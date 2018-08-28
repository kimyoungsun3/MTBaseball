-----------------------------------------------------------------------
-- exec spu_FVUserItemRoulLog 'xxxx2', 1, 1, 60045,  0, 400, 200,	1,   -1, -1, -1, -1, 2013, 3, 'xxxx3'	-- 일반
-- exec spu_FVUserItemRoulLog 'xxxx2', 1, 1, 60045,  0, 400, 200,	1,    2,  3,  4,  5, 2013, 3, 'xxxx3'
-- exec spu_FVUserItemRoulLog 'xxxx2', 2, 1, 60045, 20,   0,   0,	8, 1455, -1, -1, -1, 2013, 3, 'xxxx3'	-- 프리미엄
-- exec spu_FVUserItemRoulLog 'xxxx2', 2, 1, 60045, 20,   0,   0,	8, 1455,  2,  3,  4, 2013, 3, 'xxxx3'
-----------------------------------------------------------------------
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVUserItemRoulLog', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVUserItemRoulLog;
GO

create procedure dbo.spu_FVUserItemRoulLog
	@gameid_								varchar(60),		-- 게임아이디
	@mode_									int,
	@framelv_								int,
	@itemcode_								int,
	@cashcost_								int,
	@gamecost_								int,
	@heart_									int,
	@itemcode0_								int,
	@itemcode1_								int,
	@itemcode2_								int,
	@itemcode3_								int,
	@itemcode4_								int,
	@gameyear_								int,
	@gamemonth_								int,
	@friendid_								varchar(20)
	--WITH ENCRYPTION -- 프로시져를 암호화함.
