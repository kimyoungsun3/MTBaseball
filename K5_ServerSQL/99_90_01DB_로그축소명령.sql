
--------------------------------------------------------
-- �Ʒ��� 2008MSSQL ���� ��� ��ɾ� �Դϴ�.
-- 2005 ��� ��ɾ�� ������ �ֽ��ϴ�.
--------------------------------------------------------
USE Farm
GO

sp_helpfile

ALTER DATABASE Farm
SET RECOVERY SIMPLE;
GO

-- Shrink the truncated log file to 10 MB. <- �α������� 10MB�� ���
DBCC SHRINKFILE (Farm_log, 10);
GO


ALTER DATABASE Farm
SET RECOVERY FULL;
GO