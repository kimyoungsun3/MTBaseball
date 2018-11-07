---------------------------------------------------------------
/*
update dbo.tUserMaster set cashcost = 0,        gamecost = 0, randserial = -1 where gameid = 'mtxxxx3'
update dbo.tUserMaster set cashcost = 10000000, gamecost = 0, randserial = -1 where gameid = 'mtxxxx3'
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 333, 4000, 1, 7771, -1	-- �� �ڽ�. -> error
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 333, 4001, 1, 7772, -1	-- �� �ڽ�.
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 333, 4001, 1, 7770, -1
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 333, 4002, 1, 7773, -1	-- �� �ڽ�.
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 333, 4003,10, 7774, -1	-- �� �ڽ�.
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 333, 4004,10, 7775, -1	-- ƼŸ�� �ڽ�.

exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 333, 4500, 1, 7772, -1	-- 4500	�Ҹ�ǰ(40)	�����ʿ��ֹ���(45)
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 333, 4500, 1, 7770, -1
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 333, 4501, 1, 7772, -1	-- 4501	�Ҹ�ǰ(40)	�����ʿ��ֹ���(45)
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 333, 4501, 1, 7770, -1
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 333, 4700, 1, 7773, -1	-- 4700	�Ҹ�ǰ(40)	�г��Ӻ����(47)
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 333, 4700, 1, 7770, -1
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 333, 6000, 1, 7774, -1	-- 6000	��(60)	��(60)
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 333, 6000,10, 7775, -1


-- ���� �Ұ��۵�.
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 333, 4200, 1, 7771, -1	-- 4200	�Ҹ�ǰ(40)	���� ��Ű�� �ڽ�(42) -> web
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 333,  101, 1, 7775, -1	-- �⺻���
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 333, 1500, 1, 7776, -1	-- �� ��� ����A
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 333, 4100, 1, 7777, -1	-- �� �ǻ� �����ڽ�
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 333, 4600, 1, 7778, -1	-- 4600	�Ҹ�ǰ(40)	�������ֹ���(46)
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 333, 4800, 1, 7779, -1	-- 4800	�Ҹ�ǰ(40)	�������̾�(48)
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 333, 5000, 1, 7770, -1	-- 5000	���̾�(50)	���̾�(50)

*/

use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_ItemBuy', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_ItemBuy;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_ItemBuy
	@gameid_				varchar(20),						-- ���Ӿ��̵�
	@password_				varchar(20),						-- ��ȣȭ�ؼ�����, �����н����� ��ŷ���ص� ����
	@sid_					int,
	@itemcode_				int,								--
	@buycnt_				int,								--
	@randserial_			varchar(20),						--
	@nResult_				int					OUTPUT
	WITH ENCRYPTION
