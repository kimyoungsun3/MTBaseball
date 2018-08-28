/*
exec spu_UserParam 'xxxx2', '049000s1i0n7t8445289', 1, '0:0;1:1;2:2;3:3;4:4;5:5;6:6;7:7;8:8;9:9;', -1	-- ����.
exec spu_UserParam 'xxxx2', '049000s1i0n7t8445289', 1, '0:9;1:8;2:7;3:6;4:5;5:4;6:3;7:2;8:1;9:0;', -1	--
exec spu_UserParam 'xxxx2', '049000s1i0n7t8445289', 2, '', -1											-- �б�.
*/
use Game4Farmvill5
GO

IF OBJECT_ID ( 'dbo.spu_UserParam', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_UserParam;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_UserParam
	@gameid_								varchar(20),
	@password_								varchar(20),
	@mode_									int,
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
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--�ش������� ã�� ����
	declare @RESULT_ERROR_NOT_FOUND_PASSWORD	int				set @RESULT_ERROR_NOT_FOUND_PASSWORD	= -17
	declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--������ �����ϰ� �ִ�.
	declare @RESULT_NEWVERION_CLIENT_DOWNLOAD 	int				set @RESULT_NEWVERION_CLIENT_DOWNLOAD	= -15			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ��ũó��.
	declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ����.

	-- ��Ÿ����
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- ���������ʴ¸��
	declare @RESULT_ERROR_NOT_ENOUGH			int				set @RESULT_ERROR_NOT_ENOUGH			= -115			-- �����ΰ� ������� ����.

	------------------------------------------------
	--	2-2. ���°�
	------------------------------------------------
	declare @MODE_SAVE							int				set @MODE_SAVE							= 1			-- ����, �б���.
	declare @MODE_READ							int				set @MODE_READ							= 2			--

	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @gameid 				varchar(20)		set @gameid				= ''
	declare @comment				varchar(512)
	declare @kind				int,
			@info				int,
			@listidx			int,
			@strdata			varchar(40)

	declare @param0					int				set @param0				= 0
	declare @param1					int				set @param1				= 0
	declare @param2					int				set @param2				= 0
	declare @param3					int				set @param3				= 0
	declare @param4					int				set @param4				= 0
	declare @param5					int				set @param5				= 0
	declare @param6					int				set @param6				= 0
	declare @param7					int				set @param7				= 0
	declare @param8					int				set @param8				= 0
	declare @param9					int				set @param9				= 0

Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG �Է�����', @gameid_ gameid_, @password_ password_, @listset_ listset_

	------------------------------------------------
	--	3-2. �������(��������)
	------------------------------------------------
	select
		@gameid 		= gameid,
		@param0			= param0,
		@param1			= param1,
		@param2			= param2,
		@param3			= param3,
		@param4			= param4,
		@param5			= param5,
		@param6			= param6,
		@param7			= param7,
		@param8			= param8,
		@param9			= param9
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG ��������', @gameid gameid, @param0 param0, @param1 param1, @param2 param2, @param3 param3, @param4 param4, @param5 param5, @param6 param6, @param7 param7, @param8 param8, @param9 param9

	if(isnull(@gameid, '') = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '���̵� �������� �ʴ´�.'
			--select 'DEBUG ', @comment
		END
	else if(@mode_ not in (@MODE_SAVE, @MODE_READ))
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment 	= '�������� �ʴ� ����Դϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if(@mode_ = @MODE_SAVE and (@listset_ = '' or LEN(@listset_) < 3 or CHARINDEX(':', @listset_) < 2))
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_ENOUGH
			set @comment 	= '������ ������մϴ�.'
		END
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'DEBUG ����ó���߽��ϴ�.'
			--select 'DEBUG ', @comment

			if(@mode_ = @MODE_SAVE)
				begin
					-- 1. Ŀ�� ����
					declare curUserInfo Cursor for
					select * FROM dbo.fnu_SplitTwo(';', ':', @listset_)

					-- 2. Ŀ������
					open curUserInfo

					-- 3. Ŀ�� ���
					Fetch next from curUserInfo into @kind, @info
					while @@Fetch_status = 0
						Begin
							if(@kind = 0)
								begin
									set @param0 		= @info
								end
							else if(@kind = 1)
								begin
									set @param1 		= @info
								end
							else if(@kind = 2)
								begin
									set @param2 		= @info
								end
							else if(@kind = 3)
								begin
									set @param3		 	= @info
								end
							else if(@kind = 4)
								begin
									set @param4 		= @info
								end
							else if(@kind = 5)
								begin
									set @param5 		= @info
								end
							else if(@kind = 6)
								begin
									set @param6 		= @info
								end
							else if(@kind = 7)
								begin
									set @param7 		= @info
								end
							else if(@kind = 8)
								begin
									set @param8 		= @info
								end
							else if(@kind = 9)
								begin
									set @param9	= @info
								end
							Fetch next from curUserInfo into @kind, @info
						end
					-- 4. Ŀ���ݱ�
					close curUserInfo
					Deallocate curUserInfo


					update dbo.tUserMaster
						set
							param0	= @param0,
							param1	= @param1,
							param2	= @param2,
							param3	= @param3,
							param4	= @param4,
							param5	= @param5,
							param6	= @param6,
							param7	= @param7,
							param8	= @param8,
							param9	= @param9
					where gameid = @gameid_
				end

		END

	select @nResult_ rtn, @comment comment, @param0 param0, @param1 param1, @param2 param2, @param3 param3, @param4 param4, @param5 param5, @param6 param6, @param7 param7, @param8 param8, @param9 param9


	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off
End



