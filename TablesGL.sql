

----------------------------------------------------------------
-- GLAccount
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[GLAccount];
CREATE TABLE [dbo].[GLAccount](
	[AccountID] [uniqueidentifier] NOT NULL,
	[AccountCD] [nvarchar](30) NOT NULL,
	[Type] [char](1) NOT NULL,
	[Active] [bit] NOT NULL,
	[Description] [nvarchar](60) NULL,
	[DirectPost] [bit] NOT NULL,
	[CurrencyID] [nvarchar](5) NULL,

	[Version] [rowversion] NULL
	PRIMARY KEY CLUSTERED
	(
		[AccountID] ASC
	)
)
GO
ALTER TABLE [dbo].[GLAccount] ADD  DEFAULT (newsequentialid()) FOR [AccountID]
GO

----------------------------------------------------------------
-- GLAccountExt
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[GLAccountExt];
CREATE TABLE [dbo].[GLAccountExt](
	[RecordID] [uniqueidentifier] NOT NULL,
	[FieldName] [varchar](30) NOT NULL,
	[ValueNumeric] [decimal](28, 8) NULL,
	[ValueDate] [datetime] NULL,
	[ValueString] [nvarchar](256) NULL,
	[ValueText] [nvarchar](max) NULL,
	PRIMARY KEY CLUSTERED
	(
		[RecordID] ASC,
		[FieldName] ASC
	)
)
GO

----------------------------------------------------------------
-- GLLedger
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[GLLedger];
CREATE TABLE [dbo].[GLLedger](
	[LedgerID] [uniqueidentifier] NOT NULL,
	[LedgerCD] [nvarchar](30) NOT NULL,
	[Type] [char](1) NOT NULL,
	[Description] [nvarchar](60) NULL,
	[BaseCurrencyID] [nvarchar](5) NULL,

	[Version] [rowversion] NULL
	PRIMARY KEY CLUSTERED
	(
		[LedgerID] ASC
	)
)
GO
ALTER TABLE [dbo].[GLLedger] ADD  DEFAULT (newsequentialid()) FOR [LedgerID]
GO

----------------------------------------------------------------
-- GLTransactions
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[GLTransactions];
CREATE TABLE [dbo].[GLTransactions](
	RecordID [uniqueidentifier] NOT NULL,
	[Description] [nvarchar](255) NULL,

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
 
	-- Transaction References. 
	-- Need to have many-to-many references
	-- Replace with Guids
	DocTypeL1 [char](3) NULL,
	DocRefNbrL1 [nvarchar](15) NULL,
	DocTypeL2 [char](3) NULL,
	DocRefNbrL2 [nvarchar](15) NULL,
	ExtRefNbr [nvarchar](30) NULL,

	[Version] [rowversion] NULL,

	PRIMARY KEY CLUSTERED
	(
		[RecordID] ASC
	)
)
GO
ALTER TABLE [dbo].[GLTransactions] ADD  DEFAULT (newsequentialid()) FOR [RecordID]
GO
CREATE NONCLUSTERED INDEX [GLTransactions_PostDate] ON [dbo].[GLTransactions] ([PostDate], [BranchID], [LedgerID], [AccountID])
GO
CREATE NONCLUSTERED INDEX [GLTransactions_Budget] ON [dbo].[GLTransactions] ([BranchID],[LedgerID],[AccountID])
GO
CREATE NONCLUSTERED INDEX [GLTransactions_Axis] ON dbo.GLTransactions (BranchID, LedgerID, AccountID) INCLUDE (RecordID)
GO

----------------------------------------------------------------
-- GLTransactionsExt
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[GLTransactionsExt];
CREATE TABLE [dbo].[GLTransactionsExt](
	[RecordID] [uniqueidentifier] NOT NULL,
	[FieldName] [varchar](30) NOT NULL,
	[ValueNumeric] [decimal](28, 8) NULL,
	[ValueDate] [datetime] NULL,
	[ValueString] [nvarchar](256) NULL,
	[ValueText] [nvarchar](max) NULL,
	PRIMARY KEY CLUSTERED
	(
		[RecordID] ASC,
		[FieldName] ASC
	)
)
GO
CREATE NONCLUSTERED INDEX GLTransactionsExt_ValueString ON [dbo].[GLTransactionsExt] ([RecordID], [FieldName]) INCLUDE ([ValueString])
GO
