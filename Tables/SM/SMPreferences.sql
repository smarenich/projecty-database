----------------------------------------------------------------
-- SMPreferencesDefinition
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[SMPreferencesDefinition];
CREATE TABLE [dbo].[SMPreferencesDefinition]
(
	[PreferenceID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),

	[Name] [nvarchar](30) NOT NULL,
	[Category] [nvarchar](30) NOT NULL,       --Read dynamically from JSON? Or dynamically update during database update procedure?
	[DataType] [nvarchar](30) NOT NULL,	      --Read dynamically from JSON? Or dynamically update during database update procedure?
	[Description] [nvarchar](256) NOT NULL,	  --Read dynamically from JSON? Or dynamically update during database update procedure?
	[Tooltip] [nvarchar](MAX) NOT NULL,       --Read dynamically from JSON? Or dynamically update during database update procedure?

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
	[CompanyID] [uniqueidentifier] NULL, --Company Specific Setting, NULL is global setting

	[ParentCompanyID] [uniqueidentifier] NULL, --Take the value from the ParentCompanyID
	[Value] [jsonb] NULL,

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

--INSERT INTO [dbo].[GLPreferences]
--([PreferenceID], [CompanyID] [Name], [Type], [Description], [Value], [CreatedByUserID], [CreatedFrom], [CreatedAtDateTime], [UpdatedByUserID], [UpdatedFrom], [UpdatedAtDateTime])
--SELECT NEWID(), NULL, 'BatchNumberingID','uniqueidentifier', NULL, NULL, '00000000-0000-0000-0000-000000000000','SYSTEM', GETUTCDATE(), '00000000-0000-0000-0000-000000000000', 'SYSTEM', GETUTCDATE()
--SELECT NEWID(), NULL, 'RequireControlTotal','bit', NULL, NULL, '00000000-0000-0000-0000-000000000000','SYSTEM', GETUTCDATE(), '00000000-0000-0000-0000-000000000000', 'SYSTEM', GETUTCDATE()
--SELECT NEWID(), NULL, 'COAOrder','smallint', NULL, NULL, NULL, '00000000-0000-0000-0000-000000000000','SYSTEM', GETUTCDATE(), '00000000-0000-0000-0000-000000000000', 'SYSTEM', GETUTCDATE()
--SELECT NEWID(), NULL, 'TrialBalanceSign','char(1)', NULL, NULL, '00000000-0000-0000-0000-000000000000','SYSTEM', GETUTCDATE(), '00000000-0000-0000-0000-000000000000', 'SYSTEM', GETUTCDATE()
--SELECT NEWID(), NULL, 'YtdNetIncAccountID','uniqueidentifier', NULL, NULL, '00000000-0000-0000-0000-000000000000','SYSTEM', GETUTCDATE(), '00000000-0000-0000-0000-000000000000', 'SYSTEM', GETUTCDATE()
--SELECT NEWID(), NULL, 'RetEarnAccountID','uniqueidentifier', NULL, NULL, '00000000-0000-0000-0000-000000000000','SYSTEM', GETUTCDATE(), '00000000-0000-0000-0000-000000000000', 'SYSTEM', GETUTCDATE()