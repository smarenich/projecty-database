----------------------------------------------------------------
-- ARInvoice
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[ARInvoice];
CREATE TABLE [dbo].[ARInvoice]
(
	[RecordID] [uniqueidentifier] NOT NULL,

	--Classification
	[DocType] [char](3) NOT NULL,
	[RefNbr] [nvarchar](15) NOT NULL,

	--Invoice Details
	[InvoiceNbr] [nvarchar](40) NULL,
	[InvoiceDate] [smalldatetime] NOT NULL,

	--Dates
	[DiscDate] [smalldatetime] NULL,

	--Terms & Tax
	[TermsID] [nvarchar](10) NULL,
	[TaxZoneID] [nvarchar](10) NULL,

	--Addresses & Contacts
	[BillAddressID] [uniqueidentifier] NULL,
	[BillContactID] [uniqueidentifier] NULL,
	[ShipAddressID] [uniqueidentifier] NULL,
	[ShipContactID] [uniqueidentifier] NULL,

	--Payment
	[PMInstanceID] [int] NULL,
	[PaymentMethodID] [nvarchar](10) NULL,
	[CashAccountID] [uniqueidentifier] NULL,
	[ProcessingCenterID] [nvarchar](10) NULL,

	--Totals
	[LineTotal] [decimal](28, 8) NOT NULL,
	[LineTotalCury] [decimal](28, 8) NOT NULL,
	[TaxTotal] [decimal](28, 8) NOT NULL,
	[TaxTotalCury] [decimal](28, 8) NOT NULL,
	[DiscountTotal] [decimal](28, 8) NOT NULL DEFAULT (0),
	[DiscountTotalCury] [decimal](28, 8) NOT NULL DEFAULT (0),
	[LineDiscTotal] [decimal](28, 8) NOT NULL DEFAULT (0),
	[LineDiscTotalCury] [decimal](28, 8) NOT NULL DEFAULT (0),

	--Payment Tracking
	[PaymentTotal] [decimal](28, 8) NOT NULL DEFAULT (0),
	[PaymentTotalCury] [decimal](28, 8) NOT NULL DEFAULT (0),
	[UnpaidBalance] [decimal](28, 8) NOT NULL DEFAULT (0),
	[UnpaidBalanceCury] [decimal](28, 8) NOT NULL DEFAULT (0),
	[DiscountAppliedAmount] [decimal](28, 8) NOT NULL DEFAULT (0),
	[DiscountAppliedAmountCury] [decimal](28, 8) NOT NULL DEFAULT (0),

	CONSTRAINT [ARInvoice_PK] PRIMARY KEY CLUSTERED
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
CREATE NONCLUSTERED INDEX [ARInvoice_InvoiceDate] ON [dbo].[ARInvoice] ([InvoiceDate])
GO
CREATE NONCLUSTERED INDEX [ARInvoice_Project] ON [dbo].[ARInvoice] ([ProjectID])
GO

----------------------------------------------------------------
-- ARInvoiceExt
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[ARInvoiceExt];
CREATE TABLE [dbo].[ARInvoiceExt]
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
CREATE NONCLUSTERED INDEX [ARInvoiceExt_ValueString] ON [dbo].[ARInvoiceExt] ([RecordID], [FieldName]) INCLUDE ([ValueString])
GO
