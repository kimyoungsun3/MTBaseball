





















/*
-- update dbo.tLottoInfo set nextturndate = DATEADD(ss, 0+5*60, getdate() ) where idx = ( select top 1 idx from dbo.tLottoInfo order by curturntime desc)
declare @curturntime int  		select top 1 @curturntime = nextturntime from tLottoInfo order by curturntime desc
--declare @select varchar(100)	set @select = '1:-1:0; 2:-1:0; 3:-1:0; 4:-1:0;'	-- 0개 배팅
--declare @select varchar(100)	set @select = '1:0:100;2:-1:0; 3:-1:0; 4:-1:0;'	-- 1개 배팅
--declare @select varchar(100)	set @select = '1:0:100;2:0:100;3:-1:0; 4:-1:0;'	-- 2개 배팅
declare @select varchar(100)	set @select = '1:0:100;2:0:100;3:0:100; 4:-1:0;'	-- 3개 배팅
--declare @select varchar(100)	set @select = '1:0:100;2:0:100;3:0:100;4:0:100;'	-- 4개 배팅

--delete from dbo.tSingleGame      	where gameid = 'mtxxxx3' and curturntime = (select top 1 nextturntime from tLottoInfo order by curturntime desc)
--delete from dbo.tSingleGameLog   	where gameid = 'mtxxxx3' and curturntime = (select top 1 nextturntime from tLottoInfo order by curturntime desc)

exec spu_SGBet 'mtxxxx3', '049000s1i0n7t8445289', 333, 1, 11, @curturntime, @select, -1

--exec spu_SGBet 'asd123', '9963272myf3693838358', 287 , 1, 11, @curturntime, '1:0:100;2:0:100;3:-1:0;4:-1:0;', -1
*/


/*
alter table dbo.tUserMaster add				tempplusgamecost 	int				default(0)
update dbo.tUserMaster	set tempplusgamecost = 0
*/

	/*
alter table dbo.tUserMaster add				templistidxcloth	int 			default(-1)
alter table dbo.tUserMaster add				tempevolvestate	int 			default(-1)
alter table dbo.tUserMaster add				tempevolveitemcode	int 			default(-1)

--update dbo.tUserMaster	set tempevolveitemcode = -1, templistidxcloth = -1, tempevolvestate = -1
*/

--select itemcode, param6 from dbo.tItemInfo where category = 1

/*
exec spu_SGResult 'mtxxxx3', '049000s1i0n7t8445289', 333, 1, 837506, -1	-- 1개배팅 -> 1개성공

exec spu_PTResult 'mtxxxx3', '049000s1i0n7t8445289', 333, 0, 837506, -1	-- 1개배팅 -> 1개성공
*/


/*

alter table dbo.tDayLogInfoStatic add				combinatecnt	int 			default(0)
alter table dbo.tDayLogInfoStatic add				evolvecnt	int 			default(0)
alter table dbo.tDayLogInfoStatic add				disapartcnt	int 			default(0)

update dbo.tDayLogInfoStatic	set combinatecnt = 0, evolvecnt = 0, disapartcnt = 0
*/

/*
declare @itemname 		varchar(60)
declare @itemname2 		varchar(60)
declare @itemcode		int
declare @grade 			int
declare @param3 		int
declare @param4 		int
declare @param5 		int
DECLARE @tTempTable TABLE(
	itemname 		varchar(60),
	itemcode		int,
	grade 			int,
	param3 			int,
	param4 			int,
	param5 			int,
	itemname2 		varchar(60)
);

declare curTTTT Cursor for
select itemname, itemcode, grade, param3, param4, param5 from dbo.tItemInfo where category = 15
order by itemcode asc

Open curTTTT
Fetch next from curTTTT into @itemname, @itemcode, @grade, @param3, @param4, @param5
while @@Fetch_status = 0
	Begin
		select @itemname2 = itemname from dbo.tItemInfo where itemcode = @param5
		--select
		insert into @tTempTable(itemname, itemcode, grade, param3, param4, param5, itemname2)
		values (               @itemname, @itemcode, @grade, @param3, @param4, @param5, @itemname2)
		Fetch next from curTTTT into @itemname, @itemcode, @grade, @param3, @param4, @param5
	end
close curTTTT
Deallocate curTTTT
select itemname2, itemname, * from @tTempTable
*/






/*
declare @itemcode 		int
declare @subcategory	int
declare curPieceGift Cursor for
select itemcode, subcategory from dbo.tItemInfo where category = 15 order by itemcode asc

Open curPieceGift
Fetch next from curPieceGift into @itemcode, @subcategory
while @@Fetch_status = 0
	Begin
		--						gameid_, invenkind_, subcategory_, itemcode_, cnt_, gethow_, randserial, nResult2_
		exec dbo.spu_ToUserItem 'mtxxxx3', 		  2, @subcategory, @itemcode, 100,      20,        7771, -1
		Fetch next from curPieceGift into @itemcode, @subcategory
	end
close curPieceGift
Deallocate curPieceGift
*/




/*
alter table dbo.tUserMaster add				tempcombinatestate	int 			default(-1)
alter table dbo.tUserMaster add				tempitemcode		int				default(-1)
alter table dbo.tUserMaster add				templistidxrtn		int				default(-1)
alter table dbo.tUserMaster add				templistidxcust		int				default(-1)
alter table dbo.tUserMaster add				templistidxpiece1	int 			default(-1)
alter table dbo.tUserMaster add				templistidxpiece2	int 			default(-1)
alter table dbo.tUserMaster add				templistidxpiece3	int 			default(-1)
alter table dbo.tUserMaster add				templistidxpiece4	int 			default(-1)

update dbo.tUserMaster	set tempcombinatestate = -1, tempitemcode = -1, templistidxrtn = -1, templistidxcust = -1, templistidxpiece1 = -1, templistidxpiece2 = -1, templistidxpiece3 = -1, templistidxpiece4 = -1
*/
/*
alter table dbo.tUserMaster add			templistidxrtn		int				default(-1)
alter table dbo.tUserMaster add			tempitemcode		int				default(-1)
update dbo.tUserMaster	set templistidxrtn = -1, tempitemcode = -1
*/


/*
alter table dbo.tUserMaster add			templistidx6		int				default(-1)
update dbo.tUserMaster	set templistidx6 = -1

alter table dbo.tUserMaster add			templistidx5		int				default(-1)
alter table dbo.tUserMaster add			tempcombinatestate	int 			default(-1)
alter table dbo.tUserMaster add			tempevolvestate		int 			default(-1)
alter table dbo.tUserMaster add			tempdisapartstate	int 			default(-1)
update dbo.tUserMaster	set templistidx5 = -1, tempcombinatestate = -1, tempevolvestate = -1, tempdisapartstate = -1
*/


/*
select * from dbo.tItemInfoPieceBox  where grade = 1 order by getpercent1000 asc
select top 1 * from dbo.tItemInfoPieceBox  where grade = 1 and getpercent1000 >= (0         )   order by getpercent1000 asc
select top 1 * from dbo.tItemInfoPieceBox  where grade = 1 and getpercent1000 >= (2435      )   order by getpercent1000 asc
select top 1 * from dbo.tItemInfoPieceBox  where grade = 1 and getpercent1000 >= (2435 + 1  )   order by getpercent1000 asc
select top 1 * from dbo.tItemInfoPieceBox  where grade = 1 and getpercent1000 >= (99705     )   order by getpercent1000 asc
select top 1 * from dbo.tItemInfoPieceBox  where grade = 1 and getpercent1000 >= (99705 + 1 )   order by getpercent1000 asc
select top 1 * from dbo.tItemInfoPieceBox  where grade = 1 and getpercent1000 >= (100100    )   order by getpercent1000 asc
*/

--select top 1 * from dbo.tItemInfo where category = 1 and grade = 1 order by newid()

--select * from dbo.tUserItem where gameid = 'mtxxxx3'
--delete from dbo.tUserItem where idx = 432

/*
alter table dbo.tUserMaster add		tempopenstate		int				default(1)
update dbo.tUserMaster	set tempopenstate = 1

*/

/*
declare @idx int set @idx = 0
declare @max int set @max = 3
while(@idx <= 10 )
	begin

		select dbo.fnu_GetRandom( 0, @max)
		set @idx = @idx + 1
	end
*/


/*
declare @idx int set @idx = 494
while(@idx <= 498 )
	begin
		exec spu_GiftGainNew 'mtxxxx3', '049000s1i0n7t8445289', 333, -3,  @idx, -1
		set @idx = @idx + 1
	end
*/

/*
alter table dbo.tUserMaster add		setplusexp			int 			default(0)
update dbo.tUserMaster	set setplusexp = 0
*/

/*
exec spu_SubGiftSendNew 2,   301,  1, 'SysLogin', 'mtxxxx3', ''
exec spu_SubGiftSendNew 2,   401,  1, 'SysLogin', 'mtxxxx3', ''
exec spu_SubGiftSendNew 2,   501,  1, 'SysLogin', 'mtxxxx3', ''
exec spu_SubGiftSendNew 2,   601,  1, 'SysLogin', 'mtxxxx3', ''
exec spu_SubGiftSendNew 2,   701,  1, 'SysLogin', 'mtxxxx3', ''
exec spu_SubGiftSendNew 2,   801,  1, 'SysLogin', 'mtxxxx3', ''
exec spu_SubGiftSendNew 2,   901,  1, 'SysLogin', 'mtxxxx3', ''
exec spu_SubGiftSendNew 2,   1001,  1, 'SysLogin', 'mtxxxx3', ''
exec spu_SubGiftSendNew 2,   1101,  1, 'SysLogin', 'mtxxxx3', ''
exec spu_SubGiftSendNew 2,   1201,  1, 'SysLogin', 'mtxxxx3', ''
exec spu_SubGiftSendNew 2,   1301,  1, 'SysLogin', 'mtxxxx3', ''


exec spu_SubGiftSendNew 2,   105,  1, 'SysLogin', 'mtxxxx3', ''
exec spu_SubGiftSendNew 2,   205,  1, 'SysLogin', 'mtxxxx3', ''
exec spu_SubGiftSendNew 2,   305,  1, 'SysLogin', 'mtxxxx3', ''
exec spu_SubGiftSendNew 2,   405,  1, 'SysLogin', 'mtxxxx3', ''
exec spu_SubGiftSendNew 2,   505,  1, 'SysLogin', 'mtxxxx3', ''
exec spu_SubGiftSendNew 2,   605,  1, 'SysLogin', 'mtxxxx3', ''
exec spu_SubGiftSendNew 2,   705,  1, 'SysLogin', 'mtxxxx3', ''
exec spu_SubGiftSendNew 2,   805,  1, 'SysLogin', 'mtxxxx3', ''
exec spu_SubGiftSendNew 2,   905,  1, 'SysLogin', 'mtxxxx3', ''
exec spu_SubGiftSendNew 2,   1005,  1, 'SysLogin', 'mtxxxx3', ''
exec spu_SubGiftSendNew 2,   1105,  1, 'SysLogin', 'mtxxxx3', ''
exec spu_SubGiftSendNew 2,   1205,  1, 'SysLogin', 'mtxxxx3', ''
exec spu_SubGiftSendNew 2,   1305,  1, 'SysLogin', 'mtxxxx3', ''

declare @idx int set @idx = 433
while(@idx <= 458 )
	begin
		exec spu_GiftGainNew 'mtxxxx3', '049000s1i0n7t8445289', 333, -3,  @idx, -1
		set @idx = @idx + 1
	end

*/


/*
	-- 추가경험치값 (만분률값임... 100 -> 1%를 의미...)
	helmetexp			int 			default(0),
	shirtexp			int 			default(0),
	pantsexp			int 			default(0),
	glovesexp			int 			default(0),
	shoesexp			int 			default(0),
	batexp				int 			default(0),
	ballexp				int 			default(0),
	goggleexp			int 			default(0),
	wristbandexp		int 			default(0),
	elbowpadexp			int 			default(0),
	beltexp				int 			default(0),
	kneepadexp			int 			default(0),
	socksexp			int 			default(0),

	-- 세트번호.... -1(의미없음.), 0, 1, 2, 3, 4번까지 있음
	helmetset			int 			default(-1),
	shirtset			int 			default(-1),
	pantsset			int 			default(-1),
	glovesset			int 			default(-1),
	shoesset			int 			default(-1),
	batset				int 			default(-1),
	ballset				int 			default(-1),
	goggleset			int 			default(-1),
	wristbandset		int 			default(-1),
	elbowpadset			int 			default(-1),
	beltset				int 			default(-1),
	kneepadset			int 			default(-1),
	socksset			int 			default(-1),
*/

