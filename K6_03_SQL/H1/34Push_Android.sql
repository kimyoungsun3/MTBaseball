/*
	 	
exec spu_UserPushMsgAndroid 'guest73799', '5108471s3a9v0v424371', 'guest73799', 1, '�ܼ�����', '�ܼ�����', -1, -1

exec spu_UserPushMsgAndroid 'guest73801', '7845557f9w2v5m112499', 'guest73801', 1, '�ܼ�����', '�ܼ�����', -1, -1
exec spu_UserPushMsgAndroid 'guest73801', '7845557f9w2v5m112499', 'guest73801', 2, '�ڶ�����', '�ڶ�����', 5, -1
exec spu_UserPushMsgAndroid 'guest73801', '7845557f9w2v5m112499', 'guest73801', 3, 'URL����', 'http://m.naver.com', -1, -1

exec spu_UserPushMsgAndroid 'superman6', '7575970askeie1595312', 'superman6', 2, '�ڶ�����', '�ڶ�����', -1, -1

exec spu_UserPushMsgAndroid 'supermani', '049000s1i0n7t8445289', 'supermani', 1, '�ܼ�����', '�ܼ�����', -1, -1
exec spu_UserPushMsgAndroid 'supermani', '049000s1i0n7t8445289', 'supermani', 2, '�ڶ�����', '�ڶ�����', 5, -1
exec spu_UserPushMsgAndroid 'supermani', '049000s1i0n7t8445289', 'supermani', 3, 'URL����', 'http://m.naver.com', -1, -1

---------------------------------
-- ������ : superman7 -> superman
update dbo.tUserMaster set resultwinpush = 1 where gameid in ('sususu', 'sususu2')
exec spu_UserPushMsgAndroid 'sususu', '7575970askeie1595312', 'sususu2', 2, '�ڶ�����', '�ڶ�����', 5, -1
exec spu_BattleSearch 'sususu', 'sususu2', 5, 1, -1

-- ������ : superman <- superman7
update dbo.tUserMaster set resultwinpush = 1 where gameid in ('sususu2', 'sususu')
exec spu_UserPushMsgAndroid 'sususu', '7575970askeie1595312', 'sususu2', 2, '�ڶ�����', '�ڶ�����', 5, -1
exec spu_BattleSearch 'sususu2', 'sususu', 5, 1, -1

*/


IF OBJECT_ID ( 'dbo.spu_UserPushMsgAndroid', 'P' ) IS NOT NULL 
    DROP PROCEDURE dbo.spu_UserPushMsgAndroid;
GO

