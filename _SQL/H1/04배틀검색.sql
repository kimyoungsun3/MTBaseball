---------------------------------------------------------------
/*
--select * from dbo.tUserMaster where gameid = 'DD1'
--select * from tBattleLogSearch where gameid = 'SangSang1'
--select isnull(max(btidx), 1) from tBattleLogSearch where gameid = 'SangSang1' and grade = 1
--select isnull(max(btidx), 1) from tBattleLogSearch where gameid = 'SangSang1' and grade = 9
--select isnull(max(btidx), 1) from tBattleLogSearch where gameid = 'SangSang1' and grade = 20

--declare @idx bigint set @idx = 70075
--select top 1 * from dbo.tBattleLog where gameid != 'SangSang' and idx > @idx
--select top 1 * from dbo.tBattleLog where gameid != 'SangSang' and (grade between 1 and 6) and idx > @idx
--select top 1 * from dbo.tBattleLog where gameid != 'SangSang' and idx > @idx and (grade between 1 and 6)
--select top 1 * from dbo.tBattleLog where gameid != 'SangSang' and (grade >= 1 and grade <= 6) and idx > @idx
--select top 1 * from dbo.tBattleLog where gameid != 'SangSang' and idx > @idx and (grade >= 1 and grade <= 6)


[��Ʋ�˻�]
gameid=xxx
btgameid=xxx

-- ������ �˻��ϱ�
-- delete tBattleLogSearchJump where gameid = 'SangSang'
-- delete tBattleLogSearch where gameid = 'SangSang'
select count(*) from tBattleLogSearch
select count(*) from tBattleLogSearch where gameid = 'SangSang'
select count(*) from tBattleLog
select top 10 * from tBattleLog

select * from dbo.tBattleLogSearchJump where gameid = 'parkd'  order by idx desc
select * from dbo.tBattleLogSearch where gameid = 'parkd'  order by idx desc
select * from dbo.tBattleLog where gameid = 'parkd'  order by idx desc
select * from dbo.tUserMaster where gameid = 'parkd'



declare @var int
set @var = 1
while @var < 500
	begin
		exec spu_BattleSearch 'SangSang', '', 5, -1
		set @var = @var + 1
	end

update dbo.tUserMaster set grade = 1  where gameid = 'SangSang'
exec spu_BattleSearch 'SangSang', '', 5, -1			--ó���˻�
exec spu_BattleSearch 'SangSang', 'SangSang5', 5, -1	--���Ӱ˻�
exec spu_BattleSearch 'SangSang', 'DD', 5, -1			--���Ӱ˻� > ����������� > �űԷ��ν�
exec spu_BattleSearch 'SangSang', 'DD6', 5, -1			--���Ӱ˻� > ��������, �α�������� > �űԷ� �ν�

update dbo.tUserMaster set grade = 10  where gameid = 'park'
exec spu_BattleSearch 'parkd', '', 5, -1			--ó���˻�
exec spu_BattleSearch 'parkd', 'leaguefaz', 5, -1	--���Ӱ˻�

update dbo.tUserMaster set grade = 20  where gameid = 'SangSang'
exec spu_BattleSearch 'SangSang', '', 5, -1		--ó���˻�
exec spu_BattleSearch 'SangSang', 'SangSang7', 5,  -1	--���Ӱ˻�

update dbo.tUserMaster set grade = 30  where gameid = 'SangSang'
exec spu_BattleSearch 'SangSang', '', 5, -1			--ó���˻�
exec spu_BattleSearch 'SangSang', 'SangSang20', 5, -1	--���Ӱ˻�

update dbo.tUserMaster set grade = 40  where gameid = 'SangSang'
exec spu_BattleSearch 'SangSang', '', 5, -1			--ó���˻�
exec spu_BattleSearch 'SangSang', 'SangSang19', 5, -1	--���Ӱ˻�

update dbo.tUserMaster set grade = 50, lv = 45 where gameid = 'SangSang'
exec spu_BattleSearch 'SangSang', '', 5, -1			--ó���˻�
exec spu_BattleSearch 'SangSang', 'SangSang44', 5, -1	--���Ӱ˻�

update dbo.tUserMaster set grade = 50, lv = 50  where gameid = 'SangSang'
exec spu_BattleSearch 'SangSang', '', 5, -1			--ó���˻�
exec spu_BattleSearch 'SangSang', 'SangSang12', 5, -1	--���Ӱ˻�


exec spu_BattleSearch 'AAA', '', 5, -1
exec spu_BattleSearch 'superman', '', 5, -1			--ó���˻�
exec spu_BattleSearch 'superman', 'personaways404', 5, -1		--���Ӱ˻�
exec spu_BattleSearch 'superman', '', 6, -1			--ó���˻�
exec spu_BattleSearch 'superman', 'DD1', 6, -1		--���Ӱ˻�

-- 'mogly'
declare @loop int set @loop = 1
while @loop < 10
	begin
		--exec spu_BattleSearch 'superman7', '', 5, 0, -1			--���Ӱ˻� ������ > �ٸ������� ����
		--exec spu_BattleSearch 'superman7', '', 5, 1, -1			--���Ӱ˻� ������ > ó������
		--exec spu_BattleSearch 'superman7', 'superman', 5, 0, -1	--���Ӱ˻� ������ �ٸ������� ����		-- �˻� > ������ �ٸ������˻�(©����� ���� �־� Ȯ����)
		--exec spu_BattleSearch 'superman7', 'superman', 5, 1, -1	--���Ӱ˻� ������ > ó������			-- �˻� > ������ ó������(©����� ���� �־� Ȯ����)

		--exec spu_BattleSearch 'superman7', 'mogly', 5, 0, -1		-- ����ó��
		exec spu_BattleSearch 'superman7', 'mogly', 5, 1, -1
		set @loop = @loop + 1
	end

exec spu_BattleSearch 'superman', 'mogly', 5, 1, -1
http://14.63.218.20:8989/Game4/hlskt/btsearch.jsp?gameid=superman&btgameid=mogly&gmode=5&tmode=1
*/

