use Game4FarmVill4
GO

declare @startdate		datetime,
		@enddate		datetime

set @startdate 	= '2015-02-25 00:00:00'
set @enddate 	= '2015-02-28 23:59:59'



select idx, ikind, gameid, kakaouserid, acode, cash, writedate, kakaouk from dbo.tFVCashLog
where writedate >= @startdate and writedate <= @enddate
order by idx desc
