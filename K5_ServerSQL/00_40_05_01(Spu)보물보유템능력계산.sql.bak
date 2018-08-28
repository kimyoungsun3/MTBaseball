/*
--update dbo.tUserMaster set tsskillcashcost = 0,	tsskillheart = 0, tsskillgamecost = 0, tsskillfpoint = 0, tsskillrebirth = 0, tsskillalba = 0 from dbo.tUserMaster where gameid = 'xxxx2'
--delete from dbo.tUserItem where gameid = 'xxxx2' and invenkind = 1200

exec spu_SetDirectItem 'xxxx2', 120500, 1, -1	exec spu_SetDirectItem 'xxxx2', 120505, 1, -1
exec spu_TSRetentionEffect 'xxxx2', 120500		-- 루비생산(50)
exec spu_TSRetentionEffect 'xxxx2', 120501
exec spu_TSRetentionEffect 'xxxx2', 120505

exec spu_SetDirectItem 'xxxx2', 120510, 1, -1	exec spu_SetDirectItem 'xxxx2', 120515, 1, -1
exec spu_TSRetentionEffect 'xxxx2', 120510		-- 하트생산(51)
exec spu_TSRetentionEffect 'xxxx2', 120511
exec spu_TSRetentionEffect 'xxxx2', 120515

exec spu_SetDirectItem 'xxxx2', 120520, 1, -1	exec spu_SetDirectItem 'xxxx2', 120525, 1, -1
exec spu_TSRetentionEffect 'xxxx2', 120520		-- 코인생산(52)
exec spu_TSRetentionEffect 'xxxx2', 120521
exec spu_TSRetentionEffect 'xxxx2', 120525

exec spu_SetDirectItem 'xxxx2', 120530, 1, -1	exec spu_SetDirectItem 'xxxx2', 120535, 1, -1
exec spu_TSRetentionEffect 'xxxx2', 120530		-- 우포생산(53)
exec spu_TSRetentionEffect 'xxxx2', 120531
exec spu_TSRetentionEffect 'xxxx2', 120535

exec spu_SetDirectItem 'xxxx2', 120540, 1, -1	exec spu_SetDirectItem 'xxxx2', 120545, 1, -1
exec spu_TSRetentionEffect 'xxxx2', 120540		-- 부활생산(54)
exec spu_TSRetentionEffect 'xxxx2', 120541
exec spu_TSRetentionEffect 'xxxx2', 120545

exec spu_SetDirectItem 'xxxx2', 120550, 1, -1	exec spu_SetDirectItem 'xxxx2', 120555, 1, -1
exec spu_TSRetentionEffect 'xxxx2', 120550		-- 알바생산(55)
exec spu_TSRetentionEffect 'xxxx2', 120551
exec spu_TSRetentionEffect 'xxxx2', 120555

exec spu_SetDirectItem 'xxxx2', 120560, 1, -1	exec spu_SetDirectItem 'xxxx2', 120565, 1, -1
exec spu_TSRetentionEffect 'xxxx2', 120560		-- 특수탄 생산(56)
exec spu_TSRetentionEffect 'xxxx2', 120561
exec spu_TSRetentionEffect 'xxxx2', 120565

exec spu_SetDirectItem 'xxxx2', 120570, 1, -1	exec spu_SetDirectItem 'xxxx2', 120575, 1, -1
exec spu_TSRetentionEffect 'xxxx2', 120570		-- 슈퍼백신생산(57)
exec spu_TSRetentionEffect 'xxxx2', 120571
exec spu_TSRetentionEffect 'xxxx2', 120575

exec spu_SetDirectItem 'xxxx2', 120580, 1, -1	exec spu_SetDirectItem 'xxxx2', 120585, 1, -1
exec spu_TSRetentionEffect 'xxxx2', 120580		-- 건초생산(58).
exec spu_TSRetentionEffect 'xxxx2', 120581
exec spu_TSRetentionEffect 'xxxx2', 120585

exec spu_SetDirectItem 'xxxx2', 120590, 1, -1	exec spu_SetDirectItem 'xxxx2', 120595, 1, -1
exec spu_TSRetentionEffect 'xxxx2', 120590		-- 특수촉진제생산(59).
exec spu_TSRetentionEffect 'xxxx2', 120591
exec spu_TSRetentionEffect 'xxxx2', 120595

exec spu_TSRetentionEffect 'xxxx2', 120010		--기타 -> 패스
*/

use Game4Farmvill5
GO

