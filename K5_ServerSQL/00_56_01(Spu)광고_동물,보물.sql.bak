/*
exec spu_RoulAdLogNew 'xxxx2', 'xxxx2', 2,	  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1
exec spu_RoulAdLogNew 'xxxx2', 'xxxx2', 2,	   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1
exec spu_RoulAdLogNew 'xxxx2', 'xxxx2', 2,	 100,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1
exec spu_RoulAdLogNew 'xxxx2', 'xxxx2', 2,	 200,   2,7000,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1
exec spu_RoulAdLogNew 'xxxx2', 'xxxx2', 2,	   1,   2,   3,   4,   5,   6,   7,   8,   9,  10,  11

exec spu_RoulAdLogNew 'xxxx2', 'xxxx2', 1,	  15,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1	-- 일반.
exec spu_RoulAdLogNew 'xxxx2', 'xxxx2', 2,	  15,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 	-- 프리미엄.
exec spu_RoulAdLogNew 'xxxx2', 'xxxx2', 4,	  15,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1	-- 프리미엄10+1.

exec spu_RoulAdLogNew 'xxxx2', 'xxxx2', 3,	  15,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1	-- 합성.
exec spu_RoulAdLogNew 'xxxx2', 'xxxx2',100,	  15,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1	-- 승급.

exec spu_RoulAdLogNew 'xxxx2', 'xxxx2', 1000, 15,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1	-- 일반.
exec spu_RoulAdLogNew 'xxxx2', 'xxxx2', 2000, 15,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 	-- 프리미엄.
exec spu_RoulAdLogNew 'xxxx2', 'xxxx2', 4000, 15,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1	-- 프리미엄10+1.

exec spu_RoulAdLogNew 'xxxx2', 'xxxx2',101, 5000,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1	-- 룰렛.
exec spu_RoulAdLogNew 'xxxx2', 'xxxx2',101, 3500,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1	-- 룰렛.
exec spu_RoulAdLogNew 'xxxx2', 'xxxx2',101, 2300,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1	-- 룰렛.
exec spu_RoulAdLogNew 'xxxx2', 'xxxx2',101, 5100,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1	-- 룰렛.
exec spu_RoulAdLogNew 'xxxx2', 'xxxx2',101, 3600,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1	-- 룰렛.
*/
use Game4Farmvill5
GO

