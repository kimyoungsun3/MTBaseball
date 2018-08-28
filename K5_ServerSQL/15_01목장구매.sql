/*
delete from dbo.tGiftList where gameid = 'xxxx2'
update dbo.tUserMaster set gamecost = 100000, gameyear = 2826 where gameid = 'xxxx2'
update dbo.tUserFarm set buystate = -1 where gameid = 'xxxx2' and itemcode = 6930
exec spu_UserFarm 'xxxx2', '049000s1i0n7t8445289',  1, 6901, -1		-- 구매
exec spu_UserFarm 'xxxx2', '049000s1i0n7t8445289',  1, 6930, -1		-- 구매

update dbo.tUserFarm set incomedate = getdate() - 0.1, buystate = 1 where gameid = 'xxxx2' and itemcode = 6900
exec spu_UserFarm 'xxxx2', '049000s1i0n7t8445289',  2, 6900, -1		-- 수입

update dbo.tUserFarm set incomedate = getdate() - 1 where gameid = 'xxxx2'
update dbo.tUserMaster set gamecost = 0 where gameid = 'xxxx2'
exec spu_UserFarm 'xxxx2', '049000s1i0n7t8445289',  22, -1, -1		-- All수입

update dbo.tUserFarm set incomedate = getdate() - 0.1, buystate = 1 where gameid = 'xxxx2' and itemcode = 6900
exec spu_UserFarm 'xxxx2', '049000s1i0n7t8445289',  3, 6900, -1		-- 판매
*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_UserFarm', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_UserFarm;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_UserFarm
	@gameid_								varchar(20),					-- 게임아이디
	@password_								varchar(20),
	@mode_									int,
	@itemcode_								int,
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
	declare @RESULT_ERROR_DELETED_USER 			int				set @RESULT_ERROR_DELETED_USER			= -12			--삭제유저 > 팝업처리후 인트로로 빼버린다.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함
	declare @RESULT_ERROR_NOT_FOUND_PASSWORD	int				set @RESULT_ERROR_NOT_FOUND_PASSWORD	= -17
	declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--서버를 점검하고 있다.
	declare @RESULT_NEWVERION_CLIENT_DOWNLOAD 	int				set @RESULT_NEWVERION_CLIENT_DOWNLOAD	= -15			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 링크처리.
	declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 종료.

	-- 게임중에 부족.
	declare @RESULT_ERROR_HEART_LACK			int				set @RESULT_ERROR_HEART_LACK			= -20			--하트이 부족하다.
	declare @RESULT_ERROR_GAMECOST_LACK			int				set @RESULT_ERROR_GAMECOST_LACK			= -21			--실버가 부족하다.
	declare @RESULT_ERROR_CASHCOST_LACK			int				set @RESULT_ERROR_CASHCOST_LACK			= -22			--골드가 부족하다.
	declare @RESULT_ERROR_ITEM_LACK				int				set @RESULT_ERROR_ITEM_LACK				= -23			--아이템이부족하다.
	declare @RESULT_ERROR_FPOINT_LACK			int				set @RESULT_ERROR_FPOINT_LACK			= -124			--

	-- 기타오류
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- 지원하지않는모드
	declare @RESULT_ERROR_NOT_FOUND_USERFARM	int				set @RESULT_ERROR_NOT_FOUND_USERFARM	= -125			-- 목장리스트가 미구매.

	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------
	-- 아이템 대분류
	declare @ITEM_MAINCATEGORY_USERFARM			int					set @ITEM_MAINCATEGORY_USERFARM 			= 69 	--전국목장(69)

	-- 아이템 소분류
	declare @ITEM_SUBCATEGORY_USERFARM			int					set @ITEM_SUBCATEGORY_USERFARM	 			= 69 -- 전국목장

	-- 선물 정의값
	--declare @GIFTLIST_GIFT_KIND_MESSAGE		int					set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2
	--declare @GIFTLIST_GIFT_KIND_MESSAGE_DEL	int					set @GIFTLIST_GIFT_KIND_MESSAGE_DEL			= -1
	--declare @GIFTLIST_GIFT_KIND_GIFT_DEL		int					set @GIFTLIST_GIFT_KIND_GIFT_DEL			= -2
	--declare @GIFTLIST_GIFT_KIND_GIFT_GET		int					set @GIFTLIST_GIFT_KIND_GIFT_GET			= -3
	--declare @GIFTLIST_GIFT_KIND_GIFT_SELL		int					set @GIFTLIST_GIFT_KIND_GIFT_SELL			= -4

	-- 농장모드
	declare @USERFARM_MODE_BUY					int					set @USERFARM_MODE_BUY						= 1
	declare @USERFARM_MODE_INCOME				int					set @USERFARM_MODE_INCOME					= 2
	declare @USERFARM_MODE_INCOME_ALL			int					set @USERFARM_MODE_INCOME_ALL				= 22
	declare @USERFARM_MODE_SELL					int					set @USERFARM_MODE_SELL						= 3

	-- 농장(정보).
	declare @USERFARM_BUYSTATE_NOBUY			int					set @USERFARM_BUYSTATE_NOBUY				= -1	-- (농장)
	declare @USERFARM_BUYSTATE_BUY				int					set @USERFARM_BUYSTATE_BUY					=  1

	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @gameid			varchar(20)				set @gameid			= ''
	declare @market			int						set @market			= 5
	declare @version		int						set @version		= 101
	declare @comment		varchar(128)
	declare @cashcost		int						set @cashcost		= 0
	declare @gamecost		int						set @gamecost		= 0
	declare @feed			int						set @feed			= 0
	declare @fpoint			int						set @fpoint			= 0
	declare @heart			int						set @heart			= 0
	declare @gameyear		int						set @gameyear		= 2013
	declare @rewarditemcode	int						set @rewarditemcode	= -1
	declare @rewardcnt		int						set @rewardcnt		= 0

	declare @buystate		int						set @buystate		= -444
	declare @incomedate		datetime				set @incomedate		= getdate()
	declare @incomegamecost	int						set @incomegamecost	= 0
	declare @incomegamecost2	int					set @incomegamecost2	= 0
	declare @buycount		int						set @buycount	= 0

	declare @gamecostorg	int						set @gamecostorg	= -444
	declare @gamecostcur	int						set @gamecostcur	= 0
	declare @hourcoin		int						set @hourcoin		= 0
	declare @maxcoin		int						set @maxcoin		= 0
	declare @raiseyear		int						set @raiseyear		= 0
	declare @raisepercent	int						set @raisepercent	= 0

	declare @gapyear		int
	declare @tmp			int
	declare @gaphour		int
	declare @farmidx		int

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG 입력정보', @gameid_ gameid_, @password_ password_, @mode_ mode_, @itemcode_ itemcode_

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	select
		@gameid 		= gameid,		@market			= market,		@version		= version,
		@cashcost		= cashcost,		@gamecost		= gamecost,
		@heart			= heart,		@feed			= feed,			@fpoint			= fpoint,
		@gameyear		= gameyear
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 유저정보', @gameid gameid, @cashcost cashcost, @gamecost gamecost, @heart heart, @feed feed, @fpoint fpoint, @gameyear gameyear


	select
		@buystate		= buystate,
		@incomedate		= incomedate,
		@buycount		= buycount
	from dbo.tUserFarm
	where gameid = @gameid_ and itemcode = @itemcode_
	--select 'DEBUG 농장 보유정보', @buystate buystate, @incomedate incomedate

	select
		@gamecostorg 	= gamecost,
		@hourcoin		= param1,
		@maxcoin		= param2,
		@raiseyear		= param3,
		@raisepercent	= param4,
		@rewarditemcode	= param11,
		@rewardcnt		= param12
	from dbo.tItemInfo
	where itemcode = @itemcode_ and subcategory = @ITEM_SUBCATEGORY_USERFARM
	--select 'DEBUG 농장 일반정보', @gamecostorg gamecostorg, @hourcoin hourcoin, @maxcoin maxcoin, @raiseyear raiseyear, @raisepercent raisepercent, @rewardcnt rewardcnt


	------------------------------------------------
	-- 부동산현재가.
	------------------------------------------------
	set @gapyear		= case
								when (@gameyear - @raiseyear < 0) then 0
								else                                   (@gameyear - @raiseyear)
						  end
	set @gamecostcur 	= @gamecostorg + @gamecostorg * @raisepercent * @gapyear / 100
	--select 'DEBUG 부동산현재가', @gapyear gapyear, @gamecostcur gamecostcur

	------------------------------------------------
	-- 3-3. 각 조건별 분기
	------------------------------------------------
	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR 아이디가 존재하지 않는다.'
			--select 'DEBUG ' + @comment
		END
	else if (@mode_ not in (@USERFARM_MODE_BUY, @USERFARM_MODE_INCOME, @USERFARM_MODE_INCOME_ALL, @USERFARM_MODE_SELL))
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment 	= 'ERROR 지원하지 않는 모드입니다.'
			--select 'DEBUG ' + @comment
		END
	else if ((@mode_ != @USERFARM_MODE_INCOME_ALL) and (@buystate = -444 or @gamecostorg = -444))
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment 	= 'ERROR 지원하지 않는 모드입니다(2).'
			--select 'DEBUG ' + @comment
		END
	else if (@mode_ = @USERFARM_MODE_BUY)
		BEGIN
			------------------------------------------
			-- 구매모드.
			------------------------------------------
			if(@gamecost < @gamecostcur)
				BEGIN
					set @nResult_ 	= @RESULT_ERROR_GAMECOST_LACK
					set @comment 	= 'ERROR 코인이 부족합니다.'
					--select 'DEBUG ' + @comment
				END
			else if(@buystate = @USERFARM_BUYSTATE_BUY)
				BEGIN
					set @nResult_ 	= @RESULT_SUCCESS
					set @comment 	= 'SUCCESS 구매성공(이미구매).'
					--select 'DEBUG ' + @comment
				END
			else
				BEGIN
					set @nResult_ 	= @RESULT_SUCCESS
					set @comment 	= 'SUCCESS 구매성공.'
					--select 'DEBUG ' + @comment

					---------------------------------------------
					-- 구매금액차감.
					---------------------------------------------
					set @gamecost 	= @gamecost - @gamecostcur

					---------------------------------------------
					-- 목장 구매 상태로 변경
					---------------------------------------------
					--select 'DEBUG 전', @@ROWCOUNT, * from dbo.tUserFarm where gameid = @gameid_ and itemcode = @itemcode_
					update dbo.tUserFarm
						set
							buystate	= @USERFARM_BUYSTATE_BUY,
							buydate		= getdate(),
							incomedate	= getdate(),
							buycount	= buycount + 1
					where gameid = @gameid_ and itemcode = @itemcode_
					--select 'DEBUG 후', @@ROWCOUNT, * from dbo.tUserFarm where gameid = @gameid_ and itemcode = @itemcode_

					---------------------------------------------
					-- 구매기록마킹
					---------------------------------------------
					if(@buycount = 0)
						begin
							exec spu_UserItemBuyLogNew @gameid_, @itemcode_, @gamecostcur, 0, 0
						end

					---------------------------------------------
					-- 아이템 선물기록.
					---------------------------------------------
					if(@rewarditemcode != -1)
						begin
							--select 'DEBUG 선물하기.', @rewarditemcode rewarditemcode, @rewardcnt rewardcnt
							exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT,  @rewarditemcode, @rewardcnt, 'FarmBuy', @gameid_, ''
						end

				END


		END
	else if (@mode_ = @USERFARM_MODE_INCOME)
		BEGIN
			------------------------------------------
			-- 수입모드.
			------------------------------------------
			if(@buystate != @USERFARM_BUYSTATE_BUY)
				BEGIN
					set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_USERFARM
					set @comment 	= 'SUCCESS 농장을 소유하고 있지 않다.'
					--select 'DEBUG ' + @comment
				END
			else
				BEGIN
					set @nResult_ 	= @RESULT_SUCCESS
					set @comment 	= 'SUCCESS 수익걷기 성공.'
					--select 'DEBUG ' + @comment


					set @gaphour 		= dbo.fnu_GetDatePart('hh', @incomedate, getdate())
					set @incomegamecost	= @gaphour * @hourcoin

					if(@incomegamecost >= @maxcoin)
						begin
							set @incomegamecost	= @maxcoin
							set @incomedate		= getdate()
						end
					else if(@incomegamecost < 0)
						begin
							set @incomegamecost	= 0
							set @incomedate		= getdate()
						end
					else
						begin
							set @incomegamecost	= @incomegamecost
							set @incomedate		= DATEADD(hour, @gaphour, @incomedate)
						end
					--select 'DEBUG 수입', @incomegamecost incomegamecost, @incomedate incomedate


					-- 수익금추가.
					set @gamecost 	= @gamecost + @incomegamecost

					-- 수익 걷어간 상태로체킹.
					update dbo.tUserFarm
						set
							incomedate 	= @incomedate,
							incomett	= incomett + @incomegamecost
					where gameid = @gameid_ and itemcode = @itemcode_

				END
		END
	else if (@mode_ = @USERFARM_MODE_INCOME_ALL)
		BEGIN
			------------------------------------------
			-- All수입모드.
			------------------------------------------
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'SUCCESS 수익걷기 성공.'
			--select 'DEBUG ' + @comment

			------------------------------------------
			-- 1. 아이템 보유 정보를 읽어오기 > 커서로 읽어서 처리.
			------------------------------------------
			declare curFarmList Cursor for
			select farmidx, incomedate, buycount, gamecostorg, hourcoin, maxcoin, raiseyear, raisepercent
			from
					(select itemcode, farmidx, incomedate, buycount from dbo.tUserFarm where gameid = @gameid_ and buystate = @USERFARM_BUYSTATE_BUY) f
				JOIN
					(select itemcode, gamecost gamecostorg, param1 hourcoin, param2 maxcoin, param3 raiseyear, param4 raisepercent from dbo.tItemInfo where subcategory = @ITEM_SUBCATEGORY_USERFARM) i
				ON f.itemcode = i.itemcode

			-- 2. 커서오픈
			open curFarmList

			-- 3. 커서 사용
			Fetch next from curFarmList into @farmidx, @incomedate, @buycount, @gamecostorg, @hourcoin, @maxcoin, @raiseyear, @raisepercent
			while @@Fetch_status = 0
				Begin
					--select 'DEBUG ', @farmidx farmidx, @incomedate incomedate, @buycount buycount, @gamecostorg gamecostorg, @hourcoin hourcoin, @maxcoin maxcoin, @raiseyear raiseyear, @raisepercent raisepercent

					set @gaphour 		= dbo.fnu_GetDatePart('hh', @incomedate, getdate())
					set @incomegamecost	= @gaphour * @hourcoin
					--select 'DEBUG ', @gaphour gaphour, @hourcoin hourcoin, @incomegamecost incomegamecost

					if(@incomegamecost >= @maxcoin)
						begin
							set @incomegamecost	= @maxcoin
							set @incomedate		= getdate()
							--select 'DEBUG 수입', @incomegamecost incomegamecost, @incomedate incomedate

							-- 수익금누적.
							set @incomegamecost2	= @incomegamecost2 + @incomegamecost

							-- 수익 걷어간 상태로체킹.
							update dbo.tUserFarm
								set
									incomedate 	= @incomedate,
									incomett	= incomett + @incomegamecost
							where gameid = @gameid_ and farmidx = @farmidx
						end

					Fetch next from curFarmList into @farmidx, @incomedate, @buycount, @gamecostorg, @hourcoin, @maxcoin, @raiseyear, @raisepercent
				end

			-- 4. 커서닫기
			close curFarmList
			Deallocate curFarmList

			-- 전체 벌어들인 수익계산해서 넣어주기.
			set @gamecost 		= @gamecost + @incomegamecost2
			set @incomegamecost	= @incomegamecost2

		END
	else if (@mode_ = @USERFARM_MODE_SELL)
		BEGIN
			------------------------------------------
			-- 판매모드.
			------------------------------------------
			if(@buystate != @USERFARM_BUYSTATE_BUY)
				BEGIN
					set @nResult_ 	= @RESULT_SUCCESS
					set @comment 	= 'SUCCESS 판매성공(이미판매).'
					--select 'DEBUG ' + @comment
				END
			else
				BEGIN
					set @nResult_ 	= @RESULT_SUCCESS
					set @comment 	= 'SUCCESS 판매성공.'
					--select 'DEBUG ' + @comment

					-- 구매금액차감.
					set @gamecost 	= @gamecost + @gamecostcur


					-- 목장 구매 상태로 변경
					--select 'DEBUG 전', @@ROWCOUNT, * from dbo.tUserFarm where gameid = @gameid_ and itemcode = @itemcode_
					update dbo.tUserFarm
						set
							buystate	= @USERFARM_BUYSTATE_NOBUY
					where gameid = @gameid_ and itemcode = @itemcode_
					--select 'DEBUG 후', @@ROWCOUNT, * from dbo.tUserFarm where gameid = @gameid_ and itemcode = @itemcode_
				END
		END
	else
		begin
			set @nResult_ 	= @RESULT_ERROR
			set @comment 	= 'ERROR 알수없는 오류(-1)'
		end


	--------------------------------------------------------------
	-- 결과전송.
	--------------------------------------------------------------
	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost, @heart heart, @feed feed, @fpoint fpoint, @incomegamecost incomegamecost
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			--------------------------------------------------------------
			-- 농장 상태변화는 위에서 처리함.
			--	구매, 수입, 판매
			--------------------------------------------------------------
			update dbo.tUserMaster
				set
					gamecost	= @gamecost
			where gameid = @gameid_

			--------------------------------------------------------------
			-- 농장리스트 전송
			--------------------------------------------------------------
			exec spu_UserFarmListNew @gameid_, 1, @market, @version

			--------------------------------------------------------------
			-- 선물/쪽지 리스트 정보
			--------------------------------------------------------------
			if (@mode_ = @USERFARM_MODE_BUY and @rewarditemcode != -1)
				begin
					exec spu_GiftList @gameid_
				end

		end

	------------------------------------------------
	--	4-2. 유저정보
	------------------------------------------------
	set nocount off
End

