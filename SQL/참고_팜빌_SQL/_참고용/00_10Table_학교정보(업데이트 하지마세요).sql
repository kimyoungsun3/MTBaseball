
/*
use Farm
GO

---------------------------------------------
--		«–±≥¥Î«◊[«–±≥¡§∫∏]
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVSchoolBank', N'U') IS NOT NULL
	DROP TABLE dbo.tFVSchoolBank;
GO

create table dbo.tFVSchoolBank(
	schoolidx				int					IDENTITY(10,1),

	schoolname				varchar(128),
	schoolarea				varchar(128),
	schoolkind				int

	-- Constraint
	CONSTRAINT	pk_tSchoolBank_schoolidx	PRIMARY KEY(schoolidx)
)
-- ∆˘¿Œµ¶ΩÃ
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVSchoolBank_schoolname_schoolarea_schoolkind')
    DROP INDEX tFVSchoolBank.idx_tFVSchoolBank_schoolname_schoolarea_schoolkind
GO
CREATE INDEX idx_tFVSchoolBank_schoolname_schoolarea_schoolkind ON tSchoolBank (schoolname, schoolarea, schoolkind)
GO

--if(not exists(select top 1 * from dbo.tFVSchoolBank where schoolname = 'øÎ∫¿√ µÓ«–±≥' and schoolarea = '±§¡÷' and schoolkind = 1))
--	begin
--		insert into dbo.tFVSchoolBank(schoolkind, schoolarea, schoolname) values(1, '±§¡÷', 'øÎ∫¿√ µÓ«–±≥')
--	end
-- select * from dbo.tFVSchoolBank where schoolkind = 1 and schoolname like '%øÎ∫¿%'
-- select * from dbo.tFVSchoolBank where schoolkind = 2 and schoolname like '%øÎ∫¿%'
-- select * from dbo.tFVSchoolBank where schoolkind = 3 and schoolname like '%øÎ∫¿%'
-- select * from dbo.tFVSchoolBank where schoolkind = 4 and schoolname like '%øÎ∫¿%'
*/