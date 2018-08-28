use GameMTBaseball
GO

declare @gameid				varchar(20) set @gameid			= 'xxxx2'
declare @idx				int			set @idx 			= 0
declare @loopmax			int			set @loopmax 		= 20*3
declare @zcpchance			int			set @zcpchance		= -1
declare @salefresh			int			set @salefresh		= 150
declare @zcpappearcnt		int			set @zcpappearcnt	= 9999
declare @tradeinfo			varchar(500) set @tradeinfo		= '0:5; 1:2;   10:2;    11:1;    12:75;    20:10;    30:1;      31:11;         33:7;     34:'+ltrim(rtrim(str(@salefresh)))+';    35:77;  40:-1; 61:-1;       62:1;             63:-1; 70:1;'
DECLARE @tTempTable TABLE(
	idx				int
);

-- 최대맥스량이 있어서 여기서 필터한다.
update dbo.tUserMaster set zcpappearcnt = 0, zcpchance = -1 where gameid = @gameid
delete from dbo.tGiftList where gameid = @gameid
while( @idx < @loopmax )
	begin
		-- 일반결과
		update dbo.tUserMaster set gameyear = 2013, gamemonth = 3, frametime = 0, etsalecoin = 1000, fame = 5, famelv = 2, tradecnt = 1, prizecnt = 1, etremain = -1 where gameid = @gameid
		update dbo.tUserMaster set gamecost = 0, cashcost = 0, feed = 0, heart = 0, tradesuccesscnt = 29 where gameid = @gameid
		update dbo.tUserMaster set zcpchance = -1 where gameid = @gameid
		update dbo.tSchoolMaster set totalpoint = 0 where schoolidx = (select schoolidx from dbo.tUserMaster where gameid = @gameid)
		update dbo.tSchoolUser set point = 0 where gameid = gameid
		delete from dbo.tUserSaleLog where gameid = @gameid
		delete from dbo.tEpiReward where gameid = @gameid
		exec spu_GameTradeTest @gameid, '049000s1i0n7t8445289', '0:2013;  1:4;      2:0;      4:2;       10:10;       11:100;     12:20;     13:200;   30:16;    43:1;',
															'1:5,1,1;3:5,23,0;4:5,25,-1;',
															'14:1;15:1;16:1;',
															@tradeinfo,
															'0:0;1:1;2:2;3:3;4:4;5:5;6:6;7:7;8:8;9:9;',
															-1										-- 필드없음.

		select @zcpchance = zcpchance from dbo.tUserMaster where gameid = @gameid
		if( @zcpchance = 1 )
			begin
				insert into @tTempTable ( idx )
				values(                  @idx)
			end

		set @idx = @idx + 1
	end

select * from @tTempTable

