----------------------------------------------------------------
-- SYRecordTag
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[SYRecordTag];
CREATE TABLE [dbo].[SYRecordTag]
(
	[RecordID] [uniqueidentifier] NOT NULL,
	[TagID] [uniqueidentifier] NOT NULL,

	--System
	[CreatedByUserID] [uniqueidentifier] NOT NULL,
	[CreatedFrom] [char](8) NOT NULL,
	[CreatedAtDateTime] [datetime] NOT NULL,
	[UpdatedByUserID] [uniqueidentifier] NOT NULL,
	[UpdatedFrom] [char](8) NOT NULL,
	[UpdatedAtDateTime] [datetime] NOT NULL,
	[Version] [rowversion] NULL,

	CONSTRAINT [SYRecordTag_PK] PRIMARY KEY CLUSTERED
	(
		[RecordID] ASC,
		[TagID] ASC
	)
)
GO
