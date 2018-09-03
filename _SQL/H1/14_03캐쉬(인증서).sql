/*
gameid=xxx
password=xxx
acode=xxx
ucode=xxx
market=xxx
goldball=xxx
cash=xxx



-- select top 10 * from dbo.tCashLog
-- select top 10 * from dbo.tCashTotal
-- update  dbo.tUserMaster set goldball = 10000 where gameid = 'SangSang'
exec spu_CashBuy 1, 'SangSangl', '', 'a1s2d3f4', 'xxxxx', '60512345778998765442bcde3123192022161560004', 1, 1, 10, 1000, 10, 1000, -1		-- 아이디못찾음
exec spu_CashBuy 1, 'SangSang',  '', '1234', 'xxxxx', '60512345778998765442bcde3123192022161560004', 1, 1, 10, 1000, 10, 1000, -1			-- 패스워드틀림
exec spu_CashBuy 1, 'SangSang',  '', 'a1s2d3f4', 'xxxxx', '60512345778998765442bcde3123192022161560004', 1, 1, 10, 1000, 20, 1000, -1		-- 불일치
exec spu_CashBuy 1, 'SangSang',  '', 'a1s2d3f4', 'xxxxx', '60512345778998765442bcde3123192022161560004', 1, 0, 10, 1000, 10, 1000, -1		-- 섬오류
exec spu_CashBuy 1, 'SangSang',  '', 'a1s2d3f4', 'xxxxx', '60512345778998765442bcde3123192022161560004', 1, 1, 4000, 1000, 4000, 1000, -1	-- 골든볼조작
-- delete dbo.tCashLog where ucode = '60512345778998765442bcde3123192022161560004'
exec spu_CashBuy 1, 'SangSang', '', 'a1s2d3f4', 'xxxxx', '60512345778998765442bcde3123192022161560004', 1, 1, 10, 1000, 10, 1000, -1		-- 정상구매/두번째부터는 카피상태
exec spu_CashBuy 1, 'SangSang', '', 'a1s2d3f4', 'xxxxx', '11589012445665432119ijkl0890869799838258253', 1, 1, 10, 1000, 10, 1000, -1		-- 정상구매/두번째부터는 카피상태

-- 68867890323443210908ghijadef8678647567060340234		2000	21
-- 22490124956776543265jklmdghi1901970890393604229		5000	55
-- 35589015245665432450ijklcfgh0890869789282519232		29000	500
-- 89356784012332109401fghizcde7567536456959288242		50000	635
-- 65523466689009877863cdefwzab4234203123626951235		99000	1600
exec spu_CashBuy 1, 'SangSang', '', 'a1s2d3f4', 'xxxxx', '63234567090110987675defgxabc5345314235765769230', 2, 1, 21, 2000, 21, 2000, -1
exec spu_CashBuy 1, 'SangSang', '', 'a1s2d3f4', 'xxxxx', '49690124956776543265jklmdghi1901970891254406236', 1, 1, 55, 5000, 55, 5000, -1
exec spu_CashBuy 1, 'SangSang', '', 'a1s2d3f4', 'xxxxx', '21134560790110987905defgxabc5345314235698893239', 1, 1, 500, 29000, 500, 29000, -1
exec spu_CashBuy 1, 'SangSang', '', 'a1s2d3f4', 'xxxxx', '93889017345665432734ijklcfgh0890869780143360251', 1, 1, 635, 50000, 635, 50000, -1
exec spu_CashBuy 1, 'SangSang', '', 'a1s2d3f4', 'xxxxx', '24534577790110988974defgxabc5345314235765759230', 1, 1, 1600, 99000, 1600, 99000, -1
exec spu_CashBuy 1, 'dd10', '', '7575970askeie1595312', 'xxxxx', '24534577790110988974defgxabc5345314235765759230', 1, 1, 1600, 99000, 1600, 99000, -1

-- 친구에게 선물모드
exec spu_CashBuy 2, 'dd10', 'dd20', '7575970askeie1595312', 'xxxxx', '63234567090110987675defgxabc5345314235765769230', 1, 1, 21, 2000, 21, 2000, -1
exec spu_CashBuy 2, 'dd10', 'dd20', '7575970askeie1595312', 'xxxxx', '49690124956776543265jklmdghi1901970891254406236', 1, 1, 55, 5000, 55, 5000, -1
exec spu_CashBuy 2, 'dd10', 'dd20', '7575970askeie1595312', 'xxxxx', '21134560790110987905defgxabc5345314235698893239', 1, 1, 500, 29000, 500, 29000, -1
exec spu_CashBuy 2, 'dd10', 'dd20', '7575970askeie1595312', 'xxxxx', '93889017345665432734ijklcfgh0890869780143360251', 1, 1, 635, 50000, 635, 50000, -1
exec spu_CashBuy 2, 'dd10', 'dd20', '7575970askeie1595312', 'xxxxx', '24534577790110988974defgxabc5345314235765759230', 1, 1, 1600, 99000, 1600, 99000, -1

exec spu_CashBuy 1, 'SangSang', '', '7575970askeie1595312', 'xxxxx', '63234567090110987675defgxabc53453142357657692301', 1, 1, 21, 2000, 21, 2000, -1
exec spu_CashBuy 1, 'SangSang', '', '7575970askeie1595312', 'xxxxx', '63234567090110987675defgxabc53453142357657692302', 2, 1, 21, 2000, 21, 2000, -1
exec spu_CashBuy 1, 'SangSang', '', '7575970askeie1595312', 'xxxxx', '63234567090110987675defgxabc53453142357657692303', 3, 1, 21, 2000, 21, 2000, -1
exec spu_CashBuy 1, 'SangSang', '', '7575970askeie1595312', 'xxxxx', '63234567090110987675defgxabc53453142357657692304', 4, 1, 21, 2000, 21, 2000, -1
exec spu_CashBuy 1, 'SangSang', '', '7575970askeie1595312', 'xxxxx', '63234567090110987675defgxabc53453142357657692305', 4, 1, 21, 2000, 21, 2000, -1

exec spu_CashBuy 1, 'sususu2', '', '7575970askeie1595312', 'xxxxx', '63234567090110987675defgxabc53453142357657692407', 1, 1, 15, 1500, 15, 1500, -1
exec spu_CashBuy 1, 'sususu2', '', '7575970askeie1595312', 'xxxxx', '63234567090110987675defgxabc53453142357657692409', 1, 1, 55, 5000, 55, 5000, -1
exec spu_CashBuy 1, 'sususu2', '', '7575970askeie1595312', 'xxxxx', '63234567090110987675defgxabc53453142357657692408', 1, 1, 114, 9900, 114, 9900, -1
exec spu_CashBuy 1, 'sususu2', '', '7575970askeie1595312', 'xxxxx', '63234567090110987675defgxabc53453142357657692410', 1, 1, 400, 29000, 400, 29000, -1
exec spu_CashBuy 1, 'sususu2', '', '7575970askeie1595312', 'xxxxx', '63234567090110987675defgxabc53453142357657692411', 1, 1, 635, 50000, 635, 50000, -1
exec spu_CashBuy 1, 'sususu2', '', '7575970askeie1595312', 'xxxxx', '63234567090110987675defgxabc53453142357657692412', 1, 1, 1320, 99000, 1320, 99000, -1

exec spu_CashBuy 1, 'dd10', '', '7575970askeie1595312', 'xxxxx11', '63234567090110987675defgxabc53453142357657694911', 7, 1, 15, 199, 15, 199, 'SandBox', 'serialdata11', 'serialdata11', -1
exec spu_CashBuy 1, 'dd10', '', '7575970askeie1595312', 'xxxxx12', '63234567090110987675defgxabc53453142357657694912', 7, 1, 15, 199, 15, 199, 'SandBox', 'serialdata12', 'serialdata12', -1


exec spu_CashBuy 1, 'xxx02', '', '049000s1i0n7t8445289', 'xxxxx6', '63234567090110987675defgxabc534531423576576945a1', 1, 1, 15, 199, 15, 199, '', '', '', -1
exec spu_CashBuy 1, 'xxx02', '', '049000s1i0n7t8445289', 'xxxxx6', '63234567090110987675defgxabc534531423576576945a2', 1, 1, 15, 199, 15, 199, '', '', '', -1

exec spu_CashBuy 1, 'dd10', '', '7575970askeie1595312', 'xxxxx6', '63234567090110987675defgxabc534531423576576945a2', 1, 1, 1320, 99000, 1320, 99000, '', '', '', -1	-- SKT구매
exec spu_CashBuy 1, 'dd10', '', '7575970askeie1595312', 'xxxxx6', '63234567090110987675defgxabc534531423576576945a2', 5, 1, 15, 1500, 15, 1500, '', '', '', -1	-- GOOGLE구매
exec spu_CashBuy 1, 'dd11', '', '7575970askeie1595312', 'xxxxx6', '63234567090110987675defgxabc534531423576576945a2', 5, 1, 55, 5000, 55, 5000, '', '', '', -1	-- GOOGLE구매
exec spu_CashBuy 1, 'dd12', '', '7575970askeie1595312', 'xxxxx6', '63234567090110987675defgxabc534531423576576945a2', 5, 1, 114, 9900, 114, 9900, '', '', '', -1	-- GOOGLE구매
exec spu_CashBuy 1, 'dd13', '', '7575970askeie1595312', 'xxxxx6', '63234567090110987675defgxabc534531423576576945a2', 5, 1, 400, 29000, 400, 29000, '', '', '', -1	-- GOOGLE구매
exec spu_CashBuy 1, 'dd14', '', '7575970askeie1595312', 'xxxxx6', '63234567090110987675defgxabc534531423576576945a2', 5, 1, 635, 50000, 635, 50000, '', '', '', -1	-- GOOGLE구매
exec spu_CashBuy 1, 'dd15', '', '7575970askeie1595312', 'xxxxx6', '63234567090110987675defgxabc534531423576576945a4', 5, 1, 1320, 99000, 1320, 99000, '', '', '', -1	-- GOOGLE구매
exec spu_CashBuy 1, 'dd15', '', '7575970askeie1595312', 'xxxxx6', '63234567090110987675defgxabc534531423576576945a5', 5, 1, 1320, 99000, 1320, 99000, '', '', '', -1	-- GOOGLE구매
exec spu_CashBuy 1, 'dd15', '', '7575970askeie1595312', 'xxxxx6', '63234567090110987675defgxabc534531423576576945a6', 5, 1, 1320, 99000, 1320, 99000, '', '', '', -1	-- GOOGLE구매
select * from dbo.tUserGoogleBuyLog
*/

