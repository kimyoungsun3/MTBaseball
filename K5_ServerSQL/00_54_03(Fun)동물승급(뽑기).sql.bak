/*
								확률		뽑을동물				각확률( 0 포함안됨 )
select dbo.fnu_GetRandomPromote( 950,		1,	2,	3,	-1,	-1,		950,  50,   0,  0, 	0)
select dbo.fnu_GetRandomPromote( 950,		1,	2,	3,	-1,	-1,		900,   0, 100,  0, 	0)
select dbo.fnu_GetRandomPromote( 950,		1,	2,	3,	-1,	-1,		900,  50,  50,  0, 	0)
*/
use Game4Farmvill5
GO

IF OBJECT_ID ( N'dbo.fnu_GetRandomPromote', N'FN' ) IS NOT NULL
	DROP FUNCTION dbo.fnu_GetRandomPromote;
GO

CREATE FUNCTION dbo.fnu_GetRandomPromote(
	@rand_					int,
	@result1_				int,
	@result2_				int,
	@result3_				int,
	@result4_				int,
	@result5_				int,
	@randvalue1_			int,
	@randvalue2_			int,
	@randvalue3_			int,
	@randvalue4_			int,
	@randvalue5_			int
)
	RETURNS int
AS
BEGIN
	declare @rtn 			int		set @rtn 			= -1
	declare @group1			int
	declare @group2			int
	declare @group3			int
	declare @group4			int
	declare @group5			int

	-- 그룹설정.
	set @group1	= @randvalue1_
	set @group2	= @randvalue1_ + @randvalue2_
	set @group3	= @randvalue1_ + @randvalue2_ + @randvalue3_
	set @group4	= @randvalue1_ + @randvalue2_ + @randvalue3_ + @randvalue4_
	set @group5	= @randvalue1_ + @randvalue2_ + @randvalue3_ + @randvalue4_ + @randvalue5_

	---------------------------------
	-- set @rrrr = Convert(int, ceiling(RAND() * 10)) > 밖에서 만들어져서 들어옴.
	---------------------------------
	set @rtn = case
					when (@rand_ <= @group1 and @randvalue1_ != 0) then @result1_
					when (@rand_ <= @group2 and @randvalue2_ != 0) then @result2_
					when (@rand_ <= @group3 and @randvalue3_ != 0) then @result3_
					when (@rand_ <= @group4 and @randvalue4_ != 0) then @result4_
					when (@rand_ <= @group5 and @randvalue5_ != 0) then @result5_
					else												@result1_
				end

	RETURN @rtn
END