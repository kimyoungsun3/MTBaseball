
---------------------------------------------
-- ¥��������������.
---------------------------------------------
use GameMTBaseball
GO

IF OBJECT_ID (N'dbo.tSystemZCPInfo', N'U') IS NOT NULL
	DROP TABLE dbo.tSystemZCPInfo;
GO

create table dbo.tSystemZCPInfo(
	idx					int 				IDENTITY(1, 1),

	kind				int,									--
	itemcode			int,
	cnt					int,
	randvalfree			int,									-- ���ᶧ Ȯ��.
	randvalcash			int,									-- ���ᶧ Ȯ��.

	adlog				int,
	-- Constraint
	CONSTRAINT	pk_tSystemZCPInfo_idx	PRIMARY KEY(idx)
)


-- ���Ἴ�� (1�� 1ȸ).
insert into tSystemZCPInfo(kind, itemcode, cnt, randvalfree, randvalcash, adlog)	values(0, 3800, 1, 8000,    0, 0)	-- �����(5000)
insert into tSystemZCPInfo(kind, itemcode, cnt, randvalfree, randvalcash, adlog)	values(0, 3800, 2, 1500,    0, 0)
insert into tSystemZCPInfo(kind, itemcode, cnt, randvalfree, randvalcash, adlog)	values(0, 3800, 3,  400,    0, 0)
insert into tSystemZCPInfo(kind, itemcode, cnt, randvalfree, randvalcash, adlog)	values(0, 3800, 5,   64,    0, 0)

insert into tSystemZCPInfo(kind, itemcode, cnt, randvalfree, randvalcash, adlog)	values(0, 3800, 10,  20, 4000, 0)	-- ��Ʈ����(2000)
insert into tSystemZCPInfo(kind, itemcode, cnt, randvalfree, randvalcash, adlog)	values(0, 3800, 20,  10, 5300, 0)
insert into tSystemZCPInfo(kind, itemcode, cnt, randvalfree, randvalcash, adlog)	values(0, 3800, 50,   5,  500, 1)
insert into tSystemZCPInfo(kind, itemcode, cnt, randvalfree, randvalcash, adlog)	values(0, 3800, 99,   1,  200, 1)

-- ¥���������� (3800)
-- select top 8 * from dbo.tSystemZCPInfo where kind = 0 order by idx desc
