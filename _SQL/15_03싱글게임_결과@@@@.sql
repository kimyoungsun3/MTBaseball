/*
exec spu_SGResult 'mtxxxx3', '049000s1i0n7t8445289', 3331, 1,    -1, -1		-- ���ǿ���
exec spu_SGResult 'mtxxxx3', '049000s1i0n7t8445289', 333, 1,     -1, -1		-- ȸ������ ( �ζ�X, ��ƼX, ���ζ�X )
exec spu_SGResult 'mtxxxx3', '049000s1i0n7t8445289', 333, 1, 829532, -1		-- ȸ������ ( �׳ɺ��� ��� > 5+5�� �ȵ��ȡ� > �α׾ƿ� )
exec spu_SGResult 'mtxxxx3', '049000s1i0n7t8445289', 333, 1, 829533, -1		-- ������ > 5+5�� �ȵ���> ������Ҹ�ŷ, �α׾ƿ� ���ּ���(���߿� �α����ϸ� �ڵ� �ѹ�˴ϴ�.)
exec spu_SGResult 'mtxxxx3', '049000s1i0n7t8445289', 333, 1, 829753, -1		-- �ζ������� �ȵ���.(�ٷι����Ѱ� �˻��ϴ¹��)
exec spu_SGResult 'mtxxxx3', '049000s1i0n7t8445289', 333, 1, 829750, -1		-- �����ϱ� ���°�.

declare @curturntime int  select top 1 @curturntime = curturntime from dbo.tSingleGame where gameid = 'mtxxxx3' order by curturntime desc
exec spu_SGResult 'mtxxxx3', '049000s1i0n7t8445289', 333, 1, @curturntime, -1

-- 829534
-- ��Ʈ����ũ(0) / 100 /	����(0) / 100 /	��(0) / 100 /	��(0) / 100 /
--         ��(1)	        ��ȭ(1)	        ��(0)	        ��(0)
exec spu_SGResult 'mtxxxx3', '049000s1i0n7t8445289', 333, 1, 830092, -1	-- 1������
exec spu_SGResult 'mtxxxx3', '049000s1i0n7t8445289', 333, 1, 830093, -1	-- 2������
exec spu_SGResult 'mtxxxx3', '049000s1i0n7t8445289', 333, 1, 830094, -1	-- 3������
exec spu_SGResult 'mtxxxx3', '049000s1i0n7t8445289', 333, 1, 828643, -1	-- 4������
exec spu_SGResult 'mtxxxx3', '049000s1i0n7t8445289', 333, 1, 829540, -1
exec spu_SGResult 'mtxxxx3', '049000s1i0n7t8445289', 333, 1, 829538, -1
exec spu_SGResult 'mtxxxx3', '049000s1i0n7t8445289', 333, 1, 829537, -1
exec spu_SGResult 'mtxxxx3', '049000s1i0n7t8445289', 333, 1, 829534, -1
exec spu_SGResult 'mtxxxx3', '049000s1i0n7t8445289', 333, 1, 828644, -1

*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_SGResult', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_SGResult;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_SGResult
	@gameid_								varchar(20),					-- ���Ӿ��̵�
	@password_								varchar(20),
	@sid_									int,
	@gmode_									int,
	@curturntime_							int,
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
	declare @RESULT_ERROR_GAMECOST_LACK			int				set @RESULT_ERROR_GAMECOST_LACK			= -24			--
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- �������ڵ��ã��
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- ���������ʴ¸��
	declare @RESULT_ERROR_PARAMETER				int				set @RESULT_ERROR_PARAMETER				= -122			-- �Ķ���Ϳ���.
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
	declare @RESULT_ERROR_ITEMCODE_GRADE_CHECK	int				set @RESULT_ERROR_ITEMCODE_GRADE_CHECK		= -212		-- ������ ����� �߸��Ǿ����ϴ�.
	declare @RESULT_ERROR_MINUMUN_LACK			int				set @RESULT_ERROR_MINUMUN_LACK				= -213		-- �ּҼ������� ����.

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

	-- MT ������ ��з�
	declare @ITEM_MAINCATEGORY_WEARPART			int					set @ITEM_MAINCATEGORY_WEARPART 			= 1 	-- ������(1)
	declare @ITEM_MAINCATEGORY_PIECEPART		int					set @ITEM_MAINCATEGORY_PIECEPART			= 15 	-- ������(15)
	declare @ITEM_MAINCATEGORY_COMSUME			int					set @ITEM_MAINCATEGORY_COMSUME				= 40 	-- �Ҹ�ǰ(40)
	declare @ITEM_MAINCATEGORY_CASHCOST			int					set @ITEM_MAINCATEGORY_CASHCOST 			= 50 	-- ĳ������(50)
	declare @ITEM_MAINCATEGORY_STATICINFO		int					set @ITEM_MAINCATEGORY_STATICINFO 			= 500 	-- ��������(500)
	declare @ITEM_MAINCATEGORY_LEVELUPREWARD	int					set @ITEM_MAINCATEGORY_LEVELUPREWARD		= 510 	-- ������ ����(510)

	-- �����ϱ�.
	declare @GIFTLIST_GIFT_KIND_MESSAGE			int					set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2

	-- MT ���Ӹ��.
	declare @GAME_MODE_PRACTICE					int					set @GAME_MODE_PRACTICE						= 0
	declare @GAME_MODE_SINGLE					int					set @GAME_MODE_SINGLE						= 1
	declare @GAME_MODE_MULTI					int					set @GAME_MODE_MULTI						= 2

	-- MT �÷���
	declare @SINGLE_FLAG_PLAY					int					set @SINGLE_FLAG_PLAY						= 1
	declare @SINGLE_FLAG_END					int					set @SINGLE_FLAG_END						= 0

	-- ��Ÿ����.
	declare @BET_TIME_START						int					set @BET_TIME_START					= -5 * 60 + 10
	declare @BET_TIME_END						int					set @BET_TIME_END					=         - 30
	declare @SAFE_TIME_START					int					set @SAFE_TIME_START				= @BET_TIME_END
	declare @SAFE_TIME_END						int					set @SAFE_TIME_END					=         + 10
	declare @OVER_TIME_START					int					set @OVER_TIME_START				= @SAFE_TIME_END
	declare @OVER_TIME_END						int					set @OVER_TIME_END					= +5 * 60

	-- ���û���.
	declare @GAME_STATE_ING						int					set @GAME_STATE_ING					= -1	-- ����������.
	declare @GAME_STATE_ROLLBACK				int					set @GAME_STATE_ROLLBACK			= -2	-- �ѹ鿹����.
	declare @GAME_STATE_SUCCESS					int					set @GAME_STATE_SUCCESS				= 0		-- ����ó��.
	--declare @GAME_STATE_FAIL_LOGIN_MOLSU		int					set @GAME_STATE_FAIL_LOGIN_MOLSU	= 10	-- ��α������� ����.
	--declare @GAME_STATE_FAIL_LOGIN_ROLLBACK	int					set @GAME_STATE_FAIL_LOGIN_ROLLBACK	= 11	-- ��α������� �ѹ�
	--declare @GAME_STATE_FAIL_ADMIN_DEL		int					set @GAME_STATE_FAIL_ADMIN_DEL		= 12	-- �����ڰ� ������.
	--declare @GAME_STATE_FAIL_ADMIN_ROLLBACK	int					set @GAME_STATE_FAIL_ADMIN_ROLLBACK	= 13	-- �����ڰ� �ѹ�ó��.

	-- ���ð��.
	declare @GAME_RESULT_ING					int					set @GAME_RESULT_ING				= -1
	declare @GAME_RESULT_OUT					int					set @GAME_RESULT_OUT				= 0
	declare @GAME_RESULT_ONEHIT					int					set @GAME_RESULT_ONEHIT				= 1
	declare @GAME_RESULT_TWOHIT					int					set @GAME_RESULT_TWOHIT				= 2
	declare @GAME_RESULT_THREEHIT				int					set @GAME_RESULT_THREEHIT			= 3
	declare @GAME_RESULT_HOMERUN				int					set @GAME_RESULT_HOMERUN			= 4

	-- ������ ������ ����.
	declare @SELECT_1_STRIKE					int					set @SELECT_1_STRIKE				=  0
	declare @SELECT_1_BALL						int					set @SELECT_1_BALL					=  1
	declare @SELECT_2_FAST						int					set @SELECT_2_FAST					=  0
	declare @SELECT_2_CURVE						int					set @SELECT_2_CURVE					=  1
	declare @SELECT_3_LEFT						int					set @SELECT_3_LEFT					=  0
	declare @SELECT_3_RIGHT						int					set @SELECT_3_RIGHT					=  1
	declare @SELECT_4_UP						int					set @SELECT_4_UP					=  0
	declare @SELECT_4_DOWN						int					set @SELECT_4_DOWN					=  1

	-- �÷�������.
	declare @RESULT_SELECT_NON					int					set @RESULT_SELECT_NON				= -1
	declare @RESULT_SELECT_LOSE					int					set @RESULT_SELECT_LOSE				=  0
	declare @RESULT_SELECT_WIN					int					set @RESULT_SELECT_WIN				=  1

	-- ��Ÿ���.
	declare @COMMISSION_BASE					int					set @COMMISSION_BASE				= 700

	-- ����� ���� ����ġ
	declare @EXP_OUT							int					set @EXP_OUT						= 5
	declare @EXP_ONE_HIT						int					set @EXP_ONE_HIT					= 20
	declare @EXP_TWO_HIT						int					set @EXP_TWO_HIT					= 40
	declare @EXP_THREE_HIT						int					set @EXP_THREE_HIT					= 80
	declare @EXP_HOMERUN						int					set @EXP_HOMERUN					= 160

	------------------------------------------------
	--	2-3. ���λ�� ����
	------------------------------------------------
	declare @comment				varchar(512)		set @comment			= ''
	declare @gameid					varchar(20)			set @gameid				= ''
	declare @cashcost				int					set @cashcost			= 0
	declare @gamecost				int					set @gamecost			= 0
	declare @sid					int					set @sid				= -1
	declare @exp					int					set @exp				= 0
	declare @level					int					set @level				= 1
	declare @level2					int					set @level2				= 1
	declare @wearplusexp			int					set @wearplusexp		= 0
	declare @commission				int					set @commission			= @COMMISSION_BASE
	declare @cursyscheck			int					set @cursyscheck		= @SYSCHECK_YES
	declare @blockstate				int					set @blockstate			= @BLOCK_STATE_YES

	-- ��������.
	declare @curdate				datetime			set @curdate			= getdate()
	declare @curturntime			int					set @curturntime		= -1
	declare @curturndate			datetime			set @curturndate		= getdate() - 1
	declare @nextturntime			int					set @nextturntime		= -1
	declare @nextturndate			datetime			set @nextturndate		= getdate() - 1
	declare @select1				int					set @select1			= @RESULT_SELECT_NON
	declare @select2				int					set @select2			= @RESULT_SELECT_NON
	declare @select3				int					set @select3			= @RESULT_SELECT_NON
	declare @select4				int					set @select4			= @RESULT_SELECT_NON
	declare @cnt1					int					set @cnt1				= 0
	declare @cnt2					int					set @cnt2				= 0
	declare @cnt3					int					set @cnt3				= 0
	declare @cnt4					int					set @cnt4				= 0
	declare @connectip				varchar(20)			set @connectip			= ''
	declare @commissionbet			int					set @commissionbet		= @COMMISSION_BASE
	declare @gamestate				int					set @gamestate			= @GAME_STATE_ING
	declare @idx2					int					set @idx2				= 0
	declare @gameresult				int					set @gameresult			= @GAME_RESULT_ING
	declare @gainexp				int					set @gainexp			= 0
	declare @gaingamecost			int					set @gaingamecost		= 0
	declare @gaingamecostbet		int					set @gaingamecostbet	= 0
	declare @pcgameid				varchar(20)			set @pcgameid			= ''

	-- ���ð��.
	declare @rselect1				int					set @rselect1			= @RESULT_SELECT_NON
	declare @rselect2				int					set @rselect2			= @RESULT_SELECT_NON
	declare @rselect3				int					set @rselect3			= @RESULT_SELECT_NON
	declare @rselect4				int					set @rselect4			= @RESULT_SELECT_NON
	declare @rcnt1					int					set @rcnt1				= 0
	declare @rcnt2					int					set @rcnt2				= 0
	declare @rcnt3					int					set @rcnt3				= 0
	declare @rcnt4					int					set @rcnt4				= 0
	declare @betgamecosttotal		int					set @betgamecosttotal	= 0		-- ������ ���� ��.
	declare @betgamecostwin			int					set @betgamecostwin		= 0		-- ������ ���� ���.
	declare @betgamecostlose		int					set @betgamecostlose	= 0
	declare @rgamecostwin			int					set @rgamecostwin		= 0		-- ����� ���� ���.
	declare @rgamecostlose			int					set @rgamecostlose		= 0
	declare @rpcgamecost			int					set @rpcgamecost		= 0		-- pc�濡 �ִ°�.
	declare @betgamecostorg			int					set @betgamecostorg		= 0		-- �ܼ��ϰ� ���ñݾ�, ȹ��ݾ�
	declare @betgamecostearn		int					set @betgamecostearn	= 0

	--�ζ�ȸ������.
	declare @ltcurturntime			int					set @ltcurturntime		= -1
	declare @ltcurturntime2			int					set @ltcurturntime2		= -1
	declare @ltcurturndate			datetime			set @ltcurturndate		= getdate() - 1
	declare @ltcurturndate2			datetime			set @ltcurturndate2		= getdate() - 1
	declare @ltselect1				int					set @ltselect1			= -1
	declare @ltselect2				int					set @ltselect2			= -1
	declare @ltselect3				int					set @ltselect3			= -1
	declare @ltselect4				int					set @ltselect4			= -1

	-- ��Ÿ����.
	declare @levelupitemcode		int					set @levelupitemcode	= -1
	declare @giftsendexists			int					set @giftsendexists		= -1

	--DECLARE @tTempTable TABLE(
	--	listidx		int
	--);
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG 1 �Է�����', @gameid_ gameid_, @password_ password_, @sid_ sid_, @gmode_ gmode_, @curturntime_ curturntime_

	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	select
		@gameid 	= gameid,		@blockstate		= blockstate,
		@cashcost	= cashcost,		@gamecost		= gamecost,			@gaingamecost 	= gaingamecost,
		@exp		= exp,			@level			= level,			@wearplusexp	= wearplusexp,
		@sid		= sid
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 3-2 ��������', @gameid gameid, @blockstate blockstate, @sid sid, @cashcost cashcost, @gamecost gamecost

	if(@gameid != '')
		begin
			--	3-3. �������� üũ
			select top 1 @cursyscheck = syscheck from dbo.tNotice order by idx desc
			--select 'DEBUG 3-3 ��������', @cursyscheck cursyscheck

			-- ��������.
			select
				@curturntime= curturntime,	@curturndate 	= curturndate,
				@select1	= select1, 		@cnt1 = cnt1,
				@select2	= select2, 		@cnt2 = cnt2,
				@select3	= select3, 		@cnt3 = cnt3,
				@select4	= select4, 		@cnt4 = cnt4,
				@connectip	= connectip, 	@commissionbet = commissionbet
			from dbo.tSingleGame
			where gameid = @gameid and curturntime = @curturntime_ and gamemode = @gmode_
			--select 'DEBUG 3-5 ���������� ȸ������.', @curdate curdate, @curturntime curturntime, @curturndate curturndate, @select1 select1, @cnt1 cnt1, @select2 select2, @cnt2 cnt2, @select3 select3, @cnt3 cnt3, @select4 select4, @cnt4 cnt4, @connectip connectip, @commissionbet commissionbet

			-- �������� ȸ�� ����
			select
				@ltcurturntime 	= curturntime,	@ltcurturndate = curturndate,
				@ltselect1		= select1,
				@ltselect2		= select2,
				@ltselect3		= select3,
				@ltselect4		= select4
			from dbo.tLottoInfo
			where curturntime = @curturntime_
			--select 'DEBUG 3-7 ����ȸ������.', @ltcurturntime ltcurturntime, @ltcurturndate ltcurturndate, @ltselect1 ltselect1, @ltselect2 ltselect2, @ltselect3 ltselect3, @ltselect4 ltselect4

			-- ��ȸ������ ����ð��� �����������ؼ�.
			if( @curturntime = -1)
				begin
					select
						@ltcurturntime2 	= nextturntime,	@ltcurturndate2 = nextturndate
					from dbo.tLottoInfo
					where nextturntime = @curturntime_
					--select 'DEBUG 3-8 ����ȸ������(�ζǰ��ȵ��ͼ� ����).', @ltcurturntime2 ltcurturntime2, @ltcurturndate2 ltcurturndate2
				end

			------------------------------------------------
			-- ����ȸ�� ����
			------------------------------------------------
			select top 1
				@nextturntime = nextturntime,
				@nextturndate = nextturndate
			from dbo.tLottoInfo order by curturntime desc
			--select 'DEBUG 3-5 ȸ������.', @curdate curdate, @nextturntime nextturntime, @nextturndate nextturndate

		end

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
	else if( @ltcurturntime = -1 and @curturntime = -1 and @ltcurturntime2 = -1 )
		BEGIN
			-- �ζ�X, ��ƼX, ���ζ�X
			set @nResult_ 	= @RESULT_ERROR_PARAMETER
			set @comment 	= 'ERROR �Ķ���Ϳ��� (�ζ�, ����, ���ζ� ������ ����)'
			--select 'DEBUG ' + @comment
		END
	else if( @ltcurturntime = -1 and @curturntime  = -1 and @curdate > DATEADD(ss, @OVER_TIME_END, @ltcurturndate2) )
		BEGIN
			-- �ζ�X, ��ƼX, ���ζ�O
			set @nResult_ = @RESULT_ERROR_NOT_CALCULATE_LOTTO_LOGOUT
			set @comment = 'ERROR �׳ɺ��� ��� > 5+5�� �ȵ��ȡ� > �α׾ƿ� ���ּ���.'
			--select 'DEBUG ' + @comment
		END
	else if( @ltcurturntime = -1 and @curturntime != -1 and @curdate > DATEADD(ss, @OVER_TIME_END, @curturndate) )
		BEGIN
			-- �ζ�X, ��ƼO, ���ζ�O
			set @nResult_ = @RESULT_ERROR_NOT_CALCULATE_LOTTO_LOGOUT
			set @comment = 'ERROR ������ > 5+5�� �ȵ���> ������Ҹ�ŷ, �α׾ƿ� ���ּ���(���߿� �α����ϸ� �ڵ� �ѹ�˴ϴ�.)'

			-- �������� -> �ڵ� ��Ҹ�ŷ�صα�(-2)��α����ϸ� �ڵ����� ó����)
			update dbo.tSingleGame
				set
					gamestate = @GAME_STATE_ROLLBACK
			where gameid = @gameid and curturntime = @curturntime_ and gamemode = @gmode_

			--select 'DEBUG ' + @comment
		END
	else if(    ( @ltcurturntime = -1 and @curturntime  = -1 and @curdate > @ltcurturndate2 )
			 or ( @ltcurturntime = -1 and @curturntime != -1 and @curdate > @curturndate ) )
		BEGIN
			-- ����ð� > ���������ϷΌ���ð� + 10���� ����Ÿ�� �̻� ���� ȸ���� �ȵ��Դ°�?
			set @nResult_ 	= @RESULT_ERROR_NOT_INPUT_SUPERBALL_5TRY
			set @comment 	= 'ERROR ���ۺ� �����Ͱ� ���� �ȵ��ȡ� > 5���Ŀ� �ٽ� ��û(1)'
			--select 'DEBUG ' + @comment
		END
	else if( @ltcurturntime = -1 )
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_INPUT_SUPERBALL_5TRY
			set @comment 	= 'ERROR ���ۺ� �����Ͱ� ���� �ȵ��ȡ� > 5���Ŀ� �ٽ� ��û(2)'
			--select 'DEBUG ' + @comment
		END
	else if ( exists( select top 1 * from dbo.tSingleGameLog where gameid = @gameid_ and curturntime = @curturntime_ ) )
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS ���û����ߴ�.(�ߺ�)'
			--select 'DEBUG ' + @comment
		END
	-- ���Ϻ��ʹ� �ζ������� ���� ����...(������ ��������)
	else if( @ltcurturntime != -1 and @curturntime  = -1 )
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'SUCCESS �׳� �����ϱ� ���ؼ� ���°�'
			--select 'DEBUG ' + @comment
		END
	else if ( @ltcurturntime != -1 and @curturntime = @ltcurturntime )
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS ���û����߽��ϴ�.'
			--select 'DEBUG ' + @comment

			------------------------------------------------
			-- 700(7%) - �Ҹ���(2~3%) - ����(0~6.5%) => 0% ���Ϸδ� �ȳ�����
			-- ������ϱ� 1, 2, 3, 4
			--	if(��� : �̹���)		> �н�
			--	else if(��� > ���� )  > ������ ����(���̾ƹٷ�Plus)
			--	else ��� > ����      	> ������ ����
			------------------------------------------------
			select @rselect1 = rselect, @rcnt1 = rcnt from dbo.fnu_GetSingleGameResult( @ltselect1, @select1, @cnt1)
			--select 'DEBUG �����1', @select1 select1, @ltselect1 ltselect1, @cnt1 cnt1, @rselect1 rselect1, @rcnt1 rcnt1

			select @rselect2 = rselect, @rcnt2 = rcnt from dbo.fnu_GetSingleGameResult( @ltselect2, @select2, @cnt2)
			--select 'DEBUG �����2', @select2 select2, @ltselect2 ltselect2, @cnt2 cnt2, @rselect2 rselect2, @rcnt2 rcnt2

			select @rselect3 = rselect, @rcnt3 = rcnt from dbo.fnu_GetSingleGameResult( @ltselect3, @select3, @cnt3)
			--select 'DEBUG �����3', @select3 select3, @ltselect3 ltselect3, @cnt3 cnt3, @rselect3 rselect3, @rcnt3 rcnt3

			select @rselect4 = rselect, @rcnt4 = rcnt from dbo.fnu_GetSingleGameResult( @ltselect4, @select4, @cnt4)
			--select 'DEBUG �����4', @select4 select4, @ltselect4 ltselect4, @cnt4 cnt4, @rselect4 rselect4, @rcnt4 rcnt4

			--����� ���� ��, ��������,
			set @betgamecosttotal 	= @cnt1  + @cnt2  + @cnt3  + @cnt4
			set @betgamecostwin		= @rcnt1 + @rcnt2 + @rcnt3 + @rcnt4
			set @betgamecostlose	= @betgamecosttotal - @betgamecostwin
			set @rgamecostwin 		= @betgamecostwin
			set @rgamecostlose		= @betgamecostlose
			--select 'DEBUG ��������.', @betgamecosttotal betgamecosttotal, @cnt1 cnt1, @cnt2 cnt2, @cnt3 cnt3, @cnt4 cnt4
			--select 'DEBUG ��������.', @betgamecostwin betgamecostwin, @betgamecostlose betgamecostlose, @rcnt1 rcnt1, @rcnt2 rcnt2, @rcnt3 rcnt3, @rcnt4 rcnt4
			--select 'DEBUG ��������.', @rgamecostwin rgamecostwin, @rgamecostlose rgamecostlose

			set @rpcgamecost	 	=                 @betgamecosttotal * @commissionbet / 10000
			set @rgamecostwin		= @rgamecostwin  - @rgamecostwin    * @commissionbet / 10000
			set @rgamecostlose		= @rgamecostlose - @rgamecostlose   * @commissionbet / 10000
			--set @betgamecostwin	= betgamecostwin
			--select 'DEBUG ��������.', @betgamecosttotal betgamecosttotal, @commissionbet commissionbet, @rpcgamecost rpcgamecost, @betgamecostwin betgamecostwin, @rgamecostwin rgamecostwin, @rgamecostlose rgamecostlose

			-- �����ϰ� ���� �����.(���ں�� -> ������(��������� �����������ϰ�))
			set @betgamecostorg		= @betgamecosttotal
			set @betgamecostearn	= @betgamecostwin + @rgamecostwin

			-- ��������, PC��, ȸ��������ϱ�.
			set @gaingamecostbet= (@betgamecostwin + @rgamecostwin) - @betgamecosttotal
			set @gaingamecost	= @gaingamecost + @gaingamecostbet
			set @gamecost 		= @gamecost + ( @betgamecostwin + @rgamecostwin )
			--select 'DEBUG ��������.', @gaingamecost gaingamecost

			-- ���Ӱ��.
			set @gameresult =
				  case when @rselect1 = @RESULT_SELECT_WIN then 1 else 0 end
				+ case when @rselect2 = @RESULT_SELECT_WIN then 1 else 0 end
				+ case when @rselect3 = @RESULT_SELECT_WIN then 1 else 0 end
				+ case when @rselect4 = @RESULT_SELECT_WIN then 1 else 0 end
			--select 'DEBUG ���Ӱ�� ', @gameresult gameresult, @rselect1 rselect1, @rselect2 rselect2, @rselect3 rselect3, @rselect4 rselect4

			------------------------------------------------
			--����ġ, ���� <- ��������ۿ� ���� ����ġ +plus (���������̺�), �÷���(0)
			------------------------------------------------
			set @gainexp = case
								when @gameresult <= 0 then @EXP_OUT
								when @gameresult <= 1 then @EXP_ONE_HIT
								when @gameresult <= 2 then @EXP_TWO_HIT
								when @gameresult <= 3 then @EXP_THREE_HIT
								else 					   @EXP_HOMERUN
							end
			--select 'DEBUG ���Ӱ�� -> ����ġ(������������) ', @gameresult gameresult, @gainexp gainexp, @wearplusexp wearplusexp
			set @gainexp = @gainexp + @gainexp * @wearplusexp / 10000
			--select 'DEBUG ���Ӱ�� -> ����ġ(������������) ', @gameresult gameresult, @gainexp gainexp, @wearplusexp wearplusexp

			set @exp 			= @exp + @gainexp
			set @level2			= dbo.fnu_GetLevel( @exp )
			set @commission 	= @COMMISSION_BASE - dbo.fnu_GetTax100FromLevel( @level2 )
			set @commission = CASE
									WHEN @commission < 0 THEN 	0
									ELSE						@commission
							  END
			--select 'DEBUG ���Ӱ�� -> ����ġ ', @gainexp gainexp, @exp exp, @level level, @level2 level2, @commission commission

			--select 'DEBUG �������� ���� ������ ����?', @level level, @level2 level2
			--set @level = 9
			--set @level2 = 10
			if( @level != @level2 )
				begin
					--select 'DEBUG ������ ����Ǿ ������ ���ް��� �ִ°�?'
					select @levelupitemcode = param2
					from dbo.tItemInfo
					where category = @ITEM_MAINCATEGORY_LEVELUPREWARD and param1 = @level2

					if( @levelupitemcode != -1 )
						begin
							--select 'DEBUG ������ �˻� > ������ ����', @levelupitemcode levelupitemcode
							exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT,  @levelupitemcode,  1, 'SysLevelup', @gameid_, ''

							-- �ݿ������� �����ϱ�.
							set @giftsendexists = 1
						end
				end

			------------------------------------------------
			-- PC�� ���ֿ��� ���־��ֱ�.
			-- ����, ȸ��, PC�� ���ͺκ� ���⼭ ����غ����Ѵ�. ������ �̱�����
			------------------------------------------------
			select @pcgameid = gameid from dbo.tPCRoomIP where connectip = @connectip
			--select 'DEBUG PC���ְ˻�', @pcgameid pcgameid, @connectip connectip

			if( @pcgameid != '' )
				begin
					--select 'DEBUG PC���ֳ־��ֱ�', @rpcgamecost rpcgamecost, gamecost, gaingamecostpc from dbo.tUserMaster where gameid = @pcgameid
					-- pc ���� ������Ʈ.
					update dbo.tPCRoomIP
						set
							cnt 			= cnt + 1,
							gaingamecost 	= gaingamecost + @rpcgamecost
					 where connectip = @connectip

					 --select 'DEBUG �Ϻ���� > PC�����..(��, ��).', @pcgameid pcgameid, @rpcgamecost rpcgamecost
					 exec dbo.spu_SinglePCRoomLog @pcgameid, @connectip, 0, @rpcgamecost

					 -- PC�� ���ֿ��� �������ֱ�.
					 update dbo.tUserMaster
					 	set
					 		gamecost 		= gamecost       + @rpcgamecost,
					 		gaingamecostpc 	= gaingamecostpc + @rpcgamecost
					 where gameid = @pcgameid
				end

			------------------------------------------------
			-- ���÷ΰ� ����ϱ�.
			------------------------------------------------
			--select 'DEBUG ', @select1 select1, @select2 select2, @select3 select3, @select4 select4, @rselect1 rselect1, @rselect2 rselect2, @rselect3 rselect3, @rselect4 rselect4, @betgamecostorg betgamecostorg, @betgamecostearn betgamecostearn
			exec dbo.spu_SingleGameEarnLog @select1, @select2, @select3, @select4, @rselect1, @rselect2, @rselect3, @rselect4, @betgamecostorg, @betgamecostearn

			------------------------------------------------
			-- �������̺� -> ���÷ΰ�� �̵�, ��Ÿ���� �Է�
			------------------------------------------------
			select @idx2 = ( ISNULL( MAX( idx2 ), 0) + 1) from dbo.tSingleGameLog where gameid = @gameid_
			insert into dbo.tSingleGameLog
			(
						idx2,
						gameid, curturntime, curturndate, gamemode, consumeitemcode,
						select1, cnt1, select2, cnt2, select3, cnt3, select4, cnt4,
						selectdata, writedate, connectip, level, exp, commissionbet, gamestate,
						gameresult,
						gainexp,
						gaingamecost,
						rselect1, rselect2, rselect3, rselect4,
						ltselect1, ltselect2, ltselect3, ltselect4,
						betgamecostorg, betgamecostearn,
						pcgameid, pcgamecost, resultdate
			)
			select 		@idx2,
						gameid, curturntime, curturndate, gamemode, consumeitemcode,
						select1, cnt1, select2, cnt2, select3, cnt3, select4, cnt4,
						selectdata, writedate, connectip, level, exp, commissionbet, @GAME_STATE_SUCCESS,
						@gameresult,
						@gainexp,
						@gaingamecostbet,
						@rselect1, @rselect2, @rselect3, @rselect4,
						@ltselect1, @ltselect2, @ltselect3, @ltselect4,
						@betgamecostorg, @betgamecostearn,
						@pcgameid, @rpcgamecost, getdate()
			from dbo.tSingleGame
			where gameid = @gameid_ and curturntime = @curturntime


			------------------------------------------------
			-- �����ϱ�.
			------------------------------------------------
			--select 'DEBUG 2-3 ������������', * from dbo.tSingleGame where gameid = @gameid_ and curturntime = @curturntime
			delete from dbo.tSingleGame where gameid = @gameid_ and curturntime = @curturntime

			------------------------------------------------
			-- ��������
			------------------------------------------------
			update dbo.tUserMaster
				set
					singleflag	= @SINGLE_FLAG_END,
					cashcost	= @cashcost, 			gamecost 	= @gamecost,	gaingamecost = @gaingamecost,
					exp			= @exp, 				level 		= @level2,
					commission	= @commission
			where gameid = @gameid_
		END


	--------------------------------------------------------------
	-- �������.
	--------------------------------------------------------------
	select @nResult_ rtn, @comment comment,
	@curdate curdate, @curturntime curturntime, @curturndate curturndate,
	@nextturntime nextturntime, @nextturndate nextturndate,
	@cashcost cashcost, @gamecost gamecost,
	@ltselect1 ltselect1, @ltselect2 ltselect2, @ltselect3 ltselect3, @ltselect4 ltselect4,
	@rselect1 rselect1, @rselect2 rselect2, @rselect3 rselect3, @rselect4 rselect4,
	@rcnt1 rcnt1, @rcnt2 rcnt2, @rcnt3 rcnt3, @rcnt4 rcnt4,
	@gameresult gameresult


	if(@nResult_ = @RESULT_SUCCESS)
		BEGIN
			--------------------------------------------------------------
			-- ���� ���� ������ ����
			--------------------------------------------------------------

			if( @giftsendexists != -1 )
				begin
					exec spu_GiftList @gameid_
				end
		END

	------------------------------------------------
	--	4-2. ��������
	------------------------------------------------
	set nocount off
End

