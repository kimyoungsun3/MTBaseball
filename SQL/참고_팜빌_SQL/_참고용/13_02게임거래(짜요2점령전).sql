/*

SELECT * FROM dbo.fnu_SplitTwoStr(';', ':', '4:5,25,0;1:5,24,1;3:5,23,0;')

SELECT * FROM dbo.fnu_SplitTwo(';', ':', '14:1;15:1;')
SELECT * FROM dbo.fnu_SplitTwo(';', ':', '0:5; 1:2;   10:1;    11:1;    12:75;     20:1;    30:1;      31:10;    32:1;         33:10;     34:20;    35:60;   40:-1;')

userinfo=gameyear;gamemonth;frametime;fevergauge;bottlelittle;bottlefresh;tanklittle;tankfresh;feeduse;wolfkillcnt;
         0:2013;  1:4;      2:0;      4:2;       10:10;       11:100;     12:20;     13:200;   30:3;   43:1;
aniitem=listidx:anistep,manger,diseasestate; (인벤[O], 필드[O], 병원[X])
		...
		1:5,24,1;		--> 자체분리 	> 4 : 5, 25, 0
		3:5,23,0;
		4:5,25,0;		--> 동물병원 	> 자체필터.
cusitem=listidx:usecnt;
		...
		14:1;
		15:1;
		16:1;			--> 악세사리(자동필터)
paraminfo=param0:value0
		...
		0:0;
		1:0;
		2:0;			--> 파라미터데이타
tradeinfo=fame:famelv:tradecnt:prizecnt:prizecoin:playcoin:saletrader:saledanga:saleplusdanga:salebarrel:salefresh:salecoin:saleitemcode;plusheart;orderbarrel;orderfresh;milkproduct;
		  0:5; 1:2;   10:1;    11:1;    12:75;    20:1;    30:1;      31:10;    32:1;         33:10;     34:20;    35:110;  40:-1;		 50:0;     51:10;      52:40;		53:600;
		  0:5; 1:2;   10:1;    11:1;    12:70;    20:1;    30:1;      31:10;    32:1;         33:10;     34:20;    35:110;  40:-1;		 50:0;     51:10;      52:40;		53:600;
		  0:5; 1:2;   10:1;    11:1;    12:75;    20:1;    30:1;      31:99;    32:1;         33:10;     34:20;    35:110;  40:-1;		 50:0;     51:10;      52:40;		53:600;
		  0:5; 1:2;   10:1;    11:1;    12:75;    20:1;    30:1;      31:10;    32:1;         33:19;     34:20;    35:110;  40:-1;		 50:0;     51:10;      52:40;		53:600;
		  0:5; 1:2;   10:1;    11:1;    12:75;    20:999;  30:1;      31:10;    32:1;         33:10;     34:20;    35:110;  40:-1;		 50:0;     51:10;      52:40;		53:600;
		  0:5; 1:2;   10:1;    11:1;    12:75;    20:1;    30:1;      31:10;    32:1;         33:10;     34:20;    35:990;  40:-1;		 50:0;     51:10;      52:40;		53:600;
		  0:545;1:14; 10:0;    11:0;    12:0;     20:0;    30:0;      31:21;    32:-10;       33:3;      34:19;    35:30;   40:-1;       50:0;     51:10;      52:40;		53:600;

-- 일반결과
update dbo.tFVUserMaster set gameyear = 2013, gamemonth = 3, frametime = 0, etsalecoin = 1000, fame = 5, famelv = 2, tradecnt = 1, prizecnt = 1, etremain = -1 where gameid = 'xxxx2'
update dbo.tFVUserMaster set gamecost = 0, cashcost = 0, feed = 0, heart = 0 where gameid = 'xxxx2'
update dbo.tFVSchoolMaster set totalpoint = 0 where schoolidx = (select schoolidx from dbo.tFVUserMaster where gameid = 'xxxx2')
update dbo.tFVSchoolUser set point = 0 where gameid = 'xxxx2'
delete from dbo.tFVUserSaleLog where gameid = 'xxxx2'
delete from dbo.tFVGiftList where gameid = 'xxxx2'
delete from dbo.tFVEpiReward where gameid = 'xxxx2'
exec spu_FVGameTrade 'xxxx2', '049000s1i0n7t8445289', '0:2013;  1:4;      2:0;      4:2;       10:10;       11:100;     12:20;     13:200;   30:16;    43:1;',
													'1:5,1,1;3:5,23,0;4:5,25,-1;',
													'14:1;15:1;16:1;',
													'0:5; 1:2;   10:2;    11:1;    12:75;    20:10;    30:1;      31:10;    32:1;         33:7;     34:20;    35:77;  40:-1;',
													'0:0;1:1;2:2;3:3;4:4;5:5;6:6;7:7;8:8;9:9;',
													-1										-- 필드없음.
-- 에피소드 결과
update dbo.tFVUserMaster set gameyear = 2017, gamemonth = 11, frametime = 0, etsalecoin = 99999, fame = 5, famelv = 2, tradecnt = 1, prizecnt = 1 where gameid = 'xxxx2'
update dbo.tFVUserMaster set gamecost = 0, cashcost = 0, feed = 0, heart = 0, adidx = 0 where gameid = 'xxxx2'
update dbo.tFVSchoolMaster set totalpoint = 0 where schoolidx = (select schoolidx from dbo.tFVUserMaster where gameid = 'xxxx2')
update dbo.tFVSchoolUser set point = 0 where gameid = 'xxxx2'
delete from dbo.tFVUserSaleLog where gameid = 'xxxx2'
delete from dbo.tFVGiftList where gameid = 'xxxx2'
delete from dbo.tFVEpiReward where gameid = 'xxxx2'
exec spu_FVGameTrade 'xxxx2', '049000s1i0n7t8445289', '0:2017;  1:12;      2:0;      4:2;       10:10;       11:100;     12:20;     13:200;   30:16;    43:1;',
													'1:5,1,1;3:5,23,0;4:5,25,-1;',
													'14:1;15:1;16:1;',
													'0:5; 1:2;   10:2;    11:1;    12:75;    20:10;    30:1;      31:10;    32:1;         33:7;     34:20;    35:77;  40:-1; 53:1000',
													'0:0;1:1;2:2;3:3;4:4;5:5;6:6;7:7;8:8;9:9;',
													-1										-- 필드없음.

-- 에피소드 다음달.
exec spu_FVGameTrade 'xxxx2', '049000s1i0n7t8445289', '0:2018;  1:1;      2:0;      4:2;       10:10;       11:100;     12:20;     13:200;   30:16;    43:1;',
													'1:5,1,1;3:5,23,0;4:5,25,-1;',
													'14:1;15:1;16:1;',
													'0:5; 1:2;   10:2;    11:1;    12:75;    20:10;    30:1;      31:10;    32:1;         33:7;     34:20;    35:77;  40:-1;',
													'0:0;1:1;2:2;3:3;4:4;5:5;6:6;7:7;8:8;9:9;',
													-1										-- 필드없음.

-- 에피소드 결과시작 2013.11 -> 시작멘트
update dbo.tFVUserMaster set gameyear = 2013, gamemonth = 11, frametime = 0, etsalecoin = 1000, fame = 5, famelv = 2, tradecnt = 1, prizecnt = 1 where gameid = 'xxxx2'
update dbo.tFVUserMaster set gamecost = 0, cashcost = 0, feed = 0, heart = 0, adidx = 0 where gameid = 'xxxx2'
update dbo.tFVSchoolMaster set totalpoint = 0 where schoolidx = (select schoolidx from dbo.tFVUserMaster where gameid = 'xxxx2')
update dbo.tFVSchoolUser set point = 0 where gameid = 'xxxx2'
delete from dbo.tFVUserSaleLog where gameid = 'xxxx2'
delete from dbo.tFVGiftList where gameid = 'xxxx2'
delete from dbo.tFVEpiReward where gameid = 'xxxx2'
exec spu_FVGameTrade 'xxxx2', '049000s1i0n7t8445289', '0:2013;  1:12;      2:0;      4:2;       10:10;       11:100;     12:20;     13:200;   30:16;    43:1;',
													'1:5,1,1;3:5,23,0;4:5,25,-1;',
													'14:1;15:1;16:1;',
													'0:5; 1:2;   10:2;    11:1;    12:75;    20:10;    30:1;      31:10;    32:1;         33:7;     34:20;    35:77;  40:-1;',
													'0:0;1:1;2:2;3:3;4:4;5:5;6:6;7:7;8:8;9:9;',
													-1										-- 필드없음.

*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVGameTrade', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVGameTrade;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_FVGameTrade
	@gameid_								varchar(60),
	@password_								varchar(20),
	@userinfo_								varchar(1024),
	@aniitem_								varchar(2048),
	@cusitem_								varchar(1024),
	@tradeinfo_								varchar(1024),
	@paraminfo_								varchar(1024),
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
	--declare @RESULT_ERROR_DELETED_USER 		int				set @RESULT_ERROR_DELETED_USER			= -12			--삭제유저 > 팝업처리후 인트로로 빼버린다.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함.
	--declare @RESULT_ERROR_NOT_FOUND_PASSWORD	int				set @RESULT_ERROR_NOT_FOUND_PASSWORD	= -17
	--declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--서버를 점검하고 있다.
	--declare @RESULT_NEWVERION_CLIENT_DOWNLOAD int				set @RESULT_NEWVERION_CLIENT_DOWNLOAD	= -15			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 링크처리.
	--declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 종료.

	-- 기타오류
	declare @RESULT_ERROR_RESULT_COPY			int				set @RESULT_ERROR_RESULT_COPY			= -53
	declare @RESULT_ERROR_PARAMETER				int				set @RESULT_ERROR_PARAMETER				= -122			-- 파라미터오류.
	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------
	-- 블럭상태값.
	--declare @BLOCK_STATE_NO						int					set	@BLOCK_STATE_NO					= 0	-- 블럭상태아님
	declare @BLOCK_STATE_YES					int					set	@BLOCK_STATE_YES				= 1	-- 블럭상태

	-- 아이템별 인벤분류
	declare @USERITEM_INVENKIND_ANI				int 				set @USERITEM_INVENKIND_ANI					= 1
	declare @USERITEM_INVENKIND_CONSUME			int 				set @USERITEM_INVENKIND_CONSUME				= 3
	--declare @USERITEM_INVENKIND_ACC			int 				set @USERITEM_INVENKIND_ACC					= 4
	--declare @USERITEM_INVENKIND_DIRECT		int 				set @USERITEM_INVENKIND_DIRECT				= 40
	--declare @USERITEM_INVENKIND_INFO			int 				set @USERITEM_INVENKIND_INFO				= 60
	--declare @USERITEM_INVENKIND_PET			int 				set @USERITEM_INVENKIND_PET					= 1000

	-- 선물 정의값
	--declare @GIFTLIST_GIFT_KIND_MESSAGE		int					set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2
	--declare @GIFTLIST_GIFT_KIND_MESSAGE_DEL	int					set @GIFTLIST_GIFT_KIND_MESSAGE_DEL			= -1
	--declare @GIFTLIST_GIFT_KIND_GIFT_DEL		int					set @GIFTLIST_GIFT_KIND_GIFT_DEL			= -2
	--declare @GIFTLIST_GIFT_KIND_GIFT_GET		int					set @GIFTLIST_GIFT_KIND_GIFT_GET			= -3
	--declare @GIFTLIST_GIFT_KIND_GIFT_SELL		int					set @GIFTLIST_GIFT_KIND_GIFT_SELL			= -4

	-- 아이템 소분류
	--declare @ITEM_SUBCATEGORY_FIELDOPEN		int					set @ITEM_SUBCATEGORY_FIELDOPEN				= 56 -- 필드오픈(56)
	declare @ITEM_SUBCATEGORY_UPGRADE_HOUSE		int					set @ITEM_SUBCATEGORY_UPGRADE_HOUSE 		= 60 -- 집
	declare @ITEM_SUBCATEGORY_UPGRADE_TANK		int					set @ITEM_SUBCATEGORY_UPGRADE_TANK 			= 61 -- 탱크
	declare @ITEM_SUBCATEGORY_UPGRADE_BOTTLE	int					set @ITEM_SUBCATEGORY_UPGRADE_BOTTLE 		= 64 -- 양동이
	--declare @ITEM_SUBCATEGORY_USERFARM		int					set @ITEM_SUBCATEGORY_USERFARM	 			= 69 -- 전국목장
	declare @ITEM_SUBCATEGORY_EPISODE			int					set @ITEM_SUBCATEGORY_EPISODE				= 910 	--에피소드(910)

	-- 세이브값종류
	declare @SAVE_USERINFO_GAMEYEAR				int					set @SAVE_USERINFO_GAMEYEAR					= 0
	declare @SAVE_USERINFO_MONTH				int					set @SAVE_USERINFO_MONTH					= 1
	declare @SAVE_USERINFO_FRAMETIME			int					set @SAVE_USERINFO_FRAMETIME				= 2
	declare @SAVE_USERINFO_FEVERGAUGE			int					set @SAVE_USERINFO_FEVERGAUGE				= 4
	declare @SAVE_USERINFO_BOTTLELITTLE			int					set @SAVE_USERINFO_BOTTLELITTLE				= 10
	declare @SAVE_USERINFO_BOTTLEFRESH			int					set @SAVE_USERINFO_BOTTLEFRESH				= 11
	declare @SAVE_USERINFO_TANKLITTLE			int					set @SAVE_USERINFO_TANKLITTLE				= 12
	declare @SAVE_USERINFO_TANKFRESH			int					set @SAVE_USERINFO_TANKFRESH				= 13
	declare @SAVE_USERINFO_USEFEED				int					set @SAVE_USERINFO_USEFEED					= 30
	declare @SAVE_USERINFO_BOOSTERUSE			int					set @SAVE_USERINFO_BOOSTERUSE				= 40
	declare @SAVE_USERINFO_ALBAUSE				int					set @SAVE_USERINFO_ALBAUSE					= 41
	declare @SAVE_USERINFO_WOLFAPPEAR			int					set @SAVE_USERINFO_WOLFAPPEAR				= 42
	declare @SAVE_USERINFO_WOLFKILLCNT			int					set @SAVE_USERINFO_WOLFKILLCNT				= 43

	declare @SAVE_TRADEINFO_FAME				int					set @SAVE_TRADEINFO_FAME					= 0
	declare @SAVE_TRADEINFO_FAMELV				int					set @SAVE_TRADEINFO_FAMELV					= 1
	declare @SAVE_TRADEINFO_TRADECNT			int					set @SAVE_TRADEINFO_TRADECNT				= 10
	declare @SAVE_TRADEINFO_PRIZECNT			int					set @SAVE_TRADEINFO_PRIZECNT				= 11
	declare @SAVE_TRADEINFO_PRIZECOIN			int					set @SAVE_TRADEINFO_PRIZECOIN				= 12
	declare @SAVE_TRADEINFO_PLAYCOIN			int					set @SAVE_TRADEINFO_PLAYCOIN				= 20
	declare @SAVE_TRADEINFO_SALETRADER			int					set @SAVE_TRADEINFO_SALETRADER				= 30
	declare @SAVE_TRADEINFO_SALEDANGA			int					set @SAVE_TRADEINFO_SALEDANGA				= 31
	declare @SAVE_TRADEINFO_SALEPLUSDANGA		int					set @SAVE_TRADEINFO_SALEPLUSDANGA			= 32
	declare @SAVE_TRADEINFO_SALEBARREL			int					set @SAVE_TRADEINFO_SALEBARREL				= 33
	declare @SAVE_TRADEINFO_SALEFRESH			int					set @SAVE_TRADEINFO_SALEFRESH				= 34
	declare @SAVE_TRADEINFO_SALECOST			int					set @SAVE_TRADEINFO_SALECOST				= 35
	declare @SAVE_TRADEINFO_SALEITEMCODE		int					set @SAVE_TRADEINFO_SALEITEMCODE			= 40
	declare @SAVE_TRADEINFO_PLUSHEART			int					set @SAVE_TRADEINFO_PLUSHEART				= 50
	declare @SAVE_TRADEINFO_ORDERBARREL			int					set @SAVE_TRADEINFO_ORDERBARREL				= 51
	declare @SAVE_TRADEINFO_ORDERFRESH			int					set @SAVE_TRADEINFO_ORDERFRESH				= 52
	declare @SAVE_TRADEINFO_MILK_PRODUCT		int					set @SAVE_TRADEINFO_MILK_PRODUCT			= 53

	-- 그룹.
	declare @ITEM_REVIVAL_MOTHER				int					set @ITEM_REVIVAL_MOTHER					= 1200	-- 부활석.
	declare @ITEM_COMPOSE_TIME_MOTHER			int					set @ITEM_COMPOSE_TIME_MOTHER				= 1600	-- 합성시간 1시간초기화.
	declare @ITEM_HELPER_MOTHER					int					set @ITEM_HELPER_MOTHER						= 2100	-- 긴급지원.
	declare @ITEM_ROULETTE_NOR_MOTHER			int					set @ITEM_ROULETTE_NOR_MOTHER				= 2200	-- 일반교배뽑기.
	declare @ITEM_ROULETTE_PRE_MOTHER			int					set @ITEM_ROULETTE_PRE_MOTHER				= 2300	-- 프리미엄교배뽑기.

	-- 동물정보.
	-- 필드동물 0 ~ 8.
	declare @USERITEM_FIELDIDX_INVEN			int					set @USERITEM_FIELDIDX_INVEN					= -1	-- 창고.
	declare @USERITEM_FIELDIDX_HOSPITAL			int					set @USERITEM_FIELDIDX_HOSPITAL					= -2	-- 병원.
	declare @USERITEM_INIT_ANISTEP				int					set @USERITEM_INIT_ANISTEP						= 5		-- 단계.
	declare @USERITEM_INIT_MANGER				int					set @USERITEM_INIT_MANGER						= 25	-- 여물통.
	declare @USERITEM_INIT_DISEASESTATE			int					set @USERITEM_INIT_DISEASESTATE					= 0		-- 질병상태.

	-- 기타 상수값
	declare @USERMASTER_UPGRADE_STATE_NON		int					set @USERMASTER_UPGRADE_STATE_NON			= -1	--미진행, 완료중.(유저)
	declare @USERMASTER_UPGRADE_STATE_ING		int					set @USERMASTER_UPGRADE_STATE_ING			= 1		--다음단계진행중.

	declare @INIT_VALUE							int					set @INIT_VALUE								= -555
	declare @DEFINE_PRIZECOIN_BASE				int					set @DEFINE_PRIZECOIN_BASE					= 75
	declare @CHAR_SPLIT_COMMA					varchar(1)			set @CHAR_SPLIT_COMMA						= ','
	declare @USER_LOG_MAX						int					set @USER_LOG_MAX 							= 480	-- 12개월 * 40년.
	declare @FAMELV_MAX							int					set @FAMELV_MAX								= 70

	declare @TRADEINFO_PRIZECOIN_MAX			int					set @TRADEINFO_PRIZECOIN_MAX 				= 3000	--3000 상인연속 거래 추가 보상맥스.
	declare @TRADEINFO_SALEDANGA_MAX			int					set @TRADEINFO_SALEDANGA_MAX				= 1000	--500 현재맥스(248)2번상인 (단가:600000013코인 + 추가:0코인) x 3배럴(31신선도) = 판매금:1800000039
	declare @TRADEINFO_SALEPLUSDANGA_MAX		int					set @TRADEINFO_SALEPLUSDANGA_MAX			= 400	--100 현재맥스(49)0번상인 (단가:6118코인 + 추가:1223코인) x 11배럴(32신선도) = 판매금:80751
																														-- 아까 연속거래2 빠졌는데 연속거래까지 포함해서 최대 314 임니다.
	declare @TRADEINFO_TRADECNT_NEXT			int					set @TRADEINFO_TRADECNT_NEXT				= 2000
	declare @TRADEINFO_SALEBARREL_UNDER			int					set @TRADEINFO_SALEBARREL_UNDER				= -1000	-- 30 * 5
	declare @TRADEINFO_TANKLITTLE_UNDER			int					set @TRADEINFO_TANKLITTLE_UNDER				= -2000
	declare @TRADEINFO_TANKLITTLE_GAP			int					set @TRADEINFO_TANKLITTLE_GAP				= 29	-- 우유 탱크 거래시 리터 갭차이.

	------------------------
	-- 에피소드 관련 상수.
	------------------------
	-- 게임시작년.
	declare @GAME_START_YEAR					int					set @GAME_START_YEAR						= 2013
	declare @EPISODE_LOOP_YEAR					int					set @EPISODE_LOOP_YEAR						= 4		-- 4년마다 11 -> 12월.
	declare @EPISODE_LOOP_MONTH					int					set @EPISODE_LOOP_MONTH						= 12

	-- 농장(정보).
	--declare @USERFARM_BUYSTATE_NOBUY			int					set @USERFARM_BUYSTATE_NOBUY				= -1	-- (농장)
	declare @USERFARM_BUYSTATE_BUY				int					set @USERFARM_BUYSTATE_BUY					=  1

	-- 에피소드 상태값.
	declare @EPISODE_GRADE_NON					int					set @EPISODE_GRADE_NON						= 0		-- 없음.
	declare @EPISODE_GRADE_BAD					int					set @EPISODE_GRADE_BAD						= 1		-- Bad.
	declare @EPISODE_GRADE_NORMAL				int					set @EPISODE_GRADE_NORMAL					= 2		-- Normal.
	declare @EPISODE_GRADE_GOOD					int					set @EPISODE_GRADE_GOOD						= 3		-- Good.
	declare @EPISODE_GRADE_EXCELLENT			int					set @EPISODE_GRADE_EXCELLENT				= 4		-- Excellent.

	-- 기타 상수값들.
	declare @YABAU_CHANGE_DANGA					int					set @YABAU_CHANGE_DANGA				= 100		-- 행운의 주사위 상수값
	declare @USED_FRIEND_POINT					int					set @USED_FRIEND_POINT				= 100		-- 친구포인트 차감.
	-------------------------------------------------------------------
	-- 신규 생성 후 특정 레벨 달성 시에 아이템을 지급해드립니다.
	--	 3레벨 : 2013		하트30
	--	 6레벨 : 1003		알바의 귀재 패키지 (4개)
	--	 9레벨 : 1202		부활석 (3개)
	--	12레벨 : 2201		일반 교배 티켓 (2개)
	-------------------------------------------------------------------
	declare @EVENT01_ITEM1						int					set @EVENT01_ITEM1					= 2013
	declare @EVENT01_ITEM2						int					set @EVENT01_ITEM2					= 1003
	declare @EVENT01_ITEM3						int					set @EVENT01_ITEM3					= 1202
	declare @EVENT01_ITEM4						int					set @EVENT01_ITEM4					= 2201

	-------------------------------------------------------------------
	-- 복귀보상.
	-- 1 ~ 6 일차 * 5달플레이 : 2수정
	--     7 일차 * 5달플레이 : 프리미엄
	-- 8 ~13 일차 * 5달플레이 : 2수정
	--    14 일차 * 5달플레이 : 프리미엄
	-------------------------------------------------------------------
	declare @RETURN_REWARD_STEP_SPECIAL			int					set @RETURN_REWARD_STEP_SPECIAL			= 2300	-- 프리미엄 티켓
	declare @RETURN_REWARD_STEP_NORMAL			int					set @RETURN_REWARD_STEP_NORMAL			= 5027	-- 수정5.

	-- 장기복귀기한.
	--declare @RETURN_FLAG_OFF					int					set @RETURN_FLAG_OFF				= 0 	-- On(1), Off(0)
	declare @RETURN_FLAG_ON						int					set @RETURN_FLAG_ON					= 1 	-- On(1), Off(0)

	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @comment			varchar(256)
	declare @comment2			varchar(512)
	declare @kind				int,
			@info				int,
			@listidx			int,
			@strdata			varchar(40)
	declare @curdate			datetime	set @curdate		= getdate()

	declare @gameid 			varchar(60)	set @gameid			= ''
	declare @blockstate			int
	declare @gamecost			int,		@playcoin2			int,	@playcoinmax		int,
			@cashcost			int,
			@feed				int,		@feeduse2			int,
			@heart				int,
			@heartmax			int,
			@fpoint				int,
			@comreward			int,

			@gameyear			int,		@gameyear2			int,
			@gamemonth			int,		@gamemonth2			int,
			@frametime			int,		@frametime2			int,
			@fevergauge			int,		@fevergauge2		int,
			@bottlelittle		int,		@bottlelittle2		int,	@bottlelittlemax 	int,
			@bottlefresh		int,		@bottlefresh2		int,
			@tanklittle			int,		@tanklittle2		int,	@tanklittlemax		int,
			@tankfresh			int,		@tankfresh2			int,
			@bktwolfkillcnt		int,		@wolfkillcnt2		int,

			@housestep			int,		@housestate			int,	@housetime			datetime,	@housestepmax	int,
			@tankstep			int,		@bottlestate		int,	@bottletime			datetime,	@bottlestepmax	int,
			@bottlestep			int,		@tankstate			int,	@tanktime			datetime,	@tankstepmax	int,

			@fame				int,		@fame2				int,
			@famelv				int,		@famelv2			int,	@famelvchange		int,
			@famelvbest			int,
			@tradecnt			int,		@tradecnt2			int,
			@prizecnt			int,		@prizecnt2			int,
											@prizecoin2			int,
			@tradefailcnt		int,
			@tradecntold		int,
			@prizecntold		int,
			@tradecntoldbef		int,

			@qtsalebarrel		int,
			@qtsalecoin			int,
			@qtfame				int,
			@qtfeeduse			int,
			@qttradecnt			int,
			@qtsalecoinbest		int,

			@ttsalecoin			int,
											@param20			int,
											@param21			int,
											@param22			int,
											@param23			int,
											@param24			int,
											@param25			int,
											@param26			int,
											@param27			int,
											@param28			int,
											@param29			int,
			@bkbarrel			int,
			@bktsalecoin		int

	set @gamecost 	= 0
	set @cashcost 	= 0
	set @feed		= 0
	set @heart		= 0
	set @heartmax	= 0
	set @fpoint		= 0
	set @comreward	= 0

	set	@qtsalebarrel	= 0
	set	@qtsalecoin		= 0
	set	@qtfame			= 0
	set	@qtfeeduse		= 0
	set	@qttradecnt		= 0
	set	@qtsalecoinbest	= 0

	set	@ttsalecoin		= 0

	set @bkbarrel		= 0
	set @bktsalecoin	= 0
	set @bktwolfkillcnt	= 0

	set @famelvchange 	= -1

	declare 								@stranistep2		varchar(40),
											@strmanger2			varchar(40),
											@strdiseasestate2	varchar(40),
											@listidx2			int,
											@usecnt2			int,
											@cusitemcode		int,
											@cusitemname		varchar(40),
											@cusowncnt			int,
			@data				varchar(40),@data2				varchar(40),
			@pos1	 			int, 		@pos2	 			int,	@pos3	 			int,
			@strlen				int


	declare @usecnt				int

	declare @saletrader			int,		@saletrader2		int,
			@saledanga			int,		@saledanga2			int,
			@saleplusdanga		int,		@saleplusdanga2		int,
			@salebarrel			int,		@salebarrel2		int,
			@salefresh			int,		@salefresh2			int,
			@salecoin			int,		@salecoin2			int,
			@saleitemcode		int,		@saleitemcode2		int,
											@orderbarrel2		int,
											@orderfresh2		int,
											@milkproduct2		int

	declare @blogsave			int			set @blogsave		= 1
	declare @temp				int
	declare @idx2				int
	declare @tankbarrelmax		int			set @tankbarrelmax	= 7

	-- 분기별 추가 하트지급.
	declare @quarter			int			set @quarter		= 0
	declare @adidx				int			set @adidx			= 0
	declare @adidxmax			int			set @adidxmax		= 0
	declare @plusheart			int			set @plusheart		= 0
	declare @plusheartcow		int			set @plusheartcow	= 0
	declare @plusheartsheep		int			set @plusheartsheep	= 0
	declare @plusheartgoat		int			set @plusheartgoat	= 0

	-- 학교대항전
	declare @schoolidx			int			set @schoolidx		= -1
	declare @earncoin			int			set @earncoin		= 0

	------------------------------------
	-- 에피소드 변수..
	------------------------------------
	declare @etsalecoin			int			set @etsalecoin		= 0		-- 에피소드 기간동 수익.
	declare @etremain			int			set @etremain		= -1
	declare @etremainyear		int			set @etremainyear	= -1
	declare @etsalecoin2		int			set @etsalecoin2	= 0
	declare @etsatisfycnt		int			set @etsatisfycnt	= 0		-- 만족개수.
	declare @etrecord			int			set @etrecord		= -1
	declare @etestimate			int
	declare @etgameyear			int			set @etgameyear		= -1
	declare @etgamemonth		int			set @etgamemonth	= -1

	declare @etgrade			int			set @etgrade		= @EPISODE_GRADE_NON
	declare @etreward1			int			set @etreward1		= -1
	declare @etreward2			int			set @etreward2		= -1
	declare @etreward3			int			set @etreward3		= -1
	declare @etreward4			int			set @etreward4		= -1
	declare @etreward			int			set @etreward		= -1
	declare @etcheckresult1		int			set @etcheckresult1	= -1
	declare @etcheckresult2		int			set @etcheckresult2	= -1
	declare @etcheckresult3		int			set @etcheckresult3	= -1


	declare @etitemcode			int			set @etitemcode		= 91000
	declare @etcheckvalue1		int			set @etcheckvalue1	= -1
	declare @etcheckvalue2		int			set @etcheckvalue2	= -1
	declare @etcheckvalue3		int			set @etcheckvalue3	= -1
	declare @etrewardbad1		int			set @etrewardbad1	= -1
	declare @etrewardnor1		int			set @etrewardnor1	= -1
	declare @etrewardnor2		int			set @etrewardnor2	= -1
	declare @etrewardgood1		int			set @etrewardgood1	= -1
	declare @etrewardgood2		int			set @etrewardgood2	= -1
	declare @etrewardgood3		int			set @etrewardgood3	= -1
	declare @etrewardex1		int			set @etrewardex1	= -1
	declare @etrewardex2		int			set @etrewardex2	= -1
	declare @etrewardex3		int			set @etrewardex3	= -1
	declare @etrewardex4		int			set @etrewardex4	= -1

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

	declare @field5lv			int			set @field5lv		= 50
	declare @field6lv			int			set @field6lv		= 50
	declare @field7lv			int			set @field7lv		= 50
	declare @field8lv			int			set @field8lv		= 50

	-- 복귀 처리.
	declare @rtnflag				int														-- 현재복귀 플래그 상태.
	declare @rtnreward				int				set @rtnreward 					= -1	-- 보상템이 존재하는가?
	declare @rtnstep				int				set @rtnstep					= -1	-- 1일차 1, 2일차 2....
	declare @rtnplaycnt				int				set @rtnplaycnt					= 0		-- 거래횟수.
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG 입력값', @gameid_ gameid_, @password_ password_, @userinfo_ userinfo_, @aniitem_ aniitem_, @cusitem_ cusitem_, @tradeinfo_ tradeinfo_


	------------------------------------------------
	--	유저정보.
	------------------------------------------------
	select
		@gameid 		= gameid,
		@blockstate 	= blockstate,
		@gamecost		= gamecost,
		@cashcost		= cashcost,
		@feed			= feed,
		@heart			= heart,
		@heartmax		= heartmax,
		@fpoint			= fpoint,
		@comreward		= comreward,
		@schoolidx		= schoolidx,
		@rtnstep		= rtnstep,
		@rtnplaycnt		= rtnplaycnt,

		@gameyear		= gameyear,
		@gamemonth		= gamemonth,
		@frametime		= frametime,
		@fevergauge		= fevergauge,
		@bottlelittle	= bottlelittle,
		@bottlefresh	= bottlefresh,
		@tanklittle		= tanklittle,
		@tankfresh		= tankfresh,
		@adidx			= adidx,

		@etgameyear		= gameyear,
		@etgamemonth	= gamemonth,

		@field0			= field0,			@field1			= field1,			@field2			= field2,
		@field3			= field3,			@field4			= field4,			@field5			= field5,
		@field6			= field6,			@field7			= field7,			@field8			= field8,

		@housestep 		= housestep,		@housestate		= housestate,		@housetime		= housetime,
		@bottlestep		= bottlestep,		@bottlestate	= bottlestate,		@bottletime		= bottletime,
		@tankstep		= tankstep,			@tankstate		= tankstate,		@tanktime		= tanktime,

		@fame			= fame,
		@famelv			= famelv,
		@famelvbest		= famelvbest,
		@tradecnt		= tradecnt,
		@prizecnt		= prizecnt,
		@tradefailcnt	= tradefailcnt,

		@tradecntold	= tradecnt,
		@prizecntold	= prizecnt,
		@tradecntoldbef	= tradecntold,

		@qtsalebarrel	= qtsalebarrel,
		@qtsalecoin		= qtsalecoin,
		@qtfame			= qtfame,
		@qtfeeduse		= qtfeeduse,
		@qttradecnt		= qttradecnt,
		@qtsalecoinbest	= qtsalecoinbest,

		@ttsalecoin		= ttsalecoin,
		@etsalecoin		= etsalecoin,
		@etremain		= etremain,

		@bkbarrel		= bkbarrel,
		@bktsalecoin	= bktsalecoin,
		@bktwolfkillcnt	= bktwolfkillcnt
	from dbo.tFVUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 유저정보', @tradecnt tradecnt, @tradecntoldbef tradecntoldbef, @gameid gameid, @gamecost gamecost, @feed feed, @gameyear gameyear, @gamemonth gamemonth, @frametime frametime, @fevergauge fevergauge, @bottlelittle bottlelittle, @bottlefresh bottlefresh, @tanklittle tanklittle, @tankfresh tankfresh, @fame fame, @famelv famelv, @tradecnt tradecnt, @prizecnt prizecnt

	------------------------------------------------
	-- 유저정보 > 집 > 게임코인Max.
	-- 양동이, 탱크 > 우유량Max
	------------------------------------------------
	select top 1
		@housestepmax	= housestepmax,		@bottlestepmax	= bottlestepmax,		@tankstepmax	= tankstepmax,
		@field5lv		= field5lv,			@field6lv		= field6lv,				@field7lv		= field7lv,			@field8lv		= field8lv,
		@rtnflag 		= rtnflag
	from dbo.tFVSystemInfo
	order by idx desc

	set @housestep = case when (@housestep < @housestepmax and @housestate = @USERMASTER_UPGRADE_STATE_ING and @curdate >= @housetime) then (@housestep + 1) else @housestep end
	select
		@playcoinmax		= param7
	from dbo.tFVItemInfo
	where subcategory = @ITEM_SUBCATEGORY_UPGRADE_HOUSE and param1 = @housestep

	set @bottlestep = case when (@bottlestep < @bottlestepmax and @bottlestate = @USERMASTER_UPGRADE_STATE_ING and @curdate >= @bottletime) then (@bottlestep + 1) else @bottlestep end
	select
		@bottlelittlemax	= param5
	from dbo.tFVItemInfo
	where subcategory = @ITEM_SUBCATEGORY_UPGRADE_BOTTLE and param1 = @bottlestep

	set @tankstep = case when (@tankstep < @tankstepmax and @tankstate = @USERMASTER_UPGRADE_STATE_ING and @curdate >= @tanktime) then (@tankstep + 1) else @tankstep end
	select
		@tanklittlemax		= param5 * 30,
		@tankbarrelmax		= param5
	from dbo.tFVItemInfo
	where subcategory = @ITEM_SUBCATEGORY_UPGRADE_TANK and param1 = @tankstep

	--select 'DEBUG 집정보 ', @housestep housestep, @playcoinmax playcoinmax, @bottlestep bottlestep, @bottlelittlemax bottlelittlemax, @tankstep tankstep, @tanklittlemax tanklittlemax


	------------------------------------------------
	-- 입력정보1 (useinfo).
	-- userinfo=gameyear;gamemonth;frametime;fevergauge;bottlelittle;bottlefresh;tanklittle;tankfresh;feeduse;
    --          0:2013;  1:4;      2:0;      4:2;       10:10;       11:100;     12:20;     13:200;   30:3;
	------------------------------------------------
	set @gameyear2 		= @INIT_VALUE
	set @gamemonth2 	= @INIT_VALUE
	set @frametime2		= @INIT_VALUE
	set @fevergauge2	= @INIT_VALUE
	set @bottlelittle2	= @INIT_VALUE
	set @bottlefresh2	= @INIT_VALUE
	set @tanklittle2	= @INIT_VALUE
	set @tankfresh2		= @INIT_VALUE
	set @feeduse2		= @INIT_VALUE
	set @wolfkillcnt2	= 0


	if(LEN(@userinfo_) >= 3)
		begin
			-- 1. 커서 생성
			declare curUserInfo Cursor for
			select fieldidx, listidx FROM dbo.fnu_SplitTwo(';', ':', @userinfo_)

			-- 2. 커서오픈
			open curUserInfo

			-- 3. 커서 사용
			Fetch next from curUserInfo into @kind, @info
			while @@Fetch_status = 0
				Begin
					if(@kind = @SAVE_USERINFO_GAMEYEAR)
						begin
							set @gameyear2 		= @info
						end
					else if(@kind = @SAVE_USERINFO_MONTH)
						begin
							set @gamemonth2 	= @info
						end
					else if(@kind = @SAVE_USERINFO_FRAMETIME)
						begin
							set @frametime2 	= @info
						end
					else if(@kind = @SAVE_USERINFO_FEVERGAUGE)
						begin
							set @fevergauge2 	= @info
						end
					else if(@kind = @SAVE_USERINFO_BOTTLELITTLE)
						begin
							set @bottlelittle2 	= @info
						end
					else if(@kind = @SAVE_USERINFO_BOTTLEFRESH)
						begin
							set @bottlefresh2 	= @info
						end
					else if(@kind = @SAVE_USERINFO_TANKLITTLE)
						begin
							set @tanklittle2 	= @info
						end
					else if(@kind = @SAVE_USERINFO_TANKFRESH)
						begin
							set @tankfresh2 	= @info
						end
					else if(@kind = @SAVE_USERINFO_USEFEED)
						begin
							set @feeduse2 		= @info
						end
					else if(@kind = @SAVE_USERINFO_WOLFKILLCNT)
						begin
							set @wolfkillcnt2	= @info
						end
					Fetch next from curUserInfo into @kind, @info
				end
			-- 4. 커서닫기
			close curUserInfo
			Deallocate curUserInfo
			--select 'DEBUG 입력정보(useinfo)', @gameyear2 gameyear2, @gamemonth2 gamemonth2, @frametime2 frametime2, @fevergauge2 fevergauge2, @bottlelittle2 bottlelittle2, @bottlefresh2 bottlefresh2, @tanklittle2 tanklittle2, @tankfresh2 tankfresh2, @feeduse2 feeduse2, @wolfkillcnt2 wolfkillcnt2
		end

	------------------------------------------------
	-- 입력정보2.(aniitem) > 하단에서 세팅.
	------------------------------------------------

	------------------------------------------------
	-- 입력정보3.(cusitem) > 하단에서 세팅.
	------------------------------------------------

	----------------------------------------------
	-- 입력정보3-2.(param) >
	-- paraminfo=param0;param1;param2;param3;...
	--       0:0;   1:0;   2:0;   3:0;
	----------------------------------------------
	set @param20 		= @INIT_VALUE
	set @param21 		= @INIT_VALUE
	set @param22 		= @INIT_VALUE
	set @param23 		= @INIT_VALUE
	set @param24 		= @INIT_VALUE
	set @param25 		= @INIT_VALUE
	set @param26 		= @INIT_VALUE
	set @param27 		= @INIT_VALUE
	set @param28 		= @INIT_VALUE
	set @param29 		= @INIT_VALUE

	if(LEN(@paraminfo_) >= 3)
		begin
			-- 1. 커서 생성
			declare curParamInfo Cursor for
			select fieldidx, listidx FROM dbo.fnu_SplitTwo(';', ':', @paraminfo_)

			-- 2. 커서오픈
			open curParamInfo

			-- 3. 커서 사용
			Fetch next from curParamInfo into @kind, @info
			while @@Fetch_status = 0
				Begin
					if(@kind = 0)
						begin
							set @param20 		= @info
						end
					else if(@kind = 1)
						begin
							set @param21 		= @info
						end
					else if(@kind = 2)
						begin
							set @param22 		= @info
						end
					else if(@kind = 3)
						begin
							set @param23 		= @info
						end
					else if(@kind = 4)
						begin
							set @param24 		= @info
						end
					else if(@kind = 5)
						begin
							set @param25 		= @info
						end
					else if(@kind = 6)
						begin
							set @param26 		= @info
						end
					else if(@kind = 7)
						begin
							set @param27 		= @info
						end
					else if(@kind = 8)
						begin
							set @param28 		= @info
						end
					else if(@kind = 9)
						begin
							set @param29 		= @info
						end
					Fetch next from curParamInfo into @kind, @info
				end
			-- 4. 커서닫기
			close curParamInfo
			Deallocate curParamInfo
			--select 'DEBUG 입력정보(useinfo)', @param20 param20, @param21 param21, @param22 param22, @param23 param23, @param24 param24, @param25 param25, @param26 param26, @param27 param27, @param28 param28, @param29 param29
		end

	------------------------------------------------
	-- 입력정보4(tradeinfo).
	--	tradeinfo=fame:famelv:tradecnt:prizecnt:prizecoin:playcoin:saletrader:saledanga:saleplusdanga:salebarrel:salefresh:salecoin:saleitemcode
	--			  0:5; 1:2;   10:1;    11:1;    12:75;    20:1;    30:1;      31:10;    32:1;         33:10;     34:20;    35:60;   40:-1;
	-- SELECT * FROM dbo.fnu_SplitTwo(';', ':', '0:5; 1:2;   10:1;    11:1;    12:75;    20:1;    30:1;      31:10;    32:1;         33:10;     34:20;    35:60;   40:-1;')
	------------------------------------------------
	set @fame2			= @INIT_VALUE
	set @famelv2 		= @INIT_VALUE
	set @tradecnt2 		= @INIT_VALUE
	set @prizecnt2		= @INIT_VALUE
	set @prizecoin2		= @INIT_VALUE
	set @playcoin2 		= @INIT_VALUE
	set @saletrader2 	= @INIT_VALUE
	set @saledanga2 	= @INIT_VALUE		-- 필터핵힘
	set @saleplusdanga2 = @INIT_VALUE
	set @salebarrel2 	= @INIT_VALUE
	set @salefresh2		= @INIT_VALUE
	set @salecoin2 		= @INIT_VALUE
	set @saleitemcode2 	= @INIT_VALUE
	-- plusheart2 는 서버에서 계산함.
	set @orderbarrel2	= @INIT_VALUE
	set @orderfresh2 	= @INIT_VALUE
	set @milkproduct2	= 0
	--select 'DEBUG ', @tradeinfo_ tradeinfo_

	if(LEN(@tradeinfo_) >= 3)
		begin
			-- 1. 커서 생성
			declare curTradeInfo Cursor for
			select fieldidx, listidx FROM dbo.fnu_SplitTwo(';', ':', @tradeinfo_)

			-- 2. 커서오픈
			open curTradeInfo

			-- 3. 커서 사용
			Fetch next from curTradeInfo into @kind, @info
			while @@Fetch_status = 0
				Begin
					--select 'DEBUG', @kind, @info
					if(@kind = @SAVE_TRADEINFO_FAME)
						begin
							set @fame2 		= @info
						end
					else if(@kind = @SAVE_TRADEINFO_FAMELV)
						begin
							set @famelv2 	= @info
						end
					else if(@kind = @SAVE_TRADEINFO_TRADECNT)
						begin
							set @tradecnt2 	= @info
						end
					else if(@kind = @SAVE_TRADEINFO_PRIZECNT)
						begin
							set @prizecnt2 	= @info
						end
					else if(@kind = @SAVE_TRADEINFO_PRIZECOIN)
						begin
							set @prizecoin2	= @info
						end
					else if(@kind = @SAVE_TRADEINFO_PLAYCOIN)
						begin
							set @playcoin2 	= @info
						end
					else if(@kind = @SAVE_TRADEINFO_SALETRADER)
						begin
							set @saletrader2 	= @info
						end
					else if(@kind = @SAVE_TRADEINFO_SALEDANGA)
						begin
							set @saledanga2 	= @info
						end
					else if(@kind = @SAVE_TRADEINFO_SALEPLUSDANGA)
						begin
							set @saleplusdanga2 	= @info
						end
					else if(@kind = @SAVE_TRADEINFO_SALEBARREL)
						begin
							set @salebarrel2 	= @info
						end
					else if(@kind = @SAVE_TRADEINFO_SALEFRESH)
						begin
							set @salefresh2 	= @info
						end
					else if(@kind = @SAVE_TRADEINFO_SALECOST)
						begin
							set @salecoin2 	= @info
						end
					else if(@kind = @SAVE_TRADEINFO_SALEITEMCODE)
						begin
							set @saleitemcode2 	= @info
						end
					else if(@kind = @SAVE_TRADEINFO_ORDERBARREL)
						begin
							set @orderbarrel2 	= @info
						end
					else if(@kind = @SAVE_TRADEINFO_ORDERFRESH)
						begin
							set @orderfresh2 	= @info
						end
					else if(@kind = @SAVE_TRADEINFO_MILK_PRODUCT)
						begin
							set @milkproduct2 	= @info
						end
					Fetch next from curTradeInfo into @kind, @info
				end
			-- 4. 커서닫기
			close curTradeInfo
			Deallocate curTradeInfo
			--select 'DEBUG 입력정보(tradeinfo)', @fame2 fame2, @famelv2 famelv2, @tradecnt2 tradecnt2, @prizecnt2 prizecnt2, @prizecoin2 prizecoin2, @playcoin2 playcoin2, @saletrader2 saletrader2, @saledanga2 saledanga2, @saleplusdanga2 saleplusdanga2, @salebarrel2 salebarrel2, @salefresh2 salefresh2, @salecoin2 salecoin2, @saleitemcode2 saleitemcode2
			--select 'DEBUG 수익정보', @saledanga2 saledanga2, @saleplusdanga2 saleplusdanga2, @salebarrel2 salebarrel2, @salecoin2 salecoin2, ((@saledanga2 + @saleplusdanga2)* @salebarrel2) 판매수익, @prizecnt2 prizecnt2, @prizecoin2 prizecoin2, @prizecnt2 * @DEFINE_PRIZECOIN_BASE 상장수익, @playcoin2 playcoin2, @playcoinmax playcoinmax
		end

	if(isnull(@gameid, '') = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '아이디가 존재하지 않는다.'
		END
	else if (@blockstate = @BLOCK_STATE_YES)
		BEGIN
			-- 블럭유저인가?
			set @nResult_ 	= @RESULT_ERROR_BLOCK_USER
			set @comment 	= '블럭처리된 아이디입니다.'
		END
	else if(@gameyear2 = @INIT_VALUE 		or @gamemonth2 = @INIT_VALUE	or @frametime2 = @INIT_VALUE 	or @fevergauge2 = @INIT_VALUE 	or
			@bottlelittle2 = @INIT_VALUE 	or @bottlefresh2 = @INIT_VALUE	or @tanklittle2	= @INIT_VALUE	or @tankfresh2	= @INIT_VALUE	or @feeduse2		= @INIT_VALUE
			--@wolfkillcnt2= 0
			)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_PARAMETER
			set @comment 	=  '파라미터 오류(1) 유저정보오류.'
			exec spu_FVSubUnusualRecord2 @gameid_, 0, @comment
		END
	else if(@fame2			= @INIT_VALUE or	@famelv2 		= @INIT_VALUE or	@tradecnt2 		= @INIT_VALUE or	@prizecnt2		= @INIT_VALUE or 	@prizecoin2 	= @INIT_VALUE or
			@playcoin2 		= @INIT_VALUE or	@saletrader2 	= @INIT_VALUE or	@saledanga2 	= @INIT_VALUE or	@saleplusdanga2 = @INIT_VALUE or
			@salebarrel2 	= @INIT_VALUE or	@salefresh2		= @INIT_VALUE or	@salecoin2 		= @INIT_VALUE or	@saleitemcode2 	= @INIT_VALUE)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_PARAMETER
			set @comment 	=  '파라미터 오류(2) 거래정보오류.'
			exec spu_FVSubUnusualRecord2 @gameid_, 0, @comment
		END
	else if(not exists(select top 1 * from dbo.tFVUserSaleRewardItemCode where itemcode = @saleitemcode2))
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_PARAMETER
			set @comment 	=  '파라미터 오류(3) 선물코드오류.'
			exec spu_FVSubUnusualRecord2 @gameid_, 0, @comment
		END
	-- 레벨치트방지.
	else if(@famelv2 > @FAMELV_MAX)
		begin
			set @nResult_ 	= @RESULT_ERROR_PARAMETER
			set @comment 	=  '(게임결과)레벨이 Max('+ltrim(rtrim(str(@FAMELV_MAX)))+')을 초과할 수 없습니다. 입력렙('+ltrim(rtrim(str(@famelv2)))+')'

			-- 네트워크 단절에 따른 유연화대책.
			exec spu_FVSubUnusualRecord2 @gameid_, 0, @comment
		end
	else if(@famelv2 > @famelv + 10)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_PARAMETER
			set @comment 	=  '(게임결과)레벨치트 저장렙('+ltrim(rtrim(str(@famelv)))+') 입력렙('+ltrim(rtrim(str(@famelv2)))+')'
			--select 'DEBUG ', @comment comment, @salebarrel2 salebarrel2

			-- 네트워크 단절에 따른 유연화대책.
			exec spu_FVSubUnusualRecord2 @gameid_, 0, @comment

			-- 거래중 네트워크 끊어져서 데이타 손실이 발생했습니다. 재실행 부탁합니다.(__)
		END
	-- 판매 배럴마이너스 오류
	else if(@salebarrel2 < @TRADEINFO_SALEBARREL_UNDER)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_PARAMETER
			set @comment 	=  '(게임결과)파라미터 오류(12) 판매배럴 음수대역오류. (게임결과)salebarrel2('+ltrim(rtrim(str(@salebarrel2)))+')'
			--select 'DEBUG ', @comment comment, @salebarrel2 salebarrel2

			-- 네트워크 단절에 따른 유연화대책.
			exec spu_FVSubUnusualRecord2 @gameid_, 0, @comment
		END
	-- 탱크 검사
	else if(@tanklittle2 < @TRADEINFO_TANKLITTLE_UNDER)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_PARAMETER
			set @comment 	=  '(게임결과)파라미터 오류(13) 탱크배럴 tanklittle2('+ltrim(rtrim(str(@tanklittle2)))+')  tanklittlemax('+ltrim(rtrim(str(@tanklittlemax)))+')'
			--select 'DEBUG ', @comment comment, @tanklittle2 tanklittle2, @tanklittlemax tanklittlemax

			-- 네트워크 단절에 따른 유연화대책.
			exec spu_FVSubUnusualRecord2 @gameid_, 0, @comment
		END
	else if(@tanklittle2 > @tanklittlemax + @TRADEINFO_TANKLITTLE_GAP)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_PARAMETER
			set @comment 	=  '(게임결과)파라미터 오류(13) 탱크배럴 tanklittle2('+ltrim(rtrim(str(@tanklittle2)))+')  tanklittlemax('+ltrim(rtrim(str(@tanklittlemax)))+')'
			--select 'DEBUG ', @comment comment, @tanklittle2 tanklittle2, @tanklittlemax tanklittlemax

			-- 네트워크 단절에 따른 유연화대책.
			exec spu_FVSubUnusualRecord2 @gameid_, 0, @comment
		END
	-- 단가필터 추가.
	else if(@saledanga2 > @TRADEINFO_SALEDANGA_MAX or @saleplusdanga2 > @TRADEINFO_SALEPLUSDANGA_MAX)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_RESULT_COPY
			set @comment 	=  '(게임결과)단기치트(14) saledanga2('+ltrim(rtrim(str(@saledanga2)))+') > '+ltrim(rtrim(str(@TRADEINFO_SALEDANGA_MAX)))+' 넘을수 없음.'
							+  'saleplusdanga2('+ltrim(rtrim(str(@saleplusdanga2)))+') > '+ltrim(rtrim(str(@TRADEINFO_SALEPLUSDANGA_MAX)))+' 넘을수 없음.'
			--select 'DEBUG ', @saledanga2 saledanga2, @saleplusdanga2 saleplusdanga2, @TRADEINFO_SALEDANGA_MAX TRADEINFO_SALEDANGA_MAX, @TRADEINFO_SALEPLUSDANGA_MAX TRADEINFO_SALEPLUSDANGA_MAX

			-- 네트워크 단절에 따른 유연화대책.
			exec spu_FVSubUnusualRecord2 @gameid_, 0, @comment
		END
	-- 거래필터 추가.(기존것 + 올드)
	else if(@tradecnt2 > (@tradecnt + 2) and @tradecnt2 > (@tradecntoldbef + 2))
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_RESULT_COPY
			set @comment 	=  '(게임결과)연속거래(15) tradecnt2('
								+ ltrim(rtrim(str(@tradecnt2)))
								+ ') > 현재('
								+ ltrim(rtrim(str(@tradecnt)))
								+ ' + 2) and 전('
								+ ltrim(rtrim(str(@tradecntoldbef)))
								+ ' + 2) 넘을수 없음.'
			--select 'DEBUG ', @tradecnt tradecnt, @tradecntoldbef tradecntoldbef, @tradecnt2 tradecnt2, @TRADEINFO_TRADECNT_NEXT TRADEINFO_TRADECNT_NEXT

			-- 네트워크 단절에 따른 유연화대책.
			exec spu_FVSubUnusualRecord2 @gameid_, 0, @comment
		END
	else if(@salebarrel2 > @tankbarrelmax)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_RESULT_COPY
			set @comment 	=  '(게임결과) 판매배럴'+ltrim(rtrim(str(@salebarrel2)))+' > 우유탱크'+ltrim(rtrim(str(@tankbarrelmax)))+' 넘을수 없음.'
			-- 판매배럴 > 우유탱크 넘을수 없음.
			--select 'DEBUG ', @salebarrel2 salebarrel2, @tankbarrelmax tankbarrelmax

			-- 네트워크 단절에 따른 유연화대책.
			exec spu_FVSubUnusualRecord2 @gameid_, 0, @comment
		END
	else if(   (((@saledanga2 + @saleplusdanga2) * @salebarrel2) != @salecoin2)
			-- or (@prizecoin2 != 0 and ((@prizecnt2 * @DEFINE_PRIZECOIN_BASE) != @prizecoin2 ))
			-- or ((@prizecoin2 > 0 and @prizecoin2 < @TRADEINFO_PRIZECOIN_MAX) and (@prizecoin2 != (@prizecnt2 * @DEFINE_PRIZECOIN_BASE)))
			or ( @prizecoin2 > @TRADEINFO_PRIZECOIN_MAX)
			or (@playcoin2 > @playcoinmax))
		BEGIN
			-- 판매수익				: (단가 + Plus단가)*배럴 = 판매수익.
			-- 게임중 획득한 코인.	: playcoin <= 집허용.
			-- 표창장 받은횟수 * 75	: prizecnt * 75 = 추가수익.
			--select 'DEBUG ', (@saledanga2 + @saleplusdanga2) * @salebarrel2, @salecoin2
			--select 'DEBUG ', @prizecoin2, (@prizecnt2 * @DEFINE_PRIZECOIN_BASE)
			--select 'DEBUG ', @prizecoin2, @TRADEINFO_PRIZECOIN_MAX
			--select 'DEBUG ', @playcoin2, @playcoinmax

			set @nResult_ 	= @RESULT_ERROR_RESULT_COPY
			set @comment 	=  '(게임결과)게임코인을 결과가 불일치합니다.'

			-- 네트워크 단절에 따른 유연화대책.
			exec spu_FVSubUnusualRecord2 @gameid_, 0, @comment
		END
	else if(exists(select top 1 * from dbo.tFVUserSaleLog where gameid = @gameid_ and gameyear = @gameyear2 and gamemonth = @gamemonth2))
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	=  '정보를 저장합니다(2). '

			------------------------------------------------
			-- 분기데이타 클리어 and 세팅.
			------------------------------------------------
			set @quarter = case
								when (@gamemonth2 = 3 + 1) then 1
								when (@gamemonth2 = 6 + 1) then 2
								when (@gamemonth2 = 9 + 1) then 3
								when (@gamemonth2 =     1) then 4
								else 					      0
							end

			set @blogsave		= -1
		END
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '정보를 저장합니다(1).'

			------------------------------------------------
			-- 분기데이타 클리어 and 세팅.
			------------------------------------------------
			set @quarter = case
								when (@gamemonth2 = 3 + 1) then 1
								when (@gamemonth2 = 6 + 1) then 2
								when (@gamemonth2 = 9 + 1) then 3
								when (@gamemonth2 =     1) then 4
								else 					      0
							end

			if(@gamemonth2 in (3+2, 6+2, 9+2, 2))
				begin
					set	@qtsalebarrel	= 0
					set	@qtsalecoin		= 0
					set	@qtfame			= 0
					set	@qtfeeduse		= 0
					set	@qttradecnt		= 0
					set	@qtsalecoinbest	= 0
				end
			set @temp 			= (@salecoin2 + @prizecoin2 + @playcoin2)
			set @earncoin		= @temp
			set	@qtsalebarrel	= @qtsalebarrel + @salebarrel2
			set	@qtsalecoin		= @qtsalecoin + @temp
			set	@qtfame			= @qtfame + (@fame2 - @fame)
			set	@qtfeeduse		= @qtfeeduse + @feeduse2
			set	@qttradecnt		= @tradecnt2
			set	@qtsalecoinbest	= case when @temp > @qtsalecoinbest then @temp else @qtsalecoinbest end

			---------------------------------------
			-- 1안 랭킹용 > 총수익(변경). > 최고 갱신방식으로 보내서 이상한것 같아서 누적으로 변경(2014-02-21)
			set @ttsalecoin	= @ttsalecoin + @temp
			-- 2안 랭킹용 > 연속거래.
			-- set @ttsalecoin	= case when @tradecnt2 > @ttsalecoin then @tradecnt2 else @ttsalecoin end
			-- 3안 연속거래 성공 > 랭킹점수Plus
			-- set @ttsalecoin	= @ttsalecoin + case when @tradecnt2 > 0 then @temp else 0 end
			-- 4안 거래중 Best거래
			-- set @ttsalecoin	= case when @temp > @ttsalecoin then @temp else @ttsalecoin end
			---------------------------------------

			--총수익누정.
			set @bktsalecoin	= @bktsalecoin + @temp
			set @bkbarrel		= @bkbarrel + @salebarrel2

			-- 에피소드수익.
			set @etsalecoin		= @etsalecoin + @earncoin
			set @etsalecoin2 	= @etsalecoin

			----------------------------------------------
			-- 유저정보저장, 거래정보.(보정만하기.)
			----------------------------------------------
			-- 획득코인(게임중 획득코인).
			set @playcoin2 = case
									when @playcoin2 < 0 			then 0
									when @playcoin2 > @playcoinmax	then 0
									else @playcoin2
							end
			--       코인 = 원래코인  + 게임중 획득코인(검사완) + 상장코인(6개월마다:검사완) + 판매수익(검사완) + 유제품수익
			set @gamecost = @gamecost + @playcoin2              + @prizecoin2				 + @salecoin2       + @milkproduct2
			--select 'DEBUG 추가코인(후)', @gamecost gamecost, @playcoin2 playcoin2, @playcoinmax playcoinmax

			-- 사용 사료.
			set @feed = @feed - case when (@feeduse2 < 0) then (-@feeduse2) else @feeduse2 end
			set @feed = case when @feed < 0 then 0 else @feed end
			--select 'DEBUG 사용 사료(후)', @feed feed, @feeduse2 feeduse2

			-- 년, 월, 일.
			--select 'DEBUG 검사(전)', @gameyear gameyear, @gamemonth gamemonth, @gameyear2 gameyear2, @gamemonth2 gamemonth2
			if(@gameyear = @gameyear2 and (@gamemonth + 1) = @gamemonth2)
				begin
					-- 2013년 01월 > 2013년 02월...
					-- 2013년 03월 > 2013년 04월...
					-- 2013년 11월 > 2013년 12월...
					set @gameyear = @gameyear2
					set @gamemonth = @gamemonth2
					--select 'DEBUG 세팅1'
				end
			else if((@gameyear + 1) = @gameyear2 and @gamemonth = 12 and @gamemonth2 = 1)
				begin
					-- 2013년 12월 > 2014년 1월
					set @gameyear = @gameyear2
					set @gamemonth = @gamemonth2
					--select 'DEBUG 세팅2'
				end
			else
				begin
					set @gameyear = @gameyear
					set @gamemonth = @gamemonth + 1
					--select 'DEBUG 세팅3'
				end
			set @frametime 		= 0		-- save에서는 거꾸로 가는것 막기.
			--select 'DEBUG 검사(후)', @gameyear gameyear, @gamemonth gamemonth, @gameyear2 gameyear2, @gamemonth2 gamemonth2

			-- 피버검사.
			set @fevergauge		= case when (@fevergauge2 < 0 or @fevergauge2 >= 5) then 0 else @fevergauge2 end
			--select 'DEBUG 피버(후)', @fevergauge fevergauge, @fevergauge2 fevergauge2

			-- 우유 양동이, 탱크.
			set @bottlelittle	= case
									when (@bottlelittle2 < 0) 						then 0
									when (@bottlelittle2 > @bottlelittlemax) 		then @bottlelittlemax
									else @bottlelittle2
								  end
			set @bottlefresh	= case
									when (@bottlefresh2 < 0)						then 0
									when (@bottlefresh2 > @bottlelittlemax * 300)	then @bottlelittlemax * 300
									else @bottlefresh2
								  end
			set @tanklittle		= case
									when (@tanklittle2 < 0)							then 0
									when (@tanklittle2 > @tanklittlemax)	 		then @tanklittlemax
									else @tanklittle2
								  end
			set @tankfresh		= case
									when (@tankfresh2 < 0)							then 0
									when (@tankfresh2 > @tanklittlemax * 300) 		then @tanklittlemax * 300
									else @tankfresh2
								  end

			--select 'DEBUG 양동이, 탱크(후)', @bottlelittle bottlelittle, @bottlelittle2 bottlelittle2,	@bottlelittlemax bottlelittlemax, @bottlefresh bottlefresh, 	@bottlefresh2 bottlefresh2, @tanklittle tanklittle, 	@tanklittle2 tanklittle2, 		@tanklittlemax tanklittlemax, @tankfresh tankfresh,		@tankfresh2 tankfresh2
			set @famelvchange = case when (@famelv2 = @famelv) then -1 else 1 end

			--select 'DEBUG 일반검사(전)', @fame fame, @fame2 fame2, @famelv famelv, @famelv2 famelv2, @tradecnt tradecnt, @tradecnt2 tradecnt2, @prizecnt prizecnt, @prizecnt2 prizecnt2
			-- 일반데이타 유효성검사.(만족시 10, 7, 5, 수량불만족 -15, 신선도불만족 -15 입니다)
			set @fame		= case when (@fame2   >= @fame - 150  and @fame2   <= @fame + 30) 		then @fame2 		else @fame end
			set @famelv		= case when (@famelv2 >= @famelv - 10 and @famelv2 <= @famelv + 2) 		then @famelv2 		else @famelv end
			set @prizecnt	= case when (@prizecnt2 >= 0 		 and @prizecnt2 <= @prizecnt + 1)	then @prizecnt2		else 0 end
			--select 'DEBUG (전)', @tradecnt tradecnt, @tradecntoldbef tradecntoldbef, @tradecnt2 tradecnt2
			set @tradecnt	= case
									when (@tradecnt2 >= 0 		 and @tradecnt2 <= @tradecnt + 1)		then @tradecnt2
									when (@tradecnt2 >= 0 		 and @tradecnt2 <= @tradecntoldbef + 1)	then @tradecnt2
									else 0
								end
			--select 'DEBUG (후)', @tradecnt tradecnt, @tradecntoldbef tradecntoldbef, @tradecnt2 tradecnt2


			----------------------------------------
			-- 상인원성표시
			-- 	> 황금상인 제외
			-- 	> 상인요구와 판매가 일치하는 경우도 제외(2배럴)
			----------------------------------------
			if((@orderbarrel2 = 1 and @orderfresh2 = 1) or (@orderbarrel2 >= 0 and @orderbarrel2 <= @salebarrel2))
				begin
					-- 황금 상인호출
					set @tradefailcnt = 0
				end
			else if(@salebarrel2 <= 2 or @tradecnt = 0)
				begin
					-- 그외 2배럴 이하나 연속거래 실패
					set @tradefailcnt = @tradefailcnt + 1
				end
			else
				begin
					set @tradefailcnt = 0
				end
			--set @tradefailcnt= case when (@tradecnt = 0 )											then @tradefailcnt + 1 else 0 end
			set @famelvbest	= case when (@famelv > @famelvbest)										then @famelv		else @famelvbest end

			-- 필드오픈.
			if(@famelvbest >= @field8lv)
				begin
					set @field8		= 1
					set @field7		= 1
					set @field6		= 1
					set @field5		= 1
				end
			else if(@famelvbest >= @field7lv)
				begin
					set @field7		= 1
					set @field6		= 1
					set @field5		= 1
				end
			else if(@famelvbest >= @field6lv)
				begin
					set @field6		= 1
					set @field5		= 1
				end
			else if(@famelvbest >= @field5lv)
				begin
					set @field5		= 1
				end

			--select 'DEBUG 일반검사(후)', @fame fame, @fame2 fame2, @famelv famelv, @famelv2 famelv2, @tradecnt tradecnt, @tradecnt2 tradecnt2, @prizecnt prizecnt, @prizecnt2 prizecnt2
			set @wolfkillcnt2 = case when @wolfkillcnt2 not in(0, 1, 2, 3) 							then  0 else @wolfkillcnt2 	end
			set @bktwolfkillcnt	= @bktwolfkillcnt + @wolfkillcnt2

			----------------------------------------------
			-- 동물정보.
			----------------------------------------------
			if(LEN(@aniitem_) >= 7)
				begin
					----------------------------------------------
					-- 내부번호를 보고 필드번호세팅
					----------------------------------------------
					-- 1. 커서 생성
					declare curAniItem Cursor for
					select * FROM dbo.fnu_SplitTwoStr(';', ':', @aniitem_)

					-- 2. 커서오픈
					open curAniItem

					-- 3. 커서 사용
					Fetch next from curAniItem into @listidx2, @data2
					while @@Fetch_status = 0
						Begin
							set @strlen = LEN(@data2)
							set @pos1 	= 0
							set @pos2 	= CHARINDEX(@CHAR_SPLIT_COMMA, @data2, @pos1)
							set @pos3 	= CHARINDEX(@CHAR_SPLIT_COMMA, @data2, @pos2 + 1)
							set @stranistep2		= SUBSTRING(@data2, @pos1    , @pos2 - @pos1)
							set @strmanger2			= SUBSTRING(@data2, @pos2 + 1, @pos3 - @pos2 - 1)
							set @strdiseasestate2	= SUBSTRING(@data2, @pos3 + 1, @strlen - @pos3)
							----select 'DEBUG ', @data2 data2, @strlen strlen, @pos1 pos1, @pos2 pos2, @pos3 pos3, SUBSTRING(@data2, @pos1    , @pos2 - @pos1), SUBSTRING(@data2, @pos2 + 1, @pos3 - @pos2 - 1), SUBSTRING(@data2, @pos3 + 1, @strlen - @pos3)
							--select 'DEBUG ', @data2 data2, @stranistep2 stranistep2, @strmanger2 strmanger2, @strdiseasestate2 strdiseasestate2
							if(Isnumeric(@stranistep2) = 1 and Isnumeric(@strmanger2) = 1 and Isnumeric(@strdiseasestate2) = 1)
								begin
									--select 'DEBUG 동물정보저장 (문자열 > 정상처리).', @listidx2 listidx2, @data2 data2, @stranistep2 stranistep2, @strmanger2 strmanger2, @strdiseasestate2 strdiseasestate2

									---------------------------------------
									-- 창고, 필드 	> 갱신
									-- 병원			> 패스
									---------------------------------------
									--update dbo.tFVUserItem
									--	set
									--		anistep 		= @stranistep2,
									--		manger			= @strmanger2,
									--		diseasestate	= @strdiseasestate2
									--from dbo.tFVUserItem
									--where gameid = @gameid_ and listidx = @listidx2 and invenkind = @USERITEM_INVENKIND_ANI and fieldidx != @USERITEM_FIELDIDX_HOSPITAL

									update dbo.tFVUserItem
										set
											anistep 		= @stranistep2,
											manger			= @strmanger2,
											diseasestate	= @strdiseasestate2,
											@plusheartcow	= 0,
											@plusheartsheep	= @plusheartsheep + case
																					when (@quarter in (   2,    4) and fieldidx != @USERITEM_FIELDIDX_INVEN)
																						then (
																								case
																										when (itemcode >= 100 and itemcode < 200) then 1
																										else 0
																								end
																							)
																					else 0
															  				  end,
											@plusheartgoat	= @plusheartgoat + case
																					when (@quarter in (1, 2, 3, 4) and fieldidx != @USERITEM_FIELDIDX_INVEN)
																						then (
																								case
																										when itemcode >= 200 and itemcode < 300 then 1
																										else 0
																								end
																							)
																					else 0
															  				  end
									from dbo.tFVUserItem
									where gameid = @gameid_ and listidx = @listidx2 and invenkind = @USERITEM_INVENKIND_ANI and fieldidx != @USERITEM_FIELDIDX_HOSPITAL
								end
							Fetch next from curAniItem into @listidx2, @data2
						end

					-- 4. 커서닫기
					close curAniItem
					Deallocate curAniItem

					-----------------------------------
					-- 수집된 하트를 추가하기.
					-----------------------------------
					set @plusheart	= @plusheartcow + @plusheartsheep + @plusheartgoat
					if(@heart >= @heartmax)
						begin
							-- 원래부터 맥스량 초과 분을 가지고 있으면 유지한다.
							set @heart = @heart
						end
					else if(@heart + @plusheart >= @heartmax)
						begin
							-- 합쳐서 맥스량 초과분을 가지고 있으면 맥스까지만 유효한다.
							set @heart = @heartmax
						end
					else
						begin
							set @heart = @heart + @plusheart
						end
				end


			----------------------------------------------
			-- 소모템 사용정보. > [1:2]
			----------------------------------------------
			if(LEN(@cusitem_) >= 3)
				begin
					-- 1. 커서 생성
					declare curCusItem Cursor for
					-- fieldidx	-> @listidx2
					-- listidx	-> @usecnt2
					select * FROM dbo.fnu_SplitTwo(';', ':', @cusitem_)

					-- 2. 커서오픈
					open curCusItem

					-- 3. 커서 사용
					Fetch next from curCusItem into @listidx2, @usecnt2
					while @@Fetch_status = 0
						Begin
							--select 'DEBUG 소모템', @listidx2 listidx2, @usecnt2 usecnt2

							----------------------------------------------
							-- 음수대역은 양수로 바꾼다.(조작자방지)
							----------------------------------------------
							set @usecnt2 		= case when @usecnt2 < 0 then (-@usecnt2) else @usecnt2 end

							if(@usecnt2 > 0)
								begin
									----------------------------------------------
									-- 음수로 내려가는 것은 그대로 두자 (차후에 분석용으로 허용해둔다.)
									-- update >     find > @updatecnt	= @updatecnt + 1
									-- update > not find >
									-- 이방법을 응용한다.
									----------------------------------------------
									set @cusowncnt		= 0
									set @cusitemcode	= -1
									select
											@cusitemcode 	= itemcode,
											@cusowncnt		= cnt
									from dbo.tFVUserItem where gameid = @gameid_ and listidx = @listidx2 and invenkind = @USERITEM_INVENKIND_CONSUME
									--select 'DEBUG 아이템 소모 검사.', @gameid_ gameid_, @listidx2 listidx2, @cusitemcode cusitemcode, @cusowncnt cusowncnt, @usecnt2 usecnt2

									if(@cusitemcode = -1)
										begin
											--select 'DEBUG 없어 > 패스'
											set @cusitemcode	= -1
										end
									else if(@cusitemcode in (@ITEM_REVIVAL_MOTHER, @ITEM_COMPOSE_TIME_MOTHER, @ITEM_HELPER_MOTHER, @ITEM_ROULETTE_NOR_MOTHER, @ITEM_ROULETTE_PRE_MOTHER))
										begin
											--select 'DEBUG 부활, 긴급, 일반, 프리미엄교배, 합성시간 > 그때 차감 >(패스)'
											set @cusitemcode	= -1
										end
									else
										begin
											--select 'DEBUG 일반 소모템 > 총알, 치료제, 알바, 촉진제(수량감소)'
											update dbo.tFVUserItem
												set
													cnt 			= case
																			when ((cnt - @usecnt2) < 0) then 0
																			else (cnt - @usecnt2)
																	  end
											from dbo.tFVUserItem
											where gameid = @gameid_ and listidx = @listidx2 and invenkind = @USERITEM_INVENKIND_CONSUME

											--------------------------------------------------
											-- 템을 보유하고 있지 않는데 사용을 했다면 필터 대상임.
											--------------------------------------------------
											--select 'DEBUG ', @listidx2 listidx2, @usecnt2 usecnt2, @cusowncnt cusowncnt, (@cusowncnt - @usecnt2) gapcha, @cusitemcode cusitemcode
											if((@cusowncnt - @usecnt2) < 0)
												begin
													-- 허용량 이상 검사.
													--select 'DEBUG 소모템을 허용량 이상 사용함'
													select @cusitemname = itemname from dbo.tFVItemInfo where itemcode = @cusitemcode
													set @comment2 = '(거래미필터중)' + @cusitemname + '(' +ltrim(rtrim(str(@cusitemcode)))+') 보유:'+ltrim(rtrim(str(@cusowncnt)))+' 사용:'+ltrim(rtrim(str(@usecnt2)))
													exec spu_FVSubUnusualRecord2 @gameid_, 0, @comment2
												end
										end
								end

							Fetch next from curCusItem into @listidx2, @usecnt2
						end

					-- 4. 커서닫기
					close curCusItem
					Deallocate curCusItem
				end

			-------------------------------------------------------------------
			-- 신규 생성 후 특정 레벨 달성 시에 아이템을 지급해드립니다.
			-- 고레벨 유저를 위한 짜요 레벨 달성 이벤트!
			-- 기간 : 기간: 09/29(월) ~ 영구
			-------------------------------------------------------------------
			--select 'DEBUG ', @famelvchange famelvchange, @famelv famelv
			if(@famelvchange = 1 and @famelv in (3, 6, 9, 12, 50, 55, 60, 65, 70))
				begin
					if(@famelv = 3)
						begin
							exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @EVENT01_ITEM1, 'LvUpEvent', @gameid_, '레벨업이벤트'
						end
					else if(@famelv = 6)
						begin
							exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @EVENT01_ITEM2, 'LvUpEvent', @gameid_, '레벨업이벤트'
						end
					else if(@famelv = 9)
						begin
							exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @EVENT01_ITEM3, 'LvUpEvent', @gameid_, '레벨업이벤트'
						end
					else if(@famelv = 12)
						begin
							exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @EVENT01_ITEM4, 'LvUpEvent', @gameid_, '레벨업이벤트'
						end

					----------------------------------------
					-- 레벨업 이벤트
					-- 2014-10-07 10:00 ~ 영구.
                    ----------------------------------------
					if(@curdate >= '2014-10-07 10:00')
						begin
							if(@famelv in (50))
								begin
									-- 50레벨 - 수정5
									exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  5027, 'LvUpEvent', @gameid_, '레벨업이벤트50'
								end
							else if(@famelv in (55))
								begin
									-- 55레벨 - 수정5
									exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  5027, 'LvUpEvent', @gameid_, '레벨업이벤트55'
								end
							else if(@famelv in (60))
								begin
									-- 60레벨 - 수정10
									exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  5009, 'LvUpEvent', @gameid_, '레벨업이벤트60'
								end
							else if(@famelv in (65))
								begin
									-- 65레벨 - 프교2개(40)/알바귀재 20개(35)/특수 촉진제 50개(20)
									-- 2301	프리미엄 교배 티켓 (2개)
									-- 1007	알바의 귀재 패키지 (20개)
									-- 1109	특수 촉진제 패키지 (50개)
									exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  2301, 'LvUpEvent', @gameid_, '레벨업이벤트65'
									exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  1007, 'LvUpEvent', @gameid_, '레벨업이벤트65'
									exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  1109, 'LvUpEvent', @gameid_, '레벨업이벤트65'
								end
							else if(@famelv in (70))
								begin
									-- 70레벨 - 프교5개/알바귀재 40개(70)/특수 촉진제 50개(20)/초대형치료제 25(20)
									-- 2302	프리미엄 교배 티켓 (5개)
									-- 1009	알바의 귀재 패키지 (40개)
									-- 1109	특수 촉진제 패키지 (50개)
									-- 807	초대형 치료제 패키지 (25개)
									exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  2302, 'LvUpEvent', @gameid_, '레벨업이벤트70'
									exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  1009, 'LvUpEvent', @gameid_, '레벨업이벤트70'
									exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  1109, 'LvUpEvent', @gameid_, '레벨업이벤트70'
									exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  807,  'LvUpEvent', @gameid_, '레벨업이벤트70'
								end
						end
				end


			----------------------------------------------
			-- 선물정보.
			----------------------------------------------
			if(@saleitemcode2 != -1)
				begin
					--select 'DEBUG 동물, 소모, 악세 > 선물함'
					exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT, @saleitemcode2, 'SysTrade', @gameid_, ''				-- 특정아이템 지급
				end

			----------------------------------------------
			-- 교배광고 맥스번호.
			----------------------------------------------
			select top 1 @adidxmax = idx from dbo.tFVUserAdLog
			order by idx desc

			----------------------------------------------
			-- 거래시 결과누적.
			----------------------------------------------
			-- 하단에서 처리하기.

			----------------------------------------------
			-- 학교대항전 결과 기록.
			----------------------------------------------
			--select 'DEBUG 학교 대항전 검사', @schoolidx schoolidx, @earncoin earncoin
			if(@schoolidx != -1 and @earncoin > 0 and @earncoin < 999999)
				begin
					--select 'DEBUG > 기록하기(학교 총점기록 + 개인점 기록)', @earncoin earncoin

					-- 학교 총점기록
					update dbo.tFVSchoolMaster
						set
							totalpoint = totalpoint + @earncoin
					where schoolidx = @schoolidx

					-- 개인점 기록
					update dbo.tFVSchoolUser
						set
							point 		= point + @earncoin,
							joindate 	= getdate()
					where gameid = @gameid_
				end
			--else
			--	begin
			--		select 'DEBUG 학교미가입'
			--	end

			--------------------------------------------------------------
			-- 에피소드
			-- 2013 	| 2014 	2015 	2016 	2017
			--									11 -> 12월(결산)
			-- 			| 2018	2019	2020	2021
			--									11 -> 12월(결산)
			--			| 2022	2023	2024	2025
			--									11 -> 12월(결산)
			--			| 2026	2027	2028	2029
			--			| ....
			--------------------------------------------------------------
			set @temp 			= @gameyear - (@GAME_START_YEAR - 4)
			set @etremainyear	= -1
			set @etrecord		= -1
			select top 1 @etrecord 		= etyear from dbo.tFVEpiReward where gameid = @gameid_ and etyear = @gameyear
			select top 1 @etremainyear 	= param1 from dbo.tFVItemInfo where subcategory = @ITEM_SUBCATEGORY_EPISODE and param1 = @gameyear
			--select 'DEBUG 에피소드 정보', @gameid_ gameid_, @gameyear gameyear, @gamemonth gamemonth, @temp temp, @etsalecoin etsalecoin, @etsatisfycnt etsatisfycnt, @EPISODE_LOOP_YEAR EPISODE_LOOP_YEAR, @EPISODE_LOOP_MONTH EPISODE_LOOP_MONTH

			--select 'DEBUG (전)', @etremain etremain, @gameyear gameyear, @GAME_START_YEAR GAME_START_YEAR, @etremainyear etremainyear, @etrecord etrecord, @etremainyear etremainyear, @gamemonth2 gamemonth2
			set @etremain	= -1
			set @etestimate = -1
			-- 시작연도[X]                   and 레코드없음     and 에피소드존재        and 에피소드년도
			if(@etgameyear != @GAME_START_YEAR and @etrecord = -1 and @etremainyear != -1 and @etremainyear = @gameyear)
				begin
					set @etremain	=  @EPISODE_LOOP_MONTH - @gamemonth2 - 1
					set @etestimate = 1
					--select 'DEBUG >>>>>>>> 남은달표시', @etremain etremain
				end
			--select 'DEBUG >>>>>>>> 남은달표시', @gameyear gameyear, @gamemonth gamemonth, @etremain etremain
			--select 'DEBUG (후)', @etremain etremain, @gameyear gameyear, @GAME_START_YEAR GAME_START_YEAR, @etremainyear etremainyear, @etrecord etrecord, @etremainyear etremainyear, @gamemonth2 gamemonth2

			if(@etestimate = 1 and @etgamemonth = @EPISODE_LOOP_MONTH - 1 and @gamemonth2 = @EPISODE_LOOP_MONTH)
				begin
					-----------------------------------------
					-- 아이템 테이블 > 분류 > 보상템 선물발송
					-----------------------------------------
					select
							@etitemcode		= itemcode,
							@etcheckvalue1	= param2,		@etcheckvalue2	= param3,	@etcheckvalue3	= param4,
							@etrewardbad1	= param5,
							@etrewardnor1	= param6,		@etrewardnor2	= param7,
							@etrewardgood1	= param8,		@etrewardgood2	= param9,	@etrewardgood3	= param10,
							@etrewardex1	= param11,		@etrewardex2	= param12,	@etrewardex3	= param13,		@etrewardex4	= param14
					from dbo.tFVItemInfo
					where subcategory = @ITEM_SUBCATEGORY_EPISODE and param1 = @gameyear
					--select 'DEBUG >>>>>>>> 에피소드 결과지급 ', @gameyear gameyear, @gamemonth gamemonth, @etitemcode etitemcode, @etcheckvalue1 etcheckvalue1, @etcheckvalue2 etcheckvalue2, @etcheckvalue3 etcheckvalue3, @etrewardbad1 etrewardbad1, @etrewardnor1 etrewardnor1, @etrewardnor2 etrewardnor2, @etrewardgood1 etrewardgood1, @etrewardgood2 etrewardgood2, @etrewardgood3 etrewardgood3,@etrewardex1 etrewardex1, @etrewardex2 etrewardex2,	@etrewardex3 etrewardex3, @etrewardex4 etrewardex4

					----------------------------------------
					-- 1단계 만족도(코인획득).
					----------------------------------------
					if(@etcheckvalue1 = -1)
						begin
							--select 'DEBUG 1단계 만족도(코인획득) 공백(O)', @etcheckvalue1 etcheckvalue1
							set @etsatisfycnt	= @etsatisfycnt + 1
							set @etcheckresult1	= 1
						end
					else if(@etsalecoin >= @etcheckvalue1)
						begin
							--select 'DEBUG 1단계 만족도(코인획득) 만족(O)', @etsalecoin etsalecoin, @etcheckvalue1 etcheckvalue1
							set @etsatisfycnt	= @etsatisfycnt + 1
							set @etcheckresult1	= 1
						end
					else
						begin
							--select 'DEBUG 1단계 만족도(코인획득) 불만족(X)', @etsalecoin etsalecoin, @etcheckvalue1 etcheckvalue1
							set @etsatisfycnt	= @etsatisfycnt
						end
					--select 'DEBUG 1단계 만족도(코인획득)', @etsatisfycnt etsatisfycnt

					----------------------------------------
					-- 2단계 만족도(도감획득).
					----------------------------------------
					if(@etcheckvalue2 = -1)
						begin
							--select 'DEBUG 2단계 만족도(도감획득) 공백(O)', @etcheckvalue2 etcheckvalue2
							set @etsatisfycnt	= @etsatisfycnt + 1
							set @etcheckresult2	= 1
						end
					else if(exists(select top 1 gameid from dbo.tFVDogamList where gameid = @gameid_ and itemcode = @etcheckvalue2))
						begin
							--select 'DEBUG 2단계 만족도(도감획득) 존재(O)', @etcheckvalue2 etcheckvalue2
							set @etsatisfycnt	= @etsatisfycnt + 1
							set @etcheckresult2	= 1
						end
					else
						begin
							--select 'DEBUG 2단계 만족도(도감획득) 불만족(X)'
							set @etsatisfycnt	= @etsatisfycnt
						end
					--select 'DEBUG 2단계 만족도(도감획득)', @etsatisfycnt etsatisfycnt

					----------------------------------------
					-- 3단계 만족도(전국목장).
					----------------------------------------
					if(@etcheckvalue3 = -1)
						begin
							--select 'DEBUG 3단계 만족도(전국목장) 공백(O)'
							set @etsatisfycnt	= @etsatisfycnt + 1
							set @etcheckresult3	= 1
						end
					else if(exists(select top 1 gameid from dbo.tFVUserFarm where gameid = @gameid_ and itemcode = @etcheckvalue3 and buystate = @USERFARM_BUYSTATE_BUY))
						begin
							--select 'DEBUG 3단계 만족도(전국목장) 만족(O)'
							set @etsatisfycnt	= @etsatisfycnt + 1
							set @etcheckresult3	= 1
						end
					else
						begin
							--select 'DEBUG 3단계 만족도(전국목장) 불만족(X)'
							set @etsatisfycnt	= @etsatisfycnt
						end
					--select 'DEBUG 3단계 만족도(전국목장)', @etsatisfycnt etsatisfycnt

					----------------------------------------
					-- 에피소드 보상.
					----------------------------------------
					if(@etsatisfycnt = 3)
						begin
							set @etgrade 		= @EPISODE_GRADE_EXCELLENT
							set @etreward1		= @etrewardex1
							set @etreward2		= @etrewardex2
							set @etreward3		= @etrewardex3
							set @etreward4		= @etrewardex4

							--select 'DEBUG EXCELLENT', @etgrade etgrade, @etreward1 etreward1, @etreward2 etreward2, @etreward3 etreward3, @etreward4 etreward4
						end
					else if(@etsatisfycnt = 2)
						begin
							set @etgrade		= @EPISODE_GRADE_GOOD
							set @etreward1		= @etrewardgood1
							set @etreward2		= @etrewardgood2
							set @etreward3		= @etrewardgood3
							set @etreward4		= -1

							--select 'DEBUG GOOD', @etgrade etgrade, @etreward1 etreward1, @etreward2 etreward2, @etreward3 etreward3, @etreward4 etreward4
						end
					else if(@etsatisfycnt = 1)
						begin
							set @etgrade 		= @EPISODE_GRADE_NORMAL
							set @etreward1		= @etrewardnor1
							set @etreward2		= @etrewardnor2
							set @etreward3		= -1
							set @etreward4		= -1

							--select 'DEBUG NORMAL', @etgrade etgrade, @etreward1 etreward1, @etreward2 etreward2, @etreward3 etreward3, @etreward4 etreward4
						end
					else
						begin
							set @etgrade 		= @EPISODE_GRADE_BAD
							set @etreward1		= @etrewardbad1
							set @etreward2		= -1
							set @etreward3		= -1
							set @etreward4		= -1

							--select 'DEBUG BAD', @etgrade etgrade, @etreward1 etreward1, @etreward2 etreward2, @etreward3 etreward3, @etreward4 etreward4
						end

					-- 기록하기.
					--select 'DEBUG 기록하기.'
					insert into dbo.tFVEpiReward(gameid,      	itemcode,   	etyear,  		etsalecoin, 	etgrade,	etreward1,	etreward2,	etreward3,	etreward4,
											   etcheckvalue1,  	etcheckvalue2,  etcheckvalue3,
											   etcheckresult1, 	etcheckresult2,	etcheckresult3)
					values(                    @gameid_,		@etitemcode,	@gameyear,		@etsalecoin,	@etgrade,	@etreward1,	@etreward2,	@etreward3,	@etreward4,
											   @etcheckvalue1, 	@etcheckvalue2, @etcheckvalue3,
											   @etcheckresult1, @etcheckresult2,@etcheckresult3
											   )

					------------------------------------
					-- 선물하기.
					------------------------------------
					if(@etreward1 != -1)
						begin
							--select 'DEBUG 1번 일반템지급', @etreward1 etreward1
							exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT, @etreward1, 'SysEpi', @gameid_, ''
						end
					if(@etreward2 != -1)
						begin
							--select 'DEBUG 2번 일반템지급', @etreward2 etreward2
							exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT, @etreward2, 'SysEpi', @gameid_, ''
						end
					if(@etreward3 != -1)
						begin
							--select 'DEBUG 3번 일반템지급', @etreward3 etreward3
							exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT, @etreward3, 'SysEpi', @gameid_, ''
						end
					if(@etreward4 != -1)
						begin
							--select 'DEBUG 4번 일반템지급', @etreward4 etreward4
							exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT, @etreward4, 'SysEpi', @gameid_, ''
						end

					------------------------------------
					-- 유저 정보 클리어하기.
					------------------------------------
					set @etsalecoin 	= 0
					--select 'DEBUG 클리어', @gameyear gameyear, @gamemonth gamemonth

					-- 선물 받았다고 표시.
					if(@etreward1 != -1 or @etreward2 != -1 or @etreward3 != -1 or @etreward4 != -1)
						begin
							set @etreward = 1
						end
				end


			----------------------------------------------
			-- 복귀유저
			----------------------------------------------
			if(@rtnflag = @RETURN_FLAG_ON)
				begin
					--select 'DEBUG 서버복귀 플래그 진행중', @rtnstep rtnstep, @rtnplaycnt rtnplaycnt
					if(@rtnstep >= 1)
						begin
							--select 'DEBUG  > 해당 유저 복귀진행중'
							set @rtnplaycnt = @rtnplaycnt + 1
							if(@rtnplaycnt = 5)
								begin
									--select 'DEBUG   > 해당 유저 5개월 > 템지급'
									set @comment2 = '복귀보상(' +ltrim(rtrim(str(@rtnstep)))+'일)'
									if(@rtnstep in (7, 14))
										begin
											--select 'DEBUG    > 특수'
											exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,   @RETURN_REWARD_STEP_SPECIAL, @comment2, @gameid_, ''
											set @rtnreward = @RETURN_REWARD_STEP_SPECIAL
										end
									else
										begin
											--select 'DEBUG    > 일반'
											exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,   @RETURN_REWARD_STEP_NORMAL, @comment2, @gameid_, ''
											set @rtnreward = @RETURN_REWARD_STEP_NORMAL
										end
								end

							-- 복귀 마무리.
							if(@rtnstep >= 14 and @rtnplaycnt >= 5)
								begin
									--select 'DEBUG 복귀마무리'
									set @rtnstep 		= -1
									set @rtnplaycnt 	= 0
								end
						end
					--select 'DEBUG 결과', @rtnstep rtnstep, @rtnplaycnt rtnplaycnt

				end
		END



	--select @nResult_ rtn, @comment comment, @gamecost gamecost, @cashcost cashcost, @heart heart, @feed feed, @qtsalebarrel qtsalebarrel, @qtsalecoin qtsalecoin, @qtfame qtfame, @qtfeeduse qtfeeduse, @qttradecnt qttradecnt, @qtsalecoinbest qtsalecoinbest
	if(@nResult_ = @RESULT_SUCCESS)
		BEGIN
			--select 'DEBUG 유저 정보저장', @gameyear gameyear, @gamemonth gamemonth
			------------------------------------------------
			-- 유저정보
			------------------------------------------------
			update dbo.tFVUserMaster
				set
					--gameid 		= @gameid,
					gamecost		= @gamecost,
					feed			= @feed,
					heart			= @heart,
					bgtradecnt		= bgtradecnt + case when (@tradecnt2 != 0)  then 1 	else 0 end,

					gameyear		= @gameyear,
					gamemonth		= @gamemonth,
					frametime		= @frametime,
					fevergauge		= @fevergauge,
					bottlelittle	= @bottlelittle,
					bottlefresh		= @bottlefresh,
					tanklittle		= @tanklittle,
					tankfresh		= @tankfresh,
					adidx			= case when @adidxmax > @adidx then @adidxmax else @adidx end,
					rtnstep			= @rtnstep,
					rtnplaycnt		= @rtnplaycnt,


					field0			= @field0,		field1	= @field1,		field2			= @field2,
					field3			= @field3,		field4	= @field4,		field5			= @field5,
					field6			= @field6,		field7	= @field7,		field8			= @field8,

					--housestep 	= @housestep,
					--bottlestep	= @bottlestep,
					--tankstep		= @tankstep,,

					boosteruse 		= -1,
					albause 		= -1,
					wolfappear 		= -1,

					tradecntold		= @tradecntold,
					prizecntold		= @prizecntold,

					fame			= @fame,
					famelv			= @famelv,
					famelvbest		= @famelvbest,
					tradecnt		= @tradecnt,
					prizecnt		= @prizecnt,
					tradefailcnt	= @tradefailcnt,

					-- 분기정보.
					qtsalebarrel	= @qtsalebarrel,
					qtsalecoin		= @qtsalecoin,
					qtfame			= @qtfame,
					qtfeeduse		= @qtfeeduse,
					qttradecnt		= @qttradecnt,
					qtsalecoinbest	= @qtsalecoinbest,

					-- 랭킹용 데이타.
					ttsalecoin		= @ttsalecoin,

					-- 에피소드 수익.
					etsalecoin		= @etsalecoin,
					etremain		= @etremain,

					-- 파라미터
					param0			= case when (@param20 != @INIT_VALUE) 			then @param20		else param0			end,
					param1			= case when (@param21 != @INIT_VALUE) 			then @param21		else param1			end,
					param2			= case when (@param22 != @INIT_VALUE) 			then @param22		else param2			end,
					param3			= case when (@param23 != @INIT_VALUE) 			then @param23		else param3			end,
					param4			= case when (@param24 != @INIT_VALUE) 			then @param24		else param4			end,
					param5			= case when (@param25 != @INIT_VALUE) 			then @param25		else param5			end,
					param6			= case when (@param26 != @INIT_VALUE) 			then @param26		else param6			end,
					param7			= case when (@param27 != @INIT_VALUE) 			then @param27		else param7			end,
					param8			= case when (@param28 != @INIT_VALUE) 			then @param28		else param8			end,
					param9			= case when (@param29 != @INIT_VALUE) 			then @param29		else param9			end,

					-- 게임정보.
					bktwolfkillcnt	= @bktwolfkillcnt,
					bktsalecoin		= @bktsalecoin,
					bkbarrel		= @bkbarrel,
					bktsuccesscnt	= case when (@tradecnt2 	!= 0) 				then bktsuccesscnt + 1 	else 0 end,
					bktbestfresh	= case when (@salefresh2 	> bktbestfresh) 	then @salefresh2 		else bktbestfresh end,
					bktbestbarrel	= case when (@salebarrel2 	> bktbestbarrel) 	then @salebarrel2		else bktbestbarrel end,
					bktbestcoin		= case when (@salecoin2 	> bktbestcoin) 		then @salecoin2			else bktbestcoin end
			where gameid = @gameid_

			------------------------------------------------
			-- 정보출력.
			------------------------------------------------
			select
				@nResult_ rtn, @comment comment,
				@plusheartcow plusheartcow, @plusheartsheep plusheartsheep, @plusheartgoat plusheartgoat,
				@etgrade etgrade,
				@etsalecoin etsalecoin,
				((famelv / 10 + 1)*(famelv / 10 + 1) * @YABAU_CHANGE_DANGA) yabauchange,
				case when famelv <= 50 then @USED_FRIEND_POINT else (@USED_FRIEND_POINT + (famelv - 50)*20) end needfpoint,
				@rtnreward rtnreward,
				*
			from dbo.tFVUserMaster where gameid = @gameid_

			------------------------------------------------
			-- 랭킹정보(결산할때).
			------------------------------------------------
			--if(@quarter in (1, 2, 3, 4))
			--	begin
					exec spu_FVsubFriendRank @gameid_, 1
			--	end
			--else
			--	begin
			--		exec spu_FVsubFriendRank @gameid_, 0
			--	end


			------------------------------------------------
			-- 거래정보저장.
			------------------------------------------------
			if(@blogsave = 1)
				begin
					if(not exists(select top 1 * from dbo.tFVUserSaleLog where gameid = @gameid_ and gameyear = @gameyear and gamemonth = @gamemonth))
						begin
							set @idx2 = (@gameyear - 2013)*12 + @gamemonth
							insert into dbo.tFVUserSaleLog(
														idx2,
														gameid, 		gameyear,   	gamemonth,
														feeduse, 		playcoin,		playcoinmax,		fame,    		famelv,   		tradecnt,  		prizecnt,		prizecoin,
														saletrader, 	saledanga,		saleplusdanga,		salebarrel,		salefresh,		salecoin,		saleitemcode,	plusheart,
														orderbarrel, 	orderfresh,		milkproduct,
														userinfo, 		aniitem, 		cusitem, 			tradeinfo,
														gamecost, 		cashcost,		heart,				feed, 			fpoint
														)
							values(						@idx2,
														@gameid_, 		@gameyear2, 	@gamemonth2,
														@feeduse2, 		@playcoin2,		@playcoinmax,		@fame2, 		@famelv2, 		@tradecnt2, 	@prizecnt2,		@prizecoin2,
														@saletrader2, 	@saledanga2, 	@saleplusdanga2, 	@salebarrel2, 	@salefresh2, 	@salecoin2, 	@saleitemcode2, @plusheart,
														@orderbarrel2, 	@orderfresh2,	@milkproduct2,
														@userinfo_, 	@aniitem_, 		@cusitem_, 			@tradeinfo_,
														@gamecost, 		@cashcost,		@heart,				@feed, 			@fpoint
														)

							delete from dbo.tFVUserSaleLog where gameid = @gameid_ and idx2 < @idx2 - @USER_LOG_MAX
						end
				end

			--------------------------------------------------------------
			-- 선물함정보.
			-- 없으면 > 빈리스트를 전송해주기
			--------------------------------------------------------------
			if(@saleitemcode2 != -1 or @etreward != -1 or @rtnreward != -1)
				begin
					exec spu_FVGiftList @gameid_
				end
			else
				begin
					exec spu_FVGiftList ''
				end

			--------------------------------------------------------------
			-- 광고정보.
			--------------------------------------------------------------
			select top 1 * from dbo.tFVUserAdLog
			where idx > @adidx
			order by idx desc

			--------------------------------------------------------------
			-- 학교대항정보.
			-- 학교대항정보 > 소속인원.
			-- @schoolidx != -1 and
			--------------------------------------------------------------
			if(@quarter in (1, 2, 3, 4))
				begin
					exec spu_FVSchoolRank  4, -1, @gameid_		-- 학교랭킹.
					exec spu_FVSchoolRank  7, @schoolidx, ''		-- 학교내 개인랭킹.
				end
			else
				begin
					exec spu_FVSchoolRank  6, -1, @gameid_		-- 더미 학교랭킹.
					exec spu_FVSchoolRank  7, -1, ''				-- 더미 학교내 개인랭킹.
				end

			---------------------------------------------
			-- 교배뽑기.
			---------------------------------------------
			select top 1 * from dbo.tFVSystemRoulette
			where famelvmin <= @famelv
					and @famelv <= famelvmax
					and packstate = 1
					--and (ABS(CAST( (BINARY_CHECKSUM(*) * RAND()) as int)) % 100) <= 100
					order by newid()

			-------------------------------------------
			--	에피소드 보상정보.
			--  에피소드 > 목장리스트
			-------------------------------------------
			if(@etgrade != @EPISODE_GRADE_NON)
				begin
					--select 'DEBUG 에피소드 보상정보 전송'
					--	에피소드 보상정보.
					select @etsalecoin2 etsalecoin, 		@etgrade etgrade,
						   @etitemcode etitemcode,
						   @etcheckresult1 etcheckresult1, 	@etcheckresult2 etcheckresult2, 	@etcheckresult3 etcheckresult3,
						   @etreward1 etreward1, 			@etreward2 etreward2, 				@etreward3 etreward3, 				@etreward4 etreward4

				end

		END
	else
		BEGIN
			select @nResult_ rtn, @comment comment, @plusheartcow plusheartcow, @plusheartsheep plusheartsheep, @plusheartgoat plusheartgoat, @gamecost gamecost, @cashcost cashcost, @heart heart, @feed feed, @fpoint fpoint, @comreward comreward, @bkbarrel bkbarrel, @qtsalebarrel qtsalebarrel, @qtsalecoin qtsalecoin, @qtfame qtfame, @qtfeeduse qtfeeduse, @qttradecnt qttradecnt, @qtsalecoinbest qtsalecoinbest, 0 bktwolfkillcnt, 0 bktsalecoin, 0 bkheart, 0 bkfeed, 0 bktsuccesscnt, 0 bktbestfresh, 0 bktbestbarrel, 0 bktbestcoin, 0 bkcrossnormal, 0 bkcrosspremium, 0 param0, 0 param1, 0 param2, 0 param3, 0 param4, 0 param5, 0 param6, 0 param7, 0 param8, 0 param9, @field0 field0, @field1 field1, @field2 field2, @field3 field3, @field4 field4, @field5 field5, @field6 field6, @field7 field7, @field8 field8, 0 etgrade, 0 etsalecoin, 0 etremain, 0 tradefailcnt, 0 tradecnt, 0 prizecnt, 0 yabauchange, 1 yabauidx, 0 yabaustep, 0 needfpoint, 0 rtnplaycnt, -1 rtnstep, -1 rtnreward
		END


	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
End



