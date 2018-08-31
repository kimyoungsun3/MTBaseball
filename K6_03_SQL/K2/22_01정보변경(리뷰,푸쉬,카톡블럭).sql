/*
exec spu_FVChangeInfo 'xxxx@gmail.com',  '01022223331', 11, -1		-- Ǫ������/����

--select kakaomsgblocked from dbo.tUserMaster where gameid = 'xxxx@gmail.com'
exec spu_FVChangeInfo 'xxxx@gmail.com',  '01022223331', 12, -1		-- īī�� �޼��� �ڱ�� �ź�
*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVChangeInfo', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVChangeInfo;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_FVChangeInfo
	@gameid_								varchar(60),					-- ���Ӿ��̵�
	@phone_									varchar(20),
	@mode_									int,
	@nResult_								int					OUTPUT
	--WITH ENCRYPTION -- ���ν����� ��ȣȭ��.
as
	------------------------------------------------
	--	2-1. �ڵ尪�ڸ�
	------------------------------------------------
	-- �Ϲݰ�
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	-- �α��� ����.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--�ش������� ã�� ����

	-- ��Ÿ����
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- ���������ʴ¸��
	declare @RESULT_ERROR_NOT_FOUND_USERFARM	int				set @RESULT_ERROR_NOT_FOUND_USERFARM	= -125			-- ���帮��Ʈ�� �̱���.

	------------------------------------------------
	--	2-2. ���°�
	------------------------------------------------
	-- ���� ���� ������.
	declare @USERMASTER_CHANGEINOF_MODE_KKOPUSHALLOW	int		set @USERMASTER_CHANGEINOF_MODE_KKOPUSHALLOW	= 11		-- īī���� Ǫ��.
	declare @USERMASTER_CHANGEINOF_MODE_KKOMSGBLOCKED	int		set @USERMASTER_CHANGEINOF_MODE_KKOMSGBLOCKED	= 12		-- īī���� �޼�����.

	-- ���忡 �۾���.
	declare @BOARD_STATE_NON					int				set @BOARD_STATE_NON				= 0
	declare @BOARD_STATE_REWARD					int				set @BOARD_STATE_REWARD				= 1

	--ī�� �޼��� ��.
	declare @KAKAO_MESSAGE_ALLOW 				int				set @KAKAO_MESSAGE_ALLOW						= -1		-- īī�� �޼��� �߼۰���.
	declare @KAKAO_MESSAGE_BLOCK 				int				set @KAKAO_MESSAGE_BLOCK						=  1		-- īī�� �޼��� �Ұ���.

	-- Yes/No
	-- üŷ
	declare @INFOMATION_NO						int				set @INFOMATION_NO					= -1
	declare @INFOMATION_YES						int				set @INFOMATION_YES					=  1

	------------------------------------------------
	--	2-3. ���λ�� ����
	------------------------------------------------
	declare @comment		varchar(128)

	declare @gameid			varchar(60)				set @gameid			= ''
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG �Է�����', @gameid_ gameid_, @phone_ phone_, @mode_ mode_

	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	select
		@gameid 		= gameid
	from dbo.tUserMaster
	where gameid = @gameid_ and phone = @phone_
	--select 'DEBUG ��������', @gameid gameid

	------------------------------------------------
	-- 3-3. �� ���Ǻ� �б�
	------------------------------------------------
	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR ���̵� �������� �ʴ´�.'
			--select 'DEBUG ' + @comment
		END
	else if (@mode_ not in (@USERMASTER_CHANGEINOF_MODE_KKOPUSHALLOW, @USERMASTER_CHANGEINOF_MODE_KKOMSGBLOCKED))
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment 	= 'ERROR �������� �ʴ� ����Դϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if (@mode_ = @USERMASTER_CHANGEINOF_MODE_KKOPUSHALLOW)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'SUCCESS �����Ͽ����ϴ�.'
			--select 'DEBUG ' + @comment

			update dbo.tUserMaster
				set
					kkopushallow	= case
											when kkopushallow = @INFOMATION_NO then @INFOMATION_YES
											else									@INFOMATION_NO
									  end
			where gameid = @gameid_
		END
	else if (@mode_ = @USERMASTER_CHANGEINOF_MODE_KKOMSGBLOCKED)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'SUCCESS �����Ͽ����ϴ�.'
			----select 'DEBUG ' + @comment

			update dbo.tUserMaster
				set
					kakaomsgblocked	= case
											when kakaomsgblocked = @KAKAO_MESSAGE_ALLOW then @KAKAO_MESSAGE_BLOCK
											else													 @KAKAO_MESSAGE_ALLOW
									  end
			where gameid = @gameid_
		END
	else
		begin
			set @nResult_ 	= @RESULT_ERROR
			set @comment 	= 'ERROR �˼����� ����(-1)'
		end


	--------------------------------------------------------------
	-- �������.
	--------------------------------------------------------------
	select @nResult_ rtn, @comment comment
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			--------------------------------------------------------------
			-- ���� ����.
			--------------------------------------------------------------
			select * from dbo.tUserMaster where gameid = @gameid_
		end

	------------------------------------------------
	--	4-2. ��������
	------------------------------------------------
	set nocount off
End

