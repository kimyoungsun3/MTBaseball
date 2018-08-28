/*
-- 구매[O], 선물[O]
delete from tCashTotal
delete from tCashChangeLogTotal
delete from tCashLog where gameid = 'xxxx2'
delete from tCashChangeLog where gameid = 'xxxx2'
delete from tGiftList where gameid in ('xxxx2', 'xxxx3') and idx >= 4472
update dbo.tFVUserMaster set cashcost = 0, gamecost = 0, heart = 0, feed = 0, randserial = -1, market = 6 where gameid = 'xxxx2'
update dbo.tFVUserMaster set cashcost = 0, gamecost = 0, heart = 0, feed = 0, randserial = -1, market = 6 where gameid = 'xxxx3'

exec spu_FVCashBuy 1, 'xxxx2',      '', '049000s1i0n7t8445289', 'xxxxx6', '63234567090110987675defgxabc534531423576576945e2', 5, 1, 5000, 12,    1100, 12,    1100, '', '', '', '', -1	-- 구매
exec spu_FVCashBuy 1, 'xxxx2',      '', '049000s1i0n7t8445289', 'xxxxx7', '63234567090110987675defgxabc534531423576576945e3', 5, 1, 5001, 63,    5500, 63,    5500, '', '', '', '', -1	--
exec spu_FVCashBuy 1, 'xxxx2',      '', '049000s1i0n7t8445289', 'xxxxx8', '63234567090110987675defgxabc534531423576576945e4', 5, 1, 5002, 121,   9900, 121,   9900, '', '', '', '', -1	--
exec spu_FVCashBuy 1, 'xxxx2',      '', '049000s1i0n7t8445289', 'xxxxx9', '63234567090110987675defgxabc534531423576576945e5', 5, 1, 5003, 426,  33000, 426,  33000, '', '', '', '', -1	--
exec spu_FVCashBuy 1, 'xxxx2',      '', '049000s1i0n7t8445289', 'xxxxx0', '63234567090110987675defgxabc534531423576576945e6', 5, 1, 5004, 744,  55000, 744,  55000, '', '', '', '', -1	--
exec spu_FVCashBuy 1, 'xxxx2',      '', '049000s1i0n7t8445289', 'xxxxx1', '63234567090110987675defgxabc534531423576576945e7', 5, 1, 5005, 1680, 99000, 1680, 99000, '', '', '', '', -1	--

exec spu_FVCashBuy 2, 'xxxx2', 'xxxx3', '049000s1i0n7t8445289', 'xxxxx6', '63234567090110987675defgxabc534531423576576945d2', 5, 1, 5000, 20,    1100, 20,    1100, '', '', '', '', -1	-- 선물
exec spu_FVCashBuy 2, 'xxxx2', 'xxxx3', '049000s1i0n7t8445289', 'xxxxx6', '63234567090110987675defgxabc534531423576576945d3', 5, 1, 5001, 63,    5500, 63,    5500, '', '', '', '', -1	--
exec spu_FVCashBuy 2, 'xxxx2', 'xxxx3', '049000s1i0n7t8445289', 'xxxxx6', '63234567090110987675defgxabc534531423576576945d4', 5, 1, 5002, 121,   9900, 121,   9900, '', '', '', '', -1	--
exec spu_FVCashBuy 2, 'xxxx2', 'xxxx3', '049000s1i0n7t8445289', 'xxxxx6', '63234567090110987675defgxabc534531423576576945d5', 5, 1, 5003, 426,  33000, 426,  33000, '', '', '', '', -1	--
exec spu_FVCashBuy 2, 'xxxx2', 'xxxx3', '049000s1i0n7t8445289', 'xxxxx6', '63234567090110987675defgxabc534531423576576945d6', 5, 1, 5004, 744,  55000, 744,  55000, '', '', '', '', -1	--
exec spu_FVCashBuy 2, 'xxxx2', 'xxxx3', '049000s1i0n7t8445289', 'xxxxx6', '63234567090110987675defgxabc534531423576576945d7', 5, 1, 5005, 1680, 99000, 1680, 99000, '', '', '', '', -1	--
*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVCashBuy', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVCashBuy;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_FVCashBuy
	@mode_									int,
	@gameid_								varchar(60),					-- 게임아이디
	@giftid_								varchar(20),					-- 선물받을 유저
	@password_								varchar(20),
	@acode_									varchar(256),					-- indexing
	@ucode_									varchar(256),
	@market_								int,
		@summary_								int,
	@itemcode_								int,
	@cashcost_								int,
	@cash_									int,
		@cashcost2_								int,
		@cash2_									int,
	@ikind_									varchar(256),
	@idata_									varchar(4096),
	@idata2_								varchar(4096),
	@kakaouserid_							varchar(20),
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
	declare @RESULT_ERROR_EMAIL_DUPLICATE		int				set @RESULT_ERROR_EMAIL_DUPLICATE		= -3

	-- 로그인 오류.
	declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--블럭유저 > 팝업처리후 인트로로 빼버린다.
	declare @RESULT_ERROR_DELETED_USER 			int				set @RESULT_ERROR_DELETED_USER			= -12			--삭제유저 > 팝업처리후 인트로로 빼버린다.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함
	declare @RESULT_ERROR_NOT_FOUND_PASSWORD	int				set @RESULT_ERROR_NOT_FOUND_PASSWORD	= -17
	declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--서버를 점검하고 있다.
	declare @RESULT_NEWVERION_CLIENT_DOWNLOAD 	int				set @RESULT_NEWVERION_CLIENT_DOWNLOAD	= -15			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 링크처리.
	declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 종료.

	-- 수정구매.
	declare @RESULT_ERROR_CASH_COPY				int				set @RESULT_ERROR_CASH_COPY				= -40
	declare @RESULT_ERROR_CASH_OVER				int				set @RESULT_ERROR_CASH_OVER				= -41
	declare @RESULT_ERROR_MONTH_OVER			int				set @RESULT_ERROR_MONTH_OVER			= -42			--한달동안 구매한도를 검사

	-- 기타오류
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- 지원하지않는모드
	declare @RESULT_ERROR_NOT_FOUND_GIFTID		int				set @RESULT_ERROR_NOT_FOUND_GIFTID		= -75			-- 수정 > 선물할 아이디를 못찾음

	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------
	-- 구매처코드
	--declare @MARKET_SKT						int				set @MARKET_SKT							= 1
	--declare @MARKET_KT						int				set @MARKET_KT							= 2
	--declare @MARKET_LGT						int				set @MARKET_LGT							= 3
	declare @MARKET_GOOGLE						int				set @MARKET_GOOGLE						= 5
	declare @MARKET_NHN							int				set @MARKET_NHN							= 6
	--declare @MARKET_IPHONE					int				set @MARKET_IPHONE						= 7

	-- 상태값.
	declare @BLOCK_STATE_NO						int				set	@BLOCK_STATE_NO						= 0				-- 블럭상태아님
	declare @BLOCK_STATE_YES					int				set	@BLOCK_STATE_YES					= 1				-- 블럭상태

	-- 선물 정의값
	declare @GIFTLIST_GIFT_KIND_MESSAGE			int					set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2
	declare @GIFTLIST_GIFT_KIND_MESSAGE_DEL		int					set @GIFTLIST_GIFT_KIND_MESSAGE_DEL			= -1
	declare @GIFTLIST_GIFT_KIND_GIFT_DEL		int					set @GIFTLIST_GIFT_KIND_GIFT_DEL			= -2
	declare @GIFTLIST_GIFT_KIND_GIFT_GET		int					set @GIFTLIST_GIFT_KIND_GIFT_GET			= -3
	declare @GIFTLIST_GIFT_KIND_GIFT_SELL		int					set @GIFTLIST_GIFT_KIND_GIFT_SELL			= -4

	-- 기타 정의값
	declare @SYSTEM_SENDID						varchar(40)		set @SYSTEM_SENDID						= 'SysCash'
	declare @ITEM_PERIOD_PERMANENT				int 			set @ITEM_PERIOD_PERMANENT				= -1			-- 테이블에 -1이라 기록됨


	-- 기타 상수
	declare @ITEM_MAINCATEGORY_CASHCOST			int				set @ITEM_MAINCATEGORY_CASHCOST 		= 50 	--캐쉬선물(50)
	declare @BUY_MAX_CASHCOST					int				set	@BUY_MAX_CASHCOST					= 1680;

	-- 캐수모드
	declare @CASH_MODE_BUYMODE					int				set @CASH_MODE_BUYMODE					= 1
	declare @CASH_MODE_GIFTMODE					int				set @CASH_MODE_GIFTMODE					= 2

	----------------------------------------------
	-- Naver 이벤트 처리
	--	기간 : 7.24 ~ 8.6
	--	발표 : 8.11
	--	1. 가입시 ...		=> 시크한 양1마리, 수정 60개
	--						   02_01가입(정식버젼).sql
	--	2. 결제 2배			=> 결제하면 2배 이벤트
	--						   21_01캐쉬(인증서).sql
	--						   21_02캐쉬(관리페이지).sql
	--	3. Naver캐쉬		=> 네이버 캐쉬
	--	4. 리뷰추첨			=> 당첨자 발표 후 1주일 이내 지급을 완료하면 됩니다.
	--						  프리미엄티켓(20명), 수정20개
	--	5. 초대추첨			=> 당첨자 발표 후 1주일 이내 지급을 완료하면 됩니다.
	--						  알바의 귀재패키지(20명), 부활석 10개(전원)
	------------------------------------------------
	--declare @EVENT07NHN_START_DAY				datetime			set @EVENT07NHN_START_DAY			= '2014-06-13 20:00'
	--declare @EVENT07NHN_END_DAY				datetime			set @EVENT07NHN_END_DAY				= '2014-08-06 23:59'

	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @comment2			varchar(80)
	declare @gameid				varchar(60)		set @gameid			= ''
	declare @blockstate			int
	declare @market				int				set @market			= @MARKET_GOOGLE
	declare @giftid				varchar(60)
	declare @buycashcost		int				set @buycashcost	= 0
	declare @buycash			int				set @buycash		= 0
	declare @pluscashcost		int				set @pluscashcost	= 0


	declare @dateid 			varchar(8)		set @dateid 		= Convert(varchar(8), Getdate(), 112)		-- 20120819
	declare @eventplus			int				set @eventplus		= 0

	declare @kakaouk			varchar(19)		set @kakaouk		= substring(Convert(varchar(10),Getdate(),112), 3, 8) + Replace(Convert(varchar(12),Getdate(),114),':','') + Convert(varchar(4), Convert(int, ceiling(RAND() * 9980))+10)

	declare @gameyear			int				set @gameyear		= 2013
	declare @gamemonth			int				set @gamemonth		= 3
	declare @famelv				int				set @famelv			= 1

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	--select 'DEBUG 입력값', @mode_ mode_, @gameid_ gameid_, @giftid_ giftid_, @password_ password_, @acode_ acode_, @ucode_ ucode_, @market_ market_, @summary_ summary_, @itemcode_ itemcode_, @cashcost_ cashcost_, @cash_ cash_, @cashcost2_ cashcost2_, @cash2_ cash2_, @ikind_ ikind_, @idata_ idata_, @idata2_ idata2_

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	select
		@gameid 	= gameid,
		@gameyear	= gameyear,
		@gamemonth	= gamemonth,
		@famelv		= famelv,
		@market		= market,
		@blockstate	= blockstate
	from dbo.tFVUserMaster where gameid = @gameid_ and password = @password_

	-- 친구 ID검색
	if(@mode_ = @CASH_MODE_GIFTMODE)
		begin
			select
				@giftid = gameid
			from dbo.tFVUserMaster where gameid = @giftid_
		end

	---------------------------------------------------
	-- 아이템 코드 > 수정코드, 충전금액확인.
	-- 안드로이드, 아이폰 > 코드 > 캐쉬(동일)
	---------------------------------------------------
	select
		@buycash		= cashcost,		-- 현금
		@buycashcost 	= buyamount,	-- 캐쉬
		@eventplus		= param3
	from dbo.tFVItemInfo
	where itemcode = @itemcode_ and subcategory = @ITEM_MAINCATEGORY_CASHCOST

	------------------------------------------------
	--	3-2-3. 연산수행
	------------------------------------------------
	if(@blockstate = @BLOCK_STATE_YES)
		begin
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
			select @nResult_ rtn, 'ERROR 아이디를 찾지 못했습니다.'
		end
	else if(@mode_ not in (@CASH_MODE_BUYMODE, @CASH_MODE_GIFTMODE))
		begin
			set @nResult_ = @RESULT_ERROR_NOT_SUPPORT_MODE
			select @nResult_ rtn, 'ERROR 지원하지 않는 모드입니다.'
		end
	else if(@mode_ = @CASH_MODE_GIFTMODE and (isnull(@giftid, '') = ''))
		begin
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_GIFTID
			select @nResult_ rtn, 'ERROR 선물받을 친구가 없습니다.'
		end
	else if(@gameid = '')
		begin
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
			select @nResult_ rtn, 'ERROR 아이디를 찾지 못했습니다.'
		end
	else if(@cashcost_ != @cashcost2_ or @cash_ != @cash2_ or @buycashcost != @cashcost_)
		begin
			set @nResult_ = @RESULT_ERROR_CASH_COPY
			select @nResult_ rtn, 'ERROR 캐쉬카피(블럭처리됩니다. 캐쉬가불일치(-1))'

			---------------------------------------------------
			--	캐쉬카피 플래그 기록
			---------------------------------------------------
			update dbo.tFVUserMaster set cashcopy = cashcopy + 1 where gameid = @gameid_

			insert into dbo.tFVUserUnusualLog(gameid, comment) values(@gameid_, '**** 캐쉬카피를 시도했습니다(캐쉬가불일치) ****')
		end
	else if(@summary_ != 1)
		begin
			set @nResult_ = @RESULT_ERROR_CASH_COPY
			select @nResult_ rtn, 'ERROR 캐쉬카피(블럭처리됩니다.유효하지않는값(-2))'

			---------------------------------------------------
			--	캐쉬카피 플래그 기록
			---------------------------------------------------
			update dbo.tFVUserMaster set cashcopy = cashcopy + 1 where gameid = @gameid_

			insert into dbo.tFVUserUnusualLog(gameid, comment) values(@gameid_, '**** 캐쉬카피를 시도했습니다(유효하지않는 ucode값) ****')
		end
	else if(@cashcost_ > @BUY_MAX_CASHCOST)
		begin
			set @nResult_ = @RESULT_ERROR_CASH_COPY
			select @nResult_ rtn, 'ERROR 캐쉬카피(블럭처리됩니다.유효하지않는 캐쉬(-3))'

			---------------------------------------------------
			--	캐쉬카피 플래그 기록
			---------------------------------------------------
			update dbo.tFVUserMaster set cashcopy = cashcopy + 1 where gameid = @gameid_

			insert into dbo.tFVUserUnusualLog(gameid, comment) values(@gameid_, '**** 캐쉬카피를 시도했습니다(유효하지않는 캐쉬) ****')
		end
	else if(exists(select top 1 * from dbo.tFVCashLog where ucode = @ucode_))
		begin
			set @nResult_ = @RESULT_ERROR_CASH_COPY
			select @nResult_ rtn, 'ERROR 캐쉬카피(블럭처리됩니다.중복요청(-4))'

			---------------------------------------------------
			--	캐쉬카피 플래그 기록
			---------------------------------------------------
			update dbo.tFVUserMaster set cashcopy = cashcopy + 10 where gameid = @gameid_

			insert into dbo.tFVUserUnusualLog(gameid, comment) values(@gameid_, '**** 캐쉬카피를 시도했습니다(중복요청을 했다.) ****')
		end
	else if(@acode_ != '' and exists(select top 1 * from dbo.tFVCashLog where acode = @acode_))
		begin
			set @nResult_ = @RESULT_ERROR_CASH_COPY
			select @nResult_ rtn, 'ERROR 캐쉬카피(블럭처리됩니다.중복요청(-5))'

			---------------------------------------------------
			--	캐쉬카피 플래그 기록
			---------------------------------------------------
			update dbo.tFVUserMaster set cashcopy = cashcopy + 10 where gameid = @gameid_

			insert into dbo.tFVUserUnusualLog(gameid, comment) values(@gameid_, '**** 캐쉬카피를 시도했습니다(중복요청을 했다.) ****')
		end
	else
		begin
			set @nResult_ = @RESULT_SUCCESS
			select @nResult_ rtn, 'SUCCESS 구매를 정상처리하다.'

			-------------------------------------------------
			-- 추가 골드세팅되어 있다면
			-------------------------------------------------
			select top 1 @pluscashcost = pluscashcost
			from dbo.tFVSystemInfo
			order by idx desc

			------------------------------------------------
			---- EVENT 7.24 ~ 8.6
			------------------------------------------------
			--if(@market = @MARKET_NHN and getdate() < @EVENT07NHN_END_DAY)
			--	begin
			--		set @buycashcost = 2 * @buycashcost
			--	end
			--else if(@eventplus = 1 and @pluscashcost > 0 and @pluscashcost <= 100)
			--	begin
			--		set @buycashcost = @buycashcost + (@buycashcost * @pluscashcost / 100)
			--	end
			-- 금액 얼마 더주는 내용.
			if(@eventplus = 1 and @pluscashcost > 0 and @pluscashcost <= 100)
				begin
					set @buycashcost = @buycashcost + (@buycashcost * @pluscashcost / 100)
				end

			if(@mode_ = @CASH_MODE_BUYMODE)
				begin
					---------------------------------------------------
					-- 직접구매 > 캐쉬Pluse
					---------------------------------------------------
					update dbo.tFVUserMaster
						set
							cashcost 	= cashcost + @buycashcost,
							cashpoint 	= cashpoint + @buycash
					where gameid = @gameid_

					---------------------------------------------------
					-- 직접구매 > 구매기록하기
					---------------------------------------------------
					insert into dbo.tFVCashLog(gameid,   acode,   ucode,      cashcost,     cash,  market,   ikind,   idata,   idata2,   kakaouserid,   kakaouk,  gameyear,  gamemonth,  famelv)
					values(                 @gameid_, @acode_, @ucode_, @buycashcost, @buycash, @market_, @ikind_, @idata_, @idata2_, @kakaouserid_, @kakaouk, @gameyear, @gamemonth, @famelv)

					-----------------------------------------------------
					---- 직접구매 > 구매자 쪽지 남겨주기(삭제된 형태로 남김)
					-----------------------------------------------------
					set @comment2 = ltrim(rtrim(str(@buycashcost))) +  '수정을 구매하였습니다.'
					exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_MESSAGE_DEL, @itemcode_, @SYSTEM_SENDID, @gameid_, @comment2
				end
			else if(@mode_ = @CASH_MODE_GIFTMODE)
				begin
					---------------------------------------------------
					-- 직접구매 > 포인터누적
					---------------------------------------------------
					update dbo.tFVUserMaster
						set
							cashpoint 	= cashpoint + @buycash
					where gameid = @gameid_

					---------------------------------------------------
					-- 구매자 > 상대방에게 선물로 넣어주기
					---------------------------------------------------
					exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT, @itemcode_, @gameid_, @giftid_, ''				-- 캐쉬 선물하기.

					---------------------------------------------------
					-- 구매자 > 구매기록하기
					---------------------------------------------------
					insert into dbo.tFVCashLog(gameid,   acode,   ucode,      cashcost,     cash,  giftid,   market,   ikind,   idata,   idata2,   kakaouserid,   kakaouk,  gameyear,  gamemonth,  famelv)
					values(                 @gameid_, @acode_, @ucode_, @buycashcost, @buycash, @giftid_, @market_, @ikind_, @idata_, @idata2_, @kakaouserid_, @kakaouk, @gameyear, @gamemonth, @famelv)

					---------------------------------------------------
					-- 구매자와 선물자에게 쪽지 남겨주기
					---------------------------------------------------
					set @comment2 = ltrim(rtrim(@giftid_)) + '님에게 ' + ltrim(rtrim(str(@buycashcost))) +  '수정을 선물하였습니다.'
					exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_MESSAGE, -1, @gameid_, @gameid_, @comment2

					--set @comment2 = ltrim(rtrim(@gameid_)) + '으로부터 ' + ltrim(rtrim(str(@buycashcost))) +  '수정을 선물 받았습니다.'
					--exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_MESSAGE, -1, @gameid_, @giftid_, @comment2
				end

			---------------------------------------------------
			-- 토탈로그 기록하기
			---------------------------------------------------
			if(exists(select top 1 * from dbo.tFVCashTotal where dateid = @dateid and cashkind = @buycash and market = @market_))
				begin
					update dbo.tFVCashTotal
						set
							cashcost 	= cashcost 	+ @buycashcost,
							cash 		= cash 		+ @buycash,
							cnt 		= cnt 		+ 1
					where dateid = @dateid and cashkind = @buycash and market = @market_
				end
			else
				begin
					insert into dbo.tFVCashTotal(dateid, cashkind,  market,      cashcost,     cash)
					values(                   @dateid, @buycash, @market_, @buycashcost, @buycash)
				end

			--유저 수정과 실버볼 갱신해주기
			select * from dbo.tFVUserMaster where gameid = @gameid_
		end



	------------------------------------------------
	--	4-2. 유저정보
	------------------------------------------------
	set nocount off
End

