---------------------------------------------------------------
/* 
[연습게임시작/재시작]
gameid=xxx
gmode=GAME_MODE_TRAIN

select * from dbo.tUserMaster where gameid = 'SangSang'
exec spu_GameStart 'SangSang', 1, -1, -1, -1, -1, -1, -1			--연습모드
exec spu_GameStart 'SangSang', 2, -1, -1, -1, -1, -1, -1			--머신모드
exec spu_GameStart 'SangSang', 3, -1, -1, -1, -1, -1, -1			--암기모드
exec spu_GameStart 'SangSang', 4, -1, -1, -1, -1, -1, -1			--소울모드(기능삭제)
exec spu_GameStart 'SangSang', 5,  1,  0,  1,  0,  1, -1			--배틀모드
exec spu_GameStart 'SangSang', 5,  1,  1,  1,  1,  1, -1			--배틀모드
exec spu_GameStart 'SangSang', 5,  0,  0,  0,  0,  0, -1			--배틀모드
exec spu_GameStart 'SangSang', 5,  1,  0,  0,  0,  0, -1			--배틀모드
exec spu_GameStart 'SangSang', 5,  0,  1,  0,  0,  0, -1			--배틀모드
exec spu_GameStart 'SangSang', 5,  0,  0,  1,  0,  0, -1			--배틀모드
exec spu_GameStart 'SangSang', 5,  0,  0,  0,  1,  0, -1			--배틀모드
exec spu_GameStart 'SangSang', 5,  0,  0,  0,  0,  0, -1			--배틀모드
exec spu_GameStart 'superman6', 6,  0,  0,  0,  0,  0, -1			--스프린트
exec spu_GameStart 'SangSang', 6,  1,  1,  1,  1,  1, -1			--스프린트
exec spu_GameStart 'sususu', 6,  1,  1,  1,  1,  1, -1			--스프린트
update dbo.tUserMaster set actioncount = actionmax, btflag = 0, btflag2 = 0, bttem1cnt = 1, bttem2cnt = 1, bttem3cnt = 1, bttem4cnt = 1, bttem5cnt = 1, silverball = 1000 where gameid = 'SangSang'



exec spu_GameStart 'SangSang1', 2, -1, -1, -1, -1, -1, -1			--머신모드
*/

IF OBJECT_ID ( 'dbo.spu_GameStart', 'P' ) IS NOT NULL 
    DROP PROCEDURE dbo.spu_GameStart;