create procedure dbo.spu_UserPushMsgAndroid
	@gameid_				varchar(20),
	@password_				varchar(20),
	@receid_				varchar(20),
	@kind_					int,
	@msgtitle_				varchar(512),
	@msgmsg_				varchar(512),
	@gmode_					int,						--������ ���Ӹ��.
	@nResult_				int				OUTPUT
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
	
	-- ���ӽ���
	declare @GAME_MODE_LOGERROR					int				set @GAME_MODE_LOGERROR					= -1
	declare @GAME_MODE_SBCHEAT					int				set @GAME_MODE_SBCHEAT					= -2
	declare @GAME_MODE_TRAINING					int				set @GAME_MODE_TRAINING					= 1
	declare @GAME_MODE_MACHINE					int				set @GAME_MODE_MACHINE					= 2
	declare @GAME_MODE_MEMORISE					int				set @GAME_MODE_MEMORISE					= 3
	declare @GAME_MODE_SOUL						int				set @GAME_MODE_SOUL						= 4
	declare @GAME_MODE_BATTLE					int				set @GAME_MODE_BATTLE					= 5
	declare @GAME_MODE_SPRINT					int				set @GAME_MODE_SPRINT					= 6
	
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
	
	declare @RESULT_ERROR_NOT_FOUND_OTHERID		int				set @RESULT_ERROR_NOT_FOUND_OTHERID		= -83
	
	-- �������. (99)
	declare @PUSH_MODE_MSG						int				set @PUSH_MODE_MSG						= 1
	declare @PUSH_MODE_PEACOCK					int				set @PUSH_MODE_PEACOCK					= 2
	declare @PUSH_MODE_URL						int				set @PUSH_MODE_URL						= 3	
	declare @PUSH_MODE_GROUP					int				set @PUSH_MODE_GROUP					= 99	-- ��ü�߼ۿ�	
	
	-- �ڶ��ϱ⸦ ���ؼ� ����ޱ�.
	declare @PEACOCK_REWARD_SB_FRIEND			int				set @PEACOCK_REWARD_SB_FRIEND			= 60
	declare @PEACOCK_REWARD_SB_ALL				int				set @PEACOCK_REWARD_SB_ALL				= 30
	declare @RESULT_WIN_PUSH_PUSHED				int 			set	@RESULT_WIN_PUSH_PUSHED				= 0
	declare @RESULT_WIN_PUSH_WIN				int 			set	@RESULT_WIN_PUSH_WIN				= 1
	
	-- ��Ż� ���а�
	declare @SKT 							int					set @SKT						= 1
	declare @KT 							int					set @KT							= 2
	declare @LGT 							int					set @LGT						= 3
	declare @FACKBOOK 						int					set @FACKBOOK					= 4
	declare @GOOGLE 						int					set @GOOGLE						= 5
	declare @NHN							int					set @NHN						= 6
	declare @IPHONE							int					set @IPHONE						= 7
	declare @NHNWEB							int					set @NHNWEB						= 8
	declare @SKT2 							int					set @SKT2						= 11
	declare @KT2 							int					set @KT2						= 12
	declare @LGT2 							int					set @LGT2						= 13
	declare @GOOGLE2 						int					set @GOOGLE2					= 15
	declare @XXXXXXXXXXXXXXXXXXX			int					set @XXXXXXXXXXXXXXXXXXX		= 99
	
	------------------------------------------------
	--	2-3. ���λ�� ����
	------------------------------------------------
	declare @gameid			varchar(20)
	declare @receid			varchar(20)
	declare @recepushid		varchar(256)
	declare @comment		varchar(512)
	declare @dateid 		varchar(8)				set @dateid 			= Convert(varchar(8),Getdate(),112)		-- 20120819
	declare @grade			int
	declare @recegrade		int
	
	declare @resultwinpush	int						set @resultwinpush 		= @RESULT_WIN_PUSH_PUSHED	
	declare @silverball		int						set @silverball			= 0
	declare @goldball		int						set @goldball			= 0
	
	declare @recemarket		int						set @recemarket			= @SKT

Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on

	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	select 
		@gameid			= gameid,
		@grade			= grade,
		@silverball		= silverball,
		@goldball		= goldball,
		@resultwinpush 	= resultwinpush
	from dbo.tUserMaster where gameid = @gameid_ and password = @password_
	
	select 
		@receid		= gameid,
		@recegrade	= grade,
		@recemarket	= market,
		@recepushid	= pushid
	from dbo.tUserMaster where gameid = @receid_
				
	------------------------------------------------
	--	3-2-3. �������
	------------------------------------------------
	if(isnull(@gameid, '') = '')
		begin
			-- ���̵� ���������ʴ°�??
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID	
			set @comment = 'ERROR ���̵� ã�� ���߽��ϴ�.'
		end
	else if(isnull(@receid, '') = '')
		begin
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_OTHERID
			set @comment = 'ERROR ��밡 �������� �ʽ��ϴ�.'
		end
	else if(@kind_ not in (@PUSH_MODE_MSG, @PUSH_MODE_PEACOCK, @PUSH_MODE_URL))
		begin
			set @nResult_ = @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment = 'ERROR �������� �ʴ� ����Դϴ�..'
		end
	else 
		begin
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS Push ����ó���ϴ�.'
			
			---------------------------------------------------
			-- ���� ����ϱ�
			---------------------------------------------------
			declare @msgtitle		varchar(512)
			declare @msgmsg			varchar(512)
			declare @msgaction		varchar(512)
			
			if(@kind_ = @PUSH_MODE_MSG)
				begin
					set @msgtitle	= @msgtitle_
					set @msgmsg		= @msgmsg_
					set @msgaction	= 'LAUNCH'
				end
			else if(@kind_ = @PUSH_MODE_PEACOCK)
				begin
					-- �ڵ������� �ڶ��ϱ�� ���� ���.
					set @msgtitle	= '[Ȩ������]'
					--set @msgmsg		= @gameid + '���� �������� �¸��Ͽ����ϴ�.'
					--(ģ��)���� (����)�԰� �����Ͽ� �¸��߽��ϴ�! ���� �ٷ� �����ؼ� (ģ��)�԰� �����ϼ���!
					--set @msgmsg		= @gameid + '���� �����Ͽ� �¸��߽��ϴ�! ���� �ٷ� �����ؼ� ' + @gameid + '�԰� �����ϼ���!'
					set @msgmsg		= '[' + @gameid + '�԰��� �������� �й�! ������Ͽ��� ������븦 ã������!'
					set @msgaction	= 'LAUNCH'

					-- �ڶ��ϱ⸦ ���ؼ� ���۵� ��쿡�� �߰� �ǹ��� ���޵˴ϴ�.
					if(@resultwinpush = @RESULT_WIN_PUSH_WIN)
						begin
							---------------------------------------------------
							--	�ڱ� >�ڶ��ϱ� ��������
							---------------------------------------------------
							if(exists(select * from dbo.tUserFriend where gameid = @gameid_ and friendid = @receid_))
								begin
									set @silverball = @silverball + @PEACOCK_REWARD_SB_FRIEND
								end
							else
								begin
									set @silverball = @silverball + @PEACOCK_REWARD_SB_ALL
								end
							
							
							update dbo.tUserMaster  
								set
									resultwinpush 	= @RESULT_WIN_PUSH_PUSHED,
									silverball		= @silverball
							where gameid = @gameid_
							
							
							---------------------------------------------------
							--	���� > �¸����� ���̵� ���
							---------------------------------------------------
							--select 'DEBUG 1-1', @gmode_ gmode_, @gameid_ gameid_, @grade grade, @receid_ receid_, @recegrade recegrade
							if(@gmode_ in (@GAME_MODE_BATTLE, @GAME_MODE_SPRINT) and @grade > @recegrade - 10)
								begin
									--select 'DEBUG 1-2 > ������ ���'
									insert into dbo.tUserRevenge(btpgameid, btpgrade, btpgmode, gameid) 
									values(@gameid_, @grade, @gmode_, @receid_)
								end
							
							
						end
					else
						begin
							---------------------------------------------------
							--	ī���÷��� ���, �α� ���
							---------------------------------------------------
							update dbo.tUserMaster 
								set 
									resultcopy 		= resultcopy + 1
							where gameid = @gameid_
										
							insert into dbo.tUserUnusualLog(gameid, comment) 
							values(@gameid_, '�ڶ��ϱ⸦ �̿��ؼ� ĳ�� ī�Ǹ� �õ��ҷ��� �ߴ�.')
						end
				end
			else if(@kind_ = @PUSH_MODE_URL)
				begin
					set @msgtitle	= '[Ȩ������]'
					set @msgmsg		= '¥���� ���ǽº�~~~'
					set @msgaction	= @msgmsg_
				end
			
			if(@recemarket = @IPHONE)
				begin
					insert into dbo.tUserPushiPhone(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) 
					values(@gameid, @receid, @recepushid, @kind_, 99, @msgtitle, @msgmsg, @msgaction)
				end
			else
				begin
					insert into dbo.tUserPushAndroid(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) 
					values(@gameid, @receid, @recepushid, @kind_, 99, @msgtitle, @msgmsg, @msgaction)
				end

			---------------------------------------------------
			-- ��Ż ����ϱ�
			---------------------------------------------------
			if(exists(select top 1 * from dbo.tUserPushAndroidTotal where dateid = @dateid))
				begin
					update dbo.tUserPushAndroidTotal 
						set
							cnt = cnt + 1
					where dateid = @dateid
				end
			else
				begin
					insert into dbo.tUserPushAndroidTotal(dateid, cnt) 
					values(@dateid, 1)
				end

		end



	------------------------------------------------
	--	4-2. ��������
	------------------------------------------------
	select @nResult_ rtn, @comment comment, @goldball goldball, @silverball silverball
	
	set nocount off
End

