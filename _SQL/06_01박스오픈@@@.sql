/*
-- @@@@���� �����ڽ�.
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 59, 7711, -1	-- �� ���� �����ڽ�(4000)
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 59, 7712, -1
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 52, 7713, -1	-- �� ���� �����ڽ�(4001)
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 52, 7714, -1
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 53, 7715, -1	-- �� ���� �����ڽ�(4002)
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 53, 7716, -1
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 54, 7717, -1	-- �� ���� �����ڽ�(4003)
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 54, 7718, -1
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 55, 7719, -1	-- ƼŸ�� ���� �����ڽ�(4004)
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 55, 7720, -1

-- @@@@�ǻ� �����ڽ�.
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 60, 7721, -1	-- �� �ǻ� �����ڽ�(4100)
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 60, 7722, -1
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 61, 7723, -1	-- �� �ǻ� �����ڽ�(4101)
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 61, 7724, -1
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 62, 7725, -1	-- �� �ǻ� �����ڽ�(4102)
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 62, 7726, -1
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 63, 7727, -1	-- �� �ǻ� �����ڽ�(4103)
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 63, 7728, -1
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 64, 7729, -1	-- ƼŸ�� �ǻ� �����ڽ�(4104)
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 64, 7720, -1

-- ������Ű��.
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 65, 7721, -1	-- ���� ��Ű�� �ڽ�(4200)
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 65, 7722, -1

-- @@@@ĳ���ڽ�.
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 66, 7723, -1	-- ���� ���̾� �ڽ�(4800)
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 66, 7724, -1
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
	declare @ITEM_SUBCATEGORY_BOX_WEAR			int					set @ITEM_SUBCATEGORY_BOX_WEAR				= 40 -- ���� �����ڽ�(40)
	declare @ITEM_SUBCATEGORY_BOX_PIECE			int					set @ITEM_SUBCATEGORY_BOX_PIECE				= 41 -- �ǻ� �����ڽ�(41)
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
	declare @ITEMCODE_COACH_ADVICE				int 				set @ITEMCODE_COACH_ADVICE					= 4601 	-- ���� �ڽ����� ��������.
	declare @ITEMCODE_DIRECTOR_ADVICE			int 				set @ITEMCODE_DIRECTOR_ADVICE				= 4602 	--

	------------------------------------------------
	--	2-3. ���λ�� ����
	------------------------------------------------
	declare @comment				varchar(512)		set @comment			= ''
	declare @gameid					varchar(20)			set @gameid				= ''
	declare @cashcost				int					set @cashcost			= 0
	declare @gamecost				int					set @gamecost			= 0
	declare @sid					int					set @sid				= -1
	declare @blockstate				int					set @blockstate			= @BLOCK_STATE_YES
	declare @templistidx1		 	int					set @templistidx1		= -1
	declare @templistidx2		 	int					set @templistidx2		= -1

	declare @itemcode				int					set @itemcode			= -1
	declare @cnt					int					set @cnt				= 0
	declare @randserial				varchar(20)			set @randserial			= '-1'
	declare @subcategory			int					set @subcategory		= -1

	declare	@invenkind				int					set @invenkind			= -1
	declare @rand					int					set @rand				= 0
	declare @randsum				int					set @randsum			= 0
	declare @itemcodenew			int					set @itemcodenew		= 0
	declare @listidxcust		 	int					set @listidxcust		= -1
	declare @listidxnew			 	int					set @listidxnew			= -1
	declare @listidxrtn 			int					set @listidxrtn			= -1
	declare @openstate				int					set @openstate 			= @BOX_OPEN_STATE_SUCCESS

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
	select 'DEBUG 1 �Է�����', @gameid_ gameid_, @password_ password_, @sid_ sid_, @listidx_ listidx_, @randserial_ randserial_

	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	select
		@gameid 		= gameid,			@blockstate		= blockstate,		@sid			= sid,
		@cashcost		= cashcost,			@gamecost		= gamecost,
		@templistidx1	= templistidx1, 	@templistidx2	= templistidx2,
		@randserial 	= randserial
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	select 'DEBUG 3-2 ��������', @gameid gameid, @blockstate blockstate, @sid sid, @cashcost cashcost, @gamecost gamecost, @randserial randserial

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
			select 'DEBUG ������', @listidx_ listidx_, @itemcode itemcode, @cnt cnt

			if( @itemcode != -1 )
				begin
					------------------------------------------------
					--  ������(tItemInfo) > ����
					------------------------------------------------
					select
						@subcategory 	= subcategory
					from dbo.tItemInfo
					where itemcode = @itemcode
					select 'DEBUG ������.', @itemcode itemcode, @subcategory subcategory
				end
		end

	------------------------------------------------
	-- 3-3. �� ���Ǻ� �б�
	------------------------------------------------
	if( @gameid = '' )
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR ���̵� �������� �ʴ´�.'
			select 'DEBUG ' + @comment
		END
	else if ( @blockstate = @BLOCK_STATE_YES )
		BEGIN
			-- �������ΰ�?
			set @nResult_ 	= @RESULT_ERROR_BLOCK_USER
			set @comment 	= '��ó���� ���̵��Դϴ�.'
			select 'DEBUG ', @comment
		END
	else if ( @sid_ != @sid )
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_SESSION_ID_EXPIRE_LOGOUT
			set @comment 	= 'ERROR ������ ���� �Ǿ����ϴ�. (�α׾ƿ� �����ּ���.)'
			select 'DEBUG ' + @comment
		END
	else if ( @itemcode = -1 )
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_ITEMCODE
			set @comment = 'ERROR �������� ã�� ���߽��ϴ�.(1)'
		END
	else if ( @subcategory not in (@ITEM_SUBCATEGORY_BOX_WEAR, @ITEM_SUBCATEGORY_BOX_PIECE, @ITEM_SUBCATEGORY_BOX_ADVICE, @ITEM_SUBCATEGORY_RANDOM_CASHCOST_BOX))
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_ITEMCODE
			set @comment = 'ERROR �������� ã�� ���߽��ϴ�.(2)'
		END
	else if ( @randserial_ = @randserial )
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS �ڽ��� �����߽��ϴ�.(�ߺ�)'

			insert into @tTempTable( listidx ) values( @templistidx1 )
			insert into @tTempTable( listidx ) values( @templistidx2 )

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
			select 'DEBUG ' + @comment

			if( @subcategory = @ITEM_SUBCATEGORY_BOX_WEAR )
				begin
					select 'DEBUG ���ڽ� ����'
				end
			else if( @subcategory = @ITEM_SUBCATEGORY_BOX_PIECE )
				begin
					select 'DEBUG �����ڽ� ����'
				end
			else if( @subcategory = @ITEM_SUBCATEGORY_BOX_ADVICE )
				begin
					select 'DEBUG 3 ������Ű���ڽ� ����'
					------------------------------------------------
					-- 3-1. ����ڽ� ���� Ȯ�� Ȯ��.
					--    7% -> ��ġ�� ���� �ֹ���(4601)
					--    3% -> ������ ���� �ֹ���(4602)
					--   90% -> ��.
					------------------------------------------------
					set @randsum 	= 100
					set @rand 		= dbo.fnu_GetRandom(0, @randsum)
					select 'DEBUG ', @randsum randsum, @rand rand
					if( @rand < 7 )
						begin
							select 'DEBUG ��ġ�� ����ȹ��'
							set @itemcodenew 	= @ITEMCODE_COACH_ADVICE
							set @openstate 		= @BOX_OPEN_STATE_SUCCESS
						end
					else if( @rand < (7+3) )
						begin
							select 'DEBUG ������ ����ȹ��'
							set @itemcodenew 	= @ITEMCODE_DIRECTOR_ADVICE
							set @openstate 		= @BOX_OPEN_STATE_SUCCESS
						end
					else
						begin
							select 'DEBUG ��'
							set @itemcodenew 	= -1
							set @openstate 		= @BOX_OPEN_STATE_FAIL
						end

					------------------------------------------------
					-- 3-2. ������ �����ϱ�.
					------------------------------------------------
					if( @itemcodenew != -1 )
						begin
							set @invenkind 	= dbo.fnu_GetInvenFromSubCategory(@ITEM_SUBCATEGORY_SCROLL_COMMISSION)
							select 'DEBUG ', @invenkind invenkind

							exec dbo.spu_ToUserItem @gameid_, @invenkind, @subcategory, @itemcodenew, 1, @DEFINE_HOW_GET_BOX_OPEN, @randserial_, @nResult2_ = @listidxrtn OUTPUT
							select 'DEBUG ����������', @gameid_ gameid_, @invenkind invenkind, @subcategory subcategory
						end
					select 'DEBUG ', @randsum randsum, @rand rand, @itemcodenew itemcodenew, @openstate openstate, @listidxrtn listidxrtn


					------------------------------------------------
					-- 3-4. �ڽ�����.
					------------------------------------------------
					insert into @tTempTable( listidx ) values( @listidx_ )
					insert into @tTempTable( listidx ) values( @listidxrtn )

				end
			else if( @subcategory = @ITEM_SUBCATEGORY_RANDOM_CASHCOST_BOX )
				begin
					select 'DEBUG ĳ���ڽ� ����'
				end

			------------------------------------------------
			-- �ڽ�����.
			------------------------------------------------
			select 'DEBUG ��������', @listidx_ listidx_
			update dbo.tUserItem
				set
					cnt = cnt - 1
			where gameid = @gameid and listidx = @listidx_

			------------------------------------------------
			-- ��������
			------------------------------------------------
			update dbo.tUserMaster
				set
					--cashcost		= @cashcost,		gamecost 		= @gamecost,
					templistidx1	= @listidx_, 	templistidx2		= @listidxrtn,
					randserial 		= @randserial_
			from dbo.tUserMaster
			where gameid = @gameid_
		END


	--------------------------------------------------------------
	-- �������.
	--------------------------------------------------------------
	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost, @openstate openstate


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

