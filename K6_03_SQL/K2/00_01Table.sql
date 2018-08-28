use Farm
GO

-- 잘못해서 테이블을 전체 건드릴수 있어서 주석처리로 막아둔다.(전에 실수한적이 있어서)
-- 입력 < 검색(우선순위)
-- 데이타베이스 대소문자 구분안함(새로 세팅된 서버 확인필요)
---------------------------------------------
--		유저정보
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserMaster;
GO

create table dbo.tFVUserMaster(
	idx			int 					IDENTITY(1, 1),			-- indexing

	--(유저정보)
	gameid		varchar(60),									-- 이메일(PK)
	password	varchar(20),									-- 암호화해서저장, 유저패스워가 해킹당해도 안전
	market		int						default(5),				-- (구매처코드)
	buytype		int						default(0),				-- (무료/유료코드)
	platform	int						default(1),				-- (플랫폼)
	ukey		varchar(256),									-- UKey
	version		int						default(101),			-- 클라버젼
	concode		int						default(82),			-- 한국(82), 일본(81), 미국(1)
	pushid		varchar(256)			default(''),
	phone		varchar(20)				default(''),			-- indexing
	deldate		datetime				default(getdate() - 1),		-- 삭제일.

	-- Kakao 정보
	kakaotalkid			varchar(60)		default(''),			-- 카카오톡 해쉬 토크아이디(유니크한 값)
	kakaouserid			varchar(60)		default(''),			--          유저id
	kakaomsgblocked		int				default(-1),			--          메시지블럭 (-1:false, 1:true)
	kakaostatus			int				default(1),				--          현재상태(1:진행중, -1:새로하기)
	nickname			varchar(20)		default(''),			-- 별칭(닉네임)

	kakaomsginvitecnt		int			default(0), 			-- 			초대.
	kakaomsginvitecntbg		int			default(0), 			-- 			초대bg.
	kakaomsginvitetodaycnt	int			default(0),				-- 			오늘 초대인원수.
	kakaomsginvitetodaydate	datetime	default(getdate()),		-- 			오늘 날짜.
	--kakaomsgproudcnt	int				default(0), 			-- 			자랑.
	--kakaomsgheartcnt	int				default(0), 			-- 			하트.
	--kakaomsghelpcnt	int				default(0), 			-- 			도와줘.
	kkopushallow		int				default(1),				-- 			카카오푸쉬
	kkhelpalivecnt		int				default(0),				-- 			카카오로 도움요청으로 살아나는 놈이 있는가? 0 없음, 1 이상이면 있음.

	-- 복귀 정보.
	rtngameid	varchar(20)				default(''),			-- 요청아이디.
	rtndate		datetime				default(getdate() - 1),	-- 요청날짜.
	rtnstep		int						default(-1),			-- 복귀스텝. (-1 : 복귀상태아님), (>=1 : 복귀상태로 진행)
	rtnplaycnt	int						default(0),				-- 복귀플레이카운터(x번째에 복귀선물).

	regdate		datetime				default(getdate()),		-- 최초가입일
	condate		datetime				default(getdate()),		-- (로그인시마다 매번업데이트)
	concnt		int						default(1),				-- 접속횟수
	deletestate	int						default(0),				-- 0 : 삭제상태아님, 1 : 삭제상태
	logindate	varchar(8)				default('20100101'),	--
	blockstate	int						default(0),				-- 0 : 블럭상태아님, 1 : 블럭상태
	cashcopy	int						default(0),				-- 캐쉬불법카피시 +1추가된다.
	resultcopy	int						default(0),				-- 로그결과카피시 +1추가된다.
	cashpoint	int						default(0),
	cashcost	int						default(0),
	ownercashcost bigint				default(0),
	vippoint	int						default(0),

	-- 클라이언트 데이타.
	cashcost2	bigint					default(0),				-- 결정.
	vippoint2	int						default(0),				--
	boost2		int						default(0),				-- 촉진제
	steampack2	int						default(0),				-- 스팀펙
	compost2	int						default(0),				-- 비료촉진제.
	gun2		int						default(0),				-- 사냥총.
	guncho2		int						default(0),				-- 건초탱크 단계.
	house2		int						default(0),				-- 집 단계.
	alba2		int						default(0),				-- 알바 최고단계.
	tank2		int						default(0),				-- 탱크 단계.
	arable2		int						default(0),				-- 경작지.
	farmopen2	int						default(0),				-- 목장오픈.
	farmbest2	int						default(0),				-- 목장단계.

	-- (일반정보2)
	heartget	int						default(0),				-- 하트 받아가는것.
	heartcnt	int						default(0),				-- 하트 하루에 받아가는냥
	heartcntmax	int						default(400),			-- 하트 맥스량
	heartdate	varchar(8)				default('20100101'),	--

	-- 랭킹정보.
	bestani			int					default(500),
	salemoney		bigint				default(0),				-- 개인랭킹(0).

	-- 랭킹 홀짝전.
	rkdateid8bf		varchar(8)			default('20000101'),
	rkteam			int					default(1),				-- 1홀, 2짝
	rksalemoney		bigint				default(0),				-- 판매수익(0).
	rkproductcnt	bigint				default(0),				-- 생산수량(30).
	rkfarmearn		bigint				default(0),				-- 목장수익(31).
	rkwolfcnt		bigint				default(0),				-- 늑대사냥(32).
	rkfriendpoint	bigint				default(0),				-- 친구포인트(자동수집).
	rkroulettecnt	bigint				default(0),				-- 룰렛횟수(20, 21).
	rkplaycnt		bigint				default(0),				-- 플레이타임(33).
	rktotal			bigint				default(0),				-- > 랭킹대전의 가산점을 적용해서 들어간값(다음날 계산된것임)
	rksalemoneybk	bigint				default(0),				-- 백업
	rkproductcntbk	bigint				default(0),
	rkfarmearnbk	bigint				default(0),
	rkwolfcntbk		bigint				default(0),
	rkfriendpointbk	bigint				default(0),
	rkroulettecntbk	bigint				default(0),
	rkplaycntbk		bigint				default(0),
	rktotal2		bigint				default(0),

	-- (랭킹산출용 데이타) > 일주일 데몬에 의해서 정리됨.
	rankresult		int					default(0),
	salemoneybkup	bigint				default(0),				-- 누적판매금액백엄(스케쥴에 의해서백업).
	lmsalemoney		bigint				default(0),				-- 지난 내점수.
	lmrank			int					default(1),				-- 지난 나의 순위.
	lmcnt			int					default(1),				-- 지난 나의 친구들.

	l1gameid		varchar(20)			default(''),			-- 지난 1위 친구.
	l1bestani		int					default(-1),			-- 			대표 동물.
	l1salemoney		bigint				default(0),				-- 			점수.
	l2gameid		varchar(20)			default(''),			-- 지난 2위 친구.
	l2bestani		int					default(-1),			-- 			대표 동물.
	l2salemoney		bigint				default(0),				-- 			점수.
	l3gameid		varchar(20)			default(''),			-- 지난 3위 친구.
	l3bestani		int					default(-1),			-- 			대표 동물.
	l3salemoney		bigint				default(0),				-- 			점수.

	randserial	varchar(20)				default('-1'),			-- 랜덤씨리얼
	bgitemcode1	int						default(-1),
	bgitemcode2	int						default(-1),
	bgitemcode3	int						default(-1),
	bgcnt1		int						default(0),
	bgcnt2		int						default(0),
	bgcnt3		int						default(0),
	logwrite2	int						default(1),

	-- (뽑기(중복구매방지))
	bgroul1		int						default(-1),			-- 마지막 뽑은것 임시저장하는곳.
	bgroul2		int						default(-1),
	bgroul3		int						default(-1),
	bgroul4		int						default(-1),
	bgroul5		int						default(-1),
	tsgrade1cnt	int						default(0),				-- 일반     뽑기 횟수 D, C
	tsgrade2cnt	int						default(0),				-- 프리미엄 뽑기 횟수 B, A
	tsgrade3cnt	int						default(0),				--          뽑기 횟수 A, S
	tsgrade4cnt	int						default(0),				--          뽑기 횟수 A, S(3 + 1)
	tsgrade2gauage	int					default(0),				-- 프리미엄 게이지 B, A.
	tsgrade3gauage	int					default(0),				--          게이지 A, S
	tsgrade4gauage	int					default(0),				--          게이지 A, S(3 + 1)
	tsgrade2free	int					default(0),
	tsgrade3free	int					default(0),
	tsgrade4free	int					default(0),
	adidx		int						default(0),				-- 광고번호.

	-- 회전판.
	roulette	int						default(1),
	roulettefreecnt	int					default(0),
	roulettepaycnt	int					default(0),
	roulettegoldcnt	int					default(0),
	wheelgauage	int						default(0),				-- 회전판(게이지값)
	wheelfree	int						default(0),				-- 1이면 무료회전.

	bgroulcnt	int						default(0),				-- 교배 횟수.
	pmroulcnt	int						default(0),				-- 교배 횟수.
	pmticketcnt	int						default(0),				-- 프리미엄 티켓 교배 횟수.
	pmgauage	int						default(0),				-- 프리미엄 게이지.

	-- 이벤트.
	eventspot06		int					default(0),				-- 쿠폰에서 사용.
	eventspot07		int					default(0),				-- 쿠폰에서 사용.
	eventspot08		int					default(0),				-- 쿠폰에서 사용.
	eventspot09		int					default(0),				-- 쿠폰에서 사용.

	-- Constraint
	CONSTRAINT pk_tFVUserMaster_gameid	PRIMARY KEY(gameid)
)
GO
-- alter table dbo.tFVUserMaster add logindate	varchar(8)				default('20100101')
-- 데이타 10만건 강제로 넣어서 쿼리해보기(상상ID로 만든 유저를 입력한다.)
-- 가입시 gameid 쿼리 > PRIMARY KEY(gameid) > 인덱싱

