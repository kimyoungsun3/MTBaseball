/*
select * from dbo.tDogamList where gameid = 'xxxx2' order by itemcode asc
select * from dbo.tDogamReward where gameid = 'xxxx2' order by dogamidx asc
--delete from dbo.tDogamReward where gameid = 'xxxx2'

exec spu_DogamReward 'xxxx2', '049000s1i0n7t8445289', 1, -1	-- 이미지급
exec spu_DogamReward 'xxxx2', '049000s1i0n7t8445289', 2, -1	-- 조건만족
exec spu_DogamReward 'xxxx2', '049000s1i0n7t8445289', 3, -1	-- 부족
*/
use Game4Farmvill5
GO

IF OBJECT_ID ( 'dbo.spu_DogamReward', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_DogamReward;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_DogamReward
	@gameid_								varchar(20),
	@password_								varchar(20),
	@dogamidx_								int,
	@nResult_								int					OUTPUT
	--WITH ENCRYPTION -- 프로시져를 암호화함.
as
	------------------------------------------------
	--	2-1. 코드값자리
	------------------------------------------------
	-- 일반값
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	-- 로그인 오류.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함

	-- 기타오류
	declare @RESULT_ERROR_NOT_FOUND_DOGAMIDX	int				set @RESULT_ERROR_NOT_FOUND_DOGAMIDX	= -103			-- 도감번호를 찾을수 없음.
	declare @RESULT_ERROR_DOGAM_ALREADY_REWARD	int				set @RESULT_ERROR_DOGAM_ALREADY_REWARD	= -104			-- 도감을 이미 지급했음.
	declare @RESULT_ERROR_DOGAM_LACK			int				set @RESULT_ERROR_DOGAM_LACK			= -105			-- 도감중에 동물번호가 부족함.
	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------
	-- 아이템 대분류
	declare @ITEM_MAINCATEGORY_DOGAM			int					set @ITEM_MAINCATEGORY_DOGAM 				= 818 	--도감(818)

	-- 선물 정의값
	declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2

	declare @DOGAMLIST_ANIMAL_PERFECT			int					set @DOGAMLIST_ANIMAL_PERFECT			= 1
	declare @DOGAMLIST_ANIMAL_LACK				int					set @DOGAMLIST_ANIMAL_LACK				= -1

	------------------------------------------------
	--	2-1. 내부사용 변수
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
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG 입력정보', @gameid_ gameid_, @password_ password_, @dogamidx_ dogamidx_

	------------------------------------------------
	--	3-2. 연산수행(유저정보)
	------------------------------------------------
	select
		@gameid 		= gameid
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 유저정보', @gameid gameid

	------------------------------------------------
	--	3-2. 획득리스트와 도감 마스터 일치여부파악.
	-- 		 > 보유템에 존재여부 파악하기.
	------------------------------------------------
	select
		@animal0 		= param2, 	@animal1 		= param3,		@animal2 		= param4,
		@rewarditemcode = param8,	@rewardvalue	= param9
	from dbo.tItemInfo
	where subcategory = @ITEM_MAINCATEGORY_DOGAM
		and param1 = @dogamidx_
	--select 'DEBUG 도감마스터', @animal0 animal0, @animal1 animal1, @animal2 animal2, @rewarditemcode rewarditemcode, @rewardvalue rewardvalue


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
			set @comment 	= 'ERROR 아이디가 존재하지 않는다.'
			--select 'DEBUG ', @comment
		END
	else if(@rewarditemcode = -2)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_DOGAMIDX
			set @comment 	= 'ERROR 도감 번호가 존재하지 않는다.'
			--select 'DEBUG ', @comment
		END
	else if(exists(select top 1 * from dbo.tDogamReward where gameid = @gameid_ and dogamidx = @dogamidx_))
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_DOGAM_ALREADY_REWARD
			set @comment 	= 'ERROR 도감을 이미 지급했다.'
			--select 'DEBUG ', @comment
		END
	else if(@animal = @DOGAMLIST_ANIMAL_LACK)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_DOGAM_LACK
			set @comment 	= 'ERROR 도감 번호가 부족하다.'
			--select 'DEBUG ', @comment
		END
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'SUCCESS 도감 정상지급합니다.'
			--select 'DEBUG ', @comment

			--------------------------------------------------------------
			--	도감 : 보상 받음 도감인덱스 번호.
			--------------------------------------------------------------
			insert into dbo.tDogamReward(gameid,   dogamidx)
			values(                     @gameid_, @dogamidx_)

			--------------------------------------------------------------
			-- 보상템 선물함에 넣어두기
			--------------------------------------------------------------
			exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT, @rewarditemcode, @rewardvalue, 'SysDogam', @gameid_, ''
		END


	select @nResult_ rtn, @comment comment
	if(@nResult_ = @RESULT_SUCCESS)
		BEGIN
			--------------------------------------------------------------
			-- 유저 선물/쪽지(존재, 쪽지기능보유 통합)
			--------------------------------------------------------------
			exec spu_GiftList @gameid_

			--------------------------------------------------------------
			-- 리스트 출력(보상도감, 선물함)
			--------------------------------------------------------------
			select * from dbo.tDogamReward where gameid = @gameid_ order by dogamidx asc
		END

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
End



