----------------------------------------------------------------
-- GLLedger
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[GLLedger];
CREATE TABLE [dbo].[GLLedger](
	[LedgerID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),
	[LedgerCD] [nvarchar](30) NOT NULL,
	[Type] [char](1) NOT NULL,
	[Description] [nvarchar](60) NULL,
	[BaseCurrencyID] [nvarchar](5) NULL,

	[Version] [rowversion] NULL
	PRIMARY KEY CLUSTERED
	(
		[LedgerID] ASC
	)
)
GO
