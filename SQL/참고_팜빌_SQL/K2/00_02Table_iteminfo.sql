---------------------------------------------
--		������ ����
---------------------------------------------
use Farm
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
	equpslot		int, 								-- ���� ����
	itemname		varchar(40), 						-- ������ �̸�
	activate		int, 								-- ��� ����
	toplist			int, 								-- ��ܰԽ�
	grade			int, 								-- ���
	discount		int, 								-- ���Ͽ���
	icon			varchar(40), 						-- ������
	playerlv		int, 								-- �䱸 ������
	houselv			int, 								-- �䱸 ���� ����
	gamecost		int, 								-- ���ΰ���
	cashcost		int, 								-- ĳ�ð���
	buyamount		int, 								-- 1ȸ���ż���
	sellcost		int, 								-- �Ǹ�
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

