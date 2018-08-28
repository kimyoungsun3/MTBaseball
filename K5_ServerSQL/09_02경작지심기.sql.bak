/*
exec spu_SeedPlant 'xxxx2', '049000s1i0n7t8445280',  0, 600, 0, -1	-- 유저없음.
exec spu_SeedPlant 'xxxx2', '049000s1i0n7t8445289', 11, 600, 0, -1	-- 미구매.
exec spu_SeedPlant 'xxxx2', '049000s1i0n7t8445289', -1, 600, 0, -1	-- 잘못된 경작지번호.
exec spu_SeedPlant 'xxxx2', '049000s1i0n7t8445289',  1, 444, 0, -1	-- 잘못된 씨앗정보.

exec spu_SeedPlant 'farm1078959', '2506581j3z1t4e126143',  0, 600, 1, -1	-- 건초 > 직접.
exec spu_SeedPlant 'xxxx2', '049000s1i0n7t8445289',  1, 600, 1, -1	-- 건초 > 직접.
exec spu_SeedPlant 'xxxx2', '049000s1i0n7t8445289',  2, 601, 1, -1	-- 건초 > 직접.
exec spu_SeedPlant 'xxxx2', '049000s1i0n7t8445289',  3, 602, 0, -1	-- 건초 > 직접.
exec spu_SeedPlant 'xxxx2', '049000s1i0n7t8445289',  4, 603, 0, -1	-- 건초 > 직접.
exec spu_SeedPlant 'xxxx2', '049000s1i0n7t8445289',  5, 604, 0, -1	-- 건초 > 직접.
exec spu_SeedPlant 'xxxx2', '049000s1i0n7t8445289',  6, 607, 0, -1	-- 하트 > 직접.
exec spu_SeedPlant 'xxxx2', '049000s1i0n7t8445289',  7, 605, 0, -1	-- 회복 > 소모(선물함).
exec spu_SeedPlant 'xxxx2', '049000s1i0n7t8445289',  8, 606, 0, -1	-- 촉진 > 소모(선물함).
*/
use Game4Farmvill5
GO

