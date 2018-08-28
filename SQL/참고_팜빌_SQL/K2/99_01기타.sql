/*
--select gameid, heart from dbo.tFVRouletteLogPerson where itemcode >= 90000 and heart = 90
--select gameid, count(*), sum(heart) from dbo.tFVRouletteLogPerson where itemcode >= 90000 and heart = 90 group by gameid order by 1 desc
-- 하트복구
declare @heart		int,
		@gameid			varchar(60)

declare curUserTreasureLogPerson Cursor for
select gameid, heart from dbo.tFVRouletteLogPerson where itemcode >= 90000 and heart = 90 and writedate <= '2015-04-01' order by 1 desc

-- 2. 커서오픈
open curUserTreasureLogPerson

-- 3. 커서 사용
Fetch next from curUserTreasureLogPerson into @gameid, @heart
while @@Fetch_status = 0
	Begin
		if(@heart = 90)
			begin
				exec spu_FVSubGiftSend 2, 3300, 20, '보물20%하트원복', @gameid, ''
			end

		Fetch next from curUserTreasureLogPerson into @gameid, @heart
	end
	-- 4. 커서닫기
close curUserTreasureLogPerson
Deallocate curUserTreasureLogPerson
*/



--select gameid, count(*), sum(cashcost) from dbo.tFVRouletteLogPerson where itemcode >= 90000 and cashcost in (1800, 3600, 10800) group by gameid order by 1 desc
/*
declare @cashcost		int,
		@gameid			varchar(60)

declare curUserTreasureLogPerson Cursor for
select gameid, cashcost from dbo.tFVRouletteLogPerson where itemcode >= 90000 and cashcost in (1800, 3600, 10800) and writedate <= '2015-04-01' order by 1 desc

-- 2. 커서오픈
open curUserTreasureLogPerson

-- 3. 커서 사용
Fetch next from curUserTreasureLogPerson into @gameid, @cashcost
while @@Fetch_status = 0
	Begin
		if(@cashcost = 1800)
			begin
				--select 'DEBUG ', @cashcost cashcost, 400
				exec spu_FVSubGiftSend 2, 3015, 400, '보물20%원복', @gameid, ''
			end
		else if(@cashcost = 3600)
			begin
				--select 'DEBUG ', @cashcost cashcost, 800
				exec spu_FVSubGiftSend 2, 3015, 800, '보물20%원복', @gameid, ''
			end
		else if(@cashcost = 10800)
			begin
				--select 'DEBUG ', @cashcost cashcost, 2400
				exec spu_FVSubGiftSend 2, 3015, 2400, '보물20%원복', @gameid, ''
			end

		Fetch next from curUserTreasureLogPerson into @gameid, @cashcost
	end
	-- 4. 커서닫기
close curUserTreasureLogPerson
Deallocate curUserTreasureLogPerson
*/



/*
-- select * from dbo.tFVKakaoInvite where senddate >= (getdate() - 30)
-- 30일 이전의 유저 클리어하기.
select * from dbo.tFVKakaoInvite where senddate <= (getdate() - 30)
delete from dbo.tFVKakaoInvite where senddate <= (getdate() - 30)


select kakaomsginvitecnt, kakaomsginvitetodaycnt, kakaomsginvitetodaydate from dbo.tFVUserMaster where kakaomsginvitecnt >= 40
select kakaomsginvitecnt, kakaomsginvitetodaycnt, kakaomsginvitetodaydate from dbo.tFVUserMaster where kakaomsginvitecnt > 0


alter table dbo.tFVUserMaster add	kakaomsginvitecntbg		int			default(0)
update dbo.tFVUserMaster set kakaomsginvitecntbg = 0
update dbo.tFVUserMaster set kakaomsginvitecntbg = kakaomsginvitecnt where kakaomsginvitecnt >= 40


update dbo.tFVUserMaster set kakaomsginvitecnt = 0 where kakaomsginvitecnt >= 40
*/

/*
alter table dbo.tFVRouletteLogPerson add	ownercashcost bigint			default(0)
alter table dbo.tFVRouletteLogPerson add	ownercashcost2 bigint			default(0)
alter table dbo.tFVRouletteLogPerson add	strange			int				default(-1)
update dbo.tFVRouletteLogPerson set ownercashcost = 0, ownercashcost2 = 0, strange = -1

---------------------------------------------
-- 	유저강화 로그기록(200까지만 관리).
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserWheelLog', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserWheelLog;
GO

create table dbo.tFVUserWheelLog(
	idx				int				identity(1, 1),

	gameid			varchar(60),
	idx2			int,
	mode			int,		-- 일일룰렛(20), 결정룰렛(21), 황금무료(22)
	cashcost		int,		-- 결정비용.

	ownercashcost	bigint,		-- 보유결정.
	ownercashcost2	bigint,		-- 보유결정.
	strange			int,		-- 이상함(1) 정상(-1)
	writedate		datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tFVUserWheelLog_idx PRIMARY KEY(idx)
)
-- 인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserWheelLog_gameid_idx2')
    DROP INDEX tFVUserWheelLog.idx_tFVUserWheelLog_gameid_idx2
GO
CREATE INDEX idx_tFVUserWheelLog_gameid_idx2 ON tFVUserWheelLog (gameid, idx2)
GO

*/


/*
alter table dbo.tFVDayLogInfoStatic add	roulettefreecnt	int				default(0)
update dbo.tFVDayLogInfoStatic set roulettefreecnt = 0

--alter table dbo.tFVDayLogInfoStatic add	roulettepaycnt	int				default(0)
--update dbo.tFVDayLogInfoStatic set roulettepaycnt = 0

alter table dbo.tFVDayLogInfoStatic add	roulettegoldcnt	int				default(0)
update dbo.tFVDayLogInfoStatic set roulettegoldcnt = 0

select * from dbo.tFVDayLogInfoStatic
*/


/*
----------------------------------------------------------
alter table dbo.tFVDayLogInfoStatic add	roulettepayfreecnt 	int			default(0)
update dbo.tFVDayLogInfoStatic set roulettepayfreecnt = 0

alter table dbo.tFVUserMaster add 	wheelgauage	int						default(0)
alter table dbo.tFVUserMaster add 	wheelfree	int						default(0)
update dbo.tFVUserMaster set wheelgauage = 0, wheelfree = 0


alter table dbo.tFVSystemRouletteMan add 	wheelgauageflag		int					default(-1)
alter table dbo.tFVSystemRouletteMan add 	wheelgauagepoint	int					default(10)
alter table dbo.tFVSystemRouletteMan add 	wheelgauagemax		int					default(100)
update dbo.tFVSystemRouletteMan set wheelgauageflag = -1, wheelgauagepoint = 10, wheelgauagemax = 100
*/



/*
---------------------------------------------
-- 	유저강화 로그기록(200까지만 관리).
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserUpgradeLog', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserUpgradeLog;
GO

create table dbo.tFVUserUpgradeLog(
	idx				int				identity(1, 1),

	gameid			varchar(60),
	idx2			int,
	mode			int,		-- 일반강화(1). 결정강화(2).
	itemcode		int,		--
	step			int,		-- 1 (1 -> 2단계 업을 의미).
	results			int,		-- 성공(1), 실패(-1).
	ownercashcost	bigint,		-- 보유결정.
	ownercashcost2	bigint,		-- 보유결정.
	cashcost		int,		-- 결정비용.
	heart			int,		-- 하트비용.
	strange			int,		-- 이상함(1) 정상(-1)
	writedate		datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tFVUserUpgradeLog_idx PRIMARY KEY(idx)
)
-- 인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserUpgradeLog_gameid_idx2')
    DROP INDEX tFVUserUpgradeLog.idx_tFVUserUpgradeLog_gameid_idx2
GO
CREATE INDEX idx_tFVUserUpgradeLog_gameid_idx2 ON tFVUserUpgradeLog (gameid, idx2)
GO




alter table dbo.tFVDayLogInfoStatic add	tsupgradenormal 	int			default(0)
alter table dbo.tFVDayLogInfoStatic add	tsupgradepremium 	int			default(0)
update dbo.tFVDayLogInfoStatic set tsupgradenormal = 0, tsupgradepremium = 0

alter table dbo.tFVSystemRouletteMan add 	tsupgradesaleflag	int					default(-1)
alter table dbo.tFVSystemRouletteMan add 	tsupgradesalevalue	int					default(0)
update dbo.tFVSystemRouletteMan set tsupgradesaleflag = -1, tsupgradesalevalue = 0

*/





/*
alter table dbo.tFVUserMaster add 	adidx		int						default(0)
update dbo.tFVUserMaster set adidx = 0
*/

--select max(idx) from dbo.tFVUserAdLog


/*
---------------------------------------------
-- 	룰렛 로그 > 광고용 로그.
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserAdLog', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserAdLog;
GO

create table dbo.tFVUserAdLog(
	idx				int				identity(1, 1),

	gameid			varchar(60),
	nickname		varchar(40),
	itemcode		int,
	comment			varchar(128)	default(''),
	mode			int				default(1),

	writedate		datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tFVUserAdLog_idx PRIMARY KEY(idx)
)
-- insert into dbo.tFVUserAdLog(gameid, itemcode, comment) values('xxxx@gmail.com', 101, 'xxxx2님이 양을 교배로 얻었습니다.')
-- delete from dbo.tFVUserAdLog where idx = @idx - 100
-- update dbo.tFVUserAdLog set adidx = @idx where gameid = @gameid_
-- select top 100 * from dbo.tFVUserAdLog where gameid = 'xxxx@gmail.com' order by idx desc
*/


/*
alter table dbo.tFVUserMaster add 	tsgrade1cnt		int					default(0)
alter table dbo.tFVUserMaster add 	tsgrade2cnt		int					default(0)
alter table dbo.tFVUserMaster add 	tsgrade3cnt		int					default(0)
alter table dbo.tFVUserMaster add 	tsgrade4cnt		int					default(0)
alter table dbo.tFVUserMaster add 	tsgrade2gauage	int					default(0)
alter table dbo.tFVUserMaster add 	tsgrade3gauage	int					default(0)
alter table dbo.tFVUserMaster add 	tsgrade4gauage	int					default(0)
alter table dbo.tFVUserMaster add 	tsgrade2free	int					default(0)
alter table dbo.tFVUserMaster add 	tsgrade3free	int					default(0)
alter table dbo.tFVUserMaster add 	tsgrade4free	int					default(0)
alter table dbo.tFVUserMaster add 	ownercashcost	bigint				default(0)
update dbo.tFVUserMaster set tsgrade1cnt = 0, tsgrade2cnt = 0, 		tsgrade3cnt = 0, 	tsgrade4cnt = 0,
											  tsgrade2gauage = 0, 	tsgrade3gauage = 0, tsgrade4gauage = 0,
											  tsgrade2free = 0, 	tsgrade3free = 0, 	tsgrade4free = 0,
											  ownercashcost = 0




alter table dbo.tFVDayLogInfoStatic add tsgrade1cnt		int				default(0)
alter table dbo.tFVDayLogInfoStatic add tsgrade2cnt		int				default(0)
alter table dbo.tFVDayLogInfoStatic add tsgrade3cnt		int				default(0)
alter table dbo.tFVDayLogInfoStatic add tsgrade4cnt		int				default(0)
alter table dbo.tFVDayLogInfoStatic add	tsgrade2cntfree	int				default(0)
alter table dbo.tFVDayLogInfoStatic add	tsgrade3cntfree	int				default(0)
alter table dbo.tFVDayLogInfoStatic add	tsgrade4cntfree	int				default(0)
update dbo.tFVDayLogInfoStatic set tsgrade1cnt = 0, tsgrade2cnt = 0, 		tsgrade3cnt = 0, 	tsgrade4cnt = 0, tsgrade2cntfree = 0, tsgrade3cntfree = 0, tsgrade4cntfree = 0
*/


