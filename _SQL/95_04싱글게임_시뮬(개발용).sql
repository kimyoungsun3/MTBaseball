
declare @gamecost		int
declare @rand			int
declare @select 		varchar(100)
declare @curturntime 	int				set @curturntime 	= 830092
declare @gameid 		varchar(20)		set @gameid			= 'mtxxxx4'
declare @dateid8 		varchar(8)		set @dateid8 		= Convert(varchar(8),Getdate(),112)
update dbo.tUserMaster set gamecost = 10000, connectip = '127.0.0.6', exp = 0, level = 1, gaingamecost = 0, gaingamecostpc = 0 where gameid = 'mtxxxx4'
delete from dbo.tSingleGame where gameid = @gameid 
delete from dbo.tSingleGameLog where gameid = @gameid
update dbo.tPCRoomEarnMaster set gamecost = 0, cnt = 0 where dateid8 = @dateid8
update dbo.tPCRoomEarnSub set gamecost 	= 0, cnt  = 0 where dateid8 = @dateid8
delete from dbo.tSingleGameEarnLogMaster where dateid8 = @dateid8 
update dbo.tUserMaster set gamecost = 0, gaingamecost = 0, gaingamecostpc = 0 where gameid = 'xxxx'

declare curSingleGameSimule Cursor for
select curturntime from dbo.tLottoInfo 
--where curturntime in (830673, 830672)
order by curturntime asc
-- select count(*) from dbo.tLottoInfo
-- select * from dbo.tSingleGameEarnLogMaster

Open curSingleGameSimule
Fetch next from curSingleGameSimule into @curturntime
while @@Fetch_status = 0
	Begin
		set @rand = dbo.fnu_GetRandom(0, 8)

		----------------------------------------------
		-- 1. 배팅
		-- select=번호:select:cnt;
		--        [1번자리] : STRIKE( 0 ) : 수량(1) )
		----------------------------------------------
		set @select = case
							when @rand <= 0 then '1:0:100;2:-1:0; 3:-1:0; 4:-1:0;'	-- 1개 배팅
							when @rand <= 1 then '1:0:100;2:0:100;3:-1:0; 4:-1:0;'	-- 2개 배팅
							when @rand <= 2 then '1:0:100;2:0:100;3:0:100;4:-1:0;'	-- 3개 배팅
							when @rand <= 3 then '1:0:100;2:0:100;3:0:100;4:0:100;'	-- 4개 배팅

							when @rand <= 4 then '1:1:100;2:-1:0; 3:-1:0; 4:-1:0;'	-- 1개 배팅
							when @rand <= 5 then '1:1:100;2:1:100;3:-1:0; 4:-1:0;'	-- 2개 배팅
							when @rand <= 6 then '1:1:100;2:1:100;3:1:100;4:-1:0;'	-- 3개 배팅
							else                 '1:1:100;2:1:100;3:1:100;4:1:100;'	-- 4개 배팅
					  end

		-- 1. 배팅.
		exec dbo.spu_SGBetTest @gameid, '049000s1i0n7t8445289', 333, 1, -1, @curturntime, @select, -1

		-- 2. 결과.
		exec dbo.spu_SGResultTest @gameid, '049000s1i0n7t8445289', 333, 1, @curturntime, -1

		-- 3. 다음을 위해서 삭제.
		--delete from dbo.tSingleGame where gameid = @gameid  and curturntime = @curturntime
		--delete from dbo.tSingleGameLog where gameid = @gameid and curturntime = @curturntime

		select @gamecost = gamecost from dbo.tUserMaster where gameid = @gameid
		--select @gamecost gamecost
		if(@gamecost >= 400)			
			begin
				Fetch next from curSingleGameSimule into @curturntime
			end
		else
			begin
				break;
			end
	end
close curSingleGameSimule
Deallocate curSingleGameSimule

