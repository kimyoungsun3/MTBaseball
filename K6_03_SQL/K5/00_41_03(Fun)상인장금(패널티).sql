
/*
select dbo.fun_GetDealerStateValue( 1,  1, 100 )	-- 박스오픈 코인(1)
select dbo.fun_GetDealerStateValue( 2,  1, 2   )	-- 박스오픈 세포수량(2)
select dbo.fun_GetDealerStateValue( 11, 1, 100 )	-- 목장배틀 코인(11)
select dbo.fun_GetDealerStateValue( 12, 1, 2   )	-- 목장배틀 세포수량(12)

select dbo.fun_GetDealerStateValue( 1,  -1, 100 )	-- 박스오픈 코인(1)
select dbo.fun_GetDealerStateValue( 2,  -1, 1   )	-- 박스오픈 세포수량(2)
select dbo.fun_GetDealerStateValue( 11, -1, 100 )	-- 목장배틀 코인(11)
select dbo.fun_GetDealerStateValue( 12, -1, 1   )	-- 목장배틀 세포수량(12)

select dbo.fun_GetDealerStateValue( 1,  -1, 0   )	-- 박스오픈 코인(1)
select dbo.fun_GetDealerStateValue( 2,  -1, 0   )	-- 박스오픈 세포수량(2)
select dbo.fun_GetDealerStateValue( 11, -1, 0   )	-- 목장배틀 코인(11)
select dbo.fun_GetDealerStateValue( 12, -1, 0   )	-- 목장배틀 세포수량(12)

*/
use GameMTBaseball
GO

IF OBJECT_ID ( N'dbo.fun_GetDealerStateValue', N'FN' ) IS NOT NULL
	DROP FUNCTION dbo.fun_GetDealerStateValue;
GO

CREATE FUNCTION dbo.fun_GetDealerStateValue(
	@mode_				int =  1,
	@state_				int = -1,
	@val_				int =  0
)
	RETURNS int
AS
BEGIN
	-----------------------------------------------------------------------
	declare @rtn 			int				set @rtn 			= @val_

	-----------------------------------------------------------------------
	if( @mode_ in ( 1, 2, 11, 12) )
		begin
			--------------------------------------------
			-- 박스오픈 코인(1)
			--------------------------------------------
			set @rtn = case
							when (@state_ = -1 ) then @val_ * 80 / 100
							else					  @val_
						end

		end


	if(@val_ <= 0)
		begin
			set @rtn = @val_
		end
	else if( @rtn <= 0)
		begin
			set @rtn = 1
		end



	RETURN @rtn
END
