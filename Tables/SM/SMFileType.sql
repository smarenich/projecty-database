----------------------------------------------------------------
-- SMFileType
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[SMFileType];
CREATE TABLE [dbo].[SMFileType]					--TODISCUSS - Do we need it at all?
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
