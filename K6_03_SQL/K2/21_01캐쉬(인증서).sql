use Farm
GO

/*
-- ����[O], ����[O]
-- delete from tFVCashTotal
delete from tFVCashLog where gameid in ('xxxx@gmail.com', 'xxxx3')
delete from tFVGiftList where gameid in ('xxxx@gmail.com', 'xxxx3')
update dbo.tFVUserMaster set vippoint = 0, cashpoint = 0, cashcost = 0 where gameid = 'xxxx@gmail.com'
--					gameid           itemcode ikind      acode
exec spu_FVCashBuy2 'xxxx@gmail.com',  '01022223331', '', '7000', 'googlekw', '12999763169054705758.1343569877495792', -1	-- GOOGLE(googlekw)
exec spu_FVCashBuy2 'xxxx@gmail.com',  '01022223331', '', '7004', 'REAL', '1009010102', -1								-- NHN(REAL)
exec spu_FVCashBuy2 'xxxx@gmail.com',  '01022223331', '', '7005', 'real', '60000134460912', -1							-- IPHONE(real)
exec spu_FVCashBuy2 'xxxx@gmail.com',  '01022223331', '', '7009', 'skt', 'TX_00000030191562', -1							-- SKT(skt)

exec spu_FVCashBuy2 'xxxx@gmail.com',  '01022223331', '',      '7000', 'googlekw', '12999763169054705758.1343569877497000', -1	-- ģ������
exec spu_FVCashBuy2 'xxxx@gmail.com',  '01022223331', 'xxxx3', '7010', 'googlekw', '12999763169054705758.1343569877497010', -1	-- ģ������
exec spu_FVCashBuy2 'xxxx@gmail.com',  '01022223331', 'xxxx3', '7011', 'googlekw', '12999763169054705758.1343569877497011', -1
exec spu_FVCashBuy2 'xxxx@gmail.com',  '01022223331', 'xxxx3', '7012', 'googlekw', '12999763169054705758.1343569877497012', -1
exec spu_FVCashBuy2 'xxxx@gmail.com',  '01022223331', 'xxxx3', '7013', 'googlekw', '12999763169054705758.1343569877497013', -1
exec spu_FVCashBuy2 'xxxx@gmail.com',  '01022223331', 'xxxx3', '7014', 'googlekw', '12999763169054705758.1343569877497014', -1
*/
IF OBJECT_ID ( 'dbo.spu_FVCashBuy2', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVCashBuy2;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_FVCashBuy2
	@gameid_								varchar(60),					-- ���Ӿ��̵�
	@phone_									varchar(20),
	@giftid_								varchar(60),					-- ģ�����̵�
	@itemcode_								int,
	@ikind_									varchar(256),
	@acode_									varchar(256),					-- indexing
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
	--declare @RESULT_ERROR_DELETED_USER 		int				set @RESULT_ERROR_DELETED_USER			= -12			--�������� > �˾�ó���� ��Ʈ�η� ��������.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--�ش������� ã�� ����
	--declare @RESULT_ERROR_NOT_FOUND_PASSWORD	int				set @RESULT_ERROR_NOT_FOUND_PASSWORD	= -17
	--declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--������ �����ϰ� �ִ�.
	--declare @RESULT_NEWVERION_CLIENT_DOWNLOAD int				set @RESULT_NEWVERION_CLIENT_DOWNLOAD	= -15			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ��ũó��.
	--declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ����.

	-- ��������.
	declare @RESULT_ERROR_CASH_COPY				int				set @RESULT_ERROR_CASH_COPY				= -40
	--declare @RESULT_ERROR_CASH_OVER			int				set @RESULT_ERROR_CASH_OVER				= -41

	------------------------------------------------
	--	2-2. ���°�
	------------------------------------------------
	-- ����ó�ڵ�
	--declare @MARKET_SKT						int				set @MARKET_SKT							= 1
	--declare @MARKET_KT						int				set @MARKET_KT							= 2
	--declare @MARKET_LGT						int				set @MARKET_LGT							= 3
	declare @MARKET_GOOGLE						int				set @MARKET_GOOGLE						= 5
	--declare @MARKET_NHN						int				set @MARKET_NHN							= 6
	--declare @MARKET_IPHONE					int				set @MARKET_IPHONE						= 7

	-- ���°�.
	declare @BLOCK_STATE_NO						int				set	@BLOCK_STATE_NO						= 0				-- �����¾ƴ�
	declare @BLOCK_STATE_YES					int				set	@BLOCK_STATE_YES					= 1				-- ������

	-- ���� ���ǰ�
	--declare @GIFTLIST_GIFT_KIND_MESSAGE		int					set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	--declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2
	--declare @GIFTLIST_GIFT_KIND_MESSAGE_DEL	int					set @GIFTLIST_GIFT_KIND_MESSAGE_DEL			= -1
	--declare @GIFTLIST_GIFT_KIND_GIFT_DEL		int					set @GIFTLIST_GIFT_KIND_GIFT_DEL			= -2
	--declare @GIFTLIST_GIFT_KIND_GIFT_GET		int					set @GIFTLIST_GIFT_KIND_GIFT_GET			= -3
	--declare @GIFTLIST_GIFT_KIND_GIFT_SELL		int					set @GIFTLIST_GIFT_KIND_GIFT_SELL			= -4

	----------------------------------------------
	-- ���б� �̺�Ʈ
	-- �Ⱓ : 2015.02.13 ~ 03.14 > �Ѱ� �������ϴ� ���
	----------------------------------------------
	declare @EVENT01_START_DAY					datetime			set @EVENT01_START_DAY						= '2015-02-12'
	declare @EVENT01_END_DAY					datetime			set @EVENT01_END_DAY						= '2015-05-31 23:59'	-- �߰�������
	declare @EVENT01_ITEMCODE					int					set @EVENT01_ITEMCODE						= 3200	-- VIP����   20%
	declare @EVENT02_ITEMCODE					int					set @EVENT02_ITEMCODE						= 3015	-- ��������  20%
    --
	declare @EVENT11_START_DAY					datetime			set @EVENT11_START_DAY						= '2015-02-18'
	declare @EVENT11_END_DAY					datetime			set @EVENT11_END_DAY						= '2015-02-22 23:59'	-- + 30%�߰�.

	------------------------------------------------
	--	2-3. ���λ�� ����
	------------------------------------------------
	declare @comment2			varchar(80)
	declare @comment3			varchar(60)
	declare @gameid				varchar(60)		set @gameid			= ''
	declare @blockstate			int				set @blockstate		= @BLOCK_STATE_NO
	declare @market				int				set @market			= @MARKET_GOOGLE
	declare @buycash			int				set @buycash		= 0
	declare @cashcost			int				set @cashcost		= 0
	declare @vippoint			int				set @vippoint		= 0

	declare @dateid 			varchar(8)		set @dateid 		= Convert(varchar(8), Getdate(), 112)		-- 20120819
	declare @curdate			datetime		set @curdate		= getdate()
	declare @plusvippoint		int				set @plusvippoint	= 0
	declare @pluscashcost		int				set @pluscashcost	= 0

	declare @kakaouk			varchar(19)		set @kakaouk		= substring(Convert(varchar(10),Getdate(),112), 3, 8) + Replace(Convert(varchar(12),Getdate(),114),':','') + Convert(varchar(4), Convert(int, ceiling(RAND() * 9980))+10)
	declare @kakaouserid		varchar(20)		set @kakaouserid	= ''

	declare @eventpercent		int				set @eventpercent	= 0

Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	--select 'DEBUG �Է°�', @gameid_ gameid_, @password_ password_, @giftid_ giftid_, @itemcode_ itemcode_, @ikind_ ikind_, @acode_ acode_

	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	select
		@gameid 	= gameid,
		@blockstate = blockstate,
		@market		= market,
		@kakaouserid= kakaouserid
	from dbo.tFVUserMaster
	where gameid = @gameid_ and phone = @phone_

	------------------------------------------------
	--	3-2-3. �������
	------------------------------------------------
	if(@gameid = '')
		begin
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
			select @nResult_ rtn, 'ERROR ���̵� ã�� ���߽��ϴ�.'
		end
	else if (@blockstate = @BLOCK_STATE_YES)
		BEGIN
			-- �������ΰ�?
			set @nResult_ 	= @RESULT_ERROR_BLOCK_USER
			select @nResult_ rtn, '��ó���� ���̵��Դϴ�.'
		END
	else if(@itemcode_ not in (7000, 7001, 7002, 7003, 7004, 7005, 7006, 7007, 7008, 7009, 7010, 7011, 7012, 7013, 7014))
		begin
			set @nResult_ = @RESULT_ERROR_CASH_COPY
			select @nResult_ rtn, 'ERROR ĳ��ī��(�������� �ʴ� ������ �ڵ�(-5))'

			---------------------------------------------------
			--	ĳ��ī�� �÷��� ���
			---------------------------------------------------
			update dbo.tFVUserMaster set cashcopy = cashcopy + 10 where gameid = @gameid_

			insert into dbo.tFVUserUnusualLog(gameid, comment) values(@gameid_, '**** ĳ��ī�Ǹ� �õ��߽��ϴ�(�������� �ʴ� ������ �ڵ�(-5)) ****')
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

			-- ����, ���� ������ �ڵ� ���� ����.
			set @buycash = case
									when @itemcode_ in (7000, 7005, 7010) then 5000
									when @itemcode_ in (7001, 7006, 7011) then 10000
									when @itemcode_ in (7002, 7007, 7012) then 30000
									when @itemcode_ in (7003, 7008, 7013) then 55000
									when @itemcode_ in (7004, 7009, 7014) then 99000
									else 0
							end


			set @pluscashcost = case
									when @itemcode_ in (7000, 7005, 7010) then 5000
									when @itemcode_ in (7001, 7006, 7011) then 12000
									when @itemcode_ in (7002, 7007, 7012) then 39000
									when @itemcode_ in (7003, 7008, 7013) then 77000
									when @itemcode_ in (7004, 7009, 7014) then 148500
									else 0
							end
			--select 'DEBUG ��������', @itemcode_ itemcode_, @buycash buycash, @pluscashcost pluscashcost, @curdate curdate
			set @cashcost	= @pluscashcost
			set @vippoint	= @buycash

			----------------------------------------------
			-- ģ���� ��.
			----------------------------------------------
			if(@giftid_ != '' and @itemcode_ in (7010, 7011, 7012, 7013, 7014))
				begin
					--select 'DEBUG ģ������ ����(' + @gameid_ + ' -> ' + @giftid_ + ')', @buycash buycash, @cashcost cashcost
					set @comment3 = 'ģ��(' + @gameid_ + ')'
					exec spu_FVSubGiftSend 2, 3015, @cashcost, @comment3 , @giftid_, ''
				end

			----------------------------------------------
			-- EVENT > �����ϱ�.
			----------------------------------------------
			if(@curdate >= @EVENT01_START_DAY and @curdate < @EVENT01_END_DAY)
				begin
					--select 'DEBUG �̺�Ʈ'
					set @eventpercent = 20
					if(@curdate >= @EVENT11_START_DAY and @curdate < @EVENT11_END_DAY)
						begin
							set @eventpercent = 50
						end

					set @plusvippoint = @buycash * 20 / 100
					exec spu_FVSubGiftSend 2, @EVENT01_ITEMCODE, @plusvippoint, '�߰��̺�Ʈ', @gameid_, ''

					set @pluscashcost = @pluscashcost * @eventpercent / 100
					exec spu_FVSubGiftSend 2, @EVENT02_ITEMCODE, @pluscashcost, '�߰��̺�Ʈ', @gameid_, ''

					-- �̺�Ʈ�� �þ ���.
					set @cashcost = @cashcost + @pluscashcost
					set @vippoint = @vippoint + @plusvippoint
				end
			--else if(@curdate >= @EVENT11_START_DAY and @curdate < @EVENT11_END_DAY)
			--	begin
			--		set @plusvippoint = @buycash * 40 / 100
			--		exec spu_FVSubGiftSend 2, @EVENT11_ITEMCODE, @plusvippoint, 'vipevent2', @gameid_, ''
			--	end

			---------------------------------------------------
			-- �������� > ĳ��Pluse
			---------------------------------------------------
			update dbo.tFVUserMaster
				set
					cashpoint 	= cashpoint + @buycash,
					cashcost 	= cashcost + @cashcost,
					vippoint 	= vippoint + @vippoint
			where gameid = @gameid_
			--select 'DEBUG �����ѷ�', cashpoint from dbo.tFVUserMaster where gameid = @gameid_

			---------------------------------------------------
			-- �������� > ���ű���ϱ�
			---------------------------------------------------
			--select 'DEBUG ���ŷα�(��)', @gameid_ gameid_, @acode_ acode_, @buycash buycash, @market market, @ikind_ ikind_
			insert into dbo.tFVCashLog(gameid,   acode,      cash,  market,  ikind,   kakaouserid,  kakaouk,  giftid)
			values(                   @gameid_, @acode_, @buycash, @market, @ikind_, @kakaouserid, @kakaouk, @giftid_)
			--select 'DEBUG ���ŷα�(��)', * from dbo.tFVCashLog where gameid = @gameid_

			---------------------------------------------------
			-- ��Ż�α� ����ϱ�
			---------------------------------------------------
			if(exists(select top 1 * from dbo.tFVCashTotal where dateid = @dateid and cashkind = @buycash and market = @market))
				begin
					update dbo.tFVCashTotal
						set
							cash 		= cash 		+ @buycash,
							cnt 		= cnt 		+ 1
					where dateid = @dateid and cashkind = @buycash and market = @market

					--select 'DEBUG ������Ż ����', * from dbo.tFVCashTotal where dateid = @dateid and cashkind = @buycash and market = @market
				end
			else
				begin
					insert into dbo.tFVCashTotal(dateid, cashkind,  market,      cash)
					values(                     @dateid, @buycash, @market,   @buycash)

					--select 'DEBUG ������Ż �Է�', * from dbo.tFVCashTotal where dateid = @dateid and cashkind = @buycash and market = @market
				end

			--���� ������ �ǹ��� �������ֱ�
			select * from dbo.tFVUserMaster where gameid = @gameid_
		end



	------------------------------------------------
	--	4-2. ��������
	------------------------------------------------
	set nocount off
End

