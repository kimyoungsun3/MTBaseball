﻿use Game4FarmVill3
GO
/*
-- (1000%) 랜덤값을 얻자.
--							    10000분률, 5분률,   내부확률,                 리스트번호
select dbo.fnu_FVGetCrossRandom(50,        1,		10000,     0,     0,     0,   1, 2, 3, 4, 5,  6, 7, 8, 9, 10, 11, 12, 13, 14, 15,  16, 17, 18, 19, 20, 21, 22, 23, 24, 25,  26, 27, 28, 29, 30, 31, 32, 33, 34, 35,  36, 37, 38, 39, 40)
select dbo.fnu_FVGetCrossRandom(51,        2,		    0, 10000,     0,     0,   1, 2, 3, 4, 5,  6, 7, 8, 9, 10, 11, 12, 13, 14, 15,  16, 17, 18, 19, 20, 21, 22, 23, 24, 25,  26, 27, 28, 29, 30, 31, 32, 33, 34, 35,  36, 37, 38, 39, 40)
select dbo.fnu_FVGetCrossRandom(850,       3,		    0,     0, 10000,     0,   1, 2, 3, 4, 5,  6, 7, 8, 9, 10, 11, 12, 13, 14, 15,  16, 17, 18, 19, 20, 21, 22, 23, 24, 25,  26, 27, 28, 29, 30, 31, 32, 33, 34, 35,  36, 37, 38, 39, 40)
select dbo.fnu_FVGetCrossRandom(851,       4,		    0,     0,     0, 10000,   1, 2, 3, 4, 5,  6, 7, 8, 9, 10, 11, 12, 13, 14, 15,  16, 17, 18, 19, 20, 21, 22, 23, 24, 25,  26, 27, 28, 29, 30, 31, 32, 33, 34, 35,  36, 37, 38, 39, 40)
select dbo.fnu_FVGetCrossRandom(950,       5,		    0,  8000,  1000,  1000,   1, 2, 3, 4, 5,  6, 7, 8, 9, 10, 11, 12, 13, 14, 15,  16, 17, 18, 19, 20, 21, 22, 23, 24, 25,  26, 27, 28, 29, 30, 31, 32, 33, 34, 35,  36, 37, 38, 39, 40)
select dbo.fnu_FVGetCrossRandom(951,       6,		    0,  8000,  1000,  1000,   1, 2, 3, 4, 5,  6, 7, 8, 9, 10, 11, 12, 13, 14, 15,  16, 17, 18, 19, 20, 21, 22, 23, 24, 25,  26, 27, 28, 29, 30, 31, 32, 33, 34, 35,  36, 37, 38, 39, 40)

select dbo.fnu_FVGetCrossRandom(3549,      7,		    0,     0,  3550,   6450,  1, 2, 3, 4, 5,  6, 7, 8, 9, 10, 11, 12, 13, 14, 15,  16, 17, 18, 19, 20, 21, 22, 23, 24, 25,  26, 27, 28, 29, 30, 31, 32, 33, 34, 35,  36, 37, 38, 39, 40)
select dbo.fnu_FVGetCrossRandom(3551,      8,		    0,     0,  3550,   6450,  1, 2, 3, 4, 5,  6, 7, 8, 9, 10, 11, 12, 13, 14, 15,  16, 17, 18, 19, 20, 21, 22, 23, 24, 25,  26, 27, 28, 29, 30, 31, 32, 33, 34, 35,  36, 37, 38, 39, 40)
*/

IF OBJECT_ID ( N'dbo.fnu_FVGetCrossRandom', N'FN' ) IS NOT NULL
	DROP FUNCTION dbo.fnu_FVGetCrossRandom;
GO

CREATE FUNCTION dbo.fnu_FVGetCrossRandom(
	@rand_					int,
	@rand2_					int,

	@group1_ 				int,
	@group2_ 				int,
	@group3_ 				int,
	@group4_ 				int,

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
	declare @rtn 			int		set @rtn 		= -1
	declare @rand 			int		set @rand 		= 1
	declare @idx			int 	set @idx		= 1			-- [1                  ] [2                  ] [3                  ] [4                  ]
																-- [1 2 3 4 5 6 7 8 9 0] [1 2 3 4 5 6 7 8 9 0] [1 2 3 4 5 6 7 8 9 0] [1 2 3 4 5 6 7 8 9 0]
	declare @group1			int
	declare @group2			int
	declare @group3			int
	declare @group4			int		set @group4		= 100 * 100

	---------------------------------
	-- 	확률 정리하기.
	---------------------------------
	set @group1 = @group1_
	set @group2 = @group1_ + @group2_
	set @group3 = @group1_ + @group2_ + @group3_
	set @group4 = @group1_ + @group2_ + @group3_ + @group4_


	---------------------------------
	-- 1차 그룹 뽑기확률.
	-- 1 <= x <= n > 밖에서 만들어져서 들어옴.
	-- set @rand = Convert(int, ceiling(RAND() * 1000)) > 밖에서 만들어져서 들어옴.
	---------------------------------
	set @rand = case
					when @rand_ > @group4 then 1
					else                       @rand_
				end

	if(@rand <= @group1)
		begin
			set @idx = 1
		end
	else if(@rand <= @group2)
		begin
			set @idx = 2
		end
	else if(@rand <= @group3)
		begin
			set @idx = 3
		end
	else
		begin
			set @idx = 4
		end


	---------------------------------
	-- 2차 내부선택.
	-- set @rrrr = Convert(int, ceiling(RAND() * 10)) > 밖에서 만들어져서 들어옴.
	---------------------------------
	set @rand = case
					when @rand2_ > 10 then 1
					else @rand2_
				end
	set @idx = (@idx - 1) * 10 + @rand

	---------------------------------
	-- 3차 선택.
	---------------------------------
	set @rtn = case
					when @idx = 40 then @pack40_
					when @idx = 39 then @pack39_
					when @idx = 38 then @pack38_
					when @idx = 37 then @pack37_
					when @idx = 36 then @pack36_
					when @idx = 35 then @pack35_
					when @idx = 34 then @pack34_
					when @idx = 33 then @pack33_
					when @idx = 32 then @pack32_
					when @idx = 31 then @pack31_

					when @idx = 30 then @pack30_
					when @idx = 29 then @pack29_
					when @idx = 28 then @pack28_
					when @idx = 27 then @pack27_
					when @idx = 26 then @pack26_
					when @idx = 25 then @pack25_
					when @idx = 24 then @pack24_
					when @idx = 23 then @pack23_
					when @idx = 22 then @pack22_
					when @idx = 21 then @pack21_

					when @idx = 20 then @pack20_
					when @idx = 19 then @pack19_
					when @idx = 18 then @pack18_
					when @idx = 17 then @pack17_
					when @idx = 16 then @pack16_
					when @idx = 15 then @pack15_
					when @idx = 14 then @pack14_
					when @idx = 13 then @pack13_
					when @idx = 12 then @pack12_
					when @idx = 11 then @pack11_

					when @idx = 10 then @pack10_
					when @idx =  9 then @pack9_
					when @idx =  8 then @pack8_
					when @idx =  7 then @pack7_
					when @idx =  6 then @pack6_
					when @idx =  5 then @pack5_
					when @idx =  4 then @pack4_
					when @idx =  3 then @pack3_
					when @idx =  2 then @pack2_
					else                @pack1_
				end


	RETURN @rtn
END