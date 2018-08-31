use Game4FarmVill3
GO
/*
select * from dbo.tFVGiftList where gameid = 'xxxx2'
select * from dbo.tFVLevelUpReward where gameid = 'xxxx2' order by idx desc
update dbo.tFVUserMaster set randserial = -1 where gameid = 'xxxx2'
delete from dbo.tFVGiftList where gameid = 'xxxx2'
delete from dbo.tFVLevelUpReward where gameid = 'xxxx2'

exec spu_FVLevelUpReward 'xxxx2',  '049000s1i0n7t8445289', 10, 1,     1, 7771, -1		-- Blue
exec spu_FVLevelUpReward 'xxxx2',  '049000s1i0n7t8445289', 20, 1,   150, 7772, -1
exec spu_FVLevelUpReward 'xxxx2',  '049000s1i0n7t8445289', 30, 1,  3500, 7773, -1
exec spu_FVLevelUpReward 'xxxx2',  '049000s1i0n7t8445289', 40, 1, 40000, 7774, -1

exec spu_FVLevelUpReward 'xxxx2',  '049000s1i0n7t8445289', 10, 2,     1, 7781, -1		-- Red
exec spu_FVLevelUpReward 'xxxx2',  '049000s1i0n7t8445289', 20, 2,   150, 7782, -1
exec spu_FVLevelUpReward 'xxxx2',  '049000s1i0n7t8445289', 30, 2,  3500, 7783, -1
exec spu_FVLevelUpReward 'xxxx2',  '049000s1i0n7t8445289', 40, 2, 40000, 7784, -1


*/

