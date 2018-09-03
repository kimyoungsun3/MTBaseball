/*
delete from dbo.tGiftList where gameid = 'xxxx2'
update dbo.tUserMaster set cashcost = 1000, randserial = -1 where gameid = 'xxxx2'
exec spu_PackBuy 'xxxx2', '049000s1i0n7t8445289', 1, 7777, -1			-- ��������
*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_PackBuy', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_PackBuy;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_PackBuy
	@gameid_								varchar(20),					-- ���Ӿ��̵�
	@password_								varchar(20),					--
	@idx_									int,							--
	@randserial_							varchar(20),					--
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
	------------------------------------------------
	--	2-2. ���°�
	------------------------------------------------
	-- ���� ���ǰ�
	declare @GIFTLIST_GIFT_KIND_MESSAGE			int					set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2
	declare @GIFTLIST_GIFT_KIND_MESSAGE_DEL		int					set @GIFTLIST_GIFT_KIND_MESSAGE_DEL			= -1
	declare @GIFTLIST_GIFT_KIND_GIFT_DEL		int					set @GIFTLIST_GIFT_KIND_GIFT_DEL			= -2
	declare @GIFTLIST_GIFT_KIND_GIFT_GET		int					set @GIFTLIST_GIFT_KIND_GIFT_GET			= -3
	declare @GIFTLIST_GIFT_KIND_GIFT_SELL		int					set @GIFTLIST_GIFT_KIND_GIFT_SELL			= -4


	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @comment				varchar(512)
	declare @gameid					varchar(20)		set @gameid				= ''
	declare @cashcost				int				set @cashcost			= 0
	declare @gamecost				int				set @gamecost 			= 0
	declare @heart					int				set @heart 				= 0
	declare @feed					int				set @feed 				= 0
	declare @randserial				varchar(20)		set @randserial			= ''
	declare @itemcode				int				set @itemcode			= -1
	declare @pack1					int				set @pack1				= -1
	declare @pack2					int				set @pack2				= -1
	declare @pack3					int				set @pack3				= -1
	declare @pack4					int				set @pack4				= -1
	declare @pack5					int				set @pack5				= -1
	declare @cashcostsale		int				set @cashcostsale	= 99999

Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG �Է�����', @gameid_ gameid_, @password_ password_, @idx_ idx_, @randserial_ randserial_

	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	select
		@gameid 		= gameid,
		@randserial		= randserial,
		@cashcost		= cashcost,
		@gamecost		= gamecost,
		@heart			= heart,
		@feed			= feed
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG ��������', @gameid gameid, @cashcost cashcost, @gamecost gamecost, @heart heart, @feed feed, @randserial randserial

	select
		@itemcode = itemcode,
		@pack1 = pack1,		@pack2 = pack2,		@pack3 = pack3,
		@pack4 = pack4,		@pack5 = pack5,		@cashcostsale = cashcostsale
	from dbo.tSystemPack where idx = @idx_
	--select 'DEBUG ��������', @pack1 pack1, @pack2 pack2, @pack3 pack3, @pack4 pack4, @pack5 pack5, @cashcostsale cashcostsale

	------------------------------------------------
	--	3-3. ����Ȳ���� �ڵ�� �з�
	------------------------------------------------
	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR ���̵� �������� �ʴ´�.'
			--select 'DEBUG ' + @comment
		END
	else if (@itemcode = -1)
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_ITEMCODE
			set @comment = 'ERROR �ڵ带 ã���� �����ϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if (@cashcost < @cashcostsale)
		BEGIN
			set @nResult_ = @RESULT_ERROR_CASHCOST_LACK
			set @comment = 'ERROR ĳ���� �����մϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if (@randserial_ = @randserial)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '��Ű�� �����ϱ�(2)'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '��Ű�� �����ϱ�'
			--select 'DEBUG ', @comment

			------------------------------------------------------------------
			-- ��Ű���� �����Կ� �־��ֱ�.
			------------------------------------------------------------------
			--select 'DEBUG ��Ű�� ��������(������ �ڵ����� �н���)', @pack1 pack1, @pack2 pack2, @pack3 pack3, @pack4 pack4, @pack5 pack5
			exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT,  @pack5, 0, 'SysPack', @gameid_, ''
			exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT,  @pack4, 0, 'SysPack', @gameid_, ''
			exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT,  @pack3, 0, 'SysPack', @gameid_, ''
			exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT,  @pack2, 0, 'SysPack', @gameid_, ''
			exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT,  @pack1, 0, 'SysPack', @gameid_, ''

			-- ��Ű�����Ź�ȣ.
			exec spu_UserItemBuyLogNew @gameid_, @itemcode, 0, @cashcostsale, 0

			-- ĳ�� or �������� > �ϴܿ��� ������.
			set @cashcost = @cashcost - @cashcostsale
		END

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------

	if(@nResult_ = @RESULT_SUCCESS)
		begin
			-- �������� ���� �־���
			update dbo.tUserMaster
			set
				randserial	= @randserial_,
				cashcost	= @cashcost,
				gamecost	= @gamecost,
				heart		= @heart,
				feed		= @feed
			where gameid = @gameid_

			--------------------------------------------------------------
			-- �ڵ�(ĳ��, ����, ��Ʈ, ����)
			--------------------------------------------------------------
			select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost, @heart heart, @feed feed

			--------------------------------------------------------------
			-- ����/���� ����Ʈ ����
			--------------------------------------------------------------
			exec spu_GiftList @gameid_
		end
	else
		begin
			select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost, @heart heart, @feed feed
		end

	set nocount off
End



