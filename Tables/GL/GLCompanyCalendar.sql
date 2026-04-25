CREATE TABLE [dbo].[GLCompanyCalendar]
(
    [CompanyID] [uniqueidentifier] NOT NULL,
	--[FinancialCalendarID] [uniqueidentifier] NOT NULL,

	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NULL,  

	[PeriodType] [char](1) NOT NULL,  -- M=Monthly, Q=Quarterly, W=Weekly, F=4-4-5/4-5-4/5-4-4, --C=Custom



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

  
	CONSTRAINT [GGLCompanyCalendar_PK] PRIMARY KEY CLUSTERED
	(
		[CompanyID] ASC,
    [FinancialCalendarID] ASC
	),
)
