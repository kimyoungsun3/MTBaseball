/* 입력값
gameid=xxx

exec spu_BTRecord 'pjstime', '37993721339797757114', -1
*/

IF OBJECT_ID ( 'dbo.spu_BTRecord', 'P' ) IS NOT NULL 
    DROP PROCEDURE dbo.spu_BTRecord;
GO 

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_BTRecord
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
	                 
			
	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @gameid 		varchar(20)
	declare @comment		varchar(512)

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR	
	
	
	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	select
		@gameid = gameid 
	from dbo.tUserMaster where gameid = @gameid_ and password = @password_
	
	------------------------------------------------
	--	3-2-3. 연산수행
	------------------------------------------------
	if(isnull(@gameid, '') = '')
		begin
			-- 아이디가 존재하지않는가??
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID	
			set @comment = 'ERROR 아이디를 찾지 못했습니다.'
			
		end
	else	
		BEGIN
			set @nResult_ = @RESULT_SUCCESS	
			set @comment = '검색했습니다.'
		end
		
	
	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	select @nResult_ rtn, @comment comment
	
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			--------------------------------------------------------------
			-- 내 -> 상대
			------------------------------------------------------------
			select u2.avatar, u2.picture, u2.ccode, u2.gameid, u2.lv, u2.grade, bt.btresult, Convert(varchar(19), writedate,120) as bttime, case when btresult = 1 then 0 else 1 end as btresult2 from 
				(select top 20 * from dbo.tBattleLog where gameid = @gameid_ order by idxOrder desc) as bt
					join
				(select gameid, avatar, picture, ccode, lv, grade from dbo.tUserMaster 
					where gameid in 
						(select top 20 btgameid from dbo.tBattleLog where gameid = @gameid_ order by idxOrder desc)) as u2
				on bt.btgameid = u2.gameid
				
			------------------------------------------------------------
			-- 내 <- 상대(대전한것들)
			------------------------------------------------------------				
			select u2.avatar, u2.picture, u2.ccode, bt.gameid, u2.lv, u2.grade, bt.btresult, Convert(varchar(19), writedate,120) as bttime, case when btresult = 1 then 0 else 1 end as btresult2 from 
				(select top 20 * from dbo.tBattleLog where btgameid = @gameid_ order by idxOrder desc) as bt
					join
				(select gameid, avatar, picture, ccode, lv, grade from dbo.tUserMaster 
					where gameid in 
						(select top 20 gameid from dbo.tBattleLog where btgameid = @gameid_ order by idxOrder desc)) as u2
				on bt.gameid = u2.gameid
		end

	set nocount off
End



