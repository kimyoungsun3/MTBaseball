/*
gameid=xxx
mode=xxx
friendid=xxx

exec spu_Friend 'SangSang', '', 0, 'DD', -1			-- �������� �ʴ� ���

exec spu_Friend 'SangSang', '', 1, '', -1			-- �˻� : �����˻�
exec spu_Friend 'SangSang', '', 1, 'DD', -1			-- �˻� : �̿� > 0��
exec spu_Friend 'SangSang', '', 1, 'SangSang', -1	-- �˻� : ���������� > 0��
exec spu_Friend 'SangSang', '', 1, 'AD', -1			-- �˻� : ���� > 0��
exec spu_Friend 'SangSang', '', 1, 'superman', -1	-- �˻� : ��Ȯ��

exec spu_Friend 'SangSang', '7575970askeie1595312', 2, 'DD0', -1		-- ģ�� �߰�(����߰�����)
exec spu_Friend 'SangSang', '7575970askeie1595312', 2, 'DD', -1			-- ģ�� ����
exec spu_Friend 'SangSang', '7575970askeie1595312', 2, 'SangSang', -1	-- �ڱ��߰�?
exec spu_Friend 'SangSang', '7575970askeie1595312', 2, 'DD0', -1		-- �н�����Ʋ��
select * from dbo.tUserMaster where gameid = 'Superman'
exec spu_Friend 'Superman', '7575970askeie1595312', 2, 'Superman', -1	-- �ڱ��߰�?

exec spu_Friend 'dd5', '7575970askeie1595312', 2, 'DD1', -1
exec spu_Friend 'dd5', '7575970askeie1595312', 2, 'DD2', -1
exec spu_Friend 'dd5', '7575970askeie1595312', 2, 'DD3', -1
exec spu_Friend 'dd5', '7575970askeie1595312', 2, 'DD4', -1
exec spu_Friend 'dd5', '7575970askeie1595312', 2, 'DD6', -1
exec spu_Friend 'dd5', '7575970askeie1595312', 3, 'DD1', -1
exec spu_Friend 'dd5', '7575970askeie1595312', 3, 'DD2', -1
exec spu_Friend 'dd5', '7575970askeie1595312', 3, 'DD3', -1
exec spu_Friend 'dd5', '7575970askeie1595312', 3, 'DD4', -1
exec spu_Friend 'dd5', '7575970askeie1595312', 3, 'DD6', -1

exec spu_Friend 'SangSang', 'a1s2d3f4', 3, 'DD0', -1		-- ģ�� ����
exec spu_Friend 'SangSang', 'a1s2d3f4', 3, 'DD', -1			-- ģ�� ����
exec spu_Friend 'SangSang', '1111', 3, 'DD', -1				-- �н�����Ʋ��

exec spu_Friend 'SangSang', '', 4, 'SangSang', -1	-- ģ�� My����Ʈ

exec spu_Friend 'SangSang', '', 5, 'DD0', -1		-- ģ�� �湮(����)
exec spu_Friend 'SangSang', '', 5, 'DD', -1			-- ģ�� �湮(����)
*/

IF OBJECT_ID ( 'dbo.spu_Friend', 'P' ) IS NOT NULL 
    DROP PROCEDURE dbo.spu_Friend;
