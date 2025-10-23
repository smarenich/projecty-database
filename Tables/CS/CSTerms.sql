----------------------------------------------------------------
-- CMCurrency
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[CSTerms];
CREATE TABLE [dbo].[CSTerms]
(
	[TermsID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),
	[TermsCD] [nvarchar](5) NOT NULL,
  [Description] nvarchar(60) null,

  [DueType] char(1) not null,
  [DayFrom] smallint not null,
  [DayTo] smallint not null,
  [DayDue] smallint not null,
  [DiscType] char(1) not null,
  [DayDisc] smallint not null,
  [DiscPercent] decimal(9,6) null,
  [InstallmentType] char(1) not null,
  [InstallmentCntr] smallint not null,
  [InstallmentFreq] char(1) not null,
  [InstallmentMthd] char(1) not null,
  
  [VisibleTo] char(2) default 'AL' not null,

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
		[TermsID] ASC
	),
	UNIQUE NONCLUSTERED
	(
		[TermsCD] ASC
	)
)
GO
