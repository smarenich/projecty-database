----------------------------------------------------------------
-- SMPreferencesDefinition
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[SMPreferencesDefinition];
CREATE TABLE [dbo].[SMPreferencesDefinition]
(
	[PreferenceID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),

	[Name] [nvarchar](30) NOT NULL,

	[Category] [nvarchar](30) NOT NULL,       --Dynamically insert/update during database update procedure.
	[DataType] [nvarchar](30) NOT NULL,	      --Dynamically insert/update during database update procedure.
	[Description] [nvarchar](256) NOT NULL,	  --Dynamically insert/update during database update procedure.
	[Tooltip] [nvarchar](MAX) NOT NULL,       --Dynamically insert/update during database update procedure.

	[DefaultValue] [json] NULL,

	CONSTRAINT [GLPreferences_PK] PRIMARY KEY CLUSTERED
	(
		[PreferenceID] ASC
	),
	UNIQUE NONCLUSTERED
	(
		[Name] ASC
	)
)
GO

----------------------------------------------------------------
-- SMPreferencesValue
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[SMPreferencesValue];
CREATE TABLE [dbo].[SMPreferencesValue]
(
	[PreferenceID] [uniqueidentifier] NOT NULL, --Reference to SMPreferencesDefinition
	[CompanyID] [uniqueidentifier] NOT NULL, --Company Specific Setting, NULL is global setting

	[DependOnCompanyID] [uniqueidentifier] NOT NULL, --Automatically update the setting when the parent company setting is updated.
	[Value] [json] NULL,

	--System
	[CreatedByUserID] [uniqueidentifier] NOT NULL,
	[CreatedFrom] [char](8) NOT NULL,
	[CreatedAtDateTime] [datetime] NOT NULL,
	[UpdatedByUserID] [uniqueidentifier] NOT NULL,
	[UpdatedFrom] [char](8) NOT NULL,
	[UpdatedAtDateTime] [datetime] NOT NULL,
	[Version] [rowversion] NULL,

	CONSTRAINT [GLPreferences_PK] PRIMARY KEY CLUSTERED
	(
		[PreferenceID] ASC,
		[CompanyID] ASC
	),
)
GO

--Examples of Preferences
-- - BatchNumberingID
-- - RequireControlTotal
-- - COAOrder
-- - TrialBalanceSign
-- - YtdNetIncAccountID
-- - RetEarnAccountID