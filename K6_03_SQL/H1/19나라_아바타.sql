---------------------------------------------------------------
/* 
[������������ > �����ڵ庯��]
gameid=xxx
changemode=1
ccode=1
exec spu_ChangeInfo 'SangSang', '7575970askeie1595312', 1, 1, -1, '-1', -1					-- [������������ > �����ڵ庯��]
exec spu_ChangeInfo 'SangSang', '7575970askeie1595312', 1, 2, -1, '-1', -1					-- [������������ > �����ڵ庯��]
exec spu_ChangeInfo 'SangSang', '7575970askeie1595312', 1, 3, -1, '-1', -1					-- [������������ > �����ڵ庯��]
exec spu_ChangeInfo 'SangSang', '7575970askeie1595312', 1, 4, -1, '-1', -1					-- [������������ > �����ڵ庯��]

[������������ > �ƹ�Ÿ����]
gameid=xxx
changemode=2
avatar=1
exec spu_ChangeInfo 'SangSang', '7575970askeie1595312', 2, -1, 2, '-1', -1					-- [������������ > �ƹ�Ÿ����]

[������������ > ��������]
gameid=xxx
changemode=3
picture=xzqxwcevreasdfeas
exec spu_ChangeInfo 'SangSang', '7575970askeie1595312', 3, -1, -1, 'xzqxwcevreasdfeas', -1	-- [������������ > ��������]
exec spu_ChangeInfo 'SangSang', '7575970askeie1595312', 3, -1, -1, '-1', -1, -1					

declare @gameid varchar(20)		set @gameid = 'SangSang'
select * from dbo.tUserMaster where gameid = @gameid
select avatar, ccode from dbo.tUserMaster where gameid = @gameid

-- ������ �����ϰ� ���Դٴ� �÷���
declare @gameid varchar(20)		set @gameid = 'SangSang'
update dbo.tUserMaster set avatar = 1, ccode = 1 where gameid = @gameid
select avatar, ccode from dbo.tUserMaster where gameid = @gameid

[������������ > �ǹ�����]
select * from dbo.tUserMaster where gameid = 'superman2'
exec spu_ChangeInfo 'superman', '7575970askeie1595312', 4, -1, -1, '-1', -1					-- [�ǹ�����]
*/

IF OBJECT_ID ( 'dbo.spu_ChangeInfo', 'P' ) IS NOT NULL 
    DROP PROCEDURE dbo.spu_ChangeInfo;
