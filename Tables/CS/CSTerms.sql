----------------------------------------------------------------
-- CSTerms
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[CSTerms];
CREATE TABLE [dbo].[CSTerms]
(
	[TermsID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),
	[TermsCD] [nvarchar](5) NOT NULL,
	[Description] [nvarchar](60) NULL,

	[DueType] [char](1) NOT NULL,
	[DayFrom] [smallint] NOT NULL,
	[DayTo] [smallint] NOT NULL,
	[DayDue] [smallint] NOT NULL,
	[DiscType] [char](1) NOT NULL,
	[DayDisc] [smallint] NOT NULL,
	[DiscPercent] [decimal](9, 6) NULL,
	[InstallmentType] [char](1) NOT NULL,
	[InstallmentCounter] [smallint] NOT NULL,
	[InstallmentFreq] [char](1) NOT NULL,
	[InstallmentMethod] [char](1) NOT NULL,

	[VisibleTo] [char](2) NOT NULL DEFAULT ('AL'),

	--System
	[CreatedByUserID] [uniqueidentifier] NOT NULL,
	[CreatedFrom] [char](8) NOT NULL,
	[CreatedAtDateTime] [datetime] NOT NULL,
	[UpdatedByUserID] [uniqueidentifier] NOT NULL,
	[UpdatedFrom] [char](8) NOT NULL,
	[UpdatedAtDateTime] [datetime] NOT NULL,
	[Version] [rowversion] NULL,
	[Deleted] [bit] NOT NULL DEFAULT (0),

	CONSTRAINT [CSTerms_PK] PRIMARY KEY CLUSTERED
	(
		[TermsID] ASC
	),
	UNIQUE NONCLUSTERED
	(
		[TermsCD] ASC
	)
)
GO
