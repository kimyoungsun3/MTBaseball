/*
select top 5 'DEBUG', idx, idx2, gameid, kakaonickname, trophy, tier, aniitemcode1, upcnt1, attstem1, aniitemcode2, upcnt2, attstem2, aniitemcode3, upcnt3, attstem3 from tUserBattleBank where tier = 1 and userdata = 0 union
select top 5 'DEBUG', idx, idx2, gameid, kakaonickname, trophy, tier, aniitemcode1, upcnt1, attstem1, aniitemcode2, upcnt2, attstem2, aniitemcode3, upcnt3, attstem3 from tUserBattleBank where tier = 2 and userdata = 0 union
select top 5 'DEBUG', idx, idx2, gameid, kakaonickname, trophy, tier, aniitemcode1, upcnt1, attstem1, aniitemcode2, upcnt2, attstem2, aniitemcode3, upcnt3, attstem3 from tUserBattleBank where tier = 3 and userdata = 0 union
select top 5 'DEBUG', idx, idx2, gameid, kakaonickname, trophy, tier, aniitemcode1, upcnt1, attstem1, aniitemcode2, upcnt2, attstem2, aniitemcode3, upcnt3, attstem3 from tUserBattleBank where tier = 4 and userdata = 0 union
select top 5 'DEBUG', idx, idx2, gameid, kakaonickname, trophy, tier, aniitemcode1, upcnt1, attstem1, aniitemcode2, upcnt2, attstem2, aniitemcode3, upcnt3, attstem3 from tUserBattleBank where tier = 5 and userdata = 0 union
select top 5 'DEBUG', idx, idx2, gameid, kakaonickname, trophy, tier, aniitemcode1, upcnt1, attstem1, aniitemcode2, upcnt2, attstem2, aniitemcode3, upcnt3, attstem3 from tUserBattleBank where tier = 6 and userdata = 0 union
select top 5 'DEBUG', idx, idx2, gameid, kakaonickname, trophy, tier, aniitemcode1, upcnt1, attstem1, aniitemcode2, upcnt2, attstem2, aniitemcode3, upcnt3, attstem3 from tUserBattleBank where tier = 7 and userdata = 0 union
select top 5 'DEBUG', idx, idx2, gameid, kakaonickname, trophy, tier, aniitemcode1, upcnt1, attstem1, aniitemcode2, upcnt2, attstem2, aniitemcode3, upcnt3, attstem3 from tUserBattleBank where tier = 8 order by trophy asc

-- 각트로피군.
select trophy, count(*) from dbo.tUserBattleBank group by trophy order by 1 asc
select * from dbo.tUserBattleBank where aniitemcode1 = -1 and aniitemcode2 = -1 and aniitemcode3 = -1
select * from dbo.tUserBattleBank where trophy >= 800 and ( aniitemcode1 = -1 or aniitemcode2 = -1 or aniitemcode3 = -1 )
--delete from dbo.tUserBattleBank where aniitemcode1 = -1 and aniitemcode2 = -1 and aniitemcode3 = -1
--delete from dbo.tUserBattleBank where trophy >= 800 and ( aniitemcode1 = -1 or aniitemcode2 = -1 or aniitemcode3 = -1 )

-- 실제검색
exec spu_UserBattleStart 'farm484968', '2173403f8l7a9b455788', '0:190;1:195;2:194;', 				-1
*/

use GameMTBaseball
GO

declare @userdata				int					set @userdata			= 0 --가이드 데이타.
declare @gameid			varchar(20),
		@kakaonickname	varchar(40),
		@loop 			int,
		@loopmax		int,
		@aniper			int,
		@anilv			int,
		@idx			int,
		@idx2			int,
		@idxs1			int,
		@idxs2			int,
		@idxs3			int,
		@trophymin		int,
		@trophymax		int,
		@trophyrand		int,
		@trophy			int,
		@tier			int

declare @aniitemcode1			int					set @aniitemcode1		= -1
declare @upcnt1					int					set @upcnt1				= 0
declare @attstem1				int					set @attstem1			= 0
declare @defstem1				int					set @defstem1			= 0
declare @hpstem1				int					set @hpstem1			= 0
declare @timestem1				int					set @timestem1			= 0
declare @grade1					int					set @grade1				= 0
declare @ttatt1					int					set @ttatt1				= 0


declare @aniitemcode2			int					set @aniitemcode2		= -1
declare @upcnt2					int					set @upcnt2				= 0
declare @attstem2				int					set @attstem2			= 0
declare @defstem2				int					set @defstem2			= 0
declare @hpstem2				int                 set @hpstem2			= 0
declare @timestem2				int				    set @timestem2			= 0
declare @grade2					int					set @grade2				= 0
declare @ttatt2					int					set @ttatt2				= 0

