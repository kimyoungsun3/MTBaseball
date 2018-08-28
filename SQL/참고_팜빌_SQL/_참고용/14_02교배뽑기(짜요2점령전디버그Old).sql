use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVRoulBuyTest', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVRoulBuyTest;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_FVRoulBuyTest
	@gameid_								varchar(60),					-- ���Ӿ��̵�
	@password_								varchar(20),					--
	@idx_									int,							--
	@randserial_							varchar(20),					--
	@mode_									int,
	@friendid_								varchar(20),					--
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
	declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ����.

	-- �����߿� ����.
	declare @RESULT_ERROR_HEART_LACK			int				set @RESULT_ERROR_HEART_LACK			= -20			--��Ʈ�� �����ϴ�.
	declare @RESULT_ERROR_GAMECOST_LACK			int				set @RESULT_ERROR_GAMECOST_LACK			= -21			--�ǹ��� �����ϴ�.
	declare @RESULT_ERROR_CASHCOST_LACK			int				set @RESULT_ERROR_CASHCOST_LACK			= -22			--��尡 �����ϴ�.
	declare @RESULT_ERROR_ITEM_LACK				int				set @RESULT_ERROR_ITEM_LACK				= -23			--�������̺����ϴ�.

	-- ���� �ڵ尪
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- �������ڵ��ã��
	declare @RESULT_ERROR_GIFTITEM_NOT_FOUND	int				set @RESULT_ERROR_GIFTITEM_NOT_FOUND	= -51			-- ������������ ��ã��
	declare @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	int				set @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	= -52			-- ������ �̹� ������
	declare @RESULT_ERROR_NOT_FOUND_GIFTID		int				set @RESULT_ERROR_NOT_FOUND_GIFTID		= -75			-- ĳ�� > ������ ���̵� ��ã��

	-- ��Ÿ����
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- ���������ʴ¸��
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

	-- �����ۺ� �κ��з�
	declare @USERITEM_INVENKIND_ANI				int 				set @USERITEM_INVENKIND_ANI					= 1
	declare @USERITEM_INVENKIND_CONSUME			int 				set @USERITEM_INVENKIND_CONSUME				= 3
	declare @USERITEM_INVENKIND_ACC				int 				set @USERITEM_INVENKIND_ACC					= 4
	declare @USERITEM_INVENKIND_DIRECT			int 				set @USERITEM_INVENKIND_DIRECT				= 40
	declare @USERITEM_INVENKIND_INFO			int 				set @USERITEM_INVENKIND_INFO				= 60
	declare @USERITEM_INVENKIND_PET				int 				set @USERITEM_INVENKIND_PET					= 1000

	-- ���� ���ǰ�
	declare @GIFTLIST_GIFT_KIND_MESSAGE			int					set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2
	declare @GIFTLIST_GIFT_KIND_MESSAGE_DEL		int					set @GIFTLIST_GIFT_KIND_MESSAGE_DEL			= -1
	declare @GIFTLIST_GIFT_KIND_GIFT_DEL		int					set @GIFTLIST_GIFT_KIND_GIFT_DEL			= -2
	declare @GIFTLIST_GIFT_KIND_GIFT_GET		int					set @GIFTLIST_GIFT_KIND_GIFT_GET			= -3
	declare @GIFTLIST_GIFT_KIND_GIFT_SELL		int					set @GIFTLIST_GIFT_KIND_GIFT_SELL			= -4

	-- ����̱� ���.
	declare @MODE_ROULETTE_NORMAL				int					set @MODE_ROULETTE_NORMAL					= 1	-- �Ϲݱ���.
	declare @MODE_ROULETTE_PREMINUM				int					set @MODE_ROULETTE_PREMINUM					= 2	-- �����̾�����.
	declare @CROSS_REWARD_HEART					int					set @CROSS_REWARD_HEART						= 5 -- ����� ���޵Ǵ� ������Ʈ.
	declare @FRIEND_SYSTEM						varchar(20)			set @FRIEND_SYSTEM							= 'farmgirl'

	declare @ITEM_ROULETTE_NOR_MOTHER			int					set @ITEM_ROULETTE_NOR_MOTHER				= 2200	-- �Ϲݱ���̱�.
	declare @ITEM_ROULETTE_PRE_MOTHER			int					set @ITEM_ROULETTE_PRE_MOTHER				= 2300	-- �����̾�����̱�.
	-------------------------------------------------------------------
	-- Event01 [������ ã�ƶ�]
	-- �̺�Ʈ �Ⱓ���� [������ ���]�� ���踦 ���ؼ� ȹ���� ��� ������� ���� 20���� ����
	-- (�ش� ������ ���޵Ǹ� �����̾� ����θ� ���ɴϴ�.)
	-- �� : 2014-05-20 00:01:01 ~ 2014-06-09 23:59:59
	-- �� : 2014-05-09 00:01:01 ~ 2019-06-25 23:59:59
	-- ��¯ ���(213)		-> 5017	90����
	-- ��¯ ��(112) 		-> 5010 20����
	-- ��¯ ����(14)		-> 5009	10����
	-------------------------------------------------------------------
	declare @EVENT01_START_DAY					datetime			set @EVENT01_START_DAY			= '2014-06-09 01:01'
	declare @EVENT01_END_DAY					datetime			set @EVENT01_END_DAY			= '2014-07-24 23:59'

	declare @EVENT01_CHECK_ITEM					int					set @EVENT01_CHECK_ITEM			= 213		-- -> 5017	90����
	declare @EVENT02_CHECK_ITEM					int					set @EVENT02_CHECK_ITEM			= 112		-- -> 5010 	20����
	declare @EVENT03_CHECK_ITEM					int					set @EVENT03_CHECK_ITEM			= 14		-- -> 5009	10����

	declare @EVENT01_REWARD_ITEM				int					set @EVENT01_REWARD_ITEM		= 5017		-- 90����
	declare @EVENT02_REWARD_ITEM				int					set @EVENT02_REWARD_ITEM		= 5010		-- 20����
	declare @EVENT03_REWARD_ITEM				int					set @EVENT03_REWARD_ITEM		= 5009		-- 10����

	-------------------------------------------------------------
	---- EVENT10
	---- ������ �̺�Ʈ.
	---- �����̾� && �̺�Ʈ �Ⱓ���ȿ� Ư�� ������ �������� �Ѵ�..
	---- �Ⱓ : 2014-06-13 00:00 ~ 2014-07-14 23:59
	---- ��� : SKT, Google
	---- 6.23 04:00 �ѱ� vs ������
	---- 6.27 05:00 �ѱ� vs ���⿡
	---- 6.18 07:00 �ѱ� vs ���þ�
	----  13(15%),  14(25%),  15(50%) 			-> 16	 19
	---- 111(25%), 112(40%), 113(60%), 114(90%) 	-> 115	118
	---- 209(25%), 210(40%), 211(50%), 212(100%) 	-> 215	218
	-------------------------------------------------------------
	--declare @EVENT10_START_DAY				datetime			set @EVENT10_START_DAY			= '2014-06-13 20:00'
	--declare @EVENT10_END_DAY					datetime			set @EVENT10_END_DAY			= '2014-07-14 23:59'
    --
	--declare @EVENT10_OLD_COW					int					set @EVENT10_OLD_COW			= 10	-- ���칫�� ����(10)	�ż��� 55	��ü����
	--declare @EVENT10_OLD_SHEEP				int					set @EVENT10_OLD_SHEEP			= 111	-- ��ũ�� ���� ��(111)	�ż��� 75
	--declare @EVENT10_OLD_GOAT					int					set @EVENT10_OLD_GOAT			= 210	-- ������ ���(210)		�ż��� 100
    --
	--declare @EVENT10_NEW_COW					int					set @EVENT10_NEW_COW			= 19	-- �̰� ��!(19)			�ż��� 55 	�űԵ���
	--declare @EVENT10_NEW_SHEEP				int					set @EVENT10_NEW_SHEEP			= 118	-- �¸��Ѱ� ��!(118)	�ż��� 80
	--declare @EVENT10_NEW_GOAT					int					set @EVENT10_NEW_GOAT			= 218	-- �� �̰� ���~(218)	�ż��� 100
    --
	--declare @EVENT10_REWARD_COW				int					set @EVENT10_REWARD_COW			= 5125	-- 1500�� ����(5125)
	--declare @EVENT10_REWARD_SHEEP				int					set @EVENT10_REWARD_SHEEP		= 5010	-- ���� 20(5010)
	--declare @EVENT10_REWARD_GOAT				int					set @EVENT10_REWARD_GOAT		= 5012	-- ���� 40(5012)
    --
	--declare @EVENT10_REWARD_COW_NAME			varchar(40)			set @EVENT10_REWARD_COW_NAME	= '�̰� ��! ����'
	--declare @EVENT10_REWARD_SHEEP_NAME		varchar(40)			set @EVENT10_REWARD_SHEEP_NAME	= '�¸��Ѱ� ��! ����'
	--declare @EVENT10_REWARD_GOAT_NAME			varchar(40)			set @EVENT10_REWARD_GOAT_NAME	= '�� �̰� ���~ ����'

	-------------------------------------------------------------------
	-- Event03 [�����̾� > Ȯ������ �̺�Ʈ]
	-- 2014-07-25 ~ 2014-08-06 23:59
	-- �����̾� ���, �Ϲ��� �ش���� ����.
	-------------------------------------------------------------------
	declare @EVENT03_START_DAY					datetime			set @EVENT03_START_DAY			= '2014-07-24 01:01'
	declare @EVENT03_END_DAY					datetime			set @EVENT03_END_DAY			= '2014-08-06 23:59'

	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @comment				varchar(512)
	declare @gameid					varchar(60)		set @gameid				= ''
	declare @kakaonickname			varchar(40)		set @kakaonickname		= ''
	declare @market					int				set @market				= 1
	declare @version				int				set @version			= 101
	declare @cashcost				int				set @cashcost			= 0
	declare @gamecost				int				set @gamecost 			= 0
	declare @heart					int				set @heart 				= 0
	declare @feed					int				set @feed 				= 0
	declare @randserial				varchar(20)		set @randserial			= ''
	declare @famelv					int

	declare @itemcode				int				set @itemcode			= -1
	declare @pack1					int				set @pack1				= -1
	declare @pack2					int				set @pack2				= -1
	declare @pack3					int				set @pack3				= -1
	declare @pack4					int				set @pack4				= -1
	declare @pack5					int				set @pack5				= -1
	declare @pack6					int				set @pack6				= -1
	declare @pack7					int				set @pack7				= -1
	declare @pack8					int				set @pack8				= -1
	declare @pack9					int				set @pack9				= -1
	declare @pack10					int				set @pack10				= -1
	declare @pack11					int				set @pack11				= -1
	declare @pack12					int				set @pack12				= -1
	declare @pack13					int				set @pack13				= -1
	declare @pack14					int				set @pack14				= -1
	declare @pack15					int				set @pack15				= -1
	declare @pack16					int				set @pack16				= -1
	declare @pack17					int				set @pack17				= -1
	declare @pack18					int				set @pack18				= -1
	declare @pack19					int				set @pack19				= -1
	declare @pack20					int				set @pack20				= -1
	declare @pack21					int				set @pack21				= -1
	declare @pack22					int				set @pack22				= -1
	declare @pack23					int				set @pack23				= -1
	declare @pack24					int				set @pack24				= -1
	declare @pack25					int				set @pack25				= -1
	declare @pack26					int				set @pack26				= -1
	declare @pack27					int				set @pack27				= -1
	declare @pack28					int				set @pack28				= -1
	declare @pack29					int				set @pack29				= -1
	declare @pack30					int				set @pack30				= -1
	declare @pack31					int				set @pack31				= -1
	declare @pack32					int				set @pack32				= -1
	declare @pack33					int				set @pack33				= -1
	declare @pack34					int				set @pack34				= -1
	declare @pack35					int				set @pack35				= -1
	declare @pack36					int				set @pack36				= -1
	declare @pack37					int				set @pack37				= -1
	declare @pack38					int				set @pack38				= -1
	declare @pack39					int				set @pack39				= -1
	declare @pack40					int				set @pack40				= -1
	declare @cashcostsale			int				set @cashcostsale		= 99999
	declare @roulgamecost			int				set @roulgamecost		= 99999
	declare @roulheart				int				set @roulheart			= 99999

	declare @roul1					int				set @roul1				= -1
	declare @roul2					int				set @roul2				= -1
	declare @roul3					int				set @roul3				= -1
	declare @roul4					int				set @roul4				= -1
	declare @roul5					int				set @roul5				= -1

	declare @group1					int,
			@group2					int,
			@group3					int,
			@group4					int,
			@rand					int,
			@rand2					int,
			@rand3					int,
			@pmroulcnt				int,
			@bgroulcnt				int,
			@cnt					int
	declare @grade					int				set @grade				= 0
	declare @pmticket				int				set @pmticket			= 0
	declare @pmticketcnt			int				set @pmticketcnt		= 0

	declare @gameyear				int				set @gameyear			= 2013
	declare @gamemonth				int				set @gamemonth			= 3

	declare @norlistidx				int				set @norlistidx			= -1
	declare @prelistidx				int				set @prelistidx			= -1
	declare @norcnt					int				set @norcnt				= 0
	declare @precnt					int				set @precnt				= 0

	declare @ticket 				int 			set @ticket 			= 0
	declare @curdate				datetime		set @curdate		= getdate()
	declare @famelvmin 				int 			set @famelvmin 			= 1			-- �α���(9��) > �ŷ���(10��) �̱�� 9���� �������ش�. �Ф�
	declare @famelvmax 				int 			set @famelvmax 			= 10
	declare @curhour				int				set @curhour			= -1
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG �Է�����', @gameid_ gameid_, @password_ password_, @idx_ idx_, @randserial_ randserial_, @mode_ mode_, @friendid_ friendid_

	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	select
		@gameid 		= gameid,
		@kakaonickname 	= kakaonickname,
		@market			= market,
		@version		= version,
		@randserial		= randserial,
		@cashcost		= cashcost,
		@gamecost		= gamecost,
		@heart			= heart,
		@feed			= feed,
		@famelv			= famelv,
		@roul1			= bgroul1,
		@roul2			= bgroul2,
		@roul3			= bgroul3,
		@roul4			= bgroul4,
		@roul5			= bgroul5,
		@pmticketcnt	= pmticketcnt,
		@pmroulcnt		= pmroulcnt,
		@bgroulcnt		= bgroulcnt,
		@gameyear		= gameyear,
		@gamemonth		= gamemonth
	from dbo.tFVUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG ��������', @gameid gameid, @cashcost cashcost, @gamecost gamecost, @heart heart, @feed feed, @randserial randserial, @roul1 roul1, @roul2 roul2, @roul3 roul3, @roul4 roul4, @roul5 roul5

	-- ���� ���� �Ϲ�, �����̾�.
	if(@mode_ = @MODE_ROULETTE_PREMINUM)
		begin
			select
				@prelistidx		= listidx,
				@precnt 		= cnt
			from dbo.tFVUserItem
			where gameid = @gameid_ and itemcode = @ITEM_ROULETTE_PRE_MOTHER
			--select 'DEBUG ���� ���� �����̾�', @prelistidx prelistidx, @precnt precnt
		end
	else if(@mode_ = @MODE_ROULETTE_NORMAL)
		begin
			select
				@norlistidx		= listidx,
				@norcnt 		= cnt
			from dbo.tFVUserItem
			where gameid = @gameid_ and itemcode = @ITEM_ROULETTE_NOR_MOTHER
			--select 'DEBUG ���� ���� �Ϲݻ̱�', @norlistidx norlistidx, @norcnt norcnt
		end

	----------------------------------------
	-- �̱� ��ȣ > ���� �ٽ� ����
	-- �α���(9��) > �ŷ���(10��) �̱�� 9���� �������ش�. �Ф�
	-- 9���� ������ ������ �ٽ� ���� > �ٸ� �ε��� ����
	----------------------------------------
	select @famelvmin = famelvmin, @famelvmax = famelvmax from dbo.tFVSystemRoulette where idx = @idx_

	--select top 1 @idx_ = idx from dbo.tFVSystemRoulette
	--where famelvmin = @famelvmin
	--	and famelvmax = @famelvmax
	--	and packstate = 1
	--	order by newid()

	----------------------------------------
	-- �̱�����.
	----------------------------------------
	select
		@itemcode = itemcode,
		@pack1 = pack1,		@pack2 = pack2,		@pack3 = pack3, 	@pack4 = pack4,		@pack5 = pack5,
		@pack6 = pack6,		@pack7= pack7,		@pack8 = pack8, 	@pack9 = pack9,		@pack10 = pack10,

		@pack11 = pack11,	@pack12 = pack12,	@pack13 = pack13, 	@pack14 = pack14,	@pack15 = pack15,
		@pack16 = pack16,	@pack17= pack17,	@pack18 = pack18, 	@pack19 = pack19,	@pack20 = pack20,

		@pack21 = pack21,	@pack22 = pack22,	@pack23 = pack23, 	@pack24 = pack24,	@pack25 = pack25,
		@pack26 = pack26,	@pack27= pack27,	@pack28 = pack28, 	@pack29 = pack29,	@pack30 = pack30,

		@pack31 = pack31,	@pack32 = pack32,	@pack33 = pack33, 	@pack34 = pack34,	@pack35 = pack35,
		@pack36 = pack36,	@pack37= pack37,	@pack38 = pack38, 	@pack39 = pack39,	@pack40 = pack40,

		@roulgamecost = gamecost,				@roulheart = heart, @cashcostsale = cashcostsale
	from dbo.tFVSystemRoulette
	where famelvmin = @famelvmin
		  and famelvmax = @famelvmax
		  and packstate = 1
		  order by newid()
	--from dbo.tFVSystemRoulette where idx = @idx_
	--select 'DEBUG �̱�����', @pack1 pack1, @pack2 pack2, @pack3 pack3, @pack4 pack4, @pack5 pack5, @pack6 pack6, @pack7 pack7, @pack8 pack8, @pack9 pack9, @pack10 pack10, @pack11 pack11, @pack12 pack12, @pack13 pack13, @pack14 pack14, @pack15 pack15, @pack16 pack16, @pack17 pack17, @pack18 pack18, @pack19 pack19, @pack20 pack20, @pack21 pack21, @pack22 pack22, @pack23 pack23, @pack24 pack24, @pack25 pack25, @pack26 pack26, @pack27 pack27, @pack28 pack28, @pack29 pack29, @pack30 pack30, @pack31 pack31, @pack32 pack32, @pack33 pack33, @pack34 pack34, @pack35 pack35, @pack36 pack36, @pack37 pack37, @pack38 pack38, @pack39 pack39, @pack40 pack40, @roulgamecost gamecost, @roulheart heart, @cashcostsale cashcostsale

	------------------------------------------------
	--	3-3. ����Ȳ���� �ڵ�� �з�
	------------------------------------------------
	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR ���̵� �������� �ʴ´�.'
			--select 'DEBUG ' + @comment
		END
	else if (@itemcode = -1)
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_ITEMCODE
			set @comment = 'ERROR �ڵ带 ã���� �����ϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if (@gameid_ != '' and @gameid_ = @friendid_)
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment = 'ERROR �ڽŰ��� ���谡 �ȵ˴ϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if (@mode_ not in (@MODE_ROULETTE_NORMAL, @MODE_ROULETTE_PREMINUM))
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment = 'ERROR �������� �ʴ� ����Դϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if (@mode_ = @MODE_ROULETTE_NORMAL and (@gamecost < @roulgamecost and @norcnt <= 0))
		BEGIN
			set @nResult_ = @RESULT_ERROR_GAMECOST_LACK
			set @comment = 'ERROR ���������� �����մϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if (@mode_ = @MODE_ROULETTE_NORMAL and (@heart < @roulheart and @norcnt <= 0))
		BEGIN
			set @nResult_ = @RESULT_ERROR_HEART_LACK
			set @comment = 'ERROR ��Ʈ�� �����ϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if (@mode_ = @MODE_ROULETTE_PREMINUM and (@cashcost < @cashcostsale and @precnt <= 0))
		BEGIN
			set @nResult_ = @RESULT_ERROR_CASHCOST_LACK
			set @comment = 'ERROR ĳ���� �����մϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if (@randserial_ = @randserial)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '����̱� �����ϱ�(2)'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '����̱� �����ϱ�(1)'
			--select 'DEBUG ', @comment

			-- �ð��� ������.
			set @curhour = DATEPART(Hour, getdate())

			--------------------------------
			-- �����ϱ�.
			--------------------------------
			if(@mode_ = @MODE_ROULETTE_PREMINUM)
				begin
					-- 1����.
					--set @group1 		= 0 	* 100
					--set @group2		= 83	* 100
					--set @group3		= 14	* 100
					--set @group4		= 3		* 100

					--select 'DEBUG �����̾�����.'
					-- 2�� �� �׷��̵�.
					set @group1 	=    0
					set @group2		=    0
					set @group3		= 9800
					set @group4		=  200
					if(@curdate >= @EVENT03_START_DAY and @curdate <= @EVENT03_END_DAY)
						begin
							if(@curhour in (12, 18, 23))
								begin
									set @group3		= 9800 - 200
									set @group4		=  200 + 200
								end
						end

					if(@precnt > 0)
						begin
							------------------------
							-- ���Ź�ȣ.
							------------------------
							exec spu_FVUserItemBuyLog @gameid_, @itemcode,                 0, 0
							exec spu_FVUserItemBuyLog @gameid_, @ITEM_ROULETTE_PRE_MOTHER, 0, 0

							--------------------------------
							-- ���� ��������.
							--------------------------------
							exec spu_FVDayLogInfoStatic @market, 22, 1			-- �� ����̱�

							---------------------------------
							-- Ƽ�� > ����.
							---------------------------------
							set @precnt = @precnt - 1
							set @ticket = 1
							--select 'DEBUG > �����̾�(0), ĳ��(x) > �����̾�(0)', @precnt precnt

							update dbo.tFVUserItem
								set
									cnt = @precnt
							where gameid = @gameid_ and itemcode = @ITEM_ROULETTE_PRE_MOTHER

							-----------------------------------
							---- ��µǴ� ��������.
							-----------------------------------
							if(@pmticketcnt <= 6)		--if(@pmticketcnt <= 0)
								begin
									--select 'DEBUG Ƽ�� ó��'
									set @cnt	= 1
								end
							else
								begin
									--select 'DEBUG Ƽ�� ���� ����'
									-----------------------------------
									---- ��µǴ� ��������.
									-----------------------------------
									set @rand 		= Convert(int, ceiling(RAND() * 1000))
									set @cnt	= case
													when @rand < 850 then 1
													when @rand < 960 then 2
													when @rand < 990 then 3
													when @rand < 997 then 4
													else				  5
												  end
								end

							set @pmticket = 1
						end
					else
						begin
							------------------------
							-- ���Ź�ȣ.
							------------------------
							exec spu_FVUserItemBuyLog @gameid_, @itemcode, 0, @cashcostsale

							--------------------------------
							-- ���� ��������.
							--------------------------------
							exec spu_FVDayLogInfoStatic @market, 22, 1			-- �� ����̱�

							---------------------------------
							-- ĳ�� > �ϴܿ��� ������.
							---------------------------------
							set @cashcost = @cashcost 	- @cashcostsale


							-----------------------------------
							---- ��µǴ� ��������.
							-----------------------------------
							set @rand 		= Convert(int, ceiling(RAND() * 1000))
							set @cnt	= case
											when @rand < 850 then 1
											when @rand < 960 then 2
											when @rand < 990 then 3
											when @rand < 997 then 4
											else				  5
										  end
							set @pmticket = 0
						end

				end
			else
				begin
					--select 'DEBUG �Ϲݱ���.'
					set @group1 	= 9800
					set @group2		=  200
					set @group3		=    0
					set @group4		=    0

					if(@norcnt > 0)
						begin
							------------------------
							-- ���Ź�ȣ.
							------------------------
							exec spu_FVUserItemBuyLog @gameid_, @itemcode,                 0, 0
							exec spu_FVUserItemBuyLog @gameid_, @ITEM_ROULETTE_NOR_MOTHER, 0, 0

							--------------------------------
							-- ���� ��������.
							--------------------------------
							exec spu_FVDayLogInfoStatic @market, 21, 1				-- �� �Ϲݻ̱�

							---------------------------------
							-- Ƽ�� > ����.
							---------------------------------
							set @norcnt = @norcnt - 1
							set @ticket = 1
							--select 'DEBUG > �Ϲݻ̱�(0), ĳ��(x) > �Ϲݻ̱�(0)', @norcnt norcnt

							update dbo.tFVUserItem
								set
									cnt = @norcnt
							where gameid = @gameid_ and itemcode = @ITEM_ROULETTE_NOR_MOTHER

							---------------------------------
							-- ���� ���� ����
							---------------------------------
							set @grade = -1
						end
					else
						begin
							------------------------
							-- ���Ź�ȣ.
							------------------------
							exec spu_FVUserItemBuyLog @gameid_, @itemcode, @roulgamecost, 0

							--------------------------------
							-- ���� ��������.
							--------------------------------
							exec spu_FVDayLogInfoStatic @market, 20, @roulheart		-- �� ��Ʈ����
							exec spu_FVDayLogInfoStatic @market, 21, 1				-- �� �Ϲݻ̱�

							---------------------------------
							-- ����, ��Ʈ > �ϴܿ��� ������.
							---------------------------------
							set @gamecost 	= @gamecost 	- @roulgamecost
							set @heart 		= @heart 		- @roulheart

							---------------------------------
							-- ���� ���� ���� > ģ���� ������ ���� ��µǴ� ��������.
							---------------------------------
							if(@friendid_ = @FRIEND_SYSTEM)
								begin
									set @grade = 0
								end
							else
								begin
									select @grade = param1 from dbo.tFVItemInfo
									where itemcode = (select top 1 itemcode from dbo.tFVUserItem
													  where gameid = @friendid_ and invenkind = @USERITEM_INVENKIND_ANI
														    and listidx = (select top 1 anireplistidx from dbo.tFVUserMaster where gameid = @friendid_))
								end
						end



					-----------------------------------
					---- ��µǴ� ��������.
					-----------------------------------
					set @rand 		= Convert(int, ceiling(RAND() * 1000))
					set @cnt	= case
										when @rand < 850 then 1
										when @rand < 960 then 2
										when @rand < 990 then 3
										when @rand < 997 then 4
										else				  5
								  end
				end

			------------------------------------
			-- ������ ���� �Ѱ��� ����
			------------------------------------
			--set @cnt = 1

			set @rand 		= Convert(int, ceiling(RAND() * 10000))
			set @rand2		= Convert(int, ceiling(RAND() *    10))
			set @roul1 		= dbo.fnu_GetFVCrossRandom(@rand, @rand2, 	@group1, @group2, @group3, @group4,      @pack1,  @pack2,  @pack3,  @pack4,  @pack5,  @pack6,  @pack7,  @pack8,  @pack9, @pack10,
																												@pack11, @pack12, @pack13, @pack14, @pack15, @pack16, @pack17, @pack18, @pack19, @pack20,
																												@pack21, @pack22, @pack23, @pack24, @pack25, @pack26, @pack27, @pack28, @pack29, @pack30,
																												@pack31, @pack32, @pack33, @pack34, @pack35, @pack36, @pack37, @pack38, @pack39, @pack40)

			set @rand 		= Convert(int, ceiling(RAND() * 10000))
			set @rand2		= Convert(int, ceiling(RAND() *    10))
			set @roul2 		= dbo.fnu_GetFVCrossRandom(@rand, @rand2, 	@group1, @group2, @group3, @group4,     @pack1,  @pack2,  @pack3,  @pack4,  @pack5,  @pack6,  @pack7,  @pack8,  @pack9, @pack10,
																												@pack11, @pack12, @pack13, @pack14, @pack15, @pack16, @pack17, @pack18, @pack19, @pack20,
																												@pack21, @pack22, @pack23, @pack24, @pack25, @pack26, @pack27, @pack28, @pack29, @pack30,
																												@pack31, @pack32, @pack33, @pack34, @pack35, @pack36, @pack37, @pack38, @pack39, @pack40)

			set @rand 		= Convert(int, ceiling(RAND() * 10000))
			set @rand2		= Convert(int, ceiling(RAND() *    10))
			set @roul3 		= dbo.fnu_GetFVCrossRandom(@rand, @rand2, 	@group1, @group2, @group3, @group4,     @pack1,  @pack2,  @pack3,  @pack4,  @pack5,  @pack6,  @pack7,  @pack8,  @pack9, @pack10,
																												@pack11, @pack12, @pack13, @pack14, @pack15, @pack16, @pack17, @pack18, @pack19, @pack20,
																												@pack21, @pack22, @pack23, @pack24, @pack25, @pack26, @pack27, @pack28, @pack29, @pack30,
																												@pack31, @pack32, @pack33, @pack34, @pack35, @pack36, @pack37, @pack38, @pack39, @pack40)

			set @rand 		= Convert(int, ceiling(RAND() * 10000))
			set @rand2		= Convert(int, ceiling(RAND() *    105))
			set @roul4 		= dbo.fnu_GetFVCrossRandom(@rand, @rand2, 	@group1, @group2, @group3, @group4,    @pack1,  @pack2,  @pack3,  @pack4,  @pack5,  @pack6,  @pack7,  @pack8,  @pack9, @pack10,
																												@pack11, @pack12, @pack13, @pack14, @pack15, @pack16, @pack17, @pack18, @pack19, @pack20,
																												@pack21, @pack22, @pack23, @pack24, @pack25, @pack26, @pack27, @pack28, @pack29, @pack30,
																												@pack31, @pack32, @pack33, @pack34, @pack35, @pack36, @pack37, @pack38, @pack39, @pack40)

			set @rand 		= Convert(int, ceiling(RAND() * 10000))
			set @rand2		= Convert(int, ceiling(RAND() *    10))
			set @roul5 		= dbo.fnu_GetFVCrossRandom(@rand, @rand2, 	@group1, @group2, @group3, @group4,    @pack1,  @pack2,  @pack3,  @pack4,  @pack5,  @pack6,  @pack7,  @pack8,  @pack9, @pack10,
																												@pack11, @pack12, @pack13, @pack14, @pack15, @pack16, @pack17, @pack18, @pack19, @pack20,
																												@pack21, @pack22, @pack23, @pack24, @pack25, @pack26, @pack27, @pack28, @pack29, @pack30,
																												@pack31, @pack32, @pack33, @pack34, @pack35, @pack36, @pack37, @pack38, @pack39, @pack40)

			----------------------------------
			-- EVENT10
			-- @@@@ ����1
			-- Ư�� ���Ͽ����� ������ �ȳ������� �Ѵ�.
			-- ���� : @MARKET_GOOGLE, @MARKET_SKT, @MARKET_IPHONE
			----------------------------------
			--if(@market in (@MARKET_IPHONE))
			--	begin
			--		set @roul1 = case
			--						when @roul1 = @EVENT10_NEW_COW 		then @EVENT10_OLD_COW
			--						when @roul1 = @EVENT10_NEW_SHEEP 	then @EVENT10_OLD_SHEEP
			--						when @roul1 = @EVENT10_NEW_GOAT 	then @EVENT10_OLD_GOAT
			--						else @roul1
			--					end
			--		set @roul2 = case
			--						when @roul2 = @EVENT10_NEW_COW 		then @EVENT10_OLD_COW
			--						when @roul2 = @EVENT10_NEW_SHEEP 	then @EVENT10_OLD_SHEEP
			--						when @roul2 = @EVENT10_NEW_GOAT 	then @EVENT10_OLD_GOAT
			--						else @roul2
			--					end
			--		set @roul3 = case
			--						when @roul3 = @EVENT10_NEW_COW 		then @EVENT10_OLD_COW
			--						when @roul3 = @EVENT10_NEW_SHEEP 	then @EVENT10_OLD_SHEEP
			--						when @roul3 = @EVENT10_NEW_GOAT 	then @EVENT10_OLD_GOAT
			--						else @roul3
			--					end
			--		set @roul4 = case
			--						when @roul4 = @EVENT10_NEW_COW 		then @EVENT10_OLD_COW
			--						when @roul4 = @EVENT10_NEW_SHEEP 	then @EVENT10_OLD_SHEEP
			--						when @roul4 = @EVENT10_NEW_GOAT 	then @EVENT10_OLD_GOAT
			--						else @roul4
			--					end
			--		set @roul5 = case
			--						when @roul5 = @EVENT10_NEW_COW 		then @EVENT10_OLD_COW
			--						when @roul5 = @EVENT10_NEW_SHEEP 	then @EVENT10_OLD_SHEEP
			--						when @roul5 = @EVENT10_NEW_GOAT 	then @EVENT10_OLD_GOAT
			--						else @roul5
			--					end
			--	end
			--else
			--	begin
			--		if(@curdate >= @EVENT10_START_DAY and @curdate <= @EVENT10_END_DAY)
			--			begin
			--				set @rand3	= Convert(int, ceiling(RAND() * 1000))
			--				if(@roul1 in (5, 106, 204, 14, 111, 16, 112, 210, 115))
			--					begin
			--						set @roul1 = case
			--										when @roul1 =  5  and @rand3 < 50		then @EVENT10_NEW_COW	-- ����.
			--										when @roul1 = 106 and @rand3 < 50 		then @EVENT10_NEW_COW
			--										when @roul1 = 204 and @rand3 < 50	 	then @EVENT10_NEW_COW
			--										when @roul1 = 14  and @rand3 < 50	 	then @EVENT10_NEW_SHEEP	-- ��.
			--										when @roul1 = 111 and @rand3 < 50	 	then @EVENT10_NEW_SHEEP
			--										when @roul1 = 116 and @rand3 < 50	 	then @EVENT10_NEW_SHEEP
			--										when @roul1 = 112 and @rand3 < 60	 	then @EVENT10_NEW_GOAT	-- ���.
			--										when @roul1 = 210 and @rand3 < 60	 	then @EVENT10_NEW_GOAT
			--										when @roul1 = 115 and @rand3 < 60	 	then @EVENT10_NEW_GOAT
			--										else @roul1
			--									end
			--					end
            --
			--				if(@roul2 in (5, 106, 204, 14, 111, 16, 112, 210, 115))
			--					begin
			--						set @roul2 = case
			--										when @roul2 =  5  and @rand3 < 50		then @EVENT10_NEW_COW	-- ����.
			--										when @roul2 = 106 and @rand3 < 50 		then @EVENT10_NEW_COW
			--										when @roul2 = 204 and @rand3 < 50	 	then @EVENT10_NEW_COW
			--										when @roul2 = 14  and @rand3 < 50	 	then @EVENT10_NEW_SHEEP	-- ��.
			--										when @roul2 = 111 and @rand3 < 50	 	then @EVENT10_NEW_SHEEP
			--										when @roul2 = 116 and @rand3 < 50	 	then @EVENT10_NEW_SHEEP
			--										when @roul2 = 112 and @rand3 < 60	 	then @EVENT10_NEW_GOAT	-- ���.
			--										when @roul2 = 210 and @rand3 < 60	 	then @EVENT10_NEW_GOAT
			--										when @roul2 = 115 and @rand3 < 60	 	then @EVENT10_NEW_GOAT
			--										else @roul2
			--									end
			--					end
            --
			--				if(@roul3 in (5, 106, 204, 14, 111, 16, 112, 210, 115))
			--					begin
			--						set @roul3 = case
			--										when @roul3 =  5  and @rand3 < 50		then @EVENT10_NEW_COW	-- ����.
			--										when @roul3 = 106 and @rand3 < 50 		then @EVENT10_NEW_COW
			--										when @roul3 = 204 and @rand3 < 50	 	then @EVENT10_NEW_COW
			--										when @roul3 = 14  and @rand3 < 50	 	then @EVENT10_NEW_SHEEP	-- ��.
			--										when @roul3 = 111 and @rand3 < 50	 	then @EVENT10_NEW_SHEEP
			--										when @roul3 = 116 and @rand3 < 50	 	then @EVENT10_NEW_SHEEP
			--										when @roul3 = 112 and @rand3 < 60	 	then @EVENT10_NEW_GOAT	-- ���.
			--										when @roul3 = 210 and @rand3 < 60	 	then @EVENT10_NEW_GOAT
			--										when @roul3 = 115 and @rand3 < 60	 	then @EVENT10_NEW_GOAT
			--										else @roul3
			--									end
			--					end
            --
			--				if(@roul4 in (5, 106, 204, 14, 111, 16, 112, 210, 115))
			--					begin
			--						set @roul4 = case
			--										when @roul4 =  5  and @rand3 < 50		then @EVENT10_NEW_COW	-- ����.
			--										when @roul4 = 106 and @rand3 < 50 		then @EVENT10_NEW_COW
			--										when @roul4 = 204 and @rand3 < 50	 	then @EVENT10_NEW_COW
			--										when @roul4 = 14  and @rand3 < 50	 	then @EVENT10_NEW_SHEEP	-- ��.
			--										when @roul4 = 111 and @rand3 < 50	 	then @EVENT10_NEW_SHEEP
			--										when @roul4 = 116 and @rand3 < 50	 	then @EVENT10_NEW_SHEEP
			--										when @roul4 = 112 and @rand3 < 60	 	then @EVENT10_NEW_GOAT	-- ���.
			--										when @roul4 = 210 and @rand3 < 60	 	then @EVENT10_NEW_GOAT
			--										when @roul4 = 115 and @rand3 < 60	 	then @EVENT10_NEW_GOAT
			--										else @roul4
			--									end
			--					end
            --
			--				if(@roul5 in (5, 106, 204, 14, 111, 16, 112, 210, 115))
			--					begin
			--						set @roul5 = case
			--										when @roul5 =  5  and @rand3 < 50		then @EVENT10_NEW_COW	-- ����.
			--										when @roul5 = 106 and @rand3 < 50 		then @EVENT10_NEW_COW
			--										when @roul5 = 204 and @rand3 < 50	 	then @EVENT10_NEW_COW
			--										when @roul5 = 14  and @rand3 < 50	 	then @EVENT10_NEW_SHEEP	-- ��.
			--										when @roul5 = 111 and @rand3 < 50	 	then @EVENT10_NEW_SHEEP
			--										when @roul5 = 116 and @rand3 < 50	 	then @EVENT10_NEW_SHEEP
			--										when @roul5 = 112 and @rand3 < 60	 	then @EVENT10_NEW_GOAT	-- ���.
			--										when @roul5 = 210 and @rand3 < 60	 	then @EVENT10_NEW_GOAT
			--										when @roul5 = 115 and @rand3 < 60	 	then @EVENT10_NEW_GOAT
			--										else @roul5
			--									end
			--					end
			--			end
			--	end

			----------------------------------
			-- @@@@ ����2
			-- 24, 25, 26, 27, 28, 29 / 122, 123, 124, 125, 126, 127 / 222, 223, 224, 225, 226, 227
			-- Ư�� ���Ͽ��� ���� �������� �Ѵ�.
			-- ���� : @MARKET_GOOGLE, @MARKET_SKT, @MARKET_IPHONE, @MARKET_NHN
			----------------------------------
			if(    (@market = @MARKET_SKT    and @version <= 113)
				or (@market = @MARKET_GOOGLE and @version <= 119)
				or (@market = @MARKET_NHN    and @version <= 107)
				or (@market = @MARKET_IPHONE and @version <= 116))
					begin
						set @roul1 = case
										when @roul1 >=  24 and @roul1 <  99	then  15
										when @roul1 >= 122 and @roul1 < 199	then 114
										when @roul1 >= 222 and @roul1 < 299	then 212
										else @roul1
									end
						set @roul2 = case
										when @roul2 >=  24 and @roul2 <  99	then  15
										when @roul2 >= 122 and @roul2 < 199	then 114
										when @roul2 >= 222 and @roul2 < 299	then 212
										else @roul2
									end
						set @roul3 = case
										when @roul3 >=  24 and @roul3 <  99	then  15
										when @roul3 >= 122 and @roul3 < 199	then 114
										when @roul3 >= 222 and @roul3 < 299	then 212
										else @roul3
									end
						set @roul4 = case
										when @roul4 >=  24 and @roul4 <  99	then  15
										when @roul4 >= 122 and @roul4 < 199	then 114
										when @roul4 >= 222 and @roul4 < 299	then 212
										else @roul4
									end
						set @roul5 = case
										when @roul5 >=  24 and @roul5 <  99	then  15
										when @roul5 >= 122 and @roul5 < 199	then 114
										when @roul5 >= 222 and @roul5 < 299	then 212
										else @roul5
									end
					end

			----------------------------------
			-- ���� ���� �ϱ�.
			----------------------------------
			if(@cnt = 1)
				begin
					--set @roul1 		= -1
					set @roul2 			= -1
					set @roul3 			= -1
					set @roul4 			= -1
					set @roul5 			= -1
				end
			else if(@cnt = 2)
				begin
					--set @roul1 		= -1
					--set @roul2 		= -1
					set @roul3 			= -1
					set @roul4 			= -1
					set @roul5 			= -1
				end
			else if(@cnt = 3)
				begin
					--set @roul1 		= -1
					--set @roul2 		= -1
					--set @roul3 		= -1
					set @roul4 			= -1
					set @roul5 			= -1
				end
			else if(@cnt = 4)
				begin
					--set @roul1 		= -1
					--set @roul2 		= -1
					--set @roul3 		= -1
					--set @roul4 		= -1
					set @roul5 			= -1
				end

			--------------------------------------------
			-- ����̱� 1,2��, 5��°�� ���ϸ� ������.
			-- �̱��� ���������� �ּ� ������ ����.
			--------------------------------------------
			if(@mode_ = @MODE_ROULETTE_PREMINUM)
				begin
					set @pmroulcnt	= @pmroulcnt + 1

					if(@pmticket = 1)
						begin
							set @pmticketcnt = @pmticketcnt + 1
						end
				end
			else
				begin
					set @bgroulcnt	= @bgroulcnt + 1
				end

			if(@mode_ = @MODE_ROULETTE_PREMINUM and @pmticket = 1 and @pmticketcnt <= 1)
				begin
					-- �����̾� 60 ~ 60 (11, 108, 206)
					-- 60 : 11, 108, 206, 11, 108, 206, 11, 108, 206, 11
					-- 55 : 205, 107, 10, 205, 107, 10, 205, 107, 10, 10
					set @rand 	= Convert(int, ceiling(RAND() * 100))
					set @roul1	= dbo.fnu_GetFVCrossRandom2(@rand, 	205, 107, 10, 205, 107, 10, 205, 107, 10, 10)
				end
			--else if(@mode_ = @MODE_ROULETTE_PREMINUM and @pmticket = 1 and @pmticketcnt <= 6)
			--	begin
			--		-----------------------------------------------------
			--		-- �����̾� Ƽ���� Ǯ���� �����Ѵ�.
			--		-- 5�� ���� ������ Ǯ��.
			--		-----------------------------------------------------
			--		set @rand 	= Convert(int, ceiling(RAND() * 100))
			--		set @roul1	= dbo.fnu_GetFVCrossRandom2(@rand, 	205, 206, 11, 108, 109, 12, 207, 208, 110, 111)
			--	end
			else if(@mode_ = @MODE_ROULETTE_NORMAL and @bgroulcnt in (1, 2, 5) and @famelv <= 20)
				begin
					if(@famelv <= 10)
						begin
							-- �ż��� 15 ~ 25
							set @rand 	= Convert(int, ceiling(RAND() * 100))
							set @roul1	= dbo.fnu_GetFVCrossRandom2(@rand, 	2, 3, 100, 101, 4, 2, 3, 100, 101, 4)
						end
					else
						begin
							-- �ż��� 20 ~ 35
							set @rand 	= Convert(int, ceiling(RAND() * 100))
							set @roul1	= dbo.fnu_GetFVCrossRandom2(@rand, 	3, 100, 101, 4, 5, 102, 200, 201, 103, 6)

						end
				end
			else if(not ((@roul1 >= 1 and @roul1 < 299)	or (@roul2 >= 1 and @roul2 < 299)	or (@roul3 >= 1 and @roul3 < 299)	or (@roul4 >= 1 and @roul4 < 299)	or (@roul5 >= 1 and @roul5 < 299)))
					begin
						if(@mode_ = @MODE_ROULETTE_NORMAL)
							begin
								--select 'DEBUG (�Ϲݱ���)������ ��� �ʱ� ������ ��������('
								set @roul1 = dbo.fnu_GetFVFindAnimal(@mode_, @pack1,  @pack2,  @pack3,  @pack4,  @pack5,  @pack6,  @pack7,  @pack8,  @pack9, @pack10,
																			@pack11, @pack12, @pack13, @pack14, @pack15, @pack16, @pack17, @pack18, @pack19, @pack20,
																			@pack21, @pack22, @pack23, @pack24, @pack25, @pack26, @pack27, @pack28, @pack29, @pack30,
																			@pack31, @pack32, @pack33, @pack34, @pack35, @pack36, @pack37, @pack38, @pack39, @pack40)

							end
						else
							begin
								--select 'DEBUG (��������)������ ��� �ʱ� ������ ��������('
								set @roul1 = dbo.fnu_GetFVFindAnimal(@mode_, @pack1,  @pack2,  @pack3,  @pack4,  @pack5,  @pack6,  @pack7,  @pack8,  @pack9, @pack10,
																			@pack11, @pack12, @pack13, @pack14, @pack15, @pack16, @pack17, @pack18, @pack19, @pack20,
																			@pack21, @pack22, @pack23, @pack24, @pack25, @pack26, @pack27, @pack28, @pack29, @pack30,
																			@pack31, @pack32, @pack33, @pack34, @pack35, @pack36, @pack37, @pack38, @pack39, @pack40)
							end
					end
			--if(not 									  ((@roul2 >= 1 and @roul2 < 299)	or (@roul3 >= 1 and @roul3 < 299)	or (@roul4 >= 1 and @roul4 < 299)	or (@roul5 >= 1 and @roul5 < 299)))
			--		begin
			--			set @roul2 = @pack2
			--		end

			------------------------------------------------------------------
			-- ����̱⸦ �����Կ� �־��ֱ�.
			------------------------------------------------------------------
			--select 'DEBUG ����̱� ��������(������ �ڵ����� �н���)', @roul1 roul1, @roul2 roul2, @roul3 roul3, @roul4 roul4, @roul5 roul5
			exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @roul5, 'SysRoul', @gameid_, ''
			exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @roul4, 'SysRoul', @gameid_, ''
			exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @roul3, 'SysRoul', @gameid_, ''
			exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @roul2, 'SysRoul', @gameid_, ''
			exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @roul1, 'SysRoul', @gameid_, ''

			------------------------------------------------------------------
			-- �̺�Ʈ ��¥ > Ư������ > ��������1
			------------------------------------------------------------------
			--select 'DEBUG ', @curdate curdate, @EVENT01_START_DAY EVENT01_START_DAY, @EVENT01_END_DAY EVENT01_END_DAY, @EVENT01_CHECK_ITEM EVENT01_CHECK_ITEM, @roul1 roul1, @roul2 roul2, @roul3 roul3, @roul4 roul4, @roul5 roul5
			if(@curdate >= @EVENT01_START_DAY and @curdate <= @EVENT01_END_DAY)
				begin
					--select 'DEBUG > �̺�Ʈ �Ⱓ��'
					if(@EVENT01_CHECK_ITEM in (@roul1, @roul2, @roul3, @roul4, @roul5))
						begin
							--select 'DEBUG > 	-> 5017	90����'
							exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @EVENT01_REWARD_ITEM, '��¯ ��纸��', @gameid_, ''
						end
					else if(@EVENT02_CHECK_ITEM in (@roul1, @roul2, @roul3, @roul4, @roul5))
						begin
							--select 'DEBUG >  	-> 5010 20����'
							exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @EVENT02_REWARD_ITEM, '��¯ �纸��', @gameid_, ''
						end
					else if(@EVENT03_CHECK_ITEM in (@roul1, @roul2, @roul3, @roul4, @roul5))
						begin
							--select 'DEBUG > 	-> 5007	 5����'
							exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @EVENT03_REWARD_ITEM, '��¯ ���Һ���', @gameid_, ''
						end
				end

			--------------------------------------------------------------------
			---- ������ �̺�Ʈ.
			---- EVENT10
			---- �̺�Ʈ ��¥ > Ư������ > ��������2
			--------------------------------------------------------------------
			--if(@curdate >= @EVENT10_START_DAY and @curdate <= @EVENT10_END_DAY)
			--	begin
			--		--select 'DEBUG > �̺�Ʈ �Ⱓ��2', @EVENT10_START_DAY, @EVENT10_END_DAY
			--		if(@EVENT10_NEW_GOAT in (@roul1, @roul2, @roul3, @roul4, @roul5))
			--			begin
			--				--select 'DEBUG ->', @EVENT10_REWARD_GOAT_NAME, itemname, itemcode from dbo.tFVItemInfo where itemcode = @EVENT10_REWARD_GOAT
			--				exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @EVENT10_REWARD_GOAT, @EVENT10_REWARD_GOAT_NAME, @gameid_, ''
			--			end
			--		else if(@EVENT10_NEW_SHEEP in (@roul1, @roul2, @roul3, @roul4, @roul5))
			--			begin
			--				--select 'DEBUG ->', @EVENT10_REWARD_SHEEP_NAME, itemname, itemcode from dbo.tFVItemInfo where itemcode = @EVENT10_REWARD_SHEEP
			--				exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @EVENT10_REWARD_SHEEP, @EVENT10_REWARD_SHEEP_NAME, @gameid_, ''
			--			end
			--		else if(@EVENT10_NEW_COW in (@roul1, @roul2, @roul3, @roul4, @roul5))
			--			begin
			--				--select 'DEBUG ->', @EVENT10_REWARD_COW_NAME, itemname, itemcode from dbo.tFVItemInfo where itemcode = @EVENT10_REWARD_COW
			--				exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @EVENT10_REWARD_COW, @EVENT10_REWARD_COW_NAME, @gameid_, ''
			--			end
			--	end

			------------------------------------------------------------------
			-- ���� �����ϱ�.
			------------------------------------------------------------------
			--exec spu_FVRoulAdLog @gameid_, @kakaonickname, @mode_, @roul1, @roul2, @roul3, @roul4, @roul5
			--set @rand3	= Convert(int, ceiling(RAND() * 100))
			--if((@mode_ = @MODE_ROULETTE_PREMINUM) or (@mode_ != @MODE_ROULETTE_PREMINUM and @rand3 < 10))
			--	begin
			--		exec spu_FVRoulAdLog @gameid_, @kakaonickname, @mode_, @roul1, @roul2, @roul3, @roul4, @roul5
			--	end

			------------------------------------------------------------------
			-- ��������ϱ�.
			------------------------------------------------------------------
			if(@roul1 != -1)
				begin
					exec spu_FVDogamListLog @gameid_, @roul1
				end
			if(@roul2 != -1)
				begin
					exec spu_FVDogamListLog @gameid_, @roul2
				end
			if(@roul3 != -1)
				begin
					exec spu_FVDogamListLog @gameid_, @roul3
				end
			if(@roul4 != -1)
				begin
					exec spu_FVDogamListLog @gameid_, @roul4
				end
			if(@roul5 != -1)
				begin
					exec spu_FVDogamListLog @gameid_, @roul5
				end

			--------------------------------
			-- ���濡�� ��Ʈ�����ϱ�(��Ʈ).
			--------------------------------
			update dbo.tFVUserMaster
				set
					heart = case
								when heart >= heartmax 							then heart
								when (heart +  @CROSS_REWARD_HEART) >= heartmax	then heartmax
								else (heart +  @CROSS_REWARD_HEART)
							end,
					heartget = heartget + case
												when heart >= heartmax 							then 0
												when (heart +  @CROSS_REWARD_HEART) >= heartmax	then (heartmax - (heart +  @CROSS_REWARD_HEART))
												else                                                 @CROSS_REWARD_HEART
											end
			where gameid = @friendid_


			--------------------------------
			-- �̱� �α� ���.
			-- exec spu_FVUserItemRoulLog 'xxxx2', 1, 1, 60045,  0, 400, 200,	1,   -1, -1, -1, -1, 2013, 3, 'xxxx3'	-- �Ϲ�
			-- exec spu_FVUserItemRoulLog 'xxxx2', 2, 1, 60045, 20,   0,   0,	8, 1455, -1, -1, -1, 2013, 3, 'xxxx3'	-- �����̾�
			--------------------------------
			if(@ticket = 1)
				begin
					set @cashcostsale 	= 0
					set @roulgamecost 	= 0
					set @roulheart 		= 0
				end

			if(@mode_ = @MODE_ROULETTE_PREMINUM)
				begin
					exec spu_FVUserItemRoulLog @gameid_, @mode_, @famelv, @itemcode, @cashcostsale,             0,          0, @roul1, @roul2, @roul3, @roul4, @roul5, @gameyear, @gamemonth, @friendid_
				end
			else
				begin
					exec spu_FVUserItemRoulLog @gameid_, @mode_, @famelv, @itemcode,            0, @roulgamecost, @roulheart, @roul1, @roul2, @roul3, @roul4, @roul5, @gameyear, @gamemonth, @friendid_
				end
		END

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	--select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost, @heart heart, @feed feed, @roul1 roul1, @roul2 roul2, @roul3 roul3, @roul4 roul4, @roul5 roul5

	if(@nResult_ = @RESULT_SUCCESS)
		begin
			-- �������� ���� �־���
			update dbo.tFVUserMaster
				set
					randserial	= @randserial_,
					cashcost	= @cashcost,
					gamecost	= @gamecost,
					heart		= @heart,
					feed		= @feed,
					bgroul1		= @roul1,
					bgroul2		= @roul2,
					bgroul3		= @roul3,
					bgroul4		= @roul4,
					bgroul5		= @roul5,
					pmticketcnt	= @pmticketcnt,
					pmroulcnt	= @pmroulcnt,
					bgroulcnt	= @bgroulcnt,
					bkcrossnormal	= bkcrossnormal 	+ case when (@mode_ = @MODE_ROULETTE_NORMAL) 	then 1 else 0 end,
					bkcrosspremium	= bkcrosspremium 	+ case when (@mode_ = @MODE_ROULETTE_PREMINUM) 	then 1 else 0 end
			where gameid = @gameid_

			-------------------------------------------------
			------ ����̱�.
			-------------------------------------------------
			--select top 1 * from dbo.tFVSystemRoulette
			--where famelvmin <= @famelv
			--		and @famelv <= famelvmax
			--		and packstate = 1
			--		--and (ABS(CAST( (BINARY_CHECKSUM(*) * RAND()) as int)) % 100) <= 100
			--		--order by newid()
            --
			----------------------------------------------------------------
			---- ����/���� ����Ʈ ����
			----------------------------------------------------------------
			--exec spu_FVGiftList @gameid_


		end

	set nocount off
End



