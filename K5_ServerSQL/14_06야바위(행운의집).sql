---------------------------------------------------------------
/*
-- �߹��� ����Ʈ ����.
update dbo.tUserMaster set cashcost = 10000, gamecost = 100000, yabauidx = 1, yabaustep = 0, yabaunum = -1, randserial = -1 where gameid = 'xxxx2'
exec spu_RoulYabau 'xxxx2', '049000s1i0n7t8445289', 1,     -1, -1	-- ����Ʈ ����
exec spu_RoulYabau 'farm939089965', '9826449f4y8p8t884474', 1,     -1, -1

-- �߹��� �̱�.
update dbo.tUserMaster set cashcost = 0, gamecost = 0, yabauidx = 1, yabaustep = 0, yabaunum = -1, randserial = -1 where gameid = 'xxxx2'
update dbo.tUserMaster set cashcost = 10000, gamecost = 100000, yabauidx = 1, yabaustep = 0, yabaunum = -1, randserial = -1 where gameid = 'xxxx2'
exec spu_RoulYabau 'xxxx2', '049000s1i0n7t8445289', 2, 11111, -1	-- �Ϲݾ߹���
exec spu_RoulYabau 'xxxx2', '049000s1i0n7t8445289', 2, 11112, -1	-- �Ϲݾ߹���
exec spu_RoulYabau 'xxxx2', '049000s1i0n7t8445289', 3, 22222, -1	-- �����̾��߹���
exec spu_RoulYabau 'xxxx2', '049000s1i0n7t8445289', 3, 22223, -1	-- �����̾��߹���

-- �߹��� �޾ư��� > ����Ʈ ���ŵ�.
delete from dbo.tGiftList where gameid in ('xxxx2')
update dbo.tUserMaster set yabauidx = 1, yabaucount = 0, yabaustep = 1 where gameid = 'xxxx2'
exec spu_RoulYabau 'xxxx2', '049000s1i0n7t8445289', 4,     40, -1	-- �޾ư��� ����
*/
use Game4Farmvill5
GO

