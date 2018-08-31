/*
-----------------------------------------------------
select dbo.fnu_GetDatePart('mi', '2013-11-26 12:30:00', '2013-11-26 13:30:00')

select dbo.fnu_GetDatePart('dd', '2013-11-26',          '2013-11-26'         )
select dbo.fnu_GetDatePart('dd', '2013-11-26',          '2013-11-27'         )
select dbo.fnu_GetDatePart('dd', '2013-11-26',          '2013-12-06'         )
select dbo.fnu_GetDatePart('dd', '2013-11-26',          '2013-12-27'         )


select dbo.fnu_GetDatePart('hh', '2013-11-26 12:30:00', '2013-11-27 13:30:00')
select dbo.fnu_GetDatePart('hh', '2013-11-26 12:30:00', '2013-11-28 13:30:00')

select dbo.fnu_GetDatePart('hh', '2013-11-26 12:30:00', '2013-11-26 13:29:00')
select dbo.fnu_GetDatePart('hh', '2013-11-26 12:30:00', '2013-11-26 13:30:00')
select dbo.fnu_GetDatePart('hh', '2013-11-26 12:30:00', '2013-11-26 13:31:00')
select dbo.fnu_GetDatePart('hh', '2013-11-26 12:30:00', '2013-11-26 14:31:00')
select dbo.fnu_GetDatePart('hh', '2013-11-26 12:30:00', '2013-11-27 12:30:00')
select dbo.fnu_GetDatePart('hh', '2013-11-26 12:30:00', '2013-11-27 13:30:00')
-----------------------------------------------------
*/
use Game4FarmVill3
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