/*
alter table dbo.tUserMaster add		helmetexp			int 			default(0)
alter table dbo.tUserMaster add		shirtexp			int 			default(0)
alter table dbo.tUserMaster add		pantsexp			int 			default(0)
alter table dbo.tUserMaster add		glovesexp			int 			default(0)
alter table dbo.tUserMaster add		shoesexp			int 			default(0)
alter table dbo.tUserMaster add		batexp				int 			default(0)
alter table dbo.tUserMaster add		ballexp				int 			default(0)
alter table dbo.tUserMaster add		goggleexp			int 			default(0)
alter table dbo.tUserMaster add		wristbandexp		int 			default(0)
alter table dbo.tUserMaster add		elbowpadexp			int 			default(0)
alter table dbo.tUserMaster add		beltexp				int 			default(0)
alter table dbo.tUserMaster add		kneepadexp			int 			default(0)
alter table dbo.tUserMaster add		socksexp			int 			default(0)

	-- 세트번호.... -1(의미없음.), 0, 1, 2, 3, 4번까지 있음
alter table dbo.tUserMaster add	helmetset			int 			default(-1)
alter table dbo.tUserMaster add		shirtset			int 			default(-1)
alter table dbo.tUserMaster add		pantsset			int 			default(-1)
alter table dbo.tUserMaster add		glovesset			int 			default(-1)
alter table dbo.tUserMaster add		shoesset			int 			default(-1)
alter table dbo.tUserMaster add		batset				int 			default(-1)
alter table dbo.tUserMaster add		ballset				int 			default(-1)
alter table dbo.tUserMaster add		goggleset			int 			default(-1)
alter table dbo.tUserMaster add		wristbandset		int 			default(-1)
alter table dbo.tUserMaster add		elbowpadset			int 			default(-1)
alter table dbo.tUserMaster add		beltset				int 			default(-1)
alter table dbo.tUserMaster add		kneepadset			int 			default(-1)
alter table dbo.tUserMaster add		socksset			int 			default(-1)

update dbo.tUserMaster	set
helmetexp = 0,
	shirtexp = 0,
	pantsexp = 0,
	glovesexp = 0,
	shoesexp = 0,
	batexp	 = 0,
	ballexp	 = 0,
	goggleexp = 0,
	wristbandexp = 0,
	elbowpadexp = 0,
	beltexp	 = 0,
	kneepadexp = 0,
	socksexp = 0,
	helmetset = -1,
	shirtset = -1,
	pantsset = -1,
	glovesset = -1,
	shoesset = -1,
	batset	 = -1,
	ballset	 = -1,
	goggleset = -1,
	wristbandset = -1,
	elbowpadset = -1,
	beltset	 = -1,
	kneepadset = -1,
	socksset = -1
*/




/*
---------------------------------------------
-- 	연습게임(Practice)
---------------------------------------------
IF OBJECT_ID (N'dbo.tPracticeGame', N'U') IS NOT NULL
	DROP TABLE dbo.tPracticeGame;
GO

create table dbo.tPracticeGame(
	idx				int					IDENTITY(1,1),

	gameid			varchar(20),
	curturntime		int,										-- 나눔로또의 회차.
	curturndate		datetime,

	-- 유저가 선택한 정보.
	gamemode		int,										-- 연습(0), 싱글(1), 멀티(2)
	select1			int					default(-1),			-- 파워볼홀짝 	-> 미선택(-1), 스트라이크(0), 볼(1)
	select2			int					default(-1),			-- 파워볼언오 	-> 미선택(-1), 직구(0), 변화구(1)
	select3			int					default(-1),			-- 합볼홀짝 	-> 미선택(-1), 좌(0), 우(1)
	select4			int					default(-1),			-- 합볼언오 	-> 미선택(-1), 상(0), 하(1)
	selectdata		varchar(100),

	-- 플레이당시 정보.
	writedate		datetime			default(getdate()),
	level			int					default(1),
	exp				int					default(0),				--

	CONSTRAINT	pk_tPracticeGame_curturntime_gameid	PRIMARY KEY(curturntime, gameid)
)

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tPracticeGame_idx')
    DROP INDEX tPracticeGame.idx_tPracticeGame_idx
GO
CREATE INDEX idx_tPracticeGame_idx ON tPracticeGame (idx)
GO


---------------------------------------------
-- 	연습게임(Practice Log)
---------------------------------------------
IF OBJECT_ID (N'dbo.tPracticeGameLog', N'U') IS NOT NULL
	DROP TABLE dbo.tPracticeGameLog;
GO

create table dbo.tPracticeGameLog(
	idx				int					IDENTITY(1,1),
	idx2			int,

	gameid			varchar(20),
	curturntime		int,										-- 나눔로또의 회차.
	curturndate		datetime,

	-- 유저가 선택한 정보.
	gamemode		int,										-- 연습(0), 싱글(1), 멀티(2)
	select1			int					default(-1),			-- 파워볼홀짝 	-> 미선택(-1), 스트라이크(0), 볼(1)
	select2			int					default(-1),			-- 파워볼언오 	-> 미선택(-1), 직구(0), 변화구(1)
	select3			int					default(-1),			-- 합볼홀짝 	-> 미선택(-1), 좌(0), 우(1)
	select4			int					default(-1),			-- 합볼언오 	-> 미선택(-1), 상(0), 하(1)
	selectdata		varchar(100),

	-- 플레이당시 정보.
	writedate		datetime			default(getdate()),
	level			int					default(1),
	exp				int					default(0),				--

	-- 결과정보.
	gameresult		int					default(-1),			-- 진행중(-1)
																-- 아웃(0), 1루타(1), 2루타(2), 3루타(3), 홈런(4)
	gainexp			int					default(0),				-- 획득경험치
	rselect1 		int 				default(-1),			-- 각배팅결과 -> 미선택(-1), 패(0), 승(1)
	rselect2 		int 				default(-1),
	rselect3 		int 				default(-1),
	rselect4 		int 				default(-1),

	ltselect1		int					default(-1),										-- 로또의 정보.
	ltselect2		int					default(-1),
	ltselect3		int					default(-1),
	ltselect4		int					default(-1),

	resultdate		datetime,									-- 결과기록시간

	-- Constraint
	CONSTRAINT	pk_tPracticeGameLog_curturntime_gameid	PRIMARY KEY(curturntime, gameid)
)

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tPracticeGameLog_idx')
    DROP INDEX tPracticeGameLog.idx_tPracticeGameLog_idx
GO
CREATE INDEX idx_tPracticeGameLog_idx ON tPracticeGameLog (idx)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tPracticeGameLog_gameid_idx')
    DROP INDEX tPracticeGameLog.idx_tPracticeGameLog_gameid_idx
GO
CREATE INDEX idx_tPracticeGameLog_gameid_idx ON tPracticeGameLog (gameid, idx)
GO
*/

/*
select dbo.fnu_GetRandom(0, 4)
select dbo.fnu_GetRandom(0, 4)
select dbo.fnu_GetRandom(0, 4)
select dbo.fnu_GetRandom(0, 4)
select dbo.fnu_GetRandom(0, 4)
select dbo.fnu_GetRandom(0, 4)
*/

/*
alter table dbo.tSingleGameEarnLogMaster add	rpcgamecost		int 			default(0)

update dbo.tSingleGameEarnLogMaster	set		rpcgamecost =   0
*/


/*
---------------------------------------------
--		유저닉네임변경
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserNickNameChange', N'U') IS NOT NULL
	DROP TABLE dbo.tUserNickNameChange;
GO

create table dbo.tUserNickNameChange(
	idx			int 					IDENTITY(1, 1),

	--(유저정보)
	gameid		varchar(60),
	oldnickname	varchar(20)				default(''),
	newnickname	varchar(20)				default(''),
	writedate	datetime				default(getdate()),

	-- Constraint
	CONSTRAINT pk_tUserNickNameChange_idx	PRIMARY KEY(idx)
)
GO
*/

/*
alter table dbo.tSingleGameLog add	rcnt1	 		int 				default(0)
alter table dbo.tSingleGameLog add	rcnt2	 		int 				default(0)
alter table dbo.tSingleGameLog add	rcnt3	 		int 				default(0)
alter table dbo.tSingleGameLog add	rcnt4	 		int 				default(0)

update dbo.tSingleGameLog	set		rcnt1 =  0
update dbo.tSingleGameLog	set		rcnt2 =  0
update dbo.tSingleGameLog	set		rcnt3 =  0
update dbo.tSingleGameLog	set		rcnt4 =  0
*/

/*
---------------------------------------------
-- 	배팅일일 정보.
---------------------------------------------
IF OBJECT_ID (N'dbo.tSingleGameEarnLogMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tSingleGameEarnLogMaster;
GO

create table dbo.tSingleGameEarnLogMaster(
	idx				int				identity(1, 1),

	dateid8			char(8),							-- 20101210
	cnt				int				default(0),

	selecttry1		int				default(0),
	selecttry2		int				default(0),
	selecttry3		int				default(0),
	selecttry4		int				default(0),

	selectsuccess1	int				default(0),
	selectsuccess2	int				default(0),
	selectsuccess3	int				default(0),
	selectsuccess4	int				default(0),

	betgamecostorg	int				default(0),				-- 단순하게 배팅금액, 획득금액
	betgamecostearn	int				default(0),


	-- Constraint
	CONSTRAINT	pk_tSingleGameEarnLogMaster_dateid	PRIMARY KEY(dateid8)
)
-- select         * from dbo.tSingleGameEarnLogMaster
-- select top 1   * from dbo.tSingleGameEarnLogMaster where dateid8 = '20120818'
-- insert into dbo.tSingleGameEarnLogMaster(dateid8, cashcost) values('20120818', 0)
--update dbo.tSingleGameEarnLogMaster
--	set
--		cashcost = cashcost + 1
--where dateid8 = '20120818'
*/

/*
alter table dbo.tSingleGameLog add	betgamecostorg	int					default(0)
alter table dbo.tSingleGameLog add 	betgamecostearn	int					default(0)

update dbo.tSingleGameLog	set		betgamecostorg =   0
update dbo.tSingleGameLog	set		betgamecostearn =  0
*/

--select param2, count(*) from dbo.tItemInfo where category = 510  group by param2
--select param2, count(*) from dbo.tItemInfo where category = 510 and param1 = 10

/*
alter table dbo.tUserMaster add wearplusexp			int 			default(0)
update dbo.tUserMaster	set		wearplusexp = 0

update dbo.tUserMaster	set		wearplusexp =   0*5			where gameid = 'mtxxxx3'
update dbo.tUserMaster	set		wearplusexp =  35*5			where gameid = 'mtxxxx3'
update dbo.tUserMaster	set		wearplusexp =  70*5			where gameid = 'mtxxxx3'
update dbo.tUserMaster	set		wearplusexp = 105*5			where gameid = 'mtxxxx3'
update dbo.tUserMaster	set		wearplusexp = 140*5			where gameid = 'mtxxxx3'
update dbo.tUserMaster	set		wearplusexp = 210*5			where gameid = 'mtxxxx3'
*/



/*
-- mtxxxx3 <- mtxxxx2 가져오기
delete from dbo.tSingleGame 	where gameid = 'mtxxxx3' and curturntime in ( 828645, 828661, 828669, 828670 )
delete from dbo.tSingleGameLog 	where gameid = 'mtxxxx3' and curturntime in ( 828645, 828661, 828669, 828670 )
insert into tSingleGame (
							gameid,
							curturntime, curturndate, gamemode, consumeitemcode, select1, cnt1,
							select2, cnt2,
							select3, cnt3,
							select4, cnt4,
							selectdata, writedate, connectip, level, exp, commission, gamestate
						)
select
							'mtxxxx3',
							curturntime, curturndate, gamemode, consumeitemcode, select1, cnt1,
							select2, cnt2,
							select3, cnt3,
							select4, cnt4,
							selectdata, writedate, connectip, level, exp, commission, gamestate
from dbo.tSingleGame where gameid = 'mtxxxx2' and curturntime in ( 828645, 828661, 828669, 828670 )
*/


/*
-- mtxxxx3 -> mtxxxx2 백업
delete from dbo.tSingleGame 	where gameid = 'mtxxxx2' and curturntime in ( 828645, 828661, 828669, 828670 )
delete from dbo.tSingleGameLog 	where gameid = 'mtxxxx2' and curturntime in ( 828645, 828661, 828669, 828670 )
insert into tSingleGame (
							gameid,
							curturntime, curturndate, gamemode, consumeitemcode, select1, cnt1,
							select2, cnt2,
							select3, cnt3,
							select4, cnt4,
							selectdata, writedate, connectip, level, exp, commission, gamestate
						)
select
							'mtxxxx2',
							curturntime, curturndate, gamemode, consumeitemcode, select1, cnt1,
							select2, cnt2,
							select3, cnt3,
							select4, cnt4,
							selectdata, writedate, connectip, level, exp, commission, gamestate
from dbo.tSingleGame where gameid = 'mtxxxx3' and curturntime in ( 828645, 828661, 828669, 828670 )
*/




/*
--update dbo.tSingleGame set gamestate = -2 where gameid = 'mtxxxx3' and idx = 56

delete from dbo.tSingleGame where gameid = 'mtxxxx3' and curturntime in ( 828324, 828326, 828328 )
delete from dbo.tSingleGameLog where gameid = 'mtxxxx3' and  curturntime in ( 828324, 828326, 828328 )
insert into tSingleGame (
							gameid,
							curturntime, curturndate, gamemode, consumeitemcode, select1, itemcode1, cnt1,
							select2, itemcode2, cnt2,
							select3, itemcode3, cnt3,
							select4, itemcode4, cnt4,
							selectdata, writedate, connectip, level, exp, commission, gamestate
						)
select
							'mtxxxx3',
							curturntime, curturndate, gamemode, consumeitemcode, select1, itemcode1, cnt1,
							select2, itemcode2, cnt2,
							select3, itemcode3, cnt3,
							select4, itemcode4, cnt4,
							selectdata, writedate, connectip, level, exp, commission, gamestate
from dbo.tSingleGame where gameid = 'mtxxxx2'
*/


/*

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tSingleGame_gameid_idx')
    DROP INDEX tSingleGame.idx_tSingleGame_gameid_idx
GO
CREATE INDEX idx_tSingleGame_gameid_idx ON tSingleGame (gameid, idx)
GO



IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tSingleGameLog_gameid_idx')
    DROP INDEX tSingleGameLog.idx_tSingleGameLog_gameid_idx
GO
CREATE INDEX idx_tSingleGameLog_gameid_idx ON tSingleGameLog (gameid, idx)
GO


alter table dbo.tSingleGame    add idx2			int
alter table dbo.tSingleGameLog add idx2			int
update dbo.tSingleGame	set		idx2 = 1
update dbo.tSingleGameLog	set		idx2 = 1
*/

/*
	DECLARE @tTempTable TABLE(
		listidx		int
	);
*/



