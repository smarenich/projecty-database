CREATE TABLE [dbo].[RecordComment]
(
  [RecordID] [uniqueidentifier] NOT NULL PRIMARY KEY,
  
  [Comment] [nvarchar](max) NOT NULL,

  --System
	[CreatedByUserID] [uniqueidentifier] NOT NULL,
	[CreatedFrom] [char](8) NOT NULL,
	[CreatedAtDateTime] [datetime] NOT NULL,
	[UpdatedByUserID] [uniqueidentifier] NOT NULL,
	[UpdatedFrom] [char](8) NOT NULL,
	[UpdatedAtDateTime] [datetime] NOT NULL,
	[Version] [rowversion] NULL,
	[Deleted] [bit] NOT NULL DEFAULT (0),

  CONSTRAINT [SIRecordInfo_PK] PRIMARY KEY CLUSTERED
	(
		[RecordID] ASC
	),
)
