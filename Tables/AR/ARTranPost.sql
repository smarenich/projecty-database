----------------------------------------------------------------
-- ARTranPost
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[ARTranPost];
CREATE TABLE [dbo].[ARTranPost]
(
	[RecordID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),
	[RefNoteID] [uniqueidentifier] NOT NULL,
	[Description] [nvarchar](255) NULL,

	--General
	[Module] [char](2) NOT NULL,
	[DocType] [char](3) NOT NULL,
	[RefNumber] [nvarchar](15) NOT NULL,
	[LineNumber] [int] NOT NULL,
	[AdjNbr] [int] NULL,
	[SourceDocType] [char](3) NOT NULL,
	[SourceRefNumber] [nvarchar](15) NOT NULL,

	--Status
	[Released] [bit] NULL,
	[Modified] [bit] NULL,
	[IsMigratedRecord] [bit] NOT NULL DEFAULT (0),

	--Date
	[DocDate] [smalldatetime] NOT NULL,
	[FinPeriodID] [char](6) NOT NULL,
	[StatementDate] [smalldatetime] NULL,


	--References
	[BranchID] [uniqueidentifier] NOT NULL,
	[CustomerID] [uniqueidentifier] NOT NULL,
	[ReferenceID] [int] NOT NULL,
	[CurrencyInfoID] [uniqueidentifier] NOT NULL,
	[BatchNbr] [nvarchar](15) NULL,
	[VoidAdjNbr] [int] NULL,
	[AccountID] [uniqueidentifier] NULL,
	[SubID] [uniqueidentifier] NULL,

	--Amounts
	[Amount] [decimal](28, 8) NULL,
	[AmountCury] [decimal](28, 8) NULL,
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
