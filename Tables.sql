USE GeneralLedger
GO

----------------------------------------------------------------
-- xGLAccount 
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[xGLAccount];
CREATE TABLE [dbo].[xGLAccount](
	[TenantID] [int] NOT NULL,
	[AccountID] [uniqueidentifier] NOT NULL,
	[AccountCD] [nvarchar](30) NOT NULL,
	[Type] [char](1) NOT NULL,
	[Active] [bit] NOT NULL,
	[Description] [nvarchar](60) NULL,
	[DirectPost] [bit] NOT NULL,
	[CurrencyID] [nvarchar](5) NULL,

	[tstamp] [rowversion] NULL
PRIMARY KEY CLUSTERED
(
	[TenantID] ASC,
	[AccountID] ASC
))
GO
ALTER TABLE [dbo].[xGLAccount] ADD  DEFAULT (newsequentialid()) FOR [AccountID]
GO

----------------------------------------------------------------
-- xGLAccountExt 
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[xGLAccountExt];
CREATE TABLE [dbo].[xGLAccountExt](
	[TenantID] [int] NOT NULL,
	[RecordID] [uniqueidentifier] NOT NULL,
	[FieldName] [varchar](30) NOT NULL,
	[ValueNumeric] [decimal](28, 8) NULL,
	[ValueDate] [datetime] NULL,
	[ValueString] [nvarchar](256) NULL,
	[ValueText] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[TenantID] ASC,
	[RecordID] ASC,
	[FieldName] ASC
))
GO

----------------------------------------------------------------
-- xSICompany
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[xSICompany];
CREATE TABLE [dbo].[xSICompany](
	[TenantID] [int] NOT NULL,
	[CompanyID] [uniqueidentifier] NOT NULL,
	[CompanyCD] [nvarchar](30) NOT NULL,
	[Type] [char](1) NOT NULL,
	[Active] [bit] NOT NULL,
	[Description] [nvarchar](60) NULL,
	[CurrencyID] [nvarchar](5) NULL,

	[tstamp] [rowversion] NULL
PRIMARY KEY CLUSTERED
(
	[TenantID] ASC,
	[CompanyID] ASC
))
GO
ALTER TABLE [dbo].[xSICompany] ADD  DEFAULT (newsequentialid()) FOR [CompanyID]
GO

----------------------------------------------------------------
-- xSICompanyExt
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[xSICompanyExt];
CREATE TABLE [dbo].[xSICompanyExt](
	[TenantID] [int] NOT NULL,
	[RecordID] [uniqueidentifier] NOT NULL,
	[FieldName] [varchar](30) NOT NULL,
	[ValueNumeric] [decimal](28, 8) NULL,
	[ValueDate] [datetime] NULL,
	[ValueString] [nvarchar](256) NULL,
	[ValueText] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[TenantID] ASC,
	[RecordID] ASC,
	[FieldName] ASC
))
GO

----------------------------------------------------------------
-- xGLLedger
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[xGLLedger];
CREATE TABLE [dbo].[xGLLedger](
	[TenantID] [int] NOT NULL,
	[LedgerID] [uniqueidentifier] NOT NULL,
	[LedgerCD] [nvarchar](30) NOT NULL,
	[Type] [char](1) NOT NULL,
	[Description] [nvarchar](60) NULL,
	[BaseCurrencyID] [nvarchar](5) NULL,

	[tstamp] [rowversion] NULL
PRIMARY KEY CLUSTERED
(
	[TenantID] ASC,
	[LedgerID] ASC
))
GO
ALTER TABLE [dbo].[xGLLedger] ADD  DEFAULT (newsequentialid()) FOR [LedgerID]
GO

----------------------------------------------------------------
-- CurrencyInfo
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[xSICurrencyInfo];
CREATE TABLE [dbo].[xSICurrencyInfo](
	[TenantID] [int] NOT NULL,
	[CurrencyRateID] [uniqueidentifier] NOT NULL,

	[CurrencyRateTypeID] [nvarchar](6) NULL,
	[FromCurrencyID] [nvarchar](5) NULL,
	[ToCurrencyID] [nvarchar](5) NULL,
	
	[EffDate] [smalldatetime] NULL,
	[MultDiv] [char](1) NULL,
	[Rate] [decimal](19, 8) NULL,
	[RecipRate] [decimal](19, 8) NULL,
	--[BaseCalc] [bit] NOT NULL, ?

	[tstamp] [rowversion] NULL

CONSTRAINT [xSICurrencyInfo_PK] PRIMARY KEY CLUSTERED
(
	[TenantID]	 ASC,
	[CurrencyRateID] ASC
))
GO
ALTER TABLE [dbo].[xSICurrencyInfo] ADD  DEFAULT (newsequentialid()) FOR [CurrencyRateID]
GO

