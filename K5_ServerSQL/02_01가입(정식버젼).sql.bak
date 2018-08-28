/*
-- 일반가입
--select * from dbo.tKakaoMaster where gameid like 'xxxx%'
exec spu_UserCreate 'xxxx',   '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 101, '01011112221', '',    'kakaotalkidxxxx',      'kakaouseridxxxx',      'kakaogameid01',   '', '', -1, '', -1
exec spu_UserCreate 'xxxx2',  '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 101, '01011112222', '',    'kakaotalkidxxxx2',     'kakaouseridxxxx2',     'kakaogameid02',   '', '', -1, '', -1
exec spu_UserCreate 'xxxx3',  '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 101, '01011112222', '',    'kakaotalkidxxxx3',     'kakaouseridxxxx3',     'kakaogameid03',   '', '', -1, '', -1
exec spu_UserCreate 'xxxx4',  '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 101, '01011112222', '',    'kakaotalkidxxxx4',     'kakaouseridxxxx4',     'kakaogameid04',   '', '', -1, '', -1
exec spu_UserCreate 'xxxx5',  '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 101, '01011112222', '',    'kakaotalkidxxxx5',     'kakaouseridxxxx5',     'kakaogameid05',   '', '', -1, '', -1
exec spu_UserCreate 'xxxx6',  '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 101, '01011112222', '',    'kakaotalkidxxxx6',     'kakaouseridxxxx6',     'kakaogameid06',   '', '', -1, '', -1
exec spu_UserCreate 'xxxx7',  '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 101, '01011112222', '',    'kakaotalkidxxxx7',     'kakaouseridxxxx7',     'kakaogameid07',   '', '', -1, '', -1
exec spu_UserCreate 'xxxx8',  '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 101, '01011112222', '',    'kakaotalkidxxxx8',     'kakaouseridxxxx8',     'kakaogameid08',   '', '', -1, '', -1
exec spu_UserCreate 'xxxx9',  '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 101, '01011112222', '',    'kakaotalkidxxxx9',     'kakaouseridxxxx9',     'kakaogameid09',   '', '', -1, '', -1
exec spu_UserCreate 'xxxx10',  '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 103, '01011112210', '',   'kakaotalkidxxxx10',    'kakaouseridxxxx10',    'kakaogameid10',   '', '', -1, '', -1
exec spu_UserCreate 'xxxx11',  '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 103, '01011112211', '',   'kakaotalkidxxxx11',    'kakaouseridxxxx11',    'kakaogameid11',   '', '', -1, '', -1

-- select * from dbo.tUserBlockLog where gameid = ''
-- select * from dbo.tUserMaster where gameid = ''
-- select * from dbo.tUserItem where gameid = ''
-- select * from dbo.tUserSeed where gameid = ''
-- select top 10 * from dbo.tKakaoMaster order by idx desc

-- guest가입 (강제로 5만건 입력하기 )
declare @var 			int
declare @loop			int				set @loop	= 1
declare @gameid 		varchar(20)		set @gameid = 'farm'	-- guest, farm, iuest
declare @phone 			varchar(20)
select @var = max(idx) + 1 from dbo.tUserMaster
set @loop = @var + @loop
while @var < @loop
	begin
		set @phone			= '010' + ltrim(@var)
		exec dbo.spu_UserCreate
							@gameid,					-- gameid
							'049000s1i0n7t8445289',		-- password
							1,							-- market
							0,							-- buytype
							1,							-- platform
							'ukukukuk',					-- ukey
							101,						-- version
							@phone,						-- phone
							'',							-- pushid

							'',							-- kakaotalkid (없으면 임으로 생성해줌)
							'',							-- kakaouserid (없으면 임으로 생성해줌)
							'',							-- kakaogameid (없으면 임으로 생성해줌)
							'', 						-- kakaonickname
							'',							-- kakaoprofile
							-1,							-- kakaomsgblocked
							'0:000000000031;1:000000000033;',-- kakaofriendlist(kakaouserid)
							-1
		set @var = @var + 1
	end
-- 계정 생성에 문제가 있는지 테스트
-- farm(카톡에서 생성) -> iuest(게스트로 생성) -> iuest(연동) -> farm(연동)
-- select kakaouserid, count(*) from dbo.tKakaoMaster group by kakaouserid order by 2 desc
-- select * from dbo.tKakaoMaster where kakaouserid = '88258263875124913' order by idx desc
-- delete from dbo.tKakaoMaster where idx in (9)

*/
use Game4Farmvill5
GO

