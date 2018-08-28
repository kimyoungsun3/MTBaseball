
--################################################################
-- 소모템 묶음 종류
-- select dbo.fnu_GetFVItemcodeFromConsumePackage(16, 1600)
-- select dbo.fnu_GetFVItemcodeFromConsumePackage(16, 1601)
--################################################################
use Farm
GO

IF OBJECT_ID ( N'dbo.fnu_GetFVItemcodeFromConsumePackage', N'FN' ) IS NOT NULL
	DROP FUNCTION dbo.fnu_GetFVItemcodeFromConsumePackage;
GO

CREATE FUNCTION dbo.fnu_GetFVItemcodeFromConsumePackage(
	@subcategory_		int,
	@itemcode_ 			int
)
	RETURNS int
AS
BEGIN
	-- 아이템 소종류
	--declare @ITEM_SUBCATEGORY_COW				int					set @ITEM_SUBCATEGORY_COW 					= 1  -- 소		(판매[O], 선물[O])			0
	--declare @ITEM_SUBCATEGORY_GOAT			int					set @ITEM_SUBCATEGORY_GOAT 					= 2  -- 양		(판매[O], 선물[O])			0
	--declare @ITEM_SUBCATEGORY_SHEEP			int					set @ITEM_SUBCATEGORY_SHEEP 				= 3  -- 산양	(판매[O], 선물[O])			0
	--declare @ITEM_SUBCATEGORY_SEED			int					set @ITEM_SUBCATEGORY_SEED 					= 7  -- 씨앗	(판매[X], 선물[X], 직접[O])	0
	declare @ITEM_SUBCATEGORY_BULLET			int					set @ITEM_SUBCATEGORY_BULLET 				= 8  -- 총알	(판매[O], 선물[O])			0
	declare @ITEM_SUBCATEGORY_VACCINE			int					set @ITEM_SUBCATEGORY_VACCINE 				= 9  -- 치료제	(판매[O], 선물[O])			0
	declare @ITEM_SUBCATEGORY_FEED				int					set @ITEM_SUBCATEGORY_FEED 					= 44 -- 건초	(판매[X], 선물[O])
	declare @ITEM_SUBCATEGORY_ALBA				int					set @ITEM_SUBCATEGORY_ALBA 					= 11 -- 일꾼	(판매[O], 선물[O])			0
	declare @ITEM_SUBCATEGORY_BOOSTER			int					set @ITEM_SUBCATEGORY_BOOSTER 				= 12 -- 촉진제	(판매[O], 선물[O])			0
	declare @ITEM_SUBCATEGORY_REVIVAL			int					set @ITEM_SUBCATEGORY_REVIVAL 				= 13 -- 부활석	(판매[O], 선물[O])			0
	declare @ITEM_SUBCATEGORY_COMPOSE_TIME		int					set @ITEM_SUBCATEGORY_COMPOSE_TIME 			= 16 -- 합성1시간 초기화(판매[X], 선물[O])
	--declare @ITEM_SUBCATEGORY_ACC				int					set @ITEM_SUBCATEGORY_ACC 					= 15 -- 악세	(판매[O], 선물[O])			0
	--declare @ITEM_SUBCATEGORY_FPOINT			int					set @ITEM_SUBCATEGORY_FPOINT 				= 19 -- 우정포인트(판매[X], 선물[O])
	--declare @ITEM_SUBCATEGORY_HEART			int					set @ITEM_SUBCATEGORY_HEART 				= 40 -- 하트	(판매[O], 선물[O])
	declare @ITEM_SUBCATEGORY_HELPER			int					set @ITEM_SUBCATEGORY_HELPER 				= 41 -- 긴급요청(판매[X], 선물[O])			0
	--declare @ITEM_SUBCATEGORY_TRADESAFE		int					set @ITEM_SUBCATEGORY_TRADESAFE				= 42 -- 상인만족(판매[X], 선물[O])			0
	--declare @ITEM_SUBCATEGORY_CASHCOST		int					set @ITEM_SUBCATEGORY_CASHCOST 				= 50 -- 캐쉬	(판매[O], 선물[O])
	--declare @ITEM_SUBCATEGORY_GAMECOST		int					set @ITEM_SUBCATEGORY_GAMECOST 				= 51 -- 코인	(판매[O], 선물[O])
	declare @ITEM_SUBCATEGORY_ROULETTE_NOR		int					set @ITEM_SUBCATEGORY_ROULETTE_NOR			= 22 -- 일반교배뽑기티켓(판매[X], 선물[O])
	declare @ITEM_SUBCATEGORY_ROULETTE_PRE		int					set @ITEM_SUBCATEGORY_ROULETTE_PRE			= 23 -- 프리미엄교배뽑기티켓(판매[X], 선물[O])
	--declare @ITEM_SUBCATEGORY_CONTEST			int					set @ITEM_SUBCATEGORY_CONTEST 				= 53 -- 대회	(판매[O], 선물[O])			0
	declare @ITEM_SUBCATEGORY_CONTRADE			int					set @ITEM_SUBCATEGORY_CONTRADE 				= 54 -- 연속거래(54)
	declare @ITEM_SUBCATEGORY_TUTORIAL			int					set @ITEM_SUBCATEGORY_TUTORIAL 				= 55 -- 튜토리얼(55)
	declare @ITEM_SUBCATEGORY_FIELDOPEN			int					set @ITEM_SUBCATEGORY_FIELDOPEN				= 56 -- 필드오픈(56)
	--declare @ITEM_SUBCATEGORY_UPGRADE_HOUSE	int					set @ITEM_SUBCATEGORY_UPGRADE_HOUSE 		= 60 -- 집
	--declare @ITEM_SUBCATEGORY_UPGRADE_TANK	int					set @ITEM_SUBCATEGORY_UPGRADE_TANK 			= 61 -- 탱크
	--declare @ITEM_SUBCATEGORY_UPGRADE_FRESHCOOL	int				set @ITEM_SUBCATEGORY_UPGRADE_FRESHCOOL 	= 62 -- 저온보관
	--declare @ITEM_SUBCATEGORY_UPGRADE_PURE	int					set @ITEM_SUBCATEGORY_UPGRADE_PURE 			= 63 -- 정화시설
	--declare @ITEM_SUBCATEGORY_UPGRADE_BOTTLE	int					set @ITEM_SUBCATEGORY_UPGRADE_BOTTLE 		= 64 -- 양동이
	--declare @ITEM_SUBCATEGORY_UPGRADE_PUMP	int					set @ITEM_SUBCATEGORY_UPGRADE_PUMP 			= 65 -- 착유기
	--declare @ITEM_SUBCATEGORY_UPGRADE_TRANSFER	int				set @ITEM_SUBCATEGORY_UPGRADE_TRANSFER 		= 66 -- 주입기
	--declare @ITEM_SUBCATEGORY_INVEN			int					set @ITEM_SUBCATEGORY_INVEN 				= 67 -- 인벤확장
	--declare @ITEM_SUBCATEGORY_SEEDFIELD		int					set @ITEM_SUBCATEGORY_SEEDFIELD 			= 68 -- 경작지확장
	--declare @ITEM_SUBCATEGORY_USERFARM		int					set @ITEM_SUBCATEGORY_USERFARM	 			= 69 -- 전국목장
	--declare @ITEM_SUBCATEGORY_DOGAM			int					set @ITEM_SUBCATEGORY_DOGAM 				= 818 -- 도감
	--declare @ITEM_SUBCATEGORY_SYSINFO			int					set @ITEM_SUBCATEGORY_SYSINFO 				= 500 -- 정보수집
	--declare @ITEM_SUBCATEGORY_ATTENDANCE		int					set @ITEM_SUBCATEGORY_ATTENDANCE 			= 900 	--출석(900)
	--declare @ITEM_SUBCATEGORY_COMPETITION		int					set @ITEM_SUBCATEGORY_COMPETITION 			= 901 	--경쟁모드(901)
	--declare @ITEM_SUBCATEGORY_TRADEREWARD		int					set @ITEM_SUBCATEGORY_TRADEREWARD			= 902 	--초과거래(902)
	--declare @ITEM_SUBCATEGORY_EPISODE			int					set @ITEM_SUBCATEGORY_EPISODE				= 910 	--에피소드(910)
	--declare @ITEM_SUBCATEGORY_PET				int					set @ITEM_SUBCATEGORY_PET					= 1000 	--펫(1000)
	--declare @ITEM_SUBCATEGORY_COMPOSE			int					set @ITEM_SUBCATEGORY_COMPOSE				= 1010 	--동물합성(1010)

	-- 그룹.
	declare @ITEM_BULLET_MOTHER					int					set @ITEM_BULLET_MOTHER						= 702	-- 총알.
	declare @ITEM_BULLET_SUN1					int					set @ITEM_BULLET_SUN1						= 703
	declare @ITEM_BULLET_SUN2					int					set @ITEM_BULLET_SUN2						= 711
	declare @ITEM_BULLET_WOLFMOTHER				int					set @ITEM_BULLET_WOLFMOTHER					= 701	-- 총알(늑대용 공포탄).
	declare @ITEM_BULLET_WOLFSUN1				int					set @ITEM_BULLET_WOLFSUN1					= 712
	declare @ITEM_BULLET_WOLFSUN2				int					set @ITEM_BULLET_WOLFSUN2					= 716
	declare @ITEM_VACCINE_MOTHER				int					set @ITEM_VACCINE_MOTHER					= 802	-- 치료제.
	declare @ITEM_VACCINE_SUN1					int					set @ITEM_VACCINE_SUN1						= 803
	declare @ITEM_VACCINE_SUN2					int					set @ITEM_VACCINE_SUN2						= 811
	declare @ITEM_VACCINE_NORMAL_MOTHER			int					set @ITEM_VACCINE_NORMAL_MOTHER				= 801	-- 치료제(일반).
	declare @ITEM_VACCINE_NORMAL_SUN1			int					set @ITEM_VACCINE_NORMAL_SUN1				= 812
	declare @ITEM_VACCINE_NORMAL_SUN2			int					set @ITEM_VACCINE_NORMAL_SUN2				= 816
	declare @ITEM_ALBA_MOTHER					int					set @ITEM_ALBA_MOTHER						= 1002	-- 알바.
	declare @ITEM_ALBA_SUN1						int					set @ITEM_ALBA_SUN1							= 1003
	declare @ITEM_ALBA_SUN2						int					set @ITEM_ALBA_SUN2							= 1019
	declare @ITEM_ALBA_SUN3						int					set @ITEM_ALBA_SUN3							= 1025
	declare @ITEM_ALBA_SUN4						int					set @ITEM_ALBA_SUN4							= 1025
	declare @ITEM_ALBA_NONGBU_MOTHER			int					set @ITEM_ALBA_NONGBU_MOTHER				= 1001	-- 알바(농부).
	declare @ITEM_ALBA_NONGBU_SUN1				int					set @ITEM_ALBA_NONGBU_SUN1					= 1026
	declare @ITEM_ALBA_NONGBU_SUN2				int					set @ITEM_ALBA_NONGBU_SUN2					= 1030
	declare @ITEM_BOOSTER_MOTHER				int					set @ITEM_BOOSTER_MOTHER					= 1103	-- 촉진제
	declare @ITEM_BOOSTER_SUN1					int					set @ITEM_BOOSTER_SUN1						= 1104
	declare @ITEM_BOOSTER_SUN2					int					set @ITEM_BOOSTER_SUN2						= 1112
	declare @ITEM_BOOSTER_NORMAL_MOTHER			int					set @ITEM_BOOSTER_NORMAL_MOTHER				= 1102	-- 촉진제(일반)
	declare @ITEM_BOOSTER_NORMAL_SUN1			int					set @ITEM_BOOSTER_NORMAL_SUN1				= 1113
	declare @ITEM_BOOSTER_NORMAL_SUN2			int					set @ITEM_BOOSTER_NORMAL_SUN2				= 1117
	declare @ITEM_REVIVAL_MOTHER				int					set @ITEM_REVIVAL_MOTHER					= 1200	-- 부활석.
	declare @ITEM_COMPOSE_TIME_MOTHER			int					set @ITEM_COMPOSE_TIME_MOTHER				= 1600	-- 합성시간 1시간초기화.
	declare @ITEM_HELPER_MOTHER					int					set @ITEM_HELPER_MOTHER						= 2100	-- 긴급지원.
	declare @ITEM_ROULETTE_NOR_MOTHER			int					set @ITEM_ROULETTE_NOR_MOTHER				= 2200	-- 일반교배뽑기.
	declare @ITEM_ROULETTE_PRE_MOTHER			int					set @ITEM_ROULETTE_PRE_MOTHER				= 2300	-- 프리미엄교배뽑기.

	declare @rtn int
	set @rtn = @itemcode_

	--------------------------------------------------------------
	-- 총알					-> 소모성 아이템0
	-- 백신					-> 소모성 아이템0
	-- 촉진제				-> 소모성 아이템0
	-- 알바					-> 소모성 아이템0
	-- 부활석				-> 소모성 아이템 (여러코드 > 1개로 통일됨)
	-- 대회용 티켓			-> 소모성 아이템
	-- 교배 티켓			-> 소모성 아이템
	-- 긴급요청 티켓		-> 소모성 아이템 (여러코드 > 1개로 통일됨)
	-- 상인 100% 만족 티켓	-> 소모성 아이템
	-- 시간초기화템 		-> 소모성 아이템
	--------------------------------------------------------------
	if(@subcategory_ = @ITEM_SUBCATEGORY_BULLET and (@itemcode_  >= @ITEM_BULLET_SUN1 and @itemcode_  <= @ITEM_BULLET_SUN2))
		begin
			set @rtn = @ITEM_BULLET_MOTHER
		end
	else if(@subcategory_ = @ITEM_SUBCATEGORY_BULLET and (@itemcode_  >= @ITEM_BULLET_WOLFSUN1 and @itemcode_  <= @ITEM_BULLET_WOLFSUN2))
		begin
			set @rtn = @ITEM_BULLET_WOLFMOTHER
		end
	else if(@subcategory_ = @ITEM_SUBCATEGORY_VACCINE and (@itemcode_  >= @ITEM_VACCINE_SUN1 and @itemcode_  <= @ITEM_VACCINE_SUN2))
		begin
			set @rtn = @ITEM_VACCINE_MOTHER
		end
	else if(@subcategory_ = @ITEM_SUBCATEGORY_VACCINE and (@itemcode_  >= @ITEM_VACCINE_NORMAL_SUN1 and @itemcode_  <= @ITEM_VACCINE_NORMAL_SUN2))
		begin
			set @rtn = @ITEM_VACCINE_NORMAL_MOTHER
		end
	else if(@subcategory_ = @ITEM_SUBCATEGORY_ALBA and ((@itemcode_  >= @ITEM_ALBA_SUN1 and @itemcode_  <= @ITEM_ALBA_SUN2) or (@itemcode_  >= @ITEM_ALBA_SUN3 and @itemcode_  <= @ITEM_ALBA_SUN4)))
		begin
			set @rtn = @ITEM_ALBA_MOTHER
		end
	else if(@subcategory_ = @ITEM_SUBCATEGORY_ALBA and (@itemcode_  >= @ITEM_ALBA_NONGBU_SUN1 and @itemcode_  <= @ITEM_ALBA_NONGBU_SUN2))
		begin
			set @rtn = @ITEM_ALBA_NONGBU_MOTHER
		end
	else if(@subcategory_ = @ITEM_SUBCATEGORY_BOOSTER and (@itemcode_  >= @ITEM_BOOSTER_SUN1 and @itemcode_  <= @ITEM_BOOSTER_SUN2))
		begin
			set @rtn = @ITEM_BOOSTER_MOTHER
		end
	else if(@subcategory_ = @ITEM_SUBCATEGORY_BOOSTER and (@itemcode_  >= @ITEM_BOOSTER_NORMAL_SUN1 and @itemcode_  <= @ITEM_BOOSTER_NORMAL_SUN2))
		begin
			set @rtn = @ITEM_BOOSTER_NORMAL_MOTHER
		end
	else if(@subcategory_ = @ITEM_SUBCATEGORY_REVIVAL)
		begin
			set @rtn = @ITEM_REVIVAL_MOTHER
		end
	else if(@subcategory_ = @ITEM_SUBCATEGORY_COMPOSE_TIME)
		begin
			set @rtn = @ITEM_COMPOSE_TIME_MOTHER
		end
	else if(@subcategory_ = @ITEM_SUBCATEGORY_HELPER)
		begin
			set @rtn = @ITEM_HELPER_MOTHER
		end
	else if(@subcategory_ = @ITEM_SUBCATEGORY_ROULETTE_NOR)
		begin
			set @rtn = @ITEM_ROULETTE_NOR_MOTHER
		end
	else if(@subcategory_ = @ITEM_SUBCATEGORY_ROULETTE_PRE)
		begin
			set @rtn = @ITEM_ROULETTE_PRE_MOTHER
		end

	RETURN @rtn
END