
/*
use Farm
GO

-- ����Ż��
declare @comment	varchar(256),
        @gameid		varchar(20),
        @schoolidx int

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
		-- exec spu_FVFarmD 19, 94,  1, -1, -1, -1, -1, -1, -1, -1, @gameid, '', '', '', '', '', '', '', '', ''				-- �б����׻���

		Fetch next from curMessage into @gameid
	end

-- 4. Ŀ���ݱ�
close curMessage
Deallocate curMessage
*/




