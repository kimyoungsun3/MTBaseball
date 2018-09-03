-- 1. 2차버젼 비활성화(완료)
-- update dbo.tFVSystemRoulette set packstate = -1 where packstate = 1 and packname     like '%(2차버젼)'	-- 신규 비활성화.
-- update dbo.tFVSystemRoulette set packstate =  0 where famelvmin = 999
--
-- 2. 마켓에서 특정 동물이 못나오도록 설정하기. (반영)
--
-- 3. 2차 버젼 활성화, 기존 버젼 비활성화.(반영)
-- update dbo.tFVSystemRoulette set packstate =  1 where packstate = -1 and packname     like '%(2차버젼)'	-- 신규 비활성화.
-- update dbo.tFVSystemRoulette set packstate = -1 where packstate =  1 and packname not like '%(2차버젼)'	-- 기존 버젼 비활성화.

---------------------------------------------
-- 교배뽑기 정보.
---------------------------------------------
use Game4FarmVill4
GO

IF OBJECT_ID (N'dbo.tFVSystemRoulette', N'U') IS NOT NULL
	DROP TABLE dbo.tFVSystemRoulette;
GO

create table dbo.tFVSystemRoulette(
	idx					int 				IDENTITY(1, 1),
	itemcode			int					default(90000),

	famelvmin			int					default(500),	-- 최소렙.
	famelvmax			int					default(505),	-- 최대렙.
	packname			varchar(256)		default(''),

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

	cashcostcost		int					default(0),	-- 교배뽑기 원가.
	cashcostper			int					default(0),	--        할인율.
	cashcostsale		int					default(0),	--        할인가.
	gamecost			int					default(0),	-- 일반판매(코인)
	heart				int					default(0),	-- 하트

	--코멘트.
	packstate			int					default(-1),	-- 1:활성, -1:비활성.
	comment				varchar(256)		default(''),
	writedate			datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tFVSystemRoulette_idx	PRIMARY KEY(idx)
)

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVSystemRoulette_famelvmin_famelvmax')
	DROP INDEX tFVSystemRoulette.idx_tFVSystemRoulette_famelvmin_famelvmax
GO
CREATE INDEX idx_tFVSystemRoulette_famelvmin_famelvmax ON tFVSystemRoulette (famelvmin, famelvmax)
GO

-- delete from dbo.tItemInfo where subcategory = 900 and itemcode >= 90000
-- insert into dbo.tFVSystemRoulette(itemcode, famelvmin, famelvmax, cashcostcost, cashcostper, cashcostsale, packstate, packname,          comment, pack1, pack2, pack3, pack4, pack5, pack6, pack7, pack8, pack9, pack10, pack11, pack12, pack13, pack14, pack15, pack16, pack17, pack18, pack19, pack20, packstr)
-- values(                         90000,    1,         10,        69,           10,          62,           -1,        '소 A등급 교배뽑기', '내용',  1,     2,     3,     4,     5,     6,     7,     8,     9,     10,     11,     12,     13,     14,     15,     16,     17,     18,     19,     20,     '1:2;2:2;3:3;4:4;5:5;6:6;7:7;8:8;9:9;10:10;11:11;12:12;13:13;14:14;15:15;16:101;17:102;18:103;19:104;20:105')
-- update dbo.tFVSystemRoulette
-- 		set
-- 			famelvmin	= 1,
-- 			famelvmax	= 10,
-- 			cashcostcost 	= 69,
-- 			cashcostper		= 10,
-- 			cashcostsale	= 62,
-- 			packstate	= -1,
-- 			packname	= '소 A등급 교배뽑기',
-- 			comment		= '내용',
-- 			pack1	= 80000,   	pack2	= 80000,	pack3	= 80000,	pack4	= 80000,		pack5	= 80000,		pack6	= 80000,  	pack7	= 80000,	pack8	= 80000,	pack9	= 80000,		pack10	= 80000,
-- 			pack11	= 80001,  	pack12	= 80001,	pack13	= 80001,	pack14	= 80001,		pack15	= 80001,		pack16	= 80001,  	pack17	= 80001,	pack18	= 80001,	pack19	= 80001,		pack20	= 80001,
-- 			pack21	= 80010,  	pack22	= 80010,	pack23	= 80010,	pack24	= 80010,		pack25	= 80010,		pack26	= 80010,  	pack27	= 80010,	pack28	= 80010,	pack29	= 80010,		pack30	= 80010,
-- 			pack31	= 80011,  	pack32	= 80011,	pack33	= 80011,	pack34	= 80011,		pack35	= 80011,		pack36	= 80011,  	pack37	= 80011,	pack38	= 80011,	pack39	= 80011,		pack40	= 80011,
-- 			packstr = '1:80000;2:80000;3:80000;4:80000;5:80000;6:80000;7:80000;8:80000;9:80000;10:80000;11:80001;12:80001;13:80001;14:80001;15:80001;16:80001;17:80001;18:80001;19:80001;20:80001;21:80010;22:80010;23:80010;24:80010;25:80010;26:80010;27:80010;28:80010;29:80010;30:80010;31:80011;32:80011;33:80011;34:80011;35:80011;36:80011;37:80011;38:80011;39:80011;40:80011;'
-- where idx = 1
-- select * from dbo.tFVSystemRoulette order by famelvmin asc, famelvmax asc

