/*
gameid=xxx
password=xxx
acode=xxx
ucode=xxx
market=xxx
goldball=xxx
cash=xxx



-- select top 10 * from dbo.tCashLog
-- select top 10 * from dbo.tCashTotal
-- update  dbo.tUserMaster set goldball = 10000 where gameid = 'SangSang'
exec spu_CashBuy 1, 'SangSangl', '', 'a1s2d3f4', 'xxxxx', '60512345778998765442bcde3123192022161560004', 1, 1, 10, 1000, 10, 1000, -1		-- ���̵��ã��
exec spu_CashBuy 1, 'SangSang',  '', '1234', 'xxxxx', '60512345778998765442bcde3123192022161560004', 1, 1, 10, 1000, 10, 1000, -1			-- �н�����Ʋ��
exec spu_CashBuy 1, 'SangSang',  '', 'a1s2d3f4', 'xxxxx', '60512345778998765442bcde3123192022161560004', 1, 1, 10, 1000, 20, 1000, -1		-- ����ġ
exec spu_CashBuy 1, 'SangSang',  '', 'a1s2d3f4', 'xxxxx', '60512345778998765442bcde3123192022161560004', 1, 0, 10, 1000, 10, 1000, -1		-- ������
exec spu_CashBuy 1, 'SangSang',  '', 'a1s2d3f4', 'xxxxx', '60512345778998765442bcde3123192022161560004', 1, 1, 4000, 1000, 4000, 1000, -1	-- ��纼����
-- delete dbo.tCashLog where ucode = '60512345778998765442bcde3123192022161560004'
exec spu_CashBuy 1, 'SangSang', '', 'a1s2d3f4', 'xxxxx', '60512345778998765442bcde3123192022161560004', 1, 1, 10, 1000, 10, 1000, -1		-- ���󱸸�/�ι�°���ʹ� ī�ǻ���
exec spu_CashBuy 1, 'SangSang', '', 'a1s2d3f4', 'xxxxx', '11589012445665432119ijkl0890869799838258253', 1, 1, 10, 1000, 10, 1000, -1		-- ���󱸸�/�ι�°���ʹ� ī�ǻ���

-- 68867890323443210908ghijadef8678647567060340234		2000	21
-- 22490124956776543265jklmdghi1901970890393604229		5000	55
-- 35589015245665432450ijklcfgh0890869789282519232		29000	500
-- 89356784012332109401fghizcde7567536456959288242		50000	635
-- 65523466689009877863cdefwzab4234203123626951235		99000	1600
exec spu_CashBuy 1, 'SangSang', '', 'a1s2d3f4', 'xxxxx', '63234567090110987675defgxabc5345314235765769230', 2, 1, 21, 2000, 21, 2000, -1
exec spu_CashBuy 1, 'SangSang', '', 'a1s2d3f4', 'xxxxx', '49690124956776543265jklmdghi1901970891254406236', 1, 1, 55, 5000, 55, 5000, -1
exec spu_CashBuy 1, 'SangSang', '', 'a1s2d3f4', 'xxxxx', '21134560790110987905defgxabc5345314235698893239', 1, 1, 500, 29000, 500, 29000, -1
exec spu_CashBuy 1, 'SangSang', '', 'a1s2d3f4', 'xxxxx', '93889017345665432734ijklcfgh0890869780143360251', 1, 1, 635, 50000, 635, 50000, -1
exec spu_CashBuy 1, 'SangSang', '', 'a1s2d3f4', 'xxxxx', '24534577790110988974defgxabc5345314235765759230', 1, 1, 1600, 99000, 1600, 99000, -1
exec spu_CashBuy 1, 'dd10', '', '7575970askeie1595312', 'xxxxx', '24534577790110988974defgxabc5345314235765759230', 1, 1, 1600, 99000, 1600, 99000, -1

-- ģ������ �������
exec spu_CashBuy 2, 'dd10', 'dd20', '7575970askeie1595312', 'xxxxx', '63234567090110987675defgxabc5345314235765769230', 1, 1, 21, 2000, 21, 2000, -1
exec spu_CashBuy 2, 'dd10', 'dd20', '7575970askeie1595312', 'xxxxx', '49690124956776543265jklmdghi1901970891254406236', 1, 1, 55, 5000, 55, 5000, -1
exec spu_CashBuy 2, 'dd10', 'dd20', '7575970askeie1595312', 'xxxxx', '21134560790110987905defgxabc5345314235698893239', 1, 1, 500, 29000, 500, 29000, -1
exec spu_CashBuy 2, 'dd10', 'dd20', '7575970askeie1595312', 'xxxxx', '93889017345665432734ijklcfgh0890869780143360251', 1, 1, 635, 50000, 635, 50000, -1
exec spu_CashBuy 2, 'dd10', 'dd20', '7575970askeie1595312', 'xxxxx', '24534577790110988974defgxabc5345314235765759230', 1, 1, 1600, 99000, 1600, 99000, -1

exec spu_CashBuy 1, 'SangSang', '', '7575970askeie1595312', 'xxxxx', '63234567090110987675defgxabc53453142357657692301', 1, 1, 21, 2000, 21, 2000, -1
exec spu_CashBuy 1, 'SangSang', '', '7575970askeie1595312', 'xxxxx', '63234567090110987675defgxabc53453142357657692302', 2, 1, 21, 2000, 21, 2000, -1
exec spu_CashBuy 1, 'SangSang', '', '7575970askeie1595312', 'xxxxx', '63234567090110987675defgxabc53453142357657692303', 3, 1, 21, 2000, 21, 2000, -1
exec spu_CashBuy 1, 'SangSang', '', '7575970askeie1595312', 'xxxxx', '63234567090110987675defgxabc53453142357657692304', 4, 1, 21, 2000, 21, 2000, -1
exec spu_CashBuy 1, 'SangSang', '', '7575970askeie1595312', 'xxxxx', '63234567090110987675defgxabc53453142357657692305', 4, 1, 21, 2000, 21, 2000, -1

exec spu_CashBuy 1, 'sususu2', '', '7575970askeie1595312', 'xxxxx', '63234567090110987675defgxabc53453142357657692407', 1, 1, 15, 1500, 15, 1500, -1
exec spu_CashBuy 1, 'sususu2', '', '7575970askeie1595312', 'xxxxx', '63234567090110987675defgxabc53453142357657692409', 1, 1, 55, 5000, 55, 5000, -1
exec spu_CashBuy 1, 'sususu2', '', '7575970askeie1595312', 'xxxxx', '63234567090110987675defgxabc53453142357657692408', 1, 1, 114, 9900, 114, 9900, -1
exec spu_CashBuy 1, 'sususu2', '', '7575970askeie1595312', 'xxxxx', '63234567090110987675defgxabc53453142357657692410', 1, 1, 400, 29000, 400, 29000, -1
exec spu_CashBuy 1, 'sususu2', '', '7575970askeie1595312', 'xxxxx', '63234567090110987675defgxabc53453142357657692411', 1, 1, 635, 50000, 635, 50000, -1
exec spu_CashBuy 1, 'sususu2', '', '7575970askeie1595312', 'xxxxx', '63234567090110987675defgxabc53453142357657692412', 1, 1, 1320, 99000, 1320, 99000, -1

exec spu_CashBuy 1, 'dd10', '', '7575970askeie1595312', 'xxxxx11', '63234567090110987675defgxabc53453142357657694911', 7, 1, 15, 199, 15, 199, 'SandBox', 'serialdata11', 'serialdata11', -1
exec spu_CashBuy 1, 'dd10', '', '7575970askeie1595312', 'xxxxx12', '63234567090110987675defgxabc53453142357657694912', 7, 1, 15, 199, 15, 199, 'SandBox', 'serialdata12', 'serialdata12', -1


exec spu_CashBuy 1, 'xxx02', '', '049000s1i0n7t8445289', 'xxxxx6', '63234567090110987675defgxabc534531423576576945a1', 1, 1, 15, 199, 15, 199, '', '', '', -1
exec spu_CashBuy 1, 'xxx02', '', '049000s1i0n7t8445289', 'xxxxx6', '63234567090110987675defgxabc534531423576576945a2', 1, 1, 15, 199, 15, 199, '', '', '', -1

exec spu_CashBuy 1, 'dd10', '', '7575970askeie1595312', 'xxxxx6', '63234567090110987675defgxabc534531423576576945a2', 1, 1, 1320, 99000, 1320, 99000, '', '', '', -1	-- SKT����
exec spu_CashBuy 1, 'dd10', '', '7575970askeie1595312', 'xxxxx6', '63234567090110987675defgxabc534531423576576945a2', 5, 1, 15, 1500, 15, 1500, '', '', '', -1	-- GOOGLE����
exec spu_CashBuy 1, 'dd11', '', '7575970askeie1595312', 'xxxxx6', '63234567090110987675defgxabc534531423576576945a2', 5, 1, 55, 5000, 55, 5000, '', '', '', -1	-- GOOGLE����
exec spu_CashBuy 1, 'dd12', '', '7575970askeie1595312', 'xxxxx6', '63234567090110987675defgxabc534531423576576945a2', 5, 1, 114, 9900, 114, 9900, '', '', '', -1	-- GOOGLE����
exec spu_CashBuy 1, 'dd13', '', '7575970askeie1595312', 'xxxxx6', '63234567090110987675defgxabc534531423576576945a2', 5, 1, 400, 29000, 400, 29000, '', '', '', -1	-- GOOGLE����
exec spu_CashBuy 1, 'dd14', '', '7575970askeie1595312', 'xxxxx6', '63234567090110987675defgxabc534531423576576945a2', 5, 1, 635, 50000, 635, 50000, '', '', '', -1	-- GOOGLE����
exec spu_CashBuy 1, 'dd15', '', '7575970askeie1595312', 'xxxxx6', '63234567090110987675defgxabc534531423576576945a4', 5, 1, 1320, 99000, 1320, 99000, '', '', '', -1	-- GOOGLE����
exec spu_CashBuy 1, 'dd15', '', '7575970askeie1595312', 'xxxxx6', '63234567090110987675defgxabc534531423576576945a5', 5, 1, 1320, 99000, 1320, 99000, '', '', '', -1	-- GOOGLE����
exec spu_CashBuy 1, 'dd15', '', '7575970askeie1595312', 'xxxxx6', '63234567090110987675defgxabc534531423576576945a6', 5, 1, 1320, 99000, 1320, 99000, '', '', '', -1	-- GOOGLE����
select * from dbo.tUserGoogleBuyLog
*/

