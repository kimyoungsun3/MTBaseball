/*
select * from dbo.tFVUserBlockLog


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
*/



/*
alter table dbo.tUserMaster add 		savebktime	datetime				default(getdate() - 1)
update dbo.tUserMaster set savebktime = getdate() - 1


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

-- select * from dbo.tFVUserDataBackup
*/


/*
declare @idx2 int set @idx2 = 1
select @idx2 = isnull(max(idx2), 0) + 1 from dbo.tFVUserDataBackup where gameid = 'xxxx@gmail.com'
select @idx2 idx2

--select getdate(), getdate() - 0.5
--declare @savebktime				datetime
--set @savebktime 		= getdate() - 0
--set @savebktime 		= getdate() - 0.4
--set @savebktime 		= getdate() - 0.6
--set @savebktime 		= getdate() - 1
--if(@savebktime < (getdate() - 0.5))
--	begin
--		select '기록'
--	end
--else
--	begin
--		select '패스'
--	end
*/

--alter table Farm.dbo.tFVUserRankSub
--drop constraint pk_tFVUserRankSub_dateid8_rank


-- PRIMARY KEY 제약 조건 'pk_tFVUserRankSub_dateid8_rank'을(를) 위반했습니다.
-- 개체 'dbo.tFVUserRankSub'에 중복 키를 삽입할 수 없습니다. 중복 키 값은 (20150413, 929)입니다.

--select * from dbo.tFVUserRankSub where dateid8 = '20150411'
--select top 10000 * from dbo.tFVGiftList where giftid like '랭킹%' order by idx desc
--select * from dbo.tFVUserData where gameid in ('PC14DAE9EC6A77', '109661327975685722362', 'PCBC5FF49472EB',  '100955363252672354839',  '106402766319809380603',  '108896905679422200740',  '116044404070388979634')



/*
select kakaomsginvitecnt, kakaomsginvitecntbg, kakaomsginvitetodaycnt, kakaomsginvitetodaydate  from dbo.tUserMaster

alter table dbo.tUserMaster add 		kakaomsginvitecnt		int			default(0)
alter table dbo.tUserMaster add 		kakaomsginvitecntbg		int			default(0)
alter table dbo.tUserMaster add 		kakaomsginvitetodaycnt	int			default(0)
alter table dbo.tUserMaster add 		kakaomsginvitetodaydate	datetime	default(getdate())
update dbo.tUserMaster set kakaomsginvitecnt = 0, kakaomsginvitecntbg = 0, kakaomsginvitetodaycnt = 0, kakaomsginvitetodaydate = getdate()


select invitekakao  from dbo.tFVDayLogInfoStatic

alter table dbo.tFVDayLogInfoStatic add 		invitekakao		int				default(0)
update dbo.tFVDayLogInfoStatic set invitekakao = 0



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
*/


/*
alter table dbo.tFVNotice add 	comfile7		varchar(512)	default('')
alter table dbo.tFVNotice add 	comurl7			varchar(512)	default('')
alter table dbo.tFVNotice add 	comfile8		varchar(512)	default('')
alter table dbo.tFVNotice add 	comurl8			varchar(512)	default('')
alter table dbo.tFVNotice add 	comfile9		varchar(512)	default('')
alter table dbo.tFVNotice add 	comurl9			varchar(512)	default('')
update dbo.tFVNotice set comfile7 = '', comurl7 = '', comfile8 = '', comurl8 = '', comfile9 = '', comurl9 = ''
*/


