/*
delete from dbo.tCashLog where gameid = 'xxxx2'
update dbo.tUserMaster set cashcost = 0, cashpoint = 0      where gameid = 'xxxx2'
update dbo.tUserMaster set cashcost = 0, cashpoint = 140000 where gameid = 'xxxx2'


exec spu_CashBuyAdmin 1, 'xxxx2',      '', '049000s1i0n7t8445289', 'xxxxd6', '63234567090110987675defgxabc534531423576576945d2', 5, 1, 5000,   310,   3300,   310,   3300, '', '', '', '', -1	-- 구매
exec spu_CashBuyAdmin 1, 'xxxx2',      '', '049000s1i0n7t8445289', 'xxxxd7', '63234567090110987675defgxabc534531423576576945d3', 5, 1, 5001,   550,   5500,   550,   5500, '', '', '', '', -1	--
exec spu_CashBuyAdmin 1, 'xxxx2',      '', '049000s1i0n7t8445289', 'xxxxd8', '63234567090110987675defgxabc534531423576576945d4', 5, 1, 5002,  1120,  11000,  1120,  11000, '', '', '', '', -1	--
exec spu_CashBuyAdmin 1, 'xxxx2',      '', '049000s1i0n7t8445289', 'xxxxd9', '63234567090110987675defgxabc534531423576576945d5', 5, 1, 5003,  3450,  33000,  3450,  33000, '', '', '', '', -1	--
exec spu_CashBuyAdmin 1, 'xxxx2',      '', '049000s1i0n7t8445289', 'xxxxd0', '63234567090110987675defgxabc534531423576576945d6', 5, 1, 5004,  5900,  55000,  5900,  55000, '', '', '', '', -1	--
exec spu_CashBuyAdmin 1, 'xxxx2',      '', '049000s1i0n7t8445289', 'xxxxd1', '63234567090110987675defgxabc534531423576576945d7', 5, 1, 5005, 12500, 110000, 12500, 110000, '', '', '', '', -1	--

exec spu_CashBuyAdmin 1, 'xxxx2',      '', '049000s1i0n7t8445289', 'xxxxf1', '63234567090110987675defgxabc534531423576576945f2', 5, 1, 5050,   310,   3300,   310,   3300, '', '', '', '', -1	-- 생애
exec spu_CashBuyAdmin 1, 'xxxx2',      '', '049000s1i0n7t8445289', 'xxxxz7', '63234567090110987675defgxabc534531423576576945z3', 5, 1, 5051,   550,   5500,   550,   5500, '', '', '', '', -1	--
*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_CashBuyAdmin', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_CashBuyAdmin;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_CashBuyAdmin
	@mode_									int,
	@gameid_								varchar(20),					-- 게임아이디
	@giftid_								varchar(20),					-- 선물받을 유저
	@password_								varchar(20),
	@acode_									varchar(256),					-- indexing
	@ucode_									varchar(256),
		@summary_								int,
	@itemcode_								int,
	@cashcost_								int,
	@cash_									int,
		@cashcost2_								int,
		@cash2_									int,
	@ikind_									varchar(256),
	@idata_									varchar(4096),
	@idata2_								varchar(4096),
	@nResult_								int					OUTPUT
	WITH ENCRYPTION -- 프로시져를 암호화함.
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

	-- 루비구매.
	declare @RESULT_ERROR_CASH_COPY				int				set @RESULT_ERROR_CASH_COPY				= -40
	declare @RESULT_ERROR_CASH_OVER				int				set @RESULT_ERROR_CASH_OVER				= -41
	declare @RESULT_ERROR_MONTH_OVER			int				set @RESULT_ERROR_MONTH_OVER			= -42			--한달동안 구매한도를 검사

	-- 기타오류
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- 지원하지않는모드
	declare @RESULT_ERROR_NOT_FOUND_GIFTID		int				set @RESULT_ERROR_NOT_FOUND_GIFTID		= -75			-- 루비 > 선물할 아이디를 못찾음

	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------
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
	declare @BUY_MAX_CASHCOST					int				set	@BUY_MAX_CASHCOST					= 110000

	-- 캐수모드
	declare @CASH_MODE_BUYMODE					int				set @CASH_MODE_BUYMODE					= 1
	declare @CASH_MODE_GIFTMODE					int				set @CASH_MODE_GIFTMODE					= 2

	----------------------------------------------
	-- 	이벤트 처리
	--	기간 : 2016-05-31 ~ 2029-08-06
	--			33000	55000	110000
	--	캐쉬	20%		20%		20%			<- 시스템이 관리함.
	--	프리	각2장	각4장	각9장		<- 선물함, 중복지급 	교배프리미엄(2300)	보물프리미엄(2600)
	--	코인	20000	50000	100000		<- 선물함, 중복지급		교배프리미엄(5100)
	--	박스					슈퍼매직	<- 선물함, 중복지급		슈퍼마법(3705)
	--	펫				펫		펫			<- 시스템이 관리함.
	------------------------------------------------
	declare @EVENT01_START_DAY					datetime		set @EVENT01_START_DAY			= '2016-05-31 12:00'
	declare @EVENT01_END_DAY					datetime		set @EVENT01_END_DAY			= '2029-08-06 23:59'

	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @comment2			varchar(80)
	declare @gameid				varchar(20)		set @gameid			= ''
	declare @blockstate			int
	declare @giftid				varchar(20)
	declare @buycashcost		int				set @buycashcost	= 0
	declare @buycashcostorg		int				set @buycashcostorg	= 0
	declare @buycash			int				set @buycash		= 0
	declare @pluscashcost		int				set @pluscashcost	= 0


	declare @dateid 			varchar(8)		set @dateid 		= Convert(varchar(8), Getdate(), 112)		-- 20120819
	declare @curdate			datetime		set @curdate		= getdate()
	declare @eventplus			int				set @eventplus		= 0
	declare @productid			varchar(40)		set @productid		= ''

	declare @kakaouk			varchar(19)		set @kakaouk		= substring(Convert(varchar(10),Getdate(),112), 3, 8) + Replace(Convert(varchar(12),Getdate(),114),':','') + Convert(varchar(4), Convert(int, ceiling(RAND() * 9980))+10)

	declare @level				int				set @level			= 1

	-- VIP효과.
	declare @cashpoint			int				set @cashpoint		= 0
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	--select 'DEBUG 입력값', @mode_ mode_, @gameid_ gameid_, @giftid_ giftid_, @password_ password_, @acode_ acode_, @ucode_ ucode_, @summary_ summary_, @itemcode_ itemcode_, @cashcost_ cashcost_, @cash_ cash_, @cashcost2_ cashcost2_, @cash2_ cash2_, @ikind_ ikind_, @idata_ idata_, @idata2_ idata2_

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	select
		@gameid 	= gameid,		@cashpoint	= cashpoint,
		@level		= level,
		@blockstate	= blockstate
	from dbo.tUserMaster where gameid = @gameid_ and password = @password_

	-- 친구 ID검색
	if(@mode_ = @CASH_MODE_GIFTMODE)
		begin
			select
				@giftid = gameid
			from dbo.tUserMaster where gameid = @giftid_
		end

	---------------------------------------------------
	-- 아이템 코드 > 루비코드, 충전금액확인.
	-- 안드로이드, 아이폰 > 코드 > 캐쉬(동일)
	---------------------------------------------------
	select
		@buycash		= cashcost,		-- 현금
		@buycashcost 	= buyamount,	-- 캐쉬
		@buycashcostorg = buyamount,
		@eventplus		= param3,
		@productid		= param4
	from dbo.tItemInfo
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
			--update dbo.tUserMaster set cashcopy = cashcopy + 1 where gameid = @gameid_

			--insert into dbo.tUserUnusualLog(gameid, comment) values(@gameid_, '**** 캐쉬카피를 시도했습니다(캐쉬가불일치) ****')
		end
	else if(@summary_ != 1)
		begin
			set @nResult_ = @RESULT_ERROR_CASH_COPY
			select @nResult_ rtn, 'ERROR 캐쉬카피(블럭처리됩니다.유효하지않는값(-2))'

			---------------------------------------------------
			--	캐쉬카피 플래그 기록
			---------------------------------------------------
			--update dbo.tUserMaster set cashcopy = cashcopy + 1 where gameid = @gameid_

			--insert into dbo.tUserUnusualLog(gameid, comment) values(@gameid_, '**** 캐쉬카피를 시도했습니다(유효하지않는 ucode값) ****')
		end
	else if(@cashcost_ > @BUY_MAX_CASHCOST)
		begin
			set @nResult_ = @RESULT_ERROR_CASH_COPY
			select @nResult_ rtn, 'ERROR 캐쉬카피(블럭처리됩니다.유효하지않는 캐쉬(-3))'

			---------------------------------------------------
			--	캐쉬카피 플래그 기록
			---------------------------------------------------
			--update dbo.tUserMaster set cashcopy = cashcopy + 1 where gameid = @gameid_

			--insert into dbo.tUserUnusualLog(gameid, comment) values(@gameid_, '**** 캐쉬카피를 시도했습니다(유효하지않는 캐쉬) ****')
		end
	else if(exists(select top 1 * from dbo.tCashLog where ucode = @ucode_))
		begin
			set @nResult_ = @RESULT_ERROR_CASH_COPY
			select @nResult_ rtn, 'ERROR 캐쉬카피(블럭처리됩니다.중복요청(-4))'

			---------------------------------------------------
			--	캐쉬카피 플래그 기록
			---------------------------------------------------
			--update dbo.tUserMaster set cashcopy = cashcopy + 10 where gameid = @gameid_

			--insert into dbo.tUserUnusualLog(gameid, comment) values(@gameid_, '**** 캐쉬카피를 시도했습니다(중복요청을 했다.) ****')
		end
	else if(@acode_ != '' and exists(select top 1 * from dbo.tCashLog where acode = @acode_))
		begin
			set @nResult_ = @RESULT_ERROR_CASH_COPY
			select @nResult_ rtn, 'ERROR 캐쉬카피(블럭처리됩니다.중복요청(-5))'

			---------------------------------------------------
			--	캐쉬카피 플래그 기록
			---------------------------------------------------
			--update dbo.tUserMaster set cashcopy = cashcopy + 10 where gameid = @gameid_

			--insert into dbo.tUserUnusualLog(gameid, comment) values(@gameid_, '**** 캐쉬카피를 시도했습니다(중복요청을 했다.) ****')
		end
	else
		begin
			set @nResult_ = @RESULT_SUCCESS
			select @nResult_ rtn, 'SUCCESS 구매를 정상처리하다.'

			-------------------------------------------------
			-- 추가 골드세팅되어 있다면
			-------------------------------------------------
			select top 1 @pluscashcost = pluscashcost
			from dbo.tSystemInfo
			order by idx desc

			----------------------------------------------
			-- EVENT > 선물하기.
			----------------------------------------------
			if( @itemcode_ in ( 5003, 5004, 5005, 5053, 5054, 5055 ) and @curdate >= @EVENT01_START_DAY and @curdate < @EVENT01_END_DAY)
				begin
					if( @itemcode_ in ( 5003, 5053) )
						begin
							exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT, 2300,     2, '상인돌파 이벤트', @gameid_, ''
							exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT, 2600,     2, '상인돌파 이벤트', @gameid_, ''
							exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT, 5100, 20000, '상인돌파 이벤트', @gameid_, ''
						end
					else if( @itemcode_ in ( 5004, 5054 ) )
						begin
							exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT, 2300,     4, '상인돌파 이벤트', @gameid_, ''
							exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT, 2600,     4, '상인돌파 이벤트', @gameid_, ''
							exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT, 5100, 50000, '상인돌파 이벤트', @gameid_, ''
						end
					else if( @itemcode_ in ( 5005, 5055 ) )
						begin
							exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT, 2300,     9, '상인돌파 이벤트', @gameid_, ''
							exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT, 2600,     9, '상인돌파 이벤트', @gameid_, ''
							exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT, 5100,100000, '상인돌파 이벤트', @gameid_, ''
							exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT, 3705,     1, '상인돌파 이벤트', @gameid_, ''
						end
				end


			if(@mode_ = @CASH_MODE_BUYMODE)
				begin
					---------------------------------------------------
					-- 직접구매 > 캐쉬Pluse
					---------------------------------------------------
					update dbo.tUserMaster
						set
							cashpoint 	= cashpoint + @buycash
					where gameid = @gameid_

					---------------------------------------------------
					-- 직접구매 > 구매기록하기
					---------------------------------------------------
					insert into dbo.tCashLog(gameid,   acode,   ucode,      cashcost,     cash,  ikind,   idata,   idata2,   level,  productid)
					values(                 @gameid_, @acode_, @ucode_, @buycashcost, @buycash, @ikind_, @idata_, @idata2_, @level, @productid)



					---------------------------------------------------
					-- 생애첫결제로고.
					---------------------------------------------------
					--	begin
					--		--select 'DEBUG 생애결제로고'
					--		insert into dbo.tCashFirstTimeLog(gameid,   itemcode)
					--		values(                          @gameid_, @itemcode_)
					--		set @comment2 = ltrim(rtrim(str(@buycashcost))) +  '루비을 지급하였습니다.(생애첫결제)'
					--		exec spu_DayLogInfoStatic 82, 1				-- 일 캐쉬구매(생애)
					--	end
					--else
						begin
							set @comment2 = ltrim(rtrim(str(@buycashcost))) +  '다이라를 지급하였습니다.'

							exec spu_DayLogInfoStatic 81, 1				-- 일 캐쉬구매(일반)
						end

					-----------------------------------------------------
					---- 직접구매 > 구매자 쪽지 남겨주기(삭제된 형태로 남김)
					-----------------------------------------------------
					exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT, @itemcode_, @buycashcost, @SYSTEM_SENDID, @gameid_, @comment2


				end
			else if(@mode_ = @CASH_MODE_GIFTMODE)
				begin
					---------------------------------------------------
					-- 직접구매 > 포인터누적
					---------------------------------------------------
					update dbo.tUserMaster
						set
							cashpoint 	= cashpoint + @buycash
					where gameid = @gameid_

					---------------------------------------------------
					-- 구매자 > 상대방에게 선물로 넣어주기
					---------------------------------------------------
					exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT, @itemcode_, 0, @gameid_, @giftid_, ''				-- 캐쉬 선물하기.

					---------------------------------------------------
					-- 구매자 > 구매기록하기
					---------------------------------------------------
					insert into dbo.tCashLog(gameid,   acode,   ucode,      cashcost,     cash,  giftid,   ikind,   idata,   idata2,   level,  productid)
					values(                 @gameid_, @acode_, @ucode_, @buycashcost, @buycash, @giftid_, @ikind_, @idata_, @idata2_, @level, @productid)

					---------------------------------------------------
					-- 구매자와 선물자에게 쪽지 남겨주기
					---------------------------------------------------
					set @comment2 = ltrim(rtrim(@giftid_)) + '님에게 ' + ltrim(rtrim(str(@buycashcost))) +  '루비을 선물하였습니다.'
					exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_MESSAGE, -1, 0, @gameid_, @gameid_, @comment2

					--set @comment2 = ltrim(rtrim(@gameid_)) + '으로부터 ' + ltrim(rtrim(str(@buycashcost))) +  '루비을 선물 받았습니다.'
					--exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_MESSAGE, -1, 0, @gameid_, @giftid_, @comment2
				end

			---------------------------------------------------
			-- 토탈로그 기록하기
			---------------------------------------------------
			if(exists(select top 1 * from dbo.tCashTotal where dateid = @dateid and cashkind = @buycash))
				begin
					update dbo.tCashTotal
						set
							cashcost 	= cashcost 	+ @buycashcost,
							cash 		= cash 		+ @buycash,
							cnt 		= cnt 		+ 1
					where dateid = @dateid and cashkind = @buycash
				end
			else
				begin
					insert into dbo.tCashTotal(dateid, cashkind,     cashcost,     cash)
					values(                   @dateid, @buycash, @buycashcost, @buycash)
				end

			--유저 루비과 실버볼 갱신해주기
			--select * from dbo.tUserMaster where gameid = @gameid_
		end



	------------------------------------------------
	--	4-2. 유저정보
	------------------------------------------------
	set nocount off
End

