/*
exec spu_FVSeedPlant 'xxxx2', '049000s1i0n7t8445280',  0, 600, 0, -1	-- ��������.
exec spu_FVSeedPlant 'xxxx2', '049000s1i0n7t8445289', 11, 600, 0, -1	-- �̱���.
exec spu_FVSeedPlant 'xxxx2', '049000s1i0n7t8445289', -1, 600, 0, -1	-- �߸��� ��������ȣ.
exec spu_FVSeedPlant 'xxxx2', '049000s1i0n7t8445289',  1, 444, 0, -1	-- �߸��� ��������.

exec spu_FVSeedPlant 'farm1078959', '2506581j3z1t4e126143',  0, 600, 1, -1	-- ���� > ����.
exec spu_FVSeedPlant 'xxxx2', '049000s1i0n7t8445289',  1, 600, 1, -1	-- ���� > ����.
exec spu_FVSeedPlant 'xxxx2', '049000s1i0n7t8445289',  2, 601, 1, -1	-- ���� > ����.
exec spu_FVSeedPlant 'xxxx2', '049000s1i0n7t8445289',  3, 602, 0, -1	-- ���� > ����.
exec spu_FVSeedPlant 'xxxx2', '049000s1i0n7t8445289',  4, 603, 0, -1	-- ���� > ����.
exec spu_FVSeedPlant 'xxxx2', '049000s1i0n7t8445289',  5, 604, 0, -1	-- ���� > ����.
exec spu_FVSeedPlant 'xxxx2', '049000s1i0n7t8445289',  6, 607, 0, -1	-- ��Ʈ > ����.
exec spu_FVSeedPlant 'xxxx2', '049000s1i0n7t8445289',  7, 605, 0, -1	-- ȸ�� > �Ҹ�(������).
exec spu_FVSeedPlant 'xxxx2', '049000s1i0n7t8445289',  8, 606, 0, -1	-- ���� > �Ҹ�(������).
*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVSeedPlant', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVSeedPlant;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_FVSeedPlant
	@gameid_								varchar(60),
	@password_								varchar(20),
	@seedidx_								int,
	@seeditemcode_							int,
	@feeduse_								int,
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

	-- ������ ����, ����.
	declare @RESULT_ERROR_BUY_ALREADY			int				set @RESULT_ERROR_BUY_ALREADY			= -31			--�̹� �����߽��ϴ�.
	declare @RESULT_ERROR_NOT_HAVE				int				set @RESULT_ERROR_NOT_HAVE				= -32			--�������� �ʰ� �ִ�.
	declare @RESULT_ERROR_UPGRADE_FULL			int				set @RESULT_ERROR_UPGRADE_FULL			= -35			--���׷��̵尡 Ǯ�εǾ���.
	declare @RESULT_ERROR_ITEM_NOSALE_KIND		int				set @RESULT_ERROR_ITEM_NOSALE_KIND		= -37			--�Ǹ����� �ʴ� ������

	-- ���� �ڵ尪
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- �������ڵ��ã��
	declare @RESULT_ERROR_GIFTITEM_NOT_FOUND	int				set @RESULT_ERROR_GIFTITEM_NOT_FOUND	= -51			-- ������������ ��ã��
	declare @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	int				set @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	= -52			-- ������ �̹� ������
	declare @RESULT_ERROR_NOT_FOUND_GIFTID		int				set @RESULT_ERROR_NOT_FOUND_GIFTID		= -75			-- ĳ�� > ������ ���̵� ��ã��

	-- ��Ÿ����
	declare @RESULT_ERROR_NOT_FOUND_SEEDIDX		int				set @RESULT_ERROR_NOT_FOUND_SEEDIDX		= -118			-- �Ķ���� ����.
	declare @RESULT_ERROR_PLANT_ALREADY			int				set @RESULT_ERROR_PLANT_ALREADY			= -119			-- �̹� ������ �ɾ�������.
	declare @RESULT_ERROR_NEED_BUY				int				set @RESULT_ERROR_NEED_BUY				= -120			-- �������� �̱��Ż���.

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


	-- ������(����).
	declare @USERSEED_NEED_EMPTY				int					set @USERSEED_NEED_EMPTY					= -1	-- (������)
	declare @USERSEED_NEED_BUY					int					set @USERSEED_NEED_BUY						= -2
	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @comment			varchar(80)

	declare @gameid 			varchar(60)		set @gameid 		= ''
	declare @market				int				set @market			= 1
	declare @cashcost			int				set @cashcost		= 0
	declare @gamecost			int				set @gamecost		= 0
	declare @feed				int				set @feed			= 0
	declare @heart				int				set @heart			= 0
	declare @qtfeeduse			int				set @qtfeeduse		= 0


	declare @seeditemcode		int				set @seeditemcode		= @USERSEED_NEED_BUY

	declare @seeditemcodenew	int				set @seeditemcodenew	= -444
	declare @gamecostsell		int				set @gamecostsell 		= 99999
	declare @cashcostsell		int				set @cashcostsell 		= 99999
	declare @harvestcnt			int				set @harvestcnt			= 0
	declare @harvesttime		int				set @harvesttime		= 99999
	declare @harvestcashcost	int				set @harvestcashcost	= 99999
	declare @harvestitemcode	int				set @harvestitemcode	= -444

Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	set @comment = 'ERROR �˼����� ����(-1)'
	--select 'DEBUG 1-0 �Է°�', @gameid_ gameid_, @password_ password_, @seedidx_ seedidx_, @seeditemcode_ seeditemcode_

	------------------------------------------------
	--	3-2. ��������.
	------------------------------------------------
	-- ��������.
	select
		@gameid 		= gameid,
		@market			= market,
		@cashcost		= cashcost,
		@gamecost		= gamecost,
		@feed			= feed,
		@heart			= heart,
		@qtfeeduse		= qtfeeduse
	from dbo.tFVUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 1-1 ��������', @gameid gameid, @market market, @cashcost cashcost, @gamecost gamecost

	select
		@seeditemcode	= itemcode
	from dbo.tFVUSerSeed where gameid = @gameid_ and seedidx = @seedidx_
	--select 'DEBUG 1-2 ����������', @gameid_ gameid_, @seedidx_ seedidx_, @seeditemcode seeditemcode

	---------------------------------------------
	-- ������ ����.
	---------------------------------------------
	select
		@seeditemcodenew	= itemcode,
		@cashcostsell		= cashcost,
		@gamecostsell 		= gamecost,
		@harvestcnt			= param1,
		@harvesttime		= param2,
		@harvestcashcost	= param5,
		@harvestitemcode	= param6
	from dbo.tFVItemInfo
	where subcategory = @ITEM_SUBCATEGORY_SEED and itemcode = @seeditemcode_
	--select 'DEBUG 1-3 ��������', @seeditemcode_ seeditemcode_, @seeditemcodenew seeditemcodenew, @cashcostsell cashcostsell, @gamecostsell gamecostsell, @harvestcnt harvestcnt, @harvesttime harvesttime, @harvestcashcost harvestcashcost, @harvestitemcode harvestitemcode

	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '���̵� �������� �ʴ´�.'
			--select 'DEBUG ' + @comment
		END
	else if(@seeditemcode = @USERSEED_NEED_BUY)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NEED_BUY
			set @comment 	= '�������� �������� ����.'
			--select 'DEBUG ' + @comment
		END
	else if(@seeditemcode >= 600 and @seeditemcode <=699)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '�̹� ������ �ֽ��ϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if(@seeditemcodenew = -444)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_ITEMCODE
			set @comment 	= '���� ������ ��ã�ҽ��ϴ�.'
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
			set @comment = 'SUCCESS �������� ������ �ɴ´�.'
			--select 'DEBUG ' + @comment

			-- ������ �ɱ�.
			update dbo.tFVUSerSeed
				set
					itemcode 		= @seeditemcode_,
					seedstartdate	= getdate(),
					seedenddate		= DATEADD(ss, @harvesttime, getdate())
			where gameid = @gameid_ and seedidx = @seedidx_

			-- �������.
			set @cashcost	= @cashcost - @cashcostsell
			set @gamecost	= @gamecost - @gamecostsell

			-- �����ʰ��.
			set @feeduse_ = case
								when @feeduse_ < 0 then (-@feeduse_)
								else @feeduse_
							end

			set @feed 		= @feed - @feeduse_
			set @qtfeeduse 	= @qtfeeduse + @feeduse_

			--set @feed = case when @feed < 0 then 0 else @feed end

			-----------------------------------
			-- ���ű�ϸ�ŷ
			-----------------------------------
			exec spu_FVUserItemBuyLog @gameid_, @seeditemcode_, @gamecostsell, @cashcostsell
		END

	--------------------------------------------------------------
	-- ���� �ڵ� ������.
	--------------------------------------------------------------
	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost, @feed feed, @heart heart

	if(@nResult_ = @RESULT_SUCCESS)
		begin
			-------------------------------------------------------------
			-- �Ϲݰ���� ��ܿ� ����˴ϴ�.
			-------------------------------------------------------------

			-----------------------------------
			-- ���� ���� �ݿ�.
			-----------------------------------
			update dbo.tFVUserMaster
			set
				cashcost		= @cashcost,
				gamecost		= @gamecost,
				feed			= @feed,
				heart			= @heart,

				qtfeeduse		= @qtfeeduse
			where gameid = @gameid_

			--------------------------------------------------------------
			-- ���� ����.
			--------------------------------------------------------------
			select * from dbo.tFVUserSeed where gameid = @gameid_ and seedidx = @seedidx_
		end
	--else
	--	begin
	--		-------------------------------------------------------------
	--		-- �Ϲݰ���� ��ܿ� ����˴ϴ�.
	--		-------------------------------------------------------------
	--	end

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off
End



