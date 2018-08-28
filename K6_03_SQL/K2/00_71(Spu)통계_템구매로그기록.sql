use Farm
GO
/*
exec spu_FVUserItemBuyLog 'xxxx@gmail.com', 10, 90001,     0, 0, 100	-- D, C뽑기 X (1)
exec spu_FVUserItemBuyLog 'xxxx@gmail.com', 20, 90001,  2000, 0,   0	-- B, A뽑기 X (1)
exec spu_FVUserItemBuyLog 'xxxx@gmail.com', 30, 90001,  4000, 0,   0	-- A, S뽑기 X (1)
exec spu_FVUserItemBuyLog 'xxxx@gmail.com', 40, 90001, 12000, 0,   0	-- A, S뽑기 X (3 + 1)

select top  20 * from dbo.tFVUserItemBuyLog where gameid = 'xxxx@gmail.com' order by idx desc
select top 100 * from dbo.tFVUserItemBuyLogTotalMaster order by dateid8
select top 100 * from dbo.tFVUserItemBuyLogTotalSub order by dateid8 desc, itemcode desc
select top 100 * from dbo.tFVUserItemBuyLogMonth order by dateid6 desc, itemcode desc
*/
IF OBJECT_ID ( 'dbo.spu_FVUserItemBuyLog', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVUserItemBuyLog;
GO

create procedure dbo.spu_FVUserItemBuyLog
	@gameid_								varchar(60),		-- 게임아이디
	@ownercashcost_							int,
	@itemcode_								int,
	@cashcost_								int,
	@gamecost_								int,
	@heart_									int
	--WITH ENCRYPTION -- 프로시져를 암호화함.
as
	------------------------------------------------
	declare @USER_LOGDATA_MAX					int					set @USER_LOGDATA_MAX 						= 2000

	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @dateid8 	varchar(8)		set @dateid8 			= Convert(varchar(8),Getdate(),112)
	declare @dateid6 	varchar(6)		set @dateid6 			= Convert(varchar(6),Getdate(),112)

	declare @idx		int			set @idx  = -1
	declare @idx2		int			set @idx2 = 0
	declare @bdel		int			set @bdel = 0

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	--select 'DEBUG 구매', @gameid_ gameid_, @itemcode_ itemcode_, @cashcost_ cashcost_, @gamecost_ gamecost_, @heart_ heart_

	------------------------------------------------
	--	3-2-1. 구매했던 로그(개인)
	------------------------------------------------
	--클러스터 인덱스를 이용.
	select top 1 @idx2 = isnull(idx2, 1) from dbo.tFVUserItemBuyLog where gameid = @gameid_ order by idx desc
	set @idx2 = @idx2 + 1

	-- 로고를 별도로 기록
	insert into dbo.tFVUserItemBuyLog(gameid,   itemcode,   ownercashcost,   gamecost,   cashcost,   heart,   idx2, buydate2)
	values(                          @gameid_, @itemcode_, @ownercashcost_, @gamecost_, @cashcost_, @heart_, @idx2, @dateid8)

	-- 로고를 중복제거
	--select top 1 @idx = isnull(idx, -1)
	--from dbo.tFVUserItemBuyLog
	--where gameid = @gameid_
	--      and buydate2 = @dateid8
	--      and itemcode = @itemcode_
	-- order by idx desc
    --
	--if(@idx = -1)
	--	begin
	--		insert into dbo.tFVUserItemBuyLog(gameid,   itemcode,   ownercashcost,  gamecost,   cashcost,   heart,   idx2, buydate2)
	--		values(                          @gameid_, @itemcode_, @ownercashcost_, @gamecost_, @cashcost_, @heart_, @idx2, @dateid8)
	--	end
	--else
	--	begin
	--		update dbo.tFVUserItemBuyLog
	--			set
	--				gamecost = gamecost + @gamecost_,
	--				cashcost = cashcost + @cashcost_,
	--				heart 	= heart + @heart_,
	--				cnt 	= cnt + 1
	--		where idx = @idx
	--	end


	-- 일정 수량이상의 로그는 삭제함.
	delete dbo.tFVUserItemBuyLog where gameid = @gameid_ and idx2 < @idx2 - @USER_LOGDATA_MAX

	------------------------------------------------
	--	3-2-2. 구매했던 로그(월별 Master)
	------------------------------------------------
	--select 'DEBUG 구매했던 로그(월별 Master) ', @dateid8 dateid8, @cashcost_ cashcost_, @gamecost_ gamecost_, @heart_ heart_
	if(not exists(select top 1 * from dbo.tFVUserItemBuyLogTotalMaster where dateid8 = @dateid8))
		begin
			--select 'DEBUG > insert'

			insert into dbo.tFVUserItemBuyLogTotalMaster(dateid8,  gamecost,   cashcost,   heart, cnt)
			values(                                     @dateid8, @gamecost_, @cashcost_, @heart_, 1)
		end
	else
		begin
			--select 'DEBUG > update'

			update dbo.tFVUserItemBuyLogTotalMaster
				set
					gamecost = gamecost + @gamecost_,
					cashcost = cashcost + @cashcost_,
					heart 	= heart + @heart_,
					cnt = cnt + 1
			where dateid8 = @dateid8
		end


	------------------------------------------------
	--	3-2-3. 일별로그 > 세부기록
	------------------------------------------------
	--select 'DEBUG 일별로그 > 세부기록', @dateid8 dateid8, @itemcode_ itemcode_, @cashcost_ cashcost_, @gamecost_ gamecost_, @heart_ heart_
	if(not exists(select top 1 * from dbo.tFVUserItemBuyLogTotalSub where dateid8 = @dateid8 and itemcode = @itemcode_))
		begin
			--select 'DEBUG > insert'

			insert into dbo.tFVUserItemBuyLogTotalSub(dateid8,  itemcode,   gamecost,   cashcost,   heart, cnt)
			values                                  (@dateid8, @itemcode_, @gamecost_, @cashcost_, @heart_, 1)
		end
	else
		begin
			--select 'DEBUG > update'

			update dbo.tFVUserItemBuyLogTotalSub
				set
					gamecost = gamecost + @gamecost_,
					cashcost = cashcost + @cashcost_,
					heart 	= heart + @heart_,
					cnt = cnt + 1
			where dateid8 = @dateid8 and itemcode = @itemcode_
		end


	------------------------------------------------
	--	3-2-4. 월별(아이템)
	------------------------------------------------
	--select 'DEBUG 월별(아이템)', @dateid6 dateid6, @itemcode_ itemcode_, @cashcost_ cashcost_, @gamecost_ gamecost_, @heart_ heart_
	if(not exists(select top 1 * from dbo.tFVUserItemBuyLogMonth where dateid6 = @dateid6 and itemcode = @itemcode_))
		begin
			--select 'DEBUG 월별(아이템) insert'

			insert into dbo.tFVUserItemBuyLogMonth(dateid6,  itemcode,   gamecost,   cashcost,   heart, cnt)
			values                               (@dateid6, @itemcode_, @gamecost_, @cashcost_, @heart_, 1)
		end
	else
		begin
			--select 'DEBUG 월별(아이템) update'

			update dbo.tFVUserItemBuyLogMonth
				set
					gamecost = gamecost + @gamecost_,
					cashcost = cashcost + @cashcost_,
					heart 	= heart + @heart_,
					cnt = cnt + 1
			where dateid6 = @dateid6 and itemcode = @itemcode_
		end


	------------------------------------------------
	--	4-1. 종류
	------------------------------------------------
	set nocount off
End


