use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVRoulBuyTest', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVRoulBuyTest;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_FVRoulBuyTest
	@gameid_								varchar(60),					-- 게임아이디
	@password_								varchar(20),					--
	@idx_									int,							--
	@randserial_							varchar(20),					--
	@mode_									int,
	@friendid_								varchar(20),					--
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
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- 지원하지않는모드
	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------
	-- 구매처코드
	declare @MARKET_SKT							int					set @MARKET_SKT						= 1
	--declare @MARKET_KT						int					set @MARKET_KT						= 2
	--declare @MARKET_LGT						int					set @MARKET_LGT						= 3
	declare @MARKET_GOOGLE						int					set @MARKET_GOOGLE					= 5
	declare @MARKET_NHN							int					set @MARKET_NHN						= 6
	declare @MARKET_IPHONE						int					set @MARKET_IPHONE					= 7

	-- 아이템별 인벤분류
	declare @USERITEM_INVENKIND_ANI				int 				set @USERITEM_INVENKIND_ANI					= 1
	declare @USERITEM_INVENKIND_CONSUME			int 				set @USERITEM_INVENKIND_CONSUME				= 3
	declare @USERITEM_INVENKIND_ACC				int 				set @USERITEM_INVENKIND_ACC					= 4
	declare @USERITEM_INVENKIND_DIRECT			int 				set @USERITEM_INVENKIND_DIRECT				= 40
	declare @USERITEM_INVENKIND_INFO			int 				set @USERITEM_INVENKIND_INFO				= 60
	declare @USERITEM_INVENKIND_PET				int 				set @USERITEM_INVENKIND_PET					= 1000

	-- 선물 정의값
	declare @GIFTLIST_GIFT_KIND_MESSAGE			int					set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2
	declare @GIFTLIST_GIFT_KIND_MESSAGE_DEL		int					set @GIFTLIST_GIFT_KIND_MESSAGE_DEL			= -1
	declare @GIFTLIST_GIFT_KIND_GIFT_DEL		int					set @GIFTLIST_GIFT_KIND_GIFT_DEL			= -2
	declare @GIFTLIST_GIFT_KIND_GIFT_GET		int					set @GIFTLIST_GIFT_KIND_GIFT_GET			= -3
	declare @GIFTLIST_GIFT_KIND_GIFT_SELL		int					set @GIFTLIST_GIFT_KIND_GIFT_SELL			= -4

	-- 교배뽑기 상수.
	declare @MODE_ROULETTE_NORMAL				int					set @MODE_ROULETTE_NORMAL					= 1	-- 일반교배.
	declare @MODE_ROULETTE_PREMINUM				int					set @MODE_ROULETTE_PREMINUM					= 2	-- 프리미엄교배.
	declare @CROSS_REWARD_HEART					int					set @CROSS_REWARD_HEART						= 5 -- 교배로 지급되는 상대방하트.
	declare @FRIEND_SYSTEM						varchar(20)			set @FRIEND_SYSTEM							= 'farmgirl'

	declare @ITEM_ROULETTE_NOR_MOTHER			int					set @ITEM_ROULETTE_NOR_MOTHER				= 2200	-- 일반교배뽑기.
	declare @ITEM_ROULETTE_PRE_MOTHER			int					set @ITEM_ROULETTE_PRE_MOTHER				= 2300	-- 프리미엄교배뽑기.
	-------------------------------------------------------------------
	-- Event01 [동물을 찾아라]
	-- 이벤트 기간동안 [빵봉투 산양]을 교배를 통해서 획득한 모든 사람에게 수정 20개를 지급
	-- (해당 여러번 지급되며 프리미엄 교배로만 나옵니다.)
	-- 일 : 2014-05-20 00:01:01 ~ 2014-06-09 23:59:59
	-- 일 : 2014-05-09 00:01:01 ~ 2019-06-25 23:59:59
	-- 얼짱 산양(213)		-> 5017	90수정
	-- 얼짱 양(112) 		-> 5010 20수정
	-- 얼짱 젖소(14)		-> 5009	10수정
	-------------------------------------------------------------------
	declare @EVENT01_START_DAY					datetime			set @EVENT01_START_DAY			= '2014-06-09 01:01'
	declare @EVENT01_END_DAY					datetime			set @EVENT01_END_DAY			= '2014-07-24 23:59'

	declare @EVENT01_CHECK_ITEM					int					set @EVENT01_CHECK_ITEM			= 213		-- -> 5017	90수정
	declare @EVENT02_CHECK_ITEM					int					set @EVENT02_CHECK_ITEM			= 112		-- -> 5010 	20수정
	declare @EVENT03_CHECK_ITEM					int					set @EVENT03_CHECK_ITEM			= 14		-- -> 5009	10수정

	declare @EVENT01_REWARD_ITEM				int					set @EVENT01_REWARD_ITEM		= 5017		-- 90수정
	declare @EVENT02_REWARD_ITEM				int					set @EVENT02_REWARD_ITEM		= 5010		-- 20수정
	declare @EVENT03_REWARD_ITEM				int					set @EVENT03_REWARD_ITEM		= 5009		-- 10수정

	-------------------------------------------------------------
	---- EVENT10
	---- 월드컵 이벤트.
	---- 프리미엄 && 이벤트 기간동안에 특정 동물이 나오도록 한다..
	---- 기간 : 2014-06-13 00:00 ~ 2014-07-14 23:59
	---- 대상 : SKT, Google
	---- 6.23 04:00 한국 vs 알제리
	---- 6.27 05:00 한국 vs 벨기에
	---- 6.18 07:00 한국 vs 러시아
	----  13(15%),  14(25%),  15(50%) 			-> 16	 19
	---- 111(25%), 112(40%), 113(60%), 114(90%) 	-> 115	118
	---- 209(25%), 210(40%), 211(50%), 212(100%) 	-> 215	218
	-------------------------------------------------------------
	--declare @EVENT10_START_DAY				datetime			set @EVENT10_START_DAY			= '2014-06-13 20:00'
	--declare @EVENT10_END_DAY					datetime			set @EVENT10_END_DAY			= '2014-07-14 23:59'
    --
	--declare @EVENT10_OLD_COW					int					set @EVENT10_OLD_COW			= 10	-- 빗살무늬 젖소(10)	신선도 55	대체동물
	--declare @EVENT10_OLD_SHEEP				int					set @EVENT10_OLD_SHEEP			= 111	-- 시크한 검은 양(111)	신선도 75
	--declare @EVENT10_OLD_GOAT					int					set @EVENT10_OLD_GOAT			= 210	-- 빵봉투 산양(210)		신선도 100
    --
	--declare @EVENT10_NEW_COW					int					set @EVENT10_NEW_COW			= 19	-- 이겼 소!(19)			신선도 55 	신규동물
	--declare @EVENT10_NEW_SHEEP				int					set @EVENT10_NEW_SHEEP			= 118	-- 승리한거 양!(118)	신선도 80
	--declare @EVENT10_NEW_GOAT					int					set @EVENT10_NEW_GOAT			= 218	-- 또 이겼 산양~(218)	신선도 100
    --
	--declare @EVENT10_REWARD_COW				int					set @EVENT10_REWARD_COW			= 5125	-- 1500만 코인(5125)
	--declare @EVENT10_REWARD_SHEEP				int					set @EVENT10_REWARD_SHEEP		= 5010	-- 수정 20(5010)
	--declare @EVENT10_REWARD_GOAT				int					set @EVENT10_REWARD_GOAT		= 5012	-- 수정 40(5012)
    --
	--declare @EVENT10_REWARD_COW_NAME			varchar(40)			set @EVENT10_REWARD_COW_NAME	= '이겼 소! 보상'
	--declare @EVENT10_REWARD_SHEEP_NAME		varchar(40)			set @EVENT10_REWARD_SHEEP_NAME	= '승리한거 양! 보상'
	--declare @EVENT10_REWARD_GOAT_NAME			varchar(40)			set @EVENT10_REWARD_GOAT_NAME	= '또 이겼 산양~ 보상'

	-------------------------------------------------------------------
	-- Event03 [프리미엄 > 확률증가 이벤트]
	-- 2014-07-25 ~ 2014-08-06 23:59
	-- 프리미엄 상승, 일반은 해당사항 없음.
	-------------------------------------------------------------------
	declare @EVENT03_START_DAY					datetime			set @EVENT03_START_DAY			= '2014-07-24 01:01'
	declare @EVENT03_END_DAY					datetime			set @EVENT03_END_DAY			= '2014-08-06 23:59'

	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @comment				varchar(512)
	declare @gameid					varchar(60)		set @gameid				= ''
	declare @kakaonickname			varchar(40)		set @kakaonickname		= ''
	declare @market					int				set @market				= 1
	declare @version				int				set @version			= 101
	declare @cashcost				int				set @cashcost			= 0
	declare @gamecost				int				set @gamecost 			= 0
	declare @heart					int				set @heart 				= 0
	declare @feed					int				set @feed 				= 0
	declare @randserial				varchar(20)		set @randserial			= ''
	declare @famelv					int

	declare @itemcode				int				set @itemcode			= -1
	declare @pack1					int				set @pack1				= -1
	declare @pack2					int				set @pack2				= -1
	declare @pack3					int				set @pack3				= -1
	declare @pack4					int				set @pack4				= -1
	declare @pack5					int				set @pack5				= -1
	declare @pack6					int				set @pack6				= -1
	declare @pack7					int				set @pack7				= -1
	declare @pack8					int				set @pack8				= -1
	declare @pack9					int				set @pack9				= -1
	declare @pack10					int				set @pack10				= -1
	declare @pack11					int				set @pack11				= -1
	declare @pack12					int				set @pack12				= -1
	declare @pack13					int				set @pack13				= -1
	declare @pack14					int				set @pack14				= -1
	declare @pack15					int				set @pack15				= -1
	declare @pack16					int				set @pack16				= -1
	declare @pack17					int				set @pack17				= -1
	declare @pack18					int				set @pack18				= -1
	declare @pack19					int				set @pack19				= -1
	declare @pack20					int				set @pack20				= -1
	declare @pack21					int				set @pack21				= -1
	declare @pack22					int				set @pack22				= -1
	declare @pack23					int				set @pack23				= -1
	declare @pack24					int				set @pack24				= -1
	declare @pack25					int				set @pack25				= -1
	declare @pack26					int				set @pack26				= -1
	declare @pack27					int				set @pack27				= -1
	declare @pack28					int				set @pack28				= -1
	declare @pack29					int				set @pack29				= -1
	declare @pack30					int				set @pack30				= -1
	declare @pack31					int				set @pack31				= -1
	declare @pack32					int				set @pack32				= -1
	declare @pack33					int				set @pack33				= -1
	declare @pack34					int				set @pack34				= -1
	declare @pack35					int				set @pack35				= -1
	declare @pack36					int				set @pack36				= -1
	declare @pack37					int				set @pack37				= -1
	declare @pack38					int				set @pack38				= -1
	declare @pack39					int				set @pack39				= -1
	declare @pack40					int				set @pack40				= -1
	declare @cashcostsale			int				set @cashcostsale		= 99999
	declare @roulgamecost			int				set @roulgamecost		= 99999
	declare @roulheart				int				set @roulheart			= 99999

	declare @roul1					int				set @roul1				= -1
	declare @roul2					int				set @roul2				= -1
	declare @roul3					int				set @roul3				= -1
	declare @roul4					int				set @roul4				= -1
	declare @roul5					int				set @roul5				= -1

	declare @group1					int,
			@group2					int,
			@group3					int,
			@group4					int,
			@rand					int,
			@rand2					int,
			@rand3					int,
			@pmroulcnt				int,
			@bgroulcnt				int,
			@cnt					int
	declare @grade					int				set @grade				= 0
	declare @pmticket				int				set @pmticket			= 0
	declare @pmticketcnt			int				set @pmticketcnt		= 0

	declare @gameyear				int				set @gameyear			= 2013
	declare @gamemonth				int				set @gamemonth			= 3

	declare @norlistidx				int				set @norlistidx			= -1
	declare @prelistidx				int				set @prelistidx			= -1
	declare @norcnt					int				set @norcnt				= 0
	declare @precnt					int				set @precnt				= 0

	declare @ticket 				int 			set @ticket 			= 0
	declare @curdate				datetime		set @curdate		= getdate()
	declare @famelvmin 				int 			set @famelvmin 			= 1			-- 로그인(9렙) > 거래후(10렙) 뽑기는 9렙을 적용해준다. ㅠㅠ
	declare @famelvmax 				int 			set @famelvmax 			= 10
	declare @curhour				int				set @curhour			= -1
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG 입력정보', @gameid_ gameid_, @password_ password_, @idx_ idx_, @randserial_ randserial_, @mode_ mode_, @friendid_ friendid_

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	select
		@gameid 		= gameid,
		@kakaonickname 	= kakaonickname,
		@market			= market,
		@version		= version,
		@randserial		= randserial,
		@cashcost		= cashcost,
		@gamecost		= gamecost,
		@heart			= heart,
		@feed			= feed,
		@famelv			= famelv,
		@roul1			= bgroul1,
		@roul2			= bgroul2,
		@roul3			= bgroul3,
		@roul4			= bgroul4,
		@roul5			= bgroul5,
		@pmticketcnt	= pmticketcnt,
		@pmroulcnt		= pmroulcnt,
		@bgroulcnt		= bgroulcnt,
		@gameyear		= gameyear,
		@gamemonth		= gamemonth
	from dbo.tFVUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 유저정보', @gameid gameid, @cashcost cashcost, @gamecost gamecost, @heart heart, @feed feed, @randserial randserial, @roul1 roul1, @roul2 roul2, @roul3 roul3, @roul4 roul4, @roul5 roul5

	-- 유저 보유 일반, 프리미엄.
	if(@mode_ = @MODE_ROULETTE_PREMINUM)
		begin
			select
				@prelistidx		= listidx,
				@precnt 		= cnt
			from dbo.tFVUserItem
			where gameid = @gameid_ and itemcode = @ITEM_ROULETTE_PRE_MOTHER
			--select 'DEBUG 유저 보유 프리미엄', @prelistidx prelistidx, @precnt precnt
		end
	else if(@mode_ = @MODE_ROULETTE_NORMAL)
		begin
			select
				@norlistidx		= listidx,
				@norcnt 		= cnt
			from dbo.tFVUserItem
			where gameid = @gameid_ and itemcode = @ITEM_ROULETTE_NOR_MOTHER
			--select 'DEBUG 유저 보유 일반뽑기', @norlistidx norlistidx, @norcnt norcnt
		end

	----------------------------------------
	-- 뽑기 번호 > 렙별 다시 정렬
	-- 로그인(9렙) > 거래후(10렙) 뽑기는 9렙을 적용해준다. ㅠㅠ
	-- 9렙의 동급의 정보를 다시 정렬 > 다른 인덱스 산출
	----------------------------------------
	select @famelvmin = famelvmin, @famelvmax = famelvmax from dbo.tFVSystemRoulette where idx = @idx_

	--select top 1 @idx_ = idx from dbo.tFVSystemRoulette
	--where famelvmin = @famelvmin
	--	and famelvmax = @famelvmax
	--	and packstate = 1
	--	order by newid()

	----------------------------------------
	-- 뽑기정보.
	----------------------------------------
	select
		@itemcode = itemcode,
		@pack1 = pack1,		@pack2 = pack2,		@pack3 = pack3, 	@pack4 = pack4,		@pack5 = pack5,
		@pack6 = pack6,		@pack7= pack7,		@pack8 = pack8, 	@pack9 = pack9,		@pack10 = pack10,

		@pack11 = pack11,	@pack12 = pack12,	@pack13 = pack13, 	@pack14 = pack14,	@pack15 = pack15,
		@pack16 = pack16,	@pack17= pack17,	@pack18 = pack18, 	@pack19 = pack19,	@pack20 = pack20,

		@pack21 = pack21,	@pack22 = pack22,	@pack23 = pack23, 	@pack24 = pack24,	@pack25 = pack25,
		@pack26 = pack26,	@pack27= pack27,	@pack28 = pack28, 	@pack29 = pack29,	@pack30 = pack30,

		@pack31 = pack31,	@pack32 = pack32,	@pack33 = pack33, 	@pack34 = pack34,	@pack35 = pack35,
		@pack36 = pack36,	@pack37= pack37,	@pack38 = pack38, 	@pack39 = pack39,	@pack40 = pack40,

		@roulgamecost = gamecost,				@roulheart = heart, @cashcostsale = cashcostsale
	from dbo.tFVSystemRoulette
	where famelvmin = @famelvmin
		  and famelvmax = @famelvmax
		  and packstate = 1
		  order by newid()
	--from dbo.tFVSystemRoulette where idx = @idx_
	--select 'DEBUG 뽑기정보', @pack1 pack1, @pack2 pack2, @pack3 pack3, @pack4 pack4, @pack5 pack5, @pack6 pack6, @pack7 pack7, @pack8 pack8, @pack9 pack9, @pack10 pack10, @pack11 pack11, @pack12 pack12, @pack13 pack13, @pack14 pack14, @pack15 pack15, @pack16 pack16, @pack17 pack17, @pack18 pack18, @pack19 pack19, @pack20 pack20, @pack21 pack21, @pack22 pack22, @pack23 pack23, @pack24 pack24, @pack25 pack25, @pack26 pack26, @pack27 pack27, @pack28 pack28, @pack29 pack29, @pack30 pack30, @pack31 pack31, @pack32 pack32, @pack33 pack33, @pack34 pack34, @pack35 pack35, @pack36 pack36, @pack37 pack37, @pack38 pack38, @pack39 pack39, @pack40 pack40, @roulgamecost gamecost, @roulheart heart, @cashcostsale cashcostsale

	------------------------------------------------
	--	3-3. 각상황별로 코드로 분류
	------------------------------------------------
	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR 아이디가 존재하지 않는다.'
			--select 'DEBUG ' + @comment
		END
	else if (@itemcode = -1)
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_ITEMCODE
			set @comment = 'ERROR 코드를 찾을수 없습니다.'
			--select 'DEBUG ' + @comment
		END
	else if (@gameid_ != '' and @gameid_ = @friendid_)
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment = 'ERROR 자신과는 교배가 안됩니다.'
			--select 'DEBUG ' + @comment
		END
	else if (@mode_ not in (@MODE_ROULETTE_NORMAL, @MODE_ROULETTE_PREMINUM))
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment = 'ERROR 지원하지 않는 모드입니다.'
			--select 'DEBUG ' + @comment
		END
	else if (@mode_ = @MODE_ROULETTE_NORMAL and (@gamecost < @roulgamecost and @norcnt <= 0))
		BEGIN
			set @nResult_ = @RESULT_ERROR_GAMECOST_LACK
			set @comment = 'ERROR 게임코인이 부족합니다.'
			--select 'DEBUG ' + @comment
		END
	else if (@mode_ = @MODE_ROULETTE_NORMAL and (@heart < @roulheart and @norcnt <= 0))
		BEGIN
			set @nResult_ = @RESULT_ERROR_HEART_LACK
			set @comment = 'ERROR 하트이 부족하다.'
			--select 'DEBUG ' + @comment
		END
	else if (@mode_ = @MODE_ROULETTE_PREMINUM and (@cashcost < @cashcostsale and @precnt <= 0))
		BEGIN
			set @nResult_ = @RESULT_ERROR_CASHCOST_LACK
			set @comment = 'ERROR 캐쉬가 부족합니다.'
			--select 'DEBUG ' + @comment
		END
	else if (@randserial_ = @randserial)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '교배뽑기 구매하기(2)'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '교배뽑기 구매하기(1)'
			--select 'DEBUG ', @comment

			-- 시간을 얻어오기.
			set @curhour = DATEPART(Hour, getdate())

			--------------------------------
			-- 랜덤하기.
			--------------------------------
			if(@mode_ = @MODE_ROULETTE_PREMINUM)
				begin
					-- 1차모델.
					--set @group1 		= 0 	* 100
					--set @group2		= 83	* 100
					--set @group3		= 14	* 100
					--set @group4		= 3		* 100

					--select 'DEBUG 프리미엄교배.'
					-- 2차 모델 그룹이동.
					set @group1 	=    0
					set @group2		=    0
					set @group3		= 9800
					set @group4		=  200
					if(@curdate >= @EVENT03_START_DAY and @curdate <= @EVENT03_END_DAY)
						begin
							if(@curhour in (12, 18, 23))
								begin
									set @group3		= 9800 - 200
									set @group4		=  200 + 200
								end
						end

					if(@precnt > 0)
						begin
							------------------------
							-- 구매번호.
							------------------------
							exec spu_FVUserItemBuyLog @gameid_, @itemcode,                 0, 0
							exec spu_FVUserItemBuyLog @gameid_, @ITEM_ROULETTE_PRE_MOTHER, 0, 0

							--------------------------------
							-- 일일 정보수집.
							--------------------------------
							exec spu_FVDayLogInfoStatic @market, 22, 1			-- 일 유료뽑기

							---------------------------------
							-- 티켓 > 감소.
							---------------------------------
							set @precnt = @precnt - 1
							set @ticket = 1
							--select 'DEBUG > 프리미엄(0), 캐쉬(x) > 프리미엄(0)', @precnt precnt

							update dbo.tFVUserItem
								set
									cnt = @precnt
							where gameid = @gameid_ and itemcode = @ITEM_ROULETTE_PRE_MOTHER

							-----------------------------------
							---- 출력되는 수량조절.
							-----------------------------------
							if(@pmticketcnt <= 6)		--if(@pmticketcnt <= 0)
								begin
									--select 'DEBUG 티켓 처음'
									set @cnt	= 1
								end
							else
								begin
									--select 'DEBUG 티켓 수량 조절'
									-----------------------------------
									---- 출력되는 수량조절.
									-----------------------------------
									set @rand 		= Convert(int, ceiling(RAND() * 1000))
									set @cnt	= case
													when @rand < 850 then 1
													when @rand < 960 then 2
													when @rand < 990 then 3
													when @rand < 997 then 4
													else				  5
												  end
								end

							set @pmticket = 1
						end
					else
						begin
							------------------------
							-- 구매번호.
							------------------------
							exec spu_FVUserItemBuyLog @gameid_, @itemcode, 0, @cashcostsale

							--------------------------------
							-- 일일 정보수집.
							--------------------------------
							exec spu_FVDayLogInfoStatic @market, 22, 1			-- 일 유료뽑기

							---------------------------------
							-- 캐쉬 > 하단에서 지급함.
							---------------------------------
							set @cashcost = @cashcost 	- @cashcostsale


							-----------------------------------
							---- 출력되는 수량조절.
							-----------------------------------
							set @rand 		= Convert(int, ceiling(RAND() * 1000))
							set @cnt	= case
											when @rand < 850 then 1
											when @rand < 960 then 2
											when @rand < 990 then 3
											when @rand < 997 then 4
											else				  5
										  end
							set @pmticket = 0
						end

				end
			else
				begin
					--select 'DEBUG 일반교배.'
					set @group1 	= 9800
					set @group2		=  200
					set @group3		=    0
					set @group4		=    0

					if(@norcnt > 0)
						begin
							------------------------
							-- 구매번호.
							------------------------
							exec spu_FVUserItemBuyLog @gameid_, @itemcode,                 0, 0
							exec spu_FVUserItemBuyLog @gameid_, @ITEM_ROULETTE_NOR_MOTHER, 0, 0

							--------------------------------
							-- 일일 정보수집.
							--------------------------------
							exec spu_FVDayLogInfoStatic @market, 21, 1				-- 일 일반뽑기

							---------------------------------
							-- 티켓 > 감소.
							---------------------------------
							set @norcnt = @norcnt - 1
							set @ticket = 1
							--select 'DEBUG > 일반뽑기(0), 캐쉬(x) > 일반뽑기(0)', @norcnt norcnt

							update dbo.tFVUserItem
								set
									cnt = @norcnt
							where gameid = @gameid_ and itemcode = @ITEM_ROULETTE_NOR_MOTHER

							---------------------------------
							-- 나올 수량 조절
							---------------------------------
							set @grade = -1
						end
					else
						begin
							------------------------
							-- 구매번호.
							------------------------
							exec spu_FVUserItemBuyLog @gameid_, @itemcode, @roulgamecost, 0

							--------------------------------
							-- 일일 정보수집.
							--------------------------------
							exec spu_FVDayLogInfoStatic @market, 20, @roulheart		-- 일 하트사용수
							exec spu_FVDayLogInfoStatic @market, 21, 1				-- 일 일반뽑기

							---------------------------------
							-- 코인, 하트 > 하단에서 지급함.
							---------------------------------
							set @gamecost 	= @gamecost 	- @roulgamecost
							set @heart 		= @heart 		- @roulheart

							---------------------------------
							-- 나올 수량 조절 > 친구의 동물에 따라서 출력되는 수량조절.
							---------------------------------
							if(@friendid_ = @FRIEND_SYSTEM)
								begin
									set @grade = 0
								end
							else
								begin
									select @grade = param1 from dbo.tFVItemInfo
									where itemcode = (select top 1 itemcode from dbo.tFVUserItem
													  where gameid = @friendid_ and invenkind = @USERITEM_INVENKIND_ANI
														    and listidx = (select top 1 anireplistidx from dbo.tFVUserMaster where gameid = @friendid_))
								end
						end



					-----------------------------------
					---- 출력되는 수량조절.
					-----------------------------------
					set @rand 		= Convert(int, ceiling(RAND() * 1000))
					set @cnt	= case
										when @rand < 850 then 1
										when @rand < 960 then 2
										when @rand < 990 then 3
										when @rand < 997 then 4
										else				  5
								  end
				end

			------------------------------------
			-- 나오는 수량 한개로 조절
			------------------------------------
			--set @cnt = 1

			set @rand 		= Convert(int, ceiling(RAND() * 10000))
			set @rand2		= Convert(int, ceiling(RAND() *    10))
			set @roul1 		= dbo.fnu_GetFVCrossRandom(@rand, @rand2, 	@group1, @group2, @group3, @group4,      @pack1,  @pack2,  @pack3,  @pack4,  @pack5,  @pack6,  @pack7,  @pack8,  @pack9, @pack10,
																												@pack11, @pack12, @pack13, @pack14, @pack15, @pack16, @pack17, @pack18, @pack19, @pack20,
																												@pack21, @pack22, @pack23, @pack24, @pack25, @pack26, @pack27, @pack28, @pack29, @pack30,
																												@pack31, @pack32, @pack33, @pack34, @pack35, @pack36, @pack37, @pack38, @pack39, @pack40)

			set @rand 		= Convert(int, ceiling(RAND() * 10000))
			set @rand2		= Convert(int, ceiling(RAND() *    10))
			set @roul2 		= dbo.fnu_GetFVCrossRandom(@rand, @rand2, 	@group1, @group2, @group3, @group4,     @pack1,  @pack2,  @pack3,  @pack4,  @pack5,  @pack6,  @pack7,  @pack8,  @pack9, @pack10,
																												@pack11, @pack12, @pack13, @pack14, @pack15, @pack16, @pack17, @pack18, @pack19, @pack20,
																												@pack21, @pack22, @pack23, @pack24, @pack25, @pack26, @pack27, @pack28, @pack29, @pack30,
																												@pack31, @pack32, @pack33, @pack34, @pack35, @pack36, @pack37, @pack38, @pack39, @pack40)

			set @rand 		= Convert(int, ceiling(RAND() * 10000))
			set @rand2		= Convert(int, ceiling(RAND() *    10))
			set @roul3 		= dbo.fnu_GetFVCrossRandom(@rand, @rand2, 	@group1, @group2, @group3, @group4,     @pack1,  @pack2,  @pack3,  @pack4,  @pack5,  @pack6,  @pack7,  @pack8,  @pack9, @pack10,
																												@pack11, @pack12, @pack13, @pack14, @pack15, @pack16, @pack17, @pack18, @pack19, @pack20,
																												@pack21, @pack22, @pack23, @pack24, @pack25, @pack26, @pack27, @pack28, @pack29, @pack30,
																												@pack31, @pack32, @pack33, @pack34, @pack35, @pack36, @pack37, @pack38, @pack39, @pack40)

			set @rand 		= Convert(int, ceiling(RAND() * 10000))
			set @rand2		= Convert(int, ceiling(RAND() *    105))
			set @roul4 		= dbo.fnu_GetFVCrossRandom(@rand, @rand2, 	@group1, @group2, @group3, @group4,    @pack1,  @pack2,  @pack3,  @pack4,  @pack5,  @pack6,  @pack7,  @pack8,  @pack9, @pack10,
																												@pack11, @pack12, @pack13, @pack14, @pack15, @pack16, @pack17, @pack18, @pack19, @pack20,
																												@pack21, @pack22, @pack23, @pack24, @pack25, @pack26, @pack27, @pack28, @pack29, @pack30,
																												@pack31, @pack32, @pack33, @pack34, @pack35, @pack36, @pack37, @pack38, @pack39, @pack40)

			set @rand 		= Convert(int, ceiling(RAND() * 10000))
			set @rand2		= Convert(int, ceiling(RAND() *    10))
			set @roul5 		= dbo.fnu_GetFVCrossRandom(@rand, @rand2, 	@group1, @group2, @group3, @group4,    @pack1,  @pack2,  @pack3,  @pack4,  @pack5,  @pack6,  @pack7,  @pack8,  @pack9, @pack10,
																												@pack11, @pack12, @pack13, @pack14, @pack15, @pack16, @pack17, @pack18, @pack19, @pack20,
																												@pack21, @pack22, @pack23, @pack24, @pack25, @pack26, @pack27, @pack28, @pack29, @pack30,
																												@pack31, @pack32, @pack33, @pack34, @pack35, @pack36, @pack37, @pack38, @pack39, @pack40)

			----------------------------------
			-- EVENT10
			-- @@@@ 필터1
			-- 특정 마켓에서는 동물이 안나오도록 한다.
			-- 서비스 : @MARKET_GOOGLE, @MARKET_SKT, @MARKET_IPHONE
			----------------------------------
			--if(@market in (@MARKET_IPHONE))
			--	begin
			--		set @roul1 = case
			--						when @roul1 = @EVENT10_NEW_COW 		then @EVENT10_OLD_COW
			--						when @roul1 = @EVENT10_NEW_SHEEP 	then @EVENT10_OLD_SHEEP
			--						when @roul1 = @EVENT10_NEW_GOAT 	then @EVENT10_OLD_GOAT
			--						else @roul1
			--					end
			--		set @roul2 = case
			--						when @roul2 = @EVENT10_NEW_COW 		then @EVENT10_OLD_COW
			--						when @roul2 = @EVENT10_NEW_SHEEP 	then @EVENT10_OLD_SHEEP
			--						when @roul2 = @EVENT10_NEW_GOAT 	then @EVENT10_OLD_GOAT
			--						else @roul2
			--					end
			--		set @roul3 = case
			--						when @roul3 = @EVENT10_NEW_COW 		then @EVENT10_OLD_COW
			--						when @roul3 = @EVENT10_NEW_SHEEP 	then @EVENT10_OLD_SHEEP
			--						when @roul3 = @EVENT10_NEW_GOAT 	then @EVENT10_OLD_GOAT
			--						else @roul3
			--					end
			--		set @roul4 = case
			--						when @roul4 = @EVENT10_NEW_COW 		then @EVENT10_OLD_COW
			--						when @roul4 = @EVENT10_NEW_SHEEP 	then @EVENT10_OLD_SHEEP
			--						when @roul4 = @EVENT10_NEW_GOAT 	then @EVENT10_OLD_GOAT
			--						else @roul4
			--					end
			--		set @roul5 = case
			--						when @roul5 = @EVENT10_NEW_COW 		then @EVENT10_OLD_COW
			--						when @roul5 = @EVENT10_NEW_SHEEP 	then @EVENT10_OLD_SHEEP
			--						when @roul5 = @EVENT10_NEW_GOAT 	then @EVENT10_OLD_GOAT
			--						else @roul5
			--					end
			--	end
			--else
			--	begin
			--		if(@curdate >= @EVENT10_START_DAY and @curdate <= @EVENT10_END_DAY)
			--			begin
			--				set @rand3	= Convert(int, ceiling(RAND() * 1000))
			--				if(@roul1 in (5, 106, 204, 14, 111, 16, 112, 210, 115))
			--					begin
			--						set @roul1 = case
			--										when @roul1 =  5  and @rand3 < 50		then @EVENT10_NEW_COW	-- 젖소.
			--										when @roul1 = 106 and @rand3 < 50 		then @EVENT10_NEW_COW
			--										when @roul1 = 204 and @rand3 < 50	 	then @EVENT10_NEW_COW
			--										when @roul1 = 14  and @rand3 < 50	 	then @EVENT10_NEW_SHEEP	-- 양.
			--										when @roul1 = 111 and @rand3 < 50	 	then @EVENT10_NEW_SHEEP
			--										when @roul1 = 116 and @rand3 < 50	 	then @EVENT10_NEW_SHEEP
			--										when @roul1 = 112 and @rand3 < 60	 	then @EVENT10_NEW_GOAT	-- 산양.
			--										when @roul1 = 210 and @rand3 < 60	 	then @EVENT10_NEW_GOAT
			--										when @roul1 = 115 and @rand3 < 60	 	then @EVENT10_NEW_GOAT
			--										else @roul1
			--									end
			--					end
            --
			--				if(@roul2 in (5, 106, 204, 14, 111, 16, 112, 210, 115))
			--					begin
			--						set @roul2 = case
			--										when @roul2 =  5  and @rand3 < 50		then @EVENT10_NEW_COW	-- 젖소.
			--										when @roul2 = 106 and @rand3 < 50 		then @EVENT10_NEW_COW
			--										when @roul2 = 204 and @rand3 < 50	 	then @EVENT10_NEW_COW
			--										when @roul2 = 14  and @rand3 < 50	 	then @EVENT10_NEW_SHEEP	-- 양.
			--										when @roul2 = 111 and @rand3 < 50	 	then @EVENT10_NEW_SHEEP
			--										when @roul2 = 116 and @rand3 < 50	 	then @EVENT10_NEW_SHEEP
			--										when @roul2 = 112 and @rand3 < 60	 	then @EVENT10_NEW_GOAT	-- 산양.
			--										when @roul2 = 210 and @rand3 < 60	 	then @EVENT10_NEW_GOAT
			--										when @roul2 = 115 and @rand3 < 60	 	then @EVENT10_NEW_GOAT
			--										else @roul2
			--									end
			--					end
            --
			--				if(@roul3 in (5, 106, 204, 14, 111, 16, 112, 210, 115))
			--					begin
			--						set @roul3 = case
			--										when @roul3 =  5  and @rand3 < 50		then @EVENT10_NEW_COW	-- 젖소.
			--										when @roul3 = 106 and @rand3 < 50 		then @EVENT10_NEW_COW
			--										when @roul3 = 204 and @rand3 < 50	 	then @EVENT10_NEW_COW
			--										when @roul3 = 14  and @rand3 < 50	 	then @EVENT10_NEW_SHEEP	-- 양.
			--										when @roul3 = 111 and @rand3 < 50	 	then @EVENT10_NEW_SHEEP
			--										when @roul3 = 116 and @rand3 < 50	 	then @EVENT10_NEW_SHEEP
			--										when @roul3 = 112 and @rand3 < 60	 	then @EVENT10_NEW_GOAT	-- 산양.
			--										when @roul3 = 210 and @rand3 < 60	 	then @EVENT10_NEW_GOAT
			--										when @roul3 = 115 and @rand3 < 60	 	then @EVENT10_NEW_GOAT
			--										else @roul3
			--									end
			--					end
            --
			--				if(@roul4 in (5, 106, 204, 14, 111, 16, 112, 210, 115))
			--					begin
			--						set @roul4 = case
			--										when @roul4 =  5  and @rand3 < 50		then @EVENT10_NEW_COW	-- 젖소.
			--										when @roul4 = 106 and @rand3 < 50 		then @EVENT10_NEW_COW
			--										when @roul4 = 204 and @rand3 < 50	 	then @EVENT10_NEW_COW
			--										when @roul4 = 14  and @rand3 < 50	 	then @EVENT10_NEW_SHEEP	-- 양.
			--										when @roul4 = 111 and @rand3 < 50	 	then @EVENT10_NEW_SHEEP
			--										when @roul4 = 116 and @rand3 < 50	 	then @EVENT10_NEW_SHEEP
			--										when @roul4 = 112 and @rand3 < 60	 	then @EVENT10_NEW_GOAT	-- 산양.
			--										when @roul4 = 210 and @rand3 < 60	 	then @EVENT10_NEW_GOAT
			--										when @roul4 = 115 and @rand3 < 60	 	then @EVENT10_NEW_GOAT
			--										else @roul4
			--									end
			--					end
            --
			--				if(@roul5 in (5, 106, 204, 14, 111, 16, 112, 210, 115))
			--					begin
			--						set @roul5 = case
			--										when @roul5 =  5  and @rand3 < 50		then @EVENT10_NEW_COW	-- 젖소.
			--										when @roul5 = 106 and @rand3 < 50 		then @EVENT10_NEW_COW
			--										when @roul5 = 204 and @rand3 < 50	 	then @EVENT10_NEW_COW
			--										when @roul5 = 14  and @rand3 < 50	 	then @EVENT10_NEW_SHEEP	-- 양.
			--										when @roul5 = 111 and @rand3 < 50	 	then @EVENT10_NEW_SHEEP
			--										when @roul5 = 116 and @rand3 < 50	 	then @EVENT10_NEW_SHEEP
			--										when @roul5 = 112 and @rand3 < 60	 	then @EVENT10_NEW_GOAT	-- 산양.
			--										when @roul5 = 210 and @rand3 < 60	 	then @EVENT10_NEW_GOAT
			--										when @roul5 = 115 and @rand3 < 60	 	then @EVENT10_NEW_GOAT
			--										else @roul5
			--									end
			--					end
			--			end
			--	end

			----------------------------------
			-- @@@@ 필터2
			-- 24, 25, 26, 27, 28, 29 / 122, 123, 124, 125, 126, 127 / 222, 223, 224, 225, 226, 227
			-- 특정 마켓에서 동물 못나오게 한다.
			-- 서비스 : @MARKET_GOOGLE, @MARKET_SKT, @MARKET_IPHONE, @MARKET_NHN
			----------------------------------
			if(    (@market = @MARKET_SKT    and @version <= 113)
				or (@market = @MARKET_GOOGLE and @version <= 119)
				or (@market = @MARKET_NHN    and @version <= 107)
				or (@market = @MARKET_IPHONE and @version <= 116))
					begin
						set @roul1 = case
										when @roul1 >=  24 and @roul1 <  99	then  15
										when @roul1 >= 122 and @roul1 < 199	then 114
										when @roul1 >= 222 and @roul1 < 299	then 212
										else @roul1
									end
						set @roul2 = case
										when @roul2 >=  24 and @roul2 <  99	then  15
										when @roul2 >= 122 and @roul2 < 199	then 114
										when @roul2 >= 222 and @roul2 < 299	then 212
										else @roul2
									end
						set @roul3 = case
										when @roul3 >=  24 and @roul3 <  99	then  15
										when @roul3 >= 122 and @roul3 < 199	then 114
										when @roul3 >= 222 and @roul3 < 299	then 212
										else @roul3
									end
						set @roul4 = case
										when @roul4 >=  24 and @roul4 <  99	then  15
										when @roul4 >= 122 and @roul4 < 199	then 114
										when @roul4 >= 222 and @roul4 < 299	then 212
										else @roul4
									end
						set @roul5 = case
										when @roul5 >=  24 and @roul5 <  99	then  15
										when @roul5 >= 122 and @roul5 < 199	then 114
										when @roul5 >= 222 and @roul5 < 299	then 212
										else @roul5
									end
					end

			----------------------------------
			-- 개수 제한 하기.
			----------------------------------
			if(@cnt = 1)
				begin
					--set @roul1 		= -1
					set @roul2 			= -1
					set @roul3 			= -1
					set @roul4 			= -1
					set @roul5 			= -1
				end
			else if(@cnt = 2)
				begin
					--set @roul1 		= -1
					--set @roul2 		= -1
					set @roul3 			= -1
					set @roul4 			= -1
					set @roul5 			= -1
				end
			else if(@cnt = 3)
				begin
					--set @roul1 		= -1
					--set @roul2 		= -1
					--set @roul3 		= -1
					set @roul4 			= -1
					set @roul5 			= -1
				end
			else if(@cnt = 4)
				begin
					--set @roul1 		= -1
					--set @roul2 		= -1
					--set @roul3 		= -1
					--set @roul4 		= -1
					set @roul5 			= -1
				end

			--------------------------------------------
			-- 무료뽑기 1,2번, 5번째는 최하만 피하자.
			-- 뽑기템 동물없으면 최소 동물로 세팅.
			--------------------------------------------
			if(@mode_ = @MODE_ROULETTE_PREMINUM)
				begin
					set @pmroulcnt	= @pmroulcnt + 1

					if(@pmticket = 1)
						begin
							set @pmticketcnt = @pmticketcnt + 1
						end
				end
			else
				begin
					set @bgroulcnt	= @bgroulcnt + 1
				end

			if(@mode_ = @MODE_ROULETTE_PREMINUM and @pmticket = 1 and @pmticketcnt <= 1)
				begin
					-- 프리미엄 60 ~ 60 (11, 108, 206)
					-- 60 : 11, 108, 206, 11, 108, 206, 11, 108, 206, 11
					-- 55 : 205, 107, 10, 205, 107, 10, 205, 107, 10, 10
					set @rand 	= Convert(int, ceiling(RAND() * 100))
					set @roul1	= dbo.fnu_GetFVCrossRandom2(@rand, 	205, 107, 10, 205, 107, 10, 205, 107, 10, 10)
				end
			--else if(@mode_ = @MODE_ROULETTE_PREMINUM and @pmticket = 1 and @pmticketcnt <= 6)
			--	begin
			--		-----------------------------------------------------
			--		-- 프리미엄 티켓이 풀려서 제어한다.
			--		-- 5장 선물 지급이 풀림.
			--		-----------------------------------------------------
			--		set @rand 	= Convert(int, ceiling(RAND() * 100))
			--		set @roul1	= dbo.fnu_GetFVCrossRandom2(@rand, 	205, 206, 11, 108, 109, 12, 207, 208, 110, 111)
			--	end
			else if(@mode_ = @MODE_ROULETTE_NORMAL and @bgroulcnt in (1, 2, 5) and @famelv <= 20)
				begin
					if(@famelv <= 10)
						begin
							-- 신선도 15 ~ 25
							set @rand 	= Convert(int, ceiling(RAND() * 100))
							set @roul1	= dbo.fnu_GetFVCrossRandom2(@rand, 	2, 3, 100, 101, 4, 2, 3, 100, 101, 4)
						end
					else
						begin
							-- 신선도 20 ~ 35
							set @rand 	= Convert(int, ceiling(RAND() * 100))
							set @roul1	= dbo.fnu_GetFVCrossRandom2(@rand, 	3, 100, 101, 4, 5, 102, 200, 201, 103, 6)

						end
				end
			else if(not ((@roul1 >= 1 and @roul1 < 299)	or (@roul2 >= 1 and @roul2 < 299)	or (@roul3 >= 1 and @roul3 < 299)	or (@roul4 >= 1 and @roul4 < 299)	or (@roul5 >= 1 and @roul5 < 299)))
					begin
						if(@mode_ = @MODE_ROULETTE_NORMAL)
							begin
								--select 'DEBUG (일반교배)동물이 없어서 초기 동물로 강제세팅('
								set @roul1 = dbo.fnu_GetFVFindAnimal(@mode_, @pack1,  @pack2,  @pack3,  @pack4,  @pack5,  @pack6,  @pack7,  @pack8,  @pack9, @pack10,
																			@pack11, @pack12, @pack13, @pack14, @pack15, @pack16, @pack17, @pack18, @pack19, @pack20,
																			@pack21, @pack22, @pack23, @pack24, @pack25, @pack26, @pack27, @pack28, @pack29, @pack30,
																			@pack31, @pack32, @pack33, @pack34, @pack35, @pack36, @pack37, @pack38, @pack39, @pack40)

							end
						else
							begin
								--select 'DEBUG (프리교배)동물이 없어서 초기 동물로 강제세팅('
								set @roul1 = dbo.fnu_GetFVFindAnimal(@mode_, @pack1,  @pack2,  @pack3,  @pack4,  @pack5,  @pack6,  @pack7,  @pack8,  @pack9, @pack10,
																			@pack11, @pack12, @pack13, @pack14, @pack15, @pack16, @pack17, @pack18, @pack19, @pack20,
																			@pack21, @pack22, @pack23, @pack24, @pack25, @pack26, @pack27, @pack28, @pack29, @pack30,
																			@pack31, @pack32, @pack33, @pack34, @pack35, @pack36, @pack37, @pack38, @pack39, @pack40)
							end
					end
			--if(not 									  ((@roul2 >= 1 and @roul2 < 299)	or (@roul3 >= 1 and @roul3 < 299)	or (@roul4 >= 1 and @roul4 < 299)	or (@roul5 >= 1 and @roul5 < 299)))
			--		begin
			--			set @roul2 = @pack2
			--		end

			------------------------------------------------------------------
			-- 교배뽑기를 선물함에 넣어주기.
			------------------------------------------------------------------
			--select 'DEBUG 교배뽑기 선물지급(없으면 자동으로 패스됨)', @roul1 roul1, @roul2 roul2, @roul3 roul3, @roul4 roul4, @roul5 roul5
			exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @roul5, 'SysRoul', @gameid_, ''
			exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @roul4, 'SysRoul', @gameid_, ''
			exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @roul3, 'SysRoul', @gameid_, ''
			exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @roul2, 'SysRoul', @gameid_, ''
			exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @roul1, 'SysRoul', @gameid_, ''

			------------------------------------------------------------------
			-- 이벤트 날짜 > 특정동물 > 선물지급1
			------------------------------------------------------------------
			--select 'DEBUG ', @curdate curdate, @EVENT01_START_DAY EVENT01_START_DAY, @EVENT01_END_DAY EVENT01_END_DAY, @EVENT01_CHECK_ITEM EVENT01_CHECK_ITEM, @roul1 roul1, @roul2 roul2, @roul3 roul3, @roul4 roul4, @roul5 roul5
			if(@curdate >= @EVENT01_START_DAY and @curdate <= @EVENT01_END_DAY)
				begin
					--select 'DEBUG > 이벤트 기간내'
					if(@EVENT01_CHECK_ITEM in (@roul1, @roul2, @roul3, @roul4, @roul5))
						begin
							--select 'DEBUG > 	-> 5017	90수정'
							exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @EVENT01_REWARD_ITEM, '얼짱 산양보상', @gameid_, ''
						end
					else if(@EVENT02_CHECK_ITEM in (@roul1, @roul2, @roul3, @roul4, @roul5))
						begin
							--select 'DEBUG >  	-> 5010 20수정'
							exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @EVENT02_REWARD_ITEM, '얼짱 양보상', @gameid_, ''
						end
					else if(@EVENT03_CHECK_ITEM in (@roul1, @roul2, @roul3, @roul4, @roul5))
						begin
							--select 'DEBUG > 	-> 5007	 5수정'
							exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @EVENT03_REWARD_ITEM, '얼짱 젖소보상', @gameid_, ''
						end
				end

			--------------------------------------------------------------------
			---- 월드컵 이벤트.
			---- EVENT10
			---- 이벤트 날짜 > 특정동물 > 선물지급2
			--------------------------------------------------------------------
			--if(@curdate >= @EVENT10_START_DAY and @curdate <= @EVENT10_END_DAY)
			--	begin
			--		--select 'DEBUG > 이벤트 기간내2', @EVENT10_START_DAY, @EVENT10_END_DAY
			--		if(@EVENT10_NEW_GOAT in (@roul1, @roul2, @roul3, @roul4, @roul5))
			--			begin
			--				--select 'DEBUG ->', @EVENT10_REWARD_GOAT_NAME, itemname, itemcode from dbo.tFVItemInfo where itemcode = @EVENT10_REWARD_GOAT
			--				exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @EVENT10_REWARD_GOAT, @EVENT10_REWARD_GOAT_NAME, @gameid_, ''
			--			end
			--		else if(@EVENT10_NEW_SHEEP in (@roul1, @roul2, @roul3, @roul4, @roul5))
			--			begin
			--				--select 'DEBUG ->', @EVENT10_REWARD_SHEEP_NAME, itemname, itemcode from dbo.tFVItemInfo where itemcode = @EVENT10_REWARD_SHEEP
			--				exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @EVENT10_REWARD_SHEEP, @EVENT10_REWARD_SHEEP_NAME, @gameid_, ''
			--			end
			--		else if(@EVENT10_NEW_COW in (@roul1, @roul2, @roul3, @roul4, @roul5))
			--			begin
			--				--select 'DEBUG ->', @EVENT10_REWARD_COW_NAME, itemname, itemcode from dbo.tFVItemInfo where itemcode = @EVENT10_REWARD_COW
			--				exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @EVENT10_REWARD_COW, @EVENT10_REWARD_COW_NAME, @gameid_, ''
			--			end
			--	end

			------------------------------------------------------------------
			-- 교배 광고하기.
			------------------------------------------------------------------
			--exec spu_FVRoulAdLog @gameid_, @kakaonickname, @mode_, @roul1, @roul2, @roul3, @roul4, @roul5
			--set @rand3	= Convert(int, ceiling(RAND() * 100))
			--if((@mode_ = @MODE_ROULETTE_PREMINUM) or (@mode_ != @MODE_ROULETTE_PREMINUM and @rand3 < 10))
			--	begin
			--		exec spu_FVRoulAdLog @gameid_, @kakaonickname, @mode_, @roul1, @roul2, @roul3, @roul4, @roul5
			--	end

			------------------------------------------------------------------
			-- 도감기록하기.
			------------------------------------------------------------------
			if(@roul1 != -1)
				begin
					exec spu_FVDogamListLog @gameid_, @roul1
				end
			if(@roul2 != -1)
				begin
					exec spu_FVDogamListLog @gameid_, @roul2
				end
			if(@roul3 != -1)
				begin
					exec spu_FVDogamListLog @gameid_, @roul3
				end
			if(@roul4 != -1)
				begin
					exec spu_FVDogamListLog @gameid_, @roul4
				end
			if(@roul5 != -1)
				begin
					exec spu_FVDogamListLog @gameid_, @roul5
				end

			--------------------------------
			-- 상대방에게 하트선물하기(하트).
			--------------------------------
			update dbo.tFVUserMaster
				set
					heart = case
								when heart >= heartmax 							then heart
								when (heart +  @CROSS_REWARD_HEART) >= heartmax	then heartmax
								else (heart +  @CROSS_REWARD_HEART)
							end,
					heartget = heartget + case
												when heart >= heartmax 							then 0
												when (heart +  @CROSS_REWARD_HEART) >= heartmax	then (heartmax - (heart +  @CROSS_REWARD_HEART))
												else                                                 @CROSS_REWARD_HEART
											end
			where gameid = @friendid_


			--------------------------------
			-- 뽑기 로그 기록.
			-- exec spu_FVUserItemRoulLog 'xxxx2', 1, 1, 60045,  0, 400, 200,	1,   -1, -1, -1, -1, 2013, 3, 'xxxx3'	-- 일반
			-- exec spu_FVUserItemRoulLog 'xxxx2', 2, 1, 60045, 20,   0,   0,	8, 1455, -1, -1, -1, 2013, 3, 'xxxx3'	-- 프리미엄
			--------------------------------
			if(@ticket = 1)
				begin
					set @cashcostsale 	= 0
					set @roulgamecost 	= 0
					set @roulheart 		= 0
				end

			if(@mode_ = @MODE_ROULETTE_PREMINUM)
				begin
					exec spu_FVUserItemRoulLog @gameid_, @mode_, @famelv, @itemcode, @cashcostsale,             0,          0, @roul1, @roul2, @roul3, @roul4, @roul5, @gameyear, @gamemonth, @friendid_
				end
			else
				begin
					exec spu_FVUserItemRoulLog @gameid_, @mode_, @famelv, @itemcode,            0, @roulgamecost, @roulheart, @roul1, @roul2, @roul3, @roul4, @roul5, @gameyear, @gamemonth, @friendid_
				end
		END

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	--select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost, @heart heart, @feed feed, @roul1 roul1, @roul2 roul2, @roul3 roul3, @roul4 roul4, @roul5 roul5

	if(@nResult_ = @RESULT_SUCCESS)
		begin
			-- 아이템을 직접 넣어줌
			update dbo.tFVUserMaster
				set
					randserial	= @randserial_,
					cashcost	= @cashcost,
					gamecost	= @gamecost,
					heart		= @heart,
					feed		= @feed,
					bgroul1		= @roul1,
					bgroul2		= @roul2,
					bgroul3		= @roul3,
					bgroul4		= @roul4,
					bgroul5		= @roul5,
					pmticketcnt	= @pmticketcnt,
					pmroulcnt	= @pmroulcnt,
					bgroulcnt	= @bgroulcnt,
					bkcrossnormal	= bkcrossnormal 	+ case when (@mode_ = @MODE_ROULETTE_NORMAL) 	then 1 else 0 end,
					bkcrosspremium	= bkcrosspremium 	+ case when (@mode_ = @MODE_ROULETTE_PREMINUM) 	then 1 else 0 end
			where gameid = @gameid_

			-------------------------------------------------
			------ 교배뽑기.
			-------------------------------------------------
			--select top 1 * from dbo.tFVSystemRoulette
			--where famelvmin <= @famelv
			--		and @famelv <= famelvmax
			--		and packstate = 1
			--		--and (ABS(CAST( (BINARY_CHECKSUM(*) * RAND()) as int)) % 100) <= 100
			--		--order by newid()
            --
			----------------------------------------------------------------
			---- 선물/쪽지 리스트 정보
			----------------------------------------------------------------
			--exec spu_FVGiftList @gameid_


		end

	set nocount off
End



