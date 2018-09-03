/*
-----------------------------------------------------
--		  		     min <= x < max
select dbo.fnu_GetRandom( 100, 1000)
-----------------------------------------------------
*/
use GameMTBaseball
GO

-----------------------------------------------------
-- RAND임시 뷰어 생성...
-- rand() 함수는 대표적인 비확정적함수로서 사용자정의함수에 직접사용이 불가능하기 때문이라는군요.
-- VIEW -> 통해서 보기....	
-----------------------------------------------------
IF OBJECT_ID (N'dbo.tRandView', N'V') IS NOT NULL
	DROP view dbo.tRandView;
GO
CREATE VIEW dbo.tRandView  AS SELECT RAND() AS random_num
GO

-----------------------------------------------------
-- 프로시젼 생성....
-----------------------------------------------------
IF OBJECT_ID ( N'dbo.fnu_GetRandom', N'FN' ) IS NOT NULL
	DROP FUNCTION dbo.fnu_GetRandom;
GO

CREATE FUNCTION dbo.fnu_GetRandom(
	@min_  			int,
	@max_  			int
)
	RETURNS int
AS
BEGIN
	declare @rtn 		int	set @rtn 		= 0
	declare @mm			int set @mm	= @max_ - @min_
	
	-- set @rtn = ( @min_ + Convert(int, ceiling(RAND() * @mm)) ) - 1
	select @rtn = ( @min_ + Convert(int, ceiling(random_num * @mm)) ) - 1
  	FROM dbo.tRandView; 
	
	RETURN @rtn
END