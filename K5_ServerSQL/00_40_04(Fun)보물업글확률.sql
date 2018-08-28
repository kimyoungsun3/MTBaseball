
/*
-- 보물업글 확률
declare @grade 	int

set @grade = 1
while ( @grade <= 6 )
	begin
		select dbo.fun_GetTSUpgradeProbability( @grade, 1), dbo.fun_GetTSUpgradeProbability( @grade, 2), dbo.fun_GetTSUpgradeProbability( @grade, 3), dbo.fun_GetTSUpgradeProbability( @grade, 4), dbo.fun_GetTSUpgradeProbability( @grade, 5), dbo.fun_GetTSUpgradeProbability( @grade, 6), dbo.fun_GetTSUpgradeProbability( @grade, 7)
			    , dbo.fun_GetTSUpgradeProbability( @grade, 8)
				, dbo.fun_GetTSUpgradeProbability( @grade, 9)
				, dbo.fun_GetTSUpgradeProbability( @grade, 10)
				, dbo.fun_GetTSUpgradeProbability( @grade, 11)

		set @grade = @grade + 1
	end


*/
use Game4Farmvill5
GO

IF OBJECT_ID ( N'dbo.fun_GetTSUpgradeProbability', N'FN' ) IS NOT NULL
	DROP FUNCTION dbo.fun_GetTSUpgradeProbability;
GO

CREATE FUNCTION dbo.fun_GetTSUpgradeProbability(
	@grade_					int = 1,
	@nextlv_				int = 1
)
	RETURNS int
AS
BEGIN
	declare @rtn 								int		set @rtn 							= 0
	set @nextlv_ = case
						when (@nextlv_ <= 1)  then 1
						when (@nextlv_ >= 10) then 10
						else					  @nextlv_
					end

	if( @grade_ = 1 )
		begin
			set @rtn = case
							when @nextlv_ <= 1 then 1000
							when @nextlv_ <= 2 then 900
							when @nextlv_ <= 3 then 800
							when @nextlv_ <= 4 then 700
							when @nextlv_ <= 5 then 600
							when @nextlv_ <= 6 then 500
							when @nextlv_ <= 7 then 400	-- 정규
							when @nextlv_ <= 8 then 200
							when @nextlv_ <= 9 then 100
							when @nextlv_ <= 10 then 50
							else					 10
						end
		end
	else if( @grade_ = 2 )
		begin
			set @rtn = case
							when @nextlv_ <= 1 then 900
							when @nextlv_ <= 2 then 800
							when @nextlv_ <= 3 then 700
							when @nextlv_ <= 4 then 600
							when @nextlv_ <= 5 then 500
							when @nextlv_ <= 6 then 400
							when @nextlv_ <= 7 then 300	-- 정규
							when @nextlv_ <= 8 then 150
							when @nextlv_ <= 9 then  75
							when @nextlv_ <= 10 then 30
							else					 10
						end
		end
	else if( @grade_ = 3 )
		begin
			set @rtn = case
							when @nextlv_ <= 1 then 800
							when @nextlv_ <= 2 then 700
							when @nextlv_ <= 3 then 600
							when @nextlv_ <= 4 then 500
							when @nextlv_ <= 5 then 400
							when @nextlv_ <= 6 then 300
							when @nextlv_ <= 7 then 200-- 정규
							when @nextlv_ <= 8 then 100
							when @nextlv_ <= 9 then  50
							when @nextlv_ <= 10 then 25
							else					 10
						end
		end
	else if( @grade_ = 4 )
		begin
			set @rtn = case
							when @nextlv_ <= 1 then 700
							when @nextlv_ <= 2 then 600
							when @nextlv_ <= 3 then 500
							when @nextlv_ <= 4 then 400
							when @nextlv_ <= 5 then 300
							when @nextlv_ <= 6 then 200
							when @nextlv_ <= 7 then 100-- 정규
							when @nextlv_ <= 8 then  50
							when @nextlv_ <= 9 then  40
							when @nextlv_ <= 10 then 25
							else					 10
						end
		end
	else if( @grade_ = 5 )
		begin
			set @rtn = case
							when @nextlv_ <= 1 then 600
							when @nextlv_ <= 2 then 500
							when @nextlv_ <= 3 then 400
							when @nextlv_ <= 4 then 300
							when @nextlv_ <= 5 then 200
							when @nextlv_ <= 6 then 100
							when @nextlv_ <= 7 then  50-- 정규
							when @nextlv_ <= 8 then  50
							when @nextlv_ <= 9 then  40
							when @nextlv_ <= 10 then 25
							else					 10
						end
		end
	else
		begin
			set @rtn = case
							when @nextlv_ <= 1 then 600
							when @nextlv_ <= 2 then 500
							when @nextlv_ <= 3 then 400
							when @nextlv_ <= 4 then 300
							when @nextlv_ <= 5 then 200
							when @nextlv_ <= 6 then 100
							when @nextlv_ <= 7 then  50-- 정규
							when @nextlv_ <= 8 then  50
							when @nextlv_ <= 9 then  40
							when @nextlv_ <= 10 then 25
							else					 10
						end
		end


	RETURN @rtn
END
