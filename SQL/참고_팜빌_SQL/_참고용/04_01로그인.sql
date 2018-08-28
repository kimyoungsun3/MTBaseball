/*
select * from dbo.tFVUserMaster where gameid = 'xxxx'
exec spu_FVLogin 'xxxx', '049000s1i0n7t8445289', 1, 101, '', '', -1, -1			-- ��������
exec spu_FVLogin 'xxxx', '049000s1i0n7t8445288', 1, 101, '', '', -1, -1			-- ���Ʋ��
exec spu_FVLogin 'xxxx0', '049000s1i0n7t8445289', 1, 101, '', '', -1, -1			-- ��������
exec spu_FVLogin 'xxxx', '049000s1i0n7t8445289', 1, 100, '', '', -1, -1			-- ���Ϲ�������
exec spu_FVLogin 'xxxx3', '049000s1i0n7t8445289', 1, 101, '', '', -1, -1			-- ������
exec spu_FVLogin 'xxxx4', '049000s1i0n7t8445289', 1, 101, '', '', -1, -1			-- ��������
update dbo.tFVUserMaster set cashcopy = 3 where gameid = 'xxxx5'		-- ĳ��ī�� > ��ó��
exec spu_FVLogin 'xxxx5', '049000s1i0n7t8445289', 1, 101, '', '',-1,  -1
update dbo.tFVUserMaster set resultcopy = 100 where gameid = 'xxxx6'	-- ���Ű�� > ��ó��
exec spu_FVLogin 'xxxx7', '049000s1i0n7t8445289', 1, 101, '', '', -1, -1

exec spu_FVLogin 'xxxx', '049000s1i0n7t8445289', 1, 199, '', '', -1, -1			-- ��������
exec spu_FVLogin 'xxxx2', '049000s1i0n7t8445289', 5, 119, '', '', -1, -1			-- ��������
exec spu_FVLogin 'xxxx3', '049000s1i0n7t8445289', 1, 199, '', '', -1, -1			-- ��������
exec spu_FVLogin 'xxxx6', '049000s1i0n7t8445289', 1, 199, '', '', -1, -1			-- ��������
exec spu_FVLogin 'guest91738', '049000s1i0n7t8445289', 1, 199, '', '', -1, -1		-- ��������
exec spu_FVLogin 'farm40', '1294036k8k4s2f841412', 5, 199, '', '', -1, -1			-- ��������


update dbo.tFVUserMaster set attenddate = getdate() - 20 where gameid = 'xxxx2'
delete from dbo.tFVGiftList where gameid = 'xxxx2'
exec spu_FVLogin 'xxxx2', '049000s1i0n7t8445289', 1, 110, '', '', -1, -1			-- ��������


update dbo.tFVUserMaster set attenddate = getdate() - 1 where gameid = 'xxxx2'
exec spu_FVLogin 'xxxx2', '049000s1i0n7t8445289', 1, 103, '', '', -1, -1			-- ��������
*/
use Farm
Go

