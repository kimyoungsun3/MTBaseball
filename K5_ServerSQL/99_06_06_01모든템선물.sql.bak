use Game4Farmvill5
GO

-- 동물선물하기.
declare @kakaouserid	varchar(60)
declare @gameid			varchar(20) 	set @gameid		= ''
declare @itemcode		int
declare @kakaostatus	int				set @kakaostatus=  1
declare @deletestate	int				set @deletestate= -1

set @kakaouserid	= '88470968441492993'	-- PC


select @gameid = gameid from dbo.tKakaoMaster where kakaouserid = @kakaouserid
select @deletestate = deletestate, @kakaostatus = kakaostatus from dbo.tUserMaster where gameid = @gameid
if( @gameid = '' or @kakaostatus != 1 or @deletestate != 0 )
	begin
		select 'DEBUG 현재 유저는 활성된계정이 없음.'
	end
delete from dbo.tGiftList where gameid = @gameid
delete from dbo.tUserItem where gameid = @gameid and invenkind != 1000
delete from dbo.tUserItem where gameid = @gameid and itemcode != 100000
update dbo.tUserMaster
	set
		cashcost = 0, gamecost = 0, heart = 0, feed = 0, fpoint = 0, goldticket = 0, battleticket = 0
where gameid = @gameid



--exec spu_SubGiftSendNew 2,  10, 1, 'SysLogin', @gameid, ''
--exec spu_SubGiftSendNew 2,  100, 1, 'SysLogin', @gameid, ''
--exec spu_SubGiftSendNew 2,  200, 1, 'SysLogin', @gameid, ''
--exec spu_SubGiftSendNew 2,  700, 1, 'SysLogin', @gameid, ''
--exec spu_SubGiftSendNew 2,  800, 1, 'SysLogin', @gameid, ''
--exec spu_SubGiftSendNew 2,  900, 1, 'SysLogin', @gameid, ''
--exec spu_SubGiftSendNew 2,  1000, 1, 'SysLogin', @gameid, ''
--exec spu_SubGiftSendNew 2,  1100, 1, 'SysLogin', @gameid, ''
--exec spu_SubGiftSendNew 2,  1200, 1, 'SysLogin', @gameid, ''
--exec spu_SubGiftSendNew 2,  2100, 1, 'SysLogin', @gameid, ''
--exec spu_SubGiftSendNew 2,  2200, 1, 'SysLogin', @gameid, ''
--exec spu_SubGiftSendNew 2,  2300, 1, 'SysLogin', @gameid, ''
--exec spu_SubGiftSendNew 2,  2500, 1, 'SysLogin', @gameid, ''
--exec spu_SubGiftSendNew 2,  2600, 1, 'SysLogin', @gameid, ''
--exec spu_SubGiftSendNew 2,  1900, 1, 'SysLogin', @gameid, ''
--exec spu_SubGiftSendNew 2,  2000, 1, 'SysLogin', @gameid, ''
--exec spu_SubGiftSendNew 2,  3000, 1, 'SysLogin', @gameid, ''
--exec spu_SubGiftSendNew 2,  3100, 1, 'SysLogin', @gameid, ''
--exec spu_SubGiftSendNew 2,  5000, 1, 'SysLogin', @gameid, ''
--exec spu_SubGiftSendNew 2,  5100, 1, 'SysLogin', @gameid, ''
exec spu_SubGiftSendNew 2,  100001, 1, 'SysLogin', @gameid, ''
--exec spu_SubGiftSendNew 2,  104000, 1, 'SysLogin', @gameid, ''
--exec spu_SubGiftSendNew 2,  120010, 1, 'SysLogin', @gameid, ''
