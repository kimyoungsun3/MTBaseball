/*
exec spu_GameRecord 'mtxxxx3', '049000s1i0n7t8445289', 333, -1
*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_GameRecord', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_GameRecord;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_GameRecord
	@gameid_								varchar(20),					-- ���Ӿ��̵�
	@password_								varchar(20),
	@sid_									int,
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
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--�ش������� ã�� ����
	declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--������ �����ϰ� �ִ�.

	-- ��Ÿ����
	declare @RESULT_ERROR_SESSION_ID_EXPIRE_LOGOUT	int			set @RESULT_ERROR_SESSION_ID_EXPIRE_LOGOUT	= -151		-- ������ ����Ǿ����ϴ�.

	------------------------------------------------
	--	2-2. ���°�
	------------------------------------------------
	-- MT �����°�.
	declare @BLOCK_STATE_NO						int					set	@BLOCK_STATE_NO							= 0	-- �����¾ƴ�
	declare @BLOCK_STATE_YES					int					set	@BLOCK_STATE_YES						= 1	-- ������

	-- MT ���Ӹ��.
	declare @GAME_MODE_PRACTICE					int					set @GAME_MODE_PRACTICE						= 0
	declare @GAME_MODE_SINGLE					int					set @GAME_MODE_SINGLE						= 1
	declare @GAME_MODE_MULTI					int					set @GAME_MODE_MULTI						= 2

	-- ���û���.
	declare @GAME_STATE_ING						int					set @GAME_STATE_ING					= -1	-- ����������.
	declare @GAME_STATE_ROLLBACK				int					set @GAME_STATE_ROLLBACK			= -2	-- �ѹ鿹����.
	declare @GAME_STATE_SUCCESS					int					set @GAME_STATE_SUCCESS				= 0		-- ����ó��.
	--declare @GAME_STATE_FAIL_LOGIN_MOLSU		int					set @GAME_STATE_FAIL_LOGIN_MOLSU	= 10	-- ��α������� ����.
	--declare @GAME_STATE_FAIL_LOGIN_ROLLBACK	int					set @GAME_STATE_FAIL_LOGIN_ROLLBACK	= 11	-- ��α������� �ѹ�
	--declare @GAME_STATE_FAIL_ADMIN_DEL		int					set @GAME_STATE_FAIL_ADMIN_DEL		= 12	-- �����ڰ� ������.
	--declare @GAME_STATE_FAIL_ADMIN_ROLLBACK	int					set @GAME_STATE_FAIL_ADMIN_ROLLBACK	= 13	-- �����ڰ� �ѹ�ó��.

	------------------------------------------------
	--	2-3. ���λ�� ����
	------------------------------------------------
	declare @comment				varchar(512)		set @comment			= ''
	declare @gameid					varchar(20)			set @gameid				= ''
	declare @cashcost				int					set @cashcost			= 0
	declare @gamecost				int					set @gamecost			= 0
	declare @sid					int					set @sid				= -1
	declare @blockstate				int					set @blockstate			= @BLOCK_STATE_YES

Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG 1 �Է�����', @gameid_ gameid_, @password_ password_, @sid_ sid_

	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	select
		@gameid 	= gameid,		@blockstate		= blockstate,
		@cashcost	= cashcost,		@gamecost		= gamecost,
		@sid		= sid
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 3-2 ��������', @gameid gameid, @blockstate blockstate, @sid sid, @cashcost cashcost, @gamecost gamecost

	------------------------------------------------
	-- 3-3. �� ���Ǻ� �б�
	------------------------------------------------
	if( @gameid = '' )
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR ���̵� �������� �ʴ´�.'
			--select 'DEBUG ' + @comment
		END
	else if (@blockstate = @BLOCK_STATE_YES)
		BEGIN
			-- �������ΰ�?
			set @nResult_ 	= @RESULT_ERROR_BLOCK_USER
			set @comment 	= '��ó���� ���̵��Դϴ�.'
			--select 'DEBUG ', @comment
		END
	else if(@sid_ != @sid)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_SESSION_ID_EXPIRE_LOGOUT
			set @comment 	= 'ERROR ������ ���� �Ǿ����ϴ�. (�α׾ƿ� �����ּ���.)'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS �����Դϴ�.'
			--select 'DEBUG ' + @comment

		END


	--------------------------------------------------------------
	-- �������.
	--------------------------------------------------------------
	select @nResult_ rtn, @comment comment,	@cashcost cashcost, @gamecost gamecost


	if(@nResult_ = @RESULT_SUCCESS)
		BEGIN
			select top 15 * from
				(select
					top 15
					idx, curturntime, curturndate, gamemode, select1, select2, select3, select4, rselect1, rselect2, rselect3, rselect4, gameresult
				from dbo.tSingleGameLog
				where gameid = @gameid_ and gamestate = @GAME_STATE_SUCCESS
			union all
				select
					top 15
					idx, curturntime, curturndate, gamemode, select1, select2, select3, select4, rselect1, rselect2, rselect3, rselect4, gameresult
				from dbo.tPracticeGameLog
				where gameid = @gameid_) as A
			order by curturntime desc
		END

	------------------------------------------------
	--	4-2. ��������
	------------------------------------------------
	set nocount off
End

