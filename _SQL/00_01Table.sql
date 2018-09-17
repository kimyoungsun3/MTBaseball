use GameMTBaseball
GO

---------------------------------------------
--		유저정보
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tUserMaster;
GO

create table dbo.tUserMaster(
	--(일반정보)
	idx			int 					IDENTITY(1, 1),
	gameid		varchar(20),
	password	varchar(20),									-- 암호화해서저장, 유저패스워가 해킹당해도 안전
	sid			int						default(100),			-- 접속 세션번호.

	username	varchar(60),									-- 홍길동
	birthday	varchar(8),										-- 19900801
																-- 20000801
	email		varchar(60),									-- ai@aidata.com
	nickname	varchar(60),									-- 길동닉네임...
	phone		varchar(60),									-- 01012345678 -> >5SEF5ES6Q7E
	connectip	varchar(20)				default(''),			-- 접속시 사용되는 ip
	version		int						default(100),			-- 가입버젼.


	--(생성정보)
	regdate		datetime				default(getdate()),		-- 최초가입일
	condate		datetime				default(getdate()),		-- (로그인시마다 매번업데이트)
	concnt		int						default(1),				-- 접속횟수
	logindate	varchar(8)				default('20100101'),	-- 로그인일자.

	-- (블럭정보)
	blockstate	int						default(0),				-- 블럭아님(0), 블럭상태(1)
	deletestate	int						default(0),				-- 0 : 삭제상태아님, 1 : 삭제상태
	cashcopy	int						default(0),				-- 캐쉬불법카피시 +1추가된다.
	resultcopy	int						default(0),				-- 로그결과카피시 +1추가된다.

	-- (사이버머니)
	cashcost	int						default(0),				-- 다이아.
	cashpoint	int						default(0),				-- 캐쉬 구매하면 누적.
	cashreceivetotal	int				default(0),				-- 선물, 관리자 받은 누적금액.
	cashbuytotal		int				default(0),				-- 구매한 누적금액.
	pieceboxopencnt		int				default(0),				-- 조각오픈수량.
	wearboxopencnt		int				default(0),				-- 의상오픈수량.
	adviceboxopencnt	int				default(0),				-- 조언오픈수량.
	combinatecnt		int				default(0),				-- 조각의상 조합수량.
	evolutioncnt		int				default(0),				-- 완성의상초월수량.

	-- (게임변수 : 팔라미터)
	param0			int					default(0),				--클라이언트정보.
	param1			int					default(0),
	param2			int					default(0),
	param3			int					default(0),
	param4			int					default(0),
	param5			int					default(0),
	param6			int					default(0),
	param7			int					default(0),
	param8			int					default(0),
	param9			int					default(0),

	-- (게임변수 : 일반정보2)
	level			int					default(1),
	exp				int					default(0),				--
	commission		float				default(7.00), 			-- 수수료... (기본 7%를 지급) -> 보는 용도일뿐이다.
	tutorial		int					default(0),				-- 안봄(0), 봄(1)
	randserial		varchar(20)			default('-1'),			-- 아이템구매, 박스까기, 조각조합, 의상초월등의 유일한 구매의 랜덤씨리얼

	-- (게임변수 : 싱글게임변수)
	sflag			int					default(0),				-- 싱글미진행(0), 진행중(1).
	strycnt			int					default(0),				-- 싱글횟수.
	ssuccesscnt		int					default(0),				--   성공횟수.
	sfailcnt		int					default(0),				--   실패횟수.
	serrorcnt		int					default(0),				--   오류횟수.

	-- (게임변수 : 착용아이템 인덱스리스트)
	helmetlistidx		int 			default(-1),
	shirtlistidx		int 			default(-1),
	pantslistidx		int 			default(-1),
	gloveslistidx		int 			default(-1),
	shoeslistidx		int 			default(-1),
	batlistidx			int 			default(-1),
	balllistidx			int 			default(-1),
	gogglelistidx		int 			default(-1),
	wristbandlistidx	int 			default(-1),
	elbowpadlistidx		int 			default(-1),
	beltlistidx			int 			default(-1),
	kneepadlistidx		int 			default(-1),
	sockslistidx		int 			default(-1),

	-- 이벤트.
	eventspot01		int					default(0),				-- 로그인사용(1~5).
	eventspot02		int					default(0),
	eventspot03		int					default(0),
	eventspot04		int					default(0),
	eventspot05		int					default(0),
	eventspot06		int					default(0),				-- 쿠폰에서 사용.
	eventspot07		int					default(0),				-- 5만원 이상 구매시 일꾼 인형(100005)
	eventspot08		int					default(0),				-- skt 생애첫결제 클리어부분.
	eventspot09		int					default(0),				-- 미사용
	eventspot10		int					default(0),				-- 미사용

	-- Constraint
	CONSTRAINT pk_tUserMaster_idx		PRIMARY KEY(idx)
)
GO
-- alter table dbo.tUserMaster add randserial			varchar(20)		default('-1')
-- 데이타 10만건 강제로 넣어서 쿼리해보기(상상ID로 만든 유저를 입력한다.)
-- 가입시 gameid 쿼리 > PRIMARY KEY(gameid) > 인덱싱

-- 인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserMaster_gameid')
   DROP INDEX tUserMaster.idx_tUserMaster_gameid
GO
CREATE INDEX idx_tUserMaster_gameid ON tUserMaster (gameid)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserMaster_email')
    DROP INDEX tUserMaster.idx_tUserMaster_email
GO
CREATE INDEX idx_tUserMaster_email ON tUserMaster (email)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserMaster_nickname')
   DROP INDEX tUserMaster.idx_tUserMaster_nickname
GO
CREATE INDEX idx_tUserMaster_nickname ON tUserMaster (nickname)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserMaster_phone')
    DROP INDEX tUserMaster.idx_tUserMaster_phone
GO
CREATE INDEX idx_tUserMaster_phone ON tUserMaster (phone)
GO

-- select * from dbo.tUserMaster where gameid = 'xxxx'

---------------------------------------------
--		아이템 보유정보
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserItem', N'U') IS NOT NULL
	DROP TABLE dbo.tUserItem;
GO

create table dbo.tUserItem(
	idx				int					IDENTITY(1,1),

	gameid			varchar(20),									--
	listidx			int,											-- 리스트인덱스(각개인별로 별개)

	invenkind		int					default(1),					--대분류(장착인벤(1), 조각인벤(2), 소비인벤(3))
	itemcode		int,
	cnt				int					default(1),					--보유량

	randserial		varchar(20)			default('-1'),				--랜던씨리얼(클라이언트에서 만들어서옴)
	writedate		datetime			default(getdate()),			--구매일/획득일
	gethow			int					default(0),					--획득방식

	-- Constraint
	CONSTRAINT	pk_tUserItem_gameid_listidx	PRIMARY KEY(gameid, listidx)
)

