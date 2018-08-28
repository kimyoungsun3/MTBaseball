
/*
-- 동물뽑기 가격 (코인, 하트, 캐쉬1, 캐쉬2)
declare @famelv int		set @famelv = 1
while (@famelv < 80)
	begin
		select @famelv famelv,
			   dbo.fun_GetRoulPrice( 100, @famelv) gamecost,-- 코인
			   dbo.fun_GetRoulPrice( 101, @famelv) heart, 	-- 하트
			   dbo.fun_GetRoulPrice( 102, @famelv) cash2, 	-- 캐쉬2
			   dbo.fun_GetRoulPrice( 103, @famelv) cash4	-- 캐쉬4
		set @famelv = @famelv + 1
	end

*/
use Game4Farmvill5
GO

IF OBJECT_ID ( N'dbo.fun_GetRoulPrice', N'FN' ) IS NOT NULL
	DROP FUNCTION dbo.fun_GetRoulPrice;
GO

CREATE FUNCTION dbo.fun_GetRoulPrice(
	@mode_					int = 1,
	@famelv_				int = 1
)
	RETURNS int
AS
BEGIN
	declare @MODE_ROULETTE_GRADE1_GAMECOST		int					set @MODE_ROULETTE_GRADE1_GAMECOST			= 100
	declare @MODE_ROULETTE_GRADE1_HEART			int					set @MODE_ROULETTE_GRADE1_HEART				= 101
	declare @MODE_ROULETTE_GRADE2_CASHCOST		int					set @MODE_ROULETTE_GRADE2_CASHCOST			= 102
	declare @MODE_ROULETTE_GRADE4_CASHCOST		int					set @MODE_ROULETTE_GRADE4_CASHCOST			= 103

	declare @rtn 								int					set @rtn 									= 3000

	if( @mode_ = @MODE_ROULETTE_GRADE1_GAMECOST)
		begin
			--set @rtn = 200 + ( @famelv_ / 10) * ( @famelv_ / 10) * 100		> 너무 비쌈
			set @rtn = case
							when ( @famelv_ <=  9 ) then 400 - 100
							when ( @famelv_ <= 14 ) then 450 - 50
							when ( @famelv_ <= 19 ) then 500
							when ( @famelv_ <= 24 ) then 600
							when ( @famelv_ <= 29 ) then 700
							when ( @famelv_ <= 34 ) then 800
							when ( @famelv_ <= 39 ) then 950
							when ( @famelv_ <= 49 ) then 1100
							when ( @famelv_ <= 50 ) then 1100
							when ( @famelv_ <= 51 ) then 1500
							when ( @famelv_ <= 54 ) then 2000
							when ( @famelv_ <= 57 ) then 2500
							when ( @famelv_ <= 59 ) then 3000
							when ( @famelv_ <= 60 ) then 3500
							when ( @famelv_ <= 70 ) then 4000
							else						 4000
						end
		end
	else if( @mode_ = @MODE_ROULETTE_GRADE1_HEART)
		begin
			--set @rtn = 60 + ( @famelv_ / 10) * 10		> 너무 비쌈
			set @rtn = case
							when ( @famelv_ <=  9 ) then 35
							when ( @famelv_ <= 14 ) then 40
							when ( @famelv_ <= 19 ) then 45
							when ( @famelv_ <= 24 ) then 50
							when ( @famelv_ <= 29 ) then 55
							when ( @famelv_ <= 34 ) then 60
							when ( @famelv_ <= 39 ) then 65
							when ( @famelv_ <= 49 ) then 70
							when ( @famelv_ <= 50 ) then 75
							when ( @famelv_ <= 51 ) then 80
							when ( @famelv_ <= 54 ) then 85
							when ( @famelv_ <= 57 ) then 90
							when ( @famelv_ <= 59 ) then 95
							when ( @famelv_ <= 60 ) then 100
							when ( @famelv_ <= 70 ) then 110
							else						 110
						end
		end
	else if( @mode_ = @MODE_ROULETTE_GRADE2_CASHCOST)
		begin
			set @rtn = 300
		end
	else if( @mode_ = @MODE_ROULETTE_GRADE1_HEART)
		begin
			set @rtn = 3000
		end


	RETURN @rtn
END
