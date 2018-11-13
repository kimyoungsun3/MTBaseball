/*

-- 조합 ABCD + 조합주문서.
exec spu_ItemCombinate 'mtxxxx3', '049000s1i0n7t8445289', 333, '1:82;2:83;3:84;4:85;', 14, 7711, -1	-- 돌 헬멧조합
exec spu_ItemCombinate 'mtxxxx3', '049000s1i0n7t8445289', 333, '1:82;2:83;3:84;4:85;', 14, 7712, -1

-- error
exec spu_ItemCombinate 'mtxxxx3', '049000s1i0n7t8445289', 333, '1:82;2:83;3:84;4:-1;', 14, 7721, -1		-- 하나빈자리.
exec spu_ItemCombinate 'mtxxxx3', '049000s1i0n7t8445289', 333, '1:82;2:83;3:84;4:37;', 14, 7722, -1		-- 다른 등급.
exec spu_ItemCombinate 'mtxxxx3', '049000s1i0n7t8445289', 333, '1:82;2:83;3:84;4:37;', 14, 7723, -1		-- 주문서부족.
*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_ItemCombinate', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_ItemCombinate;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_ItemCombinate
	@gameid_								varchar(20),					-- 게임아이디
	@password_								varchar(20),
	@sid_									int,
	@listidxpiece_							varchar(100),
	@listidxcust_							int,
	@randserial_							varchar(20),
	@nResult_								int					OUTPUT
	WITH ENCRYPTION -- 프로시져를 암호화함.
as
	------------------------------------------------
	--	2-1. 코드값자리
	------------------------------------------------
	-- 일반값
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	-- 로그인 오류.
	declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--블럭유저 > 팝업처리후 인트로로 빼버린다.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함
	declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--서버를 점검하고 있다.

	-- MT 게임중에 부족.
	declare @RESULT_ERROR_CASHCOST_LACK			int				set @RESULT_ERROR_CASHCOST_LACK			= -22			--
	declare @RESULT_ERROR_GAMECOST_LACK			int				set @RESULT_ERROR_GAMECOST_LACK			= -24			--
	declare @RESULT_ERROR_ITEM_LACK				int				set @RESULT_ERROR_ITEM_LACK				= -23			--아이템이부족하다.

	-- 기타오류
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- 아이템코드못찾음
	declare @RESULT_ERROR_PARAMETER				int				set @RESULT_ERROR_PARAMETER				= -122			-- 파라미터오류.
	declare @RESULT_ERROR_SESSION_ID_EXPIRE_LOGOUT	int			set @RESULT_ERROR_SESSION_ID_EXPIRE_LOGOUT	= -151		-- 세션이 만료되었습니다.
	declare @RESULT_ERROR_DIFFERENT_GRADE		int				set @RESULT_ERROR_DIFFERENT_GRADE		= -154			-- 등급이 다릅니다.

	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------
	-- MT 블럭상태값.
	declare @BLOCK_STATE_NO						int					set	@BLOCK_STATE_NO							= 0	-- 블럭상태아님
	declare @BLOCK_STATE_YES					int					set	@BLOCK_STATE_YES						= 1	-- 블럭상태

	-- MT 시스템 체킹
	declare @SYSCHECK_NON						int					set @SYSCHECK_NON							= 0
	declare @SYSCHECK_YES						int					set @SYSCHECK_YES							= 1

	-- MT status
	declare @STATE_SUCCESS						int					set @STATE_SUCCESS							= 1
	declare @STATE_FAIL							int					set @STATE_FAIL								= -1


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
	--declare @ITEM_MAINCATEGORY_CASHCOST		int					set @ITEM_MAINCATEGORY_CASHCOST 			= 50 	-- 캐쉬선물(50)
	--declare @ITEM_MAINCATEGORY_STATICINFO		int					set @ITEM_MAINCATEGORY_STATICINFO 			= 500 	-- 정보수집(500)
	--declare @ITEM_MAINCATEGORY_LEVELUPREWARD	int					set @ITEM_MAINCATEGORY_LEVELUPREWARD		= 510 	-- 레벨업 보상(510)

	-- MT 아이템 소분류
	--declare @ITEM_SUBCATEGORY_WEAR_HELMET		int					set @ITEM_SUBCATEGORY_WEAR_HELMET			= 1  -- 헬멧(1)
	--declare @ITEM_SUBCATEGORY_WEAR_SHIRT		int					set @ITEM_SUBCATEGORY_WEAR_SHIRT			= 2  -- 상의(2)
	--declare @ITEM_SUBCATEGORY_WEAR_PANTS		int					set @ITEM_SUBCATEGORY_WEAR_PANTS			= 3  -- 하의(3)
	--declare @ITEM_SUBCATEGORY_WEAR_GLOVES		int					set @ITEM_SUBCATEGORY_WEAR_GLOVES			= 4  -- 장갑(4)
	--declare @ITEM_SUBCATEGORY_WEAR_SHOES		int					set @ITEM_SUBCATEGORY_WEAR_SHOES			= 5  -- 신발(5)
	--declare @ITEM_SUBCATEGORY_WEAR_BAT		int					set @ITEM_SUBCATEGORY_WEAR_BAT				= 6  -- 방망이(6)
	--declare @ITEM_SUBCATEGORY_WEAR_BALL		int					set @ITEM_SUBCATEGORY_WEAR_BALL				= 7  -- 색깔공(7)
	--declare @ITEM_SUBCATEGORY_WEAR_GOGGLE		int					set @ITEM_SUBCATEGORY_WEAR_GOGGLE			= 8  -- 고글(8)
	--declare @ITEM_SUBCATEGORY_WEAR_WRISTBAND	int					set @ITEM_SUBCATEGORY_WEAR_WRISTBAND		= 9  -- 손목 아대(9)
	--declare @ITEM_SUBCATEGORY_WEAR_ELBOWPAD	int					set @ITEM_SUBCATEGORY_WEAR_ELBOWPAD			= 10 -- 팔꿈치 보호대(10)
	--declare @ITEM_SUBCATEGORY_WEAR_BELT		int					set @ITEM_SUBCATEGORY_WEAR_BELT				= 11 -- 벨트(11)
	--declare @ITEM_SUBCATEGORY_WEAR_KNEEPAD	int					set @ITEM_SUBCATEGORY_WEAR_KNEEPAD			= 12 -- 무릎 보호대(12)
	--declare @ITEM_SUBCATEGORY_WEAR_SOCKS		int					set @ITEM_SUBCATEGORY_WEAR_SOCKS			= 13 -- 양말(13)
	--declare @ITEM_SUBCATEGORY_PIECE_HELMET	int					set @ITEM_SUBCATEGORY_PIECE_HELMET	    	= 15 -- 헬멧 조각(15)
	--declare @ITEM_SUBCATEGORY_PIECE_SHIRT		int					set @ITEM_SUBCATEGORY_PIECE_SHIRT	    	= 16 -- 상의 조각(16)
	--declare @ITEM_SUBCATEGORY_PIECE_PANTS		int					set @ITEM_SUBCATEGORY_PIECE_PANTS	    	= 17 -- 하의 조각(17)
	--declare @ITEM_SUBCATEGORY_PIECE_GLOVES	int					set @ITEM_SUBCATEGORY_PIECE_GLOVES	    	= 18 -- 장갑 조각(18)
	--declare @ITEM_SUBCATEGORY_PIECE_SHOES		int					set @ITEM_SUBCATEGORY_PIECE_SHOES	    	= 19 -- 신발 조각(19)
	--declare @ITEM_SUBCATEGORY_PIECE_BAT		int					set @ITEM_SUBCATEGORY_PIECE_BAT		    	= 20 -- 방망이 조각(20)
	--declare @ITEM_SUBCATEGORY_PIECE_BALL		int					set @ITEM_SUBCATEGORY_PIECE_BALL			= 21 -- 색깔공 조각(21)
	--declare @ITEM_SUBCATEGORY_PIECE_GOGGLE	int					set @ITEM_SUBCATEGORY_PIECE_GOGGLE	    	= 22 -- 고글 조각(22)
	--declare @ITEM_SUBCATEGORY_PIECE_WRISTBAND	int					set @ITEM_SUBCATEGORY_PIECE_WRISTBAND   	= 23 -- 손목 아대 조각(23)
	--declare @ITEM_SUBCATEGORY_PIECE_ELBOWPAD	int					set @ITEM_SUBCATEGORY_PIECE_ELBOWPAD		= 24 -- 팔꿈치 보호대 조각(24)
	--declare @ITEM_SUBCATEGORY_PIECE_BELT		int					set @ITEM_SUBCATEGORY_PIECE_BELT			= 25 -- 벨트 조각(25)
	--declare @ITEM_SUBCATEGORY_PIECE_KNEEPAD	int					set @ITEM_SUBCATEGORY_PIECE_KNEEPAD	    	= 26 -- 무릎 보호대 조각(26)
	--declare @ITEM_SUBCATEGORY_PIECE_SOCKS		int					set @ITEM_SUBCATEGORY_PIECE_SOCKS	    	= 27 -- 양말 조각(27)
	declare @ITEM_SUBCATEGORY_BOX_PIECE			int					set @ITEM_SUBCATEGORY_BOX_PIECE				= 40 -- 조각 랜덤박스(40)
	declare @ITEM_SUBCATEGORY_BOX_CLOTH			int					set @ITEM_SUBCATEGORY_BOX_CLOTH				= 41 -- 의상 랜덤박스(41)
	declare @ITEM_SUBCATEGORY_BOX_ADVICE		int					set @ITEM_SUBCATEGORY_BOX_ADVICE			= 42 -- 조언 패키지 박스(42)
	--declare @ITEM_SUBCATEGORY_SCROLL_EVOLUTION	int				set @ITEM_SUBCATEGORY_SCROLL_EVOLUTION		= 45 -- 합성초월주문서(45)
	declare @ITEM_SUBCATEGORY_SCROLL_COMMISSION	int					set @ITEM_SUBCATEGORY_SCROLL_COMMISSION		= 46 -- 수수료주문서(46)
	--declare @ITEM_SUBCATEGORY_NICKCHANGE		int					set @ITEM_SUBCATEGORY_NICKCHANGE			= 47 -- 닉네임변경권(47)
	declare @ITEM_SUBCATEGORY_RANDOM_CASHCOST_BOX	int				set @ITEM_SUBCATEGORY_RANDOM_CASHCOST_BOX	= 48 -- 랜덤다이아(48)
	--declare @ITEM_SUBCATEGORY_CASHCOST		int					set @ITEM_SUBCATEGORY_CASHCOST				= 50 -- 다이아(50)
	--declare @ITEM_SUBCATEGORY_GAMECOST		int					set @ITEM_SUBCATEGORY_GAMECOST				= 60 -- 볼(60)
	--declare @ITEM_SUBCATEGORY_STATICINFO		int					set @ITEM_SUBCATEGORY_STATICINFO			= 500 -- 정보수집(500)
	--declare @ITEM_SUBCATEGORY_LEVELUPREWARD	int					set @ITEM_SUBCATEGORY_LEVELUPREWARD			= 900 --레벨업 보상(510)

	-- MT 아이템 획득방법
	--declare @DEFINE_HOW_GET_FIRST				int					set @DEFINE_HOW_GET_FIRST					= 0		--기본
	--declare @DEFINE_HOW_GET_BUY				int					set @DEFINE_HOW_GET_BUY						= 1		--구매
	--declare @DEFINE_HOW_GET_GIFT				int					set @DEFINE_HOW_GET_GIFT					= 5		--선물
	--declare @DEFINE_HOW_GET_FREEANIRESTORE	int					set @DEFINE_HOW_GET_FREEANIRESTORE			= 17	--무료복구.
	--declare @DEFINE_HOW_GET_BOX_OPEN			int					set @DEFINE_HOW_GET_BOX_OPEN				= 20 	-- 박스뽑기.
	--declare @DEFINE_HOW_GET_LEVELUP			int 				set @DEFINE_HOW_GET_LEVELUP					= 21 	-- 레벨업.
	--declare @DEFINE_HOW_GET_AUCTION_BUY		int 				set @DEFINE_HOW_GET_AUCTION_BUY				= 22 	-- 경매장 구매.
	declare @DEFINE_HOW_GET_COMBINATE			int 				set @DEFINE_HOW_GET_COMBINATE				= 23 	-- 조합으로 획득.
	--declare @DEFINE_HOW_GET_EVOLUTION			int 				set @DEFINE_HOW_GET_EVOLUTION				= 24 	-- 초월로 획득.

	--조합주문서.
	declare @ITEMCODE_COMBINATE_SCROLL			int 				set @ITEMCODE_COMBINATE_SCROLL				= 4500	-- 조합 주문서
	declare @ITEMCODE_EVOLVE_SCROLL				int 				set @ITEMCODE_EVOLVE_SCROLL					= 4501	-- 초월 주문서


	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @comment				varchar(512)		set @comment			= ''
	declare @gameid					varchar(20)			set @gameid				= ''
	declare @cashcost				int					set @cashcost			= 0
	declare @gamecost				int					set @gamecost			= 0
	declare @sid					int					set @sid				= -1
	declare @blockstate				int					set @blockstate			= @BLOCK_STATE_YES
	declare @randserial				varchar(20)			set @randserial			= '-1'

	declare @tempcombinatestate		int					set @tempcombinatestate	= @STATE_SUCCESS
	declare @templistidxcust		int					set @templistidxcust	= -1
	declare @templistidxpiece1	 	int					set @templistidxpiece1	= -1
	declare @templistidxpiece2	 	int					set @templistidxpiece2	= -1
	declare @templistidxpiece3		int					set @templistidxpiece3	= -1
	declare @templistidxpiece4		int					set @templistidxpiece4	= -1
	declare @templistidxrtn		 	int					set @templistidxrtn		= -1
	declare @tempitemcode			int					set @tempitemcode		= -1

	declare @itemcodecust			int					set @itemcodecust		= -1
	declare @cntcust				int					set @cntcust			= 0
	declare @itemcode1				int					set @itemcode1			= -1
	declare @itemcode2				int					set @itemcode2			= -1
	declare @itemcode3				int					set @itemcode3			= -1
	declare @itemcode4				int					set @itemcode4			= -1
	declare @cnt1					int					set @cnt1				= 0
	declare @cnt2					int					set @cnt2				= 0
	declare @cnt3					int					set @cnt3				= 0
	declare @cnt4					int					set @cnt4				= 0
	declare @subcategory1			int					set @subcategory1		= -1
	declare @subcategory2			int					set @subcategory2		= -1
	declare @subcategory3			int					set @subcategory3		= -1
	declare @subcategory4			int					set @subcategory4		= -1
	declare @grade1					int					set @grade1				= -1
	declare @grade2					int					set @grade2				= -1
	declare @grade3					int					set @grade3				= -1
	declare @grade4					int					set @grade4				= -1
	declare @combcode1				int					set @combcode1			= -1
	declare @combcode2				int					set @combcode2			= -1
	declare @combcode3				int					set @combcode3			= -1
	declare @combcode4				int					set @combcode4			= -1
	declare @combsuborder1			int					set @combsuborder1		= -1
	declare @combsuborder2			int					set @combsuborder2		= -1
	declare @combsuborder3			int					set @combsuborder3		= -1
	declare @combsuborder4			int					set @combsuborder4		= -1
	declare @combsubordersum		int					set @combsubordersum	= 0
	declare @combitemcode1			int					set @combitemcode1		= -1
	declare @combitemcode2			int					set @combitemcode2		= -1
	declare @combitemcode3			int					set @combitemcode3		= -1
	declare @combitemcode4			int					set @combitemcode4		= -1

	declare @rand					int					set @rand				= 0
	declare @randsum				int					set @randsum			= 0
	declare @invenkind				int					set @invenkind			= -1
	declare @subcategorynew			int					set @subcategorynew		= 0
	declare @listidxcust		 	int					set @listidxcust		= -1

	DECLARE @tTempTable TABLE(
		listidx		int
	);

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	set @comment = 'ERROR 아이템을 변경할 수 없습니다.(-1)'
	--select 'DEBUG 1 입력정보', @gameid_ gameid_, @password_ password_, @sid_ sid_, @listidxpiece_ listidxpiece_, @listidxcust_ listidxcust_, @randserial_ randserial_

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	select
		@gameid 			= gameid,			@blockstate		= blockstate,		@sid			= sid,
		@cashcost			= cashcost,			@gamecost		= gamecost,
		@templistidxcust	= templistidxcust,
		@templistidxpiece1	= templistidxpiece1,
		@templistidxpiece2	= templistidxpiece2,
		@templistidxpiece3	= templistidxpiece3,
		@templistidxpiece4	= templistidxpiece4,
		@tempcombinatestate = tempcombinatestate,
		@tempitemcode		= tempitemcode,
		@templistidxrtn 	= templistidxrtn,
		@randserial 		= randserial
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 3-2 유저정보', @gameid gameid, @blockstate blockstate, @sid sid, @cashcost cashcost, @gamecost gamecost, @randserial randserial, @tempcombinatestate tempcombinatestate, @tempitemcode tempitemcode, @templistidxrtn templistidxrtn, @templistidxcust templistidxcust, @templistidxpiece1 templistidxpiece1, @templistidxpiece2 templistidxpiece2, @templistidxpiece3 templistidxpiece3, @templistidxpiece4 templistidxpiece4

	if(@gameid != '' and LEN( @listidxpiece_ ) >= 16 and @listidxcust_ != -1)
		begin
			------------------------------------------------
			-- 조각정보를 분석...
			------------------------------------------------
			SELECT @templistidxpiece1 = param2  FROM dbo.fnu_SplitTwo(';', ':', @listidxpiece_) where param1 = 1
			SELECT @templistidxpiece2 = param2  FROM dbo.fnu_SplitTwo(';', ':', @listidxpiece_) where param1 = 2
			SELECT @templistidxpiece3 = param2  FROM dbo.fnu_SplitTwo(';', ':', @listidxpiece_) where param1 = 3
			SELECT @templistidxpiece4 = param2  FROM dbo.fnu_SplitTwo(';', ':', @listidxpiece_) where param1 = 4
			--select 'DEBUG 3-3', @templistidxpiece1 templistidxpiece1, @templistidxpiece2 templistidxpiece2, @templistidxpiece3 templistidxpiece3, @templistidxpiece4 templistidxpiece4

			------------------------------------------------
			-- 유저보유템(tUserItem)
			------------------------------------------------
			select @itemcodecust  = itemcode, @cntcust = cnt from dbo.tUserItem where gameid = @gameid and listidx = @listidxcust_
			--select 'DEBUG 3-4보유템(주문서)', @listidxcust_ listidxcust_, @itemcodecust itemcodecust, @cntcust cntcust

			select @itemcode1 = itemcode, @cnt1 = cnt from dbo.tUserItem where gameid = @gameid and listidx = @templistidxpiece1
			select @itemcode2 = itemcode, @cnt2 = cnt from dbo.tUserItem where gameid = @gameid and listidx = @templistidxpiece2
			select @itemcode3 = itemcode, @cnt3 = cnt from dbo.tUserItem where gameid = @gameid and listidx = @templistidxpiece3
			select @itemcode4 = itemcode, @cnt4 = cnt from dbo.tUserItem where gameid = @gameid and listidx = @templistidxpiece4
			--select 'DEBUG 3-5보유템(조각)', @templistidxpiece1 templistidxpiece1, @itemcode1 itemcode1, @cnt1 cnt1, @templistidxpiece2 templistidxpiece2, @itemcode2 itemcode2, @cnt2 cnt2, @templistidxpiece3 templistidxpiece3, @itemcode3 itemcode3, @cnt3 cnt3, @templistidxpiece4 templistidxpiece4, @itemcode4 itemcode4, @cnt4 cnt4

			------------------------------------------------
			--  아이템(tItemInfo) > 동급조각종류인가?
			------------------------------------------------
			select @subcategory1 = subcategory, @grade1 = grade, @combcode1 = param3, @combsuborder1 = param4, @combitemcode1 = param5 from dbo.tItemInfo where itemcode = @itemcode1
			select @subcategory2 = subcategory, @grade2 = grade, @combcode2 = param3, @combsuborder2 = param4, @combitemcode2 = param5 from dbo.tItemInfo where itemcode = @itemcode2
			select @subcategory3 = subcategory, @grade3 = grade, @combcode3 = param3, @combsuborder3 = param4, @combitemcode3 = param5 from dbo.tItemInfo where itemcode = @itemcode3
			select @subcategory4 = subcategory, @grade4 = grade, @combcode4 = param3, @combsuborder4 = param4, @combitemcode4 = param5 from dbo.tItemInfo where itemcode = @itemcode4
			--select 'DEBUG 3-6-1템정보.', @itemcode1 itemcode1, @subcategory1 subcategory1, @grade1 grade1, @combcode1 combcode1, @combsuborder1 combsuborder1, @combitemcode1 combitemcode1
			--select 'DEBUG 3-6-2템정보.', @itemcode2 itemcode2, @subcategory2 subcategory2, @grade2 grade2, @combcode2 combcode2, @combsuborder2 combsuborder2, @combitemcode2 combitemcode2
			--select 'DEBUG 3-6-3템정보.', @itemcode3 itemcode3, @subcategory3 subcategory3, @grade3 grade3, @combcode3 combcode3, @combsuborder3 combsuborder3, @combitemcode3 combitemcode3
			--select 'DEBUG 3-6-4템정보.', @itemcode4 itemcode4, @subcategory4 subcategory4, @grade4 grade4, @combcode4 combcode4, @combsuborder4 combsuborder4, @combitemcode4 combitemcode4


			set @combsubordersum = @combsuborder1 + @combsuborder2 + @combsuborder3 + @combsuborder4
		end

	------------------------------------------------
	-- 3-3. 각 조건별 분기
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
	else if ( @sid_ != @sid )
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_SESSION_ID_EXPIRE_LOGOUT
			set @comment 	= 'ERROR 세션이 만기 되었습니다. (로그아웃 시켜주세요.)'
			--select 'DEBUG ' + @comment
		END
	else if ( @randserial_ = @randserial )
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 조합을 시도합니다.(중복)'

			insert into @tTempTable( listidx ) values( @templistidxcust   )
			insert into @tTempTable( listidx ) values( @templistidxpiece1 )
			insert into @tTempTable( listidx ) values( @templistidxpiece2 )
			insert into @tTempTable( listidx ) values( @templistidxpiece3 )
			insert into @tTempTable( listidx ) values( @templistidxpiece4 )
			insert into @tTempTable( listidx ) values( @templistidxrtn    )
		END
	else if ( @itemcodecust != @ITEMCODE_COMBINATE_SCROLL )
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_ITEMCODE
			set @comment = 'ERROR 아이템을 찾지 못했습니다.(1-1주문서)'
		END
	else if ( @cntcust <= 0 )
		BEGIN
			set @nResult_ = @RESULT_ERROR_ITEM_LACK
			set @comment = 'ERROR 아이템이 부족합니다.(1-2주문서)'
		END
	else if ( @itemcode1 = -1 or @itemcode2 = -1 or @itemcode3 = -1 or @itemcode4 = -1 )
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_ITEMCODE
			set @comment = 'ERROR 아이템을 찾지 못했습니다.(2-1조각)'
		END
	else if ( @cnt1 <= 0 or @cnt2 <= 0 or @cnt3 <= 0 or @cnt4 <= 0 )
		BEGIN
			set @nResult_ = @RESULT_ERROR_ITEM_LACK
			set @comment = 'ERROR 아이템이 부족합니다.(2-2조각)'
		END
	else if ( ( @subcategory2 	!= @subcategory3 	or @subcategory3 	!= @subcategory4 	or @subcategory4 	!= @subcategory1 )
			or ( @grade2 		!= @grade3 			or @grade3 			!= @grade4 			or @grade4 			!= @grade1 )
			or ( @combcode2		!= @combcode3		or @combcode3		!= @combcode4		or @combcode4		!= @combcode1 )
			or ( @combitemcode2	!= @combitemcode3	or @combitemcode3	!= @combitemcode4	or @combitemcode4	!= @combitemcode1 )
			or @combsubordersum != (1 + 2 + 3 + 4)
			)
		BEGIN
			set @nResult_ = @RESULT_ERROR_DIFFERENT_GRADE
			set @comment = 'ERROR 아이템을 찾지 못했습니다.(동일등급아님.)'
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 조합을 시도합니다.'
			--select 'DEBUG ' + @comment

			--select 'DEBUG 1 조합하러 가기.'
			------------------------------------------------
			-- 1. 조합 확률 확인.
			--   25% -> 성공.
			--			조각4개 소멸, 주문서 소멸, 의상획득.
			--   75% -> 실패.
			--			조각4개 소멸, 주문서 소멸
			------------------------------------------------
			set @randsum 	= 100
			set @rand 		= dbo.fnu_GetRandom(0, @randsum)
			--select 'DEBUG ', @randsum randsum, @rand rand
			if( @rand < 25 )
				begin
					--select 'DEBUG 25% -> 성공.'
					set @tempcombinatestate	= @STATE_SUCCESS
					set @tempitemcode 		= @combitemcode1
				end
			else
				begin
					--select 'DEBUG 75% -> 실패.'
					set @tempcombinatestate = @STATE_FAIL
					set @tempitemcode 		= -1
				end

			------------------------------------------------
			-- 1-2. 아이템 지급하기.
			------------------------------------------------
			if( @tempitemcode != -1 )
				begin
					select @subcategorynew = subcategory from dbo.tItemInfo where itemcode = @tempitemcode
					set @invenkind 			= dbo.fnu_GetInvenFromSubCategory(@subcategorynew)
					--select 'DEBUG ', @tempitemcode tempitemcode, @invenkind invenkind

					exec dbo.spu_ToUserItem @gameid_, @invenkind, @subcategorynew, @tempitemcode, 1, @DEFINE_HOW_GET_COMBINATE, @randserial_, @nResult2_ = @templistidxrtn OUTPUT
					--select 'DEBUG 아이템지급', @gameid_ gameid_, @invenkind invenkind, @subcategorynew subcategorynew
				end
			else
				begin
					set @templistidxrtn = -1
				end

			------------------------------------------------
			-- 1-4. 박스감소.
			------------------------------------------------
			insert into @tTempTable( listidx ) values( @listidxcust_        )
			insert into @tTempTable( listidx ) values( @templistidxpiece1   )
			insert into @tTempTable( listidx ) values( @templistidxpiece2   )
			insert into @tTempTable( listidx ) values( @templistidxpiece3   )
			insert into @tTempTable( listidx ) values( @templistidxpiece4   )
			insert into @tTempTable( listidx ) values( @templistidxrtn      )

			------------------------------------------------
			-- 박스감소.
			------------------------------------------------
			--select 'DEBUG 수량감소', @listidxcust_ listidxcust_
			update dbo.tUserItem set cnt = cnt - 1 where gameid = @gameid and listidx = @listidxcust_
			update dbo.tUserItem set cnt = cnt - 1 where gameid = @gameid and listidx = @templistidxpiece1
			update dbo.tUserItem set cnt = cnt - 1 where gameid = @gameid and listidx = @templistidxpiece2
			update dbo.tUserItem set cnt = cnt - 1 where gameid = @gameid and listidx = @templistidxpiece3
			update dbo.tUserItem set cnt = cnt - 1 where gameid = @gameid and listidx = @templistidxpiece4

			------------------------------------------------
			-- 통계정보.
			------------------------------------------------
			exec spu_DayLogInfoStatic 25, 1				-- 일 조합.

			------------------------------------------------
			-- 유저정보
			------------------------------------------------
			update dbo.tUserMaster
				set
					templistidxcust		= @listidxcust_,
					templistidxpiece1	= @templistidxpiece1,
					templistidxpiece2	= @templistidxpiece2,
					templistidxpiece3	= @templistidxpiece3,
					templistidxpiece4	= @templistidxpiece4,
					tempcombinatestate	= @tempcombinatestate,
					tempitemcode		= @tempitemcode,
					templistidxrtn		= @templistidxrtn,
					randserial 			= @randserial_
			from dbo.tUserMaster
			where gameid = @gameid_
		END


	--------------------------------------------------------------
	-- 결과전송.s
	--------------------------------------------------------------
	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost,
		   @tempcombinatestate combinatestate, @templistidxrtn listidxrtn, @tempitemcode itemcode

	if(@nResult_ = @RESULT_SUCCESS)
		BEGIN
			--------------------------------------------------------------
			-- 유저 보유 아이템 정보 > 새로 획득한 것만 전송(기존것 하고 같이 보내면 클라것의 데이터를 덮씌워서 문제됨)
			--------------------------------------------------------------
			select * from dbo.tUserItem
			where gameid = @gameid_ and listidx in ( select listidx from @tTempTable )

		END

	------------------------------------------------
	--	4-2. 유저정보
	------------------------------------------------
	set nocount off
End

