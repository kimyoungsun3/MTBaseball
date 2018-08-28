/*
select * from dbo.tFVUserMaster where gameid = 'xxxx'
exec spu_FVLogin 'xxxx', '049000s1i0n7t8445289', 1, 101, '', '', -1, -1			-- 정상유저
exec spu_FVLogin 'xxxx', '049000s1i0n7t8445288', 1, 101, '', '', -1, -1			-- 비번틀림
exec spu_FVLogin 'xxxx0', '049000s1i0n7t8445289', 1, 101, '', '', -1, -1			-- 없는유저
exec spu_FVLogin 'xxxx', '049000s1i0n7t8445289', 1, 100, '', '', -1, -1			-- 마켓버젼낮음
exec spu_FVLogin 'xxxx3', '049000s1i0n7t8445289', 1, 101, '', '', -1, -1			-- 블럭유저
exec spu_FVLogin 'xxxx4', '049000s1i0n7t8445289', 1, 101, '', '', -1, -1			-- 삭제유저
update dbo.tFVUserMaster set cashcopy = 3 where gameid = 'xxxx5'		-- 캐쉬카피 > 블럭처리
exec spu_FVLogin 'xxxx5', '049000s1i0n7t8445289', 1, 101, '', '',-1,  -1
update dbo.tFVUserMaster set resultcopy = 100 where gameid = 'xxxx6'	-- 결과키피 > 블럭처리
exec spu_FVLogin 'xxxx7', '049000s1i0n7t8445289', 1, 101, '', '', -1, -1

exec spu_FVLogin 'xxxx', '049000s1i0n7t8445289', 1, 199, '', '', -1, -1			-- 정상유저
exec spu_FVLogin 'xxxx2', '049000s1i0n7t8445289', 5, 119, '', '', -1, -1			-- 정상유저
exec spu_FVLogin 'xxxx3', '049000s1i0n7t8445289', 1, 199, '', '', -1, -1			-- 정상유저
exec spu_FVLogin 'xxxx6', '049000s1i0n7t8445289', 1, 199, '', '', -1, -1			-- 정상유저
exec spu_FVLogin 'guest91738', '049000s1i0n7t8445289', 1, 199, '', '', -1, -1		-- 정상유저
exec spu_FVLogin 'farm40', '1294036k8k4s2f841412', 5, 199, '', '', -1, -1			-- 정상유저


update dbo.tFVUserMaster set attenddate = getdate() - 20 where gameid = 'xxxx2'
delete from dbo.tFVGiftList where gameid = 'xxxx2'
exec spu_FVLogin 'xxxx2', '049000s1i0n7t8445289', 1, 110, '', '', -1, -1			-- 정상유저


update dbo.tFVUserMaster set attenddate = getdate() - 1 where gameid = 'xxxx2'
exec spu_FVLogin 'xxxx2', '049000s1i0n7t8445289', 1, 103, '', '', -1, -1			-- 정상유저
*/
use Farm
Go

