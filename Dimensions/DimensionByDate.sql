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