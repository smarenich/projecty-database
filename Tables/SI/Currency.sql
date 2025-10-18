----------------------------------------------------------------
-- Currency
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[SICurrency];
CREATE TABLE [dbo].[SICurrency]
(
  [CurrencyID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),
	[CurrencyCD] [nvarchar](5) NOT NULL,
	[Active] [bit] NOT NULL,

	[RealizedGainAcctID] [uniqueidentifier] NULL,
	[RealizedGainSubID] [uniqueidentifier] NULL,
	[RealizedLossAcctID] [uniqueidentifier] NULL,
	[RealizedLossSubID] [uniqueidentifier] NULL,
	[RevaluationGainAcctID] [uniqueidentifier] NULL,
	[RevaluationGainSubID] [uniqueidentifier] NULL,
	[RevaluationLossAcctID] [uniqueidentifier] NULL,
	[RevaluationLossSubID] [uniqueidentifier] NULL,
	[TranslationGainAcctID] [uniqueidentifier] NULL,
	[TranslationGainSubID] [uniqueidentifier] NULL,
	[TranslationLossAcctID] [uniqueidentifier] NULL,
	[TranslationLossSubID] [uniqueidentifier] NULL,
	[UnrealizedGainAcctID] [uniqueidentifier] NULL,
	[UnrealizedGainSubID] [uniqueidentifier] NULL,
	[UnrealizedLossAcctID] [uniqueidentifier] NULL,
	[UnrealizedLossSubID] [uniqueidentifier] NULL,
	[RoundingGainAcctID] [uniqueidentifier] NULL,
	[RoundingGainSubID] [uniqueidentifier] NULL,
	[RoundingLossAcctID] [uniqueidentifier] NULL,
	[RoundingLossSubID] [uniqueidentifier] NULL,

	[RoundingLimit] [decimal](19, 4) NOT NULL DEFAULT (0),

	[CreatedByUserID] [uniqueidentifier] NOT NULL,
	[CreatedFrom] [char](8) NOT NULL,
	[CreatedAtDateTime] [datetime] NOT NULL,
	[UpdatedByUserID] [uniqueidentifier] NOT NULL,
	[UpdatedFrom] [char](8) NOT NULL,
	[UpdatedAtDateTime] [datetime] NOT NULL,
	[Version] [rowversion] NULL,
	[Deleted] [bit] NOT NULL DEFAULT (0),

	PRIMARY KEY CLUSTERED
	(
		[CurrencyID] ASC
	),
	UNIQUE NONCLUSTERED
	(
		[CurrencyCD] ASC
	)
)
GO
