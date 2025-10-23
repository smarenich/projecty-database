DROP TABLE IF EXISTS [dbo].[SMUserInRole];
CREATE TABLE [dbo].[SMUserInRole]
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

  CONSTRAINT [SMUserInRole_PK] PRIMARY KEY CLUSTERED
  (
    [UserID] ASC,
    [RoleID] ASC
  )
)
GO