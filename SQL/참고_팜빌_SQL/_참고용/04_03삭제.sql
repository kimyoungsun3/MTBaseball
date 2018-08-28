/*
--삭제처리원복
exec spu_FVDeleteID 'xxxx0', 'a1s2d3f4', -1
exec spu_FVDeleteID 'xxxx', 'a1s2d3f4', -1
*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVDeleteID', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVDeleteID;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_FVDeleteID
	@gameid_								varchar(60),					-- 게임아이디
	@password_								varchar(20),					-- 암호화해서저장, 유저패스워가 해킹당해도 안전
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

	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------
	-- 삭제상태값.
	declare @DELETE_STATE_NO					int					set	@DELETE_STATE_NO				= 0	-- 삭제상태아님
	declare @DELETE_STATE_YES					int					set	@DELETE_STATE_YES				= 1	-- 삭제상태

	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @gameid 		varchar(60)
	declare @password 		varchar(20)
	declare @deletestate	int
	declare @comment		varchar(80)

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG 입력값', @gameid_ gameid_, @password_ password_

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	select
		@gameid 		= gameid,
		@password 		= password,
		@deletestate 	= deletestate
	from dbo.tFVUserMaster
	where gameid = @gameid_
	--select 'DEBUG 검색값', @gameid gameid, @password password, @deletestate deletestate

	if(isnull(@gameid, '') = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '아이디가 존재하지 않는다.'
		END
	else if(isnull(@password, '') = '' or @password != @password_)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_PASSWORD
			set @comment 	= '패스워드 틀렸다.'
		END
	else if(@deletestate = @DELETE_STATE_YES)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '삭제 처리했습니다.(이미했음)'
		END
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '삭제 처리했습니다.'

			-- 유저삭제기록하기
			update dbo.tFVUserMaster
				set
					deletestate = @DELETE_STATE_YES
			where gameid = @gameid_

			-- 삭제로그 기록하기
			insert into dbo.tFVUserDeleteLog(gameid, comment)
			values(@gameid_, '유저가 직접삭제했습니다.')
		END

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
	select @nResult_ rtn, @comment comment
End



