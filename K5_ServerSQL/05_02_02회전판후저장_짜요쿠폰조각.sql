use GameMTBaseball
Go

/*
update dbo.tUserMaster set randserial = -1, zcpchance = 1 where gameid = 'xxxx2'
delete from dbo.tUserItem where gameid = 'xxxx2' and itemcode in ( 3800, 3801 )
exec spu_ZCPChance 'xxxx2', '049000s1i0n7t8445289', 1,   0, 7771, -1			-- 짜요쿠폰조각 무료모드 (없는상태)

update dbo.tUserMaster set randserial = -1, zcpchance = 1 where gameid = 'xxxx2'
exec spu_ZCPChance 'xxxx2', '049000s1i0n7t8445289', 1,   0, 7773, -1			-- 짜요쿠폰조각 무료모드 (있는상태)

update dbo.tUserMaster set randserial = -1, cashcost = 15000 where gameid = 'xxxx2'
--delete from dbo.tUserItem where gameid = 'xxxx2' and itemcode in ( 3800, 3801 )
exec spu_ZCPChance 'xxxx2', '049000s1i0n7t8445289', 2, 200, 7781, -1			--  짜요쿠폰조각 유료모드 (없는상태)
exec spu_ZCPChance 'xxxx2', '049000s1i0n7t8445289', 2, 170, 7782, -1			--  짜요쿠폰조각 유료모드 (없는상태)

-----------------------------------------------------------
-- 15,000 -> 유료돌림 ( 짜요쿠폰 13 ~ 16개 정도 획득함 )
-----------------------------------------------------------
declare @gameid varchar(20)	set @gameid		= 'xxxx2'
declare @cashcost int		set @cashcost	= 15000
update dbo.tUserMaster set randserial = -1, cashcost = @cashcost where gameid = @gameid
delete from dbo.tUserItem where gameid = @gameid and itemcode in ( 3800, 3801 )
while ( @cashcost > 200 )
	begin
		exec spu_ZCPChance @gameid, '049000s1i0n7t8445289', 2, 200, 7781, -1			--  짜요쿠폰조각 유료모드 (없는상태)
		exec spu_ZCPChance @gameid, '049000s1i0n7t8445289', 2, 170, 7782, -1			--  짜요쿠폰조각 유료모드 (없는상태)
		select @cashcost = cashcost from dbo.tUserMaster where gameid = @gameid
	end

-----------------------------------------------------------
-- 100 -> 무료돌림 ( 짜요쿠폰 1.36 ~ 1.27 개 정도 획득함 )
-----------------------------------------------------------
declare @gameid varchar(20)	set @gameid		= 'xxxx2'
declare @cnt int			set @cnt		= 100
delete from dbo.tUserItem where gameid = @gameid and itemcode in ( 3800, 3801 )
while ( @cnt > 0 )
	begin
		update dbo.tUserMaster set randserial = -1, zcpchance = 1 where gameid = 'xxxx2'
		exec spu_ZCPChance 'xxxx2', '049000s1i0n7t8445289', 1,   0, 7771, -1			-- 짜요쿠폰조각 무료모드 (없는상태)
		set @cnt = @cnt - 1
	end


*/

