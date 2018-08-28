/*

exec spu_FVChangePW 'xxxx0',   '049000s1i0n7t8445289', '01011112221', -1
exec spu_FVChangePW 'xxxx',   '049000s1i0n7t8445289', '01011112227', -1
exec spu_FVChangePW 'xxxx',   '049000s1i0n7t8445289', '01011112221', -1
*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVChangePW', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVChangePW;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_FVChangePW
	@gameid_								varchar(60),
	@passwordnew_							varchar(20),
	@phone_									varchar(20),
	@nResult_								int					OUTPUT
	--WITH ENCRYPTION
as
	------------------------------------------------
	--	2-1. 코드값자리
	------------------------------------------------
	-- 일반값
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	--가입 오류.
	declare @RESULT_ERROR_ID_DUPLICATE			int				set @RESULT_ERROR_ID_DUPLICATE			= -2

	-- 로그인 오류.
	declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--블럭유저 > 팝업처리후 인트로로 빼버린다.
	declare @RESULT_ERROR_DELETED_USER 			int				set @RESULT_ERROR_DELETED_USER			= -12			--삭제유저 > 팝업처리후 인트로로 빼버린다.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함
	declare @RESULT_ERROR_NOT_FOUND_PASSWORD	int				set @RESULT_ERROR_NOT_FOUND_PASSWORD	= -17
	declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--서버를 점검하고 있다.
	declare @RESULT_NEWVERION_CLIENT_DOWNLOAD 	int				set @RESULT_NEWVERION_CLIENT_DOWNLOAD	= -15			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 링크처리.
	declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 종료.
	declare @RESULT_ERROR_NOT_FOUND_PHONE 		int				set @RESULT_ERROR_NOT_FOUND_PHONE		= -76			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 종료.


	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------

	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @gameid				varchar(60)
	declare @phone				varchar(20)
	declare @comment			varchar(80)


Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	set @comment = 'ERROR 알수없는 오류(-1)'
	--select 'DEBUG ', @gameid_ gameid_, @passwordnew_ passwordnew_, @phone_ phone_

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	select
		@gameid = gameid, @phone = phone
	from dbo.tFVUserMaster
	where gameid = @gameid_

	if(isnull(@gameid, '') = '')
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment = '아이디가 존재하지 않는다.'
		END
	else if(@phone != @phone_)
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_PHONE
			set @comment = '폰번호가 매칭이 안됩니다.'
		END
	else if(@gameid = @gameid_ and @phone = @phone_)
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = '패스워드를 새로 발급했습니다.'
			------------------------------------------------------------------
			-- 유저 패스워드 갱신
			------------------------------------------------------------------
			update dbo.tFVUserMaster
			set
				password		= @passwordNew_
			where gameid 		= @gameid_
		end

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	select @nResult_ rtn, @comment comment

	set nocount off
End



