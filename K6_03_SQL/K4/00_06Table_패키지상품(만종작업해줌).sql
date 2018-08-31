
---------------------------------------------
-- ��Ű�� ����.
---------------------------------------------
use Game4FarmVill4
GO

IF OBJECT_ID (N'dbo.tFVSystemPack', N'U') IS NOT NULL
	DROP TABLE dbo.tFVSystemPack;
GO

create table dbo.tFVSystemPack(
	idx					int 				IDENTITY(1, 1),
	itemcode			int					default(50000),

	famelvmin			int					default(500),		-- �ּҷ�.
	famelvmax			int					default(540),	-- �ִ뷾.
	packname			varchar(256)		default(''),

	-- ��Ű������.
	pack1				int					default(-1),
	pack2				int					default(-1),
	pack3				int					default(-1),
	pack4				int					default(-1),
	pack5				int					default(-1),
	pack1cnt			int					default(0),
	pack2cnt			int					default(0),
	pack3cnt			int					default(0),
	pack4cnt			int					default(0),
	pack5cnt			int					default(0),
	packstr				varchar(1024)		default(''),

	cashcostcost		int					default(100),	-- ��Ű�� ����.
	cashcostper			int					default(10),	--        ������.
	cashcostsale		int					default(90),	--        ���ΰ�.

	--�ڸ�Ʈ.
	packstate			int					default(-1),	-- 1:Ȱ��, -1:��Ȱ��.
	comment				varchar(256)		default(''),
	packmarket			varchar(40)			default('1,5,6,7'),
	writedate			datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tFVSystemPack_idx	PRIMARY KEY(idx)
)

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVSystemPack_famelvmin_famelvmax')
	DROP INDEX tFVSystemPack.idx_tFVSystemPack_famelvmin_famelvmax
GO
CREATE INDEX idx_tFVSystemPack_famelvmin_famelvmax ON tFVSystemPack (famelvmin, famelvmax)
GO

-- insert into dbo.tFVSystemPack(itemcode, famelvmin, famelvmax, cashcostcost, cashcostper, cashcostsale, packstate,         packname, comment, pack1, pack2, pack3, pack4, pack5, packstr)
-- values(                          50004,       500,       540,           69,          10,           62,        -1,  '�ٳ��� ��Ű��',  '����', 80214,  3500,  3300,    -1,    -1, '1:80214;2:3500;3:3300;4:-1;5:-1;6:1;7:2;8:3;9:0;10:0;')
-- update dbo.tFVSystemPack
-- 		set
-- 			famelvmin		= 500,
-- 			famelvmax		= 540,
-- 			cashcostcost 	= 69,
-- 			cashcostper		= 10,
-- 			cashcostsale	= 62,
-- 			packstate		= -1,
-- 			packname		= '�ٳ��� ��Ű��',
-- 			comment			= '����',
-- 			pack1	= 80214, pack2	= 3500,	pack3	= 3300,	pack4	= -1,		pack5	= -1,
-- 			pack1cnt= 1,  	pack1cnt= 2,	pack1cnt= 3,	pack1cnt=  0,		pack1cnt=  0,
-- 			packstr = '1:80214;2:3500;3:3300;4:-1;5:-1;6:1;7:2;8:3;9:0;10:0;'
-- where idx = 1
-- select * from dbo.tFVSystemPack order by famelvmin asc, famelvmax asc


------------------------------------------------------------------------------------------------------------------------------------------------
-- ������ ���̺��� ī�װ��� ����.
--delete from dbo.tFVItemInfo where subcategory = 500 and itemcode >= 50004
--
------------------------------------------------------------------------------------------------------------------------------------------------
-- ��Ű����� > ���ο� ������ �ڵ� ������.
--
--                ��ȣ,       �ּҷ���, �ִ뷹��, �ǸŰ�, ���ΰ�, Ȱ������(1),               ��Ű���̸�,  �ڸ�Ʈ, ��Ű����ȣ(10���̻�)
-- exec spu_FVFarmD 30, 12, -1,    500,      504,     69,     10,           1, -1,  -1, '�ٳ��� ��Ű��', '����', '1:80214;2:3500;3:3300;4:-1;5:-1;6:1;7:2;8:3;9:0;10:0;', '', '', '', '', '', '', ''
-- exec spu_FVFarmD 30, 12, -1,    504,      509,     69,     10,           1, -1,  -1, '�ٳ��� ��Ű��', '����', '1:80214;2:3500;3:3300;4:-1;5:-1;6:1;7:2;8:3;9:0;10:0;', '', '', '', '', '', '', ''
------------------------------------------------------------------------------------------------------------------------------------------------


