
/*
-- 보물업글 가격 (0LV -> 1LV)
declare @grade int
set @grade = 1
while( @grade <= 6)
	begin
		select dbo.fun_GetTSUpgradePrice( 1, @grade, 1), dbo.fun_GetTSUpgradePrice( 1, @grade, 2), dbo.fun_GetTSUpgradePrice( 1, @grade, 3), dbo.fun_GetTSUpgradePrice( 1, @grade, 4), dbo.fun_GetTSUpgradePrice( 1, @grade, 5), dbo.fun_GetTSUpgradePrice( 1, @grade, 6), dbo.fun_GetTSUpgradePrice( 1, @grade, 7), '초월', dbo.fun_GetTSUpgradePrice( 1, @grade, 8), dbo.fun_GetTSUpgradePrice( 1, @grade, 9)
		select dbo.fun_GetTSUpgradePrice( 2, @grade, 1), dbo.fun_GetTSUpgradePrice( 2, @grade, 2), dbo.fun_GetTSUpgradePrice( 2, @grade, 3), dbo.fun_GetTSUpgradePrice( 2, @grade, 4), dbo.fun_GetTSUpgradePrice( 2, @grade, 5), dbo.fun_GetTSUpgradePrice( 2, @grade, 6), dbo.fun_GetTSUpgradePrice( 2, @grade, 7), '초월', dbo.fun_GetTSUpgradePrice( 2, @grade, 8), dbo.fun_GetTSUpgradePrice( 2, @grade, 9)
		select dbo.fun_GetTSUpgradePrice( 3, @grade, 1), dbo.fun_GetTSUpgradePrice( 3, @grade, 2), dbo.fun_GetTSUpgradePrice( 3, @grade, 3), dbo.fun_GetTSUpgradePrice( 3, @grade, 4), dbo.fun_GetTSUpgradePrice( 3, @grade, 5), dbo.fun_GetTSUpgradePrice( 3, @grade, 6), dbo.fun_GetTSUpgradePrice( 3, @grade, 7), '초월', dbo.fun_GetTSUpgradePrice( 3, @grade, 8), dbo.fun_GetTSUpgradePrice( 3, @grade, 9)
		set @grade = @grade + 1
	end


*/
use Game4Farmvill5
GO

IF OBJECT_ID ( N'dbo.fun_GetTSUpgradePrice', N'FN' ) IS NOT NULL
	DROP FUNCTION dbo.fun_GetTSUpgradePrice;
GO

CREATE FUNCTION dbo.fun_GetTSUpgradePrice(
	@mode_					int = 1,
	@grade_					int = 1,
	@nextlv_				int = 1
)
	RETURNS int
AS
BEGIN
	declare @rtn 								int		set @rtn 							= 190
	set @nextlv_ = @nextlv_ - 1
	set @nextlv_ = case
						when (@nextlv_ <= 0) then 0
						else					  @nextlv_
					end



	if( @mode_ = 1 )
		begin
			-- 하트.
			if( @grade_ = 1 )
				begin
					set @rtn = 30 + @nextlv_ * 4
				end
			else if( @grade_ = 2 )
				begin
					set @rtn = 35 + @nextlv_ * 5
				end
			else if( @grade_ = 3 )
				begin
					set @rtn = 40 + @nextlv_ * 6
				end
			else if( @grade_ = 4 )
				begin
					set @rtn = 50 + @nextlv_ * 7
				end
			else if( @grade_ = 5 )
				begin
					set @rtn = 60 + @nextlv_ * 10
				end
			else
				begin
					set @rtn = 65 + @nextlv_ * 10
				end
		end
	else if( @mode_ = 2 )
		begin
			-- 캐쉬.
			if( @grade_ = 1 )
				begin
					set @rtn = 100 + @nextlv_ * 50
				end
			else if( @grade_ = 2 )
				begin
					set @rtn = 200 + @nextlv_ * 75
				end
			else if( @grade_ = 3 )
				begin
					set @rtn = 300 + @nextlv_ * 100
				end
			else if( @grade_ = 4 )
				begin
					set @rtn = 500 + @nextlv_ * 150
				end
			else if( @grade_ = 5 )
				begin
					set @rtn = 800 + @nextlv_ * 200
				end
			else
				begin
					set @rtn = 900 + @nextlv_ * 250
				end
		end
	else if( @mode_ = 3 )
		begin
			-- 캐쉬.
			if( @grade_ = 1 )
				begin
					set @rtn = 50 + @nextlv_ * 10
				end
			else if( @grade_ = 2 )
				begin
					set @rtn = 70 + @nextlv_ * 15
				end
			else if( @grade_ = 3 )
				begin
					set @rtn = 90 + @nextlv_ * 20
				end
			else if( @grade_ = 4 )
				begin
					set @rtn = 110 + @nextlv_ * 25
				end
			else if( @grade_ = 5 )
				begin
					set @rtn = 130 + @nextlv_ * 30
				end
			else
				begin
					set @rtn = 140 + @nextlv_ * 40
				end
		end


	RETURN @rtn
END
