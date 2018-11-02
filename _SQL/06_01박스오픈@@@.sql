/*
-- @@@@조각 랜덤박스.
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 59, 7711, -1	-- 돌 조각 랜덤박스(4000)
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 59, 7712, -1
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 52, 7713, -1	-- 동 조각 랜덤박스(4001)
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 52, 7714, -1
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 53, 7715, -1	-- 은 조각 랜덤박스(4002)
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 53, 7716, -1
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 54, 7717, -1	-- 금 조각 랜덤박스(4003)
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 54, 7718, -1
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 55, 7719, -1	-- 티타늄 조각 랜덤박스(4004)
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 55, 7720, -1

-- @@@@의상 랜덤박스.
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 60, 7721, -1	-- 돌 의상 랜덤박스(4100)
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 60, 7722, -1
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 61, 7723, -1	-- 동 의상 랜덤박스(4101)
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 61, 7724, -1
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 62, 7725, -1	-- 은 의상 랜덤박스(4102)
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 62, 7726, -1
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 63, 7727, -1	-- 금 의상 랜덤박스(4103)
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 63, 7728, -1
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 64, 7729, -1	-- 티타늄 의상 랜덤박스(4104)
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 64, 7720, -1

-- 조언패키지.
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 65, 7721, -1	-- 조언 패키지 박스(4200)
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 65, 7722, -1

-- @@@@캐쉬박스.
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 66, 7723, -1	-- 랜덤 다이아 박스(4800)
exec spu_ItemOpen 'mtxxxx3', '049000s1i0n7t8445289', 333, 66, 7724, -1
*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_ItemOpen', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_ItemOpen;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_ItemOpen
	@gameid_								varchar(20),					-- 게임아이디
	@password_								varchar(20),
	@sid_									int,
	@listidx_								int,
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

	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------
	-- MT 블럭상태값.
	declare @BLOCK_STATE_NO						int					set	@BLOCK_STATE_NO							= 0	-- 블럭상태아님
	declare @BLOCK_STATE_YES					int					set	@BLOCK_STATE_YES						= 1	-- 블럭상태

	-- MT 시스템 체킹
	declare @SYSCHECK_NON						int					set @SYSCHECK_NON							= 0
	declare @SYSCHECK_YES						int					set @SYSCHECK_YES							= 1

	-- MT box open status
	declare @BOX_OPEN_STATE_SUCCESS				int					set @BOX_OPEN_STATE_SUCCESS					= 1
	declare @BOX_OPEN_STATE_FAIL				int					set @BOX_OPEN_STATE_FAIL					= -1

	-- MT 아이템별 인벤분류
	declare @USERITEM_INVENKIND_WEAR			int 				set @USERITEM_INVENKIND_WEAR				= 1
	declare @USERITEM_INVENKIND_PIECE			int 				set @USERITEM_INVENKIND_PIECE				= 2
	declare @USERITEM_INVENKIND_CONSUME			int 				set @USERITEM_INVENKIND_CONSUME				= 3
	declare @USERITEM_INVENKIND_NON				int 				set @USERITEM_INVENKIND_NON					= 0
	declare @USERITEM_INVENKIND_INFO			int 				set @USERITEM_INVENKIND_INFO				= 60
	declare @USERITEM_INVENKIND_DIRECT			int 				set @USERITEM_INVENKIND_DIRECT				= 40

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
	declare @ITEM_SUBCATEGORY_BOX_WEAR			int					set @ITEM_SUBCATEGORY_BOX_WEAR				= 40 -- 조각 랜덤박스(40)
	declare @ITEM_SUBCATEGORY_BOX_PIECE			int					set @ITEM_SUBCATEGORY_BOX_PIECE				= 41 -- 의상 랜덤박스(41)
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
	declare @DEFINE_HOW_GET_FIRST				int					set @DEFINE_HOW_GET_FIRST					= 0		--기본
	declare @DEFINE_HOW_GET_BUY					int					set @DEFINE_HOW_GET_BUY						= 1		--구매
	declare @DEFINE_HOW_GET_GIFT				int					set @DEFINE_HOW_GET_GIFT					= 5		--선물
	declare @DEFINE_HOW_GET_FREEANIRESTORE		int					set @DEFINE_HOW_GET_FREEANIRESTORE			= 17	--무료복구.
	declare @DEFINE_HOW_GET_BOX_OPEN			int					set @DEFINE_HOW_GET_BOX_OPEN				= 20 	-- 박스뽑기.
	declare @DEFINE_HOW_GET_LEVELUP				int 				set @DEFINE_HOW_GET_LEVELUP					= 21 	-- 레벨업.
	declare @DEFINE_HOW_GET_AUCTION_BUY			int 				set @DEFINE_HOW_GET_AUCTION_BUY				= 22 	-- 경매장 구매.
	declare @DEFINE_HOW_GET_COMBINATE			int 				set @DEFINE_HOW_GET_COMBINATE				= 23 	-- 조합으로 획득.
	declare @DEFINE_HOW_GET_EVOLUTION			int 				set @DEFINE_HOW_GET_EVOLUTION				= 24 	-- 초월로 획득.

	-- 조언패키지 박스 오픈템들.
	declare @ITEMCODE_COACH_ADVICE				int 				set @ITEMCODE_COACH_ADVICE					= 4601 	-- 조언 박스에서 나오는템.
	declare @ITEMCODE_DIRECTOR_ADVICE			int 				set @ITEMCODE_DIRECTOR_ADVICE				= 4602 	--

	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @comment				varchar(512)		set @comment			= ''
	declare @gameid					varchar(20)			set @gameid				= ''
	declare @cashcost				int					set @cashcost			= 0
	declare @gamecost				int					set @gamecost			= 0
	declare @sid					int					set @sid				= -1
	declare @blockstate				int					set @blockstate			= @BLOCK_STATE_YES
	declare @templistidx1		 	int					set @templistidx1		= -1
	declare @templistidx2		 	int					set @templistidx2		= -1

	declare @itemcode				int					set @itemcode			= -1
	declare @cnt					int					set @cnt				= 0
	declare @randserial				varchar(20)			set @randserial			= '-1'
	declare @subcategory			int					set @subcategory		= -1

	declare	@invenkind				int					set @invenkind			= -1
	declare @rand					int					set @rand				= 0
	declare @randsum				int					set @randsum			= 0
	declare @itemcodenew			int					set @itemcodenew		= 0
	declare @listidxcust		 	int					set @listidxcust		= -1
	declare @listidxnew			 	int					set @listidxnew			= -1
	declare @listidxrtn 			int					set @listidxrtn			= -1
	declare @openstate				int					set @openstate 			= @BOX_OPEN_STATE_SUCCESS

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
	select 'DEBUG 1 입력정보', @gameid_ gameid_, @password_ password_, @sid_ sid_, @listidx_ listidx_, @randserial_ randserial_

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	select
		@gameid 		= gameid,			@blockstate		= blockstate,		@sid			= sid,
		@cashcost		= cashcost,			@gamecost		= gamecost,
		@templistidx1	= templistidx1, 	@templistidx2	= templistidx2,
		@randserial 	= randserial
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	select 'DEBUG 3-2 유저정보', @gameid gameid, @blockstate blockstate, @sid sid, @cashcost cashcost, @gamecost gamecost, @randserial randserial

	if(@gameid != '')
		begin
			------------------------------------------------
			-- 유저보유템(tUserItem)
			------------------------------------------------
			select
				@itemcode 	= itemcode,
				@cnt 		= cnt
			from dbo.tUserItem
			where gameid = @gameid and listidx = @listidx_
			select 'DEBUG 보유템', @listidx_ listidx_, @itemcode itemcode, @cnt cnt

			if( @itemcode != -1 )
				begin
					------------------------------------------------
					--  아이템(tItemInfo) > 종류
					------------------------------------------------
					select
						@subcategory 	= subcategory
					from dbo.tItemInfo
					where itemcode = @itemcode
					select 'DEBUG 템정보.', @itemcode itemcode, @subcategory subcategory
				end
		end

	------------------------------------------------
	-- 3-3. 각 조건별 분기
	------------------------------------------------
	if( @gameid = '' )
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR 아이디가 존재하지 않는다.'
			select 'DEBUG ' + @comment
		END
	else if ( @blockstate = @BLOCK_STATE_YES )
		BEGIN
			-- 블럭유저인가?
			set @nResult_ 	= @RESULT_ERROR_BLOCK_USER
			set @comment 	= '블럭처리된 아이디입니다.'
			select 'DEBUG ', @comment
		END
	else if ( @sid_ != @sid )
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_SESSION_ID_EXPIRE_LOGOUT
			set @comment 	= 'ERROR 세션이 만기 되었습니다. (로그아웃 시켜주세요.)'
			select 'DEBUG ' + @comment
		END
	else if ( @itemcode = -1 )
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_ITEMCODE
			set @comment = 'ERROR 아이템을 찾지 못했습니다.(1)'
		END
	else if ( @subcategory not in (@ITEM_SUBCATEGORY_BOX_WEAR, @ITEM_SUBCATEGORY_BOX_PIECE, @ITEM_SUBCATEGORY_BOX_ADVICE, @ITEM_SUBCATEGORY_RANDOM_CASHCOST_BOX))
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_ITEMCODE
			set @comment = 'ERROR 아이템을 찾지 못했습니다.(2)'
		END
	else if ( @randserial_ = @randserial )
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 박스를 오픈했습니다.(중복)'

			insert into @tTempTable( listidx ) values( @templistidx1 )
			insert into @tTempTable( listidx ) values( @templistidx2 )

		END
	else if ( @cnt <= 0 )
		BEGIN
			set @nResult_ = @RESULT_ERROR_ITEM_LACK
			set @comment = 'ERROR 아이템이 부족합니다.'
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 박스를 오픈했습니다.'
			select 'DEBUG ' + @comment

			if( @subcategory = @ITEM_SUBCATEGORY_BOX_WEAR )
				begin
					select 'DEBUG 장비박스 오픈'
				end
			else if( @subcategory = @ITEM_SUBCATEGORY_BOX_PIECE )
				begin
					select 'DEBUG 조각박스 오픈'
				end
			else if( @subcategory = @ITEM_SUBCATEGORY_BOX_ADVICE )
				begin
					select 'DEBUG 3 조언패키지박스 오픈'
					------------------------------------------------
					-- 3-1. 조언박스 오픈 확률 확인.
					--    7% -> 코치의 조언 주문서(4601)
					--    3% -> 감독의 조언 주문서(4602)
					--   90% -> 꽝.
					------------------------------------------------
					set @randsum 	= 100
					set @rand 		= dbo.fnu_GetRandom(0, @randsum)
					select 'DEBUG ', @randsum randsum, @rand rand
					if( @rand < 7 )
						begin
							select 'DEBUG 코치의 조언획득'
							set @itemcodenew 	= @ITEMCODE_COACH_ADVICE
							set @openstate 		= @BOX_OPEN_STATE_SUCCESS
						end
					else if( @rand < (7+3) )
						begin
							select 'DEBUG 감독의 조언획득'
							set @itemcodenew 	= @ITEMCODE_DIRECTOR_ADVICE
							set @openstate 		= @BOX_OPEN_STATE_SUCCESS
						end
					else
						begin
							select 'DEBUG 꽝'
							set @itemcodenew 	= -1
							set @openstate 		= @BOX_OPEN_STATE_FAIL
						end

					------------------------------------------------
					-- 3-2. 아이템 지급하기.
					------------------------------------------------
					if( @itemcodenew != -1 )
						begin
							set @invenkind 	= dbo.fnu_GetInvenFromSubCategory(@ITEM_SUBCATEGORY_SCROLL_COMMISSION)
							select 'DEBUG ', @invenkind invenkind

							exec dbo.spu_ToUserItem @gameid_, @invenkind, @subcategory, @itemcodenew, 1, @DEFINE_HOW_GET_BOX_OPEN, @randserial_, @nResult2_ = @listidxrtn OUTPUT
							select 'DEBUG 아이템지급', @gameid_ gameid_, @invenkind invenkind, @subcategory subcategory
						end
					select 'DEBUG ', @randsum randsum, @rand rand, @itemcodenew itemcodenew, @openstate openstate, @listidxrtn listidxrtn


					------------------------------------------------
					-- 3-4. 박스감소.
					------------------------------------------------
					insert into @tTempTable( listidx ) values( @listidx_ )
					insert into @tTempTable( listidx ) values( @listidxrtn )

				end
			else if( @subcategory = @ITEM_SUBCATEGORY_RANDOM_CASHCOST_BOX )
				begin
					select 'DEBUG 캐쉬박스 오픈'
				end

			------------------------------------------------
			-- 박스감소.
			------------------------------------------------
			select 'DEBUG 수량감소', @listidx_ listidx_
			update dbo.tUserItem
				set
					cnt = cnt - 1
			where gameid = @gameid and listidx = @listidx_

			------------------------------------------------
			-- 유저정보
			------------------------------------------------
			update dbo.tUserMaster
				set
					--cashcost		= @cashcost,		gamecost 		= @gamecost,
					templistidx1	= @listidx_, 	templistidx2		= @listidxrtn,
					randserial 		= @randserial_
			from dbo.tUserMaster
			where gameid = @gameid_
		END


	--------------------------------------------------------------
	-- 결과전송.
	--------------------------------------------------------------
	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost, @openstate openstate


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

