CREATE TABLE [SMLocale]
(
  [LocaleID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),	
  [LocaleCD] [nvarchar](64) NOT NULL,  
  [Description] [nvarchar](512) NULL,
  [IsActive] [bit] NOT NULL DEFAULT ((1)),
  [IsDefault] [bit] NOT NULL DEFAULT ((0)),

  [TranslatedName] [nvarchar](512) NOT NULL,
  [TemplateLocale] [nvarchar](10) NULL,
  [NumberDecimalSeporator] [nvarchar](8) NULL,
  [NumberGroupSeparator] [nvarchar](8) NULL,
  [DateTimePattern] [nvarchar](64) NULL,
  [TimeShortPattern] [nvarchar](64) NULL,
  [TimeLongPattern] [nvarchar](64) NULL,
  [DateShortPattern] [nvarchar](64) NULL,
  [DateLongPattern] [nvarchar](64) NULL,
  [AMDesignator] [nvarchar](64) NULL,
  [PMDesignator] [nvarchar](64) NULL,

	--System
	[CreatedByUserID] [uniqueidentifier] NOT NULL,
	[CreatedFrom] [char](8) NOT NULL,
	[CreatedAtDateTime] [datetime] NOT NULL,
	[UpdatedByUserID] [uniqueidentifier] NOT NULL,
	[UpdatedFrom] [char](8) NOT NULL,
	[UpdatedAtDateTime] [datetime] NOT NULL,
	[Version] [rowversion] NULL,

  CONSTRAINT [SMLocale_PK] PRIMARY KEY CLUSTERED 
  (
    [LocaleID] ASC
  )
) 
GO
CREATE UNIQUE NONCLUSTERED INDEX [SMLocale_UK] ON [dbo].[SMLocale]
(
  [LocaleCD] ASC
)
GO