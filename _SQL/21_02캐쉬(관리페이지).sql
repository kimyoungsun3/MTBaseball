/*
delete from dbo.tCashLog where gameid = 'xxxx2'
update dbo.tUserMaster set cashcost = 0, cashpoint = 0      where gameid = 'xxxx2'
update dbo.tUserMaster set cashcost = 0, cashpoint = 140000 where gameid = 'xxxx2'


exec spu_CashBuyAdmin 1, 'xxxx2',      '', '049000s1i0n7t8445289', 'xxxxd6', '63234567090110987675defgxabc534531423576576945d2', 5, 1, 5000,   310,   3300,   310,   3300, '', '', '', '', -1	-- ����
exec spu_CashBuyAdmin 1, 'xxxx2',      '', '049000s1i0n7t8445289', 'xxxxd7', '63234567090110987675defgxabc534531423576576945d3', 5, 1, 5001,   550,   5500,   550,   5500, '', '', '', '', -1	--
exec spu_CashBuyAdmin 1, 'xxxx2',      '', '049000s1i0n7t8445289', 'xxxxd8', '63234567090110987675defgxabc534531423576576945d4', 5, 1, 5002,  1120,  11000,  1120,  11000, '', '', '', '', -1	--
exec spu_CashBuyAdmin 1, 'xxxx2',      '', '049000s1i0n7t8445289', 'xxxxd9', '63234567090110987675defgxabc534531423576576945d5', 5, 1, 5003,  3450,  33000,  3450,  33000, '', '', '', '', -1	--
exec spu_CashBuyAdmin 1, 'xxxx2',      '', '049000s1i0n7t8445289', 'xxxxd0', '63234567090110987675defgxabc534531423576576945d6', 5, 1, 5004,  5900,  55000,  5900,  55000, '', '', '', '', -1	--
exec spu_CashBuyAdmin 1, 'xxxx2',      '', '049000s1i0n7t8445289', 'xxxxd1', '63234567090110987675defgxabc534531423576576945d7', 5, 1, 5005, 12500, 110000, 12500, 110000, '', '', '', '', -1	--

exec spu_CashBuyAdmin 1, 'xxxx2',      '', '049000s1i0n7t8445289', 'xxxxf1', '63234567090110987675defgxabc534531423576576945f2', 5, 1, 5050,   310,   3300,   310,   3300, '', '', '', '', -1	-- ����
exec spu_CashBuyAdmin 1, 'xxxx2',      '', '049000s1i0n7t8445289', 'xxxxz7', '63234567090110987675defgxabc534531423576576945z3', 5, 1, 5051,   550,   5500,   550,   5500, '', '', '', '', -1	--
*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_CashBuyAdmin', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_CashBuyAdmin;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_CashBuyAdmin
	@mode_									int,
	@gameid_								varchar(20),					-- ���Ӿ��̵�
	@giftid_								varchar(20),					-- �������� ����
	@password_								varchar(20),
	@acode_									varchar(256),					-- indexing
	@ucode_									varchar(256),
		@summary_								int,
	@itemcode_								int,
	@cashcost_								int,
	@cash_									int,
		@cashcost2_								int,
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

	-- ��񱸸�.
	declare @RESULT_ERROR_CASH_COPY				int				set @RESULT_ERROR_CASH_COPY				= -40
	declare @RESULT_ERROR_CASH_OVER				int				set @RESULT_ERROR_CASH_OVER				= -41
	declare @RESULT_ERROR_MONTH_OVER			int				set @RESULT_ERROR_MONTH_OVER			= -42			--�Ѵ޵��� �����ѵ��� �˻�

	-- ��Ÿ����
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- ���������ʴ¸��
	declare @RESULT_ERROR_NOT_FOUND_GIFTID		int				set @RESULT_ERROR_NOT_FOUND_GIFTID		= -75			-- ��� > ������ ���̵� ��ã��

	------------------------------------------------
	--	2-2. ���°�
	------------------------------------------------
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
	declare @BUY_MAX_CASHCOST					int				set	@BUY_MAX_CASHCOST					= 110000

	-- ĳ�����
	declare @CASH_MODE_BUYMODE					int				set @CASH_MODE_BUYMODE					= 1
	declare @CASH_MODE_GIFTMODE					int				set @CASH_MODE_GIFTMODE					= 2

	----------------------------------------------
	-- 	�̺�Ʈ ó��
	--	�Ⱓ : 2016-05-31 ~ 2029-08-06
	--			33000	55000	110000
	--	ĳ��	20%		20%		20%			<- �ý����� ������.
	--	����	��2��	��4��	��9��		<- ������, �ߺ����� 	���������̾�(2300)	���������̾�(2600)
	--	����	20000	50000	100000		<- ������, �ߺ�����		���������̾�(5100)
	--	�ڽ�					���۸���	<- ������, �ߺ�����		���۸���(3705)
	--	��				��		��			<- �ý����� ������.
	------------------------------------------------
	declare @EVENT01_START_DAY					datetime		set @EVENT01_START_DAY			= '2016-05-31 12:00'
	declare @EVENT01_END_DAY					datetime		set @EVENT01_END_DAY			= '2029-08-06 23:59'

	------------------------------------------------
	--	2-3. ���λ�� ����
	------------------------------------------------
	declare @comment2			varchar(80)
	declare @gameid				varchar(20)		set @gameid			= ''
	declare @blockstate			int
	declare @giftid				varchar(20)
	declare @buycashcost		int				set @buycashcost	= 0
	declare @buycashcostorg		int				set @buycashcostorg	= 0
	declare @buycash			int				set @buycash		= 0
	declare @pluscashcost		int				set @pluscashcost	= 0


	declare @dateid 			varchar(8)		set @dateid 		= Convert(varchar(8), Getdate(), 112)		-- 20120819
	declare @curdate			datetime		set @curdate		= getdate()
	declare @eventplus			int				set @eventplus		= 0
	declare @productid			varchar(40)		set @productid		= ''

	declare @kakaouk			varchar(19)		set @kakaouk		= substring(Convert(varchar(10),Getdate(),112), 3, 8) + Replace(Convert(varchar(12),Getdate(),114),':','') + Convert(varchar(4), Convert(int, ceiling(RAND() * 9980))+10)

	declare @level				int				set @level			= 1

	-- VIPȿ��.
	declare @cashpoint			int				set @cashpoint		= 0
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	--select 'DEBUG �Է°�', @mode_ mode_, @gameid_ gameid_, @giftid_ giftid_, @password_ password_, @acode_ acode_, @ucode_ ucode_, @summary_ summary_, @itemcode_ itemcode_, @cashcost_ cashcost_, @cash_ cash_, @cashcost2_ cashcost2_, @cash2_ cash2_, @ikind_ ikind_, @idata_ idata_, @idata2_ idata2_

	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	select
		@gameid 	= gameid,		@cashpoint	= cashpoint,
		@level		= level,
		@blockstate	= blockstate
	from dbo.tUserMaster where gameid = @gameid_ and password = @password_

	-- ģ�� ID�˻�
	if(@mode_ = @CASH_MODE_GIFTMODE)
		begin
			select
				@giftid = gameid
			from dbo.tUserMaster where gameid = @giftid_
		end

	---------------------------------------------------
	-- ������ �ڵ� > ����ڵ�, �����ݾ�Ȯ��.
	-- �ȵ���̵�, ������ > �ڵ� > ĳ��(����)
	---------------------------------------------------
	select
		@buycash		= cashcost,		-- ����
		@buycashcost 	= buyamount,	-- ĳ��
		@buycashcostorg = buyamount,
		@eventplus		= param3,
		@productid		= param4
	from dbo.tItemInfo
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
			--update dbo.tUserMaster set cashcopy = cashcopy + 1 where gameid = @gameid_

			--insert into dbo.tUserUnusualLog(gameid, comment) values(@gameid_, '**** ĳ��ī�Ǹ� �õ��߽��ϴ�(ĳ��������ġ) ****')
		end
	else if(@summary_ != 1)
		begin
			set @nResult_ = @RESULT_ERROR_CASH_COPY
			select @nResult_ rtn, 'ERROR ĳ��ī��(��ó���˴ϴ�.��ȿ�����ʴ°�(-2))'

			---------------------------------------------------
			--	ĳ��ī�� �÷��� ���
			---------------------------------------------------
			--update dbo.tUserMaster set cashcopy = cashcopy + 1 where gameid = @gameid_

			--insert into dbo.tUserUnusualLog(gameid, comment) values(@gameid_, '**** ĳ��ī�Ǹ� �õ��߽��ϴ�(��ȿ�����ʴ� ucode��) ****')
		end
	else if(@cashcost_ > @BUY_MAX_CASHCOST)
		begin
			set @nResult_ = @RESULT_ERROR_CASH_COPY
			select @nResult_ rtn, 'ERROR ĳ��ī��(��ó���˴ϴ�.��ȿ�����ʴ� ĳ��(-3))'

			---------------------------------------------------
			--	ĳ��ī�� �÷��� ���
			---------------------------------------------------
			--update dbo.tUserMaster set cashcopy = cashcopy + 1 where gameid = @gameid_

			--insert into dbo.tUserUnusualLog(gameid, comment) values(@gameid_, '**** ĳ��ī�Ǹ� �õ��߽��ϴ�(��ȿ�����ʴ� ĳ��) ****')
		end
	else if(exists(select top 1 * from dbo.tCashLog where ucode = @ucode_))
		begin
			set @nResult_ = @RESULT_ERROR_CASH_COPY
			select @nResult_ rtn, 'ERROR ĳ��ī��(��ó���˴ϴ�.�ߺ���û(-4))'

			---------------------------------------------------
			--	ĳ��ī�� �÷��� ���
			---------------------------------------------------
			--update dbo.tUserMaster set cashcopy = cashcopy + 10 where gameid = @gameid_

			--insert into dbo.tUserUnusualLog(gameid, comment) values(@gameid_, '**** ĳ��ī�Ǹ� �õ��߽��ϴ�(�ߺ���û�� �ߴ�.) ****')
		end
	else if(@acode_ != '' and exists(select top 1 * from dbo.tCashLog where acode = @acode_))
		begin
			set @nResult_ = @RESULT_ERROR_CASH_COPY
			select @nResult_ rtn, 'ERROR ĳ��ī��(��ó���˴ϴ�.�ߺ���û(-5))'

			---------------------------------------------------
			--	ĳ��ī�� �÷��� ���
			---------------------------------------------------
			--update dbo.tUserMaster set cashcopy = cashcopy + 10 where gameid = @gameid_

			--insert into dbo.tUserUnusualLog(gameid, comment) values(@gameid_, '**** ĳ��ī�Ǹ� �õ��߽��ϴ�(�ߺ���û�� �ߴ�.) ****')
		end
	else
		begin
			set @nResult_ = @RESULT_SUCCESS
			select @nResult_ rtn, 'SUCCESS ���Ÿ� ����ó���ϴ�.'

			-------------------------------------------------
			-- �߰� ��弼�õǾ� �ִٸ�
			-------------------------------------------------
			select top 1 @pluscashcost = pluscashcost
			from dbo.tSystemInfo
			order by idx desc

			----------------------------------------------
			-- EVENT > �����ϱ�.
			----------------------------------------------
			if( @itemcode_ in ( 5003, 5004, 5005, 5053, 5054, 5055 ) and @curdate >= @EVENT01_START_DAY and @curdate < @EVENT01_END_DAY)
				begin
					if( @itemcode_ in ( 5003, 5053) )
						begin
							exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT, 2300,     2, '���ε��� �̺�Ʈ', @gameid_, ''
							exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT, 2600,     2, '���ε��� �̺�Ʈ', @gameid_, ''
							exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT, 5100, 20000, '���ε��� �̺�Ʈ', @gameid_, ''
						end
					else if( @itemcode_ in ( 5004, 5054 ) )
						begin
							exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT, 2300,     4, '���ε��� �̺�Ʈ', @gameid_, ''
							exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT, 2600,     4, '���ε��� �̺�Ʈ', @gameid_, ''
							exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT, 5100, 50000, '���ε��� �̺�Ʈ', @gameid_, ''
						end
					else if( @itemcode_ in ( 5005, 5055 ) )
						begin
							exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT, 2300,     9, '���ε��� �̺�Ʈ', @gameid_, ''
							exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT, 2600,     9, '���ε��� �̺�Ʈ', @gameid_, ''
							exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT, 5100,100000, '���ε��� �̺�Ʈ', @gameid_, ''
							exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT, 3705,     1, '���ε��� �̺�Ʈ', @gameid_, ''
						end
				end


			if(@mode_ = @CASH_MODE_BUYMODE)
				begin
					---------------------------------------------------
					-- �������� > ĳ��Pluse
					---------------------------------------------------
					update dbo.tUserMaster
						set
							cashpoint 	= cashpoint + @buycash
					where gameid = @gameid_

					---------------------------------------------------
					-- �������� > ���ű���ϱ�
					---------------------------------------------------
					insert into dbo.tCashLog(gameid,   acode,   ucode,      cashcost,     cash,  ikind,   idata,   idata2,   level,  productid)
					values(                 @gameid_, @acode_, @ucode_, @buycashcost, @buycash, @ikind_, @idata_, @idata2_, @level, @productid)



					---------------------------------------------------
					-- ����ù�����ΰ�.
					---------------------------------------------------
					--	begin
					--		--select 'DEBUG ���ְ����ΰ�'
					--		insert into dbo.tCashFirstTimeLog(gameid,   itemcode)
					--		values(                          @gameid_, @itemcode_)
					--		set @comment2 = ltrim(rtrim(str(@buycashcost))) +  '����� �����Ͽ����ϴ�.(����ù����)'
					--		exec spu_DayLogInfoStatic 82, 1				-- �� ĳ������(����)
					--	end
					--else
						begin
							set @comment2 = ltrim(rtrim(str(@buycashcost))) +  '���̶� �����Ͽ����ϴ�.'

							exec spu_DayLogInfoStatic 81, 1				-- �� ĳ������(�Ϲ�)
						end

					-----------------------------------------------------
					---- �������� > ������ ���� �����ֱ�(������ ���·� ����)
					-----------------------------------------------------
					exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT, @itemcode_, @buycashcost, @SYSTEM_SENDID, @gameid_, @comment2


				end
			else if(@mode_ = @CASH_MODE_GIFTMODE)
				begin
					---------------------------------------------------
					-- �������� > �����ʹ���
					---------------------------------------------------
					update dbo.tUserMaster
						set
							cashpoint 	= cashpoint + @buycash
					where gameid = @gameid_

					---------------------------------------------------
					-- ������ > ���濡�� ������ �־��ֱ�
					---------------------------------------------------
					exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT, @itemcode_, 0, @gameid_, @giftid_, ''				-- ĳ�� �����ϱ�.

					---------------------------------------------------
					-- ������ > ���ű���ϱ�
					---------------------------------------------------
					insert into dbo.tCashLog(gameid,   acode,   ucode,      cashcost,     cash,  giftid,   ikind,   idata,   idata2,   level,  productid)
					values(                 @gameid_, @acode_, @ucode_, @buycashcost, @buycash, @giftid_, @ikind_, @idata_, @idata2_, @level, @productid)

					---------------------------------------------------
					-- �����ڿ� �����ڿ��� ���� �����ֱ�
					---------------------------------------------------
					set @comment2 = ltrim(rtrim(@giftid_)) + '�Կ��� ' + ltrim(rtrim(str(@buycashcost))) +  '����� �����Ͽ����ϴ�.'
					exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_MESSAGE, -1, 0, @gameid_, @gameid_, @comment2

					--set @comment2 = ltrim(rtrim(@gameid_)) + '���κ��� ' + ltrim(rtrim(str(@buycashcost))) +  '����� ���� �޾ҽ��ϴ�.'
					--exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_MESSAGE, -1, 0, @gameid_, @giftid_, @comment2
				end

			---------------------------------------------------
			-- ��Ż�α� ����ϱ�
			---------------------------------------------------
			if(exists(select top 1 * from dbo.tCashTotal where dateid = @dateid and cashkind = @buycash))
				begin
					update dbo.tCashTotal
						set
							cashcost 	= cashcost 	+ @buycashcost,
							cash 		= cash 		+ @buycash,
							cnt 		= cnt 		+ 1
					where dateid = @dateid and cashkind = @buycash
				end
			else
				begin
					insert into dbo.tCashTotal(dateid, cashkind,     cashcost,     cash)
					values(                   @dateid, @buycash, @buycashcost, @buycash)
				end

			--���� ���� �ǹ��� �������ֱ�
			--select * from dbo.tUserMaster where gameid = @gameid_
		end



	------------------------------------------------
	--	4-2. ��������
	------------------------------------------------
	set nocount off
End

