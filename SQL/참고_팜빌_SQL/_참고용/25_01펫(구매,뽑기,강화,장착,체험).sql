---------------------------------------------------------------
/*
-- 펫 오늘만 이가격 추천구매.
--update dbo.tFVUserMaster set cashcost = 1000, gamecost = 10000, pettodayitemcode = -1 where gameid = 'xxxx3'
exec spu_FVItemPet 'xxxx2', '049000s1i0n7t8445289', 1, 100000, -1	-- 펫구매(이미구매된것)
exec spu_FVItemPet 'xxxx2', '049000s1i0n7t8445289', 1, 100001, -1

-- 펫 뽑기
exec spu_FVItemPet 'xxxx2', '049000s1i0n7t8445289', 2,     -1, -1	-- 펫뽑기

-- 펫 업글
--update dbo.tFVUserMaster set gamecost = 10000 where gameid = 'xxxx3'
exec spu_FVItemPet 'xxxx2', '049000s1i0n7t8445289', 3,      1, -1	--존재안함
exec spu_FVItemPet 'xxxx2', '049000s1i0n7t8445289', 3,     40, -1

-- 펫 장착
--update dbo.tFVUserMaster set petcooltime = 5 where gameid = 'xxxx3'
exec spu_FVItemPet 'xxxx2', '049000s1i0n7t8445289', 4,     40, -1

-- 펫 체험
--update dbo.tFVUserMaster set pettodayitemcode2 = pettodayitemcode where gameid = 'xxxx2'
exec spu_FVItemPet 'xxxx2', '049000s1i0n7t8445289', 5,     -1, -1
*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVItemPet', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVItemPet;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_FVItemPet
	@gameid_				varchar(60),						-- 게임아이디
	@password_				varchar(20),						-- 암호화해서저장, 유저패스워가 해킹당해도 안전
	@mode_					int,								--
	@paramint_				int,								--
	@nResult_				int					OUTPUT
	--WITH ENCRYPTION
as
	------------------------------------------------
	--	2-1. 코드값
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

	-- 게임중에 부족.
	declare @RESULT_ERROR_HEART_LACK			int				set @RESULT_ERROR_HEART_LACK			= -20			--하트이 부족하다.
	declare @RESULT_ERROR_GAMECOST_LACK			int				set @RESULT_ERROR_GAMECOST_LACK			= -21			--실버가 부족하다.
	declare @RESULT_ERROR_CASHCOST_LACK			int				set @RESULT_ERROR_CASHCOST_LACK			= -22			--골드가 부족하다.
	declare @RESULT_ERROR_ITEM_LACK				int				set @RESULT_ERROR_ITEM_LACK				= -23			--아이템이부족하다.

	-- 아이템 구매, 변경.
	declare @RESULT_ERROR_UPGRADE_FULL			int				set @RESULT_ERROR_UPGRADE_FULL			= -35			--업그레이드가 풀로되었다.

	-- 선물 코드값
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- 아이템코드못찾음
	declare @RESULT_ERROR_GIFTITEM_NOT_FOUND	int				set @RESULT_ERROR_GIFTITEM_NOT_FOUND	= -51			-- 선물아이템을 못찾음
	declare @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	int				set @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	= -52			-- 선물을 이미 가져감
	declare @RESULT_ERROR_NOT_FOUND_GIFTID		int				set @RESULT_ERROR_NOT_FOUND_GIFTID		= -75			-- 캐쉬 > 선물할 아이디를 못찾음

	-- 기타오류
	declare @RESULT_ERROR_RESULT_COPY			int				set @RESULT_ERROR_RESULT_COPY			= -53			-- 결과카피시도
	declare @RESULT_ERROR_GAMECOST_COPY			int				set @RESULT_ERROR_GAMECOST_COPY			= -54			-- 실버카피시도
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- 지원하지않는모드
	declare @RESULT_ERROR_HEART_FULL			int				set @RESULT_ERROR_HEART_FULL			= -71			-- 지원하지않는모드
	declare @RESULT_ERROR_TUTORIAL_ALREADY		int				set @RESULT_ERROR_TUTORIAL_ALREADY		= -73			-- 투토리얼 이미 보상.
	declare @RESULT_ERROR_NOT_FOUND_OTHERID		int				set @RESULT_ERROR_NOT_FOUND_OTHERID		= -83
	declare @RESULT_ERROR_INVEN_FULL			int				set @RESULT_ERROR_INVEN_FULL			= -101			-- 인벤부족
	declare @RESULT_ERROR_NOT_MATCH				int				set @RESULT_ERROR_NOT_MATCH				= -110			-- 무엇인가 매치가 안되었다.
	declare @RESULT_ERROR_DOUBLE_RANDSERIAL		int				set @RESULT_ERROR_DOUBLE_RANDSERIAL		= -111			-- 랜덤시리얼 중복.
	declare @RESULT_ERROR_MAXCOUNT				int				set @RESULT_ERROR_MAXCOUNT				= -112			-- 맥스카운터.
	declare @RESULT_ERROR_ITEMCOST_WRONG		int				set @RESULT_ERROR_ITEMCOST_WRONG		= -113			-- 아이템 가격이 이상함.
	declare @RESULT_ERROR_LISTIDX_NOT_FOUND		int				set @RESULT_ERROR_LISTIDX_NOT_FOUND		= -114			-- 리스트 번호를 못찾음.
	declare @RESULT_ERROR_NO_MORE_PET			int				set @RESULT_ERROR_NO_MORE_PET			= -134			-- 더이상 펫이 없다.

	------------------------------------------------
	--	2-2. 정의된값
	------------------------------------------------
	-- 아이템별 인벤분류
	declare @USERITEM_INVENKIND_ANI				int 				set @USERITEM_INVENKIND_ANI					= 1
	declare @USERITEM_INVENKIND_CONSUME			int 				set @USERITEM_INVENKIND_CONSUME				= 3
	declare @USERITEM_INVENKIND_ACC				int 				set @USERITEM_INVENKIND_ACC					= 4
	declare @USERITEM_INVENKIND_DIRECT			int 				set @USERITEM_INVENKIND_DIRECT				= 40
	declare @USERITEM_INVENKIND_INFO			int 				set @USERITEM_INVENKIND_INFO				= 60
	declare @USERITEM_INVENKIND_PET				int 				set @USERITEM_INVENKIND_PET					= 1000

	-- 아이템 소종류
	declare @ITEM_SUBCATEGORY_PET				int					set @ITEM_SUBCATEGORY_PET					= 1000 	--펫(1000)

	-- 아이템 획득방법
	declare @DEFINE_HOW_GET_FIRST				int					set @DEFINE_HOW_GET_FIRST					= 0	--기본
	declare @DEFINE_HOW_GET_BUY					int					set @DEFINE_HOW_GET_BUY						= 1	--구매
	declare @DEFINE_HOW_GET_SEEDFIELD			int					set @DEFINE_HOW_GET_SEEDFIELD				= 2	--경작
	declare @DEFINE_HOW_GET_ROULETTE			int					set @DEFINE_HOW_GET_ROULETTE				= 3	--교배/뽑기
	declare @DEFINE_HOW_GET_SEARCH				int					set @DEFINE_HOW_GET_SEARCH					= 4	--검색
	declare @DEFINE_HOW_GET_GIFT				int					set @DEFINE_HOW_GET_GIFT					= 5	--선물
	declare @DEFINE_HOW_GET_TODAYBUY			int					set @DEFINE_HOW_GET_TODAYBUY				= 6	--[펫]오늘만판매
	declare @DEFINE_HOW_GET_PETROLL				int					set @DEFINE_HOW_GET_PETROLL					= 7	--[펫]뽑기

	-- 아이템 펫 모드.
	declare @USERITEM_MODE_PET_TODAYBUY			int					set @USERITEM_MODE_PET_TODAYBUY				= 1		-- 오늘만 이가격 추천 구매.
	declare @USERITEM_MODE_PET_ROLL				int					set @USERITEM_MODE_PET_ROLL					= 2		-- 뽑기.
	declare @USERITEM_MODE_PET_UPGRADE			int					set @USERITEM_MODE_PET_UPGRADE				= 3		-- 업급.
	declare @USERITEM_MODE_PET_WEAR				int					set @USERITEM_MODE_PET_WEAR					= 4		-- 장착.
	declare @USERITEM_MODE_PET_EXPERIENCE		int					set @USERITEM_MODE_PET_EXPERIENCE			= 5		-- 체험.

	-- 펫기타 정보
	declare @USERITEM_PET_UPGRADE_MAX			int					set @USERITEM_PET_UPGRADE_MAX				= 6		-- 업그레이드 맥스.

	-- 펫롤모델.
	declare @PET_ROLL_MODE_NON					int					set @PET_ROLL_MODE_NON						= -1	-- 없음(-1)
	declare @PET_ROLL_MODE_NEW					int					set @PET_ROLL_MODE_NEW						= 1		-- 신규(1)
	declare @PET_ROLL_MODE_UPGRADE				int					set @PET_ROLL_MODE_UPGRADE					= 2		-- 업글(2)


	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @comment		varchar(80)
	declare @gameid			varchar(60)		set @gameid			= ''	-- 유저정보.
	declare @cashcost		int				set @cashcost 		= 0
	declare @gamecost		int				set @gamecost 		= 0
	declare @petlistidx		int				set @petlistidx		= -1
	declare @petitemcode	int				set @petitemcode	= -1
	declare @petcooltime	int				set @petcooltime	= 0
	declare @pettodayitemcode int			set @pettodayitemcode = -1
	declare @pettodayitemcode2 int			set @pettodayitemcode2 = -1

	declare @itemcode		int				set @itemcode 			= -1	-- 공통정보.
	declare @petupgrade 	int				set @petupgrade			= 1
	declare @pettodaycashcost int			set @pettodaycashcost 	= 9999	-- 오늘만 구매.
	declare @petrollcashcost int			set @petrollcashcost 	= 9999	-- 뽑기 구매.
	declare @petupgradeinit	int				set @petupgradeinit		= 1
	declare @petrollmode	int				set @petrollmode		= -1	-- 없음(-1), 신규(1), 업글(2)
	declare @petupgradebase	int				set @petupgradebase		= 20000
	declare @petupgradestep	int				set @petupgradestep		= 5000
	declare @petupgradegamecost	int			set @petupgradegamecost	= 25000

	declare @listidx	 	int				set @listidx		= -1
	declare @listidxnew		int				set @listidxnew		= -1
	declare @listidxrtn 	int				set @listidxrtn		= -1
	declare @invenkind		int				set @invenkind		= @USERITEM_INVENKIND_PET
	declare @petmax			int,
			@petrand		int
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	set @comment  = '알수 없는 오류가 발생했습니다.'
	--select 'DEBUG 3-1 입력값', @gameid_ gameid_, @password_ password_, @mode_ mode_, @paramint_ paramint_

	------------------------------------------------
	--	3-2. 연산수행(유저정보, 선물정보, 아이템 종류)
	------------------------------------------------
	select
		@gameid 		= gameid,
		@cashcost		= cashcost,
		@gamecost		= gamecost,

		@petlistidx 	= petlistidx,
		@petitemcode 	= petitemcode,
		@petcooltime	= petcooltime,
		@pettodayitemcode 	= pettodayitemcode,
		@pettodayitemcode2 	= pettodayitemcode2
	from dbo.tFVUserMaster where gameid = @gameid_ and password = @password_
	--select 'DEBUG 3-2 유저정보', @gameid gameid, @cashcost cashcost, @gamecost gamecost, @petlistidx petlistidx, @petitemcode petitemcode, @pettodayitemcode pettodayitemcode

	------------------------------------------------
	--	3-3. 각상황별로 코드로 분류
	------------------------------------------------
	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR 아이디가 존재하지 않는다.'
			--select 'DEBUG 4' + @comment
		END
	else if (@mode_ not in (@USERITEM_MODE_PET_TODAYBUY, @USERITEM_MODE_PET_ROLL, @USERITEM_MODE_PET_UPGRADE, @USERITEM_MODE_PET_WEAR, @USERITEM_MODE_PET_EXPERIENCE))
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment 	= 'ERROR 지원하지 않는 모드입니다.'
			--select 'DEBUG 5' + @comment
		END
	else if (@mode_ = @USERITEM_MODE_PET_EXPERIENCE)
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 체험하기를 했다.'
			--select 'DEBUG 5' + @comment

			set @pettodayitemcode2 = -1
		END
	else if (@mode_ = @USERITEM_MODE_PET_TODAYBUY)
		BEGIN
			set @itemcode = case
								when (@paramint_ != -1) then @paramint_
								else				         @pettodayitemcode
							end
			--select 'DEBUG 6-1 [오늘만 이가격 구매모드]', @itemcode itemcode, @paramint_ paramint_, @pettodayitemcode pettodayitemcode

			select
				@pettodaycashcost	= param1,
				@petupgradeinit		= param5
			from dbo.tFVItemInfo where itemcode = @itemcode and subcategory = @ITEM_SUBCATEGORY_PET
			--select 'DEBUG 6-2 아이템정보(tItemInfo)', @itemcode itemcode, @ITEM_SUBCATEGORY_PET ITEM_SUBCATEGORY_PET, @pettodaycashcost pettodaycashcost, @petupgradeinit petupgradeinit

			if(@itemcode = -1)
				BEGIN
					set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_ITEMCODE
					set @comment = 'ERROR 아이템을 찾을 수 없습니다.'
					--select 'DEBUG ' + @comment
				END
			else if(@cashcost < @pettodaycashcost)
				BEGIN
					set @nResult_ 	= @RESULT_ERROR_CASHCOST_LACK
					set @comment 	= 'ERROR 캐쉬가 부족합니다.'
					--select 'DEBUG ' + @comment
				END
			else if(exists(select top 1 * from dbo.tFVUserItem where gameid = @gameid_ and itemcode = @itemcode and invenkind = @invenkind))
				BEGIN
					set @nResult_ = @RESULT_SUCCESS
					set @comment = 'SUCCESS [오늘만 이가격] 정상 지급 처리합니다(이미구매).'
					--select 'DEBUG ' + @comment

					-- 아이템 리스트인덱스
					select top 1 @listidxrtn = listidx from dbo.tFVUserItem where gameid = @gameid_ and itemcode = @itemcode and invenkind = @invenkind
				END
			else
				BEGIN
					set @nResult_ = @RESULT_SUCCESS
					set @comment = 'SUCCESS [오늘만 이가격] 정상 지급 처리합니다.'
					--select 'DEBUG ' + @comment

					select @listidxnew = isnull(MAX(listidx), 0) + 1 from dbo.tFVUserItem where gameid = @gameid_
					--select 'DEBUG 6-3 인벤 새번호', @listidxnew listidxnew

					---------------------------------------------
					-- 해당아이템 인벤에 지급
					-- 펫구매 > 추가(초기업글)
					-- 캐쉬차감
					-- 구매로그 기록
					-- listidxrtn = new세팅
					-- 오늘만 이가격 정보 클리어(-1)
					---------------------------------------------
					-- 펫구매 > 추가(초기업글)
					insert into dbo.tFVUserItem(gameid,      listidx,   itemcode, cnt,  invenkind,  petupgrade,      gethow)
					values(					 @gameid_, @listidxnew,  @itemcode,   1, @invenkind, @petupgradeinit, @DEFINE_HOW_GET_TODAYBUY)
					--select 'DEBUG 펫구매', @gameid_ gameid_, @listidxnew listidxnew, @itemcode itemcode, @invenkind invenkind, @petupgradeinit petupgradeinit, @DEFINE_HOW_GET_TODAYBUY DEFINE_HOW_GET_TODAYBUY

					-- 펫도감기록.
					--select 'DEBUG 펫도감기록.'
					exec spu_FVDogamListPetLog @gameid_, @itemcode

					-- 캐쉬차감 > 하단에서 적용.
					--select 'DEBUG 캐쉬차감(전)', @cashcost cashcost, @pettodaycashcost pettodaycashcost
					set @cashcost = @cashcost - @pettodaycashcost
					--select 'DEBUG 캐쉬차감(후)', @cashcost cashcost, @pettodaycashcost pettodaycashcost

					-- 구매기록마킹
					exec spu_FVUserItemBuyLog @gameid_, @itemcode, 0, @pettodaycashcost

					-- 오늘만 이가격 정보 클리어(-1)
					set @pettodayitemcode	= -1

					-- 변경된 아이템 리스트인덱스
					set @listidxrtn	= @listidxnew
				END
		END
	else if (@mode_ = @USERITEM_MODE_PET_ROLL)
		BEGIN
			-----------------------------------------------------
			-- [미보유 또는 풀업 아닌것](fun으로 못만듬, newid()때문)
			-- <= 보유템[gameid, 펫, full]아닌것
			--    > iteminfo ran>  펫 뽑기
			-----------------------------------------------------
			-- 1차 랜덤잡기.
			select @petmax	= max(CAST(param10 as int)) from dbo.tFVItemInfo where subcategory = @ITEM_SUBCATEGORY_PET
			set @petrand 	= Convert(int, ceiling(RAND() * @petmax))
			select top 1
				@itemcode 			= itemcode,
				@petrollcashcost	= cashcost,
				@petupgradeinit		= param5
				from
				(
					select
						(ABS(CAST( (BINARY_CHECKSUM(*) * RAND()) as int)) % @petmax) as petrand,
						itemcode,
						cashcost,
						param5
					from dbo.tFVItemInfo
					where subcategory = @ITEM_SUBCATEGORY_PET
						  and itemcode not in ((select itemcode from dbo.tFVUserItem
				  							   where gameid = @gameid_
				  									 and invenkind = @invenkind
				  									 and petupgrade >= @USERITEM_PET_UPGRADE_MAX))
				) b
			where petrand < @petrand
			order by 1 desc
			--select 'DEBUG 1차 랜덤잡기', @itemcode itemcode, @petrollcashcost petrollcashcost, @petupgradeinit petupgradeinit, @petmax petmax, @petrand petrand


			-- 2차 랜덤잡기.
			if(@itemcode = -1)
				BEGIN
					select top 1
						@itemcode 			= itemcode,
						@petrollcashcost	= cashcost,
						@petupgradeinit		= param5
					from dbo.tFVItemInfo
					where subcategory = @ITEM_SUBCATEGORY_PET
						  and itemcode not in ((select itemcode from dbo.tFVUserItem
						  					   where gameid = @gameid_
						  					         and invenkind = @invenkind
						  					         and petupgrade >= @USERITEM_PET_UPGRADE_MAX))
						  order by newid()
					--select 'DEBUG 2차 랜덤잡기', @itemcode itemcode, @petrollcashcost petrollcashcost, @petupgradeinit petupgradeinit, @petmax petmax, @petrand petrand
				END

			--select 'DEBUG [뽑기모드]', @itemcode itemcode, @petrollcashcost petrollcashcost, @petupgradeinit petupgradeinit

			------------------------------------------------------
			-- 뽑기코드(펫) > 보유템 > 해당템의 정보(업글)
			------------------------------------------------------
			if(@itemcode = -1)
				BEGIN
					set @petrollmode = @PET_ROLL_MODE_NON
					--select 'DEBUG [뽑기]더이상없음'
				END
			else
				BEGIN
					set @petupgrade		= -1
					select @petupgrade = petupgrade, @listidx = listidx from dbo.tFVUserItem
					where gameid = @gameid_ and itemcode = @itemcode and invenkind = @invenkind

					if(@petupgrade = -1)
						BEGIN
							set @petrollmode = @PET_ROLL_MODE_NEW
							--select 'DEBUG [뽑기] 신규'
						END
					else
						BEGIN
							set @petrollmode = @PET_ROLL_MODE_UPGRADE
							--select 'DEBUG [뽑기] 업글'
						END
				END


			if(@petrollmode = @PET_ROLL_MODE_NON)
				BEGIN
					set @nResult_ 	= @RESULT_ERROR_NO_MORE_PET
					set @comment = 'ERROR 더이상 펫을 뽑을 수 없습니다.'
					--select 'DEBUG ' + @comment
				END
			else if(@cashcost < @petrollcashcost)
				BEGIN
					set @nResult_ 	= @RESULT_ERROR_CASHCOST_LACK
					set @comment 	= 'ERROR 캐쉬가 부족합니다.'
					--select 'DEBUG ' + @comment
				END
			else
				BEGIN
					if(@petrollmode = @PET_ROLL_MODE_NEW)
						begin
							set @nResult_ = @RESULT_SUCCESS
							set @comment = 'SUCCESS [뽑기 > NEW]정상 지급 처리합니다.'
							--select 'DEBUG ' + @comment

							--------------------------------------
							-- <구매루틴>
							-- 펫구매(초기업글)
							-- 캐쉬차감, 구매로그 기록, listidxrtn = new세팅
							--------------------------------------
							select @listidxnew = isnull(MAX(listidx), 0) + 1 from dbo.tFVUserItem where gameid = @gameid_
							--select 'DEBUG [펫뽑기]인벤 새번호', @listidxnew listidxnew

							-- 펫구매 > 추가(초기업글)
							insert into dbo.tFVUserItem(gameid,      listidx,   itemcode, cnt,  invenkind,  petupgrade,      gethow)
							values(					 @gameid_, @listidxnew,  @itemcode,   1, @invenkind, @petupgradeinit, @DEFINE_HOW_GET_PETROLL)
							--select 'DEBUG [펫뽑기]구매', @gameid_ gameid_, @listidxnew listidxnew, @itemcode itemcode, @invenkind invenkind, @petupgradeinit petupgradeinit, @DEFINE_HOW_GET_PETROLL DEFINE_HOW_GET_PETROLL

							-- 펫도감기록.
							--select 'DEBUG [펫뽑기]펫도감기록.'
							exec spu_FVDogamListPetLog @gameid_, @itemcode

							-- 변경된 아이템 리스트인덱스
							set @listidxrtn	= @listidxnew
						end
					else
						begin
							set @nResult_ = @RESULT_SUCCESS
							set @comment = 'SUCCESS [뽑기 > Upgrade]정상 지급 처리합니다.'
							--select 'DEBUG ' + @comment

							--------------------------------------
							-- <업글> 해당템 업글+1
							--------------------------------------
							update dbo.tFVUserItem
								set
									petupgrade = petupgrade + 1
							where gameid = @gameid_ and listidx = @listidx

							-- 변경된 아이템 리스트인덱스
							set @listidxrtn	= @listidx
						end

					-- 캐쉬차감 > 하단에서 적용.
					--select 'DEBUG [펫뽑기]캐쉬차감(전)', @cashcost cashcost, @petrollcashcost petrollcashcost
					set @cashcost = @cashcost - @petrollcashcost
					--select 'DEBUG [펫뽑기]캐쉬차감(후)', @cashcost cashcost, @petrollcashcost petrollcashcost

					-- 구매기록마킹
					exec spu_FVUserItemBuyLog @gameid_, @itemcode, 0, @petrollcashcost
				END
		END
	else if (@mode_ = @USERITEM_MODE_PET_UPGRADE)
		BEGIN
			set @listidx = @paramint_
			select @itemcode = itemcode, @petupgrade = petupgrade from dbo.tFVUserItem
			where gameid = @gameid_ and listidx = @listidx and invenkind = @invenkind
			--select 'DEBUG [펫업글]', @listidx listidx, @itemcode itemcode, @petupgrade petupgrade

			if(@itemcode != -1 and @petupgrade < @USERITEM_PET_UPGRADE_MAX)
				begin
					select top 1
						@petupgradebase		= param7,
						@petupgradestep		= param8
					from dbo.tFVItemInfo
					where itemcode = @itemcode and subcategory = @ITEM_SUBCATEGORY_PET

					set @petupgradegamecost = @petupgradebase + @petupgrade * @petupgradestep

					--select 'DEBUG [펫업글]', @petupgradebase petupgradebase, @petupgradestep petupgradestep, @gamecost gamecost, @petupgradegamecost petupgradegamecost
				end

			if(@itemcode = -1)
				begin
					set @nResult_ 	= @RESULT_ERROR_LISTIDX_NOT_FOUND
					set @comment 	= 'ERROR 아이템 리스트 번호가 존재하지 않습니다.'
					--select 'DEBUG ' + @comment
				end
			else if(@petupgrade >= @USERITEM_PET_UPGRADE_MAX)
				BEGIN
					set @nResult_ 	= @RESULT_ERROR_UPGRADE_FULL
					set @comment 	= 'ERROR [펫업글]업그레이드가 풀입니다.'
					--select 'DEBUG ' + @comment
				END
			else if(@gamecost < @petupgradegamecost)
				BEGIN
					set @nResult_ 	= @RESULT_ERROR_GAMECOST_LACK
					set @comment 	= 'ERROR 코인이 부족합니다.'
					--select 'DEBUG ' + @comment
				END
			else
				BEGIN
					set @nResult_ = @RESULT_SUCCESS
					set @comment = 'SUCCESS [펫업글]정상 지급 처리합니다.'
					--select 'DEBUG ' + @comment

					--------------------------------------
					-- <업글> 해당템 업글+1
					--------------------------------------
					update dbo.tFVUserItem
						set
							petupgrade = petupgrade + 1
					where gameid = @gameid_ and listidx = @listidx

					-- 변경된 아이템 리스트인덱스
					set @listidxrtn	= @listidx

					-- 캐쉬차감 > 하단에서 적용.
					--select 'DEBUG [펫업글]코인차감(전)', @gamecost gamecost, @petupgradegamecost petupgradegamecost
					set @gamecost = @gamecost - @petupgradegamecost
					--select 'DEBUG [펫업글]코인차감(후)', @gamecost gamecost, @petupgradegamecost petupgradegamecost
				END

		END
	else if (@mode_ = @USERITEM_MODE_PET_WEAR)
		BEGIN
			set @listidx = @paramint_
			select @itemcode = itemcode from dbo.tFVUserItem
			where gameid = @gameid_ and listidx = @listidx and invenkind = @invenkind

			--select 'DEBUG [장착모드]', @listidx listidx, @itemcode itemcode

			if(@itemcode = -1)
				begin
					set @nResult_ 	= @RESULT_ERROR_LISTIDX_NOT_FOUND
					set @comment 	= 'ERROR 아이템 리스트 번호가 존재하지 않습니다.'
					--select 'DEBUG ' + @comment
				end
			else
				begin
					set @nResult_ = @RESULT_SUCCESS
					set @comment = 'SUCCESS [장착]정상 장착 처리합니다.'
					--select 'DEBUG ' + @comment

					------------------------------------
					-- 리스트 번호, 아이템 코드 세팅
					------------------------------------
					set @petlistidx 	= @listidx
					set @petitemcode 	= @itemcode
					set @petcooltime	= 0

					set @listidxrtn		= @petlistidx

					--select 'DEBUG > 펫장착', @petlistidx petlistidx, @petitemcode petitemcode, @listidxrtn listidxrtn
				end
		END


	--------------------------------------------------------------
	-- 	결과전송
	--------------------------------------------------------------
	select @nResult_ rtn, @comment comment

	if(@nResult_ = @RESULT_SUCCESS)
		begin
			--------------------------------------------------------------
			-- 아이템을 직접 넣어줌
			--------------------------------------------------------------
			update dbo.tFVUserMaster
			set
				cashcost	= @cashcost,
				gamecost	= @gamecost,

				petlistidx	= @petlistidx,
				petitemcode	= @petitemcode,
				petcooltime	= @petcooltime,
				pettodayitemcode	= @pettodayitemcode,
				pettodayitemcode2 	= @pettodayitemcode2
			where gameid = @gameid_

			--------------------------------------------------------------
			-- 유저 정보
			--------------------------------------------------------------
			select * from dbo.tFVUserMaster
			where gameid = @gameid_

			--------------------------------------------------------------
			-- 유저 보유 아이템 정보 > 새로 획득한 것만 전송(기존것 하고 같이 보내면 클라것의 데이터를 덮씌워서 문제됨)
			--------------------------------------------------------------
			select * from dbo.tFVUserItem
			where gameid = @gameid_ and listidx = @listidxrtn
		end

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
End

