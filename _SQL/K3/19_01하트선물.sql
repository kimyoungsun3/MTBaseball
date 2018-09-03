/*
-- 1일 1인당 5포인트 450포인트가 맥스로 받음
-- update dbo.tFVUserMaster set kakaomsgblocked = 1 where gameid = 'xxxx3'
-- update dbo.tFVUserMaster set kakaomsgblocked = 0 where gameid = 'xxxx3'
-- select * from dbo.tFVUserMaster where gameid in ( 'farm16225', 'farm51837')

update dbo.tFVUserMaster set heartget = 10, heartcnt = 20, heartdate = '20150202' where gameid = 'xxxx2'
update dbo.tFVUserMaster set heartget = 30, heartcnt = 400, heartdate = '20150201' where gameid = 'xxxx3'
update dbo.tFVUserFriend set senddate = getdate() - 1 where gameid in ('xxxx2', 'xxxx3')
exec spu_FVFriend 'xxxx2', '049000s1i0n7t8445289', 7, 'xxxx3', -1		-- 하트 : 하트선물, 포인트누적.
exec spu_FVFriend 'xxxx3', '049000s1i0n7t8445289', 7, 'xxxx2', -1		-- 하트 : 하트선물, 포인트누적.


select * from dbo.tFVUserMaster where gameid in ( 'farm16225', 'farm51837')
-- 창규 : farm16225		3465659i5o0x9v476693
-- 준식 : farm51837		7758499v9a9u6d423517
update dbo.tFVUserFriend set senddate = getdate() - 1 where gameid = 'farm16225' and friendid = 'farm51837'
update dbo.tFVUserFriend set senddate = getdate() - 1 where gameid = 'farm51837' and friendid = 'farm16225'
exec spu_FVFriend 'farm16225', '3465659i5o0x9v476693', 7, 'farm51837', -1		-- 하트 : 하트선물, 포인트누적.

exec spu_FVFriend 'farm51837', '7758499v9a9u6d423517', 7, 'farm16225', -1		-- 하트 : 하트선물, 포인트누적.


-- 복귀(9)
*/
use Game4FarmVill3
GO