/*
---------------------------------------------
-- 	싱글배팅(ing)
---------------------------------------------
IF OBJECT_ID (N'dbo.tSingleGame', N'U') IS NOT NULL
	DROP TABLE dbo.tSingleGame;
GO

create table dbo.tSingleGame(
	idx				int					IDENTITY(1,1),

	gameid			varchar(20),
	curturntime		int,										-- 나눔로또의 회차.
	curturndate		datetime,

	-- 유저가 선택한 정보.
	gamemode		int,										-- 연습(0), 싱글(1), 멀티(2)
	select1			int					default(-1),			-- 파워볼홀짝 	-> 미선택(-1), 스트라이크(0), 볼(1)
	itemcode1		int					default(-1),			-- 선택이면 어떤 아이템.
	cnt1			int 				default(0),				-- 선택이면 선택수량.
	select2			int					default(-1),			-- 파워볼언오 	-> 미선택(-1), 직구(0), 변화구(1)
	itemcode2		int					default(-1),
	cnt2			int 				default(0),
	select3			int					default(-1),			-- 합볼홀짝 	-> 미선택(-1), 좌(0), 우(1)
	itemcode3		int					default(-1),
	cnt3			int 				default(0),
	select4			int					default(-1),			-- 합볼언오 	-> 미선택(-1), 상(0), 하(1)
	itemcode4		int					default(-1),
	cnt4			int 				default(0),
	selectdata		varchar(100),

	-- 플레이당시 정보.
	writedate		datetime			default(getdate()),
	connectip		varchar(20)			default(''),			-- 접속시 사용되는
	level			int					default(1),
	exp				int					default(0),				--
	commission		float				default(7.00), 			-- 수수료... (기본 7%를 지급) -> 보는 용도일뿐이다.ip

	---- 결과정보.
	--gameresult	int					default(-1),			-- 진행중(-1)
	--															-- 아웃(0), 1루타(1), 2루타(2), 3루타(3), 홈런(4)
	--															-- 로그인시취소(-2)
	--gainexp		int					default(0),				-- 획득경험치
	--gaincashcost	int 				default(0),				-- 획드다이아
	--rselect1 		int 				default(-1),			-- 각배팅결과 -> 미선택(-1), 패(0), 승(1)
	--rselect2 		int 				default(-1),
	--rselect3 		int 				default(-1),
	--rselect4 		int 				default(-1),

	-- PC방업주들.
	--pcgameid		varchar(20),								-- 사장id
	--pccashcost	int 				default(0),				-- 지급다이아
	--resultdate	datetime,									-- 결과기록시간

	-- Constraint
	CONSTRAINT	pk_tSingleGame_curturntime_gameid	PRIMARY KEY(curturntime, gameid)
)


---------------------------------------------
-- 	싱글배팅로고(Log)
---------------------------------------------
IF OBJECT_ID (N'dbo.tSingleGameLog', N'U') IS NOT NULL
	DROP TABLE dbo.tSingleGameLog;
GO

create table dbo.tSingleGameLog(
	idx				int					IDENTITY(1,1),

	gameid			varchar(20),
	curturntime		int,										-- 나눔로또의 회차.
	curturndate		datetime,

	-- 유저가 선택한 정보.
	gamemode		int,										-- 연습(0), 싱글(1), 멀티(2)
	select1			int					default(-1),			-- 파워볼홀짝 	-> 미선택(-1), 스트라이크(0), 볼(1)
	itemcode1		int					default(-1),			-- 선택이면 어떤 아이템.
	cnt1			int 				default(0),				-- 선택이면 선택수량.
	select2			int					default(-1),			-- 파워볼언오 	-> 미선택(-1), 직구(0), 변화구(1)
	itemcode2		int					default(-1),
	cnt2			int 				default(0),
	select3			int					default(-1),			-- 합볼홀짝 	-> 미선택(-1), 좌(0), 우(1)
	itemcode3		int					default(-1),
	cnt3			int 				default(0),
	select4			int					default(-1),			-- 합볼언오 	-> 미선택(-1), 상(0), 하(1)
	itemcode4		int					default(-1),
	cnt4			int 				default(0),
	selectdata		varchar(100),

	-- 플레이당시 정보.
	writedate		datetime			default(getdate()),
	connectip		varchar(20)			default(''),			-- 접속시 사용되는
	level			int					default(1),
	exp				int					default(0),				--
	commission		float				default(7.00), 			-- 수수료... (기본 7%를 지급) -> 보는 용도일뿐이다.ip

	-- 결과정보.
	gameresult		int					default(-1),			-- 진행중(-1)
																-- 아웃(0), 1루타(1), 2루타(2), 3루타(3), 홈런(4)
																-- 재로그인몰수패(-2), 게임취소(-3)
	gainexp			int					default(0),				-- 획득경험치
	gaincashcost	int 				default(0),				-- 획드다이아
	rselect1 		int 				default(-1),			-- 각배팅결과 -> 미선택(-1), 패(0), 승(1)
	rselect2 		int 				default(-1),
	rselect3 		int 				default(-1),
	rselect4 		int 				default(-1),

	-- PC방업주들.
	pcgameid		varchar(20),								-- 사장id
	pccashcost		int 				default(0),				-- 지급다이아
	resultdate		datetime,									-- 결과기록시간

	-- Constraint
	CONSTRAINT	pk_tSingleGameLog_curturntime_gameid	PRIMARY KEY(curturntime, gameid)
)
*/


/*
alter table dbo.tSingleGame add curturndate		datetime
alter table dbo.tSingleGameLog add curturndate		datetime
select * from dbo.tSingleGame
select * from tSingleGameLog
*/

/*
alter table dbo.tSingleGame add randserial		varchar(20)			default('-1')
alter table dbo.tSingleGameLog add randserial		varchar(20)			default('-1')
update dbo.tSingleGame	set		randserial = '-1'
update dbo.tSingleGameLog	set		randserial = '-1'
*/

/*
--유저로그검색
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tLottoInfo_nextturntime')
    DROP INDEX tLottoInfo.idx_tLottoInfo_nextturntime
GO
CREATE INDEX idx_tLottoInfo_nextturntime ON tLottoInfo (nextturntime)
GO
*/



/*
alter table dbo.tUserMaster add singleflag		int					default(0)
alter table dbo.tUserMaster add singletrycnt	int					default(0)
alter table dbo.tUserMaster add singlesuccesscnt	int				default(0)
alter table dbo.tUserMaster add singlefailcnt		int				default(0)
alter table dbo.tUserMaster add singleerrorcnt		int				default(0)
update dbo.tUserMaster
	set
		singleflag = 0,
		singletrycnt = 0,
		singlesuccesscnt = 0,
		singlefailcnt = 0,
		singleerrorcnt = 0
*/

/*
---------------------------------------------
--		PC방정보...
---------------------------------------------
IF OBJECT_ID (N'dbo.tPCRoomIP', N'U') IS NOT NULL
	DROP TABLE dbo.tPCRoomIP;
GO

create table dbo.tPCRoomIP(
	idx				int					IDENTITY(1,1),

	gameid			varchar(20),									-- PC방 사장ID
	connectip		varchar(20),									-- 접속정보
	cnt				int,											-- 배팅횟수

	writedate		datetime			default(getdate()),			-- 등록일..
	adminid			varchar(20),

	-- Constraint
	CONSTRAINT	pk_tPCRoomIP_gameid_connectip	PRIMARY KEY(gameid, connectip),
	CONSTRAINT	uk_tPCRoomIP_connectip			UNIQUE( connectip )
)

*/


/*
alter table dbo.tLottoInfo add select1					int
alter table dbo.tLottoInfo add select2					int
alter table dbo.tLottoInfo add select3					int
alter table dbo.tLottoInfo add select4					int
update dbo.tLottoInfo
	set
		select1 = pbevenodd,
		select2 = pbunderover,
		select3 = tbevenodd,
		select4 = tbunderover
*/


/*
---------------------------------------------
--	로또 파워볼 마스터 타임 테이블.
---------------------------------------------
IF OBJECT_ID (N'dbo.tLottoInfo', N'U') IS NOT NULL
	DROP TABLE dbo.tLottoInfo;
GO

create table dbo.tLottoInfo(
	idx						int					IDENTITY(1,1),

	-- 현재회차 정보.
	curturntime				int,				-- 나눔로또의 정보.
	curturndate				datetime,			-- 이것이 작성될때의 시간.
	curturnnum1				int,				-- 일반볼.
	curturnnum2				int,
	curturnnum3				int,
	curturnnum4				int,
	curturnnum5				int,
	curturnnum6				int,				-- 파워볼.

	-- 파워볼에 의한 정보.
	pbgrade					int,				-- 파워볼 등급.
	pbevenodd				int,				-- 파워볼 홀짝.
	pbunderover				int,				-- 파워볼 언오.

	-- 합볼에 대한 정보.
	totalball				int,				-- 일반볼 합(1 ~ 5번까지)
	tbgrade					int,				-- 합볼등급.
	tbevenodd				int,				-- 합볼홀짝.
	tbunderover				int,				-- 합볼언오.
	tbgrade2				int,				-- 합볼소중대.

	-- 다음회차 정보
	nextturntime			int,
	nextturndate			datetime,

	writedate				datetime			default(getdate()),
	adminid					varchar(20)			default('demon'),

	-- Constraint
	CONSTRAINT	pk_tLottoInfo_nextturntime		PRIMARY KEY(curturntime)
)
*/

/*
alter table dbo.tLottoInfo add adminid	varchar(20) default('deomon')
update dbo.tLottoInfo set adminid = 'demon'
select * from dbo.tLottoInfo
*/

/*
DECLARE dbo.tSingleGame TABLE(
	idx			int 			IDENTITY(1, 1),
	curDate 	datetime
);

insert into @tTTT(curDate) values('2018-09-17 16:17:45')
insert into @tTTT(curDate) values('2018-09-17 16:17:46')
--insert into @tTTT(curDate) values('2018-09-17 16:17:47')
insert into @tTTT(curDate) values('2018-09-17 16:22:44')
insert into @tTTT(curDate) values('2018-09-17 16:22:45')
insert into @tTTT(curDate) values('2018-09-17 16:22:46')
--insert into @tTTT(curDate) values('2018-09-17 16:22:47')
insert into @tTTT(curDate) values(getdate())



declare @startDate 			datetime		set @startDate			= '2018-09-17 16:17:45'
declare @curDate			datetime		set @curDate 			= getdate()
declare @nextData 			datetime

declare @startTurnTime		int				set @startTurnTime		= 821451
declare @curTurnTime		int				set @curTurnTime		= -1
declare @nextTurnTime		int				set @nextTurnTime		= -1

declare @gaptime			bigint
declare @remainTime			int
declare @divValue			int
declare @modValue			int
declare @TURNTIME_SECOND	int				set @TURNTIME_SECOND	= 300
declare @mode				int
declare @idx				int
declare @plusTime			int				set @plusTime			= 2 + 5		-- 1일차 +5초 갭발생...


--select * from @tTTT order by idx desc
set @startDate 	= DATEADD(ss, @plusTime, @startDate)


declare curTTT Cursor for
select idx, curDate from @tTTT order by idx desc

Open curTTT
Fetch next from curTTT into @idx, @curDate
while @@Fetch_status = 0
	Begin
		set @gaptime 	= datediff(ss, @startDate, @curDate)
		set @divValue 	= @gaptime / @TURNTIME_SECOND
		set @modValue 	= @gaptime % @TURNTIME_SECOND
		set @remainTime = @TURNTIME_SECOND - @modValue

		if(@modValue != 0)
			begin
				set @mode = 1
				set @curTurnTime 	= @startTurnTime + @divValue
				set @nextData 		= DATEADD(ss, (@divValue + 1) * @TURNTIME_SECOND, @startDate);
				set @nextTurnTime 	= @curTurnTime + 1
			end
		else
			begin
				set @mode = 2
				set @curTurnTime 	= @startTurnTime + @divValue
				set @nextData 		= DATEADD(ss, (@divValue + 1) * @TURNTIME_SECOND, @startDate);
				set @nextTurnTime 	= @curTurnTime + 1
			end

		select @mode mode, @gaptime gaptime, @divValue divValue, @modValue modValue, @remainTime remainTime,
				@curTurnTime curTurnTime, @curDate curDate,
				@nextTurnTime nextTurnTime, @nextData nextData

		Fetch next from curTTT into @idx, @curDate
	end
close curTTT
Deallocate curTTT
*/


/*
alter table dbo.tPCRoomIP add adminid	varchar(20)
update dbo.tPCRoomIP set adminid = 'blackm'
select * from dbo.tPCRoomIP
*/



--alter table dbo.tUserMaster add deletestate	int						default(0)
--update dbo.tUserMaster set deletestate = 0


/*
---------------------------------------------
--	통계자료(캐쉬 마스터)
---------------------------------------------
IF OBJECT_ID (N'dbo.tStaticCashMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tStaticCashMaster;
GO

create table dbo.tStaticCashMaster(
	idx				int					identity(1, 1),

	dateid			varchar(8),									-- 20121118
	step 			int					default(1),				-- famelv(1), tel(2)
	writedate		datetime			default(getdate()), 	-- 작성일

	-- Constraint
	CONSTRAINT pk_tStaticCashMaster_dateid	PRIMARY KEY(dateid)
)
GO

---------------------------------------------
--	통계자료(캐쉬 서브)
---------------------------------------------
IF OBJECT_ID (N'dbo.tStaticCashUnique', N'U') IS NOT NULL
	DROP TABLE dbo.tStaticCashUnique;
GO

create table dbo.tStaticCashUnique(
	idx						int					IDENTITY(1,1),

	dateid					varchar(8),
	cash					int,
	cnt						int,
	writedate				datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tStaticCashUnique_idx		PRIMARY KEY(idx)
)
*/

/*
---------------------------------------------
-- 	캐쉬관련(개인로그)
---------------------------------------------
IF OBJECT_ID (N'dbo.tCashLog', N'U') IS NOT NULL
	DROP TABLE dbo.tCashLog;
GO

create table dbo.tCashLog(
	idx				int				identity(1, 1),
	gameid			varchar(20)		not null, 				-- 구매자
	lv				int				default(1),

	giftid			varchar(20), 							-- 선물받은사람
	acode			varchar(256), 							-- 승인코드() 사용안함.ㅠㅠ
	ucode			varchar(256), 							-- 승인코드

	ikind			varchar(256),							-- 아이폰, Google 종류(SandBox, Real, GoogleID)
	idata			varchar(4096),							-- 아이폰에서 사용되는 데이타(원본)
	idata2			varchar(4096),							-- 아이폰에서 사용되는 데이타(해석본)

	cashcost		int				default(0), 			-- 충전골든볼
	cash			int				default(0),				-- 구매현금
	writedate		datetime		default(getdate()), 	-- 구매일

	productid		varchar(40)		default(''),

	-- Constraint
	CONSTRAINT	pk_tCashLog_idx	PRIMARY KEY(idx)
)
--직접 clustered를 안한 이유는 쓰기는 idx로 하고 검색을 ucode > idx를 통해서 하도록 설정
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tCashLog_ucode')
    DROP INDEX tCashLog.idx_tCashLog_ucode
GO
CREATE INDEX idx_tCashLog_ucode ON tCashLog (ucode)
GO
--유저로그검색
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tCashLog_gameid')
    DROP INDEX tCashLog.idx_tCashLog_gameid
GO
CREATE INDEX idx_tCashLog_gameid ON tCashLog (gameid)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tCashLog_acode')
    DROP INDEX tCashLog.idx_tCashLog_acode
GO
CREATE INDEX idx_tCashLog_acode ON tCashLog (acode)
GO
--insert into dbo.tCashLog(gameid, acode, ucode, cashcost, cash) values('xxxx', 'xxx', '12345778998765442bcde3123192915243184254', 10, 1000)
--select * from dbo.tCashLog where ucode = '12345778998765442bcde3123192915243184254'

---------------------------------------------
-- 	캐쉬구매Total
---------------------------------------------
IF OBJECT_ID (N'dbo.tCashTotal', N'U') IS NOT NULL
	DROP TABLE dbo.tCashTotal;
GO

create table dbo.tCashTotal(
	idx				int				identity(1, 1),
	dateid			char(8),								-- 20101210
	cashkind		int,

	cashcost		int				default(0), 			-- 총판매량
	cash			int				default(0), 			-- 총판매량
	cnt				int				default(1),				--증가회수
	-- Constraint
	CONSTRAINT	pk_tCashTotal_dateid PRIMARY KEY(dateid, cashkind)
)
-- insert into dbo.tCashTotal(dateid, cashkind, cashcost, cash) values('20120818', 2000, 21, 2000)
-- insert into dbo.tCashTotal(dateid, cashkind, cashcost, cash) values('20120818', 5000, 55, 5000)
-- select top 1 * from dbo.tCashTotal where dateid = '20120818' and cashkind = 2000
-- update dbo.tCashTotal set cashcost = cashcost + 21, cash = cash + 2000, cnt = cnt + 1 where dateid = '20120818' and cashkind = 2000

*/
/*
---------------------------------------------
--		아이템 보유정보
---------------------------------------------
IF OBJECT_ID (N'dbo.tGiftList', N'U') IS NOT NULL
	DROP TABLE dbo.tGiftList;
GO

create table dbo.tGiftList(
	idx			bigint				IDENTITY(1,1),
	idx2		int,

	gameid		varchar(20),									-- gameid별 itemcode는 중복이 발생한다.
	giftkind	int					default(0),					-- 1:메시지, 2:선물, -1:메시지삭제, -2:선물받아감

	message		varchar(256)		default(''), 				-- 메세지(1)

	itemcode	int					default(-1),				-- 선물(2)
	cnt			bigint 				default(0),					-- == 0 이면 기존것의 수량
																-- >= 1 이면 이것을 수량으로한다.
	gainstate	int					default(0),					-- 가져간상태	0:안가져감, 1:가져감
	gaindate	datetime, 										-- 가져간날
	giftid		varchar(20)			default('Marbles'),			-- 선물한 유저
	giftdate	datetime			default(getdate()), 		-- 선물일

	-- Constraint
	CONSTRAINT	pk_tGiftList_idx	PRIMARY KEY(idx)
)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tGiftList_gameid_idx')
    DROP INDEX tGiftList.idx_tGiftList_gameid_idx
GO
CREATE INDEX idx_tGiftList_gameid_idx ON tGiftList (gameid, idx)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tGiftList_gameid_idx2')
    DROP INDEX tGiftList.idx_tGiftList_gameid_idx2
GO
CREATE INDEX idx_tGiftList_gameid_idx2 ON tGiftList (gameid, idx2)
GO



-- select * from dbo.tGiftList where gameid = 'xxxx' order by idx desc
-- insert into dbo.tGiftList(gameid, giftkind, message) values('xxxx', 1, 'Shot message');
-- insert into dbo.tGiftList(gameid, giftkind, itemcode, giftid) values('xxxx', 2, 1, 'Marbles');

---------------------------------------------
-- 	구매했던 로그(월별 Master)
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserItemUpgradeLogTotalMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tUserItemUpgradeLogTotalMaster;
GO

create table dbo.tUserItemUpgradeLogTotalMaster(
	idx				int				identity(1, 1),
	dateid8			char(8),							-- 20101210

	cashcost		bigint			default(0),
	gamecost		bigint			default(0),
	heart			bigint			default(0),
	cnt				int				default(0),

	-- Constraint
	CONSTRAINT	pk_tUserItemUpgradeLogTotalMaster_dateid	PRIMARY KEY(dateid8)
)

---------------------------------------------
-- 	구매했던 로그(월별 Sub)
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserItemUpgradeLogTotalSub', N'U') IS NOT NULL
	DROP TABLE dbo.tUserItemUpgradeLogTotalSub;
GO

create table dbo.tUserItemUpgradeLogTotalSub(
	idx				int				identity(1, 1),

	dateid8			char(8),							-- 20101210
	itemcode		int,

	cashcost		int				default(0),
	gamecost		int				default(0),
	heart			bigint			default(0),
	cnt				int				default(0),

	-- Constraint
	CONSTRAINT	pk_tUserItemUpgradeLogTotalSub_dateid8_itemcode	PRIMARY KEY(dateid8, itemcode)
)

---------------------------------------------
-- 	구매했던 로그(월별 누적)
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserItemUpgradeLogMonth', N'U') IS NOT NULL
	DROP TABLE dbo.tUserItemUpgradeLogMonth;
GO

create table dbo.tUserItemUpgradeLogMonth(
	idx				int				identity(1, 1),

	dateid6			char(6),							-- 201012
	itemcode		int,

	cashcost		bigint			default(0),
	gamecost		bigint			default(0),
	heart			bigint			default(0),
	cnt				int				default(0),

	-- Constraint
	CONSTRAINT	pk_tUserItemUpgradeLogMonth_dateid6_itemcode	PRIMARY KEY(dateid6, itemcode)
)

*/

/*

---------------------------------------------
-- 이벤트 인증키값
---------------------------------------------
IF OBJECT_ID (N'dbo.tEventCertNo', N'U') IS NOT NULL
	DROP TABLE dbo.tEventCertNo;
GO

create table dbo.tEventCertNo(
	idx			int				identity(1, 1),
	certno		varchar(16),

	itemcode1	int				default(-1),
	itemcode2	int				default(-1),
	itemcode3	int				default(-1),
	cnt1		int				default(0),
	cnt2		int				default(0),
	cnt3		int				default(0),

	mode		int				default(1),		-- 1: 1인1매형, 2:공용형
	kind		int				default(0),		-- 제작요청한 회사번호.

	CONSTRAINT	pk_tEventCertNo_idx	PRIMARY KEY(idx)
)
-- 인증번호 인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tEventCertNo_certno')
    DROP INDEX tEventCertNo.idx_tEventCertNo_certno
GO
CREATE INDEX idx_tEventCertNo_certno ON tEventCertNo (certno)
GO

---------------------------------------------
-- 이벤트 인증키값(백업)
-- 누구에게 무슨아이템을 지급했다.
---------------------------------------------
IF OBJECT_ID (N'dbo.tEventCertNoBack', N'U') IS NOT NULL
	DROP TABLE dbo.tEventCertNoBack;
GO

create table dbo.tEventCertNoBack(
	idx			int				identity(1, 1),
	certno		varchar(16),

	gameid		varchar(20),
	itemcode1	int				default(-1),
	itemcode2	int				default(-1),
	itemcode3	int				default(-1),
	usedtime	datetime		default(getdate()),
	kind		int				default(0),

	CONSTRAINT	pk_tEventCertNoBack_idx	PRIMARY KEY(idx)
)

-- 인증번호 인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tEventCertNoBack_certno')
    DROP INDEX tEventCertNoBack.idx_tEventCertNoBack_certno
GO
--CREATE INDEX idx_tEventCertNoBack_certno ON tEventCertNoBack (certno)
--GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tEventCertNoBack_gameid_certno')
    DROP INDEX tEventCertNoBack.idx_tEventCertNoBack_gameid_certno
GO
CREATE INDEX idx_tEventCertNoBack_gameid_certno ON tEventCertNoBack (gameid, certno)
GO


---------------------------------------------
-- 유저문의
---------------------------------------------
IF OBJECT_ID (N'dbo.tSysInquire', N'U') IS NOT NULL
	DROP TABLE dbo.tSysInquire;
GO

create table dbo.tSysInquire(
	idx					int 				IDENTITY(1, 1),

	gameid				varchar(20),
	state				int					default(0),				-- 요청대기[0], 체킹중[1], 완료[2]
	comment				varchar(1024)		default(''),
	writedate			datetime			default(getdate()),

	adminid				varchar(20)			default(''),
	comment2			varchar(1024)		default(''),
	dealdate			datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tSysInquire_idx	PRIMARY KEY(idx)
)
-- select top 10 * from dbo.tSysInquire order by idx desc
-- insert into dbo.tSysInquire(gameid, comment) values(1, '잘안됩니다.')
-- update dbo.tSysInquire set state = 1, dealdate = getdate(), comment2 = '진행중입니다.' where idx = 1
-- update dbo.tSysInquire set state = 2, dealdate = getdate(), comment2 = '처리했습니다.' where idx = 1
-- if(2)쪽지로 발송된다.
*/


/*
---------------------------------------------
--	비정삭적인 행동을 할려고 하는 유저체킹 > 블럭처리
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserUnusualLog', N'U') IS NOT NULL
	DROP TABLE dbo.tUserUnusualLog;
GO

create table dbo.tUserUnusualLog(
	idx				int				IDENTITY(1,1),
	gameid			varchar(20), 							-- 행동자
	comment			varchar(512), 							-- 비정상내용
	writedate		datetime		default(getdate()), 	-- 비정상작성일

	chkstate		int				default(0),				-- 확인상태(0:체킹안함, 1:체킹함)
	chkdate			datetime,
	chkcomment		varchar(512), 							-- 확인내용

	-- Constraint
	CONSTRAINT pk_tUserUnusualLog_idx PRIMARY KEY(idx)
)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserUnusualLog_gameid_idx')
    DROP INDEX tUserUnusualLog.idx_tUserUnusualLog_gameid_idx
GO
CREATE INDEX idx_tUserUnusualLog_gameid_idx ON tUserUnusualLog(gameid, idx)
GO
-- insert into dbo.tUserUnusualLog(gameid, comment) values('xxxx1', '캐쉬카피시도')
-- insert into dbo.tUserUnusualLog(gameid, comment) values('xxxx1', '환전카피시도')
-- insert into dbo.tUserUnusualLog(gameid, comment) values('xxxx2', '결과조작')
-- select top 20 * from dbo.tUserUnusualLog order by idx desc
-- select top 20 * from dbo.tUserUnusualLog where gameid = 'sususu' order by idx desc


---------------------------------------------
--	비정삭적인2 행동을 할려고 하는 유저체킹 > 블럭처리
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserUnusualLog2', N'U') IS NOT NULL
	DROP TABLE dbo.tUserUnusualLog2;
GO

create table dbo.tUserUnusualLog2(
	idx				int				IDENTITY(1,1),
	gameid			varchar(20), 							-- 행동자
	comment			varchar(512), 							-- 비정상내용
	writedate		datetime		default(getdate()), 	-- 비정상작성일

	chkstate		int				default(0),				-- 확인상태(0:체킹안함, 1:체킹함)
	chkdate			datetime,
	chkcomment		varchar(512), 							-- 확인내용

	-- Constraint
	CONSTRAINT pk_tUserUnusualLog2_idx PRIMARY KEY(idx)
)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserUnusualLog2_gameid_idx')
    DROP INDEX tUserUnusualLog2.idx_tUserUnusualLog2_gameid_idx
GO
CREATE INDEX idx_tUserUnusualLog2_gameid_idx ON tUserUnusualLog2(gameid, idx)
GO
-- insert into dbo.tUserUnusualLog2(gameid, comment) values('x1', '캐쉬카피시도')
-- insert into dbo.tUserUnusualLog2(gameid, comment) values('x1', '환전카피시도')
-- insert into dbo.tUserUnusualLog2(gameid, comment) values('x2', '결과조작')
-- select top 20 * from dbo.tUserUnusualLog2 order by idx desc
-- select top 20 * from dbo.tUserUnusualLog2 where gameid = 'sususu' order by idx desc

*/



/*
---------------------------------------------
-- 	관리자 정보(행동정보)
---------------------------------------------
IF OBJECT_ID (N'dbo.tMessageAdmin', N'U') IS NOT NULL
	DROP TABLE dbo.tMessageAdmin;
GO

create table dbo.tMessageAdmin(
	idx			int					IDENTITY(1,1),
	adminid		varchar(20),
	gameid		varchar(20),
	comment		varchar(1024),

	writedate	datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tMessageAdmin_idx	PRIMARY KEY(idx)
)

-- insert into dbo.tMessageAdmin(adminid, gameid, comment) values('black4', 'guest', '골드지급')
-- select top 100 * from dbo.tMessageAdmin order by idx desc

*/


