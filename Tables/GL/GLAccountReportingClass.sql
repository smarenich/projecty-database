----------------------------------------------------------------
-- GLAccountReportingClass
----------------------------------------------------------------
CREATE TABLE [dbo].[GLAccountReportingClass](
	[AccountReportingClassID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),
	[AccountReportingClassCD] [nvarchar](20) NOT NULL,
	[Descricption] [nvarchar](250) NULL,
	[IsActive] [bit] NOT NULL,
	
	[Type] [char](1) NOT NULL,
	[SortOrder] [smallint] NULL,

	[CreatedByID] [uniqueidentifier] NOT NULL,
	[CreatedByScreenID] [char](8) NOT NULL,
	[CreatedDateTime] [datetime] NOT NULL,
	[LastModifiedByID] [uniqueidentifier] NOT NULL,
	[LastModifiedByScreenID] [char](8) NOT NULL,
	[LastModifiedDateTime] [datetime] NOT NULL,
	[Version] [rowversion] NULL,

	CONSTRAINT [GLAccountClass_PK] PRIMARY KEY CLUSTERED 
	(
		[AccountClassID] ASC
	)
)
GO