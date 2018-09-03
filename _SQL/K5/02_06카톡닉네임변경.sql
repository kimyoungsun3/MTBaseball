/*
select cashcost from dbo.tUserMaster where gameid = 'xxxx2'
exec spu_CheckKakaoNickName 'xxxx2', '049000s1i0n7t8445289', 1, '닉네임12', -1		-- 무료변경
select cashcost from dbo.tUserMaster where gameid = 'xxxx2'

exec spu_CheckKakaoNickName 'xxxx2', '049000s1i0n7t8445289', 2, '닉네임12', -1		-- 유료변경
select cashcost from dbo.tUserMaster where gameid = 'xxxx2'

exec spu_CheckKakaoNickName 'farm200484', '0058948l6z4g6e529442', 1, 'ffff8', -1		-- 유료변경
*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_CheckKakaoNickName', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_CheckKakaoNickName;
GO

create procedure dbo.spu_CheckKakaoNickName
	@gameid_				varchar(20),
	@password_				varchar(20),
	@mode_					int,
	@kakaonickname_			varchar(40),
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

	-- 아이템 펫 모드.
	declare @NICKNAME_CHANGE_MODE_FREE			int				set @NICKNAME_CHANGE_MODE_FREE			= 1		-- 무료변경.
	declare @NICKNAME_CHANGE_MODE_CASHCOST		int				set @NICKNAME_CHANGE_MODE_CASHCOST		= 2		-- 유료변경.

	-- 요구캐쉬.
	declare @NICKNAME_CHANGE_NEED_CASHCOST		int				set @NICKNAME_CHANGE_NEED_CASHCOST		= 1000

	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @comment		varchar(128)
	declare @gameid			varchar(20)		set @gameid			= ''
	declare @oldnickname	varchar(20)		set @oldnickname	= ''
	declare @cashcost 		int				set @cashcost		= 0
	declare @gamecost 		int				set @gamecost		= 0
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	set @comment = '알수 없는 오류가 발생했습니다.'
	--select 'DEBUG 1', @kakaonickname_ kakaonickname_

	------------------------------------------------
	--	3-2. 정보획득
	------------------------------------------------
	select
		@gameid 		= gameid,		@cashcost		= cashcost,	@gamecost 		= gamecost,
		@oldnickname	= kakaonickname
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG ', @gameid gameid, @oldnickname oldnickname

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
	else if( exists( select top 1 * from dbo.tUserMaster where kakaonickname = @kakaonickname_ and gameid != @gameid_ and deletestate = 0) )
		begin
			set @nResult_ 	= @RESULT_ERROR_CANNOT_USED_NICKNAME
			set @comment 	= 'ERROR 닉네임을 누가 사용하고 있습니다.'
			--select 'DEBUG 3' + @comment
		end
	else if( @mode_ = @NICKNAME_CHANGE_MODE_CASHCOST and @cashcost < @NICKNAME_CHANGE_NEED_CASHCOST )
		begin
			set @nResult_ 	= @RESULT_ERROR_CASHCOST_LACK
			set @comment 	= '캐쉬비용이 부족합니다.'
			--select 'DEBUG ' + @comment
		end
	else
		begin
			set @nResult_ = @RESULT_SUCCESS
			set @comment = '닉네임을 변경하였습니다.'
			--select 'DEBUG 4', @comment

			---------------------------------------------------
			-- 정보변경
			---------------------------------------------------
			if(@kakaonickname_ = '')
				begin
					--select 'DEBUG 입력안해서 아이디로대처', @gameid_ gameid_
					set @kakaonickname_ = @gameid_
				end
			if( @mode_ = @NICKNAME_CHANGE_MODE_CASHCOST )
				begin
					set @cashcost = @cashcost - @NICKNAME_CHANGE_NEED_CASHCOST
				end

			---------------------------------------------------
			-- 유저 정보 갱신
			---------------------------------------------------
			update dbo.tUserMaster
				set
					cashcost		= @cashcost,
					kakaonickname 	= @kakaonickname_,
					nicknamechange	= nicknamechange + 1
			where gameid = @gameid_

			---------------------------------------------------
			-- 변경기록 기록.
			---------------------------------------------------
			if(@oldnickname != '')
				begin
					--select 'DEBUG 로고 기록', @gameid_ gameid_, @oldnickname oldnickname, @kakaonickname_ kakaonickname_
					insert into dbo.tUserNickNameChange(gameid,   oldnickname,   newnickname)
					values(                            @gameid_, @oldnickname,  @kakaonickname_)
				end
		end

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost

	--최종 결과를 리턴한다.
	set nocount off
End



