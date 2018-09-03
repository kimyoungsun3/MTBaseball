use Farm
GO

/*
update dbo.tUserMaster set salemoney2 = 12345678901230 where gameid = 'xxxx@gmail.com'
update dbo.tUserMaster set salemoney2 = 12345678901232 where gameid = 'xxxx2@gmail.com'
update dbo.tUserMaster set salemoney2 = 12345678901233 where gameid = 'xxxx3@gmail.com'

exec spu_FVsubTotalRank 'xxxx@gmail.com'
*/

IF OBJECT_ID ( 'dbo.spu_FVsubTotalRank', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVsubTotalRank;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_FVsubTotalRank
	@gameid_								varchar(60)
	--WITH ENCRYPTION -- 프로시져를 암호화함.
as
	------------------------------------------------
	--
	------------------------------------------------

	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @gameid			varchar(60)
	declare @salemoney2		bigint
	declare @bestani		int
	declare @nickname		varchar(20)
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on

	select
		@gameid 	= gameid,
		@salemoney2 	= salemoney2,
		@bestani 	= bestani,
		@nickname	= nickname
	from tUserMaster
	where gameid = @gameid_

	select count(gameid)+1 as rank, @bestani bestani, @salemoney2 salemoney2, @gameid gameid, @nickname nickname from dbo.tUserMaster where salemoney2 > @salemoney2
	union all
	select top 100 rank() over(order by salemoney2 desc) as rank, bestani, salemoney2, gameid, nickname from dbo.tUserMaster

	set nocount off
End

