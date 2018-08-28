use Game4Farmvill5
GO

-- 悼拱急拱窍扁.
declare @kakaouserid	varchar(60)
declare @gameid			varchar(20) 	set @gameid		= ''
declare @itemcode		int
declare @kakaostatus	int				set @kakaostatus=  1
declare @deletestate	int				set @deletestate= -1

set @kakaouserid	= '88470968441492993'	-- PC
--set @kakaouserid	= '88258263875124913'	-- 康急勤靛迄
--set @kakaouserid = '91188455545412245'	--扁枚
--set @kakaouserid = '88470968441492992'	-- 烙苞厘迄
--set @kakaouserid = '91188455545412246'	-- 焊恩


select @gameid = gameid from dbo.tKakaoMaster where kakaouserid = @kakaouserid
select @deletestate = deletestate, @kakaostatus = kakaostatus from dbo.tUserMaster where gameid = @gameid
if( @gameid = '' or @kakaostatus != 1 or @deletestate != 0 )
	begin
		select 'DEBUG 泅犁 蜡历绰 劝己等拌沥捞 绝澜.'
	end
delete from dbo.tGiftList where gameid = @gameid
delete from dbo.tUserItem where gameid = @gameid and invenkind = 1


delete from dbo.tUserItem where gameid = @gameid and invenkind = 1
exec spu_SetDirectItem @gameid, 3, 1, -1						-- 流立持扁.
exec spu_SetDirectItem @gameid, 6, 1, -1						-- 流立持扁.
exec spu_SetDirectItem @gameid, 7, 1, -1						-- 流立持扁.
exec spu_SetDirectItem @gameid, 10, 1, -1						-- 流立持扁.
exec spu_SetDirectItem @gameid, 13, 1, -1						-- 流立持扁.
exec spu_SetDirectItem @gameid, 16, 1, -1						-- 流立持扁.
exec spu_SetDirectItem @gameid, 20, 1, -1						-- 流立持扁.
exec spu_SetDirectItem @gameid, 26, 1, -1						-- 流立持扁.

exec spu_SetDirectItem @gameid, 100, 1, -1						-- 流立持扁.
exec spu_SetDirectItem @gameid, 102, 1, -1						-- 流立持扁.
exec spu_SetDirectItem @gameid, 104, 1, -1						-- 流立持扁.
exec spu_SetDirectItem @gameid, 106, 1, -1						-- 流立持扁.
exec spu_SetDirectItem @gameid, 109, 1, -1						-- 流立持扁.
exec spu_SetDirectItem @gameid, 112, 1, -1						-- 流立持扁.
exec spu_SetDirectItem @gameid, 116, 1, -1						-- 流立持扁.
exec spu_SetDirectItem @gameid, 121, 1, -1						-- 流立持扁.
exec spu_SetDirectItem @gameid, 125, 1, -1						-- 流立持扁.

exec spu_SetDirectItem @gameid, 200, 1, -1						-- 流立持扁.
exec spu_SetDirectItem @gameid, 203, 1, -1						-- 流立持扁.
exec spu_SetDirectItem @gameid, 205, 1, -1						-- 流立持扁.
exec spu_SetDirectItem @gameid, 206, 1, -1						-- 流立持扁.
exec spu_SetDirectItem @gameid, 209, 1, -1						-- 流立持扁.
exec spu_SetDirectItem @gameid, 212, 1, -1						-- 流立持扁.
exec spu_SetDirectItem @gameid, 216, 1, -1						-- 流立持扁.
exec spu_SetDirectItem @gameid, 220, 1, -1						-- 流立持扁.
exec spu_SetDirectItem @gameid, 222, 1, -1						-- 流立持扁.
exec spu_SetDirectItem @gameid, 224, 1, -1						-- 流立持扁.