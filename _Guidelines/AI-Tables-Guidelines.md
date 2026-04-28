# Database Schema — Column Type Selection Guide
 
**Purpose:** When creating new tables or columns in the database schema, use this guide to choose the correct SQL type, length, and precision.
 
**General rules:**
- Use `char(N)` for ASCII, system-controlled, fixed-width codes (status flags, type discriminators, screen IDs).
- Use `nvarchar(N)` for user-entered values, natural keys, descriptions, and anything that may contain non-ASCII characters.
- Use `nvarchar(max)` only for truly unbounded free text (notes, XML payloads, error bodies).
- Never invent new widths when a convention exists below. Match the table exactly.

---

## Primary and Foreign Key Columns

### GUID strategy

Use `NEWSEQUENTIALID()` — never `NEWID()` — as the default for primary key columns. `NEWID()` generates random GUIDs that cause page splits and severe index fragmentation on large tables. `NEWSEQUENTIALID()` generates monotonically increasing values within a SQL Server instance, keeping the clustered index append-only.

| Key role | Declaration | Notes |
|---|---|---|
| Own primary key (`ID`, `RecordID`) | `uniqueidentifier NOT NULL DEFAULT NEWSEQUENTIALID()` | Always the clustered primary key. One per table. |
| Required foreign key (relationship is mandatory) | `uniqueidentifier NOT NULL` | No default — the application must supply the value. |
| Optional foreign key (relationship may be absent) | `uniqueidentifier NULL` | NULL means "no relationship", not "unknown". |
| Composite natural/business key (`DocType` + `RefNbr`) | Each column `NOT NULL` — declare as `PRIMARY KEY (DocType, RefNbr)` | Use when the business key is stable and short enough to be indexed efficiently. The surrogate `uniqueidentifier` PK is still required alongside it as the FK target for child tables. |

### Key naming rules

- The surrogate PK of a table is always named `ID` (preferred) or `<EntityName>ID` if `ID` would be ambiguous in joins.
- FK columns referencing another table's PK use the pattern `<ReferencedEntity>ID` (e.g., `VendorID`, `BranchID`, `CurrencyRateID`).
- Never name a FK column the same as the PK of its own table.

---

## System Columns

| Column purpose | Type | Length | Notes |
|---|---|---|---|
| ID | uniqueidentifier | | Not a string type — use native `uniqueidentifier`. |
| CreatedByUserID | uniqueidentifier | | Always `uniqueidentifier` with link to the user table. |
| CreatedFrom | char | 8 | Always 8. Format: 2 letters + 6 digits (e.g. `AR301000`). Never use `nvarchar`. |
| CreatedAtDateTime | datetime | | Always `datetime` with UTC timezone. |
| UpdatedByUserID | uniqueidentifier | | Always `uniqueidentifier` with link to the user table. |
| UpdatedFrom | char | 8 | Always 8. Format: 2 letters + 6 digits (e.g. `AR301000`). Never use `nvarchar`. |
| UpdatedAtDateTime | datetime | | Always `datetime` with UTC timezone. |
| Version | rowversion | | Record version for optimistic concurrency control. |
| JSON | nvarchar | MAX | Storage for custom columns. |
| Deleted | bit | | Soft-delete flag. `NOT NULL DEFAULT 0`. Never physically delete rows; set to `1` instead. |

---

## String Columns: Type and Length Selection
 
