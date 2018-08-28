
--################################################################
-- 통계수집(spu)
-- exec spu_FVDayLogInfoStatic 1, 1, 1				-- 일 SMS 전송
-- exec spu_FVDayLogInfoStatic 1, 2, 2				-- 일 SMS 가입
--
-- exec spu_FVDayLogInfoStatic 1, 10, 1				-- 일 일반가입(O)
-- exec spu_FVDayLogInfoStatic 1, 13, 2               -- 일 게스트가입(O)
-- exec spu_FVDayLogInfoStatic 1, 11, 3               -- 일 유니크 가입(O)

-- exec spu_FVDayLogInfoStatic 1, 12, 3               -- 일 로그인(O)
-- exec spu_FVDayLogInfoStatic 1, 14, 3               -- 일 로그인(O)
-- exec spu_FVDayLogInfoStatic 1, 15, 1               -- 일 카카오초대(O)
-- exec spu_FVDayLogInfoStatic 1, 16, 1               -- 일 카카오 하트(O)
-- exec spu_FVDayLogInfoStatic 1, 17, 1               -- 일 카카오 도와줘친구야(O)
--
-- exec spu_FVDayLogInfoStatic 1, 20, 1				-- 일 하트사용수
-- exec spu_FVDayLogInfoStatic 1, 21, 2				-- 일 일반뽑기
-- exec spu_FVDayLogInfoStatic 1, 22, 3				-- 일 교배뽑기
-- exec spu_FVDayLogInfoStatic 5, 23, 1				-- 일 부활수템(O)
-- exec spu_FVDayLogInfoStatic 5, 24, 1				-- 일 부활수캐쉬(O)
-- exec spu_FVDayLogInfoStatic 5, 25, 1				-- 일 부활수무료(O)
-- exec spu_FVDayLogInfoStatic 5, 26, 1				-- 일 fpoint(무료)
-- exec spu_FVDayLogInfoStatic 1, 27, 1				-- 일 복귀요청수.
-- exec spu_FVDayLogInfoStatic 1, 28, 1				-- 일 복귀수.
--
-- exec spu_FVDayLogInfoStatic 1, 30, 1				-- 일 거래수
-- exec spu_FVDayLogInfoStatic 1, 31, 2				-- 일 상지급수
--
-- exec spu_FVDayLogInfoStatic 1, 40, 1				-- 일 대회참여수
-- exec spu_FVDayLogInfoStatic 1, 41, 1				-- 일 쿠폰등록수
--
-- exec spu_FVDayLogInfoStatic 1, 50, 10				-- 일 push android
-- exec spu_FVDayLogInfoStatic 1, 51, 1				-- 일 push iphone
-- select * from dbo.tFVDayLogInfoStatic order by idx desc
--################################################################
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVDayLogInfoStatic', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVDayLogInfoStatic;
GO

create procedure dbo.spu_FVDayLogInfoStatic
	@market_				int,
	@mode_					int,
	@cnt_					int
	--WITH ENCRYPTION -- 프로시져를 암호화함.
