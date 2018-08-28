/*
update dbo.tFVUserMaster set cashcost = 1000 where gameid = 'xxxx2'
exec spu_FVAniUrgency 'xxxx2', '049000s1i0n7t8445289', -1
*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVAniUrgency', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVAniUrgency;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_FVAniUrgency
	@gameid_								varchar(60),
	@password_								varchar(20),
	@nResult_								int					OUTPUT
	--WITH ENCRYPTION -- ���ν����� ��ȣȭ��.
as
	------------------------------------------------
	--	2-1. �ڵ尪�ڸ�
	------------------------------------------------
	-- �Ϲݰ�
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	-- �α��� ����.
	declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--������ > �˾�ó���� ��Ʈ�η� ��������.
	declare @RESULT_ERROR_DELETED_USER 			int				set @RESULT_ERROR_DELETED_USER			= -12			--�������� > �˾�ó���� ��Ʈ�η� ��������.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--�ش������� ã�� ����.
	declare @RESULT_ERROR_NOT_FOUND_PASSWORD	int				set @RESULT_ERROR_NOT_FOUND_PASSWORD	= -17
	declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--������ �����ϰ� �ִ�.
	declare @RESULT_NEWVERION_CLIENT_DOWNLOAD 	int				set @RESULT_NEWVERION_CLIENT_DOWNLOAD	= -15			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ��ũó��.
	declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ����.

	-- �����߿� ����.
	declare @RESULT_ERROR_HEART_LACK			int				set @RESULT_ERROR_HEART_LACK			= -20			--��Ʈ�� �����ϴ�.
	declare @RESULT_ERROR_GAMECOST_LACK			int				set @RESULT_ERROR_GAMECOST_LACK			= -21			--�ǹ��� �����ϴ�.
	declare @RESULT_ERROR_CASHCOST_LACK			int				set @RESULT_ERROR_CASHCOST_LACK			= -22			--��尡 �����ϴ�.
	declare @RESULT_ERROR_ITEM_LACK				int				set @RESULT_ERROR_ITEM_LACK				= -23			--�������̺����ϴ�.


	-- ������� �ڵ��ȣ.
	declare @URGENCY_ITEMCODE					int					set @URGENCY_ITEMCODE				= 2100

	------------------------------------------------
	--	2-2. ���°�
	------------------------------------------------

	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @comment			varchar(80)

	declare @gameid 			varchar(60)		set @gameid 		= ''
	declare @market				int
	declare @cashcost			int				set @cashcost		= 0
	declare @gamecost			int				set @gamecost		= 0

	declare @urglistidx			int				set @urglistidx		= -444
	declare @urgcnt				int				set @urgcnt			= 0
	declare @urgcashcost		int				set @urgcashcost	= 99999

Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG �Է°�', @gameid_ gameid_, @password_ password_

	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	-- ���� ����ĳ��
	select
		@gameid 		= gameid,
		@market			= market,
		@cashcost		= cashcost,
		@gamecost		= gamecost
	from dbo.tFVUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG ��������', @gameid gameid, @cashcost cashcost, @gamecost gamecost

	-- ���� ���� ���������.
	select
		@urglistidx		= listidx,
		@urgcnt 		= cnt
	from dbo.tFVUserItem
	where gameid = @gameid_ and itemcode = @URGENCY_ITEMCODE
	--select 'DEBUG ���� ���� ���������', @urglistidx urglistidx, @urgcnt urgcnt

	select
		@urgcashcost = cashcost
	from dbo.tFVItemInfo
	where itemcode = @URGENCY_ITEMCODE
	--select 'DEBUG ��������� ĳ������', @urgcashcost urgcashcost

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '���̵� �������� �ʴ´�.'
			--select 'DEBUG ' + @comment
		END
	else if(@urgcnt <= 0 and @urgcashcost > @cashcost)
		BEGIN
			set @nResult_ = @RESULT_ERROR_CASHCOST_LACK
			set @comment = 'ERROR ĳ���� �����մϴ�.'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS ��������� �����մϴ�.'

			if(@urgcnt > 0)
				begin
					------------------------
					-- ���Ź�ȣ.
					------------------------
					--exec spu_FVUserItemBuyLog @gameid_, @URGENCY_ITEMCODE, 0, 0

					----------------------------------
					--	������� > ��.
					----------------------------------
					set @urgcnt = @urgcnt - 1
					--select 'DEBUG > ���������(0), ĳ��(x) > �������(0)', @urgcnt urgcnt

					update dbo.tFVUserItem
						set
							cnt = @urgcnt
					where gameid = @gameid_ and itemcode = @URGENCY_ITEMCODE
				end
			else
				begin
					----------------------------------
					--	������� > ĳ��.
					----------------------------------
					set @cashcost = @cashcost - @urgcashcost

					-----------------------------------
					-- ���ű�ϸ�ŷ
					-----------------------------------
					exec spu_FVUserItemBuyLog @gameid_, @URGENCY_ITEMCODE, 0, @urgcashcost
				end
		END



	if(@nResult_ = @RESULT_SUCCESS)
		begin
			select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost

			-----------------------------------
			-- ���� ���� �ݿ�.
			-----------------------------------
			update dbo.tFVUserMaster
			set
				cashcost	= @cashcost,
				gamecost	= @gamecost
			where gameid = @gameid_

		end
	else
		begin
			select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost
		end

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off
End



