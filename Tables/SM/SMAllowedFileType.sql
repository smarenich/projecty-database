----------------------------------------------------------------
-- SMAllowedFileType
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[SMAllowedFileType];
CREATE TABLE [dbo].[SMAllowedFileType]
(
	[FileExt] [nvarchar](255) NOT NULL,
	[IconUrl] [nvarchar](512) NULL,
	[Allowed] [bit] NOT NULL DEFAULT (1),
	[IsImage] [bit] NOT NULL DEFAULT (0),
	[Application] [nvarchar](255) NULL,

	CONSTRAINT [SMAllowedFileType_PK] PRIMARY KEY CLUSTERED
	(
		[FileExt] ASC
	)
)
GO
