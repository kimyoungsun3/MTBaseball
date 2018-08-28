use Game4Farmvill5
GO

-- 동물선물하기.
declare @kakaouserid	varchar(60)
declare @gameid			varchar(20) 	set @gameid		= ''
declare @password		varchar(20) 	set @password	= ''
declare @kakaostatus	int				set @kakaostatus=  1
declare @deletestate	int				set @deletestate= -1

set @kakaouserid	= '88470968441492993'	-- PC

select @gameid = gameid from dbo.tKakaoMaster where kakaouserid = @kakaouserid
select @deletestate = deletestate, @kakaostatus = kakaostatus, @password = password from dbo.tUserMaster where gameid = @gameid
if( @gameid = '' or @kakaostatus != 1 or @deletestate != 0 )
	begin
		select 'DEBUG 현재 유저는 활성된계정이 없음.'
	end

delete from dbo.tGiftList where gameid = @gameid						-- 선물초기화
delete from dbo.tUserItem where gameid = @gameid and invenkind in (1 )	-- 동물과 세포
select * from dbo.tUserMaster where gameid = @gameid
update dbo.tUserMaster
	set
		gamecost	= 400,
		settlestep	= 0,
		cashcost = 999999999,		fame = 99999,			famelv = 70,	gameyear = 2014,
		housestep		= 0,		housestate		= -1,
		tankstep		= 0,		tankstate		= -1,
		bottlestep		= 0,		bottlestate 	= -1,
		pumpstep		= 0,		pumpstate		= -1,
		transferstep	= 0,		transferstate	= -1,
		purestep		= 0,		purestate		= -1,
		freshcoolstep	= 0,		freshcoolstate	= -1
where gameid = @gameid
select * from dbo.tUserMaster where gameid = @gameid

exec spu_SubGiftSendNew 2,  1003,  9999, 'SysLogin', @gameid, ''				--
exec spu_SubGiftSendNew 2,  100005, 0, 'SysLogin', @gameid, ''				-- 펫.
exec spu_SubGiftSendNew 2,  7,  1, 'SysLogin', @gameid, ''				--
exec spu_SubGiftSendNew 2,  7,  1, 'SysLogin', @gameid, ''				--
exec spu_SubGiftSendNew 2,  7,  1, 'SysLogin', @gameid, ''				--
exec spu_SubGiftSendNew 2,  7,  1, 'SysLogin', @gameid, ''				--
exec spu_SubGiftSendNew 2,  7,  1, 'SysLogin', @gameid, ''				--
exec spu_SubGiftSendNew 2,  7,  1, 'SysLogin', @gameid, ''				--
exec spu_SubGiftSendNew 2,  7,  1, 'SysLogin', @gameid, ''				--
exec spu_SubGiftSendNew 2,  7,  1, 'SysLogin', @gameid, ''				--
exec spu_SubGiftSendNew 2,  7,  1, 'SysLogin', @gameid, ''				--