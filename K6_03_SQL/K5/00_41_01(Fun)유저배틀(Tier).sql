
/*
select dbo.fun_GetTier( 0   )
select dbo.fun_GetTier( 400 )
select dbo.fun_GetTier( 1100 )
select dbo.fun_GetTier( 1400 )
select dbo.fun_GetTier( 1700 )
select dbo.fun_GetTier( 2000 )
select dbo.fun_GetTier( 3000 )
*/
use GameMTBaseball
GO

IF OBJECT_ID ( N'dbo.fun_GetTier', N'FN' ) IS NOT NULL
	DROP FUNCTION dbo.fun_GetTier;
GO

CREATE FUNCTION dbo.fun_GetTier(
	@trophy_				int = 0
)
	RETURNS int
AS
BEGIN

	declare @rtn 					int				set @rtn 				= 1


	-- 하트.
	set @rtn = case
					when (@trophy_ <  400 ) then 1
					when (@trophy_ <  800 ) then 2
					when (@trophy_ < 1100 ) then 3
					when (@trophy_ < 1400 ) then 4
					when (@trophy_ < 1700 ) then 5
					when (@trophy_ < 2000 ) then 6
					when (@trophy_ < 2800 ) then 7
					else						 8
				end


	RETURN @rtn
END
