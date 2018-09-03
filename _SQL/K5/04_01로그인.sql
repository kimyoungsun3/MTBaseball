/*
select * from dbo.tUserMaster where gameid = 'xxxx'
exec spu_Login 'xxxx', '049000s1i0n7t8445289', 1, 101, '', -1, -1			-- 정상유저
exec spu_Login 'xxxx', '049000s1i0n7t8445288', 1, 101, '', -1, -1			-- 비번틀림
exec spu_Login 'xxxx0', '049000s1i0n7t8445289', 1, 101, '', -1, -1			-- 없는유저
exec spu_Login 'xxxx', '049000s1i0n7t8445289', 1, 100, '',  -1, -1			-- 마켓버젼낮음
exec spu_Login 'xxxx3', '049000s1i0n7t8445289', 1, 101, '', -1, -1			-- 블럭유저
exec spu_Login 'xxxx4', '049000s1i0n7t8445289', 1, 101, '', -1, -1			-- 삭제유저
update dbo.tUserMaster set cashcopy = 3 where gameid = 'xxxx5'		-- 캐쉬카피 > 블럭처리
exec spu_Login 'xxxx5', '049000s1i0n7t8445289', 1, 101, '', -1,  -1
update dbo.tUserMaster set resultcopy = 100 where gameid = 'xxxx6'	-- 결과키피 > 블럭처리
exec spu_Login 'xxxx7', '049000s1i0n7t8445289', 1, 101, '', -1, -1

exec spu_Login 'xxxx', '049000s1i0n7t8445289', 1, 199, '', -1, -1			-- 정상유저
exec spu_Login 'xxxx2', '049000s1i0n7t8445289', 5, 119, '', -1, -1			-- 정상유저
exec spu_Login 'xxxx3', '049000s1i0n7t8445289', 1, 199, '', -1, -1			-- 정상유저
exec spu_Login 'xxxx6', '049000s1i0n7t8445289', 1, 199, '', -1, -1			-- 정상유저

update dbo.tUserMaster set attenddate = getdate() - 20 where gameid = 'xxxx2'
delete from dbo.tGiftList where gameid = 'xxxx2'
exec spu_Login 'xxxx2', '049000s1i0n7t8445289', 1, 110, '', -1, -1			-- 정상유저

update dbo.tUserMaster set attenddate = getdate() - 1 where gameid = 'xxxx2'
exec spu_Login 'xxxx2', '049000s1i0n7t8445289', 1, 103, '', -1, -1			-- 정상유저

--보물보유테스트
update dbo.tUserMaster set attenddate = getdate() - 1, tsskillcashcost = 0, tsskillheart = 0, tsskillgamecost = 100, tsskillfpoint = 0, tsskillrebirth = 0, tsskillalba = 0, tsskillbullet = 0, tsskillvaccine = 0, tsskillfeed = 0, tsskillbooster = 0 where gameid = 'xxxx2'
exec spu_Login 'xxxx2', '049000s1i0n7t8445289', 5, 119, '', -1, -1			-- 정상유저

*/
use GameMTBaseball
Go

