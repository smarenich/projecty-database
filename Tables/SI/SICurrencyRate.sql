----------------------------------------------------------------
-- CurrencyRate
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[SICurrencyRate];
CREATE TABLE [dbo].[SICurrencyRate]
(
	[CurrencyRateID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),
	
	[FromCurrencyID] [uniqueidentifier] NOT NULL,
	[ToCurrencyID] [uniqueidentifier] NOT NULL,
	[CurrencyRateType] [nvarchar](6) NULL,
	[EffectiveDate] [date] NULL,
	[MultiplyDivide] [char](1) NULL,
	[Rate] [decimal](21, 8) NULL,
	[RateReciprocal] [decimal](21, 8) NULL,

	[CreatedByUserID] [uniqueidentifier] NOT NULL,
	[CreatedFrom] [char](8) NOT NULL,
	[CreatedAtDateTime] [datetime] NOT NULL,
	[UpdatedByUserID] [uniqueidentifier] NOT NULL,
	[UpdatedFrom] [char](8) NOT NULL,
	[UpdatedAtDateTime] [datetime] NOT NULL,
	[Version] [rowversion] NULL,
	[JSON] [nvarchar](MAX) NULL,

	PRIMARY KEY CLUSTERED
	(
		[CurrencyRateID] ASC
	)
)
GO