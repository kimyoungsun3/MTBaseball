/*
exec spu_UserItemTreasureLogNew 'xxxx2', 1, 1, 130001,    0, 400, 200,	120010,     -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 2013, 3	-- 일반
exec spu_UserItemTreasureLogNew 'xxxx2', 2, 1, 130001,  300,   0,   0,	120011, 120012, -1, -1, -1, -1, -1, -1, -1, -1, -1, 2013, 3	-- 프리미엄
exec spu_UserItemTreasureLogNew 'xxxx2', 4, 1, 130001, 3000,   0,   0,	120013, 120014, -1, -1, -1, -1, -1, -1, -1, -1, -1, 2013, 3	-- 프리미엄10

--update dbo.tTreasureLogPerson set idx2 = 0 where idx2 is null
--select * from dbo.tTreasureLogPerson where gameid = 'xxxx2'
*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_UserItemTreasureLogNew', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_UserItemTreasureLogNew;
GO

create procedure dbo.spu_UserItemTreasureLogNew
	@gameid_								varchar(20),		-- 게임아이디
	@mode_									int,
	@framelv_								int,
	@itemcode_								int,
	@cashcost_								int,
	@gamecost_								int,
	@heart_									int,
	@itemcode1_								int,
	@itemcode2_								int,
	@itemcode3_								int,
	@itemcode4_								int,
	@itemcode5_								int,
	@itemcode6_								int,
	@itemcode7_								int,
	@itemcode8_								int,
	@itemcode9_								int,
	@itemcode10_							int,
	@itemcode11_							int,
	@gameyear_								int,
	@gamemonth_								int
	--WITH ENCRYPTION -- 프로시져를 암호화함.
as

	------------------------------------------------
	--
	------------------------------------------------
	-- 보물뽑기 상수.
	declare @MODE_TREASURE_GRADE1				int					set @MODE_TREASURE_GRADE1					= 1		-- 일반뽑기.
	declare @MODE_TREASURE_GRADE2				int					set @MODE_TREASURE_GRADE2					= 2		-- 루비뽑기.
	declare @MODE_TREASURE_GRADE4				int					set @MODE_TREASURE_GRADE4					= 4	   	-- 루비뽑기 10 + 1.
	declare @MODE_TREASURE_GRADE2_FREE			int					set @MODE_TREASURE_GRADE2_FREE				= 12	-- 루비뽑기			(무료).
	declare @MODE_TREASURE_GRADE4_FREE			int					set @MODE_TREASURE_GRADE4_FREE				= 14	-- 루비뽑기 10 + 1	(무료).
	declare @MODE_TREASURE_GRADE1_TICKET		int					set @MODE_TREASURE_GRADE1_TICKET			= 21	-- 일반뽑기			(티켓).
	declare @MODE_TREASURE_GRADE2_TICKET		int					set @MODE_TREASURE_GRADE2_TICKET			= 22	-- 루비뽑기			(티켓).
	declare @MODE_TREASURE_GRADE4_TICKET		int					set @MODE_TREASURE_GRADE4_TICKET			= 24	-- 루비뽑기 10 + 1 	(티켓).

	declare @USER_LOGOLIST_MAX					int					set @USER_LOGOLIST_MAX 						= 200

	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @dateid8 	varchar(8)			set @dateid8 			= Convert(varchar(8),Getdate(),112)
	declare @loop 		int
	declare @itemcode	int
	declare @idx2		int					set @idx2 		= 0

	declare @itemcodename	varchar(40)		set @itemcodename		= ''
	declare @itemcode1name	varchar(40)		set @itemcode1name		= ''
	declare @itemcode2name	varchar(40)		set @itemcode2name		= ''
	declare @itemcode3name	varchar(40)		set @itemcode3name		= ''
	declare @itemcode4name	varchar(40)		set @itemcode4name		= ''
	declare @itemcode5name	varchar(40)		set @itemcode5name		= ''
	declare @itemcode6name	varchar(40)		set @itemcode6name		= ''
	declare @itemcode7name	varchar(40)		set @itemcode7name		= ''
	declare @itemcode8name	varchar(40)		set @itemcode8name		= ''
	declare @itemcode9name	varchar(40)		set @itemcode9name		= ''
	declare @itemcode10name	varchar(40)		set @itemcode10name		= ''
	declare @itemcode11name	varchar(40)		set @itemcode11name		= ''
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	--select 'DEBUG 구매', @gameid_ gameid_, @mode_ mode_, @framelv_ framelv_, @itemcode_ itemcode_, @cashcost_ cashcost_, @gamecost_ gamecost_, @heart_ heart_, @itemcode1_ itemcode1_, @itemcode2_ itemcode2_, @itemcode3_ itemcode3_, @itemcode4_ itemcode4_, @itemcode5_ itemcode5_

	------------------------------------------------
	--	3-2-1. 구매했던 로그(개인)
	------------------------------------------------
	select @itemcodename  = itemname from dbo.tItemInfo where itemcode = @itemcode_
	if( @itemcode1_ != -1 )
		begin
			select @itemcode1name = itemname from dbo.tItemInfo where itemcode = @itemcode1_
			select @itemcode2name = itemname from dbo.tItemInfo where itemcode = @itemcode2_
			select @itemcode3name = itemname from dbo.tItemInfo where itemcode = @itemcode3_
			select @itemcode4name = itemname from dbo.tItemInfo where itemcode = @itemcode4_
			select @itemcode5name = itemname from dbo.tItemInfo where itemcode = @itemcode5_
			select @itemcode6name = itemname from dbo.tItemInfo where itemcode = @itemcode6_
			select @itemcode7name = itemname from dbo.tItemInfo where itemcode = @itemcode7_
			select @itemcode8name = itemname from dbo.tItemInfo where itemcode = @itemcode8_
			select @itemcode9name = itemname from dbo.tItemInfo where itemcode = @itemcode9_
			select @itemcode10name= itemname from dbo.tItemInfo where itemcode = @itemcode10_
			select @itemcode11name= itemname from dbo.tItemInfo where itemcode = @itemcode11_
		end

	------------------------------------------------
	--	3-2-3. 로그기록, 일부는 삭제.
	------------------------------------------------
	select top 1 @idx2 = isnull(idx2, 1) from dbo.tTreasureLogPerson where gameid = @gameid_ order by idx desc
	set @idx2 = @idx2 + 1

	--select 'DEBUG 구매했던 로그(개인)기록', @itemcodename itemcodename, @itemcode1name itemcode1name, @itemcode2name itemcode2name, @itemcode3name itemcode3name, @itemcode4name itemcode4name, @itemcode5name itemcode5name
	insert into dbo.tTreasureLogPerson(idx2,  gameid,   kind,   framelv,   itemcode,   cashcost,   gamecost,   heart,   itemcode0,   itemcode1,   itemcode2,   itemcode3,   itemcode4,   itemcode5,   itemcode6,   itemcode7,   itemcode8,   itemcode9,    itemcode10,   itemcodename,  itemcode0name,  itemcode1name,  itemcode2name,  itemcode3name,  itemcode4name,  itemcode5name,  itemcode6name,  itemcode7name,  itemcode8name,  itemcode9name,   itemcode10name,  gameyear,   gamemonth)
	values(                           @idx2, @gameid_, @mode_, @framelv_, @itemcode_, @cashcost_, @gamecost_, @heart_, @itemcode1_, @itemcode2_, @itemcode3_, @itemcode4_, @itemcode5_, @itemcode6_, @itemcode7_, @itemcode8_, @itemcode9_, @itemcode10_, @itemcode11_, @itemcodename, @itemcode1name, @itemcode2name, @itemcode3name, @itemcode4name, @itemcode5name, @itemcode6name, @itemcode7name, @itemcode8name, @itemcode9name, @itemcode10name, @itemcode11name, @gameyear_, @gamemonth_)

	-- 일부 로고를 삭제함.
	delete dbo.tTreasureLogPerson where gameid = @gameid_ and idx2 <= @idx2 - @USER_LOGOLIST_MAX

	------------------------------------------------
	--	3-2-2. 구매했던 로그(월별 Master)
	------------------------------------------------
	--select 'DEBUG 구매했던 로그(월별 Master) ', @dateid8 dateid8, @mode_ mode_
	if(not exists(select top 1 * from dbo.tTreasureLogTotalMaster where dateid8 = @dateid8))
		begin
			--select 'DEBUG > insert'
			insert into dbo.tTreasureLogTotalMaster(dateid8)
			values(                                @dateid8)
		end

	--select 'DEBUG > update'
	update dbo.tTreasureLogTotalMaster
		set
			normalcnt 	= normalcnt 	+ case when @mode_ in ( @MODE_TREASURE_GRADE1,                             @MODE_TREASURE_GRADE1_TICKET ) 	then 1 else 0 end,
			premiumcnt 	= premiumcnt 	+ case when @mode_ in ( @MODE_TREASURE_GRADE2, @MODE_TREASURE_GRADE2_FREE, @MODE_TREASURE_GRADE2_TICKET ) 	then 1 else 0 end,
			premiumcnt4	= premiumcnt4 	+ case when @mode_ in ( @MODE_TREASURE_GRADE4, @MODE_TREASURE_GRADE4_FREE, @MODE_TREASURE_GRADE4_TICKET ) 	then 1 else 0 end
	where dateid8 = @dateid8
	--select 'DEBUG ', * from dbo.tTreasureLogTotalMaster where dateid8 = @dateid8


	------------------------------------------------
	--	3-2-3. 일별로그 > 세부기록
	------------------------------------------------
	set @loop 		= 0
	while(@loop < 11)
		begin
			set @itemcode 	= case
								when @loop = 0 then @itemcode1_
								when @loop = 1 then @itemcode2_
								when @loop = 2 then @itemcode3_
								when @loop = 3 then @itemcode4_
								when @loop = 4 then @itemcode5_
								when @loop = 5 then @itemcode6_
								when @loop = 6 then @itemcode7_
								when @loop = 7 then @itemcode8_
								when @loop = 8 then @itemcode9_
								when @loop = 9 then @itemcode10_
								when @loop = 10 then @itemcode11_
								else -1
							end

			if(@itemcode != -1)
				begin
					--select 'DEBUG 일별로그 > 세부기록', @dateid8 dateid8, @itemcode itemcode
					if(not exists(select top 1 * from dbo.tTreasureLogTotalSub where dateid8 = @dateid8 and itemcode = @itemcode))
						begin
							--select 'DEBUG > insert'
							set @itemcodename 	= case
												when @loop = 0 then @itemcode1name
												when @loop = 1 then @itemcode2name
												when @loop = 2 then @itemcode3name
												when @loop = 3 then @itemcode4name
												when @loop = 4 then @itemcode5name
												when @loop = 5 then @itemcode6name
												when @loop = 6 then @itemcode7name
												when @loop = 7 then @itemcode8name
												when @loop = 8 then @itemcode9name
												when @loop = 9 then @itemcode10name
												when @loop = 10 then @itemcode11name
												else ''
											end

							insert into dbo.tTreasureLogTotalSub(dateid8,  itemcode,  itemcodename)
							values(                             @dateid8, @itemcode, @itemcodename)
						end

					--select 'DEBUG > update'
					update dbo.tTreasureLogTotalSub
						set
							normalcnt 	= normalcnt 	+ case when @mode_ in ( @MODE_TREASURE_GRADE1,                             @MODE_TREASURE_GRADE1_TICKET ) 	then 1 else 0 end,
							premiumcnt 	= premiumcnt 	+ case when @mode_ in ( @MODE_TREASURE_GRADE2, @MODE_TREASURE_GRADE2_FREE, @MODE_TREASURE_GRADE2_TICKET ) 	then 1 else 0 end,
							premiumcnt4	= premiumcnt4 	+ case when @mode_ in ( @MODE_TREASURE_GRADE4, @MODE_TREASURE_GRADE4_FREE, @MODE_TREASURE_GRADE4_TICKET ) 	then 1 else 0 end
					where dateid8 = @dateid8 and itemcode = @itemcode
				end
			set @loop = @loop + 1
		end


	------------------------------------------------
	--	4-1. 종류
	------------------------------------------------
	set nocount off
End


