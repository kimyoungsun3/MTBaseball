/*
-----------------------------------------------------
--								환생일		 오늘
-- select dbo.fnu_GetSameWeek( @rkstartdate, GETDATE() )
select dbo.fnu_GetSameWeek('2015-07-05 01:30:00', '2015-07-04 01:30:00')	--	0
select dbo.fnu_GetSameWeek('2015-07-05 01:30:00', '2015-07-05 01:30:00')	--	1
select dbo.fnu_GetSameWeek('2015-07-05 01:30:00', '2015-07-06 01:30:00')	--	1
select dbo.fnu_GetSameWeek('2015-07-05 01:30:00', '2015-07-07 01:30:00')	--	1
select dbo.fnu_GetSameWeek('2015-07-05 01:30:00', '2015-07-08 01:30:00')	--	1
select dbo.fnu_GetSameWeek('2015-07-05 01:30:00', '2015-07-09 01:30:00')	--	1
select dbo.fnu_GetSameWeek('2015-07-05 01:30:00', '2015-07-10 01:30:00')	--	1
select dbo.fnu_GetSameWeek('2015-07-05 01:30:00', '2015-07-12 01:30:00')	--	0
-----------------------------------------------------
*/
use Game4GameMTBaseballVill5
GO

IF OBJECT_ID ( N'dbo.fnu_GetSameWeek', N'FN' ) IS NOT NULL
	DROP FUNCTION dbo.fnu_GetSameWeek;
GO

CREATE FUNCTION dbo.fnu_GetSameWeek(
	@rkstartdate_  			datetime,
	@curDate_  				datetime
)
	RETURNS int
AS
BEGIN
	declare @rtn 			int				set @rtn 		= 0
	DECLARE @END_DAY		VARCHAR(8),
			@END_DAY2		VARCHAR(8)


	SET     @END_DAY	= CONVERT(varchar, @rkstartdate_ + 7 - DATEPART(dw, CONVERT(varchar, @rkstartdate_, 112)), 112)     -- 이번주 토요일
	SET     @END_DAY2	= CONVERT(varchar, @curDate_	 + 7 - DATEPART(dw, CONVERT(varchar,     @curDate_, 112)), 112)     -- 이번주 토요일

	if(@END_DAY = @END_DAY2)
		begin
			set @rtn = 1
		end


	RETURN @rtn

END