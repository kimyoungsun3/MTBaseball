use GameMTBaseball
GO

-- �б� ������ �Է�
-- select count(*) from dbo.tSchoolBank
-- select count(*) from dbo.tSchoolMaster
declare @schoolidx		int

declare curSchoolMasterInput Cursor for
select schoolidx from dbo.tSchoolBank
where schoolidx not in (select schoolidx from dbo.tSchoolMaster)

-- 2. Ŀ������
open curSchoolMasterInput

-- 3. Ŀ�� ���
Fetch next from curSchoolMasterInput into @schoolidx
while @@Fetch_status = 0
	Begin
		insert into tSchoolMaster(schoolidx,  cnt, totalpoint)
		values(                  @schoolidx,    0,          0)

		Fetch next from curSchoolMasterInput into @schoolidx
	end

-- 4. Ŀ���ݱ�
close curSchoolMasterInput
Deallocate curSchoolMasterInput