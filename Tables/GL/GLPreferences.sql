----------------------------------------------------------------
-- GLPreferences
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[GLPreferences];
CREATE TABLE [dbo].[GLPreferences]
(
	[FieldID] [uniqueidentifier] NOT NULL,
	[FieldName] [varchar](30) NOT NULL,
	[FielType] [varchar](30) NOT NULL,

	[ValueNumeric] [decimal](28, 8) NULL,
	[ValueDate] [datetime] NULL,
	[ValueString] [nvarchar](256) NULL,
	[ValueText] [nvarchar](max) NULL,

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
--([FieldID], [FieldName], [FielType], [ValueNumeric], [ValueDate], [ValueString], [ValueText], [CreatedByUserID], [CreatedFrom], [CreatedAtDateTime], [UpdatedByUserID], [UpdatedFrom], [UpdatedAtDateTime])
--SELECT NEWID(), 'LedgerID','uniqueidentifier', NULL, NULL, NULL,NULL, '00000000-0000-0000-0000-000000000000','SYSTEM', GETUTCDATE(), '00000000-0000-0000-0000-000000000000', 'SYSTEM', GETUTCDATE()
--SELECT NEWID(), 'BatchNumberingID','uniqueidentifier', NULL, NULL, NULL,NULL, '00000000-0000-0000-0000-000000000000','SYSTEM', GETUTCDATE(), '00000000-0000-0000-0000-000000000000', 'SYSTEM', GETUTCDATE()
--SELECT NEWID(), 'RequireControlTotal','bit', NULL, NULL, NULL,NULL, '00000000-0000-0000-0000-000000000000','SYSTEM', GETUTCDATE(), '00000000-0000-0000-0000-000000000000', 'SYSTEM', GETUTCDATE()
--SELECT NEWID(), 'COAOrder','smallint', NULL, NULL, NULL,NULL, '00000000-0000-0000-0000-000000000000','SYSTEM', GETUTCDATE(), '00000000-0000-0000-0000-000000000000', 'SYSTEM', GETUTCDATE()
--SELECT NEWID(), 'TrialBalanceSign','char(1)', NULL, NULL, NULL,NULL, '00000000-0000-0000-0000-000000000000','SYSTEM', GETUTCDATE(), '00000000-0000-0000-0000-000000000000', 'SYSTEM', GETUTCDATE()
--SELECT NEWID(), 'YtdNetIncAccountID','uniqueidentifier', NULL, NULL, NULL,NULL, '00000000-0000-0000-0000-000000000000','SYSTEM', GETUTCDATE(), '00000000-0000-0000-0000-000000000000', 'SYSTEM', GETUTCDATE()
--SELECT NEWID(), 'RetEarnAccountID','uniqueidentifier', NULL, NULL, NULL,NULL, '00000000-0000-0000-0000-000000000000','SYSTEM', GETUTCDATE(), '00000000-0000-0000-0000-000000000000', 'SYSTEM', GETUTCDATE()