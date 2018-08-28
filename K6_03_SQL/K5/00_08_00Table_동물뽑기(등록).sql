-- ���� ��� �ű� ���� ������Ʈ
-- 		����� �ű� ���� �߰� ���� Ȯ�� ��� �̺�Ʈ �غ�
-- 		�ű� ��Ű�� �غ�
-- 		�ű� ����/�̺�Ʈ ��� �غ�
-- 		���� �̽� : ������Ʈ ����
--		00_09Table_roul(2������).sql
-- 		������ Ȧ���ϴ� ��ƾ ������.
--
-- 0. 2������ ������Ʈ(�Ϸ�)
--
-- 1. 2������ ��Ȱ��ȭ(�Ϸ�)
-- update dbo.tSystemRoulette set packstate = -1 where packstate = 1 and packname     like '%(2������)'	-- �ű� ��Ȱ��ȭ.
-- update dbo.tSystemRoulette set packstate =  0 where famelvmin = 999
--
-- 2. ���Ͽ��� Ư�� ������ ���������� �����ϱ�. (�ݿ�)
--	16 -> 13
--	115 -> 113
--	215 -> 212
--  (14_02����̱�(¥��2������).sql)
--
-- 3. 2�� ���� Ȱ��ȭ, ���� ���� ��Ȱ��ȭ.(�ݿ�)
-- update dbo.tSystemRoulette set packstate =  1 where packstate = -1 and packname     like '%(2������)'	-- �ű� ��Ȱ��ȭ.
-- update dbo.tSystemRoulette set packstate = -1 where packstate =  1 and packname not like '%(2������)'	-- ���� ���� ��Ȱ��ȭ.

---------------------------------------------
-- ����̱� ����.
---------------------------------------------
use GameMTBaseball
GO

IF OBJECT_ID (N'dbo.tSystemRoulette', N'U') IS NOT NULL
	DROP TABLE dbo.tSystemRoulette;
GO

create table dbo.tSystemRoulette(
	idx					int 				IDENTITY(1, 1),
	itemcode			int					default(60000),

	famelvmin			int					default(1),		-- �ּҷ�.
	famelvmax			int					default(50),	-- �ִ뷾.
	packname			varchar(1024)		default(''),

	-- ����̱�����.
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

	cashcostcost		int					default(100),	-- ����̱� ����.
	cashcostper			int					default(10),	--        ������.
	cashcostsale		int					default(90),	--        ���ΰ�.
	gamecost			int					default(0),		-- �Ϲ��Ǹ�(����)
	heart				int					default(0),		-- ��Ʈ

	--�ڸ�Ʈ.
	packstate			int					default(-1),	-- 1:Ȱ��, -1:��Ȱ��.
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
-- values(                         60004,    1,         10,        69,           10,          62,           -1,        '�� A��� ����̱�', '����',  1,     2,     3,     4,     5,     6,     7,     8,     9,     10,     11,     12,     13,     14,     15,     16,     17,     18,     19,     20,     '1:2;2:2;3:3;4:4;5:5;6:6;7:7;8:8;9:9;10:10;11:11;12:12;13:13;14:14;15:15;16:101;17:102;18:103;19:104;20:105')
-- update dbo.tSystemRoulette
-- 		set
-- 			famelvmin	= 1,
-- 			famelvmax	= 10,
-- 			cashcostcost 	= 69,
-- 			cashcostper		= 10,
-- 			cashcostsale	= 62,
-- 			packstate	= -1,
-- 			packname	= '�� A��� ����̱�',
-- 			comment		= '����',
-- 			pack1	= 1,   	pack2	= 2,	pack3	= 3,	pack4	= 4,		pack5	= 5,
-- 			pack6	= 6,  	pack7	= 7,	pack8	= 8,	pack9	= 9,		pack10	= 10,
-- 			pack11	= 11,  	pack12	= 12,	pack13	= 13,	pack14	= 14,		pack15	= 15,
-- 			pack16	= 101,  pack17	= 102,	pack18	= 103,	pack19	= 104,		pack20	= 105,
-- 			packstr = '1:2;2:2;3:3;4:4;5:5;6:6;7:7;8:8;9:9;10:10;11:11;12:12;13:13;14:14;15:15;16:101;17:102;18:103;19:104;20:105'
-- where idx = 1
-- select * from dbo.tSystemRoulette order by famelvmin asc, famelvmax asc

------------------------------------------------------------------------------------------------------------------------------------------------
-- ����̱��� > ���ο� ������ �ڵ� ������.
--
--                       ��ȣ,  �ּҷ���, �ִ뷹��, �ǸŰ�, ���ΰ�, Ȱ������(1),          ����̱��̸�,        �ڸ�Ʈ, ����̱��ȣ
-- exec spu_GameMTBaseballD 30, 22, -1,     1,        50,       69,     10,     1,         1000,   50, '�� 1��� ����̱�', '����', '1:1;2:2;3:3;4:4;5:5;6:6;7:7;8:8;9:9;10:10;11:11;12:12;13:13;14:14;15:15;16:101;17:102;18:103;19:104;20:105', '', '', '', '', '', '', ''
-- exec spu_GameMTBaseballD 30, 22, -1,    10,        50,       69,     10,     1,         1000,  100, '�� 2��� ����̱�', '����', '1:2;2:2;3:3;4:4;5:5;6:6;7:7;8:8;9:9;10:10;11:11;12:12;13:13;14:14;15:15;16:101;17:102;18:103;19:104;20:105', '', '', '', '', '', '', ''
-- exec spu_GameMTBaseballD 30, 22, -1,    20,        50,       69,     10,     1,         1000,  150, '�� 3��� ����̱�', '����', '1:3;2:2;3:3;4:4;5:5;6:6;7:7;8:8;9:9;10:10;11:11;12:12;13:13;14:14;15:15;16:101;17:102;18:103;19:104;20:105', '', '', '', '', '', '', ''
-- exec spu_GameMTBaseballD 30, 22, -1,    30,        50,       69,     10,     1,         1000,  200, '�� 4��� ����̱�', '����', '1:4;2:2;3:3;4:4;5:5;6:6;7:7;8:8;9:9;10:10;11:11;12:12;13:13;14:14;15:15;16:101;17:102;18:103;19:104;20:105', '', '', '', '', '', '', ''
-- exec spu_GameMTBaseballD 30, 22, -1,    40,        50,       69,     10,     1,         1000,  200, '�� 5��� ����̱�', '����', '1:5;2:2;3:3;4:4;5:5;6:6;7:7;8:8;9:9;10:10;11:11;12:12;13:13;14:14;15:15;16:101;17:102;18:103;19:104;20:105', '', '', '', '', '', '', ''
------------------------------------------------------------------------------------------------------------------------------------------------
