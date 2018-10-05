/*
-- select * from dbo.tSingleGame			where gameid = 'mtxxxx3' order by curturntime desc
-- select * from dbo.tSingleGamelog		where gameid = 'mtxxxx3' order by curturntime desc
-- delete from dbo.tSingleGame           where gameid = 'mtxxxx3'
-- delete from dbo.tSingleGameLog        where gameid = 'mtxxxx3'
-- update dbo.tUserMaster set sid = 333 	where gameid = 'mtxxxx3'
-- exec spu_GiftGainNew 'mtxxxx3', '049000s1i0n7t8445289', 333, -3, 40, -1		-- �� ��� ���� B
-- ������ -> ����ġ
-- ����  -> ���ͺ�ȭ

-- �̱۰��� ���� : ��  ��� ���� B(1505) x 1 -> OK
-- select=��ȣ:select:itemcode:cnt;
--        [1���ڸ�] : STRIKE( 0 ) : [listidx:13]	: ����(1) )
declare @curturntime int  		select top 1 @curturntime = nextturntime from tLottoInfo order by curturntime desc
declare @select varchar(100)	set @select = '1:0:13:1;2:-1:-1:0;3:-1:-1:0;4:-1:-1:0;'
exec spu_SGBet 'mtxxxx3', '049000s1i0n7t8445289', 333, 1, 11, @curturntime, @select, 7777, -1

-- �̱۰��� ���� : �� ���� ���� A(1600) x 1	-> ���úҰ�
--        [1���ڸ�] : STRIKE( 0 ) : [listidx:20]	: ����(1) )
declare @curturntime int  		select top 1 @curturntime = nextturntime from tLottoInfo order by curturntime desc
declare @select varchar(100)	set @select = '1:0:20:1;2:-1:-1:0;3:-1:-1:0;4:-1:-1:0;'
exec spu_SGBet 'mtxxxx3', '049000s1i0n7t8445289', 333, 1, 11, @curturntime, @select, 7777, -1


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
	@randserial_							varchar(20),
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
	declare @RESULT_ERROR_SESSION_ID_EXPIRE_LOGOUT	int			set @RESULT_ERROR_SESSION_ID_EXPIRE_LOGOUT	= -151		-- ������ ����Ǿ����ϴ�.
	declare @RESULT_ERROR_DOUBLE_IP				int				set @RESULT_ERROR_DOUBLE_IP				= -201			-- IP�ߺ�...
	declare @RESULT_ERROR_TURNTIME_WRONG		int				set @RESULT_ERROR_TURNTIME_WRONG		= -203			-- ȸ�������� �߸��Ǿ���
	declare @RESULT_ERROR_NOT_BET_ITEMLACK		int				set @RESULT_ERROR_NOT_BET_ITEMLACK		= -204			-- �������� �������� �ʰ� �����ҷ����Ͽ����ϴ�.
	declare @RESULT_ERROR_NOT_BET_SAFETIME		int				set @RESULT_ERROR_NOT_BET_SAFETIME		= -205			-- 30�� ~ ��� ~ 10�� �̽ð����� ���ñ���
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

	-- �÷�������.
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

	------------------------------------------------
	--	2-3. ���λ�� ����
	------------------------------------------------
	declare @comment				varchar(512)		set @comment			= ''
	declare @gameid					varchar(20)			set @gameid				= ''
	declare @sid					int					set @sid				= -1
	declare @cursyscheck			int					set @cursyscheck		= @SYSCHECK_YES
	declare @blockstate				int					set @blockstate			= @BLOCK_STATE_YES
	declare @itemcode				int 				set @itemcode 			= -1
	declare @cnt					int					set @cnt				= 0

	declare @curdate				datetime			set @curdate			= getdate()
	declare @curturntime			int					set @curturntime		= -1
	declare @curturndate			datetime			set @curturndate		= getdate()
	declare @curturntime2			int					set @curturntime2		= -1

	-- ����.
	declare @select1				int					set @select1			= -1
	declare @select2				int					set @select2			= -1
	declare @select3				int					set @select3			= -1
	declare @select4				int					set @select4			= -1
	declare @listidx1				int					set @listidx1			= -1
	declare @listidx2				int					set @listidx2			= -1
	declare @listidx3				int					set @listidx3			= -1
	declare @listidx4				int					set @listidx4			= -1
	declare @cnt1					int					set @cnt1				= 0
	declare @cnt2					int					set @cnt2				= 0
	declare @cnt3					int					set @cnt3				= 0
	declare @cnt4					int					set @cnt4				= 0
	declare @itemcode1				int					set @itemcode1			= -1
	declare @itemcode2				int					set @itemcode2			= -1
	declare @itemcode3				int					set @itemcode3			= -1
	declare @itemcode4				int					set @itemcode4			= -1
	declare @owncnt1				int					set @owncnt1			= 0
	declare @owncnt2				int					set @owncnt2			= 0
	declare @owncnt3				int					set @owncnt3			= 0
	declare @owncnt4				int					set @owncnt4			= 0

Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	select 'DEBUG �Է�����', @gameid_ gameid_, @password_ password_, @sid_ sid_, @gmode_ gmode_, @listidx_ listidx_, @curturntime_ curturntime_, @select_ select_, @randserial_ randserial_


	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	select
		@gameid 		= gameid,	@blockstate		= blockstate,
		@sid			= sid
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	select 'DEBUG 3-2 ��������', @gameid gameid, @sid sid

	--	3-3. �������� üũ
	select top 1 @cursyscheck = syscheck from dbo.tNotice order by idx desc
	select 'DEBUG 3-3 ��������', @cursyscheck cursyscheck

	-- ����������.
	select
		@itemcode 	= itemcode,
		@cnt		= cnt
	from dbo.tUserItem
	where gameid = @gameid_ and listidx = @listidx_
	select 'DEBUG 3-4 ����������.', @itemcode itemcode, @cnt cnt

	-- ȸ�� ����1
	select
		@curturntime = nextturntime,
		@curturndate = nextturndate
	from dbo.tLottoInfo where nextturntime = @curturntime_
	select 'DEBUG 3-5 ȸ������.', @curturntime curturntime, @curturndate curturndate, @curdate curdate

	-- ȸ�� ����2 > �����ϸ� �ȵȴ�.
	select
		@curturntime2 = curturntime
	from dbo.tLottoInfo where curturntime = @curturntime_
	select 'DEBUG 3-6 �������ΰ� ���ġ�ִ°�?(���� ������ �ȵ�).', @curturntime_ curturntime_, @curturntime2 curturntime2

	-- �������� �˻�.
	select top 1 * from dbo.tSingleGame where gameid = @gameid_ and curturntime = @curturntime_

	----------------------------------
	-- ������ ���� �˻�.
	----------------------------------
	SELECT @select1 = param2, @listidx1 = param3, @cnt1 = param4  FROM dbo.fnu_SplitFour(';', ':', @select_) where param1 = 1
	SELECT @select2 = param2, @listidx2 = param3, @cnt2 = param4  FROM dbo.fnu_SplitFour(';', ':', @select_) where param1 = 2
	SELECT @select3 = param2, @listidx3 = param3, @cnt3 = param4  FROM dbo.fnu_SplitFour(';', ':', @select_) where param1 = 3
	SELECT @select4 = param2, @listidx4 = param3, @cnt4 = param4  FROM dbo.fnu_SplitFour(';', ':', @select_) where param1 = 4
	select 'DEBUG 3-7 ���� ������.', @select1 select1, @listidx1 listidx2, @cnt1 cnt1, @select2 select2, @listidx2 listidx2, @cnt2 cnt2, @select3 select3, @listidx3 listidx3, @cnt3 cnt3, @select4 select4, @listidx4 listidx4, @cnt4 cnt4

	-- ��������..
	if(@select1 != -1)
		begin
			select
				@itemcode1 = itemcode, @owncnt1 = cnt
			from dbo.tUserItem
			where gameid = @gameid_ and listidx = @listidx1 and invenkind = @USERITEM_INVENKIND_PIECE
		end
	select 'DEBUG 3-7-1 ���� ������.', @select1 select1, @itemcode1 itemcode1, @owncnt1 owncnt1, @cnt1 cnt1

	if(@select2 != -1)
		begin
			select
				@itemcode2 = itemcode, @owncnt2 = cnt
			from dbo.tUserItem
			where gameid = @gameid_ and listidx = @listidx2 and invenkind = @USERITEM_INVENKIND_PIECE
		end
	select 'DEBUG 3-7-2 ���� ������.', @select2 select2, @itemcode2 itemcode2, @owncnt2 owncnt2, @cnt2 cnt2

	if(@select3 != -1)
		begin
			select
				@itemcode3 = itemcode, @owncnt3 = cnt
			from dbo.tUserItem
			where gameid = @gameid_ and listidx = @listidx3 and invenkind = @USERITEM_INVENKIND_PIECE
		end
	select 'DEBUG 3-7-3 ���� ������.', @select3 select3, @itemcode3 itemcode3, @owncnt3 owncnt3, @cnt3 cnt3

	if(@select4 != -1)
		begin
			select
				@itemcode4 = itemcode, @owncnt4 = cnt
			from dbo.tUserItem
			where gameid = @gameid_ and listidx = @listidx4 and invenkind = @USERITEM_INVENKIND_PIECE
		end
	select 'DEBUG 3-7-4 ���� ������.', @select4 select4, @itemcode4 itemcode4, @owncnt4 owncnt4, @cnt4 cnt4


	------------------------------------------------
	-- 3-3. �� ���Ǻ� �б�
	------------------------------------------------
	if(@cursyscheck = @SYSCHECK_YES)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_SERVER_CHECKING
			set @comment 	= 'DEBUG �ý��� �������Դϴ�.'
			select 'DEBUG ', @comment
		END
	else if( @gameid = '' )
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR ���̵� �������� �ʴ´�.'
			select 'DEBUG ' + @comment
		END
	else if (@blockstate = @BLOCK_STATE_YES)
		BEGIN
			-- �������ΰ�?
			set @nResult_ 	= @RESULT_ERROR_BLOCK_USER
			set @comment 	= '��ó���� ���̵��Դϴ�.'
			select 'DEBUG ', @comment
		END
	else if(@sid_ != @sid)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_SESSION_ID_EXPIRE_LOGOUT
			set @comment 	= 'ERROR ������ ���� �Ǿ����ϴ�. (�α׾ƿ� �����ּ���.)'
			select 'DEBUG ' + @comment
		END
	--else if(������� ������ �����Ѵ�?)
	--	BEGIN
	--		set @nResult_ 	= @RESULT_ERROR_SESSION_ID_EXPIRE_LOGOUT
	--		set @comment 	= 'ERROR ������ ���� �Ǿ����ϴ�.'
	--		select 'DEBUG ' + @comment
	--	END
	else if(@curdate > @curturndate)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_CALCULATE_LOTTO_WAIT_LOBBY
			set @comment 	= 'ERROR ����� ������̿��� (�κ񿡼� ����ؼ� ����Ŀ� �����ּ���.)'
			select 'DEBUG ' + @comment
		END
	else if(@listidx_ != -1 and @cnt <= 0)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_ITEM_LACK
			set @comment 	= 'ERROR �������� �����մϴ�.'
			select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS �غ��߽��ϴ�.'
			select 'DEBUG ' + @comment

			------------------------------------------------
			-- �������.
			------------------------------------------------
			--exec spu_DayLogInfoStatic 32, 1
		END


	--------------------------------------------------------------
	-- �������.
	--------------------------------------------------------------
	select @nResult_ rtn, @comment comment, @curdate curdate, @curturntime curturntime, @curturndate curturndate


	------------------------------------------------
	--	4-2. ��������
	------------------------------------------------
	set nocount off
End

