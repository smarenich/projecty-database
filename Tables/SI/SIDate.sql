----------------------------------------------------------------
-- SIDates
----------------------------------------------------------------
DROP TABLE IF EXISTS dbo.SIDate;
CREATE TABLE dbo.SIDate
(
    [Date] [smalldatetime] NOT NULL,
	[Period] [char](6) NOT NULL
    CONSTRAINT PK_SIDates PRIMARY KEY CLUSTERED (Date)
)

----------------------------------------------------------------
-- SIPeriods
----------------------------------------------------------------
DROP TABLE IF EXISTS dbo.SIPeriod;
CREATE TABLE dbo.SIPeriod
(
	[Period] [char](6) NOT NULL
    CONSTRAINT PK_SIPeriods PRIMARY KEY CLUSTERED (Period)
)
