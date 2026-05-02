# ERP Platform — Universal Record Services
### How the SM and SY Tables Power Every Cross-Cutting Feature

---

## 1. The Core Idea

Every ERP entity — AP Invoice, AR Customer, Purchase Order, GL Batch — carries a `RecordID` (`uniqueidentifier`). That single key unlocks a shared layer of services that every module gets for free.

```
AP Invoice ──┐    RecordType
AR Customer──┤        |
PO Order ────┼──► RecordID ──► Tags
GL Batch ────┤              ──► Comments  
Project ─────┤              ──► Files / Attachments
Any entity ──┘              ──► Global Search Index
                            ──► Links to other records
```

Without this pattern, each module builds its own comments UI, its own file upload, its own tag system. The result is divergent behavior, duplicated code, and an inconsistent user experience. The SM/SY layer solves that once, for everyone.
















---

## 2. Why Entity Types Exist in the Database (`SYRecordType`)

**Question answered:** *Why do we need entity types in the database?*

`SYRecordType` is the registry of every entity that exists in the system.

| Column | Type | Purpose |
|---|---|---|
| `RecordType` | `nvarchar(127)` | Canonical name: `"APInvoice"`, `"ARCustomer"` |
| `KeyFields` | `nvarchar(255)` | Business key columns, e.g. `"DocType,RefNbr"` |
| `DescriptionFields` | `nvarchar(255)` | Business key columns, e.g. `"DocType,RefNbr"` |
| `Module` | `char(2)` | Module code: `AP`, `AR`, `GL`, `PO`… |
| `DisplayNameSingular` | `nvarchar(255)` | UI label: `"Invoice"` |
| `DisplayNamePlural` | `nvarchar(255)` | UI label: `"Invoices"` |
| `IsSearchable` | `bit` | Opt in to global search indexing |
| `IsAuditable` | `bit` | Opt in to the comments/audit stream |
| `IsTaggable` | `bit` | Opt in to user tagging |
| `IsAttachable` | `bit` | Opt in to file attachments |

### Why this matters

- **Zero hardcoding** — the platform asks `SYRecordType` whether a record supports tagging, rather than checking a constant in code.
- **`KeyFields`** — lets the platform resolve a business key (`DocType + RefNbr`) without any module-specific knowledge.









---

## 3. What Metadata We Store About a Record and Why (`SYRecordMetadata`)

**Question answered:** *What metadata do we store about the record and why?*

`SYRecordMetadata` is a denormalized identity row that follows every record. It exists alongside the source table, not instead of it.

| Column | Type | Why it exists |
|---|---|---|
| `RecordID` | `uniqueidentifier` | Shared identity key linking all SY services |
| `RecordType` | `char(1)` | `P` = Parent/header, `D` = Detail/line |
| `EntityType` | `varchar(255)` | Classifier: `"APInvoice"`, `"ARCustomer"` |
| `RecordDisplay` | `nvarchar(255)` | Pre-computed label: `"AP-000123 / Vendor Corp / $4,500"` |
| `WorkgroupID` | `uniqueidentifier` | Assigned workgroup (FK) |
| `OwnerID` | `uniqueidentifier` | Responsible user (FK) |
| `CommentsFlag` | `bit` | Has comments? (no subquery needed) |
| `FilesFlag` | `bit` | Has attachments? (no subquery needed) |
| `ActivitiesFlag` | `bit` | Has activities? (no subquery needed) |
| `Category` | `int` | Grouping code for listing/filtering |
| `Content` | `nvarchar(MAX)` | All searchable text — feeds `SYRecordSearchIndex` |

### Why each piece matters

- **`RecordDisplay`** is computed once when the record is saved. Listing screens showing thousands of rows never re-join to vendor, customer, or currency tables just to build a label.
- **Existence flags** (`CommentsFlag`, `FilesFlag`) let a list screen render comment/file indicator icons on every row with zero subqueries — just read the bit.
- **`Content`** is a denormalized concatenation of everything the user would ever search for (vendor name, reference number, description, line item text). It is written by the application and read only by the search indexer.
- **`P` / `D` hierarchy** lets the platform understand that a transaction line belongs to a header document — important for ownership propagation and search relevance ranking.


















---

## 4. How We Implement Tags (`SMTag` + `SYRecordTag`)

**Question answered:** *How do we implement tags?*

Tagging is a two-table design: a master tag dictionary and a junction that assigns tags to records.

### `SMTag` — the tag dictionary

