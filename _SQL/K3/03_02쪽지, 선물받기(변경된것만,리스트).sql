use Game4FarmVill3
GO

/*
exec spu_FVGiftGain 'farm60142592', '2691871m3r2c5r237243', -3,  733181, -1		-- ����ǰ


exec spu_FVGiftGain 'xxxx2', '049000s1i0n7t8445289', -1,  1, -1		-- �����ޱ�(����)
exec spu_FVGiftGain 'xxxx2', '049000s1i0n7t8445289', -3,  2, -1		-- ����ǰ
exec spu_FVGiftGain 'xxxx2', '049000s1i0n7t8445289', -3,  3, -1		-- ����

exec spu_FVGiftGain 'xxxx2', '049000s1i0n7t8445289', -5, -1, -1		-- ����Ʈ����
*/
IF OBJECT_ID ( 'dbo.spu_FVGiftGain', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVGiftGain;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_FVGiftGain
	@gameid_				varchar(60),						-- ���Ӿ��̵�
	@password_				varchar(20),						--
	@giftkind_				int,								--  1:�޽���
																--  2:����
																-- -1:�޽�������
																-- -2:��������
																-- -3:�����޾ư�
	@idx_					bigint,								-- �����ε���
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
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--�ش������� ã�� ����

	-- ���� �ڵ尪
	declare @RESULT_ERROR_GIFTITEM_NOT_FOUND	int				set @RESULT_ERROR_GIFTITEM_NOT_FOUND	= -51			-- ������������ ��ã��
	declare @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	int				set @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	= -52			-- ������ �̹� ������

	-- ��Ÿ����
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- ���������ʴ¸��

	------------------------------------------------
	--	2-2. ���ǵȰ�
	------------------------------------------------
	-- ���� ���ǰ�
	declare @GIFTLIST_GIFT_KIND_MESSAGE			int					set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2
	declare @GIFTLIST_GIFT_KIND_MESSAGE_DEL		int					set @GIFTLIST_GIFT_KIND_MESSAGE_DEL			= -1
	declare @GIFTLIST_GIFT_KIND_GIFT_DEL		int					set @GIFTLIST_GIFT_KIND_GIFT_DEL			= -2
	declare @GIFTLIST_GIFT_KIND_GIFT_GET		int					set @GIFTLIST_GIFT_KIND_GIFT_GET			= -3
	declare @GIFTLIST_GIFT_KIND_GIFT_SELL		int					set @GIFTLIST_GIFT_KIND_GIFT_SELL			= -4
	declare @GIFTLIST_GIFT_KIND_LIST			int					set @GIFTLIST_GIFT_KIND_LIST				= -5

	------------------------------------------------
	--	2-3. ���λ�� ����
	------------------------------------------------
	declare @comment		varchar(80)
	declare @gameid 		varchar(60)			set @gameid			= ''
	declare @itemcode		int					set @itemcode		= -1
	declare @cnt			bigint				set @cnt			= 0
	declare @giftkind		int					set @giftkind 		= -1
	declare @subcategory 	int
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	set @comment  = '�˼� ���� ������ �߻��߽��ϴ�.'
	--select 'DEBUG 3-1-1 �Է°�', @gameid_ gameid_, @password_ password_, @giftkind_ giftkind_, @idx_ idx_

	------------------------------------------------
	--	3-2. �������(��������, ��������, ������ ����)
	------------------------------------------------
	select
		@gameid 		= gameid
	from dbo.tFVUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 3-2-1 ��������', @gameid gameid

	select
		@giftkind 	= giftkind,
		@itemcode 	= itemcode,
		@cnt		= cnt
	from dbo.tFVGiftList where gameid = @gameid_ and idx = @idx_
	--select 'DEBUG 3-2-2 ����/����', @giftkind giftkind, @itemcode itemcode, @cnt cnt

	------------------------------------------------
	--	3-3. ����Ȳ���� �ڵ�� �з�
	------------------------------------------------
	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR ���̵� �������� �ʴ´�.'
			--select 'DEBUG ' + @comment
		END
	else if(@giftkind_ = @GIFTLIST_GIFT_KIND_LIST)
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS ���� ����Ʈ ����.'
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

			update dbo.tFVGiftList set giftkind = @giftkind_ where idx = @idx_
		END
	else if(@giftkind_ = @GIFTLIST_GIFT_KIND_GIFT_DEL)
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS ���� ���� ó���մϴ�.'
			----select 'DEBUG ' + @comment

			update dbo.tFVGiftList set giftkind = @giftkind_ where idx = @idx_
		END
	else if(@giftkind_ = @GIFTLIST_GIFT_KIND_GIFT_GET)
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS ���� ���� ó���մϴ�.'

			update dbo.tFVGiftList set giftkind = @GIFTLIST_GIFT_KIND_GIFT_GET, gaindate = getdate() where idx = @idx_
		END

	------------------------------------------------
	--	3-2. ������ �������ش�.
	------------------------------------------------
	if(@nResult_ != @RESULT_SUCCESS)
		BEGIN
			set @itemcode 	= -1
			set @cnt 		= 0
		END

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off

	--------------------------------------------------------------
	-- ���
	--------------------------------------------------------------
	select @nResult_ rtn, @comment comment, @itemcode itemcode, @cnt cnt

	if(@nResult_ = @RESULT_SUCCESS)
		begin
			--------------------------------------------------------------
			-- ����/���� ����Ʈ ����
			--------------------------------------------------------------
			exec spu_FVGiftList @gameid_
		end

End