------------------------------------------------------------------------------------------------------------------------------------------------
-- 교배뽑기등록 > 새로운 아이템 코드 생성됨.
--
--                       번호,  최소레벨, 최대레벨, 판매가, 할인가, 활성여부(1),                     교배뽑기이름, 코멘트, 교배뽑기번호
-- exec spu_FVFarmD 30, 22, -1,        500,      505,      0,      0,           1,  1000,   50, '초보시작1', '내용1', '1:80000;2:80000;3:80000;4:80000;5:80000;6:80000;7:80000;8:80000;9:80000;10:80000;11:80001;12:80001;13:80001;14:80001;15:80001;16:80001;17:80001;18:80001;19:80001;20:80001;21:80010;22:80010;23:80010;24:80010;25:80010;26:80010;27:80010;28:80010;29:80010;30:80010;31:80011;32:80011;33:80011;34:80011;35:80011;36:80011;37:80011;38:80011;39:80011;40:80011;', '', '', '', '', '', '', ''
-- exec spu_FVFarmD 30, 22, -1,        505,      510,      0,      0,           1,  1000,   50, '초보시작2', '내용2', '1:80000;2:80000;3:80000;4:80000;5:80000;6:80000;7:80000;8:80000;9:80000;10:80000;11:80001;12:80001;13:80001;14:80001;15:80001;16:80001;17:80001;18:80001;19:80001;20:80001;21:80010;22:80010;23:80010;24:80010;25:80010;26:80010;27:80010;28:80010;29:80010;30:80010;31:80011;32:80011;33:80011;34:80011;35:80011;36:80011;37:80011;38:80011;39:80011;40:80011;', '', '', '', '', '', '', ''
-- exec spu_FVFarmD 30, 22, -1,        510,      515,      0,      0,           1,  1000,   50, '초보시작3', '내용3', '1:80000;2:80000;3:80000;4:80000;5:80000;6:80000;7:80000;8:80000;9:80000;10:80000;11:80001;12:80001;13:80001;14:80001;15:80001;16:80001;17:80001;18:80001;19:80001;20:80001;21:80010;22:80010;23:80010;24:80010;25:80010;26:80010;27:80010;28:80010;29:80010;30:80010;31:80011;32:80011;33:80011;34:80011;35:80011;36:80011;37:80011;38:80011;39:80011;40:80011;', '', '', '', '', '', '', ''
-- exec spu_FVFarmD 30, 22, -1,        515,      520,      0,      0,           1,  1000,   50, '초보시작4', '내용4', '1:80000;2:80000;3:80000;4:80000;5:80000;6:80000;7:80000;8:80000;9:80000;10:80000;11:80001;12:80001;13:80001;14:80001;15:80001;16:80001;17:80001;18:80001;19:80001;20:80001;21:80010;22:80010;23:80010;24:80010;25:80010;26:80010;27:80010;28:80010;29:80010;30:80010;31:80011;32:80011;33:80011;34:80011;35:80011;36:80011;37:80011;38:80011;39:80011;40:80011;', '', '', '', '', '', '', ''
-- exec spu_FVFarmD 30, 22, -1,        520,      525,      0,      0,           1,  1000,   50, '초보시작5', '내용5', '1:80000;2:80000;3:80000;4:80000;5:80000;6:80000;7:80000;8:80000;9:80000;10:80000;11:80001;12:80001;13:80001;14:80001;15:80001;16:80001;17:80001;18:80001;19:80001;20:80001;21:80010;22:80010;23:80010;24:80010;25:80010;26:80010;27:80010;28:80010;29:80010;30:80010;31:80011;32:80011;33:80011;34:80011;35:80011;36:80011;37:80011;38:80011;39:80011;40:80011;', '', '', '', '', '', '', ''
------------------------------------------------------------------------------------------------------------------------------------------------
