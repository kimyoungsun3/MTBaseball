use Game4FarmVill4
GO

declare @gameid			varchar(60)
declare @cnt			int
declare @loop 			int
declare @kakaouserid	varchar(60)

set @kakaouserid	= '91188455545412242'	-- PC
--set @kakaouserid	= '91188455545412249'	-- PC ����
--set @kakaouserid	= '92064568193308403' -- �α�.
--set @kakaouserid	= '88470968441492992' -- �Ӱ���.
--set @kakaouserid	= '88255137081585760'	-- ��������
--set @kakaouserid	= '88812599272546640'	-- ������
--set @kakaouserid	= '88141973561720689'	-- �ؽ�
--set @kakaouserid	= '88318663778986177'	-- ����
--set @kakaouserid	= '90396051283528689'	-- ������
--set @kakaouserid	= '88294959671580064'	-- ���¹�
--set @kakaouserid	= '88072204762769425'	-- ��â��
--set @kakaouserid	= '92064568193308403'	-- ���α�
--set @kakaouserid	= '88114671263625504'	-- �輱��
--set @kakaouserid	= '88103356826892544'	-- �̴�ǥ
--set @kakaouserid	= '88258263875124913'	-- �ڵ���


select top 1 @gameid = gameid from dbo.tFVUserMaster where kakaouserid = @kakaouserid order by idx desc
delete from dbo.tFVGiftList where gameid = @gameid

set @cnt = 9000000
while (@cnt > 1000)
	begin
		set @loop = 3000
		while(@loop <= 3023)
			begin
				exec spu_FVSubGiftSend 2, @loop, @cnt, 'blackm', @gameid, ''
				set @loop = @loop + 1
			end
		set @cnt = @cnt / 10
	end

exec spu_FVSubGiftSend 2, 3400, 500000, 'blackm', @gameid, ''			-- ����
exec spu_FVSubGiftSend 2, 3015, 500000, 'blackm', @gameid, ''			-- ����
exec spu_FVSubGiftSend 2, 3300, 40000, 'blackm', @gameid, ''			-- ��Ʈ
exec spu_FVSubGiftSend 2, 3200, 50000, 'blackm', @gameid, ''			-- VIP����Ʈ
exec spu_FVSubGiftSend 2, 3100, 9999999999999, 'blackm', @gameid, ''	-- ����
exec spu_FVSubGiftSend 2, 3100, 9999999999999, 'blackm', @gameid, ''	-- ����
exec spu_FVSubGiftSend 2, 3100, 9999999999999, 'blackm', @gameid, ''	-- ����
exec spu_FVSubGiftSend 2, 3100, 9999999999999, 'blackm', @gameid, ''	-- ����
exec spu_FVSubGiftSend 2, 3100, 9999999999999, 'blackm', @gameid, ''	-- ����
exec spu_FVSubGiftSend 2, 3100, 9999999999999, 'blackm', @gameid, ''	-- ����
exec spu_FVSubGiftSend 2, 3100, 9999999999999, 'blackm', @gameid, ''	-- ����
exec spu_FVSubGiftSend 2, 3100, 9999999999999, 'blackm', @gameid, ''	-- ����
exec spu_FVSubGiftSend 2, 3100, 9999999999999, 'blackm', @gameid, ''	-- ����
exec spu_FVSubGiftSend 2, 3100, 9999999999999, 'blackm', @gameid, ''	-- ����
exec spu_FVSubGiftSend 2, 3100, -9999999999999, 'blackm', @gameid, ''	-- ����
exec spu_FVSubGiftSend 2, 3700, 50000, 'blackm', @gameid, ''			-- ��