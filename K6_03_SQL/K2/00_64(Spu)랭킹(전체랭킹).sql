/*
update dbo.tFVUserMaster set salemoney = 12345678901230 where gameid = 'xxxx'
update dbo.tFVUserMaster set salemoney = 12345678901232 where gameid = 'xxxx@gmail.com'
update dbo.tFVUserMaster set salemoney = 12345678901233 where gameid = 'xxxx3'

exec spu_FVsubTotalRank 'xxxx@gmail.com'
*/
use Farm
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
	declare @salemoney		bigint
	declare @bestani		int
	declare @nickname		varchar(20)
	declare @dateid8 				varchar(8) 				set @dateid8 		= Convert(varchar(8), Getdate(),  112)
	declare @dateid8b 				varchar(8) 				set @dateid8b 		= Convert(varchar(8), Getdate()-1,112)
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on

	select
		@gameid 	= gameid,
		@salemoney 	= salemoney,
		@bestani 	= bestani,
		@nickname	= nickname
	from tFVUserMaster
	where gameid = @gameid_

	select count(gameid)+1 as rank, @bestani bestani, @salemoney salemoney, @gameid gameid, @nickname nickname from dbo.tFVUserMaster where salemoney > @salemoney
	union all
	select top 100 rank() over(order by salemoney desc) as rank, bestani, salemoney, gameid, nickname from dbo.tFVUserMaster




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
				0 rksalemoney, 	0 rkproductcnt, 0 rkfarmearn, 	0 rkwolfcnt, 	0 rkfriendpoint, 0 rkroulettecnt, 0 rkplaycnt,
				0 rksalemoney2,	0 rkproductcnt2,0 rkfarmearn2,	0 rkwolfcnt2,	0 rkfriendpoint2,0 rkroulettecnt2,0 rkplaycnt2
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
			--	0 rksalemoney, 	0 rkproductcnt, 0 rkfarmearn, 	0 rkwolfcnt, 	0 rkfriendpoint, 0 rkroulettecnt, 0 rkplaycnt,
			--	0 rksalemoney2,	0 rkproductcnt2,0 rkfarmearn2,	0 rkwolfcnt2,	0 rkfriendpoint2,0 rkroulettecnt2,0 rkplaycnt2
		end

	set nocount off
End

