----------------------------------------------------------------
-- GLPreferences
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[GLPreferences];
CREATE TABLE [dbo].[GLPreferences]
(
	[LedgerID] [uniqueidentifier] NULL,
	[BatchNumberingID] [uniqueidentifier] NOT NULL,

	[RequireControlTotal] [bit] NOT NULL,
	[COAOrder] [smallint] NOT NULL,
	[TrialBalanceSign] [char](1) NOT NULL DEFAULT ('N'),

	[YtdNetIncAccountID] [uniqueidentifier] NOT NULL,
	[RetEarnAccountID] [uniqueidentifier] NOT NULL,

	--System
	[CreatedByUserID] [uniqueidentifier] NOT NULL,
	[CreatedFrom] [char](8) NOT NULL,
	[CreatedAtDateTime] [datetime] NOT NULL,
	[UpdatedByUserID] [uniqueidentifier] NOT NULL,
	[UpdatedFrom] [char](8) NOT NULL,
	[UpdatedAtDateTime] [datetime] NOT NULL,
	[Version] [rowversion] NULL,
	[Deleted] [bit] NOT NULL DEFAULT (0),
)
GO
