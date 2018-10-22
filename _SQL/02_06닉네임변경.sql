/*
update dbo.tUserMaster set cashcost = 0 where gameid = 'mtxxxx3'
exec spu_CheckNickName 'mtxxxx3', '049000s1i0n7t8445289', '닉네임12', -1		-- 비용없음.

update dbo.tUserMaster set cashcost = 10000 where gameid = 'mtxxxx3'
exec spu_CheckNickName 'mtxxxx3', '049000s1i0n7t8445289', 333, 'mtnickname', -1		-- 다른 사람이 사용중...

update dbo.tUserMaster set cashcost = 10000 where gameid = 'mtxxxx3'
exec spu_CheckNickName 'mtxxxx3', '049000s1i0n7t8445289', 333, 'mt3', -1			-- 최소4자리 이하...

update dbo.tUserMaster set cashcost = 10000 where gameid = 'mtxxxx3'
exec spu_CheckNickName 'mtxxxx3', '049000s1i0n7t8445289', 333, '닉네임mt31', -1			-- 정상처리.
exec spu_CheckNickName 'mtxxxx3', '049000s1i0n7t8445289', 333, '닉네임mt32', -1			-- 정상처리.
exec spu_CheckNickName 'mtxxxx3', '049000s1i0n7t8445289', 333, '닉네임mt33', -1			-- 정상처리.

*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_CheckNickName', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_CheckNickName;
GO

create procedure dbo.spu_CheckNickName
	@gameid_				varchar(20),
	@password_				varchar(20),
	@sid_					int,
	@nickname_				varchar(40),
	@nResult_				int				OUTPUT
	--WITH ENCRYPTION -- 프로시져를 암호화함.
as
	------------------------------------------------
	--	2-1. 에러코드값
	------------------------------------------------
	-- 일반값
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함
	declare @RESULT_ERROR_CANNOT_USED_NICKNAME	int				set @RESULT_ERROR_CANNOT_USED_NICKNAME	= -141			-- 닉네임 사용불가.
	declare @RESULT_ERROR_CASHCOST_LACK			int				set @RESULT_ERROR_CASHCOST_LACK			= -22			--골드가 부족하다.
	declare @RESULT_ERROR_SESSION_ID_EXPIRE_LOGOUT	int			set @RESULT_ERROR_SESSION_ID_EXPIRE_LOGOUT	= -151		-- 세션이 만료되었습니다.

	-- 요구캐쉬.
	declare @NICKNAME_CHANGE_NEED_CASHCOST		int				set @NICKNAME_CHANGE_NEED_CASHCOST		= 1000

	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @comment		varchar(128)	set @comment 		= '알수 없는 오류가 발생했습니다.'
	declare @gameid			varchar(20)		set @gameid			= ''
	declare @sid			int				set @sid			= -1
	declare @oldnickname	varchar(20)		set @oldnickname	= ''
	declare @cashcost 		int				set @cashcost		= 0
	declare @gamecost 		int				set @gamecost		= 0
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG 1', @gameid_ gameid_, @password_ password_, @nickname_ nickname_

	------------------------------------------------
	--	3-2. 정보획득
	------------------------------------------------
	select
		@gameid 		= gameid,		@cashcost		= cashcost,	@gamecost 		= gamecost,
		@oldnickname	= nickname,
		@sid			= sid
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG ', @gameid gameid, @cashcost cashcost, @gamecost gamecost, @oldnickname oldnickname, @sid sid

	------------------------------------------------
	--	3-3. 유저생성.
	------------------------------------------------
	if(@gameid = '')
		BEGIN
			-- 아이디가 존재하지않는가??
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '아이디가 존재하지 않는다.'
			--select 'DEBUG ', @comment
		END
	else if(@sid_ != @sid)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_SESSION_ID_EXPIRE_LOGOUT
			set @comment 	= 'ERROR 세션이 만기 되었습니다. (로그아웃 시켜주세요.)'
			--select 'DEBUG ' + @comment
		END
	else if( exists( select top 1 * from dbo.tUserMaster where nickname = @nickname_ and gameid != @gameid_ ) )
		begin
			set @nResult_ 	= @RESULT_ERROR_CANNOT_USED_NICKNAME
			set @comment 	= 'ERROR 닉네임을 누가 사용하고 있습니다.'
			--select 'DEBUG 3' + @comment
		end
	else if( LEN( @nickname_ ) < 4 )
		begin
			set @nResult_ 	= @RESULT_ERROR_CANNOT_USED_NICKNAME
			set @comment 	= '최소 4자리 이상이여야 합니다.'
			--select 'DEBUG ' + @comment
		end
	else if( @cashcost < @NICKNAME_CHANGE_NEED_CASHCOST )
		begin
			set @nResult_ 	= @RESULT_ERROR_CASHCOST_LACK
			set @comment 	= '캐쉬비용(다이아)이 부족합니다.'
			--select 'DEBUG ' + @comment
		end
	else if( @nickname_ = @oldnickname )
		begin
			set @nResult_ = @RESULT_SUCCESS
			set @comment = '닉네임을 변경하였습니다.(이미변경)'
			--select 'DEBUG 4', @comment
		end
	else
		begin
			set @nResult_ = @RESULT_SUCCESS
			set @comment = '닉네임을 변경하였습니다.'
			--select 'DEBUG 4', @comment

			---------------------------------------------------
			-- 정보변경
			---------------------------------------------------
			set @cashcost = @cashcost - @NICKNAME_CHANGE_NEED_CASHCOST

			---------------------------------------------------
			-- 유저 정보 갱신
			---------------------------------------------------
			update dbo.tUserMaster
				set
					cashcost		= @cashcost,
					nickname 		= @nickname_,
					nicknamechange	= nicknamechange + 1
			where gameid = @gameid_

			---------------------------------------------------
			-- 변경기록 기록.
			---------------------------------------------------
			if(@oldnickname != '')
				begin
					--select 'DEBUG 로고 기록', @gameid_ gameid_, @oldnickname oldnickname, @nickname_ nickname_
					insert into dbo.tUserNickNameChange(gameid,   oldnickname,   newnickname)
					values(                            @gameid_, @oldnickname,  @nickname_)
				end
		end

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost

	--최종 결과를 리턴한다.
	set nocount off
End



