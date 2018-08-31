/*
update dbo.tFVUserMaster set bestdealer = 1  where gameid = 'xxxx'
update dbo.tFVUserMaster set bestdealer = 10 where gameid = 'xxxx2'
update dbo.tFVUserMaster set bestdealer = 15 where gameid = 'xxxx3'

exec spu_FVsubTotalRank 'xxxx2'
*/
use Game4FarmVill3
GO

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
	declare @bestdealer		int
	declare @bestani		int
	declare @nickname		varchar(20)
	declare @dateid8 		varchar(8) 				set @dateid8 		= Convert(varchar(8), Getdate(),  112)
	declare @dateid8b 		varchar(8) 				set @dateid8b 		= Convert(varchar(8), Getdate()-1,112)
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on

	select
		@gameid 	= gameid,
		@bestdealer 	= bestdealer,
		@bestani 	= bestani,
		@nickname	= nickname
	from tFVUserMaster
	where gameid = @gameid_

	select count(gameid)+1 as rank, @bestani bestani, @bestdealer bestdealer, @gameid gameid, @nickname nickname from dbo.tFVUserMaster where bestdealer > @bestdealer
	union all
	select top 100 rank() over(order by bestdealer desc) as rank, bestani, bestdealer, gameid, nickname from dbo.tFVUserMaster where blockstate = 0



	/*
	------------------------------------------------
	--	랭킹대전기록(전체).
	------------------------------------------------
	if(exists(select * from dbo.tFVRankDaJun where rkdateid8 = @dateid8))
		begin
			select * from dbo.tFVRankDaJun where rkdateid8 = @dateid8
		end
	else
		begin
			select
				@dateid8 rkdateid8,
				0 rkteam1, 		0 rkteam0, 		0 rkreward,
				0 rkbestdealer, 	0 rkproductcnt, 0 rkfarmearn, 	0 rkwolfcnt, 	0 rkfriendpoint, 0 rkroulettecnt, 0 rkplaycnt,
				0 rkbestdealer2,	0 rkproductcnt2,0 rkfarmearn2,	0 rkwolfcnt2,	0 rkfriendpoint2,0 rkroulettecnt2,0 rkplaycnt2
		end


	if(exists(select * from dbo.tFVRankDaJun where rkdateid8 = @dateid8b))
		begin
			select * from dbo.tFVRankDaJun where rkdateid8 = @dateid8b
		end
	else
		begin
			select top 1 * from dbo.tFVRankDaJun where rkdateid8 < @dateid8b order by rkdateid8 desc
			--select
			--	@dateid8b rkdateid8,
			--	0 rkteam1, 		0 rkteam0, 		0 rkreward,
			--	0 rkbestdealer, 	0 rkproductcnt, 0 rkfarmearn, 	0 rkwolfcnt, 	0 rkfriendpoint, 0 rkroulettecnt, 0 rkplaycnt,
			--	0 rkbestdealer2,	0 rkproductcnt2,0 rkfarmearn2,	0 rkwolfcnt2,	0 rkfriendpoint2,0 rkroulettecnt2,0 rkplaycnt2
		end
	*/

	set nocount off
End

