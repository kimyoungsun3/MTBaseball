--select * from dbo.tZCPMarket
--update dbo.tZCPMarket set zcporder = 0
/*

---------------------------------------------
-- 	마켓정보.
---------------------------------------------
IF OBJECT_ID (N'dbo.tZCPMarket', N'U') IS NOT NULL
	DROP TABLE dbo.tZCPMarket;
GO

create table dbo.tZCPMarket(
	idx				int				identity(1, 1),

	kind			int				default(1),			-- Best(1)
														-- 일반(2)
														-- 월별한정(3)
														-- 날씬한끼(4)
														-- 든든한끼(5)
														-- 기타(6)
	title			varchar(60),						-- 타이틀
	zcpfile			varchar(512),						-- 이미지URL
	zcpurl			varchar(512),						-- 점프URL
	bestmark		int				default(-1),		-- Best마큰		YES(1) NO(-1)
	newmark			int				default(-1),		-- New마크	 	YES(1) NO(-1)
	needcnt			int				default(99),		-- 필요쿠폰수량
	firstcnt		int				default(0),			-- 입고량
	balancecnt		int				default(0),			-- 사용량
	commentsimple	varchar(512),						-- 상세설명(간략)
	commentdesc		varchar(2048),						-- 상세설명(상세)
	opendate		smalldatetime	default(getdate()),	-- 오픈날짜
	expiredate		smalldatetime	default(getdate() + 30),-- 만기날짜
	zcpflag			int				default(-1),		-- 활성여부 비활성(-1), 활성(1)
	zcporder		int				default(0),			-- 오더링(순서)

	writedate		smalldatetime	default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tZCPMarket_idx PRIMARY KEY(idx)
)

--insert into dbo.tZCPMarket( kind ) values( 1 )
--update dbo.tZCPMarket
--	set
--		kind 	= 2,
--		title	= '구이구이 소고기',
--		zcpfile	= 'http://121.138.201.251:40012/Game4FarmVill5/etc/_ad/gift_card.png',
--		zcpurl	= '',
--		bestmark= 1,
--		newmark	= 1,
--		needcnt	= 99,
--		firstcnt= 50,
--		balancecnt= 0,
--		commentsimple= '마블링된 소고기 간략설명',
--		commentdesc	 = '마블링된 소고기 상세설명',
--		opendate	= '2016-05-25',
--		expiredate	= '2016-05-31',
--		zcpflag		= 1,
--		zcporder	= 0
--where idx = 2
--select * from dbo.tZCPMarket where zcpflag = 1 and getdate() < expiredate order by kind asc, zcporder desc


---------------------------------------------
-- 	짜요장터에서 구매한 정보..
---------------------------------------------
IF OBJECT_ID (N'dbo.tZCPOrder', N'U') IS NOT NULL
	DROP TABLE dbo.tZCPOrder;
GO

create table dbo.tZCPOrder(
	idx				int				identity(1, 1),

	gameid			varchar(20),
	state			int				default(0),			-- 대기중(0), 확인중(1), 발송완료(2)
	zcpidx			int				default(-1),
	comment			varchar(1024)	default(''),
	usecnt			int				default(0),
	orderdate		smalldatetime	default(getdate()),

	adminid			varchar(20)			default(''),
	comment2		varchar(1024)		default(''),
	deliverdate		smalldatetime,

	-- Constraint
	CONSTRAINT	pk_tZCPOrder_idx PRIMARY KEY(idx)
)

--insert into dbo.tZCPOrder( gameid, zcpidx, usecnt )
--values(                   'xxxx2',      1,     15 )
--update dbo.tZCPOrder
--	set
--		state 		= 1,
--		dealdate	= getdate()
--where idx = 1
--
-- select * from dbo.tZCPOrder order by idx desc
-- select * from dbo.tZCPOrder where state = 0 order by idx desc


select top 10 expirekind, expiredate from dbo.tUserItemDel

--alter table dbo.tUserItemDel add			expirekind		int					default(-1)
--alter table dbo.tUserItemDel add			expiredate		smalldatetime
--update dbo.tUserItemDel set expirekind = -1
*/

/*

update dbo.tZCPMarket
	set
		kind 	= 1,
		title	= '문화 상품권',
		zcpfile	= 'http://121.138.201.251:40012/Game4FarmVill5/etc/_ad/gift_card.png',
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
		zcpfile	= 'http://121.138.201.251:40012/Game4FarmVill5/etc/_ad/Beef.png',
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
		zcpfile	= 'http://121.138.201.251:40012/Game4FarmVill5/etc/_ad/milk.png',
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
delete from dbo.tUserItem where gameid = 'xxxx2'
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



alter table dbo.tUserItem add			expirekind		int					default(-1)
alter table dbo.tUserItem add			expiredate		smalldatetime		default('2079-01-01')

update dbo.tUserItem set expirekind = -1
update dbo.tUserItem set expiredate = '2079-01-01'
update dbo.tUserItem set expiredate = getdate() + 60 where itemcode = 3801





---------------------------------------------
-- 	유저 짜요쿠폰룰롯 로고.
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserZCPLog', N'U') IS NOT NULL
	DROP TABLE dbo.tUserZCPLog;
GO

create table dbo.tUserZCPLog(
	idx				int				identity(1, 1),

	gameid			varchar(20),
	idx2			int,
	mode			int,		-- 일일룰렛(0), 결정룰렛(1)
	usedcashcost	int,		-- 캐쉬비용.
	ownercashcost	int,		-- 보유결정.
	cnt				int,		-- 획득개수

	writedate		smalldatetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tUserZCPLog_idx PRIMARY KEY(idx)
)
-- 인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserZCPLog_gameid_idx2')
    DROP INDEX tUserZCPLog.idx_tUserZCPLog_gameid_idx2
GO
CREATE INDEX idx_tUserZCPLog_gameid_idx2 ON tUserZCPLog (gameid, idx2)
GO
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

--update dbo.tUserMaster set rkteam = -1, rkstartstate = 0
--select * from dbo.tUserMaster where rksalemoney != 0 or rkbattlecnt != 0 or rkroulettecnt != 0

/*
---------------------------------------------
--		랭킹대전기록(전체).
---------------------------------------------
IF OBJECT_ID (N'dbo.tRankDaJun', N'U') IS NOT NULL
	DROP TABLE dbo.tRankDaJun;
GO

create table dbo.tRankDaJun(
	idx			int 					IDENTITY(1, 1),

	--(날짜정보)
	rkdateid8		varchar(8),
	rkteam1			int					default(0),				-- 홀팀점수
	rkteam0			int					default(0),				-- 짝팀점수
	rkreward		int					default(0),				-- 미지급(0), 지급(1)

	-- 홀수.
	rksalemoney		bigint				default(0),				-- 판매수익(0).
	rksalebarrel	bigint				default(0),				-- 생산배럴(30).
	rkbattlecnt		bigint				default(0),				-- 배틀횟수(31).
	rkbogicnt		bigint				default(0),				-- 동물교배,보물뽑기(32).
	rkfriendpoint	bigint				default(0),				-- 친구포인트(자동수집).
	rkroulettecnt	bigint				default(0),				-- 룰렛횟수(20, 21).
	rkwolfcnt		bigint				default(0),				-- 늑대잡기(33).

	-- 짝수.
	rksalemoney2	bigint				default(0),				-- 판매수익(0).
	rksalebarrel2	bigint				default(0),				-- 생산배럴(30).
	rkbattlecnt2	bigint				default(0),				-- 배틀횟수(31).
	rkbogicnt2		bigint				default(0),				-- 동물교배,보물뽑기(32).
	rkfriendpoint2	bigint				default(0),				-- 친구포인트(자동수집).
	rkroulettecnt2	bigint				default(0),				-- 룰렛횟수(20, 21).
	rkwolfcnt2		bigint				default(0),				-- 늑대잡기(33).

	-- Constraint
	CONSTRAINT pk_tRankDaJun_rkdateid8	PRIMARY KEY(rkdateid8)
)
GO
update dbo.tUserMaster set
	rkstartstate	= 0,
	rkstartdate		= getdate() - 1,
	condate			= getdate() - 1,
	attenddate		= getdate() - 1,
	wheeltodaydate	= getdate() - 1,
	rkteam			= 1,

	rksalemoney		= 0,
	rksalebarrel	= 0,
	rkbattlecnt		= 0,
	rkbogicnt		= 0,
	rkfriendpoint	= 0,
	rkroulettecnt	= 0,
	rkwolfcnt		= 0,
	rktotal			= 0,

	rksalemoneybk	= 0,
	rksalebarrelbk	= 0,
	rkbattlecntbk	= 0,
	rkbogicntbk		= 0,
	rkfriendpointbk	= 0,
	rkroulettecntbk	= 0,
	rkwolfcntbk		= 0,
	rktotalbk		= 0
where gameid in ('farm554587', 'xxxx2', 'xxxx3')
*/

/*
alter table dbo.tUserMaster add			rkstartstate	int					default(0)
alter table dbo.tUserMaster add			rkstartdate		datetime			default(getdate())
alter table dbo.tUserMaster add			rkteam			int					default(1)
alter table dbo.tUserMaster add			rksalemoney		bigint				default(0)
alter table dbo.tUserMaster add			rksalebarrel	bigint				default(0)
alter table dbo.tUserMaster add			rkbattlecnt		bigint				default(0)
alter table dbo.tUserMaster add			rkbogicnt		bigint				default(0)
alter table dbo.tUserMaster add			rkfriendpoint	bigint				default(0)
alter table dbo.tUserMaster add			rkroulettecnt	bigint				default(0)
alter table dbo.tUserMaster add			rkwolfcnt		bigint				default(0)
alter table dbo.tUserMaster add			rktotal			bigint				default(0)
alter table dbo.tUserMaster add			rksalemoneybk	bigint				default(0)
alter table dbo.tUserMaster add			rksalebarrelbk	bigint				default(0)
alter table dbo.tUserMaster add			rkbattlecntbk	bigint				default(0)
alter table dbo.tUserMaster add			rkbogicntbk		bigint				default(0)
alter table dbo.tUserMaster add			rkfriendpointbk	bigint				default(0)
alter table dbo.tUserMaster add			rkroulettecntbk	bigint				default(0)
alter table dbo.tUserMaster add			rkwolfcntbk		bigint				default(0)
alter table dbo.tUserMaster add			rktotalbk		bigint				default(0)


update dbo.tUserMaster set
	rkstartstate	= 0,
	rkstartdate		= getdate() - 1,
	rkteam			= 1,

	rksalemoney		= 0,
	rksalebarrel	= 0,
	rkbattlecnt		= 0,
	rkbogicnt		= 0,
	rkfriendpoint	= 0,
	rkroulettecnt	= 0,
	rkwolfcnt		= 0,
	rktotal			= 0,

	rksalemoneybk	= 0,
	rksalebarrelbk	= 0,
	rkbattlecntbk	= 0,
	rkbogicntbk		= 0,
	rkfriendpointbk	= 0,
	rkroulettecntbk	= 0,
	rkwolfcntbk		= 0,
	rktotalbk		= 0



---------------------------------------------
--		랭킹대전기록(전체).
---------------------------------------------
IF OBJECT_ID (N'dbo.tRankDaJun', N'U') IS NOT NULL
	DROP TABLE dbo.tRankDaJun;
GO

create table dbo.tRankDaJun(
	idx			int 					IDENTITY(1, 1),

	--(날짜정보)
	rkdateid8		varchar(8),
	rkteam1			int					default(0),				-- 홀팀점수
	rkteam0			int					default(0),				-- 짝팀점수
	rkreward		int					default(0),				-- 미지급(0), 지급(1)

	-- 홀수.
	rksalemoney		bigint				default(0),				-- 판매수익(0).
	rksalebarrel	bigint				default(0),				-- 생산배럴(30).
	rkbattlecnt		bigint				default(0),				-- 배틀횟수(31).
	rkbogicnt		bigint				default(0),				-- 동물교배,보물뽑기(32).
	rkfriendpoint	bigint				default(0),				-- 친구포인트(자동수집).
	rkroulettecnt	bigint				default(0),				-- 룰렛횟수(20, 21).
	rkwolfcnt		bigint				default(0),				-- 늑대잡기(33).

	-- 짝수.
	rksalemoney2	bigint				default(0),				-- 판매수익(0).
	rksalebarrel2	bigint				default(0),				-- 생산배럴(30).
	rkbattlecnt2	bigint				default(0),				-- 배틀횟수(31).
	rkbogicnt2		bigint				default(0),				-- 동물교배,보물뽑기(32).
	rkfriendpoint2	bigint				default(0),				-- 친구포인트(자동수집).
	rkroulettecnt2	bigint				default(0),				-- 룰렛횟수(20, 21).
	rkwolfcnt2		bigint				default(0),				-- 늑대잡기(33).

	-- Constraint
	CONSTRAINT pk_tRankDaJun_rkdateid8	PRIMARY KEY(rkdateid8)
)
GO
*/

--select * from dbo.tRouletteLogPerson where kind = 4                                    and gameid = 'farm3967580'
--select * from dbo.tRouletteLogPerson where kind = 4 and writedate < '2016-05-10 12:30' and gameid = 'farm3967580'
--select gameid, count(*), sum(cashcost) from dbo.tRouletteLogPerson where kind = 4 and writedate < '2016-05-10 12:30' and gameid = 'farm3967580' group by gameid


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

	mainkind	int				default(1),		-- 1: 1인1매형, 2:공용형
	kind		int				default(1),		-- 제작요청한 회사번호.

	startdate	datetime		default(getdate()),
	enddate		datetime		default(getdate()),

	CONSTRAINT	pk_tEventCertNo_idx	PRIMARY KEY(idx)
)
-- 인증번호 인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tEventCertNo_certno')
    DROP INDEX tEventCertNo.idx_tEventCertNo_certno
GO
CREATE INDEX idx_tEventCertNo_certno ON tEventCertNo (certno)
GO


-- 1인형(1)
--insert into dbo.tEventCertNo(certno, itemcode1, cnt1, itemcode2, cnt2, itemcode3, cnt3, mainkind, kind, enddate       )
--values(                      'PERSON1',      1,    1,        -1,    0,        -1,    0,        1,    1, getdate() + 1 )
--insert into dbo.tEventCertNo(certno, itemcode1, cnt1, itemcode2, cnt2, itemcode3, cnt3, mainkind, kind, enddate       )
--values(                      'PERSON2',      1,    1,        -1,    0,        -1,    0,        1,    1, getdate() + 1 )

-- 공용형(2)
--insert into dbo.tEventCertNo(certno, itemcode1, cnt1, itemcode2, cnt2, itemcode3, cnt3, mainkind, kind, enddate       )
--values(                      'COMMON1',    900,  120,        -1,    0,        -1,    0,        2,    0, getdate() + 1 )
--insert into dbo.tEventCertNo(certno, itemcode1, cnt1, itemcode2, cnt2, itemcode3, cnt3, mainkind, kind, enddate       )
--values(                      'COMMON2',    900,  120,        -1,    0,        -1,    0,        2,    0, getdate() - 1 )
insert into dbo.tEventCertNo(certno, itemcode1, cnt1, itemcode2, cnt2, itemcode3, cnt3, mainkind, kind, enddate       )
values(                'ZAYOTYCOON',      5000,  300,      5100, 2000,        -1,    0,        2,    0, getdate() + 7 )


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
	cnt1		int				default(0),
	cnt2		int				default(0),
	cnt3		int				default(0),

	mainkind	int				default(1),		-- 1: 1인1매형, 2:공용형
	kind		int				default(1),		-- 제작요청한 회사번호.

	usedtime	datetime		default(getdate()),

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

*/


/*
alter table dbo.tUserMaster add		bkwheelcnt		int					default(0)
update dbo.tUserMaster set bkwheelcnt = 0
*/

/*
alter table dbo.tUserMaster add		tradestate		int					default(1)
update dbo.tUserMaster set tradestate = 1, wheelfree = 1
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


/*
select '전', * from dbo.tItemInfo where itemcode >= 3700 and itemcode <= 3705
delete from dbo.tItemInfo where itemcode >= 3700 and itemcode <= 3705

insert into dbo.tItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3)
values('userbattlebox', '3700', '37', '37', '0', '나무 박스', '0', '-1', '0', '0', 'rewardbox01', '0', '0', '0', '9999', '1', '1', '나무 박스', '2', '15', '3')
GO

insert into dbo.tItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3)
values('userbattlebox', '3701', '37', '37', '0', '실버 박스', '0', '-1', '0', '0', 'rewardbox02', '0', '0', '0', '9999', '1', '1', '실버 박스', '2', '7200', '46')
GO

insert into dbo.tItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3)
values('userbattlebox', '3702', '37', '37', '0', '골드 박스', '0', '-1', '0', '0', 'rewardbox03', '0', '0', '0', '9999', '1', '1', '골드 박스', '2', '18000', '111')
GO

insert into dbo.tItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3)
values('userbattlebox', '3703', '37', '37', '0', '자이언트 박스', '0', '-1', '0', '0', 'rewardbox04', '0', '0', '0', '9999', '1', '1', '자이언트 박스', '2', '28800', '176')
GO

insert into dbo.tItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3)
values('userbattlebox', '3704', '37', '37', '0', '마법 박스', '0', '-1', '0', '0', 'rewardbox05', '0', '0', '0', '9999', '1', '1', '마법 박스', '2', '43200', '262')
GO

insert into dbo.tItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3)
values('userbattlebox', '3705', '37', '37', '0', '슈퍼마법 박스', '0', '-1', '0', '0', 'rewardbox06', '0', '0', '0', '9999', '1', '1', '슈퍼마법 박스', '2', '86400', '522')
GO
select '후', * from dbo.tItemInfo where itemcode >= 3700 and itemcode <= 3705
*/

/*
---------------------------------------------
-- 생애결제로고.
---------------------------------------------
IF OBJECT_ID (N'dbo.tCashFirstTimeLog', N'U') IS NOT NULL
	DROP TABLE dbo.tCashFirstTimeLog;
GO

create table dbo.tCashFirstTimeLog(
	idx			int				identity(1, 1),

	gameid		varchar(20),
	itemcode	int,
	writedate	datetime		default(getdate()),

	CONSTRAINT	pk_tCashFirstTimeLog_idx	PRIMARY KEY(idx)
)

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tCashFirstTimeLog_gameid_itemcode')
    DROP INDEX tCashFirstTimeLog.idx_tCashFirstTimeLog_gameid_itemcode
GO
CREATE INDEX idx_tCashFirstTimeLog_gameid_itemcode ON tCashFirstTimeLog (gameid, itemcode)
GO



insert into dbo.tItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10)
values('cashcoin', '5050', '50', '50', '0', '[생애첫결제] 루비', '1', '-1', '0', '0', 'crystal01', '0', '0', '0', '3300', '310', '1', '[생애첫결제] 루비', '0', '0', '0', 'farm_3300', '3300', '299', '0', '0', '6', '1')
GO

insert into dbo.tItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10)
values('cashcoin', '5051', '50', '50', '0', '[생애첫결제] 루비 뭉치', '1', '-1', '0', '0', 'crystal02', '0', '0', '0', '5500', '550', '1', '[생애첫결제] 루비 뭉치', '0', '0', '0', 'farm_5500', '5500', '499', '0', '0', '5', '1')
GO

insert into dbo.tItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10)
values('cashcoin', '5052', '50', '50', '0', '[생애첫결제] 루비 주머니', '1', '-1', '0', '0', 'crystal03', '0', '0', '0', '11000', '1120', '1', '[생애첫결제] 루비 주머니', '0', '0', '0', 'farm_11000', '11000', '899', '0', '0', '4', '1')
GO

insert into dbo.tItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10)
values('cashcoin', '5053', '50', '50', '0', '[생애첫결제] 작은 루비', '1', '-1', '0', '0', 'crystal04', '0', '0', '0', '33000', '3450', '1', '[생애첫결제] 작은 루비', '0', '0', '0', 'farm_33000', '33000', '2999', '0', '0', '3', '1')
GO

insert into dbo.tItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10)
values('cashcoin', '5054', '50', '50', '0', '[생애첫결제] 큰 루비', '1', '-1', '0', '0', 'crystal05', '0', '0', '0', '55000', '5900', '1', '[생애첫결제] 큰 루비', '0', '0', '0', 'farm_55000', '55000', '4999', '0', '0', '2', '1')
GO

insert into dbo.tItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10)
values('cashcoin', '5055', '50', '50', '0', '[생애첫결제] 대형 루비', '1', '-1', '0', '0', 'crystal05', '0', '0', '0', '110000', '12500', '1', '[생애첫결제] 대형 루비', '0', '0', '0', 'farm_110000', '110000', '9999', '0', '0', '1', '1')
GO
*/


--delete from dbo.tEvnetUserGetLog where gameid = 'farm547688' and idx =


--select * from dbo.tTTTT where gameid = 'farm548802' order by idx desc
--update dbo.tUserBattleBank set kakaonickname = '귀요미양' where kakaonickname = '영선컴'
--select * from dbo.tUserBattleBank where kakaonickname = '귀요미양'

--select * from dbo.tUserBattleBank where kakaonickname = '영선컴'


/*
--exec spu_SetDirectItemNew 'xxxx2', 120525, 0, 3, -1
delete from dbo.tGiftList where gameid = 'xxxx2'
update dbo.tUserMaster set famelv = 1, concnt = concnt - 1, attenddate = attenddate - 1, tsskillgamecost = 100  where gameid = 'xxxx2'
exec spu_Login 'xxxx2', '049000s1i0n7t8445289', 5, 119, '', -1, -1			-- 정상유저

update dbo.tUserMaster set famelv = 11, concnt = concnt - 1, attenddate = attenddate - 1, tsskillgamecost = 100  where gameid = 'xxxx2'
exec spu_Login 'xxxx2', '049000s1i0n7t8445289', 5, 119, '', -1, -1			-- 정상유저

update dbo.tUserMaster set famelv = 21, concnt = concnt - 1, attenddate = attenddate - 1, tsskillgamecost = 100  where gameid = 'xxxx2'
exec spu_Login 'xxxx2', '049000s1i0n7t8445289', 5, 119, '', -1, -1			-- 정상유저

update dbo.tUserMaster set famelv = 31, concnt = concnt - 1, attenddate = attenddate - 1, tsskillgamecost = 100  where gameid = 'xxxx2'
exec spu_Login 'xxxx2', '049000s1i0n7t8445289', 5, 119, '', -1, -1			-- 정상유저

update dbo.tUserMaster set famelv = 41, concnt = concnt - 1, attenddate = attenddate - 1, tsskillgamecost = 100  where gameid = 'xxxx2'
exec spu_Login 'xxxx2', '049000s1i0n7t8445289', 5, 119, '', -1, -1			-- 정상유저

update dbo.tUserMaster set famelv = 51, concnt = concnt - 1, attenddate = attenddate - 1, tsskillgamecost = 100  where gameid = 'xxxx2'
exec spu_Login 'xxxx2', '049000s1i0n7t8445289', 5, 119, '', -1, -1			-- 정상유저

update dbo.tUserMaster set famelv = 61, concnt = concnt - 1, attenddate = attenddate - 1, tsskillgamecost = 100  where gameid = 'xxxx2'
exec spu_Login 'xxxx2', '049000s1i0n7t8445289', 5, 119, '', -1, -1			-- 정상유저

update dbo.tUserMaster set famelv = 70, concnt = concnt - 1, attenddate = attenddate - 1, tsskillgamecost = 100  where gameid = 'xxxx2'
exec spu_Login 'xxxx2', '049000s1i0n7t8445289', 5, 119, '', -1, -1			-- 정상유저
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
alter table dbo.tUserMaster add		tsskillbottlelittle	int				default(0)
update dbo.tUserMaster set tsskillbottlelittle = 0
*/
/*
 &gameid=farm166775
 &password=8848522x7r8n2k562487
 &userinfo=0:2023;1:12;2:0;4:4;10:0;11:0;12:20;13:3160;30:57;40:-1;41:-1;44:-1;45:-1;42:-1;43:3;
 &aniitem=1159:5,25,0;2009:5,25,0;1756:5,25,0;1820:5,25,0;1566:5,25,0;1045:5,25,0;1072:5,25,0;1130:5,25,0;836:5,25,0;16:2,15,0;40:5,25,0;674:5,25,0;540:5,25,0;678:5,25,0;1822:5,25,0;1757:5,25,0;1950:5,25,0;1946:5,25,0;1912:5,25,0;1924:5,25,0;1172:5,25,0;1043:5,25,0;1044:5,25,0;33:5,25,0;1926:5,25,0;1905:5,25,0;1948:5,25,0;1954:5,25,0;1956:5,25,0;1959:5,25,0;1902:5,25,0;1904:5,25,0;1960:5,25,0;1930:5,25,0;1939:5,25,0;1940:5,25,0;1936:5,25,0;1031:5,25,0;1012:5,25,0;1023:5,25,0;1028:5,25,0;768:5,25,0;772:5,25,0;738:5,25,0;753:5,25,0;1179:5,25,0;1183:5,25,0;1184:5,25,0;1193:5,25,0;1196:5,25,0;1198:5,25,0;754:5,25,0;724:5,25,0;1029:5,25,0;1027:5,25,0;28:5,0,0;31:5,0,0;32:5,0,0;58:5,31,0;1929:5,25,0;1949:5,25,0;1951:5,25,0;1901:5,25,0;1935:5,25,0;1927:5,25,0;2010:5,25,0;1895:5,25,0;1821:5,25,0;537:5,25,0;539:5,25,0;1131:5,25,0;1138:5,25,0;1075:5,25,0;1063:5,25,0;1160:5,25,0;1120:5,25,0;1121:5,25,0;1129:5,25,0;1144:5,25,0;1077:5,25,0;1014:5,25,0;1006:5,25,0;1007:5,25,0;1035:5,25,0;1036:5,25,0;1039:5,25,0;1040:5,25,0;726:5,25,0;728:5,25,0;740:5,25,0;689:5,25,0;693:5,25,0;697:5,25,0;702:5,25,0;705:5,25,0;713:5,25,0;721:5,25,0;59:5,25,0;48:5,25,0;29:5,25,0;34:5,25,0;38:5,25,0;1953:5,25,0;1957:5,25,0;1917:5,25,0;1910:5,25,0;1933:5,25,0;1937:5,25,0;1943:5,25,0;1944:5,25,0;1928:5,25,0;1947:5,25,0;1952:5,25,0;1958:5,25,0;1955:5,25,0;1915:5,25,0;1932:5,25,0;1921:5,25,0;27:5,25,0;701:5,25,0;764:5,25,0;765:5,25,0;766:5,25,0;817:5,25,0;1033:5,25,0;1168:5,25,0;1170:5,25,0;1171:5,25,0;1174:5,25,0;1176:5,25,0;1001:5,25,0;781:5,25,0;786:5,25,0;722:5,25,0;1190:5,25,0;1961:5,25,0;17:5,0,0;807:5,25,0;1141:5,25,0;1143:5,25,0;1823:5,25,0;1128:6,24,0;1898:5,25,0;1899:5,25,0;1931:5,25,0;1916:5,25,0;1913:5,25,0;1914:5,25,0;1906:5,25,0;1908:5,25,0;1909:5,25,0;1945:5,25,0;1941:5,25,0;1942:5,25,0;1177:5,25,0;1173:5,25,0;1189:5,25,0;1003:5,25,0;1008:5,25,0;1016:5,25,0;1923:5,25,0;1920:5,25,0;1896:5,25,0;1900:5,25,0;1911:5,25,0;1934:5,25,0;796:5,25,0;1938:5,25,0;1897:5,25,0;1907:5,25,0;698:3,24,0;62:3,30,0;709:2,0,0;1034:2,30,0;1181:2,26,0;720:2,9,0;690:2,29,0;775:3,35,0;67:2,7,0;2011:5,25,0;
 &cusitem=55:3;9:3;42:1;
 &tradeinfo=0:2445;1:38;10:237;11:39;12:0;20:23;30:19;31:112;61:1;62:1;63:22;70:1;33:17;34:168;35:1904;40:5113;50:0;51:14;52:93;
 &paraminfo=0:90133;1:0;2:0;3:0;4:202312;5:0;
*/

