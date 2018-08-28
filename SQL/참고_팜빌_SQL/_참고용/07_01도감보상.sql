/*
select * from dbo.tFVDogamList where gameid = 'xxxx' order by itemcode asc
select * from dbo.tFVDogamReward where gameid = 'xxxx' order by dogamidx asc

exec spu_FVDogamReward 'xxxx', '049000s1i0n7t8445289', 1, -1	-- 이미지급
exec spu_FVDogamReward 'xxxx', '049000s1i0n7t8445289', 2, -1	-- 조건만족
exec spu_FVDogamReward 'xxxx', '049000s1i0n7t8445289', 3, -1	-- 부족
*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVDogamReward', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVDogamReward;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_FVDogamReward
	@gameid_								varchar(60),
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
	declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--블럭유저 > 팝업처리후 인트로로 빼버린다.
	declare @RESULT_ERROR_DELETED_USER 			int				set @RESULT_ERROR_DELETED_USER			= -12			--삭제유저 > 팝업처리후 인트로로 빼버린다.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함
	declare @RESULT_ERROR_NOT_FOUND_PASSWORD	int				set @RESULT_ERROR_NOT_FOUND_PASSWORD	= -17
	declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--서버를 점검하고 있다.
	declare @RESULT_NEWVERION_CLIENT_DOWNLOAD 	int				set @RESULT_NEWVERION_CLIENT_DOWNLOAD	= -15			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 링크처리.
	declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 종료.

	-- 기타오류
	declare @RESULT_ERROR_RESULT_COPY			int				set @RESULT_ERROR_RESULT_COPY			= -53			-- 결과카피시도
	declare @RESULT_ERROR_GAMECOST_COPY			int				set @RESULT_ERROR_GAMECOST_COPY			= -54			-- 실버카피시도
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- 지원하지않는모드
	declare @RESULT_ERROR_HEART_FULL			int				set @RESULT_ERROR_HEART_FULL			= -71			-- 지원하지않는모드
	declare @RESULT_ERROR_TUTORIAL_ALREADY		int				set @RESULT_ERROR_TUTORIAL_ALREADY		= -73			-- 투토리얼 이미 보상.
	declare @RESULT_ERROR_NOT_FOUND_OTHERID		int				set @RESULT_ERROR_NOT_FOUND_OTHERID		= -83
	declare @RESULT_ERROR_INVEN_FULL			int				set @RESULT_ERROR_INVEN_FULL			= -101			-- 인벤부족
	declare @RESULT_ERROR_DAILY_REWARD_ALREADY	int				set @RESULT_ERROR_DAILY_REWARD_ALREADY	= -102			-- 일일보상 이미 보상.
	declare @RESULT_ERROR_NOT_FOUND_DOGAMIDX	int				set @RESULT_ERROR_NOT_FOUND_DOGAMIDX	= -103			-- 도감번호를 찾을수 없음.
	declare @RESULT_ERROR_DOGAM_ALREADY_REWARD	int				set @RESULT_ERROR_DOGAM_ALREADY_REWARD	= -104			-- 도감을 이미 지급했음.
	declare @RESULT_ERROR_DOGAM_LACK			int				set @RESULT_ERROR_DOGAM_LACK			= -105			-- 도감중에 동물번호가 부족함.
	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------
	-- 아이템 대분류
	declare @ITEM_MAINCATEGORY_ANI				int					set @ITEM_MAINCATEGORY_ANI 					= 1 	-- 가축(1)
	declare @ITEM_MAINCATEGORY_CONSUME			int					set @ITEM_MAINCATEGORY_CONSUME 				= 3 	--소모품(3)
	declare @ITEM_MAINCATEGORY_ACC				int					set @ITEM_MAINCATEGORY_ACC 					= 4 	--액세서리(4)
	declare @ITEM_MAINCATEGORY_HEART			int					set @ITEM_MAINCATEGORY_HEART 				= 40 	--하트(40)
	declare @ITEM_MAINCATEGORY_CASHCOST			int					set @ITEM_MAINCATEGORY_CASHCOST 			= 50 	--캐쉬선물(50)
	declare @ITEM_MAINCATEGORY_GAMECOST			int					set @ITEM_MAINCATEGORY_GAMECOST 			= 51 	--코인선물(51)
	declare @ITEM_MAINCATEGORY_ROULETTE			int					set @ITEM_MAINCATEGORY_ROULETTE 			= 52 	--뽑기(52)
	declare @ITEM_MAINCATEGORY_CONTEST			int					set @ITEM_MAINCATEGORY_CONTEST 				= 53 	--대회(53)
	declare @ITEM_MAINCATEGORY_UPGRADE			int					set @ITEM_MAINCATEGORY_UPGRADE 				= 60 	--업글(60)
	declare @ITEM_MAINCATEGORY_INVEN			int					set @ITEM_MAINCATEGORY_INVEN 				= 67 	--인벤확장(67)
	declare @ITEM_MAINCATEGORY_SEEDFIEL			int					set @ITEM_MAINCATEGORY_SEEDFIEL 			= 68 	--경작지확장(68)
	declare @ITEM_MAINCATEGORY_DOGAM			int					set @ITEM_MAINCATEGORY_DOGAM 				= 818 	--도감(818)
	declare @ITEM_MAINCATEGORY_GAMEINFO			int					set @ITEM_MAINCATEGORY_GAMEINFO 			= 500 	--정보수집(500)

	-- 선물 정의값
	declare @GIFTLIST_GIFT_KIND_MESSAGE			int					set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2
	declare @GIFTLIST_GIFT_KIND_MESSAGE_DEL		int					set @GIFTLIST_GIFT_KIND_MESSAGE_DEL			= -1
	declare @GIFTLIST_GIFT_KIND_GIFT_DEL		int					set @GIFTLIST_GIFT_KIND_GIFT_DEL			= -2
	declare @GIFTLIST_GIFT_KIND_GIFT_GET		int					set @GIFTLIST_GIFT_KIND_GIFT_GET			= -3
	declare @GIFTLIST_GIFT_KIND_GIFT_SELL		int					set @GIFTLIST_GIFT_KIND_GIFT_SELL			= -4

	declare @DOGAMLIST_ANIMAL_PERFECT			int				set @DOGAMLIST_ANIMAL_PERFECT			= 1
	declare @DOGAMLIST_ANIMAL_LACK				int				set @DOGAMLIST_ANIMAL_LACK				= -1

	------------------------------------------------
	--	2-1. 내부사용 변수
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
	from dbo.tFVUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 유저정보', @gameid gameid

	------------------------------------------------
	--	3-2. 획득리스트와 도감 마스터 일치여부파악.
	-- 		 > 보유템에 존재여부 파악하기.
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
	--select 'DEBUG 도감마스터', @animal0 animal0, @animal1 animal1, @animal2 animal2, @animal3 animal3, @animal4 animal4, @animal5 animal5, @rewarditemcode rewarditemcode, @rewardvalue rewardvalue


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
			set @comment 	= '아이디가 존재하지 않는다.'
			--select 'DEBUG ', @comment
		END
	else if(@rewarditemcode = -2)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_DOGAMIDX
			set @comment 	= '도감 번호가 존재하지 않는다.'
			--select 'DEBUG ', @comment
		END
	else if(exists(select top 1 * from dbo.tFVDogamReward where gameid = @gameid_ and dogamidx = @dogamidx_))
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_DOGAM_ALREADY_REWARD
			set @comment 	= 'DEBUG 도감을 이미 지급했다.'
			--select 'DEBUG ', @comment
		END
	else if(@animal = @DOGAMLIST_ANIMAL_LACK)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_DOGAM_LACK
			set @comment 	= '도감 번호가 부족하다.'
			--select 'DEBUG ', @comment
		END
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'DEBUG 도감 정상지급합니다.'
			--select 'DEBUG ', @comment
		END


	select @nResult_ rtn, @comment comment
	if(@nResult_ = @RESULT_SUCCESS)
		BEGIN
			--------------------------------------------------------------
			--	도감 : 보상 받음 도감인덱스 번호.
			--------------------------------------------------------------
			insert into dbo.tFVDogamReward(gameid, dogamidx) values(@gameid_, @dogamidx_)

			--------------------------------------------------------------
			-- 보상템 선물함에 넣어두기
			--------------------------------------------------------------
			exec spu_FVSubGiftSend 2, @rewarditemcode, 'SysDogam', @gameid_, ''

			--------------------------------------------------------------
			-- 유저 선물/쪽지(존재, 쪽지기능보유 통합)
			--------------------------------------------------------------
			exec spu_FVGiftList @gameid_

			--------------------------------------------------------------
			-- 리스트 출력(보상도감, 선물함)
			--------------------------------------------------------------
			select * from dbo.tFVDogamReward where gameid = @gameid_ order by dogamidx asc

		END

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
End



