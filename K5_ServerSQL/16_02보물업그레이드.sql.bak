/*
-- 업글
update dbo.tUserItem set treasureupgrade = 0 where gameid = 'xxxx2' and listidx in ( 290, 291 )
update dbo.tUserMaster set cashcost = 100000, gamecost = 100000, heart = 100000, randserial = -1 where gameid = 'xxxx2'


exec spu_RoulTreasureUpgrade 'xxxx2', '049000s1i0n7t8445289', 1, 290, 7771, -1	-- 일반강화.
exec spu_RoulTreasureUpgrade 'xxxx2', '049000s1i0n7t8445289', 1, 290, 7772, -1
exec spu_RoulTreasureUpgrade 'xxxx2', '049000s1i0n7t8445289', 1, 132, 7773, -1
exec spu_RoulTreasureUpgrade 'xxxx2', '049000s1i0n7t8445289', 1, 132, 7763, -1
exec spu_RoulTreasureUpgrade 'xxxx2', '049000s1i0n7t8445289', 2, 72, 7774, -1	-- 캐쉬강화.
exec spu_RoulTreasureUpgrade 'xxxx2', '049000s1i0n7t8445289', 2, 73, 7775, -1
exec spu_RoulTreasureUpgrade 'xxxx2', '049000s1i0n7t8445289', 2, 132, 7776, -1
exec spu_RoulTreasureUpgrade 'xxxx2', '049000s1i0n7t8445289', 2, 132, 7766, -1

*/
use Game4Farmvill5
GO

