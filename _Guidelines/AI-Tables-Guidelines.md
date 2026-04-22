# Database Schema — Column Type Selection Guide
 
**Purpose:** When creating new tables or columns in the database schema, use this guide to choose the correct SQL type, length, and precision.
 
**General rules:**
- Use `char(N)` for ASCII, system-controlled, fixed-width codes (status flags, type discriminators, screen IDs).
- Use `nvarchar(N)` for user-entered values, natural keys, descriptions, and anything that may contain non-ASCII characters.
- Use `nvarchar(max)` only for truly unbounded free text (notes, XML payloads, error bodies).
- Never invent new widths when a convention exists below. Match the table exactly.
---

## Table 1 — System Columns

| Column purpose | Type | Length  | Notes |
| ID | uniqueidentifier | | Not a string type — use native `uniqueidentifier`. |
| CreatedByUserID | uniqueidentifier ||Always Uniqueidentifier with link tot he user table |
| CreatedFrom | char| 8 | Always 8. Format: 2 letters + 6 digits (e.g. `AR301000`). Never use `nvarchar`. ||
| CreatedAtDateTime | datetime || Always datetime with UTC timezone.|
| UpdatedByUserID | uniqueidentifier || Always Uniqueidentifier with link tot he user table|
| UpdatedFrom | char | 8| Always 8. Format: 2 letters + 6 digits (e.g. `AR301000`). Never use `nvarchar`. ||
| UpdatedAtDateTime | datetime || Always datetime with UTC timezone. |
| Version | rowversion || Record version for Optimistic blocking |
| JSON | nvarchar | MAX | Storage for custom columns |
| Deleted | bit | MAX | If record is deleted|

---

## Table 2 — String Columns: Type and Length Selection
 
| Column purpose / naming pattern | Type | Length | Example columns | Notes |
|---|---|---|---|---|
| User-facing natural key / code (suffix `…CD`) | `nvarchar` | `15` | `InventoryCD`, `CustomerCD`, `AccountCD`, `VendorCD` | Segmented business key. Default for all `…CD` columns. |
| Internal short lookup ID (suffix `…ID`, non-surrogate, non-screen) | `nvarchar` | `15` | `TaxZoneID`, `DiscountID`, `DiscountSequenceID` | Use for lightweight lookup entities. |
| Document number (suffix `…Nbr`, `RefNbr`, `OrderNbr`, `PONbr`, `APRefNbr`) | `nvarchar` | `20` | `RefNbr`, `OrderNbr`, `PONbr`, `APRefNbr`, `ARRefNbr` | **Default for all document numbers.** Match existing patterns exactly. |
| Document number — external / third-party reference | `nvarchar` | `40` | External invoice refs, partner system numbers | For imported or externally-generated numbers. |
| Fixed-width type discriminator (suffix `…Type`) — 2-letter | `char` | `2` | `OrderType`, `POType`, `POReceiptType`, `EntityType` | Most common `…Type` width. |
| Fixed-width type discriminator (suffix `…Type`) — 3-letter | `char` | `3` | `APDocType`, `ARDocType` | Used for document type codes. |
| Status flag | `char` | `1` | `Status`, `DocStatus` | Single-letter codes (`H`, `O`, `C`, `V`). Use `char(2)` only if a two-letter status vocabulary is required. |
| Description | `nvarchar` | `256` | `Description`, `TranDesc`, `Summary` | Use the name `Description` for 256-char descriptions. The name difference is meaningful. |
| Comment / memo / reason field | `nvarchar` | `256` | `Comment`, `Memo`, `Reason`, `Message` | Use 256 for all new columns. Do not use 250/255 (legacy drift). |
| Entity name (person, company, object) | `nvarchar` | `256` | `Name`, `CompanyName`, `ContactName` | |
| Email address | `nvarchar` | `256` | `Email`, `EmailAddress` | |
| URL / website | `nvarchar` | `256` | `URL`, `Website`, `WebSite` | |
| Phone / fax number | `varchar` | `50` | `Phone`, `Fax`, `Mobile` | **`varchar`, not `nvarchar`.** Phone numbers are ASCII-only by policy. |
| Phone country-code prefix | `varchar` | `3` | `PhoneCountryCode` | ASCII dial prefix. |
| Address line (street, line 1/2/3) | `nvarchar` | `70` | `AddressLine1`, `AddressLine2`, `AddressLine3` | Specific width — do not use 50 or 100. |
| City | `nvarchar` | `50` | `City` | |
| State / Province / Region (free-text) | `nvarchar` | `50` | `State`, `Province` | |
| Country code (ISO 3166-1 alpha-2) | `nvarchar` | `2` | `CountryID` | |
| Postal / ZIP code | `varchar` | `20` | `PostalCode`, `ZipCode` | **`varchar`, not `nvarchar`.** ASCII-only. |
| Currency code (ISO 4217 + custom) | `nvarchar` | `5` | `CuryID`, `BaseCuryID` | Always 5, never 3. |
| Fiscal period | `char` | `6` | `FinPeriodID`, `PeriodID` | Format: `YYYYPP`. Always `char(6)`. |
| Unit of measure | `nvarchar` | `6` | `UOM`, `TaxUOM`, `BaseUOM` | Always 6. No exceptions in modern code. |
 
---
 
## Table 3 — Decimal Columns: Precision and Scale Selection
 
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

