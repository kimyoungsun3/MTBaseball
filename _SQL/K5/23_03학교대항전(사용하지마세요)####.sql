/*
use GameMTBaseball
GO

--select 'DEBUG  �������� > �б� ��ŷ ��������Ÿ'
declare @schoolidx		int,
		@point			int,
		@cnt			int,
		@totalpoint		int,
		@totalcnt		int

declare curSchoolData Cursor for
select schoolidx, sum(point), count(idx) from dbo.tSchoolUser group by schoolidx
update dbo.tSchoolMaster set cnt = 0, totalpoint = 0

-- 2. Ŀ������
open curSchoolData

-- 3. Ŀ�� ���
Fetch next from curSchoolData into @schoolidx, @point, @cnt
while @@Fetch_status = 0
	Begin
		update dbo.tSchoolMaster set totalpoint = @point, cnt = @cnt where schoolidx = @schoolidx

		Fetch next from curSchoolData into @schoolidx, @point, @cnt
	end

-- 4. Ŀ���ݱ�
close curSchoolData
Deallocate curSchoolData

*/