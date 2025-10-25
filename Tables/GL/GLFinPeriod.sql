----------------------------------------------------------------
-- GLFinPeriod
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[GLFinPeriod];
CREATE TABLE [dbo].[GLFinPeriod]
(
	[FinPeriodID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),
	[FinPeriodCD] [nvarchar](5) NOT NULL,
	[Description] [nvarchar](60) NULL,

	[OrganizationID] [uniqueidentifier] NOT NULL,
	[Status] [char](1) NOT NULL,

	[StartDate] [smalldatetime] NOT NULL,
	[EndDate] [smalldatetime] NOT NULL,
	[FinYear] [char](4) NOT NULL,
	[PeriodNumber] [char](2) NOT NULL,

	[APClosed] [bit] NOT NULL DEFAULT (0),
	[ARClosed] [bit] NOT NULL DEFAULT (0),
	[INClosed] [bit] NOT NULL DEFAULT (0),
	[CAClosed] [bit] NOT NULL DEFAULT (0),
	[FAClosed] [bit] NOT NULL DEFAULT (0),
	[PRClosed] [bit] NOT NULL DEFAULT (0),

	--System
	[CreatedByUserID] [uniqueidentifier] NOT NULL,
	[CreatedFrom] [char](8) NOT NULL,
	[CreatedAtDateTime] [datetime] NOT NULL,
	[UpdatedByUserID] [uniqueidentifier] NOT NULL,
	[UpdatedFrom] [char](8) NOT NULL,
	[UpdatedAtDateTime] [datetime] NOT NULL,
	[Version] [rowversion] NULL,
	[JSON] [nvarchar](MAX) NULL,
	[Deleted] [bit] NOT NULL DEFAULT (0),

	CONSTRAINT [GLFinPeriod_PK] PRIMARY KEY CLUSTERED
	(
		[FinPeriodID] ASC
	),
	UNIQUE NONCLUSTERED
	(
		[FinPeriodCD] ASC
	)
)
GO
