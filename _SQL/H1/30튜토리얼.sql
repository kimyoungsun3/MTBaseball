/*
select silverball from dbo.tUserMaster where gameid = 'SangSang'

update dbo.tUserMaster set tutorial = 0 where gameid = 'SangSang'
exec spu_Tutorial 'SangSang', -1
*/

IF OBJECT_ID ( 'dbo.spu_Tutorial', 'P' ) IS NOT NULL 
    DROP PROCEDURE dbo.spu_Tutorial;
GO 

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_Tutorial
	@gameid_								varchar(20),					-- ���Ӿ��̵�
	@password_								varchar(20),
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
	
	-- ������Ʈ ����
	declare @RESULT_ERROR_WIN_LACK				int				set @RESULT_ERROR_WIN_LACK				= -72
	declare @RESULT_ERROR_TUTORIAL_ALREADY		int				set @RESULT_ERROR_TUTORIAL_ALREADY		= -73			-- ���丮�� �̹� ����.

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
	declare @ITEM_CHAR_CUSTOMIZE_INIT			varchar(128)	set @ITEM_CHAR_CUSTOMIZE_INIT			= '1'
	declare @AVATAR_MAX							int				set @AVATAR_MAX 						= (15+1+10)		-- 0 ~ 15��.+10
	declare @SENDER								varchar(20)		set @SENDER								= 'Ʃ�丮�󺸻�'

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

	-- ��Ʋ�� �ʱⰪ
	declare @ITEM_BATTLE_ITEMCODE_INIT			int				set @ITEM_BATTLE_ITEMCODE_INIT			= 6000
	
	-- ������Ʈ���	
	declare @SPRINT_MODE_STEP01					int				set @SPRINT_MODE_STEP01				= 4
	declare @SPRINT_MODE_STEP02					int				set @SPRINT_MODE_STEP02				= 7
	declare @SPRINT_MODE_STEP03					int				set @SPRINT_MODE_STEP03				= 10
	
	declare @SPRINT_MODE_STEP01_REWARD			int				set @SPRINT_MODE_STEP01_REWARD		= 400
	declare @SPRINT_MODE_STEP02_REWARD			int				set @SPRINT_MODE_STEP02_REWARD		= 700
	declare @SPRINT_MODE_STEP03_REWARD			int				set @SPRINT_MODE_STEP03_REWARD		= 2500
	declare @SPRINT_MODE_ITEM_PERIOD2 			int				set @SPRINT_MODE_ITEM_PERIOD2		= 3	--���ϰ� �����ϴ°�?
	
	-- ���丮�� �����
	declare @TUTORIAL_REWARD_NOT				int				set @TUTORIAL_REWARD_NOT			= 0
	declare @TUTORIAL_REWARD_OK					int				set @TUTORIAL_REWARD_OK				= 1

	
	--���Լ���
	declare @JOIN_GIFT01						int 			set @JOIN_GIFT01 					= 103
	declare @JOIN_GIFT02						int 			set @JOIN_GIFT02 					= 203
	declare @JOIN_GIFT03						int 			set @JOIN_GIFT03 					= 303
	declare @JOIN_GIFT04						int 			set @JOIN_GIFT04 					= 401
	declare @JOIN_GIFT_COMMENT					varchar(512)	set @JOIN_GIFT_COMMENT				= 'Ʃ�丮�� �Ϸ� ������ ������ Ǯ�۰� ��ƿ��Ʈ�� ������ �����մϴ�.'
	declare @JOIN_GIFT_ITEM_PERIOD				int 			set @JOIN_GIFT_ITEM_PERIOD			= 7
	
	------------------------------------------------
	--	2-3. ���λ�� ����
	------------------------------------------------
	declare @comment			varchar(80)	
	declare @gameid				varchar(20)
	declare @tutorial			int
	declare @plussilverball		int 			set @plussilverball		= 0
	
	
	
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR	
	set @comment = 'ERROR �˼����� ����(-1)'


	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	--���� ������ �о����
	select @gameid 	= gameid,
			@tutorial	= tutorial
	from dbo.tUserMaster where gameid = @gameid_ and password = @password_
	--select 'DEBUG ��������', @gameid gameid, @tutorial tutorial
	
	
	------------------------------------------------
	-- 3-3. �� ���Ǻ� �б�
	------------------------------------------------
	if isnull(@gameid, '') = ''
		BEGIN
			--select 'DEBUG ������ �������� �ʽ��ϴ�.'
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment = 'ERROR ������ �������� �ʽ��ϴ�.'
		END
	else if(@tutorial = @TUTORIAL_REWARD_OK)
		BEGIN
			--select 'DEBUG �̹� ���� �߽��ϴ�.'
			set @nResult_ = @RESULT_ERROR_TUTORIAL_ALREADY
			set @comment = 'SUCCESS �̹� ���� �߽��ϴ�.'
		END
	else
		BEGIN
			--select 'DEBUG ���丮�� ����' + ltrim(rtrim(@tutorial))
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS ���丮�� ����' + ltrim(rtrim(@tutorial))
			
			set @plussilverball = 500
			set @tutorial = @TUTORIAL_REWARD_OK
		END
		

	------------------------------------------------
	-- 4-1. �� ���Ǻ� �б� > ������
	------------------------------------------------
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			---------------------------------------------------------
			-- �ڵ����
			---------------------------------------------------------
			select @nResult_ rtn, @comment comment, @plussilverball plussilverball
			
			
			update dbo.tUserMaster
			set
				silverball 		= silverball + @plussilverball,
				tutorial		= @tutorial
			where gameid = @gameid
			
			
			-- �ʹݰ����� ������ ����
			insert into dbo.tGiftList(gameid, itemcode, giftid, period2) 
			values(@gameid_ , @JOIN_GIFT01, @SENDER, @JOIN_GIFT_ITEM_PERIOD);
			
			insert into dbo.tGiftList(gameid, itemcode, giftid, period2) 
			values(@gameid_ , @JOIN_GIFT02, @SENDER, @JOIN_GIFT_ITEM_PERIOD);
			
			insert into dbo.tGiftList(gameid, itemcode, giftid, period2) 
			values(@gameid_ , @JOIN_GIFT03, @SENDER, @JOIN_GIFT_ITEM_PERIOD);
			
			insert into dbo.tGiftList(gameid, itemcode, giftid, period2) 
			values(@gameid_ , @JOIN_GIFT04, @SENDER, @JOIN_GIFT_ITEM_PERIOD);

			insert into tMessage(gameid, comment) 
			values(@gameid_, @JOIN_GIFT_COMMENT)
			
		end
	else
		begin 
			---------------------------------------------------------
			-- �ڵ����
			---------------------------------------------------------
			select @nResult_ rtn, @comment comment, @plussilverball plussilverball
		
		end

	------------------------------------------------
	--	4-2. ��������
	------------------------------------------------
	select * from dbo.tUserMaster where gameid = @gameid
	
	-- ���� ����Ʈ ����
	-- declare @gameid_ varchar(20) set @gameid_ = 'SangSang'
	select top 50 idx, itemcode, convert(varchar(16), giftdate, 20) as giftdate, giftid, period2, upgradestate2
	from dbo.tGiftList 
	where gameid = @gameid_ and gainstate = 0 
	order by idx desc
	
	
	set nocount off
End

