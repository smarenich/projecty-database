----------------------------------------------------------------
-- Contact
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[SIContact];
CREATE TABLE [dbo].[SIContact]
(
	[ContactClass] [char](2) NOT NULL, --Company, APInvoice, Sales Order 
	[ContactID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),	

	[ParentRecordID] [uniqueidentifier] NOT NULL, --Contact should belong to some other entity
	[OrigContactID] [uniqueidentifier] NULL, --Reference to the contact, when it is a copy.

	[IsActive] [bit] NOT NULL DEFAULT (1),
	[Status] [char](1) NULL,
	[ContactType] [char](2) NULL,
	[AddressID] [int] NULL,
	[ExtRefNbr] [nvarchar](100) NULL,

	--Details
	[DisplayName] [nvarchar](255) NOT NULL,
	
	[Gender] [char](1) NULL,
	[MaritalStatus] [char](1) NULL,
	[Title] [nvarchar](50) NULL,
	[Salutation] [nvarchar](255) NULL,
	[Attention] [nvarchar](255) NULL,
	[FirstName] [nvarchar](50) NULL,
	[MidName] [nvarchar](50) NULL,
	[LastName] [nvarchar](100) NULL,
	[EMail] [nvarchar](255) NULL,
	[WebSite] [nvarchar](255) NULL,
	[Fax] [nvarchar](50) NULL,
	[FaxType] [varchar](3) NULL,
	[Phone1] [nvarchar](50) NULL,
	[Phone1Type] [varchar](3) NULL,
	[Phone2] [nvarchar](50) NULL,
	[Phone2Type] [varchar](3) NULL,
	[Phone3] [nvarchar](50) NULL,
	[Phone3Type] [varchar](3) NULL,
	[DateOfBirth] [smalldatetime] NULL,
	[LanguageID] [nvarchar](10) NULL,
	[Anniversary] [smalldatetime] NULL,
	[Spouse] [nvarchar](255) NULL,
	[Img] [nvarchar](max) NULL,

	--Categorization
	[SalesTerritoryID] [nvarchar](15) NULL,
	[Source] [char](1) NULL,
	[CampaignID] [nvarchar](15) NULL,

	--Preferences
	[NoFax] [bit] NOT NULL DEFAULT (0),
	[NoMail] [bit] NOT NULL DEFAULT (0),
	[NoMarketing] [bit] NOT NULL DEFAULT (0),
	[NoCall] [bit] NOT NULL DEFAULT (0),
	[NoEMail] [bit] NOT NULL DEFAULT (0),
	[NoMassMail] [bit] NOT NULL DEFAULT (0),

	--GDPR
	[ConsentAgreement] [bit] NULL DEFAULT (0),
	[ConsentDate] [smalldatetime] NULL,
	[ConsentExpirationDate] [smalldatetime] NULL,

	--System
	[CreatedByUserID] [uniqueidentifier] NOT NULL,
	[CreatedFrom] [char](8) NOT NULL,
	[CreatedAtDateTime] [datetime] NOT NULL,
	[UpdatedByUserID] [uniqueidentifier] NOT NULL,
	[UpdatedFrom] [char](8) NOT NULL,
	[UpdatedAtDateTime] [datetime] NOT NULL,
	[Version] [rowversion] NULL,
	[Deleted] [bit] NOT NULL DEFAULT (0),

	CONSTRAINT [SIContact_PK] PRIMARY KEY CLUSTERED
	(
		[ContactClass] ASC,
		[ContactID] ASC
	)
)
GO

CREATE NONCLUSTERED INDEX [SIContact_ReferenceEntity] ON [dbo].[SIContact]
(
	[ContactClass] ASC,
	[ParentRecordID] ASC
)
GO