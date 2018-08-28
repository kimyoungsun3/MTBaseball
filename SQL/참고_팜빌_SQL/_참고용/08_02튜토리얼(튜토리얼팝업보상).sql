/*
delete from dbo.tFVTutoStep where gameid = 'xxxx3'
delete from dbo.tFVGiftList where gameid = 'xxxx3'
update dbo.tFVUserMaster set gamecost = 0, cashcost = 0, feed = 0, heart = 0, fpoint = 0 where gameid = 'xxxx3'
exec spu_FVTutoStep 'xxxx3', '049000s1i0n7t8445289', 5500, -1, -1	-- 튜토리얼 마킹
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
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_FVTutoStep
	@gameid_								varchar(60),
	@password_								varchar(20),
	@tutostep_								int,
	@ispass_								int,
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

	-- 선물 코드값
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- 아이템코드못찾음
	declare @RESULT_ERROR_GIFTITEM_NOT_FOUND	int				set @RESULT_ERROR_GIFTITEM_NOT_FOUND	= -51			-- 선물아이템을 못찾음
	declare @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	int				set @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	= -52			-- 선물을 이미 가져감
	declare @RESULT_ERROR_NOT_FOUND_GIFTID		int				set @RESULT_ERROR_NOT_FOUND_GIFTID		= -75			-- 캐쉬 > 선물할 아이디를 못찾음

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
	-- 아이템 소분류
	declare @ITEM_SUBCATEGORY_TUTORIAL			int					set @ITEM_SUBCATEGORY_TUTORIAL 				= 55 -- 튜토리얼(55)

	-- 선물 정의값
	declare @GIFTLIST_GIFT_KIND_MESSAGE			int					set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2
	declare @GIFTLIST_GIFT_KIND_MESSAGE_DEL		int					set @GIFTLIST_GIFT_KIND_MESSAGE_DEL			= -1
	declare @GIFTLIST_GIFT_KIND_GIFT_DEL		int					set @GIFTLIST_GIFT_KIND_GIFT_DEL			= -2
	declare @GIFTLIST_GIFT_KIND_GIFT_GET		int					set @GIFTLIST_GIFT_KIND_GIFT_GET			= -3
	declare @GIFTLIST_GIFT_KIND_GIFT_SELL		int					set @GIFTLIST_GIFT_KIND_GIFT_SELL			= -4

	-- 튜토리얼 상태값.
	declare @TUTOSTEP_ISPASS_PASS				int					set @TUTOSTEP_ISPASS_PASS					=  1		--  1:패스.
	declare @TUTOSTEP_ISPASS_MARK				int					set @TUTOSTEP_ISPASS_MARK					= -1		-- -1:사전보상 or 완료보상.

	-- bool
	declare @BOOL_TRUE							int					set @BOOL_TRUE						= 1
	declare @BOOL_FALSE							int					set @BOOL_FALSE						= 0

	declare @INIT_VALUE							int					set @INIT_VALUE								= -555
	------------------------------------------------
	--	2-1. 내부사용 변수
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
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG 입력정보', @gameid_ gameid_, @password_ password_, @tutostep_ tutostep_, @ispass_ ispass_

	------------------------------------------------
	--	3-2. 연산수행(유저정보)
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
	--select 'DEBUG 유저정보', @gameid gameid, @cashcost cashcost, @gamecost gamecost, @heart heart, @feed feed, @fpoint fpoint, @gameyear gameyear, @gamemonth gamemonth, @famelv famelv

	------------------------------------------------
	--	3-2. 획득리스트와 도감 마스터 일치여부파악.
	-- 		 > 보유템에 존재여부 파악하기.
	------------------------------------------------
	select
		@rewardkind 	= param1,
		@rewardvalue 	= param2
	from dbo.tFVItemInfo
	where itemcode = @tutostep_ and subcategory = @ITEM_SUBCATEGORY_TUTORIAL
	--select 'DEBUG 튜토리얼모드 마스터', @rewardkind rewardkind, @rewardvalue rewardvalue

	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '아이디가 존재하지 않는다.'
			--select 'DEBUG ', @comment
		END
	else if(@tutostep_ != -1 and exists(select top 1 * from dbo.tFVTutoStep where gameid = @gameid_ and itemcode = @tutostep_))
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_TUTORIAL_ALREADY
			set @comment 	= 'DEBUG 이미 지급했다.'
			--select 'DEBUG ', @comment
		END
	else if(@tutostep_ != -1 and @rewardkind = -1)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_ITEMCODE
			set @comment 	= '튜토리얼모드 번호가 존재안한다.'
			--select 'DEBUG ', @comment
		END
	else if(@ispass_ = @TUTOSTEP_ISPASS_PASS)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'DEBUG 튜토리얼모드 패스합니다.'
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
			set @comment 	= 'DEBUG 정상지급합니다.'
			--select 'DEBUG ', @comment

			--코인(0)
			--캐쉬(1)
			--하트(2)
			--건초(3)
			--우정포인트(4)
			--아이템코드(5)
			if(@tutostep_ = -1)
				begin
					set @brewardwrite = @BOOL_FALSE
					--select 'DEBUG 단순초기화비기록', @rewardvalue
				end
			else if(@rewardkind = 0)
				begin
					set @gamecost = @gamecost + @rewardvalue
					--select 'DEBUG 코인지급', @rewardvalue
				end
			else if(@rewardkind = 1)
				begin
					set @cashcost = @cashcost + @rewardvalue
					--select 'DEBUG 캐쉬지급', @rewardvalue
				end
			else if(@rewardkind = 2)
				begin
					set @heart = @heart + @rewardvalue
					--select 'DEBUG 하트지급', @rewardvalue
				end
			else if(@rewardkind = 3)
				begin
					set @feed = @feed + @rewardvalue
					--select 'DEBUG 건초지급', @rewardvalue
				end
			else if(@rewardkind = 4)
				begin
					set @fpoint = @fpoint + @rewardvalue
					--select 'DEBUG 우정포인트', @rewardvalue
				end
			else if(@rewardkind = 5)
				begin
					if(exists(select top 1 * from dbo.tFVItemInfo where itemcode = @rewardvalue))
						begin
							exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT, @rewardvalue, 'SysTut', @gameid_, ''				-- 특정아이템 지급
						end
					--select 'DEBUG 아이템코드', @rewardvalue
				end

			set @brecord	= 1
		END

	if(@nResult_ = @RESULT_SUCCESS and @brecord	= 1)
		BEGIN
			--------------------------------------------------------------
			--	보상 기록(위에서 검사함)
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
			--	정보기록
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
			--	유저정보.
			--------------------------------------------------------------
			select @rewardkind rewardkind, @rewardvalue rewardvalue,  * from dbo.tFVUserMaster where gameid = @gameid_

			--------------------------------------------------------------
			--	선물함.
			--------------------------------------------------------------
			exec spu_FVGiftList @gameid_
		END

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
End



