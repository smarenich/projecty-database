DROP TABLE IF EXISTS [dbo].[User];
CREATE TABLE [User]
(
  [UserID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),
  [UserCD] [nvarchar](256) NOT NULL,
  [ExtRef] [nvarchar](512) NULL,
  [Type] [char](1) NOT NULL, --External / Internal
  [Source] [char](1) NOT NULL,
  [Status] [char](1) NOT NULL,

  [FirstName] [nvarchar](255) NULL,
  [LastName] [nvarchar](255) NULL,
  [Email] [varchar](128) NULL,
  [Phone] [nvarchar](50) NULL, 
  [Comment] [nvarchar](255) NULL,

  [Password] [nvarchar](512) NULL,
  [PasswordChangeable] [bit] NOT NULL DEFAULT ((1)),
  [PasswordChangeOnNextLogin] [bit] NOT NULL DEFAULT ((0)),
  [PasswordNeverExpires] [bit] NOT NULL DEFAULT ((1)),
  [AllowPasswordRecovery] [bit] NOT NULL DEFAULT ((1)),
  [AllowPasswordLogin] [bit] NOT NULL DEFAULT ((1)),
  [GuidForPasswordRecovery] [varchar](60) NULL,
  [PasswordRecoveryExpirationDate] [datetime] NULL,

	[CreatedByUserID] [uniqueidentifier] NOT NULL,
	[CreatedFrom] [char](8) NOT NULL,
	[CreatedAtDateTime] [datetime] NOT NULL,
	[UpdatedByUserID] [uniqueidentifier] NOT NULL,
	[UpdatedFrom] [char](8) NOT NULL,
	[UpdatedAtDateTime] [datetime] NOT NULL,
	[Version] [rowversion] NULL,
	[Deleted] [bit] NOT NULL DEFAULT (0),

  CONSTRAINT [User_PK] PRIMARY KEY CLUSTERED 
  (
    [UserID] ASC
  )
)
GO
CREATE UNIQUE NONCLUSTERED INDEX [User_UK] ON [Users] 
(
  [UserCD] ASC
)
GO

DROP TABLE IF EXISTS [dbo].[UserStatistics];
CREATE TABLE [UserStatistics]
(
  [UserID] [uniqueidentifier],

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

  CONSTRAINT [UserStatistics_PK] PRIMARY KEY CLUSTERED 
  (
    [UserID] ASC
  )
)
GO

DROP TABLE IF EXISTS [dbo].[UserPreferences];
CREATE TABLE [UserStatistics]
(
  [UserID] [uniqueidentifier],

  CONSTRAINT [UserPreferences_PK] PRIMARY KEY CLUSTERED 
  (
    [UserID] ASC
  )
)
GO