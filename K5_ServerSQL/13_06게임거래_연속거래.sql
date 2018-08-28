/*
update dbo.tUserMaster set cashcost = 1000, tradecnt = 0, prizecnt = 0, tradecntold = 29,  prizecntold =  4 where gameid = 'xxxx2'
update dbo.tUserMaster set cashcost = 1000, tradecnt = 0, prizecnt = 0, tradecntold = 30,  prizecntold =  5 where gameid = 'xxxx2'
update dbo.tUserMaster set cashcost = 1000, tradecnt = 0, prizecnt = 0, tradecntold = 60,  prizecntold = 10 where gameid = 'xxxx2'
update dbo.tUserMaster set cashcost = 1000, tradecnt = 0, prizecnt = 0, tradecntold = 120, prizecntold = 20 where gameid = 'xxxx2'
update dbo.tUserMaster set cashcost = 1000, tradecnt = 0, prizecnt = 0, tradecntold = 999, prizecntold = 99 where gameid = 'xxxx2'
exec spu_TradeContinue 'xxxx2', '049000s1i0n7t8445289', -1

update dbo.tUserMaster set cashcost = 1000, gamecost = 0, tradecnt = 0, prizecnt = 0, tradecntold = 119, prizecntold = 19 where gameid = 'xxxx2'
exec spu_TradeContinue 'xxxx2', '049000s1i0n7t8445289', -1
select cashcost, gamecost, tradecnt, prizecnt, tradecntold, prizecntold from dbo.tUserMaster where gameid = 'xxxx2'
*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_TradeContinue', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_TradeContinue;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_TradeContinue
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
	declare @RESULT_ERROR_NOT_FOUND_PASSWORD	int				set @RESULT_ERROR_NOT_FOUND_PASSWORD	= -17
	declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--������ �����ϰ� �ִ�.
	declare @RESULT_NEWVERION_CLIENT_DOWNLOAD 	int				set @RESULT_NEWVERION_CLIENT_DOWNLOAD	= -15			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ��ũó��.
	declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ����.

	-- �����߿� ����.
	declare @RESULT_ERROR_HEART_LACK			int				set @RESULT_ERROR_HEART_LACK			= -20			--��Ʈ�� �����ϴ�.
	declare @RESULT_ERROR_GAMECOST_LACK			int				set @RESULT_ERROR_GAMECOST_LACK			= -21			--�ǹ��� �����ϴ�.
	declare @RESULT_ERROR_CASHCOST_LACK			int				set @RESULT_ERROR_CASHCOST_LACK			= -22			--��尡 �����ϴ�.
	declare @RESULT_ERROR_ITEM_LACK				int				set @RESULT_ERROR_ITEM_LACK				= -23			--�������̺����ϴ�.

	-- ��Ÿ����
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- ���������ʴ¸��

	-- ������ �Һз�
	declare @ITEM_SUBCATEGORY_CONTRADE			int					set @ITEM_SUBCATEGORY_CONTRADE 				= 54 -- ���Ӱŷ�(54)

	declare @TRADEINFO_PRIZECOIN_MAX			int					set @TRADEINFO_PRIZECOIN_MAX 				= 3000	-- ���ο��� �ŷ� �߰� ����ƽ�.

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
	declare @tradecntold		int				set @tradecntold	= 0
	declare @prizecntold		int				set @prizecntold	= 0
	declare @prizecntoldnew		int				set @prizecntoldnew	= 0
	declare @plusgamecost		int				set @plusgamecost	= 0

	declare @paycashcost		int				set @paycashcost	= 99999
	declare @payitemcode		int				set @payitemcode	= -1

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
		@tradecntold 	= tradecntold,
		@prizecntold	= prizecntold
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG ��������', @gameid gameid, @cashcost cashcost, @gamecost gamecost, @tradecntold tradecntold, @prizecntold prizecntold

	select top 1
		@paycashcost 	= cashcost,
		@payitemcode	= itemcode
	from
	(select itemcode, cashcost, param1, param2 from dbo.tItemInfo where subcategory = @ITEM_SUBCATEGORY_CONTRADE) t
	where t.param1 <= @tradecntold and @tradecntold < t.param2
	--select 'DEBUG ĳ������', @tradecntold tradecntold, @paycashcost paycashcost, @payitemcode payitemcode

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '���̵� �������� �ʴ´�.'
			--select 'DEBUG ' + @comment
		END
	else if(@payitemcode =  -1)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment 	= '�������� �ʴ� ����Դϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if(@paycashcost > @cashcost)
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
			set @cashcost = @cashcost - @paycashcost

			-----------------------------------
			-- ���ű�ϸ�ŷ
			-----------------------------------
			exec spu_UserItemBuyLogNew @gameid_, @payitemcode, 0, @paycashcost, 0

			-----------------------------------
			-- ���ű�ϸ�ŷ
			-----------------------------------
			set @tradecntold 	= @tradecntold + 1
			set @prizecntoldnew	= @tradecntold / 6
			if(@prizecntold < @prizecntoldnew)
				begin
					set @plusgamecost = 75 * @prizecntoldnew
					set @plusgamecost = case
											when @plusgamecost > @TRADEINFO_PRIZECOIN_MAX 	then @TRADEINFO_PRIZECOIN_MAX
											when @plusgamecost < 75							then 75
											else @plusgamecost
										end
					set @gamecost = @gamecost + @plusgamecost
				end
			set @prizecntold = @prizecntoldnew
		END


	select @nResult_ rtn, @comment comment
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			-----------------------------------
			-- ���� ���� �ݿ�.
			-----------------------------------
			update dbo.tUserMaster
			set
				cashcost	= @cashcost,
				gamecost	= @gamecost,
				tradefailcnt= 0,
				tradecnt	= @tradecntold,
				prizecnt	= @prizecntold

				--tradecntold	= 0,
				--prizecntold	= 0

			where gameid = @gameid_

			-----------------------------------
			-- ���� ����.
			-----------------------------------
			select * from dbo.tUserMaster where gameid = @gameid_
		end

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off
End



