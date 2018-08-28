/*
update dbo.tUserMaster set cashcost = 1000, tradecnt = 0, prizecnt = 0, tradecntold = 29,  prizecntold =  4 where gameid = 'xxxx2'
update dbo.tUserMaster set cashcost = 1000, tradecnt = 0, prizecnt = 0, tradecntold = 30,  prizecntold =  5 where gameid = 'xxxx2'
update dbo.tUserMaster set cashcost = 1000, tradecnt = 0, prizecnt = 0, tradecntold = 60,  prizecntold = 10 where gameid = 'xxxx2'
update dbo.tUserMaster set cashcost = 1000, tradecnt = 0, prizecnt = 0, tradecntold = 120, prizecntold = 20 where gameid = 'xxxx2'
update dbo.tUserMaster set cashcost = 1000, tradecnt = 0, prizecnt = 0, tradecntold = 999, prizecntold = 99 where gameid = 'xxxx2'
exec spu_TradeContinue 'xxxx2', '049000s1i0n7t8445289', -1

update dbo.tUserMaster set cashcost = 1000, gamecost = 0, tradecnt = 0, prizecnt = 0, tradecntold = 119, prizecntold = 19 where gameid = 'xxxx2'
exec spu_TradeContinue 'xxxx2', '049000s1i0n7t8445289', -1
select cashcost, gamecost, tradecnt, prizecnt, tradecntold, prizecntold from dbo.tUserMaster where gameid = 'xxxx2'
*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_TradeContinue', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_TradeContinue;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_TradeContinue
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

	-- 기타오류
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- 지원하지않는모드

	-- 아이템 소분류
	declare @ITEM_SUBCATEGORY_CONTRADE			int					set @ITEM_SUBCATEGORY_CONTRADE 				= 54 -- 연속거래(54)

	declare @TRADEINFO_PRIZECOIN_MAX			int					set @TRADEINFO_PRIZECOIN_MAX 				= 3000	-- 상인연속 거래 추가 보상맥스.

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
	declare @tradecntold		int				set @tradecntold	= 0
	declare @prizecntold		int				set @prizecntold	= 0
	declare @prizecntoldnew		int				set @prizecntoldnew	= 0
	declare @plusgamecost		int				set @plusgamecost	= 0

	declare @paycashcost		int				set @paycashcost	= 99999
	declare @payitemcode		int				set @payitemcode	= -1

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
		@tradecntold 	= tradecntold,
		@prizecntold	= prizecntold
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 유저정보', @gameid gameid, @cashcost cashcost, @gamecost gamecost, @tradecntold tradecntold, @prizecntold prizecntold

	select top 1
		@paycashcost 	= cashcost,
		@payitemcode	= itemcode
	from
	(select itemcode, cashcost, param1, param2 from dbo.tItemInfo where subcategory = @ITEM_SUBCATEGORY_CONTRADE) t
	where t.param1 <= @tradecntold and @tradecntold < t.param2
	--select 'DEBUG 캐쉬가격', @tradecntold tradecntold, @paycashcost paycashcost, @payitemcode payitemcode

	------------------------------------------------
	--	3-3. 연산수행
	------------------------------------------------
	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '아이디가 존재하지 않는다.'
			--select 'DEBUG ' + @comment
		END
	else if(@payitemcode =  -1)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment 	= '지원하지 않는 모드입니다.'
			--select 'DEBUG ' + @comment
		END
	else if(@paycashcost > @cashcost)
		BEGIN
			set @nResult_ = @RESULT_ERROR_CASHCOST_LACK
			set @comment = 'ERROR 캐쉬가 부족합니다.'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 상인변경을 지원합니다.'

			----------------------------------
			--	긴급지원 > 캐쉬.
			----------------------------------
			set @cashcost = @cashcost - @paycashcost

			-----------------------------------
			-- 구매기록마킹
			-----------------------------------
			exec spu_UserItemBuyLogNew @gameid_, @payitemcode, 0, @paycashcost, 0

			-----------------------------------
			-- 구매기록마킹
			-----------------------------------
			set @tradecntold 	= @tradecntold + 1
			set @prizecntoldnew	= @tradecntold / 6
			if(@prizecntold < @prizecntoldnew)
				begin
					set @plusgamecost = 75 * @prizecntoldnew
					set @plusgamecost = case
											when @plusgamecost > @TRADEINFO_PRIZECOIN_MAX 	then @TRADEINFO_PRIZECOIN_MAX
											when @plusgamecost < 75							then 75
											else @plusgamecost
										end
					set @gamecost = @gamecost + @plusgamecost
				end
			set @prizecntold = @prizecntoldnew
		END


	select @nResult_ rtn, @comment comment
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			-----------------------------------
			-- 유저 정보 반영.
			-----------------------------------
			update dbo.tUserMaster
			set
				cashcost	= @cashcost,
				gamecost	= @gamecost,
				tradefailcnt= 0,
				tradecnt	= @tradecntold,
				prizecnt	= @prizecntold

				--tradecntold	= 0,
				--prizecntold	= 0

			where gameid = @gameid_

			-----------------------------------
			-- 유저 정보.
			-----------------------------------
			select * from dbo.tUserMaster where gameid = @gameid_
		end

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
End



