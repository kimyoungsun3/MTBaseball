/*
-- ��������
exec spu_FVAniDie 'xxxx2', '049000s1i0n7t8445289', 1, 0, -1
exec spu_FVAniDie 'xxxx2', '049000s1i0n7t8445289', 1, 1, -1
exec spu_FVAniDie 'xxxx2', '049000s1i0n7t8445289', 1, 2, -1
exec spu_FVAniDie 'xxxx2', '049000s1i0n7t8445289', 1, 3, -1
exec spu_FVAniDie 'xxxx2', '049000s1i0n7t8445289', 1,14, -1

-- �����Ȱ(2013).
exec spu_FVAniRevival 'xxxx2', '049000s1i0n7t8445289', 2, 0, -1, -1
exec spu_FVAniRevival 'xxxx2', '049000s1i0n7t8445289', 2, 1, -1, -1
exec spu_FVAniRevival 'xxxx2', '049000s1i0n7t8445289', 2, 2, -1, -1
exec spu_FVAniRevival 'xxxx2', '049000s1i0n7t8445289', 2, 3, -1, -1
exec spu_FVAniRevival 'xxxx2', '049000s1i0n7t8445289', 2,14, -1, -1

-- �����û
-- select * from dbo.tFVUserFriend where gameid = 'xxxx2'
-- select * from dbo.tFVKakaoHelpWait where gameid = 'xxxx2'
-- xxxx2 -> xxxx3, xxxx4 ��û
-- exec spu_FVGiftGain 'xxxx2', '049000s1i0n7t8445289', -3, 3429809, -1, -1, -1, -1	-- �Ҽ����ޱ�.
-- exec spu_FVAniDie 'xxxx2', '049000s1i0n7t8445289', 1, 25, -1						-- ��������.
-- update dbo.tFVUserFriend set helpdate = getdate() - 10 where gameid in ('xxxx2', 'xxxx', 'xxxx3')
exec spu_FVKakaoFriendHelp 'xxxx2', '049000s1i0n7t8445289', 'xxxx',  0, -1
exec spu_FVKakaoFriendHelp 'xxxx2', '049000s1i0n7t8445289', 'xxxx3', 1, -1

-- ��Ȱ��ûó��, �ڽ��� ��������, ������ ����Ʈ(���ο�͸� �߰����ֻ�)
exec spu_FVAniHosList 'xxxx2', '049000s1i0n7t8445289', -1
exec spu_FVAniHosList 'xxxx', '049000s1i0n7t8445289', -1
exec spu_FVAniHosList 'xxxx3', '049000s1i0n7t8445289', -1

*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVAniHosList', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVAniHosList;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_FVAniHosList
	@gameid_								varchar(60),
	@password_								varchar(20),
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
	-- �����ۺ� �κ��з�
	declare @USERITEM_INVENKIND_ANI				int 				set @USERITEM_INVENKIND_ANI					= 1
	declare @USERITEM_INVENKIND_CONSUME			int 				set @USERITEM_INVENKIND_CONSUME				= 3
	declare @USERITEM_INVENKIND_ACC				int 				set @USERITEM_INVENKIND_ACC					= 4
	declare @USERITEM_INVENKIND_DIRECT			int 				set @USERITEM_INVENKIND_DIRECT				= 40
	declare @USERITEM_INVENKIND_INFO			int 				set @USERITEM_INVENKIND_INFO				= 60
	declare @USERITEM_INVENKIND_PET				int 				set @USERITEM_INVENKIND_PET					= 1000

	-- ��Ÿ �����
	declare @ID_MAX								int					set	@ID_MAX									= 9999	-- ������ ������ �� �ִ� ���̵𰳼�.
	declare @USERMASTER_UPGRADE_STATE_NON		int					set @USERMASTER_UPGRADE_STATE_NON			= -1	--������, �Ϸ���.(����)
	declare @USERMASTER_UPGRADE_STATE_ING		int					set @USERMASTER_UPGRADE_STATE_ING			= 1		--�����ܰ�������.
	declare @USERSEED_NEED_EMPTY				int					set @USERSEED_NEED_EMPTY					= -1	-- (������)
	declare @USERSEED_NEED_BUY					int					set @USERSEED_NEED_BUY						= -2
	-- >= 0 �̻��̸� Ư�� �Ĺ��� �ɾ�������.

	-- ��������.
	-- �ʵ嵿�� 0 ~ 8.
	declare @USERITEM_FIELDIDX_INVEN			int					set @USERITEM_FIELDIDX_INVEN					= -1	-- â��.
	declare @USERITEM_FIELDIDX_HOSPITAL			int					set @USERITEM_FIELDIDX_HOSPITAL					= -2	-- ����.
	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @comment				varchar(512)
	declare @gameid 				varchar(60)
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG �Է�����', @gameid_ gameid_, @password_ password_

	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	select
		@gameid 		= gameid
	from dbo.tFVUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG ��������', @gameid gameid

	if(isnull(@gameid, '') = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '���̵� �������� �ʴ´�. > ���̵� Ȯ���ض�.'
			--select 'DEBUG ', @comment
		END
	else if(not exists(select top 1 * from dbo.tFVKakaoHelpWait where gameid = @gameid_))
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '����ó��(ó���Ұ��� ����)'
		END
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '����ó��(ó���ؼ� ����)'
			--select 'DEBUG ', @comment

			------------------------------------------------------------------------
			-- ģ�� ���� ��û ó���ϱ�(��������). > ����Ʈ ��¶�����
			-----------------------------------------------------------------------
			exec spu_FVsubKakaoHelpWait @gameid_
		END

	select @nResult_ rtn, @comment comment
	if(@nResult_ = @RESULT_SUCCESS)
		BEGIN
			--------------------------------------------------------------
			-- ���� ������ ��ü ����Ʈ
			-- ����(����ִ°�, ��������)
			--------------------------------------------------------------
			select top 10 * from dbo.tFVUserItem
			where gameid = @gameid_ and invenkind = @USERITEM_INVENKIND_ANI and fieldidx = @USERITEM_FIELDIDX_HOSPITAL
			order by diedate asc

			--------------------------------------------------------------
			-- ������ ��� �ִ� ������.
			--------------------------------------------------------------
			select * from dbo.tFVUserItem
			where gameid = @gameid_ and invenkind = @USERITEM_INVENKIND_ANI and fieldidx = @USERITEM_FIELDIDX_INVEN
		END

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off
End



