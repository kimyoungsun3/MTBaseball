/*
-- select * from dbo.tFVUserFriend where gameid = 'xxxx2'
-- select * from dbo.tFVKakaoHelpWait where gameid = 'xxxx2'
-- xxxx2 -> xxxx3, xxxx4 ��û
-- exec spu_FVGiftGain 'xxxx2', '049000s1i0n7t8445289', -3, 3429809, -1, -1, -1, -1	-- �Ҽ����ޱ�.
-- exec spu_FVAniDie 'xxxx2', '049000s1i0n7t8445289', 1, 1, -1						-- ��������.
-- update dbo.tFVUserFriend set helpdate = getdate() - 10 where gameid in ('xxxx2', 'xxxx', 'xxxx3')
exec spu_FVKakaoFriendHelp 'xxxx2', '049000s1i0n7t8445289', 'xxxx',  0, -1
exec spu_FVKakaoFriendHelp 'xxxx2', '049000s1i0n7t8445289', 'xxxx3', 1, -1

exec spu_FVKakaoFriendHelpList 'xxxx', '049000s1i0n7t8445289', -1
*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVKakaoFriendHelpList', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVKakaoFriendHelpList;
GO

create procedure dbo.spu_FVKakaoFriendHelpList
	@gameid_				varchar(60),
	@password_				varchar(20),
	@nResult_				int				OUTPUT
	--WITH ENCRYPTION -- ���ν����� ��ȣȭ��.
as
	------------------------------------------------
	--	2-1. �����ڵ尪
	------------------------------------------------
	-- �Ϲݰ�
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	-- �α��� ����.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--�ش������� ã�� ����
	declare @RESULT_ERROR_TIME_REMAIN			int				set @RESULT_ERROR_TIME_REMAIN			= -123			-- ���� �ð��� ����.

	------------------------------------------------
	--	2-2. ���°�
	------------------------------------------------


	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @comment			varchar(128)
	declare @gameid				varchar(60)		set @gameid				= ''
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	set @comment = '�˼� ���� ������ �߻��߽��ϴ�.'
	--select 'DEBUG 1', @gameid_ gameid_, @password_ password_

	------------------------------------------------
	--	3-2. ����ȹ��
	------------------------------------------------
	select
		@gameid 			= gameid
	from dbo.tFVUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 1-1 ������', @gameid gameid

	------------------------------------------------
	--	3-3. ��������.
	------------------------------------------------
	if (@gameid = '')
		begin
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR ���̵� �������� �ʴ´�.'
			--select 'DEBUG 2' + @comment
		end
	else
		begin
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'ģ������ �����ฦ ��û����Ʈ.'
			--select 'DEBUG 3-1', @comment

			delete from dbo.tFVKakaoHelpWait
			where gameid = @gameid_ and helpdate < getdate() - 1
		end

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	select @nResult_ rtn, @comment comment

	if(@nResult_ = @RESULT_SUCCESS)
		begin
			--------------------------------------------------------------
			-- ���� ģ������
			--------------------------------------------------------------
			select * from dbo.tFVUserMaster
			where gameid in (select top 100 friendid FROM dbo.tFVKakaoHelpWait where gameid = @gameid_)
		end


	--���� ����� �����Ѵ�.
	set nocount off
End



