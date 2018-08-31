/*
update dbo.tFVUserMaster set kakaomsginvitecnt = 9, kakaomsginvitetodaycnt = 0, kakaomsginvitetodaydate = kakaomsginvitetodaydate - 1 	where gameid = 'xxxx2'
update dbo.tFVUserMaster set kakaomsginvitetodaydate = kakaomsginvitetodaydate - 1 	where gameid = 'xxxx2'
update dbo.tFVKakaoInvite set senddate = senddate - 31 where gameid = 'xxxx2'
-- delete from dbo.tFVKakaoInvite where gameid = 'xxxx2'
-- delete from dbo.tFVGiftList where gameid = 'xxxx2'
exec spu_FVKakaoFriendInvite 'xxxx2',  '049000s1i0n7t8445289', 'kakaouseridxxxx', -1
exec spu_FVKakaoFriendInvite 'xxxx2',  '049000s1i0n7t8445289', 'kakaouseridxxxx3', -1

*/
use Game4FarmVill4
GO

IF OBJECT_ID ( 'dbo.spu_FVKakaoFriendInvite', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVKakaoFriendInvite;
GO

create procedure dbo.spu_FVKakaoFriendInvite
	@gameid_				varchar(60),
	@password_				varchar(20),
	@kakaouserid_			varchar(60),
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
	declare @RESULT_ERROR_TIME_REMAIN			int				set @RESULT_ERROR_TIME_REMAIN			= -123			-- 아직 시간이 남음.

	-- 초대에 대한 상수.
	declare @SENDEDDAY_INIT						int				set @SENDEDDAY_INIT						= 99999
	declare @SENDEDDAY_LIMIT					int				set @SENDEDDAY_LIMIT					= 30

	declare @KAKAO_MSG_INVITE_STEP1				int				set @KAKAO_MSG_INVITE_STEP1				= 5
	declare @KAKAO_MSG_INVITE_STEP2				int				set @KAKAO_MSG_INVITE_STEP2				= 10
	declare @KAKAO_MSG_INVITE_STEP3				int				set @KAKAO_MSG_INVITE_STEP3				= 20
	declare @KAKAO_MSG_INVITE_STEP4				int				set @KAKAO_MSG_INVITE_STEP4				= 40

	-- 카톡 친구초대 보상.
	declare @KAKAO_MSG_INVITE_STEP0_NON			int				set @KAKAO_MSG_INVITE_STEP0_NON			= -1
	--declare @KAKAO_MSG_INVITE_STEP1_ITEMCODE	int				set @KAKAO_MSG_INVITE_STEP1_ITEMCODE	= 3100
	--declare @KAKAO_MSG_INVITE_STEP2_ITEMCODE	int				set @KAKAO_MSG_INVITE_STEP2_ITEMCODE	= 3015
	--declare @KAKAO_MSG_INVITE_STEP3_ITEMCODE	int				set @KAKAO_MSG_INVITE_STEP3_ITEMCODE	= 3015
	--declare @KAKAO_MSG_INVITE_STEP4_ITEMCODE	int				set @KAKAO_MSG_INVITE_STEP4_ITEMCODE	= 3015

	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @comment			varchar(128)
	declare @gameid				varchar(60)		set @gameid				= ''
	declare @market				int				set @market				= 0
	declare @kakaomsginvitecnt	int				set @kakaomsginvitecnt	= 0
	declare @giftcode			int				set @giftcode			= @KAKAO_MSG_INVITE_STEP0_NON
	declare @cnt				int				set @cnt				= 0
	declare @sendedday			int				set @sendedday			= @SENDEDDAY_INIT
	declare @kakaomsginvitetodaycnt		int			set @kakaomsginvitetodaycnt		= 0
	declare @kakaomsginvitetodaydate	datetime	set @kakaomsginvitetodaydate	= getdate()

	declare @tmpcnt				int

	declare @kakaoinvite01		int				set @kakaoinvite01 		= 3100	--5명 코인	3100	20000
	declare @kakaoinvite02		int				set @kakaoinvite02 		= 3015	--10명 수정	3015	500
	declare @kakaoinvite03		int				set @kakaoinvite03 		= 3015	--20명 수정	3015	1000
	declare @kakaoinvite04		int				set @kakaoinvite04		= 3015	--40명 수정	3015	2000
	declare @kakaoinvitecnt01	int				set @kakaoinvitecnt01 	= 20000
	declare @kakaoinvitecnt02	int				set @kakaoinvitecnt02 	= 500
	declare @kakaoinvitecnt03	int				set @kakaoinvitecnt03 	= 1000
	declare @kakaoinvitecnt04	int				set @kakaoinvitecnt04	= 2000
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	set @comment = '알수 없는 오류가 발생했습니다.'
	--select 'DEBUG 1', @gameid_ gameid_, @password_ password_, @kakaouserid_ kakaouserid_

	------------------------------------------------
	--	3-2. 정보획득
	------------------------------------------------
	select
		@gameid 					= gameid,
		@market						= market,
		@kakaomsginvitecnt 			= kakaomsginvitecnt,
		@kakaomsginvitetodaycnt 	= kakaomsginvitetodaycnt,
		@kakaomsginvitetodaydate	= kakaomsginvitetodaydate
	from dbo.tFVUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 2', @gameid gameid, @kakaomsginvitecnt kakaomsginvitecnt, @kakaomsginvitetodaycnt kakaomsginvitetodaycnt, @kakaomsginvitetodaydate kakaomsginvitetodaydate

	select top 1
		@sendedday = datediff(d, senddate, getdate())
	from dbo.tFVKakaoInvite
	where gameid = @gameid_ and receuserid = @kakaouserid_
	--select 'DEBUG 3', @sendedday sendedday

	------------------------------------------------
	--	3-3. 유저생성.
	------------------------------------------------
	if (@gameid = '')
		begin
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR 아이디가 존재하지 않는다.'
			--select 'DEBUG 3' + @comment
		end
	else if (@sendedday < @SENDEDDAY_LIMIT)
		begin
			set @nResult_ 	= @RESULT_ERROR_TIME_REMAIN
			set @comment 	= 'ERROR 시간이 남아있습니다.'
			--select 'DEBUG 3' + @comment
		end
	else
		begin
			set @nResult_ = @RESULT_SUCCESS
			set @comment = '초대를 전송했습니다.'
			--select 'DEBUG 4', @comment

			-------------------------------------
			-- 일 카카오초대(O)
			-------------------------------------
			exec spu_FVDayLogInfoStatic @market, 15, 1

			--30일 이상이면 보낼수 있다.
			if(@sendedday = @SENDEDDAY_INIT)
				begin
					--select 'DEBUG 4-3 새로입력'
					insert into dbo.tFVKakaoInvite(gameid,   receuserid)
					values(                     @gameid_, @kakaouserid_)
				end
			else --if(@sendedday >= @SENDEDDAY_LIMIT)
				begin
					--select 'DEBUG 4-2 30일 경과해서 갱신'
					update dbo.tFVKakaoInvite
						set
							cnt 		= cnt + 1,
							senddate 	= getdate()
					where gameid = @gameid_ and receuserid = @kakaouserid_
				end
			-------------------------------------------------
			-- 1 일 초대한도
			-------------------------------------------------
			set @tmpcnt = datediff(d, @kakaomsginvitetodaydate, getdate())
			if(@tmpcnt >= 1)
				begin
					set @kakaomsginvitetodaycnt		= 0
					set @kakaomsginvitetodaydate 	= getdate()
				end
			set @kakaomsginvitetodaycnt	= @kakaomsginvitetodaycnt + 1

			-------------------------------------------------
			-- 선물 함리스트 전송.
			-------------------------------------------------
			set @kakaomsginvitecnt 	= @kakaomsginvitecnt + 1
			set @giftcode 			= @KAKAO_MSG_INVITE_STEP0_NON
			if(@kakaomsginvitecnt = @KAKAO_MSG_INVITE_STEP1)
				begin
					set @giftcode 	= @kakaoinvite01
					set @cnt		= @kakaoinvitecnt01
				end
			else if(@kakaomsginvitecnt = @KAKAO_MSG_INVITE_STEP2)
				begin
					set @giftcode 	= @kakaoinvite02
					set @cnt		= @kakaoinvitecnt02
				end
			else if(@kakaomsginvitecnt = @KAKAO_MSG_INVITE_STEP3)
				begin
					set @giftcode 	= @kakaoinvite03
					set @cnt		= @kakaoinvitecnt03
				end
			else if(@kakaomsginvitecnt = @KAKAO_MSG_INVITE_STEP4)
				begin
					set @giftcode 	= @kakaoinvite04
					set @cnt		= @kakaoinvitecnt04
				end

			--select 'DEBUG 4-4', @kakaomsginvitecnt kakaomsginvitecnt, @giftcode giftcode, @cnt cnt
			if(@giftcode != @KAKAO_MSG_INVITE_STEP0_NON)
				begin
					--select 'DEBUG 4-5 > 아이템 지급'
					exec spu_FVSubGiftSend 2, @giftcode, @cnt, 'KakaoInv', @gameid_, ''
				end

			--------------------------------------------------------------
			-- 홀짝 랭킹대전
			--------------------------------------------------------------
			exec spu_subFVRankDaJun @gameid_, 0, 0, 0, 0, 10, 0, 0
		end

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	select @nResult_ rtn, @comment comment, @kakaomsginvitecnt kakaomsginvitecnt, @kakaomsginvitetodaycnt kakaomsginvitetodaycnt, @kakaomsginvitetodaydate kakaomsginvitetodaydate
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			------------------------------------------------
			-- 유저정보
			------------------------------------------------
			update dbo.tFVUserMaster
				set
					kakaomsginvitecnt 		= @kakaomsginvitecnt,
					kakaomsginvitetodaycnt 	= @kakaomsginvitetodaycnt,
					kakaomsginvitetodaydate = @kakaomsginvitetodaydate
			where gameid = @gameid_

			--------------------------------------------------------------
			-- 카톡 초대친구들
			--------------------------------------------------------------
			select * from dbo.tFVKakaoInvite where gameid = @gameid_ and senddate >= (getdate() - 30)

			--------------------------------------------------------------
			-- 선물함정보.
			-- 없으면 > 빈리스트를 전송해주기
			--------------------------------------------------------------
			if(@giftcode != @KAKAO_MSG_INVITE_STEP0_NON)
				begin
					exec spu_FVGiftList @gameid_
				end
			else
				begin
					exec spu_FVGiftList ''
				end

		end

	--최종 결과를 리턴한다.
	set nocount off
End



