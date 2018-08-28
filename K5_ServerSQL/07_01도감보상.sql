/*
select * from dbo.tDogamList where gameid = 'xxxx2' order by itemcode asc
select * from dbo.tDogamReward where gameid = 'xxxx2' order by dogamidx asc
--delete from dbo.tDogamReward where gameid = 'xxxx2'

exec spu_DogamReward 'xxxx2', '049000s1i0n7t8445289', 1, -1	-- �̹�����
exec spu_DogamReward 'xxxx2', '049000s1i0n7t8445289', 2, -1	-- ���Ǹ���
exec spu_DogamReward 'xxxx2', '049000s1i0n7t8445289', 3, -1	-- ����
*/
use Game4Farmvill5
GO

IF OBJECT_ID ( 'dbo.spu_DogamReward', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_DogamReward;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_DogamReward
	@gameid_								varchar(20),
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
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--�ش������� ã�� ����

	-- ��Ÿ����
	declare @RESULT_ERROR_NOT_FOUND_DOGAMIDX	int				set @RESULT_ERROR_NOT_FOUND_DOGAMIDX	= -103			-- ������ȣ�� ã���� ����.
	declare @RESULT_ERROR_DOGAM_ALREADY_REWARD	int				set @RESULT_ERROR_DOGAM_ALREADY_REWARD	= -104			-- ������ �̹� ��������.
	declare @RESULT_ERROR_DOGAM_LACK			int				set @RESULT_ERROR_DOGAM_LACK			= -105			-- �����߿� ������ȣ�� ������.
	------------------------------------------------
	--	2-2. ���°�
	------------------------------------------------
	-- ������ ��з�
	declare @ITEM_MAINCATEGORY_DOGAM			int					set @ITEM_MAINCATEGORY_DOGAM 				= 818 	--����(818)

	-- ���� ���ǰ�
	declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2

	declare @DOGAMLIST_ANIMAL_PERFECT			int					set @DOGAMLIST_ANIMAL_PERFECT			= 1
	declare @DOGAMLIST_ANIMAL_LACK				int					set @DOGAMLIST_ANIMAL_LACK				= -1

	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @gameid 				varchar(20)			set @gameid					= ''

	declare @animal					int					set @animal		 			= @DOGAMLIST_ANIMAL_PERFECT
	declare @rewarditemcode			int					set @rewarditemcode 		= -2
	declare @rewardvalue			int					set @rewardvalue			= 0
	declare @animal0				int					set @animal0				= -1
	declare @animal1				int					set @animal1				= -1
	declare @animal2				int					set @animal2				= -1
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
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG ��������', @gameid gameid

	------------------------------------------------
	--	3-2. ȹ�渮��Ʈ�� ���� ������ ��ġ�����ľ�.
	-- 		 > �����ۿ� ���翩�� �ľ��ϱ�.
	------------------------------------------------
	select
		@animal0 		= param2, 	@animal1 		= param3,		@animal2 		= param4,
		@rewarditemcode = param8,	@rewardvalue	= param9
	from dbo.tItemInfo
	where subcategory = @ITEM_MAINCATEGORY_DOGAM
		and param1 = @dogamidx_
	--select 'DEBUG ����������', @animal0 animal0, @animal1 animal1, @animal2 animal2, @rewarditemcode rewarditemcode, @rewardvalue rewardvalue


	set @itemcode	= @animal0
	if(@itemcode != -1 and @animal = @DOGAMLIST_ANIMAL_PERFECT)
		begin
			if(not exists(select top 1 * from dbo.tDogamList where gameid = @gameid_ and itemcode = @itemcode))
				begin
					set @animal = @DOGAMLIST_ANIMAL_LACK
				end
		end

	set @itemcode	= @animal1
	if(@itemcode != -1 and @animal = @DOGAMLIST_ANIMAL_PERFECT)
		begin
			if(not exists(select top 1 * from dbo.tDogamList where gameid = @gameid_ and itemcode = @itemcode))
				begin
					set @animal = @DOGAMLIST_ANIMAL_LACK
				end
		end

	set @itemcode	= @animal2
	if(@itemcode != -1 and @animal = @DOGAMLIST_ANIMAL_PERFECT)
		begin
			if(not exists(select top 1 * from dbo.tDogamList where gameid = @gameid_ and itemcode = @itemcode))
				begin
					set @animal = @DOGAMLIST_ANIMAL_LACK
				end
		end


	if( @gameid = '' )
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR ���̵� �������� �ʴ´�.'
			--select 'DEBUG ', @comment
		END
	else if(@rewarditemcode = -2)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_DOGAMIDX
			set @comment 	= 'ERROR ���� ��ȣ�� �������� �ʴ´�.'
			--select 'DEBUG ', @comment
		END
	else if(exists(select top 1 * from dbo.tDogamReward where gameid = @gameid_ and dogamidx = @dogamidx_))
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_DOGAM_ALREADY_REWARD
			set @comment 	= 'ERROR ������ �̹� �����ߴ�.'
			--select 'DEBUG ', @comment
		END
	else if(@animal = @DOGAMLIST_ANIMAL_LACK)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_DOGAM_LACK
			set @comment 	= 'ERROR ���� ��ȣ�� �����ϴ�.'
			--select 'DEBUG ', @comment
		END
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'SUCCESS ���� ���������մϴ�.'
			--select 'DEBUG ', @comment

			--------------------------------------------------------------
			--	���� : ���� ���� �����ε��� ��ȣ.
			--------------------------------------------------------------
			insert into dbo.tDogamReward(gameid,   dogamidx)
			values(                     @gameid_, @dogamidx_)

			--------------------------------------------------------------
			-- ������ �����Կ� �־�α�
			--------------------------------------------------------------
			exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT, @rewarditemcode, @rewardvalue, 'SysDogam', @gameid_, ''
		END


	select @nResult_ rtn, @comment comment
	if(@nResult_ = @RESULT_SUCCESS)
		BEGIN
			--------------------------------------------------------------
			-- ���� ����/����(����, ������ɺ��� ����)
			--------------------------------------------------------------
			exec spu_GiftList @gameid_

			--------------------------------------------------------------
			-- ����Ʈ ���(���󵵰�, ������)
			--------------------------------------------------------------
			select * from dbo.tDogamReward where gameid = @gameid_ order by dogamidx asc
		END

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off
End