declare @aniitemcode3			int					set @aniitemcode3		= -1
declare @upcnt3					int					set @upcnt3				= 0
declare @attstem3				int					set @attstem3			= 0
declare @defstem3				int					set @defstem3			= 0
declare @hpstem3				int					set @hpstem3			= 0
declare @timestem3				int					set @timestem3			= 0
declare @grade3					int					set @grade3				= 0
declare @ttatt3					int					set @ttatt3				= 0

declare @treasure1			int,
		@treasure2			int,
		@treasure3			int,
		@treasure4			int,
		@treasure5			int,
		@treasureupgrade1	int,
		@treasureupgrade2	int,
		@treasureupgrade3	int,
		@treasureupgrade4	int,
		@treasureupgrade5	int,
		@skillcode1			int,
		@skillcode2			int,
		@skillcode3			int,
		@skillcode4			int,
		@skillcode5			int

DECLARE @tItemExpire TABLE(
	idx				int 		IDENTITY(1, 1) PRIMARY KEY,
	gameid			varchar(20),
	kakaonickname	varchar(40),
	idx2			int,		-- total idx
	idx3			int,		-- person idx

	--trophy		int,
	--tier			int,
	itemcode		int,
	upcnt			int,
	attstem			int,
	timestem		int,
	defstem			int,
	hpstem			int,

	ttatt			int,
	tthp			int,
	grade			int,
	kind			int
);


DECLARE @tTempBank TABLE(
	idx			int 					IDENTITY(1, 1),
	idx2		int,

	gameid			varchar(20),
	kakaonickname	varchar(40)			default(''),
	trophy			int					default(0),
	tier			int					default(0),

	aniitemcode1	int					default(-1),
	upcnt1			int					default(0),
	attstem1		int					default(0),
	defstem1		int					default(0),
	hpstem1			int					default(0),
	timestem1		int					default(0),
	grade1			int					default(0),
	ttatt1			int					default(0),

	aniitemcode2	int					default(-1),
	upcnt2			int					default(0),
	attstem2		int					default(0),
	defstem2		int					default(0),
	hpstem2			int					default(0),
	timestem2		int					default(0),
	grade2			int					default(0),
	ttatt2			int					default(0),

	aniitemcode3	int					default(-1),
	upcnt3			int					default(0),
	attstem3		int					default(0),
	defstem3		int					default(0),
	hpstem3			int					default(0),
	timestem3		int					default(0),
	grade3			int					default(0),
	ttatt3			int					default(0),


	idxs1			int					default(0),
	idxs2			int					default(0),
	idxs3			int					default(0),

	treasure1		int					default(-1),
	treasure2		int					default(-1),
	treasure3		int					default(-1),
	treasure4		int					default(-1),
	treasure5		int					default(-1),
	treasureupgrade1	int				default(0),
	treasureupgrade2	int				default(0),
	treasureupgrade3	int				default(0),
	treasureupgrade4	int				default(0),
	treasureupgrade5	int				default(0),

	userdata		int					default(1)
);

------------------------------------------------------
-- 0-1. 가상데이타 삭제.
------------------------------------------------------
--select top 3 'DEBUG (실유저)', * from dbo.tUserBattleBank where gameid = 'farm474722' and userdata = 1 order by idx desc
delete from dbo.tUserBattleBank where userdata = @userdata
select 'DEBUG 가상데이타 삭제', @userdata userdata


------------------------------------------------------
-- 1-1. 동물강화(실제8강)
-- 1-2. 강화된 동물에서 정보 얻어오기.
------------------------------------------------------
insert into @tItemExpire (gameid, kakaonickname, itemcode, upcnt, attstem, timestem, defstem, hpstem, ttatt, tthp, grade, kind)
select
	gameid, kakaonickname, itemcode, upcnt,
	attstem100, timestem100, defstem100, hpstem100,
	param21 + param22* 8 + attstem100/100 ttatt,	-- att
	--param23 + param24* 8 + timestem100/100,		-- time
	--param25 + param26* 8 + defstem100/100, 		-- def
	param27 + param28* 8 + hpstem100/100 tthp,		-- hp
	grade, 1
		from
			( select itemcode itemcode2, grade, param21, param22, param23, param24, param25, param26, param27, param28, param29, param30 from dbo.tItemInfo where category = 1 ) ii
		JOIN
			( select * from dbo.tUserItem
				where gameid in ( select gameid from dbo.tUserMaster where kakaonickname in (select gameid from dbo.tSample) ) ) ui
		ON ii.itemcode2 = ui.itemcode
		JOIN
			( select gameid gameid2, kakaonickname from dbo.tUserMaster where kakaonickname in (select gameid from dbo.tSample) ) um
		ON um.gameid2 = ui.gameid
