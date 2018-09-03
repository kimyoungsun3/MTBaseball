use Game4FarmVill4
GO

/*
-- 구매[O], 선물[O]
-- delete from tFVCashTotal
select top 10 * from dbo.tFVCashLog order by idx desc
delete from tFVCashLog where gameid in ('xxxx2', 'xxxx3')
delete from tFVGiftList where gameid in ('xxxx2', 'xxxx3')
update dbo.tFVUserMaster set vippoint = 0, cashpoint = 0, cashcost = 0 where gameid = 'xxxx2'
--					gameid           itemcode ikind      acode
exec spu_FVCashBuy3Admin 'xxxx2', '049000s1i0n7t8445289', '',      '7000', '12999763169054705758.1343569877495791', -1	-- GOOGLE(googlekw)
exec spu_FVCashBuy3Admin 'xxxx2', '049000s1i0n7t8445289', '',      '7001', '1009010101',                            -1	-- NHN(REAL)
exec spu_FVCashBuy3Admin 'xxxx2', '049000s1i0n7t8445289', '',      '7005', '60000134460912',                        -1	-- IPHONE(real)
exec spu_FVCashBuy3Admin 'xxxx2', '049000s1i0n7t8445289', '',      '7006', 'TX_00000030191562',                     -1	-- SKT(skt)
*/
IF OBJECT_ID ( 'dbo.spu_FVCashBuy3Admin', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVCashBuy3Admin;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_FVCashBuy3Admin
	@gameid_								varchar(60),					-- 게임아이디
	@password_								varchar(20),
	@giftid_								varchar(60),					-- 친구아이디
	@itemcode_								int,
	@acode_									varchar(256),					-- indexing
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
	declare @MARKET_SKT							int				set @MARKET_SKT							= 1
	--declare @MARKET_KT						int				set @MARKET_KT							= 2
	--declare @MARKET_LGT						int				set @MARKET_LGT							= 3
	declare @MARKET_GOOGLE						int				set @MARKET_GOOGLE						= 5
	declare @MARKET_NHN							int				set @MARKET_NHN							= 6
	declare @MARKET_IPHONE						int				set @MARKET_IPHONE						= 7

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
	declare @EVENT01_END_DAY					datetime			set @EVENT01_END_DAY						= '2015-12-31 23:59'	-- 추가일주일
	declare @EVENT01_ITEMCODE					int					set @EVENT01_ITEMCODE						= 3200	-- VIP지급   0%
	declare @EVENT01_ITEMCODE_COUNT				int					set @EVENT01_ITEMCODE_COUNT					= 0
	declare @EVENT02_ITEMCODE					int					set @EVENT02_ITEMCODE						= 3015	-- 우유결정  30%
	declare @EVENT02_ITEMCODE_COUNT				int					set @EVENT02_ITEMCODE_COUNT					= 30
	
	----------------------------------------------
	-- 8.15 광복기념 이벤트
	----------------------------------------------
	declare @EVENT02_START_DAY					datetime			set @EVENT02_START_DAY						= '2015-08-14 12:00'
	declare @EVENT02_END_DAY					datetime			set @EVENT02_END_DAY						= '2015-08-31 23:59'	-- 추가일주일

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
	declare @cashcost2			int				set @cashcost2		= 0
	declare @vippoint			int				set @vippoint		= 0

	declare @dateid 			varchar(8)		set @dateid 		= Convert(varchar(8), Getdate(), 112)		-- 20120819
	declare @curdate			datetime		set @curdate		= getdate()
	declare @plusvippoint		int				set @plusvippoint	= 0
	declare @pluscashcost		int				set @pluscashcost	= 0

	declare @kakaouk			varchar(19)		set @kakaouk		= substring(Convert(varchar(10),Getdate(),112), 3, 8) + Replace(Convert(varchar(12),Getdate(),114),':','') + Convert(varchar(4), Convert(int, ceiling(RAND() * 9980))+10)
	declare @kakaouserid		varchar(20)		set @kakaouserid	= ''

	declare @eventpercent		int				set @eventpercent	= 0

	declare @ikind				varchar(256)	set @ikind			= 'googlekw'
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	--select 'DEBUG 입력값', @gameid_ gameid_, @password_ password_, @giftid_ giftid_, @itemcode_ itemcode_, @acode_ acode_

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	select
		@gameid 	= gameid,
		@blockstate = blockstate,
		@market		= market,
		@kakaouserid= kakaouserid
	from dbo.tFVUserMaster
	where gameid = @gameid_ and password = @password_

	------------------------------------------------
	--	3-2-3. 연산수행
	------------------------------------------------
	if(@gameid = '')
		begin
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
			select @nResult_ rtn, 'ERROR 아이디를 찾지 못했습니다.'
		end
	else if(@acode_ = '')
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
	else if(@acode_ = 'error')
		begin
			set @nResult_ = @RESULT_ERROR_CASH_COPY
			select @nResult_ rtn, 'ERROR 캐쉬카피(과금코드가 오류코드(-6))'
		end
	else if(@itemcode_ not in (7000, 7001, 7002, 7003, 7004, 7005, 7006, 7007, 7008, 7009, 7010, 7011, 7012, 7013, 7014))
		begin
			set @nResult_ = @RESULT_ERROR_CASH_COPY
			select @nResult_ rtn, 'ERROR 캐쉬카피(인증되지 않는 아이템 코드(-5))'
		end
	else if(@acode_ != '' and exists(select top 1 * from dbo.tFVCashLog where acode = @acode_))
		begin
			set @nResult_ = @RESULT_ERROR_CASH_COPY
			select @nResult_ rtn, 'ERROR 캐쉬카피(블럭처리됩니다.중복요청(-5))'
		end
	else
		begin
			set @nResult_ = @RESULT_SUCCESS
			select @nResult_ rtn, 'SUCCESS 구매를 정상처리하다.'

			-- 무료, 유료 아이템 코드 값은 같음.
			set @buycash = case
									when @itemcode_ in (7000, 7005, 7010) then 5000
									when @itemcode_ in (7001, 7006, 7011) then 10000
									when @itemcode_ in (7002, 7007, 7012) then 30000
									when @itemcode_ in (7003, 7008, 7013) then 55000
									when @itemcode_ in (7004, 7009, 7014) then 99000
									else 0
							end


			set @pluscashcost = case
									when @itemcode_ in (7000, 7005, 7010) then 5000
									when @itemcode_ in (7001, 7006, 7011) then 12000
									when @itemcode_ in (7002, 7007, 7012) then 39000
									when @itemcode_ in (7003, 7008, 7013) then 77000
									when @itemcode_ in (7004, 7009, 7014) then 148500
									else 0
							end
			--select 'DEBUG 구매종류', @itemcode_ itemcode_, @buycash buycash, @pluscashcost pluscashcost, @curdate curdate
			set @cashcost	= @pluscashcost
			set @vippoint	= @buycash
			
			------------------------------------------------------
			-- 8.15 광복기념 이벤트.
			-- 보물최고급티켓  30,000(1장), 55,000(2장), 99,000(6장)
			------------------------------------------------------
			if(@curdate >= @EVENT02_START_DAY and @curdate < @EVENT02_END_DAY and @itemcode_ in (7002, 7007, 7012, 7003, 7008, 7013, 7004, 7009, 7014))
				begin
					if( @itemcode_ in (7002, 7007, 7012) )
						begin
							exec spu_FVSubGiftSend 2, 3601,    1, '8.15 광복기념', @gameid_, ''
						end
					else if( @itemcode_ in (7003, 7008, 7013) )
						begin
							exec spu_FVSubGiftSend 2, 3601,    2, '8.15 광복기념', @gameid_, ''
						end
					else if( @itemcode_ in (7004, 7009, 7014) )
						begin
							exec spu_FVSubGiftSend 2, 3601,    6, '8.15 광복기념', @gameid_, ''
						end
				end


			----------------------------------------------
			-- 구매내역 선물함으로 쏴주기.
			----------------------------------------------
			set @ikind = case
							when @market = @MARKET_GOOGLE	then 'googlekw'
							when @market = @MARKET_SKT		then 'skt'
							when @market = @MARKET_NHN		then 'REAL'
							when @market = @MARKET_IPHONE	then 'real'
							else 								 'idontknow'
						end

			if(@itemcode_ in (7000, 7001, 7002, 7003, 7004))
				begin
					set @cashcost2 = @cashcost * 2
					exec spu_FVSubGiftSend 2, 3015, @cashcost2, '관리자캐쉬(생애)', @gameid_, ''
				end
			else
				begin
					exec spu_FVSubGiftSend 2, 3015, @cashcost, '관리자캐쉬', @gameid_, ''
				end
			exec spu_FVSubGiftSend 2, 3200, @vippoint, '관리자VIP', @gameid_, ''

			----------------------------------------------
			-- 친구와 나.
			----------------------------------------------
			if(@giftid_ != '' and @itemcode_ in (7010, 7011, 7012, 7013, 7014))
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
					if(@EVENT01_ITEMCODE_COUNT > 0)
						begin
							set @plusvippoint = @buycash * @EVENT01_ITEMCODE_COUNT / 100
							exec spu_FVSubGiftSend 2, @EVENT01_ITEMCODE, @plusvippoint, '추가이벤트', @gameid_, ''
						end
					else
						begin
							set @plusvippoint = 0
						end

					if(@EVENT02_ITEMCODE_COUNT > 0)
						begin
							set @pluscashcost = @pluscashcost * @EVENT02_ITEMCODE_COUNT / 100
							exec spu_FVSubGiftSend 2, @EVENT02_ITEMCODE, @pluscashcost, '추가이벤트', @gameid_, ''
						end
					else
						begin
							set @pluscashcost = 0
						end

					-- 이벤트로 늘어난 비용.
					set @cashcost = @cashcost + @pluscashcost
					set @vippoint = @vippoint + @plusvippoint
				end

			---------------------------------------------------
			-- 직접구매 > 캐쉬Pluse
			---------------------------------------------------
			update dbo.tFVUserMaster
				set
					cashpoint 	= cashpoint + @buycash,
					cashcost 	= cashcost + @cashcost,
					vippoint 	= vippoint + @vippoint
			where gameid = @gameid_
			--select 'DEBUG 구매한량', cashpoint from dbo.tFVUserMaster where gameid = @gameid_

			---------------------------------------------------
			-- 직접구매 > 구매기록하기
			---------------------------------------------------
			--select 'DEBUG 구매로그(전)', @gameid_ gameid_, @acode_ acode_, @buycash buycash, @market market
			insert into dbo.tFVCashLog(gameid,   acode,      cash,  market,  ikind,  kakaouserid,  kakaouk,  giftid,    idata,  idata2)
			values(                   @gameid_, @acode_, @buycash, @market, @ikind, @kakaouserid, @kakaouk, @giftid_, @acode_, @acode_)
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
		end



	------------------------------------------------
	--	4-2. 유저정보
	------------------------------------------------
	set nocount off
End

