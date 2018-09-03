IF OBJECT_ID (N'dbo.tSample', N'U') IS NOT NULL
	DROP TABLE dbo.tSample;
GO


/*
-------------------------------------------------
declare @gameid		varchar(20)

-- 4-1. 커서선언
declare curSampleLog Cursor for
select gameid from dbo.tSample 

-- 4-2. 커서오픈
open curSampleLog

-- 3-3. 커서 사용
Fetch next from curSampleLog into @gameid
while @@Fetch_status = 0
	Begin
		-- 삭제하기
		delete from  dbo.tBattleLog where gameid = @gameid
		Fetch next from curSampleLog into @gameid
	end

-- 4-4. 커서닫기
close curSampleLog
Deallocate curSampleLog
*/


