---------------------------------------------------------------
/*
-- 악세 뽑기
delete from dbo.tFVGiftList where gameid in ('xxxx2')
update dbo.tFVUserMaster set famelv = 1, cashcost = 1000 where gameid = 'xxxx2'
exec spu_FVRoulAcc 'xxxx2', '049000s1i0n7t8445289', -1	-- 악세뽑기
*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVRoulAcc', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVRoulAcc;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_FVRoulAcc
	@gameid_				varchar(20),						-- 게임아이디
	@password_				varchar(20),						-- 암호화해서저장, 유저패스워가 해킹당해도 안전
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
	declare @RESULT_ERROR_NO_MORE_ACC			int				set @RESULT_ERROR_NO_MORE_ACC			= -134			-- 더이상 펫이 없다.

	------------------------------------------------
	--	2-2. 정의된값
	------------------------------------------------
	-- 아이템 소분류
	declare @ITEM_SUBCATEGORY_ACC				int					set @ITEM_SUBCATEGORY_ACC 					= 15 -- 악세	(판매[O], 선물[O])

	-- 선물 정의값
	declare @GIFTLIST_GIFT_KIND_MESSAGE			int					set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2

	-- 아이템 획득방법
	declare @DEFINE_HOW_GET_ROULACC				int					set @DEFINE_HOW_GET_ROULACC					= 9	--악세뽑기

	-- 악세 뽑기
	declare @ROUL_ACC_ITEMCODE					int					set @ROUL_ACC_ITEMCODE 						= 50001 	-- 악세사리뽑기코드번호.

	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @comment		varchar(80)
	declare @gameid			varchar(60)		set @gameid			= ''	-- 유저정보.
	declare @cashcost		int				set @cashcost 		= 0
	declare @gamecost		int				set @gamecost 		= 0
	declare @feed			int				set @feed 			= 0
	declare @heart			int				set @heart 			= 0
	declare @fpoint			int				set @fpoint 		= 0
	declare @famelv			int				set @famelv 		= 1

	declare @itemcode		int				set @itemcode		= -1
	declare @itemcode1		int				set @itemcode1		= -1
	declare @itemcode2		int				set @itemcode2		= -1
	declare @itemcode3		int				set @itemcode3		= -1
	declare @itemcode4		int				set @itemcode4		= -1
	declare @itemcode5		int				set @itemcode5		= -1

	declare @rand			int,
			@cnt			int,
			@accmax			int,
			@accrand		int,
			@loop			int

	-- 악세 뽑기 수정가격
	declare @roulaccprice	int				set @roulaccprice 	= 10 -- 10수정.
	declare @roulaccsale	int				set @roulaccsale 	= 10 -- 10%.
Begin
	------------------------------------------------
	--	3-1. 초기화
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
		@feed			= feed,
		@heart			= heart,
		@fpoint			= fpoint,
		@famelv			= famelv
	from dbo.tFVUserMaster where gameid = @gameid_ and password = @password_
	--select 'DEBUG 3-2 유저정보', @gameid gameid, @cashcost cashcost, @famelv famelv

	-- 악세가격 재산정
	select top 1
		@roulaccprice 	= roulaccprice,
		@roulaccsale	= roulaccsale
	from dbo.tFVSystemInfo order by idx desc

	set @roulaccprice = @roulaccprice - (@roulaccprice * @roulaccsale)/100

	------------------------------------------------
	--	3-3. 각상황별로 코드로 분류
	------------------------------------------------
	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR 아이디가 존재하지 않는다.'
			--select 'DEBUG 4' + @comment
		END
	else if(@cashcost < @roulaccprice)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_CASHCOST_LACK
			set @comment 	= 'ERROR 캐쉬가 부족합니다.'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS [뽑기 > NEW]정상 지급 처리합니다.'
			--select 'DEBUG ' + @comment

			-----------------------------------------------------
			-- 임시테이블 생성 > 입력.
			-----------------------------------------------------
			DECLARE @tTempTable TABLE(
				itemcode		int,
				accper			int,
				accmin			int,
				accmax			int
			);

			insert into @tTempTable
			select itemcode, CAST(param7 as int), CAST(param8 as int), CAST(param9 as int) from dbo.tFVItemInfo
			where subcategory = @ITEM_SUBCATEGORY_ACC and playerlv <= @famelv
			order by playerlv asc
			--select 'DEBUG ', * from @tTempTable

			-- 입력된 것 중에서 최고.
			select @accmax = max(accmax) from @tTempTable

			-----------------------------------------------------
			-- 뽑기개수.
			-----------------------------------------------------
			set @rand 	= Convert(int, ceiling(RAND() * 1000))
			set @cnt	= case
								when @rand < 600 then 2
								when @rand < 900 then 3
								when @rand < 980 then 4
								else				  5
						  end
			--select 'DEBUG 뽑기개수', @rand rand, @cnt cnt, @accmax accmax

			-----------------------------------------------------
			-- 랜덤 > 개수출력
			-----------------------------------------------------
			set @loop = 0
			while(@loop < @cnt)
				begin
					-- 랜덤 > 구간(0 <= x < 100)
					set @accrand 	= Convert(int, ceiling(RAND() * (@accmax )))

					select @itemcode = itemcode from @tTempTable
					where accmin <= @accrand and @accrand < accmax

					--select 'DEBUG [뽑기모드]', @itemcode itemcode, @accmax accmax, @accrand accrand

					if(@loop = 0)
						begin
							--select 'DEBUG 1번세팅', @itemcode itemcode
							set @itemcode1 = @itemcode
						end
					else if(@loop = 1)
						begin
							--select 'DEBUG 2번세팅', @itemcode itemcode
							set @itemcode2 = @itemcode
						end
					else if(@loop = 2)
						begin
							--select 'DEBUG 3번세팅', @itemcode itemcode
							set @itemcode3 = @itemcode
						end
					else if(@loop = 3)
						begin
							--select 'DEBUG 4번세팅', @itemcode itemcode
							set @itemcode4 = @itemcode
						end
					else if(@loop = 4)
						begin
							--select 'DEBUG 5번세팅', @itemcode itemcode
							set @itemcode5 = @itemcode
						end

					set @loop = @loop + 1
				end

			------------------------------------------------------------------
			-- 뽑기를 선물함에 넣어주기.
			------------------------------------------------------------------
			--select 'DEBUG 뽑기 선물지급(없으면 자동으로 패스됨)', @itemcode1 itemcode1, @itemcode2 itemcode2, @itemcode3 itemcode3, @itemcode4 itemcode4, @itemcode5 itemcode5
			exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @itemcode1, 'SysAcc', @gameid_, ''
			exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @itemcode2, 'SysAcc', @gameid_, ''
			exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @itemcode3, 'SysAcc', @gameid_, ''
			exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @itemcode4, 'SysAcc', @gameid_, ''
			exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @itemcode5, 'SysAcc', @gameid_, ''

			------------------------------------------------------------------
			-- 캐쉬차감 > 하단에서 적용.
			------------------------------------------------------------------
			--select 'DEBUG [악세뽑기]캐쉬차감(전)', @cashcost cashcost
			set @cashcost = @cashcost - @roulaccprice
			--select 'DEBUG [악세뽑기]캐쉬차감(후)', @cashcost cashcost

			--------------------------------
			-- 구매기록마킹
			--------------------------------
			exec spu_FVUserItemBuyLog @gameid_, @ROUL_ACC_ITEMCODE, 0, @roulaccprice


			--------------------------------
			-- 구매통계자료.
			--------------------------------
			exec spu_FVUserItemAccLog @gameid_, @famelv, @roulaccprice, 0, @itemcode1, @itemcode2, @itemcode3, @itemcode4, @itemcode5

		END




	--------------------------------------------------------------
	-- 	결과전송
	--------------------------------------------------------------
	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost, @feed feed, @heart heart, @fpoint fpoint, @itemcode1 itemcode1, @itemcode2 itemcode2, @itemcode3 itemcode3, @itemcode4 itemcode4, @itemcode5 itemcode5

	if(@nResult_ = @RESULT_SUCCESS)
		begin
			--------------------------------------------------------------
			-- 아이템을 직접 넣어줌
			--------------------------------------------------------------
			update dbo.tFVUserMaster
			set
				cashcost	= @cashcost
			where gameid = @gameid_

			--------------------------------------------------------------
			-- 선물/쪽지 리스트 정보
			--------------------------------------------------------------
			exec spu_FVGiftList @gameid_
		end

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
End