/*
-- 일반결과
--update dbo.tUserMaster set gameyear = 2023, gamemonth = 12, frametime = 0 where gameid = 'farm166775'
--delete from dbo.tUserSaleLog where gameid = 'farm166775' and gameyear = 2023 and gamemonth = 12
exec spu_GameTrade 'farm166775', '8848522x7r8n2k562487',
'0:2023;1:12;2:0;4:4;10:0;11:0;12:20;13:3160;30:57;40:-1;41:-1;44:-1;45:-1;42:-1;43:3;',
'1159:5,25,0;2009:5,25,0;1756:5,25,0;1820:5,25,0;1566:5,25,0;1045:5,25,0;1072:5,25,0;1130:5,25,0;836:5,25,0;16:2,15,0;40:5,25,0;674:5,25,0;540:5,25,0;678:5,25,0;1822:5,25,0;1757:5,25,0;1950:5,25,0;1946:5,25,0;1912:5,25,0;1924:5,25,0;1172:5,25,0;1043:5,25,0;1044:5,25,0;33:5,25,0;1926:5,25,0;1905:5,25,0;1948:5,25,0;1954:5,25,0;1956:5,25,0;1959:5,25,0;1902:5,25,0;1904:5,25,0;1960:5,25,0;1930:5,25,0;1939:5,25,0;1940:5,25,0;1936:5,25,0;1031:5,25,0;1012:5,25,0;1023:5,25,0;1028:5,25,0;768:5,25,0;772:5,25,0;738:5,25,0;753:5,25,0;1179:5,25,0;1183:5,25,0;1184:5,25,0;1193:5,25,0;1196:5,25,0;1198:5,25,0;754:5,25,0;724:5,25,0;1029:5,25,0;1027:5,25,0;28:5,0,0;31:5,0,0;32:5,0,0;58:5,31,0;1929:5,25,0;1949:5,25,0;1951:5,25,0;1901:5,25,0;1935:5,25,0;1927:5,25,0;2010:5,25,0;1895:5,25,0;1821:5,25,0;537:5,25,0;539:5,25,0;1131:5,25,0;1138:5,25,0;1075:5,25,0;1063:5,25,0;1160:5,25,0;1120:5,25,0;1121:5,25,0;1129:5,25,0;1144:5,25,0;1077:5,25,0;1014:5,25,0;1006:5,25,0;1007:5,25,0;1035:5,25,0;1036:5,25,0;1039:5,25,0;1040:5,25,0;726:5,25,0;728:5,25,0;740:5,25,0;689:5,25,0;693:5,25,0;697:5,25,0;702:5,25,0;705:5,25,0;713:5,25,0;721:5,25,0;59:5,25,0;48:5,25,0;29:5,25,0;34:5,25,0;38:5,25,0;1953:5,25,0;1957:5,25,0;1917:5,25,0;1910:5,25,0;1933:5,25,0;1937:5,25,0;1943:5,25,0;1944:5,25,0;1928:5,25,0;1947:5,25,0;1952:5,25,0;1958:5,25,0;1955:5,25,0;1915:5,25,0;1932:5,25,0;1921:5,25,0;27:5,25,0;701:5,25,0;764:5,25,0;765:5,25,0;766:5,25,0;817:5,25,0;1033:5,25,0;1168:5,25,0;1170:5,25,0;1171:5,25,0;1174:5,25,0;1176:5,25,0;1001:5,25,0;781:5,25,0;786:5,25,0;722:5,25,0;1190:5,25,0;1961:5,25,0;17:5,0,0;807:5,25,0;1141:5,25,0;1143:5,25,0;1823:5,25,0;1128:6,24,0;1898:5,25,0;1899:5,25,0;1931:5,25,0;1916:5,25,0;1913:5,25,0;1914:5,25,0;1906:5,25,0;1908:5,25,0;1909:5,25,0;1945:5,25,0;1941:5,25,0;1942:5,25,0;1177:5,25,0;1173:5,25,0;1189:5,25,0;1003:5,25,0;1008:5,25,0;1016:5,25,0;1923:5,25,0;1920:5,25,0;1896:5,25,0;1900:5,25,0;1911:5,25,0;1934:5,25,0;796:5,25,0;1938:5,25,0;1897:5,25,0;1907:5,25,0;698:3,24,0;62:3,30,0;709:2,0,0;1034:2,30,0;1181:2,26,0;720:2,9,0;690:2,29,0;775:3,35,0;67:2,7,0;2011:5,25,0;',
													'55:3;9:3;42:1;',
													'0:2445;1:38;10:237;11:39;12:0;20:23;30:19;31:112;61:1;62:1;63:22;70:1;33:17;34:168;35:1904;40:5113;50:0;51:14;52:93;',
													'0:90133;1:0;2:0;3:0;4:202312;5:0;',
													-1										-- 필드없음.

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

select * from Farm.dbo.tUserPushAndroid
select * from Farm.dbo.tUserPushiPhone
select * from Farm.dbo.tFVUserPushAndroid
select * from Farm.dbo.tFVUserPushiPhone

-- delete from Farm.dbo.tUserPushAndroid
-- delete from Farm.dbo.tUserPushiPhone
-- delete from Farm.dbo.tFVUserPushAndroid
-- delete from Farm.dbo.tFVUserPushiPhone
--select count(*) from Farm.dbo.tUserMaster		--> 939083
*/

/*
---------------------------------------------
--	Push Send Info
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserPushSendInfo', N'U') IS NOT NULL
	DROP TABLE dbo.tUserPushSendInfo;
GO

create table dbo.tUserPushSendInfo(
	idx				int				identity(1, 1),

	adminid			varchar(20),
	sendkind		int,
	market			int,

	msgtitle		varchar(512),
	msgmsg			varchar(512),
	msgurl			varchar(512)	default(''),

	cnt				int				default(0),
	writedate		datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tUserPushSendInfo_idx	PRIMARY KEY(idx)
)
*/


/*
---------------------------------------------
--	PushBlackList
---------------------------------------------
IF OBJECT_ID (N'dbo.tPushBlackList', N'U') IS NOT NULL
	DROP TABLE dbo.tPushBlackList;
GO

create table dbo.tPushBlackList(
	idx				int				identity(1, 1),

	phone			varchar(20),
	comment			varchar(512),
	writedate		datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tPushBlackList_idx	PRIMARY KEY(idx)
)
insert into dbo.tPushBlackList(phone, comment) select phone, comment from Farm.dbo.tFVPushBlackList where phone not in ( select phone from dbo.tPushBlackList )
insert into dbo.tPushBlackList(phone, comment) select phone, comment from Game4FarmVill4.dbo.tFVPushBlackList where phone not in ( select phone from dbo.tPushBlackList )
--insert into dbo.tPushBlackList(phone, comment) values('01036630157', '김세훈대표')
--insert into dbo.tPushBlackList(phone, comment) values('01055841110', '이대성 과장')
--insert into dbo.tPushBlackList(phone, comment) values('01051955895', '이정우')
--insert into dbo.tPushBlackList(phone, comment) values('01043358319', '김남훈')
--insert into dbo.tPushBlackList(phone, comment) values('01089114806', '김용민')
--insert into dbo.tPushBlackList(phone, comment) values('0183302149', '채문기')
--insert into dbo.tPushBlackList(phone, comment) values('01050457694', '이영지')
--insert into dbo.tPushBlackList(phone, comment) values('01048742835', '윤인좌 대리')
--insert into dbo.tPushBlackList(phone, comment) values('01024065144', '운영 김범수')
--insert into dbo.tPushBlackList(phone, comment) values('01027624701', '서버 김선일')
--insert into dbo.tPushBlackList(phone, comment) values('01090196756', '픽토_호스팅업체')
*/





/*
delete from dbo.tUserSaleLog where gameid = 'farm165957'
delete from dbo.tGiftList where gameid = 'farm165957'
delete from dbo.tEpiReward where gameid = 'farm165957'
exec spu_GameTrade 'farm165957',
					'1845858w6i6h1z854238',
					'0:2016;1:8;2:0;4:4;10:0;11:0;12:27;13:10692;30:18;40:-1;41:-1;44:-1;45:-1;42:-1;43:1;',
					'22:5,25,0;23:5,25,0;0:7,5,0;1:8,7,0;2:5,25,0;3:6,4,0;24:5,25,0;25:5,25,0;26:5,25,0;27:5,25,0;28:5,25,0;29:5,25,0;30:5,25,0;31:5,25,0;32:5,25,0;33:5,25,0;34:5,25,0;35:5,25,0;36:5,25,0;37:5,25,0;38:5,25,0;39:5,25,0;40:5,25,0;41:5,25,0;42:5,25,0;43:5,25,0;44:5,25,0;45:5,25,0;46:5,25,0;47:5,25,0;48:5,25,0;49:5,25,0;50:5,25,0;51:5,25,0;52:5,25,0;53:5,25,0;54:5,25,0;55:5,25,0;56:5,25,0;57:5,25,0;58:5,25,0;59:5,25,0;60:5,25,0;61:5,25,0;62:5,25,0;63:5,25,0;64:5,25,0;65:5,25,0;66:5,25,0;67:5,25,0;68:5,25,0;69:5,25,0;70:5,25,0;71:5,25,0;72:5,25,0;73:5,25,0;74:5,25,0;75:5,14,0;76:5,25,0;77:5,25,0;78:5,25,0;79:5,25,0;80:5,25,0;81:5,25,0;82:5,25,0;83:5,25,0;84:5,25,0;85:5,25,0;86:5,25,0;87:5,25,0;88:5,25,0;89:5,25,0;90:5,25,0;91:5,25,0;92:5,25,0;93:5,25,0;94:5,25,0;95:5,25,0;96:5,25,0;97:5,25,0;98:5,25,0;99:5,25,0;100:5,25,0;101:5,25,0;102:5,25,0;103:5,25,0;104:5,25,0;105:5,25,0;106:5,25,0;107:5,25,0;108:5,25,0;109:5,25,0;110:5,25,0;111:5,25,0;112:5,25,0;113:5,25,0;114:5,25,0;115:5,25,0;116:5,25,0;117:5,25,0;118:5,25,0;119:5,25,0;120:5,25,0;121:5,25,0;122:5,25,0;123:5,25,0;124:5,25,0;125:5,25,0;126:5,25,0;127:5,25,0;128:5,25,0;129:5,25,0;130:5,25,0;131:5,25,0;132:5,25,0;133:5,25,0;134:5,25,0;135:5,25,0;136:5,25,0;137:5,25,0;138:5,25,0;139:5,25,0;140:5,25,0;141:5,25,0;142:4,37,0;143:5,25,0;144:4,18,0;145:5,25,0;146:5,25,0;147:5,25,0;148:5,25,0;149:5,25,0;150:5,25,0;151:5,25,0;152:5,25,0;153:5,25,0;154:5,25,0;155:5,25,0;156:5,25,0;157:5,25,0;158:3,32,0;159:5,25,0;160:5,25,0;161:5,25,0;163:5,25,0;164:5,25,0;165:5,25,0;166:5,25,0;167:5,25,0;168:5,25,0;169:5,25,0;170:5,25,0;171:5,25,0;172:5,25,0;173:5,25,0;174:5,25,0;175:5,25,0;176:5,25,0;177:5,25,0;178:5,25,0;179:5,25,0;180:5,25,0;181:5,25,0;182:5,25,0;183:5,25,0;184:5,25,0;185:5,25,0;186:5,25,0;187:5,25,0;188:5,25,0;189:5,25,0;190:5,25,0;191:5,25,0;192:5,25,0;193:5,25,0;194:5,25,0;195:5,25,0;196:5,25,0;197:5,25,0;198:5,25,0;199:5,25,0;200:5,25,0;201:5,25,0;202:5,25,0;203:4,23,0;204:5,25,0;205:5,25,0;206:5,25,0;207:5,25,0;208:5,25,0;209:5,25,0;210:5,25,0;211:5,25,0;212:5,25,0;213:5,25,0;214:5,25,0;215:5,25,0;216:5,25,0;217:5,25,0;218:5,25,0;219:5,25,0;220:3,10,0;221:5,25,0;222:5,25,0;223:5,25,0;224:5,25,0;225:5,25,0;226:5,25,0;228:5,25,0;229:5,25,0;231:5,25,0;232:5,25,0;233:5,25,0;235:5,25,0;234:3,10,0;230:3,11,0;227:3,3,0;162:3,19,0;15:2,13,0;',
					'432:2;9:3;17:3;',
					'0:2030;1:32;10:5;11:0;12:0;20:6;30:0;31:161;61:1;62:1;63:1;70:1;33:14;34:408;35:2254;40:5119;50:0;51:1;52:1;',
					'0:90108;1:0;2:0;3:0;4:201306;5:0;',
					-1										-- 필드없음.


exec spu_GameSave 'farm165957',
				'1845858w6i6h1z854238',
				'0:2016;1:8;2:12;4:4;10:0;11:0;12:100;13:38590;30:7;40:1103;41:1002;44:1002;45:1002;42:-1;43:1;',
				'22:5,25,0;23:5,25,0;0:7,5,0;1:8,7,0;2:5,25,0;3:6,4,0;24:5,25,0;25:5,25,0;26:5,25,0;27:5,25,0;28:5,25,0;29:5,25,0;30:5,25,0;31:5,25,0;32:5,25,0;33:5,25,0;34:5,25,0;35:5,25,0;36:5,25,0;37:5,25,0;38:5,25,0;39:5,25,0;40:5,25,0;41:5,25,0;42:5,25,0;43:5,25,0;44:5,25,0;45:5,25,0;46:5,25,0;47:5,25,0;48:5,25,0;49:5,25,0;50:5,25,0;51:5,25,0;52:5,25,0;53:5,25,0;54:5,25,0;55:5,25,0;56:5,25,0;57:5,25,0;58:5,25,0;59:5,25,0;60:5,25,0;61:5,25,0;62:5,25,0;63:5,25,0;64:5,25,0;65:5,25,0;66:5,25,0;67:5,25,0;68:5,25,0;69:5,25,0;70:5,25,0;71:5,25,0;72:5,25,0;73:5,25,0;74:5,25,0;75:6,3,0;76:5,25,0;77:5,25,0;78:5,25,0;79:5,25,0;80:5,25,0;81:5,25,0;82:5,25,0;83:5,25,0;84:5,25,0;85:5,25,0;86:5,25,0;87:5,25,0;88:5,25,0;89:5,25,0;90:5,25,0;91:5,25,0;92:5,25,0;93:5,25,0;94:5,25,0;95:5,25,0;96:5,25,0;97:5,25,0;98:5,25,0;99:5,25,0;100:5,25,0;101:5,25,0;102:5,25,0;103:5,25,0;104:5,25,0;105:5,25,0;106:5,25,0;107:5,25,0;108:5,25,0;109:5,25,0;110:5,25,0;111:5,25,0;112:5,25,0;113:5,25,0;114:5,25,0;115:5,25,0;116:5,25,0;117:5,25,0;118:5,25,0;119:5,25,0;120:5,25,0;121:5,25,0;122:5,25,0;123:5,25,0;124:5,25,0;125:5,25,0;126:5,25,0;127:5,25,0;128:5,25,0;129:5,25,0;130:5,25,0;131:5,25,0;132:5,25,0;133:5,25,0;134:5,25,0;135:5,25,0;136:5,25,0;137:5,25,0;138:5,25,0;139:5,25,0;140:5,25,0;141:5,25,0;142:4,37,0;143:5,25,0;144:6,7,0;145:5,25,0;146:5,25,0;147:5,25,0;148:5,25,0;149:5,25,0;150:5,25,0;151:5,25,0;152:5,25,0;153:5,25,0;154:5,25,0;155:5,25,0;156:5,25,0;157:5,25,0;158:6,21,0;159:5,25,0;160:5,25,0;161:5,25,0;163:5,25,0;164:5,25,0;165:5,25,0;166:5,25,0;167:5,25,0;168:5,25,0;169:5,25,0;170:5,25,0;171:5,25,0;172:5,25,0;173:5,25,0;174:5,25,0;175:5,25,0;176:5,25,0;177:5,25,0;178:5,25,0;179:5,25,0;180:5,25,0;181:5,25,0;182:5,25,0;183:5,25,0;184:5,25,0;185:5,25,0;186:5,25,0;187:5,25,0;188:5,25,0;189:5,25,0;190:5,25,0;191:5,25,0;192:5,25,0;193:5,25,0;194:5,25,0;195:5,25,0;196:5,25,0;197:5,25,0;198:5,25,0;199:5,25,0;200:5,25,0;201:5,25,0;202:5,25,0;203:6,12,0;204:5,25,0;205:5,25,0;206:5,25,0;207:5,25,0;208:5,25,0;209:5,25,0;210:5,25,0;211:5,25,0;212:5,25,0;213:5,25,0;214:5,25,0;215:5,25,0;216:5,25,0;217:5,25,0;218:5,25,0;219:5,25,0;220:6,0,0;221:5,25,0;222:5,25,0;223:5,25,0;224:5,25,0;225:5,25,0;226:5,25,0;228:5,25,0;229:5,25,0;231:5,25,0;232:5,25,0;233:5,25,0;235:5,25,0;234:5,0,0;230:6,2,0;227:5,43,0;162:6,7,0;15:2,13,0;',
				'432:2;9:3;17:1;',
				'0:90108;1:0;2:0;3:0;4:201306;5:0;',
				-1										-- 필드없음.
*/

/*
alter table dbo.tUserMaster add		kakaogameid			varchar(60)		default('')
update dbo.tUserMaster set kakaogameid = gameid


-- 카카오게임아이디 인덱싱.
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserMaster_kakaogameid')
   DROP INDEX tUserMaster.idx_tUserMaster_kakaogameid
GO
CREATE INDEX idx_tUserMaster_kakaogameid ON tUserMaster (kakaogameid)
GO
*/

/*
---------------------------------------------
--		유저배틀 검색로고
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserBattleSearchLog', N'U') IS NOT NULL
	DROP TABLE dbo.tUserBattleSearchLog;
GO

create table dbo.tUserBattleSearchLog(
	--(일반정보)
	idx			int 					IDENTITY(1, 1),
	idx2		int,

	gameid		varchar(20),
	othergameid	varchar(20),
	writedate	smalldatetime			default(getdate()),

	-- Constraint
	CONSTRAINT pk_tUserBattleSearchLog_idx	PRIMARY KEY(idx)
)
GO

-- 인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserBattleSearchLog_gameid_idx2_othergameid')
    DROP INDEX tUserBattleSearchLog.idx_tUserBattleSearchLog_gameid_idx2_othergameid
GO
CREATE INDEX idx_tUserBattleSearchLog_gameid_idx2_othergameid ON tUserBattleSearchLog (gameid, othergameid, idx2)
GO
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

update dbo.tUserMaster set gamecost = 10000000, cashcost = 10000 where gameid = 'xxxx2'
exec spu_FacUpgradeTest 'xxxx2', '049000s1i0n7t8445289', 61, 1, -1		-- 탱크		(시작).
exec spu_FacUpgradeTest 'xxxx2', '049000s1i0n7t8445289', 61, 2, -1		--			(즉시완료)

update dbo.tUserMaster set gamecost = 10000000, cashcost = 10000 where gameid = 'xxxx2'
exec spu_FacUpgradeTest 'xxxx2', '049000s1i0n7t8445289', 62, 1, -1		-- 저온보관	(시작).
exec spu_FacUpgradeTest 'xxxx2', '049000s1i0n7t8445289', 62, 2, -1		--			(즉시완료)

update dbo.tUserMaster set gamecost = 10000000, cashcost = 10000 where gameid = 'xxxx2'
exec spu_FacUpgradeTest 'xxxx2', '049000s1i0n7t8445289', 63, 1, -1		-- 정화시설	(시작).
exec spu_FacUpgradeTest 'xxxx2', '049000s1i0n7t8445289', 63, 2, -1		--			(즉시완료)

update dbo.tUserMaster set gamecost = 10000000, cashcost = 10000 where gameid = 'xxxx2'
exec spu_FacUpgradeTest 'xxxx2', '049000s1i0n7t8445289', 64, 1, -1		-- 양동이	(시작).
exec spu_FacUpgradeTest 'xxxx2', '049000s1i0n7t8445289', 64, 2, -1		--			(즉시완료)

update dbo.tUserMaster set gamecost = 10000000, cashcost = 10000 where gameid = 'xxxx2'
exec spu_FacUpgradeTest 'xxxx2', '049000s1i0n7t8445289', 65, 1, -1		-- 착유기	(시작).
exec spu_FacUpgradeTest 'xxxx2', '049000s1i0n7t8445289', 65, 2, -1		--			(즉시완료)

update dbo.tUserMaster set gamecost = 10000000, cashcost = 10000 where gameid = 'xxxx2'
exec spu_FacUpgradeTest 'xxxx2', '049000s1i0n7t8445289', 66, 1, -1		-- 주입기	(시작).
exec spu_FacUpgradeTest 'xxxx2', '049000s1i0n7t8445289', 66, 2, -1		--			(즉시완료)

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
update dbo.tUserMaster
set
invenanimalbase = 50, invencustombase	= 15,
invenaccbase	= 6,
invenstemcellbase	= 50,
inventreasurebase	= 50

select invenanimalbase, invencustombase, invenaccbase, invenstemcellbase, inventreasurebase from dbo.tUserMaster order by idx desc
*/

/*


declare @tier int

set @tier = 1
select @tier, Convert(int, ceiling(RAND() * @tier))

set @tier = 2
select @tier, Convert(int, ceiling(RAND() * @tier))

set @tier = 3
select @tier, Convert(int, ceiling(RAND() * @tier))

set @tier = 4
select @tier, Convert(int, ceiling(RAND() * @tier))

set @tier = 5
select @tier, Convert(int, ceiling(RAND() * @tier))

set @tier = 6
select @tier, Convert(int, ceiling(RAND() * @tier))

set @tier = 7
select @tier, Convert(int, ceiling(RAND() * @tier))

set @tier = 8
select @tier, Convert(int, ceiling(RAND() * @tier))

*/


