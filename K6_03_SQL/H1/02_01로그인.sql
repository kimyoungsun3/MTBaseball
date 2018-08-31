/* 입력값
gameid=xxx
password=xxx <=암호화저장
version=100


exec spu_Login 'SangSang15678', 'a1s2d3f4', 1, 100, -1

-- 블럭킹처리 test
select top 10 * from dbo.tUserMaster
update dbo.tUserMaster set resultcopy = 5, blockstate = 0 where gameid='DD0'
exec spu_Login 'DD0', 'a1s2d3f4', 1, 100, -1
exec spu_Login 'SangSang', 'a1s2d3f4', 1, 100, -1
update dbo.tUserMaster set resultcopy = 0, blockstate = 0, gradeExp = 14, grade = 3, gradeStar = 2, actioncount = actionmax where gameid='SangSang'

--착용상태 > 만기템
update dbo.tUserMaster set cap = 101, cupper = 201, cunder = 301, bat = 401 where gameid='SangSang'
update dbo.tUserItem set expirestate = 0 , expiredate = '2010-12-31' where gameid = 'SangSang' and itemcode in (101)
update dbo.tUserItem set expirestate = 0 , expiredate = '2012-12-31' where gameid = 'SangSang' and itemcode in (     201, 301, 401)
exec spu_Login 'SangSang', 'a1s2d3f4', 1, 100, -1

update dbo.tUserMaster set cap = 101, cupper = 201, cunder = 301, bat = 401 where gameid='SangSang'
update dbo.tUserItem set expirestate = 0 , expiredate = '2010-12-31' where gameid = 'SangSang' and itemcode in (101, 201)
update dbo.tUserItem set expirestate = 0 , expiredate = '2012-12-31' where gameid = 'SangSang' and itemcode in (          301, 401)
exec spu_Login 'SangSang', 'a1s2d3f4', 1, 100, -1

update dbo.tUserMaster set cap = 101, cupper = 201, cunder = 301, bat = 401 where gameid='SangSang'
update dbo.tUserItem set expirestate = 0 , expiredate = '2010-12-31' where gameid = 'SangSang' and itemcode in (101, 201, 301)
update dbo.tUserItem set expirestate = 0 , expiredate = '2012-12-31' where gameid = 'SangSang' and itemcode in (              401)
exec spu_Login 'SangSang', 'a1s2d3f4', 1, 100, -1

update dbo.tUserMaster set cap = 101, cupper = 201, cunder = 301, bat = 401 where gameid='SangSang'
update dbo.tUserItem set expirestate = 0 , expiredate = '2010-12-31' where gameid = 'SangSang' and itemcode in (101, 201, 301, 401)
exec spu_Login 'SangSang', '7575970askeie1595312', 1, 106, -1
exec spu_Login 'sususu', '7575970askeie1595312', 1, 106, -1
exec spu_Login 'superman6', '7575970askeie1595312', 1, 109, -1
exec spu_Login 'SangSang', '7575970askeie1595312', 1, 100, -1
exec spu_Login 'superman7', '7575970askeie1595312', 1, 111, -1

exec spu_Login 'superman6', '7575970askeie1595312', 1, 109, -1
exec spu_Login 'superman6', '7575970askeie1595312', 11, 109, -1

select * from dbo.tUserMaster where gameid = 'sususu'
*/

