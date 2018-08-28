/*
-- ����[O], ����[O]
delete from tCashTotal
delete from tCashChangeLogTotal
delete from tCashLog where gameid = 'xxxx2'
delete from tCashChangeLog where gameid = 'xxxx2'
delete from tGiftList where gameid in ('xxxx2', 'xxxx3') and idx >= 4472
update dbo.tFVUserMaster set cashcost = 0, gamecost = 0, heart = 0, feed = 0, randserial = -1, market = 6 where gameid = 'xxxx2'
update dbo.tFVUserMaster set cashcost = 0, gamecost = 0, heart = 0, feed = 0, randserial = -1, market = 6 where gameid = 'xxxx3'

exec spu_FVCashBuy 1, 'xxxx2',      '', '049000s1i0n7t8445289', 'xxxxx6', '63234567090110987675defgxabc534531423576576945e2', 5, 1, 5000, 12,    1100, 12,    1100, '', '', '', '', -1	-- ����
exec spu_FVCashBuy 1, 'xxxx2',      '', '049000s1i0n7t8445289', 'xxxxx7', '63234567090110987675defgxabc534531423576576945e3', 5, 1, 5001, 63,    5500, 63,    5500, '', '', '', '', -1	--
exec spu_FVCashBuy 1, 'xxxx2',      '', '049000s1i0n7t8445289', 'xxxxx8', '63234567090110987675defgxabc534531423576576945e4', 5, 1, 5002, 121,   9900, 121,   9900, '', '', '', '', -1	--
exec spu_FVCashBuy 1, 'xxxx2',      '', '049000s1i0n7t8445289', 'xxxxx9', '63234567090110987675defgxabc534531423576576945e5', 5, 1, 5003, 426,  33000, 426,  33000, '', '', '', '', -1	--
exec spu_FVCashBuy 1, 'xxxx2',      '', '049000s1i0n7t8445289', 'xxxxx0', '63234567090110987675defgxabc534531423576576945e6', 5, 1, 5004, 744,  55000, 744,  55000, '', '', '', '', -1	--
exec spu_FVCashBuy 1, 'xxxx2',      '', '049000s1i0n7t8445289', 'xxxxx1', '63234567090110987675defgxabc534531423576576945e7', 5, 1, 5005, 1680, 99000, 1680, 99000, '', '', '', '', -1	--

exec spu_FVCashBuy 2, 'xxxx2', 'xxxx3', '049000s1i0n7t8445289', 'xxxxx6', '63234567090110987675defgxabc534531423576576945d2', 5, 1, 5000, 20,    1100, 20,    1100, '', '', '', '', -1	-- ����
exec spu_FVCashBuy 2, 'xxxx2', 'xxxx3', '049000s1i0n7t8445289', 'xxxxx6', '63234567090110987675defgxabc534531423576576945d3', 5, 1, 5001, 63,    5500, 63,    5500, '', '', '', '', -1	--
exec spu_FVCashBuy 2, 'xxxx2', 'xxxx3', '049000s1i0n7t8445289', 'xxxxx6', '63234567090110987675defgxabc534531423576576945d4', 5, 1, 5002, 121,   9900, 121,   9900, '', '', '', '', -1	--
exec spu_FVCashBuy 2, 'xxxx2', 'xxxx3', '049000s1i0n7t8445289', 'xxxxx6', '63234567090110987675defgxabc534531423576576945d5', 5, 1, 5003, 426,  33000, 426,  33000, '', '', '', '', -1	--
exec spu_FVCashBuy 2, 'xxxx2', 'xxxx3', '049000s1i0n7t8445289', 'xxxxx6', '63234567090110987675defgxabc534531423576576945d6', 5, 1, 5004, 744,  55000, 744,  55000, '', '', '', '', -1	--
exec spu_FVCashBuy 2, 'xxxx2', 'xxxx3', '049000s1i0n7t8445289', 'xxxxx6', '63234567090110987675defgxabc534531423576576945d7', 5, 1, 5005, 1680, 99000, 1680, 99000, '', '', '', '', -1	--
*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVCashBuy', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVCashBuy;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_FVCashBuy
	@mode_									int,
	@gameid_								varchar(60),					-- ���Ӿ��̵�
	@giftid_								varchar(20),					-- �������� ����
	@password_								varchar(20),
	@acode_									varchar(256),					-- indexing
	@ucode_									varchar(256),
	@market_								int,
		@summary_								int,
	@itemcode_								int,
	@cashcost_								int,
	@cash_									int,
		@cashcost2_								int,
		@cash2_									int,
	@ikind_									varchar(256),
	@idata_									varchar(4096),
	@idata2_								varchar(4096),
	@kakaouserid_							varchar(20),
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
	declare @RESULT_ERROR_EMAIL_DUPLICATE		int				set @RESULT_ERROR_EMAIL_DUPLICATE		= -3

	-- �α��� ����.
	declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--������ > �˾�ó���� ��Ʈ�η� ��������.
	declare @RESULT_ERROR_DELETED_USER 			int				set @RESULT_ERROR_DELETED_USER			= -12			--�������� > �˾�ó���� ��Ʈ�η� ��������.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--�ش������� ã�� ����
	declare @RESULT_ERROR_NOT_FOUND_PASSWORD	int				set @RESULT_ERROR_NOT_FOUND_PASSWORD	= -17
	declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--������ �����ϰ� �ִ�.
	declare @RESULT_NEWVERION_CLIENT_DOWNLOAD 	int				set @RESULT_NEWVERION_CLIENT_DOWNLOAD	= -15			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ��ũó��.
	declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ����.

	-- ��������.
	declare @RESULT_ERROR_CASH_COPY				int				set @RESULT_ERROR_CASH_COPY				= -40
	declare @RESULT_ERROR_CASH_OVER				int				set @RESULT_ERROR_CASH_OVER				= -41
	declare @RESULT_ERROR_MONTH_OVER			int				set @RESULT_ERROR_MONTH_OVER			= -42			--�Ѵ޵��� �����ѵ��� �˻�

	-- ��Ÿ����
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- ���������ʴ¸��
	declare @RESULT_ERROR_NOT_FOUND_GIFTID		int				set @RESULT_ERROR_NOT_FOUND_GIFTID		= -75			-- ���� > ������ ���̵� ��ã��

	------------------------------------------------
	--	2-2. ���°�
	------------------------------------------------
	-- ����ó�ڵ�
	--declare @MARKET_SKT						int				set @MARKET_SKT							= 1
	--declare @MARKET_KT						int				set @MARKET_KT							= 2
	--declare @MARKET_LGT						int				set @MARKET_LGT							= 3
	declare @MARKET_GOOGLE						int				set @MARKET_GOOGLE						= 5
	declare @MARKET_NHN							int				set @MARKET_NHN							= 6
	--declare @MARKET_IPHONE					int				set @MARKET_IPHONE						= 7

	-- ���°�.
	declare @BLOCK_STATE_NO						int				set	@BLOCK_STATE_NO						= 0				-- �����¾ƴ�
	declare @BLOCK_STATE_YES					int				set	@BLOCK_STATE_YES					= 1				-- ������

	-- ���� ���ǰ�
	declare @GIFTLIST_GIFT_KIND_MESSAGE			int					set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2
	declare @GIFTLIST_GIFT_KIND_MESSAGE_DEL		int					set @GIFTLIST_GIFT_KIND_MESSAGE_DEL			= -1
	declare @GIFTLIST_GIFT_KIND_GIFT_DEL		int					set @GIFTLIST_GIFT_KIND_GIFT_DEL			= -2
	declare @GIFTLIST_GIFT_KIND_GIFT_GET		int					set @GIFTLIST_GIFT_KIND_GIFT_GET			= -3
	declare @GIFTLIST_GIFT_KIND_GIFT_SELL		int					set @GIFTLIST_GIFT_KIND_GIFT_SELL			= -4

	-- ��Ÿ ���ǰ�
	declare @SYSTEM_SENDID						varchar(40)		set @SYSTEM_SENDID						= 'SysCash'
	declare @ITEM_PERIOD_PERMANENT				int 			set @ITEM_PERIOD_PERMANENT				= -1			-- ���̺� -1�̶� ��ϵ�


	-- ��Ÿ ���
	declare @ITEM_MAINCATEGORY_CASHCOST			int				set @ITEM_MAINCATEGORY_CASHCOST 		= 50 	--ĳ������(50)
	declare @BUY_MAX_CASHCOST					int				set	@BUY_MAX_CASHCOST					= 1680;

	-- ĳ�����
	declare @CASH_MODE_BUYMODE					int				set @CASH_MODE_BUYMODE					= 1
	declare @CASH_MODE_GIFTMODE					int				set @CASH_MODE_GIFTMODE					= 2

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
	--	4. ������÷			=> ��÷�� ��ǥ �� 1���� �̳� ������ �Ϸ��ϸ� �˴ϴ�.
	--						  �����̾�Ƽ��(20��), ����20��
	--	5. �ʴ���÷			=> ��÷�� ��ǥ �� 1���� �̳� ������ �Ϸ��ϸ� �˴ϴ�.
	--						  �˹��� ������Ű��(20��), ��Ȱ�� 10��(����)
	------------------------------------------------
	--declare @EVENT07NHN_START_DAY				datetime			set @EVENT07NHN_START_DAY			= '2014-06-13 20:00'
	--declare @EVENT07NHN_END_DAY				datetime			set @EVENT07NHN_END_DAY				= '2014-08-06 23:59'

	------------------------------------------------
	--	2-3. ���λ�� ����
	------------------------------------------------
	declare @comment2			varchar(80)
	declare @gameid				varchar(60)		set @gameid			= ''
	declare @blockstate			int
	declare @market				int				set @market			= @MARKET_GOOGLE
	declare @giftid				varchar(60)
	declare @buycashcost		int				set @buycashcost	= 0
	declare @buycash			int				set @buycash		= 0
	declare @pluscashcost		int				set @pluscashcost	= 0


	declare @dateid 			varchar(8)		set @dateid 		= Convert(varchar(8), Getdate(), 112)		-- 20120819
	declare @eventplus			int				set @eventplus		= 0

	declare @kakaouk			varchar(19)		set @kakaouk		= substring(Convert(varchar(10),Getdate(),112), 3, 8) + Replace(Convert(varchar(12),Getdate(),114),':','') + Convert(varchar(4), Convert(int, ceiling(RAND() * 9980))+10)

	declare @gameyear			int				set @gameyear		= 2013
	declare @gamemonth			int				set @gamemonth		= 3
	declare @famelv				int				set @famelv			= 1

Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	--select 'DEBUG �Է°�', @mode_ mode_, @gameid_ gameid_, @giftid_ giftid_, @password_ password_, @acode_ acode_, @ucode_ ucode_, @market_ market_, @summary_ summary_, @itemcode_ itemcode_, @cashcost_ cashcost_, @cash_ cash_, @cashcost2_ cashcost2_, @cash2_ cash2_, @ikind_ ikind_, @idata_ idata_, @idata2_ idata2_

	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	select
		@gameid 	= gameid,
		@gameyear	= gameyear,
		@gamemonth	= gamemonth,
		@famelv		= famelv,
		@market		= market,
		@blockstate	= blockstate
	from dbo.tFVUserMaster where gameid = @gameid_ and password = @password_

	-- ģ�� ID�˻�
	if(@mode_ = @CASH_MODE_GIFTMODE)
		begin
			select
				@giftid = gameid
			from dbo.tFVUserMaster where gameid = @giftid_
		end

	---------------------------------------------------
	-- ������ �ڵ� > �����ڵ�, �����ݾ�Ȯ��.
	-- �ȵ���̵�, ������ > �ڵ� > ĳ��(����)
	---------------------------------------------------
	select
		@buycash		= cashcost,		-- ����
		@buycashcost 	= buyamount,	-- ĳ��
		@eventplus		= param3
	from dbo.tFVItemInfo
	where itemcode = @itemcode_ and subcategory = @ITEM_MAINCATEGORY_CASHCOST

	------------------------------------------------
	--	3-2-3. �������
	------------------------------------------------
	if(@blockstate = @BLOCK_STATE_YES)
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
	else if(@gameid = '')
		begin
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
			select @nResult_ rtn, 'ERROR ���̵� ã�� ���߽��ϴ�.'
		end
	else if(@cashcost_ != @cashcost2_ or @cash_ != @cash2_ or @buycashcost != @cashcost_)
		begin
			set @nResult_ = @RESULT_ERROR_CASH_COPY
			select @nResult_ rtn, 'ERROR ĳ��ī��(��ó���˴ϴ�. ĳ��������ġ(-1))'

			---------------------------------------------------
			--	ĳ��ī�� �÷��� ���
			---------------------------------------------------
			update dbo.tFVUserMaster set cashcopy = cashcopy + 1 where gameid = @gameid_

			insert into dbo.tFVUserUnusualLog(gameid, comment) values(@gameid_, '**** ĳ��ī�Ǹ� �õ��߽��ϴ�(ĳ��������ġ) ****')
		end
	else if(@summary_ != 1)
		begin
			set @nResult_ = @RESULT_ERROR_CASH_COPY
			select @nResult_ rtn, 'ERROR ĳ��ī��(��ó���˴ϴ�.��ȿ�����ʴ°�(-2))'

			---------------------------------------------------
			--	ĳ��ī�� �÷��� ���
			---------------------------------------------------
			update dbo.tFVUserMaster set cashcopy = cashcopy + 1 where gameid = @gameid_

			insert into dbo.tFVUserUnusualLog(gameid, comment) values(@gameid_, '**** ĳ��ī�Ǹ� �õ��߽��ϴ�(��ȿ�����ʴ� ucode��) ****')
		end
	else if(@cashcost_ > @BUY_MAX_CASHCOST)
		begin
			set @nResult_ = @RESULT_ERROR_CASH_COPY
			select @nResult_ rtn, 'ERROR ĳ��ī��(��ó���˴ϴ�.��ȿ�����ʴ� ĳ��(-3))'

			---------------------------------------------------
			--	ĳ��ī�� �÷��� ���
			---------------------------------------------------
			update dbo.tFVUserMaster set cashcopy = cashcopy + 1 where gameid = @gameid_

			insert into dbo.tFVUserUnusualLog(gameid, comment) values(@gameid_, '**** ĳ��ī�Ǹ� �õ��߽��ϴ�(��ȿ�����ʴ� ĳ��) ****')
		end
	else if(exists(select top 1 * from dbo.tFVCashLog where ucode = @ucode_))
		begin
			set @nResult_ = @RESULT_ERROR_CASH_COPY
			select @nResult_ rtn, 'ERROR ĳ��ī��(��ó���˴ϴ�.�ߺ���û(-4))'

			---------------------------------------------------
			--	ĳ��ī�� �÷��� ���
			---------------------------------------------------
			update dbo.tFVUserMaster set cashcopy = cashcopy + 10 where gameid = @gameid_

			insert into dbo.tFVUserUnusualLog(gameid, comment) values(@gameid_, '**** ĳ��ī�Ǹ� �õ��߽��ϴ�(�ߺ���û�� �ߴ�.) ****')
		end
	else if(@acode_ != '' and exists(select top 1 * from dbo.tFVCashLog where acode = @acode_))
		begin
			set @nResult_ = @RESULT_ERROR_CASH_COPY
			select @nResult_ rtn, 'ERROR ĳ��ī��(��ó���˴ϴ�.�ߺ���û(-5))'

			---------------------------------------------------
			--	ĳ��ī�� �÷��� ���
			---------------------------------------------------
			update dbo.tFVUserMaster set cashcopy = cashcopy + 10 where gameid = @gameid_

			insert into dbo.tFVUserUnusualLog(gameid, comment) values(@gameid_, '**** ĳ��ī�Ǹ� �õ��߽��ϴ�(�ߺ���û�� �ߴ�.) ****')
		end
	else
		begin
			set @nResult_ = @RESULT_SUCCESS
			select @nResult_ rtn, 'SUCCESS ���Ÿ� ����ó���ϴ�.'

			-------------------------------------------------
			-- �߰� ��弼�õǾ� �ִٸ�
			-------------------------------------------------
			select top 1 @pluscashcost = pluscashcost
			from dbo.tFVSystemInfo
			order by idx desc

			------------------------------------------------
			---- EVENT 7.24 ~ 8.6
			------------------------------------------------
			--if(@market = @MARKET_NHN and getdate() < @EVENT07NHN_END_DAY)
			--	begin
			--		set @buycashcost = 2 * @buycashcost
			--	end
			--else if(@eventplus = 1 and @pluscashcost > 0 and @pluscashcost <= 100)
			--	begin
			--		set @buycashcost = @buycashcost + (@buycashcost * @pluscashcost / 100)
			--	end
			-- �ݾ� �� ���ִ� ����.
			if(@eventplus = 1 and @pluscashcost > 0 and @pluscashcost <= 100)
				begin
					set @buycashcost = @buycashcost + (@buycashcost * @pluscashcost / 100)
				end

			if(@mode_ = @CASH_MODE_BUYMODE)
				begin
					---------------------------------------------------
					-- �������� > ĳ��Pluse
					---------------------------------------------------
					update dbo.tFVUserMaster
						set
							cashcost 	= cashcost + @buycashcost,
							cashpoint 	= cashpoint + @buycash
					where gameid = @gameid_

					---------------------------------------------------
					-- �������� > ���ű���ϱ�
					---------------------------------------------------
					insert into dbo.tFVCashLog(gameid,   acode,   ucode,      cashcost,     cash,  market,   ikind,   idata,   idata2,   kakaouserid,   kakaouk,  gameyear,  gamemonth,  famelv)
					values(                 @gameid_, @acode_, @ucode_, @buycashcost, @buycash, @market_, @ikind_, @idata_, @idata2_, @kakaouserid_, @kakaouk, @gameyear, @gamemonth, @famelv)

					-----------------------------------------------------
					---- �������� > ������ ���� �����ֱ�(������ ���·� ����)
					-----------------------------------------------------
					set @comment2 = ltrim(rtrim(str(@buycashcost))) +  '������ �����Ͽ����ϴ�.'
					exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_MESSAGE_DEL, @itemcode_, @SYSTEM_SENDID, @gameid_, @comment2
				end
			else if(@mode_ = @CASH_MODE_GIFTMODE)
				begin
					---------------------------------------------------
					-- �������� > �����ʹ���
					---------------------------------------------------
					update dbo.tFVUserMaster
						set
							cashpoint 	= cashpoint + @buycash
					where gameid = @gameid_

					---------------------------------------------------
					-- ������ > ���濡�� ������ �־��ֱ�
					---------------------------------------------------
					exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT, @itemcode_, @gameid_, @giftid_, ''				-- ĳ�� �����ϱ�.

					---------------------------------------------------
					-- ������ > ���ű���ϱ�
					---------------------------------------------------
					insert into dbo.tFVCashLog(gameid,   acode,   ucode,      cashcost,     cash,  giftid,   market,   ikind,   idata,   idata2,   kakaouserid,   kakaouk,  gameyear,  gamemonth,  famelv)
					values(                 @gameid_, @acode_, @ucode_, @buycashcost, @buycash, @giftid_, @market_, @ikind_, @idata_, @idata2_, @kakaouserid_, @kakaouk, @gameyear, @gamemonth, @famelv)

					---------------------------------------------------
					-- �����ڿ� �����ڿ��� ���� �����ֱ�
					---------------------------------------------------
					set @comment2 = ltrim(rtrim(@giftid_)) + '�Կ��� ' + ltrim(rtrim(str(@buycashcost))) +  '������ �����Ͽ����ϴ�.'
					exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_MESSAGE, -1, @gameid_, @gameid_, @comment2

					--set @comment2 = ltrim(rtrim(@gameid_)) + '���κ��� ' + ltrim(rtrim(str(@buycashcost))) +  '������ ���� �޾ҽ��ϴ�.'
					--exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_MESSAGE, -1, @gameid_, @giftid_, @comment2
				end

			---------------------------------------------------
			-- ��Ż�α� ����ϱ�
			---------------------------------------------------
			if(exists(select top 1 * from dbo.tFVCashTotal where dateid = @dateid and cashkind = @buycash and market = @market_))
				begin
					update dbo.tFVCashTotal
						set
							cashcost 	= cashcost 	+ @buycashcost,
							cash 		= cash 		+ @buycash,
							cnt 		= cnt 		+ 1
					where dateid = @dateid and cashkind = @buycash and market = @market_
				end
			else
				begin
					insert into dbo.tFVCashTotal(dateid, cashkind,  market,      cashcost,     cash)
					values(                   @dateid, @buycash, @market_, @buycashcost, @buycash)
				end

			--���� ������ �ǹ��� �������ֱ�
			select * from dbo.tFVUserMaster where gameid = @gameid_
		end



	------------------------------------------------
	--	4-2. ��������
	------------------------------------------------
	set nocount off
End

