DROP TABLE IF EXISTS [dbo].[File];
CREATE TABLE [dbo].[File]
(
  [FileID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),	
  [Name] [nvarchar](255) NOT NULL,

  [LastRevisionID] [int] NOT NULL,

	--System
	[CreatedByUserID] [uniqueidentifier] NOT NULL,
	[CreatedFrom] [char](8) NOT NULL,
	[CreatedAtDateTime] [datetime] NOT NULL,
	[UpdatedByUserID] [uniqueidentifier] NOT NULL,
	[UpdatedFrom] [char](8) NOT NULL,
	[UpdatedAtDateTime] [datetime] NOT NULL,
	[Version] [rowversion] NULL,
	[Deleted] [bit] NOT NULL DEFAULT (0),

  CONSTRAINT [File_PK] PRIMARY KEY CLUSTERED 
  (
    [FileID] ASC
  )
)
GO
