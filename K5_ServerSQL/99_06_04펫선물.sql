-- update dbo.tUserItem set petupgrade = 6 where gameid = 'farm185995' and invenkind = 1000

use Game4Farmvill5
GO

-- ���������ϱ�.
declare @kakaouserid	varchar(60)
declare @gameid			varchar(20) 	set @gameid		= ''
declare @itemcode		int
declare @kakaostatus	int				set @kakaostatus=  1
declare @deletestate	int				set @deletestate= -1

set @kakaouserid	= '88470968441492993'	-- PC
--set @kakaouserid	= '88258263875124913'	-- �����ڵ���
--set @kakaouserid = '91188455545412245'	--��ö
--set @kakaouserid = '88470968441492992'	-- �Ӱ�����
--set @kakaouserid = '91188455545412246'	-- ����


select @gameid = gameid from dbo.tKakaoMaster where kakaouserid = @kakaouserid
select @deletestate = deletestate, @kakaostatus = kakaostatus from dbo.tUserMaster where gameid = @gameid
if( @gameid = '' or @kakaostatus != 1 or @deletestate != 0 )
	begin
		select 'DEBUG ���� ������ Ȱ���Ȱ����� ����.'
	end
--delete from dbo.tGiftList where gameid = @gameid
--delete from dbo.tUserItem where gameid = @gameid and invenkind = 1000


-- 1. ���� �о �����ϱ�.
declare curAnimal Cursor for
select itemcode from dbo.tItemInfo where subcategory = 1000
	and itemcode not in (select itemcode from dbo.tUserItem where gameid = @gameid and invenkind = 1000)

-- 2. Ŀ������
open curAnimal

-- 3. Ŀ�� ���
Fetch next from curAnimal into @itemcode
while @@Fetch_status = 0
	Begin
		exec spu_SetDirectItem @gameid, @itemcode, 1, -1						-- �����ֱ�.
		--exec spu_SubGiftSendNew 2, @itemcode,  1, '�׽�Ʈ����', @gameid, ''	-- �����ϱ�.

		Fetch next from curAnimal into @itemcode
	end

-- 4. Ŀ���ݱ�
close curAnimal
Deallocate curAnimal