--select * from tItemInfo where category = 15 and grade = 1
--select * from tItemInfo where category = 15 and param1 = 4000
--select sum(param2)  from tItemInfo where category = 15 and param1 = 4000
--select * from tItemInfo where category = 1 and param1 = 4100

/*
---------------------------------------------
-- 	블럭폰번호 > 가입시 블럭처리자
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserBlockPhone', N'U') IS NOT NULL
	DROP TABLE dbo.tUserBlockPhone;
GO

create table dbo.tUserBlockPhone(
	idx			int 					IDENTITY(1, 1),

	phone			varchar(20),
	comment			varchar(1024),
	writedate		datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tUserBlockPhone_phone	PRIMARY KEY(phone)
)

-- insert into dbo.tUserBlockPhone(phone, comment) values('01022223333', '아이템카피')
-- insert into dbo.tUserBlockPhone(phone, comment) values('01092443174', '환전버그카피')
-- select top 100 * from dbo.tUserBlockPhone order by writedate desc
-- select top 1   * from dbo.tUserBlockPhone where phone = '01022223333'

-- 센드키 충돌검사
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserBlockPhone_idx')
    DROP INDEX tUserBlockPhone.idx_tUserBlockPhone_idx
GO
CREATE INDEX idx_tUserBlockPhone_idx ON tUserBlockPhone (idx)
GO
*/


/*
declare @level	int		set @level 	= 0
declare @iMax	int		set @iMax 	= 650
declare @tax	int		set @tax 	= 0
DECLARE @tTTT TABLE(
	level		int,
	tax			int
);

while(@level <= @iMax )
	begin
		-- (@level_ / 30 ) * 0.3
		select @tax = (@level / 30 ) * 3
		insert into @tTTT(level, tax) values( @level, @tax );
		set @level = @level + 1
	end
select * from @tTTT order by level asc
*/

/*
--select sqrt(2), sqrt(144), sqrt(24)
--
--declare @i		int		set @i 		= 4001
--select (Sqrt ((@i - 1) / 100 + 1521 / 4) - 39 / 2) + 1

-- exp -> level
--https://www.google.co.kr/search?q=mssql+sqrt+decimal&oq=mssql+Sqrt&aqs=chrome.1.69i57j69i59.441640j0j7&sourceid=chrome&ie=UTF-8
declare @i		int		set @i 		= 0
declare @iMax	int		set @iMax 	= 500000
declare @level	int		set @level 	= 1
declare @level2	int		set @level2 = -1

while(@i <= @iMax )
	begin
		-- (int)(Mathf.Sqrt ((@i - 1) / 100f + 1521 / 4f) - 39 / 2f) + 1;
		select @level = (Sqrt ((@i - 1) / 100 + 380.25) - 19.5) + 1;
		if (@level != @level2)
		begin
			select @i i, @level level
        end

		set @level2 = @level
		set @i = @i + 1
	end
*/



/*
DECLARE @arg  AS DECIMAL(38, 19) = 25000000000000.000100
Declare @root AS DECIMAL(38, 19) = 5000000.00000000001
Declare @Format As nvarchar(100) = N'#.00000000000000000000'

SELECT Format(Power(@arg, 0.5), @Format) AS power_result,
       Format(SQRT(@arg), @Format) AS sqrt_result,
       Format(@Root * @Root, @Format) as arg,
       Format(cast(@arg as float), @Format)  as argfloat

DECLARE @arg AS DECIMAL(38,24) = 25000000000000.000100
DECLARE @candidate decimal(38, 24) = SQRT(@arg)
DECLARE @newCandidate decimal(38, 24)

DECLARE @iteration int = 0
WHILE @iteration < 200
BEGIN
	SET @iteration = @iteration + 1
	SET @newCandidate = (@candidate + @arg / @candidate ) / 2
	IF @newCandidate = @candidate BREAK
	SET @candidate = @newCandidate
END




PRINT @candidate
PRINT @iteration



DECLARE @arg AS float = 25000000000000.0001
SELECT @arg
*/


/*
CREATE VIEW dbo.rand_view
AS
SELECT RAND() AS random_num

CREATE FUNCTION dbo.rndNum(@i INT)
RETURNS INT
AS
BEGIN
  DECLARE @result INT;
  SELECT @result = CONVERT(INT, random_num * @i)
  FROM dbo.rand_view;
  RETURN(@result);
END
SELECT dbo.rndNum(5)


--SELECT RAND()*(10-5)+5;
--Convert(int, ceiling(RAND() * @mm))
-- random SID
declare @sid		int
declare @loop 		int set @loop 	= 1
declare @min_ 		int set @min_ = 100
declare @max_ 		int set @max_ = 1000
declare @mm			int set @mm	= @max_ - @min_
--------------------------------------
-- 임시테이블 생성해두기.
--------------------------------------
DECLARE @tTTT TABLE(
	sid		int,
	cnt		int
);
while( @loop < 10000)
	begin
		select @sid = ( @min_ + Convert(int, ceiling(RAND() * @mm)) )  - 1
		--select @sid sid
		if(not exists(select * from @tTTT where sid = @sid))
			begin
				--select 1
				insert into @tTTT(sid, cnt) values( @sid, 1 );
			end
		else
			begin
				--select 2
				update @tTTT set cnt = cnt + 1
				where sid = @sid
			end
		set @loop = @loop + 1
	end
select * from @tTTT order by sid asc
--drop table @tTTT;
*/


/*

update dbo.tZCPMarket
	set
		kind 	= 1,
		title	= '문화 상품권',
		zcpfile	= 'http://121.138.201.251:40012/Game4GameMTBaseballVill5/etc/_ad/gift_card.png',
		zcpurl	= '',
		bestmark= 1,
		newmark	= 1,
		needcnt	= 15,
		firstcnt= 50,
		balancecnt= 0,
		commentsimple= '문화 상품권 간략설명',
		commentdesc	 = '문화 상품권 상세설명',
		opendate	= '2016-05-25',
		expiredate	= '2016-05-31',
		zcpflag		= 1,
		zcporder	= 0
where idx = 1


update dbo.tZCPMarket
	set
		kind 	= 1,
		title	= '구이구이 소고기',
		zcpfile	= 'http://121.138.201.251:40012/Game4GameMTBaseballVill5/etc/_ad/Beef.png',
		zcpurl	= '',
		bestmark= 1,
		newmark	= 1,
		needcnt	= 99,
		firstcnt= 50,
		balancecnt= 0,
		commentsimple= '마블링된 소고기 간략설명',
		commentdesc	 = '마블링된 소고기 상세설명',
		opendate	= '2016-05-25',
		expiredate	= '2016-05-31',
		zcpflag		= 1,
		zcporder	= 2
where idx = 2


update dbo.tZCPMarket
	set
		kind 	= 3,
		title	= '다이어트 저지방 우유',
		zcpfile	= 'http://121.138.201.251:40012/Game4GameMTBaseballVill5/etc/_ad/milk.png',
		zcpurl	= '',
		bestmark= 1,
		newmark	= 1,
		needcnt	= 15,
		firstcnt= 50,
		balancecnt= 0,
		commentsimple= '저지방 우유 간략설명',
		commentdesc	 = '저지방 우유 상세설명',
		opendate	= '2016-05-25',
		expiredate	= '2016-05-31',
		zcpflag		= 1,
		zcporder	= 0
where idx = 3





*/

--update dbo.tUserMaster set zcpappearcnt = 0


/*
alter table dbo.tDayLogInfoStatic add			zcpappeartradecnt	int			default(0)
alter table dbo.tDayLogInfoStatic add			zcpappearboxcnt		int			default(0)
alter table dbo.tDayLogInfoStatic add			zcpappearfeedcnt	int			default(0)
alter table dbo.tDayLogInfoStatic add			zcpappearheartcnt	int			default(0)
update dbo.tDayLogInfoStatic set zcpappeartradecnt = 0, zcpappearboxcnt = 0, zcpappearfeedcnt = 0, zcpappearheartcnt = 0


alter table dbo.tUserMaster add			zcpappearcnt	int					default(0)
update dbo.tUserMaster set zcpappearcnt = 0
*/


/*
exec spu_SubGiftSendNew 2,3800,     1, 'SysLogin', 'xxxx2', ''				-- 짜요쿠폰.
exec spu_GiftGainNewTest 'xxxx2', '049000s1i0n7t8445289', -3, 43145, -1, -1, -1, -1	-- 짜요쿠폰.

exec spu_SubGiftSendNew 2,3800,    98, 'SysLogin', 'xxxx2', ''				-- 짜요쿠폰.
exec spu_SubGiftSendNew 2,3800,     1, 'SysLogin', 'xxxx2', ''				-- 짜요쿠폰.
exec spu_GiftGainNewTest 'xxxx2', '049000s1i0n7t8445289', -3, 43146, -1, -1, -1, -1	-- 짜요쿠폰.
exec spu_GiftGainNewTest 'xxxx2', '049000s1i0n7t8445289', -3, 43147, -1, -1, -1, -1	-- 짜요쿠폰.

exec spu_SubGiftSendNew 2,3800,    98, 'SysLogin', 'xxxx2', ''				-- 짜요쿠폰.
exec spu_SubGiftSendNew 2,3800,     2, 'SysLogin', 'xxxx2', ''				-- 짜요쿠폰.
exec spu_GiftGainNewTest 'xxxx2', '049000s1i0n7t8445289', -3, 43148, -1, -1, -1, -1	-- 짜요쿠폰.
exec spu_GiftGainNewTest 'xxxx2', '049000s1i0n7t8445289', -3, 43149, -1, -1, -1, -1	-- 짜요쿠폰.

exec spu_SubGiftSendNew 2,3800,    99, 'SysLogin', 'xxxx2', ''				-- 짜요쿠폰.
exec spu_GiftGainNewTest 'xxxx2', '049000s1i0n7t8445289', -3, 43150, -1, -1, -1, -1	-- 짜요쿠폰.
*/

/*
delete from dbo.tGiftList where gameid = 'xxxx2'
delete from dbo.tPCRoomIP where gameid = 'xxxx2'
declare @idx	int
declare @loop	int

set @idx = -1
set @loop = 0
select top 1 @idx = idx from dbo.tGiftList where gameid = 'xxxx2' and giftkind in (1, 2) order by idx desc
while( @idx != -1)
	begin
		exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, @idx, -1, -1, -1, -1	-- 짜요쿠폰.

		set @loop = @loop + 1
		set @idx = -1
		select top 1 @idx = idx from dbo.tGiftList where gameid = 'xxxx2' and giftkind in (1, 2) order by idx desc
		if(@loop > 300)return;
	end
*/


/*
alter table dbo.tUserMaster add			salefresh		int					default(0)
alter table dbo.tUserMaster add			zcpplus			int					default(0)
alter table dbo.tUserMaster add			zcpchance		int					default(-1)
alter table dbo.tUserMaster add			bkzcpcntfree	int					default(0)
alter table dbo.tUserMaster add			bkzcpcntcash	int					default(0)


alter table dbo.tUserMaster add			phone2			varchar(20)			default('')
alter table dbo.tUserMaster add			zipcode			varchar(6)			default('')
alter table dbo.tUserMaster add			address1		varchar(256)		default('')
alter table dbo.tUserMaster add			address2		varchar(256)		default('')

update dbo.tUserMaster set bkzcpcntfree = 0, bkzcpcntcash = 0, salefresh = 0, zcpplus = 0, zcpchance = -1, phone2 = '', zipcode = '', address1 = '', address2 = ''

update dbo.tUserItem set expirekind = -1
update dbo.tUserItem set expiredate = '2079-01-01'
update dbo.tUserItem set expiredate = getdate() + 60 where itemcode = 3801




*/

--alter table dbo.tDayLogInfoStatic add			zcpcntfree		int				default(0)
--alter table dbo.tDayLogInfoStatic add			zcpcntcash		int				default(0)

--update dbo.tDayLogInfoStatic set zcpcntfree = 0, zcpcntcash = 0


/*
select * from dbo.tItemInfo where subcategory = 38
delete from dbo.tItemInfo where subcategory = 38

insert into dbo.tItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3)
values('spendable', '3800', '3', '38', '0', '짜요 쿠폰조각', '0', '-1', '0', '0', 'jjayocouponpiece', '0', '0', '0', '10', '1', '1', '99개를 모으면 짜요 쿠폰으로 전환되는 조각. 짜요쿠폰으로 전환된 후 실제시간 60일이 지나면 사라져요.', '99', '3801', '-1')
GO

insert into dbo.tItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3)
values('spendable', '3801', '3', '38', '0', '짜요 쿠폰', '0', '-1', '0', '0', 'jjayocoupon', '0', '0', '0', '1000', '1', '1', '정해진 개수를 모으면 짜요상품이 집으로 배달되는 짜요쿠폰. 실제시간 60일이 지나면 사라져요.', '1', '-1', '60')
GO
*/


/*
declare @gameid 	varchar(20)
declare @cnt 		int
declare @cashcost	int

-- 1. 선언하기.
declare curTemp Cursor for
select gameid, count(*), sum(cashcost) from dbo.tRouletteLogPerson where kind = 4 and writedate < '2016-05-10 12:30' --and gameid = 'farm3967580'
group by gameid

-- 2. 커서오픈
open curTemp

-- 3. 커서 사용
Fetch next from curTemp into @gameid, @cnt, @cashcost
while @@Fetch_status = 0
	Begin
		select 'DEBUG ', @gameid, @cnt, @cashcost
		exec spu_SubGiftSendNew 2,  2300, @cnt, '교배 보상 지급', @gameid, ''
		exec spu_SubGiftSendNew 1,    -1, 0, '교배 보상 지급', @gameid, '저희 짜요를 이용해주셔서 감사합니다. 조그마한 보상 차원에서 보내드립니다.'

		Fetch next from curTemp into @gameid, @cnt, @cashcost
	end

-- 4. 커서닫기
close curTemp
Deallocate curTemp
*/



