use GameMTBaseball
Go

/*
update dbo.tUserMaster set randserial = -1, zcpchance = 1 where gameid = 'xxxx2'
delete from dbo.tUserItem where gameid = 'xxxx2' and itemcode in ( 3800, 3801 )
exec spu_ZCPChance 'xxxx2', '049000s1i0n7t8445289', 1,   0, 7771, -1			-- ¥���������� ������ (���»���)

update dbo.tUserMaster set randserial = -1, zcpchance = 1 where gameid = 'xxxx2'
exec spu_ZCPChance 'xxxx2', '049000s1i0n7t8445289', 1,   0, 7773, -1			-- ¥���������� ������ (�ִ»���)

update dbo.tUserMaster set randserial = -1, cashcost = 15000 where gameid = 'xxxx2'
--delete from dbo.tUserItem where gameid = 'xxxx2' and itemcode in ( 3800, 3801 )
exec spu_ZCPChance 'xxxx2', '049000s1i0n7t8445289', 2, 200, 7781, -1			--  ¥���������� ������ (���»���)
exec spu_ZCPChance 'xxxx2', '049000s1i0n7t8445289', 2, 170, 7782, -1			--  ¥���������� ������ (���»���)

-----------------------------------------------------------
-- 15,000 -> ���ᵹ�� ( ¥������ 13 ~ 16�� ���� ȹ���� )
-----------------------------------------------------------
declare @gameid varchar(20)	set @gameid		= 'xxxx2'
declare @cashcost int		set @cashcost	= 15000
update dbo.tUserMaster set randserial = -1, cashcost = @cashcost where gameid = @gameid
delete from dbo.tUserItem where gameid = @gameid and itemcode in ( 3800, 3801 )
while ( @cashcost > 200 )
	begin
		exec spu_ZCPChance @gameid, '049000s1i0n7t8445289', 2, 200, 7781, -1			--  ¥���������� ������ (���»���)
		exec spu_ZCPChance @gameid, '049000s1i0n7t8445289', 2, 170, 7782, -1			--  ¥���������� ������ (���»���)
		select @cashcost = cashcost from dbo.tUserMaster where gameid = @gameid
	end

-----------------------------------------------------------
-- 100 -> ���ᵹ�� ( ¥������ 1.36 ~ 1.27 �� ���� ȹ���� )
-----------------------------------------------------------
declare @gameid varchar(20)	set @gameid		= 'xxxx2'
declare @cnt int			set @cnt		= 100
delete from dbo.tUserItem where gameid = @gameid and itemcode in ( 3800, 3801 )
while ( @cnt > 0 )
	begin
		update dbo.tUserMaster set randserial = -1, zcpchance = 1 where gameid = 'xxxx2'
		exec spu_ZCPChance 'xxxx2', '049000s1i0n7t8445289', 1,   0, 7771, -1			-- ¥���������� ������ (���»���)
		set @cnt = @cnt - 1
	end


*/

