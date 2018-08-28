/*
-- ������� �ϱ�.
-- update dbo.tUserMaster set cashcost = 100 where gameid = 'xxxx2'
-- update dbo.tUserMaster set bgcomposewt = DATEADD(ss, 350, getdate()) where gameid = 'xxxx2'
exec spu_AniComposeInit 'xxxx2', '049000s1i0n7t8445289', -1

-- �ռ� �ð��� �޾Ƽ� ó���ϱ�.
-- update dbo.tUserMaster set cashcost = 0 where gameid = 'xxxx2'
exec spu_AniComposeInit 'xxxx2', '049000s1i0n7t8445289', -1
*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_AniComposeInit', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_AniComposeInit;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_AniComposeInit
	@gameid_				varchar(20),
	@password_				varchar(20),
	@nResult_				int					OUTPUT
	WITH ENCRYPTION
as
	------------------------------------------------
	--	2-1. �ڵ尪
	------------------------------------------------
	-- �Ϲݰ�
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	-- �α��� ����.
	declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--������ > �˾�ó���� ��Ʈ�η� ��������.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--�ش������� ã�� ����

	-- �����߿� ����.
	declare @RESULT_ERROR_CASHCOST_LACK			int				set @RESULT_ERROR_CASHCOST_LACK			= -22			--��尡 �����ϴ�.

	-- ��Ÿ����
	declare @RESULT_ERROR_TIME_REMAIN			int				set @RESULT_ERROR_TIME_REMAIN			= -123			-- ���� �ð��� ����.

	------------------------------------------------
	--	2-2. ���ǵȰ�
	------------------------------------------------
	-- ��ϰ�
	declare @COMPOSE_INIT_ITEMCODE 				int				set @COMPOSE_INIT_ITEMCODE				= 50002			-- �ռ� �ʱ�ȭ��.

	-- �׷�.
	declare @ITEM_COMPOSE_TIME_MOTHER			int				set @ITEM_COMPOSE_TIME_MOTHER			= 1600	-- �ռ��ð� 1�ð��ʱ�ȭ.

	------------------------------------------------
	--	2-3. ���λ�� ����
	------------------------------------------------
	declare @comment		varchar(80)
	declare @gameid			varchar(20)		set @gameid			= ''		-- ��������.
	declare @cashcost		int				set @cashcost 		= 0
	declare @gamecost		int				set @gamecost 		= 0
	declare @heart			int				set @heart 			= 0
	declare @feed			int				set @feed 			= 0
	declare @bgcomposewt	datetime		set @bgcomposewt	= getdate()
	declare @bgcomposecc	int				set @bgcomposecc	= 0

	declare @listidx		int				set @listidx		= -1
	declare @cnt			int				set @cnt			= 0
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ.
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	set @comment  = '�˼� ���� ������ �߻��߽��ϴ�.'
	--select 'DEBUG 3-1 �Է°�', @gameid_ gameid_, @password_ password_

	------------------------------------------------
	--	3-2. �������(��������, ��������, ������ ����)
	------------------------------------------------
	select
		@gameid 		= gameid,
		@cashcost		= cashcost,
		@gamecost		= gamecost,
		@heart			= heart,
		@feed			= feed,
		@bgcomposewt	= bgcomposewt,
		@bgcomposecc 	= bgcomposecc
	from dbo.tUserMaster where gameid = @gameid_ and password = @password_
	--select 'DEBUG 3-2 ��������', @gameid gameid, @cashcost cashcost, @gamecost gamecost, @heart heart, @bgcomposewt bgcomposewt, @bgcomposecc bgcomposecc

	-- �ð� �ʱ�ȭ�� ��������
	select
		@listidx	= listidx,
		@cnt 		= cnt
	from dbo.tUserItem
	where gameid = @gameid_ and itemcode = @ITEM_COMPOSE_TIME_MOTHER
	--select 'DEBUG ���� �ð��ʱ�ȭ', @listidx listidx, @cnt cnt

	------------------------------------------------
	--	3-3. ����Ȳ���� �ڵ�� �з�
	------------------------------------------------
	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR ���̵� �������� �ʴ´�.'
			--select 'DEBUG 4' + @comment
		END
	else if (@bgcomposecc = 0)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'SUCCESS �ʱ�ȭ �մϴ�.(�̹��ߴ�)'
			--select 'DEBUG ' + @comment
		END
	else if (@cnt <= 0 and @cashcost < @bgcomposecc)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_CASHCOST_LACK
			set @comment 	= 'ERROR ĳ���� �����մϴ�.'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'SUCCESS �ð��� �ʱ�ȭ �߽��ϴ�.'
			--select 'DEBUG ' + @comment

			if (@cnt > 0)
				BEGIN
					------------------------------------------------
					-- �ռ� �ΰ� ���.
					------------------------------------------------

					------------------------------------------------
					-- �ռ� �ð� ����.
					------------------------------------------------
					set @bgcomposewt = DATEADD(hh, -1, @bgcomposewt)
					if(getdate() >= @bgcomposewt)
						begin
							set @bgcomposecc = 0
						end
					else
						begin
							set @bgcomposecc = @bgcomposecc
						end

					------------------------------------------------
					-- ���� ����.
					------------------------------------------------
					update dbo.tUserItem
						set
							cnt	= cnt - 1
					where gameid = @gameid_ and itemcode = @ITEM_COMPOSE_TIME_MOTHER
				END
			else
				BEGIN
					set @nResult_ = @RESULT_SUCCESS
					set @comment = 'SUCCESS �ʱ�ȭ �մϴ�.'
					--select 'DEBUG ' + @comment

					------------------------------------------------
					-- �ռ� �ΰ� ���.
					------------------------------------------------
					exec spu_UserItemBuyLogNew @gameid_, @COMPOSE_INIT_ITEMCODE, 0, @bgcomposecc, 0

					------------------------------------------------
					-- �ռ� �ð� ����.
					------------------------------------------------
					set @bgcomposewt 	= getdate()
					set @cashcost 		= @cashcost - @bgcomposecc
					set @bgcomposecc	= 0
				END
		END

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost, @heart heart, @feed feed, @bgcomposewt bgcomposewt, @bgcomposecc bgcomposecc

	if(@nResult_ = @RESULT_SUCCESS)
		begin
			-- �������� ���� �־���
			update dbo.tUserMaster
				set
					cashcost	= @cashcost,
					gamecost	= @gamecost,
					heart		= @heart,
					feed		= @feed,
					bgcomposewt	= @bgcomposewt,
					bgcomposecc	= @bgcomposecc
			where gameid = @gameid_
		end
	set nocount off
End

