use GameMTBaseball
GO

-- 학교 마스터 입력
-- select count(*) from dbo.tSchoolBank
-- select count(*) from dbo.tSchoolMaster
declare @schoolidx		int

declare curSchoolMasterInput Cursor for
select schoolidx from dbo.tSchoolBank
where schoolidx not in (select schoolidx from dbo.tSchoolMaster)

-- 2. 커서오픈
open curSchoolMasterInput

-- 3. 커서 사용
Fetch next from curSchoolMasterInput into @schoolidx
while @@Fetch_status = 0
	Begin
		insert into tSchoolMaster(schoolidx,  cnt, totalpoint)
		values(                  @schoolidx,    0,          0)

		Fetch next from curSchoolMasterInput into @schoolidx
	end

-- 4. 커서닫기
close curSchoolMasterInput
Deallocate curSchoolMasterInput