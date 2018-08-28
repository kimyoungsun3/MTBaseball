---------------------------------------------
--		거래보상코드
---------------------------------------------
use GameMTBaseball
GO

IF OBJECT_ID (N'dbo.tSystemBoxInfo', N'U') IS NOT NULL
	DROP TABLE dbo.tSystemBoxInfo;
GO

create table dbo.tSystemBoxInfo(
	--(일반정보)
	idx					int 				IDENTITY(1, 1),
	label				varchar(40)			default(''),
	itemcode			int					default(3700),
	itemname			varchar(40)			default(''),

	-- 코인최소.
	gamecostmin1		int					default(0),
	gamecostmin2		int					default(0),
	gamecostmin3		int					default(0),
	gamecostmin4		int					default(0),
	gamecostmin5		int					default(0),
	gamecostmin6		int					default(0),
	gamecostmin7		int					default(0),
	gamecostmin8		int					default(0),

	--코인최대
	gamecostmax1		int					default(0),
	gamecostmax2		int					default(0),
	gamecostmax3		int					default(0),
	gamecostmax4		int					default(0),
	gamecostmax5		int					default(0),
	gamecostmax6		int					default(0),
	gamecostmax7		int					default(0),
	gamecostmax8		int					default(0),

	--합성카드
	composeticket1		int					default(0),
	composeticket2		int					default(0),
	composeticket3		int					default(0),
	composeticket4		int					default(0),
	composeticket5		int					default(0),
	composeticket6		int					default(0),
	composeticket7		int					default(0),
	composeticket8		int					default(0),

	--승급카드
	promoteticket1		int					default(0),
	promoteticket2		int					default(0),
	promoteticket3		int					default(0),
	promoteticket4		int					default(0),
	promoteticket5		int					default(0),
	promoteticket6		int					default(0),
	promoteticket7		int					default(0),
	promoteticket8		int					default(0),

	--일반세포
	generalstem1		int					default(0),
	generalstem2		int					default(0),
	generalstem3		int					default(0),
	generalstem4		int					default(0),
	generalstem5		int					default(0),
	generalstem6		int					default(0),
	generalstem7		int					default(0),
	generalstem8		int					default(0),

	--에픽세포
	epicstem1			int					default(0),
	epicstem2			int					default(0),
	epicstem3			int					default(0),
	epicstem4			int					default(0),
	epicstem5			int					default(0),
	epicstem6			int					default(0),
	epicstem7			int					default(0),
	epicstem8			int					default(0),

	-- Constraint
	CONSTRAINT pk_tSystemBoxInfo_itemcode	PRIMARY KEY(itemcode)
)
GO
