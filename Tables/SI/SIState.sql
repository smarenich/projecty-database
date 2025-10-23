----------------------------------------------------------------
-- SIState
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[SIState];
CREATE TABLE [dbo].[SIState]
(
	[StateID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),
	[CountryID] [nvarchar](2) NOT NULL,
	[StateCD] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](60) NULL,

	--System
	[CreatedByUserID] [uniqueidentifier] NOT NULL,
	[CreatedFrom] [char](8) NOT NULL,
	[CreatedAtDateTime] [datetime] NOT NULL,
	[UpdatedByUserID] [uniqueidentifier] NOT NULL,
	[UpdatedFrom] [char](8) NOT NULL,
	[UpdatedAtDateTime] [datetime] NOT NULL,
	[Version] [rowversion] NULL,
	[Deleted] [bit] NOT NULL DEFAULT (0),

	CONSTRAINT [SIState_PK] PRIMARY KEY CLUSTERED
	(
		[StateID] ASC
	),
	CONSTRAINT [SIState_UK] UNIQUE NONCLUSTERED
	(
		[CountryID] ASC,
		[StateCD] ASC
	)
)
GO
CREATE NONCLUSTERED INDEX [SIState_Country] ON [dbo].[SIState] ([CountryID])
GO
