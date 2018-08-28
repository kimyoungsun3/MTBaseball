/*
-- select * from dbo.tSystemBattleBox order by idx asc
-- delete from dbo.tUserBattleLog where gameid = 'xxxx2'
-- select * from dbo.tUserBattleLog where gameid = 'xxxx2' order by idx desc
-- 최초승(1)
update dbo.tUserMaster set userbattleflag = 1, boxslot1 = -1, boxslot2 = -1, boxslot3 = -1, boxslot4 = -1, boxrotidx = -4 where gameid = 'xxxx2'
exec spu_UserBattleResult 'xxxx2', '049000s1i0n7t8445289', 123,  1, 90, -1

-- 승(1)
update dbo.tUserMaster set userbattleflag = 1, boxslot1 = -1, boxslot2 = -1, boxslot3 = -1, boxslot4 = -1 where gameid = 'xxxx2'
exec spu_UserBattleResult 'xxxx2', '049000s1i0n7t8445289', 123,  1, 90, -1

update dbo.tUserMaster set userbattleflag = 1 where gameid = 'xxxx2'
exec spu_UserBattleResult 'xxxx2', '049000s1i0n7t8445289', 123,  1, 90, -1

-- 패(-1)
update dbo.tUserMaster set userbattleflag = 1, boxslot1 = -1, boxslot2 = -1, boxslot3 = -1, boxslot4 = -1, boxrotidx = -4 where gameid = 'xxxx2'
exec spu_UserBattleResult 'xxxx2', '049000s1i0n7t8445289', 123,  -1, 90, -1

update dbo.tUserMaster set userbattleflag = 1 where gameid = 'xxxx2'
exec spu_UserBattleResult 'xxxx2', '049000s1i0n7t8445289', 123,  -1, 90, -1

*/
use Game4Farmvill5
GO

