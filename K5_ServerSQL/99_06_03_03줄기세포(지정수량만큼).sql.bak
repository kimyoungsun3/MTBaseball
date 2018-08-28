use Game4Farmvill5
GO

-- 동물선물하기.
declare @kakaouserid	varchar(60)
declare @gameid			varchar(20) 	set @gameid		= ''
declare @itemcode		int
declare @kakaostatus	int				set @kakaostatus=  1
declare @deletestate	int				set @deletestate= -1
declare @ticketcnt		int				set @ticketcnt	= 60
declare @tmpcnt			int				set @tmpcnt		= 100
declare @stemcellitemcode	int			set @stemcellitemcode = 104026		-- 3등급
declare @cellgrade		int				set @cellgrade = 3-1


set @kakaouserid	= '88470968441492993'	-- PC
--set @kakaouserid	= '88258263875124913'	-- 영선핸드폰
--set @kakaouserid = '91188455545412245'	-- 기철
set @kakaouserid = '88470968441492992'	-- 임과장폰
--set @kakaouserid = '91188455545412246'	-- 보람
--set @kakaouserid = '88148220413796480'	-- 보람핸드폰
--set @kakaouserid = '88533256943908928'	-- 지영핸드폰


select @gameid = gameid from dbo.tKakaoMaster where kakaouserid = @kakaouserid
select @deletestate = deletestate, @kakaostatus = kakaostatus from dbo.tUserMaster where gameid = @gameid
if( @gameid = '' or @kakaostatus != 1 or @deletestate != 0 )
	begin
		select 'DEBUG 현재 유저는 활성된계정이 없음.', @gameid, @kakaostatus, @deletestate
	end

select 'DEBUG ', @gameid, @kakaostatus, @deletestate
--delete from dbo.tGiftList where gameid = @gameid
--delete from dbo.tUserItem where gameid = @gameid and invenkind = 104036
--update dbo.tUserItem set upcnt = 0, freshstem100 = 0, attstem100 = 0, timestem100 = 0, defstem100 = 0, hpstem100 = 0 where gameid = @gameid and invenkind = 1


select 'DEBUG ', @stemcellitemcode stemcellitemcode, @tmpcnt '지급세포', * from dbo.tItemInfo where itemcode = @stemcellitemcode

while ( @tmpcnt > 0 )
	begin
		exec spu_SetDirectItemNew @gameid, @stemcellitemcode, 1, 3, -1
		--exec spu_SubGiftSendNew 2, @stemcellitemcode,  1, '테스트선물', @gameid, ''	-- 선물하기.

		set @tmpcnt = @tmpcnt - 1
	end