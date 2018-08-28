
/*
-- 동물확률.
declare @cashpoint int
set @cashpoint = 0
while( @cashpoint < 1000000)
	begin
		select @cashpoint cashpoint,
			   dbo.fun_GetAnimalGroupPercent( 1, 1, @cashpoint),
			   dbo.fun_GetAnimalGroupPercent( 1, 2, @cashpoint),
			   dbo.fun_GetAnimalGroupPercent( 1, 3, @cashpoint),
			   dbo.fun_GetAnimalGroupPercent( 1, 4, @cashpoint),
			   dbo.fun_GetAnimalGroupPercent( 1, 5, @cashpoint)

		select @cashpoint cashpoint,
		       dbo.fun_GetAnimalGroupPercent( 2, 1, @cashpoint),
			   dbo.fun_GetAnimalGroupPercent( 2, 2, @cashpoint),
			   dbo.fun_GetAnimalGroupPercent( 2, 3, @cashpoint),
			   dbo.fun_GetAnimalGroupPercent( 2, 4, @cashpoint),
			   dbo.fun_GetAnimalGroupPercent( 2, 5, @cashpoint)

		select @cashpoint cashpoint,
		       dbo.fun_GetAnimalGroupPercent( 4, 1, @cashpoint),
			   dbo.fun_GetAnimalGroupPercent( 4, 2, @cashpoint),
			   dbo.fun_GetAnimalGroupPercent( 4, 3, @cashpoint),
			   dbo.fun_GetAnimalGroupPercent( 4, 4, @cashpoint),
			   dbo.fun_GetAnimalGroupPercent( 4, 5, @cashpoint)
		set @cashpoint = @cashpoint + 500001
	end


*/
use Game4Farmvill5
GO

IF OBJECT_ID ( N'dbo.fun_GetAnimalGroupPercent', N'FN' ) IS NOT NULL
	DROP FUNCTION dbo.fun_GetAnimalGroupPercent;
GO

CREATE FUNCTION dbo.fun_GetAnimalGroupPercent(
	@mode_					int = 1,
	@group_					int = 1,
	@cashpoint_				int = 0
)
	RETURNS int
AS
BEGIN
	-- 교배뽑기 상수.
	declare @MODE_ROULETTE_GRADE1				int					set @MODE_ROULETTE_GRADE1					= 1		-- 일반뽑기.
	declare @MODE_ROULETTE_GRADE2				int					set @MODE_ROULETTE_GRADE2					= 2		-- 루비뽑기.
	declare @MODE_ROULETTE_GRADE4				int					set @MODE_ROULETTE_GRADE4					= 4	   	-- 루비뽑기 10 + 1.
	declare @MODE_ROULETTE_GRADE2_FREE			int					set @MODE_ROULETTE_GRADE2_FREE				= 12	-- 루비뽑기			(무료).
	declare @MODE_ROULETTE_GRADE4_FREE			int					set @MODE_ROULETTE_GRADE4_FREE				= 14	-- 루비뽑기 10 + 1	(무료).
	declare @MODE_ROULETTE_GRADE1_TICKET		int					set @MODE_ROULETTE_GRADE1_TICKET			= 21	-- 일반뽑기			(티켓).
	declare @MODE_ROULETTE_GRADE2_TICKET		int					set @MODE_ROULETTE_GRADE2_TICKET			= 22	-- 루비뽑기			(티켓).
	declare @MODE_ROULETTE_GRADE4_TICKET		int					set @MODE_ROULETTE_GRADE4_TICKET			= 24	-- 루비뽑기 10 + 1 	(티켓).

	declare @rtn 								int					set @rtn 							= 0


	if( @mode_ in ( @MODE_ROULETTE_GRADE1, @MODE_ROULETTE_GRADE1_TICKET ) )
		begin
			-- 하트.
			set @rtn = case
							when (@group_ = 1 ) then 9700
							when (@group_ = 2 ) then  300
							when (@group_ = 3 ) then    0
							when (@group_ = 4 ) then    0
							when (@group_ = 5 ) then    0
							else						0
						end
		end
	else if(@mode_ in ( @MODE_ROULETTE_GRADE2, @MODE_ROULETTE_GRADE2_FREE , @MODE_ROULETTE_GRADE2_TICKET ) )
		begin
			-- 캐쉬.
			if( @cashpoint_ <= 200000 )
				begin
					set @rtn = case
									when (@group_ = 1 ) then    0
									when (@group_ = 2 ) then    0
									when (@group_ = 3 ) then 8800 + 850
									when (@group_ = 4 ) then 1000 - 700
									when (@group_ = 5 ) then  200 - 150
									else						0
								end
				end
			else
				begin
					set @rtn = case
									when (@group_ = 1 ) then    0
									when (@group_ = 2 ) then    0
									when (@group_ = 3 ) then 8800
									when (@group_ = 4 ) then 1000
									when (@group_ = 5 ) then  200
									else						0
								end
				end
		end
	else if(@mode_ in ( @MODE_ROULETTE_GRADE4, @MODE_ROULETTE_GRADE4_FREE , @MODE_ROULETTE_GRADE4_TICKET ) )
		begin
			-- 캐쉬.
			if( @cashpoint_ <= 200000 )
				begin
					set @rtn = case
									when (@group_ = 1 ) then    0
									when (@group_ = 2 ) then    0
									when (@group_ = 3 ) then 8800  + 200
									when (@group_ = 4 ) then 1000  - 100
									when (@group_ = 5 ) then  200  - 100
									else						0
								end
				end
			else
				begin
					set @rtn = case
									when (@group_ = 1 ) then    0
									when (@group_ = 2 ) then    0
									when (@group_ = 3 ) then 8800
									when (@group_ = 4 ) then 1000
									when (@group_ = 5 ) then  200
									else						0
								end
				end

			-----------------------------------
			---- 1차 테스트 결과 높게나온다..
			-----------------------------------
			--if( @cashpoint_ <= 5000 )
			--	begin
			--		set @rtn = case
			--						when (@group_ = 1 ) then    0
			--						when (@group_ = 2 ) then    0
			--						when (@group_ = 3 ) then 8000
			--						when (@group_ = 4 ) then 1800 + 50
			--						when (@group_ = 5 ) then  200 - 50
			--						else						0
			--					end
			--	end
			--else
			--	begin
			--		set @rtn = case
			--						when (@group_ = 1 ) then    0
			--						when (@group_ = 2 ) then    0
			--						when (@group_ = 3 ) then 8000
			--						when (@group_ = 4 ) then 1800
			--						when (@group_ = 5 ) then  200
			--						else						0
			--					end
			--	end
		end


	RETURN @rtn
END
