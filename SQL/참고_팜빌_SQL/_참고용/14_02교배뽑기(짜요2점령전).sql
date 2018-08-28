/*
delete from dbo.tFVGiftList where gameid = 'xxxx2'
update dbo.tFVUserMaster set cashcost = 0, gamecost = 0, heart = 0, randserial = -1 where gameid = 'xxxx3'
update dbo.tFVUserMaster set cashcost = 10000, gamecost = 10000, heart = 50000, randserial = -1 where gameid = 'xxxx2'
exec spu_FVRoulBuy 'xxxx2', '049000s1i0n7t8445289', 1, 7777, 1, 'xxxx3', -1			-- �Ϲݱ���  0
exec spu_FVRoulBuy 'xxxx2', '049000s1i0n7t8445289', 1, 7778, 1, 'xxxx4', -1			-- �Ϲݱ���  2
exec spu_FVRoulBuy 'xxxx2', '049000s1i0n7t8445289', 1, 7779, 1, 'xxxx5', -1			-- �Ϲݱ��� 10

delete from dbo.tFVGiftList where gameid = 'xxxx2'
update dbo.tFVUserMaster set cashcost = 0, gamecost = 0, heart = 0, randserial = -1 where gameid = 'xxxx3'
update dbo.tFVUserMaster set cashcost = 10000, gamecost = 10000, heart = 50000, randserial = -1 where gameid = 'xxxx2'
exec spu_FVRoulBuy 'xxxx2', '049000s1i0n7t8445289', 1, 7776, 1, 'xxxx3', -1			-- �Ϲݱ���
exec spu_FVRoulBuy 'xxxx2', '049000s1i0n7t8445289', 1, 7777, 2, 'xxxx3', -1			-- �����̾�����

--exec spu_FVGiftGain 'xxxx2', '049000s1i0n7t8445289', -3, 23064, -1, -1, -1, -1	-- �����̾�����̱�
update dbo.tFVUserMaster set pmroulcnt = 0, pmticketcnt = 0 where gameid in ('xxxx2', 'xxxx6', 'farm623710809')
delete from dbo.tFVGiftList where gameid in ('xxxx2', 'xxxx6')
update dbo.tFVUserMaster set cashcost = 0, gamecost = 0, heart = 0, heartget = 0, randserial = -1 where gameid = 'xxxx6'
update dbo.tFVUserMaster set cashcost = 10000, gamecost = 10000, heart = 10000, heartget = 0, randserial = -1, pmroulcnt = 0 where gameid = 'xxxx2'
exec spu_FVRoulBuy 'xxxx2', '049000s1i0n7t8445289', 1, 7776, 1, 'xxxx6', -1			-- �Ϲݱ���
exec spu_FVRoulBuy 'xxxx2', '049000s1i0n7t8445289', 1, 7777, 2, 'xxxx6', -1			-- �����̾�����
exec spu_FVRoulBuy 'xxxx2', '049000s1i0n7t8445289', 1, 7778, 2, 'xxxx6', -1			-- �����̾�����

update dbo.tFVUserMaster set cashcost = 10000, gamecost = 10000, heart = 10000, heartget = 0, randserial = -1, pmroulcnt = 0 where gameid = 'farm423576530'
exec spu_FVRoulBuy 'farm423576530', '9790943e2o3w6y383758', 169, JK5K802B1225J95910, 2, 'farm99849864', -1			-- �����̾�����
exec spu_FVRoulBuy 'farm423576530', '9790943e2o3w6y383758', 169, JK5K802B1225J95911, 2, 'farm99849864', -1			-- �����̾�����
*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVRoulBuy', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVRoulBuy;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_FVRoulBuy
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
	declare @MODE_ROULETTE_PREMINUM_FREE		int					set @MODE_ROULETTE_PREMINUM_FREE			= 3	-- �����̾�����(free:���κ���).
	declare @CROSS_REWARD_HEART					int					set @CROSS_REWARD_HEART						= 5 -- ����� ���޵Ǵ� ������Ʈ.
	declare @FRIEND_SYSTEM						varchar(20)			set @FRIEND_SYSTEM							= 'farmgirl'

	declare @ITEM_ROULETTE_NOR_MOTHER			int					set @ITEM_ROULETTE_NOR_MOTHER				= 2200	-- �Ϲݱ���̱�.
	declare @ITEM_ROULETTE_PRE_MOTHER			int					set @ITEM_ROULETTE_PRE_MOTHER				= 2300	-- �����̾�����̱�.

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
	declare @pmgauage				int				set @pmgauage			= 0
	declare @pmfree					int				set @pmfree				= 0
	declare @grade					int				set @grade				= 0
	declare @pmticket				int				set @pmticket			= 0
	declare @pmticketcnt			int				set @pmticketcnt		= 0

	declare @gameyear				int				set @gameyear			= 2013
	declare @gamemonth				int				set @gamemonth			= 3

	declare @norcnt					int				set @norcnt				= 0
	declare @precnt					int				set @precnt				= 0

	declare @ticket 				int 			set @ticket 			= 0
	declare @curdate				datetime		set @curdate		= getdate()
	declare @famelvmin 				int 			set @famelvmin 			= 1			-- �α���(9��) > �ŷ���(10��) �̱�� 9���� �������ش�. �Ф�
	declare @famelvmax 				int 			set @famelvmax 			= 10
	declare @curhour				int				set @curhour			= -1

	-- PM��������(������).
	declare @checkani				int				set @checkani			= -1
	declare @checkreward			int				set @checkreward		= -1

	-- PM��������.
	declare @strmarket				varchar(40)
	declare @roulflag				int				set @roulflag			= -1
	declare @roulani1				int				set @roulani1			= -1
	declare @roulani2				int				set @roulani2			= -1
	declare @roulani3				int				set @roulani3			= -1
	declare @roulreward1			int				set @roulreward1		= -1
	declare @roulreward2			int				set @roulreward2		= -1
	declare @roulreward3			int				set @roulreward3		= -1
	declare @roulname1				varchar(20)		set @roulname1			= ''
	declare @roulname2				varchar(20)		set @roulname2			= ''
	declare @roulname3				varchar(20)		set @roulname3			= ''

	-- PMȮ�����.
	declare @roultimeflag			int				set @roultimeflag		= -1
	declare @roultimetime1			int				set @roultimetime1		= -1
	declare @roultimetime2			int				set @roultimetime2		= -1
	declare @roultimetime3			int				set @roultimetime3		= -1

	-- PM���ᱳ��.
	declare @pmgauageflag			int				set @pmgauageflag			= -1
	declare @PMGAUAGEPOINT			int				set @PMGAUAGEPOINT			= 10
	declare @PMGAUAGEMAX			int				set @PMGAUAGEMAX			= 100


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
		@pmgauage		= isnull(pmgauage, 0),
		@bgroulcnt		= bgroulcnt,
		@gameyear		= gameyear,
		@gamemonth		= gamemonth
	from dbo.tFVUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG ��������', @gameid gameid, @cashcost cashcost, @gamecost gamecost, @heart heart, @feed feed, @randserial randserial, @roul1 roul1, @roul2 roul2, @roul3 roul3, @roul4 roul4, @roul5 roul5

	------------------------------------------------
	-- �̱� �̺�Ʈ ���� ��������.
	------------------------------------------------
	set @strmarket = '%' + ltrim(rtrim(str(@market))) + '%'
	select
		top 1
		@roulflag 		= case when (@curdate > roulstart and @curdate <= roulend) then roulflag 		else -1 end,
		@roulani1		= roulani1,
		@roulani2		= roulani2,
		@roulani3		= roulani3,
		@roulreward1	= roulreward1,
		@roulreward2	= roulreward2,
		@roulreward3	= roulreward3,
		@roulname1		= roulname1,
		@roulname2		= roulname2,
		@roulname3		= roulname3,
		@roultimeflag	= case when (@curdate > roulstart and @curdate <= roulend) then roultimeflag 	else -1 end,
		@roultimetime1	= roultimetime1,
		@roultimetime2	= roultimetime2,
		@roultimetime3	= roultimetime3,
		@pmgauageflag	= case when (@curdate > roulstart and @curdate <= roulend) then pmgauageflag 	else -1 end,
		@PMGAUAGEPOINT	= pmgauagepoint,
		@PMGAUAGEMAX	= pmgauagemax
	from dbo.tFVSystemRouletteMan
	where roulmarket like @strmarket
	order by idx desc

	------------------------------------------------
	-- ���� ���� �Ϲ�, �����̾�.
	------------------------------------------------
	if(@mode_ = @MODE_ROULETTE_PREMINUM)
		begin
			select
				@precnt 		= cnt
			from dbo.tFVUserItem
			where gameid = @gameid_ and itemcode = @ITEM_ROULETTE_PRE_MOTHER
			--select 'DEBUG ���� ���� �����̾�', @precnt precnt, @pmgauage pmgauage

			-- �����̾� �������� �� ��� > ����� ������.)
			if(@pmgauageflag = 1)
				begin
					if(@randserial_ != @randserial)
						begin
							if(@pmgauage < @PMGAUAGEMAX)
								begin
									--select 'DEBUG �����̾� ����'
									set @pmgauage 	= @pmgauage + @PMGAUAGEPOINT
								end
							else
								begin
									--select 'DEBUG �����̾� ����'
									--set @pmgauage 	= @pmgauage - @PMGAUAGEMAX			-- ���Ƽ� ��Ӻ�����.
									set @pmgauage 	= 0										-- �Ѳ����� ���������.
									set @precnt		= @precnt + 1
									set @pmfree		= 1
								end
						end
				end
		end
	else if(@mode_ = @MODE_ROULETTE_NORMAL)
		begin
			select
				@norcnt 		= cnt
			from dbo.tFVUserItem
			where gameid = @gameid_ and itemcode = @ITEM_ROULETTE_NOR_MOTHER
			--select 'DEBUG ���� ���� �Ϲݻ̱�', @norcnt norcnt
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

					--select 'DEBUG �����̾�����.', @roultimeflag roultimeflag
					-- 2�� �� �׷��̵�.
					set @group1 	=    0
					set @group2		=    0
					set @group3		= 9800
					set @group4		=  200
					if(@roultimeflag = 1)
						begin
							--select 'DEBUG ����Ȯ�� ���', @roultimetime1 roultimetime1, @roultimetime2 roultimetime2, @roultimetime3 roultimetime3
							if(@curhour in (@roultimetime1, @roultimetime2, @roultimetime3))
								begin
									--select 'DEBUG > ����ð���'
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
										when @roul1 >=  24 and @roul1 <  27	then  21
										when @roul1 >=  27 and @roul1 <  99	then  23
										when @roul1 >= 122 and @roul1 < 125	then 120
										when @roul1 >= 125 and @roul1 < 199	then 121
										when @roul1 >= 222 and @roul1 < 225	then 220
										when @roul1 >= 225 and @roul1 < 299	then 221
										else @roul1
									end
						set @roul2 = case
										when @roul2 >=  24 and @roul2 <  27	then  21
										when @roul2 >=  27 and @roul2 <  99	then  23
										when @roul2 >= 122 and @roul2 < 125	then 120
										when @roul2 >= 125 and @roul2 < 199	then 121
										when @roul2 >= 222 and @roul2 < 225	then 220
										when @roul2 >= 225 and @roul2 < 299	then 221
										else @roul2
									end
						set @roul3 = case
										when @roul3 >=  24 and @roul3 <  27	then  21
										when @roul3 >=  27 and @roul3 <  99	then  23
										when @roul3 >= 122 and @roul3 < 125	then 120
										when @roul3 >= 125 and @roul3 < 199	then 121
										when @roul3 >= 222 and @roul3 < 225	then 220
										when @roul3 >= 225 and @roul3 < 299	then 221
										else @roul3
									end
						set @roul4 = case
										when @roul4 >=  24 and @roul4 <  27	then  21
										when @roul4 >=  27 and @roul4 <  99	then  23
										when @roul4 >= 122 and @roul4 < 125	then 120
										when @roul4 >= 125 and @roul4 < 199	then 121
										when @roul4 >= 222 and @roul4 < 225	then 220
										when @roul4 >= 225 and @roul4 < 299	then 221
										else @roul4
									end
						set @roul5 = case
										when @roul5 >=  24 and @roul5 <  27	then  21
										when @roul5 >=  27 and @roul5 <  99	then  23
										when @roul5 >= 122 and @roul5 < 125	then 120
										when @roul5 >= 125 and @roul5 < 199	then 121
										when @roul5 >= 222 and @roul5 < 225	then 220
										when @roul5 >= 225 and @roul5 < 299	then 221
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
			if(@roulflag = 1)
				begin
					--select 'DEBUG > �̺�Ʈ �Ⱓ��'
					if(@roulani1 in (@roul1, @roul2, @roul3, @roul4, @roul5))
						begin
							--select 'DEBUG > 	-> Ư������ ����1'
							exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @roulreward1, @roulname1, @gameid_, ''
							set @checkani 		= @roulani1
							set @checkreward 	= @roulreward1
						end
					else if(@roulani2 in (@roul1, @roul2, @roul3, @roul4, @roul5))
						begin
							--select 'DEBUG >  	-> Ư������ ����2'
							exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @roulreward2, @roulname2, @gameid_, ''
							set @checkani 		= @roulani2
							set @checkreward 	= @roulreward2
						end
					else if(@roulani3 in (@roul1, @roul2, @roul3, @roul4, @roul5))
						begin
							--select 'DEBUG > 	-> Ư������ ����3'
							exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @roulreward3, @roulname3, @gameid_, ''
							set @checkani 		= @roulani3
							set @checkreward 	= @roulreward3
						end
				end

			------------------------------------------------------------------
			-- ���� �����ϱ�.
			------------------------------------------------------------------
			exec spu_FVRoulAdLog @gameid_, @kakaonickname, @mode_, @roul1, @roul2, @roul3, @roul4, @roul5
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
					if(@pmfree = 1)
						begin
							exec spu_FVUserItemRoulLog @gameid_, @MODE_ROULETTE_PREMINUM_FREE, @famelv, @itemcode,             0,             0,          0, @roul1, @roul2, @roul3, @roul4, @roul5, @gameyear, @gamemonth, @friendid_
						end
					else
						begin
							exec spu_FVUserItemRoulLog @gameid_,                       @mode_, @famelv, @itemcode, @cashcostsale,             0,          0, @roul1, @roul2, @roul3, @roul4, @roul5, @gameyear, @gamemonth, @friendid_
						end
				end
			else
				begin
					exec spu_FVUserItemRoulLog @gameid_, @mode_, @famelv, @itemcode,            0, @roulgamecost, @roulheart, @roul1, @roul2, @roul3, @roul4, @roul5, @gameyear, @gamemonth, @friendid_
				end
		END

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost, @heart heart, @feed feed, @roul1 roul1, @roul2 roul2, @roul3 roul3, @roul4 roul4, @roul5 roul5, @pmgauage pmgauage, @checkani checkani, @checkreward checkreward

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
					pmgauage	= @pmgauage,
					bgroulcnt	= @bgroulcnt,
					bkcrossnormal	= bkcrossnormal 	+ case when (@mode_ = @MODE_ROULETTE_NORMAL) 	then 1 else 0 end,
					bkcrosspremium	= bkcrosspremium 	+ case when (@mode_ = @MODE_ROULETTE_PREMINUM) 	then 1 else 0 end
			where gameid = @gameid_

			-----------------------------------------------
			---- ����̱�.
			-----------------------------------------------
			select top 1 * from dbo.tFVSystemRoulette
			where famelvmin <= @famelv
					and @famelv <= famelvmax
					and packstate = 1
					--and (ABS(CAST( (BINARY_CHECKSUM(*) * RAND()) as int)) % 100) <= 100
					order by newid()

			--------------------------------------------------------------
			-- ����/���� ����Ʈ ����
			--------------------------------------------------------------
			exec spu_FVGiftList @gameid_

			---------------------------------------------
			-- �����̾� ���� �ڷ�.
			---------------------------------------------
			select
				top 1 *,
				case when (@curdate > roulstart and @curdate <= roulend) then roulflag 		else -1 end roulflag2,
				case when (@curdate > roulstart and @curdate <= roulend) then roultimeflag 	else -1 end roultimeflag2,
				case when (@curdate > roulstart and @curdate <= roulend) then pmgauageflag 	else -1 end pmgauageflag2
			from dbo.tFVSystemRouletteMan
			where roulmarket like @strmarket
			order by idx desc
		end

	set nocount off
End



