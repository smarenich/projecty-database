----------------------------------------------------------------
-- SYRecordReference
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[SYRecordReference];
CREATE TABLE [dbo].[SYRecordReference]
(
	[SourceRecordID] [uniqueidentifier] NOT NULL,
	[DestRecordID] [uniqueidentifier] NOT NULL,

	CONSTRAINT [SYRecordReference_PK] PRIMARY KEY CLUSTERED
	(
		[SourceRecordID] ASC,
		[DestRecordID] ASC
	)
)
GO
CREATE UNIQUE NONCLUSTERED INDEX [SYRecordReference_UK] ON [dbo].[SYRecordReference]
(
	[DestRecordID] ASC,
	[SourceRecordID] ASC
)
GO
