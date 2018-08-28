/*
update dbo.tUserMaster set tutorial = 0 where gameid = 'xxxx2'
delete from dbo.tGiftList where  gameid = 'xxxx2'
select tutorial, * from dbo.tUserMaster where gameid = 'xxxx2'
exec spu_Tutorial 'xxxx2', '049000s1i0n7t8445289', 1, -1		-- 정독.
exec spu_Tutorial 'xxxx2', '049000s1i0n7t8445289', 2, -1		-- 재튜토리얼.
exec spu_Tutorial 'xxxx2', '049000s1i0n7t8445289', 3, -1		-- Skip.

-- 정독 		-> 재튜토리얼.
update dbo.tUserMaster set tutorial = 0 where gameid = 'xxxx2'
delete from dbo.tGiftList where  gameid = 'xxxx2'
select tutorial, * from dbo.tUserMaster where gameid = 'xxxx2'
exec spu_Tutorial 'xxxx2', '049000s1i0n7t8445289', 1, -1		-- 정독.
exec spu_Tutorial 'xxxx2', '049000s1i0n7t8445289', 2, -1		-- 재튜토리얼.

-- 재튜토리얼	-> 재튜토리얼.
update dbo.tUserMaster set tutorial = 0 where gameid = 'xxxx2'
delete from dbo.tGiftList where  gameid = 'xxxx2'
select tutorial, * from dbo.tUserMaster where gameid = 'xxxx2'
exec spu_Tutorial 'xxxx2', '049000s1i0n7t8445289', 2, -1		-- 재튜토리얼.
exec spu_Tutorial 'xxxx2', '049000s1i0n7t8445289', 2, -1		-- 재튜토리얼.

-- Skip.		-> 재튜토리얼.
update dbo.tUserMaster set tutorial = 0 where gameid = 'xxxx2'
delete from dbo.tGiftList where  gameid = 'xxxx2'
select tutorial, * from dbo.tUserMaster where gameid = 'xxxx2'
exec spu_Tutorial 'xxxx2', '049000s1i0n7t8445289', 3, -1		-- Skip.
exec spu_Tutorial 'xxxx2', '049000s1i0n7t8445289', 2, -1		-- 재튜토리얼.


*/
use Game4Farmvill5
GO

IF OBJECT_ID ( 'dbo.spu_Tutorial', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_Tutorial;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_Tutorial
	@gameid_								varchar(20),
	@password_								varchar(20),
	@mode_									int,
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

	-- 기타오류
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- 지원하지않는모드

	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------
	declare @MODE_TUTORIAL_NON					int				set @MODE_TUTORIAL_NON					= 0
	declare @MODE_TUTORIAL_OK					int				set @MODE_TUTORIAL_OK					= 1
	declare @MODE_TUTORIAL_RETRY				int				set @MODE_TUTORIAL_RETRY				= 2
	declare @MODE_TUTORIAL_SKIP					int				set @MODE_TUTORIAL_SKIP					= 3


	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @gameid 				varchar(20)			set @gameid				= ''
	declare @cashcost				int					set @cashcost			= 0
	declare @gamecost				int					set @gamecost			= 0
	declare @feed					int					set @feed				= 0
	declare @heart					int					set @heart				= 0
	declare @tutorial				int					set @tutorial			= 0

	declare @comment				varchar(512)

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG 입력정보', @gameid_ gameid_, @password_ password_, @tutorial_ tutorial_

	------------------------------------------------
	--	3-2. 연산수행(유저정보)
	------------------------------------------------
	select
		@gameid 		= gameid,
		@cashcost		= cashcost,
		@gamecost		= gamecost,
		@heart			= heart,
		@feed			= feed,
		@tutorial		= tutorial
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 유저정보', @gameid gameid

	if(isnull(@gameid, '') = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '아이디가 존재하지 않는다.'
			--select 'DEBUG ', @comment
		END
	else if(@mode_ not in (@MODE_TUTORIAL_OK, @MODE_TUTORIAL_RETRY, @MODE_TUTORIAL_SKIP))
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment 	= '지원하지 않는 모드입니다.'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'DEBUG 정상기록합니다.'
			--select 'DEBUG ', @comment

			if(@tutorial = @MODE_TUTORIAL_OK)
				begin
					set @tutorial = @MODE_TUTORIAL_OK
				end
			else if(@mode_ in (@MODE_TUTORIAL_OK, @MODE_TUTORIAL_RETRY) and @tutorial in (@MODE_TUTORIAL_NON, @MODE_TUTORIAL_SKIP))
				begin
					-- 4루비 + 150코인 + 2 캐시 일꾼 + 2캐시 백신
					exec spu_SubGiftSendNew 2, 5008, 0, 'SysTut', @gameid_, ''
					exec spu_SubGiftSendNew 2, 5102, 0, 'SysTut', @gameid_, ''
					exec spu_SubGiftSendNew 2,  803, 0, 'SysTut', @gameid_, ''
					exec spu_SubGiftSendNew 2, 1003, 0, 'SysTut', @gameid_, ''
					set @tutorial	= @MODE_TUTORIAL_OK

					update dbo.tUserMaster
						set
							tutorial	= @tutorial
					where gameid = @gameid_
				end
			else if(@mode_ in (@MODE_TUTORIAL_SKIP) and @tutorial = @MODE_TUTORIAL_NON)
				begin
					set @tutorial	= @MODE_TUTORIAL_SKIP

					update dbo.tUserMaster
						set
							tutorial	= @tutorial
					where gameid = @gameid_
				end

		END

	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost, @heart heart, @feed feed, @tutorial tutorial

	if(@nResult_ = @RESULT_SUCCESS)
		begin
			--------------------------------------------------------------
			-- 선물/쪽지 리스트 정보
			--------------------------------------------------------------
			exec spu_GiftList @gameid_
		end


	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
End



