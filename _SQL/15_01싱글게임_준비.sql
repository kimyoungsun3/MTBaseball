/*
select * from dbo.tSingleGame			where gameid = 'mtxxxx3' order by curturntime desc
select * from dbo.tSingleGamelog		where gameid = 'mtxxxx3' order by curturntime desc
delete from dbo.tSingleGame           	where gameid = 'mtxxxx3'
delete from dbo.tSingleGameLog        	where gameid = 'mtxxxx3'
update dbo.tUserMaster set sid = 333 	where gameid = 'mtxxxx3'
-- ������ -> ����ġ
-- ����  -> ���ͺ�ȭ

-- �̱۰���.
exec spu_SGReady 'mtxxxx3', '049000s1i0n7t8445289', 333, 1, -1, -1		-- �Ҹ��۾���
exec spu_SGReady 'mtxxxx3', '049000s1i0n7t8445289', 333, 1, 10, -1		-- ��ġ�� �����ֹ���
exec spu_SGReady 'mtxxxx3', '049000s1i0n7t8445289', 333, 1, 11, -1		-- ������ �Ҹ�
exec spu_SGReady 'mtxxxx3', '049000s1i0n7t8445289', 333, 1, 12, -1		-- ������ ���� �ֹ���

-- error
exec spu_SGReady 'mtxxxx3', '049000s1i0n7t8445289', 333,  1,  1, -1		-- �ǻ����� �ֹ� > error
exec spu_SGReady 'mtxxxx3', '049000s1i0n7t8445289', 3331, 1, -1, -1		-- ������ ����Ȱ��.
--delete from dbo.tLottoInfo	where curturntime = (select top 1 curturntime from dbo.tLottoInfo order by curturntime desc)
exec spu_SGReady 'mtxxxx3', '049000s1i0n7t8445289', 333, 1, -1, -1		-- ������϶�.
exec spu_SGReady 'mtxxxx3', '049000s1i0n7t8445289', 333,  1,  11, -1		-- �Ҹ��� ��������
*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_SGReady', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_SGReady;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_SGReady
	@gameid_								varchar(20),					-- ���Ӿ��̵�
	@password_								varchar(20),
	@sid_									int,
	@gmode_									int,
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
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--�ش������� ã�� ����
	declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--������ �����ϰ� �ִ�.

	-- ��Ÿ����
	declare @RESULT_ERROR_ITEM_LACK				int				set @RESULT_ERROR_ITEM_LACK				= -23			--�������̺����ϴ�.
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- �������ڵ��ã��
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- ���������ʴ¸��
	declare @RESULT_ERROR_SESSION_ID_EXPIRE_LOGOUT	int			set @RESULT_ERROR_SESSION_ID_EXPIRE_LOGOUT	= -151		-- ������ ����Ǿ����ϴ�.
	declare @RESULT_ERROR_DOUBLE_IP				int				set @RESULT_ERROR_DOUBLE_IP				= -201			-- IP�ߺ�...
	declare @RESULT_ERROR_TURNTIME_WRONG		int				set @RESULT_ERROR_TURNTIME_WRONG		= -203			-- ȸ�������� �߸��Ǿ���
	declare @RESULT_ERROR_NOT_BET_ITEMLACK		int				set @RESULT_ERROR_NOT_BET_ITEMLACK		= -204			-- �������� �������� �ʰ� �����ҷ����Ͽ����ϴ�.
	declare @RESULT_ERROR_NOT_BET_SAFETIME		int				set @RESULT_ERROR_NOT_BET_SAFETIME		= -205			-- 30�� ~ ��� ~ 10�� �̽ð����� ���ñ���
	declare @RESULT_ERROR_NOT_BET_OVERTIME		int				set @RESULT_ERROR_NOT_BET_OVERTIME		= -211			-- ����Ÿ���̻󿡼��� ���úҰ�
	declare @RESULT_ERROR_NOT_INPUT_SUPERBALL_5TRY	int			set @RESULT_ERROR_NOT_INPUT_SUPERBALL_5TRY	= -207		-- ���ۺ� �����Ͱ� ���� �ȵ��ȡ� > 5���Ŀ� �ٽ� ��û
	declare @RESULT_ERROR_NOT_ING_TURNTIME			int			set @RESULT_ERROR_NOT_ING_TURNTIME		= -	208			-- �߸��� �� Ÿ���Դϴ�.
	declare @RESULT_ERROR_NOT_CALCULATE_LOTTO_WAIT_LOBBY	int	set @RESULT_ERROR_NOT_CALCULATE_LOTTO_WAIT_LOBBY= -209	-- �ζǿ��� ȸ�� ������ 5���� �Ǿ �ȿȡ� > �κ񿡼� ������ּ���.
	declare @RESULT_ERROR_NOT_CALCULATE_LOTTO_LOGOUT	int		set @RESULT_ERROR_NOT_CALCULATE_LOTTO_LOGOUT= -210		-- �ζǿ��� ȸ�� ������ ����Ÿ��������(5+5��) �ȵ��ȡ� > ������Ҹ�ŷ, �α׾ƿ�, �����ߡ�

	------------------------------------------------
	--	2-2. ���°�
	------------------------------------------------
	-- MT �����°�.
	declare @BLOCK_STATE_NO						int					set	@BLOCK_STATE_NO							= 0	-- �����¾ƴ�
	declare @BLOCK_STATE_YES					int					set	@BLOCK_STATE_YES						= 1	-- ������

	-- MT �ý��� üŷ
	declare @SYSCHECK_NON						int					set @SYSCHECK_NON							= 0
	declare @SYSCHECK_YES						int					set @SYSCHECK_YES							= 1

	-- MT �����ۺ� �κ��з�
	declare @USERITEM_INVENKIND_WEAR			int 				set @USERITEM_INVENKIND_WEAR				= 1
	declare @USERITEM_INVENKIND_PIECE			int 				set @USERITEM_INVENKIND_PIECE				= 2
	declare @USERITEM_INVENKIND_CONSUME			int 				set @USERITEM_INVENKIND_CONSUME				= 3

	-- MT ���Ӹ��.
	declare @GAME_MODE_PRACTICE					int					set @GAME_MODE_PRACTICE						= 0
	declare @GAME_MODE_SINGLE					int					set @GAME_MODE_SINGLE						= 1
	declare @GAME_MODE_MULTI					int					set @GAME_MODE_MULTI						= 2


	------------------------------------------------
	--	2-3. ���λ�� ����
	------------------------------------------------
	declare @comment				varchar(512)		set @comment			= ''
	declare @gameid					varchar(20)			set @gameid				= ''
	declare @cashcost				int					set @cashcost			= 0
	declare @gamecost				int					set @gamecost			= 0
	declare @sid					int					set @sid				= -1
	declare @cursyscheck			int					set @cursyscheck		= @SYSCHECK_YES
	declare @blockstate				int					set @blockstate			= @BLOCK_STATE_YES
	declare @consumeitemcode		int 				set @consumeitemcode 	= -1
	declare @consumecnt				int					set @consumecnt			= 0

	declare @curdate				datetime			set @curdate			= getdate()
	declare @curturntime			int					set @curturntime		= -1
	declare @curturndate			datetime			set @curturndate		= getdate()

Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG 3-1 �Է�����', @gameid_ gameid_, @password_ password_, @sid_ sid_, @gmode_ gmode_, @listidx_ listidx_

	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	select
		@gameid 		= gameid,	@blockstate		= blockstate,
		@cashcost		= cashcost,	@gamecost		= gamecost,
		@sid			= sid
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 3-2 ��������', @gameid gameid, @sid sid, @cashcost cashcost, @gamecost gamecost

	--	3-3. �������� üũ
	select top 1 @cursyscheck = syscheck from dbo.tNotice order by idx desc
	--select 'DEBUG 3-3 ��������', @cursyscheck cursyscheck

	-- �Ҹ��ۺ���������.
	if( @listidx_ != -1)
		begin
			select
				@consumeitemcode 	= itemcode,
				@consumecnt			= cnt
			from dbo.tUserItem
			where gameid = @gameid_ and listidx = @listidx_ and invenkind = @USERITEM_INVENKIND_CONSUME
			--select 'DEBUG 3-4 ����������.', @consumeitemcode consumeitemcode, @consumecnt consumecnt
		end

	-- ȸ�� ����
	select top 1
		@curturntime = nextturntime,
		@curturndate = nextturndate
	from dbo.tLottoInfo order by curturntime desc
	--select 'DEBUG 3-4 ����������.', @curturntime curturntime, @curturndate curturndate, @curdate curdate

	------------------------------------------------
	-- 3-3. �� ���Ǻ� �б�
	------------------------------------------------
	if(@cursyscheck = @SYSCHECK_YES)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_SERVER_CHECKING
			set @comment 	= 'DEBUG �ý��� �������Դϴ�.'
			--select 'DEBUG ', @comment
		END
	else if( @gameid = '' )
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
	else if( @gmode_ not in ( @GAME_MODE_PRACTICE, @GAME_MODE_SINGLE, @GAME_MODE_MULTI ) )
		BEGIN
			-- ������ �Ķ���Ͱ˻�?
			set @nResult_ 	= @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment 	= 'ERROR �������� �ʴ� ����Դϴ�.'
			--select 'DEBUG ' + @comment
		END
	--else if(������� ������ �����Ѵ�?)
	--	BEGIN
	--		set @nResult_ 	= @RESULT_ERROR_SESSION_ID_EXPIRE_LOGOUT
	--		set @comment 	= 'ERROR ������ ���� �Ǿ����ϴ�.'
	--		--select 'DEBUG ' + @comment
	--	END
	else if(@curdate > @curturndate)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_CALCULATE_LOTTO_WAIT_LOBBY
			set @comment 	= 'ERROR ����� ������̿��� (�κ񿡼� ����ؼ� ����Ŀ� �����ּ���.)'
			--select 'DEBUG ' + @comment
		END
	else if(@listidx_ != -1 and @consumecnt <= 0)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_ITEM_LACK
			set @comment 	= 'ERROR �������� �����մϴ�.'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS �غ��߽��ϴ�.'
			--select 'DEBUG ' + @comment

			------------------------------------------------
			-- �������.
			------------------------------------------------
			--exec spu_DayLogInfoStatic 32, 1
		END


	--------------------------------------------------------------
	-- �������.
	--------------------------------------------------------------
	select @nResult_ rtn, @comment comment, @curdate curdate, @curturntime curturntime, @curturndate curturndate, @cashcost cashcost, @gamecost gamecost



	------------------------------------------------
	--	4-2. ��������
	------------------------------------------------
	set nocount off
End

