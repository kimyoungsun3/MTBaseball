use GameMTBaseball
GO
/*
select * from dbo.fnu_GetCrossRandom8(1, 		1, 2, 3, 4, 5, 6, 7, 8, 	11, 12, 13, 14, 15, 16, 17, 18, 	21, 22, 23, 24, 25, 26, 27, 28, 	10, 10, 10, 10, 10, 10, 10, 10)
select * from dbo.fnu_GetCrossRandom8(10, 		1, 2, 3, 4, 5, 6, 7, 8, 	11, 12, 13, 14, 15, 16, 17, 18, 	21, 22, 23, 24, 25, 26, 27, 28, 	10, 10, 10, 10, 10, 10, 10, 10)
select * from dbo.fnu_GetCrossRandom8(20, 		1, 2, 3, 4, 5, 6, 7, 8, 	11, 12, 13, 14, 15, 16, 17, 18, 	21, 22, 23, 24, 25, 26, 27, 28, 	10, 10, 10, 10, 10, 10, 10, 10)
select * from dbo.fnu_GetCrossRandom8(30, 		1, 2, 3, 4, 5, 6, 7, 8, 	11, 12, 13, 14, 15, 16, 17, 18, 	21, 22, 23, 24, 25, 26, 27, 28, 	10, 10, 10, 10, 10, 10, 10, 10)
select * from dbo.fnu_GetCrossRandom8(40, 		1, 2, 3, 4, 5, 6, 7, 8, 	11, 12, 13, 14, 15, 16, 17, 18, 	21, 22, 23, 24, 25, 26, 27, 28, 	10, 10, 10, 10, 10, 10, 10, 10)
select * from dbo.fnu_GetCrossRandom8(50, 		1, 2, 3, 4, 5, 6, 7, 8, 	11, 12, 13, 14, 15, 16, 17, 18, 	21, 22, 23, 24, 25, 26, 27, 28, 	10, 10, 10, 10, 10, 10, 10, 10)
select * from dbo.fnu_GetCrossRandom8(60, 		1, 2, 3, 4, 5, 6, 7, 8, 	11, 12, 13, 14, 15, 16, 17, 18, 	21, 22, 23, 24, 25, 26, 27, 28, 	10, 10, 10, 10, 10, 10, 10, 10)
select * from dbo.fnu_GetCrossRandom8(70, 		1, 2, 3, 4, 5, 6, 7, 8, 	11, 12, 13, 14, 15, 16, 17, 18, 	21, 22, 23, 24, 25, 26, 27, 28, 	10, 10, 10, 10, 10, 10, 10, 10)
select * from dbo.fnu_GetCrossRandom8(71, 		1, 2, 3, 4, 5, 6, 7, 8, 	11, 12, 13, 14, 15, 16, 17, 18, 	21, 22, 23, 24, 25, 26, 27, 28, 	10, 10, 10, 10, 10, 10, 10, 10)
select * from dbo.fnu_GetCrossRandom8(73, 		1, 2, 3, 4, 5, 6, 7, 8, 	11, 12, 13, 14, 15, 16, 17, 18, 	21, 22, 23, 24, 25, 26, 27, 28, 	10, 10, 10, 10, 10, 10, 10, 10)
select * from dbo.fnu_GetCrossRandom8(76, 		1, 2, 3, 4, 5, 6, 7, 8, 	11, 12, 13, 14, 15, 16, 17, 18, 	21, 22, 23, 24, 25, 26, 27, 28, 	10, 10, 10, 10, 10, 10, 10, 10)
select * from dbo.fnu_GetCrossRandom8(789, 		1, 2, 3, 4, 5, 6, 7, 8, 	11, 12, 13, 14, 15, 16, 17, 18, 	21, 22, 23, 24, 25, 26, 27, 28, 	10, 10, 10, 10, 10, 10, 10, 10)
*/

