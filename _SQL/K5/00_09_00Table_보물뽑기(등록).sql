-- 1. 1차버젼 비활성화(완료)
-- update dbo.tSystemTreasure set packstate = -1 where packstate = 1 and packname     like '%(1차버젼)'	-- 신규 비활성화.
-- update dbo.tSystemTreasure set packstate =  0 where famelvmin = 999
--
-- 2. 마켓에서 특정 못나오도록 설정하기. (반영)
--
-- 3. 2차 버젼 활성화, 기존 버젼 비활성화.(반영)
-- update dbo.tSystemTreasure set packstate =  1 where packstate = -1 and packname     like '%(1차버젼)'	-- 신규 비활성화.
-- update dbo.tSystemTreasure set packstate = -1 where packstate =  1 and packname not like '%(1차버젼)'	-- 기존 버젼 비활성화.

---------------------------------------------
-- 교배뽑기 정보.
---------------------------------------------
use GameMTBaseball
GO

IF OBJECT_ID (N'dbo.tSystemTreasure', N'U') IS NOT NULL
	DROP TABLE dbo.tSystemTreasure;
GO

create table dbo.tSystemTreasure(
	idx					int 				IDENTITY(1, 1),
	itemcode			int					default(130000),

	famelvmin			int					default(1),		-- 최소렙.
	famelvmax			int					default(70),	-- 최대렙.
	packname			varchar(1024)		default(''),

	-- 뽑기정보.
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
	CONSTRAINT	pk_tSystemTreasure_idx	PRIMARY KEY(idx)
)

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tSystemTreasure_famelvmin_famelvmax')
	DROP INDEX tSystemTreasure.idx_tSystemTreasure_famelvmin_famelvmax
GO
CREATE INDEX idx_tSystemTreasure_famelvmin_famelvmax ON tSystemTreasure (famelvmin, famelvmax)
GO
