DROP TABLE IF EXISTS [dbo].[CMCurrencyRateType];
CREATE TABLE [dbo].[CMCurrencyRateType]
(
	[CMCurrencyRateTypeID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),
	[CMCurrencyRateTypeCD] [nvarchar](5) NOT NULL,
  [Description] [nvarchar](512) NULL,

  [RefreshOnline] bit default 0 not null,
  --[OnlineRateAdjustment] decimal(19,8) null,
  [RateEffDays] smallint not null,

	--System
	[CreatedByUserID] [uniqueidentifier] NOT NULL,
	[CreatedFrom] [char](8) NOT NULL,
	[CreatedAtDateTime] [datetime] NOT NULL,
	[UpdatedByUserID] [uniqueidentifier] NOT NULL,
	[UpdatedFrom] [char](8) NOT NULL,
	[UpdatedAtDateTime] [datetime] NOT NULL,
	[Version] [rowversion] NULL,
	[Deleted] [bit] NOT NULL DEFAULT (0),

	CONSTRAINT [SIAddress_PK] PRIMARY KEY CLUSTERED
	(
		[CMCurrencyRateTypeID] ASC
	),
  CONSTRAINT [SIAddress_CMCurrencyRateType] UNIQUE NONCLUSTERED
  (
    [CMCurrencyRateTypeCD] ASC
  )
)
GO