/*
select * from dbo.tFVUserUnusualLog2


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
-- values     (         5,        1, '2013-09-01', '2023-09-01',    80000,    80001,    80006,        3015,        3015,        3015,  '콩나물 화분D', '오래된 라디오D', '콩나물 화분A',            1,             12,            18,            23, '최초내용')
-- update dbo.tFVSystemRouletteMan set roulflag = -1 where idx = 3

--insert into dbo.tFVSystemRouletteMan(roulmarket,      roulflag,    roulstart,      roulend, roulani1, roulani2, roulani3, roulreward1, roulreward2, roulreward3,       roulname1,       roulname2,       roulname3, roultimeflag, roultimetime1, roultimetime2, roultimetime3, comment)
--values                              (         1,             1, '2013-09-01', '2023-09-01',    80000,    80001,    80006,        3015,        3015,        3015,  '콩나물 화분D', '오래된 라디오D', '콩나물 화분A',            1,            12,            18,            23, '최초내용')
--insert into dbo.tFVSystemRouletteMan(roulmarket,      roulflag,    roulstart,      roulend, roulani1, roulani2, roulani3, roulreward1, roulreward2, roulreward3,       roulname1,       roulname2,       roulname3, roultimeflag, roultimetime1, roultimetime2, roultimetime3, comment)
--values                              (         5,             1, '2013-09-01', '2023-09-01',    80000,    80001,    80006,        3015,        3015,        3015,  '콩나물 화분D', '오래된 라디오D', '콩나물 화분A',            1,             12,            18,            23, '최초내용')
--insert into dbo.tFVSystemRouletteMan(roulmarket,      roulflag,    roulstart,      roulend, roulani1, roulani2, roulani3, roulreward1, roulreward2, roulreward3,       roulname1,       roulname2,       roulname3, roultimeflag, roultimetime1, roultimetime2, roultimetime3, comment)
--values                              (         3,             1, '2013-09-01', '2023-09-01',    80000,    80001,    80006,        3015,        3015,        3015,  '콩나물 화분D', '오래된 라디오D', '콩나물 화분A',            1,             12,            18,            23, '최초내용')
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



alter table dbo.tUserMaster add 	roulettegoldcnt	int					default(0)
alter table dbo.tUserMaster add 	wheelgauage	int						default(0)
alter table dbo.tUserMaster add 	wheelfree	int						default(0)
update dbo.tUserMaster set roulettegoldcnt = 0, wheelgauage = 0, wheelfree = 0



alter table dbo.tUserMaster add 	tsgrade1cnt		int					default(0)
alter table dbo.tUserMaster add 	tsgrade2cnt		int					default(0)
alter table dbo.tUserMaster add 	tsgrade3cnt		int					default(0)
alter table dbo.tUserMaster add 	tsgrade4cnt		int					default(0)
alter table dbo.tUserMaster add 	tsgrade2gauage	int					default(0)
alter table dbo.tUserMaster add 	tsgrade3gauage	int					default(0)
alter table dbo.tUserMaster add 	tsgrade4gauage	int					default(0)
alter table dbo.tUserMaster add 	tsgrade2free	int					default(0)
alter table dbo.tUserMaster add 	tsgrade3free	int					default(0)
alter table dbo.tUserMaster add 	tsgrade4free	int					default(0)
alter table dbo.tUserMaster add 	adidx		int						default(0)
update dbo.tUserMaster set tsgrade1cnt = 0, tsgrade2cnt = 0, 		tsgrade3cnt = 0, 	tsgrade4cnt = 0,
											  tsgrade2gauage = 0, 	tsgrade3gauage = 0, tsgrade4gauage = 0,
											  tsgrade2free = 0, 	tsgrade3free = 0, 	tsgrade4free = 0,
											  adidx = 0


alter table dbo.tFVDayLogInfoStatic add	roulettefreecnt	int				default(0)
alter table dbo.tFVDayLogInfoStatic add	roulettegoldcnt	int				default(0)
update dbo.tFVDayLogInfoStatic set roulettefreecnt = 0, roulettegoldcnt = 0
*/






/*
alter table dbo.tUserMaster add 	eventspot10		int					default(0)
update dbo.tUserMaster set eventspot10 = 0
*/


/*

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '3016', '30', '30', '30', '블루베리유', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '우유결정')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '3017', '30', '30', '30', '연질치즈', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '우유결정')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '3018', '30', '30', '30', '맑은우유', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '우유결정')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '3019', '30', '30', '30', '고급모짜렐라', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '우유결정')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '3020', '30', '30', '30', '고급카푸치노', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '우유결정')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '3021', '30', '30', '30', '고급에멘탈', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '우유결정')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '3022', '30', '30', '30', 'DHA고르곤졸라', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '우유결정')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '3023', '30', '30', '30', '신선초유', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '우유결정')
GO
*/


