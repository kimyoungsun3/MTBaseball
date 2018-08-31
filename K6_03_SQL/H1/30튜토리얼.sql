/*
select silverball from dbo.tUserMaster where gameid = 'SangSang'

update dbo.tUserMaster set tutorial = 0 where gameid = 'SangSang'
exec spu_Tutorial 'SangSang', -1
*/

IF OBJECT_ID ( 'dbo.spu_Tutorial', 'P' ) IS NOT NULL 
    DROP PROCEDURE dbo.spu_Tutorial;
GO 

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_Tutorial
	@gameid_								varchar(20),					-- 게임아이디
	@password_								varchar(20),
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
	
	-- 스프린트 보상
	declare @RESULT_ERROR_WIN_LACK				int				set @RESULT_ERROR_WIN_LACK				= -72
	declare @RESULT_ERROR_TUTORIAL_ALREADY		int				set @RESULT_ERROR_TUTORIAL_ALREADY		= -73			-- 투토리얼 이미 보상.

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
	declare @ITEM_KIND_CUSTOMIZE				int 			set @ITEM_KIND_CUSTOMIZE					= 22		-- 판매방식이 다름
	declare @ITEM_KIND_PET						int 			set @ITEM_KIND_PET						= 80
	declare @ITEM_KIND_BATTLEITEM				int 			set @ITEM_KIND_BATTLEITEM				= 90
	declare @ITEM_KIND_SYSTEMETC				int 			set @ITEM_KIND_SYSTEMETC				= 99
	
	-- 기타 정의값
	declare @ITEM_PERMANENT_START_DAY			datetime		set @ITEM_PERMANENT_START_DAY			= '2012-01-01'	-- 영구템시작
	declare @ITEM_PERMANENT_ADD_YEAR			int				set @ITEM_PERMANENT_ADD_YEAR			= 50			-- 영구템기간
	declare @ITEM_PERIOD_PERMANENT				int 			set @ITEM_PERIOD_PERMANENT				= -1			-- 테이블에 -1이라 기록됨
	declare @ITEM_CHAR_CUSTOMIZE_INIT			varchar(128)	set @ITEM_CHAR_CUSTOMIZE_INIT			= '1'
	declare @AVATAR_MAX							int				set @AVATAR_MAX 						= (15+1+10)		-- 0 ~ 15개.+10
	declare @SENDER								varchar(20)		set @SENDER								= '튜토리얼보상'

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

	-- 배틀템 초기값
	declare @ITEM_BATTLE_ITEMCODE_INIT			int				set @ITEM_BATTLE_ITEMCODE_INIT			= 6000
	
	-- 스프린트모드	
	declare @SPRINT_MODE_STEP01					int				set @SPRINT_MODE_STEP01				= 4
	declare @SPRINT_MODE_STEP02					int				set @SPRINT_MODE_STEP02				= 7
	declare @SPRINT_MODE_STEP03					int				set @SPRINT_MODE_STEP03				= 10
	
	declare @SPRINT_MODE_STEP01_REWARD			int				set @SPRINT_MODE_STEP01_REWARD		= 400
	declare @SPRINT_MODE_STEP02_REWARD			int				set @SPRINT_MODE_STEP02_REWARD		= 700
	declare @SPRINT_MODE_STEP03_REWARD			int				set @SPRINT_MODE_STEP03_REWARD		= 2500
	declare @SPRINT_MODE_ITEM_PERIOD2 			int				set @SPRINT_MODE_ITEM_PERIOD2		= 3	--몇일간 지급하는가?
	
	-- 투토리얼 상수값
	declare @TUTORIAL_REWARD_NOT				int				set @TUTORIAL_REWARD_NOT			= 0
	declare @TUTORIAL_REWARD_OK					int				set @TUTORIAL_REWARD_OK				= 1

	
	--가입선물
	declare @JOIN_GIFT01						int 			set @JOIN_GIFT01 					= 103
	declare @JOIN_GIFT02						int 			set @JOIN_GIFT02 					= 203
	declare @JOIN_GIFT03						int 			set @JOIN_GIFT03 					= 303
	declare @JOIN_GIFT04						int 			set @JOIN_GIFT04 					= 401
	declare @JOIN_GIFT_COMMENT					varchar(512)	set @JOIN_GIFT_COMMENT				= '튜토리얼 완료 선물로 폴리스 풀템과 스틸배트를 선물로 지급합니다.'
	declare @JOIN_GIFT_ITEM_PERIOD				int 			set @JOIN_GIFT_ITEM_PERIOD			= 7
	
	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @comment			varchar(80)	
	declare @gameid				varchar(20)
	declare @tutorial			int
	declare @plussilverball		int 			set @plussilverball		= 0
	
	
	
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR	
	set @comment = 'ERROR 알수없는 오류(-1)'


	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	--유저 정보를 읽어오기
	select @gameid 	= gameid,
			@tutorial	= tutorial
	from dbo.tUserMaster where gameid = @gameid_ and password = @password_
	--select 'DEBUG 유저정보', @gameid gameid, @tutorial tutorial
	
	
	------------------------------------------------
	-- 3-3. 각 조건별 분기
	------------------------------------------------
	if isnull(@gameid, '') = ''
		BEGIN
			--select 'DEBUG 유저가 존재하지 않습니다.'
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment = 'ERROR 유저가 존재하지 않습니다.'
		END
	else if(@tutorial = @TUTORIAL_REWARD_OK)
		BEGIN
			--select 'DEBUG 이미 지급 했습니다.'
			set @nResult_ = @RESULT_ERROR_TUTORIAL_ALREADY
			set @comment = 'SUCCESS 이미 지급 했습니다.'
		END
	else
		BEGIN
			--select 'DEBUG 투토리얼 보상' + ltrim(rtrim(@tutorial))
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 투토리얼 보상' + ltrim(rtrim(@tutorial))
			
			set @plussilverball = 500
			set @tutorial = @TUTORIAL_REWARD_OK
		END
		

	------------------------------------------------
	-- 4-1. 각 조건별 분기 > 결과출력
	------------------------------------------------
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			---------------------------------------------------------
			-- 코드출력
			---------------------------------------------------------
			select @nResult_ rtn, @comment comment, @plussilverball plussilverball
			
			
			update dbo.tUserMaster
			set
				silverball 		= silverball + @plussilverball,
				tutorial		= @tutorial
			where gameid = @gameid
			
			
			-- 초반가입템 선물로 지급
			insert into dbo.tGiftList(gameid, itemcode, giftid, period2) 
			values(@gameid_ , @JOIN_GIFT01, @SENDER, @JOIN_GIFT_ITEM_PERIOD);
			
			insert into dbo.tGiftList(gameid, itemcode, giftid, period2) 
			values(@gameid_ , @JOIN_GIFT02, @SENDER, @JOIN_GIFT_ITEM_PERIOD);
			
			insert into dbo.tGiftList(gameid, itemcode, giftid, period2) 
			values(@gameid_ , @JOIN_GIFT03, @SENDER, @JOIN_GIFT_ITEM_PERIOD);
			
			insert into dbo.tGiftList(gameid, itemcode, giftid, period2) 
			values(@gameid_ , @JOIN_GIFT04, @SENDER, @JOIN_GIFT_ITEM_PERIOD);

			insert into tMessage(gameid, comment) 
			values(@gameid_, @JOIN_GIFT_COMMENT)
			
		end
	else
		begin 
			---------------------------------------------------------
			-- 코드출력
			---------------------------------------------------------
			select @nResult_ rtn, @comment comment, @plussilverball plussilverball
		
		end

	------------------------------------------------
	--	4-2. 유저정보
	------------------------------------------------
	select * from dbo.tUserMaster where gameid = @gameid
	
	-- 선물 리스트 정보
	-- declare @gameid_ varchar(20) set @gameid_ = 'SangSang'
	select top 50 idx, itemcode, convert(varchar(16), giftdate, 20) as giftdate, giftid, period2, upgradestate2
	from dbo.tGiftList 
	where gameid = @gameid_ and gainstate = 0 
	order by idx desc
	
	
	set nocount off
End