IF OBJECT_ID ( 'dbo.spu_UserCreate', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_UserCreate;
GO

create procedure dbo.spu_UserCreate
	@gameid_				varchar(20),						-- 게임아이디
	@password_				varchar(20),						-- 암호화해서저장, 유저패스워가 해킹당해도 안전
	@market_				int,								-- (구매처코드) MARKET_SKT
																--		MARKET_SKT		= 1
																--		MARKET_GOOGLE	= 5
																--		MARKET_NHN		= 6
																--		MARKET_IPHONE	= 7
	@buytype_				int,								-- (무료/유료코드)
																--		무료가입 : 리워드 최소 BUYTYPE_FREE		= 0
	@platform_				int,								-- (플랫폼)
																--		PLATFORM_ANDROID	= 1
																--		PLATFORM_IPHONE		= 2
	@ukey_					varchar(256),						-- UKey
	@version_				int,								-- 클라버젼
	@phone_					varchar(20),
	@pushid_				varchar(256),
	@kakaotalkid_			varchar(60),						-- 카톡정보(재가입시 변경됨).
	@kakaouserid_			varchar(60),						--          재가입시 미변경
	@kakaogameid_			varchar(60),						--          재가입시 미변경
	@kakaonickname_			varchar(40),
	@kakaoprofile_			varchar(512),
	@kakaomsgblocked_		int,
	@kakaofriendlist_		varchar(2048),
	@nResult_				int				OUTPUT
	--WITH ENCRYPTION -- 프로시져를 암호화함.
as
	------------------------------------------------
	--	2-1. 에러코드값
	------------------------------------------------
	-- 일반값
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	declare @RESULT_ERROR_ID_DUPLICATE			int				set @RESULT_ERROR_ID_DUPLICATE			= -2
	declare @RESULT_ERROR_ID_CREATE_MAX 		int				set @RESULT_ERROR_ID_CREATE_MAX			= -3	-- 생성제한.
	declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--블럭유저 > 팝업처리후 인트로로 빼버린다.

	declare @RESULT_ERROR_JOIN_WAIT				int				set @RESULT_ERROR_JOIN_WAIT				= -142			-- 가입시간대기.

	------------------------------------------------
	--	2-1. 정의된값
	------------------------------------------------
	-- 상태값.
	declare @BLOCK_STATE_NO						int					set	@BLOCK_STATE_NO					= 0	-- 블럭상태아님
	declare @BLOCK_STATE_YES					int					set	@BLOCK_STATE_YES				= 1	-- 블럭상태

	declare @DELETE_STATE_NO					int					set	@DELETE_STATE_NO				= 0	-- 삭제상태아님
	declare @DELETE_STATE_YES					int					set	@DELETE_STATE_YES				= 1	-- 삭제상태

	declare @ID_MAX								int					set	@ID_MAX							= 99999 -- 한폰당 생성할 수 있는 아이디개수

	-- 일반가입, 게스트 가입
	declare @JOIN_MODE_GUEST					int					set @JOIN_MODE_GUEST				= 1
	declare @JOIN_MODE_PLAYER					int					set @JOIN_MODE_PLAYER				= 2

	-- 아이템별 인벤분류
	declare @USERITEM_INVENKIND_ANI				int 				set @USERITEM_INVENKIND_ANI					= 1
	declare @USERITEM_INVENKIND_CONSUME			int 				set @USERITEM_INVENKIND_CONSUME				= 3
	declare @USERITEM_INVENKIND_PET				int 				set @USERITEM_INVENKIND_PET					= 1000

	-- 경작지 상수
	declare @USERSEED_NEED_BUY					int					set @USERSEED_NEED_BUY						= -2
	declare @USERSEED_NEED_EMPTY				int					set @USERSEED_NEED_EMPTY					= -1
	-- >= 0 이상이면 특정 식물이 심어져있음.
	declare @GAME_INVEN_HOSPITAL_BASE			int					set @GAME_INVEN_HOSPITAL_BASE				= 10+9 	-- 동물병원(병원10 + 필드9).
	declare @GAME_COMPETITION_BASE				int					set @GAME_COMPETITION_BASE					= 90106	-- 진행번호, -1은 없음.
	declare @GAME_FEED_BASE						int					set @GAME_FEED_BASE							= 15	-- 최초 건초값.
	declare @GAME_PET_BASE_ITEMCODE				int					set @GAME_PET_BASE_ITEMCODE					= 100000-- 최초펫.

	-- 아이템 소분류
	declare @ITEM_SUBCATEGORY_USERFARM			int					set @ITEM_SUBCATEGORY_USERFARM	 			= 69	-- 전국목장

	-- 동물정보.
	-- 필드동물 0 ~ 8.
	declare @USERITEM_FIELDIDX_INVEN			int					set @USERITEM_FIELDIDX_INVEN				= -1	-- 창고.
	declare @USERITEM_FIELDIDX_HOSPITAL			int					set @USERITEM_FIELDIDX_HOSPITAL				= -2	-- 병원.

	-- 친구상태값.
	declare @USERFRIEND_STATE_SEARCH			int					set	@USERFRIEND_STATE_SEARCH				=-1;		-- -1: 검색.
	declare @USERFRIEND_STATE_PROPOSE_WAIT		int					set	@USERFRIEND_STATE_PROPOSE_WAIT			= 0;		-- 0 : 친구신청대기
	declare @USERFRIEND_STATE_APPROVE_WAIT		int					set	@USERFRIEND_STATE_APPROVE_WAIT			= 1;		-- 1 : 친구수락대기
	declare @USERFRIEND_STATE_FRIEND			int					set	@USERFRIEND_STATE_FRIEND				= 2;		-- 2 : 상호친구

	-- 농장(정보).
	declare @USERFARM_BUYSTATE_NOBUY			int					set @USERFARM_BUYSTATE_NOBUY				= -1	-- (농장)
	declare @USERFARM_BUYSTATE_BUY				int					set @USERFARM_BUYSTATE_BUY					=  1
	declare @USERFARM_INIT_ITEMCODE				int					set @USERFARM_INIT_ITEMCODE					= 6900

	declare @KAKAO_DATA_YES						int					set @KAKAO_DATA_YES = 1
	declare @KAKAO_DATA_NO						int					set @KAKAO_DATA_NO = -1

	-- 선물 정의값
	declare @GIFTLIST_GIFT_KIND_MESSAGE			int					set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2

	----------------------------------------------
	-- EVENT
	-- kakao 가입 이벤트 ~ 2014-06-19 23:59
	-- 10루비(5009)을 선물로 지급한다.
	----------------------------------------------
	--declare @EVENT01_START_DAY				datetime			set @EVENT01_START_DAY			= '2014-06-19 23:59'
	--declare @EVENT01_END_DAY					datetime			set @EVENT01_END_DAY			= '2014-06-19 23:59'
	--declare @EVENT01_REWARD_ITEM				int					set @EVENT01_REWARD_ITEM		= 5009		-- 10루비
	--declare @EVENT01_REWARD_NAME				varchar(20)			set @EVENT01_REWARD_NAME		= '카톡가입기념'

	----------------------------------------------
	-- Naver 이벤트 처리
	--	기간 : 7.24 ~ 8.6
	--	발표 : 8.11
	--	1. 가입시 ...		=> 시크한 양1마리, 루비 60개
	--						   02_01가입(정식버젼).sql
	--	2. 결제 2배			=> 결제하면 2배 이벤트
	--						   21_01캐쉬(인증서).sql
	--						   21_02캐쉬(관리페이지).sql
	--	3. Naver캐쉬		=> 네이버 캐쉬
	--	4. 리뷰추첨			=> 당첨자 발표 후 1주일 이내 지급을 완료하면 됩니다.
	--						  프리미엄티켓(20명), 루비20개
	--	5. 초대추첨			=> 당첨자 발표 후 1주일 이내 지급을 완료하면 됩니다.
	--						  알바의 귀재패키지(20명), 부활석 10개(전원)
	------------------------------------------------
	--declare @EVENT07_START_DAY				datetime			set @EVENT07_START_DAY			= '2014-06-13 20:00'
	--declare @EVENT07_REWARD_ITEM01			int					set @EVENT07_REWARD_ITEM01		= 205			-- 시크한 검은 양
	--declare @EVENT07_REWARD_ITEM02			int					set @EVENT07_REWARD_ITEM02		= 5000			--루비60
	--declare @EVENT07_REWARD_NAME				varchar(20)			set @EVENT07_REWARD_NAME		= '오픈기념'

	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @sysfriendid	varchar(20)		set @sysfriendid 	= 'farmgirl'
	declare @joincnt		int				set @joincnt		= 0
	declare @joinmode		int				set @joinmode 		= @JOIN_MODE_PLAYER

	declare @cashcost 		int
	declare @gamecost 		int
	declare @loop 			int

	declare	@regmsg			varchar(200)	set @regmsg = '가입을 진심으로 축하 합니다.'
	declare @comment		varchar(80)
	declare @dateid8 		varchar(8)		set @dateid8 = Convert(varchar(8),Getdate(),112)
	declare @blockstate		int
	declare @listidx		int
	declare @itemcode		int
	declare @upstepmax		int				set @upstepmax		= 16
	declare @upstepmax2		int				set @upstepmax2		= 16

	-- 추천인 제도에 따른 변수
	declare @smsgameid		varchar(20)
	declare @smsplusgbrec	int				set @smsplusgbrec	= 0
	declare @smsplusgbmy	int				set @smsplusgbmy	= 0
	declare @commentrec		varchar(128)
	declare @commentmy		varchar(128)

	-- 소비아이템
	declare @bulletlistidx		int,
			@vaccinelistidx		int,
			@albalistidx		int,
			@boosterlistidx		int,
			@petlistidx			int,
			@cnt				int

	-- Kakao
	declare	@kakaotalkid	varchar(60)		set @kakaotalkid	= ''
	declare	@kakaouserid	varchar(60)		set @kakaouserid	= ''
	declare	@kakaouserid2	varchar(60)		set @kakaouserid2	= ''
	declare @gameid			varchar(20)		set @gameid			= ''
	declare @strkind		varchar(20)		set @strkind 		= @gameid_
	declare @kakaodata		int				set @kakaodata 		= @KAKAO_DATA_YES
	declare @idx			int				set @idx			= -1

	declare @deldate		datetime		set @deldate		= getdate() - 1
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	if(exists(select top 1 * from dbo.tUserBlockPhone where phone = @phone_))
		begin
			-- 블럭유저인가?
			set @nResult_ 	= @RESULT_ERROR_BLOCK_USER
			set @comment 	= '블럭처리된 아이디입니다.'
			--select 'DEBUG ', @comment
			select @nResult_ rtn, @comment comment, @gameid_ gameid, @password_ password, @deldate waittime
			return
		end



	------------------------------------------------
	--	3-2. 게스트ID생성
	------------------------------------------------
	--select 'DEBUG ', @gameid_ gameid_, @kakaouserid_ kakaouserid_
	if(@gameid_ in ('farm', 'guest', 'iuest'))
		begin
			--select 'DEBUG 서버생성(1)'
			if(@kakaouserid_ = '')
				begin
					--select 'DEBUG kakaotalkid create'
					SET @kakaouserid_ = @gameid_ + cast(replace(NEWID(), '-', '') as varchar(15))
					SET @kakaotalkid_ = @kakaouserid_
				end

			set @joinmode = @JOIN_MODE_GUEST

			-- 1. guest 아이디생성
			declare @maxIdx int
			declare @rand int
			select @maxIdx = max(idx)+1 from dbo.tUserMaster
			set @rand 	= 100 + Convert(int, ceiling(RAND() * 899))	-- 100 ~ 999
			set @gameid_ = @gameid_ + rtrim(ltrim(str(@maxIdx))) + rtrim(ltrim(str(@rand)))
			--select 'DEBUG 3-2-1 guest가입모드', @gameid_

			if exists (select * from tUserMaster where gameid = @gameid_)
				begin
					declare @tmp varchar(10)
					set @tmp = replace(newid(), '-', '')
					set @gameid_ = @gameid_ + @tmp
					--select 'DEBUG 3-2-2 guest중복되어서 그냥생성', @gameid_
				end
		end
	--else if(PATINDEX('%iuest%', @gameid_) = 1 and @kakaouserid_ != '')
	--	begin
	--		-- 카톡 마스터 계정이 삭제되어야한다.
	--		--select 'DEBUG 카톡 마스터 계정삭제', @kakaouserid_ kakaouserid_
	--		delete from dbo.tKakaoMaster where kakaouserid = @kakaouserid_
    --
	--		-- 88452235362617025 > iuest583397699, farm161006288
	--		-- insert into dbo.tKakaoMaster(kakaotalkid,   kakaouserid,                 gameid,   kakaodata, writedate)
	--		-- values(						'A1QZxsYZVAM', '88452235362617025', 'farm161006288', 1, '2014-05-12 12:14')
	--		-- 카톡 마스터 계정 입력
	--		if(exists(select top 1 * from dbo.tKakaoMaster where gameid = @gameid_))
	--			begin
	--				--select 'DEBUG 루비', @gameid_ gameid_, @kakaotalkid_ kakaotalkid_, @kakaouserid_ kakaouserid_, @kakaodata kakaodata
	--				update dbo.tKakaoMaster
	--					set
	--						kakaotalkid	= @kakaotalkid_,
	--						kakaouserid = @kakaouserid_,
	--						kakaodata	= @kakaodata
	--				where gameid = @gameid_
	--			end
	--		else
	--			begin
	--				--select 'DEBUG 입력', @gameid_ gameid_, @kakaotalkid_ kakaotalkid_, @kakaouserid_ kakaouserid_, @kakaodata kakaodata
	--				insert into dbo.tKakaoMaster(kakaotalkid,   kakaouserid,   gameid,   kakaodata)
	--				values(						@kakaotalkid_, @kakaouserid_, @gameid_, @kakaodata)
	--			end
    --
	--		-- 유저 정보 갱신.
	--		update dbo.tUserMaster
	--			set
	--				kakaotalkid		= @kakaotalkid_,
	--				kakaouserid		= @kakaouserid_,
	--				kakaonickname	= @kakaonickname_,
	--				kakaoprofile	= @kakaoprofile_,
	--				kakaomsgblocked	= @kakaomsgblocked_
	--		where gameid = @gameid_
	--	end
	else if(@kakaouserid_ != '' and @gameid_ != '')
		begin
			 select @kakaouserid2 = kakaouserid from dbo.tKakaoMaster where gameid = @gameid_
			 --select 'DEBUG 직접생성(2)', @gameid_ gameid_, @kakaouserid2 kakaouserid2, @kakaouserid_ kakaouserid_

			 if(@kakaouserid_ != @kakaouserid2)
			 	begin
			 		--select 'DEBUG kakaouserid가 다름 > 신규생성을 위해 삭제', @kakaouserid2 kakaouserid2
			 		-- 임의의 생성된 카톡아이디는 삭제.
			 		delete from dbo.tKakaoMaster where kakaouserid = @kakaouserid2

					-- 카톡 마스터 계정 입력
					if(exists(select top 1 * from dbo.tKakaoMaster where kakaouserid = @kakaouserid_))
						begin
							--select 'DEBUG kakaouserid > update'
							update dbo.tKakaoMaster
								set
									kakaotalkid		= @kakaotalkid_,
									kakaodata		= @kakaodata,
									gameid 			= @gameid_
							where kakaouserid = @kakaouserid_
						end
					else
						begin
							--select 'DEBUG kakaouserid > insert', @gameid_ gameid_, @kakaotalkid_ kakaotalkid_, @kakaouserid_ kakaouserid_, @kakaodata kakaodata
							insert into dbo.tKakaoMaster(kakaotalkid,   kakaouserid,   gameid,   kakaodata)
							values(						@kakaotalkid_, @kakaouserid_, @gameid_, @kakaodata)
						end

					-- 유저 정보 갱신.
					update dbo.tUserMaster
						set
							kakaotalkid		= @kakaotalkid_,
							kakaouserid		= @kakaouserid_,
							kakaogameid		= @kakaogameid_,
							kakaonickname	= @kakaonickname_,
							kakaoprofile	= @kakaoprofile_,
							kakaomsgblocked	= @kakaomsgblocked_
					where gameid = @gameid_
				end
		end

	--select 'DEBUG 3-2-3', @gameid_ gameid_, @password_ password_, @market_ market_, @buytype_ buytype_, @platform_ platform_, @ukey_ ukey_, @version_ version_, @phone_ phone_, @pushid_ pushid_
	if(@strkind in ('iuest'))
		begin
			set @kakaonickname_ 	= @gameid_
			set @kakaodata			= @KAKAO_DATA_NO
		end

	------------------------------------------------
	-- 핸드폰으로 생성된 아이디기 갯수 파악
	--select
	--	@joincnt = isnull(count(*), 0)
	--from tUserMaster where phone = @phone_ and deletestate = @DELETE_STATE_NO
	------------------------------------------------
	select
		@joincnt = joincnt
	from tUserPhone where phone = @phone_
	--select 'DEBUG 3-2-4  핸드폰별 가입자:', @phone_ phone_, @joincnt joincnt

	------------------------------------------------
	-- 카카오 계정을 찾기
	-- 처음가입	: '' > ''					      -> 88258263875124913 > guestxxxx
	-- 새로하기	: 88258263875124913 > guestxxxx   -> 88258263875124913 > ''
	-- 재가입	: 88258263875124913 > ''		  -> 88258263875124913 > guestxxxx
	------------------------------------------------
	select top 1
		@idx			= idx,
		@kakaotalkid	= kakaotalkid,
		@kakaouserid 	= kakaouserid,
		@gameid 		= gameid,
		@deldate		= deldate
	from dbo.tKakaoMaster
	where kakaouserid = @kakaouserid_
	order by idx desc
	--select 'DEBUG 3-2-5', @kakaouserid_ kakaouserid_, @kakaotalkid kakaotalkid, @kakaouserid kakaouserid, @gameid gameid, @deldate deldate

	------------------------------------------------
	--	3-3. 유저생성.
	------------------------------------------------
	if (@gameid != '' and exists(select top 1 * from dbo.tUserMaster where gameid = @gameid))
		begin
			set @nResult_ = @RESULT_SUCCESS
			set @comment = '(재연결)가입을 축하합니다.'
			--select 'DEBUG 3', @comment
			if(@kakaotalkid != @kakaotalkid_)
				begin
					--select 'DEBUG 3 kakaotalkid 입력, 저장값이 틀려서 갱신', @kakaotalkid kakaotalkid, @kakaotalkid_ kakaotalkid_
					-- 재갱신될때가 있다.
					update dbo.tKakaoMaster
						set
							kakaotalkid 	= @kakaotalkid_,
							cnt2			= cnt2 + 1
					where idx = @idx
				end

			-- 닉네임과 프로파일을 갱신하다.
			update dbo.tUserMaster
				set
					kakaoprofile	= @kakaoprofile_,
					--kakaonickname = @kakaonickname_,
					--market		= @market_,				-- 로그인할때 변경한다.
					pushid			= @pushid_
			where gameid = @gameid

			select @nResult_ rtn, @comment comment, gameid, password, @deldate waittime
			from dbo.tUserMaster
			where gameid = @gameid
			return
		end
	else if exists (select * from tUserMaster where gameid = @gameid_)
		begin
			set @nResult_ = @RESULT_ERROR_ID_DUPLICATE
			set @comment = '(생성)아이디가 중복되었습니다.'
			--select 'DEBUG 4', @comment
		end
	else if(@joincnt >= @ID_MAX)
		begin
			set @nResult_ = @RESULT_ERROR_ID_CREATE_MAX
			set @comment = '생성개수 ' + ltrim(str(@ID_MAX)) + '개까지만(삭제는제외)'
			--select 'DEBUG 5', @comment
		end
	else if(@idx != -1 and @deldate > (getdate() - 1))
		begin
			set @nResult_ = @RESULT_ERROR_JOIN_WAIT
			set @comment = '일정 시간동안 재가입이 불가합니다.'

			set @deldate = @deldate + 1
			--select 'DEBUG 5', @comment
		end
	else
		begin
			set @nResult_ = @RESULT_SUCCESS
			set @comment = '(생성)가입을 축하합니다.'
			--select 'DEBUG 6', @comment

			-------------------------------------------
			-- 1. 초기 지급
			-- 무료 : 캐쉬(10),  게임머니(400), 건초(5)
			-- 튜토 : 4루비 + 150코인 + 2 캐시 일꾼 + 2캐시 백신
			-------------------------------------------
			set @cashcost		= 60
			set @gamecost		= 400

			--select 'DEBUG 6-1. 초기 지급', @buytype_ buytype_, @cashcost cashcost, @gamecost gamecost

			-------------------------------------------
			-- 2. 블럭폰 > 가입블럭처리
			-------------------------------------------
			--select 'DEBUG 6-2. 블럭폰인지 검사'
			if(exists(select top 1 * from dbo.tUserBlockPhone where phone = @phone_))
				begin
					--select 'DEBUG > 6-2-2 @@@@블럭 핸드폰@@@@'
					--블럭유저로 카입처리.
					set @blockstate = @BLOCK_STATE_YES

					-- 블럭유저라 가입부터 블럭으로 처리한다.
					insert into dbo.tUserBlockLog(gameid, comment)
					values(@gameid_, '블럭 유저가 가입할려고 해서 가입부터 블럭처리함.')
				end
			else
				begin
					--select 'DEBUG > 6-2-3 NON블럭'
					set @blockstate = @BLOCK_STATE_NO
				end

			------------------------------------------------
			-- 소 7마리 : (대표소 1 + 일반소6)
			------------------------------------------------
			--select 'DEBUG 6-4 아이템지급 > 동물입력'
			set @listidx		= 0
			set @itemcode		= 1
			select @upstepmax  = param30 from dbo.tItemInfo where itemcode = 1
			select @upstepmax2 = param30 from dbo.tItemInfo where itemcode = 2

			insert into dbo.tUserItem(gameid,   listidx,      itemcode, cnt, farmnum, fieldidx,  upstepmax, invenkind)					-- 대표동물.
			values(					 @gameid_, @listidx + 0, 		 1,   1,       0,        0, @upstepmax, @USERITEM_INVENKIND_ANI)	--	E등급 소

			insert into dbo.tUserItem(gameid,   listidx,      itemcode, cnt, farmnum, fieldidx,  upstepmax, invenkind)
			values(					 @gameid_, @listidx + 1, 		 1,   1,       0,        1, @upstepmax, @USERITEM_INVENKIND_ANI)

			insert into dbo.tUserItem(gameid,   listidx,      itemcode, cnt, farmnum, fieldidx,  upstepmax, invenkind)
			values(					 @gameid_, @listidx + 2, 		 1,   1,       0,        2, @upstepmax, @USERITEM_INVENKIND_ANI)

			insert into dbo.tUserItem(gameid,   listidx,      itemcode, cnt, farmnum, fieldidx,  upstepmax,  invenkind)
			values(					 @gameid_, @listidx + 3, 		 2,   1,       0,        3, @upstepmax2, @USERITEM_INVENKIND_ANI)

			--insert into dbo.tUserItem(gameid,   listidx,      itemcode, cnt, farmnum, fieldidx, invenkind)
			--values(				 @gameid_, @listidx + 4, 		 2,   1,       0,        4, @USERITEM_INVENKIND_ANI)

			--insert into dbo.tUserItem(gameid,   listidx,      itemcode, cnt, farmnum, fieldidx, invenkind)
			--values(				 @gameid_, @listidx + 5, 		 2,   1,       0,        5, @USERITEM_INVENKIND_ANI)

			------------------------------------------------
			-- 동물도감 획득표시.(직접 입력할려고 서브 프로시져 사용안함)
			-- exec spu_DogamListLog @gameid_, 1
			------------------------------------------------
			insert into dbo.tDogamList(gameid, itemcode) values(@gameid_, 1)
			insert into dbo.tDogamList(gameid, itemcode) values(@gameid_, 2)

			------------------------------------------------
			-- 펫지급 및 도감기록
			------------------------------------------------
			set @petlistidx	= @listidx + 6
			insert into dbo.tUserItem(gameid,   listidx,            itemcode, cnt, invenkind)
			values(					 @gameid_, @petlistidx,   @GAME_PET_BASE_ITEMCODE,    1, @USERITEM_INVENKIND_PET)

			insert into dbo.tDogamListPet(gameid, itemcode) values(@gameid_, @GAME_PET_BASE_ITEMCODE)

			------------------------------------------------
			-- 백신	: x3
			-- 알바		: x3
			-- 부활템	: x3
			------------------------------------------------
			--select 'DEBUG 6-5 아이템지급 > 소모템(총알x5, 치료제x5, 알바x2, 촉진제x2, 부활템x3)'
			set @bulletlistidx 	= @listidx + 7
			set @cnt			= 5
			insert into dbo.tUserItem(gameid,         listidx, itemcode, cnt, invenkind)							-- 총알x5
			values(					@gameid_, @bulletlistidx,      700, @cnt, @USERITEM_INVENKIND_CONSUME)

			set @vaccinelistidx 	= @listidx + 8
			set @cnt				= 5
			insert into dbo.tUserItem(gameid,          listidx, itemcode, cnt, invenkind)							-- 치료제x5
			values(					@gameid_, @vaccinelistidx,      800, @cnt, @USERITEM_INVENKIND_CONSUME)

			set @albalistidx 		= @listidx + 9
			set @cnt				= 5
			insert into dbo.tUserItem(gameid,       listidx, itemcode, cnt, invenkind)								-- 알바x2
			values(					@gameid_, @albalistidx,     1002, @cnt, @USERITEM_INVENKIND_CONSUME)

			set @boosterlistidx 	= @listidx + 10
			set @cnt				= 5
			insert into dbo.tUserItem(gameid,          listidx, itemcode, cnt, invenkind)							-- 촉진제x2
			values(					@gameid_, @boosterlistidx,     1100, @cnt, @USERITEM_INVENKIND_CONSUME)

			insert into dbo.tUserItem(gameid,      listidx, itemcode, cnt, invenkind)								-- 부활템x3
			values(					@gameid_, @listidx +11,     1200,   3, @USERITEM_INVENKIND_CONSUME)

			insert into dbo.tUserItem(gameid,      listidx, itemcode, cnt, invenkind)								-- 긴급지원x3
			values(					@gameid_, @listidx +14,     2100,   3, @USERITEM_INVENKIND_CONSUME)

			--insert into dbo.tUserItem(gameid,      listidx, itemcode, cnt, invenkind)								-- 프리미엄교배x1
			--values(					@gameid_, @listidx +15,     2300,   1, @USERITEM_INVENKIND_CONSUME)


			---------------------------------------------
			-- kakao 입력하기
			---------------------------------------------
			if(@kakaouserid = '')
				begin
					insert into dbo.tKakaoMaster(kakaotalkid,   kakaouserid,   gameid,   kakaodata)
					values(						@kakaotalkid_, @kakaouserid_, @gameid_, @kakaodata)
				end
			else
				begin
					update dbo.tKakaoMaster
						set
							gameid 	= @gameid_,
							cnt 	= cnt + 1
					where kakaouserid = @kakaouserid_
				end

			---------------------------------------------
			-- kakao 닉네임이 빈곳이면 게임아이디를 입력해준다.
			---------------------------------------------
			--select 'DEBUG ', @kakaonickname_ kakaonickname_, @gameid_ gameid_
			if( @kakaonickname_ = '' )
				begin
					set @kakaonickname_ = @gameid_
				end

			---------------------------------------------
			-- 유저 정보 입력하기,
			-- 대표동물(0)
			-- 하트맥스 : 10
			---------------------------------------------
			--select 'DEBUG 6-3 유저 정보 입력'
			insert into dbo.tUserMaster(gameid, password, market, buytype, platform, ukey, version, phone, pushid,
										gamecost, cashcost, feed,
										petlistidx, petitemcode,
										blockstate,
										l1gameid,
										bulletlistidx, vaccinelistidx, boosterlistidx, albalistidx,
										anireplistidx,
										kakaotalkid,   kakaouserid,  kakaogameid, kakaonickname,   kakaoprofile,   kakaomsgblocked
										)
			values(@gameid_, @password_, @market_, @buytype_, @platform_, @ukey_, @version_, @phone_, @pushid_,
										@gamecost, @cashcost + @smsplusgbmy, @GAME_FEED_BASE,

										@petlistidx, @GAME_PET_BASE_ITEMCODE,
										@blockstate,
										@gameid_,
										@bulletlistidx, @vaccinelistidx, @boosterlistidx, @albalistidx,
										0,
										@kakaotalkid_, @kakaouserid_, @kakaogameid_, @kakaonickname_, @kakaoprofile_, @kakaomsgblocked_
										)

			------------------------------------------------
			-- 경작지1	: 뚫어주기.
			------------------------------------------------
			--select 'DEBUG 6-6 아이템지급 > 경작지(0:구매, 11:미구매)'
			insert into dbo.tUserSeed(gameid, seedidx, itemcode) values(@gameid_, 0, @USERSEED_NEED_EMPTY)
			set @loop = 1
			while(@loop < 12)
				begin
					insert into dbo.tUserSeed(gameid, seedidx, itemcode) values(@gameid_, @loop, @USERSEED_NEED_BUY)
					set @loop = @loop + 1
				end

			------------------------------------------------
			-- 가상친구추기(상호 수락상태로 전송된다.)
			------------------------------------------------
			insert into dbo.tUserFriend(gameid,      friendid, state)
			values(                    @gameid_, @sysfriendid, @USERFRIEND_STATE_FRIEND)

			------------------------------------
			-- 가입 통계를 작성한다.(일반, 게스트)
			------------------------------------
			--select 'DEBUG > 6-7 가입 통계를 작성한다.'
			if(@joinmode = @JOIN_MODE_PLAYER)
				begin
					--select 'DEBUG > 6-7-2 아이디입력방식 생성'
					exec spu_DayLogInfoStatic @market_, 10, 1
				end
			else
				begin
					--select 'DEBUG > 6-7-2 게스트 생성'
					exec spu_DayLogInfoStatic @market_, 13, 1
				end

			----------------------------------------------
			---- 핸드폰별 가입 카운터
			----------------------------------------------
			if(@joincnt = 0)
				begin
					--select 'DEBUG > 6-8 핸드폰별 가입 카운터'
					exec spu_DayLogInfoStatic @market_, 11, 1

					insert into dbo.tUserPhone(phone, market, joincnt) values(@phone_, @market_, 1)

					----------------------------
					------ 이벤트
					----------------------------
					--exec spu_SubgiftsendNew @GIFTLIST_GIFT_KIND_GIFT, @EVENT07_REWARD_ITEM01, 1,  @EVENT07_REWARD_NAME, @gameid_, ''
					--exec spu_SubgiftsendNew @GIFTLIST_GIFT_KIND_GIFT, @EVENT07_REWARD_ITEM02, 100, @EVENT07_REWARD_NAME, @gameid_, ''
				end
			else
				begin
					update dbo.tUserPhone
						set
							joincnt = joincnt + 1
					where phone = @phone_
				end

			------------------------------------------------
			-- 농장리스트 추가.
			-- 첫목장 지급안함 > 점령의 맛을 뺏으면 안되지.
			------------------------------------------------
			insert into dbo.tUserFarm(farmidx, gameid, itemcode)
			select rank() over(order by itemcode asc) as farmidx, @gameid_, itemcode from dbo.tItemInfo
			where subcategory = @ITEM_SUBCATEGORY_USERFARM order by itemcode asc

			----------------------------------------------
			-- kakao 친구 정보 검색해서 입력하기.
			----------------------------------------------
			exec sup_subAddKakaoFriend @gameid_, @kakaofriendlist_

		end

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	select @nResult_ rtn, @comment comment, @gameid_ gameid, @password_ password, @deldate waittime
	--, CONVERT(CHAR(19), @deldate, 20) deldate > 파일을 받는 곳에서 계속 오류가 난다. ㅠㅠ

	--최종 결과를 리턴한다.
	set nocount off
End



