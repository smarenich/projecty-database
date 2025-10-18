----------------------------------------------------------------
-- SICurrencyInfo
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[SICurrencyRate];
CREATE TABLE [dbo].[SICurrencyRate]
(
	[CurrencyRateID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),

	[CurrencyRateTypeID] [nvarchar](6) NULL,
	[FromCurrencyID] [nvarchar](5) NULL,
	[ToCurrencyID] [nvarchar](5) NULL,
	
	[EffDate] [smalldatetime] NULL,
	[MultDiv] [char](1) NULL,
	[Rate] [decimal](19, 8) NULL,
	[RecipRate] [decimal](19, 8) NULL,
	--[BaseCalc] [bit] NOT NULL, ?

	[Version] [rowversion] NULL

CONSTRAINT [SICurrencyInfo_PK] PRIMARY KEY CLUSTERED
(
	[CurrencyRateID] ASC
))
GO
