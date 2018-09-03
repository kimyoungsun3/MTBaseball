---------------------------------------------------------------
/* 
[개인정보변경 > 국가코드변경]
gameid=xxx
changemode=1
ccode=1
exec spu_ChangeInfo 'SangSang', '7575970askeie1595312', 1, 1, -1, '-1', -1					-- [개인정보변경 > 국가코드변경]
exec spu_ChangeInfo 'SangSang', '7575970askeie1595312', 1, 2, -1, '-1', -1					-- [개인정보변경 > 국가코드변경]
exec spu_ChangeInfo 'SangSang', '7575970askeie1595312', 1, 3, -1, '-1', -1					-- [개인정보변경 > 국가코드변경]
exec spu_ChangeInfo 'SangSang', '7575970askeie1595312', 1, 4, -1, '-1', -1					-- [개인정보변경 > 국가코드변경]

[개인정보변경 > 아바타변경]
gameid=xxx
changemode=2
avatar=1
exec spu_ChangeInfo 'SangSang', '7575970askeie1595312', 2, -1, 2, '-1', -1					-- [개인정보변경 > 아바타변경]

[개인정보변경 > 사진변경]
gameid=xxx
changemode=3
picture=xzqxwcevreasdfeas
exec spu_ChangeInfo 'SangSang', '7575970askeie1595312', 3, -1, -1, 'xzqxwcevreasdfeas', -1	-- [개인정보변경 > 사진변경]
exec spu_ChangeInfo 'SangSang', '7575970askeie1595312', 3, -1, -1, '-1', -1, -1					

declare @gameid varchar(20)		set @gameid = 'SangSang'
select * from dbo.tUserMaster where gameid = @gameid
select avatar, ccode from dbo.tUserMaster where gameid = @gameid

-- 게임을 시작하고 들어왔다는 플래그
declare @gameid varchar(20)		set @gameid = 'SangSang'
update dbo.tUserMaster set avatar = 1, ccode = 1 where gameid = @gameid
select avatar, ccode from dbo.tUserMaster where gameid = @gameid

[개인정보변경 > 실버지급]
select * from dbo.tUserMaster where gameid = 'superman2'
exec spu_ChangeInfo 'superman', '7575970askeie1595312', 4, -1, -1, '-1', -1					-- [실버지급]
*/

IF OBJECT_ID ( 'dbo.spu_ChangeInfo', 'P' ) IS NOT NULL 
    DROP PROCEDURE dbo.spu_ChangeInfo;
