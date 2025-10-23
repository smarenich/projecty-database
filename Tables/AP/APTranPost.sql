----------------------------------------------------------------
-- APTranPost
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[APTranPost];
CREATE TABLE [dbo].[APTranPost]
(
	[RecordID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),
	[RefNoteID] [uniqueidentifier] NOT NULL,
	[Description] [nvarchar](255) NULL,

	--References
	[Module] [char](2) NOT NULL,
	[DocType] [char](3) NOT NULL,
	[RefNumber] [nvarchar](15) NOT NULL,
	[LineNumber] [int] NOT NULL,
	[SourceDocType] [char](3) NOT NULL,
	[SourceRefNumber] [nvarchar](15) NOT NULL,

	--Status
	[Released] [bit] NULL,
	[Modified] [bit] NULL,
	[IsMigratedRecord] [bit] NOT NULL DEFAULT (0),

	--Date
	[DocDate] [smalldatetime] NOT NULL,
	[TranDate] [smalldatetime] NOT NULL,
	[PostDate] [smalldatetime] NOT NULL,
	[FinPeriodID] [char](6) NOT NULL,
	[TranPeriodID] [char](6) NOT NULL,

	--Transaction
	[CompanyID] [uniqueidentifier] NOT NULL,
	[BranchID] [uniqueidentifier] NOT NULL,
	[LedgerID] [uniqueidentifier] NOT NULL,
	[AccountID] [uniqueidentifier] NULL,
	[SubID] [uniqueidentifier] NULL,
	[BatchNumber] [nvarchar](15) NULL,
	[CurrencyID] [nvarchar](5) NOT NULL,
	[BaseCurrencyID] [nvarchar](5) NULL,
	[CurrencyRateID] [uniqueidentifier] NOT NULL,

	--Amounts
	[DrCr] [char](1) NOT NULL,
	[BaseAmt] [decimal](28, 8) NULL,
	[CurrencyAmt] [decimal](28, 8) NULL,
	[CuryPPDAmt] [decimal](28, 8) NULL,
	[CuryDiscAmt] [decimal](28, 8) NULL,
	[CuryRetainageAmt] [decimal](28, 8) NULL,
	[CuryWhTaxAmt] [decimal](28, 8) NOT NULL,
	[PPDAmt] [decimal](28, 8) NULL,
	[DiscAmt] [decimal](28, 8) NULL,
	[RetainageAmt] [decimal](28, 8) NULL,
	[WhTaxAmt] [decimal](28, 8) NOT NULL,
	[RGOLAmt] [decimal](28, 8) NULL,

	--Classification
	[Type] [char](1) NOT NULL,
	[TranType] [char](3) NULL,
	[TranRefNumber] [nvarchar](15) NULL,
	[TranClass] [char](4) NOT NULL,
	[BalanceSign] [smallint] NOT NULL,
	[GLSign] [smallint] NOT NULL,

	[Version] [rowversion] NULL,

	CONSTRAINT [APTranPost_PK] PRIMARY KEY CLUSTERED
	(
		[RecordID] ASC
	)
)
GO
CREATE NONCLUSTERED INDEX [APTranPost_Document] ON [dbo].[APTranPost] ([CompanyID], [DocType], [RefNumber], [LineNumber])
GO
CREATE NONCLUSTERED INDEX [APTranPost_History] ON [dbo].[APTranPost] ([CompanyID], [VendorID], [FinPeriodID], [BranchID], [AccountID], [SubID])
GO
CREATE NONCLUSTERED INDEX [APTranPost_TranType] ON [dbo].[APTranPost] ([CompanyID], [VendorID], [TranType], [TranRefNumber])
GO
CREATE NONCLUSTERED INDEX [APTranPost_SourceDoc] ON [dbo].[APTranPost] ([CompanyID], [SourceDocType], [SourceRefNumber])
GO
CREATE NONCLUSTERED INDEX [APTranPost_PostDate] ON [dbo].[APTranPost] ([PostDate], [BranchID], [LedgerID], [AccountID])
GO