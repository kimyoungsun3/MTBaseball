use Game4FarmVill3
Go
/*
-- select top 10 nickname, gameid from dbo.tFVUserMaster
update dbo.tFVUserMaster set nickname = '' where gameid = 'xxxx2'
exec spu_FVNickName 'xxxx2',  '049000s1i0n7t8445289', '테스인원', -1
exec spu_FVNickName 'xxxx2',  '049000s1i0n7t8445289', 'nn', -1
exec spu_FVNickName 'xxxx2',  '049000s1i0n7t8445289', '리븐장인', -1
select nickname from dbo.tFVUserMaster where gameid = 'xxxx2'
select * from dbo.tFVUserNickNameChange where gameid = 'xxxx2' order by idx desc

*/

IF OBJECT_ID ( 'dbo.spu_FVNickName', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVNickName;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_FVNickName
	@gameid_								varchar(60),				-- 게임아이디
	@password_								varchar(20),
	@nickname_								varchar(20),
	@nResult_								int					OUTPUT
	--WITH ENCRYPTION -- 프로시져를 암호화함.
as
	------------------------------------------------
	--	2-1. 코드값자리
	------------------------------------------------
	-- 일반값
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함
	declare @RESULT_ERROR_CANNOT_USED_NICKNAME	int				set @RESULT_ERROR_CANNOT_USED_NICKNAME	= -141			-- 닉네임 사용불가.

	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @comment				varchar(512)			set @comment		= ''
	declare @gameid 				varchar(60)				set @gameid			= ''
	declare @oldnickname			varchar(20)				set @oldnickname	= ''

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG 입력정보', @gameid_ gameid_, @password_ password_, @nickname_ nickname_

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	select
		@gameid 	= gameid,
		@oldnickname= nickname
	from dbo.tFVUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 유저정보', @gameid gameid

	if(@gameid = '')
		BEGIN
			-- 아이디가 존재하지않는가??
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '아이디가 존재하지 않는다.'
			--select 'DEBUG ', @comment
		END
	else if exists (select * from tFVUserMaster where gameid != @gameid_ and nickname = @nickname_)
		BEGIN
			-- 아이디가 존재하지않는가??
			set @nResult_ 	= @RESULT_ERROR_CANNOT_USED_NICKNAME
			set @comment 	= '닉네임을 사용할 수 없습니다(중복).'
			--select 'DEBUG ', @comment
		END
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '닉네임 변경했습니다.'
			--select 'DEBUG ', @comment
			if(@nickname_ = '')
				begin
					set @nickname_ = @gameid_
				end

			---------------------------------------------------
			-- 유저 정보 갱신
			---------------------------------------------------
			update dbo.tFVUserMaster
				set
					nickname 	= @nickname_
			from dbo.tFVUserMaster
			where gameid = @gameid_


			---------------------------------------------------
			-- 변경기록 기록.
			---------------------------------------------------
			if(@oldnickname != '')
				begin
					insert into dbo.tFVUserNickNameChange(gameid,   oldnickname, newnickname)
					values(                              @gameid_, @oldnickname,  @nickname_)
				end

		END

	-----------------------------------------------
	-- 결과코드처리.
	-----------------------------------------------
	select @nResult_ rtn, @comment comment

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
End



