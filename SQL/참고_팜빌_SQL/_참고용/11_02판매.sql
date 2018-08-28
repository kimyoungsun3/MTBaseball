---------------------------------------------------------------
/*
-- 일반소모 구매(세팅)
--exec spu_FVItemBuy 'guest90289', '0426468u1h0p8t484847', 5201, -1, -1, -1, 7784, -1	-- 일반교배티켓
--exec spu_FVItemBuy 'guest90289', '0426468u1h0p8t484847', 5300, -1, -1, -1, 7785, -1	-- 대회티켓B
--exec spu_FVItemBuy 'guest90289', '0426468u1h0p8t484847', 2200, -1, -1, -1, 7786, -1	-- 상인100프로만족
--exec spu_FVItemBuy 'guest90289', '0426468u1h0p8t484847', 2100, -1, -1, -1, 7787, -1	-- 긴급요청티켓
--exec spu_FVItemBuy 'guest90289', '0426468u1h0p8t484847', 1401, -1, -1, -1, 7775, -1	-- 악세(머리)

-- 동물 판매.
exec spu_FVItemSell 'guest90289', '0426468u1h0p8t484847', 1, 1, -1	-- 소(인벤 -1)
exec spu_FVItemSell 'xxxx2', '049000s1i0n7t8445289', 1, 1, -1	-- 소(인벤 -1)

-- 소모.
exec spu_FVItemSell 'guest90289', '0426468u1h0p8t484847', 7, 1, -1	-- 총알
exec spu_FVItemSell 'guest90289', '0426468u1h0p8t484847', 8, 1, -1	-- 치료제
exec spu_FVItemSell 'guest90289', '0426468u1h0p8t484847', 9, 1, -1	-- 일꾼
exec spu_FVItemSell 'guest90289', '0426468u1h0p8t484847', 10, 1, -1	-- 촉진제


exec spu_FVItemSell 'guest90289', '0426468u1h0p8t484847', 11, 1, -1	-- 부활석
exec spu_FVItemSell 'guest90289', '0426468u1h0p8t484847', 12, 1, -1	-- 일반교배티켓
exec spu_FVItemSell 'guest90289', '0426468u1h0p8t484847', 13, 1, -1	-- 대회티켓B
exec spu_FVItemSell 'guest90289', '0426468u1h0p8t484847', 14, 1, -1	-- 상인100프로만족
exec spu_FVItemSell 'guest90289', '0426468u1h0p8t484847', 15, 1, -1	-- 긴급요청티켓

-- 악세.
exec spu_FVItemSell 'guest90289', '0426468u1h0p8t484847', 16, 1, -1	-- 악세(머리)
*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVItemSell', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVItemSell;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_FVItemSell
	@gameid_				varchar(60),
	@password_				varchar(20),
	@listidx_				int,
	@sellcnt_				int,
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
	-- 아이템별 인벤분류
	declare @USERITEM_INVENKIND_ANI				int 				set @USERITEM_INVENKIND_ANI					= 1
	declare @USERITEM_INVENKIND_CONSUME			int 				set @USERITEM_INVENKIND_CONSUME				= 3
	declare @USERITEM_INVENKIND_ACC				int 				set @USERITEM_INVENKIND_ACC					= 4
	declare @USERITEM_INVENKIND_DIRECT			int 				set @USERITEM_INVENKIND_DIRECT				= 40
	declare @USERITEM_INVENKIND_INFO			int 				set @USERITEM_INVENKIND_INFO				= 60
	declare @USERITEM_INVENKIND_PET				int 				set @USERITEM_INVENKIND_PET					= 1000

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
	declare @gameid			varchar(60)		set @gameid		= ''
	declare @cashcost		int				set @cashcost 	= 0
	declare @gamecost		int				set @gamecost 	= 0
	declare @heart			int				set @heart 		= 0
	declare @feed			int				set @feed 		= 0

	declare @invenkind		int				set @invenkind		= -1
	declare @itemcode 		int				set @itemcode 		= -444
	declare @cnt 			int				set @cnt			= 0
	declare @fieldidx 		int
	declare @sellcost		int				set @sellcost		= 0
	declare @anireplistidx	int				set @anireplistidx	= 1
	declare @acc1			int				set @acc1			= -1
	declare @acc2			int				set @acc2			= -1

	declare @dummy	 		int
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	set @comment  = '알수 없는 오류가 발생했습니다.'
	--select 'DEBUG 3-1-1 입력값', @gameid_ gameid_, @password_ password_, @listidx_ listidx_, @sellcnt_ sellcnt_

	------------------------------------------------
	--	3-2. 연산수행(유저정보, 선물정보, 아이템 종류)
	------------------------------------------------
	select
		@gameid 		= gameid,
		@cashcost 		= cashcost,
		@gamecost		= gamecost,
		@heart			= heart,
		@feed			= feed,
		@anireplistidx	= anireplistidx
	from dbo.tFVUserMaster where gameid = @gameid_ and password = @password_
	--select 'DEBUG 3-2-1 유저정보', @gameid gameid, @cashcost cashcost, @gamecost gamecost

	select
		@invenkind	= invenkind,
		@itemcode	= itemcode,
		@acc1		= acc1,
		@acc2		= acc2,
		@cnt		= cnt,
		@fieldidx 	= fieldidx
	from dbo.tFVUserItem where gameid = @gameid_ and listidx = @listidx_
	--select 'DEBUG 3-2-2 템정보', @listidx_ listidx_, @invenkind invenkind, @itemcode itemcode, @cnt cnt, @fieldidx fieldidx

	if(@itemcode != -1 or @acc1 != -1 or @acc2 != -1)
		begin
			select @sellcost = sum(sellcost) from dbo.tFVItemInfo where itemcode in (@itemcode, @acc1, @acc2)
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
	else if (@sellcost < 0)
		BEGIN
			-- 0원짜리 상품.
			set @nResult_ = @RESULT_ERROR_ITEMCOST_WRONG
			set @comment = 'ERROR 판매 단가가 이상합니다..'
			--select 'DEBUG ' + @comment
		END
	else if (@invenkind = @USERITEM_INVENKIND_ANI and @fieldidx = @USERITEM_FIELDIDX_HOSPITAL)
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_ITEMCODE
			set @comment = 'ERROR 아이템을 찾을 수 없습니다.'
			--select 'DEBUG ' + @comment
		END
	else if (@invenkind = @USERITEM_INVENKIND_CONSUME and @sellcnt_ > @cnt)
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_ENOUGH
			set @comment = 'ERROR 판매 수량을 초과했다.'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 정상 판매 처리합니다.'

			if(@invenkind = @USERITEM_INVENKIND_ANI)
				begin
					--------------------------------------------------------------
					-- 동물 아이템 > 판매(삭제), 판매가(+).
					--------------------------------------------------------------
					--select 'DEBUG 4-3 동물 판매(전)', @gamecost gamecost, @sellcost sellcost
					-- delete from dbo.tFVUserItem where gameid = @gameid_ and listidx = @listidx_
					exec spu_FVDeleteUserItemBackup 1, @gameid_, @listidx_

					-----------------------------------------
					-- 대표동물 죽으면 기본동물로 세팅
					-----------------------------------------
					if(@anireplistidx = @listidx_)
						begin
							update dbo.tFVUserMaster
								set
									anirepitemcode 	=  1,
									anirepacc1	 	= -1,
									anirepacc2 		= -1
							where gameid = @gameid_
						end

					set @gamecost = @gamecost + @sellcost
					--select 'DEBUG 4-3 동물 판매(후)', @gamecost gamecost, @sellcost sellcost
				end
			else if(@invenkind = @USERITEM_INVENKIND_CONSUME)
				begin
					--------------------------------------------------------------
					-- 소모 아이템 > 판매(삭감 > 0 이하는 로그인때 삭제됨), 판매가(+).
					--------------------------------------------------------------
					--select 'DEBUG 4-4 소모 판매(전)', @gamecost gamecost, @sellcost sellcost, @sellcnt_ sellcnt_
					update dbo.tFVUserItem
						set
							cnt = cnt - @sellcnt_
					where gameid = @gameid_ and listidx = @listidx_

					set @gamecost = @gamecost + @sellcost * @sellcnt_
					--select 'DEBUG 4-4 소모 판매(후)', @gamecost gamecost, @sellcost sellcost, @sellcnt_ sellcnt_
				end
			else if(@invenkind = @USERITEM_INVENKIND_ACC)
				begin
					--------------------------------------------------------------
					-- 악세 아이템 > 판매(삭제), 판매가(+).
					--------------------------------------------------------------
					--select 'DEBUG 4-5 악세 판매(전)', @gamecost gamecost, @sellcost sellcost
					-- delete from dbo.tFVUserItem where gameid = @gameid_ and listidx = @listidx_
					exec spu_FVDeleteUserItemBackup 1, @gameid_, @listidx_

					set @gamecost = @gamecost + @sellcost

					--select 'DEBUG 4-5 악세 판매(후)', @gamecost gamecost, @sellcost sellcost
				end
			else
				begin
					--------------------------------------------------------------
					-- 기타	-> 판매 못함.
					--------------------------------------------------------------
					--select 'DEBUG 4-7 정보표시용'

					set @dummy = 0
				end
		END

	if(@nResult_ = @RESULT_SUCCESS)
		begin
			-- 아이템을 직접 넣어줌
			update dbo.tFVUserMaster
			set
				gamecost	= @gamecost
			where gameid = @gameid_

			--------------------------------------------------------------
			-- 코드(캐쉬, 코인, 하트, 건초)
			--------------------------------------------------------------
			select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost, @heart heart, @feed feed

			--------------------------------------------------------------
			-- 유저 보유 아이템 정보
			--------------------------------------------------------------
			select * from dbo.tFVUserItem
			where gameid = @gameid_ and listidx = @listidx_
		end
	else
		begin
			select @nResult_ rtn, @comment comment, @gamecost gamecost, @cashcost cashcost, @heart heart, @feed feed
		end

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
End