IF OBJECT_ID ( 'dbo.spu_FVFriend', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVFriend;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_FVFriend
	@gameid_								varchar(60),					-- 게임아이디
	@password_								varchar(20),
	@mode_									int,
	@friendid_								varchar(60),
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
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함

	-- 기타오류
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- 지원하지않는모드
	declare @RESULT_ERROR_NOT_FOUND_OTHERID		int				set @RESULT_ERROR_NOT_FOUND_OTHERID		= -83
	declare @RESULT_ERROR_TIME_REMAIN			int				set @RESULT_ERROR_TIME_REMAIN			= -123			-- 아직 시간이 남음.
	declare @RESULT_ERROR_KAKAO_MESSAGE_BLOCK	int				set @RESULT_ERROR_KAKAO_MESSAGE_BLOCK	= -149			-- 메세지 수신거부상태입니다

	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------
	-- 친구하트지급
	declare @USERFRIEND_MODE_HEARD				int					set	@USERFRIEND_MODE_HEARD						= 7;

	-- 친구상태값.
	--declare @USERFRIEND_STATE_NON				int					set	@USERFRIEND_STATE_NON						=-2;		-- -2: 없음.
	--declare @USERFRIEND_STATE_SEARCH			int					set	@USERFRIEND_STATE_SEARCH					=-1;		-- -1: 검색.
	--declare @USERFRIEND_STATE_PROPOSE_WAIT	int					set	@USERFRIEND_STATE_PROPOSE_WAIT				= 0;		-- 0 : 친구신청대기
	--declare @USERFRIEND_STATE_APPROVE_WAIT	int					set	@USERFRIEND_STATE_APPROVE_WAIT				= 1;		-- 1 : 친구수락대기
	declare @USERFRIEND_STATE_FRIEND			int					set	@USERFRIEND_STATE_FRIEND					= 2;		-- 2 : 상호친구

	declare @KAKAO_FRIEND_KIND_GAME				int					set @KAKAO_FRIEND_KIND_GAME						= 1 		-- 게임친구
	declare @KAKAO_FRIEND_KIND_KAKAO			int					set @KAKAO_FRIEND_KIND_KAKAO					= 2 		-- 카카오친구

	declare @KAKAO_MESSAGE_ALLOW 				int					set @KAKAO_MESSAGE_ALLOW						= -1		-- 카카오 메세지 발송가능.
	declare @KAKAO_MESSAGE_BLOCK 				int					set @KAKAO_MESSAGE_BLOCK						=  1		-- 카카오 메세지 불가능.

	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @gameid			varchar(60)				set @gameid			= ''
	declare @market			int						set @market			= 0
	declare @friendid		varchar(60)				set @friendid		= ''
	declare @cnt			int						set @cnt 			= 0
	declare @senddate		datetime				set @senddate		= getdate()
	declare @senddate2		datetime				set @senddate2		= getdate() - 1
	declare @state			int

	-- 보낸이 하트
	declare @plusheart		int						set @plusheart		= 5
	declare @heartget2		int						set @heartget2		= 0
	declare @heartget		int						set @heartget		= 0
	declare @heartcnt		int						set @heartcnt		= 0
	declare @heartcntmax	int						set @heartcntmax	= 450
	declare @heartdate		varchar(8)				set @heartdate		= '20100101'

	-- 받은이 하트
	declare @fheartget		int						set @fheartget		= 0
	declare @fheartcnt		int						set @fheartcnt		= 0
	declare @fheartcntmax	int						set @fheartcntmax	= 400
	declare @fheartdate		varchar(8)				set @fheartdate		= '20100101'
	declare @dateid8 		varchar(8) 				set @dateid8 		= Convert(varchar(8), Getdate(),112)
	declare @fkakaomsgblocked	int					set @fkakaomsgblocked = @KAKAO_MESSAGE_BLOCK

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	--select 'DEBUG ', @gameid_ gameid_, @password_ password_, @mode_ mode_, @friendid_ friendid_

	------------------------------------------------
	-- 3-3. 각 조건별 분기
	------------------------------------------------
	if (@mode_ not in (@USERFRIEND_MODE_HEARD))
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_SUPPORT_MODE
			select @nResult_ rtn, 'ERROR 지원하지 않는 모드입니다.'
		END
	else if (@mode_ = @USERFRIEND_MODE_HEARD)
		BEGIN
			-- 친구의 정보
			select
				@gameid 	= gameid,		@market 	= market,
				@heartget	= heartget, 	@heartcnt	= heartcnt,
				@heartcntmax= heartcntmax, 	@heartdate	= heartdate
			from dbo.tFVUserMaster
			where gameid = @gameid_ and password = @password_
			--select 'DEBUG 보낸이(A)', @gameid gameid, @heartget heartget, @heartcnt heartcnt, @heartcntmax heartcntmax, @heartdate heartdate

			select
				@friendid 	= gameid,		@fkakaomsgblocked = kakaomsgblocked,
				@fheartget	= heartget, 	@fheartcnt	= heartcnt,
				@fheartcntmax= heartcntmax, @fheartdate	= heartdate
			from dbo.tFVUserMaster where gameid = @friendid_
			--select 'DEBUG 받는이(B)', @friendid friendid, @fheartget fheartget, @fheartcnt fheartcnt, @fheartcntmax fheartcntmax, @fheartdate fheartdate

			select
				@state 		= state,
				@senddate 	= senddate
			from dbo.tFVUserFriend where gameid = @gameid_ and friendid = @friendid_
			--select 'DEBUG ', @gameid gameid, @friendid friendid, @state state, @senddate senddate

			if(@gameid = '')
				begin
					set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
					select @nResult_ rtn, 'ERROR 아이디를 찾을 수 없습니다.'
				end
			else if(@friendid = '' or @gameid_ = @friendid_)
				begin
					set @nResult_ = @RESULT_ERROR_NOT_FOUND_OTHERID
					select @nResult_ rtn, 'ERROR 친구의 정보를 찾을수 없습니다.'
				end
			else if(@fkakaomsgblocked = @KAKAO_MESSAGE_BLOCK)
				begin
					set @nResult_ = @RESULT_ERROR_KAKAO_MESSAGE_BLOCK
					select @nResult_ rtn, 'ERROR 해당친구가 메세지 수신거부상태입니다.'
				end
			else if(@state != @USERFRIEND_STATE_FRIEND)
				begin
					set @nResult_ = @RESULT_ERROR_NOT_SUPPORT_MODE
					select @nResult_ rtn, 'ERROR 상호친구가 아닙니다.'
				end
			else if(@senddate > @senddate2)
				begin
					set @nResult_ = @RESULT_ERROR_TIME_REMAIN
					select @nResult_ rtn, 'ERROR 하트 선물 시간이 남았습니다.'
				end
			else
				begin
					set @nResult_ = @RESULT_SUCCESS
					select @nResult_ rtn, 'SUCCESS 친구에게 하트 선물하기'

					-------------------------------------
					-- 일 카카오 하트(O)
					-------------------------------------
					exec spu_FVDayLogInfoStatic @market, 16, 1

					---------------------------------------------
					-- 보낸이(A)
					-- 하트일일전송량 초기화
					---------------------------------------------
					if(@heartdate != @dateid8)
						begin
							--select 'DEBUG (보낸이A)하루 날짜가 바뀌어서 초기화'
							set @heartdate	= @dateid8
							set @heartcnt = 0
						end
					set @heartget2 = @heartget
					set @heartget = 0

					update dbo.tFVUserMaster
						set
							heartget		= @heartget,
							heartcnt		= @heartcnt,
							heartdate		= @heartdate
					where gameid = @gameid_
					--select 'DEBUG (보낸이A) 하트', @heartget2 heartget2

					---------------------------------------------
					--             받은이(B)
					--             받을하트 누적(일일 전송량을 초과할 수없음)
					---------------------------------------------
					if(@fheartcnt >= @fheartcntmax)
						begin
							--select 'DEBUG 받은이(B)일일초과량 초과(1:이미초과)'
							set @plusheart 	= 0
						end
					else if(@fheartcnt + @plusheart >= @fheartcntmax)
						begin
							--select 'DEBUG 받은이(B)일일초과량 초과(2:이번에 초과)'
							set @plusheart 	= @fheartcntmax - @fheartcnt
						end
					else
						begin
							--select 'DEBUG 받은이(B)하트지급'
							set @plusheart 	= @plusheart
						end
					set @fheartget = @fheartget + @plusheart
					set @fheartcnt = @fheartcnt + @plusheart
					--select 'DEBUG 받은이(B)', @plusheart plusheart, @fheartget fheartget, @fheartcnt fheartcnt

					update dbo.tFVUserMaster
						set
							heartget = @fheartget,
							heartcnt = @fheartcnt
					where gameid = @friendid_

					---------------------------------------------
					--	나		> 포인트지급날자갱신
					-- 하트 지급 시간 단축 (클라 24시간을 기준으로 세팅)
					-- 1 : 24H = 0.25 : 6H
					-- t - 24 > (t2 - (1 - 0.25) - 24
					---------------------------------------------
					update dbo.tFVUserFriend
						set
							--senddate = (getdate() - (1 - 0.25))		-- 6시간
							senddate = getdate() 						-- 1일
					where gameid = @gameid_ and friendid = @friendid_

					---------------------------------------------
					--	유저정보.
					---------------------------------------------
					select @heartget2 heartget2 --, * from dbo.tFVUserMaster where gameid = @gameid_

					--------------------------------------------------------------
					-- 유저 친구정보
					-- 카피 & 사라지면 대처동물로.(없으면 기초동물로 교체)
					--------------------------------------------------------------
					exec spu_FVsubFriendRank @gameid_, 1

					--------------------------------------------------------------
					-- 홀짝 랭킹대전
					--------------------------------------------------------------
					--exec spu_subFVRankDaJun @gameid_, 0, 0, 0, 0, 1, 0, 0

				end
		END
	else
		begin
			set @nResult_ = @RESULT_ERROR
			select @nResult_ rtn, 'ERROR 알수없는 오류(-1)'
		end



	------------------------------------------------
	--	4-2. 유저정보
	------------------------------------------------
	set nocount off
End

