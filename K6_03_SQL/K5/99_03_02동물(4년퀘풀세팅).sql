use GameMTBaseball
GO

-- ���������ϱ�.
declare @kakaouserid	varchar(60)
declare @gameid			varchar(20) 	set @gameid		= ''
declare @itemcode		int
declare @base			int
declare @kakaostatus	int				set @kakaostatus=  1
declare @deletestate	int				set @deletestate= -1
declare @needcnt		int				set @needcnt	= 0

set @kakaouserid	= '88470968441492993'	-- PC
--set @kakaouserid	= '88470968441492999'	-- ��������ǻ��.



select @gameid = gameid from dbo.tKakaoMaster where kakaouserid = @kakaouserid
select @deletestate = deletestate, @kakaostatus = kakaostatus from dbo.tUserMaster where gameid = @gameid
if( @gameid = '' or @kakaostatus != 1 or @deletestate != 0 )
	begin
		select 'DEBUG ���� ������ Ȱ���Ȱ����� ����.'
	end
select @kakaouserid kakaouserid, @gameid gameid, @kakaostatus kakaostatus, @deletestate deletestate

-- 1. ���� �о �����ϱ�.
declare curAnimal Cursor for
select itemcode from dbo.tItemInfo where subcategory in (1, 2, 3) and itemcode not in (22, 30, 31, 32, 128, 129, 130, 228, 229, 230)

-- 2. Ŀ������
open curAnimal

-- 3. Ŀ�� ���
Fetch next from curAnimal into @itemcode
while @@Fetch_status = 0
	Begin
		set @needcnt	= -1
		set @base		= -1
		select @needcnt = param5, @base = param6 from dbo.tItemInfo where itemcode = 101000 + @itemcode and subcategory = 1010
		--set @needcnt = case when @needcnt = -1 then 4 else @needcnt end
		select 'DEBUG ', @itemcode, @needcnt, @base

		while(@needcnt > 1 and @base != -1)
			begin
				exec spu_SetDirectItem @gameid, @base, 1, -1						-- �����ֱ�.
				--exec spu_SubGiftSendNew 2, @base,  1, '�׽�Ʈ����', @gameid, ''	-- �����ϱ�.
				set @needcnt = @needcnt - 1
			end
		Fetch next from curAnimal into @itemcode
	end

-- 4. Ŀ���ݱ�
close curAnimal
Deallocate curAnimal


delete from dbo.tUserItem where gameid = @gameid and invenkind in ( 1, 3, 1040, 1200 )
delete from dbo.tGiftList where gameid = @gameid
update dbo.tUserGameMTBaseball set playcnt = 10, buystate = 1 where gameid = @gameid
update dbo.tUserMaster set goldticket = 99999, tankstep = 22, housestep = 6, cashcost = 99999 where gameid = @gameid