/*
-- 루비으로 하기.
-- update dbo.tUserMaster set cashcost = 100 where gameid = 'xxxx2'
-- update dbo.tUserMaster set bgcomposewt = DATEADD(ss, 350, getdate()) where gameid = 'xxxx2'
exec spu_AniComposeInit 'xxxx2', '049000s1i0n7t8445289', -1

-- 합성 시간템 받아서 처리하기.
-- update dbo.tUserMaster set cashcost = 0 where gameid = 'xxxx2'
exec spu_AniComposeInit 'xxxx2', '049000s1i0n7t8445289', -1
*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_AniComposeInit', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_AniComposeInit;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_AniComposeInit
	@gameid_				varchar(20),
	@password_				varchar(20),
	@nResult_				int					OUTPUT
	WITH ENCRYPTION
as
	------------------------------------------------
	--	2-1. 코드값
	------------------------------------------------
	-- 일반값
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	-- 로그인 오류.
	declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--블럭유저 > 팝업처리후 인트로로 빼버린다.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함

	-- 게임중에 부족.
	declare @RESULT_ERROR_CASHCOST_LACK			int				set @RESULT_ERROR_CASHCOST_LACK			= -22			--골드가 부족하다.

	-- 기타오류
	declare @RESULT_ERROR_TIME_REMAIN			int				set @RESULT_ERROR_TIME_REMAIN			= -123			-- 아직 시간이 남음.

	------------------------------------------------
	--	2-2. 정의된값
	------------------------------------------------
	-- 기록값
	declare @COMPOSE_INIT_ITEMCODE 				int				set @COMPOSE_INIT_ITEMCODE				= 50002			-- 합성 초기화템.

	-- 그룹.
	declare @ITEM_COMPOSE_TIME_MOTHER			int				set @ITEM_COMPOSE_TIME_MOTHER			= 1600	-- 합성시간 1시간초기화.

	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @comment		varchar(80)
	declare @gameid			varchar(20)		set @gameid			= ''		-- 유저정보.
	declare @cashcost		int				set @cashcost 		= 0
	declare @gamecost		int				set @gamecost 		= 0
	declare @heart			int				set @heart 			= 0
	declare @feed			int				set @feed 			= 0
	declare @bgcomposewt	datetime		set @bgcomposewt	= getdate()
	declare @bgcomposecc	int				set @bgcomposecc	= 0

	declare @listidx		int				set @listidx		= -1
	declare @cnt			int				set @cnt			= 0
Begin
	------------------------------------------------
	--	3-1. 초기화.
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	set @comment  = '알수 없는 오류가 발생했습니다.'
	--select 'DEBUG 3-1 입력값', @gameid_ gameid_, @password_ password_

	------------------------------------------------
	--	3-2. 연산수행(유저정보, 선물정보, 아이템 종류)
	------------------------------------------------
	select
		@gameid 		= gameid,
		@cashcost		= cashcost,
		@gamecost		= gamecost,
		@heart			= heart,
		@feed			= feed,
		@bgcomposewt	= bgcomposewt,
		@bgcomposecc 	= bgcomposecc
	from dbo.tUserMaster where gameid = @gameid_ and password = @password_
	--select 'DEBUG 3-2 유저정보', @gameid gameid, @cashcost cashcost, @gamecost gamecost, @heart heart, @bgcomposewt bgcomposewt, @bgcomposecc bgcomposecc

	-- 시간 초기화템 보유수량
	select
		@listidx	= listidx,
		@cnt 		= cnt
	from dbo.tUserItem
	where gameid = @gameid_ and itemcode = @ITEM_COMPOSE_TIME_MOTHER
	--select 'DEBUG 유저 시간초기화', @listidx listidx, @cnt cnt

	------------------------------------------------
	--	3-3. 각상황별로 코드로 분류
	------------------------------------------------
	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR 아이디가 존재하지 않는다.'
			--select 'DEBUG 4' + @comment
		END
	else if (@bgcomposecc = 0)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'SUCCESS 초기화 합니다.(이미했다)'
			--select 'DEBUG ' + @comment
		END
	else if (@cnt <= 0 and @cashcost < @bgcomposecc)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_CASHCOST_LACK
			set @comment 	= 'ERROR 캐쉬가 부족합니다.'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'SUCCESS 시간을 초기화 했습니다.'
			--select 'DEBUG ' + @comment

			if (@cnt > 0)
				BEGIN
					------------------------------------------------
					-- 합성 로고 기록.
					------------------------------------------------

					------------------------------------------------
					-- 합성 시간 갱신.
					------------------------------------------------
					set @bgcomposewt = DATEADD(hh, -1, @bgcomposewt)
					if(getdate() >= @bgcomposewt)
						begin
							set @bgcomposecc = 0
						end
					else
						begin
							set @bgcomposecc = @bgcomposecc
						end

					------------------------------------------------
					-- 수량 감소.
					------------------------------------------------
					update dbo.tUserItem
						set
							cnt	= cnt - 1
					where gameid = @gameid_ and itemcode = @ITEM_COMPOSE_TIME_MOTHER
				END
			else
				BEGIN
					set @nResult_ = @RESULT_SUCCESS
					set @comment = 'SUCCESS 초기화 합니다.'
					--select 'DEBUG ' + @comment

					------------------------------------------------
					-- 합성 로고 기록.
					------------------------------------------------
					exec spu_UserItemBuyLogNew @gameid_, @COMPOSE_INIT_ITEMCODE, 0, @bgcomposecc, 0

					------------------------------------------------
					-- 합성 시간 갱신.
					------------------------------------------------
					set @bgcomposewt 	= getdate()
					set @cashcost 		= @cashcost - @bgcomposecc
					set @bgcomposecc	= 0
				END
		END

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost, @heart heart, @feed feed, @bgcomposewt bgcomposewt, @bgcomposecc bgcomposecc

	if(@nResult_ = @RESULT_SUCCESS)
		begin
			-- 아이템을 직접 넣어줌
			update dbo.tUserMaster
				set
					cashcost	= @cashcost,
					gamecost	= @gamecost,
					heart		= @heart,
					feed		= @feed,
					bgcomposewt	= @bgcomposewt,
					bgcomposecc	= @bgcomposecc
			where gameid = @gameid_
		end
	set nocount off
End

