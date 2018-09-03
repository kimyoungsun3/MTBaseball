/*
gameid=xxx
password=xxx
goldball=xxx


exec spu_CashChange 'NotFound', 'a1s2d3f4', 20, -1		-- ���̵� ����
exec spu_CashChange 'SangSang', 'passerror', 20, -1		-- �н����� ����
-- update  dbo.tUserMaster set goldball = 0 where gameid = 'SangSang'
-- update  dbo.tUserMaster set goldball = 1000 where gameid = 'SangSang'
exec spu_CashChange 'SangSang', '7575970askeie1595312', 20, -1		-- ����ȯ��
exec spu_CashChange 'SangSang', '7575970askeie1595312', 50, -1
exec spu_CashChange 'SangSang', '7575970askeie1595312', 100, -1
exec spu_CashChange 'SangSang', '7575970askeie1595312', 300, -1
exec spu_CashChange 'SangSang', '7575970askeie1595312', 500, -1
*/

IF OBJECT_ID ( 'dbo.spu_CashChange', 'P' ) IS NOT NULL 
    DROP PROCEDURE dbo.spu_CashChange;
GO 

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_CashChange
	@gameid_								varchar(20),					-- ���Ӿ��̵�
	@password_								varchar(20),
	@goldballChange_						int,
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
	declare @ITEM_KIND_CUSTOMIZE				int 			set @ITEM_KIND_CUSTOMIZE					= 22		-- �ǸŹ���� �ٸ�
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
	declare @ITEMCODE_ACTION_RECHARGE_FULL		int				set	@ITEMCODE_ACTION_RECHARGE_FULL		= 7000;
	declare @ITEMCODE_ACTION_RECHARGE_HALF		int				set	@ITEMCODE_ACTION_RECHARGE_HALF		= 7001;
	
	-- ģ���˻�, �߰�, ����
	declare @FRIEND_MODE_SEARCH					int				set	@FRIEND_MODE_SEARCH					= 1;
	declare @FRIEND_MODE_ADD					int				set	@FRIEND_MODE_ADD					= 2;
	declare @FRIEND_MODE_DELETE					int				set	@FRIEND_MODE_DELETE					= 3;
	declare @FRIEND_MODE_MYLIST					int				set	@FRIEND_MODE_MYLIST					= 4;
	declare @FRIEND_MODE_VISIT					int				set	@FRIEND_MODE_VISIT					= 5;
	
	------------------------------------------------
	--	2-3. ���λ�� ����
	------------------------------------------------
	declare @gameid			varchar(20)
	declare @password		varchar(20)
	declare @goldball		int
	declare @silverball		int
	declare @silverball2	int
	declare @plussilverball	int					set @plussilverball	= 0

Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on

	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	select 	@gameid = gameid, @password = password, @goldball = goldball, @silverball = silverball
	from dbo.tUserMaster where gameid = @gameid_
	
	if(isnull(@gameid, '') = '')
		begin
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
			select @nResult_ rtn, 'ERROR ���̵� ã�� ���߽��ϴ�.'
		end
	else if(@password != @password_)
		begin
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_PASSWORD
			select @nResult_ rtn, 'ERROR �н����尡 ��ġ���� �ʽ��ϴ�.'
		end
	else if(@goldballChange_ < 20)
		begin
			set @nResult_ = @RESULT_ERROR_GOLDBALL_LACK
			select @nResult_ rtn, 'ERROR ��纼�� �����մϴ�.'

			-- ȯ���̻��ൿ�� �ؼ� > ��ó��, ���αױ��
			update dbo.tUserMaster 
				set 
					blockstate = @BLOCK_STATE_YES,
					cashcopy = 0
			where gameid = @gameid_

			-- ������3ȸ ī�ǿ� ���� ��ó��
			insert into dbo.tUserBlockLog(gameid, comment)
			values(@gameid_, 'ĳ��ȯ������ ī�Ǹ� �ؼ� �ý��ۿ��� �� ó���߽��ϴ�. ���:' + ltrim(rtrim(str(@goldballChange_))) )	

		end
	else if(@goldball < @goldballChange_)
		begin
			set @nResult_ = @RESULT_ERROR_GOLDBALL_LACK
			select @nResult_ rtn, 'ERROR ��纼�� �����մϴ�.'
		end
	else if(@gameid = @gameid_ and @password = @password_ and @goldball >= @goldballChange_)
		begin
			-------------------------
			-- ȯ���ݾ� ���
			-------------------------
			declare @plus decimal(10, 1)
			set @plus = 0
			if(@goldballChange_ <= 20)
				begin
					set @plus = 0.1
				end
			else if(@goldballChange_ <= 50)
				begin
					set @plus = 0.2
				end
			else if(@goldballChange_ <= 100)
				begin
					set @plus = 0.3
				end
			else if(@goldballChange_ <= 300)
				begin
					set @plus = 0.4
				end
			else if(@goldballChange_ < 500)
				begin
					set @plus = 0.5
				end
			else 
				begin
					set @plus = 1.0
				end
				
			-------------------------------------------------
			--	�ǹ�ȯ�� ���
			-------------------------------------------------
			set @silverball2 = (@goldballChange_ * 200) + (@goldballChange_ * 200) * @plus
				
			-------------------------------------------------
			-- �߰� �ǹ����õǾ� �ִٸ�
			-------------------------------------------------
			select top 1 @plussilverball = plussilverball 
			from dbo.tActionInfo where flag = 1 
			order by idx desc
			if(@plussilverball > 0 and @plussilverball <= 100)
				begin
					set @silverball2 = @silverball2 + (@silverball2 * @plussilverball / 100)
				end
			
			-------------------------------------------------
			--	ȯ����� ����
			--	�߰� �ǹ� ����Plus
			-------------------------------------------------
			set @goldball =  @goldball - @goldballChange_
			set @silverball =  @silverball + @silverball2

			-------------------------
			-- ����ϱ�
			-------------------------
			set @nResult_ = @RESULT_SUCCESS
			select @nResult_ rtn, 'SUCCESS ȯ���߽��ϴ�.' + ltrim(str(@silverball2))

			
			-- ���� ������ �����Ѵ�.
			update dbo.tUserMaster
				set
					goldball = @goldball,
					silverball = @silverball
			where gameid = @gameid_
			
			---------------------------------------------
			-- ȯ���� ���
			---------------------------------------------
			insert into dbo.tCashChangeLog(gameid, goldball, silverball) 
			values(@gameid_, @goldballChange_, @silverball2)
			
			-- ��Ż�α� ����ϱ�
			declare @dateid varchar(8)
			set @dateid = Convert(varchar(8),Getdate(),112)		-- 20120819
			if(exists(select top 1 * from dbo.tCashChangeLogTotal where dateid = @dateid))
				begin
					update dbo.tCashChangeLogTotal 
						set 
							goldball = goldball + @goldballChange_, 
							silverball = silverball + @silverball2, 
							changecnt = changecnt + 1
					where dateid = @dateid
				end
			else
				begin
					insert into dbo.tCashChangeLogTotal(dateid, goldball, silverball, changecnt)
					values(@dateid, @goldballChange_, @silverball2, 1)
				end

			
			--���� ���� ����
			select * from dbo.tUserMaster where gameid = @gameid_
			
		end
	else 
		begin
			set @nResult_ = @RESULT_ERROR
			select @nResult_ rtn, 'ERROR �˼����� ����(-1)'
		end



	------------------------------------------------
	--	4-2. ��������
	------------------------------------------------		
	set nocount off
End

