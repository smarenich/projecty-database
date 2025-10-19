----------------------------------------------------------------
-- CMCurrency
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[CMCurrency];
CREATE TABLE [dbo].[CMCurrency]
(
	[CurrencyID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),
	[CurrencyCD] [nvarchar](5) NOT NULL,

	[RealizedGainAcctID] [int] NULL,
	[RealizedGainSubID] [int] NULL,
	[RealizedLossAcctID] [int] NULL,
	[RealizedLossSubID] [int] NULL,
	[RevaluationGainAcctID] [int] NULL,
	[RevaluationGainSubID] [int] NULL,
	[RevaluationLossAcctID] [int] NULL,
	[RevaluationLossSubID] [int] NULL,
	[TranslationGainAcctID] [int] NULL,
	[TranslationGainSubID] [int] NULL,
	[TranslationLossAcctID] [int] NULL,
	[TranslationLossSubID] [int] NULL,
	[UnrealizedGainAcctID] [int] NULL,
	[UnrealizedGainSubID] [int] NULL,
	[UnrealizedLossAcctID] [int] NULL,
	[UnrealizedLossSubID] [int] NULL,
	[RoundingGainAcctID] [int] NULL,
	[RoundingGainSubID] [int] NULL,
	[RoundingLossAcctID] [int] NULL,
	[RoundingLossSubID] [int] NULL,

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
