---------------------------------------------
--		������ ����
---------------------------------------------
IF OBJECT_ID (N'dbo.tItemInfo', N'U') IS NOT NULL
	DROP TABLE dbo.tItemInfo;
GO

create table dbo.tItemInfo(
	idx				int				IDENTITY(1,1), 		-- ��ȣ		
	labelname		varchar(40), 						-- ���̺�		
	itemcode		int, 								-- �ڵ�
	lv				int				default(0),			-- ����
	itemname		varchar(256), 						-- �������̸�		
	sex				int, 								-- ����		
	kind			int, 								-- ��з�			
	setcode			int, 								-- ��Ʈī�װ�		
	active			int, 								-- 
	itemfilename	varchar(20), 						-- �����̸�		
	pluspower		int, 								-- pluspower
	sale			int				default(0), 		-- �����ϱ�		
	backicon		int				default(0), 		-- �������
	iconindex		int, 								-- ������		
	param1			varchar(20)		default(0),
	param2			varchar(20)		default(0),
	param3			varchar(20)		default(0),
	param4			varchar(20)		default(0),
	param5			varchar(20)		default(0),
	param6			varchar(20)		default(0),
	param7			varchar(20)		default(0),
	param8			varchar(20)		default(0),
	param9			varchar(20)		default(0),
	silverball		int				default(0),			
	goldball		int				default(0),				
	period			int				default(-1), 		-- �Ⱓ
	explain			varchar(512), 						-- ����
	 
	-- Constraint
	CONSTRAINT	pk_tItemInfo_itemcode	PRIMARY KEY(itemcode)	
) 
-- ��������Ʈ(ĳ��������, �ڵ�Ŭ�����͵���)
-- ĳ���� ��������(���� ���� ����.), Ŀ���͸���¡ ��������(�����Է��ϹǷ� �����Ұ�)
-- select * from dbo.tItemInfo where kind in (2, 4, 5, 6, 7, 8 , 9, 100, 80, 90) order by itemcode asc
-- select * from dbo.tItemInfo where kind in (60) order by itemcode asc
-- select * from dbo.tItemInfo order by itemcode asc
-- select * from dbo.tItemInfo where itemcode = 1 order by itemcode asc
/*
-- Ȳ�ݷ귿
select * from dbo.tItemInfo 
where kind = 6
and goldball > 0 and goldball < 500
and sex = 255
and itemcode not in (
153, 154, 156, 157, 161, 162, 163, 164,
253, 254, 256, 257, 261, 262, 263, 264,
353, 354, 356, 357, 361, 362, 363, 364, 
455, 456, 457, 458, 459, 460, 461, 462)

-- �Ϲݷ귿
select * from dbo.tItemInfo 
where kind = 6
and silverball > 0 and silverball < (2000 + 50000)
and sex = 255
and itemcode not in (
153, 154, 156, 157, 161, 162, 163, 164,
253, 254, 256, 257, 261, 262, 263, 264,
353, 354, 356, 357, 361, 362, 363, 364, 
455, 456, 457, 458, 459, 460, 461, 462)

-- �̼�����
select * from dbo.tItemInfo 
where ((kind in (2, 4, 5) and sex != 0) or (sex = 255 and kind = 6))
and silverball > 0 and silverball < 50000
and itemcode not in (
153, 154, 156, 157, 161, 162, 163, 164,
253, 254, 256, 257, 261, 262, 263, 264,
353, 354, 356, 357, 361, 362, 363, 364, 
455, 456, 457, 458, 459, 460, 461, 462)



*/