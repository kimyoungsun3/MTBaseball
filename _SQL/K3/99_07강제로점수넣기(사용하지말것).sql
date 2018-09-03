/*
-- exec spu_subFVRankDaJunTest 'xxxx2', '20150312', 1, 20000000000, 3, 12679774, 5, 60000, 7
-- exec spu_subFVRankDaJunTest 'xxxx3', '20150312', 1, 20000000000, 3, 12679774, 5, 60000, 7

declare @t1			bigint,
		@t2			bigint,
		@t3			bigint,
		@t4			bigint,
		@t5			bigint,
		@t6			bigint,
		@t7			bigint,
		@gameid		varchar(20)


-- 1. 랭킹 커서로 읽어오기.
declare curUserRanking Cursor for
select gameid from dbo.tFVUserMaster

-- 2. 커서오픈
open curUserRanking

-- 3. 커서 사용
Fetch next from curUserRanking into @gameid
while @@Fetch_status = 0
	Begin
		set @t1 = Convert(bigint, ceiling(RAND() *  200000000))
		set @t2 = Convert(bigint, ceiling(RAND() *    2000000))
		set @t3 = Convert(bigint, ceiling(RAND() *    2000000))
		set @t4 = Convert(bigint, ceiling(RAND() *        500))
		set @t5 = Convert(bigint, ceiling(RAND() *        200))
		set @t6 = Convert(bigint, ceiling(RAND() *          2))
		set @t7 = Convert(bigint, ceiling(RAND() *      86400))


		--update dbo.tFVUserMaster set rkteam			= (CASE WHEN ISNUMERIC(SUBSTRING(gameid, LEN(LTRIM(gameid)), LEN(LTRIM(gameid)))) = 1 THEN CAST(SUBSTRING(gameid, LEN(LTRIM(gameid)), LEN(LTRIM(gameid))) AS INT) ELSE 0 END)%2
		--where gameid = @gameid
		exec spu_subFVRankDaJunTest @gameid, '20150312', @t1, @t2, @t3, @t4, @t5, @t6, @t7

		Fetch next from curUserRanking into @gameid
	end

-- 4. 커서닫기
close curUserRanking
Deallocate curUserRanking
*/