IF OBJECT_ID ( 'dbo.spu_BattleSearch', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_BattleSearch;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_BattleSearch
	@gameid_								varchar(20),		-- ���Ӿ��̵�
	@btgameid_								varchar(20),
	@gmode_									int,
	@tmode_									int,
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
	declare @GAME_MODE_SPRINT					int				set @GAME_MODE_SPRINT					= 6

	declare @TARGET_MODE_NO						int				set @TARGET_MODE_NO						= 0
	declare @TARGET_MODE_YES					int				set @TARGET_MODE_YES					= 1

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

	declare @FLAG_CHANGE_NO						int 			set @FLAG_CHANGE_NO						= 0
	declare @FLAG_CHANGE_YES					int 			set @FLAG_CHANGE_YES					= 1

	declare @MAX_GRADE							int				set @MAX_GRADE							= 100
	declare @MAX_LV								int				set @MAX_LV								= 100
	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @gameid			varchar(20)
	declare @winstreak		int				set @winstreak 	= 0
	declare @winstreak2		int				set @winstreak2 = 0
	declare @grademax		int
	declare @grade			int				set @grade 		= 1
	declare @lv				int
	declare @btflag			int
	declare @btflag2		int
	declare @flagchange		int				set @flagchange = @FLAG_CHANGE_NO

	declare @grademin2		int
	declare @grademax2		int
	declare @grademax3		int

	declare @btgameid		varchar(20)
	declare @btgrade		int
	declare @btidx			bigint
	declare @btidx2			bigint
	declare @btIdxTotalMax 	bigint

	declare @searchidx		bigint

	declare @kind			int				set @kind = 1
	declare @comment		varchar(80)
	declare @actioncount	int				set @actioncount = 0
	declare	@actionmax		int				set @actionmax = 0
	declare	@doubledate		datetime		set @doubledate = GETDATE()

	declare @blockstate		int


Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on

	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	-- �˻��� �ҷ��� ����
	select
		@gameid 		= gameid, 		@grademax = grademax,
		@blockstate		= blockstate,
		@winstreak		= winstreak,
		@winstreak2		= winstreak2,
		@btflag			= btflag,
		@btflag2		= btflag2,
		@grade 			= grade,  		@lv = lv,
		@doubledate		= doubledate,
		@actioncount 	= actioncount, 	@actionmax = actionmax
	from dbo.tUserMaster where gameid = @gameid_
	--select 'DEBUG1 ', @gameid gameid, @grade grade, @grademax grademax, @winstreak winstreak, @winstreak2 winstreak2


	-- ��� ���� �����ϴ°�?
	if(isnull(@btgameid_, '') != '')
		begin
			declare @e1 int
			set @e1 = -1
			--select 'DEBUG1_2 ������� ����:' + @btgameid_ + ' ��Ʋ�α� > ����Ȯ���غ���?'
			if(exists(select top 1 * from dbo.tUserMaster where gameid = @btgameid_))
				begin
					--select 'DEBUG1_3 ���α� ����?'
					if(exists(select top 1 * from dbo.tBattleLog where gameid = @btgameid_))
						begin
							--select 'DEBUG1_4 �������, �α׵� �Ѱ� �̻�����'
							set @e1 = 1
						end
				end

			if(@e1 != 1)
				begin
					--select 'DEBUG1_5 ��������� �αװ� ������� > ��� ��ó��'
					set @btgameid_ = null
				end
		end

	------------------------------------------------
	--	��Ʋ/������Ʈ ������ -> ���� �ʱ�ȭ
	------------------------------------------------
	if(isnull(@gameid, '') != '')
		begin
			if(@gmode_ = @GAME_MODE_BATTLE and @btflag = @GAME_STATE_PLAYING)
				begin
					--select 'DEBUG2_1 ��Ʋ��� > ������ > Ŭ����'
					set @winstreak 	= 0
					set @btflag 	= @GAME_STATE_END
					set @flagchange = @FLAG_CHANGE_YES
				end
			 else if(@gmode_ = @GAME_MODE_SPRINT and @btflag2 = @GAME_STATE_PLAYING)
				begin
					--select 'DEBUG2_2 ������Ʈ��� > ������ > Ŭ����'
					set @winstreak2 = 0
					set @btflag2 	= @GAME_STATE_END
					set @flagchange = @FLAG_CHANGE_YES
				end
		end

	------------------------------------------------
	--	grade ���� ����1
	------------------------------------------------
	--if(@grademax > 0)
	--	begin
	--		set @grademax3 = @grademax
	--	end
	--else
	--	begin
	--		set @grademax3 = @grademax * (-1)
	--	end
	--set @grademin2 = @grade - (3 + @grademax3)
	--set @grademax2 = @grade + (3 + @grademax3)
	--
	--if(@grademin2 < 1 )
	--	begin
	--		set @grademin2 = 1
	--	end
	--if(@grademax2 > 50 )
	--	begin
	--		set @grademax2 = 50
	--	end
	--
	--if(@grademin2 > @grademax2)
	--	begin
	--		set @grademin2 = @grade - 3
	--		set @grademax2 = @grade + 3
	--	end
	--
	--if(@grade >= 50 and @lv >= 50)
	--	begin
	--		set @grademin2 = 50
	--		set @grademax2 = 50
	--	end
	--select 'DEBUG3 ', @grademin2 grademin2, @grademax2 grademax2

	------------------------------------------------
	--	grade ���� ����2
	------------------------------------------------
	if(@gmode_ = @GAME_MODE_BATTLE)
		begin
			--select 'DEBUG4_1 ��Ʋ���'
			--set @grademin2 = @grade + @winstreak - 3
			--set @grademax2 = @grade + @winstreak + 3

			set @grademin2 = @grade + @winstreak - 10
			set @grademax2 = @grade + @winstreak + 3
		end
	else
		begin
			--select 'DEBUG4_2 ������Ʈ���'
			-- �����
			--set @grademin2 = @grade + @winstreak2 * 1 - 5
			--set @grademax2 = @grade + @winstreak2 * 3

			-- ó���� ���� ������ ��ư� > ��ƴ�.
			--set @grademin2 = @winstreak2 * @winstreak2 * 0.617 + @grade / 3
			--set @grademax2 = @winstreak2 * @winstreak2 * 0.617 + @grade / 3

			-- �������� �յ��ϰ�
			--set @grademin2 = @winstreak2 * @winstreak2 * 0.5 + @grade * 0.6
			--set @grademax2 = @winstreak2 * @winstreak2 * 0.5 + @grade * 0.6

			-- �����Ϳ� 1/2
			set @grademin2 = @winstreak2 * @winstreak2 * 0.2 + @grade * 0.6
			set @grademax2 = @winstreak2 * @winstreak2 * 0.2 + @grade * 0.8
		end
	--select 'DEBUG4_3 ', @grademin2 grademin2, @grademax2 grademax2


	if(@grademin2 < 1 )
		begin
			set @grademin2 = 1
			--select 'DEBUG4_5 ' + str(@grademin2)
		end
	if(@grademax2 > @MAX_GRADE )
		begin
			set @grademax2 = @MAX_GRADE
			--select 'DEBUG4_6 ' + str(@grademax2)
		end
	else if(@grademax2 < 2)
		begin
			set @grademax2 = 2
		end

	if(@grademin2 > @grademax2)
		begin
			set @grademin2 = @grade - 3
			set @grademax2 = @grade + 3
			--select 'DEBUG4_7 ' + str(@grademin2) + ' ~ ' + str(@grademax2)
		end

	if(@grade >= @MAX_GRADE and @lv >= @MAX_LV)
		begin
			set @grademin2 = @MAX_GRADE
			set @grademax2 = @MAX_GRADE
			--select 'DEBUG4_8 ' + str(@grademin2) + ' ~ ' + str(@grademax2)
		end
	--select 'DEBUG4_9 ', @grademin2 grademin2, @grademax2 grademax2

	------------------------------------------------
	--	�޸𸮺���
	------------------------------------------------
	declare @tBattleLog table(
		idxOrder	bigint,
		idx			bigint,
		gameid		varchar(20),
		grade		int,
		gradestar	int,
		lv			int,

		btidx		bigint,
		btgameid	varchar(20),
		btlog		varchar(1024),
		btitem		varchar(16),
		btiteminfo2	varchar(128),			--������
		bttotal2	int,
		btwin2		int,
		btresult	int,
		bthit		int,
		writedate	datetime,

		bttotalpower int,
		bttotalcount int,
		btavg		int
	)

	--���� �˻��� 1�� �˻�
	if(isnull(@gameid, '') != '')
		begin
			--------------------------------------------------------------
			-- �������̵� ���� > gameid����, btgameid���� > �ű�����
			--------------------------------------------------------------
			if(isnull(@btgameid_, '') = '')
				begin
					--select 'DEBUG5_1 �����̵� ����.', @btgameid_ btgameid_
					select @searchidx = searchidx from dbo.tBattleLogSearchJump where gameid = @gameid_ and grade = @grade
					--------------------------------------
					-- �������̵� ������ ����
					--------------------------------------
					if(isnull(@searchidx, -1) != -1)
						begin
							--------------------------------------------------------------
							--select 'DEBUG5_2 �������̵� �����ϸ� ��������!!!' + str(@searchidx)
							delete from dbo.tBattleLogSearchJump
							where gameid = @gameid_ and grade = @grade

							delete from dbo.tBattleLogSearch
							where  gameid = @gameid_ and grade = @grade and btidx >= @searchidx

							----------------------------------------
							set @kind = 2
						end
				end
			else
				begin
					--select 'DEBUG5_3 �����̵�, �α�, ���� �ִ°�?.', @btgameid_ btgameid_
					if(not exists(select top 1 * from tBattleLog where gameid = @btgameid_ and (grade between @grademin2 and @grademax2)))
						begin
							-- �����̵� 	-> ����
							-- ���α�   	-> ����
							-- ���α׹��� -> ����	> �������� Ȯ��
							-- �߰��� �α׸� �߶�Ա��ؼ� �����Ǵ� ��찡 �ִµ� �ϴ�.
							--select 'DEBUG5_5 ���α׹��� -> ����	> �������� Ȯ��', @btgameid_ btgameid_, @grademin2 grademin2, @grademax2 grademax2
							set @grademin2 = 1
							set @grademax2 = @MAX_GRADE
						end
				end



			-------------------------------------------------------------
			-- �˻��Ǵ� ����Ÿ�� ť�� ����Ʈ ���� ������ �����̴�.
			-------------------------------------------------------------
			select @btidx2 = btidx from tBattleLogSearch where gameid = @gameid_ and grade = @grade
			if(isnull(max(@btidx2), -1) = -1)
				begin
					--select 'DEBUG5_10 ����[X]'
					set @btidx2 = 1
				end
			else
				begin
					--select 'DEBUG5_11 ����[O]' + str(@btidx2)
					select @btIdxTotalMax = max(idx) from dbo.tBattleLog
					if(@btidx2 >= @btIdxTotalMax)
						begin
							--select 'DEBUG5_12 @@@@ �˻���ġ �簻��'
							set @btidx2 = 1
						end
				end
		end


	------------------------------------------------
	--	������������
	------------------------------------------------
	-- ������ ���ų� �������� �˻��� ����
	if ((isnull(@gameid, '') = '') or (@blockstate = @BLOCK_STATE_YES))
		begin
			set @nResult_ = @RESULT_ERROR
			set @comment = 'ERROR ������ ������ or ������.'
			--select 'DEBUG7 ���� ����'
		end
	else if(isnull(@btgameid_, '') = '')
		begin
			set @nResult_ = @RESULT_SUCCESS
			if(@gmode_ = @GAME_MODE_BATTLE)
				begin
					set @comment = 'SUCCESS ������ �űԹ�Ʋ�αװ˻�'
					--select 'DEBUG8_1 ������ �űԹ�Ʋ�αװ˻�'
				end
			else
				begin
					set @comment = 'SUCCESS ������ �űԽ�����Ʈ�αװ˻�'
					--select 'DEBUG8_2 ������ �űԽ�����Ʈ�αװ˻�'
				end

			--select 'DEBUG8_3 ������ �ű�', @btidx2 btidx2, @gameid_ gameid_, @grademin2 grademin2, @grademax2 grademax2
			--------------------------------------
			--�˻����� > �α� �˻� > �ӽ����̺� �ֱ�(�Ѱ���)
			--------------------------------------
			insert @tBattleLog
			select top 1 idxOrder, idx, gameid, grade, gradestar, lv, btidx, btgameid, btlog, btitem, btiteminfo, bttotal, btwin, btresult, bthit, writedate, bttotalpower, bttotalcount, btavg
			from dbo.tBattleLog
			where idx > @btidx2
			and gameid != @gameid_
			and (grade between @grademin2 and @grademax2)
			order by newid()
			--����Ÿ�� ������ ��������.

			--select 'DEBUG8_4 ������ �ű�', * from @tBattleLog
			set @kind = 2

		end
	else
		begin
			set @nResult_ = @RESULT_SUCCESS
			if(@gmode_ = @GAME_MODE_BATTLE)
				begin
					set @comment = 'SUCCESS ������ ���ӹ�Ʋ�αװ˻�' + @btgameid_
					--select 'DEBUG9_1 ������ ���ӹ�Ʋ�αװ˻�', @btgameid_ btgameid_
				end
			else
				begin
					set @comment = 'SUCCESS ������ ���ӽ�����Ʈ�αװ˻�' + @btgameid_
					--select 'DEBUG9_2 ������ ���ӽ�����Ʈ�αװ˻�', @btgameid_ btgameid_
				end

			--select 'DEBUG9_3 ������ ����', @btidx2 btidx2, @gameid_ gameid_, @grademin2 grademin2, @grademax2 grademax2, @btgameid_ btgameid_
			--------------------------------------
			--�˻����� > �α� �˻� > �ӽ����̺� �ֱ�
			--------------------------------------
			insert @tBattleLog
			select top 1 idxOrder, idx, gameid, grade, gradestar, lv, btidx, btgameid, btlog, btitem, btiteminfo, bttotal, btwin, btresult, bthit, writedate, bttotalpower, bttotalcount, btavg
			from dbo.tBattleLog
			where gameid != @gameid_ and gameid = @btgameid_
			and (grade between @grademin2 and @grademax2)
			and idx > @btidx2
			order by newid()

			--select 'DEBUG9_4 ������ ����', * from @tBattleLog
			set @kind = 3
		end

	-- ������ ����
	select @nResult_ rtn, @comment, @winstreak winstreak, @winstreak2 winstreak2, @actioncount actioncount, @actionmax actionmax, @doubledate doubledate, @grade grade


	------------------------------------------------
	--	��������ϱ�
	------------------------------------------------
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			-- �˻��� �ȶ߸� ������ Ȯ���ؼ� ��˻�
			if(not exists(select top 1 * from @tBattleLog))
				begin
					--select 'DEBUG10_1 �˻�����Ÿ���� ��˻�'
					-------------------------------------------------
					-- �ѹ����� ���Ҽ� ���̻� �����Ƿ�
					-- ó������ ���� ���ؼ���
					-- �α׸� �����Ѵ�.
					-------------------------------------------------
					delete from dbo.tBattleLogSearch
					where gameid = @gameid_ and grade = @grade

					-------------------------------------------------
					-- ó������ �˻��� �õ��Ѵ�.
					-------------------------------------------------
					set @btidx2 = 1

					-----------------------------------------
					-- �˻������� Ȯ���ؼ�
					-----------------------------------------
					set @grademin2 = @grade - 10
					set @grademax2 = @grade + 5
					if(@grademin2 < 1)
						begin
							set @grademin2 = 1
						end
					if(@grademax2 > @MAX_GRADE)
						begin
							set @grademax2 = @MAX_GRADE
						end

					-----------------------------------------
					-- top 1 ��Ʋ�α� where �����̵����� and grade A ~ B
					-----------------------------------------
					if(@tmode_ = @TARGET_MODE_NO)
						begin
							--select 'DEBUG10_2 �˻�����Ÿ���� ��˻� > ��Ÿ����'

							insert @tBattleLog
							select top 1 idxOrder, idx, gameid, grade, gradestar, lv, btidx, btgameid, btlog, btitem, btiteminfo, bttotal, btwin, btresult, bthit, writedate, bttotalpower, bttotalcount, btavg
							from dbo.tBattleLog
							where idx > @btidx2
							and gameid != @gameid_
							and (grade between @grademin2 and @grademax2)
							order by newid()
							--����Ÿ�� ������ ��������.
						end
					else
						begin
							--select 'DEBUG10_3 �˻�����Ÿ���� ��˻� > Ÿ����'

							insert @tBattleLog
							select top 1 idxOrder, idx, gameid, grade, gradestar, lv, btidx, btgameid, btlog, btitem, btiteminfo, bttotal, btwin, btresult, bthit, writedate, bttotalpower, bttotalcount, btavg
							from dbo.tBattleLog
							where gameid != @gameid_ and gameid = @btgameid_
							and (grade between @grademin2 and @grademax2)
						end
				end

			----------------------------------------------
			-- �ƹ��� �˻��ص� �ȳ����� ���
			----------------------------------------------
			if(not exists(select top 1 * from @tBattleLog))
				begin
					insert @tBattleLog
					select top 1 idxOrder, idx, gameid, grade, gradestar, lv, btidx, btgameid, btlog, btitem, btiteminfo, bttotal, btwin, btresult, bthit, writedate, bttotalpower, bttotalcount, btavg
					from dbo.tBattleLog
					where gameid != @gameid_
					order by newid()
				end

			-----------------------------------------------
			-- �߰��� �����߿� ���� ������ ������ �����ϱ�
			-----------------------------------------------
			--select 'DEBUG11_1 �߰��� �����߿� ���� ������ ������ ���� �ִ°�?'
			if(@flagchange = @FLAG_CHANGE_YES)
				begin
					--select 'DEBUG11_2 > �־� ����'
					update dbo.tUserMaster
						set
							winstreak		= @winstreak,
							winstreak2		= @winstreak2,
							btflag			= @btflag,
							btflag2			= @btflag2
					from dbo.tUserMaster where gameid = @gameid
				end

			-----------------------------------------------
			-- M �˻��αױ��
			--select 'DEBUG11_3 M �˻��αױ��'
			select @btgameid = gameid, @btgrade = grade, @btidx = idx from @tBattleLog

			--select 'DEBUG11_4 ��Ʋ�α� �˻����'
			insert into dbo.tBattleLogSearch(gameid, grade, btgameid, btgrade, btidx)
			values(@gameid, @grade, @btgameid, @btgrade, @btidx)


			-- ��Ʋ��������, �ӽ����̺� �ڵ��Ҹ�
			--select 'DEBUG11_5 ��Ʋ��������, �ӽ����̺� �ڵ��Ҹ�'
			if(@grade > 50)
				begin
					select b.*,
						isnull(u.avatar, 1) avatar,
						isnull(u.picture, '-1') picture,
						isnull(u.ccode, 1) ccode,
						u.bttotal bttotal,
						u.btwin btwin,

						-------------------------------------
						-- ������ �÷����� �αװ�
						-------------------------------------
						b.btiteminfo2 btiteminfo
					from @tBattleLog as b
						left join (select * from dbo.tUserMaster where gameid = @btgameid) as u
						on b.gameid = u.gameid
					--select * from @tBattleLog
					--select * from dbo.tUserMaster where gameid = @btgameid
				end
			else
				begin
					select b.*,
						isnull(u.avatar, 1) avatar,
						isnull(u.picture, '-1') picture,
						isnull(u.ccode, 1) ccode,
						u.bttotal bttotal,
						u.btwin btwin,

						---------------------------------------
						-- ������� ����
						---------------------------------------
						ltrim(rtrim(str(isnull(ccharacter, 0)))) + ',' +
						ltrim(rtrim(str(isnull(face, 50)))) + ',' +
						ltrim(rtrim(str(isnull(cap, 100)))) + ',' +
						ltrim(rtrim(str(isnull(cupper, 200)))) + ',' +
						ltrim(rtrim(str(isnull(cunder, 300)))) + ',' +
						ltrim(rtrim(str(isnull(bat, 400)))) + ',' +
						ltrim(rtrim(str(isnull(pet, -1)))) + ',' +
						ltrim(rtrim(str(isnull(glasses, -1)))) + ',' +
						ltrim(rtrim(str(isnull(wing, -1)))) + ',' +
						ltrim(rtrim(str(isnull(tail, -1)))) + ',' +
						isnull(customize, '1') btiteminfo

						-------------------------------------
						-- ������ �÷����� �αװ�
						-------------------------------------
						-- b.btiteminfo2 btiteminfo
					from @tBattleLog as b
						left join (select * from dbo.tUserMaster where gameid = @btgameid) as u
						on b.gameid = u.gameid
					--select * from @tBattleLog
					--select * from dbo.tUserMaster where gameid = @btgameid
				end


			if(@kind = 3)
				begin
					--------------------------------------
					-- �������̵� ����ϱ�
					--------------------------------------
					--select 'DEBUG12_0 �������̵� ����ϱ�'
					select @searchidx = searchidx from dbo.tBattleLogSearchJump where gameid = @gameid_ and grade = @grade
					if( isnull(@searchidx, -1) = -1)
						begin
							--select 'DEBUG12_1 �������̵� �������!!!' + str(@grade)

							insert into dbo.tBattleLogSearchJump(gameid, grade, searchidx)
							values(@gameid_, @grade, @btidx)
						end
					else
						begin
							--select 'DEBUG12_2 �������̵� ��ϵǾ� �ִ�.' + str(@grade)
							set @grade = @grade
						end
				end

		end

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off
End