/*
---------------------------------------------
--		이벤트 받아간 유저로그
---------------------------------------------
IF OBJECT_ID (N'dbo.tEvnetUserGetLog', N'U') IS NOT NULL
	DROP TABLE dbo.tEvnetUserGetLog;
GO

create table dbo.tEvnetUserGetLog(
	idx				int					IDENTITY(1,1),

	gameid			varchar(20),
	eventidx		int,
	eventitemcode	int,
	eventcnt		int,
	writedate		datetime			default(getdate()),
	CONSTRAINT	pk_tEvnetUserGetLog_eventidx	PRIMARY KEY(idx)
)

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tEvnetUserGetLog_gameid_eventidx')
    DROP INDEX tEvnetUserGetLog.idx_tEvnetUserGetLog_gameid_eventidx
GO
CREATE INDEX idx_tEvnetUserGetLog_gameid_eventidx ON tEvnetUserGetLog (gameid, eventidx)
GO
*/


/*
---------------------------------------------
--		이벤트 마스터
---------------------------------------------
IF OBJECT_ID (N'dbo.tEventMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tEventMaster;
GO

create table dbo.tEventMaster(
	idx						int					IDENTITY(1,1),
	eventstatemaster		int					default(0),		-- 0:대기중, 1:진행중, 2:완료중

	-- Constraint
	CONSTRAINT	pk_tEventMaster_eventstatemaster	PRIMARY KEY(eventstatemaster)
)
-- 처음 데이타는 넣어줘야한다.
insert into dbo.tEventMaster(eventstatemaster) values(0)
-- update dbo.tEventMaster set eventstatemaster = case when eventstatemaster = 0 then 1 else 0 end where idx = 1
-- select eventstatemaster from dbo.tEventMaster where idx = 1

---------------------------------------------
--		이벤트 서브
---------------------------------------------
IF OBJECT_ID (N'dbo.tEventSub', N'U') IS NOT NULL
	DROP TABLE dbo.tEventSub;
GO

create table dbo.tEventSub(
	eventidx		int					IDENTITY(1,1),
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
*/


/*
---------------------------------------------
--	유저배틀랭킹백엄(Master)
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserBattleRankMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tUserBattleRankMaster;
GO

create table dbo.tUserBattleRankMaster(
	idx				int					identity(1, 1),

	dateid			varchar(8),										-- 20121118
	step			int					default(0),
	writedate		datetime			default(getdate()), 		-- 작성일

	-- Constraint
	CONSTRAINT pk_tUserBattleRankMaster_dateid	PRIMARY KEY(dateid)
)
GO
-- select * from dbo.tUserBattleRankMaster where dateid = '20150216'

---------------------------------------------
--		유저배틀랭킹백엄(Sub)
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserBattleRankSub', N'U') IS NOT NULL
	DROP TABLE dbo.tUserBattleRankSub;
GO

create table dbo.tUserBattleRankSub(
	idx				int 					IDENTITY(1, 1),			-- indexing

	dateid8			varchar(8),
	rank			int,
	anirepitemcode	int						default(1),
	trophy			int						default(0),
	tier			int						default(0),
	gameid			varchar(20),
	kakaonickname	varchar(20)				default(''),

	-- Constraint
	CONSTRAINT pk_tUserBattleRankSub_idx	PRIMARY KEY(idx)		-- 동점때문에 dateid, rank를 못잡는다.
)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserBattleRankSub_dateid8_rank')
    DROP INDEX tUserBattleRankSub.idx_tUserBattleRankSub_dateid8_rank
GO
CREATE INDEX idx_tUserBattleRankSub_dateid8_rank ON tUserBattleRankSub (dateid8, rank)
GO
*/


/*
---------------------------------------------
--	유저랭킹백엄(Master)
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserRankMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tUserRankMaster;
GO

create table dbo.tUserRankMaster(
	idx				int					identity(1, 1),

	dateid			varchar(8),										-- 20121118
	step			int					default(0),
	writedate		datetime			default(getdate()), 		-- 작성일

	-- Constraint
	CONSTRAINT pk_tUserRankMaster_dateid	PRIMARY KEY(dateid)
)
GO
-- select * from dbo.tUserRankMaster where dateid = '20150216'

---------------------------------------------
--		유저랭킹백엄(Sub)
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserRankSub', N'U') IS NOT NULL
	DROP TABLE dbo.tUserRankSub;
GO

create table dbo.tUserRankSub(
	idx				int 					IDENTITY(1, 1),			-- indexing

	dateid8			varchar(8),
	rank			int,
	anirepitemcode	int						default(1),
	ttsalecoin		int						default(0),
	gameid			varchar(20),
	kakaonickname	varchar(20)				default(''),

	-- Constraint
	CONSTRAINT pk_tUserRankSub_idx	PRIMARY KEY(idx)		-- 동점때문에 dateid, rank를 못잡는다.
)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserRankSub_dateid8_rank')
    DROP INDEX tUserRankSub.idx_tUserRankSub_dateid8_rank
GO
CREATE INDEX idx_tUserRankSub_dateid8_rank ON tUserRankSub (dateid8, rank)
GO
*/




/*
delete from dbo.tGiftList where gameid in ('xxxx2')
delete from dbo.tUserItem where gameid in ('xxxx2')
update dbo.tUserMaster set cashcost = 0, gamecost = 15000, heart = 40, randserial = -1 where gameid = 'xxxx2'
exec spu_SetDirectItemNew 'xxxx2',   3600, 60, 3, -1	-- 긴급요청티켓
insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow, upstepmax) values('xxxx2', 31, 104, 1, 0, -1, 1, 5, 24)
insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow, upstepmax) values('xxxx2', 32, 104, 1, 0, -1, 1, 5, 24)
insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow, upstepmax) values('xxxx2', 33, 104, 1, 0, -1, 1, 5, 32)
update dbo.tUserItem set upcnt = upstepmax, freshstem100 = 1, attstem100 = 2, timestem100 = 3, defstem100 = 4, hpstem100 = 5 where gameid in ('xxxx2') and invenkind = 1

exec spu_AniPromote 'xxxx2', '049000s1i0n7t8445289', 102022, 31, 32, 33, -1, -1, 999992, -1	-- 3마리
*/



/*
---------------------------------------------
--		유저배틀 검색로고
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserBattleSearchLog', N'U') IS NOT NULL
	DROP TABLE dbo.tUserBattleSearchLog;
GO

create table dbo.tUserBattleSearchLog(
	--(일반정보)
	idx			int 					IDENTITY(1, 1),
	idx2		int,

	gameid		varchar(20),
	othergameid	varchar(20),
	writedate	smalldatetime			default(getdate()),

	-- Constraint
	CONSTRAINT pk_tUserBattleSearchLog_idx	PRIMARY KEY(idx)
)
GO

-- 인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserBattleSearchLog_gameid_idx2_othergameid')
    DROP INDEX tUserBattleSearchLog.idx_tUserBattleSearchLog_gameid_idx2_othergameid
GO
CREATE INDEX idx_tUserBattleSearchLog_gameid_idx2_othergameid ON tUserBattleSearchLog (gameid, othergameid, idx2)
GO

*/




/*
alter table dbo.tUserMaster add		userbattleresult		int			default(0)
alter table dbo.tUserMaster add		userbattlepoint			int			default(0)
update dbo.tUserMaster set userbattleresult = 0, userbattlepoint = 0
*/

/*
alter table dbo.tUserBattleBank add		userdata		int					default(1)
update tUserBattleBank set userdata = 1
*/

/*
alter table dbo.tUserBattleLog add		trophy			int					default(0)
alter table dbo.tUserBattleLog add		tier			int					default(1)
update dbo.tUserBattleLog set trophy = 0, tier = 1
*/

/*
alter table dbo.tUserMaster add		tier				int				default(1)

*/
/*
select dbo.fnu_GetDatePart('s', '2016-03-25 12:00:00', '2016-03-25 11:59:00')
select dbo.fnu_GetDatePart('s', '2016-03-25 12:00:00', '2016-03-25 12:09:00')
select dbo.fnu_GetDatePart('s', '2016-03-25 12:00:00', '2016-03-25 12:10:01')
select dbo.fnu_GetDatePart('s', '2016-03-25 12:00:00', '2016-03-25 12:11:00')
select 590/600, 600/600, 601/600
*/
/*
update dbo.tUserMaster set boxslot1 = 3700, boxslot2 = 3701, boxslot3 = 3702, boxslot4 = 3703, boxslotidx = -1, boxslottime = getdate() where gameid = 'xxxx2'
*/

/*
--select * from dbo.tUserItem where gameid = 'xxxx2'
select * from dbo.tItemInfo where category in (39)
select * from dbo.tItemInfo where subcategory in (39)
select * from dbo.tItemInfo where itemcode in ( 3900 )

select category, subcategory from dbo.tItemInfo group by category, subcategory order by 1 asc
*/


/*
---------------------------------------------
--		유저배틀 뱅크 데이타.
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserBattleBank', N'U') IS NOT NULL
	DROP TABLE dbo.tUserBattleBank;
GO

create table dbo.tUserBattleBank(
	--(일반정보)
	idx			int 					IDENTITY(1, 1),
	idx2		int,

	gameid			varchar(20),
	kakaonickname	varchar(40)			default(''),
	trophy			int					default(0),
	tier			int					default(0),

	aniitemcode1	int					default(-1),
	upcnt1			int					default(0),
	attstem1		int					default(0),
	defstem1		int					default(0),
	hpstem1			int					default(0),
	timestem1		int					default(0),

	aniitemcode2	int					default(-1),
	upcnt2			int					default(0),
	attstem2		int					default(0),
	defstem2		int					default(0),
	hpstem2			int					default(0),
	timestem2		int					default(0),

	aniitemcode3	int					default(-1),
	upcnt3			int					default(0),
	attstem3		int					default(0),
	defstem3		int					default(0),
	hpstem3			int					default(0),
	timestem3		int					default(0),

	treasure1		int					default(-1),
	treasure2		int					default(-1),
	treasure3		int					default(-1),
	treasure4		int					default(-1),
	treasure5		int					default(-1),
	treasureupgrade1	int				default(0),
	treasureupgrade2	int				default(0),
	treasureupgrade3	int				default(0),
	treasureupgrade4	int				default(0),
	treasureupgrade5	int				default(0),

	writedate		datetime			default(getdate()),

	-- Constraint
	CONSTRAINT pk_tUserBattleBank_idx	PRIMARY KEY(idx)
)
GO
-- 인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserBattleBank_gameid_tier_idx2')
    DROP INDEX tUserBattleBank.idx_tUserBattleBank_gameid_tier_idx2
GO
CREATE INDEX idx_tUserBattleBank_gameid_tier_idx2 ON tUserBattleBank (gameid, tier, idx2)
GO

-- 인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tBattleLog_gameid_trophy')
    DROP INDEX tBattleLog.idx_tBattleLog_gameid_trophy
GO
CREATE INDEX idx_tBattleLog_gameid_trophy ON tUserBattleBank (gameid, trophy)
GO





---------------------------------------------
--		유저배틀 로고
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserBattleLog', N'U') IS NOT NULL
	DROP TABLE dbo.tUserBattleLog;
GO

create table dbo.tUserBattleLog(
	idx				int 					IDENTITY(1, 1),
	idx2			int,

	gameid			varchar(20),
	otherid			varchar(20),
	kakaonickname	varchar(40)			default(''),

	myanidesc1		varchar(120)		default(''),
	myanidesc2		varchar(120)		default(''),
	myanidesc3		varchar(120)		default(''),

	myts1name		varchar(40)			default(''),
	myts2name		varchar(40)			default(''),
	myts3name		varchar(40)			default(''),
	myts4name		varchar(40)			default(''),
	myts5name		varchar(40)			default(''),

	othanidesc1		varchar(120)		default(''),
	othanidesc2		varchar(120)		default(''),
	othanidesc3		varchar(120)		default(''),

	othts1name		varchar(40)			default(''),
	othts2name		varchar(40)			default(''),
	othts3name		varchar(40)			default(''),
	othts4name		varchar(40)			default(''),
	othts5name		varchar(40)			default(''),

	writedate		datetime			default(getdate()),
	result			int					default(0),		--  1   BATTLE_RESULT_WIN
														-- -1  	BATTLE_RESULT_LOSE
														--  0   BATTLE_RESULT_DRAW

	gettrophy		int					default(0),
	playtime		int					default(0),
	rewardbox		int					default(0),

	-- Constraint
	CONSTRAINT pk_tUserBattleLog_idx	PRIMARY KEY(idx)
)
GO
-- 인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserBattleLog_gameid_idx2')
    DROP INDEX tUserBattleLog.idx_tUserBattleLog_gameid_idx2
GO
CREATE INDEX idx_tUserBattleLog_gameid_idx2 ON tUserBattleLog (gameid, idx2)
GO
*/



/*
alter table dbo.tUserMaster add	userbattleanilistidx1	int				default(-1)
alter table dbo.tUserMaster add	userbattleanilistidx2	int				default(-1)
alter table dbo.tUserMaster add	userbattleanilistidx3	int				default(-1)
alter table dbo.tUserMaster add	userbattleflag			int				default(0)


alter table dbo.tUserMaster add		trophy				int				default(0)
alter table dbo.tUserMaster add		trophybest			int				default(0)
alter table dbo.tUserMaster add		boxrotidx			int				default(0)
alter table dbo.tUserMaster add		boxslot1			int				default(-1)
alter table dbo.tUserMaster add		boxslot2			int				default(-1)
alter table dbo.tUserMaster add		boxslot3			int				default(-1)
alter table dbo.tUserMaster add		boxslot4			int				default(-1)
alter table dbo.tUserMaster add		boxusing1			int				default(0)
alter table dbo.tUserMaster add		boxusing2			int				default(0)
alter table dbo.tUserMaster add		boxusing3			int				default(0)
alter table dbo.tUserMaster add		boxusing4			int				default(0)

update dbo.tUserMaster set
		userbattleanilistidx1 = -1, userbattleanilistidx2 = -1, userbattleanilistidx3 = -1,
		userbattleflag = 0,
		trophy				= 0,
		trophybest			= 0,
		boxrotidx			= 0,
		boxslot1			= -1,
		boxslot2			= -1,
		boxslot3			= -1,
		boxslot4			= -1,
		boxusing1			= 0,
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
alter table dbo.tComposeLogPerson add	ticket			int				default(0)
update dbo.tComposeLogPerson set ticket = 0
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tComposeLogPerson_gameid_idx2')
	DROP INDEX tComposeLogPerson.idx_tComposeLogPerson_gameid_idx2
GO
CREATE INDEX idx_tComposeLogPerson_gameid_idx2 ON tComposeLogPerson (gameid, idx2)
GO
-- select top 100 * from dbo.tComposeLogPerson where gameid = 'xxxx2' order by idx desc




---------------------------------------------
-- 	승급 로그 > 개인자료
---------------------------------------------
IF OBJECT_ID (N'dbo.tPromoteLogPerson', N'U') IS NOT NULL
	DROP TABLE dbo.tPromoteLogPerson;
GO

create table dbo.tPromoteLogPerson(
	idx				int				identity(1, 1),
	idx2			int,

	kind 			int,
	gameid			varchar(20),
	gameyear		int,
	gamemonth		int,
	famelv			int,
	heart			int				default(0),
	cashcost		int				default(0),
	gamecost		int				default(0),
	ticket			int				default(0),

	itemcode		int				default(-1),
	itemcodename	varchar(40)		default(''),

	itemcode0		int				default(-1),
	itemcode1		int				default(-1),
	itemcode2		int				default(-1),
	itemcode3		int				default(-1),
	itemcode4		int				default(-1),

	resultlist		varchar(40)		default(''),

	bgpromoteic		int				default(1),
	bgpromotename	varchar(40)		default(''),

	writedate		datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tPromoteLogPerson_idx PRIMARY KEY(idx)
)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tPromoteLogPerson_gameid_idx2')
	DROP INDEX tPromoteLogPerson.idx_tPromoteLogPerson_gameid_idx2
GO
CREATE INDEX idx_tPromoteLogPerson_gameid_idx2 ON tPromoteLogPerson (gameid, idx2)
GO
-- select top 100 * from dbo.tPromoteLogPerson where gameid = 'xxxx2' order by idx desc
*/



--select idx2, * from dbo.tComposeLogPerson where gameid = 'xxxx2' order by idx desc
/*
alter table dbo.tComposeLogPerson add	idx2			int

update dbo.tComposeLogPerson set idx2 = 0
*/

--alter table dbo.tDayLogInfoStatic add	anipromotecnt	int				default(0)
--update dbo.tDayLogInfoStatic set anipromotecnt = 0



/*
select itemcode, grade from dbo.tItemInfo where subcategory in (3)
select * from dbo.tUserItem where gameid = 'xxxx2'
*/

/*
select * from dbo.tItemInfo where subcategory in (1020)
select * from dbo.tItemInfo where itemcode in ( 102000 )

--select category, subcategory from dbo.tItemInfo group by category, subcategory order by 1 asc
*/

/*
--select * from dbo.tItemInfo where category = 1020
--select * from dbo.tItemInfo where itemcode = 102000

select * from dbo.tItemInfo where subcategory in (35, 36)
select * from dbo.tItemInfo where itemcode in ( 3500, 3600 )


select * from dbo.tItemInfo where subcategory in (38)
select * from dbo.tItemInfo where itemcode in ( 3800 )


--select category from dbo.tItemInfo group by category order by 1 asc
---select itemcode, * from dbo.tItemInfo order by 1 asc
*/




/*
alter table dbo.tUserMaster add	bgroul12	int						default(-1)
alter table dbo.tUserMaster add	bgroul13	int						default(-1)
alter table dbo.tUserMaster add	bgroul14	int						default(-1)
alter table dbo.tUserMaster add	bgroul15	int						default(-1)
alter table dbo.tUserMaster add	bgroul16	int						default(-1)
alter table dbo.tUserMaster add	bgroul17	int						default(-1)
alter table dbo.tUserMaster add	bgroul18	int		 				default(-1)
alter table dbo.tUserMaster add	bgroul19	int						default(-1)
alter table dbo.tUserMaster add	bgroul20	int						default(-1)


update dbo.tUserMaster set bgroul12 = 0, bgroul13 = 0, bgroul14 = 0, bgroul15 = 0, bgroul16 = 0, bgroul17 = 0, bgroul18 = 0, bgroul19 = 0, bgroul20 = 0
*/

/*
alter table dbo.tUserMaster add		anifirstfullupreward	int			default(0)
update dbo.tUserMaster set anifirstfullupreward = 0
*/

/*
alter table dbo.tBattleLog add			anidesc1		varchar(120)		default('')
alter table dbo.tBattleLog add			anidesc2		varchar(120)		default('')
alter table dbo.tBattleLog add			anidesc3		varchar(120)		default('')
alter table dbo.tBattleLog add			anidesc4		varchar(120)		default('')
alter table dbo.tBattleLog add			anidesc5		varchar(120)		default('')
update dbo.tBattleLog set anidesc1 = '', anidesc2 = '', anidesc3 = '', anidesc4 = '', anidesc5 = ''
*/

/*
alter table dbo.tBattleLog add		enemydesc		varchar(120)		default('')

update dbo.tBattleLog set enemydesc = ''
*/

/*
alter table dbo.tBattleLog add		upstep1			int					default(0)
alter table dbo.tBattleLog add		upstep2			int					default(0)
alter table dbo.tBattleLog add		upstep3			int					default(0)
alter table dbo.tBattleLog add		upstep4			int					default(0)
alter table dbo.tBattleLog add		upstep5			int					default(0)

update dbo.tBattleLog set upstep1 = 0, upstep2 = 0, upstep3 = 0, upstep4 = 0, upstep5 = 0
*/

/*
alter table dbo.tUserMaster add		anibuydate		datetime			default(getdate() - 1)
alter table dbo.tUserMaster add		anibuycnt		int					default(0)

update dbo.tUserMaster set anibuydate = getdate() - 1, anibuycnt = 0
*/
/*
alter table dbo.tBattleLog add	aniitemname1	varchar(40)			default('')
alter table dbo.tBattleLog add	grade1			int					default(0)

alter table dbo.tBattleLog add	aniitemname2	varchar(40)			default('')
alter table dbo.tBattleLog add	grade2			int					default(0)

alter table dbo.tBattleLog add	aniitemname3	varchar(40)			default('')
alter table dbo.tBattleLog add	grade3			int					default(0)


alter table dbo.tBattleLog add	aniitemname4	varchar(40)			default('')
alter table dbo.tBattleLog add	grade4			int					default(0)

alter table dbo.tBattleLog add	aniitemname5	varchar(40)			default('')
alter table dbo.tBattleLog add	grade5			int					default(0)

alter table dbo.tBattleLog add	ts1				int					default(0)
alter table dbo.tBattleLog add	ts1name			varchar(40)			default('')
alter table dbo.tBattleLog add	ts1up			int					default(0)

alter table dbo.tBattleLog add	ts2				int					default(0)
alter table dbo.tBattleLog add	ts2name			varchar(40)			default('')
alter table dbo.tBattleLog add	ts2up			int					default(0)

alter table dbo.tBattleLog add	ts3				int					default(0)
alter table dbo.tBattleLog add	ts3name			varchar(40)			default('')
alter table dbo.tBattleLog add	ts3up			int					default(0)

alter table dbo.tBattleLog add	ts4				int					default(0)
alter table dbo.tBattleLog add	ts4name			varchar(40)			default('')
alter table dbo.tBattleLog add	ts4up			int					default(0)

alter table dbo.tBattleLog add	ts5				int					default(0)
alter table dbo.tBattleLog add	ts5name			varchar(40)			default('')
alter table dbo.tBattleLog add	ts5up			int					default(0)


update dbo.tBattleLog set
	aniitemname1 = '', grade1 = 0, aniitemname2 = '', grade2 = 0,
	aniitemname3 = '', grade3 = 0, aniitemname4 = '', grade4 = 0,
	aniitemname5 = '', grade5 = 0,
	ts1	 = 0, ts1name = '', ts1up = 0,
	ts2	 = 0, ts2name = '', ts2up = 0,
	ts3	 = 0, ts3name = '', ts3up = 0,
	ts4	 = 0, ts4name = '', ts4up = 0,
	ts5	 = 0, ts5name = '', ts5up = 0
*/






/*
- farm296613
 gameid=farm
 password=2134234r3v9e4x481183
 market=5
 buytype=0
 platform=1
 ukey=xxxxx
 version=101
 phone=01087861226
 pushid=APA91bH6LNMIDfZJhWojO3aHGHstKBhB6kgWh533iLtU8Go6cg9NxV6VVCHthpBbHXF-gAsJpZjZVQ5Ws6MrPiXRuUATnhwRq2vXuJ5zoNGtSzv0-k4arc6X4wRDKSlQCDC014sAaWE5
 kakaotalkid=C3rxUFDxegs
 kakaouserid=88470968441492992
 kakaonickname=임진혁
 kakaoprofile=X1O+2tQVVBqen7Rw61tqzjRMS7Ck1OLSozeclo8Z5i7YABa1SpCELfeUbEDaPV5bgecs9L8GgB6dd0MoqFpwgWfw/Cr3mPo/hTorXWVRf1xHv/aw5HPCYC8RZMNnBms+
 kakaomsgblocked=-1
 kakaofriendlist=0:88192823424079121;1:90396051283528689;2:88258263875124913;3:88533256943908928;4:88148220413796480;5:88103356826892544;6:88486659936005713;7:92064568193308403;8:93578396785282242;9:88120146603028848;10:93142880032972274;11:88812599272546640;


exec spu_UserCreate 'farm',   '2134234r3v9e4x481183', 5, 0, 1, 'ukukukuk', 101,
	'01087861226',
	'APA91bH6LNMIDfZJhWojO3aHGHstKBhB6kgWh533iLtU8Go6cg9NxV6VVCHthpBbHXF-gAsJpZjZVQ5Ws6MrPiXRuUATnhwRq2vXuJ5zoNGtSzv0-k4arc6X4wRDKSlQCDC014sAaWE5',
	'C3rxUFDxegs', '88470968441492992', '임진혁', 'X1O+2tQVVBqen7Rw61tqzjRMS7Ck1OLSozeclo8Z5i7YABa1SpCELfeUbEDaPV5bgecs9L8GgB6dd0MoqFpwgWfw/Cr3mPo/hTorXWVRf1xHv/aw5HPCYC8RZMNnBms+', -1, '', -1

*/

/*
alter table dbo.tDayLogInfoStatic add		freeanicomposecnt	int					default(0)
alter table dbo.tDayLogInfoStatic add		payanicomposecnt	int					default(0)
update dbo.tDayLogInfoStatic set freeanicomposecnt = 0, payanicomposecnt = 0
*/

/*
alter table dbo.tUserMaster add		bkcomposecnt	int					default(0)
update dbo.tUserMaster set bkcomposecnt = 0
*/