IF OBJECT_ID ( 'dbo.spu_Login', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_Login;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_Login
	@gameid_								varchar(20),					-- 게임아이디
	@password_								varchar(20),					-- 암호화해서저장, 유저패스워가 해킹당해도 안전
	@market_								int,							-- (구매처코드)
	@version_								int,							-- 클라버젼
	@kakaoprofile_							varchar(512),
	@kakaomsgblocked_						int,
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
	--declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 종료.

	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------
	-- 구매처코드
	declare @MARKET_SKT							int					set @MARKET_SKT						= 1
	declare @MARKET_GOOGLE						int					set @MARKET_GOOGLE					= 5
	--declare @MARKET_NHN						int					set @MARKET_NHN						= 6
	declare @MARKET_IPHONE						int					set @MARKET_IPHONE					= 7

	-- 블럭상태값.
	--declare @BLOCK_STATE_NO					int					set	@BLOCK_STATE_NO					= 0	-- 블럭상태아님
	declare @BLOCK_STATE_YES					int					set	@BLOCK_STATE_YES				= 1	-- 블럭상태

	-- 삭제상태값.
	--declare @DELETE_STATE_NO					int					set	@DELETE_STATE_NO				= 0	-- 삭제상태아님
	declare @DELETE_STATE_YES					int					set	@DELETE_STATE_YES				= 1	-- 삭제상태

	-- 시스템 체킹
	--declare @SYSCHECK_NON						int					set @SYSCHECK_NON					= 0
	declare @SYSCHECK_YES						int					set @SYSCHECK_YES					= 1

	-- 아이템별 인벤분류
	declare @USERITEM_INVENKIND_ANI				int 				set @USERITEM_INVENKIND_ANI					= 1
	declare @USERITEM_INVENKIND_CONSUME			int 				set @USERITEM_INVENKIND_CONSUME				= 3
	declare @USERITEM_INVENKIND_ACC				int 				set @USERITEM_INVENKIND_ACC					= 4
	--declare @USERITEM_INVENKIND_DIRECT		int 				set @USERITEM_INVENKIND_DIRECT				= 40
	--declare @USERITEM_INVENKIND_INFO			int 				set @USERITEM_INVENKIND_INFO				= 60
	declare @USERITEM_INVENKIND_PET				int 				set @USERITEM_INVENKIND_PET					= 1000
	declare @USERITEM_INVENKIND_STEMCELL		int 				set @USERITEM_INVENKIND_STEMCELL			= 1040
	declare @USERITEM_INVENKIND_TREASURE		int					set @USERITEM_INVENKIND_TREASURE			= 1200


	-- 아이템 소분류
	declare @ITEM_SUBCATEGORY_UPGRADE_HOUSE		int					set @ITEM_SUBCATEGORY_UPGRADE_HOUSE 		= 60 	-- 집
	--declare @ITEM_SUBCATEGORY_USERFARM		int					set @ITEM_SUBCATEGORY_USERFARM	 			= 69	-- 전국목장
	declare @ITEM_SUBCATEGORY_ATTENDANCE		int					set @ITEM_SUBCATEGORY_ATTENDANCE 			= 900 	--출석(900)
	declare @ITEM_SUBCATEGORY_PET				int					set @ITEM_SUBCATEGORY_PET					= 1000 	--펫(1000)

	-- 선물 정의값
	declare @GIFTLIST_GIFT_KIND_MESSAGE			int					set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2
	--declare @GIFTLIST_GIFT_KIND_MESSAGE_DEL	int					set @GIFTLIST_GIFT_KIND_MESSAGE_DEL			= -1
	--declare @GIFTLIST_GIFT_KIND_GIFT_DEL		int					set @GIFTLIST_GIFT_KIND_GIFT_DEL			= -2
	--declare @GIFTLIST_GIFT_KIND_GIFT_GET		int					set @GIFTLIST_GIFT_KIND_GIFT_GET			= -3
	--declare @GIFTLIST_GIFT_KIND_GIFT_SELL		int					set @GIFTLIST_GIFT_KIND_GIFT_SELL			= -4
	--declare @GIFTLIST_GIFT_KIND_LIST			int					set @GIFTLIST_GIFT_KIND_LIST				= -5

	-- 기타 상수값
	declare @ID_MAX								int					set	@ID_MAX									= 10	-- 한폰당 생성할 수 있는 아이디개수.
	declare @USERMASTER_UPGRADE_STATE_NON		int					set @USERMASTER_UPGRADE_STATE_NON			= -1	--미진행, 완료중.(유저)
	declare @USERMASTER_UPGRADE_STATE_ING		int					set @USERMASTER_UPGRADE_STATE_ING			= 1		--다음단계진행중.
	declare @USERSEED_NEED_EMPTY				int					set @USERSEED_NEED_EMPTY					= -1	-- (경작지)
	declare @USERSEED_NEED_BUY					int					set @USERSEED_NEED_BUY						= -2
	-- >= 0 이상이면 특정 식물이 심어져있음.
	declare @GAME_START_YEAR					int					set @GAME_START_YEAR						= 2013
	declare @GAME_START_MONTH					int					set @GAME_START_MONTH						= 3
	declare @FARM_BATTLE_PLAYCNT_MAX			int					set @FARM_BATTLE_PLAYCNT_MAX				= 10	-- 배틀횟수.


	-- 보드에 글쓰기.
	--declare @BOARD_STATE_NON					int					set @BOARD_STATE_NON						= 0
	--declare @BOARD_STATE_REWARD				int					set @BOARD_STATE_REWARD						= 1
	declare @BOARD_STATE_REWARD_GAMECOST		int					set @BOARD_STATE_REWARD_GAMECOST			= 600

	-- 카카오톡 정보.
	declare @KAKAO_MESSAGE_INVITE_ID			int					set @KAKAO_MESSAGE_INVITE_ID 				= 297	--초대.
	declare @KAKAO_MESSAGE_PROUD_ID				int					set @KAKAO_MESSAGE_PROUD_ID 				= 296	--자랑하기.
	declare @KAKAO_MESSAGE_HEART_ID				int					set @KAKAO_MESSAGE_HEART_ID 				= 295	--하트선물.
	declare @KAKAO_MESSAGE_HELP_ID				int					set @KAKAO_MESSAGE_HELP_ID 					= 294	--도와줘.
	declare @KAKAO_MESSAGE_RETURN_ID			int					set @KAKAO_MESSAGE_RETURN_ID				= 293	--복귀.

	--메세지 수신여부.
	--declare @KAKAO_MESSAGE_ALLOW				int 				set @KAKAO_MESSAGE_ALLOW 				= -1
	declare @KAKAO_MESSAGE_BLOCK				int					set @KAKAO_MESSAGE_BLOCK 				= 1
	declare @KAKAO_MESSAGE_NON					int					set @KAKAO_MESSAGE_NON					= 0

	-- 장기복귀기한.
	declare @RETURN_LIMIT_DAY					int					set @RETURN_LIMIT_DAY				= 30 	-- 몇일간 기한인가?.
	declare @RETURN_FLAG_OFF					int					set @RETURN_FLAG_OFF				= 0 	-- On(1), Off(0)
	declare @RETURN_FLAG_ON						int					set @RETURN_FLAG_ON					= 1 	-- On(1), Off(0)

	-- bool
	declare @BOOL_TRUE							int					set @BOOL_TRUE						= 1
	declare @BOOL_FALSE							int					set @BOOL_FALSE						= 0

	-- 로그인 메세지.
	declare @RECOMMAND_MESSAGE_SERVERID			int					set @RECOMMAND_MESSAGE_SERVERID		= @BOOL_FALSE
	declare @RECOMMAND_MESSAGE					varchar(256)		set @RECOMMAND_MESSAGE				= '게임은 재미있게 즐기고 계신가요?\n지금 후기 작성을 해주시면 600만 코인을 드립니다.'
	declare @RECOMMAND_MESSAGE_ANDROIDPLUS		varchar(256)		set @RECOMMAND_MESSAGE_ANDROIDPLUS	= '\n매일 추첨을 통해 10수정을 드려요!\n *아이디를 후기에 적지 않으시면 참가로 인정되지 않으니 꼭 기억하세요.\n\n 후기 기재용 아이디 : [ff1100]'
	declare @RECOMMAND_MESSAGE_IPHONE			varchar(256)		set @RECOMMAND_MESSAGE_IPHONE		= '게임은 재미있게 즐기고 계신가요?\n다른 친구들이 볼 수 있도록 후기를 남겨주세요!'

	-- 기타 상수값들.
	declare @YABAU_CHANGE_DANGA					int					set @YABAU_CHANGE_DANGA				= 100		-- 행운의 주사위 상수값
	declare @USED_FRIEND_POINT					int					set @USED_FRIEND_POINT				= 100		-- 친구포인트 차감.
	declare @ANIMAL_COMPOSE_LEVEL				int					set @ANIMAL_COMPOSE_LEVEL			= 1			-- 합성의 마스터 레벨.
	declare @FARM_BATTLE_OPEN_LV				int					set @FARM_BATTLE_OPEN_LV			= 20		-- 합성의 마스터 레벨.
	declare @NEW_START_INIT_LV					int					set @NEW_START_INIT_LV				= 15		-- 새로시작하기 시간초기화모델.
	declare @ANIMAL_LIMIT_TREASURE_VAL			int					set @ANIMAL_LIMIT_TREASURE_VAL		= 250		-- 촉진제 보물효과.

	-- 이벤트 상태값
	declare @EVENT_STATE_NON					int					set @EVENT_STATE_NON				= 0
	declare @EVENT_STATE_YES					int					set @EVENT_STATE_YES				= 1

	-- 동물뽑기가격.
	declare @MODE_ROULETTE_GRADE1_GAMECOST		int					set @MODE_ROULETTE_GRADE1_GAMECOST			= 100
	declare @MODE_ROULETTE_GRADE1_HEART			int					set @MODE_ROULETTE_GRADE1_HEART				= 101
	declare @MODE_ROULETTE_GRADE2_CASHCOST		int					set @MODE_ROULETTE_GRADE2_CASHCOST			= 102
	declare @MODE_ROULETTE_GRADE4_CASHCOST		int					set @MODE_ROULETTE_GRADE4_CASHCOST			= 103

	-- 보물뽑기 가격 파라미터.
	declare @MODE_TREASURE_GRADE1_GAMECOST		int					set @MODE_TREASURE_GRADE1_GAMECOST			= 100
	declare @MODE_TREASURE_GRADE1_HEART			int					set @MODE_TREASURE_GRADE1_HEART				= 101
	declare @MODE_TREASURE_GRADE2_CASHCOST		int					set @MODE_TREASURE_GRADE2_CASHCOST			= 102
	declare @MODE_TREASURE_GRADE3_CASHCOST		int					set @MODE_TREASURE_GRADE3_CASHCOST			= 103

	--declare @ITEM_ZCP_PIECE_MOTHER			int					set @ITEM_ZCP_PIECE_MOTHER					= 3800	-- 짜요쿠폰조각.
	declare @ITEM_ZCP_TICKET_MOTHER				int					set @ITEM_ZCP_TICKET_MOTHER					= 3801	-- 짜요쿠폰.

	---------------------------------------------------------
	-- 배틀의 스킬 값들.
	-- 공격력 	: 2 + (3 ) + 2		-> 너무미비함
	-- 방어  	: 2 + (3) + 2
	-- HP	  	: 1초당 HP , 		유지시간(초)
	-- TURN	  	: 1초당 감소시간 , 	유지시간(초)
	---------------------------------------------------------
	-- 공격력.
	declare @SKILL_ATK_1						int					set @SKILL_ATK_1							= 2 	-- 1개(%)
	declare @SKILL_ATK_2						int					set @SKILL_ATK_2							= 15	-- 2개(%)
	declare @SKILL_ATK_3						int					set @SKILL_ATK_3							= 60	-- 3개(%)

	-- 방어력.
	declare @SKILL_DEF_1						int					set @SKILL_DEF_1							= 2		-- 1개(%)
	declare @SKILL_DEF_2						int					set @SKILL_DEF_2							= 14	-- 2개(%)
	declare @SKILL_DEF_3						int					set @SKILL_DEF_3							= 50	-- 3개(%)

	-- 지정된 시간동안 HP, 최소값은 (1개 1HP, 2개 2HP, 3개 3HP).
	declare @SKILL_HP_1							int					set @SKILL_HP_1								= 1		-- 1개(%)
	declare @SKILL_HP_1_TIME					int					set @SKILL_HP_1_TIME						= 3		--    (s)
	declare @SKILL_HP_2							int					set @SKILL_HP_2								= 3		-- 2개(%)
	declare @SKILL_HP_2_TIME					int					set @SKILL_HP_2_TIME						= 3		--    (s)
	declare @SKILL_HP_3							int					set @SKILL_HP_3								= 6		-- 3개(%)
	declare @SKILL_HP_3_TIME					int					set @SKILL_HP_3_TIME						= 3		--    (s)

	-- 지정된 시간동안 Turn감소.
	declare @SKILL_TURN_1						int					set @SKILL_TURN_1							= 150	-- 1개
	declare @SKILL_TURN_1_TIME					int					set @SKILL_TURN_1_TIME						= 3
	declare @SKILL_TURN_2						int					set @SKILL_TURN_2							= 600	-- 2개
	declare @SKILL_TURN_2_TIME					int					set @SKILL_TURN_2_TIME						= 3
	declare @SKILL_TURN_3						int					set @SKILL_TURN_3							= 1500	-- 3개
	declare @SKILL_TURN_3_TIME					int					set @SKILL_TURN_3_TIME						= 3

	---------------------------------------------------------
	-- 상인의 신선도 상승.
	---------------------------------------------------------
	declare @DEALER_PLUS_STEP1					int					set @DEALER_PLUS_STEP1						= 1 +0
	declare @DEALER_PLUS_STEP2					int					set @DEALER_PLUS_STEP2						= 2 +0
	declare @DEALER_PLUS_STEP3					int					set @DEALER_PLUS_STEP3						= 3 +1
	declare @DEALER_PLUS_STEP4					int					set @DEALER_PLUS_STEP4						= 4 +1
	declare @DEALER_PLUS_STEP5					int					set @DEALER_PLUS_STEP5						= 5 +2
	declare @DEALER_PLUS_STEP6					int					set @DEALER_PLUS_STEP6						= 6 +2-1
	declare @DEALER_PLUS_STEP7					int					set @DEALER_PLUS_STEP7						= 7 +2-2
	declare @DEALER_PLUS_STEP8					int					set @DEALER_PLUS_STEP8						= 8 +3-3
	declare @DEALER_PLUS_STEP9					int					set @DEALER_PLUS_STEP9						= 9 +3-3
	declare @DEALER_PLUS_STEPM					int					set @DEALER_PLUS_STEPM						= 10+3-3-4 -- 상위 애들을 위해서 하향된 상태로 이놈만 둠.

	----------------------------------------------
	-- Naver 이벤트 처리
	--	기간 : 7.24 ~ 8.6
	--	발표 : 8.11
	--	1. 가입시 ...		=> 시크한 양1마리, 루비 60개
	--						   02_01가입(정식버젼).sql
	--	2. 결제 2배			=> 결제하면 2배 이벤트
	--						   21_01캐쉬(인증서).sql
	--						   21_02캐쉬(관리페이지).sql
	--	3. Naver캐쉬		=> 네이버 캐쉬
	------------------------------------------------
	--declare @EVENT07NHN_START_DAY				datetime			set @EVENT07NHN_START_DAY			= '2014-06-13 20:00'
	--declare @EVENT07NHN_END_DAY				datetime			set @EVENT07NHN_END_DAY				= '2014-08-06 23:59'

	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @sysfriendid			varchar(20)			set @sysfriendid 	= 'farmgirl'
	declare @comment				varchar(512)		set @comment		= '로그인'
	declare @comment2				varchar(128)
	declare @gameid 				varchar(20)
	declare @password 				varchar(20)
	declare @condate				datetime
	declare @deletestate			int
	declare @blockstate				int
	declare @cashcopy				int
	declare @resultcopy				int
	declare @cashcost				int
	declare @gamecost				int
	declare @goldticket				int					set @goldticket			= 0
	declare @goldticketmax			int					set @goldticketmax		= 0
	declare @goldtickettime			datetime			set @goldtickettime		= getdate()
	declare @battleticket			int					set @battleticket		= 0
	declare @battleticketmax		int					set @battleticketmax	= 0
	declare @battletickettime		datetime			set @battletickettime	= getdate()
	declare @battleanilistidx1		int					set @battleanilistidx1	= -1
	declare @battleanilistidx2		int					set @battleanilistidx2	= -1
	declare @battleanilistidx3		int					set @battleanilistidx3	= -1
	declare @battleanilistidx4		int					set @battleanilistidx4	= -1
	declare @battleanilistidx5		int					set @battleanilistidx5	= -1
	declare @tslistidx1				int					set @tslistidx1			= -1
	declare @tslistidx2				int					set @tslistidx2			= -1
	declare @tslistidx3				int					set @tslistidx3			= -1
	declare @tslistidx4				int					set @tslistidx4			= -1
	declare @tslistidx5				int					set @tslistidx5			= -1
	declare @tsskillcashcost		int					set @tsskillcashcost 	= 0
	declare @tsskillheart			int					set @tsskillheart 		= 0
	declare @tsskillgamecost		int					set @tsskillgamecost 	= 0
	declare @tsskillfpoint			int					set @tsskillfpoint 		= 0
	declare @tsskillrebirth			int					set @tsskillrebirth 	= 0
	declare @tsskillalba			int					set @tsskillalba 		= 0
	declare @tsskillbullet			int					set @tsskillbullet 		= 0
	declare @tsskillvaccine			int					set @tsskillvaccine 	= 0
	declare @tsskillfeed			int					set @tsskillfeed 		= 0
	declare @tsskillbooster			int					set @tsskillbooster 	= 0

	declare @market					int					set @market			= @MARKET_GOOGLE
	declare @version				int					set @version		= 101
	declare @gameyear				int					set @gameyear		= @GAME_START_YEAR
	declare @gamemonth				int					set @gamemonth		= @GAME_START_MONTH

	-- 시스템 업글정보, MAX
	declare @fame 					int					set @fame			= 1
	declare @famelv 				int					set @famelv			= 1
	declare @famelvbest				int					set @famelvbest		= 1
	declare @feedmax				int					set @feedmax		= 10
	declare @heartmax				int					set @heartmax		= 20
	declare @fpointmax				int					set @fpointmax		= 500
	declare @curdate				datetime			set @curdate		= getdate()
	declare @housestep				int,	@housestate				int,	@housetime				datetime,		@housestepmax		int,
			@tankstep				int,	@tankstate				int,	@tanktime				datetime,		@tankstepmax		int,
			@bottlestep				int,	@bottlestate			int,	@bottletime				datetime,		@bottlestepmax		int,
			@pumpstep				int,	@pumpstate				int,	@pumptime				datetime,		@pumpstepmax		int,
			@transferstep			int,	@transferstate			int,	@transfertime			datetime,		@transferstepmax	int,
			@purestep				int,	@purestate				int,	@puretime				datetime,		@purestepmax		int,
			@freshcoolstep			int,	@freshcoolstate			int,	@freshcooltime			datetime,		@freshcoolstepmax	int,
			@invenstepmax			int,	@invencountmax			int,	@seedfieldmax			int

	-- 소비아이템
	declare @bulletlistidx			int,
			@vaccinelistidx			int,
			@albalistidx			int,
			@boosterlistidx			int,
			@tmpcnt					int,
			@tmpitemcode			int,
			@invenkind 				int

	declare @newday					int
	declare @pettodayitemcode		int						set @pettodayitemcode	= -1		-- 오늘만 추천 펫
	declare @pettodayitemcode2		int						set @pettodayitemcode2	= -1		--        체험 펫

	-- 출석일
	declare @attenddate				datetime,
			@attendcnt				int,
			@attendnewday			int
	declare @attenditemcode			int						set @attenditemcode		= -1
	declare @attenditemcodecnt		int						set @attenditemcodecnt	=  0
	declare @attendcomment			varchar(20)

	declare @curversion				int						set @curversion		= -1
	declare @cursyscheck			int

	declare @heartsenddate			datetime				set @heartsenddate 	= getdate()		-- 하트 일일 전송량.
	declare @heartsendcnt			int						set @heartsendcnt	= 9999
	declare @zcpappearcnt			int						set @zcpappearcnt	= 9999
	declare @anibuydate				datetime				set @anibuydate 	= getdate()		-- 동물 일일전송량.
	declare @anibuycnt				int						set @anibuycnt		= 9999
	declare @wheeltodaydate			datetime				set @wheeltodaydate = getdate()		-- 무료룰렛
	declare @wheeltodaycnt			int						set @wheeltodaycnt	= 9999

	-- 시간체킹
	declare @dateid10 				varchar(10) 			set @dateid10 		= Convert(varchar(8), Getdate(),112) + Convert(varchar(2), Getdate(), 108)
	declare @dateid8 				varchar(8) 				set @dateid8 		= Convert(varchar(8), Getdate(),112)
	declare @rand					int
	declare @logindate				varchar(8)				set @logindate		= '20100101'

	-- 일반변수값
	declare @schoolinitdate			varchar(19),
			@dw						int,
			@schoolname				varchar(128),
			@schoolidx				int
	-- 학교대항 결과.
	declare @schoolresult			int						set @schoolresult	= 1		-- tUserMaster
	declare @schoolresult2			int						set @schoolresult2	= 1		-- 전송결과.
	declare @schoolresult3			int						set @schoolresult3	= 1		-- tSchoolResult
	declare @farmharvest			int						set @farmharvest	= 0
	declare @sendheart				int						set @sendheart		= 0
	declare @friendinvite			int						set @friendinvite	= 0

	-- 하트받은 정보개수.
	declare @heartget				int						set @heartget		= 0
	declare @heartmsg				varchar(128)			set @heartmsg		= ''

	-- 1일 초대 인원 초기화.
	declare @kakaomsginvitetodaycnt		int			set @kakaomsginvitetodaycnt		= 0
	declare @kakaomsginvitetodaydate	datetime	set @kakaomsginvitetodaydate	= getdate()

	-- 자신의 사진정보.
	declare @kakaoprofile			varchar(512)
	declare @kkhelpalivecnt			int				set @kkhelpalivecnt				= 0

	-- 악세사리 정보 가격.
	declare @roulaccprice			int				set @roulaccprice 				= 10 -- 악세10수정.
	declare @roulaccsale			int				set @roulaccsale 				= 10 -- 10%.

	-- 이벤트1 > 로그인만하면
	--declare @eventonedailystate		int				set @eventonedailystate 		= @EVENT_STATE_NON
	--declare @eventonedailyloop		int

	-- 이벤트2 > 지정된 시간에 로그인하면 선물지급~~~
	declare @eventstatemaster		int				set @eventstatemaster			= @EVENT_STATE_NON
	declare @eventidx				int				set @eventidx					= -1
	declare @eventidx2				int
	declare @eventitemcode			int				set @eventitemcode				= -1
	declare @eventcnt				int				set @eventcnt					= 0
	declare @eventsender 			varchar(20)		set @eventsender				= '짜요 소녀'
	declare @strmarket				varchar(40)
	declare @curyear				int				set @curyear					= DATEPART("yy", @curdate)
	declare @curmonth				int				set @curmonth					= DATEPART("mm", @curdate)
	declare @curday					int				set @curday						= DATEPART(dd, @curdate)
	declare @curhour				int				set @curhour					= DATEPART(hour, @curdate)

	-- 퀘스트 순환구조.
	declare @comreward				int				set @comreward					= 90106
	declare @idx2					int				set @idx2 						= 0
	declare @USER_LIST_MAX			int				set @USER_LIST_MAX 				= 50	-- 라인 50개만 유지한다.
	declare @COMREWARD_RECYCLE		int				set @COMREWARD_RECYCLE			= 90154

	-- 신규목장.
	declare @farmidx				int				set @farmidx					= 0

	-- 야바위 정보.
	declare @yabauidx				int				set @yabauidx					= -1	-- -2:영구잠금, -1:영구잠금, 1 >= 야바위 번호
	declare @yabaustep				int				set @yabaustep					= 0

	-- 복귀 처리.
	declare @rtnflag				int														-- 현재복귀 플래그 상태.
	declare @rtngameid				varchar(20)		set @rtngameid					= ''
	declare @rtndate				datetime		set @rtndate					= getdate() - 1
	declare @rtnstep				int				set @rtnstep					= 0		-- 1일차 1, 2일차 2....
	declare @rtnplaycnt				int				set @rtnplaycnt					= 0		-- 거래횟수.
	declare @rtnitemcode			int				set @rtnitemcode				= 5027	-- 수정5.

	-- VIP효과.
	declare @cashpoint				int				set @cashpoint					= 0
	declare @vip_plus				int				set @vip_plus					= 0

	-- SKT 생애첫결제 1번 클리어.
	declare @eventspot08			int				set @eventspot08				= 0


Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG 입력정보', @gameid_ gameid_, @password_ password_, @market_ market_, @version_ version_

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	select
		@gameid 		= gameid,			@password		= password,			@condate			= condate,
		@fame			= fame,				@famelv			= famelv,			@famelvbest			= famelvbest,
		@blockstate 	= blockstate, 		@deletestate 	= deletestate,
		@cashcopy 		= cashcopy, 		@resultcopy 	= resultcopy,
		@gamecost 		= gamecost,
		@cashcost 		= cashcost,
		@feedmax		= feedmax,
		@heartmax		= heartmax,
		@fpointmax		= fpointmax,
		@cashpoint		= cashpoint,
		@goldticket		= goldticket, 		@goldticketmax 	= goldticketmax, 	@goldtickettime		= goldtickettime,
		@battleticket	= battleticket, 	@battleticketmax= battleticketmax, 	@battletickettime	= battletickettime,
		@battleanilistidx1= battleanilistidx1, @battleanilistidx2= battleanilistidx2, @battleanilistidx3= battleanilistidx3, @battleanilistidx4= battleanilistidx4, @battleanilistidx5= battleanilistidx5,
		@tslistidx1		= tslistidx1, 		@tslistidx2		= tslistidx2, 		@tslistidx3		= tslistidx3, 				@tslistidx4		= tslistidx4, 			@tslistidx5		= tslistidx5,
		@schoolidx		= schoolidx,
		@schoolresult	= schoolresult,
		@heartget		= heartget,
		@logindate		= logindate,
		@comreward		= comreward,
		@yabauidx		= yabauidx,
		@yabaustep		= yabaustep,
		@market			= market,
		@version		= version,
		@gameyear		= gameyear,
		@gamemonth		= gamemonth,
		@tsskillcashcost= tsskillcashcost,	@tsskillheart	= tsskillheart,		@tsskillgamecost	= tsskillgamecost,
		@tsskillfpoint	= tsskillfpoint,	@tsskillrebirth	= tsskillrebirth,	@tsskillalba		= tsskillalba,
		@tsskillbullet	= tsskillbullet,	@tsskillvaccine	= tsskillvaccine,	@tsskillfeed		= tsskillfeed,			@tsskillbooster		= tsskillbooster,

		@housestep		= housestep,		@housestate		= housestate,		@housetime		= housetime,
		@tankstep		= tankstep,			@tankstate		= tankstate,		@tanktime 		= tanktime,
		@bottlestep		= bottlestep,		@bottlestate 	= bottlestate,		@bottletime		= bottletime,
		@pumpstep		= pumpstep,			@pumpstate		= pumpstate,		@pumptime		= pumptime,
		@transferstep	= transferstep,		@transferstate	= transferstate,	@transfertime 	= transfertime,
		@purestep		= purestep,			@purestate		= purestate,		@puretime 		= puretime,
		@freshcoolstep	= freshcoolstep,	@freshcoolstate	= freshcoolstate,	@freshcooltime 	= freshcooltime,

		@bulletlistidx	= bulletlistidx,
		@vaccinelistidx	= vaccinelistidx,
		@albalistidx	= albalistidx,
		@boosterlistidx	= boosterlistidx,
		@eventspot08	= eventspot08,

		@kakaomsginvitetodaycnt 	= kakaomsginvitetodaycnt,
		@kakaomsginvitetodaydate	= kakaomsginvitetodaydate,
		@kakaoprofile				= kakaoprofile,
		@kkhelpalivecnt				= kkhelpalivecnt,

		@rtngameid		= rtngameid, 		@rtndate	= rtndate,
		@rtnstep		= rtnstep, 			@rtnplaycnt	= rtnplaycnt,

		@pettodayitemcode	= pettodayitemcode,
		@pettodayitemcode2	= pettodayitemcode2,
		@attenddate 		= attenddate, 		@attendcnt 		= attendcnt,
		@heartsenddate		= heartsenddate, 	@heartsendcnt	= heartsendcnt,	@zcpappearcnt	= zcpappearcnt,
		@anibuydate			= anibuydate, 		@anibuycnt	= anibuycnt,
		@wheeltodaydate		= wheeltodaydate, 	@wheeltodaycnt	= wheeltodaycnt
	from dbo.tUserMaster
	where gameid = @gameid_
	--select 'DEBUG 유저정보', @gameid gameid, @blockstate blockstate, @deletestate deletestate, @cashcopy cashcopy, @resultcopy resultcopy, @gamecost gamecost, @cashcost cashcost, @attenddate attenddate, @attendcnt attendcnt

	------------------------------------------------
	--	3-3. 공지사항 체크
	------------------------------------------------
	select top 1 @cursyscheck = syscheck, @curversion = version from dbo.tNotice
	where market = @market_
	order by idx desc
	--select 'DEBUG 공지사항', @cursyscheck cursyscheck, @curversion curversion

	if(@cursyscheck = @SYSCHECK_YES)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_SERVER_CHECKING
			set @comment 	= 'DEBUG 시스템 점검중입니다.'
			--select 'DEBUG ', @comment
		END
	else if(isnull(@gameid, '') = '')
		BEGIN
			-- 아이디가 존재하지않는가??
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '아이디가 존재하지 않는다. > 아이디를 확인해라.'
			--select 'DEBUG ', @comment
		END
	else if(isnull(@password, '') = '' or @password != @password_)
		BEGIN
			-- 아이디 & 패스워드 존재하지않는가??
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_PASSWORD
			set @comment 	= '패스워드 틀렸다. > 패스워드 확인해라'
			--select 'DEBUG ', @comment
		END
	else if(@version_ < @curversion)
		BEGIN
			-- 마켓별 버젼이 틀리다
			set @nResult_ 	= @RESULT_NEWVERION_CLIENT_DOWNLOAD
			set @comment 	= '마켓별 버젼이 틀리다. > 다시받아라.'
			--select 'DEBUG ', @comment
		END
	else if (@blockstate = @BLOCK_STATE_YES)
		BEGIN
			-- 블럭유저인가?
			set @nResult_ 	= @RESULT_ERROR_BLOCK_USER
			set @comment 	= '블럭처리된 아이디입니다.'
			--select 'DEBUG ', @comment
		END
	else if (@deletestate = @DELETE_STATE_YES)
		BEGIN
			-- 삭제유저인가?
			set @nResult_ 	= @RESULT_ERROR_DELETED_USER
			set @comment 	= '삭제된 아이디입니다.'
			--select 'DEBUG ', @comment
		END
	else if(@cashcopy >= 2)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_BLOCK_USER
			set @comment 	= '캐쉬결재카피를 '+ltrim(rtrim(str(@cashcopy)))+'회 이상했다. > 블럭처리하자!!'
			--select 'DEBUG ', @comment

			-- xx회 이상카피행동 > 블럭처리, 블럭로그기록
			update dbo.tUserMaster
				set
					blockstate = @BLOCK_STATE_YES,
					cashcopy = 0
			where gameid = @gameid_

			-- 아이템3회 카피에 대한 블럭처리
			insert into dbo.tUserBlockLog(gameid, comment)
			values(@gameid_, '(캐쉬결재)를  '+ltrim(rtrim(str(@cashcopy)))+'회 이상 카피를 해서 로그인시 시스템에서 블럭 처리했습니다.')
		END
	else if(@resultcopy >= 20)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_BLOCK_USER
			set @comment 	= '경기결과복제를 '+ltrim(rtrim(str(@resultcopy)))+'회이상 시도했다. > 블럭처리하자!!'
			--select 'DEBUG ', @comment

			--결과복제를 xx회 이상했다. > 블럭처리, 블럭로그기록
			update dbo.tUserMaster
				set
					blockstate = @BLOCK_STATE_YES,
					resultcopy = 0
			where gameid = @gameid_

			-- 아이템3회 카피에 대한 블럭처리
			insert into dbo.tUserBlockLog(gameid, comment)
			values(@gameid_, '경기결과복제를 '+ltrim(rtrim(str(@resultcopy)))+'회이상 시도해서 로그인시 시스템에서 블럭 처리했습니다.')
		END
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '로그인 정상처리'
			--select 'DEBUG ', @comment
		END


	-----------------------------------------------
	-- 결과코드처리.
	-----------------------------------------------
	select @nResult_ rtn, @comment comment

	if(@nResult_ = @RESULT_SUCCESS)
		BEGIN
				------------------------------------------------
			-- 마켓 이동 정보 수집
			------------------------------------------------
			--select 'DEBUG ', @market_ market_, @version_ version_, @market market, @version version
			 if(@market != @market_)
				begin
					insert into dbo.tUserBeforeInfo(gameid,  market, marketnew,  version,  fame,  famelv,  famelvbest,  gameyear,  gamemonth)
					values(                        @gameid, @market, @market_,  @version, @fame, @famelv, @famelvbest, @gameyear, @gamemonth)
				end


			-----------------------------------------------
			-- 이벤트 처리
			-----------------------------------------------
			--select 'DEBUG 이벤트 처리'

			-----------------------------------------------
			-- SKT 생애첫결제 1번 클리어.
			-----------------------------------------------
			--select 'DEBUG 이벤트 처리'
			if( @market_ = @MARKET_SKT and @eventspot08 <= 0 )
				begin
					--select 'DEBUG SKT 유저 클리어 1회만.'
					update dbo.tCashFirstTimeLog
						set
							writedate = writedate - 30
					where gameid = @gameid_

					set @eventspot08 = @eventspot08 + 1

				end

			------------------------------------------------
			-- 티켓 수량 정리.
			------------------------------------------------
			select
				@goldtickettime = rtndate,
				@goldticket		= rtncount
			from dbo.fnu_GetActionTime(@goldtickettime, getdate(), @goldticket, @goldticketmax)
			--select 'DEBUG ', @goldtickettime goldtickettime, @goldticket goldticket, @goldticketmax goldticketmax

			select
				@battletickettime 	= rtndate,
				@battleticket		= rtncount
			from dbo.fnu_GetActionTime(@battletickettime, getdate(), @battleticket, @battleticketmax)
			--select 'DEBUG ', @battletickettime battletickettime, @battleticket battleticket, @battleticketmax battleticketmax

			-----------------------------------------------
			-- 배틀참여동물 링크검사
			-----------------------------------------------
			if(@battleanilistidx1 != -1 and not exists(select top 1 * from dbo.tUserItem where gameid = @gameid and listidx = @battleanilistidx1))
				begin
						set @battleanilistidx1 = -1
				end

			if(@battleanilistidx2 != -1 and not exists(select top 1 * from dbo.tUserItem where gameid = @gameid and listidx = @battleanilistidx2))
				begin
						set @battleanilistidx2 = -1
				end

			if(@battleanilistidx3 != -1 and not exists(select top 1 * from dbo.tUserItem where gameid = @gameid and listidx = @battleanilistidx3))
				begin
						set @battleanilistidx3 = -1
				end

			if(@battleanilistidx4 != -1 and not exists(select top 1 * from dbo.tUserItem where gameid = @gameid and listidx = @battleanilistidx4))
				begin
						set @battleanilistidx4 = -1
				end

			if(@battleanilistidx5 != -1 and not exists(select top 1 * from dbo.tUserItem where gameid = @gameid and listidx = @battleanilistidx5))
				begin
						set @battleanilistidx5 = -1
				end

			-----------------------------------------------
			-- 보물 링크검사.
			-----------------------------------------------
			if(@tslistidx1 != -1 and not exists(select top 1 * from dbo.tUserItem where gameid = @gameid and listidx = @tslistidx1 and invenkind = @USERITEM_INVENKIND_TREASURE))
				begin
						set @tslistidx1 = -1
				end

			if(@tslistidx2 != -1 and not exists(select top 1 * from dbo.tUserItem where gameid = @gameid and listidx = @tslistidx2 and invenkind = @USERITEM_INVENKIND_TREASURE))
				begin
						set @tslistidx2 = -1
				end

			if(@tslistidx3 != -1 and not exists(select top 1 * from dbo.tUserItem where gameid = @gameid and listidx = @tslistidx3 and invenkind = @USERITEM_INVENKIND_TREASURE))
				begin
						set @tslistidx3 = -1
				end

			if(@tslistidx4 != -1 and not exists(select top 1 * from dbo.tUserItem where gameid = @gameid and listidx = @tslistidx4 and invenkind = @USERITEM_INVENKIND_TREASURE))
				begin
						set @tslistidx4 = -1
				end

			if(@tslistidx5 != -1 and not exists(select top 1 * from dbo.tUserItem where gameid = @gameid and listidx = @tslistidx5 and invenkind = @USERITEM_INVENKIND_TREASURE))
				begin
						set @tslistidx5 = -1
				end

			------------------------------------------------
			-- 경쟁모드 순환구조로 변경한다.
			------------------------------------------------
			if(@comreward = -1)
				begin
					select @idx2 = isnull(max(idx2), 1) from dbo.tComReward where gameid = @gameid_
					set @idx2 = @idx2 + 1

					delete dbo.tComReward where gameid = @gameid_ and idx2 < @idx2 - @USER_LIST_MAX

					set @comreward = @COMREWARD_RECYCLE
				end

			-----------------------------------------------
			-- 각각시설물 > 0 and 시간이지나갔는가? > 다음단계로 표시, 진행중(-1)로 변경
			-- 액세서리 뽑기 일부 정보 시스템에서 얻어오기.
			-----------------------------------------------
			select top 1
				@housestepmax		= housestepmax,
				@tankstepmax		= tankstepmax, 			@bottlestepmax		= bottlestepmax,
				@pumpstepmax 		= pumpstepmax,			@transferstepmax 	= transferstepmax,
				@purestepmax		= purestepmax, 		 	@freshcoolstepmax 	= freshcoolstepmax,
				@invenstepmax 		= invenstepmax, 		@invencountmax 		= invencountmax, 		@seedfieldmax 		= seedfieldmax,
				@rtnflag			= rtnflag,
				@roulaccprice 		= roulaccprice,
				@roulaccsale		= roulaccsale
			from dbo.tSystemInfo
			order by idx desc
			--select 'DEBUG 각각시설물 max', @housestepmax housestepmax, @tankstepmax tankstepmax, @bottlestepmax bottlestepmax, @pumpstepmax pumpstepmax, @transferstepmax transferstepmax, @purestepmax purestepmax, @freshcoolstepmax freshcoolstepmax, @invenstepmax invenstepmax, @invencountmax invencountmax, @seedfieldmax seedfieldmax

			--select 'DEBUG 업글(집전)', @housestate housestate, @housestep housestep, @housestepmax housestepmax, @housetime housetime
			if(@housestate = @USERMASTER_UPGRADE_STATE_ING and @curdate >= @housetime)
				begin
					set @housestate = @USERMASTER_UPGRADE_STATE_NON
					set @housestep	= CASE
											WHEN (@housestep + 1 < @housestepmax) THEN @housestep + 1
											ELSE @housestepmax
									  END

					-- 집업글완료 > 건초, 하트 맥스확장.
					select
						@feedmax		= param5,
						@heartmax		= param6,
						@fpointmax		= param9
					from dbo.tItemInfo
					where subcategory = @ITEM_SUBCATEGORY_UPGRADE_HOUSE and param1 = @housestep
				end
			else
				begin
					-- 집업글완료 > 건초, 하트 맥스확장.
					select
						@feedmax		= param5,
						@heartmax		= param6,
						@fpointmax		= param9
					from dbo.tItemInfo
					where subcategory = @ITEM_SUBCATEGORY_UPGRADE_HOUSE and param1 = @housestep
				end
			--select 'DEBUG 업글(집후)', @housestate housestate, @housestep housestep, @housestepmax housestepmax, @housetime housetime

			--select 'DEBUG 업글(탱크전)', @tankstate tankstate, @tankstep tankstep, @tankstepmax tankstepmax, @tanktime tanktime
			if(@tankstate = @USERMASTER_UPGRADE_STATE_ING and @curdate >= @tanktime)
				begin
					set @tankstate = @USERMASTER_UPGRADE_STATE_NON
					set @tankstep	= CASE
											WHEN (@tankstep + 1 < @tankstepmax) THEN @tankstep + 1
											ELSE @tankstepmax
									  END
				end
			--select 'DEBUG 업글(탱크후)', @tankstate tankstate, @tankstep tankstep, @tankstepmax tankstepmax, @tanktime tanktime

			--select 'DEBUG 업글(양동이전)', @bottlestate bottlestate, @bottlestep bottlestep, @bottlestepmax bottlestepmax, @bottletime bottletime
			if(@bottlestate = @USERMASTER_UPGRADE_STATE_ING and @curdate >= @bottletime)
				begin
					set @bottlestate = @USERMASTER_UPGRADE_STATE_NON
					set @bottlestep	= CASE
											WHEN (@bottlestep + 1 < @bottlestepmax) THEN @bottlestep + 1
											ELSE @bottlestepmax
									  END
				end
			--select 'DEBUG 업글(양동이후)', @bottlestate bottlestate, @bottlestep bottlestep, @bottlestepmax bottlestepmax, @bottletime bottletime


			--select 'DEBUG 업글(착유기전)', @pumpstate pumpstate, @pumpstep pumpstep, @pumpstepmax pumpstepmax, @pumptime pumptime
			if(@pumpstate = @USERMASTER_UPGRADE_STATE_ING and @curdate >= @pumptime)
				begin
					set @pumpstate = @USERMASTER_UPGRADE_STATE_NON
					set @pumpstep	= CASE
											WHEN (@pumpstep + 1 < @pumpstepmax) THEN @pumpstep + 1
											ELSE @pumpstepmax
									  END
				end
			--select 'DEBUG 업글(착유기후)', @pumpstate pumpstate, @pumpstep pumpstep, @pumpstepmax pumpstepmax, @pumptime pumptime

			--select 'DEBUG 업글(주입기전)', @transferstate transferstate, @transferstep transferstep, @transferstepmax transferstepmax, @transfertime transfertime
			if(@transferstate = @USERMASTER_UPGRADE_STATE_ING and @curdate >= @transfertime)
				begin
					set @transferstate = @USERMASTER_UPGRADE_STATE_NON
					set @transferstep	= CASE
											WHEN (@transferstep + 1 < @transferstepmax) THEN @transferstep + 1
											ELSE @transferstepmax
									  END
				end
			--select 'DEBUG 업글(주입기후)', @transferstate transferstate, @transferstep transferstep, @transferstepmax transferstepmax, @transfertime transfertime



			--select 'DEBUG 업글(정화전)', @purestate purestate, @purestep purestep, @purestepmax purestepmax, @puretime puretime
			if(@purestate = @USERMASTER_UPGRADE_STATE_ING and @curdate >= @puretime)
				begin
					set @purestate = @USERMASTER_UPGRADE_STATE_NON
					set @purestep	= CASE
											WHEN (@purestep + 1 < @purestepmax) THEN @purestep + 1
											ELSE @purestepmax
									  END
				end
			--select 'DEBUG 업글(정화후)', @purestate purestate, @purestep purestep, @purestepmax purestepmax, @puretime puretime

			--select 'DEBUG 업글(저온보관)', @freshcoolstate freshcoolstate, @freshcoolstep freshcoolstep, @freshcoolstepmax freshcoolstepmax, @freshcooltime freshcooltime
			if(@freshcoolstate = @USERMASTER_UPGRADE_STATE_ING and @curdate >= @freshcooltime)
				begin
					set @freshcoolstate = @USERMASTER_UPGRADE_STATE_NON
					set @freshcoolstep	= CASE
											WHEN (@freshcoolstep + 1 < @freshcoolstepmax) THEN @freshcoolstep + 1
											ELSE @freshcoolstepmax
									  END
				end
			--select 'DEBUG 업글(저온보관후)', @freshcoolstate freshcoolstate, @freshcoolstep freshcoolstep, @freshcoolstepmax freshcoolstepmax, @freshcooltime freshcooltime


			-----------------------------------------------
			-- (소모템슬롯 -> 해당아이템개수 0) 소모템슬로번호 -1로 처리(빈곳)
			-----------------------------------------------
			--select 'DEBUG 소모템 슬롯정리', @bulletlistidx bulletlistidx, @vaccinelistidx vaccinelistidx, @albalistidx albalistidx, @boosterlistidx boosterlistidx

			set @tmpcnt = 0
			select @tmpcnt = cnt, @invenkind = invenkind from dbo.tUserItem where gameid = @gameid and listidx = @bulletlistidx
			if(@bulletlistidx != -1 and (@tmpcnt <= 0 or @invenkind != @USERITEM_INVENKIND_CONSUME ))
				begin
					--select 'DEBUG 총알 다사용해서 슬롯삭제, 퀵슬로 클리어'
					set @bulletlistidx 		= -1
				end

			set @tmpcnt = 0
			select @tmpcnt = cnt, @invenkind = invenkind from dbo.tUserItem where gameid = @gameid and listidx = @vaccinelistidx
			if(@vaccinelistidx != -1 and (@tmpcnt <= 0 or @invenkind != @USERITEM_INVENKIND_CONSUME ))
				begin
					--select 'DEBUG 백신 다사용해서 슬롯삭제, 퀵슬로 클리어'
					set @vaccinelistidx 	= -1
				end

			set @tmpcnt = 0
			select @tmpcnt = cnt, @invenkind = invenkind from dbo.tUserItem where gameid = @gameid and listidx = @albalistidx
			if(@albalistidx != -1 and (@tmpcnt <= 0 or @invenkind != @USERITEM_INVENKIND_CONSUME ))
				begin
					--select 'DEBUG 알바 다사용해서 슬롯삭제, 퀵슬로 클리어'
					set @albalistidx 		= -1
				end

			set @tmpcnt = 0
			select @tmpcnt = cnt, @invenkind = invenkind from dbo.tUserItem where gameid = @gameid and listidx = @boosterlistidx
			if(@boosterlistidx != -1 and (@tmpcnt <= 0 or @invenkind != @USERITEM_INVENKIND_CONSUME ))
				begin
					--select 'DEBUG 촉진제 다사용해서 슬롯삭제, 퀵슬로 클리어'
					set @boosterlistidx 	= -1
				end

			-- 부활석은 인벤에 장착 안되는 경우가 있어서 슬롯으로는 확인불가능한 것이 존재함....
			-- 모든 소모템들 중에서 수량이 없는 것은 정리 대상이 된다.
			delete from dbo.tUserItem where gameid = @gameid and invenkind = @USERITEM_INVENKIND_CONSUME and cnt <= 0

			-- 짜요쿠폰 만기되면 삭제됨.
			if( exists(select top 1 * from dbo.tUserItem where gameid = @gameid and itemcode = @ITEM_ZCP_TICKET_MOTHER and expiredate < getdate() ) )
				begin
					--select 'DEBUG 만기있음.'
					exec spu_DeleteUserExpire @gameid_
				end

			-----------------------------------------------
			-- 죽은 동물 > 10개이상 > (죽을때 검사함)
			-----------------------------------------------
			-- 여기서 안함.

			-------------------------------------------------
			---- 죽은 동물 > 동물병원(죽을때 이동함)
			-------------------------------------------------
			-- 여기서 안함.

			-------------------------------------------------
			---- 카톡 초대인원 초기화.
			-------------------------------------------------
			set @tmpcnt = datediff(d, @kakaomsginvitetodaydate, getdate())
			if(@tmpcnt >= 1)
				begin
					set @kakaomsginvitetodaycnt		= 0
					set @kakaomsginvitetodaydate 	= getdate()
				end

			-- 카톡 사진변경.
			if(isnull(@kakaoprofile_, '') != '')
				begin
					set @kakaoprofile = @kakaoprofile_
				end

			-----------------------------------------------
			-- 28일간 출석 보상받기
			-- 1 -> 2 -> ... -> 28 (반복)
			--  datediff(d, @attenddate, @curdate) > 일차이만 알려준다.
			-- 	'2016-01-09 00:00'		'2016-01-29 00:01' 	20일
			-- 	'2016-01-28 00:01'		'2016-01-29 00:01' 	1일
			-- 	'2016-01-28 23:59'		'2016-01-29 00:01' 	1일		* 일차이만 ㅎㅎㅎ;
			-- 	'2016-01-29 00:00'		'2016-01-29 23:59' 	1일
			-----------------------------------------------
			set @tmpcnt = datediff(d, @attenddate, @curdate)
			set @newday = @tmpcnt
			set @attendnewday 	= case when @newday >= 1 then 1 else 0 end
			--set @eventonedailystate = case when @newday >= 1 then @EVENT_STATE_YES else @EVENT_STATE_NON end
			--select 'DEBUG ', @tmpcnt tmpcnt, @newday newday, @attendcnt attendcnt

			if(@newday >= 1)
				begin
					set @attenddate 	= getdate()
					set @attendcnt 		= @attendcnt + 1
					set @attendcnt 		= case when @attendcnt > 28 then 1 else @attendcnt end

					select
						@attenditemcode 	= param2,
						@attenditemcodecnt	= param3
					from dbo.tItemInfo where subcategory = @ITEM_SUBCATEGORY_ATTENDANCE and param1 = @attendcnt
					--select 'DEBUG 출석일 갱신', @attenddate attenddate, @attendcnt attendcnt, @attenditemcode attenditemcode, @attenditemcodecnt attenditemcodecnt

					if(@attenditemcode != -1 and @attenditemcodecnt > 0)
						begin
							--select 'DEBUG 보상'
							set @attendcomment = rtrim( ltrim( str( @attendcnt ) ) ) + '일보상'
							exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT,  @attenditemcode, @attenditemcodecnt, @attendcomment, @gameid_, ''
						end
				end

			-----------------------------------------------
			-- 일일출석 -> 짜요쿠폰조각룰렛 등장횟수 초기화.
			-----------------------------------------------
			if(@newday >= 1)
				begin
					set @zcpappearcnt 	= 0;
				end

			-----------------------------------------------
			-- 하트 일일 권장량 초기화날짜.
			-----------------------------------------------
			set @tmpcnt = datediff(d, @heartsenddate, @curdate)
			if(@tmpcnt >= 1)
				begin
					set @heartsenddate 	= getdate()
					set @heartsendcnt 	= 0;
				end

			-----------------------------------------------
			-- 동물 일일 권장량 초기화날짜.
			-----------------------------------------------
			set @tmpcnt = datediff(d, @anibuydate, @curdate)
			if(@tmpcnt >= 1)
				begin
					set @anibuydate 	= getdate()
					set @anibuycnt	 	= 0;
				end

			-----------------------------------------------
			-- 동물 일일 권장량 초기화날짜.
			-----------------------------------------------
			set @tmpcnt = datediff(d, @wheeltodaydate, @curdate)
			if(@tmpcnt >= 1)
				begin
					set @wheeltodaydate = getdate()
					set @wheeltodaycnt	= 0;
				end

			-----------------------------------------------
			-- 보물 보유효과 처리.
			-- 	루비생산		5000		출석시 5~30루비를 생산한다(50)
			--	하트생산		2000		출석시 20~40하트를 생산한다(51)
			-- 	코인생산		5100		출석시 2000 ~ 9000만 코인생산한다(52)	-> 레벨에 따라서 상향되도록 했음.
			-- 	우포생산		1900		출석시 50~100우정포인트 생산한다(53)
			--	부활석생산		1200		출석시 부활석 1~3개 생산한다(54)
			--	알바생산		1002		출석시 알바의 귀재 2~5개 생산한다(55)
			--	특수탄 생산		702			출석시 특수탄 4~10개 생산한다(56)
			-- 	슈퍼백신생산	802			출석시 슈퍼백신 3~5개 생산한다(57)
			-- 	건초생산		900			출석시 건초 50~90개 생산한다(58)
			--	특수촉진제생산	1103		출석시 특수촉진제 3~5개 생산한다(59)
			-----------------------------------------------
			--select 'DEBUG 보물보유효과', @tsskillcashcost tsskillcashcost, @tsskillheart tsskillheart, @tsskillgamecost tsskillgamecost, @tsskillfpoint tsskillfpoint, @tsskillrebirth tsskillrebirth, @tsskillalba tsskillalba, @tsskillbullet tsskillbullet, @tsskillvaccine tsskillvaccine, @tsskillfeed tsskillfeed, @tsskillbooster tsskillbooster
			--------------------------------------
			-- 임시테이블 생성해두기.
			--------------------------------------
			DECLARE @tTempTreasureReward TABLE(
				itemcode	int,
				cnt			int
			);

			if(@newday >= 1)
				begin
					set @rand = Convert(int, ceiling(RAND() * 100))
					--select 'DEBUG ', @rand rand

					if( @tsskillcashcost > 0 and @rand <= @tsskillcashcost )
						begin
							set @tmpcnt = 5 + Convert(int, ceiling(RAND() * 25))
							set @tmpitemcode= 5000
							--select 'DEBUG > 루비생산', @tmpcnt tmpcnt
							exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT, @tmpitemcode, @tmpcnt, '루비생산보석', @gameid_, ''

							-- 수량발송.
							insert into @tTempTreasureReward(itemcode, cnt) values( @tmpitemcode, @tmpcnt );
						end

					if( @tsskillheart > 0 and @rand <= @tsskillheart )
						begin
							set @tmpcnt = 100 + Convert(int, ceiling(RAND() * 100))
							set @tmpitemcode= 2000
							--select 'DEBUG > 하트생산', @tmpcnt tmpcnt
							exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT, @tmpitemcode, @tmpcnt, '하트생산보석', @gameid_, ''

							-- 수량발송.
							insert into @tTempTreasureReward(itemcode, cnt) values( @tmpitemcode, @tmpcnt );
						end

					if( @tsskillgamecost > 0 and @rand <= @tsskillgamecost )
						begin
							set @tmpcnt = case
												when @famelv <  5 then 2000
												when @famelv < 10 then 3000
												when @famelv < 20 then 4000
												when @famelv < 30 then 5000
												when @famelv < 40 then 6000
												else                   7000
										  end
							set @tmpcnt = @tmpcnt + Convert(int, ceiling(RAND() * 2000))
							set @tmpitemcode= 5100
							--select 'DEBUG > 코인생산', @tmpcnt tmpcnt
							exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT, @tmpitemcode, @tmpcnt, '코인생산보석', @gameid_, ''

							-- 수량발송.
							insert into @tTempTreasureReward(itemcode, cnt) values( @tmpitemcode, @tmpcnt );
						end

					if( @tsskillfpoint > 0 and @rand <= @tsskillfpoint )
						begin
							set @tmpcnt = 100 + Convert(int, ceiling(RAND() * 50))
							set @tmpitemcode= 1900
							--select 'DEBUG > 우포생산', @tmpcnt tmpcnt
							exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT, @tmpitemcode, @tmpcnt, '우포생산보석', @gameid_, ''

							-- 수량발송.
							insert into @tTempTreasureReward(itemcode, cnt) values( @tmpitemcode, @tmpcnt );
						end

					if( @tsskillrebirth > 0 and @rand <= @tsskillrebirth )
						begin
							set @tmpcnt = 1 + Convert(int, ceiling(RAND() * 2))
							set @tmpitemcode= 1200
							--select 'DEBUG > 부활석생산', @tmpcnt tmpcnt
							exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT, @tmpitemcode, @tmpcnt, '부활석생산보석', @gameid_, ''

							-- 수량발송.
							insert into @tTempTreasureReward(itemcode, cnt) values( @tmpitemcode, @tmpcnt );
						end

					if( @tsskillalba > 0 and @rand <= @tsskillalba )
						begin
							set @tmpcnt = 2 + Convert(int, ceiling(RAND() * 3))
							set @tmpitemcode= 1002
							--select 'DEBUG > 알바생산보석', @tmpcnt tmpcnt
							exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT, @tmpitemcode, @tmpcnt, '알바생산보석', @gameid_, ''

							-- 수량발송.
							insert into @tTempTreasureReward(itemcode, cnt) values( @tmpitemcode, @tmpcnt );
						end

					if( @tsskillbullet > 0 and @rand <= @tsskillbullet )
						begin
							set @tmpcnt = 4 + Convert(int, ceiling(RAND() * 6))
							set @tmpitemcode= 702
							--select 'DEBUG > 특수탄생산보석', @tmpcnt tmpcnt
							exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT, @tmpitemcode, @tmpcnt, '특수탄생산보석', @gameid_, ''

							-- 수량발송.
							insert into @tTempTreasureReward(itemcode, cnt) values( @tmpitemcode, @tmpcnt );
						end

					if( @tsskillvaccine > 0 and @rand <= @tsskillvaccine )
						begin
							set @tmpcnt = 3 + Convert(int, ceiling(RAND() * 2))
							set @tmpitemcode= 802
							--select 'DEBUG > 백신생산보석', @tmpcnt tmpcnt
							exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT, @tmpitemcode, @tmpcnt, '백신생산보석', @gameid_, ''

							-- 수량발송.
							insert into @tTempTreasureReward(itemcode, cnt) values( @tmpitemcode, @tmpcnt );
						end

					if( @tsskillfeed > 0 and @rand <= @tsskillfeed )
						begin
							set @tmpcnt 	= 150 + Convert(int, ceiling(RAND() * 150))
							set @tmpitemcode= 900
							--select 'DEBUG > 건초생산보석', @tmpcnt tmpcnt
							exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT, @tmpitemcode, @tmpcnt, '건초생산보석', @gameid_, ''

							-- 수량발송.
							insert into @tTempTreasureReward(itemcode, cnt) values( @tmpitemcode, @tmpcnt );
						end

					if( @tsskillbooster > 0 and @rand <= @tsskillbooster )
						begin
							set @tmpcnt 	= 3 + Convert(int, ceiling(RAND() * 2))
							set @tmpitemcode= 1103
							--select 'DEBUG > 촉진제생산보석', @tmpcnt tmpcnt
							exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT, @tmpitemcode, @tmpcnt, '촉진제생산보석', @gameid_, ''

							-- 수량발송.
							insert into @tTempTreasureReward(itemcode, cnt) values( @tmpitemcode, @tmpcnt );
						end
				end


			---------------------------------------------------------------------
			-- Event1 로그인만 하면 매일 매일 소모템을 쏜다~~~
			--  1일 일반 교배 티켓 (2개)
			--  2일 알바의 귀재 패키지 (4개)
			--  3일 부활석 (3개)
			---------------------------------------------------------------------
			--if(@eventonedailystate = @EVENT_STATE_YES)
			--	begin
			--		set @eventonedailyloop = datepart(dd, getdate())%3
			--		if(@eventonedailyloop = 0)
			--			begin
			--				exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT,  2200, 2, 'OpenEvent', @gameid_, '오픈이벤트'
			--			end
			--		else if(@eventonedailyloop = 1)
			--			begin
			--				exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT,  1002, 4, 'OpenEvent', @gameid_, '오픈이벤트'
			--			end
			--		else
			--			begin
			--				exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT,  1200, 3, 'OpenEvent', @gameid_, '오픈이벤트'
			--			end
			--	end

			-------------------------------------------------------------------
			-- Event2 지정된 시간에 로그인하면 선물지급~~~
			-- 		step1 : 마스터가 진행중
			--		step2 : 시작 <= 지금 < 끝 (진행중)
			--				=> 이벤트코드, 아이템코드, 보낸이
			--		step3 : 해당 선물 지급, 선물지급 기록(tEventUser)
			-------------------------------------------------------------------
			select @eventstatemaster = eventstatemaster from dbo.tEventMaster where idx = 1
			--select 'DEBUG 지정이벤트1-1', @eventstatemaster eventstatemaster
			if(@eventstatemaster = @EVENT_STATE_YES)
				begin
					select top 1
						@eventidx 		= eventidx,
						@eventitemcode 	= eventitemcode,
						@eventcnt		= eventcnt,
						@eventsender 	= eventsender
					from dbo.tEventSub
					where @curday = eventday and eventstarthour <= @curhour and @curhour <= eventendhour and eventstatedaily = @EVENT_STATE_YES
					order by eventidx desc

					set @eventidx2 = (@curyear - 2015)*1000000 + @curmonth*10000 + @curday*100 + @eventidx
					--select 'DEBUG 지정이벤트1-2', @eventidx eventidx, @eventitemcode eventitemcode, @eventsender eventsender, @eventidx2 eventidx2

					if(@eventidx != -1 and @eventitemcode != -1)
						begin
							--select 'DEBUG 지정이벤트1-3'
							if(not exists(select top 1 * from dbo.tEvnetUserGetLog where gameid = @gameid_ and eventidx = @eventidx2))
								begin
									--select 'DEBUG 지정이벤트1-4 선물, 로그기록'
									exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT,  @eventitemcode, @eventcnt, @eventsender, @gameid_, '지정된 시간'

									insert into dbo.tEvnetUserGetLog(gameid,   eventidx,   eventitemcode,  eventcnt)
									values(                         @gameid_, @eventidx2, @eventitemcode, @eventcnt)

									---------------------------------
									---- 필터구간 > 추가로 시간단축템 지급 > 현재는 삭제
									---------------------------------
									--if(@market_ not in (@MARKET_IPHONE) and @eventitemcode in (703, 1202))
									--	begin
									--		exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT, 1600, 0, @eventsender, @gameid_, '지정된 시간'
									--	end

									-- 자세한 로고는 선물함에 있어서 삭제해도 된다.
									select @idx2 = max(idx) from dbo.tEvnetUserGetLog
									delete from tEvnetUserGetLog where idx <= @idx2 - 8800
								end
						end
				end


			-------------------------------------------------------------------
			-- 1일 > 미보유중 오늘판매(펫)
			--  >  오늘만 판매(아이템코드)기록
			-- fun으로는 못사용함 (newid()때문)
			-------------------------------------------------------------------
			if(@newday >= 1)
				begin
					select top 1 @pettodayitemcode = itemcode from dbo.tItemInfo
					where subcategory = @ITEM_SUBCATEGORY_PET
						  and itemcode not in (select itemcode from dbo.tUserItem
						  					   where gameid = @gameid_
						  					   		 and invenkind = @USERITEM_INVENKIND_PET)
						  --and (ABS(CAST( (BINARY_CHECKSUM(*) * RAND()) as int)) % 100) <= 100
						  order by newid()

					-- 오늘만 펫을 그대로 체험펫으로 전환.
					set @pettodayitemcode2 = @pettodayitemcode
				end

			-- 체험펫이 존재하고 오늘만 펫과 체험펫 다르면 > 오늘만 펫으로 교체.
			if(@pettodayitemcode2 != -1 and @pettodayitemcode != @pettodayitemcode2)
				begin
					set @pettodayitemcode2 = @pettodayitemcode
				end

			-------------------------------------------------------------------
			-- 1일 and 미진행 > 야바위 교체
			-- 야바위가 없음  > 야바위 교체
			--if((@newday >= 1 and @yabaustep = 0) or not exists(select top 1 * from dbo.tSystemYabau where idx = @yabauidx))
			-------------------------------------------------------------------
			set @strmarket = '%' + ltrim(rtrim(str(@market_))) + '%'
			if(@market_ = @MARKET_GOOGLE)
				begin
					-- Google 서비스.
					if((@newday >= 1 and @yabaustep = 0) or @yabauidx <= -1)
						begin
							select top 1 @yabauidx = idx from dbo.tSystemYabau
							where famelvmin <= @famelv
								and @famelv <= famelvmax
								and packstate = 1
								and packmarket like @strmarket
								order by newid()
						end

					if(not exists(select top 1 * from dbo.tSystemYabau where idx = @yabauidx))
						begin
							set @yabauidx = -1
						end
				end
			else
				begin
					-- 영구 잠금(SKT, Naver, iPhone)
					set @yabauidx = -2
				end


			-------------------------------------------------------------------
			-- 복귀 처리 하기.
			--if(condate >=30)
			--	복귀스텝 1단계
			--	복귀플레이카운터 클리어
			--	if(요청날짜 24시간이내, 아이디) 요청자 보상
			--else if(새로운날 and 상태 >= 1step and 복귀 >= 5)
			--	복귀스텝 + 1
			--	복귀플레이카운터 클리어
			--	if(step > 10)
			--		step = -1
			-------------------------------------------------------------------
			if(@rtnflag = @RETURN_FLAG_ON)
				begin
					--select 'DEBUG 복귀진행중(서버ON).', @newday newday, @rtnstep rtnstep, @rtnplaycnt rtnplaycnt, @condate condate, @rtndate rtndate, (getdate() - 1) '1일전', getdate() '현재'
					if(@condate <= (getdate() - @RETURN_LIMIT_DAY))
						begin
							--select 'DEBUG > 복귀 > 최초접속.', @rtngameid rtngameid
							set @rtnstep	= 1
							set @rtnplaycnt	= 0
							if(@rtngameid != '' and @rtndate >= (getdate() - 1))
								begin
									--select 'DEBUG > 상대보상.', @rtngameid rtngameid
									set @comment2 = @gameid_ + '님 복귀 보상으로 드립니다.'
									exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT,   @rtnitemcode, 0, '복귀보상', @rtngameid, ''
									exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_MESSAGE,          -1, 0, '누구복귀', @rtngameid, @comment2
								end

							-------------------------------------
							-- 복귀 인원수.
							-------------------------------------
							exec spu_DayLogInfoStatic @market_, 28, 1				-- 일 복귀수.
						end
					--else if(@newday >= 1 and @rtnstep >= 1 and @rtnplaycnt >= 5)	-- 다음날 and 복귀자 and 상품받음
					else if(@newday >= 1 and @rtnstep >= 1)							-- 다음날 and 복귀자
						begin
							--select 'DEBUG > 복귀 > 진행중.', @newday newday, @rtnstep rtnstep, @rtnplaycnt rtnplaycnt
							set @rtnstep	= @rtnstep + 1
							set @rtnplaycnt	= 0
							if(@rtnstep >= 15)
								begin
									--select 'DEBUG > 복귀 > 완료.', @newday newday, @rtnstep rtnstep, @rtnplaycnt rtnplaycnt
									set @rtnstep	= -1
								end
						end
				end


			------------------------------------------------------------------------
			-- 하트 받은 정보가 있는 경우 > 쪽지로 돌려주기.
			-- 1 -> 1개 받음.
			-----------------------------------------------------------------------
			if(@heartget > 0)
				begin
					set @heartmsg = '[알림]친구의 동물이 대표 가축과 교배한 보상과 친구들의 하트 선물로 하트' + ltrim(str(@heartget)) + '개를 받았습니다.(바로 적용되어서 들어갔습니다.)'
					exec spu_SubGiftSendNew 1, -1, 0, 'roulhear', @gameid_, @heartmsg
					set @heartget = 0
				end

			------------------------------------------------------------------------
			-- 친구 도움 요청 처리하기.
			-- 하단에서 출력해주기.
			-----------------------------------------------------------------------
			-- 도움 요청한 친구 정보 출력하기.
			DECLARE @tTempTableHelpWait TABLE(
				kakaoprofile		varchar(512)	default(''),
				kakaonickname		varchar(40)		default('')
			);
			insert into @tTempTableHelpWait(kakaoprofile, kakaonickname)
			select kakaoprofile, kakaonickname from dbo.tUserMaster
			where gameid in (select friendid FROM dbo.tKakaoHelpWait where gameid = @gameid_ and helpdate >= getdate() - 1)

			-- 처리해주기.
			exec sup_subKakaoHelpWait @gameid_

			------------------------------------------------------------------
			-- 유저 > 로그인 카운터
			------------------------------------------------------------------
			if(@logindate != @dateid8)
				begin
					exec spu_DayLogInfoStatic @market_, 14, 1               -- 일 로그인(유니크)
					exec spu_DayLogInfoStatic @market_, 12, 1               -- 일 로그인(중복)
				end
			else
				begin
					exec spu_DayLogInfoStatic @market_, 12, 1               -- 일 로그인(중복)
				end
			set @logindate = @dateid8

			------------------------------------------------------------------------
			-- 최근 학교 대항전 결과.
			-----------------------------------------------------------------------
			select top 1 @schoolresult3 = schoolresult from dbo.tSchoolResult order by schoolresult desc
			if(@schoolresult3 > @schoolresult)
				begin
					set @schoolresult2 = 1
				end
			else
				begin
					set @schoolresult2 = 0
				end
			set @schoolresult = @schoolresult3

			------------------------------------------------------------------------
			--	날짜보정 (테스트로 인해서 날짜를 조절할 경우에는 보정을 해줘야함)
			------------------------------------------------------------------------
			if( @gamemonth > 12 )
				begin
					set @gameyear	= @gameyear + 1
					set @gamemonth	= 1
				end

			------------------------------------------------------------------
			-- 유저 정보를 업데이트하기
			------------------------------------------------------------------
			--select * from dbo.tUserMaster where gameid = @gameid_

			update dbo.tUserMaster
				set
					fame			= @fame,
					famelv			= @famelv,
					famelvbest		= @famelvbest,
					market			= @market_,
					gameyear		= @gameyear,
					gamemonth		= @gamemonth,

					--유저 정보 > 최근 접속날짜 갱신, 접속 카운터 갱신
					version			= @version_,
					--gamecost		= @gamecost,
					--cashcost		= @cashcost,
					heartget		= @heartget,
					kakaomsgblocked	= case
											when (@kakaomsgblocked_ = @KAKAO_MESSAGE_NON) 	then kakaomsgblocked
											when (@kakaomsgblocked_ = @KAKAO_MESSAGE_BLOCK) then @KAKAO_MESSAGE_BLOCK
											else kakaomsgblocked
									end,
					kkhelpalivecnt	= 0,
					goldticket		= @goldticket, 		goldtickettime		= @goldtickettime,
					battleticket	= @battleticket, 	battletickettime	= @battletickettime,

					-- 배틀링크정보.
					battleanilistidx1= @battleanilistidx1, battleanilistidx2= @battleanilistidx2, battleanilistidx3= @battleanilistidx3, battleanilistidx4= @battleanilistidx4, battleanilistidx5= @battleanilistidx5,
					tslistidx1		= @tslistidx1, 		tslistidx2		= @tslistidx2, 		tslistidx3		= @tslistidx3, 		tslistidx4		= @tslistidx4, 		tslistidx5		= @tslistidx5,

					-- 오늘만 판매펫등록.
					pettodayitemcode	= @pettodayitemcode,
					pettodayitemcode2	= @pettodayitemcode2,
					logindate		= @logindate,	-- 로그인날짜별.

					-- 출석정보
					attenddate		= @attenddate,
					attendcnt		= @attendcnt,

					-- 하트 일일 권장량.
					heartsenddate	= @heartsenddate,
					heartsendcnt 	= @heartsendcnt,

					-- 일일룰렛등장값
					zcpappearcnt	= @zcpappearcnt,

					-- 동물 일일전송량.
					anibuydate		= @anibuydate,
					anibuycnt 		= @anibuycnt,

					-- 생애첫결제 클리어횟수.
					eventspot08		= @eventspot08,

					-- 무료룰렛
					wheeltodaydate	= @wheeltodaydate,
					wheeltodaycnt 	= @wheeltodaycnt,

					-- 퀘스트
					comreward		= @comreward,

					-- 야바위 정보.
					yabauidx		= @yabauidx,

					-- 전주 학교대항, 친구랭킹 전송했다.
					schoolresult	= @schoolresult,

					-- 업글정보
					feedmax			= @feedmax,
					heartmax		= @heartmax,
					fpointmax		= @fpointmax,
					housestate 		= @housestate, 		housestep 		= @housestep,
					tankstate 		= @tankstate, 		tankstep 		= @tankstep,
					bottlestate 	= @bottlestate, 	bottlestep 		= @bottlestep,
					pumpstate 		= @pumpstate, 		pumpstep 		= @pumpstep,
					transferstate 	= @transferstate, 	transferstep 	= @transferstep,
					purestate 		= @purestate, 		purestep 		= @purestep,
					freshcoolstate 	= @freshcoolstate, 	freshcoolstep 	= @freshcoolstep,

					-- 소비아이템
					bulletlistidx	= @bulletlistidx,
					vaccinelistidx	= @vaccinelistidx,
					albalistidx		= @albalistidx,
					boosterlistidx	= @boosterlistidx,

					-- 복귀정보저장.
					--rtngameid		= @rtngameid,
					--rtndate		= @rtndate,
					rtnstep			= @rtnstep,
					rtnplaycnt		= @rtnplaycnt,

					kakaomsginvitetodaycnt 	= @kakaomsginvitetodaycnt,
					kakaomsginvitetodaydate = @kakaomsginvitetodaydate,
					kakaoprofile			= @kakaoprofile,
					sid						= sid + 1,

					condate			= getdate(),			-- 최종접속일
					concnt			= concnt + 1			-- 접속횟수 +1
			where gameid = @gameid_

			--------------------------------------------------------------------
			---- 유저의 스테미너가 완충되면 > 푸쉬정보 날려주라 기록하기
			--------------------------------------------------------------------
			--if(not exists(select top 1 * from dbo.tActionScheduleData where gameid = @gameid_))
			--	begin
			--		insert into tActionScheduleData(gameid) values(@gameid_)
			--	end

			------------------------------------------------
			---- 랭킹 초기화날짜(매주 월요일).
			-----------------------------------------------
			--select @dw = DATEPART(dw, @curdate)
			--set @curdate = case
			--					when @dw = 1 then  @curdate
			--					else			  (@curdate - DATEPART(dw, @curdate) + 2) + 6
			--			   end
			--set @schoolinitdate = CONVERT(char(10), @curdate, 25) + ' 23:59:00'

			------------------------------------------------
			---- 랭킹 초기화날짜(매주 토요일).
			-----------------------------------------------
			select @dw = DATEPART( dw, @curdate )
			set @curdate = @curdate + ( 7 - @dw )
			set @schoolinitdate = CONVERT( char(10), @curdate, 25 ) + ' 23:59:00'

			-- 학교이름.
			set @schoolname = ''
			select @schoolname = isnull(schoolname, '') from dbo.tSchoolBank where schoolidx = @schoolidx

			------------------------------------------------------------------------
			-- 전국 목장 정보 > 수확물 정보가 있는가? > 맥스로 있는가?
			-----------------------------------------------------------------------
			--if(exists(select top 1 * from
			--								(select DATEDIFF(hh, incomedate, getdate()) * param1 as hourcoin2, b.param2 maxcoin from
			--									(select * from dbo.tUserGameMTBaseball where gameid = @gameid_ and buystate = 1) a
			--								LEFT JOIN
			--									(select * from dbo.tItemInfo where subcategory = 69) b
			--								ON a.itemcode = b.itemcode) as f
			--							where hourcoin2 >= maxcoin ))
			--	begin
			--		set @farmharvest	= 1
			--	end
			--else
			--	begin
			--		set @farmharvest	= 0
			--	end

			------------------------------------------------------------------------
			-- 친구들중에 수락 대기중인 친구가 있는가?
			-----------------------------------------------------------------------
			if(exists(select top 1 * from dbo.tUserFriend where gameid = @gameid_ and state = 1))
				begin
					set @friendinvite = 1
				end

			------------------------------------------------------------------------
			-- 하트 전송 가능한 친구.
			-----------------------------------------------------------------------
			if(exists(select top 1 * from dbo.tUserFriend where gameid = @gameid_ and friendid != @sysfriendid and state = 2 and senddate <= getdate() - 1))
				begin
					set @sendheart = 1
				end

			----------------------------------------------
			-- 유저 정보
			---------------------------------------------
			select
				*,
				@SKILL_ATK_1 atk1, 	@SKILL_ATK_2 atk2, 	@SKILL_ATK_3 atk3,
				@SKILL_DEF_1 def1, 	@SKILL_DEF_2 def2, 	@SKILL_DEF_3 def3,
				@SKILL_HP_1 hp1, 	@SKILL_HP_2 hp2, 	@SKILL_HP_3 hp3, 		@SKILL_HP_1_TIME hptime1, 		@SKILL_HP_2_TIME hptime2, 		@SKILL_HP_3_TIME hptime3,
				@SKILL_TURN_1 turn1,@SKILL_TURN_2 turn2,@SKILL_TURN_3 turn3, 	@SKILL_TURN_1_TIME turntime1,	@SKILL_TURN_2_TIME turntime2,	@SKILL_TURN_3_TIME turntime3,
				@DEALER_PLUS_STEP1 dpstep1, @DEALER_PLUS_STEP2 dpstep2, @DEALER_PLUS_STEP3 dpstep3, @DEALER_PLUS_STEP4 dpstep4, @DEALER_PLUS_STEP5 dpstep5,
				@DEALER_PLUS_STEP6 dpstep6, @DEALER_PLUS_STEP7 dpstep7, @DEALER_PLUS_STEP8 dpstep8, @DEALER_PLUS_STEP9 dpstep9, @DEALER_PLUS_STEPM dpstepM,
				@ANIMAL_COMPOSE_LEVEL anicomposelevel,
				@FARM_BATTLE_OPEN_LV farmbattleopenlv,
				@NEW_START_INIT_LV newstartinitlv,
				@ANIMAL_LIMIT_TREASURE_VAL treasureval,
				@kkhelpalivecnt kkhelpalivecnt2,
				@attendnewday attendnewday,
				@farmharvest farmharvest,
				@sendheart sendheart,
				@friendinvite friendinvite,
				@schoolresult2 schoolresult2,
				@schoolname	schoolname,
				@schoolinitdate userrankinitdate,
				@schoolinitdate schoolinitdate,
				@BOARD_STATE_REWARD_GAMECOST mboardreward,
				@GAME_START_YEAR startyear, @GAME_START_MONTH startmonth,
				@roulaccprice roulaccprice, @roulaccsale roulaccsale,
				((famelv / 10 + 1)*(famelv / 10 + 1) * @YABAU_CHANGE_DANGA) yabauchange,
				case when famelv <= 50 then @USED_FRIEND_POINT else (@USED_FRIEND_POINT + (famelv - 50)*20) end needfpoint
			from dbo.tUserMaster where gameid = @gameid_

			--------------------------------------------------------------
			-- 유저 보유템 전체 리스트
			-- 동물(동물병원[최근것], 인벤, 필드, 대표), 소비템, 악세사리
			--------------------------------------------------------------
			select * from dbo.tUserItem
			where gameid = @gameid_ and invenkind in (@USERITEM_INVENKIND_ANI, @USERITEM_INVENKIND_CONSUME, @USERITEM_INVENKIND_PET, @USERITEM_INVENKIND_STEMCELL, @USERITEM_INVENKIND_TREASURE )
			order by diedate desc, invenkind, fieldidx, itemcode

			--------------------------------------------------------------
			-- 유저 경작지 정보
			--------------------------------------------------------------
			select * from dbo.tUserSeed
			where gameid = @gameid_
			order by seedidx asc

			--------------------------------------------------------------
			-- 유저 친구정보
			-- 카피 & 사라지면 대처동물로.(없으면 기초동물로 교체)
			--------------------------------------------------------------
			exec spu_subFriendList @gameid_

			--------------------------------------------------------------
			-- 카톡 초대친구들
			--------------------------------------------------------------
			select * from dbo.tKakaoInvite where gameid = @gameid_

			--------------------------------------------------------------
			-- 유저 선물/쪽지(존재, 쪽지기능보유 통합)
			--------------------------------------------------------------
			exec spu_GiftList @gameid_

			----------------------------------------------------------------
			----	도감 : 테이블.(삭제함)
			----------------------------------------------------------------
			--select
			--	param1 dogamidx, itemname dogamname,
			--	param2 animal0, param3 animal1,
			--	param4 animal2, param5 animal3,
			--	param6 animal4, param7 animal5,
			--	param8 rewarditemcode, param9 rewardvalue
			--from dbo.tItemInfo
			--where subcategory = @ITEM_MAINCATEGORY_DOGAM

			--------------------------------------------------------------
			--	펫도감 : 획득한 펫.
			--------------------------------------------------------------
			select * from dbo.tDogamListPet where gameid = @gameid_ order by itemcode asc

			--------------------------------------------------------------
			--	도감 : 획득한 동물.
			--------------------------------------------------------------
			select * from dbo.tDogamList where gameid = @gameid_ order by itemcode asc

			--------------------------------------------------------------
			--	도감 : 보상 받음 도감인덱스 번호.
			--------------------------------------------------------------
			select * from dbo.tDogamReward where gameid = @gameid_ order by dogamidx asc

			--------------------------------------------------------------
			-- 게임정보 > 캐쉬구매(+a%), 환전(+b%), 하트(+c%), 건초(+d%) 일일출석, 각맥스
			-- iPhone은 정책 때문에 선물 지급을 못한다.
			--------------------------------------------------------------
			--select 'DEBUG 세팅정보1'
			if(@market_ = @MARKET_IPHONE)
				begin
					set @RECOMMAND_MESSAGE = @RECOMMAND_MESSAGE_IPHONE
				end
			else
				begin
					if(@RECOMMAND_MESSAGE_SERVERID = @BOOL_TRUE)
						begin
							set @RECOMMAND_MESSAGE = @RECOMMAND_MESSAGE + @RECOMMAND_MESSAGE_ANDROIDPLUS + @gameid_ + '[-]'
						end
					else
						begin
							set @RECOMMAND_MESSAGE = @RECOMMAND_MESSAGE
						end
				end

			-----------------------------------------------
			---- 시스템 정보 표시.
			---- EVENT 7.24 ~ 8.6 	>
			----	3. Naver캐쉬		=> 네이버 캐쉬 2배
			-----------------------------------------------
			select
				top 1 *,
				@housestepmax housestepmax2,
				@tankstepmax tankstepmax2,
				@bottlestepmax bottlestepmax2,
				@pumpstepmax pumpstepmax2,
				@transferstepmax transferstepmax2,
				@purestepmax purestepmax2,
				@freshcoolstepmax freshcoolstepmax2,
				@RECOMMAND_MESSAGE recommendmsg,
				@KAKAO_MESSAGE_INVITE_ID kakaoinviteid,
				@KAKAO_MESSAGE_PROUD_ID kakaoproudid,
				@KAKAO_MESSAGE_HEART_ID kakaoheartid,
				@KAKAO_MESSAGE_HELP_ID kakaohelpid,
				@KAKAO_MESSAGE_RETURN_ID kakaoreturnid
			from dbo.tSystemInfo
			order by idx desc
			--select 'DEBUG 세팅정보2'

			---------------------------------------------
			-- 패키지상품.
			---------------------------------------------
			set @strmarket = '%' + ltrim(rtrim(str(@market_))) + '%'

			select top 1 * from dbo.tSystemPack
			where famelvmin <= @famelv
				and @famelv <= famelvmax
				and packstate = 1
				and packmarket like @strmarket
				--and (ABS(CAST( (BINARY_CHECKSUM(*) * RAND()) as int)) % 100) <= 100
				order by newid()

			---------------------------------------------
			-- 랭킹.
			---------------------------------------------
			exec spu_subFriendRank @gameid_, 1

			---------------------------------------------
			-- 전국 목장 플레이 횟수 초기화
			-- 전국 목장.
			---------------------------------------------
			if(@newday >= 1)
				begin
					set @vip_plus = dbo.fun_GetVIPPlus( 8, @cashpoint, @FARM_BATTLE_PLAYCNT_MAX)		-- 목장횟수

					update dbo.tUserGameMTBaseball
						set
							playcnt = @FARM_BATTLE_PLAYCNT_MAX + @vip_plus
					where gameid = @gameid_ and playcnt <= @FARM_BATTLE_PLAYCNT_MAX
				end

			-- 리스트 전송.
			exec spu_UserGameMTBaseballListNew @gameid_, 1, @market_, @version_

			---------------------------------------------
			-- 에피소드 컨테스트 결과.
			---------------------------------------------
			select * from dbo.tEpiReward
			where gameid = @gameid_
			order by idx asc

			---------------------------------------------
			-- 전체랭킹과 유저배틀랭킹.
			---------------------------------------------
			exec spu_subUserTotalRank @gameid_, 1

			---------------------------------------------
			-- 지난 학교랭킹(학교 + 내소속).
			---------------------------------------------
			exec spu_SchoolRank 11, -1, @gameid_

			---------------------------------------------
			-- 도움준 친구들.
			---------------------------------------------
			select * from @tTempTableHelpWait

			---------------------------------------------
			-- 행운의 집.
			---------------------------------------------
			select top 1 * from dbo.tSystemYabau where idx = @yabauidx

			---------------------------------------------
			-- 보유보물보상.
			---------------------------------------------
			select * from @tTempTreasureReward

			---------------------------------------------
			-- 동물뽑기.
			---------------------------------------------
			--select 'DEBUG ', @strmarket strmarket,
			set @curdate = getdate()

			-- lv -> 가격.
			select dbo.fun_GetRoulPrice( @MODE_ROULETTE_GRADE1_GAMECOST, @famelv) roulgrade1gamecost,
				   dbo.fun_GetRoulPrice( @MODE_ROULETTE_GRADE1_HEART, 	 @famelv) roulgrade1heart,
				   dbo.fun_GetRoulPrice( @MODE_ROULETTE_GRADE2_CASHCOST, @famelv) roulgrade2cashcost,
				   dbo.fun_GetRoulPrice( @MODE_ROULETTE_GRADE4_CASHCOST, @famelv) roulgrade4cashcost

			-- 정보.
			select
				top 1 *,
				case when (@curdate > roulstart and @curdate <= roulend) then roulsaleflag	else -1 end roulsaleflag2,
				case when (@curdate > roulstart and @curdate <= roulend) then roulflag 		else -1 end roulflag2,
				case when (@curdate > roulstart and @curdate <= roulend) then roultimeflag 	else -1 end roultimeflag2,
				case when (@curdate > roulstart and @curdate <= roulend) then pmgauageflag 	else -1 end pmgauageflag2
			from dbo.tSystemRouletteMan
			where roulmarket like @strmarket
			order by idx desc

			---------------------------------------------
			-- 보물뽑기.
			---------------------------------------------
			-- lv -> 가격.
			select dbo.fun_GetTreasurePrice( @MODE_TREASURE_GRADE1_GAMECOST, @famelv) tsgrade1gamecost,
				   dbo.fun_GetTreasurePrice( @MODE_TREASURE_GRADE1_HEART, 	 @famelv) tsgrade1heart,
				   dbo.fun_GetTreasurePrice( @MODE_TREASURE_GRADE2_CASHCOST, @famelv) tsgrade2cashcost,
				   dbo.fun_GetTreasurePrice( @MODE_TREASURE_GRADE3_CASHCOST, @famelv) tsgrade4cashcost

			-- 정보.
			select
				top 1 *,
				case when (@curdate > roulstart and @curdate <= roulend) then tsupgradesaleflag	else -1 end tsupgradesaleflag2,
				case when (@curdate > roulstart and @curdate <= roulend) then roulsaleflag	else -1 end roulsaleflag2,
				case when (@curdate > roulstart and @curdate <= roulend) then roulflag 		else -1 end roulflag2,
				case when (@curdate > roulstart and @curdate <= roulend) then roultimeflag 	else -1 end roultimeflag2,
				case when (@curdate > roulstart and @curdate <= roulend) then pmgauageflag 	else -1 end pmgauageflag2
			from dbo.tSystemTreasureMan
			where roulmarket like @strmarket
			order by idx desc

			---------------------------------------------
			-- 생애첫결제 결제내역 아이템코드 (30일 유효).
			---------------------------------------------
			select distinct itemcode from dbo.tCashFirstTimeLog
			where gameid = @gameid_ and writedate >= getdate() - 30
			order by itemcode asc

			---------------------------------------------
			-- 룰렛정보.
			---------------------------------------------
			select top 8 * from dbo.tSystemWheelInfo where kind = 20 order by idx desc		-- 무료.

			select top 8 * from dbo.tSystemWheelInfo where kind = 21 order by idx desc		-- 유료.

			---------------------------------------------
			-- VIP 정보.
			---------------------------------------------
			select * from dbo.tSystemVIPInfo order by idx asc


			---------------------------------------------
			-- 랭킹대전 컬럼이름. 정보.
			-- 금요일만 수집(저장) > 토요일 연산(금 -> 토스케쥴)
			-- 일	월	화	수	목	금	토
			-- (1) 	2  (3) 	4 	5  (6) 	7
			-- 1 	2 	3 	4 	5 	6 	7
			-- 8 	9 	10 	11 	12 	13 	14
			-- 15 	16 	17 	18 	19 	20 	21
			-- 22 	23 	24 	25 	26 	27 	28
			-- C		C 	A	C	C	A	C
			---------------------------------------------
			set @dw = DATEPART(dw, getdate())

			select '판매수익' rkname1,
				   '생산배럴' rkname2,
				   '배틀 포인트' rkname3,
				   '교배,보물포인트' rkname4,
				   '친구포인트' rkname5,
				   '룰렛포인트' rkname6,
				   '늑대포인트' rkname7,
					case when @dw in (1, 3, 6) then 1 else -1 end rking


			select '매주 일, 화, 금요일마다 2팀으로\n'
				   + '나누어 랭킹 배틀을 합니다\n'
				   + '(출석룰렛을 돌리시면 랭킹전에 참여가 됩니다.)\n\n'
				   + '[승리팀 전원]\n'
				   + '1. 합성의훈장, 승급의 꽃 x 150\n'
				   + '~ 5. 합성의훈장, 승급의 꽃 x 130\n'
				   + '~ 10. 합성의훈장, 승급의 꽃 x 100\n'
				   + '~ 100. 합성의훈장, 승급의 꽃 x 50\n'
				   + '기타등수 합성의훈장, 승급의 꽃 x 30\n\n'
				   + '- 대전항목 -\n\n'
				   + '판매수익 : 상인과 거래를 해서 발생하는 수익포인트\n\n'
				   + '생산배럴 : 동물들에게서 우유 생산한 배럴 포인트\n\n'
				   + '배틀 포인트 : 목장배틀과 유저 배틀을 하면서 획득한 포인트\n\n'
				   + '교배,보물포인트 : 동물 교배와 보물 뽑기를 통해서 누적된 포인트\n\n'
				   + '친구포인트 : 친구에게 하트를 보내고 받거나 친구 초대 포인트\n\n'
				   + '룰렛포인트 : 룰렛을 돌린 횟수\n\n'
				   + '늑대포인트 : 늑대 잡은 포인트\n'
				   + '(위의 보상과 내용은 변경될 수 있습니다.)'
				   rkinfo

			---------------------------------------------
			-- 랭킹대전 랭킹.
			---------------------------------------------
			exec spu_subRKRank @gameid_

			---------------------------------------------
			-- 짜요쿠폰조각룰렛.
			---------------------------------------------
			select top 8 * from dbo.tSystemZCPInfo where kind = 0 order by idx desc

			---------------------------------------------
			-- 짜요장터.
			---------------------------------------------
			select * from dbo.tZCPMarket
			where zcpflag = 1 and getdate() < expiredate
			order by kind asc, zcporder desc
		END

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
End



