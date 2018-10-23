---------------------------------------------------------------
/*
--오류코드.
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t84452871',   1, 1, -1, -1, -1, 7771, -1	-- 유저없음.
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289',   -1, 1, -1, -1, -1, 7771, -1	-- 아이템코드없음.
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289',    1, 1, -1, -1, -1, 7771, -1	-- 코인부족.
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289',    3, 1, -1, -1, -1, 7771, -1	-- 캐쉬부족.
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289',  700, 1, -1, -1, -1, 7760, -1	-- 맥스초과.

-- 착용템.
exec spu_ItemBuy 'mtxxxx3','049000s1i0n7t8445289', 333, 100, 1, -1, 7771, -1	-- 소(인벤 -1)
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289',101, 1, -1, -1, -1, 7772, -1	-- 소(인벤 -1)
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289',    1, 1, -1,  6, -1, 7773, -1	-- 소(필드  6) > 2번 충돌.

-- 소모.
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289',  701, 1, -1, -1, -1, 7773, -1	-- 총알(새것) > 2번 충돌
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289',  701,10,  9, -1, -1, 7764, -1	-- 총알(기존누적)
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289',  702, 2, -1, -1, -1, 7773, -1	-- 최상총알(새것)
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289',  703, 2, 14, -1, -1, 7774, -1	-- 최상총알(기존)
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289',  703, 2, -1, -1, -1, 7773, -1	-- 최상총알(새것)
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289',  702, 2, 14, -1, -1, 7774, -1	-- 최상총알(기존)

exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289',  801, 1, -1, -1, -1, 7777, -1	-- 백신
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289',  801, 1, 14, -1,  1, 7778, -1	-- 백신(기존누적)
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 1001, 1, -1, -1, -1, 7779, -1	-- 일꾼
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 1001, 1, 15, -1,  1, 7760, -1	-- 일꾼(새것 > 세팅변경)
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 1003, 1, -1, -1,  1, 7761, -1	-- 일꾼(새것 > 세팅변경)
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 1004, 1, 14, -1,  1, 7762, -1	-- 일꾼(새것 > 세팅변경)
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 1005, 1, 14, -1,  1, 7763, -1	-- 일꾼(새것 > 세팅변경)
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 1006, 1, 14, -1,  1, 7764, -1	-- 일꾼(새것 > 세팅변경)
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 1007, 1, 14, -1,  1, 7767, -1	-- 일꾼(새것 > 세팅변경)
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 1101, 1, -1, -1,  1, 7781, -1	-- 촉진제
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 1101, 1, 16, -1,  1, 7782, -1	-- 촉진제(새것 > 세팅변경)

exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 1200, 1, -1, -1, -1, 7752, -1	-- 부활석
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 1202, 1, 14, -1, -1, 7753, -1	-- 부활석2번 > 부활석 기본으로 할당되어야함
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 1203, 1, 14, -1, -1, 7754, -1	-- 부활석2번 > 부활석 기본으로 할당되어야함
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 1204, 1, 14, -1, -1, 7755, -1	-- 부활석2번 > 부활석 기본으로 할당되어야함
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 1205, 1, 14, -1, -1, 7756, -1	-- 부활석2번 > 부활석 기본으로 할당되어야함
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 1206, 1, 14, -1, -1, 7757, -1	-- 부활석2번 > 부활석 기본으로 할당되어야함
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 1207, 1, 14, -1, -1, 7758, -1	-- 부활석2번 > 부활석 기본으로 할당되어야함
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 1208, 1, 14, -1, -1, 7759, -1	-- 부활석2번 > 부활석 기본으로 할당되어야함
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 1209, 1, 14, -1, -1, 7750, -1	-- 부활석2번 > 부활석 기본으로 할당되어야함
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 5201, 1, -1, -1, -1, 7784, -1	-- 일반교배티켓
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 5300, 1, -1, -1, -1, 7785, -1	-- 대회티켓B
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 2200, 1, -1, -1, -1, 7786, -1	-- 상인100프로만족
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 2100, 1, -1, -1, -1, 7787, -1	-- 긴급요청티켓
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 2101, 1, 17, -1, -1, 7788, -1	-- 긴급요청티켓
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 2103, 1, 17, -1, -1, 7787, -1	-- 긴급요청티켓
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 2104, 1, 17, -1, -1, 7788, -1	-- 긴급요청티켓
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 2105, 1, 17, -1, -1, 7787, -1	-- 긴급요청티켓
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 2106, 1, 17, -1, -1, 7788, -1	-- 긴급요청티켓
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 2107, 1, 17, -1, -1, 7786, -1	-- 긴급요청티켓
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 2108, 1, 17, -1, -1, 7788, -1	-- 긴급요청티켓
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 1600, 1, -1, -1, -1, 7780, -1	-- 시간초기화템
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 1601, 1, -1, -1, -1, 7781, -1	-- 시간초기화템


-- 악세.
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 1401, 1, -1, -1, -1, 7775, -1	-- 악세(머리)
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 1419, 1, -1, -1, -1, 7776, -1	-- 악세(등)
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 1421, 1, -1, -1, -1, 7777, -1	-- 악세(옆구리)

-- 환전.
update dbo.tUserMaster set cashcost = 100000, gamecost = 0,  randserial = -1 where gameid = 'mtxxxx3'
update dbo.tUserMaster set cashcost = 100000, gamecost = 0, randserial = -1 where gameid = 'mtxxxx3'
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 5105, 1, -1, -1, -1, 7790, -1	-- 코인환전(추가 획득있음)
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 5105, 1, -1, -1, -1, 7790, -1	-- 코인환전(추가 획득있음)
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 5106, 1, -1, -1, -1, 7791, -1	--
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 5107, 1, -1, -1, -1, 7792, -1	--
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 5108, 1, -1, -1, -1, 7793, -1	--
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 5109, 1, -1, -1, -1, 7794, -1	--
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 5110, 1, -1, -1, -1, 7795, -1	--
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 5101, 1, -1, -1, -1, 7795, -1	-- 환전비용이상함.

update dbo.tUserMaster set cashcost = 100000, gamecost = 0, cashpoint = 0,      randserial = -1 where gameid = 'mtxxxx3'
update dbo.tUserMaster set cashcost = 100000, gamecost = 0, cashpoint = 140000, randserial = -1 where gameid = 'mtxxxx3'
exec spu_ItemBuy 'mtxxxx3', '049000s1i0n7t8445289', 2000, 1, -1, -1, -1, 7789, -1	-- 하트(추가 획득있음)
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
	--WITH ENCRYPTION
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
	--declare @USERITEM_INVENKIND_NON				int 				set @USERITEM_INVENKIND_NON					= 0
	--declare @USERITEM_INVENKIND_INFO			int 				set @USERITEM_INVENKIND_INFO				= 60
	--declare @USERITEM_INVENKIND_DIRECT			int 				set @USERITEM_INVENKIND_DIRECT				= 40

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
	declare @ITEM_SUBCATEGORY_NICKCHANGE		int					set @ITEM_SUBCATEGORY_NICKCHANGE			= 47 -- 닉네임변경권(47)
	declare @ITEM_SUBCATEGORY_RANDOM_CASHCOST_BOX	int				set @ITEM_SUBCATEGORY_RANDOM_CASHCOST_BOX	= 48 -- 랜덤다이아(48)
	declare @ITEM_SUBCATEGORY_CASHCOST			int					set @ITEM_SUBCATEGORY_CASHCOST				= 50 -- 다이아(50)
	declare @ITEM_SUBCATEGORY_GAMECOST			int					set @ITEM_SUBCATEGORY_GAMECOST				= 60 -- 볼(60)
	declare @ITEM_SUBCATEGORY_STATICINFO		int					set @ITEM_SUBCATEGORY_STATICINFO			= 500 -- 정보수집(500)
	declare @ITEM_SUBCATEGORY_LEVELUPREWARD		int					set @ITEM_SUBCATEGORY_LEVELUPREWARD			= 900 --레벨업 보상(510)

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

	-- 구매의 일반정보.
	declare @CONSUME_MAX_COUNT					int					set @CONSUME_MAX_COUNT						= 99999

	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @comment		varchar(80)		set @comment  	= '알수 없는 오류가 발생했습니다.'
	declare @gameid			varchar(20)		set @gameid			= ''
	declare @cashcost		int				set @cashcost 		= 0
	declare @gamecost		int				set @gamecost 		= 0
	declare @blockstate		int				set @blockstate		= @BLOCK_STATE_YES

	declare @subcategory 	int				set @subcategory 	= -444
	declare @discount		int				set @discount		= 0
	declare @gamecostsell	int				set @gamecostsell 	= 0
	declare @cashcostsell	int				set @cashcostsell 	= 0
	declare @buyamount		int				set @buyamount	 	= 0
	declare @invenkind		int

	declare @cnt 			int				set @cnt			= 0
	declare @plus	 		int 			set @plus			= 0
	declare @listidxcust 	int				set @listidxcust	= -1
	declare @listidxnew 	int				set @listidxnew		= -1
	declare @listidxrtn 	int				set @listidxrtn		= -1

	-- 시스템에서 플러스 해주는 부분.
	declare @plusgamecost 	int				set @plusgamecost	= 0

	declare @dummy	 		int

	declare @itemcodenew	int				set @itemcodenew	= -1
	declare @curdate		datetime		set @curdate		= getdate()
	declare @tmpcnt			int
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	select 'DEBUG 3-1-1 입력값', @gameid_ gameid_, @password_ password_, @sid_ sid_, @itemcode_ itemcode_, @buycnt_ buycnt_, @randserial_ randserial_

	------------------------------------------------
	--	3-2. 연산수행(유저정보, 선물정보, 아이템 종류)
	------------------------------------------------
	select
		@gameid 		= gameid,	@blockstate		= blockstate,
		@cashcost		= cashcost,	@gamecost		= gamecost,
		@sid			= sid
	from dbo.tUserMaster where gameid = @gameid_ and password = @password_
	select 'DEBUG 3-2-1 유저정보', @gameid gameid, @cashcost cashcost, @gamecost gamecost

	select
		@subcategory 	= subcategory,
		@discount		= discount,
		@gamecostsell	= gamecost,
		@cashcostsell	= cashcost,
		@buyamount		= buyamount
	from dbo.tItemInfo where itemcode = @itemcode_
	select 'DEBUG 3-2-2 아이템정보(tItemInfo)', @itemcode_ itemcode_, @subcategory subcategory, @discount discount, @gamecostsell gamecostsell, @cashcostsell cashcostsell, @buyamount buyamount

	set @invenkind = dbo.fnu_GetInvenFromSubCategory(@subcategory)
	set @itemcodenew = dbo.fnu_GetItemcodeFromConsumePackage(@subcategory, @itemcode_)
	select 'DEBUG 3-2-3 아이템정보', @invenkind invenkind

	---------------------------------------
	-- 수량파악해서 단가조절하기.
	---------------------------------------

	if(@invenkind = @USERITEM_INVENKIND_CONSUME)
		begin
			set @buycnt_ = case when @buycnt_ <= 0 then 1 else @buycnt_ end

			set @gamecostsell	= @gamecostsell * @buycnt_
			set @cashcostsell	= @cashcostsell * @buycnt_
			set @buyamount		= @buyamount * @buycnt_
		end
	else
		begin
			set @buycnt_ = 1
		end


	if(@discount > 0 and @discount <= 100)
		begin
			select 'DEBUG 3-2-5 할인율적용(전)', @discount discount, @gamecostsell gamecostsell, @cashcostsell cashcostsell

			set @gamecostsell = @gamecostsell - (@gamecostsell * @discount)/100
			set @cashcostsell = @cashcostsell - (@cashcostsell * @discount)/100

			select 'DEBUG 3-2-6 할인율적용(후)', @discount discount, @gamecostsell gamecostsell, @cashcostsell cashcostsell
		end

	------------------------------------------------
	--	3-3. 각상황별로 코드로 분류
	------------------------------------------------
	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR 아이디가 존재하지 않는다.'
			select 'DEBUG ' + @comment
		END
	else if (@blockstate = @BLOCK_STATE_YES)
		BEGIN
			-- 블럭유저인가?
			set @nResult_ 	= @RESULT_ERROR_BLOCK_USER
			set @comment 	= '블럭처리된 아이디입니다.'
			--select 'DEBUG ', @comment
		END
	else if(@sid_ != @sid)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_SESSION_ID_EXPIRE_LOGOUT
			set @comment 	= 'ERROR 세션이 만기 되었습니다. (로그아웃 시켜주세요.)'
			--select 'DEBUG ' + @comment
		END
	else if (@subcategory = -444)
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_ITEMCODE
			set @comment = 'ERROR 아이템을 찾을 수 없습니다.'
			select 'DEBUG ' + @comment
		END
	else if (exists(select top 1 * from dbo.tUserItem where gameid = @gameid_ and itemcode = @itemcodenew and randserial = @randserial_))
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 정상 지급 처리합니다.(시리얼같아 기존것 던져줌)'
			select 'DEBUG ' + @comment

			select top 1 @listidxrtn = listidx from dbo.tUserItem
			where gameid = @gameid_
				  and itemcode = @itemcodenew
				  and randserial = @randserial_
		END
	else if (@cashcostsell > 0 and @cashcostsell > @cashcost)
		BEGIN
			set @nResult_ = @RESULT_ERROR_CASHCOST_LACK
			set @comment = 'ERROR 캐쉬가 부족합니다.'
			select 'DEBUG ' + @comment
		END
	else if (@gamecostsell > 0 and @gamecostsell > @gamecost)
		BEGIN
			set @nResult_ = @RESULT_ERROR_GAMECOST_LACK
			set @comment = 'ERROR 코인이 부족합니다.'
			select 'DEBUG ' + @comment
		END
	else if (@cashcostsell <= 0 and @gamecostsell <= 0)
		BEGIN
			set @nResult_ = @RESULT_ERROR_ITEMCOST_WRONG
			set @comment = 'ERROR 코인과 캐쉬 가격이 모두 (0)으로 이상합니다.'
			select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 정상 지급 처리합니다.'

			select @listidxnew = isnull(MAX(listidx), 0) + 1 from dbo.tUserItem where gameid = @gameid_
			select 'DEBUG 4-1 인벤 새번호', @listidxnew listidxnew

			if(@invenkind = @USERITEM_INVENKIND_WEAR)
				begin
					-- 해당아이템 인벤에 지급
					insert into dbo.tUserItem(gameid,      listidx,   itemcode, cnt, farmnum,  invenkind,   randserial,  gethow)		-- 착용템.
					values(					 @gameid_, @listidxnew, @itemcode_,   1,       0, @invenkind, @randserial_, @DEFINE_HOW_GET_BUY)

					-- 도감기록
					exec spu_DogamListLog @gameid_, @itemcode_

					-- 캐쉬 or 코인차감 > 하단에서 지급함.
					set @cashcost = @cashcost - @cashcostsell
					set @gamecost = @gamecost - @gamecostsell

					-- 구매기록마킹
					exec spu_UserItemBuyLogNew @gameid_, @itemcode_, @gamecostsell, @cashcostsell, 0

					-- 변경된 아이템 리스트인덱스
					set @listidxrtn	= @listidxnew
				end
			else if(@invenkind = @USERITEM_INVENKIND_CONSUME)
				begin
					----------------------------------------------------------------
					---- 총알					-> 소모성 아이템0
					---- 백신					-> 소모성 아이템0
					---- 촉진제					-> 소모성 아이템0
					---- 알바					-> 소모성 아이템0
					---- 부활석					-> 소모성 아이템 (여러코드 > 1개로 통일됨)
					---- 대회용 티켓			-> 소모성 아이템
					---- 교배 티켓				-> 소모성 아이템
					---- 긴급요청 티켓			-> 소모성 아이템 (여러코드 > 1개로 통일됨)
					---- 상인 100% 만족 티켓	-> 소모성 아이템
					---- 시간초기화템 			-> 소모성 아이템
					----------------------------------------------------------------
					set @itemcode_ = dbo.fnu_GetItemcodeFromConsumePackage(@subcategory, @itemcode_)

					select
						@cnt 			= cnt,
						@listidxcust 	= listidx
					from dbo.tUserItem
					where gameid = @gameid_ and itemcode = @itemcode_
					select 'DEBUG 4-3 소비(n)인벤넣기', @gameid_ gameid_, @itemcode_ itemcode_, @listidxcust listidxcust, @cnt cnt


					select 'DEBUG 4-3-2 인벤으로 이동, 이벤 지급 상태로 변경'
					---------------------------------------------------
					-- 빈자리 찾기 커서
					-- 0 [1] 2 3 4 5 	> [1] > update
					-- 0 1 2 3 4 5 6  	> 없음 > insert
					---------------------------------------------------
					if(@listidxcust = -1)
						begin
							select 'DEBUG 소비 추가', @gameid_ gameid_, @listidxnew listidxnew, @itemcode_ itemcode_, @buyamount buyamount

							insert into dbo.tUserItem(gameid,      listidx,   itemcode,        cnt,  invenkind,   randserial, gethow)
							values(					@gameid_,  @listidxnew, @itemcode_, @buyamount, @invenkind, @randserial_, @DEFINE_HOW_GET_BUY)

							-- 변경된 아이템 리스트인덱스
							set @listidxrtn	= @listidxnew
						end
					else
						begin
							select 'DEBUG 소비 보유템에 누적', @gameid_ gameid_, @listidxcust listidxcust, @buyamount buyamount

							update dbo.tUserItem
								set
									cnt = cnt + @buyamount,
									randserial = @randserial_
							where gameid = @gameid_ and listidx = @listidxcust

							-- 변경된 아이템 리스트인덱스
							set @listidxrtn	= @listidxcust
						end


					-- 캐쉬 or 코인차감 > 하단에서 지급함.
					set @cashcost = @cashcost - @cashcostsell
					set @gamecost = @gamecost - @gamecostsell

					-- 구매기록마킹
					exec spu_UserItemBuyLogNew @gameid_, @itemcode_, @gamecostsell, @cashcostsell, 0


					-- 변경된 아이템 리스트인덱스
					-- > 위에서 각각 처리함.
				end
			---------------------------------------------------------------
			--else if(@subcategory = @ITEM_SUBCATEGORY_CASHCOST)
			-- 별도구현.
			---------------------------------------------------------------
			else if(@subcategory = @ITEM_SUBCATEGORY_GAMECOST)
				begin
					-- 추가 환전.
					select top 1 @plusgamecost = plusgamecost from dbo.tSystemInfo order by idx desc
					select 'DEBUG 4-4-3 환전(전)', @buyamount buyamount, @cashcost cashcost, @gamecost gamecost

					set @plus		= isnull(@buyamount, 0)
					set @gamecost	= @gamecost + (@plus + (@plus * @plusgamecost)/100)

					-- 캐쉬 or 코인차감 > 하단에서 지급함.
					set @cashcost = @cashcost - @cashcostsell
					set @gamecost = @gamecost - @gamecostsell

					-- 구매기록마킹
					exec spu_UserItemBuyLogNew @gameid_, @itemcode_, @gamecostsell, @cashcostsell, 0

					-- 변경된 아이템 리스트인덱스
					-- 필요없음.
					select 'DEBUG 4-5-3 환전(후)', @buyamount buyamount, @cashcost cashcost, @gamecost gamecost
				end
			else
				begin
					--------------------------------------------------------------
					-- seed(선물없음)	-> 없음
					-- 업그레이드		-> 없음
					--------------------------------------------------------------
					select 'DEBUG 4-7 정보표시용'

					set @dummy = 0
				end
		END


	--------------------------------------------------------------
	-- 코드(캐쉬, 코인, 하트, 건초)
	--------------------------------------------------------------
	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost

	if(@nResult_ = @RESULT_SUCCESS)
		begin
			-- 아이템을 직접 넣어줌
			update dbo.tUserMaster
				set
					cashcost	= @cashcost,	gamecost	= @gamecost
			where gameid = @gameid_

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