/*
-- 하트
insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_coin', '3300', '33', '33', '33', '하트', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '하트')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_coin', '3301', '33', '33', '33', '하트조각', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '하트조각')
GO
*/
/*

alter table dbo.tUserMaster add 	ownercashcost	bigint				default(0)
update dbo.tUserMaster set ownercashcost = 0
*/




/*
alter table dbo.tFVNotice add comfile6		varchar(512)	default('')
alter table dbo.tFVNotice add comurl6			varchar(512)	default('')
update dbo.tFVNotice set comfile6 = '', comurl6 = ''
*/


--update dbo.tUserMaster set bestani = 500, salemoney2 = 0  where gameid = 'xxxx@gmail.com'
--update dbo.tUserMaster set bestani = 524, salemoney2 = 9123456978987  where gameid = 'xxxx@gmail.com'



/*
alter table dbo.tFVDayLogInfoStatic add roulettepaycnt	int				default(0)
update dbo.tFVDayLogInfoStatic set roulettepaycnt = 0
*/

/*
alter table dbo.tUserMaster add roulettefreecnt	int					default(0)
alter table dbo.tUserMaster add roulettepaycnt	int					default(0)
update dbo.tUserMaster set roulettefreecnt = 0, roulettepaycnt = 0

update dbo.tUserMaster set roulette  = 1, roulettefreecnt = 0, roulettepaycnt = 0 where gameid = 'xxxx@gmail.com'
select roulette, roulettefreecnt, roulettepaycnt from dbo.tUserMaster where gameid = 'xxxx@gmail.com'
exec spu_FVSave3 'xxxx@gmail.com',  '01022223331', 1, 5, '  0:123;   1:500;        10:1000;    11:2000;        ', 'google22savetest',  -1		-- 누적방식
select roulette, roulettefreecnt, roulettepaycnt from dbo.tUserMaster where gameid = 'xxxx@gmail.com'
exec spu_FVSave3 'xxxx@gmail.com',  '01022223331', 1, 5, '100:123;   1:500;        10:1000;    11:2000;        ', 'google22savetest',  -1		-- 토탈방식
select roulette, roulettefreecnt, roulettepaycnt from dbo.tUserMaster where gameid = 'xxxx@gmail.com'

select roulette, roulettefreecnt, roulettepaycnt from dbo.tUserMaster where gameid = 'xxxx@gmail.com'
exec spu_FVSave3 'xxxx@gmail.com',  '01022223331', 1, 5, '  0:123;   1:500;        10:1000;    11:2000;         20:1;          21:0;', 'google22savetest',  -1		-- 누적방식
select roulette, roulettefreecnt, roulettepaycnt from dbo.tUserMaster where gameid = 'xxxx@gmail.com'
exec spu_FVSave3 'xxxx@gmail.com',  '01022223331', 1, 5, '100:123;   1:500;        10:1000;    11:2000;         20:-1;          21:2;', 'google22savetest',  -1		-- 토탈방식
select roulette, roulettefreecnt, roulettepaycnt from dbo.tUserMaster where gameid = 'xxxx@gmail.com'
*/
/*
select concode, count(*) from dbo.tUserMaster group by concode
select concode, gameid from dbo.tUserMaster where gameid in ('xxxx@gmail.com', 'xxxx2@gmail.com', 'xxxx3@gmail.com', 'xxxx4@gmail.com')

--update dbo.tUserMaster set concode = 81 where gameid = 'xxxx3@gmail.com'
*/

/*

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
*/

/*

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserMaster_salemoney2')
   DROP INDEX tUserMaster.idx_tFVUserMaster_salemoney2
GO
CREATE INDEX idx_tFVUserMaster_salemoney2 ON tUserMaster (salemoney2)
GO




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
*/


/*
alter table dbo.tUserMaster add nickname	varchar(20)				default('')
alter table dbo.tUserMaster add nickcnt	int						default(1)


update dbo.tUserMaster set nickname = SUBSTRING ( gameid ,0 , 20 ), nickcnt = 0
--select gameid, SUBSTRING ( gameid ,0 , 20 ) from dbo.tUserMaster
*/


/*
alter table dbo.tUserMaster add eventspot0x		int					default(0)

update dbo.tUserMaster set eventspot0x = 0
*/

