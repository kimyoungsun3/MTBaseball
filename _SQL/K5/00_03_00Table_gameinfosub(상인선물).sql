---------------------------------------------
--		거래보상코드
---------------------------------------------
use GameMTBaseball
GO

IF OBJECT_ID (N'dbo.tUserSaleRewardItemCode', N'U') IS NOT NULL
	DROP TABLE dbo.tUserSaleRewardItemCode;
GO

create table dbo.tUserSaleRewardItemCode(
	--(일반정보)
	idx			int 					IDENTITY(1, 1),

	itemcode	int,

	-- Constraint
	CONSTRAINT pk_tUserSaleRewardItemCode_itemcode	PRIMARY KEY(itemcode)
)
GO


-- select * from dbo.tUserSaleRewardItemCode
-- select * from GameMTBaseball.dbo.tUserSaleRewardItemCode
-- 상세 데이타는 다른 곳에서 입력함
--insert into dbo.tUserSaleRewardItemCode(itemcode) values(-1)	-- 빈것.
--insert into dbo.tUserSaleRewardItemCode(itemcode) values(700)	-- 총알.
--insert into dbo.tUserSaleRewardItemCode(itemcode) values(701)
--insert into dbo.tUserSaleRewardItemCode(itemcode) values(800)	-- 백신.
--insert into dbo.tUserSaleRewardItemCode(itemcode) values(801)
--insert into dbo.tUserSaleRewardItemCode(itemcode) values(900)	-- 건초.
--insert into dbo.tUserSaleRewardItemCode(itemcode) values(901)
--insert into dbo.tUserSaleRewardItemCode(itemcode) values(1000)	-- 일꾼.
--insert into dbo.tUserSaleRewardItemCode(itemcode) values(1001)
--insert into dbo.tUserSaleRewardItemCode(itemcode) values(1100)	-- 촉진제
--insert into dbo.tUserSaleRewardItemCode(itemcode) values(1101)
--insert into dbo.tUserSaleRewardItemCode(itemcode) values(2005)	-- 하트.





