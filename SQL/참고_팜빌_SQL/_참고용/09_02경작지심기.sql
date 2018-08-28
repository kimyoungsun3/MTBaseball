/*
exec spu_FVSeedPlant 'xxxx2', '049000s1i0n7t8445280',  0, 600, 0, -1	-- 유저없음.
exec spu_FVSeedPlant 'xxxx2', '049000s1i0n7t8445289', 11, 600, 0, -1	-- 미구매.
exec spu_FVSeedPlant 'xxxx2', '049000s1i0n7t8445289', -1, 600, 0, -1	-- 잘못된 경작지번호.
exec spu_FVSeedPlant 'xxxx2', '049000s1i0n7t8445289',  1, 444, 0, -1	-- 잘못된 씨앗정보.

exec spu_FVSeedPlant 'farm1078959', '2506581j3z1t4e126143',  0, 600, 1, -1	-- 건초 > 직접.
exec spu_FVSeedPlant 'xxxx2', '049000s1i0n7t8445289',  1, 600, 1, -1	-- 건초 > 직접.
exec spu_FVSeedPlant 'xxxx2', '049000s1i0n7t8445289',  2, 601, 1, -1	-- 건초 > 직접.
exec spu_FVSeedPlant 'xxxx2', '049000s1i0n7t8445289',  3, 602, 0, -1	-- 건초 > 직접.
exec spu_FVSeedPlant 'xxxx2', '049000s1i0n7t8445289',  4, 603, 0, -1	-- 건초 > 직접.
exec spu_FVSeedPlant 'xxxx2', '049000s1i0n7t8445289',  5, 604, 0, -1	-- 건초 > 직접.
exec spu_FVSeedPlant 'xxxx2', '049000s1i0n7t8445289',  6, 607, 0, -1	-- 하트 > 직접.
exec spu_FVSeedPlant 'xxxx2', '049000s1i0n7t8445289',  7, 605, 0, -1	-- 회복 > 소모(선물함).
exec spu_FVSeedPlant 'xxxx2', '049000s1i0n7t8445289',  8, 606, 0, -1	-- 촉진 > 소모(선물함).
*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVSeedPlant', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVSeedPlant;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_FVSeedPlant
	@gameid_								varchar(60),
	@password_								varchar(20),
	@seedidx_								int,
	@seeditemcode_							int,
	@feeduse_								int,
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
	declare @RESULT_ERROR_PLANT_ALREADY			int				set @RESULT_ERROR_PLANT_ALREADY			= -119			-- 이미 씨앗이 심어져있음.
	declare @RESULT_ERROR_NEED_BUY				int				set @RESULT_ERROR_NEED_BUY				= -120			-- 경작지가 미구매상태.

	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------
	-- 아이템별 인벤분류
	declare @USERITEM_INVENKIND_ANI				int 				set @USERITEM_INVENKIND_ANI					= 1
	declare @USERITEM_INVENKIND_CONSUME			int 				set @USERITEM_INVENKIND_CONSUME				= 3
	declare @USERITEM_INVENKIND_ACC				int 				set @USERITEM_INVENKIND_ACC					= 4
	declare @USERITEM_INVENKIND_DIRECT			int 				set @USERITEM_INVENKIND_DIRECT				= 40
	declare @USERITEM_INVENKIND_INFO			int 				set @USERITEM_INVENKIND_INFO				= 60
	declare @USERITEM_INVENKIND_PET				int 				set @USERITEM_INVENKIND_PET					= 1000

	-- 아이템 소분류
	declare @ITEM_SUBCATEGORY_COW				int					set @ITEM_SUBCATEGORY_COW 					= 1  -- 소		(판매[O], 선물[O])
	declare @ITEM_SUBCATEGORY_GOAT				int					set @ITEM_SUBCATEGORY_GOAT 					= 2  -- 양		(판매[O], 선물[O])
	declare @ITEM_SUBCATEGORY_SHEEP				int					set @ITEM_SUBCATEGORY_SHEEP 				= 3  -- 산양	(판매[O], 선물[O])
	declare @ITEM_SUBCATEGORY_SEED				int					set @ITEM_SUBCATEGORY_SEED 					= 7  -- 씨앗	(판매[X], 선물[X], 직접[O])
	declare @ITEM_SUBCATEGORY_BULLET			int					set @ITEM_SUBCATEGORY_BULLET 				= 8  -- 총알	(판매[O], 선물[O], 장착[O])
	declare @ITEM_SUBCATEGORY_VACCINE			int					set @ITEM_SUBCATEGORY_VACCINE 				= 9  -- 치료제	(판매[O], 선물[O], 장착[O])
	declare @ITEM_SUBCATEGORY_FEED				int					set @ITEM_SUBCATEGORY_FEED 					= 44 -- 건초	(판매[X], 선물[O])
	declare @ITEM_SUBCATEGORY_ALBA				int					set @ITEM_SUBCATEGORY_ALBA 					= 11 -- 일꾼	(판매[O], 선물[O], 장착[O])
	declare @ITEM_SUBCATEGORY_BOOSTER			int					set @ITEM_SUBCATEGORY_BOOSTER 				= 12 -- 촉진제	(판매[O], 선물[O], 장착[O])
	declare @ITEM_SUBCATEGORY_REVIVAL			int					set @ITEM_SUBCATEGORY_REVIVAL 				= 13 -- 부활석	(판매[O], 선물[O])
	declare @ITEM_SUBCATEGORY_ACC				int					set @ITEM_SUBCATEGORY_ACC 					= 15 -- 악세	(판매[O], 선물[O])
	declare @ITEM_SUBCATEGORY_HEART				int					set @ITEM_SUBCATEGORY_HEART 				= 40 -- 하트	(판매[O], 선물[O])
	declare @ITEM_SUBCATEGORY_HELPER			int					set @ITEM_SUBCATEGORY_HELPER 				= 41 -- 긴급요청(판매[X], 선물[O])
	declare @ITEM_SUBCATEGORY_TRADESAFE			int					set @ITEM_SUBCATEGORY_TRADESAFE				= 42 -- 상인만족(판매[X], 선물[O])
	declare @ITEM_SUBCATEGORY_CASHCOST			int					set @ITEM_SUBCATEGORY_CASHCOST 				= 50 -- 캐쉬	(판매[O], 선물[O])
	declare @ITEM_SUBCATEGORY_GAMECOST			int					set @ITEM_SUBCATEGORY_GAMECOST 				= 51 -- 코인	(판매[O], 선물[O])
	declare @ITEM_SUBCATEGORY_CONTEST			int					set @ITEM_SUBCATEGORY_CONTEST 				= 53 -- 대회	(판매[O], 선물[O])
	declare @ITEM_SUBCATEGORY_UPGRADE_HOUSE		int					set @ITEM_SUBCATEGORY_UPGRADE_HOUSE 		= 60 -- 집
	declare @ITEM_SUBCATEGORY_UPGRADE_TANK		int					set @ITEM_SUBCATEGORY_UPGRADE_TANK 			= 61 -- 탱크
	declare @ITEM_SUBCATEGORY_UPGRADE_FRESHCOOL	int					set @ITEM_SUBCATEGORY_UPGRADE_FRESHCOOL 	= 62 -- 저온보관
	declare @ITEM_SUBCATEGORY_UPGRADE_PURE		int					set @ITEM_SUBCATEGORY_UPGRADE_PURE 			= 63 -- 정화시설
	declare @ITEM_SUBCATEGORY_UPGRADE_BOTTLE	int					set @ITEM_SUBCATEGORY_UPGRADE_BOTTLE 		= 64 -- 양동이
	declare @ITEM_SUBCATEGORY_UPGRADE_PUMP		int					set @ITEM_SUBCATEGORY_UPGRADE_PUMP 			= 65 -- 착유기
	declare @ITEM_SUBCATEGORY_UPGRADE_TRANSFER	int					set @ITEM_SUBCATEGORY_UPGRADE_TRANSFER 		= 66 -- 주입기
	declare @ITEM_SUBCATEGORY_INVEN				int					set @ITEM_SUBCATEGORY_INVEN 				= 67 -- 인벤확장
	declare @ITEM_SUBCATEGORY_SEEDFIELD			int					set @ITEM_SUBCATEGORY_SEEDFIELD 			= 68 -- 경작지확장
	declare @ITEM_SUBCATEGORY_DOGAM				int					set @ITEM_SUBCATEGORY_DOGAM 				= 818 -- 도감
	declare @ITEM_SUBCATEGORY_SYSINFO			int					set @ITEM_SUBCATEGORY_SYSINFO 				= 500 -- 정보수집
	declare @ITEM_SUBCATEGORY_ATTENDANCE		int					set @ITEM_SUBCATEGORY_ATTENDANCE 			= 900 	--출석(900)
	declare @ITEM_SUBCATEGORY_COMPETITION		int					set @ITEM_SUBCATEGORY_COMPETITION 			= 901 	--경쟁모드(901)


	-- 경작지(정보).
	declare @USERSEED_NEED_EMPTY				int					set @USERSEED_NEED_EMPTY					= -1	-- (경작지)
	declare @USERSEED_NEED_BUY					int					set @USERSEED_NEED_BUY						= -2
	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @comment			varchar(80)

	declare @gameid 			varchar(60)		set @gameid 		= ''
	declare @market				int				set @market			= 1
	declare @cashcost			int				set @cashcost		= 0
	declare @gamecost			int				set @gamecost		= 0
	declare @feed				int				set @feed			= 0
	declare @heart				int				set @heart			= 0
	declare @qtfeeduse			int				set @qtfeeduse		= 0


	declare @seeditemcode		int				set @seeditemcode		= @USERSEED_NEED_BUY

	declare @seeditemcodenew	int				set @seeditemcodenew	= -444
	declare @gamecostsell		int				set @gamecostsell 		= 99999
	declare @cashcostsell		int				set @cashcostsell 		= 99999
	declare @harvestcnt			int				set @harvestcnt			= 0
	declare @harvesttime		int				set @harvesttime		= 99999
	declare @harvestcashcost	int				set @harvestcashcost	= 99999
	declare @harvestitemcode	int				set @harvestitemcode	= -444

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	set @comment = 'ERROR 알수없는 오류(-1)'
	--select 'DEBUG 1-0 입력값', @gameid_ gameid_, @password_ password_, @seedidx_ seedidx_, @seeditemcode_ seeditemcode_

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
		@heart			= heart,
		@qtfeeduse		= qtfeeduse
	from dbo.tFVUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 1-1 유저정보', @gameid gameid, @market market, @cashcost cashcost, @gamecost gamecost

	select
		@seeditemcode	= itemcode
	from dbo.tFVUSerSeed where gameid = @gameid_ and seedidx = @seedidx_
	--select 'DEBUG 1-2 경작지정보', @gameid_ gameid_, @seedidx_ seedidx_, @seeditemcode seeditemcode

	---------------------------------------------
	-- 아이템 정보.
	---------------------------------------------
	select
		@seeditemcodenew	= itemcode,
		@cashcostsell		= cashcost,
		@gamecostsell 		= gamecost,
		@harvestcnt			= param1,
		@harvesttime		= param2,
		@harvestcashcost	= param5,
		@harvestitemcode	= param6
	from dbo.tFVItemInfo
	where subcategory = @ITEM_SUBCATEGORY_SEED and itemcode = @seeditemcode_
	--select 'DEBUG 1-3 씨앗정보', @seeditemcode_ seeditemcode_, @seeditemcodenew seeditemcodenew, @cashcostsell cashcostsell, @gamecostsell gamecostsell, @harvestcnt harvestcnt, @harvesttime harvesttime, @harvestcashcost harvestcashcost, @harvestitemcode harvestitemcode

	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '아이디가 존재하지 않는다.'
			--select 'DEBUG ' + @comment
		END
	else if(@seeditemcode = @USERSEED_NEED_BUY)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NEED_BUY
			set @comment 	= '경작지를 구매하지 않음.'
			--select 'DEBUG ' + @comment
		END
	else if(@seeditemcode >= 600 and @seeditemcode <=699)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '이미 씨앗이 있습니다.'
			--select 'DEBUG ' + @comment
		END
	else if(@seeditemcodenew = -444)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_ITEMCODE
			set @comment 	= '씨앗 정보를 못찾았습니다.'
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
			set @comment = 'SUCCESS 경작지에 씨앗을 심는다.'
			--select 'DEBUG ' + @comment

			-- 경작지 심기.
			update dbo.tFVUSerSeed
				set
					itemcode 		= @seeditemcode_,
					seedstartdate	= getdate(),
					seedenddate		= DATEADD(ss, @harvesttime, getdate())
			where gameid = @gameid_ and seedidx = @seedidx_

			-- 비용차감.
			set @cashcost	= @cashcost - @cashcostsell
			set @gamecost	= @gamecost - @gamecostsell

			-- 사용건초계산.
			set @feeduse_ = case
								when @feeduse_ < 0 then (-@feeduse_)
								else @feeduse_
							end

			set @feed 		= @feed - @feeduse_
			set @qtfeeduse 	= @qtfeeduse + @feeduse_

			--set @feed = case when @feed < 0 then 0 else @feed end

			-----------------------------------
			-- 구매기록마킹
			-----------------------------------
			exec spu_FVUserItemBuyLog @gameid_, @seeditemcode_, @gamecostsell, @cashcostsell
		END

	--------------------------------------------------------------
	-- 상태 코드 정보값.
	--------------------------------------------------------------
	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost, @feed feed, @heart heart

	if(@nResult_ = @RESULT_SUCCESS)
		begin
			-------------------------------------------------------------
			-- 일반결과는 상단에 노출됩니다.
			-------------------------------------------------------------

			-----------------------------------
			-- 유저 정보 반영.
			-----------------------------------
			update dbo.tFVUserMaster
			set
				cashcost		= @cashcost,
				gamecost		= @gamecost,
				feed			= @feed,
				heart			= @heart,

				qtfeeduse		= @qtfeeduse
			where gameid = @gameid_

			--------------------------------------------------------------
			-- 심은 정보.
			--------------------------------------------------------------
			select * from dbo.tFVUserSeed where gameid = @gameid_ and seedidx = @seedidx_
		end
	--else
	--	begin
	--		-------------------------------------------------------------
	--		-- 일반결과는 상단에 노출됩니다.
	--		-------------------------------------------------------------
	--	end

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
End



