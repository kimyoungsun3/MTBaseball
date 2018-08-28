use Game4Farmvill5
GO

-- 동물선물하기.
declare @kakaouserid	varchar(60)
declare @gameid			varchar(20) 	set @gameid		= ''
declare @itemcode		int
declare @kakaostatus	int				set @kakaostatus=  1
declare @deletestate	int				set @deletestate= -1
declare @trophy			int				set @trophy		=  3000 - 1
declare @tier			int				set @tier		=  dbo.fun_GetTier( @trophy )

set @kakaouserid	= '88470968441492993'	-- PC


select @gameid = gameid from dbo.tKakaoMaster where kakaouserid = @kakaouserid
select @deletestate = deletestate, @kakaostatus = kakaostatus from dbo.tUserMaster where gameid = @gameid
if( @gameid = '' or @kakaostatus != 1 or @deletestate != 0 )
	begin
		select 'DEBUG 현재 유저는 활성된계정이 없음.'
	end
delete from dbo.tGiftList where gameid = @gameid
delete from dbo.tUserItem where gameid = @gameid and invenkind in (1040)
update dbo.tUserMaster set trophy = @trophy, tier = @tier where gameid = @gameid
select 'DEBUG ', @gameid gameid, @trophy trophy, @tier tier

--exec spu_SubGiftSendNew 2, 3700, 1, '테스트선물', @gameid, ''	-- 선물하기.
exec spu_SubGiftSendNew 2, 3701, 1, '테스트선물', @gameid, ''	-- 선물하기.
exec spu_SubGiftSendNew 2, 3701, 1, '테스트선물', @gameid, ''	-- 선물하기.
exec spu_SubGiftSendNew 2, 3702, 1, '테스트선물', @gameid, ''	-- 선물하기.
exec spu_SubGiftSendNew 2, 3702, 1, '테스트선물', @gameid, ''	-- 선물하기.
--exec spu_SubGiftSendNew 2, 3703, 1, '테스트선물', @gameid, ''	-- 선물하기.
--exec spu_SubGiftSendNew 2, 3704, 1, '테스트선물', @gameid, ''	-- 선물하기.
--exec spu_SubGiftSendNew 2, 3705, 1, '테스트선물', @gameid, ''	-- 선물하기.
