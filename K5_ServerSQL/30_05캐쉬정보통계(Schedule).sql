/*
--------------------------------------------
-- K5_캐쉬정보통계
-- SQL Server 에이전트(먼저 켜져있어야한다.)
-- 유저 정보를 1일 단위로 백업을 진행한다.
-- 매일 시작 04시 00분 00초에 시작
---------------------------------------------
--use Game4Farmvill5
--GO
--
--select * from dbo.tStaticCashMaster
--select * from dbo.tStaticCashUnique
-- delete from dbo.tStaticCashUnique where dateid = '20140506'

declare @dateid			varchar(8),
		@dateid8		varchar(8),
		@dateid19		varchar(19),
		@market 		int,
		@cash 			int,
		@step 			int

set @dateid		= Convert(varchar(8), Getdate() - 1, 112)
--set @dateid = '20140508'
--set @dateid = '20140408'
--set @dateid = '20140327'
-------------------------------------------
-- 1. 마스터 데이타 검사.
-------------------------------------------
set @step = 0
select @step = step from dbo.tStaticCashMaster where dateid = @dateid
--select 'DEBUG ', @dateid dateid, @step step

if(@step = 0)
	begin
		--select 'DEBUG 마스터 입력', @dateid dateid, @step step
		set @step = 1
		insert into dbo.tStaticCashMaster(dateid,  step)
		values(                          @dateid, @step)
	end

if(@step = 1)
	begin
		--select 'DEBUG 서브 입력', @dateid dateid, @step step
		set @step = 2
		update dbo.tStaticCashMaster set step = @step where @dateid = dateid

		set @dateid8 = @dateid
		set @dateid19= @dateid + ' 23:59:59'
		--select 'DEBUG ', @dateid8 dateid8, @dateid19 dateid19

		insert into dbo.tStaticCashUnique(dateid, market, cash, cnt)
		select @dateid8 dateid, market, cash, COUNT(*) cnt from
		(select distinct Convert(varchar(8),writedate,112) as dateid, market, gameid, cash from dbo.tCashLog where writedate >= @dateid8 and writedate <= @dateid19) d
		group by market, cash order by market asc, cash asc
	end
*/