IF OBJECT_ID ( 'dbo.spu_ZCPChance', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_ZCPChance;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_ZCPChance
	@gameid_				varchar(20),						-- ���Ӿ��̵�
	@password_				varchar(20),						-- ��ȣȭ�ؼ�����, �����н����� ��ŷ���ص� ����
	@mode_					int,
	@usedcashcost_			int,
	@randserial_			varchar(20),
	@nResult_				int					OUTPUT
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

	-- ���̺� ����.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--�ش������� ã�� ����
	declare @RESULT_ERROR_CASHCOST_LACK			int				set @RESULT_ERROR_CASHCOST_LACK			= -22			--��尡 �����ϴ�.
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- ���������ʴ¸��
	declare @RESULT_ERROR_NOT_MATCH				int				set @RESULT_ERROR_NOT_MATCH				= -110			-- �����ΰ� ��ġ�� �ȵǾ���.
	declare @RESULT_ERROR_NOT_FOUND_ZCPCHANCE	int				set @RESULT_ERROR_NOT_FOUND_ZCPCHANCE	= -161			-- ¥���������� ȹ������ ������մϴ�.

	-- ������ ȹ����
	declare @DEFINE_HOW_GET_ZCP					int				set @DEFINE_HOW_GET_ZCP					= 20 --�����귿.

	-- ���� ���ǰ�
	declare @GIFTLIST_GIFT_KIND_MESSAGE			int				set @GIFTLIST_GIFT_KIND_MESSAGE			= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int				set @GIFTLIST_GIFT_KIND_GIFT			= 2

	-- ȸ���� ���.
	declare @MODE_ZCPCHANCE_FREE				int				set @MODE_ZCPCHANCE_FREE				= 1			-- ������(1)
	declare @MODE_ZCPCHANCE_CASH				int				set @MODE_ZCPCHANCE_CASH				= 2			-- ������(2)

	-- Ȳ�ݷ귿 �ݾ�.
	declare @PREMINUM_PRICE1					int				set @PREMINUM_PRICE1					= 200
	declare @PREMINUM_PRICE2					int				set @PREMINUM_PRICE2					= 170

	declare @ITEM_ZCP_PIECE_MOTHER				int				set @ITEM_ZCP_PIECE_MOTHER				= 3800	-- ¥����������.
	declare @ITEM_ZCP_TICKET_MOTHER				int				set @ITEM_ZCP_TICKET_MOTHER				= 3801	-- ¥������.

	declare @USER_LOGOLIST_MAX					int				set @USER_LOGOLIST_MAX 					= 100
	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @comment				varchar(80)
	declare @sendid					varchar(20)
	declare @gameid					varchar(20)				set @gameid				= ''
	declare @market					int						set @market				= 5
	declare @cashcost				int						set @cashcost 			= 0
	declare @gamecost				int						set @gamecost 			= 0
	declare @zcpplus				int						set @zcpplus			= 0
	declare @zcpchance				int						set @zcpchance			= 0
	declare @bkzcpcntfree			int						set @bkzcpcntfree		= 0
	declare @bkzcpcntcash			int						set @bkzcpcntcash		= 0
	declare @randserial				varchar(20)				set @randserial			= '-1'
	declare @zcplistidx				int
	declare @zcpcnt					int
	declare @listidx				int						set @listidx			= -1
	declare @bchange				int						set @bchange			= 0

	declare @idx					int						set @idx				= 0
	declare @itemcode				int						set @itemcode			= 0
	declare @cnt					int						set @cnt				= 0
	declare @randval				int						set @randval			= 0
	declare @randvalfree			int						set @randvalfree		= 0
	declare @randvalcash			int						set @randvalcash		= 0
	declare @randsum				int						set @randsum			= 0
	declare @rand					int						set @rand				= 0
	declare @loop					int						set @loop				= 1
	declare @kind					int						set @kind				= @MODE_ZCPCHANCE_FREE

	-- �̱� ����Ʈ ����.
	declare @idx1					int						set @idx1				= 0
	declare @idx2					int						set @idx2				= 0
	declare @idx3					int						set @idx3				= 0
	declare @idx4					int						set @idx4				= 0
	declare @idx5					int						set @idx5				= 0
	declare @idx6					int						set @idx6				= 0
	declare @idx7					int						set @idx7				= 0
	declare @idx8					int						set @idx8				= 0
	declare @itemcode1				int						set @itemcode1			= 0
	declare @itemcode2				int						set @itemcode2			= 0
	declare @itemcode3				int						set @itemcode3			= 0
	declare @itemcode4				int						set @itemcode4			= 0
	declare @itemcode5				int						set @itemcode5			= 0
	declare @itemcode6				int						set @itemcode6			= 0
	declare @itemcode7				int						set @itemcode7			= 0
	declare @itemcode8				int						set @itemcode8			= 0
	declare @cnt1					int						set @cnt1				= 0
	declare @cnt2					int						set @cnt2				= 0
	declare @cnt3					int						set @cnt3				= 0
	declare @cnt4					int						set @cnt4				= 0
	declare @cnt5					int						set @cnt5				= 0
	declare @cnt6					int						set @cnt6				= 0
	declare @cnt7					int						set @cnt7				= 0
	declare @cnt8					int						set @cnt8				= 0
	declare @randval1				int						set @randval1			= 0
	declare @randval2				int						set @randval2			= 0
	declare @randval3				int						set @randval3			= 0
	declare @randval4				int						set @randval4			= 0
	declare @randval5				int						set @randval5			= 0
	declare @randval6				int						set @randval6			= 0
	declare @randval7				int						set @randval7			= 0
	declare @randval8				int						set @randval8			= 0

	DECLARE @tTempTable TABLE(
		listidx		int
	);
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG �Է�����', @gameid_ gameid_, @password_ password_, @mode_ mode_, @usedcashcost_ usedcashcost_, @randserial_ randserial_

	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	select
		@gameid 		= gameid, 			@market			= market,
		@cashcost		= cashcost,			@gamecost		= gamecost,
		@zcpplus		= zcpplus,			@zcpchance		= zcpchance,
		@bkzcpcntfree 	= bkzcpcntfree,		@bkzcpcntcash	= bkzcpcntcash,
		@idx			= bgroul1, 			@itemcode		= bgroul2,			@cnt 		= bgroul3,
		@randserial		= randserial
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG ��������', @gameid gameid, @market market, @cashcost cashcost, @gamecost gamecost, @zcpplus zcpplus, @zcpchance zcpchance, @bkzcpcntfree bkzcpcntfree, @bkzcpcntcash bkzcpcntcash, @idx idx, @itemcode itemcode, @cnt cnt, @randserial randserial

	if( @gameid = '' )
		BEGIN
			-- ���̵� ���������ʴ°�??
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '���̵� �������� �ʴ´�. > ���̵� Ȯ���ض�.'
			--select 'DEBUG ', @comment
		END
	else if ( @mode_ not in (@MODE_ZCPCHANCE_FREE, @MODE_ZCPCHANCE_CASH) )
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment = 'ERROR �������� �ʴ� ����Դϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if ( @mode_ = @MODE_ZCPCHANCE_FREE and @zcpchance < 1 )
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_ZCPCHANCE
			set @comment = 'ERROR ¥���������� �̹� �����ϴ�.'
			----select 'DEBUG ' + @comment
		END
	else if ( @mode_ = @MODE_ZCPCHANCE_CASH and @usedcashcost_ not in ( @PREMINUM_PRICE1, @PREMINUM_PRICE2 ) )
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_MATCH
			set @comment = 'ERROR ĳ���� ����ġ�մϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if ( @mode_ = @MODE_ZCPCHANCE_CASH and @usedcashcost_ > @cashcost )
		BEGIN
			set @nResult_ = @RESULT_ERROR_CASHCOST_LACK
			set @comment = 'ERROR Ȳ�ݷ귿�� ĳ���� �����մϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if ( @randserial_ = @randserial )
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'SUCCESS ȸ���� ���� (���Ͽ�û)'
			--select 'DEBUG ' + @comment
		END
	else if ( @mode_ in ( @MODE_ZCPCHANCE_FREE, @MODE_ZCPCHANCE_CASH ) )
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS

			if( @mode_ = @MODE_ZCPCHANCE_FREE )
				begin
					set @comment 	= 'SUCCESS ¥�������̱� ���Ḧ �����ϴ�.'

					set @zcpchance	= -1
					set @bkzcpcntfree= @bkzcpcntfree + 1

					exec spu_DayLogInfoStatic @market, 110, 1				-- �� ¥�������̱� ����.

					--select 'DEBUG ����', @comment, @zcpchance zcpchance, @bkzcpcntfree bkzcpcntfree
				end
			else if( @mode_ = @MODE_ZCPCHANCE_CASH )
				begin
					set @comment 	= 'SUCCESS ¥�������̱� ������ �����ϴ�. '

					set @cashcost	= @cashcost - @usedcashcost_
					set @bkzcpcntcash= @bkzcpcntcash + 1

					exec spu_DayLogInfoStatic @market, 111, 1				-- �� ¥�������̱� ����.

					--select 'DEBUG ����', @comment, @cashcost cashcost, @bkzcpcntcash bkzcpcntcash
				end

			-----------------------------------------
			-- 1. ���ᷥ�� ������ ����.
			-----------------------------------------
			-- 1. �����ϱ�.
			declare curZCPInfo Cursor for
			select top 8 idx, itemcode, cnt, randvalfree, randvalcash from dbo.tSystemZCPInfo
			where itemcode = @ITEM_ZCP_PIECE_MOTHER
			order by idx asc

			-- 2. Ŀ������
			open curZCPInfo

			-- 3. Ŀ�� ���
			Fetch next from curZCPInfo into @idx, @itemcode, @cnt, @randvalfree, @randvalcash
			while @@Fetch_status = 0
				Begin
					set @randval = case
										when ( @mode_ = @MODE_ZCPCHANCE_FREE ) then @randvalfree
										else 										@randvalcash
									end

					if( @loop = 1 )
						begin
							set @idx1		= @idx
							set @itemcode1	= @itemcode
							set @cnt1		= @cnt
							set @randval1	= @randval
						end
					else if( @loop = 2 )
						begin
							set @idx2		= @idx
							set @itemcode2	= @itemcode
							set @cnt2		= @cnt
							set @randval2	= @randval
						end
					else if( @loop = 3 )
						begin
							set @idx3		= @idx
							set @itemcode3	= @itemcode
							set @cnt3		= @cnt
							set @randval3	= @randval
						end
					else if( @loop = 4 )
						begin
							set @idx4		= @idx
							set @itemcode4	= @itemcode
							set @cnt4		= @cnt
							set @randval4	= @randval
						end
					else if( @loop = 5 )
						begin
							set @idx5		= @idx
							set @itemcode5	= @itemcode
							set @cnt5		= @cnt
							set @randval5	= @randval
						end
					else if( @loop = 6 )
						begin
							set @idx6		= @idx
							set @itemcode6	= @itemcode
							set @cnt6		= @cnt
							set @randval6	= @randval
						end
					else if( @loop = 7 )
						begin
							set @idx7		= @idx
							set @itemcode7	= @itemcode
							set @cnt7		= @cnt
							set @randval7	= @randval
						end
					else if( @loop = 8 )
						begin
							set @idx8		= @idx
							set @itemcode8	= @itemcode
							set @cnt8		= @cnt
							set @randval8	= @randval
						end
					set @randsum = @randsum + @randval
					set @loop = @loop + 1

					Fetch next from curZCPInfo into @idx, @itemcode, @cnt, @randvalfree, @randvalcash
				end

			-- 4. Ŀ���ݱ�
			close curZCPInfo
			Deallocate curZCPInfo

			--select 'DEBUG ', @idx1, 		@idx2, 		@idx3, 		@idx4, 		@idx5, 		@idx6, 		@idx7, 		@idx8
			--select 'DEBUG ', @itemcode1, 	@itemcode2, @itemcode3, @itemcode4, @itemcode5, @itemcode6, @itemcode7, @itemcode8
			--select 'DEBUG ', @cnt1, 		@cnt2, 		@cnt3, 		@cnt4, 		@cnt5, 		@cnt6, 		@cnt7, 		@cnt8
			--select 'DEBUG ', @randval1, 	@randval2, 	@randval3, 	@randval4, 	@randval5, 	@randval6, 	@randval7, 	@randval8


			--------------------------------------------
			-- 2. ������ã��. > ��������
			--    ���޼���
			--------------------------------------------
			set @rand = Convert(int, ceiling(RAND() * @randsum))
			select
				@idx = idx, @itemcode = itemcode, @cnt = cnt
			from dbo.fnu_GetCrossRandom8(@rand,
											@idx1, 		@idx2, 		@idx3, 		@idx4, 		@idx5, 		@idx6, 		@idx7, 		@idx8,
											@itemcode1, @itemcode2, @itemcode3, @itemcode4, @itemcode5, @itemcode6, @itemcode7, @itemcode8,
											@cnt1, 		@cnt2, 		@cnt3, 		@cnt4, 		@cnt5, 		@cnt6, 		@cnt7, 		@cnt8,
											@randval1, 	@randval2, 	@randval3, 	@randval4, 	@randval5, 	@randval6, 	@randval7, 	@randval8)
			--select 'DEBUG ', @rand rand, @idx idx, @itemcode itemcode, @cnt cnt

			---------------------------------------------------
			-- ������ ��������
			-- 1. ��ü ������ ���� ���Ѵ�.
			-- > ��ü������ ���� ���ؼ� 99���� �����ϴ� ������� �Ѵ�.
			---------------------------------------------------
			--select 'DEBUG 1. ��ü ������ ���� ���Ѵ�.'
			exec spu_SetDirectItemNew @gameid_, @itemcode, @cnt, @DEFINE_HOW_GET_ZCP, @rtn_ = @listidx OUTPUT
			insert into @tTempTable( listidx ) values( @listidx )

			select
				@zcplistidx = listidx,
				@zcpcnt 	= cnt
			from dbo.tUserItem
			where gameid = @gameid_ and listidx = @listidx
			--select 'DEBUG 1-2. ������ ¥����������', @zcplistidx zcplistidx, @zcpcnt zcpcnt

			--select 'DEBUG 2. 99�� �̻��̸� ¥������ ����', @zcpcnt zcpcnt
			while( @zcpcnt >= 99 )
				begin
					--select 'DEBUG 2-2 > ¥������ ����', @zcpcnt zcpcnt
					exec spu_SetDirectItemNew @gameid_, @ITEM_ZCP_TICKET_MOTHER, 1, @DEFINE_HOW_GET_ZCP, @rtn_ = @listidx OUTPUT
					insert into @tTempTable( listidx ) values( @listidx )

					set @zcpcnt = @zcpcnt - 99
					set @bchange= 1
				end

			--select 'DEBUG 3. �����۰���.'
			if( @bchange = 1 )
				begin
					--select 'DEBUG 3-2.  > ����.'

					update dbo.tUserItem
						set
							cnt = @zcpcnt
					where gameid = @gameid_ and listidx = @zcplistidx
				end

			---------------------------------------------------
			-- ����ȸ���� �αױ��(200������ ����).
			---------------------------------------------------
			select @idx2 = isnull(idx2, 0) + 1 from dbo.tUserZCPLog where gameid = @gameid_
			--select 'DEBUG ȸ���� �α� ���', @idx2 idx2

			insert into dbo.tUserZCPLog(gameid,   idx2,  mode,   usedcashcost,   ownercashcost,  cnt)
			values(                    @gameid_, @idx2, @mode_, @usedcashcost_,      @cashcost, @cnt)

			delete from dbo.tUserZCPLog where idx2 <= @idx2 - @USER_LOGOLIST_MAX
		END


	-----------------------------------------------
	-- ����ڵ�ó��.
	-----------------------------------------------
	select @nResult_ rtn, @comment comment,
		   @cashcost cashcost, @gamecost gamecost,
		   @idx rewardidx, @itemcode rewarditemcode, @cnt rewardcnt

	if(@nResult_ = @RESULT_SUCCESS)
		BEGIN
			------------------------------------------------
			-- ��������
			------------------------------------------------
			update dbo.tUserMaster
				set
					cashcost		= @cashcost,
					bgroul1 		= @idx,			bgroul2 	= @itemcode,	bgroul3 	= @cnt,
					zcpchance		= @zcpchance,
					bkzcpcntfree	= @bkzcpcntfree, bkzcpcntcash= @bkzcpcntcash,
					randserial		= @randserial_
			where gameid = @gameid_

			--------------------------------------------------------------
			-- ���� ���� ������ ����
			--------------------------------------------------------------
			select * from dbo.tUserItem
			where gameid = @gameid_ and listidx in ( select listidx from @tTempTable )
		END

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off
End



