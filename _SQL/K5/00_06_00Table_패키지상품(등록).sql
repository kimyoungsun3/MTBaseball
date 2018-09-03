
---------------------------------------------
-- 패키지 정보.
---------------------------------------------
use GameMTBaseball
GO

IF OBJECT_ID (N'dbo.tSystemPack', N'U') IS NOT NULL
	DROP TABLE dbo.tSystemPack;
GO

create table dbo.tSystemPack(
	idx					int 				IDENTITY(1, 1),
	itemcode			int					default(50000),

	famelvmin			int					default(1),		-- 최소렙.
	famelvmax			int					default(50),	-- 최대렙.
	packname			varchar(256)		default(''),

	-- 패키지정보.
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
	packstr				varchar(1024)		default(''),

	cashcostcost		int					default(100),	-- 패키지 원가.
	cashcostper			int					default(10),	--        할인율.
	cashcostsale		int					default(90),	--        할인가.

	--코멘트.
	packstate			int					default(-1),	-- 1:활성, -1:비활성.
	comment				varchar(256)		default(''),
	packmarket			varchar(40)			default('1,2,3,4,5,6,7'),
	writedate			datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tSystemPack_idx	PRIMARY KEY(idx)
)

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tSystemPack_famelvmin_famelvmax')
	DROP INDEX tSystemPack.idx_tSystemPack_famelvmin_famelvmax
GO
CREATE INDEX idx_tSystemPack_famelvmin_famelvmax ON tSystemPack (famelvmin, famelvmax)
GO

-- insert into dbo.tSystemPack(itemcode, famelvmin, famelvmax, cashcostcost, cashcostper, cashcostsale, packstate, packname,          comment, pack1, pack2, pack3, pack4, pack5, pack6, pack7, pack8, pack9, pack10, pack11, pack12, pack13, pack14, pack15, pack16, pack17, pack18, pack19, pack20, packstr)
-- values(                     50004,    1,         10,        69,           10,          62,               -1,        '소 A등급 패키지', '내용',  1,     2,     3,     904,   1200, -1,     -1,    -1,    -1,    -1,     -1,     -1,     -1,     -1,     -1,     -1,     -1,     -1,     -1,     -1,     '1:1;2:2;3:3;4:904;5:1200;6:-1;7:-1;8:-1;9:-1;10:-1;11:-1;12:-1;13:-1;14:-1;15:-1;16:-1;17:-1;18:-1;19:-1;20:-1')
-- update dbo.tSystemPack
-- 		set
-- 			famelvmin	= 1,
-- 			famelvmax	= 10,
-- 			cashcostcost 	= 69,
-- 			cashcostper		= 10,
-- 			cashcostsale	= 62,
-- 			packstate	= -1,
-- 			packname	= '소 A등급 패키지',
-- 			comment		= '내용',
-- 			pack1	= 1,   	pack2	= 2,	pack3	= 3,	pack4	= 904,		pack5	= 1200,
-- 			pack6	= -1,  	pack7	= -1,	pack8	= -1,	pack9	= -1,		pack10	= -1,
-- 			pack11	= -1,  	pack12	= -1,	pack13	= -1,	pack14	= -1,		pack15	= -1,
-- 			pack16	= -1,  	pack17	= -1,	pack18	= -1,	pack19	= -1,		pack20	= -1,
-- 			packstr = '1:1;2:2;3:3;4:904;5:1200;'
-- where idx = 1
-- select * from dbo.tSystemPack order by famelvmin asc, famelvmax asc


------------------------------------------------------------------------------------------------------------------------------------------------
-- 아이템 테이블의 카테고리를 삭제.
--delete from dbo.tItemInfo where subcategory = 500 and itemcode >= 50004
--
------------------------------------------------------------------------------------------------------------------------------------------------
-- 패키지등록 > 새로운 아이템 코드 생성됨.
--
--                       번호,  최소레벨, 최대레벨, 판매가, 할인가, 활성여부(1),          패키지이름,        코멘트, 패키지번호(10개이상)
-- exec spu_GameMTBaseballD 30, 12, -1,     1,        50,       69,     10,     1,          -1,  -1, '소 1등급 패키지', '내용', '1:1;2:2;3:3;4:904;5:1200;', '', '', '', '', '', '', ''
-- exec spu_GameMTBaseballD 30, 12, -1,    10,        50,       69,     10,     1,          -1,  -1, '소 2등급 패키지', '내용', '1:2;2:2;3:3;4:904;5:1200;', '', '', '', '', '', '', ''
-- exec spu_GameMTBaseballD 30, 12, -1,    20,        50,       69,     10,     1,          -1,  -1, '소 3등급 패키지', '내용', '1:3;2:2;3:3;4:904;5:1200;', '', '', '', '', '', '', ''
-- exec spu_GameMTBaseballD 30, 12, -1,    30,        50,       69,     10,     1,          -1,  -1, '소 4등급 패키지', '내용', '1:4;2:2;3:3;4:904;5:1200;', '', '', '', '', '', '', ''
-- exec spu_GameMTBaseballD 30, 12, -1,    40,        50,       69,     10,     1,          -1,  -1, '소 5등급 패키지', '내용', '1:5;2:2;3:3;4:904;5:1200;', '', '', '', '', '', '', ''
------------------------------------------------------------------------------------------------------------------------------------------------


