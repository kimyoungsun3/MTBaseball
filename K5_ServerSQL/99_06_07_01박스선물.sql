use Game4Farmvill5
GO

-- ���������ϱ�.
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
		select 'DEBUG ���� ������ Ȱ���Ȱ����� ����.'
	end
delete from dbo.tGiftList where gameid = @gameid
delete from dbo.tUserItem where gameid = @gameid and invenkind in (1040)
update dbo.tUserMaster set trophy = @trophy, tier = @tier where gameid = @gameid
select 'DEBUG ', @gameid gameid, @trophy trophy, @tier tier

--exec spu_SubGiftSendNew 2, 3700, 1, '�׽�Ʈ����', @gameid, ''	-- �����ϱ�.
exec spu_SubGiftSendNew 2, 3701, 1, '�׽�Ʈ����', @gameid, ''	-- �����ϱ�.
exec spu_SubGiftSendNew 2, 3701, 1, '�׽�Ʈ����', @gameid, ''	-- �����ϱ�.
exec spu_SubGiftSendNew 2, 3702, 1, '�׽�Ʈ����', @gameid, ''	-- �����ϱ�.
exec spu_SubGiftSendNew 2, 3702, 1, '�׽�Ʈ����', @gameid, ''	-- �����ϱ�.
--exec spu_SubGiftSendNew 2, 3703, 1, '�׽�Ʈ����', @gameid, ''	-- �����ϱ�.
--exec spu_SubGiftSendNew 2, 3704, 1, '�׽�Ʈ����', @gameid, ''	-- �����ϱ�.
--exec spu_SubGiftSendNew 2, 3705, 1, '�׽�Ʈ����', @gameid, ''	-- �����ϱ�.