/*
---------------------------------------------
--		구매했던 로그(개인)
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserItemBuyLog', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserItemBuyLog;
GO

create table dbo.tFVUserItemBuyLog(
	idx			int					IDENTITY(1,1), 					-- 번호
	idx2		int,

	gameid		varchar(60), 										-- 유저id
	ownercashcost bigint			default(0),
	itemcode	int, 												-- 아이템코드, 중복 구매기록한다.
	buydate2	varchar(8),											-- 구매일20131010
	cnt			int					default(1), 					--

	cashcost	int					default(0), 					-- 구매가격(세일할수있어서)
	gamecost	int					default(0),
	heart		int					default(0),
	buydate		datetime			default(getdate()), 			-- 구매일

	-- Constraint
	CONSTRAINT	pk_tFVUserItemBuyLog_idx	PRIMARY KEY(idx)
)
-- select top 1 * from dbo.tFVUserItemBuyLog
--select top 20 * from dbo.tFVUserItemBuyLog a join dbo.tFVItemInfo b on a.itemcode = b.itemcode where gameid = 'xxxx' order by a.idx desc
--select top 20 a.idx 'idx', gameid, a.itemcode 'itemcode', a.cashcost 'cashcost', a.gamecost 'gamecost', a.buydate, b.itemname, b.gamecost 'coinball2', b.cashcost 'milkball2', b.period, b.explain from dbo.tFVUserItemBuyLog a join dbo.tFVItemInfo b on a.itemcode = b.itemcode where gameid = 'SangSang' order by a.idx desc
--select top 20 * from dbo.tFVUserItemBuyLog where buydate between '2012-08-09 00:00:01' and '2012-08-10 00:00:01' order by idx desc
--insert into dbo.tFVUserItemBuyLog(gameid, itemcode, cashcost, gamecost) values('xxxx', 1, 5,  0)
--insert into dbo.tFVUserItemBuyLog(gameid, itemcode, cashcost, gamecost) values('xxxx', 1, 0, 50)
--통계용 인덱스
--IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserItemBuyLog_buydate')
--    DROP INDEX tFVUserItemBuyLog.idx_tFVUserItemBuyLog_buydate
--GO
--CREATE INDEX idx_tFVUserItemBuyLog_buydate ON tFVUserItemBuyLog (buydate)
--GO

--유저 검색용 인덱스
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserItemBuyLog_gameid_idx')
    DROP INDEX tFVUserItemBuyLog.idx_tFVUserItemBuyLog_gameid_idx
GO
CREATE INDEX idx_tFVUserItemBuyLog_gameid_idx ON tFVUserItemBuyLog (gameid, idx)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserItemBuyLog_gameid_idx2')
    DROP INDEX tFVUserItemBuyLog.idx_tFVUserItemBuyLog_gameid_idx2
GO
CREATE INDEX idx_tFVUserItemBuyLog_gameid_idx2 ON tFVUserItemBuyLog (gameid, idx2)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserItemBuyLog_gameid_buydate2_itemcode')
    DROP INDEX tFVUserItemBuyLog.idx_tFVUserItemBuyLog_gameid_buydate2_itemcode
GO
CREATE INDEX idx_tFVUserItemBuyLog_gameid_buydate2_itemcode ON tFVUserItemBuyLog (gameid, buydate2, itemcode)
GO


---------------------------------------------
-- 	구매했던 로그(월별 Master)
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserItemBuyLogTotalMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserItemBuyLogTotalMaster;
GO

create table dbo.tFVUserItemBuyLogTotalMaster(
	idx				int				identity(1, 1),
	dateid8			char(8),							-- 20101210

	cashcost		bigint			default(0),
	gamecost		bigint			default(0),
	heart			bigint			default(0),
	cnt				int				default(0),

	-- Constraint
	CONSTRAINT	pk_tFVUserItemBuyLogTotalMaster_dateid	PRIMARY KEY(dateid8)
)
-- select         * from dbo.tFVUserItemBuyLogTotalMaster
-- select top 1   * from dbo.tFVUserItemBuyLogTotalMaster where dateid8 = '20120818'
-- insert into dbo.tFVUserItemBuyLogTotalMaster(dateid8, gamecost, cashcost, cnt) values('20120818', 100, 0, 1)
--update dbo.tFVUserItemBuyLogTotalMaster
--	set
--		gamecost = gamecost + 1,
--		cashcost = cashcost + 1,
--		heart	 = heart + 1,
--		cnt = cnt + 1
--where dateid8 = '20120818'


---------------------------------------------
-- 	구매했던 로그(월별 Sub)
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserItemBuyLogTotalSub', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserItemBuyLogTotalSub;
GO

create table dbo.tFVUserItemBuyLogTotalSub(
	idx				int				identity(1, 1),

	dateid8			char(8),							-- 20101210
	itemcode		int,

	cashcost		int				default(0),
	gamecost		int				default(0),
	heart			int				default(0),
	cnt				int				default(0),

	-- Constraint
	CONSTRAINT	pk_tFVUserItemBuyLogTotalSub_dateid8_itemcode	PRIMARY KEY(dateid8, itemcode)
)
-- select top 100 * from dbo.tFVUserItemBuyLogTotalSub order by dateid8 desc, itemcode desc
-- select         * from dbo.tFVUserItemBuyLogTotalSub where dateid8 = '20120818'
-- select top 1   * from dbo.tFVUserItemBuyLogTotalSub where dateid8 = '20120818' and itemcode = 1
--update dbo.tFVUserItemBuyLogTotalSub
--	set
--		gamecost = gamecost + 1,
--		cashcost = cashcost + 1,
--		heart 	= heart + 1,
--		cnt = cnt + 1
--where dateid8 = '20120818' and itemcode = 1
-- insert into dbo.tFVUserItemBuyLogTotalSub(dateid8, itemcode, cashcost, gamecost, cnt) values('20120818', 1, 100, 0, 1)


---------------------------------------------
-- 	구매했던 로그(월별 누적)
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserItemBuyLogMonth', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserItemBuyLogMonth;
GO

create table dbo.tFVUserItemBuyLogMonth(
	idx				int				identity(1, 1),

	dateid6			char(6),							-- 201012
	itemcode		int,

	cashcost		bigint			default(0),
	gamecost		bigint			default(0),
	heart			int				default(0),
	cnt				int				default(0),

	-- Constraint
	CONSTRAINT	pk_tFVUserItemBuyLogMonth_dateid6_itemcode	PRIMARY KEY(dateid6, itemcode)
)
-- select top 100 * from dbo.tFVUserItemBuyLogMonth order by dateid6 desc, itemcode desc
-- select         * from dbo.tFVUserItemBuyLogMonth where dateid6 = '201309'
-- select top 1   * from dbo.tFVUserItemBuyLogMonth where dateid6 = '201309' and itemcode = 1
-- insert into dbo.tFVUserItemBuyLogMonth(dateid6, itemcode, gamecost, cashcost, cnt) values('201309', 1, 100, 0, 1)
--update dbo.tFVUserItemBuyLogMonth
--	set
--		gamecost = gamecost + 1,
--		cashcost = cashcost + 1,
--		heart 	= heart + 1,
--		cnt = cnt + 1
--where dateid6 = '201309' and itemcode = 1





---------------------------------------------
-- 	룰렛 로그 > 개인자료
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVRouletteLogPerson', N'U') IS NOT NULL
	DROP TABLE dbo.tFVRouletteLogPerson;
GO

create table dbo.tFVRouletteLogPerson(
	idx				int				identity(1, 1),

	gameid			varchar(60),
	kind			int,
	bestani			int,
	itemcode		int,
	itemcodename	varchar(40),

	cashcost		int				default(0),
	gamecost		int				default(0),
	heart			int				default(0),

	itemcode0		int				default(-1),
	itemcode1		int				default(-1),
	itemcode2		int				default(-1),
	itemcode3		int				default(-1),
	itemcode4		int				default(-1),
	itemcode0name	varchar(40)		default(''),
	itemcode1name	varchar(40)		default(''),
	itemcode2name	varchar(40)		default(''),
	itemcode3name	varchar(40)		default(''),
	itemcode4name	varchar(40)		default(''),

	writedate		datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tFVRouletteLogPerson_idx PRIMARY KEY(idx)
)
-- gameid, idx
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVRouletteLogPerson_gameid_idx')
	DROP INDEX tFVRouletteLogPerson.idx_tFVRouletteLogPerson_gameid_idx
GO
CREATE INDEX idx_tFVRouletteLogPerson_gameid_idx ON tFVRouletteLogPerson (gameid, idx)
GO
-- select top 100 * from dbo.tFVRouletteLogPerson where gameid = 'xxxx@gmail.com' order by idx desc


---------------------------------------------
-- 	교배뽑기했던 로그(월별 Master)
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVRouletteLogTotalMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tFVRouletteLogTotalMaster;
GO

create table dbo.tFVRouletteLogTotalMaster(
	idx				int				identity(1, 1),
	dateid8			char(8),							-- 20101210

	tsgrade1cnt		int				default(0),			-- 보물뽑기.
	tsgrade2cnt		int				default(0),
	tsgrade3cnt		int				default(0),
	tsgrade4cnt		int				default(0),
	tsgrade2freecnt	int				default(0),
	tsgrade3freecnt	int				default(0),
	tsgrade4freecnt	int				default(0),

	roulettecnt		int				default(0),			-- 룰렛.
	roulettefreecnt	int				default(0),

	-- Constraint
	CONSTRAINT	pk_tFVRouletteLogTotalMaster_dateid	PRIMARY KEY(dateid8)
)
-- select top 1   * from dbo.tFVRouletteLogTotalMaster where dateid8 = '20120818'
-- insert into dbo.tFVRouletteLogTotalMaster(dateid8) values('20120818')
--update dbo.tFVRouletteLogTotalMaster
--	set
--		premiumcnt 	= premiumcnt + 1,
--		normalcnt 	= normalcnt + 1
--where dateid8 = '20120818'


---------------------------------------------
-- 	교배뽑기했던 로그(월별 Sub)
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVRouletteLogTotalSub', N'U') IS NOT NULL
	DROP TABLE dbo.tFVRouletteLogTotalSub;
GO

create table dbo.tFVRouletteLogTotalSub(
	idx				int				identity(1, 1),

	dateid8			char(8),							-- 20101210
	itemcode		int,
	itemcodename	varchar(40)		default(''),

	tsgrade1cnt		int				default(0),			-- 보물뽑기.
	tsgrade2cnt		int				default(0),
	tsgrade3cnt		int				default(0),
	tsgrade4cnt		int				default(0),
	tsgrade2freecnt	int				default(0),
	tsgrade3freecnt	int				default(0),
	tsgrade4freecnt	int				default(0),

	roulettecnt		int				default(0),			-- 룰렛.
	roulettefreecnt	int				default(0),

	-- Constraint
	CONSTRAINT	pk_tFVRouletteLogTotalSub_dateid8_itemcode	PRIMARY KEY(dateid8, itemcode)
)
-- select top 1   * from dbo.tFVRouletteLogTotalSub where dateid8 = '20120818' and itemcode = 1
--update dbo.tFVRouletteLogTotalSub
--	set
--		premiumcnt 	= premiumcnt + 1,
--		normalcnt	= normalcnt + 1
--where dateid8 = '20120818' and itemcode = 1
-- insert into dbo.tFVRouletteLogTotalSub(dateid8, itemcode) values('20120818', 1)

*/



/*
select top 1 * from dbo.tFVSystemRoulette
	where famelvmin <= 500
		  and 500 <= famelvmax
		  and packstate = 1
		  order by newid()
*/
/*
alter table dbo.tFVSystemRouletteMan add 	roulsaleflag		int					default(-1)
alter table dbo.tFVSystemRouletteMan add 	roulsalevalue		int					default(0)
update dbo.tFVSystemRouletteMan set roulsaleflag = -1, roulsalevalue = 0
*/




--select * from dbo.tFVSystemRoulette where packname     like '%(1차버젼)%'
--select * from dbo.tFVItemInfo where category = 90

--exec spu_FVFarmD 30, 21,  1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''							-- 뽑기상품(아이템리스트, 템리스트) 활성.
--exec spu_FVFarmD 30, 21, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''							--                                비활성.

/*
alter table dbo.tFVUserMaster add 	roulettegoldcnt	int					default(0)
update dbo.tFVUserMaster set roulettegoldcnt = 0

select roulettegoldcnt from dbo.tFVUserMaster where gameid = 'xxxx@gmail.com'
*/

/*
--exec spu_FVGiftGain 'farm60142592', '2691871m3r2c5r237243', -3,  733194, -1		-- 유제품
select roulettepaycnt from dbo.tFVUserMaster where gameid = 'farm60142592'
select * from dbo.tFVGiftList where gameid = 'farm60142592' and giftkind = 2 order by idx desc
*/

/*
update dbo.tFVUserMaster set roulettepaycnt = 0 where gameid = 'xxxx@gmail.com'-- update dbo.tFVUserMaster set roulettepaycnt = 0 where gameid = 'xxxx@gmail.com'
-- delete from dbo.tFVGiftList where gameid = 'xxxx@gmail.com'

select gameid, roulettepaycnt from dbo.tFVUserMaster where gameid = 'xxxx@gmail.com'
exec spu_FVSave2 'xxxx@gmail.com',  '049000s1i0n7t8445289', 0, '0:123;  1:500;  10:0;  11:0;  20:-1;  21:1;  30:30;  31:31;  32:32;  33:33;', 'google22savetest', 8771, -1


select gameid, roulettepaycnt from dbo.tFVUserMaster where gameid = 'xxxx@gmail.com'
exec spu_FVSave2 'xxxx@gmail.com',  '049000s1i0n7t8445289', 0, '0:123;  1:500;  10:0;  11:0;  20:-1;  21:1;  30:30;  31:31;  32:32;  33:33;', 'google22savetest', 8772, -1


select gameid, roulettepaycnt from dbo.tFVUserMaster where gameid = 'xxxx@gmail.com'
exec spu_FVSave2 'xxxx@gmail.com',  '049000s1i0n7t8445289', 0, '0:123;  1:500;  10:0;  11:0;  20:-1;  21:1;  30:30;  31:31;  32:32;  33:33;', 'google22savetest', 8773, -1

select gameid, roulettepaycnt from dbo.tFVUserMaster where gameid = 'xxxx@gmail.com'
exec spu_FVSave2 'xxxx@gmail.com',  '049000s1i0n7t8445289', 0, '0:123;  1:500;  10:0;  11:0;  20:-1;  21:1;  30:30;  31:31;  32:32;  33:33;', 'google22savetest', 8774, -1


select gameid, roulettepaycnt from dbo.tFVUserMaster where gameid = 'xxxx@gmail.com'
exec spu_FVSave2 'xxxx@gmail.com',  '049000s1i0n7t8445289', 0, '0:123;  1:500;  10:0;  11:0;  20:-1;  21:1;  30:30;  31:31;  32:32;  33:33;', 'google22savetest', 8775, -1


select gameid, roulettepaycnt from dbo.tFVUserMaster where gameid = 'xxxx@gmail.com'
exec spu_FVSave2 'xxxx@gmail.com',  '049000s1i0n7t8445289', 0, '0:123;  1:500;  10:0;  11:0;  20:-1;  21:1;  30:30;  31:31;  32:32;  33:33;', 'google22savetest', 8776, -1


select gameid, roulettepaycnt from dbo.tFVUserMaster where gameid = 'xxxx@gmail.com'
exec spu_FVSave2 'xxxx@gmail.com',  '049000s1i0n7t8445289', 0, '0:123;  1:500;  10:0;  11:0;  20:-1;  21:1;  30:30;  31:31;  32:32;  33:33;', 'google22savetest', 8777, -1


select gameid, roulettepaycnt from dbo.tFVUserMaster where gameid = 'xxxx@gmail.com'
exec spu_FVSave2 'xxxx@gmail.com',  '049000s1i0n7t8445289', 0, '0:123;  1:500;  10:0;  11:0;  20:-1;  21:1;  30:30;  31:31;  32:32;  33:33;', 'google22savetest', 8778, -1


select gameid, roulettepaycnt from dbo.tFVUserMaster where gameid = 'xxxx@gmail.com'
exec spu_FVSave2 'xxxx@gmail.com',  '049000s1i0n7t8445289', 0, '0:123;  1:500;  10:0;  11:0;  20:-1;  21:1;  30:30;  31:31;  32:32;  33:33;', 'google22savetest', 8779, -1


select gameid, roulettepaycnt from dbo.tFVUserMaster where gameid = 'xxxx@gmail.com'
exec spu_FVSave2 'xxxx@gmail.com',  '049000s1i0n7t8445289', 0, '0:123;  1:500;  10:0;  11:0;  20:-1;  21:1;  30:30;  31:31;  32:32;  33:33;', 'google22savetest', 8770, -1

*/


/*
-- 황금룰렛티켓
insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_coin', '3500', '35', '35', '35', '황금룰렛티켓', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '황금룰렛티켓')
GO
*/


/*
alter table dbo.tFVDayLogInfoStatic add roulettepaycnt	int				default(0)
update dbo.tFVDayLogInfoStatic set roulettepaycnt = 0
*/



/*
-- select * from dbo.tFVRankDaJun order by rkdateid8 desc
-- delete from dbo.tFVRankDaJun where rkdateid8 in ('20150318', '20150319', '20150320', '20150321')
-- update dbo.tFVUserMaster set rksalemoney = 0, rkproductcnt = 0, rkfarmearn = 0, rkwolfcnt = 0, rkfriendpoint = 0, rkroulettecnt = 0, rkplaycnt = 0
*/

/*
declare @curdate			datetime				set @curdate		= getdate()
declare @dateid8			varchar(8),
		@dw					int,
		@loop				int

set @loop = 0
while(@loop < 14)
	begin
		select @dw = DATEPART(dw, @curdate)
		set @dateid8 = CONVERT(char(10), @curdate, 112)
		select @curdate curdate, @dateid8 dateid8, @dw dw

		set @loop = @loop + 1
		set @curdate = @curdate + 1
	end

-- 금요일만 수집(저장) > 토요일 연산(금 -> 토스케쥴)
--일	월	화	수	목	금	토
--1 	2 	3 	4 	5 	6 	7
--1 	2 	3 	4 	5 	6 	7
--8 	9 	10 	11 	12 	13 	14
--15 	16 	17 	18 	19 	20 	21
--22 	23 	24 	25 	26 	27 	28
--29 	30 	31
*/


