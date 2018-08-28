/*
-----------------------------------------------------
-- 2014-05-15
-- 경작지를 로고 수집만 하는 용도로 변경합니다.(치트 카운터 0)
-- 시간강제 빠르게 > 경작지 증가가 안됨.
-----------------------------------------------------
exec spu_FVSeedHarvest 'xxxx2', '049000s1i0n7t8445280',  0, 1, 0, -1	-- 유저없음.
exec spu_FVSeedHarvest 'xxxx2', '049000s1i0n7t8445289', 11, 1, 0, -1	-- 미구매.
exec spu_FVSeedHarvest 'xxxx2', '049000s1i0n7t8445289',  1, 3, 0, -1	-- 잘못된 모드.

-- 일반수확
exec spu_FVSeedHarvest 'farm1078959', '2506581j3z1t4e126143',  0, 1, 1, -1	-- 건초 > 직접.
exec spu_FVSeedHarvest 'xxxx2', '049000s1i0n7t8445289',  1, 1, 1, -1	-- 건초 > 직접.
exec spu_FVSeedHarvest 'xxxx2', '049000s1i0n7t8445289',  2, 1, 0, -1	-- 건초 > 직접.
exec spu_FVSeedHarvest 'xxxx2', '049000s1i0n7t8445289',  3, 1, 0, -1	-- 건초 > 직접.
exec spu_FVSeedHarvest 'xxxx2', '049000s1i0n7t8445289',  4, 1, 0, -1	-- 건초 > 직접.
exec spu_FVSeedHarvest 'xxxx2', '049000s1i0n7t8445289',  5, 1, 0, -1	-- 건초 > 직접.
exec spu_FVSeedHarvest 'xxxx2', '049000s1i0n7t8445289',  6, 1, 0, -1	-- 하트 > 직접.
exec spu_FVSeedHarvest 'xxxx2', '049000s1i0n7t8445289',  7, 1, 0, -1	-- 회복 > 소모(선물함).
exec spu_FVSeedHarvest 'xxxx2', '049000s1i0n7t8445289',  8, 1, 0, -1	-- 촉진 > 소모(선물함).

-- 즉시수확(시간만완료)
exec spu_FVSeedHarvest 'farm1078959', '2506581j3z1t4e126143',  0, 2, 1, -1	-- 건초 > 직접.
exec spu_FVSeedHarvest 'xxxx2', '049000s1i0n7t8445289',  1, 2, 1, -1	-- 건초 > 직접.
exec spu_FVSeedHarvest 'xxxx2', '049000s1i0n7t8445289',  2, 2, 0, -1	-- 건초 > 직접.
exec spu_FVSeedHarvest 'xxxx2', '049000s1i0n7t8445289',  3, 2, 0, -1	-- 건초 > 직접.
exec spu_FVSeedHarvest 'xxxx2', '049000s1i0n7t8445289',  4, 2, 0, -1	-- 건초 > 직접.
exec spu_FVSeedHarvest 'xxxx2', '049000s1i0n7t8445289',  5, 2, 0, -1	-- 건초 > 직접.
exec spu_FVSeedHarvest 'xxxx2', '049000s1i0n7t8445289',  6, 2, 0, -1	-- 하트 > 직접.
exec spu_FVSeedHarvest 'xxxx2', '049000s1i0n7t8445289',  7, 2, 0, -1	-- 회복 > 소모(선물함).
exec spu_FVSeedHarvest 'xxxx2', '049000s1i0n7t8445289',  8, 2, 0, -1	-- 촉진 > 소모(선물함).

-- 작물폐기처리.
exec spu_FVSeedHarvest 'xxxx2', '049000s1i0n7t8445289',  1, 3, 1, -1	-- 버리기.


exec spu_FVSeedHarvest 'xxxx2', '049000s1i0n7t8445289',  1, 1, 3, -1	-- 버리기.

*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVSeedHarvest', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVSeedHarvest;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_FVSeedHarvest
	@gameid_								varchar(60),
	@password_								varchar(20),
	@seedidx_								int,
	@mode_									int,
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
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- 지원하지않는모드
	declare @RESULT_ERROR_NOT_FOUND_SEEDIDX		int				set @RESULT_ERROR_NOT_FOUND_SEEDIDX		= -118			-- 파라미터 오류.
	declare @RESULT_ERROR_PLANT_ALREADY			int				set @RESULT_ERROR_PLANT_ALREADY			= -119			-- 이미 씨앗이 심어져있음.
	declare @RESULT_ERROR_NEED_BUY				int				set @RESULT_ERROR_NEED_BUY				= -120			-- 경작지가 미구매상태.
	declare @RESULT_ERROR_HARVEST_TIME_REMAIN	int				set @RESULT_ERROR_HARVEST_TIME_REMAIN	= -121			-- 아직 시간이 남음.

	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------
	-- 블럭상태값.
	--declare @BLOCK_STATE_NO					int					set	@BLOCK_STATE_NO					= 0	-- 블럭상태아님
	declare @BLOCK_STATE_YES					int					set	@BLOCK_STATE_YES				= 1	-- 블럭상태

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

	-- 선물 정의값
	declare @GIFTLIST_GIFT_KIND_MESSAGE			int					set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2
	declare @GIFTLIST_GIFT_KIND_MESSAGE_DEL		int					set @GIFTLIST_GIFT_KIND_MESSAGE_DEL			= -1
	declare @GIFTLIST_GIFT_KIND_GIFT_DEL		int					set @GIFTLIST_GIFT_KIND_GIFT_DEL			= -2
	declare @GIFTLIST_GIFT_KIND_GIFT_GET		int					set @GIFTLIST_GIFT_KIND_GIFT_GET			= -3
	declare @GIFTLIST_GIFT_KIND_GIFT_SELL		int					set @GIFTLIST_GIFT_KIND_GIFT_SELL			= -4

	-- 경작지(수확방식).
	declare @USERSEED_HARVEST_MODE_NORMAL     	int					set @USERSEED_HARVEST_MODE_NORMAL			= 1	-- 일반수확.
	declare @USERSEED_HARVEST_MODE_RIGHTNOW  	int					set @USERSEED_HARVEST_MODE_RIGHTNOW			= 2 -- 즉시수확.
	declare @USERSEED_HARVEST_MODE_GIVEUP  		int					set @USERSEED_HARVEST_MODE_GIVEUP			= 3 -- 버리기.

	-- 기타 상수값
	declare @USERMASTER_UPGRADE_STATE_NON		int					set @USERMASTER_UPGRADE_STATE_NON			= -1	--미진행, 완료중.(유저)
	declare @USERMASTER_UPGRADE_STATE_ING		int					set @USERMASTER_UPGRADE_STATE_ING			= 1		--다음단계진행중.

	-- 경작지(정보).
	declare @USERSEED_NEED_EMPTY				int					set @USERSEED_NEED_EMPTY					= -1	-- (경작지)
	declare @USERSEED_NEED_BUY					int					set @USERSEED_NEED_BUY						= -2
	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @comment			varchar(80)

	declare @gameid 			varchar(60)		set @gameid 		= ''
	declare @blockstate			int
	declare @market				int				set @market			= 1
	declare @cashcost			int				set @cashcost		= 0
	declare @gamecost			int				set @gamecost		= 0
	declare @feed				int				set @feed			= 0
	declare @heart				int				set @heart			= 0
	declare @heartmax			int				set @heartmax		= 0
	declare @feedmax			int				set @feedmax		= 0
	declare @qtfeeduse			int				set @qtfeeduse		= 0
	declare @plusheart			int				set @plusheart		= 0
	declare @plusfeed			int				set @plusfeed		= 0
	declare @tmp				int
	declare @housestep			int,
			@housestate			int,
			@housetime			datetime,
			@housestepmax		int
	declare @curdate			datetime		set @curdate		= getdate()

	declare @seeditemcode		int				set @seeditemcode		= @USERSEED_NEED_BUY
	declare @seedenddate		datetime		set @seedenddate		= getdate() + 10
	declare @seeditemname		varchar(40)		set @seeditemname		= ''
	declare @seedgapsecond		int				set @seedgapsecond		= 0

	declare @harvestcnt			int				set @harvestcnt			= 0
	declare @harvestcashcost	int				set @harvestcashcost	= 99999
	declare @harvestitemcode	int				set @harvestitemcode	= -444

	declare @bresult			int				set @bresult			= -1

	declare @subcategory		int				set @subcategory		= -1
	declare @invenkind			int				set @invenkind			= -1

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	set @comment = 'ERROR 알수없는 오류(-1)'
	--select 'DEBUG 1-0 입력값', @gameid_ gameid_, @password_ password_, @seedidx_ seedidx_, @mode_ mode_

	------------------------------------------------
	--	3-2. 유저정보.
	-- 건초라이프 사이클
	-- 30(0)/30 -> 30개소모, 30개생산 -> 60(30)/30 * 여기서 문제발생
	--                                             > max + (9마리 * 10건초)
	------------------------------------------------
	-- 유저정보.
	select
		@gameid 		= gameid,
		@blockstate 	= blockstate,
		@market			= market,
		@cashcost		= cashcost,
		@gamecost		= gamecost,
		@feed			= feed,
		@feedmax		= feedmax,
		@heart			= heart,
		@heartmax		= heartmax,
		@qtfeeduse		= qtfeeduse,
		@housestep		= housestep,		@housestate		= housestate,		@housetime		= housetime
	from dbo.tFVUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 1-1 유저정보', @gameid gameid, @market market, @cashcost cashcost, @gamecost gamecost, @feed feed, @heart heart, @feedmax feedmax, @heartmax heartmax

	select
		@seeditemcode	= itemcode,
		@seedenddate	= seedenddate
	from dbo.tFVUSerSeed where gameid = @gameid_ and seedidx = @seedidx_
	--select 'DEBUG 1-2 경작지정보', @gameid_ gameid_, @seedidx_ seedidx_, @seeditemcode seeditemcode, getdate() getdate, @seedenddate seedenddate

	---------------------------------------------
	-- 아이템 정보.
	---------------------------------------------
	select
		@seeditemname		= itemname,
		@harvestcnt			= param1,
		@harvestcashcost	= param5,
		@harvestitemcode	= param6
	from dbo.tFVItemInfo
	where subcategory = @ITEM_SUBCATEGORY_SEED and itemcode = @seeditemcode
	--select 'DEBUG 1-3 씨앗정보', @mode_ mode_, @harvestcnt harvestcnt, @harvestcashcost harvestcashcost, @harvestitemcode harvestitemcode

	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '아이디가 존재하지 않는다.'
			--select 'DEBUG ' + @comment
		END
	else if (@blockstate = @BLOCK_STATE_YES)
		BEGIN
			-- 블럭유저인가?
			set @nResult_ 	= @RESULT_ERROR_BLOCK_USER
			set @comment 	= '블럭처리된 아이디입니다.'
		END
	else if(@seeditemcode = @USERSEED_NEED_EMPTY)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '농작물을 정상적으로 수확했습니다.(이미했음1)'
			--select 'DEBUG ' + @comment
		END
	else if(@mode_ = @USERSEED_HARVEST_MODE_RIGHTNOW and getdate() >= @seedenddate)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '농작물을 정상적으로 즉시 완료를 실행 했습니다.'
			--select 'DEBUG ' + @comment
		END
	else if(@harvestitemcode = -444)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_ITEMCODE
			set @comment 	= '정보를 못찾았습니다.'
			--select 'DEBUG ' + @comment
		END
	else if(@mode_ not in(@USERSEED_HARVEST_MODE_NORMAL, @USERSEED_HARVEST_MODE_RIGHTNOW, @USERSEED_HARVEST_MODE_GIVEUP))
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment 	= '지원하지 않는 정보입니다.'
			--select 'DEBUG ' + @comment
		END
	else if(@mode_ = @USERSEED_HARVEST_MODE_NORMAL and getdate() < @seedenddate)
		BEGIN
			select @seedgapsecond = dbo.fnu_GetFVDatePart('ss', @seedenddate, getdate())
			set @nResult_ 	= @RESULT_ERROR_HARVEST_TIME_REMAIN
			set @comment 	= '시간이 남음 ' + @seeditemname + '('+ltrim(rtrim(str(@seeditemcode)))+') 수확남은시간('+ltrim(rtrim(str(-@seedgapsecond)))+'초)'
			--select 'DEBUG ' + @comment

			if(@seedgapsecond < -10)
				begin
					exec spu_FVSubUnusualRecord2 @gameid_, 0, @comment
				end
			set @nResult_ 	= @RESULT_SUCCESS
		END
	else if(@mode_ = @USERSEED_HARVEST_MODE_RIGHTNOW and (@harvestcashcost <= 0 or @harvestcashcost > @cashcost))
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_CASHCOST_LACK
			set @comment 	= '캐쉬비용이 부족합니다.'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 경작지에 수확을 한다.'
			--select 'DEBUG ' + @comment

			--select 'DEBUG 업글(집전)', @housestate housestate, @housestep housestep, @housestepmax housestepmax, @housetime housetime
			if(@housestate = @USERMASTER_UPGRADE_STATE_ING and @curdate >= @housetime)
				begin
					select top 1 @housestepmax = housestepmax from dbo.tFVSystemInfo order by idx desc

					set @housestate = @USERMASTER_UPGRADE_STATE_NON
					set @housestep	= CASE
											WHEN (@housestep + 1 < @housestepmax) THEN @housestep + 1
											ELSE @housestepmax
									  END

					-- 집업글완료 > 건초, 하트 맥스확장.
					select
						@feedmax		= param5,
						@heartmax		= param6
					from dbo.tFVItemInfo
					where subcategory = @ITEM_SUBCATEGORY_UPGRADE_HOUSE and param1 = @housestep
				end
			--select 'DEBUG 업글(집후)', @housestate housestate, @housestep housestep, @housestepmax housestepmax, @housetime housetime


			if(@mode_ = @USERSEED_HARVEST_MODE_GIVEUP)
				begin
					--select 'DEBUG 경작지 일반폐기처리.'
					set @comment = 'SUCCESS 경작지에 수확을 폐기한다.'
					update dbo.tFVUserSeed
						set
							itemcode = @USERSEED_NEED_EMPTY
					where gameid = @gameid_ and seedidx = @seedidx_
				end
			else if(@mode_ = @USERSEED_HARVEST_MODE_NORMAL and getdate() >= @seedenddate)
				begin
					--select 'DEBUG 경작지 일반수확처리.'
					update dbo.tFVUserSeed
						set
							itemcode = @USERSEED_NEED_EMPTY
					where gameid = @gameid_ and seedidx = @seedidx_

					set @bresult = 1

					-- 하단 > 해당아이템지급 or 선물함.
				end
			else if(@mode_ = @USERSEED_HARVEST_MODE_RIGHTNOW and @harvestcashcost <= @cashcost)
				begin
					---------------------------------------------------------------
					--select 'DEBUG 경작지 즉시수확 > 시간만완료.'
					---------------------------------------------------------------
					-- 2. 시간완료만.
					update dbo.tFVUserSeed
						set
							seedenddate = getdate()
					where gameid = @gameid_ and seedidx = @seedidx_

					-- 비용차감.
					set @cashcost	= @cashcost - @harvestcashcost

					-----------------------------------
					-- 구매기록마킹
					-----------------------------------
					exec spu_FVUserItemBuyLog @gameid_, @seeditemcode, 0, @harvestcashcost

					-- > 지급없음
					set @bresult = 0
				end

			-- 해당아이템지급 or 선물함.
			if(@bresult = 1)
				begin
					-- 아이템코드 > 정보 > 분류.
					select
						@subcategory 	= subcategory
					from dbo.tFVItemInfo where itemcode = @harvestitemcode

					set @invenkind = dbo.fnu_GetFVInvenFromSubCategory(@subcategory)
					--select 'DEBUG 아이템정보 ', @subcategory subcategory, @invenkind invenkind

					-- 사용건초계산.
					set @feeduse_ = case
										when @feeduse_ < 0 then (-@feeduse_)
										else @feeduse_
									end

					set @feed 		= @feed - @feeduse_
					set @qtfeeduse 	= @qtfeeduse + @feeduse_

					if(@invenkind in (@USERITEM_INVENKIND_ANI, @USERITEM_INVENKIND_CONSUME, @USERITEM_INVENKIND_ACC))
						begin
							--select 'DEBUG 동물, 소모, 악세 > 선물함'
							exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT, @harvestitemcode, 'SysHarvest', @gameid_, ''				-- 특정아이템 지급

							set @bresult = 2
						end
					--else if(@invenkind in (@ITEM_SUBCATEGORY_CASHCOST, @ITEM_SUBCATEGORY_GAMECOST))
					--	begin
					--		set @bresult = 1
					--	end
					else if(@subcategory = @ITEM_SUBCATEGORY_HEART)
						begin
							--select 'DEBUG 하트 -> 바로적용(Max체크)', @heart heart, @heartmax heartmax, @harvestcnt harvestcnt
							set @tmp 	= @heart
							set @heart 	= case
											when (@heart 				>= @heartmax) then (@heart)
											when (@heart + @harvestcnt  >= @heartmax) then (@heartmax)
											else (@heart + @harvestcnt)
										end
							set @bresult 	= 1
							set @plusheart 	= @harvestcnt
						end
					else if(@subcategory = @ITEM_SUBCATEGORY_FEED)
						begin
							--select 'DEBUG 건초 -> 바로적용', @feed feed, @feedmax feedmax, @harvestcnt harvestcnt
							set @tmp 	= @feed
							set @feed = case
											when (@feed 			   >= @feedmax) then (@feed)
											when (@feed + @harvestcnt  >= @feedmax) then (@feedmax)
											else (@feed + @harvestcnt)
										end

							set @bresult 	= 1
							set @plusfeed 	= @harvestcnt
						end

				end
		END

	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost, @feed feed, @heart heart, @feedmax feedmax, @heartmax heartmax, @bresult bresult
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			-----------------------------------
			-- 유저 정보 반영.
			-----------------------------------
			update dbo.tFVUserMaster
			set
				cashcost		= @cashcost,
				gamecost		= @gamecost,
				feed			= @feed,
				heart			= @heart,
				feedmax			= @feedmax,
				heartmax		= @heartmax,
				housestate 		= @housestate, 		housestep 		= @housestep,

				qtfeeduse		= @qtfeeduse,
				bkheart			= bkheart + @plusheart,
				bkfeed			= bkfeed + @plusfeed

			where gameid = @gameid_

			--------------------------------------------------------------
			-- 경작지 정보.
			--------------------------------------------------------------
			select * from dbo.tFVUserSeed where gameid = @gameid_ and seedidx = @seedidx_

			--------------------------------------------------------------
			-- 선물함정보.
			--------------------------------------------------------------
			if(@bresult = 2)
				begin
					exec spu_FVGiftList @gameid_
				end
		end
	else if(@nResult_ = @RESULT_ERROR_HARVEST_TIME_REMAIN)
		begin
			-----------------------------------
			-- 유저 정보 반영(X).
			-----------------------------------

			--------------------------------------------------------------
			-- 경작지 정보.
			--------------------------------------------------------------
			select * from dbo.tFVUserSeed where gameid = @gameid_ and seedidx = @seedidx_

			--------------------------------------------------------------
			-- 선물함정보.
			--------------------------------------------------------------
			if(@bresult = 2)
				begin
					exec spu_FVGiftList @gameid_
				end
		end

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
End



