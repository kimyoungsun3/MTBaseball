use GameMTBaseball
GO

delete from dbo.tUserSaleRewardItemCode
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = -1))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(-1)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 901))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(901)
	end
GO

