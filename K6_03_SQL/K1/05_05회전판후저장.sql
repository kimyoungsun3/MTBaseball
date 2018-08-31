use Farm
Go
/*
update dbo.tUserMaster set randserial = -1, roulette = 1, ownercashcost = 10000, wheelgauage = 0, wheelfree = 1 where gameid = 'xxxx@gmail.com'
exec spu_FVWheel 'xxxx@gmail.com',  '01022223331', 5, 20,    0, 'savedata1', 7776, -1			-- 일일회전판(20)    MODE_WHEEL_NORMAL
exec spu_FVWheel 'xxxx@gmail.com',  '01022223331', 5, 21, 1000, 'savedata2', 7777, -1			-- 결정회전판(21)    MODE_WHEEL_PREMINUM
exec spu_FVWheel 'xxxx@gmail.com',  '01022223331', 5, 22,    0, 'savedata3', 7778, -1			-- 황금무료(22)  	 MODE_WHEEL_PREMINUMFREE

select * from dbo.tFVUserWheelLog where gameid = 'xxxx2'
*/

IF OBJECT_ID ( 'dbo.spu_FVWheel', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVWheel;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_FVWheel
	@gameid_								varchar(60),				-- 게임아이디
	@phone_									varchar(20),
	@market_								int,
	@mode_									int,
	@cashcost_								int,
	@savedata_								varchar(4096),
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
	declare @RESULT_ERROR_DAILY_REWARD_ALREADY	int				set @RESULT_ERROR_DAILY_REWARD_ALREADY	= -102			-- 일일보상 이미 보상.

	-- 회전판 상수.
	declare @MODE_WHEEL_NORMAL					int				set @MODE_WHEEL_NORMAL					= 20			-- 일일회전판(20)
	declare @MODE_WHEEL_PREMINUM				int				set @MODE_WHEEL_PREMINUM				= 21			-- 황금회전판(21)
	declare @MODE_WHEEL_PREMINUMFREE			int				set @MODE_WHEEL_PREMINUMFREE			= 22			-- 황금무료(22)

	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @comment				varchar(512)			set @comment		= '세이브'
	declare @comment2				varchar(512)			set @comment2		= ''
	declare @gameid 				varchar(60)				set @gameid			= ''
	declare @roulette				int						set @roulette		= -1
	declare @randserial				varchar(20)				set @randserial		= '-1'
	declare @ownercashcost			bigint					set @ownercashcost	= 0
	declare @ownercashcost2			bigint					set @ownercashcost2	= 0
	declare @idx2					int						set @idx2			= 1
	declare @strange				int						set @strange		= -1
	declare @curdate				datetime				set @curdate		= getdate()

	-- 회전판(회전판)무료뽑기.
	declare @wheelgauageflag		int						set @wheelgauageflag	= -1
	declare @wheelgauagepoint		int						set @wheelgauagepoint	= 10
	declare @wheelgauagemax			int						set @wheelgauagemax		= 100

	-- 회전판 개인정보.
	declare @wheelgauage			int						set @wheelgauage	= -1
	declare @wheelfree				int						set @wheelfree		= -1
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG 입력정보', @gameid_ gameid_, @phone_ phone_, @mode_ mode_, @cashcost_ cashcost_, @savedata_ savedata_, @randserial_ randserial_

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	select
		@gameid 		= gameid,
		@ownercashcost	= ownercashcost,	@roulette		= roulette,
		@wheelgauage	= wheelgauage,		@wheelfree		= wheelfree,
		@randserial		= randserial
	from dbo.tUserMaster
	where gameid = @gameid_ and phone = @phone_
	--select 'DEBUG 유저정보', @gameid gameid, @ownercashcost ownercashcost, @roulette roulette, @wheelgauage wheelgauage, @wheelfree wheelfree, @randserial randserial

	if(@gameid = '')
		BEGIN
			-- 아이디가 존재하지않는가??
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '아이디가 존재하지 않는다. > 아이디를 확인해라.'
			--select 'DEBUG ', @comment
		END
	else if (@mode_ not in (@MODE_WHEEL_NORMAL, @MODE_WHEEL_PREMINUM, @MODE_WHEEL_PREMINUMFREE))
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment = 'ERROR 지원하지 않는 모드입니다.'
			--select 'DEBUG ' + @comment
		END
	else if (@mode_ = @MODE_WHEEL_NORMAL and @roulette = -1)
		BEGIN
			set @nResult_ = @RESULT_ERROR_DAILY_REWARD_ALREADY
			set @comment = 'ERROR 이미 보상을 받아감(1). 1일1회 무료회전판을 2번이상 돌림'
			--select 'DEBUG ' + @comment

			exec spu_FVSubUnusualRecord2  @gameid_, '1일1회 무료회전판을 2번이상 돌림'
		END
	else if (@mode_ = @MODE_WHEEL_PREMINUMFREE and @wheelfree < 1)
		BEGIN
			set @nResult_ = @RESULT_ERROR_DAILY_REWARD_ALREADY
			set @comment = 'ERROR 이미 보상을 받아감(2). 황금무료가 없이 또돌림'
			--select 'DEBUG ' + @comment
			exec spu_FVSubUnusualRecord2  @gameid_, '황금무료가 없이 또돌림'
		END
	else if (@randserial_ = @randserial)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'SUCCESS 회전판 저장 (동일요청)'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '회전판 저장 '
			--select 'DEBUG ', @comment

			------------------------------------------------
			-- 뽑기 이벤트 정보 가져오기.
			------------------------------------------------
			select
				top 1
				-- 회전판(회전판)무료뽑기.> x회후에 1회 무료.
				@wheelgauageflag	= case when (@curdate > roulstart and @curdate <= roulend) then wheelgauageflag		else -1 end,
				@wheelgauagepoint	= wheelgauagepoint,
				@wheelgauagemax		= wheelgauagemax
			from dbo.tFVSystemRouletteMan
			where roulmarket = @market_
			order by idx desc
			--select 'DEBUG ', @wheelgauageflag wheelgauageflag, @wheelgauagepoint wheelgauagepoint, @wheelgauagemax wheelgauagemax

			------------------------------------------------
			-- 뽑기 이벤트 결정회전판 > 황금무료.
			------------------------------------------------
			if(@wheelgauageflag = 1 and @mode_ in (@MODE_WHEEL_PREMINUM))
				begin
					--select 'DEBUG 결정회전판 누적 이벤트중', @wheelgauage wheelgauage
					if(@wheelgauage < @wheelgauagemax)
						begin
							--select 'DEBUG 결정회전판 게이지 누적'
							set @wheelgauage = @wheelgauage + @wheelgauagepoint
						end

					if(@wheelgauage >= @wheelgauagemax)
						begin
							--select 'DEBUG 결정회전판 > 황금무료생성'
							set @wheelgauage = 0
							set @wheelfree	= 1
						end
				end

			----------------------------------------------
			-- 통계정보.
			-- 세이브 정보 > 금액빼기.
			----------------------------------------------
			set @ownercashcost2 = dbo.fnu_GetFVSaveDataToCashcost(@savedata_)
			--select 'DEBUG', @ownercashcost2 ownercashcost2
			if(@mode_ = @MODE_WHEEL_NORMAL)
				begin
					--select 'DEBUG 일일회전판'
					exec spu_FVDayLogInfoStatic @market_, 63, 1			-- 일 일일회전판
					set @roulette = -1
				end
			else if(@mode_ = @MODE_WHEEL_PREMINUM)
				begin
					--select 'DEBUG 결정회전판', @ownercashcost ownercashcost, @ownercashcost2 ownercashcost2, @cashcost_ cashcost_
					exec spu_FVDayLogInfoStatic @market_, 61, 1			-- 일 결정회전판

					if(@ownercashcost2 > @ownercashcost - @cashcost_)
						begin
							set @strange = 1
							set @comment2 = '결정회전판 보유(' + ltrim(rtrim(@ownercashcost)) + ') - 비용(' + ltrim(rtrim(@cashcost_)) + ') < 현재비용(' + ltrim(rtrim(@ownercashcost2)) + ')'
							--select 'DEBUG **** 이상기록', @comment2 comment2
							exec spu_FVSubUnusualRecord2  @gameid_, @comment2
						end
				end
			else if(@mode_ = @MODE_WHEEL_PREMINUMFREE)
				begin
					--select 'DEBUG 황금무료'
					exec spu_FVDayLogInfoStatic @market_, 62, 1			-- 일 황금무료

					if(@wheelfree < 1)
						begin
							set @strange = 1
							set @comment2 = '황금무료 보유(' + ltrim(rtrim(@wheelfree)) + ') 돌렸다.'
							--select 'DEBUG **** 이상기록', @comment2 comment2
							exec spu_FVSubUnusualRecord2  @gameid_, @comment2
						end

					set @wheelfree	= 0
				end

			---------------------------------------------------
			-- 유저회전판 로그기록(200까지만 관리).
			---------------------------------------------------
			select @idx2 = isnull(idx2, 0) + 1 from dbo.tFVUserWheelLog where gameid = @gameid_
			--select 'DEBUG 회전판 로그 기록', @idx2 idx2, @strange strange

			insert into dbo.tFVUserWheelLog(gameid,   idx2,  mode,   cashcost,   ownercashcost,  ownercashcost2,  strange)
			values(                        @gameid_, @idx2, @mode_, @cashcost_, @ownercashcost, @ownercashcost2, @strange)

			delete from dbo.tFVUserWheelLog where idx2 <= @idx2 - 500


			---------------------------------------------------
			-- 유저 정보 갱신
			----로그인
			--	아직안될림  	: <roulette>1</roulette>
			--	돌림			: <roulette>-1</roulette>
			--
			----일반 회전판 돌림.
			--	일반 : userinfo 	20:-1;21:0;22:0;
			--	결정 : userinfo		20:-1;21:1;22:0;
			--	황금 : userinfo		20:-1;21:0;22:1;
			---------------------------------------------------
			--select 'DEBUG 유저 정보 갱신'
			update dbo.tUserMaster
				set
					roulette 		= @roulette,
					ownercashcost	= @ownercashcost2,
					wheelgauage		= @wheelgauage,
					wheelfree		= @wheelfree,
					randserial		= @randserial_
			where gameid = @gameid_

			----------------------------------------------
			-- 세이브 정보 저장.
			----------------------------------------------
			--select 'DEBUG 세이브 정보 저장'
			if(not exists(select top 1 * from dbo.tFVUserData where gameid = @gameid_ and market = @market_))
				begin
					insert into dbo.tFVUserData(gameid,   market,  savedata)
					values(                    @gameid_, @market_, @savedata_)
				end
			else
				begin
					update dbo.tFVUserData
						set
							savedata = @savedata_
					where gameid = @gameid_ and market = @market_
				end

		END


	-----------------------------------------------
	-- 결과코드처리.
	-----------------------------------------------
	select @nResult_ rtn, @comment comment, @roulette roulette, @wheelgauageflag wheelgauageflag, @wheelgauage wheelgauage, @wheelfree wheelfree



	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
End



