
/*
-- 게임배치
declare @loop int 	set @loop = 0
while(@loop <= 9)
	begin
		SELECT @loop, dbo.fnu_GetBallInfo(1, 1, @loop), dbo.fnu_GetBallInfo(1, 2, @loop), dbo.fnu_GetBallInfo(1, 3, @loop)
		set @loop = @loop + 1
	end

declare @loop int 	set @loop = 5
while(@loop <= 140)
	begin
		SELECT @loop, dbo.fnu_GetBallInfo(2, 1, @loop),  dbo.fnu_GetBallInfo(2, 2, @loop), dbo.fnu_GetBallInfo(2, 3, @loop), dbo.fnu_GetBallInfo(2, 4, @loop)
		set @loop = @loop + 1
	end
*/

use GameMTBaseball
GO

IF OBJECT_ID ( N'dbo.fnu_GetBallInfo', N'FN' ) IS NOT NULL
	DROP FUNCTION dbo.fnu_GetBallInfo;
GO

CREATE FUNCTION dbo.fnu_GetBallInfo(
	@mode_  			int,
	@kind_  			int,
	@ball_  			int
)
	RETURNS int
AS
BEGIN
	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------
	declare @MODE_POWERBALL				int					set	@MODE_POWERBALL					= 1;
	declare @MODE_TOTALBALL				int					set	@MODE_TOTALBALL					= 2;

	declare @KIND_GRADE					int					set	@KIND_GRADE						= 1;
	declare @KIND_EVENODD				int					set	@KIND_EVENODD					= 2;
	declare @KIND_UNDEROVER				int					set	@KIND_UNDEROVER					= 3;
	declare @KIND_GRADE2				int					set	@KIND_GRADE2					= 4;


	declare @rtn 		int	set @rtn 		= -1
	if(@mode_ = @MODE_POWERBALL)
		begin
			if(@kind_ = @KIND_GRADE)
				begin
					set @rtn = case
									when @ball_ <= 2 then 	0
									when @ball_ <= 4 then 	1
									when @ball_ <= 6 then 	2
									else 					3
								end
				end
			else if(@kind_ = @KIND_EVENODD)
				begin
					set @rtn = @ball_ % 2
				end
			else if(@kind_ = @KIND_UNDEROVER)
				begin
					set @rtn = case
									when @ball_ <= 4 then 	0
									else 					1
								end
				end
		end
	else if(@mode_ = @MODE_TOTALBALL)
		begin
			if(@kind_ = @KIND_GRADE)
				begin
					set @rtn = case
									when @ball_ <= 35 then 	0
									when @ball_ <= 49 then 	1
									when @ball_ <= 57 then 	2
									when @ball_ <= 65 then 	3
									when @ball_ <= 78 then 	4
									else 					5
								end
				end
			else if(@kind_ = @KIND_EVENODD)
				begin
					set @rtn = @ball_ % 2
				end
			else if(@kind_ = @KIND_UNDEROVER)
				begin
					set @rtn = case
									when @ball_ <= 72 then 	0
									else 					1
								end
				end
			else if(@kind_ = @KIND_GRADE2)
				begin
					set @rtn = case
									when @ball_ <= 64 then 	0
									when @ball_ <= 80 then 	1
									else 					2
								end
				end
		end

	RETURN @rtn
END