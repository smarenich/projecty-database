----------------------------------------------------------------
-- GLFinPeriod
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[GLFinPeriod];
CREATE TABLE [dbo].[GLFinPeriod]
(
  [FinPeriodID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),
	[FinPeriodCD] [nvarchar](5) NOT NULL,
  [Description] nvarchar(60) null,

  [OrganizationID] int not null,
  [Status] char(1) not null,

  [StartDate] smalldatetime not null,
  [EndDate] smalldatetime not null,
  [FinYear] char(4) not null,
  [PeriodNbr] char(2) not null,

  [APClosed] bit default 0 not null,
  [ARClosed] bit default 0 not null,
  [INClosed] bit default 0 not null,
  [CAClosed] bit default 0 not null,
  [FAClosed] bit default 0 not null,
  [PRClosed] bit default 0 not null,

  	--System
	[CreatedByUserID] [uniqueidentifier] NOT NULL,
	[CreatedFrom] [char](8) NOT NULL,
	[CreatedAtDateTime] [datetime] NOT NULL,
	[UpdatedByUserID] [uniqueidentifier] NOT NULL,
	[UpdatedFrom] [char](8) NOT NULL,
	[UpdatedAtDateTime] [datetime] NOT NULL,
	[Version] [rowversion] NULL,
	[Deleted] [bit] NOT NULL DEFAULT (0),

	PRIMARY KEY CLUSTERED
	(
		[FinPeriodID] ASC
	),
	UNIQUE NONCLUSTERED
	(
		[FinPeriodCD] ASC
	)
)
