/*
delete from dbo.tFVGiftList where gameid = 'xxxx2'
update dbo.tFVUserMaster set cashcost = 0, gamecost = 0, heart = 0, randserial = -1 where gameid = 'xxxx3'
update dbo.tFVUserMaster set cashcost = 10000, gamecost = 10000, heart = 50000, randserial = -1 where gameid = 'xxxx2'
exec spu_FVRoulBuy 'xxxx2', '049000s1i0n7t8445289', 1, 7777, 1, 'xxxx3', -1			-- 일반교배  0
exec spu_FVRoulBuy 'xxxx2', '049000s1i0n7t8445289', 1, 7778, 1, 'xxxx4', -1			-- 일반교배  2
exec spu_FVRoulBuy 'xxxx2', '049000s1i0n7t8445289', 1, 7779, 1, 'xxxx5', -1			-- 일반교배 10

delete from dbo.tFVGiftList where gameid = 'xxxx2'
update dbo.tFVUserMaster set cashcost = 0, gamecost = 0, heart = 0, randserial = -1 where gameid = 'xxxx3'
update dbo.tFVUserMaster set cashcost = 10000, gamecost = 10000, heart = 50000, randserial = -1 where gameid = 'xxxx2'
exec spu_FVRoulBuy 'xxxx2', '049000s1i0n7t8445289', 1, 7776, 1, 'xxxx3', -1			-- 일반교배
exec spu_FVRoulBuy 'xxxx2', '049000s1i0n7t8445289', 1, 7777, 2, 'xxxx3', -1			-- 프리미엄교배

--exec spu_FVGiftGain 'xxxx2', '049000s1i0n7t8445289', -3, 23064, -1, -1, -1, -1	-- 프리미엄교배뽑기
update dbo.tFVUserMaster set pmroulcnt = 0, pmticketcnt = 0 where gameid in ('xxxx2', 'xxxx6', 'farm623710809')
delete from dbo.tFVGiftList where gameid in ('xxxx2', 'xxxx6')
update dbo.tFVUserMaster set cashcost = 0, gamecost = 0, heart = 0, heartget = 0, randserial = -1 where gameid = 'xxxx6'
update dbo.tFVUserMaster set cashcost = 10000, gamecost = 10000, heart = 10000, heartget = 0, randserial = -1, pmroulcnt = 0 where gameid = 'xxxx2'
exec spu_FVRoulBuy 'xxxx2', '049000s1i0n7t8445289', 1, 7776, 1, 'xxxx6', -1			-- 일반교배
exec spu_FVRoulBuy 'xxxx2', '049000s1i0n7t8445289', 1, 7777, 2, 'xxxx6', -1			-- 프리미엄교배
exec spu_FVRoulBuy 'xxxx2', '049000s1i0n7t8445289', 1, 7778, 2, 'xxxx6', -1			-- 프리미엄교배

update dbo.tFVUserMaster set cashcost = 10000, gamecost = 10000, heart = 10000, heartget = 0, randserial = -1, pmroulcnt = 0 where gameid = 'farm423576530'
exec spu_FVRoulBuy 'farm423576530', '9790943e2o3w6y383758', 169, JK5K802B1225J95910, 2, 'farm99849864', -1			-- 프리미엄교배
exec spu_FVRoulBuy 'farm423576530', '9790943e2o3w6y383758', 169, JK5K802B1225J95911, 2, 'farm99849864', -1			-- 프리미엄교배
*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVRoulBuy', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVRoulBuy;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_FVRoulBuy
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
	declare @MODE_ROULETTE_PREMINUM_FREE		int					set @MODE_ROULETTE_PREMINUM_FREE			= 3	-- 프리미엄교배(free:내부변수).
	declare @CROSS_REWARD_HEART					int					set @CROSS_REWARD_HEART						= 5 -- 교배로 지급되는 상대방하트.
	declare @FRIEND_SYSTEM						varchar(20)			set @FRIEND_SYSTEM							= 'farmgirl'

	declare @ITEM_ROULETTE_NOR_MOTHER			int					set @ITEM_ROULETTE_NOR_MOTHER				= 2200	-- 일반교배뽑기.
	declare @ITEM_ROULETTE_PRE_MOTHER			int					set @ITEM_ROULETTE_PRE_MOTHER				= 2300	-- 프리미엄교배뽑기.

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
	declare @pmgauage				int				set @pmgauage			= 0
	declare @pmfree					int				set @pmfree				= 0
	declare @grade					int				set @grade				= 0
	declare @pmticket				int				set @pmticket			= 0
	declare @pmticketcnt			int				set @pmticketcnt		= 0

	declare @gameyear				int				set @gameyear			= 2013
	declare @gamemonth				int				set @gamemonth			= 3

	declare @norcnt					int				set @norcnt				= 0
	declare @precnt					int				set @precnt				= 0

	declare @ticket 				int 			set @ticket 			= 0
	declare @curdate				datetime		set @curdate		= getdate()
	declare @famelvmin 				int 			set @famelvmin 			= 1			-- 로그인(9렙) > 거래후(10렙) 뽑기는 9렙을 적용해준다. ㅠㅠ
	declare @famelvmax 				int 			set @famelvmax 			= 10
	declare @curhour				int				set @curhour			= -1

	-- PM동물보상(보상템).
	declare @checkani				int				set @checkani			= -1
	declare @checkreward			int				set @checkreward		= -1

	-- PM동물보상.
	declare @strmarket				varchar(40)
	declare @roulflag				int				set @roulflag			= -1
	declare @roulani1				int				set @roulani1			= -1
	declare @roulani2				int				set @roulani2			= -1
	declare @roulani3				int				set @roulani3			= -1
	declare @roulreward1			int				set @roulreward1		= -1
	declare @roulreward2			int				set @roulreward2		= -1
	declare @roulreward3			int				set @roulreward3		= -1
	declare @roulname1				varchar(20)		set @roulname1			= ''
	declare @roulname2				varchar(20)		set @roulname2			= ''
	declare @roulname3				varchar(20)		set @roulname3			= ''

	-- PM확률상승.
	declare @roultimeflag			int				set @roultimeflag		= -1
	declare @roultimetime1			int				set @roultimetime1		= -1
	declare @roultimetime2			int				set @roultimetime2		= -1
	declare @roultimetime3			int				set @roultimetime3		= -1

	-- PM무료교배.
	declare @pmgauageflag			int				set @pmgauageflag			= -1
	declare @PMGAUAGEPOINT			int				set @PMGAUAGEPOINT			= 10
	declare @PMGAUAGEMAX			int				set @PMGAUAGEMAX			= 100


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
		@pmgauage		= isnull(pmgauage, 0),
		@bgroulcnt		= bgroulcnt,
		@gameyear		= gameyear,
		@gamemonth		= gamemonth
	from dbo.tFVUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 유저정보', @gameid gameid, @cashcost cashcost, @gamecost gamecost, @heart heart, @feed feed, @randserial randserial, @roul1 roul1, @roul2 roul2, @roul3 roul3, @roul4 roul4, @roul5 roul5

	------------------------------------------------
	-- 뽑기 이벤트 정보 가져오기.
	------------------------------------------------
	set @strmarket = '%' + ltrim(rtrim(str(@market))) + '%'
	select
		top 1
		@roulflag 		= case when (@curdate > roulstart and @curdate <= roulend) then roulflag 		else -1 end,
		@roulani1		= roulani1,
		@roulani2		= roulani2,
		@roulani3		= roulani3,
		@roulreward1	= roulreward1,
		@roulreward2	= roulreward2,
		@roulreward3	= roulreward3,
		@roulname1		= roulname1,
		@roulname2		= roulname2,
		@roulname3		= roulname3,
		@roultimeflag	= case when (@curdate > roulstart and @curdate <= roulend) then roultimeflag 	else -1 end,
		@roultimetime1	= roultimetime1,
		@roultimetime2	= roultimetime2,
		@roultimetime3	= roultimetime3,
		@pmgauageflag	= case when (@curdate > roulstart and @curdate <= roulend) then pmgauageflag 	else -1 end,
		@PMGAUAGEPOINT	= pmgauagepoint,
		@PMGAUAGEMAX	= pmgauagemax
	from dbo.tFVSystemRouletteMan
	where roulmarket like @strmarket
	order by idx desc

	------------------------------------------------
	-- 유저 보유 일반, 프리미엄.
	------------------------------------------------
	if(@mode_ = @MODE_ROULETTE_PREMINUM)
		begin
			select
				@precnt 		= cnt
			from dbo.tFVUserItem
			where gameid = @gameid_ and itemcode = @ITEM_ROULETTE_PRE_MOTHER
			--select 'DEBUG 유저 보유 프리미엄', @precnt precnt, @pmgauage pmgauage

			-- 프리미엄 일정수량 할 경우 > 무료로 돌리기.)
			if(@pmgauageflag = 1)
				begin
					if(@randserial_ != @randserial)
						begin
							if(@pmgauage < @PMGAUAGEMAX)
								begin
									--select 'DEBUG 프리미엄 누적'
									set @pmgauage 	= @pmgauage + @PMGAUAGEPOINT
								end
							else
								begin
									--select 'DEBUG 프리미엄 무료'
									--set @pmgauage 	= @pmgauage - @PMGAUAGEMAX			-- 남아서 계속빠진다.
									set @pmgauage 	= 0										-- 한꺼번에 비워버리자.
									set @precnt		= @precnt + 1
									set @pmfree		= 1
								end
						end
				end
		end
	else if(@mode_ = @MODE_ROULETTE_NORMAL)
		begin
			select
				@norcnt 		= cnt
			from dbo.tFVUserItem
			where gameid = @gameid_ and itemcode = @ITEM_ROULETTE_NOR_MOTHER
			--select 'DEBUG 유저 보유 일반뽑기', @norcnt norcnt
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

					--select 'DEBUG 프리미엄교배.', @roultimeflag roultimeflag
					-- 2차 모델 그룹이동.
					set @group1 	=    0
					set @group2		=    0
					set @group3		= 9800
					set @group4		=  200
					if(@roultimeflag = 1)
						begin
							--select 'DEBUG 교배확률 상승', @roultimetime1 roultimetime1, @roultimetime2 roultimetime2, @roultimetime3 roultimetime3
							if(@curhour in (@roultimetime1, @roultimetime2, @roultimetime3))
								begin
									--select 'DEBUG > 적용시간됨'
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
										when @roul1 >=  24 and @roul1 <  27	then  21
										when @roul1 >=  27 and @roul1 <  99	then  23
										when @roul1 >= 122 and @roul1 < 125	then 120
										when @roul1 >= 125 and @roul1 < 199	then 121
										when @roul1 >= 222 and @roul1 < 225	then 220
										when @roul1 >= 225 and @roul1 < 299	then 221
										else @roul1
									end
						set @roul2 = case
										when @roul2 >=  24 and @roul2 <  27	then  21
										when @roul2 >=  27 and @roul2 <  99	then  23
										when @roul2 >= 122 and @roul2 < 125	then 120
										when @roul2 >= 125 and @roul2 < 199	then 121
										when @roul2 >= 222 and @roul2 < 225	then 220
										when @roul2 >= 225 and @roul2 < 299	then 221
										else @roul2
									end
						set @roul3 = case
										when @roul3 >=  24 and @roul3 <  27	then  21
										when @roul3 >=  27 and @roul3 <  99	then  23
										when @roul3 >= 122 and @roul3 < 125	then 120
										when @roul3 >= 125 and @roul3 < 199	then 121
										when @roul3 >= 222 and @roul3 < 225	then 220
										when @roul3 >= 225 and @roul3 < 299	then 221
										else @roul3
									end
						set @roul4 = case
										when @roul4 >=  24 and @roul4 <  27	then  21
										when @roul4 >=  27 and @roul4 <  99	then  23
										when @roul4 >= 122 and @roul4 < 125	then 120
										when @roul4 >= 125 and @roul4 < 199	then 121
										when @roul4 >= 222 and @roul4 < 225	then 220
										when @roul4 >= 225 and @roul4 < 299	then 221
										else @roul4
									end
						set @roul5 = case
										when @roul5 >=  24 and @roul5 <  27	then  21
										when @roul5 >=  27 and @roul5 <  99	then  23
										when @roul5 >= 122 and @roul5 < 125	then 120
										when @roul5 >= 125 and @roul5 < 199	then 121
										when @roul5 >= 222 and @roul5 < 225	then 220
										when @roul5 >= 225 and @roul5 < 299	then 221
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
			if(@roulflag = 1)
				begin
					--select 'DEBUG > 이벤트 기간내'
					if(@roulani1 in (@roul1, @roul2, @roul3, @roul4, @roul5))
						begin
							--select 'DEBUG > 	-> 특정동물 보상1'
							exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @roulreward1, @roulname1, @gameid_, ''
							set @checkani 		= @roulani1
							set @checkreward 	= @roulreward1
						end
					else if(@roulani2 in (@roul1, @roul2, @roul3, @roul4, @roul5))
						begin
							--select 'DEBUG >  	-> 특정동물 보상2'
							exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @roulreward2, @roulname2, @gameid_, ''
							set @checkani 		= @roulani2
							set @checkreward 	= @roulreward2
						end
					else if(@roulani3 in (@roul1, @roul2, @roul3, @roul4, @roul5))
						begin
							--select 'DEBUG > 	-> 특정동물 보상3'
							exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @roulreward3, @roulname3, @gameid_, ''
							set @checkani 		= @roulani3
							set @checkreward 	= @roulreward3
						end
				end

			------------------------------------------------------------------
			-- 교배 광고하기.
			------------------------------------------------------------------
			exec spu_FVRoulAdLog @gameid_, @kakaonickname, @mode_, @roul1, @roul2, @roul3, @roul4, @roul5
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
					if(@pmfree = 1)
						begin
							exec spu_FVUserItemRoulLog @gameid_, @MODE_ROULETTE_PREMINUM_FREE, @famelv, @itemcode,             0,             0,          0, @roul1, @roul2, @roul3, @roul4, @roul5, @gameyear, @gamemonth, @friendid_
						end
					else
						begin
							exec spu_FVUserItemRoulLog @gameid_,                       @mode_, @famelv, @itemcode, @cashcostsale,             0,          0, @roul1, @roul2, @roul3, @roul4, @roul5, @gameyear, @gamemonth, @friendid_
						end
				end
			else
				begin
					exec spu_FVUserItemRoulLog @gameid_, @mode_, @famelv, @itemcode,            0, @roulgamecost, @roulheart, @roul1, @roul2, @roul3, @roul4, @roul5, @gameyear, @gamemonth, @friendid_
				end
		END

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost, @heart heart, @feed feed, @roul1 roul1, @roul2 roul2, @roul3 roul3, @roul4 roul4, @roul5 roul5, @pmgauage pmgauage, @checkani checkani, @checkreward checkreward

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
					pmgauage	= @pmgauage,
					bgroulcnt	= @bgroulcnt,
					bkcrossnormal	= bkcrossnormal 	+ case when (@mode_ = @MODE_ROULETTE_NORMAL) 	then 1 else 0 end,
					bkcrosspremium	= bkcrosspremium 	+ case when (@mode_ = @MODE_ROULETTE_PREMINUM) 	then 1 else 0 end
			where gameid = @gameid_

			-----------------------------------------------
			---- 교배뽑기.
			-----------------------------------------------
			select top 1 * from dbo.tFVSystemRoulette
			where famelvmin <= @famelv
					and @famelv <= famelvmax
					and packstate = 1
					--and (ABS(CAST( (BINARY_CHECKSUM(*) * RAND()) as int)) % 100) <= 100
					order by newid()

			--------------------------------------------------------------
			-- 선물/쪽지 리스트 정보
			--------------------------------------------------------------
			exec spu_FVGiftList @gameid_

			---------------------------------------------
			-- 프리미엄 관료 자료.
			---------------------------------------------
			select
				top 1 *,
				case when (@curdate > roulstart and @curdate <= roulend) then roulflag 		else -1 end roulflag2,
				case when (@curdate > roulstart and @curdate <= roulend) then roultimeflag 	else -1 end roultimeflag2,
				case when (@curdate > roulstart and @curdate <= roulend) then pmgauageflag 	else -1 end pmgauageflag2
			from dbo.tFVSystemRouletteMan
			where roulmarket like @strmarket
			order by idx desc
		end

	set nocount off
End



