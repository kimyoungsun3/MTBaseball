---------------------------------------------------------------
/*
-- 소모.
exec spu_FVItemQuick 'xxxx9', '049000s1i0n7t8445289',  7, 1, -1	-- 총알
exec spu_FVItemQuick 'xxxx9', '049000s1i0n7t8445289',  7,-1, -1	-- 총알(해제)
exec spu_FVItemQuick 'xxxx9', '049000s1i0n7t8445289',  8, 1, -1	-- 치료제
exec spu_FVItemQuick 'xxxx9', '049000s1i0n7t8445289',  8,-1, -1	-- 치료제(해제)
exec spu_FVItemQuick 'xxxx9', '049000s1i0n7t8445289',  9, 1, -1	-- 일꾼
exec spu_FVItemQuick 'xxxx9', '049000s1i0n7t8445289',  9,-1, -1	-- 일꾼(해제)
exec spu_FVItemQuick 'xxxx9', '049000s1i0n7t8445289', 10, 1, -1	-- 촉진제
exec spu_FVItemQuick 'xxxx9', '049000s1i0n7t8445289', 10,-1, -1	-- 촉진제(해제)
*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVItemQuick', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVItemQuick;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_FVItemQuick
	@gameid_				varchar(60),
	@password_				varchar(20),
	@listidx_				int,
	@quickkind_				int,
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
	declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--블럭유저 > 팝업처리후 인트로로 빼버린다.
	declare @RESULT_ERROR_DELETED_USER 			int				set @RESULT_ERROR_DELETED_USER			= -12			--삭제유저 > 팝업처리후 인트로로 빼버린다.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함
	declare @RESULT_ERROR_NOT_FOUND_PASSWORD	int				set @RESULT_ERROR_NOT_FOUND_PASSWORD	= -17
	declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--서버를 점검하고 있다.
	declare @RESULT_NEWVERION_CLIENT_DOWNLOAD 	int				set @RESULT_NEWVERION_CLIENT_DOWNLOAD	= -15			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 링크처리.
	declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 종료.

	-- 게임중에 부족.
	declare @RESULT_ERROR_HEART_LACK			int				set @RESULT_ERROR_HEART_LACK			= -20			--하트이 부족하다.
	declare @RESULT_ERROR_GAMECOST_LACK			int				set @RESULT_ERROR_GAMECOST_LACK			= -21			--실버가 부족하다.
	declare @RESULT_ERROR_CASHCOST_LACK			int				set @RESULT_ERROR_CASHCOST_LACK			= -22			--골드가 부족하다.
	declare @RESULT_ERROR_ITEM_LACK				int				set @RESULT_ERROR_ITEM_LACK				= -23			--아이템이부족하다.

	-- 선물 코드값
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- 아이템코드못찾음
	declare @RESULT_ERROR_GIFTITEM_NOT_FOUND	int				set @RESULT_ERROR_GIFTITEM_NOT_FOUND	= -51			-- 선물아이템을 못찾음
	declare @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	int				set @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	= -52			-- 선물을 이미 가져감
	declare @RESULT_ERROR_NOT_FOUND_GIFTID		int				set @RESULT_ERROR_NOT_FOUND_GIFTID		= -75			-- 캐쉬 > 선물할 아이디를 못찾음

	-- 기타오류
	declare @RESULT_ERROR_RESULT_COPY			int				set @RESULT_ERROR_RESULT_COPY			= -53			-- 결과카피시도
	declare @RESULT_ERROR_GAMECOST_COPY			int				set @RESULT_ERROR_GAMECOST_COPY			= -54			-- 실버카피시도
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- 지원하지않는모드
	declare @RESULT_ERROR_HEART_FULL			int				set @RESULT_ERROR_HEART_FULL			= -71			-- 지원하지않는모드
	declare @RESULT_ERROR_TUTORIAL_ALREADY		int				set @RESULT_ERROR_TUTORIAL_ALREADY		= -73			-- 투토리얼 이미 보상.
	declare @RESULT_ERROR_NOT_FOUND_OTHERID		int				set @RESULT_ERROR_NOT_FOUND_OTHERID		= -83
	declare @RESULT_ERROR_INVEN_FULL			int				set @RESULT_ERROR_INVEN_FULL			= -101			-- 인벤부족
	declare @RESULT_ERROR_NOT_MATCH				int				set @RESULT_ERROR_NOT_MATCH				= -110			-- 무엇인가 매치가 안되었다.
	declare @RESULT_ERROR_DOUBLE_RANDSERIAL		int				set @RESULT_ERROR_DOUBLE_RANDSERIAL		= -111			-- 랜덤시리얼 중복.
	declare @RESULT_ERROR_MAXCOUNT				int				set @RESULT_ERROR_MAXCOUNT				= -112			-- 맥스카운터.
	declare @RESULT_ERROR_ITEMCOST_WRONG		int				set @RESULT_ERROR_ITEMCOST_WRONG		= -113			-- 아이템 가격이 이상함.
	declare @RESULT_ERROR_LISTIDX_NOT_FOUND		int				set @RESULT_ERROR_LISTIDX_NOT_FOUND		= -114			-- 리스트 번호를 못찾음.
	declare @RESULT_ERROR_NOT_ENOUGH			int				set @RESULT_ERROR_NOT_ENOUGH			= -115			-- 무엇인가 충분하지 않음.

	------------------------------------------------
	--	2-2. 정의된값
	------------------------------------------------
	-- 아이템 소분류(장착가능)
	declare @ITEM_SUBCATEGORY_BULLET			int					set @ITEM_SUBCATEGORY_BULLET 				= 8  -- 총알	(판매[O], 선물[O], 장착[O])
	declare @ITEM_SUBCATEGORY_VACCINE			int					set @ITEM_SUBCATEGORY_VACCINE 				= 9  -- 치료제	(판매[O], 선물[O], 장착[O])
	declare @ITEM_SUBCATEGORY_ALBA				int					set @ITEM_SUBCATEGORY_ALBA 					= 11 -- 일꾼	(판매[O], 선물[O], 장착[O])
	declare @ITEM_SUBCATEGORY_BOOSTER			int					set @ITEM_SUBCATEGORY_BOOSTER 				= 12 -- 촉진제	(판매[O], 선물[O], 장착[O])

	-- 동물정보.
	-- 필드동물 0 ~ 8.
	declare @USERITEM_FIELDIDX_INVEN			int					set @USERITEM_FIELDIDX_INVEN					= -1	-- 창고.
	declare @USERITEM_FIELDIDX_HOSPITAL			int					set @USERITEM_FIELDIDX_HOSPITAL					= -2	-- 병원.

	-- 소모템 > 퀵슬롯에 착용위치.
	declare @USERMASTER_QUICKKIND_NON			int					set @USERMASTER_QUICKKIND_NON				= -1 --없음.
	declare @USERMASTER_QUICKKIND_SETTING		int					set @USERMASTER_QUICKKIND_SETTING			=  1 --총알, 백신, 촉진, 알바.

	-- 구매의 일반정보.
	declare @CONSUME_MAX_COUNT					int					set @CONSUME_MAX_COUNT						= 999

	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @comment		varchar(80)
	declare @gameid			varchar(60)		set @gameid				= ''
	declare @bulletlistidx	int				set @bulletlistidx		= -1
	declare @vaccinelistidx	int				set @vaccinelistidx		= -1
	declare @boosterlistidx	int				set @boosterlistidx		= -1
	declare @albalistidx	int				set @albalistidx		= -1

	declare @itemcode 		int				set @itemcode 		= -444
	declare @cnt 			int				set @cnt			= 0
	declare @subcategory 	int				set @subcategory 	= -444

	declare @dummy	 		int
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	set @comment  = '알수 없는 오류가 발생했습니다.'
	--select 'DEBUG 3-1-1 입력값', @gameid_ gameid_, @password_ password_, @listidx_ listidx_, @quickkind_ quickkind_

	------------------------------------------------
	--	3-2. 연산수행(유저정보, 선물정보, 아이템 종류)
	------------------------------------------------
	select
		@gameid 		= gameid,
		@bulletlistidx 	= bulletlistidx,
		@vaccinelistidx = vaccinelistidx,
		@boosterlistidx = boosterlistidx,
		@albalistidx 	= albalistidx
	from dbo.tFVUserMaster where gameid = @gameid_ and password = @password_
	--select 'DEBUG 3-2-1 유저정보', @gameid gameid, @bulletlistidx bulletlistidx, @vaccinelistidx vaccinelistidx, @boosterlistidx boosterlistidx, @albalistidx albalistidx

	select
		@itemcode	= itemcode,
		@cnt		= cnt
	from dbo.tFVUserItem where gameid = @gameid_ and listidx = @listidx_
	--select 'DEBUG 3-2-2 템정보', @listidx_ listidx_, @itemcode itemcode, @cnt cnt

	if(@itemcode != -1)
		begin
			select @subcategory = subcategory from dbo.tFVItemInfo where itemcode = @itemcode
		end

	------------------------------------------------
	--	3-3. 각상황별로 코드로 분류
	------------------------------------------------
	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR 아이디가 존재하지 않는다.'
			--select 'DEBUG ' + @comment
		END
	else if (@itemcode = -444)
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_ITEMCODE
			set @comment = 'ERROR 아이템을 찾을 수 없습니다.'
			--select 'DEBUG ' + @comment
		END
	else if (@cnt <= 0)
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_ENOUGH
			set @comment = 'ERROR 수량이 없습니다.'
			--select 'DEBUG ' + @comment
		END
	else if (@subcategory not in (@ITEM_SUBCATEGORY_BULLET, @ITEM_SUBCATEGORY_VACCINE, @ITEM_SUBCATEGORY_ALBA, @ITEM_SUBCATEGORY_BOOSTER))
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment = 'ERROR 총알, 백신, 부스터, 알바 이외에는 안됩니다.'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 퀵슬롯 세팅합니다.'

			if(@subcategory = @ITEM_SUBCATEGORY_BULLET)
				begin
					--select 'DEBUG 총알세팅', @listidx_ listidx_
					set @bulletlistidx = case when(@quickkind_ = @USERMASTER_QUICKKIND_SETTING) then @listidx_ else -1 end
				end
			else if(@subcategory = @ITEM_SUBCATEGORY_VACCINE)
				begin
					--select 'DEBUG 백신세팅', @listidx_ listidx_
					set @vaccinelistidx = case when(@quickkind_ = @USERMASTER_QUICKKIND_SETTING) then @listidx_ else -1 end
				end
			else if(@subcategory = @ITEM_SUBCATEGORY_BOOSTER)
				begin
					--select 'DEBUG 촉진세팅', @listidx_ listidx_
					set @boosterlistidx = case when(@quickkind_ = @USERMASTER_QUICKKIND_SETTING) then @listidx_ else -1 end
				end
			else if(@subcategory = @ITEM_SUBCATEGORY_ALBA)
				begin
					----select 'DEBUG 알바세팅', @listidx_ listidx_
					set @albalistidx = case when(@quickkind_ = @USERMASTER_QUICKKIND_SETTING) then @listidx_ else -1 end
				end
		END

	if(@nResult_ = @RESULT_SUCCESS)
		begin
			-- 세팅값을 직접 넣어준다.
			update dbo.tFVUserMaster
			set
				bulletlistidx 	= @bulletlistidx,
				vaccinelistidx 	= @vaccinelistidx,
				boosterlistidx 	= @boosterlistidx,
				albalistidx 	= @albalistidx
			where gameid = @gameid_

			--------------------------------------------------------------
			-- 코드(캐쉬, 코인, 하트, 건초)
			--------------------------------------------------------------
			select @nResult_ rtn, @comment comment, @bulletlistidx bulletlistidx, @vaccinelistidx vaccinelistidx, @boosterlistidx boosterlistidx, @albalistidx albalistidx
		end
	else
		begin
			select @nResult_ rtn, @comment comment, @bulletlistidx bulletlistidx, @vaccinelistidx vaccinelistidx, @boosterlistidx boosterlistidx, @albalistidx albalistidx
		end

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
End

