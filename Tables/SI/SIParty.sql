----------------------------------------------------------------
-- SIParty
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[SIParty];
CREATE TABLE [dbo].[SIParty] --TODISCUSS if Naming is right 
(
	[CompanyID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),
	[CompanyCD] [nvarchar](30) NOT NULL,
	[Type] [char](1) NOT NULL,
	[Active] [bit] NOT NULL,
	[Description] [nvarchar](60) NULL,

	[CurrencyID] [nvarchar](5) NULL,
	[LegalName] [nvarchar](60) NULL,
	[TaxRegistrationID] [nvarchar](60) NULL,

	[DefaultAddressID] [uniqueidentifier] NULL,
	[DefaultContactID] [uniqueidentifier] NULL,

	[CreatedByUserID] [uniqueidentifier] NOT NULL,
	[CreatedFrom] [char](8) NOT NULL,
	[CreatedAtDateTime] [datetime] NOT NULL,
	[UpdatedByUserID] [uniqueidentifier] NOT NULL,
	[UpdatedFrom] [char](8) NOT NULL,
	[UpdatedAtDateTime] [datetime] NOT NULL,
	[Version] [rowversion] NULL,
	[JSON] [nvarchar](MAX) NULL,
	[Deleted] [bit] NOT NULL DEFAULT (0),

	PRIMARY KEY CLUSTERED
	(
		[CompanyID] ASC
	),
	UNIQUE NONCLUSTERED
	(
		[CompanyCD] ASC
	)
)
GO

----------------------------------------------------------------
-- SIPartyExt
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[SIPartyExt];
CREATE TABLE [dbo].[SIPartyExt](
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