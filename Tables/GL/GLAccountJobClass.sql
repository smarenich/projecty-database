----------------------------------------------------------------
-- GLAccountJobClass
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[GLAccountJobClass];
CREATE TABLE [dbo].[GLAccountJobClass](
	[GLAccountJobClassID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),
	[GLAccountJobClassCD] [nvarchar](20) NOT NULL,
	[Description] [nvarchar](250) NULL,
	[IsActive] [bit] NOT NULL,

	[Type] [char](1) NULL,
	[ReportGroup] [char](1) NULL,
	[SortOrder] [smallint] NULL,

	[CreatedByUserID] [uniqueidentifier] NOT NULL,
	[CreatedFrom] [char](8) NOT NULL,
	[CreatedAtDateTime] [datetime] NOT NULL,
	[UpdatedByUserID] [uniqueidentifier] NOT NULL,
	[UpdatedFrom] [char](8) NOT NULL,
	[UpdatedAtDateTime] [datetime] NOT NULL,
	[Version] [rowversion] NULL,
	[JSON] [nvarchar](MAX) NULL,

	CONSTRAINT [GLAccountJobClass_PK] PRIMARY KEY CLUSTERED
	(
		[GLAccountJobClassID] ASC
	),
	UNIQUE NONCLUSTERED
	(
		[GLAccountJobClassCD] ASC
	)
)
GO