IF OBJECT_ID ( 'dbo.spu_Login', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_Login;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_Login
	@gameid_								varchar(20),					-- 게임아이디
	@password_								varchar(20),					-- 암호화해서저장, 유저패스워가 해킹당해도 안전
	@market_								int,							-- (구매처코드) MARKET_SKT
																			--		MARKET_SKT		= 1
																			--		MARKET_KT		= 2
																			--		MARKET_LGT		= 3
																			--		MARKET_FaceBook = 4
																			--		MARKET_Google	= 5
	@version_								int,							-- 클라버젼
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
	declare @RESULT_ERROR_UPGRADE_NOBRANCH		int				set @RESULT_ERROR_UPGRADE_NOBRANCH		= -50			--자체변경불가템

	-- 캐쉬구매.
	declare @RESULT_ERROR_CASH_COPY				int				set @RESULT_ERROR_CASH_COPY				= -40
	declare @RESULT_ERROR_CASH_OVER				int				set @RESULT_ERROR_CASH_OVER				= -41
	declare @RESULT_ERROR_MONTH_OVER			int				set @RESULT_ERROR_MONTH_OVER			= -42			--한달동안 구매한도를 검사

	-- 아이템선물
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- 아이템코드못찾음
	declare @RESULT_ERROR_GIFTITEM_NOT_FOUND	int				set @RESULT_ERROR_GIFTITEM_NOT_FOUND	= -51			-- 선물아이템을 못찾음
	declare @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	int				set @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	= -52			-- 선물을 이미 가져감

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
	declare @NOT_FOUND_DATA						int				set @NOT_FOUND_DATA						= -999

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
	declare @ITEM_KIND_PETREWARD				int 			set @ITEM_KIND_PETREWARD				= 98
	declare @ITEM_KIND_GIFTGOLDBALL				int 			set @ITEM_KIND_GIFTGOLDBALL				= 101
	declare @ITEM_KIND_CONGRATULATE_BALL		int 			set @ITEM_KIND_CONGRATULATE_BALL		= 102

	-- 기타 정의값
	declare @ITEM_PERMANENT_START_DAY			datetime		set @ITEM_PERMANENT_START_DAY			= '2012-01-01'	-- 영구템시작
	declare @ITEM_PERMANENT_ADD_YEAR			int				set @ITEM_PERMANENT_ADD_YEAR			= 50			-- 영구템기간
	declare @ITEM_PERIOD_PERMANENT				int 			set @ITEM_PERIOD_PERMANENT				= -1			-- 테이블에 -1이라 기록됨

	-- 게임플레이 상태정보
	declare @GAME_STATE_END						int				set @GAME_STATE_END						= 0
	declare @GAME_STATE_PLAYING					int				set @GAME_STATE_PLAYING					= 1

	--아이템만기
	declare @ITEM_EXPIRE_STATE_NO				int 			set @ITEM_EXPIRE_STATE_NO				= 0
	declare @ITEM_EXPIRE_STATE_YES				int				set @ITEM_EXPIRE_STATE_YES				= 1
	declare @DAY_PLUS_TIME						bigint			set @DAY_PLUS_TIME 						= 24*60*60

	-- 퀘스트
	declare @QUEST_KIND_UPGRADE				int 			set @QUEST_KIND_UPGRADE 			= 100	-- 강화
	declare @QUEST_KIND_MATING				int 			set @QUEST_KIND_MATING				= 200	-- 교배
	declare @QUEST_KIND_MACHINE				int 			set @QUEST_KIND_MACHINE				= 300	-- 머신
	declare @QUEST_KIND_MEMORIAL			int 			set @QUEST_KIND_MEMORIAL			= 400	-- 암기
	declare @QUEST_KIND_FRIEND				int 			set @QUEST_KIND_FRIEND				= 500	-- 친구
	declare @QUEST_KIND_POLL				int 			set @QUEST_KIND_POLL				= 600	-- 폴대
	declare @QUEST_KIND_BOARD				int 			set @QUEST_KIND_BOARD				= 700	-- 보드
	declare @QUEST_KIND_CEIL				int 			set @QUEST_KIND_CEIL				= 800	-- 천장
	declare @QUEST_KIND_BATTLE				int 			set @QUEST_KIND_BATTLE				= 900	-- 배틀
	declare @QUEST_KIND_SPRINT				int 			set @QUEST_KIND_SPRINT				= 1000	-- 스프

	declare @QUEST_SUBKIND_POINT_ACCRUE		int 			set @QUEST_SUBKIND_POINT_ACCRUE 	= 1		-- 누적
	declare @QUEST_SUBKIND_POINT_BEST		int 			set @QUEST_SUBKIND_POINT_BEST 		= 2		-- 최고
	declare @QUEST_SUBKIND_FRIEND_ADD		int 			set @QUEST_SUBKIND_FRIEND_ADD 		= 3		-- 추가
	declare @QUEST_SUBKIND_FRIEND_VISIT		int 			set @QUEST_SUBKIND_FRIEND_VISIT 	= 4		-- 방문
	declare @QUEST_SUBKIND_HR_CNT			int 			set @QUEST_SUBKIND_HR_CNT 			= 5		-- 홈런누적
	declare @QUEST_SUBKIND_HR_COMBO			int 			set @QUEST_SUBKIND_HR_COMBO 		= 6		-- 홈런콤보
	declare @QUEST_SUBKIND_WIN_CNT			int 			set @QUEST_SUBKIND_WIN_CNT 			= 7		-- 승누적
	declare @QUEST_SUBKIND_WIN_STREAK		int 			set @QUEST_SUBKIND_WIN_STREAK 		= 8		-- 승연승
	declare @QUEST_SUBKIND_CNT				int 			set @QUEST_SUBKIND_CNT 				= 9		-- 플레이

	declare @QUEST_INIT_NOT					int 			set @QUEST_INIT_NOT 				= 0
	declare @QUEST_INIT_FIRST				int 			set @QUEST_INIT_FIRST 				= 1

	declare @QUEST_CLEAR_NON				int 			set @QUEST_CLEAR_NON 				= 0
	declare @QUEST_CLEAR_START				int 			set @QUEST_CLEAR_START 				= 1
	declare @QUEST_CLEAR_REWARD				int 			set @QUEST_CLEAR_REWARD				= 2

	declare @QUEST_STATE_USER_END			int 			set @QUEST_STATE_USER_END 			= 0
	declare @QUEST_STATE_USER_WAIT			int 			set @QUEST_STATE_USER_WAIT 			= 1
	declare @QUEST_STATE_USER_ING			int 			set @QUEST_STATE_USER_ING 			= 2

	-- 퀘스트 일반정의문
	declare @QUEST_MODE_CLEAR				int 			set @QUEST_MODE_CLEAR 				= 1
	declare @QUEST_MODE_CHECK				int 			set @QUEST_MODE_CHECK 				= 2

	-- 타임의 종류
	declare @LOOP_TIME_ACTION				int 			set @LOOP_TIME_ACTION 				= 3*60			-- 행동력 3분에 한개씩 채워줌
	declare @LOOP_TIME_SMS					int 			set @LOOP_TIME_SMS 					= 40*60			-- SMS 40분에 한번씩
	declare @LOOP_TIME_FRIENDLS				int 			set @LOOP_TIME_FRIENDLS				= 20*60			-- 친구라커룸실버 20M분에 한개씩 채워줌
	declare @LOOP_TIME_COIN					int 			set @LOOP_TIME_COIN					= 24*60*60		-- 하루에 하나의 코인 지급(맥스 1개)

	-- Open Event
	declare @OPEN_EVENT01_END				datetime		set @OPEN_EVENT01_END				= '2013-02-04'	-- 1.30일까지
	declare @GOLDBALLGIVE_NORMAL			int				set @GOLDBALLGIVE_NORMAL			= 1
	declare @GOLDBALLGIVE_OPEN_EVENT01		int				set @GOLDBALLGIVE_OPEN_EVENT01		= 1
	declare @COINGIVE_NORMAL				int				set @COINGIVE_NORMAL				= 1
	declare @COINGIVE_OPEN_EVENT01			int				set @COINGIVE_OPEN_EVENT01			= 3

	----------------------------------------------------
	-- @@@@ start 2013-02-13
	-- 모바인 이벤트(전체)
	-- 이벤트 제목 : 발렌타인데이 이벤트
	-- 이벤트 기간 : 2013년 2월 13일 ~ 18일 까지(아이템은 19일 까지 지급)
	-- 이벤트 내용 : 게임 접속하면 아이템 100% 지급
	-- 지원 요청사항 : 게임 접속자게에 소모형 아이템 6개 지급(매일 종류별로 1개씩 또는 매일 다르게 특정 아이템 3개씩)
	-- @@@@ end
	----------------------------------------------------
	--declare @EVENT_END						datetime		set @EVENT_END						= '2013-02-18 23:59'
	--declare @EVENT_CODE						int				set @EVENT_CODE						= 1
	--declare @EVENT_COMMENT					varchar(128)	set @EVENT_COMMENT					= '발렌타인데이 이벤트 선물이 도착했습니다.'

	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @noticesyscheck		int
	declare @noticecomment		varchar(512)
	declare @noticewritedate	datetime
	declare @gameid 		varchar(20)
	declare @password 		varchar(20)
	declare @deletestate	int
	declare @blockstate		int
	declare @cashcopy		int
	declare @resultcopy		int
	declare @actioncount	int
	declare	@actionmax		int
	declare @actiontime		datetime
	declare @friendlscount	int
	declare	@friendlsmax	int
	declare @friendlstime	datetime
	declare @coin			int
	declare @coindate		datetime
	declare @smscount		int
	declare	@smsmax			int
	declare @smstime		datetime
	declare @dayplusdate	datetime
	declare @goldball		int
	declare @dayplusgb		int
	declare @lv				int
	declare @gradeexp		int
	declare @grade			int
	declare @gradestar		int
	declare @gradeOld		int
	declare @gradeStarOld	int
	declare @grademsg		varchar(128)
	declare @ccharacter		int,			@face			int,		@cap				int,
			@cupper			int,			@cunder			int,		@bat				int,
			@glasses		int,			@wing			int,		@tail				int,
			@pet			int,
			@stadium		int

	declare @btflag			int		--연승을 하다가 질것 같아서 나가는 유저의 승수를 클리어.
	declare @btflag2		int
	declare @winstreak		int
	declare @winstreak2		int
	declare @buytype		int
	declare @version		int
	declare @branchurl		varchar(512)
	declare @questkind		int,
			@questsubkind	int,
			@questclear		int

	declare @mboardurl		varchar(512)
	declare @mboardstate	int

	declare @currentDate	datetime		set @currentDate = getdate()

	declare @smsurl			varchar(512)	set @smsurl = ''
	declare @smscom			varchar(512)	set @smscom = ''

	declare @comment		varchar(512)	set @comment = '로그인'

	-- DoublePowerMode(로그인, 더블모드)
	declare @doubleitemcode					int				set	@doubleitemcode				= 7002;
	declare @doublepowerinfo				int				set @doublepowerinfo			= 50
	declare @doubledegreeinfo				int				set @doubledegreeinfo			= 50
	declare @doublepriceinfo				int				set @doublepriceinfo			= 20
	declare @doubleperiodinfo				int				set @doubleperiodinfo			= 3

	-- 시간체킹
	declare @dateid10 						varchar(10) 	set @dateid10 					= Convert(varchar(8), Getdate(),112) + Convert(varchar(2), Getdate(), 108)
	declare @dateid8 						varchar(8) 		set @dateid8 					= Convert(varchar(8), Getdate(),112)
	declare @rand							int

	-- 복수전
	declare @idx							int

	-- 쪽지 new
	declare @newmsg							int 			set @newmsg		= 1
	declare @gamekind						int 			set @gamekind	= 1

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG 초기수행', @nResult_


	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	select 	@gameid = gameid, @password = password, @blockstate = blockstate, @deletestate = deletestate, @cashcopy = cashcopy, @resultcopy = resultcopy,
		   	@actioncount = actioncount, 	@actionmax = actionmax, 		@actiontime = actiontime,
		   	@smscount = smscount, 			@smsmax = smsmax, 				@smstime = smstime,
		   	@friendlscount = friendlscount, @friendlsmax = friendlsmax, 	@friendlstime = friendlstime,
		   	@btflag = btflag,
		   	@btflag2 = btflag2,
		   	@winstreak	= winstreak,
			@winstreak2	= winstreak2,
			@buytype	= isnull(buytype, 0),
			@lv = lv,

		   	@gradeexp 			= gradeexp, 	@grade 		= grade, 		@gradestar = gradestar,
		   	@coin 				= coin, 		@coindate 	= coindate,
		   	@dayplusdate 		= dayplusdate,
		   	@goldball			= goldball,
			@ccharacter 		= ccharacter,	@face		= face,			@cap = cap,
			@cupper 			= cupper,		@cunder		= cunder,		@bat = bat,
			@glasses			= glasses,		@wing 		= wing,			@tail = tail,
			@pet 				= pet,
			@stadium 			= stadium
	from dbo.tUserMaster where gameid = @gameid_
	--select 'DEBUG 연산수행', @gameid, @password, @blockstate, @deletestate, @cashcopy, @resultcopy

	------------------------------------------------
	--	3-3. 공지사항 체크
	------------------------------------------------
	select top 1 @noticesyscheck = syscheck, @noticecomment = comment, @noticewritedate = writedate from dbo.tNotice
	where market = @market_
	order by idx desc
	--select 'DEBUG 공지사항', @noticesyscheck

	------------------------------------------------
	--	3-3-2. SMS 추천
	------------------------------------------------
	--select 'DEBUG ', @market_, @gamekind, @MARKET_SKT2, @MARKET_KT2, @MARKET_LGT2, @MARKET_GOOGLE2
	if(@market_ in (@MARKET_SKT2, @MARKET_KT2, @MARKET_LGT2, @MARKET_GOOGLE2))
		begin
			set @gamekind = 2
			--select 'DEBUG SMS2'
		end
	--select 'DEBUG ', @market_, @gamekind

	select top 1 @smsurl = url, @smscom = comment from dbo.tSMSRecommend
	where gamekind = @gamekind
	order by idx desc
	set @smsurl = @smscom + ' ' + @smsurl

	------------------------------------------------
	--	3-3-3. 더블모드가격
	------------------------------------------------
	select top 1
		@doublepowerinfo 	= doublepowerinfo,
		@doubledegreeinfo 	= doubledegreeinfo,
		@doublepriceinfo	= doublepriceinfo,
		@doubleperiodinfo	= doubleperiodinfo
	from dbo.tDoubleModeInfo
	order by idx desc


	------------------------------------------------
	--	3-4. 패치체크
	------------------------------------------------
	select
		@version = isnull(version, 0),
		@branchurl = branchurl,
		@mboardurl = mboardurl
	from dbo.tMarketPatch
	where market = @market_ and buytype = @buytype

	if(@noticesyscheck = @SYSCHECK_YES)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_SERVER_CHECKING
			set @comment 	= 'DEBUG 시스템 점검중입니다.'
		END
	else if(isnull(@gameid, '') = '')
		BEGIN
			-- 아이디가 존재하지않는가??
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '아이디가 존재하지 않는다. > 아이디를 확인해라.'
		END
	else if(isnull(@password, '') = '' or @password != @password_)
		BEGIN
			-- 아이디 & 패스워드 존재하지않는가??
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_PASSWORD
			set @comment 	= 'DEBUG 패스워드 틀렸다. > 패스워드 확인해라'
		END
	else if(@version_ < @version)		--else if(@version_ != @version)
		BEGIN
			-- 마켓별 버젼이 틀리다
			set @nResult_ 	= @RESULT_NEWVERION_CLIENT_DOWNLOAD
			--@nResult_ = @RESULT_NEWVERION_FILE_DOWNLOAD
			set @comment 	= 'DEBUG 마켓별 버젼이 틀리다. > 다시받아라.'
		END
	else if (@blockstate = @BLOCK_STATE_YES)
		BEGIN
			-- 블럭유저인가?
			set @nResult_ 	= @RESULT_ERROR_BLOCK_USER
			set @comment 	= 'DEBUG 블럭처리된 아이디입니다.'
			-- select * from tUserMaster where blockstate = 1
		END
	else if (@deletestate = @DELETE_STATE_YES)
		BEGIN
			-- 삭제유저인가?
			set @nResult_ 	= @RESULT_ERROR_DELETED_USER
			set @comment 	= 'DEBUG 삭제된 아이디입니다.'
			-- select * from tUserMaster where deletestate = 1
		END
	else if(@cashcopy >= 3)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_BLOCK_USER
			set @comment 	= 'DEBUG 캐쉬결재카피를 '+ltrim(rtrim(str(@cashcopy)))+'회 이상했다. > 블럭처리하자!!'

			-- 3회 이상카피행동 > 블럭처리, 블럭로그기록
			update dbo.tUserMaster
				set
					blockstate = @BLOCK_STATE_YES,
					cashcopy = 0
			where gameid = @gameid_

			-- 아이템3회 카피에 대한 블럭처리
			insert into dbo.tUserBlockLog(gameid, comment)
			values(@gameid_, '(캐쉬결재)를  '+ltrim(rtrim(str(@cashcopy)))+'회 이상 카피를 해서 로그인시 시스템에서 블럭 처리했습니다.')
		END
	else if(@resultcopy >= 100)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_BLOCK_USER
			set @comment 	= 'DEBUG 경기결과복제를 '+ltrim(rtrim(str(@resultcopy)))+'회이상 시도했다. > 블럭처리하자!!'

			--결과복제를 3회 이상했다. > 블럭처리, 블럭로그기록
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
			set @comment 	= 'DEBUG 로그인 정상처리'
		END



	if(@nResult_ != @RESULT_SUCCESS)
		BEGIN
			select @nResult_ rtn, @comment comment, @branchurl branchurl, @currentDate currentDate
		END
	else
		BEGIN
			select @nResult_ rtn, @comment comment, @branchurl branchurl, @currentDate currentDate

			-----------------------------------------------
			-- 배틀게임을 하다가 중간에 나가는 경우
			-- 계급경험치, 계급, 스타정리,
			-- 로그 기록
			-- 계급이 10이상일때만 정리한다.
			-----------------------------------------------
			if(@btflag = @GAME_STATE_PLAYING or @btflag2 = @GAME_STATE_PLAYING)
				begin
					--플래그 정리
					if(@btflag = @GAME_STATE_PLAYING)
						begin
							set @btflag = @GAME_STATE_END
							set @winstreak = 0
						end

					if(@btflag2 = @GAME_STATE_PLAYING)
						begin
							set @btflag2 = @GAME_STATE_END
							set @winstreak2 = 0
						end

					if(@grade >= 10)
						begin
							-- 계급정리
							--declare @gradeExp int			set @gradeExp = 103			declare @grade int			set @grade = 18				declare @gradeStar int	set @gradeStar = 1					--declare @gradeOld		int					--declare @gradeStarOld	int					--declare @i int set @i = 0																				while(@gradeExp != 0)					begin
							--select 'DEBUG 배틀중간에 나감(전) > ', @gradeexp as gradeexp, @grade as grade, @gradestar as gradestar
							set @gradeOld = @grade;
							set @gradeStarOld = @gradeStar;

							set @gradeExp = @gradeExp - 1
							set @grade = @gradeExp / 6 + 1
							set @gradeStar = @gradeExp % 6
							set @grademsg = '배틀중간에 나가서 배틀경험치가 차감되었습니다.'

							if(@gradeExp < 0)
								begin
									set @gradeExp = 0
									set @grade = 1
									set @gradeStar = 0
								end
							else
								begin
									if(@grade != @gradeOld)
										begin
											set @grademsg = '배틀중간에 나가서 배틀레벨이 하락되었습니다.'
											set @gradeExp = 6 * (@grade - 1) + 2
											if(@gradeExp < 0)
												begin
													set @gradeExp = 0
												end
											set @grade = @gradeExp / 6 + 1
											set @gradeStar = @gradeExp % 6
										end
								end
							--select 'DEBUG 배틀중간에 나감(후) > ', @gradeexp as gradeexp, @grade as grade, @gradestar as gradestar

							-- 로그기록만 제거
							-- insert into tMessage(gameid, comment) values(@gameid_, @grademsg)
						end
				end

			-----------------------------------------------
			--	행동력, 코인지급, 친구라커룸실버
			-----------------------------------------------
			--select 'DEBUG (전)', @actionCount actionCount, @actionMax actionMax, @actionTime actionTime, @friendlscount friendlscount,  @friendlsmax friendlsmax, @friendlstime friendlstime,  @coin coin,  @coindate coindate
			-- select * from tUserMaster where gameid = 'SangSang'
			-- 행동력 지급 시간
			declare @nActPerMin bigint,
					@nActCount int,
					@dActTime datetime
			set @nActPerMin = @LOOP_TIME_ACTION
			set @nActCount = datediff(s, @actiontime, getdate())/@nActPerMin
			set @dActTime = DATEADD(s, @nActCount*@nActPerMin, @actiontime)
			set @actioncount = @actioncount + @nActCount
			set @actioncount = case when @actioncount > @actionmax then @actionmax else @actioncount end
			--select 'DEBUG 행동치지급', @actiontime actiontime, getdate() getdate, @nActCount nActCount, @actioncount actioncount, @dActTime dActTime
			set @actiontime = @dActTime

			-- SMS 지급 시간
			declare @nSmsPerMin bigint,
					@nSmsCount int,
					@dSmsTime datetime
			set @nSmsPerMin = @LOOP_TIME_SMS
			set @nSmsCount = datediff(s, @smstime, getdate())/@nSmsPerMin
			set @dSmsTime = DATEADD(s, @nSmsCount*@nSmsPerMin, @smstime)
			set @smscount = @smscount + @nSmsCount
			set @smscount = case when @smscount > @smsmax then @smsmax else @smscount end
			--select 'DEBUG 행동치지급', @smstime smstime, getdate() getdate, @nSmsCount nSmsCount, @smscount smscount, @dSmsTime dSmsTime
			set @smstime = @dSmsTime

			-- 친구라커룸실버 시간
			declare @nFriendLSCount 	int,
					@nFriendLSPerMin	int,
					@dFriendLSTime 		datetime
			set @nFriendLSPerMin = @LOOP_TIME_FRIENDLS					-- 20M분에 한개씩 채워줌
			set @nFriendLSCount = datediff(s, @friendlstime, getdate())/@nFriendLSPerMin
			set @dFriendLSTime = DATEADD(s, @nFriendLSCount*@nFriendLSPerMin, @friendlstime)
			set @friendlscount = @friendlscount + @nFriendLSCount
			set @friendlscount = case when @friendlscount > @friendlsmax then @friendlsmax else @friendlscount end
			--select 'DEBUG 친구라커룸실버', @friendlstime friendlstime, getdate() getdate, @nFriendLSCount nFriendLSCount, @friendlscount friendlscount, @dFriendLSTime dFriendLSTime
			set @friendlstime = @dFriendLSTime


			----------------------------------------------------------
			-- 하루에 하나의 코인 지급(맥스 1개)
			----------------------------------------------------------
			declare @nCointPerMin bigint,
					@nCoinCount int,
					@dCoinTime datetime,
					@nCoinGive int
			set @nCointPerMin = @LOOP_TIME_COIN
			set @nCoinCount = datediff(s, @coindate, getdate())/@nCointPerMin
			set @dCoinTime = DATEADD(s, @nCoinCount*@nCointPerMin, @coindate)
			set @nCoinGive = @COINGIVE_NORMAL

			if(@coin < @nCoinGive)
				begin
					--------------------------------
					-- 코인이 없는 상태
					--------------------------------
					set @coin = @coin + case when @nCoinCount > 0 then @nCoinGive else 0 end
					set @coin = case when @coin > @nCoinGive then @nCoinGive when @coin < 0 then 0 else @coin end
				end
			--else
			--	begin
			--		--------------------------------------
			--		-- 스프린트로 추가획득된 상태 > 그대로 유지
			--		--------------------------------------
			--	end
			--select 'DEBUG 코인지급', @coindate, getdate(), @nCoinCount, @coin, @dCoinTime
			--select 'DEBUG (후)', @actionCount actionCount, @actionMax actionMax, @actionTime actionTime, @friendlscount friendlscount,  @friendlsmax friendlsmax, @friendlstime friendlstime,  @coin coin,  @coindate coindate

			----------------------------------------------------------
			-- 하루에 하나의 골든본 지급
			----------------------------------------------------------
			declare @nGodballGive int
			set @nGodballGive = 1

			set @dayplusgb = datediff(s, @dayplusdate, getdate())/@DAY_PLUS_TIME
			if(@dayplusgb >= 1)
				begin
					-- 하루에
					set @dayplusgb 		= @nGodballGive
					set @goldball 		= @goldball + @nGodballGive
					set @dayplusdate 	= getdate()
				end
			else
				begin
					set @dayplusgb 		= 0
					--set @goldball 	= @goldball
					--set @dayplusdate 	= @dayplusdate
				end


			------------------------------------------------------
			---- @@@@ start 2013-02-13
			---- 모바인 이벤트(전체)
			---- 이벤트 제목 : 발렌타인데이 이벤트
			------------------------------------------------------
			--if(getdate() < @EVENT_END)
			--	begin
			--		if(not exists(select top 1 * from dbo.tEventMaster where gameid = @gameid_ and dateid = @dateid8 and eventcode = @EVENT_CODE))
			--			begin
			--				-----------------------------------------
			--				-- 유저 아이템 지급, 메세지 기록(6000 ~ 6004)
			--				-----------------------------------------
			--				set @rand = 6000 + Convert(int, ceiling(RAND() *  5)) - 1
			--
			--				insert into dbo.tGiftList(gameid, itemcode, giftid, period2, upgradestate2)
			--				values(@gameid_ , @rand, '이벤트보상', -1, 0)
			--
			--				insert into dbo.tGiftList(gameid, itemcode, giftid, period2, upgradestate2)
			--				values(@gameid_ , @rand, '이벤트보상', -1, 0)
			--
			--				insert into tMessage(gameid, comment)
			--				values(@gameid_, @EVENT_COMMENT)
			--
			--				-----------------------------------------
			--				-- 유저 지급한것 이벤트마스터에 기록
			--				-----------------------------------------
			--				insert into dbo.tEventMaster(gameid, dateid, eventcode, comment)
			--				values(@gameid_, @dateid8, @EVENT_CODE, @EVENT_COMMENT)
            --
			--			end
			--	end
			---- @@@@ end


			-----------------------------------------------
			-- 유저 보유 아이템이 만기가되면 만기처리하고 시스템 메시지에 만기를 기록.
			-- 유저의 만기 통채로변경 > @변수테이블에 입력 > 일괄적용
			-- 2개 이상적용됨(테이블로 들어와서)
			-----------------------------------------------
			--declare @gameid_ varchar(20) set @gameid_ = 'SangSang'
			DECLARE @tItemExpire TABLE(
				idx bigint,
				gameid varchar(20),
				itemcode int
			);
			--select * from dbo.tUserItem where gameid = @gameid_
			update dbo.tUserItem
				set
					expirestate = @ITEM_EXPIRE_STATE_YES
					OUTPUT DELETED.idx, @gameid_, DELETED.itemcode into @tItemExpire
			where gameid = @gameid_ and expirestate = @ITEM_EXPIRE_STATE_NO and getdate() > expiredate

			--select * from dbo.tUserItem where gameid = @gameid_
			insert into tMessage(gameid, comment)
				select @gameid_,  itemname + '가 만기가 되었습니다.'
			from @tItemExpire a, tItemInfo b where a.itemcode = b.itemcode
			--select top 10 * from tMessage where gameid = @gameid_  order by idx desc
			--update dbo.tUserItem set expirestate = @ITEM_EXPIRE_STATE_NO where gameid = @gameid_

			------------------------------------------------------
			-- 만기가있는 임시테이블 -> 캐릭터파트정보확인
			-- 아이템정보테이블에서 복구템정보 확인
			-- 각파트별 복구와 비교해서 일치하면 복구
			------------------------------------------------------
			if exists(select * from @tItemExpire where itemcode in (@cap, @cupper, @cunder, @bat))
				begin
					--커서에서 사용되는 변수들
					declare @restoreitemcode	int
					declare @restoreitemkind	int
					declare @restoreitempart	int

					-- 1. 커서선언
					declare curItemExpire Cursor for
					select itemcode, kind, param8 from dbo.tItemInfo where itemcode in (select itemcode from @tItemExpire where itemcode in (@cap, @cupper, @cunder, @bat))

					-- 2. 커서오픈
					open curItemExpire

					-- 3. 커서 사용
					Fetch next from curItemExpire into @restoreitemcode, @restoreitemkind, @restoreitempart
					while @@Fetch_status = 0
						Begin
							if(@restoreitemkind = @ITEM_KIND_CHARACTER)
								begin
									--select 'DEBUG 캐릭터'
									set @ccharacter = @restoreitempart
								end
							else if(@restoreitemkind = @ITEM_KIND_FACE)
								begin
									--select 'DEBUG 얼굴'
									set @face = @restoreitempart
								end
							else if(@restoreitemkind = @ITEM_KIND_CAP)
								begin
									--select 'DEBUG 모자'
									set @cap = @restoreitempart
								end
							else if(@restoreitemkind = @ITEM_KIND_UPPER)
								begin
									--select 'DEBUG 상의'
									set @cupper = @restoreitempart
								end
							else if(@restoreitemkind = @ITEM_KIND_UNDER)
								begin
									--select 'DEBUG 하의'
									set @cunder = @restoreitempart
								end
							else if(@restoreitemkind = @ITEM_KIND_BAT)
								begin
									--select 'DEBUG 배트'
									set @bat = @restoreitempart
								end
							else if(@restoreitemkind = @ITEM_KIND_GLASSES)
								begin
									--select 'DEBUG 안경'
									set @glasses = @restoreitempart
								end
							else if(@restoreitemkind = @ITEM_KIND_WING)
								begin
									--select 'DEBUG 날개'
									set @wing = @restoreitempart
								end
							else if(@restoreitemkind = @ITEM_KIND_TAIL)
								begin
									--select 'DEBUG 꼬리'
									set @tail = @restoreitempart
								end
							else if(@restoreitemkind = @ITEM_KIND_PET)
								begin
									--select 'DEBUG 팻'
									set @pet = @restoreitempart
								end
							else if(@restoreitemkind = @ITEM_KIND_STADIUM)
								begin
									--select 'DEBUG 구장'
									set @stadium = @restoreitempart
								end

							Fetch next from curItemExpire into @restoreitemcode, @restoreitemkind, @restoreitempart
						end

					-- 4. 커서닫기
					close curItemExpire
					Deallocate curItemExpire
				end

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

			-- 속도를 위해서 일괄 --> 진행중(2)으로 변경
			update dbo.tQuestUser
				set
					queststate = @QUEST_STATE_USER_ING
			where gameid = @gameid_
				and queststate = @QUEST_STATE_USER_WAIT
				and getdate() >= queststart


			------------------------------------------------------------------
			-- 유저 정보를 업데이트하기
			------------------------------------------------------------------
			--select * from dbo.tUserMaster where gameid = @gameid_

			update dbo.tUserMaster
			set
				version			= @version_,
				btflag			= @btflag,				-- 배틀 초기화
				btflag2			= @btflag2,
				winstreak		= @winstreak,
				winstreak2		= @winstreak2,

				dayplusdate		= @dayplusdate, 		-- 하루에 1GB 지급하기
				goldball		= @goldball,

				gradeexp		= @gradeexp,
				grade			= @grade,
				gradestar		= @gradestar,

				actioncount		= case when @actioncount < 0 then 0 else @actioncount end,		-- 행동력 갱신
				actiontime		= @actiontime,
				smscount		= @smscount,			-- sms 갱신
				smstime			= @smstime,
				friendlscount	= @friendlscount,		-- 락커룸코인
				friendlstime	= @friendlstime,
				coin			= @coin,				-- 코인 갱신
				coindate		= @dCoinTime,
				condate			= getdate(),			-- 최근 접속날짜 갱신
				concnt			= concnt + 1,			-- 접속횟수 +1
				--ccharacter 	= @ccharacter,
				--face 			= @face,
				cap 			= @cap,
				cupper 			= @cupper,
				cunder			= @cunder,
				bat 			= @bat
				--glasses 		= @glasses,
				--wing 			= @wing,
				--tail 			= @tail,
				--pet 			= @pet,
				--stadium 		= @stadium
			where gameid 		= @gameid_
			--select * from dbo.tUserMaster where gameid = @gameid_


			------------------------------------------------------------------
			-- 유저의 스테미너가 완충되면 > 푸쉬정보 날려주라 기록하기
			------------------------------------------------------------------
			if(not exists(select top 1 * from dbo.tActionScheduleData where gameid = @gameid_))
				begin
					insert into tActionScheduleData(gameid) values(@gameid_)
				end

			------------------------------------------------------------------
			-- 유저 > 로그인 카운터
			------------------------------------------------------------------
			if(not exists(select top 1 * from dbo.tStaticTime where dateid10 = @dateid10 and market = @market_))
				begin
					insert into dbo.tStaticTime(dateid10, market, logincnt, playcnt) values(@dateid10, @market_, 1, 0)
				end
			else
				begin
					update dbo.tStaticTime
						set
							logincnt = logincnt + 1
					where dateid10 = @dateid10 and market = @market_
				end


			------------------------------------------------------------------
			-- 유저에게 전송할 데이타 출력
			-- 로그인 성공여부(상단에서출력)
			-- 공지사항 * 1
			-- 쪽지 * n
			-- 유저정보 * 1
			-- 유저소유템 * n
			-- 유저비소유강화 * n
			-- 유저친구 * n
			-- 유저선물템 * n
			------------------------------------------------------------------
			-- 공지사항(활성 최대 1개)
			select top 1 comment, convert(varchar(16), writedate, 20) as writedate from dbo.tNotice
			where market = @market_
			order by idx desc

			-----------------------------------------------
			-- 신규 쪽지 정보( 최대 10개)
			-----------------------------------------------
			-- idx(Clustered Index Seek) > writedate(Index Seek)
			-- declare @gameid_ varchar(20) set @gameid_ = 'SangSang'
			--select top 10 sendid, comment, idx, convert(varchar(16), writedate, 20) as writedate
			--from dbo.tMessage where gameid = @gameid_  order by idx desc
			select top 10 sendid, comment, idx, convert(varchar(16), writedate, 20) as writedate, newmsg from dbo.tMessage
			where gameid = @gameid_  order by idx desc

			select top 1 @newmsg = newmsg from dbo.tMessage where gameid = @gameid_ order by idx desc
			if(@newmsg = 1)
				begin
					--select 'DEBUG 10-1 메세지 상태값 변경'
					update dbo.tMessage
						set
							newmsg = 0
					where idx in (select top 10 idx from dbo.tMessage where gameid = @gameid_ order by idx desc)
				end


			----------------------------------------------
			-- 유저 정보
			---------------------------------------------
			-- declare @gameid_ varchar(20) set @gameid_ = 'SangSang'
			select *, @dayplusgb dayplusgb, @mboardurl mboardurl, @smsurl smsurl,
			@doublepowerinfo doublepowerinfo,
			@doubledegreeinfo doubledegreeinfo,
			@doublepriceinfo doublepriceinfo,
			@doubleperiodinfo doubleperiodinfo
			from dbo.tUserMaster where gameid = @gameid_

			-- 유저 보유 아이템 정보
			-- declare @gameid_ varchar(20) set @gameid_ = 'SangSang'
			--select itemcode, convert(varchar(19), expiredate, 20) as expiredate, datediff(mi, getdate(), expiredate) as remaintime, upgradestate
			select itemcode, expiredate, datediff(mi, getdate(), expiredate) as remaintime, upgradestate, lvignore
			from dbo.tUserItem where gameid = @gameid_ and expirestate = @ITEM_EXPIRE_STATE_NO

			-- 유저 강화된 미보유 아이템(강화표시에 사용하기 위해서)
			-- declare @gameid_ varchar(20) set @gameid_ = 'SangSang'
			select itemcode, upgradestate, lvignore from dbo.tUserItem where gameid = @gameid_ and expirestate = @ITEM_EXPIRE_STATE_YES and upgradestate > 0


			-- 유저 친구정보
			-- declare @gameid_ varchar(20) set @gameid_ = 'SangSang'
			select friendid, familiar, avatar, picture
				from (select * from dbo.tUserMaster where gameid in (select friendid from dbo.tUserFriend where gameid = @gameid_)) as u
			join
				(select friendid, familiar from dbo.tUserFriend where gameid = @gameid_) as f
			on u.gameid = f.friendid
			order by familiar desc

			-- 선물 리스트 정보(선물이 많은 것이 존재하네 ㅠㅠ)
			-- declare @gameid_ varchar(20) set @gameid_ = 'SangSang'
			select top 50 idx, itemcode, convert(varchar(16), giftdate, 20) as giftdate, giftid, period2, upgradestate2
			from dbo.tGiftList
			where gameid = @gameid_ and gainstate = 0
			order by idx desc

			-- 로그인할때 캐릭터 커스터마이징 정보를 보내준다.
			select itemcode, customize from dbo.tUserCustomize
			where gameid = @gameid_
			order by itemcode asc

			--------------------------------------------------------------
			-- 로그인 > 퀘시간 확인 -> 퀘리스트 받기(진행대기중, 진행중으로 바뀔시간)
			--------------------------------------------------------------
			--> 진행중 리스트 만들기
			select * from dbo.tQuestInfo
			where questcode in (
				select questcode from dbo.tQuestUser
				where gameid = @gameid_ and queststate = @QUEST_STATE_USER_ING and @lv >= questlv
			)
			order by questorder

			-- 별도의 프로토콜로 이동함.
			---------------------------------------------------------------
			--- 로그인 > 자신의 배틀 로그
			-------------------------------------------------------------
			---select top 20 * from dbo.tBattleLog where btgameid = @gameid_
			----order by idxOrder desc
			--select u2.avatar, u2.picture, u2.ccode, bt.gameid, u2.lv, u2.grade, bt.btresult, Convert(varchar(19), writedate,120) as bttime, case when btresult = 1 then 0 else 1 end as btresult2 from
			--	(select top 20 * from dbo.tBattleLog where btgameid = @gameid_ order by idxOrder desc) as bt
			--		join
			--	(select gameid, avatar, picture, ccode, lv, grade from dbo.tUserMaster
			--		where gameid in
			--			(select top 20 gameid from dbo.tBattleLog where btgameid = @gameid_ order by idxOrder desc)) as u2
			--	on bt.gameid = u2.gameid

			--- exec spu_Login 'SangSang', 'a1s2d3f4', 1, 100, 1
			--- exec spu_Login 'SS33', 'a1s2d3f4', 1, 100, 1

			--------------------------------------------------------------
			-- 로그인 > 강화비용
			--------------------------------------------------------------
			select top 1 * from dbo.tItemUpgradeInfo where flag = 1 order by idx desc

			--------------------------------------------------------------
			-- 로그인 > 역전아이템
			--------------------------------------------------------------
			select top 1 * from dbo.tRevModeInfo where flag = 1 order by idx desc

			--------------------------------------------------------------
			-- 로그인 > 스테미너정보
			--------------------------------------------------------------
			select top 1 * from dbo.tActionInfo where flag = 1 order by idx desc

			--------------------------------------------------------------
			-- 로그인 > 복수전 정보가 있는가?
			-- 0.1 : 1시간 음... 별로
			-- 0.7 : 반나절 이상 ㅇㅇ 좋음
			-- 2.0 : 2일 정도 좋은듯함
			--------------------------------------------------------------
			-- 인덱스 초기화
			set @idx = @NOT_FOUND_DATA

			-- 검색하기
			select top 1
				@idx		= idx
			from dbo.tUserRevenge
			where gameid = @gameid_ and btptime >= getdate() - 2.0 and btpflag = 1
			order by idx desc

			-- 존재하는가? > 존재하면 플래그 끄고 던져주기
			if(@idx != @NOT_FOUND_DATA)
				begin
					update dbo.tUserRevenge
						set
							btpflag = 0
						where idx = @idx

					select * from dbo.tUserRevenge where idx = @idx
				end
			else
				begin
					select * from dbo.tUserRevenge where idx = -1
				end

			--------------------------------------------------------
			-- SKT는 ToTO를 하지 못해서 막아둔다.
			-- 타통신사는 구현해서 사용해도 된다.
			--------------------------------------------------------
			if(@market_ != @MARKET_SKT)
				begin
					--------------------------------------------------------------
					-- 로그인 > WBC토토정보(SKT는 제외)
					--------------------------------------------------------------
					select
						m.totoid, m.totodate, m.totoday, m.title, m.acountry, m.bcountry, apoint, bpoint, victcountry, victpoint, chalmode1give,
						isnull(chalstate, -1) chalstate,
						isnull(u.chalmode, -1) chalmode, isnull(u.chalbat, -1) chalbat,
						isnull(chalsb, -1) chalsb,

						--isnull(chalcountry, -1) chalcountry,
						case when (isnull(chalresult1, -1) = 0 or isnull(chalresult2, -1) = 0) then -1 else isnull(chalcountry, -1) end chalcountry,

						isnull(chalpoint, -1) chalpoint,
						isnull(chalresult1, -1) chalresult1, isnull(chalresult2, -1) chalresult2
						--, u.*
							from
								dbo.tTotoMaster m
									LEFT OUTER JOIN
								(select * from dbo.tTotoUser where gameid = @gameid_) u
									on m.totoid = u.totoid
										where active = 1
						order by chalmode1give asc, totodate asc
				end
		end


	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
End



