
/*
-- 보물확률.
declare @cashpoint int
set @cashpoint = 0
while( @cashpoint <= 10000)
	begin
		select @cashpoint cashpoint,
			   dbo.fun_GetTreasureGroupPercent( 1, 1, @cashpoint),
			   dbo.fun_GetTreasureGroupPercent( 1, 2, @cashpoint),
			   dbo.fun_GetTreasureGroupPercent( 1, 3, @cashpoint),
			   dbo.fun_GetTreasureGroupPercent( 1, 4, @cashpoint),
			   dbo.fun_GetTreasureGroupPercent( 1, 5, @cashpoint)

		select @cashpoint cashpoint,
		       dbo.fun_GetTreasureGroupPercent( 2, 1, @cashpoint),
			   dbo.fun_GetTreasureGroupPercent( 2, 2, @cashpoint),
			   dbo.fun_GetTreasureGroupPercent( 2, 3, @cashpoint),
			   dbo.fun_GetTreasureGroupPercent( 2, 4, @cashpoint),
			   dbo.fun_GetTreasureGroupPercent( 2, 5, @cashpoint)

		select @cashpoint cashpoint,
		       dbo.fun_GetTreasureGroupPercent( 4, 1, @cashpoint),
			   dbo.fun_GetTreasureGroupPercent( 4, 2, @cashpoint),
			   dbo.fun_GetTreasureGroupPercent( 4, 3, @cashpoint),
			   dbo.fun_GetTreasureGroupPercent( 4, 4, @cashpoint),
			   dbo.fun_GetTreasureGroupPercent( 4, 5, @cashpoint)
		set @cashpoint = @cashpoint + 10000
	end


*/
use GameMTBaseball
GO

IF OBJECT_ID ( N'dbo.fun_GetTreasureGroupPercent', N'FN' ) IS NOT NULL
	DROP FUNCTION dbo.fun_GetTreasureGroupPercent;
GO

CREATE FUNCTION dbo.fun_GetTreasureGroupPercent(
	@mode_					int = 1,
	@group_					int = 1,
	@cashpoint_				int = 0
)
	RETURNS int
AS
BEGIN
	-- 보물뽑기 상수.
	declare @MODE_TREASURE_GRADE1				int					set @MODE_TREASURE_GRADE1					= 1		-- 일반뽑기.
	declare @MODE_TREASURE_GRADE2				int					set @MODE_TREASURE_GRADE2					= 2		-- 루비뽑기.
	declare @MODE_TREASURE_GRADE4				int					set @MODE_TREASURE_GRADE4					= 4	   	-- 루비뽑기 10 + 1.
	declare @MODE_TREASURE_GRADE2_FREE			int					set @MODE_TREASURE_GRADE2_FREE				= 12	-- 루비뽑기			(무료).
	declare @MODE_TREASURE_GRADE4_FREE			int					set @MODE_TREASURE_GRADE4_FREE				= 14	-- 루비뽑기 10 + 1	(무료).
	declare @MODE_TREASURE_GRADE1_TICKET		int					set @MODE_TREASURE_GRADE1_TICKET			= 21	-- 일반뽑기			(티켓).
	declare @MODE_TREASURE_GRADE2_TICKET		int					set @MODE_TREASURE_GRADE2_TICKET			= 22	-- 루비뽑기			(티켓).
	declare @MODE_TREASURE_GRADE4_TICKET		int					set @MODE_TREASURE_GRADE4_TICKET			= 24	-- 루비뽑기 10 + 1 	(티켓).

	declare @rtn 								int					set @rtn 							= 0


	if( @mode_ in ( @MODE_TREASURE_GRADE1, @MODE_TREASURE_GRADE1_TICKET ) )
		begin
			-- 하트.
			set @rtn = case
							when (@group_ = 1 ) then 8000
							when (@group_ = 2 ) then 2000
							when (@group_ = 3 ) then    0
							when (@group_ = 4 ) then    0
							when (@group_ = 5 ) then    0
							else						0
						end
		end
	else if(@mode_ in ( @MODE_TREASURE_GRADE2, @MODE_TREASURE_GRADE2_FREE , @MODE_TREASURE_GRADE2_TICKET ) )
		begin
			-- 캐쉬.
			if( @cashpoint_ <= 5000 )
				begin
					set @rtn = case
									when (@group_ = 1 ) then    0
									when (@group_ = 2 ) then    0
									when (@group_ = 3 ) then 8000 + 500
									when (@group_ = 4 ) then 1800 - 450
									when (@group_ = 5 ) then  200 -  50
									else						0
								end
				end
			else
				begin
					set @rtn = case
									when (@group_ = 1 ) then    0
									when (@group_ = 2 ) then    0
									when (@group_ = 3 ) then 8000
									when (@group_ = 4 ) then 1800
									when (@group_ = 5 ) then  200
									else						0
								end
				end
		end
	else if(@mode_ in ( @MODE_TREASURE_GRADE4, @MODE_TREASURE_GRADE4_FREE , @MODE_TREASURE_GRADE4_TICKET ) )
		begin
			-- 캐쉬.
			if( @cashpoint_ <= 5000 )
				begin
					set @rtn = case
									when (@group_ = 1 ) then    0
									when (@group_ = 2 ) then    0
									when (@group_ = 3 ) then 7000 + 500
									when (@group_ = 4 ) then 2800 - 450
									when (@group_ = 5 ) then  200 -  50
									else						0
								end
				end
			else
				begin
					set @rtn = case
									when (@group_ = 1 ) then    0
									when (@group_ = 2 ) then    0
									when (@group_ = 3 ) then 7000
									when (@group_ = 4 ) then 2800
									when (@group_ = 5 ) then  200
									else						0
								end
				end
		end


	RETURN @rtn
END