/*
-- delete from dbo.tFVRankDaJun where rkdateid8 in ('20150312', '20150313')
select * from dbo.tFVUserMaster order by rktotal desc
select * from dbo.tFVGiftList
select * from dbo.tFVRankDaJun
*/

/*
alter table dbo.tFVUserMaster add 	rksalemoneybk	bigint				default(0)
alter table dbo.tFVUserMaster add 	rkproductcntbk	bigint				default(0)
alter table dbo.tFVUserMaster add 	rkfarmearnbk	bigint				default(0)
alter table dbo.tFVUserMaster add 	rkwolfcntbk		bigint				default(0)
alter table dbo.tFVUserMaster add 	rkfriendpointbk	bigint				default(0)
alter table dbo.tFVUserMaster add 	rkroulettecntbk	bigint				default(0)
alter table dbo.tFVUserMaster add 	rkplaycntbk		bigint				default(0)
update dbo.tFVUserMaster set rksalemoneybk = 0, rkproductcntbk = 0, rkfarmearnbk = 0, rkwolfcntbk = 0, rkfriendpointbk = 0, rkroulettecntbk = 0, rkplaycntbk = 0
*/
/*
declare @RANK_REWARD_ING	int 	set @RANK_REWARD_ING	= 0
declare @RANK_REWARD_END	int 	set @RANK_REWARD_END	= 1
declare @rkreward			int,
		@rkwinteam			int,
		@rkteam1			int,
		@rkteam0			int,
		@rkdateid8			varchar(8),
		@rkdateid4			varchar(4),
		@loop				int,
		@idx				int,
		@rank				int,
		@gameid 			varchar(60),
		@sendid 			varchar(60),
		@title				varchar(10)

set @rkreward	= @RANK_REWARD_END
set @rkdateid8	= Convert(varchar(8), Getdate() - 1, 112)
set @rkdateid4	= SUBSTRING(@rkdateid8, 5, 8)
set @loop 		= 3000
set @idx 		= -1
set @rkteam1 		= 4
set @rkteam0 		= 3


select * from dbo.tFVUserMaster where idx >= 1 and idx <= 2
		update dbo.tFVUserMaster
				set
					-- 1차 백업 데이타를 백업한다.
					rktotal2 		= rktotal,
					rksalemoneybk	= rksalemoney,
					rkproductcntbk	= rkproductcnt,
					rkfarmearnbk	= rkfarmearn,
					rkwolfcntbk		= rkwolfcnt,
					rkfriendpointbk	= rkfriendpoint,
					rkroulettecntbk	= rkroulettecnt,
					rkplaycntbk		= rkplaycnt,

					-- 2차 연산하기.
					rktotal  = FLOOR(case when ((@rkteam1 > @rkteam0 and rkteam = 1) or (@rkteam1 < @rkteam0 and rkteam = 0)) then (rksalemoney*0.0001 + rkproductcnt*0.01 + rkfarmearn*0.01 + rkwolfcnt*40 + rkfriendpoint*50 + rkroulettecnt*900 + rkplaycnt*0.1) else 0 end),

					-- 3차 연산한 데이타를 클리어하기.
					rksalemoney 	= 0,
					rkproductcnt	= 0,
					rkfarmearn		= 0,
					rkwolfcnt		= 0,
					rkfriendpoint	= 0,
					rkroulettecnt	= 0,
					rkplaycnt		= 0
			where idx >= 1 and idx <= 2
select * from dbo.tFVUserMaster where idx >= 1 and idx <= 2
*/

/*
alter table dbo.tFVUserMaster add 	rktotal			bigint				default(0)
alter table dbo.tFVUserMaster add 	rktotal2		bigint				default(0)
update dbo.tFVUserMaster set rktotal = 0, rktotal2 = 0


alter table dbo.tFVRankDaJun add 	rkreward		int					default(0)
update dbo.tFVRankDaJun set rkreward = 0
*/

-- select rkteam, COUNT(rkteam) from dbo.tFVUserMaster group by rkteam
-- 0	19462
-- 1	19766

-- select rkteam, COUNT(rkteam) from dbo.tFVUserMaster  where salemoney > 0 group by rkteam
-- 0	3108
-- 1	3149
--select rank() over(order by salemoney desc) as rank, gameid from dbo.tFVUserMaster where salemoney > 0

/*
-- 짝승 만들기
--delete from dbo.tFVGiftList
--exec spu_subFVRankDaJunTest 'xxxx@gmail.com', '20150312', 1, 2000000000000, 300000000, 1267977400, 5, 6000000, 70000000000
--update dbo.tFVRankDaJun set rkreward = 0 where rkdateid8 = '20150312'

-- 홀승만들기
--delete from dbo.tFVGiftList
--exec spu_subFVRankDaJunTest 'xxxx3', '20150312', 1, 2000000000000, 300000000, 1267977400, 5, 6000000, 70000000000
--update dbo.tFVRankDaJun set rkreward = 0 where rkdateid8 = '20150312'

select * from dbo.tFVGiftList order by idx asc
*/


/*
declare @rkteam1			int,
		@rkteam0			int
set @rkteam1 = 4
set @rkteam0 = 3
select
		gameid, rkteam,
		FLOOR(case when ((@rkteam1 > @rkteam0 and rkteam = 1) or (@rkteam1 < @rkteam0 and rkteam = 0)) then (rksalemoney*0.0001 + rkproductcnt*0.01 + rkfarmearn*0.01 + rkwolfcnt*40 + rkfriendpoint*50 + rkroulettecnt*900 + rkplaycnt*0.1) else 0 end),
		rksalemoney*0.0001, rkproductcnt*0.01, rkfarmearn*0.01, rkwolfcnt*40, rkfriendpoint*50, rkroulettecnt*900,  rkplaycnt*0.1
from dbo.tFVUserMaster order by 3 desc
*/

/*
	------------------------------------------------
	--	랭킹대전기록(전체).
	------------------------------------------------
	select * from dbo.tFVRankDaJun where rkdateid8 = Convert(varchar(8), Getdate(),112)
	select * from dbo.tFVRankDaJun where rkdateid8 = Convert(varchar(8), Getdate()-1,112)

*/




/*
alter table dbo.tFVUserMaster add	rkdateid8bf		varchar(8)			default('20000101')
alter table dbo.tFVUserMaster add	rkteam			int					default(1)				-- 1홀, 2짝
alter table dbo.tFVUserMaster add 	rksalemoney		bigint				default(0)				-- 판매수익(0).
alter table dbo.tFVUserMaster add 	rkproductcnt	bigint				default(0)				-- 생산수량(30).
alter table dbo.tFVUserMaster add 	rkfarmearn		bigint				default(0)				-- 목장수익(31).
alter table dbo.tFVUserMaster add 	rkwolfcnt		bigint				default(0)				-- 늑대사냥(32).
alter table dbo.tFVUserMaster add 	rkfriendpoint	bigint				default(0)				-- 친구포인트(자동수집).
alter table dbo.tFVUserMaster add 	rkroulettecnt	bigint				default(0)				-- 룰렛횟수(20, 21).
alter table dbo.tFVUserMaster add 	rkplaycnt		bigint				default(0)				-- 플레이타임(33).
update dbo.tFVUserMaster set rkdateid8bf = '20000101', rkteam = 1, rksalemoney = 0, rkproductcnt = 0, rkfarmearn = 0, rkwolfcnt = 0, rkfriendpoint = 0, rkroulettecnt = 0, rkplaycnt = 0


---------------------------------------------
--		유저닉네임변경
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVRankDaJun', N'U') IS NOT NULL
	DROP TABLE dbo.tFVRankDaJun;
GO

create table dbo.tFVRankDaJun(
	idx			int 					IDENTITY(1, 1),

	--(날짜정보)
	rkdateid8		varchar(8),
	rkteam1			int					default(0),				-- 홀팀점수
	rkteam0			int					default(0),				-- 짝팀점수

	-- 홀수.
	rksalemoney		bigint				default(0),				-- 판매수익(0).
	rkproductcnt	bigint				default(0),				-- 생산수량(30).
	rkfarmearn		bigint				default(0),				-- 목장수익(31).
	rkwolfcnt		bigint				default(0),				-- 늑대사냥(32).
	rkfriendpoint	bigint				default(0),				-- 친구포인트(자동수집).
	rkroulettecnt	bigint				default(0),				-- 룰렛횟수(20, 21).
	rkplaycnt		bigint				default(0),				-- 플레이타임(33).

	-- 짝수.
	rksalemoney2	bigint				default(0),				-- 판매수익(0).
	rkproductcnt2	bigint				default(0),				-- 생산수량(30).
	rkfarmearn2		bigint				default(0),				-- 목장수익(31).
	rkwolfcnt2		bigint				default(0),				-- 늑대사냥(32).
	rkfriendpoint2	bigint				default(0),				-- 친구포인트(자동수집).
	rkroulettecnt2	bigint				default(0),				-- 룰렛횟수(20, 21).
	rkplaycnt2		bigint				default(0),				-- 플레이타임(33).

	-- Constraint
	CONSTRAINT pk_tFVRankDaJun_rkdateid8	PRIMARY KEY(rkdateid8)
)
GO
*/


/*
select
	--idx, idx%2,
	gameid,
	SUBSTRING(gameid, LEN(LTRIM(gameid)), LEN(LTRIM(gameid))),
	(CASE WHEN ISNUMERIC(SUBSTRING(gameid, LEN(LTRIM(gameid)), LEN(LTRIM(gameid)))) = 1 THEN CAST(SUBSTRING(gameid, LEN(LTRIM(gameid)), LEN(LTRIM(gameid))) AS INT) ELSE 0 END)%2
	--CASE WHEN ISNUMERIC('x') = 1 THEN CAST('x' AS INT) ELSE 0 END a2,
	--CASE WHEN ISNUMERIC('1') = 1 THEN CAST('1' AS INT) ELSE 0 END a3,
	--kakaouserid
from dbo.tFVUserMaster

select CASE WHEN ISNUMERIC('x') = 1 THEN CAST('x' AS INT) ELSE 0 END

exec spu_FVLogin 'iuest132104', '35875453295372174914', 5, 199, 0, -1
exec spu_FVLogin 'farm131243', '4494482y6t4k4z683466', 5, 199, 0, -1
exec spu_FVLogin 'xxxx4', '049000s1i0n7t8445289', 5, 199, 0, -1
exec spu_FVLogin 'xxxx5', '049000s1i0n7t8445289', 5, 199, 0, -1
exec spu_FVLogin 'xxxx3', '049000s1i0n7t8445289', 5, 199, 0, -1
exec spu_FVLogin 'xxxx@gmail.com',  '01022223331', 5, 199, 0, -1
exec spu_FVLogin 'xxxx', '049000s1i0n7t8445289', 5, 199, 0, -1

select rkteam, gameid from dbo.tFVUserMaster where gameid in ( 'iuest132104', 'farm131243', 'xxxx', 'xxxx@gmail.com', 'xxxx3', 'xxxx4', 'xxxx5')


declare @dateid8 			varchar(8) 				set @dateid8 		= Convert(varchar(8), Getdate(),112)
select @dateid8

set @dateid8 		= Convert(varchar(8), Getdate()+1,112)
select @dateid8

set @dateid8 		= Convert(varchar(8), Getdate()+2,112)
select @dateid8


*/


/*
DECLARE @ttt TABLE(
	gameid		varchar(60),
	rkteam		int
);

--별반차이가 없음.
insert into @ttt(gameid, rkteam)
select gameid, (CASE WHEN ISNUMERIC(SUBSTRING(gameid, LEN(LTRIM(gameid)), LEN(LTRIM(gameid)))) = 1 THEN CAST(SUBSTRING(gameid, LEN(LTRIM(gameid)), LEN(LTRIM(gameid))) AS INT) ELSE 0 END) %2
from dbo.tFVUserMaster
select rkteam, count(*) from @ttt group by rkteam
--select * from @ttt
delete from @ttt

insert into @ttt(gameid, rkteam)
select gameid, idx%2
from dbo.tFVUserMaster
select rkteam, count(*) from @ttt group by rkteam
*/


/*
declare @curdate			datetime				set @curdate		= getdate()
declare @dateid8			varchar(8),
		@dw					int

			select @dw = DATEPART(dw, @curdate)
			set @curdate = @curdate + (7 - @dw)
			set @dateid8 = CONVERT(char(10), @curdate, 112)
select @curdate curdate, @dateid8 dateid8
*/

/*
alter table dbo.tFVUserMaster add roulettefreecnt	int					default(0)
alter table dbo.tFVUserMaster add roulettepaycnt	int					default(0)
update dbo.tFVUserMaster set roulettefreecnt = 0, roulettepaycnt = 0

update dbo.tFVUserMaster set roulette  = 1, roulettefreecnt = 0, roulettepaycnt = 0 where gameid = 'xxxx@gmail.com'
select roulette, roulettefreecnt, roulettepaycnt from dbo.tFVUserMaster where gameid = 'xxxx@gmail.com'
exec spu_FVSave2 'xxxx@gmail.com',  '049000s1i0n7t8445289', 1, '  0:123;   1:500;        10:1000;    11:2000;        ', 'google22savetest',  8884, -1		-- 누적방식
select roulette, roulettefreecnt, roulettepaycnt from dbo.tFVUserMaster where gameid = 'xxxx@gmail.com'
exec spu_FVSave2 'xxxx@gmail.com',  '049000s1i0n7t8445289', 1, '100:123;   1:500;        10:1000;    11:2000;        ', 'google22savetest',  8885, -1		-- 토탈방식
select roulette, roulettefreecnt, roulettepaycnt from dbo.tFVUserMaster where gameid = 'xxxx@gmail.com'

select roulette, roulettefreecnt, roulettepaycnt from dbo.tFVUserMaster where gameid = 'xxxx@gmail.com'
exec spu_FVSave2 'xxxx@gmail.com',  '049000s1i0n7t8445289', 1, '  0:123;   1:500;        10:1000;    11:2000;         20:1;          21:0;', 'google22savetest', 8886,  -1		-- 누적방식
select roulette, roulettefreecnt, roulettepaycnt from dbo.tFVUserMaster where gameid = 'xxxx@gmail.com'
exec spu_FVSave2 'xxxx@gmail.com',  '049000s1i0n7t8445289', 1, '100:123;   1:500;        10:1000;    11:2000;         20:-1;          21:2;', 'google22savetest',  8887, -1		-- 토탈방식
select roulette, roulettefreecnt, roulettepaycnt from dbo.tFVUserMaster where gameid = 'xxxx@gmail.com'
*/

/*
-- 10000	20000	30000	40000	50000	60000	4	9	14	19	24	29		> 100
-- 50000	60000	70000	80000	90000	100000	36	49	62	75	88	101		> 411
select * from dbo.tFVUserData where savedata like '%80000%' or savedata like '%80008%'
*/


/*
select gameid, nickname from dbo.tFVUserMaster where nickname is null or nickname = ''
update dbo.tFVUserMaster set nickname = gameid where nickname is null or nickname = ''
delete from dbo.tFVItemInfo where itemcode = 1
*/

