/* �Է°�
gameid=SangSang
password=7575970askeie1595312 <=��ȣȭ����
phone=01022223333

exec spu_ChangePW 'SangSang',   '7575970askeie1595312', '01022223333', -1		-- ������ ���� �ڵ��� ��ȣ�� ����
exec spu_ChangePW 'Superman77', '7575970askeie1595312', '01029984222', -1		-- �ڵ��� ��ȣ�� ���̵� �ٸ�
exec spu_ChangePW 'Superman7',  '7575970askeie1595312', '01029984222', -1		-- ���󺯰�
*/

IF OBJECT_ID ( 'dbo.spu_ChangePW', 'P' ) IS NOT NULL 
    DROP PROCEDURE dbo.spu_ChangePW;
GO 

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_ChangePW
	@gameid_								varchar(20),
	@passwordnew_							varchar(20),
	@phone_									varchar(20),
	@nResult_								int					OUTPUT
	WITH ENCRYPTION
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
	declare @RESULT_ERROR_UPGRADE_NOBRANCH		int				set @RESULT_ERROR_UPGRADE_NOBRANCH		= -50			--��ü����Ұ���
	
	declare @RESULT_ERROR_NOT_FOUND_PHONE		int				set @RESULT_ERROR_NOT_FOUND_PHONE		= -76			--����ȣ ��Ī�ȵ�
	

	-- ĳ������.
	declare @RESULT_ERROR_CASH_COPY				int				set @RESULT_ERROR_CASH_COPY				= -40			
	declare @RESULT_ERROR_CASH_OVER				int				set @RESULT_ERROR_CASH_OVER				= -41			
	declare @RESULT_ERROR_MONTH_OVER			int				set @RESULT_ERROR_MONTH_OVER			= -42			--�Ѵ޵��� �����ѵ��� �˻�

	-- �����ۼ���
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- �������ڵ��ã��
	declare @RESULT_ERROR_GIFTITEM_NOT_FOUND	int				set @RESULT_ERROR_GIFTITEM_NOT_FOUND	= -51			-- ������������ ��ã��
	declare @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	int				set @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	= -52			-- ������ �̹� ������

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

	-- �����÷��� ��������
	declare @GAME_STATE_END						int				set @GAME_STATE_END						= 0
	declare @GAME_STATE_PLAYING					int				set @GAME_STATE_PLAYING					= 1
	
	--�����۸���
	declare @ITEM_EXPIRE_STATE_NO				int 			set @ITEM_EXPIRE_STATE_NO				= 0			
	declare @ITEM_EXPIRE_STATE_YES				int				set @ITEM_EXPIRE_STATE_YES				= 1
	--declare @DAY_PLUS_TIME						bigint			set @DAY_PLUS_TIME 						= 24*60*60
	
	-- ����Ʈ 
	declare @QUEST_KIND_UPGRADE				int 			set @QUEST_KIND_UPGRADE 			= 100	-- ��ȭ
	declare @QUEST_KIND_MATING				int 			set @QUEST_KIND_MATING				= 200	-- ����
	declare @QUEST_KIND_MACHINE				int 			set @QUEST_KIND_MACHINE				= 300	-- �ӽ�
	declare @QUEST_KIND_MEMORIAL			int 			set @QUEST_KIND_MEMORIAL			= 400	-- �ϱ�
	declare @QUEST_KIND_FRIEND				int 			set @QUEST_KIND_FRIEND				= 500	-- ģ��
	declare @QUEST_KIND_POLL				int 			set @QUEST_KIND_POLL				= 600	-- ����
	declare @QUEST_KIND_BOARD				int 			set @QUEST_KIND_BOARD				= 700	-- ����
	declare @QUEST_KIND_CEIL				int 			set @QUEST_KIND_CEIL				= 800	-- õ��
	declare @QUEST_KIND_BATTLE				int 			set @QUEST_KIND_BATTLE				= 900	-- ��Ʋ
	declare @QUEST_KIND_SPRINT				int 			set @QUEST_KIND_SPRINT				= 1000	-- ����
	
	declare @QUEST_SUBKIND_POINT_ACCRUE		int 			set @QUEST_SUBKIND_POINT_ACCRUE 	= 1		-- ����
	declare @QUEST_SUBKIND_POINT_BEST		int 			set @QUEST_SUBKIND_POINT_BEST 		= 2		-- �ְ�
	declare @QUEST_SUBKIND_FRIEND_ADD		int 			set @QUEST_SUBKIND_FRIEND_ADD 		= 3		-- �߰�
	declare @QUEST_SUBKIND_FRIEND_VISIT		int 			set @QUEST_SUBKIND_FRIEND_VISIT 	= 4		-- �湮
	declare @QUEST_SUBKIND_HR_CNT			int 			set @QUEST_SUBKIND_HR_CNT 			= 5		-- Ȩ������
	declare @QUEST_SUBKIND_HR_COMBO			int 			set @QUEST_SUBKIND_HR_COMBO 		= 6		-- Ȩ���޺�
	declare @QUEST_SUBKIND_WIN_CNT			int 			set @QUEST_SUBKIND_WIN_CNT 			= 7		-- �´���
	declare @QUEST_SUBKIND_WIN_STREAK		int 			set @QUEST_SUBKIND_WIN_STREAK 		= 8		-- �¿���
	declare @QUEST_SUBKIND_CNT				int 			set @QUEST_SUBKIND_CNT 				= 9		-- �÷���

	declare @QUEST_INIT_NOT					int 			set @QUEST_INIT_NOT 				= 0
	declare @QUEST_INIT_FIRST				int 			set @QUEST_INIT_FIRST 				= 1
		
	declare @QUEST_CLEAR_NON				int 			set @QUEST_CLEAR_NON 				= 0
	declare @QUEST_CLEAR_START				int 			set @QUEST_CLEAR_START 				= 1
	declare @QUEST_CLEAR_REWARD				int 			set @QUEST_CLEAR_REWARD				= 2
	
	declare @QUEST_STATE_USER_END			int 			set @QUEST_STATE_USER_END 			= 0
	declare @QUEST_STATE_USER_WAIT			int 			set @QUEST_STATE_USER_WAIT 			= 1
	declare @QUEST_STATE_USER_ING			int 			set @QUEST_STATE_USER_ING 			= 2
	
	-- ����Ʈ �Ϲ����ǹ�
	declare @QUEST_MODE_CLEAR				int 			set @QUEST_MODE_CLEAR 				= 1
	declare @QUEST_MODE_CHECK				int 			set @QUEST_MODE_CHECK 				= 2
		
	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @gameid				varchar(20)
	declare @phone				varchar(20)
	declare @comment			varchar(80)	


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
	select
		@gameid = gameid, @phone = phone
	from dbo.tUserMaster 
	where gameid = @gameid_
	--select 'DEBUG ', @gameid, @gameid_, @phone, @phone_, @passwordnew_
	
	if(isnull(@gameid, '') = '')
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID	
			set @comment = '���̵� �������� �ʴ´�.'
		END	
	else if(@phone != @phone_)
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_PHONE	
			set @comment = '����ȣ�� ��Ī�� �ȵ˴ϴ�.'
		END	
	else if(@gameid = @gameid_ and @phone = @phone_)
		BEGIN
			set @nResult_ = @RESULT_SUCCESS	
			set @comment = '�н����带 ���� �߱��߽��ϴ�.'
			------------------------------------------------------------------
			-- ���� �н����� ����
			------------------------------------------------------------------
			update dbo.tUserMaster 
			set
				password		= @passwordNew_
			where gameid 		= @gameid_
		end

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	select @nResult_ rtn, @comment comment
	
	set nocount off
End



