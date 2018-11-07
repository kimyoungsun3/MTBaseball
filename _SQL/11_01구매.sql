---------------------------------------------------------------
/*
update dbo.tUserMaster set cashcost = 0,        gamecost = 0, randserial = -1 where gameid = 'mtxxxx3'
update dbo.tUserMaster set cashcost = 10000000, gamecost = 0, randserial = -1 where gameid = 'mtxxxx3'
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 333, 4000, 1, 7771, -1	-- 돌 박스. -> error
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 333, 4001, 1, 7772, -1	-- 동 박스.
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 333, 4001, 1, 7770, -1
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 333, 4002, 1, 7773, -1	-- 은 박스.
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 333, 4003,10, 7774, -1	-- 금 박스.
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 333, 4004,10, 7775, -1	-- 티타늄 박스.

exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 333, 4500, 1, 7772, -1	-- 4500	소모품(40)	조합초월주문서(45)
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 333, 4500, 1, 7770, -1
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 333, 4501, 1, 7772, -1	-- 4501	소모품(40)	조합초월주문서(45)
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 333, 4501, 1, 7770, -1
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 333, 4700, 1, 7773, -1	-- 4700	소모품(40)	닉네임변경권(47)
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 333, 4700, 1, 7770, -1
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 333, 6000, 1, 7774, -1	-- 6000	볼(60)	볼(60)
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 333, 6000,10, 7775, -1


-- 구매 불가템들.
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 333, 4200, 1, 7771, -1	-- 4200	소모품(40)	조언 패키지 박스(42) -> web
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 333,  101, 1, 7775, -1	-- 기본헬멧
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 333, 1500, 1, 7776, -1	-- 돌 헬멧 조각A
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 333, 4100, 1, 7777, -1	-- 돌 의상 랜덤박스
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 333, 4600, 1, 7778, -1	-- 4600	소모품(40)	수수료주문서(46)
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 333, 4800, 1, 7779, -1	-- 4800	소모품(40)	랜덤다이아(48)
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 333, 5000, 1, 7770, -1	-- 5000	다이아(50)	다이아(50)

*/

use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_ItemBuy', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_ItemBuy;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_ItemBuy
	@gameid_				varchar(20),						-- 게임아이디
	@password_				varchar(20),						-- 암호화해서저장, 유저패스워가 해킹당해도 안전
	@sid_					int,
	@itemcode_				int,								--
	@buycnt_				int,								--
	@randserial_			varchar(20),						--
	@nResult_				int					OUTPUT
	WITH ENCRYPTION
