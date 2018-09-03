/*
gameid=xxx
serialkey=xxx(날자+폰 > 캐쉬코드)
exec spu_GenReward 'Superman7', '7575970askeie1595313', 'xxxxxxxxxxx01', 1, -1
exec spu_GenReward 'Superman7', '7575970askeie1595312', 'xxxxxxxxxxx02', 2, -1

exec spu_GenReward 'Superman7', '7575970askeie1595312', 'xxxxxxxxxxx01', 1, -1
exec spu_GenReward 'Superman7', '7575970askeie1595312', 'xxxxxxxxxxx02', 1, -1
exec spu_GenReward 'Superman7', '7575970askeie1595312', 'xxxxxxxxxxx03', 1, -1
exec spu_GenReward 'Superman7', '7575970askeie1595312', 'xxxxxxxxxxx04', 1, -1

*/ 

IF OBJECT_ID ( 'dbo.spu_GenReward', 'P' ) IS NOT NULL 
    DROP PROCEDURE dbo.spu_GenReward;
GO 

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_GenReward
	@gameid_								varchar(20),					-- 게임아이디
	@password_								varchar(20),
	@serialkey_								varchar(256),
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
	declare @RESULT_ERROR_WIN_LACK				int				set @RESULT_ERROR_WIN_LACK				= -72			-- 스프린트 보상.
	declare @RESULT_ERROR_TUTORIAL_ALREADY		int				set @RESULT_ERROR_TUTORIAL_ALREADY		= -73			-- 투토리얼 이미 보상.
	declare @RESULT_ERROR_FRIEND_ADD_MYGAMEID	int				set @RESULT_ERROR_FRIEND_ADD_MYGAMEID	= -74	
	declare @RESULT_ERROR_NOT_FOUND_GIFTID		int				set @RESULT_ERROR_NOT_FOUND_GIFTID		= -75			-- 캐쉬 > 선물할 아이디를 못찾음
	
	declare @RESULT_ERROR_SMS_NOT_MATCH_PHONE	int				set @RESULT_ERROR_SMS_NOT_MATCH_PHONE	= -80			--문자추천. 
	declare @RESULT_ERROR_SMS_KEY_DUPLICATE		int				set @RESULT_ERROR_SMS_KEY_DUPLICATE		= -81
	declare @RESULT_ERROR_SMS_LACK				int				set @RESULT_ERROR_SMS_LACK				= -82
	declare @RESULT_ERROR_SMS_REJECT			int				set @RESULT_ERROR_SMS_REJECT			= -84
	declare @RESULT_ERROR_SMS_DOUBLE_PHONE		int				set @RESULT_ERROR_SMS_DOUBLE_PHONE		= -85
	declare @RESULT_ERROR_KEY_DUPLICATE			int				set @RESULT_ERROR_KEY_DUPLICATE			= -86			-- 일반 키가 중복되었다.
	
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

	--일반보상
	declare @REWARD_MODE_CLOVER					int				set @REWARD_MODE_CLOVER					= 1
	
	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @comment2		varchar(1024)	
	declare @comment		varchar(80)
	declare @gameid			varchar(20)
	declare @dateid 		varchar(8)				set @dateid 		= Convert(varchar(8),Getdate(),112)		-- 20120819
	declare @coin			int						set @coin			= 0
	declare @silverball		int						set @silverball		= 0
	declare @goldball		int						set @goldball		= 0
	

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	select 	
		@gameid		= gameid,
		@coin		= coin,
		@silverball = silverball, 
		@goldball 	= goldball
	from dbo.tUserMaster where gameid = @gameid_ and password = @password_
	--select 'DEBUG 1-1', @gameid gameid, @coin coin, @silverball silverball, @goldball goldball
				
	------------------------------------------------
	--	3-2-3. 연산수행
	------------------------------------------------
	if(isnull(@gameid, '') = '')
		begin			
			-- 아이디가 존재하지않는가??
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID	
			set @comment = 'ERROR 아이디를 찾지 못했습니다.'
			--select 'DEBUG 2-1' + @comment
		end
	else if(@mode_ not in (@REWARD_MODE_CLOVER))
		begin
			set @nResult_ = @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment = 'ERROR 지원하지 않는 모드입니다.'
			--select 'DEBUG 3-1' + @comment
		end
	else if(exists(select top 1 * from dbo.tUserRewardLog where serialkey = @serialkey_))
		begin
			set @nResult_ = @RESULT_ERROR_KEY_DUPLICATE
			set @comment = 'ERROR 시리얼키가 중복된다.'
			--select 'DEBUG 4-1' + @comment
			
			---------------------------------------------------
			--	카피플래그 기록, 로그 기록
			---------------------------------------------------
			update dbo.tUserMaster 
				set 
					resultcopy 		= resultcopy + 1
			where gameid = @gameid_

			-- 아이템3회 카피에 대한 블럭처리
			insert into dbo.tUserUnusualLog(gameid, comment) values(@gameid_, '보상지급에서 ' + @comment)
		end
	else 
		begin
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 정상처리하다.'
			----select 'DEBUG 5-1' + @comment
			
			------------------------------------------------------------------
			-- 유저 정보를 업데이트하기
			------------------------------------------------------------------
			if(@mode_ = @REWARD_MODE_CLOVER)
				begin
					set @coin = @coin + 10
					set @comment2 = '뽑기코인 지급 10개'
					
					update dbo.tUserMaster 
					set
						coin = @coin
					where gameid = @gameid_
				end
			
			---------------------------------------------------
			-- 로그 기록하기
			---------------------------------------------------
			insert into dbo.tUserRewardLog(gameid, serialkey, mode, comment) 
			values(@gameid_, @serialkey_, @mode_, @comment2)
			
			---------------------------------------------------
			-- 토탈 기록하기
			---------------------------------------------------
			if(exists(select top 1 * from dbo.tUserRewardLogTotal where dateid = @dateid and mode = @mode_))
				begin
					update dbo.tUserRewardLogTotal 
						set
							cnt = cnt + 1
					where dateid = @dateid and mode = @mode_
				end
			else
				begin
					insert into dbo.tUserRewardLogTotal(dateid, mode, cnt) 
					values(@dateid, @mode_, 1)
				end 

		end



	------------------------------------------------
	--	4-2. 유저정보
	------------------------------------------------
	select @nResult_ rtn, @comment comment, @silverball silverball, @goldball goldball, @coin coin
	
	set nocount off
End

