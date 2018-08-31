
--################################################################
-- 인벤의 종류를 알아보기(구매, 선물)
-- select dbo.fnu_GetInvenFromSubCategory(1)
-- select dbo.fnu_GetInvenFromSubCategory(2)
-- select dbo.fnu_GetInvenFromSubCategory(3)
-- select dbo.fnu_GetInvenFromSubCategory(7)
-- select dbo.fnu_GetInvenFromSubCategory(8)
-- select dbo.fnu_GetInvenFromSubCategory(9)
-- select dbo.fnu_GetInvenFromSubCategory(44)
-- select dbo.fnu_GetInvenFromSubCategory(11)
-- select dbo.fnu_GetInvenFromSubCategory(12)
-- select dbo.fnu_GetInvenFromSubCategory(13)
-- select dbo.fnu_GetInvenFromSubCategory(15)
-- select dbo.fnu_GetInvenFromSubCategory(25)
-- select dbo.fnu_GetInvenFromSubCategory(26)
-- select dbo.fnu_GetInvenFromSubCategory(40)
-- select dbo.fnu_GetInvenFromSubCategory(50)
-- select dbo.fnu_GetInvenFromSubCategory(51)
-- select dbo.fnu_GetInvenFromSubCategory(52)
-- select dbo.fnu_GetInvenFromSubCategory(53)
-- select dbo.fnu_GetInvenFromSubCategory(60)
-- select dbo.fnu_GetInvenFromSubCategory(61)
-- select dbo.fnu_GetInvenFromSubCategory(62)
-- select dbo.fnu_GetInvenFromSubCategory(63)
-- select dbo.fnu_GetInvenFromSubCategory(64)
-- select dbo.fnu_GetInvenFromSubCategory(65)
-- select dbo.fnu_GetInvenFromSubCategory(66)
-- select dbo.fnu_GetInvenFromSubCategory(67)
-- select dbo.fnu_GetInvenFromSubCategory(68)
-- select dbo.fnu_GetInvenFromSubCategory(818)
-- select dbo.fnu_GetInvenFromSubCategory(500)
-- select dbo.fnu_GetInvenFromSubCategory(1200)
-- select dbo.fnu_GetInvenFromSubCategory(39)
--################################################################
use GameMTBaseball
GO

IF OBJECT_ID ( N'dbo.fnu_GetInvenFromSubCategory', N'FN' ) IS NOT NULL
	DROP FUNCTION dbo.fnu_GetInvenFromSubCategory;
GO

CREATE FUNCTION dbo.fnu_GetInvenFromSubCategory(
	@category_ 			int
)
	RETURNS int