----------------------------------------------------------------
-- xGLTransactions
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[xGLTransactions];
CREATE TABLE [dbo].[xGLTransactions](
	TenantID [int] NOT NULL,
	RecordID [uniqueidentifier] NOT NULL,

	--References
	Module [char](2) NOT NULL,
	RefNumber [nvarchar](15) NOT NULL,
	LineNumber [int] NOT NULL,

	--Status
	Released [bit],
	Modified [bit],

	--Date
	TranDate [smalldatetime] not null,
	PostDate [smalldatetime] not null,

	--Transaction
	[BranchID] [uniqueidentifier] NOT NULL,
	[LedgerID] [uniqueidentifier] NOT NULL,
	[AccountID] [uniqueidentifier] NOT NULL,
	CurrencyID [nvarchar](5) NOT NULL,
	BaseCurrencyID [nvarchar](5) NULL,
	CurrencyRateID [uniqueidentifier] NOT NULL,
	DrCr [char](1) NOT NULL,
	BaseAmt [decimal] (28, 8),
	CurrencyAmt [decimal](28, 8),
	ConsoAmt [decimal] (28, 8),
	Quantity [decimal] (28, 8),

	--References
	CompanyID [uniqueidentifier]  NULL,
	JobID [uniqueidentifier]  NULL,
	EmployeeID [uniqueidentifier] NULL,
	InventoryID [uniqueidentifier] NULL,
	CostID [uniqueidentifier] NULL,
	AssetID [uniqueidentifier] NULL,
	ScheduleID [uniqueidentifier] NULL,
 
	--Transaction References. 
	-- Need to have many-to-many references
	-- Replace with Guids
	DocTypeL1 [char](3) NULL,
	DocRefNbrL1 [nvarchar](15) NULL,
	DocTypeL2 [char](3) NULL,
	DocRefNbrL2 [nvarchar](15) NULL,
	ExtRefNbr [nvarchar](30) NULL,

	[tstamp] [rowversion] NULL,
	--
	[Description] [nvarchar](255) NULL

PRIMARY KEY CLUSTERED
(
	[TenantID] ASC,
	[RecordID] ASC
))
GO
ALTER TABLE [dbo].[xGLTransactions] ADD  DEFAULT (newsequentialid()) FOR [RecordID]
GO
CREATE NONCLUSTERED INDEX [xGLTransactions_PostDate] ON [dbo].[xGLTransactions] ([TenantID], [PostDate], [BranchID], [LedgerID], [AccountID])
GO
CREATE NONCLUSTERED INDEX [xGLTransactions_Budget] ON [dbo].[xGLTransactions] ([TenantID],[BranchID],[LedgerID],[AccountID])
GO
CREATE NONCLUSTERED INDEX [xGLTransactions_Axis] ON dbo.xGLTransactions (TenantID, BranchID, LedgerID, AccountID) INCLUDE (RecordID)
GO

----------------------------------------------------------------
-- xGLTransactionsExt
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[xGLTransactionsExt];
CREATE TABLE [dbo].[xGLTransactionsExt](
	[TenantID] [int] NOT NULL,
	[RecordID] [uniqueidentifier] NOT NULL,
	[FieldName] [varchar](30) NOT NULL,
	[ValueNumeric] [decimal](28, 8) NULL,
	[ValueDate] [datetime] NULL,
	[ValueString] [nvarchar](256) NULL,
	[ValueText] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[TenantID] ASC,
	[RecordID] ASC,
	[FieldName] ASC
))
GO
CREATE NONCLUSTERED INDEX xGLTransactionsExt_ValueString ON [dbo].[xGLTransactionsExt] ([TenantID], [RecordID], [FieldName]) INCLUDE ([ValueString])
GO

----------------------------------------------------------------
-- xSIDates
----------------------------------------------------------------
DROP TABLE IF EXISTS dbo.xSIDate;
CREATE TABLE dbo.xSIDate
(
	[TenantID] [int] NOT NULL,
    [Date] [smalldatetime] NOT NULL,
	[Period] [char](6) NOT NULL
    CONSTRAINT PK_xSIDates PRIMARY KEY CLUSTERED (TenantID, Date)
)

----------------------------------------------------------------
-- xSIPeriods
----------------------------------------------------------------
DROP TABLE IF EXISTS dbo.xSIPeriod;
CREATE TABLE dbo.xSIPeriod
(
	[TenantID] [int] NOT NULL,
	[Period] [char](6) NOT NULL
    CONSTRAINT PK_xSIPeriods PRIMARY KEY CLUSTERED (TenantID, Period)
)
