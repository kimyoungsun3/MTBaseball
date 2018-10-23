/*
exec spu_Login 'mtxxxx3', '049000s1i0n7t8445289', 100, '192.168.0.8', -1	-- ��������
exec spu_Login 'xxxx', '049000s1i0n7t8445288', 100, '192.168.0.8', -1		-- ���Ʋ��
exec spu_Login 'xxxx0','049000s1i0n7t8445289', 100, '192.168.0.8', -1		-- ��������
exec spu_Login 'xxxx', '049000s1i0n7t8445289',  99, '192.168.0.8', -1		-- ���Ϲ�������
exec spu_Login 'xxxx3','049000s1i0n7t8445289', 100, '192.168.0.8', -1		-- ������
update dbo.tUserMaster set cashcopy = 3 where gameid = 'xxxx5'				-- ĳ��ī�� > ��ó��
exec spu_Login 'xxxx5', '049000s1i0n7t8445289', 100, '192.168.0.8', -1
update dbo.tUserMaster set resultcopy = 100 where gameid = 'xxxx6'			-- ���Ű�� > ��ó��
exec spu_Login 'xxxx6', '049000s1i0n7t8445289', 100, '192.168.0.8', -1

exec spu_Login 'xxxx', '049000s1i0n7t8445289', 199, '192.168.0.8', -1		-- ��������
exec spu_Login 'xxxx2', '049000s1i0n7t8445289',119, '192.168.0.8', -1		-- ��������
exec spu_Login 'xxxx3', '049000s1i0n7t8445289',199, '192.168.0.8', -1		-- ��������
exec spu_Login 'xxxx6', '049000s1i0n7t8445289',199, '192.168.0.8', -1		-- ��������
*/
use GameMTBaseball
Go

