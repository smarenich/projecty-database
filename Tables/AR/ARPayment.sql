----------------------------------------------------------------
-- ARPayment
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[ARPayment];
CREATE TABLE [dbo].[ARPayment]
(
	[RecordID] [uniqueidentifier] NOT NULL,

	--Classification
	[DocType] [char](3) NOT NULL,
	[RefNbr] [nvarchar](15) NOT NULL,

	--Dates
	[AdjDate] [smalldatetime] NOT NULL,
	[AdjFinPeriodID] [char](6) NOT NULL,
	[AdjTranPeriodID] [char](6) NOT NULL,

	--Payment Details
	[ExtRefNbr] [nvarchar](40) NULL,
	[RefTranExtNbr] [nvarchar](50) NULL,
	[PaymentMethodID] [nvarchar](10) NULL,
	[PMInstanceID] [int] NULL,
	[ProcessingCenterID] [nvarchar](10) NULL,
	[TerminalID] [nvarchar](36) NULL,

	--Cash Account
	[CashAccountID] [uniqueidentifier] NULL,
	[CashSubID] [uniqueidentifier] NULL,

	--Project
	[ProjectID] [uniqueidentifier] NOT NULL DEFAULT ('00000000-0000-0000-0000-000000000000'),
	[TaskID] [uniqueidentifier] NULL,

	--Clearing
	[Cleared] [bit] NULL,
	[ClearDate] [smalldatetime] NULL,
	[Settled] [bit] NOT NULL DEFAULT (0),
	[CATranID] [bigint] NULL,

	--Deposit
	[DepositAsBatch] [bit] NOT NULL DEFAULT (0),
	[DepositAfter] [smalldatetime] NULL,
	[DepositType] [char](3) NULL,
	[DepositNbr] [nvarchar](15) NULL,
	[Deposited] [bit] NOT NULL DEFAULT (0),

	--Credit Card
	[CardPresent] [bit] NOT NULL DEFAULT (0),
	[IsCCPayment] [bit] NOT NULL DEFAULT (0),
	[IsCCAuthorized] [bit] NOT NULL DEFAULT (0),
	[IsCCCaptured] [bit] NOT NULL DEFAULT (0),
	[IsCCCaptureFailed] [bit] NOT NULL DEFAULT (0),
	[IsCCRefunded] [bit] NOT NULL DEFAULT (0),
	[IsCCUserAttention] [bit] NOT NULL DEFAULT (0),
	[CCTransactionRefund] [bit] NOT NULL DEFAULT (0),
	[CCActualExternalTransactionID] [int] NULL,
	[CCReauthDate] [datetime] NULL,
	[CCReauthTriesLeft] [int] NULL,
	[SaveCard] [bit] NOT NULL DEFAULT (0),

	--Sync
	[SyncLock] [bit] NULL,
	[SyncLockReason] [char](1) NULL,

	--Totals
	[OrigTaxDiscAmount] [decimal](28, 8) NOT NULL DEFAULT (0),
	[OrigTaxDiscAmountCury] [decimal](28, 8) NOT NULL DEFAULT (0),
	[ConsolidateChargeTotal] [decimal](28, 8) NOT NULL DEFAULT (0),
	[ConsolidateChargeTotalCury] [decimal](28, 8) NOT NULL DEFAULT (0),

	--Counters
	[ChargeCntr] [int] NOT NULL DEFAULT (0),

	CONSTRAINT [ARPayment_PK] PRIMARY KEY CLUSTERED
	(
		[RecordID] ASC
	),
	UNIQUE NONCLUSTERED
	(
		[DocType] ASC,
		[RefNbr] ASC
	)
)
GO
CREATE NONCLUSTERED INDEX [ARPayment_CashAccount] ON [dbo].[ARPayment] ([CashAccountID], [CashSubID])
GO
CREATE NONCLUSTERED INDEX [ARPayment_AdjDate] ON [dbo].[ARPayment] ([AdjDate])
GO
CREATE NONCLUSTERED INDEX [ARPayment_Period] ON [dbo].[ARPayment] ([AdjFinPeriodID], [AdjTranPeriodID])
GO
CREATE NONCLUSTERED INDEX [ARPayment_Deposit] ON [dbo].[ARPayment] ([DepositNbr], [Deposited])
GO
CREATE NONCLUSTERED INDEX [ARPayment_Project] ON [dbo].[ARPayment] ([ProjectID], [TaskID])
GO

----------------------------------------------------------------
-- ARPaymentExt
----------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[ARPaymentExt];
CREATE TABLE [dbo].[ARPaymentExt]
(
	[RecordID] [uniqueidentifier] NOT NULL,
	[FieldName] [varchar](30) NOT NULL,
	[ValueNumeric] [decimal](28, 8) NULL,
	[ValueDate] [datetime] NULL,
	[ValueString] [nvarchar](256) NULL,
	[ValueText] [nvarchar](max) NULL,
	PRIMARY KEY CLUSTERED
	(
		[RecordID] ASC,
		[FieldName] ASC
	)
)
GO
CREATE NONCLUSTERED INDEX [ARPaymentExt_ValueString] ON [dbo].[ARPaymentExt] ([RecordID], [FieldName]) INCLUDE ([ValueString])
GO
