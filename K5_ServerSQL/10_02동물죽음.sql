/*
exec spu_AniDie 'xxxx2', '049000s1i0n7t8445289', 1, 18, -1		-- ��������.
exec spu_AniDie 'xxxx2', '049000s1i0n7t8445289', 2, 13, -1		-- ���뿡 ����.

exec spu_AniDie 'xxxx2', '049000s1i0n7t8445289', 1, 1, -1		-- ��������.
exec spu_AniDie 'xxxx2', '049000s1i0n7t8445289', 2, 2, -1		-- ���뿡 ����.

exec spu_AniDie 'xxxx2', '049000s1i0n7t8445289', 1, 18, -1		-- ��������.
exec spu_AniDie 'xxxx2', '049000s1i0n7t8445289', 1, 19, -1		-- ��������.
exec spu_AniDie 'xxxx2', '049000s1i0n7t8445289', 1, 20, -1		-- ��������.
exec spu_AniDie 'xxxx2', '049000s1i0n7t8445289', 1, 21, -1		-- ��������.
exec spu_AniDie 'xxxx2', '049000s1i0n7t8445289', 1, 22, -1		-- ��������.

*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_AniDie', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_AniDie;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_AniDie
	@gameid_								varchar(20),
	@password_								varchar(20),
	@mode_									int,
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
	declare @RESULT_ERROR_RESULT_COPY			int				set @RESULT_ERROR_RESULT_COPY			= -53			-- ���ī�ǽõ�
	declare @RESULT_ERROR_GAMECOST_COPY			int				set @RESULT_ERROR_GAMECOST_COPY			= -54			-- �ǹ�ī�ǽõ�
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- ���������ʴ¸��
	------------------------------------------------
	--	2-2. ���°�
	------------------------------------------------
	-- �����ۺ� �κ��з�
	declare @USERITEM_INVENKIND_ANI				int 				set @USERITEM_INVENKIND_ANI					= 1
	--declare @USERITEM_INVENKIND_CONSUME		int 				set @USERITEM_INVENKIND_CONSUME				= 3
	--declare @USERITEM_INVENKIND_ACC			int 				set @USERITEM_INVENKIND_ACC					= 4
	--declare @USERITEM_INVENKIND_DIRECT		int 				set @USERITEM_INVENKIND_DIRECT				= 40
	--declare @USERITEM_INVENKIND_INFO			int 				set @USERITEM_INVENKIND_INFO				= 60
	--declare @USERITEM_INVENKIND_PET			int 				set @USERITEM_INVENKIND_PET					= 1000

	-- ���� or ��Ȱ���.
	declare @USERITEM_MODE_DIE_INIT				int					set @USERITEM_MODE_DIE_INIT					= -1-- �ʱ����.
	declare @USERITEM_MODE_DIE_PRESS			int					set @USERITEM_MODE_DIE_PRESS				= 1	-- ���� ����.
	declare @USERITEM_MODE_DIE_EAT_WOLF			int					set @USERITEM_MODE_DIE_EAT_WOLF				= 2	-- ���� ����.
	declare @USERITEM_MODE_DIE_EXPLOSE			int					set @USERITEM_MODE_DIE_EXPLOSE				= 3	-- ���� ����.
	declare @USERITEM_MODE_DIE_DISEASE			int					set @USERITEM_MODE_DIE_DISEASE				= 4	-- ���� ����.
	declare @USERITEM_MODE_REVIVAL_FIELD		int					set @USERITEM_MODE_REVIVAL_FIELD			= 1	-- �ʵ��Ȱ.
	declare @USERITEM_MODE_REVIVAL_HOSPITAL		int					set @USERITEM_MODE_REVIVAL_HOSPITAL			= 2	-- ������Ȱ.

	-- ��Ÿ �����
	declare @ID_MAX								int					set	@ID_MAX									= 9999	-- ������ ������ �� �ִ� ���̵𰳼�.
	declare @USERMASTER_UPGRADE_STATE_NON		int					set @USERMASTER_UPGRADE_STATE_NON			= -1	--������, �Ϸ���.(����)
	declare @USERMASTER_UPGRADE_STATE_ING		int					set @USERMASTER_UPGRADE_STATE_ING			= 1		--�����ܰ�������.
	declare @USERSEED_NEED_EMPTY				int					set @USERSEED_NEED_EMPTY					= -1	-- (������)
	declare @USERSEED_NEED_BUY					int					set @USERSEED_NEED_BUY						= -2
	-- >= 0 �̻��̸� Ư�� �Ĺ��� �ɾ�������.
	declare @GAME_INVEN_HOSPITAL_BASE			int					set @GAME_INVEN_HOSPITAL_BASE				= 10+9 -- ��������(����10 + �ʵ�9).

	-- ��������.
	-- �ʵ嵿�� 0 ~ 8.
	declare @USERITEM_FIELDIDX_INVEN			int					set @USERITEM_FIELDIDX_INVEN					= -1	-- â��.
	declare @USERITEM_FIELDIDX_HOSPITAL			int					set @USERITEM_FIELDIDX_HOSPITAL					= -2	-- ����.
	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @comment			varchar(80)
	declare @gameid 			varchar(20)		set @gameid			= ''
	declare @anireplistidx		int				set @anireplistidx	= -1

	declare @loop				int
	declare @fieldidx			int				set @fieldidx		= -444
	declare @listidx			int				set @listidx		= -1
	declare @itemcode			int				set @itemcode		= -1
	declare @needhelpcnt		int				set @needhelpcnt	= 99999
	declare @gameyear			int				set @gameyear		= 2013
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	set @comment = '�𸣴� ����(-1).'
	--select 'DEBUG �Է°�', @gameid_ gameid_, @password_ password_, @mode_ mode_, @listidx_ listidx_

	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	select
		@gameid 		= gameid,
		@gameyear		= gameyear,
		@anireplistidx 	= anireplistidx
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG ��������', @gameid gameid

	select
		@fieldidx 	= fieldidx,
		@itemcode 	= itemcode
	from dbo.tUserItem
	where gameid = @gameid_ and listidx = @listidx_ and invenkind in (@USERITEM_INVENKIND_ANI)


	if( @gameid = '' )
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '���̵� �������� �ʴ´�.'
		END
	else if(@mode_ not in (@USERITEM_MODE_DIE_PRESS, @USERITEM_MODE_DIE_EAT_WOLF, @USERITEM_MODE_DIE_EXPLOSE, @USERITEM_MODE_DIE_DISEASE))
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment 	= '�������� �ʴ� ����Դϴ�.'
		END
	else if(@fieldidx < @USERITEM_FIELDIDX_INVEN or @fieldidx >= 9)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment 	= '�׾��ٰ� ǥ�����ش�.(���� or ���ų� or ��ǥ or �κ�)'
		END
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '�׾��ٰ� ǥ�����ش�.(�ű�)'

			-----------------------------------------
			-- ��ǥ���� ������ �⺻������ ����
			-----------------------------------------
			if(@anireplistidx = @listidx_)
				begin
					update dbo.tUserMaster
						set
							anirepitemcode 	=  1,
							anirepacc1	 	= -1,
							anirepacc2 		= -1
					where gameid = @gameid_
				end

			-----------------------------------------
			-- �ʿ��Ȱ��.
			-----------------------------------------
			select
				@needhelpcnt = param13
			from dbo.tItemInfo
			where itemcode = @itemcode

			-----------------------------------------
			-- �ױ����� �������
			-----------------------------------------
			if(@gameyear >= 2014)
				begin
					-- ����� �ΰ� ����Ѵ�. (�̰� ������ ���������� �ʴ´�.)
					exec spu_AnimalLogBackup @gameid_, 1, @listidx_, @mode_, @needhelpcnt	-- �����ΰ�.
				end

			-----------------------------------------
			-- ����ǥ��.
			-----------------------------------------
			--select 'DEBUG ����, ���� ���� > �ʵ�(����:-2), ���, �ð�'
			update dbo.tUserItem
				set
					fieldidx 	= @USERITEM_FIELDIDX_HOSPITAL,
					diemode		= @mode_,
					diedate		= getdate(),
					needhelpcnt	= @needhelpcnt
			where gameid = @gameid_ and listidx = @listidx_ and invenkind in (@USERITEM_INVENKIND_ANI)

			-----------------------------------------
			-- (���� ���� > 10�� > ���߰� ���ͻ���)
			-----------------------------------------
			-- 1. Ŀ���� ��� ����.
			set @loop = 0

			declare curTemp Cursor for
			select listidx from dbo.tUserItem
			where gameid = @gameid_ and invenkind in (@USERITEM_INVENKIND_ANI) and fieldidx = @USERITEM_FIELDIDX_HOSPITAL
			order by diedate desc

			-- 2. Ŀ������
			open curTemp

			-- 3. Ŀ�� ���
			Fetch next from curTemp into @listidx
			while @@Fetch_status = 0
				Begin
					--select 'DEBUG �������� Ȯ��', @loop loop
					if(@loop >= @GAME_INVEN_HOSPITAL_BASE)
						begin
							--select 'DEBUG > ����', @loop loop, @listidx listidx
							exec spu_DeleteUserItemBackup 0, @gameid_, @listidx
						end

					set @loop = @loop + 1
					Fetch next from curTemp into @listidx
				end

			-- 4. Ŀ���ݱ�
			close curTemp
			Deallocate curTemp
		END

	select @nResult_ rtn, @comment comment

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off
End



