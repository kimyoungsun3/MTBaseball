-- 교배 목록 신규 동물 업데이트
-- 		교배시 신규 동물 추가 나올 확률 상승 이벤트 준비
-- 		신규 패키지 준비
-- 		신규 동물/이벤트 배너 준비
-- 		최종 이슈 : 업데이트 문제
--		00_09Table_roul(2차버젼).sql
-- 		기존것 홀딩하는 루틴 돌리기.
--
-- 0. 2차버젼 업데이트(완료)
--
-- 1. 2차버젼 비활성화(완료)
-- update dbo.tSystemRoulette set packstate = -1 where packstate = 1 and packname     like '%(2차버젼)'	-- 신규 비활성화.
-- update dbo.tSystemRoulette set packstate =  0 where famelvmin = 999
--
-- 2. 마켓에서 특정 동물이 못나오도록 설정하기. (반영)
--	16 -> 13
--	115 -> 113
--	215 -> 212
--  (14_02교배뽑기(짜요2점령전).sql)
--
-- 3. 2차 버젼 활성화, 기존 버젼 비활성화.(반영)
-- update dbo.tSystemRoulette set packstate =  1 where packstate = -1 and packname     like '%(2차버젼)'	-- 신규 비활성화.
-- update dbo.tSystemRoulette set packstate = -1 where packstate =  1 and packname not like '%(2차버젼)'	-- 기존 버젼 비활성화.

---------------------------------------------
-- 교배뽑기 정보.
---------------------------------------------
use GameMTBaseball
GO

IF OBJECT_ID (N'dbo.tSystemRoulette', N'U') IS NOT NULL
	DROP TABLE dbo.tSystemRoulette;
GO

create table dbo.tSystemRoulette(
	idx					int 				IDENTITY(1, 1),
	itemcode			int					default(60000),

	famelvmin			int					default(1),		-- 최소렙.
	famelvmax			int					default(50),	-- 최대렙.
	packname			varchar(1024)		default(''),

	-- 교배뽑기정보.
	pack1				int					default(-1),
	pack2				int					default(-1),
	pack3				int					default(-1),
	pack4				int					default(-1),
	pack5				int					default(-1),
	pack6				int					default(-1),
	pack7				int					default(-1),
	pack8				int					default(-1),
	pack9				int					default(-1),
	pack10				int					default(-1),
	pack11				int					default(-1),
	pack12				int					default(-1),
	pack13				int					default(-1),
	pack14				int					default(-1),
	pack15				int					default(-1),
	pack16				int					default(-1),
	pack17				int					default(-1),
	pack18				int					default(-1),
	pack19				int					default(-1),
	pack20				int					default(-1),
	pack21				int					default(-1),
	pack22				int					default(-1),
	pack23				int					default(-1),
	pack24				int					default(-1),
	pack25				int					default(-1),
	pack26				int					default(-1),
	pack27				int					default(-1),
	pack28				int					default(-1),
	pack29				int					default(-1),
	pack30				int					default(-1),
	pack31				int					default(-1),
	pack32				int					default(-1),
	pack33				int					default(-1),
	pack34				int					default(-1),
	pack35				int					default(-1),
	pack36				int					default(-1),
	pack37				int					default(-1),
	pack38				int					default(-1),
	pack39				int					default(-1),
	pack40				int					default(-1),
	pack41				int					default(-1),
	pack42				int					default(-1),
	pack43				int					default(-1),
	pack44				int					default(-1),
	pack45				int					default(-1),
	pack46				int					default(-1),
	pack47				int					default(-1),
	pack48				int					default(-1),
	pack49				int					default(-1),
	pack50				int					default(-1),
	packstr				varchar(1024)		default(''),

	cashcostcost		int					default(100),	-- 교배뽑기 원가.
	cashcostper			int					default(10),	--        할인율.
	cashcostsale		int					default(90),	--        할인가.
	gamecost			int					default(0),		-- 일반판매(코인)
	heart				int					default(0),		-- 하트

	--코멘트.
	packstate			int					default(-1),	-- 1:활성, -1:비활성.
	comment				varchar(256)		default(''),
	writedate			datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tSystemRoulette_idx	PRIMARY KEY(idx)
)

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tSystemRoulette_famelvmin_famelvmax')
	DROP INDEX tSystemRoulette.idx_tSystemRoulette_famelvmin_famelvmax
GO
CREATE INDEX idx_tSystemRoulette_famelvmin_famelvmax ON tSystemRoulette (famelvmin, famelvmax)
GO

