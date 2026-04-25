----------------------------------------------------------------
-- GLAccount
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[GLAccount];
CREATE TABLE [dbo].[GLAccount](
	[AccountID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),
	[AccountCD] [nvarchar](15) NOT NULL,
	[Type] [char](1) NOT NULL, --Income, Expense, Asset, Liability
	[OffBalance] [bit] NOT NULL, 
	[Description] [nvarchar](60) NULL,
	
	[CurrencyID] [nvarchar](5) /*JSON*/ NULL,
	[CuryRateTypeID] [uniqueidentifier] /*JSON*/ NULL,
	
	--TAGS

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
		[AccountID] ASC
	),
	UNIQUE NONCLUSTERED
	(
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