--delete from dbo.tUserItem where gameid = 'farm283891' and invenkind = 1
--delete from dbo.tUserItem where gameid = 'farm283891' and invenkind = 1040
--delete from dbo.tUserItem where gameid = 'farm283891' and invenkind = 1200

/*
alter table dbo.tUserMaster add		bkapartani		int					default(0)
alter table dbo.tUserMaster add		bkapartts		int					default(0)
update dbo.tUserMaster set bkapartani = 0, bkapartts = 0
*/



--alter table dbo.tUserMaster add			apartbuycnt		int					default(0)
--update dbo.tUserMaster set apartbuycnt = 0


/*
alter table dbo.tUserMaster add			heartsenddate	datetime			default(getdate() - 1)
alter table dbo.tUserMaster add			heartsendcnt	int					default(0)


update dbo.tUserMaster set heartsenddate = getdate() - 1, heartsendcnt = 0
*/

--update dbo.tUserFarm set playcnt = 10 where gameid = 'farm226440'
--update dbo.tUserFarm set buystate = -1 where gameid = 'farm226440'
--delete from dbo.tUserItem where gameid = 'farm226440' and invenkind = 1 and listidx >= 500 and freshstem100 = 0
--select * from dbo.tUserItem  where gameid = 'farm226440' and invenkind = 1 and listidx >= 500 and freshstem100 = 0

--delete from dbo.tComReward where gameid = 'farm226440'
--update dbo.tUserMaster set comreward = 90112, bkcrossnormal = 0 where gameid = 'farm226440'	-- 일반교배1
--update dbo.tUserMaster set comreward = 90142, bkheart = 89 where gameid = 'farm226440'	-- 하트


--delete from dbo.tComReward where gameid = 'farm226440'
--update dbo.tUserMaster set comreward = 90106, bktsgrade1cnt = 0 where gameid = 'farm226440'		-- 임시일반보물뽑기(23)

--delete from dbo.tComReward where gameid = 'farm226440'
--update dbo.tUserMaster set comreward = 90108-1, bktsgrade2cnt = 0 where gameid = 'farm226440'	-- 임시프림보물뽑기(24)

--delete from dbo.tComReward where gameid = 'farm226440'
--update dbo.tUserMaster set comreward = 90109-1, bktsupcnt = 0 where gameid = 'farm226440'		-- 임시보물강화횟수(25)

--delete from dbo.tComReward where gameid = 'farm226440'
--update dbo.tUserMaster set comreward = 90110-1, bkbattlecnt = 0 where gameid = 'farm226440'	-- 임시배틀참여횟수(26)

--delete from dbo.tComReward where gameid = 'farm226440'
--update dbo.tUserMaster set comreward = 90111-1, bkaniupcnt = 0 where gameid = 'farm226440'	-- 임시동물강화(27)

/*

alter table dbo.tUserMaster add		bgcttradecnt	int					default(0)
update dbo.tUserMaster set bgcttradecnt = 0

alter table dbo.tUserMaster add		bktsgrade1cnt	int					default(0)
alter table dbo.tUserMaster add		bktsgrade2cnt	int					default(0)
alter table dbo.tUserMaster add		bktsupcnt		int					default(0)
alter table dbo.tUserMaster add		bkbattlecnt		int					default(0)
alter table dbo.tUserMaster add		bkaniupcnt		int					default(0)
update dbo.tUserMaster set bktsgrade1cnt = 0, bktsgrade2cnt = 0, bktsupcnt = 0, bkbattlecnt = 0, bkaniupcnt = 0


alter table dbo.tUserMaster add		tsupcnt		int						default(0)
alter table dbo.tUserMaster add		bgbattlecnt		int					default(0)
alter table dbo.tUserMaster add		bganiupcnt		int					default(0)
update dbo.tUserMaster set tsupcnt = 0, bgbattlecnt= 0, bganiupcnt = 0
*/

/*
alter table dbo.tDayLogInfoStatic add	playcntbuy		int				default(0)

update dbo.tDayLogInfoStatic set playcntbuy = 0
*/


--update dbo.tUserFarm set playcnt = 10

/*
declare @attenddate		datetime
declare @curdate		datetime

set @attenddate		= '2016-01-09 00:00'
set @curdate		= '2016-01-29 00:01'
select @attenddate attenddate, @curdate curdate, datediff(d, @attenddate, @curdate)

set @attenddate		= '2016-01-28 00:01'
set @curdate		= '2016-01-29 00:01'
select @attenddate attenddate, @curdate curdate, datediff(d, @attenddate, @curdate)

set @attenddate		= '2016-01-28 23:59'
set @curdate		= '2016-01-29 00:01'
select @attenddate attenddate, @curdate curdate, datediff(d, @attenddate, @curdate)

set @attenddate		= '2016-01-29 00:00'
set @curdate		= '2016-01-29 23:59'
select @attenddate attenddate, @curdate curdate, datediff(d, @attenddate, @curdate)
*/



/*
alter table dbo.tUserFarm add	playcnt			int					default(10)

update dbo.tUserFarm set playcnt = 2 where gameid = 'farm167678'

select * from dbo.tUserFarm where gameid = 'xxxx2' order by farmidx asc
*/
--update dbo.tUserItem set manger = 0 where gameid = 'farm185995' and invenkind = 1

/*
exec spu_SetDirectItem 'farm185995', 120221, 1, -1	-- 보물추가.
exec spu_SetDirectItem 'farm185995', 120222, 1, -1	-- 보물추가.
exec spu_SetDirectItem 'farm185995', 120223, 1, -1	-- 보물추가.
exec spu_SetDirectItem 'farm185995', 120224, 1, -1	-- 보물추가.

exec spu_SetDirectItem 'farm185995', 120231, 1, -1	-- 보물추가.
exec spu_SetDirectItem 'farm185995', 120232, 1, -1	-- 보물추가.
exec spu_SetDirectItem 'farm185995', 120233, 1, -1	-- 보물추가.
exec spu_SetDirectItem 'farm185995', 120234, 1, -1	-- 보물추가.

exec spu_SetDirectItem 'farm185995', 120241, 1, -1	-- 보물추가.
exec spu_SetDirectItem 'farm185995', 120242, 1, -1	-- 보물추가.
exec spu_SetDirectItem 'farm185995', 120243, 1, -1	-- 보물추가.
exec spu_SetDirectItem 'farm185995', 120244, 1, -1	-- 보물추가.
*/



/*
alter table dbo.tSystemInfo add	plusgoldticket		int					default(0)
alter table dbo.tSystemInfo add	plusbattleticket	int					default(0)
update dbo.tSystemInfo set plusgoldticket = 20, plusbattleticket = 20
*/

/*
alter table dbo.tUserMaster add	nicknamechange	int						default(0)
update dbo.tUserMaster set nicknamechange = 0
*/

/*
select * from dbo.tSystemSupportMsg where groupid = 1 order by groupline asc
--select * from dbo.tSystemSupportMsg where groupid = @settlemsgid order by groupline asc

select groupid, groupline, count(*) from dbo.tSystemSupportMsg group by groupid, groupline order by groupid asc, groupline asc
*/

/*
select * from dbo.tUserItemDieLog where gameid = 'farm159937' and listidx = 492
select * from dbo.tUserItem where gameid = 'farm159937' and listidx = 492

select gameid, count(*) from dbo.tUserItemDieLog group by gameid order by 2 desc
*/

/*
alter table dbo.tUserItemDieLog add	idx3			int

update dbo.tUserItemDieLog set idx3 = 1

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserItemDieLog_gameid_idx3')
    DROP INDEX tUserItemDieLog.idx_tUserItemDieLog_gameid_idx3
GO
CREATE INDEX idx_tUserItemDieLog_gameid_idx3 ON tUserItemDieLog (gameid, idx3)
GO



alter table dbo.tUserItemAliveLog add	idx3			int

update dbo.tUserItemAliveLog set idx3 = 1

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserItemAliveLog_gameid_idx3')
    DROP INDEX tUserItemAliveLog.idx_tUserItemAliveLog_gameid_idx3
GO
CREATE INDEX idx_tUserItemAliveLog_gameid_idx3 ON tUserItemAliveLog (gameid, idx3)
GO
*/



--alter table dbo.tUserItemDieLog add	treasureupgrade	int					default(0)
--update dbo.tUserItemDieLog set treasureupgrade = 0


/*
alter table dbo.tUserMaster add	settlestep	int						default(0)
update dbo.tUserMaster set settlestep = 0
*/


/*
select * from dbo.tUserItem where gameid = 'xxxx2' and invenkind = 1200

update dbo.tUserItem
	set
		upstepmax = 7
where invenkind = 1200 and gameid = 'xxxx2'
*/

--delete from dbo.tUserItem where gameid = 'xxxx2' and invenkind = 1200
/*
alter table dbo.tDayLogInfoStatic add	battlecnt		int				default(0)
update dbo.tDayLogInfoStatic set battlecnt = 0
*/
/*
update dbo.tUserMaster
	set
		goldticket = 3,
		goldtickettime = dateadd(ss, -(60*4+30), getdate())
where gameid = 'farm144874'
*/


/*
--update dbo.tUserMaster set goldticket = 3, goldtickettime = dateadd(ss, -(60*4+30), getdate()) where gameid = 'xxxx2'
update dbo.tUserMaster set gameyear = 2013, gamemonth = 3, frametime = 0, etsalecoin = 1000, fame = 5, famelv = 2, tradecnt = 1, prizecnt = 1, etremain = -1 where gameid = 'xxxx2'
update dbo.tUserMaster set gamecost = 0, cashcost = 0, feed = 0, heart = 0 where gameid = 'xxxx2'
update dbo.tSchoolMaster set totalpoint = 0 where schoolidx = (select schoolidx from dbo.tUserMaster where gameid = 'xxxx2')
update dbo.tSchoolUser set point = 0 where gameid = 'xxxx2'
delete from dbo.tUserSaleLog where gameid = 'xxxx2'
delete from dbo.tGiftList where gameid = 'xxxx2'
delete from dbo.tEpiReward where gameid = 'xxxx2'
exec spu_GameTrade 'xxxx2', '049000s1i0n7t8445289', '0:2013;  1:4;      2:0;      4:2;       10:10;       11:100;     12:20;     13:200;   30:16;    43:1;',
													'1:5,1,1;3:5,23,0;4:5,25,-1;',
													'14:1;15:1;16:1;',
													'0:5; 1:2;   10:2;    11:1;    12:75;    20:10;    30:1;      31:11;         33:7;     34:20;    35:77;  40:-1; 61:-1;       62:1;             63:-1; 70:1',
													'0:0;1:1;2:2;3:3;4:4;5:5;6:6;7:7;8:8;9:9;',
													-1										-- 필드없음.


*/
--select getdate(), dateadd(ss, -(60*4+30), getdate())

/*
alter table dbo.tUserSaleLog add	goldticket	int						default(0)
alter table dbo.tUserSaleLog add	goldticketused2	int					default(-1)
update dbo.tUserSaleLog set goldticket = 0, goldticketused2= -1
*/
--select houselv from dbo.tItemInfo group by houselv

/*
alter table dbo.tUserMaster add	tsskillbullet	int					default(0)
alter table dbo.tUserMaster add	tsskillvaccine	int					default(0)
alter table dbo.tUserMaster add	tsskillfeed		int					default(0)
alter table dbo.tUserMaster add	tsskillbooster	int					default(0)
update dbo.tUserMaster set tsskillbullet = 0, tsskillvaccine = 0, tsskillfeed = 0, tsskillbooster = 0
*/

/*
alter table dbo.tUserMaster add		tsskillcashcost	int					default(0)
alter table dbo.tUserMaster add		tsskillheart	int					default(0)
alter table dbo.tUserMaster add		tsskillgamecost	int					default(0)
alter table dbo.tUserMaster add		tsskillfpoint	int					default(0)
alter table dbo.tUserMaster add		tsskillrebirth	int					default(0)
alter table dbo.tUserMaster add		tsskillalba		int					default(0)
update dbo.tUserMaster set tsskillcashcost = 0, tsskillheart = 0, tsskillgamecost = 0, tsskillfpoint = 0, tsskillrebirth = 0, tsskillalba = 0
*/


/*
exec spu_SubGiftSendNew 2,120500,  1, 'SysLogin', 'xxxx2', ''				-- 보물.
exec spu_SubGiftSendNew 2,120501,  1, 'SysLogin', 'xxxx2', ''				-- 보물.
exec spu_SubGiftSendNew 2,120502,  1, 'SysLogin', 'xxxx2', ''				-- 보물.
exec spu_SubGiftSendNew 2,120503,  1, 'SysLogin', 'xxxx2', ''				-- 보물.
exec spu_SubGiftSendNew 2,120504,  1, 'SysLogin', 'xxxx2', ''				-- 보물.
exec spu_SubGiftSendNew 2,120505,  1, 'SysLogin', 'xxxx2', ''				-- 보물.


exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 8870, -1, -1,  1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 8871, -1, -1,  1, -1
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 8872, -1, -1,  1, -1
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 8873, -1, -1,  1, -1
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 8874, -1, -1,  1, -1
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 8875, -1, -1,  1, -1
*/


/*
alter table dbo.tUserMaster add	tslistidx1	int						default(-1)
alter table dbo.tUserMaster add	tslistidx2	int						default(-1)
alter table dbo.tUserMaster add	tslistidx3	int						default(-1)
alter table dbo.tUserMaster add	tslistidx4	int						default(-1)
alter table dbo.tUserMaster add	tslistidx5	int						default(-1)
update dbo.tUserMaster set tslistidx1 = -1, tslistidx2 = -1, tslistidx3 = -1, tslistidx4 = -1, tslistidx5 = -1
*/

/*
alter table dbo.tDayLogInfoStatic add	tsupgradenor	int				default(0)
alter table dbo.tDayLogInfoStatic add	tsupgradepre	int				default(0)
update dbo.tDayLogInfoStatic set tsupgradenor = 0, tsupgradepre = 0
*/
/*
---------------------------------------------
-- 	보물 로그 > 개인자료
---------------------------------------------
IF OBJECT_ID (N'dbo.tTreasureLogPerson', N'U') IS NOT NULL
	DROP TABLE dbo.tTreasureLogPerson;
GO

create table dbo.tTreasureLogPerson(
	idx				int				identity(1, 1),
	idx2			int,

	gameid			varchar(20),
	kind			int,
	framelv			int,
	itemcode		int,
	itemcodename	varchar(40),

	cashcost		int				default(0),
	gamecost		int				default(0),
	heart			int				default(0),

	gameyear		int,
	gamemonth		int,

	itemcode0		int				default(-1),
	itemcode1		int				default(-1),
	itemcode2		int				default(-1),
	itemcode3		int				default(-1),
	itemcode4		int				default(-1),
	itemcode5		int				default(-1),
	itemcode6		int				default(-1),
	itemcode7		int				default(-1),
	itemcode8		int				default(-1),
	itemcode9		int				default(-1),
	itemcode10		int				default(-1),
	itemcode0name	varchar(40)		default(''),
	itemcode1name	varchar(40)		default(''),
	itemcode2name	varchar(40)		default(''),
	itemcode3name	varchar(40)		default(''),
	itemcode4name	varchar(40)		default(''),
	itemcode5name	varchar(40)		default(''),
	itemcode6name	varchar(40)		default(''),
	itemcode7name	varchar(40)		default(''),
	itemcode8name	varchar(40)		default(''),
	itemcode9name	varchar(40)		default(''),
	itemcode10name	varchar(40)		default(''),

	writedate		datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tTreasureLogPerson_idx PRIMARY KEY(idx)
)
-- gameid, idx
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tTreasureLogPerson_gameid_idx')
	DROP INDEX tTreasureLogPerson.idx_tTreasureLogPerson_gameid_idx
GO
CREATE INDEX idx_tTreasureLogPerson_gameid_idx ON tTreasureLogPerson (gameid, idx)
GO


---------------------------------------------
-- 	보물 로그(월별 Master)
---------------------------------------------
IF OBJECT_ID (N'dbo.tTreasureLogTotalMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tTreasureLogTotalMaster;
GO

create table dbo.tTreasureLogTotalMaster(
	idx				int				identity(1, 1),
	dateid8			char(8),							-- 20101210

	normalcnt		int				default(0),
	premiumcnt		int				default(0),
	premiumcnt4		int				default(0),
	acccnt			int				default(0),			-- 악세사리로그.

	-- Constraint
	CONSTRAINT	pk_tTreasureLogTotalMaster_dateid	PRIMARY KEY(dateid8)
)


---------------------------------------------
-- 	보물 로그(월별 Sub)
---------------------------------------------
IF OBJECT_ID (N'dbo.tTreasureLogTotalSub', N'U') IS NOT NULL
	DROP TABLE dbo.tTreasureLogTotalSub;
GO

create table dbo.tTreasureLogTotalSub(
	idx				int				identity(1, 1),

	dateid8			char(8),							-- 20101210
	itemcode		int,
	itemcodename	varchar(40)		default(''),

	normalcnt		int				default(0),
	premiumcnt		int				default(0),
	premiumcnt4		int				default(0),

	-- Constraint
	CONSTRAINT	pk_tTreasureLogTotalSub_dateid8_itemcode	PRIMARY KEY(dateid8, itemcode)
)
*/




















/*
alter table dbo.tRouletteLogPerson add	idx2			int
update dbo.tRouletteLogPerson set idx2 = 0
*/

/*
declare @roul1  int
set @roul1 = -1
					select @roul1 = itemcode from dbo.tItemInfo
					where category = 1
						  and grade in ( 6 )
						  and itemname not like '%미정%'
						  order by newid()
select @roul1 roul1

					select * from dbo.tItemInfo
					where category = 1
						  --and grade in ( 6 )
						  and itemname not like '%미정%'
						  and itemname not like '%지원용%'

*/

/*

alter table dbo.tUserItemBuyLogTotalMaster add	heart		int					default(0)
update dbo.tUserItemBuyLogTotalMaster set heart = 0


alter table dbo.tUserItemBuyLogTotalSub add	heart		int					default(0)
update dbo.tUserItemBuyLogTotalSub set heart = 0


alter table dbo.tUserItemBuyLogMonth add	heart		int					default(0)
update dbo.tUserItemBuyLogMonth set heart = 0
*/

/*
alter table dbo.tUserItemBuyLog add	heart		int					default(0)

update dbo.tUserItemBuyLog set heart = 0
*/

/*
alter table dbo.tDayLogInfoStatic add	payroulettcnt2	int				default(0)
alter table dbo.tDayLogInfoStatic add	freetreasurecnt	int				default(0)
alter table dbo.tDayLogInfoStatic add	paytreasurecnt	int				default(0)
alter table dbo.tDayLogInfoStatic add	paytreasurecnt2	int				default(0)

update dbo.tDayLogInfoStatic set payroulettcnt2 = 0, freetreasurecnt= 0,paytreasurecnt = 0, paytreasurecnt2= 0
*/

/*
alter table dbo.tRouletteLogPerson add	itemcode5		int				default(-1)
alter table dbo.tRouletteLogPerson add	itemcode6		int				default(-1)
alter table dbo.tRouletteLogPerson add	itemcode7		int				default(-1)
alter table dbo.tRouletteLogPerson add	itemcode8		int				default(-1)
alter table dbo.tRouletteLogPerson add	itemcode9		int				default(-1)
alter table dbo.tRouletteLogPerson add	itemcode10		int				default(-1)
alter table dbo.tRouletteLogPerson add	itemcode5name	varchar(40)		default('')
alter table dbo.tRouletteLogPerson add	itemcode6name	varchar(40)		default('')
alter table dbo.tRouletteLogPerson add	itemcode7name	varchar(40)		default('')
alter table dbo.tRouletteLogPerson add	itemcode8name	varchar(40)		default('')
alter table dbo.tRouletteLogPerson add	itemcode9name	varchar(40)		default('')
alter table dbo.tRouletteLogPerson add	itemcode10name	varchar(40)		default('')
update dbo.tRouletteLogPerson set itemcode5 = -1, itemcode6 = -1, itemcode7 = -1, itemcode8 = -1, itemcode9 = -1, itemcode10 = -1, itemcode5name = '', itemcode6name = '', itemcode7name = '', itemcode8name = '', itemcode9name = '', itemcode10name = ''

alter table dbo.tRouletteLogTotalMaster add	premiumcnt4		int				default(0)
update dbo.tRouletteLogTotalMaster set premiumcnt4 = 0

alter table dbo.tRouletteLogTotalSub add	premiumcnt4		int				default(0)
update dbo.tRouletteLogTotalSub set premiumcnt4 = 0
*/

/*
---------------------------------------------
-- 보물뽑기이벤트 관리 내용.
---------------------------------------------
IF OBJECT_ID (N'dbo.tSystemTreasureMan', N'U') IS NOT NULL
	DROP TABLE dbo.tSystemTreasureMan;
GO

create table dbo.tSystemTreasureMan(
	idx					int 				IDENTITY(1, 1),

	roulmarket			int					default(5),

	-- 0.할인.
	roulsaleflag		int					default(-1),
	roulsalevalue		int					default(0),

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
	roultimetime4		int					default(-1),

	-- 3.프리미엄 무료뽑기.
	pmgauageflag		int					default(-1),
	pmgauagepoint		int					default(10),
	pmgauagemax			int					default(100),

	-- 4.강화비용 할인.
	tsupgradesaleflag	int					default(-1),
	tsupgradesalevalue	int					default(0),

	--코멘트.
	comment				varchar(256)		default(''),
	writedate			datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tSystemTreasureMan_idx	PRIMARY KEY(idx)
)
-- select top 1 * from dbo.tSystemTreasureMan where roulmarket like '%5%' order by idx desc
-- insert into dbo.tSystemTreasureMan(roulmarket,      roulflag,    roulstart,      roulend, roulani1, roulani2, roulani3, roulreward1, roulreward2, roulreward3,       roulname1,       roulname2,       roulname3, roultimeflag, roultimetime1, roultimetime2, roultimetime3, comment)
-- values                              (         5,        1, '2013-09-01', '2023-09-01',    80000,    80001,    80006,        3015,        3015,        3015,  '콩나물 화분D', '오래된 라디오D', '콩나물 화분A',            1,             12,            18,            23, '최초내용')
-- update dbo.tSystemTreasureMan set roulflag = -1 where idx = 3
*/


/*
alter table dbo.tSystemRouletteMan add roulsaleflag		int					default(-1)
alter table dbo.tSystemRouletteMan add roulsalevalue	int					default(0)

update dbo.tSystemRouletteMan set roulsaleflag	= -1, roulsalevalue = 0
*/





/*
alter table dbo.tUserMaster add		bgroul6		int						default(-1)
alter table dbo.tUserMaster add		bgroul7		int						default(-1)
alter table dbo.tUserMaster add		bgroul8		int						default(-1)
alter table dbo.tUserMaster add		bgroul9		int						default(-1)
alter table dbo.tUserMaster add		bgroul10	int						default(-1)
alter table dbo.tUserMaster add		bgroul11	int						default(-1)


update dbo.tUserMaster set bgroul6 = -1, bgroul7 = -1, bgroul8 = -1, bgroul9 = -1, bgroul10 = -1, bgroul11 = -1
*/

/*
alter table dbo.tUserItem add	treasureupgrade	int					default(0)
update dbo.tUserItem set treasureupgrade = 0
*/

/*
alter table dbo.tUserMaster add	tradesuccesscnt	int					default(0)
alter table dbo.tUserMaster add	tradeclosedealer	int						default(-1)
update dbo.tUserMaster set tradesuccesscnt = 0, tradeclosedealer = -1
*/

/*

alter table dbo.tUserItemDel add	usedheart		int					default(0)
alter table dbo.tUserItemDel add	usedgamecost	int					default(0)
update dbo.tUserItemDel set usedheart = 0, usedgamecost = 0



alter table dbo.tUserItemDieLog add	usedheart		int					default(0)
alter table dbo.tUserItemDieLog add	usedgamecost	int					default(0)
update dbo.tUserItemDieLog set usedheart = 0, usedgamecost = 0


alter table dbo.tUserItemAliveLog add	usedheart		int					default(0)
alter table dbo.tUserItemAliveLog add	usedgamecost	int					default(0)
update dbo.tUserItemAliveLog set usedheart = 0, usedgamecost = 0


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


/*(
alter table dbo.tUserMaster add	star			int				default(0)
update dbo.tUserMaster set star = 0

alter table dbo.tBattleLog add	star			int				default(0)
update dbo.tBattleLog set star = 0

alter table dbo.tUserFarm add	star			int				default(0)
update dbo.tUserFarm set star = 0
*/



