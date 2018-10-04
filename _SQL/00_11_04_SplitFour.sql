
/*
SELECT * FROM dbo.fnu_SplitFour(';', ':', '1:-1:-1:0;2:-1:-1:0;3:-1:-1:0;4:-1:-1:0;')
SELECT * FROM dbo.fnu_SplitFour(';', ':', '1:0:1600:1;2:-1:-1:0;3:-1:-1:0;4:-1:-1:0;')
SELECT * FROM dbo.fnu_SplitFour(';', ':', '1:1:2:3;2:11:12:13;3:21:22:23;4:31:32:33;')
SELECT * FROM dbo.fnu_SplitFour(';', ':', '1:1:2:3; 11 : 22 : 33 : 44 ; 111 :222 : 333: 444 ; 1111 :2222 : 3333: 4444 ;')
SELECT * FROM dbo.fnu_SplitFour(';', ':', '1:1:2:3; 11 : 22 : 33 : 44 ; 111 :222 : 333: 444 ; 1111 :2222 : 3333: 4444 ;') where param1 = 1

-- 1. 커서 생성
declare @idx			int,
		@select			int,
		@itemcode		int,
		@cnt			int

declare curTemp Cursor for
select idx, select, itemcode, cnt FROM dbo.fnu_SplitFour(';', ',', '0,1;2,3')

-- 2. 커서오픈
open curTemp

-- 3. 커서 사용
Fetch next from curTemp into @idx, @select, @itemcode, @cnt
while @@Fetch_status = 0
	Begin
		select @idx, @select, @itemcode, @cnt
		Fetch next from curTemp into @idx, @select, @itemcode, @cnt
	end

-- 4. 커서닫기
close curTemp
Deallocate curTemp
*/


use GameMTBaseball
GO

IF OBJECT_ID ( N'dbo.fnu_SplitFour', N'TF' ) IS NOT NULL
	DROP FUNCTION dbo.fnu_SplitFour;
GO

CREATE FUNCTION dbo.fnu_SplitFour(
	@charSplit_ 		varchar(1),
	@charSplit2_ 		varchar(1),
	@strValue_ 			varchar(8000)
)
	RETURNS
		@SPLIT_TABLE_TEMP TABLE (
			param1			int,
			param2			int,
			param3			int,
			param4			int
		)
AS
begin
	--declare @charSplit_ 		varchar(1),
	--		@charSplit2_ 		varchar(1),
	--		@strValue_ 			varchar(8000)
	--set @charSplit_ = ';'
	--set @charSplit2_ = ':'
	--set @strValue_ = '0:1:2:3; 11 : 22 : 33 : 44 ; 111 :222 : 333: 444 '

	declare @posStart 	int,
			@posNext 	int,
			@strLen		int,
			@p0			int,
			@p1			int,
			@p2			int,
			@p3			int,
			@param1	varchar(20),
			@param2	varchar(20),
			@param3	varchar(20),
			@param4	varchar(20)
	declare @strTemp 	VARCHAR(8000) 	-- 분리된 문자열 임시 저장변수

	set @posStart 	= 1 	-- 구분문자 검색을 시작할 위치
	set @posNext 	= 1 	-- 구분문자 위치
	set @strValue_ 		= LTrim(RTrim(@strValue_))
	set @strLen			= len(@strValue_)

	while (@posNext > 0)
		begin
			------------------------------
			-- 1-1차분리.
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
			set @strTemp	= LTrim(RTrim(@strTemp))
			------------------------------
			-- 1-2차분리.
			------------------------------
			set @p0		= 1
			set @p1 	= CHARINDEX(@charSplit2_, @strTemp, @p0)
			set @param1	= SUBSTRING(@strTemp, @p0, @p1 - @p0)

			set @p2 	= CHARINDEX(@charSplit2_, @strTemp, @p1 + 1)
			set @param2	= SUBSTRING(@strTemp, @p1 + 1, @p2 - @p1 - 1)

			set @p3 	= CHARINDEX(@charSplit2_, @strTemp, @p2 + 1)
			set @param3	= SUBSTRING(@strTemp, @p2 + 1, @p3 - @p2 - 1)

			set @param4	= RIGHT(@strTemp, len(@strTemp) - @p3)

			--select @strTemp, @p0, @p1, @p2, @p3, @param1, @param2, @param3, @param4, @posStart, @posNext, @strLen


			------------------------------
			-- 데이타입력.
			------------------------------
			if len(@strTemp) > 0
				begin
					insert @SPLIT_TABLE_TEMP (param1,  param2,  param3,  param4)
					values (                 @param1, @param2, @param3, @param4)
				end


			set @posStart	= @posNext + 1
			if(@posNext >= @strLen)
				begin
					break;
				end

		END

	RETURN
END
