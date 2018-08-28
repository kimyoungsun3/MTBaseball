
--################################################################
/*
SELECT * FROM dbo.fnu_SplitTwo(';', ':', '0:1;1:2;2:3;3:4;4:5;5:6;6:12;7:13;8:14')
SELECT * FROM dbo.fnu_SplitTwo(';', ':', '0:1;2:3')
SELECT * FROM dbo.fnu_SplitTwo(';', ':', '0:1;2:3;')
SELECT * FROM dbo.fnu_SplitTwo(';', ':', '0:1;8:10000')

-- 1. 커서 생성
declare @fieldidx		int,
		@listidx		int

declare curTemp Cursor for
select fieldidx, listidx FROM dbo.fnu_SplitTwo(';', ':', '0:1;2:3')

-- 2. 커서오픈
open curTemp

-- 3. 커서 사용
Fetch next from curTemp into @fieldidx, @listidx
while @@Fetch_status = 0
	Begin
		select @fieldidx, @listidx
		Fetch next from curTemp into @fieldidx, @listidx
	end

-- 4. 커서닫기
close curTemp
Deallocate curTemp
*/
--################################################################
use Farm
GO

IF OBJECT_ID ( N'dbo.fnu_SplitTwo', N'TF' ) IS NOT NULL
	DROP FUNCTION dbo.fnu_SplitTwo;
GO

CREATE FUNCTION dbo.fnu_SplitTwo(
	@charSplit_ 		varchar(1),
	@charSplit2_ 		varchar(1),
	@strValue_ 			varchar(8000)
)
	RETURNS
		@SPLIT_TABLE_TEMP TABLE (
			fieldidx		int,
			listidx			int
		)
AS
begin
	--declare @charSplit_ 		varchar(1),
	--		@charSplit2_ 		varchar(1),
	--		@strValue_ 			varchar(8000)
	--set @charSplit_ = ';'
	--set @charSplit2_ = ':'
	--set @strValue_ = '0:1 ; 1 : 2 ; 8:1884'
	--set @strValue_ = '0:1 ; 1 : 2 ; 8:1884;'

	declare @posStart 	int,
			@posNext 	int,
			@posCenter 	int,
			@strLen		int,
			@fieldidx	varchar(20),
			@listidx	varchar(20)
	declare @strTemp 	VARCHAR(8000) 	-- 분리된 문자열 임시 저장변수

	set @posStart 	= 1 	-- 구분문자 검색을 시작할 위치
	set @posNext 	= 1 	-- 구분문자 위치
	set @strValue_ 		= LTrim(RTrim(@strValue_))
	set @strLen			= len(@strValue_)

	while (@posNext > 0)
		begin
			------------------------------
			-- 1차분리.
			------------------------------
			set @posNext 	= CHARINDEX(@charSplit_, @strValue_, @posStart)
			if (@posNext = 0)
				begin
					set @strTemp = RIGHT(@strValue_, @strLen - @posStart + 1 )
				end
			else
				begin
					set @strTemp = SUBSTRING(@strValue_, @posStart, @posNext - @posStart)
				end
			set @strTemp = LTrim(RTrim(@strTemp))


			------------------------------
			-- 2차분리.
			------------------------------
			set @posCenter 	= CHARINDEX(@charSplit2_, @strTemp, 1)
			set @fieldidx = SUBSTRING(@strTemp, 1, @posCenter - 1)
			set @listidx = RIGHT(@strTemp, len(@strTemp) - @posCenter)
			--select @strTemp, @fieldidx, @listidx, @posCenter, @posStart, @posNext, @strLen

			------------------------------
			-- 데이타입력.
			------------------------------
			if len(@strTemp) > 0
				begin
					insert @SPLIT_TABLE_TEMP (fieldidx, listidx)
					values (@fieldidx, @listidx)
				end
			set @posStart	= @posNext + 1
			if(@posNext >= @strLen)
				begin
					break;
				end
		END
	RETURN
END