/*
alter table dbo.tFVUserMaster add 	bgroul1		int						default(-1)
alter table dbo.tFVUserMaster add 	bgroul2		int						default(-1)
alter table dbo.tFVUserMaster add 	bgroul3		int						default(-1)
alter table dbo.tFVUserMaster add 	bgroul4		int						default(-1)
alter table dbo.tFVUserMaster add 	bgroul5		int						default(-1)
alter table dbo.tFVUserMaster add 	bgroulcnt	int						default(0)
alter table dbo.tFVUserMaster add 	pmroulcnt	int						default(0)
alter table dbo.tFVUserMaster add 	pmticketcnt	int						default(0)
alter table dbo.tFVUserMaster add 	pmgauage	int						default(0)
update dbo.tFVUserMaster set bgroul1 = -1, bgroul2 = -1, bgroul3 = -1, bgroul4 = -1, bgroul5 = -1, bgroulcnt = -1, pmroulcnt = -1, pmticketcnt = -1, pmgauage = -1
*/
/*
---------------------------------------------
-- 뽑기이벤트 관리 내용.
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVSystemRouletteMan', N'U') IS NOT NULL
	DROP TABLE dbo.tFVSystemRouletteMan;
GO

create table dbo.tFVSystemRouletteMan(
	idx					int 				IDENTITY(1, 1),

	roulmarket			int					default(5),

	-- 1.특정보물 보상받기.
	roulflag			int					default(-1),
	roulstart			datetime			default('2014-01-01'),
	roulend				datetime			default('2024-01-01'),
	roulani1			int					default(-1),
	roulani2			int					default(-1),
	roulani3			int					default(-1),
	roulreward1			int					default(-1),
	roulreward2			int					default(-1),
	roulreward3			int					default(-1),
	roulrewardcnt1		int					default(0),
	roulrewardcnt2		int					default(0),
	roulrewardcnt3		int					default(0),
	roulname1			varchar(20)			default(''),
	roulname2			varchar(20)			default(''),
	roulname3			varchar(20)			default(''),

	-- 2.특정시간에 확률상승.
	roultimeflag		int					default(-1),
	roultimetime1		int					default(-1),
	roultimetime2		int					default(-1),
	roultimetime3		int					default(-1),

	-- 3.프리미엄 무료뽑기.
	pmgauageflag		int					default(-1),
	pmgauagepoint		int					default(100),
	pmgauagemax			int					default(10),

	--코멘트.
	comment				varchar(256)		default(''),
	writedate			datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tFVSystemRouletteMan_idx	PRIMARY KEY(idx)
)
-- select top 1 * from dbo.tFVSystemRouletteMan where roulmarket like '%5%' order by idx desc
-- insert into dbo.tFVSystemRouletteMan(roulmarket,      roulflag,    roulstart,      roulend, roulani1, roulani2, roulani3, roulreward1, roulreward2, roulreward3,       roulname1,       roulname2,       roulname3, roultimeflag, roultimetime1, roultimetime2, roultimetime3, comment)
-- values                              (         5,        1, '2013-09-01', '2023-09-01',    80000,    80001,    80006,        3015,        3015,        3015,  '콩나물 화분D', '오래된 라디오D', '콩나물 화분A',            1,             12,            18,            23, '최초내용')
-- update dbo.tFVSystemRouletteMan set roulflag = -1 where idx = 3

--insert into dbo.tFVSystemRouletteMan(roulmarket,      roulflag,    roulstart,      roulend, roulani1, roulani2, roulani3, roulreward1, roulreward2, roulreward3,       roulname1,       roulname2,       roulname3, roultimeflag, roultimetime1, roultimetime2, roultimetime3, comment)
--values                              (         1,             1, '2013-09-01', '2023-09-01',    80000,    80001,    80006,        3015,        3015,        3015,  '콩나물 화분D', '오래된 라디오D', '콩나물 화분A',            1,            12,            18,            23, '최초내용')
--insert into dbo.tFVSystemRouletteMan(roulmarket,      roulflag,    roulstart,      roulend, roulani1, roulani2, roulani3, roulreward1, roulreward2, roulreward3,       roulname1,       roulname2,       roulname3, roultimeflag, roultimetime1, roultimetime2, roultimetime3, comment)
--values                              (         5,             1, '2013-09-01', '2023-09-01',    80000,    80001,    80006,        3015,        3015,        3015,  '콩나물 화분D', '오래된 라디오D', '콩나물 화분A',            1,             12,            18,            23, '최초내용')
--insert into dbo.tFVSystemRouletteMan(roulmarket,      roulflag,    roulstart,      roulend, roulani1, roulani2, roulani3, roulreward1, roulreward2, roulreward3,       roulname1,       roulname2,       roulname3, roultimeflag, roultimetime1, roultimetime2, roultimetime3, comment)
--values                              (         6,             1, '2013-09-01', '2023-09-01',    80000,    80001,    80006,        3015,        3015,        3015,  '콩나물 화분D', '오래된 라디오D', '콩나물 화분A',            1,             12,            18,            23, '최초내용')
--insert into dbo.tFVSystemRouletteMan(roulmarket,      roulflag,    roulstart,      roulend, roulani1, roulani2, roulani3, roulreward1, roulreward2, roulreward3,       roulname1,       roulname2,       roulname3, roultimeflag, roultimetime1, roultimetime2, roultimetime3, comment)
--values                              (         7,             1, '2013-09-01', '2023-09-01',    80000,    80001,    80006,        3015,        3015,        3015,  '콩나물 화분D', '오래된 라디오D', '콩나물 화분A',            1,             12,            18,            23, '최초내용')
*/
/*
---------------------------------------------
--		유저닉네임변경
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserNickNameChange', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserNickNameChange;
GO

create table dbo.tFVUserNickNameChange(
	idx			int 					IDENTITY(1, 1),

	--(유저정보)
	gameid		varchar(60),
	oldnickname	varchar(20)				default(''),
	newnickname	varchar(20)				default(''),
	writedate	datetime				default(getdate()),

	-- Constraint
	CONSTRAINT pk_tFVUserNickNameChange_idx	PRIMARY KEY(idx)
)
GO
--insert into dbo.tFVUserNickNameChange(gameid, oldnickname, newnickname) values('xxxx@gmail.com', 'oldname', 'newname')
*/


-- select nickname from dbo.tFVUserMaster where gameid = 'farm106522'
/*
update dbo.tFVUserMaster set cashpoint = 0, cashcost2 = 0, vippoint2 = 0, bestani = 500 where gameid = 'xxxx@gmail.com'

update dbo.tFVUserMaster set cashpoint = 0, cashcost2 = 50000, vippoint2 = 50000, bestani = 523 where gameid = 'xxxx@gmail.com'
update dbo.tFVUserMaster set cashpoint = 99000, cashcost2 = 500000 where gameid = 'xxxx@gmail.com'

*/

/*
alter table dbo.tFVUserMaster add roulette			int				default(1)
update dbo.tFVUserMaster set roulette = 1
*/

/*
select * from dbo.tFVUserData where gameid = 'farm73290'

update dbo.tFVUserData	set
		savedata = '14:0%270:9%1:24280,24281,24282,24283,24284%2:30%3:2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014%4:523,523,523,523,523,523,523,523,523,523,523,523,523,523,523,523,523,523,523,523,523,523,523,523,523,523,523,523,523,523%5:2,5,6,11,4,8,11,1,5,1,8,6,6,5,8,6,5,3,5,4,5,3,8,5,5,5,6,3,11,7%280:%6:2529%7:2%8:12%27:30072%19:4000,4001,4002,4003,4004,4005,4006,4007,4008,4009,4010,4011,4012,4013,4014,4015,4016,4017,4018,4019,4020,4021,4022,4023,4024,4025,4026,4027,4028,4029%50:132010,132010,0,0,0,0,0,0,0,0,0,0%51:264020%52:380428260%40:4000@3,4001@3,4002@3,4003@3,4004@3,4005@3,4006@3,4007@3,4008@3,4009@3,4010@3,4011@3,4012@3,4013@4,4014@3,4015@3,4016@3,4017@3,4018@3,4019@3,4020@3,4021@3,4022@3,4023@3,4024@3,4025@5,4026@3,4027@5,4028@5,4029@3%9:555667,555376,52584,555148,555109,555111,555111,555951,555585,555563,555573,525563,555548,555579,555545,5551525%100:24308%101:24320%102:24289%13:238800%21:1%22:1%23:1%260:1%28:-1%29:-1%34:%35:%30:7002,7003,7004,7001,7000%15:3698%24:127076838956%31:0,1,2,3,8,6,10,4,7,12,9,13,5,11,16,18,23,21,15,22,19,28,14,33,31,38,20,32,25,26,17,43,48,36,29,42,27,24,41,39,35,53,58,30,37,47,34,52,51,45,63,46,56,62,61,57,68,40,55,67,50,60,66,65,49%16:9%17:1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1%18:5012%25:30%36:24303%33:test_for_pc%37:com.sangsangdigital.farmgg%60:1%61:30349%62:3008%63:270%65:108%70:30%85:1,1,1,1,1,1,1,1,1,1,1,1,1,1,1%86:7,7,7,7,7,7,7,7,6,6,6,6,6,5,5%88:02/25/2015 23@47@08^02/25/2015 23@47@09^02/26/2015 01@51@54^02/26/2015 01@51@56^02/26/2015 01@51@58^02/27/2015 05@41@40^02/27/2015 05@41@41^03/01/2015 04@42@06^02/26/2015 06@32@51^02/27/2015 13@18@23^02/27/2015 13@18@24^02/27/2015 13@18@26^02/27/2015 13@18@28^02/25/2015 21@14@42^-1%93:0^70^2^7^56026@1^0^0^7^19663@2^0^0^7^4170@3^0^0^7^45538@4^194^2^7^55736@5^0^0^7^43751@6^0^0^7^4454@7^0^0^7^1840@8^0^0^6^34179@9^0^0^6^30033@10^0^0^6^47044@11^0^0^6^2389@12^0^0^6^1639@13^0^0^5^49697@14^0^0^5^825%201:11%210:0%221:11%250:30%290:3%300:02/25/2015 18@39@18'
where gameid = 'farm73290'


update dbo.tFVUserData	set
		savedata = '14:0%270:9%1:24280,24281,24282,24283,24284%2:30%3:2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014%4:523,523,523,523,523,523,523,523,523,523,523,523,523,523,523,523,523,523,523,523,523,523,523,523,523,523,523,523,523,523%5:4,4,2,4,5,2,5,4,4,2,2,8,10,10,2,3,3,4,3,4,3,2,1,11,3,4,9,6,8,2%280:%6:2529%7:2%8:17%27:30072%19:4000,4001,4002,4003,4004,4005,4006,4007,4008,4009,4010,4011,4012,4013,4014,4015,4016,4017,4018,4019,4020,4021,4022,4023,4024,4025,4026,4027,4028,4029%50:132010,132010,0,0,0,0,0,0,0,0,0,0%51:264020%52:380428260%40:4000@3,4001@3,4002@3,4003@3,4004@3,4005@3,4006@3,4007@3,4008@3,4009@3,4010@3,4011@3,4012@3,4013@4,4014@3,4015@3,4016@3,4017@3,4018@3,4019@3,4020@3,4021@3,4022@3,4023@3,4024@3,4025@5,4026@3,4027@5,4028@5,4029@3%9:209,135,68,57,40,46,37,38,25,25,29,23,17,18,13,5551525%100:24308%101:24320%102:24289%13:238800%21:1%22:1%23:1%260:1%28:-1%29:-1%34:%35:%30:7002,7003,7004,7001,7000%15:3698%24:152064129236%31:0,1,2,3,8,6,10,4,7,12,9,13,5,11,16,18,23,21,15,22,19,28,14,33,31,38,20,32,25,26,17,43,48,36,29,42,27,24,41,39,35,53,58,30,37,47,34,52,51,45,63,46,56,62,61,57,68,40,55,67,50,60,66,65,49%16:9%17:1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1%18:5012%25:30%36:24303%33:test_for_pc%37:com.sangsangdigital.farmgg%60:1%61:30349%62:3008%63:270%65:108%70:30%85:1,1,1,1,1,1,1,1,1,1,1,1,1,1,1%86:7,7,7,7,7,7,7,7,6,6,6,6,6,5,5%88:2/25/2015 11@47@08 PM^2/25/2015 11@47@09 PM^2/26/2015 1@51@54 AM^2/26/2015 1@51@56 AM^2/26/2015 1@51@58 AM^2/27/2015 5@41@40 AM^2/27/2015 5@41@41 AM^3/1/2015 4@42@06 AM^2/26/2015 6@32@51 AM^2/27/2015 1@18@23 PM^2/27/2015 1@18@24 PM^2/27/2015 1@18@26 PM^2/27/2015 1@18@28 PM^2/25/2015 9@14@42 PM^-1%93:1^0^0^7^24980@2^0^0^7^9487@3^0^0^7^50855@4^60^2^7^55736@5^0^0^7^49068@6^0^0^7^9771@7^0^0^7^7157@8^0^0^6^39496@9^0^0^6^35350@10^0^0^6^52361@11^0^0^6^7706@12^0^0^6^6956@13^0^0^5^55014@14^0^0^5^6142%201:11%210:0%221:11%250:30%290:3%300:2/25/2015 6@39@18 PM'
where gameid = 'farm73290'

-- 핸드폰
update dbo.tFVUserData	set
		savedata = '14:0%270:9%1:24280,24281,24282,24283,24284%2:30%3:2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014%4:523,523,523,523,523,523,523,523,523,523,523,523,523,523,523,523,523,523,523,523,523,523,523,523,523,523,523,523,523,523%5:11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11%280:%6:2765%7:9%8:0%27:30072%19:4000,4001,4002,4003,4004,4005,4006,4007,4008,4009,4010,4011,4012,4013,4014,4015,4016,4017,4018,4019,4020,4021,4022,4023,4024,4025,4026,4027,4028,4029%50:132010,132010,132010,132010,132010,132010,132010,132010,132010,0,0,0%51:1188090%52:755204650%40:4000@3,4001@3,4002@3,4003@3,4004@3,4005@3,4006@3,4007@3,4008@3,4009@3,4010@3,4011@3,4012@3,4013@4,4014@3,4015@3,4016@3,4017@3,4018@3,4019@3,4020@3,4021@3,4022@3,4023@3,4024@3,4025@5,4026@3,4027@5,4028@5,4029@3%9:2319879,1278584,690092,548247,429109,379772,357076,334074,320583,240900,269045,232648,191660,247763,160572,5534825%100:24308%101:24320%102:24289%13:238800%21:1%22:1%23:1%260:1%28:-1%29:-1%34:%35:%30:7002,7003,7004,7001,7000%15:3729%24:152064129236%31:0,1,2,3,8,6,10,4,7,12,9,13,5,11,16,18,23,21,15,22,19,28,14,33,31,38,20,32,25,26,17,43,48,36,29,42,27,24,41,39,35,53,58,30,37,47,34,52,51,45,63,46,56,62,61,57,68,40,55,67,50,60,66,65,49%16:9%17:1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1%18:5012%25:30%36:24303%33:test_for_pc%37:com.sangsangdigital.farmgg%60:0%61:30349%62:3014%63:225%65:114%70:30%85:1,1,1,1,1,1,1,1,1,1,1,1,1,1,1%86:7,7,7,7,7,7,7,7,6,6,6,6,6,5,5%88:2/25/2015 11@47@08 PM^2/25/2015 11@47@09 PM^2/26/2015 1@51@54 AM^2/26/2015 1@51@56 AM^2/26/2015 1@51@58 AM^2/27/2015 5@41@40 AM^2/27/2015 5@41@41 AM^3/1/2015 4@42@06 AM^2/26/2015 6@32@51 AM^2/27/2015 1@18@23 PM^2/27/2015 1@18@24 PM^2/27/2015 1@18@26 PM^2/27/2015 1@18@28 PM^2/25/2015 9@14@42 PM^-1%93:0^204^2^7^56566@1^204^2^7^57133@2^59^2^7^56718@3^92^2^7^56718@4^182^2^7^56718@5^2^2^7^56718@6^186^2^7^57129@7^96^2^7^57129@8^180^2^6^56566@9^180^2^6^56566@10^160^2^6^57129@11^180^2^6^56566@12^70^2^6^57129@13^46^2^5^57129@14^156^2^5^56566%201:11%210:0%221:11%250:30%290:4%300:2/25/2016 6@53@32 PM'
where gameid = 'farm60212'
*/




