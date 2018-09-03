/*
-- select eventspot10,  rebirthpoint from dbo.tFVUserMaster  where gameid = 'xxxx2'
--delete from dbo.tFVGiftList where gameid = 'xxxx2'
--update dbo.tFVUserMaster set rebirthcnt = 0, randserial = -1 where gameid = 'xxxx2'
--update dbo.tFVUserMaster set eventspot10 = 0, eventspot11 = 0, bestani = 526, rebirthpoint = 150000, randserial = -1 where gameid = 'xxxx2'
--update dbo.tFVUserMaster set eventspot10 = 0, eventspot11 = 0, bestani = 526, rebirthpoint = 150000, randserial = -1 where gameid = 'farm48901'

exec spu_FVRebirth 'xxxx2', '049000s1i0n7t8445289', 100, 'savedatarebirth', -1, 7774, -1			-- 정상유저
exec spu_FVRebirth 'xxxx2', '049000s1i0n7t8445289', 100, 'savedatarebirth', -1, 7775, -1			-- 정상유저
exec spu_FVRebirth 'xxxx2', '049000s1i0n7t8445289', 100, 'savedatarebirth', -7, 7775, -1			-- 정상유저(세션만기)
*/
use Game4FarmVill4
GO

IF OBJECT_ID ( 'dbo.spu_FVRebirth', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVRebirth;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_FVRebirth
	@gameid_								varchar(60),					-- 게임아이디
	@password_								varchar(20),					--
	@rebirthpoint_							int,							--
	@savedata_								varchar(8000),
	@sid_									int,
	@randserial_							varchar(20),					--
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
	declare @RESULT_ERROR_SESSION_ID_EXPIRE		int				set @RESULT_ERROR_SESSION_ID_EXPIRE		= -150			-- 세션이 만료되었습니다.

	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------
	-- 선물 정의값
	--declare @GIFTLIST_GIFT_KIND_MESSAGE		int					set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2
	--declare @GIFTLIST_GIFT_KIND_MESSAGE_DEL	int					set @GIFTLIST_GIFT_KIND_MESSAGE_DEL			= -1
	--declare @GIFTLIST_GIFT_KIND_GIFT_DEL		int					set @GIFTLIST_GIFT_KIND_GIFT_DEL			= -2
	--declare @GIFTLIST_GIFT_KIND_GIFT_GET		int					set @GIFTLIST_GIFT_KIND_GIFT_GET			= -3
	--declare @GIFTLIST_GIFT_KIND_GIFT_SELL		int					set @GIFTLIST_GIFT_KIND_GIFT_SELL			= -4

	----------------------------------------------
	-- 별을 모아라 이벤트(여러번 가능)
	-- 기간 : 8월 21일 ~ 9월 14일
	-- 별 1500개 A급 보물(1개 랜덤 지급)
	-- 별 3000개 S급 보물(1개 랜덤 지급)
	-- 별 20000개 SS급 보물(1개 랜덤 지급)
	----------------------------------------------
	declare @EVENT01_START_DAY					datetime			set @EVENT01_START_DAY						= '2015-08-21'
	declare @EVENT01_END_DAY					datetime			set @EVENT01_END_DAY						= '2015-09-14 23:59'

	----------------------------------------------
	-- 특정 동물에서 환생 특별 이벤트
	-- 기간 : 8월 6일 ~ 9월 10일
	-- 남색 줄리엣양(515) 	- 3000루비
	-- 핑크 버블바니양(519) - 5000루비
	-- 파랑하트양(522) 		- 7000루비
	-- 남색귀족 양(526) 	- 10000루비
	----------------------------------------------
	declare @EVENT11_START_DAY					datetime			set @EVENT11_START_DAY						= '2015-08-06'
	declare @EVENT11_END_DAY					datetime			set @EVENT11_END_DAY						= '2015-09-10 23:59'

	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @comment				varchar(512)
	declare @comment2				varchar(512)	set @comment2		= ''
	declare @gameid					varchar(60)		set @gameid			= ''
	declare @randserial				varchar(20)		set @randserial		= ''
	declare @sid					int				set @sid			= 0
	declare @rebirthpoint			int				set @rebirthpoint	= 0
	declare @eventspot10			int				set @eventspot10	= 0
	declare @eventspot11			int				set @eventspot11	= 0
	declare @curdate				datetime		set @curdate		= getdate()
	declare @roul1					int				set @roul1			= -1
	declare @bestani				int				set @bestani		= 500
	declare @rand					int,
			@rand2					int

	declare @cnt					int				set @cnt			= 0
	declare @cnt11					int				set @cnt11			= 0
	declare @rebirthcnt				int				set @rebirthcnt		= 0
	declare @eventsender 			varchar(20)		set @eventsender	= '환생이벤트'
	declare @eventsender2 			varchar(20)		set @eventsender2	= '별모아라'
	declare @eventsender11 			varchar(20)		set @eventsender11	= '환생특별도움'
	declare @market					int				set @market			= 5
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG 입력정보', @gameid_ gameid_, @password_ password_, @rebirthpoint_ rebirthpoint_, @savedata_ savedata_, @randserial_ randserial_

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	select
		@gameid 		= gameid,
		@market			= market,
		@sid			= sid,
		@rebirthcnt		= rebirthcnt,
		@rebirthpoint	= rebirthpoint,		@eventspot10	= eventspot10,
		@bestani		= bestani,			@eventspot11 = eventspot11,
		@randserial		= randserial
	from dbo.tFVUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 유저정보', @gameid gameid, @randserial randserial, @rebirthpoint rebirthpoint, @eventspot10 eventspot10, @eventspot11 eventspot11, @bestani bestani

	------------------------------------------------
	--	3-3. 각상황별로 코드로 분류
	------------------------------------------------
	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR 아이디가 존재하지 않는다.'
			--select 'DEBUG ' + @comment
		END
	else if(@sid_ != -1 and @sid_ != @sid)
		BEGIN
			-- 세션 ID가 같지 않으면 안됨.
			set @nResult_ 	= @RESULT_ERROR_SESSION_ID_EXPIRE
			set @comment 	= '세션이 만료되어 있습니다. 재로그인합니다.'
			--select 'DEBUG ', @comment
		END
	else if (@randserial_ = @randserial)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '초기화 했습니다.(동일씨리얼2)'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '초기화 했습니다.'
			----select 'DEBUG ', @comment

			---------------------------------------------------
			-- 환생횟수, 포인트 증가.
			---------------------------------------------------
			set @rebirthcnt 	= @rebirthcnt + 1
			set @rebirthpoint	= @rebirthpoint + @rebirthpoint_


			---------------------------------------------------
			-- 별을 모아라 이벤트
			---------------------------------------------------
			if(@curdate >= @EVENT01_START_DAY and @curdate < @EVENT01_END_DAY)
				begin
					--select 'DEBUG 별을 모아라 이벤트.'

					set @roul1 = -1
					set @rand 	= Convert(int, ceiling(RAND() * 100))
					set @rand2 	= Convert(int, ceiling(RAND() * 100))
					if( @eventspot10 = 0 and @rebirthpoint >= 1500 )
						begin
							--select 'DEBUG 1단계 1,500'
							if(@rand2 < 40)
								begin
									set @roul1	= dbo.fnu_FVGetCrossRandom2(@rand, 	80203, 80208, 80213, 80218, 80223, 80228, 80233, 80238, 80243, 80248, 80253, 80258)
								end
							else if(@rand2 < 80)
								begin
									set @roul1	= dbo.fnu_FVGetCrossRandom2(@rand, 	80263, 80268, 80273, 80278, 80283, 80288, 80293, 80298, 80303, 80308, 80313, 80258)
								end
							else
								begin
									set @roul1	= dbo.fnu_FVGetCrossRandom2(@rand, 	80013, 80023, 80033, 80043, 80053, 80063, 80073, 80083, 80093, 80103, 80113, 80123)
								end
						end
					else if( @eventspot10 = 1 and @rebirthpoint >= 3000 )
						begin
							--select 'DEBUG 2단계 3,000'
							if(@rand2 < 40)
								begin
									set @roul1	= dbo.fnu_FVGetCrossRandom2(@rand, 	80204, 80209, 80214, 80219, 80224, 80229, 80234, 80239, 80244, 80249, 80254, 80259)
								end
							else if(@rand2 < 80)
								begin
									set @roul1	= dbo.fnu_FVGetCrossRandom2(@rand, 	80264, 80269, 80274, 80279, 80284, 80289, 80294, 80299, 80304, 80309, 80314, 80204)
								end
							else
								begin
									set @roul1	= dbo.fnu_FVGetCrossRandom2(@rand, 	80014, 80024, 80034, 80044, 80054, 80064, 80074, 80084, 80094, 80104, 80114, 80124)
								end
						end
					else if( @eventspot10 = 2 and @rebirthpoint >= 20000 )
						begin
							--select 'DEBUG 3단계 20,000'
							set @roul1	= dbo.fnu_FVGetCrossRandom2(@rand, 	80015, 80025, 80035, 80045, 80055, 80065, 80025, 80025, 80045, 80045, 80065, 80065)
						end
					--select 'DEBUG ', @roul1 roul1, @rand rand, @rand2 rand2

					if(@roul1 != -1)
						begin
							--select 'DEBUG > 지급', @roul1 roul1
							set @eventspot10 	= @eventspot10 + 1
							set @eventsender2 	= @eventsender2 + ltrim(rtrim(str(@eventspot10)))
							exec spu_FVSubGiftSend 2, @roul1, 0, @eventsender2, @gameid_, ''
						end
				end


			----------------------------------------------
			-- 특정 동물에서 환생 특별 이벤트
			-- 기간 : 8월 6일 ~ 9월 10일
			----------------------------------------------
			if(@curdate >= @EVENT11_START_DAY and @curdate < @EVENT11_END_DAY)
				begin
					--select 'DEBUG 환생 특별 이벤트.'

					set @cnt11 = 0
					if( @eventspot11 = 0 and @bestani >= 515 )
						begin
							set @cnt11 = 3000
						end
					else if( @eventspot11 = 1 and @bestani >= 519 )
						begin
							set @cnt11 = 5000
						end
					else if( @eventspot11 = 2 and @bestani >= 522 )
						begin
							set @cnt11 = 7000
						end
					else if( @eventspot11 = 3 and @bestani >= 526 )
						begin
							set @cnt11 = 10000
						end

					if(@cnt11 > 0)
						begin
							--select 'DEBUG > 지급', @cnt11 cnt11
							set @eventspot11 	= @eventspot11 + 1
							set @eventsender11 	= @eventsender11 + ltrim(rtrim(str(@eventspot11)))
							exec spu_FVSubGiftSend 2, 3015, @cnt11, @eventsender11, @gameid_, ''
						end
				end


			---------------------------------------------------
			-- 유저 정보 갱신
			---------------------------------------------------
			update dbo.tFVUserMaster
				set
					rebirthcnt		= @rebirthcnt,
					rebirthpoint	= @rebirthpoint,
					rebirthdate		= getdate(),
					eventspot10		= @eventspot10,
					eventspot11		= @eventspot11,
					randserial		= @randserial_
			where gameid = @gameid_

			----------------------------------------------
			-- 세이브 정보 저장.
			----------------------------------------------
			--select 'DEBUG update'
			update dbo.tFVUserData
				set
					savedate	= getdate(),
					savedata 	= @savedata_
			where gameid = @gameid_

			----------------------------------------------
			-- 환생정보.
			----------------------------------------------
			insert into dbo.tFVRebirthLog(gameid,   rebirthpoint)
			values(                      @gameid_, @rebirthpoint_)

			------------------------------------------------------------------
			-- 환생포인트.
			------------------------------------------------------------------
			--exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @pack1, @pack1cnt, '환생포인트', @gameid_, ''


			------------------------------------------------------------------
			-- 환생이벤트.
			-- 목장 환생 1회 : 1000루비
			-- 목장 환생 5회 : 3000루비
			-- 목장 환생 10회 : 5000루비
			-- 목장 환생 20회 : 10000루비
			------------------------------------------------------------------
			set @cnt = case
							when (@rebirthcnt = 1) 	then 1000
							when (@rebirthcnt = 5) 	then 3000
							when (@rebirthcnt = 10) then 5000
							when (@rebirthcnt = 20) then 10000
							else 0
						end
			--select 'DEBUG ', @rebirthcnt rebirthcnt, @cnt cnt

			if(@cnt > 0)
				begin
					--select 'DEBUG 환생선물지급'
					set @eventsender = @eventsender + ltrim(rtrim(str(@rebirthcnt)))
					exec spu_FVSubGiftSend 2, 3015, @cnt, @eventsender, @gameid_, ''
				end


			-- 일 환생 횟수.
			exec spu_FVDayLogInfoStatic @market, 70, 1
			
			---------------------------------------------
			-- 환생지원.
			---------------------------------------------			
			exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT, 3100, 100000, '환생정착지원', @gameid_, ''	-- 코인.
			exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT, 3300, 20,     '환생정착지원', @gameid_, ''		-- 하트.
			exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT, 3000, 300,    '환생정착지원', @gameid_, ''	-- 울제품.
			exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT, 3001, 300,    '환생정착지원', @gameid_, ''	-- 
			exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT, 3002, 300,    '환생정착지원', @gameid_, ''
			exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT, 3003, 300,    '환생정착지원', @gameid_, ''
			exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT, 3004, 300,    '환생정착지원', @gameid_, ''

		END

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	select @nResult_ rtn, @comment comment


	set nocount off
End



