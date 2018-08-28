/*
update dbo.tFVUserMaster set fpoint = 1000, fmonth = 0 where gameid = 'xxxx2'
exec spu_FVCallFriendPoint 'xxxx2', '049000s1i0n7t8445289', -1


update dbo.tFVUserMaster set fpoint = 0 where gameid = 'xxxx2'
exec spu_FVCallFriendPoint 'xxxx2', '049000s1i0n7t8445289', -1
*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVCallFriendPoint', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVCallFriendPoint;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_FVCallFriendPoint
	@gameid_								varchar(60),
	@password_								varchar(20),
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
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함.
	declare @RESULT_ERROR_NOT_FOUND_PASSWORD	int				set @RESULT_ERROR_NOT_FOUND_PASSWORD	= -17
	declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--서버를 점검하고 있다.
	declare @RESULT_NEWVERION_CLIENT_DOWNLOAD 	int				set @RESULT_NEWVERION_CLIENT_DOWNLOAD	= -15			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 링크처리.
	declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 종료.

	-- 게임중에 부족.
	declare @RESULT_ERROR_FPOINT_LACK			int				set @RESULT_ERROR_FPOINT_LACK			= -124			--

	-- 친구포인트 차감.
	declare @USED_FRIEND_POINT					int				set @USED_FRIEND_POINT					= 50

	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------

	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @comment			varchar(80)

	declare @gameid 			varchar(60)		set @gameid 		= ''
	declare @market				int
	declare @cashcost			int				set @cashcost		= 0
	declare @gamecost			int				set @gamecost		= 0
	declare @heart				int				set @heart			= 0
	declare @feed				int				set @feed			= 0
	declare @fpoint				int				set @fpoint			= 0
	declare @gamemonth			int				set @gamemonth		= 1
	declare @fmonth				int				set @fmonth			= 2

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
	-- 유저 보유캐쉬
	select
		@gameid 		= gameid,
		@market			= market,
		@cashcost		= cashcost,
		@gamecost		= gamecost,
		@heart			= heart,
		@feed			= feed,
		@fpoint 		= fpoint,
		@gamemonth		= gamemonth,
		@fmonth			= fmonth
	from dbo.tFVUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 유저정보', @gameid gameid, @fpoint fpoint

	------------------------------------------------
	--	3-3. 연산수행
	------------------------------------------------
	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '아이디가 존재하지 않는다.'
			--select 'DEBUG ' + @comment
		END
	else if(@fpoint < @USED_FRIEND_POINT)
		BEGIN
			set @nResult_ = @RESULT_ERROR_FPOINT_LACK
			set @comment = 'ERROR 친구포인트가 부족합니다.'
			--select 'DEBUG ' + @comment
		END
	--else if(@fmonth = @gamemonth)
	--	BEGIN
	--		set @nResult_ = @RESULT_SUCCESS
	--		set @comment = 'SUCCESS 친구일꾼을 호출하였습니다.(중복호출)'
	--	END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 친구일꾼을 호출하였습니다.'

			-- 포인트차감.
			set @fpoint = @fpoint - @USED_FRIEND_POINT
			set @fmonth = @gamemonth

			-- 사용로그 기록.
			exec spu_FVDayLogInfoStatic @market, 26, 1				-- 일 fpoint(무료)
		END


	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost, @heart heart, @feed feed, @fpoint fpoint
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			-----------------------------------
			-- 유저 정보 반영.
			-----------------------------------
			update dbo.tFVUserMaster
				set
					fpoint	= @fpoint,
					fmonth	= @fmonth
			where gameid = @gameid_
		end

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
End



