----------------------------------------------------------------
-- APTran
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[APTran];
CREATE TABLE [dbo].[APTran]
(
	[RecordID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),

	--Classification
	[DocType] [char](3) NOT NULL,
	[RefNbr] [nvarchar](15) NOT NULL,
	[LineNbr] [int] NOT NULL,
	[SortOrder] [int] NULL,

	--General
	[LineType] [char](2) NOT NULL,
	[TranClass] [char](1) NOT NULL,
	[TranDescription] [nvarchar](256) NULL,
  	[TranDate] [smalldatetime] NOT NULL,
	[DocDate] [smalldatetime] NULL,
	[FinPeriodID] [char](6) NOT NULL,

	--Flags
	[Released] [bit] NOT NULL,

	--References
	[BranchID] [uniqueidentifier] NOT NULL,
	[VendorID] [uniqueidentifier] NOT NULL,
	[EmployeeID] [uniqueidentifier] NULL,
	[ProjectID] [uniqueidentifier] NULL,
	[TaskID] [uniqueidentifier] NULL,
	[CostCodeID] [uniqueidentifier] NULL,
	[CurrencyRateID] [uniqueidentifier] NOT NULL,

	--Accounting
	[AccountID] [uniqueidentifier] NULL,
	[DrCr] [char](1) NOT NULL,

	--Inventory & Quantity
	[ItemType] [bit] NULL,
	[ItemID] [uniqueidentifier] NULL,
	[SiteID] [uniqueidentifier] NULL,
	[UOM] [nvarchar](6) NULL,
	[Quanity] [decimal](25, 6) NULL,
	[QuanityBase] [decimal](25, 6) NULL,

	--Amounts
	[ExpenseAmount] [decimal](28, 8) NULL,
	[ExpenseAmountCury] [decimal](28, 8) NULL,
	[LineAmount] [decimal](28, 8) NULL,
	[LineAmountCury] [decimal](28, 8) NULL,
	[UnitCost] [decimal](19, 6) NULL,
	[UnitCostCury] [decimal](19, 6) NULL,
	[TranAmount] [decimal](28, 8) NULL,
	[TranAmountCury] [decimal](28, 8) NULL,
	[TranBalance] [decimal](28, 8) NOT NULL DEFAULT (0),
	[TranBalanceCury] [decimal](28, 8) NOT NULL DEFAULT (0),

	--Discount
	[DiscountAmount] [decimal](28, 8) NULL,
	[DiscountAmountCury] [decimal](28, 8) NULL,
	[CashDiscBalance] [decimal](28, 8) NOT NULL DEFAULT (0),
	[CashDiscBalanceCury] [decimal](28, 8) NOT NULL DEFAULT (0),

	--Tax
	[TaxCalcMode] [char](1) NOT NULL DEFAULT 'T',
	[TaxableAmount] [decimal](28, 8) NULL,
	[TaxableAmountCury] [decimal](28, 8) NULL,
	[TaxAmount] [decimal](28, 8) NULL,
	[TaxAmountCury] [decimal](28, 8) NULL,
	[RetainedTaxableAmount] [decimal](28, 8) NOT NULL DEFAULT (0),
	[RetainedTaxableAmountCury] [decimal](28, 8) NOT NULL DEFAULT (0),
	[RetainedTaxAmount] [decimal](28, 8) NOT NULL DEFAULT (0),
	[RetainedTaxAmountCury] [decimal](28, 8) NOT NULL DEFAULT (0),
	[TaxCategoryID] [nvarchar](15) NULL,

	--Retainage
	[RetainageAmount] [decimal](28, 8) NOT NULL DEFAULT (0),
	[RetainageAmountCury] [decimal](28, 8) NOT NULL DEFAULT (0),
	[OrigRetainageAmount] [decimal](28, 8) NOT NULL DEFAULT (0),
	[OrigRetainageAmountCury] [decimal](28, 8) NOT NULL DEFAULT (0),
	[RetainageBalance] [decimal](28, 8) NOT NULL DEFAULT (0),
	[RetainageBalanceCury] [decimal](28, 8) NOT NULL DEFAULT (0),

	--Prepayment
	[PrepaymentAmount] [decimal](28, 8) NOT NULL DEFAULT (0),
	[PrepaymentAmountCury] [decimal](28, 8) NOT NULL DEFAULT (0),

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

	CONSTRAINT [APTran_PK] PRIMARY KEY CLUSTERED
	(
		[RecordID] ASC
	),
	UNIQUE NONCLUSTERED
	(
		[DocType] ASC,
		[RefNbr] ASC,
		[LineNbr] ASC
	)
)
GO
CREATE NONCLUSTERED INDEX [APTran_Document] ON [dbo].[APTran] ([DocType], [RefNbr])
GO
CREATE NONCLUSTERED INDEX [APTran_Branch] ON [dbo].[APTran] ([BranchID])
GO
CREATE NONCLUSTERED INDEX [APTran_Vendor] ON [dbo].[APTran] ([VendorID])
GO
CREATE NONCLUSTERED INDEX [APTran_Account] ON [dbo].[APTran] ([AccountID], [SubID])
GO
CREATE NONCLUSTERED INDEX [APTran_Period] ON [dbo].[APTran] ([FinPeriodID], [TranPeriodID])
GO
CREATE NONCLUSTERED INDEX [APTran_Project] ON [dbo].[APTran] ([ProjectID], [TaskID])
GO
CREATE NONCLUSTERED INDEX [APTran_Inventory] ON [dbo].[APTran] ([InventoryID], [SiteID])
GO

----------------------------------------------------------------
-- APTran Foreign Keys
----------------------------------------------------------------
ALTER TABLE [dbo].[APTran] ADD CONSTRAINT [FK_APTran_Account]
    FOREIGN KEY ([AccountID]) REFERENCES [dbo].[GLAccount]([AccountID]);
GO

ALTER TABLE [dbo].[APTran] ADD CONSTRAINT [FK_APTran_Vendor]
    FOREIGN KEY ([VendorID]) REFERENCES [dbo].[SICompany]([CompanyID]);
GO

ALTER TABLE [dbo].[APTran] ADD CONSTRAINT [FK_APTran_Item]
    FOREIGN KEY ([ItemID]) REFERENCES [dbo].[INItem]([ItemID]);
GO

----------------------------------------------------------------
-- APTranExt
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[APTranExt];
CREATE TABLE [dbo].[APTranExt]
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
CREATE NONCLUSTERED INDEX [APTranExt_ValueString] ON [dbo].[APTranExt] ([RecordID], [FieldName]) INCLUDE ([ValueString])
GO
