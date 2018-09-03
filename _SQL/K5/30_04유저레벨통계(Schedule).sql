/*
--------------------------------------------
-- K5_유저레벨통계
-- SQL Server 에이전트(먼저 켜져있어야한다.)
-- 매주월요일 시작 04시 00분 00초에 시작
---------------------------------------------
-- use GameMTBaseball
-- GO
--
-- delete from dbo.tStaticMaster where dateid = '20140404'
-- delete from dbo.tStaticSubFameLV where dateid = '20140404'
-- delete from dbo.tStaticSubMarket where dateid = '20140404'


declare @dateid			varchar(8),
		@step 			int,
		@famelv 		int,
		@market 		int,
		@cnt 			int

set @dateid		= Convert(varchar(8), Getdate(), 112)
set @step 		= 0

-------------------------------------------
-- 1. 마스터 데이타 검사.
-------------------------------------------
select @step = isnull(step, 0) from dbo.tStaticMaster where dateid = @dateid


if(@step = 0)
	begin
		insert into dbo.tStaticMaster(dateid, step) values(@dateid, 1)

		-- 1. 친구 랭킹 커서로 읽어오기.
		declare curUserMaster Cursor for
		select famelv, count(*) cnt from dbo.tUserMaster where kakaostatus = 1 group by famelv

		-- 2. 커서오픈
		open curUserMaster

		-- 3. 커서 사용
		Fetch next from curUserMaster into @famelv, @cnt
		while @@Fetch_status = 0
			Begin
				if(not exists(select top 1 dateid from dbo.tStaticSubFameLV where dateid = @dateid and famelv = @famelv))
					begin
						insert into dbo.tStaticSubFameLV(dateid, famelv, cnt)
						values(@dateid, @famelv, @cnt)
					end
				else
					begin
						update dbo.tStaticSubFameLV
							set
								cnt = @cnt
						where dateid = @dateid and famelv = @famelv
					end
				Fetch next from curUserMaster into @famelv, @cnt
			end

		set @step = 1
		update dbo.tStaticMaster set step = @step where dateid = @dateid

		-- 4. 커서닫기
		close curUserMaster
		Deallocate curUserMaster
	end

if(@step = 1)
	begin
		-- 1. 친구 랭킹 커서로 읽어오기.
		declare curUserMaster2 Cursor for
		select market, count(*) cnt from dbo.tUserMaster where kakaostatus = 1 group by market

		-- 2. 커서오픈
		open curUserMaster2

		-- 3. 커서 사용
		Fetch next from curUserMaster2 into @market, @cnt
		while @@Fetch_status = 0
			Begin
				if(not exists(select dateid from dbo.tStaticSubMarket where dateid = @dateid and market = @market))
					begin
						insert into dbo.tStaticSubMarket(dateid, market, cnt)
						values(@dateid, @market, @cnt)
					end
				else
					begin
						update dbo.tStaticSubMarket
							set
								cnt = @cnt
						where dateid = @dateid and market = @market
					end
				Fetch next from curUserMaster2 into @market, @cnt
			end

		set @step = 2
		update dbo.tStaticMaster set step = @step where dateid = @dateid

		-- 4. 커서닫기
		close curUserMaster2
		Deallocate curUserMaster2
	end
*/







