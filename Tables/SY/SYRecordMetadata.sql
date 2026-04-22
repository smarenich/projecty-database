----------------------------------------------------------------
-- SYRecordInfo
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[SYRecordInfo];
CREATE TABLE [dbo].[SYRecordInfo]
(
	[RecordID] [uniqueidentifier] NOT NULL,

	--Technical Info
	[RecordTypeID] [uniqueidentifier] NOT NULL,
	[ExternalKey] [nvarchar](255) NULL, --TODISCUSS Key for Integrations

	--Public Info
	[RecordDisplay] [nvarchar](255) NULL, -- Combined Key
	[WorkgroupID] [uniqueidentifier] NULL,
	[OwnerID] [uniqueidentifier] NULL,

	--Flags
	[CommentsFlag] [bit] /*JSON*/ NOT NULL,
	[FilesFlag] [bit] /*JSON*/ NOT NULL,
	[ActivitiesFlag] [bit] /*JSON*/ NOT NULL,

	--Search
	[Category] [int] NOT NULL,
	[Content] [nvarchar](MAX) NOT NULL,

	--System
	[Version] [rowversion] NULL,
	[JSON] [nvarchar](MAX) NULL,

	PRIMARY KEY CLUSTERED
	(
		[RecordID] ASC
	)
)
GO
