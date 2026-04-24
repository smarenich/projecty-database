-- Add Fin Calendar setup table. Type with Start date
-- Check how custom fin peridos are used.
-- Fin periods should be generated automatically.
-- Fin Calendar setup should be based on types - month, quarter, 
-- Holes in the period ? What to do.
-- Calendars should be with effective dates of the calendar.

-- Do we need a process of opening periods?
-- Generate periods on the opening of periods.



CREATE TABLE [dbo].[GLFinCalendar]
(
  [FinCalendarID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),
	[FinCalendarCD] [nvarchar](15) NOT NULL,
	[Description] [nvarchar](60) NULL,




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
