/*
exec spu_DeleteUserItemBackup 0, 'guest90909', 145	-- 0:병원
exec spu_DeleteUserItemBackup 1, 'guest90909', 145	-- 1:판매
exec spu_DeleteUserItemBackup 2, 'guest90909', 145	-- 2:우편함
exec spu_DeleteUserItemBackup 3, 'guest90909', 145	-- 3:합성
exec spu_DeleteUserItemBackup 3, 'guest90909', 145	-- 4:동물세포 분해
exec spu_DeleteUserItemBackup 3, 'guest90909', 145	-- 5:보물세포 분해
exec spu_DeleteUserItemBackup 3, 'guest90909', 145	-- 6:승급
exec spu_DeleteUserItemBackup 3, 'guest90909', 145	-- 10:장터구매.
exec spu_DeleteUserItemBackup 3, 'guest90909', 145	-- 11:만기삭제.
*/
use Game4Farmvill5
GO

IF OBJECT_ID ( 'dbo.spu_DeleteUserItemBackup', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_DeleteUserItemBackup;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_DeleteUserItemBackup
	@state_									int,
	@gameid_								varchar(20),
	@listidx_								int
	--WITH ENCRYPTION -- 프로시져를 암호화함.
as

	------------------------------------------------
	declare @USER_LOGDATA_MAX					int					set @USER_LOGDATA_MAX 						= 100

	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @idx2		int			set @idx2 = 0
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on

	--클러스터 인덱스를 이용.
	select top 1 @idx2 = isnull(idx2, 1) from dbo.tUserItemDel where gameid = @gameid_ order by idx desc
	set @idx2 = @idx2 + 1

	-- 삭제 > 백업
	delete from dbo.tUserItem
		OUTPUT
		DELETED.gameid, 	DELETED.listidx, 	DELETED.invenkind, 	DELETED.itemcode, 	DELETED.cnt,
		DELETED.farmnum, 	DELETED.fieldidx,	DELETED.anistep,	DELETED.manger,		DELETED.diseasestate,
		DELETED.acc1,		DELETED.acc2,
		DELETED.upcnt,		DELETED.upstepmax,
		DELETED.freshstem100,DELETED.attstem100,DELETED.timestem100,DELETED.defstem100,	DELETED.hpstem100,
		DELETED.usedheart,	DELETED.usedgamecost,
		DELETED.expirekind,	DELETED.expiredate,

		DELETED.randserial,	DELETED.writedate,	DELETED.gethow,
		DELETED.diedate,	DELETED.diemode, 	DELETED.needhelpcnt,	DELETED.petupgrade,		DELETED.treasureupgrade,
		@idx2, 				@state_
		into dbo.tUserItemDel(	gameid, 	listidx, 	invenkind, 	itemcode, 	cnt,
								farmnum, 	fieldidx,	anistep,	manger,		diseasestate,
								acc1,		acc2,
								upcnt,		upstepmax,
								freshstem100,	attstem100,	timestem100,	defstem100,	hpstem100,
								usedheart, usedgamecost,
								expirekind,	expiredate,

								randserial,	writedate,	gethow,
								diedate,	diemode, 	needhelpcnt,			petupgrade,				treasureupgrade,
								idx2, 		state)
	where gameid = @gameid_ and listidx = @listidx_


	-- 일정 수량이상의 로그는 삭제함.
	delete dbo.tUserItemDel where gameid = @gameid_ and idx2 < (@idx2 - @USER_LOGDATA_MAX)

	set nocount off
End

