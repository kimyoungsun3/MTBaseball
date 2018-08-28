/*
--------------------------------------------
-- 15���� ���� ������ �����˴ϴ�.
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


-- 1. min ~ max ã��
select
	@idxmax = isnull( max( idx ), -1 ),
	@idxmin = isnull( min( idx ), -1 )
from dbo.tGiftList where giftdate < getdate() - @delday
--select 'DEBUG ', @idxmax idxmax, @idxmin idxmin

-- 2. ������ ���鼭 �����ϱ�.
while( @idxmin <= @idxmax )
	begin
		delete from dbo.tGiftList where idx > @idxmax - 1000 and idx <= @idxmax
		--select 'DEBUG ', * from dbo.tGiftList where idx > @idxmax - 1000 and idx <= @idxmax

		set @idxmax = @idxmax - 1000
	end

*/





