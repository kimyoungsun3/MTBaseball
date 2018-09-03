use Game4FarmVill3
GO

/*
-- 통계수집(spu)
exec spu_FVDayLogInfoStatic 1, 10, 1			 -- 일 일반가입(O)
exec spu_FVDayLogInfoStatic 1, 13, 2             -- 일 게스트가입(O)
exec spu_FVDayLogInfoStatic 1, 11, 3             -- 일 유니크 가입(O)
exec spu_FVDayLogInfoStatic 1, 15, 1             -- 일 카카오초대(O)
exec spu_FVDayLogInfoStatic 1, 16, 1             -- 일 카카오 하트(O)

exec spu_FVDayLogInfoStatic 1, 12, 3             -- 일 로그인(O)
exec spu_FVDayLogInfoStatic 1, 14, 3             -- 일 로그인(O)

exec spu_FVDayLogInfoStatic 1, 27, 1				-- 일 복귀요청수.
exec spu_FVDayLogInfoStatic 1, 28, 1				-- 일 복귀수.

exec spu_FVDayLogInfoStatic 1, 41, 1				-- 일 쿠폰등록수

exec spu_FVDayLogInfoStatic 1, 50, 10			-- 일 push android
exec spu_FVDayLogInfoStatic 1, 51, 1				-- 일 push iphone

exec spu_FVDayLogInfoStatic 1, 60, 700			-- 일 무료충전금액, 횟수.
exec spu_FVDayLogInfoStatic 1, 63, 1			-- 일 일일룰렛
exec spu_FVDayLogInfoStatic 1, 61, 1			-- 일 결정룰렛
exec spu_FVDayLogInfoStatic 1, 62, 1			-- 일 황금무료

exec spu_FVDayLogInfoStatic 1, 81, 1			-- 일 무료 시간 뽑기
exec spu_FVDayLogInfoStatic 1, 82, 1			-- 일 무료 하트 뽑기
exec spu_FVDayLogInfoStatic 1, 83, 1			-- 일 캐쉬뽑기
exec spu_FVDayLogInfoStatic 1, 84, 1			-- 일 캐쉬뽑기2
exec spu_FVDayLogInfoStatic 1, 93, 1			-- 일 캐쉬뽑기  (이벤트 게이지).
exec spu_FVDayLogInfoStatic 1, 94, 1			-- 일 캐쉬뽑기2 (이벤트 게이지).
exec spu_FVDayLogInfoStatic 1, 102, 1			-- 일 무료티켓.
exec spu_FVDayLogInfoStatic 1, 103, 1			-- 일 캐쉬티켓.
exec spu_FVDayLogInfoStatic 1, 104, 1			-- 일 캐쉬티켓2.

exec spu_FVDayLogInfoStatic 1, 100, 1			-- 일 일반강화
exec spu_FVDayLogInfoStatic 1, 101, 1			-- 일 프리미엄강화

exec spu_FVDayLogInfoStatic 1, 110, 1			-- 일 게임 무료충전카운터.(배너형태)

-- select * from dbo.tFVDayLogInfoStatic order by idx desc
*/

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
			insert into dbo.tFVDayLogInfoStatic(dateid8,  market)
			values(                          @dateid8, @market_)
		end

	update dbo.tFVDayLogInfoStatic
		set
			joinplayercnt 	= joinplayercnt		+ CASE WHEN @mode_ = 10 then @cnt_ else 0 end,		-- 일 일반가입
			joinguestcnt 	= joinguestcnt		+ CASE WHEN @mode_ = 13 then @cnt_ else 0 end,		-- 일 게스트가입
			joinukcnt 		= joinukcnt 		+ CASE WHEN @mode_ = 11 then @cnt_ else 0 end,		-- 일 유니크 가입
			invitekakao		= invitekakao		+ CASE WHEN @mode_ = 15 then @cnt_ else 0 end,		-- 일 카카오초대
			kakaoheartcnt	= kakaoheartcnt		+ CASE WHEN @mode_ = 16 then @cnt_ else 0 end,		-- 일 카카오 하트(O)

			logincnt 		= logincnt 			+ CASE WHEN @mode_ = 12 then @cnt_ else 0 end,		-- 일 로그인
			logincnt2 		= logincnt2			+ CASE WHEN @mode_ = 14 then @cnt_ else 0 end,		-- 일 로그인(유니크)

			rtnrequest 		= rtnrequest 		+ CASE WHEN @mode_ = 27 then @cnt_ else 0 end,		-- 일 복귀요청수
			rtnrejoin 		= rtnrejoin 		+ CASE WHEN @mode_ = 28 then @cnt_ else 0 end,		-- 일 복귀수

			pushandroidcnt 	= pushandroidcnt 	+ CASE WHEN @mode_ = 50 then @cnt_ else 0 end,		-- 일 안드로이드푸쉬
			pushiphonecnt 	= pushiphonecnt 	+ CASE WHEN @mode_ = 51 then @cnt_ else 0 end,		-- 일 아이폰푸쉬

			freecashcost 	= freecashcost 		+ CASE WHEN @mode_ = 60 then @cnt_ else 0 end,		-- 일 무료충전금액.
			freecnt		 	= freecnt 			+ CASE WHEN @mode_ = 60 then 1     else 0 end,		-- 일 무료충전횟수.

			roulettefreecnt	= roulettefreecnt	+ CASE WHEN @mode_ = 63 then @cnt_ else 0 end,		-- 일 일일룰렛
			roulettepaycnt	= roulettepaycnt	+ CASE WHEN @mode_ = 61 then @cnt_ else 0 end,		-- 일 결정룰렛
			roulettegoldcnt	= roulettegoldcnt	+ CASE WHEN @mode_ = 62 then @cnt_ else 0 end,		-- 일 황금무료

			roulfreetimetotal		= roulfreetimetotal 		+ CASE WHEN @mode_ = 81 then @cnt_ else 0 end,		--
			roulfreehearttotal		= roulfreehearttotal 		+ CASE WHEN @mode_ = 82 then @cnt_ else 0 end,		--
			roulcashcosttotal		= roulcashcosttotal 		+ CASE WHEN @mode_ = 83 then @cnt_ else 0 end,		--
			roulcashcost2total		= roulcashcost2total 		+ CASE WHEN @mode_ = 84 then @cnt_ else 0 end,		--
			roulcashcostfreetotal	= roulcashcostfreetotal 	+ CASE WHEN @mode_ = 93 then @cnt_ else 0 end,
			roulcashcost2freetotal	= roulcashcost2freetotal 	+ CASE WHEN @mode_ = 94 then @cnt_ else 0 end,
			roulfreetickettotal		= roulfreetickettotal 		+ CASE WHEN @mode_ = 102 then @cnt_ else 0 end,
			roulcashcosttickettotal	= roulcashcosttickettotal 	+ CASE WHEN @mode_ = 103 then @cnt_ else 0 end,
			roulcashcost2tickettotal= roulcashcost2tickettotal 	+ CASE WHEN @mode_ = 104 then @cnt_ else 0 end,

			tsupgradenormal	= tsupgradenormal	+ CASE WHEN @mode_ =100 then @cnt_ else 0 end,		-- 일 일반강화.
			tsupgradepremium= tsupgradepremium	+ CASE WHEN @mode_ =101 then @cnt_ else 0 end,		-- 일 프리미엄강화.


			gamerewardcnt	= gamerewardcnt		+ CASE WHEN @mode_ =110 then @cnt_ else 0 end,		-- 일 게임 무료충전카운터.(배너형태)

			certnocnt 		= certnocnt 		+ CASE WHEN @mode_ = 41 then @cnt_ else 0 end		-- 일 쿠폰등록.
	where dateid8 = @dateid8 and market = @market_

	set nocount off
End
