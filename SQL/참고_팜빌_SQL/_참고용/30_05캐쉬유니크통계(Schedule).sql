/*
--use Farm
--GO
--
--select * from dbo.tFVStaticCashMaster
--select * from dbo.tFVStaticCashUnique
-- delete from dbo.tFVStaticCashUnique where dateid = '20140506'

--------------------------------------------
-- SQL Server ������Ʈ(���� �����־���Ѵ�.)
-- ���� ������ 1�� ������ ����� �����Ѵ�.
-- ���� ���� 04�� 00�� 00�ʿ� ����
---------------------------------------------
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
-- 1. ������ ����Ÿ �˻�.
-------------------------------------------
set @step = 0
select @step = step from dbo.tFVStaticCashMaster where dateid = @dateid
--select 'DEBUG ', @dateid dateid, @step step

if(@step = 0)
	begin
		--select 'DEBUG ������ �Է�', @dateid dateid, @step step
		set @step = 1
		insert into dbo.tFVStaticCashMaster(dateid,  step)
		values(                          @dateid, @step)
	end

if(@step = 1)
	begin
		--select 'DEBUG ���� �Է�', @dateid dateid, @step step
		set @step = 2
		update dbo.tFVStaticCashMaster set step = @step where @dateid = dateid

		set @dateid8 = @dateid
		set @dateid19= @dateid + ' 23:59:59'
		--select 'DEBUG ', @dateid8 dateid8, @dateid19 dateid19

		insert into dbo.tFVStaticCashUnique(dateid, market, cash, cnt)
		select @dateid8 dateid, market, cash, COUNT(*) cnt from
		(select distinct Convert(varchar(8),writedate,112) as dateid, market, gameid, cash from dbo.tFVCashLog where writedate >= @dateid8 and writedate <= @dateid19) d
		group by market, cash order by market asc, cash asc
	end
*/







