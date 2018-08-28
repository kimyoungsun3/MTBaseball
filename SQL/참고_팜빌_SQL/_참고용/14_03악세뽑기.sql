---------------------------------------------------------------
/*
-- �Ǽ� �̱�
delete from dbo.tFVGiftList where gameid in ('xxxx2')
update dbo.tFVUserMaster set famelv = 1, cashcost = 1000 where gameid = 'xxxx2'
exec spu_FVRoulAcc 'xxxx2', '049000s1i0n7t8445289', -1	-- �Ǽ��̱�
*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVRoulAcc', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVRoulAcc;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_FVRoulAcc
	@gameid_				varchar(20),						-- ���Ӿ��̵�
	@password_				varchar(20),						-- ��ȣȭ�ؼ�����, �����н����� ��ŷ���ص� ����
	@nResult_				int					OUTPUT
	--WITH ENCRYPTION
as
	------------------------------------------------
	--	2-1. �ڵ尪
	------------------------------------------------
	-- �Ϲݰ�
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	-- �α��� ����.
	declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--������ > �˾�ó���� ��Ʈ�η� ��������.
	declare @RESULT_ERROR_DELETED_USER 			int				set @RESULT_ERROR_DELETED_USER			= -12			--�������� > �˾�ó���� ��Ʈ�η� ��������.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--�ش������� ã�� ����
	declare @RESULT_ERROR_NOT_FOUND_PASSWORD	int				set @RESULT_ERROR_NOT_FOUND_PASSWORD	= -17
	declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--������ �����ϰ� �ִ�.
	declare @RESULT_NEWVERION_CLIENT_DOWNLOAD 	int				set @RESULT_NEWVERION_CLIENT_DOWNLOAD	= -15			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ��ũó��.
	declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ����.

	-- �����߿� ����.
	declare @RESULT_ERROR_HEART_LACK			int				set @RESULT_ERROR_HEART_LACK			= -20			--��Ʈ�� �����ϴ�.
	declare @RESULT_ERROR_GAMECOST_LACK			int				set @RESULT_ERROR_GAMECOST_LACK			= -21			--�ǹ��� �����ϴ�.
	declare @RESULT_ERROR_CASHCOST_LACK			int				set @RESULT_ERROR_CASHCOST_LACK			= -22			--��尡 �����ϴ�.
	declare @RESULT_ERROR_ITEM_LACK				int				set @RESULT_ERROR_ITEM_LACK				= -23			--�������̺����ϴ�.

	-- ���� �ڵ尪
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- �������ڵ��ã��
	declare @RESULT_ERROR_GIFTITEM_NOT_FOUND	int				set @RESULT_ERROR_GIFTITEM_NOT_FOUND	= -51			-- ������������ ��ã��
	declare @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	int				set @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	= -52			-- ������ �̹� ������
	declare @RESULT_ERROR_NOT_FOUND_GIFTID		int				set @RESULT_ERROR_NOT_FOUND_GIFTID		= -75			-- ĳ�� > ������ ���̵� ��ã��

	-- ��Ÿ����
	declare @RESULT_ERROR_RESULT_COPY			int				set @RESULT_ERROR_RESULT_COPY			= -53			-- ���ī�ǽõ�
	declare @RESULT_ERROR_GAMECOST_COPY			int				set @RESULT_ERROR_GAMECOST_COPY			= -54			-- �ǹ�ī�ǽõ�
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- ���������ʴ¸��
	declare @RESULT_ERROR_HEART_FULL			int				set @RESULT_ERROR_HEART_FULL			= -71			-- ���������ʴ¸��
	declare @RESULT_ERROR_TUTORIAL_ALREADY		int				set @RESULT_ERROR_TUTORIAL_ALREADY		= -73			-- ���丮�� �̹� ����.
	declare @RESULT_ERROR_NOT_FOUND_OTHERID		int				set @RESULT_ERROR_NOT_FOUND_OTHERID		= -83
	declare @RESULT_ERROR_INVEN_FULL			int				set @RESULT_ERROR_INVEN_FULL			= -101			-- �κ�����
	declare @RESULT_ERROR_NOT_MATCH				int				set @RESULT_ERROR_NOT_MATCH				= -110			-- �����ΰ� ��ġ�� �ȵǾ���.
	declare @RESULT_ERROR_DOUBLE_RANDSERIAL		int				set @RESULT_ERROR_DOUBLE_RANDSERIAL		= -111			-- �����ø��� �ߺ�.
	declare @RESULT_ERROR_MAXCOUNT				int				set @RESULT_ERROR_MAXCOUNT				= -112			-- �ƽ�ī����.
	declare @RESULT_ERROR_ITEMCOST_WRONG		int				set @RESULT_ERROR_ITEMCOST_WRONG		= -113			-- ������ ������ �̻���.
	declare @RESULT_ERROR_LISTIDX_NOT_FOUND		int				set @RESULT_ERROR_LISTIDX_NOT_FOUND		= -114			-- ����Ʈ ��ȣ�� ��ã��.
	declare @RESULT_ERROR_NO_MORE_ACC			int				set @RESULT_ERROR_NO_MORE_ACC			= -134			-- ���̻� ���� ����.

	------------------------------------------------
	--	2-2. ���ǵȰ�
	------------------------------------------------
	-- ������ �Һз�
	declare @ITEM_SUBCATEGORY_ACC				int					set @ITEM_SUBCATEGORY_ACC 					= 15 -- �Ǽ�	(�Ǹ�[O], ����[O])

	-- ���� ���ǰ�
	declare @GIFTLIST_GIFT_KIND_MESSAGE			int					set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2

	-- ������ ȹ����
	declare @DEFINE_HOW_GET_ROULACC				int					set @DEFINE_HOW_GET_ROULACC					= 9	--�Ǽ��̱�

	-- �Ǽ� �̱�
	declare @ROUL_ACC_ITEMCODE					int					set @ROUL_ACC_ITEMCODE 						= 50001 	-- �Ǽ��縮�̱��ڵ��ȣ.

	------------------------------------------------
	--	2-3. ���λ�� ����
	------------------------------------------------
	declare @comment		varchar(80)
	declare @gameid			varchar(60)		set @gameid			= ''	-- ��������.
	declare @cashcost		int				set @cashcost 		= 0
	declare @gamecost		int				set @gamecost 		= 0
	declare @feed			int				set @feed 			= 0
	declare @heart			int				set @heart 			= 0
	declare @fpoint			int				set @fpoint 		= 0
	declare @famelv			int				set @famelv 		= 1

	declare @itemcode		int				set @itemcode		= -1
	declare @itemcode1		int				set @itemcode1		= -1
	declare @itemcode2		int				set @itemcode2		= -1
	declare @itemcode3		int				set @itemcode3		= -1
	declare @itemcode4		int				set @itemcode4		= -1
	declare @itemcode5		int				set @itemcode5		= -1

	declare @rand			int,
			@cnt			int,
			@accmax			int,
			@accrand		int,
			@loop			int

	-- �Ǽ� �̱� ��������
	declare @roulaccprice	int				set @roulaccprice 	= 10 -- 10����.
	declare @roulaccsale	int				set @roulaccsale 	= 10 -- 10%.
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	set @comment  = '�˼� ���� ������ �߻��߽��ϴ�.'
	--select 'DEBUG 3-1 �Է°�', @gameid_ gameid_, @password_ password_

	------------------------------------------------
	--	3-2. �������(��������, ��������, ������ ����)
	------------------------------------------------
	select
		@gameid 		= gameid,
		@cashcost		= cashcost,
		@gamecost		= gamecost,
		@feed			= feed,
		@heart			= heart,
		@fpoint			= fpoint,
		@famelv			= famelv
	from dbo.tFVUserMaster where gameid = @gameid_ and password = @password_
	--select 'DEBUG 3-2 ��������', @gameid gameid, @cashcost cashcost, @famelv famelv

	-- �Ǽ����� �����
	select top 1
		@roulaccprice 	= roulaccprice,
		@roulaccsale	= roulaccsale
	from dbo.tFVSystemInfo order by idx desc

	set @roulaccprice = @roulaccprice - (@roulaccprice * @roulaccsale)/100

	------------------------------------------------
	--	3-3. ����Ȳ���� �ڵ�� �з�
	------------------------------------------------
	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR ���̵� �������� �ʴ´�.'
			--select 'DEBUG 4' + @comment
		END
	else if(@cashcost < @roulaccprice)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_CASHCOST_LACK
			set @comment 	= 'ERROR ĳ���� �����մϴ�.'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS [�̱� > NEW]���� ���� ó���մϴ�.'
			--select 'DEBUG ' + @comment

			-----------------------------------------------------
			-- �ӽ����̺� ���� > �Է�.
			-----------------------------------------------------
			DECLARE @tTempTable TABLE(
				itemcode		int,
				accper			int,
				accmin			int,
				accmax			int
			);

			insert into @tTempTable
			select itemcode, CAST(param7 as int), CAST(param8 as int), CAST(param9 as int) from dbo.tFVItemInfo
			where subcategory = @ITEM_SUBCATEGORY_ACC and playerlv <= @famelv
			order by playerlv asc
			--select 'DEBUG ', * from @tTempTable

			-- �Էµ� �� �߿��� �ְ�.
			select @accmax = max(accmax) from @tTempTable

			-----------------------------------------------------
			-- �̱ⰳ��.
			-----------------------------------------------------
			set @rand 	= Convert(int, ceiling(RAND() * 1000))
			set @cnt	= case
								when @rand < 600 then 2
								when @rand < 900 then 3
								when @rand < 980 then 4
								else				  5
						  end
			--select 'DEBUG �̱ⰳ��', @rand rand, @cnt cnt, @accmax accmax

			-----------------------------------------------------
			-- ���� > �������
			-----------------------------------------------------
			set @loop = 0
			while(@loop < @cnt)
				begin
					-- ���� > ����(0 <= x < 100)
					set @accrand 	= Convert(int, ceiling(RAND() * (@accmax )))

					select @itemcode = itemcode from @tTempTable
					where accmin <= @accrand and @accrand < accmax

					--select 'DEBUG [�̱���]', @itemcode itemcode, @accmax accmax, @accrand accrand

					if(@loop = 0)
						begin
							--select 'DEBUG 1������', @itemcode itemcode
							set @itemcode1 = @itemcode
						end
					else if(@loop = 1)
						begin
							--select 'DEBUG 2������', @itemcode itemcode
							set @itemcode2 = @itemcode
						end
					else if(@loop = 2)
						begin
							--select 'DEBUG 3������', @itemcode itemcode
							set @itemcode3 = @itemcode
						end
					else if(@loop = 3)
						begin
							--select 'DEBUG 4������', @itemcode itemcode
							set @itemcode4 = @itemcode
						end
					else if(@loop = 4)
						begin
							--select 'DEBUG 5������', @itemcode itemcode
							set @itemcode5 = @itemcode
						end

					set @loop = @loop + 1
				end

			------------------------------------------------------------------
			-- �̱⸦ �����Կ� �־��ֱ�.
			------------------------------------------------------------------
			--select 'DEBUG �̱� ��������(������ �ڵ����� �н���)', @itemcode1 itemcode1, @itemcode2 itemcode2, @itemcode3 itemcode3, @itemcode4 itemcode4, @itemcode5 itemcode5
			exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @itemcode1, 'SysAcc', @gameid_, ''
			exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @itemcode2, 'SysAcc', @gameid_, ''
			exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @itemcode3, 'SysAcc', @gameid_, ''
			exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @itemcode4, 'SysAcc', @gameid_, ''
			exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @itemcode5, 'SysAcc', @gameid_, ''

			------------------------------------------------------------------
			-- ĳ������ > �ϴܿ��� ����.
			------------------------------------------------------------------
			--select 'DEBUG [�Ǽ��̱�]ĳ������(��)', @cashcost cashcost
			set @cashcost = @cashcost - @roulaccprice
			--select 'DEBUG [�Ǽ��̱�]ĳ������(��)', @cashcost cashcost

			--------------------------------
			-- ���ű�ϸ�ŷ
			--------------------------------
			exec spu_FVUserItemBuyLog @gameid_, @ROUL_ACC_ITEMCODE, 0, @roulaccprice


			--------------------------------
			-- ��������ڷ�.
			--------------------------------
			exec spu_FVUserItemAccLog @gameid_, @famelv, @roulaccprice, 0, @itemcode1, @itemcode2, @itemcode3, @itemcode4, @itemcode5

		END




	--------------------------------------------------------------
	-- 	�������
	--------------------------------------------------------------
	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost, @feed feed, @heart heart, @fpoint fpoint, @itemcode1 itemcode1, @itemcode2 itemcode2, @itemcode3 itemcode3, @itemcode4 itemcode4, @itemcode5 itemcode5

	if(@nResult_ = @RESULT_SUCCESS)
		begin
			--------------------------------------------------------------
			-- �������� ���� �־���
			--------------------------------------------------------------
			update dbo.tFVUserMaster
			set
				cashcost	= @cashcost
			where gameid = @gameid_

			--------------------------------------------------------------
			-- ����/���� ����Ʈ ����
			--------------------------------------------------------------
			exec spu_FVGiftList @gameid_
		end

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off
End

