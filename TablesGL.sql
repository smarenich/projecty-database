

----------------------------------------------------------------
-- GLAccount
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[GLAccount];
CREATE TABLE [dbo].[GLAccount](
	[TenantID] [int] NOT NULL,
	[AccountID] [uniqueidentifier] NOT NULL,
	[AccountCD] [nvarchar](30) NOT NULL,
	[Type] [char](1) NOT NULL,
	[Active] [bit] NOT NULL,
	[Description] [nvarchar](60) NULL,
	[DirectPost] [bit] NOT NULL,
	[CurrencyID] [nvarchar](5) NULL,

	[tstamp] [rowversion] NULL
PRIMARY KEY CLUSTERED
(
	[TenantID] ASC,
	[AccountID] ASC
))
GO
ALTER TABLE [dbo].[GLAccount] ADD  DEFAULT (newsequentialid()) FOR [AccountID]
GO

----------------------------------------------------------------
-- GLAccountExt
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[GLAccountExt];
CREATE TABLE [dbo].[GLAccountExt](
	[TenantID] [int] NOT NULL,
	[RecordID] [uniqueidentifier] NOT NULL,
	[FieldName] [varchar](30) NOT NULL,
	[ValueNumeric] [decimal](28, 8) NULL,
	[ValueDate] [datetime] NULL,
	[ValueString] [nvarchar](256) NULL,
	[ValueText] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[TenantID] ASC,
	[RecordID] ASC,
	[FieldName] ASC
))
GO

----------------------------------------------------------------
-- GLLedger
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[GLLedger];
CREATE TABLE [dbo].[GLLedger](
	[TenantID] [int] NOT NULL,
	[LedgerID] [uniqueidentifier] NOT NULL,
	[LedgerCD] [nvarchar](30) NOT NULL,
	[Type] [char](1) NOT NULL,
	[Description] [nvarchar](60) NULL,
	[BaseCurrencyID] [nvarchar](5) NULL,

	[tstamp] [rowversion] NULL
PRIMARY KEY CLUSTERED
(
	[TenantID] ASC,
	[LedgerID] ASC
))
GO
ALTER TABLE [dbo].[GLLedger] ADD  DEFAULT (newsequentialid()) FOR [LedgerID]
GO

----------------------------------------------------------------
-- GLTransactions
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[GLTransactions];
CREATE TABLE [dbo].[GLTransactions](
	TenantID [int] NOT NULL,
	RecordID [uniqueidentifier] NOT NULL,

	--References
	Module [char](2) NOT NULL,
	RefNumber [nvarchar](15) NOT NULL,
	LineNumber [int] NOT NULL,

	--Status
	Released [bit],
	Modified [bit],

	--Date
	TranDate [smalldatetime] not null,
	PostDate [smalldatetime] not null,

	--Transaction
	[BranchID] [uniqueidentifier] NOT NULL,
	[LedgerID] [uniqueidentifier] NOT NULL,
	[AccountID] [uniqueidentifier] NOT NULL,
	CurrencyID [nvarchar](5) NOT NULL,
	BaseCurrencyID [nvarchar](5) NULL,
	CurrencyRateID [uniqueidentifier] NOT NULL,
	DrCr [char](1) NOT NULL,
	BaseAmt [decimal] (28, 8),
	CurrencyAmt [decimal](28, 8),
	ConsoAmt [decimal] (28, 8),
	Quantity [decimal] (28, 8),

	--References
	CompanyID [uniqueidentifier]  NULL,
	JobID [uniqueidentifier]  NULL,
	EmployeeID [uniqueidentifier] NULL,
	InventoryID [uniqueidentifier] NULL,
	CostID [uniqueidentifier] NULL,
	AssetID [uniqueidentifier] NULL,
	ScheduleID [uniqueidentifier] NULL,
 
	--Transaction References. 
	-- Need to have many-to-many references
	-- Replace with Guids
	DocTypeL1 [char](3) NULL,
	DocRefNbrL1 [nvarchar](15) NULL,
	DocTypeL2 [char](3) NULL,
	DocRefNbrL2 [nvarchar](15) NULL,
	ExtRefNbr [nvarchar](30) NULL,

	[tstamp] [rowversion] NULL,
	--
	[Description] [nvarchar](255) NULL

PRIMARY KEY CLUSTERED
(
	[TenantID] ASC,
	[RecordID] ASC
))
GO
ALTER TABLE [dbo].[GLTransactions] ADD  DEFAULT (newsequentialid()) FOR [RecordID]
GO
CREATE NONCLUSTERED INDEX [GLTransactions_PostDate] ON [dbo].[GLTransactions] ([TenantID], [PostDate], [BranchID], [LedgerID], [AccountID])
GO
CREATE NONCLUSTERED INDEX [GLTransactions_Budget] ON [dbo].[GLTransactions] ([TenantID],[BranchID],[LedgerID],[AccountID])
GO
CREATE NONCLUSTERED INDEX [GLTransactions_Axis] ON dbo.GLTransactions (TenantID, BranchID, LedgerID, AccountID) INCLUDE (RecordID)
GO

----------------------------------------------------------------
-- GLTransactionsExt
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[GLTransactionsExt];
CREATE TABLE [dbo].[GLTransactionsExt](
	[TenantID] [int] NOT NULL,
	[RecordID] [uniqueidentifier] NOT NULL,
	[FieldName] [varchar](30) NOT NULL,
	[ValueNumeric] [decimal](28, 8) NULL,
	[ValueDate] [datetime] NULL,
	[ValueString] [nvarchar](256) NULL,
	[ValueText] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[TenantID] ASC,
	[RecordID] ASC,
	[FieldName] ASC
))
GO
CREATE NONCLUSTERED INDEX GLTransactionsExt_ValueString ON [dbo].[GLTransactionsExt] ([TenantID], [RecordID], [FieldName]) INCLUDE ([ValueString])
GO
