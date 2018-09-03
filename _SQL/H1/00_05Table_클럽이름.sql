---------------------------------------------
-- 	클럽이름 마스터
---------------------------------------------
IF OBJECT_ID (N'dbo.tBattleCountryClub', N'U') IS NOT NULL
	DROP TABLE dbo.tBattleCountryClub;
GO

create table dbo.tBattleCountryClub(	
	idx				int				identity(1, 1),
	
	ccode			int,
	cname			varchar(20),
	cnt				int				default(1),
	gameid			varchar(20),

	-- Constraint
	CONSTRAINT	pk_tBattleCountryClub_ccode	PRIMARY KEY(ccode)	
)

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tBattleCountryClub_cname')
    DROP INDEX tBattleCountryClub.idx_tBattleCountryClub_cname
GO
CREATE INDEX idx_tBattleCountryClub_cname ON tBattleCountryClub (cname)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tBattleCountryClub_gameid')
    DROP INDEX tBattleCountryClub.idx_tBattleCountryClub_gameid
GO
CREATE INDEX idx_tBattleCountryClub_gameid ON tBattleCountryClub (gameid)
GO

insert into dbo.tBattleCountryClub(cname, gameid, ccode) values('한국', 'SangSang',  1)
insert into dbo.tBattleCountryClub(cname, gameid, ccode) values('서울', 'SangSang',  2)
insert into dbo.tBattleCountryClub(cname, gameid, ccode) values('인천', 'SangSang',  3)
insert into dbo.tBattleCountryClub(cname, gameid, ccode) values('광주', 'SangSang',  4)
insert into dbo.tBattleCountryClub(cname, gameid, ccode) values('대구', 'SangSang',  5)
insert into dbo.tBattleCountryClub(cname, gameid, ccode) values('울산', 'SangSang',  6)
insert into dbo.tBattleCountryClub(cname, gameid, ccode) values('대전', 'SangSang',  7)
insert into dbo.tBattleCountryClub(cname, gameid, ccode) values('부산', 'SangSang',  8)
insert into dbo.tBattleCountryClub(cname, gameid, ccode) values('경기', 'SangSang',  9)
insert into dbo.tBattleCountryClub(cname, gameid, ccode) values('강원', 'SangSang', 10)
insert into dbo.tBattleCountryClub(cname, gameid, ccode) values('충북', 'SangSang', 11)
insert into dbo.tBattleCountryClub(cname, gameid, ccode) values('충남', 'SangSang', 12)
insert into dbo.tBattleCountryClub(cname, gameid, ccode) values('전북', 'SangSang', 13)
insert into dbo.tBattleCountryClub(cname, gameid, ccode) values('전남', 'SangSang', 14)
insert into dbo.tBattleCountryClub(cname, gameid, ccode) values('경북', 'SangSang', 15)
insert into dbo.tBattleCountryClub(cname, gameid, ccode) values('경남', 'SangSang', 16)
insert into dbo.tBattleCountryClub(cname, gameid, ccode) values('제주', 'SangSang', 17)
insert into dbo.tBattleCountryClub(cname, gameid, ccode) values('독도', 'SangSang', 18)
insert into dbo.tBattleCountryClub(cname, gameid, ccode) values('섹시클럽', 'pjstime', 19)
-- select top 1   * from dbo.tBattleCountryClub where ccode = 2
-- select top 1   * from dbo.tBattleCountryClub where cname = '제주'
-- update dbo.tBattleCountryClub 
--	set 
--		cnt = cnt + 1
-- where ccode = 2
