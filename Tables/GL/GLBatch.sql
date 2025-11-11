----------------------------------------------------------------
-- GLBatch
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[GLBatch];
CREATE TABLE [dbo].[GLBatch]
(
	[RecordID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),
	
	--Classification
	[Module] [char](2) NOT NULL, --Module
	[RefNumber] [nvarchar](15) NOT NULL, -- Autonumbering
  
	[BatchType] [varchar](3) NOT NULL,
  [Description] [nvarchar](512) NULL,

	--Status
	[Status] [char](1) NOT NULL,
	[Draft] [bit] NOT NULL DEFAULT (0),
	[Released] [bit] NULL DEFAULT (0),
	[Voided] [bit] NOT NULL DEFAULT (0),

	--Settings
	[AutoReverse] [bit] NULL,

	--Date
  [TranDate] [smalldatetime] NOT NULL,
	[PostDate] [smalldatetime] NOT NULL,
	[FinPeriodID] [char](6) NOT NULL,
	[TranPeriodID] [char](6) NOT NULL,

	--References
	[BranchID] [uniqueidentifier] NOT NULL,
	[LedgerID] [uniqueidentifier] NOT NULL,
	[CurrencyID] [nvarchar](5) NOT NULL,
	[BaseCurrencyID] [nvarchar](5) NULL,
	[CurrencyRateID] [uniqueidentifier] NULL,

  --Document
	[OrigRecordID] [uniqueidentifier]  NULL,
	[OrigModule] [char](2) NULL,
	[OrigBatchNumber] [nvarchar](15) NULL,
	[SourceRecordID] [uniqueidentifier]  NULL,
	[SourceModule] [char](2) NULL,
	[SourceBatchNumber] [nvarchar](15) NULL,

	--Totals (Base Currency)
	[CreditTotal] [decimal](28, 8) NULL,
	[DebitTotal] [decimal](28, 8) NULL,
	[ControlTotal] [decimal](28, 8) NULL,

	--Totals (Transaction Currency)
	[CreditTotalCury] [decimal](28, 8) NULL,
	[DebitTotalCury] [decimal](28, 8) NULL,
	[ControlTotalCury] [decimal](28, 8) NULL,

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

	CONSTRAINT [GLBatch_PK] PRIMARY KEY CLUSTERED
	(
		[RecordID] ASC
	),
	UNIQUE NONCLUSTERED
	(
		[Module] ASC,
		[RefNumber] ASC
	)
)
GO
CREATE NONCLUSTERED INDEX [GLBatch_Company] ON [dbo].[GLBatch] ([BranchID], [LedgerID])
GO
CREATE NONCLUSTERED INDEX [GLBatch_Period] ON [dbo].[GLBatch] ([FinPeriodID], [TranPeriodID])
GO

----------------------------------------------------------------
-- GLBatch Foreign Keys
----------------------------------------------------------------
ALTER TABLE [dbo].[GLBatch] ADD CONSTRAINT [FK_GLBatch_Ledger]
    FOREIGN KEY ([LedgerID]) REFERENCES [dbo].[GLLedger]([LedgerID]);
GO

----------------------------------------------------------------
-- GLTransactionExt
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[GLBatchExt];
CREATE TABLE [dbo].[GLBatchExt]
(
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
CREATE NONCLUSTERED INDEX GLBatchExt_ValueString ON [dbo].[GLTransactionExt] ([RecordID], [FieldName]) INCLUDE ([ValueString])
GO
