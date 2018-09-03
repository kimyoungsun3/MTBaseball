use Game4
-- 데이타베이스 대소문자 구분안함(새로 세팅된 서버 확인필요)
---------------------------------------------
--		유저정보
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tUserMaster;
GO

create table dbo.tUserMaster(
	--(가입)
	idx			int 					IDENTITY(1, 1),
	gameid		varchar(20),
	password	varchar(20),									-- 암호화해서저장, 유저패스워가 해킹당해도 안전
	email		varchar(60),
	regdate		datetime				default(getdate()),		-- 최초가입일
	condate		datetime				default(getdate()),		-- (로그인시마다 매번업데이트)
	concnt		int						default(1),				-- 접속횟수
	avatar		int						default(0),
	picture		varchar(128)			default('-1'),
	ccode		int						default(2),				-- 1:한국, 2:서울, 광주, 부산등등
	goldball	int						default(0),
	silverball	int						default(0),
	petregister	int						default(0),				-- 0 비등록, 1 등록
	petmsg		varchar(40)				default('교배는 내가 최고'),
	phone		varchar(20)				default(''),
	pushid		varchar(256)			default(''),
	tutorial	int						default(0),				-- 0:미진행, 1: 진행

	-- (시스템정보)
	market		int						default(1),				-- (구매처코드) MARKET_SKT
	mboardstate	int						default(0),				-- (0) 미작성, (1) 작성후 지급함
	buytype		int						default(0),				-- (무료/유료코드)
	platform	int						default(1),				-- (플랫폼)
	ukey		varchar(256),									-- UKey
	version		int						default(100),			-- 클라버젼
	deletestate	int						default(0),				-- 0 : 삭제상태아님, 1 : 삭제상태
	blockstate	int						default(0),				-- 0 : 블럭상태아님, 1 : 블럭상태
	cashcopy	int						default(0),				-- 캐쉬불법카피시 +1추가된다.
	resultcopy	int						default(0),				-- 로그결과카피시 +1추가된다.
	resultwinpush	int 				default(0),				-- 승리를 하면 1, 푸쉬를 하면 0

	-- (아이템코드)
	ccharacter	int						default(0),				-- 캐릭터
	face		int						default(50), 			-- 얼굴
	cap			int						default(100), 			-- 머리정보
	cupper		int						default(200), 			-- 가슴
	cunder		int						default(300), 			-- 하의
	bat			int						default(400), 			-- 배트
	glasses		int						default(-1), 			-- 안경
	wing		int						default(-1), 			-- 날개
	tail		int						default(-1), 			-- 꼬리
	pet			int						default(-1), 			-- 팻
	customize	varchar(128)			default('1'), 			-- 머리사이즈(float형으로 들어간다)
	stadium		int						default(800), 			-- 구장

	-- (행동치)
	actionCount		int					default(25), 				-- 행동치
	actionMax		int					default(25), 				-- 행동치맥스
	actionTime		datetime			default(getdate()), 		-- 지급시간
	actionfreedate	datetime			default(getdate() - 1), 	-- 행동치 자유이용
	actionPush		int					default(0),					-- 행동치 풀 노푸쉬 > 풀스캔을 해야해서 사용안함
	coin			int					default(1), 				-- 코인
	coindate		datetime			default(getdate()), 		-- 코인지급일
	dayplusdate		datetime			default(getdate()), 		-- 골드지급일
	friendlscount	int					default(5), 				-- 락커룸 실버볼 지급개수
	friendlsmax		int					default(5), 				-- 맥스
	friendlstime	datetime			default(getdate()), 		-- 지급시간
	smsCount		int					default(10), 				-- SMS발송
	smsMax			int					default(10), 				-- SMS맥스
	smsTime			datetime			default(getdate()), 		-- 지급시간
	smsjoincnt		int					default(0), 				-- SMS추천후 가입유저카운터
	doubledate		datetime			default(getdate() - 1), 	-- 더블모드
	doublepower		int					default(15),				-- 더블파워
	doubledegree	int					default(15),				-- 더블정밀도

	--(게임모드), 연습모드(산출안함), 머신모드, 암기모드, 소울모드
	trainflag		int					default(0), 				-- 게임상태 0 : 안함,끝 1 : 게임시작
	trainpoint		int					default(0), 				-- 총거리
	machineflag		int					default(0), 				-- 게임상태 0 : 안함,끝 1 : 게임시작
	machinepoint	int					default(0), 				-- 총거리
	memorialflag	int					default(0), 				-- 게임상태 0 : 안함,끝 1 : 게임시작
	memorialpoint	int					default(0), 				-- 총점수
	soulflag		int					default(0), 				-- 게임상태 0 : 안함,끝 1 : 게임시작
	soulpoint		int					default(0), 				-- 총점수

	-- (배틀정보)
	btflag			int					default(0), 				-- 게임상태 0 : 안함,끝 1 : 게임시작
	btflag2			int					default(0), 				-- 게임상태 0 : 안함,끝 1 : 게임시작
	gradeexp		int					default(2), 				-- 계급경험치
	grade			int					default(1), 				-- 계급
	gradestar		int					default(2), 				-- 계급스타
	lvexp			int					default(0), 				-- 레벨경험치
	lv				int					default(1), 				-- 레벨
	bttem1chk		int					default(0), 				-- 배틀템1
	bttem2chk		int					default(1), 				-- 배틀템2
	bttem3chk		int					default(0), 				-- 배틀템3
	bttem4chk		int					default(0), 				-- 배틀템4
	bttem5chk		int					default(1), 				-- 배틀템5
	bttotal			int					default(0), 				-- 총전적
	btwin			int					default(0), 				-- 승
	btlose			int					default(0), 				-- 패

	-- 배틀템 보유수량
	bttem1cnt		int					default(3),
	bttem2cnt		int					default(10),
	bttem3cnt		int					default(3),
	bttem4cnt		int					default(3),
	bttem5cnt		int					default(3),

	--배틀검색추가부분
	winstreak		int					default(0),
	winstreak2		int					default(0),
	grademax		int					default(1),
	sprintwin		int					default(0), 			-- 스프린트 10승 카운터

	-- 유저세이브데이타
	itemupgradecnt		int				default(0),	-- 강화 횟수
	itemupgradebest		int				default(0),	-- 강화 최고

	petmatingcnt		int				default(0),	-- 교배 횟수
	petmatingbest		int				default(0),	-- 교배 최고

	machpointaccrue		int				default(0),	-- 점수누적
	machpointbest		int				default(0), -- 점수최고
	machplaycnt			int				default(0),	-- 플레이수횟수

	mempointaccrue		int				default(0),	-- 점수누적
	mempointbest		int				default(0),	-- 최대콤보
	memplaycnt			int				default(0),	-- 플레이수횟수

	friendaddcnt		int				default(0),	-- 추가
	friendvisitcnt		int				default(0),	-- 방문횟수

	pollhitcnt			int				default(0),	-- 히트횟수
	ceilhitcnt			int				default(0),	-- 히트횟수
	boardhitcnt			int				default(0),	-- 히트횟수

	btdistaccrue		int				default(0),	-- 비거리누적
	btdistbest			int				default(0),	-- 최고비거리
	bthrcnt				int				default(0),	-- 홈런횟수
	bthrcombo			int				default(0),	-- 홈런콤보
	btwincnt			int				default(0),	-- 승횟수
	btwinstreak			int				default(0),	-- 연승
	btplaycnt			int				default(0),	-- 플레이횟수

	spdistaccrue		int				default(0),	-- 비거리누적
	spdistbest			int				default(0),	-- 최고비거리
	sphrcnt				int				default(0),	-- 홈런횟수누적
	sphrcombo			int				default(0),	-- 홈런콤보
	spwincnt			int				default(0),	-- 승횟수누적
	spwinstreak			int				default(0),	-- 연승
	spplaycnt			int				default(0),	-- 플레이횟수

	-- 각모드에 대한 백업
	trainpointbkup		int				default(0),
	machinepointbkup	int				default(0),
	memorialpointbkup	int				default(0),
	soulpointbkup		int				default(0),
	bttotalbkup			int				default(0),
	btwinbkup			int				default(0),
	btlosebkup			int				default(0),

	-- 이벤트플래그
	eventnpcwin			int				default(0),	-- 아직안함(0), 지급(1)

	-- Constraint
	CONSTRAINT pk_tUserMaster_gameid	PRIMARY KEY(gameid)
)
GO

-- alter table dbo.tUserMaster add doubledate		datetime			default(getdate() - 1)
-- alter table dbo.tUserMaster add smsCount			int					default(10)
-- alter table dbo.tUserMaster add smsMax			int					default(10)
-- alter table dbo.tUserMaster add smsTime			datetime			default(getdate())
-- update dbo.tUserMaster set smsCount = 10, smsMax = 10, smsTime = getdate()
-- alter table dbo.tUserMaster add trainpointbkup		int				default(0)
-- alter table dbo.tUserMaster add machinepointbkup		int				default(0)
-- alter table dbo.tUserMaster add memorialpointbkup	int				default(0)
-- alter table dbo.tUserMaster add soulpointbkup		int				default(0)
-- alter table dbo.tUserMaster add bttotalbkup			int				default(0)
-- alter table dbo.tUserMaster add btwinbkup			int				default(0)
-- alter table dbo.tUserMaster add btlosebkup			int				default(0)
-- update dbo.tUserMaster set trainpointbkup = 0, machinepointbkup = 0, memorialpointbkup = 0, soulpointbkup = 0, bttotalbkup = 0, btwinbkup = 0, btlosebkup = 0
-- alter table dbo.tUserMaster add dayplusdate	datetime				default(getdate()) 		-- 골드지급일
-- update dbo.tUserMaster set dayplusdate = getdate()
-- alter table dbo.tUserMaster add machplaycnt			int				default(0)
-- alter table dbo.tUserMaster add memplaycnt			int				default(0)
-- alter table dbo.tUserMaster add tutorial	int						default(0)				-- 0:미진행, 1: 진행
-- update dbo.tUserMaster set machplaycnt = 0, memplaycnt = 0
-- alter table dbo.tUserMaster add phone		varchar(20)
-- alter table dbo.tUserMaster add pushid		varchar(256)
-- select top 10 * from tUserMaster
-- alter table dbo.tUserMaster add sprintwin		int					default(0)
-- update dbo.tUserMaster set sprintwin =
-- alter table dbo.tUserMaster add friendLSCount int default(5)
-- alter table dbo.tUserMaster add friendLSMax int default(5)
-- alter table dbo.tUserMaster add friendLSTime datetime default(getdate())
-- update dbo.tUserMaster set friendLSCount = 5, friendLSMax = 5, friendLSTime = getdate()
-- update dbo.tUserMaster set petmsg = '교배는 내가 최고'
-- update dbo.tUserMaster set winstreak2 = 0, btflag2 = 0
-- update dbo.tUserMaster set winstreak = 0, grademax = 1
-- select top 10 * from tUserMaster where winstreak < 0
-- update dbo.tUserMaster set trainflag = 0, machineflag = 0, memorialflag = 0, soulflag = 0
-- update dbo.tUserMaster set ccode = 1
-- update dbo.tUserMaster set concnt = 1
-- update dbo.tUserMaster set customize = '1'
-- update dbo.tUserMaster set picture = '-1'
-- update dbo.tUserMaster set resultcopy = 0
-- update dbo.tUserMaster set gradeexp = 2, grade =1, gradestar = 2

-- 데이타 10만건 강제로 넣어서 쿼리해보기(상상ID로 만든 유저를 입력한다.)
-- 가입시 gameid 쿼리 > PRIMARY KEY(gameid) > 인덱싱

-- 폰인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserMaster_phone')
    DROP INDEX tUserMaster.idx_tUserMaster_phone
GO
CREATE INDEX idx_tUserMaster_phone ON tUserMaster (phone)
GO

-- 가입시 이메일 인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserMaster_email')
    DROP INDEX tUserMaster.idx_tUserMaster_email
GO
CREATE INDEX idx_tUserMaster_email ON tUserMaster (email)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserMaster_idx')
   DROP INDEX tUserMaster.idx_tUserMaster_idx
GO
CREATE INDEX idx_tUserMaster_idx ON tUserMaster (idx)
GO
--select max(idx) from dbo.tUserMaster

--머신 > 포인트
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserMaster_machinepoint')
    DROP INDEX tUserMaster.idx_tUserMaster_machinepoint
GO
CREATE INDEX idx_tUserMaster_machinepoint ON tUserMaster (machinepoint)
GO

--암기 > 포인트
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserMaster_memorialpoint')
    DROP INDEX tUserMaster.idx_tUserMaster_memorialpoint
GO
CREATE INDEX idx_tUserMaster_memorialpoint ON tUserMaster(memorialpoint)
GO


--배틀모드 랭킹
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserMaster_btwin_d_bttotal_a')
    DROP INDEX tUserMaster.idx_tUserMaster_btwin_d_bttotal_a
GO
CREATE INDEX idx_tUserMaster_btwin_d_bttotal_a ON tUserMaster (btwin desc, bttotal asc)
GO


--펫등록검색
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserMaster_gameid_petregister_pet')
    DROP INDEX tUserMaster.idx_tUserMaster_gameid_petregister_pet
GO
CREATE INDEX idx_tUserMaster_gameid_petregister_pet ON tUserMaster (gameid, petregister, pet)
GO
-- 등록, 해제하기
-- update dbo.tUserMaster set petregister = 1 where gameid = 'DD9999'
-- update dbo.tUserMaster set petregister = 0 where gameid = 'DD9999'
-- 랜덤 검색, 직접 검색
-- select top 10 gameid, pet from dbo.tUserMaster where gameid != 'DD1' and petregister = 1 and pet != -1 order by newid()
-- select top 10 gameid, pet from dbo.tUserMaster where gameid != 'DD1' and gameid like 'DD%' and petregister = 1 and pet != -1 order by newid()

-- 푸슁 인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserMaster_pushid')
    DROP INDEX tUserMaster.idx_tUserMaster_pushid
GO
CREATE INDEX idx_tUserMaster_pushid ON tUserMaster (pushid)
GO

