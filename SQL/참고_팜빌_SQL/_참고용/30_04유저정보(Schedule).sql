/*
-- use Farm
-- GO
--
-- delete from dbo.tFVStaticMaster where dateid = '20140404'
-- delete from dbo.tFVStaticSubFameLV where dateid = '20140404'
-- delete from dbo.tFVStaticSubMarket where dateid = '20140404'


--------------------------------------------
-- SQL Server ������Ʈ(���� �����־���Ѵ�.)
-- ���� ������ 1�� ������ ����� �����Ѵ�.
-- ���ֿ����� ���� 04�� 00�� 00�ʿ� ����
---------------------------------------------
declare @dateid			varchar(8),
		@step 			int,
		@famelv 		int,
		@market 		int,
		@cnt 			int

set @dateid		= Convert(varchar(8), Getdate(), 112)
set @step 		= 0

-------------------------------------------
-- 1. ������ ����Ÿ �˻�.
-------------------------------------------
select @step = isnull(step, 0) from dbo.tFVStaticMaster where dateid = @dateid


if(@step = 0)
	begin
		insert into dbo.tFVStaticMaster(dateid, step) values(@dateid, 1)

		-- 1. ģ�� ��ŷ Ŀ���� �о����.
		declare curUserMaster Cursor for
		select famelv, count(*) cnt from dbo.tFVUserMaster where kakaostatus = 1 group by famelv

		-- 2. Ŀ������
		open curUserMaster

		-- 3. Ŀ�� ���
		Fetch next from curUserMaster into @famelv, @cnt
		while @@Fetch_status = 0
			Begin
				if(not exists(select top 1 dateid from dbo.tFVStaticSubFameLV where dateid = @dateid and famelv = @famelv))
					begin
						insert into dbo.tFVStaticSubFameLV(dateid, famelv, cnt)
						values(@dateid, @famelv, @cnt)
					end
				else
					begin
						update dbo.tFVStaticSubFameLV
							set
								cnt = @cnt
						where dateid = @dateid and famelv = @famelv
					end
				Fetch next from curUserMaster into @famelv, @cnt
			end

		set @step = 1
		update dbo.tFVStaticMaster set step = @step where dateid = @dateid

		-- 4. Ŀ���ݱ�
		close curUserMaster
		Deallocate curUserMaster
	end

if(@step = 1)
	begin
		-- 1. ģ�� ��ŷ Ŀ���� �о����.
		declare curUserMaster2 Cursor for
		select market, count(*) cnt from dbo.tFVUserMaster where kakaostatus = 1 group by market

		-- 2. Ŀ������
		open curUserMaster2

		-- 3. Ŀ�� ���
		Fetch next from curUserMaster2 into @market, @cnt
		while @@Fetch_status = 0
			Begin
				if(not exists(select dateid from dbo.tFVStaticSubMarket where dateid = @dateid and market = @market))
					begin
						insert into dbo.tFVStaticSubMarket(dateid, market, cnt)
						values(@dateid, @market, @cnt)
					end
				else
					begin
						update dbo.tFVStaticSubMarket
							set
								cnt = @cnt
						where dateid = @dateid and market = @market
					end
				Fetch next from curUserMaster2 into @market, @cnt
			end

		set @step = 2
		update dbo.tFVStaticMaster set step = @step where dateid = @dateid

		-- 4. Ŀ���ݱ�
		close curUserMaster2
		Deallocate curUserMaster2
	end
*/







