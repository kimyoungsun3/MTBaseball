/*
exec spu_UserFarmListNew 'xxxx2',   1, 5, 115	-- ����(����Ʈ)
exec spu_UserFarmListNew 'xxxx2', 101, 5, 115	-- ������(����Ʈ)

exec spu_UserFarmListNew 'farm939088725',   1, 5, 116	-- ����(����Ʈ)
exec spu_UserFarmListNew 'farm939088725', 101, 5, 116	-- ������(����Ʈ)
*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_UserFarmListNew', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_UserFarmListNew;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_UserFarmListNew
	@gameid_								varchar(20),
	@mode_									int,
	@market_								int,
	@version_								int
	--WITH ENCRYPTION -- ���ν����� ��ȣȭ��.
as
	------------------------------------------------
	--
	------------------------------------------------
	declare @ITEM_SUBCATEGORY_USERFARM			int					set @ITEM_SUBCATEGORY_USERFARM	 			= 69 -- ��������


	------------------------------------------------
	--	2-3. ���λ�� ����
	------------------------------------------------
	declare @gameyear		int
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on

	------------------------------------------------
	--	3-3.
	------------------------------------------------
	if(@mode_ = 1)
		begin
			-- ���ӿ�.
			select * from dbo.tUserFarm where gameid = @gameid_
			order by farmidx asc
		end
	else if(@mode_ = 101)
		begin
			-- ������ ��¿�.
			select @gameyear = gameyear from dbo.tUserMaster where gameid = @gameid_

			select a.*, b.gamecost,
				DATEDIFF(hh, incomedate, getdate()) * param1 hourcoin2,
				(gamecost + gamecost * param4 * (case when (@gameyear - param3 <= 0) then 0 else (@gameyear - param3) end) / 100) as gamecost2,
				b.itemname, b.param1 hourcoin, b.param2 maxcoin, b.param3 raiseyear, b.param4 raisepercent
				from
					(select * from dbo.tUserFarm where gameid = @gameid_) a
				LEFT JOIN
					(select * from dbo.tItemInfo where subcategory = @ITEM_SUBCATEGORY_USERFARM) b
				ON a.itemcode = b.itemcode
			order by itemcode asc
		end
	else


	set nocount off
End

