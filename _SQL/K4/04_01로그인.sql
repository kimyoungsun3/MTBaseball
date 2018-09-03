use Game4FarmVill4
Go
/*
-- update dbo.tFVNotice set syscheck = 0
-- update dbo.tFVUserData set savedate = '2001-01-01' where gameid = 'xxxx2'
-- select rkteam, gameid, * from dbo.tFVUserMaster where gameid in ( 'xxxx2', 'farm81499', 'farm99545')
-- update dbo.tFVUserMaster set cashcopy = 2 where gameid = 'xxxx2'
-- update dbo.tFVUserMaster set heartget = 0, heartcnt = 0, heartdate = '20010101' where gameid = 'xxxx2'
-- update dbo.tFVUserMaster set heartget = 10, heartcnt = 10, heartdate = '20010101' where gameid = 'xxxx2'
-- update dbo.tFVUserMaster set heartget = 10, heartcnt = 10, heartdate = '20150202' where gameid = 'xxxx2'
-- update dbo.tFVUserMaster set heartget = 10, heartcnt = 50, heartdate = '20150202' where gameid = 'xxxx2'

update dbo.tFVUserData set savedate = '2001-01-01' where gameid = 'xxxx2'
exec spu_FVLogin 'xxxx2', '049000s1i0n7t8445289', 5, 199, 0, -1			-- 정상유저
exec spu_FVLogin 'xxxx3', '049000s1i0n7t8445289', 5, 199, 0, -1			-- 정상유저

-----------------------------------------------------------
update dbo.tFVUserData set savedate = getdate() - 1 where gameid = 'farm69572'
exec spu_FVLogin 'xxxx2', '049000s1i0n7t8445289', 5, 199, 0, -1			-- 정상유저


*/

