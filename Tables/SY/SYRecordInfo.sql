DROP TABLE IF EXISTS [dbo].[SYRecordInfo];
CREATE TABLE [dbo].[SYRecordInfo]
(
  [RecordID] [uniqueidentifier] NOT NULL,

  --Technical Info
  [RecordType] [Char](1) NOT NULL, --Parent/Detail
  [EntityType] [varchar](255) NULL,
  [BusinessObjectType] [varchar](255) NULL,
  --[ExternalKey] [nvarchar](255) NULL, --Key for Integrations

  --Public Info
  [RecordDisplay] [nvarchar](255) NULL, -- Combined Key
 	[WorkgroupID] [int] NULL,
	[OwnerID] [int] NULL,

  --Search
  [Category] [int] NOT NULL,
	[Content] [nvarchar] (MAX) NOT NULL,

  --System
  [Version] [rowversion] NULL,

  CONSTRAINT [SYRecordInfo_PK] PRIMARY KEY CLUSTERED
	(
		[RecordID] ASC
	)
)
GO
