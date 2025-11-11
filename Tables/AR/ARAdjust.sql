----------------------------------------------------------------
-- ARAdjust
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[ARAdjust];
CREATE TABLE [dbo].[ARAdjust]
(
	[RecordID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),

	--Classification
	[AdjNbr] [int] NOT NULL,
	[AdjBatchNbr] [nvarchar](15) NULL,

	--Adjusting Document (Payment/Credit)
	[AdjgDocType] [char](3) NOT NULL,
	[AdjgRefNbr] [nvarchar](15) NOT NULL,
	[AdjgDocDate] [smalldatetime] NOT NULL,
	[AdjgBranchID] [uniqueidentifier] NOT NULL,
	[AdjgFinPeriodID] [char](6) NOT NULL,
	[AdjgTranPeriodID] [char](6) NOT NULL,
	[AdjgCurrencyInfoID] [uniqueidentifier] NOT NULL,

	--Adjusted Document (Invoice/Debit Memo)
	[AdjdDocType] [char](3) NOT NULL,
	[AdjdRefNbr] [nvarchar](15) NOT NULL,
	[AdjdLineNbr] [int] NOT NULL DEFAULT (0),
	[AdjdDocDate] [smalldatetime] NOT NULL,
	[AdjdBranchID] [uniqueidentifier] NOT NULL,
	[AdjdFinPeriodID] [char](6) NOT NULL,
	[AdjdTranPeriodID] [char](6) NOT NULL,
	[AdjdCurrencyInfoID] [uniqueidentifier] NOT NULL,
	[AdjdOrigCurrencyInfoID] [uniqueidentifier] NOT NULL,

	--Status
	[Released] [bit] NOT NULL,
	[Hold] [bit] NOT NULL DEFAULT (0),
	[Voided] [bit] NOT NULL,
	[VoidAdjNbr] [int] NULL,

	--References
	[CustomerID] [uniqueidentifier] NOT NULL,
	[AdjdCustomerID] [uniqueidentifier] NOT NULL,
	[AdjdOrderType] [char](2) NULL,
	[AdjdOrderNbr] [nvarchar](15) NULL,

	--Accounting (Adjusted Document)
	[AdjdARAccountID] [uniqueidentifier] NOT NULL,
	[AdjdARSubID] [uniqueidentifier] NOT NULL,

	--Adjusting Amounts (Base Currency)
	[AdjustingAmount] [decimal](28, 8) NULL,
	[AdjustingDiscountAmount] [decimal](28, 8) NULL,
	[AdjustingPPDAmount] [decimal](28, 8) NULL,
	[AdjustingWriteOffAmount] [decimal](28, 8) NOT NULL DEFAULT (0),

	--Adjusting Amounts (Transaction Currency)
	[AdjustingAmountCury] [decimal](28, 8) NULL,
	[AdjustingDiscountAmountCury] [decimal](28, 8) NULL,
	[AdjustingPPDAmountCury] [decimal](28, 8) NULL,
	[AdjustingWriteOffAmountCury] [decimal](28, 8) NOT NULL DEFAULT (0),

	--Adjusted Amounts (Document Currency)
	[AdjustedAmount] [decimal](28, 8) NULL,
	[AdjustedOrigAmount] [decimal](28, 8) NULL,
	[AdjustedDiscountAmount] [decimal](28, 8) NULL,
	[AdjustedPPDAmount] [decimal](28, 8) NULL,
	[AdjustedWriteOffAmount] [decimal](28, 8) NOT NULL DEFAULT (0),

	--Adjusted Amounts (Transaction Currency)
	[AdjustedAmountCury] [decimal](28, 8) NULL,
	[AdjustedOrigAmountCury] [decimal](28, 8) NULL,
	[AdjustedDiscountAmountCury] [decimal](28, 8) NULL,
	[AdjustedPPDAmountCury] [decimal](28, 8) NULL,
	[AdjustedWriteOffAmountCury] [decimal](28, 8) NOT NULL DEFAULT (0),

	--Write-Off
	[WriteOffReasonCode] [nvarchar](20) NULL,

	--RGOL (Realized Gain/Loss)
	[RGOLAmount] [decimal](28, 8) NULL,

	--PPD (Prompt Payment Discount)
	[PendingPPD] [bit] NOT NULL DEFAULT (0),
	[AdjdHasPPDTaxes] [bit] NOT NULL DEFAULT (0),
	[PPDVATAdjDocType] [char](3) NULL,
	[PPDVATAdjRefNbr] [nvarchar](15) NULL,

	--Tax
	[TaxInvoiceNbr] [nvarchar](15) NULL,

	--Dates
	[StatementDate] [smalldatetime] NULL,

	--Flags
	[IsMigratedRecord] [bit] NOT NULL DEFAULT (0),
	[IsInitialApplication] [bit] NOT NULL DEFAULT (0),
	[Recalculatable] [bit] NOT NULL DEFAULT (0),

	--Credit Card Payment
	[IsCCPayment] [bit] NOT NULL DEFAULT (0),
	[PaymentPendingProcessing] [bit] NOT NULL DEFAULT (0),
	[PaymentReleased] [bit] NOT NULL DEFAULT (0),
	[IsCCAuthorized] [bit] NOT NULL DEFAULT (0),
	[IsCCCaptured] [bit] NOT NULL DEFAULT (0),
	[PaymentCaptureFailed] [bit] NOT NULL DEFAULT (0),

	--Notes
	[NoteID] [uniqueidentifier] NOT NULL,
	[InvoiceID] [uniqueidentifier] NULL,
	[PaymentID] [uniqueidentifier] NULL,
	[MemoID] [uniqueidentifier] NULL,

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

	CONSTRAINT [ARAdjust_PK] PRIMARY KEY CLUSTERED
	(
		[RecordID] ASC
	),
	UNIQUE NONCLUSTERED
	(
		[AdjgDocType] ASC,
		[AdjgRefNbr] ASC,
		[AdjdDocType] ASC,
		[AdjdRefNbr] ASC,
		[AdjdLineNbr] ASC,
		[AdjNbr] ASC
	)
)
GO
CREATE NONCLUSTERED INDEX [ARAdjust_AdjustingDoc] ON [dbo].[ARAdjust] ([AdjgDocType], [AdjgRefNbr])
GO
CREATE NONCLUSTERED INDEX [ARAdjust_AdjustedDoc] ON [dbo].[ARAdjust] ([AdjdDocType], [AdjdRefNbr], [AdjdLineNbr])
GO
CREATE NONCLUSTERED INDEX [ARAdjust_Customer] ON [dbo].[ARAdjust] ([CustomerID])
GO
CREATE NONCLUSTERED INDEX [ARAdjust_AdjdCustomer] ON [dbo].[ARAdjust] ([AdjdCustomerID])
GO
CREATE NONCLUSTERED INDEX [ARAdjust_AdjgBranch] ON [dbo].[ARAdjust] ([AdjgBranchID])
GO
CREATE NONCLUSTERED INDEX [ARAdjust_AdjdBranch] ON [dbo].[ARAdjust] ([AdjdBranchID])
GO
CREATE NONCLUSTERED INDEX [ARAdjust_AdjgPeriod] ON [dbo].[ARAdjust] ([AdjgFinPeriodID], [AdjgTranPeriodID])
GO
CREATE NONCLUSTERED INDEX [ARAdjust_AdjdPeriod] ON [dbo].[ARAdjust] ([AdjdFinPeriodID], [AdjdTranPeriodID])
GO
CREATE NONCLUSTERED INDEX [ARAdjust_Status] ON [dbo].[ARAdjust] ([Released], [Voided])
GO

----------------------------------------------------------------
-- ARAdjustExt
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[ARAdjustExt];
CREATE TABLE [dbo].[ARAdjustExt]
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
CREATE NONCLUSTERED INDEX [ARAdjustExt_ValueString] ON [dbo].[ARAdjustExt] ([RecordID], [FieldName]) INCLUDE ([ValueString])
GO
