
/*
-- 쿠폰룰렛 등장확률.
select dbo.fun_getZCPChance(  0, 0,     1)	-- 거래(0)  -> 2분   1		-> 60/120
select dbo.fun_getZCPChance( 10, 0,  5000)	-- 작물(10) -> 10분  1		-> 12/120
select dbo.fun_getZCPChance( 20, 0, 10000)	-- 박스(20) -> 120분 1 		->  1/120

*/
use Game4Farmvill5
GO

IF OBJECT_ID ( N'dbo.fun_getZCPChance', N'FN' ) IS NOT NULL
	DROP FUNCTION dbo.fun_getZCPChance;
GO

CREATE FUNCTION dbo.fun_getZCPChance(
	@mode_					int = 0,
	@plus_					int = 0,
	@rand_					int = 0
)
	RETURNS int
AS
BEGIN
	-- 짜요쿠폰조각 룰렛 등장확률.
	declare @ZAYO_PIECE_CHANCE_ONE				int					set @ZAYO_PIECE_CHANCE_ONE					= 1		-- 있음 ( 1)
	declare @ZAYO_PIECE_CHANCE_NON				int					set @ZAYO_PIECE_CHANCE_NON					= -1	-- 없음 (-1)

	declare @rtn 		int			set @rtn 			= -1
	declare @rangval 	int			set @rangval 		= 10000

	-----------------------------------------------------------------
	--				9960	9800	8000	-> (0)
	-- 1	10000	31		190		2012	1860	2280	2012
	--
	--
	--				9970	9900	9500	-> (0)
	-- 1	10000	28		109		526		1680	1308	526
	--				9970	9900	9500	-> (100)
	-- 1	10000	120		218		615		7200	2616	615
	--
	-- 29	110	 498
	-----------------------------------------------------------------
	if(      @mode_ in ( 0 ) )
		begin
			set @rand_ 		= @plus_ + @rand_
			set @rangval	= 10000 - 500
		end
	else if( @mode_ in ( 10 ) )
		begin
			set @rand_ 		= @plus_ + @rand_
			set @rangval	= 10000 - 250

		end
	else if( @mode_ in ( 20 ) )
		begin
			set @rand_ 		= @plus_ + @rand_
			set @rangval	= 10000 - 1000
		end
	else
		begin
			set @rand_ 		= 0
			set @rangval 	= 10000
		end

	set @rtn = case
					when (@rand_ > @rangval ) then @ZAYO_PIECE_CHANCE_ONE
					else			  			   @ZAYO_PIECE_CHANCE_NON
				end

	RETURN @rtn
END
