use GameMTBaseball
Go

/*
--update dbo.tSystemInfo set wheelgauageflag = -1
delete from dbo.tGiftList where gameid = 'xxxx2'
update dbo.tUserMaster set randserial = -1, wheeltodaycnt = 0, cashcost = 10000, gamecost = 0, wheelgauage = 0, wheelfree = 1 where gameid = 'xxxx2'
exec spu_Wheel 'xxxx2', '049000s1i0n7t8445289', 20,   0, 7771, -1			-- ���Ϸ귿(20)    MODE_WHEEL_NORMAL
exec spu_Wheel 'xxxx2', '049000s1i0n7t8445289', 20,   0, 7772, -1			-- ���Ϸ귿(20)    MODE_WHEEL_NORMAL

delete from dbo.tGiftList where gameid = 'xxxx2'
update dbo.tUserMaster set randserial = -1, wheeltodaycnt = 0, cashcost = 10000, gamecost = 0, wheelgauage = 0, wheelfree = 0 where gameid = 'xxxx2'
exec spu_Wheel 'xxxx2', '049000s1i0n7t8445289', 21, 300, 7773, -1			-- Ȳ�ݷ귿(21)    MODE_WHEEL_PREMINUM
exec spu_Wheel 'xxxx2', '049000s1i0n7t8445289', 21, 270, 7774, -1			-- Ȳ�ݷ귿(21)    MODE_WHEEL_PREMINUM

delete from dbo.tGiftList where gameid = 'xxxx2'
update dbo.tUserMaster set randserial = -1, wheeltodaycnt = 0, cashcost = 10000, gamecost = 0, wheelgauage = 0, wheelfree = 1 where gameid = 'xxxx2'
exec spu_Wheel 'xxxx2', '049000s1i0n7t8445289', 22,   0, 7775, -1			-- Ȳ�ݹ���(22)    MODE_WHEEL_PREMINUMFREE

--update dbo.tSystemInfo set wheelgauageflag = 1
exec spu_Wheel 'xxxx2', '049000s1i0n7t8445289', 21, 300, 7781, -1			-- Ȳ�ݷ귿(21)    MODE_WHEEL_PREMINUM
exec spu_Wheel 'xxxx2', '049000s1i0n7t8445289', 21, 300, 7782, -1			-- Ȳ�ݷ귿(21)    MODE_WHEEL_PREMINUM

select * from dbo.tUserWheelLog where gameid = 'xxxx2'
*/

