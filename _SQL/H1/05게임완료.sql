---------------------------------------------------------------
/* 
[���ӿϷ�]
gameid=xxx
gmode=GAME_MODE_TRAIN
point=xxx(��Ż�Ÿ�) 
lv=xxx(���緹��)
lvexp=xxx(��Ż����ġ)
gsb=xxx(ȹ���ѽǹ���)
http://210.123.107.7:40002/Game4/hlskt/gend.jsp?gameid=dd1&gmode=2&point=1001&lv=2&lvexp=1&gsb=10
http://210.123.107.7:40002/Game4/hlskt/gend.jsp?gameid=&gmode=&point=&lv=2&lvexp=20&gsb=5
--exec spu_GameEnd 'SangSang', 2, 24,		18, 7,		10,		1, -1, -1, -1, '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1	-- �ӽŸ��
--exec spu_GameEnd 'guest72617', 2, 226,		20, 2,		5,		1, -1, -1, -1, '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1	-- �ӽŸ��

select goldball, silverball, coin, bttem1cnt, bttem2cnt, bttem3cnt, bttem4cnt, bttem5cnt, winstreak, winstreak2, sprintwin from dbo.tUserMaster where gameid = 'SangSang'
update dbo.tUserMaster set trainflag = 1, machineflag = 1, memorialflag	= 1, soulflag = 1, btflag = 1, btflag2 = 1, blockstate = 0, cashcopy = 0, resultcopy = 0 where gameid = 'SangSang'	
--exec spu_GameEnd 'SangSang', 1, 23,		17, 6,		10,		1, -1, -1, -1, '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1	-- �������
--exec spu_GameEnd 'SangSang', 2, 24,		18, 7,		10,		1, -1, -1, -1, '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1	-- �ӽŸ��
--exec spu_GameEnd 'SangSang', 3, 23,		12, 4,		10,		1, -1, -1, -1, '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1	-- �ϱ���
--exec spu_GameEnd 'SangSang', 2, 24,		18, 7,		10,		1, -1, -1, -1, '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1	-- �ӽŸ��(�������)
--exec spu_GameEnd 'SangSang', 4, 44,		15, 4,		10,		1, -1, -1, -1, '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1	-- �ҿ�
--exec spu_GameEnd 'SangSang', 5, 1000,		
exec spu_GameEnd 'SangSang', 6, 1000,		
	21, 8,			-- lvexp, lv
	10,				-- get silver
	2, 1, 2, 1,		-- gradeexp, grade, gradestar, win/lose
	'DD1',			-- ������̵�
	'@1,4600,24,10@1,4800,25,20@1,4900,26,30@1,4000,28,40@1,4100,29,50@1,4200,31,-10@1,4300,33,-20@1,4400,45,-30@1,4500,20,-40',	-- ��Ʈ, �Ŀ�, ��, ����
	'1,0,0,0,0',	-- 1 ~ 5���ۼ���
	'0,50,114,220,313,418,5003,510,610,706,2',	-- ĳ����, ��, �Ӹ�, ����, ����, ��Ʈ, ��, �Ӹ� �Ǽ��縮, ����, ����, Ŀ���� ����¡
	10000, 9, 1000,
	1, 2, 3, 4, 5, 6,
	-1,
	-1	-- ������Ʈ
-- select goldball, silverball, coin, bttem1cnt, bttem2cnt, bttem3cnt, bttem4cnt, bttem5cnt, winstreak, winstreak2, sprintwin from dbo.tUserMaster where gameid = 'SangSang'
-- select goldball, silverball, coin, bttem1cnt, bttem2cnt, bttem3cnt, bttem4cnt, bttem5cnt, winstreak, winstreak2, sprintwin from dbo.tUserMaster where gameid = 'SangSang'
-- select top 20 * from dbo.tBattleLog order by idx desc
delete from dbo.tBattleLog where gameid = 'SangSang'




-- ����
select 
	spdistaccrue, spdistbest, sphrcnt, sphrcombo, spwincnt, spwinstreak, spplaycnt, 
	btdistaccrue, btdistbest, bthrcnt, bthrcombo, btwincnt, btwinstreak, btplaycnt, 
	machpointaccrue, machpointbest, machplaycnt, 
	mempointaccrue, mempointbest, memplaycnt, 
	friendaddcnt, friendvisitcnt, 
	pollhitcnt, ceilhitcnt, boardhitcnt, 
	itemupgradebest, itemupgradecnt, petmatingbest, petmatingcnt 
		from dbo.tUserMaster where gameid = 'superman6'
update dbo.tUserMaster set trainflag = 1, machineflag = 1, memorialflag	= 1, soulflag = 1, btflag = 1, btflag2 = 1, blockstate = 0, cashcopy = 0, resultcopy = 0 where gameid = 'superman6'	
--exec spu_GameEnd 'superman6', 2, 100,		18, 7,		10,		1, -1, -1, -1, '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1	-- �ӽŸ��
--exec spu_GameEnd 'superman6', 3, 250,		12, 4,		10,		1, -1, -1, -1, '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1	-- �ϱ���
--exec spu_GameEnd 'superman6', 5, 1000,		-- gameid, gmode, point																-- ��Ʋ���
exec spu_GameEnd 'superman6', 6, 1000,		-- gameid, gmode, point																-- ������Ʈ
	21, 8,				-- lvexp, lv
	10,					-- get silver
	2, 1, 2, 1,			-- gradeexp, grade, gradestar, btresult(win/lose)
	'DD1',				-- btgameid
	'@1,4600,24,10@1,4800,25,20@1,4900,26,30@1,4000,28,40@1,4100,29,50@1,4200,31,-10@1,4300,33,-20@1,4400,45,-30@1,4500,20,-40',	-- btlog_ ��Ʈ, �Ŀ�, ��, ����
	'1,0,0,0,0',		-- btitem_ 1 ~ 5���ۼ���
	'0,50,114,220,313,418,5003,510,610,706,2',	-- btiteminfo_ ĳ����, ��, �Ӹ�, ����, ����, ��Ʈ, ��, �Ӹ� �Ǽ��縮, ����, ����, Ŀ���� ����¡
	10000, 9, 1000,		-- bttotalpower_, bttotalcount_, btavg_
	1,					-- btsearchidx_
	20, 3, 4, 1, 2, 3,	-- bestdist_, homerun_, homeruncombo_, pollhit_, ceilhit_, boardhit_
	-1					
select 
	spdistaccrue, spdistbest, sphrcnt, sphrcombo, spwincnt, spwinstreak, spplaycnt, 
	btdistaccrue, btdistbest, bthrcnt, bthrcombo, btwincnt, btwinstreak, btplaycnt, 
	machpointaccrue, machpointbest, machplaycnt, 
	mempointaccrue, mempointbest, memplaycnt, 
	friendaddcnt, friendvisitcnt, 
	pollhitcnt, ceilhitcnt, boardhitcnt, 
	itemupgradebest, itemupgradecnt, petmatingbest, petmatingcnt 
		from dbo.tUserMaster where gameid = 'superman6'
select * from dbo.tUserMaster where gameid = 'superman6'
delete from dbo.tBattleLog where gameid = 'superman6'
delete from dbo.tGiftList where gameid = 'superman6'




declare @gameid varchar(20)		set @gameid = 'SangSang'
select * from dbo.tUserMaster where gameid = @gameid
update dbo.tUserMaster set actioncount = actionmax where gameid = 'SangSang'
update dbo.tUserMaster set gradeexp = 3, grade = 1, gradestar = 3 where gameid = 'parkd'

-- 3������
update dbo.tUserMaster set lv = 2, actionCount = actionMax where gameid = 'dd2'
delete from dbo.tGiftList where gameid = 'dd2' and itemcode in (439, 416) and giftid = 'SystemMsg' 
select top 1 * from dbo.tGiftList where gameid = 'dd2' and itemcode in (439, 416) and giftid = 'SystemMsg' 
exec spu_GameStart 'dd2', 2, -1, -1, -1, -1, -1, -1			--�ӽŸ��
exec spu_GameEnd 'dd2', 2, 24,		18, 3,		10,		1, -1, -1, -1, '', '', '', '', 0, 0, 0, '-1', -1	-- �ӽŸ��

--10������
update dbo.tUserMaster set lv = 9, actionCount = actionMax where gameid = 'dd2'
exec spu_GameStart 'dd2', 2, -1, -1, -1, -1, -1, -1			--�ӽŸ��
exec spu_GameEnd 'dd2', 2, 24,		18, 10,		10,		1, -1, -1, -1, '', '', '', '', 0, 0, 0, '-1', -1	-- �ӽŸ��

--���������� �α� ����Ÿ.
exec spu_GameEnd 'dd2', -1, 24,		18, 10,		10,		1, -1, -1, -1, '', '', '', '', 0, 0, 0, '-1', -1
exec spu_GameEnd 'dd99', -2, 24,		18, 10,		10,		1, -1, -1, -1, '', '', '', '', 0, 0, 0, '-1', -1
*/

