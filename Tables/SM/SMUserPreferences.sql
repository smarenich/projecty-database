DROP TABLE IF EXISTS [dbo].[SMUserPreferences];
CREATE TABLE [dbo].[SMUserPreferences]
(
  [UserID] [uniqueidentifier] NOT NULL,

  CONSTRAINT [SMUserPreferences_PK] PRIMARY KEY CLUSTERED
  (
    [UserID] ASC
  )
)
GO