/*
exec spu_SeedBuy 'xxxx2', '049000s1i0n7t8445280', 0, -1		-- 유저없음.
exec spu_SeedBuy 'xxxx2', '049000s1i0n7t8445289', 12, -1	-- 없는번호
exec spu_SeedBuy 'xxxx2', '049000s1i0n7t8445289',  0, -1	-- 이미구매.
exec spu_SeedBuy 'xxxx2', '049000s1i0n7t8445289', -1, -1	-- 잘못된 경작지번호.

exec spu_SeedBuy 'xxxx2', '049000s1i0n7t8445289',  1, -1
*/
use Game4Farmvill5
GO

IF OBJECT_ID ( 'dbo.spu_SeedBuy', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_SeedBuy;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_SeedBuy
	@gameid_								varchar(20),
	@password_								varchar(20),
	@seedidx_								int,
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

	-- 아이템 구매, 변경.
	declare @RESULT_ERROR_BUY_ALREADY			int				set @RESULT_ERROR_BUY_ALREADY			= -31			--이미 구매했습니다.
	declare @RESULT_ERROR_NOT_HAVE				int				set @RESULT_ERROR_NOT_HAVE				= -32			--보유하지 않고 있다.
	declare @RESULT_ERROR_UPGRADE_FULL			int				set @RESULT_ERROR_UPGRADE_FULL			= -35			--업그레이드가 풀로되었다.
	declare @RESULT_ERROR_ITEM_NOSALE_KIND		int				set @RESULT_ERROR_ITEM_NOSALE_KIND		= -37			--판매하지 않는 아이템

	-- 선물 코드값
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- 아이템코드못찾음
	declare @RESULT_ERROR_GIFTITEM_NOT_FOUND	int				set @RESULT_ERROR_GIFTITEM_NOT_FOUND	= -51			-- 선물아이템을 못찾음
	declare @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	int				set @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	= -52			-- 선물을 이미 가져감
	declare @RESULT_ERROR_NOT_FOUND_GIFTID		int				set @RESULT_ERROR_NOT_FOUND_GIFTID		= -75			-- 캐쉬 > 선물할 아이디를 못찾음

	-- 기타오류
	declare @RESULT_ERROR_NOT_FOUND_SEEDIDX		int				set @RESULT_ERROR_NOT_FOUND_SEEDIDX		= -118			-- 파라미터 오류.

	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------
	-- 아이템 소분류
	declare @ITEM_SUBCATEGORY_SEEDFIELD			int					set @ITEM_SUBCATEGORY_SEEDFIELD 			= 68 -- 경작지확장


	-- 경작지(정보).
	declare @USERSEED_NEED_EMPTY				int					set @USERSEED_NEED_EMPTY					= -1	-- (경작지)
	declare @USERSEED_NEED_BUY					int					set @USERSEED_NEED_BUY						= -2
	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @comment			varchar(80)

	declare @gameid 			varchar(20)		set @gameid 		= ''
	declare @market				int				set @market			= 1
	declare @cashcost			int				set @cashcost		= 0
	declare @gamecost			int				set @gamecost		= 0
	declare @feed				int				set @feed			= 0
	declare @heart				int				set @heart			= 0

	declare @itemcode			int				set @itemcode			= -444

	declare @seedfieldmax		int				set @seedfieldmax		= 11
	declare @itemcodesell		int				set @itemcodesell		= -444
	declare @gamecostsell		int				set @gamecostsell 		= 99999
	declare @cashcostsell		int				set @cashcostsell 		= 99999

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	set @comment = 'ERROR 알수없는 오류(-1)'
	--select 'DEBUG 1-0 입력값', @gameid_ gameid_, @password_ password_, @seedidx_ seedidx_

	------------------------------------------------
	--	3-2. 유저정보.
	------------------------------------------------
	-- 유저정보.
	select
		@gameid 		= gameid,
		@market			= market,
		@cashcost		= cashcost,
		@gamecost		= gamecost,
		@feed			= feed,
		@heart			= heart
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 1-1 유저정보', @gameid gameid, @market market, @cashcost cashcost, @gamecost gamecost

	select
		@itemcode	= itemcode
	from dbo.tUSerSeed where gameid = @gameid_ and seedidx = @seedidx_
	--select 'DEBUG 1-2 경작지정보', @gameid_ gameid_, @seedidx_ seedidx_, @itemcode itemcode

	---------------------------------------------
	-- tItemInfo(인벤정보) > 관리페이지(수집) > tSystemInfo
	---------------------------------------------
	select top 1 @seedfieldmax = seedfieldmax from dbo.tSystemInfo order by idx desc


	-- 가격알아보기.
	select
		@itemcodesell		= itemcode,
		@cashcostsell		= cashcost,
		@gamecostsell 		= gamecost
	from dbo.tItemInfo
	where subcategory = @ITEM_SUBCATEGORY_SEEDFIELD and param1 = @seedidx_
	--select 'DEBUG 1-3 아이템정보', @seedidx_ seedidx_, @seedfieldmax seedfieldmax, @itemcodesell itemcodesell, @cashcostsell cashcostsell, @gamecostsell gamecostsell


	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '아이디가 존재하지 않는다.'
			--select 'DEBUG ' + @comment
		END
	else if(@itemcode = -444 or @itemcodesell = -444)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_ITEMCODE
			set @comment 	= '잘못된 경작지 번호 입니다.'
			--select 'DEBUG ' + @comment
		END
	else if(@itemcode = @USERSEED_NEED_EMPTY or (@itemcode >= 600 and @itemcode < 700))
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_BUY_ALREADY
			set @comment 	= '이미 구매한 경작지 입니다.'
			--select 'DEBUG ' + @comment
		END
	else if(@seedidx_ < 0 or @seedidx_ > @seedfieldmax)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_SEEDIDX
			set @comment 	= '경작지 번호가 유효하지 않습니다.'
			--select 'DEBUG ' + @comment
		END
	else if(@cashcostsell > 0 and @cashcostsell > @cashcost)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_CASHCOST_LACK
			set @comment 	= '캐쉬비용이 부족합니다.'
			--select 'DEBUG ' + @comment
		END
	else if(@gamecostsell > 0 and @gamecostsell > @gamecost)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_GAMECOST_LACK
			set @comment 	= '코인비용이 부족합니다.'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 경작지를 구매합니다.'
			--select 'DEBUG ' + @comment

			-- 경작지 구매.
			update dbo.tUSerSeed
				set
					itemcode = @USERSEED_NEED_EMPTY
			where gameid = @gameid_ and seedidx = @seedidx_

			-- 비용차감.
			set @cashcost	= @cashcost - @cashcostsell
			set @gamecost	= @gamecost - @gamecostsell

			-----------------------------------
			-- 구매기록마킹
			-----------------------------------
			exec spu_UserItemBuyLogNew @gameid_, @itemcodesell, @gamecostsell, @cashcostsell, 0
		END


	if(@nResult_ = @RESULT_SUCCESS)
		begin
			-----------------------------------
			-- 유저 정보 반영.
			-----------------------------------
			update dbo.tUserMaster
			set
				cashcost		= @cashcost,
				gamecost		= @gamecost,
				feed			= @feed,
				heart			= @heart
			where gameid = @gameid_

			--------------------------------------------------------------
			-- 코드(캐쉬, 코인, 인벤정보)
			--------------------------------------------------------------
			select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost, @feed feed, @heart heart
		end
	else
		begin
			select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost, @feed feed, @heart heart
		end

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
End



