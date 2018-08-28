
/*
select * from dbo.tFVNotice
SELECT * FROM dbo.fnu_SplitURL(';', ':', '')		-- 외부에서 검사후 
SELECT * FROM dbo.fnu_SplitURL(';', ':', '0:1;1:2;2:3;3:4;4:5;5:6;6:12;7:13;8:14')
SELECT * FROM dbo.fnu_SplitURL(';', ':', '0:http://www.naver.com/;1:http://www.daum.net/;2:;') 
SELECT * FROM dbo.fnu_SplitURL(';', ':', '0:http://www.naver.com/;1:http://www.daum.net/;') where listidx = 0
SELECT * FROM dbo.fnu_SplitURL(';', ':', '0:http://www.naver.com/;1:http://www.daum.net/;') where listidx = 10
SELECT * FROM dbo.fnu_SplitURL(';', ':', '0:http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image01.png;1:http://m.naver.com;2:http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image02.png;3:http://m.daum.com;4:http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image02.png;5:http://m.daum.com;6:http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image02.png;7:http://m.daum.com;8:http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image02.png;9:http://m.daum.com;10:http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image02.png;11:http://m.daum.com;12:http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image02.png;13:http://m.daum.com;14:http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image02.png;15:http://m.daum.com;16:http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image02.png;17:http://m.daum.com;')

-- 1. 커서 생성
declare @listidx		int,
		@data			varchar(40)

declare curTemp Cursor for
select listidx, data FROM dbo.fnu_SplitURL(';', ':', '0:1;2:3')

-- 2. 커서오픈
open curTemp

-- 3. 커서 사용
Fetch next from curTemp into @listidx, @data
while @@Fetch_status = 0
	Begin
		select @listidx, @data
		Fetch next from curTemp into @listidx, @data
	end

-- 4. 커서닫기
close curTemp
Deallocate curTemp
*/
use Farm
GO

IF OBJECT_ID ( N'dbo.fnu_SplitURL', N'TF' ) IS NOT NULL
	DROP FUNCTION dbo.fnu_SplitURL;
GO

CREATE FUNCTION dbo.fnu_SplitURL(
	@charSplit_ 		varchar(1),
	@charSplit2_ 		varchar(1),
	@strValue_ 			varchar(8000)
)
	RETURNS
		@SPLIT_TABLE_TEMP TABLE (
			listidx			int,
			data			varchar(1024)
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
			@listidx	varchar(20),
			@data		varchar(1024)
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
			set @listidx 	= SUBSTRING(@strTemp, 1, @posCenter - 1)
			set @data 		= RIGHT(@strTemp, len(@strTemp) - @posCenter)
			--select @strTemp, @listidx, @data, @posCenter, @posStart, @posNext, @strLen

			------------------------------
			-- 데이타입력.
			------------------------------
			if len(@strTemp) > 0
				begin
					insert @SPLIT_TABLE_TEMP (listidx, data)
					values (@listidx, @data)
				end
			set @posStart	= @posNext + 1
			if(@posNext >= @strLen)
				begin
					break;
				end
		END
	RETURN
END