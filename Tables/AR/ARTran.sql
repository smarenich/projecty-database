----------------------------------------------------------------
-- ARTran
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[ARTran];
CREATE TABLE [dbo].[ARTran]
(
	[RecordID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),

	--Classification
	[TranType] [char](3) NOT NULL,
	[RefNbr] [nvarchar](15) NOT NULL,
	[LineNbr] [int] NOT NULL,
	[SortOrder] [int] NULL,
	[LineType] [char](2) NULL,
	[TranClass] [char](1) NOT NULL,

	--Description
	[TranDesc] [nvarchar](256) NULL,
	[Comment] [nvarchar](255) NULL,

	--Status
	[Released] [bit] NOT NULL,
	[IsCancellation] [bit] NOT NULL DEFAULT (0),
	[Canceled] [bit] NOT NULL DEFAULT (0),

	--Date
	[TranDate] [smalldatetime] NOT NULL,
	[Date] [smalldatetime] NULL,
	[OrigInvoiceDate] [smalldatetime] NULL,
	[ExpenseDate] [smalldatetime] NULL,
	[FinPeriodID] [char](6) NOT NULL,
	[TranPeriodID] [char](6) NOT NULL,

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
	[SubID] [uniqueidentifier] NOT NULL,
	[DrCr] [char](1) NOT NULL,
	[ExpenseAccrualAccountID] [uniqueidentifier] NULL,
	[ExpenseAccrualSubID] [uniqueidentifier] NULL,
	[ExpenseAccountID] [uniqueidentifier] NULL,
	[ExpenseSubID] [uniqueidentifier] NULL,
	[AccrueCost] [bit] NOT NULL DEFAULT (0),
	[CostBasis] [char](1) NULL,

	--Currency
	[CurrencyRateID] [uniqueidentifier] NOT NULL,

	--Amounts
	[TranAmount] [decimal](28, 8) NULL,
	[TranAmountCury] [decimal](28, 8) NULL,
	[OrigTranAmount] [decimal](28, 8) NOT NULL DEFAULT (0),
	[OrigTranAmountCury] [decimal](28, 8) NOT NULL DEFAULT (0),
	[TranBalance] [decimal](28, 8) NOT NULL DEFAULT (0),
	[TranBalanceCury] [decimal](28, 8) NOT NULL DEFAULT (0),

	--Discount
	[CashDiscBalance] [decimal](28, 8) NOT NULL DEFAULT (0),
	[CashDiscBalanceCury] [decimal](28, 8) NOT NULL DEFAULT (0),
	[DiscountAmount] [decimal](28, 8) NULL,
	[DiscountAmountCury] [decimal](28, 8) NULL,
	[DiscountPercent] [decimal](9, 6) NULL,
	[DiscountID] [nvarchar](10) NULL,
	[DiscountSequenceID] [nvarchar](10) NULL,
	[DiscountsAppliedToLine] [varbinary](max) NULL,
	[OrigLineNbr] [int] NULL,
	[OrigGroupDiscountRate] [decimal](21, 18) NOT NULL DEFAULT (1),
	[OrigDocumentDiscountRate] [decimal](21, 18) NOT NULL DEFAULT (1),
	[GroupDiscountRate] [decimal](21, 18) NULL,
	[DocumentDiscountRate] [decimal](21, 18) NOT NULL,
	[AutomaticDiscountsDisabled] [bit] NOT NULL DEFAULT (0),
	[DisableAutomaticTaxCalculation] [bit] NOT NULL DEFAULT (0),
	[SkipLineDiscounts] [bit] NOT NULL DEFAULT (0),
	[ManualDisc] [bit] NULL DEFAULT (0),

	--Tax
	[TaxableAmount] [decimal](28, 8) NULL,
	[TaxableAmountCury] [decimal](28, 8) NULL,
	[TaxAmount] [decimal](28, 8) NULL,
	[TaxAmountCury] [decimal](28, 8) NULL,
	[OrigTaxableAmount] [decimal](28, 8) NOT NULL DEFAULT (0),
	[OrigTaxableAmountCury] [decimal](28, 8) NOT NULL DEFAULT (0),
	[OrigTaxAmount] [decimal](28, 8) NOT NULL DEFAULT (0),
	[OrigTaxAmountCury] [decimal](28, 8) NOT NULL DEFAULT (0),
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
	[PrepaymentPct] [decimal](9, 6) NOT NULL DEFAULT (0),
	[PrepaymentAmount] [decimal](28, 8) NOT NULL DEFAULT (0),
	[PrepaymentAmountCury] [decimal](28, 8) NOT NULL DEFAULT (0),

	--Inventory & Item
	[InventoryID] [uniqueidentifier] NULL,
	[SubItemID] [uniqueidentifier] NULL,
	[SiteID] [uniqueidentifier] NULL,
	[LocationID] [uniqueidentifier] NULL,
	[UOM] [nvarchar](6) NULL,
	[Qty] [decimal](25, 6) NULL,
	[BaseQty] [decimal](25, 6) NULL,
	[IsStockItem] [bit] NULL,
	[InvtMult] [smallint] NOT NULL DEFAULT (0),
	[LotSerialNbr] [nvarchar](100) NULL,
	[ExpireDate] [datetime2](0) NULL,
	[PlanID] [bigint] NULL,
	[InvtDocType] [char](1) NULL,
	[InvtRefNbr] [nvarchar](15) NULL,
	[InvtReleased] [bit] NOT NULL DEFAULT (0),
	[ReasonCode] [nvarchar](20) NULL,

	--Pricing
	[ExtPrice] [decimal](28, 8) NULL,
	[ExtPriceCury] [decimal](28, 8) NULL,
	[LineAmount] [decimal](28, 8) NULL,
	[LineAmountCury] [decimal](28, 8) NULL,
	[UnitPrice] [decimal](28, 8) NOT NULL DEFAULT (0),
	[UnitPriceCury] [decimal](28, 8) NOT NULL DEFAULT (0),
	[ManualPrice] [bit] NULL DEFAULT (0),

	--Costing
	[TranCost] [decimal](28, 8) NOT NULL DEFAULT (0),
	[TranCostOrig] [decimal](28, 8) NOT NULL DEFAULT (0),
	[IsTranCostFinal] [bit] NOT NULL DEFAULT (0),
	[AccruedCost] [decimal](28, 8) NOT NULL DEFAULT (0),
	[AccruedCostCury] [decimal](28, 8) NOT NULL DEFAULT (0),

	--Commission
	[Commissionable] [bit] NOT NULL DEFAULT (1),
	[CommissionPercent] [decimal](9, 6) NOT NULL DEFAULT (0),
	[CommissionAmount] [decimal](28, 8) NOT NULL DEFAULT (0),
	[CommissionAmountCury] [decimal](28, 8) NOT NULL DEFAULT (0),

	--Sales Order
	[SOOrderType] [char](2) NULL,
	[SOOrderNbr] [nvarchar](15) NULL,
	[SOOrderLineNbr] [int] NULL,
	[SOOrderLineOperation] [char](1) NULL,
	[SOOrderSortOrder] [int] NULL,
	[SOOrderLineSign] [smallint] NULL,
	[SOShipmentType] [char](1) NULL,
	[SOShipmentNbr] [nvarchar](15) NULL,
	[SOShipmentLineGroupNbr] [int] NULL,
	[SOShipmentLineNbr] [int] NULL,
	[AssociatedOrderLineNbr] [int] NULL,
	[SubstitutionRequired] [bit] NOT NULL DEFAULT (0),
	[GiftMessage] [nvarchar](200) NULL,

	--Blanket Order
	[BlanketType] [char](2) NULL,
	[BlanketNbr] [nvarchar](15) NULL,
	[BlanketLineNbr] [int] NULL,
	[BlanketSplitLineNbr] [int] NULL,

	--Original Invoice
	[OrigInvoiceType] [char](3) NULL,
	[OrigInvoiceNbr] [nvarchar](15) NULL,
	[OrigInvoiceLineNbr] [int] NULL,
	[OrigDocType] [char](3) NULL,
	[OrigRefNbr] [nvarchar](15) NULL,

	--Deferral
	[DeferredCode] [nvarchar](10) NULL,
	[ScheduleID] [nvarchar](15) NULL,
	[DefScheduleID] [int] NULL,
	[DRTermStartDate] [smalldatetime] NULL,
	[DRTermEndDate] [smalldatetime] NULL,
	[UnitPriceDR] [decimal](28, 8) NULL,
	[DiscountPercentDR] [decimal](9, 6) NULL,
	[PMDeltaOption] [char](1) NOT NULL DEFAULT ('C'),

	--Service Order
	[SrvOrdType] [char](4) NULL,
	[ServiceOrderRefNbr] [nvarchar](15) NULL,
	[ServiceOrderLineNbr] [int] NULL,
	[AppointmentRefNbr] [nvarchar](20) NULL,
	[AppointmentLineNbr] [int] NULL,
	[ServiceContractRefNbr] [nvarchar](15) NULL,
	[ServiceContractPeriodID] [int] NULL,

	--Equipment
	[EquipmentAction] [char](2) NULL,
	[SMEquipmentID] [int] NULL,
	[NewEquipmentLineNbr] [int] NULL,
	[ComponentID] [int] NULL,
	[EquipmentComponentLineNbr] [int] NULL,
	[ReplaceSMEquipmentID] [int] NULL,

	--External
	[ExternalRef] [nvarchar](100) NULL,

	--Notes
	[NoteID] [uniqueidentifier] NOT NULL,

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
		[TranType] ASC,
		[RefNbr] ASC,
		[LineNbr] ASC
	)
)
GO
CREATE NONCLUSTERED INDEX [ARTran_Document] ON [dbo].[ARTran] ([TranType], [RefNbr])
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
