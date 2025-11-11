----------------------------------------------------------------
-- APPayment
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[APPayment];
CREATE TABLE [dbo].[APPayment]
(
	[RecordID] [uniqueidentifier] NOT NULL,

	--Classification
	[DocType] [char](3) NOT NULL,
	[RefNbr] [nvarchar](15) NOT NULL,

 	--Dates
	[PaymentDate] [smalldatetime] NOT NULL,
	[PaymentFinPeriodID] [char](6) NOT NULL,

	--Payment Details
	[ExtRefNbr] [nvarchar](40) NULL,
	[PaymentMethodID] [nvarchar](10) NULL,
	[CashAccountID] [uniqueidentifier] NULL,

	--Flags
	[PrintCheck] [bit] NOT NULL DEFAULT (0),
	[Cleared] [bit] NOT NULL,
	[ClearDate] [smalldatetime] NULL,

	--Remittance
	[RemitAddressID] [uniqueidentifier] NOT NULL,
	[RemitContactID] [uniqueidentifier] NOT NULL,

	--Totals (Base Currency)
	[OrigTaxDiscountAmt] [decimal](28, 8) NOT NULL DEFAULT (0),
	[OrigTaxDiscountAmtCury] [decimal](28, 8) NOT NULL DEFAULT (0),


	CONSTRAINT [APPayment_PK] PRIMARY KEY CLUSTERED
	(
		[RecordID] ASC
	),
	UNIQUE NONCLUSTERED
	(
		[DocType] ASC,
		[RefNbr] ASC
	)
)
GO
CREATE NONCLUSTERED INDEX [APPayment_CashAccount] ON [dbo].[APPayment] ([CashAccountID], [CashSubID])
GO
CREATE NONCLUSTERED INDEX [APPayment_AdjDate] ON [dbo].[APPayment] ([AdjDate])
GO
CREATE NONCLUSTERED INDEX [APPayment_Period] ON [dbo].[APPayment] ([AdjFinPeriodID], [AdjTranPeriodID])
GO
CREATE NONCLUSTERED INDEX [APPayment_Deposit] ON [dbo].[APPayment] ([DepositNbr], [Deposited])
GO

----------------------------------------------------------------
-- APPaymentExt
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[APPaymentExt];
CREATE TABLE [dbo].[APPaymentExt]
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
CREATE NONCLUSTERED INDEX [APPaymentExt_ValueString] ON [dbo].[APPaymentExt] ([RecordID], [FieldName]) INCLUDE ([ValueString])
GO
