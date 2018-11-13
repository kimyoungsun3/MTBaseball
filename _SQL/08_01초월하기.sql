/*
-- �ʿ� + �ʿ��ֹ���.
insert into dbo.tUserItem(gameid,      listidx,  itemcode, cnt,  invenkind,   gethow,  randserial)  values(					 'mtxxxx3',       332,       101,  1,           1,       20,        7712)
exec spu_ItemEvolve 'mtxxxx3', '049000s1i0n7t8445289', 333, 332, 15, 7711, -1	-- �� ����ʿ�.
exec spu_ItemEvolve 'mtxxxx3', '049000s1i0n7t8445289', 333, 332, 15, 7712, -1

--update dbo.tUserMaster set helmetlistidx = 86 where gameid = 'mtxxxx3'
exec spu_ItemEvolve 'mtxxxx3', '049000s1i0n7t8445289', 333, 86, 15, 7712, -1
*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_ItemEvolve', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_ItemEvolve;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_ItemEvolve
	@gameid_								varchar(20),					-- ���Ӿ��̵�
	@password_								varchar(20),
	@sid_									int,
	@listidxcloth_							int,
	@listidxcust_							int,
	@randserial_							varchar(20),
	@nResult_								int					OUTPUT
	WITH ENCRYPTION -- ���ν����� ��ȣȭ��.
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

	-- MT �����߿� ����.
	declare @RESULT_ERROR_CASHCOST_LACK			int				set @RESULT_ERROR_CASHCOST_LACK			= -22			--
	declare @RESULT_ERROR_GAMECOST_LACK			int				set @RESULT_ERROR_GAMECOST_LACK			= -24			--
	declare @RESULT_ERROR_ITEM_LACK				int				set @RESULT_ERROR_ITEM_LACK				= -23			--�������̺����ϴ�.
	declare @RESULT_ERROR_UPGRADE_FULL			int				set @RESULT_ERROR_UPGRADE_FULL			= -35			--���׷��̵尡 Ǯ�εǾ���.

	-- ��Ÿ����
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- �������ڵ��ã��
	declare @RESULT_ERROR_PARAMETER				int				set @RESULT_ERROR_PARAMETER				= -122			-- �Ķ���Ϳ���.
	declare @RESULT_ERROR_SESSION_ID_EXPIRE_LOGOUT	int			set @RESULT_ERROR_SESSION_ID_EXPIRE_LOGOUT	= -151		-- ������ ����Ǿ����ϴ�.
	declare @RESULT_ERROR_DIFFERENT_GRADE		int				set @RESULT_ERROR_DIFFERENT_GRADE		= -154			-- ����� �ٸ��ϴ�.
	declare @RESULT_ERROR_WEARING_NOT_UPGRADE	int				set @RESULT_ERROR_WEARING_NOT_UPGRADE	= -216		-- �������� ���� ���׷��̵� �Ұ����մϴ�.

	------------------------------------------------
	--	2-2. ���°�
	------------------------------------------------
	-- MT �����°�.
	declare @BLOCK_STATE_NO						int					set	@BLOCK_STATE_NO							= 0	-- �����¾ƴ�
	declare @BLOCK_STATE_YES					int					set	@BLOCK_STATE_YES						= 1	-- ������

	-- MT �ý��� üŷ
	declare @SYSCHECK_NON						int					set @SYSCHECK_NON							= 0
	declare @SYSCHECK_YES						int					set @SYSCHECK_YES							= 1

	-- MT status
	declare @EVOLVE_STATE_SUCCESS				int					set @EVOLVE_STATE_SUCCESS					= 1
	declare @EVOLVE_STATE_FAIL_ONLY				int					set @EVOLVE_STATE_FAIL_ONLY					= -1
	declare @EVOLVE_STATE_FAIL_EXPIRE			int					set @EVOLVE_STATE_FAIL_EXPIRE				= -2

	-- MT �����ۺ� �κ��з�
	declare @USERITEM_INVENKIND_WEAR			int 				set @USERITEM_INVENKIND_WEAR				= 1
	declare @USERITEM_INVENKIND_PIECE			int 				set @USERITEM_INVENKIND_PIECE				= 2
	declare @USERITEM_INVENKIND_CONSUME			int 				set @USERITEM_INVENKIND_CONSUME				= 3
	--declare @USERITEM_INVENKIND_NON			int 				set @USERITEM_INVENKIND_NON					= 0
	--declare @USERITEM_INVENKIND_INFO			int 				set @USERITEM_INVENKIND_INFO				= 60
	--declare @USERITEM_INVENKIND_DIRECT		int 				set @USERITEM_INVENKIND_DIRECT				= 40

	-- MT ������ ��з�
	declare @ITEM_MAINCATEGORY_WEARPART			int					set @ITEM_MAINCATEGORY_WEARPART 			= 1 	-- ������(1)
	declare @ITEM_MAINCATEGORY_PIECEPART		int					set @ITEM_MAINCATEGORY_PIECEPART			= 15 	-- ������(15)
	declare @ITEM_MAINCATEGORY_COMSUME			int					set @ITEM_MAINCATEGORY_COMSUME				= 40 	-- �Ҹ�ǰ(40)
	--declare @ITEM_MAINCATEGORY_CASHCOST		int					set @ITEM_MAINCATEGORY_CASHCOST 			= 50 	-- ĳ������(50)
	--declare @ITEM_MAINCATEGORY_STATICINFO		int					set @ITEM_MAINCATEGORY_STATICINFO 			= 500 	-- ��������(500)
	--declare @ITEM_MAINCATEGORY_LEVELUPREWARD	int					set @ITEM_MAINCATEGORY_LEVELUPREWARD		= 510 	-- ������ ����(510)

	-- MT ������ �Һз�
	--declare @ITEM_SUBCATEGORY_WEAR_HELMET		int					set @ITEM_SUBCATEGORY_WEAR_HELMET			= 1  -- ���(1)
	--declare @ITEM_SUBCATEGORY_WEAR_SHIRT		int					set @ITEM_SUBCATEGORY_WEAR_SHIRT			= 2  -- ����(2)
	--declare @ITEM_SUBCATEGORY_WEAR_PANTS		int					set @ITEM_SUBCATEGORY_WEAR_PANTS			= 3  -- ����(3)
	--declare @ITEM_SUBCATEGORY_WEAR_GLOVES		int					set @ITEM_SUBCATEGORY_WEAR_GLOVES			= 4  -- �尩(4)
	--declare @ITEM_SUBCATEGORY_WEAR_SHOES		int					set @ITEM_SUBCATEGORY_WEAR_SHOES			= 5  -- �Ź�(5)
	--declare @ITEM_SUBCATEGORY_WEAR_BAT		int					set @ITEM_SUBCATEGORY_WEAR_BAT				= 6  -- �����(6)
	--declare @ITEM_SUBCATEGORY_WEAR_BALL		int					set @ITEM_SUBCATEGORY_WEAR_BALL				= 7  -- �����(7)
	--declare @ITEM_SUBCATEGORY_WEAR_GOGGLE		int					set @ITEM_SUBCATEGORY_WEAR_GOGGLE			= 8  -- ���(8)
	--declare @ITEM_SUBCATEGORY_WEAR_WRISTBAND	int					set @ITEM_SUBCATEGORY_WEAR_WRISTBAND		= 9  -- �ո� �ƴ�(9)
	--declare @ITEM_SUBCATEGORY_WEAR_ELBOWPAD	int					set @ITEM_SUBCATEGORY_WEAR_ELBOWPAD			= 10 -- �Ȳ�ġ ��ȣ��(10)
	--declare @ITEM_SUBCATEGORY_WEAR_BELT		int					set @ITEM_SUBCATEGORY_WEAR_BELT				= 11 -- ��Ʈ(11)
	--declare @ITEM_SUBCATEGORY_WEAR_KNEEPAD	int					set @ITEM_SUBCATEGORY_WEAR_KNEEPAD			= 12 -- ���� ��ȣ��(12)
	--declare @ITEM_SUBCATEGORY_WEAR_SOCKS		int					set @ITEM_SUBCATEGORY_WEAR_SOCKS			= 13 -- �縻(13)
	--declare @ITEM_SUBCATEGORY_PIECE_HELMET	int					set @ITEM_SUBCATEGORY_PIECE_HELMET	    	= 15 -- ��� ����(15)
	--declare @ITEM_SUBCATEGORY_PIECE_SHIRT		int					set @ITEM_SUBCATEGORY_PIECE_SHIRT	    	= 16 -- ���� ����(16)
	--declare @ITEM_SUBCATEGORY_PIECE_PANTS		int					set @ITEM_SUBCATEGORY_PIECE_PANTS	    	= 17 -- ���� ����(17)
	--declare @ITEM_SUBCATEGORY_PIECE_GLOVES	int					set @ITEM_SUBCATEGORY_PIECE_GLOVES	    	= 18 -- �尩 ����(18)
	--declare @ITEM_SUBCATEGORY_PIECE_SHOES		int					set @ITEM_SUBCATEGORY_PIECE_SHOES	    	= 19 -- �Ź� ����(19)
	--declare @ITEM_SUBCATEGORY_PIECE_BAT		int					set @ITEM_SUBCATEGORY_PIECE_BAT		    	= 20 -- ����� ����(20)
	--declare @ITEM_SUBCATEGORY_PIECE_BALL		int					set @ITEM_SUBCATEGORY_PIECE_BALL			= 21 -- ����� ����(21)
	--declare @ITEM_SUBCATEGORY_PIECE_GOGGLE	int					set @ITEM_SUBCATEGORY_PIECE_GOGGLE	    	= 22 -- ��� ����(22)
	--declare @ITEM_SUBCATEGORY_PIECE_WRISTBAND	int					set @ITEM_SUBCATEGORY_PIECE_WRISTBAND   	= 23 -- �ո� �ƴ� ����(23)
	--declare @ITEM_SUBCATEGORY_PIECE_ELBOWPAD	int					set @ITEM_SUBCATEGORY_PIECE_ELBOWPAD		= 24 -- �Ȳ�ġ ��ȣ�� ����(24)
	--declare @ITEM_SUBCATEGORY_PIECE_BELT		int					set @ITEM_SUBCATEGORY_PIECE_BELT			= 25 -- ��Ʈ ����(25)
	--declare @ITEM_SUBCATEGORY_PIECE_KNEEPAD	int					set @ITEM_SUBCATEGORY_PIECE_KNEEPAD	    	= 26 -- ���� ��ȣ�� ����(26)
	--declare @ITEM_SUBCATEGORY_PIECE_SOCKS		int					set @ITEM_SUBCATEGORY_PIECE_SOCKS	    	= 27 -- �縻 ����(27)
	declare @ITEM_SUBCATEGORY_BOX_PIECE			int					set @ITEM_SUBCATEGORY_BOX_PIECE				= 40 -- ���� �����ڽ�(40)
	declare @ITEM_SUBCATEGORY_BOX_CLOTH			int					set @ITEM_SUBCATEGORY_BOX_CLOTH				= 41 -- �ǻ� �����ڽ�(41)
	declare @ITEM_SUBCATEGORY_BOX_ADVICE		int					set @ITEM_SUBCATEGORY_BOX_ADVICE			= 42 -- ���� ��Ű�� �ڽ�(42)
	--declare @ITEM_SUBCATEGORY_SCROLL_EVOLUTION	int				set @ITEM_SUBCATEGORY_SCROLL_EVOLUTION		= 45 -- �ռ��ʿ��ֹ���(45)
	declare @ITEM_SUBCATEGORY_SCROLL_COMMISSION	int					set @ITEM_SUBCATEGORY_SCROLL_COMMISSION		= 46 -- �������ֹ���(46)
	--declare @ITEM_SUBCATEGORY_NICKCHANGE		int					set @ITEM_SUBCATEGORY_NICKCHANGE			= 47 -- �г��Ӻ����(47)
	declare @ITEM_SUBCATEGORY_RANDOM_CASHCOST_BOX	int				set @ITEM_SUBCATEGORY_RANDOM_CASHCOST_BOX	= 48 -- �������̾�(48)
	--declare @ITEM_SUBCATEGORY_CASHCOST		int					set @ITEM_SUBCATEGORY_CASHCOST				= 50 -- ���̾�(50)
	--declare @ITEM_SUBCATEGORY_GAMECOST		int					set @ITEM_SUBCATEGORY_GAMECOST				= 60 -- ��(60)
	--declare @ITEM_SUBCATEGORY_STATICINFO		int					set @ITEM_SUBCATEGORY_STATICINFO			= 500 -- ��������(500)
	--declare @ITEM_SUBCATEGORY_LEVELUPREWARD	int					set @ITEM_SUBCATEGORY_LEVELUPREWARD			= 900 --������ ����(510)

	-- MT ������ ȹ����
	--declare @DEFINE_HOW_GET_FIRST				int					set @DEFINE_HOW_GET_FIRST					= 0		--�⺻
	--declare @DEFINE_HOW_GET_BUY				int					set @DEFINE_HOW_GET_BUY						= 1		--����
	--declare @DEFINE_HOW_GET_GIFT				int					set @DEFINE_HOW_GET_GIFT					= 5		--����
	--declare @DEFINE_HOW_GET_FREEANIRESTORE	int					set @DEFINE_HOW_GET_FREEANIRESTORE			= 17	--���ẹ��.
	--declare @DEFINE_HOW_GET_BOX_OPEN			int					set @DEFINE_HOW_GET_BOX_OPEN				= 20 	-- �ڽ��̱�.
	--declare @DEFINE_HOW_GET_LEVELUP			int 				set @DEFINE_HOW_GET_LEVELUP					= 21 	-- ������.
	--declare @DEFINE_HOW_GET_AUCTION_BUY		int 				set @DEFINE_HOW_GET_AUCTION_BUY				= 22 	-- ����� ����.
	declare @DEFINE_HOW_GET_COMBINATE			int 				set @DEFINE_HOW_GET_COMBINATE				= 23 	-- �������� ȹ��.
	declare @DEFINE_HOW_GET_EVOLUTION			int 				set @DEFINE_HOW_GET_EVOLUTION				= 24 	-- �ʿ��� ȹ��.

	--�����ֹ���.
	declare @ITEMCODE_COMBINATE_SCROLL			int 				set @ITEMCODE_COMBINATE_SCROLL				= 4500	-- ���� �ֹ���
	declare @ITEMCODE_EVOLVE_SCROLL				int 				set @ITEMCODE_EVOLVE_SCROLL					= 4501	-- �ʿ� �ֹ���

	-- ������ �⺻ listidx.
	declare @BASE_HELMET_LISTIDX				int 				set @BASE_HELMET_LISTIDX					= 1
	declare @BASE_SHIRT_LISTIDX					int 				set @BASE_SHIRT_LISTIDX						= 2
	declare @BASE_PANTS_LISTIDX					int 				set @BASE_PANTS_LISTIDX						= 3
	declare @BASE_GLOVES_LISTIDX				int 				set @BASE_GLOVES_LISTIDX					= 4
	declare @BASE_SHOES_LISTIDX					int 				set @BASE_SHOES_LISTIDX						= 5
	declare @BASE_BAT_LISTIDX					int 				set @BASE_BAT_LISTIDX						= 6
	declare @BASE_BALL_LISTIDX					int 				set @BASE_BALL_LISTIDX						= 7
	declare @BASE_GOGGLE_LISTIDX				int 				set @BASE_GOGGLE_LISTIDX					= 8
	declare @BASE_WRISTBAND_LISTIDX				int 				set @BASE_WRISTBAND_LISTIDX					= 9
	declare @BASE_ELBOWPAD_LISTIDX				int 				set @BASE_ELBOWPAD_LISTIDX					= 10
	declare @BASE_BELT_LISTIDX					int 				set @BASE_BELT_LISTIDX						= 11
	declare @BASE_KNEEPAD_LISTIDX				int 				set @BASE_KNEEPAD_LISTIDX					= 12
	declare @BASE_SOCKS_LISTIDX					int 				set @BASE_SOCKS_LISTIDX						= 13

	------------------------------------------------
	--	2-3. ���λ�� ����
	------------------------------------------------
	declare @comment				varchar(512)		set @comment			= ''
	declare @gameid					varchar(20)			set @gameid				= ''
	declare @cashcost				int					set @cashcost			= 0
	declare @gamecost				int					set @gamecost			= 0
	declare @sid					int					set @sid				= -1
	declare @blockstate				int					set @blockstate			= @BLOCK_STATE_YES
	declare @randserial				varchar(20)			set @randserial			= '-1'

	declare @itemcodecust			int					set @itemcodecust		= -1
	declare @cnt					int					set @cnt				= 0
	declare @itemcodecloth			int					set @itemcodecloth		= -1
	declare @itemcodenext			int					set @itemcodenext		= -1

	declare @evolvestate			int					set @evolvestate		= @EVOLVE_STATE_FAIL_EXPIRE
	declare @evolveitemcode			int					set @evolveitemcode		= -1
	declare @listidxcloth		 	int					set @listidxcloth		= -1
	declare @listidxcust			int					set @listidxcust		= -1

	declare @rand					int					set @rand				= 0
	declare @randsum				int					set @randsum			= 0

	-- (���Ӻ��� : ��������� �ε�������Ʈ)
	declare @helmetlistidx			int 				set @helmetlistidx 		= @BASE_HELMET_LISTIDX
	declare @shirtlistidx			int 				set @shirtlistidx		= @BASE_SHIRT_LISTIDX
	declare @pantslistidx			int 				set @pantslistidx		= @BASE_PANTS_LISTIDX
	declare @gloveslistidx			int 				set @gloveslistidx		= @BASE_GLOVES_LISTIDX
	declare @shoeslistidx			int 				set @shoeslistidx		= @BASE_SHOES_LISTIDX
	declare @batlistidx				int 				set @batlistidx			= @BASE_BAT_LISTIDX
	declare @balllistidx			int 				set @balllistidx		= @BASE_BALL_LISTIDX
	declare @gogglelistidx			int 				set @gogglelistidx		= @BASE_GOGGLE_LISTIDX
	declare @wristbandlistidx		int 				set @wristbandlistidx	= @BASE_WRISTBAND_LISTIDX
	declare @elbowpadlistidx		int 				set @elbowpadlistidx	= @BASE_ELBOWPAD_LISTIDX
	declare @beltlistidx			int 				set @beltlistidx		= @BASE_BELT_LISTIDX
	declare @kneepadlistidx			int 				set @kneepadlistidx		= @BASE_KNEEPAD_LISTIDX
	declare @sockslistidx			int 				set @sockslistidx		= @BASE_SOCKS_LISTIDX


	DECLARE @tTempTable TABLE(
		listidx		int
	);

Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	set @comment = 'ERROR �������� ������ �� �����ϴ�.(-1)'
	--select 'DEBUG 1 �Է�����', @gameid_ gameid_, @password_ password_, @sid_ sid_, @listidxcloth_ listidxcloth_, @listidxcust_ listidxcust_, @randserial_ randserial_

	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	select
		@gameid 			= gameid,			@blockstate		= blockstate,		@sid			= sid,
		@cashcost			= cashcost,			@gamecost		= gamecost,
		@listidxcloth		= templistidxcloth,
		@listidxcust		= templistidxcust,
		@evolvestate 		= tempevolvestate,
		@evolveitemcode		= tempevolveitemcode,
		@helmetlistidx 		= helmetlistidx, 	@shirtlistidx 	= shirtlistidx, 	@pantslistidx 	= pantslistidx, @gloveslistidx 	= gloveslistidx,
		@shoeslistidx 		= shoeslistidx, 	@batlistidx 	= batlistidx, 		@balllistidx 	= balllistidx, 	@gogglelistidx 	= gogglelistidx,
		@wristbandlistidx	= wristbandlistidx,	@elbowpadlistidx= elbowpadlistidx, 	@beltlistidx 	= beltlistidx, 	@kneepadlistidx = kneepadlistidx, 	@sockslistidx = sockslistidx,
		@randserial 		= randserial
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 3-2 ��������', @gameid gameid, @blockstate blockstate, @sid sid, @cashcost cashcost, @gamecost gamecost, @randserial randserial, @evolvestate evolvestate, @listidxcloth listidxcloth

	if(@gameid != '' and @listidxcust_ != -1 and @listidxcloth_ != -1 )
		begin
			------------------------------------------------
			-- ����������(tUserItem)
			------------------------------------------------
			select @itemcodecust = itemcode, @cnt = cnt from dbo.tUserItem where gameid = @gameid and listidx = @listidxcust_
			--select 'DEBUG 3-4������(�ֹ���)', @listidxcust_ listidxcust_, @itemcodecust itemcodecust, @cnt cnt

			select @itemcodecloth = itemcode from dbo.tUserItem where gameid = @gameid and listidx = @listidxcloth_
			--select 'DEBUG 3-5������(�ǻ�)', @listidxcloth_ listidxcloth_, @itemcodecloth itemcodecloth

			select @itemcodenext = param6 from dbo.tItemInfo where itemcode = @itemcodecloth and category = @ITEM_MAINCATEGORY_WEARPART
			--select 'DEBUG 3-5������(�ǻ�) > �ʿ���.', @itemcodenext itemcodenext
		end

	------------------------------------------------
	-- 3-3. �� ���Ǻ� �б�
	------------------------------------------------
	if( @gameid = '' )
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR ���̵� �������� �ʴ´�.'
			--select 'DEBUG ' + @comment
		END
	else if ( @blockstate = @BLOCK_STATE_YES )
		BEGIN
			-- �������ΰ�?
			set @nResult_ 	= @RESULT_ERROR_BLOCK_USER
			set @comment 	= '��ó���� ���̵��Դϴ�.'
			--select 'DEBUG ', @comment
		END
	else if ( @sid_ != @sid )
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_SESSION_ID_EXPIRE_LOGOUT
			set @comment 	= 'ERROR ������ ���� �Ǿ����ϴ�. (�α׾ƿ� �����ּ���.)'
			--select 'DEBUG ' + @comment
		END
	else if ( @randserial_ = @randserial )
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS �ʿ��� �õ��մϴ�.(�ߺ�)'

			insert into @tTempTable( listidx ) values( @listidxcloth )
			insert into @tTempTable( listidx ) values( @listidxcust  )
		END
	else if ( @itemcodecust != @ITEMCODE_EVOLVE_SCROLL )
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_ITEMCODE
			set @comment = 'ERROR �������� ã�� ���߽��ϴ�.(1-1�ֹ���)'
		END
	else if ( @cnt <= 0 )
		BEGIN
			set @nResult_ = @RESULT_ERROR_ITEM_LACK
			set @comment = 'ERROR �������� �����մϴ�.(1-2�ֹ���)'
		END
	else if ( @itemcodecloth = -1 )
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_ITEMCODE
			set @comment = 'ERROR �������� ã�� ���߽��ϴ�.(2-1�ǻ�)'
		END
	else if ( @itemcodenext = -1 )
		BEGIN
			set @nResult_ = @RESULT_ERROR_UPGRADE_FULL
			set @comment = 'ERROR ���׷��̵带 �� �̻� �� �� �����ϴ�.'
		END
	else if (
		@helmetlistidx 		= @listidxcloth_ 	or	@shirtlistidx 	= @listidxcloth_	or	@pantslistidx 	= @listidxcloth_	or @gloveslistidx 	= @listidxcloth_	or
		@shoeslistidx 		= @listidxcloth_	or 	@batlistidx 	= @listidxcloth_	or	@balllistidx 	= @listidxcloth_	or @gogglelistidx 	= @listidxcloth_	or
		@wristbandlistidx	= @listidxcloth_	or	@elbowpadlistidx= @listidxcloth_	or	@beltlistidx 	= @listidxcloth_	or @kneepadlistidx  = @listidxcloth_	or 	@sockslistidx = @listidxcloth_
	)
		BEGIN
			set @nResult_ = @RESULT_ERROR_WEARING_NOT_UPGRADE
			set @comment = 'ERROR �������� ���� ���׷��̵尡 �Ұ����մϴ�.'
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS �ʿ��� �õ��մϴ�.'
			--select 'DEBUG ' + @comment

			------------------------------------------------
			-- 1. ���� Ȯ�� Ȯ��.
			--   25% -> ����.
			--			�ֹ��� ����, �ǻ� ����
			--   30% -> ����(�ı�).
			--			�ֹ��� ����, �ǻ� ����
			--   45% -> ����(����).
			--			�ֹ��� ����, �ǻ� ����
			------------------------------------------------
			set @randsum 	= 100
			set @rand 		= dbo.fnu_GetRandom(0, @randsum)
			--select 'DEBUG ', @randsum randsum, @rand rand
			if( @rand < 25 )
				begin
					--select 'DEBUG 25% -> ����.'
					set @evolvestate	= @EVOLVE_STATE_SUCCESS
					set @evolveitemcode	= @itemcodenext
				end
			else if( @rand < (25+30) )
				begin
					--select 'DEBUG 30% -> ����(�ı��Ҹ�).'
					set @evolvestate	= @EVOLVE_STATE_FAIL_EXPIRE
					set @evolveitemcode	= -1
				end
			else
				begin
					--select 'DEBUG 45% -> ����(��������).'
					set @evolvestate 	= @EVOLVE_STATE_FAIL_ONLY
					set @evolveitemcode = @itemcodecloth
				end

			------------------------------------------------
			-- 1-2. ������ �����ϱ�.
			------------------------------------------------
			if( @evolvestate = @EVOLVE_STATE_SUCCESS )
				begin
					--select 'DEBUG �ǻ��ʿ�.'
					update dbo.tUserItem
						set
							itemcode 	= @evolveitemcode,
							gethow 		= @DEFINE_HOW_GET_EVOLUTION
					where gameid = @gameid and listidx = @listidxcloth_
				end
			else if( @evolvestate = @EVOLVE_STATE_FAIL_EXPIRE )
				begin
					--select 'DEBUG �ǻ����.'
					delete from dbo.tUserItem
					where gameid = @gameid and listidx = @listidxcloth_
				end

			------------------------------------------------
			-- �ڽ�����.
			------------------------------------------------
			----select 'DEBUG ��������', @listidxcust_ listidxcust_
			update dbo.tUserItem set cnt = cnt - 1 where gameid = @gameid and listidx = @listidxcust_


			------------------------------------------------
			-- 1-4. ��·ΰ�.
			------------------------------------------------
			insert into @tTempTable( listidx ) values( @listidxcust_    )
			insert into @tTempTable( listidx ) values( @listidxcloth_   )

			------------------------------------------------
			--
			------------------------------------------------
			exec spu_DayLogInfoStatic 26, 1				-- �� �ʿ�.

			------------------------------------------------
			-- ��������
			------------------------------------------------
			update dbo.tUserMaster
				set
					templistidxcust	= @listidxcust_,
					templistidxcloth= @listidxcloth_,
					tempevolvestate	= @evolvestate,
					tempevolveitemcode= @evolveitemcode,
					randserial 		= @randserial_
			from dbo.tUserMaster
			where gameid = @gameid_
		END


	--------------------------------------------------------------
	-- �������.s
	--------------------------------------------------------------
	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost,
		   @evolvestate evolvestate, @evolveitemcode evolveitemcode

	if(@nResult_ = @RESULT_SUCCESS)
		BEGIN
			--------------------------------------------------------------
			-- ���� ���� ������ ���� > ���� ȹ���� �͸� ����(������ �ϰ� ���� ������ Ŭ����� �����͸� �������� ������)
			--------------------------------------------------------------
			select * from dbo.tUserItem
			where gameid = @gameid_ and listidx in ( select listidx from @tTempTable )

		END

	------------------------------------------------
	--	4-2. ��������
	------------------------------------------------
	set nocount off
End

