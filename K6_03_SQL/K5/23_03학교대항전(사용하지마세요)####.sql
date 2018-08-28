/*
use GameMTBaseball
GO

--select 'DEBUG  유저점수 > 학교 랭킹 정리데이타'
declare @schoolidx		int,
		@point			int,
		@cnt			int,
		@totalpoint		int,
		@totalcnt		int

declare curSchoolData Cursor for
select schoolidx, sum(point), count(idx) from dbo.tSchoolUser group by schoolidx
update dbo.tSchoolMaster set cnt = 0, totalpoint = 0

-- 2. 커서오픈
open curSchoolData

-- 3. 커서 사용
Fetch next from curSchoolData into @schoolidx, @point, @cnt
while @@Fetch_status = 0
	Begin
		update dbo.tSchoolMaster set totalpoint = @point, cnt = @cnt where schoolidx = @schoolidx

		Fetch next from curSchoolData into @schoolidx, @point, @cnt
	end

-- 4. 커서닫기
close curSchoolData
Deallocate curSchoolData

*/