use Game4FarmVill4
GO

declare @kakaouserid	varchar(60),
		@gameid			varchar(60),
		@itemcode		int,
		@category		int,
		@cnt			int
set @kakaouserid	= '91188455545412242'	-- PC
--set @kakaouserid	= '91188455545412249'	-- PC ����
--set @kakaouserid	= '88255137081585760'	-- ��������
--set @kakaouserid	= '88812599272546640'	-- ������
--set @kakaouserid	= '88141973561720689'	-- �ؽ�
--set @kakaouserid	= '90396051283528689'	-- ������
--set @kakaouserid	= '88294959671580064'	-- ���¹�
--set @kakaouserid	= '88072204762769425'	-- ��â��
--set @kakaouserid	= '92064568193308403'	-- ���α�
--set @kakaouserid	= '88114671263625504'	-- �輱��
--set @kakaouserid	= '88103356826892544'	-- �̴�ǥ
--set @kakaouserid	= '88258263875124913'	-- �ڵ���

select top 1 @gameid = gameid from dbo.tFVUserMaster where kakaouserid = @kakaouserid order by idx desc
delete from dbo.tFVGiftList where gameid = @gameid


declare curUserFarmTech Cursor for
--select itemcode, category from dbo.tFVItemInfo where category in (60, 30) order by itemcode desc
select itemcode, category from dbo.tFVItemInfo where category in (60) order by itemcode desc
--select itemcode, category from dbo.tFVItemInfo where category in (30) order by itemcode asc


-- 2. Ŀ������
open curUserFarmTech

-- 3. Ŀ�� ���
Fetch next from curUserFarmTech into @itemcode, @category
while @@Fetch_status = 0
	Begin

		if(@category = 60)
			begin
				--exec spu_FVSubGiftSend 2, @itemcode,  1, 'blackm', @gameid, ''
				exec spu_FVSubGiftSend 2, @itemcode, 20, 'blackm', @gameid, ''
			end
		else if(@category = 30)
			begin
				exec spu_FVSubGiftSend 2, @itemcode, 1000, 'blackm', @gameid, ''
			end

		Fetch next from curUserFarmTech into @itemcode, @category
	end
	-- 4. Ŀ���ݱ�
close curUserFarmTech
Deallocate curUserFarmTech

exec spu_FVSubGiftSend 2, 3200, 50000, 'blackm', @gameid, ''			-- VIP����Ʈ
exec spu_FVSubGiftSend 2, 3700, 500000, 'blackm', @gameid, ''			-- ��
exec spu_FVSubGiftSend 2, 3400, 500000, 'blackm', @gameid, ''			-- ����
exec spu_FVSubGiftSend 2, 3015, 500000, 'blackm', @gameid, ''			-- ����
--exec spu_FVSubGiftSend 2, 3100, 9999999999999, 'blackm', @gameid, ''	-- ����
--exec spu_FVSubGiftSend 2, 3100, 9999999999999, 'blackm', @gameid, ''	-- ����
--exec spu_FVSubGiftSend 2, 3100, 9999999999999, 'blackm', @gameid, ''	-- ����
--exec spu_FVSubGiftSend 2, 3100, 9999999999999, 'blackm', @gameid, ''	-- ����
--exec spu_FVSubGiftSend 2, 3100, 9999999999999, 'blackm', @gameid, ''	-- ����
