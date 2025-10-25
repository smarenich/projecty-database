----------------------------------------------------------------
-- Branch
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[CSBranch];
CREATE TABLE [dbo].[CSBranch]
(
	[BranchID] [int] IDENTITY NOT NULL,
	[BranchCD] [nvarchar](30) NOT NULL,
	[BAccountID] [int] NOT NULL,
	[Active] [bit] NOT NULL DEFAULT (1),

	[Type] [varchar](1) NOT NULL DEFAULT ('W'),
    [Status] [nchar](1) NOT NULL DEFAULT ('A'),

	--Ledger & Currency
	[LedgerID] [int] NULL,
	[BaseCuryID] [nvarchar](5) NOT NULL,

	--Settings
	[RoleName] [nvarchar](64) NULL,
	[CountryID] [nvarchar](2) NULL,
	[LogoName] [nvarchar](255) NULL,
	[LogoNameReport] [nvarchar](255) NULL,

	--System
	[CreatedByID] [uniqueidentifier] NOT NULL,
	[CreatedByScreenID] [char](8) NOT NULL,
	[CreatedDateTime] [datetime] NOT NULL,
	[LastModifiedByID] [uniqueidentifier] NOT NULL,
	[LastModifiedByScreenID] [char](8) NOT NULL,
	[LastModifiedDateTime] [datetime] NOT NULL,
	[Version] [rowversion] NULL,
	[JSON] [nvarchar](MAX) NULL,
	[GroupMask] [varbinary](32) NOT NULL DEFAULT (0x),
	[Deleted] [bit] NOT NULL DEFAULT (0),

	CONSTRAINT [CSBranch_PK] PRIMARY KEY CLUSTERED
	(
		[CSBranchID] ASC
	),
	UNIQUE NONCLUSTERED
	(
		[CSBranchCD] ASC
	),
	UNIQUE NONCLUSTERED
	(
		[CSCompanyID] ASC
	)
)
GO