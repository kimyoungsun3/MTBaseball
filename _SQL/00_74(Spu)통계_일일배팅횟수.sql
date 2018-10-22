/*
exec dbo.spu_SingleGameEarnLog   0,-1, -1, -1, 1,-1, -1, -1, 100, 198,  7	--1개
exec dbo.spu_SingleGameEarnLog   0, 0, -1, -1, 1, 0, -1, -1, 200, 198, 14	--2개
exec dbo.spu_SingleGameEarnLog   0, 0,  0, -1, 1, 0,  1, -1, 300, 395, 21	--3개
exec dbo.spu_SingleGameEarnLog   0, 0,  0,  0, 1, 0,  0,  0, 400, 198, 28	--4개

select * from dbo.tSingleGameEarnLogMaster
*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_SingleGameEarnLog', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_SingleGameEarnLog;
GO

create procedure dbo.spu_SingleGameEarnLog
	@select1_							int,
	@select2_							int,
	@select3_							int,
	@select4_							int,
	@rselect1_							int,
	@rselect2_							int,
	@rselect3_							int,
	@rselect4_							int,
	@betgamecostorg_					int,
	@betgamecostearn_					int,
	@rpcgamecost_						int
	--WITH ENCRYPTION -- 프로시져를 암호화함.
as
	-- 플레그정보.
	declare @RESULT_SELECT_NON					int					set @RESULT_SELECT_NON				= -1
	declare @RESULT_SELECT_LOSE					int					set @RESULT_SELECT_LOSE				=  0
	declare @RESULT_SELECT_WIN					int					set @RESULT_SELECT_WIN				=  1

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

	declare @selecttry1				int					set @selecttry1			= 0
	declare @selecttry2				int					set @selecttry2			= 0
	declare @selecttry3				int					set @selecttry3			= 0
	declare @selecttry4				int					set @selecttry4			= 0
	declare @selectsuccess1			int					set @selectsuccess1		= 0
	declare @selectsuccess2			int					set @selectsuccess2		= 0
	declare @selectsuccess3			int					set @selectsuccess3		= 0
	declare @selectsuccess4			int					set @selectsuccess4		= 0

	------------------------------------------------
	--	3-2-1. 로고정보기록하기.
	------------------------------------------------
	--select 'DEBUG  로그(일별 Master) ', @dateid8 dateid8
	set @selecttry1 = case when @select1_ != @RESULT_SELECT_NON then 1 else 0 end
	set @selecttry2 = case when @select2_ != @RESULT_SELECT_NON then 1 else 0 end
	set @selecttry3 = case when @select3_ != @RESULT_SELECT_NON then 1 else 0 end
	set @selecttry4 = case when @select4_ != @RESULT_SELECT_NON then 1 else 0 end


	set @selectsuccess1 = case when @rselect1_ = @RESULT_SELECT_WIN then 1 else 0 end
	set @selectsuccess2 = case when @rselect2_ = @RESULT_SELECT_WIN then 1 else 0 end
	set @selectsuccess3 = case when @rselect3_ = @RESULT_SELECT_WIN then 1 else 0 end
	set @selectsuccess4 = case when @rselect4_ = @RESULT_SELECT_WIN then 1 else 0 end

	if(not exists(select top 1 * from dbo.tSingleGameEarnLogMaster where dateid8 = @dateid8))
		begin
			--select 'DEBUG > insert'
			insert into dbo.tSingleGameEarnLogMaster(
				dateid8, cnt,
				selecttry1, selecttry2, selecttry3, selecttry4,
				selectsuccess1, selectsuccess2, selectsuccess3, selectsuccess4,
				betgamecostorg, betgamecostearn, rpcgamecost
			)
			values(
				@dateid8, 1,
				@selecttry1, @selecttry2, @selecttry3, @selecttry4,
				@selectsuccess1, @selectsuccess2, @selectsuccess3, @selectsuccess4,
				@betgamecostorg_, @betgamecostearn_, @rpcgamecost_
			)
		end
	else
		begin
			--select 'DEBUG > update'
			update dbo.tSingleGameEarnLogMaster
				set
					cnt				= cnt + 1,
					selecttry1		= selecttry1 + @selecttry1,
					selecttry2		= selecttry2 + @selecttry2,
					selecttry3		= selecttry3 + @selecttry3,
					selecttry4		= selecttry4 + @selecttry4,
					selectsuccess1 	= selectsuccess1 + @selectsuccess1,
					selectsuccess2 	= selectsuccess2 + @selectsuccess2,
					selectsuccess3 	= selectsuccess3 + @selectsuccess3,
					selectsuccess4 	= selectsuccess4 + @selectsuccess4,
					betgamecostorg	= betgamecostorg + @betgamecostorg_,
					betgamecostearn	= betgamecostearn +@betgamecostearn_,
					rpcgamecost		= rpcgamecost + @rpcgamecost_
			where dateid8 = @dateid8
		end


	------------------------------------------------
	--	3-2-3. 일별로그 > 세부기록
	------------------------------------------------

	------------------------------------------------
	--	4-1. 종류
	------------------------------------------------
	set nocount off
End


