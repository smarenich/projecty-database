DROP TABLE IF EXISTS [dbo].[CAPaymentMethod];
CREATE TABLE [dbo].[CAPaymentMethod]
(
	[CurrencyID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),
	[CurrencyCD] [nvarchar](5) NOT NULL,

  --System
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
