/*
---------------------------------------------
-- 지원금멘트.
---------------------------------------------
use GameMTBaseball
GO

IF OBJECT_ID (N'dbo.tSystemWheelInfo', N'U') IS NOT NULL
	DROP TABLE dbo.tSystemWheelInfo;
GO

create table dbo.tSystemWheelInfo(
	idx					int 				IDENTITY(1, 1),

	kind				int,									-- 무료(20), 유료(21)
	itemcode			int,
	cnt					int,
	randval				int,

	adlog				int,									-- 무광고(0), 광고(1)
	-- Constraint
	CONSTRAINT	pk_tSystemWheelInfo_idx	PRIMARY KEY(idx)
)


-- 무료세팅 (1일 1회).
insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(20, 5000, 5,   1500, 0)	-- 루비세팅(5000)
insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(20, 5000, 20,  2000, 0)
insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(20, 5000, 5,   1500, 0)
insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(20, 5000, 200,   50, 0)

insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(20, 2000, 5,   1500, 0)	-- 하트세팅(2000)
insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(20, 2000, 20,  2000, 0)
insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(20, 2000, 5,   1500, 0)
insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(20, 2000, 200,   50, 0)

-- 1차 유료세팅 (300루비).
--insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 2000, 300,  2000, 0)	-- 하트(2000)x1
--insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 5000, 3000,    2, 1)	-- 루비세팅 (5000)
--insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 5100, 6000, 2000, 0)	-- 코인(5100)x2
--insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 1002, 30,    400, 0)	-- 알바의귀재(1002)x1.5
--insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 3500, 200,   120, 1)	-- 합성의훈장(3500)
--insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 2300, 6,      20, 1)	-- 프리미엄 교배티켓(2300)
--insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 5100, 12000, 700, 1)	-- 코인(5100)x4
--insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 3600, 200,   120, 1)	-- 승급의꽃(3600)

-- 거래와 배틀 유도용 > 배틀티켓과 황금티켓
-- 2차 유료세팅 (300루비).
-- select * from dbo.tSystemWheelInfo where kind = 21
-- delete from dbo.tSystemWheelInfo where kind = 21
--insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 2600, 2,     500, 1)	-- 프리미엄 보물티켓(2600)
--insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 5000, 3000,    2, 1)	-- 루비세팅 (5000)
--insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 3000, 330,   600, 0)	-- 황금티켓(3000)
--insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 3100, 330,  1000, 0)	-- 배틀티켓(3100)
--insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 3500, 200,   140, 1)	-- 합성의훈장(3500)
--insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 2300, 6,      20, 1)	-- 프리미엄 교배티켓(2300)
--insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 5100, 20000, 700, 1)	-- 코인(5100)x4
--insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 3600, 200,   140, 1)	-- 승급의꽃(3600)

--select top 8 * from dbo.tSystemWheelInfo where kind = 20
--select top 8 * from dbo.tSystemWheelInfo where kind = 21


-- 승급과 합성템 > 상위동물로올가는 용도.
-- 5.20 3차 유료세팅 (300루비).
-- select * from dbo.tSystemWheelInfo where kind = 21
-- delete from dbo.tSystemWheelInfo where kind = 21
--insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 2600, 2,    1000, 1)	-- 프리미엄 보물티켓(2600)
--insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 5000, 3000,    2, 1)	-- 루비세팅 (5000)
--insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 3703, 1,     200, 1)	-- 자이언트박스(3703)
--insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 1002, 45,   1000, 0)	-- 알바의귀재(1002)
--insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 3704, 1,     140, 1)	-- 마법박스(3704)
--insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 1900, 1000, 1000, 1)	-- 우정포인트(1900)
--insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 5100, 20000,1000, 1)	-- 코인(5100)x4
--insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 3705, 1,      80, 1)	-- 슈퍼마법박스(3705)


-- 거래와 배틀 유도용 > 배틀티켓과 황금티켓
-- 4차 유료세팅 (300루비).
-- select * from dbo.tSystemWheelInfo where kind = 21
-- delete from dbo.tSystemWheelInfo where kind = 21
insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 2600, 2,    1000, 0)	-- 프리미엄 보물티켓(2600)
insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 5000, 3000,    2, 1)	-- 루비세팅 (5000)
insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 3000, 250,   400, 0)	-- 황금티켓(3000)
insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 3100, 250,   400, 0)	-- 배틀티켓(3100)
insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 3500, 200,   140, 1)	-- 합성의훈장(3500)
insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 2300, 2,    1200, 0)	-- 프리미엄 교배티켓(2300)
insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 5100, 25000,1000, 1)	-- 코인(5100)x4
insert into tSystemWheelInfo(kind, itemcode, cnt, randval, adlog)	values(21, 3600, 200,   140, 1)	-- 승급의꽃(3600)

-- 루비세팅 (5000)
-- 하트(2000)
-- 코인(5100)

-- 알바의귀재(1002)
-- 특수촉진제(1103)
-- 특수탄(703)
-- 부활석(1200)					1개 20루비
-- 긴급요청(2100)				1개 20루비

-- 프리미엄 교배티켓(2300)		1개 300루비
-- 프리미엄 보물티켓(2600)		1개 300루비
-- 황금티켓(3000)
-- 배틀티켓(3100)

-- 합성의훈장(3500)
-- 승급의꽃(3600)

-- 자이언트박스(3703)
-- 마법박스(3704)
-- 슈퍼마법박스(3705)

-- 우정포인트(1900)				300루비 -> 1회 80루비, 4번 (320우포) -> 2배는 1000우포
-- VIP포인트(
*/