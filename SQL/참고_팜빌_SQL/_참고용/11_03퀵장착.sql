---------------------------------------------------------------
/*
-- �Ҹ�.
exec spu_FVItemQuick 'xxxx9', '049000s1i0n7t8445289',  7, 1, -1	-- �Ѿ�
exec spu_FVItemQuick 'xxxx9', '049000s1i0n7t8445289',  7,-1, -1	-- �Ѿ�(����)
exec spu_FVItemQuick 'xxxx9', '049000s1i0n7t8445289',  8, 1, -1	-- ġ����
exec spu_FVItemQuick 'xxxx9', '049000s1i0n7t8445289',  8,-1, -1	-- ġ����(����)
exec spu_FVItemQuick 'xxxx9', '049000s1i0n7t8445289',  9, 1, -1	-- �ϲ�
exec spu_FVItemQuick 'xxxx9', '049000s1i0n7t8445289',  9,-1, -1	-- �ϲ�(����)
exec spu_FVItemQuick 'xxxx9', '049000s1i0n7t8445289', 10, 1, -1	-- ������
exec spu_FVItemQuick 'xxxx9', '049000s1i0n7t8445289', 10,-1, -1	-- ������(����)
*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVItemQuick', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVItemQuick;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_FVItemQuick
	@gameid_				varchar(60),
	@password_				varchar(20),
	@listidx_				int,
	@quickkind_				int,
	@nResult_				int					OUTPUT
	--WITH ENCRYPTION
as
	------------------------------------------------
	--	2-1. �ڵ尪
	------------------------------------------------
	-- �Ϲݰ�
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	-- �α��� ����.
	declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--������ > �˾�ó���� ��Ʈ�η� ��������.
	declare @RESULT_ERROR_DELETED_USER 			int				set @RESULT_ERROR_DELETED_USER			= -12			--�������� > �˾�ó���� ��Ʈ�η� ��������.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--�ش������� ã�� ����
	declare @RESULT_ERROR_NOT_FOUND_PASSWORD	int				set @RESULT_ERROR_NOT_FOUND_PASSWORD	= -17
	declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--������ �����ϰ� �ִ�.
	declare @RESULT_NEWVERION_CLIENT_DOWNLOAD 	int				set @RESULT_NEWVERION_CLIENT_DOWNLOAD	= -15			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ��ũó��.
	declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ����.

	-- �����߿� ����.
	declare @RESULT_ERROR_HEART_LACK			int				set @RESULT_ERROR_HEART_LACK			= -20			--��Ʈ�� �����ϴ�.
	declare @RESULT_ERROR_GAMECOST_LACK			int				set @RESULT_ERROR_GAMECOST_LACK			= -21			--�ǹ��� �����ϴ�.
	declare @RESULT_ERROR_CASHCOST_LACK			int				set @RESULT_ERROR_CASHCOST_LACK			= -22			--��尡 �����ϴ�.
	declare @RESULT_ERROR_ITEM_LACK				int				set @RESULT_ERROR_ITEM_LACK				= -23			--�������̺����ϴ�.

	-- ���� �ڵ尪
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- �������ڵ��ã��
	declare @RESULT_ERROR_GIFTITEM_NOT_FOUND	int				set @RESULT_ERROR_GIFTITEM_NOT_FOUND	= -51			-- ������������ ��ã��
	declare @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	int				set @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	= -52			-- ������ �̹� ������
	declare @RESULT_ERROR_NOT_FOUND_GIFTID		int				set @RESULT_ERROR_NOT_FOUND_GIFTID		= -75			-- ĳ�� > ������ ���̵� ��ã��

	-- ��Ÿ����
	declare @RESULT_ERROR_RESULT_COPY			int				set @RESULT_ERROR_RESULT_COPY			= -53			-- ���ī�ǽõ�
	declare @RESULT_ERROR_GAMECOST_COPY			int				set @RESULT_ERROR_GAMECOST_COPY			= -54			-- �ǹ�ī�ǽõ�
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- ���������ʴ¸��
	declare @RESULT_ERROR_HEART_FULL			int				set @RESULT_ERROR_HEART_FULL			= -71			-- ���������ʴ¸��
	declare @RESULT_ERROR_TUTORIAL_ALREADY		int				set @RESULT_ERROR_TUTORIAL_ALREADY		= -73			-- ���丮�� �̹� ����.
	declare @RESULT_ERROR_NOT_FOUND_OTHERID		int				set @RESULT_ERROR_NOT_FOUND_OTHERID		= -83
	declare @RESULT_ERROR_INVEN_FULL			int				set @RESULT_ERROR_INVEN_FULL			= -101			-- �κ�����
	declare @RESULT_ERROR_NOT_MATCH				int				set @RESULT_ERROR_NOT_MATCH				= -110			-- �����ΰ� ��ġ�� �ȵǾ���.
	declare @RESULT_ERROR_DOUBLE_RANDSERIAL		int				set @RESULT_ERROR_DOUBLE_RANDSERIAL		= -111			-- �����ø��� �ߺ�.
	declare @RESULT_ERROR_MAXCOUNT				int				set @RESULT_ERROR_MAXCOUNT				= -112			-- �ƽ�ī����.
	declare @RESULT_ERROR_ITEMCOST_WRONG		int				set @RESULT_ERROR_ITEMCOST_WRONG		= -113			-- ������ ������ �̻���.
	declare @RESULT_ERROR_LISTIDX_NOT_FOUND		int				set @RESULT_ERROR_LISTIDX_NOT_FOUND		= -114			-- ����Ʈ ��ȣ�� ��ã��.
	declare @RESULT_ERROR_NOT_ENOUGH			int				set @RESULT_ERROR_NOT_ENOUGH			= -115			-- �����ΰ� ������� ����.

	------------------------------------------------
	--	2-2. ���ǵȰ�
	------------------------------------------------
	-- ������ �Һз�(��������)
	declare @ITEM_SUBCATEGORY_BULLET			int					set @ITEM_SUBCATEGORY_BULLET 				= 8  -- �Ѿ�	(�Ǹ�[O], ����[O], ����[O])
	declare @ITEM_SUBCATEGORY_VACCINE			int					set @ITEM_SUBCATEGORY_VACCINE 				= 9  -- ġ����	(�Ǹ�[O], ����[O], ����[O])
	declare @ITEM_SUBCATEGORY_ALBA				int					set @ITEM_SUBCATEGORY_ALBA 					= 11 -- �ϲ�	(�Ǹ�[O], ����[O], ����[O])
	declare @ITEM_SUBCATEGORY_BOOSTER			int					set @ITEM_SUBCATEGORY_BOOSTER 				= 12 -- ������	(�Ǹ�[O], ����[O], ����[O])

	-- ��������.
	-- �ʵ嵿�� 0 ~ 8.
	declare @USERITEM_FIELDIDX_INVEN			int					set @USERITEM_FIELDIDX_INVEN					= -1	-- â��.
	declare @USERITEM_FIELDIDX_HOSPITAL			int					set @USERITEM_FIELDIDX_HOSPITAL					= -2	-- ����.

	-- �Ҹ��� > �����Կ� ������ġ.
	declare @USERMASTER_QUICKKIND_NON			int					set @USERMASTER_QUICKKIND_NON				= -1 --����.
	declare @USERMASTER_QUICKKIND_SETTING		int					set @USERMASTER_QUICKKIND_SETTING			=  1 --�Ѿ�, ���, ����, �˹�.

	-- ������ �Ϲ�����.
	declare @CONSUME_MAX_COUNT					int					set @CONSUME_MAX_COUNT						= 999

	------------------------------------------------
	--	2-3. ���λ�� ����
	------------------------------------------------
	declare @comment		varchar(80)
	declare @gameid			varchar(60)		set @gameid				= ''
	declare @bulletlistidx	int				set @bulletlistidx		= -1
	declare @vaccinelistidx	int				set @vaccinelistidx		= -1
	declare @boosterlistidx	int				set @boosterlistidx		= -1
	declare @albalistidx	int				set @albalistidx		= -1

	declare @itemcode 		int				set @itemcode 		= -444
	declare @cnt 			int				set @cnt			= 0
	declare @subcategory 	int				set @subcategory 	= -444

	declare @dummy	 		int
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	set @comment  = '�˼� ���� ������ �߻��߽��ϴ�.'
	--select 'DEBUG 3-1-1 �Է°�', @gameid_ gameid_, @password_ password_, @listidx_ listidx_, @quickkind_ quickkind_

	------------------------------------------------
	--	3-2. �������(��������, ��������, ������ ����)
	------------------------------------------------
	select
		@gameid 		= gameid,
		@bulletlistidx 	= bulletlistidx,
		@vaccinelistidx = vaccinelistidx,
		@boosterlistidx = boosterlistidx,
		@albalistidx 	= albalistidx
	from dbo.tFVUserMaster where gameid = @gameid_ and password = @password_
	--select 'DEBUG 3-2-1 ��������', @gameid gameid, @bulletlistidx bulletlistidx, @vaccinelistidx vaccinelistidx, @boosterlistidx boosterlistidx, @albalistidx albalistidx

	select
		@itemcode	= itemcode,
		@cnt		= cnt
	from dbo.tFVUserItem where gameid = @gameid_ and listidx = @listidx_
	--select 'DEBUG 3-2-2 ������', @listidx_ listidx_, @itemcode itemcode, @cnt cnt

	if(@itemcode != -1)
		begin
			select @subcategory = subcategory from dbo.tFVItemInfo where itemcode = @itemcode
		end

	------------------------------------------------
	--	3-3. ����Ȳ���� �ڵ�� �з�
	------------------------------------------------
	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR ���̵� �������� �ʴ´�.'
			--select 'DEBUG ' + @comment
		END
	else if (@itemcode = -444)
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_ITEMCODE
			set @comment = 'ERROR �������� ã�� �� �����ϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if (@cnt <= 0)
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_ENOUGH
			set @comment = 'ERROR ������ �����ϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if (@subcategory not in (@ITEM_SUBCATEGORY_BULLET, @ITEM_SUBCATEGORY_VACCINE, @ITEM_SUBCATEGORY_ALBA, @ITEM_SUBCATEGORY_BOOSTER))
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment = 'ERROR �Ѿ�, ���, �ν���, �˹� �̿ܿ��� �ȵ˴ϴ�.'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS ������ �����մϴ�.'

			if(@subcategory = @ITEM_SUBCATEGORY_BULLET)
				begin
					--select 'DEBUG �Ѿ˼���', @listidx_ listidx_
					set @bulletlistidx = case when(@quickkind_ = @USERMASTER_QUICKKIND_SETTING) then @listidx_ else -1 end
				end
			else if(@subcategory = @ITEM_SUBCATEGORY_VACCINE)
				begin
					--select 'DEBUG ��ż���', @listidx_ listidx_
					set @vaccinelistidx = case when(@quickkind_ = @USERMASTER_QUICKKIND_SETTING) then @listidx_ else -1 end
				end
			else if(@subcategory = @ITEM_SUBCATEGORY_BOOSTER)
				begin
					--select 'DEBUG ��������', @listidx_ listidx_
					set @boosterlistidx = case when(@quickkind_ = @USERMASTER_QUICKKIND_SETTING) then @listidx_ else -1 end
				end
			else if(@subcategory = @ITEM_SUBCATEGORY_ALBA)
				begin
					----select 'DEBUG �˹ټ���', @listidx_ listidx_
					set @albalistidx = case when(@quickkind_ = @USERMASTER_QUICKKIND_SETTING) then @listidx_ else -1 end
				end
		END

	if(@nResult_ = @RESULT_SUCCESS)
		begin
			-- ���ð��� ���� �־��ش�.
			update dbo.tFVUserMaster
			set
				bulletlistidx 	= @bulletlistidx,
				vaccinelistidx 	= @vaccinelistidx,
				boosterlistidx 	= @boosterlistidx,
				albalistidx 	= @albalistidx
			where gameid = @gameid_

			--------------------------------------------------------------
			-- �ڵ�(ĳ��, ����, ��Ʈ, ����)
			--------------------------------------------------------------
			select @nResult_ rtn, @comment comment, @bulletlistidx bulletlistidx, @vaccinelistidx vaccinelistidx, @boosterlistidx boosterlistidx, @albalistidx albalistidx
		end
	else
		begin
			select @nResult_ rtn, @comment comment, @bulletlistidx bulletlistidx, @vaccinelistidx vaccinelistidx, @boosterlistidx boosterlistidx, @albalistidx albalistidx
		end

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off
End