IF OBJECT_ID ( 'dbo.spu_RoulAdLogNew', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_RoulAdLogNew;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_RoulAdLogNew
	@gameid_								varchar(20),
	@nickname_								varchar(40),
	@mode_									int,
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
	@itemcode11_							int
	--WITH ENCRYPTION -- 프로시져를 암호화함.
as
	------------------------------------------------
	--
	------------------------------------------------
	declare @IDX_MAX							int 				set @IDX_MAX								= 100

	-- 교배뽑기 상수.
	declare @MODE_ROULETTE_GRADE1				int					set @MODE_ROULETTE_GRADE1					= 1		-- 일반뽑기.
	declare @MODE_ROULETTE_GRADE2				int					set @MODE_ROULETTE_GRADE2					= 2		-- 루비뽑기.
	declare @MODE_ROULETTE_GRADE4				int					set @MODE_ROULETTE_GRADE4					= 4	   	-- 루비뽑기 10 + 1.
	declare @MODE_ROULETTE_GRADE2_FREE			int					set @MODE_ROULETTE_GRADE2_FREE				= 12	-- 루비뽑기			(무료).
	declare @MODE_ROULETTE_GRADE4_FREE			int					set @MODE_ROULETTE_GRADE4_FREE				= 14	-- 루비뽑기 10 + 1	(무료).
	declare @MODE_ROULETTE_GRADE1_TICKET		int					set @MODE_ROULETTE_GRADE1_TICKET			= 21	-- 일반뽑기			(티켓).
	declare @MODE_ROULETTE_GRADE2_TICKET		int					set @MODE_ROULETTE_GRADE2_TICKET			= 22	-- 루비뽑기			(티켓).
	declare @MODE_ROULETTE_GRADE4_TICKET		int					set @MODE_ROULETTE_GRADE4_TICKET			= 24	-- 루비뽑기 10 + 1 	(티켓).

	declare @MODE_COMPOSE						int					set @MODE_COMPOSE							= 3		-- 합성.
	declare @MODE_PROMOTE						int					set @MODE_PROMOTE							= 100	-- 승급.
	declare @MODE_WHEEL							int					set @MODE_WHEEL								= 101

	-- 보물뽑기 상수.
	declare @MODE_TREASURE_GRADE1				int					set @MODE_TREASURE_GRADE1					= 1 * 1000	-- 일반뽑기.
	declare @MODE_TREASURE_GRADE2				int					set @MODE_TREASURE_GRADE2					= 2 * 1000	-- 루비뽑기.
	declare @MODE_TREASURE_GRADE4				int					set @MODE_TREASURE_GRADE4					= 4 * 1000 	-- 루비뽑기 10 + 1.
	declare @MODE_TREASURE_GRADE2_FREE			int					set @MODE_TREASURE_GRADE2_FREE				= 12* 1000	-- 루비뽑기			(무료).
	declare @MODE_TREASURE_GRADE4_FREE			int					set @MODE_TREASURE_GRADE4_FREE				= 14* 1000	-- 루비뽑기 10 + 1	(무료).
	declare @MODE_TREASURE_GRADE1_TICKET		int					set @MODE_TREASURE_GRADE1_TICKET			= 21* 1000	-- 일반뽑기			(티켓).
	declare @MODE_TREASURE_GRADE2_TICKET		int					set @MODE_TREASURE_GRADE2_TICKET			= 22* 1000	-- 루비뽑기			(티켓).
	declare @MODE_TREASURE_GRADE4_TICKET		int					set @MODE_TREASURE_GRADE4_TICKET			= 24* 1000	-- 루비뽑기 10 + 1 	(티켓).

	-- 룰렛



	-- 아이템 대분류
	declare @ITEM_MAINCATEGORY_ANI				int					set @ITEM_MAINCATEGORY_ANI 					= 1 	--가축(1)
	declare @ITEM_MAINCATEGORY_TREASURE			int					set @ITEM_MAINCATEGORY_TREASURE	 			= 1200	-- 보물(1200)
	------------------------------------------------
	--
	------------------------------------------------
	declare @itemcode				int
	declare @itemname				varchar(40)
	declare @idx					int				set @idx			= -1
	declare @itemlist				varchar(128)
	declare @cnt					int

	declare @category				int
	declare @grade					int
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on

	-- 1. 커서 생성
	set @itemlist =   ltrim(rtrim(str(@itemcode1_))) + ','
					+ ltrim(rtrim(str(@itemcode2_))) + ','
					+ ltrim(rtrim(str(@itemcode3_))) + ','
					+ ltrim(rtrim(str(@itemcode4_))) + ','
					+ ltrim(rtrim(str(@itemcode5_))) + ','
					+ ltrim(rtrim(str(@itemcode6_))) + ','
					+ ltrim(rtrim(str(@itemcode7_))) + ','
					+ ltrim(rtrim(str(@itemcode8_))) + ','
					+ ltrim(rtrim(str(@itemcode9_))) + ','
					+ ltrim(rtrim(str(@itemcode10_)))+ ','
					+ ltrim(rtrim(str(@itemcode11_)))

	--select 'DEBUG ', @itemlist itemlist

	declare curTemp Cursor for
	select idx, listidx FROM dbo.fnu_SplitOne(',', @itemlist)

	-- 2. 커서오픈
	open curTemp

	-- 3. 커서 사용
	Fetch next from curTemp into @idx, @itemcode
	while @@Fetch_status = 0
		Begin
			--select 'DEBUG ', @idx, @itemcode
			if( @itemcode = -1 )
				begin
					set @itemcode = @itemcode
				end
			else if(    ( @itemcode >= 13     and @itemcode <= 99     )
				or ( @itemcode >= 109    and @itemcode <= 199    )
				or ( @itemcode >= 206    and @itemcode <= 299    )
				or ( @itemcode >= 120010 and @itemcode <= 120999 )
				or ( @mode_ = @MODE_WHEEL                         )
				)
				begin

					----------------------------------------
					-- 아이템 이름을 검색 > 입력.
					-- []를 사용을 주의하세요.~ -> NGUI UI_Lablel에서 사이즈 계산이 아상하게 나옴.
					-- 오동작 : [xxxx2]님이 [xxxx]을 프리미엄 교배로 얻었습니다.
					-- 정  상 : {xxxx2}님이 xxxx을 [ff00ff]프리미엄 교배[-]로 얻었습니다.
					----------------------------------------
					select
						@category 	= category,
						@grade 		= grade,
						@itemname 	= itemname
					from dbo.tItemInfo
					where itemcode = @itemcode
					--select 'DEBUG > 광고하기', @idx idx, @itemcode itemcode, @category category, @itemname itemname, @grade grade

					if(    ( @category = @ITEM_MAINCATEGORY_ANI 		and @grade < 4 )	-- 동물 -> 황금(4) 미만은 패스.
						or ( @category = @ITEM_MAINCATEGORY_TREASURE 	and @grade < 5 ) )	-- 보물 -> 전설(5) 미만은 패스.
						begin
							--select 'DEBUG 등급이 낮아 패스'
							set @cnt = @cnt
						end
					else if(@mode_ = @MODE_COMPOSE)
						begin
							--select 'DEBUG 합성'
							insert into dbo.tUserAdLog( gameid,   nickname,   itemcode,  mode, comment)
							values(                    @gameid_, @nickname_, @itemcode, @mode_, @nickname_ + '님이 {'+ @itemname +'}을 [ff00ff]합성[-]으로 얻었습니다.')
						end
					else if(@mode_ = @MODE_PROMOTE)
						begin
							--select 'DEBUG 승급'
							insert into dbo.tUserAdLog( gameid,   nickname,   itemcode,  mode, comment)
							values(                    @gameid_, @nickname_, @itemcode, @mode_, @nickname_ + '님이 {'+ @itemname +'}을 [ff00ff]승급[-]으로 얻었습니다.')
						end

					-- 동물.
					else if(@mode_ in ( @MODE_ROULETTE_GRADE1,                             @MODE_ROULETTE_GRADE1_TICKET ))
						begin
							--select 'DEBUG 일반교배'
							insert into dbo.tUserAdLog( gameid,   nickname,   itemcode,  mode,  comment)
							values(                    @gameid_, @nickname_, @itemcode, @mode_, @nickname_ + '님이 {'+ @itemname +'}을 교배로 얻었습니다.')
						end
					else if(@mode_ in ( @MODE_ROULETTE_GRADE2, @MODE_ROULETTE_GRADE2_FREE, @MODE_ROULETTE_GRADE2_TICKET ))
						begin
							--select 'DEBUG 프림교배'
							insert into dbo.tUserAdLog( gameid,   nickname,   itemcode,  mode,  comment)
							values(                    @gameid_, @nickname_, @itemcode, @mode_, @nickname_ + '님이 {'+ @itemname +'}을 [ff00ff]프리미엄 교배[-]로 얻었습니다.')
						end
					else if(@mode_ in ( @MODE_ROULETTE_GRADE4, @MODE_ROULETTE_GRADE4_FREE, @MODE_ROULETTE_GRADE4_TICKET ))
						begin
							----select 'DEBUG 프림교배 10+1'
							insert into dbo.tUserAdLog( gameid,   nickname,   itemcode,  mode,  comment)
							values(                    @gameid_, @nickname_, @itemcode, @mode_, @nickname_ + '님이 {'+ @itemname +'}을 [ff00ff]프리미엄 교배10+1[-]로 얻었습니다.')
						end

					-- 보물.
					else if(@mode_ in ( @MODE_TREASURE_GRADE1,                             @MODE_TREASURE_GRADE1_TICKET ))
						begin
							----select 'DEBUG 일반보물'
							insert into dbo.tUserAdLog( gameid,   nickname,   itemcode,  mode,  comment)
							values(                    @gameid_, @nickname_, @itemcode, @mode_, @nickname_ + '님이 {'+ @itemname +'}을 보물뽑기로 얻었습니다.')
						end
					else if(@mode_ in ( @MODE_TREASURE_GRADE2, @MODE_TREASURE_GRADE2_FREE, @MODE_TREASURE_GRADE2_TICKET ))
						begin
							--select 'DEBUG 프림보물'
							insert into dbo.tUserAdLog( gameid,   nickname,   itemcode,  mode,  comment)
							values(                    @gameid_, @nickname_, @itemcode, @mode_, @nickname_ + '님이 {'+ @itemname +'}을 [ff00ff]프리미엄 보물뽑기[-]로 얻었습니다.')
						end
					else if(@mode_ in ( @MODE_TREASURE_GRADE4, @MODE_TREASURE_GRADE4_FREE, @MODE_TREASURE_GRADE4_TICKET ))
						begin
							--select 'DEBUG 프림보물 10+1'
							insert into dbo.tUserAdLog( gameid,   nickname,   itemcode,  mode,  comment)
							values(                    @gameid_, @nickname_, @itemcode, @mode_, @nickname_ + '님이 {'+ @itemname +'}을 [ff00ff]프리미엄 보물뽑기10+1[-]로 얻었습니다.')
						end

					-- 룰렛.
					else if(@mode_ in ( @MODE_WHEEL ))
						begin
							--select 'DEBUG 황금룰렛'
							insert into dbo.tUserAdLog( gameid,   nickname,   itemcode,  mode,  comment)
							values(                    @gameid_, @nickname_, @itemcode, @mode_, @nickname_ + '님이 {'+ @itemname +'}을 [ff00ff]황금룰렛[-]으로 얻었습니다.')
						end



					set @cnt = @cnt + 1
				end
			Fetch next from curTemp into @idx, @itemcode
		end

	-- 4. 커서닫기
	close curTemp
	Deallocate curTemp

	-- 일정개수 이상은 삭제시킴
	select @idx = max(idx) from dbo.tUserAdLog
	delete from dbo.tUserAdLog where idx <= @idx - @IDX_MAX

	set nocount off
End