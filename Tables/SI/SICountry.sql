----------------------------------------------------------------
-- SICountry
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[SICountry];
CREATE TABLE [dbo].[SICountry]
(
	[CountryID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),
	[CountryCD] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](60) NULL,

	--Validation
	[CountryRegexp] [nvarchar](255) NULL,
	[ZipCodeRegexp] [varchar](255) NULL,
	[ZipCodeMask] [varchar](50) NULL,
	[IsTaxRegistrationRequired] [bit] NULL,
	[PhoneCountryCode] [varchar](5) NULL,
	[PhoneMask] [varchar](50) NULL,
	[PhoneRegexp] [varchar](255) NULL,

	--Address
	[AddressValidatorPluginID] [nvarchar](15) NULL,
	[AutoOverrideAddress] [bit] NOT NULL DEFAULT (0),
	[SalesTerritoryID] [nvarchar](15) NULL,

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

	CONSTRAINT [SICountry_PK] PRIMARY KEY CLUSTERED
	(
		[CountryID] ASC
	),
	CONSTRAINT [SICountry_UK] UNIQUE NONCLUSTERED
	(
		[CountryCD] ASC
	)
)
GO

