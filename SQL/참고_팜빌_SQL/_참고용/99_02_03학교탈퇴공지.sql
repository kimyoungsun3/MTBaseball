
/*
use Farm
GO

-- 1452		424		광주용봉초등학교
--11960		249		서울대학교
--12001		143		계명대학교
--12055		140		고려대학교
--12000		135		성균관대학교
--11951		116		성균관대학교
-----------------------------------------
-- 해당 인원들에게 쪽지 발송.
declare @comment	varchar(256),
        @comment2	varchar(256),
        @gameid		varchar(20),
        @schoolidx int

set @comment     = '[짜요소녀]인력 조정에 해당하는 학교입니다. 월요일에는 학교 이전이 가능하니, 점검전 원하시는 학교로 이동하시기 바랍니다.'
set @comment2    = '[짜요소녀]강제이동에 들어가시면 점수가 클리어 된상태로 초기화 됩니다.'

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
		exec spu_FVFarmD 27, 12, -1, -1, -1, -1, -1, -1, -1, -1, 'blackm', @gameid, @comment, '', '', '', '', '', '', ''	-- 쪽지발송
		exec spu_FVFarmD 27, 12, -1, -1, -1, -1, -1, -1, -1, -1, 'blackm', @gameid, @comment2, '', '', '', '', '', '', ''	-- 쪽지발송

		Fetch next from curMessage into @gameid
	end

-- 4. 커서닫기
close curMessage
Deallocate curMessage
*/




