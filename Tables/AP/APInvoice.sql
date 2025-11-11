----------------------------------------------------------------
-- APInvoice
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[APInvoice];
CREATE TABLE [dbo].[APInvoice]
(
	[RecordID] [uniqueidentifier] NOT NULL,

	--Classification
	[DocType] [char](3) NOT NULL,
	[RefNbr] [nvarchar](15) NOT NULL,

	--References
	[InvoiceNbr] [nvarchar](40) NULL,
	[InvoiceDate] [smalldatetime] NOT NULL,
	[MasterRefNbr] [nvarchar](15) NULL,
	[InstallmentNbr] [smallint] NULL,

	--Dates
	[DueDate] [smalldatetime] NULL,
	[DiscDate] [smalldatetime] NULL,

	--Payment
	[PayDate] [smalldatetime] NULL,
	[PayAccountID] [uniqueidentifier] NULL,
	[PayTypeID] [nvarchar](10) NULL,
	[PayLocationID] [uniqueidentifier] NULL,
	[SeparateCheck] [bit] NOT NULL,

	--Terms & Tax
	[TermsID] [nvarchar](10) NULL,
	[TaxZoneID] [nvarchar](10) NULL,
	[IsTaxDocument] [bit] NULL,
	[ExternalTaxExemptionNumber] [nvarchar](30) NULL,


	--Totals
	[LineTotal] [decimal](28, 8) NOT NULL,
  [LineTotalCury] [decimal](28, 8) NOT NULL,
	[TaxTotal] [decimal](28, 8) NOT NULL,
  [TaxTotalCury] [decimal](28, 8) NOT NULL,
	[TaxAmount] [decimal](28, 8) NOT NULL DEFAULT (0),
  [TaxAmountCury] [decimal](28, 8) NOT NULL DEFAULT (0),
	[LineDiscountTotal] [decimal](28, 8) NOT NULL DEFAULT (0),
	[LineDiscountTotalCury] [decimal](28, 8) NOT NULL DEFAULT (0),

	CONSTRAINT [APInvoice_PK] PRIMARY KEY CLUSTERED
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
CREATE NONCLUSTERED INDEX [APInvoice_Vendor] ON [dbo].[APInvoice] ([SuppliedByVendorID], [SuppliedByVendorLocationID])
GO
CREATE NONCLUSTERED INDEX [APInvoice_InvoiceDate] ON [dbo].[APInvoice] ([InvoiceDate])
GO
CREATE NONCLUSTERED INDEX [APInvoice_DueDate] ON [dbo].[APInvoice] ([DueDate])
GO

----------------------------------------------------------------
-- APInvoiceExt
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[APInvoiceExt];
CREATE TABLE [dbo].[APInvoiceExt]
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
CREATE NONCLUSTERED INDEX [APInvoiceExt_ValueString] ON [dbo].[APInvoiceExt] ([RecordID], [FieldName]) INCLUDE ([ValueString])
GO
