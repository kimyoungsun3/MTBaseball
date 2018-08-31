/*
gameid=xxx
mode=xxx

update dbo.tUserMaster set actioncount = 0, actiontime = '2012-01-01', goldball = 0 where gameid = 'SangSang'
update dbo.tUserMaster set actioncount = 1, actiontime = '2012-01-01', goldball = 0 where gameid = 'SangSang'
update dbo.tUserMaster set actioncount = 0, actiontime = '2012-01-01', goldball = 1000 where gameid = 'SangSang'
update dbo.tUserMaster set actioncount = 1, actiontime = '2012-01-01', goldball = 1000 where gameid = 'SangSang'
update dbo.tUserMaster set actioncount = 0, goldball = 1000 where gameid = 'SangSang'
update dbo.tUserMaster set actioncount = 1, goldball = 1000 where gameid = 'DD1'



exec spu_RechargeAction 'SangSangs', '7575970askeie1595312', 1, -1		-- 존재하지 않는 아이디
exec spu_RechargeAction 'SangSang', '7575970askeie1595312', 0, -1	
exec spu_RechargeAction 'SangSang', '7575970askeie1595312', 1, -1
exec spu_RechargeAction 'SangSang', '7575970askeie1595312', 2, -1
exec spu_RechargeAction 'SangSang', '7575970askeie1595312', 3, -1		-- 하루무료이용권
exec spu_RechargeAction 'DD1', 1, -1
exec spu_RechargeAction 'DD1', 2, -1
*/
 
IF OBJECT_ID ( 'dbo.spu_RechargeAction', 'P' ) IS NOT NULL 
    DROP PROCEDURE dbo.spu_RechargeAction;
GO 

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_RechargeAction
	@gameid_								varchar(20),					-- 게임아이디
	@password_								varchar(20),
	@mode_									int,
	@nResult_								int					OUTPUT
	WITH ENCRYPTION -- 프로시져를 암호화함.
