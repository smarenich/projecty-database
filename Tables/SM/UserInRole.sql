DROP TABLE IF EXISTS [dbo].[UserInRole];
CREATE TABLE [dbo].[UserInRole]
(
  [UserID] [uniqueidentifier] NOT NULL,	
  [RoleID] [uniqueidentifier] NOT NULL,	
  
	--System
	[CreatedByUserID] [uniqueidentifier] NOT NULL,
	[CreatedFrom] [char](8) NOT NULL,
	[CreatedAtDateTime] [datetime] NOT NULL,
	[UpdatedByUserID] [uniqueidentifier] NOT NULL,
	[UpdatedFrom] [char](8) NOT NULL,
	[UpdatedAtDateTime] [datetime] NOT NULL,
	[Version] [rowversion] NULL,

  CONSTRAINT [UserInRole_PK] PRIMARY KEY CLUSTERED 
  (
    [UserID] ASC,
    [RoleID] ASC
  )
)