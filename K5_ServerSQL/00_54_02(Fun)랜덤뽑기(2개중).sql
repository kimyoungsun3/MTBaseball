/*
							 현재, 제한, 이상템, 이하템
select dbo.fnu_GetRandomStemTwo(1040, 10000, 3000, 104005,     -1)
select dbo.fnu_GetRandomStemTwo(1040,     0, 3000, 104005,     -1)
select dbo.fnu_GetRandomStemTwo(1040,  5000, 3000, 104015, 104005)
select dbo.fnu_GetRandomStemTwo(1040,     0, 3000, 104015, 104005)
select dbo.fnu_GetRandomStemTwo(1040,  1000, 3000, 104025, 104015)
select dbo.fnu_GetRandomStemTwo(1040,     0, 3000, 104025, 104015)
*/
use GameMTBaseball
GO

IF OBJECT_ID ( N'dbo.fnu_GetRandomStemTwo', N'FN' ) IS NOT NULL
	DROP FUNCTION dbo.fnu_GetRandomStemTwo;
GO

CREATE FUNCTION dbo.fnu_GetRandomStemTwo(
	@subcategory_			int,
	@rand_					int,
	@randlimit_				int,
	@pack1_  				int,
	@pack2_  				int
)
	RETURNS int
AS
BEGIN
	declare @rtn 			int		set @rtn 			= -1
	declare @limititemcode	int		set @limititemcode	= 104000

	-- 수행의 값이 그리 많이 안걸림.
	-- set @pack1_ = case when @pack1_ < @limititemcode then -1 else @pack1 end
	if( @pack1_ != -1 and not exists(select top 1 * from dbo.tItemInfo where itemcode = @pack1_ and subcategory = @subcategory_) )
		begin
			set @pack1_ = -1
		end

	if( @pack2_ != -1 and not exists(select top 1 * from dbo.tItemInfo where itemcode = @pack2_ and subcategory = @subcategory_) )
		begin
			set @pack2_ = -1
		end


	---------------------------------
	-- set @rrrr = Convert(int, ceiling(RAND() * 10)) > 밖에서 만들어져서 들어옴.
	---------------------------------
	set @rtn = case
					when @rand_ >= @randlimit_ then @pack1_
					else                            @pack2_
				end

	RETURN @rtn
END