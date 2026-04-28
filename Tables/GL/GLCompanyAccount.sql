----------------------------------------------------------------
-- GLCompanyAccount
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[GLCompanyAccount];
CREATE TABLE [dbo].[GLCompanyAccount](
	[CompanyID] [uniqueidentifier] NOT NULL,
	[AccountID] [uniqueidentifier] NOT NULL,

  [VisibilityMode] [char](1) NOT NULL, --C=Company Specific, V=Visible, R=Restricted
  
	[CreatedByUserID] [uniqueidentifier] /*JSON*/ NOT NULL,
	[CreatedFrom] [char](8) /*JSON*/ NOT NULL,
	[CreatedAtDateTime] [datetime] /*JSON*/ NOT NULL,
	[UpdatedByUserID] [uniqueidentifier] /*JSON*/ NOT NULL,
	[UpdatedFrom] [char](8) /*JSON*/ NOT NULL,
	[UpdatedAtDateTime] [datetime] /*JSON*/ NOT NULL,
	[Version] [rowversion] NULL,

	PRIMARY KEY CLUSTERED
	(
		[CompanyID] ASC,
		[AccountID] ASC
	),
)
GO