---------------------------------------------------------------
/*
--오류코드.
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445287',    1, 1, -1, -1, -1, 7771, -1	-- 유저없음.
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289',   -1, 1, -1, -1, -1, 7771, -1	-- 아이템코드없음.
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289',    1, 1, -1, -1, -1, 7771, -1	-- 코인부족.
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289',    3, 1, -1, -1, -1, 7771, -1	-- 캐쉬부족.
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289',  700, 1, -1, -1, -1, 7760, -1	-- 맥스초과.

-- 동물.
exec spu_ItemBuy 'xxxx2','049000s1i0n7t8445289',	 4, 1, -1, -1, -1, 7771, -1	-- 소(인벤 -1)
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289',    4, 1, -1, -1, -1, 7772, -1	-- 소(인벤 -1)
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289',    1, 1, -1,  6, -1, 7773, -1	-- 소(필드  6) > 2번 충돌.

-- 소모.
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289',  701, 1, -1, -1, -1, 7773, -1	-- 총알(새것) > 2번 충돌
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289',  701,10,  9, -1, -1, 7764, -1	-- 총알(기존누적)
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289',  702, 2, -1, -1, -1, 7773, -1	-- 최상총알(새것)
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289',  703, 2, 14, -1, -1, 7774, -1	-- 최상총알(기존)
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289',  703, 2, -1, -1, -1, 7773, -1	-- 최상총알(새것)
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289',  702, 2, 14, -1, -1, 7774, -1	-- 최상총알(기존)

exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289',  801, 1, -1, -1, -1, 7777, -1	-- 백신
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289',  801, 1, 14, -1,  1, 7778, -1	-- 백신(기존누적)
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289', 1001, 1, -1, -1, -1, 7779, -1	-- 일꾼
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289', 1001, 1, 15, -1,  1, 7760, -1	-- 일꾼(새것 > 세팅변경)
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289', 1003, 1, -1, -1,  1, 7761, -1	-- 일꾼(새것 > 세팅변경)
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289', 1004, 1, 14, -1,  1, 7762, -1	-- 일꾼(새것 > 세팅변경)
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289', 1005, 1, 14, -1,  1, 7763, -1	-- 일꾼(새것 > 세팅변경)
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289', 1006, 1, 14, -1,  1, 7764, -1	-- 일꾼(새것 > 세팅변경)
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289', 1007, 1, 14, -1,  1, 7767, -1	-- 일꾼(새것 > 세팅변경)
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289', 1101, 1, -1, -1,  1, 7781, -1	-- 촉진제
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289', 1101, 1, 16, -1,  1, 7782, -1	-- 촉진제(새것 > 세팅변경)

exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289', 1200, 1, -1, -1, -1, 7752, -1	-- 부활석
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289', 1202, 1, 14, -1, -1, 7753, -1	-- 부활석2번 > 부활석 기본으로 할당되어야함
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289', 1203, 1, 14, -1, -1, 7754, -1	-- 부활석2번 > 부활석 기본으로 할당되어야함
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289', 1204, 1, 14, -1, -1, 7755, -1	-- 부활석2번 > 부활석 기본으로 할당되어야함
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289', 1205, 1, 14, -1, -1, 7756, -1	-- 부활석2번 > 부활석 기본으로 할당되어야함
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289', 1206, 1, 14, -1, -1, 7757, -1	-- 부활석2번 > 부활석 기본으로 할당되어야함
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289', 1207, 1, 14, -1, -1, 7758, -1	-- 부활석2번 > 부활석 기본으로 할당되어야함
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289', 1208, 1, 14, -1, -1, 7759, -1	-- 부활석2번 > 부활석 기본으로 할당되어야함
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289', 1209, 1, 14, -1, -1, 7750, -1	-- 부활석2번 > 부활석 기본으로 할당되어야함
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289', 5201, 1, -1, -1, -1, 7784, -1	-- 일반교배티켓
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289', 5300, 1, -1, -1, -1, 7785, -1	-- 대회티켓B
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289', 2200, 1, -1, -1, -1, 7786, -1	-- 상인100프로만족
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289', 2100, 1, -1, -1, -1, 7787, -1	-- 긴급요청티켓
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289', 2101, 1, 17, -1, -1, 7788, -1	-- 긴급요청티켓
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289', 2103, 1, 17, -1, -1, 7787, -1	-- 긴급요청티켓
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289', 2104, 1, 17, -1, -1, 7788, -1	-- 긴급요청티켓
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289', 2105, 1, 17, -1, -1, 7787, -1	-- 긴급요청티켓
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289', 2106, 1, 17, -1, -1, 7788, -1	-- 긴급요청티켓
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289', 2107, 1, 17, -1, -1, 7786, -1	-- 긴급요청티켓
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289', 2108, 1, 17, -1, -1, 7788, -1	-- 긴급요청티켓
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289', 1600, 1, -1, -1, -1, 7780, -1	-- 시간초기화템
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289', 1601, 1, -1, -1, -1, 7781, -1	-- 시간초기화템


-- 악세.
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289', 1401, 1, -1, -1, -1, 7775, -1	-- 악세(머리)
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289', 1419, 1, -1, -1, -1, 7776, -1	-- 악세(등)
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289', 1421, 1, -1, -1, -1, 7777, -1	-- 악세(옆구리)

-- 환전.
update dbo.tUserMaster set cashcost = 100000, gamecost = 0, heart = 0, cashpoint = 0,      randserial = -1 where gameid = 'xxxx2'
update dbo.tUserMaster set cashcost = 100000, gamecost = 0, heart = 0, cashpoint = 140000, randserial = -1 where gameid = 'xxxx2'
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289', 5105, 1, -1, -1, -1, 7790, -1	-- 코인환전(추가 획득있음)
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289', 5105, 1, -1, -1, -1, 7790, -1	-- 코인환전(추가 획득있음)
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289', 5106, 1, -1, -1, -1, 7791, -1	--
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289', 5107, 1, -1, -1, -1, 7792, -1	--
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289', 5108, 1, -1, -1, -1, 7793, -1	--
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289', 5109, 1, -1, -1, -1, 7794, -1	--
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289', 5110, 1, -1, -1, -1, 7795, -1	--
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289', 5101, 1, -1, -1, -1, 7795, -1	-- 환전비용이상함.

-- 티켓구매.
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289', 3000, 1, -1, -1, -1, 7791, -1	-- 황금티켓.
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289', 3001, 1, -1, -1, -1, 7792, -1	--
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289', 3002, 1, -1, -1, -1, 7793, -1	--
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289', 3003, 1, -1, -1, -1, 7794, -1	--
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289', 3004, 1, -1, -1, -1, 7795, -1	--
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289', 3100, 1, -1, -1, -1, 7796, -1	-- 배틀티켓.
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289', 3101, 1, -1, -1, -1, 7797, -1	--
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289', 3102, 1, -1, -1, -1, 7798, -1	--
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289', 3103, 1, -1, -1, -1, 7799, -1	--
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289', 3104, 1, -1, -1, -1, 7790, -1	--

-- 기타지정템.
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289',  901, 1, -1, -1, -1, 7788, -1	-- 건초(추가 획득없음)

update dbo.tUserMaster set cashcost = 100000, gamecost = 0, heart = 0, cashpoint = 0,      randserial = -1 where gameid = 'xxxx2'
update dbo.tUserMaster set cashcost = 100000, gamecost = 0, heart = 0, cashpoint = 140000, randserial = -1 where gameid = 'xxxx2'
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289', 2000, 1, -1, -1, -1, 7789, -1	-- 하트(추가 획득있음)
*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_ItemBuy', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_ItemBuy;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_ItemBuy
	@gameid_				varchar(20),						-- 게임아이디
	@password_				varchar(20),						-- 암호화해서저장, 유저패스워가 해킹당해도 안전
	@itemcode_				int,								--
	@buycnt_				int,								--
	@listidx_				int,								--
	@fieldidx_				int,								--
	@quickkind_				int,								--
	@randserial_			varchar(20),						--
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
	declare @RESULT_ERROR_ANIMAL_DAILY_FULL		int				set @RESULT_ERROR_ANIMAL_DAILY_FULL		= -153			-- 1일 동물 구매 수량을 초과.

	------------------------------------------------
	--	2-2. 정의된값
	------------------------------------------------
	-- 아이템별 인벤분류
	declare @USERITEM_INVENKIND_ANI				int 				set @USERITEM_INVENKIND_ANI					= 1
	declare @USERITEM_INVENKIND_CONSUME			int 				set @USERITEM_INVENKIND_CONSUME				= 3
	declare @USERITEM_INVENKIND_ACC				int 				set @USERITEM_INVENKIND_ACC					= 4
	--declare @USERITEM_INVENKIND_DIRECT		int 				set @USERITEM_INVENKIND_DIRECT				= 40
	--declare @USERITEM_INVENKIND_INFO			int 				set @USERITEM_INVENKIND_INFO				= 60
	--declare @USERITEM_INVENKIND_PET			int 				set @USERITEM_INVENKIND_PET					= 1000

	-- 아이템 소종류
	--declare @ITEM_SUBCATEGORY_COW				int					set @ITEM_SUBCATEGORY_COW 					= 1  -- 소		(판매[O], 선물[O])			0
	--declare @ITEM_SUBCATEGORY_GOAT			int					set @ITEM_SUBCATEGORY_GOAT 					= 2  -- 양		(판매[O], 선물[O])			0
	--declare @ITEM_SUBCATEGORY_SHEEP			int					set @ITEM_SUBCATEGORY_SHEEP 				= 3  -- 산양	(판매[O], 선물[O])			0
	--declare @ITEM_SUBCATEGORY_SEED			int					set @ITEM_SUBCATEGORY_SEED 					= 7  -- 씨앗	(판매[X], 선물[X], 직접[O])	0
	declare @ITEM_SUBCATEGORY_BULLET			int					set @ITEM_SUBCATEGORY_BULLET 				= 8  -- 총알	(판매[O], 선물[O])			0
	declare @ITEM_SUBCATEGORY_VACCINE			int					set @ITEM_SUBCATEGORY_VACCINE 				= 9  -- 백신	(판매[O], 선물[O])			0
	declare @ITEM_SUBCATEGORY_FEED				int					set @ITEM_SUBCATEGORY_FEED 					= 44 -- 건초	(판매[X], 선물[O])
	declare @ITEM_SUBCATEGORY_ALBA				int					set @ITEM_SUBCATEGORY_ALBA 					= 11 -- 일꾼	(판매[O], 선물[O])			0
	declare @ITEM_SUBCATEGORY_BOOSTER			int					set @ITEM_SUBCATEGORY_BOOSTER 				= 12 -- 촉진제	(판매[O], 선물[O])			0
	--declare @ITEM_SUBCATEGORY_REVIVAL			int					set @ITEM_SUBCATEGORY_REVIVAL 				= 13 -- 부활석	(판매[O], 선물[O])			0
	--declare @ITEM_SUBCATEGORY_COMPOSE_TIME	int					set @ITEM_SUBCATEGORY_COMPOSE_TIME 			= 16 -- 합성1시간 초기화(판매[X], 선물[O])
	--declare @ITEM_SUBCATEGORY_ACC				int					set @ITEM_SUBCATEGORY_ACC 					= 15 -- 악세	(판매[O], 선물[O])			0
	declare @ITEM_SUBCATEGORY_HEART				int					set @ITEM_SUBCATEGORY_HEART 				= 40 -- 하트	(판매[O], 선물[O])
	--declare @ITEM_SUBCATEGORY_HELPER			int					set @ITEM_SUBCATEGORY_HELPER 				= 41 -- 긴급요청(판매[X], 선물[O])			0
	--declare @ITEM_SUBCATEGORY_TRADESAFE		int					set @ITEM_SUBCATEGORY_TRADESAFE				= 42 -- 상인만족(판매[X], 선물[O])			0
	declare @ITEM_SUBCATEGORY_CASHCOST			int					set @ITEM_SUBCATEGORY_CASHCOST 				= 50 -- 캐쉬	(판매[O], 선물[O])
	declare @ITEM_SUBCATEGORY_GAMECOST			int					set @ITEM_SUBCATEGORY_GAMECOST 				= 51 -- 코인	(판매[O], 선물[O])
	--declare @ITEM_SUBCATEGORY_CONTEST			int					set @ITEM_SUBCATEGORY_CONTEST 				= 53 -- 대회	(판매[O], 선물[O])			0
	--declare @ITEM_SUBCATEGORY_UPGRADE_HOUSE	int					set @ITEM_SUBCATEGORY_UPGRADE_HOUSE 		= 60 -- 집
	--declare @ITEM_SUBCATEGORY_UPGRADE_TANK	int					set @ITEM_SUBCATEGORY_UPGRADE_TANK 			= 61 -- 탱크
	--declare @ITEM_SUBCATEGORY_UPGRADE_FRESHCOOL	int				set @ITEM_SUBCATEGORY_UPGRADE_FRESHCOOL 	= 62 -- 저온보관
	--declare @ITEM_SUBCATEGORY_UPGRADE_PURE	int					set @ITEM_SUBCATEGORY_UPGRADE_PURE 			= 63 -- 정화시설
	--declare @ITEM_SUBCATEGORY_UPGRADE_BOTTLE	int					set @ITEM_SUBCATEGORY_UPGRADE_BOTTLE 		= 64 -- 양동이
	--declare @ITEM_SUBCATEGORY_UPGRADE_PUMP	int					set @ITEM_SUBCATEGORY_UPGRADE_PUMP 			= 65 -- 착유기
	--declare @ITEM_SUBCATEGORY_UPGRADE_TRANSFER	int				set @ITEM_SUBCATEGORY_UPGRADE_TRANSFER 		= 66 -- 주입기
	--declare @ITEM_SUBCATEGORY_INVEN			int					set @ITEM_SUBCATEGORY_INVEN 				= 67 -- 인벤확장
	--declare @ITEM_SUBCATEGORY_SEEDFIELD		int					set @ITEM_SUBCATEGORY_SEEDFIELD 			= 68 -- 경작지확장
	--declare @ITEM_SUBCATEGORY_DOGAM			int					set @ITEM_SUBCATEGORY_DOGAM 				= 818 -- 도감
	--declare @ITEM_SUBCATEGORY_SYSINFO			int					set @ITEM_SUBCATEGORY_SYSINFO 				= 500 -- 정보수집
	--declare @ITEM_SUBCATEGORY_ATTENDANCE		int					set @ITEM_SUBCATEGORY_ATTENDANCE 			= 900 	--출석(900)
	--declare @ITEM_SUBCATEGORY_COMPETITION		int					set @ITEM_SUBCATEGORY_COMPETITION 			= 901 	--경쟁모드(901)
	declare @ITEM_SUBCATEGORY_GOLDTICKET		int					set @ITEM_SUBCATEGORY_GOLDTICKET			= 30	-- 황금티켓.
	declare @ITEM_SUBCATEGORY_BATTLETICKET		int					set @ITEM_SUBCATEGORY_BATTLETICKET			= 31	-- 싸움티켓.

	-- 아이템 획득방법
	declare @DEFINE_HOW_GET_FIRST				int					set @DEFINE_HOW_GET_FIRST					= 0	--기본
	declare @DEFINE_HOW_GET_BUY					int					set @DEFINE_HOW_GET_BUY						= 1	--구매
	declare @DEFINE_HOW_GET_SEEDFIELD			int					set @DEFINE_HOW_GET_SEEDFIELD				= 2	--경작
	declare @DEFINE_HOW_GET_ROULETTE			int					set @DEFINE_HOW_GET_ROULETTE				= 3	--교배/뽑기
	declare @DEFINE_HOW_GET_SEARCH				int					set @DEFINE_HOW_GET_SEARCH					= 4	--검색
	declare @DEFINE_HOW_GET_GIFT				int					set @DEFINE_HOW_GET_GIFT					= 5	--선물

	-- 동물정보.
	-- 필드동물 0 ~ 8.
	declare @USERITEM_FIELDIDX_INVEN			int					set @USERITEM_FIELDIDX_INVEN					= -1	-- 창고.
	declare @USERITEM_FIELDIDX_HOSPITAL			int					set @USERITEM_FIELDIDX_HOSPITAL					= -2	-- 병원.

	-- 소모템 > 퀵슬롯에 착용위치.
	declare @USERMASTER_QUICKKIND_NON			int					set @USERMASTER_QUICKKIND_NON				= -1 --없음.
	declare @USERMASTER_QUICKKIND_SETTING		int					set @USERMASTER_QUICKKIND_SETTING			=  1 --총알, 백신, 촉진, 알바.

	-- 구매의 일반정보.
	declare @CONSUME_MAX_COUNT					int					set @CONSUME_MAX_COUNT						= 999

	-- 	일일 하트 전송량.
	declare @ANIMAL_BUY_DAILY_FULL				int					set @ANIMAL_BUY_DAILY_FULL					= 4		-- 1일 동물구매 권장량.


	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @comment		varchar(80)
	declare @gameid			varchar(20)		set @gameid		= ''
	declare @cashcost		int				set @cashcost 	= 0
	declare @gamecost		int				set @gamecost 	= 0
	declare @heart			int				set @heart 		= 0
	declare @feed			int				set @feed 		= 0
	declare @fpoint			int				set @fpoint		= 0
	declare @goldticket		int				set @goldticket	= 0
	declare @battleticket	int				set @battleticket= 0
	declare @invenanimalmax	int
	declare @invencustommax int
	declare @invenaccmax	int
	declare @invencnt 		int				set @invencnt	= 0

	declare @subcategory 	int				set @subcategory 	= -444
	declare @discount		int				set @discount		= 0
	declare @gamecostsell	int				set @gamecostsell 	= 0
	declare @cashcostsell	int				set @cashcostsell 	= 0
	declare @buyamount		int				set @buyamount	 	= 0
	declare @invenkind		int

	declare @cnt 			int				set @cnt			= 0
	declare @upstepmax		int				set @upstepmax 		= 16
	declare @plus	 		int 			set @plus			= 0
	declare @listidxcust 	int				set @listidxcust	= -1
	declare @fieldidx 		int
	declare @listidxnew 	int				set @listidxnew		= -1
	declare @listidxrtn 	int				set @listidxrtn		= -1

	-- 시스템에서 플러스 해주는 부분.
	declare @plusgamecost 	int				set @plusgamecost	= 0
	declare @plusheart 		int				set @plusheart		= 0
	declare @plusfeed 		int				set @plusfeed		= 0
	declare @plusgoldticket	int				set @plusgoldticket	= 0
	declare @plusbattleticket int			set @plusbattleticket= 0

	declare @dummy	 		int
	declare @eventplus		int				set @eventplus		= 0

	-- 필드오픈.
	declare @field0				int			set @field0			= -1
	declare @field1				int			set @field1			= -1
	declare @field2				int			set @field2			= -1
	declare @field3				int			set @field3			= -1
	declare @field4				int			set @field4			= -1
	declare @field5				int			set @field5			= -1
	declare @field6				int			set @field6			= -1
	declare @field7				int			set @field7			= -1
	declare @field8				int			set @field8			= -1

	declare @itemcodenew		int			set @itemcodenew	= -1

	declare @anibuydate			datetime	set @anibuydate 	= getdate()		-- 동물 일일전송량.
	declare @anibuycnt			int			set @anibuycnt		= 9999
	declare @curdate			datetime	set @curdate		= getdate()
	declare @tmpcnt				int

	-- VIP효과.
	declare @cashpoint			int			set @cashpoint		= 0
	declare @vip_plus			int			set @vip_plus		= 0
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	set @comment  = '알수 없는 오류가 발생했습니다.'
	--select 'DEBUG 3-1-1 입력값', @gameid_ gameid_, @password_ password_, @itemcode_ itemcode_, @listidx_ listidx_, @fieldidx_ fieldidx_, @quickkind_ quickkind_, @randserial_ randserial_

	if(@fieldidx_ < -1 or @fieldidx_ >= 9)
		begin
			--select 'DEBUG 3-1-2 인벤번호가 잘못되어서 인벤으로 루비.'
			set @fieldidx_ = @USERITEM_FIELDIDX_INVEN
		end

	------------------------------------------------
	--	3-2. 연산수행(유저정보, 선물정보, 아이템 종류)
	------------------------------------------------
	select
		@gameid 		= gameid,			@cashpoint		= cashpoint,
		@cashcost		= cashcost,
		@gamecost		= gamecost,
		@heart			= heart,
		@feed			= feed,
		@fpoint			= fpoint,			@goldticket 	= goldticket, 		@battleticket	= battleticket,
		@invenanimalmax	= invenanimalmax,
		@invencustommax = invencustommax,
		@invenaccmax 	= invenaccmax,
		@anibuydate		= anibuydate, 		@anibuycnt		= anibuycnt,

		@field0			= field0,			@field1			= field1,			@field2			= field2,
		@field3			= field3,			@field4			= field4,			@field5			= field5,
		@field6			= field6,			@field7			= field7,			@field8			= field8
	from dbo.tUserMaster where gameid = @gameid_ and password = @password_
	--select 'DEBUG 3-2-1 유저정보', @gameid gameid, @cashcost cashcost, @gamecost gamecost, @heart heart, @feed feed, @invenanimalmax invenanimalmax, @invencustommax invencustommax, @invenaccmax invenaccmax

	select
		@subcategory 	= subcategory,
		@discount		= discount,
		@gamecostsell	= gamecost,
		@cashcostsell	= cashcost,
		@buyamount		= buyamount,
		@upstepmax		= param30
	from dbo.tItemInfo where itemcode = @itemcode_
	--select 'DEBUG 3-2-2 아이템정보(tItemInfo)', @itemcode_ itemcode_, @subcategory subcategory, @discount discount, @gamecostsell gamecostsell, @cashcostsell cashcostsell, @buyamount buyamount

	set @invenkind = dbo.fnu_GetInvenFromSubCategory(@subcategory)
	set @itemcodenew = dbo.fnu_GetItemcodeFromConsumePackage(@subcategory, @itemcode_)
	--select 'DEBUG 3-2-3 아이템정보', @invenkind invenkind

	---------------------------------------
	-- 수량파악해서 단가조절하기.
	---------------------------------------

	if(@invenkind = @USERITEM_INVENKIND_CONSUME)
		begin
			set @buycnt_ = case when @buycnt_ <= 0 then 1 else @buycnt_ end

			set @gamecostsell	= @gamecostsell * @buycnt_
			set @cashcostsell	= @cashcostsell * @buycnt_
			set @buyamount		= @buyamount * @buycnt_
		end
	else
		begin
			set @buycnt_ = 1
		end


	if(@discount > 0 and @discount <= 100)
		begin
			--select 'DEBUG 3-2-5 할인율적용(전)', @discount discount, @gamecostsell gamecostsell, @cashcostsell cashcostsell

			set @gamecostsell = @gamecostsell - (@gamecostsell * @discount)/100
			set @cashcostsell = @cashcostsell - (@cashcostsell * @discount)/100

			--select 'DEBUG 3-2-6 할인율적용(후)', @discount discount, @gamecostsell gamecostsell, @cashcostsell cashcostsell
		end

	------------------------------------------------
	--	3-3. 각상황별로 코드로 분류
	------------------------------------------------
	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR 아이디가 존재하지 않는다.'
			--select 'DEBUG ' + @comment
		END
	else if (@subcategory = -444)
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_ITEMCODE
			set @comment = 'ERROR 아이템을 찾을 수 없습니다.'
			--select 'DEBUG ' + @comment
		END
	else if (exists(select top 1 * from dbo.tUserItem where gameid = @gameid_ and itemcode = @itemcodenew and randserial = @randserial_))
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 정상 지급 처리합니다.(시리얼같아 기존것 던져줌)'
			--select 'DEBUG ' + @comment

			select top 1 @listidxrtn = listidx from dbo.tUserItem
			where gameid = @gameid_
				  and itemcode = @itemcodenew
				  and randserial = @randserial_
		END
	else if (@cashcostsell > 0 and @cashcostsell > @cashcost)
		BEGIN
			set @nResult_ = @RESULT_ERROR_CASHCOST_LACK
			set @comment = 'ERROR 캐쉬가 부족합니다.'
			--select 'DEBUG ' + @comment
		END
	else if (@gamecostsell > 0 and @gamecostsell > @gamecost)
		BEGIN
			set @nResult_ = @RESULT_ERROR_GAMECOST_LACK
			set @comment = 'ERROR 코인이 부족합니다.'
			--select 'DEBUG ' + @comment
		END
	else if (@cashcostsell <= 0 and @gamecostsell <= 0)
		BEGIN
			set @nResult_ = @RESULT_ERROR_ITEMCOST_WRONG
			set @comment = 'ERROR 코인과 캐쉬 가격이 모두 (0)으로 이상합니다.'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 정상 지급 처리합니다.'

			select @listidxnew = isnull(MAX(listidx), 0) + 1 from dbo.tUserItem where gameid = @gameid_
			--select 'DEBUG 4-1 인벤 새번호', @listidxnew listidxnew

			if(@invenkind = @USERITEM_INVENKIND_ANI)
				begin
					--------------------------------------------------------------
					-- 동물 아이템 > 인벤수량파악
					--------------------------------------------------------------
					select @invencnt = count(*)
					from dbo.tUserItem
					where gameid = @gameid_
						  and invenkind = @invenkind
						  and fieldidx != @USERITEM_FIELDIDX_HOSPITAL
					--select 'DEBUG 4-2 동물(1)인벤넣기', @invencnt invencnt, @invenanimalmax invenanimalmax

					-----------------------------------------------
					--  1일 동물구매 권장량.
					-----------------------------------------------
					set @tmpcnt = datediff(d, @anibuydate, @curdate)
					if(@tmpcnt >= 1)
						begin
							set @anibuydate 	= getdate()
							set @anibuycnt	 	= 0;
						end

					--------------------------------------------------------------
					-- 소,양,산양			-> 동물 아이템
					--------------------------------------------------------------
					if(@invencnt >= @invenanimalmax)
						begin
							set @nResult_ = @RESULT_ERROR_INVEN_FULL
							set @comment = 'ERROR 동물 인벤이 풀입니다.'
							--select 'DEBUG ' + @comment, @invencnt invencnt, @invenanimalmax invenanimalmax
						end
					else if(@anibuycnt >= @ANIMAL_BUY_DAILY_FULL)
						begin
							set @nResult_ = @RESULT_ERROR_ANIMAL_DAILY_FULL
							set @comment = 'ERROR 1일 동물 구매 수량을 초과했습니다.'
							--select 'DEBUG ' + @comment
						end
					else
						begin
							--select 'DEBUG 4-2-1 인벤 or 필드', @gameid_ gameid_, @listidxnew listidxnew, @itemcode_ itemcode_
							if(@fieldidx_ = -1)
								begin
									set @fieldidx = @fieldidx_
									--select 'DEBUG 4-2-1-1 필드풀이라서 인벤에 넣어두라.', @fieldidx fieldidx
								end
							else if(exists(select top 1 * from dbo.tUserItem where gameid = @gameid_ and fieldidx = @fieldidx_))
								begin
									---------------------------------------------------
									-- 빈자리 찾기 커서
									-- 0   2 3 4 5 		 >  1
									-- 0 1 2 3 4 5 		 >  6
									-- 0 1 2 3 4 5 6 7 8 > -1
									---------------------------------------------------
									set @fieldidx = dbo.fun_getUserItemFieldIdxAni(@gameid_)
									--select 'DEBUG 4-2-1-2 지정(충돌)', @fieldidx fieldidx
								end
							else
								begin
									set @fieldidx = @fieldidx_
									--select 'DEBUG 4-2-1-3 필드가 유효해서 그대로 넣어라.', @fieldidx fieldidx
								end

							-- 필드가 허용하는 범위인가?
							set @fieldidx = dbo.fun_getUserItemFieldCheck(@fieldidx,
																		  @field0, @field1, @field2,
																		  @field3, @field4, @field5,
																		  @field6, @field7, @field8)

							-- 해당아이템 인벤에 지급
							insert into dbo.tUserItem(gameid,      listidx,   itemcode, cnt, farmnum,  fieldidx,  invenkind,   randserial,  upstepmax, gethow)		-- 동물.
							values(					 @gameid_, @listidxnew, @itemcode_,   1,       0, @fieldidx, @invenkind, @randserial_, @upstepmax, @DEFINE_HOW_GET_BUY)

							-- 도감기록
							exec spu_DogamListLog @gameid_, @itemcode_

							-- 캐쉬 or 코인차감 > 하단에서 지급함.
							set @cashcost = @cashcost - @cashcostsell
							set @gamecost = @gamecost - @gamecostsell

							-- 구매기록마킹
							exec spu_UserItemBuyLogNew @gameid_, @itemcode_, @gamecostsell, @cashcostsell, 0

							-- 일일 동물 구매수량.
							set @anibuycnt = @anibuycnt + 1

							-- 변경된 아이템 리스트인덱스
							set @listidxrtn	= @listidxnew
						end
				end
			else if(@invenkind = @USERITEM_INVENKIND_CONSUME)
				begin
					--------------------------------------------------------------
					-- 소모 아이템 > 인벤수량파악
					--------------------------------------------------------------
					select @invencnt = count(*)
					from dbo.tUserItem
					where gameid = @gameid_
						  and invenkind = @invenkind
						  and cnt > 0
					--select 'DEBUG 4-3 소비(3)인벤넣기', @invencnt invencnt, @invencustommax invencustommax

					----------------------------------------------------------------
					---- 총알					-> 소모성 아이템0
					---- 백신					-> 소모성 아이템0
					---- 촉진제					-> 소모성 아이템0
					---- 알바					-> 소모성 아이템0
					---- 부활석					-> 소모성 아이템 (여러코드 > 1개로 통일됨)
					---- 대회용 티켓			-> 소모성 아이템
					---- 교배 티켓				-> 소모성 아이템
					---- 긴급요청 티켓			-> 소모성 아이템 (여러코드 > 1개로 통일됨)
					---- 상인 100% 만족 티켓	-> 소모성 아이템
					---- 시간초기화템 			-> 소모성 아이템
					----------------------------------------------------------------
					set @itemcode_ = dbo.fnu_GetItemcodeFromConsumePackage(@subcategory, @itemcode_)

					select
						@cnt 			= cnt,
						@listidxcust 	= listidx
					from dbo.tUserItem
					where gameid = @gameid_ and itemcode = @itemcode_
					--select 'DEBUG 4-3 소비(n)인벤넣기', @gameid_ gameid_, @itemcode_ itemcode_, @listidxcust listidxcust, @cnt cnt

					-------------------------------------------------
					-- 링크 번호 오류에 대한 방어코드.
					-------------------------------------------------
					if(@listidx_ =  -1 and @listidxcust != -1)
						begin
							-- 링크 번호가 없다고 하는데 링크 번호가 있네요. > 재세팅.
							set @listidx_ = @listidxcust
						end


					if(@listidx_ = -1 and (@invencnt >= (@invencustommax + 4)))
						begin
							set @nResult_ = @RESULT_ERROR_INVEN_FULL
							set @comment = 'ERROR 소비 인벤이 풀입니다.'
							--select 'DEBUG ' + @comment
						end
					else if (@cnt + @buyamount > @CONSUME_MAX_COUNT)
						BEGIN
							set @nResult_ = @RESULT_ERROR_MAXCOUNT
							set @comment = 'ERROR 구매수량('+ltrim(rtrim(str(@cnt + @buyamount)))+')이 맥스초과('+ltrim(rtrim(str(@CONSUME_MAX_COUNT)))+') 하였습니다.'
							--select 'DEBUG ' + @comment
						END
					else if(@listidx_ !=  @listidxcust)
						begin
							set @nResult_ = @RESULT_ERROR_NOT_MATCH
							set @comment = 'ERROR 소모템의 지정리스트('+ltrim(rtrim(str(@listidx_)))+') 내부존재번호('+ltrim(rtrim(str(@listidxcust)))+')가 불일치.'
							--select 'DEBUG ' + @comment
						end
					else
						begin
							--select 'DEBUG 4-3-2 인벤으로 이동, 이벤 지급 상태로 변경'
							---------------------------------------------------
							-- 빈자리 찾기 커서
							-- 0 [1] 2 3 4 5 	> [1] > update
							-- 0 1 2 3 4 5 6  	> 없음 > insert
							-- @listidxcust = @listidx_ (동일함)
							---------------------------------------------------
							if(@listidxcust = -1)
								begin
									--select 'DEBUG 소비 추가', @gameid_ gameid_, @listidxnew listidxnew, @itemcode_ itemcode_, @buyamount buyamount

									insert into dbo.tUserItem(gameid,      listidx,   itemcode,        cnt,  invenkind,   randserial, gethow)
									values(					@gameid_,  @listidxnew, @itemcode_, @buyamount, @invenkind, @randserial_, @DEFINE_HOW_GET_BUY)

									-- 변경된 아이템 리스트인덱스
									set @listidxrtn	= @listidxnew
								end
							else
								begin
									--select 'DEBUG 소비 보유템에 누적', @gameid_ gameid_, @listidxcust listidxcust, @buyamount buyamount

									update dbo.tUserItem
										set
											cnt = cnt + @buyamount,
											randserial = @randserial_
									where gameid = @gameid_ and listidx = @listidxcust

									-- 변경된 아이템 리스트인덱스
									set @listidxrtn	= @listidxcust
								end

							if(@quickkind_ = @USERMASTER_QUICKKIND_SETTING)
								begin
									--select 'DEBUG > 세팅을 추가한다.'
									update dbo.tUserMaster
										set
											bulletlistidx 	= case when (@subcategory = @ITEM_SUBCATEGORY_BULLET) 	then @listidxrtn else bulletlistidx end,
											vaccinelistidx	= case when (@subcategory = @ITEM_SUBCATEGORY_VACCINE) 	then @listidxrtn else vaccinelistidx end,
											boosterlistidx	= case when (@subcategory = @ITEM_SUBCATEGORY_BOOSTER)	then @listidxrtn else boosterlistidx end,
											albalistidx		= case when (@subcategory = @ITEM_SUBCATEGORY_ALBA) 	then @listidxrtn else albalistidx end
									where gameid = @gameid_
								end

							-- 캐쉬 or 코인차감 > 하단에서 지급함.
							set @cashcost = @cashcost - @cashcostsell
							set @gamecost = @gamecost - @gamecostsell

							-- 구매기록마킹
							exec spu_UserItemBuyLogNew @gameid_, @itemcode_, @gamecostsell, @cashcostsell, 0


							-- 변경된 아이템 리스트인덱스
							-- > 위에서 각각 처리함.
						end
				end
			else if(@invenkind = @USERITEM_INVENKIND_ACC)
				begin
					--------------------------------------------------------------
					-- 악세					-> 수량파악
					--------------------------------------------------------------
					select @invencnt = count(*)
					from dbo.tUserItem
					where gameid = @gameid_
						  and invenkind = @invenkind
					--select 'DEBUG 4-4 악세(4)인벤넣기', @invencnt invencnt, @invenaccmax invenaccmax

					--------------------------------------------------------------
					-- 악세					-> 악세 아이템
					--------------------------------------------------------------
					if(@invencnt >= @invenaccmax)
						begin
							set @nResult_ = @RESULT_ERROR_INVEN_FULL
							set @comment = 'ERROR 악세 인벤이 풀입니다.'
							--select 'DEBUG ' + @comment, @invenaccmax invenaccmax
						end
					else
						begin
							--select 'DEBUG 4-4-2 인벤으로 이동, 이벤 지급 상태로 변경', @gameid_ gameid_, @listidxnew listidxnew, @itemcode_ itemcode_

							-- 해당아이템 인벤에 지급
							insert into dbo.tUserItem(gameid,      listidx,   itemcode,  invenkind,   randserial, gethow)		-- 악세
							values(					 @gameid_, @listidxnew, @itemcode_, @invenkind, @randserial_, @DEFINE_HOW_GET_BUY)

							-- 캐쉬 or 코인차감 > 하단에서 지급함.
							set @cashcost = @cashcost - @cashcostsell
							set @gamecost = @gamecost - @gamecostsell

							-- 구매기록마킹
							exec spu_UserItemBuyLogNew @gameid_, @itemcode_, @gamecostsell, @cashcostsell, 0

							-- 변경된 아이템 리스트인덱스
							set @listidxrtn	= @listidxnew
						end
				end
			---------------------------------------------------------------
			--else if(@subcategory = @ITEM_SUBCATEGORY_CASHCOST)
			-- 별도구현.
			---------------------------------------------------------------
			else if(@subcategory = @ITEM_SUBCATEGORY_GAMECOST)
				begin
					-- 추가 환전.
					select top 1 @plusgamecost = plusgamecost from dbo.tSystemInfo order by idx desc
					select @eventplus = param3 from dbo.tItemInfo where itemcode = @itemcode_
					if(@eventplus = 0)
						begin
							set @plusgamecost = 0
						end
					--select 'DEBUG 4-4-3 환전(전)', @buyamount buyamount, @cashcost cashcost, @gamecost gamecost

					set @plus		= isnull(@buyamount, 0)
					set @gamecost	= @gamecost + (@plus + (@plus * @plusgamecost)/100)

					set @vip_plus 	= dbo.fun_GetVIPPlus( 2, @cashpoint, @plus) -- 코인구매.
					set @gamecost	= @gamecost + @vip_plus

					-- 캐쉬 or 코인차감 > 하단에서 지급함.
					set @cashcost = @cashcost - @cashcostsell
					set @gamecost = @gamecost - @gamecostsell

					-- 구매기록마킹
					exec spu_UserItemBuyLogNew @gameid_, @itemcode_, @gamecostsell, @cashcostsell, 0

					-- 변경된 아이템 리스트인덱스
					-- 필요없음.
					--select 'DEBUG 4-5-3 환전(후)', @buyamount buyamount, @cashcost cashcost, @gamecost gamecost
				end
			else if(@subcategory = @ITEM_SUBCATEGORY_HEART)
				begin
					-- 추가 환전.
					select top 1 @plusheart = plusheart from dbo.tSystemInfo order by idx desc
					select @eventplus = param3 from dbo.tItemInfo where itemcode = @itemcode_
					if(@eventplus = 0)
						begin
							set @plusheart = 0
						end

					--select 'DEBUG 4-5-3 하트(전)', @heart heart, @buyamount buyamount, @cashcost cashcost, @gamecost gamecost
					set @plus		= isnull(@buyamount, 0)
					set @heart		= @heart + (@plus + (@plus * @plusheart)/100)

					set @vip_plus 	= dbo.fun_GetVIPPlus( 3, @cashpoint, @plus) --하트구매.
					set @heart		= @heart + @vip_plus

					-- 캐쉬 or 코인차감 > 하단에서 지급함.
					set @cashcost = @cashcost - @cashcostsell
					set @gamecost = @gamecost - @gamecostsell

					-- 구매기록마킹
					exec spu_UserItemBuyLogNew @gameid_, @itemcode_, @gamecostsell, @cashcostsell, 0

					-- 변경된 아이템 리스트인덱스
					-- 필요없음.
					--select 'DEBUG 4-5-3 하트(후)', @heart heart, @buyamount buyamount, @cashcost cashcost, @gamecost gamecost
				end
			else if(@subcategory = @ITEM_SUBCATEGORY_FEED)
				begin
					-- 추가 환전.
					select top 1 @plusfeed = plusfeed from dbo.tSystemInfo order by idx desc

					-- 맥스 초과되더라더 초과해서 들어간다.
					--select 'DEBUG 4-5-4 건초(전)', @feed feed, @buyamount buyamount, @cashcost cashcost, @gamecost gamecost
					set @plus		= isnull(@buyamount, 0)
					set @feed		= @feed + (@plus + (@plus * @plusfeed)/100)

					-- 캐쉬 or 코인차감 > 하단에서 지급함.
					set @cashcost = @cashcost - @cashcostsell
					set @gamecost = @gamecost - @gamecostsell

					-- 구매기록마킹
					exec spu_UserItemBuyLogNew @gameid_, @itemcode_, @gamecostsell, @cashcostsell, 0

					-- 변경된 아이템 리스트인덱스
					-- 필요없음.
					--select 'DEBUG 4-5-3 건초(전)', @feed feed, @buyamount buyamount, @cashcost cashcost, @gamecost gamecost
				end
			else if(@subcategory = @ITEM_SUBCATEGORY_GOLDTICKET)
				begin
					-- 추가 환전.
					select top 1 @plusgoldticket = plusgoldticket from dbo.tSystemInfo order by idx desc
					select @eventplus = param3 from dbo.tItemInfo where itemcode = @itemcode_
					if(@eventplus = 0)
						begin
							set @plusgoldticket = 0
						end

					set @plus		= isnull(@buyamount, 0)
					set @goldticket	= @goldticket + (@plus + (@plus * @plusgoldticket)/100)
					--select 'DEBUG 4-4-3 환전(전)', @buyamount buyamount, @plus plus, @plusgoldticket plusgoldticket, @eventplus eventplus, @goldticket goldticket

					-- 캐쉬 or 코인차감 > 하단에서 지급함.
					set @cashcost = @cashcost - @cashcostsell
					set @gamecost = @gamecost - @gamecostsell

					-- 구매기록마킹
					exec spu_UserItemBuyLogNew @gameid_, @itemcode_, @gamecostsell, @cashcostsell, 0
				end
			else if(@subcategory = @ITEM_SUBCATEGORY_BATTLETICKET)
				begin
					-- 추가 환전.
					select top 1 @plusbattleticket = plusbattleticket from dbo.tSystemInfo order by idx desc
					select @eventplus = param3 from dbo.tItemInfo where itemcode = @itemcode_
					if(@eventplus = 0)
						begin
							set @plusbattleticket = 0
						end

					set @plus		= isnull(@buyamount, 0)
					set @battleticket= @battleticket + (@plus + (@plus * @plusbattleticket)/100)
					--select 'DEBUG 4-4-3 환전(전)', @buyamount buyamount, @plus plus, @plusbattleticket plusbattleticket, @eventplus eventplus, @itemcode_ itemcode_

					-- 캐쉬 or 코인차감 > 하단에서 지급함.
					set @cashcost = @cashcost - @cashcostsell
					set @gamecost = @gamecost - @gamecostsell

					-- 구매기록마킹
					exec spu_UserItemBuyLogNew @gameid_, @itemcode_, @gamecostsell, @cashcostsell, 0
				end
			else
				begin
					--------------------------------------------------------------
					-- seed(선물없음)	-> 없음
					-- 업그레이드		-> 없음
					--------------------------------------------------------------
					--select 'DEBUG 4-7 정보표시용'

					set @dummy = 0
				end
		END


	--------------------------------------------------------------
	-- 코드(캐쉬, 코인, 하트, 건초)
	--------------------------------------------------------------
	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost, @heart heart, @feed feed, @fpoint fpoint, @goldticket goldticket, @battleticket battleticket

	if(@nResult_ = @RESULT_SUCCESS)
		begin
			-- 아이템을 직접 넣어줌
			update dbo.tUserMaster
				set
					cashcost	= @cashcost,	gamecost	= @gamecost,	heart		= @heart,	feed		= @feed,
					anibuydate	= @anibuydate, 	anibuycnt	= @anibuycnt,
					goldticket 	= @goldticket, 	battleticket= @battleticket
			where gameid = @gameid_

			--------------------------------------------------------------
			-- 유저 보유 아이템 정보 > 새로 획득한 것만 전송(기존것 하고 같이 보내면 클라것의 데이터를 덮씌워서 문제됨)
			--------------------------------------------------------------
			select * from dbo.tUserItem
			where gameid = @gameid_ and listidx = @listidxrtn
		end

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
End

