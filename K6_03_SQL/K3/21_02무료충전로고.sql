use Game4FarmVill3
Go
/*
-- delete from dbo.tFVFreeCashLog where gameid = 'xxxx2'
select * from dbo.tFVFreeCashLog where gameid = 'xxxx2'

exec spu_FVFreeCash 'xxxx2',  '049000s1i0n7t8445289', 500, 80 , -1
exec spu_FVFreeCash 'xxxx2',  '049000s1i0n7t8445289', 500, 700 , -1

*/

IF OBJECT_ID ( 'dbo.spu_FVFreeCash', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVFreeCash;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_FVFreeCash
	@gameid_								varchar(60),				-- 게임아이디
	@password_								varchar(20),
	@bestani_								int,
	@cashcost_								int,
	@nResult_								int					OUTPUT
	--WITH ENCRYPTION -- 프로시져를 암호화함.
as
	------------------------------------------------
	--	2-1. 코드값자리
	------------------------------------------------
	-- 일반값
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함

	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @comment				varchar(512)			set @comment		= ''
	declare @gameid 				varchar(60)				set @gameid			= ''
	declare @dateid 				varchar(8)				set @dateid 		= Convert(varchar(8), Getdate(), 112)		-- 20120819
	declare @market					int						set @market			= 5

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG 입력정보', @gameid_ gameid_, @password_ password_, @bestani_ bestani_

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	select
		@gameid 	= gameid,
		@market		= market
	from dbo.tFVUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 유저정보', @gameid gameid

	if(@gameid = '')
		BEGIN
			-- 아이디가 존재하지않는가??
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '아이디가 존재하지 않는다.'
			--select 'DEBUG ', @comment
		END
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '로고를 기록했습니다.'
			--select 'DEBUG ', @comment

			---------------------------------------------------
			-- 로고 기록하기
			---------------------------------------------------
			insert into dbo.tFVFreeCashLog(gameid,   bestani,   cashcost)
			values(                       @gameid_, @bestani_, @cashcost_)

			---------------------------------------------------
			-- 토탈로그 기록하기
			---------------------------------------------------
			exec spu_FVDayLogInfoStatic @market, 60, @cashcost_			-- 일 무료충전금액, 횟수.

		END

	-----------------------------------------------
	-- 결과코드처리.
	-----------------------------------------------
	select @nResult_ rtn, @comment comment

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
End



