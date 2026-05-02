# System Preferences

This document defines the requirements for the ERP Preferences system.

---

## Requirement 1: System Preferences

### Overview
The system must provide a centralized preferences editor — similar in look and feel to VS Code Settings — with a global search across all preferences, category-based navigation, and per-company value overrides.

### Functionality
* All configurable behavior in the ERP is expressed as named preferences organized into a two-level hierarchy: **Category → Preference**.
* Each preference has a definition (name, category, data type, description, tooltip, and default value). Definitions are authored in code by the developer and synchronized into the database during the database update procedure.
* Data Type is referred to a global list of possible data types, such as selectors, strings, integers, money and so on.
* Each preference has a value stored per company. When no company-specific value exists, the system falls back to the default value from the definition. `SMPreferencesDefinition` stores default value, allowing to join `SMPreferencesValue` and use Coalesce for the company specific settings.
* A preference value can **depend on a parent company's value** via `DependOnCompanyID` — changes to the parent automatically propagate to dependents, supporting inheritance across the company hierarchy. This part will be implemented in the business logic.
* The UI operates in the context of the current company (analogous to AccessInfo in A). The programmer accesses preferences without specifying a company explicitly: `SMPreferences.Category.Property`. Company should be handled by the infrastructure.
* Changes to preference values are applied explicitly through an **Apply Settings** action in the UI, making the effect of changes intentional and auditable.

### Examples of Preferences
`BatchNumberingID`, `RequireControlTotal`, `COAOrder`, `TrialBalanceSign`, `YtdNetIncAccountID`, `RetEarnAccountID`

### SMPreferences Database Structure

[SMPreferencesDefinition](../tables/SM/SMPreferences.sql)
[SMPreferencesValue](../tables/SM/SMPreferences.sql)

**SMPreferencesDefinition** — one row per preference; holds metadata and the default value. Populated and updated by the database update procedure.

**SMPreferencesValue** — one row per preference per company; holds the company-specific override. `DependOnCompanyID` links to a parent company whose value is inherited automatically.

---