IF OBJECT_ID ( 'dbo.spu_GameEnd', 'P' ) IS NOT NULL 
    DROP PROCEDURE dbo.spu_GameEnd;
GO 

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_GameEnd
	@gameid_								varchar(20),					-- ���Ӿ��̵�
	@gmode_									int,
	@point_									int,							-- (��Ż�Ÿ�)
	@lvexp_									int,							-- (��Ż����ġ) 
	@lv_									int,							-- (���緹��)
	@gsb_									int,							-- (ȹ���ѽǹ���)
	@gradeexp_								int,							-- (�����Ż����ġ)
	@grade_									int,							-- (���)
	@gradestar_								int,							-- (��޺�)
	@btresult_								int, 							-- ��(1), ��(0)
	@btgameid_								varchar(20),					-- (���ID)
	@btlog_									varchar(1024),					-- (�ý��� ��ȹ������)
	@btitem_								varchar(16),					-- (�����ۼ�������:1,0,0,0,0)
	@btiteminfo_							varchar(128),					-- 0,50,100,200,300,400,500
	@bttotalpower_							int,							-- ��Ʋ��忡�� ��Ż�Ŀ�
	@bttotalcount_							int,							-- ��Ʋ��忡�� ��Ʈ��(������)
	@btavg_									int,							-- ��Ʋ��忡�� ��հ�
	@btsearchidx_							varchar(20),					-- (����ѹ�Ʋidx)
	
	@bestdist_								int,							-- ��Ÿ:�ӽ�(O), �ϱ�(X), ��Ʋ(O), ����(O).(��ȣȭ).
	@homerun_								int,							-- ������ Ȩ������.(��ȣȭ).
	@homeruncombo_							int,							-- ������ Ȩ���޺�.(��ȣȭ).
	@pollhit_								int,							-- ����Ʈ.(��ȣȭ).
	@ceilhit_								int,							-- õ����Ʈ.(��ȣȭ).
	@boardhit_								int,							-- ������Ʈ.(��ȣȭ).
	
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
	declare @ITEM_KIND_PETREWARD				int 			set @ITEM_KIND_PETREWARD				= 98
	declare @ITEM_KIND_GIFTGOLDBALL				int 			set @ITEM_KIND_GIFTGOLDBALL				= 101
	declare @ITEM_KIND_CONGRATULATE_BALL		int 			set @ITEM_KIND_CONGRATULATE_BALL		= 102
	
	-- ���ӽ���
	declare @GAME_MODE_LOGERROR					int				set @GAME_MODE_LOGERROR					= -1
	declare @GAME_MODE_SBCHEAT					int				set @GAME_MODE_SBCHEAT					= -2
	declare @GAME_MODE_TRAINING					int				set @GAME_MODE_TRAINING					= 1
	declare @GAME_MODE_MACHINE					int				set @GAME_MODE_MACHINE					= 2
	declare @GAME_MODE_MEMORISE					int				set @GAME_MODE_MEMORISE					= 3
	declare @GAME_MODE_SOUL						int				set @GAME_MODE_SOUL						= 4
	declare @GAME_MODE_BATTLE					int				set @GAME_MODE_BATTLE					= 5
	declare @GAME_MODE_SPRINT					int				set @GAME_MODE_SPRINT					= 6
	
	-- ��庰 �ൿ�� �Ҹ�
	declare @GAME_MODE_SINGLE_ACTION			int				set @GAME_MODE_SINGLE_ACTION			= 3
	declare @GAME_MODE_BATTLE_ACTION			int				set @GAME_MODE_BATTLE_ACTION			= 5

	-- �����÷��� ��������
	declare @GAME_STATE_END						int				set @GAME_STATE_END						= 0
	declare @GAME_STATE_PLAYING					int				set @GAME_STATE_PLAYING					= 1
	
	-- �����߿� ȹ���ϴ� ��������ġ, ��ް���ġ, ȹ��ǹ�
	declare @GAME_SINGLE_LVEXP					int				set @GAME_SINGLE_LVEXP					= 3
	declare @GAME_BATTLE_LVEXP					int				set @GAME_BATTLE_LVEXP					= 5
	--
	declare @GAME_BATTLE_GRADEEXP				int				set @GAME_BATTLE_GRADEEXP				= 5
	declare @GAME_SINGLE_SILVERBALL_MAX			int				set @GAME_SINGLE_SILVERBALL_MAX			= (800)
	declare @GAME_BATTLE_SILVERBALL_MAX			int				set @GAME_BATTLE_SILVERBALL_MAX			= (800+600)
	
	-- ������ ���޹̼�
	declare @MISSION_LVUP_STEP1					int 			set @MISSION_LVUP_STEP1					= 3
	declare @MISSION_LVUP_STEP2					int 			set @MISSION_LVUP_STEP2					= 10
	declare @MISSION_LVUP_ITEM1_ITEMCODE		int 			set @MISSION_LVUP_ITEM1_ITEMCODE		= 439
	declare @MISSION_LVUP_ITEM2_ITEMCODE		int 			set @MISSION_LVUP_ITEM2_ITEMCODE		= 416
	declare @MISSION_LVUP_ITEM_PERIOD			int 			set @MISSION_LVUP_ITEM_PERIOD			= 7
	declare @SENDER								varchar(20)		set @SENDER								= '����������'
	declare @BATTLE_LIMIT_DISTANCE				int				set @BATTLE_LIMIT_DISTANCE				= 300
	declare @BATTLE_LIMIT_DISTANCE_UNDER		int				set @BATTLE_LIMIT_DISTANCE_UNDER		= 90
	declare @SPRINT_MODE_REWARD_SILVERBALL		int				set @SPRINT_MODE_REWARD_SILVERBALL		= 2500
	
	-- ��Ʋ�� �ʱⰪ
	declare @ITEM_BATTLE_ITEMCODE_INIT			int				set @ITEM_BATTLE_ITEMCODE_INIT			= 6000
	
	-- ������Ʈ���	
	declare @SPRINT_MODE_STEP01					int				set @SPRINT_MODE_STEP01				= 3
	declare @SPRINT_MODE_STEP02					int				set @SPRINT_MODE_STEP02				= 6
	declare @SPRINT_MODE_STEP03					int				set @SPRINT_MODE_STEP03				= 10
	
	declare @SPRINT_MODE_STEP01_REWARD			int				set @SPRINT_MODE_STEP01_REWARD		= 300
	declare @SPRINT_MODE_STEP02_REWARD			int				set @SPRINT_MODE_STEP02_REWARD		= 700
	declare @SPRINT_MODE_STEP03_REWARD			int				set @SPRINT_MODE_STEP03_REWARD		= 2500
	declare @SPRINT_MODE_ITEM_PERIOD2 			int				set @SPRINT_MODE_ITEM_PERIOD2		= 3	--���ϰ� �����ϴ°�?
	
	
	--declare @OBT_END_DATE 					datetime		set @OBT_END_DATE						= '2012-11-18 23:59'

	-- Ÿ���� ����
	declare @LOOP_TIME_ACTION				int 			set @LOOP_TIME_ACTION 				= 3*60			-- �ൿ�� 3�п� �Ѱ��� ä����
	declare @LOOP_TIME_SMS					int 			set @LOOP_TIME_SMS 					= 40*60			-- SMS 40�п� �ѹ���
	declare @LOOP_TIME_FRIENDLS				int 			set @LOOP_TIME_FRIENDLS				= 20*60			-- ģ����Ŀ��ǹ� 20M�п� �Ѱ��� ä����
	
	-- �ڶ��ϱ⸦ ���ؼ� ����ޱ�.
	declare @RESULT_WIN_PUSH_PUSHED				int 			set	@RESULT_WIN_PUSH_PUSHED				= 0
	declare @RESULT_WIN_PUSH_WIN				int 			set	@RESULT_WIN_PUSH_WIN				= 1
	
	-- Open Event
	declare @OPEN_EVENT01_END				datetime		set @OPEN_EVENT01_END				= '2013-01-17'	-- 1.16�ϱ���
	declare @EVENT_NPC_WIN_NAME				varchar(20)		set @EVENT_NPC_WIN_NAME				= 'hakunamatata'
	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @actioncount	int
	declare	@actionmax		int
	declare @actiontime		datetime
	declare @lv				int
	declare @lvexp			int
	declare @grade			int
	declare @gradeexp		int
	declare @gradestar		int
	declare @copysilverball	int							set @copysilverball = @SYSCHECK_YES
	declare @trainflag		int
	declare @machineflag	int
	declare @memorialflag	int
	declare @soulflag		int
	declare @btflag			int
	declare @btflag2		int
	declare @comment		varchar(512)
	declare @bLevelUp		int							set	@bLevelUp = 0
	
	declare @bttotal		int
	declare @btwin			int
	declare @btlose			int

	declare @winstreak		int
	declare @winstreak2		int
	declare @grademax		int

	declare @trainpoint		int
	declare @machinepoint	int
	declare @memorialpoint	int
	declare @soulpoint		int
	
	--������ŷ
	declare @ccode			int
	
	-- �̺�Ʈ���
	declare @eventnpcwin	int							set @eventnpcwin 	= 0
	declare @eventnpccoin	int							set @eventnpccoin 	= 0
	
	--------------------------------------------
	-- ������Ʈ��忡 ���� �����
	--------------------------------------------
	-- �������� ���� ����
	declare @pluslvupgoldball			int				set @pluslvupgoldball 		= 0		--�������� ���� �߰�����.	
	declare @pluslvupitemecode			int				set @pluslvupitemecode		= -1
	declare @plusresultwinpush			int				set @plusresultwinpush 		= @RESULT_WIN_PUSH_PUSHED	
	
	declare @gameid						varchar(20)
	--declare @lv						int
	declare @ccharacter					int
	--declare @winstreak2				int
		
	declare @sprintsilverball			int 			set @sprintsilverball		= 0
	declare @sprintsilverballOrg		int 			set @sprintsilverballOrg	= 0
	declare @sprintbtitemcode			int 			set @sprintbtitemcode 		= -1
	declare @sprintbtitemcnt			int 			set @sprintbtitemcnt 		= 0
	declare @sprintcoin					int 			set @sprintcoin 			= 0
	declare @sprintitemcode				int 			set @sprintitemcode			= -1
	declare @sprintitemname				varchar(80)
	declare @sprintwinplus				int 			set @sprintwinplus			= 0
	declare @sprintstep					int				set @sprintstep				= -1
	declare @sprintitemperiod			int 			set @sprintitemperiod		= 0
	declare @sprintupgradestate2		int 			set @sprintupgradestate2	= 0
		
	--declare @comment					varchar(80)	
	declare @rand						int	
	declare	@doubledate					datetime
	declare @btcomment					varchar(256)	set @btcomment				= ''
	declare @idx						bigint
	
	-- �ҹ���������ȣ
	declare @phone						varchar(20)
	
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR	
	
	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	select 
		@gameid 		= gameid,
		@actioncount 	= actioncount,		@actionmax	= actionmax,	@actiontime		= actiontime,
		@lv				= lv,				@lvexp		= lvexp,
		@ccode			= ccode,
		@grade			= grade,			@gradeexp	= gradeexp,		@gradestar		= gradestar,
		@trainpoint		= trainpoint,
		@machinepoint	= machinepoint,
		@memorialpoint	= memorialpoint,
		@soulpoint		= soulpoint,
		@trainflag		= trainflag,	
		@machineflag	= machineflag, 
		@memorialflag	= memorialflag, 
		@bttotal		= bttotal,			@btwin		= btwin,		@btlose			= btlose,
		@winstreak		= winstreak, 	
		@winstreak2		= winstreak2, 	
		@grademax		= grademax,
		@soulflag		= soulflag, 	
		@btflag			= btflag,
		@btflag2		= btflag2,
		@doubledate		= doubledate,
		@eventnpcwin 	= eventnpcwin,
		@phone			= phone,
		
		@ccharacter		= ccharacter
	from dbo.tUserMaster where gameid = @gameid_
	--select 'DEBUG ������', lv, lvexp, grade, gradeexp, silverball, resultcopy, trainflag, trainpoint, machineflag, machinepoint, memorialflag, memorialpoint, soulflag, soulpoint, btflag, btflag2, bttotal, btwin, btlose, btlose, actioncount, actionmax, actiontime from dbo.tUserMaster where gameid = @gameid_

	------------------------------------------------
	--	������������
	------------------------------------------------
	if isnull(@grade, -1) = -1
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
			select @nResult_ rtn, 'ERROR ������ �������� �ʽ��ϴ�.' comment, @pluslvupgoldball pluslvupgoldball, @sprintsilverballOrg sprintsilverball, @sprintbtitemcode sprintbtitemcode, @sprintbtitemcnt sprintbtitemcnt, @sprintcoin sprintcoin, @sprintitemcode sprintitemcode, @sprintitemperiod sprintitemperiod, @sprintupgradestate2 sprintupgradestate2, @pluslvupitemecode pluslvupitemecode, @doubledate doubledate
			return
		END
	else if(@gmode_ = @GAME_MODE_LOGERROR)
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
			select @nResult_ rtn, 'ERROR �αװ� ���������� �ʽ��ϴ�.' comment, @pluslvupgoldball pluslvupgoldball, @sprintsilverballOrg sprintsilverball, @sprintbtitemcode sprintbtitemcode, @sprintbtitemcnt sprintbtitemcnt, @sprintcoin sprintcoin, @sprintitemcode sprintitemcode, @sprintitemperiod sprintitemperiod, @sprintupgradestate2 sprintupgradestate2, @pluslvupitemecode pluslvupitemecode, @doubledate doubledate
			return
		END
	else if(@gmode_ = @GAME_MODE_SBCHEAT)
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
			select @nResult_ rtn, 'ERROR �ǹ����� ġƮ �ϼ̱���.' comment, @pluslvupgoldball pluslvupgoldball, @sprintsilverballOrg sprintsilverball, @sprintbtitemcode sprintbtitemcode, @sprintbtitemcnt sprintbtitemcnt, @sprintcoin sprintcoin, @sprintitemcode sprintitemcode, @sprintitemperiod sprintitemperiod, @sprintupgradestate2 sprintupgradestate2, @pluslvupitemecode pluslvupitemecode, @doubledate doubledate
			if(exists(select top 1 * from dbo.tUserMaster where gameid = @gameid_))
				begin
					-----------------------------------
					-- �ҹ� �α� ���
					-----------------------------------
					set @comment = '(���Ӱ������)�ǹ����� ġƮ �ϼ̱���.(��ú�ó��)'
					insert into dbo.tUserUnusualLog(gameid, comment) values(@gameid_, @comment)
					
					--update dbo.tUserMaster 
					--set 
					--	resultcopy 		= resultcopy + 1
					--where gameid = @gameid_
					
					-----------------------------------
					-- �ش� ���̵� ��ó��
					-----------------------------------
					update dbo.tUserMaster 
						set 
							blockstate = @BLOCK_STATE_YES
					where gameid = @gameid_
					
					-----------------------------------
					-- �ش� ���̵� ��ó��		
					-----------------------------------
					insert into dbo.tUserBlockLog(gameid, comment)							
					values(@gameid_, @comment)
					
					-----------------------------------
					-- ����ȣ �ҹ�ó��
					-----------------------------------
					if(@phone != '')
						begin
							insert into dbo.tUserBlockPhone(phone, comment) values(@phone, @comment)
						end
				end
			return
		END



	-----------------------------------------------
	--	�ൿ�� > �þ �ð��ΰ�? �˻� > ����
	-----------------------------------------------
	-- select * from tUserMaster where gameid = 'SangSang'
	declare @nActPerMin bigint,
			@nActCount int, 					
			@dActTime datetime
	set @nActPerMin = @LOOP_TIME_ACTION						-- �ൿ�� 2�п� �Ѱ��� ä����
	set @nActCount = datediff(s, @actiontime, getdate())/@nActPerMin
	set @dActTime = DATEADD(s, @nActCount*@nActPerMin, @actiontime)
	set @actioncount = @actioncount + @nActCount
	set @actioncount = case when @actioncount > @actionmax then @actionmax else @actioncount end
	----select 'DEBUG �ൿġ����', @actiontime '���Žð���', getdate() '����ð�', @nActCount '�߰��ൿġ', @actioncount '�����ൿġ(�ð���)', @actionmax '�ൿġ�ƽ���', @dActTime '���Žð�'
	
	-----------------------------------------------
	-- ��Ÿ ���� ����
	-----------------------------------------------
	declare @dateid 	varchar(6)
	declare @dateid8 	varchar(8)
	set @dateid = Convert(varchar(6),Getdate(),112)		-- 201208
	set @dateid8 = Convert(varchar(8),Getdate(),112)	-- 20120809
	
	-----------------------------------------------
	--	����, �׷��̵�
	-----------------------------------------------
	-- ������ > ������, �ൿġ�ƽ�, �ൿġFull
	if(@lv_ = @lv + 1)
		begin
			set @lv = @lv_
			set @actionmax = 25 + (@lv/2)
			set @actioncount = @actionmax
			--select 'DEBUG ������', @lv lv, @actionmax actionmax, @actioncount actioncount

			-----------------------------------------------
			-- 2���� +1 ��纼����
			-- 1, 2, 3, 4, 5, 6, 7  ...
			-- 0  1  0  1  0  1  0  ...	> 25�� ����
			-----------------------------------------------
			--if(@lv_ % 2 = 0)
			--	begin
			--		--select 'DEBUG �������� ���� �߰� ��纼'
			--		-- set @pluslvupgoldball = 1	> �α��� ���ϸ� �������� �ٲ�
			--		set @pluslvupgoldball = 0
			--	end		
			-- OBT ��	
			--if(getdate() < @OBT_END_DATE)
			--	begin
			--		set @pluslvupgoldball	= 10
			--	end

			----------------------------------------------------
			-- ������ ������ ��� �������� �����ϱ�
			----------------------------------------------------
			if(@lv_ = @MISSION_LVUP_STEP1)
				begin
					--select 'DEBUG 3��������'
					set @pluslvupitemecode = @MISSION_LVUP_ITEM1_ITEMCODE
				end
			else if(@lv_ = @MISSION_LVUP_STEP2)
				begin
					--select 'DEBUG 10��������'
					set @pluslvupitemecode = @MISSION_LVUP_ITEM2_ITEMCODE
				end
		end


	-- ��������ġ > ������ġ������ ���Ѵ�.
	if(@lvexp_ >= @lvexp and @lvexp_ <= @lvexp + @GAME_BATTLE_LVEXP)
		begin
			--select 'DEBUG ��������ġ ������ ' + str(@lvexp) + ' > ' + str(@lvexp_)
			set @lvexp = @lvexp_
		end
	
	-----------------------------------------------
	--	��Ʋ��� > �׷��̵�, �׷��̵����ġ, ��,��,����
	-----------------------------------------------
	if(@gmode_ in (@GAME_MODE_BATTLE, @GAME_MODE_SPRINT))
		begin	
			--select 'DEBUG ��Ʋ��屸��'
			-- �׷��̵�� > �׷��̵��
			if(@grade_ >= @grade - 1 and @grade_ <= @grade + 1)
				begin
					set @grade = @grade_
					--select 'DEBUG (��Ʋ)�׷��̵巹�� ������ ' + str(@grade) + ' > ' + str(@grade_)
				end

			-- �׷��̵����ġ > �׷��̵����ġ
			if(@gradeexp_ >= @gradeexp - @GAME_BATTLE_GRADEEXP and @gradeexp_ <= @gradeexp + @GAME_BATTLE_GRADEEXP)
				begin
					set @gradeexp = @gradeexp_
					--select 'DEBUG (��Ʋ)�׷��̵����ġ ������ ' + str(@gradeexp) + ' > ' + str(@gradeexp_)
				end
			
			-- �׷��̵彺Ÿ
			if(@gradestar_ >= 0 and @gradestar_ <=5)
				begin
					set @gradestar = @gradestar_
				end
				
			if(@btresult_ = 1)
				begin
					--select 'DEBUG (��Ʋ) ����� ' + str(@btwin)
					set	@btwin	= @btwin + 1
					set @plusresultwinpush = @RESULT_WIN_PUSH_WIN
					if(@gmode_ = @GAME_MODE_BATTLE)
						begin
							if(@winstreak < 0)
								begin 
									set @winstreak = 0
								end
								
							set @winstreak = @winstreak + 1
						end
					else
						begin
							set @winstreak2 = @winstreak2 + 1
						end
					
				end
			else
				begin
					--select 'DEBUG (��Ʋ) �����' + str(@btlose)
					set	@btlose	= @btlose + 1
					if(@gmode_ = @GAME_MODE_BATTLE)
						begin
							set @winstreak = 0
							--Ŭ���̾�Ʈ�� ���װ� �־ -�� ����ϸ� �ȵȴ�.
							--set @winstreak = @winstreak - 1
						end
					else
						begin
							-- ������Ʈ ������ �ϸ� ����� 1/2�� ���� ����
							set @sprintsilverball = 0
							if(@winstreak2 >= @SPRINT_MODE_STEP01)
								begin
									if(@winstreak2 < @SPRINT_MODE_STEP02)
										begin
											--select 'DEBUG 1�ܰ� 3�º���'
											set @sprintsilverball = @SPRINT_MODE_STEP01_REWARD / 2
										end
									else if(@winstreak2 < @SPRINT_MODE_STEP03)
										begin
											--select 'DEBUG 2�ܰ�  7�º���'
											set @sprintsilverball = @SPRINT_MODE_STEP02_REWARD / 2
										end
									else
										begin
											--select 'DEBUG 3�ܰ�  10�º���'
											set @sprintsilverball = @SPRINT_MODE_STEP03_REWARD / 2
										end
								end
							set @winstreak2 = 0
						end
					
				end
			
			--��Ʋ�� ���� ���� ����
			if(@gmode_ = @GAME_MODE_BATTLE)
				begin
					if(@winstreak > 5)
						begin
							set @winstreak = 5
						end
				end
			else
				begin 
					if(@winstreak2 >= 10)
						begin
							------------------------------------------
							-- (��Ʋ�Ϸ�/������Ʈ ����� ����)							-- 
							-- ������Ʈ ���� �ִ� �ҽ� �״��
							------------------------------------------
							--select 'DEBUG 3�ܰ�  10�º���'
							set @sprintsilverball = @SPRINT_MODE_STEP03_REWARD
							set @sprintbtitemcode = @ITEM_BATTLE_ITEMCODE_INIT + (Convert(int, ceiling(RAND() * 5)) - 1) -- 0 ~ 4
							set @sprintbtitemcnt 	= 3
							set @sprintcoin			= 2
							set @sprintstep			= @SPRINT_MODE_STEP03
							set @sprintitemperiod	= @SPRINT_MODE_ITEM_PERIOD2	
							set @sprintupgradestate2 = (0 + Convert(int, ceiling(RAND() * 17)))
							-- ��ȭ��ġ
							set @rand = Convert(int, ceiling(RAND() *  100))
							if(@rand < 85)
								begin
									set @sprintupgradestate2 = (4 + Convert(int, ceiling(RAND() *  5)) - 1)
								end
							else if(@rand < 98)
								begin
									set @sprintupgradestate2 = (8 + Convert(int, ceiling(RAND() *  5)) - 1)
								end
							else
								begin
									set @sprintupgradestate2 = (12 + Convert(int, ceiling(RAND() *  5)) - 1)
								end
							
							-------------------------------------
							-- ������ �����ϱ�
							-------------------------------------
							-- select top 1 * from dbo.tItemInfo where param7 = @ccharacter and kind in (2, 4, 5, 6) and silverball > 0 and silverball < 2000 order by newid()
							select top 1 @sprintitemcode = itemcode, @sprintitemname = itemname from dbo.tItemInfo 
							where ((param7 = @ccharacter and kind in (@ITEM_KIND_CAP, @ITEM_KIND_UPPER, @ITEM_KIND_UNDER) and sex != 0) or (sex = 255 and kind = @ITEM_KIND_BAT))
							and silverball > 0 and silverball < (2000 + @lv*125)
							and lv < @lv + 10
							and itemcode not in (
								153, 154, 156, 157, 161, 162, 163, 164,
								253, 254, 256, 257, 261, 262, 263, 264,
								353, 354, 356, 357, 361, 362, 363, 364, 
								455, 456, 457, 458, 459, 460, 461, 462)
							--and sex != 0
							order by newid()
							
							-------------------------------
							-- 1-1. 10���� > ����Ŭ����, 10�� ȸ��
							-------------------------------			
							set @winstreak2 	= 0
							set @sprintwinplus	= 1
							
							
						end
				end
				
			if(@grade > @grademax)
				begin
					set @grademax = @grade
				end
		end
	-----------------------------------------------
	--	������ �ǹ�ȹ��
	-----------------------------------------------
	if(@gmode_ not in (@GAME_MODE_BATTLE, @GAME_MODE_SPRINT))
		begin
			if(@gsb_ < 0)
				begin
					set @gsb_ = 0
				end
			else if(@gsb_ > @GAME_SINGLE_SILVERBALL_MAX)
				begin
					set @gsb_ = @GAME_SINGLE_SILVERBALL_MAX
					set @btcomment = @btcomment + '�̱� �ƽ��ʰ�'
				end
		end
	else
		begin
			if(@gsb_ < 0)
				begin
					set @gsb_ = 0
				end
			else if(@gsb_ > @GAME_BATTLE_SILVERBALL_MAX)
				begin
					set @gsb_ = @GAME_BATTLE_SILVERBALL_MAX
					set @btcomment = @btcomment + '��Ʋ �ƽ��ʰ�'
				end
		end
	
	-----------------------------------------------
	--	�������̸� 2��� �����Ѵ�.
	-----------------------------------------------
	set @sprintsilverballOrg = @sprintsilverball
	if(getdate() < @doubledate)
		begin
			--select 'DEBUG ������'
			set @gsb_ = @gsb_ * 2
			set @sprintsilverball = @sprintsilverball * 2
			set @btcomment = @btcomment + '�ι����۵�'
		end
	--else
	--	begin
	--		select 'DEBUG �Ϲݸ��'
	--	end
	


	-----------------------------------------------
	--	�̺�Ʈ �Ⱓ ���� ��Ŀ�� ���� +10������
	-----------------------------------------------
	if(getdate() < @OPEN_EVENT01_END and @gmode_ in (@GAME_MODE_BATTLE, @GAME_MODE_SPRINT))
		begin
			-- �¸� and �����޻��� and NPC
			if(@btresult_ = 1 and @eventnpcwin = 0 and @btgameid_ = @EVENT_NPC_WIN_NAME)
				begin				
					set @eventnpcwin = 1
					set @eventnpccoin = 10	
				end
		end
	
	-----------------------------------------------
	--	��庰 ������
	-----------------------------------------------		
	IF (@gmode_ = @GAME_MODE_TRAINING) 
		BEGIN	
			if(@trainflag = @GAME_STATE_PLAYING)
				begin
					--select 'DEBUG ������� ����ó��'
					set @comment = '������� ����ó��'					
					set @copysilverball = @SYSCHECK_NON
					
					if(@point_ > @trainpoint)
						begin
							--select 'DEBUG ��������' + str(@trainpoint) + ' > ' + str(@point_)
							set @trainpoint = @point_
						end
				end
			else
				begin
					--select 'DEBUG ������� ī�ǽõ� > ���ī�ǽõ�+1, 1������������ �ൿ�αױ��'
					set @comment = '������� ī�ǽõ� > ���ī�ǽõ�+1, 1������������ �ൿ�αױ��'
				end
		END
	ELSE IF(@gmode_ = @GAME_MODE_MACHINE)
		BEGIN	
			if(@machineflag = @GAME_STATE_PLAYING)
				begin
					--select 'DEBUG �ӽŸ�� ����ó��'
					set @comment = '�ӽŸ�� ����ó��'
					set @copysilverball = @SYSCHECK_NON
					
					if(@point_ > @machinepoint)
						begin
							--select 'DEBUG ��������' + str(@machinepoint) + ' > ' + str(@point_)
							set @machinepoint = @point_
						end
				end
			else
				begin
					--select 'DEBUG �ӽŸ�� ī�ǽõ� > ���ī�ǽõ�+1, 1������������ �ൿ�αױ��'
					set @comment = '�ӽŸ�� ī�ǽõ� > ���ī�ǽõ�+1, 1������������ �ൿ�αױ��'
				end
		END
	ELSE IF(@gmode_ = @GAME_MODE_MEMORISE)
		BEGIN	
			if(@memorialflag = @GAME_STATE_PLAYING)
				begin
					--select 'DEBUG �ϱ��� ����ó��'
					set @comment = '�ϱ��� ����ó��'
					set @copysilverball = @SYSCHECK_NON
					
					if(@point_ > @memorialpoint)
						begin
							--select 'DEBUG ��������' + str(@memorialpoint) + ' > ' + str(@point_)
							set @memorialpoint = @point_
						end
				end
			else
				begin
					--select 'DEBUG �ϱ��� ī�ǽõ� > ���ī�ǽõ�+1, 1������������ �ൿ�αױ��'
					set @comment = '�ϱ��� ī�ǽõ� > ���ī�ǽõ�+1, 1������������ �ൿ�αױ��'
				end
		END
	ELSE IF(@gmode_ = @GAME_MODE_SOUL)
		BEGIN	 
			if(@soulflag = @GAME_STATE_PLAYING)
				begin
					--select 'DEBUG �ҿ��� ����ó��'
					set @comment = '�ҿ��� ����ó��'
					set @copysilverball = @SYSCHECK_NON

					if(@point_ > @soulpoint)
						begin
							--select 'DEBUG ��������' + str(@soulpoint) + ' > ' + str(@point_)
							set @soulpoint = @point_
						end
				end
			else
				begin
					--select 'DEBUG �ҿ��� ī�ǽõ� > ���ī�ǽõ�+1, 1������������ �ൿ�αױ��'
					set @comment = '�ҿ��� ī�ǽõ� > ���ī�ǽõ�+1, 1������������ �ൿ�αױ��'
				end
		END
	ELSE IF(@gmode_ in (@GAME_MODE_BATTLE, @GAME_MODE_SPRINT))
		BEGIN	
			if((@gmode_ = @GAME_MODE_BATTLE and @btflag = @GAME_STATE_PLAYING) or (@gmode_ = @GAME_MODE_SPRINT and @btflag2 = @GAME_STATE_PLAYING))
				begin
					--select 'DEBUG ��Ʋ��� ����ó��'
					IF(@gmode_ = @GAME_MODE_BATTLE)
						begin
							set @comment = '��Ʋ��� ����ó��'
						end
					else
						begin
							set @comment = '������Ʈ��� ����ó��'
						end
					set @copysilverball = @SYSCHECK_NON

					-- ��Ʋ�� �ִ�Ÿ������ ����.	
					-- ���и� �����Ѵ�.
					
					-- ��Ʋ�α׵���Ÿ���, ��Ż�Ÿ��� �����Ÿ� �̻� ���
					if(@point_ >= @BATTLE_LIMIT_DISTANCE)
						begin						
							---------------------------------------------------
							--select 'DEBUG �ε��� �ߺ��浹 ���ϱ�'
							-- Ű�� Ŭ������ �ε��� Ű�̴�.
							-- 1������ > (�浹) > 2������ > (�浹) > 3������ > (�浹) > 4��
							---------------------------------------------------
							set @idx = abs(checksum(newid()))
							if(exists(select * from tBattleLog where idx = @idx))
								begin
									--select 'DEBUG 1���浹 > 2������', @idx
									set @idx = abs(checksum(newid()))
									if(exists(select * from tBattleLog where idx = @idx))
										begin
											--select 'DEBUG 2���浹 > 3������', @idx
											set @idx = abs(checksum(newid()))
											if(exists(select * from tBattleLog where idx = @idx))
												begin
													--select 'DEBUG 3���浹 > 4������', @idx
													set @idx = abs(checksum(newid()))
												end
										end
								end
												
						
							---------------------------------------------------
							--select 'DEBUG �αױ���ϱ�'
							---------------------------------------------------
							insert into dbo.tBattleLog(idx,  	gameid,	  grade,  gradestar,  lv,  btgameid,	 btlog,   btitem,   btiteminfo,   bttotal,  btwin,  btresult,	bthit,  bttotalpower,    bttotalcount,   btavg,   btidx, 			btsb, 	btmode, 	winstreak, 	winstreak2, btcomment)
							values(                    @idx, 	@gameid_, @grade, @gradestar, @lv, @btgameid_,	@btlog_, @btitem_, @btiteminfo_, @bttotal, @btwin, @btresult_, @point_, @bttotalpower_, @bttotalcount_, @btavg_, @btsearchidx_, 	@gsb_, @gmode_, @winstreak, @winstreak2, @btcomment)
							
							
							---------------------------------------------------
							-- �����¼�����ϱ�.
							---------------------------------------------------
							declare @cwin 		int		
							declare @close		int 	
							if(@btresult_ = 1)
								begin
									set @cwin = 1
									set @close = 0
								end
							else
								begin
									set @cwin = 0
									set @close = 1
								end
							
							if(exists(select * from dbo.tBattleCountry where dateid = @dateid and ccode = @ccode))
								begin
									update dbo.tBattleCountry 
										set 
											win = win + @cwin ,
											lose = lose + @close
									where dateid = @dateid and ccode = @ccode
								end
							else
								begin
									insert into dbo.tBattleCountry(dateid, ccode, win, lose) values(@dateid, @ccode, @cwin, @close)
								end
							
						end
					--else if(@point_ >= @BATTLE_LIMIT_DISTANCE_UNDER)
					--	begin
					--		--select 'DEBUG Under�αױ���ϱ�'
					--		insert into dbo.tBattleLogUnder( gameid,	  grade,  gradestar,  lv,  btgameid,	 btlog,   btitem,   btiteminfo,   bttotal,  btwin,  btresult,	bthit,  bttotalpower,    bttotalcount,   btavg,   btidx)
					--		values(                         @gameid_, @grade, @gradestar, @lv, @btgameid_,	@btlog_, @btitem_, @btiteminfo_, @bttotal, @btwin, @btresult_, @point_, @bttotalpower_, @bttotalcount_, @btavg_, @btsearchidx_)
					--	end

				end
			else
				begin
					--select 'DEBUG ��Ʋ��� ī�ǽõ� > ���ī�ǽõ�+1, 1������������ �ൿ�αױ��'
					IF(@gmode_ in (@GAME_MODE_BATTLE))
						begin
							set @comment = '��Ʋ��� ī�ǽõ� > ���ī�ǽõ�+1, 1������������ �ൿ�αױ��'
						end
					else
						begin
							set @comment = '������Ʈ��� ī�ǽõ� > ���ī�ǽõ�+1, 1������������ �ൿ�αױ��'
						end
				end
		END


	-----------------------------------------------
	--	�ǹ��� ī�ǽõ����� Ȯ��
	-----------------------------------------------		
	IF (@copysilverball = @SYSCHECK_NON) 
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			select @nResult_ rtn, 'SUCCESS ' + @comment comment, @pluslvupgoldball pluslvupgoldball, @sprintsilverballOrg sprintsilverball, @sprintbtitemcode sprintbtitemcode, @sprintbtitemcnt sprintbtitemcnt, @sprintcoin sprintcoin, @sprintitemcode sprintitemcode, @sprintitemperiod sprintitemperiod, @sprintupgradestate2 sprintupgradestate2, @pluslvupitemecode pluslvupitemecode, @doubledate doubledate
			
			-----------------------------------------------
			--	����, �׷��̵�, ���÷���, �ൿġ
			-----------------------------------------------
			update dbo.tUserMaster 
			set
				-- �̺�Ʈ
				eventnpcwin 	= @eventnpcwin,
				
				lv				= @lv,
				lvexp			= @lvexp,
				grade			= @grade,
				gradeexp		= @gradeexp,
				gradestar		= @gradestar,
				
				trainpoint		= @trainpoint,
				machinepoint	= @machinepoint,
				memorialpoint	= @memorialpoint,
				soulpoint		= @soulpoint,
		
				trainflag		= case @gmode_ when @GAME_MODE_TRAINING 	then @GAME_STATE_END else trainflag end,
				machineflag		= case @gmode_ when @GAME_MODE_MACHINE 		then @GAME_STATE_END else machineflag end,
				memorialflag	= case @gmode_ when @GAME_MODE_MEMORISE 	then @GAME_STATE_END else memorialflag end,
				soulflag		= case @gmode_ when @GAME_MODE_SOUL 		then @GAME_STATE_END else soulflag end,
				btflag			= case @gmode_ when @GAME_MODE_BATTLE 		then @GAME_STATE_END else btflag end,
				btflag2			= case @gmode_ when @GAME_MODE_SPRINT 		then @GAME_STATE_END else btflag2 end,
				
				btwin			= @btwin,								--������ �������� ���ߴ�.
				btlose			= @btlose,

				winstreak		= @winstreak,							-- ��Ʋ����
				grademax		= @grademax,
									
				goldball		= goldball + @pluslvupgoldball,			-- ������ ����
				
				resultwinpush	= @plusresultwinpush,					-- ��(1), Ǫ��(0)
				
				winstreak2		= @winstreak2,							-- ������Ʈ����
				silverball		= silverball + @gsb_ + @sprintsilverball,	
				coin			= coin + @sprintcoin + @eventnpccoin,
				bttem1cnt 		= bttem1cnt + case when(@sprintbtitemcode = 6000) then @sprintbtitemcnt else 0 end,
				bttem2cnt 		= bttem2cnt + case when(@sprintbtitemcode = 6001) then @sprintbtitemcnt else 0 end,
				bttem3cnt 		= bttem3cnt + case when(@sprintbtitemcode = 6002) then @sprintbtitemcnt else 0 end,
				bttem4cnt 		= bttem4cnt + case when(@sprintbtitemcode = 6003) then @sprintbtitemcnt else 0 end,
				bttem5cnt 		= bttem5cnt + case when(@sprintbtitemcode = 6004) then @sprintbtitemcnt else 0 end,
				sprintwin		= sprintwin + @sprintwinplus,
		
				actioncount		= @actioncount,			-- �ൿ�� ����
				actionmax		= @actionmax,
				actiontime		= @dActTime,
				
				-- ���ϴ� ����Ʈ ���� ����Ÿ
				machpointaccrue = case @gmode_ 	when @GAME_MODE_MACHINE 											then machpointaccrue + @point_ 	else machpointaccrue end,
				machpointbest 	= case 			when (@gmode_ = @GAME_MODE_MACHINE and @point_ > machpointbest) 	then @point_ 					else machpointbest end,
				machplaycnt		= case @gmode_ 	when @GAME_MODE_MACHINE 											then machplaycnt + 1 			else machplaycnt end,
				
				mempointaccrue 	= case @gmode_ 	when @GAME_MODE_MEMORISE 											then mempointaccrue + @point_ 	else mempointaccrue end,
				mempointbest 	= case 			when (@gmode_ = @GAME_MODE_MEMORISE and @point_ > mempointbest) 	then @point_ 					else mempointbest end,
				memplaycnt		= case @gmode_ 	when @GAME_MODE_MEMORISE 											then memplaycnt + 1 			else memplaycnt end,
				
				pollhitcnt 		= pollhitcnt + @pollhit_,  
				ceilhitcnt 		= ceilhitcnt + @ceilhit_, 
				boardhitcnt 	= boardhitcnt + @boardhit_, 
				  								
				btdistaccrue 	= case when (@gmode_ = @GAME_MODE_BATTLE)									then btdistaccrue + @point_ 	else btdistaccrue end,	
				btdistbest 		= case when (@gmode_ = @GAME_MODE_BATTLE and @bestdist_ > btdistbest) 		then @bestdist_ 				else btdistbest end,
				bthrcnt 		= case when (@gmode_ = @GAME_MODE_BATTLE)									then bthrcnt + @homerun_	 	else bthrcnt end,	
				bthrcombo 		= case when (@gmode_ = @GAME_MODE_BATTLE and @homeruncombo_ > bthrcombo)	then @homeruncombo_ 			else bthrcombo end,
				btwincnt 		= case when (@gmode_ = @GAME_MODE_BATTLE and @btresult_ = 1)				then btwincnt + 1 				else btwincnt end,
				btwinstreak 	= case when (@gmode_ = @GAME_MODE_BATTLE and @winstreak > btwinstreak)		then @winstreak 				else btwinstreak end,
				btplaycnt		= case when (@gmode_ = @GAME_MODE_BATTLE) 									then btplaycnt + 1 				else btplaycnt end,
				
				
				spdistaccrue 	= case when (@gmode_ = @GAME_MODE_SPRINT)									then spdistaccrue + @point_ 	else spdistaccrue end,	
				spdistbest 		= case when (@gmode_ = @GAME_MODE_SPRINT and @bestdist_ > spdistbest) 		then @bestdist_ 				else spdistbest end,
				sphrcnt 		= case when (@gmode_ = @GAME_MODE_SPRINT)									then sphrcnt + @homerun_	 	else sphrcnt end,	
				sphrcombo 		= case when (@gmode_ = @GAME_MODE_SPRINT and @homeruncombo_ > sphrcombo)	then @homeruncombo_ 			else sphrcombo end,
				spwincnt 		= case when (@gmode_ = @GAME_MODE_SPRINT and @btresult_ = 1)				then spwincnt + 1 				else spwincnt end,
				spwinstreak 	= case 
										when (@gmode_ = @GAME_MODE_SPRINT and @sprintwinplus	= 1)		then 10
										when (@gmode_ = @GAME_MODE_SPRINT and @winstreak2 > spwinstreak)	then @winstreak2 				else spwinstreak end,
				spplaycnt		= case when (@gmode_ = @GAME_MODE_SPRINT) 									then spplaycnt + 1 				else spplaycnt end
			where gameid = @gameid_
			
				
				
				
				
				
			
			
			----------------------------------------------------
			-- ������ ������ ��� �������� �����ϱ�
			----------------------------------------------------
			if(@pluslvupitemecode != -1)
				begin
					--select 'DEBUG ��������'
					if(not exists(select top 1 * from dbo.tGiftList where gameid = @gameid_ and itemcode = @pluslvupitemecode and giftid = @SENDER ))
						begin
							--select 'DEBUG �������� > ������ ����'
							insert into dbo.tGiftList(gameid, itemcode, giftid, period2) 
							values(@gameid_ , @pluslvupitemecode, @SENDER, @MISSION_LVUP_ITEM_PERIOD);

							--������ ����ϱ�.
							-- declare @itemcode_ int		set @itemcode_ = 101
							declare @itemname		varchar(80)
							select @itemname = itemname from dbo.tItemInfo where itemcode = @pluslvupitemecode

							insert into tMessage(gameid, comment) 
							values(@gameid_, '������ �޼�:' + @itemname + '�� ���� �޾ҽ��ϴ�.(' + ltrim(rtrim(@MISSION_LVUP_ITEM_PERIOD)) +'��)' )
						end
				end
				
				
			----------------------------------------------------
			-- ������Ʈ ��忡�� ��� ������
			----------------------------------------------------
			if(@sprintitemcode != -1)
				begin
					-- select 'DEBUG �������޵�' + str(@sprintitemcode)
					-- select @period2 = period from dbo.tItemInfo where itemcode = @sprintitemcode
					
					insert into dbo.tGiftList(gameid, itemcode, giftid, period2, upgradestate2)
					values(@gameid_ , @sprintitemcode, '������Ʈ����', @sprintitemperiod, @sprintupgradestate2)
					
					
					insert into tMessage(gameid, comment) 
					values(@gameid_, '������Ʈ ���´޼����� :' + @sprintitemname + '�� ���� �޾ҽ��ϴ�.(' + ltrim(rtrim(@SPRINT_MODE_ITEM_PERIOD2)) +'��)' )
				end
			
				
			----------------------------------------------------
			-- ��庰 �������� ����
			----------------------------------------------------
			if(exists(select * from dbo.tUserGameMode where dateid = @dateid8 and gmode = @gmode_))
				begin
					
					update dbo.tUserGameMode 
						set 							
							playcnt = playcnt + 1
					where dateid = @dateid8 and gmode = @gmode_
				end
			else
				begin
					insert into dbo.tUserGameMode(dateid, gmode, playcnt) values(@dateid8, @gmode_, 1)
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
			

		END
	ELSE
		BEGIN	
			set @nResult_ = @RESULT_ERROR_RESULT_COPY
			select @nResult_ rtn, 'ERROR' + @comment comment, @pluslvupgoldball pluslvupgoldball, @sprintsilverballOrg sprintsilverball, @sprintbtitemcode sprintbtitemcode, @sprintbtitemcnt sprintbtitemcnt, @sprintcoin sprintcoin, @sprintitemcode sprintitemcode, @sprintitemperiod sprintitemperiod, @sprintupgradestate2 sprintupgradestate2, @pluslvupitemecode pluslvupitemecode, @doubledate doubledate
			
			
			---------------------------------------------------
			--	ī���÷��� ���, �α� ���
			---------------------------------------------------
			update dbo.tUserMaster 
			set 
				actioncount		= @actioncount,			-- �ൿ�� ����
				actiontime		= @dActTime,
				resultcopy 		= resultcopy + 1
			where gameid = @gameid_
						
			insert into dbo.tUserUnusualLog(gameid, comment) values(@gameid_, @comment)
		END
		
	--select 'DEBUG ������', lv, lvexp, grade, gradeexp, gradestar, silverball, resultcopy, trainflag, trainpoint, machineflag, machinepoint, memorialflag, memorialpoint, soulflag, soulpoint, btflag, btflag2, bttotal, btwin, btlose, btlose, actioncount, actionmax, actiontime from dbo.tUserMaster where gameid = @gameid_
	
	-------------------------------------------------
	-- ��������
	-- declare @gameid_ varchar(20) set @gameid_ = 'SangSang'
	-------------------------------------------------
	select * from dbo.tUserMaster where gameid = @gameid_
	
	----------------------------------------------------
	-- ��Ʋ��ŷ
	----------------------------------------------------		
	if(@gmode_ in (@GAME_MODE_BATTLE, @GAME_MODE_SPRINT))
		begin
			select rank() over(order by btwin desc, bttotal asc) as rank, gameid, machinepoint, memorialpoint, btwin, bttotal, avatar, picture, lv, grade from dbo.tUserMaster
			where gameid in (select friendid from dbo.tUserFriend where gameid = @gameid_) or gameid = @gameid_
		end
	
	----------------------------------------------------
	-- ������ ������ ��� �������� �����ϱ�
	----------------------------------------------------
	if(@pluslvupitemecode != -1 or @sprintitemcode != -1)
		begin
			select top 50 idx, itemcode, convert(varchar(16), giftdate, 20) as giftdate, giftid, period2, upgradestate2
			from dbo.tGiftList 
			where gameid = @gameid_ and gainstate = 0 
			order by idx desc
		end	


	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off
	--select @nResult_ rtn
End

