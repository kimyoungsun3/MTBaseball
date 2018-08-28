/*
exec spu_AnimalLogBackup 'xxxx2', 1, 67, 1, 1	-- 죽음로고.
select idx3, * from dbo.tUserItemDieLog	where gameid = 'xxxx2'	order by idx desc
select idx3, * from dbo.tUserItemAliveLog where gameid = 'xxxx2' order by idx desc

exec spu_AnimalLogBackup 'xxxx2', 2, 67, 1, 1	-- 부활로고.
select idx3, * from dbo.tUserItemDieLog	where gameid = 'xxxx2'	order by idx desc
select idx3, * from dbo.tUserItemAliveLog where gameid = 'xxxx2' order by idx desc


*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_AnimalLogBackup', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_AnimalLogBackup;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_AnimalLogBackup
	@gameid_								varchar(20),
	@mode_									int,			-- 죽음				살림
	@listidx_								int,
	@param1_								int,			-- mode_			alivecash
	@param2_								int				-- needhelpcnt		alivedoll
	--WITH ENCRYPTION -- 프로시져를 암호화함.
as
	------------------------------------------------
	declare @USER_LOGDATA_MAX					int					set @USER_LOGDATA_MAX 						= 10

	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @idx3		int			set @idx3 = 0
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	--select 'DEBUG ', @gameid_ gameid_, @mode_ mode_, @listidx_ listidx_, @param1_ param1_, @param2_ param2_

	if( @mode_ = 1 )
		begin
			select top 1 @idx3 = isnull(idx3, 1) from dbo.tUserItemDieLog where gameid = @gameid_ order by idx desc
			set @idx3 = @idx3 + 1
			--select 'DEBUG 필드 -> 죽음.', @idx3 idx3, @USER_LOGDATA_MAX USER_LOGDATA_MAX

			-- 데이타 > 백업
			insert into dbo.tUserItemDieLog(idx3, gameid, listidx, invenkind, itemcode, cnt, farmnum, fieldidx, anistep, manger, diseasestate, acc1, acc2, upcnt, upstepmax, freshstem100, attstem100, timestem100, defstem100, hpstem100, usedheart, usedgamecost, randserial, writedate, gethow,   diedate,  diemode,  needhelpcnt, petupgrade)
			select                         @idx3, gameid, listidx, invenkind, itemcode, cnt, farmnum, fieldidx, anistep, manger, diseasestate, acc1, acc2, upcnt, upstepmax, freshstem100, attstem100, timestem100, defstem100, hpstem100, usedheart, usedgamecost, randserial, writedate, gethow, getdate(), @param1_,     @param2_, petupgrade
			from dbo.tUserItem
			where gameid = @gameid_ and listidx = @listidx_ and invenkind = 1

			--select 'DEBUG ', * from dbo.tUserItem where gameid = @gameid_ and listidx = @listidx_ and invenkind = 1

			-- 일정 수량이상의 로그는 삭제함.
			delete dbo.tUserItemDieLog where gameid = @gameid_ and idx3 < (@idx3 - @USER_LOGDATA_MAX)
		end
	else if( @mode_ = 2 )
		begin
			select top 1 @idx3 = isnull(idx3, 1) from dbo.tUserItemAliveLog where gameid = @gameid_ order by idx desc
			set @idx3 = @idx3 + 1
			--select 'DEBUG 죽음 -> 부활.', @idx3 idx3

			-- 데이타 > 백업
			insert into dbo.tUserItemAliveLog(idx3, gameid, listidx, invenkind, itemcode, cnt, farmnum, fieldidx, anistep, manger, diseasestate, acc1, acc2, upcnt, upstepmax, freshstem100, attstem100, timestem100, defstem100, hpstem100, usedheart, usedgamecost, randserial, writedate, gethow,   diedate, diemode,  needhelpcnt, petupgrade, alivedate,  alivecash,  alivedoll)
			select                           @idx3, gameid, listidx, invenkind, itemcode, cnt, farmnum, fieldidx, anistep, manger, diseasestate, acc1, acc2, upcnt, upstepmax, freshstem100, attstem100, timestem100, defstem100, hpstem100, usedheart, usedgamecost, randserial, writedate, gethow,   diedate, diemode,  needhelpcnt, petupgrade, getdate(),   @param1_,   @param2_
			from dbo.tUserItem
			where gameid = @gameid_ and listidx = @listidx_ and invenkind = 1


			-- 일정 수량이상의 로그는 삭제함.
			delete dbo.tUserItemAliveLog where gameid = @gameid_ and idx3 < (@idx3 - @USER_LOGDATA_MAX)
		end

	set nocount off
End

