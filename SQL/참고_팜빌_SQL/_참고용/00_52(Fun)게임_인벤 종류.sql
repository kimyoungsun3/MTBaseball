
--################################################################
-- 인벤의 종류를 알아보기(구매, 선물)
-- select dbo.fnu_GetFVInvenFromSubCategory(1)
-- select dbo.fnu_GetFVInvenFromSubCategory(2)
-- select dbo.fnu_GetFVInvenFromSubCategory(3)
-- select dbo.fnu_GetFVInvenFromSubCategory(7)
-- select dbo.fnu_GetFVInvenFromSubCategory(8)
-- select dbo.fnu_GetFVInvenFromSubCategory(9)
-- select dbo.fnu_GetFVInvenFromSubCategory(44)
-- select dbo.fnu_GetFVInvenFromSubCategory(11)
-- select dbo.fnu_GetFVInvenFromSubCategory(12)
-- select dbo.fnu_GetFVInvenFromSubCategory(13)
-- select dbo.fnu_GetFVInvenFromSubCategory(15)
-- select dbo.fnu_GetFVInvenFromSubCategory(40)
-- select dbo.fnu_GetFVInvenFromSubCategory(50)
-- select dbo.fnu_GetFVInvenFromSubCategory(51)
-- select dbo.fnu_GetFVInvenFromSubCategory(52)
-- select dbo.fnu_GetFVInvenFromSubCategory(53)
-- select dbo.fnu_GetFVInvenFromSubCategory(60)
-- select dbo.fnu_GetFVInvenFromSubCategory(61)
-- select dbo.fnu_GetFVInvenFromSubCategory(62)
-- select dbo.fnu_GetFVInvenFromSubCategory(63)
-- select dbo.fnu_GetFVInvenFromSubCategory(64)
-- select dbo.fnu_GetFVInvenFromSubCategory(65)
-- select dbo.fnu_GetFVInvenFromSubCategory(66)
-- select dbo.fnu_GetFVInvenFromSubCategory(67)
-- select dbo.fnu_GetFVInvenFromSubCategory(68)
-- select dbo.fnu_GetFVInvenFromSubCategory(818)
-- select dbo.fnu_GetFVInvenFromSubCategory(500)
--################################################################
use Farm
GO

IF OBJECT_ID ( N'dbo.fnu_GetFVInvenFromSubCategory', N'FN' ) IS NOT NULL
	DROP FUNCTION dbo.fnu_GetFVInvenFromSubCategory;
GO

CREATE FUNCTION dbo.fnu_GetFVInvenFromSubCategory(
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

	-- 아이템 소종류
	declare @ITEM_SUBCATEGORY_COW				int					set @ITEM_SUBCATEGORY_COW 					= 1  -- 소		(판매[O], 선물[O])
	declare @ITEM_SUBCATEGORY_GOAT				int					set @ITEM_SUBCATEGORY_GOAT 					= 2  -- 양		(판매[O], 선물[O])
	declare @ITEM_SUBCATEGORY_SHEEP				int					set @ITEM_SUBCATEGORY_SHEEP 				= 3  -- 산양	(판매[O], 선물[O])
	declare @ITEM_SUBCATEGORY_SEED				int					set @ITEM_SUBCATEGORY_SEED 					= 7  -- 씨앗	(판매[X], 선물[X], 직접[O])
	declare @ITEM_SUBCATEGORY_BULLET			int					set @ITEM_SUBCATEGORY_BULLET 				= 8  -- 총알	(판매[O], 선물[O])
	declare @ITEM_SUBCATEGORY_VACCINE			int					set @ITEM_SUBCATEGORY_VACCINE 				= 9  -- 치료제	(판매[O], 선물[O])
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

	declare @rtn int
	if(@category_ in (@ITEM_SUBCATEGORY_COW, @ITEM_SUBCATEGORY_GOAT, @ITEM_SUBCATEGORY_SHEEP))
		begin
			set @rtn = @USERITEM_INVENKIND_ANI
		end
	else if(@category_ in (@ITEM_SUBCATEGORY_BULLET, @ITEM_SUBCATEGORY_VACCINE, @ITEM_SUBCATEGORY_ALBA, @ITEM_SUBCATEGORY_BOOSTER, @ITEM_SUBCATEGORY_REVIVAL, @ITEM_SUBCATEGORY_COMPOSE_TIME, @ITEM_SUBCATEGORY_HELPER, @ITEM_SUBCATEGORY_TRADESAFE, @ITEM_SUBCATEGORY_ROULETTE_NOR, @ITEM_SUBCATEGORY_ROULETTE_PRE, @ITEM_SUBCATEGORY_CONTEST))
		begin
			set @rtn = @USERITEM_INVENKIND_CONSUME
		end
	else if(@category_ in (@ITEM_SUBCATEGORY_ACC))
		begin
			set @rtn = @USERITEM_INVENKIND_ACC
		end
	else if(@category_ in (@ITEM_SUBCATEGORY_FEED, @ITEM_SUBCATEGORY_HEART, @ITEM_SUBCATEGORY_CASHCOST, @ITEM_SUBCATEGORY_GAMECOST))
		begin
			set @rtn = @USERITEM_INVENKIND_DIRECT
		end
	else if(@category_ in (@ITEM_SUBCATEGORY_PET))
		begin
			set @rtn = @USERITEM_INVENKIND_PET
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