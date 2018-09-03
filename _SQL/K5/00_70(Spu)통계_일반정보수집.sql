/*
exec spu_DayLogInfoStatic 1, 1, 1				-- 일 SMS 전송
exec spu_DayLogInfoStatic 1, 2, 2				-- 일 SMS 가입

exec spu_DayLogInfoStatic 1, 10, 1				-- 일 일반가입(O)
exec spu_DayLogInfoStatic 1, 13, 2             -- 일 게스트가입(O)
exec spu_DayLogInfoStatic 1, 11, 3             -- 일 유니크 가입(O)

exec spu_DayLogInfoStatic 1, 12, 3             -- 일 로그인(O)
exec spu_DayLogInfoStatic 1, 14, 3             -- 일 로그인(O)
exec spu_DayLogInfoStatic 1, 15, 1             -- 일 카카오초대(O)
exec spu_DayLogInfoStatic 1, 16, 1             -- 일 카카오 하트(O)
exec spu_DayLogInfoStatic 1, 17, 1             -- 일 카카오 도와줘친구야(O)

exec spu_DayLogInfoStatic 1, 20, 1				-- 일 하트사용수
exec spu_DayLogInfoStatic 5, 23, 1				-- 일 부활수템(O)
exec spu_DayLogInfoStatic 5, 24, 1				-- 일 부활수캐쉬(O)
exec spu_DayLogInfoStatic 5, 25, 1				-- 일 부활수무료(O)
exec spu_DayLogInfoStatic 5, 26, 1				-- 일 fpoint(무료)
exec spu_DayLogInfoStatic 1, 27, 1				-- 일 복귀요청수.
exec spu_DayLogInfoStatic 1, 28, 1				-- 일 복귀수.

exec spu_DayLogInfoStatic 1, 61, 1				-- 일 동물 일반뽑기
exec spu_DayLogInfoStatic 1, 62, 1				-- 일      프리미엄
exec spu_DayLogInfoStatic 1, 63, 1				-- 일      프리미엄2
exec spu_DayLogInfoStatic 1, 64, 1				-- 일      강화.
exec spu_DayLogInfoStatic 1, 65, 1				-- 일      일반합성.
exec spu_DayLogInfoStatic 1, 66, 1				-- 일      캐쉬합성.
exec spu_DayLogInfoStatic 1, 67, 1				-- 일      일반승급.

exec spu_DayLogInfoStatic 1, 71, 2				-- 일 보물 일반뽑기
exec spu_DayLogInfoStatic 1, 72, 2				-- 일      프리미엄
exec spu_DayLogInfoStatic 1, 73, 2				-- 일      프리미엄2
exec spu_DayLogInfoStatic 1, 74, 1				-- 일      업글(Normal)
exec spu_DayLogInfoStatic 1, 75, 1				-- 일      업글(Pre)
--select tsupgradenor, tsupgradepre from dbo.tDayLogInfoStatic order by idx desc

exec spu_DayLogInfoStatic 1, 30, 1				-- 일 거래수.
exec spu_DayLogInfoStatic 1, 32, 1				-- 일 배틀수.
exec spu_DayLogInfoStatic 1, 33, 1				-- 일 배틀횟수구매.
exec spu_DayLogInfoStatic 1, 31, 2				-- 일 상지급수
exec spu_DayLogInfoStatic 1, 34, 1				-- 일 유저배틀수.

exec spu_DayLogInfoStatic 1, 40, 1				-- 일 대회참여수
exec spu_DayLogInfoStatic 1, 41, 1				-- 일 쿠폰등록수

exec spu_DayLogInfoStatic 1, 50, 10				-- 일 push android
exec spu_DayLogInfoStatic 1, 51, 1				-- 일 push iphone

exec spu_DayLogInfoStatic 1, 81, 1				-- 일 캐쉬구매(일반)
exec spu_DayLogInfoStatic 1, 82, 1				-- 일 캐쉬구매(생애)

exec spu_DayLogInfoStatic 1, 90, 1				-- 일 박스오픈시간되어서.
exec spu_DayLogInfoStatic 1, 91, 1				-- 일 박스오픈시간단축
exec spu_DayLogInfoStatic 1, 92, 1				-- 일 박스즉시오픈

exec spu_DayLogInfoStatic 1, 100, 1				-- 일 무료룰렛.
exec spu_DayLogInfoStatic 1, 101, 1				-- 일 황금룰렛.
exec spu_DayLogInfoStatic 1, 102, 1				-- 일 황금무료.

exec spu_DayLogInfoStatic 1, 110, 1				-- 일 짜요쿠폰뽑기 무료.
exec spu_DayLogInfoStatic 1, 111, 1				-- 일 짜요쿠폰뽑기 유료.

exec spu_DayLogInfoStatic 1, 120, 1				-- 일 거래   짜요쿠폰조각 룰렛등장.
exec spu_DayLogInfoStatic 1, 121, 1				-- 일 박스   짜요쿠폰조각 룰렛등장.
exec spu_DayLogInfoStatic 1, 122, 1				-- 일 경작지건초 짜요쿠폰조각 룰렛등장.
exec spu_DayLogInfoStatic 1, 123, 1				-- 일 경작지하트 짜요쿠폰조각 룰렛등장.

select * from dbo.tDayLogInfoStatic order by idx desc
*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_DayLogInfoStatic', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_DayLogInfoStatic;
GO

create procedure dbo.spu_DayLogInfoStatic
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
	if( @cnt_ = 0 )return;

	------------------------------------------------
	--	3-2. 입력
	------------------------------------------------
	-- 처음 로우 생성
	if(not exists(select top 1 * from dbo.tDayLogInfoStatic where dateid8 = @dateid8 and market = @market_))
		begin
			insert into dbo.tDayLogInfoStatic(dateid8, market)
			values(@dateid8, @market_)
		end

	update dbo.tDayLogInfoStatic
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
			--freeroulettcnt = freeroulettcnt  	+ CASE WHEN @mode_ = 21 then @cnt_ else 0 end,		-- 일 일반뽑기
			--payroulettcnt = payroulettcnt 	+ CASE WHEN @mode_ = 22 then @cnt_ else 0 end,		-- 일 유료뽑기
			revivalcnt 		= revivalcnt	 	+ CASE WHEN @mode_ = 23 then @cnt_ else 0 end,		-- 일
			revivalcntcash 	= revivalcntcash 	+ CASE WHEN @mode_ = 24 then @cnt_ else 0 end,		-- 일
			revivalcntfree 	= revivalcntfree 	+ CASE WHEN @mode_ = 25 then @cnt_ else 0 end,		-- 일
			fpointcnt 		= fpointcnt 		+ CASE WHEN @mode_ = 26 then @cnt_ else 0 end,		-- 일 fpoint(무료)
			rtnrequest 		= rtnrequest 		+ CASE WHEN @mode_ = 27 then @cnt_ else 0 end,		-- 일 복귀요청수
			rtnrejoin 		= rtnrejoin 		+ CASE WHEN @mode_ = 28 then @cnt_ else 0 end,		-- 일 복귀수

			freeroulettcnt 	= freeroulettcnt  	+ CASE WHEN @mode_ = 61 then @cnt_ else 0 end,		-- 일 동물뽑기
			payroulettcnt 	= payroulettcnt 	+ CASE WHEN @mode_ = 62 then @cnt_ else 0 end,		-- 일 유료뽑기
			payroulettcnt2 	= payroulettcnt2 	+ CASE WHEN @mode_ = 63 then @cnt_ else 0 end,		-- 일 유료뽑기2
			aniupgradecnt 	= aniupgradecnt 	+ CASE WHEN @mode_ = 64 then @cnt_ else 0 end,		-- 일 동물강화.
			freeanicomposecnt= freeanicomposecnt+ CASE WHEN @mode_ = 65 then @cnt_ else 0 end,		-- 일 동물일반합성.
			payanicomposecnt = payanicomposecnt + CASE WHEN @mode_ = 66 then @cnt_ else 0 end,		-- 일 동물캐쉬합성.
			anipromotecnt 	= anipromotecnt 	+ CASE WHEN @mode_ = 67 then @cnt_ else 0 end,		-- 일 동물일반승급.

			freetreasurecnt = freetreasurecnt  	+ CASE WHEN @mode_ = 71 then @cnt_ else 0 end,		-- 일 보물뽑기
			paytreasurecnt 	= paytreasurecnt 	+ CASE WHEN @mode_ = 72 then @cnt_ else 0 end,		-- 일 유료뽑기
			paytreasurecnt2 = paytreasurecnt2 	+ CASE WHEN @mode_ = 73 then @cnt_ else 0 end,		-- 일 유료뽑기2
			tsupgradenor 	= tsupgradenor 		+ CASE WHEN @mode_ = 74 then @cnt_ else 0 end,
			tsupgradepre	= tsupgradepre 		+ CASE WHEN @mode_ = 75 then @cnt_ else 0 end,

			cashcnt			= cashcnt 			+ CASE WHEN @mode_ = 81 then @cnt_ else 0 end,		-- 일 캐쉬구매(일반)
			cashcnt2		= cashcnt2 			+ CASE WHEN @mode_ = 82 then @cnt_ else 0 end,		-- 일 캐쉬구매(생애)

			boxopenopen		= boxopenopen 		+ CASE WHEN @mode_ = 90 then @cnt_ else 0 end,		-- 일 박스오픈시간되어서.
			boxopencash		= boxopencash 		+ CASE WHEN @mode_ = 91 then @cnt_ else 0 end,		-- 일 박스오픈시간단축
			boxopentriple	= boxopentriple		+ CASE WHEN @mode_ = 92 then @cnt_ else 0 end,		-- 일 박스즉시오픈

			tradecnt 		= tradecnt 			+ CASE WHEN @mode_ = 30 then @cnt_ else 0 end,		-- 일 거래수
			prizecnt 		= prizecnt 			+ CASE WHEN @mode_ = 31 then @cnt_ else 0 end,		-- 일 상지급수
			battlecnt 		= battlecnt			+ CASE WHEN @mode_ = 32 then @cnt_ else 0 end,		-- 일 배틀.
			playcntbuy 		= playcntbuy		+ CASE WHEN @mode_ = 33 then @cnt_ else 0 end,		-- 일 배틀횟수구매.
			userbattlecnt 	= userbattlecnt		+ CASE WHEN @mode_ = 34 then @cnt_ else 0 end,		-- 일 유저배틀.

			pushandroidcnt 	= pushandroidcnt 	+ CASE WHEN @mode_ = 50 then @cnt_ else 0 end,		-- 일 안드로이드푸쉬
			pushiphonecnt 	= pushiphonecnt 	+ CASE WHEN @mode_ = 51 then @cnt_ else 0 end,		-- 일 아이폰푸쉬

			wheelnor 		= wheelnor 			+ CASE WHEN @mode_ = 100 then @cnt_ else 0 end,		-- 일 무료룰렛.
			wheelpre 		= wheelpre 			+ CASE WHEN @mode_ = 101 then @cnt_ else 0 end,		-- 일 황금룰렛
			wheelprefree 	= wheelprefree 		+ CASE WHEN @mode_ = 102 then @cnt_ else 0 end,		-- 일 황금무료

			zcpcntfree 		= zcpcntfree		+ CASE WHEN @mode_ = 110 then @cnt_ else 0 end,		-- 일 짜요쿠폰뽑기 무료
			zcpcntcash 		= zcpcntcash 		+ CASE WHEN @mode_ = 111 then @cnt_ else 0 end,		-- 일 짜요쿠폰뽑기 유료

			zcpappeartradecnt= zcpappeartradecnt+ CASE WHEN @mode_ = 120 then @cnt_ else 0 end,		-- 일 거래   짜요쿠폰조각 룰렛등장.
			zcpappearboxcnt	= zcpappearboxcnt	+ CASE WHEN @mode_ = 121 then @cnt_ else 0 end,		-- 일 박스   짜요쿠폰조각 룰렛등장.
			zcpappearfeedcnt= zcpappearfeedcnt	+ CASE WHEN @mode_ = 122 then @cnt_ else 0 end,		-- 일 경작지건초 짜요쿠폰조각 룰렛등장.
			zcpappearheartcnt= zcpappearheartcnt+ CASE WHEN @mode_ = 123 then @cnt_ else 0 end,		-- 일 경작지하트 짜요쿠폰조각 룰렛등장.

			contestcnt 		= contestcnt 		+ CASE WHEN @mode_ = 40 then @cnt_ else 0 end,		-- 일 대회참여수
			certnocnt 		= certnocnt 		+ CASE WHEN @mode_ = 41 then @cnt_ else 0 end		-- 일 대회참여수
	where dateid8 = @dateid8 and market = @market_

	set nocount off
End
