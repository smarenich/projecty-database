----------------------------------------------------------------
-- SICompany
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[SICompany];
CREATE TABLE [dbo].[SICompany]
(
	[CompanyID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),
	[CompanyCD] [nvarchar](30) NOT NULL,
	[Type] [char](1) NOT NULL, --C=Company, B=Branch
	[Active] [bit] NOT NULL,
	[Description] [nvarchar](60) NULL,

	[ParentCompanyID] [uniqueidentifier] NULL, 
	[BaseCurrencyID] [nvarchar](5) NULL,  --TODISCUSS Where to take base currency from?
  	[AccessRole] [uniqueidentifier] NULL,
	
	[LegalName] [nvarchar](60) NULL,
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
	[Deleted] [bit] NOT NULL,

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

----------------------------------------------------------------
-- SIPartyExt
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[SIPartyExt];
CREATE TABLE [dbo].[SIPartyExt](
	[RecordID] [uniqueidentifier] NOT NULL,
	[FieldName] [varchar](30) NOT NULL,
	[ValueNumeric] [decimal](28, 8) NULL,
	[ValueDate] [datetime] NULL,
	[ValueString] [nvarchar](256) NULL,
	[ValueText] [nvarchar](max) NULL,
	PRIMARY KEY CLUSTERED
	(
		[RecordID] ASC,
		[FieldName] ASC
	)
)
GO