/*
delete from dbo.tFVNotice where market = 5 and buytype = 1
select * from dbo.tFVNotice	where market = 5 and buytype = 1
order by idx desc

*/
/*
update dbo.tUserMaster set cashpoint = 0, cashcost2 = 0, vippoint2 = 0, bestani = 500 where gameid = 'xxxx@gmail.com'

update dbo.tUserMaster set cashpoint = 0, cashcost2 = 50000, vippoint2 = 50000, bestani = 523 where gameid = 'xxxx@gmail.com'
update dbo.tUserMaster set cashpoint = 99000, cashcost2 = 500000 where gameid = 'xxxx@gmail.com'

*/

/*
alter table dbo.tUserMaster add logwrite2	int						default(1)
alter table dbo.tUserMaster add roulette	int						default(1)
update dbo.tUserMaster set logwrite2 = 1, roulette = 1



select * from dbo.tUserMaster where blockstate = 0 and logwrite2 = 1 and cashpoint = 0 and cashcost2 > 50000
select * from dbo.tUserMaster where blockstate = 0 and logwrite2 = 1 and cashpoint = 0 and vippoint2 > 50000
select * from dbo.tUserMaster where blockstate = 0 and logwrite2 = 1 and cashpoint = 0 and bestani > 520
select cashpoint, cashcost2, * from dbo.tUserMaster where blockstate = 0 and logwrite2 = 1 and cashpoint > 0 and cashpoint*4 < cashcost2
*/

/*
alter table dbo.tUserMaster add bestani	int						default(500)
update dbo.tUserMaster set bestani = 500
*/
/*
alter table dbo.tUserMaster add cashcost	bigint					default(0)
alter table dbo.tUserMaster add vippoint	int						default(0)
alter table dbo.tUserMaster add cashcost2	bigint					default(0)
alter table dbo.tUserMaster add vippoint2	int						default(0)
alter table dbo.tUserMaster add salemoney2	bigint					default(0)

update dbo.tUserMaster set cashcost = cashpoint*2, vippoint = cashpoint, cashcost2 = 0, vippoint2 = 0, salemoney2 = 0

*/




/*
alter table dbo.tUserMaster add buytype		int					default(0)
update dbo.tUserMaster set buytype = 0


alter table dbo.tFVDayLogInfoStatic add joinukcnt2		int				default(0)
update dbo.tFVDayLogInfoStatic set joinukcnt2 = 0
*/

--update dbo.tUserMaster set buytype = 1 where gameid = '107146341108081809922'

/*
alter table dbo.tUserMaster add eventspot07		int					default(0)
alter table dbo.tUserMaster add eventspot08		int					default(0)
alter table dbo.tUserMaster add eventspot09		int					default(0)

update dbo.tUserMaster set eventspot06 = 0, eventspot07 = 0, eventspot08 = 0, eventspot09 = 0
*/


/*
-- delete from dbo.tFVGiftList where gameid = 'xxxx@gmail.com'
-- update dbo.tFVCashLog set writedate = '2014-12-30'
-- 2014-12-27 ~ 2014-12-30 10:18
-- select * from dbo.tFVCashLog
declare @EVENT01_START_DAY	datetime		set @EVENT01_START_DAY						= '2014-12-27'
declare @EVENT01_END_DAY	datetime		set @EVENT01_END_DAY						= '2014-12-31 10:30'
declare @EVENT02_ITEMCODE	int				set @EVENT02_ITEMCODE		= 3015	-- 우유결정 100%
declare @gameid				varchar(60)		set @gameid					= ''
declare @cash				int				set @cash					= 0
declare @pluscashcost		int				set @pluscashcost			= 0


-- 1. 선언하기.
declare curUserMessage Cursor for
select gameid, cash from dbo.tFVCashLog where writedate >= @EVENT01_START_DAY and writedate <= @EVENT01_END_DAY


-- 2. 커서오픈
open curUserMessage

-- 3. 커서 사용
Fetch next from curUserMessage into @gameid, @cash
while @@Fetch_status = 0
	Begin



		set @pluscashcost = case
								when @cash in (5000)  then   5000
								when @cash in (10000) then  12000
								when @cash in (30000) then  39000
								when @cash in (55000) then  77000
								when @cash in (99000) then 148500
								else 0
						end

		--select @gameid gameid, @cash cash, @pluscashcost pluscashcost
		exec spu_FVSubGiftSend 2, @EVENT02_ITEMCODE, @pluscashcost, 'vipevent', @gameid, ''
		Fetch next from curUserMessage into @gameid, @cash
	end

-- 4. 커서닫기
close curUserMessage
Deallocate curUserMessage
*/


