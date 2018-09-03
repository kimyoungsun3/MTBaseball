/*
gameid=xxx
serialkey=xxx(����+�� > ĳ���ڵ�)
exec spu_GenReward 'Superman7', '7575970askeie1595313', 'xxxxxxxxxxx01', 1, -1
exec spu_GenReward 'Superman7', '7575970askeie1595312', 'xxxxxxxxxxx02', 2, -1

exec spu_GenReward 'Superman7', '7575970askeie1595312', 'xxxxxxxxxxx01', 1, -1
exec spu_GenReward 'Superman7', '7575970askeie1595312', 'xxxxxxxxxxx02', 1, -1
exec spu_GenReward 'Superman7', '7575970askeie1595312', 'xxxxxxxxxxx03', 1, -1
exec spu_GenReward 'Superman7', '7575970askeie1595312', 'xxxxxxxxxxx04', 1, -1

*/ 

IF OBJECT_ID ( 'dbo.spu_GenReward', 'P' ) IS NOT NULL 
    DROP PROCEDURE dbo.spu_GenReward;
GO 

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_GenReward
	@gameid_								varchar(20),					-- ���Ӿ��̵�
	@password_								varchar(20),
	@serialkey_								varchar(256),
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
	declare @RESULT_ERROR_WIN_LACK				int				set @RESULT_ERROR_WIN_LACK				= -72			-- ������Ʈ ����.
	declare @RESULT_ERROR_TUTORIAL_ALREADY		int				set @RESULT_ERROR_TUTORIAL_ALREADY		= -73			-- ���丮�� �̹� ����.
	declare @RESULT_ERROR_FRIEND_ADD_MYGAMEID	int				set @RESULT_ERROR_FRIEND_ADD_MYGAMEID	= -74	
	declare @RESULT_ERROR_NOT_FOUND_GIFTID		int				set @RESULT_ERROR_NOT_FOUND_GIFTID		= -75			-- ĳ�� > ������ ���̵� ��ã��
	
	declare @RESULT_ERROR_SMS_NOT_MATCH_PHONE	int				set @RESULT_ERROR_SMS_NOT_MATCH_PHONE	= -80			--������õ. 
	declare @RESULT_ERROR_SMS_KEY_DUPLICATE		int				set @RESULT_ERROR_SMS_KEY_DUPLICATE		= -81
	declare @RESULT_ERROR_SMS_LACK				int				set @RESULT_ERROR_SMS_LACK				= -82
	declare @RESULT_ERROR_SMS_REJECT			int				set @RESULT_ERROR_SMS_REJECT			= -84
	declare @RESULT_ERROR_SMS_DOUBLE_PHONE		int				set @RESULT_ERROR_SMS_DOUBLE_PHONE		= -85
	declare @RESULT_ERROR_KEY_DUPLICATE			int				set @RESULT_ERROR_KEY_DUPLICATE			= -86			-- �Ϲ� Ű�� �ߺ��Ǿ���.
	
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

	--�Ϲݺ���
	declare @REWARD_MODE_CLOVER					int				set @REWARD_MODE_CLOVER					= 1
	
	------------------------------------------------
	--	2-3. ���λ�� ����
	------------------------------------------------
	declare @comment2		varchar(1024)	
	declare @comment		varchar(80)
	declare @gameid			varchar(20)
	declare @dateid 		varchar(8)				set @dateid 		= Convert(varchar(8),Getdate(),112)		-- 20120819
	declare @coin			int						set @coin			= 0
	declare @silverball		int						set @silverball		= 0
	declare @goldball		int						set @goldball		= 0
	

Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on

	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	select 	
		@gameid		= gameid,
		@coin		= coin,
		@silverball = silverball, 
		@goldball 	= goldball
	from dbo.tUserMaster where gameid = @gameid_ and password = @password_
	--select 'DEBUG 1-1', @gameid gameid, @coin coin, @silverball silverball, @goldball goldball
				
	------------------------------------------------
	--	3-2-3. �������
	------------------------------------------------
	if(isnull(@gameid, '') = '')
		begin			
			-- ���̵� ���������ʴ°�??
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID	
			set @comment = 'ERROR ���̵� ã�� ���߽��ϴ�.'
			--select 'DEBUG 2-1' + @comment
		end
	else if(@mode_ not in (@REWARD_MODE_CLOVER))
		begin
			set @nResult_ = @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment = 'ERROR �������� �ʴ� ����Դϴ�.'
			--select 'DEBUG 3-1' + @comment
		end
	else if(exists(select top 1 * from dbo.tUserRewardLog where serialkey = @serialkey_))
		begin
			set @nResult_ = @RESULT_ERROR_KEY_DUPLICATE
			set @comment = 'ERROR �ø���Ű�� �ߺ��ȴ�.'
			--select 'DEBUG 4-1' + @comment
			
			---------------------------------------------------
			--	ī���÷��� ���, �α� ���
			---------------------------------------------------
			update dbo.tUserMaster 
				set 
					resultcopy 		= resultcopy + 1
			where gameid = @gameid_

			-- ������3ȸ ī�ǿ� ���� ��ó��
			insert into dbo.tUserUnusualLog(gameid, comment) values(@gameid_, '�������޿��� ' + @comment)
		end
	else 
		begin
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS ����ó���ϴ�.'
			----select 'DEBUG 5-1' + @comment
			
			------------------------------------------------------------------
			-- ���� ������ ������Ʈ�ϱ�
			------------------------------------------------------------------
			if(@mode_ = @REWARD_MODE_CLOVER)
				begin
					set @coin = @coin + 10
					set @comment2 = '�̱����� ���� 10��'
					
					update dbo.tUserMaster 
					set
						coin = @coin
					where gameid = @gameid_
				end
			
			---------------------------------------------------
			-- �α� ����ϱ�
			---------------------------------------------------
			insert into dbo.tUserRewardLog(gameid, serialkey, mode, comment) 
			values(@gameid_, @serialkey_, @mode_, @comment2)
			
			---------------------------------------------------
			-- ��Ż ����ϱ�
			---------------------------------------------------
			if(exists(select top 1 * from dbo.tUserRewardLogTotal where dateid = @dateid and mode = @mode_))
				begin
					update dbo.tUserRewardLogTotal 
						set
							cnt = cnt + 1
					where dateid = @dateid and mode = @mode_
				end
			else
				begin
					insert into dbo.tUserRewardLogTotal(dateid, mode, cnt) 
					values(@dateid, @mode_, 1)
				end 

		end



	------------------------------------------------
	--	4-2. ��������
	------------------------------------------------
	select @nResult_ rtn, @comment comment, @silverball silverball, @goldball goldball, @coin coin
	
	set nocount off
End