IF OBJECT_ID ( 'dbo.spu_UserBattleResult', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_UserBattleResult;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_UserBattleResult
	@gameid_								varchar(20),					-- 게임아이디
	@password_								varchar(20),
	@userbattleidx2_						int,
	@result_								int,
	@playtime_								int,
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
	declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--블럭유저 > 팝업처리후 인트로로 빼버린다.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함

	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------
	-- 아이템 소분류.
	declare @ITEM_SUBCATEGORY_STEMCELL			int					set @ITEM_SUBCATEGORY_STEMCELL				= 1040	-- 줄기세포.

	-- 선물정보.
	--declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2

	-- 결과정보.
	declare @BATTLE_RESULT_WIN					int					set @BATTLE_RESULT_WIN				=  1	-- (농장)
	declare @BATTLE_RESULT_LOSE					int					set @BATTLE_RESULT_LOSE				= -1
	declare @BATTLE_RESULT_DRAW					int					set @BATTLE_RESULT_DRAW				=  0

	-- 플레그정보.
	declare @BATTLE_END							int					set @BATTLE_END						= 0
	declare @BATTLE_READY						int					set @BATTLE_READY					= 1

	-- 승패에 따른 트로피 수량
	declare @WIN_TROPHY_COUNT					int					set @WIN_TROPHY_COUNT				= +30
	declare @LOSE_TROPHY_COUNT					int					set @LOSE_TROPHY_COUNT				= -30


	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @comment				varchar(512)		set @comment			= ''
	declare @gameid					varchar(20)			set @gameid				= ''
	declare @trophy					int					set @trophy				= 0
	declare @trophybest				int					set @trophybest			= 0
	declare @tier					int					set @tier				= 1
	declare @boxrotidx 				int					set @boxrotidx			= -4
	declare @idxmax 				int					set @idxmax				= 0
	declare @boxslot1 				int					set @boxslot1			= -1
	declare @boxslot2 				int					set @boxslot2			= -1
	declare @boxslot3 				int					set @boxslot3			= -1
	declare @boxslot4 				int					set @boxslot4			= -1
	declare @userbattleflag			int					set @userbattleflag		= @BATTLE_END
	declare @userbattleresult		int					set @userbattleresult	= @BATTLE_RESULT_WIN
	declare @userbattlepoint		int					set @userbattlepoint	= 0

	-- 유저배틀박스.
	declare @result					int					set @result				= -444
	declare @slotempty 				int					set @slotempty			= -1
	declare @rand					int
	declare @rewardbox				int					set @rewardbox			= -1

	-- 상대의 정보에 따른 트로피.
	declare @othertrophy			int					set @othertrophy		= 0
	declare @othertier				int					set @othertier			= 1
	declare @gettrophy				int					set @gettrophy			= 0

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG 입력정보', @gameid_ gameid_, @password_ password_, @userbattleidx2_ userbattleidx2_, @result_ result_, @playtime_ playtime_

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	select
		@gameid 		= gameid,			@userbattleresult= userbattleresult,@userbattlepoint= userbattlepoint,
		@trophy			= trophy,			@trophybest		= trophybest,		@tier			= tier,				@boxrotidx		= boxrotidx,
		@boxslot1		= boxslot1,			@boxslot2		= boxslot2,			@boxslot3		= boxslot3,			@boxslot4		= boxslot4,
		@userbattleflag	= userbattleflag
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 유저정보', @gameid gameid, @trophy trophy, @trophybest trophybest, @tier tier, @boxrotidx boxrotidx, @boxslot1 boxslot1, @boxslot2 boxslot2, @boxslot3 boxslot3, @boxslot4 boxslot4, @userbattleflag userbattleflag

	select
		@result		= result,	@othertrophy= othertrophy,	@othertier	= othertier
	from dbo.tUserBattleLog
	where gameid = @gameid_ and idx2 = @userbattleidx2_
	--select 'DEBUG 배틀정보', @userbattleidx2_ userbattleidx2_, @result result

	------------------------------------------------
	-- 3-3. 각 조건별 분기
	------------------------------------------------
	if( @gameid = '' )
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR 아이디가 존재하지 않는다.'
			--select 'DEBUG ' + @comment
		END
	else if(@userbattleflag != @BATTLE_READY)
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 완료했습니다.(미진행중 완료 패스용)'
			--select 'DEBUG ' + @comment
		END
	else if(@result = -444)
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 완료했습니다.(로고가 없어서 완료 패스용)'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 완료했습니다.'
			--select 'DEBUG ' + @comment


			if( @result_ = @BATTLE_RESULT_WIN )
				begin
					--------------------------------------------
					-- 박스 빈곳 위치 확인.
					--------------------------------------------
					if( @boxslot1 = -1 )
						begin
							set @slotempty 		= 1
						end
					else if( @boxslot2 = -1 )
						begin
							set @slotempty 		= 2
						end
					else if( @boxslot3 = -1 )
						begin
							set @slotempty 		= 3
						end
					else if( @boxslot4 = -1 )
						begin
							set @slotempty 		= 4
						end
					--select 'DEBUG 빈곳위치확인', @slotempty slotempty, @boxslot1 boxslot1, @boxslot2 boxslot2, @boxslot3 boxslot3, @boxslot4 boxslot4

					--------------------------------------------
					-- 박스로테이션 박스지급하기.
					-- -4 -> ... -> 0 -> ... -> 250
					-- 				0 -> ... -> 250
					--------------------------------------------
					if( @slotempty != -1)
						begin
							select @rewardbox = box from dbo.tSystemBattleBox where idx = @boxrotidx
							--select 'DEBUG 지급', @boxrotidx boxrotidx, @rewardbox rewardbox

							if( @boxslot1 = -1 )
								begin
									set @boxslot1 		= @rewardbox
									--select 'DEBUG 지급슬로1번', @rewardbox rewardbox
								end
							else if( @boxslot2 = -1 )
								begin
									set @boxslot2 		= @rewardbox
									--select 'DEBUG 지급슬로2번', @rewardbox rewardbox
								end
							else if( @boxslot3 = -1 )
								begin
									set @boxslot3 		= @rewardbox
									--select 'DEBUG 지급슬로3번', @rewardbox rewardbox
								end
							else if( @boxslot4 = -1 )
								begin
									set @boxslot4 		= @rewardbox
									--select 'DEBUG 지급슬로4번', @rewardbox rewardbox
								end


							--select 'DEBUG 로테이션(전)', @boxrotidx boxrotidx
							select @idxmax = max(idx) from dbo.tSystemBattleBox
							set @boxrotidx = case when ( @boxrotidx + 1 ) > @idxmax then 0 else ( @boxrotidx + 1 ) end
							--select 'DEBUG 로테이션(후)', @boxrotidx boxrotidx
						end

					--------------------------------------------
					-- 트로피 정리(기본+티어+트로피차이).
					--------------------------------------------
					set @gettrophy 	= @WIN_TROPHY_COUNT


					------------------------------------------------
					-- 랭킹대전 정보수집.
					------------------------------------------------
					exec spu_subRankDaJun @gameid_, 0, 0, 10, 0, 0, 0, 0		-- 배틀 포인트
				end
			else
				begin
					--------------------------------------------
					-- 트로피 정리(기본+티어+트로피차이).
					--------------------------------------------
					set @gettrophy 	= @LOSE_TROPHY_COUNT
				end

			--------------------------------------------
			-- 트로피 계산
			-- 1차 : 상대의 트로차이
			-- 2차 : 연속 승, 패
			-- 3차 : 승 + 짧은 시간
			--------------------------------------------
			-- 1차 트로피 계산 1차 > 상대 트로피에 따라서...
			set @gettrophy 	= @gettrophy
							  + case
							  		when ( @othertrophy -  @trophy ) / 5 < -25 then -25
							  		when ( @othertrophy -  @trophy ) / 5 > +25 then +25
							  		else ( @othertrophy -  @trophy ) / 5
							  	end

			-- 2차 트로피 계산 2차 > 연속승패...
			if( @userbattleresult != @result_ )
				begin
					set @userbattleresult 	= @result_
					set @userbattlepoint 	= 0
				end
			else if( @userbattleresult = @BATTLE_RESULT_WIN )
				begin
					set @userbattleresult 	= @result_
					set @userbattlepoint 	= @userbattlepoint + 1
				end
			else if( @userbattleresult = @BATTLE_RESULT_LOSE )
				begin
					set @userbattleresult 	= @result_
					set @userbattlepoint 	= @userbattlepoint - 1
				end
			else if( @userbattleresult = @BATTLE_RESULT_DRAW )
				begin
					set @userbattleresult 	= @result_
					set @userbattlepoint 	= 0
				end
			set @gettrophy = @gettrophy + @userbattlepoint

			-- 3차 : 승 + 짧은 시간
			if( @result_ = @BATTLE_RESULT_WIN and @playtime_ < 30 )
				begin
					set @gettrophy = @gettrophy + case
														when @playtime_ < 10 then 30
														when @playtime_ < 16 then 20
														when @playtime_ < 24 then 10
														when @playtime_ < 26 then  5
														when @playtime_ < 28 then  2
														else   					   1
												   end

				end

			-- 트로피 계산
			set @trophy 	= @trophy + @gettrophy
			set @trophy 	= case
									when @trophy > 3000 then 3000
									when @trophy <    0 then    0
									else @trophy
							 end
			set @tier 		= dbo.fun_GetTier( @trophy )
			set @trophybest = case when @trophybest > @trophy then @trophybest else @trophy end


			----------------------------------
			-- 유저정보갱신.
			----------------------------------
			update dbo.tUserMaster
				set
					userbattleresult= @userbattleresult,
					userbattlepoint	= @userbattlepoint,
					trophy		= @trophy,		trophybest	= @trophybest,	tier 		= @tier,		boxrotidx	= @boxrotidx,
					boxslot1	= @boxslot1,	boxslot2	= @boxslot2,	boxslot3	= @boxslot3,	boxslot4	= @boxslot4,
					userbattleflag= @BATTLE_END
			where gameid = @gameid_

			----------------------------------
			-- 로고 정보갱신
			----------------------------------
			update dbo.tUserBattleLog
				set
					result 		= @result_,		playtime	= @playtime_
			where gameid = @gameid_ and idx2 = @userbattleidx2_
		END


	------------------------------------------------
	--	4-2. 유저정보
	------------------------------------------------
	set nocount off

	select @nResult_ rtn, @comment comment, @rewardbox rewardbox,
		   @trophy trophy, @tier tier, @gettrophy gettrophy,
		   @boxslot1 boxslot1, @boxslot2 boxslot2, @boxslot3 boxslot3, @boxslot4 boxslot4

End