IF OBJECT_ID ( 'dbo.spu_RoulYabau', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_RoulYabau;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_RoulYabau
	@gameid_				varchar(20),
	@password_				varchar(20),
	@mode_					int,
	@randserial_			varchar(20),
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
	--declare @RESULT_ERROR_DELETED_USER 		int				set @RESULT_ERROR_DELETED_USER			= -12			--�������� > �˾�ó���� ��Ʈ�η� ��������.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--�ش������� ã�� ����
	--declare @RESULT_ERROR_NOT_FOUND_PASSWORD	int				set @RESULT_ERROR_NOT_FOUND_PASSWORD	= -17
	--declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--������ �����ϰ� �ִ�.
	--declare @RESULT_NEWVERION_CLIENT_DOWNLOAD int				set @RESULT_NEWVERION_CLIENT_DOWNLOAD	= -15			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ��ũó��.
	--declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ����.

	-- �����߿� ����.
	--declare @RESULT_ERROR_HEART_LACK			int				set @RESULT_ERROR_HEART_LACK			= -20			--��Ʈ�� �����ϴ�.
	declare @RESULT_ERROR_GAMECOST_LACK			int				set @RESULT_ERROR_GAMECOST_LACK			= -21			--�ǹ��� �����ϴ�.
	declare @RESULT_ERROR_CASHCOST_LACK			int				set @RESULT_ERROR_CASHCOST_LACK			= -22			--��尡 �����ϴ�.
	--declare @RESULT_ERROR_ITEM_LACK			int				set @RESULT_ERROR_ITEM_LACK				= -23			--�������̺����ϴ�.

	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- �������ڵ��ã��

	-- ��Ÿ����
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- ���������ʴ¸��
	declare @RESULT_ERROR_CANNT_CHANGE			int				set @RESULT_ERROR_CANNT_CHANGE			= -146			-- ������ �� �����ϴ�..

	------------------------------------------------
	--	2-2. ���ǵȰ�
	------------------------------------------------
	-- ������ ȹ����
	--declare @DEFINE_HOW_GET_FIRST				int					set @DEFINE_HOW_GET_FIRST					= 0	--�⺻
	--declare @DEFINE_HOW_GET_BUY				int					set @DEFINE_HOW_GET_BUY						= 1	--����
	--declare @DEFINE_HOW_GET_SEEDFIELD			int					set @DEFINE_HOW_GET_SEEDFIELD				= 2	--����
	--declare @DEFINE_HOW_GET_ROULETTE			int					set @DEFINE_HOW_GET_ROULETTE				= 3	--����/�̱�
	--declare @DEFINE_HOW_GET_SEARCH			int					set @DEFINE_HOW_GET_SEARCH					= 4	--�˻�
	--declare @DEFINE_HOW_GET_GIFT				int					set @DEFINE_HOW_GET_GIFT					= 5	--����
	--declare @DEFINE_HOW_GET_TODAYBUY			int					set @DEFINE_HOW_GET_TODAYBUY				= 6	--[��]���ø��Ǹ�
	--declare @DEFINE_HOW_GET_PETROLL			int					set @DEFINE_HOW_GET_PETROLL					= 7	--[��]�̱�
	--declare @DEFINE_HOW_GET_ROULACC			int					set @DEFINE_HOW_GET_ROULACC					= 9	--�Ǽ��̱�
	--declare @DEFINE_HOW_GET_ACCSTRIP			int					set @DEFINE_HOW_GET_ACCSTRIP				= 10--�Ǽ�����
	--declare @DEFINE_HOW_GET_COMPOSE			int					set @DEFINE_HOW_GET_COMPOSE					= 11--�ռ�
	declare @DEFINE_HOW_GET_YABAU				int					set @DEFINE_HOW_GET_YABAU					= 12--�߹����̱�

	-- ���� ���ǰ�
	--declare @GIFTLIST_GIFT_KIND_MESSAGE		int					set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2
	--declare @GIFTLIST_GIFT_KIND_MESSAGE_DEL	int					set @GIFTLIST_GIFT_KIND_MESSAGE_DEL			= -1
	--declare @GIFTLIST_GIFT_KIND_GIFT_DEL		int					set @GIFTLIST_GIFT_KIND_GIFT_DEL			= -2
	--declare @GIFTLIST_GIFT_KIND_GIFT_GET		int					set @GIFTLIST_GIFT_KIND_GIFT_GET			= -3
	--declare @GIFTLIST_GIFT_KIND_GIFT_SELL		int					set @GIFTLIST_GIFT_KIND_GIFT_SELL			= -4

	-- ����� �ֻ��� ���.
	declare @MODE_YABAU_RESET					int					set @MODE_YABAU_RESET						= 1		-- ����Ʈ ����
	declare @MODE_YABAU_NORMAL					int					set @MODE_YABAU_NORMAL						= 2		-- �Ϲݾ߹���
	declare @MODE_YABAU_PREMINUM				int					set @MODE_YABAU_PREMINUM					= 3		-- �����̾��߹���
	declare @MODE_YABAU_REWARD					int					set @MODE_YABAU_REWARD						= 4		-- �޾ư��� ����

	-----------------------------------------------
	-- ����� �ֻ��� �����
	-- 0    ~      L0 / L1  ~   L2
	--       ����߰�
	-----------------------------------------------
	declare @YABAU_CHANGE_DANGA					int					set @YABAU_CHANGE_DANGA						= 100
	declare @YABAU_COUNT_L0						int					set @YABAU_COUNT_L0							= 40	-- Limit
	declare @YABAU_COUNT_L1						int					set @YABAU_COUNT_L1							= 30	-- 40�޼�, 20�̴޼�,
	declare @YABAU_COUNT_L2						int					set @YABAU_COUNT_L2							= 80

	-- ����������
	declare @ITEMCODE_YABAU_CHANGE				int					set @ITEMCODE_YABAU_CHANGE					= 80000
	------------------------------------------------
	--	2-3. ���λ�� ����
	------------------------------------------------
	declare @comment		varchar(80)
	declare @gameid			varchar(20)		set @gameid			= ''	-- ��������.
	declare @cashcost		int				set @cashcost 		= 0
	declare @gamecost		int				set @gamecost 		= 0
	declare @yabauidx		int				set @yabauidx 		= 1
	declare @yabaustep		int				set @yabaustep 		= 0
	declare @yabaunum		int				set @yabaunum 		= 2
	declare @yabauresult	int				set @yabauresult 	= 0
	declare @yabauchange	int				set @yabauchange 	= 99999
	declare @yabaucount		int				set @yabaucount		= 0
	declare @yabautemp		int				set @yabautemp		= 0
	declare @randserial		varchar(20)		set @randserial 	= '-1'
	declare @famelv			int				set @famelv 		= 0
	declare @market			int				set @market 		= 1
	declare @strmarket		varchar(40)

	declare @itemcode		int				set @itemcode 		= -1	-- ��������.
	declare @bresult		int				set @bresult		= -1
	declare @pack11			int				set @pack11			= -1
	declare @pack21			int				set @pack21			= -1
	declare @pack31			int				set @pack31			= -1
	declare @pack41			int				set @pack41			= -1
	declare @pack51			int				set @pack51			= -1
	declare @pack61			int				set @pack61			= -1
	declare @needyabaunum	int				set @needyabaunum	= 12
	declare @needgamecost	int				set @needgamecost	= 999999
	declare @needgcashcost	int				set @needgcashcost	= 999999
	declare @rand			int				set @rand			= 0

	declare @dateid8 		varchar(8)		set @dateid8 		= Convert(varchar(8),Getdate(),112)
	declare @dateid6 		varchar(6)		set @dateid6 		= Convert(varchar(6),Getdate(),112)
	declare @curhour		int				set @curhour		= DATEPART(Hour, getdate())
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	set @comment  = '�˼� ���� ������ �߻��߽��ϴ�.'
	--select 'DEBUG 3-1 �Է°�', @gameid_ gameid_, @password_ password_, @mode_ mode_, @randserial_ randserial_

	------------------------------------------------
	--	3-2. �������(��������, ��������, ������ ����)
	------------------------------------------------
	select
		@gameid 		= gameid,
		@cashcost		= cashcost,
		@gamecost		= gamecost,
		@famelv			= famelv,
		@market			= market,

		@yabauidx		= yabauidx,
		@yabaustep		= yabaustep,
		@yabaunum		= yabaunum,
		@yabauresult	= yabauresult,
		@yabauchange	= ((famelv / 10 + 1)*(famelv / 10 + 1) * @YABAU_CHANGE_DANGA),
		@yabaucount		= yabaucount,
		@randserial		= randserial
	from dbo.tUserMaster where gameid = @gameid_ and password = @password_
	--select 'DEBUG 3-2 ��������', @gameid gameid, @cashcost cashcost, @gamecost gamecost, @yabauidx yabauidx, @yabaustep yabaustep, @yabaunum yabaunum, @randserial randserial, @yabauchange yabauchange

	--------------------------------------
	-- ������ ã�ư��� > ������ ����.
	--------------------------------------
	select
		@itemcode	= itemcode,
		@pack11  	= pack11,
		@pack21  	= pack21,
		@pack31  	= pack31,
		@pack41  	= pack41,
		@pack51  	= pack51,
		@pack61  	= pack61,
		@needyabaunum= case
						when @yabaustep = 0 then pack12
						when @yabaustep = 1 then pack22
						when @yabaustep = 2 then pack32
						when @yabaustep = 3 then pack42
						when @yabaustep = 4 then pack52
						when @yabaustep = 5 then pack62
						else 0
					end,
		@needgcashcost= case
						when @yabaustep = 0 then pack13
						when @yabaustep = 1 then pack23
						when @yabaustep = 2 then pack33
						when @yabaustep = 3 then pack43
						when @yabaustep = 4 then pack53
						when @yabaustep = 5 then pack63
						else 0
					end,
		@needgamecost= case
						when @yabaustep = 0 then pack14
						when @yabaustep = 1 then pack24
						when @yabaustep = 2 then pack34
						when @yabaustep = 3 then pack44
						when @yabaustep = 4 then pack54
						when @yabaustep = 5 then pack64
						else 0
					end
	from dbo.tSystemYabau where idx = @yabauidx
	--select 'DEBUG ������', @yabaustep yabaustep, @pack11 pack11, @pack21 pack21, @pack31 pack31, @pack41 pack41, @pack51 pack51, @pack61 pack61, @needyabaunum needyabaunum, @needgcashcost needgcashcost, @needgamecost needgamecost

	------------------------------------------------
	--	3-3. ����Ȳ���� �ڵ�� �з�
	------------------------------------------------
	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR ���̵� �������� �ʴ´�.'
			--select 'DEBUG ' + @comment
		END
	else if (@mode_ not in (@MODE_YABAU_NORMAL, @MODE_YABAU_PREMINUM, @MODE_YABAU_RESET, @MODE_YABAU_REWARD))
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment 	= 'ERROR �������� �ʴ� ����Դϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if (@mode_ = @MODE_YABAU_RESET)
		BEGIN
			if (@gamecost < @yabauchange)
				BEGIN
					set @nResult_ = @RESULT_ERROR_GAMECOST_LACK
					set @comment = 'ERROR ���������� �����մϴ�.'
					--select 'DEBUG ' + @comment
				END
			else if (@yabaustep > 0)
				BEGIN
					set @nResult_ = @RESULT_ERROR_CANNT_CHANGE
					set @comment = 'ERROR ������ �� �����ϴ�.'
					--select 'DEBUG ' + @comment
				END
			else
				BEGIN
					set @nResult_ = @RESULT_SUCCESS
					set @comment = 'SUCCESS ��ü�߽��ϴ�.'
					--select 'DEBUG ' + @comment

					----------------------------------------------
					-- �߹��� �ε����� ���Ѵ�.
					----------------------------------------------
					set @strmarket = '%' + ltrim(rtrim(str(@market))) + '%'

					select top 1 @yabauidx = idx from dbo.tSystemYabau
					where idx != @yabauidx
						and famelvmin <= @famelv
						and @famelv <= famelvmax
						and packstate = 1
						and packmarket like @strmarket
						order by newid()

					-- ����� �������ش�.
					set @gamecost = @gamecost - @yabauchange

					------------------------
					-- ���ŷα� ���.
					------------------------
					exec spu_UserItemBuyLogNew @gameid_, @ITEMCODE_YABAU_CHANGE, @yabauchange, 0, 0

					------------------------
					-- �߹����α�(����).
					------------------------
					insert into dbo.tYabauLogPerson(gameid,   itemcode, kind,   framelv,  yabauchange,  yabaucount, remaingamecost, remaincashcost)
					values(                        @gameid_, @itemcode, @mode_, @famelv, @yabauchange, @yabaucount,      @gamecost,      @cashcost)
				END
		END
	else if (@mode_ = @MODE_YABAU_REWARD)
		BEGIN
			if (@yabaustep < 0 or @yabaustep > 6)
				BEGIN
					set @nResult_ = @RESULT_ERROR_NOT_FOUND_ITEMCODE
					set @comment = 'ERROR �ڵ带 ã���� �����ϴ�.'
					--select 'DEBUG ' + @comment
				END
			else if (@yabaustep = 0)
				BEGIN
					set @nResult_ = @RESULT_SUCCESS
					set @comment = 'SUCCESS �������� ã�ư���.(�̹�ã�ư�)'
					--select 'DEBUG ' + @comment

					--------------------------------------
					--��������
					--------------------------------------
					set @bresult	= 2
					set @yabaustep 	= 0
				END
			else
				BEGIN
					set @nResult_ = @RESULT_SUCCESS
					set @comment = 'SUCCESS �������� ã�ư���.'
					--select 'DEBUG ' + @comment

					--------------------------------------
					-- �ܰ�Ŭ����.
					--------------------------------------
					if(@yabaustep = 1)
						begin
							--set @pack11  = -1
							set @pack21  = -1
							set @pack31  = -1
							set @pack41  = -1
							set @pack51  = -1
							set @pack61  = -1
						end
					else if(@yabaustep = 2)
						begin
							--set @pack11  = -1
							--set @pack21  = -1
							set @pack31  = -1
							set @pack41  = -1
							set @pack51  = -1
							set @pack61  = -1
						end
					else if(@yabaustep = 3)
						begin
							--set @pack11  = -1
							--set @pack21  = -1
							--set @pack31  = -1
							set @pack41  = -1
							set @pack51  = -1
							set @pack61  = -1
						end
					else if(@yabaustep = 4)
						begin
							--set @pack11  = -1
							--set @pack21  = -1
							--set @pack31  = -1
							--set @pack41  = -1
							set @pack51  = -1
							set @pack61  = -1
						end
					else if(@yabaustep = 5)
						begin
							--set @pack11  = -1
							--set @pack21  = -1
							--set @pack31  = -1
							--set @pack41  = -1
							--set @pack51  = -1
							set @pack61  = -1
						end
					--else if(@yabaustep = 6)
					--	begin
					--		--set @pack11  = -1
					--		--set @pack21  = -1
					--		--set @pack31  = -1
					--		--set @pack41  = -1
					--		--set @pack51  = -1
					--		--set @pack61  = -1
					--	end

					------------------------------------------------------------------
					-- �����Կ� �־��ֱ�.
					------------------------------------------------------------------
					if(@pack11 != -1)exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT,  @pack11, 0, 'SysBabau', @gameid_, ''
					if(@pack21 != -1)exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT,  @pack21, 0, 'SysBabau', @gameid_, ''
					if(@pack31 != -1)exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT,  @pack31, 0, 'SysBabau', @gameid_, ''
					if(@pack41 != -1)exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT,  @pack41, 0, 'SysBabau', @gameid_, ''
					if(@pack51 != -1)exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT,  @pack51, 0, 'SysBabau', @gameid_, ''
					if(@pack61 != -1)exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT,  @pack61, 0, 'SysBabau', @gameid_, ''

					--------------------------------------
					-- ����ϱ�.
					--------------------------------------
					-- �����.
					if(not exists(select top 1 * from dbo.tUserYabauMonth where dateid6 = @dateid6 and itemcode = @itemcode))
						begin
							insert into dbo.tUserYabauMonth(dateid6, itemcode) values(@dateid6, @itemcode)
						end
					update dbo.tUserYabauMonth
						set
							step1 = step1 + case when (@yabaustep = 1) then 1 else 0 end,
							step2 = step2 + case when (@yabaustep = 2) then 1 else 0 end,
							step3 = step3 + case when (@yabaustep = 3) then 1 else 0 end,
							step4 = step4 + case when (@yabaustep = 4) then 1 else 0 end,
							step5 = step5 + case when (@yabaustep = 5) then 1 else 0 end,
							step6 = step6 + case when (@yabaustep = 6) then 1 else 0 end
					where dateid6 = @dateid6 and itemcode = @itemcode

					-- �ϱ��.
					if(not exists(select top 1 * from dbo.tUserYabauTotalSub where dateid8 = @dateid8 and itemcode = @itemcode))
						begin
							insert into dbo.tUserYabauTotalSub(dateid8, itemcode) values(@dateid8, @itemcode)
						end
					update dbo.tUserYabauTotalSub
						set
							step1 = step1 + case when (@yabaustep = 1) then 1 else 0 end,
							step2 = step2 + case when (@yabaustep = 2) then 1 else 0 end,
							step3 = step3 + case when (@yabaustep = 3) then 1 else 0 end,
							step4 = step4 + case when (@yabaustep = 4) then 1 else 0 end,
							step5 = step5 + case when (@yabaustep = 5) then 1 else 0 end,
							step6 = step6 + case when (@yabaustep = 6) then 1 else 0 end
					where dateid8 = @dateid8 and itemcode = @itemcode

					----------------------------------------------
					-- �߹��� �ε����� ���Ѵ�.
					----------------------------------------------
					set @strmarket = '%' + ltrim(rtrim(str(@market))) + '%'

					select top 1 @yabauidx = idx from dbo.tSystemYabau
					where idx != @yabauidx
						and famelvmin <= @famelv
						and @famelv <= famelvmax
						and packstate = 1
						and packmarket like @strmarket
						order by newid()

					------------------------
					-- �߹����α�(�ޱ�).
					------------------------
					insert into dbo.tYabauLogPerson(gameid,  itemcode,   kind,  framelv,  pack11,  pack21,  pack31,  pack41,  pack51,  pack61,  yabaustep,  yabaucount, remaingamecost, remaincashcost)
					values(                        @gameid_, @itemcode, @mode_, @famelv, @pack11, @pack21, @pack31, @pack41, @pack51, @pack61, @yabaustep, @yabaucount,      @gamecost,      @cashcost)

					--------------------------------------
					--��������
					--------------------------------------
					set @bresult	= 2
					set @yabaustep 	= 0
				END
		END
	else if (@mode_ in (@MODE_YABAU_NORMAL, @MODE_YABAU_PREMINUM))
		BEGIN
			if(@randserial_ = @randserial)
				BEGIN
					set @nResult_ = @RESULT_SUCCESS
					set @comment = 'SUCCESS �̹� ���� �߽��ϴ�.(���� ���� ������)'
					--select 'DEBUG ' + @comment
				END
			else if(@yabaustep >= 6)
				BEGIN
					set @nResult_ = @RESULT_SUCCESS
					set @comment = 'SUCCESS �̹� ���� �߽��ϴ�.(6�ܰ� �̻��� �ȵȴ�.)'
					--select 'DEBUG ' + @comment
				END
			else if(@mode_ = @MODE_YABAU_NORMAL and @gamecost < @needgamecost)
				BEGIN
					set @nResult_ = @RESULT_ERROR_GAMECOST_LACK
					set @comment = 'ERROR ���������� �����մϴ�.'
					--select 'DEBUG ' + @comment
				END
			else if(@mode_ = @MODE_YABAU_PREMINUM and @cashcost < @needgcashcost)
				BEGIN
					set @nResult_ 	= @RESULT_ERROR_CASHCOST_LACK
					set @comment 	= 'ERROR ĳ���� �����մϴ�.'
					--select 'DEBUG ' + @comment
				END
			else
				BEGIN
					set @nResult_ = @RESULT_SUCCESS
					set @comment = 'SUCCESS �ֻ����� ���ȴ�.'
					--select 'DEBUG ' + @comment

					set @rand = 0
					--select 'DEBUG > (��)', @rand rand, @gamecost gamecost, @cashcost cashcost, @needyabaunum needyabaunum, @needgcashcost needgcashcost, @needgamecost needgamecost
					if(@mode_ = @MODE_YABAU_NORMAL)
						begin
							---------------------------------------------
							--	Ȯ�� ���. 2 ~ 12
							---------------------------------------------
							set @rand 		= Convert(int, ceiling(RAND() * 11)) + 1

							if(@yabaustep < 1)
								begin
									-- 0, 1�ܰ迡���� ������ ���� �ʴ´�.
									set @rand = Convert(int, ceiling(RAND() * (12 - @needyabaunum))) + @needyabaunum
								end

							-----------------------------------------
							-- ���� ���
							-- ���� 5�ܰ� > ����Ƚ�� [L0 ~ ���� ~ L1 ~ �Ұ��� ~ L2]
							-- �߰� ���� �Ⱓ.
							--   L0     L1		L2
							--   +4     +1      +0
							----------------------------------------
							set @yabautemp = (@yabaucount - @YABAU_COUNT_L0) % @YABAU_COUNT_L2
							--select 'DEBUG ', @yabaucount yabaucount, @yabautemp yabautemp, @curhour curhour
							if(@yabaucount < @YABAU_COUNT_L0)
								begin
									--select 'DEBUG 1> �߰�Ȯ��(��)', @rand rand
									set @rand = @rand + Convert(int, ceiling(RAND() * 4))
									set @rand = case
													when @rand >= 12 then 12
													when @rand <=  2 then  2
													else                  @rand
												end
									--select 'DEBUG > �߰�Ȯ��(��)', @rand rand
								end
							else if(@yabaustep < 5 and @yabaucount >= 50 and @yabaucount % 50 <= 3)
								begin
									--select 'DEBUG 4> ������ ����', @yabaucount yabaucount, @yabautemp yabautemp
									set @rand = Convert(int, ceiling(RAND() * (12 - @needyabaunum + 1 ))) + @needyabaunum -1
								end
							--else if(@yabaustep < 5 and @yabautemp <= @YABAU_COUNT_L1)
							--	begin
							--		--select 'DEBUG 2> ����Ȯ�� +1', @curhour curhour
							--		-- Ȯ�� ���
							--		set @rand = @rand + Convert(int, ceiling(RAND() * 2))
							--		set @rand = case
							--						when @rand >= 12 then 12
							--						when @rand <=  2 then  2
							--						else                  @rand
							--					end
							--	end
							else if(@yabaustep >= 5 and @yabautemp > @YABAU_COUNT_L1 and @yabautemp <= @YABAU_COUNT_L2)
								begin
									--select 'DEBUG 5> ����Ȯ�� ����'
									set @rand = case
													when @rand >= @needyabaunum then @needyabaunum - 1
													else							 @rand
												end
								end
							else if(@curhour in (12, 18, 23))
								begin
									--select 'DEBUG 3> �ð����� +1', @curhour curhour
									set @rand = @rand + Convert(int, ceiling(RAND() * 2))
									set @rand = case
													when @rand >= 12 then 12
													when @rand <=  2 then  2
													else                  @rand
												end
								end

							----------------------------------------------
							-- �Ϲ�[����] �谨
							----------------------------------------------
							set @gamecost 	= @gamecost - @needgamecost

							--select 'DEBUG > �Ϲ�Ȯ��', @gamecost gamecost, @needgamecost needgamecost, @needyabaunum needyabaunum


							------------------------
							-- ���ŷα� ���.
							------------------------
							exec spu_UserItemBuyLogNew @gameid_, @itemcode, @needgamecost, 0, 0
						end
					else if(@mode_ = @MODE_YABAU_PREMINUM)
						begin
							---------------------------------------------
							--	Ȯ�� ���. 12
							---------------------------------------------
							-- set @rand = 12
							-- set @rand = Convert(int, ceiling(RAND() * (12 - @needyabaunum))) + @needyabaunum
							set @rand = Convert(int, ceiling(RAND() * (12 - @needyabaunum + 1 ))) + @needyabaunum -1

							----------------------------------------------
							-- �����̾�[���]) �谨.
							----------------------------------------------
							set @cashcost	= @cashcost - @needgcashcost

							--select 'DEBUG > �����̾�', @cashcost cashcost, @needgcashcost needgcashcost, @needyabaunum needyabaunum
							------------------------
							-- ���ŷα� ���.
							------------------------
							exec spu_UserItemBuyLogNew @gameid_, @itemcode, 0, @needgcashcost, 0
						end
					--select 'DEBUG > (��)', @needyabaunum needyabaunum, @rand rand, @gamecost gamecost, @cashcost cashcost, @needgcashcost needgcashcost, @needgamecost needgamecost

					----------------------------------------------
					-- ���� / ����
					----------------------------------------------
					if(@needyabaunum <= @rand)
						begin
							--select 'DEBUG > ����'
							set @yabaustep 		= @yabaustep + case when (@yabaustep < 6) then 1 else 0 end
							set @yabauresult	= 1
						end
					else
						begin
							--select 'DEBUG > ����'
							set @yabaustep 		= @yabaustep - case when (@yabaustep > 1) then 1 else 0 end
							set @yabauresult	= 0
						end

					set @yabaucount = @yabaucount + 1
					set @yabaunum = @rand



					------------------------
					-- �߹����α�(�ޱ�).
					------------------------
					if(@mode_ = @MODE_YABAU_NORMAL)
						begin
							set @needgcashcost = 0
						end
					else if(@mode_ = @MODE_YABAU_PREMINUM)
						begin
							set @needgamecost = 0
						end
					insert into dbo.tYabauLogPerson(gameid,   itemcode,  kind,  framelv,  pack11,  pack21,  pack31,  pack41,  pack51,  pack61,       result,       cashcost,      gamecost,  yabaustep,  yabaucount, remaingamecost, remaincashcost)
					values(                        @gameid_, @itemcode, @mode_, @famelv, @pack11, @pack21, @pack31, @pack41, @pack51, @pack61, @yabauresult, @needgcashcost, @needgamecost, @yabaustep, @yabaucount,      @gamecost,      @cashcost)

				END
		END

	--------------------------------------------------------------
	-- 	�������
	--------------------------------------------------------------
	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost, @yabauidx yabauidx, @yabaustep yabaustep, @yabaunum yabaunum, @yabauresult yabauresult, @yabauchange yabauchange

	if(@nResult_ = @RESULT_SUCCESS)
		begin
			--------------------------------------------------------------
			-- �������� ���� �־���
			--------------------------------------------------------------
			update dbo.tUserMaster
				set
					cashcost	= @cashcost,
					gamecost	= @gamecost,

					yabauidx	= @yabauidx,
					yabaustep 	= @yabaustep,
					yabaunum	= @yabaunum,
					yabauresult	= @yabauresult,
					yabaucount	= @yabaucount,
					randserial	= @randserial_
			where gameid = @gameid_

			---------------------------------------------
			-- ����� ��.
			---------------------------------------------
			select top 1 * from dbo.tSystemYabau where idx = @yabauidx

			--------------------------------------------------------------
			-- ����������.
			--------------------------------------------------------------
			if(@bresult = 2)
				begin
					exec spu_GiftList @gameid_
				end
		end


	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off
End