order by ttatt asc, tthp asc
--select 'DEBUG (가상유저 강화)', kind, * from @tItemExpire where kind = 1


------------------------------------------------------
-- 1-3. 강화안된 동물희석하기.
------------------------------------------------------
set @anilv = 1
insert into @tItemExpire (gameid, kakaonickname, itemcode, upcnt, attstem, timestem, defstem, hpstem, ttatt, tthp, grade, kind)
select
	gameid, kakaonickname, itemcode, 0,
	0, 0, 0, 0,
	param21 + param22 * @anilv ttatt,	-- att
	param27 + param28 * @anilv tthp,		-- hp
	grade, 2
		from
			( select itemcode itemcode2, grade, param21, param22, param23, param24, param25, param26, param27, param28, param29, param30 from dbo.tItemInfo where category = 1 and itemcode not in (22, 30, 31, 32, 128, 129, 130, 228, 229, 230) and grade <= 1 ) ii
		JOIN
			( select * from dbo.tUserItem
				where gameid in ( select gameid from dbo.tUserMaster where kakaonickname in (select gameid from dbo.tSample) ) ) ui
		ON ii.itemcode2 = ui.itemcode
		JOIN
			( select gameid gameid2, kakaonickname from dbo.tUserMaster where kakaonickname in (select gameid from dbo.tSample) ) um
		ON um.gameid2 = ui.gameid
order by ttatt asc, tthp asc
--select 'DEBUG (가상유저 비강화)', kind, * from @tItemExpire where kind = 2

------------------------------------
-- 2-1. 가상데이타 유저별 순위정렬(idx2).
------------------------------------
select @loopmax = max(idx) from @tItemExpire
set @loop = 0

-- 1. 선언하기.
declare curTotalIdx2 Cursor for
select idx from @tItemExpire order by ttatt asc, tthp asc

-- 2. 커서오픈
open curTotalIdx2

-- 3. 커서 사용
Fetch next from curTotalIdx2 into @idx
while @@Fetch_status = 0
	Begin
		set @trophy = @loop * 3000 / @loopmax

		update @tItemExpire
			set
				idx2 = @trophy
		where idx = @idx

		set @loop = @loop + 1
		Fetch next from curTotalIdx2 into @idx
	end
-- 4. 커서닫기
close curTotalIdx2
Deallocate curTotalIdx2
--select 'DEBUG 전체정렬', * from @tItemExpire order by idx2 asc

------------------------------------
-- 2-2. 가상데이타 유저별 순위정렬(idx3).
------------------------------------

-- 1. 선언하기.
declare curPersonGroup Cursor for
select gameid from @tItemExpire group by gameid

-- 2. 커서오픈
open curPersonGroup

-- 3. 커서 사용
Fetch next from curPersonGroup into @gameid
while @@Fetch_status = 0
	Begin
		select @loopmax = count(idx) from @tItemExpire where gameid = @gameid
		set @loop = 0

		-- 2-1. 선언하기.
		declare curPersonIdx3 Cursor for
		select idx from @tItemExpire where gameid = @gameid
		order by ttatt asc, tthp asc

		-- 2-2. 커서오픈
		open curPersonIdx3

		-- 2-3. 커서 사용
		Fetch next from curPersonIdx3 into @idx
		while @@Fetch_status = 0
			Begin
				set @trophy = @loop * 3000 / @loopmax
				--select @loop loop, @loopmax loopmax, @trophy trophy

				update @tItemExpire
					set
						idx3 = @trophy
				where idx = @idx

				set @loop = @loop + 1
				Fetch next from curPersonIdx3 into @idx
			end
		-- 2-4. 커서닫기
		close curPersonIdx3
		Deallocate curPersonIdx3

		set @loop = @loop + 1
		Fetch next from curPersonGroup into @gameid
	end
-- 4. 커서닫기
close curPersonGroup
Deallocate curPersonGroup
--select 'DEBUG 개인정렬', * from @tItemExpire order by gameid, idx3 asc

------------------------------------
-- 3. 가상데이타 입력.
------------------------------------
-- 1. 선언하기.
declare curBattleBank Cursor for
select gameid, kakaonickname from dbo.tUserMaster where kakaonickname in (select gameid from dbo.tSample)

-- 2. 커서오픈
open curBattleBank

