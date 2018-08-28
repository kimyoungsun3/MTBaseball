/*
exec spu_FVCheckKakaoNickName 'xxxx2', '049000s1i0n7t8445289', '�г���2', -1
exec spu_FVCheckKakaoNickName 'xxxx2', '049000s1i0n7t8445289', '', -1
*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVCheckKakaoNickName', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVCheckKakaoNickName;
GO

create procedure dbo.spu_FVCheckKakaoNickName
	@gameid_				varchar(60),
	@password_				varchar(20),
	@kakaonickname			varchar(40),
	@nResult_				int				OUTPUT
	--WITH ENCRYPTION -- ���ν����� ��ȣȭ��.
as
	------------------------------------------------
	--	2-1. �����ڵ尪
	------------------------------------------------
	-- �Ϲݰ�
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1
	declare @RESULT_ERROR_CANNOT_USED_NICKNAME	int				set @RESULT_ERROR_CANNOT_USED_NICKNAME	= -141			-- �г��� ���Ұ�.

	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @comment		varchar(128)
	declare @gameid			varchar(60)		set @gameid			= ''
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	set @comment = '�˼� ���� ������ �߻��߽��ϴ�.'
	--select 'DEBUG 1', @kakaonickname kakaonickname

	------------------------------------------------
	--	3-2. ����ȹ��
	------------------------------------------------
	select
		@gameid = gameid
	from dbo.tFVUserMaster
	where kakaonickname = @kakaonickname and gameid != @gameid_
	--select 'DEBUG 2', @gameid gameid

	------------------------------------------------
	--	3-3. ��������.
	------------------------------------------------
	if (@gameid != '')
		begin
			set @nResult_ 	= @RESULT_ERROR_CANNOT_USED_NICKNAME
			set @comment 	= 'ERROR �г����� ���� ����ϰ� �ֽ��ϴ�.'
			--select 'DEBUG 3' + @comment
		end
	else
		begin
			set @nResult_ = @RESULT_SUCCESS
			set @comment = '�г����� �����Ͽ����ϴ�.'
			--select 'DEBUG 4', @comment

			update dbo.tFVUserMaster
				set
					kakaonickname = @kakaonickname
			where gameid = @gameid_
		end

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	select @nResult_ rtn, @comment comment

	--���� ����� �����Ѵ�.
	set nocount off
End