GO 

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_ChangeInfo
	@gameid_								varchar(20),				-- 게임아이디
	@password_								varchar(20),				-- 암호화해서저장, 유저패스워가 해킹당해도 안전
	@changemode_							int,
	@ccode_									int,						-- mode 1
	@avatar_								int,						-- mode 2
	@picture_								varchar(60),				-- mode 3
	@nResult_								int					OUTPUT
	WITH ENCRYPTION -- 프로시져를 암호화함.
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
	
	-- 기타오류
	declare @RESULT_ERROR_RESULT_COPY			int				set @RESULT_ERROR_RESULT_COPY			= -53			-- 결과카피시도
	declare @RESULT_ERROR_SILVER_COPY			int				set @RESULT_ERROR_SILVER_COPY			= -54			-- 실버카피시도
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- 지원하지않는모드
	declare @RESULT_ERROR_ACTION_FULL			int				set @RESULT_ERROR_ACTION_FULL			= -71			-- 지원하지않는모드
	declare @RESULT_ERROR_WIN_LACK				int				set @RESULT_ERROR_WIN_LACK				= -72			-- 스프린트 보상.
	declare @RESULT_ERROR_TUTORIAL_ALREADY		int				set @RESULT_ERROR_TUTORIAL_ALREADY		= -73			-- 투토리얼 이미 보상.
	declare @RESULT_ERROR_FRIEND_ADD_MYGAMEID	int				set @RESULT_ERROR_FRIEND_ADD_MYGAMEID	= -74	
	declare @RESULT_ERROR_NOT_FOUND_GIFTID		int				set @RESULT_ERROR_NOT_FOUND_GIFTID		= -75			-- 캐쉬 > 선물할 아이디를 못찾음
	
	-- 게임중에 부족.
	declare @RESULT_ERROR_ACTION_LACK			int				set @RESULT_ERROR_ACTION_LACK			= -20			--행동력이 부족하다.
	declare @RESULT_ERROR_SILVERBALL_LACK		int				set @RESULT_ERROR_SILVERBALL_LACK		= -21			--실버가 부족하다.
	declare @RESULT_ERROR_GOLDBALL_LACK			int				set @RESULT_ERROR_GOLDBALL_LACK			= -22			--골드가 부족하다.
	declare @RESULT_ERROR_ITEM_LACK				int				set @RESULT_ERROR_ITEM_LACK				= -23			--아이템이부족하다.
	declare @RESULT_ERROR_COIN_LACK				int				set @RESULT_ERROR_COIN_LACK				= -24			--코인잉 부족하다.
	
	--각모드
	declare @CHANGE_MODE_COUNTYR				int				set @CHANGE_MODE_COUNTYR				= 1
	declare @CHANGE_MODE_AVATAR					int				set @CHANGE_MODE_AVATAR					= 2
	declare @CHANGE_MODE_PICTURE				int				set @CHANGE_MODE_PICTURE				= 3
	declare @CHANGE_MODE_MARKET_BOARD_WRITE		int				set @CHANGE_MODE_MARKET_BOARD_WRITE		= 4
	
	-- 지급여부
	declare @MARKET_BOARD_NOT_WRITE				int				set @MARKET_BOARD_NOT_WRITE				= 0
	declare @MARKET_BOARD_WRITEED				int				set @MARKET_BOARD_WRITEED				= 1
	-- 지급액수
	declare @MARKET_BOARD_WRITEED_REWARD_SB		int 			set @MARKET_BOARD_WRITEED_REWARD_SB		= 2000				-- 5골드코인을 지급하였습니다.
	
	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @actioncount	int
	declare	@actionmax		int
	declare @actiontime		datetime
	declare @ccodeOriginal	int
	
	declare @comment		varchar(512)	
	declare @gameid			varchar(20)
	declare @mboardstate	int
	declare @plussb			int				set @plussb 		= 0

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR	
	set @comment = 'ERROR 알수 없는 오류가 발생하였습니다.'
	
	------------------------------------------------
	--	3-1. 유저정보 갱신
	------------------------------------------------
	select 
		@gameid = gameid,
		@mboardstate = mboardstate
	from dbo.tUserMaster 
	where gameid = @gameid_ and password = @password_
	
	
	-----------------------------------------------
	--	3-2. 각계산하기
	-----------------------------------------------
	if(isnull(@gameid, '') = '')
		begin
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment = 'ERROR 아이디를 찾지 못했습니다.'
		END
	else if(@changemode_ not in (@CHANGE_MODE_COUNTYR, @CHANGE_MODE_AVATAR, @CHANGE_MODE_PICTURE, @CHANGE_MODE_MARKET_BOARD_WRITE))
		begin
			set @nResult_ = @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment = 'ERROR 지원하지 않는 모드입니다.'
		end
	else if(@changemode_ = @CHANGE_MODE_COUNTYR)		
		BEGIN	
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 국가코드변경'
			if(@ccode_ < 2 or @ccode_ > 10)
				begin
					set @ccode_ = 2
				end
			
			select @ccodeOriginal = ccode from dbo.tUserMaster where gameid = @gameid_
			
			--select ' DEBUG 국가변경(전)', ccode from dbo.tUserMaster where gameid = @gameid_
			update dbo.tUserMaster 
				set ccode = @ccode_
			where gameid = @gameid_
			--select ' DEBUG 국가변경(후)', ccode from dbo.tUserMaster where gameid = @gameid_
			
			-- 변경후 > +1
			update dbo.tBattleCountryClub set cnt = cnt + 1 where ccode = @ccode_
			
			-- 변경전 > -1
			update dbo.tBattleCountryClub set cnt = cnt - 1 where ccode = @ccodeOriginal
		END
	else if(@changemode_ = @CHANGE_MODE_AVATAR)		
		BEGIN	
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 아바타코드변경'
			
			--select ' DEBUG 아바타코드변경(전)', avatar from dbo.tUserMaster where gameid = @gameid_
			update dbo.tUserMaster 
				set avatar = @avatar_
			where gameid = @gameid_
			--select ' DEBUG 아바타코드변경(후)', avatar from dbo.tUserMaster where gameid = @gameid_
		END
	else if(@changemode_ = @CHANGE_MODE_PICTURE)		
		BEGIN	
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 사진변경'
			
			--select ' DEBUG 사진변경(전)', picture from dbo.tUserMaster where gameid = @gameid_
			update dbo.tUserMaster 
				set picture = @picture_
			where gameid = @gameid_
			--select ' DEBUG 사진변경(후)', picture from dbo.tUserMaster where gameid = @gameid_
		END		
	else if(@changemode_ = @CHANGE_MODE_MARKET_BOARD_WRITE)		
		BEGIN	
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 통신사별 추천글 작성하기'
			
			--select 'DEBUG (전)', gameid, mboardstate, goldball from dbo.tUserMaster where gameid = @gameid_
			if(isnull(@gameid, '') != '' and @mboardstate = @MARKET_BOARD_NOT_WRITE)
				BEGIN
					--select 'DEBUG 실버볼지급, 체킹변경'
					update dbo.tUserMaster 
						set
							silverball = silverball + @MARKET_BOARD_WRITEED_REWARD_SB,
							mboardstate = @MARKET_BOARD_WRITEED
					where gameid = @gameid_
					
					set @plussb = @MARKET_BOARD_WRITEED_REWARD_SB
				END	
			--select 'DEBUG (후)', gameid, mboardstate, goldball from dbo.tUserMaster where gameid = @gameid_
			
			--select ' DEBUG 아바타코드변경(후)', avatar from dbo.tUserMaster where gameid = @gameid_
		END
	else
		BEGIN	
			set @nResult_ = @RESULT_ERROR
			set @comment = 'ERROR 코드가 불명확하다.'
			
		END
	
	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	select @nResult_ rtn, @comment comment, @plussb plussb, @changemode_ changemode
	
	select * from dbo.tUserMaster where gameid = @gameid_
	
	set nocount off
	
End

