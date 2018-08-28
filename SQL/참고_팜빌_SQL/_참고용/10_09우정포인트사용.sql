/*
update dbo.tFVUserMaster set fpoint = 1000, fmonth = 0 where gameid = 'xxxx2'
exec spu_FVCallFriendPoint 'xxxx2', '049000s1i0n7t8445289', -1


update dbo.tFVUserMaster set fpoint = 0 where gameid = 'xxxx2'
exec spu_FVCallFriendPoint 'xxxx2', '049000s1i0n7t8445289', -1
*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVCallFriendPoint', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVCallFriendPoint;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_FVCallFriendPoint
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
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--�ش������� ã�� ����.
	declare @RESULT_ERROR_NOT_FOUND_PASSWORD	int				set @RESULT_ERROR_NOT_FOUND_PASSWORD	= -17
	declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--������ �����ϰ� �ִ�.
	declare @RESULT_NEWVERION_CLIENT_DOWNLOAD 	int				set @RESULT_NEWVERION_CLIENT_DOWNLOAD	= -15			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ��ũó��.
	declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ����.

	-- �����߿� ����.
	declare @RESULT_ERROR_FPOINT_LACK			int				set @RESULT_ERROR_FPOINT_LACK			= -124			--

	-- ģ������Ʈ ����.
	declare @USED_FRIEND_POINT					int				set @USED_FRIEND_POINT					= 50

	------------------------------------------------
	--	2-2. ���°�
	------------------------------------------------

	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @comment			varchar(80)

	declare @gameid 			varchar(60)		set @gameid 		= ''
	declare @market				int
	declare @cashcost			int				set @cashcost		= 0
	declare @gamecost			int				set @gamecost		= 0
	declare @heart				int				set @heart			= 0
	declare @feed				int				set @feed			= 0
	declare @fpoint				int				set @fpoint			= 0
	declare @gamemonth			int				set @gamemonth		= 1
	declare @fmonth				int				set @fmonth			= 2

Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG �Է°�', @gameid_ gameid_, @password_ password_

	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	-- ���� ����ĳ��
	select
		@gameid 		= gameid,
		@market			= market,
		@cashcost		= cashcost,
		@gamecost		= gamecost,
		@heart			= heart,
		@feed			= feed,
		@fpoint 		= fpoint,
		@gamemonth		= gamemonth,
		@fmonth			= fmonth
	from dbo.tFVUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG ��������', @gameid gameid, @fpoint fpoint

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '���̵� �������� �ʴ´�.'
			--select 'DEBUG ' + @comment
		END
	else if(@fpoint < @USED_FRIEND_POINT)
		BEGIN
			set @nResult_ = @RESULT_ERROR_FPOINT_LACK
			set @comment = 'ERROR ģ������Ʈ�� �����մϴ�.'
			--select 'DEBUG ' + @comment
		END
	--else if(@fmonth = @gamemonth)
	--	BEGIN
	--		set @nResult_ = @RESULT_SUCCESS
	--		set @comment = 'SUCCESS ģ���ϲ��� ȣ���Ͽ����ϴ�.(�ߺ�ȣ��)'
	--	END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS ģ���ϲ��� ȣ���Ͽ����ϴ�.'

			-- ����Ʈ����.
			set @fpoint = @fpoint - @USED_FRIEND_POINT
			set @fmonth = @gamemonth

			-- ���α� ���.
			exec spu_FVDayLogInfoStatic @market, 26, 1				-- �� fpoint(����)
		END


	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost, @heart heart, @feed feed, @fpoint fpoint
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			-----------------------------------
			-- ���� ���� �ݿ�.
			-----------------------------------
			update dbo.tFVUserMaster
				set
					fpoint	= @fpoint,
					fmonth	= @fmonth
			where gameid = @gameid_
		end

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off
End



