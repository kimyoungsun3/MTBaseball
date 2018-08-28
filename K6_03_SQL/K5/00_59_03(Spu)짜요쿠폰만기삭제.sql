/*
exec spu_DeleteUserExpire 'xxxx2'
*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_DeleteUserExpire', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_DeleteUserExpire;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_DeleteUserExpire
	@gameid_								varchar(20)
	--WITH ENCRYPTION -- ���ν����� ��ȣȭ��.
as

Begin
	--declare @ITEM_ZCP_PIECE_MOTHER			int				set @ITEM_ZCP_PIECE_MOTHER				= 3800	-- ¥����������.
	declare @ITEM_ZCP_TICKET_MOTHER				int				set @ITEM_ZCP_TICKET_MOTHER				= 3801	-- ¥������.

	declare @listidx				int						set @listidx			= -1

	-- 1. �����ϱ�.
	declare curZCPExpire Cursor for
	select listidx from dbo.tUserItem
	where gameid = @gameid_ and itemcode = @ITEM_ZCP_TICKET_MOTHER and expiredate < getdate()
	order by idx asc

	-- 2. Ŀ������
	open curZCPExpire

	-- 3. Ŀ�� ���
	Fetch next from curZCPExpire into @listidx
	while @@Fetch_status = 0
		Begin
			exec spu_DeleteUserItemBackup 11, @gameid_, @listidx
			Fetch next from curZCPExpire into @listidx
		end

	-- 4. Ŀ���ݱ�
	close curZCPExpire
	Deallocate curZCPExpire


	set nocount off
End

