use Farm
Go
/*
update dbo.tFVUserMaster set nickname = '' where gameid = 'xxxx@gmail.com'
exec spu_FVNickName 'xxxx@gmail.com',  '01022223331', '�׽��ο�', -1
exec spu_FVNickName 'xxxx@gmail.com',  '01022223331', 'nn', -1
exec spu_FVNickName 'xxxx@gmail.com',  '01022223331', '', -1
select nickname from dbo.tFVUserMaster where gameid = 'xxxx@gmail.com'

*/

IF OBJECT_ID ( 'dbo.spu_FVNickName', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVNickName;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_FVNickName
	@gameid_								varchar(60),				-- ���Ӿ��̵�
	@phone_									varchar(20),
	@nickname_								varchar(20),
	@nResult_								int					OUTPUT
	--WITH ENCRYPTION -- ���ν����� ��ȣȭ��.
as
	------------------------------------------------
	--	2-1. �ڵ尪�ڸ�
	------------------------------------------------
	-- �Ϲݰ�
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--�ش������� ã�� ����

	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @comment				varchar(512)			set @comment		= ''
	declare @gameid 				varchar(60)				set @gameid			= ''

Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG �Է�����', @gameid_ gameid_, @phone_ phone_, @nickname_ nickname_

	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	select
		@gameid 	= gameid
	from dbo.tFVUserMaster
	where gameid = @gameid_ and phone = @phone_
	--select 'DEBUG ��������', @gameid gameid

	if(@gameid = '')
		BEGIN
			-- ���̵� ���������ʴ°�??
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '���̵� �������� �ʴ´�.'
			--select 'DEBUG ', @comment
		END
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '�г��� �����߽��ϴ�.'
			--select 'DEBUG ', @comment
			if(@nickname_ = '')
				begin
					set @nickname_ = @gameid_
				end

			---------------------------------------------------
			-- ���� ���� ����
			---------------------------------------------------
			update dbo.tFVUserMaster
				set
					nickname 	= @nickname_,
					nickcnt		= nickcnt + 1
			from dbo.tFVUserMaster
			where gameid = @gameid_

		END

	-----------------------------------------------
	-- ����ڵ�ó��.
	-----------------------------------------------
	select @nResult_ rtn, @comment comment

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off
End



