/*
-----------------------------------------------------
--		  		       lv <= exp
select dbo.fnu_GetTax100FromLevel(       -1 ) -- 0         0
select dbo.fnu_GetTax100FromLevel(        0 ) -- 0         0
select dbo.fnu_GetTax100FromLevel(       29 ) -- 0         0
select dbo.fnu_GetTax100FromLevel(       30 ) -- 0.30%    30
select dbo.fnu_GetTax100FromLevel(      149 ) -- 1.20%   120
select dbo.fnu_GetTax100FromLevel(      150 ) -- 1.50%   150
select dbo.fnu_GetTax100FromLevel(      629 ) -- 6.00%   600
select dbo.fnu_GetTax100FromLevel(      630 ) -- 6.30%   630
select dbo.fnu_GetTax100FromLevel(    70000 ) -- 6.30%   630

-- float 계산
select dbo.fnu_GetTax100FromLevel(       30 )/10000.0			-- 0.30%    30
select dbo.fnu_GetTax100FromLevel(       30 )/10000.0 * 1000	-- 0.30%    30

-- int  계산
select dbo.fnu_GetTax100FromLevel(       30 )					-- 0.30%    30
select dbo.fnu_GetTax100FromLevel(       30 ) * 1000 / 10000	-- 0.30%    30

-----------------------------------------------------
*/
use GameMTBaseball
GO

IF OBJECT_ID ( N'dbo.fnu_GetTax100FromLevel', N'FN' ) IS NOT NULL
	DROP FUNCTION dbo.fnu_GetTax100FromLevel;
GO

CREATE FUNCTION dbo.fnu_GetTax100FromLevel(
	@level_  			int
)
	RETURNS int
AS
BEGIN
	declare @rtn 		int	set @rtn 		= 0

	-- (@level_ / 30 ) * 0.3
	select @rtn = (@level_ / 30 ) * 3 * 10

	set @rtn = case
					when @rtn <    0 then 	0		-- 0   -> 0%
					when @rtn >  630 then 	630		-- 630 -> 6.30%
					else @rtn
				end

	RETURN @rtn
END