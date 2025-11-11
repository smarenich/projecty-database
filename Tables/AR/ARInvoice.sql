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
	[MasterRefNbr] [nvarchar](15) NULL,
	[InstallmentNbr] [smallint] NULL,
	[InstallmentCntr] [smallint] NULL,

	--Dates
	[DiscDate] [smalldatetime] NULL,

	--Terms & Tax
	[TermsID] [nvarchar](10) NULL,
	[TaxZoneID] [nvarchar](10) NULL,
	[ExternalTaxExemptionNumber] [nvarchar](30) NULL,
	[EntityUsageType] [char](1) NOT NULL DEFAULT ('0'),

	--References
	[ProjectID] [uniqueidentifier] NULL,
	[WorkGroupID] [uniqueidentifier] NULL,
	[OwnerID] [uniqueidentifier] NULL,

	--Addresses & Contacts
	[BillAddressID] [uniqueidentifier] NULL,
	[BillContactID] [uniqueidentifier] NULL,
	[ShipAddressID] [uniqueidentifier] NULL,
	[ShipContactID] [uniqueidentifier] NULL,
	[MultiShipAddress] [bit] NOT NULL DEFAULT (0),

	--Payment
	[PMInstanceID] [int] NULL,
	[PaymentMethodID] [nvarchar](10) NULL,
	[CashAccountID] [uniqueidentifier] NULL,
	[ProcessingCenterID] [nvarchar](10) NULL,
	[PayLinkID] [int] NULL,

	--Totals
	[LineTotal] [decimal](28, 8) NOT NULL,
	[LineTotalCury] [decimal](28, 8) NOT NULL,
	[TaxTotal] [decimal](28, 8) NOT NULL,
	[TaxTotalCury] [decimal](28, 8) NOT NULL,
	[VatTaxableTotal] [decimal](28, 8) NOT NULL DEFAULT (0),
	[VatTaxableTotalCury] [decimal](28, 8) NOT NULL DEFAULT (0),
	[VatExemptTotal] [decimal](28, 8) NOT NULL DEFAULT (0),
	[VatExemptTotalCury] [decimal](28, 8) NOT NULL DEFAULT (0),

	--Discounts
	[DiscountTotal] [decimal](28, 8) NOT NULL DEFAULT (0),
	[DiscountTotalCury] [decimal](28, 8) NOT NULL DEFAULT (0),
	[LineDiscTotal] [decimal](28, 8) NOT NULL DEFAULT (0),
	[LineDiscTotalCury] [decimal](28, 8) NOT NULL DEFAULT (0),
	[GroupDiscTotal] [decimal](28, 8) NOT NULL DEFAULT (0),
	[GroupDiscTotalCury] [decimal](28, 8) NOT NULL DEFAULT (0),
	[DocumentDiscTotal] [decimal](28, 8) NOT NULL DEFAULT (0),
	[DocumentDiscTotalCury] [decimal](28, 8) NOT NULL DEFAULT (0),
	[DisableAutomaticDiscountCalculation] [bit] NOT NULL DEFAULT (0),

	--Goods
	[GoodsTotal] [decimal](28, 8) NOT NULL DEFAULT (0),
	[GoodsTotalCury] [decimal](28, 8) NOT NULL DEFAULT (0),
	[GoodsExtPriceTotal] [decimal](28, 8) NOT NULL DEFAULT (0),
	[GoodsExtPriceTotalCury] [decimal](28, 8) NOT NULL DEFAULT (0),

	--Freight
	[FreightCost] [decimal](28, 8) NOT NULL DEFAULT (0),
	[FreightCostCury] [decimal](28, 8) NOT NULL DEFAULT (0),
	[FreightAmount] [decimal](28, 8) NOT NULL DEFAULT (0),
	[FreightAmountCury] [decimal](28, 8) NOT NULL DEFAULT (0),
	[FreightTotal] [decimal](28, 8) NOT NULL DEFAULT (0),
	[FreightTotalCury] [decimal](28, 8) NOT NULL DEFAULT (0),
	[PremiumFreightAmount] [decimal](28, 8) NOT NULL DEFAULT (0),
	[PremiumFreightAmountCury] [decimal](28, 8) NOT NULL DEFAULT (0),

	--Miscellaneous
	[MiscTotal] [decimal](28, 8) NOT NULL DEFAULT (0),
	[MiscTotalCury] [decimal](28, 8) NOT NULL DEFAULT (0),
	[MiscExtPriceTotal] [decimal](28, 8) NOT NULL DEFAULT (0),
	[MiscExtPriceTotalCury] [decimal](28, 8) NOT NULL DEFAULT (0),

	--Commission
	[CommissionPercent] [decimal](9, 6) NOT NULL DEFAULT (0),
	[CommissionAmount] [decimal](28, 8) NOT NULL DEFAULT (0),
	[CommissionAmountCury] [decimal](28, 8) NOT NULL DEFAULT (0),
	[CommissionableAmount] [decimal](28, 8) NOT NULL DEFAULT (0),
	[CommissionableAmountCury] [decimal](28, 8) NOT NULL DEFAULT (0),

	--Payment Tracking
	[PaymentTotal] [decimal](28, 8) NOT NULL DEFAULT (0),
	[PaymentTotalCury] [decimal](28, 8) NOT NULL DEFAULT (0),
	[UnpaidBalance] [decimal](28, 8) NOT NULL DEFAULT (0),
	[UnpaidBalanceCury] [decimal](28, 8) NOT NULL DEFAULT (0),
	[DiscountAppliedAmount] [decimal](28, 8) NOT NULL DEFAULT (0),
	[DiscountAppliedAmountCury] [decimal](28, 8) NOT NULL DEFAULT (0),
	[BalanceWithoutTotal] [decimal](28, 8) NOT NULL DEFAULT (0),
	[BalanceWithoutTotalCury] [decimal](28, 8) NOT NULL DEFAULT (0),
	[ConsolidateChargeTotal] [decimal](28, 8) NOT NULL DEFAULT (0),
	[ConsolidateChargeTotalCury] [decimal](28, 8) NOT NULL DEFAULT (0),

	--Credit Management
	[CreditHold] [bit] NOT NULL DEFAULT (0),
	[ApprovedCredit] [bit] NOT NULL DEFAULT (0),
	[ApprovedCreditAmount] [decimal](28, 8) NOT NULL DEFAULT (0),
	[ApprovedCaptureFailed] [bit] NOT NULL DEFAULT (0),
	[ApprovedPrepaymentRequired] [bit] NOT NULL DEFAULT (0),

	--Flags
	[ProformaExists] [bit] NOT NULL DEFAULT (0),
	[Revoked] [bit] NOT NULL DEFAULT (0),
	[ApplyOverdueCharge] [bit] NOT NULL DEFAULT (1),
	[IsHiddenInIntercompanySales] [bit] NOT NULL DEFAULT (0),
	[IsPaymentsTransferred] [bit] NOT NULL DEFAULT (1),
	[DeliveryMethod] [char](1) NULL,

	--Counters
	[PendingProcessingCntr] [int] NOT NULL DEFAULT (0),
	[CaptureFailedCntr] [int] NOT NULL DEFAULT (0),
	[AuthorizedPaymentCntr] [int] NOT NULL DEFAULT (0),

	--Notes
	[RefNoteID] [uniqueidentifier] NULL,

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
