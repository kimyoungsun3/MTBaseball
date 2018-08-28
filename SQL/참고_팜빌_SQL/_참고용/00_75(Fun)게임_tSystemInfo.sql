-------------------------------------------------------------
-- select dbo.fnu_GetFVSystemInfo(21)	-- 캐쉬.
-- select dbo.fnu_GetFVSystemInfo(22)	-- 코인.
-- select dbo.fnu_GetFVSystemInfo(23)	-- 하트.
-- select dbo.fnu_GetFVSystemInfo(24)	-- 건초.
-------------------------------------------------------------
use Farm
GO

IF OBJECT_ID ( N'dbo.fnu_GetFVSystemInfo', N'FN' ) IS NOT NULL
	DROP FUNCTION dbo.fnu_GetFVSystemInfo;
GO

CREATE FUNCTION dbo.fnu_GetFVSystemInfo(
	@kind_ 			int
)
	RETURNS int
AS
BEGIN
	declare @rtn 	int			set @rtn = 0
	declare @housestepmax		int,				@tankstepmax		int,				@bottlestepmax		int,
			@pumpstepmax		int,				@transferstepmax	int,				@purestepmax		int,				@freshcoolstepmax	int,
			@invenstepmax		int,				@invencountmax		int,				@seedfieldmax		int,
			@pluscashcost		int,				@plusgamecost		int,				@plusheart			int,				@plusfeed			int,
			@attend1			int,				@attend2			int,				@attend3			int,				@attend4			int,		@attend5			int

	select top 1
			@housestepmax		= housestepmax,		@tankstepmax		= tankstepmax,		@bottlestepmax		= bottlestepmax,
			@pumpstepmax		= pumpstepmax,		@transferstepmax	= transferstepmax,	@purestepmax		= purestepmax,		@freshcoolstepmax	= freshcoolstepmax,
			@invenstepmax		= invenstepmax,		@invencountmax		= invencountmax,	@seedfieldmax		= seedfieldmax,
			@pluscashcost		= pluscashcost,		@plusgamecost		= plusgamecost,		@plusheart			= plusheart,		@plusfeed			= plusfeed,
			@attend1			= attend1,			@attend2			= attend2,			@attend3			= attend3,
			@attend4			= attend4,			@attend5			= attend5
	 from dbo.tFVSystemInfo
	order by idx desc

	set @rtn = case
					when @kind_ = 1 then @housestepmax
					when @kind_ = 2 then @tankstepmax
					when @kind_ = 3 then @bottlestepmax
					when @kind_ = 4 then @pumpstepmax
					when @kind_ = 5 then @transferstepmax
					when @kind_ = 6 then @purestepmax
					when @kind_ = 7 then @freshcoolstepmax

					when @kind_ = 11 then @invenstepmax
					when @kind_ = 12 then @invencountmax
					when @kind_ = 13 then @seedfieldmax

					when @kind_ = 21 then @pluscashcost
					when @kind_ = 22 then @plusgamecost
					when @kind_ = 23 then @plusheart
					when @kind_ = 24 then @plusfeed

					when @kind_ = 31 then @attend1
					when @kind_ = 32 then @attend2
					when @kind_ = 33 then @attend3
					when @kind_ = 34 then @attend4
					when @kind_ = 35 then @attend5
					else			      0
				end

	RETURN @rtn
END