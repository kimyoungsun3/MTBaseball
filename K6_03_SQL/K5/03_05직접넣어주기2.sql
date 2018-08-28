/*
------------------------------------------------------------------------------------------------
-- ����Ʈ������ ����Ƽ��, ����, ����Ƽ��, ����, �Ѿ˵�, ��������� �Ʒ����� �����ϰ�� �˻����.
-- Max�� �ִ� ����, ����,��Ʈ, Ȳ��, �ο� -> Max������
-- * �����̱� 	-> ���� (�������� �Է�)
-- * �����̱� 	-> ���� (�������� �Է�)
-- * �ŷ� 		-> ��Ʈ, ����, Ȳ��Ƽ��, �ο�Ƽ���� Max�� üũ�ؼ� �־��ֱ�.
------------------------------------------------------------------------------------------------
-- ���� :   0 -> ��������
--        > 0 -> ������ ���ڸ�ŭ ��.

declare @rtnlistidx int		set @rtnlistidx = -1	-- ����(����(3))
exec spu_SetDirectItemNew 'xxxx2',     1, 1, 3, @rtn_ = @rtnlistidx OUTPUT
select @rtnlistidx rtnlistidx


exec spu_SetDirectItemNew 'xxxx2',    702, 1, 1, -1	-- �Ѿ�
exec spu_SetDirectItemNew 'xxxx2',    811, 1, 1, -1	-- ���
exec spu_SetDirectItemNew 'xxxx2',   1003, 1, 1, -1	-- �ϲ�
exec spu_SetDirectItemNew 'xxxx2',   1103, 1, 1, -1	-- ������
exec spu_SetDirectItemNew 'xxxx2',   2200, 1, 1, -1	-- �Ϲݱ���Ƽ��
exec spu_SetDirectItemNew 'xxxx2',   2300, 1, 1, -1	-- �����̾�����̱�
exec spu_SetDirectItemNew 'xxxx2',   2500, 1, 1, -1	-- �����Ϲݱ���Ƽ��
exec spu_SetDirectItemNew 'xxxx2',   2600, 1, 1, -1	-- ���������̾�����̱�
exec spu_SetDirectItemNew 'xxxx2',   1200, 1, 1, -1	-- ��Ȱ��
exec spu_SetDirectItemNew 'xxxx2',   2100, 1, 1, -1	-- ��޿�ûƼ��

declare @rtnlistidx int		set @rtnlistidx = -1	-- ��������.
exec spu_SetDirectItemNew 'xxxx2',   2600, 0, 14, @rtn_ = @rtnlistidx OUTPUT
select @rtnlistidx rtnlistidx

declare @rtnlistidx int		set @rtnlistidx = -1	-- ��������.
exec spu_SetDirectItemNew 'xxxx2',   2600, 100, 14, @rtn_ = @rtnlistidx OUTPUT
select @rtnlistidx rtnlistidx



exec spu_SetDirectItemNew 'xxxx2',    900, 0, 14, -1	-- ����			(���ο��� �ڵ� �ƽ�üũ��)
exec spu_SetDirectItemNew 'xxxx2',   1900, 0, 14, -1	-- ��������Ʈ	(���ο��� �ڵ� �ƽ�üũ��)
exec spu_SetDirectItemNew 'xxxx2',   2011, 0, 14, -1	-- ��Ʈ			(���ο��� �ڵ� �ƽ�üũ��)
exec spu_SetDirectItemNew 'xxxx2',   3000, 0, 14, -1	-- Ȳ��Ƽ��		(���ο��� �ڵ� �ƽ�üũ��)
exec spu_SetDirectItemNew 'xxxx2',   3100, 0, 14, -1	-- �ο�Ƽ��		(���ο��� �ڵ� �ƽ�üũ��)
exec spu_SetDirectItemNew 'xxxx2',   5000, 0, 14, -1	-- ĳ��
exec spu_SetDirectItemNew 'xxxx2',   5100, 0, 14, -1	-- ����

declare @rtnlistidx int		set @rtnlistidx = -1	-- ��������.
exec spu_SetDirectItemNew 'xxxx2',    3000, 0, 14, @rtn_ = @rtnlistidx OUTPUT
select @rtnlistidx rtnlistidx

declare @rtnlistidx int		set @rtnlistidx = -1	-- ��������.
exec spu_SetDirectItemNew 'xxxx2',    3000, 1000, 14, @rtn_ = @rtnlistidx OUTPUT
select @rtnlistidx rtnlistidx



declare @rtnlistidx int		set @rtnlistidx = -1	-- �꼱��.
exec spu_SetDirectItemNew 'xxxx2', 100000, 1, 3, @rtn_ = @rtnlistidx OUTPUT
select @rtnlistidx rtnlistidx

declare @rtnlistidx int		set @rtnlistidx = -1	-- �ٱ⼼��.
exec spu_SetDirectItemNew 'xxxx2', 104000, 1, 3, @rtn_ = @rtnlistidx OUTPUT
select @rtnlistidx rtnlistidx

declare @rtnlistidx int		set @rtnlistidx = -1	-- ����.
exec spu_SetDirectItemNew 'xxxx2', 120010, 0, 3, @rtn_ = @rtnlistidx OUTPUT
select @rtnlistidx rtnlistidx

-- delete from dbo.tUserItem where gameid = 'xxxx2' and itemcode in ( 3800, 3801 )
declare @rtnlistidx int		set @rtnlistidx = -1	-- ¥����������.
exec spu_SetDirectItemNew 'xxxx2', 3800, 99, 20, @rtn_ = @rtnlistidx OUTPUT
select @rtnlistidx rtnlistidx

declare @rtnlistidx int		set @rtnlistidx = -1	-- ¥������.
exec spu_SetDirectItemNew 'xxxx2', 3801, 1, 20, @rtn_ = @rtnlistidx OUTPUT
select @rtnlistidx rtnlistidx
*/
use GameMTBaseball
GO
------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------

