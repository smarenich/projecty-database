----------------------------------------------------------------
-- INItem (InventoryItem)
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[INItem];
CREATE TABLE [dbo].[INItem]
(
	[ItemID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),
	[ItemCD] [nvarchar](30) NOT NULL,
	[Description] [nvarchar](256) NULL,
	[Type] [char](1) NOT NULL, --Stock/NonStock/Kit

	--Classification
	[ItemType] [char](1) NOT NULL,
	[ItemStatus] [char](2) NOT NULL,
	[ItemClassID] [uniqueidentifier] NULL,
	[PostClassID] [nvarchar](10) NULL,
	[PriceClassID] [nvarchar](10) NULL,
	[LotSerClassID] [nvarchar](10) NULL,

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

	--Weight & Volume
	[WeightItem] [bit] NOT NULL DEFAULT (0),
	[BaseWeight] [decimal](28, 8) NOT NULL,
	[BaseItemWeight] [decimal](28, 8) NOT NULL,
	[WeightUOM] [nvarchar](6) NULL,
	[BaseVolume] [decimal](28, 8) NOT NULL,
	[BaseItemVolume] [decimal](28, 8) NOT NULL,
	[VolumeUOM] [nvarchar](6) NULL,


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

	--Vendor
	[PreferredVendorID] [uniqueidentifier] NULL,
	[PreferredVendorLocationID] [uniqueidentifier] NULL,

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

	--Planning
	[PlanningMethod] [char](1) NOT NULL DEFAULT 'N',


	--Description
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
