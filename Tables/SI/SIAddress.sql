----------------------------------------------------------------
-- Address
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[SIAddress];
CREATE TABLE [dbo].[SIAddress]
(
	[AddressClass] [char](2) NOT NULL, --Company, APInvoice, Sales Order 
	[AddressID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),	

	[ParentRecordID] [uniqueidentifier] NOT NULL, --Address should belong to some other entity
	[OrigAddressID] [uniqueidentifier] NULL, --Reference to the address, when it is a copy.

	[IsActive] [bit] NOT NULL DEFAULT (1),
	[AddressType] [char](2) NOT NULL, --Home, Business, Other
	[AddressLine1] [nvarchar](50) NULL,
	[AddressLine2] [nvarchar](50) NULL,
	[AddressLine3] [nvarchar](50) NULL,
	[City] [nvarchar](50) NULL,
	[State] [nvarchar](50) NULL,
	[CountryID] [nvarchar](2) NULL,

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

	CONSTRAINT [SIAddress_PK] PRIMARY KEY CLUSTERED
	(
		[AddressClass] ASC,
		[AddressID] ASC
	),
)
GO

CREATE NONCLUSTERED INDEX [SIAddress_ReferenceEntity] ON [dbo].[SIAddress]
(
	[AddressClass] ASC,
	[ParentRecordID] ASC
)
GO