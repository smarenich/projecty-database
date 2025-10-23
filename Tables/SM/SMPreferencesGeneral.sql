----------------------------------------------------------------
-- SMPreferencesGeneral
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[SMPreferencesGeneral];
CREATE TABLE [dbo].[SMPreferencesGeneral]
(
	[MaxUploadSize] [int] NOT NULL,
	[TimeZone] [varchar](32) NULL,
	[HomePage] [uniqueidentifier] NULL,
	[PersonNameFormat] [varchar](20) NULL,

	--System
	[CreatedByUserID] [uniqueidentifier] NOT NULL,
	[CreatedFrom] [char](8) NOT NULL,
	[CreatedAtDateTime] [datetime] NOT NULL,
	[UpdatedByUserID] [uniqueidentifier] NOT NULL,
	[UpdatedFrom] [char](8) NOT NULL,
	[UpdatedAtDateTime] [datetime] NOT NULL,
	[Version] [rowversion] NULL,
)
GO
