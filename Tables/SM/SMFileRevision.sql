DROP TABLE IF EXISTS [dbo].[SMFileRevision];
CREATE TABLE [dbo].[SMFileRevision]
(
  [FileID] [uniqueidentifier] NOT NULL,
  [FileRevisionID] [int] NOT NULL,

  [Data] [image] NOT NULL,
  [Size] [int] NOT NULL,
  [Comment] [nvarchar](500) NULL,

  [OriginalName] [nvarchar](255) NULL,
  [OriginalTimestamp] [datetime] NULL,
  [BlobHandler] [uniqueidentifier] NULL,

	--System
	[CreatedByUserID] [uniqueidentifier] NOT NULL,
	[CreatedFrom] [char](8) NOT NULL,
	[CreatedAtDateTime] [datetime] NOT NULL,
	[UpdatedByUserID] [uniqueidentifier] NOT NULL,
	[UpdatedFrom] [char](8) NOT NULL,
	[UpdatedAtDateTime] [datetime] NOT NULL,
	[Version] [rowversion] NULL,
	[JSON] [nvarchar](MAX) NULL,
	[Deleted] [bit] NOT NULL DEFAULT (0),

  CONSTRAINT [SMFileRevision_PK] PRIMARY KEY CLUSTERED
  (
    [FileID] ASC,
    [FileRevisionID] ASC
  )
)
GO