--상위 10, 내순위
--머신(점수 desc), 암기(점수 desc), 배틀(승 desc, 전적 asc) > 인덱싱
/*
declare @gameid			varchar(20)		set @gameid = 'SangSang'
declare @machinepoint	int,
		@memorialpoint	int,
		@bttotal		int,
		@btwin			int
select @machinepoint = machinepoint, @memorialpoint = memorialpoint, @btwin = btwin, @bttotal = bttotal from tUserMaster where gameid = @gameid
--select @machinepoint, @memorialpoint, @btwin, @bttotal

select top 3 rank() over(order by machinepoint desc) as rank, gameid, machinepoint, memorialpoint, btwin, bttotal from dbo.tUserMaster
union all
select count(gameid) rank, @gameid gameid, @machinepoint machinepoint, @memorialpoint memorialpoint, @btwin btwin, @btwin btwin from dbo.tUserMaster where machinepoint > @machinepoint

select top 3 rank() over(order by memorialpoint desc) as rank, gameid, machinepoint, memorialpoint, btwin, bttotal from dbo.tUserMaster
union all
select count(gameid) rank, @gameid gameid, @machinepoint machinepoint, @memorialpoint memorialpoint, @btwin btwin, @btwin btwin from dbo.tUserMaster where memorialpoint > @memorialpoint

select top 3 rank() over(order by btwin desc, bttotal asc) as rank, gameid, machinepoint, memorialpoint, btwin, bttotal from dbo.tUserMaster
union all
select count(gameid) rank, @gameid gameid, @machinepoint machinepoint, @memorialpoint memorialpoint, @btwin btwin, @btwin btwin from dbo.tUserMaster where btwin >= @btwin and bttotal < @bttotal

*/
/*
-- 강제로 랭킹 데이타 입력
-- 1. 커서선언
-- select top 10 * from dbo.tUserMaster
declare @gameid	varchar(20),
		@point int,
		@point2 int,
		@bttotal int,
		@btwin int

-- 1. 커서선언
declare curUserMaster Cursor for
--select gameid from dbo.tUserMaster where gameid = 'SangSang'
--select gameid from dbo.tUserMaster
--select gameid from dbo.tUserMaster where idx < 100000
select gameid from dbo.tUserMaster where machinepoint <= 0


-- 2. 커서오픈
open curUserMaster

-- 3. 커서 사용
Fetch next from curUserMaster into @gameid
while @@Fetch_status = 0
	Begin
		set @point = Convert(int, ceiling(RAND() * 30000))
		set @point2 = Convert(int, ceiling(RAND() * 30000))
		set @bttotal = Convert(int, ceiling(RAND() * 30000))
		set @btwin = Convert(int, ceiling(RAND() * @bttotal))
		update dbo.tUserMaster
			set
				machinepoint = @point,
				memorialpoint = @point2,
				bttotal = @bttotal,
				btwin = @btwin,
				btlose = @bttotal - @btwin

		where gameid = @gameid
		Fetch next from curUserMaster into @gameid
	end

-- 4. 커서닫기
close curUserMaster
Deallocate curUserMaster
*/

---------------------------------------------
-- 	유저 가입 통계
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserJoinTotal', N'U') IS NOT NULL
	DROP TABLE dbo.tUserJoinTotal;
GO

create table dbo.tUserJoinTotal(
	idx				int				identity(1, 1),
	dateid			char(8),							-- 20101210
	market			int				default(1),			-- (구매처코드) MARKET_SKT

	cnt				int				default(0),
	cnt2			int				default(0),

	-- Constraint
	CONSTRAINT	pk_tUserJoinTotal_dateid	PRIMARY KEY(dateid, market)
)
-- alter table dbo.tUserJoinTotal add market			int				default(1)
-- select top 100 * from dbo.tUserJoinTotal order by dateid desc
-- select top 1 * from dbo.tUserJoinTotal where dateid = '20120818'
-- insert into dbo.tUserJoinTotal(dateid, cnt, cnt2) values('20120818', 1, 0)
--update dbo.tUserJoinTotal
--	set
--		cnt = cnt + 1
--where dateid = '20120818'

---------------------------------------------
--  캐릭터별 커스터마이징 정보
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserCustomize', N'U') IS NOT NULL
	DROP TABLE dbo.tUserCustomize;
GO
create table dbo.tUserCustomize(
	idx			int 					IDENTITY(1, 1),
	gameid		varchar(20),
	itemcode	int,
	customize	varchar(128),
	writedate	datetime				default(getdate()), 		-- 지급시간

	-- Constraint
	CONSTRAINT pk_tUserCustomize_gameid_itemcode	PRIMARY KEY(gameid, itemcode)
)

-- select max(idx) from dbo.tUserCustomize
/*
-- 커스터마이징 정보를 입력하기
-- 1. 커서선언
declare @gameid varchar(20)
declare @ccharacter int
declare @customize varchar(128)

declare curUserMaster Cursor for
select gameid, ccharacter, customize from dbo.tUserMaster
where gameid not in (select gameid from dbo.tUserCustomize)

-- 2. 커서오픈
open curUserMaster

--update dbo.tUserMaster set customize = '1' where customize is null
-- 3. 커서 사용
Fetch next from curUserMaster into @gameid, @ccharacter, @customize
while @@Fetch_status = 0
	Begin
		if(not exists(select * from dbo.tUserCustomize where gameid = @gameid and itemcode = @ccharacter))
			begin
				insert into tUserCustomize(gameid, itemcode, customize)
				values(@gameid, @ccharacter, @customize)
			end
		Fetch next from curUserMaster into @gameid, @ccharacter, @customize
	end

-- 4. 커서닫기
close curUserMaster
Deallocate curUserMaster
*/


---------------------------------------------
--  검색점프id
---------------------------------------------
IF OBJECT_ID (N'dbo.tBattleLogSearchJump', N'U') IS NOT NULL
	DROP TABLE dbo.tBattleLogSearchJump;
GO

create table dbo.tBattleLogSearchJump(
	idx			int 				IDENTITY(1, 1),
	gameid		varchar(20)			not null,
	grade		int,
	searchidx	bigint,

	writedate	datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tBattleLogSearchJump_idx	PRIMARY KEY(idx)
)
-- gameid, grade
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tBattleLogSearchJump_gameid_grade')
    DROP INDEX tBattleLogSearchJump.idx_tBattleLogSearchJump_gameid_grade
GO
CREATE INDEX idx_tBattleLogSearchJump_gameid_grade ON tBattleLogSearchJump (gameid, grade)
GO
--select * from dbo.tBattleLogSearchJump

---------------------------------------------
--  동일계급의 최근 데이터, 대전하지 않는 유저들로 대전
---------------------------------------------
IF OBJECT_ID (N'dbo.tBattleLogSearch', N'U') IS NOT NULL
	DROP TABLE dbo.tBattleLogSearch;
GO

create table dbo.tBattleLogSearch(
	idx			bigint 				IDENTITY(1, 1),
	gameid		varchar(20)			not null,
	grade		int,

	btgameid	varchar(20)			not null,
	btgrade		int,
	btidx		bigint,

	writedate	datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tBattleLogSearch_idx	PRIMARY KEY(idx)
)
-- btgameid, btgrade > btidx가 없는 유저
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tBattleLogSearch_btgameid_btgrade_btidx')
    DROP INDEX tBattleLogSearch.idx_tBattleLogSearch_btgameid_btgrade_btidx
GO
CREATE INDEX idx_tBattleLogSearch_btgameid_btgrade_btidx ON tBattleLogSearch (btgameid, btgrade, btidx)
GO

-- gameid, grade
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tBattleLogSearch_gameid_grade_btidx')
    DROP INDEX tBattleLogSearch.idx_tBattleLogSearch_gameid_grade_btidx
GO
CREATE INDEX idx_tBattleLogSearch_gameid_grade_btidx ON tBattleLogSearch (gameid, grade, btidx)
GO
-- select * from dbo.tBattleLogSearch

---------------------------------------------
--  배틀로그
---------------------------------------------
IF OBJECT_ID (N'dbo.tBattleLog', N'U') IS NOT NULL
	DROP TABLE dbo.tBattleLog;
GO

create table dbo.tBattleLog(
	idxOrder	bigint					IDENTITY(1, 1), 	-- 그냥인덱스
	idx			bigint					default(abs(checksum(newid()))),	-- 인덱스 > 랜덤생성
	gameid		varchar(20), 								-- 아이디
	grade		int,							 			-- 계급
	gradestar	int,
	lv			int,							 			-- 레벨

	btidx		bigint					default(-1),		-- 상대배틀인덱스
	btgameid	varchar(20), 								-- 배틀상대방
	btlog		varchar(1024), 								-- 플레이로그데이타 (회, power, 좌우각, 비각, 히트)
	btitem		varchar(16),			 					-- 배틀템 세팅정보
	btiteminfo	varchar(128), 								-- 아이템정보 (머리, 상의, 하의, 날개, 꼬리, 안경, 팻, 배트)
	bttotal		int,
	btwin		int,										-- 플래이 당시의 승수
	btresult	int, 										-- 승/패		1 : win	0 : lose
	bthit		int, 										-- 총거리
	writedate	datetime			default(getdate()), 	-- 플레이날짜
	btTotalPower int				default(0),				-- 토탈파워
	btTotalCount int				default(0),				-- 토탈히트수
	btAvg		int					default(0),				-- = btTotalPower / btTotalCount
	btsb		int					default(0),				-- 배틀에서 획득한 실버
	btmode		int					default(0),
	winstreak	int					default(0),
	winstreak2	int					default(0),

	btcomment	varchar(256),

	-- Constraint
	CONSTRAINT pk_tBattleLog_idx2	PRIMARY KEY(idx)
)
-- gameid, grade
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tBattleLog_gameid_grade')
    DROP INDEX tBattleLog.idx_tBattleLog_gameid_grade
GO
CREATE INDEX idx_tBattleLog_gameid_grade ON tBattleLog (gameid, grade)
GO

-- idxOrder
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tBattleLog_idxOrder')
    DROP INDEX tBattleLog.idx_tBattleLog_idxOrder
GO
CREATE INDEX idx_tBattleLog_idxOrder ON tBattleLog (idxOrder)
GO

-- 내 <- 상대 btgameid, idxOrder
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tBattleLog_btgameid_idxOrder')
    DROP INDEX tBattleLog.idx_tBattleLog_btgameid_idxOrder
GO
CREATE INDEX idx_tBattleLog_btgameid_idxOrder ON tBattleLog (btgameid, idxOrder desc)
GO

-- 내 -> 상대 gameid, idxOrder
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tBattleLog_gameid_idxOrder')
    DROP INDEX tBattleLog.idx_tBattleLog_gameid_idxOrder
GO
CREATE INDEX idx_tBattleLog_gameid_idxOrder ON tBattleLog (gameid, idxOrder desc)
GO

-- btAvg
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tBattleLog_btAvg')
    DROP INDEX tBattleLog.idx_tBattleLog_btAvg
GO
CREATE INDEX idx_tBattleLog_btAvg ON tBattleLog (btAvg)
GO


-- alter table dbo.tBattleLog add btcomment	varchar(256)
-- alter table dbo.tBattleLog add btmode		int					default(0)
-- alter table dbo.tBattleLog add winstreak		int					default(0)
-- alter table dbo.tBattleLog add winstreak2	int					default(0)
-- alter table dbo.tBattleLog add btsb			int					default(0)
-- update dbo.tBattleLog set btsb = 0
-- select top 10 * from dbo.tBattleLog
-- select max(idxOrder) from dbo.tBattleLog
-- select count(idxOrder) from dbo.tBattleLog
-- alter table dbo.tBattleLog add btTotalPower int NULL
-- alter table dbo.tBattleLog add btTotalCount int NULL
-- alter table dbo.tBattleLog add btAvg int NULL
-- update dbo.tBattleLog set btTotalPower = 0, btTotalCount = 0, btAvg = 1 where gameid = 'SangSang'
-- update dbo.tBattleLog set btTotalPower = 0, btTotalCount = 0, btAvg = 1 where btTotalPower is null
-- update dbo.tBattleLog set btidx = -1

/*
-- 배틀로그를 강제로 입력하기
--select max(idx) from tBattleLogSearch
--select count(*) from tBattleLogSearch where gameid = 'SangSang'
--select * from dbo.tBattleLog
--select max(idx) from dbo.tBattleLog

declare @nameid varchar(20)		set @nameid = 'SangSang'
declare @nameid2 varchar(20)	set @nameid2 = 'DD'
declare @var int
declare @var2 int				set @var2 = 1
declare @grade int
declare @btgrade int
declare @gameid varchar(20)
declare @btgameid varchar(20)
declare @btidx bigint
select @btidx = isnull(max(idx), 0) + 1 from dbo.tBattleLog
while @var2 < 100
	begin
		set @var = 1
		while @var < 100000
			begin
				set @gameid = @nameid + ltrim(@var)
				set @btgameid = @nameid2 + ltrim(@var)
				set @grade = Convert(int, ceiling(RAND() * 50))
				set @btgrade = @grade + Convert(int, ceiling(RAND() * 5))
				if(@btgrade < 1)
					set @btgrade = 1
				else if(@btgrade > 50)
					set @btgrade = 50


				-- 배틀로그
				-- select max(idx) from dbo.tUserMaster
				-- select max(idx) from dbo.tBattleLog
				insert into dbo.tBattleLog(gameid,		grade,	gradestar, lv, 		btgameid,	btlog, btitem, btiteminfo, bttotal, btwin, btresult,	bthit, btTotalPower, btTotalCount, btAvg)
									values(@gameid,		@grade,	3,			1,		@btgameid,
									'@1,3568.0,-38.6,-15.8@1,3483.0,-25.4,-31.7@1,3633.0,-36.1,18.2@1,3766.0,-27.8,-43.7@1,3658.0,-28.9,20.8@1,3358.0,-28.8,-12.8@1,3484.0,-31.2,-9.1@1,3635.0,-33.7,-24.3@0,0.0,0.0,0.0@1,3676.0,-31.2,-34.7@0,0.0,0.0,0.0@1,3630.0,-35.5,5.8@1,3564.0,-36.6,-16.7@1,3103.0,-23.7,41.6@1,3448.0,-35.9,27.8',
									'1,0,0,0,0',
									'0,50,114,220,313,418,5003,510,610,706,2',
									20, 10,
									1, 2000,
									10000, 10, 1000)

				-- 배틀검색
				-- select max(idx) from dbo.tBattleLogSearch
				insert into dbo.tBattleLogSearch(gameid, grade, btgameid, btgrade, btidx)
				values(@gameid, @grade, @btgameid, @btgrade, @btidx)

				set @var = @var + 1
				set @btidx = @btidx + 1
			end
		set @var2 = @var2 + 1
	end
*/

