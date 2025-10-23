----------------------------------------------------------------
-- SYDataType
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[SYDataType];
CREATE TABLE [dbo].[SYDataType]
(
	[DataTypeID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),
	[DataTypeCD] [nvarchar](10) NOT NULL,
	[Description] [varchar](255) NULL,

	[Type] [varchar](255) NULL,

	--System
	[Version] [rowversion] NULL,

	CONSTRAINT [SYDataType_PK] PRIMARY KEY CLUSTERED
	(
		[DataTypeID] ASC
	),
	UNIQUE NONCLUSTERED
	(
		[DataTypeCD] ASC
	)
)
GO
