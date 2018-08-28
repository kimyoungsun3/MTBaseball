---------------------------------------------------------------
/*
-- �ϹݼҸ� ����(����)
--exec spu_ItemBuy 'guest90289', '0426468u1h0p8t484847', 5201, -1, -1, -1, 7784, -1	-- �Ϲݱ���Ƽ��
--exec spu_ItemBuy 'guest90289', '0426468u1h0p8t484847', 5300, -1, -1, -1, 7785, -1	-- ��ȸƼ��B
--exec spu_ItemBuy 'guest90289', '0426468u1h0p8t484847', 2200, -1, -1, -1, 7786, -1	-- ����100���θ���
--exec spu_ItemBuy 'guest90289', '0426468u1h0p8t484847', 2100, -1, -1, -1, 7787, -1	-- ��޿�ûƼ��
--exec spu_ItemBuy 'guest90289', '0426468u1h0p8t484847', 1401, -1, -1, -1, 7775, -1	-- �Ǽ�(�Ӹ�)

-- ���� �Ǹ�.
exec spu_ItemSell 'guest90289', '0426468u1h0p8t484847', 1, 1, -1	-- ��(�κ� -1)
exec spu_ItemSell 'xxxx2', '049000s1i0n7t8445289', 1, 1, -1	-- ��(�κ� -1)

-- �Ҹ�.
exec spu_ItemSell 'guest90289', '0426468u1h0p8t484847', 7, 1, -1	-- �Ѿ�
exec spu_ItemSell 'guest90289', '0426468u1h0p8t484847', 8, 1, -1	-- ���
exec spu_ItemSell 'guest90289', '0426468u1h0p8t484847', 9, 1, -1	-- �ϲ�
exec spu_ItemSell 'guest90289', '0426468u1h0p8t484847', 10, 1, -1	-- ������


exec spu_ItemSell 'guest90289', '0426468u1h0p8t484847', 11, 1, -1	-- ��Ȱ��
exec spu_ItemSell 'guest90289', '0426468u1h0p8t484847', 12, 1, -1	-- �Ϲݱ���Ƽ��
exec spu_ItemSell 'guest90289', '0426468u1h0p8t484847', 13, 1, -1	-- ��ȸƼ��B
exec spu_ItemSell 'guest90289', '0426468u1h0p8t484847', 14, 1, -1	-- ����100���θ���
exec spu_ItemSell 'guest90289', '0426468u1h0p8t484847', 15, 1, -1	-- ��޿�ûƼ��
exec spu_ItemSell 'guest90289', '0426468u1h0p8t484847', 16, 1, -1	-- �Ǽ�(�Ӹ�)
exec spu_ItemSell 'xxxx2', '049000s1i0n7t8445289', 71, 1, -1	-- ����
*/
use Game4Farmvill5
GO

