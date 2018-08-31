---------------------------------------------
-- 	Ŭ���̸� ������
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

insert into dbo.tBattleCountryClub(cname, gameid, ccode) values('�ѱ�', 'SangSang',  1)
insert into dbo.tBattleCountryClub(cname, gameid, ccode) values('����', 'SangSang',  2)
insert into dbo.tBattleCountryClub(cname, gameid, ccode) values('��õ', 'SangSang',  3)
insert into dbo.tBattleCountryClub(cname, gameid, ccode) values('����', 'SangSang',  4)
insert into dbo.tBattleCountryClub(cname, gameid, ccode) values('�뱸', 'SangSang',  5)
insert into dbo.tBattleCountryClub(cname, gameid, ccode) values('���', 'SangSang',  6)
insert into dbo.tBattleCountryClub(cname, gameid, ccode) values('����', 'SangSang',  7)
insert into dbo.tBattleCountryClub(cname, gameid, ccode) values('�λ�', 'SangSang',  8)
insert into dbo.tBattleCountryClub(cname, gameid, ccode) values('���', 'SangSang',  9)
insert into dbo.tBattleCountryClub(cname, gameid, ccode) values('����', 'SangSang', 10)
insert into dbo.tBattleCountryClub(cname, gameid, ccode) values('���', 'SangSang', 11)
insert into dbo.tBattleCountryClub(cname, gameid, ccode) values('�泲', 'SangSang', 12)
insert into dbo.tBattleCountryClub(cname, gameid, ccode) values('����', 'SangSang', 13)
insert into dbo.tBattleCountryClub(cname, gameid, ccode) values('����', 'SangSang', 14)
insert into dbo.tBattleCountryClub(cname, gameid, ccode) values('���', 'SangSang', 15)
insert into dbo.tBattleCountryClub(cname, gameid, ccode) values('�泲', 'SangSang', 16)
insert into dbo.tBattleCountryClub(cname, gameid, ccode) values('����', 'SangSang', 17)
insert into dbo.tBattleCountryClub(cname, gameid, ccode) values('����', 'SangSang', 18)
insert into dbo.tBattleCountryClub(cname, gameid, ccode) values('����Ŭ��', 'pjstime', 19)
-- select top 1   * from dbo.tBattleCountryClub where ccode = 2
-- select top 1   * from dbo.tBattleCountryClub where cname = '����'
-- update dbo.tBattleCountryClub 
--	set 
--		cnt = cnt + 1
-- where ccode = 2