as
	------------------------------------------------
	--	2-1. �ڵ尪
	------------------------------------------------
	-- �Ϲݰ�
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	-- �α��� ����.
	declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--�������� > �˾�ó���� ��Ʈ�η� ��������.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--�ش������� ã�� ����

	-- �����߿� ����.
	declare @RESULT_ERROR_GAMECOST_LACK			int				set @RESULT_ERROR_GAMECOST_LACK			= -21			--�ǹ��� �����ϴ�.
	declare @RESULT_ERROR_CASHCOST_LACK			int				set @RESULT_ERROR_CASHCOST_LACK			= -22			--��尡 �����ϴ�.
	declare @RESULT_ERROR_ITEM_LACK				int				set @RESULT_ERROR_ITEM_LACK				= -23			--�������̺����ϴ�.

	-- ���� �ڵ尪
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- �������ڵ��ã��
	declare @RESULT_ERROR_GIFTITEM_NOT_FOUND	int				set @RESULT_ERROR_GIFTITEM_NOT_FOUND	= -51			-- ������������ ��ã��
	declare @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	int				set @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	= -52			-- ������ �̹� ������
	declare @RESULT_ERROR_NOT_FOUND_GIFTID		int				set @RESULT_ERROR_NOT_FOUND_GIFTID		= -75			-- ĳ�� > ������ ���̵� ��ã��

	-- ��Ÿ����
	declare @RESULT_ERROR_DOUBLE_RANDSERIAL		int				set @RESULT_ERROR_DOUBLE_RANDSERIAL		= -111			-- �����ø��� �ߺ�.
	declare @RESULT_ERROR_ITEMCOST_WRONG		int				set @RESULT_ERROR_ITEMCOST_WRONG		= -113			-- ������ ������ �̻���.
	declare @RESULT_ERROR_SESSION_ID_EXPIRE_LOGOUT	int			set @RESULT_ERROR_SESSION_ID_EXPIRE_LOGOUT	= -151		-- ������ ����Ǿ����ϴ�.
	declare @RESULT_ERROR_NOT_BUY_ITEMCODE		int				set @RESULT_ERROR_NOT_BUY_ITEMCODE			= -215		-- ���źҰ����Դϴ�.

	------------------------------------------------
	--	2-2. ���ǵȰ�
	------------------------------------------------
	-- MT �����°�.
	declare @BLOCK_STATE_NO						int					set	@BLOCK_STATE_NO							= 0	-- �����¾ƴ�
	declare @BLOCK_STATE_YES					int					set	@BLOCK_STATE_YES						= 1	-- ������

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
	declare @ITEM_MAINCATEGORY_CASHCOST			int					set @ITEM_MAINCATEGORY_CASHCOST 			= 50 	-- ĳ������(50)
	declare @ITEM_MAINCATEGORY_STATICINFO		int					set @ITEM_MAINCATEGORY_STATICINFO 			= 500 	-- ��������(500)
	declare @ITEM_MAINCATEGORY_LEVELUPREWARD	int					set @ITEM_MAINCATEGORY_LEVELUPREWARD		= 510 	-- ������ ����(510)

	-- MT ������ �Һз�
	declare @ITEM_SUBCATEGORY_BOX_PIECE			int					set @ITEM_SUBCATEGORY_BOX_PIECE				= 40 -- ���� �����ڽ�(40)
	--declare @ITEM_SUBCATEGORY_BOX_CLOTH		int					set @ITEM_SUBCATEGORY_BOX_CLOTH				= 41 -- �ǻ� �����ڽ�(41)
	declare @ITEM_SUBCATEGORY_BOX_ADVICE		int					set @ITEM_SUBCATEGORY_BOX_ADVICE			= 42 -- ���� ��Ű�� �ڽ�(42)
	declare @ITEM_SUBCATEGORY_SCROLL_EVOLUTION	int					set @ITEM_SUBCATEGORY_SCROLL_EVOLUTION		= 45 -- �ռ��ʿ��ֹ���(45)
	--declare @ITEM_SUBCATEGORY_SCROLL_COMMISSION	int				set @ITEM_SUBCATEGORY_SCROLL_COMMISSION		= 46 -- �������ֹ���(46)
	declare @ITEM_SUBCATEGORY_NICKCHANGE		int					set @ITEM_SUBCATEGORY_NICKCHANGE			= 47 -- �г��Ӻ����(47)
	--declare @ITEM_SUBCATEGORY_RANDOM_CASHCOST_BOX	int				set @ITEM_SUBCATEGORY_RANDOM_CASHCOST_BOX	= 48 -- �������̾�(48)
	declare @ITEM_SUBCATEGORY_CASHCOST			int					set @ITEM_SUBCATEGORY_CASHCOST				= 50 -- ���̾�(50)
	declare @ITEM_SUBCATEGORY_GAMECOST			int					set @ITEM_SUBCATEGORY_GAMECOST				= 60 -- ��(60)

	-- MT ������ ȹ����
	declare @DEFINE_HOW_GET_FIRST				int					set @DEFINE_HOW_GET_FIRST					= 0		--�⺻
	declare @DEFINE_HOW_GET_BUY					int					set @DEFINE_HOW_GET_BUY						= 1		--����
	--declare @DEFINE_HOW_GET_GIFT				int					set @DEFINE_HOW_GET_GIFT					= 5		--����
	--declare @DEFINE_HOW_GET_FREEANIRESTORE	int					set @DEFINE_HOW_GET_FREEANIRESTORE			= 17	--���ẹ��.
	--declare @DEFINE_HOW_GET_BOX_OPEN			int					set @DEFINE_HOW_GET_BOX_OPEN				= 20 	-- �ڽ��̱�.
	--declare @DEFINE_HOW_GET_LEVELUP			int 				set @DEFINE_HOW_GET_LEVELUP					= 21 	-- ������.
	--declare @DEFINE_HOW_GET_AUCTION_BUY		int 				set @DEFINE_HOW_GET_AUCTION_BUY				= 22 	-- ����� ����.
	--declare @DEFINE_HOW_GET_COMBINATE			int 				set @DEFINE_HOW_GET_COMBINATE				= 23 	-- �������� ȹ��.
	--declare @DEFINE_HOW_GET_EVOLUTION			int 				set @DEFINE_HOW_GET_EVOLUTION				= 24 	-- �ʿ��� ȹ��.

	declare @DEFINE_MULTISTATE_GIFTCNT			int					set @DEFINE_MULTISTATE_GIFTCNT				= 1		-- ��Ƽ���.
	declare @DEFINE_MULTISTATE_BUYAMOUNT		int					set @DEFINE_MULTISTATE_BUYAMOUNT			= 0		-- �⺻.

	-- ������ �Ϲ�����.
	declare @CONSUME_MAX_COUNT					int					set @CONSUME_MAX_COUNT						= 99999
	--declare @ACTIVATE_STORE_SELL_NO			int					set @ACTIVATE_STORE_SELL_NO					= 0
	declare @ACTIVATE_STORE_SELL_YES			int					set @ACTIVATE_STORE_SELL_YES				= 1

	------------------------------------------------
	--	2-3. ���λ�� ����
	------------------------------------------------
	declare @comment		varchar(80)		set @comment  		= '�˼� ���� ������ �߻��߽��ϴ�.'
	declare @gameid			varchar(20)		set @gameid			= ''
	declare @cashcost		int				set @cashcost 		= 0
	declare @gamecost		int				set @gamecost 		= 0
	declare @sid			int				set @sid			= -1
	declare @blockstate		int				set @blockstate		= @BLOCK_STATE_YES

	declare @itemcode 		int				set @itemcode 		= -1
	declare @invenkind 		int				set @invenkind 		= @USERITEM_INVENKIND_CONSUME
	declare @equpslot 		int				set @equpslot 		= @USERITEM_INVENKIND_CONSUME
	declare @subcategory 	int				set @subcategory 	= -444
	declare @discount		int				set @discount		= 0
	declare @gamecostsell	int				set @gamecostsell 	= 0
	declare @cashcostsell	int				set @cashcostsell 	= 0
	declare @buyamount		int				set @buyamount	 	= 0
	declare @multistate		int				set @multistate		= @DEFINE_MULTISTATE_BUYAMOUNT

	declare @cntnew			int				set @cntnew			= 0
	declare @randserial		varchar(20)		set @randserial		= '-1'
	declare @randserial2	varchar(20)		set @randserial2	= '-1'
	declare @listidxcust 	int				set @listidxcust	= -1
	declare @listidxnew 	int				set @listidxnew		= -1
	declare @listidxrtn 	int				set @listidxrtn		= -1
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG 3-1 �Է°�', @gameid_ gameid_, @password_ password_, @sid_ sid_, @itemcode_ itemcode_, @buycnt_ buycnt_, @randserial_ randserial_

	------------------------------------------------
	--	3-2. �������(��������, ��������, ������ ����)
	------------------------------------------------
	select
		@gameid 		= gameid,	@blockstate		= blockstate,
		@cashcost		= cashcost,	@gamecost		= gamecost,
		@sid			= sid,		@randserial2	= randserial
	from dbo.tUserMaster where gameid = @gameid_ and password = @password_
	--select 'DEBUG 3-2 ��������', @gameid gameid, @cashcost cashcost, @gamecost gamecost, @sid sid

	select
		@itemcode 		= itemcode,
		@subcategory 	= subcategory,		@equpslot	= equpslot,		@multistate		= multistate,
		@gamecostsell	= gamecost,			@cashcostsell= cashcost,	@buyamount		= buyamount
	from dbo.tItemInfo where itemcode = @itemcode_ and activate = @ACTIVATE_STORE_SELL_YES
	--select 'DEBUG 3-3 ����������(tItemInfo)', @itemcode_ itemcode_, @itemcode itemcode, @subcategory subcategory, @equpslot equpslot, @gamecostsell gamecostsell, @cashcostsell cashcostsell, @buyamount buyamount

	set @invenkind = dbo.fnu_GetInvenFromSubCategory(@subcategory)
	--select 'DEBUG 3-4 ����������', @invenkind invenkind

	select
		@listidxcust	= listidx, 			@randserial 		= randserial
	from dbo.tUserItem
	where gameid = @gameid_ and itemcode = @itemcode
	--select 'DEBUG 3-5 ����������', @itemcode itemcode, @listidxcust listidxcust, @randserial randserial

	---------------------------------------
	-- �����ľ��ؼ� �ܰ������ϱ�.
	---------------------------------------
	set @buycnt_ = case when @buycnt_ <= 0 then 1 else @buycnt_ end
	if(@invenkind = @USERITEM_INVENKIND_WEAR)
		begin
			set @buycnt_ = 1
		end
	set @gamecostsell	= @gamecostsell * @buycnt_
	set @cashcostsell	= @cashcostsell * @buycnt_
	set @cntnew			= @buyamount    * @buycnt_
	--select 'DEBUG 3-2-3 ����������', @gamecostsell gamecostsell, @cashcostsell cashcostsell, @buyamount buyamount, @buycnt_ buycnt_, @cntnew cntnew

	------------------------------------------------
	--	3-3. ����Ȳ���� �ڵ�� �з�
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
	else if( @sid_ != @sid )
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_SESSION_ID_EXPIRE_LOGOUT
			set @comment 	= 'ERROR ������ ���� �Ǿ����ϴ�. (�α׾ƿ� �����ּ���.)'
			--select 'DEBUG ' + @comment
		END
	else if ( @itemcode = -1)
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_ITEMCODE
			set @comment = 'ERROR �������� ã�� �� �����ϴ�.(�ǸžȵǴ� ��������1)'
			--select 'DEBUG ' + @comment
		END
	else if (@subcategory not in ( @ITEM_SUBCATEGORY_BOX_PIECE, @ITEM_SUBCATEGORY_SCROLL_EVOLUTION, @ITEM_SUBCATEGORY_NICKCHANGE, @ITEM_SUBCATEGORY_GAMECOST ) )
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_BUY_ITEMCODE
			set @comment = 'ERROR �������� ã�� �� �����ϴ�.(�ǸžȵǴ� ������ ī�װ���2)'
			--select 'DEBUG ' + @comment
		END
	else if (@cashcostsell > 0 and @cashcostsell > @cashcost)
		BEGIN
			set @nResult_ = @RESULT_ERROR_CASHCOST_LACK
			set @comment = 'ERROR ĳ��(���̾�)�� �����մϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if (@gamecostsell > 0 and @gamecostsell > @gamecost)
		BEGIN
			set @nResult_ = @RESULT_ERROR_GAMECOST_LACK
			set @comment = 'ERROR ������ �����մϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if ( @gamecostsell = 0 and @cashcostsell = 0 and @buyamount = 0 )
		BEGIN
			set @nResult_ = @RESULT_ERROR_ITEMCOST_WRONG
			set @comment = 'ERROR ������ ������ �̻��մϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if ( ( @invenkind = @USERITEM_INVENKIND_CONSUME and @randserial = @randserial_ )
				or
			  ( @subcategory = @ITEM_SUBCATEGORY_GAMECOST and @randserial2 = @randserial_ ))
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS ���� ���� ó���մϴ�.(�ߺ�����)'
			--select 'DEBUG ' + @comment

			set @listidxrtn = @listidxcust
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS ���� ���� ó���մϴ�.'

			if(@invenkind = @USERITEM_INVENKIND_CONSUME)
				begin
					----------------------------------------------------------------
					-- ���� �����ڽ�(40),
					-- ���� ��Ű�� �ڽ�(42)
					-- �����ʿ��ֹ���(45)
					----------------------------------------------------------------
					if(@listidxcust = -1)
						begin
							select @listidxnew = isnull(MAX(listidx), 0) + 1 from dbo.tUserItem where gameid = @gameid_
							--select 'DEBUG 4-1 �κ� ����ȣ', @listidxnew listidxnew

							--select 'DEBUG �Һ� �߰�', @gameid_ gameid_, @listidxnew listidxnew, @itemcode_ itemcode_, @cntnew cntnew

							insert into dbo.tUserItem(gameid,      listidx,   itemcode,        cnt,  invenkind,   randserial, gethow)
							values(					@gameid_,  @listidxnew, @itemcode_,    @cntnew, @invenkind, @randserial_, @DEFINE_HOW_GET_BUY)

							-- ����� ������ ����Ʈ�ε���
							set @listidxrtn	= @listidxnew
						end
					else
						begin
							--select 'DEBUG �Һ� �����ۿ� ����', @gameid_ gameid_, @listidxcust listidxcust, @cntnew cntnew

							update dbo.tUserItem
								set
									cnt 		= cnt + @cntnew,
									randserial 	= @randserial_
							where gameid = @gameid_ and listidx = @listidxcust

							-- ����� ������ ����Ʈ�ε���
							set @listidxrtn	= @listidxcust
						end

					-- ĳ�� or �������� > �ϴܿ��� ������.
					set @cashcost = @cashcost - @cashcostsell
					set @gamecost = @gamecost - @gamecostsell

					-- �������� ���� �־���
					update dbo.tUserMaster
						set
							cashcost	= @cashcost,
							gamecost	= @gamecost
					where gameid = @gameid_

					-- ���ű�ϸ�ŷ
					exec spu_UserItemBuyLogNew @gameid_, @itemcode_, @gamecostsell, @cashcostsell, @cntnew
				end
			else if(@subcategory = @ITEM_SUBCATEGORY_GAMECOST)
				begin
					--select 'DEBUG 4-5-1 gamecost(��)	-> �ٷ�����', @multistate multistate, @gamecost gamecost, @cntnew cntnew
					if(@multistate = @DEFINE_MULTISTATE_GIFTCNT)
						begin
							--select 'DEBUG 4-6 �� -> ��������'
							set @cntnew	= @cntnew
						end
					else
						begin
							--select 'DEBUG 4-6 �� -> ��������'
							set @cntnew	= @buyamount
						end
					set @cashcost 	= @cashcost - @cashcostsell
					set @gamecost	= @gamecost + @cntnew

					-- �������� ���� �־���
					update dbo.tUserMaster
						set
							cashcost	= @cashcost,
							gamecost 	= @gamecost,
							randserial	= @randserial_
					where gameid = @gameid_

					-- ���ű�ϸ�ŷ
					exec spu_UserItemBuyLogNew @gameid_, @itemcode_, 0, @cashcostsell, @cntnew
				end
		END


	--------------------------------------------------------------
	-- �ڵ�(ĳ��, ����, ��Ʈ, ����)
	--------------------------------------------------------------
	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost

	if(@nResult_ = @RESULT_SUCCESS)
		begin
			--------------------------------------------------------------
			-- ���� ���� ������ ���� > ���� ȹ���� �͸� ����(������ �ϰ� ���� ������ Ŭ����� �����͸� �������� ������)
			--------------------------------------------------------------
			select * from dbo.tUserItem
			where gameid = @gameid_ and listidx = @listidxrtn
		end

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off
End

