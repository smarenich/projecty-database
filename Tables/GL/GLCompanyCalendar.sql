DROP TABLE IF EXISTS [dbo].[GLCompanyCalendar];
CREATE TABLE [dbo].[GLCompanyCalendar]
(
	[FinancialCalendarID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),
    [CompanyID] [uniqueidentifier] NOT NULL,
	[Description] [nvarchar](60) NULL,

	[PeriodType] [char](1) NOT NULL,  -- M=Monthly, Q=Quarterly, W=Weekly, F=4-4-5/4-5-4/5-4-4, --C=Custom
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NULL,  --Null when the current configuration.

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

  
	CONSTRAINT [GLCompanyCalendar_PK] PRIMARY KEY CLUSTERED
	(
    	[FinancialCalendarID] ASC
	)
)
GO
CREATE NONCLUSTERED INDEX [GLCompanyCalendar_CompanyID_Index] ON [dbo].[GLCompanyCalendar] ([CompanyID], [FinancialCalendarID])
GO