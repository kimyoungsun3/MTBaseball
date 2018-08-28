/*
-----------------------------------------------------
-- 2014-05-15
-- �������� �ΰ� ������ �ϴ� �뵵�� �����մϴ�.(ġƮ ī���� 0)
-- �ð����� ������ > ������ ������ �ȵ�.
-----------------------------------------------------
exec spu_FVSeedHarvest 'xxxx2', '049000s1i0n7t8445280',  0, 1, 0, -1	-- ��������.
exec spu_FVSeedHarvest 'xxxx2', '049000s1i0n7t8445289', 11, 1, 0, -1	-- �̱���.
exec spu_FVSeedHarvest 'xxxx2', '049000s1i0n7t8445289',  1, 3, 0, -1	-- �߸��� ���.

-- �Ϲݼ�Ȯ
exec spu_FVSeedHarvest 'farm1078959', '2506581j3z1t4e126143',  0, 1, 1, -1	-- ���� > ����.
exec spu_FVSeedHarvest 'xxxx2', '049000s1i0n7t8445289',  1, 1, 1, -1	-- ���� > ����.
exec spu_FVSeedHarvest 'xxxx2', '049000s1i0n7t8445289',  2, 1, 0, -1	-- ���� > ����.
exec spu_FVSeedHarvest 'xxxx2', '049000s1i0n7t8445289',  3, 1, 0, -1	-- ���� > ����.
exec spu_FVSeedHarvest 'xxxx2', '049000s1i0n7t8445289',  4, 1, 0, -1	-- ���� > ����.
exec spu_FVSeedHarvest 'xxxx2', '049000s1i0n7t8445289',  5, 1, 0, -1	-- ���� > ����.
exec spu_FVSeedHarvest 'xxxx2', '049000s1i0n7t8445289',  6, 1, 0, -1	-- ��Ʈ > ����.
exec spu_FVSeedHarvest 'xxxx2', '049000s1i0n7t8445289',  7, 1, 0, -1	-- ȸ�� > �Ҹ�(������).
exec spu_FVSeedHarvest 'xxxx2', '049000s1i0n7t8445289',  8, 1, 0, -1	-- ���� > �Ҹ�(������).

-- ��ü�Ȯ(�ð����Ϸ�)
exec spu_FVSeedHarvest 'farm1078959', '2506581j3z1t4e126143',  0, 2, 1, -1	-- ���� > ����.
exec spu_FVSeedHarvest 'xxxx2', '049000s1i0n7t8445289',  1, 2, 1, -1	-- ���� > ����.
exec spu_FVSeedHarvest 'xxxx2', '049000s1i0n7t8445289',  2, 2, 0, -1	-- ���� > ����.
exec spu_FVSeedHarvest 'xxxx2', '049000s1i0n7t8445289',  3, 2, 0, -1	-- ���� > ����.
exec spu_FVSeedHarvest 'xxxx2', '049000s1i0n7t8445289',  4, 2, 0, -1	-- ���� > ����.
exec spu_FVSeedHarvest 'xxxx2', '049000s1i0n7t8445289',  5, 2, 0, -1	-- ���� > ����.
exec spu_FVSeedHarvest 'xxxx2', '049000s1i0n7t8445289',  6, 2, 0, -1	-- ��Ʈ > ����.
exec spu_FVSeedHarvest 'xxxx2', '049000s1i0n7t8445289',  7, 2, 0, -1	-- ȸ�� > �Ҹ�(������).
exec spu_FVSeedHarvest 'xxxx2', '049000s1i0n7t8445289',  8, 2, 0, -1	-- ���� > �Ҹ�(������).

-- �۹����ó��.
exec spu_FVSeedHarvest 'xxxx2', '049000s1i0n7t8445289',  1, 3, 1, -1	-- ������.


exec spu_FVSeedHarvest 'xxxx2', '049000s1i0n7t8445289',  1, 1, 3, -1	-- ������.

*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVSeedHarvest', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVSeedHarvest;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_FVSeedHarvest
	@gameid_								varchar(60),
	@password_								varchar(20),
	@seedidx_								int,
	@mode_									int,
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
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- ���������ʴ¸��
	declare @RESULT_ERROR_NOT_FOUND_SEEDIDX		int				set @RESULT_ERROR_NOT_FOUND_SEEDIDX		= -118			-- �Ķ���� ����.
	declare @RESULT_ERROR_PLANT_ALREADY			int				set @RESULT_ERROR_PLANT_ALREADY			= -119			-- �̹� ������ �ɾ�������.
	declare @RESULT_ERROR_NEED_BUY				int				set @RESULT_ERROR_NEED_BUY				= -120			-- �������� �̱��Ż���.
	declare @RESULT_ERROR_HARVEST_TIME_REMAIN	int				set @RESULT_ERROR_HARVEST_TIME_REMAIN	= -121			-- ���� �ð��� ����.

	------------------------------------------------
	--	2-2. ���°�
	------------------------------------------------
	-- �����°�.
	--declare @BLOCK_STATE_NO					int					set	@BLOCK_STATE_NO					= 0	-- �����¾ƴ�
	declare @BLOCK_STATE_YES					int					set	@BLOCK_STATE_YES				= 1	-- ������

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

	-- ���� ���ǰ�
	declare @GIFTLIST_GIFT_KIND_MESSAGE			int					set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2
	declare @GIFTLIST_GIFT_KIND_MESSAGE_DEL		int					set @GIFTLIST_GIFT_KIND_MESSAGE_DEL			= -1
	declare @GIFTLIST_GIFT_KIND_GIFT_DEL		int					set @GIFTLIST_GIFT_KIND_GIFT_DEL			= -2
	declare @GIFTLIST_GIFT_KIND_GIFT_GET		int					set @GIFTLIST_GIFT_KIND_GIFT_GET			= -3
	declare @GIFTLIST_GIFT_KIND_GIFT_SELL		int					set @GIFTLIST_GIFT_KIND_GIFT_SELL			= -4

	-- ������(��Ȯ���).
	declare @USERSEED_HARVEST_MODE_NORMAL     	int					set @USERSEED_HARVEST_MODE_NORMAL			= 1	-- �Ϲݼ�Ȯ.
	declare @USERSEED_HARVEST_MODE_RIGHTNOW  	int					set @USERSEED_HARVEST_MODE_RIGHTNOW			= 2 -- ��ü�Ȯ.
	declare @USERSEED_HARVEST_MODE_GIVEUP  		int					set @USERSEED_HARVEST_MODE_GIVEUP			= 3 -- ������.

	-- ��Ÿ �����
	declare @USERMASTER_UPGRADE_STATE_NON		int					set @USERMASTER_UPGRADE_STATE_NON			= -1	--������, �Ϸ���.(����)
	declare @USERMASTER_UPGRADE_STATE_ING		int					set @USERMASTER_UPGRADE_STATE_ING			= 1		--�����ܰ�������.

	-- ������(����).
	declare @USERSEED_NEED_EMPTY				int					set @USERSEED_NEED_EMPTY					= -1	-- (������)
	declare @USERSEED_NEED_BUY					int					set @USERSEED_NEED_BUY						= -2
	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @comment			varchar(80)

	declare @gameid 			varchar(60)		set @gameid 		= ''
	declare @blockstate			int
	declare @market				int				set @market			= 1
	declare @cashcost			int				set @cashcost		= 0
	declare @gamecost			int				set @gamecost		= 0
	declare @feed				int				set @feed			= 0
	declare @heart				int				set @heart			= 0
	declare @heartmax			int				set @heartmax		= 0
	declare @feedmax			int				set @feedmax		= 0
	declare @qtfeeduse			int				set @qtfeeduse		= 0
	declare @plusheart			int				set @plusheart		= 0
	declare @plusfeed			int				set @plusfeed		= 0
	declare @tmp				int
	declare @housestep			int,
			@housestate			int,
			@housetime			datetime,
			@housestepmax		int
	declare @curdate			datetime		set @curdate		= getdate()

	declare @seeditemcode		int				set @seeditemcode		= @USERSEED_NEED_BUY
	declare @seedenddate		datetime		set @seedenddate		= getdate() + 10
	declare @seeditemname		varchar(40)		set @seeditemname		= ''
	declare @seedgapsecond		int				set @seedgapsecond		= 0

	declare @harvestcnt			int				set @harvestcnt			= 0
	declare @harvestcashcost	int				set @harvestcashcost	= 99999
	declare @harvestitemcode	int				set @harvestitemcode	= -444

	declare @bresult			int				set @bresult			= -1

	declare @subcategory		int				set @subcategory		= -1
	declare @invenkind			int				set @invenkind			= -1

Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	set @comment = 'ERROR �˼����� ����(-1)'
	--select 'DEBUG 1-0 �Է°�', @gameid_ gameid_, @password_ password_, @seedidx_ seedidx_, @mode_ mode_

	------------------------------------------------
	--	3-2. ��������.
	-- ���ʶ����� ����Ŭ
	-- 30(0)/30 -> 30���Ҹ�, 30������ -> 60(30)/30 * ���⼭ �����߻�
	--                                             > max + (9���� * 10����)
	------------------------------------------------
	-- ��������.
	select
		@gameid 		= gameid,
		@blockstate 	= blockstate,
		@market			= market,
		@cashcost		= cashcost,
		@gamecost		= gamecost,
		@feed			= feed,
		@feedmax		= feedmax,
		@heart			= heart,
		@heartmax		= heartmax,
		@qtfeeduse		= qtfeeduse,
		@housestep		= housestep,		@housestate		= housestate,		@housetime		= housetime
	from dbo.tFVUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 1-1 ��������', @gameid gameid, @market market, @cashcost cashcost, @gamecost gamecost, @feed feed, @heart heart, @feedmax feedmax, @heartmax heartmax

	select
		@seeditemcode	= itemcode,
		@seedenddate	= seedenddate
	from dbo.tFVUSerSeed where gameid = @gameid_ and seedidx = @seedidx_
	--select 'DEBUG 1-2 ����������', @gameid_ gameid_, @seedidx_ seedidx_, @seeditemcode seeditemcode, getdate() getdate, @seedenddate seedenddate

	---------------------------------------------
	-- ������ ����.
	---------------------------------------------
	select
		@seeditemname		= itemname,
		@harvestcnt			= param1,
		@harvestcashcost	= param5,
		@harvestitemcode	= param6
	from dbo.tFVItemInfo
	where subcategory = @ITEM_SUBCATEGORY_SEED and itemcode = @seeditemcode
	--select 'DEBUG 1-3 ��������', @mode_ mode_, @harvestcnt harvestcnt, @harvestcashcost harvestcashcost, @harvestitemcode harvestitemcode

	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '���̵� �������� �ʴ´�.'
			--select 'DEBUG ' + @comment
		END
	else if (@blockstate = @BLOCK_STATE_YES)
		BEGIN
			-- �������ΰ�?
			set @nResult_ 	= @RESULT_ERROR_BLOCK_USER
			set @comment 	= '��ó���� ���̵��Դϴ�.'
		END
	else if(@seeditemcode = @USERSEED_NEED_EMPTY)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '���۹��� ���������� ��Ȯ�߽��ϴ�.(�̹�����1)'
			--select 'DEBUG ' + @comment
		END
	else if(@mode_ = @USERSEED_HARVEST_MODE_RIGHTNOW and getdate() >= @seedenddate)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '���۹��� ���������� ��� �ϷḦ ���� �߽��ϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if(@harvestitemcode = -444)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_ITEMCODE
			set @comment 	= '������ ��ã�ҽ��ϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if(@mode_ not in(@USERSEED_HARVEST_MODE_NORMAL, @USERSEED_HARVEST_MODE_RIGHTNOW, @USERSEED_HARVEST_MODE_GIVEUP))
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment 	= '�������� �ʴ� �����Դϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if(@mode_ = @USERSEED_HARVEST_MODE_NORMAL and getdate() < @seedenddate)
		BEGIN
			select @seedgapsecond = dbo.fnu_GetFVDatePart('ss', @seedenddate, getdate())
			set @nResult_ 	= @RESULT_ERROR_HARVEST_TIME_REMAIN
			set @comment 	= '�ð��� ���� ' + @seeditemname + '('+ltrim(rtrim(str(@seeditemcode)))+') ��Ȯ�����ð�('+ltrim(rtrim(str(-@seedgapsecond)))+'��)'
			--select 'DEBUG ' + @comment

			if(@seedgapsecond < -10)
				begin
					exec spu_FVSubUnusualRecord2 @gameid_, 0, @comment
				end
			set @nResult_ 	= @RESULT_SUCCESS
		END
	else if(@mode_ = @USERSEED_HARVEST_MODE_RIGHTNOW and (@harvestcashcost <= 0 or @harvestcashcost > @cashcost))
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_CASHCOST_LACK
			set @comment 	= 'ĳ������� �����մϴ�.'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS �������� ��Ȯ�� �Ѵ�.'
			--select 'DEBUG ' + @comment

			--select 'DEBUG ����(����)', @housestate housestate, @housestep housestep, @housestepmax housestepmax, @housetime housetime
			if(@housestate = @USERMASTER_UPGRADE_STATE_ING and @curdate >= @housetime)
				begin
					select top 1 @housestepmax = housestepmax from dbo.tFVSystemInfo order by idx desc

					set @housestate = @USERMASTER_UPGRADE_STATE_NON
					set @housestep	= CASE
											WHEN (@housestep + 1 < @housestepmax) THEN @housestep + 1
											ELSE @housestepmax
									  END

					-- �����ۿϷ� > ����, ��Ʈ �ƽ�Ȯ��.
					select
						@feedmax		= param5,
						@heartmax		= param6
					from dbo.tFVItemInfo
					where subcategory = @ITEM_SUBCATEGORY_UPGRADE_HOUSE and param1 = @housestep
				end
			--select 'DEBUG ����(����)', @housestate housestate, @housestep housestep, @housestepmax housestepmax, @housetime housetime


			if(@mode_ = @USERSEED_HARVEST_MODE_GIVEUP)
				begin
					--select 'DEBUG ������ �Ϲ����ó��.'
					set @comment = 'SUCCESS �������� ��Ȯ�� ����Ѵ�.'
					update dbo.tFVUserSeed
						set
							itemcode = @USERSEED_NEED_EMPTY
					where gameid = @gameid_ and seedidx = @seedidx_
				end
			else if(@mode_ = @USERSEED_HARVEST_MODE_NORMAL and getdate() >= @seedenddate)
				begin
					--select 'DEBUG ������ �Ϲݼ�Ȯó��.'
					update dbo.tFVUserSeed
						set
							itemcode = @USERSEED_NEED_EMPTY
					where gameid = @gameid_ and seedidx = @seedidx_

					set @bresult = 1

					-- �ϴ� > �ش���������� or ������.
				end
			else if(@mode_ = @USERSEED_HARVEST_MODE_RIGHTNOW and @harvestcashcost <= @cashcost)
				begin
					---------------------------------------------------------------
					--select 'DEBUG ������ ��ü�Ȯ > �ð����Ϸ�.'
					---------------------------------------------------------------
					-- 2. �ð��ϷḸ.
					update dbo.tFVUserSeed
						set
							seedenddate = getdate()
					where gameid = @gameid_ and seedidx = @seedidx_

					-- �������.
					set @cashcost	= @cashcost - @harvestcashcost

					-----------------------------------
					-- ���ű�ϸ�ŷ
					-----------------------------------
					exec spu_FVUserItemBuyLog @gameid_, @seeditemcode, 0, @harvestcashcost

					-- > ���޾���
					set @bresult = 0
				end

			-- �ش���������� or ������.
			if(@bresult = 1)
				begin
					-- �������ڵ� > ���� > �з�.
					select
						@subcategory 	= subcategory
					from dbo.tFVItemInfo where itemcode = @harvestitemcode

					set @invenkind = dbo.fnu_GetFVInvenFromSubCategory(@subcategory)
					--select 'DEBUG ���������� ', @subcategory subcategory, @invenkind invenkind

					-- �����ʰ��.
					set @feeduse_ = case
										when @feeduse_ < 0 then (-@feeduse_)
										else @feeduse_
									end

					set @feed 		= @feed - @feeduse_
					set @qtfeeduse 	= @qtfeeduse + @feeduse_

					if(@invenkind in (@USERITEM_INVENKIND_ANI, @USERITEM_INVENKIND_CONSUME, @USERITEM_INVENKIND_ACC))
						begin
							--select 'DEBUG ����, �Ҹ�, �Ǽ� > ������'
							exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT, @harvestitemcode, 'SysHarvest', @gameid_, ''				-- Ư�������� ����

							set @bresult = 2
						end
					--else if(@invenkind in (@ITEM_SUBCATEGORY_CASHCOST, @ITEM_SUBCATEGORY_GAMECOST))
					--	begin
					--		set @bresult = 1
					--	end
					else if(@subcategory = @ITEM_SUBCATEGORY_HEART)
						begin
							--select 'DEBUG ��Ʈ -> �ٷ�����(Maxüũ)', @heart heart, @heartmax heartmax, @harvestcnt harvestcnt
							set @tmp 	= @heart
							set @heart 	= case
											when (@heart 				>= @heartmax) then (@heart)
											when (@heart + @harvestcnt  >= @heartmax) then (@heartmax)
											else (@heart + @harvestcnt)
										end
							set @bresult 	= 1
							set @plusheart 	= @harvestcnt
						end
					else if(@subcategory = @ITEM_SUBCATEGORY_FEED)
						begin
							--select 'DEBUG ���� -> �ٷ�����', @feed feed, @feedmax feedmax, @harvestcnt harvestcnt
							set @tmp 	= @feed
							set @feed = case
											when (@feed 			   >= @feedmax) then (@feed)
											when (@feed + @harvestcnt  >= @feedmax) then (@feedmax)
											else (@feed + @harvestcnt)
										end

							set @bresult 	= 1
							set @plusfeed 	= @harvestcnt
						end

				end
		END

	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost, @feed feed, @heart heart, @feedmax feedmax, @heartmax heartmax, @bresult bresult
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			-----------------------------------
			-- ���� ���� �ݿ�.
			-----------------------------------
			update dbo.tFVUserMaster
			set
				cashcost		= @cashcost,
				gamecost		= @gamecost,
				feed			= @feed,
				heart			= @heart,
				feedmax			= @feedmax,
				heartmax		= @heartmax,
				housestate 		= @housestate, 		housestep 		= @housestep,

				qtfeeduse		= @qtfeeduse,
				bkheart			= bkheart + @plusheart,
				bkfeed			= bkfeed + @plusfeed

			where gameid = @gameid_

			--------------------------------------------------------------
			-- ������ ����.
			--------------------------------------------------------------
			select * from dbo.tFVUserSeed where gameid = @gameid_ and seedidx = @seedidx_

			--------------------------------------------------------------
			-- ����������.
			--------------------------------------------------------------
			if(@bresult = 2)
				begin
					exec spu_FVGiftList @gameid_
				end
		end
	else if(@nResult_ = @RESULT_ERROR_HARVEST_TIME_REMAIN)
		begin
			-----------------------------------
			-- ���� ���� �ݿ�(X).
			-----------------------------------

			--------------------------------------------------------------
			-- ������ ����.
			--------------------------------------------------------------
			select * from dbo.tFVUserSeed where gameid = @gameid_ and seedidx = @seedidx_

			--------------------------------------------------------------
			-- ����������.
			--------------------------------------------------------------
			if(@bresult = 2)
				begin
					exec spu_FVGiftList @gameid_
				end
		end

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off
End



