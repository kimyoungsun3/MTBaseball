---------------------------------------------------------------
/*
set @str = @gameid + '%'
select a.idx idx2, gameid, giftkind, message, gaindate, giftid, giftdate, b.*
from (select top 100 * from dbo.tGiftList where giftkind in (1, 2) and gameid = @gameid_ order by idx desc) a
	LEFT JOIN
	dbo.tItemInfo b
	ON a.itemcode = b.itemcode
order by idx2 desc

-- update dbo.tUserMaster set sid = 333 where gameid = 'xxxx2'
-- update dbo.tGiftList set giftkind = 2 where idx >= 2 and gameid = 'xxxx2'
-- update dbo.tGiftList set giftkind = 1 where idx  = 1 and gameid = 'xxxx2'
-- delete from dbo.tUserItem where gameid = 'xxxx2' and listidx = 10
update dbo.tGiftList set giftkind = 2 where idx = 1 where gameid = 'xxxx2'
exec spu_GiftGainNew 'xxxx2x', '049000s1i0n7t8445289', 331, -1,  1, -1		-- id /pw
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t844528x', 331, -1,  1, -1
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', 331, -1,  1, -1		-- �����߸�...
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', 333, -3,777, -1		-- �������� ��ȣ..
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', 333,-33,  2, -1		-- �������� �ʴ� �ڵ�

exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', 333, -1,  1, -1		-- �����ޱ�(����)
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', 333, -3,  2, -1		-- �������
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', 333, -3,  3, -1		-- ���� ��� ����A
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', 333, -3,  4, -1		-- ���� ���� �����ڽ�
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', 333, -3,  5, -1		-- ���� �ǻ� �����ڽ�
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', 333, -3,  6, -1		-- ���� ��Ű�� �ڽ�
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', 333, -3,  7, -1		-- ���� �ֹ���
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', 333, -3,  8, -1		-- �ʿ� �ֹ���
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', 333, -3,  9, -1		-- ������ �Ҹ�
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', 333, -3, 10, -1	-- ��ġ�� ���� �ֹ���
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', 333, -3, 11, -1	-- ������ ���� �ֹ���
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', 333, -3, 12, -1	-- ���̾� (5000 / 11��)
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', 333, -3, 13, -1	-- ���̾� �ҷ� (5001 / 1��)	1 ��	����(0)	��¥����	100
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', 333, -3, 14, -1	-- ���̾� ��ġ (5002 / 1��)	1 ��	����(0)	��¥����	1000
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', 333, -3, 15, -1	-- ���̾� �ָӴ� (5003 / 1��)	1 ��	����(0)	��¥����	2500
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', 333, -3, 16, -1	-- ���� ���̾� ���� (5004 / 1��)	1 ��	����(0)	��¥����	4000
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', 333, -3, 17, -1	-- ū ���̾� ���� (5005 / 1��)	1 ��	����(0)	��¥����	10000
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', 333, -3, 18, -1	-- ���� ���̾� ���� (5006 / 1��)	1 ��	����(0)	��¥����	20000

exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', 333, -5, -1, -1	-- ����Ʈ����
*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_GiftGainNew', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_GiftGainNew;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_GiftGainNew
	@gameid_				varchar(20),						-- ���Ӿ��̵�
	@password_				varchar(20),						-- ��ȣȭ�ؼ�����, �����н����� ��ŷ���ص� ����
	@sid_					int,
	@giftkind_				int,								--  1:�޽���
																--  2:����
																-- -1:�޽�������
																-- -2:��������
																-- -3:�����޾ư�
	@idx_					bigint,								-- �����ε���
	@nResult_				int					OUTPUT
	WITH ENCRYPTION
as
	------------------------------------------------
	--	2-1. �ڵ尪
	------------------------------------------------
	-- MT �Ϲݰ�
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	-- MT �α��� ����.
	declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--������ > �˾�ó���� ��Ʈ�η� ��������.
	declare @RESULT_ERROR_DELETED_USER 			int				set @RESULT_ERROR_DELETED_USER			= -12			--�������� > �˾�ó���� ��Ʈ�η� ��������.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--�ش������� ã�� ����
	declare @RESULT_ERROR_NOT_FOUND_PASSWORD	int				set @RESULT_ERROR_NOT_FOUND_PASSWORD	= -17
	declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--������ �����ϰ� �ִ�.
	declare @RESULT_NEWVERION_CLIENT_DOWNLOAD 	int				set @RESULT_NEWVERION_CLIENT_DOWNLOAD	= -15			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ��ũó��.
	declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ����.
	declare @RESULT_ERROR_NOT_FOUND_PHONE 		int				set @RESULT_ERROR_NOT_FOUND_PHONE		= -76			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ����.

	-- MT ���� �ڵ尪
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- �������ڵ��ã��
	declare @RESULT_ERROR_GIFTITEM_NOT_FOUND	int				set @RESULT_ERROR_GIFTITEM_NOT_FOUND	= -51			-- ������������ ��ã��
	declare @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	int				set @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	= -52			-- ������ �̹� ������
	declare @RESULT_ERROR_NOT_FOUND_GIFTID		int				set @RESULT_ERROR_NOT_FOUND_GIFTID		= -75			-- ĳ�� > ������ ���̵� ��ã��

	-- MT ��Ÿ����
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- ���������ʴ¸��
	declare @RESULT_ERROR_NOT_MATCH				int				set @RESULT_ERROR_NOT_MATCH				= -110			-- �����ΰ� ��ġ�� �ȵǾ���.
	declare @RESULT_ERROR_SESSION_ID_EXPIRE_LOGOUT	int			set @RESULT_ERROR_SESSION_ID_EXPIRE_LOGOUT	= -151		-- ������ ����Ǿ����ϴ�.

	------------------------------------------------
	--	2-2. ���ǵȰ�
	------------------------------------------------
	-- MT �����ۺ� �κ��з�
	declare @USERITEM_INVENKIND_WEAR			int 				set @USERITEM_INVENKIND_WEAR				= 1
	declare @USERITEM_INVENKIND_PIECE			int 				set @USERITEM_INVENKIND_PIECE				= 2
	declare @USERITEM_INVENKIND_CONSUME			int 				set @USERITEM_INVENKIND_CONSUME				= 3
	declare @USERITEM_INVENKIND_NON				int 				set @USERITEM_INVENKIND_NON					= 0
	declare @USERITEM_INVENKIND_INFO			int 				set @USERITEM_INVENKIND_INFO				= 60
	declare @USERITEM_INVENKIND_DIRECT			int 				set @USERITEM_INVENKIND_DIRECT				= 40

	-- MT ������ �Һз�
	declare @ITEM_SUBCATEGORY_WEAR_HELMET		int					set @ITEM_SUBCATEGORY_WEAR_HELMET			= 1  -- ���(1)
	declare @ITEM_SUBCATEGORY_WEAR_SHIRT		int					set @ITEM_SUBCATEGORY_WEAR_SHIRT			= 2  -- ����(2)
	declare @ITEM_SUBCATEGORY_WEAR_PANTS		int					set @ITEM_SUBCATEGORY_WEAR_PANTS			= 3  -- ����(3)
	declare @ITEM_SUBCATEGORY_WEAR_GLOVES		int					set @ITEM_SUBCATEGORY_WEAR_GLOVES			= 4  -- �尩(4)
	declare @ITEM_SUBCATEGORY_WEAR_SHOES		int					set @ITEM_SUBCATEGORY_WEAR_SHOES			= 5  -- �Ź�(5)
	declare @ITEM_SUBCATEGORY_WEAR_BAT			int					set @ITEM_SUBCATEGORY_WEAR_BAT				= 6  -- �����(6)
	declare @ITEM_SUBCATEGORY_WEAR_BALL			int					set @ITEM_SUBCATEGORY_WEAR_BALL				= 7  -- �����(7)
	declare @ITEM_SUBCATEGORY_WEAR_GOGGLE		int					set @ITEM_SUBCATEGORY_WEAR_GOGGLE			= 8  -- ���(8)
	declare @ITEM_SUBCATEGORY_WEAR_WRISTBAND	int					set @ITEM_SUBCATEGORY_WEAR_WRISTBAND		= 9  -- �ո� �ƴ�(9)
	declare @ITEM_SUBCATEGORY_WEAR_ELBOWPAD		int					set @ITEM_SUBCATEGORY_WEAR_ELBOWPAD			= 10 -- �Ȳ�ġ ��ȣ��(10)
	declare @ITEM_SUBCATEGORY_WEAR_BELT			int					set @ITEM_SUBCATEGORY_WEAR_BELT				= 11 -- ��Ʈ(11)
	declare @ITEM_SUBCATEGORY_WEAR_KNEEPAD		int					set @ITEM_SUBCATEGORY_WEAR_KNEEPAD			= 12 -- ���� ��ȣ��(12)
	declare @ITEM_SUBCATEGORY_WEAR_SOCKS		int					set @ITEM_SUBCATEGORY_WEAR_SOCKS			= 13 -- �縻(13)
	declare @ITEM_SUBCATEGORY_PIECE_HELMET		int					set @ITEM_SUBCATEGORY_PIECE_HELMET	    	= 15 -- ��� ����(15)
	declare @ITEM_SUBCATEGORY_PIECE_SHIRT		int					set @ITEM_SUBCATEGORY_PIECE_SHIRT	    	= 16 -- ���� ����(16)
	declare @ITEM_SUBCATEGORY_PIECE_PANTS		int					set @ITEM_SUBCATEGORY_PIECE_PANTS	    	= 17 -- ���� ����(17)
	declare @ITEM_SUBCATEGORY_PIECE_GLOVES		int					set @ITEM_SUBCATEGORY_PIECE_GLOVES	    	= 18 -- �尩 ����(18)
	declare @ITEM_SUBCATEGORY_PIECE_SHOES		int					set @ITEM_SUBCATEGORY_PIECE_SHOES	    	= 19 -- �Ź� ����(19)
	declare @ITEM_SUBCATEGORY_PIECE_BAT			int					set @ITEM_SUBCATEGORY_PIECE_BAT		    	= 20 -- ����� ����(20)
	declare @ITEM_SUBCATEGORY_PIECE_BALL		int					set @ITEM_SUBCATEGORY_PIECE_BALL			= 21 -- ����� ����(21)
	declare @ITEM_SUBCATEGORY_PIECE_GOGGLE		int					set @ITEM_SUBCATEGORY_PIECE_GOGGLE	    	= 22 -- ��� ����(22)
	declare @ITEM_SUBCATEGORY_PIECE_WRISTBAND	int					set @ITEM_SUBCATEGORY_PIECE_WRISTBAND   	= 23 -- �ո� �ƴ� ����(23)
	declare @ITEM_SUBCATEGORY_PIECE_ELBOWPAD	int					set @ITEM_SUBCATEGORY_PIECE_ELBOWPAD		= 24 -- �Ȳ�ġ ��ȣ�� ����(24)
	declare @ITEM_SUBCATEGORY_PIECE_BELT		int					set @ITEM_SUBCATEGORY_PIECE_BELT			= 25 -- ��Ʈ ����(25)
	declare @ITEM_SUBCATEGORY_PIECE_KNEEPAD		int					set @ITEM_SUBCATEGORY_PIECE_KNEEPAD	    	= 26 -- ���� ��ȣ�� ����(26)
	declare @ITEM_SUBCATEGORY_PIECE_SOCKS		int					set @ITEM_SUBCATEGORY_PIECE_SOCKS	    	= 27 -- �縻 ����(27)
	declare @ITEM_SUBCATEGORY_BOX_WEAR			int					set @ITEM_SUBCATEGORY_BOX_WEAR				= 40 -- ���� �����ڽ�(40)
	declare @ITEM_SUBCATEGORY_BOX_PIECE			int					set @ITEM_SUBCATEGORY_BOX_PIECE				= 41 -- �ǻ� �����ڽ�(41)
	declare @ITEM_SUBCATEGORY_BOX_ADVICE		int					set @ITEM_SUBCATEGORY_BOX_ADVICE			= 42 -- ���� ��Ű�� �ڽ�(42)
	declare @ITEM_SUBCATEGORY_SCROLL_EVOLUTION	int					set @ITEM_SUBCATEGORY_SCROLL_EVOLUTION		= 45 -- �ռ��ʿ��ֹ���(45)
	declare @ITEM_SUBCATEGORY_SCROLL_COMMISSION	int					set @ITEM_SUBCATEGORY_SCROLL_COMMISSION		= 46 -- �������ֹ���(46)
	declare @ITEM_SUBCATEGORY_CASHCOST			int					set @ITEM_SUBCATEGORY_CASHCOST				= 50 -- ���̾�(50)
	declare @ITEM_SUBCATEGORY_GAMECOST			int					set @ITEM_SUBCATEGORY_GAMECOST				= 60 -- ��(60)
	--declare @ITEM_SUBCATEGORY_STATICINFO		int					set @ITEM_SUBCATEGORY_STATICINFO			= 500 -- ��������(500)
	--declare @ITEM_SUBCATEGORY_LEVELUPREWARD		int					set @ITEM_SUBCATEGORY_LEVELUPREWARD			= 900 --������ ����(510)

	-- MT ���� ���ǰ�
	declare @GIFTLIST_GIFT_KIND_MESSAGE			int					set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2
	declare @GIFTLIST_GIFT_KIND_MESSAGE_DEL		int					set @GIFTLIST_GIFT_KIND_MESSAGE_DEL			= -1
	declare @GIFTLIST_GIFT_KIND_GIFT_DEL		int					set @GIFTLIST_GIFT_KIND_GIFT_DEL			= -2
	declare @GIFTLIST_GIFT_KIND_GIFT_GET		int					set @GIFTLIST_GIFT_KIND_GIFT_GET			= -3
	declare @GIFTLIST_GIFT_KIND_GIFT_SELL		int					set @GIFTLIST_GIFT_KIND_GIFT_SELL			= -4
	declare @GIFTLIST_GIFT_KIND_LIST			int					set @GIFTLIST_GIFT_KIND_LIST				= -5

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

	declare @DEFINE_MULTISTATE_GIFTCNT			int					set @DEFINE_MULTISTATE_GIFTCNT				= 1		-- ��Ƽ���.
	declare @DEFINE_MULTISTATE_BUYAMOUNT		int					set @DEFINE_MULTISTATE_BUYAMOUNT			= 0		-- �⺻.

	------------------------------------------------
	--	2-3. ���λ�� ����
	------------------------------------------------
	declare @gameid			varchar(20)		set @gameid		= ''
	declare @sid			int				set @sid		= -999
	declare @itemcode		int				set @itemcode 	= -1
	declare @giftkind		int				set @giftkind 	= -1
	declare @cashcost		int				set @cashcost 	= 0
	declare @gamecost		int				set @gamecost 	= 0

	declare @subcategory 	int
	declare	@buyamount		int				set @buyamount		= 0
	declare	@buyamount2		int				set @buyamount2		= 0
	declare	@invenkind		int
	declare @multistate		int				set @multistate		= @DEFINE_MULTISTATE_BUYAMOUNT

	declare @comment		varchar(80)
	declare @plus	 		int 			set @plus			= 0

	declare @sendcnt 		int				set @sendcnt		=  0
	declare @listidxnew 	int				set @listidxnew		= -1
	declare @listidxcust 	int				set @listidxcust	= -1
	declare @listidxrtn 	int				set @listidxrtn		= -1

	declare @dummy	 		int

	DECLARE @tTempTable TABLE(
		listidx		int
	);
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	set @comment  = '�˼� ���� ������ �߻��߽��ϴ�.'
	--select 'DEBUG 1-1 �Է°�', @gameid_ gameid_, @password_ password_, @sid_ sid_, @giftkind_ giftkind_, @idx_ idx_

	------------------------------------------------
	--	3-2. �������(��������, ��������, ������ ����)
	------------------------------------------------
	select
		@gameid 		= gameid,		@sid		= sid,
		@cashcost		= cashcost,		@gamecost	= gamecost
	from dbo.tUserMaster where gameid = @gameid_ and password = @password_
	--select 'DEBUG 1-3 ��������', @gameid gameid, @cashcost cashcost, @sid sid, @gamecost gamecost

	select
		@giftkind 	= giftkind,
		@itemcode 	= itemcode,
		@sendcnt	= cnt
	from dbo.tGiftList where gameid = @gameid_ and idx = @idx_
	--select 'DEBUG 1-4 ����/����', @giftkind giftkind, @itemcode itemcode, @sendcnt sendcnt

	------------------------------------------------
	--	3-3. ����Ȳ���� �ڵ�� �з�
	------------------------------------------------
	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR ���̵� �������� �ʴ´�.'
			--select 'DEBUG ' + @comment
		END
	else if(@sid_ != @sid)
		BEGIN
			set @nResult_ = @RESULT_ERROR_SESSION_ID_EXPIRE_LOGOUT
			set @comment 	= 'ERROR ������ ���� �Ǿ����ϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if isnull(@giftkind, -1) = -1
		BEGIN
			set @nResult_ = @RESULT_ERROR_GIFTITEM_NOT_FOUND
			set @comment = 'ERROR ����, ���� ������ü�� ����'
			--select 'DEBUG ' + @comment
		END
	else if (@giftkind in (@GIFTLIST_GIFT_KIND_MESSAGE_DEL, @GIFTLIST_GIFT_KIND_GIFT_DEL, @GIFTLIST_GIFT_KIND_GIFT_GET, @GIFTLIST_GIFT_KIND_GIFT_SELL, @GIFTLIST_GIFT_KIND_LIST))
		BEGIN
			set @nResult_ = @RESULT_ERROR_GIFTITEM_ALREADY_GAIN
			set @comment = 'ERROR ���� �� �����Ǿ����ϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if (@giftkind_ not in (@GIFTLIST_GIFT_KIND_MESSAGE_DEL, @GIFTLIST_GIFT_KIND_GIFT_DEL, @GIFTLIST_GIFT_KIND_GIFT_GET, @GIFTLIST_GIFT_KIND_GIFT_SELL, @GIFTLIST_GIFT_KIND_LIST))
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment = 'ERROR �������� �ʴ� ��尪�Դϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if(@giftkind_ = @GIFTLIST_GIFT_KIND_MESSAGE_DEL)
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS �޼��� ���� ó���մϴ�.'
			--select 'DEBUG ' + @comment

			update dbo.tGiftList set giftkind = @giftkind_ where idx = @idx_
		END
	else if(@giftkind_ = @GIFTLIST_GIFT_KIND_LIST)
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS ���� ����Ʈ ����.'
			--select 'DEBUG ' + @comment

			set @listidxrtn = -1
		END
	else if(@giftkind_ = @GIFTLIST_GIFT_KIND_GIFT_DEL)
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS ���� ���� ó���մϴ�.'
			--select 'DEBUG ' + @comment

			update dbo.tGiftList set giftkind = @giftkind_ where idx = @idx_
		END
	else if(@giftkind_ = @GIFTLIST_GIFT_KIND_GIFT_GET)
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS ���� ���� ó���մϴ�.'

			select
				@subcategory 	= subcategory,
				@multistate		= multistate,
				@buyamount 		= buyamount
			from dbo.tItemInfo where itemcode = @itemcode
			--select 'DEBUG 4-0 ', @subcategory subcategory, @buyamount buyamount, @sendcnt sendcnt

			--------------------------------------------------------------
			-- ���� ������ ������ ���� ����
			-- ������ �⺻ ������ �����Ѵ�.
			--------------------------------------------------------------
			set @buyamount2= @buyamount
			set @buyamount = case when(@sendcnt > 0) then @sendcnt else @buyamount end
			set @invenkind = dbo.fnu_GetInvenFromSubCategory(@subcategory)
			select @listidxnew = isnull(MAX(listidx), 0) + 1 from dbo.tUserItem where gameid = @gameid_
			--select 'DEBUG 4-1 ', @subcategory subcategory, @buyamount buyamount, @sendcnt sendcnt, @invenkind invenkind, @listidxnew listidxnew

			if(@invenkind = @USERITEM_INVENKIND_WEAR)
				begin
					--------------------------------------------------------------
					-- �ϼ��ǻ�
					-- listidx -> 1�� ����
					--------------------------------------------------------------
					--select 'DEBUG 4-2-2 �ϼ��ǻ� > �űԷ� �־��ֱ�', @gameid_ gameid_, @listidxnew listidxnew, @itemcode itemcode, @idx_ idx_

					-- �ش������ �κ��� ����
					insert into dbo.tUserItem(gameid,      listidx,  itemcode, cnt,  invenkind,  gethow)				-- �ǻ�
					values(					 @gameid_, @listidxnew, @itemcode,   1, @invenkind, @DEFINE_HOW_GET_GIFT)

					-- ������ ������ ���·� �����д�.
					update dbo.tGiftList set giftkind = @GIFTLIST_GIFT_KIND_GIFT_GET, gaindate = getdate() where idx = @idx_

					-- ����� ������ ����Ʈ�ε���
					set @listidxrtn	= @listidxnew

					--select 'DEBUG ', @listidxrtn listidxrtn
				end
			else if(@invenkind = @USERITEM_INVENKIND_PIECE )
				begin
					--------------------------------------------------------------
					-- �����ǻ�
					-- listidx -> n�� ���� (��Ƽ����)
					--------------------------------------------------------------
					select
						@listidxcust 	= listidx
					from dbo.tUserItem
					where gameid = @gameid_ and itemcode = @itemcode
					--select 'DEBUG 4-3 �κ��ֱ�', @gameid_ gameid_, @subcategory subcategory, @itemcode itemcode, @listidxcust listidxcust

					--------------------------------------------------------------
					-- �ش������ �κ��� ����
					-- ���ڸ� ã�� Ŀ��
					-- 0 [1] 2 3 4 5 	> [1] > update
					-- 0 1 2 3 4 5 6  	> ���� > insert
					--------------------------------------------------------------
					if(@listidxcust = -1)
						begin
							--select 'DEBUG ���� �߰�', @gameid_ gameid_, @listidxnew listidxnew, @itemcode itemcode, @buyamount buyamount

							insert into dbo.tUserItem(gameid,      listidx,  itemcode,        cnt,  invenkind, gethow)
							values(					@gameid_,  @listidxnew, @itemcode, @buyamount, @invenkind, @DEFINE_HOW_GET_GIFT)

							-- ����� ������ ����Ʈ�ε���
							set @listidxrtn	= @listidxnew
						end
					else
						begin
							--select 'DEBUG ���� �����ۿ� ����', @gameid_ gameid_, @listidxcust listidxcust, @buyamount buyamount

							update dbo.tUserItem
								set
									cnt = cnt + @buyamount
							where gameid = @gameid_ and listidx = @listidxcust

							-- ����� ������ ����Ʈ�ε���
							set @listidxrtn	= @listidxcust
						end

					-- ������ ������ ���·� �����д�.
					update dbo.tGiftList set giftkind = @GIFTLIST_GIFT_KIND_GIFT_GET, gaindate = getdate() where idx = @idx_

					-- ������ ������ ���·� �����д�.
					--select 'DEBUG ', @listidxrtn listidxrtn
				end
			else if(@invenkind = @USERITEM_INVENKIND_CONSUME)
				begin
					--------------------------------------------------------------
					-- �Ѿ�	   	-> �Ҹ� ������0
					-- listidx 	-> n�� ���� (��Ƽ����)
					--------------------------------------------------------------
					set @itemcode = dbo.fnu_GetItemcodeFromConsumePackage(@subcategory, @itemcode)

					select
						@listidxcust 	= listidx
					from dbo.tUserItem
					where gameid = @gameid_ and itemcode = @itemcode
					--select 'DEBUG 4-3 �Һ�(n)�κ��ֱ�', @gameid_ gameid_, @subcategory subcategory, @itemcode itemcode, @listidxcust listidxcust

					---------------------------------------------------
					-- �ش������ �κ��� ����
					-- ���ڸ� ã�� Ŀ��
					-- 0 [1] 2 3 4 5 	> [1] > update
					-- 0 1 2 3 4 5 6  	> ���� > insert
					---------------------------------------------------
					if(@listidxcust = -1)
						begin
							--select 'DEBUG �Һ� �߰�', @gameid_ gameid_, @listidxnew listidxnew, @itemcode itemcode, @buyamount buyamount

							insert into dbo.tUserItem(gameid,      listidx,  itemcode,        cnt,  invenkind, gethow)
							values(					@gameid_,  @listidxnew, @itemcode, @buyamount, @invenkind, @DEFINE_HOW_GET_GIFT)

							-- ����� ������ ����Ʈ�ε���
							set @listidxrtn	= @listidxnew
						end
					else
						begin
							--select 'DEBUG �Һ� �����ۿ� ����', @gameid_ gameid_, @listidxcust listidxcust, @buyamount buyamount

							update dbo.tUserItem
								set
									cnt = cnt + @buyamount
							where gameid = @gameid_ and listidx = @listidxcust

							-- ����� ������ ����Ʈ�ε���
							set @listidxrtn	= @listidxcust
						end


					-- ������ ������ ���·� �����д�.
					update dbo.tGiftList set giftkind = @GIFTLIST_GIFT_KIND_GIFT_GET, gaindate = getdate() where idx = @idx_

					-- ������ ������ ���·� �����д�.
					--select 'DEBUG ', @listidxrtn listidxrtn
				end
			else if(@subcategory = @ITEM_SUBCATEGORY_CASHCOST)
				begin
					---------------------------------------------------------------
					-- ĳ���� ����, �ŷ��ҿ��� �������� �ŷ��� �ŷ� ������ ���������� ����.
					-- ���� 	-> ������ or ����
					-- �ŷ��� 	-> ������
					---------------------------------------------------------------
					--select 'DEBUG 4-5-1 cashcost(ĳ��)	-> �ٷ�����', @multistate multistate, @cashcost cashcost, @sendcnt sendcnt, @buyamount buyamount
					if(@multistate = @DEFINE_MULTISTATE_GIFTCNT)
						begin
							set @plus		= @sendcnt
							--select 'DEBUG 4-6 ĳ�� -> ��������', @sendcnt sendcnt
						end
					else
						begin
							set @plus		= @buyamount2
							--select 'DEBUG 4-6 ĳ�� -> ��������', @buyamount2 buyamount2
						end
					set @plus = case when @plus < 0 then 0 else @plus end
					set @cashcost	= @cashcost + @plus

					-- �������� ���� �־���
					update dbo.tUserMaster
					set
						cashcost = @cashcost,
						cashreceivetotal = cashreceivetotal + @plus
					where gameid = @gameid_

					-- ������ ������ ���·� �����д�.
					update dbo.tGiftList set giftkind = @GIFTLIST_GIFT_KIND_GIFT_GET, gaindate = getdate() where idx = @idx_
				end
			else if(@subcategory = @ITEM_SUBCATEGORY_GAMECOST)
				begin
					---------------------------------------------------------------
					-- ����, �ŷ��ҿ��� �������� �ŷ��� �ŷ� ������ ���������� ����.
					-- ���� 	-> ������ or ����
					-- �ŷ��� 	-> ������
					---------------------------------------------------------------
					--select 'DEBUG 4-5-1 gamecost(��)	-> �ٷ�����', @multistate multistate, @gamecost gamecost, @sendcnt sendcnt, @buyamount buyamount
					if(@multistate = @DEFINE_MULTISTATE_GIFTCNT)
						begin
							set @plus		= @sendcnt
							--select 'DEBUG 4-6 �� -> ��������', @sendcnt sendcnt
						end
					else
						begin
							set @plus		= @buyamount2
							--select 'DEBUG 4-6 �� -> ��������', @buyamount2 buyamount2
						end
					set @plus 		= case when @plus < 0 then 0 else @plus end
					set @gamecost	= @gamecost + @plus

					-- �������� ���� �־���
					update dbo.tUserMaster
					set
						gamecost = @gamecost
					where gameid = @gameid_

					-- ������ ������ ���·� �����д�.
					update dbo.tGiftList set giftkind = @GIFTLIST_GIFT_KIND_GIFT_GET, gaindate = getdate() where idx = @idx_
				end
			else
				begin
					--------------------------------------------------------------
					-- seed(��������)	-> ����
					-- ���׷��̵�		-> ����
					--------------------------------------------------------------
					--select 'DEBUG 4-7 ����ǥ�ÿ�'

					-- ������ ������ ���·� �����д�.
					update dbo.tGiftList set giftkind = @GIFTLIST_GIFT_KIND_GIFT_GET, gaindate = getdate() where idx = @idx_
				end

			-- ���� ������ ������ ����Ʈ�� �߰����ֱ�.
			if( @listidxrtn != -1)
				begin
					insert into @tTempTable( listidx ) values( @listidxrtn )
				end
		END

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off

	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost

	if(@nResult_ = @RESULT_SUCCESS)
		begin
			--------------------------------------------------------------
			-- ���� ���� ������ ���� > ���� ȹ���� �͸� ����(������ �ϰ� ���� ������ Ŭ����� �����͸� �������� ������)
			--------------------------------------------------------------
			select * from dbo.tUserItem
			where gameid = @gameid_ and listidx in ( select listidx from @tTempTable )

			--------------------------------------------------------------
			-- ����/���� ����Ʈ ����
			--------------------------------------------------------------
			exec spu_GiftList @gameid_
		end

End

