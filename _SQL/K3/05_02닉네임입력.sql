use Game4FarmVill3
Go
/*
-- select top 10 nickname, gameid from dbo.tFVUserMaster
update dbo.tFVUserMaster set nickname = '' where gameid = 'xxxx2'
exec spu_FVNickName 'xxxx2',  '049000s1i0n7t8445289', '�׽��ο�', -1
exec spu_FVNickName 'xxxx2',  '049000s1i0n7t8445289', 'nn', -1
exec spu_FVNickName 'xxxx2',  '049000s1i0n7t8445289', '��������', -1
select nickname from dbo.tFVUserMaster where gameid = 'xxxx2'
select * from dbo.tFVUserNickNameChange where gameid = 'xxxx2' order by idx desc

*/

IF OBJECT_ID ( 'dbo.spu_FVNickName', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVNickName;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_FVNickName
	@gameid_								varchar(60),				-- ���Ӿ��̵�
	@password_								varchar(20),
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
	declare @RESULT_ERROR_CANNOT_USED_NICKNAME	int				set @RESULT_ERROR_CANNOT_USED_NICKNAME	= -141			-- �г��� ���Ұ�.

	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @comment				varchar(512)			set @comment		= ''
	declare @gameid 				varchar(60)				set @gameid			= ''
	declare @oldnickname			varchar(20)				set @oldnickname	= ''

Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG �Է�����', @gameid_ gameid_, @password_ password_, @nickname_ nickname_

	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	select
		@gameid 	= gameid,
		@oldnickname= nickname
	from dbo.tFVUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG ��������', @gameid gameid

	if(@gameid = '')
		BEGIN
			-- ���̵� ���������ʴ°�??
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '���̵� �������� �ʴ´�.'
			--select 'DEBUG ', @comment
		END
	else if exists (select * from tFVUserMaster where gameid != @gameid_ and nickname = @nickname_)
		BEGIN
			-- ���̵� ���������ʴ°�??
			set @nResult_ 	= @RESULT_ERROR_CANNOT_USED_NICKNAME
			set @comment 	= '�г����� ����� �� �����ϴ�(�ߺ�).'
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
					nickname 	= @nickname_
			from dbo.tFVUserMaster
			where gameid = @gameid_


			---------------------------------------------------
			-- ������ ���.
			---------------------------------------------------
			if(@oldnickname != '')
				begin
					insert into dbo.tFVUserNickNameChange(gameid,   oldnickname, newnickname)
					values(                              @gameid_, @oldnickname,  @nickname_)
				end

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



