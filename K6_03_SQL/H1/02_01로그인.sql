/* �Է°�
gameid=xxx
password=xxx <=��ȣȭ����
version=100


exec spu_Login 'SangSang15678', 'a1s2d3f4', 1, 100, -1

-- ��ŷó�� test
select top 10 * from dbo.tUserMaster
update dbo.tUserMaster set resultcopy = 5, blockstate = 0 where gameid='DD0'
exec spu_Login 'DD0', 'a1s2d3f4', 1, 100, -1
exec spu_Login 'SangSang', 'a1s2d3f4', 1, 100, -1
update dbo.tUserMaster set resultcopy = 0, blockstate = 0, gradeExp = 14, grade = 3, gradeStar = 2, actioncount = actionmax where gameid='SangSang'

--������� > ������
update dbo.tUserMaster set cap = 101, cupper = 201, cunder = 301, bat = 401 where gameid='SangSang'
update dbo.tUserItem set expirestate = 0 , expiredate = '2010-12-31' where gameid = 'SangSang' and itemcode in (101)
update dbo.tUserItem set expirestate = 0 , expiredate = '2012-12-31' where gameid = 'SangSang' and itemcode in (     201, 301, 401)
exec spu_Login 'SangSang', 'a1s2d3f4', 1, 100, -1

update dbo.tUserMaster set cap = 101, cupper = 201, cunder = 301, bat = 401 where gameid='SangSang'
update dbo.tUserItem set expirestate = 0 , expiredate = '2010-12-31' where gameid = 'SangSang' and itemcode in (101, 201)
update dbo.tUserItem set expirestate = 0 , expiredate = '2012-12-31' where gameid = 'SangSang' and itemcode in (          301, 401)
exec spu_Login 'SangSang', 'a1s2d3f4', 1, 100, -1

update dbo.tUserMaster set cap = 101, cupper = 201, cunder = 301, bat = 401 where gameid='SangSang'
update dbo.tUserItem set expirestate = 0 , expiredate = '2010-12-31' where gameid = 'SangSang' and itemcode in (101, 201, 301)
update dbo.tUserItem set expirestate = 0 , expiredate = '2012-12-31' where gameid = 'SangSang' and itemcode in (              401)
exec spu_Login 'SangSang', 'a1s2d3f4', 1, 100, -1

update dbo.tUserMaster set cap = 101, cupper = 201, cunder = 301, bat = 401 where gameid='SangSang'
update dbo.tUserItem set expirestate = 0 , expiredate = '2010-12-31' where gameid = 'SangSang' and itemcode in (101, 201, 301, 401)
exec spu_Login 'SangSang', '7575970askeie1595312', 1, 106, -1
exec spu_Login 'sususu', '7575970askeie1595312', 1, 106, -1
exec spu_Login 'superman6', '7575970askeie1595312', 1, 109, -1
exec spu_Login 'SangSang', '7575970askeie1595312', 1, 100, -1
exec spu_Login 'superman7', '7575970askeie1595312', 1, 111, -1

exec spu_Login 'superman6', '7575970askeie1595312', 1, 109, -1
exec spu_Login 'superman6', '7575970askeie1595312', 11, 109, -1

select * from dbo.tUserMaster where gameid = 'sususu'
*/

