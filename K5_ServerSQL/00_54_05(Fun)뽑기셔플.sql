use GameMTBaseball
GO
/*
select * from dbo.fnu_GetShuffleCard(9, 		1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11)
select * from dbo.fnu_GetShuffleCard(10, 		1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11)
select * from dbo.fnu_GetShuffleCard(11, 		1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11)

select * from dbo.fnu_GetShuffleCard(99, 		1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1)
*/

IF OBJECT_ID ( N'dbo.fnu_GetShuffleCard', N'TF' ) IS NOT NULL
	DROP FUNCTION dbo.fnu_GetShuffleCard;
GO

CREATE FUNCTION dbo.fnu_GetShuffleCard(
	@rand_					int,

	@itemcode1_  			int,
	@itemcode2_  			int,
	@itemcode3_  			int,
	@itemcode4_  			int,
	@itemcode5_  			int,
	@itemcode6_  			int,
	@itemcode7_  			int,
	@itemcode8_  			int,
	@itemcode9_  			int,
	@itemcode10_  			int,
	@itemcode11_  			int
)
	RETURNS
		@SPLIT_TABLE_TEMP TABLE (
			itemcode1	int,
			itemcode2	int,
			itemcode3	int,
			itemcode4	int,
			itemcode5	int,
			itemcode6	int,
			itemcode7	int,
			itemcode8	int,
			itemcode9	int,
			itemcode10	int,
			itemcode11	int
		)
AS
BEGIN
	declare @tmp 			int		set @tmp 		= -1
	declare @rtn 			int		set @rtn 		= -1

	------------------------------------------------------------------
	-- 셔플하기.
	------------------------------------------------------------------
	if( @itemcode2_ = -1 )
		begin
			set @itemcode1_ = @itemcode1_
		end
	else if( @rand_ < 10 )
		begin
			set @tmp 		= @itemcode1_
			set @itemcode1_ = @itemcode2_
			set @itemcode2_	= @tmp
		end
	else if( @rand_ < 20 )
		begin
			set @tmp 		= @itemcode1_
			set @itemcode1_ = @itemcode3_
			set @itemcode3_	= @tmp
		end
	else if( @rand_ < 30 )
		begin
			set @tmp 		= @itemcode1_
			set @itemcode1_ = @itemcode4_
			set @itemcode4_	= @tmp
		end
	else if( @rand_ < 40 )
		begin
			set @tmp 		= @itemcode1_
			set @itemcode1_ = @itemcode5_
			set @itemcode5_	= @tmp
		end
	else if( @rand_ < 50 )
		begin
			set @tmp 		= @itemcode1_
			set @itemcode1_ = @itemcode6_
			set @itemcode6_	= @tmp
		end
	else if( @rand_ < 60 )
		begin
			set @tmp 		= @itemcode1_
			set @itemcode1_ = @itemcode7_
			set @itemcode7_	= @tmp
		end
	else if( @rand_ < 70 )
		begin
			set @tmp 		= @itemcode1_
			set @itemcode1_ = @itemcode8_
			set @itemcode8_	= @tmp
		end
	else if( @rand_ < 80 )
		begin
			set @tmp 		= @itemcode1_
			set @itemcode1_ = @itemcode9_
			set @itemcode9_	= @tmp
		end
	else if( @rand_ < 90 )
		begin
			set @tmp 		= @itemcode1_
			set @itemcode1_ = @itemcode10_
			set @itemcode10_	= @tmp
		end
	else
		begin
			set @tmp 		= @itemcode1_
			set @itemcode1_ = @itemcode11_
			set @itemcode11_	= @tmp
		end


	insert @SPLIT_TABLE_TEMP (  itemcode1,   itemcode2,   itemcode3,   itemcode4,   itemcode5,   itemcode6,   itemcode7,   itemcode8,   itemcode9,   itemcode10,   itemcode11 )
	values 					 ( @itemcode1_, @itemcode2_, @itemcode3_, @itemcode4_, @itemcode5_, @itemcode6_, @itemcode7_, @itemcode8_, @itemcode9_, @itemcode10_, @itemcode11_)


	RETURN
END