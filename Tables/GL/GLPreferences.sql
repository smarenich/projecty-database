----------------------------------------------------------------
-- GLPreferences
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[GLPreferences];
CREATE TABLE [dbo].[GLPreferences] --TODO remove
(
	[PreferenceID] [uniqueidentifier] NOT NULL,
	[CompanyID] [uniqueidentifier] NULL, --Company Specific Setting

	[Name] [nvarchar](30) NOT NULL,
	[Type] [nvarchar](30) NOT NULL,
	[Description] [nvarchar](255) NOT NULL,

	[Value] [nvarchar](255) NOT NULL,

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
		[FieldID] ASC
	),
	UNIQUE NONCLUSTERED
	(
		[FieldName] ASC
	)
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