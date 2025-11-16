----------------------------------------------------------------
-- GLTransactions
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[GLTransaction];
CREATE TABLE [dbo].[GLTransaction](
	[RecordID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),

	--References
	[Module] [char](2) NOT NULL,
	[RefNumber] [nvarchar](15) NOT NULL,
	[LineNumber] [int] NOT NULL,
	
	[TranType] [varchar](3) NOT NULL,
	[Description] [nvarchar](255) NULL,

	--Status
	[Released] [bit] NOT NULL DEFAULT (0),
	[Modified] [bit] NOT NULL DEFAULT (0),

	--Date
	[TranDate] [smalldatetime] not null,
	[PostDate] [smalldatetime] not null,

	--Transaction
	[BranchID] [uniqueidentifier] NOT NULL,
	[LedgerID] [uniqueidentifier] NOT NULL,
	[AccountID] [uniqueidentifier] NOT NULL,
	[CurrencyID] [nvarchar](5) NOT NULL,
	[BaseCurrencyID] [nvarchar](5) NULL,
	[CurrencyRateID] [uniqueidentifier] NOT NULL,

	--Amounts
	[DrCr] [char](1) NOT NULL,
	[BaseAmt] [decimal] (28, 8),
	[CurrencyAmt] [decimal](28, 8),
	[ConsoAmt] [decimal] (28, 8),
	[Quantity] [decimal] (28, 8),

	--References
	[CompanyID] [uniqueidentifier]  NULL,
	[JobID] [uniqueidentifier]  NULL,
	[EmployeeID] [uniqueidentifier] NULL,
	[InventoryID] [uniqueidentifier] NULL,
	[CostID] [uniqueidentifier] NULL,
	[AssetID] [uniqueidentifier] NULL,
	[ScheduleID] [uniqueidentifier] NULL,

	--Documents
	[OrigRecordID] [uniqueidentifier]  NULL,
	[OrigModule] [char](2) NULL,
	[OrigBatchNumber] [nvarchar](15) NULL,
	[OrigLineNumber] [int] NULL,
	[SourceRecordID] [uniqueidentifier]  NULL,
	[SourceModule] [char](2) NULL,
	[SourceBatchNumber] [nvarchar](15) NULL,
	[SourceLineNumber] [int] NULL,

	--System
	[CreatedByUserID] [uniqueidentifier] NOT NULL,
	[CreatedFrom] [char](8) NOT NULL,
	[CreatedAtDateTime] [datetime] NOT NULL,
	[UpdatedByUserID] [uniqueidentifier] NOT NULL,
	[UpdatedFrom] [char](8) NOT NULL,
	[UpdatedAtDateTime] [datetime] NOT NULL,
	[Version] [rowversion] NULL,
	[JSON] [nvarchar](MAX) NULL,
	[Deleted] [bit] NOT NULL DEFAULT (0),

	PRIMARY KEY CLUSTERED
	(
		[RecordID] ASC
	),
	UNIQUE NONCLUSTERED
	(
		[Module] ASC,
		[RefNumber] ASC,
		[LineNumber] ASC

	)
)
GO
CREATE NONCLUSTERED INDEX [GLTransaction_PostDate] ON [dbo].[GLTransaction] ([PostDate], [BranchID], [LedgerID], [AccountID])
GO
CREATE NONCLUSTERED INDEX [GLTransaction_Budget] ON [dbo].[GLTransaction] ([BranchID],[LedgerID],[AccountID])
GO
CREATE NONCLUSTERED INDEX [GLTransaction_Axis] ON dbo.GLTransaction (BranchID, LedgerID, AccountID) INCLUDE (RecordID)
GO

----------------------------------------------------------------
-- GLTransaction Foreign Keys
----------------------------------------------------------------
ALTER TABLE [dbo].[GLTransaction] ADD CONSTRAINT [FK_GLTransaction_Account]
    FOREIGN KEY ([AccountID]) REFERENCES [dbo].[GLAccount]([AccountID]);
GO

ALTER TABLE [dbo].[GLTransaction] ADD CONSTRAINT [FK_GLTransaction_Ledger]
    FOREIGN KEY ([LedgerID]) REFERENCES [dbo].[GLLedger]([LedgerID]);
GO

ALTER TABLE [dbo].[GLTransaction] ADD CONSTRAINT [FK_GLTransaction_Company]
    FOREIGN KEY ([CompanyID]) REFERENCES [dbo].[SICompany]([CompanyID]);
GO

ALTER TABLE [dbo].[GLTransaction] ADD CONSTRAINT [FK_GLTransaction_Inventory]
    FOREIGN KEY ([InventoryID]) REFERENCES [dbo].[INItem]([ItemID]);
GO

----------------------------------------------------------------
-- GLTransactionExt
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[GLTransactionExt];
CREATE TABLE [dbo].[GLTransactionExt](
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