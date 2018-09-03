use Game4FarmVill3
GO
/*
-- (1000%) 랜덤값을 얻자.
--
select dbo.fnu_FVBoxRewardValue(2,    1,   1,  0, 0)
select dbo.fnu_FVBoxRewardValue(1,    1.5, 2,  0, 0)
select dbo.fnu_FVBoxRewardValue(1,    2,   3,  0, 0)
select dbo.fnu_FVBoxRewardValue(2,    4,   4,  0, 0)

select dbo.fnu_FVBoxRewardValue(2,    1,   1,  1, 1)
select dbo.fnu_FVBoxRewardValue(1,    1.5, 2,  2, 1)
select dbo.fnu_FVBoxRewardValue(3,    2,   3,  3, 1)
select dbo.fnu_FVBoxRewardValue(4,    3,   4,  4, 1)
*/


IF OBJECT_ID ( N'dbo.fnu_FVBoxRewardValue', N'FN' ) IS NOT NULL
	DROP FUNCTION dbo.fnu_FVBoxRewardValue;
GO

CREATE FUNCTION dbo.fnu_FVBoxRewardValue(
	@kind_					int,

	@pack1_  				decimal(4,1),
	@pack2_  				decimal(4,1),
	@pack3_  				decimal(4,1),
	@pack4_  				decimal(4,1)

)
	RETURNS decimal(4,1)
AS
BEGIN

	declare @rtn 			decimal(4,1)	set @rtn 		= -1
	declare @idx			int 			set @idx		= 1

	set @idx = @kind_

	---------------------------------
	-- 3차 선택.
	---------------------------------
	set @rtn = case
					when @idx =  4 then @pack4_
					when @idx =  3 then @pack3_
					when @idx =  2 then @pack2_
					else                @pack1_
				end


	RETURN @rtn
END
