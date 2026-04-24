----------------------------------------------------------------
-- GLChartOfAccounts
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[GLChartOfAccounts];
CREATE TABLE [dbo].[GLChartOfAccounts](
	[ChartOfAccountsID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),
	[ChartOfAccountsCD] [nvarchar](15) NOT NULL,
	[Description] [nvarchar](60) NULL,
	[IsDefault] [bit] NOT NULL, 

	[YTDNetIncomeAccount] [uniqueidentifier] /*JSON*/ NOT NULL, --TODISCUSS can it be different per comapyn?
	[RetainedEarningsAccountID] [uniqueidentifier] /*JSON*/ NOT NULL,
	[TrialBalanceSign] [char](1) /*JSON*/ NOT NULL,
	[BaseCurrencyID] [nvarchar](5) /*JSON*/ NULL, --TODISCUSS Where should base currency be? COA or Company?
  
	[CreatedByUserID] [uniqueidentifier] /*JSON*/ NOT NULL,
	[CreatedFrom] [char](8) /*JSON*/ NOT NULL,
	[CreatedAtDateTime] [datetime] /*JSON*/ NOT NULL,
	[UpdatedByUserID] [uniqueidentifier] /*JSON*/ NOT NULL,
	[UpdatedFrom] [char](8) /*JSON*/ NOT NULL,
	[UpdatedAtDateTime] [datetime] /*JSON*/ NOT NULL,
	[Version] [rowversion] NULL,
	[Deleted] [bit] NOT NULL,
	[JSON] [nvarchar](MAX) NULL,

	PRIMARY KEY CLUSTERED
	(
		[ChartOfAccountsID] ASC
	),
	UNIQUE NONCLUSTERED
	(
		[ChartOfAccountsCD] ASC
	)
)
GO



----------------------------------------------------------------
-- GLChartsOfAccountsMapping
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[GLChartsOfAccountsMapping];
CREATE TABLE [dbo].[GLChartsOfAccountsMapping](
	[ChartOfAccountsMappingID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),

	[ChartOfAccountsID] [uniqueidentifier] NOT NULL,
	[AccountID] [uniqueidentifier] NOT NULL,

	-- [DirectPost] [bit] /*JSON*/ NOT NULL, 
	[ControlAccountModule] [bit] /*JSON*/ NOT NULL, --TOREVIEW Where to store in COA or Account?
	[AllowManualEntry] [uniqueidentifier] /*JSON*/ NOT NULL, --TOREVIEW Where to store?
  
	[CreatedByUserID] [uniqueidentifier] /*JSON*/ NOT NULL,
	[CreatedFrom] [char](8) /*JSON*/ NOT NULL,
	[CreatedAtDateTime] [datetime] /*JSON*/ NOT NULL,
	[UpdatedByUserID] [uniqueidentifier] /*JSON*/ NOT NULL,
	[UpdatedFrom] [char](8) /*JSON*/ NOT NULL,
	[UpdatedAtDateTime] [datetime] /*JSON*/ NOT NULL,
	[Version] [rowversion] NULL,

	PRIMARY KEY CLUSTERED
	(
		[ChartOfAccountsMappingID] ASC
	),
)
GO
