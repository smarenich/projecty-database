

----------------------------------------------------------------
-- SICompany
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[SICompany];
CREATE TABLE [dbo].[SICompany](
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
ALTER TABLE [dbo].[SICompany] ADD  DEFAULT (newsequentialid()) FOR [CompanyID]
GO

----------------------------------------------------------------
-- SICompanyExt
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[SICompanyExt];
CREATE TABLE [dbo].[SICompanyExt](
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
-- SICurrencyInfo
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[SICurrencyInfo];
CREATE TABLE [dbo].[SICurrencyInfo](
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

CONSTRAINT [SICurrencyInfo_PK] PRIMARY KEY CLUSTERED
(
	[TenantID]	 ASC,
	[CurrencyRateID] ASC
))
GO
ALTER TABLE [dbo].[SICurrencyInfo] ADD  DEFAULT (newsequentialid()) FOR [CurrencyRateID]
GO

----------------------------------------------------------------
-- SIDates
----------------------------------------------------------------
DROP TABLE IF EXISTS dbo.SIDate;
CREATE TABLE dbo.SIDate
(
	[TenantID] [int] NOT NULL,
    [Date] [smalldatetime] NOT NULL,
	[Period] [char](6) NOT NULL
    CONSTRAINT PK_SIDates PRIMARY KEY CLUSTERED (TenantID, Date)
)

----------------------------------------------------------------
-- SIPeriods
----------------------------------------------------------------
DROP TABLE IF EXISTS dbo.SIPeriod;
CREATE TABLE dbo.SIPeriod
(
	[TenantID] [int] NOT NULL,
	[Period] [char](6) NOT NULL
    CONSTRAINT PK_SIPeriods PRIMARY KEY CLUSTERED (TenantID, Period)
)
