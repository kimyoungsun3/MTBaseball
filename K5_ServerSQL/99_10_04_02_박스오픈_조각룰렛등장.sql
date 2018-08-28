use GameMTBaseball
GO

declare @gameid				varchar(20) set @gameid			= 'xxxx2'
declare @idx				int			set @idx 			= 0
declare @loopmax			int			set @loopmax 		= 4*5
declare @zcpchance			int			set @zcpchance		= -1
declare @salefresh			int			set @salefresh		= 150
declare @zcpappearcnt		int			set @zcpappearcnt	= 9999
declare @mode				int			set @mode			= 3			-- 일반오픈(1), 3배즉시(3)
DECLARE @tTempTable TABLE(
	idx				int
);

if( @mode = 1 ) select '일반, 캐쉬시간단축모드'
else select '3배모드'

-- 최대맥스량이 있어서 여기서 필터한다.
update dbo.tUserMaster set zcpappearcnt = 0, zcpchance = -1 where gameid = @gameid
delete from dbo.tGiftList where gameid = @gameid
while( @idx < @loopmax )
	begin
		delete from dbo.tGiftList where gameid = @gameid
		delete from dbo.tUserItem where gameid = @gameid and invenkind = 1040
		update dbo.tUserMaster set zcpchance = -1 where gameid = @gameid


		if( @mode = 1 )
			begin
				-- 캐쉬모드(시간단축).
				update dbo.tUserMaster set boxslot1 = 3701, boxslot2 = -1, boxslotidx = 1, boxslottime = DATEADD(ss, 60*60, getdate()), cashcost = 1000, gamecost = 0, trophy = 1    where gameid = @gameid
				exec spu_BoxOpenModeTest @gameid, '049000s1i0n7t8445289', 2, 1, -1
			end
		else
			begin
				update dbo.tUserMaster set boxslot1 = 3701, boxslot2 = -1, boxslotidx = 1, cashcost = 1000, gamecost = 0, tier = 3    where gameid = @gameid
				exec spu_BoxOpenModeTest @gameid, '049000s1i0n7t8445289', 12, 1, -1
			end


		select @zcpchance = zcpchance from dbo.tUserMaster where gameid = @gameid
		if( @zcpchance = 1 )
			begin
				insert into @tTempTable ( idx )
				values(                  @idx)
			end

		set @idx = @idx + 1
	end

select * from @tTempTable