--alter table dbo.tUserItem add diedate			datetime
--alter table dbo.tUserItem add diemode			int					default(-1)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserItem_idx')
    DROP INDEX tUserItem.idx_tUserItem_idx
GO
CREATE INDEX idx_tUserItem_idx ON tUserItem (idx)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserItem_gameid_itemcode')
    DROP INDEX tUserItem.idx_tUserItem_gameid_itemcode
GO
CREATE INDEX idx_tUserItem_gameid_itemcode ON tUserItem (gameid, itemcode)
GO

-- select isnull(max(listidx), 0) from dbo.tUserItem where gameid = 'xxxx'	--트리거 사용하면 원하지 않는 결과가 나오는군(insert:inserted, update:deleted/inserted, delete:deleted)
-- insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum, fieldidx, category, randserial) values('xxxx', 0, 1, 1, 0, 0, 1, 1001)
-- select top 1 * from dbo.tUserItem where gameid = 'xxxx' and randserial = 1010
-- update dbo.tUserItem set fieldidx = 0 where gameid = 'xxxx' and listidx = 1
-- select * from dbo.tUserItem where gameid = 'xxxx' and category in (1, 3, 4)

---------------------------------------------
--  관리자 정보
---------------------------------------------
IF OBJECT_ID (N'dbo.tAdminUser', N'U') IS NOT NULL
	DROP TABLE dbo.tAdminUser;
GO

create table dbo.tAdminUser(
	idx				int 				IDENTITY(1, 1),
	gameid			varchar(20),
	password		varchar(20),
	writedate		datetime			default(getdate()),
	grade			int					default(0),

	-- Constraint
	CONSTRAINT	pk_tAdminUser_idx	PRIMARY KEY(gameid)
)

--select * from dbo.tAdminUser
--insert into tAdminUser(gameid, password) values('blackm', 'a1s2d3f4')


-- 잘못해서 테이블을 전체 건드릴수 있어서 주석처리로 막아둔다.(전에 실수한적이 있어서)
-- 입력 < 검색(우선순위)
-- 데이타베이스 대소문자 구분안함(새로 세팅된 서버 확인필요)

---------------------------------------------
--		아이템 보유정보 > 동물 정보만 삭제백업
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserItemDel', N'U') IS NOT NULL
	DROP TABLE dbo.tUserItemDel;
GO

create table dbo.tUserItemDel(
	idx				int					IDENTITY(1,1),

	gameid			varchar(20),									--
	listidx			int,											-- 리스트인덱스(각개인별로 별개)

	invenkind		int					default(1),
	itemcode		int,
	cnt				int					default(1),					--보유량

	randserial		varchar(20)			default(-1),				--랜던씨리얼(클라이언트에서 만들어서옴)
	writedate		datetime			default(getdate()),			--구매일/획득일
	gethow			int					default(0),					--획득방식(0:구매, 1:경작, 2:교배/뽑기, 3:검색)

	idx2			int,											-- 전의 idx번호가 들어간다(추적용으로)
	writedate2		datetime			default(getdate()),			-- 삭제일.
	state			int					default(0),					-- 0:병원에서, 1:판매, 2:우편함

	-- Constraint
	CONSTRAINT	pk_tUserItemDel_idx	PRIMARY KEY(idx)
)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserItemDel_gameid_idx2')
    DROP INDEX tUserItemDel.idx_tUserItemDel_gameid_idx2
GO
CREATE INDEX idx_tUserItemDel_gameid_idx2 ON tUserItemDel (gameid, idx2)
GO

---------------------------------------------
--		구매했던 로그(개인)
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserItemBuyLog', N'U') IS NOT NULL
	DROP TABLE dbo.tUserItemBuyLog;
GO

create table dbo.tUserItemBuyLog(
	idx			int					IDENTITY(1,1), 					-- 번호

	gameid		varchar(20), 										-- 유저id
	idx2		int,
	itemcode	int, 												-- 아이템코드, 중복 구매기록한다.
	buydate2	varchar(8),											-- 구매일20131010
	cnt			int					default(1), 					--

	cashcost	int					default(0), 					-- 구매가격(세일할수있어서)
	gamecost	int					default(0),
	buydate		datetime			default(getdate()), 			-- 구매일

	-- Constraint
	CONSTRAINT	pk_tUserItemBuyLog_idx	PRIMARY KEY(idx)
)
-- select top 1 * from dbo.tUserItemBuyLog
--select top 20 * from dbo.tUserItemBuyLog a join dbo.tItemInfo b on a.itemcode = b.itemcode where gameid = 'xxxx' order by a.idx desc
--select top 20 a.idx 'idx', gameid, a.itemcode 'itemcode', a.cashcost 'cashcost', a.gamecost 'gamecost', a.buydate, b.itemname, b.gamecost 'coinball2', b.cashcost 'milkball2', b.period, b.explain from dbo.tUserItemBuyLog a join dbo.tItemInfo b on a.itemcode = b.itemcode where gameid = 'Marbles' order by a.idx desc
--select top 20 * from dbo.tUserItemBuyLog where buydate between '2012-08-09 00:00:01' and '2012-08-10 00:00:01' order by idx desc
--insert into dbo.tUserItemBuyLog(gameid, itemcode, cashcost) values('xxxx', 1, 5)
--insert into dbo.tUserItemBuyLog(gameid, itemcode, cashcost) values('xxxx', 1, 0)

--유저 검색용 인덱스
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserItemBuyLog_gameid_idx')
    DROP INDEX tUserItemBuyLog.idx_tUserItemBuyLog_gameid_idx
GO
CREATE INDEX idx_tUserItemBuyLog_gameid_idx ON tUserItemBuyLog (gameid, idx)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserItemBuyLog_gameid_idx2')
    DROP INDEX tUserItemBuyLog.idx_tUserItemBuyLog_gameid_idx2
GO
CREATE INDEX idx_tUserItemBuyLog_gameid_idx2 ON tUserItemBuyLog (gameid, idx2)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserItemBuyLog_gameid_buydate2_itemcode')
    DROP INDEX tUserItemBuyLog.idx_tUserItemBuyLog_gameid_buydate2_itemcode
GO
CREATE INDEX idx_tUserItemBuyLog_gameid_buydate2_itemcode ON tUserItemBuyLog (gameid, buydate2, itemcode)
GO


