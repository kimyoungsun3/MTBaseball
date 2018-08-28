-----------------------------------------------------
-- 일반교배(1) / 프리미엄(2)
-- select dbo.fnu_GetFVFindAnimal(1,        1411, 2, 3, 4, 5,  6, 7, 8, 9, 10, 11, 12, 13, 14, 15,  16, 17, 18, 19, 20, 21, 22, 23, 24, 25,  26, 27, 28, 29, 30, 31, 32, 33, 34, 35,  36, 37, 38, 39, 40)
-- select dbo.fnu_GetFVFindAnimal(2,        1, 2, 3, 4, 5,  6, 7, 8, 9, 10, 11, 12, 13, 14, 15,  16, 17, 18, 19, 20, 21, 22, 23, 24, 25,  26, 27, 28, 29, 30, 31, 32, 33, 34, 35,  36, 37, 38, 39, 40)
-----------------------------------------------------
use Farm
GO

IF OBJECT_ID ( N'dbo.fnu_GetFVFindAnimal', N'FN' ) IS NOT NULL
	DROP FUNCTION dbo.fnu_GetFVFindAnimal;
GO

CREATE FUNCTION dbo.fnu_GetFVFindAnimal(
	@mode_					int,

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
	@pack12_  				int,
	@pack13_  				int,
	@pack14_  				int,
	@pack15_  				int,
	@pack16_  				int,
	@pack17_  				int,
	@pack18_  				int,
	@pack19_  				int,
	@pack20_  				int,

	@pack21_  				int,
	@pack22_  				int,
	@pack23_  				int,
	@pack24_  				int,
	@pack25_  				int,
	@pack26_  				int,
	@pack27_  				int,
	@pack28_  				int,
	@pack29_  				int,
	@pack30_  				int,

	@pack31_  				int,
	@pack32_  				int,
	@pack33_  				int,
	@pack34_  				int,
	@pack35_  				int,
	@pack36_  				int,
	@pack37_  				int,
	@pack38_  				int,
	@pack39_  				int,
	@pack40_  				int
)
	RETURNS int
AS
BEGIN
	-- 교배뽑기 상수.
	declare @MODE_ROULETTE_NORMAL				int					set @MODE_ROULETTE_NORMAL					= 1	-- 일반교배.
	declare @MODE_ROULETTE_PREMINUM				int					set @MODE_ROULETTE_PREMINUM					= 2	-- 프리미엄교배.

	declare @rtn 			int		set @rtn 		= -1
	declare @idx			int 	set @idx		= 1			-- [1                  ] [2                  ] [3                  ] [4                  ]
																-- [1 2 3 4 5 6 7 8 9 0] [1 2 3 4 5 6 7 8 9 0] [1 2 3 4 5 6 7 8 9 0] [1 2 3 4 5 6 7 8 9 0]

	if(@mode_ = @MODE_ROULETTE_NORMAL)
		begin
			set @rtn = case
							when @pack1_  < 299  then @pack1_
							when @pack2_  < 299  then @pack2_
							when @pack3_  < 299  then @pack3_
							when @pack4_  < 299  then @pack4_
							when @pack5_  < 299  then @pack5_
							when @pack6_  < 299  then @pack6_
							when @pack7_  < 299  then @pack7_
							when @pack8_  < 299  then @pack8_
							when @pack9_  < 299  then @pack9_
							when @pack10_ < 299  then @pack10_

							when @pack11_ < 299  then @pack11_
							when @pack12_ < 299  then @pack12_
							when @pack13_ < 299  then @pack13_
							when @pack14_ < 299  then @pack14_
							when @pack15_ < 299  then @pack15_
							when @pack16_ < 299  then @pack16_
							when @pack17_ < 299  then @pack17_
							when @pack18_ < 299  then @pack18_
							when @pack19_ < 299  then @pack19_
							when @pack20_ < 299  then @pack20_
							else @pack1_
						end

		end
	else
		begin
			set @rtn = case
							when @pack21_ < 299  then @pack21_
							when @pack22_ < 299  then @pack22_
							when @pack23_ < 299  then @pack23_
							when @pack24_ < 299  then @pack24_
							when @pack25_ < 299  then @pack25_
							when @pack26_ < 299  then @pack26_
							when @pack27_ < 299  then @pack27_
							when @pack28_ < 299  then @pack28_
							when @pack29_ < 299  then @pack29_
							when @pack20_ < 299  then @pack20_

							when @pack31_ < 299  then @pack31_
							when @pack32_ < 299  then @pack32_
							when @pack33_ < 299  then @pack33_
							when @pack34_ < 299  then @pack34_
							when @pack35_ < 299  then @pack35_
							when @pack36_ < 299  then @pack36_
							when @pack37_ < 299  then @pack37_
							when @pack38_ < 299  then @pack38_
							when @pack39_ < 299  then @pack39_
							when @pack40_ < 299  then @pack40_
							else @pack21_
						end

		end

	RETURN @rtn
END