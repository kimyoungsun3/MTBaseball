use Game4FarmVill3
GO
/*
-- (1000%) 랜덤값을 얻자.
--
select dbo.fnu_FVBoxRewardKind(7000,    7000, 3000,  0, 0,   1, 2, 3, 4)
select dbo.fnu_FVBoxRewardKind(7001,    7000, 3000,  0, 0,   1, 2, 3, 4)

select dbo.fnu_FVBoxRewardKind(7000,    7000, 2900, 98, 2,   1, 2, 3, 4)
select dbo.fnu_FVBoxRewardKind(9900,    7000, 2900, 98, 2,   1, 2, 3, 4)
select dbo.fnu_FVBoxRewardKind(9998,    7000, 2900, 98, 2,   1, 2, 3, 4)
select dbo.fnu_FVBoxRewardKind(9999,    7000, 2900, 98, 2,   1, 2, 3, 4)
*/


IF OBJECT_ID ( N'dbo.fnu_FVBoxRewardKind', N'FN' ) IS NOT NULL
	DROP FUNCTION dbo.fnu_FVBoxRewardKind;
GO

CREATE FUNCTION dbo.fnu_FVBoxRewardKind(
	@rand_					int,

	@group1_ 				int,
	@group2_ 				int,
	@group3_ 				int,
	@group4_ 				int,

	@pack1_  				int,
	@pack2_  				int,
	@pack3_  				int,
	@pack4_  				int

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
	-- 3차 선택.
	---------------------------------
	set @rtn = case
					when @idx =  4 then @pack4_
					when @idx =  3 then @pack3_
					when @idx =  2 then @pack2_
					else                @pack1_
				end
	--select 'DEBUG ', @rand rand, @idx idx, @rtn rtn


	RETURN @rtn
END
