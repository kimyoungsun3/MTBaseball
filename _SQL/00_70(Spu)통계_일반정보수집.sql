/*
exec spu_DayLogInfoStatic 11, 1             -- 일 유니크 가입(O)
exec spu_DayLogInfoStatic 12, 1             -- 일 로그인(중복)
exec spu_DayLogInfoStatic 14, 1             -- 일 로그인(유니크)

exec spu_DayLogInfoStatic 21, 1				-- 일 조각박스 열기
exec spu_DayLogInfoStatic 22, 1				-- 일 의상박스 열기


exec spu_DayLogInfoStatic 25, 1				-- 일 조합.
exec spu_DayLogInfoStatic 26, 1				-- 일 초월.
exec spu_DayLogInfoStatic 27, 1				-- 일 분해.

exec spu_DayLogInfoStatic 31, 1				-- 일 캐쉬구매

exec spu_DayLogInfoStatic 41, 1				-- 일 연습모드
exec spu_DayLogInfoStatic 42, 1				--   싱글모드
exec spu_DayLogInfoStatic 43, 1				--   멀티모드

select * from dbo.tDayLogInfoStatic order by idx desc
*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_DayLogInfoStatic', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_DayLogInfoStatic;
GO

create procedure dbo.spu_DayLogInfoStatic
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
	if(not exists(select top 1 * from dbo.tDayLogInfoStatic where dateid8 = @dateid8))
		begin
			insert into dbo.tDayLogInfoStatic(dateid8)
			values(@dateid8)
		end

	update dbo.tDayLogInfoStatic
		set
			joinukcnt 		= joinukcnt 		+ CASE WHEN @mode_ = 11 then @cnt_ else 0 end,		-- 일 유니크 가입
			logincnt 		= logincnt 			+ CASE WHEN @mode_ = 12 then @cnt_ else 0 end,		-- 일 로그인
			logincnt2 		= logincnt2			+ CASE WHEN @mode_ = 14 then @cnt_ else 0 end,		-- 일 로그인(유니크)

			pieceboxcnt 	= pieceboxcnt  		+ CASE WHEN @mode_ = 21 then @cnt_ else 0 end,		-- 일 조각박스 열기
			clothesboxcnt 	= clothesboxcnt 	+ CASE WHEN @mode_ = 22 then @cnt_ else 0 end,		-- 일 의상박스 열기

			combinatecnt	= combinatecnt		+ CASE WHEN @mode_ = 25 then @cnt_ else 0 end,		-- 일 조합.
			evolvecnt		= evolvecnt			+ CASE WHEN @mode_ = 26 then @cnt_ else 0 end,		-- 일 초월.
			disapartcnt		= disapartcnt		+ CASE WHEN @mode_ = 27 then @cnt_ else 0 end,		-- 일 분해.

			cashcnt			= cashcnt 			+ CASE WHEN @mode_ = 31 then @cnt_ else 0 end,		-- 일 캐쉬구매

			practicecnt 	= practicecnt 		+ CASE WHEN @mode_ = 41 then @cnt_ else 0 end,		-- 일 연습모드
			singlecnt 		= singlecnt 		+ CASE WHEN @mode_ = 42 then @cnt_ else 0 end,		--   싱글모드
			multicnt		= multicnt 			+ CASE WHEN @mode_ = 43 then @cnt_ else 0 end,		--   멀티모드



			certnocnt 		= certnocnt 		+ CASE WHEN @mode_ = 51 then @cnt_ else 0 end		--   쿠폰
	where dateid8 = @dateid8

	set nocount off
End
