----------------------------------------------------------------
-- ARTran
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[ARTran];
CREATE TABLE [dbo].[ARTran]
( 
	[RecordID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),

	--Classification
	[DocType] [char](3) NOT NULL,
	[RefNbr] [nvarchar](15) NOT NULL,
	[LineNbr] [int] NOT NULL,
	[SortOrder] [int] NULL,

	--General
	[LineType] [char](2) NULL,
	[TranClass] [char](1) NOT NULL,
	[TranDescription] [nvarchar](256) NULL,
	[TranDate] [smalldatetime] NOT NULL,
	[DocDate] [smalldatetime] NULL,
	[FinPeriodID] [char](6) NOT NULL,
	[ExternalRef] [nvarchar](100) NULL,

	--Flags
	[Released] [bit] NOT NULL,


	--References
	[BranchID] [uniqueidentifier] NOT NULL,
	[CustomerID] [uniqueidentifier] NOT NULL,
	[SalesPersonID] [uniqueidentifier] NULL,
	[EmployeeID] [uniqueidentifier] NULL,
	[ProjectID] [uniqueidentifier] NULL,
	[TaskID] [uniqueidentifier] NULL,
	[CostCodeID] [uniqueidentifier] NULL,
	[CaseCD] [nvarchar](15) NULL,

	--Accounting
	[AccountID] [uniqueidentifier] NOT NULL,
	[DrCr] [char](1) NOT NULL,

	--Inventory & Item
	[InventoryID] [uniqueidentifier] NULL,
	[SiteID] [uniqueidentifier] NULL,
	[UOM] [nvarchar](6) NULL,
	[Qty] [decimal](25, 6) NULL,
	[BaseQty] [decimal](25, 6) NULL,

	--Amounts
	[UnitPrice] [decimal](28, 8) NOT NULL DEFAULT (0),
	[UnitPriceCury] [decimal](28, 8) NOT NULL DEFAULT (0),
	[ExtPrice] [decimal](28, 8) NULL,
	[ExtPriceCury] [decimal](28, 8) NULL,
	[LineAmount] [decimal](28, 8) NULL,
	[LineAmountCury] [decimal](28, 8) NULL,
	[TranAmount] [decimal](28, 8) NULL,
	[TranAmountCury] [decimal](28, 8) NULL,
	[TranBalance] [decimal](28, 8) NOT NULL DEFAULT (0),
	[TranBalanceCury] [decimal](28, 8) NOT NULL DEFAULT (0),

	--Discount
	[CashDiscBalance] [decimal](28, 8) NOT NULL DEFAULT (0),
	[CashDiscBalanceCury] [decimal](28, 8) NOT NULL DEFAULT (0),
	[DiscountAmount] [decimal](28, 8) NULL,
	[DiscountAmountCury] [decimal](28, 8) NULL,
	[DiscountPercent] [decimal](9, 6) NULL,

	--Tax
	[TaxableAmount] [decimal](28, 8) NULL,
	[TaxableAmountCury] [decimal](28, 8) NULL,
	[TaxAmount] [decimal](28, 8) NULL,
	[TaxAmountCury] [decimal](28, 8) NULL,
	[RetainedTaxableAmount] [decimal](28, 8) NOT NULL DEFAULT (0),
	[RetainedTaxableAmountCury] [decimal](28, 8) NOT NULL DEFAULT (0),
	[RetainedTaxAmount] [decimal](28, 8) NOT NULL DEFAULT (0),
	[RetainedTaxAmountCury] [decimal](28, 8) NOT NULL DEFAULT (0),
	[TaxCategoryID] [nvarchar](15) NULL,
	[TaxID] [nvarchar](60) NULL,
	[EntityUsageType] [char](1) NOT NULL DEFAULT ('0'),

	--Retainage
	[RetainagePct] [decimal](9, 6) NOT NULL DEFAULT (0),
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

	CONSTRAINT [ARTran_PK] PRIMARY KEY CLUSTERED
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
CREATE NONCLUSTERED INDEX [ARTran_Document] ON [dbo].[ARTran] ([DocType], [RefNbr])
GO
CREATE NONCLUSTERED INDEX [ARTran_Branch] ON [dbo].[ARTran] ([BranchID])
GO
CREATE NONCLUSTERED INDEX [ARTran_Customer] ON [dbo].[ARTran] ([CustomerID])
GO
CREATE NONCLUSTERED INDEX [ARTran_Account] ON [dbo].[ARTran] ([AccountID], [SubID])
GO
CREATE NONCLUSTERED INDEX [ARTran_Period] ON [dbo].[ARTran] ([FinPeriodID], [TranPeriodID])
GO
CREATE NONCLUSTERED INDEX [ARTran_Project] ON [dbo].[ARTran] ([ProjectID], [TaskID])
GO
CREATE NONCLUSTERED INDEX [ARTran_Inventory] ON [dbo].[ARTran] ([InventoryID], [SiteID])
GO
CREATE NONCLUSTERED INDEX [ARTran_SOOrder] ON [dbo].[ARTran] ([SOOrderType], [SOOrderNbr], [SOOrderLineNbr])
GO

----------------------------------------------------------------
-- ARTran Foreign Keys
----------------------------------------------------------------
ALTER TABLE [dbo].[ARTran] ADD CONSTRAINT [FK_ARTran_Account]
    FOREIGN KEY ([AccountID]) REFERENCES [dbo].[GLAccount]([AccountID]);
GO

ALTER TABLE [dbo].[ARTran] ADD CONSTRAINT [FK_ARTran_Customer]
    FOREIGN KEY ([CustomerID]) REFERENCES [dbo].[SICompany]([CompanyID]);
GO

ALTER TABLE [dbo].[ARTran] ADD CONSTRAINT [FK_ARTran_Inventory]
    FOREIGN KEY ([InventoryID]) REFERENCES [dbo].[INItem]([ItemID]);
GO

----------------------------------------------------------------
-- ARTranExt
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[ARTranExt];
CREATE TABLE [dbo].[ARTranExt]
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
CREATE NONCLUSTERED INDEX [ARTranExt_ValueString] ON [dbo].[ARTranExt] ([RecordID], [FieldName]) INCLUDE ([ValueString])
GO
