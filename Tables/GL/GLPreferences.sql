CREATE TABLE [dbo].[GLPreferences]
(
  [LedgerID] [uniqueidentifier]  null,

  [BatchNumberingID] [uniqueidentifier] not null,

  [RequireControlTotal] bit not null,
  [COAOrder] smallint not null,
  [TrialBalanceSign] char(1) default 'N' not null,

  [YtdNetIncAccountID] [uniqueidentifier] not null,
  [RetEarnAccountID] [uniqueidentifier] not null,

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
