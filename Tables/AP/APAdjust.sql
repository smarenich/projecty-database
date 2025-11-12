----------------------------------------------------------------
-- APAdjust
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[APAdjust];
CREATE TABLE [dbo].[APAdjust]
(
	[RecordID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),

	--Adjusting Document (Payment/Credit)
	[AdjgDocType] [char](3) NOT NULL,
	[AdjgRefNbr] [nvarchar](15) NOT NULL,
	[AdjgDocDate] [smalldatetime] NOT NULL,
	[AdjgBranchID] [uniqueidentifier] NOT NULL,
	[AdjgFinPeriodID] [char](6) NOT NULL,
	[AdjgCurrencyRateID] [uniqueidentifier] NOT NULL,

	--Adjusted Document (Invoice/Debit Memo)
	[AdjdDocType] [char](3) NOT NULL,
	[AdjdRefNbr] [nvarchar](15) NOT NULL,
	[AdjdLineNbr] [int] NOT NULL DEFAULT (0),
	[AdjdDocDate] [smalldatetime] NOT NULL,
	[AdjdBranchID] [uniqueidentifier] NOT NULL,
	[AdjdFinPeriodID] [char](6) NOT NULL,
	[AdjdTranPeriodID] [char](6) NOT NULL,
	[AdjdCurrencyRateID] [uniqueidentifier] NOT NULL,

	--Frags
	[Released] [bit] NOT NULL,
	[Voided] [bit] NOT NULL,
  	[IsMigratedRecord] [bit] NOT NULL DEFAULT (0),

	--References
	[VendorID] [uniqueidentifier] NOT NULL,
	[CashAccountID] [uniqueidentifier] NULL,
	[PaymentMethodID] [nvarchar](10) NULL,
	[AdjBatchNbr] [nvarchar](15) NULL,

	--Accounting (Adjusted Document)
	[AdjdAPAccountID] [uniqueidentifier] NOT NULL,
	[AdjdAPSubID] [uniqueidentifier] NOT NULL,
	[AdjdWhTaxAccountID] [uniqueidentifier] NULL,
	[AdjdWhTaxSubID] [uniqueidentifier] NULL,

	--Adjusting Amount
	[AdjustingAmount] [decimal](28, 8) NULL,
  	[AdjustingAmountCury] [decimal](28, 8) NULL,
	[AdjustingDiscountAmount] [decimal](28, 8) NULL,
  	[AdjustingDiscountAmountCury] [decimal](28, 8) NULL,
	[AdjustingPPDAmount] [decimal](28, 8) NULL,
	[AdjustingPPDAmountCury] [decimal](28, 8) NULL,
	[AdjustingWhTaxAmount] [decimal](28, 8) NOT NULL,
	[AdjustingWhTaxAmountCury] [decimal](28, 8) NOT NULL,

	--Adjusted Amounts
	[AdjustedAmount] [decimal](28, 8) NULL,
  	[AdjustedAmountCury] [decimal](28, 8) NULL,
	[AdjustedDiscountAmount] [decimal](28, 8) NULL,
  	[AdjustedDiscountAmountCury] [decimal](28, 8) NULL,
	[AdjustedPPDAmount] [decimal](28, 8) NULL,
  	[AdjustedPPDAmountCury] [decimal](28, 8) NULL,
	[AdjustedWhTaxAmount] [decimal](28, 8) NOT NULL,
	[AdjustedWhTaxAmountCury] [decimal](28, 8) NOT NULL,

	[RGOLAmount] [decimal](28, 8) NULL,

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

	CONSTRAINT [APAdjust_PK] PRIMARY KEY CLUSTERED
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
CREATE NONCLUSTERED INDEX [APAdjust_AdjustingDoc] ON [dbo].[APAdjust] ([AdjgDocType], [AdjgRefNbr])
GO
CREATE NONCLUSTERED INDEX [APAdjust_AdjustedDoc] ON [dbo].[APAdjust] ([AdjdDocType], [AdjdRefNbr], [AdjdLineNbr])
GO
CREATE NONCLUSTERED INDEX [APAdjust_Vendor] ON [dbo].[APAdjust] ([VendorID])
GO
CREATE NONCLUSTERED INDEX [APAdjust_AdjgBranch] ON [dbo].[APAdjust] ([AdjgBranchID])
GO
CREATE NONCLUSTERED INDEX [APAdjust_AdjdBranch] ON [dbo].[APAdjust] ([AdjdBranchID])
GO
CREATE NONCLUSTERED INDEX [APAdjust_AdjgPeriod] ON [dbo].[APAdjust] ([AdjgFinPeriodID], [AdjgTranPeriodID])
GO
CREATE NONCLUSTERED INDEX [APAdjust_AdjdPeriod] ON [dbo].[APAdjust] ([AdjdFinPeriodID], [AdjdTranPeriodID])
GO
CREATE NONCLUSTERED INDEX [APAdjust_Status] ON [dbo].[APAdjust] ([Released], [Voided])
GO

----------------------------------------------------------------
-- APAdjustExt
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[APAdjustExt];
CREATE TABLE [dbo].[APAdjustExt]
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
CREATE NONCLUSTERED INDEX [APAdjustExt_ValueString] ON [dbo].[APAdjustExt] ([RecordID], [FieldName]) INCLUDE ([ValueString])
GO
