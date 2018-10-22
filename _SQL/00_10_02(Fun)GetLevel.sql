/*
-----------------------------------------------------
--		  		       lv <= exp
select dbo.fnu_GetLevel(       -1 ) -- 1
select dbo.fnu_GetLevel(        0 ) -- 1
select dbo.fnu_GetLevel(   100000 ) -- 1
select dbo.fnu_GetLevel(   100001 ) -- 2
select dbo.fnu_GetLevel(   205000 ) -- 2
select dbo.fnu_GetLevel(   205001 ) -- 3
select dbo.fnu_GetLevel(1116280000) -- 649
select dbo.fnu_GetLevel(1116280001) -- 650
select dbo.fnu_GetLevel(2022222222) -- 650
-----------------------------------------------------
*/
use GameMTBaseball
GO

IF OBJECT_ID ( N'dbo.fnu_GetLevel', N'FN' ) IS NOT NULL
	DROP FUNCTION dbo.fnu_GetLevel;
GO

CREATE FUNCTION dbo.fnu_GetLevel(
	@exp_  			int
)
	RETURNS int
AS
BEGIN
	declare @rtn 		int	set @rtn 		= 0
	-- select @rtn = (Sqrt ((@exp_ - 1) / 100 + 380.25) - 19.5) + 1;
	select @rtn = Sqrt (@exp_ - 1 + 950625)/50.0 - 37.0/2.0;
	set @rtn = case
					when @rtn <=   0 then 	1
					when @rtn >  650 then 	650
					else @rtn
				end

	RETURN @rtn
END