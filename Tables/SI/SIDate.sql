----------------------------------------------------------------
-- SIDates
----------------------------------------------------------------
DROP TABLE IF EXISTS dbo.SIDate;
CREATE TABLE dbo.SIDate
(
    [Date] [smalldatetime] NOT NULL,
	[Year] [int] NOT NULL,
    [Month] [int] NOT NULL,
    [Day] [int] NOT NULL,
    [Quarter] [int] NOT NULL,
    CONSTRAINT PK_SIDates PRIMARY KEY CLUSTERED (Date)
)


