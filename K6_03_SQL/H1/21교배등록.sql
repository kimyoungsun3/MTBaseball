/* 
-- ���, �����ϱ�
-- select * from dbo.tUserMaster where pet != -1
-- update dbo.tUserMaster set petregister = 1 where pet != -1
-- update dbo.tUserMaster set petregister = 1 where gameid = 'DD9999'
-- update dbo.tUserMaster set petregister = 0 where gameid = 'DD9999'


exec spu_MPetRegister 'AAAA1', 1, '�걳���', -1		-- ���������ʴ� ���̵�
exec spu_MPetRegister 'DD78', 1, '�걳���', -1		-- ���� ����
exec spu_MPetRegister 'DD1', 1, '�걳���', -1		-- ���/����
exec spu_MPetRegister 'DD1', 0, '�걳���', -1		-- ���/����
*/

IF OBJECT_ID ( 'dbo.spu_MPetRegister', 'P' ) IS NOT NULL 
    DROP PROCEDURE dbo.spu_MPetRegister;
GO 

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_MPetRegister
	@gameid_								varchar(20),		-- ���Ӿ��̵�
	@petregister_							int,
	@petmsg_								varchar(40),		-- ���Ӿ��̵�
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
	declare @RESULT_ERROR_ITEM_NOSALE_KIND		int 			set @RESULT_ERROR_ITEM_NOSALE_KIND		= -37			-- �Ǹ����� �ʴ� ������.
	declare @RESULT_ERROR_ITEM_PERMANENT_ALREADY int 			set @RESULT_ERROR_ITEM_PERMANENT_ALREADY = -38			-- �������� �̹� �����߽��ϴ�.						
	declare @RESULT_ERROR_ITEM_NOCHANGE_KIND	int 			set @RESULT_ERROR_ITEM_NOCHANGE_KIND 	= -39			-- ��ü����Ұ���.
	declare @RESULT_ERROR_UPGRADE_NOBRANCH		int 			set @RESULT_ERROR_UPGRADE_NOBRANCH 		= -60			-- �������� �귻ġ��.
	declare @RESULT_ERROR_NOT_WEAR				int 			set @RESULT_ERROR_NOT_WEAR 				= -61			-- �������� ���� 
	declare @RESULT_ERROR_ITEM_STRIP_CANNT_KIND	int				set @RESULT_ERROR_ITEM_STRIP_CANNT_KIND	= -62			--�����Ұ������Դϴ�.

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
	
	-- ���ӽ���
	declare @GAME_MODE_TRAINING					int				set @GAME_MODE_TRAINING					= 1
	declare @GAME_MODE_MACHINE					int				set @GAME_MODE_MACHINE					= 2
	declare @GAME_MODE_MEMORISE					int				set @GAME_MODE_MEMORISE					= 3
	declare @GAME_MODE_SOUL						int				set @GAME_MODE_SOUL						= 4
	declare @GAME_MODE_BATTLE					int				set @GAME_MODE_BATTLE					= 5
	declare @GAME_MODE_SPRINT					int				set @GAME_MODE_SPRINT					= 6
	
	-- ��庰 �ൿ�� �Ҹ�
	declare @GAME_MODE_SINGLE_ACTION			int				set @GAME_MODE_SINGLE_ACTION					= 3
	declare @GAME_MODE_BATTLE_ACTION			int				set @GAME_MODE_BATTLE_ACTION					= 5

	-- �����÷��� ��������
	declare @GAME_STATE_END						int				set @GAME_STATE_END						= 0
	declare @GAME_STATE_PLAYING					int				set @GAME_STATE_PLAYING					= 1
	
	-- �����߿� ȹ���ϴ� ��������ġ, ��ް���ġ, ȹ��ǹ�
	declare @GAME_SINGLE_LVEXP					int				set @GAME_SINGLE_LVEXP					= 3
	declare @GAME_BATTLE_LVEXP					int				set @GAME_BATTLE_LVEXP					= 5
	--
	declare @GAME_BATTLE_GRADEEXP				int				set @GAME_BATTLE_GRADEEXP				= 3
	declare @GAME_SINGLE_SILVERBALL_MAX			int				set @GAME_SINGLE_SILVERBALL_MAX			= 10
	declare @GAME_BATTLE_SILVERBALL_MAX			int				set @GAME_BATTLE_SILVERBALL_MAX			= 20
	
	-- ������°�
	declare @MATE_PET_NOT						int				set @MATE_PET_NOT						= 0
	declare @MATE_PET_CAN						int				set @MATE_PET_CAN						= 1

	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @gameid 		varchar(20)	
	declare @comment		varchar(80)
	declare @pet			int	

Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	
	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	select @gameid = gameid, @pet = pet
	from dbo.tUserMaster where gameid = @gameid_
	
	-- �˻� ���ϴ� ���� 
	if isnull(@gameid, '') = ''
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment = 'ERROR �������� �ʴ� ���̵� �Դϴ�.'
		END
	else if @pet = -1
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_WEAR
			set @comment = 'ERROR ���� ������ ���� �����̽��ϴ�. ���� ������ ���ּ���.'
		END
	else
		begin
			set @nResult_ = @RESULT_SUCCESS
			if(@petregister_ = @MATE_PET_NOT)
				begin
					set @comment = '����� ���� ����'
				end
			else
				begin
					set @comment = '����� ���� ���' 
				end

			update dbo.tUserMaster
			set
				petregister	= @petregister_,
				petmsg		= @petmsg_
			where gameid = @gameid_	
		end

	------------------------------------------------ 
	--	3-3. �������
	------------------------------------------------
	select @nResult_ rtn, @comment msg, isnull(@petregister_, 0) petregister, isnull(@petmsg_, '') petmsg
	
	set nocount off
End

