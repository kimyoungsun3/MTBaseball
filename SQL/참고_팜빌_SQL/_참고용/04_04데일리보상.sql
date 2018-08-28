/*
exec spu_FVDailyReward 'xxxx2', '049000s1i0n7t8445289', -1			-- ��������
*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVDailyReward', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVDailyReward;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_FVDailyReward
	@gameid_								varchar(60),					-- ���Ӿ��̵�
	@password_								varchar(20),					--
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

	-- ��Ÿ����
	declare @RESULT_ERROR_RESULT_COPY			int				set @RESULT_ERROR_RESULT_COPY			= -53			-- ���ī�ǽõ�
	declare @RESULT_ERROR_GAMECOST_COPY			int				set @RESULT_ERROR_GAMECOST_COPY			= -54			-- �ǹ�ī�ǽõ�
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- ���������ʴ¸��
	declare @RESULT_ERROR_HEART_FULL			int				set @RESULT_ERROR_HEART_FULL			= -71			-- ���������ʴ¸��
	declare @RESULT_ERROR_TUTORIAL_ALREADY		int				set @RESULT_ERROR_TUTORIAL_ALREADY		= -73			-- ���丮�� �̹� ����.
	declare @RESULT_ERROR_NOT_FOUND_OTHERID		int				set @RESULT_ERROR_NOT_FOUND_OTHERID		= -83
	declare @RESULT_ERROR_INVEN_FULL			int				set @RESULT_ERROR_INVEN_FULL			= -101			-- �κ�����
	declare @RESULT_ERROR_DAILY_REWARD_ALREADY	int				set @RESULT_ERROR_DAILY_REWARD_ALREADY	= -102			-- ���Ϻ��� �̹� ����.

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

	-- ���ϸ����� �������ڵ�.
	declare @DAILY_REWARD_ONE_ITEMCODE			int				set @DAILY_REWARD_ONE_ITEMCODE			= 900			--10����(900)
	declare @DAILY_REWARD_TWO_ITEMCODE			int				set @DAILY_REWARD_TWO_ITEMCODE			= 5111			--10����(5111)
	declare @DAILY_REWARD_THREE_ITEMCODE		int				set @DAILY_REWARD_THREE_ITEMCODE		= 5112			--30����(5112)
	declare @DAILY_REWARD_FOUR_ITEMCODE			int				set @DAILY_REWARD_FOUR_ITEMCODE			= 5113			--50����(5113)
	declare @DAILY_REWARD_FIVE_ITEMCODE			int				set @DAILY_REWARD_FIVE_ITEMCODE			= 5007			--5ĳ��(5007)

	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @gameid 				varchar(60)
	declare @attenddate				datetime,
			@attendcnt				int
	declare @comment				varchar(512)

Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG �Է�����', @gameid_ gameid_, @password_ password_

	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	select
		@gameid 		= gameid,
		@attenddate 	= attenddate, 			@attendcnt 	= attendcnt
	from dbo.tFVUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG ��������', @gameid gameid, @attenddate attenddate, @attendcnt attendcnt


	if(isnull(@gameid, '') = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '���ϸ� ���� ���̵� �������� �ʴ´�. > ���̵� Ȯ���ض�.'
			--select 'DEBUG ', @comment
		END
	else if (@attendcnt <= 0)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_DAILY_REWARD_ALREADY
			set @comment 	= '���ϸ� ���� �̹� �����ߴ�.'
			--select 'DEBUG ', @comment
		END
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '���ϸ� ���� ����ó��'
			--select 'DEBUG ', @comment

			------------------------------------------------------------------
			-- �����ؼ� �����Կ� �־��ֱ�
			------------------------------------------------------------------
			if(@attendcnt = 1)
				begin
					--select 'DEBUG 1�Ϻ���'
					exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @DAILY_REWARD_ONE_ITEMCODE, 'DailyReward', @gameid_, '1�Ϻ���'
				end
			else if(@attendcnt = 2)
				begin
					--select 'DEBUG 2�Ϻ���'
					exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @DAILY_REWARD_TWO_ITEMCODE, 'DailyReward', @gameid_, '2�Ϻ���'
				end
			else if(@attendcnt = 3)
				begin
					--select 'DEBUG 3�Ϻ���'
					exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @DAILY_REWARD_THREE_ITEMCODE, 'DailyReward', @gameid_, '3�Ϻ���'
				end
			else if(@attendcnt = 4)
				begin
					--select 'DEBUG 4�Ϻ���'
					exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @DAILY_REWARD_FOUR_ITEMCODE, 'DailyReward', @gameid_, '4�Ϻ���'
				end
			else if(@attendcnt >= 5)
				begin
					--select 'DEBUG 5�Ϻ���'
					exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @DAILY_REWARD_FIVE_ITEMCODE, 'DailyReward', @gameid_, '5�Ϻ���'
				end

			------------------------------------------------------------------
			-- �����ʱ�ȭ(0)
			------------------------------------------------------------------
			update dbo.tFVUserMaster set attendcnt = 0 where gameid = @gameid_
		END

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	select @nResult_ rtn, @comment comment

	--------------------------------------------------------------
	-- ����/���� ����Ʈ ����
	--------------------------------------------------------------
	exec spu_FVGiftList @gameid_

	set nocount off
End



