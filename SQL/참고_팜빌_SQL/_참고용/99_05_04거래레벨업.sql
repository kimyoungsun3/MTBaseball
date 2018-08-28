use Farm
GO

-- 하이요~
delete from dbo.tFVUserSaleLog where gameid = 'xxxx2'
delete from dbo.tFVGiftList where gameid = 'xxxx2'
delete from dbo.tFVEpiReward where gameid = 'xxxx2'
-- update dbo.tFVUserMaster set market = 5, version = 999 where gameid = 'xxxx2'
-- select count(*) from dbo.tFVUserSaleLog where gameid = 'xxxx2'
-- select * from dbo.tFVGiftList where gameid = 'xxxx2'
declare @gameyear 		int,
		@gamemonth 		int,
		@gameyearstr	varchar(20),
		@paramstr		varchar(1024),
		@paramstrorg	varchar(1024),
		@tradeinfo		varchar(1024),
		@tradeinfoorg	varchar(1024),
		@loop			int,
		@loopmax		int,
		@etsalecoin		int,
		@gameid			varchar(20),
		@password		varchar(20),
		@famelv			int

set @etsalecoin		= 87600
set @paramstrorg	= '2:0;      4:2;       10:10;       11:100;     12:20;     13:200;   30:16;    43:1;'
set @tradeinfoorg	= '10:2;    11:1;    12:75;    20:10;    30:1;      31:10;    32:1;         33:7;     34:20;    35:77;  40:-1;'

--select '매달 거래하는 스크립트'
set @gameid = 'xxxx2'	set @password = '049000s1i0n7t8445289'	set @gameyear 	= 2013	set @gamemonth 	= 3	set @loop 	= 1	set @loopmax	= 400
set @famelv	= @loop


update dbo.tFVUserMaster set gamecost = 0, cashcost = 0, feed = 0, heart = 0, adidx = 0, etsalecoin = @etsalecoin where gameid = @gameid
update dbo.tFVSchoolMaster set totalpoint = 0 where schoolidx = (select schoolidx from dbo.tFVUserMaster where gameid = @gameid)
update dbo.tFVSchoolUser set point = 0 where gameid = @gameid
update dbo.tFVUserMaster set gameyear = @gameyear, gamemonth = @gamemonth, frametime = 0, fame = 5, famelv = @famelv, tradecnt = 1, prizecnt = 1 where gameid = @gameid
delete from dbo.tFVUserSaleLog where gameid = @gameid
delete from dbo.tFVGiftList where gameid = @gameid
delete from dbo.tFVEpiReward where gameid = @gameid
while(@loop <= @loopmax)
	begin
		set @gamemonth		= @gamemonth + 1
		if(@gamemonth >= 13)
			begin
				set @gameyear	= @gameyear + 1
				set @gamemonth	= 1
			end
		set @gameyearstr 	= '0:' + ltrim(rtrim(str(@gameyear))) + ';  1:' + ltrim(rtrim(str(@gamemonth))) + ';    '
		set @paramstr		= @gameyearstr + @paramstrorg

		set @famelv			= @loop/2
		set @famelv			= case
									when @famelv <= 0  then 1
									when @famelv >= 70 then 70
									else                    @famelv
							end
		--select @loop loop, @famelv famelv
		set @tradeinfo		= '0:5; 1:' + ltrim(rtrim(str(@famelv))) + '; ' + @tradeinfoorg
		--select @tradeinfo tradeinfo


		exec spu_FVGameTradeTest @gameid, @password, @paramstr,
															'1:5,1,1;3:5,23,0;4:5,25,-1;',
															'14:1;15:1;16:1;',
															@tradeinfo,
															'0:0;1:1;2:2;3:3;4:4;5:5;6:6;7:7;8:8;9:9;',
															-1										-- 필드없음.
		set @loop 		= @loop + 1
	end