/*
declare @cashpoint_ int

set @cashpoint_ = 0
select top 1 @cashpoint_ cashpoint_, * from dbo.tSystemVIPInfo where @cashpoint_ >= vip_cashpoint order by idx desc

set @cashpoint_ = 4999
select @cashpoint_ cashpoint_, * from dbo.tSystemVIPInfo where @cashpoint_ >= vip_cashpoint order by idx desc

set @cashpoint_ = 5000
select top 1 @cashpoint_ cashpoint_, * from dbo.tSystemVIPInfo where @cashpoint_ >= vip_cashpoint order by idx desc

set @cashpoint_ = 5001
select top 1 @cashpoint_ cashpoint_, * from dbo.tSystemVIPInfo where @cashpoint_ >= vip_cashpoint order by idx desc

set @cashpoint_ = 11000
select top 1 @cashpoint_ cashpoint_, * from dbo.tSystemVIPInfo where @cashpoint_ >= vip_cashpoint order by idx desc

set @cashpoint_ = 11000 + 1
select top 1 @cashpoint_ cashpoint_, * from dbo.tSystemVIPInfo where @cashpoint_ >= vip_cashpoint order by idx desc

set @cashpoint_ = 20000
select top 1 @cashpoint_ cashpoint_, * from dbo.tSystemVIPInfo where @cashpoint_ >= vip_cashpoint order by idx desc

set @cashpoint_ = 20000 + 1
select top 1 @cashpoint_ cashpoint_, * from dbo.tSystemVIPInfo where @cashpoint_ >= vip_cashpoint order by idx desc
*/

/*
select * from dbo.tCashFirstTimeLog where writedate >= getdate() - 30

update dbo.tCashFirstTimeLog set writedate = writedate - 30

select * from dbo.tCashFirstTimeLog where writedate >= getdate() - 30
*/


/*
select * from dbo.tItemInfo where category = 39
delete from dbo.tItemInfo where itemcode in ( 3900 )

insert into dbo.tItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('cashpoint', '3900', '39', '39', '0', '낙농 포인트', '0', '-1', '0', '0', 'promoteticket01', '0', '0', '0', '0', '1', '50', '낙농 포인트')
GO
*/


/*
alter table dbo.tUserMaster add		bkwheelcnt		int					default(0)
update dbo.tUserMaster set bkwheelcnt = 0
*/

/*
---------------------------------------------
-- 	유저강화 로그기록(200까지만 관리).
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserWheelLog', N'U') IS NOT NULL
	DROP TABLE dbo.tUserWheelLog;
GO

create table dbo.tUserWheelLog(
	idx				int				identity(1, 1),

	gameid			varchar(20),
	idx2			int,
	mode			int,		-- 일일룰렛(20), 결정룰렛(21), 황금무료(22)
	usedcashcost	int,		-- 캐쉬비용.
	ownercashcost	int,		-- 보유결정.

	writedate		datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tUserWheelLog_idx PRIMARY KEY(idx)
)
-- 인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserWheelLog_gameid_idx2')
    DROP INDEX tUserWheelLog.idx_tUserWheelLog_gameid_idx2
GO
CREATE INDEX idx_tUserWheelLog_gameid_idx2 ON tUserWheelLog (gameid, idx2)
GO



alter table dbo.tUserMaster add		wheeltodaydate	datetime			default(getdate() - 1)
alter table dbo.tUserMaster add		wheeltodaycnt	int					default(0)
alter table dbo.tUserMaster add		wheelgauage		int					default(0)
alter table dbo.tUserMaster add		wheelfree		int					default(0)
update dbo.tUserMaster set wheeltodaydate = getdate() - 1, wheeltodaycnt = 0, wheelgauage = 0, wheelfree = 0

alter table dbo.tSystemInfo add		wheelgauageflag		int					default(-1)
alter table dbo.tSystemInfo add		wheelgauagepoint	int					default(10)
alter table dbo.tSystemInfo add		wheelgauagemax		int					default(100)
update dbo.tSystemInfo set wheelgauageflag = -1, wheelgauagepoint = 10, wheelgauagemax = 100


alter table dbo.tDayLogInfoStatic add		wheelnor		int				default(0)
alter table dbo.tDayLogInfoStatic add		wheelpre		int				default(0)
alter table dbo.tDayLogInfoStatic add		wheelprefree	int				default(0)
update dbo.tDayLogInfoStatic set wheelnor = 0, wheelpre = 0, wheelprefree = 0
*/


/*
alter table dbo.tDayLogInfoStatic add		cashcnt			int				default(0)
alter table dbo.tDayLogInfoStatic add		cashcnt2		int				default(0)
alter table dbo.tDayLogInfoStatic add		boxopencash		int				default(0)
alter table dbo.tDayLogInfoStatic add		boxopenopen		int				default(0)
alter table dbo.tDayLogInfoStatic add		boxopentriple	int				default(0)
update dbo.tDayLogInfoStatic set cashcnt = 0, cashcnt2 = 0, boxopenopen = 0, boxopencash = 0, boxopentriple = 0
*/


--select * from dbo.tTTTT where gameid = 'farm546103' order by idx desc
--select * from dbo.tUserSaleLog where gameid = 'farm546103' order by idx desc
-- select * from dbo.tUserSaleLog where gameid = 'farm544705' order by idx desc
-- delete from dbo.tTTTT

/*
declare @itemcode int
declare @gameid varchar(20)	set @gameid		= 'xxxx2'
set @itemcode 	= 120515

update dbo.tUserMaster
	set
		tsskillcashcost	= 0,	tsskillheart	= 0,	tsskillgamecost	= 0,
		tsskillfpoint	= 0,	tsskillrebirth	= 0,	tsskillalba		= 0,
		tsskillbullet	= 0,	tsskillvaccine	= 0,	tsskillfeed		= 0,			tsskillbooster		= 0,
		concnt = concnt - 1, 	attenddate = attenddate -1
from dbo.tUserMaster where gameid = @gameid
delete from dbo.tUserItem where gameid = @gameid and invenkind in ( 1040, 1200 )
delete from dbo.tGiftList where gameid = @gameid
select 'DEBUG (전)', tsskillcashcost, tsskillheart, tsskillgamecost, tsskillfpoint, tsskillrebirth, tsskillalba, tsskillbullet, tsskillvaccine, tsskillfeed, tsskillbooster from dbo.tUserMaster where gameid = @gameid

exec spu_SetDirectItemNew @gameid, @itemcode, 0, 3, -1
update dbo.tUserItem set treasureupgrade = 7 where gameid = @gameid and invenkind = 1200
exec spu_TSRetentionEffect  @gameid, @itemcode

select 'DEBUG (후)', tsskillcashcost, tsskillheart, tsskillgamecost, tsskillfpoint, tsskillrebirth, tsskillalba, tsskillbullet, tsskillvaccine, tsskillfeed, tsskillbooster from dbo.tUserMaster where gameid = @gameid
exec spu_Login @gameid, '049000s1i0n7t8445289', 5, 119, '', -1, -1			-- 정상유저
*/





/*
---------------------------------------------
--		디버그정보.
---------------------------------------------
IF OBJECT_ID (N'dbo.tTTTT', N'U') IS NOT NULL
	DROP TABLE dbo.tTTTT;
GO

create table dbo.tTTTT(
	idx				int					IDENTITY(1,1),

	gameid			varchar(20),
	gameyear		int,
	gamemonth		int,
	step			varchar(400)		default(''),
	msg				varchar(400)		default(''),

	writedate		datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tTTTT_idx	PRIMARY KEY(idx)
)
*/



/*
alter table dbo.tSystemInfo add		attend1		int					default(900)
alter table dbo.tSystemInfo add		attend2		int					default(5111)
alter table dbo.tSystemInfo add		attend3		int					default(5112)
alter table dbo.tSystemInfo add		attend4		int					default(5113)
alter table dbo.tSystemInfo add		attend5		int					default(5007)
update dbo.tSystemInfo set attend1 = 900, attend2 = 5111, attend3 = 5112, attend4 = 5113, attend5 = 5007
*/


--delete from dbo.tKakaoMaster where kakaouserid = '101195603'
--select * from dbo.tKakaoMaster where kakaouserid = '101195603'
--alter table dbo.tUserBattleLog add		otheridx		int					default(-1)
--update dbo.tUserBattleLog set otheridx = -1



--update tCashLog set kakaosend = -1 where idx <= 61
--update tCashLog set kakaosend = -1 where idx = 61
--update dbo.tCashLogKakaoSend set checkidx = 0
--alter table dbo.tCashLog add		productid		varchar(40)		default('')
--update tCashLog set productid = ''


/*
-- 처음집테스트.
declare @ttt int set @ttt = 60
update dbo.tUserMaster set
	housestep = 0, tankstep = 0, bottlestep = 0, pumpstep = 0, transferstep = 0, purestep = 0, freshcoolstep = 0, housestate = 1,  tankstate = 1, bottlestate = 1, pumpstate = 1, transferstate = 1, purestate = 1, freshcoolstate = 1,
	housetime = DATEADD(ss, 120, getdate()),
	tanktime = DATEADD(ss, 120, getdate()),
	bottletime = DATEADD(ss, 120, getdate()),
	pumptime = DATEADD(ss, 120, getdate()),
	transfertime = DATEADD(ss, 120, getdate()),
	puretime = DATEADD(ss, 120, getdate()),
	freshcooltime = DATEADD(ss, 120, getdate()),
	gamecost = 1000, cashcost = 1000
where gameid = 'xxxx2'
exec spu_FacUpgradeTest 'xxxx2', '049000s1i0n7t8445289', @ttt, 2, -1



update dbo.tUserMaster set gamecost = 10000000, cashcost = 10000 where gameid = 'xxxx2'
exec spu_FacUpgradeTest 'xxxx2', '049000s1i0n7t8445289', 60, 1, -1		-- 집		(시작).
exec spu_FacUpgradeTest 'xxxx2', '049000s1i0n7t8445289', 60, 2, -1		--			(즉시완료)

*/









/*
update dbo.tUserMaster set feed = 0, heart = 0, cashcost =1000 where gameid = 'xxxx2'
update dbo.tUSerSeed set itemcode = 600, seedstartdate = getdate(), seedenddate = DATEADD(ss, 15, getdate()) where gameid = 'xxxx2' and seedidx = 1
exec spu_SeedHarvest 'xxxx2', '049000s1i0n7t8445289',  1, 2, 0, -1		-- 건초수확

update dbo.tUserMaster set feed = 0, heart = 0, cashcost =1000 where gameid = 'xxxx2'
update dbo.tUSerSeed set itemcode = 600, seedstartdate = getdate(), seedenddate = DATEADD(ss, 600, getdate()) where gameid = 'xxxx2' and seedidx = 1
exec spu_SeedHarvest 'xxxx2', '049000s1i0n7t8445289',  1, 2, 0, -1		-- 건초수확

update dbo.tUserMaster set feed = 0, heart = 0, cashcost =1000 where gameid = 'xxxx2'
update dbo.tUSerSeed set itemcode = 600, seedstartdate = getdate(), seedenddate = DATEADD(ss, 50, getdate()) where gameid = 'xxxx2' and seedidx = 1
exec spu_SeedHarvest 'xxxx2', '049000s1i0n7t8445289',  1, 2, 0, -1		-- 건초수확

update dbo.tUserMaster set feed = 0, heart = 0, cashcost =1000 where gameid = 'xxxx2'
update dbo.tUSerSeed set itemcode = 600, seedstartdate = getdate(), seedenddate = DATEADD(ss, 100, getdate()) where gameid = 'xxxx2' and seedidx = 1
exec spu_SeedHarvest 'xxxx2', '049000s1i0n7t8445289',  1, 2, 0, -1		-- 건초수확

update dbo.tUserMaster set feed = 0, heart = 0, cashcost =1000 where gameid = 'xxxx2'
update dbo.tUSerSeed set itemcode = 600, seedstartdate = getdate(), seedenddate = DATEADD(ss, 200, getdate()) where gameid = 'xxxx2' and seedidx = 1
exec spu_SeedHarvest 'xxxx2', '049000s1i0n7t8445289',  1, 2, 0, -1		-- 건초수확

update dbo.tUserMaster set feed = 0, heart = 0, cashcost =1000 where gameid = 'xxxx2'
update dbo.tUSerSeed set itemcode = 600, seedstartdate = getdate(), seedenddate = DATEADD(ss, 360, getdate()) where gameid = 'xxxx2' and seedidx = 1
exec spu_SeedHarvest 'xxxx2', '049000s1i0n7t8445289',  1, 2, 0, -1		-- 건초수확
*/






/*


declare @tier			int						set @tier				= 1
declare @rand					int				set @rand					= 0
declare @rand2					int				set @rand2					= 0
declare @randbase				int				set @randbase				= 0
declare @randval				int				set @randval				= 0

while(@tier <= 8 )
	begin
		-------------------------
		-- 세포에 대한 렌덤벨류.
		-------------------------
		if( @tier <= 1 or @tier > 8)
			begin
				set @randval 	= 1
				set @randbase 	= 0
			end
		else if( @tier <= 2 )
			begin
				set @randval 	= 2
				set @randbase 	= 0
			end
		else
			begin
				set @randval 	= 3
				set @randbase 	= @tier - 3
			end
		set @rand2 		= Convert(int, ceiling(RAND() * @randval)) + @randbase
		select 'DEBUG ', @tier tier, @randval randval, @randbase randbase, @rand2 rand2
		set @tier = @tier + 1

	end

*/








/*
select dbo.fnu_GetDatePart('s', '2016-03-25 12:00:00', '2016-03-25 11:59:00')
select dbo.fnu_GetDatePart('s', '2016-03-25 12:00:00', '2016-03-25 12:09:00')
select dbo.fnu_GetDatePart('s', '2016-03-25 12:00:00', '2016-03-25 12:10:01')
select dbo.fnu_GetDatePart('s', '2016-03-25 12:00:00', '2016-03-25 12:11:00')
select 590/600, 600/600, 601/600
*/



