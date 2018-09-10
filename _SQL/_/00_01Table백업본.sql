
---------------------------------------------
-- 	합성 로그 > 개인자료
---------------------------------------------
IF OBJECT_ID (N'dbo.tComposeLogPerson', N'U') IS NOT NULL
	DROP TABLE dbo.tComposeLogPerson;
GO

create table dbo.tComposeLogPerson(
	idx				int				identity(1, 1),
	idx2			int,

	kind 			int,
	gameid			varchar(20),
	lv				int,
	cashcost		int				default(0),
	ticket			int				default(0),

	itemcode		int				default(-1),
	itemcodename	varchar(40)		default(''),

	itemcode0		int				default(-1),
	itemcode1		int				default(-1),
	itemcode2		int				default(-1),
	itemcode3		int				default(-1),
	itemcode4		int				default(-1),
	itemcode0name	varchar(40)		default(''),

	bgcomposeic		int				default(1),
	bgcomposert		int				default(0),
	bgcomposename	varchar(40)		default(''),

	writedate		datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tComposeLogPerson_idx PRIMARY KEY(idx)
)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tComposeLogPerson_gameid_idx2')
	DROP INDEX tComposeLogPerson.idx_tComposeLogPerson_gameid_idx2
GO
CREATE INDEX idx_tComposeLogPerson_gameid_idx2 ON tComposeLogPerson (gameid, idx2)
GO
-- select top 100 * from dbo.tComposeLogPerson where gameid = 'xxxx2' order by idx desc


