/*
exec spu_AnimalLogBackup 'xxxx2', 1, 67, 1, 1	-- �����ΰ�.
select idx3, * from dbo.tUserItemDieLog	where gameid = 'xxxx2'	order by idx desc
select idx3, * from dbo.tUserItemAliveLog where gameid = 'xxxx2' order by idx desc

exec spu_AnimalLogBackup 'xxxx2', 2, 67, 1, 1	-- ��Ȱ�ΰ�.
select idx3, * from dbo.tUserItemDieLog	where gameid = 'xxxx2'	order by idx desc
select idx3, * from dbo.tUserItemAliveLog where gameid = 'xxxx2' order by idx desc


*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_AnimalLogBackup', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_AnimalLogBackup;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_AnimalLogBackup
	@gameid_								varchar(20),
	@mode_									int,			-- ����				�츲
	@listidx_								int,
	@param1_								int,			-- mode_			alivecash
	@param2_								int				-- needhelpcnt		alivedoll
	--WITH ENCRYPTION -- ���ν����� ��ȣȭ��.
as
	------------------------------------------------
	declare @USER_LOGDATA_MAX					int					set @USER_LOGDATA_MAX 						= 10

	------------------------------------------------
	--	2-3. ���λ�� ����
	------------------------------------------------
	declare @idx3		int			set @idx3 = 0
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	--select 'DEBUG ', @gameid_ gameid_, @mode_ mode_, @listidx_ listidx_, @param1_ param1_, @param2_ param2_

	if( @mode_ = 1 )
		begin
			select top 1 @idx3 = isnull(idx3, 1) from dbo.tUserItemDieLog where gameid = @gameid_ order by idx desc
			set @idx3 = @idx3 + 1
			--select 'DEBUG �ʵ� -> ����.', @idx3 idx3, @USER_LOGDATA_MAX USER_LOGDATA_MAX

			-- ����Ÿ > ���
			insert into dbo.tUserItemDieLog(idx3, gameid, listidx, invenkind, itemcode, cnt, farmnum, fieldidx, anistep, manger, diseasestate, acc1, acc2, upcnt, upstepmax, freshstem100, attstem100, timestem100, defstem100, hpstem100, usedheart, usedgamecost, randserial, writedate, gethow,   diedate,  diemode,  needhelpcnt, petupgrade)
			select                         @idx3, gameid, listidx, invenkind, itemcode, cnt, farmnum, fieldidx, anistep, manger, diseasestate, acc1, acc2, upcnt, upstepmax, freshstem100, attstem100, timestem100, defstem100, hpstem100, usedheart, usedgamecost, randserial, writedate, gethow, getdate(), @param1_,     @param2_, petupgrade
			from dbo.tUserItem
			where gameid = @gameid_ and listidx = @listidx_ and invenkind = 1

			--select 'DEBUG ', * from dbo.tUserItem where gameid = @gameid_ and listidx = @listidx_ and invenkind = 1

			-- ���� �����̻��� �α״� ������.
			delete dbo.tUserItemDieLog where gameid = @gameid_ and idx3 < (@idx3 - @USER_LOGDATA_MAX)
		end
	else if( @mode_ = 2 )
		begin
			select top 1 @idx3 = isnull(idx3, 1) from dbo.tUserItemAliveLog where gameid = @gameid_ order by idx desc
			set @idx3 = @idx3 + 1
			--select 'DEBUG ���� -> ��Ȱ.', @idx3 idx3

			-- ����Ÿ > ���
			insert into dbo.tUserItemAliveLog(idx3, gameid, listidx, invenkind, itemcode, cnt, farmnum, fieldidx, anistep, manger, diseasestate, acc1, acc2, upcnt, upstepmax, freshstem100, attstem100, timestem100, defstem100, hpstem100, usedheart, usedgamecost, randserial, writedate, gethow,   diedate, diemode,  needhelpcnt, petupgrade, alivedate,  alivecash,  alivedoll)
			select                           @idx3, gameid, listidx, invenkind, itemcode, cnt, farmnum, fieldidx, anistep, manger, diseasestate, acc1, acc2, upcnt, upstepmax, freshstem100, attstem100, timestem100, defstem100, hpstem100, usedheart, usedgamecost, randserial, writedate, gethow,   diedate, diemode,  needhelpcnt, petupgrade, getdate(),   @param1_,   @param2_
			from dbo.tUserItem
			where gameid = @gameid_ and listidx = @listidx_ and invenkind = 1


			-- ���� �����̻��� �α״� ������.
			delete dbo.tUserItemAliveLog where gameid = @gameid_ and idx3 < (@idx3 - @USER_LOGDATA_MAX)
		end

	set nocount off
End

