----------------------------------------------------------------
-- Numbering
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[SINumbering];
CREATE TABLE [dbo].[SINumbering]
(
	[NumberingID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),
	[NumberingCD] [nvarchar](20) NOT NULL,
	[Description] [nvarchar](60) NULL,
	[IsActive] [bit] NOT NULL DEFAULT (0),
	--[NewSymbol] [nvarchar](15) NULL,

	[CreatedByUserID] [uniqueidentifier] NOT NULL,
	[CreatedFrom] [char](8) NOT NULL,
	[CreatedAtDateTime] [datetime] NOT NULL,
	[UpdatedByUserID] [uniqueidentifier] NOT NULL,
	[UpdatedFrom] [char](8) NOT NULL,
	[UpdatedAtDateTime] [datetime] NOT NULL,
	[Version] [rowversion] NULL,
	[JSON] [nvarchar](MAX) NULL,
	[Deleted] [bit] NOT NULL DEFAULT (0),

	CONSTRAINT [SINumbering_PK] PRIMARY KEY CLUSTERED
	(
		[NumberingID] ASC
	),
	UNIQUE NONCLUSTERED
	(
		[NumberingCD] ASC
	)
)
GO  

----------------------------------------------------------------
-- NumberingSequence
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[NumberingSequence];
CREATE TABLE [dbo].[NumberingSequence]
(
	[NumberingID] [uniqueidentifier] NOT NULL,
	[NumberingSequenceID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),
	[SortOrder] [smallint] NULL,
  
	[BranchID] [int] NULL,
	[EffectiveDate] [smalldatetime] NULL,

	[StartNbr] [nvarchar](15) NOT NULL,
	[EndNbr] [nvarchar](15) NOT NULL,	
	[LastNbr] [nvarchar](15) NULL,
	[WarnNbr] [nvarchar](15) NOT NULL,
	[NbrStep] [int] NOT NULL,
	
	[CreatedByUserID] [uniqueidentifier] NOT NULL,
	[CreatedFrom] [char](8) NOT NULL,
	[CreatedAtDateTime] [datetime] NOT NULL,
	[UpdatedByUserID] [uniqueidentifier] NOT NULL,
	[UpdatedFrom] [char](8) NOT NULL,
	[UpdatedAtDateTime] [datetime] NOT NULL,

	PRIMARY KEY CLUSTERED
	(
		[NumberingID] ASC,
		[NumberingSequenceID] ASC
	)
)
GO