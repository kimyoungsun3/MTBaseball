IF OBJECT_ID (N'dbo.tSample', N'U') IS NOT NULL
	DROP TABLE dbo.tSample;
GO


/*
-------------------------------------------------
declare @gameid		varchar(20)

-- 4-1. Ŀ������
declare curSampleLog Cursor for
select gameid from dbo.tSample 

-- 4-2. Ŀ������
open curSampleLog

-- 3-3. Ŀ�� ���
Fetch next from curSampleLog into @gameid
while @@Fetch_status = 0
	Begin
		-- �����ϱ�
		delete from  dbo.tBattleLog where gameid = @gameid
		Fetch next from curSampleLog into @gameid
	end

-- 4-4. Ŀ���ݱ�
close curSampleLog
Deallocate curSampleLog
*/


