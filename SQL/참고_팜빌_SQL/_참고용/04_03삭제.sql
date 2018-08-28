/*
--����ó������
exec spu_FVDeleteID 'xxxx0', 'a1s2d3f4', -1
exec spu_FVDeleteID 'xxxx', 'a1s2d3f4', -1
*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVDeleteID', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVDeleteID;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_FVDeleteID
	@gameid_								varchar(60),					-- ���Ӿ��̵�
	@password_								varchar(20),					-- ��ȣȭ�ؼ�����, �����н����� ��ŷ���ص� ����
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
	declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--������ > �˾�ó���� ��Ʈ�η� ��������.
	declare @RESULT_ERROR_DELETED_USER 			int				set @RESULT_ERROR_DELETED_USER			= -12			--�������� > �˾�ó���� ��Ʈ�η� ��������.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--�ش������� ã�� ����
	declare @RESULT_ERROR_NOT_FOUND_PASSWORD	int				set @RESULT_ERROR_NOT_FOUND_PASSWORD	= -17
	declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--������ �����ϰ� �ִ�.
	declare @RESULT_NEWVERION_CLIENT_DOWNLOAD 	int				set @RESULT_NEWVERION_CLIENT_DOWNLOAD	= -15			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ��ũó��.
	declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ����.

	------------------------------------------------
	--	2-2. ���°�
	------------------------------------------------
	-- �������°�.
	declare @DELETE_STATE_NO					int					set	@DELETE_STATE_NO				= 0	-- �������¾ƴ�
	declare @DELETE_STATE_YES					int					set	@DELETE_STATE_YES				= 1	-- ��������

	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @gameid 		varchar(60)
	declare @password 		varchar(20)
	declare @deletestate	int
	declare @comment		varchar(80)

Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG �Է°�', @gameid_ gameid_, @password_ password_

	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	select
		@gameid 		= gameid,
		@password 		= password,
		@deletestate 	= deletestate
	from dbo.tFVUserMaster
	where gameid = @gameid_
	--select 'DEBUG �˻���', @gameid gameid, @password password, @deletestate deletestate

	if(isnull(@gameid, '') = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '���̵� �������� �ʴ´�.'
		END
	else if(isnull(@password, '') = '' or @password != @password_)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_PASSWORD
			set @comment 	= '�н����� Ʋ�ȴ�.'
		END
	else if(@deletestate = @DELETE_STATE_YES)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '���� ó���߽��ϴ�.(�̹�����)'
		END
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '���� ó���߽��ϴ�.'

			-- ������������ϱ�
			update dbo.tFVUserMaster
				set
					deletestate = @DELETE_STATE_YES
			where gameid = @gameid_

			-- �����α� ����ϱ�
			insert into dbo.tFVUserDeleteLog(gameid, comment)
			values(@gameid_, '������ ���������߽��ϴ�.')
		END

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off
	select @nResult_ rtn, @comment comment
End