as	
	------------------------------------------------
	--	2-1. 코드값자리
	------------------------------------------------	
	-- 일반값
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1			
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1	
	
	--가입 오류.
	declare @RESULT_ERROR_ID_DUPLICATE			int				set @RESULT_ERROR_ID_DUPLICATE			= -2			
	declare @RESULT_ERROR_EMAIL_DUPLICATE		int				set @RESULT_ERROR_EMAIL_DUPLICATE		= -3
	
	-- 로그인 오류. 
	declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--블럭유저 > 팝업처리후 인트로로 빼버린다.
	declare @RESULT_ERROR_DELETED_USER 			int				set @RESULT_ERROR_DELETED_USER			= -12			--삭제유저 > 팝업처리후 인트로로 빼버린다.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함
	declare @RESULT_ERROR_NOT_FOUND_PASSWORD	int				set @RESULT_ERROR_NOT_FOUND_PASSWORD	= -17			
	declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--서버를 점검하고 있다.
	declare @RESULT_NEWVERION_CLIENT_DOWNLOAD 	int				set @RESULT_NEWVERION_CLIENT_DOWNLOAD	= -15			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 링크처리.
	declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 종료.
	                                                                                                         			
	-- 게임중에 부족.
	declare @RESULT_ERROR_ACTION_LACK			int				set @RESULT_ERROR_ACTION_LACK			= -20			--행동력이 부족하다.
	declare @RESULT_ERROR_SILVERBALL_LACK		int				set @RESULT_ERROR_SILVERBALL_LACK		= -21			--실버가 부족하다.
	declare @RESULT_ERROR_GOLDBALL_LACK			int				set @RESULT_ERROR_GOLDBALL_LACK			= -22			--골드가 부족하다.
	declare @RESULT_ERROR_ITEM_LACK				int				set @RESULT_ERROR_ITEM_LACK				= -23			--아이템이부족하다.
	declare @RESULT_ERROR_COIN_LACK				int				set @RESULT_ERROR_COIN_LACK				= -24			--코인잉 부족하다.

	-- 아이템 구매, 변경.                                                                                                   			
	declare @RESULT_ERROR_BUY_ALREADY			int				set @RESULT_ERROR_BUY_ALREADY			= -31			--이미 구매했습니다.
	declare @RESULT_ERROR_NOT_HAVE				int				set @RESULT_ERROR_NOT_HAVE				= -32			--보유하지 않고 있다.
	declare @RESULT_ERROR_UPGRADE_CANNT			int				set @RESULT_ERROR_UPGRADE_CANNT			= -33			--업그레이드를 할수 없다.						
	declare @RESULT_ERROR_UPGRADE_FAIL			int				set @RESULT_ERROR_UPGRADE_FAIL			= -34			--업그레이드 실패.
	declare @RESULT_ERROR_UPGRADE_FULL			int				set @RESULT_ERROR_UPGRADE_FULL			= -35			--업그레이드가 풀로되었다.
	declare @RESULT_ERROR_ITEM_EXPIRE			int				set @RESULT_ERROR_ITEM_EXPIRE			= -36			--아이템이 만기 되었다.
	declare @RESULT_ERROR_ITEM_NOSALE_KIND		int				set @RESULT_ERROR_ITEM_NOSALE_KIND		= -37			--판매하지 않는 아이템
	declare @RESULT_ERROR_ITEM_PERMANENT_ALREADY int			set @RESULT_ERROR_ITEM_PERMANENT_ALREADY = -38			-- 영구템을 이미 구해했습니다.
	declare @RESULT_ERROR_ITEM_NOCHANGE_KIND	int				set @RESULT_ERROR_ITEM_NOCHANGE_KIND	= -39			--자체변경불가템

	-- 캐쉬구매.
	declare @RESULT_ERROR_CASH_COPY				int				set @RESULT_ERROR_CASH_COPY				= -40			
	declare @RESULT_ERROR_CASH_OVER				int				set @RESULT_ERROR_CASH_OVER				= -41			
	declare @RESULT_ERROR_MONTH_OVER			int				set @RESULT_ERROR_MONTH_OVER			= -42			--한달동안 구매한도를 검사

	-- 아이템선물
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- 아이템코드못찾음
	declare @RESULT_ERROR_GIFTITEM_NOT_FOUND	int				set @RESULT_ERROR_GIFTITEM_NOT_FOUND	= -51			-- 선물아이템을 못찾음
	declare @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	int				set @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	= -52			-- 선물을 이미 가져감
	
	-- 기타오류
	declare @RESULT_ERROR_RESULT_COPY			int				set @RESULT_ERROR_RESULT_COPY			= -53			-- 결과카피시도
	declare @RESULT_ERROR_SILVER_COPY			int				set @RESULT_ERROR_SILVER_COPY			= -54			-- 실버카피시도
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- 지원하지않는모드
	declare @RESULT_ERROR_ACTION_FULL			int				set @RESULT_ERROR_ACTION_FULL			= -71			-- 지원하지않는모드
	
	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------	
	-- 상태값.
	declare @BLOCK_STATE_NO						int				set	@BLOCK_STATE_NO						= 0				-- 블럭상태아님
	declare @BLOCK_STATE_YES					int				set	@BLOCK_STATE_YES					= 1				-- 블럭상태
	declare @DELETE_STATE_NO					int				set	@DELETE_STATE_NO					= 0				-- 삭제상태아님
	declare @DELETE_STATE_YES					int				set	@DELETE_STATE_YES					= 1				-- 삭제상태

	-- 구매처코드
	declare @MARKET_SKT							int				set @MARKET_SKT							= 1
	declare @MARKET_KT							int				set @MARKET_KT							= 2
	declare @MARKET_LGT							int				set @MARKET_LGT							= 3
	declare @MARKET_FACEBOOK					int				set @MARKET_FACEBOOK					= 4
	declare @MARKET_GOOGLE						int				set @MARKET_GOOGLE						= 5

	-- 시스템 체킹
	declare @SYSCHECK_NON						int				set @SYSCHECK_NON						= 0
	declare @SYSCHECK_YES						int				set @SYSCHECK_YES						= 1

	-- 선물가져가기
	declare @GAINSTATE_NON						int				set @GAINSTATE_NON						= 0
	declare @GAINSTATE_YES						int				set @GAINSTATE_YES						= 1
	
	-- 아이템파트이름
	declare @ITEM_KIND_CHARACTER				int 			set @ITEM_KIND_CHARACTER				= 0
	declare @ITEM_KIND_FACE						int 			set @ITEM_KIND_FACE						= 1			-- 판매템아님
	declare @ITEM_KIND_CAP						int 			set @ITEM_KIND_CAP						= 2
	declare @ITEM_KIND_UPPER					int 			set @ITEM_KIND_UPPER					= 4
	declare @ITEM_KIND_UNDER					int 			set @ITEM_KIND_UNDER					= 5
	declare @ITEM_KIND_BAT						int 			set @ITEM_KIND_BAT						= 6
	declare @ITEM_KIND_GLASSES					int 			set @ITEM_KIND_GLASSES					= 7
	declare @ITEM_KIND_WING						int 			set @ITEM_KIND_WING						= 8
	declare @ITEM_KIND_TAIL						int 			set @ITEM_KIND_TAIL						= 9
	declare @ITEM_KIND_STADIUM					int 			set @ITEM_KIND_STADIUM					= 100
	declare @ITEM_KIND_CUSTOMIZE				int 			set @ITEM_KIND_CUSTOMIZE				= 22		-- 판매방식이 다름
	declare @ITEM_KIND_PET						int 			set @ITEM_KIND_PET						= 80
	declare @ITEM_KIND_BATTLEITEM				int 			set @ITEM_KIND_BATTLEITEM				= 90
	declare @ITEM_KIND_SYSTEMETC				int 			set @ITEM_KIND_SYSTEMETC				= 99
	
	-- 기타 정의값
	declare @ITEM_PERMANENT_START_DAY			datetime		set @ITEM_PERMANENT_START_DAY			= '2012-01-01'	-- 영구템시작
	declare @ITEM_PERMANENT_ADD_YEAR			int				set @ITEM_PERMANENT_ADD_YEAR			= 50			-- 영구템기간
	declare @ITEM_PERIOD_PERMANENT				int 			set @ITEM_PERIOD_PERMANENT				= -1			-- 테이블에 -1이라 기록됨

	--아이템만기
	declare @ITEM_EXPIRE_STATE_NO				int 			set @ITEM_EXPIRE_STATE_NO				= 0			
	declare @ITEM_EXPIRE_STATE_YES				int				set @ITEM_EXPIRE_STATE_YES				= 1

	-- 코인으로 무엇인가 얻을 경우.
	declare @COIN_RESULT_SILVER_ITEM			int				set @COIN_RESULT_SILVER_ITEM 			= 1;
	declare @COIN_RESULT_PERIOD_ITEM			int				set	@COIN_RESULT_PERIOD_ITEM			= 2;
	declare @COIN_RESULT_BATTLE_ITEM1			int				set	@COIN_RESULT_BATTLE_ITEM1			= 3;
	declare @COIN_RESULT_BATTLE_ITEM2			int				set	@COIN_RESULT_BATTLE_ITEM2			= 4;
	declare @COIN_RESULT_BATTLE_ITEM3			int				set	@COIN_RESULT_BATTLE_ITEM3			= 5;
	declare @COIN_RESULT_BATTLE_ITEM4			int				set	@COIN_RESULT_BATTLE_ITEM4			= 6;
	declare @COIN_RESULT_BATTLE_ITEM5			int				set	@COIN_RESULT_BATTLE_ITEM5			= 7;
	
	-- 액션충전
	declare @MODE_ACTION_RECHARGE_FULL			int				set	@MODE_ACTION_RECHARGE_FULL			= 1;
	declare @MODE_ACTION_RECHARGE_HALF			int				set	@MODE_ACTION_RECHARGE_HALF			= 2;
	declare @MODE_ACTION_RECHARGE_FREE			int				set	@MODE_ACTION_RECHARGE_FREE			= 3;	
	declare @ITEMCODE_ACTION_RECHARGE_FULL		int				set	@ITEMCODE_ACTION_RECHARGE_FULL		= 7000;
	declare @ITEMCODE_ACTION_RECHARGE_HALF		int				set	@ITEMCODE_ACTION_RECHARGE_HALF		= 7001;
	declare @ITEMCODE_ACTION_RECHARGE_FREE		int				set	@ITEMCODE_ACTION_RECHARGE_FREE		= 7004;
	
	
	-- 타임의 종류
	declare @LOOP_TIME_ACTION				int 			set @LOOP_TIME_ACTION 				= 3*60			-- 행동력 3분에 한개씩 채워줌
	declare @LOOP_TIME_SMS					int 			set @LOOP_TIME_SMS 					= 40*60			-- SMS 40분에 한번씩
	declare @LOOP_TIME_FRIENDLS				int 			set @LOOP_TIME_FRIENDLS				= 20*60			-- 친구라커룸실버 20M분에 한개씩 채워줌

	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @gameid				varchar(20)
	declare @comment			varchar(80)

	declare @actioncount		int
	declare @actioncount2		int
	declare	@actionmax			int
	declare @actiontime			datetime
	declare @actionfreedate		datetime
	declare @goldball			int
	declare @goldball2			int
	declare @itemcode			int
	
	declare @goldballFullPrice		int				set @goldballFullPrice		= 10
	declare @goldballHalfPrice		int				set @goldballHalfPrice		= 6
	declare @goldballFreePrice		int				set @goldballFreePrice		= 50
	declare @freeModePeriod			int				set @freeModePeriod			= 1
	
	declare @goldballPrice		int					set @goldballPrice 			= 0
	declare @silverballPrice 	int					set @silverballPrice		= 0
	
	
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR	
	set @comment = 'ERROR 알수없는 오류(-1)'
	--select 'DEBUG 1-0', @gameid_ gameid_, @password_ password_, @mode_ mode_, @nResult_ nResult_

	------------------------------------------------
	--	유저 정보읽어오기
	------------------------------------------------
	--유저 정보를 읽어오기
	select 
		@gameid = gameid,
		@actioncount = actioncount, @actionmax = actionmax, @actiontime = actiontime,
		@actionfreedate = actionfreedate,
		@actioncount2 = actioncount,
		@goldball = goldball, @goldball2 = goldball
	from dbo.tUserMaster where gameid = @gameid_ and password = @password_
	--select 'DEBUG 1-1', @gameid gameid, @actioncount actioncount, @actionmax actionmax, @actiontime actiontime, @actionfreedate actionfreedate, @actioncount2 actioncount2, @goldball goldball, @goldball2 goldball2
	
	------------------------------------------------
	--	아이템 정보 읽어오기 > 직접읽기(변경)
	--	별도의 관리 테이블에서 변경하기	
	------------------------------------------------
	select top 1
		@goldballFullPrice = fullmodeprice, 
		@goldballHalfPrice = halfmodeprice, 
		@goldballFreePrice = freemodeprice, 
		@freeModePeriod = freemodeperiod
	from dbo.tActionInfo where flag = 1 order by idx desc
	
	---- 1. 커서선언
	--declare @goldball3 int
	--declare @itemcode3 int
	--declare curItemInfo Cursor for 
	--select goldball, itemcode from dbo.tItemInfo where itemcode in (@ITEMCODE_ACTION_RECHARGE_FULL, @ITEMCODE_ACTION_RECHARGE_HALF, @ITEMCODE_ACTION_RECHARGE_FREE)
	----select 'DEBUG 1-2', @ITEMCODE_ACTION_RECHARGE_FULL, @ITEMCODE_ACTION_RECHARGE_HALF, @ITEMCODE_ACTION_RECHARGE_FREE
	--
	---- 2. 커서오픈
	--open curItemInfo
	--
	---- 3. 커서 사용
	--Fetch next from curItemInfo into @goldball3, @itemcode3
	--while @@Fetch_status = 0
	--	Begin	
	--		--select 'DEBUG 1-3', @goldball3 goldball3
	--		if(@itemcode3 = @ITEMCODE_ACTION_RECHARGE_FULL)
	--			set @goldballFullPrice = @goldball3
	--		else if(@itemcode3 = @ITEMCODE_ACTION_RECHARGE_HALF)
	--			set @goldballHalfPrice = @goldball3
	--		else if(@itemcode3 = @ITEMCODE_ACTION_RECHARGE_FREE)
	--			set @goldballFreePrice = @goldball3
	--		Fetch next from curItemInfo into @goldball3, @itemcode3
	--	end
	--
	---- 4. 커서닫기
	--close curItemInfo
	--Deallocate curItemInfo
	----select 'DEBUG 1-4', @mode_ mode_, @goldballFullPrice goldballFullPrice, @goldballHalfPrice goldballHalfPrice, @goldballFreePrice goldballFreePrice
	
	------------------------------------------------
	--	행동력 > 늘어날 시간인가? 검사 > 충전
	------------------------------------------------
	declare @nActPerMin bigint,
			@nActCount int, 					
			@dActTime datetime
	set @nActPerMin = @LOOP_TIME_ACTION						-- 행동력 2분에 한개씩 채워줌
	set @nActCount = datediff(s, @actiontime, getdate())/@nActPerMin
	set @dActTime = DATEADD(s, @nActCount*@nActPerMin, @actiontime)
	set @actioncount = @actioncount + @nActCount
	set @actioncount = case when @actioncount > @actionmax then @actionmax else @actioncount end
	--select 'DEBUG 행동치지급', @actioncount '보정행동치(시간후)', @actiontime '갱신시간전',  @actionmax '행동치맥스량', @dActTime '갱신시간'
	
	
	------------------------------------------------
	-- 3-3. 각 조건별 분기
	------------------------------------------------
	if isnull(@gameid, '') = ''
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment = 'ERROR 존재하지 않는 아이디 입니다.'
			--select 'DEBUG 2-1', @comment
		END
	else if (@mode_ not in (@MODE_ACTION_RECHARGE_HALF, @MODE_ACTION_RECHARGE_FULL, @MODE_ACTION_RECHARGE_FREE))
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment = 'ERROR 지원하지 않는 모드입니다.'
			--select 'DEBUG 3-1', @comment
		END
	else if(@actioncount2 >= @actionmax and @mode_ != @MODE_ACTION_RECHARGE_FREE)
		BEGIN
			set @nResult_ = @RESULT_ERROR_ACTION_FULL
			set @comment = 'ERROR 행동치가 맥스입니다.'
			--select 'DEBUG 4-1', @comment
		END
	else if ((@mode_ = @MODE_ACTION_RECHARGE_FULL 		and @goldball < @goldballFullPrice) 
		 or ( @mode_ = @MODE_ACTION_RECHARGE_HALF 		and @goldball < @goldballHalfPrice) 
		 or ( @mode_ = @MODE_ACTION_RECHARGE_FREE 		and @goldball < @goldballFreePrice) )
		BEGIN
			set @nResult_ = @RESULT_ERROR_GOLDBALL_LACK
			set @comment = 'ERROR 골든볼이 부족'
			--select 'DEBUG 5-1', @comment
		END
	else if (@mode_ = @MODE_ACTION_RECHARGE_HALF and @goldball >= @goldballHalfPrice)
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 골드 > 행동치 하프복구'
			--select 'DEBUG 6-1', @comment
			
			set @goldball = @goldball - @goldballHalfPrice
			set @actioncount = @actioncount + @actionmax/2
			if(@actionmax%2 = 1)
				begin
					-- 반올림해서 지급해준다.
					set @actioncount = @actioncount + 1
				end
			set @itemcode = @ITEMCODE_ACTION_RECHARGE_HALF
			
			set @goldballPrice = @goldballHalfPrice
		END
	else if (@mode_ = @MODE_ACTION_RECHARGE_FULL and @goldball >= @goldballFullPrice)
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 골드 > 행동치 풀복구'
			--select 'DEBUG 7-1', @comment
			
			set @goldball = @goldball - @goldballFullPrice
			set @actioncount = @actioncount + @actionmax
			set @itemcode = @ITEMCODE_ACTION_RECHARGE_FULL
			
			set @goldballPrice = @goldballFullPrice
		END
	else if (@mode_ = @MODE_ACTION_RECHARGE_FREE and @goldball >= @goldballFreePrice)
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 골드 > 행동치 하루무제한'
			--select 'DEBUG 8-1', @comment
			
			set @goldball = @goldball - @goldballFreePrice
			set @actioncount = @actioncount + @actionmax
			set @itemcode = @ITEMCODE_ACTION_RECHARGE_FREE
			

			if(@actionfreedate < getdate())
				begin
					--select 'DEBUG 8-2 > 오늘부터 하루'
					set @actionfreedate = getdate()
				end
			else
				begin
					--select 'DEBUG 8-3 > 남은 시간이 있어 추가'
					set @actionfreedate = @actionfreedate
				end
			
			--set @actionfreedate = DATEADD(dd, 1, @actionfreedate)
			set @actionfreedate = DATEADD(dd, @freeModePeriod, @actionfreedate)
			
			
			set @goldballPrice = @goldballFreePrice
		END



	------------------------------------------------
	-- 4-1. 각 조건별 분기 > 결과출력
	------------------------------------------------
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			---------------------------------------------------------
			-- 코드출력
			---------------------------------------------------------
			select @nResult_ rtn, @comment
			
			---------------------------------------------------------
			-- 행동치 맥스 초과하지 않도록 설정
			---------------------------------------------------------
			set @actioncount = case 
									when @actioncount > @actionmax then @actionmax 
									when @actioncount < 0 then 0
									else @actioncount
								end
			
			---------------------------------------------------------
			-- 유저정보기록
			---------------------------------------------------------			
			--select 'DEBUG (전)', actioncount, actiontime, goldball from dbo.tUserMaster where gameid = @gameid
			update dbo.tUserMaster
			set
				goldball		= @goldball,
				actioncount		= @actioncount,
				actiontime		= @dActTime,
				actionfreedate 	= @actionfreedate
			where gameid = @gameid_			
			--select 'DEBUG (후)', actioncount, actiontime, goldball from dbo.tUserMaster where gameid = @gameid
			
			---------------------------------------------------------
			-- 행동치구매로그 기록하기
			---------------------------------------------------------
			insert into dbo.tItemBuyLog(gameid, itemcode, goldball, silverball) 
			values(@gameid, @itemcode, @goldball2 - @goldball, 0)
			
			
			---------------------------------------------------
			-- 토탈로그 기록하기
			---------------------------------------------------
			declare @dateid varchar(8)
			set @dateid = Convert(varchar(8),Getdate(),112)		-- 20120819
			if(exists(select top 1 * from dbo.tItemBuyLogTotalSub where dateid = @dateid and itemcode = @itemcode))
				begin
					update dbo.tItemBuyLogTotalSub 
						set 
							goldball = goldball + @goldballPrice, 
							silverball = silverball + @silverballPrice, 
							cnt = cnt + 1
					where dateid = @dateid and itemcode = @itemcode
				end
			else
				begin
					insert into dbo.tItemBuyLogTotalSub(dateid, itemcode, goldball, silverball, cnt)
					values(@dateid, @itemcode, @goldballPrice, @silverballPrice, 1)
				end
				
			
			---------------------------------------------------------
			-- 더블실버, 부스터모드 로그기록
			---------------------------------------------------------
			if(exists(select top 1 * from dbo.tItemBuyPromotionTotal where dateid = @dateid and itemcode = @itemcode))
				begin
					update dbo.tItemBuyPromotionTotal 
						set 
							goldball = goldball + @goldballPrice,
							cnt = cnt + 1
					where dateid = @dateid and itemcode = @itemcode
				end
			else
				begin
					insert into dbo.tItemBuyPromotionTotal(dateid, itemcode, goldball, cnt)
					values(@dateid, @itemcode, @goldballPrice, 1)
				end

		end
	else
		begin 
			---------------------------------------------------------
			-- 코드출력
			---------------------------------------------------------
			select @nResult_ rtn, @comment
			return;
		end

	------------------------------------------------
	--	4-2. 유저정보
	------------------------------------------------		
	select * from dbo.tUserMaster where gameid = @gameid_
	set nocount off
End