as
	------------------------------------------------
	--	2-1. 코드값
	------------------------------------------------
	-- 일반값
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	-- 로그인 오류.
	declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--삭제유저 > 팝업처리후 인트로로 빼버린다.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함

	-- 게임중에 부족.
	declare @RESULT_ERROR_GAMECOST_LACK			int				set @RESULT_ERROR_GAMECOST_LACK			= -21			--실버가 부족하다.
	declare @RESULT_ERROR_CASHCOST_LACK			int				set @RESULT_ERROR_CASHCOST_LACK			= -22			--골드가 부족하다.
	declare @RESULT_ERROR_ITEM_LACK				int				set @RESULT_ERROR_ITEM_LACK				= -23			--아이템이부족하다.

	-- 선물 코드값
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- 아이템코드못찾음
	declare @RESULT_ERROR_GIFTITEM_NOT_FOUND	int				set @RESULT_ERROR_GIFTITEM_NOT_FOUND	= -51			-- 선물아이템을 못찾음
	declare @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	int				set @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	= -52			-- 선물을 이미 가져감
	declare @RESULT_ERROR_NOT_FOUND_GIFTID		int				set @RESULT_ERROR_NOT_FOUND_GIFTID		= -75			-- 캐쉬 > 선물할 아이디를 못찾음

	-- 기타오류
	declare @RESULT_ERROR_DOUBLE_RANDSERIAL		int				set @RESULT_ERROR_DOUBLE_RANDSERIAL		= -111			-- 랜덤시리얼 중복.
	declare @RESULT_ERROR_ITEMCOST_WRONG		int				set @RESULT_ERROR_ITEMCOST_WRONG		= -113			-- 아이템 가격이 이상함.
	declare @RESULT_ERROR_SESSION_ID_EXPIRE_LOGOUT	int			set @RESULT_ERROR_SESSION_ID_EXPIRE_LOGOUT	= -151		-- 세션이 만료되었습니다.
	declare @RESULT_ERROR_NOT_BUY_ITEMCODE		int				set @RESULT_ERROR_NOT_BUY_ITEMCODE			= -215		-- 구매불가템입니다.

	------------------------------------------------
	--	2-2. 정의된값
	------------------------------------------------
	-- MT 블럭상태값.
	declare @BLOCK_STATE_NO						int					set	@BLOCK_STATE_NO							= 0	-- 블럭상태아님
	declare @BLOCK_STATE_YES					int					set	@BLOCK_STATE_YES						= 1	-- 블럭상태

	-- MT 아이템별 인벤분류
	declare @USERITEM_INVENKIND_WEAR			int 				set @USERITEM_INVENKIND_WEAR				= 1
	declare @USERITEM_INVENKIND_PIECE			int 				set @USERITEM_INVENKIND_PIECE				= 2
	declare @USERITEM_INVENKIND_CONSUME			int 				set @USERITEM_INVENKIND_CONSUME				= 3
	--declare @USERITEM_INVENKIND_NON			int 				set @USERITEM_INVENKIND_NON					= 0
	--declare @USERITEM_INVENKIND_INFO			int 				set @USERITEM_INVENKIND_INFO				= 60
	--declare @USERITEM_INVENKIND_DIRECT		int 				set @USERITEM_INVENKIND_DIRECT				= 40

	-- MT 아이템 대분류
	declare @ITEM_MAINCATEGORY_WEARPART			int					set @ITEM_MAINCATEGORY_WEARPART 			= 1 	-- 장착템(1)
	declare @ITEM_MAINCATEGORY_PIECEPART		int					set @ITEM_MAINCATEGORY_PIECEPART			= 15 	-- 조각템(15)
	declare @ITEM_MAINCATEGORY_COMSUME			int					set @ITEM_MAINCATEGORY_COMSUME				= 40 	-- 소모품(40)
	declare @ITEM_MAINCATEGORY_CASHCOST			int					set @ITEM_MAINCATEGORY_CASHCOST 			= 50 	-- 캐쉬선물(50)
	declare @ITEM_MAINCATEGORY_STATICINFO		int					set @ITEM_MAINCATEGORY_STATICINFO 			= 500 	-- 정보수집(500)
	declare @ITEM_MAINCATEGORY_LEVELUPREWARD	int					set @ITEM_MAINCATEGORY_LEVELUPREWARD		= 510 	-- 레벨업 보상(510)

	-- MT 아이템 소분류
	declare @ITEM_SUBCATEGORY_BOX_PIECE			int					set @ITEM_SUBCATEGORY_BOX_PIECE				= 40 -- 조각 랜덤박스(40)
	--declare @ITEM_SUBCATEGORY_BOX_CLOTH		int					set @ITEM_SUBCATEGORY_BOX_CLOTH				= 41 -- 의상 랜덤박스(41)
	declare @ITEM_SUBCATEGORY_BOX_ADVICE		int					set @ITEM_SUBCATEGORY_BOX_ADVICE			= 42 -- 조언 패키지 박스(42)
	declare @ITEM_SUBCATEGORY_SCROLL_EVOLUTION	int					set @ITEM_SUBCATEGORY_SCROLL_EVOLUTION		= 45 -- 합성초월주문서(45)
	--declare @ITEM_SUBCATEGORY_SCROLL_COMMISSION	int				set @ITEM_SUBCATEGORY_SCROLL_COMMISSION		= 46 -- 수수료주문서(46)
	declare @ITEM_SUBCATEGORY_NICKCHANGE		int					set @ITEM_SUBCATEGORY_NICKCHANGE			= 47 -- 닉네임변경권(47)
	--declare @ITEM_SUBCATEGORY_RANDOM_CASHCOST_BOX	int				set @ITEM_SUBCATEGORY_RANDOM_CASHCOST_BOX	= 48 -- 랜덤다이아(48)
	declare @ITEM_SUBCATEGORY_CASHCOST			int					set @ITEM_SUBCATEGORY_CASHCOST				= 50 -- 다이아(50)
	declare @ITEM_SUBCATEGORY_GAMECOST			int					set @ITEM_SUBCATEGORY_GAMECOST				= 60 -- 볼(60)

	-- MT 아이템 획득방법
	declare @DEFINE_HOW_GET_FIRST				int					set @DEFINE_HOW_GET_FIRST					= 0		--기본
	declare @DEFINE_HOW_GET_BUY					int					set @DEFINE_HOW_GET_BUY						= 1		--구매
	--declare @DEFINE_HOW_GET_GIFT				int					set @DEFINE_HOW_GET_GIFT					= 5		--선물
	--declare @DEFINE_HOW_GET_FREEANIRESTORE	int					set @DEFINE_HOW_GET_FREEANIRESTORE			= 17	--무료복구.
	--declare @DEFINE_HOW_GET_BOX_OPEN			int					set @DEFINE_HOW_GET_BOX_OPEN				= 20 	-- 박스뽑기.
	--declare @DEFINE_HOW_GET_LEVELUP			int 				set @DEFINE_HOW_GET_LEVELUP					= 21 	-- 레벨업.
	--declare @DEFINE_HOW_GET_AUCTION_BUY		int 				set @DEFINE_HOW_GET_AUCTION_BUY				= 22 	-- 경매장 구매.
	--declare @DEFINE_HOW_GET_COMBINATE			int 				set @DEFINE_HOW_GET_COMBINATE				= 23 	-- 조합으로 획득.
	--declare @DEFINE_HOW_GET_EVOLUTION			int 				set @DEFINE_HOW_GET_EVOLUTION				= 24 	-- 초월로 획득.

	declare @DEFINE_MULTISTATE_GIFTCNT			int					set @DEFINE_MULTISTATE_GIFTCNT				= 1		-- 멀티사용.
	declare @DEFINE_MULTISTATE_BUYAMOUNT		int					set @DEFINE_MULTISTATE_BUYAMOUNT			= 0		-- 기본.

	-- 구매의 일반정보.
	declare @CONSUME_MAX_COUNT					int					set @CONSUME_MAX_COUNT						= 99999
	--declare @ACTIVATE_STORE_SELL_NO			int					set @ACTIVATE_STORE_SELL_NO					= 0
	declare @ACTIVATE_STORE_SELL_YES			int					set @ACTIVATE_STORE_SELL_YES				= 1

	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @comment		varchar(80)		set @comment  		= '알수 없는 오류가 발생했습니다.'
	declare @gameid			varchar(20)		set @gameid			= ''
	declare @cashcost		int				set @cashcost 		= 0
	declare @gamecost		int				set @gamecost 		= 0
	declare @sid			int				set @sid			= -1
	declare @blockstate		int				set @blockstate		= @BLOCK_STATE_YES

	declare @itemcode 		int				set @itemcode 		= -1
	declare @invenkind 		int				set @invenkind 		= @USERITEM_INVENKIND_CONSUME
	declare @equpslot 		int				set @equpslot 		= @USERITEM_INVENKIND_CONSUME
	declare @subcategory 	int				set @subcategory 	= -444
	declare @discount		int				set @discount		= 0
	declare @gamecostsell	int				set @gamecostsell 	= 0
	declare @cashcostsell	int				set @cashcostsell 	= 0
	declare @buyamount		int				set @buyamount	 	= 0
	declare @multistate		int				set @multistate		= @DEFINE_MULTISTATE_BUYAMOUNT

	declare @cntnew			int				set @cntnew			= 0
	declare @randserial		varchar(20)		set @randserial		= '-1'
	declare @randserial2	varchar(20)		set @randserial2	= '-1'
	declare @listidxcust 	int				set @listidxcust	= -1
	declare @listidxnew 	int				set @listidxnew		= -1
	declare @listidxrtn 	int				set @listidxrtn		= -1
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG 3-1 입력값', @gameid_ gameid_, @password_ password_, @sid_ sid_, @itemcode_ itemcode_, @buycnt_ buycnt_, @randserial_ randserial_

	------------------------------------------------
	--	3-2. 연산수행(유저정보, 선물정보, 아이템 종류)
	------------------------------------------------
	select
		@gameid 		= gameid,	@blockstate		= blockstate,
		@cashcost		= cashcost,	@gamecost		= gamecost,
		@sid			= sid,		@randserial2	= randserial
	from dbo.tUserMaster where gameid = @gameid_ and password = @password_
	--select 'DEBUG 3-2 유저정보', @gameid gameid, @cashcost cashcost, @gamecost gamecost, @sid sid

	select
		@itemcode 		= itemcode,
		@subcategory 	= subcategory,		@equpslot	= equpslot,		@multistate		= multistate,
		@gamecostsell	= gamecost,			@cashcostsell= cashcost,	@buyamount		= buyamount
	from dbo.tItemInfo where itemcode = @itemcode_ and activate = @ACTIVATE_STORE_SELL_YES
	--select 'DEBUG 3-3 아이템정보(tItemInfo)', @itemcode_ itemcode_, @itemcode itemcode, @subcategory subcategory, @equpslot equpslot, @gamecostsell gamecostsell, @cashcostsell cashcostsell, @buyamount buyamount

	set @invenkind = dbo.fnu_GetInvenFromSubCategory(@subcategory)
	--select 'DEBUG 3-4 아이템정보', @invenkind invenkind

	select
		@listidxcust	= listidx, 			@randserial 		= randserial
	from dbo.tUserItem
	where gameid = @gameid_ and itemcode = @itemcode
	--select 'DEBUG 3-5 아이템정보', @itemcode itemcode, @listidxcust listidxcust, @randserial randserial

	---------------------------------------
	-- 수량파악해서 단가조절하기.
	---------------------------------------
	set @buycnt_ = case when @buycnt_ <= 0 then 1 else @buycnt_ end
	if(@invenkind = @USERITEM_INVENKIND_WEAR)
		begin
			set @buycnt_ = 1
		end
	set @gamecostsell	= @gamecostsell * @buycnt_
	set @cashcostsell	= @cashcostsell * @buycnt_
	set @cntnew			= @buyamount    * @buycnt_
	--select 'DEBUG 3-2-3 아이템정보', @gamecostsell gamecostsell, @cashcostsell cashcostsell, @buyamount buyamount, @buycnt_ buycnt_, @cntnew cntnew

	------------------------------------------------
	--	3-3. 각상황별로 코드로 분류
	------------------------------------------------
	if( @gameid = '' )
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR 아이디가 존재하지 않는다.'
			--select 'DEBUG ' + @comment
		END
	else if ( @blockstate = @BLOCK_STATE_YES )
		BEGIN
			-- 블럭유저인가?
			set @nResult_ 	= @RESULT_ERROR_BLOCK_USER
			set @comment 	= '블럭처리된 아이디입니다.'
			--select 'DEBUG ', @comment
		END
	else if( @sid_ != @sid )
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_SESSION_ID_EXPIRE_LOGOUT
			set @comment 	= 'ERROR 세션이 만기 되었습니다. (로그아웃 시켜주세요.)'
			--select 'DEBUG ' + @comment
		END
	else if ( @itemcode = -1)
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_ITEMCODE
			set @comment = 'ERROR 아이템을 찾을 수 없습니다.(판매안되는 아이템임1)'
			--select 'DEBUG ' + @comment
		END
	else if (@subcategory not in ( @ITEM_SUBCATEGORY_BOX_PIECE, @ITEM_SUBCATEGORY_SCROLL_EVOLUTION, @ITEM_SUBCATEGORY_NICKCHANGE, @ITEM_SUBCATEGORY_GAMECOST ) )
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_BUY_ITEMCODE
			set @comment = 'ERROR 아이템을 찾을 수 없습니다.(판매안되는 아이템 카테고리임2)'
			--select 'DEBUG ' + @comment
		END
	else if (@cashcostsell > 0 and @cashcostsell > @cashcost)
		BEGIN
			set @nResult_ = @RESULT_ERROR_CASHCOST_LACK
			set @comment = 'ERROR 캐쉬(다이아)가 부족합니다.'
			--select 'DEBUG ' + @comment
		END
	else if (@gamecostsell > 0 and @gamecostsell > @gamecost)
		BEGIN
			set @nResult_ = @RESULT_ERROR_GAMECOST_LACK
			set @comment = 'ERROR 코인이 부족합니다.'
			--select 'DEBUG ' + @comment
		END
	else if ( @gamecostsell = 0 and @cashcostsell = 0 and @buyamount = 0 )
		BEGIN
			set @nResult_ = @RESULT_ERROR_ITEMCOST_WRONG
			set @comment = 'ERROR 아이템 정보가 이상합니다.'
			--select 'DEBUG ' + @comment
		END
	else if ( ( @invenkind = @USERITEM_INVENKIND_CONSUME and @randserial = @randserial_ )
				or
			  ( @subcategory = @ITEM_SUBCATEGORY_GAMECOST and @randserial2 = @randserial_ ))
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 정상 지급 처리합니다.(중복구매)'
			--select 'DEBUG ' + @comment

			set @listidxrtn = @listidxcust
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 정상 지급 처리합니다.'

			if(@invenkind = @USERITEM_INVENKIND_CONSUME)
				begin
					----------------------------------------------------------------
					-- 조각 랜덤박스(40),
					-- 조언 패키지 박스(42)
					-- 조합초월주문서(45)
					----------------------------------------------------------------
					if(@listidxcust = -1)
						begin
							select @listidxnew = isnull(MAX(listidx), 0) + 1 from dbo.tUserItem where gameid = @gameid_
							--select 'DEBUG 4-1 인벤 새번호', @listidxnew listidxnew

							--select 'DEBUG 소비 추가', @gameid_ gameid_, @listidxnew listidxnew, @itemcode_ itemcode_, @cntnew cntnew

							insert into dbo.tUserItem(gameid,      listidx,   itemcode,        cnt,  invenkind,   randserial, gethow)
							values(					@gameid_,  @listidxnew, @itemcode_,    @cntnew, @invenkind, @randserial_, @DEFINE_HOW_GET_BUY)

							-- 변경된 아이템 리스트인덱스
							set @listidxrtn	= @listidxnew
						end
					else
						begin
							--select 'DEBUG 소비 보유템에 누적', @gameid_ gameid_, @listidxcust listidxcust, @cntnew cntnew

							update dbo.tUserItem
								set
									cnt 		= cnt + @cntnew,
									randserial 	= @randserial_
							where gameid = @gameid_ and listidx = @listidxcust

							-- 변경된 아이템 리스트인덱스
							set @listidxrtn	= @listidxcust
						end

					-- 캐쉬 or 코인차감 > 하단에서 지급함.
					set @cashcost = @cashcost - @cashcostsell
					set @gamecost = @gamecost - @gamecostsell

					-- 아이템을 직접 넣어줌
					update dbo.tUserMaster
						set
							cashcost	= @cashcost,
							gamecost	= @gamecost
					where gameid = @gameid_

					-- 구매기록마킹
					exec spu_UserItemBuyLogNew @gameid_, @itemcode_, @gamecostsell, @cashcostsell, @cntnew
				end
			else if(@subcategory = @ITEM_SUBCATEGORY_GAMECOST)
				begin
					--select 'DEBUG 4-5-1 gamecost(볼)	-> 바로적용', @multistate multistate, @gamecost gamecost, @cntnew cntnew
					if(@multistate = @DEFINE_MULTISTATE_GIFTCNT)
						begin
							--select 'DEBUG 4-6 볼 -> 보낸수량'
							set @cntnew	= @cntnew
						end
					else
						begin
							--select 'DEBUG 4-6 볼 -> 엑셀수량'
							set @cntnew	= @buyamount
						end
					set @cashcost 	= @cashcost - @cashcostsell
					set @gamecost	= @gamecost + @cntnew

					-- 아이템을 직접 넣어줌
					update dbo.tUserMaster
						set
							cashcost	= @cashcost,
							gamecost 	= @gamecost,
							randserial	= @randserial_
					where gameid = @gameid_

					-- 구매기록마킹
					exec spu_UserItemBuyLogNew @gameid_, @itemcode_, 0, @cashcostsell, @cntnew
				end
		END


	--------------------------------------------------------------
	-- 코드(캐쉬, 코인, 하트, 건초)
	--------------------------------------------------------------
	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost

	if(@nResult_ = @RESULT_SUCCESS)
		begin
			--------------------------------------------------------------
			-- 유저 보유 아이템 정보 > 새로 획득한 것만 전송(기존것 하고 같이 보내면 클라것의 데이터를 덮씌워서 문제됨)
			--------------------------------------------------------------
			select * from dbo.tUserItem
			where gameid = @gameid_ and listidx = @listidxrtn
		end

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
End

