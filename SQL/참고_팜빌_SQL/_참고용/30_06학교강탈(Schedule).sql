--------------------------------------------
-- ¥�� ���� �̾߱�
-- 2�ְ� Ȱ������ ������ �б� ����Ż��.
---------------------------------------------
use Farm
GO

declare @gameid 			varchar(60),
		@schoolidx			int,
		@joindate			datetime,
		@idx				int

set @joindate	= getdate() - 14

-- 1. �����ϱ�.
declare curSchoolNonActive Cursor for
select gameid, schoolidx from dbo.tFVSchoolUser where joindate < @joindate and schoolidx != -1 and point = 0

-- 2. Ŀ������
open curSchoolNonActive

-- 3. Ŀ�� ���
Fetch next from curSchoolNonActive into @gameid, @schoolidx
while @@Fetch_status = 0
	Begin
		-- �б� ��������
		update dbo.tFVSchoolUser set schoolidx = -1 where gameid = @gameid

		-- �б� ������
		update dbo.tFVSchoolMaster set cnt = cnt - 1 where schoolidx = @schoolidx

		-- ���� ��������
		update dbo.tFVUserMaster set schoolidx = -1 where gameid = @gameid

		Fetch next from curSchoolNonActive into @gameid, @schoolidx
	end

-- 4. Ŀ���ݱ�
close curSchoolNonActive
Deallocate curSchoolNonActive