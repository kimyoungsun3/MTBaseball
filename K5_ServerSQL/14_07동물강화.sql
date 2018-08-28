---------------------------------------------------------------
/*
update dbo.tUserMaster set cashcost = 0,    gamecost = 0,     heart = 0,     randserial = -1 where gameid = 'xxxx2'
update dbo.tUserMaster set cashcost = 1000, gamecost = 10000, heart = 10000, randserial = -1 where gameid = 'xxxx2'
update dbo.tUserItem set upcnt = 0 where gameid = 'xxxx2' and listidx = 2
delete from dbo.tUserItem where gameid = 'xxxx2' and listidx >= 30

insert into dbo.tUserItem(gameid, listidx, itemcode, invenkind) values('xxxx2', 30, 104000, 1040) insert into dbo.tUserItem(gameid, listidx, itemcode, invenkind) values('xxxx2', 31, 104001, 1040) insert into dbo.tUserItem(gameid, listidx, itemcode, invenkind) values('xxxx2', 32, 104002, 1040) insert into dbo.tUserItem(gameid, listidx, itemcode, invenkind) values('xxxx2', 33, 104003, 1040) insert into dbo.tUserItem(gameid, listidx, itemcode, invenkind) values('xxxx2', 34, 104004, 1040) insert into dbo.tUserItem(gameid, listidx, itemcode, invenkind) values('xxxx2', 35, 104005, 1040) insert into dbo.tUserItem(gameid, listidx, itemcode, invenkind) values('xxxx2', 36, 104006, 1040)

exec spu_AniUpgrade 'xxxx2', '049000s1i0n7t8445289', 2, '0:30;',							'7771', -1
exec spu_AniUpgrade 'xxxx2', '049000s1i0n7t8445289', 2, '1:31;2:32;3:33;4:34;5:35;6:36;', 	'7772', -1

*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_AniUpgrade', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_AniUpgrade;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_AniUpgrade
	@gameid_				varchar(20),
	@password_				varchar(20),
	@listidxani_			int,
	@listset_				varchar(256),
	@randserial_			varchar(20),
	@nResult_				int					OUTPUT
	--WITH ENCRYPTION
as
	------------------------------------------------
	--	2-1. �ڵ尪
	------------------------------------------------
	-- �Ϲݰ�
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	-- �α��� ����.
	declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--������ > �˾�ó���� ��Ʈ�η� ��������.
	declare @RESULT_ERROR_DELETED_USER 			int				set @RESULT_ERROR_DELETED_USER			= -12			--�������� > �˾�ó���� ��Ʈ�η� ��������.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--�ش������� ã�� ����

	-- �����߿� ����.
	declare @RESULT_ERROR_HEART_LACK			int				set @RESULT_ERROR_HEART_LACK			= -20			--��Ʈ�� �����ϴ�.
	declare @RESULT_ERROR_GAMECOST_LACK			int				set @RESULT_ERROR_GAMECOST_LACK			= -21			--�ǹ��� �����ϴ�.
	declare @RESULT_ERROR_ITEM_LACK				int				set @RESULT_ERROR_ITEM_LACK				= -23			--�������̺����ϴ�.

	-- ��Ÿ����
	declare @RESULT_ERROR_UPGRADE_FULL			int				set @RESULT_ERROR_UPGRADE_FULL			= -35			--���׷��̵尡 Ǯ�εǾ���.
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- �������ڵ��ã��
	declare @RESULT_ERROR_NOT_MATCH				int				set @RESULT_ERROR_NOT_MATCH				= -110			-- �����ΰ� ��ġ�� �ȵǾ���.
	declare @RESULT_ERROR_LISTIDX_NOT_FOUND		int				set @RESULT_ERROR_LISTIDX_NOT_FOUND		= -114			-- ����Ʈ ��ȣ�� ��ã��.
	------------------------------------------------
	--	2-2. ���ǵȰ�
	------------------------------------------------
	-- �����ۺ� �κ��з�
	declare @USERITEM_INVENKIND_ANI				int 				set @USERITEM_INVENKIND_ANI					= 1
	declare @USERITEM_INVENKIND_STEMCELL		int 				set @USERITEM_INVENKIND_STEMCELL			= 1040

	-- ������ ��з�
	declare @ITEM_MAINCATEGORY_ANI				int					set @ITEM_MAINCATEGORY_ANI 					= 1 	--����(1)

	-- ������ �Һз�
	declare @ITEM_SUBCATEGORY_STEMCELL			int					set @ITEM_SUBCATEGORY_STEMCELL				= 1040	-- �ٱ⼼��.

	------------------------------------------------
	--	2-3. ���λ�� ����
	------------------------------------------------
	declare @comment		varchar(80)
	declare @gameid			varchar(20)		set @gameid			= ''		-- ��������.
	declare @market			int				set @market			= 5
	declare @cashcost		int				set @cashcost 		= 0
	declare @gamecost		int				set @gamecost 		= 0
	declare @heart			int				set @heart 			= 0
	declare @feed			int				set @feed 			= 0
	declare @fpoint			int				set @fpoint			= 0
	declare @goldticket		int				set @goldticket		= 0
	declare @battleticket	int				set @battleticket	= 0
	declare @randserial		varchar(20)		set @randserial		= '-1'

	declare @aniitemcode	int				set @aniitemcode	= -1
	declare @upcnt			int				set @upcnt			= 0
	declare @freshstem100	int				set @freshstem100	= 0
	declare @attstem100		int				set @attstem100		= 0
	declare @timestem100	int				set @timestem100	= 0
	declare @defstem100		int				set @defstem100		= 0
	declare @hpstem100		int				set @hpstem100		= 0
	declare @upgamecost		int				set @upgamecost 	= 0
	declare @upheart		int				set @upheart 		= 0
	declare @upstepmax		int				set @upstepmax 		= 16
	declare @cnt			int				set @cnt	 		= 0
	declare @usedgamecost	int				set @usedgamecost	= 0
	declare @usedheart		int				set @usedheart		= 0
	declare @tmpcnt			int				set @tmpcnt			= 0
	--declare @anifirstfullupreward	int		set @anifirstfullupreward	= 1


	declare @kind			int
	declare @info			int
	declare @plusfresh100	int
	declare @plusatt100		int
	declare @plusdef100		int
	declare @plushp100		int
	declare @plustime100	int

Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ.
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	set @comment  = '�˼� ���� ������ �߻��߽��ϴ�.'
	--select 'DEBUG 3-1 �Է°�', @gameid_ gameid_, @password_ password_, @listidxani_ listidxani_, @listset_ listset_, @randserial_ randserial_

	------------------------------------------------
	--	3-2. �������(��������, ��������, ������ ����)
	------------------------------------------------
	select
		@gameid 		= gameid,			@market			= @market,
		@cashcost		= cashcost,			@gamecost		= gamecost,			@heart			= heart,
		@feed			= feed,				@fpoint			= fpoint,			@goldticket 	= goldticket, 		@battleticket	= battleticket,
		--@anifirstfullupreward = anifirstfullupreward,
		@randserial		= randserial
	from dbo.tUserMaster where gameid = @gameid_ and password = @password_
	--select 'DEBUG 3-2 ��������', @gameid gameid, @cashcost cashcost, @gamecost gamecost, @heart heart, @randserial randserial

	-- ���� ����.
	select
		@aniitemcode	= itemcode,
		@upcnt			= upcnt,			@upstepmax	= upstepmax,
		@freshstem100	= freshstem100, 	@attstem100	= attstem100,
		@timestem100	= timestem100, 		@defstem100	= defstem100,	@hpstem100	 = hpstem100
	from dbo.tUserItem
	where gameid = @gameid_ and listidx = @listidxani_ and invenkind = @USERITEM_INVENKIND_ANI
	--select 'DEBUG 3-3 ��������.', @aniitemcode aniitemcode, @upcnt upcnt, @freshstem100 freshstem100, @attstem100 attstem100, @timestem100 timestem100, @defstem100 defstem100, @hpstem100 hpstem100

	-- ������ȭ ������ ����.
	select
		@upgamecost		= param16,
		@upheart		= param17
	from dbo.tItemInfo where itemcode = @aniitemcode and category = @ITEM_MAINCATEGORY_ANI
	--select 'DEBUG 3-4 ���׷��̵�����.', @upgamecost upgamecost, @upheart upheart

	-- �ٱ⼼����.
	select @cnt = count(*) FROM dbo.fnu_SplitTwo(';', ':', @listset_)
	--select 'DEBUG 3-5 �ٱ⼼����', @cnt cnt

	------------------------------------------------
	--	3-3. ����Ȳ���� �ڵ�� �з�
	------------------------------------------------
	if( @gameid = '' )
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR ���̵� �������� �ʴ´�.'
			--select 'DEBUG 4' + @comment
		END
	else if ( @randserial_ = @randserial )
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment = 'SUCCESS ��ȭ�߽��ϴ�(����)'
			--select 'DEBUG ' + @comment
		END
	else if ( @aniitemcode = -1 )
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_ITEMCODE
			set @comment = 'ERROR �ڵ带 ã���� �����ϴ�.(1)'
			--select 'DEBUG ' + @comment
		END
	else if ( @upcnt + @cnt > @upstepmax )
		BEGIN
			set @nResult_ = @RESULT_ERROR_UPGRADE_FULL
			set @comment = 'ERROR ���׷��̵尡 Ǯ�̴�.'
			--select 'DEBUG ' + @comment
		END
	else if (@heart < @upheart * @cnt)
		BEGIN
			set @nResult_ = @RESULT_ERROR_HEART_LACK
			set @comment = 'ERROR ��Ʈ�����մϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if (@gamecost < @upgamecost * @cnt)
		BEGIN
			set @nResult_ = @RESULT_ERROR_GAMECOST_LACK
			set @comment = 'ERROR ���κ����մϴ�.'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS ��ȭ�߽��ϴ�.'
			--select 'DEBUG ' + @comment

			------------------------------------------------------------------
			-- ��ȭ�������ֱ�.
			------------------------------------------------------------------
			-- 1. Ŀ�� ����
			declare curUpgradeInfo Cursor for
			select * FROM dbo.fnu_SplitTwo(';', ':', @listset_)

			-- 2. Ŀ������
			open curUpgradeInfo

			-- 3. Ŀ�� ���
			Fetch next from curUpgradeInfo into @kind, @info
			while @@Fetch_status = 0
				Begin
					--  > ���ٱ⼼�� ������ �о���� (��/��/Ÿ/����ġ) ����
					set @plusfresh100 	= 0
					set @plusatt100 	= 0
					set @plusdef100 	= 0
					set @plushp100 		= 0
					set @plustime100	= 0

					select
						@plusfresh100	= param1, 	@plusatt100		= param2,
						@plusdef100		= param3,	@plushp100		= param4,
						@plustime100	= param5
					from dbo.tItemInfo
					where itemcode = (select itemcode from dbo.tUserItem where gameid = @gameid_ and listidx = @info and invenkind = @USERITEM_INVENKIND_STEMCELL)
						  and subcategory = @ITEM_SUBCATEGORY_STEMCELL
					--select 'DEBUG �ٱ⼼��', @kind kind, @info info, @plusfresh100 plusfresh100, @plusatt100 plusatt100, @plusdef100 plusdef100, @plushp100 plushp100, @plustime100 plustime100

					set @freshstem100	= @freshstem100		+ @plusfresh100
					set @attstem100		= @attstem100		+ @plusatt100
					set @timestem100	= @timestem100		+ @plustime100
					set @defstem100		= @defstem100		+ @plusdef100
					set @hpstem100		= @hpstem100		+ @plushp100

					--  > ��Ʈ, ���� ����
					set @tmpcnt		= @tmpcnt + 1
					set @upcnt		= @upcnt + 1
					set @heart 		= @heart 	- @upheart
					set @gamecost 	= @gamecost - @upgamecost

					set @usedheart	= @usedheart + @upheart
					set @usedgamecost= @usedgamecost + @upgamecost

					--> ����� �ٱ⼼���� ����
					-- ���� �ϰ� ���.
					-- exec spu_DeleteUserItemBackup 3, @gameid_, @listidxs
					delete from dbo.tUserItem where gameid = @gameid_ and listidx = @info and invenkind = @USERITEM_INVENKIND_STEMCELL

					Fetch next from curUpgradeInfo into @kind, @info
				end
			-- 4. Ŀ���ݱ�
			close curUpgradeInfo
			Deallocate curUpgradeInfo
			--select 'DEBUG ��������', @upcnt upcnt, @freshstem100 freshstem100, @attstem100 attstem100, @timestem100 timestem100, @defstem100 defstem100, @hpstem100 hpstem100, @heart heart, @gamecost gamecost, @cashcost cashcost

			update dbo.tUserItem
				set
					upcnt			= @upcnt,
					usedheart		= usedheart + @usedheart,
					usedgamecost	= usedgamecost + @usedgamecost,
					freshstem100	= @freshstem100,	attstem100		= @attstem100,
					timestem100		= @timestem100,		defstem100		= @defstem100,		hpstem100		= @hpstem100
			where gameid = @gameid_ and listidx = @listidxani_ and invenkind = @USERITEM_INVENKIND_ANI

			--------------------------------
			-- ������ȭȽ��.
			--------------------------------
			exec spu_DayLogInfoStatic @market, 64, @tmpcnt				-- ��      ��ȭ.

			----------------------------------
			---- ������ȭȽ�� > ��� : 100.
			----------------------------------
			--if( @anifirstfullupreward = 0 and @upcnt >= 8 and @upcnt = @upstepmax )
			--	begin
			--		--select 'DEBUG ���� Ǯ�� ��������'
			--		exec spu_SubGiftSendNew 2,  5000, 100, '���� Ǯ�� ����', @gameid_, ''				-- ĳ������
			--		set @anifirstfullupreward = @anifirstfullupreward + 1
			--	end

			--------------------------------
			-- ��ϸ�ŷ
			--------------------------------
			--exec spu_UserItemBuyLogNew @gameid_, @itemcode_, @upgamecost, @needcashcost, 0
			exec spu_UserItemUpgradeLog @aniitemcode, 0, @usedgamecost, @usedheart


			-- �������� ���� �־���
			update dbo.tUserMaster
				set
					cashcost	= @cashcost,
					gamecost	= @gamecost,
					heart		= @heart,
					bkaniupcnt	= bkaniupcnt + @tmpcnt,
					bganiupcnt	= bganiupcnt + @tmpcnt,
					--anifirstfullupreward= @anifirstfullupreward,
					randserial	= @randserial_
			where gameid = @gameid_

		END



	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost, @heart heart, @feed feed, @fpoint fpoint, @goldticket goldticket, @battleticket battleticket
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			--------------------------------------------------------------
			-- ���� ���� ������ ���� > ���� ȹ���� �͸� ����(������ �ϰ� ���� ������ Ŭ����� �����͸� �������� ������)
			--------------------------------------------------------------
			select * from dbo.tUserItem
			where gameid = @gameid_ and listidx = @listidxani_
		end
	set nocount off
End