--exec spu_GiftGain 'xxxx2', '049000s1i0n7t8445289', -3, 3554, -1, -1, -1, -1	-- 소	(인벤)
--exec spu_GiftGain 'xxxx2', '049000s1i0n7t8445289', -3, 3553, -1, -1, -1, -1	-- 소	(인벤)
--exec spu_GiftGain 'xxxx2', '049000s1i0n7t8445289', -3, 3552, -1, -1, -1, -1	-- 소	(인벤)
/*
update dbo.tUserMaster set battleanilistidx1 = 991, battleanilistidx2 = 992, battleanilistidx3 = 993, battleanilistidx4 = 994, battleanilistidx5 = 995 where gameid = 'xxxx2'
select battleanilistidx1, battleanilistidx2, battleanilistidx3, battleanilistidx4, battleanilistidx5 from dbo.tUserMaster where gameid = 'xxxx2'
exec spu_Login 'xxxx2', '049000s1i0n7t8445289', 5, 119, '', -1, -1			-- 정상유저
select battleanilistidx1, battleanilistidx2, battleanilistidx3, battleanilistidx4, battleanilistidx5 from dbo.tUserMaster where gameid = 'xxxx2'
*/

/*
---------------------------------------------
--		배틀로고
---------------------------------------------
IF OBJECT_ID (N'dbo.tBattleLog', N'U') IS NOT NULL
	DROP TABLE dbo.tBattleLog;
GO

create table dbo.tBattleLog(
	--(일반정보)
	idx			int 					IDENTITY(1, 1),
	idx2		int,

	gameid		varchar(20),
	farmidx		int						default(6900),

	aniitemcode1	int					default(-1),	-- 동물 아이템코드
	upcnt1			int					default(0),		-- 세포능력치 1/100
	fresh1			int					default(0),
	att1			int					default(0),
	time1			int					default(0),
	def1			int					default(0),
	hp1				int					default(0),

	aniitemcode2	int					default(-1),
	upcnt2			int					default(0),
	fresh2			int					default(0),
	att2			int					default(0),
	time2			int					default(0),
	def2			int					default(0),
	hp2				int					default(0),

	aniitemcode3	int					default(-1),
	upcnt3			int					default(0),
	fresh3			int					default(0),
	att3			int					default(0),
	time3			int					default(0),
	def3			int					default(0),
	hp3				int					default(0),

	aniitemcode4	int					default(-1),
	upcnt4			int					default(0),
	fresh4			int					default(0),
	att4			int					default(0),
	time4			int					default(0),
	def4			int					default(0),
	hp4				int					default(0),

	aniitemcode5	int					default(-1),
	upcnt5			int					default(0),
	fresh5			int					default(0),
	att5			int					default(0),
	time5			int					default(0),
	def5			int					default(0),
	hp5				int					default(0),

	writedate		datetime			default(getdate()),

	result			int					default(0),		--  1   BATTLE_RESULT_WIN
														-- -1  	BATTLE_RESULT_LOSE
														--  0   BATTLE_RESULT_DRAW
	playtime		int					default(0),
	reward1			int					default(-1),
	reward2			int					default(-1),
	reward3			int					default(-1),
	reward4			int					default(-1),
	reward5			int					default(-1),
	rewardgamecost	int					default(0),

	-- Constraint
	CONSTRAINT pk_tBattleLog_idx	PRIMARY KEY(idx)
)
GO
-- 인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tBattleLog_gameid_idx2')
    DROP INDEX tBattleLog.idx_tBattleLog_gameid_idx2
GO
CREATE INDEX idx_tBattleLog_gameid_idx2 ON tBattleLog (gameid, idx2)
GO

--insert into dbo.tBattleLog(gameid, idx2, farmidx, aniitemcode1, upcnt1, fresh1, att1, time1, def1, hp1, aniitemcode2, upcnt2, fresh2, att2, time2, def2, hp2, aniitemcode3, upcnt3, fresh3, att3, time3, def3, hp3, aniitemcode4, upcnt4, fresh4, att4, time4, def4, hp4, aniitemcode5, upcnt5, fresh5, att5, time5, def5, hp5)
--values(					'xxxx2',    1,    6900,           -1,      0,      0,    0,     0,    0,   0,           -1,      0,      0,    0,     0,    0,   0,           -1,      0,      0,    0,     0,    0,   0,           -1,      0,      0,    0,     0,    0,   0,           -1,      0,      0,    0,     0,    0,   0)
--update dbo.tBattleLog
--	set
--		result 		= 1,		playtime	= 90,
--		reward1		= 104010,	reward2		= 104010,
--		reward3		= 104010,	reward4		= 104010,	reward5		= -1,
--		rewardgamecost = 20
--where gameid = 'xxxx2' and idx2 = 1
--select top 1 * from dbo.tBattleLog where gameid = 'xxxx2' and idx2 = 1
*/






/*
alter table dbo.tUserMaster add	battlefarmidx		int				default(6900)
alter table dbo.tUserMaster add	battleanilistidx1	int				default(-1)
alter table dbo.tUserMaster add	battleanilistidx2	int				default(-1)
alter table dbo.tUserMaster add	battleanilistidx3	int				default(-1)
alter table dbo.tUserMaster add	battleanilistidx4	int				default(-1)
alter table dbo.tUserMaster add	battleanilistidx5	int				default(-1)
alter table dbo.tUserMaster add	battleflag			int				default(0)
update dbo.tUserMaster set battlefarmidx = 6900, battleanilistidx1 = -1, battleanilistidx2 = -1, battleanilistidx3  = -1, battleanilistidx4  = -1, battleanilistidx5  = -1, battleflag  = 0
*/


/*
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
upcnt, upstepmax, freshstem100, attstem100, timestem100, defstem100, hpstem100

alter table dbo.tUserItem add 	upcnt			int					default(0)
alter table dbo.tUserItem add	upstepmax		int					default(0)
alter table dbo.tUserItem add	freshstem100	int					default(0)
alter table dbo.tUserItem add	attstem100		int					default(0)
alter table dbo.tUserItem add	timestem100		int					default(0)
alter table dbo.tUserItem add	defstem100		int					default(0)
alter table dbo.tUserItem add	hpstem100		int					default(0)
update dbo.tUserItem set upcnt	= 0, upstepmax = 0, freshstem100 = 0, attstem100 = 0, timestem100 = 0, defstem100 = 0, hpstem100 = 0

alter table dbo.tUserItemAliveLog add 	upcnt			int					default(0)
alter table dbo.tUserItemAliveLog add	upstepmax		int					default(0)
alter table dbo.tUserItemAliveLog add	freshstem100	int					default(0)
alter table dbo.tUserItemAliveLog add	attstem100		int					default(0)
alter table dbo.tUserItemAliveLog add	timestem100		int					default(0)
alter table dbo.tUserItemAliveLog add	defstem100		int					default(0)
alter table dbo.tUserItemAliveLog add	hpstem100		int					default(0)
update dbo.tUserItemAliveLog set upcnt	= 0, upstepmax = 0, freshstem100 = 0, attstem100 = 0, timestem100 = 0, defstem100 = 0, hpstem100 = 0

alter table dbo.tUserItemDieLog add upcnt			int					default(0)
alter table dbo.tUserItemDieLog add	upstepmax		int					default(0)
alter table dbo.tUserItemDieLog add	freshstem100	int					default(0)
alter table dbo.tUserItemDieLog add	attstem100		int					default(0)
alter table dbo.tUserItemDieLog add	timestem100		int					default(0)
alter table dbo.tUserItemDieLog add	defstem100		int					default(0)
alter table dbo.tUserItemDieLog add	hpstem100		int					default(0)
update dbo.tUserItemDieLog set upcnt	= 0, upstepmax = 0, freshstem100 = 0, attstem100 = 0, timestem100 = 0, defstem100 = 0, hpstem100 = 0

alter table dbo.tUserItemDel add 	upcnt			int					default(0)
alter table dbo.tUserItemDel add	upstepmax		int					default(0)
alter table dbo.tUserItemDel add	freshstem100	int					default(0)
alter table dbo.tUserItemDel add	attstem100		int					default(0)
alter table dbo.tUserItemDel add	timestem100		int					default(0)
alter table dbo.tUserItemDel add	defstem100		int					default(0)
alter table dbo.tUserItemDel add	hpstem100		int					default(0)
update dbo.tUserItemDel set upcnt	= 0, upstepmax = 0, freshstem100 = 0, attstem100 = 0, timestem100 = 0, defstem100 = 0, hpstem100 = 0
*/

--select * from dbo.tUserItem where gameid = 'xxxx2'

--alter table dbo.tUserMaster add invenstemcellmax	int				default(50)
--update dbo.tUserMaster set invenstemcellmax	= 50
--alter table dbo.tUserMaster add invenstemcellstep	int				default(0)
--update dbo.tUserMaster set invenstemcellstep	= 0



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


/*
alter table dbo.tSystemRouletteMan add roulrewardcnt1		int					default(0)
alter table dbo.tSystemRouletteMan add roulrewardcnt2		int					default(0)
alter table dbo.tSystemRouletteMan add roulrewardcnt3		int					default(0)
alter table dbo.tSystemRouletteMan add roultimetime4		int					default(-1)

update dbo.tSystemRouletteMan set roulrewardcnt1	= 0, roulrewardcnt2 = 0, roulrewardcnt3 = 0, roultimetime4 = -1
*/



--alter table dbo.tUserMaster add sid			int						default(0)
--update dbo.tUserMaster set sid	= 0



/*
update dbo.tGiftList set giftkind = 2 where idx >= 1936 and gameid = 'farm54835'
update dbo.tGiftList set giftkind = 1 where idx = 1936  and gameid = 'farm54835'
delete from dbo.tUserItem where gameid = 'farm54835'
update dbo.tUserMaster
	set
		gamecost = 0,
		cashcost = 0,
		heart = 0,
		feed = 0,
		fpoint = 0
where gameid = 'farm54835'
*/

--exec spu_GiftGainNew 'farm54835', '049000s1i0n7t8445289', -3, 1988, -1, -1, -1, -1	--

/*
declare @gameid varchar(20)
set @gameid = 'farm54835'
select * from dbo.tGiftList where gameid = @gameid order by idx asc

delete from dbo.tGiftList where gameid = @gameid
delete from dbo.tUserItem where gameid = @gameid


exec spu_SubgiftsendNew 1,    -1, 0, 'SysLogin', @gameid, 'message'			-- 메세지.

exec spu_SubgiftsendNew 2,     1,  1, 'SysLogin', @gameid, ''				-- 젖소.
exec spu_SubgiftsendNew 2,   100,  1, 'SysLogin', @gameid, ''				-- 양.
exec spu_SubgiftsendNew 2,   200,  1, 'SysLogin', @gameid, ''				-- 산양.
exec spu_SubgiftsendNew 2,   700, 11, 'SysLogin', @gameid, ''				-- 총알.
exec spu_SubgiftsendNew 2,   701, 11, 'SysLogin', @gameid, ''				--
exec spu_SubgiftsendNew 2,   702, 11, 'SysLogin', @gameid, ''				--
exec spu_SubgiftsendNew 2,   703, 11, 'SysLogin', @gameid, ''				--
exec spu_SubgiftsendNew 2,   703, 0 , 'SysLogin', @gameid, ''				--
exec spu_SubgiftsendNew 2,   800, 11, 'SysLogin', @gameid, ''				-- 백신.
exec spu_SubgiftsendNew 2,   801, 11, 'SysLogin', @gameid, ''				--
exec spu_SubgiftsendNew 2,   802, 11, 'SysLogin', @gameid, ''				--
exec spu_SubgiftsendNew 2,   803, 11, 'SysLogin', @gameid, ''				--
exec spu_SubgiftsendNew 2,   803,  0, 'SysLogin', @gameid, ''				--
exec spu_SubgiftsendNew 2,   900, 11, 'SysLogin', @gameid, ''				-- 건초.
exec spu_SubgiftsendNew 2,   900,  0, 'SysLogin', @gameid, ''				--
exec spu_SubgiftsendNew 2,  1000, 11, 'SysLogin', @gameid, ''				-- 일꾼.
exec spu_SubgiftsendNew 2,  1001, 11, 'SysLogin', @gameid, ''				--
exec spu_SubgiftsendNew 2,  1002, 11, 'SysLogin', @gameid, ''				--
exec spu_SubgiftsendNew 2,  1003, 11, 'SysLogin', @gameid, ''				--
exec spu_SubgiftsendNew 2,  1003,  0, 'SysLogin', @gameid, ''				--
exec spu_SubgiftsendNew 2,  1100, 11, 'SysLogin', @gameid, ''				-- 촉진제.
exec spu_SubgiftsendNew 2,  1101, 11, 'SysLogin', @gameid, ''				--
exec spu_SubgiftsendNew 2,  1102, 11, 'SysLogin', @gameid, ''				--
exec spu_SubgiftsendNew 2,  1103, 11, 'SysLogin', @gameid, ''				--
exec spu_SubgiftsendNew 2,  1104, 11, 'SysLogin', @gameid, ''				--
exec spu_SubgiftsendNew 2,  1104,  0, 'SysLogin', @gameid, ''				--
exec spu_SubgiftsendNew 2,  1200, 11, 'SysLogin', @gameid, ''				-- 부활석.
exec spu_SubgiftsendNew 2,  1201, 11, 'SysLogin', @gameid, ''				--
exec spu_SubgiftsendNew 2,  1201,  0, 'SysLogin', @gameid, ''				--
exec spu_SubgiftsendNew 2,  1600, 11, 'SysLogin', @gameid, ''				-- 합성시간단축.
exec spu_SubgiftsendNew 2,  1601, 11, 'SysLogin', @gameid, ''				--
exec spu_SubgiftsendNew 2,  1602,  0, 'SysLogin', @gameid, ''				--
exec spu_SubgiftsendNew 2,  1900, 11, 'SysLogin', @gameid, ''				-- 우정포인트.
exec spu_SubgiftsendNew 2,  1901, 11, 'SysLogin', @gameid, ''				--
exec spu_SubgiftsendNew 2,  1902,  0, 'SysLogin', @gameid, ''				--
exec spu_SubgiftsendNew 2,  2000, 11, 'SysLogin', @gameid, ''				-- 하트.
exec spu_SubgiftsendNew 2,  2001, 11, 'SysLogin', @gameid, ''				--
exec spu_SubgiftsendNew 2,  2002,  0, 'SysLogin', @gameid, ''				--
exec spu_SubgiftsendNew 2,  2100, 11, 'SysLogin', @gameid, ''				-- 긴급요청티켓.
exec spu_SubgiftsendNew 2,  2101, 11, 'SysLogin', @gameid, ''				--
exec spu_SubgiftsendNew 2,  2101,  0, 'SysLogin', @gameid, ''				--
exec spu_SubgiftsendNew 2,  2200, 11, 'SysLogin', @gameid, ''				-- 일반교배뽑기.
exec spu_SubgiftsendNew 2,  2201, 11, 'SysLogin', @gameid, ''				--
exec spu_SubgiftsendNew 2,  2202,  0, 'SysLogin', @gameid, ''				--
exec spu_SubgiftsendNew 2,  2300, 11, 'SysLogin', @gameid, ''				-- 프리미엄교배뽑기.
exec spu_SubgiftsendNew 2,  2301, 11, 'SysLogin', @gameid, ''				--
exec spu_SubgiftsendNew 2,  2302,  0, 'SysLogin', @gameid, ''				--
exec spu_SubgiftsendNew 2,  5000, 11, 'SysLogin', @gameid, ''				-- 캐쉬선물
exec spu_SubgiftsendNew 2,  5001, 11, 'SysLogin', @gameid, ''				--
exec spu_SubgiftsendNew 2,  5002,  0, 'SysLogin', @gameid, ''				--
exec spu_SubgiftsendNew 2,  5100, 11, 'SysLogin', @gameid, ''				-- 코인선물.
exec spu_SubgiftsendNew 2,  5101, 11, 'SysLogin', @gameid, ''				--
exec spu_SubgiftsendNew 2,  5102,  0, 'SysLogin', @gameid, ''				--
exec spu_SubgiftsendNew 2,  100000, 0, 'SysLogin', @gameid, ''				-- 펫.
exec spu_SubgiftsendNew 2,  100005, 0, 'SysLogin', @gameid, ''				--

*/

--delete from dbo.tItemInfo where itemcode in (606, 607, 608)

/*
declare @loop int set @loop = 127
delete from dbo.tGiftList where gameid = 'farm53944'
while @loop >= 100
	begin
		Exec Spu_Subgiftsend 2,  @loop, 'syslogin', 'farm53944', ''
		set @loop = @loop - 1
	end

*/
--select 'copy ' + rtrim(str(param12 )) + '.png' + rtrim(str(itemcode)) + '.png' from dbo.tItemInfo where category = 1010 order by itemcode asc


/*
alter table dbo.tGiftList add cnt			int 				default(0)

update dbo.tGiftList set cnt	= 0
*/


/*
alter table dbo.tNotice add serviceurl		varchar(512)	default('')
alter table dbo.tNotice add communityurl	varchar(512)	default('')

update dbo.tNotice set serviceurl	= '', communityurl = ''
*/


/*
select top 10 * from dbo.tUserMaster where blockstate = 1
select * from dbo.tUserMaster where condate > '2015-09-06' and blockstate = 1
select * from dbo.tUserMaster where condate > '2015-09-05' and blockstate = 1
select * from dbo.tUserMaster where condate > '2015-09-01' and blockstate = 1
select * from dbo.tUserMaster where regdate > '2015-09-01' and blockstate = 1

--update dbo.tUserMaster set blockstate = 0  where condate > '2015-09-06'
*/


/*
use GameMTBaseball
GO

declare @gameid 			varchar(20)
declare @framelv 			int
declare @gamecost 			int
declare @plusgamecost		int
declare @orggamecost		int
declare @comment 			varchar(256)		set @comment	= ''

-- 1. 선언하기.
declare curRouletteRecover Cursor for
select gameid, framelv, gamecost
	from dbo.tRouletteLogPerson
where
	framelv >= 51
	and kind = 1
	and gamecost > 0
	and writedate >= '2014-09-19' and writedate <= '2014-09-22 10:37'

-- 2. 커서오픈
open curRouletteRecover

-- 3. 커서 사용
Fetch next from curRouletteRecover into @gameid, @framelv, @gamecost
while @@Fetch_status = 0
	Begin
		if(@gamecost = 4500)
			begin
				set @plusgamecost = 2000

				update dbo.tUserMaster
					set
						@orggamecost = gamecost,
						gamecost = gamecost + @plusgamecost
				where gameid = @gameid


				set @comment = '교배 오류 코인 복구 안내\n\n[기존 보유금액 ' + ltrim(str(@orggamecost)) + '만 코인\n + 교배 비용 보상 ' + ltrim(str(@plusgamecost)) + '만 코인 \n = 현재 보유 ' + ltrim(str(@orggamecost + @plusgamecost)) + '만 코인]\n *확인용 메세지입니다.'
				Exec Spu_Subgiftsend 1, -1, '코인복구', @gameid, @comment
				--select 'DEBUG ', @comment comment
			end
		else if(@gamecost = 7500)
			begin
				set @plusgamecost = 3500

				update dbo.tUserMaster
					set
						@orggamecost = gamecost,
						gamecost = gamecost + @plusgamecost
				where gameid = @gameid

				set @comment = '교배 오류 코인 복구 안내\n\n[기존 보유금액 ' + ltrim(str(@orggamecost)) + '만 코인\n + 교배 비용 보상 ' + ltrim(str(@plusgamecost)) + '만 코인 \n = 현재 보유 ' + ltrim(str(@orggamecost + @plusgamecost)) + '만 코인]\n *확인용 메세지입니다.'
				Exec Spu_Subgiftsend 1, -1, '코인복구', @gameid, @comment
				--select 'DEBUG ', @comment comment
			end
		else if(@gamecost = 10000)
			begin
				set @plusgamecost = 3500

				update dbo.tUserMaster
					set
						@orggamecost = gamecost,
						gamecost = gamecost + @plusgamecost
				where gameid = @gameid

				set @comment = '교배 오류 코인 복구 안내\n\n[기존 보유금액 ' + ltrim(str(@orggamecost)) + '만 코인\n + 교배 비용 보상 ' + ltrim(str(@plusgamecost)) + '만 코인 \n = 현재 보유 ' + ltrim(str(@orggamecost + @plusgamecost)) + '만 코인]\n *확인용 메세지입니다.'
				--select 'DEBUG ', @comment comment
				Exec Spu_Subgiftsend 1, -1, '코인복구', @gameid, @comment
			end
		else if(@gamecost = 13000)
			begin
				set @plusgamecost = 5000

				update dbo.tUserMaster
					set
						@orggamecost = gamecost,
						gamecost = gamecost + @plusgamecost
				where gameid = @gameid

				set @comment = '교배 오류 코인 복구 안내\n\n[기존 보유금액 ' + ltrim(str(@orggamecost)) + '만 코인\n + 교배 비용 보상 ' + ltrim(str(@plusgamecost)) + '만 코인 \n = 현재 보유 ' + ltrim(str(@orggamecost + @plusgamecost)) + '만 코인]\n *확인용 메세지입니다.'
				--select 'DEBUG ', @comment comment
				Exec Spu_Subgiftsend 1, -1, '코인복구', @gameid, @comment
			end
		else if(@gamecost = 16000)
			begin
				set @plusgamecost = 6000

				update dbo.tUserMaster
					set
						@orggamecost = gamecost,
						gamecost = gamecost + @plusgamecost
				where gameid = @gameid

				set @comment = '교배 오류 코인 복구 안내\n\n[기존 보유금액 ' + ltrim(str(@orggamecost)) + '만 코인\n + 교배 비용 보상 ' + ltrim(str(@plusgamecost)) + '만 코인 \n = 현재 보유 ' + ltrim(str(@orggamecost + @plusgamecost)) + '만 코인]\n *확인용 메세지입니다.'
				--select 'DEBUG ', @comment comment
				Exec Spu_Subgiftsend 1, -1, '코인복구', @gameid, @comment
			end

		Fetch next from curRouletteRecover into @gameid, @framelv, @gamecost
	end

-- 4. 커서닫기
close curRouletteRecover
Deallocate curRouletteRecover
*/


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
select max(idx) from dbo.tSchoolUser where

select top 10
	-- backdateid,
	-- backschoolidx,
	backschoolrank,
	backuserrank,
	-- , backpoint
	*
	from dbo.tSchoolUser
where (backschoolrank >= 4 and backschoolrank <= 500)
	  and backuserrank <= 3
	  and backschoolidx != -1
	  and backuserrank != -1
	  and backdateid = '20140921'
--order by backschoolrank asc, backuserrank asc
*/

--exec spu_UserCreate 'farm',   '1052234j7g4k0l225439', 5, 0, 1, 'ukukukuk', 120, '01026403070', '', 'COk87e086Qg', '91386767984635713', 'oCBksPCjIXxc1BMNzZhMAw==', '', -1, '', -1


/*
		select u.backschoolrank, rank() over (partition by u.backschoolrank order by u.backpoint desc) as userrank2, gameid, m.cnt, m.totalpoint
		from dbo.tSchoolUser u
			 JOIN
			 dbo.tSchoolMaster m
			 ON u.schoolidx = m.schoolidx
		where u.backschoolrank > 0 and u.backpoint > 0 order by u.backschoolrank asc

*/


/*

-- SKT 버젼별 경험치 확인.
update dbo.tUserMaster set fame = 49395 where gameid = 'xxxx2'
select fame from dbo.tUserMaster where gameid = 'xxxx2'
exec spu_Login 'xxxx2', '049000s1i0n7t8445289', 5, 113, '', '', -1, -1			-- 정상유저
select fame from dbo.tUserMaster where gameid = 'xxxx2'

update dbo.tUserMaster set fame = 49395 where gameid = 'xxxx2'
select fame from dbo.tUserMaster where gameid = 'xxxx2'
exec spu_Login 'xxxx2', '049000s1i0n7t8445289', 5, 114, '', '', -1, -1			-- 정상유저
select fame from dbo.tUserMaster where gameid = 'xxxx2'

-- GG 버젼별 경험치 확인.
update dbo.tUserMaster set fame = 49395 where gameid = 'xxxx2'
select fame from dbo.tUserMaster where gameid = 'xxxx2'
exec spu_Login 'xxxx2', '049000s1i0n7t8445289', 5, 119, '', '', -1, -1			-- 정상유저
select fame from dbo.tUserMaster where gameid = 'xxxx2'

update dbo.tUserMaster set fame = 49395 where gameid = 'xxxx2'
select fame from dbo.tUserMaster where gameid = 'xxxx2'
exec spu_Login 'xxxx2', '049000s1i0n7t8445289', 5, 120, '', '', -1, -1			-- 정상유저
select fame from dbo.tUserMaster where gameid = 'xxxx2'


-- NHN 버젼별 경험치 확인.
update dbo.tUserMaster set fame = 49395 where gameid = 'xxxx2'
select fame from dbo.tUserMaster where gameid = 'xxxx2'
exec spu_Login 'xxxx2', '049000s1i0n7t8445289', 6, 107, '', '', -1, -1			-- 정상유저
select fame from dbo.tUserMaster where gameid = 'xxxx2'

update dbo.tUserMaster set fame = 49395 where gameid = 'xxxx2'
select fame from dbo.tUserMaster where gameid = 'xxxx2'
exec spu_Login 'xxxx2', '049000s1i0n7t8445289', 6, 108, '', '', -1, -1			-- 정상유저
select fame from dbo.tUserMaster where gameid = 'xxxx2'



-- iPhone 버젼별 경험치 확인.
update dbo.tUserMaster set fame = 49395 where gameid = 'xxxx2'
select fame from dbo.tUserMaster where gameid = 'xxxx2'
exec spu_Login 'xxxx2', '049000s1i0n7t8445289', 7, 116, '', '', -1, -1			-- 정상유저
select fame from dbo.tUserMaster where gameid = 'xxxx2'

update dbo.tUserMaster set fame = 49395 where gameid = 'xxxx2'
select fame from dbo.tUserMaster where gameid = 'xxxx2'
exec spu_Login 'xxxx2', '049000s1i0n7t8445289', 7, 117, '', '', -1, -1			-- 정상유저
select fame from dbo.tUserMaster where gameid = 'xxxx2'


*/
/*
declare @farmidx		int,
		@gameid_		varchar(20)
set @gameid_ = 'farm939124667'	-- test pc

--delete from dbo.tUserFarm where gameid = @gameid_ and itemcode >= 6944
select @farmidx = max(farmidx) from dbo.tUserFarm where gameid = @gameid_
--select @farmidx farmidx

--insert into dbo.tUserFarm(farmidx, gameid, itemcode)
select (rank() over(order by itemcode asc) + @farmidx) as farmidx, @gameid_, itemcode from dbo.tItemInfo
where subcategory = 69
	and itemcode not in (select itemcode from dbo.tUserFarm where gameid = @gameid_)
order by itemcode asc
*/