IF OBJECT_ID ( 'dbo.spu_RoulTreasureUpgrade', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_RoulTreasureUpgrade;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_RoulTreasureUpgrade
	@gameid_								varchar(20),					-- 게임아이디
	@password_								varchar(20),					--
	@mode_									int,
	@listidx_								int,
	@randserial_							varchar(20),					--
	@nResult_								int					OUTPUT
	--WITH ENCRYPTION
as
	------------------------------------------------
	--	2-1. 코드값
	------------------------------------------------
	-- 일반값
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	-- 기타 오류.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함
	declare @RESULT_ERROR_HEART_LACK			int				set @RESULT_ERROR_HEART_LACK			= -20			--하트이 부족하다.
	declare @RESULT_ERROR_GAMECOST_LACK			int				set @RESULT_ERROR_GAMECOST_LACK			= -21			--실버가 부족하다.
	declare @RESULT_ERROR_CASHCOST_LACK			int				set @RESULT_ERROR_CASHCOST_LACK			= -22			--골드가 부족하다.
	declare @RESULT_ERROR_UPGRADE_FULL			int				set @RESULT_ERROR_UPGRADE_FULL			= -35			--업그레이드가 풀로되었다.
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- 아이템코드못찾음
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- 지원하지않는모드

	------------------------------------------------
	--	2-2. 정의된값
	------------------------------------------------
	-- 아이템별 인벤분류
	declare @USERITEM_INVENKIND_TREASURE		int					set @USERITEM_INVENKIND_TREASURE			= 1200

	-- 강화모드.
	declare @MODE_TSUPGRADE_NORMAL				int					set @MODE_TSUPGRADE_NORMAL					= 1		-- 일반강화.
	declare @MODE_TSUPGRADE_PREMINUM			int					set @MODE_TSUPGRADE_PREMINUM				= 2		-- 캐쉬강화.

	declare @TSUPGRADE_RESULT_SUCCESS			int					set @TSUPGRADE_RESULT_SUCCESS				= 1		--
	declare @TSUPGRADE_RESULT_FAIL				int					set @TSUPGRADE_RESULT_FAIL					= 0		--
	--declare @USERITEM_TREASURE_UPGRADE_MAX	int					set @USERITEM_TREASURE_UPGRADE_MAX			= 7		-- max강화.

	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @comment				varchar(80)
	declare @gameid					varchar(20)		set @gameid				= ''	-- 유저정보.
	declare @cashcost				int				set @cashcost			= 0
	declare @gamecost				int				set @gamecost 			= 0
	declare @heart					int				set @heart 				= 0
	declare @feed					int				set @feed 				= 0
	declare @market					int				set @market				= 5
	declare @randserial				varchar(20)		set @randserial			= ''

	declare @itemcode				int				set @itemcode 			= -1
	declare @treasureupgrade 		int				set @treasureupgrade	= 0
	declare @upstepmax 				int				set @upstepmax			= 7
	declare @grade 					int				set @grade				= 0
	declare @needgamecost			int				set @needgamecost		= 0
	declare @needheart				int				set @needheart			= 0
	declare @needcashcost			int				set @needcashcost		= 0
	declare @tsupgraderesult		int				set @tsupgraderesult	= @TSUPGRADE_RESULT_FAIL
	declare @rand					int				set @rand				= 0
	declare @rand2					int				set @rand2				= 0
	declare @curdate				datetime		set @curdate			= getdate()
	declare @tsupgradesaleflag		int				set @tsupgradesaleflag	= 0
	declare @tsupgradesalevalue		int				set @tsupgradesalevalue	= 0

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	set @comment  = '알수 없는 오류가 발생했습니다.'
	--select 'DEBUG 3-1 입력값', @gameid_ gameid_, @password_ password_, @mode_ mode_, @listidx_ listidx_, @randserial_ randserial_

	------------------------------------------------
	--	3-2. 유저정보
	------------------------------------------------
	select
		@gameid 	= gameid,		@market		= @market,
		@cashcost	= cashcost,		@gamecost	= gamecost,		@heart	= heart,	@feed	= feed,
		@tsupgraderesult = tsupgraderesult,
		@randserial	= randserial
	from dbo.tUserMaster where gameid = @gameid_ and password = @password_
	--select 'DEBUG 3-2 유저정보', @gameid gameid, @cashcost cashcost, @gamecost gamecost, @heart heart

	------------------------------------------------
	--	3-2. 보물정보 -> 등급정보.
	------------------------------------------------
	select
		@itemcode		= itemcode,
		@treasureupgrade= treasureupgrade,
		@upstepmax		= upstepmax
	from dbo.tUserItem
	where gameid = @gameid_ and listidx = @listidx_ and invenkind = @USERITEM_INVENKIND_TREASURE
	--select 'DEBUG ', @itemcode itemcode, @treasureupgrade treasureupgrade, @upstepmax upstepmax

	if( @gameid != '' and @itemcode != -1 )
		begin
			-- 등급.
			select @grade = grade from dbo.tItemInfo where itemcode = @itemcode

			--가격 정보.
			if( @mode_ = @MODE_TSUPGRADE_NORMAL )
				begin
					set @needheart 		= dbo.fun_GetTSUpgradePrice( 1, @grade, @treasureupgrade + 1 )
					set @needgamecost	= dbo.fun_GetTSUpgradePrice( 2, @grade, @treasureupgrade + 1 )
					--select 'DEBUG 일반강화', @needheart needheart, @needgamecost needgamecost
				end
			else
				begin
					set @needcashcost 	= dbo.fun_GetTSUpgradePrice( 3, @grade, @treasureupgrade + 1 )
					--select 'DEBUG 캐쉬강화', @needcashcost needcashcost
				end
			----select 'DEBUG [보물업글]', @itemcode itemcode, @treasureupgrade treasureupgrade, @grade grade, @needheart needheart, @needgamecost needgamecost, @needcashcost needcashcost

			-- 할인.
			select
				top 1
				-- 1. 할인
				@tsupgradesaleflag	= case when (@curdate > roulstart and @curdate <= roulend) then tsupgradesaleflag	else -1 end,
				@tsupgradesalevalue	= case when @tsupgradesaleflag = -1 then 0 else tsupgradesalevalue end
			from dbo.tSystemTreasureMan
			where roulmarket like @market
			order by idx desc
			----select 'DEBUG ', @tsupgradesaleflag tsupgradesaleflag, @tsupgradesalevalue tsupgradesalevalue

			----select 'DEBUG (전)', @cashcost cashcost, @needcashcost needcashcost, @gamecost gamecost, @needgamecost needgamecost, @heart heart, @needheart needheart
			if(@tsupgradesaleflag = 1 and @tsupgradesalevalue > 0 and @tsupgradesalevalue <= 100)
				begin
					-- 일반(할인비적용), 캐쉬(할인적용)
					set @needcashcost 	= @needcashcost - @needcashcost * @tsupgradesalevalue / 100
					--set @needgamecost = @needgamecost - @needgamecost * @tsupgradesalevalue / 100
					--set @needheart 	= @needheart    - @needheart    * @tsupgradesalevalue / 100
				end
			----select 'DEBUG (후)', @cashcost cashcost, @needcashcost needcashcost, @gamecost gamecost, @needgamecost needgamecost, @heart heart, @needheart needheart
		end



	------------------------------------------------
	--	3-3. 각상황별로 코드로 분류
	------------------------------------------------
	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR 아이디가 존재하지 않는다.'
			----select 'DEBUG ' + @comment
		END
	else if (@randserial_ = @randserial)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '보물강화합니다.(2)'
			----select 'DEBUG ' + @comment
		END
	else if(@itemcode = -1)
		begin
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_ITEMCODE
			set @comment 	= 'ERROR 아이템 존재하지 않습니다.'
			----select 'DEBUG ' + @comment
		end
	else if ( @mode_ not in (@MODE_TSUPGRADE_NORMAL, @MODE_TSUPGRADE_PREMINUM ) )
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment = 'ERROR 지원하지 않는 모드입니다.'
			----select 'DEBUG ' + @comment
		END

	else if (@mode_ = @MODE_TSUPGRADE_NORMAL and @heart < @needheart )
		BEGIN
			set @nResult_ = @RESULT_ERROR_HEART_LACK
			set @comment = 'ERROR 하트이 부족하다.'
			----select 'DEBUG ' + @comment
		END
	else if (@mode_ = @MODE_TSUPGRADE_PREMINUM and @cashcost < @needcashcost)
		BEGIN
			set @nResult_ = @RESULT_ERROR_CASHCOST_LACK
			set @comment = 'ERROR 루비가 부족합니다.'
			----select 'DEBUG ' + @comment
		END
	else if( @treasureupgrade >= @upstepmax )
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_UPGRADE_FULL
			set @comment 	= 'ERROR 업그레이드가 풀입니다.'
			----select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '강화합니다.(1)'
			----select 'DEBUG ' + @comment

			--------------------------------------
			-- 분류에 의한 성고, 실패.
			-- 확률계산 -> 업그레이드.
			--------------------------------------
			if( @mode_ = @MODE_TSUPGRADE_NORMAL )
				begin
					set @rand 	= Convert(int, ceiling(RAND() * 1000))
					set @rand2	= dbo.fun_GetTSUpgradeProbability( @grade, @treasureupgrade + 1)
					----select 'DEBUG 일반강화 > 확률', @rand rand, @rand2 rand2

					if( @rand <= @rand2 )
						begin
							----select 'DEBUG 성공'
							set @treasureupgrade = @treasureupgrade + 1
							set @tsupgraderesult = @TSUPGRADE_RESULT_SUCCESS
						end
					else
						begin
							----select 'DEBUG 실패'
							set @treasureupgrade = @treasureupgrade
							set @tsupgraderesult = @TSUPGRADE_RESULT_FAIL
						end

					-- 통계기록.
					exec spu_DayLogInfoStatic @market, 74, 1				-- 일      업글(Normal)
				end
			else
				begin
					--select 'DEBUG 캐쉬강화 > 무조건 성공.'
					set @treasureupgrade = @treasureupgrade + 1
					set @tsupgraderesult = @TSUPGRADE_RESULT_SUCCESS

					-- 통계기록.
					exec spu_DayLogInfoStatic @market, 75, 1				-- 일      업글(Pre)
				end

			--------------------------------------
			-- 보물반영.
			--------------------------------------
			update dbo.tUserItem
				set
					treasureupgrade = @treasureupgrade
			where gameid = @gameid_ and listidx = @listidx_

			---------------------------------
			-- 보물 보유효과 세팅.
			---------------------------------
			exec spu_TSRetentionEffect @gameid_, @itemcode

			--------------------------------------
			-- 캐쉬차감 > 하단에서 적용.
			--------------------------------------
			--select 'DEBUG (전)', @cashcost cashcost, @gamecost gamecost, @heart heart
			set @cashcost 	= @cashcost - @needcashcost
			set @gamecost 	= @gamecost - @needgamecost
			set @heart 		= @heart - @needheart
			--select 'DEBUG (후)', @cashcost cashcost, @gamecost gamecost, @heart heart



			--------------------------------------------------------------
			-- 유저정보 업데이트.
			--------------------------------------------------------------
			update dbo.tUserMaster
				set
					cashcost		= @cashcost,		gamecost	= @gamecost,	heart	= @heart,	feed	= @feed,
					tsupgraderesult	= @tsupgraderesult,
					bktsupcnt 		= bktsupcnt + 1,	-- 임시 보물강화.
					tsupcnt			= tsupcnt + 1,		-- 누적 보물강화.
					randserial		= @randserial_
			where gameid = @gameid_


			--------------------------------------------------------------
			-- 보물 장착템효과 세팅
			-- 저장된 정보로 하니까 여기서해야함...
			--------------------------------------------------------------
			exec spu_TSWearEffect @gameid_
		END


	--------------------------------------------------------------
	-- 	결과전송
	--------------------------------------------------------------
	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost, @heart heart, @feed feed,
		   @tsupgraderesult tsupgraderesult

	if(@nResult_ = @RESULT_SUCCESS)
		begin
			--------------------------------------------------------------
			-- 유저 보유 아이템
			--------------------------------------------------------------
			select * from dbo.tUserItem
			where gameid = @gameid_ and listidx = @listidx_

			---------------------------------------------
			-- 보물.
			---------------------------------------------
			select
				top 1 *,
				case when (@curdate > roulstart and @curdate <= roulend) then tsupgradesaleflag	else -1 end tsupgradesaleflag2,
				case when (@curdate > roulstart and @curdate <= roulend) then roulsaleflag	else -1 end roulsaleflag2,
				case when (@curdate > roulstart and @curdate <= roulend) then roulflag 		else -1 end roulflag2,
				case when (@curdate > roulstart and @curdate <= roulend) then roultimeflag 	else -1 end roultimeflag2,
				case when (@curdate > roulstart and @curdate <= roulend) then pmgauageflag 	else -1 end pmgauageflag2
			from dbo.tSystemTreasureMan
			where roulmarket like @market
			order by idx desc
		end

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
End