---------------------------------------------
-- 	구매했던 로그(월별 Master)
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserItemBuyLogTotalMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tUserItemBuyLogTotalMaster;
GO

create table dbo.tUserItemBuyLogTotalMaster(
	idx				int				identity(1, 1),
	dateid8			char(8),							-- 20101210

	cashcost		bigint			default(0),
	gamecost	int					default(0),
	cnt				int				default(0),

	-- Constraint
	CONSTRAINT	pk_tUserItemBuyLogTotalMaster_dateid	PRIMARY KEY(dateid8)
)
-- select         * from dbo.tUserItemBuyLogTotalMaster
-- select top 1   * from dbo.tUserItemBuyLogTotalMaster where dateid8 = '20120818'
-- insert into dbo.tUserItemBuyLogTotalMaster(dateid8, gamecost, cashcost, cnt) values('20120818', 100, 0, 1)
--update dbo.tUserItemBuyLogTotalMaster
--	set
--		gamecost = gamecost + 1,
--		cnt = cnt + 1
--where dateid8 = '20120818'


---------------------------------------------
-- 	구매했던 로그(월별 Sub)
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserItemBuyLogTotalSub', N'U') IS NOT NULL
	DROP TABLE dbo.tUserItemBuyLogTotalSub;
GO

create table dbo.tUserItemBuyLogTotalSub(
	idx				int				identity(1, 1),

	dateid8			char(8),							-- 20101210
	itemcode		int,

	cashcost		int				default(0),
	gamecost	int					default(0),
	cnt				int				default(0),

	-- Constraint
	CONSTRAINT	pk_tUserItemBuyLogTotalSub_dateid8_itemcode	PRIMARY KEY(dateid8, itemcode)
)
-- select top 100 * from dbo.tUserItemBuyLogTotalSub order by dateid8 desc, itemcode desc
-- select         * from dbo.tUserItemBuyLogTotalSub where dateid8 = '20120818'
-- select top 1   * from dbo.tUserItemBuyLogTotalSub where dateid8 = '20120818' and itemcode = 1
--update dbo.tUserItemBuyLogTotalSub
--	set
--		gamecost = gamecost + 1,
--		cnt = cnt + 1
--where dateid8 = '20120818' and itemcode = 1
-- insert into dbo.tUserItemBuyLogTotalSub(dateid8, itemcode, cashcost, cnt) values('20120818', 1, 100, 1)


---------------------------------------------
-- 	구매했던 로그(월별 누적)
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserItemBuyLogMonth', N'U') IS NOT NULL
	DROP TABLE dbo.tUserItemBuyLogMonth;
GO

create table dbo.tUserItemBuyLogMonth(
	idx				int				identity(1, 1),

	dateid6			char(6),							-- 201012
	itemcode		int,

	cashcost		bigint			default(0),
	gamecost	int					default(0),
	cnt				int				default(0),

	-- Constraint
	CONSTRAINT	pk_tUserItemBuyLogMonth_dateid6_itemcode	PRIMARY KEY(dateid6, itemcode)
)
-- select top 100 * from dbo.tUserItemBuyLogMonth order by dateid6 desc, itemcode desc
-- select         * from dbo.tUserItemBuyLogMonth where dateid6 = '201309'
-- select top 1   * from dbo.tUserItemBuyLogMonth where dateid6 = '201309' and itemcode = 1
-- insert into dbo.tUserItemBuyLogMonth(dateid6, itemcode, gamecost, cnt) values('201309', 1, 100, 1)
--update dbo.tUserItemBuyLogMonth
--	set
--		gamecost = gamecost + 1,
--		cnt = cnt + 1
--where dateid6 = '201309' and itemcode = 1

---------------------------------------------
--		유저 블럭킹
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserBlockLog', N'U') IS NOT NULL
	DROP TABLE dbo.tUserBlockLog;
GO

create table dbo.tUserBlockLog(
	idx				int				IDENTITY(1,1),
	gameid			varchar(20), 							-- 아이디
	comment			varchar(512), 							-- 시스템코멘트
	writedate		datetime		default(getdate()), 	-- 블록일
	blockstate		int				default(1), 			-- 블럭상태 	0 : 블럭상태아님	1 : 블럭상태

	adminid			varchar(20),
	adminip			varchar(40),
	comment2		varchar(512),							-- 코멘트
	releasedate		datetime								-- 해제일

	-- Constraint
	CONSTRAINT pk_tUserBlockLog_idx PRIMARY KEY(idx)
)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserBlockLog_gameid_idx')
    DROP INDEX tUserBlockLog.idx_tUserBlockLog_gameid_idx
GO
CREATE INDEX idx_tUserBlockLog_gameid_idx ON tUserBlockLog(gameid, idx)
GO
-- 블럭 당하는 유저가 중복이 발생할 수 있다. 한번 블럭당하고 또 블럭당한다. 즉 중복 블럭을 당한다.
-- insert into dbo.tUserBlockLog(gameid, comment) values(@gameid_, '아이템를 '+ltrim(rtrim(str(@cashcopy)))+'회 이상 카피를 해서 로그인시 시스템에서 블럭 처리했습니다.')
-- update dbo.tUserMaster set blockstate = '0' where gameid = 'DD0'
-- update dbo.tUserBlockLog set blockstate = 0, adminid = 'Marbles', adminip = '172.0.0.1', comment2 = '풀어주었다.', releasedate = getdate() where idx = 17
-- select * from dbo.tUserBlockLog order by idx desc
-- select idx, gameid, comment, writedate, blockstate, adminid, comment2, releasedate from dbo.tUserBlockLog order by idx desc
-- select top 20 * from dbo.tUserBlockLog where gameid = 'DD0' order by idx desc




---------------------------------------------
--		PC방정보...
---------------------------------------------
IF OBJECT_ID (N'dbo.tPCRoomIP', N'U') IS NOT NULL
	DROP TABLE dbo.tPCRoomIP;
GO

create table dbo.tPCRoomIP(
	idx				int					IDENTITY(1,1),

	gameid			varchar(20),
	pcip			varchar(20),

	writedate		datetime			default(getdate()),			-- 등록일..
	adminid			varchar(20),

	-- Constraint
	CONSTRAINT	pk_tPCRoomIP_gameid_pcip	PRIMARY KEY(gameid, pcip),
	CONSTRAINT	uk_tPCRoomIP_pcip			UNIQUE( pcip )
)

