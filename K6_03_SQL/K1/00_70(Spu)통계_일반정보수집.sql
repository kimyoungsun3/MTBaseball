use Farm
GO
/*
-- 통계수집(spu)
exec spu_FVDayLogInfoStatic 5, 11, 1               -- 일 유니크 가입(무료)
exec spu_FVDayLogInfoStatic 5, 15, 1               -- 일 유니크 가입(유료)
exec spu_FVDayLogInfoStatic 5, 12, 1               -- 일 로그인(중복)
exec spu_FVDayLogInfoStatic 5, 14, 1               -- 일 로그인(유니크)
exec spu_FVDayLogInfoStatic 5, 17, 1               -- 일 초대

exec spu_FVDayLogInfoStatic 1, 41, 1				-- 일 쿠폰등록수

exec spu_FVDayLogInfoStatic 1, 63, 1			-- 일 일일룰렛
exec spu_FVDayLogInfoStatic 1, 61, 1			-- 일 결정룰렛	(일 유료룰렛수)
exec spu_FVDayLogInfoStatic 1, 62, 1			-- 일 황금무료

select * from dbo.tFVDayLogInfoStatic order by idx desc

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
			insert into dbo.tFVDayLogInfoStatic(dateid8, market)
			values(@dateid8, @market_)
		end

	update dbo.tFVDayLogInfoStatic
		set
			joinukcnt 		= joinukcnt 		+ CASE WHEN @mode_ = 11 then @cnt_ else 0 end,		-- 일 유니크 가입(무료)
			logincnt 		= logincnt 			+ CASE WHEN @mode_ = 12 then @cnt_ else 0 end,		-- 일 로그인(중복)
			logincnt2 		= logincnt2			+ CASE WHEN @mode_ = 14 then @cnt_ else 0 end,		-- 일 로그인(유니크)
			joinukcnt2 		= joinukcnt2 		+ CASE WHEN @mode_ = 15 then @cnt_ else 0 end,		-- 일 유니크 가입(유료)
			invitekakao		= invitekakao		+ CASE WHEN @mode_ = 17 then @cnt_ else 0 end,		-- 일 카카오초대

			roulettefreecnt	= roulettefreecnt	+ CASE WHEN @mode_ = 63 then @cnt_ else 0 end,		-- 일 일일룰렛
			roulettepaycnt	= roulettepaycnt	+ CASE WHEN @mode_ = 61 then @cnt_ else 0 end,		-- 일 결정룰렛
			roulettegoldcnt	= roulettegoldcnt	+ CASE WHEN @mode_ = 62 then @cnt_ else 0 end,		-- 일 황금무료

			certnocnt 		= certnocnt 		+ CASE WHEN @mode_ = 41 then @cnt_ else 0 end		-- 일 대회참여수
	where dateid8 = @dateid8 and market = @market_

	set nocount off
End
