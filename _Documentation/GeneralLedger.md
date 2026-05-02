# General Ledger Requirements

This document defines the general requirements for the Accounting and General Ledger Module.

---

## Requirement 1: SICompany

### Overview
The system must provide a form to add and edit the Company (known as Branches in A) to maintain business entities.

### Functionality
* Company represents a business entity for which individual accounting shall be provided by ERP.
* Company may have a type of company or branch through the Type field. Company usually represents a registered legal entity, where Branch usually is an office or building or department without own registration. 
  * Additionally Inter-Company transactions usually require balancing entries, where Inter-Branch does not require balancing.
* Companies supports Parent/Child relationship for consolidation and setting inheritance purpose.
* Company has Address and Contact information, as well as additional information.
* Company Access control using the AccessRole. User must be granted with the role to be able to access the company.

### SICompany DataBase Structure

[Company](../tables/Company/SICompany.sql)
[Address](../tables/Company/SIAddress.sql)
[Contact](../tables/Company/SIContact.sql)

---

## Requirement 2: GL Accounts 

### Overview
The system must provide a form to add and edit GL Accounts.

### Functionality
* Accounts must be classified as Balance Sheet or Off-Balance Sheet
* Accounts can be foreign currency denominated or base currency only
* Accounts must be categorized by type: Assets, Liabilities, Income, or Expenses
* Accounts must belong to a Company, it is not possible to create an account without a company.
* Accounts, as well as some other settings cold be inherited from the Parent to the Child companies.
  * Inheritance is helping with standartisation of Chart of Account throughout the organization.
  * Through the inheritance, parent company could be used as a template for fast creation of children
  * Specific accounts could be marked as restricted using `GLCompanyAccount` table, so their visibility will be broken through the inheritance and they limited to a single company.

### GLAccount Database Structure

[GLAccount](../tables/GL/GLAccount.sql)
[GLCompanyAccount](../tables/GL/GLCompanyAccount.sql)

---


