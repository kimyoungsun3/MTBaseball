/*
select dbo.fnu_GetDatePart('dd', '2018-09-27 12:30:00', '2018-09-28 13:30:00')
select dbo.fnu_GetDatePart('hh', '2018-09-27 12:30:00', '2018-09-28 13:30:00')
select dbo.fnu_GetDatePart('mi', '2018-09-27 12:30:00', '2018-09-28 13:30:00')
select dbo.fnu_GetDatePart('ss', '2018-09-27 12:30:00', '2018-09-28 13:30:00')
select dbo.fnu_GetDatePart('ms', '2018-09-27 12:30:00', '2018-09-28 13:30:00')

select dbo.fnu_GetDatePart('ss', '2018-09-27 12:30:00', '2018-09-27 12:30:20')
select dbo.fnu_GetDatePart('ms', '2018-09-27 12:30:00', '2018-09-27 12:30:20')
*/
use GameMTBaseball
GO

IF OBJECT_ID ( N'dbo.fnu_GetDatePart', N'FN' ) IS NOT NULL
	DROP FUNCTION dbo.fnu_GetDatePart;
GO

CREATE FUNCTION dbo.fnu_GetDatePart(
	@kind_					varchar(2),

	@startDate_  			datetime,
	@endDate_  				datetime
)
	RETURNS int
AS
BEGIN
	declare @rtn 			int				set @rtn 			= 0
	declare @datedif		datetime
	declare @milllisecond	bigint			set @milllisecond	= 0


	set @milllisecond = DATEDIFF (ms, @startDate_, @endDate_)

	set @rtn = case
					when @kind_ = 'dd' then 	@milllisecond/(60*60*24*1000)
					when @kind_ = 'hh' then 	@milllisecond/(60*60*1000)
					when @kind_ = 'mi' then 	@milllisecond/(60*1000)
					when @kind_ = 'ss' then 	@milllisecond/(1000)
					else 						@milllisecond
				end

	RETURN @rtn

END