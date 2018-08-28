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

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 5119))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(5119)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 5101))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(5101)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 5111))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(5111)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 5102))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(5102)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 5121))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(5121)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 5103))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(5103)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 5113))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(5113)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 5104))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(5104)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 5123))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(5123)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 5124))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(5124)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 5128))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(5128)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 2011))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(2011)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 2012))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(2012)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 2005))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(2005)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 2013))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(2013)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 2014))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(2014)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 2015))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(2015)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 2000))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(2000)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 2200))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(2200)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 2201))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(2201)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 2500))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(2500)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 2100))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(2100)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 1200))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(1200)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 1201))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(1201)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 1100))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(1100)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 1101))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(1101)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 1102))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(1102)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 1103))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(1103)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 1104))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(1104)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 1000))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(1000)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 1001))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(1001)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 1002))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(1002)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 1003))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(1003)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 800))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(800)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 801))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(801)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 802))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(802)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 803))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(803)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 700))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(700)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 701))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(701)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 702))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(702)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 703))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(703)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 905))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(905)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 900))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(900)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 908))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(908)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 910))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(910)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 913))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(913)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 5104))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(5104)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 5123))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(5123)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 5124))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(5124)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 5128))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(5128)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 2013))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(2013)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 2014))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(2014)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 2015))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(2015)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 2000))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(2000)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 2200))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(2200)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 2500))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(2500)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 2201))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(2201)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 2100))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(2100)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 1200))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(1200)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 1201))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(1201)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 1102))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(1102)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 1103))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(1103)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 1104))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(1104)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 1001))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(1001)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 1002))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(1002)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 1003))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(1003)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 801))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(801)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 802))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(802)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 803))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(803)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 701))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(701)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 702))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(702)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 703))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(703)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 908))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(908)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 910))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(910)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 911))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(911)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 912))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(912)
	end
GO

if(not exists(select top 1 * from dbo.tUserSaleRewardItemCode where itemcode = 913))
	begin
		insert into dbo.tUserSaleRewardItemCode(itemcode) values(913)
	end
GO

