/*

exec spu_FVChangePW 'xxxx0',   '049000s1i0n7t8445289', '01011112221', -1
exec spu_FVChangePW 'xxxx',   '049000s1i0n7t8445289', '01011112227', -1
exec spu_FVChangePW 'xxxx',   '049000s1i0n7t8445289', '01011112221', -1
*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVChangePW', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVChangePW;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_FVChangePW
	@gameid_								varchar(60),
	@passwordnew_							varchar(20),
	@phone_									varchar(20),
	@nResult_								int					OUTPUT
	--WITH ENCRYPTION
as
	------------------------------------------------
	--	2-1. �ڵ尪�ڸ�
	------------------------------------------------
	-- �Ϲݰ�
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	--���� ����.
	declare @RESULT_ERROR_ID_DUPLICATE			int				set @RESULT_ERROR_ID_DUPLICATE			= -2

	-- �α��� ����.
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

	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @gameid				varchar(60)
	declare @phone				varchar(20)
	declare @comment			varchar(80)


Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	set @comment = 'ERROR �˼����� ����(-1)'
	--select 'DEBUG ', @gameid_ gameid_, @passwordnew_ passwordnew_, @phone_ phone_

	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	select
		@gameid = gameid, @phone = phone
	from dbo.tFVUserMaster
	where gameid = @gameid_

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
			update dbo.tFVUserMaster
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



