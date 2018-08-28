---------------------------------------------------------------
/*
* 스크립트로 모든 동물 승급테스트 해볼것.
* 엑셀 정의 하기.


--select * from dbo.tUserItem where gameid = 'xxxx2'
--exec spu_SetDirectItemNew 'xxxx2',   3600, 100000, 1, -1	-- 승급의 꽃
-- 동물승급하기.
delete from dbo.tGiftList where gameid in ('xxxx2')
delete from dbo.tUserItem where gameid in ('xxxx2') and invenkind in (1)
update dbo.tUserMaster set cashcost = 100000, gamecost = 100000, heart = 100000, randserial = -1 where gameid = 'xxxx2'
insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow, upstepmax) values('xxxx2', 21, 1, 1, 0, -1, 1, 5, 8)   insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow, upstepmax) values('xxxx2', 22, 2, 1, 0, -1, 1, 5, 8)
insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow, upstepmax) values('xxxx2', 31, 4, 1, 0, -1, 1, 5, 24)  insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow, upstepmax) values('xxxx2', 32, 5, 1, 0, -1, 1, 5, 24)  insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow, upstepmax) values('xxxx2', 33, 6, 1, 0, -1, 1, 5, 32)
insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow, upstepmax) values('xxxx2', 41, 13, 1, 0, -1, 1, 5, 88) insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow, upstepmax) values('xxxx2', 42, 14, 1, 0, -1, 1, 5, 96) insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow, upstepmax) values('xxxx2', 43, 15, 1, 0, -1, 1, 5, 96) insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow, upstepmax) values('xxxx2', 44, 15, 1, 0, -1, 1, 5, 96)
insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow, upstepmax) values('xxxx2', 51, 100, 1, 0, -1, 1, 5, 8)
update dbo.tUserItem set upcnt = upstepmax, freshstem100 = 1, attstem100 = 2, timestem100 = 3, defstem100 = 4, hpstem100 = 5 where gameid in ('xxxx2')

exec spu_AniPromote 'xxxx2', '049000s1i0n7t8445289', 102000, 21, 22, -1, -1, -1, 999991, -1	-- 2마리
exec spu_AniPromote 'xxxx2', '049000s1i0n7t8445289', 102001, 31, 32, 33, -1, -1, 999992, -1	-- 3마리
exec spu_AniPromote 'xxxx2', '049000s1i0n7t8445289', 102004, 41, 42, 43, 44, -1, 999994, -1	-- 4마리.

exec spu_AniPromote 'xxxx2', '049000s1i0n7t8445289', 102000, 21, 32, -1, -1, -1, 999993, -1	-- 등급이 틀림.
exec spu_AniPromote 'xxxx2', '049000s1i0n7t8445289', 102000, 21, 51, -1, -1, -1, 999993, -1	-- 동물종류가 틀림.

*/
use Game4Farmvill5
GO

