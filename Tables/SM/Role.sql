DROP TABLE IF EXISTS [dbo].[Role];
CREATE TABLE [dbo].[Role]
(
  [RoleID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),	
  [RoleCD] [nvarchar](64) NOT NULL,
  [Description] [nvarchar](255) NULL,
  [Type] [char](1) NOT NULL, --External / Internal
  
	--System
	[CreatedByUserID] [uniqueidentifier] NOT NULL,
	[CreatedFrom] [char](8) NOT NULL,
	[CreatedAtDateTime] [datetime] NOT NULL,
	[UpdatedByUserID] [uniqueidentifier] NOT NULL,
	[UpdatedFrom] [char](8) NOT NULL,
	[UpdatedAtDateTime] [datetime] NOT NULL,
	[Version] [rowversion] NULL,

  CONSTRAINT [Role_PK] PRIMARY KEY CLUSTERED 
  (
    [RoleID] ASC
  )
)
GO
CREATE UNIQUE NONCLUSTERED INDEX [Role_UK] ON [Role] 
(
  [RoleCD] ASC
)
GO