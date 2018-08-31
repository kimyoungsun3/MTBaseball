/*
exec spu_Greward 'KK', -1			--������ ����

update dbo.tUserMaster set winstreak2 = 0 where gameid = 'SangSang'
exec spu_Greward 'SangSang', -1

update dbo.tUserMaster set winstreak2 = 1 where gameid = 'SangSang'
exec spu_Greward 'SangSang', -1

update dbo.tUserMaster set winstreak2 = 2 where gameid = 'SangSang'
exec spu_Greward 'SangSang', -1

update dbo.tUserMaster set winstreak2 = 3 where gameid = 'SangSang'
exec spu_Greward 'SangSang', -1

update dbo.tUserMaster set winstreak2 = 4 where gameid = 'SangSang'
exec spu_Greward 'SangSang', -1

update dbo.tUserMaster set winstreak2 = 5 where gameid = 'SangSang'
exec spu_Greward 'SangSang', -1

update dbo.tUserMaster set winstreak2 = 6 where gameid = 'SangSang'
exec spu_Greward 'SangSang', -1

update dbo.tUserMaster set winstreak2 = 7 where gameid = 'SangSang'
exec spu_Greward 'SangSang', -1

update dbo.tUserMaster set winstreak2 = 8 where gameid = 'SangSang'
exec spu_Greward 'SangSang', -1

update dbo.tUserMaster set winstreak2 = 9 where gameid = 'SangSang'
exec spu_Greward 'SangSang', -1

update dbo.tUserMaster set winstreak2 = 10 where gameid = 'SangSang'
exec spu_Greward 'SangSang', -1


-- �ݺ��ϱ�
declare @val int 
set @val = 0 
while @val <= 10 begin
	update dbo.tUserMaster set winstreak2 = @val where gameid = 'SangSang'
	exec spu_Greward 'SangSang', -1
	set @val = @val + 1 
end
-- delete from dbo.tGiftList where gameid = 'SangSang'
*/

IF OBJECT_ID ( 'dbo.spu_Greward', 'P' ) IS NOT NULL 
    DROP PROCEDURE dbo.spu_Greward;
