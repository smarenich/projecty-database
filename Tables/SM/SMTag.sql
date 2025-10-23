DROP TABLE IF EXISTS [dbo].[SMTag];
CREATE TABLE [dbo].[SMTag]
(
  [TagID] [uniqueidentifier] NOT NULL,
  [TagCD] [nvarchar](10) NOT NULL, 
  
  [Type] [char](1) NULL,
  [Description] [nvarchar](256) NULL,

	--System
	[CreatedByUserID] [uniqueidentifier] NOT NULL,
	[CreatedFrom] [char](8) NOT NULL,
	[CreatedAtDateTime] [datetime] NOT NULL,
	[UpdatedByUserID] [uniqueidentifier] NOT NULL,
	[UpdatedFrom] [char](8) NOT NULL,
	[UpdatedAtDateTime] [datetime] NOT NULL,
	[Version] [rowversion] NULL,
	[Deleted] [bit] NOT NULL DEFAULT (0),

  CONSTRAINT [SMTag_PK] PRIMARY KEY CLUSTERED
	(
		[RecordID] ASC
	)
)
GO
CREATE UNIQUE INDEX [SMTag_TagCD] ON [dbo].[SMTag]
(
	[TagCD] ASC
)
GO
