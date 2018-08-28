/*


*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_SeedHarvestTest', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_SeedHarvestTest;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_SeedHarvestTest
	@gameid_								varchar(20),
	@password_								varchar(20),
	@seedidx_								int,
	@mode_									int,
	@feeduse_								int,
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
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--�ش������� ã�� ����.
	declare @RESULT_ERROR_CASHCOST_LACK			int				set @RESULT_ERROR_CASHCOST_LACK			= -22			--��尡 �����ϴ�.
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- �������ڵ��ã��
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- ���������ʴ¸��
	declare @RESULT_ERROR_HARVEST_TIME_REMAIN	int				set @RESULT_ERROR_HARVEST_TIME_REMAIN	= -121			-- ���� �ð��� ����.

	------------------------------------------------
	--	2-2. ���°�
	------------------------------------------------
	-- �����°�.
	--declare @BLOCK_STATE_NO					int					set	@BLOCK_STATE_NO					= 0	-- �����¾ƴ�
	declare @BLOCK_STATE_YES					int					set	@BLOCK_STATE_YES				= 1	-- ������

	-- ������ �Һз�
	declare @ITEM_SUBCATEGORY_SEED				int					set @ITEM_SUBCATEGORY_SEED 					= 7  -- ����	(�Ǹ�[X], ����[X], ����[O])
	declare @ITEM_SUBCATEGORY_FEED				int					set @ITEM_SUBCATEGORY_FEED 					= 44 -- ����	(�Ǹ�[X], ����[O])
	declare @ITEM_SUBCATEGORY_HEART				int					set @ITEM_SUBCATEGORY_HEART 				= 40 -- ��Ʈ	(�Ǹ�[O], ����[O])
	declare @ITEM_SUBCATEGORY_UPGRADE_HOUSE		int					set @ITEM_SUBCATEGORY_UPGRADE_HOUSE 		= 60 -- ��

	-- ���� ���ǰ�
	declare @GIFTLIST_GIFT_KIND_MESSAGE			int					set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2
	declare @GIFTLIST_GIFT_KIND_MESSAGE_DEL		int					set @GIFTLIST_GIFT_KIND_MESSAGE_DEL			= -1
	declare @GIFTLIST_GIFT_KIND_GIFT_DEL		int					set @GIFTLIST_GIFT_KIND_GIFT_DEL			= -2
	declare @GIFTLIST_GIFT_KIND_GIFT_GET		int					set @GIFTLIST_GIFT_KIND_GIFT_GET			= -3
	declare @GIFTLIST_GIFT_KIND_GIFT_SELL		int					set @GIFTLIST_GIFT_KIND_GIFT_SELL			= -4

	-- ������(��Ȯ���).
	declare @USERSEED_HARVEST_MODE_NORMAL     	int					set @USERSEED_HARVEST_MODE_NORMAL			= 1	-- �Ϲݼ�Ȯ.
	declare @USERSEED_HARVEST_MODE_RIGHTNOW  	int					set @USERSEED_HARVEST_MODE_RIGHTNOW			= 2 -- ��ü�Ȯ.
	declare @USERSEED_HARVEST_MODE_GIVEUP  		int					set @USERSEED_HARVEST_MODE_GIVEUP			= 3 -- ������.

	-- ��Ÿ �����
	declare @USERMASTER_UPGRADE_STATE_NON		int					set @USERMASTER_UPGRADE_STATE_NON			= -1	--������, �Ϸ���.(����)
	declare @USERMASTER_UPGRADE_STATE_ING		int					set @USERMASTER_UPGRADE_STATE_ING			= 1		--�����ܰ�������.

	-- ������(����).
	declare @USERSEED_NEED_EMPTY				int					set @USERSEED_NEED_EMPTY					= -1	-- (������)
	declare @USERSEED_NEED_BUY					int					set @USERSEED_NEED_BUY						= -2

	-- ¥���������� �귿 ����Ȯ��.
	declare @ZAYO_PIECE_CHANCE_ONE				int					set @ZAYO_PIECE_CHANCE_ONE					= 1		-- ���� ( 1)
	declare @ZAYO_PIECE_CHANCE_NON				int					set @ZAYO_PIECE_CHANCE_NON					= -1	-- ���� (-1)

	declare @ZCP_APPEAR_LIMIT_FRESH				int					set @ZCP_APPEAR_LIMIT_FRESH					= 70	-- �ּҽż�����. 1���( 50 ~ 67 ), 2���( 75 ~ 93 ), 3��� ( 104 ~ 131 )
	declare @ZCP_APPEAR_CNT_DAY					int					set @ZCP_APPEAR_CNT_DAY						= 10	-- 1�� ����Ƚ��..
	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @comment			varchar(80)

	declare @gameid 			varchar(20)		set @gameid 		= ''
	declare @blockstate			int
	declare @market				int				set @market			= 1
	declare @cashcost			int				set @cashcost		= 0
	declare @gamecost			int				set @gamecost		= 0
	declare @feed				int				set @feed			= 0
	declare @heart				int				set @heart			= 0
	declare @heartmax			int				set @heartmax		= 0
	declare @feedmax			int				set @feedmax		= 0
	declare @qtfeeduse			int				set @qtfeeduse		= 0
	declare @plusheart			int				set @plusheart		= 0
	declare @plusfeed			int				set @plusfeed		= 0
	declare @tmp				int
	declare @housestep			int,
			@housestate			int,
			@housetime			datetime,
			@housestepmax		int
	declare @curdate			datetime		set @curdate		= getdate()

	declare @seeditemcode		int				set @seeditemcode		= @USERSEED_NEED_BUY
	declare @seedenddate		datetime		set @seedenddate		= getdate() + 10
	declare @seeditemname		varchar(40)		set @seeditemname		= ''
	declare @seedgapsecond		int				set @seedgapsecond		= 0

	declare @harvestcnt			int				set @harvestcnt			= 0
	declare @harvestitemcode	int				set @harvestitemcode	= -444

	declare @bresult			int				set @bresult			= -1
	declare @subcategory		int				set @subcategory		= -1
	declare @invenkind			int				set @invenkind			= -1

	-- ����������.
	declare @gaptime			int				set @gaptime			= 99999
	declare @danga				int				set @danga				= 99999
	declare @dangatime			int				set @dangatime			= 99999
	declare @needcashcost		int				set @needcashcost		= 99999

	-- ¥��������������Ȯ��.
	declare @zcpchance			int			set @zcpchance		= @ZAYO_PIECE_CHANCE_NON
	declare @zcpplus			int			set @zcpplus		= 0
	declare @zcprand			int			set @zcprand		= 0
	declare @salefresh			int			set @salefresh		= 0
	declare @zcpappearcnt		int			set @zcpappearcnt	= 9999
	declare @goldticket			int			set @goldticket		= 0

Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	set @comment = 'ERROR �˼����� ����(-1)'
	--select 'DEBUG 1-0 �Է°�', @gameid_ gameid_, @password_ password_, @seedidx_ seedidx_, @mode_ mode_, @feeduse_ feeduse_

	------------------------------------------------
	--	3-2. ��������.
	-- ���ʶ����� ����Ŭ
	-- 30(0)/30 -> 30���Ҹ�, 30������ -> 60(30)/30 * ���⼭ �����߻�
	--                                             > max + (9���� * 10����)
	------------------------------------------------
	-- ��������.
	select
		@gameid 		= gameid,	@blockstate 	= blockstate,	@market			= market,
		@zcpchance		= zcpchance,@zcpplus		= zcpplus,		@salefresh 		= salefresh,@zcpappearcnt	= zcpappearcnt,	 	@goldticket = goldticket,
		@cashcost		= cashcost,	@gamecost		= gamecost,		@feed			= feed,		@feedmax		= feedmax,
		@heart			= heart,	@heartmax		= heartmax,
		@qtfeeduse		= qtfeeduse,
		@housestep		= housestep,		@housestate		= housestate,		@housetime		= housetime
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 1-1 ��������', @gameid gameid, @market market, @cashcost cashcost, @gamecost gamecost, @feed feed, @heart heart, @feedmax feedmax, @heartmax heartmax

	select
		@seeditemcode	= itemcode,
		@seedenddate	= seedenddate
	from dbo.tUSerSeed where gameid = @gameid_ and seedidx = @seedidx_
	----select 'DEBUG 1-2 ����������', @gameid_ gameid_, @seedidx_ seedidx_, @seeditemcode seeditemcode, getdate() getdate, @seedenddate seedenddate

	---------------------------------------------
	-- ������ ����.
	---------------------------------------------
	select
		@seeditemname		= itemname,
		@harvestcnt			= param1,
		@harvestitemcode	= param6,
		@danga				= param8,
		@dangatime			= param9
	from dbo.tItemInfo
	where subcategory = @ITEM_SUBCATEGORY_SEED and itemcode = @seeditemcode
	--select 'DEBUG 1-3 ��������', @mode_ mode_, @harvestcnt harvestcnt, @harvestitemcode harvestitemcode, @danga danga

	---------------------------------------------
	-- 10�п� 2��񰡰����� ����.
	---------------------------------------------
	if( @mode_ = @USERSEED_HARVEST_MODE_RIGHTNOW and @seeditemname != '' )
		begin
			set @gaptime = dbo.fnu_GetDatePart( 's', getdate(), @seedenddate )
			set @needcashcost = case
										when ( @gaptime <= 0 ) then 0
										else 						( ( @gaptime /@dangatime ) + 1 ) * @danga
								 end
		end
	--select 'DEBUG ', @danga danga, @gaptime gaptime, @needcashcost needcashcost

	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '���̵� �������� �ʴ´�.'
			--select 'DEBUG ' + @comment
		END
	else if (@blockstate = @BLOCK_STATE_YES)
		BEGIN
			-- �������ΰ�?
			set @nResult_ 	= @RESULT_ERROR_BLOCK_USER
			set @comment 	= '��ó���� ���̵��Դϴ�.'
		END
	else if(@seeditemcode = @USERSEED_NEED_EMPTY)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '���۹��� ���������� ��Ȯ�߽��ϴ�.(�̹�����1)'
			--select 'DEBUG ' + @comment
		END
	else if(@mode_ = @USERSEED_HARVEST_MODE_RIGHTNOW and getdate() >= @seedenddate)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '���۹��� ���������� ��� �ϷḦ ���� �߽��ϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if(@harvestitemcode = -444)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_ITEMCODE
			set @comment 	= '������ ��ã�ҽ��ϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if(@mode_ not in(@USERSEED_HARVEST_MODE_NORMAL, @USERSEED_HARVEST_MODE_RIGHTNOW, @USERSEED_HARVEST_MODE_GIVEUP))
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment 	= '�������� �ʴ� �����Դϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if(@mode_ = @USERSEED_HARVEST_MODE_NORMAL and getdate() < @seedenddate)
		BEGIN
			select @seedgapsecond = dbo.fnu_GetDatePart('ss', @seedenddate, getdate())
			set @nResult_ 	= @RESULT_ERROR_HARVEST_TIME_REMAIN
			set @comment 	= '�ð��� ���� ' + @seeditemname + '('+ltrim(rtrim(str(@seeditemcode)))+') ��Ȯ�����ð�('+ltrim(rtrim(str(-@seedgapsecond)))+'��)'
			--select 'DEBUG ' + @comment

			if(@seedgapsecond < -10)
				begin
					exec spu_SubUnusualRecord2 @gameid_, @comment
				end
			set @nResult_ 	= @RESULT_SUCCESS
		END
	else if( @mode_ = @USERSEED_HARVEST_MODE_RIGHTNOW and @needcashcost > @cashcost )
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_CASHCOST_LACK
			set @comment 	= 'ĳ������� �����մϴ�.'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS �������� ��Ȯ�� �Ѵ�.'
			--select 'DEBUG ' + @comment

			--select 'DEBUG ����(����)', @housestate housestate, @housestep housestep, @housestepmax housestepmax, @housetime housetime
			if(@housestate = @USERMASTER_UPGRADE_STATE_ING and @curdate >= @housetime)
				begin
					select top 1 @housestepmax = housestepmax from dbo.tSystemInfo order by idx desc

					set @housestate = @USERMASTER_UPGRADE_STATE_NON
					set @housestep	= CASE
											WHEN (@housestep + 1 < @housestepmax) THEN @housestep + 1
											ELSE @housestepmax
									  END

					-- �����ۿϷ� > ����, ��Ʈ �ƽ�Ȯ��.
					select
						@feedmax		= param5,
						@heartmax		= param6
					from dbo.tItemInfo
					where subcategory = @ITEM_SUBCATEGORY_UPGRADE_HOUSE and param1 = @housestep
				end
			--select 'DEBUG ����(����)', @housestate housestate, @housestep housestep, @housestepmax housestepmax, @housetime housetime


			if(@mode_ = @USERSEED_HARVEST_MODE_GIVEUP)
				begin
					--select 'DEBUG ������ �Ϲ����ó��.'
					set @comment = 'SUCCESS �������� ��Ȯ�� ����Ѵ�.'
					update dbo.tUserSeed
						set
							itemcode = @USERSEED_NEED_EMPTY
					where gameid = @gameid_ and seedidx = @seedidx_
				end
			else if(@mode_ = @USERSEED_HARVEST_MODE_NORMAL and getdate() >= @seedenddate)
				begin
					--select 'DEBUG ������ �Ϲݼ�Ȯó��.'
					update dbo.tUserSeed
						set
							itemcode = @USERSEED_NEED_EMPTY
					where gameid = @gameid_ and seedidx = @seedidx_

					set @bresult = 1

					-- �ϴ� > �ش���������� or ������.
				end
			else if(@mode_ = @USERSEED_HARVEST_MODE_RIGHTNOW and @needcashcost <= @cashcost)
				begin
					---------------------------------------------------------------
					--select 'DEBUG ������ ��ü�Ȯ > �ð����Ϸ�.'
					---------------------------------------------------------------
					-- 2. �ð��ϷḸ.
					update dbo.tUserSeed
						set
							seedenddate = getdate()
					where gameid = @gameid_ and seedidx = @seedidx_

					-- �������.
					set @cashcost	= @cashcost - @needcashcost

					-----------------------------------
					-- ���ű�ϸ�ŷ
					-----------------------------------
					exec spu_UserItemBuyLogNew @gameid_, @seeditemcode, 0, @needcashcost, 0

					-- > ���޾���--------------------------------------------------------

					set @bresult = 0
				end

			-- �ش���������� or ������.
			if(@bresult = 1)
				begin
					-- �������ڵ� > ���� > �з�.
					select
						@subcategory 	= subcategory
					from dbo.tItemInfo where itemcode = @harvestitemcode

					set @invenkind = dbo.fnu_GetInvenFromSubCategory(@subcategory)
					--select 'DEBUG ���������� ', @subcategory subcategory, @invenkind invenkind

					-- �����ʰ��.
					set @feeduse_ = case
										when @feeduse_ < 0 then (-@feeduse_)
										else @feeduse_
									end

					set @feed 		= @feed - @feeduse_
					set @qtfeeduse 	= @qtfeeduse + @feeduse_

					if(@subcategory = @ITEM_SUBCATEGORY_HEART)
						begin
							--select 'DEBUG ��Ʈ -> �ٷ�����(Maxüũ)', @heart heart, @heartmax heartmax, @harvestcnt harvestcnt
							set @tmp 	= @heart
							set @heart 	= case
											when (@heart 				>= @heartmax) then (@heart)
											when (@heart + @harvestcnt  >= @heartmax) then (@heartmax)
											else (@heart + @harvestcnt)
										end
							set @bresult 	= 1
							set @plusheart 	= @harvestcnt

							------------------------------------------------
							-- ¥���������� �귿����.
							------------------------------------------------
							if( @goldticket >= 4 and @tmp < @heartmax and @salefresh >= @ZCP_APPEAR_LIMIT_FRESH and @zcpchance = @ZAYO_PIECE_CHANCE_NON and @zcpappearcnt <= @ZCP_APPEAR_CNT_DAY )
								begin
									set @zcprand  = Convert(int, ceiling(RAND() * 10000))
									set @zcpchance = dbo.fun_getZCPChance( 10,  @zcpplus, @zcprand )	-- �۹�(10).

									if( @zcpchance = @ZAYO_PIECE_CHANCE_ONE )
										begin
											set @zcpappearcnt = @zcpappearcnt + 1 -- 1ȸ����.

											exec spu_DayLogInfoStatic @market, 123, 1				-- �� ��������Ʈ ¥���������� �귿����.
										end
								end
						end
					else if(@subcategory = @ITEM_SUBCATEGORY_FEED)
						begin
							--select 'DEBUG ���� -> �ٷ�����', @feed feed, @feedmax feedmax, @harvestcnt harvestcnt
							set @tmp 	= @feed
							set @feed = case
											when (@feed 			   >= @feedmax) then (@feed)
											when (@feed + @harvestcnt  >= @feedmax) then (@feedmax)
											else (@feed + @harvestcnt)
										end

							set @bresult 	= 1
							set @plusfeed 	= @harvestcnt

							------------------------------------------------
							-- ¥���������� �귿����.
							------------------------------------------------
							if( @goldticket >= 4 and @tmp < @feedmax and @harvestcnt >= 38  and @salefresh >= @ZCP_APPEAR_LIMIT_FRESH and @zcpchance = @ZAYO_PIECE_CHANCE_NON and @zcpappearcnt <= @ZCP_APPEAR_CNT_DAY )
								begin
									set @zcprand  = Convert(int, ceiling(RAND() * 10000))
									set @zcpchance = dbo.fun_getZCPChance( 10,  @zcpplus, @zcprand )	-- �۹�(10).

									if( @zcpchance = @ZAYO_PIECE_CHANCE_ONE )
										begin
											set @zcpappearcnt = @zcpappearcnt + 1 -- 1ȸ����.

											exec spu_DayLogInfoStatic @market, 122, 1				-- �� ���������� ¥���������� �귿����.
										end
								end
						end

				end
		END

	--select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost, @feed feed, @heart heart, @feedmax feedmax, @heartmax heartmax, @bresult bresult, @zcpchance zcpchance
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			-----------------------------------
			-- ���� ���� �ݿ�.
			-----------------------------------
			update dbo.tUserMaster
			set
				cashcost		= @cashcost,	gamecost		= @gamecost,
				feed			= @feed,		heart			= @heart,
				feedmax			= @feedmax,		heartmax		= @heartmax,
				housestate 		= @housestate, 	housestep 		= @housestep,
				zcpchance		= @zcpchance,	zcpappearcnt	= @zcpappearcnt,

				qtfeeduse		= @qtfeeduse,
				bkheart			= bkheart + @plusheart,
				bkfeed			= bkfeed + @plusfeed

			where gameid = @gameid_

			--------------------------------------------------------------
			-- ������ ����.
			--------------------------------------------------------------
			--select * from dbo.tUserSeed where gameid = @gameid_ and seedidx = @seedidx_

			--------------------------------------------------------------
			-- ����������.
			--------------------------------------------------------------
			--if(@bresult = 2)
			--	begin
			--		exec spu_GiftList @gameid_
			--	end
		end
	--else if(@nResult_ = @RESULT_ERROR_HARVEST_TIME_REMAIN)
	--	begin
	--		-----------------------------------
	--		-- ���� ���� �ݿ�(X).
	--		-----------------------------------
    --
	--		--------------------------------------------------------------
	--		-- ������ ����.
	--		--------------------------------------------------------------
	--		--select * from dbo.tUserSeed where gameid = @gameid_ and seedidx = @seedidx_
    --
	--		--------------------------------------------------------------
	--		-- ����������.
	--		--------------------------------------------------------------
	--		--if(@bresult = 2)
	--		--	begin
	--		--		exec spu_GiftList @gameid_
	--		--	end
	--	end

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off
End