IF OBJECT_ID ( 'dbo.spu_Login', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_Login;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_Login
	@gameid_								varchar(20),					-- ���Ӿ��̵�
	@password_								varchar(20),					-- ��ȣȭ�ؼ�����, �����н����� ��ŷ���ص� ����
	@version_								int,							-- Ŭ�����
	@connectip_								varchar(60),					-- ���� IP
	@nResult_								int					OUTPUT
	WITH ENCRYPTION -- ���ν����� ��ȣȭ��.
as
	------------------------------------------------
	--	2-1. �ڵ尪�ڸ�
	------------------------------------------------
	-- MT �Ϲݰ�
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	-- MT �α��� ����.
	declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--������ > �˾�ó���� ��Ʈ�η� ��������.
	declare @RESULT_ERROR_DELETED_USER 			int				set @RESULT_ERROR_DELETED_USER			= -12			--�������� > �˾�ó���� ��Ʈ�η� ��������.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--�ش������� ã�� ����
	declare @RESULT_ERROR_NOT_FOUND_PASSWORD	int				set @RESULT_ERROR_NOT_FOUND_PASSWORD	= -17
	declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--������ �����ϰ� �ִ�.
	declare @RESULT_NEWVERION_CLIENT_DOWNLOAD 	int				set @RESULT_NEWVERION_CLIENT_DOWNLOAD	= -15			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ��ũó��.
	declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ����.
	declare @RESULT_ERROR_NOT_FOUND_PHONE 		int				set @RESULT_ERROR_NOT_FOUND_PHONE		= -76			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ����.

	------------------------------------------------
	--	2-2. ���°�
	------------------------------------------------
	-- MT �����°�.
	declare @BLOCK_STATE_NO						int					set	@BLOCK_STATE_NO							= 0	-- �����¾ƴ�
	declare @BLOCK_STATE_YES					int					set	@BLOCK_STATE_YES						= 1	-- ������

	-- MT �ý��� üŷ
	declare @SYSCHECK_NON						int					set @SYSCHECK_NON							= 0
	declare @SYSCHECK_YES						int					set @SYSCHECK_YES							= 1

	-- MT �����ۺ� �κ��з�
	declare @USERITEM_INVENKIND_WEAR			int 				set @USERITEM_INVENKIND_WEAR				= 1
	declare @USERITEM_INVENKIND_PIECE			int 				set @USERITEM_INVENKIND_PIECE				= 2
	declare @USERITEM_INVENKIND_CONSUME			int 				set @USERITEM_INVENKIND_CONSUME				= 3

	-- ���û���.
	declare @GAME_STATE_ING						int					set @GAME_STATE_ING							= -1	-- ����������.
	declare @GAME_STATE_ROLLBACK				int					set @GAME_STATE_ROLLBACK					= -2	-- �ѹ鿹����.
	declare @GAME_STATE_ROLLBACK_CHECK			int					set @GAME_STATE_ROLLBACK_CHECK				= -3	-- �ý������˿���.
	declare @GAME_STATE_SUCCESS					int					set @GAME_STATE_SUCCESS						= 0		-- ����ó��.
	declare @GAME_STATE_FAIL_LOGIN_MOLSU		int					set @GAME_STATE_FAIL_LOGIN_MOLSU			= 10	-- ��α������� ����.
	declare @GAME_STATE_FAIL_LOGIN_ROLLBACK		int					set @GAME_STATE_FAIL_LOGIN_ROLLBACK			= 11	-- ��α������� �ѹ�
	declare @GAME_STATE_FAIL_ADMIN_DEL			int					set @GAME_STATE_FAIL_ADMIN_DEL				= 12	-- �����ڰ� ������.
	declare @GAME_STATE_FAIL_ADMIN_ROLLBACK		int					set @GAME_STATE_FAIL_ADMIN_ROLLBACK			= 13	-- �����ڰ� �ѹ�ó��.
	declare @GAME_STATE_FAIL_CHECK_ROLLBACK		int					set @GAME_STATE_FAIL_CHECK_ROLLBACK			= 14	-- �ý��� �ѹ�.
	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @comment				varchar(512)			set @comment		= '�α���'
	declare @gameid					varchar(20)				set @gameid			= ''
	declare @password				varchar(20)				set @password		= ''
	declare @blockstate				int
	declare @cashcopy				int
	declare @resultcopy				int
	declare @version				int						set @version		= 100

	declare @curversion				int						set @curversion		= -1
	declare @cursyscheck			int

	-- �Ϲݺ�����
	declare @logindate				varchar(8)				set @logindate		= '20100101'
	--declare @dateid10 			varchar(10) 			set @dateid10 		= Convert(varchar(8), Getdate(),112) + Convert(varchar(2), Getdate(), 108)
	declare @dateid8 				varchar(8) 				set @dateid8 		= Convert(varchar(8), Getdate(),112)
	declare @curdate				datetime				set @curdate		= getdate()
	declare @rand					int

	-- �̱۰��� ����, �ѹ�ó��.
	declare @idx					int						set @idx			= -1
	declare @gamestate				int						set @gamestate		= @GAME_STATE_ING
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG �Է�����', @gameid_ gameid_, @password_ password_, @version_ version_, @connectip_ connectip_

	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	select
		@gameid 		= gameid,			@password		= password,
		@blockstate 	= blockstate,
		@cashcopy 		= cashcopy, 		@resultcopy 	= resultcopy,
		@logindate		= logindate
	from dbo.tUserMaster
	where gameid = @gameid_
	--select 'DEBUG ��������', @gameid gameid, @password password, @blockstate blockstate, @cashcopy cashcopy, @resultcopy resultcopy, @logindate logindate

	------------------------------------------------
	--	3-3. �������� üũ
	------------------------------------------------
	select top 1 @cursyscheck = syscheck, @curversion = version from dbo.tNotice
	order by idx desc
	--select 'DEBUG ��������', @cursyscheck cursyscheck, @curversion curversion

	if(@cursyscheck = @SYSCHECK_YES)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_SERVER_CHECKING
			set @comment 	= 'DEBUG �ý��� �������Դϴ�.'
			--select 'DEBUG ', @comment
		END
	else if(@gameid = '' or @password != @password_)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '���̵� �������� �ʴ´�. > ���̵� Ȯ���ض�.'
			--select 'DEBUG ', @comment
		END
	else if(@version_ < @curversion)
		BEGIN
			-- ���Ϻ� ������ Ʋ����
			set @nResult_ 	= @RESULT_NEWVERION_CLIENT_DOWNLOAD
			set @comment 	= '���Ϻ� ������ Ʋ����. > �ٽù޾ƶ�.'
			--select 'DEBUG ', @comment
		END
	else if (@blockstate = @BLOCK_STATE_YES)
		BEGIN
			-- �������ΰ�?
			set @nResult_ 	= @RESULT_ERROR_BLOCK_USER
			set @comment 	= '��ó���� ���̵��Դϴ�.'
			--select 'DEBUG ', @comment
		END
	else if(@cashcopy >= 2)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_BLOCK_USER
			set @comment 	= 'ĳ������ī�Ǹ� '+ltrim(rtrim(str(@cashcopy)))+'ȸ �̻��ߴ�. > ��ó������!!'
			--select 'DEBUG ', @comment

			-- xxȸ �̻�ī���ൿ > ��ó��, ���αױ��
			update dbo.tUserMaster
				set
					blockstate = @BLOCK_STATE_YES,
					cashcopy = 0
			where gameid = @gameid_

			-- ������3ȸ ī�ǿ� ���� ��ó��
			insert into dbo.tUserBlockLog(gameid, comment)
			values(@gameid_, '(ĳ������)��  '+ltrim(rtrim(str(@cashcopy)))+'ȸ �̻� ī�Ǹ� �ؼ� �α��ν� �ý��ۿ��� �� ó���߽��ϴ�.')
		END
	else if(@resultcopy >= 20)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_BLOCK_USER
			set @comment 	= '����������� '+ltrim(rtrim(str(@resultcopy)))+'ȸ�̻� �õ��ߴ�. > ��ó������!!'
			--select 'DEBUG ', @comment

			--��������� xxȸ �̻��ߴ�. > ��ó��, ���αױ��
			update dbo.tUserMaster
				set
					blockstate = @BLOCK_STATE_YES,
					resultcopy = 0
			where gameid = @gameid_

			-- ������3ȸ ī�ǿ� ���� ��ó��
			insert into dbo.tUserBlockLog(gameid, comment)
			values(@gameid_, '����������� '+ltrim(rtrim(str(@resultcopy)))+'ȸ�̻� �õ��ؼ� �α��ν� �ý��ۿ��� �� ó���߽��ϴ�.')
		END
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '�α��� ����ó��'
			--select 'DEBUG ', @comment
		END


	-----------------------------------------------
	-- ����ڵ�ó��.
	-----------------------------------------------
	select @nResult_ rtn, @comment comment

	if(@nResult_ = @RESULT_SUCCESS)
		BEGIN
			------------------------------------------------------------------
			-- ���� > �α��� ī����
			------------------------------------------------------------------
			if(@logindate != @dateid8)
				begin
					exec spu_DayLogInfoStatic 12, 1               -- �� �α���(�ߺ�)
					exec spu_DayLogInfoStatic 14, 1               -- �� �α���(����ũ)
				end
			else
				begin
					exec spu_DayLogInfoStatic 12, 1               -- �� �α���(�ߺ�)
				end
			set @logindate = @dateid8

			-----------------------------------------------
			-- * �α����Ҷ� �Ҹ��� ������ ���������Ѵ�.
			-----------------------------------------------
			delete from dbo.tUserItem where gameid = @gameid and invenkind = @USERITEM_INVENKIND_CONSUME and cnt <= 0


			-----------------------------------------------
			-- * ������ ���ð˻�
			--	-1 -> ��α������θ���(10)
			--		  ���� ȯ�� ó���ع�����
			--	-2 -> ��α������ηѹ�(11)
			--		  ����(�Ҹ���, ����) �ѹ�ó���ؼ� ������.
			-----------------------------------------------
			declare curSingleGame Cursor for
			select idx, gamestate from dbo.tSingleGame where gameid = @gameid_ order by idx asc

			Open curSingleGame
			Fetch next from curSingleGame into @idx, @gamestate
			while @@Fetch_status = 0
				Begin
					--select 'DEBUG �̱�ó��', @idx idx, @gamestate gamestate
					if( @gamestate = @GAME_STATE_ING )
						begin
							--select 'DEBUG -1 > ����ó��', @idx idx, @gamestate gamestate
							exec dbo.spu_BetRollBack @GAME_STATE_FAIL_LOGIN_MOLSU, @gameid_, @idx
						end
					else if( @gamestate = @GAME_STATE_ROLLBACK )
						begin
							--select 'DEBUG -2 > �ѹ�ó��', @idx idx, @gamestate gamestate
							exec dbo.spu_BetRollBack @GAME_STATE_FAIL_LOGIN_ROLLBACK, @gameid_, @idx
						end
					else if( @gamestate = @GAME_STATE_ROLLBACK_CHECK )
						begin
							--select 'DEBUG -3 > �ѹ�ó��', @idx idx, @gamestate gamestate
							exec dbo.spu_BetRollBack @GAME_STATE_FAIL_CHECK_ROLLBACK, @gameid_, @idx
						end


					Fetch next from curSingleGame into @idx, @gamestate
				end
			close curSingleGame
			Deallocate curSingleGame


			-----------------------------------------------
			-- * �������� ���� ������.
			-----------------------------------------------
			delete from dbo.tPracticeGame where gameid = @gameid_

			------------------------------------------------------------------
			-- ���� ������ ������Ʈ�ϱ�
			------------------------------------------------------------------
			update dbo.tUserMaster
				set
					version			= @version_,
					connectip		= @connectip_,
					logindate		= @logindate,	-- �α��γ�¥��.

					sid				= dbo.fnu_GetRandom( 100, 10000),

					condate			= getdate(),	-- ����������
					concnt			= concnt + 1	-- ����Ƚ�� +1
			where gameid = @gameid_

			----------------------------------------------
			-- ���� ����
			---------------------------------------------
			select
				*, @curdate curdate
			 from dbo.tUserMaster where gameid = @gameid_

			--------------------------------------------------------------
			-- ���� ������ ��ü ����Ʈ
			-- ����(��������[�ֱٰ�], �κ�, �ʵ�, ��ǥ), �Һ���, �Ǽ��縮
			--------------------------------------------------------------
			select * from dbo.tUserItem
			where gameid = @gameid_ and invenkind in (@USERITEM_INVENKIND_WEAR, @USERITEM_INVENKIND_PIECE, @USERITEM_INVENKIND_CONSUME )
			order by invenkind, itemcode

			--------------------------------------------------------------
			-- ���� ����/����(����, ������ɺ��� ����)
			--------------------------------------------------------------
			exec spu_GiftList @gameid_

			------------------------------------------------------------------
			-- ��������
			------------------------------------------------------------------
			select top 1 * from dbo.tNotice order by idx desc

		END

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off
End



