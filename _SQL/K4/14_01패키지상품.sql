/*
--delete from dbo.tFVGiftList where gameid = 'xxxx2'
--update dbo.tFVUserMaster set randserial = -1 where gameid = 'xxxx2'

exec spu_FVPackBuy 'xxxx2', '049000s1i0n7t8445289', 1, 'savedatapackbuy', -1, 7771, -1			-- 정상유저
exec spu_FVPackBuy 'xxxx2', '049000s1i0n7t8445289', 1, 'savedatapackbuy', -7, 7771, -1			-- 정상유저(세션만기)

exec spu_FVPackBuy 'farm60153115', '0381013r6v7v9b472184', 279, '14:6284668%270:240%1:24280,24281,24282,24284,24285%2:2%3:2007,2007,2007,2009,2006,2006,2006,2006%4:514,513,513,512,511,511,509,509,510,511,509,509,509,509,509,509,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1%5:7,11,7,11,9,5,10,2,11,3,5,11,5,4,8,11,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1%280:%6:3168%7:8%8:59%27:-1%19:4000,4001,4002,4003,4004,4005,4006,4007,4008,4009,4010,4011%50:3720,3720,3720,3720,3720,3720,3720,3720,0,0,0,0%51:29760%52:35976960%40:4000@0,4001@0,4002@0,4003@0,4004@0,4005@0,4006@0,4007@0,4008@0,4009@0,4010@0,4011@0%9:66530,24769,9010,6450,4717,6611,5268,4341,17234,17832,18843,8077,1170,0,0,9999766043,0,0,0,0,0,0,0,0%100:24309%101:24321%102:24289%13:0%21:1%22:1%23:1%260:1%28:-1%29:-1%34:%35:%30:%15:23%24:632206548%31:0,8,1,2,3,6,9,4,10,5,13,16,11,12,7,19,18,23,20,29,21,15,17,26,28,22,39,33,30,38,27,31,49,25,32,36,43,48%16:5%17:1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0%18:5007%25:1%36:24321%33:test_for_pc%37:%60:0%61:38010%62:3011%63:76%65:111%70:1%85:1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0%86:6,7,6,6,6,5,7,6,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1%88:-1^-1^-1^-1^-1^-1^-1^-1^-1^-1^-1^-1^-1^-1^-1^-1^-1^-1^-1^-1^-1^-1^-1%93:1^0^0^7^48197@2^0^0^6^23782@3^147^2^6^55816@4^73^2^6^55813@5^0^0^5^18638@6^138^2^7^55715@7^4^2^6^55802%201:4%210:0%221:1%250:1%290:0%300:05/28/2015 11@53@38%400:80015^7,80025^7,80035^7,80045^7,80055^7,80065^7,80074^7%410:80045,80015,80035%415:100000%601:2%602:2%603:2%600:4%500:', -1, '6356844253PWKW852K', -1			-- 정상유저
exec spu_FVPackBuy 'farm60153115', '0381013r6v7v9b472184', 279, '14:6284668%270:240%1:24280,24281,24282,24284,24285%2:2%3:2007,2007,2007,2009,2006,2006,2006,2006%4:514,513,513,512,511,511,509,509,510,511,509,509,509,509,509,509,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1%5:7,11,7,11,9,5,10,2,11,3,5,11,5,4,8,11,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1%280:%6:3168%7:8%8:59%27:-1%19:4000,4001,4002,4003,4004,4005,4006,4007,4008,4009,4010,4011%50:3720,3720,3720,3720,3720,3720,3720,3720,0,0,0,0%51:29760%52:35976960%40:4000@0,4001@0,4002@0,4003@0,4004@0,4005@0,4006@0,4007@0,4008@0,4009@0,4010@0,4011@0%9:66530,24769,9010,6450,4717,6611,5268,4341,17234,17832,18843,8077,1170,0,0,9999766043,0,0,0,0,0,0,0,0%100:24309%101:24321%102:24289%13:0%21:1%22:1%23:1%260:1%28:-1%29:-1%34:%35:%30:%15:23%24:632206548%31:0,8,1,2,3,6,9,4,10,5,13,16,11,12,7,19,18,23,20,29,21,15,17,26,28,22,39,33,30,38,27,31,49,25,32,36,43,48%16:5%17:1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0%18:5007%25:1%36:24321%33:test_for_pc%37:%60:0%61:38010%62:3011%63:76%65:111%70:1%85:1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0%86:6,7,6,6,6,5,7,6,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1%88:-1^-1^-1^-1^-1^-1^-1^-1^-1^-1^-1^-1^-1^-1^-1^-1^-1^-1^-1^-1^-1^-1^-1%93:1^0^0^7^48197@2^0^0^6^23782@3^147^2^6^55816@4^73^2^6^55813@5^0^0^5^18638@6^138^2^7^55715@7^4^2^6^55802%201:4%210:0%221:1%250:1%290:0%300:05/28/2015 11@53@38%400:80015^7,80025^7,80035^7,80045^7,80055^7,80065^7,80074^7%410:80045,80015,80035%415:100000%601:2%602:2%603:2%600:4%500:', -1, '6356844253PWKW8521', -1			-- 정상유저


*/
use Game4FarmVill4
GO

