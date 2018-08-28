/*
-----------------------------------------------------
-- 2014-05-15
-- �������� �ΰ� ������ �ϴ� �뵵�� �����մϴ�.(ġƮ ī���� 0)
-----------------------------------------------------
exec spu_FVFacUpgrade 'xxxx2', '049000s1i0n7t8445280', 60, 1, -1		-- ��������.
exec spu_FVFacUpgrade 'xxxx2', '049000s1i0n7t8445289', -1, 1, -1		-- ���۾���.
exec spu_FVFacUpgrade 'xxxx2', '049000s1i0n7t8445289', 60,-1, -1		-- �ܰ����.

exec spu_FVFacUpgrade 'farm1078959', '2506581j3z1t4e126143', 60, 1, -1		-- ��		(����).
exec spu_FVFacUpgrade 'farm1078959', '2506581j3z1t4e126143', 60, 2, -1		--			(��ÿϷ�)
exec spu_FVFacUpgrade 'xxxx2', '049000s1i0n7t8445289', 60, 1, -1		-- ��		(����).
exec spu_FVFacUpgrade 'xxxx2', '049000s1i0n7t8445289', 60, 2, -1		--			(��ÿϷ�)
exec spu_FVFacUpgrade 'xxxx2', '049000s1i0n7t8445289', 61, 1, -1		-- ��ũ		(����).
exec spu_FVFacUpgrade 'xxxx2', '049000s1i0n7t8445289', 61, 2, -1		--			(��ÿϷ�)
exec spu_FVFacUpgrade 'xxxx2', '049000s1i0n7t8445289', 62, 1, -1		-- ���º���	(����).
exec spu_FVFacUpgrade 'xxxx2', '049000s1i0n7t8445289', 62, 2, -1		--			(��ÿϷ�)
exec spu_FVFacUpgrade 'xxxx2', '049000s1i0n7t8445289', 63, 1, -1		-- ��ȭ�ü�	(����).
exec spu_FVFacUpgrade 'xxxx2', '049000s1i0n7t8445289', 63, 2, -1		--			(��ÿϷ�)
exec spu_FVFacUpgrade 'xxxx2', '049000s1i0n7t8445289', 64, 1, -1		-- �絿��	(����).
exec spu_FVFacUpgrade 'xxxx2', '049000s1i0n7t8445289', 64, 2, -1		--			(��ÿϷ�)
exec spu_FVFacUpgrade 'xxxx2', '049000s1i0n7t8445289', 65, 1, -1		-- ������	(����).
exec spu_FVFacUpgrade 'xxxx2', '049000s1i0n7t8445289', 65, 2, -1		--			(��ÿϷ�)
exec spu_FVFacUpgrade 'xxxx2', '049000s1i0n7t8445289', 66, 1, -1		-- ���Ա�	(����).
exec spu_FVFacUpgrade 'xxxx2', '049000s1i0n7t8445289', 66, 2, -1		--			(��ÿϷ�)
*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVFacUpgrade', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVFacUpgrade;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_FVFacUpgrade
	@gameid_								varchar(60),
	@password_								varchar(20),
	@subcategory_							int,
	@kind_									int,
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
	declare @RESULT_ERROR_RESULT_COPY			int				set @RESULT_ERROR_RESULT_COPY			= -53			-- ���ī�ǽõ�
	declare @RESULT_ERROR_GAMECOST_COPY			int				set @RESULT_ERROR_GAMECOST_COPY			= -54			-- �ǹ�ī�ǽõ�
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- ���������ʴ¸��
	declare @RESULT_ERROR_HARVEST_TIME_REMAIN	int				set @RESULT_ERROR_HARVEST_TIME_REMAIN	= -121			-- ���� �ð��� ����.
	declare @RESULT_ERROR_TIME_REMAIN			int				set @RESULT_ERROR_TIME_REMAIN			= -123			-- ���� �ð��� ����.

	------------------------------------------------
	--	2-2. ���°�
	------------------------------------------------
	-- �����°�.
	--declare @BLOCK_STATE_NO					int					set	@BLOCK_STATE_NO					= 0	-- �����¾ƴ�
	declare @BLOCK_STATE_YES					int					set	@BLOCK_STATE_YES				= 1	-- ������

	-- ������ �Һз�
	declare @ITEM_SUBCATEGORY_UPGRADE_HOUSE		int					set @ITEM_SUBCATEGORY_UPGRADE_HOUSE 		= 60 -- ��
	declare @ITEM_SUBCATEGORY_UPGRADE_TANK		int					set @ITEM_SUBCATEGORY_UPGRADE_TANK 			= 61 -- ��ũ
	declare @ITEM_SUBCATEGORY_UPGRADE_FRESHCOOL	int					set @ITEM_SUBCATEGORY_UPGRADE_FRESHCOOL 	= 62 -- ���º���
	declare @ITEM_SUBCATEGORY_UPGRADE_PURE		int					set @ITEM_SUBCATEGORY_UPGRADE_PURE 			= 63 -- ��ȭ�ü�
	declare @ITEM_SUBCATEGORY_UPGRADE_BOTTLE	int					set @ITEM_SUBCATEGORY_UPGRADE_BOTTLE 		= 64 -- �絿��
	declare @ITEM_SUBCATEGORY_UPGRADE_PUMP		int					set @ITEM_SUBCATEGORY_UPGRADE_PUMP 			= 65 -- ������
	declare @ITEM_SUBCATEGORY_UPGRADE_TRANSFER	int					set @ITEM_SUBCATEGORY_UPGRADE_TRANSFER 		= 66 -- ���Ա�

	-- �ü�(���׷��̵�).
	declare @USERMASTER_UPGRADE_STATE_NON		int					set @USERMASTER_UPGRADE_STATE_NON			= -1	--������, �Ϸ���.(����)
	declare @USERMASTER_UPGRADE_STATE_ING		int					set @USERMASTER_UPGRADE_STATE_ING			= 1		--�����ܰ�������.

	declare @USERMASTER_UPGRADE_KIND_NEXT		int					set @USERMASTER_UPGRADE_KIND_NEXT			= 1		-- ���׷��̵� ����.
	declare @USERMASTER_UPGRADE_KIND_RIGHTNOW	int					set @USERMASTER_UPGRADE_KIND_RIGHTNOW		= 2		-- ���׷��̵� ��ÿϷ�.

	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @comment			varchar(80)

	declare @gameid 			varchar(60)		set @gameid 		= ''
	declare @blockstate			int
	declare @market				int				set @market			= -1
	declare @cashcost			int				set @cashcost		= 0
	declare @gamecost			int				set @gamecost		= 0
	declare @feedmax			int				set @feedmax		= 10
	declare @heartmax			int				set @heartmax		= 20
	declare @fpointmax			int				set @fpointmax		= 500
	declare @housestep			int				set @housestep 		= 0
	declare @housestate			int				set @housestate 	= @USERMASTER_UPGRADE_STATE_NON
	declare @housetime			datetime		set @housetime		= getdate() + 1
	declare @tankstep			int				set @tankstep 		= 0
	declare @tankstate			int				set @tankstate 		= @USERMASTER_UPGRADE_STATE_NON
	declare @tanktime			datetime		set @tanktime		= getdate() + 1
	declare @bottlestep			int				set @bottlestep 	= 0
	declare @bottlestate		int				set @bottlestate 	= @USERMASTER_UPGRADE_STATE_NON
	declare @bottletime			datetime		set @bottletime		= getdate() + 1
	declare @pumpstep			int				set @pumpstep 		= 0
	declare @pumpstate			int				set @pumpstate 		= @USERMASTER_UPGRADE_STATE_NON
	declare @pumptime			datetime		set @pumptime		= getdate() + 1
	declare @transferstep		int				set @transferstep 	= 0
	declare @transferstate		int				set @transferstate 	= @USERMASTER_UPGRADE_STATE_NON
	declare @transfertime		datetime		set @transfertime		= getdate() + 1
	declare @purestep			int				set @purestep 		= 0
	declare @purestate			int				set @purestate 		= @USERMASTER_UPGRADE_STATE_NON
	declare @puretime			datetime		set @puretime		= getdate() + 1
	declare @freshcoolstep		int				set @freshcoolstep 	= 0
	declare @freshcoolstate		int				set @freshcoolstate = @USERMASTER_UPGRADE_STATE_NON
	declare @freshcooltime		datetime		set @freshcooltime	= getdate() + 1

	declare @housestepmax		int   			set @housestepmax		= -1
	declare @tankstepmax		int             set @tankstepmax		= -1
	declare @bottlestepmax		int             set @bottlestepmax		= -1
	declare @pumpstepmax		int             set @pumpstepmax		= -1
	declare @transferstepmax	int             set @transferstepmax	= -1
	declare @purestepmax		int             set @purestepmax		= -1
	declare @freshcoolstepmax	int             set @freshcoolstepmax	= -1

	declare @itemcodesell		int				set @itemcodesell		= -1
	declare @gamecostsell		int				set @gamecostsell 		= 99999
	declare @cashcostsell		int				set @cashcostsell 		= 99999
	declare @cashcostsell2		int				set @cashcostsell2 		= 99999
	declare @upgradesecond		int				set @upgradesecond		= 9999999
	declare @feedmax2			int				set @feedmax2			= 10
	declare @heartmax2			int				set @heartmax2			= 20
	declare @fpointmax2			int				set @fpointmax2			= 20

	declare @curstep 			int				set @curstep			= 99999
	declare @nextstep 			int				set @nextstep			= 99999
	declare @curstate 			int				set @curstate			= 99999
	declare @curtime 			datetime		set @curtime			= getdate() + 1
	declare @curmax 			int				set @curmax				= 99999
	declare @dummy	 			int
	declare @bchange			int				set @bchange			= 0
	declare @bupgradeistimeover int 			set @bupgradeistimeover	= 0

	declare @itemname			varchar(40)		set @itemname			= ''
	declare @gapsecond			int				set @gapsecond			= 0
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG �Է°�', @gameid_ gameid_, @password_ password_, @subcategory_ subcategory_, @kind_ kind_

	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	-- ��������.
	select
		@gameid 		= gameid,
		@blockstate 	= blockstate,
		@market			= market,
		@cashcost		= cashcost,
		@gamecost		= gamecost,
		@feedmax		= feedmax,
		@heartmax		= heartmax,
		@fpointmax		= fpointmax,
		@housestep		= housestep,		@housestate		= housestate,		@housetime      = housetime,
		@tankstep		= tankstep,			@tankstate		= tankstate,		@tanktime       = tanktime,
		@bottlestep		= bottlestep,		@bottlestate	= bottlestate,		@bottletime     = bottletime,
		@pumpstep		= pumpstep,			@pumpstate		= pumpstate,		@pumptime       = pumptime,
		@transferstep	= transferstep,		@transferstate	= transferstate,	@transfertime   = transfertime,
		@purestep		= purestep,			@purestate		= purestate,		@puretime       = puretime,
		@freshcoolstep	= freshcoolstep,	@freshcoolstate = freshcoolstate,	@freshcooltime  = freshcooltime
	from dbo.tFVUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 1-1 ��������', @gameid gameid, @market market, @cashcost cashcost, @gamecost gamecost, @housestep housestep, @housestate housestate, @housetime housetime, @tankstep tankstep, @tankstate tankstate, @tanktime tanktime, @bottlestep bottlestep, @bottlestate bottlestate, @bottletime bottletime, @pumpstep pumpstep, @pumpstate pumpstate, @pumptime pumptime, @transferstep transferstep, @transferstate transferstate, @transfertime transfertime, @purestep purestep, @purestate purestate, @puretime puretime, @freshcoolstep freshcoolstep, @freshcoolstate freshcoolstate, @freshcooltime freshcooltime

	---------------------------------------------
	-- tItemInfo(���׷��̵�����) > ����������(����) > tSystemInfo
	---------------------------------------------
	select top 1
		@housestepmax		= housestepmax,
		@tankstepmax		= tankstepmax,
		@bottlestepmax		= bottlestepmax,
		@pumpstepmax		= pumpstepmax,
		@transferstepmax	= transferstepmax,
		@purestepmax		= purestepmax,
		@freshcoolstepmax	= freshcoolstepmax
	from dbo.tFVSystemInfo order by idx desc
	--select 'DEBUG tSystemInfo ', @housestepmax housestepmax, @tankstepmax tankstepmax, @bottlestepmax bottlestepmax, @pumpstepmax pumpstepmax, @transferstepmax transferstepmax, @purestepmax purestepmax, @freshcoolstepmax freshcoolstepmax


	-- ��������.
	if(@subcategory_ = @ITEM_SUBCATEGORY_UPGRADE_HOUSE)
		begin
			--select 'DEBUG 1-2 ������', @housestep housestep, @housestate housestate, @housetime housetime, @housestepmax housestepmax
			set @itemname 	= '������'
			set @curstep 	= @housestep
			set @nextstep 	= @housestep + 1
			set @curstate	= @housestate
			set @curtime	= @housetime
			set @curmax		= @housestepmax
		end
	else if(@subcategory_ = @ITEM_SUBCATEGORY_UPGRADE_TANK)
		begin
			--select 'DEBUG 1-3 ��ũ����', @tankstep tankstep, @tankstate tankstate, @tanktime tanktime, @tankstepmax tankstepmax
			set @itemname 	= '��ũ����'
			set @curstep 	= @tankstep
			set @nextstep 	= @tankstep + 1
			set @curstate	= @tankstate
			set @curtime	= @tanktime
			set @curmax		= @tankstepmax
		end
	else if(@subcategory_ = @ITEM_SUBCATEGORY_UPGRADE_BOTTLE)
		begin
			--select 'DEBUG 1-4 �絿�̾���', @bottlestep bottlestep, @bottlestate bottlestate, @bottletime bottletime, @bottlestepmax bottlestepmax
			set @itemname 	= '�絿�̾���'
			set @curstep 	= @bottlestep
			set @nextstep 	= @bottlestep + 1
			set @curstate	= @bottlestate
			set @curtime	= @bottletime
			set @curmax		= @bottlestepmax
		end
	else if(@subcategory_ = @ITEM_SUBCATEGORY_UPGRADE_PUMP)
		begin
			--select 'DEBUG 1-5 ���������', @pumpstep pumpstep, @pumpstate pumpstate, @pumptime pumptime, @pumpstepmax pumpstepmax
			set @itemname 	= '���������'
			set @curstep 	= @pumpstep
			set @nextstep 	= @pumpstep + 1
			set @curstate	= @pumpstate
			set @curtime	= @pumptime
			set @curmax		= @pumpstepmax
		end
	else if(@subcategory_ = @ITEM_SUBCATEGORY_UPGRADE_TRANSFER)
		begin
			--select 'DEBUG 1-6 ���Ա����', @transferstep transferstep, @transferstate transferstate, @transfertime transfertime, @transferstepmax transferstepmax
			set @itemname 	= '���Ա����'
			set @curstep 	= @transferstep
			set @nextstep 	= @transferstep + 1
			set @curstate	= @transferstate
			set @curtime	= @transfertime
			set @curmax		= @transferstepmax
		end
	else if(@subcategory_ = @ITEM_SUBCATEGORY_UPGRADE_PURE)
		begin
			--select 'DEBUG 1-7 ��ȭ����', @purestep purestep, @purestate purestate, @puretime puretime, @purestepmax purestepmax
			set @itemname 	= '��ȭ����'
			set @curstep 	= @purestep
			set @nextstep 	= @purestep + 1
			set @curstate	= @purestate
			set @curtime	= @puretime
			set @curmax		= @purestepmax
		end
	else if(@subcategory_ = @ITEM_SUBCATEGORY_UPGRADE_FRESHCOOL)
		begin
			--select 'DEBUG 1-8 ���º�������', @freshcoolstep freshcoolstep, @freshcoolstate freshcoolstate, @freshcooltime freshcooltime, @freshcoolstepmax freshcoolstepmax
			set @itemname 	= '���º�������'
			set @curstep 	= @freshcoolstep
			set @nextstep 	= @freshcoolstep + 1
			set @curstate	= @freshcoolstate
			set @curtime	= @freshcooltime
			set @curmax		= @freshcoolstepmax
		end
	else
		begin
			--select 'DEBUG �������� �ʴ� ���׷��̵�'
			set @itemname 	= '�𸧾���'
			set @dummy 		= 0
		end

	------------------------------------------------------
	-- ������ and Ŭ��(�ð��Ϸ�) and �������ۿ�û > �����ܰ�� ����
	------------------------------------------------------
	if(@kind_ = @USERMASTER_UPGRADE_KIND_NEXT and @curstate = @USERMASTER_UPGRADE_STATE_ING and getdate() >= @curtime)
		begin
			set @curstate	= @USERMASTER_UPGRADE_STATE_NON
			set @curstep 	= @nextstep

			set @nextstep 	= @nextstep + 1
			set @curtime	= getdate()

			-- Ÿ���� �Ϸ�Ǿ �Ϸ� > �����۽� Max�� �����ϱ�.
			set @bupgradeistimeover	= 1
		end

	------------------------------------------------------
	-- �ܰ輼������.
	------------------------------------------------------
	if(@kind_ = @USERMASTER_UPGRADE_KIND_NEXT)
		begin
			select
				@itemcodesell		= itemcode,
				@cashcostsell		= cashcost,
				@gamecostsell 		= gamecost,
				@cashcostsell2		= param3,
				@upgradesecond		= param4,
				@feedmax2			= case
										when (@subcategory_ = @ITEM_SUBCATEGORY_UPGRADE_HOUSE) then param5
										else @feedmax
									end,
				@heartmax2			= case
										when (@subcategory_ = @ITEM_SUBCATEGORY_UPGRADE_HOUSE) then param6
										else @heartmax
									end,
				@fpointmax2			= case
										when (@subcategory_ = @ITEM_SUBCATEGORY_UPGRADE_HOUSE) then param9
										else @fpointmax
									end
			from dbo.tFVItemInfo
			where subcategory = @subcategory_ and param1 = @nextstep
			--select 'DEBUG > �ܰ輼��', @subcategory_ subcategory_, @nextstep nextstep, @itemcodesell itemcodesell, @cashcostsell cashcostsell, @gamecostsell gamecostsell, @cashcostsell2 cashcostsell2, @upgradesecond upgradesecond
		end
	else if(@kind_ = @USERMASTER_UPGRADE_KIND_RIGHTNOW)
		begin
			select
				@itemcodesell		= itemcode,
				@cashcostsell		= cashcost,
				@gamecostsell 		= gamecost,
				@cashcostsell2		= param3,
				@upgradesecond		= param4,
				@feedmax2			= case
										when (@subcategory_ = @ITEM_SUBCATEGORY_UPGRADE_HOUSE) then param5
										else @feedmax
									end,
				@heartmax2			= case
										when (@subcategory_ = @ITEM_SUBCATEGORY_UPGRADE_HOUSE) then param6
										else @heartmax
									end,
				@fpointmax2			= case
										when (@subcategory_ = @ITEM_SUBCATEGORY_UPGRADE_HOUSE) then param9
										else @fpointmax
									end
			from dbo.tFVItemInfo
			where subcategory = @subcategory_ and param1 = @nextstep
			--select 'DEBUG > ��ÿϷ�', @subcategory_ subcategory_, @curstep curstep, @itemcodesell itemcodesell, @cashcostsell cashcostsell, @gamecostsell gamecostsell, @cashcostsell2 cashcostsell2, @upgradesecond upgradesecond
		end
	else
		begin
			--select 'DEBUG �������� �ʴ� ����'
			set @dummy 		= 0
		end


	--------------------------------------------------------------
	-- ������ > �ð��� ���� �Ϸ�
	--------------------------------------------------------------
	if(@bupgradeistimeover = 1)
		begin
			if(@subcategory_ = @ITEM_SUBCATEGORY_UPGRADE_HOUSE)
				begin
					set @feedmax		= @feedmax2
					set @heartmax		= @heartmax2
					set @fpointmax		= @fpointmax2
				end
		end


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
	else if(@kind_ = @USERMASTER_UPGRADE_KIND_NEXT and @curstate = @USERMASTER_UPGRADE_STATE_ING and getdate() < @curtime)
		BEGIN
			select @gapsecond = dbo.fnu_GetFVDatePart('ss', @curtime, getdate())

			set @nResult_ 	= @RESULT_ERROR_TIME_REMAIN
			set @comment 	= '�ð��� ���� ' + @itemname + '('+ltrim(rtrim(str(@curstep)))+'�ܰ�) �����ð�('+ltrim(rtrim(str(-@gapsecond)))+'��)'
			--select 'DEBUG ' + @comment

			if(@gapsecond < -10)
				begin
					exec spu_FVSubUnusualRecord2 @gameid_, 0, @comment
				end
		END
	else if(@subcategory_ not in (@ITEM_SUBCATEGORY_UPGRADE_HOUSE, @ITEM_SUBCATEGORY_UPGRADE_TANK, @ITEM_SUBCATEGORY_UPGRADE_FRESHCOOL, @ITEM_SUBCATEGORY_UPGRADE_PURE, @ITEM_SUBCATEGORY_UPGRADE_BOTTLE, @ITEM_SUBCATEGORY_UPGRADE_PUMP, @ITEM_SUBCATEGORY_UPGRADE_TRANSFER))
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment 	= '�������� �ʴ� ����Դϴ�.(1)'
			--select 'DEBUG ' + @comment
		END
	else if(@kind_ not in (@USERMASTER_UPGRADE_KIND_NEXT, @USERMASTER_UPGRADE_KIND_RIGHTNOW))
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment 	= '�������� �ʴ� ����Դϴ�.(2)'
			--select 'DEBUG ' + @comment
		END
	else if(@kind_ = @USERMASTER_UPGRADE_KIND_NEXT and @nextstep > @curmax)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_UPGRADE_FULL
			set @comment 	= '���׷��̵尡 �ƽ��Դϴ�.(next)'
			--select 'DEBUG ' + @comment
		END
	--else if(@kind_ = @USERMASTER_UPGRADE_KIND_RIGHTNOW and @curstep > @curmax)
	--	> ���׷��̵�(next)���� �˻������Ƿ� ����� �������� �ȿ�.
	else if(@itemcodesell = -1 or (@cashcostsell <= 0 and @gamecostsell <= 0))
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_ITEMCODE
			set @comment 	= '���׷��̵尡 ������ �ڵ带 ã�� �� �����ϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if(@kind_ = @USERMASTER_UPGRADE_KIND_NEXT and @cashcostsell > 0 and @cashcostsell > @cashcost)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_CASHCOST_LACK
			set @comment 	= 'ĳ������� �����մϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if(@kind_ = @USERMASTER_UPGRADE_KIND_NEXT and @gamecostsell > 0 and @gamecostsell > @gamecost)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_GAMECOST_LACK
			set @comment 	= '���κ���� �����մϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if(@kind_ = @USERMASTER_UPGRADE_KIND_RIGHTNOW and @cashcostsell2 > @cashcost)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_CASHCOST_LACK
			set @comment 	= 'ĳ������� �����մϴ�.(2)'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS ���׷��̵� ���� �� ��ÿϷ�.'
			--select 'DEBUG ' + @comment

			if(@kind_ = @USERMASTER_UPGRADE_KIND_NEXT)
				begin
					set @comment = 'SUCCESS ���׷��̵� ����.'
					--select 'DEBUG ���׷��̵� ��û�ϱ�'
					if(@curstate = @USERMASTER_UPGRADE_STATE_ING)
						begin
							if(getdate() >= @curtime)
								begin
									--select 'DEBUG > ������ > �ð��Ϸ� > ���۴���(O)'
									set @curstate 	= @USERMASTER_UPGRADE_STATE_NON
									set @curstep 	= @nextstep

									set @feedmax		= @feedmax2
									set @heartmax		= @heartmax2
									set @fpointmax		= @fpointmax2
								end
							else
								begin
									--select 'DEBUG > ������ >          > ���۴���(X)'
									set @curstate 	= @USERMASTER_UPGRADE_STATE_ING
									set @curstep 	= @curstep
								end
						end
					else
						begin
							--select 'DEBUG > ����Ϸ� > ���۴���(O)'
							set @curstate 	= @USERMASTER_UPGRADE_STATE_NON
							set @curstep 	= @curstep
						end


					set @bchange	= 0
					if(@curstate = @USERMASTER_UPGRADE_STATE_NON and @curstep >= @curmax)
						begin
							--select 'DEBUG > ����Ϸ� > �ƽ�����(���̻� ���۾���)'
							set @bchange	= 1
						end
					else if(@curstate = @USERMASTER_UPGRADE_STATE_NON)
						begin
							--select 'DEBUG > ����Ϸ� > ���� �ü����׷��̵�'

							-- ĳ�� or �������� > �ϴܿ��� ������.
							set @cashcost = @cashcost - @cashcostsell
							set @gamecost = @gamecost - @gamecostsell

							-- ���ű�ϸ�ŷ
							exec spu_FVUserItemBuyLog @gameid_, @itemcodesell, @gamecostsell, @cashcostsell

							set @curstep 	= @curstep
							set @curstate 	= @USERMASTER_UPGRADE_STATE_ING
							set @curtime 	= dateadd(s, @upgradesecond, getdate())

							set @bchange	= 1
						end

					if(@bchange = 1)
						begin
							if(@subcategory_ = @ITEM_SUBCATEGORY_UPGRADE_HOUSE)
								begin
									set @housestep 		= @curstep
									set @housestate		= @curstate
									set @housetime		= @curtime
									--select 'DEBUG 3-2 ������', @housestep housestep, @housestate housestate, @housetime housetime
								end
							else if(@subcategory_ = @ITEM_SUBCATEGORY_UPGRADE_TANK)
								begin
									set @tankstep 		= @curstep
									set @tankstate		= @curstate
									set @tanktime		= @curtime
									--select 'DEBUG 3-3 ��ũ����', @tankstep tankstep, @tankstate tankstate, @tanktime tanktime
								end
							else if(@subcategory_ = @ITEM_SUBCATEGORY_UPGRADE_BOTTLE)
								begin
									set @bottlestep 	= @curstep
									set @bottlestate	= @curstate
									set @bottletime		= @curtime
									--select 'DEBUG 3-4 �絿�̾���', @bottlestep bottlestep, @bottlestate bottlestate, @bottletime bottletime
								end
							else if(@subcategory_ = @ITEM_SUBCATEGORY_UPGRADE_PUMP)
								begin
									set @pumpstep 		= @curstep
									set @pumpstate		= @curstate
									set @pumptime		= @curtime
									--select 'DEBUG 3-5 ���������', @pumpstep pumpstep, @pumpstate pumpstate, @pumptime pumptime
								end
							else if(@subcategory_ = @ITEM_SUBCATEGORY_UPGRADE_TRANSFER)
								begin
									set @transferstep 	= @curstep
									set @transferstate	= @curstate
									set @transfertime	= @curtime
									--select 'DEBUG 3-6 ���Ա����', @transferstep transferstep, @transferstate transferstate, @transfertime transfertime
								end
							else if(@subcategory_ = @ITEM_SUBCATEGORY_UPGRADE_PURE)
								begin
									set @purestep 		= @curstep
									set @purestate		= @curstate
									set @puretime		= @curtime
									--select 'DEBUG 3-7 ��ȭ����', @purestep purestep, @purestate purestate, @puretime puretime
								end
							else if(@subcategory_ = @ITEM_SUBCATEGORY_UPGRADE_FRESHCOOL)
								begin
									set @freshcoolstep 	= @curstep
									set @freshcoolstate	= @curstate
									set @freshcooltime	= @curtime
									--select 'DEBUG 3-8 ���º�������', @freshcoolstep freshcoolstep, @freshcoolstate freshcoolstate, @freshcooltime freshcooltime
								end
						end
				end
			else if(@kind_ = @USERMASTER_UPGRADE_KIND_RIGHTNOW)
				begin
					set @comment = 'SUCCESS ���׷��̵� ��ÿϷ�.'
					--select 'DEBUG (��ÿϷ�) ���׷��̵�'
					if(@curstate = @USERMASTER_UPGRADE_STATE_ING)
						begin
							if(getdate() >= @curtime)
								begin
									--select 'DEBUG > (��ÿϷ�) > �ð��Ϸ� > ���ۿϷ�(X)'
									set @curstate 	= @USERMASTER_UPGRADE_STATE_NON
									set @curstep 	= @curstep

									set @feedmax		= @feedmax2
									set @heartmax		= @heartmax2
									set @fpointmax		= @fpointmax2
								end
							else
								begin
									--select 'DEBUG > (��ÿϷ�) > �����ߡ� > ��������(O)'
									set @curstate 	= @USERMASTER_UPGRADE_STATE_ING
									set @curstep 	= @nextstep

									set @feedmax		= @feedmax2
									set @heartmax		= @heartmax2
									set @fpointmax		= @fpointmax2
								end
						end
					else
						begin
							--select 'DEBUG > (��ÿϷ�) > ������ۿϷ�(X)'
							set @curstate 	= @USERMASTER_UPGRADE_STATE_NON
							set @curstep 	= @curstep
						end

					if(@curstate = @USERMASTER_UPGRADE_STATE_ING)
						begin
							--select 'DEBUG > (��ÿϷ�) > ���ۿϷ�(O)'

							-- ĳ�� > �ϴܿ��� ������.
							set @cashcost = @cashcost - @cashcostsell2

							-- ���ű�ϸ�ŷ
							exec spu_FVUserItemBuyLog @gameid_, @itemcodesell, 0, @cashcostsell2

							set @curstep 	= @curstep
							set @curstate 	= @USERMASTER_UPGRADE_STATE_NON
							if(@subcategory_ = @ITEM_SUBCATEGORY_UPGRADE_HOUSE)
								begin
									set @housestep 		= @curstep
									set @housestate		= @curstate
									--select 'DEBUG 4-2 ������', @housestep housestep, @housestate housestate, @housetime housetime
								end
							else if(@subcategory_ = @ITEM_SUBCATEGORY_UPGRADE_TANK)
								begin
									set @tankstep 		= @curstep
									set @tankstate		= @curstate
									--select 'DEBUG 4-3 ��ũ����', @tankstep tankstep, @tankstate tankstate, @tanktime tanktime
								end
							else if(@subcategory_ = @ITEM_SUBCATEGORY_UPGRADE_BOTTLE)
								begin
									set @bottlestep 	= @curstep
									set @bottlestate	= @curstate
									--select 'DEBUG 4-4 �絿�̾���', @bottlestep bottlestep, @bottlestate bottlestate, @bottletime bottletime
								end
							else if(@subcategory_ = @ITEM_SUBCATEGORY_UPGRADE_PUMP)
								begin
									set @pumpstep 		= @curstep
									set @pumpstate		= @curstate
									--select 'DEBUG 4-5 ���������', @pumpstep pumpstep, @pumpstate pumpstate, @pumptime pumptime
								end
							else if(@subcategory_ = @ITEM_SUBCATEGORY_UPGRADE_TRANSFER)
								begin
									set @transferstep 	= @curstep
									set @transferstate	= @curstate
									--select 'DEBUG 4-6 ���Ա����', @transferstep transferstep, @transferstate transferstate, @transfertime transfertime
								end
							else if(@subcategory_ = @ITEM_SUBCATEGORY_UPGRADE_PURE)
								begin
									set @purestep 		= @curstep
									set @purestate		= @curstate
									--select 'DEBUG 4-7 ��ȭ����', @purestep purestep, @purestate purestate, @puretime puretime
								end
							else if(@subcategory_ = @ITEM_SUBCATEGORY_UPGRADE_FRESHCOOL)
								begin
									set @freshcoolstep 	= @curstep
									set @freshcoolstate	= @curstate
									--select 'DEBUG 4-8 ���º�������', @freshcoolstep freshcoolstep, @freshcoolstate freshcoolstate, @freshcooltime freshcooltime
								end
						end
				end


		END

	--------------------------------------------------------------
	-- �ڵ�(ĳ��, ����, ���׷��̵�����)
	--------------------------------------------------------------
	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost, @feedmax feedmax, @heartmax heartmax, @fpointmax fpointmax, @housestep housestep, @housestate housestate, @housetime housetime, @tankstep tankstep, @tankstate tankstate, @tanktime tanktime, @bottlestep bottlestep, @bottlestate bottlestate, @bottletime bottletime, @pumpstep pumpstep, @pumpstate pumpstate, @pumptime pumptime, @transferstep transferstep, @transferstate transferstate, @transfertime transfertime, @purestep purestep, @purestate purestate, @puretime puretime, @freshcoolstep freshcoolstep, @freshcoolstate freshcoolstate, @freshcooltime freshcooltime
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			-----------------------------------
			-- ���� ���� �ݿ�.
			-----------------------------------
			update dbo.tFVUserMaster
				set
					cashcost		= @cashcost,
					gamecost		= @gamecost,
					feedmax			= @feedmax,
					heartmax		= @heartmax,
					fpointmax		= @fpointmax,
					housestep		= @housestep,		housestate		= @housestate, 		housetime      = @housetime,
					tankstep		= @tankstep,		tankstate		= @tankstate, 		tanktime       = @tanktime,
					bottlestep		= @bottlestep,		bottlestate		= @bottlestate, 	bottletime     = @bottletime,
					pumpstep		= @pumpstep,		pumpstate		= @pumpstate, 		pumptime       = @pumptime,
					transferstep	= @transferstep,	transferstate	= @transferstate, 	transfertime   = @transfertime,
					purestep		= @purestep,		purestate		= @purestate, 		puretime       = @puretime,
					freshcoolstep	= @freshcoolstep,	freshcoolstate 	= @freshcoolstate, 	freshcooltime  = @freshcooltime
			where gameid = @gameid_
		end

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off
End



