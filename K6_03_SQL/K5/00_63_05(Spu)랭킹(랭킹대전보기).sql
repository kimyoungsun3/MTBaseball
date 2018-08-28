/*
-- select * from dbo.tRankDaJun
exec spu_subRKRank 'xxxx2'
*/
use Game4GameMTBaseballVill5
GO

IF OBJECT_ID ( 'dbo.spu_subRKRank', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_subRKRank;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_subRKRank
	@gameid_								varchar(60)
	--WITH ENCRYPTION -- 프로시져를 암호화함.
as
	------------------------------------------------
	--
	------------------------------------------------

	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @gameid					varchar(20)
	declare @dateid8 				varchar(8) 				set @dateid8 		= Convert(varchar(8), Getdate(),  112)
	declare @dateid8b 				varchar(8) 				set @dateid8b 		= Convert(varchar(8), Getdate()-1,112)
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on

	------------------------------------------------
	--	랭킹대전기록(전체).
	------------------------------------------------
	if(exists(select * from dbo.tRankDaJun where rkdateid8 = @dateid8))
		begin
			select * from dbo.tRankDaJun where rkdateid8 = @dateid8
		end
	else
		begin
			select
				@dateid8 rkdateid8,
				0 rkteam1, 		0 rkteam0, 		0 rkreward,
				0 rksalemoney, 	0 rksalebarrel, 0 rkbattlecnt, 	0 rkbogicnt, 	0 rkfriendpoint, 0 rkroulettecnt, 0 rkwolfcnt,
				0 rksalemoney2,	0 rksalebarrel2,0 rkbattlecnt2,	0 rkbogicnt2,	0 rkfriendpoint2,0 rkroulettecnt2,0 rkwolfcnt2
		end


	if( exists ( select top 1 * from dbo.tRankDaJun where rkdateid8 <= @dateid8b ) )
		begin
			select top 1 * from dbo.tRankDaJun where rkdateid8 <= @dateid8b order by rkdateid8 desc
		end
	else
		begin
			select
				@dateid8b rkdateid8,
				0 rkteam1, 		0 rkteam0, 		0 rkreward,
				0 rksalemoney, 	0 rksalebarrel, 0 rkbattlecnt, 	0 rkbogicnt, 	0 rkfriendpoint, 0 rkroulettecnt, 0 rkwolfcnt,
				0 rksalemoney2,	0 rksalebarrel2,0 rkbattlecnt2,	0 rkbogicnt2,	0 rkfriendpoint2,0 rkroulettecnt2,0 rkwolfcnt2
		end

	set nocount off
End

