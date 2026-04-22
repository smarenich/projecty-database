----------------------------------------------------------------
-- SYRecordSearchIndex
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[SYRecordSearchIndex];
CREATE TABLE [dbo].[SYRecordSearchIndex]
(
	[RecordID] [uniqueidentifier] NOT NULL,
	[LocaleID] [uniqueidentifier] NOT NULL,
  [RecordTypeID] [uniqueidentifier] NOT NULL,

  --Search
  [Category] [int] NOT NULL,
	[Content] [nvarchar] (MAX) NOT NULL,

  --Display
  [Title] [NVARCHAR](255) NULL,
  [Description] [NVARCHAR](511) NULL,                 

  --FiltrationMetadata
  [ModuleCode] [char](2) NULL,
  [Status] [NVARCHAR](20) NULL,     
  [Date] [datetime] NULL,
  [Amount] [decimal](21,4) NULL,
  [CurrencyID] [char](5) NULL,
  [OwnerID] [uniqueidentifier] NULL,

	PRIMARY KEY CLUSTERED
	(
		[RecordID] ASC,
    [LocaleID] ASC
	)
)
GO

IF EXISTS(SELECT * FROM sys.fulltext_catalogs)
	CREATE FULLTEXT INDEX ON [SYRecordSearchIndex] ([Content]) KEY INDEX [IX_SearchIndex]  ON [ft]
GO

DROP TABLE IF EXISTS [dbo].[IX_SearchIndex_Date];
CREATE INDEX IX_SearchIndex_Date 
    ON SYRecordSearchIndex (Date DESC)
    INCLUDE (RecordTypeID, Title);

DROP TABLE IF EXISTS [dbo].[IX_SearchIndex_Owner];
CREATE INDEX IX_SearchIndex_Owner 
    ON SYRecordSearchIndex (OwnerID)
    WHERE OwnerID IS NOT NULL;