IF OBJECT_ID ( 'dbo.spu_CashBuy', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_CashBuy;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_CashBuy
	@mode_									int,
	@gameid_								varchar(20),					-- ���Ӿ��̵�
	@giftid_								varchar(20),					-- �������� ����
	@password_								varchar(20),
	@acode_									varchar(256),					-- indexing
	@ucode_									varchar(256),
	@market_								int,
		@summary_								int,
	@goldball_								int,
	@cash_									int,
		@goldball2_								int,
		@cash2_									int,
	@ikind_									varchar(256),
	@idata_									varchar(4096),
	@idata2_								varchar(4096),
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

	-- ��Ÿ����
	declare @RESULT_ERROR_RESULT_COPY			int				set @RESULT_ERROR_RESULT_COPY			= -53			-- ���ī�ǽõ�
	declare @RESULT_ERROR_SILVER_COPY			int				set @RESULT_ERROR_SILVER_COPY			= -54			-- �ǹ�ī�ǽõ�
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- ���������ʴ¸��
	declare @RESULT_ERROR_ACTION_FULL			int				set @RESULT_ERROR_ACTION_FULL			= -71			-- ���������ʴ¸��
	declare @RESULT_ERROR_WIN_LACK				int				set @RESULT_ERROR_WIN_LACK				= -72			-- ������Ʈ ����.
	declare @RESULT_ERROR_TUTORIAL_ALREADY		int				set @RESULT_ERROR_TUTORIAL_ALREADY		= -73			-- ���丮�� �̹� ����.
	declare @RESULT_ERROR_FRIEND_ADD_MYGAMEID	int				set @RESULT_ERROR_FRIEND_ADD_MYGAMEID	= -74
	declare @RESULT_ERROR_NOT_FOUND_GIFTID		int				set @RESULT_ERROR_NOT_FOUND_GIFTID		= -75			-- ĳ�� > ������ ���̵� ��ã��

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
	declare @SYSTEM_SENDID						varchar(40)		set @SYSTEM_SENDID						= 'SysCash'
	declare @ITEM_PERMANENT_START_DAY			datetime		set @ITEM_PERMANENT_START_DAY			= '2012-01-01'	-- �����۽���
	declare @ITEM_PERMANENT_ADD_YEAR			int				set @ITEM_PERMANENT_ADD_YEAR			= 50			-- �����۱Ⱓ
	declare @ITEM_PERIOD_PERMANENT				int 			set @ITEM_PERIOD_PERMANENT				= -1			-- ���̺� -1�̶� ��ϵ�
	declare @SYSTEM_SENDID_GIFT					varchar(20)		set @SYSTEM_SENDID_GIFT					= 'SysCashGift'

	-- ������纼 ������ �ڵ尪
	declare @GOLDBALL_ITEMCODE_1500				int 			set @GOLDBALL_ITEMCODE_1500				= 9000
	declare @GOLDBALL_ITEMCODE_5000				int 			set @GOLDBALL_ITEMCODE_5000				= 9001
	declare @GOLDBALL_ITEMCODE_9900				int 			set @GOLDBALL_ITEMCODE_9900				= 9002
	declare @GOLDBALL_ITEMCODE_29000			int 			set @GOLDBALL_ITEMCODE_29000			= 9003
	declare @GOLDBALL_ITEMCODE_50000			int 			set @GOLDBALL_ITEMCODE_50000			= 9004
	declare @GOLDBALL_ITEMCODE_99000			int 			set @GOLDBALL_ITEMCODE_99000			= 9005

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

	-- �׼�����
	declare @MODE_ACTION_RECHARGE_FULL			int				set	@MODE_ACTION_RECHARGE_FULL			= 1;
	declare @MODE_ACTION_RECHARGE_HALF			int				set	@MODE_ACTION_RECHARGE_HALF			= 2;
	declare @ITEMCODE_ACTION_RECHARGE_FULL		int				set	@ITEMCODE_ACTION_RECHARGE_FULL		= 7000;
	declare @ITEMCODE_ACTION_RECHARGE_HALF		int				set	@ITEMCODE_ACTION_RECHARGE_HALF		= 7001;

	-- ģ���˻�, �߰�, ����
	declare @FRIEND_MODE_SEARCH					int				set	@FRIEND_MODE_SEARCH					= 1;
	declare @FRIEND_MODE_ADD					int				set	@FRIEND_MODE_ADD					= 2;
	declare @FRIEND_MODE_DELETE					int				set	@FRIEND_MODE_DELETE					= 3;
	declare @FRIEND_MODE_MYLIST					int				set	@FRIEND_MODE_MYLIST					= 4;
	declare @FRIEND_MODE_VISIT					int				set	@FRIEND_MODE_VISIT					= 5;

	-- ��Ÿ ���
	declare @BUY_MAX_GOLDBALL					int				set	@BUY_MAX_GOLDBALL					= 1600*2;

	-- ĳ�����
	declare @CASH_MODE_BUYMODE					int				set @CASH_MODE_BUYMODE					= 1
	declare @CASH_MODE_GIFTMODE					int				set @CASH_MODE_GIFTMODE					= 2

	------------------------------------------------
	--	2-3. ���λ�� ����
	------------------------------------------------
	declare @gameid				varchar(20)
	declare @password			varchar(20)
	declare @giftid				varchar(20)
	declare @goldballitemcode	int
	declare @pgb				int
	declare @plusgoldball		int					set @plusgoldball	= 0
	declare @version			int					set @version		= 100

	declare @blockstate		int

	declare @dateid 		varchar(8)
	declare @market			int
	declare @goldball		int
	declare @cash			int
	declare @idx			int

Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on

	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	select
		@gameid 	= gameid,
		@password 	= password,
		@blockstate	= blockstate,
		@version 	= version
	from dbo.tUserMaster where gameid = @gameid_

	-- ģ�� ID�˻�
	if(@mode_ = @CASH_MODE_GIFTMODE)
		begin
			select @giftid = gameid
			from dbo.tUserMaster where gameid = @giftid_
		end


	------------------------------------------------
	--	3-2-3. �������
	------------------------------------------------
	if (@blockstate = @BLOCK_STATE_YES)
		begin
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
			select @nResult_ rtn, 'ERROR ���̵� ã�� ���߽��ϴ�.'
		end
	else if(@mode_ not in (@CASH_MODE_BUYMODE, @CASH_MODE_GIFTMODE))
		begin
			set @nResult_ = @RESULT_ERROR_NOT_SUPPORT_MODE
			select @nResult_ rtn, 'ERROR �������� �ʴ� ����Դϴ�.'
		end
	else if(@mode_ = @CASH_MODE_GIFTMODE and (isnull(@giftid, '') = ''))
		begin
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_GIFTID
			select @nResult_ rtn, 'ERROR �������� ģ���� �����ϴ�.'
		end
	else if(isnull(@gameid, '') = '')
		begin
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
			select @nResult_ rtn, 'ERROR ���̵� ã�� ���߽��ϴ�.'
		end
	else if(@password != @password_)
		begin
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_PASSWORD
			select @nResult_ rtn, 'ERROR �н����尡 ��ġ���� �ʽ��ϴ�.'
		end
	else if(@goldball_ != @goldball2_ or @cash_ != @cash2_)
		begin
			set @nResult_ = @RESULT_ERROR_CASH_COPY
			select @nResult_ rtn, 'ERROR ĳ��ī��(��ó���˴ϴ�.����ĳ��������ġ(-1))'

			---------------------------------------------------
			--	ĳ��ī�� �÷��� ���
			---------------------------------------------------
			update dbo.tUserMaster set cashcopy = cashcopy + 1 where gameid = @gameid_

			insert into dbo.tUserUnusualLog(gameid, comment) values(@gameid_, '**** ĳ��ī�Ǹ� �õ��߽��ϴ�(����ĳ��������ġ) ****')
		end
	else if(@summary_ != 1)
		begin
			set @nResult_ = @RESULT_ERROR_CASH_COPY
			select @nResult_ rtn, 'ERROR ĳ��ī��(��ó���˴ϴ�.��ȿ�����ʴ°�(-2))'

			---------------------------------------------------
			--	ĳ��ī�� �÷��� ���
			---------------------------------------------------
			update dbo.tUserMaster set cashcopy = cashcopy + 1 where gameid = @gameid_

			insert into dbo.tUserUnusualLog(gameid, comment) values(@gameid_, '**** ĳ��ī�Ǹ� �õ��߽��ϴ�(��ȿ�����ʴ� ucode��) ****')
		end
	else if(@goldball_ > @BUY_MAX_GOLDBALL)
		begin
			set @nResult_ = @RESULT_ERROR_CASH_COPY
			select @nResult_ rtn, 'ERROR ĳ��ī��(��ó���˴ϴ�.��ȿ�����ʴ� ��纼(-3))'

			---------------------------------------------------
			--	ĳ��ī�� �÷��� ���
			---------------------------------------------------
			update dbo.tUserMaster set cashcopy = cashcopy + 1 where gameid = @gameid_

			insert into dbo.tUserUnusualLog(gameid, comment) values(@gameid_, '**** ĳ��ī�Ǹ� �õ��߽��ϴ�(��ȿ�����ʴ� ��纼) ****')
		end
	else if(exists(select top 1 * from dbo.tCashLog where ucode = @ucode_))
		begin
			set @nResult_ = @RESULT_ERROR_CASH_COPY
			select @nResult_ rtn, 'ERROR ĳ��ī��(��ó���˴ϴ�.�ߺ���û(-4))'

			---------------------------------------------------
			--	ĳ��ī�� �÷��� ���
			---------------------------------------------------
			update dbo.tUserMaster set cashcopy = cashcopy + 10 where gameid = @gameid_

			insert into dbo.tUserUnusualLog(gameid, comment) values(@gameid_, '**** ĳ��ī�Ǹ� �õ��߽��ϴ�(�ߺ���û�� �ߴ�.) ****')
		end
	else
		begin
			set @nResult_ = @RESULT_SUCCESS
			select @nResult_ rtn, 'SUCCESS ���Ÿ� ����ó���ϴ�.'

			---------------------------------------------------
			-- ĳ��Pluse > ���űݾ�
			---------------------------------------------------
			set @goldballitemcode = @GOLDBALL_ITEMCODE_1500
			if(@market_ = @MARKET_IPHONE)
				begin
					if(@cash_ = 199)
						begin
							set @goldballitemcode = @GOLDBALL_ITEMCODE_1500
							set @cash_ = 1500
						end
					else if(@cash_ = 499)
						begin
							set @goldballitemcode = @GOLDBALL_ITEMCODE_5000
							set @cash_ = 5000
						end
					else if(@cash_ = 899)
						begin
							set @goldballitemcode = @GOLDBALL_ITEMCODE_9900
							set @cash_ = 9900
						end
					else if(@cash_ = 2699)
						begin
							set @goldballitemcode = @GOLDBALL_ITEMCODE_29000
							set @cash_ = 29000
						end
					else if(@cash_ = 4599)
						begin
							set @goldballitemcode = @GOLDBALL_ITEMCODE_50000
							set @cash_ = 50000
						end
					else if(@cash_ = 8999)
						begin
							set @goldballitemcode = @GOLDBALL_ITEMCODE_99000
							set @cash_ = 99000
						end
				end
			else
				begin
					if(@cash_ = 1500)
						begin
							set @goldballitemcode = @GOLDBALL_ITEMCODE_1500
						end
					else if(@cash_ = 5000)
						begin
							set @goldballitemcode = @GOLDBALL_ITEMCODE_5000
						end
					else if(@cash_ = 9900)
						begin
							set @goldballitemcode = @GOLDBALL_ITEMCODE_9900
						end
					else if(@cash_ = 29000)
						begin
							set @goldballitemcode = @GOLDBALL_ITEMCODE_29000
						end
					else if(@cash_ = 50000)
						begin
							set @goldballitemcode = @GOLDBALL_ITEMCODE_50000
						end
					else if(@cash_ = 99000)
						begin
							set @goldballitemcode = @GOLDBALL_ITEMCODE_99000
						end
				end
			select @pgb = isnull(param1, 0) from dbo.tItemInfo where itemcode = @goldballitemcode

			-------------------------------------------------
			-- �߰� ��弼�õǾ� �ִٸ�
			-------------------------------------------------
			select top 1 @plusgoldball = plusgoldball
			from dbo.tActionInfo where flag = 1
			order by idx desc
			if(@plusgoldball > 0 and @plusgoldball <= 100)
				begin
					set @pgb = @pgb + (@pgb * @plusgoldball / 100)
				end


			if(@mode_ = @CASH_MODE_BUYMODE)
				begin
					---------------------------------------------------
					-- �������� > ĳ��Pluse
					---------------------------------------------------
					update dbo.tUserMaster
						set goldball = goldball + @pgb
					where gameid = @gameid_

					---------------------------------------------------
					-- �������� > ���ű���ϱ�
					---------------------------------------------------
					insert into dbo.tCashLog(gameid, acode, ucode, goldball, cash, market, ikind, idata, idata2)
					values(@gameid_, @acode_, @ucode_, @pgb, @cash_, @market_, @ikind_, @idata_, @idata2_)

					---------------------------------------------------
					-- �������� > ������ ���� �����ֱ�
					---------------------------------------------------
					insert into tMessage(gameid, sendid, comment)
					values(@gameid_, @SYSTEM_SENDID, ltrim(rtrim(str(@pgb))) +  '����� �����Ͽ����ϴ�.')
				end
			else if(@mode_ = @CASH_MODE_GIFTMODE)
				begin
					---------------------------------------------------
					-- ������ > ���濡�� ������ �־��ֱ�
					---------------------------------------------------
					-- �����־��ֱ�
					--update dbo.tUserMaster
					--	set goldball = goldball + @pgb
					--where gameid = @giftid_

					insert into dbo.tGiftList(gameid, itemcode, giftid, period2)
					values(@giftid_ , @goldballitemcode, @gameid_, @ITEM_PERIOD_PERMANENT);


					---------------------------------------------------
					-- ������ > ���ű���ϱ�
					---------------------------------------------------
					insert into dbo.tCashLog(gameid, acode, ucode, goldball, cash, giftid, market, ikind, idata, idata2)
					values(@gameid_, @acode_, @ucode_, @pgb, @cash_, @giftid_, @market_, @ikind_, @idata_, @idata2_)

					---------------------------------------------------
					-- �����ڿ� �����ڿ��� ���� �����ֱ�
					---------------------------------------------------
					insert into tMessage(gameid, sendid, comment)
					values(@gameid_, @SYSTEM_SENDID, ltrim(rtrim(@giftid_)) + '�Կ��� ' + ltrim(rtrim(str(@pgb))) +  '����� �����Ͽ����ϴ�.')

					insert into tMessage(gameid, sendid, comment)
					values(@giftid_, @SYSTEM_SENDID, ltrim(rtrim(@gameid_)) + '���κ��� ' + ltrim(rtrim(str(@pgb))) +  '����� ���� �޾ҽ��ϴ�.')
				end

			---------------------------------------------------
			-- ��Ż�α� ����ϱ�
			---------------------------------------------------
			set @dateid = Convert(varchar(8),Getdate(),112)		-- 20120819
			if(exists(select top 1 * from dbo.tCashTotal where dateid = @dateid and cashkind = @cash_ and market = @market_))
				begin
					update dbo.tCashTotal
						set
							goldball = goldball + @pgb,
							cash = cash + @cash_,
							cnt = cnt + 1
					where dateid = @dateid and cashkind = @cash_ and market = @market_
				end
			else
				begin
					insert into dbo.tCashTotal(dateid, cashkind, market, goldball, cash)
					values(@dateid, @cash_, @market_, @pgb, @cash_)
				end

			--���� ��纼�� �ǹ��� �������ֱ�
			select * from dbo.tUserMaster where gameid = @gameid_
		end



	------------------------------------------------
	--	4-2. ��������
	------------------------------------------------
	set nocount off
End

