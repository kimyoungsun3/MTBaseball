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
	phone		varchar(20)				default(''),			-- indexing
	market		int						default(5),				-- (구매처코드)
	buytype		int						default(0),				-- (무료/유료코드)
	version		int						default(101),			-- 클라버젼
	concode		int						default(82),			-- 한국(82), 일본(81), 미국(1)
	pushid		varchar(256)			default(''),

	-- 유저 정보
	nickname	varchar(20)				default(''),			-- 별칭(닉네임)
	nickcnt		int						default(1),

	regdate		datetime				default(getdate()),		-- 최초가입일
	condate		datetime				default(getdate()),		-- (로그인시마다 매번업데이트)
	concnt		int						default(1),				-- 접속횟수
	logindate	varchar(8)				default('20100101'),	--
	savebktime	datetime				default(getdate() - 1),		-- 백업한 타임

	-- 초대정보
	kakaomsginvitecnt		int			default(0), 			-- 			초대.
	kakaomsginvitecntbg		int			default(0), 			-- 			초대bg.
	kakaomsginvitetodaycnt	int			default(0),				-- 			오늘 초대인원수.
	kakaomsginvitetodaydate	datetime	default(getdate()),		-- 			오늘 날짜.

	blockstate	int						default(0),				-- 0 : 블럭상태아님, 1 : 블럭상태
	cashcopy	int						default(0),				-- 캐쉬불법카피시 +1추가된다.
	resultcopy	int						default(0),				-- 로그결과카피시 +1추가된다.
	bestani		int						default(500),
	cashpoint	int						default(0),
	cashcost	bigint					default(0),				-- 결정.
	vippoint	int						default(0),
	ownercashcost	bigint				default(0),

	randserial	varchar(20)				default('-1'),			-- 랜덤씨리얼
	bgitemcode1	int						default(-1),
	bgitemcode2	int						default(-1),
	bgitemcode3	int						default(-1),
	bgcnt1		int						default(0),
	bgcnt2		int						default(0),
	bgcnt3		int						default(0),
	logwrite2	int						default(1),

	-- 클라이언트 데이타.
	cashcost2	bigint					default(0),				-- 결정.
	vippoint2	int						default(0),				--
	salemoney2	bigint					default(0),

	-- 회전판.
	roulette	int						default(1),
	roulettefreecnt	int					default(0),
	roulettepaycnt	int					default(0),
	roulettegoldcnt	int					default(0),
	wheelgauage	int						default(0),				-- 회전판(게이지값)
	wheelfree	int						default(0),				-- 1이면 무료회전.

	-- (뽑기)
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

	-- 이벤트.
	eventspot06		int					default(0),				-- 쿠폰에서 사용.
	eventspot07		int					default(0),				-- 쿠폰에서 사용.
	eventspot08		int					default(0),				-- 쿠폰에서 사용.
	eventspot09		int					default(0),				-- 쿠폰에서 사용.
	eventspot10		int					default(0),				-- 쿠폰에서 사용.
	eventspot0x		int					default(0),

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

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserMaster_salemoney2')
   DROP INDEX tFVUserMaster.idx_tFVUserMaster_salemoney2
GO
CREATE INDEX idx_tFVUserMaster_salemoney2 ON tFVUserMaster (salemoney2)
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
	market		int						default(5),				-- (구매처코드)
	savestate	int						default(1),				-- 1(save), -1(읽어감)
	savedata	varchar(4096)			default('-1'),

	-- Constraint
	CONSTRAINT pk_tFVUserData_gameid	PRIMARY KEY(gameid, market)
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
	comfile6		varchar(512)	default(''),
	comurl6			varchar(512)	default(''),
	comfile7		varchar(512)	default(''),
	comurl7			varchar(512)	default(''),
	comfile8		varchar(512)	default(''),
	comurl8			varchar(512)	default(''),
	comfile9		varchar(512)	default(''),
	comurl9			varchar(512)	default(''),
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

	joinukcnt		int				default(0),					-- 일 유니크 가입(무료)
	joinukcnt2		int				default(0),					-- 일 유니크 가입(유료)
	logincnt		int				default(0),					-- 일 로그인(중복)
	logincnt2		int				default(0),					-- 일 로그인(유니크)
	invitekakao		int				default(0),

	roulettefreecnt	int				default(0),					-- 일 일일룰렛
	roulettepaycnt	int				default(0),					-- 일 결정룰렛
	roulettegoldcnt	int				default(0),					-- 일 황금무료

	certnocnt		int				default(0),

	-- Constraint
	CONSTRAINT	pk_tFVDayLogInfoStatic_idx	PRIMARY KEY(idx)
)
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
	gameyear		int				default(2013),			-- 게임시작 2013년 3월부터 시작(봄)
	gamemonth		int				default(3),				--
	famelv			int				default(1),

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
--	Android Push Service
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserPushAndroid', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserPushAndroid;
GO

