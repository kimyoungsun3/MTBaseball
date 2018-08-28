/*
delete from dbo.tGiftList where gameid = 'xxxx2'
update dbo.tUserMaster set gamecost = 100000, gameyear = 2826 where gameid = 'xxxx2'
update dbo.tUserFarm set buystate = -1 where gameid = 'xxxx2' and itemcode = 6930
exec spu_UserFarm 'xxxx2', '049000s1i0n7t8445289',  1, 6901, -1		-- ����
exec spu_UserFarm 'xxxx2', '049000s1i0n7t8445289',  1, 6930, -1		-- ����

update dbo.tUserFarm set incomedate = getdate() - 0.1, buystate = 1 where gameid = 'xxxx2' and itemcode = 6900
exec spu_UserFarm 'xxxx2', '049000s1i0n7t8445289',  2, 6900, -1		-- ����

update dbo.tUserFarm set incomedate = getdate() - 1 where gameid = 'xxxx2'
update dbo.tUserMaster set gamecost = 0 where gameid = 'xxxx2'
exec spu_UserFarm 'xxxx2', '049000s1i0n7t8445289',  22, -1, -1		-- All����

update dbo.tUserFarm set incomedate = getdate() - 0.1, buystate = 1 where gameid = 'xxxx2' and itemcode = 6900
exec spu_UserFarm 'xxxx2', '049000s1i0n7t8445289',  3, 6900, -1		-- �Ǹ�
*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_UserFarm', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_UserFarm;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_UserFarm
	@gameid_								varchar(20),					-- ���Ӿ��̵�
	@password_								varchar(20),
	@mode_									int,
	@itemcode_								int,
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
	declare @RESULT_ERROR_FPOINT_LACK			int				set @RESULT_ERROR_FPOINT_LACK			= -124			--

	-- ��Ÿ����
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- ���������ʴ¸��
	declare @RESULT_ERROR_NOT_FOUND_USERFARM	int				set @RESULT_ERROR_NOT_FOUND_USERFARM	= -125			-- ���帮��Ʈ�� �̱���.

	------------------------------------------------
	--	2-2. ���°�
	------------------------------------------------
	-- ������ ��з�
	declare @ITEM_MAINCATEGORY_USERFARM			int					set @ITEM_MAINCATEGORY_USERFARM 			= 69 	--��������(69)

	-- ������ �Һз�
	declare @ITEM_SUBCATEGORY_USERFARM			int					set @ITEM_SUBCATEGORY_USERFARM	 			= 69 -- ��������

	-- ���� ���ǰ�
	--declare @GIFTLIST_GIFT_KIND_MESSAGE		int					set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2
	--declare @GIFTLIST_GIFT_KIND_MESSAGE_DEL	int					set @GIFTLIST_GIFT_KIND_MESSAGE_DEL			= -1
	--declare @GIFTLIST_GIFT_KIND_GIFT_DEL		int					set @GIFTLIST_GIFT_KIND_GIFT_DEL			= -2
	--declare @GIFTLIST_GIFT_KIND_GIFT_GET		int					set @GIFTLIST_GIFT_KIND_GIFT_GET			= -3
	--declare @GIFTLIST_GIFT_KIND_GIFT_SELL		int					set @GIFTLIST_GIFT_KIND_GIFT_SELL			= -4

	-- ������
	declare @USERFARM_MODE_BUY					int					set @USERFARM_MODE_BUY						= 1
	declare @USERFARM_MODE_INCOME				int					set @USERFARM_MODE_INCOME					= 2
	declare @USERFARM_MODE_INCOME_ALL			int					set @USERFARM_MODE_INCOME_ALL				= 22
	declare @USERFARM_MODE_SELL					int					set @USERFARM_MODE_SELL						= 3

	-- ����(����).
	declare @USERFARM_BUYSTATE_NOBUY			int					set @USERFARM_BUYSTATE_NOBUY				= -1	-- (����)
	declare @USERFARM_BUYSTATE_BUY				int					set @USERFARM_BUYSTATE_BUY					=  1

	------------------------------------------------
	--	2-3. ���λ�� ����
	------------------------------------------------
	declare @gameid			varchar(20)				set @gameid			= ''
	declare @market			int						set @market			= 5
	declare @version		int						set @version		= 101
	declare @comment		varchar(128)
	declare @cashcost		int						set @cashcost		= 0
	declare @gamecost		int						set @gamecost		= 0
	declare @feed			int						set @feed			= 0
	declare @fpoint			int						set @fpoint			= 0
	declare @heart			int						set @heart			= 0
	declare @gameyear		int						set @gameyear		= 2013
	declare @rewarditemcode	int						set @rewarditemcode	= -1
	declare @rewardcnt		int						set @rewardcnt		= 0

	declare @buystate		int						set @buystate		= -444
	declare @incomedate		datetime				set @incomedate		= getdate()
	declare @incomegamecost	int						set @incomegamecost	= 0
	declare @incomegamecost2	int					set @incomegamecost2	= 0
	declare @buycount		int						set @buycount	= 0

	declare @gamecostorg	int						set @gamecostorg	= -444
	declare @gamecostcur	int						set @gamecostcur	= 0
	declare @hourcoin		int						set @hourcoin		= 0
	declare @maxcoin		int						set @maxcoin		= 0
	declare @raiseyear		int						set @raiseyear		= 0
	declare @raisepercent	int						set @raisepercent	= 0

	declare @gapyear		int
	declare @tmp			int
	declare @gaphour		int
	declare @farmidx		int

Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG �Է�����', @gameid_ gameid_, @password_ password_, @mode_ mode_, @itemcode_ itemcode_

	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	select
		@gameid 		= gameid,		@market			= market,		@version		= version,
		@cashcost		= cashcost,		@gamecost		= gamecost,
		@heart			= heart,		@feed			= feed,			@fpoint			= fpoint,
		@gameyear		= gameyear
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG ��������', @gameid gameid, @cashcost cashcost, @gamecost gamecost, @heart heart, @feed feed, @fpoint fpoint, @gameyear gameyear


	select
		@buystate		= buystate,
		@incomedate		= incomedate,
		@buycount		= buycount
	from dbo.tUserFarm
	where gameid = @gameid_ and itemcode = @itemcode_
	--select 'DEBUG ���� ��������', @buystate buystate, @incomedate incomedate

	select
		@gamecostorg 	= gamecost,
		@hourcoin		= param1,
		@maxcoin		= param2,
		@raiseyear		= param3,
		@raisepercent	= param4,
		@rewarditemcode	= param11,
		@rewardcnt		= param12
	from dbo.tItemInfo
	where itemcode = @itemcode_ and subcategory = @ITEM_SUBCATEGORY_USERFARM
	--select 'DEBUG ���� �Ϲ�����', @gamecostorg gamecostorg, @hourcoin hourcoin, @maxcoin maxcoin, @raiseyear raiseyear, @raisepercent raisepercent, @rewardcnt rewardcnt


	------------------------------------------------
	-- �ε������簡.
	------------------------------------------------
	set @gapyear		= case
								when (@gameyear - @raiseyear < 0) then 0
								else                                   (@gameyear - @raiseyear)
						  end
	set @gamecostcur 	= @gamecostorg + @gamecostorg * @raisepercent * @gapyear / 100
	--select 'DEBUG �ε������簡', @gapyear gapyear, @gamecostcur gamecostcur

	------------------------------------------------
	-- 3-3. �� ���Ǻ� �б�
	------------------------------------------------
	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR ���̵� �������� �ʴ´�.'
			--select 'DEBUG ' + @comment
		END
	else if (@mode_ not in (@USERFARM_MODE_BUY, @USERFARM_MODE_INCOME, @USERFARM_MODE_INCOME_ALL, @USERFARM_MODE_SELL))
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment 	= 'ERROR �������� �ʴ� ����Դϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if ((@mode_ != @USERFARM_MODE_INCOME_ALL) and (@buystate = -444 or @gamecostorg = -444))
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment 	= 'ERROR �������� �ʴ� ����Դϴ�(2).'
			--select 'DEBUG ' + @comment
		END
	else if (@mode_ = @USERFARM_MODE_BUY)
		BEGIN
			------------------------------------------
			-- ���Ÿ��.
			------------------------------------------
			if(@gamecost < @gamecostcur)
				BEGIN
					set @nResult_ 	= @RESULT_ERROR_GAMECOST_LACK
					set @comment 	= 'ERROR ������ �����մϴ�.'
					--select 'DEBUG ' + @comment
				END
			else if(@buystate = @USERFARM_BUYSTATE_BUY)
				BEGIN
					set @nResult_ 	= @RESULT_SUCCESS
					set @comment 	= 'SUCCESS ���ż���(�̹̱���).'
					--select 'DEBUG ' + @comment
				END
			else
				BEGIN
					set @nResult_ 	= @RESULT_SUCCESS
					set @comment 	= 'SUCCESS ���ż���.'
					--select 'DEBUG ' + @comment

					---------------------------------------------
					-- ���űݾ�����.
					---------------------------------------------
					set @gamecost 	= @gamecost - @gamecostcur

					---------------------------------------------
					-- ���� ���� ���·� ����
					---------------------------------------------
					--select 'DEBUG ��', @@ROWCOUNT, * from dbo.tUserFarm where gameid = @gameid_ and itemcode = @itemcode_
					update dbo.tUserFarm
						set
							buystate	= @USERFARM_BUYSTATE_BUY,
							buydate		= getdate(),
							incomedate	= getdate(),
							buycount	= buycount + 1
					where gameid = @gameid_ and itemcode = @itemcode_
					--select 'DEBUG ��', @@ROWCOUNT, * from dbo.tUserFarm where gameid = @gameid_ and itemcode = @itemcode_

					---------------------------------------------
					-- ���ű�ϸ�ŷ
					---------------------------------------------
					if(@buycount = 0)
						begin
							exec spu_UserItemBuyLogNew @gameid_, @itemcode_, @gamecostcur, 0, 0
						end

					---------------------------------------------
					-- ������ �������.
					---------------------------------------------
					if(@rewarditemcode != -1)
						begin
							--select 'DEBUG �����ϱ�.', @rewarditemcode rewarditemcode, @rewardcnt rewardcnt
							exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT,  @rewarditemcode, @rewardcnt, 'FarmBuy', @gameid_, ''
						end

				END


		END
	else if (@mode_ = @USERFARM_MODE_INCOME)
		BEGIN
			------------------------------------------
			-- ���Ը��.
			------------------------------------------
			if(@buystate != @USERFARM_BUYSTATE_BUY)
				BEGIN
					set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_USERFARM
					set @comment 	= 'SUCCESS ������ �����ϰ� ���� �ʴ�.'
					--select 'DEBUG ' + @comment
				END
			else
				BEGIN
					set @nResult_ 	= @RESULT_SUCCESS
					set @comment 	= 'SUCCESS ���Ͱȱ� ����.'
					--select 'DEBUG ' + @comment


					set @gaphour 		= dbo.fnu_GetDatePart('hh', @incomedate, getdate())
					set @incomegamecost	= @gaphour * @hourcoin

					if(@incomegamecost >= @maxcoin)
						begin
							set @incomegamecost	= @maxcoin
							set @incomedate		= getdate()
						end
					else if(@incomegamecost < 0)
						begin
							set @incomegamecost	= 0
							set @incomedate		= getdate()
						end
					else
						begin
							set @incomegamecost	= @incomegamecost
							set @incomedate		= DATEADD(hour, @gaphour, @incomedate)
						end
					--select 'DEBUG ����', @incomegamecost incomegamecost, @incomedate incomedate


					-- ���ͱ��߰�.
					set @gamecost 	= @gamecost + @incomegamecost

					-- ���� �Ⱦ ���·�üŷ.
					update dbo.tUserFarm
						set
							incomedate 	= @incomedate,
							incomett	= incomett + @incomegamecost
					where gameid = @gameid_ and itemcode = @itemcode_

				END
		END
	else if (@mode_ = @USERFARM_MODE_INCOME_ALL)
		BEGIN
			------------------------------------------
			-- All���Ը��.
			------------------------------------------
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'SUCCESS ���Ͱȱ� ����.'
			--select 'DEBUG ' + @comment

			------------------------------------------
			-- 1. ������ ���� ������ �о���� > Ŀ���� �о ó��.
			------------------------------------------
			declare curFarmList Cursor for
			select farmidx, incomedate, buycount, gamecostorg, hourcoin, maxcoin, raiseyear, raisepercent
			from
					(select itemcode, farmidx, incomedate, buycount from dbo.tUserFarm where gameid = @gameid_ and buystate = @USERFARM_BUYSTATE_BUY) f
				JOIN
					(select itemcode, gamecost gamecostorg, param1 hourcoin, param2 maxcoin, param3 raiseyear, param4 raisepercent from dbo.tItemInfo where subcategory = @ITEM_SUBCATEGORY_USERFARM) i
				ON f.itemcode = i.itemcode

			-- 2. Ŀ������
			open curFarmList

			-- 3. Ŀ�� ���
			Fetch next from curFarmList into @farmidx, @incomedate, @buycount, @gamecostorg, @hourcoin, @maxcoin, @raiseyear, @raisepercent
			while @@Fetch_status = 0
				Begin
					--select 'DEBUG ', @farmidx farmidx, @incomedate incomedate, @buycount buycount, @gamecostorg gamecostorg, @hourcoin hourcoin, @maxcoin maxcoin, @raiseyear raiseyear, @raisepercent raisepercent

					set @gaphour 		= dbo.fnu_GetDatePart('hh', @incomedate, getdate())
					set @incomegamecost	= @gaphour * @hourcoin
					--select 'DEBUG ', @gaphour gaphour, @hourcoin hourcoin, @incomegamecost incomegamecost

					if(@incomegamecost >= @maxcoin)
						begin
							set @incomegamecost	= @maxcoin
							set @incomedate		= getdate()
							--select 'DEBUG ����', @incomegamecost incomegamecost, @incomedate incomedate

							-- ���ͱݴ���.
							set @incomegamecost2	= @incomegamecost2 + @incomegamecost

							-- ���� �Ⱦ ���·�üŷ.
							update dbo.tUserFarm
								set
									incomedate 	= @incomedate,
									incomett	= incomett + @incomegamecost
							where gameid = @gameid_ and farmidx = @farmidx
						end

					Fetch next from curFarmList into @farmidx, @incomedate, @buycount, @gamecostorg, @hourcoin, @maxcoin, @raiseyear, @raisepercent
				end

			-- 4. Ŀ���ݱ�
			close curFarmList
			Deallocate curFarmList

			-- ��ü ������� ���Ͱ���ؼ� �־��ֱ�.
			set @gamecost 		= @gamecost + @incomegamecost2
			set @incomegamecost	= @incomegamecost2

		END
	else if (@mode_ = @USERFARM_MODE_SELL)
		BEGIN
			------------------------------------------
			-- �ǸŸ��.
			------------------------------------------
			if(@buystate != @USERFARM_BUYSTATE_BUY)
				BEGIN
					set @nResult_ 	= @RESULT_SUCCESS
					set @comment 	= 'SUCCESS �Ǹż���(�̹��Ǹ�).'
					--select 'DEBUG ' + @comment
				END
			else
				BEGIN
					set @nResult_ 	= @RESULT_SUCCESS
					set @comment 	= 'SUCCESS �Ǹż���.'
					--select 'DEBUG ' + @comment

					-- ���űݾ�����.
					set @gamecost 	= @gamecost + @gamecostcur


					-- ���� ���� ���·� ����
					--select 'DEBUG ��', @@ROWCOUNT, * from dbo.tUserFarm where gameid = @gameid_ and itemcode = @itemcode_
					update dbo.tUserFarm
						set
							buystate	= @USERFARM_BUYSTATE_NOBUY
					where gameid = @gameid_ and itemcode = @itemcode_
					--select 'DEBUG ��', @@ROWCOUNT, * from dbo.tUserFarm where gameid = @gameid_ and itemcode = @itemcode_
				END
		END
	else
		begin
			set @nResult_ 	= @RESULT_ERROR
			set @comment 	= 'ERROR �˼����� ����(-1)'
		end


	--------------------------------------------------------------
	-- �������.
	--------------------------------------------------------------
	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost, @heart heart, @feed feed, @fpoint fpoint, @incomegamecost incomegamecost
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			--------------------------------------------------------------
			-- ���� ���º�ȭ�� ������ ó����.
			--	����, ����, �Ǹ�
			--------------------------------------------------------------
			update dbo.tUserMaster
				set
					gamecost	= @gamecost
			where gameid = @gameid_

			--------------------------------------------------------------
			-- ���帮��Ʈ ����
			--------------------------------------------------------------
			exec spu_UserFarmListNew @gameid_, 1, @market, @version

			--------------------------------------------------------------
			-- ����/���� ����Ʈ ����
			--------------------------------------------------------------
			if (@mode_ = @USERFARM_MODE_BUY and @rewarditemcode != -1)
				begin
					exec spu_GiftList @gameid_
				end

		end

	------------------------------------------------
	--	4-2. ��������
	------------------------------------------------
	set nocount off
End

