
---------------------------------------------
-- 야바위 정보.
---------------------------------------------
use Game4Farmvill5
GO

IF OBJECT_ID (N'dbo.tSystemYabau', N'U') IS NOT NULL
	DROP TABLE dbo.tSystemYabau;
GO

create table dbo.tSystemYabau(
	idx					int 				IDENTITY(1, 1),
	itemcode			int					default(70001),
	ukcode				int,

	famelvmin			int					default(1),		-- 최소렙.
	famelvmax			int					default(70),	-- 최대렙.
	packname			varchar(256)		default(''),

	-- 야바위정보.
	pack11				int					default(-1),
	pack12				int					default(-1),
	pack13				int					default(-1),
	pack14				int					default(-1),
	pack21				int					default(-1),
	pack22				int					default(-1),
	pack23				int					default(-1),
	pack24				int					default(-1),
	pack31				int					default(-1),
	pack32				int					default(-1),
	pack33				int					default(-1),
	pack34				int					default(-1),
	pack41				int					default(-1),
	pack42				int					default(-1),
	pack43				int					default(-1),
	pack44				int					default(-1),
	pack51				int					default(-1),
	pack52				int					default(-1),
	pack53				int					default(-1),
	pack54				int					default(-1),
	pack61				int					default(-1),
	pack62				int					default(-1),
	pack63				int					default(-1),
	pack64				int					default(-1),
	packstr				varchar(1024)		default(''),

	saleper				int					default(10),	--        할인율.

	--코멘트.
	packstate			int					default(-1),	-- 1:활성, -1:비활성.
	comment				varchar(256)		default(''),
	packmarket			varchar(40)			default('1,2,3,4,5,6,7'),
	writedate			datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tSystemYabau_idx	PRIMARY KEY(idx)
)

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tSystemYabau_famelvmin_famelvmax')
	DROP INDEX tSystemYabau.idx_tSystemYabau_famelvmin_famelvmax
GO
CREATE INDEX idx_tSystemYabau_famelvmin_famelvmax ON tSystemYabau (famelvmin, famelvmax)
GO


--insert into dbo.tSystemYabau(itemcode, famelvmin, famelvmax, saleper, packstate, packname,  comment, pack11, pack12, pack13, pack14, pack21, pack22, pack23, pack24, pack31, pack32, pack33, pack34, pack41, pack42, pack43, pack44, pack51, pack52, pack53, pack54, pack61, pack62, pack63, pack64, packstr)
--values(                      70001,    1,         10,        10,          -1,        '야바위1', '내용',  1,      2,      2,      200,    2,      4,      4,      400,    3,      6,      8,      800,    4,      9,      16,     1600,   5,      10,     32,     3200,   6,      11,     64,     6400,   '1:1:2:2:200;1:2:4:4:400;1:3:6:8:800;1:4:9:16:1600;1:5:10:32:3200;1:6:11:64:6400;')
--select * from dbo.tSystemYabau order by famelvmin asc, famelvmax asc
--update dbo.tSystemYabau
--		set
--			famelvmin	= 1,
--			famelvmax	= 10,
--			saleper		= 10,
--			packstate	= -1,
--			packname	= '야바위1',
--			comment		= '내용',
--			pack11	= 1,   	pack12	= 2,	pack13	= 2,	pack14	= 200,
--			pack21	= 2,   	pack22	= 4,	pack23	= 4,	pack24	= 400,
--			pack31	= 3,   	pack32	= 6,	pack33	= 8,	pack34	= 800,
--			pack41	= 4,   	pack42	= 9,	pack43	= 16,	pack44	= 1600,
--			pack51	= 5,   	pack52	= 10,	pack53	= 32,	pack54	= 3200,
--			pack61	= 6,   	pack62	= 11,	pack63	= 64,	pack64	= 6400
--			packstr = '1:1:2:2:200;1:2:4:4:400;1:3:6:8:800;1:4:9:16:1600;1:5:10:32:3200;1:6:11:64:6400;'
--where idx = 1
--select * from dbo.tSystemYabau order by famelvmin asc, famelvmax asc
--select pack13, pack23, pack33, pack43, pack53, pack63 from dbo.tSystemYabau order by famelvmin asc, famelvmax asc