| Column purpose / naming pattern | Type | Length | Example columns | Notes |
|---|---|---|---|---|
| User-facing natural key / code (suffix `…CD`) | `nvarchar` | `15` | `InventoryCD`, `CustomerCD`, `AccountCD`, `VendorCD` | Segmented business key. Default for all `…CD` columns. |
| Internal short lookup ID (suffix `…ID`, non-surrogate, non-screen) | `nvarchar` | `15` | `TaxZoneID`, `DiscountID`, `DiscountSequenceID` | Use for lightweight lookup entities. |
| Document number (suffix `…Nbr`, `RefNbr`, `OrderNbr`, `PONbr`, `APRefNbr`) | `nvarchar` | `15` | `RefNbr`, `OrderNbr`, `PONbr`, `APRefNbr`, `ARRefNbr` | **Default for all document numbers.** Match existing patterns exactly. |
| Document number — external / third-party reference | `nvarchar` | `40` | External invoice refs, partner system numbers | For imported or externally-generated numbers. |
| Fixed-width type discriminator (suffix `…Type`) — 2-letter | `char` | `2` | `OrderType`, `POType`, `POReceiptType`, `EntityType` | Most common `…Type` width. |
| Fixed-width type discriminator (suffix `…Type`) — 3-letter | `char` | `3` | `APDocType`, `ARDocType` | Used for document type codes. |
| Status flag | `char` | `1` | `Status`, `DocStatus` | Single-letter codes (`H`, `O`, `C`, `V`). Use `char(2)` only if a two-letter status vocabulary is required. |
| Description | `nvarchar` | `60` or `256` | `Description`, `TranDesc`, `Summary` | Use the name `Description` for 60 or 256-char descriptions. The name difference is meaningful. |
| Comment / memo / reason field | `nvarchar` | `256` | `Comment`, `Memo`, `Reason`, `Message` | Use 256 for all new columns. Do not use 250/255 (legacy drift). |
| Entity name (person, company, object) | `nvarchar` | `256` | `Name`, `CompanyName`, `ContactName` | |
| Email address | `nvarchar` | `256` | `Email`, `EmailAddress` | |
| URL / website | `nvarchar` | `256` | `URL`, `Website`, `WebSite` | |
| Phone / fax number | `nvarchar` | `50` | `Phone`, `Fax`, `Mobile` | |
| Phone country-code prefix | `nvarchar` | `3` | `PhoneCountryCode` | ASCII dial prefix. |
| Address line (street, line 1/2/3) | `nvarchar` | `70` | `AddressLine1`, `AddressLine2`, `AddressLine3` | Specific width — do not use 50 or 100. |
| City | `nvarchar` | `50` | `City` | |
| State / Province / Region (free-text) | `nvarchar` | `50` | `State`, `Province` | |
| Country code (ISO 3166-1 alpha-2) | `nvarchar` | `2` | `CountryID` | Always 2 uppercase letters. |
| Postal / ZIP code | `nvarchar` | `20` | `PostalCode`, `ZipCode` |  |
| Currency code (ISO 4217 + custom) | `nvarchar` | `5` | `CuryID`, `BaseCuryID` | Always 5, never 3. |
| Fiscal period | `char` | `6` | `FinPeriodID`, `PeriodID` | Format: `YYYYPP`. Always `char(6)`. |
| Unit of measure | `nvarchar` | `6` | `UOM`, `TaxUOM`, `BaseUOM` | Always 6. No exceptions in modern code. |

### NOT NULL defaults for string columns

- **Business keys and document numbers** (`…CD`, non-surrogate `…ID`, `…Nbr`, `…Type`, `…Status`, `FinPeriodID`, `CuryID`, `UOM`) → `NOT NULL DEFAULT N''`. These columns are part of the entity's identity and must always have a value.
- **Descriptive fields** (`Description`, `Comment`, `Name`, `Email`, `URL`, `Phone`, `AddressLine1`, `City`, `State`, `PostalCode`) → `NOT NULL DEFAULT N''`. Empty string is always preferred over NULL for display fields.
- **Optional lookup references** (a `…CD` or `…ID` that may be blank because the relationship is optional) → `NULL`. Use NULL only when the absence of a value is semantically meaningful and must be distinguished from an empty string.
- **Never mix NULL and empty string** for the same column across rows. Pick one and enforce it with a constraint.

---

## Decimal Columns: Precision and Scale Selection
 
