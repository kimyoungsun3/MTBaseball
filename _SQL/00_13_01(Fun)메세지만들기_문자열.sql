/*류
-- 관리자가(admin)이 (xxxx)를 블럭 처리했습니다.
select dbo.fnu_GetMessageString('관리자가(#1)이 (#2)를 블럭 처리했습니다.', 'admin', 'xxxx', '', '', '')
select dbo.fnu_GetMessageString('관리자가(#1)이 (#2)를 (#3:#4->#5) 지급했습니다.', 'admin', 'xxxx', '100', '10', '99')

*/
use GameMTBaseball
GO

IF OBJECT_ID ( N'dbo.fnu_GetMessageString', N'FN' ) IS NOT NULL
	DROP FUNCTION dbo.fnu_GetMessageString;
GO

CREATE FUNCTION dbo.fnu_GetMessageString(
	@comment 			varchar(256),
	@p1	 				varchar(256),
	@p2		 			varchar(256),
	@p3		 			varchar(256),
	@p4		 			varchar(256),
	@p5		 			varchar(256)
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

	if(@p3 != '')
		begin
			set @comment = REPLACE ( @comment , '#3' , @p3 )
		end

	if(@p4 != '')
		begin
			set @comment = REPLACE ( @comment , '#4' , @p4 )
		end

	if(@p5 != '')
		begin
			set @comment = REPLACE ( @comment , '#5' , @p4 )
		end


	RETURN @comment
END