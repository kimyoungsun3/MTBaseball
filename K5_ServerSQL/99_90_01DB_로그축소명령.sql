
--------------------------------------------------------
-- 아래는 2008MSSQL 서버 축소 명령어 입니다.
-- 2005 축소 명령어는 별도로 있습니다.
--------------------------------------------------------
USE Farm
GO

sp_helpfile

ALTER DATABASE Farm
SET RECOVERY SIMPLE;
GO

-- Shrink the truncated log file to 10 MB. <- 로그파일을 10MB로 축소
DBCC SHRINKFILE (Farm_log, 10);
GO


ALTER DATABASE Farm
SET RECOVERY FULL;
GO