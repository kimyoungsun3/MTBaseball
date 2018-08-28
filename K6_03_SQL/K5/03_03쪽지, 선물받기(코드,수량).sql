---------------------------------------------------------------
/*
set @str = @gameid + '%'
select a.idx idx2, gameid, giftkind, message, gaindate, giftid, giftdate, b.*
from (select top 100 * from dbo.tGiftList where giftkind in (1, 2) and gameid = @gameid_ order by idx desc) a
	LEFT JOIN
	dbo.tItemInfo b
	ON a.itemcode = b.itemcode
order by idx2 desc

-- update dbo.tGiftList set giftkind = 2 where idx >= 1870 and gameid = 'xxxx2'
-- update dbo.tGiftList set giftkind = 1 where idx = 1925  and gameid = 'xxxx2'
-- delete from dbo.tUserItem where gameid = 'xxxx2' and listidx = 10
update dbo.tGiftList set giftkind = 2 where idx = 1 where gameid = 'xxxx2'

exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -1, 1925, -1, -1, -1, -1	-- �����ޱ�(����)
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1926, -1, -1, -1, -1	-- ��	(�κ�)
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1927, -1,  2, -1, -1	-- ��	(�ʵ�2)
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1928, -1,  2, -1, -1	-- ��� (�ʵ�2 �浹)
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1929, -1, -1, -1, -1	-- �Ѿ�
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1930, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1931, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1932, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1933, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1875, -1, -1,  1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1870, -1, -1,  1, -1	-- ���
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1871, -1, -1,  1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1872, -1, -1,  1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1873, -1, -1,  1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1876, -1, -1,  1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1878, -1, -1,  1, -1	-- �ϲ�
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1879, -1, -1,  1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1880, -1, -1,  1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1881, -1, -1,  1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1882, -1, -1,  1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1883, -1, -1,  1, -1	-- ������
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1884, -1, -1,  1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1885, -1, -1,  1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1886, -1, -1,  1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1887, -1, -1,  1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1888, -1, -1,  1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1889, -1, -1,  1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1892, -1, -1, -1, -1	-- ��Ȱ��
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1893, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1894, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1897, -1, -1, -1, -1	-- �ռ��ð�����
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1898, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1899, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1901, -1, -1, -1, -1	-- ��޿�ûƼ��
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1902, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1903, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1874, -1, -1,  1, -1	-- ����
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1877, -1, -1,  1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1910, -1, -1, -1, -1	-- ��������Ʈ
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1911, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1912, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1913, -1, -1, -1, -1	-- ��Ʈ
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1914, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1915, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1916, -1, -1, -1, -1	-- ĳ��
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1917, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1918, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1919, -1, -1, -1, -1	-- ����
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1920, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1921, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1904, -1, -1, -1, -1	-- �Ϲݱ���Ƽ��
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1905, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1906, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1907, -1, -1, -1, -1	-- �����̾�����̱�
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1908, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1909, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 3463, -1, -1, -1, -1	-- Ȳ��Ƽ��
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 3230, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 3464, -1, -1, -1, -1	-- �ο�Ƽ��
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 3232, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 8866, -1, -1, -1, -1	-- �ٱ⼼��.
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 3360, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 3361, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 3362, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 3363, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 3364, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 3365, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 10752, -1, -1, -1, -1	-- �����ޱ�.
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 8873, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 6695, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 8097, -1, -1, -1, -1	-- ����Ƽ�Ϲޱ�.
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 8098, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 8099, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 8100, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 24894, -1, -1, -1, -1	-- �ռ��� ����.
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 24893, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 24895, -1, -1, -1, -1	-- �±��� ��.
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 24896, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 28382, -1, -1, -1, -1	-- ������Ʋ�ڽ� > �ޱ������....
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 28383, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 28384, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 28385, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 28386, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 28387, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 31568, -1, -1, -1, -1	-- ¥������.
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 31569, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 40354, -1, -1, -1, -1	-- ĳ������Ʈ.
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 263704, -1, -1, -1, -1	--

exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1924, -1, -1, -1, -1	-- �꼱��(6).
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1923, -1, -1, -1, -1	-- �꼱��(1).

exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -5, -1, -1, -1, -1, -1	-- ����Ʈ����
*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_GiftGainNew', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_GiftGainNew;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_GiftGainNew
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

	-- ���� �ڵ尪
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- �������ڵ��ã��
	declare @RESULT_ERROR_GIFTITEM_NOT_FOUND	int				set @RESULT_ERROR_GIFTITEM_NOT_FOUND	= -51			-- ������������ ��ã��
	declare @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	int				set @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	= -52			-- ������ �̹� ������
	declare @RESULT_ERROR_NOT_FOUND_GIFTID		int				set @RESULT_ERROR_NOT_FOUND_GIFTID		= -75			-- ĳ�� > ������ ���̵� ��ã��

	-- ��Ÿ����
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- ���������ʴ¸��
	declare @RESULT_ERROR_INVEN_FULL			int				set @RESULT_ERROR_INVEN_FULL			= -101			-- �κ�����
	declare @RESULT_ERROR_NOT_MATCH				int				set @RESULT_ERROR_NOT_MATCH				= -110			-- �����ΰ� ��ġ�� �ȵǾ���.

	------------------------------------------------
	--	2-2. ���ǵȰ�
	------------------------------------------------
	-- �����ۺ� �κ��з�
	declare @USERITEM_INVENKIND_ANI				int 				set @USERITEM_INVENKIND_ANI					= 1
	declare @USERITEM_INVENKIND_CONSUME			int 				set @USERITEM_INVENKIND_CONSUME				= 3
	--declare @USERITEM_INVENKIND_ACC			int 				set @USERITEM_INVENKIND_ACC					= 4
	--declare @USERITEM_INVENKIND_DIRECT		int 				set @USERITEM_INVENKIND_DIRECT				= 40
	--declare @USERITEM_INVENKIND_INFO			int 				set @USERITEM_INVENKIND_INFO				= 60
	declare @USERITEM_INVENKIND_PET				int 				set @USERITEM_INVENKIND_PET					= 1000
	declare @USERITEM_INVENKIND_STEMCELL		int 				set @USERITEM_INVENKIND_STEMCELL			= 1040
	declare @USERITEM_INVENKIND_TREASURE		int 				set @USERITEM_INVENKIND_TREASURE			= 1200

	-- ������ ������
	--declare @ITEM_SUBCATEGORY_COW				int					set @ITEM_SUBCATEGORY_COW 					= 1  -- ��		(�Ǹ�[O], ����[O])			0
	--declare @ITEM_SUBCATEGORY_GOAT			int					set @ITEM_SUBCATEGORY_GOAT 					= 2  -- ��		(�Ǹ�[O], ����[O])			0
	--declare @ITEM_SUBCATEGORY_SHEEP			int					set @ITEM_SUBCATEGORY_SHEEP 				= 3  -- ���	(�Ǹ�[O], ����[O])			0
	--declare @ITEM_SUBCATEGORY_SEED			int					set @ITEM_SUBCATEGORY_SEED 					= 7  -- ����	(�Ǹ�[X], ����[X], ����[O])	0
	declare @ITEM_SUBCATEGORY_BULLET			int					set @ITEM_SUBCATEGORY_BULLET 				= 8  -- �Ѿ�	(�Ǹ�[O], ����[O])			0
	declare @ITEM_SUBCATEGORY_VACCINE			int					set @ITEM_SUBCATEGORY_VACCINE 				= 9  -- ���	(�Ǹ�[O], ����[O])			0
	declare @ITEM_SUBCATEGORY_FEED				int					set @ITEM_SUBCATEGORY_FEED 					= 44 -- ����	(�Ǹ�[X], ����[O])
	declare @ITEM_SUBCATEGORY_ALBA				int					set @ITEM_SUBCATEGORY_ALBA 					= 11 -- �ϲ�	(�Ǹ�[O], ����[O])			0
	declare @ITEM_SUBCATEGORY_BOOSTER			int					set @ITEM_SUBCATEGORY_BOOSTER 				= 12 -- ������	(�Ǹ�[O], ����[O])			0
	--declare @ITEM_SUBCATEGORY_REVIVAL			int					set @ITEM_SUBCATEGORY_REVIVAL 				= 13 -- ��Ȱ��	(�Ǹ�[O], ����[O])			0
	--declare @ITEM_SUBCATEGORY_COMPOSE_TIME	int					set @ITEM_SUBCATEGORY_COMPOSE_TIME 			= 16 -- �ռ�1�ð� �ʱ�ȭ(�Ǹ�[X], ����[O])
	--declare @ITEM_SUBCATEGORY_ACC				int					set @ITEM_SUBCATEGORY_ACC 					= 15 -- �Ǽ�	(�Ǹ�[O], ����[O])			0
	declare @ITEM_SUBCATEGORY_FPOINT			int					set @ITEM_SUBCATEGORY_FPOINT 				= 19 -- ��������Ʈ(�Ǹ�[X], ����[O])
	declare @ITEM_SUBCATEGORY_HEART				int					set @ITEM_SUBCATEGORY_HEART 				= 40 -- ��Ʈ	(�Ǹ�[O], ����[O])
	--declare @ITEM_SUBCATEGORY_HELPER			int					set @ITEM_SUBCATEGORY_HELPER 				= 41 -- ��޿�û(�Ǹ�[X], ����[O])			0
	--declare @ITEM_SUBCATEGORY_TRADESAFE		int					set @ITEM_SUBCATEGORY_TRADESAFE				= 42 -- ���θ���(�Ǹ�[X], ����[O])			0
	declare @ITEM_SUBCATEGORY_CASHCOST			int					set @ITEM_SUBCATEGORY_CASHCOST 				= 50 -- ĳ��	(�Ǹ�[O], ����[O])
	declare @ITEM_SUBCATEGORY_GAMECOST			int					set @ITEM_SUBCATEGORY_GAMECOST 				= 51 -- ����	(�Ǹ�[O], ����[O])
	--declare @ITEM_SUBCATEGORY_ROULETTE_NOR	int					set @ITEM_SUBCATEGORY_ROULETTE_NOR			= 22 -- �Ϲ� ���� �̱�Ƽ��(�Ǹ�[X], ����[O])
	--declare @ITEM_SUBCATEGORY_ROULETTE_PRE	int					set @ITEM_SUBCATEGORY_ROULETTE_PRE			= 23 -- �����̾� ���� �̱�Ƽ��(�Ǹ�[X], ����[O])
	--declare @ITEM_SUBCATEGORY_TREASURE_NOR	int					set @ITEM_SUBCATEGORY_TREASURE_NOR			= 25 -- �Ϲ� ���� �̱�Ƽ��
	--declare @ITEM_SUBCATEGORY_TREASURE_PRE	int					set @ITEM_SUBCATEGORY_TREASURE_PRE			= 26 -- �����̾� ���� �̱�Ƽ��
	--declare @ITEM_SUBCATEGORY_CONTEST			int					set @ITEM_SUBCATEGORY_CONTEST 				= 53 -- ��ȸ	(�Ǹ�[O], ����[O])			0
	--declare @ITEM_SUBCATEGORY_UPGRADE_HOUSE	int					set @ITEM_SUBCATEGORY_UPGRADE_HOUSE 		= 60 -- ��
	--declare @ITEM_SUBCATEGORY_UPGRADE_TANK	int					set @ITEM_SUBCATEGORY_UPGRADE_TANK 			= 61 -- ��ũ
	--declare @ITEM_SUBCATEGORY_UPGRADE_FRESHCOOL	int				set @ITEM_SUBCATEGORY_UPGRADE_FRESHCOOL 	= 62 -- ���º���
	--declare @ITEM_SUBCATEGORY_UPGRADE_PURE	int					set @ITEM_SUBCATEGORY_UPGRADE_PURE 			= 63 -- ��ȭ�ü�
	--declare @ITEM_SUBCATEGORY_UPGRADE_BOTTLE	int					set @ITEM_SUBCATEGORY_UPGRADE_BOTTLE 		= 64 -- �絿��
	--declare @ITEM_SUBCATEGORY_UPGRADE_PUMP	int					set @ITEM_SUBCATEGORY_UPGRADE_PUMP 			= 65 -- ������
	--declare @ITEM_SUBCATEGORY_UPGRADE_TRANSFER	int				set @ITEM_SUBCATEGORY_UPGRADE_TRANSFER 		= 66 -- ���Ա�
	--declare @ITEM_SUBCATEGORY_INVEN			int					set @ITEM_SUBCATEGORY_INVEN 				= 67 -- �κ�Ȯ��
	--declare @ITEM_SUBCATEGORY_SEEDFIELD		int					set @ITEM_SUBCATEGORY_SEEDFIELD 			= 68 -- ������Ȯ��
	--declare @ITEM_SUBCATEGORY_DOGAM			int					set @ITEM_SUBCATEGORY_DOGAM 				= 818 -- ����
	--declare @ITEM_SUBCATEGORY_SYSINFO			int					set @ITEM_SUBCATEGORY_SYSINFO 				= 500 -- ��������
	--declare @ITEM_SUBCATEGORY_ATTENDANCE		int					set @ITEM_SUBCATEGORY_ATTENDANCE 			= 900 	--�⼮(900)
	--declare @ITEM_SUBCATEGORY_COMPETITION		int					set @ITEM_SUBCATEGORY_COMPETITION 			= 901 	--������(901)
	declare @ITEM_SUBCATEGORY_PET				int					set @ITEM_SUBCATEGORY_PET					= 1000 	--��(1000)
	declare @ITEM_SUBCATEGORY_GOLDTICKET		int					set @ITEM_SUBCATEGORY_GOLDTICKET			= 30	-- Ȳ��Ƽ��.
	declare @ITEM_SUBCATEGORY_BATTLETICKET		int					set @ITEM_SUBCATEGORY_BATTLETICKET			= 31	-- �ο�Ƽ��.
	--declare @ITEM_SUBCATEGORY_STEMCELL		int					set @ITEM_SUBCATEGORY_STEMCELL				= 1040	-- �ٱ⼼��.
	--declare @ITEM_SUBCATEGORY_TREASURE		int					set @ITEM_SUBCATEGORY_TREASURE				= 1200	-- ����.
	--declare @ITEM_SUBCATEGORY_COMPOSETICKET	int					set @ITEM_SUBCATEGORY_COMPOSETICKET			= 35	-- �ռ��� ����(35)
	--declare @ITEM_SUBCATEGORY_PROMOTETICKET	int					set @ITEM_SUBCATEGORY_PROMOTETICKET	 		= 36	-- �±��� ��(36)
	declare @ITEM_SUBCATEGORY_USERBATTLEBOX		int					set @ITEM_SUBCATEGORY_USERBATTLEBOX			= 37	-- ������Ʋ�ڽ�(37)
	--declare @ITEM_SUBCATEGORY_ZZCOUPON		int					set @ITEM_SUBCATEGORY_ZZCOUPON				= 38	-- ¥�� ����(38)
	declare @ITEM_SUBCATEGORY_CASHPOINT			int					set @ITEM_SUBCATEGORY_CASHPOINT				= 39	-- ��������Ʈ(39)

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
	declare @USERITEM_FIELDIDX_INVEN			int					set @USERITEM_FIELDIDX_INVEN				= -1	-- â��.
	declare @USERITEM_FIELDIDX_HOSPITAL			int					set @USERITEM_FIELDIDX_HOSPITAL				= -2	-- ����.

	-- �Ҹ��� > �����Կ� ������ġ.
	declare @USERMASTER_QUICKKIND_NON			int					set @USERMASTER_QUICKKIND_NON				= -1 --����.
	declare @USERMASTER_QUICKKIND_SETTING		int					set @USERMASTER_QUICKKIND_SETTING			=  1 --�Ѿ�, ���, ����, �˹�.

	-- ���Ÿ ����
	declare @USERITEM_PET_UPGRADE_MAX			int					set @USERITEM_PET_UPGRADE_MAX				= 6	-- ���׷��̵� �ƽ�.
	declare @USERITEM_TREASURE_UPGRADE_MAX		int					set @USERITEM_TREASURE_UPGRADE_MAX			= 7	-- max��ȭ.

	-- Ư����.
	declare @ITEM_ZCP_PIECE_MOTHER				int					set @ITEM_ZCP_PIECE_MOTHER					= 3800	-- ¥����������.
	declare @ITEM_ZCP_TICKET_MOTHER				int					set @ITEM_ZCP_TICKET_MOTHER					= 3801	-- ¥������.

	------------------------------------------------
	--	2-3. ���λ�� ����
	------------------------------------------------
	declare @gameid			varchar(20)		set @gameid		= ''
	declare @itemcode		int
	declare @giftkind		int				set @giftkind 	= -1
	declare @cashcost		int				set @cashcost 	= 0
	declare @gamecost		int				set @gamecost 	= 0
	declare @heart			int				set @heart 		= 0
	declare @feed			int				set @feed 		= 0
	declare @fpoint			int				set @fpoint		= 0
	declare @goldticket		int				set @goldticket	= 0
	declare @battleticket	int				set @battleticket= 0
	declare @cashpoint		int				set @cashpoint 	= 0

	declare @invenanimalmax	int
	declare @invencustommax int
	declare @invenaccmax	int
	declare @invenstemcellmax	int
	declare @inventreasuremax	int

	declare @subcategory 	int,
			@buyamount		int,
			@invenkind		int

	declare @comment		varchar(80)
	declare @plus	 		int 			set @plus			= 0
	declare @plus2	 		int 			set @plus2			= 0
	declare @cashcostplus	int				set @cashcostplus	= 0

	declare @cnt 			int
	declare @cnt2 			int				set @cnt2			=  0
	declare @listidx2		int				set @listidx2		=  -1
	declare @upstepmax		int				set @upstepmax		=  8
	declare @listidxtreasure	int			set @listidxtreasure= -1
	declare @sendcnt 		int				set @sendcnt		=  0
	declare @listidxnew 	int				set @listidxnew		= -1
	declare @listidxcust 	int				set @listidxcust	= -1
	declare @listidxpet 	int				set @listidxpet		= -1
	declare @petupgradeinit	int				set @petupgradeinit	=  1
	declare @listidxrtn 	int				set @listidxrtn		= -1
	declare @fieldidx 		int

	declare @dummy	 		int
	declare @sellcost		int				set @sellcost		= 0

	-- ������Ʋ�ڽ�
	declare @boxslotidx		int				set @boxslotidx		= -1
	declare @boxslottime	datetime		set @boxslottime	= getdate()
	declare @boxslot1 		int				set @boxslot1		= -1
	declare @boxslot2 		int				set @boxslot2		= -1
	declare @boxslot3 		int				set @boxslot3		= -1
	declare @boxslot4 		int				set @boxslot4		= -1

	-- �ʵ����.
	declare @field0			int				set @field0			= -1
	declare @field1			int				set @field1			= -1
	declare @field2			int				set @field2			= -1
	declare @field3			int				set @field3			= -1
	declare @field4			int				set @field4			= -1
	declare @field5			int				set @field5			= -1
	declare @field6			int				set @field6			= -1
	declare @field7			int				set @field7			= -1
	declare @field8			int				set @field8			= -1

	DECLARE @tTempTable TABLE(
		listidx		int
	);
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	set @comment  = '�˼� ���� ������ �߻��߽��ϴ�.'
	--select 'DEBUG 1-1 �Է°�', @gameid_ gameid_, @password_ password_, @giftkind_ giftkind_, @idx_ idx_, @listidx_ listidx_, @fieldidx_ fieldidx_, @quickkind_ quickkind_

	if(@fieldidx_ < -1 or @fieldidx_ >= 9)
		begin
			--select 'DEBUG 1-2 �κ���ȣ�� �߸��Ǿ �κ����� ���.'
			set @fieldidx_ = @USERITEM_FIELDIDX_INVEN
		end

	------------------------------------------------
	--	3-2. �������(��������, ��������, ������ ����)
	------------------------------------------------
	select
		@gameid 		= gameid,
		@cashcost		= cashcost,			@gamecost		= gamecost,			@heart			= heart,			@cashpoint		= cashpoint,
		@feed			= feed,				@fpoint			= fpoint,			@goldticket 	= goldticket, 		@battleticket	= battleticket,
		@invenanimalmax	= invenanimalmax,
		@invencustommax = invencustommax,
		@invenaccmax 	= invenaccmax,
		@invenstemcellmax= invenstemcellmax,@inventreasuremax = inventreasuremax,
		@boxslotidx		= boxslotidx,		@boxslottime	= boxslottime,
		@boxslot1		= boxslot1,			@boxslot2		= boxslot2,			@boxslot3		= boxslot3,			@boxslot4		= boxslot4,

		@field0			= field0,			@field1			= field1,			@field2			= field2,
		@field3			= field3,			@field4			= field4,			@field5			= field5,
		@field6			= field6,			@field7			= field7,			@field8			= field8
	from dbo.tUserMaster where gameid = @gameid_ and password = @password_
	--select 'DEBUG 1-3 ��������', @gameid gameid, @cashcost cashcost, @gamecost gamecost, @heart heart, @feed feed, @fpoint fpoint, @invenanimalmax invenanimalmax, @invencustommax invencustommax, @invenaccmax invenaccmax

	select
		@giftkind 	= giftkind,
		@itemcode 	= itemcode,
		@sendcnt	= cnt
	from dbo.tGiftList where gameid = @gameid_ and idx = @idx_
	--select 'DEBUG 1-4 ����/����', @giftkind giftkind, @itemcode itemcode, @sendcnt sendcnt

	------------------------------------------------
	--	3-3. ����Ȳ���� �ڵ�� �з�
	------------------------------------------------
	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR ���̵� �������� �ʴ´�.'
			--select 'DEBUG ' + @comment
		END
	else if(@giftkind_ = @GIFTLIST_GIFT_KIND_LIST)
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS ���� ����Ʈ ����.'
			--select 'DEBUG ' + @comment

			set @listidxrtn = -1
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

			update dbo.tGiftList set giftkind = @giftkind_ where idx = @idx_
		END
	else if(@giftkind_ = @GIFTLIST_GIFT_KIND_GIFT_DEL)
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS ���� ���� ó���մϴ�.'
			--select 'DEBUG ' + @comment

			update dbo.tGiftList set giftkind = @giftkind_ where idx = @idx_
		END
	else if(@giftkind_ = @GIFTLIST_GIFT_KIND_GIFT_SELL)
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS �������� ������ �Ⱦƶ�.'
			--select 'DEBUG ' + @comment

			------------------------------------------
			-- �������� �Ǹ��ϴ� ����.
			------------------------------------------
			select
				@buyamount 	= buyamount,
				@sellcost 	= sellcost
			from dbo.tItemInfo where itemcode = @itemcode

			if(@sendcnt > 0)
				begin
					set @gamecost = @gamecost + @sellcost * @sendcnt
				end
			else
				begin
					set @gamecost = @gamecost + @sellcost * @buyamount
				end

			update dbo.tGiftList set giftkind = @giftkind_ where idx = @idx_
			update dbo.tUserMaster
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
				@upstepmax		= param30
			from dbo.tItemInfo where itemcode = @itemcode
			--select 'DEBUG 4-0 ', @subcategory subcategory, @buyamount buyamount, @sendcnt sendcnt

			set @buyamount = case when(@sendcnt > 0) then @sendcnt else @buyamount end
			set @invenkind = dbo.fnu_GetInvenFromSubCategory(@subcategory)
			select @listidxnew = isnull(MAX(listidx), 0) + 1 from dbo.tUserItem where gameid = @gameid_

			--select 'DEBUG 4-1 ', @subcategory subcategory, @buyamount buyamount, @sendcnt sendcnt, @invenkind invenkind, @listidxnew listidxnew

			if(@invenkind = @USERITEM_INVENKIND_ANI)
				begin
					--------------------------------------------------------------
					-- ���� ������ > �κ������ľ�
					--------------------------------------------------------------
					select @cnt = count(*)
					from dbo.tUserItem
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
									--select 'DEBUG 4-2-3 ���� > �ʵ�Ǯ�̶� �κ��� �־�ζ�(Ŭ�󿡼� ��û��).', @fieldidx fieldidx
								end
							else if(exists(select top 1 * from dbo.tUserItem where gameid = @gameid_ and fieldidx = @fieldidx_))
								begin
									---------------------------------------------------
									-- ���ڸ� ã�� Ŀ��
									-- 0   2 3 4 5 		 >  1
									-- 0 1 2 3 4 5 		 >  6
									-- 0 1 2 3 4 5 6 7 8 > -1
									---------------------------------------------------
									set @fieldidx = dbo.fun_getUserItemFieldIdxAni(@gameid_)
									--select 'DEBUG 4-2-3 ���� > ����(�浹)', @fieldidx fieldidx
								end
							else
								begin
									set @fieldidx = @fieldidx_
									--select 'DEBUG 4-2-3 ���� > �ʵ尡 ��ȿ�ؼ� �״�� �־��.', @fieldidx fieldidx
								end

							-- �ʵ尡 ����ϴ� �����ΰ�?
							--select 'DEBUG (��)', @fieldidx fieldidx, @field0 field0, @field1 field1, @field2 field2, @field3 field3, @field4 field4, @field5 field5, @field6 field6, @field7 field7, @field8 field8
							set @fieldidx = dbo.fun_getUserItemFieldCheck(@fieldidx,
																		  @field0, @field1, @field2,
																		  @field3, @field4, @field5,
																		  @field6, @field7, @field8)
							--select 'DEBUG (��)', @fieldidx fieldidx, @field0 field0, @field1 field1, @field2 field2, @field3 field3, @field4 field4, @field5 field5, @field6 field6, @field7 field7, @field8 field8

							-- �ش������ �κ��� ����
							insert into dbo.tUserItem(gameid,      listidx,  itemcode, cnt, farmnum,  fieldidx,  invenkind,  upstepmax, gethow)		-- ����.
							values(					 @gameid_, @listidxnew, @itemcode,   1,       0, @fieldidx, @invenkind, @upstepmax, @DEFINE_HOW_GET_GIFT)

							-- �������
							exec spu_DogamListLog @gameid_, @itemcode

							-- ������ ������ ���·� �����д�.
							update dbo.tGiftList set giftkind = @GIFTLIST_GIFT_KIND_GIFT_GET, gaindate = getdate() where idx = @idx_

							-- ����� ������ ����Ʈ�ε���
							set @listidxrtn	= @listidxnew

							--select 'DEBUG ', @listidxrtn listidxrtn, @fieldidx fieldidx
						end
				end
			else if(@invenkind = @USERITEM_INVENKIND_CONSUME and @itemcode = @ITEM_ZCP_PIECE_MOTHER )
				begin
					--------------------------------------------------------------
					-- ¥���������� > �κ������ľ�
					--------------------------------------------------------------
					select @cnt = count(*) from dbo.tUserItem
					where gameid = @gameid_
						  and invenkind = @invenkind
						  and cnt > 0

					--------------------------------------------------------------
					-- ������ Ȯ��.
					--------------------------------------------------------------
					select
						@cnt2			= cnt,
						@listidxcust 	= listidx
					from dbo.tUserItem
					where gameid = @gameid_ and itemcode = @itemcode
					--select 'DEBUG 4-3 ¥���������� �κ��ֱ�', @gameid_ gameid_, @subcategory subcategory, @itemcode itemcode, @cnt2 cnt2, @listidxcust listidxcust, @cnt cnt, @invencustommax invencustommax

					-------------------------------------------------
					-- ��ũ ��ȣ ������ ���� ����ڵ�.
					-------------------------------------------------
					if( @listidx_ =  -1 and @listidxcust != -1 )
						begin
							-- ��ũ ��ȣ�� ���ٰ� �ϴµ� ��ũ ��ȣ�� �ֳ׿�. > �缼��.
							set @listidx_ = @listidxcust
						end
					else if( @listidx_ !=  @listidxcust )
						begin
							set @listidx_ = @listidxcust
						end

					-------------------------------------------------
					-- �������.
					-------------------------------------------------
					if(@listidxcust = -1 and (@cnt >= (@invencustommax + 4)))
						begin
							set @nResult_ = @RESULT_ERROR_INVEN_FULL
							set @comment = 'ERROR �Һ� �κ��� Ǯ�Դϴ�.'
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

									insert into dbo.tUserItem(gameid,      listidx,  itemcode,        cnt,  invenkind, gethow)
									values(					@gameid_,  @listidxnew, @itemcode, @buyamount, @invenkind, @DEFINE_HOW_GET_GIFT)

									-- ����� ������ ����Ʈ�ε���
									set @listidxrtn	= @listidxnew
								end
							else
								begin
									--select 'DEBUG �Һ� �����ۿ� ����', @gameid_ gameid_, @listidxcust listidxcust, @buyamount buyamount

									update dbo.tUserItem
										set
											cnt = cnt + @buyamount
									where gameid = @gameid_ and listidx = @listidxcust

									-- ����� ������ ����Ʈ�ε���
									set @listidxrtn	= @listidxcust
								end


							---------------------------------------------------
							-- ������ ��������
							-- 99���� ������ ������� ����.
							---------------------------------------------------
							select @cnt2 = cnt from dbo.tUserItem where gameid = @gameid_ and listidx = @listidxrtn
							--select 'DEBUG ', @cnt2 cnt2
							while( @cnt2 >= 99 )
								begin
									--select 'DEBUG ¥����������(99��) -> ¥������ (1��)'
									exec spu_SetDirectItemNew @gameid_, @ITEM_ZCP_TICKET_MOTHER, 1, @DEFINE_HOW_GET_GIFT, @rtn_ = @listidx2 OUTPUT
									insert into @tTempTable( listidx ) values( @listidx2 )

									-- ���������Ŀ� ���� �������ֱ�.
									set @cnt2 = @cnt2 - 99

									update dbo.tUserItem
										set
											cnt = @cnt2
									where gameid = @gameid_ and listidx = @listidxrtn
								end


							-- ������ ������ ���·� �����д�.
							--select 'DEBUG > ', @idx_ idx_
							update dbo.tGiftList set giftkind = @GIFTLIST_GIFT_KIND_GIFT_GET, gaindate = getdate() where idx = @idx_
						end
				end
			else if(@invenkind = @USERITEM_INVENKIND_CONSUME and @itemcode = @ITEM_ZCP_TICKET_MOTHER )
				begin
					--------------------------------------------------------------
					-- ¥������ (60�� ������).
					--------------------------------------------------------------
					--select 'DEBUG ¥������ insert', @gameid_ gameid_, @listidxnew listidxnew, @itemcode itemcode, @buyamount buyamount
					insert into dbo.tUserItem(gameid,       listidx,  itemcode,        cnt, expirekind,     expiredate,  invenkind,  gethow)
					values(					 @gameid_,  @listidxnew, @itemcode, @buyamount,          1, getdate() + 60, @invenkind, @DEFINE_HOW_GET_GIFT)

					-- ����� ������ ����Ʈ�ε���
					set @listidxrtn	= @listidxnew

					-- ������ ������ ���·� �����д�.
					--select 'DEBUG > ', @idx_ idx_
					update dbo.tGiftList set giftkind = @GIFTLIST_GIFT_KIND_GIFT_GET, gaindate = getdate() where idx = @idx_
				end
			else if(@invenkind = @USERITEM_INVENKIND_CONSUME)
				begin
					--------------------------------------------------------------
					-- ���� ������ > �κ������ľ�
					--------------------------------------------------------------
					select @cnt = count(*)
					from dbo.tUserItem
					where gameid = @gameid_
						  and invenkind = @invenkind
						  and cnt > 0

					--------------------------------------------------------------
					-- �Ѿ�					-> �Ҹ� ������0
					-- ���					-> �Ҹ� ������0
					-- �˹�					-> �Ҹ� ������0
					-- ������				-> �Ҹ� ������0
					-- ��Ȱ��				-> �Ҹ� ������ (�����ڵ� > 1���� ���ϵ�)
					-- �ռ��ð�		 		-> �Ҹ� ������
					-- ��޿�û Ƽ��		-> �Ҹ� ������ (�����ڵ� > 1���� ���ϵ�)
					-- �Ϲݱ���̱� Ƽ��	-> �Ҹ� ������
					-- �����̾�����̱� Ƽ��-> �Ҹ� ������
					--------------------------------------------------------------
					set @itemcode = dbo.fnu_GetItemcodeFromConsumePackage(@subcategory, @itemcode)

					select
						@listidxcust = listidx
					from dbo.tUserItem
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

									insert into dbo.tUserItem(gameid,      listidx,  itemcode,        cnt,  invenkind, gethow)
									values(					@gameid_,  @listidxnew, @itemcode, @buyamount, @invenkind, @DEFINE_HOW_GET_GIFT)

									-- ����� ������ ����Ʈ�ε���
									set @listidxrtn	= @listidxnew
								end
							else
								begin
									--select 'DEBUG �Һ� �����ۿ� ����', @gameid_ gameid_, @listidxcust listidxcust, @buyamount buyamount

									update dbo.tUserItem
										set
											cnt = cnt + @buyamount
									where gameid = @gameid_ and listidx = @listidxcust

									-- ����� ������ ����Ʈ�ε���
									set @listidxrtn	= @listidxcust
								end

							if(@quickkind_ = @USERMASTER_QUICKKIND_SETTING)
								begin
									--select 'DEBUG > ������ �߰��Ѵ�.'
									update dbo.tUserMaster
										set
											bulletlistidx 	= case when (@subcategory = @ITEM_SUBCATEGORY_BULLET) 	then @listidxrtn else bulletlistidx end,
											vaccinelistidx	= case when (@subcategory = @ITEM_SUBCATEGORY_VACCINE) 	then @listidxrtn else vaccinelistidx end,
											boosterlistidx	= case when (@subcategory = @ITEM_SUBCATEGORY_BOOSTER)	then @listidxrtn else boosterlistidx end,
											albalistidx		= case when (@subcategory = @ITEM_SUBCATEGORY_ALBA) 	then @listidxrtn else albalistidx end
									where gameid = @gameid_
								end

							-- ������ ������ ���·� �����д�.
							--select 'DEBUG > ', @idx_ idx_
							update dbo.tGiftList set giftkind = @GIFTLIST_GIFT_KIND_GIFT_GET, gaindate = getdate() where idx = @idx_
						end
				end
			else if(@invenkind = @USERITEM_INVENKIND_STEMCELL)
				begin
					--------------------------------------------------------------
					-- �ٱ⼼��					-> �����ľ�
					--------------------------------------------------------------
					select @cnt = count(*)
					from dbo.tUserItem
					where gameid = @gameid_
						  and invenkind = @invenkind

					--------------------------------------------------------------
					-- �ٱ⼼��					-> �ٱ⼼�� ������
					--------------------------------------------------------------
					--select 'DEBUG 4-4 �ٱ⼼�� �κ��ֱ�', @cnt cnt, @invenstemcellmax invenstemcellmax
					if(@cnt >= @invenstemcellmax)
						begin
							set @nResult_ = @RESULT_ERROR_INVEN_FULL
							set @comment = 'ERROR �ٱ⼼�� �κ��� Ǯ�Դϴ�.'
							--select 'DEBUG ' + @comment, @invenstemcellmax invenstemcellmax
						end
					else
						begin
							--select 'DEBUG 4-4-2 ���� > �κ����� �̵�, �̺� ���� ���·� ����', @gameid_ gameid_, @listidxnew listidxnew, @itemcode itemcode

							insert into dbo.tUserItem(gameid,      listidx,  itemcode, invenkind,  gethow)		-- �Ǽ�
							values(					 @gameid_, @listidxnew, @itemcode, @invenkind, @DEFINE_HOW_GET_GIFT)

							-- ������ ������ ���·� �����д�.
							update dbo.tGiftList set giftkind = @GIFTLIST_GIFT_KIND_GIFT_GET, gaindate = getdate() where idx = @idx_

							-- ����� ������ ����Ʈ�ε���
							set @listidxrtn	= @listidxnew
						end
				end
			else if(@invenkind = @USERITEM_INVENKIND_TREASURE)
				begin
					--------------------------------------------------------------
					-- ����					-> �����ľ�
					--------------------------------------------------------------
					select @cnt = count(*)
					from dbo.tUserItem
					where gameid = @gameid_ and invenkind = @invenkind

					--------------------------------------------------------------
					-- ����					-> ���� ������
					--------------------------------------------------------------
					--select 'DEBUG 4-4 ���� �κ��ֱ�', @cnt cnt, @inventreasuremax inventreasuremax, @listidxtreasure listidxtreasure
					if( @cnt >= @inventreasuremax )
						begin
							set @nResult_ = @RESULT_ERROR_INVEN_FULL
							set @comment = 'ERROR ���� �κ��� Ǯ�Դϴ�.'
							--select 'DEBUG ' + @comment, @inventreasuremax inventreasuremax
						end
					else
						begin
							--select 'DEBUG 4-4-1 ���� > ��������'

							insert into dbo.tUserItem(gameid,      listidx,  itemcode,  invenkind,                      upstepmax, gethow)
							values(					 @gameid_, @listidxnew, @itemcode, @invenkind, @USERITEM_TREASURE_UPGRADE_MAX, @DEFINE_HOW_GET_GIFT)

							-- ����� ������ ����Ʈ�ε���
							set @listidxrtn	= @listidxnew

							---------------------------------
							-- ���� ����ȿ�� ����.
							---------------------------------
							exec spu_TSRetentionEffect @gameid_, @itemcode
						end


					-- ������ ������ ���·� �����д�.
					update dbo.tGiftList set giftkind = @GIFTLIST_GIFT_KIND_GIFT_GET, gaindate = getdate() where idx = @idx_
				end
			else if(@invenkind = @USERITEM_INVENKIND_PET)
				begin
					--------------------------------------------------------------
					-- ��					-> �� ������
					--------------------------------------------------------------
					--select 'DEBUG 4-4-2 ���� > ���κ����� �̵�, �̺� ���� ���·� ����', @gameid_ gameid_, @listidxnew listidxnew, @itemcode itemcode

					select
						@listidxpet = listidx
					from dbo.tUserItem
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
							from dbo.tItemInfo where itemcode = @itemcode and subcategory = @ITEM_SUBCATEGORY_PET
							--select 'DEBUG >', @petupgradeinit petupgradeinit

							if(@listidxpet = -1)
								begin
									--select 'DEBUG �� �߰�', @gameid_ gameid_, @listidxnew listidxnew, @itemcode itemcode, @buyamount buyamount
									insert into dbo.tUserItem(gameid,      listidx,  itemcode, invenkind,       petupgrade,      gethow)		-- ��
									values(					 @gameid_, @listidxnew, @itemcode, @invenkind, @petupgradeinit, @DEFINE_HOW_GET_GIFT)

									-- �굵�����.
									exec spu_DogamListPetLog @gameid_, @itemcode

									-- ����� ������ ����Ʈ�ε���
									set @listidxrtn	= @listidxnew
								end
							else
								begin
									--select 'DEBUG �� ���׷��̵�', @gameid_ gameid_, @listidxpet listidxpet

									update dbo.tUserItem
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
							update dbo.tGiftList set giftkind = @GIFTLIST_GIFT_KIND_GIFT_GET, gaindate = getdate() where idx = @idx_
						end
				end
			else if(@subcategory = @ITEM_SUBCATEGORY_USERBATTLEBOX)
				begin
					---------------------------------------------------------------
					--select 'DEBUG ������Ʋ�ڽ�'
					---------------------------------------------------------------
					set @dummy = -1
					if( @boxslot1 = -1 )
						begin
							set @boxslot1 		= @itemcode
							set @dummy 			= 1
						end
					else if( @boxslot2 = -1 )
						begin
							set @boxslot2 		= @itemcode
							set @dummy 			= 1
						end
					else if( @boxslot3 = -1 )
						begin
							set @boxslot3 		= @itemcode
							set @dummy 			= 1
						end
					else if( @boxslot4 = -1 )
						begin
							set @boxslot4 		= @itemcode
							set @dummy 			= 1
						end

					if(@dummy = -1)
						begin
							set @nResult_ = @RESULT_ERROR_INVEN_FULL
							set @comment = 'ERROR �κ��� Ǯ�Դϴ�.'
						end
					else
						begin
							-- �������� ���� �־���
							update dbo.tUserMaster
								set
									boxslot1	= @boxslot1,
									boxslot2	= @boxslot2,
									boxslot3	= @boxslot3,
									boxslot4	= @boxslot4
							where gameid = @gameid_

							-- ������ ������ ���·� �����д�.
							update dbo.tGiftList set giftkind = @GIFTLIST_GIFT_KIND_GIFT_GET, gaindate = getdate() where idx = @idx_
						end
				end
			else if(@subcategory = @ITEM_SUBCATEGORY_CASHCOST)
				begin
					---------------------------------------------------------------
					--select 'DEBUG 4-5-1 cashcost(ĳ��)	-> �ٷ�����', @cashcost cashcost, @buyamount buyamount
					---------------------------------------------------------------
					set @plus		= isnull(@buyamount, 0)
					set @cashcost	= @cashcost + @plus

					-- �������� ���� �־���
					update dbo.tUserMaster
					set
						cashcost = @cashcost
					where gameid = @gameid_

					-- ������ ������ ���·� �����д�.
					update dbo.tGiftList set giftkind = @GIFTLIST_GIFT_KIND_GIFT_GET, gaindate = getdate() where idx = @idx_
				end
			else if(@subcategory = @ITEM_SUBCATEGORY_GAMECOST)
				begin
					--select 'DEBUG 4-5-2 gamecost(����)	-> �ٷ�����', @gamecost gamecost, @buyamount buyamount
					set @plus		= isnull(@buyamount, 0)
					set @gamecost	= @gamecost + @plus

					update dbo.tUserMaster
					set
						gamecost = @gamecost
					where gameid = @gameid_

					-- ������ ������ ���·� �����д�.
					update dbo.tGiftList set giftkind = @GIFTLIST_GIFT_KIND_GIFT_GET, gaindate = getdate() where idx = @idx_
				end
			else if(@subcategory = @ITEM_SUBCATEGORY_FPOINT)
				begin
					--select 'DEBUG 4-5-3 ��������Ʈ -> �ٷ�����', @fpoint fpoint, @buyamount buyamount
					set @plus		= isnull(@buyamount, 0)
					set @fpoint		= @fpoint + @plus

					update dbo.tUserMaster
					set
						fpoint = @fpoint
					where gameid = @gameid_

					-- ������ ������ ���·� �����д�.
					update dbo.tGiftList set giftkind = @GIFTLIST_GIFT_KIND_GIFT_GET, gaindate = getdate() where idx = @idx_
				end
			else if(@subcategory = @ITEM_SUBCATEGORY_GOLDTICKET)
				begin
					--select 'DEBUG 4-6 Ȳ��Ƽ��  -> �ٷ�����', @goldticket goldticket, @buyamount buyamount
					set @plus		= isnull(@buyamount, 0)
					set @goldticket	= @goldticket + @plus

					update dbo.tUserMaster
						set
							goldticket = @goldticket
					where gameid = @gameid_

					-- ������ ������ ���·� �����д�.
					update dbo.tGiftList set giftkind = @GIFTLIST_GIFT_KIND_GIFT_GET, gaindate = getdate() where idx = @idx_
				end
			else if(@subcategory = @ITEM_SUBCATEGORY_BATTLETICKET)
				begin
					--select 'DEBUG 4-7 �ο�Ƽ��  -> �ٷ�����', @battleticket battleticket, @buyamount buyamount
					set @plus		= isnull(@buyamount, 0)
					set @battleticket= @battleticket + @plus

					update dbo.tUserMaster
						set
							battleticket = @battleticket
					where gameid = @gameid_

					-- ������ ������ ���·� �����д�.
					update dbo.tGiftList set giftkind = @GIFTLIST_GIFT_KIND_GIFT_GET, gaindate = getdate() where idx = @idx_
				end
			else if(@subcategory = @ITEM_SUBCATEGORY_HEART)
				begin
					--select 'DEBUG 4-5-3 ��Ʈ -> �ٷ�����', @heart heart, @buyamount buyamount
					set @plus		= isnull(@buyamount, 0)
					set @heart		= @heart + @plus

					update dbo.tUserMaster
					set
						heart = @heart
					where gameid = @gameid_

					-- ������ ������ ���·� �����д�.
					update dbo.tGiftList set giftkind = @GIFTLIST_GIFT_KIND_GIFT_GET, gaindate = getdate() where idx = @idx_
				end
			else if(@subcategory = @ITEM_SUBCATEGORY_FEED)
				begin
					-- �ƽ� �ʰ��Ǵ���� �ʰ��ؼ� ����.
					--select 'DEBUG 4-5-4 ���� -> �ٷ�����', @feed feed, @buyamount buyamount
					set @plus		= isnull(@buyamount, 0)
					set @feed		= @feed + @plus

					update dbo.tUserMaster
					set
						feed = @feed
					where gameid = @gameid_

					-- ������ ������ ���·� �����д�.
					update dbo.tGiftList set giftkind = @GIFTLIST_GIFT_KIND_GIFT_GET, gaindate = getdate() where idx = @idx_
				end
			else if(@subcategory = @ITEM_SUBCATEGORY_CASHPOINT)
				begin
					--select 'DEBUG 4-5-4 cashpoint -> �ٷ�����', @cashpoint feed, @buyamount buyamount
					set @plus		= isnull(@buyamount, 0)
					set @cashpoint	= @cashpoint + @plus

					update dbo.tUserMaster
						set
							cashpoint = @cashpoint
					where gameid = @gameid_

					-- ������ ������ ���·� �����д�.
					update dbo.tGiftList set giftkind = @GIFTLIST_GIFT_KIND_GIFT_GET, gaindate = getdate() where idx = @idx_
				end
			else
				begin
					--------------------------------------------------------------
					-- seed(��������)	-> ����
					-- ���׷��̵�		-> ����
					--------------------------------------------------------------
					--select 'DEBUG 4-7 ����ǥ�ÿ�'

					-- ������ ������ ���·� �����д�.
					update dbo.tGiftList set giftkind = @GIFTLIST_GIFT_KIND_GIFT_GET, gaindate = getdate() where idx = @idx_
				end

			-- ���� ������ ������ ����Ʈ�� �߰����ֱ�.
			if( @listidxrtn != -1)
				begin
					insert into @tTempTable( listidx ) values( @listidxrtn )
				end
		END

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off

	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost, @heart heart, @feed feed, @fpoint fpoint, @goldticket goldticket, @battleticket battleticket,
		   @boxslotidx boxslotidx, @boxslottime boxslottime, @cashpoint cashpoint,
		   @boxslot1 boxslot1, @boxslot2 boxslot2, @boxslot3 boxslot3, @boxslot4 boxslot4

	if(@nResult_ = @RESULT_SUCCESS)
		begin
			--------------------------------------------------------------
			-- ���� ���� ������ ���� > ���� ȹ���� �͸� ����(������ �ϰ� ���� ������ Ŭ����� �����͸� �������� ������)
			--------------------------------------------------------------
			select * from dbo.tUserItem
			where gameid = @gameid_ and listidx in ( select listidx from @tTempTable )

			--------------------------------------------------------------
			-- ����/���� ����Ʈ ����
			--------------------------------------------------------------
			exec spu_GiftList @gameid_
		end

End

