/* 
[��ŷ]
gameid=xxx
gmode=xxx

update dbo.tUserMaster set machinepoint = 0, memorialpoint = 0, btwin = 0, bttotal = 0 where gameid = 'SangSang'
update dbo.tUserMaster set machinepoint = 0, memorialpoint = 0, btwin = 1, bttotal = 1 where gameid = 'SangSang'
update dbo.tUserMaster set machinepoint = 0, memorialpoint = 0, btwin = 0, bttotal = 1 where gameid = 'SangSang'
update dbo.tUserMaster set machinepoint = 50000, memorialpoint = 50000, btwin = 50000, bttotal = 50000 where gameid = 'SangSang'
update dbo.tUserMaster set machinepoint = 1235, memorialpoint = 2345, btwin = 500, bttotal = 240 where gameid = 'SangSang'
exec spu_GameRank 'SangSang', 1, -1
exec spu_GameRank 'SangSang', 2, -1
exec spu_GameRank 'SangSang', 3, -1
--exec spu_GameRank 'SangSang', 4, -1		--��������Ǿ� ����
exec spu_GameRank 'SangSang', 5, -1
select gameid, btwin from dbo.tUserMaster order by btwin desc

declare @v1 int		set @v1 = Convert(int, ceiling(RAND() * 10000) - 1)
declare @v2 int		set @v2 = Convert(int, ceiling(RAND() * 10000) - 1)
declare @v3 int		set @v3 = Convert(int, ceiling(RAND() * 10000) - 1)
declare @v4 int		set @v4 = Convert(int, ceiling(RAND() * 10000) - 1) + @v3
update dbo.tUserMaster set machinepoint = @v1, memorialpoint = @v2, btwin = @v3, bttotal = @v4 where gameid = 'DD99'
DD2, DD4, DD60, DD99
--SELECT Convert(int, ceiling(RAND() * 10000) - 1)

select rank() over(order by win desc, lose asc) as rank, c.ccode, n.cname, win btwin, (lose + win) bttotal, n.cnt, n.gameid  gameid
from 
	dbo.tBattleCountry c 
		join 
	dbo.tBattleCountryClub n
	on c.ccode = n.ccode
where dateid = '201211'

select * from dbo.tBattleCountryClub
*/



IF OBJECT_ID ( 'dbo.spu_GameRank', 'P' ) IS NOT NULL 
    DROP PROCEDURE dbo.spu_GameRank;
GO 

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_GameRank
	@gameid_								varchar(20),					-- ���Ӿ��̵�
	@mode_									int,
	@nResult_								int					OUTPUT
	WITH ENCRYPTION -- ���ν����� ��ȣȭ��.