IF OBJECT_ID ( 'dbo.spu_FVLogin', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVLogin;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_FVLogin
	@gameid_								varchar(60),					-- 게임아이디
	@password_								varchar(20),					-- 암호화해서저장, 유저패스워가 해킹당해도 안전
	@market_								int,							-- (구매처코드)
	@version_								int,							-- 클라버젼
	@kakaoprofile_							varchar(512),
	@kakaonickname_							varchar(40),
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

	--가입 오류.
	declare @RESULT_ERROR_ID_DUPLICATE			int				set @RESULT_ERROR_ID_DUPLICATE			= -2

	-- 로그인 오류.
	declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--블럭유저 > 팝업처리후 인트로로 빼버린다.
	declare @RESULT_ERROR_DELETED_USER 			int				set @RESULT_ERROR_DELETED_USER			= -12			--삭제유저 > 팝업처리후 인트로로 빼버린다.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함
	declare @RESULT_ERROR_NOT_FOUND_PASSWORD	int				set @RESULT_ERROR_NOT_FOUND_PASSWORD	= -17
	declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--서버를 점검하고 있다.
	declare @RESULT_NEWVERION_CLIENT_DOWNLOAD 	int				set @RESULT_NEWVERION_CLIENT_DOWNLOAD	= -15			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 링크처리.
	--declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 종료.

	-- 게임중에 부족.
	--declare @RESULT_ERROR_HEART_LACK			int				set @RESULT_ERROR_HEART_LACK			= -20			--하트이 부족하다.
	--declare @RESULT_ERROR_GAMECOST_LACK		int				set @RESULT_ERROR_GAMECOST_LACK			= -21			--실버가 부족하다.
	--declare @RESULT_ERROR_CASHCOST_LACK		int				set @RESULT_ERROR_CASHCOST_LACK			= -22			--골드가 부족하다.
	--declare @RESULT_ERROR_ITEM_LACK			int				set @RESULT_ERROR_ITEM_LACK				= -23			--아이템이부족하다.

	-- 캐쉬구매.
	--declare @RESULT_ERROR_CASH_COPY			int				set @RESULT_ERROR_CASH_COPY				= -40
	--declare @RESULT_ERROR_CASH_OVER			int				set @RESULT_ERROR_CASH_OVER				= -41
	--declare @RESULT_ERROR_MONTH_OVER			int				set @RESULT_ERROR_MONTH_OVER			= -42			--한달동안 구매한도를 검사

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

	-- (무료/유료코드)
	--declare @BUYTYPE_FREE						int					set @BUYTYPE_FREE 					= 0	-- 무료가입 : 리워드 최소
	--declare @BUYTYPE_PAY						int					set @BUYTYPE_PAY 					= 1	-- 유료가입 : 리워드 많음
	--declare @BUYTYPE_PAY2						int					set @BUYTYPE_PAY2 					= 2	-- 유료가입(재가입)

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

	---- 아이템 대분류
	--declare @ITEM_MAINCATEGORY_ANI			int					set @ITEM_MAINCATEGORY_ANI 					= 1 	-- 가축(1)
	--declare @ITEM_MAINCATEGORY_CONSUME		int					set @ITEM_MAINCATEGORY_CONSUME 				= 3 	--소모품(3)
	--declare @ITEM_MAINCATEGORY_ACC			int					set @ITEM_MAINCATEGORY_ACC 					= 4 	--액세서리(4)
	--declare @ITEM_MAINCATEGORY_HEART			int					set @ITEM_MAINCATEGORY_HEART 				= 40 	--하트(40)
	--declare @ITEM_MAINCATEGORY_CASHCOST		int					set @ITEM_MAINCATEGORY_CASHCOST 			= 50 	--캐쉬선물(50)
	--declare @ITEM_MAINCATEGORY_GAMECOST		int					set @ITEM_MAINCATEGORY_GAMECOST 			= 51 	--코인선물(51)
	--declare @ITEM_MAINCATEGORY_ROULETTE		int					set @ITEM_MAINCATEGORY_ROULETTE 			= 52 	--뽑기(52)
	--declare @ITEM_MAINCATEGORY_CONTEST		int					set @ITEM_MAINCATEGORY_CONTEST 				= 53 	--대회(53)
	--declare @ITEM_MAINCATEGORY_UPGRADE		int					set @ITEM_MAINCATEGORY_UPGRADE 				= 60 	--업글(60)
	--declare @ITEM_MAINCATEGORY_INVEN			int					set @ITEM_MAINCATEGORY_INVEN 				= 67 	--인벤확장(67)
	--declare @ITEM_MAINCATEGORY_SEEDFIEL		int					set @ITEM_MAINCATEGORY_SEEDFIEL 			= 68 	--경작지확장(68)
	--declare @ITEM_MAINCATEGORY_DOGAM			int					set @ITEM_MAINCATEGORY_DOGAM 				= 818 	--도감(818)
	--declare @ITEM_MAINCATEGORY_GAMEINFO		int					set @ITEM_MAINCATEGORY_GAMEINFO 			= 500 	--정보수집(500)

	-- 아이템 소분류
	declare @ITEM_SUBCATEGORY_UPGRADE_HOUSE		int					set @ITEM_SUBCATEGORY_UPGRADE_HOUSE 		= 60 -- 집
	declare @ITEM_SUBCATEGORY_USERFARM			int					set @ITEM_SUBCATEGORY_USERFARM	 			= 69	-- 전국목장
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
	declare @GAME_INVEN_ANIMAL_BASE				int					set @GAME_INVEN_ANIMAL_BASE					= 10	-- 대표1 + 동물9
	declare @GAME_INVEN_CUSTOME_BASE			int					set @GAME_INVEN_CUSTOME_BASE				= 8
	declare @GAME_INVEN_ACC_BASE				int					set @GAME_INVEN_ACC_BASE					= 6

	-- 보드에 글쓰기.
	--declare @BOARD_STATE_NON					int					set @BOARD_STATE_NON				= 0
	--declare @BOARD_STATE_REWARD				int					set @BOARD_STATE_REWARD				= 1
	declare @BOARD_STATE_REWARD_GAMECOST		int					set @BOARD_STATE_REWARD_GAMECOST	= 600

	-- 카카오톡 정보.
	declare @KAKAO_MESSAGE_INVITE_ID			int					set @KAKAO_MESSAGE_INVITE_ID 				= 907
	declare @KAKAO_MESSAGE_PROUD_ID				int					set @KAKAO_MESSAGE_PROUD_ID 				= 980
	declare @KAKAO_MESSAGE_HEART_ID				int					set @KAKAO_MESSAGE_HEART_ID 				= 981
	declare @KAKAO_MESSAGE_HELP_ID				int					set @KAKAO_MESSAGE_HELP_ID 					= 1047
	declare @KAKAO_MESSAGE_RETURN_ID			int					set @KAKAO_MESSAGE_RETURN_ID				= 1856

	--메세지 수신여부.
	declare @KAKAO_MESSAGE_BLOCKED_FALSE		int 				set @KAKAO_MESSAGE_BLOCKED_FALSE 		= -1
	declare @KAKAO_MESSAGE_BLOCKED_TRUE			int					set @KAKAO_MESSAGE_BLOCKED_TRUE 		= 1
	declare @KAKAO_MESSAGE_BLOCKED_NON			int					set @KAKAO_MESSAGE_BLOCKED_NON			= 0

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

	-- 신규목장.
	declare @NEW_FARM 							int 				set @NEW_FARM 						= 6952

	-- 기타 상수값들.
	declare @YABAU_CHANGE_DANGA					int					set @YABAU_CHANGE_DANGA				= 100		-- 행운의 주사위 상수값
	declare @USED_FRIEND_POINT					int					set @USED_FRIEND_POINT				= 100		-- 친구포인트 차감.
	-------------------------------------------------------------------
	-- 로그인만 하면 매일 매일 소모템을 쏜다~~~
	--	 1일 : 2201	일반 교배 티켓 (2개)
	--	 2일 : 1003	알바의 귀재 패키지 (4개)
	--	 3일 : 1202	부활석 (3개)
	-------------------------------------------------------------------
	-- eventonedailystate
	declare @EVENT_STATE_NON					int					set @EVENT_STATE_NON				= 0
	declare @EVENT_STATE_YES					int					set @EVENT_STATE_YES				= 1
	declare @EVENT01_ITEM1						int					set @EVENT01_ITEM1					= 2201	-- 일반 교배 티켓 (2개)
	declare @EVENT01_ITEM2						int					set @EVENT01_ITEM2					= 1003	-- 알바의 귀재 패키지 (4개)
	declare @EVENT01_ITEM3						int					set @EVENT01_ITEM3					= 1202	-- 부활석 (3개)

	----------------------------------------------
	-- Naver 이벤트 처리
	--	기간 : 7.24 ~ 8.6
	--	발표 : 8.11
	--	1. 가입시 ...		=> 시크한 양1마리, 수정 60개
	--						   02_01가입(정식버젼).sql
	--	2. 결제 2배			=> 결제하면 2배 이벤트
	--						   21_01캐쉬(인증서).sql
	--						   21_02캐쉬(관리페이지).sql
	--	3. Naver캐쉬		=> 네이버 캐쉬
	------------------------------------------------
	--declare @EVENT02_START_DAY				datetime			set @EVENT02_START_DAY			= '2014-06-13 20:00'
	--declare @EVENT02_END_DAY					datetime			set @EVENT02_END_DAY			= '2014-08-06 23:59'

	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @sysfriendid			varchar(20)				set @sysfriendid 	= 'farmgirl'
	declare @comment				varchar(512)			set @comment		= '로그인'
	declare @comment2				varchar(128)
	declare @gameid 				varchar(60)
	declare @password 				varchar(20)
	declare @condate				datetime
	declare @deletestate			int
	declare @blockstate				int
	declare @cashcopy				int
	declare @resultcopy				int
	declare @cashcost				int
	declare @gamecost				int
	declare @buytype				int
	declare @market					int						set @market			= @MARKET_GOOGLE
	declare @version				int						set @version		= 101
	declare @gameyear				int						set @gameyear		= @GAME_START_YEAR
	declare @gamemonth				int						set @gamemonth		= @GAME_START_MONTH

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
			@invenstepmax			int,	@invencountmax			int,	@seedfieldmax			int,
			@attend1				int, 	@attend2				int, 	@attend3				int,			@attend4			int, 		@attend5			int

	-- 소비아이템
	declare @bulletlistidx			int,
			@vaccinelistidx			int,
			@albalistidx			int,
			@boosterlistidx			int,
			@tmpcnt					int,
			@invenkind 				int

	declare @newday					int
	declare @pettodayitemcode		int						set @pettodayitemcode	= -1		-- 오늘만 추천 펫
	declare @pettodayitemcode2		int						set @pettodayitemcode2	= -1		--        체험 펫

	-- 출석일
	declare @attenddate				datetime,
			@attendcnt				int,
			@attendcntview			int,
			@attendnewday			int

	declare @curversion				int						set @curversion		= -1
	declare @cursyscheck			int

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
	declare @kakaonickname			varchar(40)
	declare @kkhelpalivecnt			int				set @kkhelpalivecnt				= 0

	-- 악세사리 정보 가격.
	declare @roulaccprice			int				set @roulaccprice 				= 10 -- 악세10수정.
	declare @roulaccsale			int				set @roulaccsale 				= 10 -- 10%.

	-- 이벤트1 > 로그인만하면
	declare @eventonedailystate		int				set @eventonedailystate 		= @EVENT_STATE_NON
	declare @eventonedailyloop		int

	-- 이벤트2 > 지정된 시간에 로그인하면 선물지급~~~
	declare @eventstatemaster		int				set @eventstatemaster			= @EVENT_STATE_NON
	declare @eventidx				int				set @eventidx					= -1
	declare @eventitemcode			int				set @eventitemcode				= -1
	declare @eventsender 			varchar(20)		set @eventsender				= '짜요 소녀'
	declare @strmarket				varchar(40)

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
		@buytype		= isnull(buytype, 0),
		@feedmax		= feedmax,
		@heartmax		= heartmax,
		@fpointmax		= fpointmax,
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

		@kakaomsginvitetodaycnt 	= kakaomsginvitetodaycnt,
		@kakaomsginvitetodaydate	= kakaomsginvitetodaydate,
		@kakaoprofile				= kakaoprofile,
		@kakaonickname				= kakaonickname,
		@kkhelpalivecnt				= kkhelpalivecnt,

		@rtngameid		= rtngameid, 		@rtndate	= rtndate,
		@rtnstep		= rtnstep, 			@rtnplaycnt	= rtnplaycnt,

		@pettodayitemcode	= pettodayitemcode,
		@pettodayitemcode2	= pettodayitemcode2,
		@attenddate 	= attenddate, 		@attendcnt 		= attendcnt
	from dbo.tFVUserMaster
	where gameid = @gameid_
	--select 'DEBUG 유저정보', @gameid gameid, @blockstate blockstate, @deletestate deletestate, @cashcopy cashcopy, @resultcopy resultcopy, @gamecost gamecost, @cashcost cashcost, @attenddate attenddate, @attendcnt attendcnt

	------------------------------------------------
	--	3-3. 공지사항 체크
	------------------------------------------------
	select top 1 @cursyscheck = syscheck, @curversion = version from dbo.tFVNotice
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
			update dbo.tFVUserMaster
				set
					blockstate = @BLOCK_STATE_YES,
					cashcopy = 0
			where gameid = @gameid_

			-- 아이템3회 카피에 대한 블럭처리
			insert into dbo.tFVUserBlockLog(gameid, comment)
			values(@gameid_, '(캐쉬결재)를  '+ltrim(rtrim(str(@cashcopy)))+'회 이상 카피를 해서 로그인시 시스템에서 블럭 처리했습니다.')
		END
	else if(@resultcopy >= 20)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_BLOCK_USER
			set @comment 	= '경기결과복제를 '+ltrim(rtrim(str(@resultcopy)))+'회이상 시도했다. > 블럭처리하자!!'
			--select 'DEBUG ', @comment

			--결과복제를 xx회 이상했다. > 블럭처리, 블럭로그기록
			update dbo.tFVUserMaster
				set
					blockstate = @BLOCK_STATE_YES,
					resultcopy = 0
			where gameid = @gameid_

			-- 아이템3회 카피에 대한 블럭처리
			insert into dbo.tFVUserBlockLog(gameid, comment)
			values(@gameid_, '경기결과복제를 '+ltrim(rtrim(str(@resultcopy)))+'회이상 시도해서 로그인시 시스템에서 블럭 처리했습니다.')
		END
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '로그인 정상처리'
			--select 'DEBUG ', @comment
		END


	if(@nResult_ = @RESULT_SUCCESS)
		BEGIN
			-----------------------------------------------
			-- 결과코드처리.
			-----------------------------------------------
			select @nResult_ rtn, @comment comment

			------------------------------------------------
			-- 마켓 이동 정보 수집
			------------------------------------------------
			--select 'DEBUG ', @market_ market_, @version_ version_, @market market, @version version
			 if(@market != @market_)
				begin
					insert into dbo.tFVUserBeforeInfo(gameid,  market, marketnew,  version,  fame,  famelv,  famelvbest,  gameyear,  gamemonth)
					values(                        @gameid, @market, @market_,  @version, @fame, @famelv, @famelvbest, @gameyear, @gamemonth)
				end

			------------------------------------------------
			-- 농장리스트 추가된것이 없는 사람 추가하기.
			-- 기존 목장		     ~ 6928
			-- 1차 업데이트 	6929 ~ 6943
			-- 2차 업데이트 	6944 ~ 6952
			------------------------------------------------
			if(not exists(select top 1 * from dbo.tFVUserFarm where gameid = @gameid_ and itemcode = @NEW_FARM))
				begin
					select @farmidx = max(farmidx) from dbo.tFVUserFarm where gameid = @gameid_

					insert into dbo.tFVUserFarm(farmidx, gameid, itemcode)
					select (rank() over(order by itemcode asc) + @farmidx) as farmidx, @gameid_, itemcode from dbo.tFVItemInfo
					where subcategory = @ITEM_SUBCATEGORY_USERFARM
						and itemcode not in (select itemcode from dbo.tFVUserFarm where gameid = @gameid_)
					order by itemcode asc
				end

			-----------------------------------------------
			-- 이벤트 처리
			-----------------------------------------------
			--select 'DEBUG 이벤트 처리'

			------------------------------------------------
			-- 경쟁모드 순환구조로 변경한다.
			------------------------------------------------
			if(@comreward = -1)
				begin
					select @idx2 = isnull(max(idx2), 1) from dbo.tFVComReward where gameid = @gameid_
					set @idx2 = @idx2 + 1

					delete dbo.tFVComReward where gameid = @gameid_ and idx2 < @idx2 - @USER_LIST_MAX

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
				@attend1			= attend1,				@attend2			= attend2,				@attend3			= attend3,			@attend4			= attend4,		@attend5			= attend5,
				@rtnflag			= rtnflag,
				@roulaccprice 		= roulaccprice,
				@roulaccsale		= roulaccsale
			from dbo.tFVSystemInfo
			order by idx desc
			--select 'DEBUG 각각시설물 max', @housestepmax housestepmax, @tankstepmax tankstepmax, @bottlestepmax bottlestepmax, @pumpstepmax pumpstepmax, @transferstepmax transferstepmax, @purestepmax purestepmax, @freshcoolstepmax freshcoolstepmax, @invenstepmax invenstepmax, @invencountmax invencountmax, @seedfieldmax seedfieldmax

			-----------------------------------------------
			--	@@@@ 시스템 버젼체크
			-----------------------------------------------
			if(    (@market_ = @MARKET_SKT    and @version_ <= 113)
				or (@market_ = @MARKET_GOOGLE and @version_ <= 119)
				or (@market_ = @MARKET_NHN    and @version_ <= 107)
				or (@market_ = @MARKET_IPHONE and @version_ <= 116))
					begin
						--select 'DEBUG old version 업글낮게', @market_ market_, @version_ version_
						set @housestepmax		= 7
						set @tankstepmax		= 23
						set @bottlestepmax		= 23
						set @pumpstepmax 		= 23
						set @transferstepmax 	= 23
						set @purestepmax		= 23
						set @freshcoolstepmax 	= 23
					end
			--else
			--	begin
			--		--select 'DEBUG new version 업글낮게', @market_ market_, @version_ version_
			--	end
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
					from dbo.tFVItemInfo
					where subcategory = @ITEM_SUBCATEGORY_UPGRADE_HOUSE and param1 = @housestep
				end
			else
				begin
					-- 집업글완료 > 건초, 하트 맥스확장.
					select
						@feedmax		= param5,
						@heartmax		= param6,
						@fpointmax		= param9
					from dbo.tFVItemInfo
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
			select @tmpcnt = cnt, @invenkind = invenkind from dbo.tFVUserItem where gameid = @gameid and listidx = @bulletlistidx
			if(@bulletlistidx != -1 and (@tmpcnt <= 0 or @invenkind != @USERITEM_INVENKIND_CONSUME ))
				begin
					--select 'DEBUG 총알 다사용해서 슬롯삭제, 퀵슬로 클리어'
					set @bulletlistidx 		= -1
				end

			set @tmpcnt = 0
			select @tmpcnt = cnt, @invenkind = invenkind from dbo.tFVUserItem where gameid = @gameid and listidx = @vaccinelistidx
			if(@vaccinelistidx != -1 and (@tmpcnt <= 0 or @invenkind != @USERITEM_INVENKIND_CONSUME ))
				begin
					--select 'DEBUG 백신 다사용해서 슬롯삭제, 퀵슬로 클리어'
					set @vaccinelistidx 	= -1
				end

			set @tmpcnt = 0
			select @tmpcnt = cnt, @invenkind = invenkind from dbo.tFVUserItem where gameid = @gameid and listidx = @albalistidx
			if(@albalistidx != -1 and (@tmpcnt <= 0 or @invenkind != @USERITEM_INVENKIND_CONSUME ))
				begin
					--select 'DEBUG 알바 다사용해서 슬롯삭제, 퀵슬로 클리어'
					set @albalistidx 		= -1
				end

			set @tmpcnt = 0
			select @tmpcnt = cnt, @invenkind = invenkind from dbo.tFVUserItem where gameid = @gameid and listidx = @boosterlistidx
			if(@boosterlistidx != -1 and (@tmpcnt <= 0 or @invenkind != @USERITEM_INVENKIND_CONSUME ))
				begin
					--select 'DEBUG 촉진제 다사용해서 슬롯삭제, 퀵슬로 클리어'
					set @boosterlistidx 	= -1
				end

			-- 부활석은 인벤에 장착 안되는 경우가 있어서 슬롯으로는 확인불가능한 것이 존재함....
			-- 모든 소모템들 중에서 수량이 없는 것은 정리 대상이 된다.
			delete from dbo.tFVUserItem where gameid = @gameid and invenkind = @USERITEM_INVENKIND_CONSUME and cnt <= 0

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
			-- 카톡 닉네임변경
			if(isnull(@kakaonickname_, '') != '')
				begin
					set @kakaonickname = @kakaonickname_
				end

			-----------------------------------------------
			-- if(출석일 >= 5일) 아직안받아감
			--else if(출석일 < 1일) 미반영
			--else if(출석일 = 1일) 출석일 갱신, 출석카운터 +=1
			--else 출석일 갱신, 출석카운터 = 1(초기화)
			-----------------------------------------------
			set @tmpcnt = datediff(d, @attenddate, getdate())
			set @newday = @tmpcnt
			set @attendcntview	= @attendcnt
			set @attendnewday = case when @newday >= 1 then 1 else 0 end
			--select 'DEBUG ', @tmpcnt tmpcnt
			set @eventonedailystate = case when @newday >= 1 then @EVENT_STATE_YES else @EVENT_STATE_NON end

			if(@attendcnt >= 5)
				begin
					--select 'DEBUG(출석일: >= 5일 연속) 아직안받아감'
					set @tmpcnt = 0
				end
			else if(@tmpcnt < 1)
				begin
					--select 'DEBUG(출석일: 0 < ~ < 1.0) 미반영'
					set @tmpcnt = 0
				end
			else if(@tmpcnt >= 1)
				begin
					--select 'DEBUG(출석일: 1.0 <= ~ < 2.0) 출석일 갱신, 출석카운터 +=1'
					set @attenddate 	= getdate()
					set @attendcnt 		= case when (@tmpcnt = 1) then (@attendcnt + 1) else 1 end
					set @attendcntview	= @attendcnt

					if(@attendcnt = 1)
						begin
							--select 'DEBUG 1일보상'
							exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @attend1, 'DailyReward', @gameid_, '1일보상'
						end
					else if(@attendcnt = 2)
						begin
							--select 'DEBUG 2일보상'
							exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @attend2, 'DailyReward', @gameid_, '2일보상'
						end
					else if(@attendcnt = 3)
						begin
							--select 'DEBUG 3일보상'
							exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @attend3, 'DailyReward', @gameid_, '3일보상'
						end
					else if(@attendcnt = 4)
						begin
							--select 'DEBUG 4일보상'
							exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @attend4, 'DailyReward', @gameid_, '4일보상'
						end
					else if(@attendcnt >= 5)
						begin
							--select 'DEBUG 5일보상'
							exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @attend5, 'DailyReward', @gameid_, '5일보상'
						end

					if(@attendcnt >= 5)
						begin
							set @attendcnt = 0
						end
				end
			else
				begin
					--select 'DEBUG(출석일: 2.0 <= ~ 무한대) 출석카운터 = 1(초기화)'
					set @attenddate 	= getdate()
					set @attendcnt 		= 1
					set @attendcntview	= @attendcnt
				end

			-------------------------------------------------------------------
			-- Event1 로그인만 하면 매일 매일 소모템을 쏜다~~~
			-------------------------------------------------------------------
			if(@eventonedailystate = @EVENT_STATE_YES)
				begin
					set @eventonedailyloop = datepart(dd, getdate())%3
					if(@eventonedailyloop = 0)
						begin
							exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @EVENT01_ITEM1, 'OpenEvent', @gameid_, '오픈이벤트'
						end
					else if(@eventonedailyloop = 1)
						begin
							exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @EVENT01_ITEM2, 'OpenEvent', @gameid_, '오픈이벤트'
						end
					else
						begin
							exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @EVENT01_ITEM3, 'OpenEvent', @gameid_, '오픈이벤트'
						end
				end

			-------------------------------------------------------------------
			-- Event2 지정된 시간에 로그인하면 선물지급~~~
			-- 		step1 : 마스터가 진행중
			--		step2 : 시작 <= 지금 < 끝 (진행중)
			--				=> 이벤트코드, 아이템코드, 보낸이
			--		step3 : 해당 선물 지급, 선물지급 기록(tEventUser)
			-------------------------------------------------------------------
			select @eventstatemaster = eventstatemaster from dbo.tFVEventMaster where idx = 1
			--select 'DEBUG 지정이벤트1-1', @eventstatemaster eventstatemaster
			if(@eventstatemaster = @EVENT_STATE_YES)
				begin
					select top 1
						@eventidx 		= eventidx,
						@eventitemcode 	= eventitemcode,
						@eventsender 	= eventsender
					from dbo.tFVEventSub
					where eventstart <= @curdate and @curdate < eventend and eventstatedaily = @EVENT_STATE_YES
					order by eventidx desc
					--select 'DEBUG 지정이벤트1-2', @eventidx eventidx, @eventitemcode eventitemcode, @eventsender eventsender

					if(@eventidx != -1 and @eventitemcode != -1)
						begin
							--select 'DEBUG 지정이벤트1-3'
							if(not exists(select top 1 * from dbo.tFVEvnetUserGetLog where gameid = @gameid_ and eventidx = @eventidx))
								begin
									--select 'DEBUG 지정이벤트1-4 선물, 로그기록'
									exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @eventitemcode, @eventsender, @gameid_, '지정된 시간'

									insert into dbo.tFVEvnetUserGetLog(gameid,   eventidx,  eventitemcode)
									values(                         @gameid_, @eventidx, @eventitemcode)

									---------------------------------
									---- 필터구간 > 추가로 시간단축템 지급 > 현재는 삭제
									---------------------------------
									--if(@market_ not in (@MARKET_IPHONE) and @eventitemcode in (703, 1202))
									--	begin
									--		exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT, 1600, @eventsender, @gameid_, '지정된 시간'
									--	end

									-- 자세한 로고는 선물함에 있어서 삭제해도 된다.
									select @idx2 = max(idx) from dbo.tFVEvnetUserGetLog
									delete from tEvnetUserGetLog where idx <= @idx2 - 5000
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
					select top 1 @pettodayitemcode = itemcode from dbo.tFVItemInfo
					where subcategory = @ITEM_SUBCATEGORY_PET
						  and itemcode not in (select itemcode from dbo.tFVUserItem
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
			--if((@newday >= 1 and @yabaustep = 0) or not exists(select top 1 * from dbo.tFVSystemYabau where idx = @yabauidx))
			-------------------------------------------------------------------
			set @strmarket = '%' + ltrim(rtrim(str(@market_))) + '%'
			if(@market_ = @MARKET_GOOGLE)
				begin
					-- Google 서비스.
					if((@newday >= 1 and @yabaustep = 0) or @yabauidx <= -1)
						begin
							select top 1 @yabauidx = idx from dbo.tFVSystemYabau
							where famelvmin <= @famelv
								and @famelv <= famelvmax
								and packstate = 1
								and packmarket like @strmarket
								order by newid()
						end

					if(not exists(select top 1 * from dbo.tFVSystemYabau where idx = @yabauidx))
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
									exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,   @rtnitemcode, '복귀보상', @rtngameid, ''
									exec Spu_Subgiftsend @GIFTLIST_GIFT_KIND_MESSAGE, -1, '누구복귀', @rtngameid, @comment2
								end

							-------------------------------------
							-- 복귀 인원수.
							-------------------------------------
							exec spu_FVDayLogInfoStatic @market_, 28, 1				-- 일 복귀수.
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
					exec Spu_Subgiftsend 1, -1, 'roulhear', @gameid_, @heartmsg
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
			select kakaoprofile, kakaonickname from dbo.tFVUserMaster
			where gameid in (select friendid FROM dbo.tFVKakaoHelpWait where gameid = @gameid_ and helpdate >= getdate() - 1)

			-- 처리해주기.
			exec spu_FVsubKakaoHelpWait @gameid_

			------------------------------------------------------------------
			-- 유저 > 로그인 카운터
			------------------------------------------------------------------
			if(@logindate != @dateid8)
				begin
					exec spu_FVDayLogInfoStatic @market_, 14, 1               -- 일 로그인(유니크)
					exec spu_FVDayLogInfoStatic @market_, 12, 1               -- 일 로그인(중복)
				end
			else
				begin
					exec spu_FVDayLogInfoStatic @market_, 12, 1               -- 일 로그인(중복)
				end
			set @logindate = @dateid8

			------------------------------------------------------------------------
			-- 최근 학교 대항전 결과.
			-----------------------------------------------------------------------
			select top 1 @schoolresult3 = schoolresult from dbo.tFVSchoolResult order by schoolresult desc
			if(@schoolresult3 > @schoolresult)
				begin
					set @schoolresult2 = 1
				end
			else
				begin
					set @schoolresult2 = 0
				end
			set @schoolresult = @schoolresult3


			--------------------------------------------------------------------
			-- 유저 경험치 정보 정리.
			--50 	3395	~ 3794
			--51 	3795	~ 4394
			--52 	4395	~ 5194
			--53 	5195	~ 6194
			--54 	6195	~ 7394
			--55	7395	~ 8794
			--56	8795	~ 10394
			--57	10395	~ 10394
			--58	12195	~ 14194
			--59	14195	~ 16394
			--60	16395	~ 18794			<= 여기까지 오픈되었음.
			--61 	18795	~ 21394
			--62 	21395	~ 24194
			--63 	24195	~ 27194
			--64 	27195	~ 30394
			--65 	30395	~ 33794
			--66 	33795	~ 37394
			--67 	37395	~ 41194
			--68 	41195	~ 45194
			--69 	45195	~ 49394
			--70 	49395	~
			--------------------------------------------------------------------
			--select 'DEBUG ', @market_ market_, @version_ version_, @fame fame, @famelv famelv, @famelvbest famelvbest
			if((@market_ = @MARKET_GOOGLE    and @version_ <= 119)
				or (@market_ = @MARKET_SKT    and @version_ <= 113)
				or (@market_ = @MARKET_IPHONE and @version_ <= 116)
				or (@market_ = @MARKET_NHN    and @version_ <= 107))
					begin
						--select 'DEBUG  >'
						if(@fame >= 18795)
							begin
								--select 'DEBUG   >'
								set @fame			= 18795 - 1	-- 경험치.
								set @famelv			= 60		-- 레벨.
								set @famelvbest		= 60		-- 레벨.
							end
					end

			------------------------------------------------------------------
			-- 유저 정보를 업데이트하기
			------------------------------------------------------------------
			--select * from dbo.tFVUserMaster where gameid = @gameid_

			update dbo.tFVUserMaster
				set
					fame			= @fame,
					famelv			= @famelv,
					famelvbest		= @famelvbest,
					market			= @market_,

					--유저 정보 > 최근 접속날짜 갱신, 접속 카운터 갱신
					version			= @version_,
					--gamecost		= @gamecost,
					--cashcost		= @cashcost,
					heartget		= @heartget,
					kakaomsgblocked	= case
											when (@kakaomsgblocked_ = @KAKAO_MESSAGE_BLOCKED_NON) 	then kakaomsgblocked
											when (@kakaomsgblocked_ = @KAKAO_MESSAGE_BLOCKED_TRUE) 	then @KAKAO_MESSAGE_BLOCKED_TRUE
											else kakaomsgblocked
									end,
					kkhelpalivecnt	= 0,

					-- 오늘만 판매펫등록.
					pettodayitemcode	= @pettodayitemcode,
					pettodayitemcode2	= @pettodayitemcode2,
					logindate		= @logindate,	-- 로그인날짜별.

					-- 출석정보
					attenddate		= @attenddate,
					attendcnt		= @attendcnt,

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
					kakaonickname			= @kakaonickname,

					condate			= getdate(),			-- 최종접속일
					concnt			= concnt + 1			-- 접속횟수 +1
			where gameid = @gameid_

			--------------------------------------------------------------------
			---- 유저의 스테미너가 완충되면 > 푸쉬정보 날려주라 기록하기
			--------------------------------------------------------------------
			--if(not exists(select top 1 * from dbo.tFVActionScheduleData where gameid = @gameid_))
			--	begin
			--		insert into tActionScheduleData(gameid) values(@gameid_)
			--	end

			----------------------------------------------
			-- 학교정보 초기화날짜(매주 월요일).
			---------------------------------------------
			select @dw = DATEPART(dw, @curdate)
			set @curdate = case
								when @dw = 1 then  @curdate
								else			  (@curdate - DATEPART(dw, @curdate) + 2) + 6
						   end
			set @schoolinitdate = CONVERT(char(10), @curdate, 25) + ' 23:59:00'

			-- 학교이름.
			set @schoolname = ''
			select @schoolname = isnull(schoolname, '') from dbo.tFVSchoolBank where schoolidx = @schoolidx

			------------------------------------------------------------------------
			-- 전국 목장 정보 > 수확물 정보가 있는가? > 맥스로 있는가?
			-----------------------------------------------------------------------
			if(exists(select top 1 * from
											(select DATEDIFF(hh, incomedate, getdate()) * param1 as hourcoin2, b.param2 maxcoin from
												(select * from dbo.tFVUserFarm where gameid = @gameid_ and buystate = 1) a
											LEFT JOIN
												(select * from dbo.tFVItemInfo where subcategory = 69) b
											ON a.itemcode = b.itemcode) as f
										where hourcoin2 >= maxcoin ))
				begin
					set @farmharvest	= 1
				end
			else
				begin
					set @farmharvest	= 0
				end

			------------------------------------------------------------------------
			-- 친구들중에 수락 대기중인 친구가 있는가?
			-----------------------------------------------------------------------
			if(exists(select top 1 * from dbo.tFVUserFriend where gameid = @gameid_ and state = 1))
				begin
					set @friendinvite = 1
				end

			------------------------------------------------------------------------
			-- 하트 전송 가능한 친구.
			-----------------------------------------------------------------------
			if(exists(select top 1 * from dbo.tFVUserFriend where gameid = @gameid_ and friendid != @sysfriendid and state = 2 and senddate <= getdate() - 1))
				begin
					set @sendheart = 1
				end

			--######################################################
			----------------------------------------------
			-- 유저 정보
			---------------------------------------------
			select
				*,
				@kkhelpalivecnt kkhelpalivecnt2,
				@attendnewday attendnewday,
				@attendcntview attendcntview,
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
				@GAME_INVEN_ANIMAL_BASE invenanimalbase, @GAME_INVEN_CUSTOME_BASE invencustombase, @GAME_INVEN_ACC_BASE invenaccbase,
				((famelv / 10 + 1)*(famelv / 10 + 1) * @YABAU_CHANGE_DANGA) yabauchange,
				isnull(pmgauage, 0) pmgauage2,
				case when famelv <= 50 then @USED_FRIEND_POINT else (@USED_FRIEND_POINT + (famelv - 50)*20) end needfpoint
			from dbo.tFVUserMaster where gameid = @gameid_

			--------------------------------------------------------------
			-- 유저 보유템 전체 리스트
			-- 동물(동물병원[최근것], 인벤, 필드, 대표), 소비템, 악세사리
			--------------------------------------------------------------
			select * from dbo.tFVUserItem
			where gameid = @gameid_ and invenkind in (@USERITEM_INVENKIND_ANI, @USERITEM_INVENKIND_CONSUME, @USERITEM_INVENKIND_ACC, @USERITEM_INVENKIND_PET)
			order by diedate desc, invenkind, fieldidx, itemcode

			--------------------------------------------------------------
			-- 유저 경작지 정보
			--------------------------------------------------------------
			select * from dbo.tFVUserSeed
			where gameid = @gameid_
			order by seedidx asc

			--------------------------------------------------------------
			-- 유저 친구정보
			-- 카피 & 사라지면 대처동물로.(없으면 기초동물로 교체)
			--------------------------------------------------------------
			exec spu_FVsubFriendList @gameid_

			--------------------------------------------------------------
			-- 카톡 초대친구들
			--------------------------------------------------------------
			select * from dbo.tFVKakaoInvite where gameid = @gameid_

			--------------------------------------------------------------
			-- 유저 선물/쪽지(존재, 쪽지기능보유 통합)
			--------------------------------------------------------------
			exec spu_FVGiftList @gameid_

			----------------------------------------------------------------
			----	도감 : 테이블.(삭제함)
			----------------------------------------------------------------
			--select
			--	param1 dogamidx, itemname dogamname,
			--	param2 animal0, param3 animal1,
			--	param4 animal2, param5 animal3,
			--	param6 animal4, param7 animal5,
			--	param8 rewarditemcode, param9 rewardvalue
			--from dbo.tFVItemInfo
			--where subcategory = @ITEM_MAINCATEGORY_DOGAM

			--------------------------------------------------------------
			--	펫도감 : 획득한 펫.
			--------------------------------------------------------------
			select * from dbo.tFVDogamListPet where gameid = @gameid_ order by itemcode asc

			--------------------------------------------------------------
			--	도감 : 획득한 동물.
			--------------------------------------------------------------
			select * from dbo.tFVDogamList where gameid = @gameid_ order by itemcode asc

			--------------------------------------------------------------
			--	도감 : 보상 받음 도감인덱스 번호.
			--------------------------------------------------------------
			select * from dbo.tFVDogamReward where gameid = @gameid_ order by dogamidx asc

			--------------------------------------------------------------
			-- 게임정보 > 캐쉬구매(+a%), 환전(+b%), 하트(+c%), 건초(+d%) 일일출석, 각맥스
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
			if(@market_ = @MARKET_NHN and getdate() < @EVENT02_END_DAY)
				begin
					select
						top 1
						housestepmax, pumpstepmax, bottlestepmax, transferstepmax, tankstepmax, purestepmax, freshcoolstepmax,
						invenstepmax, invencountmax, seedfieldmax,
						100 pluscashcost, plusgamecost, plusheart, plusfeed, attend1, attend2, attend3, attend4, attend5, composesale, iphonecoupon,
						kakaoinvite01, kakaoinvite02, kakaoinvite03, kakaoinvite04,
						@RECOMMAND_MESSAGE recommendmsg,
						@KAKAO_MESSAGE_INVITE_ID kakaoinviteid,
						@KAKAO_MESSAGE_PROUD_ID kakaoproudid,
						@KAKAO_MESSAGE_HEART_ID kakaoheartid,
						@KAKAO_MESSAGE_HELP_ID kakaohelpid
					from dbo.tFVSystemInfo
					order by idx desc
					--select 'DEBUG 세팅정보2'
				end
			else
				begin
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
					from dbo.tFVSystemInfo
					order by idx desc
					--select 'DEBUG 세팅정보2'
				end

			---------------------------------------------
			-- 패키지상품.
			---------------------------------------------
			set @strmarket = '%' + ltrim(rtrim(str(@market_))) + '%'

			select top 1 * from dbo.tFVSystemPack
			where famelvmin <= @famelv
				and @famelv <= famelvmax
				and packstate = 1
				and packmarket like @strmarket
				--and (ABS(CAST( (BINARY_CHECKSUM(*) * RAND()) as int)) % 100) <= 100
				order by newid()

			---------------------------------------------
			-- 교배뽑기.
			---------------------------------------------
			select top 1 * from dbo.tFVSystemRoulette
			where famelvmin <= @famelv
				and @famelv <= famelvmax
				and packstate = 1
				--and (ABS(CAST( (BINARY_CHECKSUM(*) * RAND()) as int)) % 100) <= 100
				order by newid()

			---------------------------------------------
			-- 랭킹.
			---------------------------------------------
			exec spu_FVsubFriendRank @gameid_, 1

			---------------------------------------------
			-- 전국목장.
			---------------------------------------------
			exec spu_FVUserFarmListNew @gameid_, 1, @market_, @version_

			---------------------------------------------
			-- 에피소드 컨테스트 결과.
			---------------------------------------------
			select * from dbo.tFVEpiReward
			where gameid = @gameid_
			order by idx asc

			---------------------------------------------
			-- 친구랭킹(지난).
			---------------------------------------------
			-- 위에 유저 정보에서 보내준다.

			---------------------------------------------
			-- 지난 학교랭킹(학교 + 내소속).
			---------------------------------------------
			exec spu_FVSchoolRank 11, -1, @gameid_

			---------------------------------------------
			-- 도움준 친구들.
			---------------------------------------------
			select * from @tTempTableHelpWait

			---------------------------------------------
			-- 행운의 집.
			---------------------------------------------
			select top 1 * from dbo.tFVSystemYabau where idx = @yabauidx

			---------------------------------------------
			-- 프리미엄 관료 자료.
			---------------------------------------------
			--select 'DEBUG ', @strmarket strmarket,
			set @curdate = getdate()
			select
				top 1 *,
				case when (@curdate > roulstart and @curdate <= roulend) then roulflag 		else -1 end roulflag2,
				case when (@curdate > roulstart and @curdate <= roulend) then roultimeflag 	else -1 end roultimeflag2,
				case when (@curdate > roulstart and @curdate <= roulend) then pmgauageflag 	else -1 end pmgauageflag2
			from dbo.tFVSystemRouletteMan
			where roulmarket like @strmarket
			order by idx desc

		END
	else
		BEGIN
			select @nResult_ rtn, @comment comment
		END

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
End



