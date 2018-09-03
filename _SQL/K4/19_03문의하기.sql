/*
select * from dbo.tFVSysInquire order by idx desc
exec spu_FVSysInquire 'xxxx2', '049000s1i0n7t8445289', '[���ݹ���]�����մϴ�..', -1
*/
use Game4FarmVill4
GO

IF OBJECT_ID ( 'dbo.spu_FVSysInquire', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVSysInquire;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_FVSysInquire
	@gameid_								varchar(60),					-- ���Ӿ��̵�
	@password_								varchar(20),
	@message_								varchar(1024),
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
	--select 'DEBUG �Է�����', @gameid_ gameid_, @message_ message_

	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	select
		@gameid 		= gameid
	from dbo.tFVUserMaster
	where gameid = @gameid_
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
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'SUCCESS �۾��� ����.'
			--select 'DEBUG ' + @comment

			-- �Է�
			insert into dbo.tFVSysInquire(gameid,   comment)
			values(                      @gameid_, @message_)
		END


	--------------------------------------------------------------
	-- �������.
	--------------------------------------------------------------
	select @nResult_ rtn, @comment comment

	------------------------------------------------
	--	4-2. ��������
	------------------------------------------------
	set nocount off
End

