/*
update dbo.tUserMaster set cashcost = 1000 where gameid = 'xxxx2'
exec spu_AniUrgency 'xxxx2', '049000s1i0n7t8445289', -1
*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_AniUrgency', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_AniUrgency;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_AniUrgency
	@gameid_								varchar(20),
	@password_								varchar(20),
	@nResult_								int					OUTPUT
	--WITH ENCRYPTION -- ���ν����� ��ȣȭ��.
as
	------------------------------------------------
	--	2-1. �ڵ尪�ڸ�
	------------------------------------------------
	-- �Ϲݰ�
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	-- �α��� ����.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--�ش������� ã�� ����.
	declare @RESULT_ERROR_CASHCOST_LACK			int				set @RESULT_ERROR_CASHCOST_LACK			= -22			--��尡 �����ϴ�.


	-- ������� �ڵ��ȣ.
	declare @URGENCY_ITEMCODE					int					set @URGENCY_ITEMCODE				= 2100

	------------------------------------------------
	--	2-2. ���°�
	------------------------------------------------

	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @comment			varchar(80)

	declare @gameid 			varchar(20)		set @gameid 		= ''
	declare @market				int
	declare @cashcost			int				set @cashcost		= 0
	declare @gamecost			int				set @gamecost		= 0

	declare @urglistidx			int				set @urglistidx		= -444
	declare @urgcnt				int				set @urgcnt			= 0
	declare @urgcashcost		int				set @urgcashcost	= 99999

Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG �Է°�', @gameid_ gameid_, @password_ password_

	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	-- ���� ����ĳ��
	select
		@gameid 		= gameid,
		@market			= market,
		@cashcost		= cashcost,
		@gamecost		= gamecost
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG ��������', @gameid gameid, @cashcost cashcost, @gamecost gamecost

	-- ���� ���� ���������.
	select
		@urglistidx		= listidx,
		@urgcnt 		= cnt
	from dbo.tUserItem
	where gameid = @gameid_ and itemcode = @URGENCY_ITEMCODE
	--select 'DEBUG ���� ���� ���������', @urglistidx urglistidx, @urgcnt urgcnt

	select
		@urgcashcost = cashcost
	from dbo.tItemInfo
	where itemcode = @URGENCY_ITEMCODE
	--select 'DEBUG ��������� ĳ������', @urgcashcost urgcashcost

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '���̵� �������� �ʴ´�.'
			--select 'DEBUG ' + @comment
		END
	else if(@urgcnt <= 0 and @urgcashcost > @cashcost)
		BEGIN
			set @nResult_ = @RESULT_ERROR_CASHCOST_LACK
			set @comment = 'ERROR ĳ���� �����մϴ�.'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS ��������� �����մϴ�.'

			if(@urgcnt > 0)
				begin
					------------------------
					-- ���Ź�ȣ.
					------------------------
					--exec spu_UserItemBuyLogNew @gameid_, @URGENCY_ITEMCODE, 0, 0, 0

					----------------------------------
					--	������� > ��.
					----------------------------------
					set @urgcnt = @urgcnt - 1
					--select 'DEBUG > ���������(0), ĳ��(x) > �������(0)', @urgcnt urgcnt

					update dbo.tUserItem
						set
							cnt = @urgcnt
					where gameid = @gameid_ and itemcode = @URGENCY_ITEMCODE
				end
			else
				begin
					----------------------------------
					--	������� > ĳ��.
					----------------------------------
					set @cashcost = @cashcost - @urgcashcost

					-----------------------------------
					-- ���ű�ϸ�ŷ
					-----------------------------------
					exec spu_UserItemBuyLogNew @gameid_, @URGENCY_ITEMCODE, 0, @urgcashcost, 0
				end
		END



	if(@nResult_ = @RESULT_SUCCESS)
		begin
			select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost

			-----------------------------------
			-- ���� ���� �ݿ�.
			-----------------------------------
			update dbo.tUserMaster
			set
				cashcost	= @cashcost,
				gamecost	= @gamecost
			where gameid = @gameid_

		end
	else
		begin
			select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost
		end

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off
End



