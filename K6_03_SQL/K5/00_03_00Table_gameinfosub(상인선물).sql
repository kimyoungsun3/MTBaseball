---------------------------------------------
--		�ŷ������ڵ�
---------------------------------------------
use GameMTBaseball
GO

IF OBJECT_ID (N'dbo.tUserSaleRewardItemCode', N'U') IS NOT NULL
	DROP TABLE dbo.tUserSaleRewardItemCode;
GO

create table dbo.tUserSaleRewardItemCode(
	--(�Ϲ�����)
	idx			int 					IDENTITY(1, 1),

	itemcode	int,

	-- Constraint
	CONSTRAINT pk_tUserSaleRewardItemCode_itemcode	PRIMARY KEY(itemcode)
)
GO


-- select * from dbo.tUserSaleRewardItemCode
-- select * from GameMTBaseball.dbo.tUserSaleRewardItemCode
-- �� ����Ÿ�� �ٸ� ������ �Է���
--insert into dbo.tUserSaleRewardItemCode(itemcode) values(-1)	-- ���.
--insert into dbo.tUserSaleRewardItemCode(itemcode) values(700)	-- �Ѿ�.
--insert into dbo.tUserSaleRewardItemCode(itemcode) values(701)
--insert into dbo.tUserSaleRewardItemCode(itemcode) values(800)	-- ���.
--insert into dbo.tUserSaleRewardItemCode(itemcode) values(801)
--insert into dbo.tUserSaleRewardItemCode(itemcode) values(900)	-- ����.
--insert into dbo.tUserSaleRewardItemCode(itemcode) values(901)
--insert into dbo.tUserSaleRewardItemCode(itemcode) values(1000)	-- �ϲ�.
--insert into dbo.tUserSaleRewardItemCode(itemcode) values(1001)
--insert into dbo.tUserSaleRewardItemCode(itemcode) values(1100)	-- ������
--insert into dbo.tUserSaleRewardItemCode(itemcode) values(1101)
--insert into dbo.tUserSaleRewardItemCode(itemcode) values(2005)	-- ��Ʈ.





