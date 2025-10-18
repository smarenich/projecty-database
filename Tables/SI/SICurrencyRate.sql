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
	[EffectiveDate] [smalldatetime] NULL,
	[MultiplyDivide] [char](1) NULL,
	[Rate] [decimal](19, 8) NULL,
	[RateReciprocal] [decimal](19, 8) NULL,

	[CreatedByID] [uniqueidentifier] NOT NULL,
	[CreatedByScreenID] [char](8) NOT NULL,
	[CreatedDateTime] [datetime] NOT NULL,
	[LastModifiedByID] [uniqueidentifier] NOT NULL,
	[LastModifiedByScreenID] [char](8) NOT NULL,
	[LastModifiedDateTime] [datetime] NOT NULL,
	[Version] [rowversion] NULL,

	PRIMARY KEY CLUSTERED
	(
		[CurrencyRateID] ASC
	)
)
GO