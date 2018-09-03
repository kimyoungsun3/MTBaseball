use Game4FarmVill3
GO

IF OBJECT_ID ( 'dbo.spu_SamplePro', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_SamplePro;
GO

create procedure dbo.spu_SamplePro
	@gameid_				varchar(60),						-- 게임아이디
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

	-- 아이디 생성
	declare @RESULT_ERROR_ID_DUPLICATE			int				set @RESULT_ERROR_ID_DUPLICATE			= -2
	declare @RESULT_ERROR_ID_CREATE_MAX 		int				set @RESULT_ERROR_ID_CREATE_MAX			= -3	-- 생성제한.

	-- 로그인 오류.
	declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--블럭유저 > 팝업처리후 인트로로 빼버린다.
	declare @RESULT_ERROR_DELETED_USER 			int				set @RESULT_ERROR_DELETED_USER			= -12			--삭제유저 > 팝업처리후 인트로로 빼버린다.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함
	declare @RESULT_ERROR_NOT_FOUND_PASSWORD	int				set @RESULT_ERROR_NOT_FOUND_PASSWORD	= -17
	declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--서버를 점검하고 있다.
	declare @RESULT_NEWVERION_CLIENT_DOWNLOAD 	int				set @RESULT_NEWVERION_CLIENT_DOWNLOAD	= -15			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 링크처리.
	declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 종료.
	declare @RESULT_ERROR_NOT_FOUND_PHONE 		int				set @RESULT_ERROR_NOT_FOUND_PHONE		= -76			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 종료.

	-- 게임중에 부족.
	declare @RESULT_ERROR_HEART_LACK			int				set @RESULT_ERROR_HEART_LACK			= -20			--하트이 부족하다.
	declare @RESULT_ERROR_GAMECOST_LACK			int				set @RESULT_ERROR_GAMECOST_LACK			= -21			--실버가 부족하다.
	declare @RESULT_ERROR_CASHCOST_LACK			int				set @RESULT_ERROR_CASHCOST_LACK			= -22			--골드가 부족하다.
	declare @RESULT_ERROR_ITEM_LACK				int				set @RESULT_ERROR_ITEM_LACK				= -23			--아이템이부족하다.
	declare @RESULT_ERROR_FPOINT_LACK			int				set @RESULT_ERROR_FPOINT_LACK			= -124			--

	-- 아이템 구매, 변경.
	declare @RESULT_ERROR_BUY_ALREADY			int				set @RESULT_ERROR_BUY_ALREADY			= -31			--이미 구매했습니다.
	declare @RESULT_ERROR_NOT_HAVE				int				set @RESULT_ERROR_NOT_HAVE				= -32			--보유하지 않고 있다.
	declare @RESULT_ERROR_UPGRADE_FULL			int				set @RESULT_ERROR_UPGRADE_FULL			= -35			--업그레이드가 풀로되었다.
	declare @RESULT_ERROR_ITEM_NOSALE_KIND		int				set @RESULT_ERROR_ITEM_NOSALE_KIND		= -37			--판매하지 않는 아이템

	-- 캐쉬구매.
	declare @RESULT_ERROR_CASH_COPY				int				set @RESULT_ERROR_CASH_COPY				= -40
	declare @RESULT_ERROR_CASH_OVER				int				set @RESULT_ERROR_CASH_OVER				= -41
	declare @RESULT_ERROR_MONTH_OVER			int				set @RESULT_ERROR_MONTH_OVER			= -42			--한달동안 구매한도를 검사

	-- 선물 코드값
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- 아이템코드못찾음
	declare @RESULT_ERROR_GIFTITEM_NOT_FOUND	int				set @RESULT_ERROR_GIFTITEM_NOT_FOUND	= -51			-- 선물아이템을 못찾음
	declare @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	int				set @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	= -52			-- 선물을 이미 가져감
	declare @RESULT_ERROR_NOT_FOUND_GIFTID		int				set @RESULT_ERROR_NOT_FOUND_GIFTID		= -75			-- 캐쉬 > 선물할 아이디를 못찾음

	-- SMS
	declare @RESULT_ERROR_SMS_NOT_MATCH_PHONE	int				set @RESULT_ERROR_SMS_NOT_MATCH_PHONE	= -80			--문자추천.
	declare @RESULT_ERROR_SMS_KEY_DUPLICATE		int				set @RESULT_ERROR_SMS_KEY_DUPLICATE		= -81
	declare @RESULT_ERROR_SMS_REJECT			int				set @RESULT_ERROR_SMS_REJECT			= -84
	declare @RESULT_ERROR_SMS_DOUBLE_PHONE		int				set @RESULT_ERROR_SMS_DOUBLE_PHONE		= -85
	declare @RESULT_ERROR_KEY_DUPLICATE			int				set @RESULT_ERROR_KEY_DUPLICATE			= -86			-- 일반 키가 중복되었다.

	-- 기타오류
	declare @RESULT_ERROR_RESULT_COPY			int				set @RESULT_ERROR_RESULT_COPY			= -53			-- 결과카피시도
	declare @RESULT_ERROR_GAMECOST_COPY			int				set @RESULT_ERROR_GAMECOST_COPY			= -54			-- 실버카피시도
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- 지원하지않는모드
	declare @RESULT_ERROR_HEART_FULL			int				set @RESULT_ERROR_HEART_FULL			= -71			-- 지원하지않는모드
	declare @RESULT_ERROR_TUTORIAL_ALREADY		int				set @RESULT_ERROR_TUTORIAL_ALREADY		= -73			-- 투토리얼 이미 보상.
	declare @RESULT_ERROR_NOT_FOUND_OTHERID		int				set @RESULT_ERROR_NOT_FOUND_OTHERID		= -83
	declare @RESULT_ERROR_INVEN_FULL			int				set @RESULT_ERROR_INVEN_FULL			= -101			-- 인벤부족
	declare @RESULT_ERROR_DAILY_REWARD_ALREADY	int				set @RESULT_ERROR_DAILY_REWARD_ALREADY	= -102			-- 일일보상 이미 보상.
	declare @RESULT_ERROR_NOT_FOUND_DOGAMIDX	int				set @RESULT_ERROR_NOT_FOUND_DOGAMIDX	= -103			-- 도감번호를 찾을수 없음.
	declare @RESULT_ERROR_DOGAM_ALREADY_REWARD	int				set @RESULT_ERROR_DOGAM_ALREADY_REWARD	= -104			-- 도감을 이미 지급했음.
	declare @RESULT_ERROR_DOGAM_LACK			int				set @RESULT_ERROR_DOGAM_LACK			= -105			-- 도감중에 동물번호가 부족함.
	declare @RESULT_ERROR_ANIMAL_NOT_FOUND		int				set @RESULT_ERROR_ANIMAL_NOT_FOUND		= -106			-- 대표동물 못찾음
	declare @RESULT_ERROR_ANIMAL_NOT_INVEN		int				set @RESULT_ERROR_ANIMAL_NOT_INVEN		= -107			-- 인벤에 없음(창고)
	declare @RESULT_ERROR_ANIMAL_NOT_ALIVE		int				set @RESULT_ERROR_ANIMAL_NOT_ALIVE		= -108			-- 살아 있지 않음
	declare @RESULT_ERROR_ANIMAL_IS_ALIVE		int				set @RESULT_ERROR_ANIMAL_IS_ALIVE		= -116			-- 동물이 살아있다.
	declare @RESULT_ERROR_ANIMAL_FIELDIDX		int				set @RESULT_ERROR_ANIMAL_FIELDIDX		= -117			-- 필드인덱스오류.
	declare @RESULT_ERROR_NOT_MATCH				int				set @RESULT_ERROR_NOT_MATCH				= -110			-- 무엇인가 매치가 안되었다.
	declare @RESULT_ERROR_DOUBLE_RANDSERIAL		int				set @RESULT_ERROR_DOUBLE_RANDSERIAL		= -111			-- 랜덤시리얼 중복.
	declare @RESULT_ERROR_MAXCOUNT				int				set @RESULT_ERROR_MAXCOUNT				= -112			-- 맥스카운터.
	declare @RESULT_ERROR_ITEMCOST_WRONG		int				set @RESULT_ERROR_ITEMCOST_WRONG		= -113			-- 아이템 가격이 이상함.
	declare @RESULT_ERROR_LISTIDX_NOT_FOUND		int				set @RESULT_ERROR_LISTIDX_NOT_FOUND		= -114			-- 리스트 번호를 못찾음.
	declare @RESULT_ERROR_NOT_ENOUGH			int				set @RESULT_ERROR_NOT_ENOUGH			= -115			-- 무엇인가 충분하지 않음.
	declare @RESULT_ERROR_NOT_FOUND_SEEDIDX		int				set @RESULT_ERROR_NOT_FOUND_SEEDIDX		= -118			-- 파라미터 오류.
	declare @RESULT_ERROR_PLANT_ALREADY			int				set @RESULT_ERROR_PLANT_ALREADY			= -119			-- 이미 씨앗이 심어져있음.
	declare @RESULT_ERROR_NEED_BUY				int				set @RESULT_ERROR_NEED_BUY				= -120			-- 경작지가 미구매상태.
	declare @RESULT_ERROR_HARVEST_TIME_REMAIN	int				set @RESULT_ERROR_HARVEST_TIME_REMAIN	= -121			-- 아직 시간이 남음.
	declare @RESULT_ERROR_PARAMETER				int				set @RESULT_ERROR_PARAMETER				= -122			-- 파라미터오류.
	declare @RESULT_ERROR_TIME_REMAIN			int				set @RESULT_ERROR_TIME_REMAIN			= -123			-- 아직 시간이 남음.
	declare @RESULT_ERROR_NOT_FOUND_USERFARM	int				set @RESULT_ERROR_NOT_FOUND_USERFARM	= -125			-- 목장리스트가 미구매.
	declare @RESULT_ERROR_ALREADY_REWARD		int				set @RESULT_ERROR_ALREADY_REWARD		= -126			-- 무엇인가 이미보상했음.
	declare @RESULT_ERROR_CANNT_CHANGEDAY_SCHOOL	int			set @RESULT_ERROR_CANNT_CHANGEDAY_SCHOOL= -127			-- 학교대항전을 변경못함.
	declare @RESULT_ERROR_CANNT_JOINDAY_SCHOOL	int				set @RESULT_ERROR_CANNT_JOINDAY_SCHOOL	= -128			-- 학교대항전을 가입불가.
	declare @RESULT_ERROR_CANNT_FIND_SCHOOL		int				set @RESULT_ERROR_CANNT_FIND_SCHOOL		= -129			-- 학교대항전을 학교를 찾을수 없음.
	declare @RESULT_ERROR_CANNT_JOINMAX_SCHOOL	int				set @RESULT_ERROR_CANNT_JOINMAX_SCHOOL	= -130			-- 학교대항전을 학교가 맥스입니다.
	declare @RESULT_ERROR_FRIEND_WAIT_MAX		int				set @RESULT_ERROR_FRIEND_WAIT_MAX		= -131			-- 친구 대기 맥스(더이상 친구 신청을 할 수 없습니다.)
	declare @RESULT_ERROR_FRIEND_AGREE_MAX		int				set @RESULT_ERROR_FRIEND_AGREE_MAX		= -132			-- 친구 맥스(더 이상 친구를 맺을 수 없습니다.)
	declare @RESULT_ERROR_NOT_FOUND_CERTNO		int				set @RESULT_ERROR_NOT_FOUND_CERTNO		= -133			-- 쿠폰 번호가 없음.
	declare @RESULT_ERROR_NO_MORE_PET			int				set @RESULT_ERROR_NO_MORE_PET			= -134			-- 더이상 펫이 없다.
	declare @RESULT_ERROR_HELP_TIME_REMAIN		int				set @RESULT_ERROR_HELP_TIME_REMAIN		= -140			-- Help 타임이 아직남음.
	declare @RESULT_ERROR_CANNOT_USED_NICKNAME	int				set @RESULT_ERROR_CANNOT_USED_NICKNAME	= -141			-- 닉네임 사용불가.
	declare @RESULT_ERROR_JOIN_WAIT				int				set @RESULT_ERROR_JOIN_WAIT				= -142			-- 가입시간대기.
	declare @RESULT_ERROR_ALREADY_REWARD_COUPON	int				set @RESULT_ERROR_ALREADY_REWARD_COUPON	= -143			-- 쿠폰은 1인 1매.
	declare @RESULT_ERROR_ACC_SAMEPART			int				set @RESULT_ERROR_ACC_SAMEPART			= -144			-- 악세사리가 동일 파트이다.
	declare @RESULT_ERROR_ACC_EMPTY_CREATE		int				set @RESULT_ERROR_ACC_EMPTY_CREATE		= -145			-- 악세사리가 빈곳에 생성할려고한다.
	declare @RESULT_ERROR_CANNT_CHANGE			int				set @RESULT_ERROR_CANNT_CHANGE			= -146			-- 변경할 수 없습니다..
	declare @RESULT_ERROR_ALIVE_USER			int				set @RESULT_ERROR_ALIVE_USER			= -147			-- 현재 활동하는 유저입니다.
	declare @RESULT_ERROR_WAIT_RETURN			int				set @RESULT_ERROR_WAIT_RETURN			= -148			-- 요청 대기중입니다.
	declare @RESULT_ERROR_KAKAO_MESSAGE_BLOCK	int				set @RESULT_ERROR_KAKAO_MESSAGE_BLOCK	= -149			-- 메세지 수신거부상태입니다
	declare @RESULT_ERROR_HEART_ROUL_3TIME_OVER	int				set @RESULT_ERROR_HEART_ROUL_3TIME_OVER	= -150			-- 무료 하트뽑기 1일 3회를 초과했습니다.

	------------------------------------------------
	--	2-2. 정의값
	------------------------------------------------
	-- 구매처코드
	declare @MARKET_SKT							int					set @MARKET_SKT						= 1
	declare @MARKET_KT							int					set @MARKET_KT						= 2
	declare @MARKET_LGT							int					set @MARKET_LGT						= 3
	declare @MARKET_GOOGLE						int					set @MARKET_GOOGLE					= 5
	declare @MARKET_NHN							int					set @MARKET_NHN						= 6
	declare @MARKET_IPHONE						int					set @MARKET_IPHONE					= 7

	-- (무료/유료코드)
	declare @BUYTYPE_FREE						int					set @BUYTYPE_FREE 					= 0	-- 무료가입 : 리워드 최소
	declare @BUYTYPE_PAY						int					set @BUYTYPE_PAY 					= 1	-- 유료가입 : 리워드 많음
	declare @BUYTYPE_PAY2						int					set @BUYTYPE_PAY2 					= 2	-- 유료가입(재가입)

	-- (플랫폼)
	declare @PLATFORM_ANDROID 					int					set @PLATFORM_ANDROID				= 1
	declare @PLATFORM_IPHONE 					int					set @PLATFORM_IPHONE				= 2

	-- 블럭상태값.
	declare @BLOCK_STATE_NO						int					set	@BLOCK_STATE_NO					= 0	-- 블럭상태아님
	declare @BLOCK_STATE_YES					int					set	@BLOCK_STATE_YES				= 1	-- 블럭상태

	-- 삭제상태값.
	declare @DELETE_STATE_NO					int					set	@DELETE_STATE_NO				= 0	-- 삭제상태아님
	declare @DELETE_STATE_YES					int					set	@DELETE_STATE_YES				= 1	-- 삭제상태

	-- 시스템 체킹
	declare @SYSCHECK_NON						int					set @SYSCHECK_NON					= 0
	declare @SYSCHECK_YES						int					set @SYSCHECK_YES					= 1

	-- 체킹
	declare @INFOMATION_NO						int					set @INFOMATION_NO					= -1
	declare @INFOMATION_YES						int					set @INFOMATION_YES					=  1

	-- bool
	declare @BOOL_TRUE							int					set @BOOL_TRUE						= 1
	declare @BOOL_FALSE							int					set @BOOL_FALSE						= 0

	-- 일반가입, 게스트 가입
	declare @JOIN_MODE_GUEST					int					set @JOIN_MODE_GUEST				= 1
	declare @JOIN_MODE_PLAYER					int					set @JOIN_MODE_PLAYER				= 2

	-- compose
	declare @COMPOSE_RESULT_SUCCESS				int					set @COMPOSE_RESULT_SUCCESS			= 1
	declare @COMPOSE_RESULT_FAIL				int					set @COMPOSE_RESULT_FAIL			= 0

	-- 아이템별 인벤분류
	declare @USERITEM_INVENKIND_ANI				int 				set @USERITEM_INVENKIND_ANI					= 1
	declare @USERITEM_INVENKIND_CONSUME			int 				set @USERITEM_INVENKIND_CONSUME				= 3
	declare @USERITEM_INVENKIND_ACC				int 				set @USERITEM_INVENKIND_ACC					= 4
	declare @USERITEM_INVENKIND_DIRECT			int 				set @USERITEM_INVENKIND_DIRECT				= 40
	declare @USERITEM_INVENKIND_INFO			int 				set @USERITEM_INVENKIND_INFO				= 60
	declare @USERITEM_INVENKIND_PET				int 				set @USERITEM_INVENKIND_PET					= 1000

	-- 아이템 대분류
	declare @ITEM_MAINCATEGORY_ANI				int					set @ITEM_MAINCATEGORY_ANI 					= 1 	--가축(1)
	declare @ITEM_MAINCATEGORY_CONSUME			int					set @ITEM_MAINCATEGORY_CONSUME 				= 3 	--소모품(3)
	declare @ITEM_MAINCATEGORY_ACC				int					set @ITEM_MAINCATEGORY_ACC 					= 4 	--액세서리(4)
	declare @ITEM_MAINCATEGORY_HEART			int					set @ITEM_MAINCATEGORY_HEART 				= 40 	--하트(40)
	declare @ITEM_MAINCATEGORY_CASHCOST			int					set @ITEM_MAINCATEGORY_CASHCOST 			= 50 	--캐쉬선물(50)
	declare @ITEM_MAINCATEGORY_GAMECOST			int					set @ITEM_MAINCATEGORY_GAMECOST 			= 51 	--코인선물(51)
	declare @ITEM_MAINCATEGORY_ROULETTE			int					set @ITEM_MAINCATEGORY_ROULETTE 			= 52 	--뽑기(52)
	declare @ITEM_MAINCATEGORY_CONTEST			int					set @ITEM_MAINCATEGORY_CONTEST 				= 53 	--대회(53)
	declare @ITEM_MAINCATEGORY_CONTRADE			int					set @ITEM_MAINCATEGORY_CONTRADE 			= 54 	--연속거래(54)
	declare @ITEM_MAINCATEGORY_TUTORIAL			int					set @ITEM_MAINCATEGORY_TUTORIAL				= 55 	--튜토리얼(55)
	declare @ITEM_MAINCATEGORY_FIELDOPEN		int					set @ITEM_MAINCATEGORY_FIELDOPEN			= 56 	--필드오픈(56)
	declare @ITEM_MAINCATEGORY_UPGRADE			int					set @ITEM_MAINCATEGORY_UPGRADE 				= 60 	--업글(60)
	declare @ITEM_MAINCATEGORY_INVEN			int					set @ITEM_MAINCATEGORY_INVEN 				= 67 	--인벤확장(67)
	declare @ITEM_MAINCATEGORY_SEEDFIEL			int					set @ITEM_MAINCATEGORY_SEEDFIEL 			= 68 	--경작지확장(68)
	declare @ITEM_MAINCATEGORY_USERFARM			int					set @ITEM_MAINCATEGORY_USERFARM 			= 69 	--전국목장(69)
	declare @ITEM_MAINCATEGORY_DOGAM			int					set @ITEM_MAINCATEGORY_DOGAM 				= 818 	--도감(818)
	declare @ITEM_MAINCATEGORY_GAMEINFO			int					set @ITEM_MAINCATEGORY_GAMEINFO 			= 500 	--정보수집(500)
	declare @ITEM_MAINCATEGORY_ATTENDANCE		int					set @ITEM_MAINCATEGORY_ATTENDANCE 			= 900 	--출석(900)
	--declare @ITEM_MAINCATEGORY_TUTORIAL		int					set @ITEM_MAINCATEGORY_TUTORIAL 			= 901 	--튜토리얼(901)
	declare @ITEM_MAINCATEGORY_EPISODE			int					set @ITEM_MAINCATEGORY_EPISODE	 			= 910 	--에피소드(910)
	declare @ITEM_MAINCATEGORY_PET				int					set @ITEM_MAINCATEGORY_PET		 			= 1000 	--펫(1000)
	declare @ITEM_MAINCATEGORY_COMPOSE			int					set @ITEM_MAINCATEGORY_COMPOSE	 			= 1010 	--동물합성(1010)

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
	declare @ITEM_SUBCATEGORY_COMPOSE_TIME		int					set @ITEM_SUBCATEGORY_COMPOSE_TIME 			= 16 -- 합성1시간 초기화(판매[X], 선물[O])
	declare @ITEM_SUBCATEGORY_ACC				int					set @ITEM_SUBCATEGORY_ACC 					= 15 -- 악세	(판매[O], 선물[O])
	declare @ITEM_SUBCATEGORY_FPOINT			int					set @ITEM_SUBCATEGORY_FPOINT 				= 19 -- 우정포인트(판매[X], 선물[O])
	declare @ITEM_SUBCATEGORY_HEART				int					set @ITEM_SUBCATEGORY_HEART 				= 40 -- 하트	(판매[O], 선물[O])
	declare @ITEM_SUBCATEGORY_HELPER			int					set @ITEM_SUBCATEGORY_HELPER 				= 41 -- 긴급요청(판매[X], 선물[O])
	declare @ITEM_SUBCATEGORY_TRADESAFE			int					set @ITEM_SUBCATEGORY_TRADESAFE				= 42 -- 상인만족(판매[X], 선물[O])
	declare @ITEM_SUBCATEGORY_CASHCOST			int					set @ITEM_SUBCATEGORY_CASHCOST 				= 50 -- 캐쉬	(판매[O], 선물[O])
	declare @ITEM_SUBCATEGORY_GAMECOST			int					set @ITEM_SUBCATEGORY_GAMECOST 				= 51 -- 코인	(판매[O], 선물[O])
	declare @ITEM_SUBCATEGORY_ROULETTE_NOR		int					set @ITEM_SUBCATEGORY_ROULETTE_NOR			= 22 -- 일반교배뽑기티켓(판매[X], 선물[O])
	declare @ITEM_SUBCATEGORY_ROULETTE_PRE		int					set @ITEM_SUBCATEGORY_ROULETTE_PRE			= 23 -- 프리미엄교배뽑기티켓(판매[X], 선물[O])
	declare @ITEM_SUBCATEGORY_CONTEST			int					set @ITEM_SUBCATEGORY_CONTEST 				= 53 -- 대회	(판매[O], 선물[O])
	declare @ITEM_SUBCATEGORY_CONTRADE			int					set @ITEM_SUBCATEGORY_CONTRADE 				= 54 -- 연속거래(54)
	declare @ITEM_SUBCATEGORY_TUTORIAL			int					set @ITEM_SUBCATEGORY_TUTORIAL 				= 55 -- 튜토리얼(55)
	declare @ITEM_SUBCATEGORY_FIELDOPEN			int					set @ITEM_SUBCATEGORY_FIELDOPEN				= 56 -- 필드오픈(56)
	declare @ITEM_SUBCATEGORY_UPGRADE_HOUSE		int					set @ITEM_SUBCATEGORY_UPGRADE_HOUSE 		= 60 -- 집
	declare @ITEM_SUBCATEGORY_UPGRADE_TANK		int					set @ITEM_SUBCATEGORY_UPGRADE_TANK 			= 61 -- 탱크
	declare @ITEM_SUBCATEGORY_UPGRADE_FRESHCOOL	int					set @ITEM_SUBCATEGORY_UPGRADE_FRESHCOOL 	= 62 -- 저온보관
	declare @ITEM_SUBCATEGORY_UPGRADE_PURE		int					set @ITEM_SUBCATEGORY_UPGRADE_PURE 			= 63 -- 정화시설
	declare @ITEM_SUBCATEGORY_UPGRADE_BOTTLE	int					set @ITEM_SUBCATEGORY_UPGRADE_BOTTLE 		= 64 -- 양동이
	declare @ITEM_SUBCATEGORY_UPGRADE_PUMP		int					set @ITEM_SUBCATEGORY_UPGRADE_PUMP 			= 65 -- 착유기
	declare @ITEM_SUBCATEGORY_UPGRADE_TRANSFER	int					set @ITEM_SUBCATEGORY_UPGRADE_TRANSFER 		= 66 -- 주입기
	declare @ITEM_SUBCATEGORY_INVEN				int					set @ITEM_SUBCATEGORY_INVEN 				= 67 -- 인벤확장
	declare @ITEM_SUBCATEGORY_SEEDFIELD			int					set @ITEM_SUBCATEGORY_SEEDFIELD 			= 68 -- 경작지확장
	declare @ITEM_SUBCATEGORY_USERFARM			int					set @ITEM_SUBCATEGORY_USERFARM	 			= 69 -- 전국목장
	declare @ITEM_SUBCATEGORY_DOGAM				int					set @ITEM_SUBCATEGORY_DOGAM 				= 818 -- 도감
	declare @ITEM_SUBCATEGORY_SYSINFO			int					set @ITEM_SUBCATEGORY_SYSINFO 				= 500 -- 정보수집
	declare @ITEM_SUBCATEGORY_ATTENDANCE		int					set @ITEM_SUBCATEGORY_ATTENDANCE 			= 900 	--출석(900)
	declare @ITEM_SUBCATEGORY_COMPETITION		int					set @ITEM_SUBCATEGORY_COMPETITION 			= 901 	--경쟁모드(901)
	--declare @ITEM_SUBCATEGORY_TRADEREWARD		int					set @ITEM_SUBCATEGORY_TRADEREWARD			= 902 	--초과거래(902)
	declare @ITEM_SUBCATEGORY_EPISODE			int					set @ITEM_SUBCATEGORY_EPISODE				= 910 	--에피소드(910)
	declare @ITEM_SUBCATEGORY_PET				int					set @ITEM_SUBCATEGORY_PET					= 1000 	--펫(1000)
	declare @ITEM_SUBCATEGORY_COMPOSE			int					set @ITEM_SUBCATEGORY_COMPOSE				= 1010 	--동물합성(1010)

	-- 선물 정의값
	declare @GIFTLIST_GIFT_KIND_MESSAGE			int					set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2
	declare @GIFTLIST_GIFT_KIND_MESSAGE_DEL		int					set @GIFTLIST_GIFT_KIND_MESSAGE_DEL			= -1
	declare @GIFTLIST_GIFT_KIND_GIFT_DEL		int					set @GIFTLIST_GIFT_KIND_GIFT_DEL			= -2
	declare @GIFTLIST_GIFT_KIND_GIFT_GET		int					set @GIFTLIST_GIFT_KIND_GIFT_GET			= -3
	declare @GIFTLIST_GIFT_KIND_GIFT_SELL		int					set @GIFTLIST_GIFT_KIND_GIFT_SELL			= -4

	-- 아이템 획득방법
	declare @DEFINE_HOW_GET_FIRST				int					set @DEFINE_HOW_GET_FIRST					= 0	--기본
	declare @DEFINE_HOW_GET_BUY					int					set @DEFINE_HOW_GET_BUY						= 1	--구매
	declare @DEFINE_HOW_GET_SEEDFIELD			int					set @DEFINE_HOW_GET_SEEDFIELD				= 2	--경작
	declare @DEFINE_HOW_GET_ROULETTE			int					set @DEFINE_HOW_GET_ROULETTE				= 3	--교배/뽑기
	declare @DEFINE_HOW_GET_SEARCH				int					set @DEFINE_HOW_GET_SEARCH					= 4	--검색
	declare @DEFINE_HOW_GET_GIFT				int					set @DEFINE_HOW_GET_GIFT					= 5	--선물
	declare @DEFINE_HOW_GET_TODAYBUY			int					set @DEFINE_HOW_GET_TODAYBUY				= 6	--[펫]오늘만판매
	declare @DEFINE_HOW_GET_PETROLL				int					set @DEFINE_HOW_GET_PETROLL					= 7	--[펫]뽑기
	declare @DEFINE_HOW_GET_ROULACC				int					set @DEFINE_HOW_GET_ROULACC					= 9	--악세뽑기
	declare @DEFINE_HOW_GET_ACCSTRIP			int					set @DEFINE_HOW_GET_ACCSTRIP				= 10--악세해제
	declare @DEFINE_HOW_GET_COMPOSE				int					set @DEFINE_HOW_GET_COMPOSE					= 11--합성
	declare @DEFINE_HOW_GET_YABAU				int					set @DEFINE_HOW_GET_YABAU					= 12--야바위뽑기

	-- 상수값들. (99)
	declare @PUSH_MODE_MSG						int					set @PUSH_MODE_MSG							= 1
	declare @PUSH_MODE_PEACOCK					int					set @PUSH_MODE_PEACOCK						= 2
	declare @PUSH_MODE_URL						int					set @PUSH_MODE_URL							= 3
	declare @PUSH_MODE_GROUP					int					set @PUSH_MODE_GROUP						= 99	-- 단체발송용

	-- 친구검색, 추가, 삭제
	declare @USERFRIEND_MODE_SEARCH				int					set	@USERFRIEND_MODE_SEARCH						= 1;
	declare @USERFRIEND_MODE_ADD				int					set	@USERFRIEND_MODE_ADD						= 2;
	declare @USERFRIEND_MODE_DELETE				int					set	@USERFRIEND_MODE_DELETE						= 3;
	declare @USERFRIEND_MODE_MYLIST				int					set	@USERFRIEND_MODE_MYLIST						= 4;
	declare @USERFRIEND_MODE_VISIT				int					set	@USERFRIEND_MODE_VISIT						= 5;

	-- 자랑하기를 통해서 보상받기.
	declare @BOARDWRITE_REWARD_GAMECOST			int					set @BOARDWRITE_REWARD_GAMECOST				= 500

	-- 죽은 or 부활모드.
	declare @USERITEM_MODE_DIE_INIT				int					set @USERITEM_MODE_DIE_INIT					= -1-- 초기상태.
	declare @USERITEM_MODE_DIE_PRESS			int					set @USERITEM_MODE_DIE_PRESS				= 1	-- 눌러 죽음.
	declare @USERITEM_MODE_DIE_EAT_WOLF			int					set @USERITEM_MODE_DIE_EAT_WOLF				= 2	-- 늑대 죽음.
	declare @USERITEM_MODE_DIE_EXPLOSE			int					set @USERITEM_MODE_DIE_EXPLOSE				= 3	-- 터져 죽음.
	declare @USERITEM_MODE_DIE_DISEASE			int					set @USERITEM_MODE_DIE_DISEASE				= 4	-- 질병 죽음.

	--부활.
	declare @USERITEM_MODE_REVIVAL_FIELD		int					set @USERITEM_MODE_REVIVAL_FIELD			= 1	-- 필드부활.
	declare @USERITEM_MODE_REVIVAL_HOSPITAL		int					set @USERITEM_MODE_REVIVAL_HOSPITAL			= 2	-- 병원부활.

	-- 기타 상수값
	declare @ID_MAX								int					set	@ID_MAX									= 9999	-- 한폰당 생성할 수 있는 아이디개수.

	-- 시설(업그레이드).
	declare @USERMASTER_UPGRADE_STATE_NON		int					set @USERMASTER_UPGRADE_STATE_NON			= -1	--미진행, 완료중.(유저)
	declare @USERMASTER_UPGRADE_STATE_ING		int					set @USERMASTER_UPGRADE_STATE_ING			= 1		--다음단계진행중.

	declare @USERMASTER_UPGRADE_KIND_NEXT		int					set @USERMASTER_UPGRADE_KIND_NEXT			= 1		-- 업그레이드 시작.
	declare @USERMASTER_UPGRADE_KIND_RIGHTNOW	int					set @USERMASTER_UPGRADE_KIND_RIGHTNOW		= 2		-- 업그레이드 즉시완료.

	-- 경작지(정보).
	declare @USERSEED_NEED_EMPTY				int					set @USERSEED_NEED_EMPTY					= -1	-- (경작지)
	declare @USERSEED_NEED_BUY					int					set @USERSEED_NEED_BUY						= -2

	-- 농장(정보).
	declare @USERFARM_BUYSTATE_NOBUY			int					set @USERFARM_BUYSTATE_NOBUY				= -1	-- (농장)
	declare @USERFARM_BUYSTATE_BUY				int					set @USERFARM_BUYSTATE_BUY					=  1

	-- 경작지(수확방식).
	declare @USERSEED_HARVEST_MODE_NORMAL     	int					set @USERSEED_HARVEST_MODE_NORMAL			= 1
	declare @USERSEED_HARVEST_MODE_RIGHTNOW  	int					set @USERSEED_HARVEST_MODE_RIGHTNOW			= 2

	-- >= 0 이상이면 특정 식물이 심어져있음.
	declare @GAME_START_YEAR					int					set @GAME_START_YEAR						= 2013	-- 게임 기본정보.
	declare @GAME_START_MONTH					int					set @GAME_START_MONTH						= 3
	declare @GAME_INVEN_ANIMAL_BASE				int					set @GAME_INVEN_ANIMAL_BASE					= 10	-- 대표1 + 동물9
	declare @GAME_INVEN_CUSTOME_BASE			int					set @GAME_INVEN_CUSTOME_BASE				= 6
	declare @GAME_INVEN_ACC_BASE				int					set @GAME_INVEN_ACC_BASE					= 4
	declare @GAME_INVEN_HOSPITAL_BASE			int					set @GAME_INVEN_HOSPITAL_BASE				= 10+9 -- 동물병원(병원10 + 필드9).
	declare @GAME_COMPETITION_BASE				int					set @GAME_COMPETITION_BASE					= 90106	-- 진행번호, -1은 없음.

	-- 동물정보.
	-- 필드동물 0 ~ 8.
	declare @USERITEM_FIELDIDX_INVEN			int					set @USERITEM_FIELDIDX_INVEN					= -1	-- 창고.
	declare @USERITEM_FIELDIDX_HOSPITAL			int					set @USERITEM_FIELDIDX_HOSPITAL					= -2	-- 병원.
	declare @USERITEM_INIT_ANISTEP				int					set @USERITEM_INIT_ANISTEP						= 5		-- 단계.
	declare @USERITEM_INIT_MANGER				int					set @USERITEM_INIT_MANGER						= 25	-- 여물통.
	declare @USERITEM_INIT_DISEASESTATE			int					set @USERITEM_INIT_DISEASESTATE					= 0		-- 질병상태.

	-- 소모템 > 퀵슬롯에 착용위치.
	declare @USERMASTER_QUICKKIND_NON			int					set @USERMASTER_QUICKKIND_NON				= -1 --없음.
	declare @USERMASTER_QUICKKIND_SETTING		int					set @USERMASTER_QUICKKIND_SETTING			=  1 --총알, 백신, 촉진, 알바(아이템 보고 세팅해줌).

	-- 교배뽑기 상수.
	declare @MODE_ROULETTE_NORMAL				int					set @MODE_ROULETTE_NORMAL					= 1	-- 일반교배.
	declare @MODE_ROULETTE_PREMINUM				int					set @MODE_ROULETTE_PREMINUM					= 2	-- 프리미엄교배.

	-- 코드번호.
	declare @REVIVAL_ITEMCODE					int					set @REVIVAL_ITEMCODE						= 1200			-- 부활템 코드번호.
	declare @CHANGE_TRADE_ITEMCODE				int					set @CHANGE_TRADE_ITEMCODE					= 50000			-- 상인변경.

	-- 보드에 글쓰기.
	--declare @BOARD_STATE_NON					int				set @BOARD_STATE_NON				= 0
	--declare @BOARD_STATE_REWARD				int				set @BOARD_STATE_REWARD				= 1
	declare @BOARD_STATE_REWARD_GAMECOST		int				set @BOARD_STATE_REWARD_GAMECOST	= 600

	-- 아이템 펫 모드.
	declare @USERITEM_MODE_PET_TODAYBUY			int					set @USERITEM_MODE_PET_TODAYBUY				= 1		-- 오늘만 이가격 추천 구매.
	declare @USERITEM_MODE_PET_ROLL				int					set @USERITEM_MODE_PET_ROLL					= 2		-- 뽑기.
	declare @USERITEM_MODE_PET_UPGRADE			int					set @USERITEM_MODE_PET_UPGRADE				= 3		-- 업급.
	declare @USERITEM_MODE_PET_WEAR				int					set @USERITEM_MODE_PET_WEAR					= 4		-- 장착.


	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @gameid			varchar(60)			set @gameid		= ''
	declare @comment		varchar(128)
	declare @cashcost 		int
	declare @gamecost 		int

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR

	select
		@gameid = gameid
	from dbo.tFVUserMaster where gameid = @gameid_ and password = @password_

	------------------------------------------------
	--	3-3. 유저생성.
	------------------------------------------------
	if exists (select * from tFVUserMaster where gameid = @gameid_)
		begin
			set @nResult_ = @RESULT_ERROR_ID_DUPLICATE
			set @comment = ' DEBUG (생성)아이디가 중복되었습니다.'
		end
	else
		begin
			set @nResult_ = @RESULT_SUCCESS
			set @comment = ' DEBUG (생성)가입을 축하합니다.'
		end

	/*
	------------------------------------------------------------------
	-- 스위치문
	------------------------------------------------------------------
	set @buypointplus = CASE
							WHEN (@buypointmin <= 0) then 100
							WHEN (@buypointmin <= 5) then 80
							WHEN (@buypointmin <= 10) then 60
							WHEN (@buypointmin <= 20) then 40
							WHEN (@buypointmin <= 40) then 20
							WHEN (@buypointmin <= 60) then 10
							ELSE 0
						END

	------------------------------------------------------------------
	-- select -> insert(읽어서 > 그대로 넣어주기)
	------------------------------------------------------------------
	insert into tMessage(gameid, comment)
		select @gameid_,  itemname + '가 만기가 되었습니다.'
		from @tItemExpire a, tItemInfo b where a.itemcode = b.itemcode

	-----------------------------------------------
	-- 유저 보유 아이템이 만기가되면 만기처리하고 시스템 메시지에 만기를 기록.
	-- 유저의 만기 통채로변경 > @변수테이블에 입력 > 일괄적용
	-- 2개 이상적용됨(테이블로 들어와서)
	-----------------------------------------------
	--declare @gameid_ varchar(20) set @gameid_ = 'SangSang'
	DECLARE @tItemExpire TABLE(
		idx bigint,
		gameid varchar(60),
		itemcode int
	);
	--select * from dbo.tUserItem where gameid = @gameid_
	update dbo.tUserItem
		set
			expirestate = @ITEM_EXPIRE_STATE_YES
			OUTPUT DELETED.idx, @gameid_, DELETED.itemcode into @tItemExpire
	where gameid = @gameid_ and expirestate = @ITEM_EXPIRE_STATE_NO and getdate() > expiredate


	------------------------------------------------------------------
	-- 유저 퀘스트 정보 업데이트
	------------------------------------------------------------------
	-- 로그인 > 대기중(1) and 시간이 유효 > 커서로 필터
	declare curQuestUser Cursor for
		select questkind, questsubkind, questclear from dbo.tQuestInfo
		where questcode in (select questcode from dbo.tQuestUser
							where gameid = @gameid_
								  and queststate = @QUEST_STATE_USER_WAIT
								  and getdate() > queststart)
		Open curQuestUser
		Fetch next from curQuestUser into @questkind, @questsubkind, @questclear
		while @@Fetch_status = 0
			Begin
				if(@questclear = @QUEST_CLEAR_START)
					begin
						-- select 'DEBUG 로그인 > 데이타 클리어해주세요.', @questkind, @questsubkind, @questclear
						-- exec spu_QuestCheck 1, 'superman3', 1000, 8, -1, -1
						exec spu_QuestCheck @QUEST_MODE_CLEAR, @gameid_, @questkind, @questsubkind, -1, -1
					end
				Fetch next from curQuestUser into @questkind, @questsubkind, @questclear
			end
		close curQuestUser
		Deallocate curQuestUser
	*/

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	select @nResult_ rtn, @comment comment, @gameid_ gameid

	set nocount off
End



