----------------------------------------------------------------
-- SMTag
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[SMTag];
CREATE TABLE [dbo].[SMTag]
(
	[TagID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),
	[TagCD] [nvarchar](15) NOT NULL,

	[Type] [char](64) NULL, --Group of entities aby applicable scenarios 
		--Examples: Account, Warehouse, Cases, All Documents
		--TOREVIEW Include in key?
		--TOREVIEW Can be multiple types? Check Dualentry!
	

	[Color] [char](6) NULL,
	[Description] [nvarchar](256) NULL,

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

	CONSTRAINT [SMTag_PK] PRIMARY KEY CLUSTERED
	(
		[TagID] ASC
	),
	UNIQUE NONCLUSTERED
	(
		[TagCD] ASC
	)
)
GO
