use Farm
GO

declare @gameid			varchar(60)
declare @cnt			int
declare @loop 			int

set @gameid		= 'PC14DAE9EC6A77'			-- PC
set @gameid		= '106402766319809380603'	-- 인규
set @gameid		= '109661327975685722362'	-- 영선
--set @gameid		= '108896905679422200740'	-- 임진혁


delete from dbo.tFVGiftList where gameid = @gameid
set @cnt = 9000000
while (@cnt > 1000)
	begin
		set @loop = 3000
		while(@loop <= 3022)
			begin
				exec spu_FVSubGiftSend 2, @loop, @cnt, 'blackm', @gameid, ''
				set @loop = @loop + 1
			end
		set @cnt = @cnt / 10
	end

exec spu_FVSubGiftSend 2, 3015, 500000, 'blackm', @gameid, ''			-- 결정
exec spu_FVSubGiftSend 2, 3300, 200, 'blackm', @gameid, ''				-- 하트
exec spu_FVSubGiftSend 2, 3300, 40000, 'blackm', @gameid, ''			-- 하트
exec spu_FVSubGiftSend 2, 3200, 50000, 'blackm', @gameid, ''			-- VIP포인트
exec spu_FVSubGiftSend 2, 3100, 9999999999999, 'blackm', @gameid, ''	-- 코인
exec spu_FVSubGiftSend 2, 3100, 999999999999999, 'blackm', @gameid, ''	-- 코인