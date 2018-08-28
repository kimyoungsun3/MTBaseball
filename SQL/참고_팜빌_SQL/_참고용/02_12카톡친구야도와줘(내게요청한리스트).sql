/*
-- select * from dbo.tFVUserFriend where gameid = 'xxxx2'
-- select * from dbo.tFVKakaoHelpWait where gameid = 'xxxx2'
-- xxxx2 -> xxxx3, xxxx4 요청
-- exec spu_FVGiftGain 'xxxx2', '049000s1i0n7t8445289', -3, 3429809, -1, -1, -1, -1	-- 소선물받기.
-- exec spu_FVAniDie 'xxxx2', '049000s1i0n7t8445289', 1, 1, -1						-- 눌러죽음.
-- update dbo.tFVUserFriend set helpdate = getdate() - 10 where gameid in ('xxxx2', 'xxxx', 'xxxx3')
exec spu_FVKakaoFriendHelp 'xxxx2', '049000s1i0n7t8445289', 'xxxx',  0, -1
exec spu_FVKakaoFriendHelp 'xxxx2', '049000s1i0n7t8445289', 'xxxx3', 1, -1

exec spu_FVKakaoFriendHelpList 'xxxx', '049000s1i0n7t8445289', -1
*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVKakaoFriendHelpList', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVKakaoFriendHelpList;
GO

create procedure dbo.spu_FVKakaoFriendHelpList
	@gameid_				varchar(60),
	@password_				varchar(20),
	@nResult_				int				OUTPUT
	--WITH ENCRYPTION -- 프로시져를 암호화함.
as
	------------------------------------------------
	--	2-1. 에러코드값
	------------------------------------------------
	-- 일반값
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	-- 로그인 오류.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함
	declare @RESULT_ERROR_TIME_REMAIN			int				set @RESULT_ERROR_TIME_REMAIN			= -123			-- 아직 시간이 남음.

	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------


	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @comment			varchar(128)
	declare @gameid				varchar(60)		set @gameid				= ''
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	set @comment = '알수 없는 오류가 발생했습니다.'
	--select 'DEBUG 1', @gameid_ gameid_, @password_ password_

	------------------------------------------------
	--	3-2. 정보획득
	------------------------------------------------
	select
		@gameid 			= gameid
	from dbo.tFVUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 1-1 내정보', @gameid gameid

	------------------------------------------------
	--	3-3. 유저생성.
	------------------------------------------------
	if (@gameid = '')
		begin
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR 아이디가 존재하지 않는다.'
			--select 'DEBUG 2' + @comment
		end
	else
		begin
			set @nResult_ = @RESULT_SUCCESS
			set @comment = '친구에게 도와줘를 요청리스트.'
			--select 'DEBUG 3-1', @comment

			delete from dbo.tFVKakaoHelpWait
			where gameid = @gameid_ and helpdate < getdate() - 1
		end

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	select @nResult_ rtn, @comment comment

	if(@nResult_ = @RESULT_SUCCESS)
		begin
			--------------------------------------------------------------
			-- 유저 친구정보
			--------------------------------------------------------------
			select * from dbo.tFVUserMaster
			where gameid in (select top 100 friendid FROM dbo.tFVKakaoHelpWait where gameid = @gameid_)
		end


	--최종 결과를 리턴한다.
	set nocount off
End



