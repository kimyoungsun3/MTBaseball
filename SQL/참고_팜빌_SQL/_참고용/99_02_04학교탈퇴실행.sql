
/*
use Farm
GO

-- 강제탈퇴
declare @comment	varchar(256),
        @gameid		varchar(20),
        @schoolidx int

-- 1. 선언하기.
declare curMessage Cursor for
select gameid from dbo.tFVUserMaster where schoolidx in  (1452, 11960, 12001, 12055, 12000, 11951)

-- 2. 커서오픈
open curMessage

-- 3. 커서 사용
Fetch next from curMessage into @gameid
while @@Fetch_status = 0
	Begin
		-- select 'DEBUG ', @gameid gameid
		-- exec spu_FVFarmD 19, 94,  1, -1, -1, -1, -1, -1, -1, -1, @gameid, '', '', '', '', '', '', '', '', ''				-- 학교대항삭제

		Fetch next from curMessage into @gameid
	end

-- 4. 커서닫기
close curMessage
Deallocate curMessage
*/




