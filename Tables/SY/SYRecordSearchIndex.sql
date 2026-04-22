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

  --FiltrationMetadata
  [ModuleCode] [char](2) NULL,
  [Status] [NVARCHAR](20) NULL,     
  [Date] [datetime] NULL,
  [Amount]              DECIMAL(19,4)    NULL,      -- сумма, если применимо
  [CurrencyID]        CHAR(5)          NULL,
  [OwnerID]             UNIQUEIDENTIFIER NULL,      -- кто владелец/ответственный

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

CREATE INDEX IX_SearchIndex_Date 
    ON SearchIndex (CompanyID, DocumentDate DESC)
    INCLUDE (EntityTypeID, Title);

-- Для навигации по владельцу (My Documents)
CREATE INDEX IX_SearchIndex_Owner 
    ON SearchIndex (CompanyID, OwnerID, IsActive)
    WHERE OwnerID IS NOT NULL;