as

	------------------------------------------------
	--
	------------------------------------------------
	-- 교배뽑기 상수.
	declare @MODE_ROULETTE_NORMAL				int					set @MODE_ROULETTE_NORMAL					= 1	-- 일반교배.
	declare @MODE_ROULETTE_PREMINUM				int					set @MODE_ROULETTE_PREMINUM					= 2	-- 프리미엄교배.

	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @dateid8 	varchar(8)			set @dateid8 			= Convert(varchar(8),Getdate(),112)
	declare @loop 		int
	declare @itemcode	int

	declare @itemcodename	varchar(40)		set @itemcodename		= ''
	declare @itemcode0name	varchar(40)		set @itemcode0name		= ''
	declare @itemcode1name	varchar(40)		set @itemcode1name		= ''
	declare @itemcode2name	varchar(40)		set @itemcode2name		= ''
	declare @itemcode3name	varchar(40)		set @itemcode3name		= ''
	declare @itemcode4name	varchar(40)		set @itemcode4name		= ''


	declare @frienditemcode	int				set @frienditemcode		= 1
	declare @frienditemname	varchar(40)		set @frienditemname		= '젖소'
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	--select 'DEBUG 구매', @gameid_ gameid_, @mode_ mode_, @framelv_ framelv_, @itemcode_ itemcode_, @cashcost_ cashcost_, @gamecost_ gamecost_, @heart_ heart_, @itemcode0_ itemcode0_, @itemcode1_ itemcode1_, @itemcode2_ itemcode2_, @itemcode3_ itemcode3_, @itemcode4_ itemcode4_

	------------------------------------------------
	--	3-2-1. 구매했던 로그(개인)
	------------------------------------------------
	select @itemcodename = itemname from dbo.tFVItemInfo where itemcode = @itemcode_
	select @itemcode0name = itemname from dbo.tFVItemInfo where itemcode = @itemcode0_
	select @itemcode1name = itemname from dbo.tFVItemInfo where itemcode = @itemcode1_
	select @itemcode2name = itemname from dbo.tFVItemInfo where itemcode = @itemcode2_
	select @itemcode3name = itemname from dbo.tFVItemInfo where itemcode = @itemcode3_
	select @itemcode4name = itemname from dbo.tFVItemInfo where itemcode = @itemcode4_

	------------------------------------------------
	--	3-2-2. 친구동물(개인)
	------------------------------------------------
	select @frienditemcode = itemcode, @frienditemname = itemname from dbo.tFVItemInfo
		where itemcode = (select top 1 itemcode from dbo.tFVUserItem
					  where gameid = @friendid_
						    and listidx = (select top 1 anireplistidx from dbo.tFVUserMaster where gameid = @friendid_))

	------------------------------------------------
	--	3-2-3. 로그기록
	------------------------------------------------
	--select 'DEBUG 구매했던 로그(개인)기록', @itemcodename itemcodename, @itemcode0name itemcode0name, @itemcode1name itemcode1name, @itemcode2name itemcode2name, @itemcode3name itemcode3name, @itemcode4name itemcode4name
	insert into dbo.tFVRouletteLogPerson(gameid,   kind,   framelv,   itemcode,   cashcost,   gamecost,   heart,   itemcode0,   itemcode1,   itemcode2,   itemcode3,   itemcode4,   itemcodename,  itemcode0name,  itemcode1name,  itemcode2name,  itemcode3name,  itemcode4name,  gameyear,   gamemonth,   friendid,   frienditemcode,  frienditemname)
	values(                           @gameid_, @mode_, @framelv_, @itemcode_, @cashcost_, @gamecost_, @heart_, @itemcode0_, @itemcode1_, @itemcode2_, @itemcode3_, @itemcode4_, @itemcodename, @itemcode0name, @itemcode1name, @itemcode2name, @itemcode3name, @itemcode4name, @gameyear_, @gamemonth_, @friendid_, @frienditemcode, @frienditemname)

	------------------------------------------------
	--	3-2-2. 구매했던 로그(월별 Master)
	------------------------------------------------
	--select 'DEBUG 구매했던 로그(월별 Master) ', @dateid8 dateid8, @mode_ mode_
	if(not exists(select top 1 * from dbo.tFVRouletteLogTotalMaster where dateid8 = @dateid8))
		begin
			--select 'DEBUG > insert'

			insert into dbo.tFVRouletteLogTotalMaster(dateid8)
			values(@dateid8)
		end

	--select 'DEBUG > update'
	update dbo.tFVRouletteLogTotalMaster
		set
			normalcnt 	= normalcnt 	+ case when @mode_ = @MODE_ROULETTE_NORMAL 		then 1 else 0 end,
			premiumcnt 	= premiumcnt 	+ case when @mode_ = @MODE_ROULETTE_PREMINUM 	then 1 else 0 end
	where dateid8 = @dateid8
	--select 'DEBUG ', * from dbo.tFVRouletteLogTotalMaster where dateid8 = @dateid8


	------------------------------------------------
	--	3-2-3. 일별로그 > 세부기록
	------------------------------------------------
	set @loop 		= 0
	while(@loop < 5)
		begin
			set @itemcode 	= case
								when @loop = 0 then @itemcode0_
								when @loop = 1 then @itemcode1_
								when @loop = 2 then @itemcode2_
								when @loop = 3 then @itemcode3_
								when @loop = 4 then @itemcode4_
								else -1
							end

			if(@itemcode != -1)
				begin
					--select 'DEBUG 일별로그 > 세부기록', @dateid8 dateid8, @itemcode itemcode
					if(not exists(select top 1 * from dbo.tFVRouletteLogTotalSub where dateid8 = @dateid8 and itemcode = @itemcode))
						begin
							--select 'DEBUG > insert'
							set @itemcodename 	= case
												when @loop = 0 then @itemcode0name
												when @loop = 1 then @itemcode1name
												when @loop = 2 then @itemcode2name
												when @loop = 3 then @itemcode3name
												when @loop = 4 then @itemcode4name
												else ''
											end

							insert into dbo.tFVRouletteLogTotalSub(dateid8, itemcode, itemcodename)
							values(@dateid8, @itemcode, @itemcodename)
						end

					--select 'DEBUG > update'
					update dbo.tFVRouletteLogTotalSub
						set
							normalcnt 	= normalcnt 	+ case when @mode_ = @MODE_ROULETTE_NORMAL 		then 1 else 0 end,
							premiumcnt 	= premiumcnt 	+ case when @mode_ = @MODE_ROULETTE_PREMINUM 	then 1 else 0 end
					where dateid8 = @dateid8 and itemcode = @itemcode
				end
			set @loop = @loop + 1
		end



	------------------------------------------------
	--	4-1. 종류
	------------------------------------------------
	set nocount off
End


