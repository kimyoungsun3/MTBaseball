/*
-----------------------------------------------------
--		  		       lv <= exp
select dbo.fnu_GetLevel(       -1 ) -- 1
select dbo.fnu_GetLevel(        0 ) -- 1
select dbo.fnu_GetLevel(       81 ) -- 1
select dbo.fnu_GetLevel(       82 ) -- 2
select dbo.fnu_GetLevel(     8100 ) -- 10
select dbo.fnu_GetLevel(     8101 ) -- 11
select dbo.fnu_GetLevel(  5904900 ) -- 270
select dbo.fnu_GetLevel(  5904901 ) -- 270

select dbo.fnu_GetLevel(  6718464 ) -- 288
select dbo.fnu_GetLevel(  6718465 ) -- 289
select dbo.fnu_GetLevel(  6907041 ) -- 290
select dbo.fnu_GetLevel(  6907042 ) -- 291
select dbo.fnu_GetLevel( 83037656 ) -- 540
select dbo.fnu_GetLevel( 83037657 ) -- 541
select dbo.fnu_GetLevel(172186884 ) -- 648
select dbo.fnu_GetLevel(172186885 ) -- 649
select dbo.fnu_GetLevel(173252229 ) -- 649 x
select dbo.fnu_GetLevel(173252230 ) -- 650 x
select dbo.fnu_GetLevel(174322510 ) -- 650 x

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
	-- select @rtn = Sqrt (@exp_ - 1 + 950625)/50.0 - 37.0/2.0;
	if ( @exp_ <= 6718464 )
		set @rtn = Sqrt ( (@exp_ - 1) / 81.0 ) + 1
	else
		set @rtn = CEILING( Sqrt ( Sqrt ( 1024.0 * @exp_ ) ) )

	set @rtn = case
					when @rtn <=   0 then 	1
					when @rtn >  650 then 	650
					else @rtn
				end


	RETURN @rtn
END