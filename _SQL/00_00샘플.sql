use GameMTBaseball
GO

/*
exec spu_SamplePro 'xxxx', '049000s1i0n7t8445289', -1			-- 정상유저
*/


IF OBJECT_ID ( 'dbo.spu_SamplePro', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_SamplePro;
GO

create procedure dbo.spu_SamplePro
	@gameid_				varchar(20),						-- 게임아이디
	@password_				varchar(20),						-- 암호화해서저장, 유저패스워가 해킹당해도 안전
	@randserial_			varchar(20),						--
	@nResult_				int					OUTPUT
	--WITH ENCRYPTION
as
	------------------------------------------------
	--	2-1. 코드값
	------------------------------------------------
	-- MT 일반값
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	-- MT 아이디 생성
	declare @RESULT_ERROR_ID_DUPLICATE			int				set @RESULT_ERROR_ID_DUPLICATE			= -2
	declare @RESULT_ERROR_ID_CREATE_MAX 		int				set @RESULT_ERROR_ID_CREATE_MAX			= -3			-- 생성제한.
	declare @RESULT_ERROR_PHONE_DUPLICATE		int				set @RESULT_ERROR_PHONE_DUPLICATE		= -4
	declare @RESULT_ERROR_EMAIL_DUPLICATE		int				set @RESULT_ERROR_EMAIL_DUPLICATE		= -5
	declare @RESULT_ERROR_NICKNAME_DUPLICATE	int				set @RESULT_ERROR_NICKNAME_DUPLICATE	= -6

	-- MT 로그인 오류.
	declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--블럭유저 > 팝업처리후 인트로로 빼버린다.
	declare @RESULT_ERROR_DELETED_USER 			int				set @RESULT_ERROR_DELETED_USER			= -12			--삭제유저 > 팝업처리후 인트로로 빼버린다.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함
	declare @RESULT_ERROR_NOT_FOUND_PASSWORD	int				set @RESULT_ERROR_NOT_FOUND_PASSWORD	= -17
	declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--서버를 점검하고 있다.
	declare @RESULT_NEWVERION_CLIENT_DOWNLOAD 	int				set @RESULT_NEWVERION_CLIENT_DOWNLOAD	= -15			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 링크처리.
	declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 종료.
	declare @RESULT_ERROR_NOT_FOUND_PHONE 		int				set @RESULT_ERROR_NOT_FOUND_PHONE		= -76			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 종료.

	-- MT 게임중에 부족.
	declare @RESULT_ERROR_CASHCOST_LACK			int				set @RESULT_ERROR_CASHCOST_LACK			= -22			--
	declare @RESULT_ERROR_GAMECOST_LACK			int				set @RESULT_ERROR_GAMECOST_LACK			= -24			--
	declare @RESULT_ERROR_ITEM_LACK				int				set @RESULT_ERROR_ITEM_LACK				= -23			--아이템이부족하다.

	-- MT 아이템 구매, 변경.
	declare @RESULT_ERROR_BUY_ALREADY			int				set @RESULT_ERROR_BUY_ALREADY			= -31			--이미 구매했습니다.
	declare @RESULT_ERROR_NOT_HAVE				int				set @RESULT_ERROR_NOT_HAVE				= -32			--보유하지 않고 있다.
	declare @RESULT_ERROR_UPGRADE_FULL			int				set @RESULT_ERROR_UPGRADE_FULL			= -35			--업그레이드가 풀로되었다.
	declare @RESULT_ERROR_ITEM_NOSALE_KIND		int				set @RESULT_ERROR_ITEM_NOSALE_KIND		= -37			--판매하지 않는 아이템

	-- MT 캐쉬구매.
	declare @RESULT_ERROR_CASH_COPY				int				set @RESULT_ERROR_CASH_COPY				= -40
	declare @RESULT_ERROR_CASH_OVER				int				set @RESULT_ERROR_CASH_OVER				= -41
	declare @RESULT_ERROR_MONTH_OVER			int				set @RESULT_ERROR_MONTH_OVER			= -42			--한달동안 구매한도를 검사

	-- MT 선물 코드값
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- 아이템코드못찾음
	declare @RESULT_ERROR_GIFTITEM_NOT_FOUND	int				set @RESULT_ERROR_GIFTITEM_NOT_FOUND	= -51			-- 선물아이템을 못찾음
	declare @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	int				set @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	= -52			-- 선물을 이미 가져감
	declare @RESULT_ERROR_NOT_FOUND_GIFTID		int				set @RESULT_ERROR_NOT_FOUND_GIFTID		= -75			-- 캐쉬 > 선물할 아이디를 못찾음

	-- MT SMS
	declare @RESULT_ERROR_SMS_NOT_MATCH_PHONE	int				set @RESULT_ERROR_SMS_NOT_MATCH_PHONE	= -80			--문자추천.
	declare @RESULT_ERROR_SMS_KEY_DUPLICATE		int				set @RESULT_ERROR_SMS_KEY_DUPLICATE		= -81
	declare @RESULT_ERROR_SMS_REJECT			int				set @RESULT_ERROR_SMS_REJECT			= -84
	declare @RESULT_ERROR_SMS_DOUBLE_PHONE		int				set @RESULT_ERROR_SMS_DOUBLE_PHONE		= -85
	declare @RESULT_ERROR_KEY_DUPLICATE			int				set @RESULT_ERROR_KEY_DUPLICATE			= -86			-- 일반 키가 중복되었다.

	-- MT 기타오류
	declare @RESULT_ERROR_RESULT_COPY			int				set @RESULT_ERROR_RESULT_COPY			= -53			-- 결과카피시도
	declare @RESULT_ERROR_CASHCOST_COPY			int				set @RESULT_ERROR_CASHCOST_COPY			= -200			-- 캐쉬카피시도
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- 지원하지않는모드
	declare @RESULT_ERROR_NOT_MATCH				int				set @RESULT_ERROR_NOT_MATCH				= -110			-- 무엇인가 매치가 안되었다.
	declare @RESULT_ERROR_DOUBLE_RANDSERIAL		int				set @RESULT_ERROR_DOUBLE_RANDSERIAL		= -111			-- 랜덤시리얼 중복.
	declare @RESULT_ERROR_ITEMCOST_WRONG		int				set @RESULT_ERROR_ITEMCOST_WRONG		= -113			-- 아이템 가격이 이상함.
	declare @RESULT_ERROR_NOT_FOUND_LISTIDX		int				set @RESULT_ERROR_NOT_FOUND_LISTIDX		= -114			-- 리스트 번호를 못찾음.
	declare @RESULT_ERROR_NOT_ENOUGH			int				set @RESULT_ERROR_NOT_ENOUGH			= -115			-- 무엇인가 충분하지 않음.
	declare @RESULT_ERROR_PARAMETER				int				set @RESULT_ERROR_PARAMETER				= -122			-- 파라미터오류.
	declare @RESULT_ERROR_TIME_REMAIN			int				set @RESULT_ERROR_TIME_REMAIN			= -123			-- 아직 시간이 남음.
	declare @RESULT_ERROR_ALREADY_REWARD		int				set @RESULT_ERROR_ALREADY_REWARD		= -126			-- 무엇인가 이미보상했음.
	declare @RESULT_ERROR_NOT_FOUND_CERTNO		int				set @RESULT_ERROR_NOT_FOUND_CERTNO		= -133			-- 쿠폰 번호가 없음.
	declare @RESULT_ERROR_CANNOT_USED_NICKNAME	int				set @RESULT_ERROR_CANNOT_USED_NICKNAME	= -141			-- 닉네임 사용불가.
	declare @RESULT_ERROR_ALREADY_REWARD_COUPON	int				set @RESULT_ERROR_ALREADY_REWARD_COUPON	= -143			-- 쿠폰은 1인 1매.
	declare @RESULT_ERROR_CANNT_CHANGE			int				set @RESULT_ERROR_CANNT_CHANGE			= -146			-- 변경할 수 없습니다..
	declare @RESULT_ERROR_WAIT_RETURN			int				set @RESULT_ERROR_WAIT_RETURN			= -148			-- 요청 대기중입니다.
	declare @RESULT_ERROR_TICKET_LACK			int				set @RESULT_ERROR_TICKET_LACK			= -150			-- 목장도전불가.
	declare @RESULT_ERROR_DIFFERENT_GRADE		int				set @RESULT_ERROR_DIFFERENT_GRADE		= -154			-- 등급이 다릅니다.
	declare @RESULT_ERROR_NOT_FOUND_BOX			int				set @RESULT_ERROR_NOT_FOUND_BOX			= -156			-- 박스를 찾을 수 없습니다.
	declare @RESULT_ERROR_TIME_PASSED			int				set @RESULT_ERROR_TIME_PASSED			= -160			-- 시간이 지났습니다.
	declare @RESULT_ERROR_PRODUCT_EXPIRE		int				set @RESULT_ERROR_PRODUCT_EXPIRE		= -165			-- 해당상품이 만기되었습니다.
	declare @RESULT_ERROR_PRODUCT_EXHAUSTED		int				set @RESULT_ERROR_PRODUCT_EXHAUSTED		= -166			-- 해당상품이 모두 판매되었거나 및 조기종영되었습니다.
	declare @RESULT_ERROR_NOT_FOUND_OTHERID		int				set @RESULT_ERROR_NOT_FOUND_OTHERID		= -83			--
	declare @RESULT_ERROR_SESSION_ID_EXPIRE_LOGOUT	int			set @RESULT_ERROR_SESSION_ID_EXPIRE_LOGOUT	= -151		-- 세션이 만료되었습니다.
	declare @RESULT_ERROR_DOUBLE_IP				int				set @RESULT_ERROR_DOUBLE_IP				= -201			-- IP중복...
	declare @RESULT_ERROR_TURNTIME_WRONG		int				set @RESULT_ERROR_TURNTIME_WRONG		= -203			-- 회차정보가 잘못되었다
	declare @RESULT_ERROR_NOT_BET_ITEMLACK		int				set @RESULT_ERROR_NOT_BET_ITEMLACK		= -204			-- 아이템을 배팅하지 않고 배팅할려고하였습니다.
	declare @RESULT_ERROR_NOT_BET_SAFETIME		int				set @RESULT_ERROR_NOT_BET_SAFETIME		= -205			-- 30초 ~ 결과 ~ 10초 이시간에는 배팅금지
	declare @RESULT_ERROR_NOT_BET_OVERTIME		int				set @RESULT_ERROR_NOT_BET_OVERTIME		= -211			-- 오버타임이상에서는 배팅불가
	declare @RESULT_ERROR_NOT_INPUT_SUPERBALL_5TRY	int			set @RESULT_ERROR_NOT_INPUT_SUPERBALL_5TRY	= -207		-- 슈퍼볼 데이터가 아직 안들어옴… > 5초후에 다시 요청
	declare @RESULT_ERROR_NOT_ING_TURNTIME			int			set @RESULT_ERROR_NOT_ING_TURNTIME		= -	208			-- 잘못된 턴 타임입니다.
	declare @RESULT_ERROR_NOT_CALCULATE_LOTTO_WAIT_LOBBY	int	set @RESULT_ERROR_NOT_CALCULATE_LOTTO_WAIT_LOBBY= -209	-- 로또에서 회차 정보가 5분이 되어도 안옴… > 로비에서 대기해주세요.
	declare @RESULT_ERROR_NOT_CALCULATE_LOTTO_LOGOUT	int		set @RESULT_ERROR_NOT_CALCULATE_LOTTO_LOGOUT= -210		-- 로또에서 회차 정보가 오버타임지나도(5+5분) 안들어옴… > 내부취소마킹, 로그아웃, 점검중…
	declare @RESULT_ERROR_ITEMCODE_GRADE_CHECK	int				set @RESULT_ERROR_ITEMCODE_GRADE_CHECK		= -212		-- 아이템 등급이 잘못되었습니다.
	declare @RESULT_ERROR_MINUMUN_LACK			int				set @RESULT_ERROR_MINUMUN_LACK				= -213		-- 최소수량보다 부족.
	declare @RESULT_ERROR_NOT_BUY_ITEMCODE		int				set @RESULT_ERROR_NOT_BUY_ITEMCODE			= -215		-- 구매불가템입니다.


	------------------------------------------------
	--	2-2. 정의값
	------------------------------------------------
	-- MT 블럭상태값.
	declare @BLOCK_STATE_NO						int					set	@BLOCK_STATE_NO							= 0	-- 블럭상태아님
	declare @BLOCK_STATE_YES					int					set	@BLOCK_STATE_YES						= 1	-- 블럭상태

	declare @ID_MAX								int					set	@ID_MAX									= 1 -- 한폰당 생성할 수 있는 아이디개수

	-- MT 시스템 체킹
	declare @SYSCHECK_NON						int					set @SYSCHECK_NON							= 0
	declare @SYSCHECK_YES						int					set @SYSCHECK_YES							= 1

	-- MT 체킹
	declare @INFOMATION_NO						int					set @INFOMATION_NO							= -1
	declare @INFOMATION_YES						int					set @INFOMATION_YES							=  1

	-- MT bool
	declare @BOOL_TRUE							int					set @BOOL_TRUE								= 1
	declare @BOOL_FALSE							int					set @BOOL_FALSE								= 0

	-- MT 게임모드.
	declare @GAME_MODE_PRACTICE					int					set @GAME_MODE_PRACTICE						= 0
	declare @GAME_MODE_SINGLE					int					set @GAME_MODE_SINGLE						= 1
	declare @GAME_MODE_MULTI					int					set @GAME_MODE_MULTI						= 2

	-- MT combinate(조합)
	declare @COMBINATE_RESULT_SUCCESS			int					set @COMBINATE_RESULT_SUCCESS				= 1
	declare @COMBINATE_RESULT_FAIL				int					set @COMBINATE_RESULT_FAIL					= 0

	-- MT evolution(초월)
	declare @EVOLUTION_RESULT_SUCCESS			int					set @EVOLUTION_RESULT_SUCCESS				= 1
	declare @EVOLUTION_RESULT_FAIL				int					set @EVOLUTION_RESULT_FAIL					= 0

	-- MT 아이템별 인벤분류
	declare @USERITEM_INVENKIND_WEAR			int 				set @USERITEM_INVENKIND_WEAR				= 1
	declare @USERITEM_INVENKIND_PIECE			int 				set @USERITEM_INVENKIND_PIECE				= 2
	declare @USERITEM_INVENKIND_CONSUME			int 				set @USERITEM_INVENKIND_CONSUME				= 3
	declare @USERITEM_INVENKIND_NON				int 				set @USERITEM_INVENKIND_NON					= 0
	declare @USERITEM_INVENKIND_INFO			int 				set @USERITEM_INVENKIND_INFO				= 60
	declare @USERITEM_INVENKIND_DIRECT			int 				set @USERITEM_INVENKIND_DIRECT				= 40

	-- MT 아이템 대분류
	declare @ITEM_MAINCATEGORY_WEARPART			int					set @ITEM_MAINCATEGORY_WEARPART 			= 1 	-- 장착템(1)
	declare @ITEM_MAINCATEGORY_PIECEPART		int					set @ITEM_MAINCATEGORY_PIECEPART			= 15 	-- 조각템(15)
	declare @ITEM_MAINCATEGORY_COMSUME			int					set @ITEM_MAINCATEGORY_COMSUME				= 40 	-- 소모품(40)
	declare @ITEM_MAINCATEGORY_CASHCOST			int					set @ITEM_MAINCATEGORY_CASHCOST 			= 50 	-- 캐쉬선물(50)
	declare @ITEM_MAINCATEGORY_STATICINFO		int					set @ITEM_MAINCATEGORY_STATICINFO 			= 500 	-- 정보수집(500)
	declare @ITEM_MAINCATEGORY_LEVELUPREWARD	int					set @ITEM_MAINCATEGORY_LEVELUPREWARD		= 510 	-- 레벨업 보상(510)

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
	declare @ITEM_SUBCATEGORY_BOX_PIECE			int					set @ITEM_SUBCATEGORY_BOX_PIECE				= 40 -- 조각 랜덤박스(40)
	declare @ITEM_SUBCATEGORY_BOX_CLOTH			int					set @ITEM_SUBCATEGORY_BOX_CLOTH				= 41 -- 의상 랜덤박스(41)
	declare @ITEM_SUBCATEGORY_BOX_ADVICE		int					set @ITEM_SUBCATEGORY_BOX_ADVICE			= 42 -- 조언 패키지 박스(42)
	declare @ITEM_SUBCATEGORY_SCROLL_EVOLUTION	int					set @ITEM_SUBCATEGORY_SCROLL_EVOLUTION		= 45 -- 합성초월주문서(45)
	declare @ITEM_SUBCATEGORY_SCROLL_COMMISSION	int					set @ITEM_SUBCATEGORY_SCROLL_COMMISSION		= 46 -- 수수료주문서(46)
	declare @ITEM_SUBCATEGORY_NICKCHANGE		int					set @ITEM_SUBCATEGORY_NICKCHANGE			= 47 -- 닉네임변경권(47)
	declare @ITEM_SUBCATEGORY_RANDOM_CASHCOST_BOX	int				set @ITEM_SUBCATEGORY_RANDOM_CASHCOST_BOX	= 48 -- 랜덤다이아(48)
	declare @ITEM_SUBCATEGORY_CASHCOST			int					set @ITEM_SUBCATEGORY_CASHCOST				= 50 -- 다이아(50)
	declare @ITEM_SUBCATEGORY_GAMECOST			int					set @ITEM_SUBCATEGORY_GAMECOST				= 60 -- 볼(60)
	declare @ITEM_SUBCATEGORY_STATICINFO		int					set @ITEM_SUBCATEGORY_STATICINFO			= 500 -- 정보수집(500)
	declare @ITEM_SUBCATEGORY_LEVELUPREWARD		int					set @ITEM_SUBCATEGORY_LEVELUPREWARD			= 900 --레벨업 보상(510)

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

	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @gameid			varchar(20)			set @gameid		= ''
	declare @comment		varchar(128)
	declare @cashcost 		int

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR

	select
		@gameid = gameid
	from dbo.tUserMaster where gameid = @gameid_ and password = @password_

	------------------------------------------------
	--	3-3. 유저생성.
	------------------------------------------------
	if exists (select * from tUserMaster where gameid = @gameid_)
		begin
			set @nResult_ = @RESULT_ERROR_ID_DUPLICATE
			set @comment = ' DEBUG (샘플)아이디가 존재합니다.'
		end
	else
		begin
			set @nResult_ = @RESULT_SUCCESS
			set @comment = ' DEBUG (샘플)아이디가 없습니다.'
		end

	/*
	------------------------------------------------------------------
	-- 스위치문
	------------------------------------------------------------------
	set @buypointplus = CASE
							WHEN (@buypointmin <= 0) then 100
							WHEN (@buypointmin <= 5) then 80
							WHEN (@buypointmin <= 10) then 60
							WHEN (@buypointmin <= 20) then 40
							WHEN (@buypointmin <= 40) then 20
							WHEN (@buypointmin <= 60) then 10
							ELSE 0
						END

	------------------------------------------------------------------
	-- select -> insert(읽어서 > 그대로 넣어주기)
	------------------------------------------------------------------
	insert into tMessage(gameid, comment)
		select @gameid_,  itemname + '가 만기가 되었습니다.'
		from @tItemExpire a, tItemInfo b where a.itemcode = b.itemcode

	-----------------------------------------------
	-- 유저 보유 아이템이 만기가되면 만기처리하고 시스템 메시지에 만기를 기록.
	-- 유저의 만기 통채로변경 > @변수테이블에 입력 > 일괄적용
	-- 2개 이상적용됨(테이블로 들어와서)
	-----------------------------------------------
	--declare @gameid_ varchar(20) set @gameid_ = 'Marbles'
	DECLARE @tItemExpire TABLE(
		idx bigint,
		gameid varchar(20),
		itemcode int
	);
	--select * from dbo.tUserItem where gameid = @gameid_
	update dbo.tUserItem
		set
			expirestate = @ITEM_EXPIRE_STATE_YES
			OUTPUT DELETED.idx, @gameid_, DELETED.itemcode into @tItemExpire
	where gameid = @gameid_ and expirestate = @ITEM_EXPIRE_STATE_NO and getdate() > expiredate


	------------------------------------------------------------------
	-- 유저 퀘스트 정보 업데이트
	------------------------------------------------------------------
	-- 로그인 > 대기중(1) and 시간이 유효 > 커서로 필터
	declare curQuestUser Cursor for
		select questkind, questsubkind, questclear from dbo.tQuestInfo
		where questcode in (select questcode from dbo.tQuestUser
							where gameid = @gameid_
								  and queststate = @QUEST_STATE_USER_WAIT
								  and getdate() > queststart)
		Open curQuestUser
		Fetch next from curQuestUser into @questkind, @questsubkind, @questclear
		while @@Fetch_status = 0
			Begin
				if(@questclear = @QUEST_CLEAR_START)
					begin
						-- select 'DEBUG 로그인 > 데이타 클리어해주세요.', @questkind, @questsubkind, @questclear
						-- exec spu_QuestCheck 1, 'superman3', 1000, 8, -1, -1
						exec spu_QuestCheck @QUEST_MODE_CLEAR, @gameid_, @questkind, @questsubkind, -1, -1
					end
				Fetch next from curQuestUser into @questkind, @questsubkind, @questclear
			end
		close curQuestUser
		Deallocate curQuestUser
	*/

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	select @nResult_ rtn, @comment comment, @gameid_ gameid

	set nocount off
End



