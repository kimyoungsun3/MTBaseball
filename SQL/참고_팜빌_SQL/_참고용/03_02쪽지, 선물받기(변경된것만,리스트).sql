---------------------------------------------------------------
/*
set @str = @gameid + '%'
select a.idx idx2, gameid, giftkind, message, gaindate, giftid, giftdate, b.*
from (select top 100 * from dbo.tFVGiftList where giftkind in (1, 2) and gameid = @gameid_ order by idx desc) a
	LEFT JOIN
	dbo.tFVItemInfo b
	ON a.itemcode = b.itemcode
order by idx2 desc

update dbo.tFVGiftList set giftkind = 2 where idx <= 17
update dbo.tFVGiftList set giftkind = 1 where idx = 2
select * from dbo.tFVUserMaster where gameid = 'xxxx'
exec spu_FVSubGiftSend 2,     1, 'SysLogin', 'xxxx2', ''				-- ���� ����
exec spu_FVSubGiftSend 2,     1, 'SysLogin', 'guest91886', ''			-- ���� ����

update dbo.tFVUserMaster set invenanimalmax = 10
delete from dbo.tFVUserItem where gameid = 'xxxx' and listidx = 10
update dbo.tFVGiftList set giftkind = 2 where idx = 1

exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', -1, 75, -1, -1, -1, -1	-- �����ޱ�(����)
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', -3, 60, -1, -1, -1, -1	-- ��	(�κ�)
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', -3, 61, -1,  6, -1, -1	-- ��	(�ʵ�6)
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', -3, 62, -1,  6, -1, -1	-- ��� (�ʵ�6 �浹)
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', -3, 69, -1, -1, -1, -1	-- �Ǽ�
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', -3, 63, -1, -1, -1, -1	-- �Ѿ�(��ȣ����ġ)
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', -3, 63,  7, -1, -1, -1	-- �Ѿ�(��ȣ��ġ)
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', -3,216, 25, -1,  1, -1	-- �Ѿ�(���Ѿ�  > ���ú���)
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', -3, 64,  8, -1,  1, -1	-- ġ����
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', -3,217, 26, -1,  1, -1	-- ġ����(���� > ���ú���)
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', -3, 66,  9, -1,  1, -1	-- �ϲ�
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', -3,218, 27, -1,  1, -1	-- �ϲ�(���� > ���ú���)
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', -3, 67, 10, -1,  1, -1	-- ������
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', -3,219, 28, -1,  1, -1	-- ������(���� > ���ú���)
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', -3, 68, 29, -1, -1, -1	-- ��Ȱ��
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', -3, 73, 30, -1, -1, -1	-- �Ϲݱ���Ƽ��
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', -3, 74, 31, -1, -1, -1	-- ��ȸƼ��B
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', -3, 76, 32, -1, -1, -1	-- ����100���θ���
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', -3, 77, 33, -1, -1, -1	-- ��޿�ûƼ��
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', -3, 65, -1, -1,  1, -1	-- ����
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', -3, 301941151, -1, -1, -1, -1	-- ��������Ʈ
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', -3, 301941152, -1, -1, -1, -1	--
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', -3, 70, -1, -1, -1, -1	-- ��Ʈ
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', -3, 71, -1, -1, -1, -1	-- ĳ��
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', -3, 72, -1, -1, -1, -1	-- ����
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', -3, 984, -1, -1, -1, -1	-- �Ϲݱ���̱�
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', -3, 985, 14, -1, -1, -1	-- �Ϲݱ���̱�
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', -3, 986, -1, -1, -1, -1	-- �����̾�����̱�
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', -3, 987, 15, -1, -1, -1	-- �����̾�����̱�

exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', -3, 3416696, -1, -1, -1, -1	-- �꼱��(6).
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', -3, 3416697, -1, -1, -1, -1	-- �꼱��(1).

exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', -5, -1, -1, -1, -1, -1		-- ����Ʈ����
*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVGiftGain', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVGiftGain;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_FVGiftGain
	@gameid_				varchar(20),						-- ���Ӿ��̵�
	@password_				varchar(20),						-- ��ȣȭ�ؼ�����, �����н����� ��ŷ���ص� ����
	@giftkind_				int,								--  1:�޽���
																--  2:����
																-- -1:�޽�������
																-- -2:��������
																-- -3:�����޾ư�
	@idx_					bigint,								-- �����ε���
	@listidx_				int,								--
	@fieldidx_				int,								--
	@quickkind_				int,								--
	@nResult_				int					OUTPUT
	--WITH ENCRYPTION
as
	------------------------------------------------
	--	2-1. �ڵ尪
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
	declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ����.

	-- ������ ����, ����.
	declare @RESULT_ERROR_BUY_ALREADY			int				set @RESULT_ERROR_BUY_ALREADY			= -31			--�̹� �����߽��ϴ�.
	declare @RESULT_ERROR_NOT_HAVE				int				set @RESULT_ERROR_NOT_HAVE				= -32			--�������� �ʰ� �ִ�.
	declare @RESULT_ERROR_UPGRADE_FULL			int				set @RESULT_ERROR_UPGRADE_FULL			= -35			--���׷��̵尡 Ǯ�εǾ���.
	declare @RESULT_ERROR_ITEM_NOSALE_KIND		int				set @RESULT_ERROR_ITEM_NOSALE_KIND		= -37			--�Ǹ����� �ʴ� ������

	-- ���� �ڵ尪
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- �������ڵ��ã��
	declare @RESULT_ERROR_GIFTITEM_NOT_FOUND	int				set @RESULT_ERROR_GIFTITEM_NOT_FOUND	= -51			-- ������������ ��ã��
	declare @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	int				set @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	= -52			-- ������ �̹� ������
	declare @RESULT_ERROR_NOT_FOUND_GIFTID		int				set @RESULT_ERROR_NOT_FOUND_GIFTID		= -75			-- ĳ�� > ������ ���̵� ��ã��

	-- ��Ÿ����
	declare @RESULT_ERROR_RESULT_COPY			int				set @RESULT_ERROR_RESULT_COPY			= -53			-- ���ī�ǽõ�
	declare @RESULT_ERROR_GAMECOST_COPY			int				set @RESULT_ERROR_GAMECOST_COPY			= -54			-- �ǹ�ī�ǽõ�
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- ���������ʴ¸��
	declare @RESULT_ERROR_HEART_FULL			int				set @RESULT_ERROR_HEART_FULL			= -71			-- ���������ʴ¸��
	declare @RESULT_ERROR_TUTORIAL_ALREADY		int				set @RESULT_ERROR_TUTORIAL_ALREADY		= -73			-- ���丮�� �̹� ����.
	declare @RESULT_ERROR_NOT_FOUND_OTHERID		int				set @RESULT_ERROR_NOT_FOUND_OTHERID		= -83
	declare @RESULT_ERROR_INVEN_FULL			int				set @RESULT_ERROR_INVEN_FULL			= -101			-- �κ�����
	declare @RESULT_ERROR_NOT_MATCH				int				set @RESULT_ERROR_NOT_MATCH				= -110			-- �����ΰ� ��ġ�� �ȵǾ���.

	------------------------------------------------
	--	2-2. ���ǵȰ�
	------------------------------------------------
	-- �����ۺ� �κ��з�
	declare @USERITEM_INVENKIND_ANI				int 				set @USERITEM_INVENKIND_ANI					= 1
	declare @USERITEM_INVENKIND_CONSUME			int 				set @USERITEM_INVENKIND_CONSUME				= 3
	declare @USERITEM_INVENKIND_ACC				int 				set @USERITEM_INVENKIND_ACC					= 4
	declare @USERITEM_INVENKIND_DIRECT			int 				set @USERITEM_INVENKIND_DIRECT				= 40
	declare @USERITEM_INVENKIND_INFO			int 				set @USERITEM_INVENKIND_INFO				= 60
	declare @USERITEM_INVENKIND_PET				int 				set @USERITEM_INVENKIND_PET					= 1000

	-- ������ ��з�
	declare @ITEM_MAINCATEGORY_ANI				int					set @ITEM_MAINCATEGORY_ANI 					= 1 	-- ����(1)
	declare @ITEM_MAINCATEGORY_CONSUME			int					set @ITEM_MAINCATEGORY_CONSUME 				= 3 	--�Ҹ�ǰ(3)
	declare @ITEM_MAINCATEGORY_ACC				int					set @ITEM_MAINCATEGORY_ACC 					= 4 	--�׼�����(4)
	declare @ITEM_MAINCATEGORY_HEART			int					set @ITEM_MAINCATEGORY_HEART 				= 40 	--��Ʈ(40)
	declare @ITEM_MAINCATEGORY_CASHCOST			int					set @ITEM_MAINCATEGORY_CASHCOST 			= 50 	--ĳ������(50)
	declare @ITEM_MAINCATEGORY_GAMECOST			int					set @ITEM_MAINCATEGORY_GAMECOST 			= 51 	--���μ���(51)
	declare @ITEM_MAINCATEGORY_ROULETTE			int					set @ITEM_MAINCATEGORY_ROULETTE 			= 52 	--�̱�(52)
	declare @ITEM_MAINCATEGORY_CONTEST			int					set @ITEM_MAINCATEGORY_CONTEST 				= 53 	--��ȸ(53)
	declare @ITEM_MAINCATEGORY_UPGRADE			int					set @ITEM_MAINCATEGORY_UPGRADE 				= 60 	--����(60)
	declare @ITEM_MAINCATEGORY_INVEN			int					set @ITEM_MAINCATEGORY_INVEN 				= 67 	--�κ�Ȯ��(67)
	declare @ITEM_MAINCATEGORY_SEEDFIEL			int					set @ITEM_MAINCATEGORY_SEEDFIEL 			= 68 	--������Ȯ��(68)
	declare @ITEM_MAINCATEGORY_DOGAM			int					set @ITEM_MAINCATEGORY_DOGAM 				= 818 	--����(818)
	declare @ITEM_MAINCATEGORY_GAMEINFO			int					set @ITEM_MAINCATEGORY_GAMEINFO 			= 500 	--��������(500)

	-- ������ ������
	declare @ITEM_SUBCATEGORY_COW				int					set @ITEM_SUBCATEGORY_COW 					= 1  -- ��		(�Ǹ�[O], ����[O])			0
	declare @ITEM_SUBCATEGORY_GOAT				int					set @ITEM_SUBCATEGORY_GOAT 					= 2  -- ��		(�Ǹ�[O], ����[O])			0
	declare @ITEM_SUBCATEGORY_SHEEP				int					set @ITEM_SUBCATEGORY_SHEEP 				= 3  -- ���	(�Ǹ�[O], ����[O])			0
	declare @ITEM_SUBCATEGORY_SEED				int					set @ITEM_SUBCATEGORY_SEED 					= 7  -- ����	(�Ǹ�[X], ����[X], ����[O])	0
	declare @ITEM_SUBCATEGORY_BULLET			int					set @ITEM_SUBCATEGORY_BULLET 				= 8  -- �Ѿ�	(�Ǹ�[O], ����[O])			0
	declare @ITEM_SUBCATEGORY_VACCINE			int					set @ITEM_SUBCATEGORY_VACCINE 				= 9  -- ġ����	(�Ǹ�[O], ����[O])			0
	declare @ITEM_SUBCATEGORY_FEED				int					set @ITEM_SUBCATEGORY_FEED 					= 44 -- ����	(�Ǹ�[X], ����[O])
	declare @ITEM_SUBCATEGORY_ALBA				int					set @ITEM_SUBCATEGORY_ALBA 					= 11 -- �ϲ�	(�Ǹ�[O], ����[O])			0
	declare @ITEM_SUBCATEGORY_BOOSTER			int					set @ITEM_SUBCATEGORY_BOOSTER 				= 12 -- ������	(�Ǹ�[O], ����[O])			0
	declare @ITEM_SUBCATEGORY_REVIVAL			int					set @ITEM_SUBCATEGORY_REVIVAL 				= 13 -- ��Ȱ��	(�Ǹ�[O], ����[O])			0
	declare @ITEM_SUBCATEGORY_COMPOSE_TIME		int					set @ITEM_SUBCATEGORY_COMPOSE_TIME 			= 16 -- �ռ�1�ð� �ʱ�ȭ(�Ǹ�[X], ����[O])
	declare @ITEM_SUBCATEGORY_ACC				int					set @ITEM_SUBCATEGORY_ACC 					= 15 -- �Ǽ�	(�Ǹ�[O], ����[O])			0
	declare @ITEM_SUBCATEGORY_FPOINT			int					set @ITEM_SUBCATEGORY_FPOINT 				= 19 -- ��������Ʈ(�Ǹ�[X], ����[O])
	declare @ITEM_SUBCATEGORY_HEART				int					set @ITEM_SUBCATEGORY_HEART 				= 40 -- ��Ʈ	(�Ǹ�[O], ����[O])
	declare @ITEM_SUBCATEGORY_HELPER			int					set @ITEM_SUBCATEGORY_HELPER 				= 41 -- ��޿�û(�Ǹ�[X], ����[O])			0
	declare @ITEM_SUBCATEGORY_TRADESAFE			int					set @ITEM_SUBCATEGORY_TRADESAFE				= 42 -- ���θ���(�Ǹ�[X], ����[O])			0
	declare @ITEM_SUBCATEGORY_CASHCOST			int					set @ITEM_SUBCATEGORY_CASHCOST 				= 50 -- ĳ��	(�Ǹ�[O], ����[O])
	declare @ITEM_SUBCATEGORY_GAMECOST			int					set @ITEM_SUBCATEGORY_GAMECOST 				= 51 -- ����	(�Ǹ�[O], ����[O])
	declare @ITEM_SUBCATEGORY_ROULETTE_NOR		int					set @ITEM_SUBCATEGORY_ROULETTE_NOR			= 22 -- �Ϲݱ���̱�Ƽ��(�Ǹ�[X], ����[O])
	declare @ITEM_SUBCATEGORY_ROULETTE_PRE		int					set @ITEM_SUBCATEGORY_ROULETTE_PRE			= 23 -- �����̾�����̱�Ƽ��(�Ǹ�[X], ����[O])
	declare @ITEM_SUBCATEGORY_CONTEST			int					set @ITEM_SUBCATEGORY_CONTEST 				= 53 -- ��ȸ	(�Ǹ�[O], ����[O])			0
	declare @ITEM_SUBCATEGORY_UPGRADE_HOUSE		int					set @ITEM_SUBCATEGORY_UPGRADE_HOUSE 		= 60 -- ��
	declare @ITEM_SUBCATEGORY_UPGRADE_TANK		int					set @ITEM_SUBCATEGORY_UPGRADE_TANK 			= 61 -- ��ũ
	declare @ITEM_SUBCATEGORY_UPGRADE_FRESHCOOL	int					set @ITEM_SUBCATEGORY_UPGRADE_FRESHCOOL 	= 62 -- ���º���
	declare @ITEM_SUBCATEGORY_UPGRADE_PURE		int					set @ITEM_SUBCATEGORY_UPGRADE_PURE 			= 63 -- ��ȭ�ü�
	declare @ITEM_SUBCATEGORY_UPGRADE_BOTTLE	int					set @ITEM_SUBCATEGORY_UPGRADE_BOTTLE 		= 64 -- �絿��
	declare @ITEM_SUBCATEGORY_UPGRADE_PUMP		int					set @ITEM_SUBCATEGORY_UPGRADE_PUMP 			= 65 -- ������
	declare @ITEM_SUBCATEGORY_UPGRADE_TRANSFER	int					set @ITEM_SUBCATEGORY_UPGRADE_TRANSFER 		= 66 -- ���Ա�
	declare @ITEM_SUBCATEGORY_INVEN				int					set @ITEM_SUBCATEGORY_INVEN 				= 67 -- �κ�Ȯ��
	declare @ITEM_SUBCATEGORY_SEEDFIELD			int					set @ITEM_SUBCATEGORY_SEEDFIELD 			= 68 -- ������Ȯ��
	declare @ITEM_SUBCATEGORY_DOGAM				int					set @ITEM_SUBCATEGORY_DOGAM 				= 818 -- ����
	declare @ITEM_SUBCATEGORY_SYSINFO			int					set @ITEM_SUBCATEGORY_SYSINFO 				= 500 -- ��������
	declare @ITEM_SUBCATEGORY_ATTENDANCE		int					set @ITEM_SUBCATEGORY_ATTENDANCE 			= 900 	--�⼮(900)
	declare @ITEM_SUBCATEGORY_COMPETITION		int					set @ITEM_SUBCATEGORY_COMPETITION 			= 901 	--������(901)
	declare @ITEM_SUBCATEGORY_PET				int					set @ITEM_SUBCATEGORY_PET					= 1000 	--��(1000)

	-- ���� ���ǰ�
	declare @GIFTLIST_GIFT_KIND_MESSAGE			int					set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2
	declare @GIFTLIST_GIFT_KIND_MESSAGE_DEL		int					set @GIFTLIST_GIFT_KIND_MESSAGE_DEL			= -1
	declare @GIFTLIST_GIFT_KIND_GIFT_DEL		int					set @GIFTLIST_GIFT_KIND_GIFT_DEL			= -2
	declare @GIFTLIST_GIFT_KIND_GIFT_GET		int					set @GIFTLIST_GIFT_KIND_GIFT_GET			= -3
	declare @GIFTLIST_GIFT_KIND_GIFT_SELL		int					set @GIFTLIST_GIFT_KIND_GIFT_SELL			= -4
	declare @GIFTLIST_GIFT_KIND_LIST			int					set @GIFTLIST_GIFT_KIND_LIST				= -5

	-- ������ ȹ����
	declare @DEFINE_HOW_GET_FIRST				int					set @DEFINE_HOW_GET_FIRST					= 0	--�⺻
	declare @DEFINE_HOW_GET_BUY					int					set @DEFINE_HOW_GET_BUY						= 1	--����
	declare @DEFINE_HOW_GET_SEEDFIELD			int					set @DEFINE_HOW_GET_SEEDFIELD				= 2	--����
	declare @DEFINE_HOW_GET_ROULETTE			int					set @DEFINE_HOW_GET_ROULETTE				= 3	--����/�̱�
	declare @DEFINE_HOW_GET_SEARCH				int					set @DEFINE_HOW_GET_SEARCH					= 4	--�˻�
	declare @DEFINE_HOW_GET_GIFT				int					set @DEFINE_HOW_GET_GIFT					= 5	--�˻�

	-- ��������.
	-- �ʵ嵿�� 0 ~ 8.
	declare @USERITEM_FIELDIDX_INVEN			int					set @USERITEM_FIELDIDX_INVEN					= -1	-- â��.
	declare @USERITEM_FIELDIDX_HOSPITAL			int					set @USERITEM_FIELDIDX_HOSPITAL					= -2	-- ����.

	-- �Ҹ��� > �����Կ� ������ġ.
	declare @USERMASTER_QUICKKIND_NON			int					set @USERMASTER_QUICKKIND_NON				= -1 --����.
	declare @USERMASTER_QUICKKIND_SETTING		int					set @USERMASTER_QUICKKIND_SETTING			=  1 --�Ѿ�, ���, ����, �˹�.


	declare @URGENCY_ITEMCODE					int					set @URGENCY_ITEMCODE				= 2100

	-- ���Ÿ ����
	declare @USERITEM_PET_UPGRADE_MAX			int					set @USERITEM_PET_UPGRADE_MAX				= 6		-- ���׷��̵� �ƽ�.

	------------------------------------------------
	--	2-3. ���λ�� ����
	------------------------------------------------
	declare @gameid			varchar(60)
	declare @itemcode		int
	declare @giftkind		int				set @giftkind 	= -1
	declare @cashcost		int				set @cashcost 	= 0
	declare @gamecost		int				set @gamecost 	= 0
	declare @heart			int				set @heart 		= 0
	declare @feed			int				set @feed 		= 0
	declare @fpoint			int				set @fpoint		= 0
	declare @invenanimalmax	int
	declare @invencustommax int
	declare @invenaccmax	int

	declare @subcategory 	int,
			@buyamount		int,
			@invenkind		int

	declare @comment		varchar(80)
	declare @param1			varchar(40)
	declare @plus	 		int 			set @plus			= 0
	declare @plus2	 		int 			set @plus2			= 0
	declare @cashcostplus	int				set @cashcostplus	= 0

	declare @cnt 			int
	declare @listidxnew 	int				set @listidxnew		= -1
	declare @listidxcust 	int				set @listidxcust	= -1
	declare @listidxpet 	int				set @listidxpet		= -1
	declare @petupgradeinit	int				set @petupgradeinit	=  1
	declare @listidxrtn 	int				set @listidxrtn		= -1
	declare @fieldidx 		int

	declare @dummy	 		int
	declare @sellcost		int				set @sellcost		= 0

	-- �ʵ����.
	declare @field0				int			set @field0			= -1
	declare @field1				int			set @field1			= -1
	declare @field2				int			set @field2			= -1
	declare @field3				int			set @field3			= -1
	declare @field4				int			set @field4			= -1
	declare @field5				int			set @field5			= -1
	declare @field6				int			set @field6			= -1
	declare @field7				int			set @field7			= -1
	declare @field8				int			set @field8			= -1
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	set @comment  = '�˼� ���� ������ �߻��߽��ϴ�.'
	--select 'DEBUG 3-1-1 �Է°�', @gameid_ gameid_, @password_ password_, @giftkind_ giftkind_, @idx_ idx_, @listidx_ listidx_, @fieldidx_ fieldidx_, @quickkind_ quickkind_

	if(@fieldidx_ < -1 or @fieldidx_ >= 9)
		begin
			--select 'DEBUG 3-1-2 �κ���ȣ�� �߸��Ǿ �κ����� ����.'
			set @fieldidx_ = @USERITEM_FIELDIDX_INVEN
		end

	------------------------------------------------
	--	3-2. �������(��������, ��������, ������ ����)
	------------------------------------------------
	select
		@gameid 		= gameid,
		@cashcost		= cashcost,
		@gamecost		= gamecost,
		@heart			= heart,
		@feed			= feed,
		@fpoint			= fpoint,
		@invenanimalmax	= invenanimalmax,
		@invencustommax = invencustommax,
		@invenaccmax 	= invenaccmax,

		@field0			= field0,			@field1			= field1,			@field2			= field2,
		@field3			= field3,			@field4			= field4,			@field5			= field5,
		@field6			= field6,			@field7			= field7,			@field8			= field8
	from dbo.tFVUserMaster where gameid = @gameid_ and password = @password_
	--select 'DEBUG 3-2-1 ��������', @gameid gameid, @cashcost cashcost, @gamecost gamecost, @heart heart, @feed feed, @fpoint fpoint, @invenanimalmax invenanimalmax, @invencustommax invencustommax, @invenaccmax invenaccmax

	select
		@giftkind = giftkind,
		@itemcode = itemcode
	from dbo.tFVGiftList where gameid = @gameid_ and idx = @idx_
	--select 'DEBUG 3-2-2 ����/����', @giftkind giftkind, @itemcode itemcode

	------------------------------------------------
	--	3-3. ����Ȳ���� �ڵ�� �з�
	------------------------------------------------
	if(isnull(@gameid, '') = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR ���̵� �������� �ʴ´�.'
			--select 'DEBUG ' + @comment
		END
	else if(@giftkind_ = @GIFTLIST_GIFT_KIND_LIST)
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS ���� ����Ʈ ����.'

			set @listidxrtn = -1
			--select 'DEBUG ' + @comment
		END
	else if isnull(@giftkind, -1) = -1
		BEGIN
			set @nResult_ = @RESULT_ERROR_GIFTITEM_NOT_FOUND
			set @comment = 'ERROR ����, ���� ������ü�� ����'
			--select 'DEBUG ' + @comment
		END
	else if (@giftkind in (@GIFTLIST_GIFT_KIND_MESSAGE_DEL, @GIFTLIST_GIFT_KIND_GIFT_DEL, @GIFTLIST_GIFT_KIND_GIFT_GET, @GIFTLIST_GIFT_KIND_GIFT_SELL, @GIFTLIST_GIFT_KIND_LIST))
		BEGIN
			set @nResult_ = @RESULT_ERROR_GIFTITEM_ALREADY_GAIN
			set @comment = 'ERROR ���� �� �����Ǿ����ϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if (@giftkind_ not in (@GIFTLIST_GIFT_KIND_MESSAGE_DEL, @GIFTLIST_GIFT_KIND_GIFT_DEL, @GIFTLIST_GIFT_KIND_GIFT_GET, @GIFTLIST_GIFT_KIND_GIFT_SELL, @GIFTLIST_GIFT_KIND_LIST))
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment = 'ERROR �������� �ʴ� ��尪�Դϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if(@giftkind_ = @GIFTLIST_GIFT_KIND_MESSAGE_DEL)
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS �޼��� ���� ó���մϴ�.'
			--select 'DEBUG ' + @comment

			update dbo.tFVGiftList
				set
					giftkind = @giftkind_
			where idx = @idx_
		END
	else if(@giftkind_ = @GIFTLIST_GIFT_KIND_GIFT_DEL)
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS ���� ���� ó���մϴ�.'
			--select 'DEBUG ' + @comment

			update dbo.tFVGiftList
				set
					giftkind = @giftkind_
			where idx = @idx_
		END
	else if(@giftkind_ = @GIFTLIST_GIFT_KIND_GIFT_SELL)
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS �������� ������ �Ⱦƶ�.'
			--select 'DEBUG ' + @comment

			update dbo.tFVGiftList
				set
					giftkind = @giftkind_
			where idx = @idx_

			------------------------------------------
			-- �������� �Ǹ��ϴ� ����.
			------------------------------------------
			select
				@buyamount 	= buyamount,
				@sellcost 	= sellcost
			from dbo.tFVItemInfo where itemcode = @itemcode

			set @gamecost = @gamecost + @sellcost * @buyamount

			update dbo.tFVUserMaster
			set
				gamecost = @gamecost
			where gameid = @gameid_

		END
	else if(@giftkind_ = @GIFTLIST_GIFT_KIND_GIFT_GET)
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS ���� ���� ó���մϴ�.'

			select
				@subcategory 	= subcategory,
				@buyamount 		= buyamount,
				@param1			= param1
			from dbo.tFVItemInfo where itemcode = @itemcode
			set @invenkind = dbo.fnu_GetFVInvenFromSubCategory(@subcategory)
			--select 'DEBUG 4-1 �����ۿ� ����', @subcategory subcategory, @buyamount buyamount, @param1 param1, @invenkind invenkind

			select @listidxnew = isnull(MAX(listidx), 0) + 1 from dbo.tFVUserItem where gameid = @gameid_
			--select 'DEBUG 4-1-2 �κ� ����ȣ', @listidxnew listidxnew

			if(@invenkind = @USERITEM_INVENKIND_ANI)
				begin
					--------------------------------------------------------------
					-- ���� ������ > �κ������ľ�
					--------------------------------------------------------------
					select @cnt = count(*)
					from dbo.tFVUserItem
					where gameid = @gameid_
						  and invenkind = @invenkind
						  and fieldidx != @USERITEM_FIELDIDX_HOSPITAL
					--select 'DEBUG 4-2 ����(1)�κ��ֱ�', @cnt cnt, @invenanimalmax invenanimalmax

					--------------------------------------------------------------
					-- ��,��,���			-> ���� ������
					--------------------------------------------------------------
					if(@cnt >= @invenanimalmax)
						begin
							set @nResult_ = @RESULT_ERROR_INVEN_FULL
							set @comment = 'ERROR ���� �κ��� Ǯ�Դϴ�.'
							--select 'DEBUG ' + @comment, @cnt cnt, @invenanimalmax invenanimalmax
						end
					else
						begin
							--select 'DEBUG 4-2-2 ���� > �κ� or �ʵ�, �̺� ���� ���·� ����', @gameid_ gameid_, @listidxnew listidxnew, @itemcode itemcode, @idx_ idx_
							if(@fieldidx_ = -1)
								begin
									set @fieldidx = @fieldidx_
									--select 'DEBUG 4-2-3 ���� > �ʵ�Ǯ�̶� �κ��� �־�ζ�.', @fieldidx fieldidx
								end
							else if(exists(select top 1 * from dbo.tFVUserItem where gameid = @gameid_ and fieldidx = @fieldidx_))
								begin
									---------------------------------------------------
									-- ���ڸ� ã�� Ŀ��
									-- 0   2 3 4 5 		 >  1
									-- 0 1 2 3 4 5 		 >  6
									-- 0 1 2 3 4 5 6 7 8 > -1
									---------------------------------------------------
									set @fieldidx = dbo.fun_getFVUserItemFieldIdxAni(@gameid_)
									--select 'DEBUG 4-2-3 ���� > ����(�浹)', @fieldidx fieldidx
								end
							else
								begin
									set @fieldidx = @fieldidx_
									--select 'DEBUG 4-2-3 ���� > �ʵ尡 ��ȿ�ؼ� �״�� �־��.', @fieldidx fieldidx
								end

							-- �ʵ尡 ����ϴ� �����ΰ�?
							set @fieldidx = dbo.fun_getFVUserItemFieldCheck(@fieldidx,
																		  @field0, @field1, @field2,
																		  @field3, @field4, @field5,
																		  @field6, @field7, @field8)

							-- �ش������ �κ��� ����
							insert into dbo.tFVUserItem(gameid,      listidx,  itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow)		-- ����.
							values(					 @gameid_, @listidxnew, @itemcode,   1,       0, @fieldidx, @invenkind, @DEFINE_HOW_GET_GIFT)

							-- �������
							exec spu_FVDogamListLog @gameid_, @itemcode

							-- ������ ������ ���·� �����д�.
							update dbo.tFVGiftList set giftkind = @GIFTLIST_GIFT_KIND_GIFT_GET, gaindate = getdate() where idx = @idx_

							-- ����� ������ ����Ʈ�ε���
							set @listidxrtn	= @listidxnew
						end
				end
			else if(@invenkind = @USERITEM_INVENKIND_CONSUME)
				begin
					--------------------------------------------------------------
					-- ���� ������ > �κ������ľ�
					--------------------------------------------------------------
					select @cnt = count(*)
					from dbo.tFVUserItem
					where gameid = @gameid_
						  and invenkind = @invenkind
						  and cnt > 0

					----------------------------------------------------------------
					---- �Ѿ�					-> �Ҹ� ������0
					---- ���					-> �Ҹ� ������0
					---- ������				-> �Ҹ� ������0
					---- �˹�					-> �Ҹ� ������0
					---- ��Ȱ��				-> �Ҹ� ������ (�����ڵ� > 1���� ���ϵ�)
					---- ��ȸ�� Ƽ��			-> �Ҹ� ������
					---- ���� Ƽ��			-> �Ҹ� ������
					---- ��޿�û Ƽ��		-> �Ҹ� ������ (�����ڵ� > 1���� ���ϵ�)
					---- ���� 100% ���� Ƽ��	-> �Ҹ� ������
					----------------------------------------------------------------
					set @itemcode = dbo.fnu_GetFVItemcodeFromConsumePackage(@subcategory, @itemcode)


					select
						@listidxcust = listidx
					from dbo.tFVUserItem
					where gameid = @gameid_ and itemcode = @itemcode
					--select 'DEBUG 4-3 �Һ�(n)�κ��ֱ�', @gameid_ gameid_, @subcategory subcategory, @itemcode itemcode, @listidxcust listidxcust, @cnt cnt, @invencustommax invencustommax

					-------------------------------------------------
					-- ��ũ ��ȣ ������ ���� ����ڵ�.
					-------------------------------------------------
					if(@listidx_ =  -1 and @listidxcust != -1)
						begin
							-- ��ũ ��ȣ�� ���ٰ� �ϴµ� ��ũ ��ȣ�� �ֳ׿�. > �缼��.
							set @listidx_ = @listidxcust
						end

					if(@listidxcust = -1 and (@cnt >= (@invencustommax + 4)))
						begin
							set @nResult_ = @RESULT_ERROR_INVEN_FULL
							set @comment = 'ERROR �Һ� �κ��� Ǯ�Դϴ�.'
							--select 'DEBUG ' + @comment
						end
					else if(@listidx_ !=  @listidxcust)
						begin
							-- and @subcategory in (@ITEM_SUBCATEGORY_BULLET, @ITEM_SUBCATEGORY_VACCINE, @ITEM_SUBCATEGORY_ALBA, @ITEM_SUBCATEGORY_BOOSTER)
							set @nResult_ = @RESULT_ERROR_NOT_MATCH
							set @comment = 'ERROR �Ҹ����� ��������Ʈ('+ltrim(rtrim(str(@listidx_)))+') ���������ȣ('+ltrim(rtrim(str(@listidxcust)))+')�� ����ġ.'
							--select 'DEBUG ' + @comment
						end
					else
						begin
							--select 'DEBUG 4-3-2 ���� > �κ����� �̵�, �̺� ���� ���·� ����'
							---------------------------------------------------
							-- ���ڸ� ã�� Ŀ��
							-- 0 [1] 2 3 4 5 	> [1] > update
							-- 0 1 2 3 4 5 6  	> ���� > insert
							-- @listidxcust = @listidx_ (������)
							---------------------------------------------------
							if(@listidxcust = -1)
								begin
									--select 'DEBUG �Һ� �߰�', @gameid_ gameid_, @listidxnew listidxnew, @itemcode itemcode, @buyamount buyamount

									insert into dbo.tFVUserItem(gameid,      listidx,  itemcode,        cnt,  invenkind, gethow)
									values(					@gameid_,  @listidxnew, @itemcode, @buyamount, @invenkind, @DEFINE_HOW_GET_GIFT)

									-- ����� ������ ����Ʈ�ε���
									set @listidxrtn	= @listidxnew
								end
							else
								begin
									--select 'DEBUG �Һ� �����ۿ� ����', @gameid_ gameid_, @listidxcust listidxcust, @buyamount buyamount

									update dbo.tFVUserItem
										set
											cnt = cnt + @buyamount
									where gameid = @gameid_ and listidx = @listidxcust

									-- ����� ������ ����Ʈ�ε���
									set @listidxrtn	= @listidxcust
								end

							if(@quickkind_ = @USERMASTER_QUICKKIND_SETTING)
								begin
									--select 'DEBUG > ������ �߰��Ѵ�.'
									update dbo.tFVUserMaster
										set
											bulletlistidx 	= case when (@subcategory = @ITEM_SUBCATEGORY_BULLET) 	then @listidxrtn else bulletlistidx end,
											vaccinelistidx	= case when (@subcategory = @ITEM_SUBCATEGORY_VACCINE) 	then @listidxrtn else vaccinelistidx end,
											boosterlistidx	= case when (@subcategory = @ITEM_SUBCATEGORY_BOOSTER)	then @listidxrtn else boosterlistidx end,
											albalistidx		= case when (@subcategory = @ITEM_SUBCATEGORY_ALBA) 	then @listidxrtn else albalistidx end
									where gameid = @gameid_
								end

							-- ������ ������ ���·� �����д�.
							--select 'DEBUG > ', @idx_ idx_
							update dbo.tFVGiftList set giftkind = @GIFTLIST_GIFT_KIND_GIFT_GET, gaindate = getdate() where idx = @idx_
						end
				end
			else if(@invenkind = @USERITEM_INVENKIND_ACC)
				begin
					--------------------------------------------------------------
					-- �Ǽ�					-> �����ľ�
					--------------------------------------------------------------
					select @cnt = count(*)
					from dbo.tFVUserItem
					where gameid = @gameid_
						  and invenkind = @invenkind

					--------------------------------------------------------------
					-- �Ǽ�					-> �Ǽ� ������
					--------------------------------------------------------------
					--select 'DEBUG 4-4 �Ǽ�(1)�κ��ֱ�', @cnt cnt, @invenaccmax invenaccmax
					if(@cnt >= @invenaccmax)
						begin
							set @nResult_ = @RESULT_ERROR_INVEN_FULL
							set @comment = 'ERROR �Ǽ� �κ��� Ǯ�Դϴ�.'
							--select 'DEBUG ' + @comment, @invenaccmax invenaccmax
						end
					else
						begin
							--select 'DEBUG 4-4-2 ���� > �κ����� �̵�, �̺� ���� ���·� ����', @gameid_ gameid_, @listidxnew listidxnew, @itemcode itemcode

							insert into dbo.tFVUserItem(gameid,      listidx,  itemcode, invenkind,  gethow)		-- �Ǽ�
							values(					 @gameid_, @listidxnew, @itemcode, @invenkind, @DEFINE_HOW_GET_GIFT)

							-- ������ ������ ���·� �����д�.
							update dbo.tFVGiftList set giftkind = @GIFTLIST_GIFT_KIND_GIFT_GET, gaindate = getdate() where idx = @idx_

							-- ����� ������ ����Ʈ�ε���
							set @listidxrtn	= @listidxnew
						end
				end
			else if(@invenkind = @USERITEM_INVENKIND_PET)
				begin
					--------------------------------------------------------------
					-- ��					-> �� ������
					--------------------------------------------------------------
					--select 'DEBUG 4-4-2 ���� > ���κ����� �̵�, �̺� ���� ���·� ����', @gameid_ gameid_, @listidxnew listidxnew, @itemcode itemcode

					select
						@listidxpet = listidx
					from dbo.tFVUserItem
					where gameid = @gameid_ and itemcode = @itemcode
					--select 'DEBUG >', @listidxpet listidxpet, @listidx_ listidx_

					-------------------------------------------------
					-- ��ũ ��ȣ ������ ���� ����ڵ�.
					-------------------------------------------------
					if(@listidx_ =  -1 and @listidxpet != -1)
						begin
							-- ��ũ ��ȣ�� ���ٰ� �ϴµ� ��ũ ��ȣ�� �ֳ׿�. > �缼��.
							set @listidx_ = @listidxpet
						end

					if(@listidx_ !=  @listidxpet)
						begin
							set @nResult_ = @RESULT_ERROR_NOT_MATCH
							set @comment = 'ERROR �� ��������Ʈ('+ltrim(rtrim(str(@listidx_)))+') ���������ȣ('+ltrim(rtrim(str(@listidxpet)))+')�� ����ġ.'
							--select 'DEBUG ' + @comment
						end
					else
						begin
							select
								@petupgradeinit		= param5
							from dbo.tFVItemInfo where itemcode = @itemcode and subcategory = @ITEM_SUBCATEGORY_PET
							--select 'DEBUG >', @petupgradeinit petupgradeinit

							if(@listidxpet = -1)
								begin
									--select 'DEBUG �� �߰�', @gameid_ gameid_, @listidxnew listidxnew, @itemcode itemcode, @buyamount buyamount
									insert into dbo.tFVUserItem(gameid,      listidx,  itemcode, invenkind,   petupgrade,      gethow)		-- ��
									values(					 @gameid_, @listidxnew, @itemcode, @invenkind, @petupgradeinit, @DEFINE_HOW_GET_GIFT)

									-- �굵�����.
									exec spu_FVDogamListPetLog @gameid_, @itemcode

									-- ����� ������ ����Ʈ�ε���
									set @listidxrtn	= @listidxnew
								end
							else
								begin
									--select 'DEBUG �� ���׷��̵�', @gameid_ gameid_, @listidxpet listidxpet

									update dbo.tFVUserItem
										set
											petupgrade = case
															when (petupgrade + 1 >= @USERITEM_PET_UPGRADE_MAX) then @USERITEM_PET_UPGRADE_MAX
															else													petupgrade + 1
														end
									where gameid = @gameid_ and listidx = @listidxpet

									-- ����� ������ ����Ʈ�ε���
									set @listidxrtn	= @listidxpet
								end

							-- ������ ������ ���·� �����д�.
							update dbo.tFVGiftList set giftkind = @GIFTLIST_GIFT_KIND_GIFT_GET, gaindate = getdate() where idx = @idx_
						end
				end
			else if(@subcategory = @ITEM_SUBCATEGORY_CASHCOST)
				begin
					---------------------------------------------------------------
					--select 'DEBUG 4-5-1 cashcost(ĳ��)	-> �ٷ�����', @cashcost cashcost, @buyamount buyamount
					---------------------------------------------------------------
					set @plus		= isnull(@buyamount, 0)
					set @plus2		= dbo.fnu_GetFVSystemInfo(21)
					if(@plus2 > 0 and @plus2 <= 100)
						begin
							set @plus = @plus + (@plus * @plus2 / 100)
						end
					set @cashcost	= @cashcost + @plus

					-- �������� ���� �־���
					update dbo.tFVUserMaster
					set
						cashcost = @cashcost
					where gameid = @gameid_

					-- ������ ������ ���·� �����д�.
					update dbo.tFVGiftList set giftkind = @GIFTLIST_GIFT_KIND_GIFT_GET, gaindate = getdate() where idx = @idx_
				end
			else if(@subcategory = @ITEM_SUBCATEGORY_GAMECOST)
				begin
					--select 'DEBUG 4-5-2 gamecost(����)	-> �ٷ�����', @gamecost gamecost, @buyamount buyamount
					set @plus		= isnull(@buyamount, 0)
					--set @plus2		= dbo.fnu_GetFVSystemInfo(22)
					--if(@plus2 > 0 and @plus2 <= 100)
					--	begin
					--		set @plus = @plus + (@plus * @plus2 / 100)
					--	end
					set @gamecost	= @gamecost + @plus

					update dbo.tFVUserMaster
					set
						gamecost = @gamecost
					where gameid = @gameid_

					-- ������ ������ ���·� �����д�.
					update dbo.tFVGiftList set giftkind = @GIFTLIST_GIFT_KIND_GIFT_GET, gaindate = getdate() where idx = @idx_
				end
			else if(@subcategory = @ITEM_SUBCATEGORY_FPOINT)
				begin
					--select 'DEBUG 4-5-3 ��������Ʈ -> �ٷ�����', @fpoint fpoint, @buyamount buyamount
					set @plus		= isnull(@buyamount, 0)
					set @fpoint		= @fpoint + @plus

					update dbo.tFVUserMaster
					set
						fpoint = @fpoint
					where gameid = @gameid_

					-- ������ ������ ���·� �����д�.
					update dbo.tFVGiftList set giftkind = @GIFTLIST_GIFT_KIND_GIFT_GET, gaindate = getdate() where idx = @idx_
				end
			else if(@subcategory = @ITEM_SUBCATEGORY_HEART)
				begin
					--select 'DEBUG 4-5-3 ��Ʈ -> �ٷ�����', @heart heart, @buyamount buyamount
					set @plus		= isnull(@buyamount, 0)
					--set @plus2		= dbo.fnu_GetFVSystemInfo(23)
					--if(@plus2 > 0 and @plus2 <= 100)
					--	begin
					--		set @plus = @plus + (@plus * @plus2 / 100)
					--	end
					set @heart		= @heart + @plus

					update dbo.tFVUserMaster
					set
						heart = @heart
					where gameid = @gameid_

					-- ������ ������ ���·� �����д�.
					update dbo.tFVGiftList set giftkind = @GIFTLIST_GIFT_KIND_GIFT_GET, gaindate = getdate() where idx = @idx_
				end
			else if(@subcategory = @ITEM_SUBCATEGORY_FEED)
				begin
					-- �ƽ� �ʰ��Ǵ���� �ʰ��ؼ� ����.
					--select 'DEBUG 4-5-4 ���� -> �ٷ�����', @feed feed, @buyamount buyamount
					set @plus		= isnull(@buyamount, 0)
					--set @plus2		= dbo.fnu_GetFVSystemInfo(24)
					--if(@plus2 > 0 and @plus2 <= 100)
					--	begin
					--		set @plus = @plus + (@plus * @plus2 / 100)
					--	end
					set @feed		= @feed + @plus

					update dbo.tFVUserMaster
					set
						feed = @feed
					where gameid = @gameid_

					-- ������ ������ ���·� �����д�.
					update dbo.tFVGiftList set giftkind = @GIFTLIST_GIFT_KIND_GIFT_GET, gaindate = getdate() where idx = @idx_
				end
			else
				begin
					--------------------------------------------------------------
					-- seed(��������)	-> ����
					-- ���׷��̵�		-> ����
					--------------------------------------------------------------
					--select 'DEBUG 4-7 ����ǥ�ÿ�'

					-- ������ ������ ���·� �����д�.
					update dbo.tFVGiftList set giftkind = @GIFTLIST_GIFT_KIND_GIFT_GET, gaindate = getdate() where idx = @idx_
				end
		END

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off

	if(@nResult_ = @RESULT_SUCCESS)
		begin
			--------------------------------------------------------------
			-- �ڵ�(ĳ��, ����, ��Ʈ, ����)
			--------------------------------------------------------------
			select @nResult_ rtn, @comment comment, gamecost, cashcost, heart, feed, fpoint from dbo.tFVUserMaster where gameid = @gameid

			--------------------------------------------------------------
			-- ���� ���� ������ ���� > ���� ȹ���� �͸� ����(������ �ϰ� ���� ������ Ŭ����� �����͸� �������� ������)
			--------------------------------------------------------------
			select * from dbo.tFVUserItem
			where gameid = @gameid_ and listidx = @listidxrtn

			--------------------------------------------------------------
			-- ����/���� ����Ʈ ����
			--------------------------------------------------------------
			exec spu_FVGiftList @gameid_
		end
	else
		begin
			select @nResult_ rtn, @comment comment, @gamecost gamecost, @cashcost cashcost, @heart heart, @feed feed, @fpoint fpoint
		end

End

