use Farm
Go
/*
-- update dbo.tFVNotice set syscheck = 0
-- select * from dbo.tUserMaster where gameid = 'xxxx@gmail.com'
-- update dbo.tUserMaster set eventspot0x = 0 where gameid = 'xxxx@gmail.com'	 delete from dbo.tFVGiftList where gameid = 'xxxx@gmail.com'

exec spu_FVLogin 'xxxx@gmail.com',  '01022223331', 1, 199, 82, 0, 'pushid', -1			-- 정상유저
exec spu_FVLogin 'xxxx@gmail.com',  '01022223331', 5, 199, 82, 0, 'pushid', -1			-- 정상유저
exec spu_FVLogin 'xxxx2@gmail.com', '01022223332', 5, 100, 82, 0, 'pushid', -1			-- 마켓버젼낮음
exec spu_FVLogin 'xxxx3@gmail.com', '01022223333', 5, 101, 82, 0, 'pushid', -1			-- 블럭유저
exec spu_FVLogin '',                '01022223336', 5, 101, 82, 0, 'pushid', -1			-- 빈계정 전송

exec spu_FVLogin 'xxxx5@gmail.com', '01022223335', 5, 101, 82, 0, 'pushid', -1			-- 삭제유저
exec spu_FVLogin 'xxxx6@gmail.com', '01022223336', 5, 101, 82, 0, 'pushid', -1			-- 삭제유저
exec spu_FVLogin 'xxxx7@gmail.com', '01022223337', 5, 101, 82, 0, 'pushid', -1			-- 삭제유저
exec spu_FVLogin 'xxxx8@gmail.com', '01022223338', 5, 101, 82, 0, 'pushid', -1			-- 삭제유저
exec spu_FVLogin 'xxxx9@gmail.com', '01022223339', 5, 101, 82, 0, 'pushid', -1			-- 삭제유저

delete from dbo.tUserMaster where gameid in ('', 'xxxx91@gmail.com', 'xxxx92@gmail.com', 'xxxx93@gmail.com', 'xxxx95@gmail.com', 'xxxx96@gmail.com', 'xxxx97@gmail.com')
delete from dbo.tFVGiftList where gameid in ('', 'xxxx91@gmail.com', 'xxxx92@gmail.com', 'xxxx93@gmail.com', 'xxxx95@gmail.com', 'xxxx96@gmail.com', 'xxxx97@gmail.com')
exec spu_FVLogin 'xxxx91@gmail.com', '01022223390', 1, 101, 82, 0, 'pushid', -1	-- SKT
exec spu_FVLogin 'xxxx92@gmail.com', '01022223390', 2, 101, 82, 0, 'pushid', -1	-- KT
exec spu_FVLogin 'xxxx93@gmail.com', '01022223390', 3, 101, 82, 0, 'pushid', -1	-- LGT Event
exec spu_FVLogin 'xxxx95@gmail.com', '01022223390', 5, 101, 82, 0, 'pushid', -1	-- Google
exec spu_FVLogin 'xxxx96@gmail.com', '01022223390', 6, 101, 82, 0, 'pushid', -1	-- NHN Event
exec spu_FVLogin 'xxxx97@gmail.com', '01022223390', 7, 101, 82, 0, 'pushid', -1	-- iPhone

-- delete from dbo.tUserMaster where gameid in ('xxxx70@gmail.com', 'xxxx72@gmail.com')
-- select * from dbo.tUserMaster where gameid in ('xxxx70@gmail.com', 'xxxx72@gmail.com')
exec spu_FVLogin 'xxxx70@gmail.com', '01022223371', 5, 199, 82, 0, 'pushid', -1	-- Google(무료)
exec spu_FVLogin 'xxxx72@gmail.com', '01022223372', 5, 199, 82, 1, 'pushid', -1	-- Google(유료)

exec spu_FVLogin 'xxxx81@gmail.com', '01022223381', 3, 199, 82, 0, 'pushid', -1	-- LGT Event
*/

