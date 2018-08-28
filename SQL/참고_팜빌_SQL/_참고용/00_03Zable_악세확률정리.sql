
use Farm
GO

select '변경(전)', itemcode, playerlv, param7, param8, param9 from dbo.tFVFVItemInfo where subcategory = 15 order by playerlv asc

-- 1. 아이템 테이블의 순서 데이타를 정리
declare @itemcode			int		set @itemcode	= -1
declare @accper				int		set @accper		= 0
declare @accsum				int		set @accsum		= 0
declare @accsumbefore		int		set @accsumbefore	= 0
declare curItemInfoAccSum Cursor for
select itemcode, CAST(param7 as int) accper from dbo.tFVFVItemInfo where subcategory = 15 order by playerlv asc

-- 2. 커서오픈
open curItemInfoAccSum

-- 3. 커서 사용
Fetch next from curItemInfoAccSum into @itemcode, @accper
while @@Fetch_status = 0
	Begin
		set @accsumbefore	= @accsum
		set @accsum			= @accsum + @accper

		update dbo.tFVFVItemInfo
			set
				param8 = ltrim(rtrim(str(@accsumbefore))),
				param9 = ltrim(rtrim(str(@accsum)))
		where itemcode = @itemcode

		Fetch next from curItemInfoAccSum into @itemcode, @accper
	end

-- 4. 커서닫기
close curItemInfoAccSum
Deallocate curItemInfoAccSum


select '변경(후)', itemcode, playerlv, param7, param8, param9 from dbo.tFVFVItemInfo where subcategory = 15 order by playerlv asc