/*
alter table dbo.tUserMaster add	userbattleanilistidx1	int				default(-1)
alter table dbo.tUserMaster add	userbattleanilistidx2	int				default(-1)
alter table dbo.tUserMaster add	userbattleanilistidx3	int				default(-1)
alter table dbo.tUserMaster add	userbattleflag			int				default(0)

update dbo.tUserMaster set
		userbattleanilistidx1 = -1, userbattleanilistidx2 = -1, userbattleanilistidx3 = -1,
		userbattleflag = 0,
		trophy				= 0,
		boxusing2			= 0,
		boxusing3			= 0,
*/




/*
alter table dbo.tUserMaster add	bgpromoteic		int						default(-1)
alter table dbo.tUserMaster add	bgpromotecnt	int					default(0)
alter table dbo.tUserMaster add	bkpromotecnt	int					default(0)

update dbo.tUserMaster set bgpromoteic = -1
*/



/*
declare @loop int
set @loop = 1
while @loop <= 29
	begin
		--exec spu_SetDirectItem 'farm92180', @loop, 1, -1
		exec spu_SubGiftSendNew 2, @loop,  1, 'SysLogin', 'farm87300', ''
		set @loop = @loop + 1
	end
*/


/*
select DATEPART(DW, getdate())
select DATEPART(DW, getdate())
select DATEPART(DW, getdate())
select DATEPART(DW, getdate())
select DATEPART(DW, getdate())
select DATEPART(DW, getdate())
select DATEPART(DW, getdate())
select DATEPART(DW, getdate())
--목요일 5
	--/// C#    > 일(0) 월(1) 화(2) 수(3) 목(4) 금(5) 토(6) < 이것으로 통일 >
	--/// 서버  > 일(1) 월(2) 화(3) 수(4) 목(5) 금(6) 토(7)
*/


--select 'copy ' + rtrim(str(param12 )) + '.png' + rtrim(str(itemcode)) + '.png' from dbo.tItemInfo where category = 1010 order by itemcode asc




/*
-- 교배 테이블 정보 검사.
-- 51이상 일반교배
select idx, gameid, gamecost, *
	from dbo.tRouletteLogPerson
where
	framelv >= 51
	and kind = 1
	and gamecost > 0
	and writedate >= '2014-09-19' and writedate <= '2014-09-22 10:37'

-- 51 레벨 교배 	: 4500  -> 2500		-- 2000
-- 52~54 레벨 교배 	: 7500  -> 4000		-- 3500
-- 55~57 레벨 교배 	: 10000 -> 6500		-- 3500
-- 58~59 레벨 교배 	: 13000 -> 8000		-- 5000
-- 60 레벨 교배 	: 16000 -> 10000	-- 6000
*/



/*
declare @itemcode1 			int 			set @itemcode1 	= 5027
declare @itemcode2 			int 			set @itemcode2 	= 5026
declare @itemcode3 			int 			set @itemcode3 	= 5025
declare @gameid 			varchar(20)
declare @backschoolrank 	int
declare @backuserrank	 	int
declare @comment 			varchar(80)		set @comment	= '긴급패치보상'

-- 1. 선언하기.
declare curSchoolRand4Over Cursor for
select gameid, backschoolrank, backuserrank
	from dbo.tSchoolUser
where (backschoolrank >= 4 and backschoolrank <= 500)
	  and backuserrank <= 3
	  and backschoolidx != -1
	  and backuserrank != -1
	  and backdateid = '20140921'
order by backschoolrank asc, backuserrank asc

-- 2. 커서오픈
open curSchoolRand4Over

-- 3. 커서 사용
Fetch next from curSchoolRand4Over into @gameid, @backschoolrank, @backuserrank
while @@Fetch_status = 0
	Begin
		if(@backuserrank = 1)
			begin
				set @comment = '학교 ' + ltrim(str(@backschoolrank)) + '등 1위'
				--select 'DEBUG 1위', @comment comment
				exec spu_SubGiftSend 2,   @itemcode1, @comment, @gameid, ''
			end
		else if(@backuserrank = 2)
			begin
				set @comment = '학교 ' + ltrim(str(@backschoolrank)) + '등 2위'
				--select 'DEBUG 2위', @comment comment
				exec spu_SubGiftSend 2,   @itemcode2, @comment, @gameid, ''
			end
		else if(@backuserrank = 3)
			begin
				set @comment = '학교 ' + ltrim(str(@backschoolrank)) + '등 3위'
				--select 'DEBUG 3위', @comment comment
				exec spu_SubGiftSend 2,   @itemcode3, @comment, @gameid, ''
			end

		Fetch next from curSchoolRand4Over into @gameid, @backschoolrank, @backuserrank
	end

-- 4. 커서닫기
close curSchoolRand4Over
Deallocate curSchoolRand4Over
*/

/*
declare @farmidx		int,
		@gameid_		varchar(20)
set @gameid_ = 'farm939124667'	-- test pc

--delete from dbo.tUserGameMTBaseball where gameid = @gameid_ and itemcode >= 6944
select @farmidx = max(farmidx) from dbo.tUserGameMTBaseball where gameid = @gameid_
--select @farmidx farmidx

--insert into dbo.tUserGameMTBaseball(farmidx, gameid, itemcode)
select (rank() over(order by itemcode asc) + @farmidx) as farmidx, @gameid_, itemcode from dbo.tItemInfo
where subcategory = 69
	and itemcode not in (select itemcode from dbo.tUserGameMTBaseball where gameid = @gameid_)
order by itemcode asc
*/

/*
declare @idx int set @idx = 0
select @idx = max(idx) from dbo.tUserMaster
while(@idx > -1000)
	begin
		update dbo.tUserMaster
			set
				rtngameid	= '',
				rtndate		= getdate() - 1,
				rtnstep		= -1,
				rtnplaycnt	= 0
		where idx >= @idx - 1000 and idx <= @idx
		set @idx =  @idx - 1000
	end
*/


/*
declare @cashpoint 	int
declare @gameid 	varchar(20)

-- 1. 선언하기.
declare curCashPoint Cursor for
-- update dbo.tUserMaster set cashpoint	= 0 where gameid = 'farm642687765'
-- select gameid, cash from dbo.tCashLog where gameid = 'farm642687765'
select gameid, cash from dbo.tCashLog

-- 2. 커서오픈
open curCashPoint

-- 3. 커서 사용
Fetch next from curCashPoint into @gameid, @cashpoint
while @@Fetch_status = 0
	Begin
		update dbo.tUserMaster
			set
				cashpoint = isnull(cashpoint, 0) + @cashpoint
		where gameid = @gameid

		Fetch next from curCashPoint into @gameid, @cashpoint
	end

-- 4. 커서닫기
close curCashPoint
Deallocate curCashPoint
*/




--select gameid, COUNT(*) from dbo.tGiftList where giftdate > '2014-07-26 16:00' and itemcode = 5108 group by gameid

/*
declare @itemcode int 			set @itemcode 	= 5108				-- 14000코인 x 3박스
declare @eventname varchar(20)	set @eventname	= '긴급패치보상'
declare @gameid varchar(20)

-- 1. 선언하기.
declare curENCheck Cursor for
--select gameid from dbo.tUserMaster where gameid = 'farm269756530'
select gameid from dbo.tUserMaster where famelv >= 50 and market in (5, 6) and condate >= '2014-07-26 16:00'

-- 2. 커서오픈
open curENCheck

-- 3. 커서 사용
Fetch next from curENCheck into @gameid
while @@Fetch_status = 0
	Begin
		if(exists(select top 1 * from dbo.tGiftList where gameid = @gameid and itemcode = @itemcode))
			begin
				select 'DEBUG 받아감'
			end
		else
			begin
				exec spu_SubGiftSend 2,   @itemcode, @eventname, @gameid, ''
				exec spu_SubGiftSend 2,   @itemcode, @eventname, @gameid, ''
				exec spu_SubGiftSend 2,   @itemcode, @eventname, @gameid, ''
			end

		Fetch next from curENCheck into @gameid
	end

-- 4. 커서닫기
close curENCheck
Deallocate curENCheck
*/



/*
select top 500 a.idx 'idx',
	dateid8,
	a.itemcode 'itemcode', b.itemname,
	a.gamecost 'gamecost', a.cashcost 'cashcost',
	a.cnt, y.pack11, y.pack21, y.pack31, y.pack41, y.pack51, y.pack61
from
		dbo.tUserItemBuyLogTotalSub a
	JOIN
		dbo.tItemInfo b
		ON a.itemcode = b.itemcode
	JOIN
		tSystemYabau y
		ON a.itemcode = y.itemcode
where subcategory = 700
and dateid8 in ('20140722', '20140723')
order by a.gamecost desc, a.cashcost desc


select * from dbo.tItemInfo where subcategory = 700
*/


/*
-- 2주간 활동안한 유저는 학교 강제탈퇴.
declare @gameid 			varchar(20),
		@schoolidx			int,
		@joindate			datetime,
		@idx				int

set @joindate	= getdate() - 14

-- 1. 선언하기.
declare curSchoolNonActive Cursor for
select gameid, schoolidx from dbo.tSchoolUser where joindate < @joindate and schoolidx != -1 and point = 0

-- 2. 커서오픈
open curSchoolNonActive

-- 3. 커서 사용
Fetch next from curSchoolNonActive into @gameid, @schoolidx
while @@Fetch_status = 0
	Begin
		-- 학교 개인정보
		update dbo.tSchoolUser set schoolidx = -1 where gameid = @gameid

		-- 학교 마스터
		update dbo.tSchoolMaster set cnt = cnt - 1 where schoolidx = @schoolidx

		-- 유저 정보갱신
		update dbo.tUserMaster set schoolidx = -1 where gameid = @gameid

		Fetch next from curSchoolNonActive into @gameid, @schoolidx
	end

-- 4. 커서닫기
close curSchoolNonActive
Deallocate curSchoolNonActive
*/


/*
alter table dbo.tUserMaster add 	yabaucount		int					default(0)

declare @idx int set @idx = 0
select @idx = max(idx) from dbo.tUserMaster
while(@idx > -1000)
	begin
		update dbo.tUserMaster
			set
				yabaucount	= 0
		where idx >= @idx - 1000 and idx <= @idx
		set @idx =  @idx - 1000
	end
*/

/*
declare @rand			int				set @rand			= 0
declare @needyabaunum	int				set @needyabaunum	= 5

select Convert(int, ceiling(RAND() * (12 - @needyabaunum + 1 )))
set @rand = Convert(int, ceiling(RAND() * (12 - @needyabaunum + 1 ))) + @needyabaunum -1

select @rand
*/







/*
alter table dbo.tUserMaster add 	yabauresult		int					default(0)

declare @idx int set @idx = 0
select @idx = max(idx) from dbo.tUserMaster
while(@idx > -1000)
	begin
		update dbo.tUserMaster
			set
				yabauresult	= 0
		where idx >= @idx - 1000 and idx <= @idx
		set @idx =  @idx - 1000
	end
*/

/*
declare @loop int set @loop = 0
while(@loop < 100)
	begin
		select Convert(int, ceiling(RAND() * 11)) + 1
		set @loop = @loop + 1
	end
*/

/*
			select top 1 * from dbo.tSystemYabau
			where famelvmin <= @famelv
				and @famelv <= famelvmax
				and packstate = 1
				and packmarket like @strmarket
				order by newid()
*/




/*
--select '시', DATEpart(Hour, GETDATE())

declare @date datetime
set @date = '2014-07-10 00:12'
select @date, DATEpart(Hour, @date)
set @date = '2014-07-10 09:12'
select @date, DATEpart(Hour, @date)
set @date = '2014-07-10 10:12'
select @date, DATEpart(Hour, @date)
set @date = '2014-07-10 12:12'
select @date, DATEpart(Hour, @date)
set @date = '2014-07-10 19:12'
select @date, DATEpart(Hour, @date)
set @date = '2014-07-10 23:12'
select @date, DATEpart(Hour, @date)
set @date = '2014-07-10 24:12'
select @date, DATEpart(Hour, @date)
*/

/*
declare @gameid varchar(20) set @gameid = 'farm939085910'
exec spu_SubGiftSend 2,     17, 'SysLogin', @gameid, ''
exec spu_SubGiftSend 2,     20, 'SysLogin', @gameid, ''
exec spu_SubGiftSend 2,     21, 'SysLogin', @gameid, ''
exec spu_SubGiftSend 2,     23, 'SysLogin', @gameid, ''
exec spu_SubGiftSend 2,     117, 'SysLogin', @gameid, ''
exec spu_SubGiftSend 2,     119, 'SysLogin', @gameid, ''
exec spu_SubGiftSend 2,     120, 'SysLogin', @gameid, ''
exec spu_SubGiftSend 2,     121, 'SysLogin', @gameid, ''
exec spu_SubGiftSend 2,     217, 'SysLogin', @gameid, ''
exec spu_SubGiftSend 2,     219, 'SysLogin', @gameid, ''
exec spu_SubGiftSend 2,     220, 'SysLogin', @gameid, ''
exec spu_SubGiftSend 2,     221, 'SysLogin', @gameid, ''



declare @gameid varchar(20) set @gameid = 'farm939087130'
exec spu_SubGiftSend 2,     17, 'SysLogin', @gameid, ''
exec spu_SubGiftSend 2,     20, 'SysLogin', @gameid, ''
exec spu_SubGiftSend 2,     21, 'SysLogin', @gameid, ''
exec spu_SubGiftSend 2,     23, 'SysLogin', @gameid, ''
exec spu_SubGiftSend 2,     117, 'SysLogin', @gameid, ''
exec spu_SubGiftSend 2,     119, 'SysLogin', @gameid, ''
exec spu_SubGiftSend 2,     120, 'SysLogin', @gameid, ''
exec spu_SubGiftSend 2,     121, 'SysLogin', @gameid, ''
exec spu_SubGiftSend 2,     217, 'SysLogin', @gameid, ''
exec spu_SubGiftSend 2,     219, 'SysLogin', @gameid, ''
exec spu_SubGiftSend 2,     220, 'SysLogin', @gameid, ''
exec spu_SubGiftSend 2,     221, 'SysLogin', @gameid, ''
*/

