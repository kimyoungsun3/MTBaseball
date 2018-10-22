/*
update dbo.tUserMaster set cashcost = 0 where gameid = 'mtxxxx3'
exec spu_CheckNickName 'mtxxxx3', '049000s1i0n7t8445289', '�г���12', -1		-- ������.

update dbo.tUserMaster set cashcost = 10000 where gameid = 'mtxxxx3'
exec spu_CheckNickName 'mtxxxx3', '049000s1i0n7t8445289', 333, 'mtnickname', -1		-- �ٸ� ����� �����...

update dbo.tUserMaster set cashcost = 10000 where gameid = 'mtxxxx3'
exec spu_CheckNickName 'mtxxxx3', '049000s1i0n7t8445289', 333, 'mt3', -1			-- �ּ�4�ڸ� ����...

update dbo.tUserMaster set cashcost = 10000 where gameid = 'mtxxxx3'
exec spu_CheckNickName 'mtxxxx3', '049000s1i0n7t8445289', 333, '�г���mt31', -1			-- ����ó��.
exec spu_CheckNickName 'mtxxxx3', '049000s1i0n7t8445289', 333, '�г���mt32', -1			-- ����ó��.
exec spu_CheckNickName 'mtxxxx3', '049000s1i0n7t8445289', 333, '�г���mt33', -1			-- ����ó��.

*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_CheckNickName', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_CheckNickName;
GO

create procedure dbo.spu_CheckNickName
	@gameid_				varchar(20),
	@password_				varchar(20),
	@sid_					int,
	@nickname_				varchar(40),
	@nResult_				int				OUTPUT
	--WITH ENCRYPTION -- ���ν����� ��ȣȭ��.
as
	------------------------------------------------
	--	2-1. �����ڵ尪
	------------------------------------------------
	-- �Ϲݰ�
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--�ش������� ã�� ����
	declare @RESULT_ERROR_CANNOT_USED_NICKNAME	int				set @RESULT_ERROR_CANNOT_USED_NICKNAME	= -141			-- �г��� ���Ұ�.
	declare @RESULT_ERROR_CASHCOST_LACK			int				set @RESULT_ERROR_CASHCOST_LACK			= -22			--��尡 �����ϴ�.
	declare @RESULT_ERROR_SESSION_ID_EXPIRE_LOGOUT	int			set @RESULT_ERROR_SESSION_ID_EXPIRE_LOGOUT	= -151		-- ������ ����Ǿ����ϴ�.

	-- �䱸ĳ��.
	declare @NICKNAME_CHANGE_NEED_CASHCOST		int				set @NICKNAME_CHANGE_NEED_CASHCOST		= 1000

	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @comment		varchar(128)	set @comment 		= '�˼� ���� ������ �߻��߽��ϴ�.'
	declare @gameid			varchar(20)		set @gameid			= ''
	declare @sid			int				set @sid			= -1
	declare @oldnickname	varchar(20)		set @oldnickname	= ''
	declare @cashcost 		int				set @cashcost		= 0
	declare @gamecost 		int				set @gamecost		= 0
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG 1', @gameid_ gameid_, @password_ password_, @nickname_ nickname_

	------------------------------------------------
	--	3-2. ����ȹ��
	------------------------------------------------
	select
		@gameid 		= gameid,		@cashcost		= cashcost,	@gamecost 		= gamecost,
		@oldnickname	= nickname,
		@sid			= sid
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG ', @gameid gameid, @cashcost cashcost, @gamecost gamecost, @oldnickname oldnickname, @sid sid

	------------------------------------------------
	--	3-3. ��������.
	------------------------------------------------
	if(@gameid = '')
		BEGIN
			-- ���̵� ���������ʴ°�??
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '���̵� �������� �ʴ´�.'
			--select 'DEBUG ', @comment
		END
	else if(@sid_ != @sid)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_SESSION_ID_EXPIRE_LOGOUT
			set @comment 	= 'ERROR ������ ���� �Ǿ����ϴ�. (�α׾ƿ� �����ּ���.)'
			--select 'DEBUG ' + @comment
		END
	else if( exists( select top 1 * from dbo.tUserMaster where nickname = @nickname_ and gameid != @gameid_ ) )
		begin
			set @nResult_ 	= @RESULT_ERROR_CANNOT_USED_NICKNAME
			set @comment 	= 'ERROR �г����� ���� ����ϰ� �ֽ��ϴ�.'
			--select 'DEBUG 3' + @comment
		end
	else if( LEN( @nickname_ ) < 4 )
		begin
			set @nResult_ 	= @RESULT_ERROR_CANNOT_USED_NICKNAME
			set @comment 	= '�ּ� 4�ڸ� �̻��̿��� �մϴ�.'
			--select 'DEBUG ' + @comment
		end
	else if( @cashcost < @NICKNAME_CHANGE_NEED_CASHCOST )
		begin
			set @nResult_ 	= @RESULT_ERROR_CASHCOST_LACK
			set @comment 	= 'ĳ�����(���̾�)�� �����մϴ�.'
			--select 'DEBUG ' + @comment
		end
	else if( @nickname_ = @oldnickname )
		begin
			set @nResult_ = @RESULT_SUCCESS
			set @comment = '�г����� �����Ͽ����ϴ�.(�̹̺���)'
			--select 'DEBUG 4', @comment
		end
	else
		begin
			set @nResult_ = @RESULT_SUCCESS
			set @comment = '�г����� �����Ͽ����ϴ�.'
			--select 'DEBUG 4', @comment

			---------------------------------------------------
			-- ��������
			---------------------------------------------------
			set @cashcost = @cashcost - @NICKNAME_CHANGE_NEED_CASHCOST

			---------------------------------------------------
			-- ���� ���� ����
			---------------------------------------------------
			update dbo.tUserMaster
				set
					cashcost		= @cashcost,
					nickname 		= @nickname_,
					nicknamechange	= nicknamechange + 1
			where gameid = @gameid_

			---------------------------------------------------
			-- ������ ���.
			---------------------------------------------------
			if(@oldnickname != '')
				begin
					--select 'DEBUG �ΰ� ���', @gameid_ gameid_, @oldnickname oldnickname, @nickname_ nickname_
					insert into dbo.tUserNickNameChange(gameid,   oldnickname,   newnickname)
					values(                            @gameid_, @oldnickname,  @nickname_)
				end
		end

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost

	--���� ����� �����Ѵ�.
	set nocount off
End



