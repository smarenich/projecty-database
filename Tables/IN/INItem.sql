----------------------------------------------------------------
-- INItem (InventoryItem)
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[INItem];
CREATE TABLE [dbo].[INItem]
(
	[ItemID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),
	[ItemCD] [nvarchar](30) NOT NULL,
	[Description] [nvarchar](256) NULL,

	--Classification
	[ItemType] [char](1) NOT NULL,
	[ItemStatus] [char](2) NOT NULL,
	[ItemClassID] [uniqueidentifier] NULL,
	[PostClassID] [nvarchar](10) NULL,
	[PriceClassID] [nvarchar](10) NULL,

	--Units
	[BaseUnit] [nvarchar](6) NOT NULL,
	[SalesUnit] [nvarchar](6) NOT NULL,
	[PurchaseUnit] [nvarchar](6) NOT NULL,
	[DecimalBaseUnit] [bit] NOT NULL DEFAULT (1),
	[DecimalSalesUnit] [bit] NOT NULL DEFAULT (1),
	[DecimalPurchaseUnit] [bit] NOT NULL DEFAULT (1),

	--Pricing
	[BasePrice] [decimal](28, 8) NOT NULL,
	[RecPrice] [decimal](28, 8) NULL,
	[MarkupPct] [decimal](28, 8) NULL,
	[MinGrossProfitPct] [decimal](28, 8) NOT NULL,
	[PercentOfSalesPrice] [decimal](28, 8) NOT NULL DEFAULT (0),

	--Weight & Volume
	[WeightItem] [bit] NOT NULL DEFAULT (0),
	[BaseWeight] [decimal](28, 8) NOT NULL,
	[BaseItemWeight] [decimal](28, 8) NOT NULL,
	[WeightUOM] [nvarchar](6) NULL,
	[BaseVolume] [decimal](28, 8) NOT NULL,
	[BaseItemVolume] [decimal](28, 8) NOT NULL,
	[VolumeUOM] [nvarchar](6) NULL,

	--Packaging
	[PackageOption] [char](1) NOT NULL DEFAULT ('W'),
	[PackSeparately] [bit] NOT NULL DEFAULT (0),

	--Stock
	[StkItem] [bit] NOT NULL,
	[KitItem] [bit] NOT NULL DEFAULT (0),
	[LotSerClassID] [nvarchar](10) NULL,

	--Valuation & Costing
	[ValMethod] [char](1) NULL,
	[CostBasis] [char](1) NULL,
	[StdCost] [decimal](28, 8) NOT NULL,
	[StdCostDate] [smalldatetime] NULL,
	[LastStdCost] [decimal](28, 8) NOT NULL,
	[PendingStdCost] [decimal](28, 8) NOT NULL,
	[PendingStdCostDate] [smalldatetime] NULL,

	--Accounting
	[InvtAcctID] [uniqueidentifier] NULL,
	[InvtSubID] [uniqueidentifier] NULL,
	[COGSAcctID] [uniqueidentifier] NULL,
	[COGSSubID] [uniqueidentifier] NULL,
	[SalesAcctID] [uniqueidentifier] NULL,
	[SalesSubID] [uniqueidentifier] NULL,
	[StdCstRevAcctID] [uniqueidentifier] NULL,
	[StdCstRevSubID] [uniqueidentifier] NULL,
	[StdCstVarAcctID] [uniqueidentifier] NULL,
	[StdCstVarSubID] [uniqueidentifier] NULL,
	[PPVAcctID] [uniqueidentifier] NULL,
	[PPVSubID] [uniqueidentifier] NULL,
	[POAccrualAcctID] [uniqueidentifier] NULL,
	[POAccrualSubID] [uniqueidentifier] NULL,
	[LCVarianceAcctID] [uniqueidentifier] NULL,
	[LCVarianceSubID] [uniqueidentifier] NULL,
	[ReasonCodeSubID] [uniqueidentifier] NULL,

	--Deferral
	[DeferredCode] [nvarchar](10) NULL,
	[DefaultTerm] [decimal](9, 4) NOT NULL DEFAULT (0),
	[DefaultTermUOM] [char](1) NOT NULL DEFAULT ('Y'),
	[DeferralAcctID] [uniqueidentifier] NULL,
	[DeferralSubID] [uniqueidentifier] NULL,

	--HR/Payroll
	[EarningsAcctID] [uniqueidentifier] NULL,
	[EarningsSubID] [uniqueidentifier] NULL,
	[BenefitExpenseAcctID] [uniqueidentifier] NULL,
	[BenefitExpenseSubID] [uniqueidentifier] NULL,
	[TaxExpenseAcctID] [uniqueidentifier] NULL,
	[TaxExpenseSubID] [uniqueidentifier] NULL,
	[PTOExpenseAcctID] [uniqueidentifier] NULL,
	[PTOExpenseSubID] [uniqueidentifier] NULL,

	--Defaults
	[DfltSiteID] [uniqueidentifier] NULL,
	[DfltShipLocationID] [uniqueidentifier] NULL,
	[DfltReceiptLocationID] [uniqueidentifier] NULL,
	[LastSiteID] [uniqueidentifier] NULL,

	--Management
	[ProductWorkGroupID] [uniqueidentifier] NULL,
	[ProductManagerID] [uniqueidentifier] NULL,
	[PriceWorkGroupID] [uniqueidentifier] NULL,
	[PriceManagerID] [uniqueidentifier] NULL,

	--Vendor
	[PreferredVendorID] [uniqueidentifier] NULL,
	[PreferredVendorLocationID] [uniqueidentifier] NULL,

	--Sub Items
	[DefaultSubItemID] [uniqueidentifier] NULL,
	[DefaultSubItemOnEntry] [bit] NOT NULL,
	[IsSplitted] [bit] NOT NULL DEFAULT (0),
	[UseParentSubID] [bit] NOT NULL DEFAULT (0),

	--Cycle & ABC
	[CycleID] [nvarchar](10) NULL,
	[ABCCodeID] [char](1) NULL,
	[ABCCodeIsFixed] [bit] NOT NULL DEFAULT (0),
	[MovementClassID] [char](1) NULL,
	[MovementClassIsFixed] [bit] NOT NULL DEFAULT (0),

	--Non-Stock
	[NonStockReceipt] [bit] NOT NULL DEFAULT (1),
	[NonStockReceiptAsService] [bit] NOT NULL DEFAULT (0),
	[NonStockShip] [bit] NOT NULL DEFAULT (1),

	--Purchase Order
	[CompletePOLine] [char](1) NULL,
	[UndershipThreshold] [decimal](9, 6) NOT NULL DEFAULT (100),
	[OvershipThreshold] [decimal](9, 6) NOT NULL DEFAULT (100),

	--Tax
	[TaxCategoryID] [nvarchar](15) NULL,
	[TaxCalcMode] [char](1) NOT NULL DEFAULT 'T',

	--International
	[HSTariffCode] [nvarchar](30) NULL,
	[CommodityCodeType] [nvarchar](30) NULL DEFAULT 'HS',
	[CountryOfOrigin] [nvarchar](2) NULL,

	--Matrix/Template
	[IsTemplate] [bit] NOT NULL DEFAULT (0),
	[TemplateItemID] [uniqueidentifier] NULL,
	[DefaultRowMatrixAttributeID] [nvarchar](10) NULL,
	[DefaultColumnMatrixAttributeID] [nvarchar](10) NULL,
	[GenerationRuleCntr] [int] NOT NULL DEFAULT (0),
	[AttributeDescriptionGroupID] [uniqueidentifier] NULL,
	[ColumnAttributeValue] [nvarchar](255) NULL,
	[RowAttributeValue] [nvarchar](255) NULL,

	--E-Commerce
	[Visibility] [char](1) NULL,
	[Availability] [char](1) NULL,
	[NotAvailMode] [char](1) NULL,
	[AvailabilityAdjustment] [decimal](28, 8) NOT NULL DEFAULT (0),
	[CustomURL] [nvarchar](100) NULL,
	[PageTitle] [nvarchar](100) NULL,
	[MetaDescription] [nvarchar](1024) NULL,
	[MetaKeywords] [nvarchar](1024) NULL,
	[SearchKeywords] [nvarchar](1024) NULL,
	[ShortDescription] [nvarchar](1024) NULL,
	[ExportToExternal] [bit] NULL DEFAULT (1),
	[ImageUrl] [varchar](255) NULL,

	--Manufacturing (MFG)
	[AMBOMID] [nvarchar](15) NULL,
	[AMPlanningBOMID] [nvarchar](15) NULL,
	[AMLotSize] [decimal](28, 8) NULL,
	[AMMaxOrdQty] [decimal](28, 8) NULL,
	[AMMinOrdQty] [decimal](28, 8) NULL,
	[AMLowLevel] [int] NULL,
	[AMMrpItem] [bit] NULL,
	[AMMFGLeadTime] [int] NULL,
	[AMGroupWindow] [int] NULL,
	[AMWIPAcctID] [uniqueidentifier] NULL,
	[AMWIPSubID] [uniqueidentifier] NULL,
	[AMWIPVarianceAcctID] [uniqueidentifier] NULL,
	[AMWIPVarianceSubID] [uniqueidentifier] NULL,
	[AMConfigurationID] [nvarchar](15) NULL,
	[AMReplenishmentSourceOverride] [bit] NOT NULL DEFAULT (0),
	[ReplenishmentSource] [char](1) NOT NULL DEFAULT 'N',
	[AMSafetyStockOverride] [bit] NOT NULL DEFAULT (0),
	[AMSafetyStock] [decimal](16, 9) NULL,
	[AMMinQtyOverride] [bit] NOT NULL DEFAULT (0),
	[AMMinQty] [decimal](16, 9) NULL,
	[AMQtyRoundUp] [bit] NOT NULL DEFAULT (0),
	[AMScrapSiteID] [uniqueidentifier] NULL,
	[AMScrapLocationID] [uniqueidentifier] NULL,
	[AMMakeToOrderItem] [bit] NOT NULL DEFAULT (0),
	[AMDefaultMarkFor] [int] NOT NULL DEFAULT (0),
	[AMCheckSchdMatlAvailability] [bit] NULL,
	[AMCTPItem] [bit] NULL,
	[AMGroupWindowOverride] [bit] NOT NULL DEFAULT (0),
	[AMSourceSiteID] [uniqueidentifier] NULL,
	[IsProcessMFG] [bit] NULL,

	--Equipment & Warranty
	[EQEnabled] [bit] NULL DEFAULT (0),
	[EquipmentItemClass] [char](2) NULL DEFAULT 'OI',
	[EquipmentTypeID] [uniqueidentifier] NULL,
	[ManufacturerID] [uniqueidentifier] NULL,
	[ManufacturerModelID] [uniqueidentifier] NULL,
	[ModelType] [char](2) NULL DEFAULT 'EQ',
	[CpnyWarrantyType] [char](1) NULL DEFAULT 'M',
	[CpnyWarrantyValue] [int] NULL DEFAULT (0),
	[VendorWarrantyType] [char](1) NULL DEFAULT 'M',
	[VendorWarrantyValue] [int] NULL DEFAULT (0),

	--Service Management
	[SDEnabled] [bit] NULL DEFAULT (0),
	[ActionType] [char](1) NULL,
	[BillingRule] [char](4) NULL,
	[DfltEarningType] [nvarchar](15) NULL,
	[EstimatedDuration] [int] NULL DEFAULT (0),
	[IsTravelItem] [bit] NULL DEFAULT (0),
	[PostToExpenseAccount] [char](1) NOT NULL DEFAULT ('P'),

	--Planning
	[PlanningMethod] [char](1) NOT NULL DEFAULT 'N',

	--Flags
	[Commissionable] [bit] NOT NULL,
	[IsConverted] [bit] NOT NULL DEFAULT (0),
	[IsSpecialOrderItem] [bit] NOT NULL DEFAULT (0),
	[T5018Service] [bit] NULL DEFAULT (0),

	--Security
	[GroupMask] [varbinary](32) NOT NULL DEFAULT 0x,

	--Notes
	[NoteID] [uniqueidentifier] NOT NULL,
	[Body] [ntext] NULL,

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

	CONSTRAINT [INItem_PK] PRIMARY KEY CLUSTERED
	(
		[ItemID] ASC
	),
	CONSTRAINT [INItem_UK] UNIQUE NONCLUSTERED
	(
		[ItemCD] ASC
	)
)
GO
CREATE NONCLUSTERED INDEX [INItem_ItemClass] ON [dbo].[INItem] ([ItemClassID])
GO
CREATE NONCLUSTERED INDEX [INItem_PostClass] ON [dbo].[INItem] ([PostClassID])
GO
CREATE NONCLUSTERED INDEX [INItem_LotSerClass] ON [dbo].[INItem] ([LotSerClassID])
GO
CREATE NONCLUSTERED INDEX [INItem_ItemType] ON [dbo].[INItem] ([ItemType], [ItemStatus])
GO
CREATE NONCLUSTERED INDEX [INItem_PreferredVendor] ON [dbo].[INItem] ([PreferredVendorID], [PreferredVendorLocationID])
GO

----------------------------------------------------------------
-- INItemExt
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[INItemExt];
CREATE TABLE [dbo].[INItemExt]
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
CREATE NONCLUSTERED INDEX [INItemExt_ValueString] ON [dbo].[INItemExt] ([RecordID], [FieldName]) INCLUDE ([ValueString])
GO