/*
declare @gameid varchar(60) set @gameid = '108896905679422200740'
select * from dbo.tFVUserData where gameid = @gameid

insert into dbo.tFVUserData(gameid, market, savestate, savedata)
select @gameid, 2, savestate, savedata from dbo.tFVUserData where gameid = @gameid and market = 5

insert into dbo.tFVUserData(gameid, market, savestate, savedata)
select @gameid, 6, savestate, savedata from dbo.tFVUserData where gameid = @gameid and market = 5
*/

/*
-- 세이브파일 연동
-- 내것 Org 	-- 109661327975685722362
				-- 103066420248652848154
-- 준식PC 		-- za1xs2cd3vf4
-- delete from dbo.tFVUserData where gameid = '103066420248652848154'
declare @gameid varchar(60) set @gameid = '103066420248652848154'
select * from dbo.tFVUserData where gameid = @gameid

insert into dbo.tFVUserData(gameid, market, savestate, savedata)
select @gameid, 1, savestate, savedata from dbo.tFVUserData where gameid = '109661327975685722362' and market = 5

insert into dbo.tFVUserData(gameid, market, savestate, savedata)
select @gameid, 2, savestate, savedata from dbo.tFVUserData where gameid = '109661327975685722362' and market = 5

insert into dbo.tFVUserData(gameid, market, savestate, savedata)
select '103066420248652848154', 3, savestate, savedata from dbo.tFVUserData where gameid = '109661327975685722362' and market = 5

insert into dbo.tFVUserData(gameid, market, savestate, savedata)
select @gameid, 4, savestate, savedata from dbo.tFVUserData where gameid = '109661327975685722362' and market = 5

insert into dbo.tFVUserData(gameid, market, savestate, savedata)
select @gameid, 5, savestate, savedata from dbo.tFVUserData where gameid = '109661327975685722362' and market = 5

insert into dbo.tFVUserData(gameid, market, savestate, savedata)
select @gameid, 6, savestate, savedata from dbo.tFVUserData where gameid = '109661327975685722362' and market = 5

insert into dbo.tFVUserData(gameid, market, savestate, savedata)
select @gameid, 7, savestate, savedata from dbo.tFVUserData where gameid = '109661327975685722362' and market = 5

--select * from dbo.tFVUserData where market != 5
--delete from dbo.tFVUserData where market != 5


declare @loop int
set @loop = 3000
while (@loop < 3015)
	begin
		exec spu_FVSubGiftSend 2, @loop, 20000, '강제전송', '109661327975685722362', ''			-- 유제품
		set @loop = @loop + 1
	end
exec spu_FVSubGiftSend 2, 3100, 2000000000, '강제전송', '109661327975685722362', ''				-- 코인
exec spu_FVSubGiftSend 2, 3200, 50000, '강제전송', '109661327975685722362', ''					-- VIP
exec spu_FVSubGiftSend 2, 3015, 500000, '강제전송', '109661327975685722362', ''					-- 결정


declare @loop int
set @loop = 3000
while (@loop < 3015)
	begin
		exec spu_FVSubGiftSend 2, @loop, 20000, '강제전송', '103066420248652848154', ''			-- 유제품
		set @loop = @loop + 1
	end
exec spu_FVSubGiftSend 2, 3100, 2000000000, '강제전송', '103066420248652848154', ''				-- 코인
exec spu_FVSubGiftSend 2, 3200, 50000, '강제전송', '103066420248652848154', ''					-- VIP
exec spu_FVSubGiftSend 2, 3015, 500000, '강제전송', '109661327975685722362', ''					-- 결정




declare @loop int
set @loop = 3000
while (@loop < 3015)
	begin
		exec spu_FVSubGiftSend 2, @loop, 20000, '강제전송', '101865416115406975127', ''			-- 유제품
		set @loop = @loop + 1
	end
exec spu_FVSubGiftSend 2, 3100, 2000000000, '강제전송', '101865416115406975127', ''				-- 코인
exec spu_FVSubGiftSend 2, 3200, 50000, '강제전송', '101865416115406975127', ''					-- VIP
exec spu_FVSubGiftSend 2, 3015, 500000, '강제전송', '101865416115406975127', ''					-- 결정

*/