| Column | Type | Notes |
|---|---|---|
| `TagCD` | `nvarchar(10)` | Short user-facing code: `"URGENT"`, `"Q1-CLOSE"` |
| `Type` | `char(1)` | `S` = System, `U` = User, `V` = ISV/partner |
| `Scope` | `char(64)` | Module scope: `"GL,AP,SO"` — filters visible tags per module |
| `Color` | `char(6)` | Hex badge color for the UI: `"FF5733"` |
| `Description` | `nvarchar(256)` | What this tag means |

### `SYRecordTag` — the assignment junction

| Column | Type | Notes |
|---|---|---|
| `RecordID` | `uniqueidentifier` | PK part 1 — the tagged record |
| `TagID` | `uniqueidentifier` | PK part 2 — FK to `SMTag` |
| *(audit columns)* | | Who tagged it and when |
| `JSON` | `nvarchar(MAX)` | Tag-assignment-specific attributes if needed |

```
SMTag (tag master — one row per tag definition)
  TagID ──────────────────────────────────────────────┐
                                                       ▼
Any ERP Record ──► RecordID ──► SYRecordTag (junction)
  (only if SYRecordType.IsTaggable = 1)
```

### Design decisions

- **Scope filtering** — an AP user sees only tags where `Scope` contains `"AP"`. One dictionary, many filtered views.
- **Three tag types** — System tags are set by workflow automation (e.g., auto-tag overdue invoices). User tags are set manually. ISV tags allow partner products to tag records without colliding with system tags.
- **Color in the database** — the hex color drives the UI badge with no frontend constants. Tag appearance is configured by data, not code.
- **Adding a new tag** = one `INSERT` into `SMTag`. Zero schema changes, zero deployment.














---

## 5. How We Organize Global Search (`SYRecordSearchIndex`)

**Question answered:** *How do we organize global search?*

`SYRecordSearchIndex` is a pre-built, locale-aware search index. It is written on every record save and queried when users type in the global search box.

| Column | Type | Role |
|---|---|---|
| `RecordID` | `uniqueidentifier` | PK part 1 |
| `LocaleID` | `uniqueidentifier` | PK part 2 — one row per record per language |
| `RecordTypeID` | `uniqueidentifier` | FK to `SYRecordType` |
| `Content` | `nvarchar(MAX)` | **Full-text indexed** — all searchable text |
| `Title` | `nvarchar(255)` | Headline shown in search results |
| `Description` | `nvarchar(511)` | Snippet shown below the headline |
| `ModuleCode` | `char(2)` | Filter facet: show only AP results |
| `Status` | `nvarchar(20)` | Filter facet: show only Open records |
| `Date` | `datetime` | Filter facet: indexed DESC for time-range queries |
| `Amount` | `decimal(21,4)` | Filter facet: "invoices over $10,000" |
| `CurrencyID` | `char(5)` | Filter facet: "in EUR" |
| `OwnerID` | `uniqueidentifier` | Partial index — "my records" filter |

### Indexes

| Index | Columns | Purpose |
|---|---|---|
| Clustered PK | `(RecordID, LocaleID)` | Identity lookup |
| Full-text | `Content` | Keyword search |
| `IX_SearchIndex_Date` | `Date DESC` | "Recent documents" filter |
| `IX_SearchIndex_Owner` | `OwnerID` (partial) | "My records" filter |

### How data flows into the index

```
Record saved / updated
        │
        ▼
Application writes SYRecordInfo.Content
(concatenation of vendor name, ref number, description, line text…)
        │
        ▼
SYRecordSearchIndex row is upserted
(one row per locale — different Content text per language)
        │
        ▼
SQL Server full-text index updates asynchronously
        │
        ▼
User search query hits SYRecordSearchIndex only
(source tables are never touched during search)
```




















---

## 6. How We Attach Files to an Entity

**Question answered:** *How do we attach files to an entity?*

File attachment is a three-layer design separated by responsibility.

```
Layer 1 — Validation         Layer 2 — File Storage           Layer 3 — Association
─────────────────────        ──────────────────────────────   ──────────────────────
SMAllowedFileType            SMFile (header)                  SYRecordAttachment
  .pdf  ✓ Allowed              FileID                           RecordID
  .exe  ✗ Blocked   ─check─►   FileName                      +  FileID
  .jpg  ✓ Allowed              LastRevisionID ─────────────►
  .zip  ✓ Allowed                                            SMFileRevision (content)
                                                               FileID + FileRevisionID
                                                               Data  (varbinary / blob)
                                                               Size, Comment
                                                               OriginalName
                                                               BlobHandler ──► Azure / S3
```