/*
alter table dbo.tFVDayLogInfoStatic add freecashcost	bigint				default(0)
alter table dbo.tFVDayLogInfoStatic add freecnt			int				default(0)
update dbo.tFVDayLogInfoStatic set freecashcost = 0, freecnt = 0

---------------------------------------------
--		무료충전
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVFreeCashLog', N'U') IS NOT NULL
	DROP TABLE dbo.tFVFreeCashLog;
GO

create table dbo.tFVFreeCashLog(
	idx			int 					IDENTITY(1, 1),			-- indexing

	--(유저정보)
	gameid		varchar(60),									-- 이메일(PK)
	bestani		int						default(500),
	cashcost	int						default(0),

	-- Constraint
	CONSTRAINT pk_tFVFreeCashLog_idx		PRIMARY KEY(idx)
)
GO

--유저로그검색
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVFreeCashLog_gameid')
    DROP INDEX tFVFreeCashLog.idx_tFVFreeCashLog_gameid
GO
CREATE INDEX idx_tFVFreeCashLog_gameid ON tFVFreeCashLog (gameid)
GO
*/

/*
--update dbo.tFVUserMaster set cashcost = cashpoint * 2, vippoint = cashpoint * 120 / 100 where cashpoint > 0
--select cashpoint, cashcost, vippoint, cashcost2, vippoint2 from dbo.tFVUserMaster where gameid = 'xxxx@gmail.com'
--select cashpoint, cashpoint * 2, cashpoint * 120 / 100 from dbo.tFVUserMaster where cashpoint > 0
-- delete from dbo.tFVUserUnusualLog2
*/

/*
alter table dbo.tFVUserMaster add 	logwrite2	int						default(1)

update dbo.tFVUserMaster set logwrite2 = 1
*/

/*
alter table dbo.tFVUserMaster add 	cashcost2	int						default(0)
alter table dbo.tFVUserMaster add 	vippoint2	int						default(0)
alter table dbo.tFVUserMaster add 	boost2		int						default(0)
alter table dbo.tFVUserMaster add 	steampack2	int						default(0)
alter table dbo.tFVUserMaster add 	compost2	int						default(0)
alter table dbo.tFVUserMaster add 	gun2		int						default(0)
alter table dbo.tFVUserMaster add 	guncho2		int						default(0)
alter table dbo.tFVUserMaster add 	house2		int						default(0)
alter table dbo.tFVUserMaster add 	alba2		int						default(0)
alter table dbo.tFVUserMaster add 	tank2		int						default(0)
alter table dbo.tFVUserMaster add 	arable2		int						default(0)
alter table dbo.tFVUserMaster add 	farmopen2	int						default(0)
alter table dbo.tFVUserMaster add 	farmbest2	int						default(0)

update dbo.tFVUserMaster set cashcost2 = 0, vippoint2 = 0,  boost2 = 0, steampack2 = 0, compost2 = 0, gun2 = 0, guncho2 = 0, house2 = 0, alba2 = 0, tank2 = 0, arable2 = 0, farmopen2 = 0, farmbest2 = 0
*/

/*
-- farm4002740		01073459002
declare @savedata varchar(4096)
declare @gameidfrom varchar(60)		set @gameidfrom	= 'farm5820809'
declare @gameidto 	varchar(60)		set @gameidto	= 'farm26926'


select @savedata = savedata from dbo.tFVUserData where gameid = @gameidfrom
update dbo.tFVUserData set savedata = @savedata where gameid = @gameidto
*/

/*


---------------------------------------------
--	유저랭킹백엄(Master)
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserRankMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserRankMaster;
GO

create table dbo.tFVUserRankMaster(
	idx				int					identity(1, 1),

	dateid			varchar(8),										-- 20121118
	step			int					default(0),
	writedate		datetime			default(getdate()), 		-- 작성일

	-- Constraint
	CONSTRAINT pk_tFVUserRankMaster_dateid	PRIMARY KEY(dateid)
)
GO
-- select * from dbo.tFVUserRankMaster where dateid = '20150216'

---------------------------------------------
--		유저랭킹백엄(Sub)
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserRankSub', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserRankSub;
GO

create table dbo.tFVUserRankSub(
	idx			int 					IDENTITY(1, 1),			-- indexing

	dateid8		varchar(8),

	rank		int,
	gameid		varchar(60),
	salemoney	bigint					default(0),
	bestani		int						default(500),
	nickname	varchar(20)				default(''),

	-- Constraint
	CONSTRAINT pk_tFVUserRankSub_dateid8_rank	PRIMARY KEY(dateid8, rank)
)
GO
*/


/*

select * from dbo.tFVGiftList where idx > 455
select * from dbo.tFVUserRankMaster
select * from dbo.tFVUserRankSub

delete from dbo.tFVGiftList where idx > 455
delete from dbo.tFVUserRankMaster
delete from dbo.tFVUserRankSub


declare @ttsalecoin		int,
		@gameid			varchar(20)

declare curUserMaster Cursor for
select top 100 gameid from dbo.tFVUserMaster

-- 2. 커서오픈
open curUserMaster

-- 3. 커서 사용
Fetch next from curUserMaster into @gameid
while @@Fetch_status = 0
	Begin
		set @ttsalecoin = Convert(int, ceiling(RAND() * 2000000))
		update dbo.tFVUserMaster		set salemoney	= @ttsalecoin				where gameid = @gameid

		Fetch next from curUserMaster into @gameid
	end
	-- 4. 커서닫기
close curUserMaster
Deallocate curUserMaster
select 'DEBUG 2. 개인 정보 랜덤입력 > 완료.'

*/






/*

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserMaster_nickname')
   DROP INDEX tFVUserMaster.idx_tFVUserMaster_nickname
GO
CREATE INDEX idx_tFVUserMaster_nickname ON tFVUserMaster (nickname)
GO

select * from dbo.tFVUserMaster where nickname = 'nn'
*/

/*

declare @gameid varchar(60) set @gameid = 'xxxx@gmail.com'
					select f.*, m.nickname from
							(select * from dbo.tFVUserFriend where gameid = @gameid) f
						JOIN
							(select gameid, nickname from dbo.tFVUserMaster where gameid in (select gameid from dbo.tFVUserFriend where gameid = @gameid)) m
							ON f.gameid = m.gameid
					order by state desc, familiar desc

-- 준식PC, 핸드폰 > 지난 랭킹
update dbo.tFVUserMaster
	set
		rankresult		= 1,		salemoneybkup	= 0,
		lmsalemoney		= 100,
		lmrank			= 1,
		lmcnt			= 5,

		l1gameid		= 'farm402222',		l1bestani		= 502,		l1salemoney		= 100,
		l2gameid		= 'farm107454',		l2bestani		= 501,		l2salemoney		= 90,
		l3gameid		= 'farm110574',		l3bestani		= 500,		l3salemoney		= 80
where gameid = 'farm402222'

update dbo.tFVUserMaster set nickname = 'nn' where gameid = 'xxxx'
update dbo.tFVUserMaster set nickname = 'nn2' where gameid = 'xxxx@gmail.com'
update dbo.tFVUserMaster set nickname = 'nn3' where gameid = 'xxxx3'
-- update dbo.tFVUserMaster set nickname = gameid where nickname = ''
*/

/*


----------------------------
-- 짜요 데몬	>  단순푸쉬
----------------------------
insert into Farm.dbo.tUserPushAndroid(recepushid,   sendid,        receid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction)
select distinct                           pushid,  'blackm', rtrim(gameid), 1,            99,  'title',  'msg',         '' from Game4FarmVill2.dbo.tFVUserMaster
	where gameid = 'farm54578'


----------------------------
-- 짜요 데몬	>  URL 푸쉬
----------------------------
insert into Farm.dbo.tUserPushAndroid(recepushid,   sendid,        receid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction)
select distinct                           pushid,  'blackm', rtrim(gameid), 3,            99,  'title',  'msg',         '' from Game4FarmVill2.dbo.tFVUserMaster
	where gameid = 'farm54578'


*/

--select * from dbo.tFVEventSub order by eventday, writedate
--delete from dbo.tFVEventSub where eventidx >= 32

/*

	-- (랭킹산출용 데이타) > 일주일 데몬에 의해서 정리됨.
alter table dbo.tFVUserMaster add 	salemoneybkup	bigint				default(0)
alter table dbo.tFVUserMaster add 	lmsalemoney		bigint				default(0)
alter table dbo.tFVUserMaster add 	lmrank			int					default(1)
alter table dbo.tFVUserMaster add 	lmcnt			int					default(1)

alter table dbo.tFVUserMaster add 	l1gameid		varchar(20)			default('')
alter table dbo.tFVUserMaster add 	l1bestani		int					default(-1)
alter table dbo.tFVUserMaster add 	l1salemoney		bigint				default(0)
alter table dbo.tFVUserMaster add 	l2gameid		varchar(20)			default('')
alter table dbo.tFVUserMaster add 	l2bestani		int					default(-1)
alter table dbo.tFVUserMaster add 	l2salemoney		bigint				default(0)
alter table dbo.tFVUserMaster add 	l3gameid		varchar(20)			default('')
alter table dbo.tFVUserMaster add 	l3bestani		int					default(-1)
alter table dbo.tFVUserMaster add 	l3salemoney		bigint				default(0)
alter table dbo.tFVUserMaster add 	rankresult		int					default(1)


update dbo.tFVUserMaster set salemoneybkup = 0, lmsalemoney	 = 0, lmrank = 1, lmcnt = 1,
	l1gameid = '', l1bestani = -1, l1salemoney = 0,
	l2gameid = '', l2bestani = -1, l2salemoney = 0,
	l3gameid = '', l3bestani = -1, l3salemoney = 0,
	rankresult = 1

---------------------------------------------
--	친구랭킹[백업스케쥴러]
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserMasterSchedule', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserMasterSchedule;
GO

create table dbo.tFVUserMasterSchedule(
	idx				int					identity(1, 1),

	dateid			varchar(8),										-- 20121118
	idxStart		int					default(0),
	writedate		datetime			default(getdate()), 		-- 작성일

	-- Constraint
	CONSTRAINT pk_tFVUserMasterSchedule_dateid	PRIMARY KEY(dateid)
)
GO
*/
-- select * from dbo.tFVUserMasterSchedule
-- if(not exist(select dateid from dbo.tFVUserMasterSchedule where dateid = '20131227'))
-- 		insert into dbo.tFVUserMasterSchedule(dateid, idxStart) values('20131227', 1)
-- update tFVUserMasterSchedule
-- 	set
--		idxStart = idx
-- where dateid = '20121118'


/*
---------------------------------------------
--		유저정보
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserData2', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserData2;
GO

create table dbo.tFVUserData2(
	idx			int 					IDENTITY(1, 1),			-- indexing

	--(유저정보)
	gameid		varchar(60),
	savedata	varchar(4096)			default('-1'),

	-- Constraint
	CONSTRAINT pk_tFVUserData2_idx	PRIMARY KEY(idx)
)
GO
*/


/*
select * from Farm.dbo.tFVUserPushAndroid
select * from Farm.dbo.tFVUserPushiPhone
select * from Farm.dbo.tUserPushAndroid
select * from Farm.dbo.tUserPushiPhone


select * from dbo.tFVUserPushAndroid
select * from dbo.tFVUserPushiPhone

DROP TABLE dbo.tFVUserPushAndroid;
DROP TABLE dbo.tFVUserPushiPhone;

select * from dbo.tFVPushBlackList
select * from Farm.dbo.tFVPushBlackList


insert into dbo.tFVPushBlackList(phone, comment) select phone, comment from Farm.dbo.tFVPushBlackList
*/

/*
---------------------------------------------
-- 	캐쉬전송
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVCashLogKakaoSend', N'U') IS NOT NULL
	DROP TABLE dbo.tFVCashLogKakaoSend;
GO

create table dbo.tFVCashLogKakaoSend(
	checkidx		int,

	-- Constraint
	CONSTRAINT	pk_tFVCashLogKakaoSend_checkidx	PRIMARY KEY(checkidx)
)




alter table dbo.tFVCashLog add kakaouserid		varchar(20)		default('')
alter table dbo.tFVCashLog add kakaouk			varchar(19)		default('')
alter table dbo.tFVCashLog add kakaosend		int				default(-1)
update dbo.tFVCashLog set kakaouserid = '', kakaouk = '', kakaosend = -1
*/




/*
declare @gameid_		varchar(20) set @gameid_ = 'xxxx@gmail.com'
declare @gameid			varchar(20)
declare @salemoney		bigint
declare @bestani		int
select @gameid = gameid, @salemoney = salemoney, @bestani = bestani from tFVUserMaster where gameid = @gameid_



select count(gameid)+1 as rank, @bestani bestani, @salemoney salemoney, @gameid gameid from dbo.tFVUserMaster where salemoney > @salemoney
union all
select top 10 rank() over(order by salemoney desc) as rank, bestani, salemoney, gameid from dbo.tFVUserMaster
*/

