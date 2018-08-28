/*
exec spu_FVDogamList 'xxxx', '049000s1i0n7t8445289', -1
*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVDogamList', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVDogamList;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_FVDogamList
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
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함
	declare @RESULT_ERROR_NOT_FOUND_PASSWORD	int				set @RESULT_ERROR_NOT_FOUND_PASSWORD	= -17
	declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--서버를 점검하고 있다.
	declare @RESULT_NEWVERION_CLIENT_DOWNLOAD 	int				set @RESULT_NEWVERION_CLIENT_DOWNLOAD	= -15			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 링크처리.
	declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 종료.

	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------


	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @comment				varchar(512)
	declare @gameid 				varchar(60)

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG 입력정보', @gameid_ gameid_, @password_ password_

	------------------------------------------------
	--	3-2. 연산수행(유저정보)
	------------------------------------------------
	select
		@gameid 		= gameid
	from dbo.tFVUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 유저정보', @gameid gameid

	if(isnull(@gameid, '') = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '아이디가 존재하지 않는다.'
			--select 'DEBUG ', @comment
		END
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '도감 리스트.'
			--select 'DEBUG ', @comment
		END


	select @nResult_ rtn, @comment comment
	if(@nResult_ = @RESULT_SUCCESS)
		BEGIN
			--------------------------------------------------------------
			--	도감 : 획득한 동물.
			--------------------------------------------------------------
			select * from dbo.tFVDogamList where gameid = @gameid_ order by itemcode asc

			--------------------------------------------------------------
			--	도감 : 보상 받음 도감인덱스 번호.
			--------------------------------------------------------------
			select * from dbo.tFVDogamReward where gameid = @gameid_ order by dogamidx asc
		END

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
End