### Layer 1 — `SMAllowedFileType`

A whitelist/blacklist of file extensions with an `Allowed bit` flag. Checked at upload time before anything is written.

### Layer 2 — `SMFile` + `SMFileRevision`

`SMFile` is the file header — just the name and a pointer to the current revision.
`SMFileRevision` is append-only: every upload of a new version adds a row; no row is ever updated or deleted. This gives a full revision history.

Key `SMFileRevision` columns:
- **`Data`** — binary file content stored in SQL (`image` type; note: this is deprecated and should be `varbinary(max)` in new tables)
- **`BlobHandler`** (`uniqueidentifier`) — when non-null, the actual bytes live in external storage (Azure Blob Storage, S3). The database stores only a reference. When null, the bytes are in `Data`. This allows a hybrid: small files inline, large files external.

### Layer 3 — `SYRecordAttachment`

A simple junction: `RecordID + FileID`. The same file can be attached to multiple records. An invoice scan attached to both the AP Invoice and its originating PO references one `FileID`, not two copies.

**Controlled by** `SYRecordType.IsAttachable = 1`. Reflected in `SYRecordInfo.FilesFlag`.


















---

## 7. How We Store Comments on Entities (`SYRecordComment`)

**Question answered:** *How do we store comments on entities?*

`SYRecordComment` holds both user-written notes and system-generated audit messages in one chronological stream per record.

| Column | Type | Notes |
|---|---|---|
| `RecordID` | `uniqueidentifier` | Which entity |
| `Type` | `char(1)` | `U` = user comment, `S` = system-generated |
| `Comment` | `nvarchar(MAX)` | Full comment text — supports rich content |
| `RefActivityID` | `uniqueidentifier` | FK to the workflow event that triggered a system comment |
| *(audit columns)* | | Who wrote it and when; soft-delete; rowversion |

### Two types in one stream

| Type | Created by | Example |
|---|---|---|
| `U` — User | A person, manually | *"Vendor confirmed payment by phone on Apr 20."* |
| `S` — System | Workflow / automation | *"Status changed from Open → Approved by J. Smith at 14:35."* |

### Design decisions

- **One stream, not two tables** — user notes and system messages are interleaved chronologically. The UI renders a single activity feed. No separate "audit log" panel vs. "notes" panel.
- **`RefActivityID`** traces a system comment back to the specific workflow step that triggered it. Auditors can click through from the comment to the approval step, the approver, and the timestamp.
- **`CommentsFlag` on `SYRecordInfo`** means a list screen can render a speech-bubble icon on every row that has comments — with no subquery, just reading a bit column.
- **Controlled by** `SYRecordType.IsAuditable = 1`.


















---

## 8. How We Link Entities to Each Other (`SYRecordReference`)

**Question answered:** *How do we link entities between each other?*

`SYRecordReference` is the entire table:

| Column | Type | Notes |
|---|---|---|
| `SourceRecordID` | `uniqueidentifier` | PK part 1 — the originating record |
| `DestRecordID` | `uniqueidentifier` | PK part 2 — the target record |

Two non-clustered indexes: one on `SourceRecordID`, one on `DestRecordID`. Both directions are equally fast.

### What links look like

| What you're expressing | SourceRecordID | DestRecordID |
|---|---|---|
| This AP Invoice was created from this PO | APInvoice | PurchaseOrder |
| This Payment closes this Invoice | ARPayment | ARInvoice |
| This Project owns this Task | Project | ProjectTask |
| This Invoice went through this Approval | APInvoice | ApprovalRequest |
| This Contract supersedes this old Contract | NewContract | OldContract |

### Why this design instead of typed FKs

The alternative is a separate junction table per relationship type:

```
APInvoiceToPurchaseOrder (APInvoiceID, PurchaseOrderID)
ARPaymentToARInvoice     (PaymentID,   InvoiceID)
ProjectToTask            (ProjectID,   TaskID)
... one new table per new relationship type
```

Problems with that approach:
- Schema change required for every new relationship type
- Cannot support user-defined or partner-defined links
- No single place to ask "what is linked to record X?"

With `SYRecordReference`, adding a new relationship type between any two entities requires only application logic — the database never changes. The traversal query is always the same:

```sql
-- Everything linked TO this invoice (in either direction)
SELECT DestRecordID   FROM SYRecordReference WHERE SourceRecordID = @InvoiceID
UNION ALL
SELECT SourceRecordID FROM SYRecordReference WHERE DestRecordID   = @InvoiceID
```
