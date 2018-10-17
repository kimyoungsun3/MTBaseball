/*
--							gameid, 캐쉬, 볼
exec dbo.spu_SinglePCRoomLog   'xxxx', '127.0.0.1', 0,  100

select * from dbo.tPCRoomEarnMaster
select * from dbo.tPCRoomEarnSub
*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_SinglePCRoomLog', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_SinglePCRoomLog;
GO

create procedure dbo.spu_SinglePCRoomLog
	@gameid_								varchar(20),					-- 게임아이디
	@connectip_								varchar(20),
	@cashcost_								int,
	@gamecost_								int
	--WITH ENCRYPTION -- 프로시져를 암호화함.
as
	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @dateid8 	varchar(8)		set @dateid8 			= Convert(varchar(8),Getdate(),112)
	declare @dateid6 	varchar(6)		set @dateid6 			= Convert(varchar(6),Getdate(),112)

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	--select 'DEBUG 구매', @gameid_ gameid_, @cashcost_ cashcost_, @gamecost_ gamecost_


	------------------------------------------------
	--	3-2-1. 룸정보 업데이트
	------------------------------------------------
	--if( exists( select top 1 * from dbo.tPCRoomIP where connectip = @connectip_ ) )
	--	begin
	--		update dbo.tPCRoomIP
	--			set
	--				cnt 			= cnt + 1,
	--				gaingamecost 	= gaingamecost + @gamecost_
	--		 where connectip = @connectip_
	--	end

	------------------------------------------------
	--	3-2-2. 업글 로그(월별 Master)
	------------------------------------------------
	--select 'DEBUG  로그(월별 Master) ', @dateid8 dateid8, @cashcost_ cashcost_, @gamecost_ gamecost_
	if(not exists(select top 1 * from dbo.tPCRoomEarnMaster where dateid8 = @dateid8))
		begin
			--select 'DEBUG > insert'
			insert into dbo.tPCRoomEarnMaster(dateid8,  cashcost,   gamecost,  cnt)
			values(                          @dateid8, @cashcost_, @gamecost_, 1)
		end
	else
		begin
			--select 'DEBUG > update'
			update dbo.tPCRoomEarnMaster
				set
					cashcost	= cashcost + @cashcost_,
					gamecost	= gamecost + @gamecost_,
					cnt 		= cnt + 1
			where dateid8 = @dateid8
		end


	------------------------------------------------
	--	3-2-3. 일별로그 > 세부기록
	------------------------------------------------
	--select 'DEBUG 일별로그 > 세부기록', @dateid8 dateid8, @cashcost_ cashcost_, @gamecost_ gamecost_
	if(not exists(select top 1 * from dbo.tPCRoomEarnSub where dateid8 = @dateid8 and gameid = @gameid_))
		begin
			--select 'DEBUG > insert'

			insert into dbo.tPCRoomEarnSub(dateid8,  gameid,   cashcost,   gamecost,  cnt)
			values(                       @dateid8, @gameid_, @cashcost_, @gamecost_, 1)
		end
	else
		begin
			--select 'DEBUG > update'

			update dbo.tPCRoomEarnSub
				set
					cashcost 	= cashcost + @cashcost_,
					gamecost 	= gamecost + @gamecost_,
					cnt 		= cnt + 1
			where dateid8 = @dateid8 and gameid = @gameid_
		end


	------------------------------------------------
	--	4-1. 종류
	------------------------------------------------
	set nocount off
End


