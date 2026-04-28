----------------------------------------------------------------
-- SICountry
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[SICountry];
CREATE TABLE [dbo].[SICountry]
(
	[CountryID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),
	[CountryCD] [nvarchar](15) NOT NULL,
	[Description] [nvarchar](256) NULL,

	--Validation
	[CountryRegexp] [nvarchar](255) NULL,
	[ZipCodeRegexp] [nvarchar](255) NULL,
	[ZipCodeMask] [nvarchar](50) NULL,
	[IsTaxRegistrationRequired] [bit] NULL,
	[PhoneCountryCode] [nvarchar](5) NULL,
	[PhoneMask] [nvarchar](50) NULL,
	[PhoneRegexp] [nvarchar](255) NULL,

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

