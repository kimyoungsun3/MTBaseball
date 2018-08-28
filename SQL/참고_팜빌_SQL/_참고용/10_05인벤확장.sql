/*
exec spu_FVItemInvenExp 'xxxx2', '049000s1i0n7t8445280', 0, -1		-- 유저없음.
exec spu_FVItemInvenExp 'xxxx2', '049000s1i0n7t8445289', 0, -1		-- 인벤종류틀림.

exec spu_FVItemInvenExp 'xxxx2', '049000s1i0n7t8445289', 1, -1		-- 동물 인벤확장.
exec spu_FVItemInvenExp 'xxxx2', '049000s1i0n7t8445289', 3, -1		-- 소비템 인벤확장.
exec spu_FVItemInvenExp 'xxxx2', '049000s1i0n7t8445289', 4, -1		-- 악세사리 인벤확장.
*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVItemInvenExp', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVItemInvenExp;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_FVItemInvenExp
	@gameid_								varchar(60),
	@password_								varchar(20),
	@invenkind_								int,
	@nResult_								int					OUTPUT
	--WITH ENCRYPTION -- 프로시져를 암호화함.
as
	------------------------------------------------
	--	2-1. 코드값자리
	------------------------------------------------
	-- 일반값
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	-- 로그인 오류.
	declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--블럭유저 > 팝업처리후 인트로로 빼버린다.
	declare @RESULT_ERROR_DELETED_USER 			int				set @RESULT_ERROR_DELETED_USER			= -12			--삭제유저 > 팝업처리후 인트로로 빼버린다.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함.
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
	declare @RESULT_ERROR_DAILY_REWARD_ALREADY	int				set @RESULT_ERROR_DAILY_REWARD_ALREADY	= -102			-- 일일보상 이미 보상.
	declare @RESULT_ERROR_NOT_FOUND_DOGAMIDX	int				set @RESULT_ERROR_NOT_FOUND_DOGAMIDX	= -103			-- 도감번호를 찾을수 없음.
	declare @RESULT_ERROR_DOGAM_ALREADY_REWARD	int				set @RESULT_ERROR_DOGAM_ALREADY_REWARD	= -104			-- 도감을 이미 지급했음.
	declare @RESULT_ERROR_DOGAM_LACK			int				set @RESULT_ERROR_DOGAM_LACK			= -105			-- 도감중에 동물번호가 부족함.
	declare @RESULT_ERROR_ANIMAL_NOT_FOUND		int				set @RESULT_ERROR_ANIMAL_NOT_FOUND		= -106			-- 대표동물 못찾음
	declare @RESULT_ERROR_ANIMAL_NOT_INVEN		int				set @RESULT_ERROR_ANIMAL_NOT_INVEN		= -107			-- 인벤에 없음(창고)
	declare @RESULT_ERROR_ANIMAL_NOT_ALIVE		int				set @RESULT_ERROR_ANIMAL_NOT_ALIVE		= -108			-- 살아 있지 않음
	declare @RESULT_ERROR_ANIMAL_IS_ALIVE		int				set @RESULT_ERROR_ANIMAL_IS_ALIVE		= -116			-- 동물이 살아있다.
	declare @RESULT_ERROR_ANIMAL_FIELDIDX		int				set @RESULT_ERROR_ANIMAL_FIELDIDX		= -117			-- 필드인덱스오류.
	declare @RESULT_ERROR_NOT_MATCH				int				set @RESULT_ERROR_NOT_MATCH				= -110			-- 무엇인가 매치가 안되었다.
	declare @RESULT_ERROR_DOUBLE_RANDSERIAL		int				set @RESULT_ERROR_DOUBLE_RANDSERIAL		= -111			-- 랜덤시리얼 중복.
	declare @RESULT_ERROR_MAXCOUNT				int				set @RESULT_ERROR_MAXCOUNT				= -112			-- 맥스카운터.
	declare @RESULT_ERROR_ITEMCOST_WRONG		int				set @RESULT_ERROR_ITEMCOST_WRONG		= -113			-- 아이템 가격이 이상함.
	declare @RESULT_ERROR_LISTIDX_NOT_FOUND		int				set @RESULT_ERROR_LISTIDX_NOT_FOUND		= -114			-- 리스트 번호를 못찾음.
	declare @RESULT_ERROR_NOT_ENOUGH			int				set @RESULT_ERROR_NOT_ENOUGH			= -115			-- 무엇인가 충분하지 않음.
	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------
	-- 아이템별 인벤분류
	declare @USERITEM_INVENKIND_ANI				int 				set @USERITEM_INVENKIND_ANI					= 1
	declare @USERITEM_INVENKIND_CONSUME			int 				set @USERITEM_INVENKIND_CONSUME				= 3
	declare @USERITEM_INVENKIND_ACC				int 				set @USERITEM_INVENKIND_ACC					= 4
	declare @USERITEM_INVENKIND_DIRECT			int 				set @USERITEM_INVENKIND_DIRECT				= 40
	declare @USERITEM_INVENKIND_INFO			int 				set @USERITEM_INVENKIND_INFO				= 60
	declare @USERITEM_INVENKIND_PET				int 				set @USERITEM_INVENKIND_PET					= 1000

	-- 아이템 소분류
	declare @ITEM_SUBCATEGORY_COW				int					set @ITEM_SUBCATEGORY_COW 					= 1  -- 소		(판매[O], 선물[O])
	declare @ITEM_SUBCATEGORY_GOAT				int					set @ITEM_SUBCATEGORY_GOAT 					= 2  -- 양		(판매[O], 선물[O])
	declare @ITEM_SUBCATEGORY_SHEEP				int					set @ITEM_SUBCATEGORY_SHEEP 				= 3  -- 산양	(판매[O], 선물[O])
	declare @ITEM_SUBCATEGORY_SEED				int					set @ITEM_SUBCATEGORY_SEED 					= 7  -- 씨앗	(판매[X], 선물[X], 직접[O])
	declare @ITEM_SUBCATEGORY_BULLET			int					set @ITEM_SUBCATEGORY_BULLET 				= 8  -- 총알	(판매[O], 선물[O], 장착[O])
	declare @ITEM_SUBCATEGORY_VACCINE			int					set @ITEM_SUBCATEGORY_VACCINE 				= 9  -- 치료제	(판매[O], 선물[O], 장착[O])
	declare @ITEM_SUBCATEGORY_FEED				int					set @ITEM_SUBCATEGORY_FEED 					= 44 -- 건초	(판매[X], 선물[O])
	declare @ITEM_SUBCATEGORY_ALBA				int					set @ITEM_SUBCATEGORY_ALBA 					= 11 -- 일꾼	(판매[O], 선물[O], 장착[O])
	declare @ITEM_SUBCATEGORY_BOOSTER			int					set @ITEM_SUBCATEGORY_BOOSTER 				= 12 -- 촉진제	(판매[O], 선물[O], 장착[O])
	declare @ITEM_SUBCATEGORY_REVIVAL			int					set @ITEM_SUBCATEGORY_REVIVAL 				= 13 -- 부활석	(판매[O], 선물[O])
	declare @ITEM_SUBCATEGORY_ACC				int					set @ITEM_SUBCATEGORY_ACC 					= 15 -- 악세	(판매[O], 선물[O])
	declare @ITEM_SUBCATEGORY_HEART				int					set @ITEM_SUBCATEGORY_HEART 				= 40 -- 하트	(판매[O], 선물[O])
	declare @ITEM_SUBCATEGORY_HELPER			int					set @ITEM_SUBCATEGORY_HELPER 				= 41 -- 긴급요청(판매[X], 선물[O])
	declare @ITEM_SUBCATEGORY_TRADESAFE			int					set @ITEM_SUBCATEGORY_TRADESAFE				= 42 -- 상인만족(판매[X], 선물[O])
	declare @ITEM_SUBCATEGORY_CASHCOST			int					set @ITEM_SUBCATEGORY_CASHCOST 				= 50 -- 캐쉬	(판매[O], 선물[O])
	declare @ITEM_SUBCATEGORY_GAMECOST			int					set @ITEM_SUBCATEGORY_GAMECOST 				= 51 -- 코인	(판매[O], 선물[O])
	declare @ITEM_SUBCATEGORY_CONTEST			int					set @ITEM_SUBCATEGORY_CONTEST 				= 53 -- 대회	(판매[O], 선물[O])
	declare @ITEM_SUBCATEGORY_UPGRADE_HOUSE		int					set @ITEM_SUBCATEGORY_UPGRADE_HOUSE 		= 60 -- 집
	declare @ITEM_SUBCATEGORY_UPGRADE_TANK		int					set @ITEM_SUBCATEGORY_UPGRADE_TANK 			= 61 -- 탱크
	declare @ITEM_SUBCATEGORY_UPGRADE_FRESHCOOL	int					set @ITEM_SUBCATEGORY_UPGRADE_FRESHCOOL 	= 62 -- 저온보관
	declare @ITEM_SUBCATEGORY_UPGRADE_PURE		int					set @ITEM_SUBCATEGORY_UPGRADE_PURE 			= 63 -- 정화시설
	declare @ITEM_SUBCATEGORY_UPGRADE_BOTTLE	int					set @ITEM_SUBCATEGORY_UPGRADE_BOTTLE 		= 64 -- 양동이
	declare @ITEM_SUBCATEGORY_UPGRADE_PUMP		int					set @ITEM_SUBCATEGORY_UPGRADE_PUMP 			= 65 -- 착유기
	declare @ITEM_SUBCATEGORY_UPGRADE_TRANSFER	int					set @ITEM_SUBCATEGORY_UPGRADE_TRANSFER 		= 66 -- 주입기
	declare @ITEM_SUBCATEGORY_INVEN				int					set @ITEM_SUBCATEGORY_INVEN 				= 67 -- 인벤확장
	declare @ITEM_SUBCATEGORY_SEEDFIELD			int					set @ITEM_SUBCATEGORY_SEEDFIELD 			= 68 -- 경작지확장
	declare @ITEM_SUBCATEGORY_DOGAM				int					set @ITEM_SUBCATEGORY_DOGAM 				= 818 -- 도감
	declare @ITEM_SUBCATEGORY_SYSINFO			int					set @ITEM_SUBCATEGORY_SYSINFO 				= 500 -- 정보수집
	declare @ITEM_SUBCATEGORY_ATTENDANCE		int					set @ITEM_SUBCATEGORY_ATTENDANCE 			= 900 	--출석(900)
	declare @ITEM_SUBCATEGORY_COMPETITION		int					set @ITEM_SUBCATEGORY_COMPETITION 			= 901 	--경쟁모드(901)
	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @comment			varchar(80)

	declare @gameid 			varchar(60)		set @gameid 		= ''
	declare @market				int,
			@cashcost			int,
			@gamecost			int,
			@invenanimalmax		int,		-- 10
			@invenanimalstep	int,		-- 0
			@invencustommax		int,		-- 6
			@invencustomstep	int,		-- 0
			@invenaccmax		int,		-- 4
			@invenaccstep		int			-- 0

	declare @itemcodesell		int				set @itemcodesell		= -1
	declare @gamecostsell		int				set @gamecostsell 		= 99999
	declare @cashcostsell		int				set @cashcostsell 		= 99999
	declare @invenstepnext		int				set @invenstepnext		= 99999
	declare @invenstepmax		int				set @invenstepmax		= 0

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG 입력값', @gameid_ gameid_, @password_ password_, @invenkind_ invenkind_

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	-- 유저정보.
	select
		@gameid 		= gameid,
		@market			= market,
		@cashcost		= cashcost,
		@gamecost		= gamecost,
		@invenanimalmax	= invenanimalmax,
		@invenanimalstep= invenanimalstep,
		@invencustommax	= invencustommax,
		@invencustomstep= invencustomstep,
		@invenaccmax	= invenaccmax,
		@invenaccstep	= invenaccstep
	from dbo.tFVUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 1-1 유저정보', @gameid gameid, @market market, @cashcost cashcost, @gamecost gamecost, @invenanimalmax invenanimalmax, @invenanimalstep invenanimalstep, @invencustommax invencustommax, @invencustomstep invencustomstep, @invenaccmax invenaccmax, @invenaccstep invenaccstep

	---------------------------------------------
	-- tItemInfo(인벤정보) > 관리페이지(수집) > tSystemInfo
	---------------------------------------------
	select top 1 @invenstepmax = invenstepmax from dbo.tFVSystemInfo order by idx desc
	--select 'DEBUG 인벤허용맥스정보 ', @invenstepmax invenstepmax


	-- 인벤다음단계
	if(@invenkind_ = @USERITEM_INVENKIND_ANI)
		begin
			--select 'DEBUG 1-2 동물 인벤확장정보', @invenanimalmax invenanimalmax, @invenanimalstep invenanimalstep
			set @invenstepnext 	= @invenanimalstep + 1
		end
	else if(@invenkind_ = @USERITEM_INVENKIND_CONSUME)
		begin
			--select 'DEBUG 1-3 소모 인벤확장정보', @invencustommax invencustommax, @invencustomstep invencustomstep
			set @invenstepnext 	= @invencustomstep + 1
		end
	else if(@invenkind_ = @USERITEM_INVENKIND_ACC)
		begin
			--select 'DEBUG 1-4 악세 인벤확장정보', @invenaccmax invenaccmax, @invenaccstep invenaccstep
			set @invenstepnext 	= @invenaccstep + 1
		end

	select
		@itemcodesell		= itemcode,
		@cashcostsell		= cashcost,
		@gamecostsell 		= gamecost
	from dbo.tFVItemInfo
	where subcategory = @ITEM_SUBCATEGORY_INVEN and param1 = @invenstepnext
	--select 'DEBUG > 다음단계', @invenstepnext invenstepnext, @invenstepmax invenstepmax, @itemcodesell itemcodesell, @cashcostsell cashcostsell, @gamecostsell gamecostsell


	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '아이디가 존재하지 않는다.'
			--select 'DEBUG ' + @comment
		END
	else if(@invenkind_ not in (@USERITEM_INVENKIND_ANI, @USERITEM_INVENKIND_CONSUME, @USERITEM_INVENKIND_ACC))
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment 	= '지원하지 않는 모드입니다.'
			--select 'DEBUG ' + @comment
		END
	else if(@invenstepnext > @invenstepmax)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_INVEN_FULL
			set @comment 	= '인벤이 풀로 확장되었습니다.'
			--select 'DEBUG ' + @comment
		END
	else if(@itemcodesell = -1 or (@cashcostsell <= 0 and @gamecostsell <= 0))
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_ITEMCODE
			set @comment 	= '인벤이 해당 아이템 코드를 찾을 수 없습니다.'
			--select 'DEBUG ' + @comment
		END
	else if(@cashcostsell > 0 and @cashcostsell > @cashcost)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_CASHCOST_LACK
			set @comment 	= '캐쉬비용이 부족합니다.'
			--select 'DEBUG ' + @comment
		END
	else if(@gamecostsell > 0 and @gamecostsell > @gamecost)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_GAMECOST_LACK
			set @comment 	= '코인비용이 부족합니다.'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 인벤을 확장했습니다.'
			--select 'DEBUG ' + @comment

			-- 비용차감.
			set @cashcost	= @cashcost - @cashcostsell
			set @gamecost	= @gamecost - @gamecostsell

			-- 인벤다음단계
			if(@invenkind_ = @USERITEM_INVENKIND_ANI)
				begin
					set @invenanimalmax		= @invenanimalmax + 5
					set @invenanimalstep 	= @invenanimalstep + 1
				end
			else if(@invenkind_ = @USERITEM_INVENKIND_CONSUME)
				begin
					set @invencustommax		= @invencustommax + 5
					set @invencustomstep 	= @invencustomstep + 1
				end
			else if(@invenkind_ = @USERITEM_INVENKIND_ACC)
				begin
					set @invenaccmax 		= @invenaccmax + 5
					set @invenaccstep 		= @invenaccstep + 1
				end

			-----------------------------------
			-- 구매기록마킹
			-----------------------------------
			exec spu_FVUserItemBuyLog @gameid_, @itemcodesell, @gamecostsell, @cashcostsell
		END


	if(@nResult_ = @RESULT_SUCCESS)
		begin
			-----------------------------------
			-- 유저 정보 반영.
			-----------------------------------
			update dbo.tFVUserMaster
			set
				cashcost		= @cashcost,
				gamecost		= @gamecost,
				invenanimalmax	= @invenanimalmax,
				invenanimalstep	= @invenanimalstep,
				invencustommax	= @invencustommax,
				invencustomstep	= @invencustomstep,
				invenaccmax		= @invenaccmax,
				invenaccstep	= @invenaccstep
			where gameid = @gameid_

			--------------------------------------------------------------
			-- 코드(캐쉬, 코인, 인벤정보)
			--------------------------------------------------------------
			select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost, @invenanimalmax invenanimalmax, @invenanimalstep invenanimalstep, @invencustommax invencustommax, @invencustomstep invencustomstep, @invenaccmax invenaccmax, @invenaccstep invenaccstep
		end
	else
		begin
			select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost, @invenanimalmax invenanimalmax, @invenanimalstep invenanimalstep, @invencustommax invencustommax, @invencustomstep invencustomstep, @invenaccmax invenaccmax, @invenaccstep invenaccstep
		end


	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
End



