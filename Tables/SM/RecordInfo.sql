DROP TABLE IF EXISTS [dbo].[RecordInfo];
CREATE TABLE [dbo].[RecordInfo]
(
  [RecordID] [uniqueidentifier] NOT NULL PRIMARY KEY,
  
  --Technical Info
  [RecordType] [Char](1) NOT NULL, --Parent/Detaild
  [EntityType] [varchar](255) NULL,
  [BusinessOjectType] [varchar](255) NULL,
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

  CONSTRAINT [RecordInfo_PK] PRIMARY KEY CLUSTERED
	(
		[RecordID] ASC
	),
)
