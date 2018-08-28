/*
update dbo.tFVUserMaster set cashcost = 1000 where gameid = 'xxxx2'
exec spu_FVAniUrgency 'xxxx2', '049000s1i0n7t8445289', -1
*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVAniUrgency', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVAniUrgency;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_FVAniUrgency
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
	declare @RESULT_ERROR_HEART_LACK			int				set @RESULT_ERROR_HEART_LACK			= -20			--하트이 부족하다.
	declare @RESULT_ERROR_GAMECOST_LACK			int				set @RESULT_ERROR_GAMECOST_LACK			= -21			--실버가 부족하다.
	declare @RESULT_ERROR_CASHCOST_LACK			int				set @RESULT_ERROR_CASHCOST_LACK			= -22			--골드가 부족하다.
	declare @RESULT_ERROR_ITEM_LACK				int				set @RESULT_ERROR_ITEM_LACK				= -23			--아이템이부족하다.


	-- 긴급지원 코드번호.
	declare @URGENCY_ITEMCODE					int					set @URGENCY_ITEMCODE				= 2100

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

	declare @urglistidx			int				set @urglistidx		= -444
	declare @urgcnt				int				set @urgcnt			= 0
	declare @urgcashcost		int				set @urgcashcost	= 99999

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
		@gamecost		= gamecost
	from dbo.tFVUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 유저정보', @gameid gameid, @cashcost cashcost, @gamecost gamecost

	-- 유저 보유 긴급지원템.
	select
		@urglistidx		= listidx,
		@urgcnt 		= cnt
	from dbo.tFVUserItem
	where gameid = @gameid_ and itemcode = @URGENCY_ITEMCODE
	--select 'DEBUG 유저 보유 긴급지원템', @urglistidx urglistidx, @urgcnt urgcnt

	select
		@urgcashcost = cashcost
	from dbo.tFVItemInfo
	where itemcode = @URGENCY_ITEMCODE
	--select 'DEBUG 긴급지원템 캐쉬가격', @urgcashcost urgcashcost

	------------------------------------------------
	--	3-3. 연산수행
	------------------------------------------------
	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '아이디가 존재하지 않는다.'
			--select 'DEBUG ' + @comment
		END
	else if(@urgcnt <= 0 and @urgcashcost > @cashcost)
		BEGIN
			set @nResult_ = @RESULT_ERROR_CASHCOST_LACK
			set @comment = 'ERROR 캐쉬가 부족합니다.'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 긴급지원을 지원합니다.'

			if(@urgcnt > 0)
				begin
					------------------------
					-- 구매번호.
					------------------------
					--exec spu_FVUserItemBuyLog @gameid_, @URGENCY_ITEMCODE, 0, 0

					----------------------------------
					--	긴급지원 > 템.
					----------------------------------
					set @urgcnt = @urgcnt - 1
					--select 'DEBUG > 긴급지원석(0), 캐쉬(x) > 긴급지원(0)', @urgcnt urgcnt

					update dbo.tFVUserItem
						set
							cnt = @urgcnt
					where gameid = @gameid_ and itemcode = @URGENCY_ITEMCODE
				end
			else
				begin
					----------------------------------
					--	긴급지원 > 캐쉬.
					----------------------------------
					set @cashcost = @cashcost - @urgcashcost

					-----------------------------------
					-- 구매기록마킹
					-----------------------------------
					exec spu_FVUserItemBuyLog @gameid_, @URGENCY_ITEMCODE, 0, @urgcashcost
				end
		END



	if(@nResult_ = @RESULT_SUCCESS)
		begin
			select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost

			-----------------------------------
			-- 유저 정보 반영.
			-----------------------------------
			update dbo.tFVUserMaster
			set
				cashcost	= @cashcost,
				gamecost	= @gamecost
			where gameid = @gameid_

		end
	else
		begin
			select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost
		end

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
End



