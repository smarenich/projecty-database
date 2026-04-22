----------------------------------------------------------------
-- SYRecordType
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[SYRecordType];
CREATE TABLE [dbo].[SYRecordType]
(
	[RecordTypeID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),
	[EntityType] [nvarchar](255) NOT NULL,

  --System Info
  [KeyFields] [varchar](255) NOT NULL,
  [PrimaryModelType] [varchar](255) NULL,

  --Search
  [Module] [char](2) NOT NULL,
  [Prefix] [char](5) NOT NULL,

  --Interface
	[DisplayNameSingular] [nvarchar](255) NULL,
  [DisplayNamePlural] [nvarchar](255) NULL,

  --Flags
  [IsSearchable] [bit] NULL,
  [IsAuditable] [bit] NULL,
  [IsTaggable] [bit] NULL,
  [IsAttachable] [bit] NULL,

	PRIMARY KEY CLUSTERED
	(
		[RecordTypeID] ASC
	),
	UNIQUE NONCLUSTERED
	(
		[EntityType] ASC
	)
)
GO
