/*
delete from dbo.tFVTutoStep where gameid = 'xxxx3'
delete from dbo.tFVGiftList where gameid = 'xxxx3'
update dbo.tFVUserMaster set gamecost = 0, cashcost = 0, feed = 0, heart = 0, fpoint = 0 where gameid = 'xxxx3'
exec spu_FVTutoStep 'xxxx3', '049000s1i0n7t8445289', 5500, -1, -1	-- Ʃ�丮�� ��ŷ
exec spu_FVTutoStep 'xxxx3', '049000s1i0n7t8445289', 5501, -1, -1	--
exec spu_FVTutoStep 'xxxx3', '049000s1i0n7t8445289', 5502, -1, -1	--
exec spu_FVTutoStep 'xxxx3', '049000s1i0n7t8445289', 5503, -1, -1	--
exec spu_FVTutoStep 'xxxx3', '049000s1i0n7t8445289', 5504, -1, -1	--
exec spu_FVTutoStep 'xxxx3', '049000s1i0n7t8445289', 5505, -1, -1	--
*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVTutoStep', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVTutoStep;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_FVTutoStep
	@gameid_								varchar(60),
	@password_								varchar(20),
	@tutostep_								int,
	@ispass_								int,
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
	declare @RESULT_ERROR_DAILY_REWARD_ALREADY	int				set @RESULT_ERROR_DAILY_REWARD_ALREADY	= -102			-- ���Ϻ��� �̹� ����.
	declare @RESULT_ERROR_NOT_FOUND_DOGAMIDX	int				set @RESULT_ERROR_NOT_FOUND_DOGAMIDX	= -103			-- ������ȣ�� ã���� ����.
	declare @RESULT_ERROR_DOGAM_ALREADY_REWARD	int				set @RESULT_ERROR_DOGAM_ALREADY_REWARD	= -104			-- ������ �̹� ��������.
	declare @RESULT_ERROR_DOGAM_LACK			int				set @RESULT_ERROR_DOGAM_LACK			= -105			-- �����߿� ������ȣ�� ������.
	------------------------------------------------
	--	2-2. ���°�
	------------------------------------------------
	-- ������ �Һз�
	declare @ITEM_SUBCATEGORY_TUTORIAL			int					set @ITEM_SUBCATEGORY_TUTORIAL 				= 55 -- Ʃ�丮��(55)

	-- ���� ���ǰ�
	declare @GIFTLIST_GIFT_KIND_MESSAGE			int					set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2
	declare @GIFTLIST_GIFT_KIND_MESSAGE_DEL		int					set @GIFTLIST_GIFT_KIND_MESSAGE_DEL			= -1
	declare @GIFTLIST_GIFT_KIND_GIFT_DEL		int					set @GIFTLIST_GIFT_KIND_GIFT_DEL			= -2
	declare @GIFTLIST_GIFT_KIND_GIFT_GET		int					set @GIFTLIST_GIFT_KIND_GIFT_GET			= -3
	declare @GIFTLIST_GIFT_KIND_GIFT_SELL		int					set @GIFTLIST_GIFT_KIND_GIFT_SELL			= -4

	-- Ʃ�丮�� ���°�.
	declare @TUTOSTEP_ISPASS_PASS				int					set @TUTOSTEP_ISPASS_PASS					=  1		--  1:�н�.
	declare @TUTOSTEP_ISPASS_MARK				int					set @TUTOSTEP_ISPASS_MARK					= -1		-- -1:�������� or �ϷẸ��.

	-- bool
	declare @BOOL_TRUE							int					set @BOOL_TRUE						= 1
	declare @BOOL_FALSE							int					set @BOOL_FALSE						= 0

	declare @INIT_VALUE							int					set @INIT_VALUE								= -555
	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @gameid 				varchar(60)			set @gameid			= ''
	declare @cashcost				int					set @cashcost			= 0
	declare @gamecost				int					set @gamecost			= 0
	declare @feed					int					set @feed				= 0
	declare @heart					int					set @heart				= 0
	declare @fpoint					int					set @fpoint				= 0

	declare @gameyear				int					set @gameyear			= -1
	declare @gamemonth				int					set @gamemonth			= -1
	declare @famelv					int					set @famelv				= -1

	declare @rewardkind				int					set @rewardkind 		= -1
	declare @rewardvalue			int					set @rewardvalue		= 0
	declare @brewardwrite			int					set @brewardwrite		= @BOOL_TRUE

	declare @brecord				int					set @brecord			= -1

	declare @comment				varchar(512)
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG �Է�����', @gameid_ gameid_, @password_ password_, @tutostep_ tutostep_, @ispass_ ispass_

	------------------------------------------------
	--	3-2. �������(��������)
	------------------------------------------------
	select
		@gameid 		= gameid,
		@cashcost		= cashcost,
		@gamecost		= gamecost,
		@heart			= heart,
		@feed			= feed,
		@fpoint			= fpoint,

		@gameyear 		= gameyear,
		@gamemonth 		= gamemonth,
		@famelv 		= famelv
	from dbo.tFVUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG ��������', @gameid gameid, @cashcost cashcost, @gamecost gamecost, @heart heart, @feed feed, @fpoint fpoint, @gameyear gameyear, @gamemonth gamemonth, @famelv famelv

	------------------------------------------------
	--	3-2. ȹ�渮��Ʈ�� ���� ������ ��ġ�����ľ�.
	-- 		 > �����ۿ� ���翩�� �ľ��ϱ�.
	------------------------------------------------
	select
		@rewardkind 	= param1,
		@rewardvalue 	= param2
	from dbo.tFVItemInfo
	where itemcode = @tutostep_ and subcategory = @ITEM_SUBCATEGORY_TUTORIAL
	--select 'DEBUG Ʃ�丮���� ������', @rewardkind rewardkind, @rewardvalue rewardvalue

	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '���̵� �������� �ʴ´�.'
			--select 'DEBUG ', @comment
		END
	else if(@tutostep_ != -1 and exists(select top 1 * from dbo.tFVTutoStep where gameid = @gameid_ and itemcode = @tutostep_))
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_TUTORIAL_ALREADY
			set @comment 	= 'DEBUG �̹� �����ߴ�.'
			--select 'DEBUG ', @comment
		END
	else if(@tutostep_ != -1 and @rewardkind = -1)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_ITEMCODE
			set @comment 	= 'Ʃ�丮���� ��ȣ�� ������Ѵ�.'
			--select 'DEBUG ', @comment
		END
	else if(@ispass_ = @TUTOSTEP_ISPASS_PASS)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'DEBUG Ʃ�丮���� �н��մϴ�.'
			--select 'DEBUG ', @comment

			if(@tutostep_ = -1)
				begin
					set @brewardwrite 	= @BOOL_FALSE
				end
			else
				begin
					set @brewardwrite 	= @BOOL_TRUE
				end
			set @brecord		= 1
		END
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'DEBUG ���������մϴ�.'
			--select 'DEBUG ', @comment

			--����(0)
			--ĳ��(1)
			--��Ʈ(2)
			--����(3)
			--��������Ʈ(4)
			--�������ڵ�(5)
			if(@tutostep_ = -1)
				begin
					set @brewardwrite = @BOOL_FALSE
					--select 'DEBUG �ܼ��ʱ�ȭ����', @rewardvalue
				end
			else if(@rewardkind = 0)
				begin
					set @gamecost = @gamecost + @rewardvalue
					--select 'DEBUG ��������', @rewardvalue
				end
			else if(@rewardkind = 1)
				begin
					set @cashcost = @cashcost + @rewardvalue
					--select 'DEBUG ĳ������', @rewardvalue
				end
			else if(@rewardkind = 2)
				begin
					set @heart = @heart + @rewardvalue
					--select 'DEBUG ��Ʈ����', @rewardvalue
				end
			else if(@rewardkind = 3)
				begin
					set @feed = @feed + @rewardvalue
					--select 'DEBUG ��������', @rewardvalue
				end
			else if(@rewardkind = 4)
				begin
					set @fpoint = @fpoint + @rewardvalue
					--select 'DEBUG ��������Ʈ', @rewardvalue
				end
			else if(@rewardkind = 5)
				begin
					if(exists(select top 1 * from dbo.tFVItemInfo where itemcode = @rewardvalue))
						begin
							exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT, @rewardvalue, 'SysTut', @gameid_, ''				-- Ư�������� ����
						end
					--select 'DEBUG �������ڵ�', @rewardvalue
				end

			set @brecord	= 1
		END

	if(@nResult_ = @RESULT_SUCCESS and @brecord	= 1)
		BEGIN
			--------------------------------------------------------------
			--	���� ���(������ �˻���)
			--------------------------------------------------------------
			if(@brewardwrite = @BOOL_TRUE)
				begin
					insert into dbo.tFVTutoStep(gameid,   itemcode,          ispass,                           gameyear,  gamemonth,  famelv)
					values(                  @gameid_, @tutostep_, isnull(@ispass_, @TUTOSTEP_ISPASS_MARK), @gameyear, @gamemonth, @famelv)
				end
		END


	select @nResult_ rtn, @comment comment
	if(@nResult_ = @RESULT_SUCCESS)
		BEGIN
			--------------------------------------------------------------
			--	�������
			--------------------------------------------------------------
			update dbo.tFVUserMaster
				set
					cashcost		= @cashcost,
					gamecost		= @gamecost,
					heart			= @heart,
					feed			= @feed,
					fpoint			= @fpoint
			where gameid = @gameid_


			--------------------------------------------------------------
			--	��������.
			--------------------------------------------------------------
			select @rewardkind rewardkind, @rewardvalue rewardvalue,  * from dbo.tFVUserMaster where gameid = @gameid_

			--------------------------------------------------------------
			--	������.
			--------------------------------------------------------------
			exec spu_FVGiftList @gameid_
		END

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off
End



