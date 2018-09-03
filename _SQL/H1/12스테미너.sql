/*
gameid=xxx
mode=xxx

update dbo.tUserMaster set actioncount = 0, actiontime = '2012-01-01', goldball = 0 where gameid = 'SangSang'
update dbo.tUserMaster set actioncount = 1, actiontime = '2012-01-01', goldball = 0 where gameid = 'SangSang'
update dbo.tUserMaster set actioncount = 0, actiontime = '2012-01-01', goldball = 1000 where gameid = 'SangSang'
update dbo.tUserMaster set actioncount = 1, actiontime = '2012-01-01', goldball = 1000 where gameid = 'SangSang'
update dbo.tUserMaster set actioncount = 0, goldball = 1000 where gameid = 'SangSang'
update dbo.tUserMaster set actioncount = 1, goldball = 1000 where gameid = 'DD1'



exec spu_RechargeAction 'SangSangs', '7575970askeie1595312', 1, -1		-- �������� �ʴ� ���̵�
exec spu_RechargeAction 'SangSang', '7575970askeie1595312', 0, -1	
exec spu_RechargeAction 'SangSang', '7575970askeie1595312', 1, -1
exec spu_RechargeAction 'SangSang', '7575970askeie1595312', 2, -1
exec spu_RechargeAction 'SangSang', '7575970askeie1595312', 3, -1		-- �Ϸ繫���̿��
exec spu_RechargeAction 'DD1', 1, -1
exec spu_RechargeAction 'DD1', 2, -1
*/
 
IF OBJECT_ID ( 'dbo.spu_RechargeAction', 'P' ) IS NOT NULL 
    DROP PROCEDURE dbo.spu_RechargeAction;
GO 

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_RechargeAction
	@gameid_								varchar(20),					-- ���Ӿ��̵�
	@password_								varchar(20),
	@mode_									int,
	@nResult_								int					OUTPUT
	WITH ENCRYPTION -- ���ν����� ��ȣȭ��.
