
---------------------------------------------
-- ��Ű�� ����.
---------------------------------------------
use GameMTBaseball
GO

IF OBJECT_ID (N'dbo.tSystemPack', N'U') IS NOT NULL
	DROP TABLE dbo.tSystemPack;
GO

create table dbo.tSystemPack(
	idx					int 				IDENTITY(1, 1),
	itemcode			int					default(50000),

	famelvmin			int					default(1),		-- �ּҷ�.
	famelvmax			int					default(50),	-- �ִ뷾.
	packname			varchar(256)		default(''),

	-- ��Ű������.
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

	cashcostcost		int					default(100),	-- ��Ű�� ����.
	cashcostper			int					default(10),	--        ������.
	cashcostsale		int					default(90),	--        ���ΰ�.

	--�ڸ�Ʈ.
	packstate			int					default(-1),	-- 1:Ȱ��, -1:��Ȱ��.
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
-- values(                     50004,    1,         10,        69,           10,          62,               -1,        '�� A��� ��Ű��', '����',  1,     2,     3,     904,   1200, -1,     -1,    -1,    -1,    -1,     -1,     -1,     -1,     -1,     -1,     -1,     -1,     -1,     -1,     -1,     '1:1;2:2;3:3;4:904;5:1200;6:-1;7:-1;8:-1;9:-1;10:-1;11:-1;12:-1;13:-1;14:-1;15:-1;16:-1;17:-1;18:-1;19:-1;20:-1')
-- update dbo.tSystemPack
-- 		set
-- 			famelvmin	= 1,
-- 			famelvmax	= 10,
-- 			cashcostcost 	= 69,
-- 			cashcostper		= 10,
-- 			cashcostsale	= 62,
-- 			packstate	= -1,
-- 			packname	= '�� A��� ��Ű��',
-- 			comment		= '����',
-- 			pack1	= 1,   	pack2	= 2,	pack3	= 3,	pack4	= 904,		pack5	= 1200,
-- 			pack6	= -1,  	pack7	= -1,	pack8	= -1,	pack9	= -1,		pack10	= -1,
-- 			pack11	= -1,  	pack12	= -1,	pack13	= -1,	pack14	= -1,		pack15	= -1,
-- 			pack16	= -1,  	pack17	= -1,	pack18	= -1,	pack19	= -1,		pack20	= -1,
-- 			packstr = '1:1;2:2;3:3;4:904;5:1200;'
-- where idx = 1
-- select * from dbo.tSystemPack order by famelvmin asc, famelvmax asc


------------------------------------------------------------------------------------------------------------------------------------------------
-- ������ ���̺��� ī�װ��� ����.
--delete from dbo.tItemInfo where subcategory = 500 and itemcode >= 50004
--
------------------------------------------------------------------------------------------------------------------------------------------------
-- ��Ű����� > ���ο� ������ �ڵ� ������.
--
--                       ��ȣ,  �ּҷ���, �ִ뷹��, �ǸŰ�, ���ΰ�, Ȱ������(1),          ��Ű���̸�,        �ڸ�Ʈ, ��Ű����ȣ(10���̻�)
-- exec spu_GameMTBaseballD 30, 12, -1,     1,        50,       69,     10,     1,          -1,  -1, '�� 1��� ��Ű��', '����', '1:1;2:2;3:3;4:904;5:1200;', '', '', '', '', '', '', ''
-- exec spu_GameMTBaseballD 30, 12, -1,    10,        50,       69,     10,     1,          -1,  -1, '�� 2��� ��Ű��', '����', '1:2;2:2;3:3;4:904;5:1200;', '', '', '', '', '', '', ''
-- exec spu_GameMTBaseballD 30, 12, -1,    20,        50,       69,     10,     1,          -1,  -1, '�� 3��� ��Ű��', '����', '1:3;2:2;3:3;4:904;5:1200;', '', '', '', '', '', '', ''
-- exec spu_GameMTBaseballD 30, 12, -1,    30,        50,       69,     10,     1,          -1,  -1, '�� 4��� ��Ű��', '����', '1:4;2:2;3:3;4:904;5:1200;', '', '', '', '', '', '', ''
-- exec spu_GameMTBaseballD 30, 12, -1,    40,        50,       69,     10,     1,          -1,  -1, '�� 5��� ��Ű��', '����', '1:5;2:2;3:3;4:904;5:1200;', '', '', '', '', '', '', ''
------------------------------------------------------------------------------------------------------------------------------------------------


