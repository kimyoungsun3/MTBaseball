/*


*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_SeedHarvestTest', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_SeedHarvestTest;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_SeedHarvestTest
	@gameid_								varchar(20),
	@password_								varchar(20),
	@seedidx_								int,
	@mode_									int,
	@feeduse_								int,
	@nResult_								int					OUTPUT
	--WITH ENCRYPTION -- 프로시져를 암호화함.
as
	------------------------------------------------
	--	2-1. 코드값자리
	------------------------------------------------
	-- 일반값
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	-- 로그인 오류.
	declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--블럭유저 > 팝업처리후 인트로로 빼버린다.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함.
	declare @RESULT_ERROR_CASHCOST_LACK			int				set @RESULT_ERROR_CASHCOST_LACK			= -22			--골드가 부족하다.
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- 아이템코드못찾음
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- 지원하지않는모드
	declare @RESULT_ERROR_HARVEST_TIME_REMAIN	int				set @RESULT_ERROR_HARVEST_TIME_REMAIN	= -121			-- 아직 시간이 남음.

	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------
	-- 블럭상태값.
	--declare @BLOCK_STATE_NO					int					set	@BLOCK_STATE_NO					= 0	-- 블럭상태아님
	declare @BLOCK_STATE_YES					int					set	@BLOCK_STATE_YES				= 1	-- 블럭상태

	-- 아이템 소분류
	declare @ITEM_SUBCATEGORY_SEED				int					set @ITEM_SUBCATEGORY_SEED 					= 7  -- 씨앗	(판매[X], 선물[X], 직접[O])
	declare @ITEM_SUBCATEGORY_FEED				int					set @ITEM_SUBCATEGORY_FEED 					= 44 -- 건초	(판매[X], 선물[O])
	declare @ITEM_SUBCATEGORY_HEART				int					set @ITEM_SUBCATEGORY_HEART 				= 40 -- 하트	(판매[O], 선물[O])
	declare @ITEM_SUBCATEGORY_UPGRADE_HOUSE		int					set @ITEM_SUBCATEGORY_UPGRADE_HOUSE 		= 60 -- 집

	-- 선물 정의값
	declare @GIFTLIST_GIFT_KIND_MESSAGE			int					set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2
	declare @GIFTLIST_GIFT_KIND_MESSAGE_DEL		int					set @GIFTLIST_GIFT_KIND_MESSAGE_DEL			= -1
	declare @GIFTLIST_GIFT_KIND_GIFT_DEL		int					set @GIFTLIST_GIFT_KIND_GIFT_DEL			= -2
	declare @GIFTLIST_GIFT_KIND_GIFT_GET		int					set @GIFTLIST_GIFT_KIND_GIFT_GET			= -3
	declare @GIFTLIST_GIFT_KIND_GIFT_SELL		int					set @GIFTLIST_GIFT_KIND_GIFT_SELL			= -4

	-- 경작지(수확방식).
	declare @USERSEED_HARVEST_MODE_NORMAL     	int					set @USERSEED_HARVEST_MODE_NORMAL			= 1	-- 일반수확.
	declare @USERSEED_HARVEST_MODE_RIGHTNOW  	int					set @USERSEED_HARVEST_MODE_RIGHTNOW			= 2 -- 즉시수확.
	declare @USERSEED_HARVEST_MODE_GIVEUP  		int					set @USERSEED_HARVEST_MODE_GIVEUP			= 3 -- 버리기.

	-- 기타 상수값
	declare @USERMASTER_UPGRADE_STATE_NON		int					set @USERMASTER_UPGRADE_STATE_NON			= -1	--미진행, 완료중.(유저)
	declare @USERMASTER_UPGRADE_STATE_ING		int					set @USERMASTER_UPGRADE_STATE_ING			= 1		--다음단계진행중.

	-- 경작지(정보).
	declare @USERSEED_NEED_EMPTY				int					set @USERSEED_NEED_EMPTY					= -1	-- (경작지)
	declare @USERSEED_NEED_BUY					int					set @USERSEED_NEED_BUY						= -2

	-- 짜요쿠폰조각 룰렛 등장확률.
	declare @ZAYO_PIECE_CHANCE_ONE				int					set @ZAYO_PIECE_CHANCE_ONE					= 1		-- 있음 ( 1)
	declare @ZAYO_PIECE_CHANCE_NON				int					set @ZAYO_PIECE_CHANCE_NON					= -1	-- 없음 (-1)

	declare @ZCP_APPEAR_LIMIT_FRESH				int					set @ZCP_APPEAR_LIMIT_FRESH					= 70	-- 최소신선도값. 1등급( 50 ~ 67 ), 2등급( 75 ~ 93 ), 3등급 ( 104 ~ 131 )
	declare @ZCP_APPEAR_CNT_DAY					int					set @ZCP_APPEAR_CNT_DAY						= 10	-- 1일 등장횟수..
	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @comment			varchar(80)

	declare @gameid 			varchar(20)		set @gameid 		= ''
	declare @blockstate			int
	declare @market				int				set @market			= 1
	declare @cashcost			int				set @cashcost		= 0
	declare @gamecost			int				set @gamecost		= 0
	declare @feed				int				set @feed			= 0
	declare @heart				int				set @heart			= 0
	declare @heartmax			int				set @heartmax		= 0
	declare @feedmax			int				set @feedmax		= 0
	declare @qtfeeduse			int				set @qtfeeduse		= 0
	declare @plusheart			int				set @plusheart		= 0
	declare @plusfeed			int				set @plusfeed		= 0
	declare @tmp				int
	declare @housestep			int,
			@housestate			int,
			@housetime			datetime,
			@housestepmax		int
	declare @curdate			datetime		set @curdate		= getdate()

	declare @seeditemcode		int				set @seeditemcode		= @USERSEED_NEED_BUY
	declare @seedenddate		datetime		set @seedenddate		= getdate() + 10
	declare @seeditemname		varchar(40)		set @seeditemname		= ''
	declare @seedgapsecond		int				set @seedgapsecond		= 0

	declare @harvestcnt			int				set @harvestcnt			= 0
	declare @harvestitemcode	int				set @harvestitemcode	= -444

	declare @bresult			int				set @bresult			= -1
	declare @subcategory		int				set @subcategory		= -1
	declare @invenkind			int				set @invenkind			= -1

	-- 아이템정보.
	declare @gaptime			int				set @gaptime			= 99999
	declare @danga				int				set @danga				= 99999
	declare @dangatime			int				set @dangatime			= 99999
	declare @needcashcost		int				set @needcashcost		= 99999

	-- 짜요쿠폰조각등장확률.
	declare @zcpchance			int			set @zcpchance		= @ZAYO_PIECE_CHANCE_NON
	declare @zcpplus			int			set @zcpplus		= 0
	declare @zcprand			int			set @zcprand		= 0
	declare @salefresh			int			set @salefresh		= 0
	declare @zcpappearcnt		int			set @zcpappearcnt	= 9999
	declare @goldticket			int			set @goldticket		= 0

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	set @comment = 'ERROR 알수없는 오류(-1)'
	--select 'DEBUG 1-0 입력값', @gameid_ gameid_, @password_ password_, @seedidx_ seedidx_, @mode_ mode_, @feeduse_ feeduse_

	------------------------------------------------
	--	3-2. 유저정보.
	-- 건초라이프 사이클
	-- 30(0)/30 -> 30개소모, 30개생산 -> 60(30)/30 * 여기서 문제발생
	--                                             > max + (9마리 * 10건초)
	------------------------------------------------
	-- 유저정보.
	select
		@gameid 		= gameid,	@blockstate 	= blockstate,	@market			= market,
		@zcpchance		= zcpchance,@zcpplus		= zcpplus,		@salefresh 		= salefresh,@zcpappearcnt	= zcpappearcnt,	 	@goldticket = goldticket,
		@cashcost		= cashcost,	@gamecost		= gamecost,		@feed			= feed,		@feedmax		= feedmax,
		@heart			= heart,	@heartmax		= heartmax,
		@qtfeeduse		= qtfeeduse,
		@housestep		= housestep,		@housestate		= housestate,		@housetime		= housetime
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 1-1 유저정보', @gameid gameid, @market market, @cashcost cashcost, @gamecost gamecost, @feed feed, @heart heart, @feedmax feedmax, @heartmax heartmax

	select
		@seeditemcode	= itemcode,
		@seedenddate	= seedenddate
	from dbo.tUSerSeed where gameid = @gameid_ and seedidx = @seedidx_
	----select 'DEBUG 1-2 경작지정보', @gameid_ gameid_, @seedidx_ seedidx_, @seeditemcode seeditemcode, getdate() getdate, @seedenddate seedenddate

	---------------------------------------------
	-- 아이템 정보.
	---------------------------------------------
	select
		@seeditemname		= itemname,
		@harvestcnt			= param1,
		@harvestitemcode	= param6,
		@danga				= param8,
		@dangatime			= param9
	from dbo.tItemInfo
	where subcategory = @ITEM_SUBCATEGORY_SEED and itemcode = @seeditemcode
	--select 'DEBUG 1-3 씨앗정보', @mode_ mode_, @harvestcnt harvestcnt, @harvestitemcode harvestitemcode, @danga danga

	---------------------------------------------
	-- 10분에 2루비가격으로 결정.
	---------------------------------------------
	if( @mode_ = @USERSEED_HARVEST_MODE_RIGHTNOW and @seeditemname != '' )
		begin
			set @gaptime = dbo.fnu_GetDatePart( 's', getdate(), @seedenddate )
			set @needcashcost = case
										when ( @gaptime <= 0 ) then 0
										else 						( ( @gaptime /@dangatime ) + 1 ) * @danga
								 end
		end
	--select 'DEBUG ', @danga danga, @gaptime gaptime, @needcashcost needcashcost

	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '아이디가 존재하지 않는다.'
			--select 'DEBUG ' + @comment
		END
	else if (@blockstate = @BLOCK_STATE_YES)
		BEGIN
			-- 블럭유저인가?
			set @nResult_ 	= @RESULT_ERROR_BLOCK_USER
			set @comment 	= '블럭처리된 아이디입니다.'
		END
	else if(@seeditemcode = @USERSEED_NEED_EMPTY)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '농작물을 정상적으로 수확했습니다.(이미했음1)'
			--select 'DEBUG ' + @comment
		END
	else if(@mode_ = @USERSEED_HARVEST_MODE_RIGHTNOW and getdate() >= @seedenddate)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '농작물을 정상적으로 즉시 완료를 실행 했습니다.'
			--select 'DEBUG ' + @comment
		END
	else if(@harvestitemcode = -444)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_ITEMCODE
			set @comment 	= '정보를 못찾았습니다.'
			--select 'DEBUG ' + @comment
		END
	else if(@mode_ not in(@USERSEED_HARVEST_MODE_NORMAL, @USERSEED_HARVEST_MODE_RIGHTNOW, @USERSEED_HARVEST_MODE_GIVEUP))
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment 	= '지원하지 않는 정보입니다.'
			--select 'DEBUG ' + @comment
		END
	else if(@mode_ = @USERSEED_HARVEST_MODE_NORMAL and getdate() < @seedenddate)
		BEGIN
			select @seedgapsecond = dbo.fnu_GetDatePart('ss', @seedenddate, getdate())
			set @nResult_ 	= @RESULT_ERROR_HARVEST_TIME_REMAIN
			set @comment 	= '시간이 남음 ' + @seeditemname + '('+ltrim(rtrim(str(@seeditemcode)))+') 수확남은시간('+ltrim(rtrim(str(-@seedgapsecond)))+'초)'
			--select 'DEBUG ' + @comment

			if(@seedgapsecond < -10)
				begin
					exec spu_SubUnusualRecord2 @gameid_, @comment
				end
			set @nResult_ 	= @RESULT_SUCCESS
		END
	else if( @mode_ = @USERSEED_HARVEST_MODE_RIGHTNOW and @needcashcost > @cashcost )
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_CASHCOST_LACK
			set @comment 	= '캐쉬비용이 부족합니다.'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 경작지에 수확을 한다.'
			--select 'DEBUG ' + @comment

			--select 'DEBUG 업글(집전)', @housestate housestate, @housestep housestep, @housestepmax housestepmax, @housetime housetime
			if(@housestate = @USERMASTER_UPGRADE_STATE_ING and @curdate >= @housetime)
				begin
					select top 1 @housestepmax = housestepmax from dbo.tSystemInfo order by idx desc

					set @housestate = @USERMASTER_UPGRADE_STATE_NON
					set @housestep	= CASE
											WHEN (@housestep + 1 < @housestepmax) THEN @housestep + 1
											ELSE @housestepmax
									  END

					-- 집업글완료 > 건초, 하트 맥스확장.
					select
						@feedmax		= param5,
						@heartmax		= param6
					from dbo.tItemInfo
					where subcategory = @ITEM_SUBCATEGORY_UPGRADE_HOUSE and param1 = @housestep
				end
			--select 'DEBUG 업글(집후)', @housestate housestate, @housestep housestep, @housestepmax housestepmax, @housetime housetime


			if(@mode_ = @USERSEED_HARVEST_MODE_GIVEUP)
				begin
					--select 'DEBUG 경작지 일반폐기처리.'
					set @comment = 'SUCCESS 경작지에 수확을 폐기한다.'
					update dbo.tUserSeed
						set
							itemcode = @USERSEED_NEED_EMPTY
					where gameid = @gameid_ and seedidx = @seedidx_
				end
			else if(@mode_ = @USERSEED_HARVEST_MODE_NORMAL and getdate() >= @seedenddate)
				begin
					--select 'DEBUG 경작지 일반수확처리.'
					update dbo.tUserSeed
						set
							itemcode = @USERSEED_NEED_EMPTY
					where gameid = @gameid_ and seedidx = @seedidx_

					set @bresult = 1

					-- 하단 > 해당아이템지급 or 선물함.
				end
			else if(@mode_ = @USERSEED_HARVEST_MODE_RIGHTNOW and @needcashcost <= @cashcost)
				begin
					---------------------------------------------------------------
					--select 'DEBUG 경작지 즉시수확 > 시간만완료.'
					---------------------------------------------------------------
					-- 2. 시간완료만.
					update dbo.tUserSeed
						set
							seedenddate = getdate()
					where gameid = @gameid_ and seedidx = @seedidx_

					-- 비용차감.
					set @cashcost	= @cashcost - @needcashcost

					-----------------------------------
					-- 구매기록마킹
					-----------------------------------
					exec spu_UserItemBuyLogNew @gameid_, @seeditemcode, 0, @needcashcost, 0

					-- > 지급없음--------------------------------------------------------

					set @bresult = 0
				end

			-- 해당아이템지급 or 선물함.
			if(@bresult = 1)
				begin
					-- 아이템코드 > 정보 > 분류.
					select
						@subcategory 	= subcategory
					from dbo.tItemInfo where itemcode = @harvestitemcode

					set @invenkind = dbo.fnu_GetInvenFromSubCategory(@subcategory)
					--select 'DEBUG 아이템정보 ', @subcategory subcategory, @invenkind invenkind

					-- 사용건초계산.
					set @feeduse_ = case
										when @feeduse_ < 0 then (-@feeduse_)
										else @feeduse_
									end

					set @feed 		= @feed - @feeduse_
					set @qtfeeduse 	= @qtfeeduse + @feeduse_

					if(@subcategory = @ITEM_SUBCATEGORY_HEART)
						begin
							--select 'DEBUG 하트 -> 바로적용(Max체크)', @heart heart, @heartmax heartmax, @harvestcnt harvestcnt
							set @tmp 	= @heart
							set @heart 	= case
											when (@heart 				>= @heartmax) then (@heart)
											when (@heart + @harvestcnt  >= @heartmax) then (@heartmax)
											else (@heart + @harvestcnt)
										end
							set @bresult 	= 1
							set @plusheart 	= @harvestcnt

							------------------------------------------------
							-- 짜요쿠폰조각 룰렛등장.
							------------------------------------------------
							if( @goldticket >= 4 and @tmp < @heartmax and @salefresh >= @ZCP_APPEAR_LIMIT_FRESH and @zcpchance = @ZAYO_PIECE_CHANCE_NON and @zcpappearcnt <= @ZCP_APPEAR_CNT_DAY )
								begin
									set @zcprand  = Convert(int, ceiling(RAND() * 10000))
									set @zcpchance = dbo.fun_getZCPChance( 10,  @zcpplus, @zcprand )	-- 작물(10).

									if( @zcpchance = @ZAYO_PIECE_CHANCE_ONE )
										begin
											set @zcpappearcnt = @zcpappearcnt + 1 -- 1회증가.

											exec spu_DayLogInfoStatic @market, 123, 1				-- 일 경작지하트 짜요쿠폰조각 룰렛등장.
										end
								end
						end
					else if(@subcategory = @ITEM_SUBCATEGORY_FEED)
						begin
							--select 'DEBUG 건초 -> 바로적용', @feed feed, @feedmax feedmax, @harvestcnt harvestcnt
							set @tmp 	= @feed
							set @feed = case
											when (@feed 			   >= @feedmax) then (@feed)
											when (@feed + @harvestcnt  >= @feedmax) then (@feedmax)
											else (@feed + @harvestcnt)
										end

							set @bresult 	= 1
							set @plusfeed 	= @harvestcnt

							------------------------------------------------
							-- 짜요쿠폰조각 룰렛등장.
							------------------------------------------------
							if( @goldticket >= 4 and @tmp < @feedmax and @harvestcnt >= 38  and @salefresh >= @ZCP_APPEAR_LIMIT_FRESH and @zcpchance = @ZAYO_PIECE_CHANCE_NON and @zcpappearcnt <= @ZCP_APPEAR_CNT_DAY )
								begin
									set @zcprand  = Convert(int, ceiling(RAND() * 10000))
									set @zcpchance = dbo.fun_getZCPChance( 10,  @zcpplus, @zcprand )	-- 작물(10).

									if( @zcpchance = @ZAYO_PIECE_CHANCE_ONE )
										begin
											set @zcpappearcnt = @zcpappearcnt + 1 -- 1회증가.

											exec spu_DayLogInfoStatic @market, 122, 1				-- 일 경작지건초 짜요쿠폰조각 룰렛등장.
										end
								end
						end

				end
		END

	--select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost, @feed feed, @heart heart, @feedmax feedmax, @heartmax heartmax, @bresult bresult, @zcpchance zcpchance
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			-----------------------------------
			-- 유저 정보 반영.
			-----------------------------------
			update dbo.tUserMaster
			set
				cashcost		= @cashcost,	gamecost		= @gamecost,
				feed			= @feed,		heart			= @heart,
				feedmax			= @feedmax,		heartmax		= @heartmax,
				housestate 		= @housestate, 	housestep 		= @housestep,
				zcpchance		= @zcpchance,	zcpappearcnt	= @zcpappearcnt,

				qtfeeduse		= @qtfeeduse,
				bkheart			= bkheart + @plusheart,
				bkfeed			= bkfeed + @plusfeed

			where gameid = @gameid_

			--------------------------------------------------------------
			-- 경작지 정보.
			--------------------------------------------------------------
			--select * from dbo.tUserSeed where gameid = @gameid_ and seedidx = @seedidx_

			--------------------------------------------------------------
			-- 선물함정보.
			--------------------------------------------------------------
			--if(@bresult = 2)
			--	begin
			--		exec spu_GiftList @gameid_
			--	end
		end
	--else if(@nResult_ = @RESULT_ERROR_HARVEST_TIME_REMAIN)
	--	begin
	--		-----------------------------------
	--		-- 유저 정보 반영(X).
	--		-----------------------------------
    --
	--		--------------------------------------------------------------
	--		-- 경작지 정보.
	--		--------------------------------------------------------------
	--		--select * from dbo.tUserSeed where gameid = @gameid_ and seedidx = @seedidx_
    --
	--		--------------------------------------------------------------
	--		-- 선물함정보.
	--		--------------------------------------------------------------
	--		--if(@bresult = 2)
	--		--	begin
	--		--		exec spu_GiftList @gameid_
	--		--	end
	--	end

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
End



