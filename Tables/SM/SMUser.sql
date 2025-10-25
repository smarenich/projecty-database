DROP TABLE IF EXISTS [dbo].[SMUser];
CREATE TABLE [dbo].[SMUser]
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
	[JSON] [nvarchar](MAX) NULL,
	[Deleted] [bit] NOT NULL DEFAULT (0),

  CONSTRAINT [SMUser_PK] PRIMARY KEY CLUSTERED
  (
    [UserID] ASC
  )
)
GO
CREATE UNIQUE NONCLUSTERED INDEX [SMUser_UK] ON [dbo].[SMUser]
(
  [UserCD] ASC
)
GO
