---------------------------------------------------------------
/*
-- 오류나는것들.
exec spu_AniCompose 'xxxxa', '049000s1i0n7t8445289', 1, 101002, 19, 20, -1, -1, -1, 999991, -1	-- 아이디오류
exec spu_AniCompose 'xxxx2', '049000s1i0n7t8445289', 0, 101002, 19, 20, -1, -1, -1, 999992, -1	-- 모드 오류
exec spu_AniCompose 'xxxx2', '049000s1i0n7t8445289', 1, 101000, 19, 20, -1, -1, -1, 999993, -1	-- 합성코드 오류
exec spu_AniCompose 'xxxx2', '049000s1i0n7t8445289', 1, 101012, 28, 20, 30, 31, 32, 999990, -1	-- 베이스와 1번 다름
exec spu_AniCompose 'xxxx2', '049000s1i0n7t8445289', 1, 101012, 28, 29, 20, 31, 32, 999980, -1	--
exec spu_AniCompose 'xxxx2', '049000s1i0n7t8445289', 1, 101012, 28, 29, 30, 20, 32, 999995, -1	--
exec spu_AniCompose 'xxxx2', '049000s1i0n7t8445289', 1, 101012, 28, 29, 30, 31, 20, 999996, -1	--
exec spu_AniCompose 'xxxx2', '049000s1i0n7t8445289', 1, 101012, 28, 29, 30, 31,  0, 999997, -1	-- 해당 리스트를 찾을수 없습니다
-- update dbo.tUserMaster set cashcost = 0, gamecost = 799, heart = 64, randserial = -1 where gameid = 'xxxx2'
exec spu_AniCompose 'xxxx2', '049000s1i0n7t8445289', 1, 101012, 28, 29, 30, 31, 32, 999998, -1	-- 부족
-- update dbo.tUserMaster set cashcost = 19, gamecost = 800, heart = 65, randserial = -1 where gameid = 'xxxx2'
exec spu_AniCompose 'xxxx2', '049000s1i0n7t8445289', 3, 101012, 28, 29, 30, 31, -1, 999998, -1	-- 루비합성 > 부족


-- 동물합성하기.
delete from dbo.tGiftList where gameid in ('xxxx2')
delete from dbo.tUserItem where gameid in ('xxxx2') and invenkind in (1)
update dbo.tUserMaster set cashcost = 0,     gamecost = 0,     heart = 0,     randserial = -1 where gameid = 'xxxx2'
update dbo.tUserMaster set cashcost = 10000, gamecost = 10000, heart = 10000, randserial = -1 where gameid = 'xxxx2'
insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 14, 9, 1, 0, -1, 1, 5)
insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 19, 1, 1, 0, -1, 1, 5) insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 20, 1, 1, 0, -1, 1, 5)
insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 21, 5, 1, 0, -1, 1, 5) insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 22, 5, 1, 0, -1, 1, 5) insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 23, 5, 1, 0, -1, 1, 5)
insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 24, 9, 1, 0, -1, 1, 5) insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 25, 9, 1, 0, -1, 1, 5) insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 26, 9, 1, 0, -1, 1, 5) insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 27, 9, 1, 0, -1, 1, 5)
insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 28, 11, 1, 0, -1, 1, 5) insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 29, 11, 1, 0, -1, 1, 5) insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 30, 11, 1, 0, -1, 1, 5) insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 31, 11, 1, 0, -1, 1, 5) insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 32, 11, 1, 0, -1, 1, 5)

exec spu_AniCompose 'xxxx2', '049000s1i0n7t8445289', 1, 101002, 19, 20, -1, -1, -1, 999992, -1	-- 2마리
exec spu_AniCompose 'xxxx2', '049000s1i0n7t8445289', 1, 101006, 21, 22, 23, -1, -1, 999993, -1	-- 3마리
exec spu_AniCompose 'xxxx2', '049000s1i0n7t8445289', 1, 101010, 24, 25, 26, 27, -1, 999994, -1	-- 4마리
exec spu_AniCompose 'xxxx2', '049000s1i0n7t8445289', 1, 101012, 28, 29, 30, 31, 32, 999995, -1	-- 5마리.
select idx2, * from dbo.tComposeLogPerson where gameid = 'xxxx2' order by idx desc

exec spu_AniCompose 'xxxx2', '049000s1i0n7t8445289', 2, 101002, 19, 20, -1, -1, -1, 999992, -1	-- 2마리(오류)
exec spu_AniCompose 'xxxx2', '049000s1i0n7t8445289', 2, 101006, 21, 22, -1, -1, -1, 999993, -1	-- 3마리(1마리 부족)
exec spu_AniCompose 'xxxx2', '049000s1i0n7t8445289', 2, 101010, 24, 25, 26, -1, -1, 999994, -1	-- 4마리(1마리 부족)
exec spu_AniCompose 'xxxx2', '049000s1i0n7t8445289', 2, 101012, 28, 29, 30, 31, -1, 999995, -1	-- 5마리(1마리 부족)

-- delete from dbo.tUserItem where gameid = 'xxxx2' and listidx in (19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32)
-- update dbo.tUserMaster set cashcost = 0,     gamecost = 0,     heart = 0,     randserial = -1, bgcomposewt = getdate() - 1  where gameid = 'xxxx2'
-- update dbo.tUserMaster set cashcost = 10000, gamecost = 10000, heart = 10000, randserial = -1, bgcomposewt = getdate() - 1 where gameid = 'xxxx2'
-- insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 19, 1, 1, 0, -1, 1, 5) insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 20, 1, 1, 0, -1, 1, 5)
-- insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 21, 5, 1, 0, -1, 1, 5) insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 22, 5, 1, 0, -1, 1, 5) insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 23, 5, 1, 0, -1, 1, 5)
-- insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 24, 9, 1, 0, -1, 1, 5) insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 25, 9, 1, 0, -1, 1, 5) insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 26, 9, 1, 0, -1, 1, 5) insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 27, 9, 1, 0, -1, 1, 5)
-- insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 28, 11, 1, 0, -1, 1, 5) insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 29, 11, 1, 0, -1, 1, 5) insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 30, 11, 1, 0, -1, 1, 5) insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 31, 11, 1, 0, -1, 1, 5) insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 32, 11, 1, 0, -1, 1, 5)
exec spu_AniCompose 'xxxx2', '049000s1i0n7t8445289', 3, 101002, 19, 20, -1, -1, -1, 999992, -1	-- 2마리(오류)
exec spu_AniCompose 'xxxx2', '049000s1i0n7t8445289', 3, 101006, 21, 22, -1, -1, -1, 999993, -1	-- 3마리(1마리 부족 > 루비)
exec spu_AniCompose 'xxxx2', '049000s1i0n7t8445289', 3, 101010, 24, 25, -1, -1, -1, 999994, -1	-- 4마리(1마리 부족 > 루비)
exec spu_AniCompose 'xxxx2', '049000s1i0n7t8445289', 3, 101010, 24, 25, 26, -1, -1, 999995, -1	-- 4마리(1마리 부족 > 루비)
exec spu_AniCompose 'xxxx2', '049000s1i0n7t8445289', 3, 101012, 28, 29, -1, -1, -1, 999996, -1	-- 5마리(1마리 부족 > 루비)
exec spu_AniCompose 'xxxx2', '049000s1i0n7t8445289', 3, 101012, 28, 29, 30, -1, -1, 999997, -1	-- 5마리(1마리 부족 > 루비)
exec spu_AniCompose 'xxxx2', '049000s1i0n7t8445289', 3, 101012, 28, 29, 30, 31, -1, 999998, -1	-- 5마리(1마리 부족 > 루비)

-- 동물합성하기 (강화후 합성).
delete from dbo.tGiftList where gameid in ('xxxx2')
delete from dbo.tUserItem where gameid in ('xxxx2') and invenkind in (1)
update dbo.tUserMaster set cashcost = 10000, gamecost = 10000, heart = 10000, randserial = -1 where gameid = 'xxxx2'
exec spu_SetDirectItemNew 'xxxx2', 2, 1, 1, -1	exec spu_SetDirectItemNew 'xxxx2', 2, 1, 1, -1 exec spu_SetDirectItemNew 'xxxx2', 2, 1, 1, -1
update dbo.tUserItem set upcnt = upstepmax, freshstem100 = 1, attstem100 = 2, timestem100 = 3, defstem100 = 4, hpstem100 = 5 where gameid in ('xxxx2') and listidx = 1
exec spu_AniCompose 'xxxx2', '049000s1i0n7t8445289', 1, 101003, 1, 2, -1, -1, -1, 999992, -1	-- 2마리 (실패)
exec spu_AniCompose 'xxxx2', '049000s1i0n7t8445289', 1, 101003, 1, 2,  3, -1, -1, 999991, -1	-- 3마리 (성공)

*/
use Game4Farmvill5
GO