IF OBJECT_ID ( 'dbo.spu_Login', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_Login;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_Login
	@gameid_								varchar(20),					-- ���Ӿ��̵�
	@password_								varchar(20),					-- ��ȣȭ�ؼ�����, �����н����� ��ŷ���ص� ����
	@market_								int,							-- (����ó�ڵ�) MARKET_SKT
																			--		MARKET_SKT		= 1
																			--		MARKET_KT		= 2
																			--		MARKET_LGT		= 3
																			--		MARKET_FaceBook = 4
																			--		MARKET_Google	= 5
	@version_								int,							-- Ŭ�����
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
	declare @RESULT_ERROR_UPGRADE_NOBRANCH		int				set @RESULT_ERROR_UPGRADE_NOBRANCH		= -50			--��ü����Ұ���

	-- ĳ������.
	declare @RESULT_ERROR_CASH_COPY				int				set @RESULT_ERROR_CASH_COPY				= -40
	declare @RESULT_ERROR_CASH_OVER				int				set @RESULT_ERROR_CASH_OVER				= -41
	declare @RESULT_ERROR_MONTH_OVER			int				set @RESULT_ERROR_MONTH_OVER			= -42			--�Ѵ޵��� �����ѵ��� �˻�

	-- �����ۼ���
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- �������ڵ��ã��
	declare @RESULT_ERROR_GIFTITEM_NOT_FOUND	int				set @RESULT_ERROR_GIFTITEM_NOT_FOUND	= -51			-- ������������ ��ã��
	declare @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	int				set @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	= -52			-- ������ �̹� ������

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
	declare @MARKET_NHN							int				set @MARKET_NHN							= 6
	declare @MARKET_IPHONE						int				set @MARKET_IPHONE						= 7
	declare @MARKET_SKT2						int				set @MARKET_SKT2						= 11
	declare @MARKET_KT2							int				set @MARKET_KT2							= 12
	declare @MARKET_LGT2						int				set @MARKET_LGT2						= 13
	declare @MARKET_GOOGLE2						int				set @MARKET_GOOGLE2						= 15

	-- �ý��� üŷ
	declare @SYSCHECK_NON						int				set @SYSCHECK_NON						= 0
	declare @SYSCHECK_YES						int				set @SYSCHECK_YES						= 1
	declare @NOT_FOUND_DATA						int				set @NOT_FOUND_DATA						= -999

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

	-- ��Ÿ ���ǰ�
	declare @ITEM_PERMANENT_START_DAY			datetime		set @ITEM_PERMANENT_START_DAY			= '2012-01-01'	-- �����۽���
	declare @ITEM_PERMANENT_ADD_YEAR			int				set @ITEM_PERMANENT_ADD_YEAR			= 50			-- �����۱Ⱓ
	declare @ITEM_PERIOD_PERMANENT				int 			set @ITEM_PERIOD_PERMANENT				= -1			-- ���̺� -1�̶� ��ϵ�

	-- �����÷��� ��������
	declare @GAME_STATE_END						int				set @GAME_STATE_END						= 0
	declare @GAME_STATE_PLAYING					int				set @GAME_STATE_PLAYING					= 1

	--�����۸���
	declare @ITEM_EXPIRE_STATE_NO				int 			set @ITEM_EXPIRE_STATE_NO				= 0
	declare @ITEM_EXPIRE_STATE_YES				int				set @ITEM_EXPIRE_STATE_YES				= 1
	declare @DAY_PLUS_TIME						bigint			set @DAY_PLUS_TIME 						= 24*60*60

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

	-- Ÿ���� ����
	declare @LOOP_TIME_ACTION				int 			set @LOOP_TIME_ACTION 				= 3*60			-- �ൿ�� 3�п� �Ѱ��� ä����
	declare @LOOP_TIME_SMS					int 			set @LOOP_TIME_SMS 					= 40*60			-- SMS 40�п� �ѹ���
	declare @LOOP_TIME_FRIENDLS				int 			set @LOOP_TIME_FRIENDLS				= 20*60			-- ģ����Ŀ��ǹ� 20M�п� �Ѱ��� ä����
	declare @LOOP_TIME_COIN					int 			set @LOOP_TIME_COIN					= 24*60*60		-- �Ϸ翡 �ϳ��� ���� ����(�ƽ� 1��)

	-- Open Event
	declare @OPEN_EVENT01_END				datetime		set @OPEN_EVENT01_END				= '2013-02-04'	-- 1.30�ϱ���
	declare @GOLDBALLGIVE_NORMAL			int				set @GOLDBALLGIVE_NORMAL			= 1
	declare @GOLDBALLGIVE_OPEN_EVENT01		int				set @GOLDBALLGIVE_OPEN_EVENT01		= 1
	declare @COINGIVE_NORMAL				int				set @COINGIVE_NORMAL				= 1
	declare @COINGIVE_OPEN_EVENT01			int				set @COINGIVE_OPEN_EVENT01			= 3

	----------------------------------------------------
	-- @@@@ start 2013-02-13
	-- ����� �̺�Ʈ(��ü)
	-- �̺�Ʈ ���� : �߷�Ÿ�ε��� �̺�Ʈ
	-- �̺�Ʈ �Ⱓ : 2013�� 2�� 13�� ~ 18�� ����(�������� 19�� ���� ����)
	-- �̺�Ʈ ���� : ���� �����ϸ� ������ 100% ����
	-- ���� ��û���� : ���� �����ڰԿ� �Ҹ��� ������ 6�� ����(���� �������� 1���� �Ǵ� ���� �ٸ��� Ư�� ������ 3����)
	-- @@@@ end
	----------------------------------------------------
	--declare @EVENT_END						datetime		set @EVENT_END						= '2013-02-18 23:59'
	--declare @EVENT_CODE						int				set @EVENT_CODE						= 1
	--declare @EVENT_COMMENT					varchar(128)	set @EVENT_COMMENT					= '�߷�Ÿ�ε��� �̺�Ʈ ������ �����߽��ϴ�.'

	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @noticesyscheck		int
	declare @noticecomment		varchar(512)
	declare @noticewritedate	datetime
	declare @gameid 		varchar(20)
	declare @password 		varchar(20)
	declare @deletestate	int
	declare @blockstate		int
	declare @cashcopy		int
	declare @resultcopy		int
	declare @actioncount	int
	declare	@actionmax		int
	declare @actiontime		datetime
	declare @friendlscount	int
	declare	@friendlsmax	int
	declare @friendlstime	datetime
	declare @coin			int
	declare @coindate		datetime
	declare @smscount		int
	declare	@smsmax			int
	declare @smstime		datetime
	declare @dayplusdate	datetime
	declare @goldball		int
	declare @dayplusgb		int
	declare @lv				int
	declare @gradeexp		int
	declare @grade			int
	declare @gradestar		int
	declare @gradeOld		int
	declare @gradeStarOld	int
	declare @grademsg		varchar(128)
	declare @ccharacter		int,			@face			int,		@cap				int,
			@cupper			int,			@cunder			int,		@bat				int,
			@glasses		int,			@wing			int,		@tail				int,
			@pet			int,
			@stadium		int

	declare @btflag			int		--������ �ϴٰ� ���� ���Ƽ� ������ ������ �¼��� Ŭ����.
	declare @btflag2		int
	declare @winstreak		int
	declare @winstreak2		int
	declare @buytype		int
	declare @version		int
	declare @branchurl		varchar(512)
	declare @questkind		int,
			@questsubkind	int,
			@questclear		int

	declare @mboardurl		varchar(512)
	declare @mboardstate	int

	declare @currentDate	datetime		set @currentDate = getdate()

	declare @smsurl			varchar(512)	set @smsurl = ''
	declare @smscom			varchar(512)	set @smscom = ''

	declare @comment		varchar(512)	set @comment = '�α���'

	-- DoublePowerMode(�α���, ������)
	declare @doubleitemcode					int				set	@doubleitemcode				= 7002;
	declare @doublepowerinfo				int				set @doublepowerinfo			= 50
	declare @doubledegreeinfo				int				set @doubledegreeinfo			= 50
	declare @doublepriceinfo				int				set @doublepriceinfo			= 20
	declare @doubleperiodinfo				int				set @doubleperiodinfo			= 3

	-- �ð�üŷ
	declare @dateid10 						varchar(10) 	set @dateid10 					= Convert(varchar(8), Getdate(),112) + Convert(varchar(2), Getdate(), 108)
	declare @dateid8 						varchar(8) 		set @dateid8 					= Convert(varchar(8), Getdate(),112)
	declare @rand							int

	-- ������
	declare @idx							int

	-- ���� new
	declare @newmsg							int 			set @newmsg		= 1
	declare @gamekind						int 			set @gamekind	= 1

Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG �ʱ����', @nResult_


	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	select 	@gameid = gameid, @password = password, @blockstate = blockstate, @deletestate = deletestate, @cashcopy = cashcopy, @resultcopy = resultcopy,
		   	@actioncount = actioncount, 	@actionmax = actionmax, 		@actiontime = actiontime,
		   	@smscount = smscount, 			@smsmax = smsmax, 				@smstime = smstime,
		   	@friendlscount = friendlscount, @friendlsmax = friendlsmax, 	@friendlstime = friendlstime,
		   	@btflag = btflag,
		   	@btflag2 = btflag2,
		   	@winstreak	= winstreak,
			@winstreak2	= winstreak2,
			@buytype	= isnull(buytype, 0),
			@lv = lv,

		   	@gradeexp 			= gradeexp, 	@grade 		= grade, 		@gradestar = gradestar,
		   	@coin 				= coin, 		@coindate 	= coindate,
		   	@dayplusdate 		= dayplusdate,
		   	@goldball			= goldball,
			@ccharacter 		= ccharacter,	@face		= face,			@cap = cap,
			@cupper 			= cupper,		@cunder		= cunder,		@bat = bat,
			@glasses			= glasses,		@wing 		= wing,			@tail = tail,
			@pet 				= pet,
			@stadium 			= stadium
	from dbo.tUserMaster where gameid = @gameid_
	--select 'DEBUG �������', @gameid, @password, @blockstate, @deletestate, @cashcopy, @resultcopy

	------------------------------------------------
	--	3-3. �������� üũ
	------------------------------------------------
	select top 1 @noticesyscheck = syscheck, @noticecomment = comment, @noticewritedate = writedate from dbo.tNotice
	where market = @market_
	order by idx desc
	--select 'DEBUG ��������', @noticesyscheck

	------------------------------------------------
	--	3-3-2. SMS ��õ
	------------------------------------------------
	--select 'DEBUG ', @market_, @gamekind, @MARKET_SKT2, @MARKET_KT2, @MARKET_LGT2, @MARKET_GOOGLE2
	if(@market_ in (@MARKET_SKT2, @MARKET_KT2, @MARKET_LGT2, @MARKET_GOOGLE2))
		begin
			set @gamekind = 2
			--select 'DEBUG SMS2'
		end
	--select 'DEBUG ', @market_, @gamekind

	select top 1 @smsurl = url, @smscom = comment from dbo.tSMSRecommend
	where gamekind = @gamekind
	order by idx desc
	set @smsurl = @smscom + ' ' + @smsurl

	------------------------------------------------
	--	3-3-3. �����尡��
	------------------------------------------------
	select top 1
		@doublepowerinfo 	= doublepowerinfo,
		@doubledegreeinfo 	= doubledegreeinfo,
		@doublepriceinfo	= doublepriceinfo,
		@doubleperiodinfo	= doubleperiodinfo
	from dbo.tDoubleModeInfo
	order by idx desc


	------------------------------------------------
	--	3-4. ��ġüũ
	------------------------------------------------
	select
		@version = isnull(version, 0),
		@branchurl = branchurl,
		@mboardurl = mboardurl
	from dbo.tMarketPatch
	where market = @market_ and buytype = @buytype

	if(@noticesyscheck = @SYSCHECK_YES)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_SERVER_CHECKING
			set @comment 	= 'DEBUG �ý��� �������Դϴ�.'
		END
	else if(isnull(@gameid, '') = '')
		BEGIN
			-- ���̵� ���������ʴ°�??
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '���̵� �������� �ʴ´�. > ���̵� Ȯ���ض�.'
		END
	else if(isnull(@password, '') = '' or @password != @password_)
		BEGIN
			-- ���̵� & �н����� ���������ʴ°�??
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_PASSWORD
			set @comment 	= 'DEBUG �н����� Ʋ�ȴ�. > �н����� Ȯ���ض�'
		END
	else if(@version_ < @version)		--else if(@version_ != @version)
		BEGIN
			-- ���Ϻ� ������ Ʋ����
			set @nResult_ 	= @RESULT_NEWVERION_CLIENT_DOWNLOAD
			--@nResult_ = @RESULT_NEWVERION_FILE_DOWNLOAD
			set @comment 	= 'DEBUG ���Ϻ� ������ Ʋ����. > �ٽù޾ƶ�.'
		END
	else if (@blockstate = @BLOCK_STATE_YES)
		BEGIN
			-- �������ΰ�?
			set @nResult_ 	= @RESULT_ERROR_BLOCK_USER
			set @comment 	= 'DEBUG ��ó���� ���̵��Դϴ�.'
			-- select * from tUserMaster where blockstate = 1
		END
	else if (@deletestate = @DELETE_STATE_YES)
		BEGIN
			-- ���������ΰ�?
			set @nResult_ 	= @RESULT_ERROR_DELETED_USER
			set @comment 	= 'DEBUG ������ ���̵��Դϴ�.'
			-- select * from tUserMaster where deletestate = 1
		END
	else if(@cashcopy >= 3)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_BLOCK_USER
			set @comment 	= 'DEBUG ĳ������ī�Ǹ� '+ltrim(rtrim(str(@cashcopy)))+'ȸ �̻��ߴ�. > ��ó������!!'

			-- 3ȸ �̻�ī���ൿ > ��ó��, ���αױ��
			update dbo.tUserMaster
				set
					blockstate = @BLOCK_STATE_YES,
					cashcopy = 0
			where gameid = @gameid_

			-- ������3ȸ ī�ǿ� ���� ��ó��
			insert into dbo.tUserBlockLog(gameid, comment)
			values(@gameid_, '(ĳ������)��  '+ltrim(rtrim(str(@cashcopy)))+'ȸ �̻� ī�Ǹ� �ؼ� �α��ν� �ý��ۿ��� �� ó���߽��ϴ�.')
		END
	else if(@resultcopy >= 100)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_BLOCK_USER
			set @comment 	= 'DEBUG ����������� '+ltrim(rtrim(str(@resultcopy)))+'ȸ�̻� �õ��ߴ�. > ��ó������!!'

			--��������� 3ȸ �̻��ߴ�. > ��ó��, ���αױ��
			update dbo.tUserMaster
				set
					blockstate = @BLOCK_STATE_YES,
					resultcopy = 0
			where gameid = @gameid_

			-- ������3ȸ ī�ǿ� ���� ��ó��
			insert into dbo.tUserBlockLog(gameid, comment)
			values(@gameid_, '����������� '+ltrim(rtrim(str(@resultcopy)))+'ȸ�̻� �õ��ؼ� �α��ν� �ý��ۿ��� �� ó���߽��ϴ�.')
		END
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'DEBUG �α��� ����ó��'
		END



	if(@nResult_ != @RESULT_SUCCESS)
		BEGIN
			select @nResult_ rtn, @comment comment, @branchurl branchurl, @currentDate currentDate
		END
	else
		BEGIN
			select @nResult_ rtn, @comment comment, @branchurl branchurl, @currentDate currentDate

			-----------------------------------------------
			-- ��Ʋ������ �ϴٰ� �߰��� ������ ���
			-- ��ް���ġ, ���, ��Ÿ����,
			-- �α� ���
			-- ����� 10�̻��϶��� �����Ѵ�.
			-----------------------------------------------
			if(@btflag = @GAME_STATE_PLAYING or @btflag2 = @GAME_STATE_PLAYING)
				begin
					--�÷��� ����
					if(@btflag = @GAME_STATE_PLAYING)
						begin
							set @btflag = @GAME_STATE_END
							set @winstreak = 0
						end

					if(@btflag2 = @GAME_STATE_PLAYING)
						begin
							set @btflag2 = @GAME_STATE_END
							set @winstreak2 = 0
						end

					if(@grade >= 10)
						begin
							-- �������
							--declare @gradeExp int			set @gradeExp = 103			declare @grade int			set @grade = 18				declare @gradeStar int	set @gradeStar = 1					--declare @gradeOld		int					--declare @gradeStarOld	int					--declare @i int set @i = 0																				while(@gradeExp != 0)					begin
							--select 'DEBUG ��Ʋ�߰��� ����(��) > ', @gradeexp as gradeexp, @grade as grade, @gradestar as gradestar
							set @gradeOld = @grade;
							set @gradeStarOld = @gradeStar;

							set @gradeExp = @gradeExp - 1
							set @grade = @gradeExp / 6 + 1
							set @gradeStar = @gradeExp % 6
							set @grademsg = '��Ʋ�߰��� ������ ��Ʋ����ġ�� �����Ǿ����ϴ�.'

							if(@gradeExp < 0)
								begin
									set @gradeExp = 0
									set @grade = 1
									set @gradeStar = 0
								end
							else
								begin
									if(@grade != @gradeOld)
										begin
											set @grademsg = '��Ʋ�߰��� ������ ��Ʋ������ �϶��Ǿ����ϴ�.'
											set @gradeExp = 6 * (@grade - 1) + 2
											if(@gradeExp < 0)
												begin
													set @gradeExp = 0
												end
											set @grade = @gradeExp / 6 + 1
											set @gradeStar = @gradeExp % 6
										end
								end
							--select 'DEBUG ��Ʋ�߰��� ����(��) > ', @gradeexp as gradeexp, @grade as grade, @gradestar as gradestar

							-- �αױ�ϸ� ����
							-- insert into tMessage(gameid, comment) values(@gameid_, @grademsg)
						end
				end

			-----------------------------------------------
			--	�ൿ��, ��������, ģ����Ŀ��ǹ�
			-----------------------------------------------
			--select 'DEBUG (��)', @actionCount actionCount, @actionMax actionMax, @actionTime actionTime, @friendlscount friendlscount,  @friendlsmax friendlsmax, @friendlstime friendlstime,  @coin coin,  @coindate coindate
			-- select * from tUserMaster where gameid = 'SangSang'
			-- �ൿ�� ���� �ð�
			declare @nActPerMin bigint,
					@nActCount int,
					@dActTime datetime
			set @nActPerMin = @LOOP_TIME_ACTION
			set @nActCount = datediff(s, @actiontime, getdate())/@nActPerMin
			set @dActTime = DATEADD(s, @nActCount*@nActPerMin, @actiontime)
			set @actioncount = @actioncount + @nActCount
			set @actioncount = case when @actioncount > @actionmax then @actionmax else @actioncount end
			--select 'DEBUG �ൿġ����', @actiontime actiontime, getdate() getdate, @nActCount nActCount, @actioncount actioncount, @dActTime dActTime
			set @actiontime = @dActTime

			-- SMS ���� �ð�
			declare @nSmsPerMin bigint,
					@nSmsCount int,
					@dSmsTime datetime
			set @nSmsPerMin = @LOOP_TIME_SMS
			set @nSmsCount = datediff(s, @smstime, getdate())/@nSmsPerMin
			set @dSmsTime = DATEADD(s, @nSmsCount*@nSmsPerMin, @smstime)
			set @smscount = @smscount + @nSmsCount
			set @smscount = case when @smscount > @smsmax then @smsmax else @smscount end
			--select 'DEBUG �ൿġ����', @smstime smstime, getdate() getdate, @nSmsCount nSmsCount, @smscount smscount, @dSmsTime dSmsTime
			set @smstime = @dSmsTime

			-- ģ����Ŀ��ǹ� �ð�
			declare @nFriendLSCount 	int,
					@nFriendLSPerMin	int,
					@dFriendLSTime 		datetime
			set @nFriendLSPerMin = @LOOP_TIME_FRIENDLS					-- 20M�п� �Ѱ��� ä����
			set @nFriendLSCount = datediff(s, @friendlstime, getdate())/@nFriendLSPerMin
			set @dFriendLSTime = DATEADD(s, @nFriendLSCount*@nFriendLSPerMin, @friendlstime)
			set @friendlscount = @friendlscount + @nFriendLSCount
			set @friendlscount = case when @friendlscount > @friendlsmax then @friendlsmax else @friendlscount end
			--select 'DEBUG ģ����Ŀ��ǹ�', @friendlstime friendlstime, getdate() getdate, @nFriendLSCount nFriendLSCount, @friendlscount friendlscount, @dFriendLSTime dFriendLSTime
			set @friendlstime = @dFriendLSTime


			----------------------------------------------------------
			-- �Ϸ翡 �ϳ��� ���� ����(�ƽ� 1��)
			----------------------------------------------------------
			declare @nCointPerMin bigint,
					@nCoinCount int,
					@dCoinTime datetime,
					@nCoinGive int
			set @nCointPerMin = @LOOP_TIME_COIN
			set @nCoinCount = datediff(s, @coindate, getdate())/@nCointPerMin
			set @dCoinTime = DATEADD(s, @nCoinCount*@nCointPerMin, @coindate)
			set @nCoinGive = @COINGIVE_NORMAL

			if(@coin < @nCoinGive)
				begin
					--------------------------------
					-- ������ ���� ����
					--------------------------------
					set @coin = @coin + case when @nCoinCount > 0 then @nCoinGive else 0 end
					set @coin = case when @coin > @nCoinGive then @nCoinGive when @coin < 0 then 0 else @coin end
				end
			--else
			--	begin
			--		--------------------------------------
			--		-- ������Ʈ�� �߰�ȹ��� ���� > �״�� ����
			--		--------------------------------------
			--	end
			--select 'DEBUG ��������', @coindate, getdate(), @nCoinCount, @coin, @dCoinTime
			--select 'DEBUG (��)', @actionCount actionCount, @actionMax actionMax, @actionTime actionTime, @friendlscount friendlscount,  @friendlsmax friendlsmax, @friendlstime friendlstime,  @coin coin,  @coindate coindate

			----------------------------------------------------------
			-- �Ϸ翡 �ϳ��� ��纻 ����
			----------------------------------------------------------
			declare @nGodballGive int
			set @nGodballGive = 1

			set @dayplusgb = datediff(s, @dayplusdate, getdate())/@DAY_PLUS_TIME
			if(@dayplusgb >= 1)
				begin
					-- �Ϸ翡
					set @dayplusgb 		= @nGodballGive
					set @goldball 		= @goldball + @nGodballGive
					set @dayplusdate 	= getdate()
				end
			else
				begin
					set @dayplusgb 		= 0
					--set @goldball 	= @goldball
					--set @dayplusdate 	= @dayplusdate
				end


			------------------------------------------------------
			---- @@@@ start 2013-02-13
			---- ����� �̺�Ʈ(��ü)
			---- �̺�Ʈ ���� : �߷�Ÿ�ε��� �̺�Ʈ
			------------------------------------------------------
			--if(getdate() < @EVENT_END)
			--	begin
			--		if(not exists(select top 1 * from dbo.tEventMaster where gameid = @gameid_ and dateid = @dateid8 and eventcode = @EVENT_CODE))
			--			begin
			--				-----------------------------------------
			--				-- ���� ������ ����, �޼��� ���(6000 ~ 6004)
			--				-----------------------------------------
			--				set @rand = 6000 + Convert(int, ceiling(RAND() *  5)) - 1
			--
			--				insert into dbo.tGiftList(gameid, itemcode, giftid, period2, upgradestate2)
			--				values(@gameid_ , @rand, '�̺�Ʈ����', -1, 0)
			--
			--				insert into dbo.tGiftList(gameid, itemcode, giftid, period2, upgradestate2)
			--				values(@gameid_ , @rand, '�̺�Ʈ����', -1, 0)
			--
			--				insert into tMessage(gameid, comment)
			--				values(@gameid_, @EVENT_COMMENT)
			--
			--				-----------------------------------------
			--				-- ���� �����Ѱ� �̺�Ʈ�����Ϳ� ���
			--				-----------------------------------------
			--				insert into dbo.tEventMaster(gameid, dateid, eventcode, comment)
			--				values(@gameid_, @dateid8, @EVENT_CODE, @EVENT_COMMENT)
            --
			--			end
			--	end
			---- @@@@ end


			-----------------------------------------------
			-- ���� ���� �������� ���Ⱑ�Ǹ� ����ó���ϰ� �ý��� �޽����� ���⸦ ���.
			-- ������ ���� ��ä�κ��� > @�������̺� �Է� > �ϰ�����
			-- 2�� �̻������(���̺�� ���ͼ�)
			-----------------------------------------------
			--declare @gameid_ varchar(20) set @gameid_ = 'SangSang'
			DECLARE @tItemExpire TABLE(
				idx bigint,
				gameid varchar(20),
				itemcode int
			);
			--select * from dbo.tUserItem where gameid = @gameid_
			update dbo.tUserItem
				set
					expirestate = @ITEM_EXPIRE_STATE_YES
					OUTPUT DELETED.idx, @gameid_, DELETED.itemcode into @tItemExpire
			where gameid = @gameid_ and expirestate = @ITEM_EXPIRE_STATE_NO and getdate() > expiredate

			--select * from dbo.tUserItem where gameid = @gameid_
			insert into tMessage(gameid, comment)
				select @gameid_,  itemname + '�� ���Ⱑ �Ǿ����ϴ�.'
			from @tItemExpire a, tItemInfo b where a.itemcode = b.itemcode
			--select top 10 * from tMessage where gameid = @gameid_  order by idx desc
			--update dbo.tUserItem set expirestate = @ITEM_EXPIRE_STATE_NO where gameid = @gameid_

			------------------------------------------------------
			-- ���Ⱑ�ִ� �ӽ����̺� -> ĳ������Ʈ����Ȯ��
			-- �������������̺��� ���������� Ȯ��
			-- ����Ʈ�� ������ ���ؼ� ��ġ�ϸ� ����
			------------------------------------------------------
			if exists(select * from @tItemExpire where itemcode in (@cap, @cupper, @cunder, @bat))
				begin
					--Ŀ������ ���Ǵ� ������
					declare @restoreitemcode	int
					declare @restoreitemkind	int
					declare @restoreitempart	int

					-- 1. Ŀ������
					declare curItemExpire Cursor for
					select itemcode, kind, param8 from dbo.tItemInfo where itemcode in (select itemcode from @tItemExpire where itemcode in (@cap, @cupper, @cunder, @bat))

					-- 2. Ŀ������
					open curItemExpire

					-- 3. Ŀ�� ���
					Fetch next from curItemExpire into @restoreitemcode, @restoreitemkind, @restoreitempart
					while @@Fetch_status = 0
						Begin
							if(@restoreitemkind = @ITEM_KIND_CHARACTER)
								begin
									--select 'DEBUG ĳ����'
									set @ccharacter = @restoreitempart
								end
							else if(@restoreitemkind = @ITEM_KIND_FACE)
								begin
									--select 'DEBUG ��'
									set @face = @restoreitempart
								end
							else if(@restoreitemkind = @ITEM_KIND_CAP)
								begin
									--select 'DEBUG ����'
									set @cap = @restoreitempart
								end
							else if(@restoreitemkind = @ITEM_KIND_UPPER)
								begin
									--select 'DEBUG ����'
									set @cupper = @restoreitempart
								end
							else if(@restoreitemkind = @ITEM_KIND_UNDER)
								begin
									--select 'DEBUG ����'
									set @cunder = @restoreitempart
								end
							else if(@restoreitemkind = @ITEM_KIND_BAT)
								begin
									--select 'DEBUG ��Ʈ'
									set @bat = @restoreitempart
								end
							else if(@restoreitemkind = @ITEM_KIND_GLASSES)
								begin
									--select 'DEBUG �Ȱ�'
									set @glasses = @restoreitempart
								end
							else if(@restoreitemkind = @ITEM_KIND_WING)
								begin
									--select 'DEBUG ����'
									set @wing = @restoreitempart
								end
							else if(@restoreitemkind = @ITEM_KIND_TAIL)
								begin
									--select 'DEBUG ����'
									set @tail = @restoreitempart
								end
							else if(@restoreitemkind = @ITEM_KIND_PET)
								begin
									--select 'DEBUG ��'
									set @pet = @restoreitempart
								end
							else if(@restoreitemkind = @ITEM_KIND_STADIUM)
								begin
									--select 'DEBUG ����'
									set @stadium = @restoreitempart
								end

							Fetch next from curItemExpire into @restoreitemcode, @restoreitemkind, @restoreitempart
						end

					-- 4. Ŀ���ݱ�
					close curItemExpire
					Deallocate curItemExpire
				end

			------------------------------------------------------------------
			-- ���� ����Ʈ ���� ������Ʈ
			------------------------------------------------------------------
			-- �α��� > �����(1) and �ð��� ��ȿ > Ŀ���� ����
			declare curQuestUser Cursor for
				select questkind, questsubkind, questclear from dbo.tQuestInfo
				where questcode in (select questcode from dbo.tQuestUser
									where gameid = @gameid_
										  and queststate = @QUEST_STATE_USER_WAIT
										  and getdate() > queststart)
				Open curQuestUser
				Fetch next from curQuestUser into @questkind, @questsubkind, @questclear
				while @@Fetch_status = 0
					Begin
						if(@questclear = @QUEST_CLEAR_START)
							begin
								-- select 'DEBUG �α��� > ����Ÿ Ŭ�������ּ���.', @questkind, @questsubkind, @questclear
								-- exec spu_QuestCheck 1, 'superman3', 1000, 8, -1, -1
								exec spu_QuestCheck @QUEST_MODE_CLEAR, @gameid_, @questkind, @questsubkind, -1, -1
							end
						Fetch next from curQuestUser into @questkind, @questsubkind, @questclear
					end
				close curQuestUser
				Deallocate curQuestUser

			-- �ӵ��� ���ؼ� �ϰ� --> ������(2)���� ����
			update dbo.tQuestUser
				set
					queststate = @QUEST_STATE_USER_ING
			where gameid = @gameid_
				and queststate = @QUEST_STATE_USER_WAIT
				and getdate() >= queststart


			------------------------------------------------------------------
			-- ���� ������ ������Ʈ�ϱ�
			------------------------------------------------------------------
			--select * from dbo.tUserMaster where gameid = @gameid_

			update dbo.tUserMaster
			set
				version			= @version_,
				btflag			= @btflag,				-- ��Ʋ �ʱ�ȭ
				btflag2			= @btflag2,
				winstreak		= @winstreak,
				winstreak2		= @winstreak2,

				dayplusdate		= @dayplusdate, 		-- �Ϸ翡 1GB �����ϱ�
				goldball		= @goldball,

				gradeexp		= @gradeexp,
				grade			= @grade,
				gradestar		= @gradestar,

				actioncount		= case when @actioncount < 0 then 0 else @actioncount end,		-- �ൿ�� ����
				actiontime		= @actiontime,
				smscount		= @smscount,			-- sms ����
				smstime			= @smstime,
				friendlscount	= @friendlscount,		-- ��Ŀ������
				friendlstime	= @friendlstime,
				coin			= @coin,				-- ���� ����
				coindate		= @dCoinTime,
				condate			= getdate(),			-- �ֱ� ���ӳ�¥ ����
				concnt			= concnt + 1,			-- ����Ƚ�� +1
				--ccharacter 	= @ccharacter,
				--face 			= @face,
				cap 			= @cap,
				cupper 			= @cupper,
				cunder			= @cunder,
				bat 			= @bat
				--glasses 		= @glasses,
				--wing 			= @wing,
				--tail 			= @tail,
				--pet 			= @pet,
				--stadium 		= @stadium
			where gameid 		= @gameid_
			--select * from dbo.tUserMaster where gameid = @gameid_


			------------------------------------------------------------------
			-- ������ ���׹̳ʰ� ����Ǹ� > Ǫ������ �����ֶ� ����ϱ�
			------------------------------------------------------------------
			if(not exists(select top 1 * from dbo.tActionScheduleData where gameid = @gameid_))
				begin
					insert into tActionScheduleData(gameid) values(@gameid_)
				end

			------------------------------------------------------------------
			-- ���� > �α��� ī����
			------------------------------------------------------------------
			if(not exists(select top 1 * from dbo.tStaticTime where dateid10 = @dateid10 and market = @market_))
				begin
					insert into dbo.tStaticTime(dateid10, market, logincnt, playcnt) values(@dateid10, @market_, 1, 0)
				end
			else
				begin
					update dbo.tStaticTime
						set
							logincnt = logincnt + 1
					where dateid10 = @dateid10 and market = @market_
				end


			------------------------------------------------------------------
			-- �������� ������ ����Ÿ ���
			-- �α��� ��������(��ܿ������)
			-- �������� * 1
			-- ���� * n
			-- �������� * 1
			-- ���������� * n
			-- �����������ȭ * n
			-- ����ģ�� * n
			-- ���������� * n
			------------------------------------------------------------------
			-- ��������(Ȱ�� �ִ� 1��)
			select top 1 comment, convert(varchar(16), writedate, 20) as writedate from dbo.tNotice
			where market = @market_
			order by idx desc

			-----------------------------------------------
			-- �ű� ���� ����( �ִ� 10��)
			-----------------------------------------------
			-- idx(Clustered Index Seek) > writedate(Index Seek)
			-- declare @gameid_ varchar(20) set @gameid_ = 'SangSang'
			--select top 10 sendid, comment, idx, convert(varchar(16), writedate, 20) as writedate
			--from dbo.tMessage where gameid = @gameid_  order by idx desc
			select top 10 sendid, comment, idx, convert(varchar(16), writedate, 20) as writedate, newmsg from dbo.tMessage
			where gameid = @gameid_  order by idx desc

			select top 1 @newmsg = newmsg from dbo.tMessage where gameid = @gameid_ order by idx desc
			if(@newmsg = 1)
				begin
					--select 'DEBUG 10-1 �޼��� ���°� ����'
					update dbo.tMessage
						set
							newmsg = 0
					where idx in (select top 10 idx from dbo.tMessage where gameid = @gameid_ order by idx desc)
				end


			----------------------------------------------
			-- ���� ����
			---------------------------------------------
			-- declare @gameid_ varchar(20) set @gameid_ = 'SangSang'
			select *, @dayplusgb dayplusgb, @mboardurl mboardurl, @smsurl smsurl,
			@doublepowerinfo doublepowerinfo,
			@doubledegreeinfo doubledegreeinfo,
			@doublepriceinfo doublepriceinfo,
			@doubleperiodinfo doubleperiodinfo
			from dbo.tUserMaster where gameid = @gameid_

			-- ���� ���� ������ ����
			-- declare @gameid_ varchar(20) set @gameid_ = 'SangSang'
			--select itemcode, convert(varchar(19), expiredate, 20) as expiredate, datediff(mi, getdate(), expiredate) as remaintime, upgradestate
			select itemcode, expiredate, datediff(mi, getdate(), expiredate) as remaintime, upgradestate, lvignore
			from dbo.tUserItem where gameid = @gameid_ and expirestate = @ITEM_EXPIRE_STATE_NO

			-- ���� ��ȭ�� �̺��� ������(��ȭǥ�ÿ� ����ϱ� ���ؼ�)
			-- declare @gameid_ varchar(20) set @gameid_ = 'SangSang'
			select itemcode, upgradestate, lvignore from dbo.tUserItem where gameid = @gameid_ and expirestate = @ITEM_EXPIRE_STATE_YES and upgradestate > 0


			-- ���� ģ������
			-- declare @gameid_ varchar(20) set @gameid_ = 'SangSang'
			select friendid, familiar, avatar, picture
				from (select * from dbo.tUserMaster where gameid in (select friendid from dbo.tUserFriend where gameid = @gameid_)) as u
			join
				(select friendid, familiar from dbo.tUserFriend where gameid = @gameid_) as f
			on u.gameid = f.friendid
			order by familiar desc

			-- ���� ����Ʈ ����(������ ���� ���� �����ϳ� �Ф�)
			-- declare @gameid_ varchar(20) set @gameid_ = 'SangSang'
			select top 50 idx, itemcode, convert(varchar(16), giftdate, 20) as giftdate, giftid, period2, upgradestate2
			from dbo.tGiftList
			where gameid = @gameid_ and gainstate = 0
			order by idx desc

			-- �α����Ҷ� ĳ���� Ŀ���͸���¡ ������ �����ش�.
			select itemcode, customize from dbo.tUserCustomize
			where gameid = @gameid_
			order by itemcode asc

			--------------------------------------------------------------
			-- �α��� > ���ð� Ȯ�� -> ������Ʈ �ޱ�(��������, ���������� �ٲ�ð�)
			--------------------------------------------------------------
			--> ������ ����Ʈ �����
			select * from dbo.tQuestInfo
			where questcode in (
				select questcode from dbo.tQuestUser
				where gameid = @gameid_ and queststate = @QUEST_STATE_USER_ING and @lv >= questlv
			)
			order by questorder

			-- ������ �������ݷ� �̵���.
			---------------------------------------------------------------
			--- �α��� > �ڽ��� ��Ʋ �α�
			-------------------------------------------------------------
			---select top 20 * from dbo.tBattleLog where btgameid = @gameid_
			----order by idxOrder desc
			--select u2.avatar, u2.picture, u2.ccode, bt.gameid, u2.lv, u2.grade, bt.btresult, Convert(varchar(19), writedate,120) as bttime, case when btresult = 1 then 0 else 1 end as btresult2 from
			--	(select top 20 * from dbo.tBattleLog where btgameid = @gameid_ order by idxOrder desc) as bt
			--		join
			--	(select gameid, avatar, picture, ccode, lv, grade from dbo.tUserMaster
			--		where gameid in
			--			(select top 20 gameid from dbo.tBattleLog where btgameid = @gameid_ order by idxOrder desc)) as u2
			--	on bt.gameid = u2.gameid

			--- exec spu_Login 'SangSang', 'a1s2d3f4', 1, 100, 1
			--- exec spu_Login 'SS33', 'a1s2d3f4', 1, 100, 1

			--------------------------------------------------------------
			-- �α��� > ��ȭ���
			--------------------------------------------------------------
			select top 1 * from dbo.tItemUpgradeInfo where flag = 1 order by idx desc

			--------------------------------------------------------------
			-- �α��� > ����������
			--------------------------------------------------------------
			select top 1 * from dbo.tRevModeInfo where flag = 1 order by idx desc

			--------------------------------------------------------------
			-- �α��� > ���׹̳�����
			--------------------------------------------------------------
			select top 1 * from dbo.tActionInfo where flag = 1 order by idx desc

			--------------------------------------------------------------
			-- �α��� > ������ ������ �ִ°�?
			-- 0.1 : 1�ð� ��... ����
			-- 0.7 : �ݳ��� �̻� ���� ����
			-- 2.0 : 2�� ���� ��������
			--------------------------------------------------------------
			-- �ε��� �ʱ�ȭ
			set @idx = @NOT_FOUND_DATA

			-- �˻��ϱ�
			select top 1
				@idx		= idx
			from dbo.tUserRevenge
			where gameid = @gameid_ and btptime >= getdate() - 2.0 and btpflag = 1
			order by idx desc

			-- �����ϴ°�? > �����ϸ� �÷��� ���� �����ֱ�
			if(@idx != @NOT_FOUND_DATA)
				begin
					update dbo.tUserRevenge
						set
							btpflag = 0
						where idx = @idx

					select * from dbo.tUserRevenge where idx = @idx
				end
			else
				begin
					select * from dbo.tUserRevenge where idx = -1
				end

			--------------------------------------------------------
			-- SKT�� ToTO�� ���� ���ؼ� ���Ƶд�.
			-- Ÿ��Ż�� �����ؼ� ����ص� �ȴ�.
			--------------------------------------------------------
			if(@market_ != @MARKET_SKT)
				begin
					--------------------------------------------------------------
					-- �α��� > WBC��������(SKT�� ����)
					--------------------------------------------------------------
					select
						m.totoid, m.totodate, m.totoday, m.title, m.acountry, m.bcountry, apoint, bpoint, victcountry, victpoint, chalmode1give,
						isnull(chalstate, -1) chalstate,
						isnull(u.chalmode, -1) chalmode, isnull(u.chalbat, -1) chalbat,
						isnull(chalsb, -1) chalsb,

						--isnull(chalcountry, -1) chalcountry,
						case when (isnull(chalresult1, -1) = 0 or isnull(chalresult2, -1) = 0) then -1 else isnull(chalcountry, -1) end chalcountry,

						isnull(chalpoint, -1) chalpoint,
						isnull(chalresult1, -1) chalresult1, isnull(chalresult2, -1) chalresult2
						--, u.*
							from
								dbo.tTotoMaster m
									LEFT OUTER JOIN
								(select * from dbo.tTotoUser where gameid = @gameid_) u
									on m.totoid = u.totoid
										where active = 1
						order by chalmode1give asc, totodate asc
				end
		end


	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off
End



