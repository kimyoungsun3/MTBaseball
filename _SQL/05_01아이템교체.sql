/*
-- 1. 아이템을 장착할때 해당 아이템 클릭 (해당아이템 listidx)
-- 2. 아이템을 벗을 때는 캐릭터의 창에서 아이템을 클릭(기본 아이템 listidx)
exec spu_ItemChange 'mtxxxx3', '049000s1i0n7t8445289', 333,   1, 7711, -1	-- 기본 헬멧
exec spu_ItemChange 'mtxxxx3', '049000s1i0n7t8445289', 333,  26, 7712, -1	-- 돌 헬멧
exec spu_ItemChange 'mtxxxx3', '049000s1i0n7t8445289', 333,  39, 7713, -1	-- 티타늄 헬멧
exec spu_ItemChange 'mtxxxx3', '049000s1i0n7t8445289', 333,  40, 7714, -1	--
exec spu_ItemChange 'mtxxxx3', '049000s1i0n7t8445289', 333,  41, 7715, -1	--
exec spu_ItemChange 'mtxxxx3', '049000s1i0n7t8445289', 333,  42, 7716, -1	--
exec spu_ItemChange 'mtxxxx3', '049000s1i0n7t8445289', 333,  43, 7717, -1	--
exec spu_ItemChange 'mtxxxx3', '049000s1i0n7t8445289', 333,  44, 7718, -1	--
exec spu_ItemChange 'mtxxxx3', '049000s1i0n7t8445289', 333,  45, 7719, -1	--
exec spu_ItemChange 'mtxxxx3', '049000s1i0n7t8445289', 333,  46, 7711, -1	--
exec spu_ItemChange 'mtxxxx3', '049000s1i0n7t8445289', 333,  47, 7712, -1	--
exec spu_ItemChange 'mtxxxx3', '049000s1i0n7t8445289', 333,  48, 7713, -1	--
exec spu_ItemChange 'mtxxxx3', '049000s1i0n7t8445289', 333,  49, 7714, -1	--
exec spu_ItemChange 'mtxxxx3', '049000s1i0n7t8445289', 333,  50, 7715, -1	--
exec spu_ItemChange 'mtxxxx3', '049000s1i0n7t8445289', 333,  51, 7716, -1	--

exec spu_ItemChange 'mtxxxx3', '049000s1i0n7t8445289', 333,  26, 7773, -1	-- 돌 헬멧
exec spu_ItemChange 'mtxxxx3', '049000s1i0n7t8445289', 333,  27, 7774, -1	--
exec spu_ItemChange 'mtxxxx3', '049000s1i0n7t8445289', 333,  28, 7775, -1	--
exec spu_ItemChange 'mtxxxx3', '049000s1i0n7t8445289', 333,  29, 7776, -1	--
exec spu_ItemChange 'mtxxxx3', '049000s1i0n7t8445289', 333,  30, 7777, -1	--
exec spu_ItemChange 'mtxxxx3', '049000s1i0n7t8445289', 333,  31, 7778, -1	--
exec spu_ItemChange 'mtxxxx3', '049000s1i0n7t8445289', 333,  32, 7779, -1	--
exec spu_ItemChange 'mtxxxx3', '049000s1i0n7t8445289', 333,  33, 7771, -1	--
exec spu_ItemChange 'mtxxxx3', '049000s1i0n7t8445289', 333,  34, 7772, -1	--
exec spu_ItemChange 'mtxxxx3', '049000s1i0n7t8445289', 333,  35, 7773, -1	--
exec spu_ItemChange 'mtxxxx3', '049000s1i0n7t8445289', 333,  36, 7774, -1	--
exec spu_ItemChange 'mtxxxx3', '049000s1i0n7t8445289', 333,  37, 7775, -1	--
exec spu_ItemChange 'mtxxxx3', '049000s1i0n7t8445289', 333,  38, 7776, -1	--


exec spu_ItemChange 'mtxxxx3', '049000s1i0n7t8445289', 333, 21, 7778, -1	-- 조각으로 변경 -> error
exec spu_ItemChange 'mtxxxx3', '049000s1i0n7t8445289', 333, 24, 7778, -1	-- 닉네임변경권 -> error
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
	declare @itemcode				int					set @itemcode			= -1
	declare @randserial				varchar(20)			set @randserial			= '-1'
	declare @subcategory			int					set @subcategory		= -1
	declare @expincrease100			int					set @expincrease100		= 0
	declare @setcode				int					set @setcode			= -1
	declare @setplusexp100			int					set @setplusexp100		= 0

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
	declare @helmetsetnum			int 				set @helmetsetnum 		= -1
	declare @shirtsetnum			int 				set @shirtsetnum 		= -1
	declare @pantssetnum			int 				set @pantssetnum 		= -1
	declare @glovessetnum			int 				set @glovessetnum 		= -1
	declare @shoessetnum			int 				set @shoessetnum 		= -1
	declare @batsetnum				int 				set @batsetnum 			= -1
	declare @ballsetnum				int 				set @ballsetnum 		= -1
	declare @gogglesetnum			int 				set @gogglesetnum 		= -1
	declare @wristbandsetnum		int 				set @wristbandsetnum 	= -1
	declare @elbowpadsetnum			int 				set @elbowpadsetnum 	= -1
	declare @beltsetnum				int 				set @beltsetnum 		= -1
	declare @kneepadsetnum			int 				set @kneepadsetnum 		= -1
	declare @sockssetnum			int 				set @sockssetnum 		= -1

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	set @comment = 'ERROR 아이템을 변경할 수 없습니다.(-1)'
	--select 'DEBUG 1 입력정보', @gameid_ gameid_, @password_ password_, @sid_ sid_, @listidx_ listidx_, @randserial_ randserial_

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	select
		@gameid 		= gameid,			@blockstate		= blockstate,		@sid			= sid,
		@cashcost		= cashcost,			@gamecost		= gamecost,
		@wearplusexp	= wearplusexp,		@randserial 	= randserial,

		@helmetlistidx 	= helmetlistidx, 	@shirtlistidx 	= shirtlistidx, 	@pantslistidx 	= pantslistidx, @gloveslistidx 	= gloveslistidx,
		@shoeslistidx 	= shoeslistidx, 	@batlistidx 	= batlistidx, 		@balllistidx 	= balllistidx, 	@gogglelistidx 	= gogglelistidx,
		@wristbandlistidx= wristbandlistidx,@elbowpadlistidx= elbowpadlistidx, 	@beltlistidx 	= beltlistidx, 	@kneepadlistidx = kneepadlistidx, 	@sockslistidx = sockslistidx,

		@helmetexp 		= helmetexp, 		@shirtexp 		= shirtexp, 		@pantsexp 		= pantsexp, 	@glovesexp 		= glovesexp,
		@shoesexp 		= shoesexp, 		@batexp 		= batexp, 			@ballexp 		= ballexp, 		@goggleexp 		= goggleexp,
		@wristbandexp 	= wristbandexp, 	@elbowpadexp 	= elbowpadexp, 		@beltexp 		= beltexp, 		@kneepadexp 	= kneepadexp, 		@socksexp 		= socksexp,

		@helmetsetnum 	= helmetsetnum, 	@shirtsetnum 	= shirtsetnum, 		@pantssetnum 	= pantssetnum, 	@glovessetnum 	= glovessetnum,
		@shoessetnum 	= shoessetnum, 		@batsetnum 		= batsetnum, 		@ballsetnum 	= ballsetnum, 	@gogglesetnum 	= gogglesetnum,
		@wristbandsetnum= wristbandsetnum, 	@elbowpadsetnum = elbowpadsetnum, 	@beltsetnum 	= beltsetnum, 	@kneepadsetnum 	= kneepadsetnum, 	@sockssetnum 	= sockssetnum
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 3-2 유저정보', @gameid gameid, @blockstate blockstate, @sid sid, @cashcost cashcost, @gamecost gamecost, @wearplusexp wearplusexp
	--select 'DEBUG 파트 listidx', @helmetlistidx helmetlistidx, 	@shirtlistidx shirtlistidx, @pantslistidx pantslistidx, @gloveslistidx gloveslistidx, 	@shoeslistidx shoeslistidx, @batlistidx batlistidx, @balllistidx balllistidx, 	@gogglelistidx gogglelistidx, 	@wristbandlistidx wristbandlistidx, @elbowpadlistidx elbowpadlistidx, 	@beltlistidx beltlistidx, 	@kneepadlistidx kneepadlistidx, @sockslistidx sockslistidx
	--select 'DEBUG 파트 추가경험치', @wearplusexp wearplusexp, @helmetexp helmetexp, @shirtexp shirtexp, @pantsexp pantsexp, @glovesexp glovesexp, @shoesexp shoesexp, @batexp batexp, @ballexp ballexp, @goggleexp goggleexp, @wristbandexp wristbandexp, @elbowpadexp elbowpadexp, @beltexp beltexp, @kneepadexp kneepadexp, @socksexp socksexp
	--select 'DEBUG 파트 세트번호', @helmetsetnum helmetsetnum, @shirtsetnum shirtsetnum, @pantssetnum pantssetnum, @glovessetnum glovessetnum, @shoessetnum shoessetnum, @batsetnum batsetnum, @ballsetnum ballsetnum, @gogglesetnum gogglesetnum, @wristbandsetnum wristbandsetnum, @elbowpadsetnum elbowpadsetnum, @beltsetnum beltsetnum, @kneepadsetnum kneepadsetnum, @sockssetnum sockssetnum


	if(@gameid != '')
		begin
			------------------------------------------------
			-- 유저보유템(tUserItem)
			------------------------------------------------
			select
				@itemcode = itemcode
			from dbo.tUserItem
			where gameid = @gameid and listidx = @listidx_ and invenkind = @USERITEM_INVENKIND_WEAR
			----select 'DEBUG 보유템', @listidx_ listidx_, @itemcode itemcode


			if( @itemcode != -1 )
				begin
					------------------------------------------------
					--  아이템(tItemInfo) > 종류
					------------------------------------------------
					select
						@subcategory 	= subcategory,
						@expincrease100 = param3, 		@setcode = param4
					from dbo.tItemInfo
					where itemcode = @itemcode and category = @ITEM_MAINCATEGORY_WEARPART
					--select 'DEBUG 템정보.', @itemcode itemcode, @subcategory subcategory, @expincrease100 expincrease100, @setcode setcode
				end
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
	else if ( @itemcode = -1 )
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_ITEMCODE
			set @comment = 'ERROR 아이템을 찾지 못했습니다.(1)'
		END
	else if (@subcategory not in (@ITEM_SUBCATEGORY_WEAR_HELMET, @ITEM_SUBCATEGORY_WEAR_SHIRT, @ITEM_SUBCATEGORY_WEAR_PANTS, @ITEM_SUBCATEGORY_WEAR_GLOVES, @ITEM_SUBCATEGORY_WEAR_SHOES, @ITEM_SUBCATEGORY_WEAR_BAT, @ITEM_SUBCATEGORY_WEAR_BALL	, @ITEM_SUBCATEGORY_WEAR_GOGGLE, @ITEM_SUBCATEGORY_WEAR_WRISTBAND, @ITEM_SUBCATEGORY_WEAR_ELBOWPAD, @ITEM_SUBCATEGORY_WEAR_BELT, @ITEM_SUBCATEGORY_WEAR_KNEEPAD, @ITEM_SUBCATEGORY_WEAR_SOCKS))
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_ITEMCODE
			set @comment = 'ERROR 아이템을 찾지 못했습니다.(2)'
		END
	else if ( @randserial_ = @randserial )
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 장비를 교체했습니다.(2)'
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 장비를 교체했습니다.'
			--select 'DEBUG ' + @comment

			------------------------------------------------
			-- 유저정보
			------------------------------------------------
			if( @subcategory = @ITEM_SUBCATEGORY_WEAR_HELMET )
				begin
					set @helmetlistidx 		= @listidx_
					set @helmetexp			= @expincrease100
					set @helmetsetnum 		= @setcode
					--select 'DEBUG 헬멧교체'
				end
			else if( @subcategory = @ITEM_SUBCATEGORY_WEAR_SHIRT )
				begin
					set @shirtlistidx 		= @listidx_
					set @shirtexp			= @expincrease100
					set @shirtsetnum 		= @setcode
					--select 'DEBUG shirt 교체'
				end
			else if( @subcategory = @ITEM_SUBCATEGORY_WEAR_PANTS )
				begin
					set @pantslistidx 		= @listidx_
					set @pantsexp			= @expincrease100
					set @pantssetnum 		= @setcode
					--select 'DEBUG pants 교체'
				end
			else if( @subcategory = @ITEM_SUBCATEGORY_WEAR_GLOVES )
				begin
					set @gloveslistidx 		= @listidx_
					set @glovesexp			= @expincrease100
					set @glovessetnum 		= @setcode
					--select 'DEBUG gloves 교체'
				end
			else if( @subcategory = @ITEM_SUBCATEGORY_WEAR_SHOES )
				begin
					set @shoeslistidx 		= @listidx_
					set @shoesexp			= @expincrease100
					set @shoessetnum 		= @setcode
					--select 'DEBUG shoes 교체'
				end
			else if( @subcategory = @ITEM_SUBCATEGORY_WEAR_BAT )
				begin
					set @batlistidx	 		= @listidx_
					set @batexp				= @expincrease100
					set @batsetnum 			= @setcode
					--select 'DEBUG bat 교체'
				end
			else if( @subcategory = @ITEM_SUBCATEGORY_WEAR_BALL )
				begin
					set @balllistidx 		= @listidx_
					set @ballexp			= @expincrease100
					set @ballsetnum 		= @setcode
					--select 'DEBUG ball 교체'
				end
			else if( @subcategory = @ITEM_SUBCATEGORY_WEAR_GOGGLE )
				begin
					set @gogglelistidx 		= @listidx_
					set @goggleexp			= @expincrease100
					set @gogglesetnum 		= @setcode
					--select 'DEBUG goggle 교체'
				end
			else if( @subcategory = @ITEM_SUBCATEGORY_WEAR_WRISTBAND )
				begin
					set @wristbandlistidx 	= @listidx_
					set @wristbandexp		= @expincrease100
					set @wristbandsetnum 	= @setcode
					--select 'DEBUG wristband 교체'
				end
			else if( @subcategory = @ITEM_SUBCATEGORY_WEAR_ELBOWPAD )
				begin
					set @elbowpadlistidx 	= @listidx_
					set @elbowpadexp		= @expincrease100
					set @elbowpadsetnum 	= @setcode
					--select 'DEBUG elbowpad 교체'
				end
			else if( @subcategory = @ITEM_SUBCATEGORY_WEAR_BELT )
				begin
					set @beltlistidx 		= @listidx_
					set @beltexp			= @expincrease100
					set @beltsetnum 		= @setcode
					--select 'DEBUG belt 교체'
				end
			else if( @subcategory = @ITEM_SUBCATEGORY_WEAR_KNEEPAD )
				begin
					set @kneepadlistidx 	= @listidx_
					set @kneepadexp			= @expincrease100
					set @kneepadsetnum 		= @setcode
					--select 'DEBUG kneepad 교체'
				end
			else if( @subcategory = @ITEM_SUBCATEGORY_WEAR_SOCKS )
				begin
					set @sockslistidx 		= @listidx_
					set @socksexp			= @expincrease100
					set @sockssetnum 		= @setcode
					--select 'DEBUG socks 교체'
				end
			set @wearplusexp = @helmetexp + @shirtexp + @pantsexp + @glovesexp + @shoesexp + @batexp + @ballexp + @goggleexp + @wristbandexp + @elbowpadexp + @beltexp + @kneepadexp + @socksexp
			--select 'DEBUG 파트 추가경험치', @wearplusexp wearplusexp, @helmetexp helmetexp, @shirtexp shirtexp, @pantsexp pantsexp, @glovesexp glovesexp, @shoesexp shoesexp, @batexp batexp, @ballexp ballexp, @goggleexp goggleexp, @wristbandexp wristbandexp, @elbowpadexp elbowpadexp, @beltexp beltexp, @kneepadexp kneepadexp, @socksexp socksexp
			--select 'DEBUG 파트 세트번호', @helmetsetnum helmetsetnum, @shirtsetnum shirtsetnum, @pantssetnum pantssetnum, @glovessetnum glovessetnum, @shoessetnum shoessetnum, @batsetnum batsetnum, @ballsetnum ballsetnum, @gogglesetnum gogglesetnum, @wristbandsetnum wristbandsetnum, @elbowpadsetnum elbowpadsetnum, @beltsetnum beltsetnum, @kneepadsetnum kneepadsetnum, @sockssetnum sockssetnum


			------------------------------------------------
			-- 세트 추가경험치.
			------------------------------------------------
			if(     @helmetsetnum 	!= -1
				and	@helmetsetnum 	= @shirtsetnum
				and @shirtsetnum 	= @pantssetnum
				and @pantssetnum 	= @glovessetnum
				and @glovessetnum	= @shoessetnum
				and @shoessetnum 	= @batsetnum
				and @batsetnum 	= @ballsetnum
				and @ballsetnum 	= @gogglesetnum
				and @gogglesetnum 	= @wristbandsetnum
				and @wristbandsetnum = @elbowpadsetnum
				and @elbowpadsetnum= @beltsetnum
				and @beltsetnum 	= @kneepadsetnum
				and @kneepadsetnum = @sockssetnum
			)
				begin
					------------------------------------------------
					--  아이템(tItemInfo) > 종류
					------------------------------------------------
					select
						@setplusexp100 = param5
					from dbo.tItemInfo
					where itemcode = (
						select
							top 1 itemcode
						from dbo.tUserItem
						where gameid = @gameid and listidx = @helmetlistidx )

					set @wearplusexp = @wearplusexp + @setplusexp100
					--select 'DEBUG 세트효과', @setplusexp100 setplusexp100, @wearplusexp wearplusexp
				end

			------------------------------------------------
			-- 유저정보
			------------------------------------------------
			update dbo.tUserMaster
				set
					wearplusexp		= @wearplusexp,		setplusexp		= @setplusexp100,
					randserial 		= @randserial_,

					helmetlistidx 	= @helmetlistidx, 	shirtlistidx 	= @shirtlistidx, 	pantslistidx 	= @pantslistidx, 	gloveslistidx 	= @gloveslistidx,
					shoeslistidx 	= @shoeslistidx, 	batlistidx 		= @batlistidx, 		balllistidx 	= @balllistidx, 	gogglelistidx 	= @gogglelistidx,
					wristbandlistidx= @wristbandlistidx,elbowpadlistidx	= @elbowpadlistidx, beltlistidx 	= @beltlistidx, 	kneepadlistidx 	= @kneepadlistidx, 	sockslistidx = @sockslistidx,

					helmetexp 		= @helmetexp, 		shirtexp 		= @shirtexp, 		pantsexp 		= @pantsexp, 		glovesexp 		= @glovesexp,
					shoesexp 		= @shoesexp, 		batexp 			= @batexp, 			ballexp 		= @ballexp, 		goggleexp 		= @goggleexp,
					wristbandexp	= @wristbandexp,	elbowpadexp		= @elbowpadexp, 	beltexp 		= @beltexp, 		kneepadexp 		= @kneepadexp, 		socksexp 	= @socksexp,

					helmetsetnum 	= @helmetsetnum, 	shirtsetnum 	= @shirtsetnum, 	pantssetnum 	= @pantssetnum, 	glovessetnum 	= @glovessetnum,
					shoessetnum 	= @shoessetnum, 	batsetnum 		= @batsetnum, 		ballsetnum 		= @ballsetnum, 		gogglesetnum 	= @gogglesetnum,
					wristbandsetnum	= @wristbandsetnum,	elbowpadsetnum	= @elbowpadsetnum,	beltsetnum 		= @beltsetnum, 		kneepadsetnum 	= @kneepadsetnum, 	sockssetnum = @sockssetnum
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

