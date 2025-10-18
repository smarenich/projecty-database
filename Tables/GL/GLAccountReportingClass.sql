----------------------------------------------------------------
-- GLAccountReportingClass
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[GLAccountReportingClass];
CREATE TABLE [dbo].[GLAccountReportingClass](
	[AccountReportingClassID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),
	[AccountReportingClassCD] [nvarchar](20) NOT NULL,
	[Descricption] [nvarchar](250) NULL,
	[IsActive] [bit] NOT NULL,
	
	[Type] [char](1) NOT NULL,
	[SortOrder] [smallint] NULL,

	[CreatedByUserID] [uniqueidentifier] NOT NULL,
	[CreatedFrom] [char](8) NOT NULL,
	[CreatedAtDateTime] [datetime] NOT NULL,
	[UpdatedByUserID] [uniqueidentifier] NOT NULL,
	[UpdatedFrom] [char](8) NOT NULL,
	[UpdatedAtDateTime] [datetime] NOT NULL,
	[Version] [rowversion] NULL,

	CONSTRAINT [GLAccountClass_PK] PRIMARY KEY CLUSTERED 
	(
		[AccountClassID] ASC
	)
)
GO