use GameMTBaseball
GO

declare @gameid				varchar(20) set @gameid			= 'xxxx2'
declare @idx				int			set @idx 			= 0
declare @loopmax			int			set @loopmax 		= 4*5
declare @zcpchance			int			set @zcpchance		= -1
declare @salefresh			int			set @salefresh		= 150
declare @zcpappearcnt		int			set @zcpappearcnt	= 9999
declare @mode				int			set @mode			= 3			-- �Ϲݿ���(1), 3�����(3)
DECLARE @tTempTable TABLE(
	idx				int
);

if( @mode = 1 ) select '�Ϲ�, ĳ���ð�������'
else select '3����'

-- �ִ�ƽ����� �־ ���⼭ �����Ѵ�.
update dbo.tUserMaster set zcpappearcnt = 0, zcpchance = -1 where gameid = @gameid
delete from dbo.tGiftList where gameid = @gameid
while( @idx < @loopmax )
	begin
		delete from dbo.tGiftList where gameid = @gameid
		delete from dbo.tUserItem where gameid = @gameid and invenkind = 1040
		update dbo.tUserMaster set zcpchance = -1 where gameid = @gameid


		if( @mode = 1 )
			begin
				-- ĳ�����(�ð�����).
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

