
--------------------------------------------------------
-- �Ʒ��� 2008MSSQL ���� ��� ��ɾ� �Դϴ�.
-- 2005 ��� ��ɾ�� ������ �ֽ��ϴ�.
--------------------------------------------------------
USE GameMTBaseball
GO

sp_helpfile

ALTER DATABASE GameMTBaseball
SET RECOVERY SIMPLE;
GO

-- Shrink the truncated log file to 10 MB. <- �α������� 10MB�� ���
DBCC SHRINKFILE (GameMTBaseball_log, 10);
GO


ALTER DATABASE GameMTBaseball
SET RECOVERY FULL;
GO