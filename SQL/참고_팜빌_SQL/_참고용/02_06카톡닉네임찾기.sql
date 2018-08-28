/*
exec spu_FVCheckKakaoNickName 'xxxx2', '049000s1i0n7t8445289', '닉네임2', -1
exec spu_FVCheckKakaoNickName 'xxxx2', '049000s1i0n7t8445289', '', -1
*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVCheckKakaoNickName', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVCheckKakaoNickName;
GO

create procedure dbo.spu_FVCheckKakaoNickName
	@gameid_				varchar(60),
	@password_				varchar(20),
	@kakaonickname			varchar(40),
	@nResult_				int				OUTPUT
	--WITH ENCRYPTION -- 프로시져를 암호화함.
as
	------------------------------------------------
	--	2-1. 에러코드값
	------------------------------------------------
	-- 일반값
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1
	declare @RESULT_ERROR_CANNOT_USED_NICKNAME	int				set @RESULT_ERROR_CANNOT_USED_NICKNAME	= -141			-- 닉네임 사용불가.

	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @comment		varchar(128)
	declare @gameid			varchar(60)		set @gameid			= ''
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	set @comment = '알수 없는 오류가 발생했습니다.'
	--select 'DEBUG 1', @kakaonickname kakaonickname

	------------------------------------------------
	--	3-2. 정보획득
	------------------------------------------------
	select
		@gameid = gameid
	from dbo.tFVUserMaster
	where kakaonickname = @kakaonickname and gameid != @gameid_
	--select 'DEBUG 2', @gameid gameid

	------------------------------------------------
	--	3-3. 유저생성.
	------------------------------------------------
	if (@gameid != '')
		begin
			set @nResult_ 	= @RESULT_ERROR_CANNOT_USED_NICKNAME
			set @comment 	= 'ERROR 닉네임을 누가 사용하고 있습니다.'
			--select 'DEBUG 3' + @comment
		end
	else
		begin
			set @nResult_ = @RESULT_SUCCESS
			set @comment = '닉네임을 변경하였습니다.'
			--select 'DEBUG 4', @comment

			update dbo.tFVUserMaster
				set
					kakaonickname = @kakaonickname
			where gameid = @gameid_
		end

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	select @nResult_ rtn, @comment comment

	--최종 결과를 리턴한다.
	set nocount off
End



