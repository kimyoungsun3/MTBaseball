/*
select * from dbo.tUserMaster where gameid = 'xxxx'
exec spu_Login 'xxxx', '049000s1i0n7t8445289', 1, 101, '', -1, -1			-- ��������
exec spu_Login 'xxxx', '049000s1i0n7t8445288', 1, 101, '', -1, -1			-- ���Ʋ��
exec spu_Login 'xxxx0', '049000s1i0n7t8445289', 1, 101, '', -1, -1			-- ��������
exec spu_Login 'xxxx', '049000s1i0n7t8445289', 1, 100, '',  -1, -1			-- ���Ϲ�������
exec spu_Login 'xxxx3', '049000s1i0n7t8445289', 1, 101, '', -1, -1			-- ������
exec spu_Login 'xxxx4', '049000s1i0n7t8445289', 1, 101, '', -1, -1			-- ��������
update dbo.tUserMaster set cashcopy = 3 where gameid = 'xxxx5'		-- ĳ��ī�� > ��ó��
exec spu_Login 'xxxx5', '049000s1i0n7t8445289', 1, 101, '', -1,  -1
update dbo.tUserMaster set resultcopy = 100 where gameid = 'xxxx6'	-- ���Ű�� > ��ó��
exec spu_Login 'xxxx7', '049000s1i0n7t8445289', 1, 101, '', -1, -1

exec spu_Login 'xxxx', '049000s1i0n7t8445289', 1, 199, '', -1, -1			-- ��������
exec spu_Login 'xxxx2', '049000s1i0n7t8445289', 5, 119, '', -1, -1			-- ��������
exec spu_Login 'xxxx3', '049000s1i0n7t8445289', 1, 199, '', -1, -1			-- ��������
exec spu_Login 'xxxx6', '049000s1i0n7t8445289', 1, 199, '', -1, -1			-- ��������

update dbo.tUserMaster set attenddate = getdate() - 20 where gameid = 'xxxx2'
delete from dbo.tGiftList where gameid = 'xxxx2'
exec spu_Login 'xxxx2', '049000s1i0n7t8445289', 1, 110, '', -1, -1			-- ��������

update dbo.tUserMaster set attenddate = getdate() - 1 where gameid = 'xxxx2'
exec spu_Login 'xxxx2', '049000s1i0n7t8445289', 1, 103, '', -1, -1			-- ��������

--���������׽�Ʈ
update dbo.tUserMaster set attenddate = getdate() - 1, tsskillcashcost = 0, tsskillheart = 0, tsskillgamecost = 100, tsskillfpoint = 0, tsskillrebirth = 0, tsskillalba = 0, tsskillbullet = 0, tsskillvaccine = 0, tsskillfeed = 0, tsskillbooster = 0 where gameid = 'xxxx2'
exec spu_Login 'xxxx2', '049000s1i0n7t8445289', 5, 119, '', -1, -1			-- ��������

*/
use GameMTBaseball
Go

