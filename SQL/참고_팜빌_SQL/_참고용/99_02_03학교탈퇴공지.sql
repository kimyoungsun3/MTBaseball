
/*
use Farm
GO

-- 1452		424		���ֿ���ʵ��б�
--11960		249		������б�
--12001		143		�����б�
--12055		140		������б�
--12000		135		���հ����б�
--11951		116		���հ����б�
-----------------------------------------
-- �ش� �ο��鿡�� ���� �߼�.
declare @comment	varchar(256),
        @comment2	varchar(256),
        @gameid		varchar(20),
        @schoolidx int

set @comment     = '[¥��ҳ�]�η� ������ �ش��ϴ� �б��Դϴ�. �����Ͽ��� �б� ������ �����ϴ�, ������ ���Ͻô� �б��� �̵��Ͻñ� �ٶ��ϴ�.'
set @comment2    = '[¥��ҳ�]�����̵��� ���ø� ������ Ŭ���� �Ȼ��·� �ʱ�ȭ �˴ϴ�.'

-- 1. �����ϱ�.
declare curMessage Cursor for
select gameid from dbo.tFVUserMaster where schoolidx in  (1452, 11960, 12001, 12055, 12000, 11951)

-- 2. Ŀ������
open curMessage

-- 3. Ŀ�� ���
Fetch next from curMessage into @gameid
while @@Fetch_status = 0
	Begin
		-- select 'DEBUG ', @gameid gameid
		exec spu_FVFarmD 27, 12, -1, -1, -1, -1, -1, -1, -1, -1, 'blackm', @gameid, @comment, '', '', '', '', '', '', ''	-- �����߼�
		exec spu_FVFarmD 27, 12, -1, -1, -1, -1, -1, -1, -1, -1, 'blackm', @gameid, @comment2, '', '', '', '', '', '', ''	-- �����߼�

		Fetch next from curMessage into @gameid
	end

-- 4. Ŀ���ݱ�
close curMessage
Deallocate curMessage
*/