IF OBJECT_ID ( N'dbo.fnu_GetCrossRandom8', N'TF' ) IS NOT NULL
	DROP FUNCTION dbo.fnu_GetCrossRandom8;
GO

CREATE FUNCTION dbo.fnu_GetCrossRandom8(
	@rand_					int,

	@idx1_  				int,
	@idx2_  				int,
	@idx3_  				int,
	@idx4_  				int,
	@idx5_  				int,
	@idx6_  				int,
	@idx7_  				int,
	@idx8_  				int,

	@itemcode1_  			int,
	@itemcode2_  			int,
	@itemcode3_  			int,
	@itemcode4_  			int,
	@itemcode5_  			int,
	@itemcode6_  			int,
	@itemcode7_  			int,
	@itemcode8_  			int,

	@cnt1_  				int,
	@cnt2_  				int,
	@cnt3_  				int,
	@cnt4_  				int,
	@cnt5_  				int,
	@cnt6_  				int,
	@cnt7_  				int,
	@cnt8_  				int,

	@randval1_  			int,
	@randval2_  			int,
	@randval3_  			int,
	@randval4_  			int,
	@randval5_  			int,
	@randval6_  			int,
	@randval7_  			int,
	@randval8_  			int
)
	RETURNS
		@SPLIT_TABLE_TEMP TABLE (
			idx			int,
			itemcode	int,
			cnt			int
		)
AS
BEGIN
	declare @rtn 			int		set @rtn 		= -1

	declare @group1			int
	declare @group2			int
	declare @group3			int
	declare @group4			int
	declare @group5			int
	declare @group6			int
	declare @group7			int
	declare @group8			int

	------------------------------------------------------------------
	-- 확률 단계별로 정리.
	------------------------------------------------------------------
	set @group1		= 		    @randval1_
	set @group2		= @group1 + @randval2_
	set @group3		= @group2 + @randval3_
	set @group4		= @group3 + @randval4_
	set @group5		= @group4 + @randval5_
	set @group6		= @group5 + @randval6_
	set @group7		= @group6 + @randval7_
	set @group8		= @group7 + @randval8_



	------------------------------------------------------------------
	-- 1차 내부선택.(함수내에서 RAND, ceiling를 사용못함).
	------------------------------------------------------------------
	if( @rand_ <= @group1 )
		begin
			insert @SPLIT_TABLE_TEMP (idx,    itemcode,    cnt  )
			values 					(@idx1_, @itemcode1_, @cnt1_)
		end
	else if( @rand_ <= @group2 )
		begin
			insert @SPLIT_TABLE_TEMP (idx,    itemcode,    cnt  )
			values 					(@idx2_, @itemcode2_, @cnt2_)
		end
	else if( @rand_ <= @group3 )
		begin
			insert @SPLIT_TABLE_TEMP (idx,    itemcode,    cnt  )
			values 					(@idx3_, @itemcode3_, @cnt3_)
		end
	else if( @rand_ <= @group4 )
		begin
			insert @SPLIT_TABLE_TEMP (idx,    itemcode,    cnt  )
			values 					(@idx4_, @itemcode4_, @cnt4_)
		end
	else if( @rand_ <= @group5 )
		begin
			insert @SPLIT_TABLE_TEMP (idx,    itemcode,    cnt  )
			values 					(@idx5_, @itemcode5_, @cnt5_)
		end
	else if( @rand_ <= @group6 )
		begin
			insert @SPLIT_TABLE_TEMP (idx,    itemcode,    cnt  )
			values 					(@idx6_, @itemcode6_, @cnt6_)
		end
	else if( @rand_ <= @group7 )
		begin
			insert @SPLIT_TABLE_TEMP (idx,    itemcode,    cnt  )
			values 					(@idx7_, @itemcode7_, @cnt7_)
		end
	else
		begin
			insert @SPLIT_TABLE_TEMP (idx,    itemcode,    cnt  )
			values 					(@idx8_, @itemcode8_, @cnt8_)
		end


	RETURN
END