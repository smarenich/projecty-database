

----------------------------------------------------------------
-- GLTranXRef
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[GLTranXRef];
CREATE TABLE [dbo].[GLTranXRef](
    [Type] [tinyint] NOT NULL,
    [RecordID] [uniqueidentifier] NOT NULL,
	[DimensionID] [uniqueidentifier] NOT NULL
PRIMARY KEY CLUSTERED
(
    [Type],
	[RecordID],
	[DimensionID]
))
GO
CREATE NONCLUSTERED INDEX GLTranXRef_Dimension ON GLTranXRef ([DimensionID]) INCLUDE ([RecordID])
GO

----------------------------------------------------------------
-- DimensionByDate
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[DimensionByDate];
CREATE TABLE [dbo].[DimensionByDate] (
     [PostDate] [smalldatetime] not null,
     [Type] [tinyint] NOT NULL,
	 [DimensionID] [uniqueidentifier] not null,
	 [BaseAmt] [decimal] (28, 8),
     [CurrencyAmt] [decimal](28, 8),
	 [ConsoAmt] [decimal] (28, 8)
PRIMARY KEY CLUSTERED (
     [PostDate],
     [Type],
	 [DimensionID]
))
GO

----------------------------------------------------------------
-- DimensionByDate_Balances
----------------------------------------------------------------
DROP VIEW IF EXISTS [dbo].[DimensionByDate_Balances];
GO
CREATE VIEW [DimensionByDate_Balances]
AS SELECT
    Dimension.Type, 
    SIDate.Date, 
    Dimension.DimensionID, 
    Balance = sum(BaseAmt) 
FROM SIDate SIDate
INNER JOIN DimensionByDate Dimension ON SIDate.Date >= Dimension.postdate
GROUP BY
    SIDate.Date,    
    Dimension.Type,
    Dimension.DimensionID
GO

----------------------------------------------------------------
-- DimensionByPeriod
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[DimensionByPeriod];
CREATE TABLE [dbo].[DimensionByPeriod] (
     [Period] [char](6) not null,
     [Type] [tinyint] NOT NULL,
	 [DimensionID] [uniqueidentifier] not null,
	 [BaseAmt] [decimal] (28, 8),
     [CurrencyAmt] [decimal](28, 8),
	 [ConsoAmt] [decimal] (28, 8)
PRIMARY KEY CLUSTERED (
     [Period],
     [Type],
	 [DimensionID]
))
GO

----------------------------------------------------------------
-- Dimension_ViewByPeriod
----------------------------------------------------------------
DROP VIEW IF EXISTS [dbo].[DimensionByPeriod_Balances];
GO
CREATE VIEW [DimensionByPeriod_Balances]
AS SELECT
    Dimension.Type,
    SIPeriod.Period,
    Dimension.DimensionID, 
    Balance = sum(BaseAmt) 
FROM SIPeriod SIPeriod
INNER JOIN DimensionByPeriod Dimension ON SIPeriod.Period >= Dimension.[Period]
GROUP BY
    SIPeriod.Period,
    Dimension.Type,
    Dimension.DimensionID
GO