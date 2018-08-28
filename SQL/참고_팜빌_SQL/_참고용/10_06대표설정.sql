/*
exec spu_FVAniRepReg 'xxxx0', '049000s1i0n7t8445289', 0, -1	-- ����.
exec spu_FVAniRepReg 'xxxx', '049000s1i0n7t8445289', 8, -1	-- �Ҹ���.
exec spu_FVAniRepReg 'xxxx', '049000s1i0n7t8445289', 1, -1	-- �ʵ嵿��.
exec spu_FVAniRepReg 'xxxx', '049000s1i0n7t8445289', 18, -1	 --���� ��ȣ
exec spu_FVAniRepReg 'xxxx', '049000s1i0n7t8445289', 17, -1	-- ����(����).
exec spu_FVAniRepReg 'xxxx', '049000s1i0n7t8445289', 0, -1	-- ����(â��).
exec spu_FVAniRepReg 'xxxx2', '049000s1i0n7t8445289', 3, -1	-- ����(�ʵ�).
select * from dbo.tFVSchoolUser where gameid = 'xxxx2'
*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVAniRepReg', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVAniRepReg;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_FVAniRepReg
	@gameid_								varchar(60),
	@password_								varchar(20),
	@listidx_								int,
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
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--�ش������� ã�� ����.
	declare @RESULT_ERROR_NOT_FOUND_PASSWORD	int				set @RESULT_ERROR_NOT_FOUND_PASSWORD	= -17
	declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--������ �����ϰ� �ִ�.
	declare @RESULT_NEWVERION_CLIENT_DOWNLOAD 	int				set @RESULT_NEWVERION_CLIENT_DOWNLOAD	= -15			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ��ũó��.
	declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ����.

	-- ��Ÿ����
	declare @RESULT_ERROR_RESULT_COPY			int				set @RESULT_ERROR_RESULT_COPY			= -53			-- ���ī�ǽõ�.
	declare @RESULT_ERROR_GAMECOST_COPY			int				set @RESULT_ERROR_GAMECOST_COPY			= -54			-- �ǹ�ī�ǽõ�.
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- ���������ʴ¸��.
	declare @RESULT_ERROR_HEART_FULL			int				set @RESULT_ERROR_HEART_FULL			= -71			-- ���������ʴ¸��.
	declare @RESULT_ERROR_TUTORIAL_ALREADY		int				set @RESULT_ERROR_TUTORIAL_ALREADY		= -73			-- ���丮�� �̹� ����.
	declare @RESULT_ERROR_NOT_FOUND_OTHERID		int				set @RESULT_ERROR_NOT_FOUND_OTHERID		= -83
	declare @RESULT_ERROR_INVEN_FULL			int				set @RESULT_ERROR_INVEN_FULL			= -101			-- �κ�����.
	declare @RESULT_ERROR_DAILY_REWARD_ALREADY	int				set @RESULT_ERROR_DAILY_REWARD_ALREADY	= -102			-- ���Ϻ��� �̹� ����.
	declare @RESULT_ERROR_NOT_FOUND_DOGAMIDX	int				set @RESULT_ERROR_NOT_FOUND_DOGAMIDX	= -103			-- ������ȣ�� ã���� ����.
	declare @RESULT_ERROR_DOGAM_ALREADY_REWARD	int				set @RESULT_ERROR_DOGAM_ALREADY_REWARD	= -104			-- ������ �̹� ��������.
	declare @RESULT_ERROR_DOGAM_LACK			int				set @RESULT_ERROR_DOGAM_LACK			= -105			-- �����߿� ������ȣ�� ������.
	declare @RESULT_ERROR_ANIMAL_NOT_FOUND		int				set @RESULT_ERROR_ANIMAL_NOT_FOUND		= -106			-- ��ǥ���� ��ã��.
	declare @RESULT_ERROR_ANIMAL_NOT_INVEN		int				set @RESULT_ERROR_ANIMAL_NOT_INVEN		= -107			-- �κ��� ����(â��).
	declare @RESULT_ERROR_ANIMAL_NOT_ALIVE		int				set @RESULT_ERROR_ANIMAL_NOT_ALIVE		= -108			-- ��� ���� ����.
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

	-- ��������.
	-- �ʵ嵿�� 0 ~ 8.
	declare @USERITEM_FIELDIDX_INVEN			int					set @USERITEM_FIELDIDX_INVEN					= -1	-- â��.
	declare @USERITEM_FIELDIDX_HOSPITAL			int					set @USERITEM_FIELDIDX_HOSPITAL					= -2	-- ����.

	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @comment			varchar(80)
	declare @gameid 			varchar(60),
			@anireplistidx		int,
			@anirepitemcode		int,
			@anirepacc1			int,
			@anirepacc2			int

	declare @invenkind			int				set	@invenkind	= -444
	declare @fieldidx			int				set @fieldidx	= -444

	set @anirepitemcode			=  1
	set @anirepacc1				= -1
	set @anirepacc2				= -1


Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG �Է°�', @gameid_ gameid_, @password_ password_, @listidx_ listidx_

	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	select
		@gameid 		= gameid,
		@anireplistidx 	= anireplistidx
	from dbo.tFVUserMaster
	where gameid = @gameid_
	--select 'DEBUG ��������', @gameid gameid, @anireplistidx anireplistidx

	select
		@invenkind 		= invenkind,
		@fieldidx 		= fieldidx,
		@anirepitemcode	= itemcode,
		@anirepacc1		= acc1,
		@anirepacc2		= acc2
	from dbo.tFVUserItem
	where gameid = @gameid_ and listidx = @listidx_
	--select 'DEBUG ��ǥ��������', @gameid gameid, @invenkind invenkind, @fieldidx fieldidx

	if(isnull(@gameid, '') = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '���̵� �������� �ʴ´�.'
		END
	else if(@invenkind != @USERITEM_INVENKIND_ANI)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_ANIMAL_NOT_FOUND
			set @comment 	= '�ش� �����ƴϰų� ����.'
		END
	else if(@fieldidx = @USERITEM_FIELDIDX_HOSPITAL)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_ANIMAL_NOT_ALIVE
			set @comment 	= '�ش� ������ ������� �ʴ�.'
		END
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '����߽��ϴ�..'

			----------------------------
			-- ��ǥ���� ��ũ����.
			----------------------------
			update dbo.tFVUserMaster
				set
					anireplistidx 	= @listidx_,
					anirepitemcode 	= @anirepitemcode,
					anirepacc1	 	= @anirepacc1,
					anirepacc2 		= @anirepacc2
			where gameid = @gameid_

			----------------------------
			-- ��ǥ���� > �б����� �������õ� ����.
			----------------------------
			update dbo.tFVSchoolUser
				set
					itemcode= @anirepitemcode,
					acc1	= @anirepacc1,
					acc2	= @anirepacc2
			where gameid = @gameid_
		END

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off
	select @nResult_ rtn, @comment comment
End