/*
---------------------------------------------
--  배틀로그(기준이하것들)
---------------------------------------------
IF OBJECT_ID (N'dbo.tBattleLogUnder', N'U') IS NOT NULL
	DROP TABLE dbo.tBattleLogUnder;
GO

create table dbo.tBattleLogUnder(
	idxOrder	bigint					IDENTITY(1, 1), 	-- 그냥인덱스
	idx			bigint					default(abs(checksum(newid()))),	-- 인덱스 > 랜덤생성
	gameid		varchar(20), 								-- 아이디
	grade		int,							 			-- 계급
	gradestar	int,
	lv			int,							 			-- 레벨

	btidx		bigint					default(-1),		-- 상대배틀인덱스
	btgameid	varchar(20), 								-- 배틀상대방
	btlog		varchar(1024), 								-- 플레이로그데이타 (회, power, 좌우각, 비각, 히트)
	btitem		varchar(16),			 					-- 배틀템 세팅정보
	btiteminfo	varchar(128), 								-- 아이템정보 (머리, 상의, 하의, 날개, 꼬리, 안경, 팻, 배트)
	bttotal		int,
	btwin		int,										-- 플래이 당시의 승수
	btresult	int, 										-- 승/패		1 : win	0 : lose
	bthit		int, 										-- 총거리
	writedate	datetime			default(getdate()), 	-- 플레이날짜
	btTotalPower int				default(0),				-- 토탈파워
	btTotalCount int				default(0),				-- 토탈히트수
	btAvg		int					default(0),				-- = btTotalPower / btTotalCount

	-- Constraint
	CONSTRAINT pk_tBattleLogUnder_idx	PRIMARY KEY(idx)
)
--select top 10 * from dbo.tBattleLogUnder order by idxOrder desc
-- gameid, grade
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tBattleLogUnder_gameid_grade')
    DROP INDEX tBattleLogUnder.idx_tBattleLogUnder_gameid_grade
GO
CREATE INDEX idx_tBattleLogUnder_gameid_grade ON tBattleLogUnder (gameid, grade)
GO

-- gameid, grade
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tBattleLogUnder_idxOrder')
    DROP INDEX tBattleLogUnder.idx_tBattleLogUnder_idxOrder
GO
CREATE INDEX idx_tBattleLogUnder_idxOrder ON tBattleLogUnder (idxOrder)
GO
*/

---------------------------------------------
-- 	배틀시 국가별 승수
---------------------------------------------
IF OBJECT_ID (N'dbo.tBattleCountry', N'U') IS NOT NULL
	DROP TABLE dbo.tBattleCountry;
GO

create table dbo.tBattleCountry(
	idx				int				identity(1, 1),
	dateid			char(6),								-- 201212
	ccode			int				default(1),
	win				int 			default(0),				-- 증가회수
	lose			int 			default(0),				-- 증가회수

	CONSTRAINT	pk_tBattleCountry_dateid_ccode	PRIMARY KEY(dateid, ccode)
)

-- select * from dbo.tBattleCountry where dateid = '201209' order by win desc, lose asc
-- select * from dbo.tBattleCountry where dateid = '201209' and ccode = 1
-- insert into dbo.tBattleCountry(dateid, ccode, win) values('201209', 1, 1)
-- insert into dbo.tBattleCountry(dateid, ccode, win) values('201209', 2, 1)
-- insert into dbo.tBattleCountry(dateid, ccode, win) values('201209', 3, 1)
--update dbo.tBattleCountry
--	set
--		win = win + 1
--where dateid = '201209' and ccode = 3


---------------------------------------------
-- 	유저가 플레이한 모드
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserGameMode', N'U') IS NOT NULL
	DROP TABLE dbo.tUserGameMode;
GO

create table dbo.tUserGameMode(
	idx				int				identity(1, 1),
	dateid			char(8),								-- 201212
	gmode			int				default(1),
	playcnt			int 			default(1),				-- 회수

	CONSTRAINT	pk_tUserGameMode_dateid_gmode	PRIMARY KEY(dateid, gmode)
)

-- select * from dbo.tUserGameMode where dateid = '20120901' order by gmode desc
-- select * from dbo.tUserGameMode where dateid = '20120901' and gmode = 1
-- insert into dbo.tUserGameMode(dateid, gmode, playcnt) values('20120901', 1, 1)
-- insert into dbo.tUserGameMode(dateid, gmode, playcnt) values('20120901', 2, 1)
-- insert into dbo.tUserGameMode(dateid, gmode, playcnt) values('20120901', 3, 1)
-- update dbo.tUserGameMode set playcnt = playcnt + 1 where dateid = '20120901' and gmode = 3

---------------------------------------------
-- 	유저가 스프린트 중간보상
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserGameSprintReward', N'U') IS NOT NULL
	DROP TABLE dbo.tUserGameSprintReward;
GO

create table dbo.tUserGameSprintReward(
	idx				int				identity(1, 1),
	dateid			char(8),								-- 20121018
	step			int				default(1),
	rewardsb		int,
	rewardcnt		int 			default(1),				-- 회수

	CONSTRAINT	pk_tUserGameSprintReward_dateid_step	PRIMARY KEY(dateid, step)
)

-- insert into dbo.tUserGameSprintReward(dateid, step, rewardsb, rewardcnt) values('20121018', 4, 300, 1)
-- insert into dbo.tUserGameSprintReward(dateid, step, rewardsb, rewardcnt) values('20121018', 7, 700, 1)
-- insert into dbo.tUserGameSprintReward(dateid, step, rewardsb, rewardcnt) values('20121018', 10, 2500, 1)
-- update dbo.tUserGameSprintReward set rewardcnt = rewardcnt + 1, rewardsb = rewardsb + 2500 where dateid = '20121018' and step = 10
-- select * from dbo.tUserGameSprintReward where dateid = '20121018' order by step desc
-- select * from dbo.tUserGameSprintReward where dateid = '20121018' and step = 1


---------------------------------------------
-- 	배틀시 아이템 사용체킹 상태정보
---------------------------------------------
IF OBJECT_ID (N'dbo.tBattleItemUseTotal', N'U') IS NOT NULL
	DROP TABLE dbo.tBattleItemUseTotal;
GO

create table dbo.tBattleItemUseTotal(
	idx				int				identity(1, 1),
	dateid			char(8),							-- 20101210

	bttem1cnt		int				default(0),				--증가회수
	bttem2cnt		int				default(0),				--증가회수
	bttem3cnt		int				default(0),				--증가회수
	bttem4cnt		int				default(0),				--증가회수
	bttem5cnt		int				default(0),				--증가회수

	playcnt			int				default(0),

	-- Constraint
	CONSTRAINT	pk_tBattleItemUseTotal_dateid	PRIMARY KEY(dateid)
)
-- select top 100 * from dbo.tBattleItemUseTotal order by dateid desc
-- select top 1 * from dbo.tBattleItemUseTotal where dateid = '20120818'
-- insert into dbo.tBattleItemUseTotal(dateid, bttem1cnt, bttem2cnt, bttem3cnt, bttem4cnt, bttem5cnt) values('20120818', 1, 0, 0, 0, 0)
--update dbo.tBattleItemUseTotal
--	set
--		bttem1cnt = bttem1cnt + 1,
--		bttem2cnt = bttem2cnt + 1,
--		bttem3cnt = bttem3cnt + 1,
--		bttem4cnt = bttem4cnt + 1,
--		bttem5cnt = bttem5cnt + 1
--		playcnt = playcnt + 1
--where dateid = '20120818'


---------------------------------------------
-- 	(시스템쪽지)
---------------------------------------------
IF OBJECT_ID (N'dbo.tMessage', N'U') IS NOT NULL
	DROP TABLE dbo.tMessage;
GO

create table dbo.tMessage(
	idx			int					IDENTITY(1,1), 			-- 번호
	gameid		varchar(20), 								-- 받는이
	sendid		varchar(20)			default('autosys'), 		-- 보내이
	writedate	datetime			default(getdate()), 	-- 작성일
	newmsg		int					default(1), 			-- 읽었는가? 1:new 0:한번읽음
	comment		varchar(512), 								-- 쪽지내용

	-- Constraint
	CONSTRAINT	pk_tMessage_gameid_writedate	PRIMARY KEY(gameid, idx)
)

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tMessage_writedate')
    DROP INDEX tMessage.idx_tMessage_writedate
GO
CREATE INDEX idx_tMessage_writedate ON tMessage(writedate)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tMessage_idx')
    DROP INDEX tMessage.idx_tMessage_idx
GO
CREATE INDEX idx_tMessage_idx ON tMessage(idx)
GO

/*
select top 10 * from tMessage where gameid = 'SangSang'
insert into tMessage(gameid, comment) values('SangSang', '가입을 진심으로 축하 합니다.')
insert into tMessage(gameid, comment) values('SangSang', '메세지2')
*/

---------------------------------------------
-- 	(어드민 쪽지)
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

-- insert into tMessageAdmin(adminid, gameid, comment) values('black4', 'guest', '골드지급');
-- select top 100 * from tMessageAdmin order by idx desc


---------------------------------------------
-- (회사공지)
---------------------------------------------
IF OBJECT_ID (N'dbo.tNotice', N'U') IS NOT NULL
	DROP TABLE dbo.tNotice;
GO

create table dbo.tNotice(
	idx				int				IDENTITY(1,1), 			-- 번호
	market			int				default(1),
	writedate		datetime		default(getdate()), 	-- 작성일
	branchurl		varchar(512),
	facebookurl		varchar(512),
	adurl			varchar(512),
	adfile			varchar(512),
	adurl2			varchar(512),
	adfile2			varchar(512),
	comment			varchar(4096), 							-- 공지내용
	syscheck		int				default(0),				-- 시스템 점검	0 : 비활성화	1 : 활성화

	-- Constraint
	CONSTRAINT	pk_tNotice_idx	PRIMARY KEY(idx)
)
--
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tNotice_writedate')
    DROP INDEX tNotice.idx_tNotice_writedate
GO
CREATE INDEX idx_tNotice_writedate ON tNotice (writedate)
GO
-- 공지사항(활성 최대 1개)
-- alter table dbo.tNotice add adurl			varchar(512)
-- alter table dbo.tNotice add adfile			varchar(512)
-- alter table dbo.tNotice add branchurl		varchar(512)
-- alter table dbo.tNotice add facebookurl		varchar(512)
--select top 100 * from dbo.tNotice order by writedate desc
--insert into tNotice(comment, syscheck) values('오픈을 축하 합니다.', 0)
--insert into dbo.tNotice(comment, syscheck) values('시스템 점검중입니다.', 1)
--insert into dbo.tNotice(comment, syscheck) values('시스템 점검을 완료했습니다.', 0)



---------------------------------------------
-- (New Version),
---------------------------------------------
IF OBJECT_ID (N'dbo.tNewVersion', N'U') IS NOT NULL
	DROP TABLE dbo.tNewVersion;
GO

create table dbo.tNewVersion(
	idx				int				IDENTITY(1,1), 			-- 번호
	market			int, 									-- 통신사
	url				varchar(256), 							-- URL
	writedate		datetime		default(getdate()), 	-- 작성일

	-- Constraint
	CONSTRAINT	pk_tNewVersion_idx	PRIMARY KEY(idx)
)


---------------------------------------------
-- SMS Link,
---------------------------------------------
IF OBJECT_ID (N'dbo.tSMSLink', N'U') IS NOT NULL
	DROP TABLE dbo.tSMSLink;
GO

create table dbo.tSMSLink(
	idx				int				IDENTITY(1,1), 			-- 번호
	url				varchar(512), 							-- URL
	writedate		datetime		default(getdate()), 	-- 작성일

	-- Constraint
	CONSTRAINT	pk_tSMSLink_idx	PRIMARY KEY(idx)
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
	giftid			varchar(20), 							-- 선물받은사람
	acode			varchar(256), 							-- 승인코드() 사용안함.ㅠㅠ
	ucode			varchar(256), 							-- 승인코드

	ikind			varchar(256),							-- 아이폰의 종류(SandBox, Real)
	idata			varchar(4096),							-- 아이폰에서 사용되는 데이타(원본)
	idata2			varchar(4096),							-- 아이폰에서 사용되는 데이타(해석본)

	goldball		int				default(0), 			-- 충전골든볼
	cash			int				default(0),				-- 구매현금
	writedate		datetime		default(getdate()), 	-- 구매일
	market			int				default(1),				-- (구매처코드) MARKET_SKT

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
--insert into dbo.tCashLog(gameid, acode, ucode, goldball, cash) values('SangSang', 'xxx', '12345778998765442bcde3123192915243184254', 10, 1000)
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
	market			int				default(1),				-- (구매처코드) MARKET_SKT

	goldball		int				default(0), 			-- 총판매량
	cash			int				default(0), 			-- 총판매량
	cnt				int				default(1),				--증가회수
	-- Constraint
	CONSTRAINT	pk_tCashTotal_dateid_market	PRIMARY KEY(dateid, cashkind, market)
)
-- insert into dbo.tCashTotal(dateid, cashkind, market, goldball, cash) values('20120818', 2000, 1, 21, 2000)
-- insert into dbo.tCashTotal(dateid, cashkind, market, goldball, cash) values('20120818', 5000, 1, 55, 5000)
-- select top 1 * from dbo.tCashTotal where dateid = '20120818' and cashkind = 2000 and market = 1
-- update dbo.tCashTotal set goldball = goldball + 21, cash = cash + 2000, cnt = cnt + 1 where dateid = '20120818' and cashkind = 2000 and market = 1


---------------------------------------------
-- 	캐쉬환전로그
---------------------------------------------
IF OBJECT_ID (N'dbo.tCashChangeLog', N'U') IS NOT NULL
	DROP TABLE dbo.tCashChangeLog;
GO

create table dbo.tCashChangeLog(
	idx				int				identity(1, 1),
	gameid			varchar(20)		not null, 				-- 구매자
	goldball		int, 									-- 환전골드
	silverball		int, 									-- 환전실버
	writedate		datetime		default(getdate()),		-- 환전일

	-- Constraint
	CONSTRAINT	pk_tCashChangeLog_idx	PRIMARY KEY(idx)
)
--캐쉬환전인덱스
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tCashChangeLog_gameid_idx')
    DROP INDEX tCashChangeLog.idx_tCashChangeLog_gameid_idx
GO
CREATE INDEX idx_tCashChangeLog_gameid_idx ON tCashChangeLog (gameid, idx desc)
GO

-- insert into dbo.tCashChangeLog(gameid, goldball, silverball) values('SangSang', 10, 1000)
-- insert into dbo.tCashChangeLog(gameid, goldball, silverball) values('SangSang', 20, 2000)
-- insert into dbo.tCashChangeLog(gameid, goldball, silverball) values('SangSang', 30, 3000)
-- insert into dbo.tCashChangeLog(gameid, goldball, silverball) values('SangSang', 40, 4000)
-- insert into dbo.tCashChangeLog(gameid, goldball, silverball) values('DD0', 10, 1000)
-- select * from dbo.tCashChangeLog where gameid = 'SangSang' order by idx desc

---------------------------------------------
-- 	캐쉬환전토탈
---------------------------------------------
IF OBJECT_ID (N'dbo.tCashChangeLogTotal', N'U') IS NOT NULL
	DROP TABLE dbo.tCashChangeLogTotal;
GO

