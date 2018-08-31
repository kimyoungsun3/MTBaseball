use Game4FarmVill3
GO

/*
-- 구매[O], 선물[O]
-- delete from tFVCashTotal
select top 10 * from dbo.tFVCashLog order by idx desc
delete from tFVCashLog where gameid in ('xxxx2', 'xxxx3')
delete from tFVGiftList where gameid in ('xxxx2', 'xxxx3')
update dbo.tFVUserMaster set vippoint = 0, cashpoint = 0, cashcost = 0 where gameid = 'xxxx2'
--					gameid           itemcode ikind      acode
exec spu_FVCashBuy3 'xxxx2', '049000s1i0n7t8445289', '',      '7000', 'googlekw', '12999763169054705758.1343569877495791', '', '', '7791', -1	-- GOOGLE(googlekw)
exec spu_FVCashBuy3 'xxxx2', '049000s1i0n7t8445289', '',      '7000', 'googlekw', '12999763169054705758.1343569877495792', '', '', '7792', -1	-- GOOGLE(googlekw)

exec spu_FVCashBuy3 'xxxx2', '049000s1i0n7t8445289', '',      '7001', 'REAL',      '1009010101',                           '', '', '7781', -1	-- NHN(REAL)
exec spu_FVCashBuy3 'xxxx2', '049000s1i0n7t8445289', '',      '7002', 'REAL',      '1009010102',                           '', '', '7782', -1	-- NHN(REAL)
exec spu_FVCashBuy3 'xxxx2', '049000s1i0n7t8445289', '',      '7003', 'REAL',      '1009010103',                           '', '', '7783', -1	-- NHN(REAL)
exec spu_FVCashBuy3 'xxxx2', '049000s1i0n7t8445289', '',      '7004', 'REAL',      '1009010104',                           '', '', '7784', -1	-- NHN(REAL)
exec spu_FVCashBuy3 'xxxx2', '049000s1i0n7t8445289', '',      '7005', 'real',      '60000134460912',                       '', '', '7785', -1	-- IPHONE(real)
exec spu_FVCashBuy3 'xxxx2', '049000s1i0n7t8445289', '',      '7006', 'skt',       'TX_00000030191561',                    '', '', '7786', -1	-- SKT(skt)
exec spu_FVCashBuy3 'xxxx2', '049000s1i0n7t8445289', '',      '7007', 'skt',       'TX_00000030191562',                    '', '', '7787', -1	-- SKT(skt)
exec spu_FVCashBuy3 'xxxx2', '049000s1i0n7t8445289', '',      '7008', 'skt',       'TX_00000030191563',                    '', '', '7788', -1	-- SKT(skt)
exec spu_FVCashBuy3 'xxxx2', '049000s1i0n7t8445289', '',      '7009', 'skt',       'TX_00000030191564',                    '', '', '7789', -1	-- SKT(skt)

exec spu_FVCashBuy3 'xxxx2', '049000s1i0n7t8445289', 'xxxx3', '7014', 'googlekw', '12999763169054705758.1343569877497010', '', '', '7771', -1	-- 친구있음
exec spu_FVCashBuy3 'xxxx2', '049000s1i0n7t8445289', 'xxxx3', '7018', 'googlekw', '12999763169054705758.1343569877497011', '', '', '7772', -1

exec spu_FVCashBuy3 'xxxx2', '049000s1i0n7t8445289', '',      '7005', 'real', '영수증번호', '암호문', '해석문', -1					-- IPHONE(real)
*/
IF OBJECT_ID ( 'dbo.spu_FVCashBuy3', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVCashBuy3;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_FVCashBuy3
	@gameid_								varchar(60),					-- 게임아이디
	@password_								varchar(20),
	@giftid_								varchar(60),					-- 친구아이디
	@itemcode_								int,
	@ikind_									varchar(256),
	@acode_									varchar(256),					-- indexing
	@idata_									varchar(4096),
	@idata2_								varchar(4096),
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
	declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--블럭유저 > 팝업처리후 인트로로 빼버린다.
	--declare @RESULT_ERROR_DELETED_USER 		int				set @RESULT_ERROR_DELETED_USER			= -12			--삭제유저 > 팝업처리후 인트로로 빼버린다.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함
	--declare @RESULT_ERROR_NOT_FOUND_PASSWORD	int				set @RESULT_ERROR_NOT_FOUND_PASSWORD	= -17
	--declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--서버를 점검하고 있다.
	--declare @RESULT_NEWVERION_CLIENT_DOWNLOAD int				set @RESULT_NEWVERION_CLIENT_DOWNLOAD	= -15			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 링크처리.
	--declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 종료.

	-- 수정구매.
	declare @RESULT_ERROR_CASH_COPY				int				set @RESULT_ERROR_CASH_COPY				= -40
	--declare @RESULT_ERROR_CASH_OVER			int				set @RESULT_ERROR_CASH_OVER				= -41

	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------
	-- 구매처코드
	--declare @MARKET_SKT						int				set @MARKET_SKT							= 1
	--declare @MARKET_KT						int				set @MARKET_KT							= 2
	--declare @MARKET_LGT						int				set @MARKET_LGT							= 3
	declare @MARKET_GOOGLE						int				set @MARKET_GOOGLE						= 5
	--declare @MARKET_NHN						int				set @MARKET_NHN							= 6
	--declare @MARKET_IPHONE					int				set @MARKET_IPHONE						= 7

	-- 상태값.
	declare @BLOCK_STATE_NO						int				set	@BLOCK_STATE_NO						= 0				-- 블럭상태아님
	declare @BLOCK_STATE_YES					int				set	@BLOCK_STATE_YES					= 1				-- 블럭상태

	-- 선물 정의값
	--declare @GIFTLIST_GIFT_KIND_MESSAGE		int					set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	--declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2
	--declare @GIFTLIST_GIFT_KIND_MESSAGE_DEL	int					set @GIFTLIST_GIFT_KIND_MESSAGE_DEL			= -1
	--declare @GIFTLIST_GIFT_KIND_GIFT_DEL		int					set @GIFTLIST_GIFT_KIND_GIFT_DEL			= -2
	--declare @GIFTLIST_GIFT_KIND_GIFT_GET		int					set @GIFTLIST_GIFT_KIND_GIFT_GET			= -3
	--declare @GIFTLIST_GIFT_KIND_GIFT_SELL		int					set @GIFTLIST_GIFT_KIND_GIFT_SELL			= -4

	----------------------------------------------
	-- 새학기 이벤트
	-- 기간 : 2015.02.13 ~ 03.14 > 한개 더지급하는 방식
	----------------------------------------------
	declare @EVENT01_START_DAY					datetime			set @EVENT01_START_DAY						= '2015-02-12'
	declare @EVENT01_END_DAY					datetime			set @EVENT01_END_DAY						= '2015-02-13 23:59'	-- 추가일주일
	declare @EVENT01_ITEMCODE					int					set @EVENT01_ITEMCODE						= 3200	-- VIP지급   20%
	declare @EVENT02_ITEMCODE					int					set @EVENT02_ITEMCODE						= 3015	-- 우유결정  20%
    --
	declare @EVENT11_START_DAY					datetime			set @EVENT11_START_DAY						= '2015-02-18'
	declare @EVENT11_END_DAY					datetime			set @EVENT11_END_DAY						= '2015-02-22 23:59'	-- + 30%추가.

	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @comment2			varchar(80)
	declare @comment3			varchar(60)
	declare @gameid				varchar(60)		set @gameid			= ''
	declare @blockstate			int				set @blockstate		= @BLOCK_STATE_NO
	declare @market				int				set @market			= @MARKET_GOOGLE
	declare @buycash			int				set @buycash		= 0
	declare @cashcost			int				set @cashcost		= 0
	declare @vippoint			int				set @vippoint		= 0
	declare @randserial			varchar(20)		set @randserial		= ''

	declare @dateid 			varchar(8)		set @dateid 		= Convert(varchar(8), Getdate(), 112)		-- 20120819
	declare @curdate			datetime		set @curdate		= getdate()
	declare @plusvippoint		int				set @plusvippoint	= 0
	declare @pluscashcost		int				set @pluscashcost	= 0

	declare @kakaouk			varchar(19)		set @kakaouk		= substring(Convert(varchar(10),Getdate(),112), 3, 8) + Replace(Convert(varchar(12),Getdate(),114),':','') + Convert(varchar(4), Convert(int, ceiling(RAND() * 9980))+10)
	declare @kakaouserid		varchar(20)		set @kakaouserid	= ''

	declare @eventpercent		int				set @eventpercent	= 0

	-- 캐쉬구매후 30일간 지급.
	declare @cashdatestart		smalldatetime	set @cashdatestart	= '20000101'
	declare @cashdateend		smalldatetime	set @cashdateend	= '20000101'
	declare @cashdatecur		smalldatetime	set @cashdatecur	= '20000101'
	declare @curdate2			smalldatetime	set @curdate2		= Convert(varchar(8), Getdate(), 112)
	declare @cashgift			int				set @cashgift		= -1

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	--select 'DEBUG 입력값', @gameid_ gameid_, @password_ password_, @giftid_ giftid_, @itemcode_ itemcode_, @ikind_ ikind_, @acode_ acode_, @randserial_ randserial_

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	select
		@gameid 		= gameid,			@blockstate = blockstate,		@market		= market,
		@cashdatestart	= cashdatestart, 	@cashdateend = cashdateend,		@cashdatecur = cashdatecur,
		@kakaouserid	= kakaouserid,
		@randserial		= randserial
	from dbo.tFVUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG ', @gameid gameid, @blockstate blockstate, @market market, @cashdatestart cashdatestart, @cashdateend cashdateend, @cashdatecur cashdatecur


	------------------------------------------------
	--	3-2-3. 연산수행
	------------------------------------------------
	if(@gameid = '')
		begin
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
			select @nResult_ rtn, 'ERROR 아이디를 찾지 못했습니다.'
		end
	else if(@acode_ = '' and @idata_ = '' and @idata2_ = '')
		begin
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
			select @nResult_ rtn, 'ERROR 아이디를 찾지 못했습니다.'
		end
	else if (@blockstate = @BLOCK_STATE_YES)
		BEGIN
			-- 블럭유저인가?
			set @nResult_ 	= @RESULT_ERROR_BLOCK_USER
			select @nResult_ rtn, '블럭처리된 아이디입니다.'
		END
	else if(@itemcode_ not in (7000, 7001, 7002, 7003, 7004, 7005, 7006, 7007, 7008, 7009, 7014, 7015, 7016, 7017, 7018))
		begin
			set @nResult_ = @RESULT_ERROR_CASH_COPY
			select @nResult_ rtn, 'ERROR 캐쉬카피(인증되지 않는 아이템 코드(-5))'

			---------------------------------------------------
			--	캐쉬카피 플래그 기록
			---------------------------------------------------
			update dbo.tFVUserMaster set cashcopy = cashcopy + 10 where gameid = @gameid_

			insert into dbo.tFVUserUnusualLog(gameid, comment) values(@gameid_, '**** 캐쉬카피를 시도했습니다(인증되지 않는 아이템 코드(-5)) ****')
		end
	else if (@randserial_ = @randserial)
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			select @nResult_ rtn, 'SUCCESS 구매를 정상처리하다(동일시리얼).'
		END
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

			-- 무료, 유료 아이템 코드 값은 같음.
			set @buycash = case
									when @itemcode_ in (7000) then   3000	-- 이벤트.

									when @itemcode_ in (7001) then   5000	-- 생애.
									when @itemcode_ in (7002) then  30000
									when @itemcode_ in (7003) then 100000

									when @itemcode_ in (7004) then   1000	-- 일반.
									when @itemcode_ in (7005) then   5000
									when @itemcode_ in (7006) then  10000
									when @itemcode_ in (7007) then  30000
									when @itemcode_ in (7008) then  60000
									when @itemcode_ in (7009) then 100000
									else 0
							end

			set @pluscashcost = case
									when @itemcode_ in (7000) then (   300 +     0 )	-- 이벤트.

									when @itemcode_ in (7001) then (  1000 +    50 )	-- 생애.
									when @itemcode_ in (7002) then (  6000 +  1200 )
									when @itemcode_ in (7003) then ( 20000 + 10000 )

									when @itemcode_ in (7004) then (   100 +     0 )	-- 일반.
									when @itemcode_ in (7005) then (   500 +    25 )
									when @itemcode_ in (7006) then (  1000 +   100 )
									when @itemcode_ in (7007) then (  3000 +   600 )
									when @itemcode_ in (7008) then (  6000 +  1800 )
									when @itemcode_ in (7009) then ( 10000 +  5000 )
									else 0
							end
			--select 'DEBUG 구매종류', @itemcode_ itemcode_, @buycash buycash, @pluscashcost pluscashcost, @curdate curdate
			set @cashcost	= @pluscashcost
			set @vippoint	= @buycash
			set @buycash	= @buycash * 1.1
			--select 'DEBUG', @buycash buycash, @cashcost cashcost, @vippoint vippoint


			----------------------------------------------
			-- EVENT > 캐쉬구매후 30일간 지급.
			----------------------------------------------
			if(@itemcode_ = 7000)
				begin
					--select 'DEBUG 캐쉬30일간 지급기록'
					if(@curdate2 >= @cashdatestart and @curdate2 < @cashdateend)
						begin
							--select 'DEBUG 30일 + 신규30일 연장'
							set @cashdatestart	= @cashdatestart
							set @cashdateend	= @cashdateend + 30
							set @cashdatecur	= Convert(varchar(8), Getdate(), 112)
						end
					else
						begin
							--select 'DEBUG 신규30일'
							set @cashdatestart	= Convert(varchar(8), Getdate(), 112)
							set @cashdateend	= Convert(varchar(8), Getdate() + 30, 112)
							set @cashdatecur	= Convert(varchar(8), Getdate(), 112)
						end


					exec spu_FVCashCostDaily @gameid_, '이벤트30(1일)', 3015, 100
					--exec spu_FVSubGiftSend 2, 3015, 100, '이벤트30(1일)', @gameid_, ''
					set @cashgift = 1
				end

			------------------------------------------------
			---- 친구와 나.
			------------------------------------------------
			if(@giftid_ != '' and @itemcode_ in (7014, 7015, 7016, 7017, 7018))
				begin
					--select 'DEBUG 친구에게 선물(' + @gameid_ + ' -> ' + @giftid_ + ')', @buycash buycash, @cashcost cashcost
					set @comment3 = '친구(' + @gameid_ + ')'
					exec spu_FVSubGiftSend 2, 3015, @cashcost, @comment3 , @giftid_, ''
				end

			----------------------------------------------
			-- EVENT > 선물하기.
			----------------------------------------------
			if(@curdate >= @EVENT01_START_DAY and @curdate < @EVENT01_END_DAY)
				begin
					--select 'DEBUG 이벤트'
					set @eventpercent = 20
					if(@curdate >= @EVENT11_START_DAY and @curdate < @EVENT11_END_DAY)
						begin
							set @eventpercent = 50
						end

					set @plusvippoint = @vippoint * 20 / 100
					exec spu_FVSubGiftSend 2, @EVENT01_ITEMCODE, @plusvippoint, '추가이벤트', @gameid_, ''

					set @pluscashcost = @pluscashcost * @eventpercent / 100
					exec spu_FVSubGiftSend 2, @EVENT02_ITEMCODE, @pluscashcost, '추가이벤트', @gameid_, ''

					-- 이벤트로 늘어난 비용.
					set @cashcost = @cashcost + @pluscashcost
					set @vippoint = @vippoint + @plusvippoint
				end
			--else if(@curdate >= @EVENT11_START_DAY and @curdate < @EVENT11_END_DAY)
			--	begin
			--		set @plusvippoint = @vippoint * 40 / 100
			--		exec spu_FVSubGiftSend 2, @EVENT11_ITEMCODE, @plusvippoint, 'vipevent2', @gameid_, ''
			--	end
			---------------------------------------------------
			-- 직접구매 > 캐쉬Pluse
			---------------------------------------------------
			update dbo.tFVUserMaster
				set
					randserial		= @randserial_,
					cashpoint 		= cashpoint + @buycash,
					cashcost 		= cashcost + @cashcost,
					vippoint 		= vippoint + @vippoint,
					cashdatestart	= @cashdatestart,
					cashdateend 	= @cashdateend,
					cashdatecur 	= @cashdatecur
			where gameid = @gameid_
			--select 'DEBUG 구매한량', cashpoint from dbo.tFVUserMaster where gameid = @gameid_

			---------------------------------------------------
			-- 직접구매 > 구매기록하기
			---------------------------------------------------
			--select 'DEBUG 구매로그(전)', @gameid_ gameid_, @acode_ acode_, @buycash buycash, @market market, @ikind_ ikind_
			insert into dbo.tFVCashLog(gameid,   acode,      cash,  market,  ikind,   kakaouserid,  kakaouk,  giftid,   idata,   idata2)
			values(                   @gameid_, @acode_, @buycash, @market, @ikind_, @kakaouserid, @kakaouk, @giftid_, @idata_, @idata2_)
			--select 'DEBUG 구매로그(후)', * from dbo.tFVCashLog where gameid = @gameid_

			---------------------------------------------------
			-- 토탈로그 기록하기
			---------------------------------------------------
			if(exists(select top 1 * from dbo.tFVCashTotal where dateid = @dateid and cashkind = @buycash and market = @market))
				begin
					update dbo.tFVCashTotal
						set
							cash 		= cash 		+ @buycash,
							cnt 		= cnt 		+ 1
					where dateid = @dateid and cashkind = @buycash and market = @market

					--select 'DEBUG 구매토탈 갱신', * from dbo.tFVCashTotal where dateid = @dateid and cashkind = @buycash and market = @market
				end
			else
				begin
					insert into dbo.tFVCashTotal(dateid, cashkind,  market,      cash)
					values(                     @dateid, @buycash, @market,   @buycash)

					--select 'DEBUG 구매토탈 입력', * from dbo.tFVCashTotal where dateid = @dateid and cashkind = @buycash and market = @market
				end

			--유저 수정과 실버볼 갱신해주기
			select * from dbo.tFVUserMaster where gameid = @gameid_


			if(@cashgift = 1)
				begin
					--------------------------------------------------------------
					-- 선물/쪽지 리스트 정보
					--------------------------------------------------------------
					exec spu_FVGiftList @gameid_
				end
		end


	------------------------------------------------
	--	4-2. 유저정보
	------------------------------------------------
	set nocount off
End

