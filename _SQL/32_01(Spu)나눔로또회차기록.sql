
/*
exec spu_LottoPowerBallTime 821730, 19, 12, 15, 9, 10, 4, -1
*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_LottoPowerBallTime', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_LottoPowerBallTime;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_LottoPowerBallTime
	@curturntime_							int,
	@curturnnum1_							int,
	@curturnnum2_							int,
	@curturnnum3_							int,
	@curturnnum4_							int,
	@curturnnum5_							int,
	@curturnnum6_							int,
	@nResult_								int					OUTPUT
	WITH ENCRYPTION -- 프로시져를 암호화함.
as
	------------------------------------------------
	--	2-1. 코드값자리
	------------------------------------------------
	-- 일반값
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	declare @MODE_POWERBALL						int				set	@MODE_POWERBALL						= 1;
	declare @MODE_TOTALBALL						int				set	@MODE_TOTALBALL						= 2;

	declare @KIND_GRADE							int				set	@KIND_GRADE							= 1;
	declare @KIND_EVENODD						int				set	@KIND_EVENODD						= 2;
	declare @KIND_UNDEROVER						int				set	@KIND_UNDEROVER						= 3;
	declare @KIND_GRADE2						int				set	@KIND_GRADE2						= 4;

	declare @TURNTIME_SECOND					int				set @TURNTIME_SECOND					= 5 * 60
	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @comment					varchar(512)			set @comment		= 'ERROR 알수없는 오류(-1)'
	declare @nextturntime				int
	declare @nextturndate				datetime
	declare @totalball					int


Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	select 'DEBUG ', @curturntime_ curturntime_, @curturnnum1_ curturnnum1_, @curturnnum2_ curturnnum2_, @curturnnum3_ curturnnum3_, @curturnnum4_ curturnnum4_, @curturnnum5_ curturnnum5_, @curturnnum6_ curturnnum6_

	------------------------------------------------
	-- 3-3. 각 조건별 분기
	------------------------------------------------
	select 'DEBUG ', * from dbo.tLottoInfo where curturntime = @curturntime_
	if(not exists(select top 1 * from dbo.tLottoInfo where curturntime = @curturntime_))
		begin
			set @nResult_ = @RESULT_SUCCESS
			set @comment = '정상 처리 했습니다.'

			set @nextturntime	= @curturntime_ + 1
			set @nextturndate 	= DATEADD(ss, @TURNTIME_SECOND, getdate());
			set @totalball 		= @curturnnum1_ + @curturnnum2_ + @curturnnum3_ + @curturnnum4_ + @curturnnum5_


			insert into dbo.tLottoInfo(
					curturntime, 	curturndate,
					curturnnum1, 	curturnnum2, 	curturnnum3, 	curturnnum4, 	curturnnum5, 	curturnnum6,
					pbgrade, pbevenodd, pbunderover,
					totalball, tbgrade, tbevenodd, tbunderover, tbgrade2,
					nextturntime, nextturndate
			)
			values(
					@curturntime_,	getdate(),
					@curturnnum1_, 	@curturnnum2_, 	@curturnnum3_, 	@curturnnum4_, 	@curturnnum5_, 	@curturnnum6_,
					dbo.fnu_GetBallInfo(@MODE_POWERBALL, @KIND_GRADE, @curturnnum6_),
					dbo.fnu_GetBallInfo(@MODE_POWERBALL, @KIND_EVENODD, @curturnnum6_),
					dbo.fnu_GetBallInfo(@MODE_POWERBALL, @KIND_UNDEROVER, @curturnnum6_),
					@totalball,
					dbo.fnu_GetBallInfo(@MODE_TOTALBALL, @KIND_GRADE, @totalball),
					dbo.fnu_GetBallInfo(@MODE_TOTALBALL, @KIND_EVENODD, @totalball),
					dbo.fnu_GetBallInfo(@MODE_TOTALBALL, @KIND_UNDEROVER, @totalball),
					dbo.fnu_GetBallInfo(@MODE_TOTALBALL, @KIND_GRADE2, @totalball),
					@nextturntime, @nextturndate
			)
		END



	------------------------------------------------
	--	4-2. 유저정보
	------------------------------------------------
	select @nResult_ rtn, @comment comment

	set nocount off
End