/*
update dbo.tFVUserMaster set heartget = 0, heartcnt = 0, heartdate = '20010101' where gameid = 'xxxx@gmail.com'
select heartget, heartcnt, heartdate from dbo.tFVUserMaster where gameid = 'xxxx@gmail.com'
exec spu_FVLogin2 'xxxx@gmail.com',  '01022223331', 5, 199, 0, -1			-- 정상유저
select heartget, heartcnt, heartdate from dbo.tFVUserMaster where gameid = 'xxxx@gmail.com'

update dbo.tFVUserMaster set heartget = 10, heartcnt = 399, heartdate = '20010101' where gameid = 'xxxx@gmail.com'
select heartget, heartcnt, heartdate from dbo.tFVUserMaster where gameid = 'xxxx@gmail.com'
exec spu_FVLogin2 'xxxx@gmail.com',  '01022223331', 5, 199, 0, -1			-- 정상유저
select heartget, heartcnt, heartdate from dbo.tFVUserMaster where gameid = 'xxxx@gmail.com'

update dbo.tFVUserMaster set heartget = 10, heartcnt = 10, heartdate = '20150203' where gameid = 'xxxx@gmail.com'
select heartget, heartcnt, heartdate from dbo.tFVUserMaster where gameid = 'xxxx@gmail.com'
exec spu_FVLogin2 'xxxx@gmail.com',  '01022223331', 5, 199, 0, -1			-- 정상유저
select heartget, heartcnt, heartdate from dbo.tFVUserMaster where gameid = 'xxxx@gmail.com'

update dbo.tFVUserMaster set heartget = 10, heartcnt = 399, heartdate = '20150203' where gameid = 'xxxx@gmail.com'
select heartget, heartcnt, heartdate from dbo.tFVUserMaster where gameid = 'xxxx@gmail.com'
exec spu_FVLogin2 'xxxx@gmail.com',  '01022223331', 5, 199, 0, -1			-- 정상유저
select heartget, heartcnt, heartdate from dbo.tFVUserMaster where gameid = 'xxxx@gmail.com'
*/
/*

update dbo.tFVUserMaster set heartget = @p4_ where gameid = @gameid
update dbo.tFVUserMaster set heartcnt = @p4_ where gameid = @gameid
update dbo.tFVUserMaster set heartdate = '20100101' where gameid = @gameid
*/


/*
alter table dbo.tFVUserMaster add heartdate	varchar(8)				default('20100101')
update dbo.tFVUserMaster set heartdate = '20100101'
*/


/*
alter table dbo.tFVUserMaster add bestani		int						default(500)
alter table dbo.tFVUserMaster add weekscore	bigint					default(0)
update dbo.tFVUserMaster set bestani = 500, weekscore = 0
*/


--exec spu_FVUserCreate 'iuest33290',   '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 101, '01033', '', 'kakaotalkidiuest33290', 'kakaouseridiuest33290', '', '', -1, '', -1


/*
select * from dbo.tFVKakaoInvite

---------------------------------------------
-- 	캐쉬전송
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVCashLogKakaoSend', N'U') IS NOT NULL
	DROP TABLE dbo.tFVCashLogKakaoSend;
GO

create table dbo.tFVCashLogKakaoSend(
	checkidx		int,

	-- Constraint
	CONSTRAINT	pk_tFVCashLogKakaoSend_checkidx	PRIMARY KEY(checkidx)
)
*/


/*
select
	'insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) value('
	+ ltrim(str(eventstatedaily)) + ', '
	+ ltrim(str(eventitemcode)) + ', '
	+ ltrim(str(eventcnt)) + ', '
	+ ltrim(str(eventday)) + ', '
	+ ltrim(str(eventstarthour)) + ', '
	+ ltrim(str(eventendhour)) + ', '
	+ '''' + eventpushtitle + '''' + ', '
	+ '''' + eventpushmsg + '''' + ', '
	+ ltrim(str(eventpushstate))+ ')'
from dbo.tFVEventSub order by eventidx asc
*/


/*
insert into dbo.tFVUserBlockPhone(phone, comment) values('01022223335', '아이템카피')
select * from dbo.tFVKakaoMaster where gameid like 'xxxx%'
select kakaostatus, kakaouserid, * from dbo.tFVUserMaster where kakaouserid like 'kakaouserid%'
select * from dbo.tFVUserFriend
*/


/*
---------------------------------------------
-- 	매일통계관리
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVDayLogInfoStatic', N'U') IS NOT NULL
	DROP TABLE dbo.tFVDayLogInfoStatic;
GO

create table dbo.tFVDayLogInfoStatic(
	idx				int				IDENTITY(1,1),

	dateid8			varchar(8),
	market			int				default(1),

	joinplayercnt	int				default(0),					-- 일 일반가입
	joinguestcnt	int				default(0),					-- 일 일반가입
	joinukcnt		int				default(0),					-- 일 유니크 가입
	invitekakao		int				default(0),					-- 일 카카오 초대.
	kakaoheartcnt	int				default(0),					-- 일 카카오 하트.

	logincnt		int				default(0),					-- 일 로그인
	logincnt2		int				default(0),					-- 일 로그인(유니크)

	rtnrequest		int				default(0),					-- 일 복귀요청수
	rtnrejoin		int				default(0),					-- 일 복귀수

	certnocnt		int				default(0),					-- 일 쿠폰등록수.

	pushandroidcnt	int				default(0),					-- 안드로이드통계.
	pushiphonecnt	int				default(0),					-- 아이폰통계.


	-- Constraint
	CONSTRAINT	pk_tFVDayLogInfoStatic_idx	PRIMARY KEY(idx)
)
-- alter table dbo.tFVDayLogInfoStatic add certnocnt		int				default(0)
-- alter table dbo.tFVDayLogInfoStatic add revivalcnt		int				default(0)
-- alter table dbo.tFVDayLogInfoStatic add revivalcntcash	int				default(0)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVDayLogInfoStatic_dateid8_market')
    DROP INDEX tFVDayLogInfoStatic.idx_tFVDayLogInfoStatic_dateid8_market
GO
CREATE INDEX idx_tFVDayLogInfoStatic_dateid8_market ON tFVDayLogInfoStatic(dateid8, market)
GO

-- insert into dbo.tFVDayLogInfoStatic(dateid8) values('20130827')
-- select top 100 * from dbo.tFVDayLogInfoStatic order by idx desc

*/

/*
---------------------------------------------
--		Kakao Master
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVKakaoMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tFVKakaoMaster;
GO

create table dbo.tFVKakaoMaster(
	idx				int					IDENTITY(1,1),

	kakaouserid		varchar(60),
	kakaotalkid		varchar(60),
	gameid			varchar(60),
	cnt				int					default(1),					-- 보유량
	cnt2			int					default(0),
	kakaodata		int					default(1),					-- 카톡유저(1), 게스트유저(1)
	writedate		datetime			default(getdate()),
	deldate			datetime			default(getdate() - 1),

	-- Constraint
	CONSTRAINT	pk_tFVKakaoMaster_kakaotalkid	PRIMARY KEY(kakaouserid)
)

--IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVKakaoMaster_kakaotalkid')
--    DROP INDEX tFVKakaoMaster.idx_tFVKakaoMaster_kakaotalkid
--GO
--CREATE INDEX idx_tFVKakaoMaster_kakaotalkid ON tFVKakaoMaster (kakaotalkid)
--GO
--
--IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVKakaoMaster_idx')
--    DROP INDEX tFVKakaoMaster.idx_tFVKakaoMaster_idx
--GO
--CREATE INDEX idx_tFVKakaoMaster_idx ON tFVKakaoMaster (idx)
--GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVKakaoMaster_gameid')
    DROP INDEX tFVKakaoMaster.idx_tFVKakaoMaster_gameid
GO
CREATE INDEX idx_tFVKakaoMaster_gameid ON tFVKakaoMaster (gameid)
GO

---------------------------------------------
--		Kakao 초대
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVKakaoInvite', N'U') IS NOT NULL
	DROP TABLE dbo.tFVKakaoInvite;
GO

create table dbo.tFVKakaoInvite(
	idx				int					IDENTITY(1,1),

	gameid			varchar(60),
	receuserid		varchar(60),
	cnt				int					default(1),
	senddate		datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tFVKakaoInvite_idx	PRIMARY KEY(idx)
)

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVKakaoInvite_gameid_receuserid')
    DROP INDEX tFVKakaoInvite.idx_tFVKakaoInvite_gameid_receuserid
GO
CREATE INDEX idx_tFVKakaoInvite_gameid_receuserid ON tFVKakaoInvite (gameid, receuserid)
GO

-- select top 1 * from dbo.tFVKakaoInvite where gameid = 'xxxx@gmail.com' and receuserid = 'kakaotalkid13'
-- select datediff(d, '2014-03-01 12:20', '2014-03-06 12:20')	-- 5일차
-- insert into dbo.tFVKakaoInvite(gameid, receuserid) values('xxxx@gmail.com', 'kakaotalkid13')
-- update dbo.tFVKakaoInvite
--	set
--		cnt = cnt + 1,
--		senddate = getdate()
--	where gameid = 'xxxx@gmail.com' and receuserid = 'kakaotalkid13'
*/

/*
---------------------------------------------
--	유니크 가입현황파악하기
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserPhone', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserPhone;
GO

create table dbo.tFVUserPhone(
	idx					int 				IDENTITY(1, 1),

	phone				varchar(20),
	market				int					default(1),
	joincnt				int					default(1),
	writedate			datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tFVUserPhone_idx	PRIMARY KEY(idx)
)
-- 폰인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserPhone_phone')
    DROP INDEX tFVUserPhone.idx_tFVUserPhone_phone
GO
CREATE INDEX idx_tFVUserPhone_phone ON tFVUserPhone (phone)
GO
-- select top 1 * from dbo.tFVUserPhone
*/


--select * from dbo.tFVUserBlockPhone

/*
alter table dbo.tFVUserMaster add 	vippoint	int						default(0)
update dbo.tFVUserMaster set vippoint = 0
*/
--select * from dbo.tFVUserMaster
/*
alter table dbo.tFVUserMaster add buytype		int					default(0)
update dbo.tFVUserMaster set buytype = 0


alter table dbo.tFVDayLogInfoStatic add joinukcnt2		int				default(0)
update dbo.tFVDayLogInfoStatic set joinukcnt2 = 0
*/

--update dbo.tFVUserMaster set buytype = 1 where gameid = '107146341108081809922'

/*
alter table dbo.tFVUserMaster add eventspot07		int					default(0)
alter table dbo.tFVUserMaster add eventspot08		int					default(0)
alter table dbo.tFVUserMaster add eventspot09		int					default(0)

update dbo.tFVUserMaster set eventspot06 = 0, eventspot07 = 0, eventspot08 = 0, eventspot09 = 0
*/


/*
-- delete from dbo.tFVGiftList where gameid = 'xxxx@gmail.com'
-- update dbo.tFVCashLog set writedate = '2014-12-30'
-- 2014-12-27 ~ 2014-12-30 10:18
-- select * from dbo.tFVCashLog
declare @EVENT01_START_DAY	datetime		set @EVENT01_START_DAY						= '2014-12-27'
declare @EVENT01_END_DAY	datetime		set @EVENT01_END_DAY						= '2014-12-31 10:30'
declare @EVENT02_ITEMCODE	int				set @EVENT02_ITEMCODE		= 3015	-- 우유결정 100%
declare @gameid				varchar(60)		set @gameid					= ''
declare @cash				int				set @cash					= 0
declare @pluscashcost		int				set @pluscashcost			= 0


-- 1. 선언하기.
declare curUserMessage Cursor for
select gameid, cash from dbo.tFVCashLog where writedate >= @EVENT01_START_DAY and writedate <= @EVENT01_END_DAY


-- 2. 커서오픈
open curUserMessage

-- 3. 커서 사용
Fetch next from curUserMessage into @gameid, @cash
while @@Fetch_status = 0
	Begin



		set @pluscashcost = case
								when @cash in (5000)  then   5000
								when @cash in (10000) then  12000
								when @cash in (30000) then  39000
								when @cash in (55000) then  77000
								when @cash in (99000) then 148500
								else 0
						end

		--select @gameid gameid, @cash cash, @pluscashcost pluscashcost
		exec spu_FVSubGiftSend 2, @EVENT02_ITEMCODE, @pluscashcost, 'vipevent', @gameid, ''
		Fetch next from curUserMessage into @gameid, @cash
	end

-- 4. 커서닫기
close curUserMessage
Deallocate curUserMessage
*/


/*
declare @gameid varchar(60) set @gameid = '108896905679422200740'
select * from dbo.tFVUserData where gameid = @gameid

insert into dbo.tFVUserData(gameid, savestate, savedata)
select @gameid, savestate, savedata from dbo.tFVUserData where gameid = @gameid and market = 5

insert into dbo.tFVUserData(gameid, savestate, savedata)
select @gameid, savestate, savedata from dbo.tFVUserData where gameid = @gameid and market = 5
*/

/*
-- 세이브파일 연동
-- 내것 Org 	-- 109661327975685722362
				-- 103066420248652848154
-- 준식PC 		-- za1xs2cd3vf4
-- delete from dbo.tFVUserData where gameid = '103066420248652848154'
declare @gameid varchar(60) set @gameid = '103066420248652848154'
select * from dbo.tFVUserData where gameid = @gameid

insert into dbo.tFVUserData(gameid, savestate, savedata)
select @gameid, savestate, savedata from dbo.tFVUserData where gameid = '109661327975685722362'


declare @loop int
set @loop = 3000
while (@loop < 3015)
	begin
		exec spu_FVSubGiftSend 2, @loop, 20000, '강제전송', '109661327975685722362', ''			-- 유제품
		set @loop = @loop + 1
	end
exec spu_FVSubGiftSend 2, 3100, 2000000000, '강제전송', '109661327975685722362', ''				-- 코인
exec spu_FVSubGiftSend 2, 3200, 50000, '강제전송', '109661327975685722362', ''					-- VIP
exec spu_FVSubGiftSend 2, 3015, 500000, '강제전송', '109661327975685722362', ''					-- 결정


declare @loop int
set @loop = 3000
while (@loop < 3015)
	begin
		exec spu_FVSubGiftSend 2, @loop, 20000, '강제전송', '103066420248652848154', ''			-- 유제품
		set @loop = @loop + 1
	end
exec spu_FVSubGiftSend 2, 3100, 2000000000, '강제전송', '103066420248652848154', ''				-- 코인
exec spu_FVSubGiftSend 2, 3200, 50000, '강제전송', '103066420248652848154', ''					-- VIP
exec spu_FVSubGiftSend 2, 3015, 500000, '강제전송', '109661327975685722362', ''					-- 결정




declare @loop int
set @loop = 3000
while (@loop < 3015)
	begin
		exec spu_FVSubGiftSend 2, @loop, 20000, '강제전송', '101865416115406975127', ''			-- 유제품
		set @loop = @loop + 1
	end
exec spu_FVSubGiftSend 2, 3100, 2000000000, '강제전송', '101865416115406975127', ''				-- 코인
exec spu_FVSubGiftSend 2, 3200, 50000, '강제전송', '101865416115406975127', ''					-- VIP
exec spu_FVSubGiftSend 2, 3015, 500000, '강제전송', '101865416115406975127', ''					-- 결정

*/

/*
use Farm
GO


IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserData_idx')
   DROP INDEX tFVUserData.idx_tFVUserData_idx
GO
CREATE INDEX idx_tFVUserData_idx ON tFVUserData (idx)
GO
*/