IF OBJECT_ID ( 'dbo.spu_ZCPChance', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_ZCPChance;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_ZCPChance
	@gameid_				varchar(20),						-- 게임아이디
	@password_				varchar(20),						-- 암호화해서저장, 유저패스워가 해킹당해도 안전
	@mode_					int,
	@usedcashcost_			int,
	@randserial_			varchar(20),
	@nResult_				int					OUTPUT
	--WITH ENCRYPTION -- 프로시져를 암호화함.
as
	------------------------------------------------
	--	2-1. 코드값자리
	------------------------------------------------
	-- 일반값
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	--가입 오류.
	declare @RESULT_ERROR_ID_DUPLICATE			int				set @RESULT_ERROR_ID_DUPLICATE			= -2

	-- 세이브 오류.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함
	declare @RESULT_ERROR_CASHCOST_LACK			int				set @RESULT_ERROR_CASHCOST_LACK			= -22			--골드가 부족하다.
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- 지원하지않는모드
	declare @RESULT_ERROR_NOT_MATCH				int				set @RESULT_ERROR_NOT_MATCH				= -110			-- 무엇인가 매치가 안되었다.
	declare @RESULT_ERROR_NOT_FOUND_ZCPCHANCE	int				set @RESULT_ERROR_NOT_FOUND_ZCPCHANCE	= -161			-- 짜요쿠폰조각 획득판이 존재안합니다.

	-- 아이템 획득방법
	declare @DEFINE_HOW_GET_ZCP					int				set @DEFINE_HOW_GET_ZCP					= 20 --쿠폰룰렛.

	-- 선물 정의값
	declare @GIFTLIST_GIFT_KIND_MESSAGE			int				set @GIFTLIST_GIFT_KIND_MESSAGE			= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int				set @GIFTLIST_GIFT_KIND_GIFT			= 2

	-- 회전판 상수.
	declare @MODE_ZCPCHANCE_FREE				int				set @MODE_ZCPCHANCE_FREE				= 1			-- 무료모드(1)
	declare @MODE_ZCPCHANCE_CASH				int				set @MODE_ZCPCHANCE_CASH				= 2			-- 유료모드(2)

	-- 황금룰렛 금액.
	declare @PREMINUM_PRICE1					int				set @PREMINUM_PRICE1					= 200
	declare @PREMINUM_PRICE2					int				set @PREMINUM_PRICE2					= 170

	declare @ITEM_ZCP_PIECE_MOTHER				int				set @ITEM_ZCP_PIECE_MOTHER				= 3800	-- 짜요쿠폰조각.
	declare @ITEM_ZCP_TICKET_MOTHER				int				set @ITEM_ZCP_TICKET_MOTHER				= 3801	-- 짜요쿠폰.

	declare @USER_LOGOLIST_MAX					int				set @USER_LOGOLIST_MAX 					= 100
	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @comment				varchar(80)
	declare @sendid					varchar(20)
	declare @gameid					varchar(20)				set @gameid				= ''
	declare @market					int						set @market				= 5
	declare @cashcost				int						set @cashcost 			= 0
	declare @gamecost				int						set @gamecost 			= 0
	declare @zcpplus				int						set @zcpplus			= 0
	declare @zcpchance				int						set @zcpchance			= 0
	declare @bkzcpcntfree			int						set @bkzcpcntfree		= 0
	declare @bkzcpcntcash			int						set @bkzcpcntcash		= 0
	declare @randserial				varchar(20)				set @randserial			= '-1'
	declare @zcplistidx				int
	declare @zcpcnt					int
	declare @listidx				int						set @listidx			= -1
	declare @bchange				int						set @bchange			= 0

	declare @idx					int						set @idx				= 0
	declare @itemcode				int						set @itemcode			= 0
	declare @cnt					int						set @cnt				= 0
	declare @randval				int						set @randval			= 0
	declare @randvalfree			int						set @randvalfree		= 0
	declare @randvalcash			int						set @randvalcash		= 0
	declare @randsum				int						set @randsum			= 0
	declare @rand					int						set @rand				= 0
	declare @loop					int						set @loop				= 1
	declare @kind					int						set @kind				= @MODE_ZCPCHANCE_FREE

	-- 뽑기 리스트 정보.
	declare @idx1					int						set @idx1				= 0
	declare @idx2					int						set @idx2				= 0
	declare @idx3					int						set @idx3				= 0
	declare @idx4					int						set @idx4				= 0
	declare @idx5					int						set @idx5				= 0
	declare @idx6					int						set @idx6				= 0
	declare @idx7					int						set @idx7				= 0
	declare @idx8					int						set @idx8				= 0
	declare @itemcode1				int						set @itemcode1			= 0
	declare @itemcode2				int						set @itemcode2			= 0
	declare @itemcode3				int						set @itemcode3			= 0
	declare @itemcode4				int						set @itemcode4			= 0
	declare @itemcode5				int						set @itemcode5			= 0
	declare @itemcode6				int						set @itemcode6			= 0
	declare @itemcode7				int						set @itemcode7			= 0
	declare @itemcode8				int						set @itemcode8			= 0
	declare @cnt1					int						set @cnt1				= 0
	declare @cnt2					int						set @cnt2				= 0
	declare @cnt3					int						set @cnt3				= 0
	declare @cnt4					int						set @cnt4				= 0
	declare @cnt5					int						set @cnt5				= 0
	declare @cnt6					int						set @cnt6				= 0
	declare @cnt7					int						set @cnt7				= 0
	declare @cnt8					int						set @cnt8				= 0
	declare @randval1				int						set @randval1			= 0
	declare @randval2				int						set @randval2			= 0
	declare @randval3				int						set @randval3			= 0
	declare @randval4				int						set @randval4			= 0
	declare @randval5				int						set @randval5			= 0
	declare @randval6				int						set @randval6			= 0
	declare @randval7				int						set @randval7			= 0
	declare @randval8				int						set @randval8			= 0

	DECLARE @tTempTable TABLE(
		listidx		int
	);
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG 입력정보', @gameid_ gameid_, @password_ password_, @mode_ mode_, @usedcashcost_ usedcashcost_, @randserial_ randserial_

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	select
		@gameid 		= gameid, 			@market			= market,
		@cashcost		= cashcost,			@gamecost		= gamecost,
		@zcpplus		= zcpplus,			@zcpchance		= zcpchance,
		@bkzcpcntfree 	= bkzcpcntfree,		@bkzcpcntcash	= bkzcpcntcash,
		@idx			= bgroul1, 			@itemcode		= bgroul2,			@cnt 		= bgroul3,
		@randserial		= randserial
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 유저정보', @gameid gameid, @market market, @cashcost cashcost, @gamecost gamecost, @zcpplus zcpplus, @zcpchance zcpchance, @bkzcpcntfree bkzcpcntfree, @bkzcpcntcash bkzcpcntcash, @idx idx, @itemcode itemcode, @cnt cnt, @randserial randserial

	if( @gameid = '' )
		BEGIN
			-- 아이디가 존재하지않는가??
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '아이디가 존재하지 않는다. > 아이디를 확인해라.'
			--select 'DEBUG ', @comment
		END
	else if ( @mode_ not in (@MODE_ZCPCHANCE_FREE, @MODE_ZCPCHANCE_CASH) )
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment = 'ERROR 지원하지 않는 모드입니다.'
			--select 'DEBUG ' + @comment
		END
	else if ( @mode_ = @MODE_ZCPCHANCE_FREE and @zcpchance < 1 )
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_ZCPCHANCE
			set @comment = 'ERROR 짜요쿠폰조각 이미 얻어갔습니다.'
			----select 'DEBUG ' + @comment
		END
	else if ( @mode_ = @MODE_ZCPCHANCE_CASH and @usedcashcost_ not in ( @PREMINUM_PRICE1, @PREMINUM_PRICE2 ) )
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_MATCH
			set @comment = 'ERROR 캐쉬가 불일치합니다.'
			--select 'DEBUG ' + @comment
		END
	else if ( @mode_ = @MODE_ZCPCHANCE_CASH and @usedcashcost_ > @cashcost )
		BEGIN
			set @nResult_ = @RESULT_ERROR_CASHCOST_LACK
			set @comment = 'ERROR 황금룰렛의 캐쉬가 부족합니다.'
			--select 'DEBUG ' + @comment
		END
	else if ( @randserial_ = @randserial )
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'SUCCESS 회전판 저장 (동일요청)'
			--select 'DEBUG ' + @comment
		END
	else if ( @mode_ in ( @MODE_ZCPCHANCE_FREE, @MODE_ZCPCHANCE_CASH ) )
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS

			if( @mode_ = @MODE_ZCPCHANCE_FREE )
				begin
					set @comment 	= 'SUCCESS 짜요쿠폰뽑기 무료를 돌립니다.'

					set @zcpchance	= -1
					set @bkzcpcntfree= @bkzcpcntfree + 1

					exec spu_DayLogInfoStatic @market, 110, 1				-- 일 짜요쿠폰뽑기 무료.

					--select 'DEBUG 무료', @comment, @zcpchance zcpchance, @bkzcpcntfree bkzcpcntfree
				end
			else if( @mode_ = @MODE_ZCPCHANCE_CASH )
				begin
					set @comment 	= 'SUCCESS 짜요쿠폰뽑기 유료을 돌립니다. '

					set @cashcost	= @cashcost - @usedcashcost_
					set @bkzcpcntcash= @bkzcpcntcash + 1

					exec spu_DayLogInfoStatic @market, 111, 1				-- 일 짜요쿠폰뽑기 무료.

					--select 'DEBUG 유료', @comment, @cashcost cashcost, @bkzcpcntcash bkzcpcntcash
				end

			-----------------------------------------
			-- 1. 무료램덤 정보를 빼기.
			-----------------------------------------
			-- 1. 선언하기.
			declare curZCPInfo Cursor for
			select top 8 idx, itemcode, cnt, randvalfree, randvalcash from dbo.tSystemZCPInfo
			where itemcode = @ITEM_ZCP_PIECE_MOTHER
			order by idx asc

			-- 2. 커서오픈
			open curZCPInfo

			-- 3. 커서 사용
			Fetch next from curZCPInfo into @idx, @itemcode, @cnt, @randvalfree, @randvalcash
			while @@Fetch_status = 0
				Begin
					set @randval = case
										when ( @mode_ = @MODE_ZCPCHANCE_FREE ) then @randvalfree
										else 										@randvalcash
									end

					if( @loop = 1 )
						begin
							set @idx1		= @idx
							set @itemcode1	= @itemcode
							set @cnt1		= @cnt
							set @randval1	= @randval
						end
					else if( @loop = 2 )
						begin
							set @idx2		= @idx
							set @itemcode2	= @itemcode
							set @cnt2		= @cnt
							set @randval2	= @randval
						end
					else if( @loop = 3 )
						begin
							set @idx3		= @idx
							set @itemcode3	= @itemcode
							set @cnt3		= @cnt
							set @randval3	= @randval
						end
					else if( @loop = 4 )
						begin
							set @idx4		= @idx
							set @itemcode4	= @itemcode
							set @cnt4		= @cnt
							set @randval4	= @randval
						end
					else if( @loop = 5 )
						begin
							set @idx5		= @idx
							set @itemcode5	= @itemcode
							set @cnt5		= @cnt
							set @randval5	= @randval
						end
					else if( @loop = 6 )
						begin
							set @idx6		= @idx
							set @itemcode6	= @itemcode
							set @cnt6		= @cnt
							set @randval6	= @randval
						end
					else if( @loop = 7 )
						begin
							set @idx7		= @idx
							set @itemcode7	= @itemcode
							set @cnt7		= @cnt
							set @randval7	= @randval
						end
					else if( @loop = 8 )
						begin
							set @idx8		= @idx
							set @itemcode8	= @itemcode
							set @cnt8		= @cnt
							set @randval8	= @randval
						end
					set @randsum = @randsum + @randval
					set @loop = @loop + 1

					Fetch next from curZCPInfo into @idx, @itemcode, @cnt, @randvalfree, @randvalcash
				end

			-- 4. 커서닫기
			close curZCPInfo
			Deallocate curZCPInfo

			--select 'DEBUG ', @idx1, 		@idx2, 		@idx3, 		@idx4, 		@idx5, 		@idx6, 		@idx7, 		@idx8
			--select 'DEBUG ', @itemcode1, 	@itemcode2, @itemcode3, @itemcode4, @itemcode5, @itemcode6, @itemcode7, @itemcode8
			--select 'DEBUG ', @cnt1, 		@cnt2, 		@cnt3, 		@cnt4, 		@cnt5, 		@cnt6, 		@cnt7, 		@cnt8
			--select 'DEBUG ', @randval1, 	@randval2, 	@randval3, 	@randval4, 	@randval5, 	@randval6, 	@randval7, 	@randval8


			--------------------------------------------
			-- 2. 랜덤값찾기. > 보상지급
			--    지급세팅
			--------------------------------------------
			set @rand = Convert(int, ceiling(RAND() * @randsum))
			select
				@idx = idx, @itemcode = itemcode, @cnt = cnt
			from dbo.fnu_GetCrossRandom8(@rand,
											@idx1, 		@idx2, 		@idx3, 		@idx4, 		@idx5, 		@idx6, 		@idx7, 		@idx8,
											@itemcode1, @itemcode2, @itemcode3, @itemcode4, @itemcode5, @itemcode6, @itemcode7, @itemcode8,
											@cnt1, 		@cnt2, 		@cnt3, 		@cnt4, 		@cnt5, 		@cnt6, 		@cnt7, 		@cnt8,
											@randval1, 	@randval2, 	@randval3, 	@randval4, 	@randval5, 	@randval6, 	@randval7, 	@randval8)
			--select 'DEBUG ', @rand rand, @idx idx, @itemcode itemcode, @cnt cnt

			---------------------------------------------------
			-- 아이템 직접지급
			-- 1. 전체 수량을 전부 더한다.
			-- > 전체수량을 전부 더해서 99개씩 제거하는 방식으로 한다.
			---------------------------------------------------
			--select 'DEBUG 1. 전체 수량을 전부 더한다.'
			exec spu_SetDirectItemNew @gameid_, @itemcode, @cnt, @DEFINE_HOW_GET_ZCP, @rtn_ = @listidx OUTPUT
			insert into @tTempTable( listidx ) values( @listidx )

			select
				@zcplistidx = listidx,
				@zcpcnt 	= cnt
			from dbo.tUserItem
			where gameid = @gameid_ and listidx = @listidx
			--select 'DEBUG 1-2. 누적량 짜요쿠폰조각', @zcplistidx zcplistidx, @zcpcnt zcpcnt

			--select 'DEBUG 2. 99개 이상이면 짜요쿠폰 지급', @zcpcnt zcpcnt
			while( @zcpcnt >= 99 )
				begin
					--select 'DEBUG 2-2 > 짜요쿠폰 지급', @zcpcnt zcpcnt
					exec spu_SetDirectItemNew @gameid_, @ITEM_ZCP_TICKET_MOTHER, 1, @DEFINE_HOW_GET_ZCP, @rtn_ = @listidx OUTPUT
					insert into @tTempTable( listidx ) values( @listidx )

					set @zcpcnt = @zcpcnt - 99
					set @bchange= 1
				end

			--select 'DEBUG 3. 보유템갱신.'
			if( @bchange = 1 )
				begin
					--select 'DEBUG 3-2.  > 갱신.'

					update dbo.tUserItem
						set
							cnt = @zcpcnt
					where gameid = @gameid_ and listidx = @zcplistidx
				end

			---------------------------------------------------
			-- 유저회전판 로그기록(200까지만 관리).
			---------------------------------------------------
			select @idx2 = isnull(idx2, 0) + 1 from dbo.tUserZCPLog where gameid = @gameid_
			--select 'DEBUG 회전판 로그 기록', @idx2 idx2

			insert into dbo.tUserZCPLog(gameid,   idx2,  mode,   usedcashcost,   ownercashcost,  cnt)
			values(                    @gameid_, @idx2, @mode_, @usedcashcost_,      @cashcost, @cnt)

			delete from dbo.tUserZCPLog where idx2 <= @idx2 - @USER_LOGOLIST_MAX
		END


	-----------------------------------------------
	-- 결과코드처리.
	-----------------------------------------------
	select @nResult_ rtn, @comment comment,
		   @cashcost cashcost, @gamecost gamecost,
		   @idx rewardidx, @itemcode rewarditemcode, @cnt rewardcnt

	if(@nResult_ = @RESULT_SUCCESS)
		BEGIN
			------------------------------------------------
			-- 유저정보
			------------------------------------------------
			update dbo.tUserMaster
				set
					cashcost		= @cashcost,
					bgroul1 		= @idx,			bgroul2 	= @itemcode,	bgroul3 	= @cnt,
					zcpchance		= @zcpchance,
					bkzcpcntfree	= @bkzcpcntfree, bkzcpcntcash= @bkzcpcntcash,
					randserial		= @randserial_
			where gameid = @gameid_

			--------------------------------------------------------------
			-- 유저 보유 아이템 정보
			--------------------------------------------------------------
			select * from dbo.tUserItem
			where gameid = @gameid_ and listidx in ( select listidx from @tTempTable )
		END

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
End



