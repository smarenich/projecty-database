----------------------------------------------------------------
-- GLRegister
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[GLRegister];
CREATE TABLE [dbo].[GLRegister]
(
	[RecordID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),
	
	--Classification
	[Module] [char](2) NOT NULL, --Module
	[RefNumber] [nvarchar](15) NOT NULL, -- Autonumbering
  
  	[TranType] [char](1) NOT NULL, --Normal="H"; Consol="C"; TrialBalance="T"; Reclassification="R"; Allocation="A";
    [Description] [nvarchar](256) NULL,

	--Status
	[Status] [char](1) NOT NULL,
	[Draft] [bit] NOT NULL DEFAULT (0),
	[Released] [bit] NOT NULL DEFAULT (0),
	[Posted] [bit] NOT NULL DEFAULT (0),
	[Voided] [bit] NOT NULL DEFAULT (0),

	--Settings
	[AutoReverse] [bit] /*JSON*/ NULL,
	[AutoReversingEntry] [bit] /*JSON*/ NULL,

	--Date
    [TranDate] [smalldatetime] NOT NULL,
	[PostDate] [smalldatetime] NOT NULL,
	[PeriodID] [char](6) NOT NULL,

	--References
	[CompanyID] [uniqueidentifier] NOT NULL,
	[LedgerID] [uniqueidentifier] NOT NULL,

	--Currency
	[CurrencyID] [nvarchar](5) NOT NULL,
	[CurrencyRateTypeID] [nvarchar](6) /*JSON*/ NULL,
	[EffDate] [smalldatetime] /*JSON*/ NULL,
	[MultiplyDivide] [char](1) /*JSON*/ NULL,
	[Rate] [decimal](19, 8) /*JSON*/ NULL,

    --Document
	[OrigRecordID] [uniqueidentifier]  NULL,
	[SourceRecordID] [uniqueidentifier]  NULL,
	[ExternalReferenceNumber] [nvarchar](30) NULL,

	--Totals
	[CuryCreditTotal] [decimal](21, 4) NULL,
	[CreditTotal] [decimal](21, 4) NULL,
	[CuryDebitTotal] [decimal](21, 4) NULL,
	[DebitTotal] [decimal](21, 4) NULL,

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
-- GLBatchExt
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
CREATE NONCLUSTERED INDEX GLBatchExt_ValueString ON [dbo].[GLBatchExt] ([RecordID], [FieldName]) INCLUDE ([ValueString])
GO
