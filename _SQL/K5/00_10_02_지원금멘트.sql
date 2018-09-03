---------------------------------------------
-- �����ݸ�Ʈ.
---------------------------------------------
use GameMTBaseball
GO

IF OBJECT_ID (N'dbo.tSystemSupportMsg', N'U') IS NOT NULL
	DROP TABLE dbo.tSystemSupportMsg;
GO

create table dbo.tSystemSupportMsg(
	idx					int 				IDENTITY(1, 1),

	groupid				int,
	groupline			int,
	msg					varchar(1024)
	-- Constraint
	CONSTRAINT	pk_tSystemSupportMsg_idx	PRIMARY KEY(idx)
)

-- 2013. 4		> ����, �Ҹ��� ����(Ʃ�丮��).
--				>  ���� 300
insert into tSystemSupportMsg(groupid, groupline, msg)	values(0, 0, '�ȳ��ϼ���? �ݰ����ϴ�. ���� �������� �������Ϳ��� �������� ���Ϸ� �� ����Դϴ�.')
insert into tSystemSupportMsg(groupid, groupline, msg)	values(0, 1, '���忡 ���Ӱ� ������ ����� ������ �������տ��� ���� �Ⱓ���� �������� �������ִ� �ý����� �ֽ��ϴ�.')
insert into tSystemSupportMsg(groupid, groupline, msg)	values(0, 2, '������ �Ŵ� [ffcc00]300�� ����[ffffff]�� ������ �帳�ϴ�. �ʿ��ѵ� ������ ����ϼ���. [ffcc00]���� �־�[ffffff]��Ƚ��ϴ�. �׷� ������ �� �˰ڽ��ϴ�.')

-- 2013. 5		>
-- ���� ����	> ���� 300
insert into tSystemSupportMsg(groupid, groupline, msg)	values(1, 0, '�ȳ��ϼ���. �������Ϳ��� ���Խ��ϴ�.')
insert into tSystemSupportMsg(groupid, groupline, msg)	values(1, 1, '�̹��� [ffcc00]������[ffffff]�� �־��Ƚ��ϴ�. ���� ��� �ʿ��� ���� ����Ͻø� �˴ϴ�. �׷� �����ϼ���.')

--2013. 6		> ���谡 �̷���(�����̵�).
--				> ���� 300
insert into tSystemSupportMsg(groupid, groupline, msg)	values(2, 0, '�ȳ��ϼ���? ���Ϳ��� [ffcc00]������[ffffff] �����Ϸ� �Խ��ϴ�.')
insert into tSystemSupportMsg(groupid, groupline, msg)	values(2, 1, '�̹��� �������� ���� �ֽ��ϴ�. ������ �ߵǽô��� �𸣰ڽ��ϴ�.')

--2013. 7		> ������(Ʃ�丮��), �ü����׷��̵�(�����̵�).
--				> ���� 300
insert into tSystemSupportMsg(groupid, groupline, msg)	values(3, 0, '�ȳ��ϼ���? �̹��� [ffcc00]������[ffffff]�� ���� �ֽ��ϴ�.')
insert into tSystemSupportMsg(groupid, groupline, msg)	values(3, 1, '��� ���ϰ� �����? �������� �Ƴ��� ���ð� ����ϼ���.')

--2013. 8		>
-- ġ����.		> ���� 300
insert into tSystemSupportMsg(groupid, groupline, msg)	values(4, 0, '�ȳ��ϼ���? ���� ��� �� �ͼ������̽��ϱ�?')
insert into tSystemSupportMsg(groupid, groupline, msg)	values(4, 1, '�̹��� [ffcc00]������[ffffff]�� �־��Ƚ��ϴ�. �����ϼ���.')

--2013. 9		> ���屸��(Ʃ�丮��)
--				> ���� 300
insert into tSystemSupportMsg(groupid, groupline, msg)	values(5, 0, '�ȳ��ϼ���? �̹��� ������ �帮�� �Խ��ϴ�.')
insert into tSystemSupportMsg(groupid, groupline, msg)	values(5, 1, '�ʿ��� �� �����ø� ���������� �����ؼ� ����ϼ���. �׷� �����ϼ���')

--2013. 10		>
-- ������ȭ		> ���� 300
insert into tSystemSupportMsg(groupid, groupline, msg)	values(6, 0, '�ȳ��ϼ���? ���� ���� �������� ���Ϸ� �Խ��ϴ�.')
insert into tSystemSupportMsg(groupid, groupline, msg)	values(6, 1, '�����ϳ� �帮�ڸ� �ٱ⼼���� ������ �ż����� �ø� �� �ֽ��ϴ�. ���տ� � ���ͼ� [ffcc00]������[ffffff]�� �־��Ƚ��ϴ�.')
insert into tSystemSupportMsg(groupid, groupline, msg)	values(6, 2, '[ffcc00]������ ������ �������� �ٱ⼼�� ����� �ǿ��� ��ȭ[ffffff] �� �� �ֽ��ϴ�.')

--2013. 11		>
-- �ϲ�			> ���� 300
insert into tSystemSupportMsg(groupid, groupline, msg)	values(7, 0, '�ȳ��ϼ���? ���Ϳ��� [ffcc00]������[ffffff] �����Ϸ� �Խ��ϴ�.')
insert into tSystemSupportMsg(groupid, groupline, msg)	values(7, 1, '���ϳ� �� �帮�ڸ� �ϲ��� ����ϼ���. �����ϰ� ��� �� �ֽ��ϴ�. ����� �����.')

--2013. 12		> 4�� ���� ��� ����. ���屸��.
--				> ���� 300
insert into tSystemSupportMsg(groupid, groupline, msg)	values(8, 0, '�ȳ��ϼ���? ���� ��� ����� �ͼ����� �� �����ϴ�.')
insert into tSystemSupportMsg(groupid, groupline, msg)	values(8, 1, '�̹��� [ffcc00]������[ffffff]�� �־� ��Ƚ��ϴ�.. �׷� ������ �� �˰ڽ��ϴ�.')

--2014. 1		>
-- ����â��		> ���� 300
insert into tSystemSupportMsg(groupid, groupline, msg)	values(9, 0, '�ȳ��ϼ���? �̹��� ������ �帮�� �Խ��ϴ�.')
insert into tSystemSupportMsg(groupid, groupline, msg)	values(9, 1, '���ϳ� �帮�ڸ� ���ε��� ��ȣ�ϴ� �������� �ֽ��ϴ�. �װ��� ���صνø� ������ �ܰ��� ����մϴ�.')

--2014. 2		>
-- ����.		> ���� 300
insert into tSystemSupportMsg(groupid, groupline, msg)	values(10, 0, '�̹��� ���������� ������ [ffcc00]������[ffffff]�Դϴ�.')
insert into tSystemSupportMsg(groupid, groupline, msg)	values(10, 3, '����, ���� ���׿�. �̹��� ������ ���� Ƽ���� �������ͼ� [ffcc00]Ư.��.��.[ffffff] ���� �帮�� ���ڽ��ϴ�.')
insert into tSystemSupportMsg(groupid, groupline, msg)	values(10, 2, '���� Ƽ���� ���� �޴����� ���� �� �ֽ��ϴ�. ��ȭ�� ���ؼ� ����� ���� ��� ��ų�� �ֽ��ϴ�. [ffcc00]����� ���ڽ��ϴ�.')


--2014. 3		> ���屸��(�����̵�)
