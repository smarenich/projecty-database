DROP TABLE IF EXISTS [dbo].[SYCustomField];
CREATE TABLE [dbo].[SYCustomField]
(
  [CustomFieldID] [uniqueidentifier] NOT NULL,
  [CustomFieldCD] [nvarchar](10) NOT NULL, --Parent/Detail
  [Description] [varchar](255) NULL,

  [DataTypeID] [uniqueidentifier] NOT NULL,
  [RegExp] [nvarchar](255) NULL,
  [EntryMask] [varchar](60) NULL,

	--System
	[CreatedByUserID] [uniqueidentifier] NOT NULL,
	[CreatedFrom] [char](8) NOT NULL,
	[CreatedAtDateTime] [datetime] NOT NULL,
	[UpdatedByUserID] [uniqueidentifier] NOT NULL,
	[UpdatedFrom] [char](8) NOT NULL,
	[UpdatedAtDateTime] [datetime] NOT NULL,
	[Version] [rowversion] NULL,
	[Deleted] [bit] NOT NULL DEFAULT (0),

  CONSTRAINT [SYCustomField_PK] PRIMARY KEY CLUSTERED
	(
		[CustomFieldID] ASC
	)
)
GO
CREATE UNIQUE INDEX [SYCustomField_CustomFieldCD] ON [dbo].[SYCustomField]
(
	[CustomFieldCD] ASC
)
GO
