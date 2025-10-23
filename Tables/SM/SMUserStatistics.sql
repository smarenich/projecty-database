DROP TABLE IF EXISTS [dbo].[SMUserStatistics];
CREATE TABLE [dbo].[SMUserStatistics]
(
  [UserID] [uniqueidentifier] NOT NULL,

  [IsOnLine] [bit] NOT NULL,

  [LastHostName] [varchar](50) NULL,
  [LastActivityDate] [datetime] NULL,
  [LastLoginDate] [datetime] NULL,
  [LastPasswordChangedDate] [datetime] NULL,

  [LockedOutDate] [datetime] NULL,
  [LastLockedOutDate] [datetime] NULL,
  [FailedPasswordAttemptCount] [int] NULL,
  [FailedPasswordAttemptWindowStart] [datetime] NULL,
  [FailedPasswordAnswerAttemptCount] [int] NULL,
  [FailedPasswordAnswerAttemptWindowStart] [datetime] NULL,

  CONSTRAINT [SMUserStatistics_PK] PRIMARY KEY CLUSTERED
  (
    [UserID] ASC
  )
)
GO