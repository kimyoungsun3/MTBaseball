/*
-- ���忡 ��ġ�� �����鸸 �������� �Ѵ�.
exec spu_FVAniSet 'xxxx', '049000s1i0n7t8445289', '', -1											-- �ʵ����.
exec spu_FVAniSet 'xxxx', '049000s1i0n7t8445289', '3:4', -1										-- �ʵ�1����.
exec spu_FVAniSet 'xxxx', '049000s1i0n7t8445289', '0:1;1:3', -1
exec spu_FVAniSet 'xxxx', '049000s1i0n7t8445289', '0:1;2:3;3:17', -1
exec spu_FVAniSet 'xxxx', '049000s1i0n7t8445289', '0:1;1:3;2:17;3:16;4:8', -1
exec spu_FVAniSet 'xxxx', '049000s1i0n7t8445289', '0:1;1:2;2:3;3:4;4:5;5:6;6:12;7:13;8:14', -1	-- �ʵ�9����.
*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVAniSet', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVAniSet;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_FVAniSet
	@gameid_								varchar(60),
	@password_								varchar(20),
	@listset_								varchar(256),
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
	declare @comment			varchar(80)
	declare @gameid 			varchar(60)
	declare @fieldidx			int,
			@fieldidxold		int
	declare @listidx			int

	-- �ʵ����.
	declare @field0				int			set @field0			= -1
	declare @field1				int			set @field1			= -1
	declare @field2				int			set @field2			= -1
	declare @field3				int			set @field3			= -1
	declare @field4				int			set @field4			= -1
	declare @field5				int			set @field5			= -1
	declare @field6				int			set @field6			= -1
	declare @field7				int			set @field7			= -1
	declare @field8				int			set @field8			= -1
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG �Է°�', @gameid_ gameid_, @password_ password_, @listset_ listset_

	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	select
		@gameid 		= gameid,

		@field0			= field0,			@field1			= field1,			@field2			= field2,
		@field3			= field3,			@field4			= field4,			@field5			= field5,
		@field6			= field6,			@field7			= field7,			@field8			= field8
	from dbo.tFVUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG ��������', @gameid gameid


	if(isnull(@gameid, '') = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '���̵� �������� �ʴ´�.'
		END
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '������ ���ġ�߽��ϴ�.'

			----------------------------------------------
			-- ������ �ʵ��ȣ ���� �ʱ�ȭ (-1)
			----------------------------------------------
			update dbo.tFVUserItem
				set
					fieldidx = @USERITEM_FIELDIDX_INVEN
			from dbo.tFVUserItem
			where gameid = @gameid_ and (fieldidx >= 0 and fieldidx < 9)

			-- �ּ� �ѽ��̻��� ��츸 �۵��ǵ��� �Ѵ�.[1:2]
			if(LEN(@listset_) >= 3)
				begin
				----------------------------------------------
				-- ���ι�ȣ�� ���� �ʵ��ȣ����
				----------------------------------------------
				-- 1. Ŀ�� ����
				declare curTemp Cursor for
				select fieldidx, listidx FROM dbo.fnu_SplitTwo(';', ':', @listset_)

				-- 2. Ŀ������
				open curTemp

				-- 3. Ŀ�� ���
				Fetch next from curTemp into @fieldidx, @listidx
				while @@Fetch_status = 0
					Begin
						--select 'DEBUG ', @fieldidx fieldidx, @listidx listidx

						-- ������	 	> ...
						-- ��ǥ���� 	> �н�
						-- �׾���		> �н�
						set @fieldidxold = -444
						select
							@fieldidxold = fieldidx
						from dbo.tFVUserItem
						where gameid = @gameid_ and listidx = @listidx and invenkind = @USERITEM_INVENKIND_ANI
						if(@fieldidxold = -1)
							begin
								-- �ʵ尡 ����ϴ� �����ΰ�?
								set @fieldidx = dbo.fun_getFVUserItemFieldCheck(@fieldidx,
																			  @field0, @field1, @field2,
																			  @field3, @field4, @field5,
																			  @field6, @field7, @field8)

								--select 'DEBUG ���� ��ġ����'
								update dbo.tFVUserItem
									set
										fieldidx = @fieldidx
								from dbo.tFVUserItem
								where gameid = @gameid_ and listidx = @listidx
							end

						Fetch next from curTemp into @fieldidx, @listidx
					end

				-- 4. Ŀ���ݱ�
				close curTemp
				Deallocate curTemp
			end
		END


	select @nResult_ rtn, @comment comment
	if(@nResult_ = @RESULT_SUCCESS)
		BEGIN
			--------------------------------------------------------------
			-- ���� ����Ʈ�� ������.
			--------------------------------------------------------------
			select fieldidx, listidx from dbo.tFVUserItem
			where gameid = @gameid_ and invenkind in (@USERITEM_INVENKIND_ANI) and fieldidx >= 0 and fieldidx <= 9
			order by fieldidx asc
		END


	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off
End