-- 폰인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserMaster_phone')
    DROP INDEX tFVUserMaster.idx_tFVUserMaster_phone
GO
CREATE INDEX idx_tFVUserMaster_phone ON tFVUserMaster (phone)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserMaster_idx')
   DROP INDEX tFVUserMaster.idx_tFVUserMaster_idx
GO
CREATE INDEX idx_tFVUserMaster_idx ON tFVUserMaster (idx)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserMaster_salemoney')
   DROP INDEX tFVUserMaster.idx_tFVUserMaster_salemoney
GO
CREATE INDEX idx_tFVUserMaster_salemoney ON tFVUserMaster (salemoney)
GO

-- insert into dbo.tFVUserMaster(gameid, phone, market, version) values('xxxx@gmail.com', '01022223333', 5, 101)
-- select * from dbo.tFVUserMaster where gameid = 'xxxx@gmail.com'
-- update dbo.tFVUserMaster set market = 5, version = 101 where gameid = 'xxxx@gmail.com'

---------------------------------------------
--		유저정보
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserData', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserData;
GO

create table dbo.tFVUserData(
	idx			int 					IDENTITY(1, 1),			-- indexing

	--(유저정보)
	gameid		varchar(60),
	savestate	int						default(1),				-- 1(save), -1(읽어감)
	savedata	varchar(4096)			default('-1'),

	-- Constraint
	CONSTRAINT pk_tFVUserData_gameid	PRIMARY KEY(gameid)
)
GO


IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserData_idx')
   DROP INDEX tFVUserData.idx_tFVUserData_idx
GO
CREATE INDEX idx_tFVUserData_idx ON tFVUserData (idx)
GO

---------------------------------------------
--		아이템 보유정보
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVGiftList', N'U') IS NOT NULL
	DROP TABLE dbo.tFVGiftList;
GO

create table dbo.tFVGiftList(
	idx			bigint				IDENTITY(1,1),
	idx2		int,

	gameid		varchar(60),									-- gameid별 itemcode는 중복이 발생한다.
	giftkind	int					default(0),					-- 1:메시지, 2:선물, -1:메시지삭제, -2:선물받아감

	message		varchar(256)		default(''), 				-- 메세지(1)

	itemcode	int					default(-1),				-- 선물(2)
	cnt			bigint				default(0),
	gainstate	int					default(0),					-- 가져간상태	0:안가져감, 1:가져감
	gaindate	datetime, 										-- 가져간날
	giftid		varchar(60)			default('SangSang'),		-- 선물한 유저
	giftdate	datetime			default(getdate()), 		-- 선물일

	-- Constraint
	CONSTRAINT	pk_tFVGiftList_idx	PRIMARY KEY(idx)
)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVGiftList_gameid_idx')
    DROP INDEX tFVGiftList.idx_tFVGiftList_gameid_idx
GO
CREATE INDEX idx_tFVGiftList_gameid_idx ON tFVGiftList (gameid, idx)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVGiftList_gameid_idx2')
    DROP INDEX tFVGiftList.idx_tFVGiftList_gameid_idx2
GO
CREATE INDEX idx_tFVGiftList_gameid_idx2 ON tFVGiftList (gameid, idx2)
GO



---------------------------------------------
-- 	블럭폰번호 > 가입시 블럭처리자
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserBlockPhone', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserBlockPhone;
GO

create table dbo.tFVUserBlockPhone(
	idx			int 					IDENTITY(1, 1),

	phone			varchar(20),
	comment			varchar(1024),
	writedate		datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tFVUserBlockPhone_phone	PRIMARY KEY(phone)
)

-- insert into dbo.tFVUserBlockPhone(phone, comment) values('01022223335', '아이템카피')
-- select top 100 * from dbo.tFVUserBlockPhone order by writedate desc
-- select top 1   * from dbo.tFVUserBlockPhone where phone = '01022223333'

-- 센드키 충돌검사
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserBlockPhone_idx')
    DROP INDEX tFVUserBlockPhone.idx_tFVUserBlockPhone_idx
GO
CREATE INDEX idx_tFVUserBlockPhone_idx ON tFVUserBlockPhone (idx)
GO

---------------------------------------------
--	유니크 가입현황파악하기
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserPhone', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserPhone;
GO

create table dbo.tFVUserPhone(
	idx					int 				IDENTITY(1, 1),

	phone				varchar(20),
	market				int					default(5),
	joincnt				int					default(1),
	writedate			datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tFVUserPhone_idx	PRIMARY KEY(idx)
)
-- 폰인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserPhone_phone')
    DROP INDEX tFVUserPhone.idx_tFVUserPhone_phone
GO
CREATE INDEX idx_tFVUserPhone_phone ON tFVUserPhone (phone)
GO
-- select top 1 * from dbo.tFVUserPhone


---------------------------------------------------
--	(회사공지)
---------------------------------------------------
IF OBJECT_ID (N'dbo.tFVNotice', N'U') IS NOT NULL
	DROP TABLE dbo.tFVNotice;
GO

create table dbo.tFVNotice(
	idx				int				IDENTITY(1,1), 			-- 번호
	market			int				default(1),
	buytype			int				default(0),				-- 무료(0), 유료(1)

	comfile			varchar(512)	default(''),			-- 공지이미지
	comurl			varchar(512)	default(''),			-- 공지URL
	comfile2		varchar(512)	default(''),
	comurl2			varchar(512)	default(''),
	comfile3		varchar(512)	default(''),
	comurl3			varchar(512)	default(''),
	comfile4		varchar(512)	default(''),
	comurl4			varchar(512)	default(''),
	comfile5		varchar(512)	default(''),
	comurl5			varchar(512)	default(''),
	comment			varchar(4096)	default(''),

	version			int				default(101),			--클라이언트버전
	patchurl		varchar(512)	default(''),			--패치URL
	recurl			varchar(512)	default(''),			--게시판URL
	smsurl			varchar(512)	default(''),			--SMSURL (사용안함)
	smscom			varchar(512)	default(''),			--(사용안함)

	iteminfover		int				default(100),			-- 사용안함
	iteminfourl		varchar(512)	default(''),			-- 각URL

	writedate		datetime		default(getdate()), 	-- 작성일
	syscheck		int				default(0),				-- 0:서비스중 	1:점검중

	-- Constraint
	CONSTRAINT	pk_tFVNotice_idx	PRIMARY KEY(idx)
)
--select top 1 * from dbo.tFVNotice where market = 1 order by writedate desc
--select * from dbo.tFVNotice where market = 1 order by writedate desc
--insert into dbo.tFVNotice(market, version, patchurl) values(1, 101, 'http://m.naver.com')
--insert into dbo.tFVNotice(market, version, patchurl) values(2, 101, 'http://m.naver.com')
--insert into dbo.tFVNotice(market, version, patchurl) values(5, 101, 'http://m.naver.com')


---------------------------------------------
-- 	매일통계관리
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVDayLogInfoStatic', N'U') IS NOT NULL
	DROP TABLE dbo.tFVDayLogInfoStatic;
GO

create table dbo.tFVDayLogInfoStatic(
	idx				int				IDENTITY(1,1),

	dateid8			varchar(8),
	market			int				default(1),

	joinplayercnt	int				default(0),					-- 일 일반가입
	joinguestcnt	int				default(0),					-- 일 일반가입
	joinukcnt		int				default(0),					-- 일 유니크 가입
	invitekakao		int				default(0),					-- 일 카카오 초대.
	kakaoheartcnt	int				default(0),					-- 일 카카오 하트.

	logincnt		int				default(0),					-- 일 로그인
	logincnt2		int				default(0),					-- 일 로그인(유니크)

	rtnrequest		int				default(0),					-- 일 복귀요청수
	rtnrejoin		int				default(0),					-- 일 복귀수

	certnocnt		int				default(0),					-- 일 쿠폰등록수.

	pushandroidcnt	int				default(0),					-- 안드로이드통계.
	pushiphonecnt	int				default(0),					-- 아이폰통계.

	roulettefreecnt	int				default(0),					-- 일 일일룰렛
	roulettepaycnt	int				default(0),					-- 일 결정룰렛
	roulettegoldcnt	int				default(0),					-- 일 황금무료

	tsupgradenormal 	int			default(0),					-- 일 일반강화
	tsupgradepremium 	int			default(0),					-- 일 프리미엄강화

	tsgrade1cnt		int				default(0),					-- 일반     뽑기 횟수 D, C
	tsgrade2cnt		int				default(0),					-- 프리미엄 뽑기 횟수 B, A
	tsgrade3cnt		int				default(0),					--          뽑기 횟수 A, S
	tsgrade4cnt		int				default(0),					--          뽑기 횟수 A, S(3 + 1)
	tsgrade2cntfree	int				default(0),					-- 프리미엄 무료
	tsgrade3cntfree	int				default(0),					--
	tsgrade4cntfree	int				default(0),					--

	freecashcost	bigint			default(0),					-- 안드로이드통계.
	freecnt			int				default(0),					-- 아이폰통계.

	-- Constraint
	CONSTRAINT	pk_tFVDayLogInfoStatic_idx	PRIMARY KEY(idx)
)
-- alter table dbo.tFVDayLogInfoStatic add certnocnt		int				default(0)
-- alter table dbo.tFVDayLogInfoStatic add revivalcnt		int				default(0)
-- alter table dbo.tFVDayLogInfoStatic add revivalcntcash	int				default(0)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVDayLogInfoStatic_dateid8_market')
    DROP INDEX tFVDayLogInfoStatic.idx_tFVDayLogInfoStatic_dateid8_market
GO
CREATE INDEX idx_tFVDayLogInfoStatic_dateid8_market ON tFVDayLogInfoStatic(dateid8, market)
GO

-- insert into dbo.tFVDayLogInfoStatic(dateid8) values('20130827')
-- select top 100 * from dbo.tFVDayLogInfoStatic order by idx desc