create table dbo.tCashChangeLogTotal(
	idx				int				identity(1, 1),
	dateid			char(8),							-- 20101210

	goldball		int				default(0),
	silverball		int				default(0),

	changecnt		int				default(1),

	-- Constraint
	CONSTRAINT	pk_tCashChangeLogTotal_dateid	PRIMARY KEY(dateid)
)
-- select top 100 * from dbo.tCashChangeLogTotal order by dateid desc
-- select top 1 * from dbo.tCashChangeLogTotal where dateid = '20120818'
-- insert into dbo.tCashChangeLogTotal(dateid, goldball, silverball, changecnt) values('20120818', 10, 1000, 1)
--update dbo.tCashChangeLogTotal
--	set
--		goldball = goldball + 10,
--		silverball = silverball + 10000,
--		changecnt = changecnt + 1
--where dateid = '20120818'


---------------------------------------------
--		아이템 보유정보
---------------------------------------------
IF OBJECT_ID (N'dbo.tGiftList', N'U') IS NOT NULL
	DROP TABLE dbo.tGiftList;
GO

create table dbo.tGiftList(
	idx			int					IDENTITY(1,1),
	gameid		varchar(20),									-- gameid별 itemcode는 중복이 발생한다.
	itemcode	int,
	period2		int					default(7), 				-- (-1)영구, (1)1일, (7)7일, 30(30일)
	upgradestate2	int				default(0), 				-- 강화상태
	gainstate	int					default(0),					-- 가져간상태	0:안가져감, 1:가져감
	gaindate	datetime, 										-- 가져간날

	giftid		varchar(20)			default('SangSang'),		-- 선물한 유저
	giftdate	datetime			default(getdate()), 		-- 선물일

	-- Constraint
	CONSTRAINT	pk_tGiftList_gameid_idx	PRIMARY KEY(gameid, idx)
)
-- alter table dbo.tGiftList add upgradestate2	int				default(0)
-- update dbo.tGiftList set upgradestate2 = 0
-- alter table dbo.tGiftList add period2		int				default(7)
-- update dbo.tGiftList set period2 = 7
-- 자동 인덱싱 된다. ㅎㅎㅎ
-- select * from dbo.tGiftList where gameid = 'SangSang' and gainstate = 0 order by giftdate asc
-- 입력하기
-- insert into dbo.tGiftList(gameid, itemcode, giftid) values('SangSang', 101, 'SangSang');
-- insert into dbo.tGiftList(gameid, itemcode, giftid) values('SangSang', 102, 'SangSang');
-- insert into dbo.tGiftList(gameid, itemcode, giftid) values('SangSang', 6000, 'SangSang');
-- insert into dbo.tGiftList(gameid, itemcode, giftid) values('SangSang', 6000, 'SangSang');
--
-- 선물받기
/*
아이템 받는 상태로 변경 > 아이템 테이블 참조해서 선물 입력
DECLARE @tGainGift TABLE(
	gameid varchar(20),
	itemcode int
);
update dbo.tGiftList
	set
		gaindate = getdate(),
		gainstate = 1
		OUTPUT DELETED.gameid, DELETED.itemcode INTO @tGainGift
where idx = 1
select * from @tGainGift
select * from dbo.tGiftList
*/

---------------------------------------------
--		아이템 보유정보
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserItem', N'U') IS NOT NULL
	DROP TABLE dbo.tUserItem;
GO

create table dbo.tUserItem(
	idx				int					IDENTITY(1,1),
	gameid			varchar(20),									-- gameid별 itemcode는 유일하다.
	itemcode		int,
	buydate			datetime			default(getdate()), 		-- 구매일
	expiredate		datetime			default(getdate()), 		-- 만기일
	expirestate		int					default(0),					-- 기간말료메세지	0:활성화, 1:만료, 시스템 메시지 전송
	upgradestate	int					default(0), 				-- 강화상태
	upgradecost		int					default(0),
	lvignore		int					default(0),					-- 0:렙제있다, 1:렙제무시하기

	-- Constraint
	CONSTRAINT	pk_tUserItem_gameid_itemcode	PRIMARY KEY(gameid, itemcode)
)

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserItem_idx')
    DROP INDEX tUserItem.idx_tUserItem_idx
GO
CREATE INDEX idx_tUserItem_idx ON tUserItem (idx)
GO
-- 자동 인덱싱 된다. ㅎㅎㅎ
-- 아이템 입력하기
--update dbo.tUserItem set upgradecost = 0
--insert into dbo.tUserItem(gameid, itemcode, buydate, expiredate) values('SangSang', 105, '2012-07-30 10:00:00', '2012-07-30 11:00:00')
--insert into dbo.tUserItem(gameid, itemcode, buydate, expiredate) values('SangSang', 103, '2012-07-30 10:00:00', '2012-07-30 11:00:00')
--insert into dbo.tUserItem(gameid, itemcode, buydate, expiredate) values('SangSang', 104, '2012-07-30 10:00:00', '2012-07-30 11:00:00')
--insert into dbo.tUserItem(gameid, itemcode, buydate, expiredate) values('SangSang', 105, getdate(), '2012-07-31 18:56:00')
--insert into dbo.tUserItem(gameid, itemcode, buydate, expiredate) values('SangSang', 107, '2012-07-30 10:00:00', '2012-07-30 11:00:00')
--insert into dbo.tUserItem(gameid, itemcode, buydate, expiredate) values('SangSang', 108, '2012-07-30 10:00:00', '2012-07-30 11:00:00')
--insert into dbo.tUserItem(gameid, itemcode, buydate, expiredate, upgradestate) values('SangSang', 106, getdate(), '2012-07-31 18:50:00', 3)
--select max(idx) from dbo.tUserItem
--select * from dbo.tUserItem where gameid = 'SangSang' and expirestate = 0

---------------------------------------------
--		구매했던 로그
---------------------------------------------
IF OBJECT_ID (N'dbo.tItemBuyLog', N'U') IS NOT NULL
	DROP TABLE dbo.tItemBuyLog;
GO

create table dbo.tItemBuyLog(
	idx			int					IDENTITY(1,1), 					-- 번호
	gameid		varchar(20), 										-- 유저id
	itemcode	int, 												-- 아이템코드, 중복 구매기록한다.
	goldball	int					default(0), 					-- 구매가격(세일할수있어서)
	silverball	int					default(0),
	buydate		datetime			default(getdate()), 			-- 구매일

	-- Constraint
	CONSTRAINT	pk_tItemBuyLog_idx	PRIMARY KEY(idx)
)
--select top 20 * from dbo.tItemBuyLog a join dbo.tItemInfo b on a.itemcode = b.itemcode where gameid = 'SangSang' order by a.idx desc
--select top 20 a.idx 'idx', gameid, a.itemcode 'itemcode', a.goldball 'goldball', a.silverball 'silverball', a.buydate, b.itemname, b.silverball 'silverball2', b.goldball 'goldball2', b.period, b.explain from dbo.tItemBuyLog a join dbo.tItemInfo b on a.itemcode = b.itemcode where gameid = 'SangSang' order by a.idx desc
--select top 20 * from dbo.tItemBuyLog where buydate between '2012-08-09 00:00:01' and '2012-08-10 00:00:01' order by idx desc
--insert into dbo.tItemBuyLog(gameid, itemcode, goldball, silverball) values('SangSang45', 1, 0, 91)
--insert into dbo.tItemBuyLog(gameid, itemcode, goldball, silverball) values('SangSang', 1, 0, 91)
--통계용 인덱스
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tItemBuyLog_buydate')
    DROP INDEX tItemBuyLog.idx_tItemBuyLog_buydate
GO
CREATE INDEX idx_tItemBuyLog_buydate ON tItemBuyLog (buydate)
GO

--유저 검색용 인덱스
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tItemBuyLog_gameid_idx')
    DROP INDEX tItemBuyLog.idx_tItemBuyLog_gameid_idx
GO
CREATE INDEX idx_tItemBuyLog_gameid_idx ON tItemBuyLog (gameid, idx)
GO

---------------------------------------------
-- 	구매했던 로그 > 통계용
---------------------------------------------
IF OBJECT_ID (N'dbo.tItemBuyLogTotalSub', N'U') IS NOT NULL
	DROP TABLE dbo.tItemBuyLogTotalSub;
GO

create table dbo.tItemBuyLogTotalSub(
	idx				int				identity(1, 1),
	dateid			char(8),							-- 20101210
	itemcode		int,

	goldball		int				default(0),
	silverball		int				default(0),
	cnt				int				default(0),

	-- Constraint
	CONSTRAINT	pk_tItemBuyLogTotalSub_dateid_itemcode	PRIMARY KEY(dateid, itemcode)
)
-- select top 100 * from dbo.tItemBuyLogTotalSub order by dateid desc, itemcode desc
-- select         * from dbo.tItemBuyLogTotalSub where dateid = '20120818'
-- select top 1   * from dbo.tItemBuyLogTotalSub where dateid = '20120818' and itemcode = 1
--update dbo.tItemBuyLogTotalSub
--	set
--		goldball = goldball + 1,
--		silverball = silverball + 1,
--		cnt = cnt + 1
--where dateid = '20120818' and itemcode = 1
-- insert into dbo.tItemBuyLogTotalSub(dateid, itemcode, goldball, silverball, cnt) values('20120818', 1, 100, 0, 1)


