/*
update dbo.tFVUserMaster set logwrite2 =  1 where gameid = 'xxxx2'
exec spu_FVSubUnusualRecord2  'xxxx2', '����ϱ�'
update dbo.tFVUserMaster set logwrite2 = -1 where gameid = 'xxxx2'
exec spu_FVSubUnusualRecord2  'xxxx2', '��Ͼ���'

exec spu_FVSubUnusualRecord2  'xxxx2', '���ġƮTest'
select * from dbo.tFVUserMaster where gameid = 'xxxx2'
*/
use Game4FarmVill3
GO

IF OBJECT_ID ( 'dbo.spu_FVSubUnusualRecord2', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVSubUnusualRecord2;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_FVSubUnusualRecord2
	@gameid_								varchar(60),		-- ���Ӿ��̵�
	@comment_								varchar(512)
	WITH ENCRYPTION -- ���ν����� ��ȣȭ��.
as
	------------------------------------------------
	--	2-2. ���°�
	------------------------------------------------

	------------------------------------------------
	--	2-3. ���λ�� ����
	------------------------------------------------
	declare @logwrite2		int			set @logwrite2		= 1
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	--select 'DEBUG ', @gameid_ gameid_, @comment_ comment_
	select @logwrite2 = logwrite2 from dbo.tFVUserMaster where gameid = @gameid_

	if(@logwrite2 = 1)
		begin
			insert into dbo.tFVUserUnusualLog2(gameid, comment) values(@gameid_, @comment_)
		end

	------------------------------------------------
	set nocount off
End