IF OBJECT_ID ( 'dbo.spu_AniPromote', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_AniPromote;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_AniPromote
	@gameid_				varchar(20),
	@password_				varchar(20),
	@itemcode_				int,
	@listidxs1_				int,
	@listidxs2_				int,
	@listidxs3_				int,
	@listidxs4_				int,
	@listidxs5_				int,
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
	declare @RESULT_ERROR_TICKET_LACK			int				set @RESULT_ERROR_TICKET_LACK			= -150			-- 목장도전불가.
	declare @RESULT_ERROR_DIFFERENT_GRADE		int				set @RESULT_ERROR_DIFFERENT_GRADE		= -154			-- 동물의 등급이 다릅니다.
	declare @RESULT_ERROR_ANIMAL_LACK			int				set @RESULT_ERROR_ANIMAL_LACK			= -155			-- 동물의 수량이 부족합니다.

	------------------------------------------------
	--	2-2. 정의된값
	------------------------------------------------
	-- 아이템별 인벤분류
	declare @USERITEM_INVENKIND_ANI				int 				set @USERITEM_INVENKIND_ANI					= 1
	declare @USERITEM_INVENKIND_CONSUME			int 				set @USERITEM_INVENKIND_CONSUME				= 3

	-- 아이템 소분류
	declare @ITEM_SUBCATEGORY_PROMOTE			int					set @ITEM_SUBCATEGORY_PROMOTE				= 1020 	--동물승급(1020)

	-- 선물 정의값
	declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2

	-- 그룹.
	--declare @ITEM_COMPOSETICKET_MOTHER		int					set @ITEM_COMPOSETICKET_MOTHER				= 3500	-- 합성의 훈장.
	declare @ITEM_PROMOTETICKET_MOTHER			int					set @ITEM_PROMOTETICKET_MOTHER				= 3600	-- 승급의 꽃.

	-- 아이템 획득방법
	--declare @DEFINE_HOW_GET_COMPOSE			int					set @DEFINE_HOW_GET_COMPOSE					= 11--합성
	declare @DEFINE_HOW_GET_PROMOTE				int					set @DEFINE_HOW_GET_PROMOTE					= 18--승급.

	-- 기타값들.
	declare @USER_LOG_MAX						int					set @USER_LOG_MAX 							= 20	-- 테스트용.

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
	declare @market			int				set @market			= 5
	declare @cashcost		int				set @cashcost 		= 0
	declare @gamecost		int				set @gamecost 		= 0
	declare @heart			int				set @heart 			= 0
	declare @feed			int				set @feed 			= 0
	declare @bgpromoteic	int				set @bgpromoteic	= -1
	declare @bgpromotename	varchar(40)		set @bgpromotename	= ''
	declare @bkpromotecnt	int				set @bkpromotecnt	= 0
	declare @bgpromotecnt	int				set @bgpromotecnt	= 0
	declare @randserial		varchar(20)		set @randserial		= '-1'

	declare @itemcode		int				set @itemcode		= -1		-- 승급마스터 정보.
	declare @itemname		varchar(40)		set @itemname		= ''
	declare @needheart		int				set @needheart		= 99999
	declare @needgamecost	int				set @needgamecost 	= 99999
	declare @needpromoteticket	int			set @needpromoteticket= 99999
	declare @needcnt		int				set @needcnt		= 2
	declare @base1			int				set @base1			= -1
	declare @base2			int				set @base2			= -1
	declare @base3			int				set @base3			= -1
	declare @base4			int				set @base4			= -1
	declare @base5			int				set @base5			= -1
	declare @result1		int				set @result1		= -1
	declare @result2		int				set @result2		= -1
	declare @result3		int				set @result3		= -1
	declare @result4		int				set @result4		= -1
	declare @result5		int				set @result5		= -1
	declare @randvalue1		int				set @randvalue1		= 0
	declare @randvalue2		int				set @randvalue2		= 0
	declare @randvalue3		int				set @randvalue3		= 0
	declare @randvalue4		int				set @randvalue4		= 0
	declare @randvalue5		int				set @randvalue5		= 0
	declare @resultlist		varchar(40)		set @resultlist		= ''

	declare @promoteticket	int				set @promoteticket	= 0
	declare @promoteticketlistidx	int		set @promoteticketlistidx= -1

	declare @s1itemcode		int				set @s1itemcode		= -1
	declare @s2itemcode		int				set @s2itemcode		= -1
	declare @s3itemcode		int				set @s3itemcode		= -1
	declare @s4itemcode		int				set @s4itemcode		= -1
	declare @s5itemcode		int				set @s5itemcode		= -1
	declare @s1lv			int				set @s1lv			= 0
	declare @s2lv			int				set @s2lv			= 0
	declare @s3lv			int				set @s3lv			= 0
	declare @s4lv			int				set @s4lv			= 0
	declare @s5lv			int				set @s5lv			= 0
	declare @s1grade		int				set @s1grade		= -999
	declare @s2grade		int				set @s2grade		= -999
	declare @s3grade		int				set @s3grade		= -999
	declare @s4grade		int				set @s4grade		= -999
	declare @s5grade		int				set @s5grade		= -999
	declare @curcnt			int				set @curcnt			= 0
	declare @gradecnt		int				set @gradecnt		= 0

	declare @rand			int				set @rand			= 0
	declare @randmax		int				set @randmax		= 0
	declare @rand3			int

	-- 신규동물의 능력치.
	declare @upstepmax		int				set @upstepmax		= 0
	declare @idx2			int				set @idx2			= 0
Begin
	------------------------------------------------
	--	3-1. 초기화.
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	set @comment  = '알수 없는 오류가 발생했습니다.'
	--select 'DEBUG 3-1 입력값', @gameid_ gameid_, @password_ password_, @itemcode_ itemcode_, @listidxs1_ listidxs1_, @listidxs2_ listidxs2_, @listidxs3_ listidxs3_, @listidxs4_ listidxs4_, @listidxs5_ listidxs5_, @randserial_ randserial_

	------------------------------------------------
	--	3-2. 연산수행(유저정보, 선물정보, 아이템 종류)
	------------------------------------------------
	select
		@gameid 		= gameid,			@kakaonickname 	= kakaonickname,	@famelv			= famelv,			@gameyear		= gameyear,			@gamemonth		= gamemonth,		@market			= market,
		@cashcost		= cashcost,			@gamecost		= gamecost,			@heart			= heart,			@feed			= feed,
		@anireplistidx	= anireplistidx,	@anirepitemcode	= anirepitemcode,	@anirepacc1		= anirepacc1,		@anirepacc2		= anirepacc2,
		@bgpromoteic	= bgpromoteic,		@bkpromotecnt	= bkpromotecnt,		@bgpromotecnt	= bgpromotecnt,
		@randserial		= randserial
	from dbo.tUserMaster where gameid = @gameid_ and password = @password_
	--select 'DEBUG 3-2 유저정보', @gameid gameid, @market market, @cashcost cashcost, @gamecost gamecost, @heart heart, @randserial randserial, @bgpromoteic bgpromoteic

	-------------------------------------
	-- 동물승급 마스터 정보.
	-------------------------------------
	select
		@itemcode		= itemcode,		@itemname		= itemname,
		@needheart		= param1,		@needgamecost	= param2,		@needpromoteticket= param3,		@needcnt	= param4,
		@base1			= param5,		@base2			= param6,		@base3			= param7,		@base4		= param8,	@base5		= param9,
		@result1		= param10,		@result2		= param11,		@result3		= param12,		@result4	= param13,	@result5	= param14,
		@randvalue1		= param15,		@randvalue2		= param16,		@randvalue3		= param17,		@randvalue4	= param18,	@randvalue5	= param19
	from dbo.tItemInfo where itemcode = @itemcode_ and subcategory = @ITEM_SUBCATEGORY_PROMOTE
	--select 'DEBUG 3-3', @itemcode itemcode, @needheart needheart, @needgamecost needgamecost, @needpromoteticket needpromoteticket, @needcnt needcnt, @base1 base1, @base2 base2, @base3 base3, @base4 base4, @base5 base5, @result1 result1, @result2 result2, @result3 result3, @result4 result4, @result5 result5

	-------------------------------------
	-- 보유템 승급의 꽃 정보.
	-------------------------------------
	select
		@promoteticket 			= cnt,
		@promoteticketlistidx 	= listidx
	from dbo.tUserItem
	where gameid = @gameid_ and itemcode = @ITEM_PROMOTETICKET_MOTHER and invenkind = @USERITEM_INVENKIND_CONSUME
	--select 'DEBUG ', @promoteticket promoteticket, @needpromoteticket needpromoteticket

	-------------------------------------
	-- 보유템 동물 정보.
	-------------------------------------
	if(@listidxs1_ != -1)
		begin
			select @s1itemcode = itemcode, @s1lv = upcnt from dbo.tUserItem where gameid = @gameid_ and listidx = @listidxs1_ and invenkind = @USERITEM_INVENKIND_ANI

			if( @s1itemcode != -1 )
				begin
					select @s1lv = @s1lv / param29, @s1grade = grade from dbo.tItemInfo where itemcode = @s1itemcode
				end
		end
	if(@listidxs2_ != -1)
		begin
			select @s2itemcode = itemcode, @s2lv = upcnt from dbo.tUserItem where gameid = @gameid_ and listidx = @listidxs2_ and invenkind = @USERITEM_INVENKIND_ANI

			if( @s2itemcode != -1 )
				begin
					select @s2lv = @s2lv / param29, @s2grade = grade from dbo.tItemInfo where itemcode = @s2itemcode
				end
		end
	if(@listidxs3_ != -1)
		begin
			select @s3itemcode = itemcode, @s3lv = upcnt from dbo.tUserItem where gameid = @gameid_ and listidx = @listidxs3_ and invenkind = @USERITEM_INVENKIND_ANI

			if( @s3itemcode != -1 )
				begin
					select @s3lv = @s3lv / param29, @s3grade = grade from dbo.tItemInfo where itemcode = @s3itemcode
				end
		end
	if(@listidxs4_ != -1)
		begin
			select @s4itemcode = itemcode, @s4lv = upcnt from dbo.tUserItem where gameid = @gameid_ and listidx = @listidxs4_ and invenkind = @USERITEM_INVENKIND_ANI

			if( @s4itemcode != -1 )
				begin
					select @s4lv = @s4lv / param29, @s4grade = grade from dbo.tItemInfo where itemcode = @s4itemcode
				end
		end
	if(@listidxs5_ != -1)
		begin
			select @s5itemcode = itemcode, @s5lv = upcnt from dbo.tUserItem where gameid = @gameid_ and listidx = @listidxs5_ and invenkind = @USERITEM_INVENKIND_ANI

			if( @s5itemcode != -1 )
				begin
					select @s5lv = @s5lv / param29, @s5grade = grade from dbo.tItemInfo where itemcode = @s5itemcode
				end
		end
	--select 'DEBUG 3-4-1', @listidxs1_ listidxs1_, @s1itemcode s1itemcode, @s1lv s1lv, @s1grade s1grade, @listidxs2_ listidxs2_, @s2itemcode s2itemcode, @s2lv s2lv, @s2grade s2grade, @listidxs3_ listidxs3_, @s3itemcode s3itemcode, @s3lv s3lv, @s3grade s3grade, @listidxs4_ listidxs4_, @s4itemcode s4itemcode, @s4lv s4lv, @s4grade s4grade, @listidxs5_ listidxs5_, @s5itemcode s5itemcode, @s5lv s5lv, @s5grade s5grade
	set @curcnt = @curcnt + case when (@s1itemcode != -1) then 1 else 0 end
	set @curcnt = @curcnt + case when (@s2itemcode != -1) then 1 else 0 end
	set @curcnt = @curcnt + case when (@s3itemcode != -1) then 1 else 0 end
	set @curcnt = @curcnt + case when (@s4itemcode != -1) then 1 else 0 end
	set @curcnt = @curcnt + case when (@s5itemcode != -1) then 1 else 0 end
	--select 'DEBUG 3-4-2', @curcnt curcnt, @needcnt needcnt

	set @gradecnt = @gradecnt + case when (@s1itemcode != -1                         ) then 1 else 0 end
	set @gradecnt = @gradecnt + case when (@s2itemcode != -1 and @s1grade = @s2grade ) then 1 else 0 end
	set @gradecnt = @gradecnt + case when (@s3itemcode != -1 and @s1grade = @s3grade ) then 1 else 0 end
	set @gradecnt = @gradecnt + case when (@s4itemcode != -1 and @s1grade = @s4grade ) then 1 else 0 end
	set @gradecnt = @gradecnt + case when (@s5itemcode != -1 and @s1grade = @s5grade ) then 1 else 0 end
	--select 'DEBUG 3-4-2', @gradecnt gradecnt, @needcnt needcnt, @s1grade s1grade, @s2grade s2grade, @s3grade s3grade, @s4grade s4grade, @s5grade s5grade

	------------------------------------------------
	--	3-3. 각상황별로 코드로 분류
	------------------------------------------------
	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR 아이디가 존재하지 않는다.'
			--select 'DEBUG 4' + @comment
		END
	else if (@randserial_ = @randserial)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment = 'SUCCESS 승급 처리합니다(이미한것 재전송).'
			--select 'DEBUG ' + @comment
		END
	else if (@itemcode = -1 or @s1itemcode = -1 or (@s2itemcode = -1 and @s3itemcode = -1 and @s4itemcode = -1 and @s5itemcode = -1))
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_ITEMCODE
			set @comment = 'ERROR 코드를 찾을수 없습니다.(1)'
			--select 'DEBUG ' + @comment
		END
	else if ( (  @listidxs1_ != -1 and @s1itemcode = -1 )
			or ( @listidxs2_ != -1 and @s2itemcode = -1 )
			or ( @listidxs3_ != -1 and @s3itemcode = -1 )
			or ( @listidxs4_ != -1 and @s4itemcode = -1 )
			or ( @listidxs5_ != -1 and @s5itemcode = -1 ))
		BEGIN
			set @nResult_ = @RESULT_ERROR_LISTIDX_NOT_FOUND
			set @comment = 'ERROR 해당 리스트를 찾을수 없습니다.(2)'
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
	else if (@promoteticket < @needpromoteticket)
		BEGIN
			set @nResult_ = @RESULT_ERROR_TICKET_LACK
			set @comment = 'ERROR 아이템이 부족합니다.(1승급템)'
			--select 'DEBUG ' + @comment
		END
	else if (@curcnt < @needcnt)
		BEGIN
			set @nResult_ = @RESULT_ERROR_ANIMAL_LACK
			set @comment = 'ERROR 동물의 수량이 부족합니다.'
			--select 'DEBUG ' + @comment
		END
	else if (@gradecnt != @needcnt)
		BEGIN
			set @nResult_ = @RESULT_ERROR_DIFFERENT_GRADE
			set @comment = 'ERROR 동물의 등급이 다릅니다.(1)'
			--select 'DEBUG ' + @comment
		END
	else if ( (  @listidxs1_ != -1 and @s1itemcode not in (@base1, @base2, @base3, @base4, @base5) )
			or ( @listidxs2_ != -1 and @s2itemcode not in (@base1, @base2, @base3, @base4, @base5) )
			or ( @listidxs3_ != -1 and @s3itemcode not in (@base1, @base2, @base3, @base4, @base5) )
			or ( @listidxs4_ != -1 and @s4itemcode not in (@base1, @base2, @base3, @base4, @base5) )
			or ( @listidxs5_ != -1 and @s5itemcode not in (@base1, @base2, @base3, @base4, @base5) ))
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_MATCH
			set @comment = 'ERROR 동물이 매칭되지 않습니다.'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 승급 처리합니다.'
			--select 'DEBUG ' + @comment

			----------------------------------------------
			--1마리	원본	r1
			--2마리	원본	r1	r2
			--3마리	원본	r1	r2	r3
			--4마리	원본	r1	r2	r3	r4
			--5마리	원본	r1	r2	r3	r4	r5
			----------------------------------------------
			set @randmax 	= @randvalue1 + @randvalue2 + @randvalue3 + @randvalue4 + @randvalue5
			set @rand 		= Convert(int, ceiling(RAND() * @randmax))
			set @bgpromoteic= dbo.fnu_GetRandomPromote(@rand, @result1, @result2, @result3, @result4, @result5, @randvalue1, @randvalue2, @randvalue3, @randvalue4, @randvalue5)
			--select 'DEBUG ', @rand rand, @randmax randmax, @bgpromoteic bgpromoteic, @result1 result1, @result2 result2, @result3 result3, @result4 result4, @result5 result5, @randvalue1 randvalue1, @randvalue2 randvalue2, @randvalue3 randvalue3, @randvalue4 randvalue4, @randvalue5 randvalue5

			-- 나온 동물의 정보를 세팅하기 위해서 max값 읽어오기.
			select
				@bgpromotename 	= itemname,
				@upstepmax		= param30
			from dbo.tItemInfo where itemcode = @bgpromoteic
			--select 'DEBUG 승급 > ', @bgpromoteic bgpromoteic, @bgpromotename bgpromotename, @upstepmax upstepmax

			----------------------------------------------
			-- 코인가 하트차감
			----------------------------------------------
			set @heart 		= @heart - @needheart
			set @gamecost 	= @gamecost - @needgamecost
			--select 'DEBUG ', @rand rand, @heart heart, @gamecost gamecost, @cashcost cashcost, @needpromoteticket needpromoteticket

			------------------------------------------------------------------
			-- 승급 티켓 수량감소
			------------------------------------------------------------------
			if( @promoteticket > 0 )
				begin
					update dbo.tUserItem
						set
							cnt = cnt - @needpromoteticket
					where gameid = @gameid_ and listidx = @promoteticketlistidx
				end

			------------------------------------------------
			-- 동물 서브 재료들 삭제
			-- source2 ~ 5 > 인덱스 삭제(승급삭제로기록)
			------------------------------------------------
			if(@listidxs2_ != -1)
				begin
					exec spu_DeleteUserItemBackup 6, @gameid_, @listidxs2_
				end
			if(@listidxs3_ != -1)
				begin
					exec spu_DeleteUserItemBackup 6, @gameid_, @listidxs3_
				end
			if(@listidxs4_ != -1)
				begin
					exec spu_DeleteUserItemBackup 6, @gameid_, @listidxs4_
				end
			if(@listidxs5_ != -1)
				begin
					exec spu_DeleteUserItemBackup 6, @gameid_, @listidxs5_
				end

			-----------------------------------------
			-- 대표동물 죽으면 기본동물로 세팅
			-----------------------------------------
			if(@anireplistidx in (@listidxs2_, @listidxs3_, @listidxs4_, @listidxs5_))
				begin
					set @anireplistidx	= -1
					set @anirepitemcode =  1
					set @anirepacc1	 	= -1
					set @anirepacc2 	= -1
				end


			------------------------------------------------
			-- 성공 퀘스트 데이타 누적
			------------------------------------------------
			set @bkpromotecnt	= @bkpromotecnt + 1
			set @bgpromotecnt	= @bgpromotecnt + 1


			------------------------------------------------------------------
			-- 승급 변경해주기.
			--> 승급 -> 성공 > 상위 동물로 이동.
			--> 승급 -> 실패 > 현상유지.
			------------------------------------------------------------------
			--select 'DEBUG 승급 > 상위, 능력초기화',  @bgpromoteic bgpromoteic, @bgpromotename bgpromotename
			update dbo.tUserItem
				set
					upcnt		= 0,
					freshstem100= 0, 		attstem100 	= 0, 	timestem100	= 0, 	defstem100 = 0, hpstem100 = 0,
					upstepmax	= @upstepmax,
					itemcode 	= @bgpromoteic,
					writedate	= getdate(),
					gethow		= @DEFINE_HOW_GET_PROMOTE
			where gameid = @gameid_ and listidx = @listidxs1_ and invenkind = @USERITEM_INVENKIND_ANI

			------------------------------------------------
			-- 기록 : 일반통계자료
			------------------------------------------------
			exec spu_DayLogInfoStatic @market, 67, 1				-- 일      일반승급.

			--------------------------------
			-- 구매기록마킹
			--------------------------------
			exec spu_UserItemBuyLogNew @gameid_, @itemcode_, @needgamecost, 0, @needheart

			--------------------------------
			-- 승급 로그 기록
			--------------------------------
			set @resultlist = ltrim(str(@result1)) + '/' + ltrim(str(@result2)) + '/' + ltrim(str(@result3)) + '/' + ltrim(str(@result4)) + '/' + ltrim(str(@result5))
			set @idx2 		= 1
			select @idx2 = isnull( max( idx2 ), 0 ) + 1 from dbo.tPromoteLogPerson where gameid = @gameid_
			insert into dbo.tPromoteLogPerson(gameid,   idx2,  famelv,  gameyear,  gamemonth,      heart, cashcost,             ticket,      gamecost,  itemcode, itemcodename,   itemcode0,   itemcode1,   itemcode2,   itemcode3,   itemcode4,  resultlist,  bgpromoteic,  bgpromotename, kind)
			values(                          @gameid_, @idx2, @famelv, @gameyear, @gamemonth, @needheart,        0, @needpromoteticket, @needgamecost, @itemcode,    @itemname, @s1itemcode, @s2itemcode, @s3itemcode, @s4itemcode, @s5itemcode, @resultlist, @bgpromoteic, @bgpromotename,    1)
			if(@idx2 - @USER_LOG_MAX > 0)
				begin
					delete from dbo.tPromoteLogPerson where gameid = @gameid_ and idx2 < @idx2 - @USER_LOG_MAX
				end
			--select 'DEBUG ', @resultlist resultlist

			------------------------------------------------
			-- 도감 갱신.
			------------------------------------------------
			if(@bgpromoteic != -1)
				begin
					exec spu_DogamListLog @gameid_, @bgpromoteic
				end

			------------------------------------------------------------------
			-- 승급 광고하기.
			------------------------------------------------------------------
			exec spu_RoulAdLogNew @gameid_, @kakaonickname, 100, @bgpromoteic, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1
		END

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost, @heart heart, @feed feed, @randserial randserial, @bgpromoteic bgpromoteic

	if(@nResult_ = @RESULT_SUCCESS)
		begin
			-- 아이템을 직접 넣어줌
			update dbo.tUserMaster
				set
					cashcost		= @cashcost,		gamecost		= @gamecost,		heart			= @heart,			feed			= @feed,
					anireplistidx 	= @anireplistidx,	anirepitemcode 	= @anirepitemcode,	anirepacc1		= @anirepacc1,		anirepacc2		= @anirepacc2,
					bgpromoteic		= @bgpromoteic,		bkpromotecnt	= @bkpromotecnt,	bgpromotecnt	= @bgpromotecnt,
					randserial		= @randserial_
			where gameid = @gameid_

			--------------------------------------------------------------
			-- 변경된 동물 정보.
			--------------------------------------------------------------
			select * from dbo.tUserItem
			where gameid = @gameid_ and listidx in (@listidxs1_)
		end

	set nocount off
End




