/*
exec spu_FVUserFarmListNew 'xxxx2',   1, 5, 115	-- 게임(리스트)
exec spu_FVUserFarmListNew 'xxxx2', 101, 5, 115	-- 관리용(리스트)

exec spu_FVUserFarmListNew 'farm939088725',   1, 5, 116	-- 게임(리스트)
exec spu_FVUserFarmListNew 'farm939088725', 101, 5, 116	-- 관리용(리스트)
*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVUserFarmListNew', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVUserFarmListNew;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_FVUserFarmListNew
	@gameid_								varchar(60),
	@mode_									int,
	@market_								int,
	@version_								int
	--WITH ENCRYPTION -- 프로시져를 암호화함.
as
	------------------------------------------------
	--
	------------------------------------------------
	-- 구매처코드
	declare @MARKET_SKT							int					set @MARKET_SKT						= 1
	--declare @MARKET_KT						int					set @MARKET_KT						= 2
	--declare @MARKET_LGT						int					set @MARKET_LGT						= 3
	declare @MARKET_GOOGLE						int					set @MARKET_GOOGLE					= 5
	declare @MARKET_NHN							int					set @MARKET_NHN						= 6
	declare @MARKET_IPHONE						int					set @MARKET_IPHONE					= 7

	declare @ITEM_SUBCATEGORY_USERFARM			int					set @ITEM_SUBCATEGORY_USERFARM	 			= 69 -- 전국목장

	-- 신규목장.
	declare @OLD_FARM 							int 				set @OLD_FARM 						= 6929
	declare @NEW_FARM 							int 				set @NEW_FARM 						= 6952

	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @gameyear		int
	declare @itemcodelimit	int					set @itemcodelimit		= @OLD_FARM
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on

	------------------------------------------------
	--	3-2. 템정보
	------------------------------------------------
	set @itemcodelimit = case
								when (@market_ = @MARKET_SKT 	and @version_ >= 110)	then @NEW_FARM
								when (@market_ = @MARKET_GOOGLE and @version_ >= 116)	then @NEW_FARM
								when (@market_ = @MARKET_NHN 	and @version_ >= 103)	then @NEW_FARM
								when (@market_ = @MARKET_IPHONE and @version_ >= 113)	then @NEW_FARM
								else @OLD_FARM
						end


	------------------------------------------------
	--	3-3.
	------------------------------------------------
	if(@mode_ = 1)
		begin
			-- 게임용.
			select * from dbo.tFVUserFarm
			where gameid = @gameid_ and itemcode <= @itemcodelimit
			order by farmidx asc
		end
	else if(@mode_ = 101)
		begin
			-- 관리자 출력용.
			select @gameyear = gameyear from dbo.tFVUserMaster where gameid = @gameid_

			select a.*, b.gamecost,
				DATEDIFF(hh, incomedate, getdate()) * param1 hourcoin2,
				(gamecost + gamecost * param4 * (case when (@gameyear - param3 <= 0) then 0 else (@gameyear - param3) end) / 100) as gamecost2,
				b.itemname, b.param1 hourcoin, b.param2 maxcoin, b.param3 raiseyear, b.param4 raisepercent
				from
					(select * from dbo.tFVUserFarm where gameid = @gameid_ and itemcode <= @itemcodelimit) a
				LEFT JOIN
					(select * from dbo.tFVItemInfo where subcategory = @ITEM_SUBCATEGORY_USERFARM) b
				ON a.itemcode = b.itemcode
			order by itemcode asc
		end
	else


	set nocount off
End

