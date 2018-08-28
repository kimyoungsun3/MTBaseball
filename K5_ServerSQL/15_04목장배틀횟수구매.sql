/*
update dbo.tUserMaster set cashcost = 1000 where gameid = 'xxxx2'  update dbo.tUserFarm set playcnt = 0 where gameid = 'xxxx2' and itemcode in ( 6900, 6901, 6902 )

exec spu_AniBattlePlayCntBuy 'xxxx2', '049000s1i0n7t8445289', 6900, -1
exec spu_AniBattlePlayCntBuy 'xxxx2', '049000s1i0n7t8445289', 6901, -1
exec spu_AniBattlePlayCntBuy 'xxxx2', '049000s1i0n7t8445289', 6902, -1
*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_AniBattlePlayCntBuy', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_AniBattlePlayCntBuy;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_AniBattlePlayCntBuy
	@gameid_								varchar(20),					-- 게임아이디
	@password_								varchar(20),
	@farmidx_								int,
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
	declare @RESULT_ERROR_CASHCOST_LACK			int				set @RESULT_ERROR_CASHCOST_LACK			= -22			--골드가 부족하다.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함
	declare @RESULT_ERROR_NOT_FOUND_USERFARM	int				set @RESULT_ERROR_NOT_FOUND_USERFARM	= -125			-- 목장리스트가 미구매.

	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------
	-- 농장(정보).
	declare @USERFARM_BUYSTATE_NOBUY			int					set @USERFARM_BUYSTATE_NOBUY				= -1	-- (농장)
	declare @USERFARM_BUYSTATE_BUY				int					set @USERFARM_BUYSTATE_BUY					=  1

	declare @FARM_BATTLE_PLAYCNT_MAX			int					set @FARM_BATTLE_PLAYCNT_MAX				= 10	-- 배틀횟수.

	-- 배틀참여횟수 코드번호.
	declare @BATTLE_PLAYCNT_ITEMCODE			int					set @BATTLE_PLAYCNT_ITEMCODE				= 50003

	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @comment				varchar(512)		set @comment			= ''
	declare @gameid					varchar(20)			set @gameid				= ''
	declare @market					int					set @market				= 1
	declare @version				int					set @version			= 101
	declare @cashcost				int					set @cashcost 			= 0
	declare @gamecost				int					set @gamecost 			= 0

	declare @buystate				int					set @buystate			= @USERFARM_BUYSTATE_NOBUY
	declare @playcnt				int					set @playcnt			= 0
	declare @needcashcost			int					set @needcashcost		= 9999

	-- VIP효과.
	declare @cashpoint				int				set @cashpoint					= 0
	declare @vip_plus				int				set @vip_plus					= 0

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG 입력정보', @gameid_ gameid_, @password_ password_, @farmidx_ farmidx_

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	select
		@gameid 		= gameid,			@market			= market,		@version		= version,
		@cashpoint		= cashpoint,
		@cashcost		= cashcost,			@gamecost		= gamecost
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 유저정보', @gameid gameid, @cashcost cashcost

	select
		@buystate		= buystate,		@playcnt		= playcnt
	from dbo.tUserFarm
	where gameid = @gameid_ and itemcode = @farmidx_
	--select 'DEBUG 농장 보유정보', @farmidx_ farmidx_, @buystate buystate, @playcnt playcnt

	select
		@needcashcost = cashcost
	from dbo.tItemInfo
	where itemcode = @BATTLE_PLAYCNT_ITEMCODE
	--select 'DEBUG 배틀참여횟수 캐쉬가격', @needcashcost needcashcost

	------------------------------------------------
	-- 3-3. 각 조건별 분기
	------------------------------------------------
	if( @gameid = '' )
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR 아이디가 존재하지 않는다.'
			--select 'DEBUG ' + @comment
		END
	else if(@playcnt > 0)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment = 'SUCCESS 구매했습니다.(2)'
			--select 'DEBUG ' + @comment
		END
	else if(@buystate != @USERFARM_BUYSTATE_BUY)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_USERFARM
			set @comment 	= 'ERROR 농장을 소유하고 있지 않다.'
			--select 'DEBUG ' + @comment
		END
	else if( @needcashcost > @cashcost )
		BEGIN
			set @nResult_ = @RESULT_ERROR_CASHCOST_LACK
			set @comment = 'ERROR 캐쉬가 부족합니다.'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 구매했습니다.(1)'
			--select 'DEBUG ' + @comment

			---------------------------------------------
			-- 캐쉬차감
			-- 다음날에 횟수 자동으로 입력은 로그인의 복잡한 부분을 연결해야해서 여기서 진행하면 안된다.
			---------------------------------------------
			--select 'DEBUG (전)', @cashcost cashcost, @needcashcost needcashcost
			set @cashcost	= @cashcost - @needcashcost
			--select 'DEBUG (후)', @cashcost cashcost, @needcashcost needcashcost

			---------------------------------------------
			-- 기록마킹
			---------------------------------------------
			update dbo.tUserMaster
				set
					cashcost		= @cashcost
			where gameid = @gameid_

			---------------------------------------------
			-- 배틀참여횟수.
			---------------------------------------------
			set @vip_plus = dbo.fun_GetVIPPlus( 8, @cashpoint, @FARM_BATTLE_PLAYCNT_MAX)		-- 목장횟수

			update dbo.tUserFarm
				set
					playcnt = @FARM_BATTLE_PLAYCNT_MAX + @vip_plus
			where gameid = @gameid_ and itemcode = @farmidx_

			------------------------------------------------
			-- 통계정보.
			------------------------------------------------
			exec spu_DayLogInfoStatic @market, 33, 1				-- 일 배틀횟수구매.

			-----------------------------------
			-- 구매기록마킹
			-----------------------------------
			exec spu_UserItemBuyLogNew @gameid_, @BATTLE_PLAYCNT_ITEMCODE, 0, @needcashcost, 0
		END


	--------------------------------------------------------------
	-- 결과전송.
	--------------------------------------------------------------
	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost


	if(@nResult_ = @RESULT_SUCCESS)
		begin
			--------------------------------------------------------------
			-- 농장리스트 전송
			--------------------------------------------------------------
			exec spu_UserFarmListNew @gameid_, 1, @market, @version
		end



	------------------------------------------------
	--	4-2. 유저정보
	------------------------------------------------
	set nocount off
End

