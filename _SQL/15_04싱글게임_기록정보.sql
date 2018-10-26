/*
exec spu_GameRecord 'mtxxxx3', '049000s1i0n7t8445289', 333, -1
*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_GameRecord', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_GameRecord;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_GameRecord
	@gameid_								varchar(20),					-- 게임아이디
	@password_								varchar(20),
	@sid_									int,
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
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함
	declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--서버를 점검하고 있다.

	-- 기타오류
	declare @RESULT_ERROR_SESSION_ID_EXPIRE_LOGOUT	int			set @RESULT_ERROR_SESSION_ID_EXPIRE_LOGOUT	= -151		-- 세션이 만료되었습니다.

	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------
	-- MT 블럭상태값.
	declare @BLOCK_STATE_NO						int					set	@BLOCK_STATE_NO							= 0	-- 블럭상태아님
	declare @BLOCK_STATE_YES					int					set	@BLOCK_STATE_YES						= 1	-- 블럭상태

	-- MT 게임모드.
	declare @GAME_MODE_PRACTICE					int					set @GAME_MODE_PRACTICE						= 0
	declare @GAME_MODE_SINGLE					int					set @GAME_MODE_SINGLE						= 1
	declare @GAME_MODE_MULTI					int					set @GAME_MODE_MULTI						= 2

	-- 배팅상태.
	declare @GAME_STATE_ING						int					set @GAME_STATE_ING					= -1	-- 게임진행중.
	declare @GAME_STATE_ROLLBACK				int					set @GAME_STATE_ROLLBACK			= -2	-- 롤백예정임.
	declare @GAME_STATE_SUCCESS					int					set @GAME_STATE_SUCCESS				= 0		-- 정상처리.
	--declare @GAME_STATE_FAIL_LOGIN_MOLSU		int					set @GAME_STATE_FAIL_LOGIN_MOLSU	= 10	-- 재로그인으로 몰수.
	--declare @GAME_STATE_FAIL_LOGIN_ROLLBACK	int					set @GAME_STATE_FAIL_LOGIN_ROLLBACK	= 11	-- 재로그인으로 롤백
	--declare @GAME_STATE_FAIL_ADMIN_DEL		int					set @GAME_STATE_FAIL_ADMIN_DEL		= 12	-- 관리자가 삭제함.
	--declare @GAME_STATE_FAIL_ADMIN_ROLLBACK	int					set @GAME_STATE_FAIL_ADMIN_ROLLBACK	= 13	-- 관리자가 롤백처리.

	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @comment				varchar(512)		set @comment			= ''
	declare @gameid					varchar(20)			set @gameid				= ''
	declare @cashcost				int					set @cashcost			= 0
	declare @gamecost				int					set @gamecost			= 0
	declare @sid					int					set @sid				= -1
	declare @blockstate				int					set @blockstate			= @BLOCK_STATE_YES

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG 1 입력정보', @gameid_ gameid_, @password_ password_, @sid_ sid_

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	select
		@gameid 	= gameid,		@blockstate		= blockstate,
		@cashcost	= cashcost,		@gamecost		= gamecost,
		@sid		= sid
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 3-2 유저정보', @gameid gameid, @blockstate blockstate, @sid sid, @cashcost cashcost, @gamecost gamecost

	------------------------------------------------
	-- 3-3. 각 조건별 분기
	------------------------------------------------
	if( @gameid = '' )
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR 아이디가 존재하지 않는다.'
			--select 'DEBUG ' + @comment
		END
	else if (@blockstate = @BLOCK_STATE_YES)
		BEGIN
			-- 블럭유저인가?
			set @nResult_ 	= @RESULT_ERROR_BLOCK_USER
			set @comment 	= '블럭처리된 아이디입니다.'
			--select 'DEBUG ', @comment
		END
	else if(@sid_ != @sid)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_SESSION_ID_EXPIRE_LOGOUT
			set @comment 	= 'ERROR 세션이 만기 되었습니다. (로그아웃 시켜주세요.)'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 성공입니다.'
			--select 'DEBUG ' + @comment

		END


	--------------------------------------------------------------
	-- 결과전송.
	--------------------------------------------------------------
	select @nResult_ rtn, @comment comment,	@cashcost cashcost, @gamecost gamecost


	if(@nResult_ = @RESULT_SUCCESS)
		BEGIN
			select top 15 * from
				(select
					top 15
					idx, curturntime, curturndate, gamemode, select1, select2, select3, select4, rselect1, rselect2, rselect3, rselect4, gameresult
				from dbo.tSingleGameLog
				where gameid = @gameid_ and gamestate = @GAME_STATE_SUCCESS
			union all
				select
					top 15
					idx, curturntime, curturndate, gamemode, select1, select2, select3, select4, rselect1, rselect2, rselect3, rselect4, gameresult
				from dbo.tPracticeGameLog
				where gameid = @gameid_) as A
			order by curturntime desc
		END

	------------------------------------------------
	--	4-2. 유저정보
	------------------------------------------------
	set nocount off
End

