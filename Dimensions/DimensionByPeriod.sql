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