IF OBJECT_ID ( 'dbo.spu_FVLevelUpReward', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVLevelUpReward;
GO

create procedure dbo.spu_FVLevelUpReward
	@gameid_				varchar(60),
	@password_				varchar(20),
	@lv_					int,
	@boxtype_				int,
	@quality_				int,
	@randserial_			varchar(20),
	@nResult_				int				OUTPUT
	--WITH ENCRYPTION -- 프로시져를 암호화함.
as
	------------------------------------------------
	--	2-1. 에러코드값
	------------------------------------------------
	-- 일반값
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	-- 로그인 오류.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- 지원하지않는모드

	-- 선물 정의값
	--declare @GIFTLIST_GIFT_KIND_MESSAGE		int				set @GIFTLIST_GIFT_KIND_MESSAGE			= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int				set @GIFTLIST_GIFT_KIND_GIFT			= 2

	-- 레벨 박스모드
	declare @BOX_TYPE_BLUE						int				set @BOX_TYPE_BLUE						= 1
	declare @BOX_TYPE_RED						int				set @BOX_TYPE_RED						= 2

	-- 레벨 박스보상종류
	declare @BOX_REWARD_COIN					int				set @BOX_REWARD_COIN					= 1
	declare @BOX_REWARD_POINT					int				set @BOX_REWARD_POINT					= 2
	declare @BOX_REWARD_NORMAL_TICKET			int				set @BOX_REWARD_NORMAL_TICKET			= 3
	declare @BOX_REWARD_PREMIUM_TICKET			int				set @BOX_REWARD_PREMIUM_TICKET			= 4

	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @comment			varchar(128)
	declare @gameid				varchar(60)		set @gameid				= ''
	declare @market				int				set @market				= 0
	declare @lv					int				set @lv					= 0
	declare @rewardkind			int				set @rewardkind			= @BOX_REWARD_COIN
	declare @rewarditemcode		int				set @rewarditemcode		= -1
	declare @rewardvalue		decimal(4,1)	set @rewardvalue		= 0
	declare @rewarddate			datetime		set @rewarddate			= '2001-01-01'

	declare @randserial			varchar(20)		set @randserial			= ''
	declare @rand				int
	declare @tmp				int
	declare @curdate			datetime		set @curdate			= getdate()
	declare @timegap			int				set @timegap			= 0
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	set @comment = '알수 없는 오류가 발생했습니다.'
	--select 'DEBUG ', @gameid_ gameid_, @password_ password_, @lv_ lv_, @boxtype_ boxtype_, @quality_ quality_, @randserial_ randserial_

	------------------------------------------------
	--	3-2. 정보획득
	------------------------------------------------
	select
		@gameid 	= gameid,
		@randserial	= randserial
	from dbo.tFVUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 2', @gameid gameid, @randserial randserial

	select top 1
		@lv				= lv,
		@rewardkind 	= rewardkind,
		@rewardvalue	= rewardvalue,
		@rewarditemcode	= rewarditemcode,
		@rewarddate		= writedate
	from dbo.tFVLevelUpReward
	where gameid = @gameid_ order by idx desc

	set @timegap = dbo.fnu_GetDatePart('mi', @rewarddate, @curdate)
	--select 'DEBUG 2', @rewardkind rewardkind, @rewardvalue rewardvalue, @rewarditemcode rewarditemcode, @timegap timegap


	------------------------------------------------
	--	3-3. 유저생성.
	------------------------------------------------
	if (@gameid = '')
		begin
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR 아이디가 존재하지 않는다.'
			--select 'DEBUG 3' + @comment
		end
	else if (@boxtype_ not in (@BOX_TYPE_BLUE, @BOX_TYPE_RED))
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment = 'ERROR 지원하지 않는 모드입니다.'
			--select 'DEBUG ' + @comment
		END
	else if (@randserial_ = @randserial or (@timegap <= 5 and @lv_ = @lv))
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '박스보상 하다.(재전송)'
			--select 'DEBUG ' + @comment

			if(@rewardkind = @BOX_REWARD_COIN)
				begin
					--select 'DEBUG > 코인:0'
					set @rewardvalue	= 0
				end
		END
	else
		begin
			set @nResult_ = @RESULT_SUCCESS
			set @comment 	= '박스보상 하다.'
			--select 'DEBUG 4', @comment

			set @rand 		= Convert(int, ceiling(RAND() * 10000))
			--select 'DEBUG ', @rand rand

			if(@boxtype_ = @BOX_TYPE_BLUE)
				begin
					set @rewardkind 	= dbo.fnu_FVBoxRewardKind(@rand,    	7000, 3000,  0, 0,   @BOX_REWARD_COIN, @BOX_REWARD_POINT, @BOX_REWARD_NORMAL_TICKET, @BOX_REWARD_PREMIUM_TICKET)
					--select 'DEBUG Blue보상', @rewardkind rewardkind
					if(@quality_ <= 149)
						begin
							--select 'DEBUG Blue > 149'
							set @rewardvalue	= dbo.fnu_FVBoxRewardValue(@rewardkind, 1,   1,  0, 0)
						end
					else if(@quality_ <= 3499)
						begin
							--select 'DEBUG Blue > 3499'
							set @rewardvalue	= dbo.fnu_FVBoxRewardValue(@rewardkind, 1.5, 2,  0, 0)
						end
					else if(@quality_ <= 39999)
						begin
							--select 'DEBUG Blue > 39999'
							set @rewardvalue	= dbo.fnu_FVBoxRewardValue(@rewardkind, 2,   3,  0, 0)
						end
					else
						begin
							--select 'DEBUG Blue > max'
							set @rewardvalue	= dbo.fnu_FVBoxRewardValue(@rewardkind, 4,   4,  0, 0)
						end
				end
			else if(@boxtype_ = @BOX_TYPE_RED)
				begin
					set @rewardkind 	= dbo.fnu_FVBoxRewardKind(@rand,    	7000, 2900,  98, 2,   @BOX_REWARD_COIN, @BOX_REWARD_POINT, @BOX_REWARD_NORMAL_TICKET, @BOX_REWARD_PREMIUM_TICKET)
					--select 'DEBUG Red보상', @rewardkind rewardkind
					if(@quality_ <= 149)
						begin
							--select 'DEBUG Red > 1'
							set @rewardvalue	= dbo.fnu_FVBoxRewardValue(@rewardkind, 1,   1,  1, 1)
						end
					else if(@quality_ <= 3499)
						begin
							--select 'DEBUG Red > 2'
							set @rewardvalue	= dbo.fnu_FVBoxRewardValue(@rewardkind, 1.5, 2,  2, 1)
						end
					else if(@quality_ <= 39999)
						begin
							--select 'DEBUG Red > 3'
							set @rewardvalue	= dbo.fnu_FVBoxRewardValue(@rewardkind, 2,   3,  3, 1)
						end
					else
						begin
							--select 'DEBUG Red > 4'
							set @rewardvalue	= dbo.fnu_FVBoxRewardValue(@rewardkind, 3,   4,  4, 1)
						end
				end
			--select 'DEBUG > ', @rewardkind rewardkind, @rewardvalue rewardvalue, @rewarditemcode rewarditemcode




			-------------------------------------
			-- 특정 선물지급.
			-------------------------------------
			if(@rewardkind = @BOX_REWARD_POINT)
				begin
					set @rewarditemcode	= 3016
					exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT, @rewarditemcode, @rewardvalue, '박스보상', @gameid_, ''	-- 연구포인트.
				end
			else if(@rewardkind = @BOX_REWARD_NORMAL_TICKET)
				begin
					set @rewarditemcode	= 3400
					exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT, @rewarditemcode, @rewardvalue, '박스보상', @gameid_, ''	-- 일반 동물 구매권.
				end
			else if(@rewardkind = @BOX_REWARD_PREMIUM_TICKET)
				begin
					set @rewarditemcode	= 3500
					exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT, @rewarditemcode, @rewardvalue, '박스보상', @gameid_, ''	-- 프리미엄 동물 구매권.
				end
			else
				begin
					set @rewarditemcode	= 3100
				end


			-------------------------------------
			-- 로고기록.
			-------------------------------------
			insert into dbo.tFVLevelUpReward(gameid,  lv,   boxtype,   quality,   rewardkind,  rewardvalue,  rewarditemcode)
			values(                         @gameid, @lv_, @boxtype_, @quality_, @rewardkind, @rewardvalue, @rewarditemcode)

		end

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	select @nResult_ rtn, @comment comment, @rewardkind rewardkind, @rewardvalue rewardvalue, @rewarditemcode rewarditemcode
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			------------------------------------------------
			-- 유저정보
			------------------------------------------------
			update dbo.tFVUserMaster
				set
					@randserial	= @randserial_
			where gameid = @gameid_

			--------------------------------------------------------------
			-- 선물함정보.
			--------------------------------------------------------------
			exec spu_FVGiftList @gameid_

		end

	--최종 결과를 리턴한다.
	set nocount off
End



