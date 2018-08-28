/*
--------------------------------------------
-- 15일이 지난 메일은 삭제됩니다.
---------------------------------------------
--use GameMTBaseball
--GO
--
-- select max(idx), min(idx) from dbo.tGiftList
-- select count(idx) from dbo.tGiftList
-- select max(idx), min(idx) from dbo.tGiftList where giftdate < getdate() - 30

declare @idxmax			int,
		@idxmin 		int,
		@delday			int

set @delday		= 30


-- 1. min ~ max 찾기
select
	@idxmax = isnull( max( idx ), -1 ),
	@idxmin = isnull( min( idx ), -1 )
from dbo.tGiftList where giftdate < getdate() - @delday
--select 'DEBUG ', @idxmax idxmax, @idxmin idxmin

-- 2. 루프를 돌면서 삭제하기.
while( @idxmin <= @idxmax )
	begin
		delete from dbo.tGiftList where idx > @idxmax - 1000 and idx <= @idxmax
		--select 'DEBUG ', * from dbo.tGiftList where idx > @idxmax - 1000 and idx <= @idxmax

		set @idxmax = @idxmax - 1000
	end

*/





