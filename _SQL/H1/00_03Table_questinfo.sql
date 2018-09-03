---------------------------------------------
--  ����ƮInfo
---------------------------------------------
IF OBJECT_ID (N'dbo.tQuestInfo', N'U') IS NOT NULL
	DROP TABLE dbo.tQuestInfo;
GO

create table dbo.tQuestInfo(
	idx				int 				IDENTITY(1, 1),
	questlv			int					default(1),
	questlabel		varchar(40),
	
	questcode		int,
	questnext		int,
	
	questkind 		int,
	questsubkind	int,
	questvalue		int,
	
	rewardsb		int					default(0),
	rewarditem		int					default(-1),	
	content			varchar(80),
	questtime		int					default(24),
	questinit		int					default(0),
	questclear		int					default(0),
	questorder		int,
	
	-- Constraint
	CONSTRAINT	pk_tQuestInfo_idx	PRIMARY KEY(questcode)	
)
-- idx
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tQuestInfo_questorder')
    DROP INDEX tQuestInfo.idx_tQuestInfo_questorder
GO
CREATE INDEX idx_tQuestInfo_questorder ON tQuestInfo (questorder)
GO


/*
select * from dbo.tQuestInfo
select 
	'insert into dbo.tQuestInfo('
	+ ' questlv, questlabel, questcode, questnext, questkind, '
	+ ' questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit, '
	+ ' questclear, questorder'
	+ ') values('
		+ ltrim(rtrim(str(questlv))) + ', '
		+ '"' + ltrim(rtrim(questlabel)) + '", '
		+ ltrim(rtrim(str(questcode))) + ', '
		+ ltrim(rtrim(str(questnext))) + ', '
		+ ltrim(rtrim(str(questkind))) + ', '
		+ ltrim(rtrim(str(questsubkind))) + ', '
		+ ltrim(rtrim(str(questvalue))) + ', '
		+ ltrim(rtrim(str(rewardsb))) + ', '
		+ ltrim(rtrim(str(rewarditem))) + ', '
		+ '"' + ltrim(rtrim(content)) + '", '
		+ ltrim(rtrim(str(questtime))) + ', '
		+ ltrim(rtrim(str(questinit))) + ', '
		+ ltrim(rtrim(str(questclear))) + ', '
		+ ltrim(rtrim(str(questorder)))
	+ ')'	
from dbo.tQuestInfo order by idx asc
*/

insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 100, 101, 100, 2, 20, 250, -1, '�� ���� ������ 20�� ��ȭ ����', 6, 1, 0, 2)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 101, 102, 100, 2, 30, 400, -1, '�� ���� ������ 30�� ��ȭ ����', 6, 0, 0, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 102, 103, 100, 2, 50, 600, -1, '�� ���� ������ 50�� ��ȭ ����', 6, 0, 0, 4)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 103, -1, 100, 2, 100, 800, -1, '�� ���� ������ 100�� ��ȭ ����', 6, 0, 0, 4)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 110, 111, 100, 9, 1, 50, -1, '������ 1�� ��ȭ�õ� �ϱ�', 6, 1, 0, 1)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 111, 112, 100, 9, 10, 100, -1, '������ ���� ���� ���� 10ȸ ��ȭ �ϱ�', 6, 0, 0, 2)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 112, 113, 100, 9, 20, 200, -1, '������ ���� ���� ���� 20ȸ ��ȭ �ϱ�', 6, 0, 0, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 113, 114, 100, 9, 100, 500, -1, '������ ���� ���� ���� 100ȸ ��ȭ �ϱ�', 6, 0, 0, 4)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 114, 114, 100, 9, 50, 400, -1, '������ ���� ���� ���� 50ȸ ��ȭ �ϱ�', 6, 0, 1, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 200, 201, 200, 9, 1, 50, -1, '�� ���� 1ȸ �õ� �غ���', 6, 1, 0, 1)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 201, 202, 200, 9, 5, 100, -1, '�� ���� ���� Ƚ�� 5�� �޼� �ϱ�', 6, 0, 0, 2)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 202, 203, 200, 9, 10, 200, -1, '�� ���� ���� Ƚ�� 10�� �޼� �ϱ�', 6, 0, 0, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 203, 204, 200, 9, 20, 400, -1, '�� ���� ���� Ƚ�� 20�� �޼� �ϱ�', 6, 0, 0, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 204, 205, 200, 9, 30, 800, -1, '�� ���� ���� Ƚ�� 30�� �޼� �ϱ�', 6, 0, 0, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 205, 206, 200, 9, 100, 1000, -1, '�� ���� ���� Ƚ�� 100�� �޼� �ϱ�', 6, 0, 0, 4)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 206, 206, 200, 9, 50, 500, -1, '�� ���� ���� Ƚ�� 50�� �޼� �ϱ�', 6, 0, 1, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 300, 301, 300, 1, 10000, 150, -1, '�ӽŸ�� �� 10000�� ����', 6, 1, 0, 2)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 301, 302, 300, 1, 50000, 500, -1, '�ӽŸ�� �� 50000�� ����', 6, 0, 0, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 302, -1, 300, 1, 200000, 800, -1, '�ӽŸ�� �� 200000�� ����', 6, 0, 0, 4)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 310, 311, 300, 2, 1000, 100, -1, '�ӽŸ�忡�� ���� 1000�� �̻� ����', 6, 1, 1, 2)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 311, 312, 300, 2, 4500, 150, -1, '�ӽŸ�忡�� ���� 4500�� �̻� ����', 6, 0, 1, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 312, 312, 300, 2, 9000, 250, -1, '�ӽŸ�忡�� ���� 9000�� �̻� ����', 6, 0, 1, 4)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 320, 321, 300, 9, 1, 50, -1, '�ӽŸ�� 1ȸ �÷��� ����', 6, 1, 0, 1)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 321, 322, 300, 9, 10, 100, -1, '�ӽŸ�� �� 10ȸ �÷���', 6, 0, 0, 2)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 322, 323, 300, 9, 50, 300, -1, '�ӽŸ�� �� 50ȸ �÷���', 6, 0, 0, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 323, 324, 300, 9, 100, 500, -1, '�ӽŸ�� �� 100ȸ �÷���', 6, 0, 0, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 324, 325, 300, 9, 300, 800, -1, '�ӽŸ�� �� 300ȸ �÷���', 6, 0, 0, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 325, -1, 300, 9, 1000, 800, -1, '�ӽŸ�� �� 1000ȸ �÷���', 6, 0, 0, 4)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 400, 401, 400, 1, 10000, 250, -1, '���¸�� �� 10000�� ����', 6, 1, 1, 2)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 401, 402, 400, 1, 50000, 500, -1, '���¸�� �� 50000�� ����', 6, 0, 1, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 402, -1, 400, 1, 200000, 700, -1, '���¸�� �� 200000�� ����', 6, 0, 1, 4)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 410, 411, 400, 2, 500, 250, -1, '���¸�忡�� ���� 500�� �̻� ����', 6, 1, 0, 2)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 411, 412, 400, 2, 2000, 300, -1, '���¸�忡�� ���� 2000�� �̻� ����', 6, 0, 0, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 412, 412, 400, 2, 7000, 500, -1, '���¸�忡�� ���� 7000�� �̻� ����', 6, 0, 1, 4)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 420, 421, 400, 9, 1, 50, -1, '���¸�� 1ȸ �÷��� ����', 6, 1, 0, 1)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 421, 422, 400, 9, 10, 100, -1, '���¸�� �� 10ȸ �÷���', 6, 0, 0, 2)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 422, 423, 400, 9, 50, 300, -1, '���¸�� �� 50ȸ �÷���', 6, 0, 0, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 423, 424, 400, 9, 100, 1000, -1, '���¸�� �� 100ȸ �÷���', 6, 0, 0, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 424, 425, 400, 9, 300, 1000, -1, '���¸�� �� 300ȸ �÷���', 6, 0, 0, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 425, -1, 400, 9, 1000, 1000, -1, '���¸�� �� 1000ȸ �÷���', 6, 0, 0, 4)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 500, 501, 500, 3, 1, 50, -1, '���ο� ģ�� 1�� �߰� �غ���', 6, 1, 0, 1)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 501, 502, 500, 3, 10, 100, -1, '�߰��� ģ�� 10�� ���� �ϱ�', 6, 0, 0, 2)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 502, 503, 500, 3, 20, 200, -1, '�߰��� ģ�� 20�� ���� �ϱ�', 6, 0, 0, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 503, 504, 500, 3, 30, 300, -1, '�߰��� ģ�� 30�� ���� �ϱ�', 6, 0, 0, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 504, -1, 500, 3, 50, 500, -1, '�߰��� ģ�� 50�� ���� �ϱ�', 6, 0, 0, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 510, 511, 500, 4, 5, 50, -1, 'ģ�� 5�� �湮�� ����', 6, 1, 0, 1)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 511, 512, 500, 4, 50, 100, -1, 'ģ�� �� 50�� �湮�ϱ�', 6, 0, 0, 2)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 512, 513, 500, 4, 100, 250, -1, 'ģ�� �� 100�� �湮�ϱ�', 6, 0, 0, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 513, 513, 500, 4, 50, 100, -1, 'ģ�� �� 50�� �湮�ϱ�', 6, 0, 1, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 600, 601, 600, 1, 1, 100, -1, '�� ��Ʈ ���� �غ���', 6, 1, 0, 2)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 601, 602, 600, 1, 10, 300, -1, '�� Ÿ�� ���� 10ȸ ����', 6, 0, 0, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 602, 602, 600, 1, 50, 600, -1, '�� Ÿ�� ���� 50ȸ ����', 6, 0, 1, 4)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 700, 701, 700, 1, 3, 50, -1, '������ 3ȸ ���� ����', 6, 1, 0, 2)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 701, 702, 700, 1, 50, 150, -1, '������ Ÿ�� ���� 50ȸ ����', 6, 0, 0, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 702, 702, 700, 1, 300, 500, -1, '������ Ÿ�� ���� 300ȸ ����', 6, 0, 1, 4)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 800, 801, 800, 1, 2, 100, -1, 'õ�� 2ȸ ���� ����', 6, 1, 0, 2)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 801, 802, 800, 1, 100, 250, -1, 'õ�� Ÿ�� ���� 100ȸ ����', 6, 0, 0, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 802, 802, 800, 1, 500, 1000, -1, 'õ�� Ÿ�� ���� 500ȸ ����', 6, 0, 1, 4)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 900, 901, 900, 1, 50000, 500, -1, '��Ʋ��� ���� ���� 50000�� ����', 6, 1, 0, 2)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 901, 902, 900, 1, 100000, 800, -1, '��Ʋ��� ���� ���� 100000�� ����', 6, 0, 0, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 902, -1, 900, 1, 1000000, 1000, -1, '��Ʋ��� ���� ���� 1000000�� ����', 6, 0, 0, 4)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 910, 911, 900, 5, 5, 250, -1, '��Ʋ��忡�� Ȩ�� ��� 5ȸ', 6, 1, 0, 2)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 911, 911, 900, 5, 200, 500, -1, '��Ʋ��忡�� Ȩ�� ��� 200ȸ', 6, 0, 1, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 920, 921, 900, 6, 3, 50, -1, '��Ʋ��忡�� 1ȸ �÷��̽� Ȩ�� 3�޺� �̻� ���', 6, 1, 1, 2)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 921, 922, 900, 6, 6, 100, -1, '��Ʋ��忡�� 1ȸ �÷��̽� Ȩ�� 6�޺� �̻� ���', 6, 0, 1, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 922, 922, 900, 6, 10, 200, -1, '��Ʋ��忡�� 1ȸ �÷��̽� Ȩ�� 10�޺� �̻� ���', 6, 0, 1, 4)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 930, 931, 900, 7, 5, 100, -1, '��Ʋ��忡�� 5ȸ �¸� �غ���', 6, 1, 0, 2)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 931, 932, 900, 7, 25, 300, -1, '��Ʋ��忡�� �¸� ���� 25ȸ', 6, 0, 0, 2)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 932, 933, 900, 7, 100, 700, -1, '��Ʋ��忡�� �¸� ���� 100ȸ', 6, 0, 0, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 933, 933, 900, 7, 50, 500, -1, '��Ʋ��忡�� �¸� ���� 50ȸ', 6, 0, 1, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 940, 941, 900, 8, 3, 100, -1, '��Ʋ��忡�� ���� 3ȸ ���� �غ���', 6, 1, 1, 2)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 941, 942, 900, 8, 4, 150, -1, '��Ʋ��忡�� ���� 4ȸ �̻� ���', 6, 0, 1, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 942, 940, 900, 8, 5, 250, -1, '��Ʋ��忡�� ���� 5ȸ �̻� ���', 6, 0, 1, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 950, 951, 900, 9, 1, 50, -1, '��Ʋ��� 1ȸ �÷���', 6, 1, 0, 1)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 951, 952, 900, 9, 50, 200, -1, '��Ʋ��� 50ȸ �÷���', 6, 0, 0, 2)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 952, 952, 900, 9, 100, 500, -1, '��Ʋ��� 100ȸ �÷���', 6, 0, 1, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 1000, 1001, 1000, 1, 15000, 300, -1, '�̼Ǹ�� ���� ���� 15000�� ����', 6, 1, 0, 2)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 1001, 1002, 1000, 1, 30000, 500, -1, '�̼Ǹ�� ���� ���� 30000�� ����', 6, 0, 0, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 1002, -1, 1000, 1, 300000, 800, -1, '�̼Ǹ�� ���� ���� 300000�� ����', 6, 0, 0, 4)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 1010, 1011, 1000, 5, 5, 50, -1, '�̼Ǹ�忡�� Ȩ�� ��� 5ȸ', 6, 1, 0, 1)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 1011, 1011, 1000, 5, 100, 500, -1, '�̼Ǹ�忡�� Ȩ�� ��� 100ȸ', 6, 0, 1, 2)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 1020, 1021, 1000, 6, 2, 50, -1, '�̼Ǹ�忡�� 1ȸ �÷��̽� Ȩ�� 2�޺� �̻� ���', 6, 1, 1, 1)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 1021, 1022, 1000, 6, 3, 150, -1, '�̼Ǹ�忡�� 1ȸ �÷��̽� Ȩ�� 3�޺� �̻� ���', 6, 0, 1, 2)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 1022, 1020, 1000, 6, 4, 300, -1, '�̼Ǹ�忡�� 1ȸ �÷��̽� Ȩ�� 4�޺� �̻� ���', 6, 0, 1, 2)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 1030, 1031, 1000, 7, 5, 100, -1, '�̼Ǹ�� �¸� 5ȸ ����', 6, 1, 0, 2)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 1031, 1032, 1000, 7, 25, 300, -1, '�̼Ǹ�� �¸� ���� 25ȸ', 6, 0, 0, 2)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 1032, 1033, 1000, 7, 100, 700, -1, '�̼Ǹ�� �¸� ���� 100ȸ', 6, 0, 0, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 1033, 1033, 1000, 7, 50, 500, -1, '�̼Ǹ�� �¸� ���� 50ȸ', 6, 0, 1, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 1040, 1041, 1000, 8, 4, 100, -1, '�̼Ǹ�忡�� ���� 4ȸ ����', 6, 1, 1, 2)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 1041, 1042, 1000, 8, 7, 500, -1, '�̼Ǹ�忡�� ���� 7ȸ ����', 6, 0, 1, 3)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 1042, 1040, 1000, 8, 10, 800, -1, '�̼Ǹ�忡�� ���� 10ȸ ����', 6, 0, 1, 4)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 1050, 1051, 1000, 9, 1, 50, -1, '�̼Ǹ�� 1ȸ �÷���', 6, 1, 0, 1)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 1051, 1052, 1000, 9, 100, 300, -1, '�̼Ǹ�� 100ȸ �÷���', 6, 0, 1, 2)
insert into dbo.tQuestInfo( questlv, questlabel, questcode, questnext, questkind,  questsubkind, questvalue, rewardsb, rewarditem, content, questtime, questinit,  questclear, questorder) values(1, 'quest', 1052, 1052, 1000, 9, 200, 500, -1, '�̼Ǹ�� 200ȸ �÷���', 6, 0, 1, 3)


