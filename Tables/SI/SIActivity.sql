----------------------------------------------------------------
-- Activity
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[SIActivity];
CREATE TABLE [dbo].[SIActivity]
(
	[ActivityID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),

	[ParentRecordID] [uniqueidentifier] NOT NULL, --Activity should belong to some other entity
	[ActivityType] [char](2) NOT NULL, --Email, Call, Meeting, Task, Note
	--[ActivityClassID] [char](2) NOT NULL,
	[RefDocumentID] [uniqueidentifier] NULL, --Activity may refer to the other document, ex: email, task

	[Subject] [nvarchar](998) NULL,
	[Body] [ntext] NULL,

	[Priority] [char](1) NULL, --H=High, M=Medium, L=Low
	[Status] [char](1) NULL, --N=New, P=In Progress, C=Completed, X=Cancelled
	[OwnerID] [uniqueidentifier] NULL,
	[WorkgroupID] [uniqueidentifier] NULL,

	[TimeZone] [varchar](32) NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[DueDate] [datetime] NULL,
	[CompletedDate] [datetime] NULL,
	[AllDay] [bit] NULL,

	--References
	[CompanyID] [uniqueidentifier] NULL,
	[ContactID] [uniqueidentifier] NULL,
	[JobID] [uniqueidentifier]  NULL,	
	[EmployeeID] [uniqueidentifier] NULL,

	--System
	[CreatedByUserID] [uniqueidentifier] NOT NULL,
	[CreatedFrom] [char](8) NOT NULL,
	[CreatedAtDateTime] [datetime] NOT NULL,
	[UpdatedByUserID] [uniqueidentifier] NOT NULL,
	[UpdatedFrom] [char](8) NOT NULL,
	[UpdatedAtDateTime] [datetime] NOT NULL,
	[Version] [rowversion] NULL,
	[Deleted] [bit] NOT NULL DEFAULT (0),

	CONSTRAINT [SIActivity_PK] PRIMARY KEY CLUSTERED
	(
		[ActivityID] ASC
	)
)
GO
CREATE NONCLUSTERED INDEX [SIActivity_ReferenceEntity] ON [dbo].[SIActivity]
(
	[ParentRecordID] ASC,
	[ActivityID] ASC
)
GO
CREATE NONCLUSTERED INDEX [SIActivity_CompanyID] ON [dbo].[SIActivity]
(
	[CompanyID] ASC,
	[ActivityID] ASC
)
GO
CREATE NONCLUSTERED INDEX [SIActivity_JobID] ON [SIActivity] 
(
  [JobID] ASC,
  [ActivityID] ASC
)
GO
CREATE NONCLUSTERED INDEX [SIActivity_EmployeeID] ON [SIActivity] 
(
  [EmployeeID] ASC,
  [ActivityID] ASC
)
GO
CREATE NONCLUSTERED INDEX [SIActivity_ContactID] ON [SIActivity] 
(
  [ContactID] ASC,
  [ActivityID] ASC
)
GO