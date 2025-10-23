DROP TABLE IF EXISTS [dbo].[SMFileAllowedTypes];
CREATE TABLE [dbo].[SMFileAllowedTypes]
(
  [FileExt] [nvarchar](255) NOT NULL,
  [IconUrl] [nvarchar](512) NULL,
  [Allowed] [bit] NOT NULL DEFAULT ((1)),
  [IsImage] [bit] NOT NULL DEFAULT ((0)),  
  [Application] [nvarchar](255) NULL,
  CONSTRAINT [SMFileAllowedTypes_PK] PRIMARY KEY CLUSTERED 
  (
    [FileExt] ASC
  )
)