---------------------------------------------
-- 	캐쉬관련(개인로그)
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVCashLog', N'U') IS NOT NULL
	DROP TABLE dbo.tFVCashLog;
GO

create table dbo.tFVCashLog(
	idx				int				identity(1, 1),
	gameid			varchar(60)		not null, 				-- 구매자

	giftid			varchar(20), 							-- 선물받은사람
	acode			varchar(256), 							-- 승인코드() 사용안함.ㅠㅠ
	ucode			varchar(256), 							-- 승인코드

	ikind			varchar(256),							-- 아이폰, Google 종류(SandBox, Real, GoogleID)
	idata			varchar(4096),							-- 아이폰에서 사용되는 데이타(원본)
	idata2			varchar(4096),							-- 아이폰에서 사용되는 데이타(해석본)
	concode			int				default(82),			-- 한국(82), 일본(81), 미국(1)

	cashcost		int				default(0), 			-- 충전골든볼
	cash			int				default(0),				-- 구매현금
	writedate		datetime		default(getdate()), 	-- 구매일
	market			int				default(1),				-- (구매처코드) MARKET_SKT

	kakaouserid		varchar(20)		default(''),			--          유저id
	kakaouk			varchar(19)		default(''),			--          유저id

	kakaosend		int				default(-1),			-- 미전송(-1) -> 전송(1)

	-- Constraint
	CONSTRAINT	pk_tFVCashLog_idx	PRIMARY KEY(idx)
)
--직접 clustered를 안한 이유는 쓰기는 idx로 하고 검색을 ucode > idx를 통해서 하도록 설정
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVCashLog_ucode')
    DROP INDEX tFVCashLog.idx_tFVCashLog_ucode
GO
CREATE INDEX idx_tFVCashLog_ucode ON tFVCashLog (ucode)
GO
--유저로그검색
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVCashLog_gameid')
    DROP INDEX tFVCashLog.idx_tFVCashLog_gameid
GO
CREATE INDEX idx_tFVCashLog_gameid ON tFVCashLog (gameid)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVCashLog_acode')
    DROP INDEX tFVCashLog.idx_tFVCashLog_acode
GO
CREATE INDEX idx_tFVCashLog_acode ON tFVCashLog (acode)
GO
--insert into dbo.tFVCashLog(gameid, acode, ucode, cashcost, cash) values('xxxx', 'xxx', '12345778998765442bcde3123192915243184254', 10, 1000)
--select * from dbo.tFVCashLog where ucode = '12345778998765442bcde3123192915243184254'


---------------------------------------------
-- 	캐쉬전송
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVCashLogKakaoSend', N'U') IS NOT NULL
	DROP TABLE dbo.tFVCashLogKakaoSend;
GO

create table dbo.tFVCashLogKakaoSend(
	checkidx		int,

	-- Constraint
	CONSTRAINT	pk_tFVCashLogKakaoSend_checkidx	PRIMARY KEY(checkidx)
)



---------------------------------------------
-- 	캐쉬구매Total
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVCashTotal', N'U') IS NOT NULL
	DROP TABLE dbo.tFVCashTotal;
GO

create table dbo.tFVCashTotal(
	idx				int				identity(1, 1),
	dateid			char(8),								-- 20101210
	cashkind		int,
	market			int				default(1),				-- (구매처코드) MARKET_SKT

	cashcost		int				default(0), 			-- 총판매량
	cash			int				default(0), 			-- 총판매량
	cnt				int				default(1),				--증가회수
	-- Constraint
	CONSTRAINT	pk_tFVCashTotal_dateid_market	PRIMARY KEY(dateid, cashkind, market)
)
-- insert into dbo.tFVCashTotal(dateid, cashkind, market, cashcost, cash) values('20120818', 2000, 1, 21, 2000)
-- insert into dbo.tFVCashTotal(dateid, cashkind, market, cashcost, cash) values('20120818', 5000, 1, 55, 5000)
-- select top 1 * from dbo.tFVCashTotal where dateid = '20120818' and cashkind = 2000 and market = 1
-- update dbo.tFVCashTotal set cashcost = cashcost + 21, cash = cash + 2000, cnt = cnt + 1 where dateid = '20120818' and cashkind = 2000 and market = 1


---------------------------------------------
-- 	캐쉬전송
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVCashLogKakaoSend', N'U') IS NOT NULL
	DROP TABLE dbo.tFVCashLogKakaoSend;
GO

create table dbo.tFVCashLogKakaoSend(
	checkidx		int,

	-- Constraint
	CONSTRAINT	pk_tFVCashLogKakaoSend_checkidx	PRIMARY KEY(checkidx)
)


---------------------------------------------
--  관리자 정보
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVAdminUser', N'U') IS NOT NULL
	DROP TABLE dbo.tFVAdminUser;
GO

create table dbo.tFVAdminUser(
	idx				int 				IDENTITY(1, 1),
	gameid			varchar(20),
	password		varchar(20),
	writedate		datetime			default(getdate()),
	grade			int					default(0),

	-- Constraint
	CONSTRAINT	pk_tFVAdminUser_idx	PRIMARY KEY(gameid)
)

--select * from dbo.tFVAdminUser
--insert into tFVAdminUser(gameid, password) values('blackm', 'a1s2d3f4')




---------------------------------------------
--	비정삭적인 행동을 할려고 하는 유저체킹 > 블럭처리
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserUnusualLog', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserUnusualLog;
GO

create table dbo.tFVUserUnusualLog(
	idx				int				IDENTITY(1,1),
	gameid			varchar(20), 							-- 행동자
	comment			varchar(512), 							-- 비정상내용
	writedate		datetime		default(getdate()), 	-- 비정상작성일

	chkstate		int				default(0),				-- 확인상태(0:체킹안함, 1:체킹함)
	chkdate			datetime,
	chkcomment		varchar(512), 							-- 확인내용

	-- Constraint
	CONSTRAINT pk_tFVUserUnusualLog_idx PRIMARY KEY(idx)
)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserUnusualLog_gameid_idx')
    DROP INDEX tFVUserUnusualLog.idx_tFVUserUnusualLog_gameid_idx
GO
CREATE INDEX idx_tFVUserUnusualLog_gameid_idx ON tFVUserUnusualLog(gameid, idx)
GO
-- insert into dbo.tFVUserUnusualLog(gameid, comment) values('x1', '캐쉬카피시도')
-- insert into dbo.tFVUserUnusualLog(gameid, comment) values('x1', '환전카피시도')
-- insert into dbo.tFVUserUnusualLog(gameid, comment) values('x2', '결과조작')
-- select top 20 * from dbo.tFVUserUnusualLog order by idx desc
-- select top 20 * from dbo.tFVUserUnusualLog where gameid = 'sususu' order by idx desc


---------------------------------------------
--	비정삭적인2 행동을 할려고 하는 유저체킹 > 블럭처리
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserUnusualLog2', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserUnusualLog2;
GO

create table dbo.tFVUserUnusualLog2(
	idx				int				IDENTITY(1,1),
	gameid			varchar(60), 							-- 행동자
	comment			varchar(512), 							-- 비정상내용
	writedate		datetime		default(getdate()), 	-- 비정상작성일

	chkstate		int				default(0),				-- 확인상태(0:체킹안함, 1:체킹함)
	chkdate			datetime,
	chkcomment		varchar(512), 							-- 확인내용

	-- Constraint
	CONSTRAINT pk_tFVUserUnusualLog2_idx PRIMARY KEY(idx)
)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserUnusualLog2_gameid_idx')
    DROP INDEX tFVUserUnusualLog2.idx_tFVUserUnusualLog2_gameid_idx
GO
CREATE INDEX idx_tFVUserUnusualLog2_gameid_idx ON tFVUserUnusualLog2(gameid, idx)
GO
-- insert into dbo.tFVUserUnusualLog2(gameid, comment) values('x1', '캐쉬카피시도')
-- insert into dbo.tFVUserUnusualLog2(gameid, comment) values('x1', '환전카피시도')
-- insert into dbo.tFVUserUnusualLog2(gameid, comment) values('x2', '결과조작')
-- select top 20 * from dbo.tFVUserUnusualLog2 order by idx desc
-- select top 20 * from dbo.tFVUserUnusualLog2 where gameid = 'sususu' order by idx desc