GO 

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_ChangeInfo
	@gameid_								varchar(20),				-- ���Ӿ��̵�
	@password_								varchar(20),				-- ��ȣȭ�ؼ�����, �����н����� ��ŷ���ص� ����
	@changemode_							int,
	@ccode_									int,						-- mode 1
	@avatar_								int,						-- mode 2
	@picture_								varchar(60),				-- mode 3
	@nResult_								int					OUTPUT
	WITH ENCRYPTION -- ���ν����� ��ȣȭ��.
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
	
	-- ��Ÿ����
	declare @RESULT_ERROR_RESULT_COPY			int				set @RESULT_ERROR_RESULT_COPY			= -53			-- ���ī�ǽõ�
	declare @RESULT_ERROR_SILVER_COPY			int				set @RESULT_ERROR_SILVER_COPY			= -54			-- �ǹ�ī�ǽõ�
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- ���������ʴ¸��
	declare @RESULT_ERROR_ACTION_FULL			int				set @RESULT_ERROR_ACTION_FULL			= -71			-- ���������ʴ¸��
	declare @RESULT_ERROR_WIN_LACK				int				set @RESULT_ERROR_WIN_LACK				= -72			-- ������Ʈ ����.
	declare @RESULT_ERROR_TUTORIAL_ALREADY		int				set @RESULT_ERROR_TUTORIAL_ALREADY		= -73			-- ���丮�� �̹� ����.
	declare @RESULT_ERROR_FRIEND_ADD_MYGAMEID	int				set @RESULT_ERROR_FRIEND_ADD_MYGAMEID	= -74	
	declare @RESULT_ERROR_NOT_FOUND_GIFTID		int				set @RESULT_ERROR_NOT_FOUND_GIFTID		= -75			-- ĳ�� > ������ ���̵� ��ã��
	
	-- �����߿� ����.
	declare @RESULT_ERROR_ACTION_LACK			int				set @RESULT_ERROR_ACTION_LACK			= -20			--�ൿ���� �����ϴ�.
	declare @RESULT_ERROR_SILVERBALL_LACK		int				set @RESULT_ERROR_SILVERBALL_LACK		= -21			--�ǹ��� �����ϴ�.
	declare @RESULT_ERROR_GOLDBALL_LACK			int				set @RESULT_ERROR_GOLDBALL_LACK			= -22			--��尡 �����ϴ�.
	declare @RESULT_ERROR_ITEM_LACK				int				set @RESULT_ERROR_ITEM_LACK				= -23			--�������̺����ϴ�.
	declare @RESULT_ERROR_COIN_LACK				int				set @RESULT_ERROR_COIN_LACK				= -24			--������ �����ϴ�.
	
	--�����
	declare @CHANGE_MODE_COUNTYR				int				set @CHANGE_MODE_COUNTYR				= 1
	declare @CHANGE_MODE_AVATAR					int				set @CHANGE_MODE_AVATAR					= 2
	declare @CHANGE_MODE_PICTURE				int				set @CHANGE_MODE_PICTURE				= 3
	declare @CHANGE_MODE_MARKET_BOARD_WRITE		int				set @CHANGE_MODE_MARKET_BOARD_WRITE		= 4
	
	-- ���޿���
	declare @MARKET_BOARD_NOT_WRITE				int				set @MARKET_BOARD_NOT_WRITE				= 0
	declare @MARKET_BOARD_WRITEED				int				set @MARKET_BOARD_WRITEED				= 1
	-- ���޾׼�
	declare @MARKET_BOARD_WRITEED_REWARD_SB		int 			set @MARKET_BOARD_WRITEED_REWARD_SB		= 2000				-- 5��������� �����Ͽ����ϴ�.
	
	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @actioncount	int
	declare	@actionmax		int
	declare @actiontime		datetime
	declare @ccodeOriginal	int
	
	declare @comment		varchar(512)	
	declare @gameid			varchar(20)
	declare @mboardstate	int
	declare @plussb			int				set @plussb 		= 0

Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR	
	set @comment = 'ERROR �˼� ���� ������ �߻��Ͽ����ϴ�.'
	
	------------------------------------------------
	--	3-1. �������� ����
	------------------------------------------------
	select 
		@gameid = gameid,
		@mboardstate = mboardstate
	from dbo.tUserMaster 
	where gameid = @gameid_ and password = @password_
	
	
	-----------------------------------------------
	--	3-2. ������ϱ�
	-----------------------------------------------
	if(isnull(@gameid, '') = '')
		begin
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment = 'ERROR ���̵� ã�� ���߽��ϴ�.'
		END
	else if(@changemode_ not in (@CHANGE_MODE_COUNTYR, @CHANGE_MODE_AVATAR, @CHANGE_MODE_PICTURE, @CHANGE_MODE_MARKET_BOARD_WRITE))
		begin
			set @nResult_ = @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment = 'ERROR �������� �ʴ� ����Դϴ�.'
		end
	else if(@changemode_ = @CHANGE_MODE_COUNTYR)		
		BEGIN	
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS �����ڵ庯��'
			if(@ccode_ < 2 or @ccode_ > 10)
				begin
					set @ccode_ = 2
				end
			
			select @ccodeOriginal = ccode from dbo.tUserMaster where gameid = @gameid_
			
			--select ' DEBUG ��������(��)', ccode from dbo.tUserMaster where gameid = @gameid_
			update dbo.tUserMaster 
				set ccode = @ccode_
			where gameid = @gameid_
			--select ' DEBUG ��������(��)', ccode from dbo.tUserMaster where gameid = @gameid_
			
			-- ������ > +1
			update dbo.tBattleCountryClub set cnt = cnt + 1 where ccode = @ccode_
			
			-- ������ > -1
			update dbo.tBattleCountryClub set cnt = cnt - 1 where ccode = @ccodeOriginal
		END
	else if(@changemode_ = @CHANGE_MODE_AVATAR)		
		BEGIN	
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS �ƹ�Ÿ�ڵ庯��'
			
			--select ' DEBUG �ƹ�Ÿ�ڵ庯��(��)', avatar from dbo.tUserMaster where gameid = @gameid_
			update dbo.tUserMaster 
				set avatar = @avatar_
			where gameid = @gameid_
			--select ' DEBUG �ƹ�Ÿ�ڵ庯��(��)', avatar from dbo.tUserMaster where gameid = @gameid_
		END
	else if(@changemode_ = @CHANGE_MODE_PICTURE)		
		BEGIN	
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS ��������'
			
			--select ' DEBUG ��������(��)', picture from dbo.tUserMaster where gameid = @gameid_
			update dbo.tUserMaster 
				set picture = @picture_
			where gameid = @gameid_
			--select ' DEBUG ��������(��)', picture from dbo.tUserMaster where gameid = @gameid_
		END		
	else if(@changemode_ = @CHANGE_MODE_MARKET_BOARD_WRITE)		
		BEGIN	
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS ��Ż纰 ��õ�� �ۼ��ϱ�'
			
			--select 'DEBUG (��)', gameid, mboardstate, goldball from dbo.tUserMaster where gameid = @gameid_
			if(isnull(@gameid, '') != '' and @mboardstate = @MARKET_BOARD_NOT_WRITE)
				BEGIN
					--select 'DEBUG �ǹ�������, üŷ����'
					update dbo.tUserMaster 
						set
							silverball = silverball + @MARKET_BOARD_WRITEED_REWARD_SB,
							mboardstate = @MARKET_BOARD_WRITEED
					where gameid = @gameid_
					
					set @plussb = @MARKET_BOARD_WRITEED_REWARD_SB
				END	
			--select 'DEBUG (��)', gameid, mboardstate, goldball from dbo.tUserMaster where gameid = @gameid_
			
			--select ' DEBUG �ƹ�Ÿ�ڵ庯��(��)', avatar from dbo.tUserMaster where gameid = @gameid_
		END
	else
		BEGIN	
			set @nResult_ = @RESULT_ERROR
			set @comment = 'ERROR �ڵ尡 �Ҹ�Ȯ�ϴ�.'
			
		END
	
	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	select @nResult_ rtn, @comment comment, @plussb plussb, @changemode_ changemode
	
	select * from dbo.tUserMaster where gameid = @gameid_
	
	set nocount off
	
End

