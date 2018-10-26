/*
exec spu_ItemChange 'mtxxxx3', '049000s1i0n7t8445289', 333, 1, -1	-- 1 번호로 바꿈...
*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_ItemChange', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_ItemChange;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_ItemChange
	@gameid_								varchar(20),					-- 게임아이디
	@password_								varchar(20),
	@sid_									int,
	@listidx_								int,
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

	-- MT 아이템별 인벤분류
	declare @USERITEM_INVENKIND_WEAR			int 				set @USERITEM_INVENKIND_WEAR				= 1
	declare @USERITEM_INVENKIND_PIECE			int 				set @USERITEM_INVENKIND_PIECE				= 2
	declare @USERITEM_INVENKIND_CONSUME			int 				set @USERITEM_INVENKIND_CONSUME				= 3

	-- MT 아이템 대분류
	declare @ITEM_MAINCATEGORY_WEARPART			int					set @ITEM_MAINCATEGORY_WEARPART 			= 1 	-- 장착템(1)
	--declare @ITEM_MAINCATEGORY_PIECEPART		int					set @ITEM_MAINCATEGORY_PIECEPART			= 15 	-- 조각템(15)
	--declare @ITEM_MAINCATEGORY_COMSUME		int					set @ITEM_MAINCATEGORY_COMSUME				= 40 	-- 소모품(40)
	--declare @ITEM_MAINCATEGORY_CASHCOST		int					set @ITEM_MAINCATEGORY_CASHCOST 			= 50 	-- 캐쉬선물(50)
	--declare @ITEM_MAINCATEGORY_STATICINFO		int					set @ITEM_MAINCATEGORY_STATICINFO 			= 500 	-- 정보수집(500)
	--declare @ITEM_MAINCATEGORY_LEVELUPREWARD	int					set @ITEM_MAINCATEGORY_LEVELUPREWARD		= 510 	-- 레벨업 보상(510)

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

	-- 아이템 기본 listidx.
	declare @BASE_HELMET_LISTIDX				int 				set @BASE_HELMET_LISTIDX					= 1
	declare @BASE_SHIRT_LISTIDX					int 				set @BASE_SHIRT_LISTIDX						= 2
	declare @BASE_PANTS_LISTIDX					int 				set @BASE_PANTS_LISTIDX						= 3
	declare @BASE_GLOVES_LISTIDX				int 				set @BASE_GLOVES_LISTIDX					= 4
	declare @BASE_SHOES_LISTIDX					int 				set @BASE_SHOES_LISTIDX						= 5
	declare @BASE_BAT_LISTIDX					int 				set @BASE_BAT_LISTIDX						= 6
	declare @BASE_BALL_LISTIDX					int 				set @BASE_BALL_LISTIDX						= 7
	declare @BASE_GOGGLE_LISTIDX				int 				set @BASE_GOGGLE_LISTIDX					= 8
	declare @BASE_WRISTBAND_LISTIDX				int 				set @BASE_WRISTBAND_LISTIDX					= 9
	declare @BASE_ELBOWPAD_LISTIDX				int 				set @BASE_ELBOWPAD_LISTIDX					= 10
	declare @BASE_BELT_LISTIDX					int 				set @BASE_BELT_LISTIDX						= 11
	declare @BASE_KNEEPAD_LISTIDX				int 				set @BASE_KNEEPAD_LISTIDX					= 12
	declare @BASE_SOCKS_LISTIDX					int 				set @BASE_SOCKS_LISTIDX						= 13


	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @comment				varchar(512)		set @comment			= ''
	declare @gameid					varchar(20)			set @gameid				= ''
	declare @cashcost				int					set @cashcost			= 0
	declare @gamecost				int					set @gamecost			= 0
	declare @sid					int					set @sid				= -1
	declare @wearplusexp			int					set @wearplusexp		= 0
	declare @blockstate				int					set @blockstate			= @BLOCK_STATE_YES

	-- (게임변수 : 착용아이템 인덱스리스트)
	declare @helmetlistidx			int 				set @helmetlistidx 		= @BASE_HELMET_LISTIDX
	declare @shirtlistidx			int 				set @shirtlistidx		= @BASE_SHIRT_LISTIDX
	declare @pantslistidx			int 				set @pantslistidx		= @BASE_PANTS_LISTIDX
	declare @gloveslistidx			int 				set @gloveslistidx		= @BASE_GLOVES_LISTIDX
	declare @shoeslistidx			int 				set @shoeslistidx		= @BASE_SHOES_LISTIDX
	declare @batlistidx				int 				set @batlistidx			= @BASE_BAT_LISTIDX
	declare @balllistidx			int 				set @balllistidx		= @BASE_BALL_LISTIDX
	declare @gogglelistidx			int 				set @gogglelistidx		= @BASE_GOGGLE_LISTIDX
	declare @wristbandlistidx		int 				set @wristbandlistidx	= @BASE_WRISTBAND_LISTIDX
	declare @elbowpadlistidx		int 				set @elbowpadlistidx	= @BASE_ELBOWPAD_LISTIDX
	declare @beltlistidx			int 				set @beltlistidx		= @BASE_BELT_LISTIDX
	declare @kneepadlistidx			int 				set @kneepadlistidx		= @BASE_KNEEPAD_LISTIDX
	declare @sockslistidx			int 				set @sockslistidx		= @BASE_SOCKS_LISTIDX

	-- 추가경험치값 (만분률값임... 100 -> 1%를 의미...)
	declare @helmetexp				int 				set @helmetexp 			= 0
	declare @shirtexp				int 				set @shirtexp 			= 0
	declare @pantsexp				int 				set @pantsexp 			= 0
	declare @glovesexp				int 				set @glovesexp 			= 0
	declare @shoesexp				int 				set @shoesexp 			= 0
	declare @batexp					int 				set @batexp 			= 0
	declare @ballexp				int 				set @ballexp 			= 0
	declare @goggleexp				int 				set @goggleexp 			= 0
	declare @wristbandexp			int 				set @wristbandexp 		= 0
	declare @elbowpadexp			int 				set @elbowpadexp 		= 0
	declare @beltexp				int 				set @beltexp 			= 0
	declare @kneepadexp				int 				set @kneepadexp 		= 0
	declare @socksexp				int 				set @socksexp 			= 0

	-- 세트번호.... -1(의미없음.), 0, 1, 2, 3, 4번까지 있음
	declare @helmetset				int 				set @helmetset 			= -1
	declare @shirtset				int 				set @shirtset 			= -1
	declare @pantsset				int 				set @pantsset 			= -1
	declare @glovesset				int 				set @glovesset 			= -1
	declare @shoesset				int 				set @shoesset 			= -1
	declare @batset					int 				set @batset 			= -1
	declare @ballset				int 				set @ballset 			= -1
	declare @goggleset				int 				set @goggleset 			= -1
	declare @wristbandset			int 				set @wristbandset 		= -1
	declare @elbowpadset			int 				set @elbowpadset 		= -1
	declare @beltset				int 				set @beltset 			= -1
	declare @kneepadset				int 				set @kneepadset 		= -1
	declare @socksset				int 				set @socksset 			= -1

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	select 'DEBUG 1 입력정보', @gameid_ gameid_, @password_ password_, @sid_ sid_, @listidx_ listidx_

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	select
		@gameid 	= gameid,		@blockstate		= blockstate,	@sid			= sid,
		@cashcost	= cashcost,		@gamecost		= gamecost,		@wearplusexp	= wearplusexp,
		@helmetlistidx 	= helmetlistidx, 	@shirtlistidx 	= shirtlistidx, 	@pantslistidx 	= pantslistidx, @gloveslistidx 	= gloveslistidx,
		@shoeslistidx 	= shoeslistidx, 	@batlistidx 	= batlistidx, 		@balllistidx 	= balllistidx, 	@gogglelistidx 	= gogglelistidx,
		@wristbandlistidx= wristbandlistidx,@elbowpadlistidx= elbowpadlistidx, 	@beltlistidx 	= beltlistidx, 	@kneepadlistidx = kneepadlistidx, 	@sockslistidx = sockslistidx,

		@helmetexp 		= helmetexp, 		@shirtexp 		= shirtexp, 		@pantsexp 		= pantsexp, 	@glovesexp 		= glovesexp,
		@shoesexp 		= shoesexp, 		@batexp 		= batexp, 			@ballexp 		= ballexp, 		@goggleexp 		= goggleexp,
		@wristbandexp 	= wristbandexp, 	@elbowpadexp 	= elbowpadexp, 		@beltexp 		= beltexp, 		@kneepadexp 	= kneepadexp, 		@socksexp 	= socksexp,

		@helmetset 		= helmetset, 		@shirtset 		= shirtset, 		@pantsset 		= pantsset, 	@glovesset 		= glovesset,
		@shoesset 		= shoesset, 		@batset 		= batset, 			@ballset 		= ballset, 		@goggleset 		= goggleset,
		@wristbandset 	= wristbandset, 	@elbowpadset 	= elbowpadset, 		@beltset 		= beltset, 		@kneepadset 	= kneepadset, 		@socksset 	= socksset

	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	select 'DEBUG 3-2 유저정보', @gameid gameid, @blockstate blockstate, @sid sid, @cashcost cashcost, @gamecost gamecost, @wearplusexp wearplusexp
	select 'DEBUG ', @helmetlistidx helmetlistidx, 	@shirtlistidx shirtlistidx, @pantslistidx pantslistidx, @gloveslistidx gloveslistidx, 	@shoeslistidx shoeslistidx, @batlistidx batlistidx, @balllistidx balllistidx, 	@gogglelistidx gogglelistidx, 	@wristbandlistidx wristbandlistidx, @elbowpadlistidx elbowpadlistidx, 	@beltlistidx beltlistidx, 	@kneepadlistidx kneepadlistidx, @sockslistidx sockslistidx
	select 'DEBUG ', @helmetexp helmetexp, 			@shirtexp shirtexp, 		@pantsexp pantsexp, 		@glovesexp glovesexp, 			@shoesexp shoesexp, 		@batexp batexp, 		@ballexp ballexp, 			@goggleexp goggleexp, 			@wristbandexp wristbandexp, 		@elbowpadexp elbowpadexp, 			@beltexp beltexp, 			@kneepadexp kneepadexp, 		@socksexp socksexp
	select 'DEBUG ', @helmetset helmetset, 			@shirtset shirtset, 		@pantsset pantsset, 		@glovesset glovesset, 			@shoesset shoesset, 		@batset batset, 		@ballset ballset, 			@goggleset goggleset, 			@wristbandset wristbandset, 		@elbowpadset elbowpadset, 			@beltset beltset, 			@kneepadset kneepadset, 		@socksset socksset


	if(@gameid != '')
		begin
			select 'DEBUG'
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
	else if (@blockstate = @BLOCK_STATE_YES)
		BEGIN
			-- 블럭유저인가?
			set @nResult_ 	= @RESULT_ERROR_BLOCK_USER
			set @comment 	= '블럭처리된 아이디입니다.'
			select 'DEBUG ', @comment
		END
	else if(@sid_ != @sid)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_SESSION_ID_EXPIRE_LOGOUT
			set @comment 	= 'ERROR 세션이 만기 되었습니다. (로그아웃 시켜주세요.)'
			select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 배팅산출했습니다.'
			select 'DEBUG ' + @comment

			------------------------------------------------
			-- 유저정보
			------------------------------------------------
			update dbo.tUserMaster
				set
					wearplusexp	= @wearplusexp,

					helmetlistidx 	= @helmetlistidx, 	shirtlistidx 	= @shirtlistidx, 	pantslistidx 	= @pantslistidx, 	gloveslistidx 	= @gloveslistidx,
					shoeslistidx 	= @shoeslistidx, 	batlistidx 		= @batlistidx, 		balllistidx 	= @balllistidx, 	gogglelistidx 	= @gogglelistidx,
					wristbandlistidx= @wristbandlistidx,elbowpadlistidx	= @elbowpadlistidx, beltlistidx 	= @beltlistidx, 	kneepadlistidx 	= @kneepadlistidx, 	sockslistidx = @sockslistidx,

					helmetexp 	= @helmetexp, 	shirtexp 	= @shirtexp, 	pantsexp 	= @pantsexp, 	glovesexp 	= @glovesexp,
					shoesexp 	= @shoesexp, 	batexp 		= @batexp, 		ballexp 	= @ballexp, 	goggleexp 	= @goggleexp,
					wristbandexp= @wristbandexp,elbowpadexp	= @elbowpadexp, beltexp 	= @beltexp, 	kneepadexp 	= @kneepadexp, 	socksexp = @socksexp,

					helmetset 	= @helmetset, 	shirtset 	= @shirtset, 	pantsset 	= @pantsset, 	glovesset 	= @glovesset,
					shoesset 	= @shoesset, 	batset 		= @batset, 		ballset 	= @ballset, 	goggleset 	= @goggleset,
					wristbandset= @wristbandset,elbowpadset	= @elbowpadset, beltset 	= @beltset, 	kneepadset 	= @kneepadset, 	socksset = @socksset
			from dbo.tUserMaster
			where gameid = @gameid_
		END


	--------------------------------------------------------------
	-- 결과전송.
	--------------------------------------------------------------
	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost


	if(@nResult_ = @RESULT_SUCCESS)
		BEGIN
			select * from dbo.tUserMaster where gameid = @gameid_
		END

	------------------------------------------------
	--	4-2. 유저정보
	------------------------------------------------
	set nocount off
End

