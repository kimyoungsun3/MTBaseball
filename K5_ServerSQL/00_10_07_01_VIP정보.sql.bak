---------------------------------------------
-- VIPÁö±Þ.
---------------------------------------------
use Game4Farmvill5
GO

IF OBJECT_ID (N'dbo.tSystemVIPInfo', N'U') IS NOT NULL
	DROP TABLE dbo.tSystemVIPInfo;
GO

create table dbo.tSystemVIPInfo(
	idx					int 				IDENTITY(1, 1),
	label				varchar(40)			default(''),

	vip_grade			int,
	vip_cashpoint		int,
	vip_cashplus		int,
	vip_gamecost		int,
	vip_heart			int,
	vip_animal10		int,
	vip_wheel10			int,
	vip_treasure10		int,
	vip_box				int,
	vip_fbplus			int,

	-- Constraint
	CONSTRAINT	pk_tSystemVIPInfo_idx	PRIMARY KEY(idx)
)