IF OBJECT_ID ( 'dbo.spu_ItemSell', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_ItemSell;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_ItemSell
	@gameid_				varchar(20),
	@password_				varchar(20),
	@listidx_				int,
	@sellcnt_				int,
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
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--�ش������� ã�� ����

	-- ���� �ڵ尪
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- �������ڵ��ã��

	-- ��Ÿ����
	declare @RESULT_ERROR_ITEMCOST_WRONG		int				set @RESULT_ERROR_ITEMCOST_WRONG		= -113			-- ������ ������ �̻���.
	declare @RESULT_ERROR_NOT_ENOUGH			int				set @RESULT_ERROR_NOT_ENOUGH			= -115			-- �����ΰ� ������� ����.

	------------------------------------------------
	--	2-2. ���ǵȰ�
	------------------------------------------------
	-- �����ۺ� �κ��з�
	declare @USERITEM_INVENKIND_ANI				int 				set @USERITEM_INVENKIND_ANI					= 1
	declare @USERITEM_INVENKIND_CONSUME			int 				set @USERITEM_INVENKIND_CONSUME				= 3
	declare @USERITEM_INVENKIND_ACC				int 				set @USERITEM_INVENKIND_ACC					= 4
	--declare @USERITEM_INVENKIND_DIRECT		int 				set @USERITEM_INVENKIND_DIRECT				= 40
	--declare @USERITEM_INVENKIND_INFO			int 				set @USERITEM_INVENKIND_INFO				= 60
	--declare @USERITEM_INVENKIND_PET			int 				set @USERITEM_INVENKIND_PET					= 1000
	declare @USERITEM_INVENKIND_STEMCELL		int 				set @USERITEM_INVENKIND_STEMCELL			= 1040
	declare @USERITEM_INVENKIND_TREASURE		int 				set @USERITEM_INVENKIND_TREASURE			= 1200

	-- ��������.
	-- �ʵ嵿�� 0 ~ 8.
	declare @USERITEM_FIELDIDX_INVEN			int					set @USERITEM_FIELDIDX_INVEN					= -1	-- â��.
	declare @USERITEM_FIELDIDX_HOSPITAL			int					set @USERITEM_FIELDIDX_HOSPITAL					= -2	-- ����.

	-- �Ҹ��� > �����Կ� ������ġ.
	declare @USERMASTER_QUICKKIND_NON			int					set @USERMASTER_QUICKKIND_NON				= -1 --����.
	declare @USERMASTER_QUICKKIND_SETTING		int					set @USERMASTER_QUICKKIND_SETTING			=  1 --�Ѿ�, ���, ����, �˹�.

	-- ������ �Ϲ�����.
	declare @CONSUME_MAX_COUNT					int					set @CONSUME_MAX_COUNT						= 999

	------------------------------------------------
	--	2-3. ���λ�� ����
	------------------------------------------------
	declare @comment		varchar(80)
	declare @gameid			varchar(20)		set @gameid		= ''
	declare @cashcost		int				set @cashcost 	= 0
	declare @gamecost		int				set @gamecost 	= 0
	declare @heart			int				set @heart 		= 0
	declare @feed			int				set @feed 		= 0
	declare @fpoint			int				set @fpoint		= 0
	declare @goldticket		int				set @goldticket	= 0
	declare @battleticket	int				set @battleticket= 0

	declare @invenkind		int				set @invenkind		= -1
	declare @itemcode 		int				set @itemcode 		= -444
	declare @cnt 			int				set @cnt			= 0
	declare @fieldidx 		int
	declare @sellcost		int				set @sellcost		= 0
	declare @anireplistidx	int				set @anireplistidx	= 1
	declare @acc1			int				set @acc1			= -1
	declare @acc2			int				set @acc2			= -1

	declare @dummy	 		int
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	set @comment  = '�˼� ���� ������ �߻��߽��ϴ�.'
	--select 'DEBUG 3-1-1 �Է°�', @gameid_ gameid_, @password_ password_, @listidx_ listidx_, @sellcnt_ sellcnt_

	------------------------------------------------
	--	3-2. �������(��������, ��������, ������ ����)
	------------------------------------------------
	select
		@gameid 		= gameid,
		@cashcost 		= cashcost,
		@gamecost		= gamecost,
		@heart			= heart,
		@feed			= feed,
		@fpoint			= fpoint,			@goldticket 	= goldticket, 		@battleticket	= battleticket,
		@anireplistidx	= anireplistidx
	from dbo.tUserMaster where gameid = @gameid_ and password = @password_
	--select 'DEBUG 3-2-1 ��������', @gameid gameid, @cashcost cashcost, @gamecost gamecost

	select
		@invenkind	= invenkind,
		@itemcode	= itemcode,
		@acc1		= acc1,
		@acc2		= acc2,
		@cnt		= cnt,
		@fieldidx 	= fieldidx
	from dbo.tUserItem where gameid = @gameid_ and listidx = @listidx_
	--select 'DEBUG 3-2-2 ������', @listidx_ listidx_, @invenkind invenkind, @itemcode itemcode, @cnt cnt, @fieldidx fieldidx

	if(@itemcode != -1 or @acc1 != -1 or @acc2 != -1)
		begin
			select @sellcost = sum(sellcost) from dbo.tItemInfo where itemcode in (@itemcode, @acc1, @acc2)
		end


	------------------------------------------------
	--	3-3. ����Ȳ���� �ڵ�� �з�
	------------------------------------------------
	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR ���̵� �������� �ʴ´�.'
			--select 'DEBUG ' + @comment
		END
	else if (@itemcode = -444)
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_ITEMCODE
			set @comment = 'ERROR �������� ã�� �� �����ϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if (@sellcost < 0)
		BEGIN
			-- 0��¥�� ��ǰ.
			set @nResult_ = @RESULT_ERROR_ITEMCOST_WRONG
			set @comment = 'ERROR �Ǹ� �ܰ��� �̻��մϴ�..'
			--select 'DEBUG ' + @comment
		END
	else if (@invenkind = @USERITEM_INVENKIND_ANI and @fieldidx = @USERITEM_FIELDIDX_HOSPITAL)
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_ITEMCODE
			set @comment = 'ERROR �������� ã�� �� �����ϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if (@invenkind = @USERITEM_INVENKIND_CONSUME and @sellcnt_ > @cnt)
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_ENOUGH
			set @comment = 'ERROR �Ǹ� ������ �ʰ��ߴ�.'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS ���� �Ǹ� ó���մϴ�.'

			if(@invenkind = @USERITEM_INVENKIND_ANI)
				begin
					--------------------------------------------------------------
					-- ���� ������ > �Ǹ�(����), �ǸŰ�(+).
					--------------------------------------------------------------
					--select 'DEBUG 4-3 ���� �Ǹ�(��)', @gamecost gamecost, @sellcost sellcost
					-- delete from dbo.tUserItem where gameid = @gameid_ and listidx = @listidx_
					exec spu_DeleteUserItemBackup 1, @gameid_, @listidx_

					-----------------------------------------
					-- ��ǥ���� ������ �⺻������ ����
					-----------------------------------------
					if(@anireplistidx = @listidx_)
						begin
							update dbo.tUserMaster
								set
									anirepitemcode 	=  1,
									anirepacc1	 	= -1,
									anirepacc2 		= -1
							where gameid = @gameid_
						end

					set @gamecost = @gamecost + @sellcost
					--select 'DEBUG 4-3 ���� �Ǹ�(��)', @gamecost gamecost, @sellcost sellcost
				end
			else if(@invenkind = @USERITEM_INVENKIND_CONSUME)
				begin
					--------------------------------------------------------------
					-- �Ҹ� ������ > �Ǹ�(�谨 > 0 ���ϴ� �α��ζ� ������), �ǸŰ�(+).
					--------------------------------------------------------------
					--select 'DEBUG 4-4 �Ҹ� �Ǹ�(��)', @gamecost gamecost, @sellcost sellcost, @sellcnt_ sellcnt_
					update dbo.tUserItem
						set
							cnt = cnt - @sellcnt_
					where gameid = @gameid_ and listidx = @listidx_

					set @gamecost = @gamecost + @sellcost * @sellcnt_
					--select 'DEBUG 4-4 �Ҹ� �Ǹ�(��)', @gamecost gamecost, @sellcost sellcost, @sellcnt_ sellcnt_
				end
			else if(@invenkind in ( @USERITEM_INVENKIND_ACC, @USERITEM_INVENKIND_STEMCELL ))
				begin
					--------------------------------------------------------------
					-- �Ǽ� ������ > �Ǹ�(����), �ǸŰ�(+).
					--------------------------------------------------------------
					--select 'DEBUG 4-5 �Ǽ� �Ǹ�(��)', @gamecost gamecost, @sellcost sellcost
					-- delete from dbo.tUserItem where gameid = @gameid_ and listidx = @listidx_
					exec spu_DeleteUserItemBackup 1, @gameid_, @listidx_

					set @gamecost = @gamecost + @sellcost

					--select 'DEBUG 4-5 �Ǽ� �Ǹ�(��)', @gamecost gamecost, @sellcost sellcost
				end
			else if(@invenkind in ( @USERITEM_INVENKIND_TREASURE ))
				begin
					--------------------------------------------------------------
					-- �Ǽ� ������ > �Ǹ�(����), �ǸŰ�(+).
					--------------------------------------------------------------
					exec spu_DeleteUserItemBackup 1, @gameid_, @listidx_

					set @gamecost = @gamecost + @sellcost

					---------------------------------
					-- ���� ����ȿ�� ����.
					---------------------------------
					exec spu_TSRetentionEffect @gameid_, @itemcode
				end
			else
				begin
					--------------------------------------------------------------
					-- ��Ÿ	-> �Ǹ� ����.
					--------------------------------------------------------------
					--select 'DEBUG 4-7 ����ǥ�ÿ�'

					set @dummy = 0
				end
		END

	--------------------------------------------------------------
	-- �ڵ�(ĳ��, ����, ��Ʈ, ����)
	--------------------------------------------------------------
	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost, @heart heart, @feed feed, @fpoint fpoint, @goldticket goldticket, @battleticket battleticket
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			-- �������� ���� �־���
			update dbo.tUserMaster
				set
					gamecost	= @gamecost
			where gameid = @gameid_

			--------------------------------------------------------------
			-- ���� ���� ������ ����
			--------------------------------------------------------------
			select * from dbo.tUserItem
			where gameid = @gameid_ and listidx = @listidx_
		end

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off
End