/*
use Farm
GO


IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserData_idx')
   DROP INDEX tFVUserData.idx_tFVUserData_idx
GO
CREATE INDEX idx_tFVUserData_idx ON tFVUserData (idx)
GO
*/


/*
use Farm
GO

-- select * from dbo.tFVUserData
--update dbo.tFVUserData set savedata = ''
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
	CONSTRAINT pk_tFVUserData_gameid_market	PRIMARY KEY(gameid, market)
)
GO


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


*/



/*
alter table dbo.tUserMaster add eventspot06		int					default(0)
update dbo.tUserMaster set eventspot06 = 0
*/

/*
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

*/












/*

select m.gameid, m.regdate, c.cash
from dbo.tUserMaster m
	JOIN
	(select gameid, SUM(cash) cash from dbo.tFVCashLog group by gameid) c
	ON m.gameid = c.gameid
	order by 2 desc


select top 10 * from dbo.tUserMaster
*/


/*
-- 쪽지 발송
declare @gameid 	varchar(60),
		@concode	int,
		@message1 	varchar(256),
		@message2 	varchar(256)

set @message1 = '게임을 삭제하실 경우 게임 세이브 데이터가 초기화됩니다. 게임을 업데이트를 하실 때 저장공간을 충분히 마련하시고 업데이트를 진행해주시길 부탁드립니다.'
set @message2 = 'If you delete the game save data will be initialized.'


-- 1. 선언하기.
declare curUserMessage Cursor for
select gameid, concode from dbo.tUserMaster

-- 2. 커서오픈
open curUserMessage

-- 3. 커서 사용
Fetch next from curUserMessage into @gameid, @concode
while @@Fetch_status = 0
	Begin
		if(@concode = 82)
			begin
				exec spu_FVSubGiftSend 1,   -1,   0, 'SangSang', @gameid, @message1
				--select @message1
			end
		else
			begin
				exec spu_FVSubGiftSend 1,   -1,   0, 'SangSang', @gameid, @message2
				--select @message2
			end
		Fetch next from curUserMessage into @gameid, @concode
	end

-- 4. 커서닫기
close curUserMessage
Deallocate curUserMessage

*/

--alter table dbo.tFVEventCertNoBack add market		int				default(5)
--update dbo.tFVEventCertNoBack set market = 5

/*
DROP INDEX tFVEventCertNoBack.idx_tFVEventCertNoBack_gameid_kind

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVEventCertNoBack_gameid_kind_market')
    DROP INDEX tFVEventCertNoBack.idx_tFVEventCertNoBack_gameid_kind_market
GO
CREATE INDEX idx_tFVEventCertNoBack_gameid_kind_market ON tFVEventCertNoBack (gameid, kind, market)
GO
*/


/*
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
*/

/*
alter table dbo.tFVUserData add pushid		varchar(256)			default('')
update dbo.tFVUserData set pushid = ''
*/


/*
alter table dbo.tUserMaster add concode		int						default(82)
update dbo.tUserMaster set concode = 82

alter table dbo.tUserMaster add randserial	varchar(20)			default('-1')
alter table dbo.tUserMaster add bgitemcode1	int						default(-1)
alter table dbo.tUserMaster add bgitemcode2	int						default(-1)
alter table dbo.tUserMaster add bgitemcode3	int						default(-1)
alter table dbo.tUserMaster add bgcnt1		int						default(0)
alter table dbo.tUserMaster add bgcnt2		int						default(0)
alter table dbo.tUserMaster add bgcnt3		int						default(0)
update dbo.tUserMaster set bgitemcode1 = -1, bgitemcode2 = -1, bgitemcode3 = -1, bgcnt1 = 0, bgcnt2 = 0, bgcnt3 = 0, randserial = '-1'



alter table dbo.tFVDayLogInfoStatic add certnocnt		int				default(0)
update dbo.tFVDayLogInfoStatic set certnocnt = 0
*/