IF OBJECT_ID ( 'dbo.spu_FVLogin', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVLogin;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_FVLogin
	@gameid_								varchar(60),					-- 게임아이디
	@password_								varchar(20),
	@market_								int,							-- (구매처코드)
	@version_								int,							-- 클라버젼
	@kakaomsgblocked_						int,
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

	-- 로그인 오류.
	declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--블럭유저 > 팝업처리후 인트로로 빼버린다.
	declare @RESULT_ERROR_DELETED_USER 			int				set @RESULT_ERROR_DELETED_USER			= -12			--삭제유저 > 팝업처리후 인트로로 빼버린다.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함
	declare @RESULT_ERROR_NOT_FOUND_PASSWORD	int				set @RESULT_ERROR_NOT_FOUND_PASSWORD	= -17
	declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--서버를 점검하고 있다.
	declare @RESULT_NEWVERION_CLIENT_DOWNLOAD 	int				set @RESULT_NEWVERION_CLIENT_DOWNLOAD	= -15			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 링크처리.
	--declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 종료.

	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------
	-- 구매처코드
	declare @MARKET_SKT							int					set @MARKET_SKT						= 1
	declare @MARKET_KT							int					set @MARKET_KT						= 2
	declare @MARKET_LGT							int					set @MARKET_LGT						= 3
	declare @MARKET_GOOGLE						int					set @MARKET_GOOGLE					= 5
	declare @MARKET_NHN							int					set @MARKET_NHN						= 6
	declare @MARKET_IPHONE						int					set @MARKET_IPHONE					= 7

	-- 블럭상태값.
	--declare @BLOCK_STATE_NO					int					set	@BLOCK_STATE_NO					= 0	-- 블럭상태아님
	declare @BLOCK_STATE_YES					int					set	@BLOCK_STATE_YES				= 1	-- 블럭상태

	-- 시스템 체킹
	--declare @SYSCHECK_NON						int					set @SYSCHECK_NON					= 0
	declare @SYSCHECK_YES						int					set @SYSCHECK_YES					= 1

	-- bool
	declare @BOOL_TRUE							int					set @BOOL_TRUE						= 1
	declare @BOOL_FALSE							int					set @BOOL_FALSE						= 0

	-- 선물 정의값
	declare @GIFTLIST_GIFT_KIND_MESSAGE			int					set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2
	--declare @GIFTLIST_GIFT_KIND_MESSAGE_DEL	int					set @GIFTLIST_GIFT_KIND_MESSAGE_DEL			= -1
	--declare @GIFTLIST_GIFT_KIND_GIFT_DEL		int					set @GIFTLIST_GIFT_KIND_GIFT_DEL			= -2
	--declare @GIFTLIST_GIFT_KIND_GIFT_GET		int					set @GIFTLIST_GIFT_KIND_GIFT_GET			= -3
	--declare @GIFTLIST_GIFT_KIND_GIFT_SELL		int					set @GIFTLIST_GIFT_KIND_GIFT_SELL			= -4
	--declare @GIFTLIST_GIFT_KIND_LIST			int					set @GIFTLIST_GIFT_KIND_LIST				= -5

	--메세지 수신여부.
	declare @KAKAO_MESSAGE_BLOCKED_NON			int					set @KAKAO_MESSAGE_BLOCKED_NON					= 0
	declare @KAKAO_MESSAGE_ALLOW 				int					set @KAKAO_MESSAGE_ALLOW						= -1		-- 카카오 메세지 발송가능.
	declare @KAKAO_MESSAGE_BLOCK 				int					set @KAKAO_MESSAGE_BLOCK						=  1		-- 카카오 메세지 불가능.

	-- 카카오톡 정보.
	declare @KAKAO_MESSAGE_INVITE_ID			int					set @KAKAO_MESSAGE_INVITE_ID 				= 3210	--초대하기 A
	declare @KAKAO_MESSAGE_PROUD_ID				int					set @KAKAO_MESSAGE_PROUD_ID 				= 3207	--자랑하기A
	declare @KAKAO_MESSAGE_HEART_ID				int					set @KAKAO_MESSAGE_HEART_ID 				= 3208	--하트선물C
	declare @KAKAO_MESSAGE_RETURN_ID			int					set @KAKAO_MESSAGE_RETURN_ID				= 3209	--복귀이벤트

	-- 장기복귀기한.
	declare @RETURN_LIMIT_DAY					int					set @RETURN_LIMIT_DAY				= 30 	-- 몇일간 기한인가?.
	declare @RETURN_FLAG_OFF					int					set @RETURN_FLAG_OFF				= -1 	-- On(1), Off(-1)
	declare @RETURN_FLAG_ON						int					set @RETURN_FLAG_ON					= 1 	--
	-------------------------------------------------------------------
	-- Event1. 일일 매일 보상하는 아이템.
	-------------------------------------------------------------------
	declare @EVENT_STATE_NON					int					set @EVENT_STATE_NON				=-1
	declare @EVENT_STATE_YES					int					set @EVENT_STATE_YES				= 1

	------------------------------------------------
	--	NHN, LGT 오픈 이벤트
	-- ~ 2015.01.31
	-- 1. 추천글 추첨을 통해서 제공
	-- 2. 생애 첫결제 지원
	-- 3. 정착지원 재료
	--	> 우유결정		: 500	3015
	--	> 바나나 우유 	: 200	3004
	--	> 생크림		: 200	3005
	--	> 무지방 		: 500	3003
	------------------------------------------------
	declare @EVENT02_END_DAY					datetime			set @EVENT02_END_DAY			= '2015-01-31 23:59'

	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @comment				varchar(512)			set @comment		= ''
	declare @comment2				varchar(128)			set @comment2		= ''
	declare @gameid 				varchar(60)				set @gameid			= ''
	declare @nickname 				varchar(20)				set @nickname		= ''
	declare @market					int						set @market			= @MARKET_GOOGLE
	declare @curdate				datetime				set @curdate		= getdate()
	declare @blockstate				int
	declare @kakaostatus			int						set @kakaostatus	= 1
	declare @cashcopy				int
	declare @ownercashcost			bigint					set @ownercashcost	= 0
	declare @bestani				int						set @bestani		= 500
	declare @rebirthdate			datetime				set @rebirthdate 	= getdate()		-- 환생일.
	declare @sameweek				int						set @sameweek		= 0
	declare @eventspot12			int						set @eventspot12	= 0
	declare @eventspot13			int						set @eventspot13	= 0

	declare @curversion				int						set @curversion		= -1
	declare @cursyscheck			int
	declare @patchurl				varchar(512)
	declare @recurl					varchar(512)

	-- 시간체킹
	declare @dateid8 				varchar(8) 				set @dateid8 		= Convert(varchar(8), Getdate(),112)
	declare @logindate				varchar(8)				set @logindate		= '20100101'
	declare @attendnewday			int						set @attendnewday	= -1
	declare @roulette				int						set @roulette		= -1

	-- 하트전송.
	declare @heartget2		int						set @heartget2		= 0
	declare @heartget		int						set @heartget		= 0
	declare @heartcnt		int						set @heartcnt		= 0
	--declare @heartcntmax	int						set @heartcntmax	= 400
	declare @heartdate		varchar(8)				set @heartdate		= '20100101'

	-- 공지사항
	declare @ntcomment				varchar(8000)			set @ntcomment	= ''

	-- Event1 > 지정된 시간에 로그인하면 선물지급~~~
	declare @eventstatemaster		int				set @eventstatemaster			= @EVENT_STATE_NON
	declare @eventidx				int				set @eventidx					= -1
	declare @eventidx2				int
	declare @eventitemcode			int				set @eventitemcode				= -1
	declare @eventcnt				int				set @eventcnt					= 0
	declare @eventsender 			varchar(20)		set @eventsender				= 'sangsang'
	declare @curyear				int				set @curyear					= DATEPART("yy", @curdate)
	declare @curmonth				int				set @curmonth					= DATEPART("mm", @curdate)
	declare @curday					int				set @curday						= DATEPART(dd, @curdate)
	declare @curhour				int				set @curhour					= DATEPART(hour, @curdate)
	declare @idx2					int				set @idx2 						= 0

	-- 세이브데이타.
	declare @savedata				varchar(8000)	set @savedata					= ''
	declare @strmarket				varchar(40)
	declare @savedate				datetime		set @savedate		= getdate()
	declare @pausetick				int				set @pausetick		= 0

	-- 1일 초대 인원 초기화.
	declare @kakaomsginvitetodaycnt		int			set @kakaomsginvitetodaycnt		= 0
	declare @kakaomsginvitetodaydate	datetime	set @kakaomsginvitetodaydate	= getdate()


	-- 자신의 사진정보.
	declare @kkhelpalivecnt			int				set @kkhelpalivecnt				= 0
	declare @tmpcnt					int
	declare @rankresult2			int				set @rankresult2				= 0

	-- 랭킹변수.
	declare @schoolinitdate			varchar(19),
			@dw						int

	-- 보물정보.
	declare @tsgrade2gauage			int,			@tsgrade2free			int,
			@tsgrade3gauage			int,			@tsgrade3free			int,
			@tsgrade4gauage			int,			@tsgrade4free			int

	-- 보물할인.
	declare @roulsaleflag			int				set @roulsaleflag		= -1
	declare @roulsalevalue			int				set @roulsalevalue		=  0

	-- 보물보상.
	declare @roulrewardflag			int				set @roulrewardflag		= -1

	-- 보물확률상승.
	declare @roultimeflag			int				set @roultimeflag		= -1
	declare @roultimetime1			int				set @roultimetime1		= -1
	declare @roultimetime2			int				set @roultimetime2		= -1
	declare @roultimetime3			int				set @roultimetime3		= -1
	declare @roultimetime4			int				set @roultimetime4		= -1

	-- 보물무료뽑기.
	declare @tsgauageflag			int				set @tsgauageflag		= -1

	-- 보물강화할인.
	declare @tsupgradesaleflag		int				set @tsupgradesaleflag	= -1
	declare @tsupgradesalevalue		int				set @tsupgradesalevalue	=  0

	-- 룰렛(회전판)무료뽑기.
	declare @wheelgauageflag		int				set @wheelgauageflag	= -1

	-- 복귀 처리.
	declare @rtnflag				int				set @rtnflag					= @RETURN_FLAG_OFF	-- 현재복귀 플래그 상태.
	declare @rtngameid				varchar(60)		set @rtngameid					= ''
	declare @rtndate				datetime		set @rtndate					= getdate() 		-- 1
	declare @rtnstep				int				set @rtnstep					= 0					-- 1일차 1, 2일차 2....
	declare @rtnplaycnt				int				set @rtnplaycnt					= 0					-- 거래횟수.
	declare @rtnitemcode			int				set @rtnitemcode				= 3015				-- 요청자 : 500결정, 복귀 : 1일 300결정.
	declare @newday					int				set @newday						= 0
	declare @condate				datetime		set @condate					= getdate()

	declare @pos					int				set @pos 						= 0
	declare @pos2					int				set @pos						= 0
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG 입력정보', @gameid_ gameid_, @password_ password_, @market_ market_, @version_ version_, @kakaomsgblocked_ kakaomsgblocked_

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	select
		@gameid 	= gameid,		@nickname	= nickname,
		@eventspot12= eventspot12,	@eventspot13= eventspot13,
		@bestani	= bestani,
		@roulette	= roulette,
		@blockstate = blockstate,	@kakaostatus = kakaostatus,
		@rebirthdate= rebirthdate,
		@cashcopy	= cashcopy,
		@logindate	= logindate,	@rankresult2= rankresult,
		@rtngameid	= rtngameid, 	@rtndate	= rtndate,
		@rtnstep	= rtnstep, 		@rtnplaycnt	= rtnplaycnt,
		@condate	= condate,
		@heartget	= heartget, 	@heartcnt	= heartcnt,		@heartdate	= heartdate,
		@kakaomsginvitetodaycnt 	= kakaomsginvitetodaycnt,
		@kakaomsginvitetodaydate	= kakaomsginvitetodaydate
	from dbo.tFVUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 유저정보', @gameid gameid, @blockstate blockstate, @logindate logindate, @heartdate heartdate, @condate condate

	------------------------------------------------
	--	3-3. 공지사항 체크
	------------------------------------------------
	select top 1
		@cursyscheck 	= syscheck,
		@curversion 	= version,
		@patchurl		= patchurl,
		@recurl			= recurl,
		@ntcomment		= comment
	from dbo.tFVNotice
	where market = @market_
	order by idx desc
	--select 'DEBUG 공지사항', @cursyscheck cursyscheck, @curversion curversion, @patchurl patchurl, @recurl recurl

	if(@cursyscheck = @SYSCHECK_YES)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_SERVER_CHECKING
			set @comment 	= 'DEBUG 시스템 점검중입니다.'
			--select 'DEBUG ', @comment
		END
	else if(@gameid = '')
		BEGIN
			-- 아이디가 존재하지않는가??
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '아이디가 존재하지 않는다. > 아이디를 확인해라.'
			--select 'DEBUG ', @comment
		END
	else if(@version_ < @curversion)
		BEGIN
			-- 마켓별 버젼이 틀리다
			set @nResult_ 	= @RESULT_NEWVERION_CLIENT_DOWNLOAD
			set @comment 	= '마켓별 버젼이 틀리다. > 다시받아라.'
			--select 'DEBUG ', @comment
		END
	else if (@blockstate = @BLOCK_STATE_YES)
		BEGIN
			-- 블럭유저인가?
			set @nResult_ 	= @RESULT_ERROR_BLOCK_USER
			set @comment 	= '블럭처리된 아이디입니다.'
			--select 'DEBUG ', @comment
		END
	else if (@kakaostatus = -1)
		BEGIN
			-- 삭제된 계정입니다.
			set @nResult_ 	= @RESULT_ERROR_DELETED_USER
			set @comment 	= '아이디가 삭제되었습니다.'
			--select 'DEBUG ', @comment
		END
	else if(@cashcopy >= 2)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_BLOCK_USER
			set @comment 	= '캐쉬결재카피를 '+ltrim(rtrim(str(@cashcopy)))+'회 이상했다. > 블럭처리하자!!'
			--select 'DEBUG ', @comment

			-- xx회 이상카피행동 > 블럭처리, 블럭로그기록
			update dbo.tFVUserMaster
				set
					blockstate = @BLOCK_STATE_YES,
					cashcopy = 0
			where gameid = @gameid_

			-- 아이템3회 카피에 대한 블럭처리
			insert into dbo.tFVUserBlockLog(gameid, comment)
			values(@gameid_, '(캐쉬결재)를  '+ltrim(rtrim(str(@cashcopy)))+'회 이상 카피를 해서 로그인시 시스템에서 블럭 처리했습니다.')
		END
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '로그인 정상처리'
			--select 'DEBUG ', @comment
		END


	-----------------------------------------------
	-- 결과코드처리.
	-----------------------------------------------
	select @nResult_ rtn, @comment comment, @patchurl patchurl, @recurl recurl, @curversion curversion, @curdate curdate, @ntcomment ntcomment

	if(@nResult_ = @RESULT_SUCCESS)
		BEGIN
			-------------------------------------------------------------------
			-- 일일 선물지급(지속적인 접속 유도2 > 로그인을 유도하기 위해 제2의 기능)
			-- Event1 지정된 시간에 로그인하면 선물지급~~~
			-- 		step1 : 마스터가 진행중
			--		step2 : 시작 <= 지금 < 끝 (진행중)
			--				=> 이벤트코드, 아이템코드, 보낸이
			--		step3 : 해당 선물 지급, 선물지급 기록(tEventUser)
			-------------------------------------------------------------------
			select @eventstatemaster = eventstatemaster from dbo.tFVEventMaster where idx = 1
			--select 'DEBUG 지정이벤트1-1', @eventstatemaster eventstatemaster
			if(@eventstatemaster = @EVENT_STATE_YES)
				begin
					select top 1
						@eventidx 		= eventidx,
						@eventitemcode 	= eventitemcode,
						@eventcnt		= eventcnt,
						@eventsender 	= eventsender
					from dbo.tFVEventSub
					where @curday = eventday and eventstarthour <= @curhour and @curhour <= eventendhour and eventstatedaily = @EVENT_STATE_YES
					order by eventidx desc

					set @eventidx2 = (@curyear - 2015)*1000000 + @curmonth*10000 + @curday*100 + @eventidx
					--select 'DEBUG 지정이벤트1-2', @eventidx eventidx, @eventitemcode eventitemcode, @eventsender eventsender, @eventidx2 eventidx2

					if(@eventidx != -1 and @eventitemcode != -1)
						begin
							--select 'DEBUG 지정이벤트1-3'
							if(not exists(select top 1 * from dbo.tFVEvnetUserGetLog where gameid = @gameid_ and eventidx = @eventidx2))
								begin
									--select 'DEBUG 지정이벤트1-4 선물, 로그기록', @eventitemcode eventitemcode, @eventcnt eventcnt, @eventsender eventsender, @gameid_ gameid_
									exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @eventitemcode, @eventcnt, @eventsender, @gameid_, 'login'

									insert into dbo.tFVEvnetUserGetLog(gameid,   eventidx,   eventitemcode)
									values(                           @gameid_, @eventidx2, @eventitemcode)

									-- 자세한 로고는 선물함에 있어서 삭제해도 된다.
									select @idx2 = max(idx) from dbo.tFVEvnetUserGetLog
									delete from tFVEvnetUserGetLog where idx <= @idx2 - 8800
								end
						end
				end

			------------------------------------------------------------------
			-- 유저 > 로그인 카운터
			------------------------------------------------------------------
			if(@logindate != @dateid8)
				begin
					exec spu_FVDayLogInfoStatic @market_, 12, 1               -- 일 로그인(중복)
					exec spu_FVDayLogInfoStatic @market_, 14, 1               -- 일 로그인(유니크)
					set @attendnewday 	= 1
					set @roulette		= 1
					--select 'DEBUG 일 로그인(유니크)'
				end
			else
				begin
					exec spu_FVDayLogInfoStatic @market_, 12, 1               -- 일 로그인(중복)
					--select 'DEBUG 일 로그인(중복)'
				end
			set @logindate = @dateid8

			-------------------------------------------------------------------
			-- 복귀 처리 하기.
			--if(@condate >=30)
			--	복귀스텝 1단계
			--	복귀플레이카운터 클리어
			--	if(요청날짜 24시간이내, 아이디) 요청자 보상
			--else if(새로운날 and 상태 >= 1step and 복귀 >= 5)
			--	복귀스텝 + 1
			--	복귀플레이카운터 클리어
			--	if(step > 10)
			--		step = -1
			-------------------------------------------------------------------
			set @newday = datediff(d, @condate, getdate())

			select top 1 @rtnflag = rtnflag from dbo.tFVSystemRouletteMan where roulmarket = @market_ order by idx desc
			--select 'DEBUG 복귀처리', @rtnflag rtnflag, @newday newday, @rtnstep rtnstep
			if(@rtnflag = @RETURN_FLAG_ON)
				begin
					--select 'DEBUG 복귀진행중(서버ON).', @newday newday, @rtnstep rtnstep, @rtnplaycnt rtnplaycnt, @condate condate, @rtndate rtndate, (getdate() - 1) '1일전', getdate() '현재'
					if(@condate <= (getdate() - @RETURN_LIMIT_DAY))
						begin
							--select 'DEBUG > 복귀 > 최초접속.', @rtngameid rtngameid
							set @rtnstep	= 1
							set @rtnplaycnt	= 0

							-- 복귀자 선물.
							exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,    @rtnitemcode, 300, '복귀보상(1일)', @gameid_, ''

							-- 복귀 요청자 선물.
							if(@rtngameid != '' and @rtndate >= (getdate() - 1))
								begin
									--select 'DEBUG > 상대보상.', @rtngameid rtngameid
									set @comment2 = @nickname + '님 복귀 보상으로 드립니다.'
									exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,    @rtnitemcode, 500, '복귀보상', @rtngameid, ''
									exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_MESSAGE, -1,             0, '누구복귀', @rtngameid, @comment2
								end

							-------------------------------------
							-- 복귀 인원수.
							-------------------------------------
							exec spu_FVDayLogInfoStatic @market_, 28, 1				-- 일 복귀수.
						end
					else if(@newday >= 1 and @rtnstep >= 1)							-- 다음날 and 복귀자
						begin
							--select 'DEBUG > 복귀 > 진행중.', @newday newday, @rtnstep rtnstep, @rtnplaycnt rtnplaycnt
							set @rtnstep	= @rtnstep + 1
							set @rtnplaycnt	= 0
							set @comment2 = '복귀보상(' + ltrim(rtrim(str(@rtnstep))) + '일)'

							-- 복귀자 선물.
							if(@rtnstep in (2, 3, 4, 5, 6, 8, 9, 10, 11, 12, 13))
								begin
									exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,    @rtnitemcode, 300, @comment2, @gameid_, ''
								end
							else if(@rtnstep in (7, 14))
								begin
									exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,    3500,           1, @comment2, @gameid_, ''
								end

							if(@rtnstep >= 15)
								begin
									--select 'DEBUG > 복귀 > 완료.', @newday newday, @rtnstep rtnstep, @rtnplaycnt rtnplaycnt
									set @rtnstep	= -1
								end
						end
				end



			---------------------------------------------
			-- 하트일일전송량 초기화
			---------------------------------------------
			if(@heartdate != @dateid8)
				begin
					--select 'DEBUG 하루 날짜가 바뀌어서 초기화'
					set @heartdate	= @dateid8
					set @heartcnt = 0
				end
			set @heartget2 = @heartget
			set @heartget = 0

			-------------------------------------------------
			---- 카톡 초대인원 초기화.
			-------------------------------------------------
			set @tmpcnt = datediff(d, @kakaomsginvitetodaydate, getdate())
			if(@tmpcnt >= 1)
				begin
					set @kakaomsginvitetodaycnt		= 0
					set @kakaomsginvitetodaydate 	= getdate()
				end

			--select 'DEBUG ', @kakaomsginvitetodaycnt kakaomsginvitetodaycnt, @kakaomsginvitetodaydate kakaomsginvitetodaydate

			-----------------------------------------------------------------
			-- 세이브 정보.
			-----------------------------------------------------------------
			select
				@savedate	= savedate,
				@savedata 	= savedata
			from dbo.tFVUserData where gameid = @gameid_
			set @ownercashcost = dbo.fnu_GetFVSaveDataToCashcost(@savedata)


			---------------------------------------------------
			-- 환생정보와 비교.
			-- 일 월 화 수 목 금 토
			--                		> 이번주에 환생시 기록.
			---------------------------------------------------
			set @sameweek = dbo.fnu_GetSameWeek( @rebirthdate, GETDATE() )


			-------------------------------------------------------------------
			---- ★★★ 세이브 정보 > 생애결제 클리어해주기.★★★
			-------------------------------------------------------------------
			set @pos = charindex('%30:', @savedata)
			set @pos2 = charindex('%', @savedata, @pos + 4)
			if(@pos + 4 < @pos2)
				begin
					set @savedata = substring(@savedata, 1, @pos + 3)  + substring(@savedata, @pos2, len(@savedata))
					--select 'DEBUG', @savedata savedata
				end

			------------------------------------------------------------------ 
			-- ★★★3만 성원에 감사★★★
			-- 여러분들의 성원에 힘입어 빠르게 3만명의 유저가 가입했습니다. 
			-- 이에 조그마한 선물로 기존 유저분들에게는 1,000 루비와 신규 유저분들에게는 3,000루비 그리고 전 유저분들에게는 보물최고급티켓 1개를 100프로 드립니다. 
			-- 기한은 8월 31일까지이며 로그인하시면 선물함으로 지급됩니다.
			------------------------------------------------------------------ 
			if(@eventspot12 = 0 and @curdate < '2015-08-31 23:59')
				begin
					exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT, 3015, 2000, '성원에 감사', @gameid_, ''
					set @eventspot12 = @eventspot12 + 1
				end
				
			if(@eventspot13 = 0 and @curdate < '2015-08-31 23:59')
				begin
					exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT, 3015, 1000, '3만 성원감사', @gameid_, ''
					exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT, 3601,    1, '3만 성원감사', @gameid_, ''
					set @eventspot13 = @eventspot13 + 1
				end
				

			-------------------------------------------------------------------
			-- 세이브 시간을 이용해서 틱계산하기.
			-- 세이브 - 현재시간 > 분(1분틱) / 15 > 15분틱 > 40틱까지 이용
			-------------------------------------------------------------------
			set @pausetick = dbo.fnu_GetDatePart('mi', @savedate, @curdate) / 15
			set @pausetick = case
								when (@pausetick >= 40) then 40
								when (@pausetick <   0) then  0
								else 						 @pausetick
							end
			--select 'DEBUG ', @pausetick pausetick, @savedate savedate, @curdate curdate


			----------------------------------------------
			-- 학교정보 초기화날짜(매주 토요일 오후 11:59).
			---------------------------------------------
			select @dw = DATEPART(dw, @curdate)
			set @curdate = @curdate + (7 - @dw)
			set @schoolinitdate = CONVERT(char(10), @curdate, 25) + ' 23:59:00'


			------------------------------------------------
			-- 뽑기 이벤트 정보 가져오기.
			------------------------------------------------
			select
				top 1
				-- 보물할인
				@roulsaleflag	= case when (@curdate > roulstart and @curdate <= roulend) then roulsaleflag	else -1 end,
				@roulsalevalue	= case when @roulsaleflag = -1 then 0 else roulsalevalue end,

				-- 보물보상 	> 무엇을 뽑으면 결정지급
				@roulrewardflag = case when (@curdate > roulstart and @curdate <= roulend) then roulflag 		else -1 end,

				-- 보물확률상승 > 특정 시간에 확률상승.
				@roultimeflag	= case when (@curdate > roulstart and @curdate <= roulend) then roultimeflag 	else -1 end,
				@roultimetime1	= roultimetime1,	@roultimetime2	= roultimetime2,	@roultimetime3	= roultimetime3,	@roultimetime4	= roultimetime4,

				-- 보물무료뽑기	> 뽑기 x회후에 1회 무료.
				@tsgauageflag	= case when (@curdate > roulstart and @curdate <= roulend) then pmgauageflag 	else -1 end,

				-- 보물강화할인
				@tsupgradesaleflag	= case when (@curdate > roulstart and @curdate <= roulend) then tsupgradesaleflag	else -1 end,
				@tsupgradesalevalue	= case when @tsupgradesaleflag = -1 then 0 else tsupgradesalevalue end,

				-- 룰렛(회전판)무료뽑기.> x회후에 1회 무료.
				@wheelgauageflag	= case when (@curdate > roulstart and @curdate <= roulend) then wheelgauageflag		else -1 end
			from dbo.tFVSystemRouletteMan
			where roulmarket = @market
			order by idx desc
			--select 'DEBUG ', @roulrewardflag roulrewardflag, @roultimeflag roultimeflag, @tsgauageflag tsgauageflag, @tsupgradesaleflag tsupgradesaleflag, @tsupgradesalevalue tsupgradesalevalue


			------------------------------------------------------------------
			-- 유저 정보를 업데이트하기
			------------------------------------------------------------------
			--select 'DEBUG(전)', rkteam, * from dbo.tFVUserMaster where gameid = @gameid_

			update dbo.tFVUserMaster
				set
					market			= @market_,
					version			= @version_,
					rkteam			= (CASE WHEN ISNUMERIC(SUBSTRING(gameid, LEN(LTRIM(gameid)), LEN(LTRIM(gameid)))) = 1 THEN CAST(SUBSTRING(gameid, LEN(LTRIM(gameid)), LEN(LTRIM(gameid))) AS INT) ELSE 0 END)%2,
					ownercashcost	= @ownercashcost,
					eventspot12		= @eventspot12,
					eventspot13		= @eventspot13,

					kakaomsgblocked	= case
											when (@kakaomsgblocked_ = @KAKAO_MESSAGE_BLOCKED_NON) 	then kakaomsgblocked
											when (@kakaomsgblocked_ = @KAKAO_MESSAGE_BLOCK) 	then @KAKAO_MESSAGE_BLOCK
											else kakaomsgblocked
									end,
					logindate		= @logindate,		-- 로그인날짜별.
					roulette		= @roulette,


					heartget		= @heartget,
					heartcnt		= @heartcnt,
					heartdate		= @heartdate,

					-- 복귀정보저장.
					--rtngameid		= @rtngameid,
					--rtndate		= @rtndate,
					rtnstep			= @rtnstep,
					rtnplaycnt		= @rtnplaycnt,

					kakaomsginvitetodaycnt 	= @kakaomsginvitetodaycnt,
					kakaomsginvitetodaydate = @kakaomsginvitetodaydate,
					sid				= sid + 1,

					rankresult		= 0,
					condate			= getdate(),		-- 최종접속일
					concnt			= concnt + 1		-- 접속횟수 +1
			where gameid = @gameid_

			--select 'DEBUG(후)', rkteam, * from dbo.tFVUserMaster where gameid = @gameid_


			----------------------------------------------
			-- 유저 정보
			---------------------------------------------
			select
				@sameweek sameweek,
				@pausetick pausetick,
				@rtnstep rtnstep,
				@schoolinitdate userrankinitdate,
				@attendnewday attendnewday, @savedata savedata,
				@KAKAO_MESSAGE_INVITE_ID kakaoinviteid,
				@KAKAO_MESSAGE_PROUD_ID kakaoproudid,
				@KAKAO_MESSAGE_HEART_ID kakaoheartid,
				@KAKAO_MESSAGE_RETURN_ID kakaoreturnid,
				@heartget2 heartget2,
				@rankresult2 rankresult2,
				@roulsaleflag roulsaleflag, @roulsalevalue roulsalevalue,
				@tsupgradesaleflag tsupgradesaleflag, @tsupgradesalevalue tsupgradesalevalue,
				@roulrewardflag roulrewardflag,
				@roultimeflag roultimeflag,
				@roultimetime1 roultimetime1, @roultimetime2 roultimetime2,	@roultimetime3 roultimetime3, @roultimetime4 roultimetime4,
				@tsgauageflag tsgauageflag,
				@wheelgauageflag wheelgauageflag,
				*
			from dbo.tFVUserMaster where gameid = @gameid_

			--------------------------------------------------------------
			-- 유저 친구정보   &   랭 킹
			--------------------------------------------------------------
			exec spu_FVsubFriendRank @gameid_, 1

			--------------------------------------------------------------
			-- 카톡 초대친구들
			--------------------------------------------------------------
			select * from dbo.tFVKakaoInvite where gameid = @gameid_ and senddate >= (getdate() - 30)

			----------------------------------------------
			-- 선물리스트
			---------------------------------------------
			exec spu_FVGiftList @gameid_

			------------------------------------------------
			--	3-2. 추천게임
			------------------------------------------------
			set @strmarket = '%' + ltrim(rtrim(str(@market_))) + '%'
			select m.*, isnull(s.rewarded, -1) rewarded from
			(select idx, comfile, comurl, compackname, rewarditemcode, rewardcnt from dbo.tFVSysRecommend2 where packmarket like @strmarket and syscheck = 1) m
				LEFT JOIN
			(select recommendidx, 1 rewarded from dbo.tFVSysRecommendLog where gameid = @gameid_) s
				ON m.idx = s.recommendidx

			--------------------------------------------------------------
			-- 유저 전체랭킹 (3가지 종류의 랭킹이 있음)
			--------------------------------------------------------------
			exec spu_FVsubTotalRank @gameid_

			---------------------------------------------
			-- 패키지상품.
			---------------------------------------------
			select top 1 * from dbo.tFVSystemPack
			where famelvmin <= @bestani
				and @bestani <= famelvmax
				and packstate = 1
				and packmarket like @strmarket
				order by newid()
		END

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
End



