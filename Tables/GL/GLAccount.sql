----------------------------------------------------------------
-- GLAccount
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[GLAccount];
CREATE TABLE [dbo].[GLAccount](
	[AccountID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),
	[AccountCD] [nvarchar](15) NOT NULL,

	[CompanyID] [uniqueidentifier] NOT NULL, --Foreign Key to Company
	[VisibilityMode] [char](1) NOT NULL, --R=Restricted to All V=Visible to All

	[Type] [char](1) NOT NULL, --Income, Expense, Asset, Liability, YTDNetIncome, RetainedEarnings
	[OffBalance] [bit] NOT NULL DEFAULT (0),
	[Description] [nvarchar](60) NULL,
	
	[CurrencyID] [nvarchar](5) /*JSON*/ NULL,
	[CuryRateTypeID] [uniqueidentifier] /*JSON*/ NULL,
	
	-- [DirectPost] [bit] /*JSON*/ NOT NULL, 
	[ControlAccountModule] [bit] /*JSON*/ NOT NULL DEFAULT (0), 
	[AllowManualEntry] [bit] /*JSON*/ NOT NULL DEFAULT (0),

	--[TaxCategoryID] [uniqueidentifier] /*JSON*/ NULL, --TODO To be added with taxes

	--TAGS

	[CreatedByUserID] [uniqueidentifier] /*JSON*/ NOT NULL,
	[CreatedFrom] [char](8) /*JSON*/ NOT NULL,
	[CreatedAtDateTime] [datetime] /*JSON*/ NOT NULL,
	[UpdatedByUserID] [uniqueidentifier] /*JSON*/ NOT NULL,
	[UpdatedFrom] [char](8) /*JSON*/ NOT NULL,
	[UpdatedAtDateTime] [datetime] /*JSON*/ NOT NULL,
	[Version] [rowversion] NULL,
	[Deleted] [bit] NOT NULL DEFAULT (0),
	[JSON] [nvarchar](MAX) NULL,

	PRIMARY KEY CLUSTERED
	(
		[AccountID] ASC
	),
	UNIQUE NONCLUSTERED
	(
		[CompanyID] ASC,
		[AccountCD] ASC
	)
)
GO

----------------------------------------------------------------
-- GLAccountExt
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[GLAccountExt];
CREATE TABLE [dbo].[GLAccountExt](
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
