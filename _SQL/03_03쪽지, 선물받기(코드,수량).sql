---------------------------------------------------------------
/*
set @str = @gameid + '%'
select a.idx idx2, gameid, giftkind, message, gaindate, giftid, giftdate, b.*
from (select top 100 * from dbo.tGiftList where giftkind in (1, 2) and gameid = @gameid_ order by idx desc) a
	LEFT JOIN
	dbo.tItemInfo b
	ON a.itemcode = b.itemcode
order by idx2 desc

-- update dbo.tUserMaster set sid = 333 where gameid = 'xxxx2'
-- update dbo.tGiftList set giftkind = 2 where idx >= 2 and gameid = 'xxxx2'
-- update dbo.tGiftList set giftkind = 1 where idx  = 1 and gameid = 'xxxx2'
-- delete from dbo.tUserItem where gameid = 'xxxx2' and listidx = 10
update dbo.tGiftList set giftkind = 2 where idx = 1 where gameid = 'xxxx2'
exec spu_GiftGainNew 'xxxx2x', '049000s1i0n7t8445289', 331, -1,  1, -1		-- id /pw
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t844528x', 331, -1,  1, -1
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', 331, -1,  1, -1		-- 세션잘못...
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', 333, -3,777, -1		-- 선물없는 번호..
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', 333,-33,  2, -1		-- 지원하지 않는 코드

exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', 333, -1,  1, -1		-- 쪽지받기(삭제)
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', 333, -3,  2, -1		-- 나무헬멧
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', 333, -3,  3, -1		-- 나무 헬멧 조각A
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', 333, -3,  4, -1		-- 나무 조각 랜덤박스
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', 333, -3,  5, -1		-- 나무 의상 랜덤박스
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', 333, -3,  6, -1		-- 조언 패키지 박스
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', 333, -3,  7, -1		-- 조합 주문서
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', 333, -3,  8, -1		-- 초월 주문서
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', 333, -3,  9, -1		-- 응원의 소리
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', 333, -3, 10, -1	-- 코치의 조언 주문서
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', 333, -3, 11, -1	-- 감독의 조언 주문서
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', 333, -3, 12, -1	-- 다이아 (5000 / 11개)
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', 333, -3, 13, -1	-- 다이아 소량 (5001 / 1개)	1 개	저급(0)	날짜미정	100
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', 333, -3, 14, -1	-- 다이아 뭉치 (5002 / 1개)	1 개	저급(0)	날짜미정	1000
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', 333, -3, 15, -1	-- 다이아 주머니 (5003 / 1개)	1 개	저급(0)	날짜미정	2500
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', 333, -3, 16, -1	-- 작은 다이아 상자 (5004 / 1개)	1 개	저급(0)	날짜미정	4000
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', 333, -3, 17, -1	-- 큰 다이아 상자 (5005 / 1개)	1 개	저급(0)	날짜미정	10000
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', 333, -3, 18, -1	-- 대형 다이아 상자 (5006 / 1개)	1 개	저급(0)	날짜미정	20000

exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', 333, -5, -1, -1	-- 리스트갱신
*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_GiftGainNew', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_GiftGainNew;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_GiftGainNew
	@gameid_				varchar(20),						-- 게임아이디
	@password_				varchar(20),						-- 암호화해서저장, 유저패스워가 해킹당해도 안전
	@sid_					int,
	@giftkind_				int,								--  1:메시지
																--  2:선물
																-- -1:메시지삭제
																-- -2:선물삭제
																-- -3:선물받아감
	@idx_					bigint,								-- 선물인덱스
	@nResult_				int					OUTPUT
	WITH ENCRYPTION
as
	------------------------------------------------
	--	2-1. 코드값
	------------------------------------------------
	-- MT 일반값
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	-- MT 로그인 오류.
	declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--블럭유저 > 팝업처리후 인트로로 빼버린다.
	declare @RESULT_ERROR_DELETED_USER 			int				set @RESULT_ERROR_DELETED_USER			= -12			--삭제유저 > 팝업처리후 인트로로 빼버린다.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함
	declare @RESULT_ERROR_NOT_FOUND_PASSWORD	int				set @RESULT_ERROR_NOT_FOUND_PASSWORD	= -17
	declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--서버를 점검하고 있다.
	declare @RESULT_NEWVERION_CLIENT_DOWNLOAD 	int				set @RESULT_NEWVERION_CLIENT_DOWNLOAD	= -15			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 링크처리.
	declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 종료.
	declare @RESULT_ERROR_NOT_FOUND_PHONE 		int				set @RESULT_ERROR_NOT_FOUND_PHONE		= -76			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 종료.

	-- MT 선물 코드값
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- 아이템코드못찾음
	declare @RESULT_ERROR_GIFTITEM_NOT_FOUND	int				set @RESULT_ERROR_GIFTITEM_NOT_FOUND	= -51			-- 선물아이템을 못찾음
	declare @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	int				set @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	= -52			-- 선물을 이미 가져감
	declare @RESULT_ERROR_NOT_FOUND_GIFTID		int				set @RESULT_ERROR_NOT_FOUND_GIFTID		= -75			-- 캐쉬 > 선물할 아이디를 못찾음

	-- MT 기타오류
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- 지원하지않는모드
	declare @RESULT_ERROR_NOT_MATCH				int				set @RESULT_ERROR_NOT_MATCH				= -110			-- 무엇인가 매치가 안되었다.
	declare @RESULT_ERROR_SESSION_ID_EXPIRE_LOGOUT	int			set @RESULT_ERROR_SESSION_ID_EXPIRE_LOGOUT	= -151		-- 세션이 만료되었습니다.

	------------------------------------------------
	--	2-2. 정의된값
	------------------------------------------------
	-- MT 아이템별 인벤분류
	declare @USERITEM_INVENKIND_WEAR			int 				set @USERITEM_INVENKIND_WEAR				= 1
	declare @USERITEM_INVENKIND_PIECE			int 				set @USERITEM_INVENKIND_PIECE				= 2
	declare @USERITEM_INVENKIND_CONSUME			int 				set @USERITEM_INVENKIND_CONSUME				= 3
	declare @USERITEM_INVENKIND_NON				int 				set @USERITEM_INVENKIND_NON					= 0
	declare @USERITEM_INVENKIND_INFO			int 				set @USERITEM_INVENKIND_INFO				= 60
	declare @USERITEM_INVENKIND_DIRECT			int 				set @USERITEM_INVENKIND_DIRECT				= 40

	-- MT 아이템 소분류
	declare @ITEM_SUBCATEGORY_WEAR_HELMET		int					set @ITEM_SUBCATEGORY_WEAR_HELMET			= 1  -- 헬멧(1)
	declare @ITEM_SUBCATEGORY_WEAR_SHIRT		int					set @ITEM_SUBCATEGORY_WEAR_SHIRT			= 2  -- 상의(2)
	declare @ITEM_SUBCATEGORY_WEAR_PANTS		int					set @ITEM_SUBCATEGORY_WEAR_PANTS			= 3  -- 하의(3)
	declare @ITEM_SUBCATEGORY_WEAR_GLOVES		int					set @ITEM_SUBCATEGORY_WEAR_GLOVES			= 4  -- 장갑(4)
	declare @ITEM_SUBCATEGORY_WEAR_SHOES		int					set @ITEM_SUBCATEGORY_WEAR_SHOES			= 5  -- 신발(5)
	declare @ITEM_SUBCATEGORY_WEAR_BAT			int					set @ITEM_SUBCATEGORY_WEAR_BAT				= 6  -- 방망이(6)
	declare @ITEM_SUBCATEGORY_WEAR_BALL			int					set @ITEM_SUBCATEGORY_WEAR_BALL				= 7  -- 색깔공(7)
	declare @ITEM_SUBCATEGORY_WEAR_GOGGLE		int					set @ITEM_SUBCATEGORY_WEAR_GOGGLE			= 8  -- 고글(8)
	declare @ITEM_SUBCATEGORY_WEAR_WRISTBAND	int					set @ITEM_SUBCATEGORY_WEAR_WRISTBAND		= 9  -- 손목 아대(9)
	declare @ITEM_SUBCATEGORY_WEAR_ELBOWPAD		int					set @ITEM_SUBCATEGORY_WEAR_ELBOWPAD			= 10 -- 팔꿈치 보호대(10)
	declare @ITEM_SUBCATEGORY_WEAR_BELT			int					set @ITEM_SUBCATEGORY_WEAR_BELT				= 11 -- 벨트(11)
	declare @ITEM_SUBCATEGORY_WEAR_KNEEPAD		int					set @ITEM_SUBCATEGORY_WEAR_KNEEPAD			= 12 -- 무릎 보호대(12)
	declare @ITEM_SUBCATEGORY_WEAR_SOCKS		int					set @ITEM_SUBCATEGORY_WEAR_SOCKS			= 13 -- 양말(13)
	declare @ITEM_SUBCATEGORY_PIECE_HELMET		int					set @ITEM_SUBCATEGORY_PIECE_HELMET	    	= 15 -- 헬멧 조각(15)
	declare @ITEM_SUBCATEGORY_PIECE_SHIRT		int					set @ITEM_SUBCATEGORY_PIECE_SHIRT	    	= 16 -- 상의 조각(16)
	declare @ITEM_SUBCATEGORY_PIECE_PANTS		int					set @ITEM_SUBCATEGORY_PIECE_PANTS	    	= 17 -- 하의 조각(17)
	declare @ITEM_SUBCATEGORY_PIECE_GLOVES		int					set @ITEM_SUBCATEGORY_PIECE_GLOVES	    	= 18 -- 장갑 조각(18)
	declare @ITEM_SUBCATEGORY_PIECE_SHOES		int					set @ITEM_SUBCATEGORY_PIECE_SHOES	    	= 19 -- 신발 조각(19)
	declare @ITEM_SUBCATEGORY_PIECE_BAT			int					set @ITEM_SUBCATEGORY_PIECE_BAT		    	= 20 -- 방망이 조각(20)
	declare @ITEM_SUBCATEGORY_PIECE_BALL		int					set @ITEM_SUBCATEGORY_PIECE_BALL			= 21 -- 색깔공 조각(21)
	declare @ITEM_SUBCATEGORY_PIECE_GOGGLE		int					set @ITEM_SUBCATEGORY_PIECE_GOGGLE	    	= 22 -- 고글 조각(22)
	declare @ITEM_SUBCATEGORY_PIECE_WRISTBAND	int					set @ITEM_SUBCATEGORY_PIECE_WRISTBAND   	= 23 -- 손목 아대 조각(23)
	declare @ITEM_SUBCATEGORY_PIECE_ELBOWPAD	int					set @ITEM_SUBCATEGORY_PIECE_ELBOWPAD		= 24 -- 팔꿈치 보호대 조각(24)
	declare @ITEM_SUBCATEGORY_PIECE_BELT		int					set @ITEM_SUBCATEGORY_PIECE_BELT			= 25 -- 벨트 조각(25)
	declare @ITEM_SUBCATEGORY_PIECE_KNEEPAD		int					set @ITEM_SUBCATEGORY_PIECE_KNEEPAD	    	= 26 -- 무릎 보호대 조각(26)
	declare @ITEM_SUBCATEGORY_PIECE_SOCKS		int					set @ITEM_SUBCATEGORY_PIECE_SOCKS	    	= 27 -- 양말 조각(27)
	declare @ITEM_SUBCATEGORY_BOX_WEAR			int					set @ITEM_SUBCATEGORY_BOX_WEAR				= 40 -- 조각 랜덤박스(40)
	declare @ITEM_SUBCATEGORY_BOX_PIECE			int					set @ITEM_SUBCATEGORY_BOX_PIECE				= 41 -- 의상 랜덤박스(41)
	declare @ITEM_SUBCATEGORY_BOX_ADVICE		int					set @ITEM_SUBCATEGORY_BOX_ADVICE			= 42 -- 조언 패키지 박스(42)
	declare @ITEM_SUBCATEGORY_SCROLL_EVOLUTION	int					set @ITEM_SUBCATEGORY_SCROLL_EVOLUTION		= 45 -- 합성초월주문서(45)
	declare @ITEM_SUBCATEGORY_SCROLL_COMMISSION	int					set @ITEM_SUBCATEGORY_SCROLL_COMMISSION		= 46 -- 수수료주문서(46)
	declare @ITEM_SUBCATEGORY_CASHCOST			int					set @ITEM_SUBCATEGORY_CASHCOST				= 50 -- 다이아(50)
	declare @ITEM_SUBCATEGORY_GAMECOST			int					set @ITEM_SUBCATEGORY_GAMECOST				= 60 -- 볼(60)
	--declare @ITEM_SUBCATEGORY_STATICINFO		int					set @ITEM_SUBCATEGORY_STATICINFO			= 500 -- 정보수집(500)
	--declare @ITEM_SUBCATEGORY_LEVELUPREWARD		int					set @ITEM_SUBCATEGORY_LEVELUPREWARD			= 900 --레벨업 보상(510)

	-- MT 선물 정의값
	declare @GIFTLIST_GIFT_KIND_MESSAGE			int					set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2
	declare @GIFTLIST_GIFT_KIND_MESSAGE_DEL		int					set @GIFTLIST_GIFT_KIND_MESSAGE_DEL			= -1
	declare @GIFTLIST_GIFT_KIND_GIFT_DEL		int					set @GIFTLIST_GIFT_KIND_GIFT_DEL			= -2
	declare @GIFTLIST_GIFT_KIND_GIFT_GET		int					set @GIFTLIST_GIFT_KIND_GIFT_GET			= -3
	declare @GIFTLIST_GIFT_KIND_GIFT_SELL		int					set @GIFTLIST_GIFT_KIND_GIFT_SELL			= -4
	declare @GIFTLIST_GIFT_KIND_LIST			int					set @GIFTLIST_GIFT_KIND_LIST				= -5

	-- MT 아이템 획득방법
	declare @DEFINE_HOW_GET_FIRST				int					set @DEFINE_HOW_GET_FIRST					= 0		--기본
	declare @DEFINE_HOW_GET_BUY					int					set @DEFINE_HOW_GET_BUY						= 1		--구매
	declare @DEFINE_HOW_GET_GIFT				int					set @DEFINE_HOW_GET_GIFT					= 5		--선물
	declare @DEFINE_HOW_GET_FREEANIRESTORE		int					set @DEFINE_HOW_GET_FREEANIRESTORE			= 17	--무료복구.
	declare @DEFINE_HOW_GET_BOX_OPEN			int					set @DEFINE_HOW_GET_BOX_OPEN				= 20 	-- 박스뽑기.
	declare @DEFINE_HOW_GET_LEVELUP				int 				set @DEFINE_HOW_GET_LEVELUP					= 21 	-- 레벨업.
	declare @DEFINE_HOW_GET_AUCTION_BUY			int 				set @DEFINE_HOW_GET_AUCTION_BUY				= 22 	-- 경매장 구매.
	declare @DEFINE_HOW_GET_COMBINATE			int 				set @DEFINE_HOW_GET_COMBINATE				= 23 	-- 조합으로 획득.
	declare @DEFINE_HOW_GET_EVOLUTION			int 				set @DEFINE_HOW_GET_EVOLUTION				= 24 	-- 초월로 획득.

	declare @DEFINE_MULTISTATE_GIFTCNT			int					set @DEFINE_MULTISTATE_GIFTCNT				= 1		-- 멀티사용.
	declare @DEFINE_MULTISTATE_BUYAMOUNT		int					set @DEFINE_MULTISTATE_BUYAMOUNT			= 0		-- 기본.

	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @gameid			varchar(20)		set @gameid		= ''
	declare @sid			int				set @sid		= -999
	declare @itemcode		int				set @itemcode 	= -1
	declare @giftkind		int				set @giftkind 	= -1
	declare @cashcost		int				set @cashcost 	= 0
	declare @gamecost		int				set @gamecost 	= 0

	declare @subcategory 	int
	declare	@buyamount		int				set @buyamount		= 0
	declare	@buyamount2		int				set @buyamount2		= 0
	declare	@invenkind		int
	declare @multistate		int				set @multistate		= @DEFINE_MULTISTATE_BUYAMOUNT

	declare @comment		varchar(80)
	declare @plus	 		int 			set @plus			= 0

	declare @sendcnt 		int				set @sendcnt		=  0
	declare @listidxnew 	int				set @listidxnew		= -1
	declare @listidxcust 	int				set @listidxcust	= -1
	declare @listidxrtn 	int				set @listidxrtn		= -1

	declare @dummy	 		int

	DECLARE @tTempTable TABLE(
		listidx		int
	);
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	set @comment  = '알수 없는 오류가 발생했습니다.'
	--select 'DEBUG 1-1 입력값', @gameid_ gameid_, @password_ password_, @sid_ sid_, @giftkind_ giftkind_, @idx_ idx_

	------------------------------------------------
	--	3-2. 연산수행(유저정보, 선물정보, 아이템 종류)
	------------------------------------------------
	select
		@gameid 		= gameid,		@sid		= sid,
		@cashcost		= cashcost,		@gamecost	= gamecost
	from dbo.tUserMaster where gameid = @gameid_ and password = @password_
	--select 'DEBUG 1-3 유저정보', @gameid gameid, @cashcost cashcost, @sid sid, @gamecost gamecost

	select
		@giftkind 	= giftkind,
		@itemcode 	= itemcode,
		@sendcnt	= cnt
	from dbo.tGiftList where gameid = @gameid_ and idx = @idx_
	--select 'DEBUG 1-4 선물/쪽지', @giftkind giftkind, @itemcode itemcode, @sendcnt sendcnt

	------------------------------------------------
	--	3-3. 각상황별로 코드로 분류
	------------------------------------------------
	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR 아이디가 존재하지 않는다.'
			--select 'DEBUG ' + @comment
		END
	else if(@sid_ != @sid)
		BEGIN
			set @nResult_ = @RESULT_ERROR_SESSION_ID_EXPIRE_LOGOUT
			set @comment 	= 'ERROR 세션이 만기 되었습니다.'
			--select 'DEBUG ' + @comment
		END
	else if isnull(@giftkind, -1) = -1
		BEGIN
			set @nResult_ = @RESULT_ERROR_GIFTITEM_NOT_FOUND
			set @comment = 'ERROR 선물, 쪽지 존재자체를 안함'
			--select 'DEBUG ' + @comment
		END
	else if (@giftkind in (@GIFTLIST_GIFT_KIND_MESSAGE_DEL, @GIFTLIST_GIFT_KIND_GIFT_DEL, @GIFTLIST_GIFT_KIND_GIFT_GET, @GIFTLIST_GIFT_KIND_GIFT_SELL, @GIFTLIST_GIFT_KIND_LIST))
		BEGIN
			set @nResult_ = @RESULT_ERROR_GIFTITEM_ALREADY_GAIN
			set @comment = 'ERROR 지급 및 삭제되었습니다.'
			--select 'DEBUG ' + @comment
		END
	else if (@giftkind_ not in (@GIFTLIST_GIFT_KIND_MESSAGE_DEL, @GIFTLIST_GIFT_KIND_GIFT_DEL, @GIFTLIST_GIFT_KIND_GIFT_GET, @GIFTLIST_GIFT_KIND_GIFT_SELL, @GIFTLIST_GIFT_KIND_LIST))
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment = 'ERROR 지원하지 않는 모드값입니다.'
			--select 'DEBUG ' + @comment
		END
	else if(@giftkind_ = @GIFTLIST_GIFT_KIND_MESSAGE_DEL)
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 메세지 삭제 처리합니다.'
			--select 'DEBUG ' + @comment

			update dbo.tGiftList set giftkind = @giftkind_ where idx = @idx_
		END
	else if(@giftkind_ = @GIFTLIST_GIFT_KIND_LIST)
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 선물 리스트 갱신.'
			--select 'DEBUG ' + @comment

			set @listidxrtn = -1
		END
	else if(@giftkind_ = @GIFTLIST_GIFT_KIND_GIFT_DEL)
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 선물 삭제 처리합니다.'
			--select 'DEBUG ' + @comment

			update dbo.tGiftList set giftkind = @giftkind_ where idx = @idx_
		END
	else if(@giftkind_ = @GIFTLIST_GIFT_KIND_GIFT_GET)
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 정상 지급 처리합니다.'

			select
				@subcategory 	= subcategory,
				@multistate		= multistate,
				@buyamount 		= buyamount
			from dbo.tItemInfo where itemcode = @itemcode
			--select 'DEBUG 4-0 ', @subcategory subcategory, @buyamount buyamount, @sendcnt sendcnt

			--------------------------------------------------------------
			-- 지급 수량이 있으면 지급 수량
			-- 없으면 기본 수량을 지급한다.
			--------------------------------------------------------------
			set @buyamount2= @buyamount
			set @buyamount = case when(@sendcnt > 0) then @sendcnt else @buyamount end
			set @invenkind = dbo.fnu_GetInvenFromSubCategory(@subcategory)
			select @listidxnew = isnull(MAX(listidx), 0) + 1 from dbo.tUserItem where gameid = @gameid_
			--select 'DEBUG 4-1 ', @subcategory subcategory, @buyamount buyamount, @sendcnt sendcnt, @invenkind invenkind, @listidxnew listidxnew

			if(@invenkind = @USERITEM_INVENKIND_WEAR)
				begin
					--------------------------------------------------------------
					-- 완성의상
					-- listidx -> 1개 한줄
					--------------------------------------------------------------
					--select 'DEBUG 4-2-2 완성의상 > 신규로 넣어주기', @gameid_ gameid_, @listidxnew listidxnew, @itemcode itemcode, @idx_ idx_

					-- 해당아이템 인벤에 지급
					insert into dbo.tUserItem(gameid,      listidx,  itemcode, cnt,  invenkind,  gethow)				-- 의상
					values(					 @gameid_, @listidxnew, @itemcode,   1, @invenkind, @DEFINE_HOW_GET_GIFT)

					-- 아이템 가져간 상태로 돌려둔다.
					update dbo.tGiftList set giftkind = @GIFTLIST_GIFT_KIND_GIFT_GET, gaindate = getdate() where idx = @idx_

					-- 변경된 아이템 리스트인덱스
					set @listidxrtn	= @listidxnew

					--select 'DEBUG ', @listidxrtn listidxrtn
				end
			else if(@invenkind = @USERITEM_INVENKIND_PIECE )
				begin
					--------------------------------------------------------------
					-- 조각의상
					-- listidx -> n개 한줄 (멀티보유)
					--------------------------------------------------------------
					select
						@listidxcust 	= listidx
					from dbo.tUserItem
					where gameid = @gameid_ and itemcode = @itemcode
					--select 'DEBUG 4-3 인벤넣기', @gameid_ gameid_, @subcategory subcategory, @itemcode itemcode, @listidxcust listidxcust

					--------------------------------------------------------------
					-- 해당아이템 인벤에 지급
					-- 빈자리 찾기 커서
					-- 0 [1] 2 3 4 5 	> [1] > update
					-- 0 1 2 3 4 5 6  	> 없음 > insert
					--------------------------------------------------------------
					if(@listidxcust = -1)
						begin
							--select 'DEBUG 조각 추가', @gameid_ gameid_, @listidxnew listidxnew, @itemcode itemcode, @buyamount buyamount

							insert into dbo.tUserItem(gameid,      listidx,  itemcode,        cnt,  invenkind, gethow)
							values(					@gameid_,  @listidxnew, @itemcode, @buyamount, @invenkind, @DEFINE_HOW_GET_GIFT)

							-- 변경된 아이템 리스트인덱스
							set @listidxrtn	= @listidxnew
						end
					else
						begin
							--select 'DEBUG 조각 보유템에 누적', @gameid_ gameid_, @listidxcust listidxcust, @buyamount buyamount

							update dbo.tUserItem
								set
									cnt = cnt + @buyamount
							where gameid = @gameid_ and listidx = @listidxcust

							-- 변경된 아이템 리스트인덱스
							set @listidxrtn	= @listidxcust
						end

					-- 아이템 가져간 상태로 돌려둔다.
					update dbo.tGiftList set giftkind = @GIFTLIST_GIFT_KIND_GIFT_GET, gaindate = getdate() where idx = @idx_

					-- 아이템 가져간 상태로 돌려둔다.
					--select 'DEBUG ', @listidxrtn listidxrtn
				end
			else if(@invenkind = @USERITEM_INVENKIND_CONSUME)
				begin
					--------------------------------------------------------------
					-- 총알	   	-> 소모성 아이템0
					-- listidx 	-> n개 한줄 (멀티보유)
					--------------------------------------------------------------
					set @itemcode = dbo.fnu_GetItemcodeFromConsumePackage(@subcategory, @itemcode)

					select
						@listidxcust 	= listidx
					from dbo.tUserItem
					where gameid = @gameid_ and itemcode = @itemcode
					--select 'DEBUG 4-3 소비(n)인벤넣기', @gameid_ gameid_, @subcategory subcategory, @itemcode itemcode, @listidxcust listidxcust

					---------------------------------------------------
					-- 해당아이템 인벤에 지급
					-- 빈자리 찾기 커서
					-- 0 [1] 2 3 4 5 	> [1] > update
					-- 0 1 2 3 4 5 6  	> 없음 > insert
					---------------------------------------------------
					if(@listidxcust = -1)
						begin
							--select 'DEBUG 소비 추가', @gameid_ gameid_, @listidxnew listidxnew, @itemcode itemcode, @buyamount buyamount

							insert into dbo.tUserItem(gameid,      listidx,  itemcode,        cnt,  invenkind, gethow)
							values(					@gameid_,  @listidxnew, @itemcode, @buyamount, @invenkind, @DEFINE_HOW_GET_GIFT)

							-- 변경된 아이템 리스트인덱스
							set @listidxrtn	= @listidxnew
						end
					else
						begin
							--select 'DEBUG 소비 보유템에 누적', @gameid_ gameid_, @listidxcust listidxcust, @buyamount buyamount

							update dbo.tUserItem
								set
									cnt = cnt + @buyamount
							where gameid = @gameid_ and listidx = @listidxcust

							-- 변경된 아이템 리스트인덱스
							set @listidxrtn	= @listidxcust
						end


					-- 아이템 가져간 상태로 돌려둔다.
					update dbo.tGiftList set giftkind = @GIFTLIST_GIFT_KIND_GIFT_GET, gaindate = getdate() where idx = @idx_

					-- 아이템 가져간 상태로 돌려둔다.
					--select 'DEBUG ', @listidxrtn listidxrtn
				end
			else if(@subcategory = @ITEM_SUBCATEGORY_CASHCOST)
				begin
					---------------------------------------------------------------
					-- 캐쉬는 선물, 거래소에서 수량으로 거래후 거래 가격이 우편함으로 들어간다.
					-- 구매 	-> 우편함 or 직접
					-- 거래소 	-> 우편함
					---------------------------------------------------------------
					--select 'DEBUG 4-5-1 cashcost(캐시)	-> 바로적용', @multistate multistate, @cashcost cashcost, @sendcnt sendcnt, @buyamount buyamount
					if(@multistate = @DEFINE_MULTISTATE_GIFTCNT)
						begin
							set @plus		= @sendcnt
							--select 'DEBUG 4-6 캐쉬 -> 보낸수량', @sendcnt sendcnt
						end
					else
						begin
							set @plus		= @buyamount2
							--select 'DEBUG 4-6 캐쉬 -> 엑셀수량', @buyamount2 buyamount2
						end
					set @plus = case when @plus < 0 then 0 else @plus end
					set @cashcost	= @cashcost + @plus

					-- 아이템을 직접 넣어줌
					update dbo.tUserMaster
					set
						cashcost = @cashcost,
						cashreceivetotal = cashreceivetotal + @plus
					where gameid = @gameid_

					-- 아이템 가져간 상태로 돌려둔다.
					update dbo.tGiftList set giftkind = @GIFTLIST_GIFT_KIND_GIFT_GET, gaindate = getdate() where idx = @idx_
				end
			else if(@subcategory = @ITEM_SUBCATEGORY_GAMECOST)
				begin
					---------------------------------------------------------------
					-- 선물, 거래소에서 수량으로 거래후 거래 가격이 우편함으로 들어간다.
					-- 구매 	-> 우편함 or 직접
					-- 거래소 	-> 우편함
					---------------------------------------------------------------
					--select 'DEBUG 4-5-1 gamecost(볼)	-> 바로적용', @multistate multistate, @gamecost gamecost, @sendcnt sendcnt, @buyamount buyamount
					if(@multistate = @DEFINE_MULTISTATE_GIFTCNT)
						begin
							set @plus		= @sendcnt
							--select 'DEBUG 4-6 볼 -> 보낸수량', @sendcnt sendcnt
						end
					else
						begin
							set @plus		= @buyamount2
							--select 'DEBUG 4-6 볼 -> 엑셀수량', @buyamount2 buyamount2
						end
					set @plus 		= case when @plus < 0 then 0 else @plus end
					set @gamecost	= @gamecost + @plus

					-- 아이템을 직접 넣어줌
					update dbo.tUserMaster
					set
						gamecost = @gamecost
					where gameid = @gameid_

					-- 아이템 가져간 상태로 돌려둔다.
					update dbo.tGiftList set giftkind = @GIFTLIST_GIFT_KIND_GIFT_GET, gaindate = getdate() where idx = @idx_
				end
			else
				begin
					--------------------------------------------------------------
					-- seed(선물없음)	-> 없음
					-- 업그레이드		-> 없음
					--------------------------------------------------------------
					--select 'DEBUG 4-7 정보표시용'

					-- 아이템 가져간 상태로 돌려둔다.
					update dbo.tGiftList set giftkind = @GIFTLIST_GIFT_KIND_GIFT_GET, gaindate = getdate() where idx = @idx_
				end

			-- 받은 아이템 정보를 리스트에 추가해주기.
			if( @listidxrtn != -1)
				begin
					insert into @tTempTable( listidx ) values( @listidxrtn )
				end
		END

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off

	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost

	if(@nResult_ = @RESULT_SUCCESS)
		begin
			--------------------------------------------------------------
			-- 유저 보유 아이템 정보 > 새로 획득한 것만 전송(기존것 하고 같이 보내면 클라것의 데이터를 덮씌워서 문제됨)
			--------------------------------------------------------------
			select * from dbo.tUserItem
			where gameid = @gameid_ and listidx in ( select listidx from @tTempTable )

			--------------------------------------------------------------
			-- 선물/쪽지 리스트 정보
			--------------------------------------------------------------
			exec spu_GiftList @gameid_
		end

End