---------------------------------------------
-- 	구매했던 로그 > 통계용2 Master
---------------------------------------------
IF OBJECT_ID (N'dbo.tItemBuyLogTotalMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tItemBuyLogTotalMaster;
GO

create table dbo.tItemBuyLogTotalMaster(
	idx				int				identity(1, 1),
	dateid			char(8),							-- 20101210

	goldball		int				default(0),
	silverball		int				default(0),
	cnt				int				default(0),

	-- Constraint
	CONSTRAINT	pk_tItemBuyLogTotalMaster_dateid	PRIMARY KEY(dateid)
)
-- select top 100 * from dbo.tItemBuyLogTotalMaster order by dateid desc
-- select         * from dbo.tItemBuyLogTotalMaster where dateid = '20120818'
-- select top 1   * from dbo.tItemBuyLogTotalMaster where dateid = '20120818'
--update dbo.tItemBuyLogTotalMaster
--	set
--		goldball = goldball + 1,
--		silverball = silverball + 1,
--		cnt = cnt + 1
--where dateid = '20120818'
-- insert into dbo.tItemBuyLogTotalSub(dateid, goldball, silverball, cnt) values('20120818', 100, 0, 1)


---------------------------------------------
-- 	부스터, 더블 > 통계용
---------------------------------------------
IF OBJECT_ID (N'dbo.tItemBuyPromotionTotal', N'U') IS NOT NULL
	DROP TABLE dbo.tItemBuyPromotionTotal;
GO

create table dbo.tItemBuyPromotionTotal(
	idx				int				identity(1, 1),
	dateid			char(8),							-- 20101210
	itemcode		int,

	cnt				int				default(1),
	goldball		int				default(0),

	-- Constraint
	CONSTRAINT	pk_tItemBuyPromotionTotal_dateid_itemcode	PRIMARY KEY(dateid, itemcode)
)

--update dbo.tItemBuyPromotionTotal
--	set
--		goldball = goldball + 20,
--		cnt = cnt + 1
--where dateid = '20130105' and itemcode = 7002
-- insert into dbo.tItemBuyPromotionTotal(dateid, itemcode, cnt, goldball) values('20130105', 7002, 1, 20)
-- insert into dbo.tItemBuyPromotionTotal(dateid, itemcode, cnt, goldball) values('20130105', 7003, 1, 20)
-- select top 100 * from dbo.tItemBuyPromotionTotal order by dateid desc, itemcode desc
-- select top 1   * from dbo.tItemBuyPromotionTotal where dateid = '20130105' and itemcode = 7002


---------------------------------------------
--		업그레이드로그
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserItemUpgradeLog', N'U') IS NOT NULL
	DROP TABLE dbo.tUserItemUpgradeLog;
GO

create table dbo.tUserItemUpgradeLog(
	idx				int				IDENTITY(1,1),			-- 번호
	gameid			varchar(20),							-- 아이디
	itemcode		int, 									-- 아이템코드, 중복 강화기록한다.
	upgradebranch	int,
	upgraderesult	int,
	upgradestate	int, 									-- 현재등급
	silverball		int, 									-- 사용실버
	goldball		int,
	writedate		datetime		default(getdate()), 	-- 업그레이드한날짜

	-- Constraint
	CONSTRAINT	pk_tUserItemUpgradeLog_idx	PRIMARY KEY(idx)
)
--유저 검색용 인덱스
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserItemUpgradeLog_gameid_idx')
    DROP INDEX tUserItemUpgradeLog.idx_tUserItemUpgradeLog_gameid_idx
GO
CREATE INDEX idx_tUserItemUpgradeLog_gameid_idx ON tUserItemUpgradeLog (gameid, idx)
GO
--insert into dbo.tUserItemUpgradeLog(gameid, itemcode, upgradebranch, upgraderesult, upgradestate, silverball, goldball) values('SangSang', 101, 1, 1, 1, 100, 200)
--select * from tUserItemUpgradeLog where gameid = 'SangSang'

---------------------------------------------
-- 	강화했던 로그 > 통계용
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserItemUpgradeLogTotal', N'U') IS NOT NULL
	DROP TABLE dbo.tUserItemUpgradeLogTotal;
GO

create table dbo.tUserItemUpgradeLogTotal(
	idx				int				identity(1, 1),
	dateid			char(8),

	branchplatinum	int				default(0),
	branchgold		int				default(0),
	branchsilver	int				default(0),
	branchdong		int				default(0),
	branchpet		int				default(0),

	goldball		int				default(0),
	silverball		int				default(0),
	cnt				int				default(0),

	-- Constraint
	CONSTRAINT	pk_tUserItemUpgradeLogTotal_dateid	PRIMARY KEY(dateid)
)
--update dbo.tUserItemUpgradeLogTotal set branchpet = 0
-- select top 100 * from dbo.tUserItemUpgradeLogTotal order by dateid desc
-- select top 1   * from dbo.tUserItemUpgradeLogTotal where dateid = '20120818'
--update dbo.tUserItemUpgradeLogTotal
--	set
--		branchplatinum = branchplatinum + 1,
--		goldball = goldball + 1,
--		silverball = silverball + 1,
--		cnt = cnt + 1
--where dateid = '20120818'
-- insert into dbo.tUserItemUpgradeLogTotal(dateid, branchplatinum, branchgold, branchsilver, branchdong, goldball, silverball, cnt) values('20120818', 0, 0, 0, 0, 0, 0, 1)


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
-- insert into dbo.tUserUnusualLog(gameid, comment) values('x2', '연습결과조작시도')
-- insert into dbo.tUserUnusualLog(gameid, comment) values('x3', '머신결과조작 실버볼사시도')
-- insert into dbo.tUserUnusualLog(gameid, comment) values('x4', '암기결과조작 실버볼사시도')
-- insert into dbo.tUserUnusualLog(gameid, comment) values('x5', '소울결과조작 실버볼사시도')
-- insert into dbo.tUserUnusualLog(gameid, comment) values('x6', '배틀결과조작 실버볼사시도')
-- 자동오더링이 되어있다.(order by idx desc)
-- select top 20 * from dbo.tUserUnusualLog order by idx desc
-- select top 20 * from dbo.tUserUnusualLog where gameid = 'x1' order by idx desc


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
-- update dbo.tUserBlockLog set blockstate = 0, adminid = 'SangSang', adminip = '172.0.0.1', comment2 = '풀어주었다.', releasedate = getdate() where idx = 17
-- select * from dbo.tUserBlockLog order by idx desc
-- select idx, gameid, comment, writedate, blockstate, adminid, comment2, releasedate from dbo.tUserBlockLog order by idx desc
-- select top 20 * from dbo.tUserBlockLog where gameid = 'DD0' order by idx desc
---------------------------------------------
--		유저가 삭제 요청에 의한 삭제
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserDeleteLog', N'U') IS NOT NULL
	DROP TABLE dbo.tUserDeleteLog;
GO

create table dbo.tUserDeleteLog(
	idx				int				IDENTITY(1,1),
	gameid			varchar(20), 							-- 아이디
	comment			varchar(512), 							-- 코멘트
	writedate		datetime		default(getdate()), 	-- 삭제요청
	deletestate		int				default(1), 			-- 삭제상태 0 : 삭제상태아님 1 : 삭제상태

	adminid			varchar(20),
	adminip			varchar(40),
	comment2		varchar(512),							-- 코멘트
	releasedate		datetime								-- 해제일

	-- Constraint
	CONSTRAINT pk_tUserDeleteLog_idx PRIMARY KEY(idx)
)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserDeleteLog_gameid_idx')
    DROP INDEX tUserDeleteLog.idx_tUserDeleteLog_gameid_idx
GO
CREATE INDEX idx_tUserDeleteLog_gameid_idx ON tUserDeleteLog(gameid, idx)
GO
-- select * from dbo.tUserDeleteLog order by idx desc
-- select * from dbo.tUserDeleteLog order by idx desc
-- select top 20 * from dbo.tUserDeleteLog where gameid = 'DD0' order by idx desc
---------------------------------------------
--		친구
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserFriend', N'U') IS NOT NULL
	DROP TABLE dbo.tUserFriend;
GO

create table dbo.tUserFriend(
	idx				int				IDENTITY(1,1),
	gameid			varchar(20)		NOT NULL,
	friendid		varchar(20)		NOT NULL, 				-- 친구아이디
	writedate		datetime		default(getdate()), 	-- 등록일
	familiar		int				default(1), 			-- 친밀도(방문마다+1)

	-- Constraint
	CONSTRAINT pk_tUserFriend_gameid_friendid	PRIMARY KEY(gameid, friendid)
)

--암기 > 포인트
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserFriend_gameid_familiar')
    DROP INDEX tUserFriend.idx_tUserFriend_gameid_familiar
GO
CREATE INDEX idx_tUserFriend_gameid_familiar ON tUserFriend(gameid, familiar desc)
GO

/*
-- SangSang > 친구들
--insert into dbo.tUserFriend(gameid, friendid) values('SangSang', 'SangSang11')
--insert into dbo.tUserFriend(gameid, friendid) values('SangSang', 'SangSang12')
--insert into dbo.tUserFriend(gameid, friendid) values('SangSang', 'SangSang121')
--insert into dbo.tUserFriend(gameid, friendid) values('SangSang', 'SangSang122')
--insert into dbo.tUserFriend(gameid, friendid) values('SangSang', 'SangSang123')
--insert into dbo.tUserFriend(gameid, friendid) values('SangSang', 'SangSang124')
--insert into dbo.tUserFriend(gameid, friendid) values('SangSang', 'SangSang125')
--insert into dbo.tUserFriend(gameid, friendid) values('SangSang', 'SangSang126')
-- SangSang11 > 친구들
--insert into dbo.tUserFriend(gameid, friendid) values('SangSang11', 'SangSang')

select * from dbo.tUserFriend where gameid = 'SangSang'
select * from dbo.tUserFriend where gameid = 'SangSang' order by familiar desc
update dbo.tUserFriend set familiar = familiar + 1 where gameid = @gameid_ and friendid = @friendid_
*/


---------------------------------------------
--  마켓패치
---------------------------------------------
IF OBJECT_ID (N'dbo.tMarketPatch', N'U') IS NOT NULL
	DROP TABLE dbo.tMarketPatch;
GO

create table dbo.tMarketPatch(
	idx				int 				IDENTITY(1, 1),
	market		int,
	buytype		int,
	version		int,
	branchurl	varchar(512)		default(''),
	mboardurl	varchar(512)		default(''),
	writedate	datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tMarketPatch_idx	PRIMARY KEY(market, buytype)
)

-- insert into dbo.tMarketPatch(market, buytype, version, branchurl) values(1, 0, 100, 'http://m.naver.com')
-- update dbo.tMarketPatch set version = 100, branchurl = 'http://m.naver.com' where market = 1 and buytype = 0
-- select * from dbo.tMarketPatch where market = 1 and buytype = 0


---------------------------------------------
--  퀘스트진행
---------------------------------------------
IF OBJECT_ID (N'dbo.tQuestUser', N'U') IS NOT NULL
	DROP TABLE dbo.tQuestUser;
GO

create table dbo.tQuestUser(
	idx				int 				IDENTITY(1, 1),
	gameid			varchar(20),
	questcode		int,
	queststate 		int					default(1),				-- 완료(0), 대기중(1) 진행중(2)
	queststart		datetime			default(getdate()),
	questend		datetime,

	-- Constraint
	CONSTRAINT	pk_tQuestUser_idx	PRIMARY KEY(gameid, questcode)
)
-- idx
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tQuestUser_idx')
    DROP INDEX tQuestUser.idx_tQuestUser_idx
GO
CREATE INDEX idx_tQuestUser_idx ON tQuestUser (idx)
GO



---------------------------------------------
--  퀘스트진행
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

--insert into tAdminUser(gameid, password) values('mobine', 'mobine2013')
--insert into tAdminUser(gameid, password) values('sangsang', 'sangsang2013')



---------------------------------------------
-- 	룰렛 로그 > 통계용2 Master
---------------------------------------------
IF OBJECT_ID (N'dbo.tRouletteLogTotalMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tRouletteLogTotalMaster;
GO

create table dbo.tRouletteLogTotalMaster(
	idx				int				identity(1, 1),
	dateid			char(8),							-- 20101210
	goldballkind	int				default(2),

	goldball		int				default(0),			-- 누적 골든볼 (-)
	silverball		int				default(0),			-- 누적 실버볼 (+)
	itemcodecnt		int				default(0),			-- 누적 아이템 (+)
	cnt				int				default(1),			-- 누적 	   (+)

	-- Constraint
	CONSTRAINT	pk_tRouletteLogTotalMaster_dateid_goldballkind	PRIMARY KEY(dateid, goldballkind)
)
-- select top 100 * from dbo.tRouletteLogTotalMaster order by dateid desc
-- select         * from dbo.tRouletteLogTotalMaster where dateid = '20120818'
-- select top 1   * from dbo.tRouletteLogTotalMaster where dateid = '20120818'
--
--insert into dbo.tRouletteLogTotalMaster(dateid, goldball, silverball, itemcodecnt, cnt) values('20120818', 2, 400, 0, 1)
--update dbo.tRouletteLogTotalMaster
--	set
--		goldball = goldball + 2,
--		silverball = silverball + 400,
--
--		cnt = cnt + 1
-- where dateid = '20120818'
----
-- insert into dbo.tRouletteLogTotalMaster(dateid, goldball, silverball, itemcodecnt, cnt) values('20120819', 2,   0, 1, 1)
-- update dbo.tRouletteLogTotalMaster
--	set
--		goldball = goldball + 2,
--
-- 		itemcodecnt = itemcodecnt + 1,
--		cnt = cnt + 1
-- where dateid = '20120818'


---------------------------------------------
-- 	룰렛 로그 > 통계용
---------------------------------------------
IF OBJECT_ID (N'dbo.tRouletteLogTotalSub', N'U') IS NOT NULL
	DROP TABLE dbo.tRouletteLogTotalSub;
GO

create table dbo.tRouletteLogTotalSub(
	idx				int				identity(1, 1),
	dateid			char(8),							-- 20101210
	goldballkind	int				default(2),

	goldball		int				default(0),
	silverball		int				default(0),
	itemcode		int				default(-1),
	cnt				int				default(1),
	comment			varchar(128),

	-- Constraint
	CONSTRAINT	pk_tRouletteLogTotalSub_dateid_silverball_itemcode PRIMARY KEY(dateid, silverball, itemcode, goldballkind)
)
-- select top 100 * from dbo.tRouletteLogTotalSub order by dateid desc, itemcode desc
-- select         * from dbo.tRouletteLogTotalSub where dateid = '20120818'
-- select top 1   * from dbo.tRouletteLogTotalSub where dateid = '20120818' and itemcode = 1
--
-- insert into dbo.tRouletteLogTotalSub(dateid, goldball, silverball, itemcode, cnt, comment)  values('20120818', 2, 400,  -1, 1, '2 -> 400 실버로 환전')
-- update dbo.tRouletteLogTotalSub
--	set
--		--goldball = goldball + 2,
--		cnt = cnt + 1
-- where dateid = '20120818' and silverball = 400 and itemcode = -1
--
-- insert into dbo.tRouletteLogTotalSub(dateid, goldball, silverball, itemcode, cnt, comment)  values('20120818', 2,   0, 401, 1, '2 -> 스틸배트 환전')
-- update dbo.tRouletteLogTotalSub
--	set
--		--goldball = goldball + 2,
--		cnt = cnt + 1
-- where dateid = '20120818' and silverball = 0 and itemcode = 401



---------------------------------------------
-- 	룰렛 로그 > 개인자료
---------------------------------------------
IF OBJECT_ID (N'dbo.tRouletteLogPerson', N'U') IS NOT NULL
	DROP TABLE dbo.tRouletteLogPerson;
GO

create table dbo.tRouletteLogPerson(
	idx				int				identity(1, 1),

	gameid			varchar(20),
	goldball		int				default(0),
	silverball		int				default(0),
	itemcode		int				default(-1),
	comment			varchar(128),

	writedate		datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tRouletteLogPerson_idx PRIMARY KEY(idx)
)
-- gameid, idx
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tRouletteLogPerson_gameid_idx')
	DROP INDEX tRouletteLogPerson.idx_tRouletteLogPerson_gameid_idx
GO
CREATE INDEX idx_tRouletteLogPerson_gameid_idx ON tRouletteLogPerson (gameid, idx)
GO
-- insert into dbo.tRouletteLogPerson(gameid, goldball, silverball, itemcode, comment)  values('SangSang', 2, 400,  -1, '2 -> 400 실버로 환전')
-- insert into dbo.tRouletteLogPerson(gameid, goldball, silverball, itemcode, comment)  values('SangSang', 2,   0, 401, '2 -> 스틸배트 환전')
-- select top 100 * from dbo.tRouletteLogPerson
-- select top 100 * from dbo.tRouletteLogPerson where gameid = 'SangSang' order by idx desc


---------------------------------------------
--	백업스케쥴러 포인트
--	(덤프 단위로 할경우)
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserMasterSchedule', N'U') IS NOT NULL
	DROP TABLE dbo.tUserMasterSchedule;
GO

create table dbo.tUserMasterSchedule(
	--(가입)
	idx				int					identity(1, 1),
	dateid			varchar(8),										-- 20121118
	idxStart		int					default(0),
	writedate		datetime			default(getdate()), 		-- 작성일

	-- Constraint
	CONSTRAINT pk_tUserMasterSchedule_dateid	PRIMARY KEY(dateid)
)
GO

-- select * from tUserMasterSchedule
-- if(not exist(select dateid from dbo.tUserMasterSchedule where dateid = '20121118'))
-- insert into dbo.tUserMasterSchedule(dateid, idxEnd) values('20121118', 1000)
-- update tUserMasterSchedule
-- 	set
--		idxStart = idx
-- where dateid = '20121118'


---------------------------------------------
--	SMS 로그 기록하기
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserSMSLog', N'U') IS NOT NULL
	DROP TABLE dbo.tUserSMSLog;
GO

create table dbo.tUserSMSLog(
	idx			int					IDENTITY(1,1),

	gameid		varchar(20),
	sendkey		varchar(256),
	recphone	varchar(20),

	senddate	datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tUserSMSLog_idx	PRIMARY KEY(idx)
)

--insert into dbo.tUserSMSLog(gameid, sendkey, recphone) values('superman7', 'xxxxxxxxxxx1', '01011112222')
--insert into dbo.tUserSMSLog(gameid, sendkey, recphone) values('superman7', 'xxxxxxxxxxx2', '01011112222')
-- select top 10 * from dbo.tUserSMSLog
-- select top 1  * from dbo.tUserSMSLog where sendkey = 'xxxxxxxxxxx1'
-- select top 10 * from dbo.tUserSMSLog where gameid = 'superman7'

-- 센드키 충돌검사
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserSMSLog_sendkey')
    DROP INDEX tUserSMSLog.idx_tUserSMSLog_sendkey
GO
CREATE INDEX idx_tUserSMSLog_sendkey ON tUserSMSLog (sendkey)
GO

--유저별 검색용
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserSMSLog_gameid')
    DROP INDEX tUserSMSLog.idx_tUserSMSLog_gameid
GO
CREATE INDEX idx_tUserSMSLog_gameid ON tUserSMSLog (gameid)
GO

-- 폰키 검색
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserSMSLog_recphone')
    DROP INDEX tUserSMSLog.idx_tUserSMSLog_recphone
GO
CREATE INDEX idx_tUserSMSLog_recphone ON tUserSMSLog (recphone)
GO

---------------------------------------------
-- 	SMS 로그 > 통계용
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserSMSLogTotal', N'U') IS NOT NULL
	DROP TABLE dbo.tUserSMSLogTotal;
GO

create table dbo.tUserSMSLogTotal(
	idx				int				identity(1, 1),

	dateid			char(8),							-- 20101210
	cnt				int				default(1),
	cnt2			int				default(0),
	joincnt			int				default(0),

	-- Constraint
	CONSTRAINT	pk_tUserSMSLogTotal_dateid	PRIMARY KEY(dateid)
)
-- select top 100 * from dbo.tUserSMSLogTotal order by dateid desc
-- select top 100 * from dbo.tUserSMSLogTotal where dateid = '20121129' order by dateid desc
--update dbo.tUserSMSLogTotal
--	set
--		cnt = cnt + 1
--where dateid = '20120818'
-- insert into dbo.tUserSMSLogTotal(dateid, cnt) values('20120818', 1)



---------------------------------------------
--	SMS > Reward
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserSMSReward', N'U') IS NOT NULL
	DROP TABLE dbo.tUserSMSReward;
GO

create table dbo.tUserSMSReward(
	idx			int					IDENTITY(1,1),

	recphone	varchar(20),
	gameid		varchar(20),

	rewarddate	datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tUserSMSReward_idx	PRIMARY KEY(idx)
)

-- insert into dbo.tUserSMSReward(recphone, gameid) values('01011112222', 'superman7')
-- select top 1  * from dbo.tUserSMSReward where recphone = '01011112222'

-- 폰키 검색
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserSMSReward_recphone')
    DROP INDEX tUserSMSReward.idx_tUserSMSReward_recphone
GO
CREATE INDEX idx_tUserSMSReward_recphone ON tUserSMSReward (recphone)
GO

--유저별 검색용
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserSMSReward_gameid')
    DROP INDEX tUserSMSReward.idx_tUserSMSReward_gameid
GO
CREATE INDEX idx_tUserSMSReward_gameid ON tUserSMSReward (gameid)
GO


---------------------------------------------
--	일반보상 > 기록하기
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserRewardLog', N'U') IS NOT NULL
	DROP TABLE dbo.tUserRewardLog;
GO

create table dbo.tUserRewardLog(
	idx			int					IDENTITY(1,1),

	gameid		varchar(20),
	serialkey	varchar(256),
	mode		int,

	writedate	datetime			default(getdate()),
	comment		varchar(1024),

	-- Constraint
	CONSTRAINT	pk_tUserRewardLog_idx	PRIMARY KEY(idx)
)

--insert into dbo.tUserRewardLog(gameid, serialkey, mode) values('superman7', 'xxxxxxxxxxx1', 1)
--insert into dbo.tUserRewardLog(gameid, serialkey, mode) values('superman7', 'xxxxxxxxxxx2', 1)
-- select top 10 * from dbo.tUserRewardLog
-- select top 1  * from dbo.tUserRewardLog where serialkey = 'xxxxxxxxxxx1'
-- select top 10 * from dbo.tUserRewardLog where gameid = 'superman7'

-- 씨리얼키 충돌검사
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserRewardLog_serialkey')
    DROP INDEX tUserRewardLog.idx_tUserRewardLog_serialkey
GO
CREATE INDEX idx_tUserRewardLog_serialkey ON tUserRewardLog (serialkey)
GO

--유저별 검색용
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserRewardLog_gameid')
    DROP INDEX tUserRewardLog.idx_tUserRewardLog_gameid
GO
CREATE INDEX idx_tUserRewardLog_gameid ON tUserRewardLog (gameid)
GO

---------------------------------------------
-- 	일반보상 > 통계용
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserRewardLogTotal', N'U') IS NOT NULL
	DROP TABLE dbo.tUserRewardLogTotal;
GO

create table dbo.tUserRewardLogTotal(
	idx				int				identity(1, 1),

	dateid			char(8),							-- 20101210
	mode			int,
	cnt				int				default(1),

	-- Constraint
	CONSTRAINT	pk_tUserRewardLogTotal_dateid_mode	PRIMARY KEY(dateid, mode)
)
-- select top 100 * from dbo.tUserRewardLogTotal order by dateid desc
-- select top 100 * from dbo.tUserRewardLogTotal where dateid = '20121129' order by dateid desc
--update dbo.tUserRewardLogTotal
--	set
--		cnt = cnt + 1
--where dateid = '20120818'
-- insert into dbo.tUserRewardLogTotal(dateid, cnt) values('20130204', 1)



---------------------------------------------
--	Android Push Service
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserPushAndroid', N'U') IS NOT NULL
	DROP TABLE dbo.tUserPushAndroid;
GO

create table dbo.tUserPushAndroid(
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

	-- Constraint
	CONSTRAINT	pk_tUserPushAndroid_idx	PRIMARY KEY(idx)
)


----------------------------------------------------
---- Push입력하기
----------------------------------------------------
---- 내폰
--insert into dbo.tUserPushAndroid(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73801', 'guest73801', 'APA91bF6Y96_WIvc3jQH83B2QoTUkcDcX2KAp6A5AGQfMQ_V4LZOjzKe7Wr-IVgXz-a2XS1A8hUIUZ6-0NmWkfkkQLqUMSYikMGA_P1Ejj42Z4e_VxRth84WJkMuhGjbvWUuwAVUdn90R5wlYe6P2W4hLMsyU8FeWjEXcHzFbRe2Fj8lH4CoOL0', 1, 99, '홈런리그제목', '홈런리그 내용푸쉬로 날려요.', 'LAUNCH')
----insert into dbo.tUserPushAndroid(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73801', 'guest73801', 'APA91bF6Y96_WIvc3jQH83B2QoTUkcDcX2KAp6A5AGQfMQ_V4LZOjzKe7Wr-IVgXz-a2XS1A8hUIUZ6-0NmWkfkkQLqUMSYikMGA_P1Ejj42Z4e_VxRth84WJkMuhGjbvWUuwAVUdn90R5wlYe6P2W4hLMsyU8FeWjEXcHzFbRe2Fj8lH4CoOL0', 1, 99, '홈런리그제목url', '홈런리그 내용푸쉬로 날려요.url', 'http://m.naver.com')
---- 진혁폰
--insert into dbo.tUserPushAndroid(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73799', 'guest73799', 'APA91bE5TtZI1T81gIpHN1o1IZuasNwm0PoaiG2xYDzOJ6AkW2H148vKqUdy7Oh1in0F-OZUo1VxUbwnNt-Jg1blX7c6sJ7wf92vzIsDy9sRBCtJK4GhauekcatxyM7rS_pvEla4A5Tj3GWQEH3JFOZFZSIrK4UDa7FZxUwLiWZpNrceCqaRct4', 1, 99, '홈런리그제목', '홈런리그 내용푸쉬로 날려요.', 'LAUNCH')
----insert into dbo.tUserPushAndroid(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73799', 'guest73799', 'APA91bE5TtZI1T81gIpHN1o1IZuasNwm0PoaiG2xYDzOJ6AkW2H148vKqUdy7Oh1in0F-OZUo1VxUbwnNt-Jg1blX7c6sJ7wf92vzIsDy9sRBCtJK4GhauekcatxyM7rS_pvEla4A5Tj3GWQEH3JFOZFZSIrK4UDa7FZxUwLiWZpNrceCqaRct4', 1, 99, '홈런리그제목url', '홈런리그 내용푸쉬로 날려요.url', 'http://m.naver.com')
--
----------------------------------------------------
---- 푸쉬 읽어오기(데몬처리부분)
----------------------------------------------------
---- select top 100 * from dbo.tUserPushAndroid
---- 백업하기
--DECLARE @tTemp TABLE(
--				sendid			varchar(20),
--				receid			varchar(20),
--				recepushid		varchar(256),
--				sendkind		int,
--
--				msgpush_id		int,
--				msgtitle		varchar(512),
--				msgmsg			varchar(512),
--				msgaction		varchar(512)
--			);
----select * from dbo.tUserPushAndroid
--delete from dbo.tUserPushAndroid
--	OUTPUT DELETED.sendid, DELETED.receid, DELETED.recepushid, DELETED.sendkind, DELETED.msgpush_id, DELETED.msgtitle, DELETED.msgmsg, DELETED.msgaction into @tTemp
--	where idx in (1)
------select * from @tTemp
----
--insert into dbo.tUserPushAndroidLog(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction)
--	(select sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction from @tTemp)
--
----select * from dbo.tUserPushAndroidLog


---------------------------------------------
--	Android Push Service Log
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserPushAndroidLog', N'U') IS NOT NULL
	DROP TABLE dbo.tUserPushAndroidLog;
GO

create table dbo.tUserPushAndroidLog(
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

	-- Constraint
	CONSTRAINT	pk_tUserPushAndroidLog_idx	PRIMARY KEY(idx)
)


---------------------------------------------
-- Android Push > 통계용
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserPushAndroidTotal', N'U') IS NOT NULL
	DROP TABLE dbo.tUserPushAndroidTotal;
GO

create table dbo.tUserPushAndroidTotal(
	idx				int				identity(1, 1),

	dateid			char(8),							-- 20101210
	cnt				int				default(1),

	-- Constraint
	CONSTRAINT	pk_tUserPushAndroidTotal_dateid	PRIMARY KEY(dateid)
)
-- select top 100 * from dbo.tUserPushAndroidTotal order by dateid desc
-- select top 100 * from dbo.tUserPushAndroidTotal where dateid = '20121129' order by dateid desc
--update dbo.tUserPushAndroidTotal
--	set
--		cnt = cnt + 1
--where dateid = '20120818'
-- insert into dbo.tUserPushAndroidTotal(dateid, cnt) values('20120818', 1)

---------------------------------------------
--	iPhone Push Service
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserPushiPhone', N'U') IS NOT NULL
	DROP TABLE dbo.tUserPushiPhone;
GO

create table dbo.tUserPushiPhone(
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

	-- Constraint
	CONSTRAINT	pk_tUserPushiPhone_idx	PRIMARY KEY(idx)
)

---- Push입력하기
--insert into dbo.tUserPushiPhone(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73801', 'guest73801', 'APA91bF6Y96_WIvc3jQH83B2QoTUkcDcX2KAp6A5AGQfMQ_V4LZOjzKe7Wr-IVgXz-a2XS1A8hUIUZ6-0NmWkfkkQLqUMSYikMGA_P1Ejj42Z4e_VxRth84WJkMuhGjbvWUuwAVUdn90R5wlYe6P2W4hLMsyU8FeWjEXcHzFbRe2Fj8lH4CoOL0', 1, 99, '홈런리그제목', '홈런리그 내용푸쉬로 날려요.', 'LAUNCH')
--insert into dbo.tUserPushiPhone(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73801', 'guest73801', 'APA91bF6Y96_WIvc3jQH83B2QoTUkcDcX2KAp6A5AGQfMQ_V4LZOjzKe7Wr-IVgXz-a2XS1A8hUIUZ6-0NmWkfkkQLqUMSYikMGA_P1Ejj42Z4e_VxRth84WJkMuhGjbvWUuwAVUdn90R5wlYe6P2W4hLMsyU8FeWjEXcHzFbRe2Fj8lH4CoOL0', 1, 99, '홈런리그제목url', '홈런리그 내용푸쉬로 날려요.url', 'http://m.naver.com')
--insert into dbo.tUserPushiPhone(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73799', 'guest73799', 'APA91bE5TtZI1T81gIpHN1o1IZuasNwm0PoaiG2xYDzOJ6AkW2H148vKqUdy7Oh1in0F-OZUo1VxUbwnNt-Jg1blX7c6sJ7wf92vzIsDy9sRBCtJK4GhauekcatxyM7rS_pvEla4A5Tj3GWQEH3JFOZFZSIrK4UDa7FZxUwLiWZpNrceCqaRct4', 1, 99, '홈런리그제목', '홈런리그 내용푸쉬로 날려요.', 'LAUNCH')
--insert into dbo.tUserPushiPhone(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73799', 'guest73799', 'APA91bE5TtZI1T81gIpHN1o1IZuasNwm0PoaiG2xYDzOJ6AkW2H148vKqUdy7Oh1in0F-OZUo1VxUbwnNt-Jg1blX7c6sJ7wf92vzIsDy9sRBCtJK4GhauekcatxyM7rS_pvEla4A5Tj3GWQEH3JFOZFZSIrK4UDa7FZxUwLiWZpNrceCqaRct4', 1, 99, '홈런리그제목url', '홈런리그 내용푸쉬로 날려요.url', 'http://m.naver.com')

---------------------------------------------
--	iPhone Push Service Log
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserPushiPhoneLog', N'U') IS NOT NULL
	DROP TABLE dbo.tUserPushiPhoneLog;
GO

create table dbo.tUserPushiPhoneLog(
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

	-- Constraint
	CONSTRAINT	pk_tUserPushiPhoneLog_idx	PRIMARY KEY(idx)
)

---------------------------------------------
--	iPhone Push Service
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserPushiPhone', N'U') IS NOT NULL
	DROP TABLE dbo.tUserPushiPhone;
GO

create table dbo.tUserPushiPhone(
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

	-- Constraint
	CONSTRAINT	pk_tUserPushiPhone_idx	PRIMARY KEY(idx)
)

---- Push입력하기
--insert into dbo.tUserPushiPhone(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73801', 'guest73801', 'APA91bF6Y96_WIvc3jQH83B2QoTUkcDcX2KAp6A5AGQfMQ_V4LZOjzKe7Wr-IVgXz-a2XS1A8hUIUZ6-0NmWkfkkQLqUMSYikMGA_P1Ejj42Z4e_VxRth84WJkMuhGjbvWUuwAVUdn90R5wlYe6P2W4hLMsyU8FeWjEXcHzFbRe2Fj8lH4CoOL0', 1, 99, '홈런리그제목', '홈런리그 내용푸쉬로 날려요.', 'LAUNCH')
--insert into dbo.tUserPushiPhone(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73801', 'guest73801', 'APA91bF6Y96_WIvc3jQH83B2QoTUkcDcX2KAp6A5AGQfMQ_V4LZOjzKe7Wr-IVgXz-a2XS1A8hUIUZ6-0NmWkfkkQLqUMSYikMGA_P1Ejj42Z4e_VxRth84WJkMuhGjbvWUuwAVUdn90R5wlYe6P2W4hLMsyU8FeWjEXcHzFbRe2Fj8lH4CoOL0', 1, 99, '홈런리그제목url', '홈런리그 내용푸쉬로 날려요.url', 'http://m.naver.com')
--insert into dbo.tUserPushiPhone(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73799', 'guest73799', 'APA91bE5TtZI1T81gIpHN1o1IZuasNwm0PoaiG2xYDzOJ6AkW2H148vKqUdy7Oh1in0F-OZUo1VxUbwnNt-Jg1blX7c6sJ7wf92vzIsDy9sRBCtJK4GhauekcatxyM7rS_pvEla4A5Tj3GWQEH3JFOZFZSIrK4UDa7FZxUwLiWZpNrceCqaRct4', 1, 99, '홈런리그제목', '홈런리그 내용푸쉬로 날려요.', 'LAUNCH')
--insert into dbo.tUserPushiPhone(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73799', 'guest73799', 'APA91bE5TtZI1T81gIpHN1o1IZuasNwm0PoaiG2xYDzOJ6AkW2H148vKqUdy7Oh1in0F-OZUo1VxUbwnNt-Jg1blX7c6sJ7wf92vzIsDy9sRBCtJK4GhauekcatxyM7rS_pvEla4A5Tj3GWQEH3JFOZFZSIrK4UDa7FZxUwLiWZpNrceCqaRct4', 1, 99, '홈런리그제목url', '홈런리그 내용푸쉬로 날려요.url', 'http://m.naver.com')

---------------------------------------------
--	iPhone Push Service Log
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserPushiPhoneLog', N'U') IS NOT NULL
	DROP TABLE dbo.tUserPushiPhoneLog;
GO

create table dbo.tUserPushiPhoneLog(
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

	-- Constraint
	CONSTRAINT	pk_tUserPushiPhoneLog_idx	PRIMARY KEY(idx)
)



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



---------------------------------------------
--  더블모드 마스터 테이블
---------------------------------------------
IF OBJECT_ID (N'dbo.tDoubleModeInfo', N'U') IS NOT NULL
	DROP TABLE dbo.tDoubleModeInfo;
GO

create table dbo.tDoubleModeInfo(
	idx					int 				IDENTITY(1, 1),

	doubleitemcode		int					default(7002),
	doublepowerinfo		int					default(50),
	doubledegreeinfo	int					default(50),
	doublepriceinfo		int					default(20),
	doubleperiodinfo	int					default(3),

	flag				int					default(1),			--(1):활성화, (0)비활성화
	comment				varchar(1024),
	writedate			datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tDoubleModeInfo_idx	PRIMARY KEY(idx)
)
-- insert into dbo.tDoubleModeInfo(doubleitemcode, doublepowerinfo, doubledegreeinfo, doublepriceinfo, doubleperiodinfo) values(7002, 50, 50, 20, 3)
-- select top 1 * from dbo.tDoubleModeInfo where flag = 1 order by idx desc

---------------------------------------------
-- 	랭크백업
---------------------------------------------
IF OBJECT_ID (N'dbo.tRankTotal', N'U') IS NOT NULL
	DROP TABLE dbo.tRankTotal;
GO

create table dbo.tRankTotal(
	idx				int				identity(1, 1),

	dateid			char(8),								-- 20101210
	gamemode		int,
	gameid			varchar(20),

	rank			int,

	machinepoint	int				default(0),
	memorialpoint	int				default(0),
	btwin			int				default(0),
	bttotal			int				default(0),
	btlose			int				default(0),

	writedate		datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tRankTotal_dateid_gamemode_gameid	PRIMARY KEY(dateid, gamemode, gameid)
)
-- insert into dbo.tRankTotal(dateid, gamemode, gameid, rank, machinepoint, memorialpoint, btwin, bttotal, btlose) values('20130117', 2, 'kyssmart', 1, 10, 10, 10, 10, 0)
-- insert into dbo.tRankTotal(dateid, gamemode, gameid, rank, machinepoint, memorialpoint, btwin, bttotal, btlose) values('20130117', 2, 'superman2', 2, 9, 10, 10, 10, 0)
-- insert into dbo.tRankTotal(dateid, gamemode, gameid, rank, machinepoint, memorialpoint, btwin, bttotal, btlose) values('20130117', 2, 'superman3', 3, 8, 10, 10, 10, 0)
-- insert into dbo.tRankTotal(dateid, gamemode, gameid, rank, machinepoint, memorialpoint, btwin, bttotal, btlose) values('20130117', 3, 'kyssmart', 1, 10, 10, 10, 10, 0)
-- insert into dbo.tRankTotal(dateid, gamemode, gameid, rank, machinepoint, memorialpoint, btwin, bttotal, btlose) values('20130117', 5, 'kyssmart', 1, 10, 10, 10, 10, 0)
-- select * from dbo.tRankTotal where dateid = '20130117' and gamemode = 2 order by rank asc
-- select * from dbo.tRankTotal where dateid = '20130117' and gamemode = 3 order by rank asc
-- select * from dbo.tRankTotal where dateid = '20130117' and gamemode = 5 order by rank asc

--declare @dateid 	varchar(8) set @dateid = Convert(varchar(8),Getdate(),112)	-- 20120809
--                                    insert into dbo.tRankTotal(rank,  dateid, gamemode, gameid, machinepoint, memorialpoint, btwin, bttotal, btlose)
--select top 10 rank() over(order by machinepoint desc)       as rank, @dateid, 2,        gameid, machinepoint, memorialpoint, btwin, bttotal, bttotal - btwin from dbo.tUserMaster
--                                    insert into dbo.tRankTotal(rank,  dateid, gamemode, gameid, machinepoint, memorialpoint, btwin, bttotal, btlose)
--select top 10 rank() over(order by memorialpoint desc)      as rank, @dateid, 3,        gameid, machinepoint, memorialpoint, btwin, bttotal, bttotal - btwin from dbo.tUserMaster
--                                    insert into dbo.tRankTotal(rank,  dateid, gamemode, gameid, machinepoint, memorialpoint, btwin, bttotal, btlose)
--select top 10 rank() over(order by btwin desc, bttotal asc) as rank, @dateid, 5,        gameid, machinepoint, memorialpoint, btwin, bttotal, bttotal - btwin from dbo.tUserMaster


---------------------------------------------
--  강화비용 > 서버조절
---------------------------------------------
IF OBJECT_ID (N'dbo.tItemUpgradeInfo', N'U') IS NOT NULL
	DROP TABLE dbo.tItemUpgradeInfo;
GO

create table dbo.tItemUpgradeInfo(
	idx						int 				IDENTITY(1, 1),

	petitemupgradebase		int					default(50),
	petitemupgradestep		int					default(30),
	normalitemupgradebase	int					default(50),
	normalitemupgradestep	int					default(10),
	permanentstep			int					default(20),

	flag				int					default(1),			--(1):활성화, (0)비활성화
	comment				varchar(1024),
	writedate			datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tItemUpgradeInfo_idx	PRIMARY KEY(idx)
)
-- insert into dbo.tItemUpgradeInfo(petitemupgradebase, petitemupgradestep, normalitemupgradebase, normalitemupgradestep, comment) values(50, 30, 50, 10, '내용')
-- select top 1 * from dbo.tItemUpgradeInfo where flag = 1 order by idx desc
--	public const int ITEM_UPGRADE_BASE_PRICE 		= 50;
--	public const int ITEM_UPGRADE_NORMAL_STEP 		= 10;
--	public const int ITEM_UPGRADE_NORMAL_INTERVAl	= 5;
--	public const int ITEM_UPGRADE_PET_STEP 			= 30;

---------------------------------------------
-- 일반 세팅값들
---------------------------------------------
IF OBJECT_ID (N'dbo.tHomeleague', N'U') IS NOT NULL
	DROP TABLE dbo.tHomeleague;
GO

create table dbo.tHomeleague(
	idx						int 				IDENTITY(1, 1),

	-- 역전부스터
	reversalitemcode		int					default(7020),
	reversalprice			int					default(5),

	comment				varchar(1024),
	writedate			datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tHomeleague_idx	PRIMARY KEY(idx)
)
-- insert into dbo.tHomeleague(reversalitemcode, reversalprice, comment) values(7020, 10, '내용')




---------------------------------------------
--  역전배틀/미션 세팅값들
---------------------------------------------
IF OBJECT_ID (N'dbo.tRevModeInfo', N'U') IS NOT NULL
	DROP TABLE dbo.tRevModeInfo;
GO

create table dbo.tRevModeInfo(
	idx					int 				IDENTITY(1, 1),

	btrevitemcode		int					default(7020),
	btrevprice			int					default(5),
	msrevitemcode4		int					default(7021),
	msrevprice4			int					default(5),
	msrevitemcode7		int					default(7022),
	msrevprice7			int					default(7),
	msrevitemcode8		int					default(7023),
	msrevprice8			int					default(20),
	msrevitemcode9		int					default(7024),
	msrevprice9			int					default(50),

	flag				int					default(1),			--(1):활성화, (0)비활성화
	comment				varchar(1024),
	writedate			datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tRevModeInfo_idx	PRIMARY KEY(idx)
)
-- insert into dbo.tRevModeInfo(btrevitemcode, btrevprice, msrevitemcode4, msrevprice4, msrevitemcode7, msrevprice7, msrevitemcode8, msrevprice8, msrevitemcode9, msrevprice9, comment) values(7020, 5, 7021, 5, 7022, 7, 7023, 20, 7024, 50, '내용')
-- select top 1 * from dbo.tRevModeInfo where flag = 1 order by idx desc

---------------------------------------------
--  스테미너 세팅값들
---------------------------------------------
IF OBJECT_ID (N'dbo.tActionInfo', N'U') IS NOT NULL
	DROP TABLE dbo.tActionInfo;
GO

create table dbo.tActionInfo(
	idx					int 				IDENTITY(1, 1),

	halfmodeprice			int				default(6),
	fullmodeprice			int				default(10),
	freemodeprice			int				default(50),
	freemodeperiod			int				default(1),

	plusgoldball			int				default(0),			-- 골든볼 추가지급
	plussilverball			int				default(0),			-- 실버볼 추가지급

	flag					int				default(1),			--(1):활성화, (0)비활성화
	comment					varchar(1024),
	writedate				datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tActionInfo_idx	PRIMARY KEY(idx)
)
-- insert into dbo.tActionInfo(halfmodeprice, fullmodeprice, freemodeprice, freemodeperiod, comment) values(6, 10, 50, 1, '내용')
-- insert into dbo.tActionInfo(halfmodeprice, fullmodeprice, freemodeprice, freemodeperiod, comment) values(4, 7, 20, 5, '내용')
-- select * from dbo.tActionInfo where flag = 1 order by idx desc
-- select top 1 * from dbo.tActionInfo where flag = 1 order by idx desc
--halfmodeprice=4GB
--fullmodeprice=7GB
--freemodeprice=20GB
--freemodeperiod=5

---------------------------------------------
--	로그인 현황, 플레이 현황
---------------------------------------------
IF OBJECT_ID (N'dbo.tStaticTime', N'U') IS NOT NULL
	DROP TABLE dbo.tStaticTime;
GO

create table dbo.tStaticTime(
	idx					int 				IDENTITY(1, 1),

	dateid10			varchar(10),
	market				int					default(1),				-- (구매처코드) MARKET_SKT

	logincnt			int					default(0),
	playcnt				int					default(0),


	-- Constraint
	CONSTRAINT	pk_tStaticTime_dateid10_market	PRIMARY KEY(dateid10, market)
)



---------------------------------------------
--	유니크 가입현황파악하기
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserPhone', N'U') IS NOT NULL
	DROP TABLE dbo.tUserPhone;
GO

create table dbo.tUserPhone(
	idx					int 				IDENTITY(1, 1),

	phone				varchar(20),
	market				int					default(1),
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


---------------------------------------------
--	스테미너 스케쥴 > 대기자 정보
---------------------------------------------
IF OBJECT_ID (N'dbo.tActionScheduleData', N'U') IS NOT NULL
	DROP TABLE dbo.tActionScheduleData;
GO

create table dbo.tActionScheduleData(
	idx					int 				IDENTITY(1, 1),

	gameid				varchar(20),

	writedate			datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tActionScheduleData_idx	PRIMARY KEY(idx)
)
-- 폰인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tActionScheduleData_gameid')
    DROP INDEX tActionScheduleData.idx_tActionScheduleData_gameid
GO
CREATE INDEX idx_tActionScheduleData_gameid ON tActionScheduleData (gameid)
GO


---------------------------------------------
--	스테미너 스케쥴 > 통계용
---------------------------------------------
IF OBJECT_ID (N'dbo.tActionScheduleStatic', N'U') IS NOT NULL
	DROP TABLE dbo.tActionScheduleStatic;
GO

create table dbo.tActionScheduleStatic(
	idx					int 				IDENTITY(1, 1),

	dateid10			varchar(10),

	cnt					int					default(0),
	cnt2				int					default(0),
	writedate			datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tActionScheduleStatic_dateid10	PRIMARY KEY(dateid10)
)



---------------------------------------------
--  배틀로그 어뷰징 로그 백업
---------------------------------------------
IF OBJECT_ID (N'dbo.tBattleLogBlock', N'U') IS NOT NULL
	DROP TABLE dbo.tBattleLogBlock;
GO

create table dbo.tBattleLogBlock(
	idxOrder	bigint, 									-- 그냥인덱스
	idx			bigint,										-- 인덱스 > 랜덤생성
	gameid		varchar(20), 								-- 아이디
	grade		int,							 			-- 계급
	gradestar	int,
	lv			int,							 			-- 레벨

	btidx		bigint					default(-1),		-- 상대배틀인덱스
	btgameid	varchar(20), 								-- 배틀상대방
	btlog		varchar(1024), 								-- 플레이로그데이타 (회, power, 좌우각, 비각, 히트)
	btitem		varchar(16),			 					-- 배틀템 세팅정보
	btiteminfo	varchar(128), 								-- 아이템정보 (머리, 상의, 하의, 날개, 꼬리, 안경, 팻, 배트)
	bttotal		int,
	btwin		int,										-- 플래이 당시의 승수
	btresult	int, 										-- 승/패		1 : win	0 : lose
	bthit		int, 										-- 총거리
	writedate	datetime			default(getdate()), 	-- 플레이날짜
	btTotalPower int				default(0),				-- 토탈파워
	btTotalCount int				default(0),				-- 토탈히트수
	btAvg		int					default(0),				-- = btTotalPower / btTotalCount
	btsb		int					default(0),				-- 배틀에서 획득한 실버
	btmode		int					default(0),
	winstreak	int					default(0),
	winstreak2	int					default(0),

	btcomment	varchar(256),

)

-- select gameid, btAvg, btlog, * from tBattleLog where btAvg > 4500 order by 1 desc, 2 desc
-- select * from dbo.tBattleLog where btAvg > 4500 and gameid in ('whaql2', 'spdlqj34', 'nhkims', 'hello20boy', 'hello18boy', 'hello17boy', 'hello16boy', 'guest24419', 'guest22440', 'apisbio') order by gameid desc, btAvg desc
-- insert into tBattleLogBlock select * from dbo.tBattleLog where btAvg > 4500 and gameid in ('whaql2', 'spdlqj34', 'nhkims', 'hello20boy', 'hello18boy', 'hello17boy', 'hello16boy', 'guest24419', 'guest22440', 'apisbio')
-- select * from dbo.tBattleLogBlock
-- delete from dbo.tBattleLog where btAvg > 4500 and gameid in ('whaql2', 'spdlqj34', 'nhkims', 'hello20boy', 'hello18boy', 'hello17boy', 'hello16boy', 'guest24419', 'guest22440', 'apisbio') order by gameid desc, btAvg desc


---------------------------------------------
--  로그인 이벤트
---------------------------------------------
IF OBJECT_ID (N'dbo.tEventMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tEventMaster;
GO

create table dbo.tEventMaster(
	idx			int 				IDENTITY(1, 1),

	gameid		varchar(20),
	dateid		varchar(8),
	eventcode	int,
	comment		varchar(128),

	writedate	datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tEventMaster_idx	PRIMARY KEY(idx)
)
-- gameid, grade
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tEventMaster_gameid_dateid_eventcode')
    DROP INDEX tEventMaster.idx_tEventMaster_gameid_dateid_eventcode
GO
CREATE INDEX idx_tEventMaster_gameid_dateid_eventcode ON tEventMaster(gameid, dateid, eventcode)
GO

-- select * from dbo.tEventMaster where gameid = 'superman' and dateid = '20130213' and eventcode = 1
-- insert into dbo.tEventMaster(gameid, dateid, eventcode, comment) values('Superman', '20130213', 1, '발렌타인데이 이벤트')
-- declare @dateid 	varchar(8) set @dateid = Convert(varchar(8),Getdate(),112)	-- 20120809


---------------------------------------------
--  로그인 > 유료가입자(1회가입만)
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserPay', N'U') IS NOT NULL
	DROP TABLE dbo.tUserPay;
GO

create table dbo.tUserPay(
	idx			int 				IDENTITY(1, 1),

	phone		varchar(20),
	market		int,

	writedate	datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tUserPay_idx	PRIMARY KEY(idx)
)
-- phone, market
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserPay_phone_market')
    DROP INDEX tUserPay.idx_tUserPay_phone_market
GO
CREATE INDEX idx_tUserPay_phone_market ON tUserPay(phone, market)
GO

-- select * from dbo.tUserPay where phone = '01022223333' and market = 1
-- insert into dbo.tUserPay(phone, market) values('01022223333', 1)
-- select * from dbo.tUserPay where phone = '01022223333'
-- delete from dbo.tUserPay where idx = 1

---------------------------------------------
--  가입 > 1회만 지급
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserPayEvent', N'U') IS NOT NULL
	DROP TABLE dbo.tUserPayEvent;
GO

create table dbo.tUserPayEvent(
	idx			int 				IDENTITY(1, 1),

	phone		varchar(20),
	market		int,

	writedate	datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tUserPayEvent_idx	PRIMARY KEY(idx)
)
-- phone, market
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserPayEvent_phone_market')
    DROP INDEX tUserPayEventEvent.idx_tUserPayEvent_phone_market
GO
CREATE INDEX idx_tUserPayEvent_phone_market ON tUserPayEvent(phone, market)
GO

-- select * from dbo.tUserPayEvent where phone = '01022223333' and market = 3
-- insert into dbo.tUserPayEvent(phone, market) values('01022223333', 3)
-- select * from dbo.tUserPayEvent where phone = '01022223333'
-- delete from dbo.tUserPayEvent where idx = 1



---------------------------------------------
-- TotoMaster 마스터
---------------------------------------------
IF OBJECT_ID (N'dbo.tTotoMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tTotoMaster;
GO

create table dbo.tTotoMaster(
	idx			int				identity(1, 1),

	totoid		int,
	totodate	varchar(16),
	totoday		int,

	title		varchar(128),
	acountry	int,
	bcountry	int,
	apoint		int					default(-1),		-- 각국가에서 획득한 점수
	bpoint		int					default(-1),
	writedate	datetime			default(getdate()),

	active		int					default(-1),
	victcountry	int					default(-1),		-- 획득한 점수를 바탕으로 승리국 결정
	victpoint	int					default(-1),

	chalmode1cnt	int				default(0),
	chalmode2cnt	int				default(0),
	chalmode1sb		int				default(0),
	chalmode2sb		int				default(0),
	chalmode1give	int				default(-1),
	chalmode2give	int				default(-1),
	chalmode1wincnt	int				default(0),
	chalmode2wincnt	int				default(0),
	chalmode1winsb	int				default(0),
	chalmode2winsb	int				default(0),

	givedate	datetime,

	-- Constraint
	CONSTRAINT	pk_tTotoMaster_idx	PRIMARY KEY(idx)
)
--
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tTotoMaster_totodate')
    DROP INDEX tTotoMaster.idx_tTotoMaster_totodate
GO
CREATE INDEX idx_tTotoMaster_totodate ON tTotoMaster (totodate)
GO

-- ToToid로 검색
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tTotoMaster_totoid')
    DROP INDEX tTotoMaster.idx_tTotoMaster_totoid
GO
CREATE INDEX idx_tTotoMaster_totoid ON tTotoMaster (totoid)
GO

-- select top 100 * from dbo.tTotoMaster order by totodate asc
-- insert into dbo.tTotoMaster(totoid, totodate, totoday, title, acountry, bcountry) values(1, '2013-02-25 13:30', 1, 'B조 호주 : 대만', 2, 3)
-- insert into dbo.tTotoMaster(totoid, totodate, totoday, title, acountry, bcountry) values(2, '2013-02-25 19:00', 2, 'A조 일본 : 브라질', 2, 3)
-- insert into dbo.tTotoMaster(totoid, totodate, totoday, title, acountry, bcountry) values(3, '2013-02-25 20:30', 3, 'B조 대한민국 : 네덜란드', 2, 3)
-- update dbo.tTotoMaster
--	set
--		totodate 	= '2013-02-25 16:00',
--		totoday 	= 1,
--		title		= 'B조 대한민국 : 네덜란드',
--		acountry	= 2,
--		bcountry	= 3,
--		apoint		= 1,
--		bpoint		= 0,
--
--		active		= 1,
--		victcountry	= 2,
--		victpoint	= 1,		-- 1 -> 1 ~ 3
--	where totoid = 1
-- update dbo.tTotoMaster set active = -1 where totoid = 1
-- 지급

---------------------------------------------
-- Toto 유저 지원
---------------------------------------------
IF OBJECT_ID (N'dbo.tTotoUser', N'U') IS NOT NULL
	DROP TABLE dbo.tTotoUser;
GO

create table dbo.tTotoUser(
	idx				int				identity(1, 1),

	gameid		varchar(20),
	totoid		int,

	chalmode	int					default(1),
	chalbat		int					default(2),
	chalsb		int					default(500),
	chalcountry	int					default(-1),
	chalpoint	int					default(-1),
	writedate	datetime			default(getdate()),

	chalresult1	int					default(-1),
	chalresult2	int					default(-1),
	chalstate	int					default(-1),

	givedate	datetime,

	-- Constraint
	CONSTRAINT	pk_tTotoUser_idx	PRIMARY KEY(idx)
)
--
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tTotoUser_gameid_totoid')
    DROP INDEX tTotoUser.idx_tTotoUser_gameid_totoid
GO
CREATE INDEX idx_tTotoUser_gameid_totoid ON tTotoUser (gameid, totoid)
GO

-- select top 100 * from dbo.tTotoUser order by idx desc
-- select * from dbo.tTotoUser where gameid = 'superman' order by idx desc
-- select top 100 * from dbo.tTotoUser where totoid = 1 order by idx desc
-- insert into dbo.tTotoUser(gameid, totoid, chalmode, chalbat, chalsb, chalcountry, chalpoint) values('superman',  1,    1,        2,       500,    12,          -1)
-- insert into dbo.tTotoUser(gameid, totoid, chalmode, chalbat, chalsb, chalcountry, chalpoint) values('superman2', 1,    2,        4,       500,    12,           1)
-- insert into dbo.tTotoUser(gameid, totoid, chalmode, chalbat, chalsb, chalcountry, chalpoint) values('superman3', 1,    1,        2,       500,    13,          -1)
-- insert into dbo.tTotoUser(gameid, totoid, chalmode, chalbat, chalsb, chalcountry, chalpoint) values('superman5', 1,    2,        4,       500,    13,          10)
-- insert into dbo.tTotoUser(gameid, totoid, chalmode, chalbat, chalsb, chalcountry, chalpoint) values('superman',  2,    2,        4,       500,    2,           1)
-- insert into dbo.tTotoUser(gameid, totoid, chalmode, chalbat, chalsb, chalcountry, chalpoint) values('superman',  3,    2,        4,       500,    2,           1)
-- insert into dbo.tTotoUser(gameid, totoid, chalmode, chalbat, chalsb, chalcountry, chalpoint) values('superman',  4,    2,        4,       500,    2,           1)
--select gameid, silverball from dbo.tUserMaster where gameid in ('superman', 'superman2', 'superman3', 'superman5')
--select top 2 * from dbo.tMessage where gameid = 'superman' order by idx desc
--select top 2 * from dbo.tMessage where gameid = 'superman2' order by idx desc
--select top 2 * from dbo.tMessage where gameid = 'superman3' order by idx desc
--select top 2 * from dbo.tMessage where gameid = 'superman5' order by idx desc
-- delete from dbo.tTotoUser where idx = 1		-- 개발자 개발을 위한 삭제
-- 지급
-- select * from dbo.tTotoUser where totoid = 1 > Cursor
-- update dbo.tTotoUser set chalresult1 = 1, chalstate = 2, givedate = getdate() where idx = 1
-- update dbo.tTotoUser set chalresult2 = 2, chalstate = 2, givedate = getdate() where idx = 1


---------------------------------------------
-- 이벤트 인증키값
---------------------------------------------
IF OBJECT_ID (N'dbo.tEventCertNo', N'U') IS NOT NULL
	DROP TABLE dbo.tEventCertNo;
GO


create table dbo.tEventCertNo(
	idx			int				identity(1, 1),
	certno		varchar(16),

	certused	int				default(0),
	gameid		varchar(20),
	usedtime	datetime,

	CONSTRAINT	pk_tEventCertNo_idx	PRIMARY KEY(idx)
)

-- 인증번호 인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tEventCertNo_certno')
    DROP INDEX tEventCertNo.idx_tEventCertNo_certno
GO
CREATE INDEX idx_tEventCertNo_certno ON tEventCertNo (certno)
GO
-- select *, certno from dbo.tEventCertNo

---------------------------------------------
-- 이벤트 유저테이블
---------------------------------------------
IF OBJECT_ID (N'dbo.tEventCertUser', N'U') IS NOT NULL
	DROP TABLE dbo.tEventCertUser;
GO

create table dbo.tEventCertUser(
	idx			int				identity(1, 1),

	gameid		varchar(20),
	usedtime	datetime		default(getdate()),

	CONSTRAINT	pk_tEventCertUser_idx	PRIMARY KEY(idx)
)

-- 인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tEventCertUser_gameid')
    DROP INDEX tEventCertUser.idx_tEventCertUser_gameid
GO
CREATE INDEX idx_tEventCertUser_gameid ON tEventCertUser (gameid)
GO
-- select * from dbo.tEventCertUser where gameid = 'xxxx'


-----------------------------------------------
---- 이벤트 인증키 생성방식
-----------------------------------------------
--declare @noloop 	int
--declare @nomax 		int
--declare @newid		uniqueidentifier
--declare @newid2		varchar(256)
--declare @certno		varchar(16)
--
--set @noloop 	= 1
--set @nomax 		= 2
--
--while(@noloop < @nomax)
--	begin
--		-- 인증번호 생성 > [-] 제거 > 16자리로(알아서 짤리네 ㅎㅎㅎ)
--		SET @newid = NEWID()
--		set @newid2 = replace(@newid, '-', '')
--		SET @certno = @newid2
--		--select @newid, @newid2, @certno
--		--80D9B780-5F99-4AE9-A59C-08301077285F	80D9B7805F994AE9A59C08301077285F	80D9B7805F994AE9
--
--		-- 인증번호 중복인가?
--		if(not exists(select top 1 * from dbo.tEventCertNo where certno = @certno))
--			begin
--				insert into dbo.tEventCertNo(certno) values(@certno)
--			end
--		else
--			begin
--				select '중복:' + @certno
--			end
--
--		set @noloop = @noloop + 1
--	end

---------------------------------------------
-- 	토탈 기록하기
---------------------------------------------
IF OBJECT_ID (N'dbo.tEventCertNoLogTotal', N'U') IS NOT NULL
	DROP TABLE dbo.tEventCertNoLogTotal;
GO

create table dbo.tEventCertNoLogTotal(
	idx				int				identity(1, 1),

	dateid			char(8),							-- 20101210
	cnt				int				default(1),

	-- Constraint
	CONSTRAINT	pk_tEventCertNoLogTotal_dateid	PRIMARY KEY(dateid)
)
-- select top 100 * from dbo.tEventCertNoLogTotal order by dateid desc
-- select top 100 * from dbo.tEventCertNoLogTotal where dateid = '20121129' order by dateid desc
--update dbo.tEventCertNoLogTotal
--	set
--		cnt = cnt + 1
--where dateid = '20120818'
-- insert into dbo.tEventCertNoLogTotal(dateid, cnt) values('20120818', 1)


---------------------------------------------
-- 	추천SMS등록
---------------------------------------------
IF OBJECT_ID (N'dbo.tSMSRecommend', N'U') IS NOT NULL
	DROP TABLE dbo.tSMSRecommend;
GO

create table dbo.tSMSRecommend(
	idx				int				identity(1, 1),
	comment			varchar(512),
	url				varchar(512),
	writedate		datetime		default(getdate()),
	gamekind		int				default(1),

	-- Constraint
	CONSTRAINT	pk_tSMSRecommend_idx	PRIMARY KEY(idx)
)
-- alter table dbo.tSMSRecommend add gamekind			int				default(1)
-- update dbo.tSMSRecommend set gamekind = 1 where gamekind is null
-- select top 1 * from dbo.tSMSRecommend order by idx desc


---------------------------------------------
--  구글 > 연속 과금유저 블럭처리
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserGoogleBuyLog', N'U') IS NOT NULL
	DROP TABLE dbo.tUserGoogleBuyLog;
GO
create table dbo.tUserGoogleBuyLog(
	idx			int 					IDENTITY(1, 1),

	gameid		varchar(20),
	buydate		datetime				default(getdate()),
	buypoint	int						default(0),

	-- Constraint
	CONSTRAINT pk_tUserGoogleBuyLog_gameid	PRIMARY KEY(gameid)
)


---------------------------------------------
-- 	유저 push > 복수전 테이블
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserRevenge', N'U') IS NOT NULL
	DROP TABLE dbo.tUserRevenge;
GO

create table dbo.tUserRevenge(
	idx				int				identity(1, 1),

	gameid			varchar(20),								-- 받는 유저
	btpflag			int					default(1),				-- 배틀Push로그	> flag:0 대전함, flag:1 > 대전안함
	btpgameid 		varchar(20),								-- 상대의 아이디
	btpgrade 		int,										-- 계급
	btptime			datetime			default(getdate()),		-- 배틀시간
	btpgmode		int					default(5),				-- 배틀모드

	-- Constraint
	CONSTRAINT	pk_tUserRevenge_idx	PRIMARY KEY(idx)
)

-- gameid, idx
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserRevenge_gameid_btptime')
    DROP INDEX tUserRevenge.idx_tUserRevenge_gameid_btptime
GO
CREATE INDEX idx_tUserRevenge_gameid_btptime ON tUserRevenge (gameid, btptime)
GO
-- insert into dbo.tUserRevenge(gameid, btpgameid, btpgrade, btpgmode) values('superman', 'superman2', 40, 5)
-- select top 1 * from dbo.tUserRevenge where gameid = 'superman' and btptime >= getdate() - 0.1 and btpflag = 1 order by idx desc
-- update dbo.tUserRevenge set btpflag = 0 where idx = 1
-- select * from dbo.tUserRevenge order by idx desc