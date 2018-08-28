
----------------------------------------------------------------------
-- 동물번호자리체킹                             0  1  2     3  4  5      6   7  8
-- select dbo.fun_getUserItemFieldCheck(5,		1, 1, 1,	1, 1, 1,	-1, -1,-1)
-- select dbo.fun_getUserItemFieldCheck(6,		1, 1, 1,	1, 1, 1,	-1, -1,-1)
----------------------------------------------------------------------
use GameMTBaseball
GO

IF OBJECT_ID ( N'dbo.fun_getUserItemFieldCheck', N'FN' ) IS NOT NULL
	DROP FUNCTION dbo.fun_getUserItemFieldCheck;
GO

CREATE FUNCTION dbo.fun_getUserItemFieldCheck(
	@fieldidx_			int,

	@field0_			int,
	@field1_			int,
	@field2_			int,

	@field3_			int,
	@field4_			int,
	@field5_			int,

	@field6_			int,
	@field7_			int,
	@field8_			int
)
	RETURNS int
AS
BEGIN

	---------------------------------------------------
	-- 유효자인지 체킹
	-- 0  1  2     3  4  5      6   7  8
	-- 1, 1, 1,    1, 1, 1,    -1, -1,-1
	---------------------------------------------------
	if(@fieldidx_ = 5)
		begin
			set @fieldidx_ = case
								when (@field5_ = 1) then @fieldidx_
								else					 -1
							end
		end
	else if(@fieldidx_ = 6)
		begin
			set @fieldidx_ = case
								when (@field6_ = 1) then @fieldidx_
								else					 -1
							end
		end
	else if(@fieldidx_ = 7)
		begin
			set @fieldidx_ = case
								when (@field7_ = 1) then @fieldidx_
								else					 -1
							end
		end
	else if(@fieldidx_ = 8)
		begin
			set @fieldidx_ = case
								when (@field8_ = 1) then @fieldidx_
								else					 -1
							end
		end
	---------------------------
	-- 0, 1, 2,   4, 5	> 자동
	---------------------------
	--else
	--	begin
	--		set @fieldidx_ = @fieldidx_
	--	end


	RETURN @fieldidx_
END