/*
-- select 'insert into dbo.tFVEventCertNo(certno,  itemcode1,  cnt1,  itemcode2,  cnt2,  itemcode3,  cnt3, kind) values(''' + certno + ''',' + str(itemcode1) + ',  ' + str(cnt1) + ',  ' + str(itemcode2) + ',  ' + str(cnt2) + ',  ' + str(itemcode3) + ',  ' + str(cnt3) + ',  ' + str(kind) + ')' from dbo.tFVEventCertNo where kind = 1
select max(idx) from dbo.tFVEventCertNo where kind = 1
select * from dbo.tFVEventCertNo where kind = 1
*/


/*


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
	cnt			int					default(0),
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



*/


-- select * from dbo.tFVGiftList where gameid = 'xxxx' order by idx desc
-- insert into dbo.tFVGiftList(gameid, giftkind, message) values('xxxx', 1, 'Shot message');
-- insert into dbo.tFVGiftList(gameid, giftkind, itemcode, giftid) values('xxxx', 2, 1, 'SangSang');




/*
select * from dbo.tFVUserPushSendInfo

alter table dbo.tFVUserPushSendInfo add msgurl			varchar(512)	default('')
update dbo.tFVUserPushSendInfo set msgurl = 'market://details?id=com.sangsangdigital.farmvill'



--alter table dbo.tFVPushBlackList add writedate		datetime			default(getdate())
--update dbo.tFVPushBlackList set writedate = getdate()
*/

/*
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

	-- Constraint
	CONSTRAINT	pk_tFVPushBlackList_idx	PRIMARY KEY(idx)
)
insert into dbo.tFVPushBlackList(phone, comment) values('01036630157', '김세훈대표')
insert into dbo.tFVPushBlackList(phone, comment) values('01055841110', '이대성 과장')
insert into dbo.tFVPushBlackList(phone, comment) values('01051955895', '이정우')
insert into dbo.tFVPushBlackList(phone, comment) values('01043358319', '김남훈')
insert into dbo.tFVPushBlackList(phone, comment) values('01089114806', '김용민')
insert into dbo.tFVPushBlackList(phone, comment) values('0183302149', '채문기')
insert into dbo.tFVPushBlackList(phone, comment) values('01050457694', '이영지')
insert into dbo.tFVPushBlackList(phone, comment) values('01048742835', '윤인좌 대리')
insert into dbo.tFVPushBlackList(phone, comment) values('01024065144', '운영 김범수')
insert into dbo.tFVPushBlackList(phone, comment) values('01027624701', '서버 김선일')
insert into dbo.tFVPushBlackList(phone, comment) values('01090196756', '픽토_호스팅업체')
--select * from dbo.tFVPushBlackList

---------------------------------------------
--	Android Push Service
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserPushAndroid', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserPushAndroid;
GO

create table dbo.tFVUserPushAndroid(
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
--select * from dbo.tFVUserPushiPhone
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
*/



/*
select top 10 * from dbo.tFVCashLog order by idx desc

select * from dbo.tFVAdminUser where gameid = 'global'

select * from dbo.tUserMaster
select * from dbo.tFVUserBlockPhone
select * from dbo.tFVNotice
select * from dbo.tFVDayLogInfoStatic
select * from dbo.tFVCashLog
select * from dbo.tFVCashTotal
select * from dbo.tFVAdminUser

alter table dbo.tUserMaster add logindate	varchar(8)				default('20100101')
update dbo.tUserMaster set logindate = '20100101'

alter table dbo.tUserMaster add cashpoint	int						default(0)
update dbo.tUserMaster set cashpoint = 0
*/


/*
exec spu_FVFarmD 27, 12, -1, -1, -1, -1, -1, -1, -1, -1, '사과쪽지', '', 'Naver패치가 구글로 연결되었습니다. 다시 네이버에서 받아주세요.', '', '', '', '', '', '', ''	-- 메세지보내기
exec spu_FVFarmD 27, 12, -1, -1, -1, -1, -1, -1, -1, -1, '이용에 불편을 드려 죄송합니다.', 'farm635061189', 'Naver패치가 구글로 연결되었습니다. 다시 네이버에서 받아주세요.', '', '', '', '', '', '', ''	-- 메세지보내기
*/


