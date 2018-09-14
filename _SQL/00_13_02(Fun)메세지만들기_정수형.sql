/*류
-- 관리자가(admin)이 (xxxx)를 블럭 처리했습니다.
select dbo.fnu_GetMessageInt('관리자가(#1)이 (#2)를 블럭 처리했습니다.', 'admin', 'xxxx', -999, -999, -999)
select dbo.fnu_GetMessageInt('관리자가(#1)이 (#2)를 아이템(#3:#4->#5) 지급했습니다.', 'admin', 'xxxx', 100, 10, 99)

*/
use GameMTBaseball
GO

IF OBJECT_ID ( N'dbo.fnu_GetMessageInt', N'FN' ) IS NOT NULL
	DROP FUNCTION dbo.fnu_GetMessageInt;
GO

CREATE FUNCTION dbo.fnu_GetMessageInt(
	@comment 			varchar(256),
	@p1	 				varchar(256),
	@p2		 			varchar(256),
	@p3		 			int,
	@p4		 			int,
	@p5		 			int
)
	RETURNS varchar(256)
AS
BEGIN
	if(@p1 != '')
		begin
			set @comment = REPLACE ( @comment , '#1' , @p1 )
		end

	if(@p2 != '')
		begin
			set @comment = REPLACE ( @comment , '#2' , @p2 )
		end

	if(@p3 != -999)
		begin
			set @comment = REPLACE ( @comment , '#3' , CONVERT(varchar(10), @p3) )
		end

	if(@p4 != -999)
		begin
			set @comment = REPLACE ( @comment , '#4' , CONVERT(varchar(10), @p4) )
		end

	if(@p5 != -999)
		begin
			set @comment = REPLACE ( @comment , '#5' , CONVERT(varchar(10), @p5) )
		end


	RETURN @comment
END