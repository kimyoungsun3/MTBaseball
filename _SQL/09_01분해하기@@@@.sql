/*
-- ������Ű��.
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 28, 7701, -1	-- ���� ��Ű�� �ڽ�(4200)
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 28, 7702, -1

-- ���� �����ڽ�.
-- select * from dbo.tUserItem where gameid = 'mtxxxx3' and invenkind = 2
-- delete from dbo.tUserItem where gameid = 'mtxxxx3' and invenkind = 2
--select * from dbo.tItemInfoPieceBox  order by getpercent1000 desc, grade asc
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 18, 7711, -1	-- �� ���� �����ڽ�(4000)
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 18, 7712, -1
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 30, 7713, -1	-- �� ���� �����ڽ�(4001)
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 30, 7714, -1
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 20, 7715, -1	-- �� ���� �����ڽ�(4002)
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 20, 7716, -1
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 21, 7717, -1	-- �� ���� �����ڽ�(4003)
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 21, 7718, -1
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 22, 7719, -1	-- ƼŸ�� ���� �����ڽ�(4004)
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 22, 7720, -1

-- �ǻ� �����ڽ�.
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 23, 7721, -1	-- �� �ǻ� �����ڽ�(4100)
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 23, 7722, -1
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 24, 7723, -1	-- �� �ǻ� �����ڽ�(4101)
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 24, 7724, -1
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 25, 7725, -1	-- �� �ǻ� �����ڽ�(4102)
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 25, 7726, -1
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 26, 7727, -1	-- �� �ǻ� �����ڽ�(4103)
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 26, 7728, -1
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 27, 7729, -1	-- ƼŸ�� �ǻ� �����ڽ�(4104)
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 27, 7720, -1

-- ĳ���ڽ�.
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 17, 7731, -1	-- ���� ���̾� �ڽ�(4800)
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 17, 7732, -1
*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_ItemOpen', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_ItemOpen;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_ItemOpen
	@gameid_								varchar(20),					-- ���Ӿ��̵�
	@password_								varchar(20),
	@sid_									int,
	@listidx_								int,
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

	-- ��Ÿ����
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- �������ڵ��ã��
	declare @RESULT_ERROR_PARAMETER				int				set @RESULT_ERROR_PARAMETER				= -122			-- �Ķ���Ϳ���.
	declare @RESULT_ERROR_SESSION_ID_EXPIRE_LOGOUT	int			set @RESULT_ERROR_SESSION_ID_EXPIRE_LOGOUT	= -151		-- ������ ����Ǿ����ϴ�.

	------------------------------------------------
	--	2-2. ���°�
	------------------------------------------------
	-- MT �����°�.
	declare @BLOCK_STATE_NO						int					set	@BLOCK_STATE_NO							= 0	-- �����¾ƴ�
	declare @BLOCK_STATE_YES					int					set	@BLOCK_STATE_YES						= 1	-- ������

	-- MT �ý��� üŷ
	declare @SYSCHECK_NON						int					set @SYSCHECK_NON							= 0
	declare @SYSCHECK_YES						int					set @SYSCHECK_YES							= 1

	-- MT box open status
	declare @BOX_OPEN_STATE_SUCCESS				int					set @BOX_OPEN_STATE_SUCCESS					= 1
	declare @BOX_OPEN_STATE_FAIL				int					set @BOX_OPEN_STATE_FAIL					= -1

	-- MT �����ۺ� �κ��з�
	declare @USERITEM_INVENKIND_WEAR			int 				set @USERITEM_INVENKIND_WEAR				= 1
	declare @USERITEM_INVENKIND_PIECE			int 				set @USERITEM_INVENKIND_PIECE				= 2
	declare @USERITEM_INVENKIND_CONSUME			int 				set @USERITEM_INVENKIND_CONSUME				= 3
	declare @USERITEM_INVENKIND_NON				int 				set @USERITEM_INVENKIND_NON					= 0
	declare @USERITEM_INVENKIND_INFO			int 				set @USERITEM_INVENKIND_INFO				= 60
	declare @USERITEM_INVENKIND_DIRECT			int 				set @USERITEM_INVENKIND_DIRECT				= 40

	-- MT ������ ��з�
	declare @ITEM_MAINCATEGORY_WEARPART			int					set @ITEM_MAINCATEGORY_WEARPART 			= 1 	-- ������(1)
	--declare @ITEM_MAINCATEGORY_PIECEPART		int					set @ITEM_MAINCATEGORY_PIECEPART			= 15 	-- ������(15)
	--declare @ITEM_MAINCATEGORY_COMSUME		int					set @ITEM_MAINCATEGORY_COMSUME				= 40 	-- �Ҹ�ǰ(40)
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
	declare @DEFINE_HOW_GET_FIRST				int					set @DEFINE_HOW_GET_FIRST					= 0		--�⺻
	declare @DEFINE_HOW_GET_BUY					int					set @DEFINE_HOW_GET_BUY						= 1		--����
	declare @DEFINE_HOW_GET_GIFT				int					set @DEFINE_HOW_GET_GIFT					= 5		--����
	declare @DEFINE_HOW_GET_FREEANIRESTORE		int					set @DEFINE_HOW_GET_FREEANIRESTORE			= 17	--���ẹ��.
	declare @DEFINE_HOW_GET_BOX_OPEN			int					set @DEFINE_HOW_GET_BOX_OPEN				= 20 	-- �ڽ��̱�.
	declare @DEFINE_HOW_GET_LEVELUP				int 				set @DEFINE_HOW_GET_LEVELUP					= 21 	-- ������.
	declare @DEFINE_HOW_GET_AUCTION_BUY			int 				set @DEFINE_HOW_GET_AUCTION_BUY				= 22 	-- ����� ����.
	declare @DEFINE_HOW_GET_COMBINATE			int 				set @DEFINE_HOW_GET_COMBINATE				= 23 	-- �������� ȹ��.
	declare @DEFINE_HOW_GET_EVOLUTION			int 				set @DEFINE_HOW_GET_EVOLUTION				= 24 	-- �ʿ��� ȹ��.

	-- ������Ű�� �ڽ� �����۵�.
	declare @ITEMCODE_CHEER_VOICE				int 				set @ITEMCODE_CHEER_VOICE					= 4600 	-- ���� �ڽ����� ��������.
	declare @ITEMCODE_COACH_ADVICE				int 				set @ITEMCODE_COACH_ADVICE					= 4601 	-- ���� �ڽ����� ��������.
	declare @ITEMCODE_DIRECTOR_ADVICE			int 				set @ITEMCODE_DIRECTOR_ADVICE				= 4602 	--

	-- ĳ���ڽ�.
	declare @CASHCOST_BOX_STEP1					int					set @CASHCOST_BOX_STEP1						= 40
	declare @CASHCOST_BOX_STEP2					int					set @CASHCOST_BOX_STEP2						= 40+30
	declare @CASHCOST_BOX_STEP3					int					set @CASHCOST_BOX_STEP3						= 40+30+15
	declare @CASHCOST_BOX_STEP4					int					set @CASHCOST_BOX_STEP4						= 40+30+15+10
	declare @CASHCOST_BOX_STEP5					int					set @CASHCOST_BOX_STEP5						= 40+30+15+10+3
	declare @CASHCOST_BOX_STEP6					int					set @CASHCOST_BOX_STEP6						= 40+30+15+10+3+2
	declare @CASHCOST_BOX_STEP_MAX				int					set @CASHCOST_BOX_STEP_MAX					= @CASHCOST_BOX_STEP6
	declare @CASHCOST_BOX_STEP1_VALUE			int					set @CASHCOST_BOX_STEP1_VALUE				=  5000
	declare @CASHCOST_BOX_STEP2_VALUE			int					set @CASHCOST_BOX_STEP2_VALUE				= 10000
	declare @CASHCOST_BOX_STEP3_VALUE			int					set @CASHCOST_BOX_STEP3_VALUE				= 15000
	declare @CASHCOST_BOX_STEP4_VALUE			int					set @CASHCOST_BOX_STEP4_VALUE				= 20000
	declare @CASHCOST_BOX_STEP5_VALUE			int					set @CASHCOST_BOX_STEP5_VALUE				= 25000
	declare @CASHCOST_BOX_STEP6_VALUE			int					set @CASHCOST_BOX_STEP6_VALUE				= 30000

	-- �ǻ�ڽ� ������ ����.
	declare @BOX_OPEN_MODE_ADVICE				int					set @BOX_OPEN_MODE_ADVICE					= @ITEM_SUBCATEGORY_BOX_ADVICE
	declare @BOX_OPEN_MODE_PIECE				int					set @BOX_OPEN_MODE_PIECE					= @ITEM_SUBCATEGORY_BOX_PIECE
	declare @BOX_OPEN_MODE_CLOTH				int					set @BOX_OPEN_MODE_CLOTH					= @ITEM_SUBCATEGORY_BOX_CLOTH
	declare @BOX_OPEN_MODE_CASHCOST				int					set @BOX_OPEN_MODE_CASHCOST					= @ITEM_SUBCATEGORY_RANDOM_CASHCOST_BOX

	-- �����ڽ� �ƽ���
	declare @BOX_PIECE_MAX_VALUE				int					set @BOX_PIECE_MAX_VALUE					= 100100

	------------------------------------------------
	--	2-3. ���λ�� ����
	------------------------------------------------
	declare @comment				varchar(512)		set @comment			= ''
	declare @gameid					varchar(20)			set @gameid				= ''
	declare @cashcost				int					set @cashcost			= 0
	declare @gamecost				int					set @gamecost			= 0
	declare @sid					int					set @sid				= -1
	declare @blockstate				int					set @blockstate			= @BLOCK_STATE_YES

	declare @tempboxopenmode		int					set @tempboxopenmode	= -1
	declare @tempopenstate			int					set @tempopenstate		= @BOX_OPEN_STATE_SUCCESS
	declare @temppluscashcost		int					set @temppluscashcost	= 0
	declare @templistidx		 	int					set @templistidx		= -1
	declare @templistidx2		 	int					set @templistidx2		= -1
	declare @templistidx3		 	int					set @templistidx3		= -1
	declare @templistidx4		 	int					set @templistidx4		= -1

	declare @itemcode				int					set @itemcode			= -1
	declare @cnt					int					set @cnt				= 0
	declare @randserial				varchar(20)			set @randserial			= '-1'
	declare @subcategory			int					set @subcategory		= -1
	declare @grade					int					set @grade				= -1

	declare	@invenkind				int					set @invenkind			= -1
	declare @rand					int					set @rand				= 0
	declare @randsum				int					set @randsum			= 0
	declare @itemcodenew			int					set @itemcodenew		= 0
	declare @subcategorynew			int					set @subcategorynew		= 0
	declare @listidxcust		 	int					set @listidxcust		= -1
	declare @listidxnew			 	int					set @listidxnew			= -1
	declare @listidxrtn2 			int					set @listidxrtn2		= -1
	declare @listidxrtn3 			int					set @listidxrtn3		= -1
	declare @listidxrtn4 			int					set @listidxrtn4		= -1

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
	--select 'DEBUG 1 �Է�����', @gameid_ gameid_, @password_ password_, @sid_ sid_, @listidx_ listidx_, @randserial_ randserial_

	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	select
		@gameid 		= gameid,			@blockstate		= blockstate,		@sid			= sid,
		@cashcost		= cashcost,			@gamecost		= gamecost,
		@tempboxopenmode= tempboxopenmode,	@temppluscashcost= temppluscashcost,@tempopenstate	= tempopenstate,
		@templistidx	= templistidx, 		@templistidx2	= templistidx2,		@templistidx3	= templistidx3,		@templistidx4	= templistidx4,
		@randserial 	= randserial
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 3-2 ��������', @gameid gameid, @blockstate blockstate, @sid sid, @cashcost cashcost, @gamecost gamecost, @randserial randserial, @tempboxopenmode tempboxopenmode, @temppluscashcost temppluscashcost, @tempopenstate tempopenstate, @templistidx templistidx, @templistidx2 templistidx2, @templistidx3 templistidx3, @templistidx4 templistidx4



	if(@gameid != '')
		begin
			------------------------------------------------
			-- ����������(tUserItem)
			------------------------------------------------
			select
				@itemcode 	= itemcode,
				@cnt 		= cnt
			from dbo.tUserItem
			where gameid = @gameid and listidx = @listidx_
			--select 'DEBUG ������', @listidx_ listidx_, @itemcode itemcode, @cnt cnt

			if( @itemcode != -1 )
				begin
					------------------------------------------------
					--  ������(tItemInfo) > ����
					------------------------------------------------
					select
						@subcategory 	= subcategory,
						@grade			= grade
					from dbo.tItemInfo
					where itemcode = @itemcode
					--select 'DEBUG ������.', @itemcode itemcode, @subcategory subcategory, @grade grade
				end
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
	else if ( @itemcode = -1 )
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_ITEMCODE
			set @comment = 'ERROR �������� ã�� ���߽��ϴ�.(1)'
		END
	else if ( @subcategory not in (@ITEM_SUBCATEGORY_BOX_PIECE, @ITEM_SUBCATEGORY_BOX_CLOTH, @ITEM_SUBCATEGORY_BOX_ADVICE, @ITEM_SUBCATEGORY_RANDOM_CASHCOST_BOX))
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_ITEMCODE
			set @comment = 'ERROR �������� ã�� ���߽��ϴ�.(2)'
		END
	else if ( @randserial_ = @randserial )
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS �ڽ��� �����߽��ϴ�.(�ߺ�)'

			insert into @tTempTable( listidx ) values( @templistidx )
			insert into @tTempTable( listidx ) values( @templistidx2 )
			insert into @tTempTable( listidx ) values( @templistidx3 )
			insert into @tTempTable( listidx ) values( @templistidx4 )

		END
	else if ( @cnt <= 0 )
		BEGIN
			set @nResult_ = @RESULT_ERROR_ITEM_LACK
			set @comment = 'ERROR �������� �����մϴ�.'
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS �ڽ��� �����߽��ϴ�.'
			--select 'DEBUG ' + @comment

			if( @subcategory = @ITEM_SUBCATEGORY_BOX_ADVICE )
				begin
					--select 'DEBUG 1 ������Ű���ڽ� ����'
					set @tempboxopenmode	= @BOX_OPEN_MODE_ADVICE
					------------------------------------------------
					-- 1-1. ����ڽ� ���� Ȯ�� Ȯ��.
					--    7% -> ��ġ�� ���� �ֹ���(4601)
					--    3% -> ������ ���� �ֹ���(4602)
					--   90% -> ��.
					------------------------------------------------
					set @randsum 	= 100
					set @rand 		= dbo.fnu_GetRandom(0, @randsum)
					--select 'DEBUG ', @randsum randsum, @rand rand
					if( @rand < 7 )
						begin
							--select 'DEBUG ��ġ�� ����ȹ��'
							set @itemcodenew 	= @ITEMCODE_COACH_ADVICE
							set @tempopenstate	= @BOX_OPEN_STATE_SUCCESS
						end
					else if( @rand < (7+3) )
						begin
							--select 'DEBUG ������ ����ȹ��'
							set @itemcodenew 	= @ITEMCODE_DIRECTOR_ADVICE
							set @tempopenstate	= @BOX_OPEN_STATE_SUCCESS
						end
					else
						begin
							--select 'DEBUG ��'
							set @itemcodenew 	= -1
							set @tempopenstate 	= @BOX_OPEN_STATE_FAIL
						end

					------------------------------------------------
					-- 1-2. ������ �����ϱ�.
					------------------------------------------------
					if( @itemcodenew != -1 )
						begin
							set @subcategorynew 	= @ITEM_SUBCATEGORY_SCROLL_COMMISSION
							set @invenkind 			= dbo.fnu_GetInvenFromSubCategory(@subcategorynew)
							--select 'DEBUG ', @invenkind invenkind

							exec dbo.spu_ToUserItem @gameid_, @invenkind, @subcategorynew, @itemcodenew, 1, @DEFINE_HOW_GET_BOX_OPEN, @randserial_, @nResult2_ = @listidxrtn2 OUTPUT
							--select 'DEBUG ����������', @gameid_ gameid_, @invenkind invenkind, @subcategorynew subcategorynew
						end
					--select 'DEBUG ', @randsum randsum, @rand rand, @itemcodenew itemcodenew, @subcategorynew subcategorynew, @tempopenstate tempopenstate, @listidxrtn2 listidxrtn2


					------------------------------------------------
					-- 1-4. �ڽ�����.
					------------------------------------------------
					insert into @tTempTable( listidx ) values( @listidx_    )
					insert into @tTempTable( listidx ) values( @listidxrtn2 )

				end
			else if( @subcategory = @ITEM_SUBCATEGORY_BOX_PIECE )
				begin
					--select 'DEBUG �����ڽ� ����'
					set @tempboxopenmode	= @BOX_OPEN_MODE_PIECE
					------------------------------------------------
					-- 1-1. �����ڽ� ���� > ������ Ȯ���� ����.
					------------------------------------------------
					set @tempopenstate		= @BOX_OPEN_STATE_SUCCESS
					set @randsum 	= @BOX_PIECE_MAX_VALUE
					set @rand 		= dbo.fnu_GetRandom(0, @randsum)
					--select 'DEBUG ', @randsum randsum, @rand rand


					select top 1 @itemcodenew = itemcode, @subcategorynew = subcategory from dbo.tItemInfoPieceBox
					where grade = @grade and getpercent1000 >= ( @rand )
					order by getpercent1000 asc
					--select 'DEBUG �ǻ�', @itemcodenew itemcodenew, @subcategorynew subcategorynew, @grade grade


					------------------------------------------------
					-- 1-2. ������ �����ϱ�.
					------------------------------------------------
					set @invenkind 	= dbo.fnu_GetInvenFromSubCategory(@subcategorynew)
					--select 'DEBUG ', @invenkind invenkind

					exec dbo.spu_ToUserItem @gameid_, @invenkind, @subcategorynew, @itemcodenew, 1, @DEFINE_HOW_GET_BOX_OPEN, @randserial_, @nResult2_ = @listidxrtn2 OUTPUT
					--select 'DEBUG ����������', @gameid_ gameid_, @invenkind invenkind, @subcategorynew subcategorynew, @itemcodenew itemcodenew, @listidxrtn2 listidxrtn2

					------------------------------------------------
					-- 1-4. �ڽ�����.
					------------------------------------------------
					insert into @tTempTable( listidx ) values( @listidx_    )
					insert into @tTempTable( listidx ) values( @listidxrtn2 )
				end
			else if( @subcategory = @ITEM_SUBCATEGORY_BOX_CLOTH )
				begin
					--select 'DEBUG �ǻ�ڽ� ����'
					set @tempboxopenmode	= @BOX_OPEN_MODE_CLOTH

					------------------------------------------------
					-- 1-1. �ǻ�ڽ� ���� > ��� ��ġ.
					------------------------------------------------
					set @tempopenstate		= @BOX_OPEN_STATE_SUCCESS

					select top 1 @itemcodenew = itemcode, @subcategorynew = subcategory from dbo.tItemInfo
					where category = @ITEM_MAINCATEGORY_WEARPART and grade = @grade
					order by newid()
					--select 'DEBUG �ǻ�', @itemcodenew itemcodenew, @subcategorynew subcategorynew, @grade grade


					------------------------------------------------
					-- 1-2. ������ �����ϱ�.
					------------------------------------------------
					set @invenkind 	= dbo.fnu_GetInvenFromSubCategory(@subcategorynew)
					--select 'DEBUG ', @invenkind invenkind

					exec dbo.spu_ToUserItem @gameid_, @invenkind, @subcategorynew, @itemcodenew, 1, @DEFINE_HOW_GET_BOX_OPEN, @randserial_, @nResult2_ = @listidxrtn2 OUTPUT
					--select 'DEBUG ����������', @gameid_ gameid_, @invenkind invenkind, @subcategorynew subcategorynew, @itemcodenew itemcodenew, @listidxrtn2 listidxrtn2

					------------------------------------------------
					-- 1-4. �ڽ�����.
					------------------------------------------------
					insert into @tTempTable( listidx ) values( @listidx_    )
					insert into @tTempTable( listidx ) values( @listidxrtn2 )
				end
			else if( @subcategory = @ITEM_SUBCATEGORY_RANDOM_CASHCOST_BOX )
				begin
					--select 'DEBUG ĳ���ڽ� ����'
					set @tempboxopenmode	= @BOX_OPEN_MODE_CASHCOST
					------------------------------------------------
				    --1. ��ġ�� ����, ������ ����, ������ �Ҹ� 1�徿
				    --2.  5,000	(40%)
				    --   10,000	(30%)
				    --   15,000	(15%)
				    --   20,000	(10%)
				    --   25,000	( 3%)
				    --   30,000	( 2%)
					------------------------------------------------
					set @rand 		= dbo.fnu_GetRandom(0, @CASHCOST_BOX_STEP_MAX)
					--select 'DEBUG ', @CASHCOST_BOX_STEP_MAX CASHCOST_BOX_STEP_MAX, @rand rand
					if( @rand < @CASHCOST_BOX_STEP1 )
						begin
							set @temppluscashcost 	= @CASHCOST_BOX_STEP1_VALUE
							--select 'DEBUG step1', @temppluscashcost temppluscashcost
						end
					else if( @rand < @CASHCOST_BOX_STEP2 )
						begin
							set @temppluscashcost 	= @CASHCOST_BOX_STEP2_VALUE
							--select 'DEBUG step2', @temppluscashcost temppluscashcost
						end
					else if( @rand < @CASHCOST_BOX_STEP3 )
						begin
							set @temppluscashcost 	= @CASHCOST_BOX_STEP3_VALUE
							--select 'DEBUG step3', @temppluscashcost temppluscashcost
						end
					else if( @rand < @CASHCOST_BOX_STEP4 )
						begin
							set @temppluscashcost 	= @CASHCOST_BOX_STEP4_VALUE
							--select 'DEBUG step4', @temppluscashcost temppluscashcost
						end
					else if( @rand < @CASHCOST_BOX_STEP5 )
						begin
							set @temppluscashcost 	= @CASHCOST_BOX_STEP5_VALUE
							--select 'DEBUG step5', @temppluscashcost temppluscashcost
						end
					else
						begin
							set @temppluscashcost 	= @CASHCOST_BOX_STEP6_VALUE
							--select 'DEBUG step6', @temppluscashcost temppluscashcost
						end
					--select 'DEBUG ����(��)', @cashcost cashcost, @temppluscashcost temppluscashcost
					set @cashcost = @cashcost + @temppluscashcost
					--select 'DEBUG ����(��)', @cashcost cashcost

					exec dbo.spu_ToUserItem @gameid_, @USERITEM_INVENKIND_CONSUME, @ITEM_SUBCATEGORY_SCROLL_COMMISSION, @ITEMCODE_CHEER_VOICE, 1, @DEFINE_HOW_GET_BOX_OPEN, @randserial_, @nResult2_ = @listidxrtn2 OUTPUT
					exec dbo.spu_ToUserItem @gameid_, @USERITEM_INVENKIND_CONSUME, @ITEM_SUBCATEGORY_SCROLL_COMMISSION, @ITEMCODE_COACH_ADVICE, 1, @DEFINE_HOW_GET_BOX_OPEN, @randserial_, @nResult2_ = @listidxrtn3 OUTPUT
					exec dbo.spu_ToUserItem @gameid_, @USERITEM_INVENKIND_CONSUME, @ITEM_SUBCATEGORY_SCROLL_COMMISSION, @ITEMCODE_DIRECTOR_ADVICE, 1, @DEFINE_HOW_GET_BOX_OPEN, @randserial_, @nResult2_ = @listidxrtn4 OUTPUT

					insert into @tTempTable( listidx ) values( @listidx_    )
					insert into @tTempTable( listidx ) values( @listidxrtn2 )
					insert into @tTempTable( listidx ) values( @listidxrtn3 )
					insert into @tTempTable( listidx ) values( @listidxrtn4 )

				end

			------------------------------------------------
			-- �ڽ�����.
			------------------------------------------------
			--select 'DEBUG ��������', @listidx_ listidx_
			update dbo.tUserItem
				set
					cnt = cnt - 1
			where gameid = @gameid and listidx = @listidx_

			------------------------------------------------
			-- ��������
			------------------------------------------------
			update dbo.tUserMaster
				set
					cashcost		= @cashcost,		gamecost 		= @gamecost,
					tempboxopenmode	= @tempboxopenmode,	temppluscashcost= @temppluscashcost,	tempopenstate	= @tempopenstate,
					templistidx		= @listidx_,
					templistidx2	= @listidxrtn2,		templistidx3	= @listidxrtn3,			templistidx4	= @listidxrtn4,
					randserial 		= @randserial_
			from dbo.tUserMaster
			where gameid = @gameid_
		END


	--------------------------------------------------------------
	-- �������.
	--------------------------------------------------------------
	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost,
		   @tempboxopenmode boxopenmode, @tempopenstate openstate, @temppluscashcost pluscashcost

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

