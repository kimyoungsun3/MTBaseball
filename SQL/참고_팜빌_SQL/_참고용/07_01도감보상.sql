/*
select * from dbo.tFVDogamList where gameid = 'xxxx' order by itemcode asc
select * from dbo.tFVDogamReward where gameid = 'xxxx' order by dogamidx asc

exec spu_FVDogamReward 'xxxx', '049000s1i0n7t8445289', 1, -1	-- �̹�����
exec spu_FVDogamReward 'xxxx', '049000s1i0n7t8445289', 2, -1	-- ���Ǹ���
exec spu_FVDogamReward 'xxxx', '049000s1i0n7t8445289', 3, -1	-- ����
*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVDogamReward', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVDogamReward;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_FVDogamReward
	@gameid_								varchar(60),
	@password_								varchar(20),
	@dogamidx_								int,
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
	declare @RESULT_ERROR_NOT_FOUND_DOGAMIDX	int				set @RESULT_ERROR_NOT_FOUND_DOGAMIDX	= -103			-- ������ȣ�� ã���� ����.
	declare @RESULT_ERROR_DOGAM_ALREADY_REWARD	int				set @RESULT_ERROR_DOGAM_ALREADY_REWARD	= -104			-- ������ �̹� ��������.
	declare @RESULT_ERROR_DOGAM_LACK			int				set @RESULT_ERROR_DOGAM_LACK			= -105			-- �����߿� ������ȣ�� ������.
	------------------------------------------------
	--	2-2. ���°�
	------------------------------------------------
	-- ������ ��з�
	declare @ITEM_MAINCATEGORY_ANI				int					set @ITEM_MAINCATEGORY_ANI 					= 1 	-- ����(1)
	declare @ITEM_MAINCATEGORY_CONSUME			int					set @ITEM_MAINCATEGORY_CONSUME 				= 3 	--�Ҹ�ǰ(3)
	declare @ITEM_MAINCATEGORY_ACC				int					set @ITEM_MAINCATEGORY_ACC 					= 4 	--�׼�����(4)
	declare @ITEM_MAINCATEGORY_HEART			int					set @ITEM_MAINCATEGORY_HEART 				= 40 	--��Ʈ(40)
	declare @ITEM_MAINCATEGORY_CASHCOST			int					set @ITEM_MAINCATEGORY_CASHCOST 			= 50 	--ĳ������(50)
	declare @ITEM_MAINCATEGORY_GAMECOST			int					set @ITEM_MAINCATEGORY_GAMECOST 			= 51 	--���μ���(51)
	declare @ITEM_MAINCATEGORY_ROULETTE			int					set @ITEM_MAINCATEGORY_ROULETTE 			= 52 	--�̱�(52)
	declare @ITEM_MAINCATEGORY_CONTEST			int					set @ITEM_MAINCATEGORY_CONTEST 				= 53 	--��ȸ(53)
	declare @ITEM_MAINCATEGORY_UPGRADE			int					set @ITEM_MAINCATEGORY_UPGRADE 				= 60 	--����(60)
	declare @ITEM_MAINCATEGORY_INVEN			int					set @ITEM_MAINCATEGORY_INVEN 				= 67 	--�κ�Ȯ��(67)
	declare @ITEM_MAINCATEGORY_SEEDFIEL			int					set @ITEM_MAINCATEGORY_SEEDFIEL 			= 68 	--������Ȯ��(68)
	declare @ITEM_MAINCATEGORY_DOGAM			int					set @ITEM_MAINCATEGORY_DOGAM 				= 818 	--����(818)
	declare @ITEM_MAINCATEGORY_GAMEINFO			int					set @ITEM_MAINCATEGORY_GAMEINFO 			= 500 	--��������(500)

	-- ���� ���ǰ�
	declare @GIFTLIST_GIFT_KIND_MESSAGE			int					set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2
	declare @GIFTLIST_GIFT_KIND_MESSAGE_DEL		int					set @GIFTLIST_GIFT_KIND_MESSAGE_DEL			= -1
	declare @GIFTLIST_GIFT_KIND_GIFT_DEL		int					set @GIFTLIST_GIFT_KIND_GIFT_DEL			= -2
	declare @GIFTLIST_GIFT_KIND_GIFT_GET		int					set @GIFTLIST_GIFT_KIND_GIFT_GET			= -3
	declare @GIFTLIST_GIFT_KIND_GIFT_SELL		int					set @GIFTLIST_GIFT_KIND_GIFT_SELL			= -4

	declare @DOGAMLIST_ANIMAL_PERFECT			int				set @DOGAMLIST_ANIMAL_PERFECT			= 1
	declare @DOGAMLIST_ANIMAL_LACK				int				set @DOGAMLIST_ANIMAL_LACK				= -1

	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @gameid 				varchar(60)
	declare @password 				varchar(20)

	declare @animal					int					set @animal		 			= @DOGAMLIST_ANIMAL_PERFECT
	declare @rewarditemcode			int					set @rewarditemcode 		= -2
	declare @rewardvalue			int					set @rewardvalue			= 0
	declare @animal0				int					set @animal0				= -1
	declare @animal1				int					set @animal1				= -1
	declare @animal2				int					set @animal2				= -1
	declare @animal3				int					set @animal3				= -1
	declare @animal4				int					set @animal4				= -1
	declare @animal5				int					set @animal5				= -1
	declare @itemcode				int

	declare @comment				varchar(512)

Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG �Է�����', @gameid_ gameid_, @password_ password_, @dogamidx_ dogamidx_

	------------------------------------------------
	--	3-2. �������(��������)
	------------------------------------------------
	select
		@gameid 		= gameid
	from dbo.tFVUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG ��������', @gameid gameid

	------------------------------------------------
	--	3-2. ȹ�渮��Ʈ�� ���� ������ ��ġ�����ľ�.
	-- 		 > �����ۿ� ���翩�� �ľ��ϱ�.
	------------------------------------------------
	select
		@animal0 		= param2,
		@animal1 		= param3,
		@animal2 		= param4,
		@animal3 		= param5,
		@animal4 		= param6,
		@animal5 		= param7,
		@rewarditemcode = param8,
		@rewardvalue	= param9
	from dbo.tFVItemInfo
	where subcategory = @ITEM_MAINCATEGORY_DOGAM
		and param1 = @dogamidx_
	--select 'DEBUG ����������', @animal0 animal0, @animal1 animal1, @animal2 animal2, @animal3 animal3, @animal4 animal4, @animal5 animal5, @rewarditemcode rewarditemcode, @rewardvalue rewardvalue


	set @itemcode	= @animal0
	if(@itemcode != -1 and @animal = @DOGAMLIST_ANIMAL_PERFECT)
		begin
			if(not exists(select top 1 * from dbo.tFVDogamList where gameid = @gameid_ and itemcode = @itemcode))
				begin
					set @animal = @DOGAMLIST_ANIMAL_LACK
				end
		end

	set @itemcode	= @animal1
	if(@itemcode != -1 and @animal = @DOGAMLIST_ANIMAL_PERFECT)
		begin
			if(not exists(select top 1 * from dbo.tFVDogamList where gameid = @gameid_ and itemcode = @itemcode))
				begin
					set @animal = @DOGAMLIST_ANIMAL_LACK
				end
		end

	set @itemcode	= @animal2
	if(@itemcode != -1 and @animal = @DOGAMLIST_ANIMAL_PERFECT)
		begin
			if(not exists(select top 1 * from dbo.tFVDogamList where gameid = @gameid_ and itemcode = @itemcode))
				begin
					set @animal = @DOGAMLIST_ANIMAL_LACK
				end
		end

	set @itemcode	= @animal3
	if(@itemcode != -1 and @animal = @DOGAMLIST_ANIMAL_PERFECT)
		begin
			if(not exists(select top 1 * from dbo.tFVDogamList where gameid = @gameid_ and itemcode = @itemcode))
				begin
					set @animal = @DOGAMLIST_ANIMAL_LACK
				end
		end

	set @itemcode	= @animal4
	if(@itemcode != -1 and @animal = @DOGAMLIST_ANIMAL_PERFECT)
		begin
			if(not exists(select top 1 * from dbo.tFVDogamList where gameid = @gameid_ and itemcode = @itemcode))
				begin
					set @animal = @DOGAMLIST_ANIMAL_LACK
				end
		end

	set @itemcode	= @animal5
	if(@itemcode != -1 and @animal = @DOGAMLIST_ANIMAL_PERFECT)
		begin
			if(not exists(select top 1 * from dbo.tFVDogamList where gameid = @gameid_ and itemcode = @itemcode))
				begin
					set @animal = @DOGAMLIST_ANIMAL_LACK
				end
		end


	if(isnull(@gameid, '') = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '���̵� �������� �ʴ´�.'
			--select 'DEBUG ', @comment
		END
	else if(@rewarditemcode = -2)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_DOGAMIDX
			set @comment 	= '���� ��ȣ�� �������� �ʴ´�.'
			--select 'DEBUG ', @comment
		END
	else if(exists(select top 1 * from dbo.tFVDogamReward where gameid = @gameid_ and dogamidx = @dogamidx_))
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_DOGAM_ALREADY_REWARD
			set @comment 	= 'DEBUG ������ �̹� �����ߴ�.'
			--select 'DEBUG ', @comment
		END
	else if(@animal = @DOGAMLIST_ANIMAL_LACK)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_DOGAM_LACK
			set @comment 	= '���� ��ȣ�� �����ϴ�.'
			--select 'DEBUG ', @comment
		END
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'DEBUG ���� ���������մϴ�.'
			--select 'DEBUG ', @comment
		END


	select @nResult_ rtn, @comment comment
	if(@nResult_ = @RESULT_SUCCESS)
		BEGIN
			--------------------------------------------------------------
			--	���� : ���� ���� �����ε��� ��ȣ.
			--------------------------------------------------------------
			insert into dbo.tFVDogamReward(gameid, dogamidx) values(@gameid_, @dogamidx_)

			--------------------------------------------------------------
			-- ������ �����Կ� �־�α�
			--------------------------------------------------------------
			exec spu_FVSubGiftSend 2, @rewarditemcode, 'SysDogam', @gameid_, ''

			--------------------------------------------------------------
			-- ���� ����/����(����, ������ɺ��� ����)
			--------------------------------------------------------------
			exec spu_FVGiftList @gameid_

			--------------------------------------------------------------
			-- ����Ʈ ���(���󵵰�, ������)
			--------------------------------------------------------------
			select * from dbo.tFVDogamReward where gameid = @gameid_ order by dogamidx asc

		END

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off
End