-- insert into dbo.tPCRoomIP(gameid, pcip) values('xxxx', '127.0.0.1')
-- insert into dbo.tPCRoomIP(gameid, pcip) values('xxxx', '127.0.0.2')
-- insert into dbo.tPCRoomIP(gameid, pcip) values('xxxx', '127.0.0.3')
-- insert into dbo.tPCRoomIP(gameid, pcip) values('xxxx2', '127.0.0.3')		--error 가 정상이다.
-- select top 1 * from dbo.tPCRoomIP where pcip = '127.0.0.1'
-- select * from dbo.tPCRoomIP where gameid = 'xxxx'
-- update dbo.tPCRoomIP set pcip = '127.0.0.1' where gameid = 'xxxx' and pcip = '127.0.0.1'



---------------------------------------------
--	유니크 가입현황파악하기
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserPhone', N'U') IS NOT NULL
	DROP TABLE dbo.tUserPhone;
GO

create table dbo.tUserPhone(
	idx					int 				IDENTITY(1, 1),

	phone				varchar(20),
	joincnt				int					default(1),
	writedate			datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tUserPhone_idx	PRIMARY KEY(idx)
)
-- 폰인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserPhone_phone')
    DROP INDEX tUserPhone.idx_tUserPhone_phone
GO
CREATE INDEX idx_tUserPhone_phone ON tUserPhone (phone)
GO
-- select top 1 * from dbo.tUserPhone


---------------------------------------------
-- 	블럭폰번호 > 가입시 블럭처리자
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserBlockPhone', N'U') IS NOT NULL
	DROP TABLE dbo.tUserBlockPhone;
GO

create table dbo.tUserBlockPhone(
	idx			int 					IDENTITY(1, 1),

	phone			varchar(20),
	comment			varchar(1024),
	writedate		datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tUserBlockPhone_phone	PRIMARY KEY(phone)
)

-- insert into dbo.tUserBlockPhone(phone, comment) values('01022223333', '아이템카피')
-- insert into dbo.tUserBlockPhone(phone, comment) values('01092443174', '환전버그카피')
-- select top 100 * from dbo.tUserBlockPhone order by writedate desc
-- select top 1   * from dbo.tUserBlockPhone where phone = '01022223333'

-- 센드키 충돌검사
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserBlockPhone_idx')
    DROP INDEX tUserBlockPhone.idx_tUserBlockPhone_idx
GO
CREATE INDEX idx_tUserBlockPhone_idx ON tUserBlockPhone (idx)
GO


---------------------------------------------------
--	(회사공지)
---------------------------------------------------
IF OBJECT_ID (N'dbo.tNotice', N'U') IS NOT NULL
	DROP TABLE dbo.tNotice;
GO

create table dbo.tNotice(
	idx				int				IDENTITY(1,1), 			-- 번호

	comfile1		varchar(512)	default(''),			-- 싱글옆에 이미지.
	comurl1			varchar(512)	default(''),			-- 공지URL
	comfile2		varchar(512)	default(''),
	comurl2			varchar(512)	default(''),
	comfile3		varchar(512)	default(''),
	comurl3			varchar(512)	default(''),
	comfile4		varchar(512)	default(''),
	comurl4			varchar(512)	default(''),
	comfile5		varchar(512)	default(''),
	comurl5			varchar(512)	default(''),
	comment			varchar(8000)	default(''),

	version			int				default(101),			--클라이언트버전
	patchurl		varchar(512)	default(''),			--패치URL
	writedate		datetime		default(getdate()), 	-- 작성일
	syscheck		int				default(0),				-- 0:서비스중 	1:점검중

	-- Constraint
	CONSTRAINT	pk_tNotice_idx	PRIMARY KEY(idx)
)



---------------------------------------------
-- 	매일통계관리
---------------------------------------------
IF OBJECT_ID (N'dbo.tDayLogInfoStatic', N'U') IS NOT NULL
	DROP TABLE dbo.tDayLogInfoStatic;
GO

