
--################################################################
/*
-- 게임배치
SELECT * FROM dbo.fnu_SplitOne(',', '1,2,3,4,5,6,12,13,14')

-- 1. 커서 생성
declare @idx 		int,
		@listidx	bigint

declare curTemp Cursor for
select idx, listidx FROM dbo.fnu_SplitOne(',', '1,2,3,4,5,6,12,13,14')

-- 2. 커서오픈
open curTemp

-- 3. 커서 사용
Fetch next from curTemp into @idx, @listidx
while @@Fetch_status = 0
	Begin
		select @idx, @listidx
		Fetch next from curTemp into @idx, @listidx
	end

-- 4. 커서닫기
close curTemp
Deallocate curTemp
*/
--################################################################
use Farm
GO

IF OBJECT_ID ( N'dbo.fnu_SplitOne', N'TF' ) IS NOT NULL
	DROP FUNCTION dbo.fnu_SplitOne;
GO

CREATE FUNCTION dbo.fnu_SplitOne(
	@charSplit_ 	VARCHAR(1),		-- 구분할 문자
	@strValue_ 		VARCHAR(8000)	-- 분리할 문자열
)
	RETURNS @SPLIT_TEMP TABLE  (
		idx 		smallint 		Primary Key,
		listidx		bigint
	)
AS
begin
	declare @idx 		smallint
	declare @posStart 	int, @posNext int
	declare @strTemp 	VARCHAR(8000) 	-- 분리된 문자열 임시 저장변수

	set @posStart 	= 1 	-- 구분문자 검색을 시작할 위치
	set @posNext 	= 1 	-- 구분문자 위치
	set @idx 		= 0
	set @strValue_ 		= LTrim(RTrim(@strValue_))

	WHILE (@posNext > 0)
		begin
			set @posNext 	= CHARINDEX(@charSplit_, @strValue_, @posStart)
			if (@posNext = 0)
				begin
					set @strTemp = RIGHT(@strValue_, len(@strValue_) - @posStart + 1 )
				end
			else
				begin
					set @strTemp = SUBSTRING(@strValue_, @posStart, @posNext - @posStart)
				end

			set @strTemp = LTrim(RTrim(@strTemp))
			if len(@strTemp) > 0
				begin
					INSERT INTO @SPLIT_TEMP VALUES(@idx, @strTemp )
				end

			set @idx 		= @idx + 1
			set @posStart	= @posNext +1
		end

   RETURN
end


