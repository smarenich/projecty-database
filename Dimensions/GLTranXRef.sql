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