select * from dbo.tAdminUser

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
---------------------------------------------
--		PC방정보...
---------------------------------------------
IF OBJECT_ID (N'dbo.tPCRoomIP', N'U') IS NOT NULL
	DROP TABLE dbo.tPCRoomIP;
GO

create table dbo.tPCRoomIP(
	idx				int					IDENTITY(1,1),

	gameid			varchar(20),
	pcip			varchar(20),

	writedate		datetime			default(getdate()),			-- 등록일..

	-- Constraint
	CONSTRAINT	pk_tPCRoomIP_gameid_pcip	PRIMARY KEY(gameid, pcip),
	CONSTRAINT	uk_tPCRoomIP_pcip			UNIQUE( pcip )
)

-- insert into dbo.tPCRoomIP(gameid, pcip) values('xxxx', '127.0.0.1')
-- insert into dbo.tPCRoomIP(gameid, pcip) values('xxxx', '127.0.0.2')
-- insert into dbo.tPCRoomIP(gameid, pcip) values('xxxx', '127.0.0.3')
-- insert into dbo.tPCRoomIP(gameid, pcip) values('xxxx2', '127.0.0.3')		--error 가 정상이다.
-- select top 1 * from dbo.tPCRoomIP where pcip = '127.0.0.1'
-- select * from dbo.tPCRoomIP where gameid = 'xxxx'
-- update dbo.tPCRoomIP set pcip = '127.0.0.1' where gameid = 'xxxx' and pcip = '127.0.0.1'



---------------------------------------------
--	유니크 가입현황파악하기
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserPhone', N'U') IS NOT NULL
	DROP TABLE dbo.tUserPhone;
GO

create table dbo.tUserPhone(
	idx					int 				IDENTITY(1, 1),

	phone				varchar(20),
	joincnt				int					default(1),
	writedate			datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tUserPhone_idx	PRIMARY KEY(idx)
)
-- 폰인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserPhone_phone')
    DROP INDEX tUserPhone.idx_tUserPhone_phone
GO
CREATE INDEX idx_tUserPhone_phone ON tUserPhone (phone)
GO
-- select top 1 * from dbo.tUserPhone
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


