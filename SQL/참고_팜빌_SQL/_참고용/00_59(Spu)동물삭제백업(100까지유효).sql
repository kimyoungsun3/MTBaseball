/*
exec spu_FVDeleteUserItemBackup 0, 'guest90909', 145	-- 0:����
exec spu_FVDeleteUserItemBackup 1, 'guest90909', 145	-- 1:�Ǹ�
exec spu_FVDeleteUserItemBackup 2, 'guest90909', 145	-- 2:������
exec spu_FVDeleteUserItemBackup 3, 'guest90909', 145	-- 3:�ռ�
*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVDeleteUserItemBackup', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVDeleteUserItemBackup;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_FVDeleteUserItemBackup
	@state_									int,
	@gameid_								varchar(60),
	@listidx_								int
	--WITH ENCRYPTION -- ���ν����� ��ȣȭ��.
as

	------------------------------------------------
	declare @USER_LOGDATA_MAX					int					set @USER_LOGDATA_MAX 						= 1000

	------------------------------------------------
	--	2-3. ���λ�� ����
	------------------------------------------------
	declare @idx2		int			set @idx2 = 0
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on

	--Ŭ������ �ε����� �̿�.
	select top 1 @idx2 = isnull(idx2, 1) from dbo.tFVUserItemDel where gameid = @gameid_ order by idx desc
	set @idx2 = @idx2 + 1

	-- ���� > ���
	delete from dbo.tFVUserItem
		OUTPUT
		DELETED.gameid, 	DELETED.listidx, 	DELETED.invenkind, 	DELETED.itemcode, 	DELETED.cnt,
		DELETED.farmnum, 	DELETED.fieldidx,	DELETED.anistep,	DELETED.manger,		DELETED.diseasestate,
		DELETED.acc1,		DELETED.acc2,
		DELETED.abilkind,	DELETED.abilval,	DELETED.abilkind2,	DELETED.abilval2,
		DELETED.abilkind3,	DELETED.abilval3,	DELETED.abilkind4,	DELETED.abilval4,	DELETED.abilkind5,	DELETED.abilval5,

		DELETED.randserial,	DELETED.writedate,	DELETED.gethow,
		DELETED.diedate,	DELETED.diemode, 	@idx2, 				@state_
		into dbo.tFVUserItemDel(	gameid, 	listidx, 	invenkind, 	itemcode, 	cnt,
								farmnum, 	fieldidx,	anistep,	manger,		diseasestate,
								acc1,		acc2,
								abilkind,	abilval,	abilkind2,	abilval2,
								abilkind3,	abilval3,	abilkind4,	abilval4,	abilkind5,	abilval5,

								randserial,	writedate,	gethow,
								diedate,	diemode, 	idx2, 		state)
	where gameid = @gameid_ and listidx = @listidx_


	-- ���� �����̻��� �α״� ������.
	delete dbo.tFVUserItemDel where gameid = @gameid_ and idx2 < (@idx2 - @USER_LOGDATA_MAX)

	set nocount off
End

