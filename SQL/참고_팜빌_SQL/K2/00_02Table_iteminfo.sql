---------------------------------------------
--		아이템 정보
---------------------------------------------
use Farm
GO

IF OBJECT_ID (N'dbo.tFVItemInfo', N'U') IS NOT NULL
	DROP TABLE dbo.tFVItemInfo;
GO

create table dbo.tFVItemInfo(
	idx				int				IDENTITY(1,1), 		-- 번호

	labelname		varchar(40), 						-- 레이블

	itemcode		int, 								-- 아이템 코드
	category		int,								-- 카테고리
	subcategory		int, 								-- 서브 카테고리
	equpslot		int, 								-- 장착 슬롯
	itemname		varchar(40), 						-- 아이템 이름
	activate		int, 								-- 사용 여부
	toplist			int, 								-- 상단게시
	grade			int, 								-- 등급
	discount		int, 								-- 세일여부
	icon			varchar(40), 						-- 아이콘
	playerlv		int, 								-- 요구 명성레벨
	houselv			int, 								-- 요구 주택 레벨
	gamecost		int, 								-- 코인가격
	cashcost		int, 								-- 캐시가격
	buyamount		int, 								-- 1회구매수량
	sellcost		int, 								-- 판매
	description		varchar(256), 						--

	param1			int				default(-999),
	param2			int				default(-999),
	param3			varchar(40)		default(-999),
	param4			varchar(40)		default(-999),
	param5			varchar(40)		default(-999),
	param6			varchar(40)		default(-999),
	param7			varchar(40)		default(-999),
	param8			varchar(40)		default(-999),
	param9			varchar(40)		default(-999),
	param10			varchar(40)		default(-999),
	param11			varchar(40)		default(-999),
	param12			varchar(40)		default(-999),
	param13			varchar(40)		default(-999),
	param14			varchar(40)		default(-999),
	param15			varchar(40)		default(-999),

	param16			varchar(40)		default(-999),
	param17			varchar(40)		default(-999),
	param18			varchar(40)		default(-999),
	param19			varchar(40)		default(-999),
	param20			varchar(40)		default(-999),

	-- Constraint
	CONSTRAINT	pk_tFVItemInfo_itemcode	PRIMARY KEY(itemcode)
)
-- select * from dbo.tFVItemInfo where kind in (2, 4, 5, 6, 7, 8 , 9, 100, 80, 90) order by itemcode asc

