---------------------------------------------------------------
/*
-- ���� �Ǹ�.
exec spu_ItemSellListSet 'xxxx2', '049000s1i0n7t8445289', '1:65;2:69;', -1	-- ��(�κ� -1)
exec spu_ItemSellListSet 'xxxx2', '049000s1i0n7t8445289', '1:5;2:7;', -1	-- �Ѿ�
exec spu_ItemSellListSet 'xxxx2', '049000s1i0n7t8445289', '1:42;2:45;', -1	-- �ٱ⼼��.
exec spu_ItemSellListSet 'xxxx2', '049000s1i0n7t8445289', '', -1
*/
use Game4Farmvill5
GO

IF OBJECT_ID ( 'dbo.spu_ItemSellListSet', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_ItemSellListSet;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_ItemSellListSet
	@gameid_								varchar(20),
	@password_								varchar(20),
	@listset_								varchar(256),
	@nResult_								int					OUTPUT
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

	-- ��Ÿ����
	declare @RESULT_ERROR_PARAMETER				int				set @RESULT_ERROR_PARAMETER				= -122			-- �Ķ���Ϳ���.


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
	declare @anireplistidx	int				set @anireplistidx	= 1

	declare @kind			int
	declare @info			int
	declare @totalsellcost	int				set @totalsellcost	= 0
	declare @sellcost		int				set @sellcost		= 0
	declare @cnt 			int				set @cnt			= 0
	declare @itemcode 		int				set @itemcode 		= -1
	declare @loop			int				set @loop			= 0

Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	set @comment  = '�˼� ���� ������ �߻��߽��ϴ�.'
	--select 'DEBUG 3-1-1 �Է°�', @gameid_ gameid_, @password_ password_, @listset_ listset_

	------------------------------------------------
	--	3-2. �������(��������, ��������, ������ ����)
	------------------------------------------------
	select
		@gameid 		= gameid,
		@cashcost 		= cashcost,			@gamecost		= gamecost,			@heart			= heart,			@feed			= feed,
		@fpoint			= fpoint,			@goldticket 	= goldticket, 		@battleticket	= battleticket,
		@anireplistidx	= anireplistidx
	from dbo.tUserMaster where gameid = @gameid_ and password = @password_
	--select 'DEBUG 3-2-1 ��������', @gameid gameid, @cashcost cashcost, @gamecost gamecost

	------------------------------------------------
	--	3-3. ����Ȳ���� �ڵ�� �з�
	------------------------------------------------
	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR ���̵� �������� �ʴ´�.'
			--select 'DEBUG ' + @comment
		END
	else if( LEN(@listset_) < 4 )
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_PARAMETER
			set @comment 	= 'ERROR �Ķ���� �����Դϴ�.'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS ���� �Ǹ� ó���մϴ�.'

			------------------------------------------------------------------
			-- ��������.
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
					set @itemcode 		= -1
					set @sellcost		= 0
					set @cnt			= 0

					select @itemcode = itemcode, @cnt = cnt from dbo.tUserItem where gameid = @gameid_ and listidx = @info
					select @sellcost = sellcost from dbo.tItemInfo where itemcode = @itemcode
					--select 'DEBUG ', @itemcode itemcode, @cnt cnt, @sellcost sellcost

					if( @itemcode != -1 )
						begin
							exec spu_DeleteUserItemBackup 1, @gameid_, @info

							if(@anireplistidx = @info)
								begin
									set @anireplistidx = -444
								end

							set @totalsellcost = @totalsellcost + @sellcost * @cnt
							--select 'DEBUG ', @loop loop, @totalsellcost totalsellcost, @cnt cnt, @sellcost sellcost
						end

					set @loop = @loop + 1
					Fetch next from curUpgradeInfo into @kind, @info
				end
			-- 4. Ŀ���ݱ�
			close curUpgradeInfo
			Deallocate curUpgradeInfo


			set @gamecost = @gamecost + @totalsellcost
		END

	--------------------------------------------------------------
	-- �ڵ�(ĳ��, ����, ��Ʈ, ����)
	--------------------------------------------------------------
	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost, @heart heart, @feed feed, @fpoint fpoint, @goldticket goldticket, @battleticket battleticket
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			--------------------------------------------------------------
			-- �������� ���� �־���
			--------------------------------------------------------------
			update dbo.tUserMaster
				set
					gamecost		= @gamecost,
					anirepitemcode 	= case when (@anireplistidx = -444) then  1 else anirepitemcode end,
					anirepacc1	 	= case when (@anireplistidx = -444) then -1 else anirepacc1 end,
					anirepacc2 		= case when (@anireplistidx = -444) then -1 else anirepacc1 end
			where gameid = @gameid_
		end

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off
End