IF OBJECT_ID ( 'dbo.spu_FVLogin', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVLogin;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_FVLogin
	@gameid_								varchar(60),					-- ���Ӿ��̵�
	@password_								varchar(20),					-- ��ȣȭ�ؼ�����, �����н����� ��ŷ���ص� ����
	@market_								int,							-- (����ó�ڵ�)
	@version_								int,							-- Ŭ�����
	@kakaoprofile_							varchar(512),
	@kakaonickname_							varchar(40),
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

	--���� ����.
	declare @RESULT_ERROR_ID_DUPLICATE			int				set @RESULT_ERROR_ID_DUPLICATE			= -2

	-- �α��� ����.
	declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--������ > �˾�ó���� ��Ʈ�η� ��������.
	declare @RESULT_ERROR_DELETED_USER 			int				set @RESULT_ERROR_DELETED_USER			= -12			--�������� > �˾�ó���� ��Ʈ�η� ��������.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--�ش������� ã�� ����
	declare @RESULT_ERROR_NOT_FOUND_PASSWORD	int				set @RESULT_ERROR_NOT_FOUND_PASSWORD	= -17
	declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--������ �����ϰ� �ִ�.
	declare @RESULT_NEWVERION_CLIENT_DOWNLOAD 	int				set @RESULT_NEWVERION_CLIENT_DOWNLOAD	= -15			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ��ũó��.
	--declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ����.

	-- �����߿� ����.
	--declare @RESULT_ERROR_HEART_LACK			int				set @RESULT_ERROR_HEART_LACK			= -20			--��Ʈ�� �����ϴ�.
	--declare @RESULT_ERROR_GAMECOST_LACK		int				set @RESULT_ERROR_GAMECOST_LACK			= -21			--�ǹ��� �����ϴ�.
	--declare @RESULT_ERROR_CASHCOST_LACK		int				set @RESULT_ERROR_CASHCOST_LACK			= -22			--��尡 �����ϴ�.
	--declare @RESULT_ERROR_ITEM_LACK			int				set @RESULT_ERROR_ITEM_LACK				= -23			--�������̺����ϴ�.

	-- ĳ������.
	--declare @RESULT_ERROR_CASH_COPY			int				set @RESULT_ERROR_CASH_COPY				= -40
	--declare @RESULT_ERROR_CASH_OVER			int				set @RESULT_ERROR_CASH_OVER				= -41
	--declare @RESULT_ERROR_MONTH_OVER			int				set @RESULT_ERROR_MONTH_OVER			= -42			--�Ѵ޵��� �����ѵ��� �˻�

	------------------------------------------------
	--	2-2. ���°�
	------------------------------------------------
	-- ����ó�ڵ�
	declare @MARKET_SKT							int					set @MARKET_SKT						= 1
	--declare @MARKET_KT						int					set @MARKET_KT						= 2
	--declare @MARKET_LGT						int					set @MARKET_LGT						= 3
	declare @MARKET_GOOGLE						int					set @MARKET_GOOGLE					= 5
	declare @MARKET_NHN							int					set @MARKET_NHN						= 6
	declare @MARKET_IPHONE						int					set @MARKET_IPHONE					= 7

	-- (����/�����ڵ�)
	--declare @BUYTYPE_FREE						int					set @BUYTYPE_FREE 					= 0	-- ���ᰡ�� : ������ �ּ�
	--declare @BUYTYPE_PAY						int					set @BUYTYPE_PAY 					= 1	-- ���ᰡ�� : ������ ����
	--declare @BUYTYPE_PAY2						int					set @BUYTYPE_PAY2 					= 2	-- ���ᰡ��(�簡��)

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

	---- ������ ��з�
	--declare @ITEM_MAINCATEGORY_ANI			int					set @ITEM_MAINCATEGORY_ANI 					= 1 	-- ����(1)
	--declare @ITEM_MAINCATEGORY_CONSUME		int					set @ITEM_MAINCATEGORY_CONSUME 				= 3 	--�Ҹ�ǰ(3)
	--declare @ITEM_MAINCATEGORY_ACC			int					set @ITEM_MAINCATEGORY_ACC 					= 4 	--�׼�����(4)
	--declare @ITEM_MAINCATEGORY_HEART			int					set @ITEM_MAINCATEGORY_HEART 				= 40 	--��Ʈ(40)
	--declare @ITEM_MAINCATEGORY_CASHCOST		int					set @ITEM_MAINCATEGORY_CASHCOST 			= 50 	--ĳ������(50)
	--declare @ITEM_MAINCATEGORY_GAMECOST		int					set @ITEM_MAINCATEGORY_GAMECOST 			= 51 	--���μ���(51)
	--declare @ITEM_MAINCATEGORY_ROULETTE		int					set @ITEM_MAINCATEGORY_ROULETTE 			= 52 	--�̱�(52)
	--declare @ITEM_MAINCATEGORY_CONTEST		int					set @ITEM_MAINCATEGORY_CONTEST 				= 53 	--��ȸ(53)
	--declare @ITEM_MAINCATEGORY_UPGRADE		int					set @ITEM_MAINCATEGORY_UPGRADE 				= 60 	--����(60)
	--declare @ITEM_MAINCATEGORY_INVEN			int					set @ITEM_MAINCATEGORY_INVEN 				= 67 	--�κ�Ȯ��(67)
	--declare @ITEM_MAINCATEGORY_SEEDFIEL		int					set @ITEM_MAINCATEGORY_SEEDFIEL 			= 68 	--������Ȯ��(68)
	--declare @ITEM_MAINCATEGORY_DOGAM			int					set @ITEM_MAINCATEGORY_DOGAM 				= 818 	--����(818)
	--declare @ITEM_MAINCATEGORY_GAMEINFO		int					set @ITEM_MAINCATEGORY_GAMEINFO 			= 500 	--��������(500)

	-- ������ �Һз�
	declare @ITEM_SUBCATEGORY_UPGRADE_HOUSE		int					set @ITEM_SUBCATEGORY_UPGRADE_HOUSE 		= 60 -- ��
	declare @ITEM_SUBCATEGORY_USERFARM			int					set @ITEM_SUBCATEGORY_USERFARM	 			= 69	-- ��������
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
	declare @GAME_INVEN_ANIMAL_BASE				int					set @GAME_INVEN_ANIMAL_BASE					= 10	-- ��ǥ1 + ����9
	declare @GAME_INVEN_CUSTOME_BASE			int					set @GAME_INVEN_CUSTOME_BASE				= 8
	declare @GAME_INVEN_ACC_BASE				int					set @GAME_INVEN_ACC_BASE					= 6

	-- ���忡 �۾���.
	--declare @BOARD_STATE_NON					int					set @BOARD_STATE_NON				= 0
	--declare @BOARD_STATE_REWARD				int					set @BOARD_STATE_REWARD				= 1
	declare @BOARD_STATE_REWARD_GAMECOST		int					set @BOARD_STATE_REWARD_GAMECOST	= 600

	-- īī���� ����.
	declare @KAKAO_MESSAGE_INVITE_ID			int					set @KAKAO_MESSAGE_INVITE_ID 				= 907
	declare @KAKAO_MESSAGE_PROUD_ID				int					set @KAKAO_MESSAGE_PROUD_ID 				= 980
	declare @KAKAO_MESSAGE_HEART_ID				int					set @KAKAO_MESSAGE_HEART_ID 				= 981
	declare @KAKAO_MESSAGE_HELP_ID				int					set @KAKAO_MESSAGE_HELP_ID 					= 1047
	declare @KAKAO_MESSAGE_RETURN_ID			int					set @KAKAO_MESSAGE_RETURN_ID				= 1856

	--�޼��� ���ſ���.
	declare @KAKAO_MESSAGE_BLOCKED_FALSE		int 				set @KAKAO_MESSAGE_BLOCKED_FALSE 		= -1
	declare @KAKAO_MESSAGE_BLOCKED_TRUE			int					set @KAKAO_MESSAGE_BLOCKED_TRUE 		= 1
	declare @KAKAO_MESSAGE_BLOCKED_NON			int					set @KAKAO_MESSAGE_BLOCKED_NON			= 0

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

	-- �űԸ���.
	declare @NEW_FARM 							int 				set @NEW_FARM 						= 6952

	-- ��Ÿ �������.
	declare @YABAU_CHANGE_DANGA					int					set @YABAU_CHANGE_DANGA				= 100		-- ����� �ֻ��� �����
	declare @USED_FRIEND_POINT					int					set @USED_FRIEND_POINT				= 100		-- ģ������Ʈ ����.
	-------------------------------------------------------------------
	-- �α��θ� �ϸ� ���� ���� �Ҹ����� ���~~~
	--	 1�� : 2201	�Ϲ� ���� Ƽ�� (2��)
	--	 2�� : 1003	�˹��� ���� ��Ű�� (4��)
	--	 3�� : 1202	��Ȱ�� (3��)
	-------------------------------------------------------------------
	-- eventonedailystate
	declare @EVENT_STATE_NON					int					set @EVENT_STATE_NON				= 0
	declare @EVENT_STATE_YES					int					set @EVENT_STATE_YES				= 1
	declare @EVENT01_ITEM1						int					set @EVENT01_ITEM1					= 2201	-- �Ϲ� ���� Ƽ�� (2��)
	declare @EVENT01_ITEM2						int					set @EVENT01_ITEM2					= 1003	-- �˹��� ���� ��Ű�� (4��)
	declare @EVENT01_ITEM3						int					set @EVENT01_ITEM3					= 1202	-- ��Ȱ�� (3��)

	----------------------------------------------
	-- Naver �̺�Ʈ ó��
	--	�Ⱓ : 7.24 ~ 8.6
	--	��ǥ : 8.11
	--	1. ���Խ� ...		=> ��ũ�� ��1����, ���� 60��
	--						   02_01����(���Ĺ���).sql
	--	2. ���� 2��			=> �����ϸ� 2�� �̺�Ʈ
	--						   21_01ĳ��(������).sql
	--						   21_02ĳ��(����������).sql
	--	3. Naverĳ��		=> ���̹� ĳ��
	------------------------------------------------
	--declare @EVENT02_START_DAY				datetime			set @EVENT02_START_DAY			= '2014-06-13 20:00'
	--declare @EVENT02_END_DAY					datetime			set @EVENT02_END_DAY			= '2014-08-06 23:59'

	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @sysfriendid			varchar(20)				set @sysfriendid 	= 'farmgirl'
	declare @comment				varchar(512)			set @comment		= '�α���'
	declare @comment2				varchar(128)
	declare @gameid 				varchar(60)
	declare @password 				varchar(20)
	declare @condate				datetime
	declare @deletestate			int
	declare @blockstate				int
	declare @cashcopy				int
	declare @resultcopy				int
	declare @cashcost				int
	declare @gamecost				int
	declare @buytype				int
	declare @market					int						set @market			= @MARKET_GOOGLE
	declare @version				int						set @version		= 101
	declare @gameyear				int						set @gameyear		= @GAME_START_YEAR
	declare @gamemonth				int						set @gamemonth		= @GAME_START_MONTH

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
			@invenstepmax			int,	@invencountmax			int,	@seedfieldmax			int,
			@attend1				int, 	@attend2				int, 	@attend3				int,			@attend4			int, 		@attend5			int

	-- �Һ������
	declare @bulletlistidx			int,
			@vaccinelistidx			int,
			@albalistidx			int,
			@boosterlistidx			int,
			@tmpcnt					int,
			@invenkind 				int

	declare @newday					int
	declare @pettodayitemcode		int						set @pettodayitemcode	= -1		-- ���ø� ��õ ��
	declare @pettodayitemcode2		int						set @pettodayitemcode2	= -1		--        ü�� ��

	-- �⼮��
	declare @attenddate				datetime,
			@attendcnt				int,
			@attendcntview			int,
			@attendnewday			int

	declare @curversion				int						set @curversion		= -1
	declare @cursyscheck			int

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
	declare @kakaonickname			varchar(40)
	declare @kkhelpalivecnt			int				set @kkhelpalivecnt				= 0

	-- �Ǽ��縮 ���� ����.
	declare @roulaccprice			int				set @roulaccprice 				= 10 -- �Ǽ�10����.
	declare @roulaccsale			int				set @roulaccsale 				= 10 -- 10%.

	-- �̺�Ʈ1 > �α��θ��ϸ�
	declare @eventonedailystate		int				set @eventonedailystate 		= @EVENT_STATE_NON
	declare @eventonedailyloop		int

	-- �̺�Ʈ2 > ������ �ð��� �α����ϸ� ��������~~~
	declare @eventstatemaster		int				set @eventstatemaster			= @EVENT_STATE_NON
	declare @eventidx				int				set @eventidx					= -1
	declare @eventitemcode			int				set @eventitemcode				= -1
	declare @eventsender 			varchar(20)		set @eventsender				= '¥�� �ҳ�'
	declare @strmarket				varchar(40)

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
		@buytype		= isnull(buytype, 0),
		@feedmax		= feedmax,
		@heartmax		= heartmax,
		@fpointmax		= fpointmax,
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

		@kakaomsginvitetodaycnt 	= kakaomsginvitetodaycnt,
		@kakaomsginvitetodaydate	= kakaomsginvitetodaydate,
		@kakaoprofile				= kakaoprofile,
		@kakaonickname				= kakaonickname,
		@kkhelpalivecnt				= kkhelpalivecnt,

		@rtngameid		= rtngameid, 		@rtndate	= rtndate,
		@rtnstep		= rtnstep, 			@rtnplaycnt	= rtnplaycnt,

		@pettodayitemcode	= pettodayitemcode,
		@pettodayitemcode2	= pettodayitemcode2,
		@attenddate 	= attenddate, 		@attendcnt 		= attendcnt
	from dbo.tFVUserMaster
	where gameid = @gameid_
	--select 'DEBUG ��������', @gameid gameid, @blockstate blockstate, @deletestate deletestate, @cashcopy cashcopy, @resultcopy resultcopy, @gamecost gamecost, @cashcost cashcost, @attenddate attenddate, @attendcnt attendcnt

	------------------------------------------------
	--	3-3. �������� üũ
	------------------------------------------------
	select top 1 @cursyscheck = syscheck, @curversion = version from dbo.tFVNotice
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
			update dbo.tFVUserMaster
				set
					blockstate = @BLOCK_STATE_YES,
					cashcopy = 0
			where gameid = @gameid_

			-- ������3ȸ ī�ǿ� ���� ��ó��
			insert into dbo.tFVUserBlockLog(gameid, comment)
			values(@gameid_, '(ĳ������)��  '+ltrim(rtrim(str(@cashcopy)))+'ȸ �̻� ī�Ǹ� �ؼ� �α��ν� �ý��ۿ��� �� ó���߽��ϴ�.')
		END
	else if(@resultcopy >= 20)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_BLOCK_USER
			set @comment 	= '����������� '+ltrim(rtrim(str(@resultcopy)))+'ȸ�̻� �õ��ߴ�. > ��ó������!!'
			--select 'DEBUG ', @comment

			--��������� xxȸ �̻��ߴ�. > ��ó��, ���αױ��
			update dbo.tFVUserMaster
				set
					blockstate = @BLOCK_STATE_YES,
					resultcopy = 0
			where gameid = @gameid_

			-- ������3ȸ ī�ǿ� ���� ��ó��
			insert into dbo.tFVUserBlockLog(gameid, comment)
			values(@gameid_, '����������� '+ltrim(rtrim(str(@resultcopy)))+'ȸ�̻� �õ��ؼ� �α��ν� �ý��ۿ��� �� ó���߽��ϴ�.')
		END
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '�α��� ����ó��'
			--select 'DEBUG ', @comment
		END


	if(@nResult_ = @RESULT_SUCCESS)
		BEGIN
			-----------------------------------------------
			-- ����ڵ�ó��.
			-----------------------------------------------
			select @nResult_ rtn, @comment comment

			------------------------------------------------
			-- ���� �̵� ���� ����
			------------------------------------------------
			--select 'DEBUG ', @market_ market_, @version_ version_, @market market, @version version
			 if(@market != @market_)
				begin
					insert into dbo.tFVUserBeforeInfo(gameid,  market, marketnew,  version,  fame,  famelv,  famelvbest,  gameyear,  gamemonth)
					values(                        @gameid, @market, @market_,  @version, @fame, @famelv, @famelvbest, @gameyear, @gamemonth)
				end

			------------------------------------------------
			-- ���帮��Ʈ �߰��Ȱ��� ���� ��� �߰��ϱ�.
			-- ���� ����		     ~ 6928
			-- 1�� ������Ʈ 	6929 ~ 6943
			-- 2�� ������Ʈ 	6944 ~ 6952
			------------------------------------------------
			if(not exists(select top 1 * from dbo.tFVUserFarm where gameid = @gameid_ and itemcode = @NEW_FARM))
				begin
					select @farmidx = max(farmidx) from dbo.tFVUserFarm where gameid = @gameid_

					insert into dbo.tFVUserFarm(farmidx, gameid, itemcode)
					select (rank() over(order by itemcode asc) + @farmidx) as farmidx, @gameid_, itemcode from dbo.tFVItemInfo
					where subcategory = @ITEM_SUBCATEGORY_USERFARM
						and itemcode not in (select itemcode from dbo.tFVUserFarm where gameid = @gameid_)
					order by itemcode asc
				end

			-----------------------------------------------
			-- �̺�Ʈ ó��
			-----------------------------------------------
			--select 'DEBUG �̺�Ʈ ó��'

			------------------------------------------------
			-- ������ ��ȯ������ �����Ѵ�.
			------------------------------------------------
			if(@comreward = -1)
				begin
					select @idx2 = isnull(max(idx2), 1) from dbo.tFVComReward where gameid = @gameid_
					set @idx2 = @idx2 + 1

					delete dbo.tFVComReward where gameid = @gameid_ and idx2 < @idx2 - @USER_LIST_MAX

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
				@attend1			= attend1,				@attend2			= attend2,				@attend3			= attend3,			@attend4			= attend4,		@attend5			= attend5,
				@rtnflag			= rtnflag,
				@roulaccprice 		= roulaccprice,
				@roulaccsale		= roulaccsale
			from dbo.tFVSystemInfo
			order by idx desc
			--select 'DEBUG �����ü��� max', @housestepmax housestepmax, @tankstepmax tankstepmax, @bottlestepmax bottlestepmax, @pumpstepmax pumpstepmax, @transferstepmax transferstepmax, @purestepmax purestepmax, @freshcoolstepmax freshcoolstepmax, @invenstepmax invenstepmax, @invencountmax invencountmax, @seedfieldmax seedfieldmax

			-----------------------------------------------
			--	@@@@ �ý��� ����üũ
			-----------------------------------------------
			if(    (@market_ = @MARKET_SKT    and @version_ <= 113)
				or (@market_ = @MARKET_GOOGLE and @version_ <= 119)
				or (@market_ = @MARKET_NHN    and @version_ <= 107)
				or (@market_ = @MARKET_IPHONE and @version_ <= 116))
					begin
						--select 'DEBUG old version ���۳���', @market_ market_, @version_ version_
						set @housestepmax		= 7
						set @tankstepmax		= 23
						set @bottlestepmax		= 23
						set @pumpstepmax 		= 23
						set @transferstepmax 	= 23
						set @purestepmax		= 23
						set @freshcoolstepmax 	= 23
					end
			--else
			--	begin
			--		--select 'DEBUG new version ���۳���', @market_ market_, @version_ version_
			--	end
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
					from dbo.tFVItemInfo
					where subcategory = @ITEM_SUBCATEGORY_UPGRADE_HOUSE and param1 = @housestep
				end
			else
				begin
					-- �����ۿϷ� > ����, ��Ʈ �ƽ�Ȯ��.
					select
						@feedmax		= param5,
						@heartmax		= param6,
						@fpointmax		= param9
					from dbo.tFVItemInfo
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
			select @tmpcnt = cnt, @invenkind = invenkind from dbo.tFVUserItem where gameid = @gameid and listidx = @bulletlistidx
			if(@bulletlistidx != -1 and (@tmpcnt <= 0 or @invenkind != @USERITEM_INVENKIND_CONSUME ))
				begin
					--select 'DEBUG �Ѿ� �ٻ���ؼ� ���Ի���, ������ Ŭ����'
					set @bulletlistidx 		= -1
				end

			set @tmpcnt = 0
			select @tmpcnt = cnt, @invenkind = invenkind from dbo.tFVUserItem where gameid = @gameid and listidx = @vaccinelistidx
			if(@vaccinelistidx != -1 and (@tmpcnt <= 0 or @invenkind != @USERITEM_INVENKIND_CONSUME ))
				begin
					--select 'DEBUG ��� �ٻ���ؼ� ���Ի���, ������ Ŭ����'
					set @vaccinelistidx 	= -1
				end

			set @tmpcnt = 0
			select @tmpcnt = cnt, @invenkind = invenkind from dbo.tFVUserItem where gameid = @gameid and listidx = @albalistidx
			if(@albalistidx != -1 and (@tmpcnt <= 0 or @invenkind != @USERITEM_INVENKIND_CONSUME ))
				begin
					--select 'DEBUG �˹� �ٻ���ؼ� ���Ի���, ������ Ŭ����'
					set @albalistidx 		= -1
				end

			set @tmpcnt = 0
			select @tmpcnt = cnt, @invenkind = invenkind from dbo.tFVUserItem where gameid = @gameid and listidx = @boosterlistidx
			if(@boosterlistidx != -1 and (@tmpcnt <= 0 or @invenkind != @USERITEM_INVENKIND_CONSUME ))
				begin
					--select 'DEBUG ������ �ٻ���ؼ� ���Ի���, ������ Ŭ����'
					set @boosterlistidx 	= -1
				end

			-- ��Ȱ���� �κ��� ���� �ȵǴ� ��찡 �־ �������δ� Ȯ�κҰ����� ���� ������....
			-- ��� �Ҹ��۵� �߿��� ������ ���� ���� ���� ����� �ȴ�.
			delete from dbo.tFVUserItem where gameid = @gameid and invenkind = @USERITEM_INVENKIND_CONSUME and cnt <= 0

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
			-- ī�� �г��Ӻ���
			if(isnull(@kakaonickname_, '') != '')
				begin
					set @kakaonickname = @kakaonickname_
				end

			-----------------------------------------------
			-- if(�⼮�� >= 5��) �����ȹ޾ư�
			--else if(�⼮�� < 1��) �̹ݿ�
			--else if(�⼮�� = 1��) �⼮�� ����, �⼮ī���� +=1
			--else �⼮�� ����, �⼮ī���� = 1(�ʱ�ȭ)
			-----------------------------------------------
			set @tmpcnt = datediff(d, @attenddate, getdate())
			set @newday = @tmpcnt
			set @attendcntview	= @attendcnt
			set @attendnewday = case when @newday >= 1 then 1 else 0 end
			--select 'DEBUG ', @tmpcnt tmpcnt
			set @eventonedailystate = case when @newday >= 1 then @EVENT_STATE_YES else @EVENT_STATE_NON end

			if(@attendcnt >= 5)
				begin
					--select 'DEBUG(�⼮��: >= 5�� ����) �����ȹ޾ư�'
					set @tmpcnt = 0
				end
			else if(@tmpcnt < 1)
				begin
					--select 'DEBUG(�⼮��: 0 < ~ < 1.0) �̹ݿ�'
					set @tmpcnt = 0
				end
			else if(@tmpcnt >= 1)
				begin
					--select 'DEBUG(�⼮��: 1.0 <= ~ < 2.0) �⼮�� ����, �⼮ī���� +=1'
					set @attenddate 	= getdate()
					set @attendcnt 		= case when (@tmpcnt = 1) then (@attendcnt + 1) else 1 end
					set @attendcntview	= @attendcnt

					if(@attendcnt = 1)
						begin
							--select 'DEBUG 1�Ϻ���'
							exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @attend1, 'DailyReward', @gameid_, '1�Ϻ���'
						end
					else if(@attendcnt = 2)
						begin
							--select 'DEBUG 2�Ϻ���'
							exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @attend2, 'DailyReward', @gameid_, '2�Ϻ���'
						end
					else if(@attendcnt = 3)
						begin
							--select 'DEBUG 3�Ϻ���'
							exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @attend3, 'DailyReward', @gameid_, '3�Ϻ���'
						end
					else if(@attendcnt = 4)
						begin
							--select 'DEBUG 4�Ϻ���'
							exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @attend4, 'DailyReward', @gameid_, '4�Ϻ���'
						end
					else if(@attendcnt >= 5)
						begin
							--select 'DEBUG 5�Ϻ���'
							exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @attend5, 'DailyReward', @gameid_, '5�Ϻ���'
						end

					if(@attendcnt >= 5)
						begin
							set @attendcnt = 0
						end
				end
			else
				begin
					--select 'DEBUG(�⼮��: 2.0 <= ~ ���Ѵ�) �⼮ī���� = 1(�ʱ�ȭ)'
					set @attenddate 	= getdate()
					set @attendcnt 		= 1
					set @attendcntview	= @attendcnt
				end

			-------------------------------------------------------------------
			-- Event1 �α��θ� �ϸ� ���� ���� �Ҹ����� ���~~~
			-------------------------------------------------------------------
			if(@eventonedailystate = @EVENT_STATE_YES)
				begin
					set @eventonedailyloop = datepart(dd, getdate())%3
					if(@eventonedailyloop = 0)
						begin
							exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @EVENT01_ITEM1, 'OpenEvent', @gameid_, '�����̺�Ʈ'
						end
					else if(@eventonedailyloop = 1)
						begin
							exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @EVENT01_ITEM2, 'OpenEvent', @gameid_, '�����̺�Ʈ'
						end
					else
						begin
							exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @EVENT01_ITEM3, 'OpenEvent', @gameid_, '�����̺�Ʈ'
						end
				end

			-------------------------------------------------------------------
			-- Event2 ������ �ð��� �α����ϸ� ��������~~~
			-- 		step1 : �����Ͱ� ������
			--		step2 : ���� <= ���� < �� (������)
			--				=> �̺�Ʈ�ڵ�, �������ڵ�, ������
			--		step3 : �ش� ���� ����, �������� ���(tEventUser)
			-------------------------------------------------------------------
			select @eventstatemaster = eventstatemaster from dbo.tFVEventMaster where idx = 1
			--select 'DEBUG �����̺�Ʈ1-1', @eventstatemaster eventstatemaster
			if(@eventstatemaster = @EVENT_STATE_YES)
				begin
					select top 1
						@eventidx 		= eventidx,
						@eventitemcode 	= eventitemcode,
						@eventsender 	= eventsender
					from dbo.tFVEventSub
					where eventstart <= @curdate and @curdate < eventend and eventstatedaily = @EVENT_STATE_YES
					order by eventidx desc
					--select 'DEBUG �����̺�Ʈ1-2', @eventidx eventidx, @eventitemcode eventitemcode, @eventsender eventsender

					if(@eventidx != -1 and @eventitemcode != -1)
						begin
							--select 'DEBUG �����̺�Ʈ1-3'
							if(not exists(select top 1 * from dbo.tFVEvnetUserGetLog where gameid = @gameid_ and eventidx = @eventidx))
								begin
									--select 'DEBUG �����̺�Ʈ1-4 ����, �αױ��'
									exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @eventitemcode, @eventsender, @gameid_, '������ �ð�'

									insert into dbo.tFVEvnetUserGetLog(gameid,   eventidx,  eventitemcode)
									values(                         @gameid_, @eventidx, @eventitemcode)

									---------------------------------
									---- ���ͱ��� > �߰��� �ð������� ���� > ����� ����
									---------------------------------
									--if(@market_ not in (@MARKET_IPHONE) and @eventitemcode in (703, 1202))
									--	begin
									--		exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT, 1600, @eventsender, @gameid_, '������ �ð�'
									--	end

									-- �ڼ��� �ΰ�� �����Կ� �־ �����ص� �ȴ�.
									select @idx2 = max(idx) from dbo.tFVEvnetUserGetLog
									delete from tEvnetUserGetLog where idx <= @idx2 - 5000
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
					select top 1 @pettodayitemcode = itemcode from dbo.tFVItemInfo
					where subcategory = @ITEM_SUBCATEGORY_PET
						  and itemcode not in (select itemcode from dbo.tFVUserItem
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
			--if((@newday >= 1 and @yabaustep = 0) or not exists(select top 1 * from dbo.tFVSystemYabau where idx = @yabauidx))
			-------------------------------------------------------------------
			set @strmarket = '%' + ltrim(rtrim(str(@market_))) + '%'
			if(@market_ = @MARKET_GOOGLE)
				begin
					-- Google ����.
					if((@newday >= 1 and @yabaustep = 0) or @yabauidx <= -1)
						begin
							select top 1 @yabauidx = idx from dbo.tFVSystemYabau
							where famelvmin <= @famelv
								and @famelv <= famelvmax
								and packstate = 1
								and packmarket like @strmarket
								order by newid()
						end

					if(not exists(select top 1 * from dbo.tFVSystemYabau where idx = @yabauidx))
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
									exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,   @rtnitemcode, '���ͺ���', @rtngameid, ''
									exec Spu_Subgiftsend @GIFTLIST_GIFT_KIND_MESSAGE, -1, '��������', @rtngameid, @comment2
								end

							-------------------------------------
							-- ���� �ο���.
							-------------------------------------
							exec spu_FVDayLogInfoStatic @market_, 28, 1				-- �� ���ͼ�.
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
					exec Spu_Subgiftsend 1, -1, 'roulhear', @gameid_, @heartmsg
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
			select kakaoprofile, kakaonickname from dbo.tFVUserMaster
			where gameid in (select friendid FROM dbo.tFVKakaoHelpWait where gameid = @gameid_ and helpdate >= getdate() - 1)

			-- ó�����ֱ�.
			exec spu_FVsubKakaoHelpWait @gameid_

			------------------------------------------------------------------
			-- ���� > �α��� ī����
			------------------------------------------------------------------
			if(@logindate != @dateid8)
				begin
					exec spu_FVDayLogInfoStatic @market_, 14, 1               -- �� �α���(����ũ)
					exec spu_FVDayLogInfoStatic @market_, 12, 1               -- �� �α���(�ߺ�)
				end
			else
				begin
					exec spu_FVDayLogInfoStatic @market_, 12, 1               -- �� �α���(�ߺ�)
				end
			set @logindate = @dateid8

			------------------------------------------------------------------------
			-- �ֱ� �б� ������ ���.
			-----------------------------------------------------------------------
			select top 1 @schoolresult3 = schoolresult from dbo.tFVSchoolResult order by schoolresult desc
			if(@schoolresult3 > @schoolresult)
				begin
					set @schoolresult2 = 1
				end
			else
				begin
					set @schoolresult2 = 0
				end
			set @schoolresult = @schoolresult3


			--------------------------------------------------------------------
			-- ���� ����ġ ���� ����.
			--50 	3395	~ 3794
			--51 	3795	~ 4394
			--52 	4395	~ 5194
			--53 	5195	~ 6194
			--54 	6195	~ 7394
			--55	7395	~ 8794
			--56	8795	~ 10394
			--57	10395	~ 10394
			--58	12195	~ 14194
			--59	14195	~ 16394
			--60	16395	~ 18794			<= ������� ���µǾ���.
			--61 	18795	~ 21394
			--62 	21395	~ 24194
			--63 	24195	~ 27194
			--64 	27195	~ 30394
			--65 	30395	~ 33794
			--66 	33795	~ 37394
			--67 	37395	~ 41194
			--68 	41195	~ 45194
			--69 	45195	~ 49394
			--70 	49395	~
			--------------------------------------------------------------------
			--select 'DEBUG ', @market_ market_, @version_ version_, @fame fame, @famelv famelv, @famelvbest famelvbest
			if((@market_ = @MARKET_GOOGLE    and @version_ <= 119)
				or (@market_ = @MARKET_SKT    and @version_ <= 113)
				or (@market_ = @MARKET_IPHONE and @version_ <= 116)
				or (@market_ = @MARKET_NHN    and @version_ <= 107))
					begin
						--select 'DEBUG  >'
						if(@fame >= 18795)
							begin
								--select 'DEBUG   >'
								set @fame			= 18795 - 1	-- ����ġ.
								set @famelv			= 60		-- ����.
								set @famelvbest		= 60		-- ����.
							end
					end

			------------------------------------------------------------------
			-- ���� ������ ������Ʈ�ϱ�
			------------------------------------------------------------------
			--select * from dbo.tFVUserMaster where gameid = @gameid_

			update dbo.tFVUserMaster
				set
					fame			= @fame,
					famelv			= @famelv,
					famelvbest		= @famelvbest,
					market			= @market_,

					--���� ���� > �ֱ� ���ӳ�¥ ����, ���� ī���� ����
					version			= @version_,
					--gamecost		= @gamecost,
					--cashcost		= @cashcost,
					heartget		= @heartget,
					kakaomsgblocked	= case
											when (@kakaomsgblocked_ = @KAKAO_MESSAGE_BLOCKED_NON) 	then kakaomsgblocked
											when (@kakaomsgblocked_ = @KAKAO_MESSAGE_BLOCKED_TRUE) 	then @KAKAO_MESSAGE_BLOCKED_TRUE
											else kakaomsgblocked
									end,
					kkhelpalivecnt	= 0,

					-- ���ø� �Ǹ�����.
					pettodayitemcode	= @pettodayitemcode,
					pettodayitemcode2	= @pettodayitemcode2,
					logindate		= @logindate,	-- �α��γ�¥��.

					-- �⼮����
					attenddate		= @attenddate,
					attendcnt		= @attendcnt,

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
					kakaonickname			= @kakaonickname,

					condate			= getdate(),			-- ����������
					concnt			= concnt + 1			-- ����Ƚ�� +1
			where gameid = @gameid_

			--------------------------------------------------------------------
			---- ������ ���׹̳ʰ� ����Ǹ� > Ǫ������ �����ֶ� ����ϱ�
			--------------------------------------------------------------------
			--if(not exists(select top 1 * from dbo.tFVActionScheduleData where gameid = @gameid_))
			--	begin
			--		insert into tActionScheduleData(gameid) values(@gameid_)
			--	end

			----------------------------------------------
			-- �б����� �ʱ�ȭ��¥(���� ������).
			---------------------------------------------
			select @dw = DATEPART(dw, @curdate)
			set @curdate = case
								when @dw = 1 then  @curdate
								else			  (@curdate - DATEPART(dw, @curdate) + 2) + 6
						   end
			set @schoolinitdate = CONVERT(char(10), @curdate, 25) + ' 23:59:00'

			-- �б��̸�.
			set @schoolname = ''
			select @schoolname = isnull(schoolname, '') from dbo.tFVSchoolBank where schoolidx = @schoolidx

			------------------------------------------------------------------------
			-- ���� ���� ���� > ��Ȯ�� ������ �ִ°�? > �ƽ��� �ִ°�?
			-----------------------------------------------------------------------
			if(exists(select top 1 * from
											(select DATEDIFF(hh, incomedate, getdate()) * param1 as hourcoin2, b.param2 maxcoin from
												(select * from dbo.tFVUserFarm where gameid = @gameid_ and buystate = 1) a
											LEFT JOIN
												(select * from dbo.tFVItemInfo where subcategory = 69) b
											ON a.itemcode = b.itemcode) as f
										where hourcoin2 >= maxcoin ))
				begin
					set @farmharvest	= 1
				end
			else
				begin
					set @farmharvest	= 0
				end

			------------------------------------------------------------------------
			-- ģ�����߿� ���� ������� ģ���� �ִ°�?
			-----------------------------------------------------------------------
			if(exists(select top 1 * from dbo.tFVUserFriend where gameid = @gameid_ and state = 1))
				begin
					set @friendinvite = 1
				end

			------------------------------------------------------------------------
			-- ��Ʈ ���� ������ ģ��.
			-----------------------------------------------------------------------
			if(exists(select top 1 * from dbo.tFVUserFriend where gameid = @gameid_ and friendid != @sysfriendid and state = 2 and senddate <= getdate() - 1))
				begin
					set @sendheart = 1
				end

			--######################################################
			----------------------------------------------
			-- ���� ����
			---------------------------------------------
			select
				*,
				@kkhelpalivecnt kkhelpalivecnt2,
				@attendnewday attendnewday,
				@attendcntview attendcntview,
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
				@GAME_INVEN_ANIMAL_BASE invenanimalbase, @GAME_INVEN_CUSTOME_BASE invencustombase, @GAME_INVEN_ACC_BASE invenaccbase,
				((famelv / 10 + 1)*(famelv / 10 + 1) * @YABAU_CHANGE_DANGA) yabauchange,
				isnull(pmgauage, 0) pmgauage2,
				case when famelv <= 50 then @USED_FRIEND_POINT else (@USED_FRIEND_POINT + (famelv - 50)*20) end needfpoint
			from dbo.tFVUserMaster where gameid = @gameid_

			--------------------------------------------------------------
			-- ���� ������ ��ü ����Ʈ
			-- ����(��������[�ֱٰ�], �κ�, �ʵ�, ��ǥ), �Һ���, �Ǽ��縮
			--------------------------------------------------------------
			select * from dbo.tFVUserItem
			where gameid = @gameid_ and invenkind in (@USERITEM_INVENKIND_ANI, @USERITEM_INVENKIND_CONSUME, @USERITEM_INVENKIND_ACC, @USERITEM_INVENKIND_PET)
			order by diedate desc, invenkind, fieldidx, itemcode

			--------------------------------------------------------------
			-- ���� ������ ����
			--------------------------------------------------------------
			select * from dbo.tFVUserSeed
			where gameid = @gameid_
			order by seedidx asc

			--------------------------------------------------------------
			-- ���� ģ������
			-- ī�� & ������� ��ó������.(������ ���ʵ����� ��ü)
			--------------------------------------------------------------
			exec spu_FVsubFriendList @gameid_

			--------------------------------------------------------------
			-- ī�� �ʴ�ģ����
			--------------------------------------------------------------
			select * from dbo.tFVKakaoInvite where gameid = @gameid_

			--------------------------------------------------------------
			-- ���� ����/����(����, ������ɺ��� ����)
			--------------------------------------------------------------
			exec spu_FVGiftList @gameid_

			----------------------------------------------------------------
			----	���� : ���̺�.(������)
			----------------------------------------------------------------
			--select
			--	param1 dogamidx, itemname dogamname,
			--	param2 animal0, param3 animal1,
			--	param4 animal2, param5 animal3,
			--	param6 animal4, param7 animal5,
			--	param8 rewarditemcode, param9 rewardvalue
			--from dbo.tFVItemInfo
			--where subcategory = @ITEM_MAINCATEGORY_DOGAM

			--------------------------------------------------------------
			--	�굵�� : ȹ���� ��.
			--------------------------------------------------------------
			select * from dbo.tFVDogamListPet where gameid = @gameid_ order by itemcode asc

			--------------------------------------------------------------
			--	���� : ȹ���� ����.
			--------------------------------------------------------------
			select * from dbo.tFVDogamList where gameid = @gameid_ order by itemcode asc

			--------------------------------------------------------------
			--	���� : ���� ���� �����ε��� ��ȣ.
			--------------------------------------------------------------
			select * from dbo.tFVDogamReward where gameid = @gameid_ order by dogamidx asc

			--------------------------------------------------------------
			-- �������� > ĳ������(+a%), ȯ��(+b%), ��Ʈ(+c%), ����(+d%) �����⼮, ���ƽ�
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
			if(@market_ = @MARKET_NHN and getdate() < @EVENT02_END_DAY)
				begin
					select
						top 1
						housestepmax, pumpstepmax, bottlestepmax, transferstepmax, tankstepmax, purestepmax, freshcoolstepmax,
						invenstepmax, invencountmax, seedfieldmax,
						100 pluscashcost, plusgamecost, plusheart, plusfeed, attend1, attend2, attend3, attend4, attend5, composesale, iphonecoupon,
						kakaoinvite01, kakaoinvite02, kakaoinvite03, kakaoinvite04,
						@RECOMMAND_MESSAGE recommendmsg,
						@KAKAO_MESSAGE_INVITE_ID kakaoinviteid,
						@KAKAO_MESSAGE_PROUD_ID kakaoproudid,
						@KAKAO_MESSAGE_HEART_ID kakaoheartid,
						@KAKAO_MESSAGE_HELP_ID kakaohelpid
					from dbo.tFVSystemInfo
					order by idx desc
					--select 'DEBUG ��������2'
				end
			else
				begin
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
					from dbo.tFVSystemInfo
					order by idx desc
					--select 'DEBUG ��������2'
				end

			---------------------------------------------
			-- ��Ű����ǰ.
			---------------------------------------------
			set @strmarket = '%' + ltrim(rtrim(str(@market_))) + '%'

			select top 1 * from dbo.tFVSystemPack
			where famelvmin <= @famelv
				and @famelv <= famelvmax
				and packstate = 1
				and packmarket like @strmarket
				--and (ABS(CAST( (BINARY_CHECKSUM(*) * RAND()) as int)) % 100) <= 100
				order by newid()

			---------------------------------------------
			-- ����̱�.
			---------------------------------------------
			select top 1 * from dbo.tFVSystemRoulette
			where famelvmin <= @famelv
				and @famelv <= famelvmax
				and packstate = 1
				--and (ABS(CAST( (BINARY_CHECKSUM(*) * RAND()) as int)) % 100) <= 100
				order by newid()

			---------------------------------------------
			-- ��ŷ.
			---------------------------------------------
			exec spu_FVsubFriendRank @gameid_, 1

			---------------------------------------------
			-- ��������.
			---------------------------------------------
			exec spu_FVUserFarmListNew @gameid_, 1, @market_, @version_

			---------------------------------------------
			-- ���Ǽҵ� ���׽�Ʈ ���.
			---------------------------------------------
			select * from dbo.tFVEpiReward
			where gameid = @gameid_
			order by idx asc

			---------------------------------------------
			-- ģ����ŷ(����).
			---------------------------------------------
			-- ���� ���� �������� �����ش�.

			---------------------------------------------
			-- ���� �б���ŷ(�б� + ���Ҽ�).
			---------------------------------------------
			exec spu_FVSchoolRank 11, -1, @gameid_

			---------------------------------------------
			-- ������ ģ����.
			---------------------------------------------
			select * from @tTempTableHelpWait

			---------------------------------------------
			-- ����� ��.
			---------------------------------------------
			select top 1 * from dbo.tFVSystemYabau where idx = @yabauidx

			---------------------------------------------
			-- �����̾� ���� �ڷ�.
			---------------------------------------------
			--select 'DEBUG ', @strmarket strmarket,
			set @curdate = getdate()
			select
				top 1 *,
				case when (@curdate > roulstart and @curdate <= roulend) then roulflag 		else -1 end roulflag2,
				case when (@curdate > roulstart and @curdate <= roulend) then roultimeflag 	else -1 end roultimeflag2,
				case when (@curdate > roulstart and @curdate <= roulend) then pmgauageflag 	else -1 end pmgauageflag2
			from dbo.tFVSystemRouletteMan
			where roulmarket like @strmarket
			order by idx desc

		END
	else
		BEGIN
			select @nResult_ rtn, @comment comment
		END

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off
End



