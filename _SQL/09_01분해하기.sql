/*
-- 조각 분해
exec spu_ItemDisapart 'mtxxxx3', '049000s1i0n7t8445289', 333, 82, 7711, -1	-- 돌 헬멧 조각.
exec spu_ItemDisapart 'mtxxxx3', '049000s1i0n7t8445289', 333, 82, 7712, -1
exec spu_ItemDisapart 'mtxxxx3', '049000s1i0n7t8445289', 333, 87, 7713, -1	-- 동 헬멧.
exec spu_ItemDisapart 'mtxxxx3', '049000s1i0n7t8445289', 333, 87, 7714, -1
exec spu_ItemDisapart 'mtxxxx3', '049000s1i0n7t8445289', 333, 90, 7715, -1	-- 은 헬멧.
exec spu_ItemDisapart 'mtxxxx3', '049000s1i0n7t8445289', 333, 90, 7716, -1
exec spu_ItemDisapart 'mtxxxx3', '049000s1i0n7t8445289', 333, 94, 7717, -1	-- 금 헬멧.
exec spu_ItemDisapart 'mtxxxx3', '049000s1i0n7t8445289', 333, 94, 7718, -1
exec spu_ItemDisapart 'mtxxxx3', '049000s1i0n7t8445289', 333, 98, 7719, -1	-- 티타늄 헬멧.
exec spu_ItemDisapart 'mtxxxx3', '049000s1i0n7t8445289', 333, 98, 7710, -1
*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_ItemDisapart', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_ItemDisapart;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_ItemDisapart
	@gameid_								varchar(20),					-- 게임아이디
	@password_								varchar(20),
	@sid_									int,
	@listidxpiece_							int,
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
	declare @RESULT_ERROR_UPGRADE_FULL			int				set @RESULT_ERROR_UPGRADE_FULL			= -35			--업그레이드가 풀로되었다.

	-- 기타오류
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- 아이템코드못찾음
	declare @RESULT_ERROR_PARAMETER				int				set @RESULT_ERROR_PARAMETER				= -122			-- 파라미터오류.
	declare @RESULT_ERROR_SESSION_ID_EXPIRE_LOGOUT	int			set @RESULT_ERROR_SESSION_ID_EXPIRE_LOGOUT	= -151		-- 세션이 만료되었습니다.
	declare @RESULT_ERROR_DIFFERENT_GRADE		int				set @RESULT_ERROR_DIFFERENT_GRADE		= -154			-- 등급이 다릅니다.
	declare @RESULT_ERROR_WEARING_NOT_UPGRADE	int				set @RESULT_ERROR_WEARING_NOT_UPGRADE	= -216		-- 착용중인 템은 업그레이드 불가능합니다.

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
	declare @EVOLVE_STATE_SUCCESS				int					set @EVOLVE_STATE_SUCCESS					= 1
	declare @EVOLVE_STATE_FAIL_ONLY				int					set @EVOLVE_STATE_FAIL_ONLY					= -1
	declare @EVOLVE_STATE_FAIL_EXPIRE			int					set @EVOLVE_STATE_FAIL_EXPIRE				= -2

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

	declare @itemcode				int					set @itemcode			= -1
	declare @cnt					int					set @cnt				= 0
	declare @gamecostorg			int					set @gamecostorg 		= 0
	declare @gamecostplus			int					set @gamecostplus		= @EVOLVE_STATE_FAIL_EXPIRE

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
	--select 'DEBUG 1 입력정보', @gameid_ gameid_, @password_ password_, @sid_ sid_, @listidxpiece_ listidxpiece_, @randserial_ randserial_

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	select
		@gameid 			= gameid,			@blockstate		= blockstate,		@sid			= sid,
		@cashcost			= cashcost,			@gamecost		= gamecost,
		@gamecostplus 		= tempplusgamecost,
		@randserial 		= randserial
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 3-2 유저정보', @gameid gameid, @blockstate blockstate, @sid sid, @cashcost cashcost, @gamecost gamecost, @randserial randserial, @gamecostplus gamecostplus

	if(@gameid != '' and @listidxpiece_ != -1 )
		begin
			------------------------------------------------
			-- 유저보유템(tUserItem)
			------------------------------------------------
			select @itemcode = itemcode, @cnt = cnt from dbo.tUserItem where gameid = @gameid and listidx = @listidxpiece_
			--select 'DEBUG 3-5보유템(조각)', @listidxpiece_ listidxpiece_, @itemcode itemcode, @cnt cnt

			select @gamecostorg = cashcost from dbo.tItemInfo where itemcode = @itemcode and category = @ITEM_MAINCATEGORY_PIECEPART
			--select 'DEBUG 3-5보유템(조각) > 분해.', @itemcode itemcode, @gamecostorg gamecostorg
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
			set @comment = 'SUCCESS 분해을 시도합니다.(중복)'

			insert into @tTempTable( listidx ) values( @listidxpiece_ )
		END
	else if ( @itemcode = -1 )
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_ITEMCODE
			set @comment = 'ERROR 아이템을 찾지 못했습니다.'
		END
	else if ( @cnt <= 0 )
		BEGIN
			set @nResult_ = @RESULT_ERROR_ITEM_LACK
			set @comment = 'ERROR 아이템이 부족합니다.'
		END
	else if ( @gamecostorg <= 0 )
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_ITEMCODE
			set @comment = 'ERROR 아이템을 찾지 못했습니다.'
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 분해을 시도합니다.'
			--select 'DEBUG ' + @comment

			------------------------------------------------
			-- 1. 분해 80%
			------------------------------------------------
			--select 'DEBUG (전)', @gamecost gamecost
			set @gamecostplus = @gamecostorg * 80 / 100
			set @gamecost = @gamecost + @gamecostplus
			--select 'DEBUG (후)', @gamecost gamecost, @gamecostorg gamecostorg, @gamecostplus gamecostplus

			------------------------------------------------
			-- 1-2. 아이템 감소.
			------------------------------------------------
			----select 'DEBUG 조각수량감소', @listidxpiece_ listidxpiece_
			update dbo.tUserItem set cnt = cnt - 1 where gameid = @gameid and listidx = @listidxpiece_

			------------------------------------------------
			-- 1-4. 출력로고.
			------------------------------------------------
			insert into @tTempTable( listidx ) values( @listidxpiece_   )

			------------------------------------------------
			--
			------------------------------------------------
			exec spu_DayLogInfoStatic 27, 1				-- 일 분해

			------------------------------------------------
			-- 유저정보
			------------------------------------------------
			update dbo.tUserMaster
				set
					gamecost 		= @gamecost,
					tempplusgamecost= @gamecostplus,
					randserial 		= @randserial_
			from dbo.tUserMaster where gameid = @gameid_
		END


	--------------------------------------------------------------
	-- 결과전송.
	--------------------------------------------------------------
	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost,
		   @gamecostplus gamecostplus

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