as
	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @dateid8 			varchar(8)		set @dateid8 		= Convert(varchar(8), Getdate(),112)
	--declare @dateid10 		varchar(10) 	set @dateid10 		= Convert(varchar(8), Getdate(),112) + Convert(varchar(2), Getdate(), 108)

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on

	------------------------------------------------
	--	3-2. 입력
	------------------------------------------------
	-- 처음 로우 생성
	if(not exists(select top 1 * from dbo.tFVDayLogInfoStatic where dateid8 = @dateid8 and market = @market_))
		begin
			insert into dbo.tFVDayLogInfoStatic(dateid8, market)
			values(@dateid8, @market_)
		end

	update dbo.tFVDayLogInfoStatic
		set
			smssendcnt 		= smssendcnt 		+ CASE WHEN @mode_ = 1 then @cnt_ else 0 end,		-- 일 SMS 전송
			smsjoincnt 		= smsjoincnt 		+ CASE WHEN @mode_ = 2 then @cnt_ else 0 end,		-- 일 SMS 가입

			joinplayercnt 	= joinplayercnt		+ CASE WHEN @mode_ = 10 then @cnt_ else 0 end,		-- 일 일반가입
			joinguestcnt 	= joinguestcnt		+ CASE WHEN @mode_ = 13 then @cnt_ else 0 end,		-- 일 게스트가입
			joinukcnt 		= joinukcnt 		+ CASE WHEN @mode_ = 11 then @cnt_ else 0 end,		-- 일 유니크 가입
			invitekakao		= invitekakao		+ CASE WHEN @mode_ = 15 then @cnt_ else 0 end,		-- 일 카카오초대
			kakaoheartcnt	= kakaoheartcnt		+ CASE WHEN @mode_ = 16 then @cnt_ else 0 end,		-- 일 카카오 하트(O)
			kakaohelpcnt	= kakaohelpcnt		+ CASE WHEN @mode_ = 17 then @cnt_ else 0 end,		-- 일 카카오 도와줘친구야

			logincnt 		= logincnt 			+ CASE WHEN @mode_ = 12 then @cnt_ else 0 end,		-- 일 로그인
			logincnt2 		= logincnt2			+ CASE WHEN @mode_ = 14 then @cnt_ else 0 end,		-- 일 로그인(유니크)

			heartusecnt 	= heartusecnt 		+ CASE WHEN @mode_ = 20 then @cnt_ else 0 end,		-- 일 하트사용수
			freeroulettcnt 	= freeroulettcnt  	+ CASE WHEN @mode_ = 21 then @cnt_ else 0 end,		-- 일 무료뽑기
			payroulettcnt 	= payroulettcnt 	+ CASE WHEN @mode_ = 22 then @cnt_ else 0 end,		-- 일 유료뽑기
			revivalcnt 		= revivalcnt	 	+ CASE WHEN @mode_ = 23 then @cnt_ else 0 end,		-- 일 유료뽑기
			revivalcntcash 	= revivalcntcash 	+ CASE WHEN @mode_ = 24 then @cnt_ else 0 end,		-- 일 유료뽑기
			revivalcntfree 	= revivalcntfree 	+ CASE WHEN @mode_ = 25 then @cnt_ else 0 end,		-- 일 유료뽑기
			fpointcnt 		= fpointcnt 		+ CASE WHEN @mode_ = 26 then @cnt_ else 0 end,		-- 일 fpoint(무료)
			rtnrequest 		= rtnrequest 		+ CASE WHEN @mode_ = 27 then @cnt_ else 0 end,		-- 일 복귀요청수
			rtnrejoin 		= rtnrejoin 		+ CASE WHEN @mode_ = 28 then @cnt_ else 0 end,		-- 일 복귀수

			tradecnt 		= tradecnt 			+ CASE WHEN @mode_ = 30 then @cnt_ else 0 end,		-- 일 거래수
			prizecnt 		= prizecnt 			+ CASE WHEN @mode_ = 31 then @cnt_ else 0 end,		-- 일 상지급수

			pushandroidcnt 	= pushandroidcnt 	+ CASE WHEN @mode_ = 50 then @cnt_ else 0 end,		-- 일 안드로이드푸쉬
			pushiphonecnt 	= pushiphonecnt 	+ CASE WHEN @mode_ = 51 then @cnt_ else 0 end,		-- 일 아이폰푸쉬

			contestcnt 		= contestcnt 		+ CASE WHEN @mode_ = 40 then @cnt_ else 0 end,		-- 일 대회참여수
			certnocnt 		= certnocnt 		+ CASE WHEN @mode_ = 41 then @cnt_ else 0 end		-- 일 대회참여수
	where dateid8 = @dateid8 and market = @market_

	set nocount off
End
