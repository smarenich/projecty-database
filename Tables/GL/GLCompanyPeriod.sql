----------------------------------------------------------------
-- GLCompanyPeriod
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[GLCompanyPeriod];
CREATE TABLE [dbo].[GLCompanyPeriod]
(
	[FinPeriodID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),
	[FinPeriodCD] [nvarchar](6) NOT NULL,
	[Description] [nvarchar](60) NULL,

	[CompanyID] [uniqueidentifier] NOT NULL,
	[Status] [char](1) NOT NULL,

	[StartDate] [smalldatetime] NOT NULL,
	[EndDate] [smalldatetime] NOT NULL,
	[FinYear] [char](4) NOT NULL,
	[PeriodNumber] [char](2) NOT NULL,

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
		[FinPeriodCD] ASC
	)
)
GO
