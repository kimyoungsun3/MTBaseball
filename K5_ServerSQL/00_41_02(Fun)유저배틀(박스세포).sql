
/*
-- 세포정보(일반).
select dbo.fun_GetBoxStemCell( 1, 1, 1 )
select dbo.fun_GetBoxStemCell( 1, 1000, 1 )
select dbo.fun_GetBoxStemCell( 1, 1000, 8 )

-- 세포정보(에픽).
select dbo.fun_GetBoxStemCell( 2, 1, 1    )
select dbo.fun_GetBoxStemCell( 2, 1000, 1 )
select dbo.fun_GetBoxStemCell( 2, 1000, 8 )
*/
use GameMTBaseball
GO

IF OBJECT_ID ( N'dbo.fun_GetBoxStemCell', N'FN' ) IS NOT NULL
	DROP FUNCTION dbo.fun_GetBoxStemCell;
GO

CREATE FUNCTION dbo.fun_GetBoxStemCell(
	@mode_				int = 1,
	@rand_				int = 0,
	@tier_				int = 1

)
	RETURNS int
AS
BEGIN
	declare @rtn 								int				set @rtn 									= 104000

	--------------------------------------------
	-- 일반모드 or 에픽모드.
	--------------------------------------------
	if( @mode_ = 1 )
		begin
			-- 세포정보(일반).
			set @rtn = case
							when (@rand_ <  200 ) then 104000
							when (@rand_ <  400 ) then 104001
							when (@rand_ <  600 ) then 104002
							when (@rand_ <  800 ) then 104003
							when (@rand_ <  900 ) then 104004
							else					   104005
						end

		end
	else
		begin
			-- 세포정보(에픽).
			set @rtn = 104006
		end

	--------------------------------------------
	-- 티어에 따른 지급.
	--------------------------------------------
	set @rtn = @rtn + case
							when @tier_ in ( 1       ) then 0
							when @tier_ in ( 2, 3    ) then 10
							when @tier_ in ( 4, 5    ) then 20
							when @tier_ in ( 6, 7, 8 ) then 30
							else				 		     0
					  end



	RETURN @rtn
END
