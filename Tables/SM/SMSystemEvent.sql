----------------------------------------------------------------
-- SMSystemEvent
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[SMSystemEvent];
CREATE TABLE [dbo].[SMSystemEvent]
(
	[EventID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),
	[Date] [datetime] NOT NULL,
	[Level] [int] NOT NULL,
	[Source] [nvarchar](64) NOT NULL,
	[ScreenID] [varchar](128) NULL,
	[User] [nvarchar](64) NULL,
	[Details] [nvarchar](max) NOT NULL,
	[Properties] [nvarchar](max) NOT NULL,

	CONSTRAINT [SMSystemEvent_PK] PRIMARY KEY CLUSTERED
	(
		[EventID] ASC
	)
)
GO
CREATE NONCLUSTERED INDEX [SMSystemEvent_Date] ON [dbo].[SMSystemEvent] ([Date] DESC)
GO
CREATE NONCLUSTERED INDEX [SMSystemEvent_Level] ON [dbo].[SMSystemEvent] ([Level] ASC)
GO
CREATE NONCLUSTERED INDEX [SMSystemEvent_Source] ON [dbo].[SMSystemEvent] ([Source] ASC)
GO