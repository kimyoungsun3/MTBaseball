use GameMTBaseball
GO

declare @gameid				varchar(20) set @gameid			= 'xxxx2'
declare @idx				int			set @idx 			= 0
declare @loopmax			int			set @loopmax 		= 20*5
declare @zcpchance			int			set @zcpchance		= -1
declare @salefresh			int			set @salefresh		= 150
declare @zcpappearcnt		int			set @zcpappearcnt	= 9999
declare @seedidx			int			set @seedidx		= 1
declare @seeditemcode		int			set @seeditemcode	= 605	-- 하트(601), 건초(605)
declare @goldticket			int			set @goldticket		= 4
DECLARE @tTempTable TABLE(
	idx				int
);

-- 최대맥스량이 있어서 여기서 필터한다.
update dbo.tUserMaster set zcpappearcnt = 0, zcpchance = -1 where gameid = @gameid
delete from dbo.tGiftList where gameid = @gameid
while( @idx < @loopmax )
	begin
		-- 작물심기.
		update dbo.tUSerSeed
			set
				itemcode 		= @seeditemcode,
				seedstartdate	= getdate() - 1,
				seedenddate		= getdate() - 1
		where gameid = @gameid and seedidx = @seedidx


		-- 일반결과
		update dbo.tUserMaster set goldticket = @goldticket, heart = 0, feed = 0, salefresh = @salefresh where gameid = @gameid
		update dbo.tUserMaster set zcpchance = -1 where gameid = @gameid

		exec spu_SeedHarvestTest @gameid, '049000s1i0n7t8445289',  @seedidx, 1, 0, -1	-- 하트 > 직접.

		select @zcpchance = zcpchance from dbo.tUserMaster where gameid = @gameid
		if( @zcpchance = 1 )
			begin
				insert into @tTempTable ( idx )
				values(                  @idx)
			end

		set @idx = @idx + 1
	end

select * from @tTempTable