/*
delete from dbo.tGiftList where gameid in ('xxxx2')
delete from dbo.tUserItem where gameid = 'xxxx2' and listidx >= 28
 update dbo.tUserMaster set cashcost = 900000000, gamecost = 9900000, heart = 9000000, randserial = -1, bgcomposewt = getdate() - 10 where gameid = 'xxxx2'
 insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 28, 23, 1, 0, -1, 1, 5)
 insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 29, 23, 1, 0, -1, 1, 5)
 insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 30, 23, 1, 0, -1, 1, 5)
 insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 31, 23, 1, 0, -1, 1, 5)
 insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 32, 23, 1, 0, -1, 1, 5)

 insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 128, 121, 1, 0, -1, 1, 5)
 insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 129, 121, 1, 0, -1, 1, 5)
 insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 130, 121, 1, 0, -1, 1, 5)
 insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 131, 121, 1, 0, -1, 1, 5)
 insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 132, 121, 1, 0, -1, 1, 5)

 insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 228, 221, 1, 0, -1, 1, 5)
 insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 229, 221, 1, 0, -1, 1, 5)
 insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 230, 221, 1, 0, -1, 1, 5)
 insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 231, 221, 1, 0, -1, 1, 5)
 insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 232, 221, 1, 0, -1, 1, 5)


exec spu_AniCompose 'xxxx2', '049000s1i0n7t8445289', 2, 101224, 28, 29, 30, 31, 32, 999992, -1
exec spu_AniCompose 'xxxx2', '049000s1i0n7t8445289', 2, 101225, 128, 129, 130, 131, 132, 999993, -1
exec spu_AniCompose 'xxxx2', '049000s1i0n7t8445289', 2, 101226, 228, 229, 230, 231, 232, 999994, -1


exec spu_AniCompose 'xxxx2', '049000s1i0n7t8445289', 2, 101227, 28, 29, 30, 31, 32, 999992, -1
exec spu_AniCompose 'xxxx2', '049000s1i0n7t8445289', 2, 101233, 128, 129, 130, 131, 132, 999993, -1
exec spu_AniCompose 'xxxx2', '049000s1i0n7t8445289', 2, 101239, 228, 229, 230, 231, 232, 999994, -1
*/

/*
---------------------------------------------
-- 뽑기이벤트 관리 내용.
---------------------------------------------
IF OBJECT_ID (N'dbo.tSystemRouletteMan', N'U') IS NOT NULL
	DROP TABLE dbo.tSystemRouletteMan;
GO

create table dbo.tSystemRouletteMan(
	idx					int 				IDENTITY(1, 1),

	roulmarket			varchar(40)			default('1,2,3,4,5,6,7'),

	-- 특정동물 보상받기.
	roulflag			int					default(-1),
	roulstart			datetime			default('2014-01-01'),
	roulend				datetime			default('2024-01-01'),
	roulani1			int					default(-1),
	roulani2			int					default(-1),
	roulani3			int					default(-1),
	roulreward1			int					default(-1),
	roulreward2			int					default(-1),
	roulreward3			int					default(-1),
	roulname1			varchar(20)			default(''),
	roulname2			varchar(20)			default(''),
	roulname3			varchar(20)			default(''),

	-- 특정시간에 확률상승.
	roultimeflag		int					default(-1),
	roultimetime1		int					default(-1),
	roultimetime2		int					default(-1),
	roultimetime3		int					default(-1),

	-- 프리미엄 무료뽑기.
	pmgauageflag		int					default(-1),
	pmgauagepoint		int					default(100),
	pmgauagemax			int					default(10),

	--코멘트.
	comment				varchar(256)		default(''),
	writedate			datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tSystemRouletteMan_idx	PRIMARY KEY(idx)
)
-- select top 1 * from dbo.tSystemRouletteMan where roulmarket like '%5%' order by idx desc
-- insert into dbo.tSystemRouletteMan(roulmarket, roulflag,    roulstart,      roulend, roulani1, roulani2, roulani3, roulreward1, roulreward2, roulreward3,       roulname1,     roulname2,       roulname3, roultimeflag, roultimestart,  roultimeend, roultimetime1, roultimetime2, roultimetime3, comment)
-- values                            ('1,2,3,4,5,6,7',   1, '2013-09-01', '2023-09-01',      213,      112,       14,        5017,        5010,        5009, '얼짱 산양보상', '얼짱 양보상', '얼짱 젖소보상',            1,  '2013-09-01', '2023-09-01',            12,            18,            23, '최초내용')
-- update dbo.tSystemRouletteMan set roulflag = -1 where idx = 3
*/


/*
update dbo.tItemInfo set param9 = 500 where subcategory = 60
--update dbo.tItemInfo set param9 = 600 where subcategory = 60 and itemcode >= 6007
--update dbo.tItemInfo set param9 = 700 where subcategory = 60 and itemcode >= 6008

select * from dbo.tItemInfo where subcategory = 60
*/
--insert into dbo.tKakaoMaster(kakaotalkid,   kakaouserid,                 gameid,   kakaodata, writedate)
--values(						'BqBAg4NAoAY', '89825532910935601', 'farm642535466', 1, '2014-07-18 22:52')

/*

------------------------------------------
-- 복귀 처음
-- xxxx2(나)
-- xxxxx(친구들)
------------------------------------------
delete from dbo.tGiftList where gameid in ('xxxx2', 'xxxx3', 'xxxx4', 'xxxx5', 'xxxx6')
-- 친구상태를 세팅
-- update dbo.tSystemInfo set rtnflag = 1
update dbo.tUserMaster set condate = getdate(),      rtndate = getdate(),       rtngameid = ''      where gameid = 'xxxx3'	-- 활동중.
update dbo.tUserMaster set condate = getdate() - 30, rtndate = getdate(),       rtngameid = ''      where gameid = 'xxxx4'	-- 이미요청.
update dbo.tUserMaster set condate = getdate() - 30, rtndate = getdate() - 0.5, rtngameid = 'xxxx2' where gameid = 'xxxx5'	-- 장기 > 만기.
update dbo.tUserMaster set condate = getdate() - 30, rtndate = getdate() - 2,   rtngameid = 'xxxx2' where gameid = 'xxxx6'	-- 장기 > 스스로.

--exec spu_LoginTest 'xxxx2', '049000s1i0n7t8445289', 1, 110, '', '', -1, -1			-- 정상유저
--exec spu_LoginTest 'xxxx3', '049000s1i0n7t8445289', 1, 110, '', '', -1, -1			-- 정상유저
--exec spu_LoginTest 'xxxx4', '049000s1i0n7t8445289', 1, 110, '', '', -1, -1			-- 정상유저
--exec spu_LoginTest 'xxxx5', '049000s1i0n7t8445289', 1, 110, '', '', -1, -1			-- 정상유저
--exec spu_LoginTest 'xxxx6', '049000s1i0n7t8445289', 1, 110, '', '', -1, -1			-- 정상유저


------------------------------------------
-- 진행중
------------------------------------------
update dbo.tUserMaster set attenddate = getdate() - 1, rtnstep = 1, rtnplaycnt = 1 where gameid = 'xxxx5'
exec spu_LoginTest 'xxxx5', '049000s1i0n7t8445289', 1, 110, '', '', -1, -1			-- 정상유저

update dbo.tUserMaster set attenddate = getdate() - 1, rtnstep = 1, rtnplaycnt = 5 where gameid = 'xxxx5'
exec spu_LoginTest 'xxxx5', '049000s1i0n7t8445289', 1, 110, '', '', -1, -1			-- 정상유저

update dbo.tUserMaster set attenddate = getdate() - 1, rtnstep = 14, rtnplaycnt = 4 where gameid = 'xxxx5'
exec spu_LoginTest 'xxxx5', '049000s1i0n7t8445289', 1, 110, '', '', -1, -1			-- 정상유저

update dbo.tUserMaster set attenddate = getdate() - 1, rtnstep = 14, rtnplaycnt = 5 where gameid = 'xxxx5'
exec spu_LoginTest 'xxxx5', '049000s1i0n7t8445289', 1, 110, '', '', -1, -1			-- 정상유저



*/


/*
alter table dbo.tDayLogInfoStatic add rtnrequest	int				default(0)
alter table dbo.tDayLogInfoStatic add rtnrejoin		int				default(0)

update dbo.tDayLogInfoStatic set rtnrequest	= 0, rtnrejoin = 0
*/

/*
alter table dbo.tSystemInfo add 	rtnflag				int					default(0)

update dbo.tSystemInfo set rtnflag	= 0
*/

/*
alter table dbo.tUserMaster add 	rtngameid	varchar(20)				default('')
alter table dbo.tUserMaster add 	rtndate		datetime				default(getdate() - 1)
alter table dbo.tUserMaster add 	rtnstep		int						default(-1)
alter table dbo.tUserMaster add 	rtnplaycnt	int						default(0)


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


-- 삭제된 유저 삭제하기.


/*
-- 푸쉬 로고 삭제하는 부분
	declare @idx 			int
	declare @idx2 			int


					set @idx = 0
					select @idx  = max(idx) from dbo.tUserPushiPhoneLog
					select @idx2 = min(idx) from dbo.tUserPushiPhoneLog
					while(@idx > @idx2)
						begin
							delete from dbo.tUserPushiPhoneLog
							where idx >= @idx - 1000 and idx <= @idx
							set @idx =  @idx - 1000
						end


					set @idx = 0
					select @idx  = max(idx) from dbo.tUserPushAndroidLog
					select @idx2 = min(idx) from dbo.tUserPushAndroidLog
					while(@idx > @idx2)
						begin
							delete from dbo.tUserPushAndroidLog
							where idx >= @idx - 1000 and idx <= @idx
							set @idx =  @idx - 1000
						end

select MAX(idx) - MIN(idx) from dbo.tUserPushiPhoneLog
select MAX(idx) - MIN(idx) from dbo.tUserPushAndroidLog
*/

/*
alter table dbo.tUserMaster add 	cashpoint	int						default(0)

declare @idx int set @idx = 0
select @idx = max(idx) from dbo.tUserMaster
while(@idx > -1000)
	begin
		update dbo.tUserMaster
			set
				cashpoint	= 0
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


/*
alter table dbo.tSystemInfo add 	kakaoinvite01		int					default(2000)
alter table dbo.tSystemInfo add 	kakaoinvite02		int					default(1005)
alter table dbo.tSystemInfo add 	kakaoinvite03		int					default(6)
alter table dbo.tSystemInfo add 	kakaoinvite04		int					default(100003)


update dbo.tSystemInfo set kakaoinvite01 = 2000, kakaoinvite02 = 1005, kakaoinvite03 = 6, kakaoinvite04 = 100003
*/
/*
alter table dbo.tUserMaster add 	constate	int						default(0)

declare @idx int set @idx = 0
select @idx = max(idx) from dbo.tUserMaster
while(@idx > -1000)
	begin
		update dbo.tUserMaster
			set
				constate	= 0
		where idx >= @idx - 1000 and idx <= @idx
		set @idx =  @idx - 1000
	end
*/





/*
exec spu_FarmD 27, 12, -1, -1, -1, -1, -1, -1, -1, -1, '사과쪽지', '', 'Naver패치가 구글로 연결되었습니다. 다시 네이버에서 받아주세요.', '', '', '', '', '', '', ''	-- 메세지보내기
exec spu_FarmD 27, 12, -1, -1, -1, -1, -1, -1, -1, -1, '이용에 불편을 드려 죄송합니다.', 'farm635061189', 'Naver패치가 구글로 연결되었습니다. 다시 네이버에서 받아주세요.', '', '', '', '', '', '', ''	-- 메세지보내기
*/

/*
alter table dbo.tUserBeforeInfo add 	marketnew	int						default(1)

update dbo.tUserBeforeInfo set marketnew	= 5


exec spu_Login 'xxxx2', '049000s1i0n7t8445289', 1, 110, '', '', -1, -1			-- 정상유저
exec spu_Login 'xxxx2', '049000s1i0n7t8445289', 5, 116, '', '', -1, -1			-- 정상유저
exec spu_Login 'xxxx2', '049000s1i0n7t8445289', 6, 102, '', '', -1, -1			-- 정상유저
exec spu_Login 'xxxx2', '049000s1i0n7t8445289', 7, 112, '', '', -1, -1			-- 정상유저


select * from dbo.tUserBeforeInfo
*/

/*
-- 이동 이력 기록( 경험치, 레벨, 마켓, 시간)

IF OBJECT_ID (N'dbo.tUserBeforeInfo', N'U') IS NOT NULL
	DROP TABLE dbo.tUserBeforeInfo;
GO

create table dbo.tUserBeforeInfo(
	--(일반정보)
	idx			int 					IDENTITY(1, 1),
	gameid		varchar(20),
	market		int						default(1),				-- (구매처코드) MARKET_SKT
	version		int						default(101),			-- 클라버젼

	fame		int						default(0),
	famelv		int						default(1),
	famelvbest	int						default(1),
	gameyear	int						default(2013),
	gamemonth	int						default(3),
	changedate	datetime				default(getdate()),
	-- Constraint
	CONSTRAINT pk_tUserBeforeInfo_gameid	PRIMARY KEY(idx)
)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserBeforeInfo_gameid_idx')
	DROP INDEX tUserBeforeInfo.idx_tUserBeforeInfo_gameid_idx
GO
CREATE INDEX idx_tUserBeforeInfo_gameid_idx ON tUserBeforeInfo (gameid, idx)
GO
-- if(@market != @market_)
--	begin
--		insert into dbo.tUserBeforeInfo(gameid,  market,  version,  fame,  famelv,  gameyear,  gamemonth)
--		values(                        @gameid, @market, @version, @fame, @famelv, @gameyear, @gamemonth)
--	end
*/

/*
alter table dbo.tYabauLogPerson add 	remaingamecost		int					default(0)
alter table dbo.tYabauLogPerson add 	remaincashcost		int					default(0)

update dbo.tYabauLogPerson set remaingamecost	= 0, remaincashcost = 0
*/

/*
alter table dbo.tYabauLogPerson add 	yabaucount		int					default(0)

update dbo.tYabauLogPerson set yabaucount	= 0
*/



/*
---------------------------------------------
-- 	주사위 로그 > 개인자료
---------------------------------------------
IF OBJECT_ID (N'dbo.tYabauLogPerson', N'U') IS NOT NULL
	DROP TABLE dbo.tYabauLogPerson;
GO

create table dbo.tYabauLogPerson(
	idx				int				identity(1, 1),

	gameid			varchar(20),
	itemcode		int				default(-1),
	kind			int				default(1),			-- 주사위의 모드가 들어감.
	framelv			int,

	yabaustep		int				default(-1),
	pack11			int				default(-1),
	pack21			int				default(-1),
	pack31			int				default(-1),
	pack41			int				default(-1),
	pack51			int				default(-1),
	pack61			int				default(-1),
	result			int				default(-1),
	cashcost		int				default(0),
	gamecost		int				default(0),
	yabauchange		int				default(0),

	writedate		datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tYabauLogPerson_idx PRIMARY KEY(idx)
)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tYabauLogPerson_gameid_idx')
	DROP INDEX tYabauLogPerson.idx_tYabauLogPerson_gameid_idx
GO
CREATE INDEX idx_tYabauLogPerson_gameid_idx ON tYabauLogPerson (gameid, idx)
GO
-- select top 100 * from dbo.tYabauLogPerson where gameid = 'xxxx2' order by idx desc
-- MODE_YABAU_RESET
-- insert into dbo.tYabauLogPerson(gameid, itemcode, kind, framelv, gamecost) values('xxxx2', 70002, 1, 20, 1700)
-- MODE_YABAU_REWARD
-- insert into dbo.tYabauLogPerson(gameid, itemcode, kind, framelv, pack11, pack21, pack31, pack41, pack51, pack61, yabaustep) values('xxxx2', 70002, 1, 20, 1, 1, 1, -1, -1, -1, 3)
-- MODE_YABAU_NORMAL, MODE_YABAU_PREMINUM
-- insert into dbo.tYabauLogPerson(gameid, itemcode, kind, framelv, pack11, pack21, pack31, pack41, pack51, pack61, result, cashcost, gamecost) values('xxxx2', 70002, 1, 20, 1, 1, 1, -1, -1, -1, 1, 1, 0)
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
declare @itemcode int 			set @itemcode 	= 5108				-- 14000코인 x 3박스
declare @eventname varchar(20)	set @eventname	= '긴급패치보상'
declare @gameid varchar(20)

-- 1. 선언하기.
declare curENCheck Cursor for
--select gameid from dbo.tUserMaster where gameid = 'xxxx2' and  famelv >= 50 and market in (5, 6) and condate >= '2014-07-25 18:50' -- and condate <= '2014-07-26 16:00'
select gameid from dbo.tUserMaster where famelv >= 50 and market in (5, 6) and condate >= '2014-07-25 18:50' -- and condate <= '2014-07-26 16:00'

-- 2. 커서오픈
open curENCheck

-- 3. 커서 사용
Fetch next from curENCheck into @gameid
while @@Fetch_status = 0
	Begin
		exec spu_SubGiftSend 2,   @itemcode, @eventname, @gameid, ''
		exec spu_SubGiftSend 2,   @itemcode, @eventname, @gameid, ''
		exec spu_SubGiftSend 2,   @itemcode, @eventname, @gameid, ''

		Fetch next from curENCheck into @gameid
	end

-- 4. 커서닫기
close curENCheck
Deallocate curENCheck
*/



/*
-- PTC_LOGIN > 구버젼 > 경험치 누적(51:3795)를 초과하면 3794로 세팅하기.
-- Google, Naver 신버젼
-- SKT, iPhone
-- 50렙 SKT, iPhone
select famelv, fame, * from dbo.tUserMaster where fame > 3795 and market in (1, 7)
-- update dbo.tUserMaster set fame = 3795 - 1 where fame > 3795 and market in (1, 7)
*/


/*
select famelv, fame, * from dbo.tUserMaster where gameid = 'farm599057333'
select famelv, fame, * from dbo.tUserMaster where fame > 5195 order by 2 desc
--update dbo.tUserMaster set famelv = 5120 where fame > 5195 and famelv >= 50
--50 3395	~ 3794
--51 3795	~ 4394
--52 4395	~ 5194
--53 5195	~ 6194
--54 6195	~ 7394
-- update dbo.tUserMaster set famelv = 51 where fame >= 3795 and fame <= 4394
-- update dbo.tUserMaster set famelv = 52 where fame >= 4395 and fame <= 5194
-- update dbo.tUserMaster set famelv = 53 where fame >= 5195 and fame <= 6194


select famelv, fame, * from dbo.tUserMaster where fame > 3795


-- 50렙
select famelv, fame, * from dbo.tUserMaster where fame > 3795
-- update dbo.tUserMaster set fame = 3795 - 1, famelv = 50 where fame > 3795


-- 50렙 SKT, iPhone
select famelv, fame, * from dbo.tUserMaster where fame > 3795 and market in (1, 7)
-- update dbo.tUserMaster set fame = 3795 - 1, famelv = 50 where fame > 3795 and market in (1, 7)

-- 52렙
select famelv, fame, * from dbo.tUserMaster where fame > 5195
select famelv, fame, * from dbo.tUserMaster where fame > 5195 and condate < '2014-07-26 1:00'
-- update dbo.tUserMaster set fame = 5195 - 1 where fame > 5195 and condate < '2014-07-26 09:00'
-- update dbo.tUserMaster set fame = 5195 - 1 where fame > 5195



-- 55렙
select famelv, fame, * from dbo.tUserMaster where fame > 7395
-- update dbo.tUserMaster set fame = 7395 - 1 where fame > 7395

select itemcode, gameid from dbo.tUserFarm where itemcode >= 6930 and buystate = 1 order by 1 desc
select distinct gameid from dbo.tUserFarm where itemcode >= 6930 and buystate = 1
select distinct gameid from dbo.tUserFarm where itemcode >= 6931 and buystate = 1
select distinct gameid from dbo.tUserFarm where itemcode >= 6932 and buystate = 1

--6933~6935까지 산 애들은 52로 강제 수정해도 무방합니다
select * from dbo.tUserFarm where itemcode >= 6933 and buystate = 1
select * from dbo.tUserFarm where itemcode = 6934 and buystate = 1
select * from dbo.tUserFarm where itemcode = 6935 and buystate = 1

-- 6939 이상의 목장 구매한 애들은 다시 봐야하구요
select * from dbo.tUserFarm where itemcode >= 6939 and buystate = 1

-- 6936~6938까지 산 애들이 있으면 걔네들은 55로 수정해 주시면 될거구요
select * from dbo.tUserFarm where itemcode >= 6936 and itemcode <= 6938 and buystate = 1




-- alter table dbo.tUserMaster add famebg			int					default(0)
--declare @loop int set @loop = 1000
--declare @loopmax int set @loopmax = 0
--select @loopmax = max(idx) from dbo.tUserMaster
--
--while(@loop < @loopmax)
--	begin
--		update dbo.tUserMaster set famebg = fame where idx >= @loop - 1000 and idx <= @loop
--		set @loop = @loop + 1000
--	end
*/


/*
update dbo.tUserMaster set famelvbest = 50 where famelvbest > 50
select count(*) from dbo.tUserMaster where famelvbest > 50
*/

/*
exec spu_SchoolRank  2, -1, ''


	declare @schoolname		varchar(128)
	declare @schoolidx		int						set @schoolidx		= -1
			select @schoolname = schoolname from dbo.tSchoolBank where schoolidx = @schoolidx

			select rank() over(order by point desc) userrank, @schoolname schoolname, * from dbo.tSchoolUser
			where schoolidx = @schoolidx and schoolidx != -1
			order by point desc
*/


/*
select 'exec spu_SubGiftSend 2,     ' + rtrim(str(itemcode)) + ', ''프리미엄'', @gameid, ''''' from dbo.tRouletteLogTotalSub
where dateid8 = '20140725'
order by premiumcnt desc, normalcnt desc

select 'exec spu_SubGiftSend 2,     ' + rtrim(str(itemcode)) + ', ''일반교배'', @gameid, ''''' from dbo.tRouletteLogTotalSub
where dateid8 = '20140725'
order by premiumcnt desc, normalcnt desc

declare @gameid varchar(20) set @gameid = 'farm621981767'
exec spu_SubGiftSend 2,              4, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,            101, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,              5, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,              3, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,            100, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,              2, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,            102, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,            200, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,              8, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,            104, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,            202, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,            201, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,              7, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,              6, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,            103, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,            105, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,            203, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,              9, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,            106, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,              1, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,            204, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,             10, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,            107, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,            205, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,             11, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,            108, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,            206, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,            207, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,             12, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,            109, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,            208, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,             13, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,            110, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,             14, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,            111, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,            209, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,             15, '일반교배', @gameid, ''

exec spu_SubGiftSend 2,             16, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,            108, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,            206, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,             11, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,             14, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,            110, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,            208, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,            209, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,            111, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,             13, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,             12, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,             15, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,            109, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,            207, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,            113, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,            112, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,            115, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,            211, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,             20, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,            210, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,             21, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,            212, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,            114, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,            119, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,            215, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,            120, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,            213, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,             23, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,            121, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,            220, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,            219, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,            214, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,            221, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,            117, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,             17, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,            217, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,            107, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,            104, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,            100, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,              7, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,              8, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,              3, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,              6, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,            101, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,            103, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,            200, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,            201, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,            202, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,            203, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,            102, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,              4, '프리미엄', @gameid, ''

*/

