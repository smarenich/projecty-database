----------------------------------------------------------------
-- INWarehouse (INSite)
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[INWarehouse];
CREATE TABLE [dbo].[INWarehouse]
(
	[WarehouseID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),
	[WarehouseCD] [nvarchar](30) NOT NULL,
	[Description] [nvarchar](60) NULL,

	--Status
	[Active] [bit] NOT NULL DEFAULT (1),

	--References
	[BranchID] [uniqueidentifier] NOT NULL,
	[BAccountID] [uniqueidentifier] NULL,
	[ContactID] [uniqueidentifier] NULL,
	[AddressID] [uniqueidentifier] NULL,

	--Currency
	[BaseCurrencyID] [nvarchar](5) NOT NULL,

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
	[OverrideInvtAccSub] [bit] NOT NULL DEFAULT (0),

	--Locations
	[ReceiptLocationID] [uniqueidentifier] NULL,
	[ShipLocationID] [uniqueidentifier] NULL,
	[ReturnLocationID] [uniqueidentifier] NULL,
	[DropShipLocationID] [uniqueidentifier] NULL,
	[NonStockPickingLocationID] [uniqueidentifier] NULL,

	--Replenishment
	[ReplenishmentClassID] [nvarchar](10) NULL,

	--Costing
	[AvgDefaultCost] [char](1) NOT NULL DEFAULT 'A',
	[FIFODefaultCost] [char](1) NOT NULL DEFAULT 'A',

	--Carrier
	[CarrierFacility] [nvarchar](50) NULL,

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

	CONSTRAINT [INWarehouse_PK] PRIMARY KEY CLUSTERED
	(
		[WarehouseID] ASC
	),
	CONSTRAINT [INWarehouse_UK] UNIQUE NONCLUSTERED
	(
		[WarehouseCD] ASC
	)
)
GO
CREATE NONCLUSTERED INDEX [INWarehouse_Branch] ON [dbo].[INWarehouse] ([BranchID])
GO
CREATE NONCLUSTERED INDEX [INWarehouse_Active] ON [dbo].[INWarehouse] ([Active])
GO

----------------------------------------------------------------
-- INWarehouseExt
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[INWarehouseExt];
CREATE TABLE [dbo].[INWarehouseExt]
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
CREATE NONCLUSTERED INDEX [INWarehouseExt_ValueString] ON [dbo].[INWarehouseExt] ([RecordID], [FieldName]) INCLUDE ([ValueString])
GO