IF OBJECT_ID ( 'dbo.spu_TSRetentionEffect', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_TSRetentionEffect;
GO

create procedure dbo.spu_TSRetentionEffect
	@gameid_								varchar(20),		-- 게임아이디
	@itemcode_								int
	--WITH ENCRYPTION -- 프로시져를 암호화함.
as
	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------
	-- 아이템 대분류
	declare @ITEM_MAINCATEGORY_TREASURE			int					set @ITEM_MAINCATEGORY_TREASURE				= 1200	-- 보물.

	-- 보물스킬코드.
	declare @TS_SKILL_CASHCOST					int					set @TS_SKILL_CASHCOST						= 50	-- 루비생산(50).
	declare @TS_SKILL_HEART						int					set @TS_SKILL_HEART							= 51	-- 하트생산(51).
	declare @TS_SKILL_GAMECOST					int					set @TS_SKILL_GAMECOST						= 52	-- 코인생산(52).
	declare @TS_SKILL_FPOINT					int					set @TS_SKILL_FPOINT						= 53	-- 우포생산(53).
	declare @TS_SKILL_REBIRTH					int					set @TS_SKILL_REBIRTH						= 54	-- 부활생산(54).
	declare @TS_SKILL_ALBA						int					set @TS_SKILL_ALBA							= 55	-- 알바생산(55).
	declare @TS_SKILL_BULLET					int					set @TS_SKILL_BULLET						= 56	-- 특수탄 생산(56).
	declare @TS_SKILL_VACCINE					int					set @TS_SKILL_VACCINE						= 57	-- 슈퍼백신생산(57).
	declare @TS_SKILL_FEED						int					set @TS_SKILL_FEED							= 58	-- 건초생산(58).
	declare @TS_SKILL_BOOSTER					int					set @TS_SKILL_BOOSTER						= 59	-- 특수촉진제생산(59).

	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @gameid					varchar(20)		set @gameid				= ''
	declare @tsskillcashcost		int				set @tsskillcashcost 	= 0
	declare @tsskillheart			int				set @tsskillheart 		= 0
	declare @tsskillgamecost		int				set @tsskillgamecost 	= 0
	declare @tsskillfpoint			int				set @tsskillfpoint 		= 0
	declare @tsskillrebirth			int				set @tsskillrebirth 	= 0
	declare @tsskillalba			int				set @tsskillalba 		= 0
	declare @tsskillbullet			int				set @tsskillbullet 		= 0
	declare @tsskillvaccine			int				set @tsskillvaccine 	= 0
	declare @tsskillfeed			int				set @tsskillfeed 		= 0
	declare @tsskillbooster			int				set @tsskillbooster 	= 0

	declare @itemcode				int				set @itemcode			= -1
	declare @skillcode				int				set @skillcode			= 0
	declare @ischange				int				set @ischange			= 1
	declare @tsvalue				int				set @tsvalue			= 0

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	--select 'DEBUG ', @gameid_ gameid_, @itemcode_ itemcode_
	if( @itemcode_ < 120500)
		begin
			return;
		end

	------------------------------------------------
	--	3-2. 유저 정보.
	------------------------------------------------
	select
		@gameid 		= gameid,
		@tsskillcashcost= tsskillcashcost,	@tsskillheart	= tsskillheart,		@tsskillgamecost	= tsskillgamecost,
		@tsskillfpoint	= tsskillfpoint,	@tsskillrebirth	= tsskillrebirth,	@tsskillalba		= tsskillalba,
		@tsskillbullet	= tsskillbullet,	@tsskillvaccine	= tsskillvaccine,	@tsskillfeed		= tsskillfeed,			@tsskillbooster		= tsskillbooster
	from dbo.tUserMaster
	where gameid = @gameid_
	--select 'DEBUG 유저정보', @gameid gameid, @tsskillcashcost tsskillcashcost, @tsskillheart tsskillheart, @tsskillgamecost tsskillgamecost, @tsskillfpoint tsskillfpoint, @tsskillrebirth tsskillrebirth, @tsskillalba tsskillalba, @tsskillbullet tsskillbullet, @tsskillvaccine tsskillvaccine, @tsskillfeed tsskillfeed, @tsskillbooster tsskillbooster


	------------------------------------------------
	--  3-2. 템정보
	-- param5 (2) 보유시를 의미함
	------------------------------------------------
	select
		@itemcode 	= itemcode,
		@skillcode	= param1
	from dbo.tItemInfo where itemcode = @itemcode_ and category = @ITEM_MAINCATEGORY_TREASURE and param5 = 2
	--select 'DEBUG 템정보', @itemcode itemcode, @skillcode skillcode

	if( @gameid != '' and @itemcode != -1 )
		begin
			--------------------------------------
			-- 임시테이블 생성해두기.
			--------------------------------------
			DECLARE @tTempTable TABLE(
				itemcode		int,
				basevalue		int,
				upgradevalue	int
			);

			--------------------------------------
			-- iteminfo -> 임시테이블에 넣기.
			--	아이템      -> G50 	-> T1
			--              		-> T2
			--              		-> T3
			--              		-> T4
			--------------------------------------
			insert into @tTempTable(itemcode, basevalue, upgradevalue)
			select                  itemcode,    param2,       param3
			from dbo.tItemInfo
			where category = @ITEM_MAINCATEGORY_TREASURE
				  and param1 = @skillcode
			--select 'DEBUG ', * from @tTempTable

			--------------------------------------
			-- 보물 대표정보 추출하기.
			--	아이템      -> G50 	-> T1		-> T1 * 7업		->최종선택.
			--              		-> T2
			--              		-> T3
			--              		-> T4		-> T4
			--------------------------------------
			if(not exists(select top 1 * from @tTempTable ))
					begin
						-- 삭제 		-> 존재안함 	-> 0
						set @tsvalue = 0
					end
				else
					begin
						-- 선물, 직접 	-> 존재함		-> 값
						select top 1
							@tsvalue = treasureupgrade * upgradevalue + basevalue
						from @tTempTable i
							JOIN
								(select itemcode, treasureupgrade from dbo.tUserItem
								where gameid = @gameid_ and itemcode in (select itemcode from @tTempTable)) u
							ON i.itemcode = u.itemcode
						order by 1 desc
						--select 'DEBUG ', @tsvalue tsvalue
					end


			if( @skillcode = @TS_SKILL_CASHCOST )
				begin
					--select 'DEBUG 루비생산(50)', @skillcode skillcode
					set @tsskillcashcost 	= @tsvalue
				end
			else if( @skillcode = @TS_SKILL_HEART )
				begin
					--select 'DEBUG 하트생산(51)', @skillcode skillcode
					set @tsskillheart 		= @tsvalue
				end
			else if( @skillcode = @TS_SKILL_GAMECOST )
				begin
					--select 'DEBUG 코인생산(52)', @skillcode skillcode
					set @tsskillgamecost 	= @tsvalue

				end
			else if( @skillcode = @TS_SKILL_FPOINT )
				begin
					--select 'DEBUG 우포생산(53)', @skillcode skillcode
					set @tsskillfpoint 		= @tsvalue
				end
			else if( @skillcode = @TS_SKILL_REBIRTH )
				begin
					--select 'DEBUG 부활생산(54)', @skillcode skillcode
					set @tsskillrebirth 	= @tsvalue
				end
			else if( @skillcode = @TS_SKILL_ALBA )
				begin
					--select 'DEBUG 알바생산(55)', @skillcode skillcode
					set @tsskillalba 	= @tsvalue
				end
			else if( @skillcode = @TS_SKILL_BULLET )
				begin
					--select 'DEBUG 특수탄 생산(56)', @skillcode skillcode
					set @tsskillbullet 	= @tsvalue
				end
			else if( @skillcode = @TS_SKILL_VACCINE )
				begin
					--select 'DEBUG 슈퍼백신생산(57)', @skillcode skillcode
					set @tsskillvaccine = @tsvalue
				end
			else if( @skillcode = @TS_SKILL_FEED )
				begin
					--select 'DEBUG 건초생산(58)', @skillcode skillcode
					set @tsskillfeed 	= @tsvalue
				end
			else if( @skillcode = @TS_SKILL_BOOSTER )
				begin
					--select 'DEBUG 특수촉진제생산(59)', @skillcode skillcode
					set @tsskillbooster = @tsvalue
				end
			else
				begin
					--select 'DEBUG 비인증(xx)', @skillcode skillcode
					set @ischange	= 0
				end
			--select 'DEBUG ', @tsskillcashcost tsskillcashcost, @tsskillheart tsskillheart, @tsskillgamecost tsskillgamecost, @tsskillfpoint tsskillfpoint, @tsskillrebirth tsskillrebirth, @tsskillalba tsskillalba, @tsskillbullet tsskillbullet, @tsskillvaccine tsskillvaccine, @tsskillfeed tsskillfeed, @tsskillbooster tsskillbooster

			if( @ischange = 1 )
				begin
					--select 'DEBUG 보유효과 변경'

					update dbo.tUserMaster
						set
							tsskillcashcost	= @tsskillcashcost,	tsskillheart	= @tsskillheart,	tsskillgamecost	= @tsskillgamecost,
							tsskillfpoint	= @tsskillfpoint,	tsskillrebirth	= @tsskillrebirth,	tsskillalba		= @tsskillalba,
							tsskillbullet	= @tsskillbullet,	tsskillvaccine	= @tsskillvaccine,	tsskillfeed		= @tsskillfeed,			tsskillbooster		= @tsskillbooster
					from dbo.tUserMaster
					where gameid = @gameid_
				end
		end


	------------------------------------------------
	--	4-1. 종류
	------------------------------------------------
	set nocount off
End