-- delete from dbo.tItemInfo where subcategory = 600 and itemcode >= 60004
-- insert into dbo.tSystemRoulette(itemcode, famelvmin, famelvmax, cashcostcost, cashcostper, cashcostsale, packstate, packname,          comment, pack1, pack2, pack3, pack4, pack5, pack6, pack7, pack8, pack9, pack10, pack11, pack12, pack13, pack14, pack15, pack16, pack17, pack18, pack19, pack20, packstr)
-- values(                         60004,    1,         10,        69,           10,          62,           -1,        '소 A등급 교배뽑기', '내용',  1,     2,     3,     4,     5,     6,     7,     8,     9,     10,     11,     12,     13,     14,     15,     16,     17,     18,     19,     20,     '1:2;2:2;3:3;4:4;5:5;6:6;7:7;8:8;9:9;10:10;11:11;12:12;13:13;14:14;15:15;16:101;17:102;18:103;19:104;20:105')
-- update dbo.tSystemRoulette
-- 		set
-- 			famelvmin	= 1,
-- 			famelvmax	= 10,
-- 			cashcostcost 	= 69,
-- 			cashcostper		= 10,
-- 			cashcostsale	= 62,
-- 			packstate	= -1,
-- 			packname	= '소 A등급 교배뽑기',
-- 			comment		= '내용',
-- 			pack1	= 1,   	pack2	= 2,	pack3	= 3,	pack4	= 4,		pack5	= 5,
-- 			pack6	= 6,  	pack7	= 7,	pack8	= 8,	pack9	= 9,		pack10	= 10,
-- 			pack11	= 11,  	pack12	= 12,	pack13	= 13,	pack14	= 14,		pack15	= 15,
-- 			pack16	= 101,  pack17	= 102,	pack18	= 103,	pack19	= 104,		pack20	= 105,
-- 			packstr = '1:2;2:2;3:3;4:4;5:5;6:6;7:7;8:8;9:9;10:10;11:11;12:12;13:13;14:14;15:15;16:101;17:102;18:103;19:104;20:105'
-- where idx = 1
-- select * from dbo.tSystemRoulette order by famelvmin asc, famelvmax asc

------------------------------------------------------------------------------------------------------------------------------------------------
-- 교배뽑기등록 > 새로운 아이템 코드 생성됨.
--
--                       번호,  최소레벨, 최대레벨, 판매가, 할인가, 활성여부(1),          교배뽑기이름,        코멘트, 교배뽑기번호
-- exec spu_GameMTBaseballD 30, 22, -1,     1,        50,       69,     10,     1,         1000,   50, '소 1등급 교배뽑기', '내용', '1:1;2:2;3:3;4:4;5:5;6:6;7:7;8:8;9:9;10:10;11:11;12:12;13:13;14:14;15:15;16:101;17:102;18:103;19:104;20:105', '', '', '', '', '', '', ''
-- exec spu_GameMTBaseballD 30, 22, -1,    10,        50,       69,     10,     1,         1000,  100, '소 2등급 교배뽑기', '내용', '1:2;2:2;3:3;4:4;5:5;6:6;7:7;8:8;9:9;10:10;11:11;12:12;13:13;14:14;15:15;16:101;17:102;18:103;19:104;20:105', '', '', '', '', '', '', ''
-- exec spu_GameMTBaseballD 30, 22, -1,    20,        50,       69,     10,     1,         1000,  150, '소 3등급 교배뽑기', '내용', '1:3;2:2;3:3;4:4;5:5;6:6;7:7;8:8;9:9;10:10;11:11;12:12;13:13;14:14;15:15;16:101;17:102;18:103;19:104;20:105', '', '', '', '', '', '', ''
-- exec spu_GameMTBaseballD 30, 22, -1,    30,        50,       69,     10,     1,         1000,  200, '소 4등급 교배뽑기', '내용', '1:4;2:2;3:3;4:4;5:5;6:6;7:7;8:8;9:9;10:10;11:11;12:12;13:13;14:14;15:15;16:101;17:102;18:103;19:104;20:105', '', '', '', '', '', '', ''
-- exec spu_GameMTBaseballD 30, 22, -1,    40,        50,       69,     10,     1,         1000,  200, '소 5등급 교배뽑기', '내용', '1:5;2:2;3:3;4:4;5:5;6:6;7:7;8:8;9:9;10:10;11:11;12:12;13:13;14:14;15:15;16:101;17:102;18:103;19:104;20:105', '', '', '', '', '', '', ''
------------------------------------------------------------------------------------------------------------------------------------------------
