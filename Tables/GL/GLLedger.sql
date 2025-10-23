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

	[BalanceType] char(1) not null,
  	[BranchID] int null,

	[CreatedByUserID] [uniqueidentifier] NOT NULL,
	[CreatedFrom] [char](8) NOT NULL,
	[CreatedAtDateTime] [datetime] NOT NULL,
	[UpdatedByUserID] [uniqueidentifier] NOT NULL,
	[UpdatedFrom] [char](8) NOT NULL,
	[UpdatedAtDateTime] [datetime] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[Version] [rowversion] NULL,

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