| Column purpose / naming pattern | Precision | Scale | Example columns | Notes |
|---|---|---|---|---|
| Monetary amount (total, balance, extended amount) — suffix `…Amt`, `…Amount`, `Balance`, `…Total` | `21` | `4` | `CuryDocBal`, `DocBal`, `TaxAmt`, `CuryTaxAmt`, `TaxableAmt`, `ExpenseAmt`, `CuryOrigDocAmt`, `OrigDocAmt` | **The universal money default.** Use for any value the user sees as a final monetary amount on a document. |
| Price or Cost (suffix `UnitPrice`, `Price`) — value per single unit | `21` | `6` | `UnitPrice`, `CuryUnitPrice`, `SalesPrice`, `CurySalesPrice` | 6 decimals prevent rounding drift when multiplied by `Qty`. |
| Quantity (suffix `Qty`, `Quantity`) — any count, including fractional units | `25` | `6` | `Qty`, `BaseQty`, `TaxableQty`, `OrderQty`, `ReceiptQty`, `OpenQty` | Always `(25,6)`, never `(19,x)`. Large precision absorbs intermediate `Qty × UnitPrice` multiplication without overflow. |
| Currency exchange rate (suffix `…CuryRate`, `CuryRate`, `ExchRate`) | `15` | `6` | `CuryRate`, `CuryMultDiv` | Default for standard exchange rates. |
| Currency exchange rate — high-precision / inverse rates | `21` | `18` | `CuryRateReciprocal`, inverse exchange rates | Use when (a) rate invertibility matters mathematically, or (b) the currency has very high denominations (VND, IDR, etc.). |
| Tax rate | `15` | `6` | `TaxRate`, `EffectiveTaxRate` | Modern standard. Do not use `(9,6)` for new columns (legacy drift). |
| Percentage (suffix `Pct`, `…Percent`) — general purpose | `15` | `6` | `DiscountPct`, `MarkupPct`, `CommissionPct` | |
| Discount rate / multiplier | `21` | `6` | `DiscountRate`, `DiscountMult` | Discount as a rate → follow the per-unit rule. |
| Weight | `19` | `4` | `Weight`, `NetWeight`, `GrossWeight` | Treated with money-grade precision. |
| Volume / size (dimensional) | `19` | `4` | `Volume`, `Size` | Same treatment as weight. |

### Currency amount pairing convention

Every monetary amount column that can be expressed in a transaction currency **must** have a paired base-currency column. The naming rule is strict:

| Role | Prefix rule | Example pair |
|---|---|---|
| Transaction-currency column (what the user entered) | `Cury` prefix | `CuryTaxAmt`, `CuryDocBal`, `CuryUnitPrice` |
| Base-currency column (converted to company base) | No prefix | `TaxAmt`, `DocBal`, `UnitPrice` |

- Always declare the `Cury…` column first, immediately followed by its base-currency twin.
- Both columns use the **same** precision and scale (e.g., both `decimal(21,4)` for amounts, both `decimal(21,6)` for prices).
- A base-currency-only column (no user-currency equivalent) is allowed only when the value is always stored in base currency by design (e.g., `RGOLAmount`).
- Never store the exchange rate inline on the row — reference `CurrencyRateID` (uniqueidentifier FK) instead.

---

## Integer Columns

| Column purpose / naming pattern | Type | Notes |
|---|---|---|
| Line / sequence number (suffix `…Nbr`, `LineNbr`, `SortOrder`) | `int NOT NULL` | Start at 1. Never use `smallint` for new columns. |
| Identity / auto-increment surrogate | `int IDENTITY(1,1) NOT NULL` | Only for internal lookup tables with no natural key. All primary entity tables use `uniqueidentifier` instead. |

---

## Bit (Boolean) Columns

| Column purpose / naming pattern | Type | Notes |
|---|---|---|
| Any true/false flag (`Is…`, `Released`, `OpenDoc`, `Active`, `Posted`) | `bit NOT NULL DEFAULT 0` | Always non-null with a default. Never use `tinyint` as a substitute. |

---

## Date and Time Columns

| Column purpose / naming pattern | Type | Notes |
|---|---|---|
| Audit / system timestamp (`CreatedAtDateTime`, `UpdatedAtDateTime`) | `datetime` | Always stored in UTC. See Table 1. |
| Document / business date (`DocDate`, `DueDate`, `ClosedDate`, `PostDate`) | `smalldatetime` | Second-level precision is unnecessary for business dates; `smalldatetime` is acceptable. Use `datetime` if time-of-day must be captured. |
| Date-only value (no time component needed) | `date` | Use only when the column must be purely a calendar date and a time part would be misleading (e.g. `BirthDate`, `EffectiveDate`). |

