use Game4FarmVill4
Go
/*
update dbo.tFVUserMaster set randserial = -1, ownercashcost = 10000  where gameid = 'xxxx2'
exec spu_FVTSUgrade 'xxxx2', '049000s1i0n7t8445289', 1, 80010, 0, 1,    0, 100, 'savedata1', -1, 7776, -1			-- 일반강화(1)
exec spu_FVTSUgrade 'xxxx2', '049000s1i0n7t8445289', 2, 80010, 0, 1, 1000,   0, 'savedata2', -1, 7777, -1			-- 결정강화(2)
exec spu_FVTSUgrade 'xxxx2', '049000s1i0n7t8445289', 2, 80010, 0, 1, 1000,   0, 'savedata2',  1, 7777, -1			-- 결정강화(2)

select * from dbo.tFVUserUpgradeLog where gameid = 'xxxx2'
*/

IF OBJECT_ID ( 'dbo.spu_FVTSUgrade', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVTSUgrade;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_FVTSUgrade
	@gameid_								varchar(60),				-- 게임아이디
	@password_								varchar(20),
	@mode_									int,
	@itemcode_								int,
	@step_									int,
	@results_								int,
	@cashcost_								int,
	@heart_									int,
	@savedata_								varchar(8000),
	@sid_									int,
	@randserial_							varchar(20),
	@nResult_								int					OUTPUT
	--WITH ENCRYPTION -- 프로시져를 암호화함.
as
	------------------------------------------------
	--	2-1. 코드값자리
	------------------------------------------------
	-- 일반값
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	--가입 오류.
	declare @RESULT_ERROR_ID_DUPLICATE			int				set @RESULT_ERROR_ID_DUPLICATE			= -2

	-- 세이브 오류.
	--declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--블럭유저 > 팝업처리후 인트로로 빼버린다.
	--declare @RESULT_ERROR_DELETED_USER 		int				set @RESULT_ERROR_DELETED_USER			= -12			--삭제유저 > 팝업처리후 인트로로 빼버린다.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- 지원하지않는모드
	declare @RESULT_ERROR_SESSION_ID_EXPIRE		int				set @RESULT_ERROR_SESSION_ID_EXPIRE		= -150			-- 세션이 만료되었습니다.

	-- 강화 상수.
	declare @MODE_TSUPGRADE_NORMAL				int				set @MODE_TSUPGRADE_NORMAL				= 1		-- 일반강화(1).
	declare @MODE_TSUPGRADE_PREMIUM				int				set @MODE_TSUPGRADE_PREMIUM				= 2		-- 결정강화(2).

	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @comment				varchar(512)			set @comment		= '세이브'
	declare @comment2				varchar(512)			set @comment2		= ''
	declare @gameid 				varchar(60)				set @gameid			= ''
	declare @market					int						set @market			= 5
	declare @randserial				varchar(20)				set @randserial		= '-1'
	declare @ownercashcost			bigint					set @ownercashcost	= 0
	declare @ownercashcost2			bigint					set @ownercashcost2	= 0
	declare @idx2					int						set @idx2			= 1
	declare @strange				int						set @strange		= -1
	declare @curdate				datetime				set @curdate		= getdate()
	declare @sid					int						set @sid			= 0

	-- 보물강화할인.
	declare @tsupgradesaleflag		int						set @tsupgradesaleflag	= -1
	declare @tsupgradesalevalue		int						set @tsupgradesalevalue	=  0
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG 입력정보', @gameid_ gameid_, @password_ password_, @mode_ mode_, @itemcode_ itemcode_, @step_ step_, @results_ results_, @cashcost_ cashcost_, @heart_ heart_, @savedata_ savedata_, @randserial_ randserial_

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	select
		@gameid 	= gameid,
		@market		= market,
		@ownercashcost= ownercashcost,
		@sid		= sid,
		@randserial	= randserial
	from dbo.tFVUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 유저정보', @gameid gameid, @market market, @ownercashcost ownercashcost, @randserial randserial

	if(@gameid = '')
		BEGIN
			-- 아이디가 존재하지않는가??
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '아이디가 존재하지 않는다. > 아이디를 확인해라.'
			--select 'DEBUG ', @comment
		END
	else if(@sid_ != -1 and @sid_ != @sid)
		BEGIN
			-- 세션 ID가 같지 않으면 안됨.
			set @nResult_ 	= @RESULT_ERROR_SESSION_ID_EXPIRE
			set @comment 	= '세션이 만료되어 있습니다. 재로그인합니다.'
			--select 'DEBUG ', @comment
		END
	else if (@mode_ not in (@MODE_TSUPGRADE_NORMAL, @MODE_TSUPGRADE_PREMIUM))
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment = 'ERROR 지원하지 않는 모드입니다.'
			--select 'DEBUG ' + @comment
		END
	else if (@randserial_ = @randserial)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'SUCCESS 강화후 저장 정상처리(동일요청)'

			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '강화후 저장 정상처리'
			--select 'DEBUG ', @comment

			------------------------------------------------
			-- 뽑기 이벤트 정보 가져오기.
			------------------------------------------------
			select
				top 1
				-- 보물강화할인
				@tsupgradesaleflag	= case when (@curdate > roulstart and @curdate <= roulend) then tsupgradesaleflag	else -1 end,
				@tsupgradesalevalue	= case when @tsupgradesaleflag = -1 then 0 else tsupgradesalevalue end
			from dbo.tFVSystemRouletteMan
			where roulmarket = @market
			order by idx desc
			--select 'DEBUG ', @tsupgradesaleflag tsupgradesaleflag, @tsupgradesalevalue tsupgradesalevalue

			----------------------------------------------
			-- 통계정보.
			-- 세이브 정보 > 금액빼기.
			----------------------------------------------
			set @ownercashcost2 = dbo.fnu_GetFVSaveDataToCashcost(@savedata_)
			--select 'DEBUG', @ownercashcost2 ownercashcost2
			if(@mode_ = @MODE_TSUPGRADE_NORMAL)
				begin
					--select 'DEBUG 일반강화'
					exec spu_FVDayLogInfoStatic @market, 100, 1			-- 일 일반강화
				end
			else if(@mode_ = @MODE_TSUPGRADE_PREMIUM)
				begin
					--select 'DEBUG 프리미엄강화', @ownercashcost ownercashcost, @ownercashcost2 ownercashcost2, @cashcost_ cashcost_
					exec spu_FVDayLogInfoStatic @market, 101, 1			-- 일 프리미엄강화

					if(@ownercashcost2 > @ownercashcost - @cashcost_)
						begin
							set @strange = 1
							set @comment2 = '강화이상 보유(' + ltrim(rtrim(@ownercashcost)) + ') - 강화비용(' + ltrim(rtrim(@cashcost_)) + ') < 현재비용(' + ltrim(rtrim(@ownercashcost2)) + ')'
							--select 'DEBUG **** 이상기록', @comment2 comment2
							exec spu_FVSubUnusualRecord2  @gameid_, @comment2
						end
				end

			---------------------------------------------------
			-- 유저강화 로그기록(200까지만 관리).
			---------------------------------------------------
			select @idx2 = isnull(idx2, 0) + 1 from dbo.tFVUserUpgradeLog where gameid = @gameid_
			--select 'DEBUG 개인강화 로그 기록', @idx2 idx2, @strange strange

			insert into dbo.tFVUserUpgradeLog(gameid,    idx2,  mode,   itemcode,   step,   results,   ownercashcost,  ownercashcost2, cashcost,   heart,   strange)
			values(                           @gameid_, @idx2, @mode_, @itemcode_, @step_, @results_, @ownercashcost, @ownercashcost2, @cashcost_, @heart_, @strange)

			delete from dbo.tFVUserUpgradeLog where idx2 <= @idx2 - 500

			---------------------------------------------------
			-- 유저 정보 갱신
			---------------------------------------------------
			update dbo.tFVUserMaster
				set
					ownercashcost	= @ownercashcost2,
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
		END


	-----------------------------------------------
	-- 결과코드처리.
	-----------------------------------------------
	select @nResult_ rtn, @comment comment, @tsupgradesaleflag tsupgradesaleflag, @tsupgradesalevalue tsupgradesalevalue

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
End



