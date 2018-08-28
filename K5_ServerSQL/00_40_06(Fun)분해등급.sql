
/*
-- 동물분해.
select dbo.fun_GetApartGrade( 1, 0)	-- 저급(0)
select dbo.fun_GetApartGrade( 1, 1)	-- 일반(1)
select dbo.fun_GetApartGrade( 1, 2)	-- 고급(2)
select dbo.fun_GetApartGrade( 1, 3)	-- 희귀(3)
select dbo.fun_GetApartGrade( 1, 4)	-- 황금(4)
select dbo.fun_GetApartGrade( 1, 5)	-- 전설(5)
select dbo.fun_GetApartGrade( 1, 6)	-- 붉은(6)
select dbo.fun_GetApartGrade( 1, 7)	-- 영웅(7)
select dbo.fun_GetApartGrade( 1, 8)	-- 지존(8)
select dbo.fun_GetApartGrade( 1, 9)	-- 신화(9)
select dbo.fun_GetApartGrade( 1, 10)-- 신화(10)

-- 보물분해.
select dbo.fun_GetApartGrade( 2, 1)	-- 일반(1)
select dbo.fun_GetApartGrade( 2, 2)	-- 고급(2)
select dbo.fun_GetApartGrade( 2, 3)	-- 희귀(3)
select dbo.fun_GetApartGrade( 2, 4)	-- 황금(4)
select dbo.fun_GetApartGrade( 2, 5)	-- 전설(5)
select dbo.fun_GetApartGrade( 2, 6)	-- 붉은(6)
*/
use Game4Farmvill5
GO

IF OBJECT_ID ( N'dbo.fun_GetApartGrade', N'FN' ) IS NOT NULL
	DROP FUNCTION dbo.fun_GetApartGrade;
GO

CREATE FUNCTION dbo.fun_GetApartGrade(
	@mode_					int = 1,
	@grade_					int = 0
)
	RETURNS int
AS
BEGIN
	declare @MODE_APART_ANIMAL					int					set @MODE_APART_ANIMAL						= 1
	declare @MODE_APART_TREASURE				int					set @MODE_APART_TREASURE					= 2

	declare @rtn 								int					set @rtn 									= -1

	if( @mode_ = @MODE_APART_ANIMAL )
		begin
			set @rtn = case
							when @grade_ = 0  then 1
							when @grade_ = 1  then 1
							when @grade_ = 2  then 2
							when @grade_ = 3  then 3
							when @grade_ = 4  then 4
							when @grade_ = 5  then 5
							when @grade_ = 6  then 5
							when @grade_ = 7  then 5
							when @grade_ = 8  then 5
							when @grade_ = 9  then 5
							when @grade_ = 10 then 5
							else				   -1
				end
		end
	else if( @mode_ = @MODE_APART_TREASURE )
		begin
			set @rtn = case
							when @grade_ = 1  then 1
							when @grade_ = 2  then 2
							when @grade_ = 3  then 3
							when @grade_ = 4  then 4
							when @grade_ = 5  then 5
							when @grade_ = 6  then 5
							else				   -1
				end
		end


	RETURN @rtn
END
