/*
-- 일반가입
select * from dbo.tFVKakaoMaster where gameid like 'xxxx%'
select * from dbo.tUserMaster where kakaouserid like 'kakaouserid%'
exec spu_FVUserCreate 'xxxx',   '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 101, '01011112221', '', 'kakaotalkidxxxx', 'kakaouseridxxxx', -1, '', -1
exec spu_FVUserCreate 'xxxx@gmail.com',  '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 101, '01011112222', '', 'kakaotalkidxxxx2', 'kakaouseridxxxx2', -1, '', -1
exec spu_FVUserCreate 'xxxx3',  '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 101, '01011112222', '', 'kakaotalkidxxxx3', 'kakaouseridxxxx3', -1, '', -1
exec spu_FVUserCreate 'xxxx4',  '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 101, '01011112222', '', 'kakaotalkidxxxx4', 'kakaouseridxxxx4', -1, '', -1
exec spu_FVUserCreate 'xxxx5',  '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 101, '01011112222', '', 'kakaotalkidxxxx5', 'kakaouseridxxxx5', -1, '', -1
exec spu_FVUserCreate 'xxxx6',  '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 101, '01011112222', '', 'kakaotalkidxxxx6', 'kakaouseridxxxx6', -1, '', -1
exec spu_FVUserCreate 'xxxx7',  '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 101, '01011112222', '', 'kakaotalkidxxxx7', 'kakaouseridxxxx7', -1, '', -1
exec spu_FVUserCreate 'xxxx8',  '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 101, '01011112222', '', 'kakaotalkidxxxx8', 'kakaouseridxxxx8', -1, '', -1
exec spu_FVUserCreate 'xxxx9',  '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 101, '01011112222', '', 'kakaotalkidxxxx9', 'kakaouseridxxxx9', -1, '', -1

-- 처음(생성), 두번째(연결)
exec spu_FVUserCreate 'farm',  '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 101, '01011112222', '', 'kakaotalkidnnnn2', '', -1, '0:x1;1:x2;2:x3;', -1

-- select * from dbo.tUserMaster where gameid = ''
-- select top 10 * from dbo.tFVKakaoMaster order by idx desc

-- guest가입 (강제로 5만건 입력하기 )
declare @var 			int
declare @loop			int				set @loop	= 1
declare @gameid 		varchar(20)		set @gameid = 'farm'	-- farm, iuest
declare @phone 			varchar(20)
select @var = max(idx) + 1 from dbo.tUserMaster
set @loop = @var + @loop
while @var < @loop
	begin
		set @phone			= '010' + ltrim(@var)
		exec dbo.spu_FVUserCreate
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
							-1,							-- kakaomsgblocked
							'0:000000000031;1:000000000033;',-- kakaofriendlist(kakaouserid)
							-1
		set @var = @var + 1
	end
-- 계정 생성에 문제가 있는지 테스트
-- farm(카톡에서 생성) -> iuest(게스트로 생성) -> iuest(연동) -> farm(연동)
-- select kakaouserid, count(*) from dbo.tFVKakaoMaster group by kakaouserid order by 2 desc
-- select * from dbo.tFVKakaoMaster where kakaouserid = '88258263875124913' order by idx desc
-- delete from dbo.tFVKakaoMaster where idx in (9)
*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVUserCreate', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVUserCreate;
GO

create procedure dbo.spu_FVUserCreate
	@gameid_				varchar(60),						-- 게임아이디
	@password_				varchar(20),						-- 암호화해서저장, 유저패스워가 해킹당해도 안전
	@market_				int,
	@buytype_				int,								-- (무료/유료코드)
																--		무료가입 : 리워드 최소 BUYTYPE_FREE		= 0
																--		유료가입 : 리워드 많음 BUYTYPE_PAY		= 1
	@platform_				int,								-- (플랫폼)
																--		PLATFORM_ANDROID	= 1
																--		PLATFORM_IPHONE		= 2
	@ukey_					varchar(256),						-- UKey
	@version_				int,								-- 클라버젼
	@phone_					varchar(20),
	@pushid_				varchar(256),
	@kakaotalkid_			varchar(60),						-- 카톡정보(재가입시 변경됨).
	@kakaouserid_			varchar(60),						--          재가입시 미변경
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
	-- 구매처코드
	--declare @MARKET_SKT						int				set @MARKET_SKT							= 1
	--declare @MARKET_KT						int				set @MARKET_KT							= 2
	--declare @MARKET_LGT						int				set @MARKET_LGT							= 3
	--declare @MARKET_GOOGLE					int				set @MARKET_GOOGLE						= 5
	--declare @MARKET_NHN						int				set @MARKET_NHN							= 6
	--declare @MARKET_IPHONE					int				set @MARKET_IPHONE						= 7

	declare @ID_MAX								int				set	@ID_MAX								= 99999 -- 한폰당 생성할 수 있는 아이디개수

	-- 일반가입, 게스트 가입
	declare @JOIN_MODE_GUEST					int				set @JOIN_MODE_GUEST				= 1
	declare @JOIN_MODE_PLAYER					int				set @JOIN_MODE_PLAYER				= 2

	declare @KAKAO_DATA_YES						int				set @KAKAO_DATA_YES = 1
	declare @KAKAO_DATA_NO						int				set @KAKAO_DATA_NO = -1

	-- 선물 정의값
	--declare @GIFTLIST_GIFT_KIND_MESSAGE		int				set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int				set @GIFTLIST_GIFT_KIND_GIFT				= 2

	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @comment		varchar(80)
	declare @joincnt		int				set @joincnt		= 0
	declare @joinmode		int				set @joinmode 		= @JOIN_MODE_PLAYER

	-- Kakao
	declare	@kakaotalkid	varchar(60)		set @kakaotalkid	= ''
	declare	@kakaouserid	varchar(60)		set @kakaouserid	= ''
	declare	@kakaouserid2	varchar(60)		set @kakaouserid2	= ''
	declare @gameid			varchar(60)		set @gameid			= ''
	declare @strkind		varchar(60)		set @strkind 		= @gameid_
	declare @kakaodata		int				set @kakaodata 		= @KAKAO_DATA_YES
	declare @idx			int				set @idx			= -1

	declare @deldate		datetime		set @deldate		= getdate() - 1
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG ', @gameid_ gameid_, @password_ password_, @market_ market_, @buytype_ buytype_, @platform_ platform_, @ukey_ ukey_, @version_ version_, @phone_ phone_, @pushid_ pushid_, @kakaotalkid_ kakaotalkid_, @kakaouserid_ kakaouserid_, @kakaomsgblocked_ kakaomsgblocked_, @kakaofriendlist_ kakaofriendlist_

	if(exists(select top 1 * from dbo.tFVUserBlockPhone where phone = @phone_))
		begin
			-- 블럭유저인가?
			set @nResult_ 	= @RESULT_ERROR_BLOCK_USER
			set @comment 	= '블럭처리된 아이디입니다.'
			select @nResult_ rtn, @comment comment, @gameid_ gameid, @password_ password
			return
		end



	------------------------------------------------
	--	3-2. 게스트ID생성
	------------------------------------------------
	if(@gameid_ in ('farm', 'iuest'))
		begin
			--select 'DEBUG guest create'
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
	--		delete from dbo.tFVKakaoMaster where kakaouserid = @kakaouserid_
    --
	--		-- 88452235362617025 > iuest583397699, farm161006288
	--		-- insert into dbo.tFVKakaoMaster(kakaotalkid,   kakaouserid,                 gameid,   kakaodata, writedate)
	--		-- values(						'A1QZxsYZVAM', '88452235362617025', 'farm161006288', 1, '2014-05-12 12:14')
	--		-- 카톡 마스터 계정 입력
	--		if(exists(select top 1 * from dbo.tFVKakaoMaster where gameid = @gameid_))
	--			begin
	--				--select 'DEBUG 수정', @gameid_ gameid_, @kakaotalkid_ kakaotalkid_, @kakaouserid_ kakaouserid_, @kakaodata kakaodata
	--				update dbo.tFVKakaoMaster
	--					set
	--						kakaotalkid	= @kakaotalkid_,
	--						kakaouserid = @kakaouserid_,
	--						kakaodata	= @kakaodata
	--				where gameid = @gameid_
	--			end
	--		else
	--			begin
	--				--select 'DEBUG 입력', @gameid_ gameid_, @kakaotalkid_ kakaotalkid_, @kakaouserid_ kakaouserid_, @kakaodata kakaodata
	--				insert into dbo.tFVKakaoMaster(kakaotalkid,   kakaouserid,   gameid,   kakaodata)
	--				values(						@kakaotalkid_, @kakaouserid_, @gameid_, @kakaodata)
	--			end
    --
	--		-- 유저 정보 갱신.
	--		update dbo.tUserMaster
	--			set
	--				kakaotalkid		= @kakaotalkid_,
	--				kakaouserid		= @kakaouserid_,
	--				kakaomsgblocked	= @kakaomsgblocked_
	--		where gameid = @gameid_
	--	end
	else if(@kakaouserid_ != '' and @gameid_ != '')
		begin
			select @kakaouserid2 = kakaouserid from dbo.tFVKakaoMaster where gameid = @gameid_
			--select 'DEBUG 직접생성', @kakaouserid_ kakaouserid_, @gameid_ gameid_, @kakaouserid2 kakaouserid2
			if(@kakaouserid_ != @kakaouserid2)
			 	begin
			 		-- 임의의 생성된 카톡아이디는 삭제.
			 		delete from dbo.tFVKakaoMaster where kakaouserid = @kakaouserid2
			 		--select 'DEBUG kakao master 삭제하고 재생성'

					-- 카톡 마스터 계정 입력
					if(exists(select top 1 * from dbo.tFVKakaoMaster where kakaouserid = @kakaouserid_))
						begin
							--select 'DEBUG update(tFVKakaoMaster)', @gameid_ gameid_, @kakaotalkid_ kakaotalkid_, @kakaouserid_ kakaouserid_, @kakaodata kakaodata
							update dbo.tFVKakaoMaster
								set
									kakaotalkid		= @kakaotalkid_,
									kakaodata		= @kakaodata,
									gameid 			= @gameid_
							where kakaouserid = @kakaouserid_
						end
					else
						begin
							--select 'DEBUG insert(tFVKakaoMaster)', @gameid_ gameid_, @kakaotalkid_ kakaotalkid_, @kakaouserid_ kakaouserid_, @kakaodata kakaodata
							insert into dbo.tFVKakaoMaster(kakaotalkid,   kakaouserid,   gameid,   kakaodata)
							values(						  @kakaotalkid_, @kakaouserid_, @gameid_, @kakaodata)
						end

					-- 유저 정보 갱신.
					update dbo.tUserMaster
						set
							kakaotalkid		= @kakaotalkid_,
							kakaouserid		= @kakaouserid_,
							kakaomsgblocked	= @kakaomsgblocked_
					where gameid = @gameid_
				end
		end

	--select 'DEBUG 3-2-3', @gameid_ gameid_, @password_ password_, @market_ market_, @buytype_ buytype_, @platform_ platform_, @ukey_ ukey_, @version_ version_, @phone_ phone_, @pushid_ pushid_
	if(@strkind in ('iuest'))
		begin
			set @kakaodata			= @KAKAO_DATA_NO
		end

	------------------------------------------------
	-- 핸드폰으로 생성된 아이디기 갯수 파악
	------------------------------------------------
	select
		@joincnt = joincnt
	from tFVUserPhone where phone = @phone_
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
	from dbo.tFVKakaoMaster
	where kakaouserid = @kakaouserid_
	order by idx desc
	--select 'DEBUG 3-2-5', @kakaouserid_ kakaouserid_, @kakaotalkid kakaotalkid, @kakaouserid kakaouserid, @gameid gameid

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
					update dbo.tFVKakaoMaster
						set
							kakaotalkid 	= @kakaotalkid_,
							cnt2			= cnt2 + 1
					where idx = @idx
				end

			-- 닉네임과 프로파일을 갱신하다.
			update dbo.tUserMaster
				set
					--market		= @market_,				-- 로그인할때 변경한다.
					pushid			= @pushid_
			where gameid = @gameid

			select @nResult_ rtn, @comment comment, gameid, password
			from dbo.tUserMaster
			where gameid = @gameid

			return
		end
	--else if exists (select * from tUserMaster where gameid = @gameid_)
	--	begin
	--		set @nResult_ = @RESULT_ERROR_ID_DUPLICATE
	--		set @comment = '(생성)아이디가 중복되었습니다.'
	--		--select 'DEBUG 4', @comment
	--	end
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

			---------------------------------------------
			-- kakao 입력하기
			---------------------------------------------
			if(@kakaouserid = '')
				begin
					insert into dbo.tFVKakaoMaster(kakaotalkid,   kakaouserid,   gameid,   kakaodata)
					values(					 	  @kakaotalkid_, @kakaouserid_, @gameid_, @kakaodata)
				end
			else
				begin
					update dbo.tFVKakaoMaster
						set
							gameid 	= @gameid_,
							cnt 	= cnt + 1
					where kakaouserid = @kakaouserid_
				end

			---------------------------------------------
			-- 유저 정보 입력하기,
			-- 대표동물(0)
			-- 하트맥스 : 10
			---------------------------------------------
			--select 'DEBUG 6-3 유저 정보 입력'
			insert into dbo.tUserMaster(gameid,  password,   market,   buytype,   platform,   ukey,   version,   phone,   pushid,
										 kakaotalkid,   kakaouserid,   kakaomsgblocked,   nickname
										)
			values(                     @gameid_, @password_, @market_, @buytype_, @platform_, @ukey_, @version_, @phone_, @pushid_,
										@kakaotalkid_, @kakaouserid_, @kakaomsgblocked_, @gameid_
										)

			---------------------------------------------
			-- 가입선물.
			-- 하트(3300) 	50
			-- 무지방(3003)	200
			-- 바나나(3004)	200
			-- 건초(3400)	250
			---------------------------------------------
			exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT, 3300, 50, '신규가입', @gameid_, ''
			exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT, 3003, 100, '신규가입', @gameid_, ''
			exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT, 3004, 100, '신규가입', @gameid_, ''
			exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT, 3400, 150, '신규가입', @gameid_, ''


			------------------------------------
			-- 가입 통계를 작성한다.(일반, 게스트)
			------------------------------------
			--select 'DEBUG > 6-7 가입 통계를 작성한다.'
			if(@joinmode = @JOIN_MODE_PLAYER)
				begin
					--select 'DEBUG > 6-7-2 아이디입력방식 생성'
					exec spu_FVDayLogInfoStatic @market_, 10, 1
				end
			else
				begin
					--select 'DEBUG > 6-7-2 게스트 생성'
					exec spu_FVDayLogInfoStatic @market_, 13, 1
				end

			----------------------------------------------
			---- 핸드폰별 가입 카운터
			----------------------------------------------
			if(@joincnt = 0)
				begin
					--select 'DEBUG > 6-8 핸드폰별 가입 카운터'
					exec spu_FVDayLogInfoStatic @market_, 11, 1

					insert into dbo.tFVUserPhone(phone,   market)
					values(                     @phone_, @market_)
				end
			else
				begin
					update dbo.tFVUserPhone
						set
							joincnt = joincnt + 1
					where phone = @phone_
				end

			----------------------------------------------
			-- kakao 친구 정보 검색해서 입력하기.
			----------------------------------------------
			exec sup_FVsubAddKakaoFriend @gameid_, @kakaofriendlist_

		end

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	select @nResult_ rtn, @comment comment, @gameid_ gameid, @password_ password
	--, CONVERT(CHAR(19), @deldate, 20) deldate > 파일을 받는 곳에서 계속 오류가 난다. ㅠㅠ

	--최종 결과를 리턴한다.
	set nocount off
End