as	
	------------------------------------------------
	--	2-1. �ڵ尪�ڸ�
	------------------------------------------------	
	-- �Ϲݰ�
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1			
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1	
	
	--���� ����.
	declare @RESULT_ERROR_ID_DUPLICATE			int				set @RESULT_ERROR_ID_DUPLICATE			= -2			
	declare @RESULT_ERROR_EMAIL_DUPLICATE		int				set @RESULT_ERROR_EMAIL_DUPLICATE		= -3
	
	-- �α��� ����. 
	declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--������ > �˾�ó���� ��Ʈ�η� ��������.
	declare @RESULT_ERROR_DELETED_USER 			int				set @RESULT_ERROR_DELETED_USER			= -12			--�������� > �˾�ó���� ��Ʈ�η� ��������.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--�ش������� ã�� ����
	declare @RESULT_ERROR_NOT_FOUND_PASSWORD	int				set @RESULT_ERROR_NOT_FOUND_PASSWORD	= -17			
	declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--������ �����ϰ� �ִ�.
	declare @RESULT_NEWVERION_CLIENT_DOWNLOAD 	int				set @RESULT_NEWVERION_CLIENT_DOWNLOAD	= -15			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ��ũó��.
	declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ����.
	                                                                                                         			
	-- �����߿� ����.
	declare @RESULT_ERROR_ACTION_LACK			int				set @RESULT_ERROR_ACTION_LACK			= -20			--�ൿ���� �����ϴ�.
	declare @RESULT_ERROR_SILVERBALL_LACK		int				set @RESULT_ERROR_SILVERBALL_LACK		= -21			--�ǹ��� �����ϴ�.
	declare @RESULT_ERROR_GOLDBALL_LACK			int				set @RESULT_ERROR_GOLDBALL_LACK			= -22			--��尡 �����ϴ�.
	declare @RESULT_ERROR_ITEM_LACK				int				set @RESULT_ERROR_ITEM_LACK				= -23			--�������̺����ϴ�.
	declare @RESULT_ERROR_COIN_LACK				int				set @RESULT_ERROR_COIN_LACK				= -24			--������ �����ϴ�.

	-- ������ ����, ����.                                                                                                   			
	declare @RESULT_ERROR_BUY_ALREADY			int				set @RESULT_ERROR_BUY_ALREADY			= -31			--�̹� �����߽��ϴ�.
	declare @RESULT_ERROR_NOT_HAVE				int				set @RESULT_ERROR_NOT_HAVE				= -32			--�������� �ʰ� �ִ�.
	declare @RESULT_ERROR_UPGRADE_CANNT			int				set @RESULT_ERROR_UPGRADE_CANNT			= -33			--���׷��̵带 �Ҽ� ����.						
	declare @RESULT_ERROR_UPGRADE_FAIL			int				set @RESULT_ERROR_UPGRADE_FAIL			= -34			--���׷��̵� ����.
	declare @RESULT_ERROR_UPGRADE_FULL			int				set @RESULT_ERROR_UPGRADE_FULL			= -35			--���׷��̵尡 Ǯ�εǾ���.
	declare @RESULT_ERROR_ITEM_EXPIRE			int				set @RESULT_ERROR_ITEM_EXPIRE			= -36			--�������� ���� �Ǿ���.
	declare @RESULT_ERROR_ITEM_NOSALE_KIND		int				set @RESULT_ERROR_ITEM_NOSALE_KIND		= -37			--�Ǹ����� �ʴ� ������
	declare @RESULT_ERROR_ITEM_PERMANENT_ALREADY int			set @RESULT_ERROR_ITEM_PERMANENT_ALREADY = -38			-- �������� �̹� �����߽��ϴ�.
	declare @RESULT_ERROR_ITEM_NOCHANGE_KIND	int				set @RESULT_ERROR_ITEM_NOCHANGE_KIND	= -39			--��ü����Ұ���

	-- ĳ������.
	declare @RESULT_ERROR_CASH_COPY				int				set @RESULT_ERROR_CASH_COPY				= -40			
	declare @RESULT_ERROR_CASH_OVER				int				set @RESULT_ERROR_CASH_OVER				= -41			
	declare @RESULT_ERROR_MONTH_OVER			int				set @RESULT_ERROR_MONTH_OVER			= -42			--�Ѵ޵��� �����ѵ��� �˻�

	-- �����ۼ���
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- �������ڵ��ã��
	declare @RESULT_ERROR_GIFTITEM_NOT_FOUND	int				set @RESULT_ERROR_GIFTITEM_NOT_FOUND	= -51			-- ������������ ��ã��
	declare @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	int				set @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	= -52			-- ������ �̹� ������
	
	-- ��Ÿ����
	declare @RESULT_ERROR_RESULT_COPY			int				set @RESULT_ERROR_RESULT_COPY			= -53			-- ���ī�ǽõ�
	declare @RESULT_ERROR_SILVER_COPY			int				set @RESULT_ERROR_SILVER_COPY			= -54			-- �ǹ�ī�ǽõ�
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- ���������ʴ¸��
	declare @RESULT_ERROR_ACTION_FULL			int				set @RESULT_ERROR_ACTION_FULL			= -71			-- ���������ʴ¸��
	
	------------------------------------------------
	--	2-2. ���°�
	------------------------------------------------	
	-- ���°�.
	declare @BLOCK_STATE_NO						int				set	@BLOCK_STATE_NO						= 0				-- �����¾ƴ�
	declare @BLOCK_STATE_YES					int				set	@BLOCK_STATE_YES					= 1				-- ������
	declare @DELETE_STATE_NO					int				set	@DELETE_STATE_NO					= 0				-- �������¾ƴ�
	declare @DELETE_STATE_YES					int				set	@DELETE_STATE_YES					= 1				-- ��������

	-- ����ó�ڵ�
	declare @MARKET_SKT							int				set @MARKET_SKT							= 1
	declare @MARKET_KT							int				set @MARKET_KT							= 2
	declare @MARKET_LGT							int				set @MARKET_LGT							= 3
	declare @MARKET_FACEBOOK					int				set @MARKET_FACEBOOK					= 4
	declare @MARKET_GOOGLE						int				set @MARKET_GOOGLE						= 5

	-- �ý��� üŷ
	declare @SYSCHECK_NON						int				set @SYSCHECK_NON						= 0
	declare @SYSCHECK_YES						int				set @SYSCHECK_YES						= 1

	-- ������������
	declare @GAINSTATE_NON						int				set @GAINSTATE_NON						= 0
	declare @GAINSTATE_YES						int				set @GAINSTATE_YES						= 1
	
	-- ��������Ʈ�̸�
	declare @ITEM_KIND_CHARACTER				int 			set @ITEM_KIND_CHARACTER				= 0
	declare @ITEM_KIND_FACE						int 			set @ITEM_KIND_FACE						= 1			-- �Ǹ��۾ƴ�
	declare @ITEM_KIND_CAP						int 			set @ITEM_KIND_CAP						= 2
	declare @ITEM_KIND_UPPER					int 			set @ITEM_KIND_UPPER					= 4
	declare @ITEM_KIND_UNDER					int 			set @ITEM_KIND_UNDER					= 5
	declare @ITEM_KIND_BAT						int 			set @ITEM_KIND_BAT						= 6
	declare @ITEM_KIND_GLASSES					int 			set @ITEM_KIND_GLASSES					= 7
	declare @ITEM_KIND_WING						int 			set @ITEM_KIND_WING						= 8
	declare @ITEM_KIND_TAIL						int 			set @ITEM_KIND_TAIL						= 9
	declare @ITEM_KIND_STADIUM					int 			set @ITEM_KIND_STADIUM					= 100
	declare @ITEM_KIND_CUSTOMIZE				int 			set @ITEM_KIND_CUSTOMIZE				= 22		-- �ǸŹ���� �ٸ�
	declare @ITEM_KIND_PET						int 			set @ITEM_KIND_PET						= 80
	declare @ITEM_KIND_BATTLEITEM				int 			set @ITEM_KIND_BATTLEITEM				= 90
	declare @ITEM_KIND_SYSTEMETC				int 			set @ITEM_KIND_SYSTEMETC				= 99
	
	-- ��Ÿ ���ǰ�
	declare @ITEM_PERMANENT_START_DAY			datetime		set @ITEM_PERMANENT_START_DAY			= '2012-01-01'	-- �����۽���
	declare @ITEM_PERMANENT_ADD_YEAR			int				set @ITEM_PERMANENT_ADD_YEAR			= 50			-- �����۱Ⱓ
	declare @ITEM_PERIOD_PERMANENT				int 			set @ITEM_PERIOD_PERMANENT				= -1			-- ���̺� -1�̶� ��ϵ�

	--�����۸���
	declare @ITEM_EXPIRE_STATE_NO				int 			set @ITEM_EXPIRE_STATE_NO				= 0			
	declare @ITEM_EXPIRE_STATE_YES				int				set @ITEM_EXPIRE_STATE_YES				= 1

	-- �������� �����ΰ� ���� ���.
	declare @COIN_RESULT_SILVER_ITEM			int				set @COIN_RESULT_SILVER_ITEM 			= 1;
	declare @COIN_RESULT_PERIOD_ITEM			int				set	@COIN_RESULT_PERIOD_ITEM			= 2;
	declare @COIN_RESULT_BATTLE_ITEM1			int				set	@COIN_RESULT_BATTLE_ITEM1			= 3;
	declare @COIN_RESULT_BATTLE_ITEM2			int				set	@COIN_RESULT_BATTLE_ITEM2			= 4;
	declare @COIN_RESULT_BATTLE_ITEM3			int				set	@COIN_RESULT_BATTLE_ITEM3			= 5;
	declare @COIN_RESULT_BATTLE_ITEM4			int				set	@COIN_RESULT_BATTLE_ITEM4			= 6;
	declare @COIN_RESULT_BATTLE_ITEM5			int				set	@COIN_RESULT_BATTLE_ITEM5			= 7;
	
	-- �׼�����
	declare @MODE_ACTION_RECHARGE_FULL			int				set	@MODE_ACTION_RECHARGE_FULL			= 1;
	declare @MODE_ACTION_RECHARGE_HALF			int				set	@MODE_ACTION_RECHARGE_HALF			= 2;
	declare @MODE_ACTION_RECHARGE_FREE			int				set	@MODE_ACTION_RECHARGE_FREE			= 3;	
	declare @ITEMCODE_ACTION_RECHARGE_FULL		int				set	@ITEMCODE_ACTION_RECHARGE_FULL		= 7000;
	declare @ITEMCODE_ACTION_RECHARGE_HALF		int				set	@ITEMCODE_ACTION_RECHARGE_HALF		= 7001;
	declare @ITEMCODE_ACTION_RECHARGE_FREE		int				set	@ITEMCODE_ACTION_RECHARGE_FREE		= 7004;
	
	
	-- Ÿ���� ����
	declare @LOOP_TIME_ACTION				int 			set @LOOP_TIME_ACTION 				= 3*60			-- �ൿ�� 3�п� �Ѱ��� ä����
	declare @LOOP_TIME_SMS					int 			set @LOOP_TIME_SMS 					= 40*60			-- SMS 40�п� �ѹ���
	declare @LOOP_TIME_FRIENDLS				int 			set @LOOP_TIME_FRIENDLS				= 20*60			-- ģ����Ŀ��ǹ� 20M�п� �Ѱ��� ä����

	------------------------------------------------
	--	2-3. ���λ�� ����
	------------------------------------------------
	declare @gameid				varchar(20)
	declare @comment			varchar(80)

	declare @actioncount		int
	declare @actioncount2		int
	declare	@actionmax			int
	declare @actiontime			datetime
	declare @actionfreedate		datetime
	declare @goldball			int
	declare @goldball2			int
	declare @itemcode			int
	
	declare @goldballFullPrice		int				set @goldballFullPrice		= 10
	declare @goldballHalfPrice		int				set @goldballHalfPrice		= 6
	declare @goldballFreePrice		int				set @goldballFreePrice		= 50
	declare @freeModePeriod			int				set @freeModePeriod			= 1
	
	declare @goldballPrice		int					set @goldballPrice 			= 0
	declare @silverballPrice 	int					set @silverballPrice		= 0
	
	
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR	
	set @comment = 'ERROR �˼����� ����(-1)'
	--select 'DEBUG 1-0', @gameid_ gameid_, @password_ password_, @mode_ mode_, @nResult_ nResult_

	------------------------------------------------
	--	���� �����о����
	------------------------------------------------
	--���� ������ �о����
	select 
		@gameid = gameid,
		@actioncount = actioncount, @actionmax = actionmax, @actiontime = actiontime,
		@actionfreedate = actionfreedate,
		@actioncount2 = actioncount,
		@goldball = goldball, @goldball2 = goldball
	from dbo.tUserMaster where gameid = @gameid_ and password = @password_
	--select 'DEBUG 1-1', @gameid gameid, @actioncount actioncount, @actionmax actionmax, @actiontime actiontime, @actionfreedate actionfreedate, @actioncount2 actioncount2, @goldball goldball, @goldball2 goldball2
	
	------------------------------------------------
	--	������ ���� �о���� > �����б�(����)
	--	������ ���� ���̺��� �����ϱ�	
	------------------------------------------------
	select top 1
		@goldballFullPrice = fullmodeprice, 
		@goldballHalfPrice = halfmodeprice, 
		@goldballFreePrice = freemodeprice, 
		@freeModePeriod = freemodeperiod
	from dbo.tActionInfo where flag = 1 order by idx desc
	
	---- 1. Ŀ������
	--declare @goldball3 int
	--declare @itemcode3 int
	--declare curItemInfo Cursor for 
	--select goldball, itemcode from dbo.tItemInfo where itemcode in (@ITEMCODE_ACTION_RECHARGE_FULL, @ITEMCODE_ACTION_RECHARGE_HALF, @ITEMCODE_ACTION_RECHARGE_FREE)
	----select 'DEBUG 1-2', @ITEMCODE_ACTION_RECHARGE_FULL, @ITEMCODE_ACTION_RECHARGE_HALF, @ITEMCODE_ACTION_RECHARGE_FREE
	--
	---- 2. Ŀ������
	--open curItemInfo
	--
	---- 3. Ŀ�� ���
	--Fetch next from curItemInfo into @goldball3, @itemcode3
	--while @@Fetch_status = 0
	--	Begin	
	--		--select 'DEBUG 1-3', @goldball3 goldball3
	--		if(@itemcode3 = @ITEMCODE_ACTION_RECHARGE_FULL)
	--			set @goldballFullPrice = @goldball3
	--		else if(@itemcode3 = @ITEMCODE_ACTION_RECHARGE_HALF)
	--			set @goldballHalfPrice = @goldball3
	--		else if(@itemcode3 = @ITEMCODE_ACTION_RECHARGE_FREE)
	--			set @goldballFreePrice = @goldball3
	--		Fetch next from curItemInfo into @goldball3, @itemcode3
	--	end
	--
	---- 4. Ŀ���ݱ�
	--close curItemInfo
	--Deallocate curItemInfo
	----select 'DEBUG 1-4', @mode_ mode_, @goldballFullPrice goldballFullPrice, @goldballHalfPrice goldballHalfPrice, @goldballFreePrice goldballFreePrice
	
	------------------------------------------------
	--	�ൿ�� > �þ �ð��ΰ�? �˻� > ����
	------------------------------------------------
	declare @nActPerMin bigint,
			@nActCount int, 					
			@dActTime datetime
	set @nActPerMin = @LOOP_TIME_ACTION						-- �ൿ�� 2�п� �Ѱ��� ä����
	set @nActCount = datediff(s, @actiontime, getdate())/@nActPerMin
	set @dActTime = DATEADD(s, @nActCount*@nActPerMin, @actiontime)
	set @actioncount = @actioncount + @nActCount
	set @actioncount = case when @actioncount > @actionmax then @actionmax else @actioncount end
	--select 'DEBUG �ൿġ����', @actioncount '�����ൿġ(�ð���)', @actiontime '���Žð���',  @actionmax '�ൿġ�ƽ���', @dActTime '���Žð�'
	
	
	------------------------------------------------
	-- 3-3. �� ���Ǻ� �б�
	------------------------------------------------
	if isnull(@gameid, '') = ''
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment = 'ERROR �������� �ʴ� ���̵� �Դϴ�.'
			--select 'DEBUG 2-1', @comment
		END
	else if (@mode_ not in (@MODE_ACTION_RECHARGE_HALF, @MODE_ACTION_RECHARGE_FULL, @MODE_ACTION_RECHARGE_FREE))
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment = 'ERROR �������� �ʴ� ����Դϴ�.'
			--select 'DEBUG 3-1', @comment
		END
	else if(@actioncount2 >= @actionmax and @mode_ != @MODE_ACTION_RECHARGE_FREE)
		BEGIN
			set @nResult_ = @RESULT_ERROR_ACTION_FULL
			set @comment = 'ERROR �ൿġ�� �ƽ��Դϴ�.'
			--select 'DEBUG 4-1', @comment
		END
	else if ((@mode_ = @MODE_ACTION_RECHARGE_FULL 		and @goldball < @goldballFullPrice) 
		 or ( @mode_ = @MODE_ACTION_RECHARGE_HALF 		and @goldball < @goldballHalfPrice) 
		 or ( @mode_ = @MODE_ACTION_RECHARGE_FREE 		and @goldball < @goldballFreePrice) )
		BEGIN
			set @nResult_ = @RESULT_ERROR_GOLDBALL_LACK
			set @comment = 'ERROR ��纼�� ����'
			--select 'DEBUG 5-1', @comment
		END
	else if (@mode_ = @MODE_ACTION_RECHARGE_HALF and @goldball >= @goldballHalfPrice)
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS ��� > �ൿġ ��������'
			--select 'DEBUG 6-1', @comment
			
			set @goldball = @goldball - @goldballHalfPrice
			set @actioncount = @actioncount + @actionmax/2
			if(@actionmax%2 = 1)
				begin
					-- �ݿø��ؼ� �������ش�.
					set @actioncount = @actioncount + 1
				end
			set @itemcode = @ITEMCODE_ACTION_RECHARGE_HALF
			
			set @goldballPrice = @goldballHalfPrice
		END
	else if (@mode_ = @MODE_ACTION_RECHARGE_FULL and @goldball >= @goldballFullPrice)
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS ��� > �ൿġ Ǯ����'
			--select 'DEBUG 7-1', @comment
			
			set @goldball = @goldball - @goldballFullPrice
			set @actioncount = @actioncount + @actionmax
			set @itemcode = @ITEMCODE_ACTION_RECHARGE_FULL
			
			set @goldballPrice = @goldballFullPrice
		END
	else if (@mode_ = @MODE_ACTION_RECHARGE_FREE and @goldball >= @goldballFreePrice)
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS ��� > �ൿġ �Ϸ繫����'
			--select 'DEBUG 8-1', @comment
			
			set @goldball = @goldball - @goldballFreePrice
			set @actioncount = @actioncount + @actionmax
			set @itemcode = @ITEMCODE_ACTION_RECHARGE_FREE
			

			if(@actionfreedate < getdate())
				begin
					--select 'DEBUG 8-2 > ���ú��� �Ϸ�'
					set @actionfreedate = getdate()
				end
			else
				begin
					--select 'DEBUG 8-3 > ���� �ð��� �־� �߰�'
					set @actionfreedate = @actionfreedate
				end
			
			--set @actionfreedate = DATEADD(dd, 1, @actionfreedate)
			set @actionfreedate = DATEADD(dd, @freeModePeriod, @actionfreedate)
			
			
			set @goldballPrice = @goldballFreePrice
		END



	------------------------------------------------
	-- 4-1. �� ���Ǻ� �б� > ������
	------------------------------------------------
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			---------------------------------------------------------
			-- �ڵ����
			---------------------------------------------------------
			select @nResult_ rtn, @comment
			
			---------------------------------------------------------
			-- �ൿġ �ƽ� �ʰ����� �ʵ��� ����
			---------------------------------------------------------
			set @actioncount = case 
									when @actioncount > @actionmax then @actionmax 
									when @actioncount < 0 then 0
									else @actioncount
								end
			
			---------------------------------------------------------
			-- �����������
			---------------------------------------------------------			
			--select 'DEBUG (��)', actioncount, actiontime, goldball from dbo.tUserMaster where gameid = @gameid
			update dbo.tUserMaster
			set
				goldball		= @goldball,
				actioncount		= @actioncount,
				actiontime		= @dActTime,
				actionfreedate 	= @actionfreedate
			where gameid = @gameid_			
			--select 'DEBUG (��)', actioncount, actiontime, goldball from dbo.tUserMaster where gameid = @gameid
			
			---------------------------------------------------------
			-- �ൿġ���ŷα� ����ϱ�
			---------------------------------------------------------
			insert into dbo.tItemBuyLog(gameid, itemcode, goldball, silverball) 
			values(@gameid, @itemcode, @goldball2 - @goldball, 0)
			
			
			---------------------------------------------------
			-- ��Ż�α� ����ϱ�
			---------------------------------------------------
			declare @dateid varchar(8)
			set @dateid = Convert(varchar(8),Getdate(),112)		-- 20120819
			if(exists(select top 1 * from dbo.tItemBuyLogTotalSub where dateid = @dateid and itemcode = @itemcode))
				begin
					update dbo.tItemBuyLogTotalSub 
						set 
							goldball = goldball + @goldballPrice, 
							silverball = silverball + @silverballPrice, 
							cnt = cnt + 1
					where dateid = @dateid and itemcode = @itemcode
				end
			else
				begin
					insert into dbo.tItemBuyLogTotalSub(dateid, itemcode, goldball, silverball, cnt)
					values(@dateid, @itemcode, @goldballPrice, @silverballPrice, 1)
				end
				
			
			---------------------------------------------------------
			-- ����ǹ�, �ν��͸�� �αױ��
			---------------------------------------------------------
			if(exists(select top 1 * from dbo.tItemBuyPromotionTotal where dateid = @dateid and itemcode = @itemcode))
				begin
					update dbo.tItemBuyPromotionTotal 
						set 
							goldball = goldball + @goldballPrice,
							cnt = cnt + 1
					where dateid = @dateid and itemcode = @itemcode
				end
			else
				begin
					insert into dbo.tItemBuyPromotionTotal(dateid, itemcode, goldball, cnt)
					values(@dateid, @itemcode, @goldballPrice, 1)
				end

		end
	else
		begin 
			---------------------------------------------------------
			-- �ڵ����
			---------------------------------------------------------
			select @nResult_ rtn, @comment
			return;
		end

	------------------------------------------------
	--	4-2. ��������
	------------------------------------------------		
	select * from dbo.tUserMaster where gameid = @gameid_
	set nocount off
End

