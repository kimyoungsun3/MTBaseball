/*
-- listidx:11 -> ������ �Ҹ�(4600)
-- �̱۰��� ���� > 1��������, ��Ʈ����Ʈ(0) x 1��
--                 2 ~ 4�� �̼���
-- select=��ȣ:select:cnt;
--        [1���ڸ�] : STRIKE( 0 ) : ����(1) )
-- update dbo.tLottoInfo set nextturndate = DATEADD(ss, 0+5*60, getdate() ) where idx = ( select top 1 idx from dbo.tLottoInfo order by curturntime desc)
declare @curturntime int  		select top 1 @curturntime = nextturntime from tLottoInfo order by curturntime desc
--declare @select varchar(100)	set @select = '1:-1:0; 2:-1:0; 3:-1:0; 4:-1:0;'	-- 0�� ����
--declare @select varchar(100)	set @select = '1:0:100;2:-1:0; 3:-1:0; 4:-1:0;'	-- 1�� ����
declare @select varchar(100)	set @select = '1:0:100;2:0:100;3:0:100;4:0:100;'	-- 4�� ����

--delete from dbo.tSingleGame      	where gameid = 'mtxxxx3' and curturntime = (select top 1 nextturntime from tLottoInfo order by curturntime desc)
--delete from dbo.tSingleGameLog   	where gameid = 'mtxxxx3' and curturntime = (select top 1 nextturntime from tLottoInfo order by curturntime desc)
exec spu_SGBet 'mtxxxx3', '049000s1i0n7t8445289', 333, 1, 11, @curturntime, @select, -1

-- select * from dbo.tSingleGame		where gameid = 'mtxxxx3' order by curturntime desc
-- delete from dbo.tSingleGame      	where gameid = 'mtxxxx3' and curturntime = (select top 1 nextturntime from tLottoInfo order by curturntime desc)
-- select top 1 nextturntime from tLottoInfo order by curturntime desc


-- �̱۰��� ���� : �� ���� ���� A(1600) x 1	-> ���úҰ�
--        [1���ڸ�] : STRIKE( 0 ) : ����(1) )
declare @curturntime int  		select top 1 @curturntime = nextturntime from tLottoInfo order by curturntime desc
declare @select varchar(100)	set @select = '1:0:1;2:-1:0;3:-1:0;4:-1:0;'
exec spu_SGBet 'mtxxxx3', '049000s1i0n7t8445289', 333, 1, 11, @curturntime, @select, -1

-- ������ �Ұ��... > ������ �ȵȴ�.
declare @curturntime int  		select top 1 @curturntime = nextturntime from tLottoInfo order by curturntime desc
declare @select varchar(100)	set @select = ''	-- �ƹ��͵� ����.
exec spu_SGBet 'mtxxxx3', '049000s1i0n7t8445289', 333, 1, 11, @curturntime, @select, -1


-- ������ ����Ÿ�� ����ϰ� �ѵ������.
--update dbo.tSingleGame set gamestate = -2 where gameid = 'mtxxxx3' and idx = 56
delete from dbo.tSingleGame where gameid = 'mtxxxx3' and curturntime in ( 828644, 828643, 828645 )
delete from dbo.tSingleGameLog where gameid = 'mtxxxx3' and  curturntime in ( 828644, 828643, 828645 )
insert into tSingleGame (
							gameid,
							curturntime, curturndate, gamemode, consumeitemcode, select1, cnt1,
							select2, cnt2,
							select3, cnt3,
							select4, cnt4,
							selectdata, writedate, connectip, level, exp, commission, gamestate
						)
select
							'mtxxxx3',
							curturntime, curturndate, gamemode, consumeitemcode, select1, cnt1,
							select2, cnt2,
							select3, cnt3,
							select4, cnt4,
							selectdata, writedate, connectip, level, exp, commission, gamestate
from dbo.tSingleGame where gameid = 'mtxxxx2'
*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_SGBet', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_SGBet;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_SGBet
	@gameid_								varchar(20),					-- ���Ӿ��̵�
	@password_								varchar(20),
	@sid_									int,
	@gmode_									int,
	@listidx_								int,
	@curturntime_							int,
	@select_								varchar(100),
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

	-- MT ���Ӹ��.
	declare @GAME_MODE_PRACTICE					int					set @GAME_MODE_PRACTICE						= 0
	declare @GAME_MODE_SINGLE					int					set @GAME_MODE_SINGLE						= 1
	declare @GAME_MODE_MULTI					int					set @GAME_MODE_MULTI						= 2

	-- MT �÷���
	declare @SINGLE_FLAG_PLAY					int					set @SINGLE_FLAG_PLAY						= 1
	declare @SINGLE_FLAG_END					int					set @SINGLE_FLAG_END						= 0

	-- �÷�������.
	declare @SELECT_1							int					set @SELECT_1						= 1		-- ��Ʈ����ũ, ��.
	declare @SELECT_2							int					set @SELECT_2						= 2		-- ����, ��ȭ��.
	declare @SELECT_3							int					set @SELECT_3						= 3		-- ��, ��.
	declare @SELECT_4							int					set @SELECT_4						= 4		-- ��, ��.
	declare @BATTLE_END							int					set @BATTLE_END						= 0
	declare @SELECT_1_NON						int					set @SELECT_1_NON					= -1
	declare @SELECT_1_STRIKE					int					set @SELECT_1_STRIKE				= 0
	declare @SELECT_1_BALL						int					set @SELECT_1_BALL					= 1
	declare @SELECT_2_NON						int					set @SELECT_2_NON					= -1
	declare @SELECT_2_FAST						int					set @SELECT_2_FAST					= 0
	declare @SELECT_2_CURVE						int					set @SELECT_2_CURVE					= 1
	declare @SELECT_3_NON						int					set @SELECT_3_NON					= -1
	declare @SELECT_3_LEFT						int					set @SELECT_3_LEFT					= 0
	declare @SELECT_3_RIGHT						int					set @SELECT_3_RIGHT					= 1
	declare @SELECT_4_NON						int					set @SELECT_4_NON					= -1
	declare @SELECT_4_UP						int					set @SELECT_4_UP					= 0
	declare @SELECT_4_DOWN						int					set @SELECT_4_DOWN					= 1

	-- ��Ÿ����.
	declare @BET_TIME_START						int					set @BET_TIME_START					= -5 * 60 + 10
	declare @BET_TIME_END						int					set @BET_TIME_END					=         - 30
	declare @SAFE_TIME_START					int					set @SAFE_TIME_START				= @BET_TIME_END
	declare @SAFE_TIME_END						int					set @SAFE_TIME_END					=         + 10
	declare @OVER_TIME_START					int					set @OVER_TIME_START				= @SAFE_TIME_END
	declare @OVER_TIME_END						int					set @OVER_TIME_END					= +5 * 60

	declare @GAMECOST_MINIMUM_CNT				int					set @GAMECOST_MINIMUM_CNT			= 100	--�ּҹ���ī����.
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
	declare @consumeitemcode		int 				set @consumeitemcode	= -1
	declare @consumecnt				int					set @consumecnt			= 0
	declare @connectip				varchar(20)			set @connectip			= ''
	declare @level					int					set @level				= 1
	declare @exp					int					set @exp				= 0
	declare @commission				int					set @commission			= 700

	declare @curdate				datetime			set @curdate			= getdate()
	declare @curturntime			int					set @curturntime		= -1
	declare @curturndate			datetime			set @curturndate		= getdate() - 1

	-- ��������.
	declare @totalcnt				int					set @totalcnt			= 0
	declare @select1				int					set @select1			= -1
	declare @select2				int					set @select2			= -1
	declare @select3				int					set @select3			= -1
	declare @select4				int					set @select4			= -1
	declare @cnt1					int					set @cnt1				= 0
	declare @cnt2					int					set @cnt2				= 0
	declare @cnt3					int					set @cnt3				= 0
	declare @cnt4					int					set @cnt4				= 0

	DECLARE @tTempTable TABLE(
		listidx		int
	);
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG �Է�����', @gameid_ gameid_, @password_ password_, @sid_ sid_, @gmode_ gmode_, @listidx_ listidx_, @curturntime_ curturntime_, @select_ select_

	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	select
		@gameid 	= gameid,		@blockstate		= blockstate,
		@cashcost	= cashcost,		@gamecost		= gamecost,
		@connectip	= connectip, 	@exp			= exp,			@level	= level, @commission 	= commission,
		@sid		= sid
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 3-2 ��������', @gameid gameid, @sid sid, @blockstate blockstate, @connectip connectip, @exp exp, @cashcost cashcost, @gamecost gamecost

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
			--select 'DEBUG 3-4 �Ҹ��� ������Ȳ.', @consumeitemcode consumeitemcode, @consumecnt consumecnt
		end

	-- �������� ȸ�� ����
	select top 1
		@curturntime = nextturntime,
		@curturndate = nextturndate
	from dbo.tLottoInfo order by curturntime desc
	--select 'DEBUG 3-5 ȸ������.', @curdate curdate, @curturntime curturntime, @curturndate curturndate, @curdate curdate
	--select 'DEBUG 3-5 �ð��̵�.', @BET_TIME_START BET_TIME_START, @BET_TIME_END BET_TIME_END, @SAFE_TIME_START SAFE_TIME_START, @SAFE_TIME_END SAFE_TIME_END, @OVER_TIME_START OVER_TIME_START, @OVER_TIME_END OVER_TIME_END
	--select 'DEBUG 3-5 �ð��̵�.', @curdate curdate, @curturndate curturndate, DATEADD(ss, @OVER_TIME_START, @curturndate) p1, DATEADD(ss, @SAFE_TIME_START, @curturndate) p2, DATEADD(ss, @BET_TIME_START, @curturndate) p3

	if( @curturntime_ = -1 )
		begin
			set @curturntime_ = @curturntime
			--select 'DEBUG 3-5 ����Ÿ���� ��� �ֱٰ��� �״�� ����.', @curturntime_ curturntime_
		end

	---------------------------------------------------------
	-- ������ ���� �˻�.
	---------------------------------------------------------
	if( LEN( @select_ ) > 8)
		begin
			SELECT @select1 = param2, @cnt1 = param3  FROM dbo.fnu_SplitThree(';', ':', @select_) where param1 = 1
			SELECT @select2 = param2, @cnt2 = param3  FROM dbo.fnu_SplitThree(';', ':', @select_) where param1 = 2
			SELECT @select3 = param2, @cnt3 = param3  FROM dbo.fnu_SplitThree(';', ':', @select_) where param1 = 3
			SELECT @select4 = param2, @cnt4 = param3  FROM dbo.fnu_SplitThree(';', ':', @select_) where param1 = 4
		end
	--select 'DEBUG 3-7 ���� ������.', @select1 select1, @cnt1 cnt1, @select2 select2, @cnt2 cnt2, @select3 select3, @cnt3 cnt3, @select4 select4, @cnt4 cnt4

	-- �� ��������..
	set @totalcnt = @cnt1 + @cnt2 + @cnt3 + @cnt4

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
	else if(@curturntime_ != @curturntime)
		BEGIN
			-- (����ȸ������ != �ְ�ȸ���� ��������ȸ��)
			set @nResult_ 	= @RESULT_ERROR_TURNTIME_WRONG
			set @comment 	= 'ERROR ȸ�������� �߸��Ǿ���.'
			--select 'DEBUG ' + @comment
		END
	else if(@curdate > DATEADD(ss, @OVER_TIME_START, @curturndate))
		BEGIN
			-- ����ð� > ���������ϷΌ���ð� + 10���� ����Ÿ�� �̻� ���� ȸ���� �ȵ��Դ°�?
			set @nResult_ 	= @RESULT_ERROR_NOT_BET_OVERTIME
			set @comment 	= 'ERROR ����Ÿ���̻󿡼��� ���úҰ�'
			--select 'DEBUG ' + @comment
		END
	else if(@curdate > DATEADD(ss, @SAFE_TIME_START, @curturndate))
		BEGIN
			-- ����ð� > ���������ϷΌ���ð� - 30���� ~ +10���� ������ Ÿ���ΰ�?
			set @nResult_ 	= @RESULT_ERROR_NOT_BET_SAFETIME
			set @comment 	= 'ERROR ������Ÿ�ӿ����� ���úҰ�'
			--select 'DEBUG ' + @comment
		END
	else if(@curdate < DATEADD(ss, @BET_TIME_START, @curturndate))
		BEGIN
			-- ����ð� > ���������ϷΌ���ð�(bettime)�̳��� �ƴѰ�?
			set @nResult_ 	= @RESULT_ERROR_NOT_BET_SAFETIME
			set @comment 	= 'ERROR ���� �Ұ� Ÿ���Դϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if( @gmode_ not in ( @GAME_MODE_PRACTICE, @GAME_MODE_SINGLE, @GAME_MODE_MULTI ) )
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment 	= 'ERROR �������� �ʴ� ����Դϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if( LEN( @select_ ) = 0 )
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS �����߽��ϴ�.(������ ��Ͼ���)'
			--select 'DEBUG ' + @comment
		END
	else if(   ( LEN( @select_ ) < 6 )
			or ( @select1 = -1 and @select2 = -1 and @select3 = -1 and @select4 = -1 )
			or ( @cnt1    < 0     or  @cnt2 < 0      or @cnt3 < 0      or @cnt4 < 0 )
			)
		BEGIN
			-- ������ �Ķ���Ͱ˻�?
			set @nResult_ 	= @RESULT_ERROR_PARAMETER
			set @comment 	= 'ERROR �Ķ���Ͱ� �߸��Ǿ����ϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if(
			   ( @select1 != -1 and @cnt1 < @GAMECOST_MINIMUM_CNT )
			or ( @select2 != -1 and @cnt2 < @GAMECOST_MINIMUM_CNT )
			or ( @select3 != -1 and @cnt3 < @GAMECOST_MINIMUM_CNT )
			or ( @select4 != -1 and @cnt4 < @GAMECOST_MINIMUM_CNT )
			)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_MINUMUN_LACK
			set @comment 	= 'ERROR �ּҼ������� �۽��ϴ�.(100)'
			--select 'DEBUG ' + @comment
		END
	else if( @totalcnt > @gamecost )
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_GAMECOST_LACK
			set @comment 	= 'ERROR �������� �����մϴ�.(������)'
			--select 'DEBUG ' + @comment
		END
	else if( @consumeitemcode != -1 and @consumecnt <= 0 )
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_ITEM_LACK
			set @comment 	= 'ERROR �������� �����մϴ�.(�Ҹ���)'
			--select 'DEBUG ' + @comment
		END
	else if ( exists( select top 1 * from dbo.tSingleGame where gameid = @gameid_ and curturntime = @curturntime_ ) )
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS �����߽��ϴ�.(�ߺ�)'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS �����߽��ϴ�.'
			--select 'DEBUG ' + @comment

			set @level 		= dbo.fnu_GetLevel( @exp )
			set @commission = dbo.fnu_GetTax100FromLevel( @level )
			--select 'DEBUG ', @exp exp, @level level, @commission commission

			------------------------------------------------
			-- ���� ���̺� gameid�� ���� ���ñ��, ���������Ϸ�ð����.
			------------------------------------------------
			insert into dbo.tSingleGame(
						gameid, connectip, exp, level, commission,
						curturntime, curturndate,
						gamemode,
						consumeitemcode,
						selectdata,
						select1, cnt1,
						select2, cnt2,
						select3, cnt3,
						select4, cnt4
			)
			values (
						@gameid, @connectip, @exp, @level, @commission,
						@curturntime, @curturndate,
						@gmode_,
						@consumeitemcode,
						@select_,
						@select1, @cnt1,
						@select2, @cnt2,
						@select3, @cnt3,
						@select4, @cnt4
			)

			------------------------------------------------
			-- �Ҹ��� �����صα�
			------------------------------------------------
			if( @listidx_ != -1)
				begin
					update dbo.tUserItem
						set
							cnt = cnt - 1
					where gameid = @gameid_ and listidx = @listidx_ and invenkind = @USERITEM_INVENKIND_CONSUME

					-- �ݿ������� �����ϱ�.
					insert into @tTempTable( listidx ) values( @listidx_ )
				end

			------------------------------------------------
			-- �����Ѱ� �����ϱ�.
			------------------------------------------------
			set @gamecost = @gamecost - @totalcnt

			------------------------------------------------
			-- ��������
			------------------------------------------------
			update dbo.tUserMaster
				set
					singleflag	= @SINGLE_FLAG_PLAY,
					gamecost 	= @gamecost,
					level 		= @level,
					commission 	= @commission
			where gameid = @gameid_

		END


	--------------------------------------------------------------
	-- �������.
	--------------------------------------------------------------
	select @nResult_ rtn, @comment comment, @curdate curdate, @curturntime curturntime, @curturndate curturndate, @cashcost cashcost, @gamecost gamecost

	if(@nResult_ = @RESULT_SUCCESS)
		BEGIN
			--------------------------------------------------------------
			-- ���� ���� ������ ����
			--------------------------------------------------------------
			select * from dbo.tUserItem
			where gameid = @gameid_ and listidx in ( select listidx from @tTempTable )
		END

	------------------------------------------------
	--	4-2. ��������
	------------------------------------------------
	set nocount off
End

