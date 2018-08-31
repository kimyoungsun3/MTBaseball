
/*				

exec spu_QuestReward 'guest73317', '8259288t0f2g7j817448', 100, -1	
delete from dbo.tGiftList where gameid ='guest73317'

exec spu_QuestReward 'superman3', '7575970askeie1595312', 100, -1	
delete from dbo.tGiftList where gameid ='superman3'
*/

IF OBJECT_ID ( 'dbo.spu_QuestReward', 'P' ) IS NOT NULL 
    DROP PROCEDURE dbo.spu_QuestReward;
GO 

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_QuestReward
	@gameid_								varchar(20),					-- ���Ӿ��̵�
	@password_								varchar(20),
	@questcode_								int,
	@nResult_								int				OUTPUT
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
	declare @RESULT_ERROR_FRIEND_ADD_MYGAMEID	int				set @RESULT_ERROR_FRIEND_ADD_MYGAMEID	= -74			-- �ڽ��� ���̵� �߰�.
	
	-- ����Ʈ ���޹̼�
	declare @QUEST_MISSION_ITEM_PERIOD			int 			set @QUEST_MISSION_ITEM_PERIOD			= 4
	declare @QUEST_MISSION_SENDER				varchar(20)		set @QUEST_MISSION_SENDER				= 'QuestMsg'
	
	-- ����Ʈ ����.
	declare @RESULT_ERROR_QUEST_CODE_NOT_FOUND	int				set @RESULT_ERROR_QUEST_CODE_NOT_FOUND	= -100			-- ����Ʈ �ڵ带 ã���� ����.
	declare @RESULT_ERROR_QUEST_ALREADY_REWARD	int				set @RESULT_ERROR_QUEST_ALREADY_REWARD	= -101			-- ����Ʈ �̹� �����ߴ�.
	declare @RESULT_ERROR_QUEST_NOT_ING			int				set @RESULT_ERROR_QUEST_NOT_ING			= -102			-- ����Ʈ �������� �ƴϴ�.
	declare @RESULT_ERROR_QUEST_NOT_COMPLETED	int				set @RESULT_ERROR_QUEST_NOT_COMPLETED	= -103			-- ����Ʈ �������ϴ�.

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
	
	declare @QUEST_NOT_COMPLETE				int 			set @QUEST_NOT_COMPLETE 			= -1
	declare @QUEST_COMPLETED				int 			set @QUEST_COMPLETED 				= 1

	------------------------------------------------
	--	2-3. ���λ�� ����
	------------------------------------------------
	declare @comment		varchar(80)
	
	declare @gameid			varchar(20)
	declare @password		varchar(20)
	declare @silverball		int,
			@lv				int
	
	declare @questcode		int,
			@queststate		int,	
			
			@questnext		int,
			@questkind		int,	
			@questsubkind	int,	
			@questvalue		int,
			@rewardsb		int,
			@rewarditem		int,
			
			@questtimenext	int,
			@questclearnext	int
			
	declare @questcomplete	int				set @questcomplete		= @QUEST_NOT_COMPLETE	
	
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR	
	set @comment = 'ERROR �������� �ʴ� ���̵� �Դϴ�.'
	
	
	------------------------------------------------
	--	3-2. ���� �����˻�
	------------------------------------------------
	select 
		@gameid = gameid, 		@password = password,	
		@silverball = silverball,
		@lv = lv
	from dbo.tUserMaster where gameid = @gameid_
	
	------------------------------------------------
	--	3-3. ������ ��ȿ���� �˻�.
	------------------------------------------------
	if isnull(@gameid, '') = ''
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment = 'ERROR �������� �ʴ� ���̵� �Դϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if(isnull(@password, '') = '' or @password != @password_)
		BEGIN
			-- ���̵� & �н����� ���������ʴ°�??
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_PASSWORD
			set @comment = 'DEBUG �н����� Ʋ�ȴ�. > �н����� Ȯ���ض�'
			--select 'DEBUG ' + @comment
		END
	else
		begin
			-------------------------------------------------------
			-- �������̵�, ����Ʈ �ڵ� -> ��������Ʈ �������
			-- ����Ʈ �ڵ� -> ����Ʈ���� 
			-- ������(info), ������(user) > ����Ʈ�����б�
			-------------------------------------------------------
			--select 'DEBUG ������(info), ������(user) > ����Ʈ�����б�'
			select 
				@questcode = u.questcode, 	@queststate = queststate, 
				@questnext = questnext,		@questkind = questkind,		@questsubkind = questsubkind,	@questvalue = questvalue, 	
				@rewardsb = rewardsb,		@rewarditem = rewarditem
			from 
				(select * from dbo.tQuestUser where gameid = @gameid_ and questcode = @questcode_) u 
					join
				(select * from dbo.tQuestInfo where questcode = @questcode_) i
					on u.questcode = i.questcode
			
			-- ����ȣ�� �������?
			if isnull(@questcode, -1) = -1
				BEGIN
					set @nResult_ = @RESULT_ERROR_QUEST_CODE_NOT_FOUND
					set @comment = 'ERROR ����ȣ�� ���������� �ʽ��ϴ�.'
					--select 'DEBUG ' + @comment
				END
			else if(@queststate = @QUEST_STATE_USER_END)					
				BEGIN
					set @nResult_ = @RESULT_ERROR_QUEST_ALREADY_REWARD
					set @comment = 'ERROR �̹� ���� ���� �߽��ϴ�.'
					--select 'DEBUG ' + @comment
				END
			else if(@queststate = @QUEST_STATE_USER_WAIT)					
				BEGIN
					set @nResult_ = @RESULT_ERROR_QUEST_NOT_ING
					set @comment = 'ERROR �������� ���� �ƴմϴ�.'
					--select 'DEBUG ' + @comment
				END
			else if(@queststate = @QUEST_STATE_USER_ING)					
				BEGIN
					-------------------------------------------------
					-- ����Ʈ�� �Ϸ� �� �� �־� ������ �� �ִ°�?
					-- spu_QuestCheck > ���˻� > ����üũ
					-------------------------------------------------
					declare @rtn 		int		
					set @rtn 			= @QUEST_NOT_COMPLETE
					exec spu_QuestCheck @QUEST_MODE_CHECK, @gameid_, @questkind, @questsubkind, @questvalue, @rtn OUTPUT
					--select 'DEBUG spu_QuestCheck > ���˻� > ����üũ'
					
					-------------------------------------------------
					-- �Ϸ��Ҽ� �ִ°�?
					if(@rtn = @QUEST_NOT_COMPLETE)
						begin		
							set @nResult_ = @RESULT_ERROR_QUEST_NOT_COMPLETED
							set @comment = 'ERROR ����Ʈ ������ �������� ���߽��ϴ�.'	
							--select 'DEBUG ' + @comment 
						end
					else	
						begin
							-------------------------------------------------
							set @nResult_ = @RESULT_SUCCESS
							set @comment = 'SUCCESS ����Ʈ �Ϸ��߽��ϴ�.'
							select @questtimenext = isnull(questtime, -100), @questclearnext = isnull(questclear, @QUEST_CLEAR_NON) 
							from dbo.tQuestInfo 
							where questcode = @questnext
							
							-------------------------------------------------
							--select 'DEBUG ���� �ǹ��� or ����'
							set @silverball = @silverball + @rewardsb
							if(@rewarditem != -1)
								begin
									--select 'DEBUG ������ ������ ����'
									insert into dbo.tGiftList(gameid, itemcode, giftid, period2) 
									values(@gameid_ , @rewarditem, @QUEST_MISSION_SENDER, @QUEST_MISSION_ITEM_PERIOD);
								end
								
							-------------------------------------------------
							--select 'DEBUG ������ �Ϸ�� ����(user)'
							update dbo.tQuestUser
								set 
									queststate = @QUEST_STATE_USER_END,
									questend = getdate()
							where gameid = @gameid_ and questcode = @questcode_
										
							-------------------------------------------------
							--select 'DEBUG �������� ��� Ŭ����?'
							if(@questclearnext = @QUEST_CLEAR_REWARD)
								begin 
									--select 'DEBUG > (������)spu > ��� Ŭ���� > ��������Ÿ�� ����Ʈ ������ Ŭ����'
									exec spu_QuestCheck @QUEST_MODE_CLEAR, @gameid_, @questkind, @questsubkind, -1, -1
								end
								
							-------------------------------------------------
							--select 'DEBUG �������� �ִ°�?'
							if(@questtimenext != -100)
								begin
									--select 'DEBUG > (������)�����ϱ� ��������ȣ:' + ltrim(rtrim(str(@questnext))) + ' �ð�:' + ltrim(rtrim(str(@questtimenext)))
									
									if exists (select * from dbo.tQuestUser where gameid = @gameid_ and questcode = @questnext)
										begin
											--select 'DEBUG ������ ���� > Update �����, ������ + �ð�'
											update dbo.tQuestUser 
												set 
													queststate = @QUEST_STATE_USER_WAIT,
													queststart = DATEADD(hh, @questtimenext, getdate())
											where gameid = @gameid_ and questcode = @questnext
										end
									else	
										begin	
											--select 'DEBUG ������ ���� > insert �����, ������ + �ð�'
											insert into dbo.tQuestUser(gameid, questcode, queststate, queststart) 
											values(@gameid_, @questnext, @QUEST_STATE_USER_WAIT, DATEADD(hh, @questtimenext, getdate()))
										end
								end
								
							-------------------------------------------------
							--select 'DEBUG �����°� �������ϱ�'
							update dbo.tQuestUser 
								set 
									queststate = @QUEST_STATE_USER_ING
							where gameid = @gameid_ 
								and queststate = @QUEST_STATE_USER_WAIT 
								and getdate() >= queststart
						end	
				end	
		end
	

	------------------------------------------------
	--	3-5. ���� ����Ÿ �����ϱ�
	--       �� ���Ǻ� �б� > ������
	------------------------------------------------
	if(@nResult_ in (@RESULT_SUCCESS, @RESULT_ERROR_QUEST_ALREADY_REWARD))
		begin
			-- �޽��� ���	
			select @nResult_ rtn, @comment
		
			-- �������� ����, �������� ������Ÿ	(������ ó����)
			update dbo.tUserMaster
				set
					silverball = @silverball
			where gameid = @gameid_
			
			-- ���� ������Ÿ ����
			select * from dbo.tUserMaster where gameid = @gameid_
						
			--> ������ ����Ʈ �����
			select * from dbo.tQuestInfo 
			where questcode in (
				select questcode from dbo.tQuestUser 
				where gameid = @gameid_ and queststate = @QUEST_STATE_USER_ING and @lv >= questlv
			)
			order by questorder
			
			-- ���� ����Ʈ ����
			select top 50 idx, itemcode, convert(varchar(16), giftdate, 20) as giftdate, giftid, period2, upgradestate2
			from dbo.tGiftList 
			where gameid = @gameid_ and gainstate = 0 
			order by idx desc
		end
	else
		begin
			select @nResult_ rtn, @comment
		end
	
	set nocount off
End