/*
IF OBJECT_ID (N'dbo.tFVXXX', N'U') IS NOT NULL
	DROP TABLE dbo.tFVXXX;
GO

create table dbo.tFVXXX(
	idx			int 					IDENTITY(1, 1),
	phone		varchar(20)				default(''),			-- indexing

	-- Constraint
	CONSTRAINT pk_tXXX_gameid	PRIMARY KEY(idx)
)
GO


-- 폰인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tXXX_phone')
    DROP INDEX tXXX.idx_tXXX_phone
GO
CREATE INDEX idx_tXXX_phone ON tXXX (phone)
GO
*/



/*
select --top 10
'insert into dbo.tFVXXX(phone, market, regdate) values('''
+ ltrim(rtrim(phone)) + ''','
+ ltrim(rtrim(str(market))) + ','''
+ Convert(varchar(8), regdate, 112) + ''')'
-- , *
from dbo.tFVFVUserMaster where market != 7 and regdate >= '2014-05-01'
*/
/*
DECLARE @tTTT Table(phone varchar(20));

insert into @tTTT(phone)
select
distinct
-- top 10
phone
from dbo.tFVFVUserMaster
where market != 7 and regdate >= '2014-05-01' and phone != '-1'

select
'insert into dbo.tFVXXX(phone) values('''
+ ltrim(rtrim(phone)) + ''')'
 from @tTTT


--insert into dbo.tFVXXX(phone, market, regdate) values(' + ltrim(rtrim(phone)) + '' + ltrim(rtrim(str(market))) + '' + ltrim(rtrim(str(regdate))) + '
--insert into dbo.tFVXXX(phone, market, regdate) values('01029442435',5',05  6 2014  9:52PM',
-- insert into dbo.tFVXXX(phone, market, regdate) values('01029442435',5',20140506',
-- insert into dbo.tFVXXX(phone, market, regdate) values('01029442435',5,'20140506',
-- insert into dbo.tFVXXX(phone, market, regdate) values('01029442435',5,'20140506')
*/
/*

select distinct phone from dbo.tFVFVUserMaster
where market != 7 and regdate >= '2014-05-01' and phone != '-1'

*/


--------------------------------------------
-- 대용량 푸쉬보내기
---------------------------------------------
/*

-- 대용량으로 입력하기
insert into dbo.tFVQuestUser(gameid, questcode, queststate, queststart)
	select @gameid_, questcode, @QUEST_STATE_USER_ING, getdate()
		from dbo.tFVQuestInfo where questinit = @QUEST_INIT_FIRST



insert into dbo.tFVUserPushAndroid(recepushid, sendid, receid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction)
	select distinct pushid, @ps2_, @gameid_, @p5_, 99, @ps3_, @ps4_, @branchurl from dbo.tFVFVUserMaster
		where market = 1 and pushid is not null and len(pushid) > 50

	select distinct pushid, 'a2' from dbo.tFVFVUserMaster
		where market = 1 and pushid is not null and len(pushid) > 50
		and gameid in ('guest74019', 'guest74022')

	select distinct pushid, 'a2' from dbo.tFVFVUserMaster
		where gameid in ('guest74019', 'guest74022')

*/


--------------------------------------------
-- Android Push 발송후 로그쪽으로 이동하기
---------------------------------------------
/*
-- select min(idx) min, max(idx) max from dbo.tFVUserPushAndroid
-- select * from dbo.tFVUserPushAndroid
DECLARE @tTemp TABLE(
				sendid			varchar(20),
				receid			varchar(20),
				recepushid		varchar(256),
				comment			varchar(256)
			);
delete from dbo.tFVUserPushAndroid
	OUTPUT sendid, receid, recepushid, comment into @tTemp
	where idx in (1, 2)
	--where idx between 1 and 2
-- select * from @tTemp

insert into dbo.tFVUserPushAndroidLog(sendid, receid, recepushid, comment)
	(select sendid, receid, recepushid, comment from @tTemp)
-- select * from dbo.tFVUserPushAndroidLog
*/
