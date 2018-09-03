/*
update dbo.tUserMaster set cashcost = 1000 where gameid = 'xxxx2'
exec spu_AniUrgency 'xxxx2', '049000s1i0n7t8445289', -1
*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_AniUrgency', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_AniUrgency;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_AniUrgency
	@gameid_								varchar(20),
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
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함.
	declare @RESULT_ERROR_CASHCOST_LACK			int				set @RESULT_ERROR_CASHCOST_LACK			= -22			--골드가 부족하다.


	-- 긴급지원 코드번호.
	declare @URGENCY_ITEMCODE					int					set @URGENCY_ITEMCODE				= 2100

	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------

	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @comment			varchar(80)

	declare @gameid 			varchar(20)		set @gameid 		= ''
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
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 유저정보', @gameid gameid, @cashcost cashcost, @gamecost gamecost

	-- 유저 보유 긴급지원템.
	select
		@urglistidx		= listidx,
		@urgcnt 		= cnt
	from dbo.tUserItem
	where gameid = @gameid_ and itemcode = @URGENCY_ITEMCODE
	--select 'DEBUG 유저 보유 긴급지원템', @urglistidx urglistidx, @urgcnt urgcnt

	select
		@urgcashcost = cashcost
	from dbo.tItemInfo
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
					--exec spu_UserItemBuyLogNew @gameid_, @URGENCY_ITEMCODE, 0, 0, 0

					----------------------------------
					--	긴급지원 > 템.
					----------------------------------
					set @urgcnt = @urgcnt - 1
					--select 'DEBUG > 긴급지원석(0), 캐쉬(x) > 긴급지원(0)', @urgcnt urgcnt

					update dbo.tUserItem
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
					exec spu_UserItemBuyLogNew @gameid_, @URGENCY_ITEMCODE, 0, @urgcashcost, 0
				end
		END



	if(@nResult_ = @RESULT_SUCCESS)
		begin
			select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost

			-----------------------------------
			-- 유저 정보 반영.
			-----------------------------------
			update dbo.tUserMaster
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