IF OBJECT_ID ( 'dbo.spu_FVPackBuy', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVPackBuy;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_FVPackBuy
	@gameid_								varchar(60),					-- 게임아이디
	@password_								varchar(20),					--
	@idx_									int,							--
	@savedata_								varchar(8000),
	@sid_									int,
	@randserial_							varchar(20),					--
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

	-- 선물 코드값
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- 아이템코드못찾음
	declare @RESULT_ERROR_SESSION_ID_EXPIRE		int				set @RESULT_ERROR_SESSION_ID_EXPIRE		= -150			-- 세션이 만료되었습니다.

	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------
	-- 선물 정의값
	--declare @GIFTLIST_GIFT_KIND_MESSAGE		int					set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2
	--declare @GIFTLIST_GIFT_KIND_MESSAGE_DEL	int					set @GIFTLIST_GIFT_KIND_MESSAGE_DEL			= -1
	--declare @GIFTLIST_GIFT_KIND_GIFT_DEL		int					set @GIFTLIST_GIFT_KIND_GIFT_DEL			= -2
	--declare @GIFTLIST_GIFT_KIND_GIFT_GET		int					set @GIFTLIST_GIFT_KIND_GIFT_GET			= -3
	--declare @GIFTLIST_GIFT_KIND_GIFT_SELL		int					set @GIFTLIST_GIFT_KIND_GIFT_SELL			= -4

	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @comment				varchar(512)
	declare @comment2				varchar(512)			set @comment2		= ''
	declare @gameid					varchar(60)		set @gameid				= ''
	declare @market					int				set @market				= 5
	declare @ownercashcost			bigint			set @ownercashcost		= 0
	declare @ownercashcost2			bigint			set @ownercashcost2		= 0
	declare @randserial				varchar(20)		set @randserial			= ''
	declare @itemcode				int				set @itemcode			= -1
	declare @pack1					int				set @pack1				= -1
	declare @pack2					int				set @pack2				= -1
	declare @pack3					int				set @pack3				= -1
	declare @pack4					int				set @pack4				= -1
	declare @pack5					int				set @pack5				= -1
	declare @pack1cnt				int				set @pack1cnt			= -1
	declare @pack2cnt				int				set @pack2cnt			= -1
	declare @pack3cnt				int				set @pack3cnt			= -1
	declare @pack4cnt				int				set @pack4cnt			= -1
	declare @pack5cnt				int				set @pack5cnt			= -1
	declare @cashcostsale			int				set @cashcostsale		= 99999
	declare @sid					int				set @sid				= 0

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG 입력정보', @gameid_ gameid_, @password_ password_, @idx_ idx_, @savedata_ savedata_, @randserial_ randserial_

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	select
		@gameid 		= gameid,
		@market			= market,
		@ownercashcost	= ownercashcost,
		@sid			= sid,
		@randserial		= randserial
	from dbo.tFVUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 유저정보', @gameid gameid, @market market, @ownercashcost ownercashcost, @randserial randserial

	select
		@itemcode 	= itemcode,
		@pack1 		= pack1,	@pack2 		= pack2,	@pack3 		= pack3,	@pack4 		= pack4,	@pack5 		= pack5,
		@pack1cnt 	= pack1cnt,	@pack2cnt 	= pack2cnt,	@pack3cnt 	= pack3cnt,	@pack4cnt 	= pack4cnt, @pack5cnt 	= pack5cnt,
		@cashcostsale = cashcostsale
	from dbo.tFVSystemPack where idx = @idx_
	--select 'DEBUG 유저정보', @pack1 pack1, @pack2 pack2, @pack3 pack3, @pack4 pack4, @pack5 pack5, @cashcostsale cashcostsale

	------------------------------------------------
	--	3-3. 각상황별로 코드로 분류
	------------------------------------------------
	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR 아이디가 존재하지 않는다.'
			--select 'DEBUG ' + @comment
		END
	else if(@sid_ != -1 and @sid_ != @sid)
		BEGIN
			-- 세션 ID가 같지 않으면 안됨.
			set @nResult_ 	= @RESULT_ERROR_SESSION_ID_EXPIRE
			set @comment 	= '세션이 만료되어 있습니다. 재로그인합니다.'
			--select 'DEBUG ', @comment
		END
	else if (@itemcode = -1)
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_ITEMCODE
			set @comment = 'ERROR 코드를 찾을수 없습니다.'
			--select 'DEBUG ' + @comment
		END
	else if (@randserial_ = @randserial)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '패키지 구매하기(동일씨리얼2)'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '패키지 구매하기'
			--select 'DEBUG ', @comment

			----------------------------------------------
			-- 세이브 정보 > 금액빼기.
			----------------------------------------------
			set @ownercashcost2 = dbo.fnu_GetFVSaveDataToCashcost(@savedata_)
			if(@ownercashcost2 > @ownercashcost - @cashcostsale)
				begin
					set @comment2 = '<font color=red>패키지이상 보유(' + ltrim(rtrim(@ownercashcost)) + ') - 비용(' + ltrim(rtrim(@cashcostsale)) + ') < 현재비용(' + ltrim(rtrim(@ownercashcost2)) + ')</font>'
					--select 'DEBUG **** 이상기록', @comment2 comment2
					exec spu_FVSubUnusualRecord2  @gameid_, @comment2
				end

			---------------------------------------------------
			-- 패키지구매 로그기록(200까지만 관리).
			---------------------------------------------------
			exec spu_FVUserItemBuyLog @gameid_, @ownercashcost2, @itemcode, @cashcostsale, 0, 0

			---------------------------------------------------
			-- 유저 정보 갱신
			---------------------------------------------------
			update dbo.tFVUserMaster
				set
					ownercashcost	= @ownercashcost2,
					randserial		= @randserial_
			where gameid = @gameid_

			----------------------------------------------
			-- 세이브 정보 저장.
			----------------------------------------------
			--select 'DEBUG update'
			update dbo.tFVUserData
				set
					savedate	= getdate(),
					savedata 	= @savedata_
			where gameid = @gameid_

			------------------------------------------------------------------
			-- 패키지를 선물함에 넣어주기.
			------------------------------------------------------------------
			--select 'DEBUG 패키지 선물지급(없으면 자동으로 패스됨)', @pack1 pack1, @pack2 pack2, @pack3 pack3, @pack4 pack4, @pack5 pack5, @pack1cnt pack1cnt, @pack2cnt pack2cnt, @pack3cnt pack3cnt, @pack4cnt pack4cnt, @pack5cnt pack5cnt
			exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @pack1, @pack1cnt, '패키지상품', @gameid_, ''
			exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @pack2, @pack2cnt, '패키지상품', @gameid_, ''
			exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @pack3, @pack3cnt, '패키지상품', @gameid_, ''
			exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @pack4, @pack4cnt, '패키지상품', @gameid_, ''
			exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @pack5, @pack5cnt, '패키지상품', @gameid_, ''

		END

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	select @nResult_ rtn, @comment comment

	if(@nResult_ = @RESULT_SUCCESS)
		begin

			--------------------------------------------------------------
			-- 선물/쪽지 리스트 정보
			--------------------------------------------------------------
			exec spu_FVGiftList @gameid_
		end

	set nocount off
End



