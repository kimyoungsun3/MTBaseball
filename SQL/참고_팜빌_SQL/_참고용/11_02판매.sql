---------------------------------------------------------------
/*
-- �ϹݼҸ� ����(����)
--exec spu_FVItemBuy 'guest90289', '0426468u1h0p8t484847', 5201, -1, -1, -1, 7784, -1	-- �Ϲݱ���Ƽ��
--exec spu_FVItemBuy 'guest90289', '0426468u1h0p8t484847', 5300, -1, -1, -1, 7785, -1	-- ��ȸƼ��B
--exec spu_FVItemBuy 'guest90289', '0426468u1h0p8t484847', 2200, -1, -1, -1, 7786, -1	-- ����100���θ���
--exec spu_FVItemBuy 'guest90289', '0426468u1h0p8t484847', 2100, -1, -1, -1, 7787, -1	-- ��޿�ûƼ��
--exec spu_FVItemBuy 'guest90289', '0426468u1h0p8t484847', 1401, -1, -1, -1, 7775, -1	-- �Ǽ�(�Ӹ�)

-- ���� �Ǹ�.
exec spu_FVItemSell 'guest90289', '0426468u1h0p8t484847', 1, 1, -1	-- ��(�κ� -1)
exec spu_FVItemSell 'xxxx2', '049000s1i0n7t8445289', 1, 1, -1	-- ��(�κ� -1)

-- �Ҹ�.
exec spu_FVItemSell 'guest90289', '0426468u1h0p8t484847', 7, 1, -1	-- �Ѿ�
exec spu_FVItemSell 'guest90289', '0426468u1h0p8t484847', 8, 1, -1	-- ġ����
exec spu_FVItemSell 'guest90289', '0426468u1h0p8t484847', 9, 1, -1	-- �ϲ�
exec spu_FVItemSell 'guest90289', '0426468u1h0p8t484847', 10, 1, -1	-- ������


exec spu_FVItemSell 'guest90289', '0426468u1h0p8t484847', 11, 1, -1	-- ��Ȱ��
exec spu_FVItemSell 'guest90289', '0426468u1h0p8t484847', 12, 1, -1	-- �Ϲݱ���Ƽ��
exec spu_FVItemSell 'guest90289', '0426468u1h0p8t484847', 13, 1, -1	-- ��ȸƼ��B
exec spu_FVItemSell 'guest90289', '0426468u1h0p8t484847', 14, 1, -1	-- ����100���θ���
exec spu_FVItemSell 'guest90289', '0426468u1h0p8t484847', 15, 1, -1	-- ��޿�ûƼ��

-- �Ǽ�.
exec spu_FVItemSell 'guest90289', '0426468u1h0p8t484847', 16, 1, -1	-- �Ǽ�(�Ӹ�)
*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVItemSell', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVItemSell;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_FVItemSell
	@gameid_				varchar(60),
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
	declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--������ > �˾�ó���� ��Ʈ�η� ��������.
	declare @RESULT_ERROR_DELETED_USER 			int				set @RESULT_ERROR_DELETED_USER			= -12			--�������� > �˾�ó���� ��Ʈ�η� ��������.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--�ش������� ã�� ����
	declare @RESULT_ERROR_NOT_FOUND_PASSWORD	int				set @RESULT_ERROR_NOT_FOUND_PASSWORD	= -17
	declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--������ �����ϰ� �ִ�.
	declare @RESULT_NEWVERION_CLIENT_DOWNLOAD 	int				set @RESULT_NEWVERION_CLIENT_DOWNLOAD	= -15			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ��ũó��.
	declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ����.

	-- �����߿� ����.
	declare @RESULT_ERROR_HEART_LACK			int				set @RESULT_ERROR_HEART_LACK			= -20			--��Ʈ�� �����ϴ�.
	declare @RESULT_ERROR_GAMECOST_LACK			int				set @RESULT_ERROR_GAMECOST_LACK			= -21			--�ǹ��� �����ϴ�.
	declare @RESULT_ERROR_CASHCOST_LACK			int				set @RESULT_ERROR_CASHCOST_LACK			= -22			--��尡 �����ϴ�.
	declare @RESULT_ERROR_ITEM_LACK				int				set @RESULT_ERROR_ITEM_LACK				= -23			--�������̺����ϴ�.

	-- ���� �ڵ尪
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- �������ڵ��ã��
	declare @RESULT_ERROR_GIFTITEM_NOT_FOUND	int				set @RESULT_ERROR_GIFTITEM_NOT_FOUND	= -51			-- ������������ ��ã��
	declare @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	int				set @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	= -52			-- ������ �̹� ������
	declare @RESULT_ERROR_NOT_FOUND_GIFTID		int				set @RESULT_ERROR_NOT_FOUND_GIFTID		= -75			-- ĳ�� > ������ ���̵� ��ã��

	-- ��Ÿ����
	declare @RESULT_ERROR_RESULT_COPY			int				set @RESULT_ERROR_RESULT_COPY			= -53			-- ���ī�ǽõ�
	declare @RESULT_ERROR_GAMECOST_COPY			int				set @RESULT_ERROR_GAMECOST_COPY			= -54			-- �ǹ�ī�ǽõ�
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- ���������ʴ¸��
	declare @RESULT_ERROR_HEART_FULL			int				set @RESULT_ERROR_HEART_FULL			= -71			-- ���������ʴ¸��
	declare @RESULT_ERROR_TUTORIAL_ALREADY		int				set @RESULT_ERROR_TUTORIAL_ALREADY		= -73			-- ���丮�� �̹� ����.
	declare @RESULT_ERROR_NOT_FOUND_OTHERID		int				set @RESULT_ERROR_NOT_FOUND_OTHERID		= -83
	declare @RESULT_ERROR_INVEN_FULL			int				set @RESULT_ERROR_INVEN_FULL			= -101			-- �κ�����
	declare @RESULT_ERROR_NOT_MATCH				int				set @RESULT_ERROR_NOT_MATCH				= -110			-- �����ΰ� ��ġ�� �ȵǾ���.
	declare @RESULT_ERROR_DOUBLE_RANDSERIAL		int				set @RESULT_ERROR_DOUBLE_RANDSERIAL		= -111			-- �����ø��� �ߺ�.
	declare @RESULT_ERROR_MAXCOUNT				int				set @RESULT_ERROR_MAXCOUNT				= -112			-- �ƽ�ī����.
	declare @RESULT_ERROR_ITEMCOST_WRONG		int				set @RESULT_ERROR_ITEMCOST_WRONG		= -113			-- ������ ������ �̻���.
	declare @RESULT_ERROR_LISTIDX_NOT_FOUND		int				set @RESULT_ERROR_LISTIDX_NOT_FOUND		= -114			-- ����Ʈ ��ȣ�� ��ã��.
	declare @RESULT_ERROR_NOT_ENOUGH			int				set @RESULT_ERROR_NOT_ENOUGH			= -115			-- �����ΰ� ������� ����.

	------------------------------------------------
	--	2-2. ���ǵȰ�
	------------------------------------------------
	-- �����ۺ� �κ��з�
	declare @USERITEM_INVENKIND_ANI				int 				set @USERITEM_INVENKIND_ANI					= 1
	declare @USERITEM_INVENKIND_CONSUME			int 				set @USERITEM_INVENKIND_CONSUME				= 3
	declare @USERITEM_INVENKIND_ACC				int 				set @USERITEM_INVENKIND_ACC					= 4
	declare @USERITEM_INVENKIND_DIRECT			int 				set @USERITEM_INVENKIND_DIRECT				= 40
	declare @USERITEM_INVENKIND_INFO			int 				set @USERITEM_INVENKIND_INFO				= 60
	declare @USERITEM_INVENKIND_PET				int 				set @USERITEM_INVENKIND_PET					= 1000

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
	declare @gameid			varchar(60)		set @gameid		= ''
	declare @cashcost		int				set @cashcost 	= 0
	declare @gamecost		int				set @gamecost 	= 0
	declare @heart			int				set @heart 		= 0
	declare @feed			int				set @feed 		= 0

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
		@anireplistidx	= anireplistidx
	from dbo.tFVUserMaster where gameid = @gameid_ and password = @password_
	--select 'DEBUG 3-2-1 ��������', @gameid gameid, @cashcost cashcost, @gamecost gamecost

	select
		@invenkind	= invenkind,
		@itemcode	= itemcode,
		@acc1		= acc1,
		@acc2		= acc2,
		@cnt		= cnt,
		@fieldidx 	= fieldidx
	from dbo.tFVUserItem where gameid = @gameid_ and listidx = @listidx_
	--select 'DEBUG 3-2-2 ������', @listidx_ listidx_, @invenkind invenkind, @itemcode itemcode, @cnt cnt, @fieldidx fieldidx

	if(@itemcode != -1 or @acc1 != -1 or @acc2 != -1)
		begin
			select @sellcost = sum(sellcost) from dbo.tFVItemInfo where itemcode in (@itemcode, @acc1, @acc2)
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
					-- delete from dbo.tFVUserItem where gameid = @gameid_ and listidx = @listidx_
					exec spu_FVDeleteUserItemBackup 1, @gameid_, @listidx_

					-----------------------------------------
					-- ��ǥ���� ������ �⺻������ ����
					-----------------------------------------
					if(@anireplistidx = @listidx_)
						begin
							update dbo.tFVUserMaster
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
					update dbo.tFVUserItem
						set
							cnt = cnt - @sellcnt_
					where gameid = @gameid_ and listidx = @listidx_

					set @gamecost = @gamecost + @sellcost * @sellcnt_
					--select 'DEBUG 4-4 �Ҹ� �Ǹ�(��)', @gamecost gamecost, @sellcost sellcost, @sellcnt_ sellcnt_
				end
			else if(@invenkind = @USERITEM_INVENKIND_ACC)
				begin
					--------------------------------------------------------------
					-- �Ǽ� ������ > �Ǹ�(����), �ǸŰ�(+).
					--------------------------------------------------------------
					--select 'DEBUG 4-5 �Ǽ� �Ǹ�(��)', @gamecost gamecost, @sellcost sellcost
					-- delete from dbo.tFVUserItem where gameid = @gameid_ and listidx = @listidx_
					exec spu_FVDeleteUserItemBackup 1, @gameid_, @listidx_

					set @gamecost = @gamecost + @sellcost

					--select 'DEBUG 4-5 �Ǽ� �Ǹ�(��)', @gamecost gamecost, @sellcost sellcost
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

	if(@nResult_ = @RESULT_SUCCESS)
		begin
			-- �������� ���� �־���
			update dbo.tFVUserMaster
			set
				gamecost	= @gamecost
			where gameid = @gameid_

			--------------------------------------------------------------
			-- �ڵ�(ĳ��, ����, ��Ʈ, ����)
			--------------------------------------------------------------
			select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost, @heart heart, @feed feed

			--------------------------------------------------------------
			-- ���� ���� ������ ����
			--------------------------------------------------------------
			select * from dbo.tFVUserItem
			where gameid = @gameid_ and listidx = @listidx_
		end
	else
		begin
			select @nResult_ rtn, @comment comment, @gamecost gamecost, @cashcost cashcost, @heart heart, @feed feed
		end

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off
End

