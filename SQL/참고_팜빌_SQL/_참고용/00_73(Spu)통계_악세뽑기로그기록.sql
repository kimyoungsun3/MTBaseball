-----------------------------------------------------------------------
/*
exec spu_FVUserItemAccLog 'xxxx2', 1, 9, 0, -1, -1, -1, -1, -1			-- 없어서 리턴
exec spu_FVUserItemAccLog 'xxxx2', 1, 9, 0, 1400, -1, -1, -1, -1			-- 해당정보를 입력
exec spu_FVUserItemAccLog 'xxxx2', 1, 9, 0, 1400, 1401, 1402, 1403, 1404
select top 10 * from dbo.tFVRouletteLogTotalMaster order by idx desc
select top 10 * from dbo.tFVAccRoulLogPerson order by idx desc
*/
-----------------------------------------------------------------------
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVUserItemAccLog', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVUserItemAccLog;
GO

create procedure dbo.spu_FVUserItemAccLog
	@gameid_								varchar(60),		-- 게임아이디
	@framelv_								int,
	@cashcost_								int,
	@gamecost_								int,
	@itemcode0_								int,
	@itemcode1_								int,
	@itemcode2_								int,
	@itemcode3_								int,
	@itemcode4_								int
	--WITH ENCRYPTION -- 프로시져를 암호화함.
as

	------------------------------------------------
	--
	------------------------------------------------
	-- 교배뽑기 상수.
	declare @MODE_ROULETTE_ACC				int					set @MODE_ROULETTE_ACC					= 3

	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @dateid8 		varchar(8)		set @dateid8 			= Convert(varchar(8),Getdate(),112)
	declare @itemcode		int
	declare @itemcode0name	varchar(40)		set @itemcode0name		= ''
	declare @itemcode1name	varchar(40)		set @itemcode1name		= ''
	declare @itemcode2name	varchar(40)		set @itemcode2name		= ''
	declare @itemcode3name	varchar(40)		set @itemcode3name		= ''
	declare @itemcode4name	varchar(40)		set @itemcode4name		= ''

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	--select 'DEBUG 구매', @gameid_ gameid_, @framelv_ framelv_, @cashcost_ cashcost_, @gamecost_ gamecost_, @itemcode0_ itemcode0_, @itemcode1_ itemcode1_, @itemcode2_ itemcode2_, @itemcode3_ itemcode3_, @itemcode4_ itemcode4_
	if(@itemcode0_ = -1 and @itemcode1_ = -1 and @itemcode2_ = -1 and @itemcode3_ = -1 and @itemcode4_ = -1)
		begin
			----select 'DEBUG 없어서 그냥 리턴함'
			return;
		end

	------------------------------------------------
	--	3-2-1. 구매했던 로그(개인)
	------------------------------------------------
	if(@itemcode0_ != -1)
		begin
			select @itemcode0name = itemname from dbo.tFVItemInfo where itemcode = @itemcode0_
		end
	if(@itemcode1_ != -1)
		begin
			select @itemcode1name = itemname from dbo.tFVItemInfo where itemcode = @itemcode1_
		end
	if(@itemcode2_ != -1)
		begin
			select @itemcode2name = itemname from dbo.tFVItemInfo where itemcode = @itemcode2_
		end
	if(@itemcode3_ != -1)
		begin
			select @itemcode3name = itemname from dbo.tFVItemInfo where itemcode = @itemcode3_
		end
	if(@itemcode4_ != -1)
		begin
			select @itemcode4name = itemname from dbo.tFVItemInfo where itemcode = @itemcode4_
		end
	--select 'DEBUG 구매했던 로그(개인)기록', @itemcode0name itemcode0name, @itemcode1name itemcode1name, @itemcode2name itemcode2name, @itemcode3name itemcode3name, @itemcode4name itemcode4name

	------------------------------------------------
	--	3-2-3. 로그기록
	------------------------------------------------
	insert into dbo.tFVAccRoulLogPerson(gameid,                kind,  framelv,   cashcost,   gamecost,   itemcode0,   itemcode1,   itemcode2,   itemcode3,   itemcode4,   itemcode0name,  itemcode1name,  itemcode2name,  itemcode3name,  itemcode4name)
	values(                          @gameid_, @MODE_ROULETTE_ACC, @framelv_, @cashcost_, @gamecost_, @itemcode0_, @itemcode1_, @itemcode2_, @itemcode3_, @itemcode4_, @itemcode0name, @itemcode1name, @itemcode2name, @itemcode3name, @itemcode4name)

	------------------------------------------------
	--	3-2-2. 구매했던 로그(월별 Master)
	------------------------------------------------
	--select 'DEBUG 구매했던 로그(월별 Master) ', @dateid8 dateid8
	if(not exists(select top 1 * from dbo.tFVRouletteLogTotalMaster where dateid8 = @dateid8))
		begin
			--select 'DEBUG > insert'

			insert into dbo.tFVRouletteLogTotalMaster(dateid8)
			values(@dateid8)
		end

	--select 'DEBUG > update'
	update dbo.tFVRouletteLogTotalMaster
		set
			acccnt 	= acccnt 	+ 1
	where dateid8 = @dateid8
	--select 'DEBUG ', * from dbo.tFVRouletteLogTotalMaster where dateid8 = @dateid8


	------------------------------------------------
	--	4-1. 종류
	------------------------------------------------
	set nocount off
End