IF OBJECT_ID ( 'dbo.spu_FVLogin', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVLogin;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_FVLogin
	@gameid_								varchar(60),					-- 게임아이디
	@phone_									varchar(20),
	@market_								int,							-- (구매처코드)
	@version_								int,							-- 클라버젼
	@concode_								int,
	@buytype_								int,							-- (무료/유료코드)
																			--		무료가입 : 리워드 최소 BUYTYPE_FREE		= 0
																			--		유료가입 : 리워드 많음 BUYTYPE_PAY		= 1
	@pushid_								varchar(256),
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

	-- (무료/유료코드)
	declare @BUYTYPE_FREE						int					set @BUYTYPE_FREE 					= 0	-- 무료가입 : 리워드 최소
	declare @BUYTYPE_PAY						int					set @BUYTYPE_PAY 					= 1	-- 유료가입 : 리워드 많음
	declare @BUYTYPE_PAY2						int					set @BUYTYPE_PAY2 					= 2	-- 유료가입(재가입)

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
	--declare @GIFTLIST_GIFT_KIND_MESSAGE		int					set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2
	--declare @GIFTLIST_GIFT_KIND_MESSAGE_DEL	int					set @GIFTLIST_GIFT_KIND_MESSAGE_DEL			= -1
	--declare @GIFTLIST_GIFT_KIND_GIFT_DEL		int					set @GIFTLIST_GIFT_KIND_GIFT_DEL			= -2
	--declare @GIFTLIST_GIFT_KIND_GIFT_GET		int					set @GIFTLIST_GIFT_KIND_GIFT_GET			= -3
	--declare @GIFTLIST_GIFT_KIND_GIFT_SELL		int					set @GIFTLIST_GIFT_KIND_GIFT_SELL			= -4
	--declare @GIFTLIST_GIFT_KIND_LIST			int					set @GIFTLIST_GIFT_KIND_LIST				= -5

	-------------------------------------------------------------------
	-- Event1. 일일 매일 보상하는 아이템.
	-------------------------------------------------------------------
	declare @EVENT_STATE_NON					int					set @EVENT_STATE_NON				=-1
	declare @EVENT_STATE_YES					int					set @EVENT_STATE_YES				= 1

	------------------------------------------------
	-- ~ 2015.03.27
	-- 2. 생애 첫결제 지원
	-- 3. 정착지원 재료
	--	> 우유    		: 200	3000
	--	> 요구르트		: 200	3001
	--	> 저지방 우유	: 100	3002
	--	> 바나나 우유 	: 100	3004
	--	> 생크림		: 100	3005
	--	> 코인 			: 20000	3100
	------------------------------------------------
	declare @EVENT02_END_DAY					datetime			set @EVENT02_END_DAY			= '2015-03-31 23:59'
	declare @EVENT0X_END_DAY					datetime			set @EVENT0X_END_DAY			= '2015-03-07 05:00'

	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @comment				varchar(512)			set @comment		= '로그인'
	declare @gameid 				varchar(60)				set @gameid			= ''
	declare @phone 					varchar(20)
	declare @market					int						set @market			= @MARKET_GOOGLE
	declare @curdate				datetime				set @curdate		= getdate()
	declare @blockstate				int						set @blockstate		= 0
	declare @ownercashcost			bigint					set @ownercashcost	= 0
	declare @cashcopy				int						set @cashcopy		= 0

	declare @curversion				int						set @curversion		= -1
	declare @cursyscheck			int

	-- 시간체킹
	declare @dateid8 				varchar(8) 				set @dateid8 		= Convert(varchar(8), Getdate(),112)
	declare @logindate				varchar(8)				set @logindate		= '20100101'
	declare @attendnewday			int						set @attendnewday	= -1
	declare @roulette				int						set @roulette		= -1

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
	declare @idx					int				set @idx 						= 0
	declare @idx2					int				set @idx2 						= 0

	-- 세이브데이타.
	declare @savedata				varchar(4096)	set @savedata					= ''
	declare @strmarket				varchar(40)

	-- 기타변수.
	declare @eventspot0x			int				set @eventspot0x 				= 1

	-- 랭킹초기화 시간표시.
	declare @schoolinitdate			varchar(19),
			@dw						int
	declare @userrankview			int				set @userrankview				= -1 -- 안보임(-1), 보임(1)


	-- 보물할인(X).
	declare @roulsaleflag			int				set @roulsaleflag		= -1
	declare @roulsalevalue			int				set @roulsalevalue		=  0

	-- 보물보상(X).
	declare @roulrewardflag			int				set @roulrewardflag		= -1

	-- 보물확률상승(X).
	declare @roultimeflag			int				set @roultimeflag		= -1
	declare @roultimetime1			int				set @roultimetime1		= -1
	declare @roultimetime2			int				set @roultimetime2		= -1
	declare @roultimetime3			int				set @roultimetime3		= -1
	declare @roultimetime4			int				set @roultimetime4		= -1

	-- 보물무료뽑기(X).
	declare @tsgauageflag			int				set @tsgauageflag		= -1

	-- 보물강화할인(X).
	declare @tsupgradesaleflag		int				set @tsupgradesaleflag	= -1
	declare @tsupgradesalevalue		int				set @tsupgradesalevalue	=  0

	-- 룰렛(회전판)무료뽑기.
	declare @wheelgauageflag		int				set @wheelgauageflag	= -1
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG 입력정보', @gameid_ gameid_, @phone_ phone_, @market_ market_, @version_ version_, @concode_ concode_, @pushid_ pushid_

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	select
		@gameid 		= gameid,
		@roulette		= roulette,
		@logindate		= logindate,
		@blockstate		= blockstate,
		@cashcopy		= cashcopy,
		@eventspot0x	= eventspot0x
	from dbo.tUserMaster
	where gameid = @gameid_
	--select 'DEBUG 유저정보', @gameid gameid

	------------------------------------------------
	--	3-3. 공지사항 체크
	------------------------------------------------
	select
		top 1
		@cursyscheck 	= syscheck,
		@curversion 	= version,
		@idx 			= idx
	from dbo.tFVNotice
	where market = @market_
	order by idx desc
	--select 'DEBUG 공지사항', @cursyscheck cursyscheck, @curversion curversion

	if(@cursyscheck = @SYSCHECK_YES)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_SERVER_CHECKING
			set @comment 	= 'DEBUG 시스템 점검중입니다.'
			--select 'DEBUG ', @comment
		END
	else if(@gameid_ = '')
		BEGIN
			-- 아이디가 존재하지않는가??
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '아이디가 존재하지 않는다. > 아이디를 확인해라.'
			--select 'DEBUG ', @comment
		END
	else if(@blockstate = 1)
		BEGIN
			-- 아이디가 존재하지않는가??
			set @nResult_ 	= @RESULT_ERROR_BLOCK_USER
			set @comment 	= '계정이 블럭 되었습니다.'
			--select 'DEBUG ', @comment
		END
	else if(@version_ < @curversion)
		BEGIN
			-- 마켓별 버젼이 틀리다
			set @nResult_ 	= @RESULT_NEWVERION_CLIENT_DOWNLOAD
			set @comment 	= '마켓별 버젼이 틀리다. > 다시받아라.'
			--select 'DEBUG ', @comment
		END
	else if (exists(select top 1 * from dbo.tFVUserBlockPhone where phone = @phone_))
		BEGIN
			-- 블럭유저인가?
			set @nResult_ 	= @RESULT_ERROR_BLOCK_USER
			set @comment 	= '블럭처리된 아이디입니다.'
			--select 'DEBUG ', @comment
		END
	else if(@cashcopy >= 2)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_BLOCK_USER
			set @comment 	= '캐쉬결재카피를 '+ltrim(rtrim(str(@cashcopy)))+'회 이상했다. > 블럭처리하자!!'
			--select 'DEBUG ', @comment

			-- xx회 이상카피행동 > 블럭처리, 블럭로그기록
			update dbo.tUserMaster
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
	select @nResult_ rtn, @comment comment, @curdate curdate, comment ntcomment, version curversion, * from dbo.tFVNotice where idx = @idx

	if(@nResult_ = @RESULT_SUCCESS)
		BEGIN
			if(@gameid = '')
				begin
					--select 'DEBUG 신규가입'
					---------------------------------------------
					-- 가입, 유니크 가입.
					---------------------------------------------
					insert into dbo.tUserMaster(gameid,   phone,   market,   version,   concode,   pushid,   buytype)
					values(                      @gameid_, @phone_, @market_, @version_, @concode_, @pushid_, @buytype_)

					---------------------------------------------
					-- 무료, 유료 정보 구분해서 저장.
					---------------------------------------------
					if(@buytype_ = @BUYTYPE_PAY)
						begin
							--select 'DEBUG 신규가입(유료)'
							------------------------------
							-- 유료 가입 > 통계정보.
							--	> 유료 가입자는 캐쉬를 선물함으로 전달.
							------------------------------
							exec spu_FVDayLogInfoStatic @market_, 15, 1               -- 일 유니크 가입(유료)

							--if(@market_ = @MARKET_GOOGLE)
							--	begin
							--		exec spu_FVSubGiftSend 2, 3015, 5000, 'sangsang', @gameid_, ''
							--	end
						end
					else
						begin
							--select 'DEBUG 신규가입(무료)'
							------------------------------
							-- 무료 가입 > 통계정보.
							------------------------------
							exec spu_FVDayLogInfoStatic @market_, 11, 1               -- 일 유니크 가입(무료)

						end

					---------------------------------------------
					--	Event
					-----------------------------------------------
					--select 'DEBUG ', @market_ market_, @curdate curdate, @gameid_ gameid_
					if(@curdate < @EVENT02_END_DAY)
						begin
							exec spu_FVSubGiftSend 2, 3000,  200, 'NewStart', @gameid_, ''
							exec spu_FVSubGiftSend 2, 3001,  200, 'NewStart', @gameid_, ''
							exec spu_FVSubGiftSend 2, 3002,  100, 'NewStart', @gameid_, ''
							exec spu_FVSubGiftSend 2, 3004,  100, 'NewStart', @gameid_, ''
							exec spu_FVSubGiftSend 2, 3005,  100, 'NewStart', @gameid_, ''
							exec spu_FVSubGiftSend 2, 3100,20000, 'NewStart', @gameid_, ''
						end
				end

			-------------------------------------------------------------------
			-- 패치보상
			-------------------------------------------------------------------
			if(@market_ = @MARKET_GOOGLE and @eventspot0x = 0 and @curdate < @EVENT0X_END_DAY)
				begin
					exec spu_FVSubGiftSend 2, 3015,   3000, '패치보상', @gameid_, ''
					exec spu_FVSubGiftSend 2, 3100,5000000, '패치보상', @gameid_, ''
					set @eventspot0x = 1
				end


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

					set @eventidx2 = (@curyear - 2013)*1000000 + @curmonth*10000 + @curday*100 + @eventidx
					--select 'DEBUG 지정이벤트1-2', @eventidx eventidx, @eventitemcode eventitemcode, @eventsender eventsender, @eventidx2 eventidx2

					if(@eventidx != -1 and @eventitemcode != -1)
						begin
							--select 'DEBUG 지정이벤트1-3'
							if(not exists(select top 1 * from dbo.tFVEvnetUserGetLog where gameid = @gameid_ and eventidx = @eventidx2))
								begin
									--select 'DEBUG 지정이벤트1-4 선물, 로그기록'
									exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @eventitemcode, @eventcnt, @eventsender, @gameid_, 'login'

									insert into dbo.tFVEvnetUserGetLog(gameid,   eventidx,  eventitemcode)
									values(                         @gameid_, @eventidx2, @eventitemcode)

									-- 자세한 로고는 선물함에 있어서 삭제해도 된다.
									select @idx2 = max(idx) from dbo.tFVEvnetUserGetLog
									delete from tFVEvnetUserGetLog where idx <= @idx2 - 800
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
				end
			else
				begin
					exec spu_FVDayLogInfoStatic @market_, 12, 1               -- 일 로그인(중복)
				end
			set @logindate = @dateid8

			-----------------------------------------------------------------
			-- 세이브 정보.
			-----------------------------------------------------------------
			select @savedata = savedata from dbo.tFVUserData where gameid = @gameid_ and market = @market_
			set @ownercashcost = dbo.fnu_GetFVSaveDataToCashcost(@savedata)

			----------------------------------------------
			-- 학교정보 초기화날짜(매주 토요일 오후 11:00).
			---------------------------------------------
			select @dw = DATEPART(dw, @curdate)
			set @curdate = @curdate + (7 - @dw)
			set @schoolinitdate = CONVERT(char(10), @curdate, 25) + ' 23:00:00'

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
				@roultimetime1	= roultimetime1,	@roultimetime2	= roultimetime2,	@roultimetime3	= roultimetime3, @roultimetime4	= roultimetime4,

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


			----------------------------------------------
			-- 랭킹보기?
			---------------------------------------------
			select @userrankview = userrankview from dbo.tFVUserRankView where idx = 1

			------------------------------------------------------------------
			-- 유저 정보를 업데이트하기
			------------------------------------------------------------------
			--select * from dbo.tUserMaster where gameid = @gameid_

			update dbo.tUserMaster
				set
					market			= @market_,
					version			= @version_,
					concode			= @concode_,
					ownercashcost	= @ownercashcost,
					pushid			= @pushid_,
					phone			= @phone_,
					eventspot0x		= @eventspot0x,
					logindate		= @logindate,		-- 로그인날짜별.
					roulette		= @roulette,
					condate			= getdate(),		-- 최종접속일
					concnt			= concnt + 1		-- 접속횟수 +1
			where gameid = @gameid_

			----------------------------------------------
			-- 유저 정보
			---------------------------------------------
			select
				concnt,
				@attendnewday attendnewday,
				@savedata savedata,
				@userrankview userrankview,
				@schoolinitdate userrankinitdate,

				@roulsaleflag roulsaleflag, @roulsalevalue roulsalevalue,
				@tsupgradesaleflag tsupgradesaleflag, @tsupgradesalevalue tsupgradesalevalue,
				@roulrewardflag roulrewardflag,
				@roultimeflag roultimeflag,
				@roultimetime1 roultimetime1, @roultimetime2 roultimetime2,	@roultimetime3 roultimetime3, @roultimetime4 roultimetime4,
				@tsgauageflag tsgauageflag,
				@wheelgauageflag wheelgauageflag, wheelgauage, wheelfree,
				tsgrade1cnt, tsgrade2cnt, tsgrade3cnt, tsgrade4cnt,
						     tsgrade2gauage, tsgrade3gauage, tsgrade4gauage,
						     tsgrade2free, tsgrade3free, tsgrade4free,
						     adidx,
				kakaomsginvitecnt, kakaomsginvitetodaycnt, kakaomsginvitetodaydate,
				roulette, nickname, nickcnt
			from dbo.tUserMaster where gameid = @gameid_

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
			-- 카톡 초대친구들
			--------------------------------------------------------------
			select * from dbo.tFVKakaoInvite where gameid = @gameid_ and senddate >= (getdate() - 7)

			--------------------------------------------------------------
			-- 유저 전체랭킹
			--------------------------------------------------------------
			if(@userrankview = 1)
				begin
					exec spu_FVsubTotalRank @gameid_
				end
		END

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
End