as	
	------------------------------------------------
	--	2-1. �ڵ尪�ڸ�
	------------------------------------------------	
	-- �Ϲݰ�
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1			
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1	
	
	--���� ����.
	declare @RESULT_ERROR_ID_DUPLICATE			int				set @RESULT_ERROR_ID_DUPLICATE			= -2			
	declare @RESULT_ERROR_EMAIL_DUPLICATE		int				set @RESULT_ERROR_EMAIL_DUPLICATE		= -3
	
	-- �α��� ����. 
	declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--������ > �˾�ó���� ��Ʈ�η� ��������.
	declare @RESULT_ERROR_DELETED_USER 			int				set @RESULT_ERROR_DELETED_USER			= -12			--�������� > �˾�ó���� ��Ʈ�η� ��������.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--�ش������� ã�� ����
	declare @RESULT_ERROR_NOT_FOUND_PASSWORD	int				set @RESULT_ERROR_NOT_FOUND_PASSWORD	= -17			
	declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--������ �����ϰ� �ִ�.
	declare @RESULT_NEWVERION_CLIENT_DOWNLOAD 	int				set @RESULT_NEWVERION_CLIENT_DOWNLOAD	= -15			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ��ũó��.
	declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ����.
	                                                                                                         			
	-- �����߿� ����.
	declare @RESULT_ERROR_ACTION_LACK			int				set @RESULT_ERROR_ACTION_LACK			= -20			--�ൿ���� �����ϴ�.
	declare @RESULT_ERROR_SILVERBALL_LACK		int				set @RESULT_ERROR_SILVERBALL_LACK		= -21			--�ǹ��� �����ϴ�.
	declare @RESULT_ERROR_GOLDBALL_LACK			int				set @RESULT_ERROR_GOLDBALL_LACK			= -22			--��尡 �����ϴ�.
	declare @RESULT_ERROR_ITEM_LACK				int				set @RESULT_ERROR_ITEM_LACK				= -23			--�������̺����ϴ�.
	declare @RESULT_ERROR_COIN_LACK				int				set @RESULT_ERROR_COIN_LACK				= -24			--������ �����ϴ�.

	-- ������ ����, ����.                                                                                                   			
	declare @RESULT_ERROR_BUY_ALREADY			int				set @RESULT_ERROR_BUY_ALREADY			= -31			--�̹� �����߽��ϴ�.
	declare @RESULT_ERROR_NOT_HAVE				int				set @RESULT_ERROR_NOT_HAVE				= -32			--�������� �ʰ� �ִ�.
	declare @RESULT_ERROR_UPGRADE_CANNT			int				set @RESULT_ERROR_UPGRADE_CANNT			= -33			--���׷��̵带 �Ҽ� ����.						
	declare @RESULT_ERROR_UPGRADE_FAIL			int				set @RESULT_ERROR_UPGRADE_FAIL			= -34			--���׷��̵� ����.
	declare @RESULT_ERROR_UPGRADE_FULL			int				set @RESULT_ERROR_UPGRADE_FULL			= -35			--���׷��̵尡 Ǯ�εǾ���.
	declare @RESULT_ERROR_ITEM_EXPIRE			int				set @RESULT_ERROR_ITEM_EXPIRE			= -36			--�������� ���� �Ǿ���.

	-- ĳ������.
	declare @RESULT_ERROR_CASH_COPY				int				set @RESULT_ERROR_CASH_COPY				= -40			
	declare @RESULT_ERROR_CASH_OVER				int				set @RESULT_ERROR_CASH_OVER				= -41			
	declare @RESULT_ERROR_MONTH_OVER			int				set @RESULT_ERROR_MONTH_OVER			= -42			--�Ѵ޵��� �����ѵ��� �˻�

	-- �����ۼ���
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- �������ڵ��ã��
	declare @RESULT_ERROR_GIFTITEM_NOT_FOUND	int				set @RESULT_ERROR_GIFTITEM_NOT_FOUND	= -51			-- ������������ ��ã��
	declare @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	int				set @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	= -52			-- ������ �̹� ������
	
	-- ��Ÿ����
	declare @RESULT_ERROR_RESULT_COPY			int				set @RESULT_ERROR_RESULT_COPY			= -53			-- ���ī�ǽõ�
	declare @RESULT_ERROR_SILVER_COPY			int				set @RESULT_ERROR_SILVER_COPY			= -54			-- �ǹ�ī�ǽõ�


	-- ���°�.
	declare @BLOCK_STATE_NO						int				set	@BLOCK_STATE_NO						= 0				-- �����¾ƴ�
	declare @BLOCK_STATE_YES					int				set	@BLOCK_STATE_YES					= 1				-- ������
	declare @DELETE_STATE_NO					int				set	@DELETE_STATE_NO					= 0				-- �������¾ƴ�
	declare @DELETE_STATE_YES					int				set	@DELETE_STATE_YES					= 1				-- ��������

	-- ����ó�ڵ�
	declare @MARKET_SKT							int				set @MARKET_SKT							= 1
	declare @MARKET_KT							int				set @MARKET_KT							= 2
	declare @MARKET_LGT							int				set @MARKET_LGT							= 3
	declare @MARKET_FACEBOOK					int				set @MARKET_FACEBOOK					= 4
	declare @MARKET_GOOGLE						int				set @MARKET_GOOGLE						= 5

	-- �ý��� üŷ
	declare @SYSCHECK_NON						int				set @SYSCHECK_NON						= 0
	declare @SYSCHECK_YES						int				set @SYSCHECK_YES						= 1

	-- ������������
	declare @GAINSTATE_NON						int				set @GAINSTATE_NON						= 0
	declare @GAINSTATE_YES						int				set @GAINSTATE_YES						= 1
	
	-- ���ӽ���
	declare @GAME_MODE_TRAINING					int				set @GAME_MODE_TRAINING					= 1
	declare @GAME_MODE_MACHINE					int				set @GAME_MODE_MACHINE					= 2
	declare @GAME_MODE_MEMORISE					int				set @GAME_MODE_MEMORISE					= 3
	declare @GAME_MODE_SOUL						int				set @GAME_MODE_SOUL						= 4
	declare @GAME_MODE_BATTLE					int				set @GAME_MODE_BATTLE					= 5
	
	-- ��庰 �ൿ�� �Ҹ�
	declare @GAME_MODE_SINGLE_ACTION			int				set @GAME_MODE_SINGLE_ACTION					= 3
	declare @GAME_MODE_BATTLE_ACTION			int				set @GAME_MODE_BATTLE_ACTION					= 5

	-- �����÷��� ��������
	declare @GAME_STATE_END						int				set @GAME_STATE_END						= 0
	declare @GAME_STATE_PLAYING					int				set @GAME_STATE_PLAYING					= 1
	
	-- �����߿� ȹ���ϴ� ��������ġ, ��ް���ġ, ȹ��ǹ�
	declare @GAME_SINGLE_LVEXP					int				set @GAME_SINGLE_LVEXP					= 3
	declare @GAME_BATTLE_LVEXP					int				set @GAME_BATTLE_LVEXP					= 5
	--
	declare @GAME_BATTLE_GRADEEXP				int				set @GAME_BATTLE_GRADEEXP				= 3
	declare @GAME_SINGLE_SILVERBALL_MAX			int				set @GAME_SINGLE_SILVERBALL_MAX			= 10
	declare @GAME_BATTLE_SILVERBALL_MAX			int				set @GAME_BATTLE_SILVERBALL_MAX			= 20

	--��ŷ���.
	declare @RANK_MODE_FRIENDS					int				set @RANK_MODE_FRIENDS					= 3		-- �޴�(ģ��)
	declare @RANK_MODE_WORLDTOP10				int				set @RANK_MODE_WORLDTOP10				= 1		-- �޴�(����)	
	declare @RANK_MODE_COUNTRY					int				set @RANK_MODE_COUNTRY					= 5		-- �޴�(����)
	declare @RANK_MODE_MY						int				set @RANK_MODE_MY						= 2		-- ��������
	--declare @RANK_MODE_BATTLE_FRIENDS			int				set @RANK_MODE_BATTLE_FRIENDS			= 4		-- ����

	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @comment		varchar(80)
	declare @gameid			varchar(20)
	declare @machinepoint	int,
			@memorialpoint	int,
			@bttotal		int,
			@btwin			int,
			@avatar			int,
			@grade			int,
			@lv				int
	declare @picture		varchar(128)

Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on

	
	------------------------------------------------
	--	3-2. ��ŷ
	------------------------------------------------
	select @gameid = gameid, @machinepoint = machinepoint, @memorialpoint = memorialpoint, @btwin = btwin, @bttotal = bttotal, @avatar = avatar, @picture = picture, @grade = grade, @lv = lv from tUserMaster where gameid = @gameid_
	--select @machinepoint, @memorialpoint, @btwin, @bttotal

	------------------------------------------------
	--	������������
	------------------------------------------------
	if isnull(@gameid, '') = ''
		BEGIN
			set @nResult_ = @RESULT_ERROR
			select @nResult_ rtn, 'ERROR ������ �������� �ʽ��ϴ�.'
		END
	else if(@mode_ not in (@RANK_MODE_WORLDTOP10, @RANK_MODE_MY, @RANK_MODE_FRIENDS, @RANK_MODE_COUNTRY))
		BEGIN
			set @nResult_ = @RESULT_ERROR
			select @nResult_ rtn, 'ERROR �������� �ʴ¸���Դϴ�.'
		END
	else if(@mode_ in (@RANK_MODE_WORLDTOP10))
		begin
			set @nResult_ = @RESULT_SUCCESS
			select @nResult_ rtn, 'SUCCESS Top10 ��ŷ����'

			select top 10 rank() over(order by machinepoint desc) as rank, gameid, machinepoint, memorialpoint, btwin, bttotal, avatar, picture, grade, lv from dbo.tUserMaster
			union all
			select count(gameid)+1 as rank, @gameid gameid, @machinepoint machinepoint, @memorialpoint memorialpoint, @btwin btwin, @bttotal bttotal, @avatar avatar, @picture picture, @grade grade, @lv lv from dbo.tUserMaster where machinepoint > @machinepoint

			select top 10 rank() over(order by memorialpoint desc) as rank, gameid, machinepoint, memorialpoint, btwin, bttotal, avatar, picture, grade, lv from dbo.tUserMaster
			union all
			select count(gameid)+1 as rank, @gameid gameid, @machinepoint machinepoint, @memorialpoint memorialpoint, @btwin btwin, @bttotal bttotal, @avatar avatar, @picture picture, @grade grade, @lv lv from dbo.tUserMaster where memorialpoint > @memorialpoint

			select top 10 rank() over(order by btwin desc, bttotal asc) as rank, gameid, machinepoint, memorialpoint, btwin, bttotal, avatar, picture, grade, lv from dbo.tUserMaster
			union all
			select count(gameid)+1 as rank, @gameid gameid, @machinepoint machinepoint, @memorialpoint memorialpoint, @btwin btwin, @bttotal bttotal, @avatar avatar, @picture picture, @grade grade, @lv lv from dbo.tUserMaster where btwin > @btwin
		end
	else if(@mode_ in (@RANK_MODE_MY))
		begin
			set @nResult_ = @RESULT_SUCCESS
			select @nResult_ rtn, 'SUCCESS my ��ŷ����'

			--select top 10 rank() over(order by machinepoint desc) as rank, gameid, machinepoint, memorialpoint, btwin, bttotal, avatar, picture, grade, lv from dbo.tUserMaster
			--union all
			select count(gameid)+1 as rank, @gameid gameid, @machinepoint machinepoint, @memorialpoint memorialpoint, @btwin btwin, @bttotal bttotal, @avatar avatar, @picture picture, @grade grade, @lv lv from dbo.tUserMaster where machinepoint > @machinepoint

			--select top 10 rank() over(order by memorialpoint desc) as rank, gameid, machinepoint, memorialpoint, btwin, bttotal, avatar, picture, grade, lv from dbo.tUserMaster
			--union all
			select count(gameid)+1 as rank, @gameid gameid, @machinepoint machinepoint, @memorialpoint memorialpoint, @btwin btwin, @bttotal bttotal, @avatar avatar, @picture picture, @grade grade, @lv lv from dbo.tUserMaster where memorialpoint > @memorialpoint

			--select top 10 rank() over(order by btwin desc, bttotal asc) as rank, gameid, machinepoint, memorialpoint, btwin, bttotal, avatar, picture, grade, lv from dbo.tUserMaster
			--union all
			select count(gameid)+1 as rank, @gameid gameid, @machinepoint machinepoint, @memorialpoint memorialpoint, @btwin btwin, @bttotal bttotal, @avatar avatar, @picture picture, @grade grade, @lv lv from dbo.tUserMaster where btwin > @btwin
		end
	else if(@mode_ in (@RANK_MODE_FRIENDS))
		begin
			set @nResult_ = @RESULT_SUCCESS
			select @nResult_ rtn, 'SUCCESS friend ��ŷ����'

			select rank() over(order by machinepoint desc) as rank, gameid, machinepoint, memorialpoint, btwin, bttotal, avatar, picture, grade, lv from dbo.tUserMaster
			where gameid in (select friendid from dbo.tUserFriend where gameid = @gameid_) or gameid = @gameid_

			select rank() over(order by memorialpoint desc) as rank, gameid, machinepoint, memorialpoint, btwin, bttotal, avatar, picture, grade, lv from dbo.tUserMaster
			where gameid in (select friendid from dbo.tUserFriend where gameid = @gameid_) or gameid = @gameid_

			select rank() over(order by btwin desc, bttotal asc) as rank, gameid, machinepoint, memorialpoint, btwin, bttotal, avatar, picture, grade, lv from dbo.tUserMaster
			where gameid in (select friendid from dbo.tUserFriend where gameid = @gameid_) or gameid = @gameid_
		end
	--else if(@mode_ in (@RANK_MODE_BATTLE_FRIENDS))
	--	begin
	--		set @nResult_ = @RESULT_SUCCESS
	--		select @nResult_ rtn, 'SUCCESS battle friend ��ŷ����'
	--
	--		select -1 as rank , @gameid gameid, @machinepoint machinepoint, @memorialpoint memorialpoint, @btwin btwin, @bttotal bttotal, @avatar avatar, @picture picture , @grade grade, @lv lv
	--
	--		select -1 as rank, @gameid gameid, @machinepoint machinepoint, @memorialpoint memorialpoint, @btwin btwin, @bttotal bttotal, @avatar avatar, @picture picture, @grade grade, @lv lv
	--
	--		select rank() over(order by btwin desc, bttotal asc) as rank, gameid, machinepoint, memorialpoint, btwin, bttotal, avatar, picture, grade, lv from dbo.tUserMaster
	--		where gameid in (select friendid from dbo.tUserFriend where gameid = @gameid_) or gameid = @gameid_
	--	end
	else if(@mode_ in (@RANK_MODE_COUNTRY))
		begin
			set @nResult_ = @RESULT_SUCCESS
			select @nResult_ rtn, 'SUCCESS ���� ��ŷ����'
			
			declare @dateid 	varchar(6)
			set @dateid = Convert(varchar(6),Getdate(),112)		-- 201208

			select rank() over(order by win desc, lose asc) as rank, c.ccode, n.cname, win btwin, (lose + win) bttotal, n.cnt, n.gameid  gameid
			from 
				dbo.tBattleCountry c 
					join 
				dbo.tBattleCountryClub n
				on c.ccode = n.ccode
			where dateid = @dateid
		end
	
	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off
End

