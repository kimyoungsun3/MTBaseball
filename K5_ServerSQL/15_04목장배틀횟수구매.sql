/*
update dbo.tUserMaster set cashcost = 1000 where gameid = 'xxxx2'  update dbo.tUserFarm set playcnt = 0 where gameid = 'xxxx2' and itemcode in ( 6900, 6901, 6902 )

exec spu_AniBattlePlayCntBuy 'xxxx2', '049000s1i0n7t8445289', 6900, -1
exec spu_AniBattlePlayCntBuy 'xxxx2', '049000s1i0n7t8445289', 6901, -1
exec spu_AniBattlePlayCntBuy 'xxxx2', '049000s1i0n7t8445289', 6902, -1
*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_AniBattlePlayCntBuy', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_AniBattlePlayCntBuy;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_AniBattlePlayCntBuy
	@gameid_								varchar(20),					-- ���Ӿ��̵�
	@password_								varchar(20),
	@farmidx_								int,
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
	declare @RESULT_ERROR_CASHCOST_LACK			int				set @RESULT_ERROR_CASHCOST_LACK			= -22			--��尡 �����ϴ�.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--�ش������� ã�� ����
	declare @RESULT_ERROR_NOT_FOUND_USERFARM	int				set @RESULT_ERROR_NOT_FOUND_USERFARM	= -125			-- ���帮��Ʈ�� �̱���.

	------------------------------------------------
	--	2-2. ���°�
	------------------------------------------------
	-- ����(����).
	declare @USERFARM_BUYSTATE_NOBUY			int					set @USERFARM_BUYSTATE_NOBUY				= -1	-- (����)
	declare @USERFARM_BUYSTATE_BUY				int					set @USERFARM_BUYSTATE_BUY					=  1

	declare @FARM_BATTLE_PLAYCNT_MAX			int					set @FARM_BATTLE_PLAYCNT_MAX				= 10	-- ��ƲȽ��.

	-- ��Ʋ����Ƚ�� �ڵ��ȣ.
	declare @BATTLE_PLAYCNT_ITEMCODE			int					set @BATTLE_PLAYCNT_ITEMCODE				= 50003

	------------------------------------------------
	--	2-3. ���λ�� ����
	------------------------------------------------
	declare @comment				varchar(512)		set @comment			= ''
	declare @gameid					varchar(20)			set @gameid				= ''
	declare @market					int					set @market				= 1
	declare @version				int					set @version			= 101
	declare @cashcost				int					set @cashcost 			= 0
	declare @gamecost				int					set @gamecost 			= 0

	declare @buystate				int					set @buystate			= @USERFARM_BUYSTATE_NOBUY
	declare @playcnt				int					set @playcnt			= 0
	declare @needcashcost			int					set @needcashcost		= 9999

	-- VIPȿ��.
	declare @cashpoint				int				set @cashpoint					= 0
	declare @vip_plus				int				set @vip_plus					= 0

Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG �Է�����', @gameid_ gameid_, @password_ password_, @farmidx_ farmidx_

	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	select
		@gameid 		= gameid,			@market			= market,		@version		= version,
		@cashpoint		= cashpoint,
		@cashcost		= cashcost,			@gamecost		= gamecost
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG ��������', @gameid gameid, @cashcost cashcost

	select
		@buystate		= buystate,		@playcnt		= playcnt
	from dbo.tUserFarm
	where gameid = @gameid_ and itemcode = @farmidx_
	--select 'DEBUG ���� ��������', @farmidx_ farmidx_, @buystate buystate, @playcnt playcnt

	select
		@needcashcost = cashcost
	from dbo.tItemInfo
	where itemcode = @BATTLE_PLAYCNT_ITEMCODE
	--select 'DEBUG ��Ʋ����Ƚ�� ĳ������', @needcashcost needcashcost

	------------------------------------------------
	-- 3-3. �� ���Ǻ� �б�
	------------------------------------------------
	if( @gameid = '' )
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR ���̵� �������� �ʴ´�.'
			--select 'DEBUG ' + @comment
		END
	else if(@playcnt > 0)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment = 'SUCCESS �����߽��ϴ�.(2)'
			--select 'DEBUG ' + @comment
		END
	else if(@buystate != @USERFARM_BUYSTATE_BUY)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_USERFARM
			set @comment 	= 'ERROR ������ �����ϰ� ���� �ʴ�.'
			--select 'DEBUG ' + @comment
		END
	else if( @needcashcost > @cashcost )
		BEGIN
			set @nResult_ = @RESULT_ERROR_CASHCOST_LACK
			set @comment = 'ERROR ĳ���� �����մϴ�.'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS �����߽��ϴ�.(1)'
			--select 'DEBUG ' + @comment

			---------------------------------------------
			-- ĳ������
			-- �������� Ƚ�� �ڵ����� �Է��� �α����� ������ �κ��� �����ؾ��ؼ� ���⼭ �����ϸ� �ȵȴ�.
			---------------------------------------------
			--select 'DEBUG (��)', @cashcost cashcost, @needcashcost needcashcost
			set @cashcost	= @cashcost - @needcashcost
			--select 'DEBUG (��)', @cashcost cashcost, @needcashcost needcashcost

			---------------------------------------------
			-- ��ϸ�ŷ
			---------------------------------------------
			update dbo.tUserMaster
				set
					cashcost		= @cashcost
			where gameid = @gameid_

			---------------------------------------------
			-- ��Ʋ����Ƚ��.
			---------------------------------------------
			set @vip_plus = dbo.fun_GetVIPPlus( 8, @cashpoint, @FARM_BATTLE_PLAYCNT_MAX)		-- ����Ƚ��

			update dbo.tUserFarm
				set
					playcnt = @FARM_BATTLE_PLAYCNT_MAX + @vip_plus
			where gameid = @gameid_ and itemcode = @farmidx_

			------------------------------------------------
			-- �������.
			------------------------------------------------
			exec spu_DayLogInfoStatic @market, 33, 1				-- �� ��ƲȽ������.

			-----------------------------------
			-- ���ű�ϸ�ŷ
			-----------------------------------
			exec spu_UserItemBuyLogNew @gameid_, @BATTLE_PLAYCNT_ITEMCODE, 0, @needcashcost, 0
		END


	--------------------------------------------------------------
	-- �������.
	--------------------------------------------------------------
	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost


	if(@nResult_ = @RESULT_SUCCESS)
		begin
			--------------------------------------------------------------
			-- ���帮��Ʈ ����
			--------------------------------------------------------------
			exec spu_UserFarmListNew @gameid_, 1, @market, @version
		end



	------------------------------------------------
	--	4-2. ��������
	------------------------------------------------
	set nocount off
End

