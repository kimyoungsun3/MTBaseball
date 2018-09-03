-----------------------------------------------------------------------
-- exec spu_FVUserRankScheduleRecord '20131231', 0
-----------------------------------------------------------------------
use Game4FarmVill4
GO

IF OBJECT_ID ( 'dbo.spu_FVUserRankScheduleRecord', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVUserRankScheduleRecord;
GO

create procedure dbo.spu_FVUserRankScheduleRecord
	@dateid_								varchar(8),
	@step_									int
	--WITH ENCRYPTION -- 프로시져를 암호화함.
as

	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on

	if(not exists(select top 1 dateid from dbo.tFVUserRankMaster where dateid = @dateid_))
		begin
			insert into dbo.tFVUserRankMaster(dateid, step) values(@dateid_, @step_)
		end
	else
		begin
			update dbo.tFVUserRankMaster set step = @step_ where dateid = @dateid_
		end


	------------------------------------------------
	--	4-1. 종류
	------------------------------------------------
	set nocount off
End


