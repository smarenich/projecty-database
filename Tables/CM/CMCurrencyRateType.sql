----------------------------------------------------------------
-- CMCurrencyRateType
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[CMCurrencyRateType];
CREATE TABLE [dbo].[CMCurrencyRateType]
(
	[CMCurrencyRateTypeID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),
	[CMCurrencyRateTypeCD] [nvarchar](5) NOT NULL,
	[Description] [nvarchar](512) NULL,

	[RefreshOnline] [bit] NOT NULL DEFAULT (0),
	--[OnlineRateAdjustment] [decimal](19,8) NULL,
	[RateEffDays] [smallint] NOT NULL,

	--System
	[CreatedByUserID] [uniqueidentifier] NOT NULL,
	[CreatedFrom] [char](8) NOT NULL,
	[CreatedAtDateTime] [datetime] NOT NULL,
	[UpdatedByUserID] [uniqueidentifier] NOT NULL,
	[UpdatedFrom] [char](8) NOT NULL,
	[UpdatedAtDateTime] [datetime] NOT NULL,
	[Version] [rowversion] NULL,
	[JSON] [nvarchar](MAX) NULL,
	[Deleted] [bit] NOT NULL DEFAULT (0),

	CONSTRAINT [CMCurrencyRateType_PK] PRIMARY KEY CLUSTERED
	(
		[CMCurrencyRateTypeID] ASC
	),
	CONSTRAINT [CMCurrencyRateType_UK] UNIQUE NONCLUSTERED
	(
		[CMCurrencyRateTypeCD] ASC
	)
)
GO

