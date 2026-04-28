----------------------------------------------------------------
-- SICompany
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[SICompany];
CREATE TABLE [dbo].[SICompany]
(
	[CompanyID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),
	[CompanyCD] [nvarchar](15) NOT NULL,
	[Type] [char](1) NOT NULL, --C=Company, B=Branch
	[Active] [bit] NOT NULL DEFAULT (0),
	[Description] [nvarchar](60) NULL,

	[ParentCompanyID] [uniqueidentifier] NULL, 
	[BaseCurrencyID] [nvarchar](5) NULL,  --TODISCUSS Where to take base currency from?
  	[AccessRole] [uniqueidentifier] NULL,
	
	[LegalName] [nvarchar](256) NULL,
	[TaxRegistrationID] [nvarchar](60) NULL,
  	[DefaultAddressID] [uniqueidentifier] NULL, --TODISCUSS Do we need double links from Company to Address and Back?
	[DefaultContactID] [uniqueidentifier] NULL, --TODISCUSS Do we need double links from Company to Contact and Back?

	[YTDNetIncomeAccount] [uniqueidentifier] /*JSON*/ NOT NULL, --TODISCUSS can it be different per comapyn?
	[RetainedEarningsAccountID] [uniqueidentifier] /*JSON*/ NOT NULL,
	[TrialBalanceSign] [char](1) /*JSON*/ NOT NULL,

  
	[CreatedByUserID] [uniqueidentifier] NOT NULL,
	[CreatedFrom] [char](8) NOT NULL,
	[CreatedAtDateTime] [datetime] NOT NULL,
	[UpdatedByUserID] [uniqueidentifier] NOT NULL,
	[UpdatedFrom] [char](8) NOT NULL,
	[UpdatedAtDateTime] [datetime] NOT NULL,
	[Version] [rowversion] NULL,
	[JSON] [nvarchar](MAX) NULL,
	[Deleted] [bit] NOT NULL DEFAULT (0),

	PRIMARY KEY CLUSTERED
	(
		[CompanyID] ASC
	),
	UNIQUE NONCLUSTERED
	(
		[CompanyCD] ASC
	)
)
GO
