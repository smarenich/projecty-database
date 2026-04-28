----------------------------------------------------------------
-- GLCompanyPeriod
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[GLCompanyPeriod];
CREATE TABLE [dbo].[GLCompanyPeriod]
(
	[FinPeriodID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),
	[FinPeriodCD] [nvarchar](6) NOT NULL,

	[CompanyID] [uniqueidentifier] NOT NULL, --Foreign Key to Company
	[FinancialCalendarID] [uniqueidentifier] NOT NULL, --Foreign Key to Company
	[Description] [nvarchar](60) NULL,

	[StartDate] [smalldatetime] NOT NULL,
	[EndDate] [smalldatetime] NOT NULL,
	[FinYear] [char](4) NOT NULL,
	[PeriodNumber] [char](2) NOT NULL,

	[Status] [char](1) NOT NULL,
	[APStatus] [char](1) NOT NULL DEFAULT (0),
	[ARStatus] [char](1) NOT NULL DEFAULT (0),
	[INStatus] [char](1) NOT NULL DEFAULT (0),
	[CAStatus] [char](1) NOT NULL DEFAULT (0),
	--[FAStatus] [char](1) NOT NULL DEFAULT (0),


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

	CONSTRAINT [GLCompanyPeriod_PK] PRIMARY KEY CLUSTERED
	(
		[FinPeriodID] ASC
	),
	UNIQUE NONCLUSTERED
	(
		[CompanyID] ASC,
		[FinPeriodCD] ASC
	)
)
GO
CREATE NONCLUSTERED INDEX [GLCompanyPeriod_Date_Index] ON [dbo].[GLCompanyPeriod] ([CompanyID], [StartDate], [EndDate])
GO