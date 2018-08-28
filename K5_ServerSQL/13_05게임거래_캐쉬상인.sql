/*
-- ��������Ʈ ���� (100)
-- ĳ���� �״�� ����(itemcode : 50000 -> 4 ����)
update dbo.tUserMaster set cashcost = 1000, fpoint = 1000 where gameid = 'xxxx2'
exec spu_TradeCash 'xxxx2', '049000s1i0n7t8445289', -1
*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_TradeCash', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_TradeCash;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_TradeCash
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
	declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--������ > �˾�ó���� ��Ʈ�η� ��������.
	declare @RESULT_ERROR_DELETED_USER 			int				set @RESULT_ERROR_DELETED_USER			= -12			--�������� > �˾�ó���� ��Ʈ�η� ��������.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--�ش������� ã�� ����.

	-- �����߿� ����.
	declare @RESULT_ERROR_HEART_LACK			int				set @RESULT_ERROR_HEART_LACK			= -20			--��Ʈ�� �����ϴ�.
	declare @RESULT_ERROR_GAMECOST_LACK			int				set @RESULT_ERROR_GAMECOST_LACK			= -21			--�ǹ��� �����ϴ�.
	declare @RESULT_ERROR_CASHCOST_LACK			int				set @RESULT_ERROR_CASHCOST_LACK			= -22			--��尡 �����ϴ�.
	declare @RESULT_ERROR_ITEM_LACK				int				set @RESULT_ERROR_ITEM_LACK				= -23			--�������̺����ϴ�.

	-- �ڵ��ȣ.
	declare @CHANGE_TRADE_ITEMCODE				int				set @CHANGE_TRADE_ITEMCODE				= 50000			-- ���κ���.

	-- ģ������Ʈ ����.
	declare @USED_FRIEND_POINT					int				set @USED_FRIEND_POINT					= 100

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
	declare @fpoint				int				set @fpoint			= 0

	declare @paycashcost		int				set @paycashcost	= 99999
	declare @needfpoint			int				set @needfpoint		= @USED_FRIEND_POINT

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
		@gamecost		= gamecost,
		@fpoint			= fpoint,
		@needfpoint		= case when famelv <= 50 then @USED_FRIEND_POINT else (@USED_FRIEND_POINT + (famelv - 50)*20) end
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG ��������', @gameid gameid, @cashcost cashcost, @gamecost gamecost, @fpoint fpoint, @needfpoint needfpoint

	select
		@paycashcost = cashcost
	from dbo.tItemInfo
	where itemcode = @CHANGE_TRADE_ITEMCODE
	--select 'DEBUG ĳ������', @paycashcost paycashcost

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '���̵� �������� �ʴ´�.'
			--select 'DEBUG ' + @comment
		END
	else if(@fpoint < @needfpoint and @paycashcost > @cashcost)
		BEGIN
			set @nResult_ = @RESULT_ERROR_CASHCOST_LACK
			set @comment = 'ERROR ĳ���� �����մϴ�.'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS ���κ����� �����մϴ�.'

			----------------------------------
			--	������� > ĳ��.
			----------------------------------
			if(@fpoint >= @needfpoint)
				begin
					-- ��������Ʈ ����.
					set @fpoint = @fpoint - @needfpoint

					-----------------------------------
					-- ���ű�ϸ�ŷ
					-----------------------------------
					exec spu_UserItemBuyLogNew @gameid_, @CHANGE_TRADE_ITEMCODE, 0, 0, 0
				end
			else
				begin
					-- ĳ�� ����.
					set @cashcost = @cashcost - @paycashcost

					-----------------------------------
					-- ���ű�ϸ�ŷ
					-----------------------------------
					exec spu_UserItemBuyLogNew @gameid_, @CHANGE_TRADE_ITEMCODE, 0, @paycashcost, 0
				end

		END


	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost, @fpoint fpoint
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			-----------------------------------
			-- ���� ���� �ݿ�.
			-----------------------------------
			update dbo.tUserMaster
			set
				cashcost	= @cashcost,
				gamecost	= @gamecost,
				fpoint		= @fpoint
			where gameid = @gameid_
		end

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off
End



