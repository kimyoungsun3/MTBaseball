use Game4FarmVill3
GO

IF OBJECT_ID ( 'dbo.spu_SamplePro', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_SamplePro;
GO

create procedure dbo.spu_SamplePro
	@gameid_				varchar(60),						-- ���Ӿ��̵�
	@password_				varchar(20),						-- ��ȣȭ�ؼ�����, �����н����� ��ŷ���ص� ����
	@nResult_				int					OUTPUT
	--WITH ENCRYPTION
as
	------------------------------------------------
	--	2-1. �ڵ尪
	------------------------------------------------
	-- �Ϲݰ�
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	-- ���̵� ����
	declare @RESULT_ERROR_ID_DUPLICATE			int				set @RESULT_ERROR_ID_DUPLICATE			= -2
	declare @RESULT_ERROR_ID_CREATE_MAX 		int				set @RESULT_ERROR_ID_CREATE_MAX			= -3	-- ��������.

	-- �α��� ����.
	declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--������ > �˾�ó���� ��Ʈ�η� ��������.
	declare @RESULT_ERROR_DELETED_USER 			int				set @RESULT_ERROR_DELETED_USER			= -12			--�������� > �˾�ó���� ��Ʈ�η� ��������.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--�ش������� ã�� ����
	declare @RESULT_ERROR_NOT_FOUND_PASSWORD	int				set @RESULT_ERROR_NOT_FOUND_PASSWORD	= -17
	declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--������ �����ϰ� �ִ�.
	declare @RESULT_NEWVERION_CLIENT_DOWNLOAD 	int				set @RESULT_NEWVERION_CLIENT_DOWNLOAD	= -15			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ��ũó��.
	declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ����.
	declare @RESULT_ERROR_NOT_FOUND_PHONE 		int				set @RESULT_ERROR_NOT_FOUND_PHONE		= -76			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ����.

	-- �����߿� ����.
	declare @RESULT_ERROR_HEART_LACK			int				set @RESULT_ERROR_HEART_LACK			= -20			--��Ʈ�� �����ϴ�.
	declare @RESULT_ERROR_GAMECOST_LACK			int				set @RESULT_ERROR_GAMECOST_LACK			= -21			--�ǹ��� �����ϴ�.
	declare @RESULT_ERROR_CASHCOST_LACK			int				set @RESULT_ERROR_CASHCOST_LACK			= -22			--��尡 �����ϴ�.
	declare @RESULT_ERROR_ITEM_LACK				int				set @RESULT_ERROR_ITEM_LACK				= -23			--�������̺����ϴ�.
	declare @RESULT_ERROR_FPOINT_LACK			int				set @RESULT_ERROR_FPOINT_LACK			= -124			--

	-- ������ ����, ����.
	declare @RESULT_ERROR_BUY_ALREADY			int				set @RESULT_ERROR_BUY_ALREADY			= -31			--�̹� �����߽��ϴ�.
	declare @RESULT_ERROR_NOT_HAVE				int				set @RESULT_ERROR_NOT_HAVE				= -32			--�������� �ʰ� �ִ�.
	declare @RESULT_ERROR_UPGRADE_FULL			int				set @RESULT_ERROR_UPGRADE_FULL			= -35			--���׷��̵尡 Ǯ�εǾ���.
	declare @RESULT_ERROR_ITEM_NOSALE_KIND		int				set @RESULT_ERROR_ITEM_NOSALE_KIND		= -37			--�Ǹ����� �ʴ� ������

	-- ĳ������.
	declare @RESULT_ERROR_CASH_COPY				int				set @RESULT_ERROR_CASH_COPY				= -40
	declare @RESULT_ERROR_CASH_OVER				int				set @RESULT_ERROR_CASH_OVER				= -41
	declare @RESULT_ERROR_MONTH_OVER			int				set @RESULT_ERROR_MONTH_OVER			= -42			--�Ѵ޵��� �����ѵ��� �˻�

	-- ���� �ڵ尪
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- �������ڵ��ã��
	declare @RESULT_ERROR_GIFTITEM_NOT_FOUND	int				set @RESULT_ERROR_GIFTITEM_NOT_FOUND	= -51			-- ������������ ��ã��
	declare @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	int				set @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	= -52			-- ������ �̹� ������
	declare @RESULT_ERROR_NOT_FOUND_GIFTID		int				set @RESULT_ERROR_NOT_FOUND_GIFTID		= -75			-- ĳ�� > ������ ���̵� ��ã��

	-- SMS
	declare @RESULT_ERROR_SMS_NOT_MATCH_PHONE	int				set @RESULT_ERROR_SMS_NOT_MATCH_PHONE	= -80			--������õ.
	declare @RESULT_ERROR_SMS_KEY_DUPLICATE		int				set @RESULT_ERROR_SMS_KEY_DUPLICATE		= -81
	declare @RESULT_ERROR_SMS_REJECT			int				set @RESULT_ERROR_SMS_REJECT			= -84
	declare @RESULT_ERROR_SMS_DOUBLE_PHONE		int				set @RESULT_ERROR_SMS_DOUBLE_PHONE		= -85
	declare @RESULT_ERROR_KEY_DUPLICATE			int				set @RESULT_ERROR_KEY_DUPLICATE			= -86			-- �Ϲ� Ű�� �ߺ��Ǿ���.

	-- ��Ÿ����
	declare @RESULT_ERROR_RESULT_COPY			int				set @RESULT_ERROR_RESULT_COPY			= -53			-- ���ī�ǽõ�
	declare @RESULT_ERROR_GAMECOST_COPY			int				set @RESULT_ERROR_GAMECOST_COPY			= -54			-- �ǹ�ī�ǽõ�
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- ���������ʴ¸��
	declare @RESULT_ERROR_HEART_FULL			int				set @RESULT_ERROR_HEART_FULL			= -71			-- ���������ʴ¸��
	declare @RESULT_ERROR_TUTORIAL_ALREADY		int				set @RESULT_ERROR_TUTORIAL_ALREADY		= -73			-- ���丮�� �̹� ����.
	declare @RESULT_ERROR_NOT_FOUND_OTHERID		int				set @RESULT_ERROR_NOT_FOUND_OTHERID		= -83
	declare @RESULT_ERROR_INVEN_FULL			int				set @RESULT_ERROR_INVEN_FULL			= -101			-- �κ�����
	declare @RESULT_ERROR_DAILY_REWARD_ALREADY	int				set @RESULT_ERROR_DAILY_REWARD_ALREADY	= -102			-- ���Ϻ��� �̹� ����.
	declare @RESULT_ERROR_NOT_FOUND_DOGAMIDX	int				set @RESULT_ERROR_NOT_FOUND_DOGAMIDX	= -103			-- ������ȣ�� ã���� ����.
	declare @RESULT_ERROR_DOGAM_ALREADY_REWARD	int				set @RESULT_ERROR_DOGAM_ALREADY_REWARD	= -104			-- ������ �̹� ��������.
	declare @RESULT_ERROR_DOGAM_LACK			int				set @RESULT_ERROR_DOGAM_LACK			= -105			-- �����߿� ������ȣ�� ������.
	declare @RESULT_ERROR_ANIMAL_NOT_FOUND		int				set @RESULT_ERROR_ANIMAL_NOT_FOUND		= -106			-- ��ǥ���� ��ã��
	declare @RESULT_ERROR_ANIMAL_NOT_INVEN		int				set @RESULT_ERROR_ANIMAL_NOT_INVEN		= -107			-- �κ��� ����(â��)
	declare @RESULT_ERROR_ANIMAL_NOT_ALIVE		int				set @RESULT_ERROR_ANIMAL_NOT_ALIVE		= -108			-- ��� ���� ����
	declare @RESULT_ERROR_ANIMAL_IS_ALIVE		int				set @RESULT_ERROR_ANIMAL_IS_ALIVE		= -116			-- ������ ����ִ�.
	declare @RESULT_ERROR_ANIMAL_FIELDIDX		int				set @RESULT_ERROR_ANIMAL_FIELDIDX		= -117			-- �ʵ��ε�������.
	declare @RESULT_ERROR_NOT_MATCH				int				set @RESULT_ERROR_NOT_MATCH				= -110			-- �����ΰ� ��ġ�� �ȵǾ���.
	declare @RESULT_ERROR_DOUBLE_RANDSERIAL		int				set @RESULT_ERROR_DOUBLE_RANDSERIAL		= -111			-- �����ø��� �ߺ�.
	declare @RESULT_ERROR_MAXCOUNT				int				set @RESULT_ERROR_MAXCOUNT				= -112			-- �ƽ�ī����.
	declare @RESULT_ERROR_ITEMCOST_WRONG		int				set @RESULT_ERROR_ITEMCOST_WRONG		= -113			-- ������ ������ �̻���.
	declare @RESULT_ERROR_LISTIDX_NOT_FOUND		int				set @RESULT_ERROR_LISTIDX_NOT_FOUND		= -114			-- ����Ʈ ��ȣ�� ��ã��.
	declare @RESULT_ERROR_NOT_ENOUGH			int				set @RESULT_ERROR_NOT_ENOUGH			= -115			-- �����ΰ� ������� ����.
	declare @RESULT_ERROR_NOT_FOUND_SEEDIDX		int				set @RESULT_ERROR_NOT_FOUND_SEEDIDX		= -118			-- �Ķ���� ����.
	declare @RESULT_ERROR_PLANT_ALREADY			int				set @RESULT_ERROR_PLANT_ALREADY			= -119			-- �̹� ������ �ɾ�������.
	declare @RESULT_ERROR_NEED_BUY				int				set @RESULT_ERROR_NEED_BUY				= -120			-- �������� �̱��Ż���.
	declare @RESULT_ERROR_HARVEST_TIME_REMAIN	int				set @RESULT_ERROR_HARVEST_TIME_REMAIN	= -121			-- ���� �ð��� ����.
	declare @RESULT_ERROR_PARAMETER				int				set @RESULT_ERROR_PARAMETER				= -122			-- �Ķ���Ϳ���.
	declare @RESULT_ERROR_TIME_REMAIN			int				set @RESULT_ERROR_TIME_REMAIN			= -123			-- ���� �ð��� ����.
	declare @RESULT_ERROR_NOT_FOUND_USERFARM	int				set @RESULT_ERROR_NOT_FOUND_USERFARM	= -125			-- ���帮��Ʈ�� �̱���.
	declare @RESULT_ERROR_ALREADY_REWARD		int				set @RESULT_ERROR_ALREADY_REWARD		= -126			-- �����ΰ� �̹̺�������.
	declare @RESULT_ERROR_CANNT_CHANGEDAY_SCHOOL	int			set @RESULT_ERROR_CANNT_CHANGEDAY_SCHOOL= -127			-- �б��������� �������.
	declare @RESULT_ERROR_CANNT_JOINDAY_SCHOOL	int				set @RESULT_ERROR_CANNT_JOINDAY_SCHOOL	= -128			-- �б��������� ���ԺҰ�.
	declare @RESULT_ERROR_CANNT_FIND_SCHOOL		int				set @RESULT_ERROR_CANNT_FIND_SCHOOL		= -129			-- �б��������� �б��� ã���� ����.
	declare @RESULT_ERROR_CANNT_JOINMAX_SCHOOL	int				set @RESULT_ERROR_CANNT_JOINMAX_SCHOOL	= -130			-- �б��������� �б��� �ƽ��Դϴ�.
	declare @RESULT_ERROR_FRIEND_WAIT_MAX		int				set @RESULT_ERROR_FRIEND_WAIT_MAX		= -131			-- ģ�� ��� �ƽ�(���̻� ģ�� ��û�� �� �� �����ϴ�.)
	declare @RESULT_ERROR_FRIEND_AGREE_MAX		int				set @RESULT_ERROR_FRIEND_AGREE_MAX		= -132			-- ģ�� �ƽ�(�� �̻� ģ���� ���� �� �����ϴ�.)
	declare @RESULT_ERROR_NOT_FOUND_CERTNO		int				set @RESULT_ERROR_NOT_FOUND_CERTNO		= -133			-- ���� ��ȣ�� ����.
	declare @RESULT_ERROR_NO_MORE_PET			int				set @RESULT_ERROR_NO_MORE_PET			= -134			-- ���̻� ���� ����.
	declare @RESULT_ERROR_HELP_TIME_REMAIN		int				set @RESULT_ERROR_HELP_TIME_REMAIN		= -140			-- Help Ÿ���� ��������.
	declare @RESULT_ERROR_CANNOT_USED_NICKNAME	int				set @RESULT_ERROR_CANNOT_USED_NICKNAME	= -141			-- �г��� ���Ұ�.
	declare @RESULT_ERROR_JOIN_WAIT				int				set @RESULT_ERROR_JOIN_WAIT				= -142			-- ���Խð����.
	declare @RESULT_ERROR_ALREADY_REWARD_COUPON	int				set @RESULT_ERROR_ALREADY_REWARD_COUPON	= -143			-- ������ 1�� 1��.
	declare @RESULT_ERROR_ACC_SAMEPART			int				set @RESULT_ERROR_ACC_SAMEPART			= -144			-- �Ǽ��縮�� ���� ��Ʈ�̴�.
	declare @RESULT_ERROR_ACC_EMPTY_CREATE		int				set @RESULT_ERROR_ACC_EMPTY_CREATE		= -145			-- �Ǽ��縮�� ����� �����ҷ����Ѵ�.
	declare @RESULT_ERROR_CANNT_CHANGE			int				set @RESULT_ERROR_CANNT_CHANGE			= -146			-- ������ �� �����ϴ�..
	declare @RESULT_ERROR_ALIVE_USER			int				set @RESULT_ERROR_ALIVE_USER			= -147			-- ���� Ȱ���ϴ� �����Դϴ�.
	declare @RESULT_ERROR_WAIT_RETURN			int				set @RESULT_ERROR_WAIT_RETURN			= -148			-- ��û ������Դϴ�.
	declare @RESULT_ERROR_KAKAO_MESSAGE_BLOCK	int				set @RESULT_ERROR_KAKAO_MESSAGE_BLOCK	= -149			-- �޼��� ���Űźλ����Դϴ�
	declare @RESULT_ERROR_HEART_ROUL_3TIME_OVER	int				set @RESULT_ERROR_HEART_ROUL_3TIME_OVER	= -150			-- ���� ��Ʈ�̱� 1�� 3ȸ�� �ʰ��߽��ϴ�.

	------------------------------------------------
	--	2-2. ���ǰ�
	------------------------------------------------
	-- ����ó�ڵ�
	declare @MARKET_SKT							int					set @MARKET_SKT						= 1
	declare @MARKET_KT							int					set @MARKET_KT						= 2
	declare @MARKET_LGT							int					set @MARKET_LGT						= 3
	declare @MARKET_GOOGLE						int					set @MARKET_GOOGLE					= 5
	declare @MARKET_NHN							int					set @MARKET_NHN						= 6
	declare @MARKET_IPHONE						int					set @MARKET_IPHONE					= 7

	-- (����/�����ڵ�)
	declare @BUYTYPE_FREE						int					set @BUYTYPE_FREE 					= 0	-- ���ᰡ�� : ������ �ּ�
	declare @BUYTYPE_PAY						int					set @BUYTYPE_PAY 					= 1	-- ���ᰡ�� : ������ ����
	declare @BUYTYPE_PAY2						int					set @BUYTYPE_PAY2 					= 2	-- ���ᰡ��(�簡��)

	-- (�÷���)
	declare @PLATFORM_ANDROID 					int					set @PLATFORM_ANDROID				= 1
	declare @PLATFORM_IPHONE 					int					set @PLATFORM_IPHONE				= 2

	-- �����°�.
	declare @BLOCK_STATE_NO						int					set	@BLOCK_STATE_NO					= 0	-- �����¾ƴ�
	declare @BLOCK_STATE_YES					int					set	@BLOCK_STATE_YES				= 1	-- ������

	-- �������°�.
	declare @DELETE_STATE_NO					int					set	@DELETE_STATE_NO				= 0	-- �������¾ƴ�
	declare @DELETE_STATE_YES					int					set	@DELETE_STATE_YES				= 1	-- ��������

	-- �ý��� üŷ
	declare @SYSCHECK_NON						int					set @SYSCHECK_NON					= 0
	declare @SYSCHECK_YES						int					set @SYSCHECK_YES					= 1

	-- üŷ
	declare @INFOMATION_NO						int					set @INFOMATION_NO					= -1
	declare @INFOMATION_YES						int					set @INFOMATION_YES					=  1

	-- bool
	declare @BOOL_TRUE							int					set @BOOL_TRUE						= 1
	declare @BOOL_FALSE							int					set @BOOL_FALSE						= 0

	-- �Ϲݰ���, �Խ�Ʈ ����
	declare @JOIN_MODE_GUEST					int					set @JOIN_MODE_GUEST				= 1
	declare @JOIN_MODE_PLAYER					int					set @JOIN_MODE_PLAYER				= 2

	-- compose
	declare @COMPOSE_RESULT_SUCCESS				int					set @COMPOSE_RESULT_SUCCESS			= 1
	declare @COMPOSE_RESULT_FAIL				int					set @COMPOSE_RESULT_FAIL			= 0

	-- �����ۺ� �κ��з�
	declare @USERITEM_INVENKIND_ANI				int 				set @USERITEM_INVENKIND_ANI					= 1
	declare @USERITEM_INVENKIND_CONSUME			int 				set @USERITEM_INVENKIND_CONSUME				= 3
	declare @USERITEM_INVENKIND_ACC				int 				set @USERITEM_INVENKIND_ACC					= 4
	declare @USERITEM_INVENKIND_DIRECT			int 				set @USERITEM_INVENKIND_DIRECT				= 40
	declare @USERITEM_INVENKIND_INFO			int 				set @USERITEM_INVENKIND_INFO				= 60
	declare @USERITEM_INVENKIND_PET				int 				set @USERITEM_INVENKIND_PET					= 1000

	-- ������ ��з�
	declare @ITEM_MAINCATEGORY_ANI				int					set @ITEM_MAINCATEGORY_ANI 					= 1 	--����(1)
	declare @ITEM_MAINCATEGORY_CONSUME			int					set @ITEM_MAINCATEGORY_CONSUME 				= 3 	--�Ҹ�ǰ(3)
	declare @ITEM_MAINCATEGORY_ACC				int					set @ITEM_MAINCATEGORY_ACC 					= 4 	--�׼�����(4)
	declare @ITEM_MAINCATEGORY_HEART			int					set @ITEM_MAINCATEGORY_HEART 				= 40 	--��Ʈ(40)
	declare @ITEM_MAINCATEGORY_CASHCOST			int					set @ITEM_MAINCATEGORY_CASHCOST 			= 50 	--ĳ������(50)
	declare @ITEM_MAINCATEGORY_GAMECOST			int					set @ITEM_MAINCATEGORY_GAMECOST 			= 51 	--���μ���(51)
	declare @ITEM_MAINCATEGORY_ROULETTE			int					set @ITEM_MAINCATEGORY_ROULETTE 			= 52 	--�̱�(52)
	declare @ITEM_MAINCATEGORY_CONTEST			int					set @ITEM_MAINCATEGORY_CONTEST 				= 53 	--��ȸ(53)
	declare @ITEM_MAINCATEGORY_CONTRADE			int					set @ITEM_MAINCATEGORY_CONTRADE 			= 54 	--���Ӱŷ�(54)
	declare @ITEM_MAINCATEGORY_TUTORIAL			int					set @ITEM_MAINCATEGORY_TUTORIAL				= 55 	--Ʃ�丮��(55)
	declare @ITEM_MAINCATEGORY_FIELDOPEN		int					set @ITEM_MAINCATEGORY_FIELDOPEN			= 56 	--�ʵ����(56)
	declare @ITEM_MAINCATEGORY_UPGRADE			int					set @ITEM_MAINCATEGORY_UPGRADE 				= 60 	--����(60)
	declare @ITEM_MAINCATEGORY_INVEN			int					set @ITEM_MAINCATEGORY_INVEN 				= 67 	--�κ�Ȯ��(67)
	declare @ITEM_MAINCATEGORY_SEEDFIEL			int					set @ITEM_MAINCATEGORY_SEEDFIEL 			= 68 	--������Ȯ��(68)
	declare @ITEM_MAINCATEGORY_USERFARM			int					set @ITEM_MAINCATEGORY_USERFARM 			= 69 	--��������(69)
	declare @ITEM_MAINCATEGORY_DOGAM			int					set @ITEM_MAINCATEGORY_DOGAM 				= 818 	--����(818)
	declare @ITEM_MAINCATEGORY_GAMEINFO			int					set @ITEM_MAINCATEGORY_GAMEINFO 			= 500 	--��������(500)
	declare @ITEM_MAINCATEGORY_ATTENDANCE		int					set @ITEM_MAINCATEGORY_ATTENDANCE 			= 900 	--�⼮(900)
	--declare @ITEM_MAINCATEGORY_TUTORIAL		int					set @ITEM_MAINCATEGORY_TUTORIAL 			= 901 	--Ʃ�丮��(901)
	declare @ITEM_MAINCATEGORY_EPISODE			int					set @ITEM_MAINCATEGORY_EPISODE	 			= 910 	--���Ǽҵ�(910)
	declare @ITEM_MAINCATEGORY_PET				int					set @ITEM_MAINCATEGORY_PET		 			= 1000 	--��(1000)
	declare @ITEM_MAINCATEGORY_COMPOSE			int					set @ITEM_MAINCATEGORY_COMPOSE	 			= 1010 	--�����ռ�(1010)

	-- ������ �Һз�
	declare @ITEM_SUBCATEGORY_COW				int					set @ITEM_SUBCATEGORY_COW 					= 1  -- ��		(�Ǹ�[O], ����[O])
	declare @ITEM_SUBCATEGORY_GOAT				int					set @ITEM_SUBCATEGORY_GOAT 					= 2  -- ��		(�Ǹ�[O], ����[O])
	declare @ITEM_SUBCATEGORY_SHEEP				int					set @ITEM_SUBCATEGORY_SHEEP 				= 3  -- ���	(�Ǹ�[O], ����[O])
	declare @ITEM_SUBCATEGORY_SEED				int					set @ITEM_SUBCATEGORY_SEED 					= 7  -- ����	(�Ǹ�[X], ����[X], ����[O])
	declare @ITEM_SUBCATEGORY_BULLET			int					set @ITEM_SUBCATEGORY_BULLET 				= 8  -- �Ѿ�	(�Ǹ�[O], ����[O], ����[O])
	declare @ITEM_SUBCATEGORY_VACCINE			int					set @ITEM_SUBCATEGORY_VACCINE 				= 9  -- ġ����	(�Ǹ�[O], ����[O], ����[O])
	declare @ITEM_SUBCATEGORY_FEED				int					set @ITEM_SUBCATEGORY_FEED 					= 44 -- ����	(�Ǹ�[X], ����[O])
	declare @ITEM_SUBCATEGORY_ALBA				int					set @ITEM_SUBCATEGORY_ALBA 					= 11 -- �ϲ�	(�Ǹ�[O], ����[O], ����[O])
	declare @ITEM_SUBCATEGORY_BOOSTER			int					set @ITEM_SUBCATEGORY_BOOSTER 				= 12 -- ������	(�Ǹ�[O], ����[O], ����[O])
	declare @ITEM_SUBCATEGORY_REVIVAL			int					set @ITEM_SUBCATEGORY_REVIVAL 				= 13 -- ��Ȱ��	(�Ǹ�[O], ����[O])
	declare @ITEM_SUBCATEGORY_COMPOSE_TIME		int					set @ITEM_SUBCATEGORY_COMPOSE_TIME 			= 16 -- �ռ�1�ð� �ʱ�ȭ(�Ǹ�[X], ����[O])
	declare @ITEM_SUBCATEGORY_ACC				int					set @ITEM_SUBCATEGORY_ACC 					= 15 -- �Ǽ�	(�Ǹ�[O], ����[O])
	declare @ITEM_SUBCATEGORY_FPOINT			int					set @ITEM_SUBCATEGORY_FPOINT 				= 19 -- ��������Ʈ(�Ǹ�[X], ����[O])
	declare @ITEM_SUBCATEGORY_HEART				int					set @ITEM_SUBCATEGORY_HEART 				= 40 -- ��Ʈ	(�Ǹ�[O], ����[O])
	declare @ITEM_SUBCATEGORY_HELPER			int					set @ITEM_SUBCATEGORY_HELPER 				= 41 -- ��޿�û(�Ǹ�[X], ����[O])
	declare @ITEM_SUBCATEGORY_TRADESAFE			int					set @ITEM_SUBCATEGORY_TRADESAFE				= 42 -- ���θ���(�Ǹ�[X], ����[O])
	declare @ITEM_SUBCATEGORY_CASHCOST			int					set @ITEM_SUBCATEGORY_CASHCOST 				= 50 -- ĳ��	(�Ǹ�[O], ����[O])
	declare @ITEM_SUBCATEGORY_GAMECOST			int					set @ITEM_SUBCATEGORY_GAMECOST 				= 51 -- ����	(�Ǹ�[O], ����[O])
	declare @ITEM_SUBCATEGORY_ROULETTE_NOR		int					set @ITEM_SUBCATEGORY_ROULETTE_NOR			= 22 -- �Ϲݱ���̱�Ƽ��(�Ǹ�[X], ����[O])
	declare @ITEM_SUBCATEGORY_ROULETTE_PRE		int					set @ITEM_SUBCATEGORY_ROULETTE_PRE			= 23 -- �����̾�����̱�Ƽ��(�Ǹ�[X], ����[O])
	declare @ITEM_SUBCATEGORY_CONTEST			int					set @ITEM_SUBCATEGORY_CONTEST 				= 53 -- ��ȸ	(�Ǹ�[O], ����[O])
	declare @ITEM_SUBCATEGORY_CONTRADE			int					set @ITEM_SUBCATEGORY_CONTRADE 				= 54 -- ���Ӱŷ�(54)
	declare @ITEM_SUBCATEGORY_TUTORIAL			int					set @ITEM_SUBCATEGORY_TUTORIAL 				= 55 -- Ʃ�丮��(55)
	declare @ITEM_SUBCATEGORY_FIELDOPEN			int					set @ITEM_SUBCATEGORY_FIELDOPEN				= 56 -- �ʵ����(56)
	declare @ITEM_SUBCATEGORY_UPGRADE_HOUSE		int					set @ITEM_SUBCATEGORY_UPGRADE_HOUSE 		= 60 -- ��
	declare @ITEM_SUBCATEGORY_UPGRADE_TANK		int					set @ITEM_SUBCATEGORY_UPGRADE_TANK 			= 61 -- ��ũ
	declare @ITEM_SUBCATEGORY_UPGRADE_FRESHCOOL	int					set @ITEM_SUBCATEGORY_UPGRADE_FRESHCOOL 	= 62 -- ���º���
	declare @ITEM_SUBCATEGORY_UPGRADE_PURE		int					set @ITEM_SUBCATEGORY_UPGRADE_PURE 			= 63 -- ��ȭ�ü�
	declare @ITEM_SUBCATEGORY_UPGRADE_BOTTLE	int					set @ITEM_SUBCATEGORY_UPGRADE_BOTTLE 		= 64 -- �絿��
	declare @ITEM_SUBCATEGORY_UPGRADE_PUMP		int					set @ITEM_SUBCATEGORY_UPGRADE_PUMP 			= 65 -- ������
	declare @ITEM_SUBCATEGORY_UPGRADE_TRANSFER	int					set @ITEM_SUBCATEGORY_UPGRADE_TRANSFER 		= 66 -- ���Ա�
	declare @ITEM_SUBCATEGORY_INVEN				int					set @ITEM_SUBCATEGORY_INVEN 				= 67 -- �κ�Ȯ��
	declare @ITEM_SUBCATEGORY_SEEDFIELD			int					set @ITEM_SUBCATEGORY_SEEDFIELD 			= 68 -- ������Ȯ��
	declare @ITEM_SUBCATEGORY_USERFARM			int					set @ITEM_SUBCATEGORY_USERFARM	 			= 69 -- ��������
	declare @ITEM_SUBCATEGORY_DOGAM				int					set @ITEM_SUBCATEGORY_DOGAM 				= 818 -- ����
	declare @ITEM_SUBCATEGORY_SYSINFO			int					set @ITEM_SUBCATEGORY_SYSINFO 				= 500 -- ��������
	declare @ITEM_SUBCATEGORY_ATTENDANCE		int					set @ITEM_SUBCATEGORY_ATTENDANCE 			= 900 	--�⼮(900)
	declare @ITEM_SUBCATEGORY_COMPETITION		int					set @ITEM_SUBCATEGORY_COMPETITION 			= 901 	--������(901)
	--declare @ITEM_SUBCATEGORY_TRADEREWARD		int					set @ITEM_SUBCATEGORY_TRADEREWARD			= 902 	--�ʰ��ŷ�(902)
	declare @ITEM_SUBCATEGORY_EPISODE			int					set @ITEM_SUBCATEGORY_EPISODE				= 910 	--���Ǽҵ�(910)
	declare @ITEM_SUBCATEGORY_PET				int					set @ITEM_SUBCATEGORY_PET					= 1000 	--��(1000)
	declare @ITEM_SUBCATEGORY_COMPOSE			int					set @ITEM_SUBCATEGORY_COMPOSE				= 1010 	--�����ռ�(1010)

	-- ���� ���ǰ�
	declare @GIFTLIST_GIFT_KIND_MESSAGE			int					set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2
	declare @GIFTLIST_GIFT_KIND_MESSAGE_DEL		int					set @GIFTLIST_GIFT_KIND_MESSAGE_DEL			= -1
	declare @GIFTLIST_GIFT_KIND_GIFT_DEL		int					set @GIFTLIST_GIFT_KIND_GIFT_DEL			= -2
	declare @GIFTLIST_GIFT_KIND_GIFT_GET		int					set @GIFTLIST_GIFT_KIND_GIFT_GET			= -3
	declare @GIFTLIST_GIFT_KIND_GIFT_SELL		int					set @GIFTLIST_GIFT_KIND_GIFT_SELL			= -4

	-- ������ ȹ����
	declare @DEFINE_HOW_GET_FIRST				int					set @DEFINE_HOW_GET_FIRST					= 0	--�⺻
	declare @DEFINE_HOW_GET_BUY					int					set @DEFINE_HOW_GET_BUY						= 1	--����
	declare @DEFINE_HOW_GET_SEEDFIELD			int					set @DEFINE_HOW_GET_SEEDFIELD				= 2	--����
	declare @DEFINE_HOW_GET_ROULETTE			int					set @DEFINE_HOW_GET_ROULETTE				= 3	--����/�̱�
	declare @DEFINE_HOW_GET_SEARCH				int					set @DEFINE_HOW_GET_SEARCH					= 4	--�˻�
	declare @DEFINE_HOW_GET_GIFT				int					set @DEFINE_HOW_GET_GIFT					= 5	--����
	declare @DEFINE_HOW_GET_TODAYBUY			int					set @DEFINE_HOW_GET_TODAYBUY				= 6	--[��]���ø��Ǹ�
	declare @DEFINE_HOW_GET_PETROLL				int					set @DEFINE_HOW_GET_PETROLL					= 7	--[��]�̱�
	declare @DEFINE_HOW_GET_ROULACC				int					set @DEFINE_HOW_GET_ROULACC					= 9	--�Ǽ��̱�
	declare @DEFINE_HOW_GET_ACCSTRIP			int					set @DEFINE_HOW_GET_ACCSTRIP				= 10--�Ǽ�����
	declare @DEFINE_HOW_GET_COMPOSE				int					set @DEFINE_HOW_GET_COMPOSE					= 11--�ռ�
	declare @DEFINE_HOW_GET_YABAU				int					set @DEFINE_HOW_GET_YABAU					= 12--�߹����̱�

	-- �������. (99)
	declare @PUSH_MODE_MSG						int					set @PUSH_MODE_MSG							= 1
	declare @PUSH_MODE_PEACOCK					int					set @PUSH_MODE_PEACOCK						= 2
	declare @PUSH_MODE_URL						int					set @PUSH_MODE_URL							= 3
	declare @PUSH_MODE_GROUP					int					set @PUSH_MODE_GROUP						= 99	-- ��ü�߼ۿ�

	-- ģ���˻�, �߰�, ����
	declare @USERFRIEND_MODE_SEARCH				int					set	@USERFRIEND_MODE_SEARCH						= 1;
	declare @USERFRIEND_MODE_ADD				int					set	@USERFRIEND_MODE_ADD						= 2;
	declare @USERFRIEND_MODE_DELETE				int					set	@USERFRIEND_MODE_DELETE						= 3;
	declare @USERFRIEND_MODE_MYLIST				int					set	@USERFRIEND_MODE_MYLIST						= 4;
	declare @USERFRIEND_MODE_VISIT				int					set	@USERFRIEND_MODE_VISIT						= 5;

	-- �ڶ��ϱ⸦ ���ؼ� ����ޱ�.
	declare @BOARDWRITE_REWARD_GAMECOST			int					set @BOARDWRITE_REWARD_GAMECOST				= 500

	-- ���� or ��Ȱ���.
	declare @USERITEM_MODE_DIE_INIT				int					set @USERITEM_MODE_DIE_INIT					= -1-- �ʱ����.
	declare @USERITEM_MODE_DIE_PRESS			int					set @USERITEM_MODE_DIE_PRESS				= 1	-- ���� ����.
	declare @USERITEM_MODE_DIE_EAT_WOLF			int					set @USERITEM_MODE_DIE_EAT_WOLF				= 2	-- ���� ����.
	declare @USERITEM_MODE_DIE_EXPLOSE			int					set @USERITEM_MODE_DIE_EXPLOSE				= 3	-- ���� ����.
	declare @USERITEM_MODE_DIE_DISEASE			int					set @USERITEM_MODE_DIE_DISEASE				= 4	-- ���� ����.

	--��Ȱ.
	declare @USERITEM_MODE_REVIVAL_FIELD		int					set @USERITEM_MODE_REVIVAL_FIELD			= 1	-- �ʵ��Ȱ.
	declare @USERITEM_MODE_REVIVAL_HOSPITAL		int					set @USERITEM_MODE_REVIVAL_HOSPITAL			= 2	-- ������Ȱ.

	-- ��Ÿ �����
	declare @ID_MAX								int					set	@ID_MAX									= 9999	-- ������ ������ �� �ִ� ���̵𰳼�.

	-- �ü�(���׷��̵�).
	declare @USERMASTER_UPGRADE_STATE_NON		int					set @USERMASTER_UPGRADE_STATE_NON			= -1	--������, �Ϸ���.(����)
	declare @USERMASTER_UPGRADE_STATE_ING		int					set @USERMASTER_UPGRADE_STATE_ING			= 1		--�����ܰ�������.

	declare @USERMASTER_UPGRADE_KIND_NEXT		int					set @USERMASTER_UPGRADE_KIND_NEXT			= 1		-- ���׷��̵� ����.
	declare @USERMASTER_UPGRADE_KIND_RIGHTNOW	int					set @USERMASTER_UPGRADE_KIND_RIGHTNOW		= 2		-- ���׷��̵� ��ÿϷ�.

	-- ������(����).
	declare @USERSEED_NEED_EMPTY				int					set @USERSEED_NEED_EMPTY					= -1	-- (������)
	declare @USERSEED_NEED_BUY					int					set @USERSEED_NEED_BUY						= -2

	-- ����(����).
	declare @USERFARM_BUYSTATE_NOBUY			int					set @USERFARM_BUYSTATE_NOBUY				= -1	-- (����)
	declare @USERFARM_BUYSTATE_BUY				int					set @USERFARM_BUYSTATE_BUY					=  1

	-- ������(��Ȯ���).
	declare @USERSEED_HARVEST_MODE_NORMAL     	int					set @USERSEED_HARVEST_MODE_NORMAL			= 1
	declare @USERSEED_HARVEST_MODE_RIGHTNOW  	int					set @USERSEED_HARVEST_MODE_RIGHTNOW			= 2

	-- >= 0 �̻��̸� Ư�� �Ĺ��� �ɾ�������.
	declare @GAME_START_YEAR					int					set @GAME_START_YEAR						= 2013	-- ���� �⺻����.
	declare @GAME_START_MONTH					int					set @GAME_START_MONTH						= 3
	declare @GAME_INVEN_ANIMAL_BASE				int					set @GAME_INVEN_ANIMAL_BASE					= 10	-- ��ǥ1 + ����9
	declare @GAME_INVEN_CUSTOME_BASE			int					set @GAME_INVEN_CUSTOME_BASE				= 6
	declare @GAME_INVEN_ACC_BASE				int					set @GAME_INVEN_ACC_BASE					= 4
	declare @GAME_INVEN_HOSPITAL_BASE			int					set @GAME_INVEN_HOSPITAL_BASE				= 10+9 -- ��������(����10 + �ʵ�9).
	declare @GAME_COMPETITION_BASE				int					set @GAME_COMPETITION_BASE					= 90106	-- �����ȣ, -1�� ����.

	-- ��������.
	-- �ʵ嵿�� 0 ~ 8.
	declare @USERITEM_FIELDIDX_INVEN			int					set @USERITEM_FIELDIDX_INVEN					= -1	-- â��.
	declare @USERITEM_FIELDIDX_HOSPITAL			int					set @USERITEM_FIELDIDX_HOSPITAL					= -2	-- ����.
	declare @USERITEM_INIT_ANISTEP				int					set @USERITEM_INIT_ANISTEP						= 5		-- �ܰ�.
	declare @USERITEM_INIT_MANGER				int					set @USERITEM_INIT_MANGER						= 25	-- ������.
	declare @USERITEM_INIT_DISEASESTATE			int					set @USERITEM_INIT_DISEASESTATE					= 0		-- ��������.

	-- �Ҹ��� > �����Կ� ������ġ.
	declare @USERMASTER_QUICKKIND_NON			int					set @USERMASTER_QUICKKIND_NON				= -1 --����.
	declare @USERMASTER_QUICKKIND_SETTING		int					set @USERMASTER_QUICKKIND_SETTING			=  1 --�Ѿ�, ���, ����, �˹�(������ ���� ��������).

	-- ����̱� ���.
	declare @MODE_ROULETTE_NORMAL				int					set @MODE_ROULETTE_NORMAL					= 1	-- �Ϲݱ���.
	declare @MODE_ROULETTE_PREMINUM				int					set @MODE_ROULETTE_PREMINUM					= 2	-- �����̾�����.

	-- �ڵ��ȣ.
	declare @REVIVAL_ITEMCODE					int					set @REVIVAL_ITEMCODE						= 1200			-- ��Ȱ�� �ڵ��ȣ.
	declare @CHANGE_TRADE_ITEMCODE				int					set @CHANGE_TRADE_ITEMCODE					= 50000			-- ���κ���.

	-- ���忡 �۾���.
	--declare @BOARD_STATE_NON					int				set @BOARD_STATE_NON				= 0
	--declare @BOARD_STATE_REWARD				int				set @BOARD_STATE_REWARD				= 1
	declare @BOARD_STATE_REWARD_GAMECOST		int				set @BOARD_STATE_REWARD_GAMECOST	= 600

	-- ������ �� ���.
	declare @USERITEM_MODE_PET_TODAYBUY			int					set @USERITEM_MODE_PET_TODAYBUY				= 1		-- ���ø� �̰��� ��õ ����.
	declare @USERITEM_MODE_PET_ROLL				int					set @USERITEM_MODE_PET_ROLL					= 2		-- �̱�.
	declare @USERITEM_MODE_PET_UPGRADE			int					set @USERITEM_MODE_PET_UPGRADE				= 3		-- ����.
	declare @USERITEM_MODE_PET_WEAR				int					set @USERITEM_MODE_PET_WEAR					= 4		-- ����.


	------------------------------------------------
	--	2-3. ���λ�� ����
	------------------------------------------------
	declare @gameid			varchar(60)			set @gameid		= ''
	declare @comment		varchar(128)
	declare @cashcost 		int
	declare @gamecost 		int

Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR

	select
		@gameid = gameid
	from dbo.tFVUserMaster where gameid = @gameid_ and password = @password_

	------------------------------------------------
	--	3-3. ��������.
	------------------------------------------------
	if exists (select * from tFVUserMaster where gameid = @gameid_)
		begin
			set @nResult_ = @RESULT_ERROR_ID_DUPLICATE
			set @comment = ' DEBUG (����)���̵� �ߺ��Ǿ����ϴ�.'
		end
	else
		begin
			set @nResult_ = @RESULT_SUCCESS
			set @comment = ' DEBUG (����)������ �����մϴ�.'
		end

	/*
	------------------------------------------------------------------
	-- ����ġ��
	------------------------------------------------------------------
	set @buypointplus = CASE
							WHEN (@buypointmin <= 0) then 100
							WHEN (@buypointmin <= 5) then 80
							WHEN (@buypointmin <= 10) then 60
							WHEN (@buypointmin <= 20) then 40
							WHEN (@buypointmin <= 40) then 20
							WHEN (@buypointmin <= 60) then 10
							ELSE 0
						END

	------------------------------------------------------------------
	-- select -> insert(�о > �״�� �־��ֱ�)
	------------------------------------------------------------------
	insert into tMessage(gameid, comment)
		select @gameid_,  itemname + '�� ���Ⱑ �Ǿ����ϴ�.'
		from @tItemExpire a, tItemInfo b where a.itemcode = b.itemcode

	-----------------------------------------------
	-- ���� ���� �������� ���Ⱑ�Ǹ� ����ó���ϰ� �ý��� �޽����� ���⸦ ���.
	-- ������ ���� ��ä�κ��� > @�������̺� �Է� > �ϰ�����
	-- 2�� �̻������(���̺�� ���ͼ�)
	-----------------------------------------------
	--declare @gameid_ varchar(20) set @gameid_ = 'SangSang'
	DECLARE @tItemExpire TABLE(
		idx bigint,
		gameid varchar(60),
		itemcode int
	);
	--select * from dbo.tUserItem where gameid = @gameid_
	update dbo.tUserItem
		set
			expirestate = @ITEM_EXPIRE_STATE_YES
			OUTPUT DELETED.idx, @gameid_, DELETED.itemcode into @tItemExpire
	where gameid = @gameid_ and expirestate = @ITEM_EXPIRE_STATE_NO and getdate() > expiredate


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
	*/

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	select @nResult_ rtn, @comment comment, @gameid_ gameid

	set nocount off
End



