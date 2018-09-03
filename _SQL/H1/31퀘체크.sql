
/*
-- �α���, ����
exec spu_QuestCheck @gameid_, @questkind, @questsubkind, -1

exec spu_QuestCheck 1, 'superman3',  100, 2, -1, -1				-- ��ȭ
exec spu_QuestCheck 1, 'superman3',  100, 9, -1, -1

exec spu_QuestCheck 1, 'superman3',  200, 2, -1, -1				-- ����
exec spu_QuestCheck 1, 'superman3',  200, 9, -1, -1

exec spu_QuestCheck 1, 'superman3',  300, 1, -1, -1				-- �ӽ�
exec spu_QuestCheck 1, 'superman3',  300, 2, -1, -1
exec spu_QuestCheck 1, 'superman3',  300, 9, -1, -1

exec spu_QuestCheck 1, 'superman3',  400, 1, -1, -1				-- �ϱ�
exec spu_QuestCheck 1, 'superman3',  400, 2, -1, -1
exec spu_QuestCheck 1, 'superman3',  400, 9, -1, -1

exec spu_QuestCheck 1, 'superman3',  500, 3, -1, -1				-- ģ��
exec spu_QuestCheck 1, 'superman3',  500, 4, -1, -1

exec spu_QuestCheck 1, 'superman3',  600, 1, -1, -1				-- ����
exec spu_QuestCheck 1, 'superman3',  700, 1, -1, -1				-- ����
exec spu_QuestCheck 1, 'superman3',  800, 1, -1, -1				-- õ��

exec spu_QuestCheck 1, 'superman3',  900, 1, -1, -1				-- ��Ʋ
exec spu_QuestCheck 1, 'superman3',  900, 2, -1, -1
exec spu_QuestCheck 1, 'superman3',  900, 5, -1, -1
exec spu_QuestCheck 1, 'superman3',  900, 6, -1, -1
exec spu_QuestCheck 1, 'superman3',  900, 7, -1, -1
exec spu_QuestCheck 1, 'superman3',  900, 8, -1, -1
exec spu_QuestCheck 1, 'superman3',  900, 9, -1, -1

exec spu_QuestCheck 1, 'superman3', 1000, 1, -1, -1				-- ����
exec spu_QuestCheck 1, 'superman3', 1000, 2, -1, -1
exec spu_QuestCheck 1, 'superman3', 1000, 5, -1, -1
exec spu_QuestCheck 1, 'superman3', 1000, 6, -1, -1
exec spu_QuestCheck 1, 'superman3', 1000, 7, -1, -1
exec spu_QuestCheck 1, 'superman3', 1000, 8, -1, -1
exec spu_QuestCheck 1, 'superman3', 1000, 9, -1, -1


-- �α��� > if(�ʱ�ȭ)
exec spu_QuestCheck 1, 'superman3', 100, 2, -1, -1

-- ���� > �˻�
declare @rtn int		set @rtn = -1
exec spu_QuestCheck 2, 'superman3', 100, 2, 1, @rtn OUTPUT
select @rtn

-- ���� > if(�ʱ�ȭ)
exec spu_QuestCheck 1, 'superman3', 100, 2, -1, -1
*/

IF OBJECT_ID ( 'dbo.spu_QuestCheck', 'P' ) IS NOT NULL 
    DROP PROCEDURE dbo.spu_QuestCheck;
GO 

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_QuestCheck
	@questmode_								int,
	@gameid_								varchar(20),												-- ���Ӿ��̵�
	@questkind_								int,
	@questsubkind_							int,
	@questvalue_							int,
	@nResult_								int				OUTPUT
	WITH ENCRYPTION -- ���ν����� ��ȣȭ��.