IF OBJECT_ID ( 'dbo.spu_Wheel', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_Wheel;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_Wheel
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
	declare @RESULT_ERROR_DAILY_REWARD_ALREADY	int				set @RESULT_ERROR_DAILY_REWARD_ALREADY	= -102			-- ���Ϻ��� �̹� ����.
	declare @RESULT_ERROR_NOT_MATCH				int				set @RESULT_ERROR_NOT_MATCH				= -110			-- �����ΰ� ��ġ�� �ȵǾ���.

	-- ���� ���ǰ�
	declare @GIFTLIST_GIFT_KIND_MESSAGE			int				set @GIFTLIST_GIFT_KIND_MESSAGE			= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int				set @GIFTLIST_GIFT_KIND_GIFT			= 2

	-- ȸ���� ���.
	declare @MODE_WHEEL_NORMAL					int				set @MODE_WHEEL_NORMAL					= 20			-- ���Ϸ귿(20)
	declare @MODE_WHEEL_PREMINUM				int				set @MODE_WHEEL_PREMINUM				= 21			-- Ȳ�ݷ귿(21)
	declare @MODE_WHEEL_PREMINUMFREE			int				set @MODE_WHEEL_PREMINUMFREE			= 22			-- Ȳ�ݹ���(22)

	declare @WHEEL_TABLE_NORMAL					int				set @WHEEL_TABLE_NORMAL					= 20			-- �������̺�(20)
	declare @WHEEL_TABLE_PREMINUM				int				set @WHEEL_TABLE_PREMINUM				= 21			-- Ȳ�����̺�(21)

	-- Ȳ�ݷ귿 �ݾ�.
	declare @PREMINUM_PRICE1					int				set @PREMINUM_PRICE1					= 300
	declare @PREMINUM_PRICE2					int				set @PREMINUM_PRICE2					= 270

	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @comment				varchar(80)
	declare @sendid					varchar(20)
	declare @gameid					varchar(20)				set @gameid				= ''
	declare @kakaonickname			varchar(40)				set @kakaonickname		= ''
	declare @market					int						set @market				= 5
	declare @cashcost				int						set @cashcost 			= 0
	declare @gamecost				int						set @gamecost 			= 0
	declare @wheeltodaycnt			int						set @wheeltodaycnt		= 0		-- ����귿.
	declare @wheelgauage			int						set @wheelgauage		= 0		-- Ȳ�ݷ귿.
	declare @wheelfree				int						set @wheelfree			= 0
	declare @bkwheelcnt				int						set @bkwheelcnt			= 0
	declare @randserial				varchar(20)				set @randserial			= '-1'

	declare @idx					int						set @idx				= 0
	declare @itemcode				int						set @itemcode			= 0
	declare @cnt					int						set @cnt				= 0
	declare @randval				int						set @randval			= 0
	declare @randsum				int						set @randsum			= 0
	declare @rand					int						set @rand				= 0
	declare @loop					int						set @loop				= 1
	declare @kind					int						set @kind				= 20
	declare @adlog					int						set @adlog				= 0

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

	-- Ȳ�ݷ귿 ��������.
	declare @wheelgauageflag		int						set @wheelgauageflag	= -1
	declare @wheelgauagepoint		int						set @wheelgauagepoint	= 10
	declare @wheelgauagemax			int						set @wheelgauagemax		= 100

	-- VIPȿ��.
	declare @cashpoint				int						set @cashpoint			= 0
	declare @vip_plus				int						set @vip_plus			= 0

	-- ��ŷ���� ����.
	declare @rkteam					int						set @rkteam				= -1
	declare @rkstartstate			int						set @rkstartstate		= 0

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
		@gameid 		= gameid, 			@market			= market,			@kakaonickname 	= kakaonickname,
		@rkteam			= rkteam, 			@rkstartstate	= rkstartstate,
		@cashcost		= cashcost,			@gamecost		= gamecost,			@cashpoint		= cashpoint,
		@wheeltodaycnt	= wheeltodaycnt,	@wheelgauage	= wheelgauage,		@wheelfree		= wheelfree,		@bkwheelcnt = bkwheelcnt,
		@idx			= bgroul1, 			@itemcode		= bgroul2,			@cnt 			= bgroul3,
		@randserial		= randserial
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG ��������', @gameid gameid, @market market, @cashcost cashcost, @wheeltodaycnt wheeltodaycnt, @wheelgauage wheelgauage, @wheelfree wheelfree, @randserial randserial

	------------------------------------------------
	-- �̱� �̺�Ʈ ���� ��������.
	------------------------------------------------
	select
		top 1 @wheelgauageflag	= wheelgauageflag,		@wheelgauagepoint	= wheelgauagepoint,		@wheelgauagemax		= wheelgauagemax
	from dbo.tSystemInfo
	order by idx desc
	--select 'DEBUG ', @wheelgauageflag wheelgauageflag, @wheelgauagepoint wheelgauagepoint, @wheelgauagemax wheelgauagemax

	if( @gameid = '' )
		BEGIN
			-- ���̵� ���������ʴ°�??
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '���̵� �������� �ʴ´�. > ���̵� Ȯ���ض�.'
			--select 'DEBUG ', @comment
		END
	else if ( @mode_ not in (@MODE_WHEEL_NORMAL, @MODE_WHEEL_PREMINUM, @MODE_WHEEL_PREMINUMFREE) )
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment = 'ERROR �������� �ʴ� ����Դϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if ( @mode_ = @MODE_WHEEL_NORMAL and @wheeltodaycnt >= 1 )
		BEGIN
			set @nResult_ = @RESULT_ERROR_DAILY_REWARD_ALREADY
			set @comment = 'ERROR 1��1ȸ ����ȸ������ 2���̻� ����'
			--select 'DEBUG ' + @comment
		END
	else if ( @mode_ = @MODE_WHEEL_PREMINUMFREE and @wheelfree < 1 )
		BEGIN
			set @nResult_ = @RESULT_ERROR_DAILY_REWARD_ALREADY
			set @comment = 'ERROR �̹� ������ �޾ư�(2). Ȳ�ݹ��ᰡ ���� �ǵ���'
			--select 'DEBUG ' + @comment
		END
	else if ( @mode_ = @MODE_WHEEL_PREMINUM and @usedcashcost_ not in ( @PREMINUM_PRICE1, @PREMINUM_PRICE2 ) )
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_MATCH
			set @comment = 'ERROR Ȳ�ݷ귿�� ĳ���� ����ġ�մϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if ( @mode_ = @MODE_WHEEL_PREMINUM and @usedcashcost_ > @cashcost )
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
	else if ( @mode_ in ( @MODE_WHEEL_NORMAL, @MODE_WHEEL_PREMINUM, @MODE_WHEEL_PREMINUMFREE ) )
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS

			if( @mode_ = @MODE_WHEEL_NORMAL )
				begin
					set @comment 	= 'SUCCESS ����귿�� �����ϴ�. '
					set @kind = @WHEEL_TABLE_NORMAL
				end
			else if( @mode_ = @MODE_WHEEL_PREMINUM )
				begin
					set @comment 	= 'SUCCESS Ȳ�ݷ귿�� �����ϴ�. '
					set @kind = @WHEEL_TABLE_PREMINUM
				end
			else if( @mode_ = @MODE_WHEEL_PREMINUMFREE )
				begin
					set @comment 	= 'SUCCESS Ȳ�ݹ���귿�� �����ϴ�. '
					set @kind = @WHEEL_TABLE_PREMINUM
				end
			--select 'DEBUG ', @comment, @kind kind

			-----------------------------------------
			-- 1. ���ᷥ�� ������ ����.
			-----------------------------------------
			-- 1. �����ϱ�.
			declare curWheelFree Cursor for
			select top 8 idx, itemcode, cnt, randval from dbo.tSystemWheelInfo
			where kind = @kind
			order by idx desc

			-- 2. Ŀ������
			open curWheelFree

			-- 3. Ŀ�� ���
			Fetch next from curWheelFree into @idx, @itemcode, @cnt, @randval
			while @@Fetch_status = 0
				Begin
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

					Fetch next from curWheelFree into @idx, @itemcode, @cnt, @randval
				end

			-- 4. Ŀ���ݱ�
			close curWheelFree
			Deallocate curWheelFree

			--select 'DDEBUG ', @idx1, 	@idx2, 		@idx3, 		@idx4, 		@idx5, 		@idx6, 		@idx7, 		@idx8
			--select 'DDEBUG ', @itemcode1, @itemcode2, @itemcode3, @itemcode4, @itemcode5, @itemcode6, @itemcode7, @itemcode8
			--select 'DDEBUG ', @cnt1, 		@cnt2, 		@cnt3, 		@cnt4, 		@cnt5, 		@cnt6, 		@cnt7, 		@cnt8
			--select 'DDEBUG ', @randval1, 	@randval2, 	@randval3, 	@randval4, 	@randval5, 	@randval6, 	@randval7, 	@randval8


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

			--------------------------------------------
			-- �귿 ����(101)
			--------------------------------------------
			select @adlog = adlog from dbo.tSystemWheelInfo where idx = @idx
			if( @adlog = 1 )
				begin
					--exec spu_RoulAdLogNew @gameid_, @kakaonickname, 101, @itemcode, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1
					exec spu_WheelAdLogNew @gameid_, @kakaonickname, 101, @itemcode,  @cnt
				end

			--select 'DEBUG ', @rand rand, @idx idx, @itemcode itemcode, @cnt cnt
			if( @mode_ = @MODE_WHEEL_NORMAL )
				begin
					set @sendid = '���Ϸ귿'

					-- ���޼���.
					set @wheeltodaycnt = @wheeltodaycnt + 1

					-- �Ϲ������.
					exec spu_DayLogInfoStatic @market, 100, 1				-- �� ����귿.
				end
			else if( @mode_ = @MODE_WHEEL_PREMINUM )
				begin
					set @sendid = 'Ȳ�ݷ귿'
					set @bkwheelcnt = @bkwheelcnt + 1

					-- �Ϲ������.
					exec spu_DayLogInfoStatic @market, 101, 1				-- �� Ȳ�ݷ귿.

					-- ĳ�� ����.
					--select 'DEBUG (��)', @cashcost cashcost, @usedcashcost_ usedcashcost_
					set @cashcost = @cashcost - @usedcashcost_
					--select 'DEBUG (��)', @cashcost cashcost, @usedcashcost_ usedcashcost_

					------------------------------------------------
					-- �̱� �̺�Ʈ ����ȸ���� > Ȳ�ݹ���.
					------------------------------------------------
					if( @wheelgauageflag = 1 )
						begin
							set @vip_plus = dbo.fun_GetVIPPlus( 5, @cashpoint,   0) -- �귿.
							set @wheelgauagepoint = @wheelgauagepoint + @vip_plus

							--select 'DEBUG ����ȸ���� ���� �̺�Ʈ��', @wheelgauage wheelgauage
							if(@wheelgauage < @wheelgauagemax)
								begin
									--select 'DEBUG ����ȸ���� ������ ����'
									set @wheelgauage = @wheelgauage + @wheelgauagepoint
								end

							if(@wheelgauage >= @wheelgauagemax)
								begin
									--select 'DEBUG ����ȸ���� > Ȳ�ݹ������'
									set @wheelgauage = @wheelgauage - @wheelgauagemax
									set @wheelfree	= 1
								end
						end
				end
			else if( @mode_ = @MODE_WHEEL_PREMINUMFREE )
				begin
					set @sendid = 'Ȳ�ݹ���귿'

					--select 'DEBUG Ȳ�ݹ���'
					exec spu_DayLogInfoStatic @market,  102, 1				-- �� Ȳ�ݹ���.

					set @wheelfree	= 0
				end

			-- ������ ����.
			exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT,  @itemcode, @cnt, @sendid, @gameid_, ''

			---------------------------------------------------
			-- ����ȸ���� �αױ��(200������ ����).
			---------------------------------------------------
			select @idx2 = isnull(idx2, 0) + 1 from dbo.tUserWheelLog where gameid = @gameid_
			--select 'DEBUG ȸ���� �α� ���', @idx2 idx2

			insert into dbo.tUserWheelLog(gameid,   idx2,  mode,   usedcashcost,   ownercashcost)
			values(                      @gameid_, @idx2, @mode_, @usedcashcost_,      @cashcost)

			delete from dbo.tUserWheelLog where idx2 <= @idx2 - 20


			---------------------------------------------------
			-- ��Ű���� ���� ����.
			-- ���� �����ϱ�.
			---------------------------------------------------
			set @rkteam			= (CASE WHEN ISNUMERIC(SUBSTRING(@gameid_, LEN(LTRIM(@gameid_)), LEN(LTRIM(@gameid_)))) = 1 THEN CAST(SUBSTRING(@gameid_, LEN(LTRIM(@gameid_)), LEN(LTRIM(@gameid_))) AS INT) ELSE 0 END)%2
			set @rkstartstate 	= 1
		END


	-----------------------------------------------
	-- ����ڵ�ó��.
	-----------------------------------------------
	select @nResult_ rtn, @comment comment,
		   @cashcost cashcost, @gamecost gamecost,
		   @idx rewardidx, @itemcode rewarditemcode, @cnt rewardcnt,
		   @wheeltodaycnt wheeltodaycnt, @wheelgauage wheelgauage, @wheelfree wheelfree,
		   @rkteam rkteam, @rkstartstate rkstartstate,
		   @wheelgauageflag wheelgauageflag, @wheelgauagepoint wheelgauagepoint, @wheelgauagemax wheelgauagemax

	if(@nResult_ = @RESULT_SUCCESS)
		BEGIN
			--select 'DEBUG ���� ��������', @gameyear gameyear, @gamemonth gamemonth
			------------------------------------------------
			-- ��������
			------------------------------------------------
			update dbo.tUserMaster
				set
					cashcost		= @cashcost,
					wheeltodaycnt	= @wheeltodaycnt,
					wheelgauage		= @wheelgauage,
					wheelfree		= @wheelfree,
					bkwheelcnt		= @bkwheelcnt,
					bgroul1 		= @idx,				bgroul2 	= @itemcode,	bgroul3 	= @cnt,

					-- ȸ������ ������ ��ŷ���� ���۳�¥�� ����Ѵ�.
					rkteam			= @rkteam,
					rkstartdate		= getdate(),
					rkstartstate	= @rkstartstate,

					randserial		= @randserial_
			where gameid = @gameid_

			----------------------------------------------
			-- ��ŷ�������.
			----------------------------------------------
			----select 'DEBUG Ȧ¦ ��ŷ����',
			exec spu_subRankDaJun @gameid_, 0, 0, 0, 0, 0, 1, 0		-- �귿����Ʈ.

			--------------------------------------------------------------
			-- ����������.
			-- ������ > �󸮽�Ʈ�� �������ֱ�
			--------------------------------------------------------------
			exec spu_GiftList @gameid_

			---------------------------------------------
			-- �귿����.
			---------------------------------------------
			select top 8 * from dbo.tSystemWheelInfo where kind = 20 order by idx desc		-- ����.

			select top 8 * from dbo.tSystemWheelInfo where kind = 21 order by idx desc		-- ����.

		END

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off
End



