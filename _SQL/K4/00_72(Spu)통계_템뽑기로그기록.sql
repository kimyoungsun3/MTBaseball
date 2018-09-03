use Game4FarmVill4
GO
/*
exec spu_FVUserItemRoulLog 'xxxx2',  1, 500, 80010,     0, 0, 400, 80010, -1, -1, -1, -1, -1, 10, 10
exec spu_FVUserItemRoulLog 'xxxx2',  2, 500, 80010,  2000, 0,   0, 80010, -1, -1, -1, -1, -1, 10, 10
exec spu_FVUserItemRoulLog 'xxxx2',  3, 500, 80010,  4000, 0,   0, 80010, -1, -1, -1, -1, -1, 10, 10
exec spu_FVUserItemRoulLog 'xxxx2',  4, 500, 80010, 12000, 0,   0, 80010, -1, -1, -1, -1, -1, 10, 10

exec spu_FVUserItemRoulLog 'xxxx2', 12, 500, 80010,     0, 0,   0, 80010, -1, -1, -1, -1, -1, 10, 10
exec spu_FVUserItemRoulLog 'xxxx2', 13, 500, 80010,     0, 0,   0, 80010, -1, -1, -1, -1, -1, 10, 10
exec spu_FVUserItemRoulLog 'xxxx2', 14, 500, 80010,     0, 0,   0, 80010, -1, -1, -1, -1, -1, 10, 10


select * from dbo.tFVRouletteLogPerson where gameid = 'xxxx2'
select * from dbo.tFVRouletteLogTotalMaster
select * from dbo.tFVRouletteLogTotalSub
*/
IF OBJECT_ID ( 'dbo.spu_FVUserItemRoulLog', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVUserItemRoulLog;
GO

create procedure dbo.spu_FVUserItemRoulLog
	@gameid_								varchar(20),		-- 게임아이디
	@mode_									int,
	@bestani_								int,
	@itemcode_								int,
	@cashcost_								int,
	@gamecost_								int,
	@heart_									int,
	@itemcode0_								int,
	@itemcode1_								int,
	@itemcode2_								int,
	@itemcode3_								int,
	@itemcode4_								int,
	@strange_								int,
	@ownercashcost_							bigint,
	@ownercashcost2_						bigint
	--WITH ENCRYPTION -- 프로시져를 암호화함.
as

	------------------------------------------------
	--
	------------------------------------------------
	-- 뽑기 상수.
	declare @MODE_ROULETTE_GRADE1				int					set @MODE_ROULETTE_GRADE1					= 1		-- 일반뽑기.
	declare @MODE_ROULETTE_GRADE2				int					set @MODE_ROULETTE_GRADE2					= 2		-- 결정뽑기.
	declare @MODE_ROULETTE_GRADE3				int					set @MODE_ROULETTE_GRADE3					= 3		--
	declare @MODE_ROULETTE_GRADE4				int					set @MODE_ROULETTE_GRADE4					= 4	   	--
	declare @MODE_ROULETTE_GRADE2_FREE			int					set @MODE_ROULETTE_GRADE2_FREE				= 12	-- 결정뽑기(무료).
	declare @MODE_ROULETTE_GRADE3_FREE			int					set @MODE_ROULETTE_GRADE3_FREE				= 13	--
	declare @MODE_ROULETTE_GRADE4_FREE			int					set @MODE_ROULETTE_GRADE4_FREE				= 14	--

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

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	--select 'DEBUG 구매', @gameid_ gameid_, @mode_ mode_, @bestani_ bestani_, @itemcode_ itemcode_, @cashcost_ cashcost_, @gamecost_ gamecost_, @heart_ heart_, @itemcode0_ itemcode0_, @itemcode1_ itemcode1_, @itemcode2_ itemcode2_, @itemcode3_ itemcode3_, @itemcode4_ itemcode4_

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
	--	3-2-3. 로그기록
	------------------------------------------------
	--select 'DEBUG 구매했던 로그(개인)기록', @itemcodename itemcodename, @itemcode0name itemcode0name
	insert into dbo.tFVRouletteLogPerson(gameid,   kind,   bestani,   itemcode,   itemcodename,  cashcost,   gamecost,   heart,   itemcode0,   itemcode1,   itemcode2,   itemcode3,   itemcode4,   itemcode0name,  itemcode1name,  itemcode2name,  itemcode3name,  itemcode4name,  ownercashcost,   ownercashcost2,   strange)
	values(                             @gameid_, @mode_, @bestani_, @itemcode_, @itemcodename, @cashcost_, @gamecost_, @heart_, @itemcode0_, @itemcode1_, @itemcode2_, @itemcode3_, @itemcode4_, @itemcode0name, @itemcode1name, @itemcode2name, @itemcode3name, @itemcode4name, @ownercashcost_, @ownercashcost2_, @strange_)


	------------------------------------------------
	--	3-2-2. 구매했던 로그(월별 Master)
	------------------------------------------------
	--select 'DEBUG 구매했던 로그(월별 Master) ', @dateid8 dateid8, @mode_ mode_
	if(not exists(select top 1 * from dbo.tFVRouletteLogTotalMaster where dateid8 = @dateid8))
		begin
			--select 'DEBUG > insert'

			insert into dbo.tFVRouletteLogTotalMaster(dateid8)
			values(                                  @dateid8)
		end

	--select 'DEBUG > update'
	update dbo.tFVRouletteLogTotalMaster
		set
			tsgrade1cnt		= tsgrade1cnt 		+ case when @mode_ = @MODE_ROULETTE_GRADE1 		then 1 else 0 end,
			tsgrade2cnt		= tsgrade2cnt 		+ case when @mode_ = @MODE_ROULETTE_GRADE2 		then 1 else 0 end,
			tsgrade3cnt		= tsgrade3cnt 		+ case when @mode_ = @MODE_ROULETTE_GRADE3 		then 1 else 0 end,
			tsgrade4cnt		= tsgrade4cnt 		+ case when @mode_ = @MODE_ROULETTE_GRADE4 		then 1 else 0 end,
			tsgrade2freecnt	= tsgrade2freecnt 	+ case when @mode_ = @MODE_ROULETTE_GRADE2_FREE then 1 else 0 end,
			tsgrade3freecnt	= tsgrade3freecnt 	+ case when @mode_ = @MODE_ROULETTE_GRADE3_FREE then 1 else 0 end,
			tsgrade4freecnt	= tsgrade4freecnt 	+ case when @mode_ = @MODE_ROULETTE_GRADE4_FREE then 1 else 0 end
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

							insert into dbo.tFVRouletteLogTotalSub(dateid8,  itemcode,  itemcodename)
							values(                               @dateid8, @itemcode, @itemcodename)
						end

					--select 'DEBUG > update'
					update dbo.tFVRouletteLogTotalSub
						set
							tsgrade1cnt		= tsgrade1cnt 		+ case when @mode_ = @MODE_ROULETTE_GRADE1 		then 1 else 0 end,
							tsgrade2cnt		= tsgrade2cnt 		+ case when @mode_ = @MODE_ROULETTE_GRADE2 		then 1 else 0 end,
							tsgrade3cnt		= tsgrade3cnt 		+ case when @mode_ = @MODE_ROULETTE_GRADE3 		then 1 else 0 end,
							tsgrade4cnt		= tsgrade4cnt 		+ case when @mode_ = @MODE_ROULETTE_GRADE4 		then 1 else 0 end,
							tsgrade2freecnt	= tsgrade2freecnt 	+ case when @mode_ = @MODE_ROULETTE_GRADE2_FREE then 1 else 0 end,
							tsgrade3freecnt	= tsgrade3freecnt 	+ case when @mode_ = @MODE_ROULETTE_GRADE3_FREE then 1 else 0 end,
							tsgrade4freecnt	= tsgrade4freecnt 	+ case when @mode_ = @MODE_ROULETTE_GRADE4_FREE then 1 else 0 end
					where dateid8 = @dateid8 and itemcode = @itemcode
				end
			set @loop = @loop + 1
		end



	------------------------------------------------
	--	4-1. 종류
	------------------------------------------------
	set nocount off
End


