CREATE TABLE [dbo].[RecordAttachment]
(
  [RecordID] [uniqueidentifier] NOT NULL PRIMARY KEY,  
  [FileID] [uniqueidentifier] NOT NULL,

  --System
	[CreatedByUserID] [uniqueidentifier] NOT NULL,
	[CreatedFrom] [char](8) NOT NULL,
	[CreatedAtDateTime] [datetime] NOT NULL,
	[UpdatedByUserID] [uniqueidentifier] NOT NULL,
	[UpdatedFrom] [char](8) NOT NULL,
	[UpdatedAtDateTime] [datetime] NOT NULL,

  CONSTRAINT [SIRecordInfo_PK] PRIMARY KEY CLUSTERED
	(
		[RecordID] ASC
	),
)