create table dbo.tDayLogInfoStatic(
	idx				int				IDENTITY(1,1),

	dateid8			varchar(8),

	joinukcnt		int				default(0),					-- 일 유니크 가입
	logincnt		int				default(0),					-- 일 로그인
	logincnt2		int				default(0),					-- 일 로그인(유니크)

	pieceboxcnt		int				default(0),					-- 일 조각박스 열기
	clothesboxcnt	int				default(0),					-- 일 의상박스 열기
	cashcnt			int				default(0),					-- 일 캐쉬구매(일반
	practicecnt		int				default(0),					--   연습모드횟수
	singlecnt		int				default(0),					--   싱글모드횟수
	multicnt		int				default(0),					--

	certnocnt		int				default(0),					--   쿠폰사용횟수

	-- Constraint
	CONSTRAINT	pk_tDayLogInfoStatic_idx	PRIMARY KEY(idx)
)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tDayLogInfoStatic_dateid8')
    DROP INDEX tDayLogInfoStatic.idx_tDayLogInfoStatic_dateid8
GO
CREATE INDEX idx_tDayLogInfoStatic_dateid8 ON tDayLogInfoStatic(dateid8)
GO

-- insert into dbo.tDayLogInfoStatic(dateid8) values('20130827')
-- select top 100 * from dbo.tDayLogInfoStatic order by idx desc

---------------------------------------------
-- 	매일통계관리
---------------------------------------------
IF OBJECT_ID (N'dbo.tDayLogInfoSubStatic', N'U') IS NOT NULL
	DROP TABLE dbo.tDayLogInfoSubStatic;
GO

create table dbo.tDayLogInfoSubStatic(
	idx				int				IDENTITY(1,1),

	dateid10		varchar(10),

	joinukcnt		int				default(0),					-- 일 유니크 가입
	logincnt		int				default(0),					-- 일 로그인

	pieceboxcnt		int				default(0),					-- 일 조각박스 열기
	clothesboxcnt	int				default(0),					-- 일 의상박스 열기
	cashcnt			int				default(0),					-- 일 캐쉬구매(일반
	practicecnt		int				default(0),					--
	singlecnt		int				default(0),					--
	multicnt		int				default(0),					--

	-- Constraint
	CONSTRAINT	pk_tDayLogInfoSubStatic_idx	PRIMARY KEY(idx)
)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tDayLogInfoSubStatic_dateid10')
    DROP INDEX tDayLogInfoSubStatic.idx_tDayLogInfoSubStatic_dateid10
GO
CREATE INDEX idx_tDayLogInfoSubStatic_dateid10 ON tDayLogInfoSubStatic(dateid10)
GO

-- insert into dbo.tDayLogInfoSubStatic(dateid10) values('20130827')
-- select top 100 * from dbo.tDayLogInfoSubStatic order by idx desc

---------------------------------------------
-- 	관리자 정보(행동정보)
---------------------------------------------
IF OBJECT_ID (N'dbo.tMessageAdmin', N'U') IS NOT NULL
	DROP TABLE dbo.tMessageAdmin;
GO

create table dbo.tMessageAdmin(
	idx			int					IDENTITY(1,1),
	adminid		varchar(20),
	gameid		varchar(20),
	comment		varchar(1024),

	writedate	datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tMessageAdmin_idx	PRIMARY KEY(idx)
)

-- insert into dbo.tMessageAdmin(adminid, gameid, comment) values('black4', 'guest', '골드지급')
-- select top 100 * from dbo.tMessageAdmin order by idx desc


---------------------------------------------
--	비정삭적인 행동을 할려고 하는 유저체킹 > 블럭처리
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserUnusualLog', N'U') IS NOT NULL
	DROP TABLE dbo.tUserUnusualLog;
GO

create table dbo.tUserUnusualLog(
	idx				int				IDENTITY(1,1),
	gameid			varchar(20), 							-- 행동자
	comment			varchar(512), 							-- 비정상내용
	writedate		datetime		default(getdate()), 	-- 비정상작성일

	chkstate		int				default(0),				-- 확인상태(0:체킹안함, 1:체킹함)
	chkdate			datetime,
	chkcomment		varchar(512), 							-- 확인내용

	-- Constraint
	CONSTRAINT pk_tUserUnusualLog_idx PRIMARY KEY(idx)
)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserUnusualLog_gameid_idx')
    DROP INDEX tUserUnusualLog.idx_tUserUnusualLog_gameid_idx
GO
CREATE INDEX idx_tUserUnusualLog_gameid_idx ON tUserUnusualLog(gameid, idx)
GO
-- insert into dbo.tUserUnusualLog(gameid, comment) values('x1', '캐쉬카피시도')
-- insert into dbo.tUserUnusualLog(gameid, comment) values('x1', '환전카피시도')
-- insert into dbo.tUserUnusualLog(gameid, comment) values('x2', '결과조작')
-- select top 20 * from dbo.tUserUnusualLog order by idx desc
-- select top 20 * from dbo.tUserUnusualLog where gameid = 'sususu' order by idx desc


---------------------------------------------
--	비정삭적인2 행동을 할려고 하는 유저체킹 > 블럭처리
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserUnusualLog2', N'U') IS NOT NULL
	DROP TABLE dbo.tUserUnusualLog2;
GO

create table dbo.tUserUnusualLog2(
	idx				int				IDENTITY(1,1),
	gameid			varchar(20), 							-- 행동자
	comment			varchar(512), 							-- 비정상내용
	writedate		datetime		default(getdate()), 	-- 비정상작성일

	chkstate		int				default(0),				-- 확인상태(0:체킹안함, 1:체킹함)
	chkdate			datetime,
	chkcomment		varchar(512), 							-- 확인내용

	-- Constraint
	CONSTRAINT pk_tUserUnusualLog2_idx PRIMARY KEY(idx)
)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserUnusualLog2_gameid_idx')
    DROP INDEX tUserUnusualLog2.idx_tUserUnusualLog2_gameid_idx
GO
CREATE INDEX idx_tUserUnusualLog2_gameid_idx ON tUserUnusualLog2(gameid, idx)
GO
-- insert into dbo.tUserUnusualLog2(gameid, comment) values('x1', '캐쉬카피시도')
-- insert into dbo.tUserUnusualLog2(gameid, comment) values('x1', '환전카피시도')
-- insert into dbo.tUserUnusualLog2(gameid, comment) values('x2', '결과조작')
-- select top 20 * from dbo.tUserUnusualLog2 order by idx desc
-- select top 20 * from dbo.tUserUnusualLog2 where gameid = 'sususu' order by idx desc




---------------------------------------------
-- 이벤트 인증키값
---------------------------------------------
IF OBJECT_ID (N'dbo.tEventCertNo', N'U') IS NOT NULL
	DROP TABLE dbo.tEventCertNo;
GO

create table dbo.tEventCertNo(
	idx			int				identity(1, 1),
	certno		varchar(16),

	itemcode1	int				default(-1),
	itemcode2	int				default(-1),
	itemcode3	int				default(-1),
	cnt1		int				default(0),
	cnt2		int				default(0),
	cnt3		int				default(0),

	mode		int				default(1),		-- 1: 1인1매형, 2:공용형
	kind		int				default(0),		-- 제작요청한 회사번호.

	CONSTRAINT	pk_tEventCertNo_idx	PRIMARY KEY(idx)
)
-- 인증번호 인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tEventCertNo_certno')
    DROP INDEX tEventCertNo.idx_tEventCertNo_certno
GO
CREATE INDEX idx_tEventCertNo_certno ON tEventCertNo (certno)
GO

---------------------------------------------
-- 이벤트 인증키값(백업)
-- 누구에게 무슨아이템을 지급했다.
---------------------------------------------
IF OBJECT_ID (N'dbo.tEventCertNoBack', N'U') IS NOT NULL
	DROP TABLE dbo.tEventCertNoBack;
GO

create table dbo.tEventCertNoBack(
	idx			int				identity(1, 1),
	certno		varchar(16),

	gameid		varchar(20),
	itemcode1	int				default(-1),
	itemcode2	int				default(-1),
	itemcode3	int				default(-1),
	usedtime	datetime		default(getdate()),
	kind		int				default(0),

	CONSTRAINT	pk_tEventCertNoBack_idx	PRIMARY KEY(idx)
)

-- 인증번호 인덱싱
--IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tEventCertNoBack_certno')
--    DROP INDEX tEventCertNoBack.idx_tEventCertNoBack_certno
--GO
--CREATE INDEX idx_tEventCertNoBack_certno ON tEventCertNoBack (certno)
--GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tEventCertNoBack_gameid_certno')
    DROP INDEX tEventCertNoBack.idx_tEventCertNoBack_gameid_certno
GO
CREATE INDEX idx_tEventCertNoBack_gameid_certno ON tEventCertNoBack (gameid, certno)
GO


---------------------------------------------
-- 유저문의
---------------------------------------------
IF OBJECT_ID (N'dbo.tSysInquire', N'U') IS NOT NULL
	DROP TABLE dbo.tSysInquire;
GO

create table dbo.tSysInquire(
	idx					int 				IDENTITY(1, 1),

	gameid				varchar(20),
	state				int					default(0),				-- 요청대기[0], 체킹중[1], 완료[2]
	comment				varchar(1024)		default(''),
	writedate			datetime			default(getdate()),

	adminid				varchar(20)			default(''),
	comment2			varchar(1024)		default(''),
	dealdate			datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tSysInquire_idx	PRIMARY KEY(idx)
)
-- select top 10 * from dbo.tSysInquire order by idx desc
-- insert into dbo.tSysInquire(gameid, comment) values(1, '잘안됩니다.')
-- update dbo.tSysInquire set state = 1, dealdate = getdate(), comment2 = '진행중입니다.' where idx = 1
-- update dbo.tSysInquire set state = 2, dealdate = getdate(), comment2 = '처리했습니다.' where idx = 1
-- if(2)쪽지로 발송된다.




---------------------------------------------
--		아이템 구매 (통합로그)
---------------------------------------------

---------------------------------------------
--		통계자료 (통합로그)
---------------------------------------------


---------------------------------------------
--		아이템 보유정보
---------------------------------------------
IF OBJECT_ID (N'dbo.tGiftList', N'U') IS NOT NULL
	DROP TABLE dbo.tGiftList;
GO

create table dbo.tGiftList(
	idx			bigint				IDENTITY(1,1),
	idx2		int,

	gameid		varchar(20),									-- gameid별 itemcode는 중복이 발생한다.
	giftkind	int					default(0),					-- 1:메시지, 2:선물, -1:메시지삭제, -2:선물받아감

	message		varchar(256)		default(''), 				-- 메세지(1)

	itemcode	int					default(-1),				-- 선물(2)
	cnt			bigint 				default(0),					-- == 0 이면 기존것의 수량
																-- >= 1 이면 이것을 수량으로한다.
	gainstate	int					default(0),					-- 가져간상태	0:안가져감, 1:가져감
	gaindate	datetime, 										-- 가져간날
	giftid		varchar(20)			default('Marbles'),			-- 선물한 유저
	giftdate	datetime			default(getdate()), 		-- 선물일

	-- Constraint
	CONSTRAINT	pk_tGiftList_idx	PRIMARY KEY(idx)
)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tGiftList_gameid_idx')
    DROP INDEX tGiftList.idx_tGiftList_gameid_idx
GO
CREATE INDEX idx_tGiftList_gameid_idx ON tGiftList (gameid, idx)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tGiftList_gameid_idx2')
    DROP INDEX tGiftList.idx_tGiftList_gameid_idx2
GO
CREATE INDEX idx_tGiftList_gameid_idx2 ON tGiftList (gameid, idx2)
GO



-- select * from dbo.tGiftList where gameid = 'xxxx' order by idx desc
-- insert into dbo.tGiftList(gameid, giftkind, message) values('xxxx', 1, 'Shot message');
-- insert into dbo.tGiftList(gameid, giftkind, itemcode, giftid) values('xxxx', 2, 1, 'Marbles');

---------------------------------------------
-- 	구매했던 로그(월별 Master)
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserItemUpgradeLogTotalMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tUserItemUpgradeLogTotalMaster;
GO

create table dbo.tUserItemUpgradeLogTotalMaster(
	idx				int				identity(1, 1),
	dateid8			char(8),							-- 20101210

	cashcost		bigint			default(0),
	gamecost		bigint			default(0),
	heart			bigint			default(0),
	cnt				int				default(0),

	-- Constraint
	CONSTRAINT	pk_tUserItemUpgradeLogTotalMaster_dateid	PRIMARY KEY(dateid8)
)

---------------------------------------------
-- 	구매했던 로그(월별 Sub)
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserItemUpgradeLogTotalSub', N'U') IS NOT NULL
	DROP TABLE dbo.tUserItemUpgradeLogTotalSub;
GO

create table dbo.tUserItemUpgradeLogTotalSub(
	idx				int				identity(1, 1),

	dateid8			char(8),							-- 20101210
	itemcode		int,

	cashcost		int				default(0),
	gamecost		int				default(0),
	heart			bigint			default(0),
	cnt				int				default(0),

	-- Constraint
	CONSTRAINT	pk_tUserItemUpgradeLogTotalSub_dateid8_itemcode	PRIMARY KEY(dateid8, itemcode)
)

---------------------------------------------
-- 	구매했던 로그(월별 누적)
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserItemUpgradeLogMonth', N'U') IS NOT NULL
	DROP TABLE dbo.tUserItemUpgradeLogMonth;
GO

create table dbo.tUserItemUpgradeLogMonth(
	idx				int				identity(1, 1),

	dateid6			char(6),							-- 201012
	itemcode		int,

	cashcost		bigint			default(0),
	gamecost		bigint			default(0),
	heart			bigint			default(0),
	cnt				int				default(0),

	-- Constraint
	CONSTRAINT	pk_tUserItemUpgradeLogMonth_dateid6_itemcode	PRIMARY KEY(dateid6, itemcode)
)


---------------------------------------------
-- 	캐쉬관련(개인로그)
---------------------------------------------
IF OBJECT_ID (N'dbo.tCashLog', N'U') IS NOT NULL
	DROP TABLE dbo.tCashLog;
GO

create table dbo.tCashLog(
	idx				int				identity(1, 1),
	gameid			varchar(20)		not null, 				-- 구매자
	level			int				default(1),

	giftid			varchar(20), 							-- 선물받은사람
	acode			varchar(256), 							-- 승인코드() 사용안함.ㅠㅠ
	ucode			varchar(256), 							-- 승인코드

	ikind			varchar(256),							-- 아이폰, Google 종류(SandBox, Real, GoogleID)
	idata			varchar(4096),							-- 아이폰에서 사용되는 데이타(원본)
	idata2			varchar(4096),							-- 아이폰에서 사용되는 데이타(해석본)

	cashcost		int				default(0), 			-- 충전골든볼
	cash			int				default(0),				-- 구매현금
	writedate		datetime		default(getdate()), 	-- 구매일

	productid		varchar(40)		default(''),

	-- Constraint
	CONSTRAINT	pk_tCashLog_idx	PRIMARY KEY(idx)
)
--직접 clustered를 안한 이유는 쓰기는 idx로 하고 검색을 ucode > idx를 통해서 하도록 설정
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tCashLog_ucode')
    DROP INDEX tCashLog.idx_tCashLog_ucode
GO
CREATE INDEX idx_tCashLog_ucode ON tCashLog (ucode)
GO
--유저로그검색
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tCashLog_gameid')
    DROP INDEX tCashLog.idx_tCashLog_gameid
GO
CREATE INDEX idx_tCashLog_gameid ON tCashLog (gameid)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tCashLog_acode')
    DROP INDEX tCashLog.idx_tCashLog_acode
GO
CREATE INDEX idx_tCashLog_acode ON tCashLog (acode)
GO
--insert into dbo.tCashLog(gameid, acode, ucode, cashcost, cash) values('xxxx', 'xxx', '12345778998765442bcde3123192915243184254', 10, 1000)
--select * from dbo.tCashLog where ucode = '12345778998765442bcde3123192915243184254'

---------------------------------------------
-- 	캐쉬구매Total
---------------------------------------------
IF OBJECT_ID (N'dbo.tCashTotal', N'U') IS NOT NULL
	DROP TABLE dbo.tCashTotal;
GO

create table dbo.tCashTotal(
	idx				int				identity(1, 1),
	dateid			char(8),								-- 20101210
	cashkind		int,

	cashcost		int				default(0), 			-- 총판매량
	cash			int				default(0), 			-- 총판매량
	cnt				int				default(1),				--증가회수
	-- Constraint
	CONSTRAINT	pk_tCashTotal_dateid PRIMARY KEY(dateid, cashkind)
)
-- insert into dbo.tCashTotal(dateid, cashkind, cashcost, cash) values('20120818', 2000, 21, 2000)
-- insert into dbo.tCashTotal(dateid, cashkind, cashcost, cash) values('20120818', 5000, 55, 5000)
-- select top 1 * from dbo.tCashTotal where dateid = '20120818' and cashkind = 2000
-- update dbo.tCashTotal set cashcost = cashcost + 21, cash = cash + 2000, cnt = cnt + 1 where dateid = '20120818' and cashkind = 2000

---------------------------------------------
--	통계자료(캐쉬 마스터)
---------------------------------------------
IF OBJECT_ID (N'dbo.tStaticCashMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tStaticCashMaster;
GO

create table dbo.tStaticCashMaster(
	idx				int					identity(1, 1),

	dateid			varchar(8),									-- 20121118
	step 			int					default(1),				-- famelv(1), tel(2)
	writedate		datetime			default(getdate()), 	-- 작성일

	-- Constraint
	CONSTRAINT pk_tStaticCashMaster_dateid	PRIMARY KEY(dateid)
)
GO

---------------------------------------------
--	통계자료(캐쉬 서브)
---------------------------------------------
IF OBJECT_ID (N'dbo.tStaticCashUnique', N'U') IS NOT NULL
	DROP TABLE dbo.tStaticCashUnique;
GO

create table dbo.tStaticCashUnique(
	idx						int					IDENTITY(1,1),

	dateid					varchar(8),
	cash					int,
	cnt						int,
	writedate				datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tStaticCashUnique_idx		PRIMARY KEY(idx)
)


/*

---------------------------------------------
--		게시판 정보(글쓰기에 우선순위를 올림).
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserBoard', N'U') IS NOT NULL
	DROP TABLE dbo.tUserBoard;
GO

create table dbo.tUserBoard(
	idx			int					IDENTITY(1,1),

	idx2		int,
	kind		int					default(1),					-- 1:일반게시판광고, 2:친추게시판광고, 3:대항게시판광고

	gameid		varchar(20),
	message		varchar(256)		default(''),
	writedate	datetime			default(getdate()), 		-- 선물일

	schoolidx	int					default(-1),

	-- Constraint
	CONSTRAINT	pk_tUserBoard_idx2_kind	PRIMARY KEY(idx)
)
-- 폰인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserBoard_idx2_kind')
    DROP INDEX tUserBoard.idx_tUserBoard_idx2
GO
CREATE INDEX idx_tUserBoard_idx2_kind ON tUserBoard (idx2, kind)
GO

-- insert into dbo.tUserBoard(kind, idx2, gameid, message) values(1, 1, 'xxxx2', '일반게시판광고')
-- insert into dbo.tUserBoard(kind, idx2, gameid, message) values(2, 1, 'xxxx2', '친추게시판광고')
-- insert into dbo.tUserBoard(kind, idx2, gameid, message) values(3, 1, 'xxxx2', '대항게시판광고')
-- select top 5 * from dbo.tUserBoard where kind = 1 order by idx2 desc
-- select top 5 * from dbo.tUserBoard where kind = 2 order by idx2 desc
-- select top 5 * from dbo.tUserBoard where kind = 3 order by idx2 desc


---------------------------------------------
--	로그인 현황, 플레이 현황
---------------------------------------------
IF OBJECT_ID (N'dbo.tStaticTime', N'U') IS NOT NULL
	DROP TABLE dbo.tStaticTime;
GO

create table dbo.tStaticTime(
	idx					int 				IDENTITY(1, 1),
	dateid10			varchar(10),
	logincnt			int					default(0),
	playcnt				int					default(0),

	-- Constraint
	CONSTRAINT	pk_tStaticTime_dateid10	PRIMARY KEY(dateid10)
)
-- select top 1 * from dbo.tStaticTime




---------------------------------------------
-- 이벤트 진행 정보
---------------------------------------------
IF OBJECT_ID (N'dbo.tSysEventInfo', N'U') IS NOT NULL
	DROP TABLE dbo.tSysEventInfo;
GO

create table dbo.tSysEventInfo(
	idx					int 				IDENTITY(1, 1),

	adminid				varchar(20),
	state				int					default(0),				-- 대기중[0], 진행중[1], 완료[2]
	startdate			varchar(16),								-- 2014-05-05 10:00
	enddate				varchar(16),
	company				int					default(0),				-- 상상디지탈(0), 픽토소프트(1)
	title				varchar(256)		default(''),
	comment				varchar(4096)		default(''),
	writedate			datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tSysEventInfo_idx	PRIMARY KEY(idx)
)
-- insert into dbo.tSysEventInfo(adminid, state, startdate, enddate, company, title, comment) values('blackm', 0, '2014-05-12 00:00', '2014-05-12 23:59', 0, '이벤트제목', '이벤트내용')
-- update dbo.tSysEventInfo set state = 1, startdate = '2014-05-12 00:00', enddate = '2014-05-12 23:59', company = 0, title = '이벤트제목', comment = '이벤트내용' where idx = 1
-- select top 10 * from dbo.tSysEventInfo order by idx desc


---------------------------------------------
--	통계마스터[FameLV]
---------------------------------------------
IF OBJECT_ID (N'dbo.tStaticMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tStaticMaster;
GO

create table dbo.tStaticMaster(
	idx				int					identity(1, 1),

	dateid			varchar(8),									-- 20121118
	step 			int					default(1),				-- famelv(1), tel(2)
	writedate		datetime			default(getdate()), 	-- 작성일

	-- Constraint
	CONSTRAINT pk_tStaticMaster_dateid	PRIMARY KEY(dateid)
)
GO

-- select * from dbo.tStaticMaster
-- if(not exist(select dateid from dbo.tStaticMaster where dateid = '20140404'))
-- 		insert into dbo.tStaticMaster(dateid, step) values('20140404', 1)
-- update dbo.tStaticMaster set step = 2 where dateid = '20140404'




---------------------------------------------
--		이벤트 마스터
---------------------------------------------
IF OBJECT_ID (N'dbo.tEventMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tEventMaster;
GO

create table dbo.tEventMaster(
	idx						int					IDENTITY(1,1),
	eventstatemaster		int					default(0),		-- 0:대기중, 1:진행중, 2:완료중

	-- Constraint
	CONSTRAINT	pk_tEventMaster_eventstatemaster	PRIMARY KEY(eventstatemaster)
)
-- 처음 데이타는 넣어줘야한다.
-- insert into dbo.tEventMaster(eventstatemaster) values(0)
-- update dbo.tEventMaster set eventstatemaster = case when eventstatemaster = 0 then 1 else 0 end where idx = 1
-- select eventstatemaster from dbo.tEventMaster where idx = 1


---------------------------------------------
--		이벤트 받아간 유저로그
---------------------------------------------
IF OBJECT_ID (N'dbo.tEvnetUserGetLog', N'U') IS NOT NULL
	DROP TABLE dbo.tEvnetUserGetLog;
GO

create table dbo.tEvnetUserGetLog(
	idx				int					IDENTITY(1,1),

	gameid			varchar(20),
	eventidx		int,
	eventitemcode	int,
	eventcnt		int,
	writedate		datetime			default(getdate()),
	CONSTRAINT	pk_tEvnetUserGetLog_eventidx	PRIMARY KEY(idx)
)

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tEvnetUserGetLog_gameid_eventidx')
    DROP INDEX tEvnetUserGetLog.idx_tEvnetUserGetLog_gameid_eventidx
GO
CREATE INDEX idx_tEvnetUserGetLog_gameid_eventidx ON tEvnetUserGetLog (gameid, eventidx)
GO

-- insert into dbo.tEvnetUserGetLog(gameid, eventidx, eventitemcode) values( 'xxxx2', 1, 1104)
-- select * from dbo.tEvnetUserGetLog where gameid = 'xxxx2' and eventidx = 1

---------------------------------------------
-- 이벤트 인증키값
---------------------------------------------
IF OBJECT_ID (N'dbo.tEventCertNo', N'U') IS NOT NULL
	DROP TABLE dbo.tEventCertNo;
GO

create table dbo.tEventCertNo(
	idx			int				identity(1, 1),
	certno		varchar(16),

	itemcode1	int				default(-1),
	itemcode2	int				default(-1),
	itemcode3	int				default(-1),
	cnt1		int				default(0),
	cnt2		int				default(0),
	cnt3		int				default(0),

	mainkind	int				default(1),		-- 1: 1인1매형, 2:공용형
	kind		int				default(1),		-- 제작요청한 회사번호.

	startdate	datetime		default(getdate()),
	enddate		datetime		default(getdate()),

	CONSTRAINT	pk_tEventCertNo_idx	PRIMARY KEY(idx)
)
-- 인증번호 인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tEventCertNo_certno')
    DROP INDEX tEventCertNo.idx_tEventCertNo_certno
GO
CREATE INDEX idx_tEventCertNo_certno ON tEventCertNo (certno)
GO


---- 1인형(1)
--insert into dbo.tEventCertNo(certno, itemcode1, cnt1, itemcode2, cnt2, itemcode3, cnt3, mainkind, kind, enddate       )
--values(                      'PERSON1',      1,    1,        -1,    0,        -1,    0,        1,    1, getdate() + 1 )
--insert into dbo.tEventCertNo(certno, itemcode1, cnt1, itemcode2, cnt2, itemcode3, cnt3, mainkind, kind, enddate       )
--values(                      'PERSON2',      1,    1,        -1,    0,        -1,    0,        1,    1, getdate() + 1 )
--
---- 공용형(2)
--insert into dbo.tEventCertNo(certno, itemcode1, cnt1, itemcode2, cnt2, itemcode3, cnt3, mainkind, kind, enddate       )
--values(                      'COMMON1',    900,  120,        -1,    0,        -1,    0,        2,    0, getdate() + 1 )
--insert into dbo.tEventCertNo(certno, itemcode1, cnt1, itemcode2, cnt2, itemcode3, cnt3, mainkind, kind, enddate       )
--values(                      'COMMON2',    900,  120,        -1,    0,        -1,    0,        2,    0, getdate() - 1 )
--insert into dbo.tEventCertNo(certno, itemcode1, cnt1, itemcode2, cnt2, itemcode3, cnt3, mainkind, kind, enddate       )
--values(          'ZAYOZAYOTYCOONK5',      5000,  300,      5100, 2000,        -1,    0,        2,    0, getdate() + 7 )


---------------------------------------------
-- 이벤트 인증키값(백업)
-- 누구에게 무슨아이템을 지급했다.
---------------------------------------------
IF OBJECT_ID (N'dbo.tEventCertNoBack', N'U') IS NOT NULL
	DROP TABLE dbo.tEventCertNoBack;
GO

create table dbo.tEventCertNoBack(
	idx			int				identity(1, 1),
	certno		varchar(16),

	gameid		varchar(20),
	itemcode1	int				default(-1),
	itemcode2	int				default(-1),
	itemcode3	int				default(-1),
	cnt1		int				default(0),
	cnt2		int				default(0),
	cnt3		int				default(0),

	mainkind	int				default(1),		-- 1: 1인1매형, 2:공용형
	kind		int				default(1),		-- 제작요청한 회사번호.

	usedtime	datetime		default(getdate()),

	CONSTRAINT	pk_tEventCertNoBack_idx	PRIMARY KEY(idx)
)

-- 인증번호 인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tEventCertNoBack_certno')
    DROP INDEX tEventCertNoBack.idx_tEventCertNoBack_certno
GO
--CREATE INDEX idx_tEventCertNoBack_certno ON tEventCertNoBack (certno)
--GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tEventCertNoBack_gameid_certno')
    DROP INDEX tEventCertNoBack.idx_tEventCertNoBack_gameid_certno
GO
CREATE INDEX idx_tEventCertNoBack_gameid_certno ON tEventCertNoBack (gameid, certno)
GO
*/

