use Game4FarmVill3
GO
/*
select dbo.fnu_FVGetCrossRandom2(1, 		1, 2, 3, 4, 5,  6, 7, 8, 9, 10, 11, 12)
select dbo.fnu_FVGetCrossRandom2(10, 		1, 2, 3, 4, 5,  6, 7, 8, 9, 10, 11, 12)
select dbo.fnu_FVGetCrossRandom2(20, 		1, 2, 3, 4, 5,  6, 7, 8, 9, 10, 11, 12)
select dbo.fnu_FVGetCrossRandom2(30, 		1, 2, 3, 4, 5,  6, 7, 8, 9, 10, 11, 12)
select dbo.fnu_FVGetCrossRandom2(40, 		1, 2, 3, 4, 5,  6, 7, 8, 9, 10, 11, 12)
select dbo.fnu_FVGetCrossRandom2(50, 		1, 2, 3, 4, 5,  6, 7, 8, 9, 10, 11, 12)
select dbo.fnu_FVGetCrossRandom2(60, 		1, 2, 3, 4, 5,  6, 7, 8, 9, 10, 11, 12)
select dbo.fnu_FVGetCrossRandom2(70, 		1, 2, 3, 4, 5,  6, 7, 8, 9, 10, 11, 12)
select dbo.fnu_FVGetCrossRandom2(80, 		1, 2, 3, 4, 5,  6, 7, 8, 9, 10, 11, 12)
select dbo.fnu_FVGetCrossRandom2(90, 		1, 2, 3, 4, 5,  6, 7, 8, 9, 10, 11, 12)
select dbo.fnu_FVGetCrossRandom2(93, 		1, 2, 3, 4, 5,  6, 7, 8, 9, 10, 11, 12)
select dbo.fnu_FVGetCrossRandom2(96, 		1, 2, 3, 4, 5,  6, 7, 8, 9, 10, 11, 12)
select dbo.fnu_FVGetCrossRandom2(99, 		1, 2, 3, 4, 5,  6, 7, 8, 9, 10, 11, 12)
select dbo.fnu_FVGetCrossRandom2(100, 	    1, 2, 3, 4, 5,  6, 7, 8, 9, 10, 11, 12)
*/

IF OBJECT_ID ( N'dbo.fnu_FVGetCrossRandom2', N'FN' ) IS NOT NULL
	DROP FUNCTION dbo.fnu_FVGetCrossRandom2;
GO

CREATE FUNCTION dbo.fnu_FVGetCrossRandom2(
	@rand_					int,

	@pack1_  				int,
	@pack2_  				int,
	@pack3_  				int,
	@pack4_  				int,
	@pack5_  				int,
	@pack6_  				int,
	@pack7_  				int,
	@pack8_  				int,
	@pack9_  				int,
	@pack10_  				int,
	@pack11_  				int,
	@pack12_  				int
)
	RETURNS int
AS
BEGIN
	declare @rtn 			int		set @rtn 		= -1

	------------------------------------------------------------------
	-- 1차 내부선택.(함수내에서 RAND, ceiling를 사용못함).
	------------------------------------------------------------------
	set @rtn = case
					when @rand_ >= 96 then @pack12_
					when @rand_ >= 93 then @pack11_
					when @rand_ >= 90 then @pack10_
					when @rand_ >= 80 then @pack9_
					when @rand_ >= 70 then @pack8_
					when @rand_ >= 60 then @pack7_
					when @rand_ >= 50 then @pack6_
					when @rand_ >= 40 then @pack5_
					when @rand_ >= 30 then @pack4_
					when @rand_ >= 20 then @pack3_
					when @rand_ >= 10 then @pack2_
					else              	   @pack1_
				end
	RETURN @rtn
END