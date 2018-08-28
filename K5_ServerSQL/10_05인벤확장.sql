/*
exec spu_ItemInvenExp 'xxxx2', '049000s1i0n7t8445280', 0, -1		-- 유저없음.
exec spu_ItemInvenExp 'xxxx2', '049000s1i0n7t8445289', 0, -1		-- 인벤종류틀림.

exec spu_ItemInvenExp 'xxxx2', '049000s1i0n7t8445289', 1, -1		-- 동물 인벤확장.
exec spu_ItemInvenExp 'xxxx2', '049000s1i0n7t8445289', 3, -1		-- 소비템 인벤확장.
exec spu_ItemInvenExp 'xxxx2', '049000s1i0n7t8445289', 4, -1		-- 악세사리 인벤확장.
exec spu_ItemInvenExp 'xxxx2', '049000s1i0n7t8445289', 1040, -1		-- 줄기세포 인벤확장.
exec spu_ItemInvenExp 'xxxx2', '049000s1i0n7t8445289', 1200, -1		-- 보물 인벤확장.
*/
use Game4Farmvill5
GO

IF OBJECT_ID ( 'dbo.spu_ItemInvenExp', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_ItemInvenExp;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_ItemInvenExp
	@gameid_								varchar(20),
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
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함.
	declare @RESULT_ERROR_GAMECOST_LACK			int				set @RESULT_ERROR_GAMECOST_LACK			= -21			--실버가 부족하다.
	declare @RESULT_ERROR_CASHCOST_LACK			int				set @RESULT_ERROR_CASHCOST_LACK			= -22			--골드가 부족하다.
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- 아이템코드못찾음

	-- 기타오류
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- 지원하지않는모드
	declare @RESULT_ERROR_INVEN_FULL			int				set @RESULT_ERROR_INVEN_FULL			= -101			-- 인벤부족
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
	declare @USERITEM_INVENKIND_STEMCELL		int 				set @USERITEM_INVENKIND_STEMCELL			= 1040
	declare @USERITEM_INVENKIND_TREASURE		int 				set @USERITEM_INVENKIND_TREASURE			= 1200

	-- 아이템 소분류
	declare @ITEM_SUBCATEGORY_INVEN				int					set @ITEM_SUBCATEGORY_INVEN 				= 67 -- 인벤확장
	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @comment			varchar(80)

	declare @gameid 			varchar(20)		set @gameid 		= ''
	declare @market				int,
			@cashcost			int,
			@gamecost			int,
			@invenanimalmax		int,
			@invenanimalstep	int,
			@invencustommax		int,
			@invencustomstep	int,
			@invenaccmax		int,
			@invenaccstep		int,
			@invenstemcellmax	int,
			@invenstemcellstep	int,
			@inventreasuremax	int,
			@inventreasurestep	int

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
		@invenaccstep	= invenaccstep,
		@invenstemcellmax= invenstemcellmax,
		@invenstemcellstep= invenstemcellstep,
		@inventreasuremax= inventreasuremax,
		@inventreasurestep= inventreasurestep
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 1-1 유저정보', @gameid gameid, @market market, @cashcost cashcost, @gamecost gamecost, @invenanimalmax invenanimalmax, @invenanimalstep invenanimalstep, @invencustommax invencustommax, @invencustomstep invencustomstep, @invenaccmax invenaccmax, @invenaccstep invenaccstep

	---------------------------------------------
	-- tItemInfo(인벤정보) > 관리페이지(수집) > tSystemInfo
	---------------------------------------------
	select top 1 @invenstepmax = invenstepmax from dbo.tSystemInfo order by idx desc
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
	else if(@invenkind_ = @USERITEM_INVENKIND_STEMCELL)
		begin
			--select 'DEBUG 1-4 세포 인벤확장정보', @invenstemcellmax invenstemcellmax, @invenstemcellstep invenstemcellstep
			set @invenstepnext 	= @invenstemcellstep + 1
		end
	else if(@invenkind_ = @USERITEM_INVENKIND_TREASURE)
		begin
			--select 'DEBUG 1-4 보물 인벤확장정보', @inventreasuremax inventreasuremax, @inventreasurestep inventreasurestep
			set @invenstepnext 	= @inventreasurestep + 1
		end

	select
		@itemcodesell		= itemcode,
		@cashcostsell		= cashcost,
		@gamecostsell 		= gamecost
	from dbo.tItemInfo
	where subcategory = @ITEM_SUBCATEGORY_INVEN and param1 = @invenstepnext
	--select 'DEBUG > 다음단계', @invenstepnext invenstepnext, @invenstepmax invenstepmax, @itemcodesell itemcodesell, @cashcostsell cashcostsell, @gamecostsell gamecostsell


	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '아이디가 존재하지 않는다.'
			--select 'DEBUG ' + @comment
		END
	else if(@invenkind_ not in (@USERITEM_INVENKIND_ANI, @USERITEM_INVENKIND_CONSUME, @USERITEM_INVENKIND_ACC, @USERITEM_INVENKIND_STEMCELL, @USERITEM_INVENKIND_TREASURE))
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
					set @invenanimalmax		= @invenanimalmax + 10
					set @invenanimalstep 	= @invenanimalstep + 1
				end
			else if(@invenkind_ = @USERITEM_INVENKIND_CONSUME)
				begin
					set @invencustommax		= @invencustommax + 10
					set @invencustomstep 	= @invencustomstep + 1
				end
			else if(@invenkind_ = @USERITEM_INVENKIND_ACC)
				begin
					set @invenaccmax 		= @invenaccmax + 10
					set @invenaccstep 		= @invenaccstep + 1
				end
			else if(@invenkind_ = @USERITEM_INVENKIND_STEMCELL)
				begin
					set @invenstemcellmax 	= @invenstemcellmax + 10
					set @invenstemcellstep 	= @invenstemcellstep + 1
				end
			else if(@invenkind_ = @USERITEM_INVENKIND_TREASURE)
				begin
					set @inventreasuremax 	= @inventreasuremax + 10
					set @inventreasurestep 	= @inventreasurestep + 1
				end

			-----------------------------------
			-- 구매기록마킹
			-----------------------------------
			exec spu_UserItemBuyLogNew @gameid_, @itemcodesell, @gamecostsell, @cashcostsell, 0
		END

	--------------------------------------------------------------
	-- 코드(캐쉬, 코인, 인벤정보)
	--------------------------------------------------------------
	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost,
			@invenanimalmax invenanimalmax, @invenanimalstep invenanimalstep,
			@invencustommax invencustommax, @invencustomstep invencustomstep,
			@invenaccmax invenaccmax, @invenaccstep invenaccstep,
			@invenstemcellmax invenstemcellmax, @invenstemcellstep invenstemcellstep,
			@inventreasuremax inventreasuremax, @inventreasurestep inventreasurestep

	if(@nResult_ = @RESULT_SUCCESS)
		begin
			-----------------------------------
			-- 유저 정보 반영.
			-----------------------------------
			update dbo.tUserMaster
			set
				cashcost		= @cashcost,
				gamecost		= @gamecost,
				invenanimalmax	= @invenanimalmax,
				invenanimalstep	= @invenanimalstep,
				invencustommax	= @invencustommax,
				invencustomstep	= @invencustomstep,
				invenaccmax		= @invenaccmax,
				invenaccstep	= @invenaccstep,
				invenstemcellmax= @invenstemcellmax,
				invenstemcellstep= @invenstemcellstep,
				inventreasuremax= @inventreasuremax,
				inventreasurestep= @inventreasurestep
			where gameid = @gameid_
		end


	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
End



