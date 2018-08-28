use Game4Farmvill5
GO

-- 개수를 치트한 경우. > 100이상 , 0개 미만
--select * from dbo.tUserItemBuyLog where gameid = 'farm337' and itemcode = 1002
--select * from dbo.tUserItem where cnt > 100 order by cnt desc
--select * from dbo.tUserItem where cnt < 0 order by cnt asc

-- 아이템 과하게 검색되는 사람들
declare @gameid			varchar(20),
		@itemcode		int,
		@itemname		varchar(40),
		@gamedanga		int,
		@cashdanga		int,
		@cnt			int,
		@cashcostcnt	int,
		@gamecostcnt	int

declare curItemOwner Cursor for
select gameid, itemcode, cnt from dbo.tUserItem where cnt > 50 and gameid not in ('farm100138113')
-- farm100138113, farm100343448, farm100528484, farm100658865, farm100722103, farm100759691, farm100982212

-- 2. 커서오픈
open curItemOwner

-- 3. 커서 사용
Fetch next from curItemOwner into @gameid, @itemcode, @cnt
while @@Fetch_status = 0
	Begin
		set @cashcostcnt = 0
		set @gamecostcnt = 0
		select @itemname = itemname, @cashdanga = cashcost, @gamedanga = gamecost from dbo.tItemInfo where itemcode = @itemcode
		--select 'DEBUG ', @gameid gameid, @itemcode itemcode, @cnt cnt, @cashdanga cashdanga, @gamedanga gamedanga
		--select 'DEBUG ', * from dbo.tUserItemBuyLog where gameid = @gameid and itemcode = @itemcode
		set @cashdanga = case when @cashdanga = 0 then 1 else @cashdanga end
		set @gamedanga = case when @gamedanga = 0 then 1 else @gamedanga end

		--select @gameid gameid, @itemname itemname, @itemcode itemcode, @cnt cnt, sum(cashcost) / @cashdanga, SUM(gamecost)/@gamedanga from dbo.tUserItemBuyLog where gameid = @gameid and itemcode = @itemcode
		select @cashcostcnt = sum(cashcost) / @cashdanga, @gamecostcnt = SUM(gamecost)/@gamedanga from dbo.tUserItemBuyLog where gameid = @gameid and itemcode = @itemcode
		if(isnull(@cashcostcnt, -1) = -1 or isnull(@gamecostcnt, -1) = -1
			or (@cashcostcnt != 0 and @cnt > @cashcostcnt)
			or (@gamecostcnt != 0 and @cnt > @gamecostcnt) )
				begin
					select ' ***(치트)', @gameid gameid, @itemname itemname, @itemcode itemcode, @cnt cnt, @cashcostcnt cashcostcnt, @gamecostcnt gamecostcnt
				end

		Fetch next from curItemOwner into @gameid, @itemcode, @cnt
	end

-- 4. 커서닫기
close curItemOwner
Deallocate curItemOwner

