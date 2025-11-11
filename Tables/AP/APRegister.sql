----------------------------------------------------------------
-- APRegister
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[APRegister];
CREATE TABLE [dbo].[APRegister]
(
	[RecordID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),

	--Classification
	[DocType] [char](3) NOT NULL,
	[RefNbr] [nvarchar](15) NOT NULL,
	[Desciption] [nvarchar](512) NULL,

	--Status
	[Status] [char](1) NOT NULL,
	[OpenDoc] [bit] NOT NULL,
	[Released] [bit] NOT NULL,

	--Date
	[DocDate] [smalldatetime] NOT NULL,
	[OrigDocDate] [smalldatetime] NULL,
	[ClosedDate] [smalldatetime] NULL,
	[FinPeriodID] [char](6) NOT NULL,

	--Currency
	[CurrencyID] [nvarchar](5) NOT NULL,
	[BaseCurrencyID] [nvarchar](5) NULL,
	[CurrencyRateID] [uniqueidentifier] NOT NULL,
  	[TaxCalcMode] [char](1) NOT NULL DEFAULT 'T',

	--Flags
	[IsPaymentsByLinesAllowed] [bit] NOT NULL DEFAULT (0),
	[IsMigratedRecord] [bit] NOT NULL DEFAULT (0),
	[IsExpectedPPVValid] [bit] NOT NULL DEFAULT (0),
  	[IsRetainageAllowed] [bit] NOT NULL DEFAULT (0),

	--References
	[BranchID] [uniqueidentifier] NOT NULL,
	[LedgerID] [uniqueidentifier] NULL,
	[VendorID] [uniqueidentifier] NOT NULL,
	[VendorLocationID] [uniqueidentifier] NOT NULL,
	[EmployeeID] [uniqueidentifier] NULL,
	[ProjectID] [uniqueidentifier] NULL,

	[BatchNbr] [uniqueidentifier] NULL,
	[VoidBatchNbr] [nvarchar](15) NULL,
	[OrigModule] [char](2) NOT NULL,
	[OrigDocType] [char](3) NULL,
	[OrigRefNbr] [nvarchar](15) NULL,

	--Accounting
	[APAccountID] [uniqueidentifier] NOT NULL,
	[APSubID] [uniqueidentifier] NOT NULL,
	[RetainageAcctID] [uniqueidentifier] NULL,
	[RetainageSubID] [uniqueidentifier] NULL,

	--Totals
	[OrigDocAmount] [decimal](28, 8) NOT NULL,
  	[OrigDocAmountCury] [decimal](28, 8) NOT NULL,
	[DocBalance] [decimal](28, 8) NOT NULL,
  	[DocBalanceCury] [decimal](28, 8) NOT NULL,
	[ImportDocBalance] [decimal](28, 8) NOT NULL DEFAULT (0.0),
  	[ImportDocBalanceCury] [decimal](28, 8) NOT NULL DEFAULT (0.0),
	[DiscountTotal] [decimal](28, 8) NULL,
 	[DiscountTotalCury] [decimal](28, 8) NULL,
	[DiscountBalance] [decimal](28, 8) NOT NULL,
  	[DiscountBalanceCury] [decimal](28, 8) NOT NULL,
	[DiscountTaken] [decimal](28, 8) NOT NULL,
  	[DiscountTakenCury] [decimal](28, 8) NOT NULL,
  	[ChargeAmount] [decimal](28, 8) NOT NULL DEFAULT (0),
  	[ChargeAmountCury] [decimal](28, 8) NOT NULL DEFAULT (0),

	[RoundDiff] [decimal](28, 8) NOT NULL,
  	[RoundDiffCury] [decimal](28, 8) NOT NULL,
	[TaxRoundDiff] [decimal](28, 8) NOT NULL,
  	[TaxRoundDiffCury] [decimal](28, 8) NOT NULL,

	[OrigWitholdingTaxAmt] [decimal](28, 8) NOT NULL,
  	[OrigWitholdingTaxAmtCury] [decimal](28, 8) NOT NULL,
	[WitholdingTaxBal] [decimal](28, 8) NOT NULL,
  	[WitholdingTaxBalCury] [decimal](28, 8) NOT NULL,
	[TaxWithheld] [decimal](28, 8) NOT NULL,
  	[TaxWithheldCury] [decimal](28, 8) NOT NULL,

	[RGOLAmount] [decimal](28, 8) NOT NULL,

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

	CONSTRAINT [APRegister_PK] PRIMARY KEY CLUSTERED
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
CREATE NONCLUSTERED INDEX [APRegister_Vendor] ON [dbo].[APRegister] ([VendorID], [VendorLocationID])
GO
CREATE NONCLUSTERED INDEX [APRegister_Branch] ON [dbo].[APRegister] ([BranchID], [LedgerID])
GO
CREATE NONCLUSTERED INDEX [APRegister_Period] ON [dbo].[APRegister] ([FinPeriodID], [TranPeriodID])
GO
CREATE NONCLUSTERED INDEX [APRegister_Status] ON [dbo].[APRegister] ([Status], [OpenDoc])
GO

----------------------------------------------------------------
-- APRegister Foreign Keys
----------------------------------------------------------------
ALTER TABLE [dbo].[APRegister] ADD CONSTRAINT [FK_APRegister_APAccount]
    FOREIGN KEY ([APAccountID]) REFERENCES [dbo].[GLAccount]([AccountID]);
GO

ALTER TABLE [dbo].[APRegister] ADD CONSTRAINT [FK_APRegister_Ledger]
    FOREIGN KEY ([LedgerID]) REFERENCES [dbo].[GLLedger]([LedgerID]);
GO

ALTER TABLE [dbo].[APRegister] ADD CONSTRAINT [FK_APRegister_Vendor]
    FOREIGN KEY ([VendorID]) REFERENCES [dbo].[SICompany]([CompanyID]);
GO

----------------------------------------------------------------
-- APRegisterExt
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[APRegisterExt];
CREATE TABLE [dbo].[APRegisterExt]
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
CREATE NONCLUSTERED INDEX [APRegisterExt_ValueString] ON [dbo].[APRegisterExt] ([RecordID], [FieldName]) INCLUDE ([ValueString])
GO
