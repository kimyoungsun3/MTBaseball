---------------------------------------------
--		아이템 정보
---------------------------------------------
IF OBJECT_ID (N'dbo.tItemInfo', N'U') IS NOT NULL
	DROP TABLE dbo.tItemInfo;
GO

create table dbo.tItemInfo(
	idx				int				IDENTITY(1,1), 		-- 번호		
	labelname		varchar(40), 						-- 레이블		
	itemcode		int, 								-- 코드
	lv				int				default(0),			-- 레벨
	itemname		varchar(256), 						-- 아이템이름		
	sex				int, 								-- 성별		
	kind			int, 								-- 대분류			
	setcode			int, 								-- 세트카테고리		
	active			int, 								-- 
	itemfilename	varchar(20), 						-- 파일이름		
	pluspower		int, 								-- pluspower
	sale			int				default(0), 		-- 할인하기		
	backicon		int				default(0), 		-- 백아이콘
	iconindex		int, 								-- 아이콘		
	param1			varchar(20)		default(0),
	param2			varchar(20)		default(0),
	param3			varchar(20)		default(0),
	param4			varchar(20)		default(0),
	param5			varchar(20)		default(0),
	param6			varchar(20)		default(0),
	param7			varchar(20)		default(0),
	param8			varchar(20)		default(0),
	param9			varchar(20)		default(0),
	silverball		int				default(0),			
	goldball		int				default(0),				
	period			int				default(-1), 		-- 기간
	explain			varchar(512), 						-- 설명
	 
	-- Constraint
	CONSTRAINT	pk_tItemInfo_itemcode	PRIMARY KEY(itemcode)	
) 
-- 선물리스트(캐릭터제외, 자동클러스터딩됨)
-- 캐릭터 선물제외(템이 많이 들어간다.), 커스터마이징 선물제외(직접입력하므로 구현불가)
-- select * from dbo.tItemInfo where kind in (2, 4, 5, 6, 7, 8 , 9, 100, 80, 90) order by itemcode asc
-- select * from dbo.tItemInfo where kind in (60) order by itemcode asc
-- select * from dbo.tItemInfo order by itemcode asc
-- select * from dbo.tItemInfo where itemcode = 1 order by itemcode asc
/*
-- 황금룰렛
select * from dbo.tItemInfo 
where kind = 6
and goldball > 0 and goldball < 500
and sex = 255
and itemcode not in (
153, 154, 156, 157, 161, 162, 163, 164,
253, 254, 256, 257, 261, 262, 263, 264,
353, 354, 356, 357, 361, 362, 363, 364, 
455, 456, 457, 458, 459, 460, 461, 462)

-- 일반룰렛
select * from dbo.tItemInfo 
where kind = 6
and silverball > 0 and silverball < (2000 + 50000)
and sex = 255
and itemcode not in (
153, 154, 156, 157, 161, 162, 163, 164,
253, 254, 256, 257, 261, 262, 263, 264,
353, 354, 356, 357, 361, 362, 363, 364, 
455, 456, 457, 458, 459, 460, 461, 462)

-- 미션지급
select * from dbo.tItemInfo 
where ((kind in (2, 4, 5) and sex != 0) or (sex = 255 and kind = 6))
and silverball > 0 and silverball < 50000
and itemcode not in (
153, 154, 156, 157, 161, 162, 163, 164,
253, 254, 256, 257, 261, 262, 263, 264,
353, 354, 356, 357, 361, 362, 363, 364, 
455, 456, 457, 458, 459, 460, 461, 462)



*/