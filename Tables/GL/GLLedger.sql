----------------------------------------------------------------
-- GLLedger
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[GLLedger];
CREATE TABLE [dbo].[GLLedger](
	[LedgerID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),
	[LedgerCD] [nvarchar](30) NOT NULL,
	[Description] [nvarchar](60) NULL,

	[Type] [char](1) NOT NULL, --Actual, Reporting, Statistical
	[BaseCurrencyID] [nvarchar](5) NULL, --TODISCUSS Where to take base currency from?


	[CreatedByUserID] [uniqueidentifier] NOT NULL,
	[CreatedFrom] [char](8) NOT NULL,
	[CreatedAtDateTime] [datetime] NOT NULL,
	[UpdatedByUserID] [uniqueidentifier] NOT NULL,
	[UpdatedFrom] [char](8) NOT NULL,
	[UpdatedAtDateTime] [datetime] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[Version] [rowversion] NULL,
	[JSON] [nvarchar](MAX) NULL,

	PRIMARY KEY CLUSTERED
	(
		[LedgerID] ASC
	),
	UNIQUE NONCLUSTERED
	(
		[LedgerCD] ASC
	)
)
GO
