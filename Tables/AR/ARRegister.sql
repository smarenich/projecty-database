----------------------------------------------------------------
-- ARRegister
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[ARRegister];
CREATE TABLE [dbo].[ARRegister]
(
	[RecordID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),

	--Classification
	[DocType] [char](3) NOT NULL,
	[RefNbr] [nvarchar](15) NOT NULL,
	[Description] [nvarchar](512) NULL,
	[ExternalRef] [nvarchar](80) NULL,

	--Status
	[Status] [char](1) NOT NULL,
	[OpenDoc] [bit] NOT NULL,
	[Released] [bit] NOT NULL,

	--Date
	[DocDate] [smalldatetime] NOT NULL,
	[OrigDocDate] [smalldatetime] NULL,
	[DueDate] [smalldatetime] NULL,
	[ClosedDate] [smalldatetime] NULL,
	[StatementDate] [smalldatetime] NULL,
	[FinPeriodID] [char](6) NOT NULL,
	[ClosedFinPeriodID] [char](6) NULL,

	--Currency
	[CurrencyID] [nvarchar](5) NOT NULL,
	[BaseCurrencyID] [nvarchar](5) NULL,
	[CurrencyRateID] [uniqueidentifier] NOT NULL,
	[TaxCalcMode] [char](1) NOT NULL DEFAULT 'T',

	--Flags
	[IsMigratedRecord] [bit] NOT NULL DEFAULT (0),
  	[IsRetainage] [bit] NOT NULL DEFAULT (0),

	--Tax
	[DisableAutomaticTaxCalculation] [bit] NULL,
	[TaxCalcMode] [char](1) NOT NULL DEFAULT 'T',
	[IsTaxValid] [bit] NOT NULL DEFAULT (0),
	[IsTaxSaved] [bit] NOT NULL DEFAULT (0),
	[IsTaxPosted] [bit] NOT NULL DEFAULT (0),
	[NonTaxable] [bit] NOT NULL DEFAULT (0),

	--References
	[BranchID] [uniqueidentifier] NOT NULL,
	[CustomerID] [uniqueidentifier] NOT NULL,
	[CustomerLocationID] [uniqueidentifier] NOT NULL,
	[SalesPersonID] [uniqueidentifier] NULL,
	[ApproverID] [uniqueidentifier] NULL,
	[ApproverWorkGroupID] [uniqueidentifier] NULL,
	[ProjectID] [uniqueidentifier] NULL,

	[BatchNbr] [nvarchar](15) NULL,
	[OrigModule] [char](2) NOT NULL,
	[OrigDocType] [char](3) NULL,
	[OrigRefNbr] [nvarchar](15) NULL,

	--Accounting
	[ARAccountID] [uniqueidentifier] NOT NULL,
	[PrepaymentAccountID] [uniqueidentifier] NULL,
	[RetainageAcctID] [uniqueidentifier] NULL,


	--Totals
	[OrigDocAmount] [decimal](28, 8) NOT NULL,
	[OrigDocAmountCury] [decimal](28, 8) NOT NULL,
	[DocBalance] [decimal](28, 8) NOT NULL,
	[DocBalanceCury] [decimal](28, 8) NOT NULL,
	[ImportDocBalance] [decimal](28, 8) NOT NULL DEFAULT (0.0),
	[ImportDocBalanceCury] [decimal](28, 8) NOT NULL DEFAULT (0.0),
	[DiscountBalance] [decimal](28, 8) NOT NULL,
	[DiscountBalanceCury] [decimal](28, 8) NOT NULL,
	[DiscountTaken] [decimal](28, 8) NOT NULL,
	[DiscountTakenCury] [decimal](28, 8) NOT NULL,
	[OrigDiscAmount] [decimal](28, 8) NOT NULL,
	[OrigDiscAmountCury] [decimal](28, 8) NOT NULL,
	[ChargeAmount] [decimal](28, 8) NOT NULL DEFAULT (0),
	[ChargeAmountCury] [decimal](28, 8) NOT NULL DEFAULT (0),
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

	CONSTRAINT [ARRegister_PK] PRIMARY KEY CLUSTERED
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
CREATE NONCLUSTERED INDEX [ARRegister_Customer] ON [dbo].[ARRegister] ([CustomerID], [CustomerLocationID])
GO
CREATE NONCLUSTERED INDEX [ARRegister_Branch] ON [dbo].[ARRegister] ([BranchID])
GO
CREATE NONCLUSTERED INDEX [ARRegister_Period] ON [dbo].[ARRegister] ([FinPeriodID], [TranPeriodID])
GO
CREATE NONCLUSTERED INDEX [ARRegister_Status] ON [dbo].[ARRegister] ([Status], [OpenDoc])
GO

----------------------------------------------------------------
-- ARRegister Foreign Keys
----------------------------------------------------------------
ALTER TABLE [dbo].[ARRegister] ADD CONSTRAINT [FK_ARRegister_ARAccount]
    FOREIGN KEY ([ARAccountID]) REFERENCES [dbo].[GLAccount]([AccountID]);
GO

ALTER TABLE [dbo].[ARRegister] ADD CONSTRAINT [FK_ARRegister_Customer]
    FOREIGN KEY ([CustomerID]) REFERENCES [dbo].[SICompany]([CompanyID]);
GO

----------------------------------------------------------------
-- ARRegisterExt
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[ARRegisterExt];
CREATE TABLE [dbo].[ARRegisterExt]
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
CREATE NONCLUSTERED INDEX [ARRegisterExt_ValueString] ON [dbo].[ARRegisterExt] ([RecordID], [FieldName]) INCLUDE ([ValueString])
GO