IF OBJECT_ID ( 'dbo.spu_SeedPlant', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_SeedPlant;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_SeedPlant
	@gameid_								varchar(20),
	@password_								varchar(20),
	@seedidx_								int,
	@seeditemcode_							int,
	@feeduse_								int,
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
	declare @RESULT_ERROR_NEED_BUY				int				set @RESULT_ERROR_NEED_BUY				= -120			-- 경작지가 미구매상태.

	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------
	-- 아이템 소분류
	declare @ITEM_SUBCATEGORY_SEED				int					set @ITEM_SUBCATEGORY_SEED 					= 7  -- 씨앗	(판매[X], 선물[X], 직접[O])

	-- 경작지(정보).
	declare @USERSEED_NEED_EMPTY				int					set @USERSEED_NEED_EMPTY					= -1	-- (경작지)
	declare @USERSEED_NEED_BUY					int					set @USERSEED_NEED_BUY						= -2
	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @comment			varchar(80)

	declare @gameid 			varchar(20)		set @gameid 		= ''
	declare @market				int				set @market			= 1
	declare @cashcost			int				set @cashcost		= 0
	declare @gamecost			int				set @gamecost		= 0
	declare @feed				int				set @feed			= 0
	declare @heart				int				set @heart			= 0
	declare @qtfeeduse			int				set @qtfeeduse		= 0


	declare @seeditemcode		int				set @seeditemcode		= @USERSEED_NEED_BUY

	declare @seeditemcodenew	int				set @seeditemcodenew	= -444
	declare @gamecostsell		int				set @gamecostsell 		= 99999
	declare @cashcostsell		int				set @cashcostsell 		= 99999
	declare @harvestcnt			int				set @harvestcnt			= 0
	declare @harvesttime		int				set @harvesttime		= 99999
	declare @harvestcashcost	int				set @harvestcashcost	= 99999
	declare @harvestitemcode	int				set @harvestitemcode	= -444

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	set @comment = 'ERROR 알수없는 오류(-1)'
	--select 'DEBUG 1-0 입력값', @gameid_ gameid_, @password_ password_, @seedidx_ seedidx_, @seeditemcode_ seeditemcode_

	------------------------------------------------
	--	3-2. 유저정보.
	------------------------------------------------
	-- 유저정보.
	select
		@gameid 		= gameid,
		@market			= market,
		@cashcost		= cashcost,
		@gamecost		= gamecost,
		@feed			= feed,
		@heart			= heart,
		@qtfeeduse		= qtfeeduse
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 1-1 유저정보', @gameid gameid, @market market, @cashcost cashcost, @gamecost gamecost

	select
		@seeditemcode	= itemcode
	from dbo.tUSerSeed where gameid = @gameid_ and seedidx = @seedidx_
	--select 'DEBUG 1-2 경작지정보', @gameid_ gameid_, @seedidx_ seedidx_, @seeditemcode seeditemcode

	---------------------------------------------
	-- 아이템 정보.
	---------------------------------------------
	select
		@seeditemcodenew	= itemcode,
		@cashcostsell		= cashcost,
		@gamecostsell 		= gamecost,
		@harvestcnt			= param1,
		@harvesttime		= param2,
		@harvestcashcost	= param5,
		@harvestitemcode	= param6
	from dbo.tItemInfo
	where subcategory = @ITEM_SUBCATEGORY_SEED and itemcode = @seeditemcode_
	--select 'DEBUG 1-3 씨앗정보', @seeditemcode_ seeditemcode_, @seeditemcodenew seeditemcodenew, @cashcostsell cashcostsell, @gamecostsell gamecostsell, @harvestcnt harvestcnt, @harvesttime harvesttime, @harvestcashcost harvestcashcost, @harvestitemcode harvestitemcode

	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '아이디가 존재하지 않는다.'
			--select 'DEBUG ' + @comment
		END
	else if(@seeditemcode = @USERSEED_NEED_BUY)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NEED_BUY
			set @comment 	= '경작지를 구매하지 않음.'
			--select 'DEBUG ' + @comment
		END
	else if(@seeditemcode >= 600 and @seeditemcode <=699)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '이미 씨앗이 있습니다.'
			--select 'DEBUG ' + @comment
		END
	else if(@seeditemcodenew = -444)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_ITEMCODE
			set @comment 	= '씨앗 정보를 못찾았습니다.'
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
			set @comment = 'SUCCESS 경작지에 씨앗을 심는다.'
			--select 'DEBUG ' + @comment

			-- 경작지 심기.
			update dbo.tUSerSeed
				set
					itemcode 		= @seeditemcode_,
					seedstartdate	= getdate(),
					seedenddate		= DATEADD(ss, @harvesttime, getdate())
			where gameid = @gameid_ and seedidx = @seedidx_

			-- 비용차감.
			set @cashcost	= @cashcost - @cashcostsell
			set @gamecost	= @gamecost - @gamecostsell

			-- 사용건초계산.
			set @feeduse_ = case
								when @feeduse_ < 0 then (-@feeduse_)
								else @feeduse_
							end

			set @feed 		= @feed - @feeduse_
			set @qtfeeduse 	= @qtfeeduse + @feeduse_

			--set @feed = case when @feed < 0 then 0 else @feed end

			-----------------------------------
			-- 구매기록마킹
			-----------------------------------
			exec spu_UserItemBuyLogNew @gameid_, @seeditemcode_, @gamecostsell, @cashcostsell, 0
		END

	--------------------------------------------------------------
	-- 상태 코드 정보값.
	--------------------------------------------------------------
	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost, @feed feed, @heart heart

	if(@nResult_ = @RESULT_SUCCESS)
		begin
			-------------------------------------------------------------
			-- 일반결과는 상단에 노출됩니다.
			-------------------------------------------------------------

			-----------------------------------
			-- 유저 정보 반영.
			-----------------------------------
			update dbo.tUserMaster
			set
				cashcost		= @cashcost,
				gamecost		= @gamecost,
				feed			= @feed,
				heart			= @heart,

				qtfeeduse		= @qtfeeduse
			where gameid = @gameid_

			--------------------------------------------------------------
			-- 심은 정보.
			--------------------------------------------------------------
			select * from dbo.tUserSeed where gameid = @gameid_ and seedidx = @seedidx_
		end
	--else
	--	begin
	--		-------------------------------------------------------------
	--		-- 일반결과는 상단에 노출됩니다.
	--		-------------------------------------------------------------
	--	end

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
End