GO 

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_Greward
	@gameid_								varchar(20),					-- ���Ӿ��̵�
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
	declare @RESULT_ERROR_ITEM_NOSALE_KIND		int				set @RESULT_ERROR_ITEM_NOSALE_KIND		= -37			--�Ǹ����� �ʴ� ������
	declare @RESULT_ERROR_ITEM_PERMANENT_ALREADY int			set @RESULT_ERROR_ITEM_PERMANENT_ALREADY = -38			-- �������� �̹� �����߽��ϴ�.
	declare @RESULT_ERROR_ITEM_NOCHANGE_KIND	int				set @RESULT_ERROR_ITEM_NOCHANGE_KIND	= -39			--��ü����Ұ���

	-- ĳ������.
	declare @RESULT_ERROR_CASH_COPY				int				set @RESULT_ERROR_CASH_COPY				= -40			
	declare @RESULT_ERROR_CASH_OVER				int				set @RESULT_ERROR_CASH_OVER				= -41			
	declare @RESULT_ERROR_MONTH_OVER			int				set @RESULT_ERROR_MONTH_OVER			= -42			--�Ѵ޵��� �����ѵ��� �˻�

	-- �����ۼ���
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- �������ڵ��ã��
	declare @RESULT_ERROR_GIFTITEM_NOT_FOUND	int				set @RESULT_ERROR_GIFTITEM_NOT_FOUND	= -51			-- ������������ ��ã��
	declare @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	int				set @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	= -52			-- ������ �̹� ������
	
	-- ������Ʈ ����
	declare @RESULT_ERROR_WIN_LACK				int				set @RESULT_ERROR_WIN_LACK				= -72

	------------------------------------------------
	--	2-2. ���°�
	------------------------------------------------	
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
	
	-- ��������Ʈ�̸�
	declare @ITEM_KIND_CHARACTER				int 			set @ITEM_KIND_CHARACTER				= 0
	declare @ITEM_KIND_FACE						int 			set @ITEM_KIND_FACE						= 1			-- �Ǹ��۾ƴ�
	declare @ITEM_KIND_CAP						int 			set @ITEM_KIND_CAP						= 2
	declare @ITEM_KIND_UPPER					int 			set @ITEM_KIND_UPPER					= 4
	declare @ITEM_KIND_UNDER					int 			set @ITEM_KIND_UNDER					= 5
	declare @ITEM_KIND_BAT						int 			set @ITEM_KIND_BAT						= 6
	declare @ITEM_KIND_GLASSES					int 			set @ITEM_KIND_GLASSES					= 7
	declare @ITEM_KIND_WING						int 			set @ITEM_KIND_WING						= 8
	declare @ITEM_KIND_TAIL						int 			set @ITEM_KIND_TAIL						= 9
	declare @ITEM_KIND_STADIUM					int 			set @ITEM_KIND_STADIUM					= 100
	declare @ITEM_KIND_CUSTOMIZE				int 			set @ITEM_KIND_CUSTOMIZE					= 22		-- �ǸŹ���� �ٸ�
	declare @ITEM_KIND_PET						int 			set @ITEM_KIND_PET						= 80
	declare @ITEM_KIND_BATTLEITEM				int 			set @ITEM_KIND_BATTLEITEM				= 90
	declare @ITEM_KIND_SYSTEMETC				int 			set @ITEM_KIND_SYSTEMETC				= 99
	
	-- ��Ÿ ���ǰ�
	declare @ITEM_PERMANENT_START_DAY			datetime		set @ITEM_PERMANENT_START_DAY			= '2012-01-01'	-- �����۽���
	declare @ITEM_PERMANENT_ADD_YEAR			int				set @ITEM_PERMANENT_ADD_YEAR			= 50			-- �����۱Ⱓ
	declare @ITEM_PERIOD_PERMANENT				int 			set @ITEM_PERIOD_PERMANENT				= -1			-- ���̺� -1�̶� ��ϵ�
	

	--�����۸���
	declare @ITEM_EXPIRE_STATE_NO				int 			set @ITEM_EXPIRE_STATE_NO				= 0			
	declare @ITEM_EXPIRE_STATE_YES				int				set @ITEM_EXPIRE_STATE_YES				= 1

	-- �������� �����ΰ� ���� ���.
	declare @COIN_RESULT_SILVER_ITEM			int				set @COIN_RESULT_SILVER_ITEM 			= 1;
	declare @COIN_RESULT_PERIOD_ITEM			int				set	@COIN_RESULT_PERIOD_ITEM			= 2;
	declare @COIN_RESULT_BATTLE_ITEM1			int				set	@COIN_RESULT_BATTLE_ITEM1			= 3;
	declare @COIN_RESULT_BATTLE_ITEM2			int				set	@COIN_RESULT_BATTLE_ITEM2			= 4;
	declare @COIN_RESULT_BATTLE_ITEM3			int				set	@COIN_RESULT_BATTLE_ITEM3			= 5;
	declare @COIN_RESULT_BATTLE_ITEM4			int				set	@COIN_RESULT_BATTLE_ITEM4			= 6;
	declare @COIN_RESULT_BATTLE_ITEM5			int				set	@COIN_RESULT_BATTLE_ITEM5			= 7;

	-- ��Ʋ�� �ʱⰪ
	declare @ITEM_BATTLE_ITEMCODE_INIT			int				set @ITEM_BATTLE_ITEMCODE_INIT			= 6000
	
	-- ������Ʈ���	
	declare @SPRINT_MODE_STEP01					int				set @SPRINT_MODE_STEP01				= 4
	declare @SPRINT_MODE_STEP02					int				set @SPRINT_MODE_STEP02				= 7
	declare @SPRINT_MODE_STEP03					int				set @SPRINT_MODE_STEP03				= 10
	
	declare @SPRINT_MODE_STEP01_REWARD			int				set @SPRINT_MODE_STEP01_REWARD		= 400
	declare @SPRINT_MODE_STEP02_REWARD			int				set @SPRINT_MODE_STEP02_REWARD		= 700
	declare @SPRINT_MODE_STEP03_REWARD			int				set @SPRINT_MODE_STEP03_REWARD		= 2500
	declare @SPRINT_MODE_ITEM_PERIOD2 			int				set @SPRINT_MODE_ITEM_PERIOD2		= 3	--���ϰ� �����ϴ°�?


	------------------------------------------------
	--	2-3. ���λ�� ����
	------------------------------------------------
	declare @gameid				varchar(20)
	declare @lv					int
	declare @ccharacter			int
	declare @winstreak2			int
	
	declare @sprintsilverball	int 		set @sprintsilverball		= 0
	declare @sprintbtitemcode	int 		set @sprintbtitemcode 		= -1
	declare @sprintbtitemcnt	int 		set @sprintbtitemcnt 		= 0
	declare @sprintcoin			int 		set @sprintcoin 			= 0
	declare @sprintitemcode		int 		set @sprintitemcode			= -1
	declare @sprintitemperiod	int 		set @sprintitemperiod		= 0
	declare @sprintupgradestate2	int 	set @sprintupgradestate2	= 0

	declare @sprintstep			int			set @sprintstep				= -1
	declare @dateid8 			varchar(8)	set @dateid8				= Convert(varchar(8),Getdate(),112)	-- 20120809
	
	declare @comment			varchar(80)	
	
	declare @rand				int	
	declare	@doubledate			datetime
	--declare @btcomment		varchar(256)	set @btcomment				= ''
	
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR	
	set @comment = 'ERROR �˼����� ����(-1)'

	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	--���� ������ �о����
	select 
		@gameid 	= gameid,
		@lv			= lv,
		@ccharacter	= ccharacter,
		@doubledate		= doubledate,
		@winstreak2	= winstreak2
	from dbo.tUserMaster where gameid = @gameid_
	--select 'DEBUG ��������', @gameid gameid, @ccharacter ccharacter, @winstreak2 winstreak2
	

	------------------------------------------------
	-- 3-3. �� ���Ǻ� �б�
	------------------------------------------------
	if isnull(@gameid, '') = ''
		BEGIN
			--select 'DEBUG ������ �������� �ʽ��ϴ�.'
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment = 'ERROR ������ �������� �ʽ��ϴ�.'
		END
	else if (@winstreak2 < @SPRINT_MODE_STEP01)
		BEGIN
			--select 'DEBUG ���� ������ �ޱⰡ �����մϴ�. ������:' + ltrim(rtrim(@winstreak2))
			set @nResult_ = @RESULT_ERROR_WIN_LACK
			set @comment = 'ERROR ���� ������ �ޱⰡ �����մϴ�. ������:' + ltrim(rtrim(@winstreak2))
		END
	else
		BEGIN
			--select 'DEBUG ���� ���� ������:' + ltrim(rtrim(@winstreak2))
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS ���� ���� ������:' + ltrim(rtrim(@winstreak2))
			
			if(@winstreak2 < @SPRINT_MODE_STEP02)
				begin
					--select 'DEBUG 1�ܰ� 3�º���'
					set @sprintsilverball = @SPRINT_MODE_STEP01_REWARD
					set @sprintbtitemcode = @ITEM_BATTLE_ITEMCODE_INIT + (Convert(int, ceiling(RAND() * 5)) - 1) -- 0 ~ 4
					set @sprintbtitemcnt 	= 1					
					set @sprintstep			= @SPRINT_MODE_STEP01
				end
			else if(@winstreak2 < @SPRINT_MODE_STEP03)
				begin
					--select 'DEBUG 2�ܰ�  7�º���'
					set @sprintsilverball = @SPRINT_MODE_STEP02_REWARD
					set @sprintbtitemcode = @ITEM_BATTLE_ITEMCODE_INIT + (Convert(int, ceiling(RAND() * 5)) - 1) -- 0 ~ 4
					set @sprintbtitemcnt 	= 2
					set @sprintcoin			= 1
					set @sprintstep			= @SPRINT_MODE_STEP02
				end 
			else
				begin
					-------------------------------------------
					-- (��Ʋ�Ϸ�/������Ʈ ����� ����)
					-------------------------------------------
					--select 'DEBUG 3�ܰ�  10�º���'
					set @sprintsilverball = @SPRINT_MODE_STEP03_REWARD
					set @sprintbtitemcode = @ITEM_BATTLE_ITEMCODE_INIT + (Convert(int, ceiling(RAND() * 5)) - 1) -- 0 ~ 4
					set @sprintbtitemcnt 	= 3
					set @sprintcoin			= 2
					set @sprintstep			= @SPRINT_MODE_STEP03
					set @sprintitemperiod	= @SPRINT_MODE_ITEM_PERIOD2
					-- ��ȭ��ġ
					set @rand = Convert(int, ceiling(RAND() *  100))
					if(@rand < 70)
						begin
							set @sprintupgradestate2 = ( 5 + Convert(int, ceiling(RAND() *  5)) - 1)
						end
					else if(@rand < 95)
						begin
							set @sprintupgradestate2 = (10 + Convert(int, ceiling(RAND() *  5)) - 1)
						end
					else
						begin
							set @sprintupgradestate2 = (15 + Convert(int, ceiling(RAND() *  5)) - 1)
						end
					
					-------------------------------------
					-- ������ �����ϱ�(��Ʋ�Ϸ�/������Ʈ ����� ����)
					-------------------------------------
					-- select top 1 * from dbo.tItemInfo where param7 = @ccharacter and kind in (2, 4, 5, 6) and silverball > 0 and silverball < 2000 order by newid()
					select top 1 @sprintitemcode = itemcode from dbo.tItemInfo 
					where ((param7 = @ccharacter and kind in (@ITEM_KIND_CAP, @ITEM_KIND_UPPER, @ITEM_KIND_UNDER) and sex != 0) or (sex = 255 and kind = @ITEM_KIND_BAT))
					and silverball > 0 and silverball < (2000 + @lv*125)
					and lv < @lv + 10
					--and sex != 0
					order by newid()
					
				end
						
			-----------------------------------------------
			--	�������̸� 2��� �����Ѵ�.
			-----------------------------------------------
			if(getdate() < @doubledate)
				begin
					--select 'DEBUG ������'
					set @sprintsilverball = @sprintsilverball * 2
				end
			--else
			--	begin
			--		select 'DEBUG �Ϲݸ��'
			--	end
				
			-------------------------------
			-- 1-1. ����Ŭ����
			-------------------------------			
			set @winstreak2 = 0
		END
		

	------------------------------------------------
	-- 4-1. �� ���Ǻ� �б� > ������
	------------------------------------------------
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			---------------------------------------------------------
			-- �ڵ����
			---------------------------------------------------------
			select @nResult_ rtn, @comment comment, @sprintsilverball sprintsilverball, @sprintbtitemcode sprintbtitemcode, @sprintbtitemcnt sprintbtitemcnt, @sprintcoin sprintcoin, @sprintitemcode sprintitemcode, @sprintitemperiod sprintitemperiod, @sprintupgradestate2 sprintupgradestate2
			
			---------------------------------------------------------
			-- �����������
			---------------------------------------------------------
			--select 'DEBUG (��)', winstreak2, silverball, coin, bttem1cnt, bttem2cnt, bttem3cnt, bttem4cnt, bttem5cnt from dbo.tUserMaster where gameid = @gameid
			
			update dbo.tUserMaster
			set
				winstreak2		= @winstreak2, 
				silverball 		= silverball + @sprintsilverball,
				coin			= coin + @sprintcoin,
				bttem1cnt 		= bttem1cnt + case when(@sprintbtitemcode = 6000) then @sprintbtitemcnt else 0 end,
				bttem2cnt 		= bttem2cnt + case when(@sprintbtitemcode = 6001) then @sprintbtitemcnt else 0 end,
				bttem3cnt 		= bttem3cnt + case when(@sprintbtitemcode = 6002) then @sprintbtitemcnt else 0 end,
				bttem4cnt 		= bttem4cnt + case when(@sprintbtitemcode = 6003) then @sprintbtitemcnt else 0 end,
				bttem5cnt 		= bttem5cnt + case when(@sprintbtitemcode = 6004) then @sprintbtitemcnt else 0 end				
			where gameid = @gameid
			
			--select 'DEBUG (��)', winstreak2, silverball, coin, bttem1cnt, bttem2cnt, bttem3cnt, bttem4cnt, bttem5cnt from dbo.tUserMaster where gameid = @gameid
			
			---------------------------------------------------------
			-- ������ �����ϱ� ó���Ѵ�.
			---------------------------------------------------------
			if(@sprintitemcode != -1)
				begin
					-- select 'DEBUG �������޵�' + str(@sprintitemcode)
					-- select @period2 = period from dbo.tItemInfo where itemcode = @sprintitemcode
					
					insert into dbo.tGiftList(gameid, itemcode, giftid, period2, upgradestate2) 
					values(@gameid , @sprintitemcode, '������Ʈ����', @sprintitemperiod, @sprintupgradestate2)
				end


			----------------------------------------------------
			-- ������Ʈ ���� ���
			----------------------------------------------------
			if(@sprintstep != -1)
				begin
					if(exists(select * from dbo.tUserGameSprintReward where dateid = @dateid8 and step = @sprintstep))
						begin
							
							update dbo.tUserGameSprintReward
								set 
									rewardsb = rewardsb + @sprintsilverball,
									rewardcnt = rewardcnt + 1
							where dateid = @dateid8 and step = @sprintstep
						end
					else
						begin
							insert into dbo.tUserGameSprintReward(dateid, step, rewardsb, rewardcnt) values(@dateid8, @sprintstep, @sprintsilverball, 1)
						end
				end
		end
	else
		begin 
			---------------------------------------------------------
			-- �ڵ����
			---------------------------------------------------------
			select @nResult_ rtn, @comment comment, @sprintsilverball sprintsilverball, @sprintbtitemcode sprintbtitemcode, @sprintbtitemcnt sprintbtitemcnt, @sprintcoin sprintcoin, @sprintitemcode sprintitemcode, @sprintitemperiod sprintitemperiod, @sprintupgradestate2 sprintupgradestate2
		
		end

	------------------------------------------------
	--	4-2. ��������
	------------------------------------------------
	select * from dbo.tUserMaster where gameid = @gameid
	
	if(@sprintitemcode != -1)
		begin
			------------------------------------------------
			--	4-3. ��������Ʈ
			------------------------------------------------
			select top 20 idx, itemcode, convert(varchar(16), giftdate, 20) as giftdate, giftid, period2, upgradestate2
			from dbo.tGiftList where gameid = @gameid and gainstate = 0 
			order by idx desc
		end
	
	set nocount off
End

