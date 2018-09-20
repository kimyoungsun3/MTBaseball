
--################################################################
/*
-- 게임배치
SELECT * FROM dbo.fnu_GetNextTimeInfo(1, 2     )		-- 0일차 > +2초기본갭
--SELECT * FROM dbo.fnu_GetNextTimeInfo(1, 2+5   )		-- 1일차 > +2초기본갭 + 5
--SELECT * FROM dbo.fnu_GetNextTimeInfo(1, 2+5+7   )	-- 2일차 > +2초기본갭 + 5+7
SELECT * FROM dbo.fnu_GetNextTimeInfo(1, 2+5+7+8 )		-- 3일차 > +2초기본갭 + 5+7+6

SELECT * FROM dbo.fnu_GetNextTimeInfo(2, 2000     )		-- 0일차 > +2초기본갭
--SELECT * FROM dbo.fnu_GetNextTimeInfo(2, 2000+5000)	-- 1일차 > +2초기본갭 + 5
--SELECT * FROM dbo.fnu_GetNextTimeInfo(2, 2000+12000)	-- 2일차 > +2초기본갭 + 5+7
SELECT * FROM dbo.fnu_GetNextTimeInfo(2, 2000+19500)	-- 3일차 > +2초기본갭 + 5+7+6
*/
--################################################################
use GameMTBaseball
GO

IF OBJECT_ID ( N'dbo.fnu_GetNextTimeInfo', N'TF' ) IS NOT NULL
	DROP FUNCTION dbo.fnu_GetNextTimeInfo;
GO

CREATE FUNCTION dbo.fnu_GetNextTimeInfo(
	@mode_				int,
	@plusTime_			int
)
	RETURNS @SPLIT_TEMP TABLE  (
		gaptime				bigint,
		divValue			int,
		modValue			int,
		remainTime			bigint,
		curTurnTime 		int,
		curDate				datetime,
		nextTurnTime 		int,
		nextData			datetime
	)
AS
begin
	-- MT SMS
	declare @TURNTIME_MODE_SECOND		int				set @TURNTIME_MODE_SECOND		= 1
	declare @TURNTIME_MODE_MILLISECOND	int				set @TURNTIME_MODE_MILLISECOND	= 2

	declare @startDate 					datetime		set @startDate					= '2018-09-17 16:17:45'
	declare @curDate					datetime		set @curDate 					= getdate()
	declare @nextData 					datetime

	declare @startTurnTime				int				set @startTurnTime				= 821451
	declare @curTurnTime				int				set @curTurnTime				= -1
	declare @nextTurnTime				int				set @nextTurnTime				= -1

	declare @gaptime					bigint
	declare @remainTime					bigint
	declare @divValue					int
	declare @modValue					int
	declare @TURNTIME_SECOND			int				set @TURNTIME_SECOND			= 5 * 60
	declare @TURNTIME_MILLESECOND		bigint			set @TURNTIME_MILLESECOND		= 5 * 60 * 1000

	if(@mode_ = @TURNTIME_MODE_SECOND)
		begin
			set @startDate 	= DATEADD(ss, @plusTime_, @startDate)
			set @gaptime 	= datediff(ss, @startDate, @curDate)
			set @divValue 	= @gaptime / @TURNTIME_SECOND
			set @modValue 	= @gaptime % @TURNTIME_SECOND
			set @remainTime = @TURNTIME_SECOND - @modValue

			set @curTurnTime 	= @startTurnTime + @divValue
			set @nextData 		= DATEADD(ss, (@divValue + 1) * @TURNTIME_SECOND, @startDate);
			set @nextTurnTime 	= @curTurnTime + 1
		end
	else
		begin
			set @startDate 	= DATEADD(ms, @plusTime_, @startDate)
			set @gaptime 	= datediff(ms, @startDate, @curDate)
			set @divValue 	= @gaptime / @TURNTIME_MILLESECOND
			set @modValue 	= @gaptime % @TURNTIME_MILLESECOND
			set @remainTime = @TURNTIME_MILLESECOND - @modValue

			set @curTurnTime 	= @startTurnTime + @divValue
			set @nextData 		= DATEADD(ms, (@divValue + 1) * @TURNTIME_MILLESECOND, @startDate);
			set @nextTurnTime 	= @curTurnTime + 1
		end

	INSERT INTO @SPLIT_TEMP VALUES( @gaptime, @divValue, @modValue, @remainTime, @curTurnTime, @curDate, @nextTurnTime, @nextData )
   RETURN
end