-- 3. 커서 사용
Fetch next from curBattleBank into @gameid, @kakaonickname
while @@Fetch_status = 0
	Begin
		set @trophy 	= 0
		set @trophyrand	= 0
		set @trophymin 	= 0
		set @trophymax	= 0--Convert(int, ceiling(RAND() * 50)) + 10
		set @loop		= 0

		while( @trophymin <= 3000 )
			begin
				set @trophymin 	= @trophy
				set @aniitemcode1	= -1	set @upcnt1		= 0		set @attstem1	= 0	set @defstem1	= 0	set @hpstem1	= 0	set @timestem1	= 0
				set @aniitemcode2	= -1	set @upcnt2		= 0		set @attstem2	= 0	set @defstem2	= 0	set @hpstem2	= 0	set @timestem2	= 0
				set @aniitemcode3	= -1	set @upcnt3		= 0		set @attstem3	= 0	set @defstem3	= 0	set @hpstem3	= 0	set @timestem3	= 0
				set @idxs1			= -1	set @idxs2		= -1	set @idxs3		= -1
				set @treasure1 		= -1	set @treasureupgrade1 =0
				set @treasure2 		= -1	set @treasureupgrade2 =0
				set @treasure3 		= -1	set @treasureupgrade3 =0
				set @treasure4 		= -1	set @treasureupgrade4 =0
				set @treasure5 		= -1	set @treasureupgrade5 =0

				-------------------------------------------
				-- 동물 세팅.
				-------------------------------------------
				set @trophymax	= @trophymin + Convert(int, ceiling(RAND() * 20)) + 50
				select top 1 @idxs1 = idx, @aniitemcode1 = itemcode, @upcnt1 = upcnt, @attstem1 = attstem, @defstem1 = timestem, @hpstem1 = defstem, @timestem1 = hpstem, @grade1 = grade, @ttatt1 = ttatt from @tItemExpire
				where gameid = @gameid and
					  idx3 >= @trophymin and idx3 < @trophymax
				order by newid()

				set @trophymax	= @trophymin + Convert(int, ceiling(RAND() * 20)) + 100
				select top 1 @idxs2 = idx, @aniitemcode2 = itemcode, @upcnt2 = upcnt, @attstem2 = attstem, @defstem2 = timestem, @hpstem2 = defstem, @timestem2 = hpstem, @grade2 = grade, @ttatt2 = ttatt from @tItemExpire
				where gameid = @gameid and
					  idx3 >= @trophymin and idx3 < @trophymax and idx not in ( @idxs1 )
				order by newid()

				set @trophymax	= @trophymin + Convert(int, ceiling(RAND() * 20)) + 150
				select top 1 @idxs3 = idx, @aniitemcode3 = itemcode, @upcnt3 = upcnt, @attstem3 = attstem, @defstem3 = timestem, @hpstem3 = defstem, @timestem3 = hpstem, @grade3 = grade, @ttatt3 = ttatt from @tItemExpire
				where gameid = @gameid and
					  idx3 >= @trophymin and idx3 < @trophymax and idx not in ( @idxs1, @idxs2 )
				order by newid()

				-------------------------------------------
				-- 보물 세팅.
				-------------------------------------------
				if( @grade1 <= 0 )
					begin
						--select * from dbo.tItemInfo where grade = 1
						set @grade1 = @grade1
					end
				else if( @grade1 <= 0 and @upcnt1 > 0 )
					begin
						  select top 1 @treasure1 = itemcode, @skillcode1 = param1 from dbo.tItemInfo where subcategory = 1200 and grade in ( 1, 2, 3 ) and itemcode < 120500 																		  order by newid()
						--select top 1 @treasure2 = itemcode, @skillcode2 = param1 from dbo.tItemInfo where subcategory = 1200 and grade in ( 1, 2, 3 ) and itemcode < 120500 and param1 not in ( @skillcode1								      	) order by newid()
						--select top 1 @treasure3 = itemcode, @skillcode3 = param1 from dbo.tItemInfo where subcategory = 1200 and grade in ( 1, 2, 3 ) and itemcode < 120500 and param1 not in ( @skillcode1, @skillcode2						    ) order by newid()
						--select top 1 @treasure4 = itemcode, @skillcode4 = param1 from dbo.tItemInfo where subcategory = 1200 and grade in ( 1, 2, 3 ) and itemcode < 120500 and param1 not in ( @skillcode1, @skillcode2, @skillcode3			    ) order by newid()
						--select top 1 @treasure5 = itemcode, @skillcode5 = param1 from dbo.tItemInfo where subcategory = 1200 and grade in ( 1, 2, 3 ) and itemcode < 120500 and param1 not in ( @skillcode1, @skillcode2, @skillcode3, @skillcode4) order by newid()

						set @treasureupgrade1 = Convert(int, ceiling(RAND() * 2))
						--set @treasureupgrade2 = Convert(int, ceiling(RAND() * 5))
						--set @treasureupgrade3 = Convert(int, ceiling(RAND() * 5))
						--set @treasureupgrade4 = Convert(int, ceiling(RAND() * 5))
						--set @treasureupgrade5 = Convert(int, ceiling(RAND() * 5))
					end
				else if( @grade1 <= 1 )
					begin
						  select top 1 @treasure1 = itemcode, @skillcode1 = param1 from dbo.tItemInfo where subcategory = 1200 and grade in ( 1, 2, 3 ) and itemcode < 120500 																		  order by newid()
						--select top 1 @treasure2 = itemcode, @skillcode2 = param1 from dbo.tItemInfo where subcategory = 1200 and grade in ( 1, 2, 3 ) and itemcode < 120500 and param1 not in ( @skillcode1								      	) order by newid()
						--select top 1 @treasure3 = itemcode, @skillcode3 = param1 from dbo.tItemInfo where subcategory = 1200 and grade in ( 1, 2, 3 ) and itemcode < 120500 and param1 not in ( @skillcode1, @skillcode2						    ) order by newid()
						--select top 1 @treasure4 = itemcode, @skillcode4 = param1 from dbo.tItemInfo where subcategory = 1200 and grade in ( 1, 2, 3 ) and itemcode < 120500 and param1 not in ( @skillcode1, @skillcode2, @skillcode3			    ) order by newid()
						--select top 1 @treasure5 = itemcode, @skillcode5 = param1 from dbo.tItemInfo where subcategory = 1200 and grade in ( 1, 2, 3 ) and itemcode < 120500 and param1 not in ( @skillcode1, @skillcode2, @skillcode3, @skillcode4) order by newid()

						set @treasureupgrade1 = Convert(int, ceiling(RAND() * 5))
						--set @treasureupgrade2 = Convert(int, ceiling(RAND() * 5))
						--set @treasureupgrade3 = Convert(int, ceiling(RAND() * 5))
						--set @treasureupgrade4 = Convert(int, ceiling(RAND() * 5))
						--set @treasureupgrade5 = Convert(int, ceiling(RAND() * 5))
					end
				else if( @grade1 <= 2 )
					begin
						  select top 1 @treasure1 = itemcode, @skillcode1 = param1 from dbo.tItemInfo where subcategory = 1200 and grade in ( 1, 2, 3, 4) and itemcode < 120500 																		  order by newid()
						  select top 1 @treasure2 = itemcode, @skillcode2 = param1 from dbo.tItemInfo where subcategory = 1200 and grade in ( 1, 2, 3, 4) and itemcode < 120500 and param1 not in ( @skillcode1								      	    ) order by newid()
						--select top 1 @treasure3 = itemcode, @skillcode3 = param1 from dbo.tItemInfo where subcategory = 1200 and grade in ( 1, 2, 3, 4) and itemcode < 120500 and param1 not in ( @skillcode1, @skillcode2						    ) order by newid()
						--select top 1 @treasure4 = itemcode, @skillcode4 = param1 from dbo.tItemInfo where subcategory = 1200 and grade in ( 1, 2, 3, 4) and itemcode < 120500 and param1 not in ( @skillcode1, @skillcode2, @skillcode3			    ) order by newid()
						--select top 1 @treasure5 = itemcode, @skillcode5 = param1 from dbo.tItemInfo where subcategory = 1200 and grade in ( 1, 2, 3, 4) and itemcode < 120500 and param1 not in ( @skillcode1, @skillcode2, @skillcode3, @skillcode4  ) order by newid()

						set @treasureupgrade1 = Convert(int, ceiling(RAND() * 5))
						set @treasureupgrade2 = Convert(int, ceiling(RAND() * 5))
						--set @treasureupgrade3 = Convert(int, ceiling(RAND() * 5))
						--set @treasureupgrade4 = Convert(int, ceiling(RAND() * 5))
						--set @treasureupgrade5 = Convert(int, ceiling(RAND() * 5))
					end
				else if( @grade1 <= 3 )
					begin
						  select top 1 @treasure1 = itemcode, @skillcode1 = param1 from dbo.tItemInfo where subcategory = 1200 and grade in ( 2, 3, 4, 5) and itemcode < 120500 																		 order by newid()
						  select top 1 @treasure2 = itemcode, @skillcode2 = param1 from dbo.tItemInfo where subcategory = 1200 and grade in ( 2, 3, 4, 5) and itemcode < 120500 and param1 not in ( @skillcode1								           ) order by newid()
						  select top 1 @treasure3 = itemcode, @skillcode3 = param1 from dbo.tItemInfo where subcategory = 1200 and grade in ( 2, 3, 4, 5) and itemcode < 120500 and param1 not in ( @skillcode1, @skillcode2						   ) order by newid()
						--select top 1 @treasure4 = itemcode, @skillcode4 = param1 from dbo.tItemInfo where subcategory = 1200 and grade in ( 2, 3, 4, 5) and itemcode < 120500 and param1 not in ( @skillcode1, @skillcode2, @skillcode3			   ) order by newid()
						--select top 1 @treasure5 = itemcode, @skillcode5 = param1 from dbo.tItemInfo where subcategory = 1200 and grade in ( 2, 3, 4, 5) and itemcode < 120500 and param1 not in ( @skillcode1, @skillcode2, @skillcode3, @skillcode4 ) order by newid()

						set @treasureupgrade1 = Convert(int, ceiling(RAND() * 5))
						set @treasureupgrade2 = Convert(int, ceiling(RAND() * 5))
						set @treasureupgrade3 = Convert(int, ceiling(RAND() * 5))
						--set @treasureupgrade4 = Convert(int, ceiling(RAND() * 5))
						--set @treasureupgrade5 = Convert(int, ceiling(RAND() * 5))
					end
				else if( @grade1 <= 4 )
					begin
						  select top 1 @treasure1 = itemcode, @skillcode1 = param1 from dbo.tItemInfo where subcategory = 1200 and grade in ( 3, 4, 5) and itemcode < 120500 																		 order by newid()
						  select top 1 @treasure2 = itemcode, @skillcode2 = param1 from dbo.tItemInfo where subcategory = 1200 and grade in ( 3, 4, 5) and itemcode < 120500 and param1 not in ( @skillcode1								       ) order by newid()
						  select top 1 @treasure3 = itemcode, @skillcode3 = param1 from dbo.tItemInfo where subcategory = 1200 and grade in ( 3, 4, 5) and itemcode < 120500 and param1 not in ( @skillcode1, @skillcode2						   ) order by newid()
						  select top 1 @treasure4 = itemcode, @skillcode4 = param1 from dbo.tItemInfo where subcategory = 1200 and grade in ( 3, 4, 5) and itemcode < 120500 and param1 not in ( @skillcode1, @skillcode2, @skillcode3			   ) order by newid()
						--select top 1 @treasure5 = itemcode, @skillcode5 = param1 from dbo.tItemInfo where subcategory = 1200 and grade in ( 3, 4, 5) and itemcode < 120500 and param1 not in ( @skillcode1, @skillcode2, @skillcode3, @skillcode4) order by newid()

						set @treasureupgrade1 = Convert(int, ceiling(RAND() * 5))
						set @treasureupgrade2 = Convert(int, ceiling(RAND() * 5))
						set @treasureupgrade3 = Convert(int, ceiling(RAND() * 5))
						set @treasureupgrade4 = Convert(int, ceiling(RAND() * 5))
						--set @treasureupgrade5 = Convert(int, ceiling(RAND() * 5))
					end
				else if( @grade1 > 4 )
					begin
						--select 'DEBUG >>> '
						select top 1 @treasure1 = itemcode, @skillcode1 = param1 from dbo.tItemInfo where subcategory = 1200 and grade in ( 3, 4, 5, 6 ) and itemcode < 120500 																		   order by newid()
						select top 1 @treasure2 = itemcode, @skillcode2 = param1 from dbo.tItemInfo where subcategory = 1200 and grade in ( 3, 4, 5, 6 ) and itemcode < 120500 and param1 not in ( @skillcode1								         ) order by newid()
						select top 1 @treasure3 = itemcode, @skillcode3 = param1 from dbo.tItemInfo where subcategory = 1200 and grade in ( 3, 4, 5, 6 ) and itemcode < 120500 and param1 not in ( @skillcode1, @skillcode2						     ) order by newid()
						select top 1 @treasure4 = itemcode, @skillcode4 = param1 from dbo.tItemInfo where subcategory = 1200 and grade in ( 3, 4, 5, 6 ) and itemcode < 120500 and param1 not in ( @skillcode1, @skillcode2, @skillcode3		     ) order by newid()
						select top 1 @treasure5 = itemcode, @skillcode5 = param1 from dbo.tItemInfo where subcategory = 1200 and grade in ( 3, 4, 5, 6 ) and itemcode < 120500 and param1 not in ( @skillcode1, @skillcode2, @skillcode3, @skillcode4) order by newid()

						set @treasureupgrade1 = 7
						set @treasureupgrade2 = 7
						set @treasureupgrade3 = 7
						set @treasureupgrade4 = 7
						set @treasureupgrade5 = 7
					end

				-------------------------------------------
				-- 입력.
				-------------------------------------------
				set @idx2 	= 1
				set @tier 	= dbo.fun_GetTier( @trophy )
				select @idx2 = isnull( max( idx2 ), 0 ) + 1 from @tTempBank where gameid = @gameid and trophy = @trophy
				--select 'DEBUG ', @trophymin trophymin, @trophymax trophymax, @trophy trophy, @tier tier, @gameid gameid, @idx2 idx2, @kakaonickname kakaonickname, @aniitemcode1, @upcnt1, @attstem1, @defstem1, @hpstem1, @timestem1, @aniitemcode2, @upcnt2, @attstem2, @defstem2, @hpstem2, @timestem2, @aniitemcode3, @upcnt3, @attstem3, @defstem3, @hpstem3, @timestem3

				insert into @tTempBank(     idx2, gameid, kakaonickname, trophy, tier, userdata, idxs1, idxs2, idxs3,
											aniitemcode1, upcnt1, attstem1, defstem1, hpstem1, timestem1, grade1, ttatt1,
											aniitemcode2, upcnt2, attstem2, defstem2, hpstem2, timestem2, grade2, ttatt2,
											aniitemcode3, upcnt3, attstem3, defstem3, hpstem3, timestem3, grade3, ttatt3,
											treasure1, treasure2, treasure3, treasure4, treasure5,
											treasureupgrade1, treasureupgrade2, treasureupgrade3, treasureupgrade4, treasureupgrade5
											)
				values(						@idx2, @gameid, @kakaonickname, @trophy, @tier, @userdata, @idxs1, @idxs2, @idxs3,
											@aniitemcode1, @upcnt1, @attstem1, @defstem1, @hpstem1, @timestem1, @grade1, @ttatt1,
											@aniitemcode2, @upcnt2, @attstem2, @defstem2, @hpstem2, @timestem2, @grade2, @ttatt2,
											@aniitemcode3, @upcnt3, @attstem3, @defstem3, @hpstem3, @timestem3, @grade3, @ttatt3,
											@treasure1, @treasure2, @treasure3, @treasure4, @treasure5,
											@treasureupgrade1, @treasureupgrade2, @treasureupgrade3, @treasureupgrade4, @treasureupgrade5
											)

				set @trophy 	= @trophy + Convert(int, ceiling(RAND() * 20)) + 10
				set @loop		= @loop + 1
			end
		--select 'DEBUG ', @gameid gameid, @kakaonickname kakaonickname, @loop loop
		Fetch next from curBattleBank into @gameid, @kakaonickname
	end


