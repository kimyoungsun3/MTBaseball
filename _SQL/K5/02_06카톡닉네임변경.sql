/*
select cashcost from dbo.tUserMaster where gameid = 'xxxx2'
exec spu_CheckKakaoNickName 'xxxx2', '049000s1i0n7t8445289', 1, '�г���12', -1		-- ���ắ��
select cashcost from dbo.tUserMaster where gameid = 'xxxx2'

exec spu_CheckKakaoNickName 'xxxx2', '049000s1i0n7t8445289', 2, '�г���12', -1		-- ���ắ��
select cashcost from dbo.tUserMaster where gameid = 'xxxx2'

exec spu_CheckKakaoNickName 'farm200484', '0058948l6z4g6e529442', 1, 'ffff8', -1		-- ���ắ��
*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_CheckKakaoNickName', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_CheckKakaoNickName;
GO

create procedure dbo.spu_CheckKakaoNickName
	@gameid_				varchar(20),
	@password_				varchar(20),
	@mode_					int,
	@kakaonickname_			varchar(40),
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

	-- ������ �� ���.
	declare @NICKNAME_CHANGE_MODE_FREE			int				set @NICKNAME_CHANGE_MODE_FREE			= 1		-- ���ắ��.
	declare @NICKNAME_CHANGE_MODE_CASHCOST		int				set @NICKNAME_CHANGE_MODE_CASHCOST		= 2		-- ���ắ��.

	-- �䱸ĳ��.
	declare @NICKNAME_CHANGE_NEED_CASHCOST		int				set @NICKNAME_CHANGE_NEED_CASHCOST		= 1000

	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @comment		varchar(128)
	declare @gameid			varchar(20)		set @gameid			= ''
	declare @oldnickname	varchar(20)		set @oldnickname	= ''
	declare @cashcost 		int				set @cashcost		= 0
	declare @gamecost 		int				set @gamecost		= 0
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	set @comment = '�˼� ���� ������ �߻��߽��ϴ�.'
	--select 'DEBUG 1', @kakaonickname_ kakaonickname_

	------------------------------------------------
	--	3-2. ����ȹ��
	------------------------------------------------
	select
		@gameid 		= gameid,		@cashcost		= cashcost,	@gamecost 		= gamecost,
		@oldnickname	= kakaonickname
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG ', @gameid gameid, @oldnickname oldnickname

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
	else if( exists( select top 1 * from dbo.tUserMaster where kakaonickname = @kakaonickname_ and gameid != @gameid_ and deletestate = 0) )
		begin
			set @nResult_ 	= @RESULT_ERROR_CANNOT_USED_NICKNAME
			set @comment 	= 'ERROR �г����� ���� ����ϰ� �ֽ��ϴ�.'
			--select 'DEBUG 3' + @comment
		end
	else if( @mode_ = @NICKNAME_CHANGE_MODE_CASHCOST and @cashcost < @NICKNAME_CHANGE_NEED_CASHCOST )
		begin
			set @nResult_ 	= @RESULT_ERROR_CASHCOST_LACK
			set @comment 	= 'ĳ������� �����մϴ�.'
			--select 'DEBUG ' + @comment
		end
	else
		begin
			set @nResult_ = @RESULT_SUCCESS
			set @comment = '�г����� �����Ͽ����ϴ�.'
			--select 'DEBUG 4', @comment

			---------------------------------------------------
			-- ��������
			---------------------------------------------------
			if(@kakaonickname_ = '')
				begin
					--select 'DEBUG �Է¾��ؼ� ���̵�δ�ó', @gameid_ gameid_
					set @kakaonickname_ = @gameid_
				end
			if( @mode_ = @NICKNAME_CHANGE_MODE_CASHCOST )
				begin
					set @cashcost = @cashcost - @NICKNAME_CHANGE_NEED_CASHCOST
				end

			---------------------------------------------------
			-- ���� ���� ����
			---------------------------------------------------
			update dbo.tUserMaster
				set
					cashcost		= @cashcost,
					kakaonickname 	= @kakaonickname_,
					nicknamechange	= nicknamechange + 1
			where gameid = @gameid_

			---------------------------------------------------
			-- ������ ���.
			---------------------------------------------------
			if(@oldnickname != '')
				begin
					--select 'DEBUG �ΰ� ���', @gameid_ gameid_, @oldnickname oldnickname, @kakaonickname_ kakaonickname_
					insert into dbo.tUserNickNameChange(gameid,   oldnickname,   newnickname)
					values(                            @gameid_, @oldnickname,  @kakaonickname_)
				end
		end

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost

	--���� ����� �����Ѵ�.
	set nocount off
End



