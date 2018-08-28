
/*
declare @cashpoint 	int
declare @grade	 	int

-- 1. 선언하기.
declare curCashPoint Cursor for
select vip_cashpoint, vip_grade from dbo.tSystemVIPInfo

-- 2. 커서오픈
open curCashPoint

-- 3. 커서 사용
Fetch next from curCashPoint into @cashpoint, @grade
while @@Fetch_status = 0
	Begin

		select @cashpoint cashpoint, @grade grade,
			   dbo.fun_GetVIPPlus( 1, @cashpoint, 100) vip_cashplus,	-- 캐쉬구매.
			   dbo.fun_GetVIPPlus( 2, @cashpoint, 100) vip_gamecost,	-- 코인구매.
			   dbo.fun_GetVIPPlus( 3, @cashpoint, 100) vip_heart,		-- 하트구매.
			   dbo.fun_GetVIPPlus( 4, @cashpoint,   0) vip_animal10,	-- 교배.
			   dbo.fun_GetVIPPlus( 5, @cashpoint,   0) vip_wheel10,		-- 룰렛.
			   dbo.fun_GetVIPPlus( 6, @cashpoint,   0) vip_treasure10,	-- 보물.
			   dbo.fun_GetVIPPlus( 7, @cashpoint, 100) vip_box,			-- 박스오픈시간.
			   dbo.fun_GetVIPPlus( 8, @cashpoint,  10) vip_fbplus		-- 목장횟수.
		Fetch next from curCashPoint into @cashpoint, @grade
	end

-- 4. 커서닫기
close curCashPoint
Deallocate curCashPoint



*/
use Game4Farmvill5
GO

IF OBJECT_ID ( N'dbo.fun_GetVIPPlus', N'FN' ) IS NOT NULL
	DROP FUNCTION dbo.fun_GetVIPPlus;
GO

CREATE FUNCTION dbo.fun_GetVIPPlus(
	@mode_					int = 1,
	@cashpoint_				int = 0,
	@val_					int = 0
)
	RETURNS int
AS
BEGIN
	declare @MODE_VIP_CASHPLUS					int					set @MODE_VIP_CASHPLUS						= 1
	declare @MODE_VIP_GAMECOST					int					set @MODE_VIP_GAMECOST						= 2
	declare @MODE_VIP_HEART						int					set @MODE_VIP_HEART							= 3
	declare @MODE_VIP_ANIMAL10					int					set @MODE_VIP_ANIMAL10						= 4
	declare @MODE_VIP_WHEEL10					int					set @MODE_VIP_WHEEL10						= 5
	declare @MODE_VIP_TREASURE10				int					set @MODE_VIP_TREASURE10					= 6
	declare @MODE_VIP_BOX						int					set @MODE_VIP_BOX							= 7
	declare @MODE_VIP_FBPLUS					int					set @MODE_VIP_FBPLUS						= 8

	declare @vip_cashplus						int					set @vip_cashplus							= 0
	declare @vip_gamecost						int					set @vip_gamecost							= 0
	declare @vip_heart							int					set @vip_heart								= 0
	declare @vip_animal10						int					set @vip_animal10							= 0
	declare @vip_wheel10						int					set @vip_wheel10							= 0
	declare @vip_treasure10						int					set @vip_treasure10							= 0
	declare @vip_box							int					set @vip_box								= 0
	declare @vip_fbplus							int					set @vip_fbplus								= 0

	declare @rtn 								int					set @rtn 									= 0

	if( @cashpoint_ <= 0)
		begin
			--select 'DEBUG 그대로 리턴'
			set @rtn = 0
		end
	else
		begin
			select
				top 1
				@vip_cashplus 	= vip_cashplus,		@vip_gamecost	= vip_gamecost,		@vip_heart		= vip_heart,
				@vip_animal10	= vip_animal10,		@vip_wheel10	= vip_wheel10,		@vip_treasure10	= vip_treasure10,
				@vip_box		= vip_box,			@vip_fbplus		= vip_fbplus
			from dbo.tSystemVIPInfo where @cashpoint_ >= vip_cashpoint order by idx desc
			--select 'DEBUG ', @vip_cashplus vip_cashplus, @vip_gamecost vip_gamecost, @vip_heart vip_heart, @vip_animal10 vip_animal10, @vip_wheel10 vip_wheel10, @vip_treasure10 vip_treasure10, @vip_box vip_box, @vip_fbplus vip_fbplus

			if( @mode_ = @MODE_VIP_CASHPLUS )
				begin
					set @rtn = @val_ * @vip_cashplus / 100
				end
			else if( @mode_ = @MODE_VIP_GAMECOST )
				begin
					set @rtn = @val_ * @vip_gamecost / 100
				end
			else if( @mode_ = @MODE_VIP_HEART )
				begin
					set @rtn = @val_ * @vip_heart / 100
				end
			else if( @mode_ = @MODE_VIP_ANIMAL10 )
				begin
					set @rtn = @vip_animal10
				end
			else if( @mode_ = @MODE_VIP_WHEEL10 )
				begin
					set @rtn = @vip_wheel10
				end
			else if( @mode_ = @MODE_VIP_TREASURE10 )
				begin
					set @rtn = @vip_treasure10
				end
			else if( @mode_ = @MODE_VIP_BOX )
				begin
					set @rtn = @val_ * @vip_box / 100
				end
			else if( @mode_ = @MODE_VIP_FBPLUS )
				begin
					set @rtn = @val_ * @vip_fbplus / 100
				end
	end

	RETURN @rtn
END
