/*
-----------------------------------------------------
select dbo.fnu_GetFVDatePart('hh', '2013-11-26 12:30:00', '2013-11-26 13:30:00')
select dbo.fnu_GetFVDatePart('hh', '2013-11-26 12:30:00', '2013-11-27 13:30:00')
select dbo.fnu_GetFVDatePart('hh', '2013-11-26 12:30:00', '2013-11-28 13:30:00')

select dbo.fnu_GetFVDatePart('hh', '2013-11-26 12:30:00', '2013-11-26 13:29:00')
select dbo.fnu_GetFVDatePart('hh', '2013-11-26 12:30:00', '2013-11-26 13:30:00')
select dbo.fnu_GetFVDatePart('hh', '2013-11-26 12:30:00', '2013-11-26 13:31:00')
select dbo.fnu_GetFVDatePart('hh', '2013-11-26 12:30:00', '2013-11-26 14:31:00')
select dbo.fnu_GetFVDatePart('hh', '2013-11-26 12:30:00', '2013-11-27 12:30:00')
select dbo.fnu_GetFVDatePart('hh', '2013-11-26 12:30:00', '2013-11-27 13:30:00')
-----------------------------------------------------
*/
use Farm
GO

IF OBJECT_ID ( N'dbo.fnu_GetFVDatePart', N'FN' ) IS NOT NULL
	DROP FUNCTION dbo.fnu_GetFVDatePart;
GO

CREATE FUNCTION dbo.fnu_GetFVDatePart(
	@kind_					varchar(2),

	@startDate_  			datetime,
	@endDate_  				datetime
)
	RETURNS int
AS
BEGIN
	declare @rtn 			int				set @rtn 		= 0
	declare @datedif		datetime


	set @rtn = DATEDIFF (s, @startDate_, @endDate_)

	set @rtn = case
					when @kind_ = 'dd' then 	@rtn/(60*60*24)
					when @kind_ = 'hh' then 	@rtn/3600
					when @kind_ = 'mi' then 	@rtn/60
					else 						@rtn
				end

	RETURN @rtn

END