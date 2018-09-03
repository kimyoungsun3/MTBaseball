/*
---------------------------------------------
-- �����ݸ�Ʈ.
---------------------------------------------
use GameMTBaseball
GO

IF OBJECT_ID (N'dbo.tSystemWheelInfo', N'U') IS NOT NULL
	DROP TABLE dbo.tSystemWheelInfo;
GO

create table dbo.tSystemWheelInfo(
	idx					int 				IDENTITY(1, 1),

	kind				int,									-- ����(20), ����(21)
	itemcode			int,
	cnt					int,
	randval				int,

	adlog				int,									-- ������(0), ����(1)
	-- Constraint
	CONSTRAINT	pk_tSystemWheelInfo_idx	PRIMARY KEY(idx)
)


-- ���Ἴ�� (1�� 1ȸ).
insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(20, 5000, 5,   1500, 0)	-- �����(5000)
insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(20, 5000, 20,  2000, 0)
insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(20, 5000, 5,   1500, 0)
insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(20, 5000, 200,   50, 0)

insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(20, 2000, 5,   1500, 0)	-- ��Ʈ����(2000)
insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(20, 2000, 20,  2000, 0)
insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(20, 2000, 5,   1500, 0)
insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(20, 2000, 200,   50, 0)

-- 1�� ���Ἴ�� (300���).
--insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 2000, 300,  2000, 0)	-- ��Ʈ(2000)x1
--insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 5000, 3000,    2, 1)	-- ����� (5000)
--insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 5100, 6000, 2000, 0)	-- ����(5100)x2
--insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 1002, 30,    400, 0)	-- �˹��Ǳ���(1002)x1.5
--insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 3500, 200,   120, 1)	-- �ռ�������(3500)
--insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 2300, 6,      20, 1)	-- �����̾� ����Ƽ��(2300)
--insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 5100, 12000, 700, 1)	-- ����(5100)x4
--insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 3600, 200,   120, 1)	-- �±��ǲ�(3600)

-- �ŷ��� ��Ʋ ������ > ��ƲƼ�ϰ� Ȳ��Ƽ��
-- 2�� ���Ἴ�� (300���).
-- select * from dbo.tSystemWheelInfo where kind = 21
-- delete from dbo.tSystemWheelInfo where kind = 21
--insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 2600, 2,     500, 1)	-- �����̾� ����Ƽ��(2600)
--insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 5000, 3000,    2, 1)	-- ����� (5000)
--insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 3000, 330,   600, 0)	-- Ȳ��Ƽ��(3000)
--insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 3100, 330,  1000, 0)	-- ��ƲƼ��(3100)
--insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 3500, 200,   140, 1)	-- �ռ�������(3500)
--insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 2300, 6,      20, 1)	-- �����̾� ����Ƽ��(2300)
--insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 5100, 20000, 700, 1)	-- ����(5100)x4
--insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 3600, 200,   140, 1)	-- �±��ǲ�(3600)

--select top 8 * from dbo.tSystemWheelInfo where kind = 20
--select top 8 * from dbo.tSystemWheelInfo where kind = 21


-- �±ް� �ռ��� > ���������οð��� �뵵.
-- 5.20 3�� ���Ἴ�� (300���).
-- select * from dbo.tSystemWheelInfo where kind = 21
-- delete from dbo.tSystemWheelInfo where kind = 21
--insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 2600, 2,    1000, 1)	-- �����̾� ����Ƽ��(2600)
--insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 5000, 3000,    2, 1)	-- ����� (5000)
--insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 3703, 1,     200, 1)	-- ���̾�Ʈ�ڽ�(3703)
--insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 1002, 45,   1000, 0)	-- �˹��Ǳ���(1002)
--insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 3704, 1,     140, 1)	-- �����ڽ�(3704)
--insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 1900, 1000, 1000, 1)	-- ��������Ʈ(1900)
--insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 5100, 20000,1000, 1)	-- ����(5100)x4
--insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 3705, 1,      80, 1)	-- ���۸����ڽ�(3705)


-- �ŷ��� ��Ʋ ������ > ��ƲƼ�ϰ� Ȳ��Ƽ��
-- 4�� ���Ἴ�� (300���).
-- select * from dbo.tSystemWheelInfo where kind = 21
-- delete from dbo.tSystemWheelInfo where kind = 21
insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 2600, 2,    1000, 0)	-- �����̾� ����Ƽ��(2600)
insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 5000, 3000,    2, 1)	-- ����� (5000)
insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 3000, 250,   400, 0)	-- Ȳ��Ƽ��(3000)
insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 3100, 250,   400, 0)	-- ��ƲƼ��(3100)
insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 3500, 200,   140, 1)	-- �ռ�������(3500)
insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 2300, 2,    1200, 0)	-- �����̾� ����Ƽ��(2300)
insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 5100, 25000,1000, 1)	-- ����(5100)x4
insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 3600, 200,   140, 1)	-- �±��ǲ�(3600)

-- ����� (5000)
-- ��Ʈ(2000)
-- ����(5100)

-- �˹��Ǳ���(1002)
-- Ư��������(1103)
-- Ư��ź(703)
-- ��Ȱ��(1200)					1�� 20���
-- ��޿�û(2100)				1�� 20���

-- �����̾� ����Ƽ��(2300)		1�� 300���
-- �����̾� ����Ƽ��(2600)		1�� 300���
-- Ȳ��Ƽ��(3000)
-- ��ƲƼ��(3100)

-- �ռ�������(3500)
-- �±��ǲ�(3600)

-- ���̾�Ʈ�ڽ�(3703)
-- �����ڽ�(3704)
-- ���۸����ڽ�(3705)

-- ��������Ʈ(1900)				300��� -> 1ȸ 80���, 4�� (320����) -> 2��� 1000����
-- VIP����Ʈ(
*/