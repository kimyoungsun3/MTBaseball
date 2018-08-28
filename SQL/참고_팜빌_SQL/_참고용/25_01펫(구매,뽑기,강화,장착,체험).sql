---------------------------------------------------------------
/*
-- �� ���ø� �̰��� ��õ����.
--update dbo.tFVUserMaster set cashcost = 1000, gamecost = 10000, pettodayitemcode = -1 where gameid = 'xxxx3'
exec spu_FVItemPet 'xxxx2', '049000s1i0n7t8445289', 1, 100000, -1	-- �걸��(�̹̱��ŵȰ�)
exec spu_FVItemPet 'xxxx2', '049000s1i0n7t8445289', 1, 100001, -1

-- �� �̱�
exec spu_FVItemPet 'xxxx2', '049000s1i0n7t8445289', 2,     -1, -1	-- ��̱�

-- �� ����
--update dbo.tFVUserMaster set gamecost = 10000 where gameid = 'xxxx3'
exec spu_FVItemPet 'xxxx2', '049000s1i0n7t8445289', 3,      1, -1	--�������
exec spu_FVItemPet 'xxxx2', '049000s1i0n7t8445289', 3,     40, -1

-- �� ����
--update dbo.tFVUserMaster set petcooltime = 5 where gameid = 'xxxx3'
exec spu_FVItemPet 'xxxx2', '049000s1i0n7t8445289', 4,     40, -1

-- �� ü��
--update dbo.tFVUserMaster set pettodayitemcode2 = pettodayitemcode where gameid = 'xxxx2'
exec spu_FVItemPet 'xxxx2', '049000s1i0n7t8445289', 5,     -1, -1
*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVItemPet', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVItemPet;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_FVItemPet
	@gameid_				varchar(60),						-- ���Ӿ��̵�
	@password_				varchar(20),						-- ��ȣȭ�ؼ�����, �����н����� ��ŷ���ص� ����
	@mode_					int,								--
	@paramint_				int,								--
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

	-- ������ ����, ����.
	declare @RESULT_ERROR_UPGRADE_FULL			int				set @RESULT_ERROR_UPGRADE_FULL			= -35			--���׷��̵尡 Ǯ�εǾ���.

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
	declare @RESULT_ERROR_NO_MORE_PET			int				set @RESULT_ERROR_NO_MORE_PET			= -134			-- ���̻� ���� ����.

	------------------------------------------------
	--	2-2. ���ǵȰ�
	------------------------------------------------
	-- �����ۺ� �κ��з�
	declare @USERITEM_INVENKIND_ANI				int 				set @USERITEM_INVENKIND_ANI					= 1
	declare @USERITEM_INVENKIND_CONSUME			int 				set @USERITEM_INVENKIND_CONSUME				= 3
	declare @USERITEM_INVENKIND_ACC				int 				set @USERITEM_INVENKIND_ACC					= 4
	declare @USERITEM_INVENKIND_DIRECT			int 				set @USERITEM_INVENKIND_DIRECT				= 40
	declare @USERITEM_INVENKIND_INFO			int 				set @USERITEM_INVENKIND_INFO				= 60
	declare @USERITEM_INVENKIND_PET				int 				set @USERITEM_INVENKIND_PET					= 1000

	-- ������ ������
	declare @ITEM_SUBCATEGORY_PET				int					set @ITEM_SUBCATEGORY_PET					= 1000 	--��(1000)

	-- ������ ȹ����
	declare @DEFINE_HOW_GET_FIRST				int					set @DEFINE_HOW_GET_FIRST					= 0	--�⺻
	declare @DEFINE_HOW_GET_BUY					int					set @DEFINE_HOW_GET_BUY						= 1	--����
	declare @DEFINE_HOW_GET_SEEDFIELD			int					set @DEFINE_HOW_GET_SEEDFIELD				= 2	--����
	declare @DEFINE_HOW_GET_ROULETTE			int					set @DEFINE_HOW_GET_ROULETTE				= 3	--����/�̱�
	declare @DEFINE_HOW_GET_SEARCH				int					set @DEFINE_HOW_GET_SEARCH					= 4	--�˻�
	declare @DEFINE_HOW_GET_GIFT				int					set @DEFINE_HOW_GET_GIFT					= 5	--����
	declare @DEFINE_HOW_GET_TODAYBUY			int					set @DEFINE_HOW_GET_TODAYBUY				= 6	--[��]���ø��Ǹ�
	declare @DEFINE_HOW_GET_PETROLL				int					set @DEFINE_HOW_GET_PETROLL					= 7	--[��]�̱�

	-- ������ �� ���.
	declare @USERITEM_MODE_PET_TODAYBUY			int					set @USERITEM_MODE_PET_TODAYBUY				= 1		-- ���ø� �̰��� ��õ ����.
	declare @USERITEM_MODE_PET_ROLL				int					set @USERITEM_MODE_PET_ROLL					= 2		-- �̱�.
	declare @USERITEM_MODE_PET_UPGRADE			int					set @USERITEM_MODE_PET_UPGRADE				= 3		-- ����.
	declare @USERITEM_MODE_PET_WEAR				int					set @USERITEM_MODE_PET_WEAR					= 4		-- ����.
	declare @USERITEM_MODE_PET_EXPERIENCE		int					set @USERITEM_MODE_PET_EXPERIENCE			= 5		-- ü��.

	-- ���Ÿ ����
	declare @USERITEM_PET_UPGRADE_MAX			int					set @USERITEM_PET_UPGRADE_MAX				= 6		-- ���׷��̵� �ƽ�.

	-- ��Ѹ�.
	declare @PET_ROLL_MODE_NON					int					set @PET_ROLL_MODE_NON						= -1	-- ����(-1)
	declare @PET_ROLL_MODE_NEW					int					set @PET_ROLL_MODE_NEW						= 1		-- �ű�(1)
	declare @PET_ROLL_MODE_UPGRADE				int					set @PET_ROLL_MODE_UPGRADE					= 2		-- ����(2)


	------------------------------------------------
	--	2-3. ���λ�� ����
	------------------------------------------------
	declare @comment		varchar(80)
	declare @gameid			varchar(60)		set @gameid			= ''	-- ��������.
	declare @cashcost		int				set @cashcost 		= 0
	declare @gamecost		int				set @gamecost 		= 0
	declare @petlistidx		int				set @petlistidx		= -1
	declare @petitemcode	int				set @petitemcode	= -1
	declare @petcooltime	int				set @petcooltime	= 0
	declare @pettodayitemcode int			set @pettodayitemcode = -1
	declare @pettodayitemcode2 int			set @pettodayitemcode2 = -1

	declare @itemcode		int				set @itemcode 			= -1	-- ��������.
	declare @petupgrade 	int				set @petupgrade			= 1
	declare @pettodaycashcost int			set @pettodaycashcost 	= 9999	-- ���ø� ����.
	declare @petrollcashcost int			set @petrollcashcost 	= 9999	-- �̱� ����.
	declare @petupgradeinit	int				set @petupgradeinit		= 1
	declare @petrollmode	int				set @petrollmode		= -1	-- ����(-1), �ű�(1), ����(2)
	declare @petupgradebase	int				set @petupgradebase		= 20000
	declare @petupgradestep	int				set @petupgradestep		= 5000
	declare @petupgradegamecost	int			set @petupgradegamecost	= 25000

	declare @listidx	 	int				set @listidx		= -1
	declare @listidxnew		int				set @listidxnew		= -1
	declare @listidxrtn 	int				set @listidxrtn		= -1
	declare @invenkind		int				set @invenkind		= @USERITEM_INVENKIND_PET
	declare @petmax			int,
			@petrand		int
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	set @comment  = '�˼� ���� ������ �߻��߽��ϴ�.'
	--select 'DEBUG 3-1 �Է°�', @gameid_ gameid_, @password_ password_, @mode_ mode_, @paramint_ paramint_

	------------------------------------------------
	--	3-2. �������(��������, ��������, ������ ����)
	------------------------------------------------
	select
		@gameid 		= gameid,
		@cashcost		= cashcost,
		@gamecost		= gamecost,

		@petlistidx 	= petlistidx,
		@petitemcode 	= petitemcode,
		@petcooltime	= petcooltime,
		@pettodayitemcode 	= pettodayitemcode,
		@pettodayitemcode2 	= pettodayitemcode2
	from dbo.tFVUserMaster where gameid = @gameid_ and password = @password_
	--select 'DEBUG 3-2 ��������', @gameid gameid, @cashcost cashcost, @gamecost gamecost, @petlistidx petlistidx, @petitemcode petitemcode, @pettodayitemcode pettodayitemcode

	------------------------------------------------
	--	3-3. ����Ȳ���� �ڵ�� �з�
	------------------------------------------------
	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR ���̵� �������� �ʴ´�.'
			--select 'DEBUG 4' + @comment
		END
	else if (@mode_ not in (@USERITEM_MODE_PET_TODAYBUY, @USERITEM_MODE_PET_ROLL, @USERITEM_MODE_PET_UPGRADE, @USERITEM_MODE_PET_WEAR, @USERITEM_MODE_PET_EXPERIENCE))
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment 	= 'ERROR �������� �ʴ� ����Դϴ�.'
			--select 'DEBUG 5' + @comment
		END
	else if (@mode_ = @USERITEM_MODE_PET_EXPERIENCE)
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS ü���ϱ⸦ �ߴ�.'
			--select 'DEBUG 5' + @comment

			set @pettodayitemcode2 = -1
		END
	else if (@mode_ = @USERITEM_MODE_PET_TODAYBUY)
		BEGIN
			set @itemcode = case
								when (@paramint_ != -1) then @paramint_
								else				         @pettodayitemcode
							end
			--select 'DEBUG 6-1 [���ø� �̰��� ���Ÿ��]', @itemcode itemcode, @paramint_ paramint_, @pettodayitemcode pettodayitemcode

			select
				@pettodaycashcost	= param1,
				@petupgradeinit		= param5
			from dbo.tFVItemInfo where itemcode = @itemcode and subcategory = @ITEM_SUBCATEGORY_PET
			--select 'DEBUG 6-2 ����������(tItemInfo)', @itemcode itemcode, @ITEM_SUBCATEGORY_PET ITEM_SUBCATEGORY_PET, @pettodaycashcost pettodaycashcost, @petupgradeinit petupgradeinit

			if(@itemcode = -1)
				BEGIN
					set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_ITEMCODE
					set @comment = 'ERROR �������� ã�� �� �����ϴ�.'
					--select 'DEBUG ' + @comment
				END
			else if(@cashcost < @pettodaycashcost)
				BEGIN
					set @nResult_ 	= @RESULT_ERROR_CASHCOST_LACK
					set @comment 	= 'ERROR ĳ���� �����մϴ�.'
					--select 'DEBUG ' + @comment
				END
			else if(exists(select top 1 * from dbo.tFVUserItem where gameid = @gameid_ and itemcode = @itemcode and invenkind = @invenkind))
				BEGIN
					set @nResult_ = @RESULT_SUCCESS
					set @comment = 'SUCCESS [���ø� �̰���] ���� ���� ó���մϴ�(�̹̱���).'
					--select 'DEBUG ' + @comment

					-- ������ ����Ʈ�ε���
					select top 1 @listidxrtn = listidx from dbo.tFVUserItem where gameid = @gameid_ and itemcode = @itemcode and invenkind = @invenkind
				END
			else
				BEGIN
					set @nResult_ = @RESULT_SUCCESS
					set @comment = 'SUCCESS [���ø� �̰���] ���� ���� ó���մϴ�.'
					--select 'DEBUG ' + @comment

					select @listidxnew = isnull(MAX(listidx), 0) + 1 from dbo.tFVUserItem where gameid = @gameid_
					--select 'DEBUG 6-3 �κ� ����ȣ', @listidxnew listidxnew

					---------------------------------------------
					-- �ش������ �κ��� ����
					-- �걸�� > �߰�(�ʱ����)
					-- ĳ������
					-- ���ŷα� ���
					-- listidxrtn = new����
					-- ���ø� �̰��� ���� Ŭ����(-1)
					---------------------------------------------
					-- �걸�� > �߰�(�ʱ����)
					insert into dbo.tFVUserItem(gameid,      listidx,   itemcode, cnt,  invenkind,  petupgrade,      gethow)
					values(					 @gameid_, @listidxnew,  @itemcode,   1, @invenkind, @petupgradeinit, @DEFINE_HOW_GET_TODAYBUY)
					--select 'DEBUG �걸��', @gameid_ gameid_, @listidxnew listidxnew, @itemcode itemcode, @invenkind invenkind, @petupgradeinit petupgradeinit, @DEFINE_HOW_GET_TODAYBUY DEFINE_HOW_GET_TODAYBUY

					-- �굵�����.
					--select 'DEBUG �굵�����.'
					exec spu_FVDogamListPetLog @gameid_, @itemcode

					-- ĳ������ > �ϴܿ��� ����.
					--select 'DEBUG ĳ������(��)', @cashcost cashcost, @pettodaycashcost pettodaycashcost
					set @cashcost = @cashcost - @pettodaycashcost
					--select 'DEBUG ĳ������(��)', @cashcost cashcost, @pettodaycashcost pettodaycashcost

					-- ���ű�ϸ�ŷ
					exec spu_FVUserItemBuyLog @gameid_, @itemcode, 0, @pettodaycashcost

					-- ���ø� �̰��� ���� Ŭ����(-1)
					set @pettodayitemcode	= -1

					-- ����� ������ ����Ʈ�ε���
					set @listidxrtn	= @listidxnew
				END
		END
	else if (@mode_ = @USERITEM_MODE_PET_ROLL)
		BEGIN
			-----------------------------------------------------
			-- [�̺��� �Ǵ� Ǯ�� �ƴѰ�](fun���� ������, newid()����)
			-- <= ������[gameid, ��, full]�ƴѰ�
			--    > iteminfo ran>  �� �̱�
			-----------------------------------------------------
			-- 1�� �������.
			select @petmax	= max(CAST(param10 as int)) from dbo.tFVItemInfo where subcategory = @ITEM_SUBCATEGORY_PET
			set @petrand 	= Convert(int, ceiling(RAND() * @petmax))
			select top 1
				@itemcode 			= itemcode,
				@petrollcashcost	= cashcost,
				@petupgradeinit		= param5
				from
				(
					select
						(ABS(CAST( (BINARY_CHECKSUM(*) * RAND()) as int)) % @petmax) as petrand,
						itemcode,
						cashcost,
						param5
					from dbo.tFVItemInfo
					where subcategory = @ITEM_SUBCATEGORY_PET
						  and itemcode not in ((select itemcode from dbo.tFVUserItem
				  							   where gameid = @gameid_
				  									 and invenkind = @invenkind
				  									 and petupgrade >= @USERITEM_PET_UPGRADE_MAX))
				) b
			where petrand < @petrand
			order by 1 desc
			--select 'DEBUG 1�� �������', @itemcode itemcode, @petrollcashcost petrollcashcost, @petupgradeinit petupgradeinit, @petmax petmax, @petrand petrand


			-- 2�� �������.
			if(@itemcode = -1)
				BEGIN
					select top 1
						@itemcode 			= itemcode,
						@petrollcashcost	= cashcost,
						@petupgradeinit		= param5
					from dbo.tFVItemInfo
					where subcategory = @ITEM_SUBCATEGORY_PET
						  and itemcode not in ((select itemcode from dbo.tFVUserItem
						  					   where gameid = @gameid_
						  					         and invenkind = @invenkind
						  					         and petupgrade >= @USERITEM_PET_UPGRADE_MAX))
						  order by newid()
					--select 'DEBUG 2�� �������', @itemcode itemcode, @petrollcashcost petrollcashcost, @petupgradeinit petupgradeinit, @petmax petmax, @petrand petrand
				END

			--select 'DEBUG [�̱���]', @itemcode itemcode, @petrollcashcost petrollcashcost, @petupgradeinit petupgradeinit

			------------------------------------------------------
			-- �̱��ڵ�(��) > ������ > �ش����� ����(����)
			------------------------------------------------------
			if(@itemcode = -1)
				BEGIN
					set @petrollmode = @PET_ROLL_MODE_NON
					--select 'DEBUG [�̱�]���̻����'
				END
			else
				BEGIN
					set @petupgrade		= -1
					select @petupgrade = petupgrade, @listidx = listidx from dbo.tFVUserItem
					where gameid = @gameid_ and itemcode = @itemcode and invenkind = @invenkind

					if(@petupgrade = -1)
						BEGIN
							set @petrollmode = @PET_ROLL_MODE_NEW
							--select 'DEBUG [�̱�] �ű�'
						END
					else
						BEGIN
							set @petrollmode = @PET_ROLL_MODE_UPGRADE
							--select 'DEBUG [�̱�] ����'
						END
				END


			if(@petrollmode = @PET_ROLL_MODE_NON)
				BEGIN
					set @nResult_ 	= @RESULT_ERROR_NO_MORE_PET
					set @comment = 'ERROR ���̻� ���� ���� �� �����ϴ�.'
					--select 'DEBUG ' + @comment
				END
			else if(@cashcost < @petrollcashcost)
				BEGIN
					set @nResult_ 	= @RESULT_ERROR_CASHCOST_LACK
					set @comment 	= 'ERROR ĳ���� �����մϴ�.'
					--select 'DEBUG ' + @comment
				END
			else
				BEGIN
					if(@petrollmode = @PET_ROLL_MODE_NEW)
						begin
							set @nResult_ = @RESULT_SUCCESS
							set @comment = 'SUCCESS [�̱� > NEW]���� ���� ó���մϴ�.'
							--select 'DEBUG ' + @comment

							--------------------------------------
							-- <���ŷ�ƾ>
							-- �걸��(�ʱ����)
							-- ĳ������, ���ŷα� ���, listidxrtn = new����
							--------------------------------------
							select @listidxnew = isnull(MAX(listidx), 0) + 1 from dbo.tFVUserItem where gameid = @gameid_
							--select 'DEBUG [��̱�]�κ� ����ȣ', @listidxnew listidxnew

							-- �걸�� > �߰�(�ʱ����)
							insert into dbo.tFVUserItem(gameid,      listidx,   itemcode, cnt,  invenkind,  petupgrade,      gethow)
							values(					 @gameid_, @listidxnew,  @itemcode,   1, @invenkind, @petupgradeinit, @DEFINE_HOW_GET_PETROLL)
							--select 'DEBUG [��̱�]����', @gameid_ gameid_, @listidxnew listidxnew, @itemcode itemcode, @invenkind invenkind, @petupgradeinit petupgradeinit, @DEFINE_HOW_GET_PETROLL DEFINE_HOW_GET_PETROLL

							-- �굵�����.
							--select 'DEBUG [��̱�]�굵�����.'
							exec spu_FVDogamListPetLog @gameid_, @itemcode

							-- ����� ������ ����Ʈ�ε���
							set @listidxrtn	= @listidxnew
						end
					else
						begin
							set @nResult_ = @RESULT_SUCCESS
							set @comment = 'SUCCESS [�̱� > Upgrade]���� ���� ó���մϴ�.'
							--select 'DEBUG ' + @comment

							--------------------------------------
							-- <����> �ش��� ����+1
							--------------------------------------
							update dbo.tFVUserItem
								set
									petupgrade = petupgrade + 1
							where gameid = @gameid_ and listidx = @listidx

							-- ����� ������ ����Ʈ�ε���
							set @listidxrtn	= @listidx
						end

					-- ĳ������ > �ϴܿ��� ����.
					--select 'DEBUG [��̱�]ĳ������(��)', @cashcost cashcost, @petrollcashcost petrollcashcost
					set @cashcost = @cashcost - @petrollcashcost
					--select 'DEBUG [��̱�]ĳ������(��)', @cashcost cashcost, @petrollcashcost petrollcashcost

					-- ���ű�ϸ�ŷ
					exec spu_FVUserItemBuyLog @gameid_, @itemcode, 0, @petrollcashcost
				END
		END
	else if (@mode_ = @USERITEM_MODE_PET_UPGRADE)
		BEGIN
			set @listidx = @paramint_
			select @itemcode = itemcode, @petupgrade = petupgrade from dbo.tFVUserItem
			where gameid = @gameid_ and listidx = @listidx and invenkind = @invenkind
			--select 'DEBUG [�����]', @listidx listidx, @itemcode itemcode, @petupgrade petupgrade

			if(@itemcode != -1 and @petupgrade < @USERITEM_PET_UPGRADE_MAX)
				begin
					select top 1
						@petupgradebase		= param7,
						@petupgradestep		= param8
					from dbo.tFVItemInfo
					where itemcode = @itemcode and subcategory = @ITEM_SUBCATEGORY_PET

					set @petupgradegamecost = @petupgradebase + @petupgrade * @petupgradestep

					--select 'DEBUG [�����]', @petupgradebase petupgradebase, @petupgradestep petupgradestep, @gamecost gamecost, @petupgradegamecost petupgradegamecost
				end

			if(@itemcode = -1)
				begin
					set @nResult_ 	= @RESULT_ERROR_LISTIDX_NOT_FOUND
					set @comment 	= 'ERROR ������ ����Ʈ ��ȣ�� �������� �ʽ��ϴ�.'
					--select 'DEBUG ' + @comment
				end
			else if(@petupgrade >= @USERITEM_PET_UPGRADE_MAX)
				BEGIN
					set @nResult_ 	= @RESULT_ERROR_UPGRADE_FULL
					set @comment 	= 'ERROR [�����]���׷��̵尡 Ǯ�Դϴ�.'
					--select 'DEBUG ' + @comment
				END
			else if(@gamecost < @petupgradegamecost)
				BEGIN
					set @nResult_ 	= @RESULT_ERROR_GAMECOST_LACK
					set @comment 	= 'ERROR ������ �����մϴ�.'
					--select 'DEBUG ' + @comment
				END
			else
				BEGIN
					set @nResult_ = @RESULT_SUCCESS
					set @comment = 'SUCCESS [�����]���� ���� ó���մϴ�.'
					--select 'DEBUG ' + @comment

					--------------------------------------
					-- <����> �ش��� ����+1
					--------------------------------------
					update dbo.tFVUserItem
						set
							petupgrade = petupgrade + 1
					where gameid = @gameid_ and listidx = @listidx

					-- ����� ������ ����Ʈ�ε���
					set @listidxrtn	= @listidx

					-- ĳ������ > �ϴܿ��� ����.
					--select 'DEBUG [�����]��������(��)', @gamecost gamecost, @petupgradegamecost petupgradegamecost
					set @gamecost = @gamecost - @petupgradegamecost
					--select 'DEBUG [�����]��������(��)', @gamecost gamecost, @petupgradegamecost petupgradegamecost
				END

		END
	else if (@mode_ = @USERITEM_MODE_PET_WEAR)
		BEGIN
			set @listidx = @paramint_
			select @itemcode = itemcode from dbo.tFVUserItem
			where gameid = @gameid_ and listidx = @listidx and invenkind = @invenkind

			--select 'DEBUG [�������]', @listidx listidx, @itemcode itemcode

			if(@itemcode = -1)
				begin
					set @nResult_ 	= @RESULT_ERROR_LISTIDX_NOT_FOUND
					set @comment 	= 'ERROR ������ ����Ʈ ��ȣ�� �������� �ʽ��ϴ�.'
					--select 'DEBUG ' + @comment
				end
			else
				begin
					set @nResult_ = @RESULT_SUCCESS
					set @comment = 'SUCCESS [����]���� ���� ó���մϴ�.'
					--select 'DEBUG ' + @comment

					------------------------------------
					-- ����Ʈ ��ȣ, ������ �ڵ� ����
					------------------------------------
					set @petlistidx 	= @listidx
					set @petitemcode 	= @itemcode
					set @petcooltime	= 0

					set @listidxrtn		= @petlistidx

					--select 'DEBUG > ������', @petlistidx petlistidx, @petitemcode petitemcode, @listidxrtn listidxrtn
				end
		END


	--------------------------------------------------------------
	-- 	�������
	--------------------------------------------------------------
	select @nResult_ rtn, @comment comment

	if(@nResult_ = @RESULT_SUCCESS)
		begin
			--------------------------------------------------------------
			-- �������� ���� �־���
			--------------------------------------------------------------
			update dbo.tFVUserMaster
			set
				cashcost	= @cashcost,
				gamecost	= @gamecost,

				petlistidx	= @petlistidx,
				petitemcode	= @petitemcode,
				petcooltime	= @petcooltime,
				pettodayitemcode	= @pettodayitemcode,
				pettodayitemcode2 	= @pettodayitemcode2
			where gameid = @gameid_

			--------------------------------------------------------------
			-- ���� ����
			--------------------------------------------------------------
			select * from dbo.tFVUserMaster
			where gameid = @gameid_

			--------------------------------------------------------------
			-- ���� ���� ������ ���� > ���� ȹ���� �͸� ����(������ �ϰ� ���� ������ Ŭ����� �����͸� �������� ������)
			--------------------------------------------------------------
			select * from dbo.tFVUserItem
			where gameid = @gameid_ and listidx = @listidxrtn
		end

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off
End

