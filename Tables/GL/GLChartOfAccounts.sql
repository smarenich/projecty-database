----------------------------------------------------------------
-- GLChartOfAccounts
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[GLChartOfAccounts];
CREATE TABLE [dbo].[GLChartOfAccounts](
	[ChartOfAccountsID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),
	[ChartOfAccountsCD] [nvarchar](15) NOT NULL,
	[Description] [nvarchar](60) NULL,

	[YTDNetIncomeAccount] [uniqueidentifier] /*JSON*/ NOT NULL,
	[RetainedEarningsAccountID] [uniqueidentifier] /*JSON*/ NOT NULL,
	[TrialBalanceSign] [char](1) /*JSON*/ NOT NULL,
	[CurrencyID] [nvarchar](5) /*JSON*/ NULL,
  
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
-- GLAccountExt
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[GLChartOfAccountsExt];
CREATE TABLE [dbo].[GLChartOfAccountsExt](
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


----------------------------------------------------------------
-- GLChartOfAccountsDetail
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[GLChartOfAccountsDetail];
CREATE TABLE [dbo].[GLChartOfAccountsDetail](
  [ChartOfAccountsDetailID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),

	[ChartOfAccountsID] [uniqueidentifier] NOT NULL,
	[AccountID] [uniqueidentifier] NOT NULL,

	[ControlAccountModule] [bit] /*JSON*/ NOT NULL,
	[AllowManualEntry] [uniqueidentifier] /*JSON*/ NOT NULL,
  
	[CreatedByUserID] [uniqueidentifier] /*JSON*/ NOT NULL,
	[CreatedFrom] [char](8) /*JSON*/ NOT NULL,
	[CreatedAtDateTime] [datetime] /*JSON*/ NOT NULL,
	[UpdatedByUserID] [uniqueidentifier] /*JSON*/ NOT NULL,
	[UpdatedFrom] [char](8) /*JSON*/ NOT NULL,
	[UpdatedAtDateTime] [datetime] /*JSON*/ NOT NULL,
	[Version] [rowversion] NULL,

	PRIMARY KEY CLUSTERED
	(
		[ChartOfAccountsDetailID] ASC
	),
)
GO