-- 4. 커서닫기
close curBattleBank
Deallocate curBattleBank


------------------------------------
-- 5. 샘플데이타 눈으로 확인하기.
------------------------------------
select top 5 'DEBUG', idx, idx2, gameid, kakaonickname, trophy, tier, aniitemcode1, grade1, upcnt1, attstem1, ttatt1, aniitemcode2, grade2, upcnt2, attstem2, ttatt2, aniitemcode3, grade3, upcnt3, attstem3, ttatt3, treasure1, treasure2, treasure3, treasure4, treasure5, treasureupgrade1, treasureupgrade2, treasureupgrade3, treasureupgrade4, treasureupgrade5, idxs1, idxs2, idxs3 from @tTempBank where tier = 1 union
select top 5 'DEBUG', idx, idx2, gameid, kakaonickname, trophy, tier, aniitemcode1, grade1, upcnt1, attstem1, ttatt1, aniitemcode2, grade2, upcnt2, attstem2, ttatt2, aniitemcode3, grade3, upcnt3, attstem3, ttatt3, treasure1, treasure2, treasure3, treasure4, treasure5, treasureupgrade1, treasureupgrade2, treasureupgrade3, treasureupgrade4, treasureupgrade5, idxs1, idxs2, idxs3 from @tTempBank where tier = 2 union
select top 5 'DEBUG', idx, idx2, gameid, kakaonickname, trophy, tier, aniitemcode1, grade1, upcnt1, attstem1, ttatt1, aniitemcode2, grade2, upcnt2, attstem2, ttatt2, aniitemcode3, grade3, upcnt3, attstem3, ttatt3, treasure1, treasure2, treasure3, treasure4, treasure5, treasureupgrade1, treasureupgrade2, treasureupgrade3, treasureupgrade4, treasureupgrade5, idxs1, idxs2, idxs3 from @tTempBank where tier = 3 union
select top 5 'DEBUG', idx, idx2, gameid, kakaonickname, trophy, tier, aniitemcode1, grade1, upcnt1, attstem1, ttatt1, aniitemcode2, grade2, upcnt2, attstem2, ttatt2, aniitemcode3, grade3, upcnt3, attstem3, ttatt3, treasure1, treasure2, treasure3, treasure4, treasure5, treasureupgrade1, treasureupgrade2, treasureupgrade3, treasureupgrade4, treasureupgrade5, idxs1, idxs2, idxs3 from @tTempBank where tier = 4 union
select top 5 'DEBUG', idx, idx2, gameid, kakaonickname, trophy, tier, aniitemcode1, grade1, upcnt1, attstem1, ttatt1, aniitemcode2, grade2, upcnt2, attstem2, ttatt2, aniitemcode3, grade3, upcnt3, attstem3, ttatt3, treasure1, treasure2, treasure3, treasure4, treasure5, treasureupgrade1, treasureupgrade2, treasureupgrade3, treasureupgrade4, treasureupgrade5, idxs1, idxs2, idxs3 from @tTempBank where tier = 5 union
select top 5 'DEBUG', idx, idx2, gameid, kakaonickname, trophy, tier, aniitemcode1, grade1, upcnt1, attstem1, ttatt1, aniitemcode2, grade2, upcnt2, attstem2, ttatt2, aniitemcode3, grade3, upcnt3, attstem3, ttatt3, treasure1, treasure2, treasure3, treasure4, treasure5, treasureupgrade1, treasureupgrade2, treasureupgrade3, treasureupgrade4, treasureupgrade5, idxs1, idxs2, idxs3 from @tTempBank where tier = 6 union
select top 5 'DEBUG', idx, idx2, gameid, kakaonickname, trophy, tier, aniitemcode1, grade1, upcnt1, attstem1, ttatt1, aniitemcode2, grade2, upcnt2, attstem2, ttatt2, aniitemcode3, grade3, upcnt3, attstem3, ttatt3, treasure1, treasure2, treasure3, treasure4, treasure5, treasureupgrade1, treasureupgrade2, treasureupgrade3, treasureupgrade4, treasureupgrade5, idxs1, idxs2, idxs3 from @tTempBank where tier = 7 union
select top 5 'DEBUG', idx, idx2, gameid, kakaonickname, trophy, tier, aniitemcode1, grade1, upcnt1, attstem1, ttatt1, aniitemcode2, grade2, upcnt2, attstem2, ttatt2, aniitemcode3, grade3, upcnt3, attstem3, ttatt3, treasure1, treasure2, treasure3, treasure4, treasure5, treasureupgrade1, treasureupgrade2, treasureupgrade3, treasureupgrade4, treasureupgrade5, idxs1, idxs2, idxs3 from @tTempBank where tier = 8 order by trophy asc



