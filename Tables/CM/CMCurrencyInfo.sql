----------------------------------------------------------------
-- CMCurrencyInfo
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[CMCurrencyInfo];
CREATE TABLE [dbo].[CMCurrencyInfo]
(
	[CurrencyInfoID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),

	[CurrencyRateTypeID] [nvarchar](6) NULL,
	[FromCurrencyID] [nvarchar](5) NULL,
	[ToCurrencyID] [nvarchar](5) NULL,

	[EffDate] [smalldatetime] NULL,
	[MultDiv] [char](1) NULL,
	[Rate] [decimal](19, 8) NULL,
	[RecipRate] [decimal](19, 8) NULL,

	[CreatedByUserID] [uniqueidentifier] NOT NULL,
	[CreatedFrom] [char](8) NOT NULL,
	[CreatedAtDateTime] [datetime] NOT NULL,
	[UpdatedByUserID] [uniqueidentifier] NOT NULL,
	[UpdatedFrom] [char](8) NOT NULL,
	[UpdatedAtDateTime] [datetime] NOT NULL,
	[Version] [rowversion] NULL,
	[JSON] [nvarchar](MAX) NULL,

	CONSTRAINT [CMCurrencyInfo_PK] PRIMARY KEY CLUSTERED
	(
		[CurrencyInfoID] ASC
	)
)
GO