IF OBJECT_ID ( 'dbo.spu_CashBuy', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_CashBuy;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_CashBuy
	@mode_									int,
	@gameid_								varchar(20),					-- 게임아이디
	@giftid_								varchar(20),					-- 선물받을 유저
	@password_								varchar(20),
	@acode_									varchar(256),					-- indexing
	@ucode_									varchar(256),
	@market_								int,
		@summary_								int,
	@goldball_								int,
	@cash_									int,
		@goldball2_								int,
		@cash2_									int,
	@ikind_									varchar(256),
	@idata_									varchar(4096),
	@idata2_								varchar(4096),
	@nResult_								int					OUTPUT
	WITH ENCRYPTION -- 프로시져를 암호화함.
as
	------------------------------------------------
	--	2-1. 코드값자리
	------------------------------------------------
	-- 일반값
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	--가입 오류.
	declare @RESULT_ERROR_ID_DUPLICATE			int				set @RESULT_ERROR_ID_DUPLICATE			= -2
	declare @RESULT_ERROR_EMAIL_DUPLICATE		int				set @RESULT_ERROR_EMAIL_DUPLICATE		= -3

	-- 로그인 오류.
	declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--블럭유저 > 팝업처리후 인트로로 빼버린다.
	declare @RESULT_ERROR_DELETED_USER 			int				set @RESULT_ERROR_DELETED_USER			= -12			--삭제유저 > 팝업처리후 인트로로 빼버린다.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함
	declare @RESULT_ERROR_NOT_FOUND_PASSWORD	int				set @RESULT_ERROR_NOT_FOUND_PASSWORD	= -17
	declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--서버를 점검하고 있다.
	declare @RESULT_NEWVERION_CLIENT_DOWNLOAD 	int				set @RESULT_NEWVERION_CLIENT_DOWNLOAD	= -15			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 링크처리.
	declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 종료.

	-- 게임중에 부족.
	declare @RESULT_ERROR_ACTION_LACK			int				set @RESULT_ERROR_ACTION_LACK			= -20			--행동력이 부족하다.
	declare @RESULT_ERROR_SILVERBALL_LACK		int				set @RESULT_ERROR_SILVERBALL_LACK		= -21			--실버가 부족하다.
	declare @RESULT_ERROR_GOLDBALL_LACK			int				set @RESULT_ERROR_GOLDBALL_LACK			= -22			--골드가 부족하다.
	declare @RESULT_ERROR_ITEM_LACK				int				set @RESULT_ERROR_ITEM_LACK				= -23			--아이템이부족하다.
	declare @RESULT_ERROR_COIN_LACK				int				set @RESULT_ERROR_COIN_LACK				= -24			--코인잉 부족하다.

	-- 아이템 구매, 변경.
	declare @RESULT_ERROR_BUY_ALREADY			int				set @RESULT_ERROR_BUY_ALREADY			= -31			--이미 구매했습니다.
	declare @RESULT_ERROR_NOT_HAVE				int				set @RESULT_ERROR_NOT_HAVE				= -32			--보유하지 않고 있다.
	declare @RESULT_ERROR_UPGRADE_CANNT			int				set @RESULT_ERROR_UPGRADE_CANNT			= -33			--업그레이드를 할수 없다.
	declare @RESULT_ERROR_UPGRADE_FAIL			int				set @RESULT_ERROR_UPGRADE_FAIL			= -34			--업그레이드 실패.
	declare @RESULT_ERROR_UPGRADE_FULL			int				set @RESULT_ERROR_UPGRADE_FULL			= -35			--업그레이드가 풀로되었다.
	declare @RESULT_ERROR_ITEM_EXPIRE			int				set @RESULT_ERROR_ITEM_EXPIRE			= -36			--아이템이 만기 되었다.
	declare @RESULT_ERROR_ITEM_NOSALE_KIND		int				set @RESULT_ERROR_ITEM_NOSALE_KIND		= -37			--판매하지 않는 아이템
	declare @RESULT_ERROR_ITEM_PERMANENT_ALREADY int			set @RESULT_ERROR_ITEM_PERMANENT_ALREADY = -38			-- 영구템을 이미 구해했습니다.
	declare @RESULT_ERROR_ITEM_NOCHANGE_KIND	int				set @RESULT_ERROR_ITEM_NOCHANGE_KIND	= -39			--자체변경불가템

	-- 캐쉬구매.
	declare @RESULT_ERROR_CASH_COPY				int				set @RESULT_ERROR_CASH_COPY				= -40
	declare @RESULT_ERROR_CASH_OVER				int				set @RESULT_ERROR_CASH_OVER				= -41
	declare @RESULT_ERROR_MONTH_OVER			int				set @RESULT_ERROR_MONTH_OVER			= -42			--한달동안 구매한도를 검사

	-- 아이템선물
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- 아이템코드못찾음
	declare @RESULT_ERROR_GIFTITEM_NOT_FOUND	int				set @RESULT_ERROR_GIFTITEM_NOT_FOUND	= -51			-- 선물아이템을 못찾음
	declare @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	int				set @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	= -52			-- 선물을 이미 가져감

	-- 기타오류
	declare @RESULT_ERROR_RESULT_COPY			int				set @RESULT_ERROR_RESULT_COPY			= -53			-- 결과카피시도
	declare @RESULT_ERROR_SILVER_COPY			int				set @RESULT_ERROR_SILVER_COPY			= -54			-- 실버카피시도
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- 지원하지않는모드
	declare @RESULT_ERROR_ACTION_FULL			int				set @RESULT_ERROR_ACTION_FULL			= -71			-- 지원하지않는모드
	declare @RESULT_ERROR_WIN_LACK				int				set @RESULT_ERROR_WIN_LACK				= -72			-- 스프린트 보상.
	declare @RESULT_ERROR_TUTORIAL_ALREADY		int				set @RESULT_ERROR_TUTORIAL_ALREADY		= -73			-- 투토리얼 이미 보상.
	declare @RESULT_ERROR_FRIEND_ADD_MYGAMEID	int				set @RESULT_ERROR_FRIEND_ADD_MYGAMEID	= -74
	declare @RESULT_ERROR_NOT_FOUND_GIFTID		int				set @RESULT_ERROR_NOT_FOUND_GIFTID		= -75			-- 캐쉬 > 선물할 아이디를 못찾음

	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------
	-- 상태값.
	declare @BLOCK_STATE_NO						int				set	@BLOCK_STATE_NO						= 0				-- 블럭상태아님
	declare @BLOCK_STATE_YES					int				set	@BLOCK_STATE_YES					= 1				-- 블럭상태
	declare @DELETE_STATE_NO					int				set	@DELETE_STATE_NO					= 0				-- 삭제상태아님
	declare @DELETE_STATE_YES					int				set	@DELETE_STATE_YES					= 1				-- 삭제상태

	-- 구매처코드
	declare @MARKET_SKT							int				set @MARKET_SKT							= 1
	declare @MARKET_KT							int				set @MARKET_KT							= 2
	declare @MARKET_LGT							int				set @MARKET_LGT							= 3
	declare @MARKET_FACEBOOK					int				set @MARKET_FACEBOOK					= 4
	declare @MARKET_GOOGLE						int				set @MARKET_GOOGLE						= 5
	declare @MARKET_NHN							int				set @MARKET_NHN							= 6
	declare @MARKET_IPHONE						int				set @MARKET_IPHONE						= 7
	declare @MARKET_SKT2						int				set @MARKET_SKT2						= 11
	declare @MARKET_KT2							int				set @MARKET_KT2							= 12
	declare @MARKET_LGT2						int				set @MARKET_LGT2						= 13
	declare @MARKET_GOOGLE2						int				set @MARKET_GOOGLE2						= 15

	-- 시스템 체킹
	declare @SYSCHECK_NON						int				set @SYSCHECK_NON						= 0
	declare @SYSCHECK_YES						int				set @SYSCHECK_YES						= 1

	-- 선물가져가기
	declare @GAINSTATE_NON						int				set @GAINSTATE_NON						= 0
	declare @GAINSTATE_YES						int				set @GAINSTATE_YES						= 1

	-- 아이템파트이름
	declare @ITEM_KIND_CHARACTER				int 			set @ITEM_KIND_CHARACTER				= 0
	declare @ITEM_KIND_FACE						int 			set @ITEM_KIND_FACE						= 1			-- 판매템아님
	declare @ITEM_KIND_CAP						int 			set @ITEM_KIND_CAP						= 2
	declare @ITEM_KIND_UPPER					int 			set @ITEM_KIND_UPPER					= 4
	declare @ITEM_KIND_UNDER					int 			set @ITEM_KIND_UNDER					= 5
	declare @ITEM_KIND_BAT						int 			set @ITEM_KIND_BAT						= 6
	declare @ITEM_KIND_GLASSES					int 			set @ITEM_KIND_GLASSES					= 7
	declare @ITEM_KIND_WING						int 			set @ITEM_KIND_WING						= 8
	declare @ITEM_KIND_TAIL						int 			set @ITEM_KIND_TAIL						= 9
	declare @ITEM_KIND_STADIUM					int 			set @ITEM_KIND_STADIUM					= 100
	declare @ITEM_KIND_CUSTOMIZE				int 			set @ITEM_KIND_CUSTOMIZE					= 22		-- 판매방식이 다름
	declare @ITEM_KIND_PET						int 			set @ITEM_KIND_PET						= 80
	declare @ITEM_KIND_BATTLEITEM				int 			set @ITEM_KIND_BATTLEITEM				= 90
	declare @ITEM_KIND_SYSTEMETC				int 			set @ITEM_KIND_SYSTEMETC				= 99

	-- 기타 정의값
	declare @SYSTEM_SENDID						varchar(40)		set @SYSTEM_SENDID						= 'SysCash'
	declare @ITEM_PERMANENT_START_DAY			datetime		set @ITEM_PERMANENT_START_DAY			= '2012-01-01'	-- 영구템시작
	declare @ITEM_PERMANENT_ADD_YEAR			int				set @ITEM_PERMANENT_ADD_YEAR			= 50			-- 영구템기간
	declare @ITEM_PERIOD_PERMANENT				int 			set @ITEM_PERIOD_PERMANENT				= -1			-- 테이블에 -1이라 기록됨
	declare @SYSTEM_SENDID_GIFT					varchar(20)		set @SYSTEM_SENDID_GIFT					= 'SysCashGift'

	-- 선물골든볼 아이템 코드값
	declare @GOLDBALL_ITEMCODE_1500				int 			set @GOLDBALL_ITEMCODE_1500				= 9000
	declare @GOLDBALL_ITEMCODE_5000				int 			set @GOLDBALL_ITEMCODE_5000				= 9001
	declare @GOLDBALL_ITEMCODE_9900				int 			set @GOLDBALL_ITEMCODE_9900				= 9002
	declare @GOLDBALL_ITEMCODE_29000			int 			set @GOLDBALL_ITEMCODE_29000			= 9003
	declare @GOLDBALL_ITEMCODE_50000			int 			set @GOLDBALL_ITEMCODE_50000			= 9004
	declare @GOLDBALL_ITEMCODE_99000			int 			set @GOLDBALL_ITEMCODE_99000			= 9005

	--아이템만기
	declare @ITEM_EXPIRE_STATE_NO				int 			set @ITEM_EXPIRE_STATE_NO				= 0
	declare @ITEM_EXPIRE_STATE_YES				int				set @ITEM_EXPIRE_STATE_YES				= 1

	-- 코인으로 무엇인가 얻을 경우.
	declare @COIN_RESULT_SILVER_ITEM			int				set @COIN_RESULT_SILVER_ITEM 			= 1;
	declare @COIN_RESULT_PERIOD_ITEM			int				set	@COIN_RESULT_PERIOD_ITEM			= 2;
	declare @COIN_RESULT_BATTLE_ITEM1			int				set	@COIN_RESULT_BATTLE_ITEM1			= 3;
	declare @COIN_RESULT_BATTLE_ITEM2			int				set	@COIN_RESULT_BATTLE_ITEM2			= 4;
	declare @COIN_RESULT_BATTLE_ITEM3			int				set	@COIN_RESULT_BATTLE_ITEM3			= 5;
	declare @COIN_RESULT_BATTLE_ITEM4			int				set	@COIN_RESULT_BATTLE_ITEM4			= 6;
	declare @COIN_RESULT_BATTLE_ITEM5			int				set	@COIN_RESULT_BATTLE_ITEM5			= 7;

	-- 액션충전
	declare @MODE_ACTION_RECHARGE_FULL			int				set	@MODE_ACTION_RECHARGE_FULL			= 1;
	declare @MODE_ACTION_RECHARGE_HALF			int				set	@MODE_ACTION_RECHARGE_HALF			= 2;
	declare @ITEMCODE_ACTION_RECHARGE_FULL		int				set	@ITEMCODE_ACTION_RECHARGE_FULL		= 7000;
	declare @ITEMCODE_ACTION_RECHARGE_HALF		int				set	@ITEMCODE_ACTION_RECHARGE_HALF		= 7001;

	-- 친구검색, 추가, 삭제
	declare @FRIEND_MODE_SEARCH					int				set	@FRIEND_MODE_SEARCH					= 1;
	declare @FRIEND_MODE_ADD					int				set	@FRIEND_MODE_ADD					= 2;
	declare @FRIEND_MODE_DELETE					int				set	@FRIEND_MODE_DELETE					= 3;
	declare @FRIEND_MODE_MYLIST					int				set	@FRIEND_MODE_MYLIST					= 4;
	declare @FRIEND_MODE_VISIT					int				set	@FRIEND_MODE_VISIT					= 5;

	-- 기타 상수
	declare @BUY_MAX_GOLDBALL					int				set	@BUY_MAX_GOLDBALL					= 1600*2;

	-- 캐수모드
	declare @CASH_MODE_BUYMODE					int				set @CASH_MODE_BUYMODE					= 1
	declare @CASH_MODE_GIFTMODE					int				set @CASH_MODE_GIFTMODE					= 2

	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @gameid				varchar(20)
	declare @password			varchar(20)
	declare @giftid				varchar(20)
	declare @goldballitemcode	int
	declare @pgb				int
	declare @plusgoldball		int					set @plusgoldball	= 0
	declare @version			int					set @version		= 100

	declare @blockstate		int

	declare @dateid 		varchar(8)
	declare @market			int
	declare @goldball		int
	declare @cash			int
	declare @idx			int

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	select
		@gameid 	= gameid,
		@password 	= password,
		@blockstate	= blockstate,
		@version 	= version
	from dbo.tUserMaster where gameid = @gameid_

	-- 친구 ID검색
	if(@mode_ = @CASH_MODE_GIFTMODE)
		begin
			select @giftid = gameid
			from dbo.tUserMaster where gameid = @giftid_
		end


	------------------------------------------------
	--	3-2-3. 연산수행
	------------------------------------------------
	if (@blockstate = @BLOCK_STATE_YES)
		begin
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
			select @nResult_ rtn, 'ERROR 아이디를 찾지 못했습니다.'
		end
	else if(@mode_ not in (@CASH_MODE_BUYMODE, @CASH_MODE_GIFTMODE))
		begin
			set @nResult_ = @RESULT_ERROR_NOT_SUPPORT_MODE
			select @nResult_ rtn, 'ERROR 지원하지 않는 모드입니다.'
		end
	else if(@mode_ = @CASH_MODE_GIFTMODE and (isnull(@giftid, '') = ''))
		begin
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_GIFTID
			select @nResult_ rtn, 'ERROR 선물받을 친구가 없습니다.'
		end
	else if(isnull(@gameid, '') = '')
		begin
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
			select @nResult_ rtn, 'ERROR 아이디를 찾지 못했습니다.'
		end
	else if(@password != @password_)
		begin
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_PASSWORD
			select @nResult_ rtn, 'ERROR 패스워드가 일치하지 않습니다.'
		end
	else if(@goldball_ != @goldball2_ or @cash_ != @cash2_)
		begin
			set @nResult_ = @RESULT_ERROR_CASH_COPY
			select @nResult_ rtn, 'ERROR 캐쉬카피(블럭처리됩니다.골드와캐쉬가불일치(-1))'

			---------------------------------------------------
			--	캐쉬카피 플래그 기록
			---------------------------------------------------
			update dbo.tUserMaster set cashcopy = cashcopy + 1 where gameid = @gameid_

			insert into dbo.tUserUnusualLog(gameid, comment) values(@gameid_, '**** 캐쉬카피를 시도했습니다(골드와캐쉬가불일치) ****')
		end
	else if(@summary_ != 1)
		begin
			set @nResult_ = @RESULT_ERROR_CASH_COPY
			select @nResult_ rtn, 'ERROR 캐쉬카피(블럭처리됩니다.유효하지않는값(-2))'

			---------------------------------------------------
			--	캐쉬카피 플래그 기록
			---------------------------------------------------
			update dbo.tUserMaster set cashcopy = cashcopy + 1 where gameid = @gameid_

			insert into dbo.tUserUnusualLog(gameid, comment) values(@gameid_, '**** 캐쉬카피를 시도했습니다(유효하지않는 ucode값) ****')
		end
	else if(@goldball_ > @BUY_MAX_GOLDBALL)
		begin
			set @nResult_ = @RESULT_ERROR_CASH_COPY
			select @nResult_ rtn, 'ERROR 캐쉬카피(블럭처리됩니다.유효하지않는 골든볼(-3))'

			---------------------------------------------------
			--	캐쉬카피 플래그 기록
			---------------------------------------------------
			update dbo.tUserMaster set cashcopy = cashcopy + 1 where gameid = @gameid_

			insert into dbo.tUserUnusualLog(gameid, comment) values(@gameid_, '**** 캐쉬카피를 시도했습니다(유효하지않는 골든볼) ****')
		end
	else if(exists(select top 1 * from dbo.tCashLog where ucode = @ucode_))
		begin
			set @nResult_ = @RESULT_ERROR_CASH_COPY
			select @nResult_ rtn, 'ERROR 캐쉬카피(블럭처리됩니다.중복요청(-4))'

			---------------------------------------------------
			--	캐쉬카피 플래그 기록
			---------------------------------------------------
			update dbo.tUserMaster set cashcopy = cashcopy + 10 where gameid = @gameid_

			insert into dbo.tUserUnusualLog(gameid, comment) values(@gameid_, '**** 캐쉬카피를 시도했습니다(중복요청을 했다.) ****')
		end
	else
		begin
			set @nResult_ = @RESULT_SUCCESS
			select @nResult_ rtn, 'SUCCESS 구매를 정상처리하다.'

			---------------------------------------------------
			-- 캐쉬Pluse > 구매금액
			---------------------------------------------------
			set @goldballitemcode = @GOLDBALL_ITEMCODE_1500
			if(@market_ = @MARKET_IPHONE)
				begin
					if(@cash_ = 199)
						begin
							set @goldballitemcode = @GOLDBALL_ITEMCODE_1500
							set @cash_ = 1500
						end
					else if(@cash_ = 499)
						begin
							set @goldballitemcode = @GOLDBALL_ITEMCODE_5000
							set @cash_ = 5000
						end
					else if(@cash_ = 899)
						begin
							set @goldballitemcode = @GOLDBALL_ITEMCODE_9900
							set @cash_ = 9900
						end
					else if(@cash_ = 2699)
						begin
							set @goldballitemcode = @GOLDBALL_ITEMCODE_29000
							set @cash_ = 29000
						end
					else if(@cash_ = 4599)
						begin
							set @goldballitemcode = @GOLDBALL_ITEMCODE_50000
							set @cash_ = 50000
						end
					else if(@cash_ = 8999)
						begin
							set @goldballitemcode = @GOLDBALL_ITEMCODE_99000
							set @cash_ = 99000
						end
				end
			else
				begin
					if(@cash_ = 1500)
						begin
							set @goldballitemcode = @GOLDBALL_ITEMCODE_1500
						end
					else if(@cash_ = 5000)
						begin
							set @goldballitemcode = @GOLDBALL_ITEMCODE_5000
						end
					else if(@cash_ = 9900)
						begin
							set @goldballitemcode = @GOLDBALL_ITEMCODE_9900
						end
					else if(@cash_ = 29000)
						begin
							set @goldballitemcode = @GOLDBALL_ITEMCODE_29000
						end
					else if(@cash_ = 50000)
						begin
							set @goldballitemcode = @GOLDBALL_ITEMCODE_50000
						end
					else if(@cash_ = 99000)
						begin
							set @goldballitemcode = @GOLDBALL_ITEMCODE_99000
						end
				end
			select @pgb = isnull(param1, 0) from dbo.tItemInfo where itemcode = @goldballitemcode

			-------------------------------------------------
			-- 추가 골드세팅되어 있다면
			-------------------------------------------------
			select top 1 @plusgoldball = plusgoldball
			from dbo.tActionInfo where flag = 1
			order by idx desc
			if(@plusgoldball > 0 and @plusgoldball <= 100)
				begin
					set @pgb = @pgb + (@pgb * @plusgoldball / 100)
				end


			if(@mode_ = @CASH_MODE_BUYMODE)
				begin
					---------------------------------------------------
					-- 직접구매 > 캐쉬Pluse
					---------------------------------------------------
					update dbo.tUserMaster
						set goldball = goldball + @pgb
					where gameid = @gameid_

					---------------------------------------------------
					-- 직접구매 > 구매기록하기
					---------------------------------------------------
					insert into dbo.tCashLog(gameid, acode, ucode, goldball, cash, market, ikind, idata, idata2)
					values(@gameid_, @acode_, @ucode_, @pgb, @cash_, @market_, @ikind_, @idata_, @idata2_)

					---------------------------------------------------
					-- 직접구매 > 구매자 쪽지 남겨주기
					---------------------------------------------------
					insert into tMessage(gameid, sendid, comment)
					values(@gameid_, @SYSTEM_SENDID, ltrim(rtrim(str(@pgb))) +  '골든을 구매하였습니다.')
				end
			else if(@mode_ = @CASH_MODE_GIFTMODE)
				begin
					---------------------------------------------------
					-- 구매자 > 상대방에게 선물로 넣어주기
					---------------------------------------------------
					-- 직접넣어주기
					--update dbo.tUserMaster
					--	set goldball = goldball + @pgb
					--where gameid = @giftid_

					insert into dbo.tGiftList(gameid, itemcode, giftid, period2)
					values(@giftid_ , @goldballitemcode, @gameid_, @ITEM_PERIOD_PERMANENT);


					---------------------------------------------------
					-- 구매자 > 구매기록하기
					---------------------------------------------------
					insert into dbo.tCashLog(gameid, acode, ucode, goldball, cash, giftid, market, ikind, idata, idata2)
					values(@gameid_, @acode_, @ucode_, @pgb, @cash_, @giftid_, @market_, @ikind_, @idata_, @idata2_)

					---------------------------------------------------
					-- 구매자와 선물자에게 쪽지 남겨주기
					---------------------------------------------------
					insert into tMessage(gameid, sendid, comment)
					values(@gameid_, @SYSTEM_SENDID, ltrim(rtrim(@giftid_)) + '님에게 ' + ltrim(rtrim(str(@pgb))) +  '골든을 선물하였습니다.')

					insert into tMessage(gameid, sendid, comment)
					values(@giftid_, @SYSTEM_SENDID, ltrim(rtrim(@gameid_)) + '으로부터 ' + ltrim(rtrim(str(@pgb))) +  '골든을 선물 받았습니다.')
				end

			---------------------------------------------------
			-- 토탈로그 기록하기
			---------------------------------------------------
			set @dateid = Convert(varchar(8),Getdate(),112)		-- 20120819
			if(exists(select top 1 * from dbo.tCashTotal where dateid = @dateid and cashkind = @cash_ and market = @market_))
				begin
					update dbo.tCashTotal
						set
							goldball = goldball + @pgb,
							cash = cash + @cash_,
							cnt = cnt + 1
					where dateid = @dateid and cashkind = @cash_ and market = @market_
				end
			else
				begin
					insert into dbo.tCashTotal(dateid, cashkind, market, goldball, cash)
					values(@dateid, @cash_, @market_, @pgb, @cash_)
				end

			--유저 골든볼과 실버볼 갱신해주기
			select * from dbo.tUserMaster where gameid = @gameid_
		end



	------------------------------------------------
	--	4-2. 유저정보
	------------------------------------------------
	set nocount off
End