GO 

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_Friend
	@gameid_								varchar(20),					-- ���Ӿ��̵�
	@password_								varchar(20),
	@mode_									int,
	@friendid_								varchar(20),
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
	declare @RESULT_ERROR_FRIEND_ADD_MYGAMEID	int				set @RESULT_ERROR_FRIEND_ADD_MYGAMEID	= -74			-- �ڽ��� ���̵� �߰�.
	
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
	
	-- ģ���߰��� ���� ��Ŀ�� ���ǰ�
	declare @FRIEND_LSINIT						int				set @FRIEND_LSINIT						= 5
	declare @FRIEND_LSMAX						int				set @FRIEND_LSMAX						= 20
	
	------------------------------------------------
	--	2-3. ���λ�� ����
	------------------------------------------------
	declare @gameid			varchar(20)
	declare @password		varchar(20)
	declare @comment		varchar(80)
	declare @cnt			int
	declare @friendLSMax	int
	declare @friendLSMaxO	int
	

	-- ����Ʈ�� ����Ÿ.
	declare @friendaddcnt			int,
			@friendvisitcnt			int	

Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on

	------------------------------------------------
	-- 3-3. �� ���Ǻ� �б�
	------------------------------------------------
	if (@mode_ not in (@FRIEND_MODE_SEARCH, @FRIEND_MODE_ADD, @FRIEND_MODE_DELETE, @FRIEND_MODE_MYLIST, @FRIEND_MODE_VISIT))
		BEGIN
			set @nResult_ = @RESULT_ERROR
			select @nResult_ rtn, 'ERROR �������� �ʴ� ����Դϴ�.'
		END
	else if (@mode_ = @FRIEND_MODE_SEARCH)
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			select @nResult_ rtn, 'SUCCESS �����˻�����Ʈ'
			
			--1. �տ� '%' �ʹ�����			
			--set @friendid_ = '%' + @friendid_ + '%'
			--select top 10 * from dbo.tUserMaster where gameid like @friendid_ and gameid != @gameid_		
			--select top 10 * from dbo.tUserMaster where gameid = @friendid_ and gameid != @gameid_		

			if(isnull(@friendid_, '') = '')
				begin
					select top 10 * from dbo.tUserMaster where gameid != @gameid_	
					order by newid()
				end
			-- �����˻��� ������ ���� 
			-- mogly > mogly�� �����ϸ� mogly�� ����, �� mogly, mogly2�� �˻��ϱ⸦ ����.
			--else if(exists(select top 1 * from dbo.tUserMaster where gameid != @gameid_ and gameid = @friendid_))
			--	begin
			--		select top 1 * from dbo.tUserMaster where gameid = @friendid_
			--	end
			else
				begin
					-- 2. �� '%' ����
					set @friendid_ = @friendid_ + '%'
					select top 10 * from dbo.tUserMaster where gameid != @gameid_ and gameid like @friendid_ 	
				end
			
		END
	else if (@mode_ = @FRIEND_MODE_ADD)
		BEGIN
			select 
				@password = password, @friendLSMaxO = friendLSMax,
				@friendaddcnt = friendaddcnt
			from dbo.tUserMaster where gameid = @gameid_		
			
			select @cnt = count(*)  from dbo.tUserMaster where gameid in (@gameid_, @friendid_)
			
			if(isnull(@password, '') != '' and @password != @password_)
				begin
					set @nResult_ = @RESULT_ERROR_NOT_FOUND_PASSWORD
					select @nResult_ rtn, 'ERROR �н����尡 Ʋ���ϴ�.'
				end
			else if(isnull(@gameid_, '') != '' and @gameid_ = @friendid_)
				begin
					set @nResult_ = @RESULT_ERROR_FRIEND_ADD_MYGAMEID
					select @nResult_ rtn, 'ERROR �ڽ��� ���̵� �߰� �� �� �����ϴ�.'
				end
			else if(@cnt = 2)
				begin
					------------------------------------------
					-- ģ���߰�
					------------------------------------------
					if(exists(select * from dbo.tUserFriend where gameid = @gameid_ and friendid = @friendid_))
						begin
							-- ģ���� �ִ�.
							set @nResult_ = @RESULT_SUCCESS
							select @nResult_ rtn, 'SUCCESS ����ģ���߰�(�̹��߰�)'
						end
					else
						begin
							--ģ���߰�
							set @nResult_ = @RESULT_SUCCESS
							select @nResult_ rtn, 'SUCCESS ����ģ���߰�'
							
							insert into dbo.tUserFriend(gameid, friendid) values(@gameid_, @friendid_)
						end
					
					------------------------------------------
					-- ģ���߰��� ������ ���� ��Ŀ�� ��������
					-- ���������� ������ ���Ҷ� �������̺� �ݿ�
					------------------------------------------
					select @friendLSMax = count(*) from dbo.tUserFriend where gameid = @gameid_
					set @friendaddcnt = @friendLSMax 
					set @friendLSMax = @FRIEND_LSINIT + @friendLSMax / 2
					if(@friendLSMax > @FRIEND_LSMAX)
						begin
							set @friendLSMax = @FRIEND_LSMAX
						end
					--if(@friendLSMaxO != @friendLSMax)
					--	begin
					--		update dbo.tUserMaster
					--			set
					--				friendLSMax = @friendLSMax
					--		where gameid = @gameid_	
					--	end
					update dbo.tUserMaster
						set
							friendLSMax = @friendLSMax,
							friendaddcnt = @friendaddcnt
					where gameid = @gameid_	
					
					
					------------------------------------------
					-- ģ�� ����Ʈ ����
					------------------------------------------
					select f.gameid, u.avatar, u.picture, u.ccode, u.grade, u.lv, u.btwin, u.bttotal, f.friendid, f.writedate, f.familiar 
					from dbo.tUserMaster u join dbo.tUserFriend f on u.gameid = f.friendid
					where f.gameid = @gameid_ order by familiar desc
					
					
				end
			else
				begin
					set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
					select @nResult_ rtn, 'ERROR ������ �����ϴ�.'
				end

		END
	else if (@mode_ = @FRIEND_MODE_DELETE)
		BEGIN
			select 
				@password = password, @friendLSMaxO = friendLSMax,
				@friendaddcnt = friendaddcnt
			from dbo.tUserMaster where gameid = @gameid_	
			
			if(isnull(@password, '') != '' and @password != @password_)
				begin
					set @nResult_ = @RESULT_ERROR_NOT_FOUND_PASSWORD
					select @nResult_ rtn, 'ERROR �н����尡 Ʋ���ϴ�.'
				end
			else if EXISTS(select * from dbo.tUserFriend where gameid = @gameid_ and friendid = @friendid_)
				begin
					set @nResult_ = @RESULT_SUCCESS
					select @nResult_ rtn, 'SUCCESS ���� ģ������Ʈ ����' + @friendid_
					
					------------------------------------------
					-- ģ������
					------------------------------------------
					delete from dbo.tUserFriend where gameid = @gameid_ and friendid = @friendid_
					
					
					------------------------------------------
					-- ģ���߰��� ������ ���� ��Ŀ�� ��������
					-- ���������� ������ ���Ҷ� �������̺� �ݿ�
					------------------------------------------
					select @friendLSMax = count(*) from dbo.tUserFriend where gameid = @gameid_
					set @friendaddcnt = @friendLSMax 
					set @friendLSMax = @FRIEND_LSINIT + @friendLSMax / 2
					if(@friendLSMax > @FRIEND_LSMAX)
						begin
							set @friendLSMax = @FRIEND_LSMAX
						end
					--if(@friendLSMaxO != @friendLSMax)
					--	begin
					--		update dbo.tUserMaster
					--			set
					--				friendLSMax = @friendLSMax,
					--				friendLSCount = case 
					--									when friendLSCount > @friendLSMax then @friendLSMax
					--									else friendLSCount
					--								end
					--		where gameid = @gameid_	
					--	end
					update dbo.tUserMaster
						set
							friendLSMax = @friendLSMax,
							friendLSCount = case 
												when friendLSCount > @friendLSMax then @friendLSMax
												else friendLSCount
											end,
							friendaddcnt = @friendaddcnt
					where gameid = @gameid_	
			
					
					
					------------------------------------------
					-- ģ�� ����Ʈ ����
					------------------------------------------
					select f.gameid, u.avatar, u.picture, u.ccode, u.grade, u.lv, u.btwin, u.bttotal, f.friendid, f.writedate, f.familiar 
					from dbo.tUserMaster u join dbo.tUserFriend f on u.gameid = f.friendid
					where f.gameid = @gameid_ order by familiar desc
				end
			else
				begin
					set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
					select @nResult_ rtn, 'ERROR ���� ģ������Ʈ�� �����ϴ�.'
				end
		END
	else if (@mode_ = @FRIEND_MODE_MYLIST)
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			select @nResult_ rtn, 'SUCCESS ����ģ������Ʈ'
			
			select f.gameid, u.avatar, u.picture, u.ccode, u.grade, u.lv, u.btwin, u.bttotal, f.friendid, f.writedate, f.familiar 
			--select u.lv, u.grade, f.gameid, f.friendid, f.writedate, f.familiar 
			from dbo.tUserMaster u join dbo.tUserFriend f on u.gameid = f.friendid
			where f.gameid = @gameid_ order by familiar desc
		END
	else if (@mode_ = @FRIEND_MODE_VISIT)
		BEGIN
			-- ģ���� ����
			declare @cap 			int,	@cap2		int,
					@cupper			int,	@cupper2	int,
					@cunder			int,	@cunder2	int,
					@bat			int,	@bat2		int,
					@pet			int,	@pet2		int,
					@itemcode		int,	@upgradestate int
			select 
				@cap = cap, @cunder = cunder, @cupper = cupper, @bat = bat, @pet = pet
			from dbo.tUserMaster where gameid = @friendid_

			
			if(isnull(@cap, -1) != -1)
				begin
					set @nResult_ = @RESULT_SUCCESS
					select @nResult_ rtn, 'SUCCESS ģ���� ����'
					
					-- ��ģ����ģ�е� �ø���
					-- ���Ϳ��� ģ���� �湮 > gameid and friendid
					-- ģ������ ģ���� �湮 >            friendid
					if(isnull(@gameid_, '') != '')
						begin
							update dbo.tUserFriend
								set
								familiar = familiar + 1
							where gameid = @gameid_ and friendid = @friendid_
						end
					
					-- ��������
					-- 1. Ŀ������
					declare curUserItem Cursor for
					select itemcode, upgradestate from dbo.tUserItem where gameid = @friendid_ and itemcode in (@cap, @cupper, @cunder, @bat, @pet)
		
					-- 2. Ŀ������
					open curUserItem
		
					-- 3. Ŀ�� ���
					Fetch next from curUserItem into @itemcode, @upgradestate
					while @@Fetch_status = 0
						Begin	
							if(@itemcode = @cap)
								set @cap2 = @upgradestate
							else if(@itemcode = @cupper)
								set @cupper2 = @upgradestate
							else if(@itemcode = @cunder)
								set @cunder2 = @upgradestate
							else if(@itemcode = @bat)
								set @bat2 = @upgradestate
							else if(@itemcode = @pet)
								set @pet2 = @upgradestate
							Fetch next from curUserItem into @itemcode, @upgradestate
						end
		
					-- 4. Ŀ���ݱ�
					close curUserItem
					Deallocate curUserItem		
					select @cap2 capupgrade, @cunder2 cunderupgrade, @cupper2 cupperupgrade, @bat2 batupgrade, isnull(@pet2, 0) petupgrade, * from dbo.tUserMaster where gameid = @friendid_ 
					
				
					-- ģ���� ģ����
					--select * from dbo.tUserFriend where gameid = @friendid_ order by familiar desc
					select f.gameid, u.avatar, u.picture, u.ccode, u.grade, u.lv, u.btwin, u.bttotal, f.friendid, f.writedate, f.familiar 
					from dbo.tUserMaster u join dbo.tUserFriend f on u.gameid = f.friendid
					where f.gameid = @friendid_ order by familiar desc
					
					
					-- ģ�� �湮 ī���� �����ϱ�
					update dbo.tUserMaster
						set 
							friendvisitcnt = friendvisitcnt + 1
					where gameid = @gameid_					
				end
			else
				begin
					set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
					select @nResult_ rtn, 'ERROR ģ���� ������ ã���� �����ϴ�.'
				end
		END
	else 
		begin
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
			select @nResult_ rtn, 'ERROR �˼����� ����(-1)'
		end



	------------------------------------------------
	--	4-2. ��������
	------------------------------------------------		
	set nocount off
End

