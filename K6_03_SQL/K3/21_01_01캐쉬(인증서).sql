use Game4FarmVill3
GO

/*
-- ����[O], ����[O]
-- delete from tFVCashTotal
select top 10 * from dbo.tFVCashLog order by idx desc
delete from tFVCashLog where gameid in ('xxxx2', 'xxxx3')
delete from tFVGiftList where gameid in ('xxxx2', 'xxxx3')
update dbo.tFVUserMaster set vippoint = 0, cashpoint = 0, cashcost = 0 where gameid = 'xxxx2'
--					gameid           itemcode ikind      acode
exec spu_FVCashBuy3 'xxxx2', '049000s1i0n7t8445289', '',      '7000', 'googlekw', '12999763169054705758.1343569877495791', '', '', '7791', -1	-- GOOGLE(googlekw)
exec spu_FVCashBuy3 'xxxx2', '049000s1i0n7t8445289', '',      '7000', 'googlekw', '12999763169054705758.1343569877495792', '', '', '7792', -1	-- GOOGLE(googlekw)

exec spu_FVCashBuy3 'xxxx2', '049000s1i0n7t8445289', '',      '7001', 'REAL',      '1009010101',                           '', '', '7781', -1	-- NHN(REAL)
exec spu_FVCashBuy3 'xxxx2', '049000s1i0n7t8445289', '',      '7002', 'REAL',      '1009010102',                           '', '', '7782', -1	-- NHN(REAL)
exec spu_FVCashBuy3 'xxxx2', '049000s1i0n7t8445289', '',      '7003', 'REAL',      '1009010103',                           '', '', '7783', -1	-- NHN(REAL)
exec spu_FVCashBuy3 'xxxx2', '049000s1i0n7t8445289', '',      '7004', 'REAL',      '1009010104',                           '', '', '7784', -1	-- NHN(REAL)
exec spu_FVCashBuy3 'xxxx2', '049000s1i0n7t8445289', '',      '7005', 'real',      '60000134460912',                       '', '', '7785', -1	-- IPHONE(real)
exec spu_FVCashBuy3 'xxxx2', '049000s1i0n7t8445289', '',      '7006', 'skt',       'TX_00000030191561',                    '', '', '7786', -1	-- SKT(skt)
exec spu_FVCashBuy3 'xxxx2', '049000s1i0n7t8445289', '',      '7007', 'skt',       'TX_00000030191562',                    '', '', '7787', -1	-- SKT(skt)
exec spu_FVCashBuy3 'xxxx2', '049000s1i0n7t8445289', '',      '7008', 'skt',       'TX_00000030191563',                    '', '', '7788', -1	-- SKT(skt)
exec spu_FVCashBuy3 'xxxx2', '049000s1i0n7t8445289', '',      '7009', 'skt',       'TX_00000030191564',                    '', '', '7789', -1	-- SKT(skt)

exec spu_FVCashBuy3 'xxxx2', '049000s1i0n7t8445289', 'xxxx3', '7014', 'googlekw', '12999763169054705758.1343569877497010', '', '', '7771', -1	-- ģ������
exec spu_FVCashBuy3 'xxxx2', '049000s1i0n7t8445289', 'xxxx3', '7018', 'googlekw', '12999763169054705758.1343569877497011', '', '', '7772', -1

exec spu_FVCashBuy3 'xxxx2', '049000s1i0n7t8445289', '',      '7005', 'real', '��������ȣ', '��ȣ��', '�ؼ���', -1					-- IPHONE(real)
*/
IF OBJECT_ID ( 'dbo.spu_FVCashBuy3', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVCashBuy3;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_FVCashBuy3
	@gameid_								varchar(60),					-- ���Ӿ��̵�
	@password_								varchar(20),
	@giftid_								varchar(60),					-- ģ�����̵�
	@itemcode_								int,
	@ikind_									varchar(256),
	@acode_									varchar(256),					-- indexing
	@idata_									varchar(4096),
	@idata2_								varchar(4096),
	@randserial_							varchar(20),
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
	declare @EVENT01_END_DAY					datetime			set @EVENT01_END_DAY						= '2015-02-13 23:59'	-- �߰�������
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
	declare @randserial			varchar(20)		set @randserial		= ''

	declare @dateid 			varchar(8)		set @dateid 		= Convert(varchar(8), Getdate(), 112)		-- 20120819
	declare @curdate			datetime		set @curdate		= getdate()
	declare @plusvippoint		int				set @plusvippoint	= 0
	declare @pluscashcost		int				set @pluscashcost	= 0

	declare @kakaouk			varchar(19)		set @kakaouk		= substring(Convert(varchar(10),Getdate(),112), 3, 8) + Replace(Convert(varchar(12),Getdate(),114),':','') + Convert(varchar(4), Convert(int, ceiling(RAND() * 9980))+10)
	declare @kakaouserid		varchar(20)		set @kakaouserid	= ''

	declare @eventpercent		int				set @eventpercent	= 0

	-- ĳ�������� 30�ϰ� ����.
	declare @cashdatestart		smalldatetime	set @cashdatestart	= '20000101'
	declare @cashdateend		smalldatetime	set @cashdateend	= '20000101'
	declare @cashdatecur		smalldatetime	set @cashdatecur	= '20000101'
	declare @curdate2			smalldatetime	set @curdate2		= Convert(varchar(8), Getdate(), 112)
	declare @cashgift			int				set @cashgift		= -1

Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	--select 'DEBUG �Է°�', @gameid_ gameid_, @password_ password_, @giftid_ giftid_, @itemcode_ itemcode_, @ikind_ ikind_, @acode_ acode_, @randserial_ randserial_

	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	select
		@gameid 		= gameid,			@blockstate = blockstate,		@market		= market,
		@cashdatestart	= cashdatestart, 	@cashdateend = cashdateend,		@cashdatecur = cashdatecur,
		@kakaouserid	= kakaouserid,
		@randserial		= randserial
	from dbo.tFVUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG ', @gameid gameid, @blockstate blockstate, @market market, @cashdatestart cashdatestart, @cashdateend cashdateend, @cashdatecur cashdatecur


	------------------------------------------------
	--	3-2-3. �������
	------------------------------------------------
	if(@gameid = '')
		begin
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
			select @nResult_ rtn, 'ERROR ���̵� ã�� ���߽��ϴ�.'
		end
	else if(@acode_ = '' and @idata_ = '' and @idata2_ = '')
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
	else if(@itemcode_ not in (7000, 7001, 7002, 7003, 7004, 7005, 7006, 7007, 7008, 7009, 7014, 7015, 7016, 7017, 7018))
		begin
			set @nResult_ = @RESULT_ERROR_CASH_COPY
			select @nResult_ rtn, 'ERROR ĳ��ī��(�������� �ʴ� ������ �ڵ�(-5))'

			---------------------------------------------------
			--	ĳ��ī�� �÷��� ���
			---------------------------------------------------
			update dbo.tFVUserMaster set cashcopy = cashcopy + 10 where gameid = @gameid_

			insert into dbo.tFVUserUnusualLog(gameid, comment) values(@gameid_, '**** ĳ��ī�Ǹ� �õ��߽��ϴ�(�������� �ʴ� ������ �ڵ�(-5)) ****')
		end
	else if (@randserial_ = @randserial)
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			select @nResult_ rtn, 'SUCCESS ���Ÿ� ����ó���ϴ�(���Ͻø���).'
		END
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
									when @itemcode_ in (7000) then   3000	-- �̺�Ʈ.

									when @itemcode_ in (7001) then   5000	-- ����.
									when @itemcode_ in (7002) then  30000
									when @itemcode_ in (7003) then 100000

									when @itemcode_ in (7004) then   1000	-- �Ϲ�.
									when @itemcode_ in (7005) then   5000
									when @itemcode_ in (7006) then  10000
									when @itemcode_ in (7007) then  30000
									when @itemcode_ in (7008) then  60000
									when @itemcode_ in (7009) then 100000
									else 0
							end

			set @pluscashcost = case
									when @itemcode_ in (7000) then (   300 +     0 )	-- �̺�Ʈ.

									when @itemcode_ in (7001) then (  1000 +    50 )	-- ����.
									when @itemcode_ in (7002) then (  6000 +  1200 )
									when @itemcode_ in (7003) then ( 20000 + 10000 )

									when @itemcode_ in (7004) then (   100 +     0 )	-- �Ϲ�.
									when @itemcode_ in (7005) then (   500 +    25 )
									when @itemcode_ in (7006) then (  1000 +   100 )
									when @itemcode_ in (7007) then (  3000 +   600 )
									when @itemcode_ in (7008) then (  6000 +  1800 )
									when @itemcode_ in (7009) then ( 10000 +  5000 )
									else 0
							end
			--select 'DEBUG ��������', @itemcode_ itemcode_, @buycash buycash, @pluscashcost pluscashcost, @curdate curdate
			set @cashcost	= @pluscashcost
			set @vippoint	= @buycash
			set @buycash	= @buycash * 1.1
			--select 'DEBUG', @buycash buycash, @cashcost cashcost, @vippoint vippoint


			----------------------------------------------
			-- EVENT > ĳ�������� 30�ϰ� ����.
			----------------------------------------------
			if(@itemcode_ = 7000)
				begin
					--select 'DEBUG ĳ��30�ϰ� ���ޱ��'
					if(@curdate2 >= @cashdatestart and @curdate2 < @cashdateend)
						begin
							--select 'DEBUG 30�� + �ű�30�� ����'
							set @cashdatestart	= @cashdatestart
							set @cashdateend	= @cashdateend + 30
							set @cashdatecur	= Convert(varchar(8), Getdate(), 112)
						end
					else
						begin
							--select 'DEBUG �ű�30��'
							set @cashdatestart	= Convert(varchar(8), Getdate(), 112)
							set @cashdateend	= Convert(varchar(8), Getdate() + 30, 112)
							set @cashdatecur	= Convert(varchar(8), Getdate(), 112)
						end


					exec spu_FVCashCostDaily @gameid_, '�̺�Ʈ30(1��)', 3015, 100
					--exec spu_FVSubGiftSend 2, 3015, 100, '�̺�Ʈ30(1��)', @gameid_, ''
					set @cashgift = 1
				end

			------------------------------------------------
			---- ģ���� ��.
			------------------------------------------------
			if(@giftid_ != '' and @itemcode_ in (7014, 7015, 7016, 7017, 7018))
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

					set @plusvippoint = @vippoint * 20 / 100
					exec spu_FVSubGiftSend 2, @EVENT01_ITEMCODE, @plusvippoint, '�߰��̺�Ʈ', @gameid_, ''

					set @pluscashcost = @pluscashcost * @eventpercent / 100
					exec spu_FVSubGiftSend 2, @EVENT02_ITEMCODE, @pluscashcost, '�߰��̺�Ʈ', @gameid_, ''

					-- �̺�Ʈ�� �þ ���.
					set @cashcost = @cashcost + @pluscashcost
					set @vippoint = @vippoint + @plusvippoint
				end
			--else if(@curdate >= @EVENT11_START_DAY and @curdate < @EVENT11_END_DAY)
			--	begin
			--		set @plusvippoint = @vippoint * 40 / 100
			--		exec spu_FVSubGiftSend 2, @EVENT11_ITEMCODE, @plusvippoint, 'vipevent2', @gameid_, ''
			--	end
			---------------------------------------------------
			-- �������� > ĳ��Pluse
			---------------------------------------------------
			update dbo.tFVUserMaster
				set
					randserial		= @randserial_,
					cashpoint 		= cashpoint + @buycash,
					cashcost 		= cashcost + @cashcost,
					vippoint 		= vippoint + @vippoint,
					cashdatestart	= @cashdatestart,
					cashdateend 	= @cashdateend,
					cashdatecur 	= @cashdatecur
			where gameid = @gameid_
			--select 'DEBUG �����ѷ�', cashpoint from dbo.tFVUserMaster where gameid = @gameid_

			---------------------------------------------------
			-- �������� > ���ű���ϱ�
			---------------------------------------------------
			--select 'DEBUG ���ŷα�(��)', @gameid_ gameid_, @acode_ acode_, @buycash buycash, @market market, @ikind_ ikind_
			insert into dbo.tFVCashLog(gameid,   acode,      cash,  market,  ikind,   kakaouserid,  kakaouk,  giftid,   idata,   idata2)
			values(                   @gameid_, @acode_, @buycash, @market, @ikind_, @kakaouserid, @kakaouk, @giftid_, @idata_, @idata2_)
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


			if(@cashgift = 1)
				begin
					--------------------------------------------------------------
					-- ����/���� ����Ʈ ����
					--------------------------------------------------------------
					exec spu_FVGiftList @gameid_
				end
		end


	------------------------------------------------
	--	4-2. ��������
	------------------------------------------------
	set nocount off
End