GO 

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_GameStart
	@gameid_								varchar(20),					-- 게임아이디
	@gmode_									int,
	@bttem1chk_								int,
	@bttem2chk_								int,
	@bttem3chk_								int,
	@bttem4chk_								int,
	@bttem5chk_								int,
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

	-- 캐쉬구매.
	declare @RESULT_ERROR_CASH_COPY				int				set @RESULT_ERROR_CASH_COPY				= -40			
	declare @RESULT_ERROR_CASH_OVER				int				set @RESULT_ERROR_CASH_OVER				= -41			
	declare @RESULT_ERROR_MONTH_OVER			int				set @RESULT_ERROR_MONTH_OVER			= -42			--한달동안 구매한도를 검사

	-- 아이템선물
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- 아이템코드못찾음
	declare @RESULT_ERROR_GIFTITEM_NOT_FOUND	int				set @RESULT_ERROR_GIFTITEM_NOT_FOUND	= -51			-- 선물아이템을 못찾음
	declare @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	int				set @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	= -52			-- 선물을 이미 가져감


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
	
	-- 게임시작
	declare @GAME_MODE_TRAINING					int				set @GAME_MODE_TRAINING					= 1
	declare @GAME_MODE_MACHINE					int				set @GAME_MODE_MACHINE					= 2
	declare @GAME_MODE_MEMORISE					int				set @GAME_MODE_MEMORISE					= 3
	declare @GAME_MODE_SOUL						int				set @GAME_MODE_SOUL						= 4
	declare @GAME_MODE_BATTLE					int				set @GAME_MODE_BATTLE					= 5
	declare @GAME_MODE_SPRINT					int				set @GAME_MODE_SPRINT					= 6
	
	-- 모드별 행동력 소모량
	declare @GAME_MODE_SINGLE_ACTION			int				set @GAME_MODE_SINGLE_ACTION					= 3
	declare @GAME_MODE_BATTLE_ACTION			int				set @GAME_MODE_BATTLE_ACTION					= 5

	-- 게임플레이 상태정보
	declare @GAME_STATE_END						int				set @GAME_STATE_END						= 0
	declare @GAME_STATE_PLAYING					int				set @GAME_STATE_PLAYING					= 1
	
	-- 타임의 종류
	declare @LOOP_TIME_ACTION				int 			set @LOOP_TIME_ACTION 				= 3*60			-- 행동력 2분에 한개씩 채워줌
	declare @LOOP_TIME_SMS					int 			set @LOOP_TIME_SMS 					= 40*60			-- SMS 40분에 한번씩
	declare @LOOP_TIME_FRIENDLS				int 			set @LOOP_TIME_FRIENDLS				= 20*60			-- 친구라커룸실버 20M분에 한개씩 채워줌
	declare @LOOP_TIME_COIN					int 			set @LOOP_TIME_COIN					= 24*60*60		-- 하루에 하나의 코인 지급(맥스 1개)

	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @actioncount	int
	declare	@actionmax		int
	declare @actiontime		datetime
	declare @silverball		int
	declare @bttem1cnt		int
	declare @bttem2cnt		int
	declare @bttem3cnt		int
	declare @bttem4cnt		int
	declare @bttem5cnt		int
	
	--원래는 아이템 테이블에서 읽어야하지만 자주 읽지 않도록 하기위해서 강제세팅해둠
	declare @bttem1price	int									set @bttem1price						= 70
	declare @bttem2price	int									set @bttem2price						= 90
	declare @bttem3price	int									set @bttem3price						= 110
	declare @bttem4price	int									set @bttem4price						= 120
	declare @bttem5price	int									set @bttem5price						= 5
	
	--스테미너 무료이용권 지정된 시간
	declare @actionfreedate		datetime
	
	-- 시간체킹
	declare @dateid10 		varchar(10) 						set @dateid10 							= Convert(varchar(8), Getdate(),112) + Convert(varchar(2), Getdate(), 108)
	declare @market			int									set @market								= 1
	

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR	
	
	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	-- 유저 데이타 읽어오기
	select 
		@market = market,
		@actioncount = actioncount, @actionmax = actionmax, @actiontime = actiontime,
		@actionfreedate = actionfreedate,
		@bttem1cnt = bttem1cnt, 
		@bttem2cnt = bttem2cnt, 
		@bttem3cnt = bttem3cnt, 
		@bttem4cnt = bttem4cnt, 
		@bttem5cnt = bttem5cnt, 
		@silverball = silverball
	from dbo.tUserMaster where gameid = @gameid_

	
	------------------------------------------------
	--	유저존재유무
	------------------------------------------------
	if isnull(@silverball, -1) = -1
		BEGIN
			set @nResult_ = @RESULT_ERROR
			select @nResult_ rtn, 'ERROR 유저가 존재하지 않습니다.'
			return
		END


	------------------------------------------------
	--	(배틀)모드 템체크
	-- 스프린트모드는 노체크 
	------------------------------------------------
	IF(@gmode_ in (@GAME_MODE_BATTLE))
		begin
			--select 'DEBUG (배틀)모드 템체크'
			
			-- 배틀아이템 체킹 and 배틀아이템 보유하면 차감, 없으면 실버차감
			if(@bttem1chk_ = 1)
				begin 
					if(@bttem1cnt > 0)
						begin
							--select 'DEBUG 배틀1번 있음 > 개수차감:' + str(@bttem1cnt)
							set @bttem1cnt = @bttem1cnt - 1
						end
					else
						begin
							--select 'DEBUG 배틀1번 없음 > 실버차감:' + str(@silverball)
							set @silverball = @silverball - @bttem1price;
						end
				end
				
			if(@bttem2chk_ = 1)
				begin 
					if(@bttem2cnt > 0)
						begin
							--select 'DEBUG 배틀2번 있음 > 개수차감:' + str(@bttem2cnt)
							set @bttem2cnt = @bttem2cnt - 1
						end
					else
						begin
							--select 'DEBUG 배틀2번 없음 > 실버차감:' + str(@silverball)
							set @silverball = @silverball - @bttem2price;
						end
				end
				
			if(@bttem3chk_ = 1)
				begin 
					if(@bttem3cnt > 0)
						begin
							--select 'DEBUG 배틀3번 있음 > 개수차감:' + str(@bttem3cnt)
							set @bttem3cnt = @bttem3cnt - 1
						end
					else
						begin
							--select 'DEBUG 배틀3번 없음 > 실버차감:' + str(@silverball)
							set @silverball = @silverball - @bttem3price;
						end
				end
				
			if(@bttem4chk_ = 1)
				begin 
					if(@bttem4cnt > 0)
						begin
							--select 'DEBUG 배틀4번 있음 > 개수차감:' + str(@bttem4cnt)
							set @bttem4cnt = @bttem4cnt - 1
						end
					else
						begin
							--select 'DEBUG 배틀4번 없음 > 실버차감:' + str(@silverball)
							set @silverball = @silverball - @bttem4price;
						end
				end
				
			if(@bttem5chk_ = 1)
				begin 
					if(@bttem5cnt > 0)
						begin
							--select 'DEBUG 배틀5번 있음 > 개수차감:' + str(@bttem5cnt)
							set @bttem5cnt = @bttem5cnt - 1
						end
					else
						begin
							--select 'DEBUG 배틀3번 없음 > 실버차감:' + str(@silverball)
							set @silverball = @silverball - @bttem5price;
						end
				end
			 
		end
	

	-----------------------------------------------
	--	행동력 > 늘어날 시간인가? 검사 > 충전
	-----------------------------------------------
	-- select * from tUserMaster where gameid = 'SangSang'
	--set @actionmax = 25				
	--set @actiontime = '2012-08-02 13:00'		
	--set @gameid_ = 'SangSang'
	--set @gmode_ = @GAME_MODE_TRAINING
	--set @actioncount = 0 		
	--exec spu_GameStart 'SangSang', 1, -1			--연습모드

	declare @nActPerMin bigint,
			@nActCount int, 					
			@dActTime datetime
	set @nActPerMin = @LOOP_TIME_ACTION						-- 행동력 2분에 한개씩 채워줌
	set @nActCount = datediff(s, @actiontime, getdate())/@nActPerMin
	set @dActTime = DATEADD(s, @nActCount*@nActPerMin, @actiontime)
	set @actioncount = @actioncount + @nActCount
	set @actioncount = case when @actioncount > @actionmax then @actionmax else @actioncount end
	--select 'DEBUG 행동치지급', @actiontime '갱신시간전', getdate() '현재시간', @nActCount '추가행동치', @actioncount '보정행동치(시간후)', @actionmax '행동치맥스량', @dActTime '갱신시간'
	
	
	-----------------------------------------------
	--	유저가 스테미너 무료 이용기간인가?
	-----------------------------------------------		
	if(@actionfreedate >= getdate())
		begin
			--select 'DEBUG 날짜가 남은 것이 있다.'
			set @actioncount = @actionmax
		end
	
	-----------------------------------------------
	--	정보 저장하기
	-----------------------------------------------		
	if(@actioncount > 0)
		begin
			--select 'DEBUG 갱신전', * from dbo.tUserMaster where gameid = @gameid_
			update dbo.tUserMaster 
			set
				actioncount		= @actioncount,			-- 행동력 갱신
				actiontime		= @dActTime
			where gameid = @gameid_
			--select 'DEBUG 갱신후', * from dbo.tUserMaster where gameid = @gameid_	
		end
		
	
	-----------------------------------------------
	--	유저 행동치 모드별 차감
	-----------------------------------------------		
	-- (유저 행동치 게임모드를 참조해서 행동치 비교)				
	
	
	IF (@gmode_ in (@GAME_MODE_BATTLE) and @silverball < 0)
		BEGIN
			set @nResult_ = @RESULT_ERROR_SILVERBALL_LACK
			select @nResult_ rtn, 'ERROR 실버부족:' + str(@silverball)
		END
	ELSE IF (((@gmode_ = @GAME_MODE_TRAINING 
		or @gmode_ = @GAME_MODE_MACHINE 
		or @gmode_ = @GAME_MODE_MEMORISE 
		or @gmode_ = @GAME_MODE_SOUL) and @actioncount < @GAME_MODE_SINGLE_ACTION)
		or (@gmode_ = @GAME_MODE_BATTLE and @actioncount < @GAME_MODE_BATTLE_ACTION)
		or (@gmode_ = @GAME_MODE_SPRINT and @actioncount < @GAME_MODE_BATTLE_ACTION))
		BEGIN	
			set @nResult_ = @RESULT_ERROR_ACTION_LACK
			select @nResult_ rtn, 'ERROR 행동치부족:' + str(@actioncount)
		END
	ELSE
		BEGIN	
			-- 결과 코드세팅
			set @nResult_ = @RESULT_SUCCESS
			select @nResult_ rtn, 'SUCCESS 행동치충분:' + str(@actioncount)
			
			--행동치 -3감소, 배틀 전적+1				
			--select 'DEBUG 전', actioncount, trainflag, machineflag, memorialflag, soulflag, bttotal, btflag, btflag2, bttem1chk, bttem2chk, bttem3chk, bttem4chk, bttem5chk, bttem1cnt, bttem2cnt, bttem3cnt, bttem4cnt, bttem5cnt, silverball from dbo.tUserMaster where gameid = @gameid_
			if(@gmode_ not in (@GAME_MODE_BATTLE, @GAME_MODE_SPRINT))
				begin
					--select ' DEBUG 싱글 행동치 차감(-3), 종류별 > 싱글플래그 활성화'
					
					update dbo.tUserMaster 
						set
						actioncount		= actioncount - case when @actionfreedate >= getdate() then 0 else @GAME_MODE_SINGLE_ACTION end,
						trainflag		= case @gmode_ when @GAME_MODE_TRAINING then @GAME_STATE_PLAYING else trainflag end,
						machineflag		= case @gmode_ when @GAME_MODE_MACHINE then @GAME_STATE_PLAYING else machineflag end,
						memorialflag	= case @gmode_ when @GAME_MODE_MEMORISE then @GAME_STATE_PLAYING else memorialflag end,
						soulflag		= case @gmode_ when @GAME_MODE_SOUL then @GAME_STATE_PLAYING else soulflag end
					where gameid = @gameid_
				end
			else
				begin
					--select ' DEBUG 배틀 행동치 차감(-5), 배틀전적 +1, 게임모드 플래그 GAME_STATE_END > GAME_STATE_PLAYING'
					if(@gmode_ in (@GAME_MODE_BATTLE))
						begin
							update dbo.tUserMaster 
								set
								actioncount	= actioncount - case when @actionfreedate >= getdate() then 0 else @GAME_MODE_BATTLE_ACTION end,
								bttotal	= bttotal + 1,
								btflag		= case @gmode_ when @GAME_MODE_BATTLE then @GAME_STATE_PLAYING else btflag end,
								bttem1chk = @bttem1chk_,
								bttem2chk = @bttem2chk_,
								bttem3chk = @bttem3chk_,
								bttem4chk = @bttem4chk_,
								bttem5chk = @bttem5chk_,
		
								bttem1cnt = @bttem1cnt,
								bttem2cnt = @bttem2cnt,
								bttem3cnt = @bttem3cnt,
								bttem4cnt = @bttem4cnt,
								bttem5cnt = @bttem5cnt,
								silverball = @silverball
							where gameid = @gameid_
						end
					else
						begin
							update dbo.tUserMaster 
								set
								actioncount	= actioncount - case when @actionfreedate >= getdate() then 0 else @GAME_MODE_BATTLE_ACTION end,
								bttotal		= bttotal + 1,
								btflag2		= case @gmode_ when @GAME_MODE_SPRINT then @GAME_STATE_PLAYING else btflag2 end
							where gameid = @gameid_
						end
					
					-- 아이템이 체킹이 되어 있으면 사용개수를 누적하자.
					if(@bttem1chk_ = 1 or @bttem2chk_ = 1 or @bttem3chk_ = 1 or @bttem4chk_ = 1 or @bttem5chk_ = 1)
						begin
							---------------------------------------------------
							-- 토탈로그 기록하기
							---------------------------------------------------
							declare @dateid varchar(8)
							set @dateid = Convert(varchar(8),Getdate(),112)		-- 20120819
							if(exists(select top 1 * from dbo.tBattleItemUseTotal where dateid = @dateid))
								begin
									update dbo.tBattleItemUseTotal 
										set 
											bttem1cnt = bttem1cnt + @bttem1chk_, 
											bttem2cnt = bttem2cnt + @bttem2chk_, 
											bttem3cnt = bttem3cnt + @bttem3chk_, 
											bttem4cnt = bttem4cnt + @bttem4chk_, 
											bttem5cnt = bttem5cnt + @bttem5chk_,
											playcnt = playcnt + 1
									where dateid = @dateid
								end
							else
								begin
									insert into dbo.tBattleItemUseTotal(dateid, bttem1cnt, bttem2cnt, bttem3cnt, bttem4cnt, bttem5cnt, playcnt) 
									values(@dateid, @bttem1chk_, @bttem2chk_, @bttem3chk_, @bttem4chk_, @bttem5chk_, 1)
								end
						end
						
					
				end
			--declare @gameid_ varchar(20) set @gameid_ = 'SangSang'
			--select 'DEBUG 후', actioncount, trainflag, machineflag, memorialflag, soulflag, bttotal, btflag, btflag2, bttem1chk, bttem2chk, bttem3chk, bttem4chk, bttem5chk, bttem1cnt, bttem2cnt, bttem3cnt, bttem4cnt, bttem5cnt, silverball from dbo.tUserMaster where gameid = @gameid_
			--if(게임스테이상태 != GAME_STATE_END)			
			--	중간에 게임을 나갔으므로 패널티 지급? > 싱글은 마땅한 것이 없음(승점을 까버린다)		

			--게임모드 플래그 GAME_STATE_END > GAME_STATE_PLAYING
			
			
			-----------------------------------------------------------------
			-- 플레이 카운드
			----------------------------------------------------------------
			if(not exists(select top 1 * from dbo.tStaticTime where dateid10 = @dateid10 and market = @market))
				begin
					insert into dbo.tStaticTime(dateid10, market, logincnt, playcnt) values(@dateid10, @market, 0, 1)
				end
			else
				begin
					update dbo.tStaticTime
						set
							playcnt = playcnt + 1
					where dateid10 = @dateid10 and market = @market 
				end
		END
	
	-- declare @gameid_ varchar(20) set @gameid_ = 'SangSang'
	select * from dbo.tUserMaster where gameid = @gameid_
	

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
	--select @nResult_ rtn
End

