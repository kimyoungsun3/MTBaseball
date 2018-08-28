/*
exec spu_ItemInvenExp 'xxxx2', '049000s1i0n7t8445280', 0, -1		-- ��������.
exec spu_ItemInvenExp 'xxxx2', '049000s1i0n7t8445289', 0, -1		-- �κ�����Ʋ��.

exec spu_ItemInvenExp 'xxxx2', '049000s1i0n7t8445289', 1, -1		-- ���� �κ�Ȯ��.
exec spu_ItemInvenExp 'xxxx2', '049000s1i0n7t8445289', 3, -1		-- �Һ��� �κ�Ȯ��.
exec spu_ItemInvenExp 'xxxx2', '049000s1i0n7t8445289', 4, -1		-- �Ǽ��縮 �κ�Ȯ��.
exec spu_ItemInvenExp 'xxxx2', '049000s1i0n7t8445289', 1040, -1		-- �ٱ⼼�� �κ�Ȯ��.
exec spu_ItemInvenExp 'xxxx2', '049000s1i0n7t8445289', 1200, -1		-- ���� �κ�Ȯ��.
*/
use Game4Farmvill5
GO

IF OBJECT_ID ( 'dbo.spu_ItemInvenExp', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_ItemInvenExp;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_ItemInvenExp
	@gameid_								varchar(20),
	@password_								varchar(20),
	@invenkind_								int,
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
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--�ش������� ã�� ����.
	declare @RESULT_ERROR_GAMECOST_LACK			int				set @RESULT_ERROR_GAMECOST_LACK			= -21			--�ǹ��� �����ϴ�.
	declare @RESULT_ERROR_CASHCOST_LACK			int				set @RESULT_ERROR_CASHCOST_LACK			= -22			--��尡 �����ϴ�.
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- �������ڵ��ã��

	-- ��Ÿ����
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- ���������ʴ¸��
	declare @RESULT_ERROR_INVEN_FULL			int				set @RESULT_ERROR_INVEN_FULL			= -101			-- �κ�����
	------------------------------------------------
	--	2-2. ���°�
	------------------------------------------------
	-- �����ۺ� �κ��з�
	declare @USERITEM_INVENKIND_ANI				int 				set @USERITEM_INVENKIND_ANI					= 1
	declare @USERITEM_INVENKIND_CONSUME			int 				set @USERITEM_INVENKIND_CONSUME				= 3
	declare @USERITEM_INVENKIND_ACC				int 				set @USERITEM_INVENKIND_ACC					= 4
	declare @USERITEM_INVENKIND_DIRECT			int 				set @USERITEM_INVENKIND_DIRECT				= 40
	declare @USERITEM_INVENKIND_INFO			int 				set @USERITEM_INVENKIND_INFO				= 60
	declare @USERITEM_INVENKIND_PET				int 				set @USERITEM_INVENKIND_PET					= 1000
	declare @USERITEM_INVENKIND_STEMCELL		int 				set @USERITEM_INVENKIND_STEMCELL			= 1040
	declare @USERITEM_INVENKIND_TREASURE		int 				set @USERITEM_INVENKIND_TREASURE			= 1200

	-- ������ �Һз�
	declare @ITEM_SUBCATEGORY_INVEN				int					set @ITEM_SUBCATEGORY_INVEN 				= 67 -- �κ�Ȯ��
	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @comment			varchar(80)

	declare @gameid 			varchar(20)		set @gameid 		= ''
	declare @market				int,
			@cashcost			int,
			@gamecost			int,
			@invenanimalmax		int,
			@invenanimalstep	int,
			@invencustommax		int,
			@invencustomstep	int,
			@invenaccmax		int,
			@invenaccstep		int,
			@invenstemcellmax	int,
			@invenstemcellstep	int,
			@inventreasuremax	int,
			@inventreasurestep	int

	declare @itemcodesell		int				set @itemcodesell		= -1
	declare @gamecostsell		int				set @gamecostsell 		= 99999
	declare @cashcostsell		int				set @cashcostsell 		= 99999
	declare @invenstepnext		int				set @invenstepnext		= 99999
	declare @invenstepmax		int				set @invenstepmax		= 0

Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG �Է°�', @gameid_ gameid_, @password_ password_, @invenkind_ invenkind_

	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	-- ��������.
	select
		@gameid 		= gameid,
		@market			= market,
		@cashcost		= cashcost,
		@gamecost		= gamecost,
		@invenanimalmax	= invenanimalmax,
		@invenanimalstep= invenanimalstep,
		@invencustommax	= invencustommax,
		@invencustomstep= invencustomstep,
		@invenaccmax	= invenaccmax,
		@invenaccstep	= invenaccstep,
		@invenstemcellmax= invenstemcellmax,
		@invenstemcellstep= invenstemcellstep,
		@inventreasuremax= inventreasuremax,
		@inventreasurestep= inventreasurestep
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 1-1 ��������', @gameid gameid, @market market, @cashcost cashcost, @gamecost gamecost, @invenanimalmax invenanimalmax, @invenanimalstep invenanimalstep, @invencustommax invencustommax, @invencustomstep invencustomstep, @invenaccmax invenaccmax, @invenaccstep invenaccstep

	---------------------------------------------
	-- tItemInfo(�κ�����) > ����������(����) > tSystemInfo
	---------------------------------------------
	select top 1 @invenstepmax = invenstepmax from dbo.tSystemInfo order by idx desc
	--select 'DEBUG �κ����ƽ����� ', @invenstepmax invenstepmax


	-- �κ������ܰ�
	if(@invenkind_ = @USERITEM_INVENKIND_ANI)
		begin
			--select 'DEBUG 1-2 ���� �κ�Ȯ������', @invenanimalmax invenanimalmax, @invenanimalstep invenanimalstep
			set @invenstepnext 	= @invenanimalstep + 1
		end
	else if(@invenkind_ = @USERITEM_INVENKIND_CONSUME)
		begin
			--select 'DEBUG 1-3 �Ҹ� �κ�Ȯ������', @invencustommax invencustommax, @invencustomstep invencustomstep
			set @invenstepnext 	= @invencustomstep + 1
		end
	else if(@invenkind_ = @USERITEM_INVENKIND_ACC)
		begin
			--select 'DEBUG 1-4 �Ǽ� �κ�Ȯ������', @invenaccmax invenaccmax, @invenaccstep invenaccstep
			set @invenstepnext 	= @invenaccstep + 1
		end
	else if(@invenkind_ = @USERITEM_INVENKIND_STEMCELL)
		begin
			--select 'DEBUG 1-4 ���� �κ�Ȯ������', @invenstemcellmax invenstemcellmax, @invenstemcellstep invenstemcellstep
			set @invenstepnext 	= @invenstemcellstep + 1
		end
	else if(@invenkind_ = @USERITEM_INVENKIND_TREASURE)
		begin
			--select 'DEBUG 1-4 ���� �κ�Ȯ������', @inventreasuremax inventreasuremax, @inventreasurestep inventreasurestep
			set @invenstepnext 	= @inventreasurestep + 1
		end

	select
		@itemcodesell		= itemcode,
		@cashcostsell		= cashcost,
		@gamecostsell 		= gamecost
	from dbo.tItemInfo
	where subcategory = @ITEM_SUBCATEGORY_INVEN and param1 = @invenstepnext
	--select 'DEBUG > �����ܰ�', @invenstepnext invenstepnext, @invenstepmax invenstepmax, @itemcodesell itemcodesell, @cashcostsell cashcostsell, @gamecostsell gamecostsell


	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '���̵� �������� �ʴ´�.'
			--select 'DEBUG ' + @comment
		END
	else if(@invenkind_ not in (@USERITEM_INVENKIND_ANI, @USERITEM_INVENKIND_CONSUME, @USERITEM_INVENKIND_ACC, @USERITEM_INVENKIND_STEMCELL, @USERITEM_INVENKIND_TREASURE))
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment 	= '�������� �ʴ� ����Դϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if(@invenstepnext > @invenstepmax)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_INVEN_FULL
			set @comment 	= '�κ��� Ǯ�� Ȯ��Ǿ����ϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if(@itemcodesell = -1 or (@cashcostsell <= 0 and @gamecostsell <= 0))
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_ITEMCODE
			set @comment 	= '�κ��� �ش� ������ �ڵ带 ã�� �� �����ϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if(@cashcostsell > 0 and @cashcostsell > @cashcost)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_CASHCOST_LACK
			set @comment 	= 'ĳ������� �����մϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if(@gamecostsell > 0 and @gamecostsell > @gamecost)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_GAMECOST_LACK
			set @comment 	= '���κ���� �����մϴ�.'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS �κ��� Ȯ���߽��ϴ�.'
			--select 'DEBUG ' + @comment

			-- �������.
			set @cashcost	= @cashcost - @cashcostsell
			set @gamecost	= @gamecost - @gamecostsell

			-- �κ������ܰ�
			if(@invenkind_ = @USERITEM_INVENKIND_ANI)
				begin
					set @invenanimalmax		= @invenanimalmax + 10
					set @invenanimalstep 	= @invenanimalstep + 1
				end
			else if(@invenkind_ = @USERITEM_INVENKIND_CONSUME)
				begin
					set @invencustommax		= @invencustommax + 10
					set @invencustomstep 	= @invencustomstep + 1
				end
			else if(@invenkind_ = @USERITEM_INVENKIND_ACC)
				begin
					set @invenaccmax 		= @invenaccmax + 10
					set @invenaccstep 		= @invenaccstep + 1
				end
			else if(@invenkind_ = @USERITEM_INVENKIND_STEMCELL)
				begin
					set @invenstemcellmax 	= @invenstemcellmax + 10
					set @invenstemcellstep 	= @invenstemcellstep + 1
				end
			else if(@invenkind_ = @USERITEM_INVENKIND_TREASURE)
				begin
					set @inventreasuremax 	= @inventreasuremax + 10
					set @inventreasurestep 	= @inventreasurestep + 1
				end

			-----------------------------------
			-- ���ű�ϸ�ŷ
			-----------------------------------
			exec spu_UserItemBuyLogNew @gameid_, @itemcodesell, @gamecostsell, @cashcostsell, 0
		END

	--------------------------------------------------------------
	-- �ڵ�(ĳ��, ����, �κ�����)
	--------------------------------------------------------------
	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost,
			@invenanimalmax invenanimalmax, @invenanimalstep invenanimalstep,
			@invencustommax invencustommax, @invencustomstep invencustomstep,
			@invenaccmax invenaccmax, @invenaccstep invenaccstep,
			@invenstemcellmax invenstemcellmax, @invenstemcellstep invenstemcellstep,
			@inventreasuremax inventreasuremax, @inventreasurestep inventreasurestep

	if(@nResult_ = @RESULT_SUCCESS)
		begin
			-----------------------------------
			-- ���� ���� �ݿ�.
			-----------------------------------
			update dbo.tUserMaster
			set
				cashcost		= @cashcost,
				gamecost		= @gamecost,
				invenanimalmax	= @invenanimalmax,
				invenanimalstep	= @invenanimalstep,
				invencustommax	= @invencustommax,
				invencustomstep	= @invencustomstep,
				invenaccmax		= @invenaccmax,
				invenaccstep	= @invenaccstep,
				invenstemcellmax= @invenstemcellmax,
				invenstemcellstep= @invenstemcellstep,
				inventreasuremax= @inventreasuremax,
				inventreasurestep= @inventreasurestep
			where gameid = @gameid_
		end


	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off
End



