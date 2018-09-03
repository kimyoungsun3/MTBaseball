---------------------------------------------
--		������ ����
---------------------------------------------
use Game4FarmVill3
GO

IF OBJECT_ID (N'dbo.tFVItemInfo', N'U') IS NOT NULL
	DROP TABLE dbo.tFVItemInfo;
GO

create table dbo.tFVItemInfo(
	idx				int				IDENTITY(1,1), 		-- ��ȣ

	labelname		varchar(40), 						-- ���̺�

	itemcode		int, 								-- ������ �ڵ�
	category		int,								-- ī�װ�
	subcategory		int, 								-- ���� ī�װ�
	equpslot		int				default(0), 		-- ���� ����
	itemname		varchar(40), 						-- ������ �̸�
	activate		int				default(0), 		-- ��� ����
	toplist			int				default(0), 		-- ��ܰԽ�
	grade			int				default(0), 		-- ���
	discount		int				default(0),			-- ���Ͽ���
	icon			varchar(40)		default('0'), 		-- ������
	playerlv		int				default(0), 		-- �䱸 ������
	houselv			int				default(0), 		-- �䱸 ���� ����
	gamecost		int				default(0), 		-- ���ΰ���
	cashcost		int				default(0), 		-- ĳ�ð���
	buyamount		int				default(0), 		-- 1ȸ���ż���
	sellcost		int				default(0), 		-- �Ǹ�
	description		varchar(256), 						--

	param1			int				default(-999),
	param2			int				default(-999),
	param3			varchar(40)		default(-999),
	param4			varchar(40)		default(-999),
	param5			varchar(40)		default(-999),
	param6			varchar(40)		default(-999),
	param7			varchar(40)		default(-999),
	param8			varchar(40)		default(-999),
	param9			varchar(40)		default(-999),
	param10			varchar(40)		default(-999),
	param11			varchar(40)		default(-999),
	param12			varchar(40)		default(-999),
	param13			varchar(40)		default(-999),
	param14			varchar(40)		default(-999),
	param15			varchar(40)		default(-999),

	param16			varchar(40)		default(-999),
	param17			varchar(40)		default(-999),
	param18			varchar(40)		default(-999),
	param19			varchar(40)		default(-999),
	param20			varchar(40)		default(-999),

	-- Constraint
	CONSTRAINT	pk_tFVItemInfo_itemcode	PRIMARY KEY(itemcode)
)
-- select * from dbo.tFVItemInfo where kind in (2, 4, 5, 6, 7, 8 , 9, 100, 80, 90) order by itemcode asc