IF OBJECT_ID ( 'dbo.spu_Login', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_Login;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_Login
	@gameid_								varchar(20),					-- ���Ӿ��̵�
	@password_								varchar(20),					-- ��ȣȭ�ؼ�����, �����н����� ��ŷ���ص� ����
	@market_								int,							-- (����ó�ڵ�)
	@version_								int,							-- Ŭ�����
	@kakaoprofile_							varchar(512),
	@kakaomsgblocked_						int,
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
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--�ش������� ã�� ����
	declare @RESULT_ERROR_NOT_FOUND_PASSWORD	int				set @RESULT_ERROR_NOT_FOUND_PASSWORD	= -17
	declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--������ �����ϰ� �ִ�.
	declare @RESULT_NEWVERION_CLIENT_DOWNLOAD 	int				set @RESULT_NEWVERION_CLIENT_DOWNLOAD	= -15			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ��ũó��.
	--declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ����.

	------------------------------------------------
	--	2-2. ���°�
	------------------------------------------------
	-- ����ó�ڵ�
	declare @MARKET_SKT							int					set @MARKET_SKT						= 1
	declare @MARKET_GOOGLE						int					set @MARKET_GOOGLE					= 5
	--declare @MARKET_NHN						int					set @MARKET_NHN						= 6
	declare @MARKET_IPHONE						int					set @MARKET_IPHONE					= 7

	-- �����°�.
	--declare @BLOCK_STATE_NO					int					set	@BLOCK_STATE_NO					= 0	-- �����¾ƴ�
	declare @BLOCK_STATE_YES					int					set	@BLOCK_STATE_YES				= 1	-- ������

	-- �������°�.
	--declare @DELETE_STATE_NO					int					set	@DELETE_STATE_NO				= 0	-- �������¾ƴ�
	declare @DELETE_STATE_YES					int					set	@DELETE_STATE_YES				= 1	-- ��������

	-- �ý��� üŷ
	--declare @SYSCHECK_NON						int					set @SYSCHECK_NON					= 0
	declare @SYSCHECK_YES						int					set @SYSCHECK_YES					= 1

	-- �����ۺ� �κ��з�
	declare @USERITEM_INVENKIND_ANI				int 				set @USERITEM_INVENKIND_ANI					= 1
	declare @USERITEM_INVENKIND_CONSUME			int 				set @USERITEM_INVENKIND_CONSUME				= 3
	declare @USERITEM_INVENKIND_ACC				int 				set @USERITEM_INVENKIND_ACC					= 4
	--declare @USERITEM_INVENKIND_DIRECT		int 				set @USERITEM_INVENKIND_DIRECT				= 40
	--declare @USERITEM_INVENKIND_INFO			int 				set @USERITEM_INVENKIND_INFO				= 60
	declare @USERITEM_INVENKIND_PET				int 				set @USERITEM_INVENKIND_PET					= 1000
	declare @USERITEM_INVENKIND_STEMCELL		int 				set @USERITEM_INVENKIND_STEMCELL			= 1040
	declare @USERITEM_INVENKIND_TREASURE		int					set @USERITEM_INVENKIND_TREASURE			= 1200


	-- ������ �Һз�
	declare @ITEM_SUBCATEGORY_UPGRADE_HOUSE		int					set @ITEM_SUBCATEGORY_UPGRADE_HOUSE 		= 60 	-- ��
	--declare @ITEM_SUBCATEGORY_USERFARM		int					set @ITEM_SUBCATEGORY_USERFARM	 			= 69	-- ��������
	declare @ITEM_SUBCATEGORY_ATTENDANCE		int					set @ITEM_SUBCATEGORY_ATTENDANCE 			= 900 	--�⼮(900)
	declare @ITEM_SUBCATEGORY_PET				int					set @ITEM_SUBCATEGORY_PET					= 1000 	--��(1000)

	-- ���� ���ǰ�
	declare @GIFTLIST_GIFT_KIND_MESSAGE			int					set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2
	--declare @GIFTLIST_GIFT_KIND_MESSAGE_DEL	int					set @GIFTLIST_GIFT_KIND_MESSAGE_DEL			= -1
	--declare @GIFTLIST_GIFT_KIND_GIFT_DEL		int					set @GIFTLIST_GIFT_KIND_GIFT_DEL			= -2
	--declare @GIFTLIST_GIFT_KIND_GIFT_GET		int					set @GIFTLIST_GIFT_KIND_GIFT_GET			= -3
	--declare @GIFTLIST_GIFT_KIND_GIFT_SELL		int					set @GIFTLIST_GIFT_KIND_GIFT_SELL			= -4
	--declare @GIFTLIST_GIFT_KIND_LIST			int					set @GIFTLIST_GIFT_KIND_LIST				= -5

	-- ��Ÿ �����
	declare @ID_MAX								int					set	@ID_MAX									= 10	-- ������ ������ �� �ִ� ���̵𰳼�.
	declare @USERMASTER_UPGRADE_STATE_NON		int					set @USERMASTER_UPGRADE_STATE_NON			= -1	--������, �Ϸ���.(����)
	declare @USERMASTER_UPGRADE_STATE_ING		int					set @USERMASTER_UPGRADE_STATE_ING			= 1		--�����ܰ�������.
	declare @USERSEED_NEED_EMPTY				int					set @USERSEED_NEED_EMPTY					= -1	-- (������)
	declare @USERSEED_NEED_BUY					int					set @USERSEED_NEED_BUY						= -2
	-- >= 0 �̻��̸� Ư�� �Ĺ��� �ɾ�������.
	declare @GAME_START_YEAR					int					set @GAME_START_YEAR						= 2013
	declare @GAME_START_MONTH					int					set @GAME_START_MONTH						= 3
	declare @FARM_BATTLE_PLAYCNT_MAX			int					set @FARM_BATTLE_PLAYCNT_MAX				= 10	-- ��ƲȽ��.


	-- ���忡 �۾���.
	--declare @BOARD_STATE_NON					int					set @BOARD_STATE_NON						= 0
	--declare @BOARD_STATE_REWARD				int					set @BOARD_STATE_REWARD						= 1
	declare @BOARD_STATE_REWARD_GAMECOST		int					set @BOARD_STATE_REWARD_GAMECOST			= 600

	-- īī���� ����.
	declare @KAKAO_MESSAGE_INVITE_ID			int					set @KAKAO_MESSAGE_INVITE_ID 				= 297	--�ʴ�.
	declare @KAKAO_MESSAGE_PROUD_ID				int					set @KAKAO_MESSAGE_PROUD_ID 				= 296	--�ڶ��ϱ�.
	declare @KAKAO_MESSAGE_HEART_ID				int					set @KAKAO_MESSAGE_HEART_ID 				= 295	--��Ʈ����.
	declare @KAKAO_MESSAGE_HELP_ID				int					set @KAKAO_MESSAGE_HELP_ID 					= 294	--������.
	declare @KAKAO_MESSAGE_RETURN_ID			int					set @KAKAO_MESSAGE_RETURN_ID				= 293	--����.

	--�޼��� ���ſ���.
	--declare @KAKAO_MESSAGE_ALLOW				int 				set @KAKAO_MESSAGE_ALLOW 				= -1
	declare @KAKAO_MESSAGE_BLOCK				int					set @KAKAO_MESSAGE_BLOCK 				= 1
	declare @KAKAO_MESSAGE_NON					int					set @KAKAO_MESSAGE_NON					= 0

	-- ��⺹�ͱ���.
	declare @RETURN_LIMIT_DAY					int					set @RETURN_LIMIT_DAY				= 30 	-- ���ϰ� �����ΰ�?.
	declare @RETURN_FLAG_OFF					int					set @RETURN_FLAG_OFF				= 0 	-- On(1), Off(0)
	declare @RETURN_FLAG_ON						int					set @RETURN_FLAG_ON					= 1 	-- On(1), Off(0)

	-- bool
	declare @BOOL_TRUE							int					set @BOOL_TRUE						= 1
	declare @BOOL_FALSE							int					set @BOOL_FALSE						= 0

	-- �α��� �޼���.
	declare @RECOMMAND_MESSAGE_SERVERID			int					set @RECOMMAND_MESSAGE_SERVERID		= @BOOL_FALSE
	declare @RECOMMAND_MESSAGE					varchar(256)		set @RECOMMAND_MESSAGE				= '������ ����ְ� ���� ��Ű���?\n���� �ı� �ۼ��� ���ֽø� 600�� ������ �帳�ϴ�.'
	declare @RECOMMAND_MESSAGE_ANDROIDPLUS		varchar(256)		set @RECOMMAND_MESSAGE_ANDROIDPLUS	= '\n���� ��÷�� ���� 10������ �����!\n *���̵� �ı⿡ ���� �����ø� ������ �������� ������ �� ����ϼ���.\n\n �ı� ����� ���̵� : [ff1100]'
	declare @RECOMMAND_MESSAGE_IPHONE			varchar(256)		set @RECOMMAND_MESSAGE_IPHONE		= '������ ����ְ� ���� ��Ű���?\n�ٸ� ģ������ �� �� �ֵ��� �ı⸦ �����ּ���!'

	-- ��Ÿ �������.
	declare @YABAU_CHANGE_DANGA					int					set @YABAU_CHANGE_DANGA				= 100		-- ����� �ֻ��� �����
	declare @USED_FRIEND_POINT					int					set @USED_FRIEND_POINT				= 100		-- ģ������Ʈ ����.
	declare @ANIMAL_COMPOSE_LEVEL				int					set @ANIMAL_COMPOSE_LEVEL			= 1			-- �ռ��� ������ ����.
	declare @FARM_BATTLE_OPEN_LV				int					set @FARM_BATTLE_OPEN_LV			= 20		-- �ռ��� ������ ����.
	declare @NEW_START_INIT_LV					int					set @NEW_START_INIT_LV				= 15		-- ���ν����ϱ� �ð��ʱ�ȭ��.
	declare @ANIMAL_LIMIT_TREASURE_VAL			int					set @ANIMAL_LIMIT_TREASURE_VAL		= 250		-- ������ ����ȿ��.

	-- �̺�Ʈ ���°�
	declare @EVENT_STATE_NON					int					set @EVENT_STATE_NON				= 0
	declare @EVENT_STATE_YES					int					set @EVENT_STATE_YES				= 1

	-- �����̱Ⱑ��.
	declare @MODE_ROULETTE_GRADE1_GAMECOST		int					set @MODE_ROULETTE_GRADE1_GAMECOST			= 100
	declare @MODE_ROULETTE_GRADE1_HEART			int					set @MODE_ROULETTE_GRADE1_HEART				= 101
	declare @MODE_ROULETTE_GRADE2_CASHCOST		int					set @MODE_ROULETTE_GRADE2_CASHCOST			= 102
	declare @MODE_ROULETTE_GRADE4_CASHCOST		int					set @MODE_ROULETTE_GRADE4_CASHCOST			= 103

	-- �����̱� ���� �Ķ����.
	declare @MODE_TREASURE_GRADE1_GAMECOST		int					set @MODE_TREASURE_GRADE1_GAMECOST			= 100
	declare @MODE_TREASURE_GRADE1_HEART			int					set @MODE_TREASURE_GRADE1_HEART				= 101
	declare @MODE_TREASURE_GRADE2_CASHCOST		int					set @MODE_TREASURE_GRADE2_CASHCOST			= 102
	declare @MODE_TREASURE_GRADE3_CASHCOST		int					set @MODE_TREASURE_GRADE3_CASHCOST			= 103

	--declare @ITEM_ZCP_PIECE_MOTHER			int					set @ITEM_ZCP_PIECE_MOTHER					= 3800	-- ¥����������.
	declare @ITEM_ZCP_TICKET_MOTHER				int					set @ITEM_ZCP_TICKET_MOTHER					= 3801	-- ¥������.

	---------------------------------------------------------
	-- ��Ʋ�� ��ų ����.
	-- ���ݷ� 	: 2 + (3 ) + 2		-> �ʹ��̺���
	-- ���  	: 2 + (3) + 2
	-- HP	  	: 1�ʴ� HP , 		�����ð�(��)
	-- TURN	  	: 1�ʴ� ���ҽð� , 	�����ð�(��)
	---------------------------------------------------------
	-- ���ݷ�.
	declare @SKILL_ATK_1						int					set @SKILL_ATK_1							= 2 	-- 1��(%)
	declare @SKILL_ATK_2						int					set @SKILL_ATK_2							= 15	-- 2��(%)
	declare @SKILL_ATK_3						int					set @SKILL_ATK_3							= 60	-- 3��(%)

	-- ����.
	declare @SKILL_DEF_1						int					set @SKILL_DEF_1							= 2		-- 1��(%)
	declare @SKILL_DEF_2						int					set @SKILL_DEF_2							= 14	-- 2��(%)
	declare @SKILL_DEF_3						int					set @SKILL_DEF_3							= 50	-- 3��(%)

	-- ������ �ð����� HP, �ּҰ��� (1�� 1HP, 2�� 2HP, 3�� 3HP).
	declare @SKILL_HP_1							int					set @SKILL_HP_1								= 1		-- 1��(%)
	declare @SKILL_HP_1_TIME					int					set @SKILL_HP_1_TIME						= 3		--    (s)
	declare @SKILL_HP_2							int					set @SKILL_HP_2								= 3		-- 2��(%)
	declare @SKILL_HP_2_TIME					int					set @SKILL_HP_2_TIME						= 3		--    (s)
	declare @SKILL_HP_3							int					set @SKILL_HP_3								= 6		-- 3��(%)
	declare @SKILL_HP_3_TIME					int					set @SKILL_HP_3_TIME						= 3		--    (s)

	-- ������ �ð����� Turn����.
	declare @SKILL_TURN_1						int					set @SKILL_TURN_1							= 150	-- 1��
	declare @SKILL_TURN_1_TIME					int					set @SKILL_TURN_1_TIME						= 3
	declare @SKILL_TURN_2						int					set @SKILL_TURN_2							= 600	-- 2��
	declare @SKILL_TURN_2_TIME					int					set @SKILL_TURN_2_TIME						= 3
	declare @SKILL_TURN_3						int					set @SKILL_TURN_3							= 1500	-- 3��
	declare @SKILL_TURN_3_TIME					int					set @SKILL_TURN_3_TIME						= 3

	---------------------------------------------------------
	-- ������ �ż��� ���.
	---------------------------------------------------------
	declare @DEALER_PLUS_STEP1					int					set @DEALER_PLUS_STEP1						= 1 +0
	declare @DEALER_PLUS_STEP2					int					set @DEALER_PLUS_STEP2						= 2 +0
	declare @DEALER_PLUS_STEP3					int					set @DEALER_PLUS_STEP3						= 3 +1
	declare @DEALER_PLUS_STEP4					int					set @DEALER_PLUS_STEP4						= 4 +1
	declare @DEALER_PLUS_STEP5					int					set @DEALER_PLUS_STEP5						= 5 +2
	declare @DEALER_PLUS_STEP6					int					set @DEALER_PLUS_STEP6						= 6 +2-1
	declare @DEALER_PLUS_STEP7					int					set @DEALER_PLUS_STEP7						= 7 +2-2
	declare @DEALER_PLUS_STEP8					int					set @DEALER_PLUS_STEP8						= 8 +3-3
	declare @DEALER_PLUS_STEP9					int					set @DEALER_PLUS_STEP9						= 9 +3-3
	declare @DEALER_PLUS_STEPM					int					set @DEALER_PLUS_STEPM						= 10+3-3-4 -- ���� �ֵ��� ���ؼ� ����� ���·� �̳� ��.

	----------------------------------------------
	-- Naver �̺�Ʈ ó��
	--	�Ⱓ : 7.24 ~ 8.6
	--	��ǥ : 8.11
	--	1. ���Խ� ...		=> ��ũ�� ��1����, ��� 60��
	--						   02_01����(���Ĺ���).sql
	--	2. ���� 2��			=> �����ϸ� 2�� �̺�Ʈ
	--						   21_01ĳ��(������).sql
	--						   21_02ĳ��(����������).sql
	--	3. Naverĳ��		=> ���̹� ĳ��
	------------------------------------------------
	--declare @EVENT07NHN_START_DAY				datetime			set @EVENT07NHN_START_DAY			= '2014-06-13 20:00'
	--declare @EVENT07NHN_END_DAY				datetime			set @EVENT07NHN_END_DAY				= '2014-08-06 23:59'

	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @sysfriendid			varchar(20)			set @sysfriendid 	= 'farmgirl'
	declare @comment				varchar(512)		set @comment		= '�α���'
	declare @comment2				varchar(128)
	declare @gameid 				varchar(20)
	declare @password 				varchar(20)
	declare @condate				datetime
	declare @deletestate			int
	declare @blockstate				int
	declare @cashcopy				int
	declare @resultcopy				int
	declare @cashcost				int
	declare @gamecost				int
	declare @goldticket				int					set @goldticket			= 0
	declare @goldticketmax			int					set @goldticketmax		= 0
	declare @goldtickettime			datetime			set @goldtickettime		= getdate()
	declare @battleticket			int					set @battleticket		= 0
	declare @battleticketmax		int					set @battleticketmax	= 0
	declare @battletickettime		datetime			set @battletickettime	= getdate()
	declare @battleanilistidx1		int					set @battleanilistidx1	= -1
	declare @battleanilistidx2		int					set @battleanilistidx2	= -1
	declare @battleanilistidx3		int					set @battleanilistidx3	= -1
	declare @battleanilistidx4		int					set @battleanilistidx4	= -1
	declare @battleanilistidx5		int					set @battleanilistidx5	= -1
	declare @tslistidx1				int					set @tslistidx1			= -1
	declare @tslistidx2				int					set @tslistidx2			= -1
	declare @tslistidx3				int					set @tslistidx3			= -1
	declare @tslistidx4				int					set @tslistidx4			= -1
	declare @tslistidx5				int					set @tslistidx5			= -1
	declare @tsskillcashcost		int					set @tsskillcashcost 	= 0
	declare @tsskillheart			int					set @tsskillheart 		= 0
	declare @tsskillgamecost		int					set @tsskillgamecost 	= 0
	declare @tsskillfpoint			int					set @tsskillfpoint 		= 0
	declare @tsskillrebirth			int					set @tsskillrebirth 	= 0
	declare @tsskillalba			int					set @tsskillalba 		= 0
	declare @tsskillbullet			int					set @tsskillbullet 		= 0
	declare @tsskillvaccine			int					set @tsskillvaccine 	= 0
	declare @tsskillfeed			int					set @tsskillfeed 		= 0
	declare @tsskillbooster			int					set @tsskillbooster 	= 0

	declare @market					int					set @market			= @MARKET_GOOGLE
	declare @version				int					set @version		= 101
	declare @gameyear				int					set @gameyear		= @GAME_START_YEAR
	declare @gamemonth				int					set @gamemonth		= @GAME_START_MONTH

	-- �ý��� ��������, MAX
	declare @fame 					int					set @fame			= 1
	declare @famelv 				int					set @famelv			= 1
	declare @famelvbest				int					set @famelvbest		= 1
	declare @feedmax				int					set @feedmax		= 10
	declare @heartmax				int					set @heartmax		= 20
	declare @fpointmax				int					set @fpointmax		= 500
	declare @curdate				datetime			set @curdate		= getdate()
	declare @housestep				int,	@housestate				int,	@housetime				datetime,		@housestepmax		int,
			@tankstep				int,	@tankstate				int,	@tanktime				datetime,		@tankstepmax		int,
			@bottlestep				int,	@bottlestate			int,	@bottletime				datetime,		@bottlestepmax		int,
			@pumpstep				int,	@pumpstate				int,	@pumptime				datetime,		@pumpstepmax		int,
			@transferstep			int,	@transferstate			int,	@transfertime			datetime,		@transferstepmax	int,
			@purestep				int,	@purestate				int,	@puretime				datetime,		@purestepmax		int,
			@freshcoolstep			int,	@freshcoolstate			int,	@freshcooltime			datetime,		@freshcoolstepmax	int,
			@invenstepmax			int,	@invencountmax			int,	@seedfieldmax			int

	-- �Һ������
	declare @bulletlistidx			int,
			@vaccinelistidx			int,
			@albalistidx			int,
			@boosterlistidx			int,
			@tmpcnt					int,
			@tmpitemcode			int,
			@invenkind 				int

	declare @newday					int
	declare @pettodayitemcode		int						set @pettodayitemcode	= -1		-- ���ø� ��õ ��
	declare @pettodayitemcode2		int						set @pettodayitemcode2	= -1		--        ü�� ��

	-- �⼮��
	declare @attenddate				datetime,
			@attendcnt				int,
			@attendnewday			int
	declare @attenditemcode			int						set @attenditemcode		= -1
	declare @attenditemcodecnt		int						set @attenditemcodecnt	=  0
	declare @attendcomment			varchar(20)

	declare @curversion				int						set @curversion		= -1
	declare @cursyscheck			int

	declare @heartsenddate			datetime				set @heartsenddate 	= getdate()		-- ��Ʈ ���� ���۷�.
	declare @heartsendcnt			int						set @heartsendcnt	= 9999
	declare @zcpappearcnt			int						set @zcpappearcnt	= 9999
	declare @anibuydate				datetime				set @anibuydate 	= getdate()		-- ���� �������۷�.
	declare @anibuycnt				int						set @anibuycnt		= 9999
	declare @wheeltodaydate			datetime				set @wheeltodaydate = getdate()		-- ����귿
	declare @wheeltodaycnt			int						set @wheeltodaycnt	= 9999

	-- �ð�üŷ
	declare @dateid10 				varchar(10) 			set @dateid10 		= Convert(varchar(8), Getdate(),112) + Convert(varchar(2), Getdate(), 108)
	declare @dateid8 				varchar(8) 				set @dateid8 		= Convert(varchar(8), Getdate(),112)
	declare @rand					int
	declare @logindate				varchar(8)				set @logindate		= '20100101'

	-- �Ϲݺ�����
	declare @schoolinitdate			varchar(19),
			@dw						int,
			@schoolname				varchar(128),
			@schoolidx				int
	-- �б����� ���.
	declare @schoolresult			int						set @schoolresult	= 1		-- tUserMaster
	declare @schoolresult2			int						set @schoolresult2	= 1		-- ���۰��.
	declare @schoolresult3			int						set @schoolresult3	= 1		-- tSchoolResult
	declare @farmharvest			int						set @farmharvest	= 0
	declare @sendheart				int						set @sendheart		= 0
	declare @friendinvite			int						set @friendinvite	= 0

	-- ��Ʈ���� ��������.
	declare @heartget				int						set @heartget		= 0
	declare @heartmsg				varchar(128)			set @heartmsg		= ''

	-- 1�� �ʴ� �ο� �ʱ�ȭ.
	declare @kakaomsginvitetodaycnt		int			set @kakaomsginvitetodaycnt		= 0
	declare @kakaomsginvitetodaydate	datetime	set @kakaomsginvitetodaydate	= getdate()

	-- �ڽ��� ��������.
	declare @kakaoprofile			varchar(512)
	declare @kkhelpalivecnt			int				set @kkhelpalivecnt				= 0

	-- �Ǽ��縮 ���� ����.
	declare @roulaccprice			int				set @roulaccprice 				= 10 -- �Ǽ�10����.
	declare @roulaccsale			int				set @roulaccsale 				= 10 -- 10%.

	-- �̺�Ʈ1 > �α��θ��ϸ�
	--declare @eventonedailystate		int				set @eventonedailystate 		= @EVENT_STATE_NON
	--declare @eventonedailyloop		int

	-- �̺�Ʈ2 > ������ �ð��� �α����ϸ� ��������~~~
	declare @eventstatemaster		int				set @eventstatemaster			= @EVENT_STATE_NON
	declare @eventidx				int				set @eventidx					= -1
	declare @eventidx2				int
	declare @eventitemcode			int				set @eventitemcode				= -1
	declare @eventcnt				int				set @eventcnt					= 0
	declare @eventsender 			varchar(20)		set @eventsender				= '¥�� �ҳ�'
	declare @strmarket				varchar(40)
	declare @curyear				int				set @curyear					= DATEPART("yy", @curdate)
	declare @curmonth				int				set @curmonth					= DATEPART("mm", @curdate)
	declare @curday					int				set @curday						= DATEPART(dd, @curdate)
	declare @curhour				int				set @curhour					= DATEPART(hour, @curdate)

	-- ����Ʈ ��ȯ����.
	declare @comreward				int				set @comreward					= 90106
	declare @idx2					int				set @idx2 						= 0
	declare @USER_LIST_MAX			int				set @USER_LIST_MAX 				= 50	-- ���� 50���� �����Ѵ�.
	declare @COMREWARD_RECYCLE		int				set @COMREWARD_RECYCLE			= 90154

	-- �űԸ���.
	declare @farmidx				int				set @farmidx					= 0

	-- �߹��� ����.
	declare @yabauidx				int				set @yabauidx					= -1	-- -2:�������, -1:�������, 1 >= �߹��� ��ȣ
	declare @yabaustep				int				set @yabaustep					= 0

	-- ���� ó��.
	declare @rtnflag				int														-- ���纹�� �÷��� ����.
	declare @rtngameid				varchar(20)		set @rtngameid					= ''
	declare @rtndate				datetime		set @rtndate					= getdate() - 1
	declare @rtnstep				int				set @rtnstep					= 0		-- 1���� 1, 2���� 2....
	declare @rtnplaycnt				int				set @rtnplaycnt					= 0		-- �ŷ�Ƚ��.
	declare @rtnitemcode			int				set @rtnitemcode				= 5027	-- ����5.

	-- VIPȿ��.
	declare @cashpoint				int				set @cashpoint					= 0
	declare @vip_plus				int				set @vip_plus					= 0

	-- SKT ����ù���� 1�� Ŭ����.
	declare @eventspot08			int				set @eventspot08				= 0


Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG �Է�����', @gameid_ gameid_, @password_ password_, @market_ market_, @version_ version_

	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	select
		@gameid 		= gameid,			@password		= password,			@condate			= condate,
		@fame			= fame,				@famelv			= famelv,			@famelvbest			= famelvbest,
		@blockstate 	= blockstate, 		@deletestate 	= deletestate,
		@cashcopy 		= cashcopy, 		@resultcopy 	= resultcopy,
		@gamecost 		= gamecost,
		@cashcost 		= cashcost,
		@feedmax		= feedmax,
		@heartmax		= heartmax,
		@fpointmax		= fpointmax,
		@cashpoint		= cashpoint,
		@goldticket		= goldticket, 		@goldticketmax 	= goldticketmax, 	@goldtickettime		= goldtickettime,
		@battleticket	= battleticket, 	@battleticketmax= battleticketmax, 	@battletickettime	= battletickettime,
		@battleanilistidx1= battleanilistidx1, @battleanilistidx2= battleanilistidx2, @battleanilistidx3= battleanilistidx3, @battleanilistidx4= battleanilistidx4, @battleanilistidx5= battleanilistidx5,
		@tslistidx1		= tslistidx1, 		@tslistidx2		= tslistidx2, 		@tslistidx3		= tslistidx3, 				@tslistidx4		= tslistidx4, 			@tslistidx5		= tslistidx5,
		@schoolidx		= schoolidx,
		@schoolresult	= schoolresult,
		@heartget		= heartget,
		@logindate		= logindate,
		@comreward		= comreward,
		@yabauidx		= yabauidx,
		@yabaustep		= yabaustep,
		@market			= market,
		@version		= version,
		@gameyear		= gameyear,
		@gamemonth		= gamemonth,
		@tsskillcashcost= tsskillcashcost,	@tsskillheart	= tsskillheart,		@tsskillgamecost	= tsskillgamecost,
		@tsskillfpoint	= tsskillfpoint,	@tsskillrebirth	= tsskillrebirth,	@tsskillalba		= tsskillalba,
		@tsskillbullet	= tsskillbullet,	@tsskillvaccine	= tsskillvaccine,	@tsskillfeed		= tsskillfeed,			@tsskillbooster		= tsskillbooster,

		@housestep		= housestep,		@housestate		= housestate,		@housetime		= housetime,
		@tankstep		= tankstep,			@tankstate		= tankstate,		@tanktime 		= tanktime,
		@bottlestep		= bottlestep,		@bottlestate 	= bottlestate,		@bottletime		= bottletime,
		@pumpstep		= pumpstep,			@pumpstate		= pumpstate,		@pumptime		= pumptime,
		@transferstep	= transferstep,		@transferstate	= transferstate,	@transfertime 	= transfertime,
		@purestep		= purestep,			@purestate		= purestate,		@puretime 		= puretime,
		@freshcoolstep	= freshcoolstep,	@freshcoolstate	= freshcoolstate,	@freshcooltime 	= freshcooltime,

		@bulletlistidx	= bulletlistidx,
		@vaccinelistidx	= vaccinelistidx,
		@albalistidx	= albalistidx,
		@boosterlistidx	= boosterlistidx,
		@eventspot08	= eventspot08,

		@kakaomsginvitetodaycnt 	= kakaomsginvitetodaycnt,
		@kakaomsginvitetodaydate	= kakaomsginvitetodaydate,
		@kakaoprofile				= kakaoprofile,
		@kkhelpalivecnt				= kkhelpalivecnt,

		@rtngameid		= rtngameid, 		@rtndate	= rtndate,
		@rtnstep		= rtnstep, 			@rtnplaycnt	= rtnplaycnt,

		@pettodayitemcode	= pettodayitemcode,
		@pettodayitemcode2	= pettodayitemcode2,
		@attenddate 		= attenddate, 		@attendcnt 		= attendcnt,
		@heartsenddate		= heartsenddate, 	@heartsendcnt	= heartsendcnt,	@zcpappearcnt	= zcpappearcnt,
		@anibuydate			= anibuydate, 		@anibuycnt	= anibuycnt,
		@wheeltodaydate		= wheeltodaydate, 	@wheeltodaycnt	= wheeltodaycnt
	from dbo.tUserMaster
	where gameid = @gameid_
	--select 'DEBUG ��������', @gameid gameid, @blockstate blockstate, @deletestate deletestate, @cashcopy cashcopy, @resultcopy resultcopy, @gamecost gamecost, @cashcost cashcost, @attenddate attenddate, @attendcnt attendcnt

	------------------------------------------------
	--	3-3. �������� üũ
	------------------------------------------------
	select top 1 @cursyscheck = syscheck, @curversion = version from dbo.tNotice
	where market = @market_
	order by idx desc
	--select 'DEBUG ��������', @cursyscheck cursyscheck, @curversion curversion

	if(@cursyscheck = @SYSCHECK_YES)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_SERVER_CHECKING
			set @comment 	= 'DEBUG �ý��� �������Դϴ�.'
			--select 'DEBUG ', @comment
		END
	else if(isnull(@gameid, '') = '')
		BEGIN
			-- ���̵� ���������ʴ°�??
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '���̵� �������� �ʴ´�. > ���̵� Ȯ���ض�.'
			--select 'DEBUG ', @comment
		END
	else if(isnull(@password, '') = '' or @password != @password_)
		BEGIN
			-- ���̵� & �н����� ���������ʴ°�??
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_PASSWORD
			set @comment 	= '�н����� Ʋ�ȴ�. > �н����� Ȯ���ض�'
			--select 'DEBUG ', @comment
		END
	else if(@version_ < @curversion)
		BEGIN
			-- ���Ϻ� ������ Ʋ����
			set @nResult_ 	= @RESULT_NEWVERION_CLIENT_DOWNLOAD
			set @comment 	= '���Ϻ� ������ Ʋ����. > �ٽù޾ƶ�.'
			--select 'DEBUG ', @comment
		END
	else if (@blockstate = @BLOCK_STATE_YES)
		BEGIN
			-- �������ΰ�?
			set @nResult_ 	= @RESULT_ERROR_BLOCK_USER
			set @comment 	= '��ó���� ���̵��Դϴ�.'
			--select 'DEBUG ', @comment
		END
	else if (@deletestate = @DELETE_STATE_YES)
		BEGIN
			-- ���������ΰ�?
			set @nResult_ 	= @RESULT_ERROR_DELETED_USER
			set @comment 	= '������ ���̵��Դϴ�.'
			--select 'DEBUG ', @comment
		END
	else if(@cashcopy >= 2)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_BLOCK_USER
			set @comment 	= 'ĳ������ī�Ǹ� '+ltrim(rtrim(str(@cashcopy)))+'ȸ �̻��ߴ�. > ��ó������!!'
			--select 'DEBUG ', @comment

			-- xxȸ �̻�ī���ൿ > ��ó��, ���αױ��
			update dbo.tUserMaster
				set
					blockstate = @BLOCK_STATE_YES,
					cashcopy = 0
			where gameid = @gameid_

			-- ������3ȸ ī�ǿ� ���� ��ó��
			insert into dbo.tUserBlockLog(gameid, comment)
			values(@gameid_, '(ĳ������)��  '+ltrim(rtrim(str(@cashcopy)))+'ȸ �̻� ī�Ǹ� �ؼ� �α��ν� �ý��ۿ��� �� ó���߽��ϴ�.')
		END
	else if(@resultcopy >= 20)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_BLOCK_USER
			set @comment 	= '����������� '+ltrim(rtrim(str(@resultcopy)))+'ȸ�̻� �õ��ߴ�. > ��ó������!!'
			--select 'DEBUG ', @comment

			--��������� xxȸ �̻��ߴ�. > ��ó��, ���αױ��
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
			set @comment 	= '�α��� ����ó��'
			--select 'DEBUG ', @comment
		END


	-----------------------------------------------
	-- ����ڵ�ó��.
	-----------------------------------------------
	select @nResult_ rtn, @comment comment

	if(@nResult_ = @RESULT_SUCCESS)
		BEGIN
				------------------------------------------------
			-- ���� �̵� ���� ����
			------------------------------------------------
			--select 'DEBUG ', @market_ market_, @version_ version_, @market market, @version version
			 if(@market != @market_)
				begin
					insert into dbo.tUserBeforeInfo(gameid,  market, marketnew,  version,  fame,  famelv,  famelvbest,  gameyear,  gamemonth)
					values(                        @gameid, @market, @market_,  @version, @fame, @famelv, @famelvbest, @gameyear, @gamemonth)
				end


			-----------------------------------------------
			-- �̺�Ʈ ó��
			-----------------------------------------------
			--select 'DEBUG �̺�Ʈ ó��'

			-----------------------------------------------
			-- SKT ����ù���� 1�� Ŭ����.
			-----------------------------------------------
			--select 'DEBUG �̺�Ʈ ó��'
			if( @market_ = @MARKET_SKT and @eventspot08 <= 0 )
				begin
					--select 'DEBUG SKT ���� Ŭ���� 1ȸ��.'
					update dbo.tCashFirstTimeLog
						set
							writedate = writedate - 30
					where gameid = @gameid_

					set @eventspot08 = @eventspot08 + 1

				end

			------------------------------------------------
			-- Ƽ�� ���� ����.
			------------------------------------------------
			select
				@goldtickettime = rtndate,
				@goldticket		= rtncount
			from dbo.fnu_GetActionTime(@goldtickettime, getdate(), @goldticket, @goldticketmax)
			--select 'DEBUG ', @goldtickettime goldtickettime, @goldticket goldticket, @goldticketmax goldticketmax

			select
				@battletickettime 	= rtndate,
				@battleticket		= rtncount
			from dbo.fnu_GetActionTime(@battletickettime, getdate(), @battleticket, @battleticketmax)
			--select 'DEBUG ', @battletickettime battletickettime, @battleticket battleticket, @battleticketmax battleticketmax

			-----------------------------------------------
			-- ��Ʋ�������� ��ũ�˻�
			-----------------------------------------------
			if(@battleanilistidx1 != -1 and not exists(select top 1 * from dbo.tUserItem where gameid = @gameid and listidx = @battleanilistidx1))
				begin
						set @battleanilistidx1 = -1
				end

			if(@battleanilistidx2 != -1 and not exists(select top 1 * from dbo.tUserItem where gameid = @gameid and listidx = @battleanilistidx2))
				begin
						set @battleanilistidx2 = -1
				end

			if(@battleanilistidx3 != -1 and not exists(select top 1 * from dbo.tUserItem where gameid = @gameid and listidx = @battleanilistidx3))
				begin
						set @battleanilistidx3 = -1
				end

			if(@battleanilistidx4 != -1 and not exists(select top 1 * from dbo.tUserItem where gameid = @gameid and listidx = @battleanilistidx4))
				begin
						set @battleanilistidx4 = -1
				end

			if(@battleanilistidx5 != -1 and not exists(select top 1 * from dbo.tUserItem where gameid = @gameid and listidx = @battleanilistidx5))
				begin
						set @battleanilistidx5 = -1
				end

			-----------------------------------------------
			-- ���� ��ũ�˻�.
			-----------------------------------------------
			if(@tslistidx1 != -1 and not exists(select top 1 * from dbo.tUserItem where gameid = @gameid and listidx = @tslistidx1 and invenkind = @USERITEM_INVENKIND_TREASURE))
				begin
						set @tslistidx1 = -1
				end

			if(@tslistidx2 != -1 and not exists(select top 1 * from dbo.tUserItem where gameid = @gameid and listidx = @tslistidx2 and invenkind = @USERITEM_INVENKIND_TREASURE))
				begin
						set @tslistidx2 = -1
				end

			if(@tslistidx3 != -1 and not exists(select top 1 * from dbo.tUserItem where gameid = @gameid and listidx = @tslistidx3 and invenkind = @USERITEM_INVENKIND_TREASURE))
				begin
						set @tslistidx3 = -1
				end

			if(@tslistidx4 != -1 and not exists(select top 1 * from dbo.tUserItem where gameid = @gameid and listidx = @tslistidx4 and invenkind = @USERITEM_INVENKIND_TREASURE))
				begin
						set @tslistidx4 = -1
				end

			if(@tslistidx5 != -1 and not exists(select top 1 * from dbo.tUserItem where gameid = @gameid and listidx = @tslistidx5 and invenkind = @USERITEM_INVENKIND_TREASURE))
				begin
						set @tslistidx5 = -1
				end

			------------------------------------------------
			-- ������ ��ȯ������ �����Ѵ�.
			------------------------------------------------
			if(@comreward = -1)
				begin
					select @idx2 = isnull(max(idx2), 1) from dbo.tComReward where gameid = @gameid_
					set @idx2 = @idx2 + 1

					delete dbo.tComReward where gameid = @gameid_ and idx2 < @idx2 - @USER_LIST_MAX

					set @comreward = @COMREWARD_RECYCLE
				end

			-----------------------------------------------
			-- �����ü��� > 0 and �ð����������°�? > �����ܰ�� ǥ��, ������(-1)�� ����
			-- �׼����� �̱� �Ϻ� ���� �ý��ۿ��� ������.
			-----------------------------------------------
			select top 1
				@housestepmax		= housestepmax,
				@tankstepmax		= tankstepmax, 			@bottlestepmax		= bottlestepmax,
				@pumpstepmax 		= pumpstepmax,			@transferstepmax 	= transferstepmax,
				@purestepmax		= purestepmax, 		 	@freshcoolstepmax 	= freshcoolstepmax,
				@invenstepmax 		= invenstepmax, 		@invencountmax 		= invencountmax, 		@seedfieldmax 		= seedfieldmax,
				@rtnflag			= rtnflag,
				@roulaccprice 		= roulaccprice,
				@roulaccsale		= roulaccsale
			from dbo.tSystemInfo
			order by idx desc
			--select 'DEBUG �����ü��� max', @housestepmax housestepmax, @tankstepmax tankstepmax, @bottlestepmax bottlestepmax, @pumpstepmax pumpstepmax, @transferstepmax transferstepmax, @purestepmax purestepmax, @freshcoolstepmax freshcoolstepmax, @invenstepmax invenstepmax, @invencountmax invencountmax, @seedfieldmax seedfieldmax

			--select 'DEBUG ����(����)', @housestate housestate, @housestep housestep, @housestepmax housestepmax, @housetime housetime
			if(@housestate = @USERMASTER_UPGRADE_STATE_ING and @curdate >= @housetime)
				begin
					set @housestate = @USERMASTER_UPGRADE_STATE_NON
					set @housestep	= CASE
											WHEN (@housestep + 1 < @housestepmax) THEN @housestep + 1
											ELSE @housestepmax
									  END

					-- �����ۿϷ� > ����, ��Ʈ �ƽ�Ȯ��.
					select
						@feedmax		= param5,
						@heartmax		= param6,
						@fpointmax		= param9
					from dbo.tItemInfo
					where subcategory = @ITEM_SUBCATEGORY_UPGRADE_HOUSE and param1 = @housestep
				end
			else
				begin
					-- �����ۿϷ� > ����, ��Ʈ �ƽ�Ȯ��.
					select
						@feedmax		= param5,
						@heartmax		= param6,
						@fpointmax		= param9
					from dbo.tItemInfo
					where subcategory = @ITEM_SUBCATEGORY_UPGRADE_HOUSE and param1 = @housestep
				end
			--select 'DEBUG ����(����)', @housestate housestate, @housestep housestep, @housestepmax housestepmax, @housetime housetime

			--select 'DEBUG ����(��ũ��)', @tankstate tankstate, @tankstep tankstep, @tankstepmax tankstepmax, @tanktime tanktime
			if(@tankstate = @USERMASTER_UPGRADE_STATE_ING and @curdate >= @tanktime)
				begin
					set @tankstate = @USERMASTER_UPGRADE_STATE_NON
					set @tankstep	= CASE
											WHEN (@tankstep + 1 < @tankstepmax) THEN @tankstep + 1
											ELSE @tankstepmax
									  END
				end
			--select 'DEBUG ����(��ũ��)', @tankstate tankstate, @tankstep tankstep, @tankstepmax tankstepmax, @tanktime tanktime

			--select 'DEBUG ����(�絿����)', @bottlestate bottlestate, @bottlestep bottlestep, @bottlestepmax bottlestepmax, @bottletime bottletime
			if(@bottlestate = @USERMASTER_UPGRADE_STATE_ING and @curdate >= @bottletime)
				begin
					set @bottlestate = @USERMASTER_UPGRADE_STATE_NON
					set @bottlestep	= CASE
											WHEN (@bottlestep + 1 < @bottlestepmax) THEN @bottlestep + 1
											ELSE @bottlestepmax
									  END
				end
			--select 'DEBUG ����(�絿����)', @bottlestate bottlestate, @bottlestep bottlestep, @bottlestepmax bottlestepmax, @bottletime bottletime


			--select 'DEBUG ����(��������)', @pumpstate pumpstate, @pumpstep pumpstep, @pumpstepmax pumpstepmax, @pumptime pumptime
			if(@pumpstate = @USERMASTER_UPGRADE_STATE_ING and @curdate >= @pumptime)
				begin
					set @pumpstate = @USERMASTER_UPGRADE_STATE_NON
					set @pumpstep	= CASE
											WHEN (@pumpstep + 1 < @pumpstepmax) THEN @pumpstep + 1
											ELSE @pumpstepmax
									  END
				end
			--select 'DEBUG ����(��������)', @pumpstate pumpstate, @pumpstep pumpstep, @pumpstepmax pumpstepmax, @pumptime pumptime

			--select 'DEBUG ����(���Ա���)', @transferstate transferstate, @transferstep transferstep, @transferstepmax transferstepmax, @transfertime transfertime
			if(@transferstate = @USERMASTER_UPGRADE_STATE_ING and @curdate >= @transfertime)
				begin
					set @transferstate = @USERMASTER_UPGRADE_STATE_NON
					set @transferstep	= CASE
											WHEN (@transferstep + 1 < @transferstepmax) THEN @transferstep + 1
											ELSE @transferstepmax
									  END
				end
			--select 'DEBUG ����(���Ա���)', @transferstate transferstate, @transferstep transferstep, @transferstepmax transferstepmax, @transfertime transfertime



			--select 'DEBUG ����(��ȭ��)', @purestate purestate, @purestep purestep, @purestepmax purestepmax, @puretime puretime
			if(@purestate = @USERMASTER_UPGRADE_STATE_ING and @curdate >= @puretime)
				begin
					set @purestate = @USERMASTER_UPGRADE_STATE_NON
					set @purestep	= CASE
											WHEN (@purestep + 1 < @purestepmax) THEN @purestep + 1
											ELSE @purestepmax
									  END
				end
			--select 'DEBUG ����(��ȭ��)', @purestate purestate, @purestep purestep, @purestepmax purestepmax, @puretime puretime

			--select 'DEBUG ����(���º���)', @freshcoolstate freshcoolstate, @freshcoolstep freshcoolstep, @freshcoolstepmax freshcoolstepmax, @freshcooltime freshcooltime
			if(@freshcoolstate = @USERMASTER_UPGRADE_STATE_ING and @curdate >= @freshcooltime)
				begin
					set @freshcoolstate = @USERMASTER_UPGRADE_STATE_NON
					set @freshcoolstep	= CASE
											WHEN (@freshcoolstep + 1 < @freshcoolstepmax) THEN @freshcoolstep + 1
											ELSE @freshcoolstepmax
									  END
				end
			--select 'DEBUG ����(���º�����)', @freshcoolstate freshcoolstate, @freshcoolstep freshcoolstep, @freshcoolstepmax freshcoolstepmax, @freshcooltime freshcooltime


			-----------------------------------------------
			-- (�Ҹ��۽��� -> �ش�����۰��� 0) �Ҹ��۽��ι�ȣ -1�� ó��(���)
			-----------------------------------------------
			--select 'DEBUG �Ҹ��� ��������', @bulletlistidx bulletlistidx, @vaccinelistidx vaccinelistidx, @albalistidx albalistidx, @boosterlistidx boosterlistidx

			set @tmpcnt = 0
			select @tmpcnt = cnt, @invenkind = invenkind from dbo.tUserItem where gameid = @gameid and listidx = @bulletlistidx
			if(@bulletlistidx != -1 and (@tmpcnt <= 0 or @invenkind != @USERITEM_INVENKIND_CONSUME ))
				begin
					--select 'DEBUG �Ѿ� �ٻ���ؼ� ���Ի���, ������ Ŭ����'
					set @bulletlistidx 		= -1
				end

			set @tmpcnt = 0
			select @tmpcnt = cnt, @invenkind = invenkind from dbo.tUserItem where gameid = @gameid and listidx = @vaccinelistidx
			if(@vaccinelistidx != -1 and (@tmpcnt <= 0 or @invenkind != @USERITEM_INVENKIND_CONSUME ))
				begin
					--select 'DEBUG ��� �ٻ���ؼ� ���Ի���, ������ Ŭ����'
					set @vaccinelistidx 	= -1
				end

			set @tmpcnt = 0
			select @tmpcnt = cnt, @invenkind = invenkind from dbo.tUserItem where gameid = @gameid and listidx = @albalistidx
			if(@albalistidx != -1 and (@tmpcnt <= 0 or @invenkind != @USERITEM_INVENKIND_CONSUME ))
				begin
					--select 'DEBUG �˹� �ٻ���ؼ� ���Ի���, ������ Ŭ����'
					set @albalistidx 		= -1
				end

			set @tmpcnt = 0
			select @tmpcnt = cnt, @invenkind = invenkind from dbo.tUserItem where gameid = @gameid and listidx = @boosterlistidx
			if(@boosterlistidx != -1 and (@tmpcnt <= 0 or @invenkind != @USERITEM_INVENKIND_CONSUME ))
				begin
					--select 'DEBUG ������ �ٻ���ؼ� ���Ի���, ������ Ŭ����'
					set @boosterlistidx 	= -1
				end

			-- ��Ȱ���� �κ��� ���� �ȵǴ� ��찡 �־ �������δ� Ȯ�κҰ����� ���� ������....
			-- ��� �Ҹ��۵� �߿��� ������ ���� ���� ���� ����� �ȴ�.
			delete from dbo.tUserItem where gameid = @gameid and invenkind = @USERITEM_INVENKIND_CONSUME and cnt <= 0

			-- ¥������ ����Ǹ� ������.
			if( exists(select top 1 * from dbo.tUserItem where gameid = @gameid and itemcode = @ITEM_ZCP_TICKET_MOTHER and expiredate < getdate() ) )
				begin
					--select 'DEBUG ��������.'
					exec spu_DeleteUserExpire @gameid_
				end

			-----------------------------------------------
			-- ���� ���� > 10���̻� > (������ �˻���)
			-----------------------------------------------
			-- ���⼭ ����.

			-------------------------------------------------
			---- ���� ���� > ��������(������ �̵���)
			-------------------------------------------------
			-- ���⼭ ����.

			-------------------------------------------------
			---- ī�� �ʴ��ο� �ʱ�ȭ.
			-------------------------------------------------
			set @tmpcnt = datediff(d, @kakaomsginvitetodaydate, getdate())
			if(@tmpcnt >= 1)
				begin
					set @kakaomsginvitetodaycnt		= 0
					set @kakaomsginvitetodaydate 	= getdate()
				end

			-- ī�� ��������.
			if(isnull(@kakaoprofile_, '') != '')
				begin
					set @kakaoprofile = @kakaoprofile_
				end

			-----------------------------------------------
			-- 28�ϰ� �⼮ ����ޱ�
			-- 1 -> 2 -> ... -> 28 (�ݺ�)
			--  datediff(d, @attenddate, @curdate) > �����̸� �˷��ش�.
			-- 	'2016-01-09 00:00'		'2016-01-29 00:01' 	20��
			-- 	'2016-01-28 00:01'		'2016-01-29 00:01' 	1��
			-- 	'2016-01-28 23:59'		'2016-01-29 00:01' 	1��		* �����̸� ������;
			-- 	'2016-01-29 00:00'		'2016-01-29 23:59' 	1��
			-----------------------------------------------
			set @tmpcnt = datediff(d, @attenddate, @curdate)
			set @newday = @tmpcnt
			set @attendnewday 	= case when @newday >= 1 then 1 else 0 end
			--set @eventonedailystate = case when @newday >= 1 then @EVENT_STATE_YES else @EVENT_STATE_NON end
			--select 'DEBUG ', @tmpcnt tmpcnt, @newday newday, @attendcnt attendcnt

			if(@newday >= 1)
				begin
					set @attenddate 	= getdate()
					set @attendcnt 		= @attendcnt + 1
					set @attendcnt 		= case when @attendcnt > 28 then 1 else @attendcnt end

					select
						@attenditemcode 	= param2,
						@attenditemcodecnt	= param3
					from dbo.tItemInfo where subcategory = @ITEM_SUBCATEGORY_ATTENDANCE and param1 = @attendcnt
					--select 'DEBUG �⼮�� ����', @attenddate attenddate, @attendcnt attendcnt, @attenditemcode attenditemcode, @attenditemcodecnt attenditemcodecnt

					if(@attenditemcode != -1 and @attenditemcodecnt > 0)
						begin
							--select 'DEBUG ����'
							set @attendcomment = rtrim( ltrim( str( @attendcnt ) ) ) + '�Ϻ���'
							exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT,  @attenditemcode, @attenditemcodecnt, @attendcomment, @gameid_, ''
						end
				end

			-----------------------------------------------
			-- �����⼮ -> ¥�����������귿 ����Ƚ�� �ʱ�ȭ.
			-----------------------------------------------
			if(@newday >= 1)
				begin
					set @zcpappearcnt 	= 0;
				end

			-----------------------------------------------
			-- ��Ʈ ���� ���差 �ʱ�ȭ��¥.
			-----------------------------------------------
			set @tmpcnt = datediff(d, @heartsenddate, @curdate)
			if(@tmpcnt >= 1)
				begin
					set @heartsenddate 	= getdate()
					set @heartsendcnt 	= 0;
				end

			-----------------------------------------------
			-- ���� ���� ���差 �ʱ�ȭ��¥.
			-----------------------------------------------
			set @tmpcnt = datediff(d, @anibuydate, @curdate)
			if(@tmpcnt >= 1)
				begin
					set @anibuydate 	= getdate()
					set @anibuycnt	 	= 0;
				end

			-----------------------------------------------
			-- ���� ���� ���差 �ʱ�ȭ��¥.
			-----------------------------------------------
			set @tmpcnt = datediff(d, @wheeltodaydate, @curdate)
			if(@tmpcnt >= 1)
				begin
					set @wheeltodaydate = getdate()
					set @wheeltodaycnt	= 0;
				end

			-----------------------------------------------
			-- ���� ����ȿ�� ó��.
			-- 	������		5000		�⼮�� 5~30��� �����Ѵ�(50)
			--	��Ʈ����		2000		�⼮�� 20~40��Ʈ�� �����Ѵ�(51)
			-- 	���λ���		5100		�⼮�� 2000 ~ 9000�� ���λ����Ѵ�(52)	-> ������ ���� ����ǵ��� ����.
			-- 	��������		1900		�⼮�� 50~100��������Ʈ �����Ѵ�(53)
			--	��Ȱ������		1200		�⼮�� ��Ȱ�� 1~3�� �����Ѵ�(54)
			--	�˹ٻ���		1002		�⼮�� �˹��� ���� 2~5�� �����Ѵ�(55)
			--	Ư��ź ����		702			�⼮�� Ư��ź 4~10�� �����Ѵ�(56)
			-- 	���۹�Ż���	802			�⼮�� ���۹�� 3~5�� �����Ѵ�(57)
			-- 	���ʻ���		900			�⼮�� ���� 50~90�� �����Ѵ�(58)
			--	Ư������������	1103		�⼮�� Ư�������� 3~5�� �����Ѵ�(59)
			-----------------------------------------------
			--select 'DEBUG ��������ȿ��', @tsskillcashcost tsskillcashcost, @tsskillheart tsskillheart, @tsskillgamecost tsskillgamecost, @tsskillfpoint tsskillfpoint, @tsskillrebirth tsskillrebirth, @tsskillalba tsskillalba, @tsskillbullet tsskillbullet, @tsskillvaccine tsskillvaccine, @tsskillfeed tsskillfeed, @tsskillbooster tsskillbooster
			--------------------------------------
			-- �ӽ����̺� �����صα�.
			--------------------------------------
			DECLARE @tTempTreasureReward TABLE(
				itemcode	int,
				cnt			int
			);

			if(@newday >= 1)
				begin
					set @rand = Convert(int, ceiling(RAND() * 100))
					--select 'DEBUG ', @rand rand

					if( @tsskillcashcost > 0 and @rand <= @tsskillcashcost )
						begin
							set @tmpcnt = 5 + Convert(int, ceiling(RAND() * 25))
							set @tmpitemcode= 5000
							--select 'DEBUG > ������', @tmpcnt tmpcnt
							exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT, @tmpitemcode, @tmpcnt, '�����꺸��', @gameid_, ''

							-- �����߼�.
							insert into @tTempTreasureReward(itemcode, cnt) values( @tmpitemcode, @tmpcnt );
						end

					if( @tsskillheart > 0 and @rand <= @tsskillheart )
						begin
							set @tmpcnt = 100 + Convert(int, ceiling(RAND() * 100))
							set @tmpitemcode= 2000
							--select 'DEBUG > ��Ʈ����', @tmpcnt tmpcnt
							exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT, @tmpitemcode, @tmpcnt, '��Ʈ���꺸��', @gameid_, ''

							-- �����߼�.
							insert into @tTempTreasureReward(itemcode, cnt) values( @tmpitemcode, @tmpcnt );
						end

					if( @tsskillgamecost > 0 and @rand <= @tsskillgamecost )
						begin
							set @tmpcnt = case
												when @famelv <  5 then 2000
												when @famelv < 10 then 3000
												when @famelv < 20 then 4000
												when @famelv < 30 then 5000
												when @famelv < 40 then 6000
												else                   7000
										  end
							set @tmpcnt = @tmpcnt + Convert(int, ceiling(RAND() * 2000))
							set @tmpitemcode= 5100
							--select 'DEBUG > ���λ���', @tmpcnt tmpcnt
							exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT, @tmpitemcode, @tmpcnt, '���λ��꺸��', @gameid_, ''

							-- �����߼�.
							insert into @tTempTreasureReward(itemcode, cnt) values( @tmpitemcode, @tmpcnt );
						end

					if( @tsskillfpoint > 0 and @rand <= @tsskillfpoint )
						begin
							set @tmpcnt = 100 + Convert(int, ceiling(RAND() * 50))
							set @tmpitemcode= 1900
							--select 'DEBUG > ��������', @tmpcnt tmpcnt
							exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT, @tmpitemcode, @tmpcnt, '�������꺸��', @gameid_, ''

							-- �����߼�.
							insert into @tTempTreasureReward(itemcode, cnt) values( @tmpitemcode, @tmpcnt );
						end

					if( @tsskillrebirth > 0 and @rand <= @tsskillrebirth )
						begin
							set @tmpcnt = 1 + Convert(int, ceiling(RAND() * 2))
							set @tmpitemcode= 1200
							--select 'DEBUG > ��Ȱ������', @tmpcnt tmpcnt
							exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT, @tmpitemcode, @tmpcnt, '��Ȱ�����꺸��', @gameid_, ''

							-- �����߼�.
							insert into @tTempTreasureReward(itemcode, cnt) values( @tmpitemcode, @tmpcnt );
						end

					if( @tsskillalba > 0 and @rand <= @tsskillalba )
						begin
							set @tmpcnt = 2 + Convert(int, ceiling(RAND() * 3))
							set @tmpitemcode= 1002
							--select 'DEBUG > �˹ٻ��꺸��', @tmpcnt tmpcnt
							exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT, @tmpitemcode, @tmpcnt, '�˹ٻ��꺸��', @gameid_, ''

							-- �����߼�.
							insert into @tTempTreasureReward(itemcode, cnt) values( @tmpitemcode, @tmpcnt );
						end

					if( @tsskillbullet > 0 and @rand <= @tsskillbullet )
						begin
							set @tmpcnt = 4 + Convert(int, ceiling(RAND() * 6))
							set @tmpitemcode= 702
							--select 'DEBUG > Ư��ź���꺸��', @tmpcnt tmpcnt
							exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT, @tmpitemcode, @tmpcnt, 'Ư��ź���꺸��', @gameid_, ''

							-- �����߼�.
							insert into @tTempTreasureReward(itemcode, cnt) values( @tmpitemcode, @tmpcnt );
						end

					if( @tsskillvaccine > 0 and @rand <= @tsskillvaccine )
						begin
							set @tmpcnt = 3 + Convert(int, ceiling(RAND() * 2))
							set @tmpitemcode= 802
							--select 'DEBUG > ��Ż��꺸��', @tmpcnt tmpcnt
							exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT, @tmpitemcode, @tmpcnt, '��Ż��꺸��', @gameid_, ''

							-- �����߼�.
							insert into @tTempTreasureReward(itemcode, cnt) values( @tmpitemcode, @tmpcnt );
						end

					if( @tsskillfeed > 0 and @rand <= @tsskillfeed )
						begin
							set @tmpcnt 	= 150 + Convert(int, ceiling(RAND() * 150))
							set @tmpitemcode= 900
							--select 'DEBUG > ���ʻ��꺸��', @tmpcnt tmpcnt
							exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT, @tmpitemcode, @tmpcnt, '���ʻ��꺸��', @gameid_, ''

							-- �����߼�.
							insert into @tTempTreasureReward(itemcode, cnt) values( @tmpitemcode, @tmpcnt );
						end

					if( @tsskillbooster > 0 and @rand <= @tsskillbooster )
						begin
							set @tmpcnt 	= 3 + Convert(int, ceiling(RAND() * 2))
							set @tmpitemcode= 1103
							--select 'DEBUG > ���������꺸��', @tmpcnt tmpcnt
							exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT, @tmpitemcode, @tmpcnt, '���������꺸��', @gameid_, ''

							-- �����߼�.
							insert into @tTempTreasureReward(itemcode, cnt) values( @tmpitemcode, @tmpcnt );
						end
				end


			---------------------------------------------------------------------
			-- Event1 �α��θ� �ϸ� ���� ���� �Ҹ����� ���~~~
			--  1�� �Ϲ� ���� Ƽ�� (2��)
			--  2�� �˹��� ���� ��Ű�� (4��)
			--  3�� ��Ȱ�� (3��)
			---------------------------------------------------------------------
			--if(@eventonedailystate = @EVENT_STATE_YES)
			--	begin
			--		set @eventonedailyloop = datepart(dd, getdate())%3
			--		if(@eventonedailyloop = 0)
			--			begin
			--				exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT,  2200, 2, 'OpenEvent', @gameid_, '�����̺�Ʈ'
			--			end
			--		else if(@eventonedailyloop = 1)
			--			begin
			--				exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT,  1002, 4, 'OpenEvent', @gameid_, '�����̺�Ʈ'
			--			end
			--		else
			--			begin
			--				exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT,  1200, 3, 'OpenEvent', @gameid_, '�����̺�Ʈ'
			--			end
			--	end

			-------------------------------------------------------------------
			-- Event2 ������ �ð��� �α����ϸ� ��������~~~
			-- 		step1 : �����Ͱ� ������
			--		step2 : ���� <= ���� < �� (������)
			--				=> �̺�Ʈ�ڵ�, �������ڵ�, ������
			--		step3 : �ش� ���� ����, �������� ���(tEventUser)
			-------------------------------------------------------------------
			select @eventstatemaster = eventstatemaster from dbo.tEventMaster where idx = 1
			--select 'DEBUG �����̺�Ʈ1-1', @eventstatemaster eventstatemaster
			if(@eventstatemaster = @EVENT_STATE_YES)
				begin
					select top 1
						@eventidx 		= eventidx,
						@eventitemcode 	= eventitemcode,
						@eventcnt		= eventcnt,
						@eventsender 	= eventsender
					from dbo.tEventSub
					where @curday = eventday and eventstarthour <= @curhour and @curhour <= eventendhour and eventstatedaily = @EVENT_STATE_YES
					order by eventidx desc

					set @eventidx2 = (@curyear - 2015)*1000000 + @curmonth*10000 + @curday*100 + @eventidx
					--select 'DEBUG �����̺�Ʈ1-2', @eventidx eventidx, @eventitemcode eventitemcode, @eventsender eventsender, @eventidx2 eventidx2

					if(@eventidx != -1 and @eventitemcode != -1)
						begin
							--select 'DEBUG �����̺�Ʈ1-3'
							if(not exists(select top 1 * from dbo.tEvnetUserGetLog where gameid = @gameid_ and eventidx = @eventidx2))
								begin
									--select 'DEBUG �����̺�Ʈ1-4 ����, �αױ��'
									exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT,  @eventitemcode, @eventcnt, @eventsender, @gameid_, '������ �ð�'

									insert into dbo.tEvnetUserGetLog(gameid,   eventidx,   eventitemcode,  eventcnt)
									values(                         @gameid_, @eventidx2, @eventitemcode, @eventcnt)

									---------------------------------
									---- ���ͱ��� > �߰��� �ð������� ���� > ����� ����
									---------------------------------
									--if(@market_ not in (@MARKET_IPHONE) and @eventitemcode in (703, 1202))
									--	begin
									--		exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT, 1600, 0, @eventsender, @gameid_, '������ �ð�'
									--	end

									-- �ڼ��� �ΰ�� �����Կ� �־ �����ص� �ȴ�.
									select @idx2 = max(idx) from dbo.tEvnetUserGetLog
									delete from tEvnetUserGetLog where idx <= @idx2 - 8800
								end
						end
				end


			-------------------------------------------------------------------
			-- 1�� > �̺����� �����Ǹ�(��)
			--  >  ���ø� �Ǹ�(�������ڵ�)���
			-- fun���δ� ������� (newid()����)
			-------------------------------------------------------------------
			if(@newday >= 1)
				begin
					select top 1 @pettodayitemcode = itemcode from dbo.tItemInfo
					where subcategory = @ITEM_SUBCATEGORY_PET
						  and itemcode not in (select itemcode from dbo.tUserItem
						  					   where gameid = @gameid_
						  					   		 and invenkind = @USERITEM_INVENKIND_PET)
						  --and (ABS(CAST( (BINARY_CHECKSUM(*) * RAND()) as int)) % 100) <= 100
						  order by newid()

					-- ���ø� ���� �״�� ü�������� ��ȯ.
					set @pettodayitemcode2 = @pettodayitemcode
				end

			-- ü������ �����ϰ� ���ø� ��� ü���� �ٸ��� > ���ø� ������ ��ü.
			if(@pettodayitemcode2 != -1 and @pettodayitemcode != @pettodayitemcode2)
				begin
					set @pettodayitemcode2 = @pettodayitemcode
				end

			-------------------------------------------------------------------
			-- 1�� and ������ > �߹��� ��ü
			-- �߹����� ����  > �߹��� ��ü
			--if((@newday >= 1 and @yabaustep = 0) or not exists(select top 1 * from dbo.tSystemYabau where idx = @yabauidx))
			-------------------------------------------------------------------
			set @strmarket = '%' + ltrim(rtrim(str(@market_))) + '%'
			if(@market_ = @MARKET_GOOGLE)
				begin
					-- Google ����.
					if((@newday >= 1 and @yabaustep = 0) or @yabauidx <= -1)
						begin
							select top 1 @yabauidx = idx from dbo.tSystemYabau
							where famelvmin <= @famelv
								and @famelv <= famelvmax
								and packstate = 1
								and packmarket like @strmarket
								order by newid()
						end

					if(not exists(select top 1 * from dbo.tSystemYabau where idx = @yabauidx))
						begin
							set @yabauidx = -1
						end
				end
			else
				begin
					-- ���� ���(SKT, Naver, iPhone)
					set @yabauidx = -2
				end


			-------------------------------------------------------------------
			-- ���� ó�� �ϱ�.
			--if(condate >=30)
			--	���ͽ��� 1�ܰ�
			--	�����÷���ī���� Ŭ����
			--	if(��û��¥ 24�ð��̳�, ���̵�) ��û�� ����
			--else if(���ο and ���� >= 1step and ���� >= 5)
			--	���ͽ��� + 1
			--	�����÷���ī���� Ŭ����
			--	if(step > 10)
			--		step = -1
			-------------------------------------------------------------------
			if(@rtnflag = @RETURN_FLAG_ON)
				begin
					--select 'DEBUG ����������(����ON).', @newday newday, @rtnstep rtnstep, @rtnplaycnt rtnplaycnt, @condate condate, @rtndate rtndate, (getdate() - 1) '1����', getdate() '����'
					if(@condate <= (getdate() - @RETURN_LIMIT_DAY))
						begin
							--select 'DEBUG > ���� > ��������.', @rtngameid rtngameid
							set @rtnstep	= 1
							set @rtnplaycnt	= 0
							if(@rtngameid != '' and @rtndate >= (getdate() - 1))
								begin
									--select 'DEBUG > ��뺸��.', @rtngameid rtngameid
									set @comment2 = @gameid_ + '�� ���� �������� �帳�ϴ�.'
									exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT,   @rtnitemcode, 0, '���ͺ���', @rtngameid, ''
									exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_MESSAGE,          -1, 0, '��������', @rtngameid, @comment2
								end

							-------------------------------------
							-- ���� �ο���.
							-------------------------------------
							exec spu_DayLogInfoStatic @market_, 28, 1				-- �� ���ͼ�.
						end
					--else if(@newday >= 1 and @rtnstep >= 1 and @rtnplaycnt >= 5)	-- ������ and ������ and ��ǰ����
					else if(@newday >= 1 and @rtnstep >= 1)							-- ������ and ������
						begin
							--select 'DEBUG > ���� > ������.', @newday newday, @rtnstep rtnstep, @rtnplaycnt rtnplaycnt
							set @rtnstep	= @rtnstep + 1
							set @rtnplaycnt	= 0
							if(@rtnstep >= 15)
								begin
									--select 'DEBUG > ���� > �Ϸ�.', @newday newday, @rtnstep rtnstep, @rtnplaycnt rtnplaycnt
									set @rtnstep	= -1
								end
						end
				end


			------------------------------------------------------------------------
			-- ��Ʈ ���� ������ �ִ� ��� > ������ �����ֱ�.
			-- 1 -> 1�� ����.
			-----------------------------------------------------------------------
			if(@heartget > 0)
				begin
					set @heartmsg = '[�˸�]ģ���� ������ ��ǥ ����� ������ ����� ģ������ ��Ʈ ������ ��Ʈ' + ltrim(str(@heartget)) + '���� �޾ҽ��ϴ�.(�ٷ� ����Ǿ �����ϴ�.)'
					exec spu_SubGiftSendNew 1, -1, 0, 'roulhear', @gameid_, @heartmsg
					set @heartget = 0
				end

			------------------------------------------------------------------------
			-- ģ�� ���� ��û ó���ϱ�.
			-- �ϴܿ��� ������ֱ�.
			-----------------------------------------------------------------------
			-- ���� ��û�� ģ�� ���� ����ϱ�.
			DECLARE @tTempTableHelpWait TABLE(
				kakaoprofile		varchar(512)	default(''),
				kakaonickname		varchar(40)		default('')
			);
			insert into @tTempTableHelpWait(kakaoprofile, kakaonickname)
			select kakaoprofile, kakaonickname from dbo.tUserMaster
			where gameid in (select friendid FROM dbo.tKakaoHelpWait where gameid = @gameid_ and helpdate >= getdate() - 1)

			-- ó�����ֱ�.
			exec sup_subKakaoHelpWait @gameid_

			------------------------------------------------------------------
			-- ���� > �α��� ī����
			------------------------------------------------------------------
			if(@logindate != @dateid8)
				begin
					exec spu_DayLogInfoStatic @market_, 14, 1               -- �� �α���(����ũ)
					exec spu_DayLogInfoStatic @market_, 12, 1               -- �� �α���(�ߺ�)
				end
			else
				begin
					exec spu_DayLogInfoStatic @market_, 12, 1               -- �� �α���(�ߺ�)
				end
			set @logindate = @dateid8

			------------------------------------------------------------------------
			-- �ֱ� �б� ������ ���.
			-----------------------------------------------------------------------
			select top 1 @schoolresult3 = schoolresult from dbo.tSchoolResult order by schoolresult desc
			if(@schoolresult3 > @schoolresult)
				begin
					set @schoolresult2 = 1
				end
			else
				begin
					set @schoolresult2 = 0
				end
			set @schoolresult = @schoolresult3

			------------------------------------------------------------------------
			--	��¥���� (�׽�Ʈ�� ���ؼ� ��¥�� ������ ��쿡�� ������ �������)
			------------------------------------------------------------------------
			if( @gamemonth > 12 )
				begin
					set @gameyear	= @gameyear + 1
					set @gamemonth	= 1
				end

			------------------------------------------------------------------
			-- ���� ������ ������Ʈ�ϱ�
			------------------------------------------------------------------
			--select * from dbo.tUserMaster where gameid = @gameid_

			update dbo.tUserMaster
				set
					fame			= @fame,
					famelv			= @famelv,
					famelvbest		= @famelvbest,
					market			= @market_,
					gameyear		= @gameyear,
					gamemonth		= @gamemonth,

					--���� ���� > �ֱ� ���ӳ�¥ ����, ���� ī���� ����
					version			= @version_,
					--gamecost		= @gamecost,
					--cashcost		= @cashcost,
					heartget		= @heartget,
					kakaomsgblocked	= case
											when (@kakaomsgblocked_ = @KAKAO_MESSAGE_NON) 	then kakaomsgblocked
											when (@kakaomsgblocked_ = @KAKAO_MESSAGE_BLOCK) then @KAKAO_MESSAGE_BLOCK
											else kakaomsgblocked
									end,
					kkhelpalivecnt	= 0,
					goldticket		= @goldticket, 		goldtickettime		= @goldtickettime,
					battleticket	= @battleticket, 	battletickettime	= @battletickettime,

					-- ��Ʋ��ũ����.
					battleanilistidx1= @battleanilistidx1, battleanilistidx2= @battleanilistidx2, battleanilistidx3= @battleanilistidx3, battleanilistidx4= @battleanilistidx4, battleanilistidx5= @battleanilistidx5,
					tslistidx1		= @tslistidx1, 		tslistidx2		= @tslistidx2, 		tslistidx3		= @tslistidx3, 		tslistidx4		= @tslistidx4, 		tslistidx5		= @tslistidx5,

					-- ���ø� �Ǹ�����.
					pettodayitemcode	= @pettodayitemcode,
					pettodayitemcode2	= @pettodayitemcode2,
					logindate		= @logindate,	-- �α��γ�¥��.

					-- �⼮����
					attenddate		= @attenddate,
					attendcnt		= @attendcnt,

					-- ��Ʈ ���� ���差.
					heartsenddate	= @heartsenddate,
					heartsendcnt 	= @heartsendcnt,

					-- ���Ϸ귿���尪
					zcpappearcnt	= @zcpappearcnt,

					-- ���� �������۷�.
					anibuydate		= @anibuydate,
					anibuycnt 		= @anibuycnt,

					-- ����ù���� Ŭ����Ƚ��.
					eventspot08		= @eventspot08,

					-- ����귿
					wheeltodaydate	= @wheeltodaydate,
					wheeltodaycnt 	= @wheeltodaycnt,

					-- ����Ʈ
					comreward		= @comreward,

					-- �߹��� ����.
					yabauidx		= @yabauidx,

					-- ���� �б�����, ģ����ŷ �����ߴ�.
					schoolresult	= @schoolresult,

					-- ��������
					feedmax			= @feedmax,
					heartmax		= @heartmax,
					fpointmax		= @fpointmax,
					housestate 		= @housestate, 		housestep 		= @housestep,
					tankstate 		= @tankstate, 		tankstep 		= @tankstep,
					bottlestate 	= @bottlestate, 	bottlestep 		= @bottlestep,
					pumpstate 		= @pumpstate, 		pumpstep 		= @pumpstep,
					transferstate 	= @transferstate, 	transferstep 	= @transferstep,
					purestate 		= @purestate, 		purestep 		= @purestep,
					freshcoolstate 	= @freshcoolstate, 	freshcoolstep 	= @freshcoolstep,

					-- �Һ������
					bulletlistidx	= @bulletlistidx,
					vaccinelistidx	= @vaccinelistidx,
					albalistidx		= @albalistidx,
					boosterlistidx	= @boosterlistidx,

					-- ������������.
					--rtngameid		= @rtngameid,
					--rtndate		= @rtndate,
					rtnstep			= @rtnstep,
					rtnplaycnt		= @rtnplaycnt,

					kakaomsginvitetodaycnt 	= @kakaomsginvitetodaycnt,
					kakaomsginvitetodaydate = @kakaomsginvitetodaydate,
					kakaoprofile			= @kakaoprofile,
					sid						= sid + 1,

					condate			= getdate(),			-- ����������
					concnt			= concnt + 1			-- ����Ƚ�� +1
			where gameid = @gameid_

			--------------------------------------------------------------------
			---- ������ ���׹̳ʰ� ����Ǹ� > Ǫ������ �����ֶ� ����ϱ�
			--------------------------------------------------------------------
			--if(not exists(select top 1 * from dbo.tActionScheduleData where gameid = @gameid_))
			--	begin
			--		insert into tActionScheduleData(gameid) values(@gameid_)
			--	end

			------------------------------------------------
			---- ��ŷ �ʱ�ȭ��¥(���� ������).
			-----------------------------------------------
			--select @dw = DATEPART(dw, @curdate)
			--set @curdate = case
			--					when @dw = 1 then  @curdate
			--					else			  (@curdate - DATEPART(dw, @curdate) + 2) + 6
			--			   end
			--set @schoolinitdate = CONVERT(char(10), @curdate, 25) + ' 23:59:00'

			------------------------------------------------
			---- ��ŷ �ʱ�ȭ��¥(���� �����).
			-----------------------------------------------
			select @dw = DATEPART( dw, @curdate )
			set @curdate = @curdate + ( 7 - @dw )
			set @schoolinitdate = CONVERT( char(10), @curdate, 25 ) + ' 23:59:00'

			-- �б��̸�.
			set @schoolname = ''
			select @schoolname = isnull(schoolname, '') from dbo.tSchoolBank where schoolidx = @schoolidx

			------------------------------------------------------------------------
			-- ���� ���� ���� > ��Ȯ�� ������ �ִ°�? > �ƽ��� �ִ°�?
			-----------------------------------------------------------------------
			--if(exists(select top 1 * from
			--								(select DATEDIFF(hh, incomedate, getdate()) * param1 as hourcoin2, b.param2 maxcoin from
			--									(select * from dbo.tUserGameMTBaseball where gameid = @gameid_ and buystate = 1) a
			--								LEFT JOIN
			--									(select * from dbo.tItemInfo where subcategory = 69) b
			--								ON a.itemcode = b.itemcode) as f
			--							where hourcoin2 >= maxcoin ))
			--	begin
			--		set @farmharvest	= 1
			--	end
			--else
			--	begin
			--		set @farmharvest	= 0
			--	end

			------------------------------------------------------------------------
			-- ģ�����߿� ���� ������� ģ���� �ִ°�?
			-----------------------------------------------------------------------
			if(exists(select top 1 * from dbo.tUserFriend where gameid = @gameid_ and state = 1))
				begin
					set @friendinvite = 1
				end

			------------------------------------------------------------------------
			-- ��Ʈ ���� ������ ģ��.
			-----------------------------------------------------------------------
			if(exists(select top 1 * from dbo.tUserFriend where gameid = @gameid_ and friendid != @sysfriendid and state = 2 and senddate <= getdate() - 1))
				begin
					set @sendheart = 1
				end

			----------------------------------------------
			-- ���� ����
			---------------------------------------------
			select
				*,
				@SKILL_ATK_1 atk1, 	@SKILL_ATK_2 atk2, 	@SKILL_ATK_3 atk3,
				@SKILL_DEF_1 def1, 	@SKILL_DEF_2 def2, 	@SKILL_DEF_3 def3,
				@SKILL_HP_1 hp1, 	@SKILL_HP_2 hp2, 	@SKILL_HP_3 hp3, 		@SKILL_HP_1_TIME hptime1, 		@SKILL_HP_2_TIME hptime2, 		@SKILL_HP_3_TIME hptime3,
				@SKILL_TURN_1 turn1,@SKILL_TURN_2 turn2,@SKILL_TURN_3 turn3, 	@SKILL_TURN_1_TIME turntime1,	@SKILL_TURN_2_TIME turntime2,	@SKILL_TURN_3_TIME turntime3,
				@DEALER_PLUS_STEP1 dpstep1, @DEALER_PLUS_STEP2 dpstep2, @DEALER_PLUS_STEP3 dpstep3, @DEALER_PLUS_STEP4 dpstep4, @DEALER_PLUS_STEP5 dpstep5,
				@DEALER_PLUS_STEP6 dpstep6, @DEALER_PLUS_STEP7 dpstep7, @DEALER_PLUS_STEP8 dpstep8, @DEALER_PLUS_STEP9 dpstep9, @DEALER_PLUS_STEPM dpstepM,
				@ANIMAL_COMPOSE_LEVEL anicomposelevel,
				@FARM_BATTLE_OPEN_LV farmbattleopenlv,
				@NEW_START_INIT_LV newstartinitlv,
				@ANIMAL_LIMIT_TREASURE_VAL treasureval,
				@kkhelpalivecnt kkhelpalivecnt2,
				@attendnewday attendnewday,
				@farmharvest farmharvest,
				@sendheart sendheart,
				@friendinvite friendinvite,
				@schoolresult2 schoolresult2,
				@schoolname	schoolname,
				@schoolinitdate userrankinitdate,
				@schoolinitdate schoolinitdate,
				@BOARD_STATE_REWARD_GAMECOST mboardreward,
				@GAME_START_YEAR startyear, @GAME_START_MONTH startmonth,
				@roulaccprice roulaccprice, @roulaccsale roulaccsale,
				((famelv / 10 + 1)*(famelv / 10 + 1) * @YABAU_CHANGE_DANGA) yabauchange,
				case when famelv <= 50 then @USED_FRIEND_POINT else (@USED_FRIEND_POINT + (famelv - 50)*20) end needfpoint
			from dbo.tUserMaster where gameid = @gameid_

			--------------------------------------------------------------
			-- ���� ������ ��ü ����Ʈ
			-- ����(��������[�ֱٰ�], �κ�, �ʵ�, ��ǥ), �Һ���, �Ǽ��縮
			--------------------------------------------------------------
			select * from dbo.tUserItem
			where gameid = @gameid_ and invenkind in (@USERITEM_INVENKIND_ANI, @USERITEM_INVENKIND_CONSUME, @USERITEM_INVENKIND_PET, @USERITEM_INVENKIND_STEMCELL, @USERITEM_INVENKIND_TREASURE )
			order by diedate desc, invenkind, fieldidx, itemcode

			--------------------------------------------------------------
			-- ���� ������ ����
			--------------------------------------------------------------
			select * from dbo.tUserSeed
			where gameid = @gameid_
			order by seedidx asc

			--------------------------------------------------------------
			-- ���� ģ������
			-- ī�� & ������� ��ó������.(������ ���ʵ����� ��ü)
			--------------------------------------------------------------
			exec spu_subFriendList @gameid_

			--------------------------------------------------------------
			-- ī�� �ʴ�ģ����
			--------------------------------------------------------------
			select * from dbo.tKakaoInvite where gameid = @gameid_

			--------------------------------------------------------------
			-- ���� ����/����(����, ������ɺ��� ����)
			--------------------------------------------------------------
			exec spu_GiftList @gameid_

			----------------------------------------------------------------
			----	���� : ���̺�.(������)
			----------------------------------------------------------------
			--select
			--	param1 dogamidx, itemname dogamname,
			--	param2 animal0, param3 animal1,
			--	param4 animal2, param5 animal3,
			--	param6 animal4, param7 animal5,
			--	param8 rewarditemcode, param9 rewardvalue
			--from dbo.tItemInfo
			--where subcategory = @ITEM_MAINCATEGORY_DOGAM

			--------------------------------------------------------------
			--	�굵�� : ȹ���� ��.
			--------------------------------------------------------------
			select * from dbo.tDogamListPet where gameid = @gameid_ order by itemcode asc

			--------------------------------------------------------------
			--	���� : ȹ���� ����.
			--------------------------------------------------------------
			select * from dbo.tDogamList where gameid = @gameid_ order by itemcode asc

			--------------------------------------------------------------
			--	���� : ���� ���� �����ε��� ��ȣ.
			--------------------------------------------------------------
			select * from dbo.tDogamReward where gameid = @gameid_ order by dogamidx asc

			--------------------------------------------------------------
			-- �������� > ĳ������(+a%), ȯ��(+b%), ��Ʈ(+c%), ����(+d%) �����⼮, ���ƽ�
			-- iPhone�� ��å ������ ���� ������ ���Ѵ�.
			--------------------------------------------------------------
			--select 'DEBUG ��������1'
			if(@market_ = @MARKET_IPHONE)
				begin
					set @RECOMMAND_MESSAGE = @RECOMMAND_MESSAGE_IPHONE
				end
			else
				begin
					if(@RECOMMAND_MESSAGE_SERVERID = @BOOL_TRUE)
						begin
							set @RECOMMAND_MESSAGE = @RECOMMAND_MESSAGE + @RECOMMAND_MESSAGE_ANDROIDPLUS + @gameid_ + '[-]'
						end
					else
						begin
							set @RECOMMAND_MESSAGE = @RECOMMAND_MESSAGE
						end
				end

			-----------------------------------------------
			---- �ý��� ���� ǥ��.
			---- EVENT 7.24 ~ 8.6 	>
			----	3. Naverĳ��		=> ���̹� ĳ�� 2��
			-----------------------------------------------
			select
				top 1 *,
				@housestepmax housestepmax2,
				@tankstepmax tankstepmax2,
				@bottlestepmax bottlestepmax2,
				@pumpstepmax pumpstepmax2,
				@transferstepmax transferstepmax2,
				@purestepmax purestepmax2,
				@freshcoolstepmax freshcoolstepmax2,
				@RECOMMAND_MESSAGE recommendmsg,
				@KAKAO_MESSAGE_INVITE_ID kakaoinviteid,
				@KAKAO_MESSAGE_PROUD_ID kakaoproudid,
				@KAKAO_MESSAGE_HEART_ID kakaoheartid,
				@KAKAO_MESSAGE_HELP_ID kakaohelpid,
				@KAKAO_MESSAGE_RETURN_ID kakaoreturnid
			from dbo.tSystemInfo
			order by idx desc
			--select 'DEBUG ��������2'

			---------------------------------------------
			-- ��Ű����ǰ.
			---------------------------------------------
			set @strmarket = '%' + ltrim(rtrim(str(@market_))) + '%'

			select top 1 * from dbo.tSystemPack
			where famelvmin <= @famelv
				and @famelv <= famelvmax
				and packstate = 1
				and packmarket like @strmarket
				--and (ABS(CAST( (BINARY_CHECKSUM(*) * RAND()) as int)) % 100) <= 100
				order by newid()

			---------------------------------------------
			-- ��ŷ.
			---------------------------------------------
			exec spu_subFriendRank @gameid_, 1

			---------------------------------------------
			-- ���� ���� �÷��� Ƚ�� �ʱ�ȭ
			-- ���� ����.
			---------------------------------------------
			if(@newday >= 1)
				begin
					set @vip_plus = dbo.fun_GetVIPPlus( 8, @cashpoint, @FARM_BATTLE_PLAYCNT_MAX)		-- ����Ƚ��

					update dbo.tUserGameMTBaseball
						set
							playcnt = @FARM_BATTLE_PLAYCNT_MAX + @vip_plus
					where gameid = @gameid_ and playcnt <= @FARM_BATTLE_PLAYCNT_MAX
				end

			-- ����Ʈ ����.
			exec spu_UserGameMTBaseballListNew @gameid_, 1, @market_, @version_

			---------------------------------------------
			-- ���Ǽҵ� ���׽�Ʈ ���.
			---------------------------------------------
			select * from dbo.tEpiReward
			where gameid = @gameid_
			order by idx asc

			---------------------------------------------
			-- ��ü��ŷ�� ������Ʋ��ŷ.
			---------------------------------------------
			exec spu_subUserTotalRank @gameid_, 1

			---------------------------------------------
			-- ���� �б���ŷ(�б� + ���Ҽ�).
			---------------------------------------------
			exec spu_SchoolRank 11, -1, @gameid_

			---------------------------------------------
			-- ������ ģ����.
			---------------------------------------------
			select * from @tTempTableHelpWait

			---------------------------------------------
			-- ����� ��.
			---------------------------------------------
			select top 1 * from dbo.tSystemYabau where idx = @yabauidx

			---------------------------------------------
			-- ������������.
			---------------------------------------------
			select * from @tTempTreasureReward

			---------------------------------------------
			-- �����̱�.
			---------------------------------------------
			--select 'DEBUG ', @strmarket strmarket,
			set @curdate = getdate()

			-- lv -> ����.
			select dbo.fun_GetRoulPrice( @MODE_ROULETTE_GRADE1_GAMECOST, @famelv) roulgrade1gamecost,
				   dbo.fun_GetRoulPrice( @MODE_ROULETTE_GRADE1_HEART, 	 @famelv) roulgrade1heart,
				   dbo.fun_GetRoulPrice( @MODE_ROULETTE_GRADE2_CASHCOST, @famelv) roulgrade2cashcost,
				   dbo.fun_GetRoulPrice( @MODE_ROULETTE_GRADE4_CASHCOST, @famelv) roulgrade4cashcost

			-- ����.
			select
				top 1 *,
				case when (@curdate > roulstart and @curdate <= roulend) then roulsaleflag	else -1 end roulsaleflag2,
				case when (@curdate > roulstart and @curdate <= roulend) then roulflag 		else -1 end roulflag2,
				case when (@curdate > roulstart and @curdate <= roulend) then roultimeflag 	else -1 end roultimeflag2,
				case when (@curdate > roulstart and @curdate <= roulend) then pmgauageflag 	else -1 end pmgauageflag2
			from dbo.tSystemRouletteMan
			where roulmarket like @strmarket
			order by idx desc

			---------------------------------------------
			-- �����̱�.
			---------------------------------------------
			-- lv -> ����.
			select dbo.fun_GetTreasurePrice( @MODE_TREASURE_GRADE1_GAMECOST, @famelv) tsgrade1gamecost,
				   dbo.fun_GetTreasurePrice( @MODE_TREASURE_GRADE1_HEART, 	 @famelv) tsgrade1heart,
				   dbo.fun_GetTreasurePrice( @MODE_TREASURE_GRADE2_CASHCOST, @famelv) tsgrade2cashcost,
				   dbo.fun_GetTreasurePrice( @MODE_TREASURE_GRADE3_CASHCOST, @famelv) tsgrade4cashcost

			-- ����.
			select
				top 1 *,
				case when (@curdate > roulstart and @curdate <= roulend) then tsupgradesaleflag	else -1 end tsupgradesaleflag2,
				case when (@curdate > roulstart and @curdate <= roulend) then roulsaleflag	else -1 end roulsaleflag2,
				case when (@curdate > roulstart and @curdate <= roulend) then roulflag 		else -1 end roulflag2,
				case when (@curdate > roulstart and @curdate <= roulend) then roultimeflag 	else -1 end roultimeflag2,
				case when (@curdate > roulstart and @curdate <= roulend) then pmgauageflag 	else -1 end pmgauageflag2
			from dbo.tSystemTreasureMan
			where roulmarket like @strmarket
			order by idx desc

			---------------------------------------------
			-- ����ù���� �������� �������ڵ� (30�� ��ȿ).
			---------------------------------------------
			select distinct itemcode from dbo.tCashFirstTimeLog
			where gameid = @gameid_ and writedate >= getdate() - 30
			order by itemcode asc

			---------------------------------------------
			-- �귿����.
			---------------------------------------------
			select top 8 * from dbo.tSystemWheelInfo where kind = 20 order by idx desc		-- ����.

			select top 8 * from dbo.tSystemWheelInfo where kind = 21 order by idx desc		-- ����.

			---------------------------------------------
			-- VIP ����.
			---------------------------------------------
			select * from dbo.tSystemVIPInfo order by idx asc


			---------------------------------------------
			-- ��ŷ���� �÷��̸�. ����.
			-- �ݿ��ϸ� ����(����) > ����� ����(�� -> �佺����)
			-- ��	��	ȭ	��	��	��	��
			-- (1) 	2  (3) 	4 	5  (6) 	7
			-- 1 	2 	3 	4 	5 	6 	7
			-- 8 	9 	10 	11 	12 	13 	14
			-- 15 	16 	17 	18 	19 	20 	21
			-- 22 	23 	24 	25 	26 	27 	28
			-- C		C 	A	C	C	A	C
			---------------------------------------------
			set @dw = DATEPART(dw, getdate())

			select '�Ǹż���' rkname1,
				   '����跲' rkname2,
				   '��Ʋ ����Ʈ' rkname3,
				   '����,��������Ʈ' rkname4,
				   'ģ������Ʈ' rkname5,
				   '�귿����Ʈ' rkname6,
				   '��������Ʈ' rkname7,
					case when @dw in (1, 3, 6) then 1 else -1 end rking


			select '���� ��, ȭ, �ݿ��ϸ��� 2������\n'
				   + '������ ��ŷ ��Ʋ�� �մϴ�\n'
				   + '(�⼮�귿�� �����ø� ��ŷ���� ������ �˴ϴ�.)\n\n'
				   + '[�¸��� ����]\n'
				   + '1. �ռ�������, �±��� �� x 150\n'
				   + '~ 5. �ռ�������, �±��� �� x 130\n'
				   + '~ 10. �ռ�������, �±��� �� x 100\n'
				   + '~ 100. �ռ�������, �±��� �� x 50\n'
				   + '��Ÿ��� �ռ�������, �±��� �� x 30\n\n'
				   + '- �����׸� -\n\n'
				   + '�Ǹż��� : ���ΰ� �ŷ��� �ؼ� �߻��ϴ� ��������Ʈ\n\n'
				   + '����跲 : �����鿡�Լ� ���� ������ �跲 ����Ʈ\n\n'
				   + '��Ʋ ����Ʈ : �����Ʋ�� ���� ��Ʋ�� �ϸ鼭 ȹ���� ����Ʈ\n\n'
				   + '����,��������Ʈ : ���� ����� ���� �̱⸦ ���ؼ� ������ ����Ʈ\n\n'
				   + 'ģ������Ʈ : ģ������ ��Ʈ�� ������ �ްų� ģ�� �ʴ� ����Ʈ\n\n'
				   + '�귿����Ʈ : �귿�� ���� Ƚ��\n\n'
				   + '��������Ʈ : ���� ���� ����Ʈ\n'
				   + '(���� ����� ������ ����� �� �ֽ��ϴ�.)'
				   rkinfo

			---------------------------------------------
			-- ��ŷ���� ��ŷ.
			---------------------------------------------
			exec spu_subRKRank @gameid_

			---------------------------------------------
			-- ¥�����������귿.
			---------------------------------------------
			select top 8 * from dbo.tSystemZCPInfo where kind = 0 order by idx desc

			---------------------------------------------
			-- ¥������.
			---------------------------------------------
			select * from dbo.tZCPMarket
			where zcpflag = 1 and getdate() < expiredate
			order by kind asc, zcporder desc
		END

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off
End