IF OBJECT_ID ( 'dbo.spu_AniCompose', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_AniCompose;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_AniCompose
	@gameid_				varchar(20),
	@password_				varchar(20),
	@mode_					int,
	@itemcode_				int,
	@listidxbase_			int,
	@listidxs1_				int,
	@listidxs2_				int,
	@listidxs3_				int,
	@listidxs4_				int,
	@randserial_			varchar(20),
	@nResult_				int					OUTPUT
	--WITH ENCRYPTION
as
	------------------------------------------------
	--	2-1. 코드값
	------------------------------------------------
	-- 일반값
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	-- 오류.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함
	declare @RESULT_ERROR_HEART_LACK			int				set @RESULT_ERROR_HEART_LACK			= -20			--하트이 부족하다.
	declare @RESULT_ERROR_GAMECOST_LACK			int				set @RESULT_ERROR_GAMECOST_LACK			= -21			--실버가 부족하다.
	declare @RESULT_ERROR_CASHCOST_LACK			int				set @RESULT_ERROR_CASHCOST_LACK			= -22			--골드가 부족하다.
	declare @RESULT_ERROR_ITEM_LACK				int				set @RESULT_ERROR_ITEM_LACK				= -23			--아이템이부족하다.
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- 아이템코드못찾음
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- 지원하지않는모드
	declare @RESULT_ERROR_NOT_MATCH				int				set @RESULT_ERROR_NOT_MATCH				= -110			-- 무엇인가 매치가 안되었다.
	declare @RESULT_ERROR_LISTIDX_NOT_FOUND		int				set @RESULT_ERROR_LISTIDX_NOT_FOUND		= -114			-- 리스트 번호를 못찾음.
	declare @RESULT_ERROR_TIME_REMAIN			int				set @RESULT_ERROR_TIME_REMAIN			= -123			-- 아직 시간이 남음.

	------------------------------------------------
	--	2-2. 정의된값
	------------------------------------------------
	-- 아이템별 인벤분류
	declare @USERITEM_INVENKIND_ANI				int 				set @USERITEM_INVENKIND_ANI					= 1
	declare @USERITEM_INVENKIND_CONSUME			int 				set @USERITEM_INVENKIND_CONSUME				= 3

	-- 아이템 소분류
	declare @ITEM_SUBCATEGORY_COMPOSE			int					set @ITEM_SUBCATEGORY_COMPOSE				= 1010 	--동물합성(1010)

	-- 선물 정의값
	declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2

	-- 그룹.
	declare @ITEM_COMPOSETICKET_MOTHER			int					set @ITEM_COMPOSETICKET_MOTHER				= 3500	-- 합성의 훈장.
	--declare @ITEM_PROMOTETICKET_MOTHER		int					set @ITEM_PROMOTETICKET_MOTHER				= 3600	-- 승급의 꽃.

	-- 아이템 획득방법
	--declare @DEFINE_HOW_GET_FIRST				int					set @DEFINE_HOW_GET_FIRST					= 0	--기본
	--declare @DEFINE_HOW_GET_BUY				int					set @DEFINE_HOW_GET_BUY						= 1	--구매
	--declare @DEFINE_HOW_GET_SEEDFIELD			int					set @DEFINE_HOW_GET_SEEDFIELD				= 2	--경작
	--declare @DEFINE_HOW_GET_ROULETTE			int					set @DEFINE_HOW_GET_ROULETTE				= 3	--교배/뽑기
	--declare @DEFINE_HOW_GET_SEARCH			int					set @DEFINE_HOW_GET_SEARCH					= 4	--검색
	--declare @DEFINE_HOW_GET_GIFT				int					set @DEFINE_HOW_GET_GIFT					= 5	--선물
	--declare @DEFINE_HOW_GET_TODAYBUY			int					set @DEFINE_HOW_GET_TODAYBUY				= 6	--[펫]오늘만판매
	--declare @DEFINE_HOW_GET_PETROLL			int					set @DEFINE_HOW_GET_PETROLL					= 7	--[펫]뽑기
	--declare @DEFINE_HOW_GET_ROULACC			int					set @DEFINE_HOW_GET_ROULACC					= 9	--악세뽑기
	--declare @DEFINE_HOW_GET_ACCSTRIP			int					set @DEFINE_HOW_GET_ACCSTRIP				= 10--악세해제
	declare @DEFINE_HOW_GET_COMPOSE				int					set @DEFINE_HOW_GET_COMPOSE					= 11--합성

	-- 합성의 종류
	declare @MODE_ANI_COMPOSE_FULL				int 				set @MODE_ANI_COMPOSE_FULL					= 1		-- 준비만족 > 무료 돌리기.
	declare @MODE_ANI_COMPOSE_LACK_HAKROUL		int 				set @MODE_ANI_COMPOSE_LACK_HAKROUL			= 2		-- 준비부족 > 확률 돌리기.
	declare @MODE_ANI_COMPOSE_LACK_CASHCOST		int 				set @MODE_ANI_COMPOSE_LACK_CASHCOST			= 3		-- 준비부족 > 루비 돌리기.

	-- 합성의 결과.
	declare @COMPOSE_RESULT_SUCCESS				int					set @COMPOSE_RESULT_SUCCESS			= 1
	declare @COMPOSE_RESULT_FAIL				int					set @COMPOSE_RESULT_FAIL			= 0

	declare @USER_LOG_MAX						int					set @USER_LOG_MAX 					= 20	-- 테스트용.
	--declare @COMPOSE_FREE_HOUR				int					set @COMPOSE_FREE_HOUR				= 19			-- 19시(7시)
	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @comment		varchar(80)
	declare @gameid			varchar(20)		set @gameid			= ''		-- 유저정보.
	declare @kakaonickname	varchar(40)		set @kakaonickname	= ''
	declare @famelv			int				set @famelv			= 1
	declare @gameyear		int				set @gameyear		= 2013
	declare @gamemonth		int				set @gamemonth		= 3

	declare @anireplistidx	int				set @anireplistidx	= 1
	declare @anirepitemcode	int				set @anirepitemcode	=  1
	declare @anirepacc1		int				set @anirepacc1		= -1
	declare @anirepacc2		int				set @anirepacc2		= -1
	declare @cashcost		int				set @cashcost 		= 0
	declare @gamecost		int				set @gamecost 		= 0
	declare @heart			int				set @heart 			= 0
	declare @feed			int				set @feed 			= 0
	declare @composeticket	int				set @composeticket	= 0
	declare @composeticketlistidx	int		set @composeticketlistidx= -1
	declare @randserial		varchar(20)		set @randserial		= '-1'
	declare @bgcomposeic	int				set @bgcomposeic	= -1
	declare @bgcomposert	int				set @bgcomposert	= @COMPOSE_RESULT_FAIL
	declare @bgcomposename	varchar(40)		set @bgcomposename	= ''
	declare @bgcomposewt	datetime		set @bgcomposewt	= getdate()
	declare @bgcomposecc	int				set @bgcomposecc	= 0
	declare @seedgapsecond	int				set @seedgapsecond	= 0
	declare @market			int				set @market			= 5

	declare @itemcode		int				set @itemcode		= -1		-- 합성마스터 정보.
	declare @itemname		varchar(40)		set @itemname		= ''
	declare @needheart		int				set @needheart		= 99999
	declare @needgamecost	int				set @needgamecost 	= 99999
	declare @needcashcost	int				set @needcashcost 	= 99999
	declare @needcomposeticket	int			set @needcomposeticket= 99999
	declare @onepercent		int				set @onepercent		= 0
	declare @needcnt		int				set @needcnt		= 2
	declare @needtime		int				set @needtime		= 99999
	declare @needtimecashcost	int			set @needtimecashcost= 99999
	declare @mbase			int				set @mbase			= -1
	declare @msource1		int				set @msource1		= -1
	declare @msource2		int				set @msource2		= -1
	declare @msource3		int				set @msource3		= -1
	declare @msource4		int				set @msource4		= -1
	declare @mresultfail	int				set @mresultfail	= -1
	declare @mresultsuccess	int				set @mresultsuccess	= -1

	declare @baseitemcode	int				set @baseitemcode	= -1
	declare @s1itemcode		int				set @s1itemcode		= -1
	declare @s2itemcode		int				set @s2itemcode		= -1
	declare @s3itemcode		int				set @s3itemcode		= -1
	declare @s4itemcode		int				set @s4itemcode		= -1
	declare @curcnt			int				set @curcnt			= 0
	declare @basename		varchar(40)		set @basename		= ''

	declare @composesale	int				set @composesale	= 0			-- 할인률.
	declare @rand			int				set @rand			= 0

	declare @bgcomposecnt	int				set @bgcomposecnt	= 0			-- 합성포인트.
	declare @resultpoint	int				set @resultpoint	= 0

	declare @rand3			int
	--declare @curhour		int				set @curhour		= 0

	-- 신규동물의 능력치.
	declare @bkcomposecnt	int				set @bkcomposecnt	= 0
	declare @upstepmax		int				set @upstepmax		= 0
	declare @idx2			int				set @idx2			= 0
Begin
	------------------------------------------------
	--	3-1. 초기화.
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	set @comment  = '알수 없는 오류가 발생했습니다.'
	--select 'DEBUG 3-1 입력값', @gameid_ gameid_, @password_ password_, @mode_ mode_, @itemcode_ itemcode_, @listidxbase_ listidxbase_, @listidxs1_ listidxs1_, @listidxs2_ listidxs2_, @listidxs3_ listidxs3_, @listidxs4_ listidxs4_, @randserial_ randserial_

	------------------------------------------------
	--	3-2. 연산수행(유저정보, 선물정보, 아이템 종류)
	------------------------------------------------
	select
		@gameid 		= gameid,			@kakaonickname 	= kakaonickname,
		@famelv			= famelv,			@gameyear		= gameyear,			@gamemonth		= gamemonth,
		@anireplistidx	= anireplistidx,
		@anirepitemcode	= anirepitemcode,	@anirepacc1		= anirepacc1,		@anirepacc2		= anirepacc2,
		@market			= market,			@cashcost		= cashcost,			@gamecost		= gamecost,			@heart			= heart,	@feed			= feed,
		@bgcomposecnt	= bgcomposecnt,		@bgcomposeic	= bgcomposeic,		@bgcomposert	= bgcomposert,
		@bgcomposewt	= bgcomposewt,		@bgcomposecc 	= bgcomposecc,		@bkcomposecnt	= bkcomposecnt,
		@randserial		= randserial
	from dbo.tUserMaster where gameid = @gameid_ and password = @password_
	--select 'DEBUG 3-2 유저정보', @gameid gameid, @market market, @cashcost cashcost, @gamecost gamecost, @heart heart, @randserial randserial, @bgcomposeic bgcomposeic, @bgcomposert bgcomposert

	-- 동물합성 마스터 정보.
	select
		@itemcode		= itemcode,		@itemname		= itemname,
		@needheart		= param1,		@needgamecost	= param2,		@needcashcost	= param3,		@needcomposeticket= param16,
		@onepercent		= param4,		@needcnt		= param5,
		@mbase			= param6,		@msource1		= param7,		@msource2		= param8,		@msource3		= param9,	@msource4		= param10,
		@mresultfail	= param11,		@mresultsuccess	= param12,		@needtime		= param13,
		@needtimecashcost= param14,		@resultpoint	= param15
	from dbo.tItemInfo where itemcode = @itemcode_ and subcategory = @ITEM_SUBCATEGORY_COMPOSE
	--select 'DEBUG 3-3', @itemcode itemcode, @needheart needheart, @needgamecost needgamecost, @needcashcost needcashcost, @onepercent onepercent, @needcnt needcnt, @mbase mbase, @msource1 msource1, @msource2 msource2, @msource3 msource3, @msource4 msource4, @mresultfail mresultfail, @mresultsuccess mresultsuccess, @needtimecashcost needtimecashcost

	-------------------------------------
	-- 보유템 합성의 훈장 정보.
	-------------------------------------
	select @composeticket = cnt, @composeticketlistidx = listidx from dbo.tUserItem where gameid = @gameid_ and itemcode = @ITEM_COMPOSETICKET_MOTHER and invenkind = @USERITEM_INVENKIND_CONSUME
	--select 'DEBUG ', @composeticket composeticket, @needcomposeticket needcomposeticket

	-------------------------------------
	-- 보유템 동물 정보.
	-------------------------------------
	if(@listidxbase_ != -1)
		begin
			select @baseitemcode = itemcode from dbo.tUserItem where gameid = @gameid_ and listidx = @listidxbase_ and invenkind = @USERITEM_INVENKIND_ANI

			if(@baseitemcode != -1)
				begin
					select @basename = itemname from dbo.tItemInfo where itemcode = @baseitemcode
				end
		end
	if(@listidxs1_ != -1)
		begin
			select @s1itemcode = itemcode from dbo.tUserItem where gameid = @gameid_ and listidx = @listidxs1_ and invenkind = @USERITEM_INVENKIND_ANI
		end
	if(@listidxs2_ != -1)
		begin
			select @s2itemcode = itemcode from dbo.tUserItem where gameid = @gameid_ and listidx = @listidxs2_ and invenkind = @USERITEM_INVENKIND_ANI
		end
	if(@listidxs3_ != -1)
		begin
			select @s3itemcode = itemcode from dbo.tUserItem where gameid = @gameid_ and listidx = @listidxs3_ and invenkind = @USERITEM_INVENKIND_ANI
		end
	if(@listidxs4_ != -1)
		begin
			select @s4itemcode = itemcode from dbo.tUserItem where gameid = @gameid_ and listidx = @listidxs4_ and invenkind = @USERITEM_INVENKIND_ANI
		end

	--select 'DEBUG 3-4-1', @listidxbase_ listidxbase_, @baseitemcode baseitemcode, @listidxs1_ listidxs1_, @s1itemcode s1itemcode, @listidxs2_ listidxs2_, @s2itemcode s2itemcode, @listidxs3_ listidxs3_, @s3itemcode s3itemcode, @listidxs4_ listidxs4_, @s4itemcode s4itemcode
	set @curcnt = @curcnt + case when (@baseitemcode != -1) then 1 else 0 end
	set @curcnt = @curcnt + case when (@s1itemcode != -1) then 1 else 0 end
	set @curcnt = @curcnt + case when (@s2itemcode != -1) then 1 else 0 end
	set @curcnt = @curcnt + case when (@s3itemcode != -1) then 1 else 0 end
	set @curcnt = @curcnt + case when (@s4itemcode != -1) then 1 else 0 end
	--select 'DEBUG 3-4-2', @curcnt curcnt, @needcnt needcnt

	-- 모드 점검
	if(@mode_ = @MODE_ANI_COMPOSE_FULL and @needcnt > @curcnt)
		begin
			--select 'DEBUG 3-4-3 수량부족해서 FULL -> LACK 모드 변경', @curcnt curcnt, @needcnt needcnt
			set @mode_ = @MODE_ANI_COMPOSE_LACK_HAKROUL
		end
	else if(@mode_ = @MODE_ANI_COMPOSE_LACK_HAKROUL and @needcnt = @curcnt)
		begin
			--select 'DEBUG 3-4-3 수량같아서 FULL <- LACK모드 변경', @curcnt curcnt, @needcnt needcnt
			set @mode_ = @MODE_ANI_COMPOSE_FULL
		end

	-- 할인가격.
	if(@mode_ = @MODE_ANI_COMPOSE_LACK_CASHCOST)
		begin
			select top 1
				@composesale	= composesale
			from dbo.tSystemInfo order by idx desc
			--select 'DEBUG 3-5 합성루비 (원가)', @composesale composesale, @needcashcost needcashcost
			set @needcashcost = @needcashcost - (@needcashcost * @composesale)/100
			--select 'DEBUG 3-5 합성루비 (할인)', @composesale composesale, @needcashcost needcashcost

			set @needcashcost = @needcashcost * (@needcnt - @curcnt)
			--select 'DEBUG 3-5 합성가격', @needcashcost needcashcost, @needcnt needcnt, @curcnt curcnt
		end
	else
		begin
			set @needcashcost = 0
			--select 'DEBUG 3-5 합성를 FULL, LACK모드 루비가격(0)', @needcashcost needcashcost
		end


	------------------------------------------------
	--	3-3. 각상황별로 코드로 분류
	------------------------------------------------
	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR 아이디가 존재하지 않는다.'
			--select 'DEBUG 4' + @comment
		END
	else if (@mode_ not in (@MODE_ANI_COMPOSE_FULL, @MODE_ANI_COMPOSE_LACK_HAKROUL, @MODE_ANI_COMPOSE_LACK_CASHCOST))
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment = 'ERROR 지원하지 않는 모드입니다.'
			--select 'DEBUG ' + @comment
		END
	else if (@randserial_ = @randserial)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment = 'SUCCESS 합성 처리합니다(이미한것 재전송).'
			--select 'DEBUG ' + @comment
		END
	else if(getdate() < @bgcomposewt)
		BEGIN
			select @seedgapsecond = dbo.fnu_GetDatePart('ss', @bgcomposewt, getdate())
			set @nResult_ 	= @RESULT_ERROR_TIME_REMAIN
			set @comment 	= '시간이 남음 ('+ltrim(rtrim(str(-@seedgapsecond)))+'초)'
			--select 'DEBUG ' + @comment
		END
	else if (@itemcode = -1 or @baseitemcode = -1 or (@s1itemcode = -1 and @s2itemcode = -1 and @s3itemcode = -1 and @s4itemcode = -1))
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_ITEMCODE
			set @comment = 'ERROR 코드를 찾을수 없습니다.(1)'
			--select 'DEBUG ' + @comment
		END
	else if ((@listidxbase_ != -1 and @baseitemcode = -1)
			or (@listidxs1_ != -1 and @s1itemcode = -1)
			or (@listidxs2_ != -1 and @s2itemcode = -1)
			or (@listidxs3_ != -1 and @s3itemcode = -1)
			or (@listidxs4_ != -1 and @s4itemcode = -1))
		BEGIN
			set @nResult_ = @RESULT_ERROR_LISTIDX_NOT_FOUND
			set @comment = 'ERROR 해당 리스트를 찾을수 없습니다.(2)'
			--select 'DEBUG ' + @comment
		END
	else if ((@baseitemcode != -1  and @s1itemcode != -1 and @baseitemcode != @s1itemcode)
			or (@s1itemcode != -1 and @s2itemcode != -1 and @s1itemcode != @s2itemcode)
			or (@s2itemcode != -1 and @s3itemcode != -1 and @s2itemcode != @s3itemcode)
			or (@s3itemcode != -1 and @s4itemcode != -1 and @s3itemcode != @s4itemcode)
			)
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_MATCH
			set @comment = 'ERROR 합성을 위한 아이템이 매치가 안된다.'
			--select 'DEBUG ' + @comment
		END
	else if (@mbase != @baseitemcode)
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment = 'ERROR 지원하지 않는 모드입니다(베이스 동물이틀림).'
			--select 'DEBUG ' + @comment
		END
	else if (@heart < @needheart)
		BEGIN
			set @nResult_ = @RESULT_ERROR_HEART_LACK
			set @comment = 'ERROR 하트부족합니다.'
			--select 'DEBUG ' + @comment
		END
	else if (@gamecost < @needgamecost)
		BEGIN
			set @nResult_ = @RESULT_ERROR_GAMECOST_LACK
			set @comment = 'ERROR 코인부족합니다.'
			--select 'DEBUG ' + @comment
		END
	else if(@mode_ = @MODE_ANI_COMPOSE_LACK_CASHCOST and @cashcost < @needcashcost)
		BEGIN
			-- 단일 가격을 반영해서 xN를 적용했다.
			set @nResult_ 	= @RESULT_ERROR_CASHCOST_LACK
			set @comment 	= 'ERROR 캐쉬가 부족합니다.'
			--select 'DEBUG ' + @comment
		END
	else if (@composeticket < @needcomposeticket)
		BEGIN
			set @nResult_ = @RESULT_ERROR_ITEM_LACK
			set @comment = 'ERROR 아이템이 부족합니다..'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 합성 처리합니다.'
			--select 'DEBUG ' + @comment

			set @rand = 0
			if(@mode_ = @MODE_ANI_COMPOSE_FULL)
				begin
					set @rand 		= 100
					set @onepercent = 100
					--select 'DEBUG 풀합성'

					exec spu_DayLogInfoStatic @market, 65, 1				-- 일      일반합성.
				end
			else if(@mode_ = @MODE_ANI_COMPOSE_LACK_HAKROUL)
				begin
					set @rand 		= Convert(int, ceiling(RAND() * 100))
					set @onepercent = (@curcnt - 1) * @onepercent
					----------------------------------------------
					--5마리	원본	25	50	75	100
					--		변경	20	45	70	100
					--4마리	원본	33	66	100
					--		변경	28	60	100
					--3마리	원본	50	100
					--		변경	45	100
					----------------------------------------------
					--select 'DEBUG 확률합성(전)', @needcnt needcnt, @curcnt curcnt, @onepercent onepercent
					if(@needcnt != @curcnt)
						begin
							--select 'DEBUG > 하락시킴'
							set @onepercent = @onepercent - 5
						end
					--select 'DEBUG 확률합성(후)', @needcnt needcnt, @curcnt curcnt, @onepercent onepercent

					exec spu_DayLogInfoStatic @market, 65, 1				-- 일      일반합성.
				end
			else if(@mode_ = @MODE_ANI_COMPOSE_LACK_CASHCOST)
				begin
					set @rand 		= 100
					set @onepercent = 100
					set @cashcost 	= @cashcost - @needcashcost
					--select 'DEBUG 루비합성'

					set @needtime = -10

					exec spu_DayLogInfoStatic @market, 66, 1				-- 일      캐쉬합성.
				end
			set @heart 		= @heart - @needheart
			set @gamecost 	= @gamecost - @needgamecost
			--select 'DEBUG ', @rand rand, @onepercent onepercent, @heart heart, @gamecost gamecost, @cashcost cashcost

			------------------------------------------------
			-- base > 성공, 실패.
			-- source1 ~ 4 > 인덱스 삭제(합성삭제로기록)
			------------------------------------------------
			--if(@listidxbase_ != -1)
			--	begin
			--		exec spu_DeleteUserItemBackup 3, @gameid_, @listidxbase_
			--	end

			if(@listidxs1_ != -1)
				begin
					exec spu_DeleteUserItemBackup 3, @gameid_, @listidxs1_
				end
			if(@listidxs2_ != -1)
				begin
					exec spu_DeleteUserItemBackup 3, @gameid_, @listidxs2_
				end
			if(@listidxs3_ != -1)
				begin
					exec spu_DeleteUserItemBackup 3, @gameid_, @listidxs3_
				end
			if(@listidxs4_ != -1)
				begin
					exec spu_DeleteUserItemBackup 3, @gameid_, @listidxs4_
				end
			-----------------------------------------
			-- 대표동물 죽으면 기본동물로 세팅
			-----------------------------------------
			if(@anireplistidx in (@listidxs1_, @listidxs2_, @listidxs3_, @listidxs4_))
				begin
					set @anireplistidx	= -1
					set @anirepitemcode =  1
					set @anirepacc1	 	= -1
					set @anirepacc2 	= -1
				end

			------------------------------------------------
			-- 성공, 실패 확인.
			------------------------------------------------
			if(@rand <= @onepercent)
				begin
					--select 'DEBUG 합성 성공'
					set @bgcomposeic	= @mresultsuccess
					set @bgcomposert	= @COMPOSE_RESULT_SUCCESS

					-- 성공 > 합성포인트 누적.
					set @bgcomposecnt	= @bgcomposecnt + @resultpoint
					set @bkcomposecnt	= @bkcomposecnt + 1
				end
			else
				begin
					--select 'DEBUG 합성 실패'
					set @bgcomposeic	= @mresultfail
					set @bgcomposert	= @COMPOSE_RESULT_FAIL
				end
			set @bgcomposecc = @needtimecashcost
			select
				@bgcomposename 	= itemname,
				@upstepmax		= param30
			from dbo.tItemInfo where itemcode = @bgcomposeic
			--select 'DEBUG ', @bgcomposecc bgcomposecc, @bkcomposecnt bkcomposecnt

			------------------------------------------------------------------
			-- 합성 변경해주기.
			--> 합성 -> 성공 > 상위 동물로 이동.
			--> 합성 -> 실패 > 현상유지.
			------------------------------------------------------------------
			--select 'DEBUG 합성 선물지급',  @bgcomposeic bgcomposeic, @bgcomposert bgcomposert, @bgcomposename bgcomposename
			if( @bgcomposert = @COMPOSE_RESULT_SUCCESS )
				begin
					--select 'DEBUG 합성 -> 성공 > 상위 동물, 능력초기화'
					update dbo.tUserItem
						set
							upcnt		= 0,
							freshstem100= 0, 		attstem100 	= 0, 	timestem100	= 0, 	defstem100 = 0, hpstem100 = 0,
							upstepmax	= @upstepmax,
							itemcode 	= @bgcomposeic,
							writedate	= getdate(),
							gethow		= @DEFINE_HOW_GET_COMPOSE
					where gameid = @gameid_ and listidx = @listidxbase_ and invenkind = @USERITEM_INVENKIND_ANI
				end
			else
				begin
					--select 'DEBUG 합성 -> 실패 > 현상유지'
					update dbo.tUserItem
						set
							itemcode 	= @bgcomposeic,
							writedate	= getdate(),
							gethow		= @DEFINE_HOW_GET_COMPOSE
					where gameid = @gameid_ and listidx = @listidxbase_ and invenkind = @USERITEM_INVENKIND_ANI
				end

			------------------------------------------------------------------
			-- 합성 티켓 수량감소
			------------------------------------------------------------------
			if( @composeticket > 0 )
				begin
					update dbo.tUserItem
						set
							cnt = cnt - @needcomposeticket
					where gameid = @gameid_ and listidx = @composeticketlistidx
				end

			--------------------------------
			-- 구매기록마킹
			--------------------------------
			exec spu_UserItemBuyLogNew @gameid_, @itemcode_, @needgamecost, @needcashcost, 0

			--------------------------------
			-- 합성 로그 기록
			--------------------------------
			set @idx2 = 1
			select @idx2 = isnull( max( idx2 ), 0 ) + 1 from dbo.tComposeLogPerson where gameid = @gameid_
			insert into dbo.tComposeLogPerson(gameid,   idx2,  famelv,  gameyear,  gamemonth,      heart,      cashcost,      gamecost,             ticket,  itemcode, itemcodename,     itemcode0,   itemcode1,   itemcode2,   itemcode3,   itemcode4,  itemcode0name,  bgcomposeic,  bgcomposert,  bgcomposename, kind)
			values(                          @gameid_, @idx2, @famelv, @gameyear, @gamemonth, @needheart, @needcashcost, @needgamecost, @needcomposeticket, @itemcode,    @itemname, @baseitemcode, @s1itemcode, @s2itemcode, @s3itemcode, @s4itemcode,      @basename, @bgcomposeic, @bgcomposert, @bgcomposename, @mode_)
			if(@idx2 - @USER_LOG_MAX > 0)
				begin
					delete from dbo.tComposeLogPerson where gameid = @gameid_ and idx2 < @idx2 - @USER_LOG_MAX
				end

			------------------------------------------------
			-- 도감 갱신.
			------------------------------------------------
			if(@bgcomposeic != -1)
				begin
					exec spu_DogamListLog @gameid_, @bgcomposeic
				end

			------------------------------------------------
			-- 합성 시간 갱신.
			------------------------------------------------
			set @bgcomposewt = DATEADD(ss, @needtime, getdate())

			--set @curhour = DATEpart(Hour, getdate())
			--if(@curhour = @COMPOSE_FREE_HOUR)
			--	begin
			--		---------------------------------------------------------
			--		-- 10초 정도 대기시간을 주는 이벤트를 넣어주어야할듯함.
			--		-- 바로하니까 클라이언트에서 -6초 지나감.
			--		-- set @bgcomposewt = getdate()
			--		---------------------------------------------------------
			--		set @bgcomposewt = DATEADD(ss, 10, getdate())
			--	end

			------------------------------------------------------------------
			-- 합성 광고하기.
			------------------------------------------------------------------
			exec spu_RoulAdLogNew @gameid_, @kakaonickname, 3, @bgcomposeic, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1

			--set @rand3	= Convert(int, ceiling(RAND() * 100))
			--if(@bgcomposert	= @COMPOSE_RESULT_SUCCESS and @rand3 < 10)
			--	begin
			--		exec spu_RoulAdLogNew @gameid_, @kakaonickname, 3, @bgcomposeic, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1
			--	end

		END



	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost, @heart heart, @feed feed, @randserial randserial, @bgcomposeic bgcomposeic, @bgcomposert bgcomposert, @bgcomposewt bgcomposewt, @bgcomposecc bgcomposecc

	if(@nResult_ = @RESULT_SUCCESS)
		begin
			-- 아이템을 직접 넣어줌
			update dbo.tUserMaster
				set
					cashcost		= @cashcost,		gamecost		= @gamecost,		heart		= @heart,		feed		= @feed,
					bgcomposecnt	= @bgcomposecnt,
					bgcomposeic		= @bgcomposeic,		bgcomposert		= @bgcomposert,
					bgcomposewt		= @bgcomposewt,		bgcomposecc		= @bgcomposecc,
					anireplistidx 	= @anireplistidx,	anirepitemcode 	= @anirepitemcode,
					anirepacc1		= @anirepacc1,		anirepacc2		= @anirepacc2,
					bkcomposecnt	= @bkcomposecnt,
					randserial		= @randserial_
			where gameid = @gameid_

			--------------------------------------------------------------
			-- 변경된 동물 정보.
			--------------------------------------------------------------
			select * from dbo.tUserItem
			where gameid = @gameid_ and listidx in (@listidxbase_)
		end
	set nocount off
End

