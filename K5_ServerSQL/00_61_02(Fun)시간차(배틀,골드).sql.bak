/*
-----------------------------------------------------
select * from dbo.fnu_GetActionTime('2013-11-26 00:00', '2013-11-26 00:09', 10, 20)
select * from dbo.fnu_GetActionTime('2013-11-26 00:00', '2013-11-26 00:10', 10, 20)
select * from dbo.fnu_GetActionTime('2013-11-26 00:00', '2013-11-26 00:11', 10, 20)

select * from dbo.fnu_GetActionTime('2013-11-26 00:00', '2013-11-26 00:11', 30, 20)
select * from dbo.fnu_GetActionTime('2013-11-26 00:00', getdate(), 30, 20)
-----------------------------------------------------
*/
use Game4Farmvill5
GO


IF OBJECT_ID ( N'dbo.fnu_GetActionTime', N'TF' ) IS NOT NULL
	DROP FUNCTION dbo.fnu_GetActionTime;
GO

CREATE FUNCTION dbo.fnu_GetActionTime(
	@actiontime_  			datetime,
	@curdate_				datetime,
	@actioncnt_				int,
	@actionmax_				int
)
RETURNS
	@TEMP_TABLE TABLE (
		rtndate		datetime,
		rtncount	int
	)
AS
BEGIN
	declare @LOOP_TIME_ACTION		int 			set @LOOP_TIME_ACTION 		= 5*60			-- 행동력 5분에 한개씩 채워줌
	declare @tmpcnt 				int
	declare @tmpcnt2 				int


	set @tmpcnt 	= DATEDIFF( s, @actiontime_, @curdate_ ) / @LOOP_TIME_ACTION

	set @actiontime_= DATEADD( s, @tmpcnt * @LOOP_TIME_ACTION, @actiontime_ )

	set @actioncnt_ = case
							when @actioncnt_ 				> @actionmax_ then 	@actioncnt_
							when ( @actioncnt_ + @tmpcnt ) 	> @actionmax_ then 	@actionmax_
							else												( @actioncnt_ + @tmpcnt )
						end

	-- 숫자가 맥스이면 시간을 갱신해주라.
	if( @actioncnt_ >= @actionmax_ )
		begin
			set @actiontime_ = @curdate_
		end


	insert @TEMP_TABLE (rtndate,      rtncount)
	values (           @actiontime_, @actioncnt_)

	RETURN
END