/*
alter table dbo.tUserSaleLog add 	cashcost	int						default(0)
alter table dbo.tUserSaleLog add 	gamecost	int						default(0)
alter table dbo.tUserSaleLog add 	feed		int						default(0)
alter table dbo.tUserSaleLog add 	fpoint		int						default(0)
alter table dbo.tUserSaleLog add 	heart		int						default(0)
*/

/*
alter table dbo.tUserMaster add 	trade0		tinyint					default(0)
alter table dbo.tUserMaster add 	trade1		tinyint					default(1)
alter table dbo.tUserMaster add 	trade2		tinyint					default(2)
alter table dbo.tUserMaster add 	trade3		tinyint					default(3)
alter table dbo.tUserMaster add 	trade4		tinyint					default(4)
alter table dbo.tUserMaster add 	trade5		tinyint					default(5)
alter table dbo.tUserMaster add 	trade6		tinyint					default(6)
alter table dbo.tUserMaster add 	tradedummy	tinyint					default(0)



-- select max(idx) from dbo.tUserMaster
declare @idx int set @idx = 0
select @idx = max(idx) from dbo.tUserMaster
while(@idx > -1000)
	begin
		update dbo.tUserMaster
			set
				trade0 	= 0,	--7
				trade1 	= 1,	--8
				trade2 	= 2,	--9
				trade3 	= 3,	--10
				trade4 	= 4,	--11
				trade5 	= 5,	--12
				trade6 	= 6,	--13
				tradedummy = 0
		where idx >= @idx - 1000 and idx <= @idx
		set @idx =  @idx - 1000
	end
*/



--select * from dbo.tItemInfo where subcategory = 69 and itemcode >= 6930
--update dbo.tItemInfo set param3 = 5000 where subcategory = 69 and itemcode >= 6930

/*
-- delete from dbo.tUserGameMTBaseball where gameid = 'xxxx3' and itemcode >= 6930
declare @ITEM_SUBCATEGORY_USERFARM			int					set @ITEM_SUBCATEGORY_USERFARM	 			= 69	-- 전국목장
declare @gameid_ 				varchar(20)	set @gameid_ = 'xxxx3'
declare @farmidx				int				set @farmidx					= 0

--select * from dbo.tUserGameMTBaseball where gameid = @gameid_

if(not exists(select top 1 * from dbo.tUserGameMTBaseball where gameid = @gameid_ and itemcode = 6952))
	begin
		select @farmidx = max(farmidx) from dbo.tUserGameMTBaseball where gameid = @gameid_

		insert into dbo.tUserGameMTBaseball(farmidx, gameid, itemcode)
		select (rank() over(order by itemcode asc) + @farmidx) as farmidx, @gameid_, itemcode from dbo.tItemInfo
		where subcategory = @ITEM_SUBCATEGORY_USERFARM
			and itemcode not in (select itemcode from dbo.tUserGameMTBaseball where gameid = @gameid_)
		order by itemcode asc
	end
--select * from dbo.tUserGameMTBaseball where gameid = @gameid_
*/
--select * from dbo.tUserMaster where gamemonth > 12


/*
alter table dbo.tDogamList add 	cnt				int				default(0)

-- select max(idx) from dbo.tDogamList
declare @idx int set @idx = 0
select @idx = max(idx) from dbo.tDogamList
while(@idx > -1000)
	begin
		update dbo.tDogamList
			set
				cnt 	= 0
		where idx >= @idx - 1000 and idx <= @idx
		set @idx =  @idx - 1000
	end
*/


/*
alter table dbo.tUserMaster add 	bgtradecnt		int					default(0)
alter table dbo.tUserMaster add 	bgcomposecnt 	int					default(0)

declare @idx int set @idx = 0
select @idx = max(idx) from dbo.tUserMaster
while(@idx > -1000)
	begin
		update dbo.tUserMaster
			set
				bgtradecnt 		= 0,
				bgcomposecnt 	= 0
		where idx >= @idx - 1000 and idx <= @idx
		set @idx =  @idx - 1000
	end
*/

/*
select param15, * from dbo.tItemInfo where subcategory = 1010
update dbo.tItemInfo set param15 = 0 where subcategory = 1010
update dbo.tItemInfo set param15 = 1 where subcategory = 1010 and itemcode >= 101005
*/

/*
insert into dbo.tNotice(market, buytype, comfile, comurl, comfile2, comurl2, comfile3, comurl3, comment, version, patchurl, recurl, smsurl, smscom, writedate, syscheck, iteminfover, iteminfourl, comfile4, comurl4, comfile5, comurl5)
select 6, buytype, comfile, comurl, comfile2, comurl2, comfile3, comurl3, comment, version, patchurl, recurl, smsurl, smscom, writedate, syscheck, iteminfover, iteminfourl, comfile4, comurl4, comfile5, comurl5 from dbo.tNotice where market = 5
*/

/*
select * from dbo.tDayLogInfoStatic
group by dateid8
order by dateid8 desc, market asc, idx desc

select dateid8, SUM(joinguestcnt) from dbo.tDayLogInfoStatic
group by dateid8
order by 2 desc

select dateid8, SUM(joinguestcnt) from dbo.tDayLogInfoStatic
where dateid8
order by 2 desc


select SUM(joinguestcnt)/COUNT(*) from dbo.tDayLogInfoStatic
where dateid8 like '201405%' or dateid8 like '201406%'


declare @attenddate datetime set @attenddate = getdate()
select COUNT(*) from dbo.tUserMaster where attenddate >= (@attenddate - 2)
select COUNT(*) from dbo.tUserMaster where attenddate >= (@attenddate - 7)
*/

/*
update dbo.tUserMaster set gamecost = 100000, cashcost = 100000 where gameid = 'xxxx7'

select gamecost, cashcost from dbo.tUserMaster where gameid = 'xxxx7'
exec spu_ItemBuy 'xxxx7', '049000s1i0n7t8445289', 1600, 1, -1, -1, -1, 7780, -1	-- 시간초기화템
select gamecost, cashcost from dbo.tUserMaster where gameid = 'xxxx7'
exec spu_ItemBuy 'xxxx7', '049000s1i0n7t8445289', 1601, 1, -1, -1, -1, 7781, -1	-- 시간초기화템
select gamecost, cashcost from dbo.tUserMaster where gameid = 'xxxx7'
*/

/*
--insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 40, 2301, 2, 0, -1, 3, 5)
--insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 41, 2307, 99, 0, -1, 3, 5)

declare @DEFINE_HOW_GET_GIFT				int					set @DEFINE_HOW_GET_GIFT					= 5	--검색
declare @USERITEM_INVENKIND_CONSUME			int 				set @USERITEM_INVENKIND_CONSUME				= 3
declare @gameid			varchar(20)
declare @cnt			int
declare @listidx		int
declare @listidxnew		int
declare @itemcodemaster	int				set @itemcodemaster		= 2300
declare @itemcodemin	int				set @itemcodemin		= 2301
declare @itemcodemax	int				set @itemcodemax		= 2307

-- 1. 커서 생성
declare curTicket Cursor for
select gameid, listidx, cnt from dbo.tUserItem where itemcode >= @itemcodemin and itemcode <= @itemcodemax and cnt > 0 and invenkind = @USERITEM_INVENKIND_CONSUME
--and gameid = 'xxxx2'

-- 2. 커서오픈
open curTicket

-- 3. 커서 사용
Fetch next from curTicket into @gameid, @listidx, @cnt
while @@Fetch_status = 0
	Begin
		--select 'DEBUG ', @gameid gameid, @listidx listidx, @cnt cnt
		if(exists(select top 1 * from dbo.tUserItem where gameid = @gameid and itemcode = @itemcodemaster))
			begin
				--select 'DEBUG ', '존재 > +cnt, 기존것 0'
				update dbo.tUserItem
					set
						cnt = cnt + @cnt
				where gameid = @gameid and itemcode = @itemcodemaster
			end
		else
			begin
				--select 'DEBUG ', '새것 입력, 기존것 0'
				select @listidxnew = isnull(MAX(listidx), 0) + 1 from dbo.tUserItem where gameid = @gameid
				insert into dbo.tUserItem(gameid,      listidx,  itemcode,        cnt,  invenkind, gethow)
				values(					 @gameid,  @listidxnew, @itemcodemaster,       @cnt,  @USERITEM_INVENKIND_CONSUME, @DEFINE_HOW_GET_GIFT)
			end

		update dbo.tUserItem
			set
				cnt = 0
		where gameid = @gameid and listidx = @listidx

		Fetch next from curTicket into @gameid, @listidx, @cnt
	end

-- 4. 커서닫기
close curTicket
Deallocate curTicket
*/


/*
- SKT 이벤트 아이템 일괄지급
6/22 부토 T스토어 단독 이벤트가 종료되었습니다.
- 기준일 : 6/9 ~ 6/22 23:59
- 지급일 : 6/23 ~6/24 * 늦어도 6/24 오전까지 지급처리를 완료 부탁드리겠습니다.
1) 이벤트 기간동안 짜요 목장 이야기 for Kakao를 다운받은 신규 T스토어 유저
	-> 수정 100개 + 부활석 20개 + 긴급요청 티켓 20개 지급
2) 이벤트 기간동안 발생된 누적 결제금액에 대해 보너스 수정 지급
	-> 5000원 이상 	: 보너스 수정 3개
	-> 10000원 이상 	: 보너스 수정 5개
	-> 30000원 이상 	: 보너스 수정 25개
	-> 100000원 이상 	: 보너스 수정 110개
	-> 300000원 이상 	: 보너스 수정 490개
	-> 500000원 이상 	: 보너스 수정 1,090개
	-> 1000000원 이상 	: 보너스 수정 2,720개
*/

/*
declare @gameid_	varchar(20) set @gameid_ = 'xxxx2'
declare @idx2		int			set @idx2 		= 0
declare @USER_LIST_MAX					int					set @USER_LIST_MAX 						= 50
select * from dbo.tComReward where gameid = @gameid_ order by idx2 desc
select * from dbo.tComReward order by idx2 desc

select @idx2 = isnull(max(idx2), 1) from dbo.tComReward where gameid = @gameid_
set @idx2 = @idx2 + 1
select @idx2
*/


/*

declare @market_			int					set @market_					= 7
declare @strmarket			varchar(40)

set @strmarket = '%' + ltrim(rtrim(str(@market_))) + '%'

select top 1 * from dbo.tSystemPack
where famelvmin <= 5
	and 5 <= famelvmax
	and packstate = 1
	and packmarket like @strmarket
	order by newid()

*/


--update dbo.tSystemInfo set iphonecoupon = 0 where idx = 10
/*
declare @gameid		varchar(20)		set @gameid = 'farm49'
declare @friend		varchar(20)
declare @password	varchar(20)
declare @idx		int				set @idx	= 46

select @password = password from dbo.tUserMaster where gameid = @gameid
update dbo.tUserFriend set helpdate = getdate() - 10 where gameid = @gameid
-- 1. 커서 생성
declare curHelpFriend Cursor for
select friendid from dbo.tUserFriend where gameid = @gameid

-- 2. 커서오픈
open curHelpFriend

-- 3. 커서 사용
Fetch next from curHelpFriend into @gameid
while @@Fetch_status = 0
	Begin
		-- 3-1. 도움요청(나0
		exec spu_KakaoFriendHelp @gameid, @password, @friend, @idx, -1

		-- 3-2. 도움처리(친구)
		exec sup_subKakaoHelpWait @friend

		Fetch next from curHelpFriend into @gameid
	end

-- 4. 커서닫기
close curHelpFriend
Deallocate curHelpFriend
*/



/*
IF OBJECT_ID (N'dbo.tTTT', N'U') IS NOT NULL
	DROP TABLE dbo.tTTT;
GO
create table dbo.tTTT(
	idx				int					IDENTITY(1,1),

	t1				float 				default(7.99),
	t2 				decimal(10, 2)		default(7.99)
)
GO
insert into dbo.tTTT(t1, t2) values(9.01, 9.01)
insert into dbo.tTTT(t1, t2) values(8.02, 8.02)
insert into dbo.tTTT(t1, t2) values(7.03, 7.03)
insert into dbo.tTTT(t1, t2) values(6.04, 6.04)
insert into dbo.tTTT(t1, t2) values(5.75, 5.75)
insert into dbo.tTTT(t1, t2) values(4.54, 4.54)
insert into dbo.tTTT(t1, t2) values(3.32, 3.32)
insert into dbo.tTTT(t1, t2) values(2.10, 2.10)
insert into dbo.tTTT(t1, t2) values(1.03, 1.03)
insert into dbo.tTTT(t1, t2) values(0.07, 0.07)
select * from tTTT



declare @t1 	float
declare @t2 	decimal(10, 2)
declare @t1sum 	float				set @t1sum 		= 0
declare @t2sum 	decimal(10, 2)		set @t2sum 		= 0
declare @t3sum 	float				set @t3sum 		= 0
declare @t4sum 	decimal(10, 2)		set @t4sum 		= 0

-- 1. 선언하기.
declare curTemp Cursor for
select t1, t2 from dbo.tTTT

-- 2. 커서오픈
open curTemp

-- 3. 커서 사용
Fetch next from curTemp into @t1, @t2
while @@Fetch_status = 0
	Begin
		set @t1sum = @t1sum + @t1
		set @t2sum = @t2sum + @t2
		set @t3sum = @t2sum
		set @t4sum = @t1sum
		select 'DEBUG ', @t1 t1, @t2 t2, @t1sum t1sum, @t2sum t2sum, @t3sum t3sum, @t4sum t4sum

		Fetch next from curTemp into @t1, @t2
	end

-- 4. 커서닫기
close curTemp
Deallocate curTemp
*/


