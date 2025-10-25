----------------------------------------------------------------
-- SMPreferencesSecurity
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[SMPreferencesSecurity];
CREATE TABLE [dbo].[SMPreferencesSecurity]
(
	[PasswordDayAge] [int] NOT NULL DEFAULT (0),
	[PasswordMinLength] [int] NOT NULL DEFAULT (3),
	[PasswordComplexity] [bit] NOT NULL DEFAULT (0),
	[PasswordRegexCheck] [varchar](250) NULL,
	[PasswordRegexCheckMessage] [varchar](500) NULL,
	[AccountLockoutThreshold] [int] NOT NULL DEFAULT (3),
	[AccountLockoutDuration] [int] NOT NULL DEFAULT (15),
	[AccountLockoutReset] [int] NOT NULL DEFAULT (10),
	[PasswordSecurityType] [smallint] NOT NULL DEFAULT (0),
	[MultiFactorAuthLevel] [int] NOT NULL DEFAULT (0),
	[MultiFactorAllowedTypes] [int] NOT NULL DEFAULT (3),

	--System
	[CreatedByUserID] [uniqueidentifier] NOT NULL,
	[CreatedFrom] [char](8) NOT NULL,
	[CreatedAtDateTime] [datetime] NOT NULL,
	[UpdatedByUserID] [uniqueidentifier] NOT NULL,
	[UpdatedFrom] [char](8) NOT NULL,
	[UpdatedAtDateTime] [datetime] NOT NULL,
	[Version] [rowversion] NULL,
	[JSON] [nvarchar](MAX) NULL,
)
GO
