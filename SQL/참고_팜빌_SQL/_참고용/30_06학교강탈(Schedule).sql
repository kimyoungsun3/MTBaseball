--------------------------------------------
-- 짜요 목장 이야기
-- 2주간 활동안한 유저는 학교 강제탈퇴.
---------------------------------------------
use Farm
GO

declare @gameid 			varchar(60),
		@schoolidx			int,
		@joindate			datetime,
		@idx				int

set @joindate	= getdate() - 14

-- 1. 선언하기.
declare curSchoolNonActive Cursor for
select gameid, schoolidx from dbo.tFVSchoolUser where joindate < @joindate and schoolidx != -1 and point = 0

-- 2. 커서오픈
open curSchoolNonActive

-- 3. 커서 사용
Fetch next from curSchoolNonActive into @gameid, @schoolidx
while @@Fetch_status = 0
	Begin
		-- 학교 개인정보
		update dbo.tFVSchoolUser set schoolidx = -1 where gameid = @gameid

		-- 학교 마스터
		update dbo.tFVSchoolMaster set cnt = cnt - 1 where schoolidx = @schoolidx

		-- 유저 정보갱신
		update dbo.tFVUserMaster set schoolidx = -1 where gameid = @gameid

		Fetch next from curSchoolNonActive into @gameid, @schoolidx
	end

-- 4. 커서닫기
close curSchoolNonActive
Deallocate curSchoolNonActive