-----------------------------------------------
----	Android Push Service
----	짜요것을 사용.
-----------------------------------------------
--IF OBJECT_ID (N'dbo.tFVUserPushAndroid', N'U') IS NOT NULL
--	DROP TABLE dbo.tFVUserPushAndroid;
--GO
--
--create table dbo.tFVUserPushAndroid(
--	idx				int				identity(1, 1),
--
--	sendid			varchar(60),
--	receid			varchar(60),
--	recepushid		varchar(256),
--	sendkind		int,
--
--	msgpush_id		int				default(99),
--	msgtitle		varchar(512),
--	msgmsg			varchar(512),
--	msgaction		varchar(512)	default('LAUNCH'),
--
--	actionTime		datetime		default(getdate()),
--	scheduleTime	datetime		default(getdate()),
--
--	-- Constraint
--	CONSTRAINT	pk_tFVUserPushAndroid_idx	PRIMARY KEY(idx)
--)
---- select top 1 * from dbo.tFVUserPushAndroid
--
---- 내폰
----insert into dbo.tFVUserPushAndroid(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73801', 'guest73801', 'APA91bF6Y96_WIvc3jQH83B2QoTUkcDcX2KAp6A5AGQfMQ_V4LZOjzKe7Wr-IVgXz-a2XS1A8hUIUZ6-0NmWkfkkQLqUMSYikMGA_P1Ejj42Z4e_VxRth84WJkMuhGjbvWUuwAVUdn90R5wlYe6P2W4hLMsyU8FeWjEXcHzFbRe2Fj8lH4CoOL0', 1, 99, '홈런리그제목', '홈런리그 내용푸쉬로 날려요.', 'LAUNCH')
----insert into dbo.tFVUserPushAndroid(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73801', 'guest73801', 'APA91bF6Y96_WIvc3jQH83B2QoTUkcDcX2KAp6A5AGQfMQ_V4LZOjzKe7Wr-IVgXz-a2XS1A8hUIUZ6-0NmWkfkkQLqUMSYikMGA_P1Ejj42Z4e_VxRth84WJkMuhGjbvWUuwAVUdn90R5wlYe6P2W4hLMsyU8FeWjEXcHzFbRe2Fj8lH4CoOL0', 1, 99, '홈런리그제목url', '홈런리그 내용푸쉬로 날려요.url', 'http://m.naver.com')
---- 진혁폰
----insert into dbo.tFVUserPushAndroid(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73799', 'guest73799', 'APA91bE5TtZI1T81gIpHN1o1IZuasNwm0PoaiG2xYDzOJ6AkW2H148vKqUdy7Oh1in0F-OZUo1VxUbwnNt-Jg1blX7c6sJ7wf92vzIsDy9sRBCtJK4GhauekcatxyM7rS_pvEla4A5Tj3GWQEH3JFOZFZSIrK4UDa7FZxUwLiWZpNrceCqaRct4', 1, 99, '홈런리그제목', '홈런리그 내용푸쉬로 날려요.', 'LAUNCH')
----insert into dbo.tFVUserPushAndroid(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73799', 'guest73799', 'APA91bE5TtZI1T81gIpHN1o1IZuasNwm0PoaiG2xYDzOJ6AkW2H148vKqUdy7Oh1in0F-OZUo1VxUbwnNt-Jg1blX7c6sJ7wf92vzIsDy9sRBCtJK4GhauekcatxyM7rS_pvEla4A5Tj3GWQEH3JFOZFZSIrK4UDa7FZxUwLiWZpNrceCqaRct4', 1, 99, '홈런리그제목url', '홈런리그 내용푸쉬로 날려요.url', 'http://m.naver.com')
----


-----------------------------------------------
----	iPhone Push Service
----	짜요것을 사용.
-----------------------------------------------
--IF OBJECT_ID (N'dbo.tFVUserPushiPhone', N'U') IS NOT NULL
--	DROP TABLE dbo.tFVUserPushiPhone;
--GO
--
--create table dbo.tFVUserPushiPhone(
--	idx				int				identity(1, 1),
--
--	sendid			varchar(20),
--	receid			varchar(20),
--	recepushid		varchar(256),
--	sendkind		int,
--
--	msgpush_id		int				default(99),
--	msgtitle		varchar(512),
--	msgmsg			varchar(512),
--	msgaction		varchar(512)	default('LAUNCH'),
--
--	actionTime		datetime		default(getdate()),
--	scheduleTime	datetime		default(getdate()),
--
--	-- Constraint
--	CONSTRAINT	pk_tFVUserPushiPhone_idx	PRIMARY KEY(idx)
--)
----select top 1 * from dbo.tFVUserPushAndroidLog
------ Push입력하기
----insert into dbo.tFVUserPushiPhone(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73801', 'guest73801', 'APA91bF6Y96_WIvc3jQH83B2QoTUkcDcX2KAp6A5AGQfMQ_V4LZOjzKe7Wr-IVgXz-a2XS1A8hUIUZ6-0NmWkfkkQLqUMSYikMGA_P1Ejj42Z4e_VxRth84WJkMuhGjbvWUuwAVUdn90R5wlYe6P2W4hLMsyU8FeWjEXcHzFbRe2Fj8lH4CoOL0', 1, 99, '홈런리그제목', '홈런리그 내용푸쉬로 날려요.', 'LAUNCH')
----insert into dbo.tFVUserPushiPhone(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73801', 'guest73801', 'APA91bF6Y96_WIvc3jQH83B2QoTUkcDcX2KAp6A5AGQfMQ_V4LZOjzKe7Wr-IVgXz-a2XS1A8hUIUZ6-0NmWkfkkQLqUMSYikMGA_P1Ejj42Z4e_VxRth84WJkMuhGjbvWUuwAVUdn90R5wlYe6P2W4hLMsyU8FeWjEXcHzFbRe2Fj8lH4CoOL0', 1, 99, '홈런리그제목url', '홈런리그 내용푸쉬로 날려요.url', 'http://m.naver.com')
----insert into dbo.tFVUserPushiPhone(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73799', 'guest73799', 'APA91bE5TtZI1T81gIpHN1o1IZuasNwm0PoaiG2xYDzOJ6AkW2H148vKqUdy7Oh1in0F-OZUo1VxUbwnNt-Jg1blX7c6sJ7wf92vzIsDy9sRBCtJK4GhauekcatxyM7rS_pvEla4A5Tj3GWQEH3JFOZFZSIrK4UDa7FZxUwLiWZpNrceCqaRct4', 1, 99, '홈런리그제목', '홈런리그 내용푸쉬로 날려요.', 'LAUNCH')
----insert into dbo.tFVUserPushiPhone(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73799', 'guest73799', 'APA91bE5TtZI1T81gIpHN1o1IZuasNwm0PoaiG2xYDzOJ6AkW2H148vKqUdy7Oh1in0F-OZUo1VxUbwnNt-Jg1blX7c6sJ7wf92vzIsDy9sRBCtJK4GhauekcatxyM7rS_pvEla4A5Tj3GWQEH3JFOZFZSIrK4UDa7FZxUwLiWZpNrceCqaRct4', 1, 99, '홈런리그제목url', '홈런리그 내용푸쉬로 날려요.url', 'http://m.naver.com')



---------------------------------------------
--	Push Send Info
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserPushSendInfo', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserPushSendInfo;
GO

create table dbo.tFVUserPushSendInfo(
	idx				int				identity(1, 1),

	adminid			varchar(20),
	sendkind		int,
	market			int,

	msgtitle		varchar(512),
	msgmsg			varchar(512),
	msgurl			varchar(512)	default(''),

	cnt				int				default(0),
	writedate		datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tFVUserPushSendInfo_idx	PRIMARY KEY(idx)
)
-- select top 10 * from dbo.tFVUserPushSendInfo order by idx desc
-- insert into dbo.tFVUserPushSendInfo(adminid,  sendkind, market, msgtitle, msgmsg,  cnt)
-- values(				       	   @adminid,      @p3_,   @p4_,    @ps3_,  @ps4_, @cnt)
-- select max(idx), min(idx) from dbo.tFVUserPushiPhone
-- select max(idx), min(idx) from dbo.tFVUserPushAndroid
-- select distinct msgtitle, msgmsg from dbo.tFVUserPushiPhone
-- select distinct msgtitle, msgmsg from dbo.tFVUserPushAndroid
-- select top 10 * from dbo.tFVUserPushiPhone where msgtitle = '제목 iPhone'
-- select top 10 * from dbo.tFVUserPushAndroid where msgtitle = '제목 Google'
-- 삭제
-- delete from dbo.tFVUserPushiPhone  where msgtitle = '제목 iPhone'
-- delete from dbo.tFVUserPushAndroid where msgtitle = '제목 Google'
-- delete from dbo.tFVUserPushiPhone  where msgtitle = (select msgtitle from dbo.tFVUserPushSendInfo where idx = 1)
-- delete from dbo.tFVUserPushAndroid  where msgtitle = (select msgtitle from dbo.tFVUserPushSendInfo where idx = 1)


---------------------------------------------
--	PushBlackList
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVPushBlackList', N'U') IS NOT NULL
	DROP TABLE dbo.tFVPushBlackList;
GO

create table dbo.tFVPushBlackList(
	idx				int				identity(1, 1),

	phone			varchar(20),
	comment			varchar(512),
	writedate		datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tFVPushBlackList_idx	PRIMARY KEY(idx)
)
-- insert into dbo.tFVPushBlackList(phone, comment) select phone, comment from Farm.dbo.tFVPushBlackList
--insert into dbo.tFVPushBlackList(phone, comment) values('01036630157', '김세훈대표')
--insert into dbo.tFVPushBlackList(phone, comment) values('01055841110', '이대성 과장')
--insert into dbo.tFVPushBlackList(phone, comment) values('01051955895', '이정우')
--insert into dbo.tFVPushBlackList(phone, comment) values('01043358319', '김남훈')
--insert into dbo.tFVPushBlackList(phone, comment) values('01089114806', '김용민')
--insert into dbo.tFVPushBlackList(phone, comment) values('0183302149', '채문기')
--insert into dbo.tFVPushBlackList(phone, comment) values('01050457694', '이영지')
--insert into dbo.tFVPushBlackList(phone, comment) values('01048742835', '윤인좌 대리')
--insert into dbo.tFVPushBlackList(phone, comment) values('01024065144', '운영 김범수')
--insert into dbo.tFVPushBlackList(phone, comment) values('01027624701', '서버 김선일')
--insert into dbo.tFVPushBlackList(phone, comment) values('01090196756', '픽토_호스팅업체')


---------------------------------------------
-- 이벤트 인증키값
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVEventCertNo', N'U') IS NOT NULL
	DROP TABLE dbo.tFVEventCertNo;
GO

create table dbo.tFVEventCertNo(
	idx			int				identity(1, 1),
	certno		varchar(16),

	itemcode1	int				default(-1),
	itemcode2	int				default(-1),
	itemcode3	int				default(-1),
	cnt1		int				default(0),
	cnt2		int				default(0),
	cnt3		int				default(0),
	kind		int				default(0),

	CONSTRAINT	pk_tFVEventCertNo_idx	PRIMARY KEY(idx)
)
-- 인증번호 인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVEventCertNo_certno')
    DROP INDEX tFVEventCertNo.idx_tFVEventCertNo_certno
GO
CREATE INDEX idx_tFVEventCertNo_certno ON tFVEventCertNo (certno)
GO

---------------------------------------------
-- 이벤트 인증키값(백업)
-- 누구에게 무슨아이템을 지급했다.
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVEventCertNoBack', N'U') IS NOT NULL
	DROP TABLE dbo.tFVEventCertNoBack;
GO

create table dbo.tFVEventCertNoBack(
	idx			int				identity(1, 1),
	certno		varchar(16),

	gameid		varchar(60),
	market		int				default(5),
	itemcode1	int				default(-1),
	itemcode2	int				default(-1),
	itemcode3	int				default(-1),
	cnt1		int				default(0),
	cnt2		int				default(0),
	cnt3		int				default(0),
	usedtime	datetime		default(getdate()),
	kind		int				default(0),

	CONSTRAINT	pk_tFVEventCertNoBack_idx	PRIMARY KEY(idx)
)

-- 인증번호 인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVEventCertNoBack_certno')
    DROP INDEX tFVEventCertNoBack.idx_tFVEventCertNoBack_certno
GO
CREATE INDEX idx_tFVEventCertNoBack_certno ON tFVEventCertNoBack (certno)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVEventCertNoBack_gameid_kind')
    DROP INDEX tFVEventCertNoBack.idx_tFVEventCertNoBack_gameid_kind
GO
CREATE INDEX idx_tFVEventCertNoBack_gameid_kind ON tFVEventCertNoBack (gameid, kind)
GO




---------------------------------------------
--		이벤트 마스터
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVEventMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tFVEventMaster;
GO

create table dbo.tFVEventMaster(
	idx						int					IDENTITY(1,1),
	eventstatemaster		int					default(0),		-- 0:대기중, 1:진행중, 2:완료중

	-- Constraint
	CONSTRAINT	pk_tFVEventMaster_eventstatemaster	PRIMARY KEY(eventstatemaster)
)
-- 처음 데이타는 넣어줘야한다.
-- insert into dbo.tFVEventMaster(eventstatemaster) values(0)
-- update dbo.tFVEventMaster set eventstatemaster = case when eventstatemaster = 0 then 1 else 0 end where idx = 1
-- select eventstatemaster from dbo.tFVEventMaster where idx = 1

---------------------------------------------
--		이벤트 서브
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVEventSub', N'U') IS NOT NULL
	DROP TABLE dbo.tFVEventSub;
GO

create table dbo.tFVEventSub(
	eventidx		int					IDENTITY(1,1),
	eventstatedaily	int					default(0),					-- 0:EVENT_STATE_NON, 1:ING, 2:_END
	eventitemcode	int					default(-1),
	eventcnt		int					default(0),
	eventsender		varchar(60)			default('sangsang'),
	eventday		int					default(0),
	eventstarthour	int					default(0),
	eventendhour	int					default(0),

	eventpushtitle	varchar(512)		default(''),				-- 푸쉬 제목, 내용, 상태
	eventpushmsg	varchar(512)		default(''),				--
	eventpushstate	int					default(0),					-- 0:EVENT_PUSH_NON, 1:EVENT_PUSH_SEND

	writedate		datetime			default(getdate()),
	CONSTRAINT	pk_tFVEventSub_eventidx	PRIMARY KEY(eventidx)
)

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVEventSub_eventday_eventstarthour_eventendhour')
    DROP INDEX tFVEventSub.idx_tFVEventSub_eventday_eventstarthour_eventendhour
GO
CREATE INDEX idx_tFVEventSub_eventday_eventstarthour_eventendhour ON tFVEventSub (eventday, eventstarthour, eventendhour)
GO

--insert into dbo.tFVEventSub(eventitemcode,  eventsender,  eventday, eventstarthour, eventendhour,  eventpushtitle, eventpushmsg)
--values(                            1000,  'sangsang',         1,             12,           18,  '푸쉬 제목1',   '푸쉬 내용1')
--insert into dbo.tFVEventSub(eventitemcode,  eventsender,  eventday, eventstarthour, eventendhour,  eventpushtitle, eventpushmsg)
--values(                            1000,  'sangsang',         1,             19,           24,  '푸쉬 제목1-2',   '푸쉬 내용1-2')
--update dbo.tFVEventSub
--	set
--		eventstatedaily	= 1,
--		eventitemcode 	= 1000,
--		eventday		= 1,
--		eventstarthour	= 12,
--		eventendhour	= 18,
--		eventsender		= 'sangsang',
--		eventpushtitle	= '푸쉬 제목1',
--		eventpushmsg	= '푸쉬 내용1'
--where eventidx = 1
--update dbo.tFVEventSub set eventstatedaily	= 1 where eventidx = 2
--declare @curdate datetime 	set @curdate = '2014-09-02 23:59'
--declare @dd int 			set @dd = DATEPART(dd, @curdate)
--declare @hour int 			set @hour = DATEPART(hour, @curdate)
--select * from dbo.tFVEventSub where @dd = eventday and eventstarthour <= @hour and @hour <= eventendhour and eventstatedaily = 1
--select top 100 * from dbo.tFVEventSub order by eventidx desc



---------------------------------------------
--		이벤트 받아간 유저로그
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVEvnetUserGetLog', N'U') IS NOT NULL
	DROP TABLE dbo.tFVEvnetUserGetLog;
GO

create table dbo.tFVEvnetUserGetLog(
	idx				int					IDENTITY(1,1),

	gameid			varchar(60),
	eventidx		int,
	eventitemcode	int,
	writedate		datetime			default(getdate()),
	CONSTRAINT		pk_tFVEvnetUserGetLog_eventidx	PRIMARY KEY(idx)
)

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVEvnetUserGetLog_gameid_eventidx')
    DROP INDEX tFVEvnetUserGetLog.idx_tFVEvnetUserGetLog_gameid_eventidx
GO
CREATE INDEX idx_tFVEvnetUserGetLog_gameid_eventidx ON tFVEvnetUserGetLog (gameid, eventidx)
GO

-- insert into dbo.tFVEvnetUserGetLog(gameid, eventidx, eventitemcode) values( 'xxxx@gmail.com', 1, 1104)
-- select * from dbo.tFVEvnetUserGetLog where gameid = 'xxxx@gmail.com' and eventidx = 1






---------------------------------------------------
--	추천게임
---------------------------------------------------
IF OBJECT_ID (N'dbo.tFVSysRecommend2', N'U') IS NOT NULL
	DROP TABLE dbo.tFVSysRecommend2;
GO

create table dbo.tFVSysRecommend2(
	idx				int				IDENTITY(1,1), 			-- 번호
	packmarket		varchar(40)		default('1,2,3,4,5,6,7'),

	comfile			varchar(512)	default(''),
	comurl			varchar(512)	default(''),
	compackname		varchar(512)	default(''),
	rewarditemcode	int 			default(0),
	rewardcnt		int 			default(0),

	syscheck		int				default(-1),			-- 1:서비스중 	-1:보류
	ordering		int				default(0),				-- 높은것이 나옴.
	writedate		datetime		default(getdate()), 	-- 작성일

	-- Constraint
	CONSTRAINT	pk_tFVSysRecommend2_idx	PRIMARY KEY(idx)
)


---------------------------------------------------
--	추천게임 로고
---------------------------------------------------
IF OBJECT_ID (N'dbo.tFVSysRecommendLog', N'U') IS NOT NULL
	DROP TABLE dbo.tFVSysRecommendLog;
GO

create table dbo.tFVSysRecommendLog(
	idx				int				IDENTITY(1,1), 			-- 번호

	gameid			varchar(60),
	recommendidx	int 			default(0),
	writedate		datetime		default(getdate()), 	-- 작성일

	-- Constraint
	CONSTRAINT	pk_tFVSysRecommendLog_idx	PRIMARY KEY(idx)
)



---------------------------------------------
--		Kakao Master
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVKakaoMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tFVKakaoMaster;
GO

create table dbo.tFVKakaoMaster(
	idx				int					IDENTITY(1,1),

	kakaouserid		varchar(60),
	kakaotalkid		varchar(60),
	gameid			varchar(60),
	cnt				int					default(1),					-- 보유량
	cnt2			int					default(0),
	kakaodata		int					default(1),					-- 카톡유저(1), 게스트유저(1)
	writedate		datetime			default(getdate()),
	deldate			datetime			default(getdate() - 1),

	-- Constraint
	CONSTRAINT	pk_tFVKakaoMaster_kakaotalkid	PRIMARY KEY(kakaouserid)
)

--IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVKakaoMaster_kakaotalkid')
--    DROP INDEX tFVKakaoMaster.idx_tFVKakaoMaster_kakaotalkid
--GO
--CREATE INDEX idx_tFVKakaoMaster_kakaotalkid ON tFVKakaoMaster (kakaotalkid)
--GO
--
--IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVKakaoMaster_idx')
--    DROP INDEX tFVKakaoMaster.idx_tFVKakaoMaster_idx
--GO
--CREATE INDEX idx_tFVKakaoMaster_idx ON tFVKakaoMaster (idx)
--GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVKakaoMaster_gameid')
    DROP INDEX tFVKakaoMaster.idx_tFVKakaoMaster_gameid
GO
CREATE INDEX idx_tFVKakaoMaster_gameid ON tFVKakaoMaster (gameid)
GO

---------------------------------------------
--		Kakao 초대
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVKakaoInvite', N'U') IS NOT NULL
	DROP TABLE dbo.tFVKakaoInvite;
GO

create table dbo.tFVKakaoInvite(
	idx				int					IDENTITY(1,1),

	gameid			varchar(60),
	receuserid		varchar(60),
	cnt				int					default(1),
	senddate		datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tFVKakaoInvite_idx	PRIMARY KEY(idx)
)

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVKakaoInvite_gameid_receuserid')
    DROP INDEX tFVKakaoInvite.idx_tFVKakaoInvite_gameid_receuserid
GO
CREATE INDEX idx_tFVKakaoInvite_gameid_receuserid ON tFVKakaoInvite (gameid, receuserid)
GO

-- select top 1 * from dbo.tFVKakaoInvite where gameid = 'xxxx@gmail.com' and receuserid = 'kakaotalkid13'
-- select datediff(d, '2014-03-01 12:20', '2014-03-06 12:20')	-- 5일차
-- insert into dbo.tFVKakaoInvite(gameid, receuserid) values('xxxx@gmail.com', 'kakaotalkid13')
-- update dbo.tFVKakaoInvite
--	set
--		cnt = cnt + 1,
--		senddate = getdate()
--	where gameid = 'xxxx@gmail.com' and receuserid = 'kakaotalkid13'



---------------------------------------------
--		친구
-- 	삭제는 진짜 삭제
--	친구는 100명까지만
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserFriend', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserFriend;
GO

create table dbo.tFVUserFriend(
	idx				int				IDENTITY(1,1),
	gameid			varchar(60)		NOT NULL,

	friendid		varchar(60)		NOT NULL, 				-- 친구아이디
	familiar		int				default(1), 			-- 친밀도(교배+1)
	state			int				default(0),				-- 친구신청(0), 친구대기(1), 친구수락(2)
	senddate		datetime		default(getdate()),		-- 하트보낸날 1일후에 다시 보낸수 있음.
	kakaofriendkind	int				default(1),				-- 게임친구(1), 카카오친구(2)
	helpdate		datetime		default(getdate() - 1),	-- 친구가 도와줘 요청을 할 경우(동물).
	rentdate		datetime		default(getdate() - 1),	-- 친구동물을 빌려서 사용하기.

	writedate		datetime		default(getdate()), 	-- 등록일
	-- Constraint
	CONSTRAINT pk_tFVUserFriend_gameid_friendid	PRIMARY KEY(gameid, friendid)
)

--암기 > 포인트
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserFriend_gameid_familiar')
    DROP INDEX tFVUserFriend.idx_tFVUserFriend_gameid_familiar
GO
CREATE INDEX idx_tFVUserFriend_gameid_familiar ON tFVUserFriend(gameid, familiar desc)
GO

-- xxxx > 친구들
--insert into dbo.tFVUserFriend(gameid, friendid) values('xxxx', 'xxxx@gmail.com')
--insert into dbo.tFVUserFriend(gameid, friendid) values('xxxx', 'xxxx3')
--insert into dbo.tFVUserFriend(gameid, friendid) values('xxxx', 'xxxx4')
--insert into dbo.tFVUserFriend(gameid, friendid) values('xxxx', 'xxxx5')

--select * from dbo.tFVUserFriend where gameid = 'xxxx'
--select * from dbo.tFVUserFriend where gameid = 'xxxx' order by familiar desc
--update dbo.tFVUserFriend set familiar = familiar + 1 where gameid = @gameid_ and friendid = @friendid_




---------------------------------------------
--		유저 블럭킹
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserBlockLog', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserBlockLog;
GO

create table dbo.tFVUserBlockLog(
	idx				int				IDENTITY(1,1),
	gameid			varchar(60), 							-- 아이디
	comment			varchar(512), 							-- 시스템코멘트
	writedate		datetime		default(getdate()), 	-- 블록일
	blockstate		int				default(1), 			-- 블럭상태 	0 : 블럭상태아님	1 : 블럭상태

	adminid			varchar(20),
	adminip			varchar(40),
	comment2		varchar(512),							-- 코멘트
	releasedate		datetime								-- 해제일

	-- Constraint
	CONSTRAINT pk_tFVUserBlockLog_idx PRIMARY KEY(idx)
)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserBlockLog_gameid_idx')
    DROP INDEX tFVUserBlockLog.idx_tFVUserBlockLog_gameid_idx
GO
CREATE INDEX idx_tFVUserBlockLog_gameid_idx ON tFVUserBlockLog(gameid, idx)
GO
-- 블럭 당하는 유저가 중복이 발생할 수 있다. 한번 블럭당하고 또 블럭당한다. 즉 중복 블럭을 당한다.
-- insert into dbo.tFVUserBlockLog(gameid, comment) values(@gameid_, '아이템를 '+ltrim(rtrim(str(@cashcopy)))+'회 이상 카피를 해서 로그인시 시스템에서 블럭 처리했습니다.')
-- update dbo.tFVUserMaster set blockstate = '0' where gameid = 'DD0'
-- update dbo.tFVUserBlockLog set blockstate = 0, adminid = 'SangSang', adminip = '172.0.0.1', comment2 = '풀어주었다.', releasedate = getdate() where idx = 17
-- select * from dbo.tFVUserBlockLog order by idx desc
-- select idx, gameid, comment, writedate, blockstate, adminid, comment2, releasedate from dbo.tFVUserBlockLog order by idx desc
-- select top 20 * from dbo.tFVUserBlockLog where gameid = 'DD0' order by idx desc



---------------------------------------------
--	친구랭킹[백업스케쥴러]
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserMasterSchedule', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserMasterSchedule;
GO

create table dbo.tFVUserMasterSchedule(
	idx				int					identity(1, 1),

	dateid			varchar(8),										-- 20121118
	idxStart		int					default(0),
	writedate		datetime			default(getdate()), 		-- 작성일

	-- Constraint
	CONSTRAINT pk_tUserMasterSchedule_dateid	PRIMARY KEY(dateid)
)
GO

-- select * from dbo.tFVUserMasterSchedule
-- if(not exist(select dateid from dbo.tFVUserMasterSchedule where dateid = '20131227'))
-- 		insert into dbo.tFVUserMasterSchedule(dateid, idxStart) values('20131227', 1)
-- update tFVUserMasterSchedule
-- 	set
--		idxStart = idx
-- where dateid = '20121118'




---------------------------------------------
--	유저랭킹백엄(Master)
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserRankMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserRankMaster;
GO

create table dbo.tFVUserRankMaster(
	idx				int					identity(1, 1),

	dateid			varchar(8),										-- 20121118
	step			int					default(0),
	writedate		datetime			default(getdate()), 		-- 작성일

	-- Constraint
	CONSTRAINT pk_tFVUserRankMaster_dateid	PRIMARY KEY(dateid)
)
GO
-- select * from dbo.tFVUserRankMaster where dateid = '20150216'

---------------------------------------------
--		유저랭킹백엄(Sub)
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserRankSub', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserRankSub;
GO

create table dbo.tFVUserRankSub(
	idx			int 					IDENTITY(1, 1),			-- indexing

	dateid8		varchar(8),

	rank		int,
	gameid		varchar(60),
	salemoney	bigint					default(0),
	bestani		int						default(500),
	nickname	varchar(20)				default(''),

	-- Constraint
	CONSTRAINT pk_tFVUserRankSub_dateid8_rank	PRIMARY KEY(dateid8, rank)
)
GO



---------------------------------------------
--		무료충전
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVFreeCashLog', N'U') IS NOT NULL
	DROP TABLE dbo.tFVFreeCashLog;
GO

create table dbo.tFVFreeCashLog(
	idx			int 					IDENTITY(1, 1),			-- indexing

	--(유저정보)
	gameid		varchar(60),									-- 이메일(PK)
	bestani		int						default(500),
	cashcost	int						default(0),

	-- Constraint
	CONSTRAINT pk_tFVFreeCashLog_idx		PRIMARY KEY(idx)
)
GO

--유저로그검색
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVFreeCashLog_gameid')
    DROP INDEX tFVFreeCashLog.idx_tFVFreeCashLog_gameid
GO
CREATE INDEX idx_tFVFreeCashLog_gameid ON tFVFreeCashLog (gameid)
GO



---------------------------------------------
--		유저닉네임변경
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserNickNameChange', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserNickNameChange;
GO

create table dbo.tFVUserNickNameChange(
	idx			int 					IDENTITY(1, 1),

	--(유저정보)
	gameid		varchar(60),
	oldnickname	varchar(20)				default(''),
	newnickname	varchar(20)				default(''),
	writedate	datetime				default(getdate()),

	-- Constraint
	CONSTRAINT pk_tFVUserNickNameChange_idx	PRIMARY KEY(idx)
)
GO
--insert into dbo.tFVUserNickNameChange(gameid, oldnickname, newnickname) values('xxxx@gmail.com', 'oldname', 'newname')




---------------------------------------------
-- 뽑기이벤트 관리 내용.
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVSystemRouletteMan', N'U') IS NOT NULL
	DROP TABLE dbo.tFVSystemRouletteMan;
GO

create table dbo.tFVSystemRouletteMan(
	idx					int 				IDENTITY(1, 1),

	roulmarket			int					default(5),

	-- 0.특정시간에 확률상승.
	roulsaleflag		int					default(-1),
	roulsalevalue		int					default(0),

	-- 1.특정보물 보상받기.
	roulflag			int					default(-1),
	roulstart			datetime			default('2014-01-01'),
	roulend				datetime			default('2024-01-01'),
	roulani1			int					default(-1),
	roulani2			int					default(-1),
	roulani3			int					default(-1),
	roulreward1			int					default(-1),
	roulreward2			int					default(-1),
	roulreward3			int					default(-1),
	roulrewardcnt1		int					default(0),
	roulrewardcnt2		int					default(0),
	roulrewardcnt3		int					default(0),
	roulname1			varchar(20)			default(''),
	roulname2			varchar(20)			default(''),
	roulname3			varchar(20)			default(''),

	-- 2.특정시간에 확률상승.
	roultimeflag		int					default(-1),
	roultimetime1		int					default(-1),
	roultimetime2		int					default(-1),
	roultimetime3		int					default(-1),

	-- 3.프리미엄 무료뽑기.
	pmgauageflag		int					default(-1),
	pmgauagepoint		int					default(10),
	pmgauagemax			int					default(100),

	-- 4.강화비용 할인.
	tsupgradesaleflag	int					default(-1),
	tsupgradesalevalue	int					default(0),

	-- 5.회전판 무료뽑기.
	wheelgauageflag		int					default(-1),
	wheelgauagepoint	int					default(10),
	wheelgauagemax		int					default(100),

	--코멘트.
	comment				varchar(256)		default(''),
	writedate			datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tFVSystemRouletteMan_idx	PRIMARY KEY(idx)
)
-- select top 1 * from dbo.tFVSystemRouletteMan where roulmarket like '%5%' order by idx desc
-- insert into dbo.tFVSystemRouletteMan(roulmarket,      roulflag,    roulstart,      roulend, roulani1, roulani2, roulani3, roulreward1, roulreward2, roulreward3,       roulname1,       roulname2,       roulname3, roultimeflag, roultimetime1, roultimetime2, roultimetime3, comment)
-- values                              (         5,        1, '2013-09-01', '2023-09-01',    80000,    80001,    80006,        3015,        3015,        3015,  '콩나물 화분D', '오래된 라디오D', '콩나물 화분A',            1,             12,            18,            23, '최초내용')
-- update dbo.tFVSystemRouletteMan set roulflag = -1 where idx = 3

--insert into dbo.tFVSystemRouletteMan(roulmarket,      roulflag,    roulstart,      roulend, roulani1, roulani2, roulani3, roulreward1, roulreward2, roulreward3,       roulname1,       roulname2,       roulname3, roultimeflag, roultimetime1, roultimetime2, roultimetime3, comment)
--values                              (         1,             1, '2013-09-01', '2023-09-01',    80000,    80001,    80006,        3015,        3015,        3015,  '콩나물 화분D', '오래된 라디오D', '콩나물 화분A',            1,            12,            18,            23, '최초내용')
--insert into dbo.tFVSystemRouletteMan(roulmarket,      roulflag,    roulstart,      roulend, roulani1, roulani2, roulani3, roulreward1, roulreward2, roulreward3,       roulname1,       roulname2,       roulname3, roultimeflag, roultimetime1, roultimetime2, roultimetime3, comment)
--values                              (         5,             1, '2013-09-01', '2023-09-01',    80000,    80001,    80006,        3015,        3015,        3015,  '콩나물 화분D', '오래된 라디오D', '콩나물 화분A',            1,             12,            18,            23, '최초내용')
--insert into dbo.tFVSystemRouletteMan(roulmarket,      roulflag,    roulstart,      roulend, roulani1, roulani2, roulani3, roulreward1, roulreward2, roulreward3,       roulname1,       roulname2,       roulname3, roultimeflag, roultimetime1, roultimetime2, roultimetime3, comment)
--values                              (         6,             1, '2013-09-01', '2023-09-01',    80000,    80001,    80006,        3015,        3015,        3015,  '콩나물 화분D', '오래된 라디오D', '콩나물 화분A',            1,             12,            18,            23, '최초내용')
--insert into dbo.tFVSystemRouletteMan(roulmarket,      roulflag,    roulstart,      roulend, roulani1, roulani2, roulani3, roulreward1, roulreward2, roulreward3,       roulname1,       roulname2,       roulname3, roultimeflag, roultimetime1, roultimetime2, roultimetime3, comment)
--values                              (         7,             1, '2013-09-01', '2023-09-01',    80000,    80001,    80006,        3015,        3015,        3015,  '콩나물 화분D', '오래된 라디오D', '콩나물 화분A',            1,             12,            18,            23, '최초내용')



---------------------------------------------
--		유저닉네임변경
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVRankDaJun', N'U') IS NOT NULL
	DROP TABLE dbo.tFVRankDaJun;
GO

create table dbo.tFVRankDaJun(
	idx			int 					IDENTITY(1, 1),

	--(날짜정보)
	rkdateid8		varchar(8),
	rkteam1			int					default(0),				-- 홀팀점수
	rkteam0			int					default(0),				-- 짝팀점수
	rkreward		int					default(0),				-- 미지급(0), 지급(1)

	-- 홀수.
	rksalemoney		bigint				default(0),				-- 판매수익(0).
	rkproductcnt	bigint				default(0),				-- 생산수량(30).
	rkfarmearn		bigint				default(0),				-- 목장수익(31).
	rkwolfcnt		bigint				default(0),				-- 늑대사냥(32).
	rkfriendpoint	bigint				default(0),				-- 친구포인트(자동수집).
	rkroulettecnt	bigint				default(0),				-- 룰렛횟수(20, 21).
	rkplaycnt		bigint				default(0),				-- 플레이타임(33).

	-- 짝수.
	rksalemoney2	bigint				default(0),				-- 판매수익(0).
	rkproductcnt2	bigint				default(0),				-- 생산수량(30).
	rkfarmearn2		bigint				default(0),				-- 목장수익(31).
	rkwolfcnt2		bigint				default(0),				-- 늑대사냥(32).
	rkfriendpoint2	bigint				default(0),				-- 친구포인트(자동수집).
	rkroulettecnt2	bigint				default(0),				-- 룰렛횟수(20, 21).
	rkplaycnt2		bigint				default(0),				-- 플레이타임(33).

	-- Constraint
	CONSTRAINT pk_tFVRankDaJun_rkdateid8	PRIMARY KEY(rkdateid8)
)
GO







---------------------------------------------
--		구매했던 로그(개인)
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserItemBuyLog', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserItemBuyLog;
GO

create table dbo.tFVUserItemBuyLog(
	idx			int					IDENTITY(1,1), 					-- 번호
	idx2		int,

	gameid		varchar(60), 										-- 유저id
	ownercashcost bigint			default(0),
	itemcode	int, 												-- 아이템코드, 중복 구매기록한다.
	buydate2	varchar(8),											-- 구매일20131010
	cnt			int					default(1), 					--

	cashcost	int					default(0), 					-- 구매가격(세일할수있어서)
	gamecost	int					default(0),
	heart		int					default(0),
	buydate		datetime			default(getdate()), 			-- 구매일

	-- Constraint
	CONSTRAINT	pk_tFVUserItemBuyLog_idx	PRIMARY KEY(idx)
)
-- select top 1 * from dbo.tFVUserItemBuyLog
--select top 20 * from dbo.tFVUserItemBuyLog a join dbo.tFVItemInfo b on a.itemcode = b.itemcode where gameid = 'xxxx' order by a.idx desc
--select top 20 a.idx 'idx', gameid, a.itemcode 'itemcode', a.cashcost 'cashcost', a.gamecost 'gamecost', a.buydate, b.itemname, b.gamecost 'coinball2', b.cashcost 'milkball2', b.period, b.explain from dbo.tFVUserItemBuyLog a join dbo.tFVItemInfo b on a.itemcode = b.itemcode where gameid = 'SangSang' order by a.idx desc
--select top 20 * from dbo.tFVUserItemBuyLog where buydate between '2012-08-09 00:00:01' and '2012-08-10 00:00:01' order by idx desc
--insert into dbo.tFVUserItemBuyLog(gameid, itemcode, cashcost, gamecost) values('xxxx', 1, 5,  0)
--insert into dbo.tFVUserItemBuyLog(gameid, itemcode, cashcost, gamecost) values('xxxx', 1, 0, 50)
--통계용 인덱스
--IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserItemBuyLog_buydate')
--    DROP INDEX tFVUserItemBuyLog.idx_tFVUserItemBuyLog_buydate
--GO
--CREATE INDEX idx_tFVUserItemBuyLog_buydate ON tFVUserItemBuyLog (buydate)
--GO

--유저 검색용 인덱스
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserItemBuyLog_gameid_idx')
    DROP INDEX tFVUserItemBuyLog.idx_tFVUserItemBuyLog_gameid_idx
GO
CREATE INDEX idx_tFVUserItemBuyLog_gameid_idx ON tFVUserItemBuyLog (gameid, idx)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserItemBuyLog_gameid_idx2')
    DROP INDEX tFVUserItemBuyLog.idx_tFVUserItemBuyLog_gameid_idx2
GO
CREATE INDEX idx_tFVUserItemBuyLog_gameid_idx2 ON tFVUserItemBuyLog (gameid, idx2)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserItemBuyLog_gameid_buydate2_itemcode')
    DROP INDEX tFVUserItemBuyLog.idx_tFVUserItemBuyLog_gameid_buydate2_itemcode
GO
CREATE INDEX idx_tFVUserItemBuyLog_gameid_buydate2_itemcode ON tFVUserItemBuyLog (gameid, buydate2, itemcode)
GO


---------------------------------------------
-- 	구매했던 로그(월별 Master)
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserItemBuyLogTotalMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserItemBuyLogTotalMaster;
GO

create table dbo.tFVUserItemBuyLogTotalMaster(
	idx				int				identity(1, 1),
	dateid8			char(8),							-- 20101210

	cashcost		bigint			default(0),
	gamecost		bigint			default(0),
	heart			bigint			default(0),
	cnt				int				default(0),

	-- Constraint
	CONSTRAINT	pk_tFVUserItemBuyLogTotalMaster_dateid	PRIMARY KEY(dateid8)
)
-- select         * from dbo.tFVUserItemBuyLogTotalMaster
-- select top 1   * from dbo.tFVUserItemBuyLogTotalMaster where dateid8 = '20120818'
-- insert into dbo.tFVUserItemBuyLogTotalMaster(dateid8, gamecost, cashcost, cnt) values('20120818', 100, 0, 1)
--update dbo.tFVUserItemBuyLogTotalMaster
--	set
--		gamecost = gamecost + 1,
--		cashcost = cashcost + 1,
--		heart	 = heart + 1,
--		cnt = cnt + 1
--where dateid8 = '20120818'


---------------------------------------------
-- 	구매했던 로그(월별 Sub)
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserItemBuyLogTotalSub', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserItemBuyLogTotalSub;
GO

create table dbo.tFVUserItemBuyLogTotalSub(
	idx				int				identity(1, 1),

	dateid8			char(8),							-- 20101210
	itemcode		int,

	cashcost		int				default(0),
	gamecost		int				default(0),
	heart			int				default(0),
	cnt				int				default(0),

	-- Constraint
	CONSTRAINT	pk_tFVUserItemBuyLogTotalSub_dateid8_itemcode	PRIMARY KEY(dateid8, itemcode)
)
-- select top 100 * from dbo.tFVUserItemBuyLogTotalSub order by dateid8 desc, itemcode desc
-- select         * from dbo.tFVUserItemBuyLogTotalSub where dateid8 = '20120818'
-- select top 1   * from dbo.tFVUserItemBuyLogTotalSub where dateid8 = '20120818' and itemcode = 1
--update dbo.tFVUserItemBuyLogTotalSub
--	set
--		gamecost = gamecost + 1,
--		cashcost = cashcost + 1,
--		heart 	= heart + 1,
--		cnt = cnt + 1
--where dateid8 = '20120818' and itemcode = 1
-- insert into dbo.tFVUserItemBuyLogTotalSub(dateid8, itemcode, cashcost, gamecost, cnt) values('20120818', 1, 100, 0, 1)


---------------------------------------------
-- 	구매했던 로그(월별 누적)
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserItemBuyLogMonth', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserItemBuyLogMonth;
GO

create table dbo.tFVUserItemBuyLogMonth(
	idx				int				identity(1, 1),

	dateid6			char(6),							-- 201012
	itemcode		int,

	cashcost		bigint			default(0),
	gamecost		bigint			default(0),
	heart			int				default(0),
	cnt				int				default(0),

	-- Constraint
	CONSTRAINT	pk_tFVUserItemBuyLogMonth_dateid6_itemcode	PRIMARY KEY(dateid6, itemcode)
)
-- select top 100 * from dbo.tFVUserItemBuyLogMonth order by dateid6 desc, itemcode desc
-- select         * from dbo.tFVUserItemBuyLogMonth where dateid6 = '201309'
-- select top 1   * from dbo.tFVUserItemBuyLogMonth where dateid6 = '201309' and itemcode = 1
-- insert into dbo.tFVUserItemBuyLogMonth(dateid6, itemcode, gamecost, cashcost, cnt) values('201309', 1, 100, 0, 1)
--update dbo.tFVUserItemBuyLogMonth
--	set
--		gamecost = gamecost + 1,
--		cashcost = cashcost + 1,
--		heart 	= heart + 1,
--		cnt = cnt + 1
--where dateid6 = '201309' and itemcode = 1





---------------------------------------------
-- 	룰렛 로그 > 개인자료
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVRouletteLogPerson', N'U') IS NOT NULL
	DROP TABLE dbo.tFVRouletteLogPerson;
GO

create table dbo.tFVRouletteLogPerson(
	idx				int				identity(1, 1),

	gameid			varchar(60),
	kind			int,
	bestani			int,
	itemcode		int,
	itemcodename	varchar(40),

	ownercashcost 	bigint			default(0),
	ownercashcost2 	bigint			default(0),
	strange			int				default(-1),	-- 이상함(1) 정상(-1), 강제정상(-2)

	cashcost		int				default(0),
	gamecost		int				default(0),
	heart			int				default(0),

	itemcode0		int				default(-1),
	itemcode1		int				default(-1),
	itemcode2		int				default(-1),
	itemcode3		int				default(-1),
	itemcode4		int				default(-1),
	itemcode0name	varchar(40)		default(''),
	itemcode1name	varchar(40)		default(''),
	itemcode2name	varchar(40)		default(''),
	itemcode3name	varchar(40)		default(''),
	itemcode4name	varchar(40)		default(''),

	writedate		datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tFVRouletteLogPerson_idx PRIMARY KEY(idx)
)
-- gameid, idx
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVRouletteLogPerson_gameid_idx')
	DROP INDEX tFVRouletteLogPerson.idx_tFVRouletteLogPerson_gameid_idx
GO
CREATE INDEX idx_tFVRouletteLogPerson_gameid_idx ON tFVRouletteLogPerson (gameid, idx)
GO
-- select top 100 * from dbo.tFVRouletteLogPerson where gameid = 'xxxx@gmail.com' order by idx desc


---------------------------------------------
-- 	교배뽑기했던 로그(월별 Master)
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVRouletteLogTotalMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tFVRouletteLogTotalMaster;
GO

create table dbo.tFVRouletteLogTotalMaster(
	idx				int				identity(1, 1),
	dateid8			char(8),							-- 20101210

	tsgrade1cnt		int				default(0),			-- 보물뽑기.
	tsgrade2cnt		int				default(0),
	tsgrade3cnt		int				default(0),
	tsgrade4cnt		int				default(0),
	tsgrade2freecnt	int				default(0),
	tsgrade3freecnt	int				default(0),
	tsgrade4freecnt	int				default(0),

	roulettecnt		int				default(0),			-- 룰렛.
	roulettefreecnt	int				default(0),

	-- Constraint
	CONSTRAINT	pk_tFVRouletteLogTotalMaster_dateid	PRIMARY KEY(dateid8)
)
-- select top 1   * from dbo.tFVRouletteLogTotalMaster where dateid8 = '20120818'
-- insert into dbo.tFVRouletteLogTotalMaster(dateid8) values('20120818')
--update dbo.tFVRouletteLogTotalMaster
--	set
--		premiumcnt 	= premiumcnt + 1,
--		normalcnt 	= normalcnt + 1
--where dateid8 = '20120818'


---------------------------------------------
-- 	교배뽑기했던 로그(월별 Sub)
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVRouletteLogTotalSub', N'U') IS NOT NULL
	DROP TABLE dbo.tFVRouletteLogTotalSub;
GO

create table dbo.tFVRouletteLogTotalSub(
	idx				int				identity(1, 1),

	dateid8			char(8),							-- 20101210
	itemcode		int,
	itemcodename	varchar(40)		default(''),

	tsgrade1cnt		int				default(0),			-- 보물뽑기.
	tsgrade2cnt		int				default(0),
	tsgrade3cnt		int				default(0),
	tsgrade4cnt		int				default(0),
	tsgrade2freecnt	int				default(0),
	tsgrade3freecnt	int				default(0),
	tsgrade4freecnt	int				default(0),

	roulettecnt		int				default(0),			-- 룰렛.
	roulettefreecnt	int				default(0),

	-- Constraint
	CONSTRAINT	pk_tFVRouletteLogTotalSub_dateid8_itemcode	PRIMARY KEY(dateid8, itemcode)
)
-- select top 1   * from dbo.tFVRouletteLogTotalSub where dateid8 = '20120818' and itemcode = 1
--update dbo.tFVRouletteLogTotalSub
--	set
--		premiumcnt 	= premiumcnt + 1,
--		normalcnt	= normalcnt + 1
--where dateid8 = '20120818' and itemcode = 1
-- insert into dbo.tFVRouletteLogTotalSub(dateid8, itemcode) values('20120818', 1)





---------------------------------------------
-- 	룰렛 로그 > 광고용 로그.
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserAdLog', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserAdLog;
GO

create table dbo.tFVUserAdLog(
	idx				int				identity(1, 1),

	gameid			varchar(60),
	nickname		varchar(40),
	itemcode		int,
	comment			varchar(128)	default(''),
	mode			int				default(1),

	writedate		datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tFVUserAdLog_idx PRIMARY KEY(idx)
)
-- insert into dbo.tFVUserAdLog(gameid, itemcode, comment) values('xxxx@gmail.com', 101, 'xxxx2님이 양을 교배로 얻었습니다.')
-- delete from dbo.tFVUserAdLog where idx = @idx - 100
-- update dbo.tFVUserAdLog set adidx = @idx where gameid = @gameid_
-- select top 100 * from dbo.tFVUserAdLog where gameid = 'xxxx@gmail.com' order by idx desc



---------------------------------------------
-- 	유저강화 로그기록(200까지만 관리).
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserUpgradeLog', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserUpgradeLog;
GO

create table dbo.tFVUserUpgradeLog(
	idx				int				identity(1, 1),

	gameid			varchar(60),
	idx2			int,
	mode			int,		-- 일반강화(1). 결정강화(2).
	itemcode		int,		--
	step			int,		-- 1 (1 -> 2단계 업을 의미).
	results			int,		-- 성공(1), 실패(-1).
	ownercashcost	bigint,		-- 보유결정.
	ownercashcost2	bigint,		-- 보유결정.
	cashcost		int,		-- 결정비용.
	heart			int,		-- 하트비용.
	strange			int,		-- 이상함(1) 정상(-1), 강제정상(-2)
	writedate		datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tFVUserUpgradeLog_idx PRIMARY KEY(idx)
)
-- 인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserUpgradeLog_gameid_idx2')
    DROP INDEX tFVUserUpgradeLog.idx_tFVUserUpgradeLog_gameid_idx2
GO
CREATE INDEX idx_tFVUserUpgradeLog_gameid_idx2 ON tFVUserUpgradeLog (gameid, idx2)
GO



---------------------------------------------
-- 	유저강화 로그기록(200까지만 관리).
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserWheelLog', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserWheelLog;
GO

create table dbo.tFVUserWheelLog(
	idx				int				identity(1, 1),

	gameid			varchar(60),
	idx2			int,
	mode			int,		-- 일일룰렛(20), 결정룰렛(21), 황금무료(22)
	cashcost		int,		-- 결정비용.

	ownercashcost	bigint,		-- 보유결정.
	ownercashcost2	bigint,		-- 보유결정.
	strange			int,		-- 이상함(1) 정상(-1), 강제정상(-2)
	writedate		datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tFVUserWheelLog_idx PRIMARY KEY(idx)
)
-- 인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserWheelLog_gameid_idx2')
    DROP INDEX tFVUserWheelLog.idx_tFVUserWheelLog_gameid_idx2
GO
CREATE INDEX idx_tFVUserWheelLog_gameid_idx2 ON tFVUserWheelLog (gameid, idx2)
GO