AS
BEGIN
	-- 아이템별 인벤분류
	declare @USERITEM_INVENKIND_ANI				int 				set @USERITEM_INVENKIND_ANI					= 1
	declare @USERITEM_INVENKIND_CONSUME			int 				set @USERITEM_INVENKIND_CONSUME				= 3
	declare @USERITEM_INVENKIND_ACC				int 				set @USERITEM_INVENKIND_ACC					= 4
	declare @USERITEM_INVENKIND_DIRECT			int 				set @USERITEM_INVENKIND_DIRECT				= 40
	declare @USERITEM_INVENKIND_INFO			int 				set @USERITEM_INVENKIND_INFO				= 60
	declare @USERITEM_INVENKIND_PET				int 				set @USERITEM_INVENKIND_PET					= 1000
	declare @USERITEM_INVENKIND_STEMCELL		int 				set @USERITEM_INVENKIND_STEMCELL			= 1040
	declare @USERITEM_INVENKIND_TREASURE		int 				set @USERITEM_INVENKIND_TREASURE			= 1200

	-- 아이템 소종류
	declare @ITEM_SUBCATEGORY_COW				int					set @ITEM_SUBCATEGORY_COW 					= 1  -- 소		(판매[O], 선물[O])
	declare @ITEM_SUBCATEGORY_GOAT				int					set @ITEM_SUBCATEGORY_GOAT 					= 2  -- 양		(판매[O], 선물[O])
	declare @ITEM_SUBCATEGORY_SHEEP				int					set @ITEM_SUBCATEGORY_SHEEP 				= 3  -- 산양	(판매[O], 선물[O])
	declare @ITEM_SUBCATEGORY_SEED				int					set @ITEM_SUBCATEGORY_SEED 					= 7  -- 씨앗	(판매[X], 선물[X], 직접[O])
	declare @ITEM_SUBCATEGORY_BULLET			int					set @ITEM_SUBCATEGORY_BULLET 				= 8  -- 총알	(판매[O], 선물[O])
	declare @ITEM_SUBCATEGORY_VACCINE			int					set @ITEM_SUBCATEGORY_VACCINE 				= 9  -- 백신	(판매[O], 선물[O])
	declare @ITEM_SUBCATEGORY_FEED				int					set @ITEM_SUBCATEGORY_FEED 					= 44 -- 건초	(판매[X], 선물[O])
	declare @ITEM_SUBCATEGORY_ALBA				int					set @ITEM_SUBCATEGORY_ALBA 					= 11 -- 일꾼	(판매[O], 선물[O])
	declare @ITEM_SUBCATEGORY_BOOSTER			int					set @ITEM_SUBCATEGORY_BOOSTER 				= 12 -- 촉진제	(판매[O], 선물[O])
	declare @ITEM_SUBCATEGORY_REVIVAL			int					set @ITEM_SUBCATEGORY_REVIVAL 				= 13 -- 부활석	(판매[O], 선물[O])
	declare @ITEM_SUBCATEGORY_COMPOSE_TIME		int					set @ITEM_SUBCATEGORY_COMPOSE_TIME 			= 16 -- 합성1시간 초기화(판매[X], 선물[O])
	declare @ITEM_SUBCATEGORY_ACC				int					set @ITEM_SUBCATEGORY_ACC 					= 15 -- 악세	(판매[O], 선물[O])
	declare @ITEM_SUBCATEGORY_HEART				int					set @ITEM_SUBCATEGORY_HEART 				= 40 -- 하트	(판매[O], 선물[O])
	declare @ITEM_SUBCATEGORY_HELPER			int					set @ITEM_SUBCATEGORY_HELPER 				= 41 -- 긴급요청(판매[X], 선물[O])
	declare @ITEM_SUBCATEGORY_TRADESAFE			int					set @ITEM_SUBCATEGORY_TRADESAFE				= 42 -- 상인만족(판매[X], 선물[O])
	declare @ITEM_SUBCATEGORY_CASHCOST			int					set @ITEM_SUBCATEGORY_CASHCOST 				= 50 -- 캐쉬	(판매[O], 선물[O])
	declare @ITEM_SUBCATEGORY_GAMECOST			int					set @ITEM_SUBCATEGORY_GAMECOST 				= 51 -- 코인	(판매[O], 선물[O])
	declare @ITEM_SUBCATEGORY_ROULETTE_NOR		int					set @ITEM_SUBCATEGORY_ROULETTE_NOR			= 22 -- 일반교배뽑기티켓(판매[X], 선물[O])
	declare @ITEM_SUBCATEGORY_ROULETTE_PRE		int					set @ITEM_SUBCATEGORY_ROULETTE_PRE			= 23 -- 프리미엄교배뽑기티켓(판매[X], 선물[O])
	declare @ITEM_SUBCATEGORY_TREASURE_NOR		int					set @ITEM_SUBCATEGORY_TREASURE_NOR			= 25 -- 일반 보물 뽑기티켓
	declare @ITEM_SUBCATEGORY_TREASURE_PRE		int					set @ITEM_SUBCATEGORY_TREASURE_PRE			= 26 -- 프리미엄 보물 뽑기티켓
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
	declare @ITEM_SUBCATEGORY_PET				int					set @ITEM_SUBCATEGORY_PET					= 1000 	--펫(1000)
	declare @ITEM_SUBCATEGORY_GOLDTICKET		int					set @ITEM_SUBCATEGORY_GOLDTICKET			= 30	-- 황금티켓.
	declare @ITEM_SUBCATEGORY_BATTLETICKET		int					set @ITEM_SUBCATEGORY_BATTLETICKET			= 31	-- 싸움티켓.
	declare @ITEM_SUBCATEGORY_STEMCELL			int					set @ITEM_SUBCATEGORY_STEMCELL				= 1040	-- 줄기세포.
	declare @ITEM_SUBCATEGORY_TREASURE			int					set @ITEM_SUBCATEGORY_TREASURE				= 1200	-- 보물.
	declare @ITEM_SUBCATEGORY_COMPOSETICKET		int					set @ITEM_SUBCATEGORY_COMPOSETICKET			= 35	-- 합성의 훈장(35)
	declare @ITEM_SUBCATEGORY_PROMOTETICKET		int					set @ITEM_SUBCATEGORY_PROMOTETICKET	 		= 36	-- 승급의 꽃(36)
	declare @ITEM_SUBCATEGORY_USERBATTLEBOX		int					set @ITEM_SUBCATEGORY_USERBATTLEBOX			= 37	-- 유저배틀박스(37)
	declare @ITEM_SUBCATEGORY_ZZCOUPON			int					set @ITEM_SUBCATEGORY_ZZCOUPON				= 38	-- 짜요 쿠폰(38)
	declare @ITEM_SUBCATEGORY_CASHPOINT			int					set @ITEM_SUBCATEGORY_CASHPOINT				= 39	-- 낙농포인트(39)

	declare @rtn int
	if(@category_ in (@ITEM_SUBCATEGORY_COW, @ITEM_SUBCATEGORY_GOAT, @ITEM_SUBCATEGORY_SHEEP))
		begin
			set @rtn = @USERITEM_INVENKIND_ANI
		end
	else if(@category_ in (@ITEM_SUBCATEGORY_BULLET, @ITEM_SUBCATEGORY_VACCINE, @ITEM_SUBCATEGORY_ALBA, @ITEM_SUBCATEGORY_BOOSTER, @ITEM_SUBCATEGORY_REVIVAL, @ITEM_SUBCATEGORY_COMPOSE_TIME, @ITEM_SUBCATEGORY_HELPER, @ITEM_SUBCATEGORY_TRADESAFE, @ITEM_SUBCATEGORY_ROULETTE_NOR, @ITEM_SUBCATEGORY_ROULETTE_PRE, @ITEM_SUBCATEGORY_TREASURE_NOR, @ITEM_SUBCATEGORY_TREASURE_PRE, @ITEM_SUBCATEGORY_CONTEST, @ITEM_SUBCATEGORY_COMPOSETICKET, @ITEM_SUBCATEGORY_PROMOTETICKET, @ITEM_SUBCATEGORY_ZZCOUPON))
		begin
			set @rtn = @USERITEM_INVENKIND_CONSUME
		end
	else if(@category_ in (@ITEM_SUBCATEGORY_ACC))
		begin
			set @rtn = @USERITEM_INVENKIND_ACC
		end
	else if(@category_ in (@ITEM_SUBCATEGORY_FEED, @ITEM_SUBCATEGORY_HEART, @ITEM_SUBCATEGORY_CASHCOST, @ITEM_SUBCATEGORY_GAMECOST, @ITEM_SUBCATEGORY_GOLDTICKET, @ITEM_SUBCATEGORY_BATTLETICKET, @ITEM_SUBCATEGORY_USERBATTLEBOX, @ITEM_SUBCATEGORY_CASHPOINT))
		begin
			set @rtn = @USERITEM_INVENKIND_DIRECT
		end
	else if(@category_ in (@ITEM_SUBCATEGORY_PET))
		begin
			set @rtn = @USERITEM_INVENKIND_PET
		end
	else if(@category_ in (@ITEM_SUBCATEGORY_STEMCELL))
		begin
			set @rtn = @USERITEM_INVENKIND_STEMCELL
		end
	else if(@category_ in (@ITEM_SUBCATEGORY_TREASURE))
		begin
			set @rtn = @USERITEM_INVENKIND_TREASURE
		end
	else
		begin
			-- @ITEM_SUBCATEGORY_SEED, @ITEM_SUBCATEGORY_CONTEST, @ITEM_SUBCATEGORY_ROULETTE_NOR, @ITEM_SUBCATEGORY_ROULETTE_PRE
			-- @ITEM_SUBCATEGORY_UPGRADE_HOUSE, @ITEM_SUBCATEGORY_UPGRADE_TANK, @ITEM_SUBCATEGORY_UPGRADE_FRESHCOOL, @ITEM_SUBCATEGORY_UPGRADE_PURE, @ITEM_SUBCATEGORY_UPGRADE_BOTTLE, @ITEM_SUBCATEGORY_UPGRADE_PUMP, @ITEM_SUBCATEGORY_UPGRADE_TRANSFER
			-- @ITEM_SUBCATEGORY_DOGAM, @ITEM_SUBCATEGORY_SYSINFO
			set @rtn = @USERITEM_INVENKIND_INFO
		end

	RETURN @rtn
END