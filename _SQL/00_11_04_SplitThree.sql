
/*
SELECT * FROM dbo.fnu_SplitThree(';', ':', '1:-1:0;   2:-1:0;   3:-1:0;    4:-1:0;')
SELECT * FROM dbo.fnu_SplitThree(';', ':', '1:1:2; 11 : 22 : 33 ; 111 :222 : 333 ; 1111 :2222 : 3333 ;')
SELECT * FROM dbo.fnu_SplitThree(';', ':', '1:1:2; 11 : 22 : 33 ; 111 :222 : 333 ; 1111 :2222 : 3333 ;') where param1 = 1

*/


use GameMTBaseball
GO

IF OBJECT_ID ( N'dbo.fnu_SplitThree', N'TF' ) IS NOT NULL
	DROP FUNCTION dbo.fnu_SplitThree;
GO

CREATE FUNCTION dbo.fnu_SplitThree(
	@charSplit_ 		varchar(1),
	@charSplit2_ 		varchar(1),
	@strValue_ 			varchar(8000)
)
	RETURNS
		@SPLIT_TABLE_TEMP TABLE (
			param1			int,
			param2			int,
			param3			int
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
			@param1	varchar(20),
			@param2	varchar(20),
			@param3	varchar(20)
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

			set @param3	= RIGHT(@strTemp, len(@strTemp) - @p2)

			--select @strTemp, @p0, @p1, @p2, @param1, @param2, @param3, @posStart, @posNext, @strLen


			------------------------------
			-- 데이타입력.
			------------------------------
			if len(@strTemp) > 0
				begin
					insert @SPLIT_TABLE_TEMP (param1,  param2,  param3)
					values (                 @param1, @param2, @param3)
				end


			set @posStart	= @posNext + 1
			if(@posNext >= @strLen)
				begin
					break;
				end

		END

	RETURN
END