/*
use Farm
GO

-- select * from dbo.tFVUserData
--update dbo.tFVUserData set savedata = ''
---------------------------------------------
--		유저정보
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserData', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserData;
GO

create table dbo.tFVUserData(
	idx			int 					IDENTITY(1, 1),			-- indexing

	--(유저정보)
	gameid		varchar(60),
	market		int						default(5),				-- (구매처코드)
	savestate	int						default(1),				-- 1(save), -1(읽어감)
	savedata	varchar(4096)			default('-1'),

	-- Constraint
	CONSTRAINT pk_tFVUserData_gameid_market	PRIMARY KEY(gameid, market)
)
GO


---------------------------------------------------
--	추천게임
---------------------------------------------------
IF OBJECT_ID (N'dbo.tFVSysRecommend2', N'U') IS NOT NULL
	DROP TABLE dbo.tFVSysRecommend2;
GO

create table dbo.tFVSysRecommend2(
	idx				int				IDENTITY(1,1), 			-- 번호
	packmarket		varchar(40)		default('1,2,3,4,5,6,7'),

	comfile			varchar(512)	default(''),
	comurl			varchar(512)	default(''),
	compackname		varchar(512)	default(''),
	rewarditemcode	int 			default(0),
	rewardcnt		int 			default(0),

	syscheck		int				default(-1),			-- 1:서비스중 	-1:보류
	ordering		int				default(0),				-- 높은것이 나옴.
	writedate		datetime		default(getdate()), 	-- 작성일

	-- Constraint
	CONSTRAINT	pk_tFVSysRecommend2_idx	PRIMARY KEY(idx)
)


---------------------------------------------------
--	추천게임 로고
---------------------------------------------------
IF OBJECT_ID (N'dbo.tFVSysRecommendLog', N'U') IS NOT NULL
	DROP TABLE dbo.tFVSysRecommendLog;
GO

create table dbo.tFVSysRecommendLog(
	idx				int				IDENTITY(1,1), 			-- 번호

	gameid			varchar(60),
	recommendidx	int 			default(0),
	writedate		datetime		default(getdate()), 	-- 작성일

	-- Constraint
	CONSTRAINT	pk_tFVSysRecommendLog_idx	PRIMARY KEY(idx)
)


*/



/*
alter table dbo.tFVUserMaster add eventspot06		int					default(0)
update dbo.tFVUserMaster set eventspot06 = 0
*/

/*
---------------------------------------------
--		이벤트 마스터
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVEventMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tFVEventMaster;
GO

create table dbo.tFVEventMaster(
	idx						int					IDENTITY(1,1),
	eventstatemaster		int					default(0),		-- 0:대기중, 1:진행중, 2:완료중

	-- Constraint
	CONSTRAINT	pk_tFVEventMaster_eventstatemaster	PRIMARY KEY(eventstatemaster)
)
-- 처음 데이타는 넣어줘야한다.
-- insert into dbo.tFVEventMaster(eventstatemaster) values(0)
-- update dbo.tFVEventMaster set eventstatemaster = case when eventstatemaster = 0 then 1 else 0 end where idx = 1
-- select eventstatemaster from dbo.tFVEventMaster where idx = 1

---------------------------------------------
--		이벤트 서브
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVEventSub', N'U') IS NOT NULL
	DROP TABLE dbo.tFVEventSub;
GO

create table dbo.tFVEventSub(
	eventidx		int					IDENTITY(1,1),
	eventstatedaily	int					default(0),					-- 0:EVENT_STATE_NON, 1:ING, 2:_END
	eventitemcode	int					default(-1),
	eventcnt		int					default(0),
	eventsender		varchar(60)			default('sangsang'),
	eventday		int					default(0),
	eventstarthour	int					default(0),
	eventendhour	int					default(0),

	eventpushtitle	varchar(512)		default(''),				-- 푸쉬 제목, 내용, 상태
	eventpushmsg	varchar(512)		default(''),				--
	eventpushstate	int					default(0),					-- 0:EVENT_PUSH_NON, 1:EVENT_PUSH_SEND

	writedate		datetime			default(getdate()),
	CONSTRAINT	pk_tFVEventSub_eventidx	PRIMARY KEY(eventidx)
)

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVEventSub_eventday_eventstarthour_eventendhour')
    DROP INDEX tFVEventSub.idx_tFVEventSub_eventday_eventstarthour_eventendhour
GO
CREATE INDEX idx_tFVEventSub_eventday_eventstarthour_eventendhour ON tFVEventSub (eventday, eventstarthour, eventendhour)
GO

--insert into dbo.tFVEventSub(eventitemcode,  eventsender,  eventday, eventstarthour, eventendhour,  eventpushtitle, eventpushmsg)
--values(                            1000,  'sangsang',         1,             12,           18,  '푸쉬 제목1',   '푸쉬 내용1')
--insert into dbo.tFVEventSub(eventitemcode,  eventsender,  eventday, eventstarthour, eventendhour,  eventpushtitle, eventpushmsg)
--values(                            1000,  'sangsang',         1,             19,           24,  '푸쉬 제목1-2',   '푸쉬 내용1-2')
--update dbo.tFVEventSub
--	set
--		eventstatedaily	= 1,
--		eventitemcode 	= 1000,
--		eventday		= 1,
--		eventstarthour	= 12,
--		eventendhour	= 18,
--		eventsender		= 'sangsang',
--		eventpushtitle	= '푸쉬 제목1',
--		eventpushmsg	= '푸쉬 내용1'
--where eventidx = 1
--update dbo.tFVEventSub set eventstatedaily	= 1 where eventidx = 2
--declare @curdate datetime 	set @curdate = '2014-09-02 23:59'
--declare @dd int 			set @dd = DATEPART(dd, @curdate)
--declare @hour int 			set @hour = DATEPART(hour, @curdate)
--select * from dbo.tFVEventSub where @dd = eventday and eventstarthour <= @hour and @hour <= eventendhour and eventstatedaily = 1
--select top 100 * from dbo.tFVEventSub order by eventidx desc



---------------------------------------------
--		이벤트 받아간 유저로그
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVEvnetUserGetLog', N'U') IS NOT NULL
	DROP TABLE dbo.tFVEvnetUserGetLog;
GO

create table dbo.tFVEvnetUserGetLog(
	idx				int					IDENTITY(1,1),

	gameid			varchar(60),
	eventidx		int,
	eventitemcode	int,
	writedate		datetime			default(getdate()),
	CONSTRAINT		pk_tFVEvnetUserGetLog_eventidx	PRIMARY KEY(idx)
)

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVEvnetUserGetLog_gameid_eventidx')
    DROP INDEX tFVEvnetUserGetLog.idx_tFVEvnetUserGetLog_gameid_eventidx
GO
CREATE INDEX idx_tFVEvnetUserGetLog_gameid_eventidx ON tFVEvnetUserGetLog (gameid, eventidx)
GO

-- insert into dbo.tFVEvnetUserGetLog(gameid, eventidx, eventitemcode) values( 'xxxx@gmail.com', 1, 1104)
-- select * from dbo.tFVEvnetUserGetLog where gameid = 'xxxx@gmail.com' and eventidx = 1

*/












/*

select m.gameid, m.regdate, c.cash
from dbo.tFVUserMaster m
	JOIN
	(select gameid, SUM(cash) cash from dbo.tFVCashLog group by gameid) c
	ON m.gameid = c.gameid
	order by 2 desc


select top 10 * from dbo.tFVUserMaster
*/


/*
-- 쪽지 발송
declare @gameid 	varchar(60),
		@concode	int,
		@message1 	varchar(256),
		@message2 	varchar(256)

set @message1 = '게임을 삭제하실 경우 게임 세이브 데이터가 초기화됩니다. 게임을 업데이트를 하실 때 저장공간을 충분히 마련하시고 업데이트를 진행해주시길 부탁드립니다.'
set @message2 = 'If you delete the game save data will be initialized.'


-- 1. 선언하기.
declare curUserMessage Cursor for
select gameid, concode from dbo.tFVUserMaster

-- 2. 커서오픈
open curUserMessage

-- 3. 커서 사용
Fetch next from curUserMessage into @gameid, @concode
while @@Fetch_status = 0
	Begin
		if(@concode = 82)
			begin
				exec spu_FVSubGiftSend 1,   -1,   0, 'SangSang', @gameid, @message1
				--select @message1
			end
		else
			begin
				exec spu_FVSubGiftSend 1,   -1,   0, 'SangSang', @gameid, @message2
				--select @message2
			end
		Fetch next from curUserMessage into @gameid, @concode
	end

-- 4. 커서닫기
close curUserMessage
Deallocate curUserMessage

*/

--alter table dbo.tFVEventCertNoBack add market		int				default(5)
--update dbo.tFVEventCertNoBack set market = 5

/*
DROP INDEX tFVEventCertNoBack.idx_tFVEventCertNoBack_gameid_kind

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVEventCertNoBack_gameid_kind_market')
    DROP INDEX tFVEventCertNoBack.idx_tFVEventCertNoBack_gameid_kind_market
GO
CREATE INDEX idx_tFVEventCertNoBack_gameid_kind_market ON tFVEventCertNoBack (gameid, kind, market)
GO
*/


/*
---------------------------------------------
--		유저정보
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserData', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserData;
GO

create table dbo.tFVUserData(
	idx			int 					IDENTITY(1, 1),			-- indexing

	--(유저정보)
	gameid		varchar(60),
	savestate	int						default(1),				-- 1(save), -1(읽어감)
	savedata	varchar(4096)			default('-1'),

	-- Constraint
	CONSTRAINT pk_tFVUserData_gameid	PRIMARY KEY(gameid)
)
GO
*/

/*
alter table dbo.tFVUserData add pushid		varchar(256)			default('')
update dbo.tFVUserData set pushid = ''
*/


/*
alter table dbo.tFVUserMaster add concode		int						default(82)
update dbo.tFVUserMaster set concode = 82

alter table dbo.tFVUserMaster add randserial	varchar(20)			default('-1')
alter table dbo.tFVUserMaster add bgitemcode1	int						default(-1)
alter table dbo.tFVUserMaster add bgitemcode2	int						default(-1)
alter table dbo.tFVUserMaster add bgitemcode3	int						default(-1)
alter table dbo.tFVUserMaster add bgcnt1		int						default(0)
alter table dbo.tFVUserMaster add bgcnt2		int						default(0)
alter table dbo.tFVUserMaster add bgcnt3		int						default(0)
update dbo.tFVUserMaster set bgitemcode1 = -1, bgitemcode2 = -1, bgitemcode3 = -1, bgcnt1 = 0, bgcnt2 = 0, bgcnt3 = 0, randserial = '-1'



alter table dbo.tFVDayLogInfoStatic add certnocnt		int				default(0)
update dbo.tFVDayLogInfoStatic set certnocnt = 0
*/

/*
-- select 'insert into dbo.tFVEventCertNo(certno,  itemcode1,  cnt1,  itemcode2,  cnt2,  itemcode3,  cnt3, kind) values(''' + certno + ''',' + str(itemcode1) + ',  ' + str(cnt1) + ',  ' + str(itemcode2) + ',  ' + str(cnt2) + ',  ' + str(itemcode3) + ',  ' + str(cnt3) + ',  ' + str(kind) + ')' from dbo.tFVEventCertNo where kind = 1
select max(idx) from dbo.tFVEventCertNo where kind = 1
select * from dbo.tFVEventCertNo where kind = 1
*/


/*


---------------------------------------------
-- 이벤트 인증키값
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVEventCertNo', N'U') IS NOT NULL
	DROP TABLE dbo.tFVEventCertNo;
GO

create table dbo.tFVEventCertNo(
	idx			int				identity(1, 1),
	certno		varchar(16),

	itemcode1	int				default(-1),
	itemcode2	int				default(-1),
	itemcode3	int				default(-1),

	cnt1		int				default(0),
	cnt2		int				default(0),
	cnt3		int				default(0),

	kind		int				default(0),

	CONSTRAINT	pk_tFVEventCertNo_idx	PRIMARY KEY(idx)
)
-- 인증번호 인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVEventCertNo_certno')
    DROP INDEX tFVEventCertNo.idx_tFVEventCertNo_certno
GO
CREATE INDEX idx_tFVEventCertNo_certno ON tFVEventCertNo (certno)
GO

---------------------------------------------
-- 이벤트 인증키값(백업)
-- 누구에게 무슨아이템을 지급했다.
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVEventCertNoBack', N'U') IS NOT NULL
	DROP TABLE dbo.tFVEventCertNoBack;
GO

create table dbo.tFVEventCertNoBack(
	idx			int				identity(1, 1),
	certno		varchar(16),

	gameid		varchar(60),
	itemcode1	int				default(-1),
	itemcode2	int				default(-1),
	itemcode3	int				default(-1),

	cnt1		int				default(0),
	cnt2		int				default(0),
	cnt3		int				default(0),

	usedtime	datetime		default(getdate()),
	kind		int				default(0),

	CONSTRAINT	pk_tFVEventCertNoBack_idx	PRIMARY KEY(idx)
)

-- 인증번호 인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVEventCertNoBack_certno')
    DROP INDEX tFVEventCertNoBack.idx_tFVEventCertNoBack_certno
GO
CREATE INDEX idx_tFVEventCertNoBack_certno ON tFVEventCertNoBack (certno)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVEventCertNoBack_gameid_kind')
    DROP INDEX tFVEventCertNoBack.idx_tFVEventCertNoBack_gameid_kind
GO
CREATE INDEX idx_tFVEventCertNoBack_gameid_kind ON tFVEventCertNoBack (gameid, kind)
GO



---------------------------------------------
--		아이템 보유정보
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVGiftList', N'U') IS NOT NULL
	DROP TABLE dbo.tFVGiftList;
GO

create table dbo.tFVGiftList(
	idx			bigint				IDENTITY(1,1),
	idx2		int,

	gameid		varchar(60),									-- gameid별 itemcode는 중복이 발생한다.
	giftkind	int					default(0),					-- 1:메시지, 2:선물, -1:메시지삭제, -2:선물받아감

	message		varchar(256)		default(''), 				-- 메세지(1)

	itemcode	int					default(-1),				-- 선물(2)
	cnt			int					default(0),
	gainstate	int					default(0),					-- 가져간상태	0:안가져감, 1:가져감
	gaindate	datetime, 										-- 가져간날
	giftid		varchar(60)			default('SangSang'),		-- 선물한 유저
	giftdate	datetime			default(getdate()), 		-- 선물일

	-- Constraint
	CONSTRAINT	pk_tFVGiftList_idx	PRIMARY KEY(idx)
)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVGiftList_gameid_idx')
    DROP INDEX tFVGiftList.idx_tFVGiftList_gameid_idx
GO
CREATE INDEX idx_tFVGiftList_gameid_idx ON tFVGiftList (gameid, idx)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVGiftList_gameid_idx2')
    DROP INDEX tFVGiftList.idx_tFVGiftList_gameid_idx2
GO
CREATE INDEX idx_tFVGiftList_gameid_idx2 ON tFVGiftList (gameid, idx2)
GO



*/


-- select * from dbo.tFVGiftList where gameid = 'xxxx' order by idx desc
-- insert into dbo.tFVGiftList(gameid, giftkind, message) values('xxxx', 1, 'Shot message');
-- insert into dbo.tFVGiftList(gameid, giftkind, itemcode, giftid) values('xxxx', 2, 1, 'SangSang');




/*
select * from dbo.tFVUserPushSendInfo

alter table dbo.tFVUserPushSendInfo add msgurl			varchar(512)	default('')
update dbo.tFVUserPushSendInfo set msgurl = 'market://details?id=com.sangsangdigital.farmvill'



--alter table dbo.tFVPushBlackList add writedate		datetime			default(getdate())
--update dbo.tFVPushBlackList set writedate = getdate()
*/

