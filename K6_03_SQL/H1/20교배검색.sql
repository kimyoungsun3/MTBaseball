---------------------------------------------------------------
/* 
-- 랜덤 검색, 직접 검색
select top 20 gameid, pet from dbo.tUserMaster where gameid != 'DD1' and petregister = 1 and pet != -1 order by newid()
select top 20 gameid, pet from dbo.tUserMaster where gameid != 'DD1' and gameid like 'DD%' and petregister = 1 and pet != -1 
select top 20 gameid, pet from dbo.tUserMaster where gameid != 'DD1' and gameid like 'guest%' and petregister = 1 and pet != -1 

exec spu_MPetSearch 'DD1', '', -1		-- 랜덤검색
exec spu_MPetSearch 'DD1', 'DD1',-1		-- 와일드검색
exec spu_MPetSearch 'sususu', 'sususu',-1		-- 자기검색
exec spu_MPetSearch 'guktang0530', 'guktang0530',-1		-- 자기검색
*/

IF OBJECT_ID ( 'dbo.spu_MPetSearch', 'P' ) IS NOT NULL 
    DROP PROCEDURE dbo.spu_MPetSearch;
GO 

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_MPetSearch
	@gameid_								varchar(20),		-- 게임아이디
	@mpetid_								varchar(20),
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
	declare @RESULT_ERROR_ITEM_NOSALE_KIND		int 			set @RESULT_ERROR_ITEM_NOSALE_KIND		= -37			-- 판매하지 않는 아이템.
	declare @RESULT_ERROR_ITEM_PERMANENT_ALREADY int 			set @RESULT_ERROR_ITEM_PERMANENT_ALREADY = -38			-- 영구템을 이미 구해했습니다.						
	declare @RESULT_ERROR_ITEM_NOCHANGE_KIND	int 			set @RESULT_ERROR_ITEM_NOCHANGE_KIND 	= -39			-- 자체변경불가템.
	declare @RESULT_ERROR_UPGRADE_NOBRANCH		int 			set @RESULT_ERROR_UPGRADE_NOBRANCH 		= -60			-- 비지정된 브렌치문.
	declare @RESULT_ERROR_NOT_WEAR				int 			set @RESULT_ERROR_NOT_WEAR 				= -61			-- 미장착된 상태 
	declare @RESULT_ERROR_ITEM_STRIP_CANNT_KIND	int				set @RESULT_ERROR_ITEM_STRIP_CANNT_KIND	= -62			--해제불가부위입니다.

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
	
	-- 게임중에 획득하는 레벨경험치, 등급경험치, 획득실버
	declare @GAME_SINGLE_LVEXP					int				set @GAME_SINGLE_LVEXP					= 3
	declare @GAME_BATTLE_LVEXP					int				set @GAME_BATTLE_LVEXP					= 5
	--
	declare @GAME_BATTLE_GRADEEXP				int				set @GAME_BATTLE_GRADEEXP				= 3
	declare @GAME_SINGLE_SILVERBALL_MAX			int				set @GAME_SINGLE_SILVERBALL_MAX			= 10
	declare @GAME_BATTLE_SILVERBALL_MAX			int				set @GAME_BATTLE_SILVERBALL_MAX			= 20
	
	-- 교배상태값
	declare @MATE_PET_NOT						int				set @MATE_PET_NOT						= 0
	declare @MATE_PET_CAN						int				set @MATE_PET_CAN						= 1

	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @comment		varchar(80)
	declare @mpetid			varchar(20)
	declare @petregister	int	
	declare @petmsg			varchar(40)

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	
	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	select @petregister = petregister, @petmsg = petmsg
	from dbo.tUserMaster where gameid = @gameid_
	
	-- 검색 당하는 유저 
	if(isnull(@mpetid_, '') = '')
		begin
			set @nResult_ = @RESULT_SUCCESS
			select @nResult_ rtn, '교배 검색 > 랜덤검색', isnull(@petregister, 0) petregister, isnull(@petmsg, '') petmsg
			
			select top 20 * 
			from dbo.tUserMaster 
			where gameid != @gameid_ and petregister = @MATE_PET_CAN and pet != -1 
			order by newid()
		end
	else
		begin
			set @nResult_ = @RESULT_SUCCESS
			select @nResult_ rtn, '교배 검색 > ' + @mpetid_ + '검색', isnull(@petregister, 0) petregister, isnull(@petmsg, '') petmsg
			
			set @mpetid = @mpetid_ + '%'
			
			select top 20 *
			from dbo.tUserMaster 
			where gameid != @gameid_ 
				and gameid like @mpetid 
				and petregister = @MATE_PET_CAN 
				and pet != -1 
		end

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
End