IF OBJECT_ID ( 'dbo.spu_SetDirectItemNew', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_SetDirectItemNew;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_SetDirectItemNew
	@gameid_				varchar(20),
	@itemcode_				int,
	@sendcnt_				int,
	@gethow_				int,
	@rtn_				int					OUTPUT
	--WITH ENCRYPTION
AS
	------------------------------------------------
	--	2-1. �ڵ尪
	------------------------------------------------
	------------------------------------------------
	--	2-2. ���ǵȰ�
	------------------------------------------------
	-- �����ۺ� �κ��з�
	declare @USERITEM_INVENKIND_ANI				int 				set @USERITEM_INVENKIND_ANI					= 1
	declare @USERITEM_INVENKIND_CONSUME			int 				set @USERITEM_INVENKIND_CONSUME				= 3
	--declare @USERITEM_INVENKIND_ACC			int 				set @USERITEM_INVENKIND_ACC					= 4
	--declare @USERITEM_INVENKIND_DIRECT		int 				set @USERITEM_INVENKIND_DIRECT				= 40
	--declare @USERITEM_INVENKIND_INFO			int 				set @USERITEM_INVENKIND_INFO				= 60
	declare @USERITEM_INVENKIND_PET				int 				set @USERITEM_INVENKIND_PET					= 1000
	declare @USERITEM_INVENKIND_STEMCELL		int 				set @USERITEM_INVENKIND_STEMCELL			= 1040
	declare @USERITEM_INVENKIND_TREASURE		int 				set @USERITEM_INVENKIND_TREASURE			= 1200

	-- ������ ������
	--declare @ITEM_SUBCATEGORY_COW				int					set @ITEM_SUBCATEGORY_COW 					= 1  -- ��		(�Ǹ�[O], ����[O])			0
	--declare @ITEM_SUBCATEGORY_GOAT			int					set @ITEM_SUBCATEGORY_GOAT 					= 2  -- ��		(�Ǹ�[O], ����[O])			0
	--declare @ITEM_SUBCATEGORY_SHEEP			int					set @ITEM_SUBCATEGORY_SHEEP 				= 3  -- ���	(�Ǹ�[O], ����[O])			0
	--declare @ITEM_SUBCATEGORY_SEED			int					set @ITEM_SUBCATEGORY_SEED 					= 7  -- ����	(�Ǹ�[X], ����[X], ����[O])	0
	--declare @ITEM_SUBCATEGORY_BULLET			int					set @ITEM_SUBCATEGORY_BULLET 				= 8  -- �Ѿ�	(�Ǹ�[O], ����[O])			0
	--declare @ITEM_SUBCATEGORY_VACCINE			int					set @ITEM_SUBCATEGORY_VACCINE 				= 9  -- ���	(�Ǹ�[O], ����[O])			0
	declare @ITEM_SUBCATEGORY_FEED				int					set @ITEM_SUBCATEGORY_FEED 					= 44 -- ����	(�Ǹ�[X], ����[O])
	--declare @ITEM_SUBCATEGORY_ALBA			int					set @ITEM_SUBCATEGORY_ALBA 					= 11 -- �ϲ�	(�Ǹ�[O], ����[O])			0
	--declare @ITEM_SUBCATEGORY_BOOSTER			int					set @ITEM_SUBCATEGORY_BOOSTER 				= 12 -- ������	(�Ǹ�[O], ����[O])			0
	--declare @ITEM_SUBCATEGORY_REVIVAL			int					set @ITEM_SUBCATEGORY_REVIVAL 				= 13 -- ��Ȱ��	(�Ǹ�[O], ����[O])			0
	--declare @ITEM_SUBCATEGORY_COMPOSE_TIME	int					set @ITEM_SUBCATEGORY_COMPOSE_TIME 			= 16 -- �ռ�1�ð� �ʱ�ȭ(�Ǹ�[X], ����[O])
	--declare @ITEM_SUBCATEGORY_ACC				int					set @ITEM_SUBCATEGORY_ACC 					= 15 -- �Ǽ�	(�Ǹ�[O], ����[O])			0
	declare @ITEM_SUBCATEGORY_FPOINT			int					set @ITEM_SUBCATEGORY_FPOINT 				= 19 -- ��������Ʈ(�Ǹ�[X], ����[O])
	declare @ITEM_SUBCATEGORY_HEART				int					set @ITEM_SUBCATEGORY_HEART 				= 40 -- ��Ʈ	(�Ǹ�[O], ����[O])
	--declare @ITEM_SUBCATEGORY_HELPER			int					set @ITEM_SUBCATEGORY_HELPER 				= 41 -- ��޿�û(�Ǹ�[X], ����[O])			0
	--declare @ITEM_SUBCATEGORY_TRADESAFE		int					set @ITEM_SUBCATEGORY_TRADESAFE				= 42 -- ���θ���(�Ǹ�[X], ����[O])			0
	declare @ITEM_SUBCATEGORY_CASHCOST			int					set @ITEM_SUBCATEGORY_CASHCOST 				= 50 -- ĳ��	(�Ǹ�[O], ����[O])
	declare @ITEM_SUBCATEGORY_GAMECOST			int					set @ITEM_SUBCATEGORY_GAMECOST 				= 51 -- ����	(�Ǹ�[O], ����[O])
	--declare @ITEM_SUBCATEGORY_ROULETTE_NOR	int					set @ITEM_SUBCATEGORY_ROULETTE_NOR			= 22 -- �Ϲݱ���̱�Ƽ��(�Ǹ�[X], ����[O])
	--declare @ITEM_SUBCATEGORY_ROULETTE_PRE	int					set @ITEM_SUBCATEGORY_ROULETTE_PRE			= 23 -- �����̾�����̱�Ƽ��(�Ǹ�[X], ����[O])
	--declare @ITEM_SUBCATEGORY_TREASURE_NOR	int					set @ITEM_SUBCATEGORY_TREASURE_NOR			= 25 -- �Ϲ� ���� �̱�Ƽ��
	--declare @ITEM_SUBCATEGORY_TREASURE_PRE	int					set @ITEM_SUBCATEGORY_TREASURE_PRE			= 26 -- �����̾� ���� �̱�Ƽ��
	--declare @ITEM_SUBCATEGORY_CONTEST			int					set @ITEM_SUBCATEGORY_CONTEST 				= 53 -- ��ȸ	(�Ǹ�[O], ����[O])			0
	--declare @ITEM_SUBCATEGORY_UPGRADE_HOUSE	int					set @ITEM_SUBCATEGORY_UPGRADE_HOUSE 		= 60 -- ��
	--declare @ITEM_SUBCATEGORY_UPGRADE_TANK	int					set @ITEM_SUBCATEGORY_UPGRADE_TANK 			= 61 -- ��ũ
	--declare @ITEM_SUBCATEGORY_UPGRADE_FRESHCOOL	int				set @ITEM_SUBCATEGORY_UPGRADE_FRESHCOOL 	= 62 -- ���º���
	--declare @ITEM_SUBCATEGORY_UPGRADE_PURE	int					set @ITEM_SUBCATEGORY_UPGRADE_PURE 			= 63 -- ��ȭ�ü�
	--declare @ITEM_SUBCATEGORY_UPGRADE_BOTTLE	int					set @ITEM_SUBCATEGORY_UPGRADE_BOTTLE 		= 64 -- �絿��
	--declare @ITEM_SUBCATEGORY_UPGRADE_PUMP	int					set @ITEM_SUBCATEGORY_UPGRADE_PUMP 			= 65 -- ������
	--declare @ITEM_SUBCATEGORY_UPGRADE_TRANSFER	int				set @ITEM_SUBCATEGORY_UPGRADE_TRANSFER 		= 66 -- ���Ա�
	--declare @ITEM_SUBCATEGORY_INVEN			int					set @ITEM_SUBCATEGORY_INVEN 				= 67 -- �κ�Ȯ��
	--declare @ITEM_SUBCATEGORY_SEEDFIELD		int					set @ITEM_SUBCATEGORY_SEEDFIELD 			= 68 -- ������Ȯ��
	--declare @ITEM_SUBCATEGORY_DOGAM			int					set @ITEM_SUBCATEGORY_DOGAM 				= 818 -- ����
	--declare @ITEM_SUBCATEGORY_SYSINFO			int					set @ITEM_SUBCATEGORY_SYSINFO 				= 500 -- ��������
	--declare @ITEM_SUBCATEGORY_ATTENDANCE		int					set @ITEM_SUBCATEGORY_ATTENDANCE 			= 900 	--�⼮(900)
	--declare @ITEM_SUBCATEGORY_COMPETITION		int					set @ITEM_SUBCATEGORY_COMPETITION 			= 901 	--������(901)
	declare @ITEM_SUBCATEGORY_PET				int					set @ITEM_SUBCATEGORY_PET					= 1000 	--��(1000)
	declare @ITEM_SUBCATEGORY_GOLDTICKET		int					set @ITEM_SUBCATEGORY_GOLDTICKET			= 30	-- Ȳ��Ƽ��.
	declare @ITEM_SUBCATEGORY_BATTLETICKET		int					set @ITEM_SUBCATEGORY_BATTLETICKET			= 31	-- �ο�Ƽ��.
	--declare @ITEM_SUBCATEGORY_STEMCELL		int					set @ITEM_SUBCATEGORY_STEMCELL				= 1040	-- �ٱ⼼��.
	declare @ITEM_SUBCATEGORY_ZZCOUPON			int					set @ITEM_SUBCATEGORY_ZZCOUPON				= 38	-- ¥�� ����(38)

	-- ���Ÿ ����
	declare @USERITEM_PET_UPGRADE_MAX			int					set @USERITEM_PET_UPGRADE_MAX				= 6		-- ���׷��̵� �ƽ�.
	declare @USERITEM_TREASURE_UPGRADE_MAX		int					set @USERITEM_TREASURE_UPGRADE_MAX			= 7		-- max��ȭ.

	-- Ư����.
	--declare @ITEM_ZCP_PIECE_MOTHER			int					set @ITEM_ZCP_PIECE_MOTHER					= 3800	-- ¥����������.
	declare @ITEM_ZCP_TICKET_MOTHER				int					set @ITEM_ZCP_TICKET_MOTHER					= 3801	-- ¥������.


	------------------------------------------------
	--	2-3. ���λ�� ����
	------------------------------------------------
	declare @gameid			varchar(20)		set @gameid			= @gameid_
	declare @subcategory 	int
	declare @buyamount		int				set @buyamount		= @sendcnt_
	declare @invenkind		int
	declare @itemcode		int				set @itemcode		= @itemcode_
	declare @cnt			int				set @cnt			= 0
	declare @upstepmax		int				set @upstepmax		= 16

	declare @listidxrtn 	int				set @listidxrtn		= -1
	declare @listidxnew 	int				set @listidxnew		= -1
	declare @listidxcust 	int				set @listidxcust	= -1
	declare @listidxpet 	int				set @listidxpet		= -1
	declare @petupgradeinit	int				set @petupgradeinit	=  1

Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	--select 'DEBUG 1-1 �Է°�', @gameid_ gameid_, @itemcode_ itemcode_, @sendcnt_ sendcnt_
	if(@itemcode = -1)
		begin
			set @rtn_ = -1
			return
		end

	------------------------------------------------
	--	3-2. �������(��������, ��������, ������ ����)
	------------------------------------------------
	select
		@subcategory 	= subcategory,
		@buyamount 		= buyamount,
		@upstepmax		= param30
	from dbo.tItemInfo where itemcode = @itemcode
	--select 'DEBUG 1-4 ', @subcategory subcategory, @buyamount buyamount, @sendcnt_ sendcnt_

	set @buyamount = case when(@sendcnt_ > 0) then @sendcnt_ else @buyamount end
	set @invenkind = dbo.fnu_GetInvenFromSubCategory(@subcategory)
	select @listidxnew = isnull(MAX(listidx), 0) + 1 from dbo.tUserItem where gameid = @gameid_
	--select 'DEBUG 4-1 ', @subcategory subcategory, @buyamount buyamount, @invenkind invenkind, @listidxnew listidxnew

	if(@invenkind = @USERITEM_INVENKIND_ANI)
		begin
			--------------------------------------------------------------
			-- ��,��,���			-> ���� ������
			--------------------------------------------------------------
			-- �ش������ �κ��� ����
			insert into dbo.tUserItem(gameid,      listidx,  itemcode, cnt, farmnum,  fieldidx,  invenkind,  upstepmax,  gethow)
			values(					 @gameid_, @listidxnew, @itemcode,   1,       0,        -1, @invenkind, @upstepmax, @gethow_)

			-- �������
			exec spu_DogamListLog @gameid_, @itemcode

			-- ����� ������ ����Ʈ�ε���
			set @listidxrtn	= @listidxnew
		end
	else if(@invenkind = @USERITEM_INVENKIND_CONSUME and @itemcode = @ITEM_ZCP_TICKET_MOTHER )
		begin
			--------------------------------------------------------------
			-- ¥������ (60�� ������).
			--------------------------------------------------------------
			--select 'DEBUG ¥������ insert', @gameid_ gameid_, @listidxnew listidxnew, @itemcode itemcode, @buyamount buyamount
			insert into dbo.tUserItem(gameid,       listidx,  itemcode,        cnt, expirekind,     expiredate,  invenkind,  gethow)
			values(					 @gameid_,  @listidxnew, @itemcode, @buyamount,          1, getdate() + 60, @invenkind, @gethow_)

			-- ����� ������ ����Ʈ�ε���
			set @listidxrtn	= @listidxnew
		end
	else if(@invenkind = @USERITEM_INVENKIND_CONSUME)
		begin
			--------------------------------------------------------------
			-- ��ǥ�Ҹ��� ����.
			--------------------------------------------------------------
			set @itemcode = dbo.fnu_GetItemcodeFromConsumePackage(@subcategory, @itemcode)

			select
				@listidxcust = listidx
			from dbo.tUserItem
			where gameid = @gameid_ and itemcode = @itemcode
			--select 'DEBUG 4-3 �Һ�(n)�κ��ֱ�', @gameid_ gameid_, @subcategory subcategory, @itemcode itemcode, @listidxcust listidxcust

			if(@listidxcust = -1)
				begin
					--select 'DEBUG �Һ� �߰�', @gameid_ gameid_, @listidxnew listidxnew, @itemcode itemcode, @buyamount buyamount

					insert into dbo.tUserItem(gameid,      listidx,  itemcode,        cnt,  invenkind,  gethow)
					values(					@gameid_,  @listidxnew, @itemcode, @buyamount, @invenkind, @gethow_)

					-- ����� ������ ����Ʈ�ε���
					set @listidxrtn	= @listidxnew
				end
			else
				begin
					--select 'DEBUG �Һ� �����ۿ� ����', @gameid_ gameid_, @listidxcust listidxcust, @buyamount buyamount

					update dbo.tUserItem
						set
							cnt = cnt + @buyamount
					where gameid = @gameid_ and listidx = @listidxcust

					-- ����� ������ ����Ʈ�ε���
					set @listidxrtn	= @listidxcust
				end
		end
	else if(@invenkind = @USERITEM_INVENKIND_STEMCELL)
		begin
			--------------------------------------------------------------
			-- �ٱ⼼��					-> �ٱ⼼�� ������
			--------------------------------------------------------------
			insert into dbo.tUserItem(gameid,      listidx,  itemcode, invenkind,   gethow)		-- �Ǽ�
			values(					 @gameid_, @listidxnew, @itemcode, @invenkind, @gethow_)

			-- ����� ������ ����Ʈ�ε���
			set @listidxrtn	= @listidxnew
		end
	else if(@invenkind = @USERITEM_INVENKIND_TREASURE)
		begin
			insert into dbo.tUserItem(gameid,      listidx,  itemcode,  invenkind,                      upstepmax,  gethow)
			values(					 @gameid_, @listidxnew, @itemcode, @invenkind, @USERITEM_TREASURE_UPGRADE_MAX, @gethow_)

			-- ����� ������ ����Ʈ�ε���
			set @listidxrtn	= @listidxnew

			---------------------------------
			-- ���� ����ȿ�� ����.
			---------------------------------
			exec spu_TSRetentionEffect @gameid_, @itemcode
		end
	else if(@invenkind = @USERITEM_INVENKIND_PET)
		begin
			--------------------------------------------------------------
			-- ��					-> �� ������
			--------------------------------------------------------------
			--select 'DEBUG 4-4-2 ���� > ���κ����� �̵�, �̺� ���� ���·� ����', @gameid_ gameid_, @listidxnew listidxnew, @itemcode itemcode

			select
				@listidxpet = listidx
			from dbo.tUserItem
			where gameid = @gameid_ and itemcode = @itemcode
			--select 'DEBUG >', @listidxpet listidxpet

			select
				@petupgradeinit		= param5
			from dbo.tItemInfo where itemcode = @itemcode and subcategory = @ITEM_SUBCATEGORY_PET
			--select 'DEBUG >', @petupgradeinit petupgradeinit

			if(@listidxpet = -1)
				begin
					--select 'DEBUG �� �߰�', @gameid_ gameid_, @listidxnew listidxnew, @itemcode itemcode, @buyamount buyamount
					insert into dbo.tUserItem(gameid,      listidx,  itemcode, invenkind,       petupgrade,  gethow)
					values(					 @gameid_, @listidxnew, @itemcode, @invenkind, @petupgradeinit, @gethow_)

					-- �굵�����.
					exec spu_DogamListPetLog @gameid_, @itemcode

					-- ����� ������ ����Ʈ�ε���
					set @listidxrtn	= @listidxnew
				end
			else
				begin
					--select 'DEBUG �� ���׷��̵�', @gameid_ gameid_, @listidxpet listidxpet

					update dbo.tUserItem
						set
							petupgrade = case
											when (petupgrade + 1 >= @USERITEM_PET_UPGRADE_MAX) then @USERITEM_PET_UPGRADE_MAX
											else													petupgrade + 1
										end
					where gameid = @gameid_ and listidx = @listidxpet

					-- ����� ������ ����Ʈ�ε���
					set @listidxrtn	= @listidxpet
				end
		end
	else if(@subcategory = @ITEM_SUBCATEGORY_CASHCOST)
		begin
			--select 'DEBUG 4-5-1 cashcost(ĳ��)	-> �ٷ�����'
			update dbo.tUserMaster
				set
					cashcost = cashcost + @buyamount
			where gameid = @gameid_
		end
	else if(@subcategory = @ITEM_SUBCATEGORY_GAMECOST)
		begin
			--select 'DEBUG 4-5-2 gamecost(����)	-> �ٷ�����', @buyamount buyamount
			update dbo.tUserMaster
				set
					gamecost = gamecost + @buyamount
			where gameid = @gameid_

		end
	else if(@subcategory = @ITEM_SUBCATEGORY_GOLDTICKET)
		begin
			--select 'DEBUG 4-6 Ȳ��Ƽ��  -> �ٷ�����'
			update dbo.tUserMaster
				set
					goldticket =  case
								when (goldticket 		 	 ) > goldticketmax then goldticket
								when (goldticket + @buyamount) > goldticketmax then goldticketmax
								else (goldticket + @buyamount)
							end
			where gameid = @gameid_
		end
	else if(@subcategory = @ITEM_SUBCATEGORY_BATTLETICKET)
		begin
			--select 'DEBUG 4-6 ��ƲƼ��  -> �ٷ�����'
			update dbo.tUserMaster
				set
					battleticket =  case
								when (battleticket 		 	   ) > battleticketmax then battleticket
								when (battleticket + @buyamount) > battleticketmax then battleticketmax
								else (battleticket + @buyamount)
							end
			where gameid = @gameid_
		end
	else if(@subcategory = @ITEM_SUBCATEGORY_FPOINT)
		begin
			--select 'DEBUG 4-5-3 ��������Ʈ -> �ٷ�����'
			update dbo.tUserMaster
				set
					fpoint =  case
								when (fpoint 		 	 ) > fpointmax then fpoint
								when (fpoint + @buyamount) > fpointmax then fpointmax
								else (fpoint + @buyamount)
							end
			where gameid = @gameid_
		end
	else if(@subcategory = @ITEM_SUBCATEGORY_HEART)
		begin
			--select 'DEBUG 4-6 ��Ʈ  -> �ٷ�����'
			update dbo.tUserMaster
				set
					heart = case
								when (heart 			) > heartmax then heart
								when (heart + @buyamount) > heartmax then heartmax
								else (heart + @buyamount)
							end
			where gameid = @gameid_
		end
	else if(@subcategory = @ITEM_SUBCATEGORY_FEED)
		begin
			--select 'DEBUG 4-6 ����  -> �ٷ�����'
			update dbo.tUserMaster
				set
				feed = case
							when (feed 			   ) > feedmax then feed
							when (feed + @buyamount) > feedmax then feedmax
							else (feed + @buyamount)
						end
			where gameid = @gameid_
		end
	else
		begin
			set @listidxrtn = @listidxrtn
		end

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off

	set @rtn_ = @listidxrtn
END
