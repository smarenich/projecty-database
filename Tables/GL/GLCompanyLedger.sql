----------------------------------------------------------------
-- GLCompanyLedger
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[GLCompanyLedger];
CREATE TABLE [dbo].[GLCompanyLedger](
	[LedgerID] [uniqueidentifier] NOT NULL, --Foreign Key to Company
	[CompanyID] [uniqueidentifier] NOT NULL, --Foreign Key to Company

    [VisibilityMode] [char](1) NOT NULL, --C=Company Specific, V=Visible, R=Restricted

	[CreatedByUserID] [uniqueidentifier] NOT NULL,
	[CreatedFrom] [char](8) NOT NULL,
	[CreatedAtDateTime] [datetime] NOT NULL,
	[UpdatedByUserID] [uniqueidentifier] NOT NULL,
	[UpdatedFrom] [char](8) NOT NULL,
	[UpdatedAtDateTime] [datetime] NOT NULL,
	[Deleted] [bit] NOT NULL DEFAULT (0),
	[Version] [rowversion] NULL,
	[JSON] [nvarchar](MAX) NULL,

	PRIMARY KEY CLUSTERED
	(
		[LedgerID] ASC,
		[CompanyID] ASC
	)
)
GO
