/*
select * from dbo.tFVSysInquire order by idx desc
exec spu_FVSysInquire 'xxxx2', '049000s1i0n7t8445289', '[과금문의]문의합니다..', -1
*/
use Game4FarmVill4
GO

IF OBJECT_ID ( 'dbo.spu_FVSysInquire', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVSysInquire;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_FVSysInquire
	@gameid_								varchar(60),					-- 게임아이디
	@password_								varchar(20),
	@message_								varchar(1024),
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
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함

	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @comment		varchar(128)
	declare @gameid			varchar(60)				set @gameid			= ''
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG 입력정보', @gameid_ gameid_, @message_ message_

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	select
		@gameid 		= gameid
	from dbo.tFVUserMaster
	where gameid = @gameid_
	--select 'DEBUG 유저정보', @gameid gameid

	------------------------------------------------
	-- 3-3. 각 조건별 분기
	------------------------------------------------
	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR 아이디가 존재하지 않는다.'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'SUCCESS 글쓰기 성공.'
			--select 'DEBUG ' + @comment

			-- 입력
			insert into dbo.tFVSysInquire(gameid,   comment)
			values(                      @gameid_, @message_)
		END


	--------------------------------------------------------------
	-- 결과전송.
	--------------------------------------------------------------
	select @nResult_ rtn, @comment comment

	------------------------------------------------
	--	4-2. 유저정보
	------------------------------------------------
	set nocount off
End