create table dbo.tFVUserPushAndroid(
	idx				int				identity(1, 1),

	sendid			varchar(60),
	receid			varchar(60),
	recepushid		varchar(256),
	sendkind		int,

	msgpush_id		int				default(99),
	msgtitle		varchar(512),
	msgmsg			varchar(512),
	msgaction		varchar(512)	default('LAUNCH'),

	actionTime		datetime		default(getdate()),
	scheduleTime	datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tFVUserPushAndroid_idx	PRIMARY KEY(idx)
)
-- select top 1 * from dbo.tFVUserPushAndroid

-- 내폰
--insert into dbo.tFVUserPushAndroid(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73801', 'guest73801', 'APA91bF6Y96_WIvc3jQH83B2QoTUkcDcX2KAp6A5AGQfMQ_V4LZOjzKe7Wr-IVgXz-a2XS1A8hUIUZ6-0NmWkfkkQLqUMSYikMGA_P1Ejj42Z4e_VxRth84WJkMuhGjbvWUuwAVUdn90R5wlYe6P2W4hLMsyU8FeWjEXcHzFbRe2Fj8lH4CoOL0', 1, 99, '홈런리그제목', '홈런리그 내용푸쉬로 날려요.', 'LAUNCH')
--insert into dbo.tFVUserPushAndroid(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73801', 'guest73801', 'APA91bF6Y96_WIvc3jQH83B2QoTUkcDcX2KAp6A5AGQfMQ_V4LZOjzKe7Wr-IVgXz-a2XS1A8hUIUZ6-0NmWkfkkQLqUMSYikMGA_P1Ejj42Z4e_VxRth84WJkMuhGjbvWUuwAVUdn90R5wlYe6P2W4hLMsyU8FeWjEXcHzFbRe2Fj8lH4CoOL0', 1, 99, '홈런리그제목url', '홈런리그 내용푸쉬로 날려요.url', 'http://m.naver.com')
-- 진혁폰
--insert into dbo.tFVUserPushAndroid(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73799', 'guest73799', 'APA91bE5TtZI1T81gIpHN1o1IZuasNwm0PoaiG2xYDzOJ6AkW2H148vKqUdy7Oh1in0F-OZUo1VxUbwnNt-Jg1blX7c6sJ7wf92vzIsDy9sRBCtJK4GhauekcatxyM7rS_pvEla4A5Tj3GWQEH3JFOZFZSIrK4UDa7FZxUwLiWZpNrceCqaRct4', 1, 99, '홈런리그제목', '홈런리그 내용푸쉬로 날려요.', 'LAUNCH')
--insert into dbo.tFVUserPushAndroid(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73799', 'guest73799', 'APA91bE5TtZI1T81gIpHN1o1IZuasNwm0PoaiG2xYDzOJ6AkW2H148vKqUdy7Oh1in0F-OZUo1VxUbwnNt-Jg1blX7c6sJ7wf92vzIsDy9sRBCtJK4GhauekcatxyM7rS_pvEla4A5Tj3GWQEH3JFOZFZSIrK4UDa7FZxUwLiWZpNrceCqaRct4', 1, 99, '홈런리그제목url', '홈런리그 내용푸쉬로 날려요.url', 'http://m.naver.com')
--


---------------------------------------------
--	iPhone Push Service
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserPushiPhone', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserPushiPhone;
GO

create table dbo.tFVUserPushiPhone(
	idx				int				identity(1, 1),

	sendid			varchar(20),
	receid			varchar(20),
	recepushid		varchar(256),
	sendkind		int,

	msgpush_id		int				default(99),
	msgtitle		varchar(512),
	msgmsg			varchar(512),
	msgaction		varchar(512)	default('LAUNCH'),

	actionTime		datetime		default(getdate()),
	scheduleTime	datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tFVUserPushiPhone_idx	PRIMARY KEY(idx)
)
--select top 1 * from dbo.tFVUserPushAndroidLog
---- Push입력하기
--insert into dbo.tFVUserPushiPhone(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73801', 'guest73801', 'APA91bF6Y96_WIvc3jQH83B2QoTUkcDcX2KAp6A5AGQfMQ_V4LZOjzKe7Wr-IVgXz-a2XS1A8hUIUZ6-0NmWkfkkQLqUMSYikMGA_P1Ejj42Z4e_VxRth84WJkMuhGjbvWUuwAVUdn90R5wlYe6P2W4hLMsyU8FeWjEXcHzFbRe2Fj8lH4CoOL0', 1, 99, '홈런리그제목', '홈런리그 내용푸쉬로 날려요.', 'LAUNCH')
--insert into dbo.tFVUserPushiPhone(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73801', 'guest73801', 'APA91bF6Y96_WIvc3jQH83B2QoTUkcDcX2KAp6A5AGQfMQ_V4LZOjzKe7Wr-IVgXz-a2XS1A8hUIUZ6-0NmWkfkkQLqUMSYikMGA_P1Ejj42Z4e_VxRth84WJkMuhGjbvWUuwAVUdn90R5wlYe6P2W4hLMsyU8FeWjEXcHzFbRe2Fj8lH4CoOL0', 1, 99, '홈런리그제목url', '홈런리그 내용푸쉬로 날려요.url', 'http://m.naver.com')
--insert into dbo.tFVUserPushiPhone(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73799', 'guest73799', 'APA91bE5TtZI1T81gIpHN1o1IZuasNwm0PoaiG2xYDzOJ6AkW2H148vKqUdy7Oh1in0F-OZUo1VxUbwnNt-Jg1blX7c6sJ7wf92vzIsDy9sRBCtJK4GhauekcatxyM7rS_pvEla4A5Tj3GWQEH3JFOZFZSIrK4UDa7FZxUwLiWZpNrceCqaRct4', 1, 99, '홈런리그제목', '홈런리그 내용푸쉬로 날려요.', 'LAUNCH')
--insert into dbo.tFVUserPushiPhone(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73799', 'guest73799', 'APA91bE5TtZI1T81gIpHN1o1IZuasNwm0PoaiG2xYDzOJ6AkW2H148vKqUdy7Oh1in0F-OZUo1VxUbwnNt-Jg1blX7c6sJ7wf92vzIsDy9sRBCtJK4GhauekcatxyM7rS_pvEla4A5Tj3GWQEH3JFOZFZSIrK4UDa7FZxUwLiWZpNrceCqaRct4', 1, 99, '홈런리그제목url', '홈런리그 내용푸쉬로 날려요.url', 'http://m.naver.com')



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

-- insert into dbo.tFVEvnetUserGetLog(gameid, eventidx, eventitemcode) values( 'xxxx2', 1, 1104)
-- select * from dbo.tFVEvnetUserGetLog where gameid = 'xxxx2' and eventidx = 1






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
--		랭킹보인가? 안보인가?
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserRankView', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserRankView;
GO

create table dbo.tFVUserRankView(
	idx				int 					IDENTITY(1, 1),			-- indexing
	userrankview	int						default(-1),
)
GO

insert into dbo.tFVUserRankView(userrankview) values(-1)
update dbo.tFVUserRankView set userrankview = case when userrankview = -1 then 1 else -1 end where idx = 1





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
	CONSTRAINT pk_tFVUserRankSub_idx	PRIMARY KEY(idx)		-- 동점때문에 dateid, rank를 못잡는다.
)
GO


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
	roultimetime4		int					default(-1),

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



---------------------------------------------
--		유저정보(백업)
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserDataBackup', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserDataBackup;
GO

create table dbo.tFVUserDataBackup(
	idx			int 					IDENTITY(1, 1),			-- indexing

	--(유저정보)
	gameid		varchar(60),
	market		int						default(5),				-- (구매처코드)
	idx2		int,
	savedata	varchar(4096)			default('-1'),
	writedate	datetime				default(getdate()),

	-- Constraint
	CONSTRAINT pk_tFVUserDataBackup_gameid_market_idx2	PRIMARY KEY(gameid, market, idx2)
)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserDataBackup_idx')
   DROP INDEX tFVUserDataBackup.idx_tFVUserDataBackup_idx
GO
CREATE INDEX idx_tFVUserDataBackup_idx ON tFVUserDataBackup (idx)
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