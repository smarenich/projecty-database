----------------------------------------------------------------
-- ARTranPost
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[ARTranPost];
CREATE TABLE [dbo].[ARTranPost]
(
	[RecordID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),

	--Classification
	[DocType] [char](3) NOT NULL,
	[RefNbr] [nvarchar](15) NOT NULL,
	[LineNbr] [int] NOT NULL,
	[AdjNbr] [int] NULL,

	--Source Document
	[SourceDocType] [char](3) NOT NULL,
	[SourceRefNbr] [nvarchar](15) NOT NULL,

	--References
	[RefNoteID] [uniqueidentifier] NOT NULL,
	[BranchID] [uniqueidentifier] NOT NULL,
	[CustomerID] [uniqueidentifier] NOT NULL,
	[ReferenceID] [int] NOT NULL,

	--Date
	[DocDate] [smalldatetime] NOT NULL,
	[FinPeriodID] [char](6) NOT NULL,
	[TranPeriodID] [char](6) NOT NULL,
	[StatementDate] [smalldatetime] NULL,

	--Currency
	[CurrencyInfoID] [uniqueidentifier] NOT NULL,

	--Document Links
	[BatchNbr] [nvarchar](15) NULL,
	[VoidAdjNbr] [int] NULL,

	--Accounting
	[AccountID] [uniqueidentifier] NULL,
	[SubID] [uniqueidentifier] NULL,

	--Amounts
	[Amount] [decimal](28, 8) NULL,
	[AmountCury] [decimal](28, 8) NULL,
	[PPDAmount] [decimal](28, 8) NULL,
	[PPDAmountCury] [decimal](28, 8) NULL,
	[DiscountAmount] [decimal](28, 8) NULL,
	[DiscountAmountCury] [decimal](28, 8) NULL,
	[RetainageAmount] [decimal](28, 8) NULL,
	[RetainageAmountCury] [decimal](28, 8) NULL,
	[WriteOffAmount] [decimal](28, 8) NOT NULL,
	[WriteOffAmountCury] [decimal](28, 8) NOT NULL,
	[ItemDiscAmount] [decimal](28, 8) NOT NULL,
	[ItemDiscAmountCury] [decimal](28, 8) NOT NULL,
	[RGOLAmount] [decimal](28, 8) NULL,

	--Classification
	[Type] [char](1) NOT NULL,
	[TranType] [char](3) NOT NULL,
	[TranRefNbr] [nvarchar](15) NULL,
	[TranClass] [char](4) NOT NULL,
	[BalanceSign] [smallint] NOT NULL,
	[GLSign] [smallint] NOT NULL,

	--Flags
	[IsMigratedRecord] [bit] NOT NULL DEFAULT (0),

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

	CONSTRAINT [ARTranPost_PK] PRIMARY KEY CLUSTERED
	(
		[RecordID] ASC
	),
	UNIQUE NONCLUSTERED
	(
		[DocType] ASC,
		[RefNbr] ASC,
		[LineNbr] ASC,
		[RecordID] ASC
	)
)
GO
CREATE NONCLUSTERED INDEX [ARTranPost_Document] ON [dbo].[ARTranPost] ([DocType], [RefNbr])
GO
CREATE NONCLUSTERED INDEX [ARTranPost_SourceDoc] ON [dbo].[ARTranPost] ([SourceDocType], [SourceRefNbr])
GO
CREATE NONCLUSTERED INDEX [ARTranPost_History] ON [dbo].[ARTranPost] ([CustomerID], [FinPeriodID], [BranchID], [AccountID], [SubID])
GO
CREATE NONCLUSTERED INDEX [ARTranPost_TranType] ON [dbo].[ARTranPost] ([ReferenceID], [TranType], [TranRefNbr])
GO

----------------------------------------------------------------
-- ARTranPostExt
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[ARTranPostExt];
CREATE TABLE [dbo].[ARTranPostExt]
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
CREATE NONCLUSTERED INDEX [ARTranPostExt_ValueString] ON [dbo].[ARTranPostExt] ([RecordID], [FieldName]) INCLUDE ([ValueString])
GO
