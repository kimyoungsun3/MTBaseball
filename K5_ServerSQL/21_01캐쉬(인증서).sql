/*
-- ����[O], ����[O]
delete from tCashTotal
delete from tCashChangeLogTotal
delete from tCashLog where gameid = 'xxxx2'
delete from tCashFirstTimeLog where gameid = 'xxxx2'
delete from tCashChangeLog where gameid = 'xxxx2'
delete from tGiftList where gameid in ('xxxx2', 'xxxx3') and idx >= 4472
update dbo.tUserMaster set cashcost = 0, cashpoint = 0, gamecost = 0, heart = 0, feed = 0, eventspot07 = 0, randserial = -1, market = 6 where gameid = 'xxxx2'
update dbo.tUserMaster set cashcost = 0, cashpoint = 0, gamecost = 0, heart = 0, feed = 0, eventspot07 = 0, randserial = -1, market = 6 where gameid = 'xxxx3'

exec spu_CashBuy 1, 'xxxx2',      '', '049000s1i0n7t8445289', 'xxxxx6', '63234567090110987675defgxabc534531423576576945e2', 5, 1, 5000,   310,   3300,   310,   3300, '', '', '', '', -1	-- ����
exec spu_CashBuy 1, 'xxxx2',      '', '049000s1i0n7t8445289', 'xxxxx7', '63234567090110987675defgxabc534531423576576945e3', 5, 1, 5001,   550,   5500,   550,   5500, '', '', '', '', -1	--
exec spu_CashBuy 1, 'xxxx2',      '', '049000s1i0n7t8445289', 'xxxxx8', '63234567090110987675defgxabc534531423576576945e4', 5, 1, 5002,  1120,  11000,  1120,  11000, '', '', '', '', -1	--
exec spu_CashBuy 1, 'xxxx2',      '', '049000s1i0n7t8445289', 'xxxxx9', '63234567090110987675defgxabc534531423576576945e5', 5, 1, 5003,  3450,  33000,  3450,  33000, '', '', '', '', -1	--
exec spu_CashBuy 1, 'xxxx2',      '', '049000s1i0n7t8445289', 'xxxxx0', '63234567090110987675defgxabc534531423576576945e6', 5, 1, 5004,  5900,  55000,  5900,  55000, '', '', '', '', -1	--
exec spu_CashBuy 1, 'xxxx2',      '', '049000s1i0n7t8445289', 'xxxxx1', '63234567090110987675defgxabc534531423576576945e7', 5, 1, 5005, 12500, 110000, 12500, 110000, '', '', '', '', -1	--

exec spu_CashBuy 1, 'xxxx2',      '', '049000s1i0n7t8445289', 'xxxx2a', '63234567090110987675defgxabc5345314235765769452a', 5, 1, 5050,   310,   3300,   310,   3300, '', '', '', '', -1	-- ����
exec spu_CashBuy 1, 'xxxx2',      '', '049000s1i0n7t8445289', 'xxxx27', '63234567090110987675defgxabc53453142357657694523', 5, 1, 5051,   550,   5500,   550,   5500, '', '', '', '', -1	--
exec spu_CashBuy 1, 'xxxx2',      '', '049000s1i0n7t8445289', 'xxxx28', '63234567090110987675defgxabc53453142357657694524', 5, 1, 5052,  1120,  11000,  1120,  11000, '', '', '', '', -1	--
exec spu_CashBuy 1, 'xxxx2',      '', '049000s1i0n7t8445289', 'xxxx29', '63234567090110987675defgxabc53453142357657694525', 5, 1, 5053,  3450,  33000,  3450,  33000, '', '', '', '', -1	--
exec spu_CashBuy 1, 'xxxx2',      '', '049000s1i0n7t8445289', 'xxxx20', '63234567090110987675defgxabc53453142357657694526', 5, 1, 5054,  5900,  55000,  5900,  55000, '', '', '', '', -1	--
exec spu_CashBuy 1, 'xxxx2',      '', '049000s1i0n7t8445289', 'xxxx2c', '63234567090110987675defgxabc5345314235765769452c', 5, 1, 5055, 12500, 110000, 12500, 110000, '', '', '', '', -1	--

exec spu_CashBuy 2, 'xxxx2', 'xxxx3', '049000s1i0n7t8445289', 'xxxxz6', '63234567090110987675defgxabc534531423576576945d2', 5, 1, 5000,   310,   3300,   310,   3300, '', '', '', '', -1	-- ����
exec spu_CashBuy 2, 'xxxx2', 'xxxx3', '049000s1i0n7t8445289', 'xxxxz7', '63234567090110987675defgxabc534531423576576945d3', 5, 1, 5001,   550,   5500,   550,   5500, '', '', '', '', -1	--
exec spu_CashBuy 2, 'xxxx2', 'xxxx3', '049000s1i0n7t8445289', 'xxxxz8', '63234567090110987675defgxabc534531423576576945d4', 5, 1, 5002,  1120,  11000,  1120,  11000, '', '', '', '', -1	--
exec spu_CashBuy 2, 'xxxx2', 'xxxx3', '049000s1i0n7t8445289', 'xxxxz9', '63234567090110987675defgxabc534531423576576945d5', 5, 1, 5003,  3450,  33000,  3450,  33000, '', '', '', '', -1	--
exec spu_CashBuy 2, 'xxxx2', 'xxxx3', '049000s1i0n7t8445289', 'xxxxz0', '63234567090110987675defgxabc534531423576576945d6', 5, 1, 5004,  5900,  55000,  5900,  55000, '', '', '', '', -1	--
exec spu_CashBuy 2, 'xxxx2', 'xxxx3', '049000s1i0n7t8445289', 'xxxxz1', '63234567090110987675defgxabc534531423576576945d7', 5, 1, 5005, 12500, 110000, 12500, 110000, '', '', '', '', -1	--

exec spu_CashBuy 1, 'farm488258', '', '7292083m4k0w0v465454', 'TX_00000000336681', '78390123786776543520ojav3771471905940794042700106', 1,
	0, 5000,   310,   3300,   310,   3300, 'skt', '{"appid":"OA00700316","txid":"TX_00000000336681","signdata":"MIIIBAYJKoZIhvcNAQcCoIIH9TCCB\/ECAQExDzANBglghkgBZQMEAgEFADBjBgkqhkiG9w0BBwGgVgRUMjAxNjA1MTgxNzE1MzZ8VFhfMDAwMDAwMDAzMzY2ODF8MDEwMzI0ODMxNDR8T0EwMDcwMDMxNnwwOTEwMDQ3MDc5fDMzMDB8fHy357rxIDMxMLCzoIIF7jCCBeowggTSoAMCAQICBAEDYIQwDQYJKoZIhvcNAQELBQAwTzELMAkGA1UEBhMCS1IxEjAQBgNVBAoMCUNyb3NzQ2VydDEVMBMGA1UECwwMQWNjcmVkaXRlZENBMRUwEwYDVQQDDAxDcm9zc0NlcnRDQTIwHhcNMTUxMjE2MDUyMzAwWhcNMTYxMjIxMTQ1OTU5WjCBjDELMAkGA1UEBhMCS1IxEjAQBgNVBAoMCUNyb3NzQ2VydDEVMBMGA1UECwwMQWNjcmVkaXRlZENBMRswGQYDVQQLDBLtlZzqta3soITsnpDsnbjspp0xDzANBgNVBAsMBuyEnOuyhDEkMCIGA1UEAwwb7JeQ7Iqk7LyA7J20IO2UjOuemOuLmyjso7wpMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA0Ldr5ayjfKQiow61No6GPTX3M7ooj+IoZ18eN+KDRk7CJjLP+rg6pUZja0bDhwIxjLgeUo5ohJAndCbRwapXRgfegbO5B89dIBhy5qxHpnIPg8pSgyl9YdmBH0OinEJLesv5P0jieLH6FeoRhSRecJZpQXR3XtYMB2pltB4\/yA6NCN946ytbEU5aRzLYZtqcZ6ubtkZnGW63ZLXR9gc0lhFS07h6yLZp64h4WzD8KivTFC\/cIWfy59a\/hZJFFBlu7lw30aSZGqmEQe2Sx1F\/dGz3E0BObnj0Iqnrl5boBcMUHrKQW\/uOnr8tCg1Gh4fl+03dWiqrBn9Nlna+2yjAhQIDAQABo4ICjjCCAoowgY8GA1UdIwSBhzCBhIAUtnSpm5I8x1GxIqRPvLc8\/iIz13ahaKRmMGQxCzAJBgNVBAYTAktSMQ0wCwYDVQQKDARLSVNBMS4wLAYDVQQLDCVLb3JlYSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eSBDZW50cmFsMRYwFAYDVQQDDA1LSVNBIFJvb3RDQSA0ggIQBDAdBgNVHQ4EFgQU08zNJ\/AGJIS3R7YThWPmVV7WtGowDgYDVR0PAQH\/BAQDAgbAMIGDBgNVHSABAf8EeTB3MHUGCiqDGoyaRAUEAQMwZzAtBggrBgEFBQcCARYhaHR0cDovL2djYS5jcm9zc2NlcnQuY29tL2Nwcy5odG1sMDYGCCsGAQUFBwICMCoeKLz4ACDHeMmdwRzHWAAgxyDWqK4wrATHQAAgADGxRAAgx4WyyLLkAC4wegYDVR0RBHMwcaBvBgkqgxqMmkQKAQGgYjBgDBvsl5DsiqTsvIDsnbQg7ZSM656Y64ubKOyjvCkwQTA\/BgoqgxqMmkQKAQEBMDEwCwYJYIZIAWUDBAIBoCIEIO0ndMlciC8i4rXTTabKVdLuz5aS3Pb\/9gsDeciXqGuVMH0GA1UdHwR2MHQwcqBwoG6GbGxkYXA6Ly9kaXIuY3Jvc3NjZXJ0LmNvbTozODkvY249czFkcDlwNzQsb3U9Y3JsZHAsb3U9QWNjcmVkaXRlZENBLG89Q3Jvc3NDZXJ0LGM9S1I\/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdDBGBggrBgEFBQcBAQQ6MDgwNgYIKwYBBQUHMAGGKmh0dHA6Ly9vY3NwLmNyb3NzY2VydC5jb206MTQyMDMvT0NTUFNlcnZlcjANBgkqhkiG9w0BAQsFAAOCAQEAlx3K2jB9idefvdGomJFtXxcg6a2iB\/ydOcP1G04uTNRX2ddRpT5LS38dUlmreiwepWzBASsDB6FPnt21T9FXSn9Ouyx0FGlaAucluDHjZ+cTCbXtwutGTepy23AR3\/d7BUeUTrrV1b78SWLhSxySsXCrVlV8vZsVJx3mnDvcyEeJG7wgEzk4ZS9YUzYO3PrWUfgIPY+AXuJs8tPf33O0XlD8OM8AXiw0cGJhnldbv0e0rV9uzlNRKXvFf1BHSSUFm2Xfjxxkxuv0SSRtObS0w4k91ffFBDuQc74IDEGQzjwCErCazer1v5tYToFxSKbq8WO\/y+hK4FYFCrJ0nU2raDGCAYIwggF+AgEBMFcwTzELMAkGA1UEBhMCS1IxEjAQBgNVBAoMCUNyb3NzQ2VydDEVMBMGA1UECwwMQWNjcmVkaXRlZENBMRUwEwYDVQQDDAxDcm9zc0NlcnRDQTICBAEDYIQwDQYJYIZIAWUDBAIBBQAwDQYJKoZIhvcNAQELBQAEggEAtbVoJBWXn0mBLRhTruCvWsG85W0y5cleK2yNZJxS\/1B\/Rt8kM8mXl9O8EmOd23G138hL1WqJrkufs1FExOhJvPbfyAKVkUphjQpFf3k5JYYKD9Q+eKAMysjEikujCLCvckcPpNYFk21Hxt0t0yOHNAa+THPVk3fUti5iQD\/iTvLygyEuU5zj7z\/sGOUUUcDJL3c5S5sOBG2TSAPhtqxTUKyGtr3oRoUmXfn\/f+JUoNS0qNXlhVlujHiD2te\/NF7EdDgEecQ\/oiQiqd5VQZkoALBL7ZE2UBCumLtFIaR01hWytujulKjSlRRimSOZJCKV0U6eAcRSFYaXz+RpEBMcxQ=="}',
	'{"product":[{"appid":"OA00700316","bp_info":"","charge_amount":3300,"detail_pname":"루비 310�?,"log_time":"20160518171536","product_id":"0910047079","tid":""}],"message":"?�상�?��?�료.","detail":"0000","count":1,"status":0}',
	'168400605', -1	--
*/
use GameMTBaseball
GO

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
	@itemcode_								int,
	@cashcost_								int,
	@cash_									int,
		@cashcost2_								int,
		@cash2_									int,
	@ikind_									varchar(256),
	@idata_									varchar(4096),
	@idata2_								varchar(4096),
	@kakaogameid_							varchar(60),
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
	declare @RESULT_ERROR_CASH_COPY				int				set @RESULT_ERROR_CASH_COPY				= -40
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- �������ڵ��ã��
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- ���������ʴ¸��
	declare @RESULT_ERROR_NOT_FOUND_GIFTID		int				set @RESULT_ERROR_NOT_FOUND_GIFTID		= -75			-- ��� > ������ ���̵� ��ã��

	------------------------------------------------
	--	2-2. ���°�
	------------------------------------------------
	-- ����ó�ڵ�
	--declare @MARKET_SKT						int				set @MARKET_SKT							= 1
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
	declare @market				int				set @market			= @MARKET_GOOGLE
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

	declare @gameyear			int				set @gameyear		= 2013
	declare @gamemonth			int				set @gamemonth		= 3
	declare @famelv				int				set @famelv			= 1
	declare @eventspot07		int				set @eventspot07	= 1
	declare @firsttime			int				set @firsttime		= 0

	-- VIPȿ��.
	declare @cashpoint			int				set @cashpoint		= 0
	declare @vip_plus			int				set @vip_plus		= 0
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
		@gameid 	= gameid,		@market		= market,		@cashpoint	= cashpoint,
		@gameyear	= gameyear,		@gamemonth	= gamemonth,
		@famelv		= famelv,		@eventspot07= eventspot07,
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
		@productid		= param4,
		@firsttime		= param10
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
	else if( @gameid = '' )
		begin
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
			select @nResult_ rtn, 'ERROR ���̵� ã�� ���߽��ϴ�.'
		end
	else if( @buycashcost = 0 )
		begin
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_ITEMCODE
			select @nResult_ rtn, 'ERROR ������ �ڵ尡 �߸��Ǿ����ϴ�.'
		end
	else if(@cashcost_ != @cashcost2_ or @cash_ != @cash2_ or @buycashcost != @cashcost_)
		begin
			set @nResult_ = @RESULT_ERROR_CASH_COPY
			select @nResult_ rtn, 'ERROR ĳ��ī��(��ó���˴ϴ�. ĳ��������ġ(-1))'

			---------------------------------------------------
			--	ĳ��ī�� �÷��� ���
			---------------------------------------------------
			update dbo.tUserMaster set cashcopy = cashcopy + 1 where gameid = @gameid_

			insert into dbo.tUserUnusualLog(gameid, comment) values(@gameid_, '**** ĳ��ī�Ǹ� �õ��߽��ϴ�(ĳ��������ġ) ****')
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
	else if(@cashcost_ > @BUY_MAX_CASHCOST)
		begin
			set @nResult_ = @RESULT_ERROR_CASH_COPY
			select @nResult_ rtn, 'ERROR ĳ��ī��(��ó���˴ϴ�.��ȿ�����ʴ� ĳ��(-3))'

			---------------------------------------------------
			--	ĳ��ī�� �÷��� ���
			---------------------------------------------------
			update dbo.tUserMaster set cashcopy = cashcopy + 1 where gameid = @gameid_

			insert into dbo.tUserUnusualLog(gameid, comment) values(@gameid_, '**** ĳ��ī�Ǹ� �õ��߽��ϴ�(��ȿ�����ʴ� ĳ��) ****')
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
	else if(@acode_ != '' and exists(select top 1 * from dbo.tCashLog where acode = @acode_))
		begin
			set @nResult_ = @RESULT_ERROR_CASH_COPY
			select @nResult_ rtn, 'ERROR ĳ��ī��(��ó���˴ϴ�.�ߺ���û(-5))'

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

			------------------------------------------------
			---- EVENT 7.24 ~ 8.6
			------------------------------------------------
			-- �ݾ� �� ���ִ� ����.
			if( @firsttime = 1 )
				begin
					--select 'DEBUG ���ְ����ΰ�'
					set @buycashcost = 2 *@buycashcostorg
				end
			else if( @eventplus = 1 and @pluscashcost > 0 and @pluscashcost <= 100)
				begin
					set @buycashcost = @buycashcostorg + (@buycashcostorg * @pluscashcost / 100)
				end

			set @vip_plus = dbo.fun_GetVIPPlus( 1, @cashpoint, @buycashcostorg) -- ĳ������.
			set @buycashcost = @buycashcost + @vip_plus


			if(@mode_ = @CASH_MODE_BUYMODE)
				begin
					---------------------------------------------------
					-- 5���� �̻� ���Ž� �ϲ� ����(100005)
					---------------------------------------------------
					if( @eventspot07 = 0 and @cash_ >= 55000 )
						begin
							exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT, 100005, 1, 'ĳ�� �̺�Ʈ', @gameid_, ''
							set @eventspot07 = @eventspot07 + 1
						end

					---------------------------------------------------
					-- �������� > ĳ��Pluse
					---------------------------------------------------
					update dbo.tUserMaster
						set
							cashcost 	= cashcost + @buycashcost,
							eventspot07	= @eventspot07,
							cashpoint 	= cashpoint + @buycash
					where gameid = @gameid_

					---------------------------------------------------
					-- �������� > ���ű���ϱ�
					---------------------------------------------------
					insert into dbo.tCashLog(gameid,   acode,   ucode,      cashcost,     cash,  market,   ikind,   idata,   idata2,   kakaogameid,   kakaouk,  gameyear,  gamemonth,  famelv,  productid)
					values(                 @gameid_, @acode_, @ucode_, @buycashcost, @buycash, @market_, @ikind_, @idata_, @idata2_, @kakaogameid_, @kakaouk, @gameyear, @gamemonth, @famelv, @productid)

					---------------------------------------------------
					-- ����ù�����ΰ�.
					---------------------------------------------------
					if( @firsttime = 1 )
						begin
							--select 'DEBUG ���ְ����ΰ�'
							insert into dbo.tCashFirstTimeLog(gameid,   itemcode)
							values(                          @gameid_, @itemcode_)

							set @comment2 = ltrim(rtrim(str(@buycashcost))) +  '����� �����Ͽ����ϴ�.(����ù����)'

							exec spu_DayLogInfoStatic @market_, 82, 1				-- �� ĳ������(����)
						end
					else
						begin
							set @comment2 = ltrim(rtrim(str(@buycashcost))) +  '����� �����Ͽ����ϴ�.'

							exec spu_DayLogInfoStatic @market_, 81, 1				-- �� ĳ������(�Ϲ�)
						end


					-----------------------------------------------------
					---- �������� > ������ ���� �����ֱ�(������ ���·� ����)
					-----------------------------------------------------
					exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_MESSAGE_DEL, @itemcode_, 0, @SYSTEM_SENDID, @gameid_, @comment2
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
					insert into dbo.tCashLog(gameid,   acode,   ucode,      cashcost,     cash,  giftid,   market,   ikind,   idata,   idata2,   kakaogameid,   kakaouk,  gameyear,  gamemonth,  famelv,  productid)
					values(                 @gameid_, @acode_, @ucode_, @buycashcost, @buycash, @giftid_, @market_, @ikind_, @idata_, @idata2_, @kakaogameid_, @kakaouk, @gameyear, @gamemonth, @famelv, @productid)

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
			if(exists(select top 1 * from dbo.tCashTotal where dateid = @dateid and cashkind = @buycash and market = @market_))
				begin
					update dbo.tCashTotal
						set
							cashcost 	= cashcost 	+ @buycashcost,
							cash 		= cash 		+ @buycash,
							cnt 		= cnt 		+ 1
					where dateid = @dateid and cashkind = @buycash and market = @market_
				end
			else
				begin
					insert into dbo.tCashTotal(dateid, cashkind,  market,      cashcost,     cash)
					values(                   @dateid, @buycash, @market_, @buycashcost, @buycash)
				end

			--���� ���� �ǹ��� �������ֱ�
			select * from dbo.tUserMaster where gameid = @gameid_
		end



	------------------------------------------------
	--	4-2. ��������
	------------------------------------------------
	set nocount off
End

