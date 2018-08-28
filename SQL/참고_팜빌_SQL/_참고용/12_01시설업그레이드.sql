/*
-----------------------------------------------------
-- 2014-05-15
-- 경작지를 로고 수집만 하는 용도로 변경합니다.(치트 카운터 0)
-----------------------------------------------------
exec spu_FVFacUpgrade 'xxxx2', '049000s1i0n7t8445280', 60, 1, -1		-- 유저없음.
exec spu_FVFacUpgrade 'xxxx2', '049000s1i0n7t8445289', -1, 1, -1		-- 업글없음.
exec spu_FVFacUpgrade 'xxxx2', '049000s1i0n7t8445289', 60,-1, -1		-- 단계없음.

exec spu_FVFacUpgrade 'farm1078959', '2506581j3z1t4e126143', 60, 1, -1		-- 집		(시작).
exec spu_FVFacUpgrade 'farm1078959', '2506581j3z1t4e126143', 60, 2, -1		--			(즉시완료)
exec spu_FVFacUpgrade 'xxxx2', '049000s1i0n7t8445289', 60, 1, -1		-- 집		(시작).
exec spu_FVFacUpgrade 'xxxx2', '049000s1i0n7t8445289', 60, 2, -1		--			(즉시완료)
exec spu_FVFacUpgrade 'xxxx2', '049000s1i0n7t8445289', 61, 1, -1		-- 탱크		(시작).
exec spu_FVFacUpgrade 'xxxx2', '049000s1i0n7t8445289', 61, 2, -1		--			(즉시완료)
exec spu_FVFacUpgrade 'xxxx2', '049000s1i0n7t8445289', 62, 1, -1		-- 저온보관	(시작).
exec spu_FVFacUpgrade 'xxxx2', '049000s1i0n7t8445289', 62, 2, -1		--			(즉시완료)
exec spu_FVFacUpgrade 'xxxx2', '049000s1i0n7t8445289', 63, 1, -1		-- 정화시설	(시작).
exec spu_FVFacUpgrade 'xxxx2', '049000s1i0n7t8445289', 63, 2, -1		--			(즉시완료)
exec spu_FVFacUpgrade 'xxxx2', '049000s1i0n7t8445289', 64, 1, -1		-- 양동이	(시작).
exec spu_FVFacUpgrade 'xxxx2', '049000s1i0n7t8445289', 64, 2, -1		--			(즉시완료)
exec spu_FVFacUpgrade 'xxxx2', '049000s1i0n7t8445289', 65, 1, -1		-- 착유기	(시작).
exec spu_FVFacUpgrade 'xxxx2', '049000s1i0n7t8445289', 65, 2, -1		--			(즉시완료)
exec spu_FVFacUpgrade 'xxxx2', '049000s1i0n7t8445289', 66, 1, -1		-- 주입기	(시작).
exec spu_FVFacUpgrade 'xxxx2', '049000s1i0n7t8445289', 66, 2, -1		--			(즉시완료)
*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVFacUpgrade', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVFacUpgrade;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_FVFacUpgrade
	@gameid_								varchar(60),
	@password_								varchar(20),
	@subcategory_							int,
	@kind_									int,
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
	declare @RESULT_ERROR_RESULT_COPY			int				set @RESULT_ERROR_RESULT_COPY			= -53			-- 결과카피시도
	declare @RESULT_ERROR_GAMECOST_COPY			int				set @RESULT_ERROR_GAMECOST_COPY			= -54			-- 실버카피시도
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- 지원하지않는모드
	declare @RESULT_ERROR_HARVEST_TIME_REMAIN	int				set @RESULT_ERROR_HARVEST_TIME_REMAIN	= -121			-- 아직 시간이 남음.
	declare @RESULT_ERROR_TIME_REMAIN			int				set @RESULT_ERROR_TIME_REMAIN			= -123			-- 아직 시간이 남음.

	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------
	-- 블럭상태값.
	--declare @BLOCK_STATE_NO					int					set	@BLOCK_STATE_NO					= 0	-- 블럭상태아님
	declare @BLOCK_STATE_YES					int					set	@BLOCK_STATE_YES				= 1	-- 블럭상태

	-- 아이템 소분류
	declare @ITEM_SUBCATEGORY_UPGRADE_HOUSE		int					set @ITEM_SUBCATEGORY_UPGRADE_HOUSE 		= 60 -- 집
	declare @ITEM_SUBCATEGORY_UPGRADE_TANK		int					set @ITEM_SUBCATEGORY_UPGRADE_TANK 			= 61 -- 탱크
	declare @ITEM_SUBCATEGORY_UPGRADE_FRESHCOOL	int					set @ITEM_SUBCATEGORY_UPGRADE_FRESHCOOL 	= 62 -- 저온보관
	declare @ITEM_SUBCATEGORY_UPGRADE_PURE		int					set @ITEM_SUBCATEGORY_UPGRADE_PURE 			= 63 -- 정화시설
	declare @ITEM_SUBCATEGORY_UPGRADE_BOTTLE	int					set @ITEM_SUBCATEGORY_UPGRADE_BOTTLE 		= 64 -- 양동이
	declare @ITEM_SUBCATEGORY_UPGRADE_PUMP		int					set @ITEM_SUBCATEGORY_UPGRADE_PUMP 			= 65 -- 착유기
	declare @ITEM_SUBCATEGORY_UPGRADE_TRANSFER	int					set @ITEM_SUBCATEGORY_UPGRADE_TRANSFER 		= 66 -- 주입기

	-- 시설(업그레이드).
	declare @USERMASTER_UPGRADE_STATE_NON		int					set @USERMASTER_UPGRADE_STATE_NON			= -1	--미진행, 완료중.(유저)
	declare @USERMASTER_UPGRADE_STATE_ING		int					set @USERMASTER_UPGRADE_STATE_ING			= 1		--다음단계진행중.

	declare @USERMASTER_UPGRADE_KIND_NEXT		int					set @USERMASTER_UPGRADE_KIND_NEXT			= 1		-- 업그레이드 시작.
	declare @USERMASTER_UPGRADE_KIND_RIGHTNOW	int					set @USERMASTER_UPGRADE_KIND_RIGHTNOW		= 2		-- 업그레이드 즉시완료.

	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @comment			varchar(80)

	declare @gameid 			varchar(60)		set @gameid 		= ''
	declare @blockstate			int
	declare @market				int				set @market			= -1
	declare @cashcost			int				set @cashcost		= 0
	declare @gamecost			int				set @gamecost		= 0
	declare @feedmax			int				set @feedmax		= 10
	declare @heartmax			int				set @heartmax		= 20
	declare @fpointmax			int				set @fpointmax		= 500
	declare @housestep			int				set @housestep 		= 0
	declare @housestate			int				set @housestate 	= @USERMASTER_UPGRADE_STATE_NON
	declare @housetime			datetime		set @housetime		= getdate() + 1
	declare @tankstep			int				set @tankstep 		= 0
	declare @tankstate			int				set @tankstate 		= @USERMASTER_UPGRADE_STATE_NON
	declare @tanktime			datetime		set @tanktime		= getdate() + 1
	declare @bottlestep			int				set @bottlestep 	= 0
	declare @bottlestate		int				set @bottlestate 	= @USERMASTER_UPGRADE_STATE_NON
	declare @bottletime			datetime		set @bottletime		= getdate() + 1
	declare @pumpstep			int				set @pumpstep 		= 0
	declare @pumpstate			int				set @pumpstate 		= @USERMASTER_UPGRADE_STATE_NON
	declare @pumptime			datetime		set @pumptime		= getdate() + 1
	declare @transferstep		int				set @transferstep 	= 0
	declare @transferstate		int				set @transferstate 	= @USERMASTER_UPGRADE_STATE_NON
	declare @transfertime		datetime		set @transfertime		= getdate() + 1
	declare @purestep			int				set @purestep 		= 0
	declare @purestate			int				set @purestate 		= @USERMASTER_UPGRADE_STATE_NON
	declare @puretime			datetime		set @puretime		= getdate() + 1
	declare @freshcoolstep		int				set @freshcoolstep 	= 0
	declare @freshcoolstate		int				set @freshcoolstate = @USERMASTER_UPGRADE_STATE_NON
	declare @freshcooltime		datetime		set @freshcooltime	= getdate() + 1

	declare @housestepmax		int   			set @housestepmax		= -1
	declare @tankstepmax		int             set @tankstepmax		= -1
	declare @bottlestepmax		int             set @bottlestepmax		= -1
	declare @pumpstepmax		int             set @pumpstepmax		= -1
	declare @transferstepmax	int             set @transferstepmax	= -1
	declare @purestepmax		int             set @purestepmax		= -1
	declare @freshcoolstepmax	int             set @freshcoolstepmax	= -1

	declare @itemcodesell		int				set @itemcodesell		= -1
	declare @gamecostsell		int				set @gamecostsell 		= 99999
	declare @cashcostsell		int				set @cashcostsell 		= 99999
	declare @cashcostsell2		int				set @cashcostsell2 		= 99999
	declare @upgradesecond		int				set @upgradesecond		= 9999999
	declare @feedmax2			int				set @feedmax2			= 10
	declare @heartmax2			int				set @heartmax2			= 20
	declare @fpointmax2			int				set @fpointmax2			= 20

	declare @curstep 			int				set @curstep			= 99999
	declare @nextstep 			int				set @nextstep			= 99999
	declare @curstate 			int				set @curstate			= 99999
	declare @curtime 			datetime		set @curtime			= getdate() + 1
	declare @curmax 			int				set @curmax				= 99999
	declare @dummy	 			int
	declare @bchange			int				set @bchange			= 0
	declare @bupgradeistimeover int 			set @bupgradeistimeover	= 0

	declare @itemname			varchar(40)		set @itemname			= ''
	declare @gapsecond			int				set @gapsecond			= 0
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG 입력값', @gameid_ gameid_, @password_ password_, @subcategory_ subcategory_, @kind_ kind_

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	-- 유저정보.
	select
		@gameid 		= gameid,
		@blockstate 	= blockstate,
		@market			= market,
		@cashcost		= cashcost,
		@gamecost		= gamecost,
		@feedmax		= feedmax,
		@heartmax		= heartmax,
		@fpointmax		= fpointmax,
		@housestep		= housestep,		@housestate		= housestate,		@housetime      = housetime,
		@tankstep		= tankstep,			@tankstate		= tankstate,		@tanktime       = tanktime,
		@bottlestep		= bottlestep,		@bottlestate	= bottlestate,		@bottletime     = bottletime,
		@pumpstep		= pumpstep,			@pumpstate		= pumpstate,		@pumptime       = pumptime,
		@transferstep	= transferstep,		@transferstate	= transferstate,	@transfertime   = transfertime,
		@purestep		= purestep,			@purestate		= purestate,		@puretime       = puretime,
		@freshcoolstep	= freshcoolstep,	@freshcoolstate = freshcoolstate,	@freshcooltime  = freshcooltime
	from dbo.tFVUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 1-1 유저정보', @gameid gameid, @market market, @cashcost cashcost, @gamecost gamecost, @housestep housestep, @housestate housestate, @housetime housetime, @tankstep tankstep, @tankstate tankstate, @tanktime tanktime, @bottlestep bottlestep, @bottlestate bottlestate, @bottletime bottletime, @pumpstep pumpstep, @pumpstate pumpstate, @pumptime pumptime, @transferstep transferstep, @transferstate transferstate, @transfertime transfertime, @purestep purestep, @purestate purestate, @puretime puretime, @freshcoolstep freshcoolstep, @freshcoolstate freshcoolstate, @freshcooltime freshcooltime

	---------------------------------------------
	-- tItemInfo(업그레이드정보) > 관리페이지(수집) > tSystemInfo
	---------------------------------------------
	select top 1
		@housestepmax		= housestepmax,
		@tankstepmax		= tankstepmax,
		@bottlestepmax		= bottlestepmax,
		@pumpstepmax		= pumpstepmax,
		@transferstepmax	= transferstepmax,
		@purestepmax		= purestepmax,
		@freshcoolstepmax	= freshcoolstepmax
	from dbo.tFVSystemInfo order by idx desc
	--select 'DEBUG tSystemInfo ', @housestepmax housestepmax, @tankstepmax tankstepmax, @bottlestepmax bottlestepmax, @pumpstepmax pumpstepmax, @transferstepmax transferstepmax, @purestepmax purestepmax, @freshcoolstepmax freshcoolstepmax


	-- 업글정보.
	if(@subcategory_ = @ITEM_SUBCATEGORY_UPGRADE_HOUSE)
		begin
			--select 'DEBUG 1-2 집업글', @housestep housestep, @housestate housestate, @housetime housetime, @housestepmax housestepmax
			set @itemname 	= '집업글'
			set @curstep 	= @housestep
			set @nextstep 	= @housestep + 1
			set @curstate	= @housestate
			set @curtime	= @housetime
			set @curmax		= @housestepmax
		end
	else if(@subcategory_ = @ITEM_SUBCATEGORY_UPGRADE_TANK)
		begin
			--select 'DEBUG 1-3 탱크업글', @tankstep tankstep, @tankstate tankstate, @tanktime tanktime, @tankstepmax tankstepmax
			set @itemname 	= '탱크업글'
			set @curstep 	= @tankstep
			set @nextstep 	= @tankstep + 1
			set @curstate	= @tankstate
			set @curtime	= @tanktime
			set @curmax		= @tankstepmax
		end
	else if(@subcategory_ = @ITEM_SUBCATEGORY_UPGRADE_BOTTLE)
		begin
			--select 'DEBUG 1-4 양동이업글', @bottlestep bottlestep, @bottlestate bottlestate, @bottletime bottletime, @bottlestepmax bottlestepmax
			set @itemname 	= '양동이업글'
			set @curstep 	= @bottlestep
			set @nextstep 	= @bottlestep + 1
			set @curstate	= @bottlestate
			set @curtime	= @bottletime
			set @curmax		= @bottlestepmax
		end
	else if(@subcategory_ = @ITEM_SUBCATEGORY_UPGRADE_PUMP)
		begin
			--select 'DEBUG 1-5 착유기업글', @pumpstep pumpstep, @pumpstate pumpstate, @pumptime pumptime, @pumpstepmax pumpstepmax
			set @itemname 	= '착유기업글'
			set @curstep 	= @pumpstep
			set @nextstep 	= @pumpstep + 1
			set @curstate	= @pumpstate
			set @curtime	= @pumptime
			set @curmax		= @pumpstepmax
		end
	else if(@subcategory_ = @ITEM_SUBCATEGORY_UPGRADE_TRANSFER)
		begin
			--select 'DEBUG 1-6 주입기업글', @transferstep transferstep, @transferstate transferstate, @transfertime transfertime, @transferstepmax transferstepmax
			set @itemname 	= '주입기업글'
			set @curstep 	= @transferstep
			set @nextstep 	= @transferstep + 1
			set @curstate	= @transferstate
			set @curtime	= @transfertime
			set @curmax		= @transferstepmax
		end
	else if(@subcategory_ = @ITEM_SUBCATEGORY_UPGRADE_PURE)
		begin
			--select 'DEBUG 1-7 정화업글', @purestep purestep, @purestate purestate, @puretime puretime, @purestepmax purestepmax
			set @itemname 	= '정화업글'
			set @curstep 	= @purestep
			set @nextstep 	= @purestep + 1
			set @curstate	= @purestate
			set @curtime	= @puretime
			set @curmax		= @purestepmax
		end
	else if(@subcategory_ = @ITEM_SUBCATEGORY_UPGRADE_FRESHCOOL)
		begin
			--select 'DEBUG 1-8 저온보관업글', @freshcoolstep freshcoolstep, @freshcoolstate freshcoolstate, @freshcooltime freshcooltime, @freshcoolstepmax freshcoolstepmax
			set @itemname 	= '저온보관업글'
			set @curstep 	= @freshcoolstep
			set @nextstep 	= @freshcoolstep + 1
			set @curstate	= @freshcoolstate
			set @curtime	= @freshcooltime
			set @curmax		= @freshcoolstepmax
		end
	else
		begin
			--select 'DEBUG 지정되지 않는 업그레이드'
			set @itemname 	= '모름업글'
			set @dummy 		= 0
		end

	------------------------------------------------------
	-- 진행중 and 클라(시간완료) and 다음업글요청 > 다음단계로 변경
	------------------------------------------------------
	if(@kind_ = @USERMASTER_UPGRADE_KIND_NEXT and @curstate = @USERMASTER_UPGRADE_STATE_ING and getdate() >= @curtime)
		begin
			set @curstate	= @USERMASTER_UPGRADE_STATE_NON
			set @curstep 	= @nextstep

			set @nextstep 	= @nextstep + 1
			set @curtime	= getdate()

			-- 타임이 완료되어서 완료 > 집업글시 Max량 변경하기.
			set @bupgradeistimeover	= 1
		end

	------------------------------------------------------
	-- 단계세팅정보.
	------------------------------------------------------
	if(@kind_ = @USERMASTER_UPGRADE_KIND_NEXT)
		begin
			select
				@itemcodesell		= itemcode,
				@cashcostsell		= cashcost,
				@gamecostsell 		= gamecost,
				@cashcostsell2		= param3,
				@upgradesecond		= param4,
				@feedmax2			= case
										when (@subcategory_ = @ITEM_SUBCATEGORY_UPGRADE_HOUSE) then param5
										else @feedmax
									end,
				@heartmax2			= case
										when (@subcategory_ = @ITEM_SUBCATEGORY_UPGRADE_HOUSE) then param6
										else @heartmax
									end,
				@fpointmax2			= case
										when (@subcategory_ = @ITEM_SUBCATEGORY_UPGRADE_HOUSE) then param9
										else @fpointmax
									end
			from dbo.tFVItemInfo
			where subcategory = @subcategory_ and param1 = @nextstep
			--select 'DEBUG > 단계세팅', @subcategory_ subcategory_, @nextstep nextstep, @itemcodesell itemcodesell, @cashcostsell cashcostsell, @gamecostsell gamecostsell, @cashcostsell2 cashcostsell2, @upgradesecond upgradesecond
		end
	else if(@kind_ = @USERMASTER_UPGRADE_KIND_RIGHTNOW)
		begin
			select
				@itemcodesell		= itemcode,
				@cashcostsell		= cashcost,
				@gamecostsell 		= gamecost,
				@cashcostsell2		= param3,
				@upgradesecond		= param4,
				@feedmax2			= case
										when (@subcategory_ = @ITEM_SUBCATEGORY_UPGRADE_HOUSE) then param5
										else @feedmax
									end,
				@heartmax2			= case
										when (@subcategory_ = @ITEM_SUBCATEGORY_UPGRADE_HOUSE) then param6
										else @heartmax
									end,
				@fpointmax2			= case
										when (@subcategory_ = @ITEM_SUBCATEGORY_UPGRADE_HOUSE) then param9
										else @fpointmax
									end
			from dbo.tFVItemInfo
			where subcategory = @subcategory_ and param1 = @nextstep
			--select 'DEBUG > 즉시완료', @subcategory_ subcategory_, @curstep curstep, @itemcodesell itemcodesell, @cashcostsell cashcostsell, @gamecostsell gamecostsell, @cashcostsell2 cashcostsell2, @upgradesecond upgradesecond
		end
	else
		begin
			--select 'DEBUG 지정되지 않는 종류'
			set @dummy 		= 0
		end


	--------------------------------------------------------------
	-- 집업글 > 시간에 의한 완료
	--------------------------------------------------------------
	if(@bupgradeistimeover = 1)
		begin
			if(@subcategory_ = @ITEM_SUBCATEGORY_UPGRADE_HOUSE)
				begin
					set @feedmax		= @feedmax2
					set @heartmax		= @heartmax2
					set @fpointmax		= @fpointmax2
				end
		end


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
	else if(@kind_ = @USERMASTER_UPGRADE_KIND_NEXT and @curstate = @USERMASTER_UPGRADE_STATE_ING and getdate() < @curtime)
		BEGIN
			select @gapsecond = dbo.fnu_GetFVDatePart('ss', @curtime, getdate())

			set @nResult_ 	= @RESULT_ERROR_TIME_REMAIN
			set @comment 	= '시간이 남음 ' + @itemname + '('+ltrim(rtrim(str(@curstep)))+'단계) 남은시간('+ltrim(rtrim(str(-@gapsecond)))+'초)'
			--select 'DEBUG ' + @comment

			if(@gapsecond < -10)
				begin
					exec spu_FVSubUnusualRecord2 @gameid_, 0, @comment
				end
		END
	else if(@subcategory_ not in (@ITEM_SUBCATEGORY_UPGRADE_HOUSE, @ITEM_SUBCATEGORY_UPGRADE_TANK, @ITEM_SUBCATEGORY_UPGRADE_FRESHCOOL, @ITEM_SUBCATEGORY_UPGRADE_PURE, @ITEM_SUBCATEGORY_UPGRADE_BOTTLE, @ITEM_SUBCATEGORY_UPGRADE_PUMP, @ITEM_SUBCATEGORY_UPGRADE_TRANSFER))
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment 	= '지원하지 않는 모드입니다.(1)'
			--select 'DEBUG ' + @comment
		END
	else if(@kind_ not in (@USERMASTER_UPGRADE_KIND_NEXT, @USERMASTER_UPGRADE_KIND_RIGHTNOW))
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment 	= '지원하지 않는 모드입니다.(2)'
			--select 'DEBUG ' + @comment
		END
	else if(@kind_ = @USERMASTER_UPGRADE_KIND_NEXT and @nextstep > @curmax)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_UPGRADE_FULL
			set @comment 	= '업그레이드가 맥스입니다.(next)'
			--select 'DEBUG ' + @comment
		END
	--else if(@kind_ = @USERMASTER_UPGRADE_KIND_RIGHTNOW and @curstep > @curmax)
	--	> 업그레이드(next)에서 검사했으므로 여기는 논리적으로 안옴.
	else if(@itemcodesell = -1 or (@cashcostsell <= 0 and @gamecostsell <= 0))
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_ITEMCODE
			set @comment 	= '업그레이드가 아이템 코드를 찾을 수 없습니다.'
			--select 'DEBUG ' + @comment
		END
	else if(@kind_ = @USERMASTER_UPGRADE_KIND_NEXT and @cashcostsell > 0 and @cashcostsell > @cashcost)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_CASHCOST_LACK
			set @comment 	= '캐쉬비용이 부족합니다.'
			--select 'DEBUG ' + @comment
		END
	else if(@kind_ = @USERMASTER_UPGRADE_KIND_NEXT and @gamecostsell > 0 and @gamecostsell > @gamecost)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_GAMECOST_LACK
			set @comment 	= '코인비용이 부족합니다.'
			--select 'DEBUG ' + @comment
		END
	else if(@kind_ = @USERMASTER_UPGRADE_KIND_RIGHTNOW and @cashcostsell2 > @cashcost)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_CASHCOST_LACK
			set @comment 	= '캐쉬비용이 부족합니다.(2)'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 업그레이드 진행 및 즉시완료.'
			--select 'DEBUG ' + @comment

			if(@kind_ = @USERMASTER_UPGRADE_KIND_NEXT)
				begin
					set @comment = 'SUCCESS 업그레이드 진행.'
					--select 'DEBUG 업그레이드 신청하기'
					if(@curstate = @USERMASTER_UPGRADE_STATE_ING)
						begin
							if(getdate() >= @curtime)
								begin
									--select 'DEBUG > 진행중 > 시간완료 > 업글다음(O)'
									set @curstate 	= @USERMASTER_UPGRADE_STATE_NON
									set @curstep 	= @nextstep

									set @feedmax		= @feedmax2
									set @heartmax		= @heartmax2
									set @fpointmax		= @fpointmax2
								end
							else
								begin
									--select 'DEBUG > 진행중 >          > 업글다음(X)'
									set @curstate 	= @USERMASTER_UPGRADE_STATE_ING
									set @curstep 	= @curstep
								end
						end
					else
						begin
							--select 'DEBUG > 현재완료 > 업글다음(O)'
							set @curstate 	= @USERMASTER_UPGRADE_STATE_NON
							set @curstep 	= @curstep
						end


					set @bchange	= 0
					if(@curstate = @USERMASTER_UPGRADE_STATE_NON and @curstep >= @curmax)
						begin
							--select 'DEBUG > 현재완료 > 맥스업글(더이상 업글없음)'
							set @bchange	= 1
						end
					else if(@curstate = @USERMASTER_UPGRADE_STATE_NON)
						begin
							--select 'DEBUG > 현재완료 > 다음 시설업그레이드'

							-- 캐쉬 or 코인차감 > 하단에서 지급함.
							set @cashcost = @cashcost - @cashcostsell
							set @gamecost = @gamecost - @gamecostsell

							-- 구매기록마킹
							exec spu_FVUserItemBuyLog @gameid_, @itemcodesell, @gamecostsell, @cashcostsell

							set @curstep 	= @curstep
							set @curstate 	= @USERMASTER_UPGRADE_STATE_ING
							set @curtime 	= dateadd(s, @upgradesecond, getdate())

							set @bchange	= 1
						end

					if(@bchange = 1)
						begin
							if(@subcategory_ = @ITEM_SUBCATEGORY_UPGRADE_HOUSE)
								begin
									set @housestep 		= @curstep
									set @housestate		= @curstate
									set @housetime		= @curtime
									--select 'DEBUG 3-2 집업글', @housestep housestep, @housestate housestate, @housetime housetime
								end
							else if(@subcategory_ = @ITEM_SUBCATEGORY_UPGRADE_TANK)
								begin
									set @tankstep 		= @curstep
									set @tankstate		= @curstate
									set @tanktime		= @curtime
									--select 'DEBUG 3-3 탱크업글', @tankstep tankstep, @tankstate tankstate, @tanktime tanktime
								end
							else if(@subcategory_ = @ITEM_SUBCATEGORY_UPGRADE_BOTTLE)
								begin
									set @bottlestep 	= @curstep
									set @bottlestate	= @curstate
									set @bottletime		= @curtime
									--select 'DEBUG 3-4 양동이업글', @bottlestep bottlestep, @bottlestate bottlestate, @bottletime bottletime
								end
							else if(@subcategory_ = @ITEM_SUBCATEGORY_UPGRADE_PUMP)
								begin
									set @pumpstep 		= @curstep
									set @pumpstate		= @curstate
									set @pumptime		= @curtime
									--select 'DEBUG 3-5 착유기업글', @pumpstep pumpstep, @pumpstate pumpstate, @pumptime pumptime
								end
							else if(@subcategory_ = @ITEM_SUBCATEGORY_UPGRADE_TRANSFER)
								begin
									set @transferstep 	= @curstep
									set @transferstate	= @curstate
									set @transfertime	= @curtime
									--select 'DEBUG 3-6 주입기업글', @transferstep transferstep, @transferstate transferstate, @transfertime transfertime
								end
							else if(@subcategory_ = @ITEM_SUBCATEGORY_UPGRADE_PURE)
								begin
									set @purestep 		= @curstep
									set @purestate		= @curstate
									set @puretime		= @curtime
									--select 'DEBUG 3-7 정화업글', @purestep purestep, @purestate purestate, @puretime puretime
								end
							else if(@subcategory_ = @ITEM_SUBCATEGORY_UPGRADE_FRESHCOOL)
								begin
									set @freshcoolstep 	= @curstep
									set @freshcoolstate	= @curstate
									set @freshcooltime	= @curtime
									--select 'DEBUG 3-8 저온보관업글', @freshcoolstep freshcoolstep, @freshcoolstate freshcoolstate, @freshcooltime freshcooltime
								end
						end
				end
			else if(@kind_ = @USERMASTER_UPGRADE_KIND_RIGHTNOW)
				begin
					set @comment = 'SUCCESS 업그레이드 즉시완료.'
					--select 'DEBUG (즉시완료) 업그레이드'
					if(@curstate = @USERMASTER_UPGRADE_STATE_ING)
						begin
							if(getdate() >= @curtime)
								begin
									--select 'DEBUG > (즉시완료) > 시간완료 > 업글완료(X)'
									set @curstate 	= @USERMASTER_UPGRADE_STATE_NON
									set @curstep 	= @curstep

									set @feedmax		= @feedmax2
									set @heartmax		= @heartmax2
									set @fpointmax		= @fpointmax2
								end
							else
								begin
									--select 'DEBUG > (즉시완료) > 진행중… > 업글진행(O)'
									set @curstate 	= @USERMASTER_UPGRADE_STATE_ING
									set @curstep 	= @nextstep

									set @feedmax		= @feedmax2
									set @heartmax		= @heartmax2
									set @fpointmax		= @fpointmax2
								end
						end
					else
						begin
							--select 'DEBUG > (즉시완료) > 현재업글완료(X)'
							set @curstate 	= @USERMASTER_UPGRADE_STATE_NON
							set @curstep 	= @curstep
						end

					if(@curstate = @USERMASTER_UPGRADE_STATE_ING)
						begin
							--select 'DEBUG > (즉시완료) > 업글완료(O)'

							-- 캐쉬 > 하단에서 지급함.
							set @cashcost = @cashcost - @cashcostsell2

							-- 구매기록마킹
							exec spu_FVUserItemBuyLog @gameid_, @itemcodesell, 0, @cashcostsell2

							set @curstep 	= @curstep
							set @curstate 	= @USERMASTER_UPGRADE_STATE_NON
							if(@subcategory_ = @ITEM_SUBCATEGORY_UPGRADE_HOUSE)
								begin
									set @housestep 		= @curstep
									set @housestate		= @curstate
									--select 'DEBUG 4-2 집업글', @housestep housestep, @housestate housestate, @housetime housetime
								end
							else if(@subcategory_ = @ITEM_SUBCATEGORY_UPGRADE_TANK)
								begin
									set @tankstep 		= @curstep
									set @tankstate		= @curstate
									--select 'DEBUG 4-3 탱크업글', @tankstep tankstep, @tankstate tankstate, @tanktime tanktime
								end
							else if(@subcategory_ = @ITEM_SUBCATEGORY_UPGRADE_BOTTLE)
								begin
									set @bottlestep 	= @curstep
									set @bottlestate	= @curstate
									--select 'DEBUG 4-4 양동이업글', @bottlestep bottlestep, @bottlestate bottlestate, @bottletime bottletime
								end
							else if(@subcategory_ = @ITEM_SUBCATEGORY_UPGRADE_PUMP)
								begin
									set @pumpstep 		= @curstep
									set @pumpstate		= @curstate
									--select 'DEBUG 4-5 착유기업글', @pumpstep pumpstep, @pumpstate pumpstate, @pumptime pumptime
								end
							else if(@subcategory_ = @ITEM_SUBCATEGORY_UPGRADE_TRANSFER)
								begin
									set @transferstep 	= @curstep
									set @transferstate	= @curstate
									--select 'DEBUG 4-6 주입기업글', @transferstep transferstep, @transferstate transferstate, @transfertime transfertime
								end
							else if(@subcategory_ = @ITEM_SUBCATEGORY_UPGRADE_PURE)
								begin
									set @purestep 		= @curstep
									set @purestate		= @curstate
									--select 'DEBUG 4-7 정화업글', @purestep purestep, @purestate purestate, @puretime puretime
								end
							else if(@subcategory_ = @ITEM_SUBCATEGORY_UPGRADE_FRESHCOOL)
								begin
									set @freshcoolstep 	= @curstep
									set @freshcoolstate	= @curstate
									--select 'DEBUG 4-8 저온보관업글', @freshcoolstep freshcoolstep, @freshcoolstate freshcoolstate, @freshcooltime freshcooltime
								end
						end
				end


		END

	--------------------------------------------------------------
	-- 코드(캐쉬, 코인, 업그레이드정보)
	--------------------------------------------------------------
	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost, @feedmax feedmax, @heartmax heartmax, @fpointmax fpointmax, @housestep housestep, @housestate housestate, @housetime housetime, @tankstep tankstep, @tankstate tankstate, @tanktime tanktime, @bottlestep bottlestep, @bottlestate bottlestate, @bottletime bottletime, @pumpstep pumpstep, @pumpstate pumpstate, @pumptime pumptime, @transferstep transferstep, @transferstate transferstate, @transfertime transfertime, @purestep purestep, @purestate purestate, @puretime puretime, @freshcoolstep freshcoolstep, @freshcoolstate freshcoolstate, @freshcooltime freshcooltime
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			-----------------------------------
			-- 유저 정보 반영.
			-----------------------------------
			update dbo.tFVUserMaster
				set
					cashcost		= @cashcost,
					gamecost		= @gamecost,
					feedmax			= @feedmax,
					heartmax		= @heartmax,
					fpointmax		= @fpointmax,
					housestep		= @housestep,		housestate		= @housestate, 		housetime      = @housetime,
					tankstep		= @tankstep,		tankstate		= @tankstate, 		tanktime       = @tanktime,
					bottlestep		= @bottlestep,		bottlestate		= @bottlestate, 	bottletime     = @bottletime,
					pumpstep		= @pumpstep,		pumpstate		= @pumpstate, 		pumptime       = @pumptime,
					transferstep	= @transferstep,	transferstate	= @transferstate, 	transfertime   = @transfertime,
					purestep		= @purestep,		purestate		= @purestate, 		puretime       = @puretime,
					freshcoolstep	= @freshcoolstep,	freshcoolstate 	= @freshcoolstate, 	freshcooltime  = @freshcooltime
			where gameid = @gameid_
		end

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
End