/*
---------------------------------------------
--	PushBlackList
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVPushBlackList', N'U') IS NOT NULL
	DROP TABLE dbo.tFVPushBlackList;
GO

create table dbo.tFVPushBlackList(
	idx				int				identity(1, 1),

	phone			varchar(20),
	comment			varchar(512),

	-- Constraint
	CONSTRAINT	pk_tFVPushBlackList_idx	PRIMARY KEY(idx)
)
insert into dbo.tFVPushBlackList(phone, comment) values('01036630157', '김세훈대표')
insert into dbo.tFVPushBlackList(phone, comment) values('01055841110', '이대성 과장')
insert into dbo.tFVPushBlackList(phone, comment) values('01051955895', '이정우')
insert into dbo.tFVPushBlackList(phone, comment) values('01043358319', '김남훈')
insert into dbo.tFVPushBlackList(phone, comment) values('01089114806', '김용민')
insert into dbo.tFVPushBlackList(phone, comment) values('0183302149', '채문기')
insert into dbo.tFVPushBlackList(phone, comment) values('01050457694', '이영지')
insert into dbo.tFVPushBlackList(phone, comment) values('01048742835', '윤인좌 대리')
insert into dbo.tFVPushBlackList(phone, comment) values('01024065144', '운영 김범수')
insert into dbo.tFVPushBlackList(phone, comment) values('01027624701', '서버 김선일')
insert into dbo.tFVPushBlackList(phone, comment) values('01090196756', '픽토_호스팅업체')
--select * from dbo.tFVPushBlackList

---------------------------------------------
--	Android Push Service
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserPushAndroid', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserPushAndroid;
GO

create table dbo.tFVUserPushAndroid(
	idx				int				identity(1, 1),

	sendid			varchar(20),
	receid			varchar(20),
	recepushid		varchar(256),
	sendkind		int,

	msgpush_id		int				default(99),
	msgtitle		varchar(512),
	msgmsg			varchar(512),
	msgaction		varchar(512)	default('LAUNCH'),

	actionTime		datetime		default(getdate()),
	scheduleTime	datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tFVUserPushAndroid_idx	PRIMARY KEY(idx)
)
-- select top 1 * from dbo.tFVUserPushAndroid

-- 내폰
--insert into dbo.tFVUserPushAndroid(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73801', 'guest73801', 'APA91bF6Y96_WIvc3jQH83B2QoTUkcDcX2KAp6A5AGQfMQ_V4LZOjzKe7Wr-IVgXz-a2XS1A8hUIUZ6-0NmWkfkkQLqUMSYikMGA_P1Ejj42Z4e_VxRth84WJkMuhGjbvWUuwAVUdn90R5wlYe6P2W4hLMsyU8FeWjEXcHzFbRe2Fj8lH4CoOL0', 1, 99, '홈런리그제목', '홈런리그 내용푸쉬로 날려요.', 'LAUNCH')
--insert into dbo.tFVUserPushAndroid(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73801', 'guest73801', 'APA91bF6Y96_WIvc3jQH83B2QoTUkcDcX2KAp6A5AGQfMQ_V4LZOjzKe7Wr-IVgXz-a2XS1A8hUIUZ6-0NmWkfkkQLqUMSYikMGA_P1Ejj42Z4e_VxRth84WJkMuhGjbvWUuwAVUdn90R5wlYe6P2W4hLMsyU8FeWjEXcHzFbRe2Fj8lH4CoOL0', 1, 99, '홈런리그제목url', '홈런리그 내용푸쉬로 날려요.url', 'http://m.naver.com')
-- 진혁폰
--insert into dbo.tFVUserPushAndroid(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73799', 'guest73799', 'APA91bE5TtZI1T81gIpHN1o1IZuasNwm0PoaiG2xYDzOJ6AkW2H148vKqUdy7Oh1in0F-OZUo1VxUbwnNt-Jg1blX7c6sJ7wf92vzIsDy9sRBCtJK4GhauekcatxyM7rS_pvEla4A5Tj3GWQEH3JFOZFZSIrK4UDa7FZxUwLiWZpNrceCqaRct4', 1, 99, '홈런리그제목', '홈런리그 내용푸쉬로 날려요.', 'LAUNCH')
--insert into dbo.tFVUserPushAndroid(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73799', 'guest73799', 'APA91bE5TtZI1T81gIpHN1o1IZuasNwm0PoaiG2xYDzOJ6AkW2H148vKqUdy7Oh1in0F-OZUo1VxUbwnNt-Jg1blX7c6sJ7wf92vzIsDy9sRBCtJK4GhauekcatxyM7rS_pvEla4A5Tj3GWQEH3JFOZFZSIrK4UDa7FZxUwLiWZpNrceCqaRct4', 1, 99, '홈런리그제목url', '홈런리그 내용푸쉬로 날려요.url', 'http://m.naver.com')
--


---------------------------------------------
--	iPhone Push Service
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserPushiPhone', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserPushiPhone;
GO

create table dbo.tFVUserPushiPhone(
	idx				int				identity(1, 1),

	sendid			varchar(20),
	receid			varchar(20),
	recepushid		varchar(256),
	sendkind		int,

	msgpush_id		int				default(99),
	msgtitle		varchar(512),
	msgmsg			varchar(512),
	msgaction		varchar(512)	default('LAUNCH'),

	actionTime		datetime		default(getdate()),
	scheduleTime	datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tFVUserPushiPhone_idx	PRIMARY KEY(idx)
)
--select * from dbo.tFVUserPushiPhone
---- Push입력하기
--insert into dbo.tFVUserPushiPhone(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73801', 'guest73801', 'APA91bF6Y96_WIvc3jQH83B2QoTUkcDcX2KAp6A5AGQfMQ_V4LZOjzKe7Wr-IVgXz-a2XS1A8hUIUZ6-0NmWkfkkQLqUMSYikMGA_P1Ejj42Z4e_VxRth84WJkMuhGjbvWUuwAVUdn90R5wlYe6P2W4hLMsyU8FeWjEXcHzFbRe2Fj8lH4CoOL0', 1, 99, '홈런리그제목', '홈런리그 내용푸쉬로 날려요.', 'LAUNCH')
--insert into dbo.tFVUserPushiPhone(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73801', 'guest73801', 'APA91bF6Y96_WIvc3jQH83B2QoTUkcDcX2KAp6A5AGQfMQ_V4LZOjzKe7Wr-IVgXz-a2XS1A8hUIUZ6-0NmWkfkkQLqUMSYikMGA_P1Ejj42Z4e_VxRth84WJkMuhGjbvWUuwAVUdn90R5wlYe6P2W4hLMsyU8FeWjEXcHzFbRe2Fj8lH4CoOL0', 1, 99, '홈런리그제목url', '홈런리그 내용푸쉬로 날려요.url', 'http://m.naver.com')
--insert into dbo.tFVUserPushiPhone(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73799', 'guest73799', 'APA91bE5TtZI1T81gIpHN1o1IZuasNwm0PoaiG2xYDzOJ6AkW2H148vKqUdy7Oh1in0F-OZUo1VxUbwnNt-Jg1blX7c6sJ7wf92vzIsDy9sRBCtJK4GhauekcatxyM7rS_pvEla4A5Tj3GWQEH3JFOZFZSIrK4UDa7FZxUwLiWZpNrceCqaRct4', 1, 99, '홈런리그제목', '홈런리그 내용푸쉬로 날려요.', 'LAUNCH')
--insert into dbo.tFVUserPushiPhone(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73799', 'guest73799', 'APA91bE5TtZI1T81gIpHN1o1IZuasNwm0PoaiG2xYDzOJ6AkW2H148vKqUdy7Oh1in0F-OZUo1VxUbwnNt-Jg1blX7c6sJ7wf92vzIsDy9sRBCtJK4GhauekcatxyM7rS_pvEla4A5Tj3GWQEH3JFOZFZSIrK4UDa7FZxUwLiWZpNrceCqaRct4', 1, 99, '홈런리그제목url', '홈런리그 내용푸쉬로 날려요.url', 'http://m.naver.com')



---------------------------------------------
--	Push Send Info
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserPushSendInfo', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserPushSendInfo;
GO

create table dbo.tFVUserPushSendInfo(
	idx				int				identity(1, 1),

	adminid			varchar(20),
	sendkind		int,
	market			int,

	msgtitle		varchar(512),
	msgmsg			varchar(512),

	cnt				int				default(0),
	writedate		datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tFVUserPushSendInfo_idx	PRIMARY KEY(idx)
)
-- select top 10 * from dbo.tFVUserPushSendInfo order by idx desc
-- insert into dbo.tFVUserPushSendInfo(adminid,  sendkind, market, msgtitle, msgmsg,  cnt)
-- values(				       	   @adminid,      @p3_,   @p4_,    @ps3_,  @ps4_, @cnt)
-- select max(idx), min(idx) from dbo.tFVUserPushiPhone
-- select max(idx), min(idx) from dbo.tFVUserPushAndroid
-- select distinct msgtitle, msgmsg from dbo.tFVUserPushiPhone
-- select distinct msgtitle, msgmsg from dbo.tFVUserPushAndroid
-- select top 10 * from dbo.tFVUserPushiPhone where msgtitle = '제목 iPhone'
-- select top 10 * from dbo.tFVUserPushAndroid where msgtitle = '제목 Google'
-- 삭제
-- delete from dbo.tFVUserPushiPhone  where msgtitle = '제목 iPhone'
-- delete from dbo.tFVUserPushAndroid where msgtitle = '제목 Google'
-- delete from dbo.tFVUserPushiPhone  where msgtitle = (select msgtitle from dbo.tFVUserPushSendInfo where idx = 1)
-- delete from dbo.tFVUserPushAndroid  where msgtitle = (select msgtitle from dbo.tFVUserPushSendInfo where idx = 1)
*/



/*
select top 10 * from dbo.tFVCashLog order by idx desc

select * from dbo.tFVAdminUser where gameid = 'global'

select * from dbo.tFVUserMaster
select * from dbo.tFVUserBlockPhone
select * from dbo.tFVNotice
select * from dbo.tFVDayLogInfoStatic
select * from dbo.tFVCashLog
select * from dbo.tFVCashTotal
select * from dbo.tFVAdminUser

alter table dbo.tFVUserMaster add logindate	varchar(8)				default('20100101')
update dbo.tFVUserMaster set logindate = '20100101'

alter table dbo.tFVUserMaster add cashpoint	int						default(0)
update dbo.tFVUserMaster set cashpoint = 0
*/


/*
exec spu_FVFarmD 27, 12, -1, -1, -1, -1, -1, -1, -1, -1, '사과쪽지', '', 'Naver패치가 구글로 연결되었습니다. 다시 네이버에서 받아주세요.', '', '', '', '', '', '', ''	-- 메세지보내기
exec spu_FVFarmD 27, 12, -1, -1, -1, -1, -1, -1, -1, -1, '이용에 불편을 드려 죄송합니다.', 'farm635061189', 'Naver패치가 구글로 연결되었습니다. 다시 네이버에서 받아주세요.', '', '', '', '', '', '', ''	-- 메세지보내기
*/


/*
IF OBJECT_ID (N'dbo.tFVXXX', N'U') IS NOT NULL
	DROP TABLE dbo.tFVXXX;
GO

create table dbo.tFVXXX(
	idx			int 					IDENTITY(1, 1),
	phone		varchar(20)				default(''),			-- indexing

	-- Constraint
	CONSTRAINT pk_tXXX_gameid	PRIMARY KEY(idx)
)
GO


-- 폰인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tXXX_phone')
    DROP INDEX tXXX.idx_tXXX_phone
GO
CREATE INDEX idx_tXXX_phone ON tXXX (phone)
GO
*/



/*
select --top 10
'insert into dbo.tFVXXX(phone, market, regdate) values('''
+ ltrim(rtrim(phone)) + ''','
+ ltrim(rtrim(str(market))) + ','''
+ Convert(varchar(8), regdate, 112) + ''')'
-- , *
from dbo.tFVFVUserMaster where market != 7 and regdate >= '2014-05-01'
*/
/*
DECLARE @tTTT Table(phone varchar(20));

insert into @tTTT(phone)
select
distinct
-- top 10
phone
from dbo.tFVFVUserMaster
where market != 7 and regdate >= '2014-05-01' and phone != '-1'

select
'insert into dbo.tFVXXX(phone) values('''
+ ltrim(rtrim(phone)) + ''')'
 from @tTTT


--insert into dbo.tFVXXX(phone, market, regdate) values(' + ltrim(rtrim(phone)) + '' + ltrim(rtrim(str(market))) + '' + ltrim(rtrim(str(regdate))) + '
--insert into dbo.tFVXXX(phone, market, regdate) values('01029442435',5',05  6 2014  9:52PM',
-- insert into dbo.tFVXXX(phone, market, regdate) values('01029442435',5',20140506',
-- insert into dbo.tFVXXX(phone, market, regdate) values('01029442435',5,'20140506',
-- insert into dbo.tFVXXX(phone, market, regdate) values('01029442435',5,'20140506')
*/
/*

select distinct phone from dbo.tFVFVUserMaster
where market != 7 and regdate >= '2014-05-01' and phone != '-1'

*/


--------------------------------------------
-- 대용량 푸쉬보내기
---------------------------------------------
/*

-- 대용량으로 입력하기
insert into dbo.tFVQuestUser(gameid, questcode, queststate, queststart)
	select @gameid_, questcode, @QUEST_STATE_USER_ING, getdate()
		from dbo.tFVQuestInfo where questinit = @QUEST_INIT_FIRST



insert into dbo.tFVUserPushAndroid(recepushid, sendid, receid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction)
	select distinct pushid, @ps2_, @gameid_, @p5_, 99, @ps3_, @ps4_, @branchurl from dbo.tFVFVUserMaster
		where market = 1 and pushid is not null and len(pushid) > 50

	select distinct pushid, 'a2' from dbo.tFVFVUserMaster
		where market = 1 and pushid is not null and len(pushid) > 50
		and gameid in ('guest74019', 'guest74022')

	select distinct pushid, 'a2' from dbo.tFVFVUserMaster
		where gameid in ('guest74019', 'guest74022')

*/


--------------------------------------------
-- Android Push 발송후 로그쪽으로 이동하기
---------------------------------------------
/*
-- select min(idx) min, max(idx) max from dbo.tFVUserPushAndroid
-- select * from dbo.tFVUserPushAndroid
DECLARE @tTemp TABLE(
				sendid			varchar(20),
				receid			varchar(20),
				recepushid		varchar(256),
				comment			varchar(256)
			);
delete from dbo.tFVUserPushAndroid
	OUTPUT sendid, receid, recepushid, comment into @tTemp
	where idx in (1, 2)
	--where idx between 1 and 2
-- select * from @tTemp

insert into dbo.tFVUserPushAndroidLog(sendid, receid, recepushid, comment)
	(select sendid, receid, recepushid, comment from @tTemp)
-- select * from dbo.tFVUserPushAndroidLog
*/
