use Game4FarmVill4
GO

declare @gameid			varchar(60)
declare @cnt			int
declare @loop 			int
declare @kakaouserid	varchar(60)

set @kakaouserid	= '91188455545412242'	-- PC
--set @kakaouserid	= '91188455545412249'	-- PC 선훈
--set @kakaouserid	= '92064568193308403' -- 인규.
--set @kakaouserid	= '88470968441492992' -- 임과장.
--set @kakaouserid	= '88255137081585760'	-- 만종이폰
--set @kakaouserid	= '88812599272546640'	-- 최정기
--set @kakaouserid	= '88141973561720689'	-- 준식
--set @kakaouserid	= '88318663778986177'	-- 연지
--set @kakaouserid	= '90396051283528689'	-- 임진혁
--set @kakaouserid	= '88294959671580064'	-- 김태민
--set @kakaouserid	= '88072204762769425'	-- 최창규
--set @kakaouserid	= '92064568193308403'	-- 박인규
--set @kakaouserid	= '88114671263625504'	-- 김선훈
--set @kakaouserid	= '88103356826892544'	-- 이대표
--set @kakaouserid	= '88258263875124913'	-- 핸드폰


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

exec spu_FVSubGiftSend 2, 3400, 500000, 'blackm', @gameid, ''			-- 건초
exec spu_FVSubGiftSend 2, 3015, 500000, 'blackm', @gameid, ''			-- 결정
exec spu_FVSubGiftSend 2, 3300, 40000, 'blackm', @gameid, ''			-- 하트
exec spu_FVSubGiftSend 2, 3200, 50000, 'blackm', @gameid, ''			-- VIP포인트
exec spu_FVSubGiftSend 2, 3100, 9999999999999, 'blackm', @gameid, ''	-- 코인
exec spu_FVSubGiftSend 2, 3100, 9999999999999, 'blackm', @gameid, ''	-- 코인
exec spu_FVSubGiftSend 2, 3100, 9999999999999, 'blackm', @gameid, ''	-- 코인
exec spu_FVSubGiftSend 2, 3100, 9999999999999, 'blackm', @gameid, ''	-- 코인
exec spu_FVSubGiftSend 2, 3100, 9999999999999, 'blackm', @gameid, ''	-- 코인
exec spu_FVSubGiftSend 2, 3100, 9999999999999, 'blackm', @gameid, ''	-- 코인
exec spu_FVSubGiftSend 2, 3100, 9999999999999, 'blackm', @gameid, ''	-- 코인
exec spu_FVSubGiftSend 2, 3100, 9999999999999, 'blackm', @gameid, ''	-- 코인
exec spu_FVSubGiftSend 2, 3100, 9999999999999, 'blackm', @gameid, ''	-- 코인
exec spu_FVSubGiftSend 2, 3100, 9999999999999, 'blackm', @gameid, ''	-- 코인
exec spu_FVSubGiftSend 2, 3100, -9999999999999, 'blackm', @gameid, ''	-- 코인
exec spu_FVSubGiftSend 2, 3700, 50000, 'blackm', @gameid, ''			-- 별