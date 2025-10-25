----------------------------------------------------------------
-- CAPaymentMethod
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[CAPaymentMethod];
CREATE TABLE [dbo].[CAPaymentMethod]
(
	[PaymentMethodID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),
	[PaymentMethodCD] [nvarchar](10) NOT NULL,
	[Description] [nvarchar](60) NULL,

	[IsActive] [bit] NOT NULL DEFAULT (1),
	[PaymentType] [char](1) NOT NULL,
	[UseInAP] [bit] NOT NULL DEFAULT (0),
	[UseInAR] [bit] NOT NULL DEFAULT (0),

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

	CONSTRAINT [CAPaymentMethod_PK] PRIMARY KEY CLUSTERED
	(
		[PaymentMethodID] ASC
	),
	UNIQUE NONCLUSTERED
	(
		[PaymentMethodCD] ASC
	)
)
GO
