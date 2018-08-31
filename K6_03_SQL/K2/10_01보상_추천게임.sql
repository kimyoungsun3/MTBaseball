/*
-- select * from dbo.tFVSysRecommendLog where gameid = 'xxxx@gmail.com'
-- select * from dbo.tFVGiftList where gameid = 'xxxx@gmail.com'
-- delete from dbo.tFVSysRecommendLog where gameid = 'xxxx@gmail.com'
-- delete from dbo.tFVGiftList where gameid = 'xxxx@gmail.com'

exec spu_FVGameReward 'xxxx@gmail.com',  '01022223331', 1, 7773, -1
exec spu_FVGameReward 'xxxx@gmail.com',  '01022223331', 2, 7774, -1
exec spu_FVGameReward 'xxxx@gmail.com',  '01022223331', 3, 7775, -1
*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVGameReward', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVGameReward;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_FVGameReward
	@gameid_								varchar(60),					-- 게임아이디
	@phone_									varchar(20),					-- 암호화해서저장, 유저패스워가 해킹당해도 안전
	@idx_									int,
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

	-- 로그인 오류.
	--declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--블럭유저 > 팝업처리후 인트로로 빼버린다.
	--declare @RESULT_ERROR_DELETED_USER 		int				set @RESULT_ERROR_DELETED_USER			= -12			--삭제유저 > 팝업처리후 인트로로 빼버린다.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함

	-- 기타오류
	declare @RESULT_ERROR_ALREADY_REWARD		int				set @RESULT_ERROR_ALREADY_REWARD		= -126			-- 무엇인가 이미보상했음.

	------------------------------------------------
	--	2-2. 정의값
	------------------------------------------------

	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @comment				varchar(80)
	declare @gameid 				varchar(60)			set @gameid 		= ''
	declare @market					int					set @market			= 5

	declare @randserial				varchar(20)			set @randserial		= ''
	declare @bgitemcode1			int					set @bgitemcode1	= -1
	declare @bgcnt1					int					set @bgcnt1			= 0

	declare @rewarditemcode			int					set @rewarditemcode	= -1
	declare @rewardcnt				int					set @rewardcnt		= 0

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG 입력정보', @gameid_ gameid_, @password_ password_, @idx_ idx_, @randserial_ randserial_

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	-- 유저 데이타 읽어오기
	select
		@gameid 		= gameid,		@market		= market,
		@randserial		= randserial,
		@bgitemcode1	= bgitemcode1,	@bgcnt1		= bgcnt1
	from dbo.tUserMaster where gameid = @gameid_ and phone = @phone_
	--select 'DEBUG ', @gameid gameid, @market market, @randserial randserial, @bgitemcode1 bgitemcode1, @bgcnt1 bgcnt1

	-- 추천게임 정보보기.
	select
		@rewarditemcode		= rewarditemcode,
		@rewardcnt 			= rewardcnt
	from dbo.tFVSysRecommend2
	where idx = @idx_
	--select 'DEBUG ', @rewarditemcode rewarditemcode, @rewardcnt rewardcnt

	------------------------------------------------
	--	3-3. 각상황별로 코드로 분류
	------------------------------------------------
	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR 아이디가 존재하지 않는다.'
			--select 'DEBUG ' + @comment
		END
	else if (@randserial_ = @randserial)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'SUCCESS 추천 보상을 받기 했습니다.(동일요청)'
			--select 'DEBUG ' + @comment
		END
	else if (exists(select top 1 * from dbo.tFVSysRecommendLog where gameid = @gameid_ and recommendidx = @idx_))
		BEGIN
			set @nResult_ = @RESULT_ERROR_ALREADY_REWARD
			set @comment = 'ERROR 이미 보상을 받았습니다.'
			--select 'DEBUG ' + @comment
		END
	else if (@rewarditemcode = -1)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR 추천보상 코드가 존재하지 않습니다.'
			--select 'DEBUG ' + @comment
		END
	ELSE
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 추천 보상을 받기 했습니다.'
			--select 'DEBUG ' + @comment

			--------------------------------------------------
			-- 아이템 선물
			-- 로그 기록
			--------------------------------------------------
			exec spu_FVSubGiftSend 2, @rewarditemcode, @rewardcnt, 'SysRecom', @gameid_, ''

			insert into dbo.tFVSysRecommendLog(gameid,   recommendidx)
			values(                           @gameid_,         @idx_)

			update dbo.tUserMaster
				set
					randserial	= @randserial_,
					bgitemcode1	= @rewarditemcode,		bgcnt1	= @rewardcnt
			where gameid = @gameid_
		END

	-----------------------------------------------
	-- 결과코드처리.
	-----------------------------------------------
	select @nResult_ rtn, @comment comment
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			--------------------------------------------------------------
			-- 선물/쪽지 리스트 정보
			--------------------------------------------------------------
			exec spu_FVGiftList @gameid_
		end

	set nocount off
End