insert into dbo.tUserBattleBank(idx2, gameid, kakaonickname, trophy, tier, userdata,
							aniitemcode1, upcnt1, attstem1, defstem1, hpstem1, timestem1,
							aniitemcode2, upcnt2, attstem2, defstem2, hpstem2, timestem2,
							aniitemcode3, upcnt3, attstem3, defstem3, hpstem3, timestem3,
							treasure1, treasure2, treasure3, treasure4, treasure5, treasureupgrade1, treasureupgrade2, treasureupgrade3, treasureupgrade4, treasureupgrade5
							)
select 						idx2, gameid, kakaonickname, trophy, tier, userdata,
							aniitemcode1, upcnt1, attstem1, defstem1, hpstem1, timestem1,
							aniitemcode2, upcnt2, attstem2, defstem2, hpstem2, timestem2,
							aniitemcode3, upcnt3, attstem3, defstem3, hpstem3, timestem3,
							treasure1, treasure2, treasure3, treasure4, treasure5, treasureupgrade1, treasureupgrade2, treasureupgrade3, treasureupgrade4, treasureupgrade5
							from @tTempBank


------------------------------------
-- 6. 데이타 정리하기.
------------------------------------
-- 모두 동물이 없으면 삭제하기.
delete from dbo.tUserBattleBank where aniitemcode1 = -1 and aniitemcode2 = -1 and aniitemcode3 = -1
delete from dbo.tUserBattleBank where trophy >= 800 and ( aniitemcode1 = -1 or aniitemcode2 = -1 or aniitemcode3 = -1 )
