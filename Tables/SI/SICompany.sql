----------------------------------------------------------------
-- SICompany
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[SICompany];
CREATE TABLE [dbo].[SICompany]
(
	[CompanyID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),
	[CompanyCD] [nvarchar](30) NOT NULL,
	[Type] [char](1) NOT NULL,
	[Active] [bit] NOT NULL,
	[Description] [nvarchar](60) NULL,
	[CurrencyID] [nvarchar](5) NULL,

	[CreatedByUserID] [uniqueidentifier] NOT NULL,
	[CreatedFrom] [char](8) NOT NULL,
	[CreatedAtDateTime] [datetime] NOT NULL,
	[UpdatedByUserID] [uniqueidentifier] NOT NULL,
	[UpdatedFrom] [char](8) NOT NULL,
	[UpdatedAtDateTime] [datetime] NOT NULL,
	[Version] [rowversion] NULL,
	[Deleted] [bit] NOT NULL,


	PRIMARY KEY CLUSTERED
	(
		[CompanyID] ASC
	)
)
GO

----------------------------------------------------------------
-- SICompanyExt
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[SICompanyExt];
CREATE TABLE [dbo].[SICompanyExt](
	[RecordID] [uniqueidentifier] NOT NULL,
	[FieldName] [varchar](30) NOT NULL,
	[ValueNumeric] [decimal](28, 8) NULL,
	[ValueDate] [datetime] NULL,
	[ValueString] [nvarchar](256) NULL,
	[ValueText] [nvarchar](max) NULL,
	PRIMARY KEY CLUSTERED
	(
		[RecordID] ASC,
		[FieldName] ASC
	)
)
GO