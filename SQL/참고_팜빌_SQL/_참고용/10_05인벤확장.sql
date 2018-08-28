/*
exec spu_FVItemInvenExp 'xxxx2', '049000s1i0n7t8445280', 0, -1		-- ��������.
exec spu_FVItemInvenExp 'xxxx2', '049000s1i0n7t8445289', 0, -1		-- �κ�����Ʋ��.

exec spu_FVItemInvenExp 'xxxx2', '049000s1i0n7t8445289', 1, -1		-- ���� �κ�Ȯ��.
exec spu_FVItemInvenExp 'xxxx2', '049000s1i0n7t8445289', 3, -1		-- �Һ��� �κ�Ȯ��.
exec spu_FVItemInvenExp 'xxxx2', '049000s1i0n7t8445289', 4, -1		-- �Ǽ��縮 �κ�Ȯ��.
*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVItemInvenExp', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVItemInvenExp;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_FVItemInvenExp
	@gameid_								varchar(60),
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
	declare @RESULT_ERROR_DAILY_REWARD_ALREADY	int				set @RESULT_ERROR_DAILY_REWARD_ALREADY	= -102			-- ���Ϻ��� �̹� ����.
	declare @RESULT_ERROR_NOT_FOUND_DOGAMIDX	int				set @RESULT_ERROR_NOT_FOUND_DOGAMIDX	= -103			-- ������ȣ�� ã���� ����.
	declare @RESULT_ERROR_DOGAM_ALREADY_REWARD	int				set @RESULT_ERROR_DOGAM_ALREADY_REWARD	= -104			-- ������ �̹� ��������.
	declare @RESULT_ERROR_DOGAM_LACK			int				set @RESULT_ERROR_DOGAM_LACK			= -105			-- �����߿� ������ȣ�� ������.
	declare @RESULT_ERROR_ANIMAL_NOT_FOUND		int				set @RESULT_ERROR_ANIMAL_NOT_FOUND		= -106			-- ��ǥ���� ��ã��
	declare @RESULT_ERROR_ANIMAL_NOT_INVEN		int				set @RESULT_ERROR_ANIMAL_NOT_INVEN		= -107			-- �κ��� ����(â��)
	declare @RESULT_ERROR_ANIMAL_NOT_ALIVE		int				set @RESULT_ERROR_ANIMAL_NOT_ALIVE		= -108			-- ��� ���� ����
	declare @RESULT_ERROR_ANIMAL_IS_ALIVE		int				set @RESULT_ERROR_ANIMAL_IS_ALIVE		= -116			-- ������ ����ִ�.
	declare @RESULT_ERROR_ANIMAL_FIELDIDX		int				set @RESULT_ERROR_ANIMAL_FIELDIDX		= -117			-- �ʵ��ε�������.
	declare @RESULT_ERROR_NOT_MATCH				int				set @RESULT_ERROR_NOT_MATCH				= -110			-- �����ΰ� ��ġ�� �ȵǾ���.
	declare @RESULT_ERROR_DOUBLE_RANDSERIAL		int				set @RESULT_ERROR_DOUBLE_RANDSERIAL		= -111			-- �����ø��� �ߺ�.
	declare @RESULT_ERROR_MAXCOUNT				int				set @RESULT_ERROR_MAXCOUNT				= -112			-- �ƽ�ī����.
	declare @RESULT_ERROR_ITEMCOST_WRONG		int				set @RESULT_ERROR_ITEMCOST_WRONG		= -113			-- ������ ������ �̻���.
	declare @RESULT_ERROR_LISTIDX_NOT_FOUND		int				set @RESULT_ERROR_LISTIDX_NOT_FOUND		= -114			-- ����Ʈ ��ȣ�� ��ã��.
	declare @RESULT_ERROR_NOT_ENOUGH			int				set @RESULT_ERROR_NOT_ENOUGH			= -115			-- �����ΰ� ������� ����.
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

	-- ������ �Һз�
	declare @ITEM_SUBCATEGORY_COW				int					set @ITEM_SUBCATEGORY_COW 					= 1  -- ��		(�Ǹ�[O], ����[O])
	declare @ITEM_SUBCATEGORY_GOAT				int					set @ITEM_SUBCATEGORY_GOAT 					= 2  -- ��		(�Ǹ�[O], ����[O])
	declare @ITEM_SUBCATEGORY_SHEEP				int					set @ITEM_SUBCATEGORY_SHEEP 				= 3  -- ���	(�Ǹ�[O], ����[O])
	declare @ITEM_SUBCATEGORY_SEED				int					set @ITEM_SUBCATEGORY_SEED 					= 7  -- ����	(�Ǹ�[X], ����[X], ����[O])
	declare @ITEM_SUBCATEGORY_BULLET			int					set @ITEM_SUBCATEGORY_BULLET 				= 8  -- �Ѿ�	(�Ǹ�[O], ����[O], ����[O])
	declare @ITEM_SUBCATEGORY_VACCINE			int					set @ITEM_SUBCATEGORY_VACCINE 				= 9  -- ġ����	(�Ǹ�[O], ����[O], ����[O])
	declare @ITEM_SUBCATEGORY_FEED				int					set @ITEM_SUBCATEGORY_FEED 					= 44 -- ����	(�Ǹ�[X], ����[O])
	declare @ITEM_SUBCATEGORY_ALBA				int					set @ITEM_SUBCATEGORY_ALBA 					= 11 -- �ϲ�	(�Ǹ�[O], ����[O], ����[O])
	declare @ITEM_SUBCATEGORY_BOOSTER			int					set @ITEM_SUBCATEGORY_BOOSTER 				= 12 -- ������	(�Ǹ�[O], ����[O], ����[O])
	declare @ITEM_SUBCATEGORY_REVIVAL			int					set @ITEM_SUBCATEGORY_REVIVAL 				= 13 -- ��Ȱ��	(�Ǹ�[O], ����[O])
	declare @ITEM_SUBCATEGORY_ACC				int					set @ITEM_SUBCATEGORY_ACC 					= 15 -- �Ǽ�	(�Ǹ�[O], ����[O])
	declare @ITEM_SUBCATEGORY_HEART				int					set @ITEM_SUBCATEGORY_HEART 				= 40 -- ��Ʈ	(�Ǹ�[O], ����[O])
	declare @ITEM_SUBCATEGORY_HELPER			int					set @ITEM_SUBCATEGORY_HELPER 				= 41 -- ��޿�û(�Ǹ�[X], ����[O])
	declare @ITEM_SUBCATEGORY_TRADESAFE			int					set @ITEM_SUBCATEGORY_TRADESAFE				= 42 -- ���θ���(�Ǹ�[X], ����[O])
	declare @ITEM_SUBCATEGORY_CASHCOST			int					set @ITEM_SUBCATEGORY_CASHCOST 				= 50 -- ĳ��	(�Ǹ�[O], ����[O])
	declare @ITEM_SUBCATEGORY_GAMECOST			int					set @ITEM_SUBCATEGORY_GAMECOST 				= 51 -- ����	(�Ǹ�[O], ����[O])
	declare @ITEM_SUBCATEGORY_CONTEST			int					set @ITEM_SUBCATEGORY_CONTEST 				= 53 -- ��ȸ	(�Ǹ�[O], ����[O])
	declare @ITEM_SUBCATEGORY_UPGRADE_HOUSE		int					set @ITEM_SUBCATEGORY_UPGRADE_HOUSE 		= 60 -- ��
	declare @ITEM_SUBCATEGORY_UPGRADE_TANK		int					set @ITEM_SUBCATEGORY_UPGRADE_TANK 			= 61 -- ��ũ
	declare @ITEM_SUBCATEGORY_UPGRADE_FRESHCOOL	int					set @ITEM_SUBCATEGORY_UPGRADE_FRESHCOOL 	= 62 -- ���º���
	declare @ITEM_SUBCATEGORY_UPGRADE_PURE		int					set @ITEM_SUBCATEGORY_UPGRADE_PURE 			= 63 -- ��ȭ�ü�
	declare @ITEM_SUBCATEGORY_UPGRADE_BOTTLE	int					set @ITEM_SUBCATEGORY_UPGRADE_BOTTLE 		= 64 -- �絿��
	declare @ITEM_SUBCATEGORY_UPGRADE_PUMP		int					set @ITEM_SUBCATEGORY_UPGRADE_PUMP 			= 65 -- ������
	declare @ITEM_SUBCATEGORY_UPGRADE_TRANSFER	int					set @ITEM_SUBCATEGORY_UPGRADE_TRANSFER 		= 66 -- ���Ա�
	declare @ITEM_SUBCATEGORY_INVEN				int					set @ITEM_SUBCATEGORY_INVEN 				= 67 -- �κ�Ȯ��
	declare @ITEM_SUBCATEGORY_SEEDFIELD			int					set @ITEM_SUBCATEGORY_SEEDFIELD 			= 68 -- ������Ȯ��
	declare @ITEM_SUBCATEGORY_DOGAM				int					set @ITEM_SUBCATEGORY_DOGAM 				= 818 -- ����
	declare @ITEM_SUBCATEGORY_SYSINFO			int					set @ITEM_SUBCATEGORY_SYSINFO 				= 500 -- ��������
	declare @ITEM_SUBCATEGORY_ATTENDANCE		int					set @ITEM_SUBCATEGORY_ATTENDANCE 			= 900 	--�⼮(900)
	declare @ITEM_SUBCATEGORY_COMPETITION		int					set @ITEM_SUBCATEGORY_COMPETITION 			= 901 	--������(901)
	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @comment			varchar(80)

	declare @gameid 			varchar(60)		set @gameid 		= ''
	declare @market				int,
			@cashcost			int,
			@gamecost			int,
			@invenanimalmax		int,		-- 10
			@invenanimalstep	int,		-- 0
			@invencustommax		int,		-- 6
			@invencustomstep	int,		-- 0
			@invenaccmax		int,		-- 4
			@invenaccstep		int			-- 0

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
		@invenaccstep	= invenaccstep
	from dbo.tFVUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 1-1 ��������', @gameid gameid, @market market, @cashcost cashcost, @gamecost gamecost, @invenanimalmax invenanimalmax, @invenanimalstep invenanimalstep, @invencustommax invencustommax, @invencustomstep invencustomstep, @invenaccmax invenaccmax, @invenaccstep invenaccstep

	---------------------------------------------
	-- tItemInfo(�κ�����) > ����������(����) > tSystemInfo
	---------------------------------------------
	select top 1 @invenstepmax = invenstepmax from dbo.tFVSystemInfo order by idx desc
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

	select
		@itemcodesell		= itemcode,
		@cashcostsell		= cashcost,
		@gamecostsell 		= gamecost
	from dbo.tFVItemInfo
	where subcategory = @ITEM_SUBCATEGORY_INVEN and param1 = @invenstepnext
	--select 'DEBUG > �����ܰ�', @invenstepnext invenstepnext, @invenstepmax invenstepmax, @itemcodesell itemcodesell, @cashcostsell cashcostsell, @gamecostsell gamecostsell


	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '���̵� �������� �ʴ´�.'
			--select 'DEBUG ' + @comment
		END
	else if(@invenkind_ not in (@USERITEM_INVENKIND_ANI, @USERITEM_INVENKIND_CONSUME, @USERITEM_INVENKIND_ACC))
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
					set @invenanimalmax		= @invenanimalmax + 5
					set @invenanimalstep 	= @invenanimalstep + 1
				end
			else if(@invenkind_ = @USERITEM_INVENKIND_CONSUME)
				begin
					set @invencustommax		= @invencustommax + 5
					set @invencustomstep 	= @invencustomstep + 1
				end
			else if(@invenkind_ = @USERITEM_INVENKIND_ACC)
				begin
					set @invenaccmax 		= @invenaccmax + 5
					set @invenaccstep 		= @invenaccstep + 1
				end

			-----------------------------------
			-- ���ű�ϸ�ŷ
			-----------------------------------
			exec spu_FVUserItemBuyLog @gameid_, @itemcodesell, @gamecostsell, @cashcostsell
		END


	if(@nResult_ = @RESULT_SUCCESS)
		begin
			-----------------------------------
			-- ���� ���� �ݿ�.
			-----------------------------------
			update dbo.tFVUserMaster
			set
				cashcost		= @cashcost,
				gamecost		= @gamecost,
				invenanimalmax	= @invenanimalmax,
				invenanimalstep	= @invenanimalstep,
				invencustommax	= @invencustommax,
				invencustomstep	= @invencustomstep,
				invenaccmax		= @invenaccmax,
				invenaccstep	= @invenaccstep
			where gameid = @gameid_

			--------------------------------------------------------------
			-- �ڵ�(ĳ��, ����, �κ�����)
			--------------------------------------------------------------
			select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost, @invenanimalmax invenanimalmax, @invenanimalstep invenanimalstep, @invencustommax invencustommax, @invencustomstep invencustomstep, @invenaccmax invenaccmax, @invenaccstep invenaccstep
		end
	else
		begin
			select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost, @invenanimalmax invenanimalmax, @invenanimalstep invenanimalstep, @invencustommax invencustommax, @invencustomstep invencustomstep, @invenaccmax invenaccmax, @invenaccstep invenaccstep
		end


	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off
End



