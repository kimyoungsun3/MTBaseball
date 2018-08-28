
---------------------------------------------
--		이벤트 서브 >
---------------------------------------------
use Game4Farmvill5
GO


IF OBJECT_ID (N'dbo.tEventSub', N'U') IS NOT NULL
	DROP TABLE dbo.tEventSub;
GO

create table dbo.tEventSub(
	eventidx		int					IDENTITY(1,1),
	label			varchar(20)			default(''),
	eventstatedaily	int					default(0),					-- 0:EVENT_STATE_NON, 1:ING, 2:_END
	eventitemcode	int					default(-1),
	eventcnt		int					default(0),
	eventsender		varchar(20)			default('짜요 소녀'),
	eventday		int					default(0),
	eventstarthour	int					default(0),
	eventendhour	int					default(0),

	eventpushtitle	varchar(512)		default(''),				-- 푸쉬 제목, 내용, 상태
	eventpushmsg	varchar(512)		default(''),				--
	eventpushstate	int					default(0),					-- 0:EVENT_PUSH_NON, 1:EVENT_PUSH_SEND

	writedate		datetime			default(getdate()),
	CONSTRAINT	pk_tEventSub_eventidx	PRIMARY KEY(eventidx)
)

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tEventSub_eventday_eventstarthour_eventendhour')
    DROP INDEX tEventSub.idx_tEventSub_eventday_eventstarthour_eventendhour
GO
CREATE INDEX idx_tEventSub_eventday_eventstarthour_eventendhour ON tEventSub (eventday, eventstarthour, eventendhour)
GO