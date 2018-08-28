/*
update dbo.tUserMaster set tsskillbottlelittle = 0 from dbo.tUserMaster where gameid = 'xxxx2'
delete from dbo.tUserItem where gameid = 'xxxx2' and invenkind = 1200
exec spu_SetDirectItemNew 'xxxx2', 120255, 0, 3, -1

exec spu_RoulTreasureWear 'xxxx2', '049000s1i0n7t8445289',  '1:290;2:-1;3:-1;4:-1;5:-1;', -1
exec spu_TSWearEffect 'xxxx2' 		-- 유저 장착보물 능력치 계산

exec spu_RoulTreasureWear 'xxxx2', '049000s1i0n7t8445289',  '1:-1;2:-1;3:-1;4:-1;5:-1;', -1
exec spu_TSWearEffect 'xxxx2' 		-- 유저 장착보물 능력치 계산

*/

use Game4Farmvill5
GO

IF OBJECT_ID ( 'dbo.spu_TSWearEffect', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_TSWearEffect;
GO

create procedure dbo.spu_TSWearEffect
	@gameid_								varchar(20)		-- 게임아이디
	--WITH ENCRYPTION -- 프로시져를 암호화함.
as
	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------
	-- 아이템 대분류
	declare @ITEM_MAINCATEGORY_TREASURE			int					set @ITEM_MAINCATEGORY_TREASURE				= 1200	-- 보물.

	-- 보물스킬코드.
	declare @TS_SKILL_BOTTLE					int					set @TS_SKILL_BOTTLE						= 25	-- 양동이의 크기를 늘려준다(25).

	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @gameid					varchar(20)		set @gameid					= ''
	declare @tslistidx1				int				set @tslistidx1				= -1
	declare @tslistidx2				int				set @tslistidx2				= -1
	declare @tslistidx3				int				set @tslistidx3				= -1
	declare @tslistidx4				int				set @tslistidx4				= -1
	declare @tslistidx5				int				set @tslistidx5				= -1

	declare @treasureupgrade 		int				set @treasureupgrade		= 0
	declare @tsskillbottlelittle	int				set @tsskillbottlelittle 	= 0

	declare @itemcode				int				set @itemcode				= -1
	declare @skillcode				int				set @skillcode				= 0
	declare @tsvalue				int				set @tsvalue				= 0

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	--select 'DEBUG ', @gameid_ gameid_

	------------------------------------------------
	--	3-2. 유저 정보.
	------------------------------------------------
	select
		@gameid 	= gameid,		@tsskillbottlelittle = 0,
		@tslistidx1 = tslistidx1,	@tslistidx2 = tslistidx2,	@tslistidx3 = tslistidx3,	@tslistidx4 = tslistidx4,
		@tslistidx5 = tslistidx5
	from dbo.tUserMaster
	where gameid = @gameid_
	--select 'DEBUG 유저정보', @gameid gameid, @tslistidx1 tslistidx1, @tslistidx2 tslistidx2, @tslistidx3 tslistidx3, @tslistidx4 tslistidx4, @tslistidx5 tslistidx5

	----------------------------------------
	-- 장착된 템 -> 정보추출...
	----------------------------------------
	-- 1. 커서 생성
	declare curTSWearInfo Cursor for
	select itemcode, treasureupgrade from dbo.tUserItem
	where gameid = @gameid_ and listidx in ( @tslistidx1, @tslistidx2, @tslistidx3, @tslistidx4, @tslistidx5 )

	-- 2. 커서오픈
	open curTSWearInfo

	-- 3. 커서 사용
	Fetch next from curTSWearInfo into @itemcode, @treasureupgrade
	while @@Fetch_status = 0
		Begin
			set @skillcode				= 0
			set @tsvalue				= 0

			--------------------------------------
			-- 보물 장착된것에서 정보추출.
			--------------------------------------
			select
				@skillcode 	= param1,
				@tsvalue	= param2 + @treasureupgrade * param3
			from dbo.tItemInfo where itemcode = @itemcode
			--select 'DEBUG 유지.', @itemcode itemcode, @treasureupgrade treasureupgrade, @skillcode skillcode, @tsvalue tsvalue

			if( @skillcode = @TS_SKILL_BOTTLE )
				begin
					--select 'DEBUG 양동이의 크기를 늘려준다(25)', @skillcode skillcode
					set @tsskillbottlelittle 	= @tsvalue / 100
				end

			Fetch next from curTSWearInfo into @itemcode, @treasureupgrade
		end
	-- 4. 커서닫기
	close curTSWearInfo
	Deallocate curTSWearInfo


	--------------------------------------
	-- 보물 정보갱신.
	--------------------------------------
	update dbo.tUserMaster
		set
			tsskillbottlelittle	= @tsskillbottlelittle
	from dbo.tUserMaster
	where gameid = @gameid_


	------------------------------------------------
	--	4-1. 종류
	------------------------------------------------
	set nocount off
End


