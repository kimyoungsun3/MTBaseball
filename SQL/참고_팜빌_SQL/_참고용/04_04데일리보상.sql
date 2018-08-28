/*
exec spu_FVDailyReward 'xxxx2', '049000s1i0n7t8445289', -1			-- 정상유저
*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVDailyReward', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVDailyReward;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_FVDailyReward
	@gameid_								varchar(60),					-- 게임아이디
	@password_								varchar(20),					--
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

	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------
	-- 선물 정의값
	declare @GIFTLIST_GIFT_KIND_MESSAGE			int					set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2
	declare @GIFTLIST_GIFT_KIND_MESSAGE_DEL		int					set @GIFTLIST_GIFT_KIND_MESSAGE_DEL			= -1
	declare @GIFTLIST_GIFT_KIND_GIFT_DEL		int					set @GIFTLIST_GIFT_KIND_GIFT_DEL			= -2
	declare @GIFTLIST_GIFT_KIND_GIFT_GET		int					set @GIFTLIST_GIFT_KIND_GIFT_GET			= -3
	declare @GIFTLIST_GIFT_KIND_GIFT_SELL		int					set @GIFTLIST_GIFT_KIND_GIFT_SELL			= -4

	-- 데일리보상 아이템코드.
	declare @DAILY_REWARD_ONE_ITEMCODE			int				set @DAILY_REWARD_ONE_ITEMCODE			= 900			--10건초(900)
	declare @DAILY_REWARD_TWO_ITEMCODE			int				set @DAILY_REWARD_TWO_ITEMCODE			= 5111			--10코인(5111)
	declare @DAILY_REWARD_THREE_ITEMCODE		int				set @DAILY_REWARD_THREE_ITEMCODE		= 5112			--30코인(5112)
	declare @DAILY_REWARD_FOUR_ITEMCODE			int				set @DAILY_REWARD_FOUR_ITEMCODE			= 5113			--50코인(5113)
	declare @DAILY_REWARD_FIVE_ITEMCODE			int				set @DAILY_REWARD_FIVE_ITEMCODE			= 5007			--5캐시(5007)

	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @gameid 				varchar(60)
	declare @attenddate				datetime,
			@attendcnt				int
	declare @comment				varchar(512)

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG 입력정보', @gameid_ gameid_, @password_ password_

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	select
		@gameid 		= gameid,
		@attenddate 	= attenddate, 			@attendcnt 	= attendcnt
	from dbo.tFVUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 유저정보', @gameid gameid, @attenddate attenddate, @attendcnt attendcnt


	if(isnull(@gameid, '') = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '데일리 보상 아이디가 존재하지 않는다. > 아이디를 확인해라.'
			--select 'DEBUG ', @comment
		END
	else if (@attendcnt <= 0)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_DAILY_REWARD_ALREADY
			set @comment 	= '데일리 보상 이미 지급했다.'
			--select 'DEBUG ', @comment
		END
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '데일리 보상 정상처리'
			--select 'DEBUG ', @comment

			------------------------------------------------------------------
			-- 보상해서 선물함에 넣어주기
			------------------------------------------------------------------
			if(@attendcnt = 1)
				begin
					--select 'DEBUG 1일보상'
					exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @DAILY_REWARD_ONE_ITEMCODE, 'DailyReward', @gameid_, '1일보상'
				end
			else if(@attendcnt = 2)
				begin
					--select 'DEBUG 2일보상'
					exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @DAILY_REWARD_TWO_ITEMCODE, 'DailyReward', @gameid_, '2일보상'
				end
			else if(@attendcnt = 3)
				begin
					--select 'DEBUG 3일보상'
					exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @DAILY_REWARD_THREE_ITEMCODE, 'DailyReward', @gameid_, '3일보상'
				end
			else if(@attendcnt = 4)
				begin
					--select 'DEBUG 4일보상'
					exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @DAILY_REWARD_FOUR_ITEMCODE, 'DailyReward', @gameid_, '4일보상'
				end
			else if(@attendcnt >= 5)
				begin
					--select 'DEBUG 5일보상'
					exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @DAILY_REWARD_FIVE_ITEMCODE, 'DailyReward', @gameid_, '5일보상'
				end

			------------------------------------------------------------------
			-- 보상초기화(0)
			------------------------------------------------------------------
			update dbo.tFVUserMaster set attendcnt = 0 where gameid = @gameid_
		END

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	select @nResult_ rtn, @comment comment

	--------------------------------------------------------------
	-- 선물/쪽지 리스트 정보
	--------------------------------------------------------------
	exec spu_FVGiftList @gameid_

	set nocount off
End



