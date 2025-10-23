----------------------------------------------------------------
-- SMTag
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[SMTag];
CREATE TABLE [dbo].[SMTag]
(
	[TagID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),
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
		[TagID] ASC
	),
	UNIQUE NONCLUSTERED
	(
		[TagCD] ASC
	)
)
GO