as	
	-- ����Ʈ 
	declare @QUEST_KIND_UPGRADE				int 			set @QUEST_KIND_UPGRADE 			= 100	-- ��ȭ
	declare @QUEST_KIND_MATING				int 			set @QUEST_KIND_MATING				= 200	-- ����
	declare @QUEST_KIND_MACHINE				int 			set @QUEST_KIND_MACHINE				= 300	-- �ӽ�
	declare @QUEST_KIND_MEMORIAL			int 			set @QUEST_KIND_MEMORIAL			= 400	-- �ϱ�
	declare @QUEST_KIND_FRIEND				int 			set @QUEST_KIND_FRIEND				= 500	-- ģ��
	declare @QUEST_KIND_POLL				int 			set @QUEST_KIND_POLL				= 600	-- ����
	declare @QUEST_KIND_BOARD				int 			set @QUEST_KIND_BOARD				= 700	-- ����
	declare @QUEST_KIND_CEIL				int 			set @QUEST_KIND_CEIL				= 800	-- õ��
	declare @QUEST_KIND_BATTLE				int 			set @QUEST_KIND_BATTLE				= 900	-- ��Ʋ
	declare @QUEST_KIND_SPRINT				int 			set @QUEST_KIND_SPRINT				= 1000	-- ����
	
	declare @QUEST_SUBKIND_POINT_ACCRUE		int 			set @QUEST_SUBKIND_POINT_ACCRUE 	= 1		-- ����
	declare @QUEST_SUBKIND_POINT_BEST		int 			set @QUEST_SUBKIND_POINT_BEST 		= 2		-- �ְ�
	declare @QUEST_SUBKIND_FRIEND_ADD		int 			set @QUEST_SUBKIND_FRIEND_ADD 		= 3		-- �߰�
	declare @QUEST_SUBKIND_FRIEND_VISIT		int 			set @QUEST_SUBKIND_FRIEND_VISIT 	= 4		-- �湮
	declare @QUEST_SUBKIND_HR_CNT			int 			set @QUEST_SUBKIND_HR_CNT 			= 5		-- Ȩ������
	declare @QUEST_SUBKIND_HR_COMBO			int 			set @QUEST_SUBKIND_HR_COMBO 		= 6		-- Ȩ���޺�
	declare @QUEST_SUBKIND_WIN_CNT			int 			set @QUEST_SUBKIND_WIN_CNT 			= 7		-- �´���
	declare @QUEST_SUBKIND_WIN_STREAK		int 			set @QUEST_SUBKIND_WIN_STREAK 		= 8		-- �¿���
	declare @QUEST_SUBKIND_CNT				int 			set @QUEST_SUBKIND_CNT 				= 9		-- �÷���

	declare @QUEST_INIT_NOT					int 			set @QUEST_INIT_NOT 				= 0
	declare @QUEST_INIT_FIRST				int 			set @QUEST_INIT_FIRST 				= 1
		
	declare @QUEST_CLEAR_NON				int 			set @QUEST_CLEAR_NON 				= 0
	declare @QUEST_CLEAR_START				int 			set @QUEST_CLEAR_START 				= 1
	declare @QUEST_CLEAR_REWARD				int 			set @QUEST_CLEAR_REWARD				= 2
	
	declare @QUEST_STATE_USER_END			int 			set @QUEST_STATE_USER_END 			= 0
	declare @QUEST_STATE_USER_WAIT			int 			set @QUEST_STATE_USER_WAIT 			= 1
	declare @QUEST_STATE_USER_ING			int 			set @QUEST_STATE_USER_ING 			= 2
	
	-- ����Ʈ �Ϲ����ǹ�
	declare @QUEST_MODE_CLEAR				int 			set @QUEST_MODE_CLEAR 				= 1
	declare @QUEST_MODE_CHECK				int 			set @QUEST_MODE_CHECK 				= 2
	
	declare @QUEST_NOT_COMPLETE				int 			set @QUEST_NOT_COMPLETE 			= -1
	declare @QUEST_COMPLETED				int 			set @QUEST_COMPLETED 				= 1

	------------------------------------------------
	--	2-3. ���λ�� ����
	------------------------------------------------
	declare @itemupgradebest				int,
			@itemupgradecnt					int,
			
			@petmatingbest					int,
			@petmatingcnt					int,
			
			@machpointaccrue				int,
			@machpointbest					int,
			@machplaycnt					int,
			
			@mempointaccrue					int,
			@mempointbest					int,
			@memplaycnt						int,
			
			@friendaddcnt					int,
			@friendvisitcnt					int,
			
			@pollhitcnt						int,
			@ceilhitcnt						int,
			@boardhitcnt					int,
			
			@btdistaccrue					int,
			@btdistbest						int,
			@bthrcnt						int,
			@bthrcombo						int,
			@btwincnt						int,
			@btwinstreak					int,
			@btplaycnt						int,
			
			@spdistaccrue					int,
			@spdistbest						int,
			@sphrcnt						int,
			@sphrcombo						int,
			@spwincnt						int,
			@spwinstreak					int,
			@spplaycnt						int
	
	declare @userdata						int
	
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	
	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	select 
		@itemupgradebest = itemupgradebest, 	@itemupgradecnt = itemupgradecnt,		
		@petmatingbest = petmatingbest,			@petmatingcnt = petmatingcnt,			
		@machpointaccrue = machpointaccrue, 	@machpointbest = machpointbest,			@machplaycnt = machplaycnt,
		@mempointaccrue = mempointaccrue, 		@mempointbest = mempointbest,			@memplaycnt =  memplaycnt,
		@friendaddcnt = friendaddcnt,			@friendvisitcnt = friendvisitcnt,		
		@pollhitcnt = pollhitcnt,				@ceilhitcnt = ceilhitcnt,				@boardhitcnt = boardhitcnt,
		@btdistaccrue = btdistaccrue,			@btdistbest = btdistbest,				@bthrcnt = bthrcnt,
		@bthrcombo = bthrcombo,					@btwincnt = btwincnt,					@btwinstreak = btwinstreak,
		@btplaycnt = btplaycnt,
		@spdistaccrue = spdistaccrue,			@spdistbest = spdistbest,				@sphrcnt = sphrcnt,
		@sphrcombo = sphrcombo,					@spwincnt = spwincnt,					@spwinstreak = spwinstreak,
		@spplaycnt = spplaycnt
	from dbo.tUserMaster where gameid = @gameid_
	
	
	------------------------------------------------
	--	3-3. Ŭ����, �˻�, �˻�_Ŭ����
	------------------------------------------------
	if(@questkind_ = @QUEST_KIND_UPGRADE)
		begin
			-- @QUEST_SUBKIND_POINT_ACCRUE													-- ����.
			if(@questsubkind_ = @QUEST_SUBKIND_POINT_BEST)									-- �ְ�.
				begin
					if(@questmode_ = @QUEST_MODE_CLEAR)
						begin
							set @itemupgradebest = 0
						end
					else if(@questmode_ = @QUEST_MODE_CHECK and @itemupgradebest >= @questvalue_)
						begin
							set @nResult_ = @QUEST_COMPLETED
						end
				end
			-- @QUEST_SUBKIND_FRIEND_ADD
			-- @QUEST_SUBKIND_FRIEND_VISIT 													-- �湮.
			-- @QUEST_SUBKIND_HR_CNT 														-- Ȩ������.
			-- @QUEST_SUBKIND_HR_COMBO 														-- Ȩ���޺�.
			-- @QUEST_SUBKIND_WIN_CNT 														-- �´���.
			-- @QUEST_SUBKIND_WIN_STREAK 													-- �¿���.
			else if(@questsubkind_ = @QUEST_SUBKIND_CNT)									-- �÷���.
				begin
					if(@questmode_ = @QUEST_MODE_CLEAR)
						begin
							set @itemupgradecnt = 0
						end
					else if(@questmode_ = @QUEST_MODE_CHECK and @itemupgradecnt >= @questvalue_)
						begin
							set @nResult_ = @QUEST_COMPLETED
						end
				end
		end
	else if(@questkind_ = @QUEST_KIND_MATING)
		begin
			-- @QUEST_SUBKIND_POINT_ACCRUE 													-- ����.
			if(@questsubkind_ = @QUEST_SUBKIND_POINT_BEST)									-- �ְ�.
				begin
					if(@questmode_ = @QUEST_MODE_CLEAR)
						begin
							set @petmatingbest = 0
						end
					else if(@questmode_ = @QUEST_MODE_CHECK and @petmatingbest >= @questvalue_)
						begin
							set @nResult_ = @QUEST_COMPLETED
						end
				end
			-- @QUEST_SUBKIND_FRIEND_ADD 													-- �߰�.
			-- @QUEST_SUBKIND_FRIEND_VISIT 													-- �湮.
			-- @QUEST_SUBKIND_HR_CNT 														-- Ȩ������.
			-- @QUEST_SUBKIND_HR_COMBO 														-- Ȩ���޺�.
			-- @QUEST_SUBKIND_WIN_CNT 														-- �´���.
			-- @QUEST_SUBKIND_WIN_STREAK 													-- �¿���.
			else if(@questsubkind_ = @QUEST_SUBKIND_CNT) 										-- �÷���.
				begin
					if(@questmode_ = @QUEST_MODE_CLEAR)
						begin
							set @petmatingcnt = 0
						end
					else if(@questmode_ = @QUEST_MODE_CHECK and @petmatingcnt >= @questvalue_)
						begin
							set @nResult_ = @QUEST_COMPLETED
						end
				end
		end
	else if(@questkind_ = @QUEST_KIND_MACHINE)
		begin
			if(@questsubkind_ = @QUEST_SUBKIND_POINT_ACCRUE) 								-- ����.
				begin
					if(@questmode_ = @QUEST_MODE_CLEAR)
						begin
							set @machpointaccrue = 0
						end
					else if(@questmode_ = @QUEST_MODE_CHECK and @machpointaccrue >= @questvalue_)
						begin
							set @nResult_ = @QUEST_COMPLETED
						end
				end
			else if(@questsubkind_ = @QUEST_SUBKIND_POINT_BEST)								-- �ְ�.
				begin
					if(@questmode_ = @QUEST_MODE_CLEAR)
						begin
							set @machpointbest = 0
						end
					else if(@questmode_ = @QUEST_MODE_CHECK and @machpointbest >= @questvalue_)
						begin
							set @nResult_ = @QUEST_COMPLETED
						end
				end
			-- @QUEST_SUBKIND_FRIEND_ADD													-- �߰�.
			-- @QUEST_SUBKIND_FRIEND_VISIT													-- �湮.
			-- @QUEST_SUBKIND_HR_CNT 														-- Ȩ������.
			-- @QUEST_SUBKIND_HR_COMBO 														-- Ȩ���޺�.
			-- @QUEST_SUBKIND_WIN_CNT 														-- �´���.
			-- @QUEST_SUBKIND_WIN_STREAK 													-- �¿���.
			else if(@questsubkind_ = @QUEST_SUBKIND_CNT)									-- �÷���.
				begin
					if(@questmode_ = @QUEST_MODE_CLEAR)
						begin
							set @machplaycnt = 0
						end
					else if(@questmode_ = @QUEST_MODE_CHECK and @machplaycnt >= @questvalue_)
						begin
							set @nResult_ = @QUEST_COMPLETED
						end
				end
		end
	else if(@questkind_ = @QUEST_KIND_MEMORIAL)
		begin
			if(@questsubkind_ = @QUEST_SUBKIND_POINT_ACCRUE) 								-- ����.
				begin
					if(@questmode_ = @QUEST_MODE_CLEAR)
						begin
							set @mempointaccrue = 0
						end
					else if(@questmode_ = @QUEST_MODE_CHECK and @mempointaccrue >= @questvalue_)
						begin
							set @nResult_ = @QUEST_COMPLETED
						end
				end
			else if(@questsubkind_ = @QUEST_SUBKIND_POINT_BEST)								-- �ְ�.
				begin
					if(@questmode_ = @QUEST_MODE_CLEAR)
						begin
							set @mempointbest = 0
						end
					else if(@questmode_ = @QUEST_MODE_CHECK and @mempointbest >= @questvalue_)
						begin
							set @nResult_ = @QUEST_COMPLETED
						end
				end
			-- @QUEST_SUBKIND_FRIEND_ADD 													-- �߰�.
			-- @QUEST_SUBKIND_FRIEND_VISIT 													-- �湮.
			-- @QUEST_SUBKIND_HR_CNT 														-- Ȩ������.
			-- @QUEST_SUBKIND_HR_COMBO 														-- Ȩ���޺�.
			-- @QUEST_SUBKIND_WIN_CNT 														-- �´���.
			-- @QUEST_SUBKIND_WIN_STREAK 													-- �¿���.
			else if(@questsubkind_ = @QUEST_SUBKIND_CNT)									-- �÷���.
				begin
					if(@questmode_ = @QUEST_MODE_CLEAR)
						begin
							set @memplaycnt = 0
						end
					else if(@questmode_ = @QUEST_MODE_CHECK and @memplaycnt >= @questvalue_)
						begin
							set @nResult_ = @QUEST_COMPLETED
						end
				end
		end
	else if(@questkind_ = @QUEST_KIND_FRIEND)
		begin
			-- @QUEST_SUBKIND_POINT_ACCRUE) -- ����.
			-- @QUEST_SUBKIND_POINT_BEST) -- �ְ�.
			if(@questsubkind_ = @QUEST_SUBKIND_FRIEND_ADD) 									-- �߰�.
				begin
					if(@questmode_ = @QUEST_MODE_CLEAR)
						begin
							set @friendaddcnt = 0
						end
					else if(@questmode_ = @QUEST_MODE_CHECK and @friendaddcnt >= @questvalue_)
						begin
							set @nResult_ = @QUEST_COMPLETED
						end
				end
			else if(@questsubkind_ = @QUEST_SUBKIND_FRIEND_VISIT) 							-- �湮.
				begin
					if(@questmode_ = @QUEST_MODE_CLEAR)
						begin
							set @friendvisitcnt = 0
						end
					else if(@questmode_ = @QUEST_MODE_CHECK and @friendvisitcnt >= @questvalue_)
						begin
							set @nResult_ = @QUEST_COMPLETED
						end
				end
			-- @QUEST_SUBKIND_HR_CNT 														-- Ȩ������.
			-- @QUEST_SUBKIND_HR_COMBO 														-- Ȩ���޺�.
			-- @QUEST_SUBKIND_WIN_CNT 														-- �´���.
			-- @QUEST_SUBKIND_WIN_STREAK 													-- �¿���.
			-- @QUEST_SUBKIND_CNT 															-- �÷���.
		end
	else if(@questkind_ = @QUEST_KIND_POLL)
		begin
			if(@questsubkind_ = @QUEST_SUBKIND_POINT_ACCRUE) 							-- ����.
				begin
					if(@questmode_ = @QUEST_MODE_CLEAR)
						begin
							set @pollhitcnt = 0
						end
					else if(@questmode_ = @QUEST_MODE_CHECK and @pollhitcnt >= @questvalue_)
						begin
							set @nResult_ = @QUEST_COMPLETED
						end
				end
			-- @QUEST_SUBKIND_POINT_BEST 													-- �ְ�.
			-- @QUEST_SUBKIND_FRIEND_ADD 													-- �߰�.
			-- @QUEST_SUBKIND_FRIEND_VISIT 													-- �湮.
			-- @QUEST_SUBKIND_HR_CNT 														-- Ȩ������.
			-- @QUEST_SUBKIND_HR_COMBO 														-- Ȩ���޺�.
			-- @QUEST_SUBKIND_WIN_CNT 														-- �´���.
			-- @QUEST_SUBKIND_WIN_STREAK 													-- �¿���.
			-- @QUEST_SUBKIND_CNT 															-- �÷���.
		end
	else if(@questkind_ = @QUEST_KIND_BOARD)
		begin
			if(@questsubkind_ = @QUEST_SUBKIND_POINT_ACCRUE) 								-- ����.
				begin
					if(@questmode_ = @QUEST_MODE_CLEAR)
						begin
							set @boardhitcnt = 0
						end
					else if(@questmode_ = @QUEST_MODE_CHECK and @boardhitcnt >= @questvalue_)
						begin
							set @nResult_ = @QUEST_COMPLETED
						end
				end
			-- @QUEST_SUBKIND_POINT_BEST 													-- �ְ�.
			-- @QUEST_SUBKIND_FRIEND_ADD 													-- �߰�.
			-- @QUEST_SUBKIND_FRIEND_VISIT 													-- �湮.
			-- @QUEST_SUBKIND_HR_CNT 														-- Ȩ������.
			-- @QUEST_SUBKIND_HR_COMBO 														-- Ȩ���޺�.
			-- @QUEST_SUBKIND_WIN_CNT 														-- �´���.
			-- @QUEST_SUBKIND_WIN_STREAK 													-- �¿���.
			-- @QUEST_SUBKIND_CNT 															-- �÷���.
		end
	else if(@questkind_ = @QUEST_KIND_CEIL)
		begin
			if(@questsubkind_ = @QUEST_SUBKIND_POINT_ACCRUE) -- ����.
				begin
					if(@questmode_ = @QUEST_MODE_CLEAR)
						begin
							set @ceilhitcnt = 0
						end
					else if(@questmode_ = @QUEST_MODE_CHECK and @ceilhitcnt >= @questvalue_)
						begin
							set @nResult_ = @QUEST_COMPLETED
						end
				end
			-- @QUEST_SUBKIND_POINT_BEST 													-- �ְ�.
			-- @QUEST_SUBKIND_FRIEND_ADD 													-- �߰�.
			-- @QUEST_SUBKIND_FRIEND_VISIT 													-- �湮.
			-- @QUEST_SUBKIND_HR_CNT 														-- Ȩ������.
			-- @QUEST_SUBKIND_HR_COMBO 														-- Ȩ���޺�.
			-- @QUEST_SUBKIND_WIN_CNT 														-- �´���.
			-- @QUEST_SUBKIND_WIN_STREAK 													-- �¿���.
			-- @QUEST_SUBKIND_CNT 															-- �÷���.
		end
	else if(@questkind_ = @QUEST_KIND_BATTLE)
		begin
			if(@questsubkind_ = @QUEST_SUBKIND_POINT_ACCRUE) 								-- ����.
				begin
					if(@questmode_ = @QUEST_MODE_CLEAR)
						begin
							set @btdistaccrue = 0
						end
					else if(@questmode_ = @QUEST_MODE_CHECK and @btdistaccrue >= @questvalue_)
						begin
							set @nResult_ = @QUEST_COMPLETED
						end
				end
			else if(@questsubkind_ = @QUEST_SUBKIND_POINT_BEST)								-- �ְ�.
				begin
					if(@questmode_ = @QUEST_MODE_CLEAR)
						begin
							set @btdistbest = 0
						end
					else if(@questmode_ = @QUEST_MODE_CHECK and @btdistbest >= @questvalue_)
						begin
							set @nResult_ = @QUEST_COMPLETED
						end
				end
			-- @QUEST_SUBKIND_FRIEND_ADD 													-- �߰�.
			-- @QUEST_SUBKIND_FRIEND_VISIT 													-- �湮.
			else if(@questsubkind_ = @QUEST_SUBKIND_HR_CNT)									-- Ȩ������.
				begin
					if(@questmode_ = @QUEST_MODE_CLEAR)
						begin
							set @bthrcnt = 0
						end
					else if(@questmode_ = @QUEST_MODE_CHECK and @bthrcnt >= @questvalue_)
						begin
							set @nResult_ = @QUEST_COMPLETED
						end
				end
			else if(@questsubkind_ = @QUEST_SUBKIND_HR_COMBO) 								-- Ȩ���޺�.
				begin
					if(@questmode_ = @QUEST_MODE_CLEAR)
						begin
							set @bthrcombo = 0
						end
					else if(@questmode_ = @QUEST_MODE_CHECK and @bthrcombo >= @questvalue_)
						begin
							set @nResult_ = @QUEST_COMPLETED
						end
				end
			else if(@questsubkind_ = @QUEST_SUBKIND_WIN_CNT) 								-- �´���.
				begin
					if(@questmode_ = @QUEST_MODE_CLEAR)
						begin
							set @btwincnt = 0
						end
					else if(@questmode_ = @QUEST_MODE_CHECK and @btwincnt >= @questvalue_)
						begin
							set @nResult_ = @QUEST_COMPLETED
						end
				end
			else if(@questsubkind_ = @QUEST_SUBKIND_WIN_STREAK) 							-- �¿���.
				begin
					if(@questmode_ = @QUEST_MODE_CLEAR)
						begin
							set @btwinstreak = 0
						end
					else if(@questmode_ = @QUEST_MODE_CHECK and @btwinstreak >= @questvalue_)
						begin
							set @nResult_ = @QUEST_COMPLETED
						end
				end
			else if(@questsubkind_ = @QUEST_SUBKIND_CNT)									-- �÷���.
				begin
					if(@questmode_ = @QUEST_MODE_CLEAR)
						begin
							set @btplaycnt = 0
						end
					else if(@questmode_ = @QUEST_MODE_CHECK and @btplaycnt >= @questvalue_)
						begin
							set @nResult_ = @QUEST_COMPLETED
						end
				end
		end
	else if(@questkind_ = @QUEST_KIND_SPRINT)
		begin
			if(@questsubkind_ = @QUEST_SUBKIND_POINT_ACCRUE) 								-- ����.
				begin
					if(@questmode_ = @QUEST_MODE_CLEAR)
						begin
							set @spdistaccrue = 0
						end
					else if(@questmode_ = @QUEST_MODE_CHECK and @spdistaccrue >= @questvalue_)
						begin
							set @nResult_ = @QUEST_COMPLETED
						end
				end		
			else if(@questsubkind_ = @QUEST_SUBKIND_POINT_BEST) 							-- �ְ�.
				begin
					if(@questmode_ = @QUEST_MODE_CLEAR)
						begin
							set @spdistbest = 0
						end
					else if(@questmode_ = @QUEST_MODE_CHECK and @spdistbest >= @questvalue_)
						begin
							set @nResult_ = @QUEST_COMPLETED
						end
				end
			-- @QUEST_SUBKIND_FRIEND_ADD 													-- �߰�.
			-- @QUEST_SUBKIND_FRIEND_VISIT 													-- �湮.
			else if(@questsubkind_ = @QUEST_SUBKIND_HR_CNT) 								-- Ȩ������.
				begin
					if(@questmode_ = @QUEST_MODE_CLEAR)
						begin
							set @sphrcnt = 0
						end
					else if(@questmode_ = @QUEST_MODE_CHECK and @sphrcnt >= @questvalue_)
						begin
							set @nResult_ = @QUEST_COMPLETED
						end
				end
			else if(@questsubkind_ = @QUEST_SUBKIND_HR_COMBO) 								-- Ȩ���޺�.
				begin
					if(@questmode_ = @QUEST_MODE_CLEAR)
						begin
							set @sphrcombo = 0
						end
					else if(@questmode_ = @QUEST_MODE_CHECK and @sphrcombo >= @questvalue_)
						begin
							set @nResult_ = @QUEST_COMPLETED
						end
				end
			else if(@questsubkind_ = @QUEST_SUBKIND_WIN_CNT) 								-- �´���.
				begin
					if(@questmode_ = @QUEST_MODE_CLEAR)
						begin
							set @spwincnt = 0
						end
					else if(@questmode_ = @QUEST_MODE_CHECK and @spwincnt >= @questvalue_)
						begin
							set @nResult_ = @QUEST_COMPLETED
						end
				end
			else if(@questsubkind_ = @QUEST_SUBKIND_WIN_STREAK) 							-- �¿���.
				begin
					if(@questmode_ = @QUEST_MODE_CLEAR)
						begin
							set @spwinstreak = 0
						end
					else if(@questmode_ = @QUEST_MODE_CHECK and @spwinstreak >= @questvalue_)
						begin
							set @nResult_ = @QUEST_COMPLETED
						end
				end
			else if(@questsubkind_ = @QUEST_SUBKIND_CNT) 									-- �÷���.
				begin
					if(@questmode_ = @QUEST_MODE_CLEAR)
						begin
							set @spplaycnt = 0
						end
					else if(@questmode_ = @QUEST_MODE_CHECK and @spplaycnt >= @questvalue_)
						begin
							set @nResult_ = @QUEST_COMPLETED
						end
				end
		end
		
		
	------------------------------------------------
	--	3-4. �����ϱ�
	------------------------------------------------
	if(@questmode_ = @QUEST_MODE_CLEAR)
		begin
			update dbo.tUserMaster
				set
					itemupgradebest = @itemupgradebest, 	itemupgradecnt = @itemupgradecnt,		
					petmatingbest = @petmatingbest,			petmatingcnt = @petmatingcnt,			
					machpointaccrue = @machpointaccrue, 	machpointbest = @machpointbest,			machplaycnt = @machplaycnt,
					mempointaccrue = @mempointaccrue, 		mempointbest = @mempointbest,			memplaycnt =  @memplaycnt,
					friendaddcnt = @friendaddcnt,			friendvisitcnt = @friendvisitcnt,		
					pollhitcnt = @pollhitcnt,				ceilhitcnt = @ceilhitcnt,				boardhitcnt = @boardhitcnt,
					btdistaccrue = @btdistaccrue,			btdistbest = @btdistbest,				bthrcnt = @bthrcnt,
					bthrcombo = @bthrcombo,					btwincnt = @btwincnt,					btwinstreak = @btwinstreak,
					btplaycnt = @btplaycnt,
					spdistaccrue = @spdistaccrue,			spdistbest = @spdistbest,				sphrcnt = @sphrcnt,
					sphrcombo = @sphrcombo,					spwincnt = @spwincnt,					spwinstreak = @spwinstreak,
					spplaycnt = @spplaycnt
			where gameid = @gameid_
		end
	

	------------------------------------------------
	--	3-5. ��������
	------------------------------------------------		
	set nocount off
End

