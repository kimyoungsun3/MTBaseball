use Farm
GO

declare @kakaouserid	varchar(60),
		@gameid			varchar(60)
set @kakaouserid	= '91188455545412242'	-- PC
set @kakaouserid	= '88255137081585760'	-- ��������
set @kakaouserid	= '88812599272546640'	-- ������
set @kakaouserid	= '88141973561720689'	-- �ؽ�
set @kakaouserid	= '88318663778986177'	-- ����
set @kakaouserid	= '90396051283528689'	-- ������
set @kakaouserid	= '88294959671580064'	-- ���¹�
set @kakaouserid	= '88072204762769425'	-- ��â��
set @kakaouserid	= '92064568193308403'	-- ���α�
set @kakaouserid	= '88114671263625504'	-- �輱��
set @kakaouserid	= '88103356826892544'	-- �̴�ǥ
set @kakaouserid	= '88258263875124913'	-- �ڵ���


select top 1 @gameid = gameid from dbo.tFVUserMaster where kakaouserid = @kakaouserid order by idx desc
delete from dbo.tFVGiftList where gameid = @gameid

exec spu_FVSubGiftSend 2, 3000, 500000, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 3001, 500000, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 3002, 500000, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 3003, 500000, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 3004, 500000, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 3005, 500000, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 3006, 500000, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 3007, 500000, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 3008, 500000, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 3009, 500000, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 3010, 500000, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 3011, 500000, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 3012, 500000, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 3013, 500000, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 3014, 500000, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 3015, 500000, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 3016, 500000, 'blackm', @gameid, ''	-- �űԾ�����
exec spu_FVSubGiftSend 2, 3017, 500000, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 3018, 500000, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 3019, 500000, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 3020, 500000, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 3021, 500000, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 3022, 500000, 'blackm', @gameid, ''
exec spu_FVSubGiftSend 2, 3023, 500000, 'blackm', @gameid, ''

exec spu_FVSubGiftSend 2, 3300, 200, 'blackm', @gameid, ''			-- ��Ʈ
exec spu_FVSubGiftSend 2, 3300, 40000, 'blackm', @gameid, ''			-- ��Ʈ
--exec spu_FVSubGiftSend 2, 3200, 50000, 'blackm', @gameid, ''		-- VIP����Ʈ
exec spu_FVSubGiftSend 2, 3100, 99800000000000, 'blackm', @gameid, ''	-- ����