/*
select         * from dbo.tUserYabauMonth
select         * from dbo.tUserYabauTotalSub

---------------------------------------------
-- 	구매했던 로그(월별 누적)
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserYabauMonth', N'U') IS NOT NULL
	DROP TABLE dbo.tUserYabauMonth;
GO

create table dbo.tUserYabauMonth(
	idx				int				identity(1, 1),

	dateid6			char(6),							-- 201012
	itemcode		int,

	step1			int				default(0),
	step2			int				default(0),
	step3			int				default(0),
	step4			int				default(0),
	step5			int				default(0),
	step6			int				default(0),

	-- Constraint
	CONSTRAINT	pk_tUserYabauMonth_dateid6_itemcode	PRIMARY KEY(dateid6, itemcode)
)
-- select         * from dbo.tUserYabauMonth where dateid6 = '201407' and itemcode = 70008
-- insert into dbo.tUserYabauMonth(dateid6, itemcode) values('201407', 70008)
-- update dbo.tUserYabauMonth set step1 = step1 + 1 where dateid6 = '201407' and itemcode = 70008


---------------------------------------------
-- 	구매했던 로그(월별 Sub)
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserYabauTotalSub', N'U') IS NOT NULL
	DROP TABLE dbo.tUserYabauTotalSub;
GO

create table dbo.tUserYabauTotalSub(
	idx				int				identity(1, 1),

	dateid8			char(8),							-- 20101210
	itemcode		int,

	step1			int				default(0),
	step2			int				default(0),
	step3			int				default(0),
	step4			int				default(0),
	step5			int				default(0),
	step6			int				default(0),

	-- Constraint
	CONSTRAINT	pk_tUserYabauTotalSub_dateid8_itemcode	PRIMARY KEY(dateid8, itemcode)
)
-- select         * from dbo.tUserYabauTotalSub where dateid8 = '20140724' and itemcode = 70008
-- insert into dbo.tUserYabauTotalSub(dateid8, itemcode) values('20140724', 70008)
-- update dbo.tUserYabauTotalSub set step1 = step1 + 1 where dateid8 = '20140724' and itemcode = 70008
*/

/*
select 'exec spu_SubGiftSend 2,     ' + rtrim(str(itemcode)) + ', ''프리미엄'', @gameid, ''''' from dbo.tRouletteLogTotalSub
where dateid8 = '20140724'
order by premiumcnt desc, normalcnt desc

select 'exec spu_SubGiftSend 2,     ' + rtrim(str(itemcode)) + ', ''일반교배'', @gameid, ''''' from dbo.tRouletteLogTotalSub
where dateid8 = '20140724'
order by premiumcnt desc, normalcnt desc

declare @gameid varchar(20) set @gameid = 'farm939112937'
exec spu_SubGiftSend 2,              4, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,            101, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,              5, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,              3, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,            100, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,              2, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,            102, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,            200, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,              8, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,            104, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,            202, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,            201, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,              7, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,              6, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,            103, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,            105, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,            203, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,              9, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,            106, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,              1, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,            204, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,             10, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,            107, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,            205, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,             11, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,            108, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,            206, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,            207, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,             12, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,            109, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,            208, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,             13, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,            110, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,             14, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,            111, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,            209, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,             15, '일반교배', @gameid, ''


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
-- 이름변경
update dbo.tItemInfo set itemname = '얼음 냉기 젖소' where itemcode = 17
update dbo.tItemInfo set itemname = '분홍 젖소무늬 캡' where itemcode = 1429
update dbo.tItemInfo set itemname = '주사위교체' where itemcode = 80000
update dbo.tItemInfo set itemname = '합성하늘색 젖소' where itemcode = 101002
update dbo.tItemInfo set itemname = '합성노랑 젖소' where itemcode = 101003
update dbo.tItemInfo set itemname = '합성검은 소' where itemcode =101004
update dbo.tItemInfo set itemname = '합성분홍점박이 젖소' where itemcode =101005
update dbo.tItemInfo set itemname = '합성노랑점박이 젖소' where itemcode =101006
update dbo.tItemInfo set itemname = '합성파란꽃무늬 젖소' where itemcode =101007
update dbo.tItemInfo set itemname = '합성분홍꽃무늬 젖소' where itemcode =101008
update dbo.tItemInfo set itemname = '합성연보라 꽃무늬 젖소' where itemcode =101009
update dbo.tItemInfo set itemname = '합성빗살무늬 젖소' where itemcode =101010
update dbo.tItemInfo set itemname = '합성터프한 젖소' where itemcode =101011
update dbo.tItemInfo set itemname = '합성봉제 인형 소' where itemcode =101012
update dbo.tItemInfo set itemname = '합성세일러 젖소' where itemcode =101013
update dbo.tItemInfo set itemname = '합성얼짱 젖소' where itemcode =101014
update dbo.tItemInfo set itemname = '합성무법자 젖소' where itemcode =101015
update dbo.tItemInfo set itemname = '합성갈색 양' where itemcode =101101
update dbo.tItemInfo set itemname = '합성분홍 양' where itemcode =101102
update dbo.tItemInfo set itemname = '합성검은양' where itemcode =101103
update dbo.tItemInfo set itemname = '합성노란별무늬 양' where itemcode =101104
update dbo.tItemInfo set itemname = '합성파란별무늬 양' where itemcode =101105
update dbo.tItemInfo set itemname = '합성노랑 체크무늬 양' where itemcode =101106
update dbo.tItemInfo set itemname = '합성분홍 체크무늬 양' where itemcode =101107
update dbo.tItemInfo set itemname = '합성하늘색 체크무늬 양' where itemcode =101108
update dbo.tItemInfo set itemname = '합성봉제 인형 양' where itemcode =101109
update dbo.tItemInfo set itemname = '합성늑대가죽 양' where itemcode =101110
update dbo.tItemInfo set itemname = '합성시크한 검은 양' where itemcode =101111
update dbo.tItemInfo set itemname = '합성얼짱 양' where itemcode =101112
update dbo.tItemInfo set itemname = '합성뭉게뭉게 구름 양' where itemcode =101113
update dbo.tItemInfo set itemname = '합성황금뿔 양' where itemcode =101114
update dbo.tItemInfo set itemname = '합성갈색 산양' where itemcode =101201
update dbo.tItemInfo set itemname = '합성분홍 산양' where itemcode =101202
update dbo.tItemInfo set itemname = '합성검은 산양' where itemcode =101203
update dbo.tItemInfo set itemname = '합성하얀 점박이 산양' where itemcode =101204
update dbo.tItemInfo set itemname = '합성노랑 점박이 산양' where itemcode =101205
update dbo.tItemInfo set itemname = '합성하늘색 러블리 산양' where itemcode =101206
update dbo.tItemInfo set itemname = '합성분홍 러블리 산양' where itemcode =101207
update dbo.tItemInfo set itemname = '합성보라 러블리 산양' where itemcode =101208
update dbo.tItemInfo set itemname = '합성봉제 인형 산양' where itemcode =101209
update dbo.tItemInfo set itemname = '합성빵봉투 산양' where itemcode =101210
update dbo.tItemInfo set itemname = '합성팔랑팔랑 산양' where itemcode =101211
update dbo.tItemInfo set itemname = '합성루돌프 산양' where itemcode =101212
update dbo.tItemInfo set itemname = '합성얼짱 산양' where itemcode =101213
update dbo.tItemInfo set itemname = '합성조로 산양' where itemcode =101214

*/





/*
declare @gameid varchar(20) set @gameid = 'farm939102895'
exec spu_SubGiftSend 2,     4, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,     101, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,     5, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,     2, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,     100, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,     3, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,     102, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,     200, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,     104, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,     202, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,     8, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,     7, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,     201, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,     6, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,     203, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,     103, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,     105, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,     9, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,     106, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,     1, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,     204, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,     10, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,     107, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,     205, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,     108, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,     11, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,     206, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,     207, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,     109, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,     12, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,     208, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,     13, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,     14, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,     110, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,     15, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,     111, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,     209, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,     210, '일반교배', @gameid, ''
exec spu_SubGiftSend 2,     112, '일반교배', @gameid, ''



exec spu_SubGiftSend 2,     115, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,     211, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,     113, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,     20, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,     14, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,     108, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,     209, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,     16, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,     15, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,     11, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,     206, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,     111, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,     110, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,     12, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,     208, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,     13, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,     109, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,     207, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,     114, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,     21, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,     212, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,     112, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,     210, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,     215, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,     119, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,     23, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,     213, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,     120, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,     219, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,     121, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,     220, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,     221, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,     214, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,     217, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,     17, '프리미엄', @gameid, ''
exec spu_SubGiftSend 2,     117, '프리미엄', @gameid, ''
*/


/*
exec spu_SubGiftSend 2,   712, 'SysLogin', 'xxxx2', ''
exec spu_SubGiftSend 2,   713, 'SysLogin', 'xxxx2', ''
exec spu_SubGiftSend 2,   714, 'SysLogin', 'xxxx2', ''
exec spu_SubGiftSend 2,   715, 'SysLogin', 'xxxx2', ''
exec spu_SubGiftSend 2,   716, 'SysLogin', 'xxxx2', ''


exec spu_SubGiftSend 2,   812, 'SysLogin', 'xxxx2', ''
exec spu_SubGiftSend 2,   813, 'SysLogin', 'xxxx2', ''
exec spu_SubGiftSend 2,   814, 'SysLogin', 'xxxx2', ''
exec spu_SubGiftSend 2,   815, 'SysLogin', 'xxxx2', ''
exec spu_SubGiftSend 2,   816, 'SysLogin', 'xxxx2', ''

exec spu_SubGiftSend 2,   1026, 'SysLogin', 'xxxx2', ''
exec spu_SubGiftSend 2,   1027, 'SysLogin', 'xxxx2', ''
exec spu_SubGiftSend 2,   1028, 'SysLogin', 'xxxx2', ''
exec spu_SubGiftSend 2,   1029, 'SysLogin', 'xxxx2', ''
exec spu_SubGiftSend 2,   1030, 'SysLogin', 'xxxx2', ''

exec spu_SubGiftSend 2,   1113, 'SysLogin', 'xxxx2', ''
exec spu_SubGiftSend 2,   1114, 'SysLogin', 'xxxx2', ''
exec spu_SubGiftSend 2,   1115, 'SysLogin', 'xxxx2', ''
exec spu_SubGiftSend 2,   1116, 'SysLogin', 'xxxx2', ''
exec spu_SubGiftSend 2,   1117, 'SysLogin', 'xxxx2', ''

declare @loop int set @loop = 57817038
declare @loopmax int set @loopmax = 57817042
while(@loop <= @loopmax)
	begin
		exec spu_GiftGain 'xxxx2', '049000s1i0n7t8445289', -3, @loop, -1, -1, -1, -1
		set @loop = @loop + 1
	end


-- 늑대용 공포탄 	: 701 < 712 ~ 716
-- 일반 치료제 		: 801 < 812 ~ 816
-- 농부				: 1001 < 1026 ~ 1030
-- 일반 촉진제		: 1102 < 1113 ~ 1117
*/


/*
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tSchoolUser_joindate')
    DROP INDEX tSchoolUser.idx_tSchoolUser_joindate
GO
CREATE INDEX idx_tSchoolUser_joindate ON tSchoolUser (joindate)
GO
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
update dbo.tItemInfo set itemname = '공주병 젖소' where itemcode = 20
update dbo.tItemInfo set itemname = '주황색 공주병 젖소' where itemcode = 21
update dbo.tItemInfo set itemname = '보라색 공주병 젖소' where itemcode = 23
update dbo.tItemInfo set itemname = '쑥대머리 젖소' where itemcode = 24
update dbo.tItemInfo set itemname = '썬글라스 젖소' where itemcode = 25

update dbo.tItemInfo set itemname = '뭉게뭉게 구름 양' where itemcode = 113
update dbo.tItemInfo set itemname = '황금뿔 양' where itemcode = 114
update dbo.tItemInfo set itemname = '황금털 양' where itemcode = 115
update dbo.tItemInfo set itemname = '흑인 양' where itemcode = 116
update dbo.tItemInfo set itemname = '별빛털 양' where itemcode = 117
update dbo.tItemInfo set itemname = '솜사탕 양' where itemcode = 119
update dbo.tItemInfo set itemname = '분홍 솜사탕 양' where itemcode = 120
update dbo.tItemInfo set itemname = '보라 솜사탕 양' where itemcode = 121
update dbo.tItemInfo set itemname = '노란 머리띠 양' where itemcode = 122
update dbo.tItemInfo set itemname = '사탕 양' where itemcode = 123

update dbo.tItemInfo set itemname = '얼음뿔 산양' where itemcode = 215
update dbo.tItemInfo set itemname = '머플러핏산양' where itemcode = 216
update dbo.tItemInfo set itemname = '방울방울 산양' where itemcode = 217
update dbo.tItemInfo set itemname = '후드 산양' where itemcode = 219
update dbo.tItemInfo set itemname = '노란 후드 산양' where itemcode = 220
update dbo.tItemInfo set itemname = '파란 후드 산양' where itemcode = 221
update dbo.tItemInfo set itemname = '회색 갈기 산양' where itemcode = 222
update dbo.tItemInfo set itemname = '황금 산양' where itemcode = 223

update dbo.tItemInfo set param10 = '공주병 젖소 모음' where itemcode = 81820
update dbo.tItemInfo set param10 = '솜사탕 양 모음' where itemcode = 81821
update dbo.tItemInfo set param10 = '후드 산양 모음' where itemcode = 81822

update dbo.tItemInfo set itemname = '합성공주병 젖소' where itemcode = 101215
update dbo.tItemInfo set itemname = '합성주황색공주병 젖소' where itemcode = 101216
update dbo.tItemInfo set itemname = '합성보라색공주병 젖소' where itemcode = 101217
update dbo.tItemInfo set itemname = '합성솜사탕 양' where itemcode = 101218
update dbo.tItemInfo set itemname = '합성분홍솜사탕 양' where itemcode = 101219
update dbo.tItemInfo set itemname = '합성보라솜사탕 양' where itemcode = 101220
update dbo.tItemInfo set itemname = '합성후드 산양' where itemcode = 101221
update dbo.tItemInfo set itemname = '합성노란후드 산양' where itemcode = 101222
update dbo.tItemInfo set itemname = '합성파란후드 산양' where itemcode = 101223
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
48	3235	80
49	3315	80
50	3395	400
51	3795	600
52	4395	800
53	5195	1000
54	6195	1200
55	7395	1400
56	8795	1600
57	10395	1800
58	12195	2000
59	14195	2200
60	16395	2400
*/
/*
-- exec spu_FarmD 19, 65,  4,  1, -1, -1, -1, -1, -1, -1, 'xxxx2', 'admin', '', '', '', '', '', '', '', ''			--      명성도
-- exec spu_FarmD 19, 65,  4,  9, -1, -1, -1, -1, -1, -1, 'xxxx2', 'admin', '', '', '', '', '', '', '', ''			--      명성도
-- exec spu_FarmD 19, 65,  4, 10, -1, -1, -1, -1, -1, -1, 'xxxx2', 'admin', '', '', '', '', '', '', '', ''			--      명성도
-- exec spu_FarmD 19, 65,  4, 11, -1, -1, -1, -1, -1, -1, 'xxxx2', 'admin', '', '', '', '', '', '', '', ''			--      명성도
-- exec spu_FarmD 19, 65,  4, 24, -1, -1, -1, -1, -1, -1, 'xxxx2', 'admin', '', '', '', '', '', '', '', ''			--      명성도
-- exec spu_FarmD 19, 65,  4, 25, -1, -1, -1, -1, -1, -1, 'xxxx2', 'admin', '', '', '', '', '', '', '', ''			--      명성도
-- exec spu_FarmD 19, 65,  4, 45, -1, -1, -1, -1, -1, -1, 'xxxx2', 'admin', '', '', '', '', '', '', '', ''			--      명성도
-- exec spu_FarmD 19, 65,  4, 1074, -1, -1, -1, -1, -1, -1, 'xxxx2', 'admin', '', '', '', '', '', '', '', ''			--      명성도
-- exec spu_FarmD 19, 65,  4, 1075, -1, -1, -1, -1, -1, -1, 'xxxx2', 'admin', '', '', '', '', '', '', '', ''			--      명성도
-- exec spu_FarmD 19, 65,  4, 1076, -1, -1, -1, -1, -1, -1, 'xxxx2', 'admin', '', '', '', '', '', '', '', ''			--      명성도
-- exec spu_FarmD 19, 65,  4, 1874, -1, -1, -1, -1, -1, -1, 'xxxx2', 'admin', '', '', '', '', '', '', '', ''			--      명성도
-- exec spu_FarmD 19, 65,  4, 1875, -1, -1, -1, -1, -1, -1, 'xxxx2', 'admin', '', '', '', '', '', '', '', ''			--      명성도
-- exec spu_FarmD 19, 65,  4, 1876, -1, -1, -1, -1, -1, -1, 'xxxx2', 'admin', '', '', '', '', '', '', '', ''			--      명성도

-- exec spu_FarmD 19, 65,  4, 3394, -1, -1, -1, -1, -1, -1, 'xxxx2', 'admin', '', '', '', '', '', '', '', ''			--      명성도
-- exec spu_FarmD 19, 65,  4, 3395, -1, -1, -1, -1, -1, -1, 'xxxx2', 'admin', '', '', '', '', '', '', '', ''			--      명성도
-- exec spu_FarmD 19, 65,  4, 3396, -1, -1, -1, -1, -1, -1, 'xxxx2', 'admin', '', '', '', '', '', '', '', ''			--      명성도

-- exec spu_FarmD 19, 65,  4, 3794, -1, -1, -1, -1, -1, -1, 'xxxx2', 'admin', '', '', '', '', '', '', '', ''			--      명성도
-- exec spu_FarmD 19, 65,  4, 3795, -1, -1, -1, -1, -1, -1, 'xxxx2', 'admin', '', '', '', '', '', '', '', ''			--      명성도
-- exec spu_FarmD 19, 65,  4, 3796, -1, -1, -1, -1, -1, -1, 'xxxx2', 'admin', '', '', '', '', '', '', '', ''			--      명성도
-- exec spu_FarmD 19, 65,  4, 8794, -1, -1, -1, -1, -1, -1, 'xxxx2', 'admin', '', '', '', '', '', '', '', ''			--      명성도
-- exec spu_FarmD 19, 65,  4, 8795, -1, -1, -1, -1, -1, -1, 'xxxx2', 'admin', '', '', '', '', '', '', '', ''			--      명성도
-- exec spu_FarmD 19, 65,  4, 8796, -1, -1, -1, -1, -1, -1, 'xxxx2', 'admin', '', '', '', '', '', '', '', ''			--      명성도
-- exec spu_FarmD 19, 65,  4, 16394, -1, -1, -1, -1, -1, -1, 'xxxx2', 'admin', '', '', '', '', '', '', '', ''			--      명성도
-- exec spu_FarmD 19, 65,  4, 16395, -1, -1, -1, -1, -1, -1, 'xxxx2', 'admin', '', '', '', '', '', '', '', ''			--      명성도
-- exec spu_FarmD 19, 65,  4, 16396, -1, -1, -1, -1, -1, -1, 'xxxx2', 'admin', '', '', '', '', '', '', '', ''			--      명성도
-- exec spu_FarmD 19, 65,  4, , -1, -1, -1, -1, -1, -1, 'xxxx2', 'admin', '', '', '', '', '', '', '', ''			--      명성도
-- exec spu_FarmD 19, 65,  4, , -1, -1, -1, -1, -1, -1, 'xxxx2', 'admin', '', '', '', '', '', '', '', ''			--      명성도
-- exec spu_FarmD 19, 65,  4, , -1, -1, -1, -1, -1, -1, 'xxxx2', 'admin', '', '', '', '', '', '', '', ''			--      명성도
-- exec spu_FarmD 19, 65,  4, , -1, -1, -1, -1, -1, -1, 'xxxx2', 'admin', '', '', '', '', '', '', '', ''			--      명성도
-- exec spu_FarmD 19, 65,  4, , -1, -1, -1, -1, -1, -1, 'xxxx2', 'admin', '', '', '', '', '', '', '', ''			--      명성도
select fame, famelv from dbo.tUserMaster where gameid = 'xxxx2'

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
alter table dbo.tUserMaster add 	yabaunum		int					default(0)

declare @idx int set @idx = 0
select @idx = max(idx) from dbo.tUserMaster
while(@idx > -1000)
	begin
		update dbo.tUserMaster
			set
				yabaunum	= 0
		where idx >= @idx - 1000 and idx <= @idx
		set @idx =  @idx - 1000
	end
*/

/*
alter table dbo.tUserMaster add 	yabauidx		int					default(1)
alter table dbo.tUserMaster add 	yabaustep		int					default(0)

declare @idx int set @idx = 0
select @idx = max(idx) from dbo.tUserMaster
while(@idx > -1000)
	begin
		update dbo.tUserMaster
			set
				yabauidx 	= 1,
				yabaustep	= 0
		where idx >= @idx - 1000 and idx <= @idx
		set @idx =  @idx - 1000
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
--delete from dbo.tItemInfo where subcategory = 700 and itemcode >= 70001
--delete from dbo.tSystemYabau
--exec spu_FarmD 30, 45, -1    , '1', '10', '-1', '10', '1', '-1', '-1', '주사위1', '주사위1', '1:1:2:2:200;1:2:4:4:400;1:3:6:8:800;1:4:9:16:1600;1:5:10:32:3200;1:6:11:64:6400;1:7:11:128:12800;1:8:11:256:25600;', '', '', '', '', '', '', ''
--GO
--select * FROM dbo.fnu_SplitTwoStr(';', ':', '1:1:2:2:200;2:2:4:4:400;3:3:6:8:800;4:4:9:16:1600;5:5:10:32:3200;6:6:11:64:6400;7:7:11:128:12800;8:8:11:256:25600;')
--SELECT * FROM dbo.fnu_SplitOne(':', '2:4:4:400') where idx = 0
--SELECT * FROM dbo.fnu_SplitOne(':', '2:4:4:400')
declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
declare @p1_			int, @p2_		int, @p3_			int, @p4_			int, @p5_			int, @p6_			int, @p7_			int, @p8_			int, @p9_			int, @p10_			bigint,
		@ps1_			varchar(1024), @ps2_			varchar(1024), @ps3_			varchar(1024), @ps4_			varchar(1024), @ps5_			varchar(1024), @ps6_			varchar(1024), @ps7_			varchar(1024), @ps8_			varchar(1024), @ps9_			varchar(1024), @ps10_			varchar(4096)
	set @p2_ =45
	set @p4_ = 1
	set @p5_ = 10
	set @p7_ = 10
	set @p8_ = 1
	set @ps1_ = '주사위1'
	set @ps2_ = '주사위1'
	set @ps3_ = '1:1:2:2:200;1:2:4:4:400;1:3:6:8:800;1:4:9:16:1600;1:5:10:32:3200;1:6:11:64:6400;1:7:11:128:12800;1:8:11:256:25600;'
declare @packkind 		int
declare @itemcode 		int
declare @pack1			int,@pack2			int,@pack3			int,@pack4			int,@pack5			int,@pack6			int,@pack7			int,@pack8			int,@pack9			int,@pack10			int,@pack11			int,@pack12			int,@pack13			int,@pack14			int,@pack15			int,@pack16			int,@pack17			int,@pack18			int,@pack19			int,@pack20			int,@pack21			int,@pack22			int,@pack23			int,@pack24			int,@pack25			int,@pack26			int,@pack27			int,@pack28			int,@pack29			int,@pack30			int,@pack31			int,@pack32			int,@pack33			int,@pack34			int,@pack35			int,@pack36			int,@pack37			int,@pack38			int,@pack39			int,@pack40			int

declare @yabau			varchar(256)
declare @pack41			int, @pack42			int, @pack43			int, @pack44			int,
		@pack51			int, @pack52			int, @pack53			int, @pack54			int,
		@pack61			int, @pack62			int, @pack63			int, @pack64			int,
		@pack71			int, @pack72			int, @pack73			int, @pack74			int,
		@pack81			int, @pack82			int, @pack83			int, @pack84			int

			if(@p2_ = 45)
				begin
					-- 1. 커서 생성
					declare curYabauInsert Cursor for
					select * FROM dbo.fnu_SplitTwoStr(';', ':', @ps3_)

					-- 2. 커서오픈.
					open curYabauInsert

					-- 3. 커서 사용
					Fetch next from curYabauInsert into @packkind, @yabau
					while @@Fetch_status = 0
						Begin
							select 'DEBUG ', @packkind packkind, @yabau yabau
							if(@packkind = 1)
								begin
									select @pack11 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 0
									select @pack12 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 1
									select @pack13 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 2
									select @pack14 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 3
								end
							else if(@packkind = 2)
								begin
									select @pack21 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 0
									select @pack22 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 1
									select @pack23 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 2
									select @pack24 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 3
								end
							else if(@packkind = 3)
								begin
									select @pack31 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 0
									select @pack32 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 1
									select @pack33 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 2
									select @pack34 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 3
								end
							else if(@packkind = 4)
								begin
									select @pack41 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 0
									select @pack42 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 1
									select @pack43 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 2
									select @pack44 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 3
								end
							else if(@packkind = 5)
								begin
									select @pack51 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 0
									select @pack52 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 1
									select @pack53 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 2
									select @pack54 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 3
								end
							else if(@packkind = 6)
								begin
									select @pack61 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 0
									select @pack62 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 1
									select @pack63 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 2
									select @pack64 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 3
								end
							else if(@packkind = 7)
								begin
									select @pack71 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 0
									select @pack72 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 1
									select @pack73 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 2
									select @pack74 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 3
								end
							else if(@packkind = 8)
								begin
									select @pack81 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 0
									select @pack82 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 1
									select @pack83 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 2
									select @pack84 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 3
								end
							Fetch next from curYabauInsert into @packkind, @yabau
						end

					-- 4. 커서닫기
					close curYabauInsert
					Deallocate curYabauInsert

					if(not exists(select top 1 * from dbo.tSystemYabau where packstr = @ps3_))
						begin
							select 'DEBUG 시스템 야바위추가.'
							-- 정보수집용 추가 > 아이템 테이블 추가하기.
							set @itemcode = 70000
							select @itemcode = max(itemcode) + 1 from dbo.tItemInfo where subcategory = 700

							if(not exists(select top 1 * from dbo.tItemInfo where itemcode = @itemcode))
								begin
									select 'DEBUG > 실제입력'

									insert into dbo.tItemInfo(labelname,     itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
									                   values('staticinfo', @itemcode, '700',    '700',       '0',      @ps1_,    '0',      '0',     '0',   '0',      '16', '0',      '0',     '0',      '0',      '0',       '0',      @ps2_)

									insert into dbo.tSystemYabau(itemcode, famelvmin, famelvmax, saleper, packstate, packname,  comment, packstr, pack11, pack12, pack13, pack14, pack21, pack22, pack23, pack24, pack31, pack32, pack33, pack34, pack41, pack42, pack43, pack44, pack51, pack52, pack53, pack54, pack61, pack62, pack63, pack64, pack71, pack72, pack73, pack74, pack81, pack82, pack83, pack84)
									values(                     @itemcode, @p4_,      @p5_,      @p7_,    @p8_,      @ps1_,     @ps2_,   @ps3_,  @pack11,@pack12,@pack13,@pack14,@pack21,@pack22,@pack23,@pack24,@pack31,@pack32,@pack33,@pack34,@pack41,@pack42,@pack43,@pack44,@pack51,@pack52,@pack53,@pack54,@pack61,@pack62,@pack63,@pack64,@pack71,@pack72,@pack73,@pack74,@pack81,@pack82,@pack83,@pack84)

								end
						end

					select @RESULT_SUCCESS 'rtn'
				end

*/



/*
-- guest가입 (강제로 5만건 입력하기 )
declare @var 			int
declare @loop			int				set @loop	= 1
declare @gameid 		varchar(20)		set @gameid = 'farm'	-- guest, farm, iuest
declare @phone 			varchar(20)
select @var = max(idx) + 1 from dbo.tUserMaster
set @loop = @var + @loop
while @var < @loop
	begin
		set @phone			= '010' + ltrim(@var)
		exec dbo.spu_UserCreate
							@gameid,					-- gameid
							'5828478z2e6t0p422634',		-- password
							5,							-- market
							0,							-- buytype
							1,							-- platform
							'xxxxx',					-- ukey
							111,						-- version
							'01054794759',				-- phone
							'9171fcef9af92fc38f4bd19d79275b73970ffc44112e239260846201b7197c1e',							-- pushid
							'ACfWUFDWJwA',				-- kakaotalkid (없으면 임으로 생성해줌)
							'88282212134918145',		-- kakaouserid (없으면 임으로 생성해줌)
							'VXVB9u3kws6y2l1nF9qDIg==',	-- kakaonickname
							'X1O+2tQVVBqen7Rw61tqzjRMS7Ck1OLSozeclo8Z5i7YABa1SpCELWm9lS6HZCChOEeLU3yp9qtTtVLoazcars/uy1zyJFQI/oLWmSdIt6M2pKKyBtqIFxQrqlJWNJLb',	-- kakaoprofile
							-1,							-- kakaomsgblocked
							'',							-- kakaofriendlist(kakaouserid)
							-1
		set @var = @var + 1
	end


select * from dbo.tKakaoMaster where gameid = 'farm325033748'
select * from dbo.tUserMaster where gameid = 'farm325033748'
--select top 1 * from dbo.tKakaoMaster where kakaouserid = '88282212134918145'
--insert into dbo.tUserPhone(phone, market, joincnt) values('01054794759', 6, 1)
--update dbo.tUserMaster set phone = '01054794759' where gameid = 'farm325033748'
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
-- delete from dbo.tUserFarm where gameid = 'xxxx3' and itemcode >= 6930
declare @ITEM_SUBCATEGORY_USERFARM			int					set @ITEM_SUBCATEGORY_USERFARM	 			= 69	-- 전국목장
declare @gameid_ 				varchar(20)	set @gameid_ = 'xxxx3'
declare @farmidx				int				set @farmidx					= 0

--select * from dbo.tUserFarm where gameid = @gameid_

if(not exists(select top 1 * from dbo.tUserFarm where gameid = @gameid_ and itemcode = 6952))
	begin
		select @farmidx = max(farmidx) from dbo.tUserFarm where gameid = @gameid_

		insert into dbo.tUserFarm(farmidx, gameid, itemcode)
		select (rank() over(order by itemcode asc) + @farmidx) as farmidx, @gameid_, itemcode from dbo.tItemInfo
		where subcategory = @ITEM_SUBCATEGORY_USERFARM
			and itemcode not in (select itemcode from dbo.tUserFarm where gameid = @gameid_)
		order by itemcode asc
	end
--select * from dbo.tUserFarm where gameid = @gameid_
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
declare @MARKET_SKT		int				set @MARKET_SKT		= 1
declare @startdate		varchar(20)		set @startdate		= '2014-06-09 00:00'
declare @enddate		varchar(20)		set @enddate		= '2014-06-22 23:59'
declare @gameid			varchar(20)
declare @phone			varchar(20)
declare @cash			int
-- select * from dbo.tUserPhone where phone in (select phone from dbo.tUserMaster where market = @MARKET_SKT and regdate >= @startdate and regdate <= @enddate)
--									  and market = @MARKET_SKT and writedate >= @startdate and writedate <= @enddate

-- 1. 커서 생성
declare curSKTJoin Cursor for
select gameid, phone from dbo.tUserMaster where market = @MARKET_SKT and regdate >= @startdate and regdate <= @enddate

-- 2. 커서오픈
open curSKTJoin

-- 3. 커서 사용
Fetch next from curSKTJoin into @gameid, @phone
while @@Fetch_status = 0
	Begin
		if(exists(select top 1 * from dbo.tUserPhone where phone = @phone and market = @MARKET_SKT and writedate >= @startdate and writedate <= @enddate))
			begin
				-----------------------------------------------------------------------------
				-- 이벤트 기간동안 짜요 목장 이야기 for Kakao를 다운받은 신규 T스토어 유저
				--> 수정 100개(5018) + 부활석 20개(1206) + 긴급요청 티켓 20개(2106) 지급
				--exec spu_SubGiftSend 2, 5018, 'SKT신규보상', 'xxxx2', ''
				--exec spu_SubGiftSend 2, 1206, 'SKT신규보상', 'xxxx2', ''
				--exec spu_SubGiftSend 2, 2106, 'SKT신규보상', 'xxxx2', ''
				-----------------------------------------------------------------------------
				exec spu_SubGiftSend 2, 5018, 'SKT신규보상', @gameid, ''
				exec spu_SubGiftSend 2, 1206, 'SKT신규보상', @gameid, ''
				exec spu_SubGiftSend 2, 2106, 'SKT신규보상', @gameid, ''
			end
		Fetch next from curSKTJoin into @gameid, @phone
	end

-- 4. 커서닫기
close curSKTJoin
Deallocate curSKTJoin
*/
/*
declare @MARKET_SKT		int				set @MARKET_SKT		= 1
declare @startdate		varchar(20)		set @startdate		= '2014-06-09 00:00'
declare @enddate		varchar(20)		set @enddate		= '2014-06-22 23:59'
declare @gameid			varchar(20)
declare @phone			varchar(20)
declare @comment		varchar(256)
declare @cash			int
declare @cashcost		int
declare @cashcostorg	int
declare @plus			int
--select gameid, SUM(cash) from dbo.tCashLog where market = @MARKET_SKT and writedate >= @startdate and writedate <= @enddate group by gameid having SUM(cash) >= 5000 order by 2 desc

-- 1. 커서 생성
declare curSKTCash Cursor for
select gameid, SUM(cash) from dbo.tCashLog where market = @MARKET_SKT and writedate >= @startdate and writedate <= @enddate group by gameid having SUM(cash) >= 5000 order by 2 desc
--select gameid, 500000 cash from dbo.tUserMaster where gameid = 'xxxx2'

-- 2. 커서오픈
open curSKTCash

-- 3. 커서 사용
Fetch next from curSKTCash into @gameid, @cash
while @@Fetch_status = 0
	Begin
		-----------------------------------------------------------------------------
		-- 이벤트 기간동안 발생된 누적 결제금액에 대해 보너스 수정 지급
		-- Exec Spu_Subgiftsend 1, -1, 'SKT결제보너스', 'xxxx2', '1000원 이상 결제로 추가 수정 10개를 지급합니다.(직접반영)'
		-----------------------------------------------------------------------------
		-- 수정 추가, 쪽지기록.
		select @cashcostorg = cashcost from dbo.tUserMaster where gameid = @gameid
		if(@cash >= 1000000)
			begin
				set @plus 		= 2720
				set @cashcost	= @cashcostorg + @plus
				set @comment	= '1,000,000원 이상 결제로 추가 수정 '+ltrim(rtrim(str(@plus)))+'개를 지급합니다.('+ltrim(rtrim(str(@cashcostorg)))+'수정에서 '+ltrim(rtrim(str(@cashcost)))+'으로 증가)'
				update dbo.tUserMaster set cashcost = cashcost + @plus where gameid = @gameid
				Exec Spu_Subgiftsend 1, -1, 'SKT결제보너스', @gameid, @comment
			end
		else if(@cash >= 500000)
			begin
				set @plus		= 1090
				set @cashcost	= @cashcostorg + @plus
				set @comment	= '500,000원 이상 결제로 추가 수정 '+ltrim(rtrim(str(@plus)))+'개를 지급합니다.('+ltrim(rtrim(str(@cashcostorg)))+'수정에서 '+ltrim(rtrim(str(@cashcost)))+'으로 증가)'
				update dbo.tUserMaster set cashcost = cashcost + @plus where gameid = @gameid
				Exec Spu_Subgiftsend 1, -1, 'SKT결제보너스', @gameid, @comment
			end
		else if(@cash >= 300000)
			begin
				set @plus		= 490
				set @cashcost	= @cashcostorg + @plus
				set @comment	= '300,000원 이상 결제로 추가 수정 '+ltrim(rtrim(str(@plus)))+'개를 지급합니다.('+ltrim(rtrim(str(@cashcostorg)))+'수정에서 '+ltrim(rtrim(str(@cashcost)))+'으로 증가)'
				update dbo.tUserMaster set cashcost = cashcost + @plus where gameid = @gameid
				Exec Spu_Subgiftsend 1, -1, 'SKT결제보너스', @gameid, @comment
			end
		else if(@cash >= 100000)
			begin
				set @plus		= 110
				set @cashcost	= @cashcostorg + @plus
				set @comment	= '100,000원 이상 결제로 추가 수정 '+ltrim(rtrim(str(@plus)))+'개를 지급합니다.('+ltrim(rtrim(str(@cashcostorg)))+'수정에서 '+ltrim(rtrim(str(@cashcost)))+'으로 증가)'
				update dbo.tUserMaster set cashcost = cashcost + @plus where gameid = @gameid
				Exec Spu_Subgiftsend 1, -1, 'SKT결제보너스', @gameid, @comment
			end
		else if(@cash >= 30000)
			begin
				set @plus		= 25
				set @cashcost	= @cashcostorg + @plus
				set @comment	= '30,000원 이상 결제로 추가 수정 '+ltrim(rtrim(str(@plus)))+'개를 지급합니다.('+ltrim(rtrim(str(@cashcostorg)))+'수정에서 '+ltrim(rtrim(str(@cashcost)))+'으로 증가)'
				update dbo.tUserMaster set cashcost = cashcost + @plus where gameid = @gameid
				Exec Spu_Subgiftsend 1, -1, 'SKT결제보너스', @gameid, @comment
			end
		else if(@cash >= 10000)
			begin
				set @plus		= 5
				set @cashcost	= @cashcostorg + @plus
				set @comment	= '10,000원 이상 결제로 추가 수정 '+ltrim(rtrim(str(@plus)))+'개를 지급합니다.('+ltrim(rtrim(str(@cashcostorg)))+'수정에서 '+ltrim(rtrim(str(@cashcost)))+'으로 증가)'
				update dbo.tUserMaster set cashcost = cashcost + @plus where gameid = @gameid
				Exec Spu_Subgiftsend 1, -1, 'SKT결제보너스', @gameid, @comment
			end
		else if(@cash >= 5000)
			begin
				set @plus		= 3
				set @cashcost	= @cashcostorg + @plus
				set @comment	= '5,000원 이상 결제로 추가 수정 '+ltrim(rtrim(str(@plus)))+'개를 지급합니다.('+ltrim(rtrim(str(@cashcostorg)))+'수정에서 '+ltrim(rtrim(str(@cashcost)))+'으로 증가)'
				update dbo.tUserMaster set cashcost = cashcost + @plus where gameid = @gameid
				Exec Spu_Subgiftsend 1, -1, 'SKT결제보너스', @gameid, @comment
			end

		Fetch next from curSKTCash into @gameid, @cash
	end

-- 4. 커서닫기
close curSKTCash
Deallocate curSKTCash
*/



/*
alter table dbo.tUserMaster add 	bgacc1listidxdel	int				default(-1)
alter table dbo.tUserMaster add 	bgacc2listidxdel	int				default(-1)

declare @idx int set @idx = 0
select @idx = max(idx) from dbo.tUserMaster
while(@idx > -1000)
	begin
		update dbo.tUserMaster
			set
				bgacc1listidxdel = -1,
				bgacc2listidxdel = -1
		where idx >= @idx - 1000 and idx <= @idx
		set @idx =  @idx - 1000
	end
*/

--update dbo.tUserMaster set comreward = 90372 where gameid = 'farm378'
--update dbo.tUserMaster set comreward = -1 where gameid = 'farm378'
--select * from dbo.tUserMaster where comreward = -1
--update dbo.tUserMaster set comreward = 90154 where comreward = -1

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

-- select * from dbo.tItemInfo where category = 901 and itemcode = 90372
-- update dbo.tItemInfo set param8 = 90152 where category = 901 and itemcode = 90372

--select top 10 * from dbo.tComReward order by idx desc
--select top 10 * from dbo.tComReward where gameid = 'farm423406560' order by idx2 desc

/*
--alter table dbo.tComReward add 	idx2			int

declare @idx int set @idx = 0
select @idx = max(idx) from dbo.tComReward
while(@idx > -1000)
	begin
		update dbo.tComReward
			set
				idx2 = itemcode - 90000
		where idx >= @idx - 1000 and idx <= @idx and idx2 is null
		set @idx =  @idx - 1000
	end
*/

/*
-- gameid, idx2
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tComReward_gameid_idx2')
	DROP INDEX tComReward.idx_tComReward_gameid_idx2
GO
CREATE INDEX idx_tComReward_gameid_idx2 ON tComReward (gameid, idx2)
GO
*/


/*alter table dbo.tUserAdLog add 	mode	int					default(1)

declare @idx int set @idx = 0
select @idx = max(idx) from dbo.tUserAdLog
while(@idx > -1000)
	begin
		update dbo.tUserAdLog
			set
				mode = 1
		where idx >= @idx - 1000 and idx <= @idx
		set @idx =  @idx - 1000
	end
*/

/*
update dbo.tUserItem set acc1 = 1401, acc2 = 1462 where gameid = 'xxxx2' and listidx = 19

-- select * from dbo.tUsermaster where gameid = 'xxxx2'
alter table dbo.tUserMaster add 	bgacc1listidx	int					default(-1)
alter table dbo.tUserMaster add 	bgacc2listidx	int					default(-1)

declare @idx int set @idx = 0
select @idx = max(idx) from dbo.tUserMaster
while(@idx > -1000)
	begin
		update dbo.tUserMaster
			set
				bgacc1listidx = -1,
				bgacc2listidx = -1
		where idx >= @idx - 1000 and idx <= @idx
		set @idx =  @idx - 1000
	end
*/

/*
-- select * from dbo.tUsermaster where gameid = 'xxxx2'
alter table dbo.tUserMaster add 	pettodayitemcode2	int				default(100005)

declare @idx int set @idx = 0
select @idx = max(idx) from dbo.tUserMaster
while(@idx > -1000)
	begin
		update dbo.tUserMaster
			set
				pettodayitemcode2 = 100005
		where idx >= @idx - 1000 and idx <= @idx
		set @idx =  @idx - 1000
	end
*/


/*
select * from dbo.tKakaoMaster where kakaouserid = '88258263875124913'
select * from dbo.tKakaoMaster where kakaouserid = '88452235362617025'

insert into dbo.tKakaoMaster(kakaotalkid,   kakaouserid,                 gameid,   kakaodata, writedate)
values(						'A1QZxsYZVAM', '88452235362617025', 'farm161006288', 1, '2014-05-12 12:14')
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
-- 펫 오늘만 이가격 추천구매.
-- exec spu_ItemPet 'farm49', '0423641e9n4j3z454287', 1, 100000, -1	-- 펫구매(이미구매된것)
-- exec spu_ItemPet 'farm49', '0423641e9n4j3z454287', 4,     45, -1
-- 도움요청
--
-- select * from dbo.tKakaoHelpWait where gameid = 'farm49'
-- farm49 -> farm45, farm939030595, farm939033459, farm939034201 요청
-- exec spu_GiftGain 'xxxx2', '049000s1i0n7t8445289', -3, 3429809, -1, -1, -1, -1	-- 소선물받기.
-- exec spu_AniDie 'xxxx2', '049000s1i0n7t8445289', 1, 1, -1						-- 눌러죽음.
update dbo.tUserFriend set helpdate = getdate() - 10 where gameid in ('farm49', 'farm939030595', 'farm939033459')
exec spu_KakaoFriendHelp 'farm49', '0423641e9n4j3z454287', 'farm939030595',  46, -1
exec spu_KakaoFriendHelp 'farm49', '0423641e9n4j3z454287', 'farm939033459', 46, -1

-- 도움처리
exec sup_subKakaoHelpWait 'farm939030595'
exec sup_subKakaoHelpWait 'farm939033459'
*/







/*
delete from dbo.tItemInfo where itemcode in (19, 118, 218, 81819)

insert into dbo.tItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14, param15, param16, param17, param18, param19)
values('animal', '19', '1', '1', '1', '이겼 소!', '1', '0', '3', '0', '25', '28', '0', '0', '50', '1', '340', '이겼소~ 이겼소~ 우리나라가 이겼소!', '2', '4', '2', '111', '2500', '55', '4', '3', '100', '89', '214', '-1', '1', '2', '30', '51', '2', '-1', '0')
GO

insert into dbo.tItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14, param15, param16, param17, param18, param19)
values('animal', '118', '1', '2', '1', '승리한거 양!', '1', '0', '3', '0', '26', '19', '0', '0', '81', '1', '450', '우리나라가 또 이긴거양? 그런거양?', '6', '4', '2', '201', '2163', '80', '6', '4', '110', '78', '608', '-1', '1', '3', '34', '67', '2', '-1', '0')
GO

insert into dbo.tItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14, param15, param16, param17, param18, param19)
values('animal', '218', '1', '3', '1', '또 이겼 산양~', '0', '0', '3', '0', '26', '0', '0', '0', '118', '1', '540', '또~ 또~ 우리나라가 이겼 산양~', '9', '4', '2', '212', '2016', '100', '8', '4', '120', '73', '314', '-1', '1', '3', '36', '81', '3', '-1', '0')
GO

insert into dbo.tItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10)
values('dogam', '81819', '818', '818', '0', '도감17', '1', '0', '0', '0', '16', '0', '0', '0', '0', '1', '1', '도감17', '20', '19', '118', '218', '-1', '-1', '-1', '1207', '1', '월드컵 동물 모음')
GO



*/


/*
-- 일반교배
-- 하트 추가: 27,315(합성) +   103,320(교배)
-- 코인 추가:416,600(합성) + 1,136,800(교배) 150(구매)
-- 캐쉬 추가:    270(합성)
-- 교배 	: 1036	(2014-06-10 11:37:38 ~ 2014-06-10 18:56)
-- 합성		: 676
-- 209	1 봉제 인형 산양 90
-- 110	1 늑대가죽 양 70
-- 12	5 봉제 인형 소 65
select sum(gamecost) from dbo.tUserItemBuyLog where gameid = 'farm939022644' and itemcode < 100 and buydate >= '2014-06-10' and buydate <= '2014-06-10 19:00'
select kind, count(*), sum(heart), sum(gamecost), sum(cashcost) from dbo.tRouletteLogPerson where gameid = 'farm939022644' and writedate >= '2014-06-10' and writedate <= '2014-06-10 19:00' group by kind
select * from dbo.tRouletteLogPerson where gameid = 'farm939022644' and writedate >= '2014-06-10' and writedate <= '2014-06-10 19:00'
select * from dbo.tComposeLogPerson where gameid = 'farm939022644' and writedate >= '2014-06-10' and writedate <= '2014-06-10 19:00'
select sum(heart), sum(cashcost), sum(gamecost) from dbo.tComposeLogPerson where gameid = 'farm939022644' and writedate >= '2014-06-10' and writedate <= '2014-06-10 19:00'
select bgcomposeic, count(*) from dbo.tComposeLogPerson where gameid = 'farm939022644' and writedate >= '2014-06-10' and writedate <= '2014-06-10 19:00' group by bgcomposeic order by 1 desc


-- 일반교배 + 프림교배
-- 하트 추가:    8060(합성) +  43,500(교배)
-- 코인 추가: 125,420(합성) + 478,500(교배) + 900(상점구매)
-- 캐쉬 추가:     699(합성) +     440(프교배)
-- 교배 	: 457 (일반교배 435, 프림 22)
-- 합성		: 175
-- 209	1 봉제 인형 산양(90)
-- 111	1 시크한 검은양(75)
-- 15	1 무법자 젖소 (90)
select sum(gamecost) from dbo.tUserItemBuyLog where gameid = 'farm939021205' and itemcode < 100 and buydate >= '2014-06-10' and buydate <= '2014-06-10 19:00'
select kind, count(*), sum(heart), sum(gamecost), sum(cashcost) from dbo.tRouletteLogPerson where gameid = 'farm939021205' and writedate >= '2014-06-10' and writedate <= '2014-06-10 19:00' group by kind
select * from dbo.tRouletteLogPerson where gameid = 'farm939021205' and writedate >= '2014-06-10' and writedate <= '2014-06-10 19:00'
select * from dbo.tComposeLogPerson where gameid = 'farm939021205' and writedate >= '2014-06-10' and writedate <= '2014-06-10 19:00'
select sum(heart), sum(cashcost), sum(gamecost) from dbo.tComposeLogPerson where gameid = 'farm939021205' and writedate >= '2014-06-10' and writedate <= '2014-06-10 19:00'
select bgcomposeic, count(*) from dbo.tComposeLogPerson where gameid = 'farm939021205' and writedate >= '2014-06-10' and writedate <= '2014-06-10 19:00' group by bgcomposeic order by 1 desc


-- 상점구매
-- 하트 추가:  68,575(합성)
-- 코인 추가: 837,600(합성) + 11,947,850(상점구매)
-- 캐쉬 추가:
-- 교배 	: 0
-- 합성		: 2014	> 최대 얼장젖소(14) 신선도75
select sum(gamecost) from dbo.tUserItemBuyLog where gameid = 'farm939023759' and itemcode < 100 and buydate >= '2014-06-10' and buydate <= '2014-06-10 19:00'
select * from dbo.tRouletteLogPerson where gameid = 'farm939023759' and writedate >= '2014-06-10' and writedate <= '2014-06-10 19:00'
select * from dbo.tComposeLogPerson where gameid = 'farm939023759' and writedate >= '2014-06-10' and writedate <= '2014-06-10 19:00'
select sum(heart), sum(cashcost), sum(gamecost) from dbo.tComposeLogPerson where gameid = 'farm939023759' and writedate >= '2014-06-10' and writedate <= '2014-06-10 19:00'
select bgcomposeic, count(*) from dbo.tComposeLogPerson where gameid = 'farm939023759' and writedate >= '2014-06-10' and writedate <= '2014-06-10 19:00' group by bgcomposeic order by 1 desc

*/



