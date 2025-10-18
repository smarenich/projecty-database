----------------------------------------------------------------
-- GLAccountJobClass
----------------------------------------------------------------
CREATE TABLE [dbo].[GLAccountJobClass](
	[GLAccountJobClassID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),
	[GLAccountJobClassCD] [nvarchar](20) NOT NULL,
	[Description] [nvarchar](250) NULL,
	[IsActive] [bit] NOT NULL,

	[Type] [char](1) NULL,
	[ReportGroup] [char](1) NULL,
	[SortOrder] [smallint] NULL,

	[CreatedByID] [uniqueidentifier] NOT NULL,
	[CreatedByScreenID] [char](8) NOT NULL,
	[CreatedDateTime] [datetime] NOT NULL,
	[LastModifiedByID] [uniqueidentifier] NOT NULL,
	[LastModifiedByScreenID] [char](8) NOT NULL,
	[LastModifiedDateTime] [datetime] NOT NULL,
	[Version] [rowversion] NULL,

	CONSTRAINT [GLAccountJobClass_PK] PRIMARY KEY CLUSTERED 
	(
		[GroupID] ASC
	)
)
GO