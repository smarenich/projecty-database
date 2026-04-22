----------------------------------------------------------------
-- SYRecordType
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[SYRecordType];
CREATE TABLE [dbo].[SYRecordType]
(
	[RecordTypeID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),
	[RecordType] [nvarchar](127) NOT NULL,

  --System Info
  [KeyFields] [nvarchar](255) NOT NULL,
  [PrimaryModel] [nvarchar](255) NULL,

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
		[RecordType] ASC
	)
)
GO
