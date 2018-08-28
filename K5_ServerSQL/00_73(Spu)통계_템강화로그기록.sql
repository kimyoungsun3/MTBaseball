/*
--							아이템코드,	캐쉬, 코인, 하트
exec spu_UserItemUpgradeLog 1, 1, 2, 3

select * from dbo.tUserItemUpgradeLogTotalMaster
select * from dbo.tUserItemUpgradeLogTotalSub
select * from dbo.tUserItemUpgradeLogMonth


*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_UserItemUpgradeLog', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_UserItemUpgradeLog;
GO

create procedure dbo.spu_UserItemUpgradeLog
	@itemcode_								int,
	@cashcost_								int,
	@gamecost_								int,
	@heart_									int
	--WITH ENCRYPTION -- 프로시져를 암호화함.
as
	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @dateid8 	varchar(8)		set @dateid8 			= Convert(varchar(8),Getdate(),112)
	declare @dateid6 	varchar(6)		set @dateid6 			= Convert(varchar(6),Getdate(),112)

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	--select 'DEBUG 구매', @itemcode_ itemcode_, @gamecost_ gamecost_, @cashcost_ cashcost_, @heart_ heart_

	------------------------------------------------
	--	3-2-2. 업글 로그(월별 Master)
	------------------------------------------------
	--select 'DEBUG  로그(월별 Master) ', @dateid8 dateid8, @gamecost_ gamecost_, @cashcost_ cashcost_
	if(not exists(select top 1 * from dbo.tUserItemUpgradeLogTotalMaster where dateid8 = @dateid8))
		begin
			--select 'DEBUG > insert'
			insert into dbo.tUserItemUpgradeLogTotalMaster(dateid8,  cashcost,   gamecost,   heart, cnt)
			values(                                       @dateid8, @cashcost_, @gamecost_, @heart_, 1)
		end
	else
		begin
			--select 'DEBUG > update'
			update dbo.tUserItemUpgradeLogTotalMaster
				set
					cashcost	= cashcost + @cashcost_,
					gamecost	= gamecost + @gamecost_,
					heart		= heart + @heart_,
					cnt 		= cnt + 1
			where dateid8 = @dateid8
		end


	------------------------------------------------
	--	3-2-3. 일별로그 > 세부기록
	------------------------------------------------
	--select 'DEBUG 일별로그 > 세부기록', @dateid8 dateid8, @itemcode_ itemcode_, @gamecost_ gamecost_, @cashcost_ cashcost_
	if(not exists(select top 1 * from dbo.tUserItemUpgradeLogTotalSub where dateid8 = @dateid8 and itemcode = @itemcode_))
		begin
			--select 'DEBUG > insert'

			insert into dbo.tUserItemUpgradeLogTotalSub(dateid8,  itemcode,   cashcost,   gamecost,   heart, cnt)
			values(                                    @dateid8, @itemcode_, @cashcost_, @gamecost_, @heart_, 1)
		end
	else
		begin
			--select 'DEBUG > update'

			update dbo.tUserItemUpgradeLogTotalSub
				set
					cashcost 	= cashcost + @cashcost_,
					gamecost 	= gamecost + @gamecost_,
					heart		= heart + @heart_,
					cnt 		= cnt + 1
			where dateid8 = @dateid8 and itemcode = @itemcode_
		end

	------------------------------------------------
	--	3-2-4. 월별(아이템)
	------------------------------------------------
	--select 'DEBUG 월별(아이템)', @dateid6 dateid6, @itemcode_ itemcode_, @gamecost_ gamecost_, @cashcost_ cashcost_
	if(not exists(select top 1 * from dbo.tUserItemUpgradeLogMonth where dateid6 = @dateid6 and itemcode = @itemcode_))
		begin
			--select 'DEBUG 월별(아이템) insert'

			insert into dbo.tUserItemUpgradeLogMonth(dateid6,  itemcode,   cashcost,  gamecost,   heart, cnt)
			values(                                 @dateid6, @itemcode_, @cashcost_, @gamecost_, @heart_, 1)
		end
	else
		begin
			--select 'DEBUG 월별(아이템) update'

			update dbo.tUserItemUpgradeLogMonth
				set
					cashcost 	= cashcost + @cashcost_,
					gamecost 	= gamecost + @gamecost_,
					heart		= heart + @heart_,
					cnt 		= cnt + 1
			where dateid6 = @dateid6 and itemcode = @itemcode_
		end

	------------------------------------------------
	--	4-1. 종류
	------------------------------------------------
	set nocount off
End


