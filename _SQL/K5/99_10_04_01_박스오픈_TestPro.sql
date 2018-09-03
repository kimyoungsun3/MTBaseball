/*

*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_BoxOpenModeTest', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_BoxOpenModeTest;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_BoxOpenModeTest
	@gameid_								varchar(20),					-- ���Ӿ��̵�
	@password_								varchar(20),
	@mode_									int,
	@boxslotidx_							int,
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
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--�ش������� ã�� ����

	-- ��Ÿ����
	declare @RESULT_ERROR_CASHCOST_LACK			int				set @RESULT_ERROR_CASHCOST_LACK			= -22			--��尡 �����ϴ�.
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- ���������ʴ¸��
	declare @RESULT_ERROR_INVEN_FULL			int				set @RESULT_ERROR_INVEN_FULL			= -101			-- �κ�����
	declare @RESULT_ERROR_NOT_MATCH				int				set @RESULT_ERROR_NOT_MATCH				= -110			-- �����ΰ� ��ġ�� �ȵǾ���.
	declare @RESULT_ERROR_TIME_REMAIN			int				set @RESULT_ERROR_TIME_REMAIN			= -123			-- ���� �ð��� ����.
	declare @RESULT_ERROR_NOT_FOUND_BOX			int				set @RESULT_ERROR_NOT_FOUND_BOX			= -156			-- �ڽ��� ã�� �� �����ϴ�.
	declare @RESULT_ERROR_OPERATE_OTHER_BOX		int				set @RESULT_ERROR_OPERATE_OTHER_BOX		= -157			-- �ڽ��� �ٸ����� �۵���.
	declare @RESULT_ERROR_NOT_OPERATE_BOX		int				set @RESULT_ERROR_NOT_OPERATE_BOX		= -158			-- �ڽ��� ���� ���۵����Դϴ�.

	------------------------------------------------
	--	2-2. ���°�
	------------------------------------------------
	-- �����ۺ� �κ��з�
	declare @USERITEM_INVENKIND_STEMCELL		int 			set @USERITEM_INVENKIND_STEMCELL			= 1040

	-- ������ �Һз�
	declare @ITEM_SUBCATEGORY_USERBATTLEBOX		int				set @ITEM_SUBCATEGORY_USERBATTLEBOX			= 37	-- ������Ʋ�ڽ�(37)
	declare @ITEM_SUBCATEGORY_STEMCELL			int				set @ITEM_SUBCATEGORY_STEMCELL				= 1040	-- �ٱ⼼��.

	-- �׷�.
	declare @ITEM_COMPOSETICKET_MOTHER			int				set @ITEM_COMPOSETICKET_MOTHER				= 3500	-- �ռ��� ����.
	declare @ITEM_PROMOTETICKET_MOTHER			int				set @ITEM_PROMOTETICKET_MOTHER				= 3600	-- �±��� ��.

	-- ���.
	declare @MODE_BOXOPEN_OPEN					int				set	@MODE_BOXOPEN_OPEN						= 1;
	declare @MODE_BOXOPEN_CASH					int				set	@MODE_BOXOPEN_CASH						= 2;
	declare @MODE_BOXOPEN_GETITEM				int				set	@MODE_BOXOPEN_GETITEM					= 3;
	declare @MODE_BOXOPEN_CASH_TRIPLE			int				set	@MODE_BOXOPEN_CASH_TRIPLE				= 12;

	-- ������ݻ���.
	declare @TRADE_STATE_OPEN					int					set @TRADE_STATE_OPEN						= 1	 	-- ���ο���(1)
	declare @TRADE_STATE_CLOSE					int					set @TRADE_STATE_CLOSE						= -1	-- �������(-1)

	-- ¥���������� �귿 ����Ȯ��.
	declare @ZAYO_PIECE_CHANCE_ONE				int					set @ZAYO_PIECE_CHANCE_ONE					= 1		-- ���� ( 1)
	declare @ZAYO_PIECE_CHANCE_NON				int					set @ZAYO_PIECE_CHANCE_NON					= -1	-- ���� (-1)

	declare @ZCP_APPEAR_LIMIT_FRESH				int					set @ZCP_APPEAR_LIMIT_FRESH					= 70	-- �ּҽż�����. 1���( 50 ~ 67 ), 2���( 75 ~ 93 ), 3��� ( 104 ~ 131 )
	declare @ZCP_APPEAR_CNT_DAY					int					set @ZCP_APPEAR_CNT_DAY						= 10	-- 1�� ����Ƚ��..

	------------------------------------------------
	--	2-3. ���λ�� ����
	------------------------------------------------
	declare @comment		varchar(256)
	declare @gameid			varchar(20)				set @gameid				= ''
	declare @market			int						set @market				= 0
	declare @cashcost		int						set @cashcost 			= 0
	declare @gamecost		int						set @gamecost 			= 0
	declare @heart			int						set @heart 				= 0
	declare @feed			int						set @feed 				= 0
	declare @fpoint			int						set @fpoint				= 0
	declare @goldticket		int						set @goldticket			= 0
	declare @goldticketmax	int						set @goldticketmax		= 0
	declare @goldtickettime	datetime				set @goldtickettime		= getdate()
	declare @battleticket	int						set @battleticket		= 0
	declare @battleticketmax	int					set @battleticketmax	= 0
	declare @battletickettime	datetime			set @battletickettime	= getdate()
	declare @curdate		datetime				set @curdate			= getdate()
	declare @invenstemcellmax	int					set @invenstemcellmax	= 50
	declare @cnt			int						set @cnt				= 0
	declare @tradestate		int						set @tradestate			= @TRADE_STATE_CLOSE

	-- ¥��������������Ȯ��.
	declare @zcpchance		int						set @zcpchance			= @ZAYO_PIECE_CHANCE_NON
	declare @zcpplus		int						set @zcpplus			= 0
	declare @zcprand		int						set @zcprand			= 0
	declare @salefresh		int						set @salefresh			= 0
	declare @zcpappearcnt	int						set @zcpappearcnt		= 9999

	-- ������Ʋ�ڽ�
	declare @boxslotidx		int						set @boxslotidx			= -1
	declare @boxslottime	datetime				set @boxslottime		= getdate()
	declare @boxslot1 		int						set @boxslot1			= -1
	declare @boxslot2 		int						set @boxslot2			= -1
	declare @boxslot3 		int						set @boxslot3			= -1
	declare @boxslot4 		int						set @boxslot4			= -1

	-- ����������.
	declare @itemcode		int
	declare @boxgrowtime	int						set @boxgrowtime		= 99999
	declare @gaptime		int						set @gaptime			= 99999
	declare @danga			int						set @danga				= 99999
	declare @needcashcost	int						set @needcashcost		= 99999
	declare @needcashcost3	int						set @needcashcost3		= 99999

	-- ��������.
	declare @tier			int						set @tier				= 0
	declare @gamecostmin	int						set @gamecostmin		= 0		--�����ּ�.
	declare @gamecostmax	int						set @gamecostmax		= 0		--�����ִ�.
	declare @composeticket	int						set @composeticket		= 0		--�ռ�ī��.
	declare @promoteticket	int						set @promoteticket		= 0		--�±�ī��.
	declare @generalstem	int						set @generalstem		= 0		--�Ϲݼ���.
	declare @epicstem		int						set @epicstem			= 0		--���ȼ���.

	declare @rewardgamecost			int				set @rewardgamecost			= 0
	declare @rewardcomposeticket	int				set @rewardcomposeticket	= 0
	declare @rewardpromoteticket	int				set @rewardpromoteticket	= 0
	declare @rewardgeneralstem		int				set @rewardgeneralstem		= 0
	declare @rewardepicstem			int				set @rewardepicstem			= 0
	declare @loop					int				set @loop					= 0
	declare @rand					int				set @rand					= 0
	declare @rand2					int				set @rand2					= 0
	declare @randbase				int				set @randbase				= 0
	declare @randval				int				set @randval				= 0
	declare @stemcellitemcode		int				set @stemcellitemcode		= 0
	declare @celllistidx			int				set @celllistidx			= 0

	-- VIPȿ��.
	declare @cashpoint				int				set @cashpoint				= 0
	declare @vip_plus				int				set @vip_plus				= 0
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ 	= @RESULT_ERROR
	set @comment 	= 'ERROR �˼����� ����(-1)'
	--select 'DEBUG �Է�����', @gameid_ gameid_, @password_ password_, @mode_ mode_, @boxslotidx_ boxslotidx_


	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	select
		@gameid 		= gameid,			@market 		= market,
		@cashcost		= cashcost,			@gamecost		= gamecost,			@cashpoint			= cashpoint,
		@heart			= heart,			@feed			= feed,				@fpoint				= fpoint,
		@tier			= tier,				@invenstemcellmax= invenstemcellmax,
		@zcpchance		= zcpchance,		@zcpplus		= zcpplus,			@salefresh 			= salefresh,	@zcpappearcnt	= zcpappearcnt,
		@tradestate		= tradestate,
		@goldticket		= goldticket, 		@goldticketmax 	= goldticketmax, 	@goldtickettime		= goldtickettime,
		@battleticket	= battleticket, 	@battleticketmax= battleticketmax, 	@battletickettime	= battletickettime,
		@boxslotidx		= boxslotidx,		@boxslottime	= boxslottime,
		@boxslot1		= boxslot1,			@boxslot2		= boxslot2,			@boxslot3		= boxslot3,			@boxslot4		= boxslot4
	from dbo.tUserMaster
	where gameid = @gameid_
	--select 'DEBUG ��������', @gameid gameid, @boxslotidx boxslotidx, @boxslottime boxslottime, @boxslot1 boxslot1, @boxslot2 boxslot2, @boxslot3 boxslot3, @boxslot4 boxslot4

	if(@gameid != '')
		begin
			------------------------------------------------
			-- Ƽ�� ���� ����.
			------------------------------------------------
			select
				@goldtickettime = rtndate,
				@goldticket		= rtncount
			from dbo.fnu_GetActionTime(@goldtickettime, getdate(), @goldticket, @goldticketmax)
			--select 'DEBUG ', @goldtickettime goldtickettime, @goldticket goldticket, @goldticketmax goldticketmax

			select
				@battletickettime 	= rtndate,
				@battleticket		= rtncount
			from dbo.fnu_GetActionTime(@battletickettime, getdate(), @battleticket, @battleticketmax)
			--select 'DEBUG ', @battletickettime battletickettime, @battleticket battleticket, @battleticketmax battleticketmax

			------------------------------------------------
			-- �ٱ⼼���� ����.
			------------------------------------------------
			select @cnt = count(*) from dbo.tUserItem
			where gameid = @gameid_ and invenkind = @USERITEM_INVENKIND_STEMCELL

			------------------------------------------------
			-- ���� ���� ����Ʈ.
			------------------------------------------------
			DECLARE @tTempTable TABLE(
				listidx			int
			);
		end

	------------------------------------------------
	--	3-3. ����Ȳ���� �ڵ�� �з�
	------------------------------------------------
	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR ���̵� �������� �ʴ´�.'
			--select 'DEBUG ' + @comment
		END
	else if ( @mode_ not in (@MODE_BOXOPEN_OPEN, @MODE_BOXOPEN_CASH, @MODE_BOXOPEN_GETITEM, @MODE_BOXOPEN_CASH_TRIPLE ))
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment 	= 'ERROR �������� �ʴ� ����Դϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if (  ( @boxslotidx_ = 1 and @boxslot1 = -1 )
			or ( @boxslotidx_ = 2 and @boxslot2 = -1 )
			or ( @boxslotidx_ = 3 and @boxslot3 = -1 )
			or ( @boxslotidx_ = 4 and @boxslot4 = -1 )
			or ( @boxslotidx_ <= 0 or @boxslotidx_ > 4 )
			)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_BOX
			set @comment 	= 'ERROR �ش� ����(' + ltrim(str(@boxslotidx_)) + ')�� �ڽ��� �������� �ʽ��ϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if( @mode_ in ( @MODE_BOXOPEN_CASH, @MODE_BOXOPEN_CASH_TRIPLE, @MODE_BOXOPEN_GETITEM ) and @cnt >= @invenstemcellmax)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_INVEN_FULL
			set @comment 	= 'ERROR ���� �κ��� Ǯ�Դϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if ( @mode_ = @MODE_BOXOPEN_OPEN )
		BEGIN
			--select 'DEBUG ���¸��'
			------------------------------------------
			-- ���¸��.
			------------------------------------------
			if( @boxslotidx_ = @boxslotidx)
				BEGIN
					set @nResult_ 	= @RESULT_SUCCESS
					set @comment = 'SUCCESS ���� ���¸�� �۵��մϴ�.(2)'
					--select 'DEBUG ' + @comment
				END
			else if( @boxslotidx != -1 )
				BEGIN
					set @nResult_ 	= @RESULT_ERROR_OPERATE_OTHER_BOX
					set @comment 	= 'ERROR �ٸ� ������ �۵����Դϴ�.'
					--select 'DEBUG ' + @comment
				END
			else
				BEGIN
					set @nResult_ = @RESULT_SUCCESS
					set @comment = 'SUCCESS ���� ���¸�� �۵��մϴ�.(1)'
					--select 'DEBUG ' + @comment


					set @boxslotidx = @boxslotidx_
					set @itemcode = case
										when @boxslotidx_ = 1 then @boxslot1
										when @boxslotidx_ = 2 then @boxslot2
										when @boxslotidx_ = 3 then @boxslot3
										else 					   @boxslot4
									end
					select @boxgrowtime	= param2 from dbo.tItemInfo where itemcode = @itemcode and subcategory = @ITEM_SUBCATEGORY_USERBATTLEBOX

					set @vip_plus = dbo.fun_GetVIPPlus( 7, @cashpoint, @boxgrowtime) -- �ڽ����½ð�.
					--select 'DEBUG (��)', @boxgrowtime boxgrowtime
					set @boxgrowtime = @boxgrowtime - @vip_plus
					--select 'DEBUG (��)', @boxgrowtime boxgrowtime

					set @boxslottime = DATEADD(ss, @boxgrowtime, getdate())
					--select 'DEBUG ', @boxslotidx boxslotidx, @boxslottime boxslottime, @itemcode itemcode, @boxgrowtime boxgrowtime
				END
		END
	else if ( @mode_ in ( @MODE_BOXOPEN_CASH, @MODE_BOXOPEN_CASH_TRIPLE, @MODE_BOXOPEN_GETITEM ) )
		BEGIN
			--select 'DEBUG ĳ����� or ȹ����'

			------------------------------------------
			-- ĳ�����.
			------------------------------------------
			if( @mode_ != @MODE_BOXOPEN_CASH_TRIPLE and @boxslotidx_ != @boxslotidx )
				BEGIN
					set @nResult_ 	= @RESULT_ERROR_NOT_OPERATE_BOX
					set @comment 	= 'ERROR �ش� ������ ���۵����Դϴ�.'
					--select 'DEBUG ' + @comment
				END
			else if( @mode_ = @MODE_BOXOPEN_GETITEM and @boxslottime > getdate() )
				BEGIN
					set @nResult_ 	= @RESULT_ERROR_TIME_REMAIN
					set @comment 	= 'ERROR �ڽ� ���±��� �ð��� ���ҽ��ϴ�.'
					--select 'DEBUG ' + @comment
				END
			else
				BEGIN
					-----------------------------------------------------------------------------------------
					-- �ð��� ĳ���� ����ϱ�.
					--select dbo.fnu_GetDatePart('s', '2016-03-25 12:00:00', '2016-03-25 11:59:00')	-> -60
					--select dbo.fnu_GetDatePart('s', '2016-03-25 12:00:00', '2016-03-25 12:09:00')	-> -540
					--select dbo.fnu_GetDatePart('s', '2016-03-25 12:00:00', '2016-03-25 12:10:01')	-> 601
					--select dbo.fnu_GetDatePart('s', '2016-03-25 12:00:00', '2016-03-25 12:11:00')	-> 660
					-----------------------------------------------------------------------------------------
					set @itemcode = case
										when @boxslotidx_ = 1 then @boxslot1
										when @boxslotidx_ = 2 then @boxslot2
										when @boxslotidx_ = 3 then @boxslot3
										else 					   @boxslot4
									end
					select
						@danga			= param1,
						@needcashcost3	= param3
					from dbo.tItemInfo where itemcode = @itemcode and subcategory = @ITEM_SUBCATEGORY_USERBATTLEBOX

					set @gaptime = dbo.fnu_GetDatePart( 's', getdate(), @boxslottime )

					set @needcashcost = case
												when ( @gaptime <= 0 ) then 0
												else 						( ( @gaptime /600) + 1 ) * @danga
										 end
					--select 'DEBUG (��)', @itemcode itemcode, @danga danga, @gaptime gaptime, @needcashcost needcashcost
					set @needcashcost = case
												when ( @mode_ = @MODE_BOXOPEN_CASH_TRIPLE ) then @needcashcost3
												else                                             @needcashcost
										 end
					--select 'DEBUG (��)', @itemcode itemcode, @danga danga, @gaptime gaptime, @needcashcost needcashcost


					if( @needcashcost > @cashcost )
						BEGIN
							set @nResult_ = @RESULT_ERROR_CASHCOST_LACK
							set @comment = 'ERROR ĳ���� �����մϴ�.'
							--select 'DEBUG ' + @comment
						END
					else
						BEGIN
							set @nResult_ = @RESULT_SUCCESS
							if( @mode_ = @MODE_BOXOPEN_CASH )
								begin
									set @comment = 'SUCCESS ĳ�� ���������߽��ϴ�.'
									exec spu_DayLogInfoStatic @market, 91, 1				-- �� �ڽ����½ð�����
								end
							else if( @mode_ = @MODE_BOXOPEN_CASH_TRIPLE )
								begin
									set @comment = 'SUCCESS ĳ�� 3�� �����߽��ϴ�.'
									exec spu_DayLogInfoStatic @market, 92, 1				-- �� �ڽ���ÿ���
								end
							else
								begin
									set @comment = 'SUCCESS �ð��Ǿ �����߽��ϴ�.'
									exec spu_DayLogInfoStatic @market, 90, 1				-- �� �ڽ����½ð��Ǿ.
								end
							--select 'DEBUG ' + @comment




							-- �ش罽�� �����, ����߻���
							if ( @boxslotidx_ = 1 )
								begin
									set @boxslot1 = -1
								end
							else if ( @boxslotidx_ = 2 )
								begin
									set @boxslot2 = -1
								end
							else if ( @boxslotidx_ = 3 )
								begin
									set @boxslot3 = -1
								end
							else
								begin
									set @boxslot4 = -1
								end
							set @boxslotidx = -1

							-- ĳ������.
							set @cashcost = @cashcost - @needcashcost

							-- ������Ʋ�� �ڽ����޿� ���� ����������.
							select
								@gamecostmin = case
													when @tier = 1 then gamecostmin1
													when @tier = 2 then gamecostmin2
													when @tier = 3 then gamecostmin3
													when @tier = 4 then gamecostmin4
													when @tier = 5 then gamecostmin5
													when @tier = 6 then gamecostmin6
													when @tier = 7 then gamecostmin7
													when @tier = 8 then gamecostmin8
													else				gamecostmin1
												end,
								@gamecostmax = case
													when @tier = 1 then gamecostmax1
													when @tier = 2 then gamecostmax2
													when @tier = 3 then gamecostmax3
													when @tier = 4 then gamecostmax4
													when @tier = 5 then gamecostmax5
													when @tier = 6 then gamecostmax6
													when @tier = 7 then gamecostmax7
													when @tier = 8 then gamecostmax8
													else				gamecostmax1
												end,
								@composeticket = case
													when @tier = 1 then composeticket1
													when @tier = 2 then composeticket2
													when @tier = 3 then composeticket3
													when @tier = 4 then composeticket4
													when @tier = 5 then composeticket5
													when @tier = 6 then composeticket6
													when @tier = 7 then composeticket7
													when @tier = 8 then composeticket8
													else				composeticket1
												end,
								@promoteticket = case
													when @tier = 1 then promoteticket1
													when @tier = 2 then promoteticket2
													when @tier = 3 then promoteticket3
													when @tier = 4 then promoteticket4
													when @tier = 5 then promoteticket5
													when @tier = 6 then promoteticket6
													when @tier = 7 then promoteticket7
													when @tier = 8 then promoteticket8
													else				promoteticket1
												end,
								@generalstem = case
													when @tier = 1 then generalstem1
													when @tier = 2 then generalstem2
													when @tier = 3 then generalstem3
													when @tier = 4 then generalstem4
													when @tier = 5 then generalstem5
													when @tier = 6 then generalstem6
													when @tier = 7 then generalstem7
													when @tier = 8 then generalstem8
													else				generalstem1
												end,
								@epicstem = case
													when @tier = 1 then epicstem1
													when @tier = 2 then epicstem2
													when @tier = 3 then epicstem3
													when @tier = 4 then epicstem4
													when @tier = 5 then epicstem5
													when @tier = 6 then epicstem6
													when @tier = 7 then epicstem7
													when @tier = 8 then epicstem8
													else				epicstem1
												end
							from dbo.tSystemBoxInfo
							where itemcode = @itemcode
							--select 'DEBUG ', @tier tier, @itemcode itemcode, @gamecostmin gamecostmin, @gamecostmax gamecostmax, @composeticket composeticket, @promoteticket promoteticket, @generalstem generalstem, @epicstem epicstem



							-------------------------
							-- ��������.
							-------------------------
							set @rewardgamecost	= Convert(int, ceiling(RAND() * ( @gamecostmax - @gamecostmin ) ) ) + @gamecostmin
							--select 'DEBUG (��)', @rewardgamecost rewardgamecost, @epicstem epicstem, @generalstem generalstem
							set @rewardgamecost = dbo.fun_GetDealerStateValue( 1,  @tradestate, @rewardgamecost ) -- �ڽ����� ����(1)
							set @gamecost		= @gamecost + @rewardgamecost
							--select 'DEBUG ', @rewardgamecost rewardgamecost, @gamecostmin gamecostmin, @gamecostmax gamecostmax

							-------------------------
							-- �ռ�, �±��� �� ���� -> ��������.
							-------------------------
							if( @mode_ = @MODE_BOXOPEN_CASH_TRIPLE )
								begin
									set @composeticket = @composeticket * 3
									set @promoteticket = @promoteticket * 3
								end

							-------------------------
							-- �ռ�, �±��� �� ����.
							-------------------------
							set @rewardcomposeticket	= @composeticket
							exec spu_SetDirectItemNew @gameid, @ITEM_COMPOSETICKET_MOTHER, @rewardcomposeticket, 19, @rtn_ = @celllistidx OUTPUT
							insert into @tTempTable(listidx) values( @celllistidx )

							set @rewardpromoteticket	= @promoteticket
							exec spu_SetDirectItemNew @gameid, @ITEM_PROMOTETICKET_MOTHER, @rewardpromoteticket, 19, @rtn_ = @celllistidx OUTPUT
							insert into @tTempTable(listidx) values( @celllistidx )

							--select 'DEBUG ', @rewardcomposeticket rewardcomposeticket, @rewardpromoteticket rewardpromoteticket

							-------------------------
							-- ������ ���� ��������.
							-- 1�� Ƽ� ���� Ƽ�� ������.
							-- (1)	1			-> (1)
							-- (2)	2, 3		->
							-- (3)	4, 5
							-- (4)	6, 7, 8
							-- (5) 	x
							-------------------------
							if( @tier <= 1 or @tier > 8)
								begin
									set @randval 	= 1
									set @randbase 	= 0
								end
							else if( @tier <= 2 )
								begin
									set @randval 	= 2
									set @randbase 	= 0
								end
							else if( @tier >= 6 )
								begin
									set @randval 	= 3
									set @randbase 	= 6 - 3
								end
							else
								begin
									set @randval 	= 3
									set @randbase 	= @tier - 3
								end
							--select 'DEBUG ', @tier tier, @randbase randbase, @randval randval


							-------------------------
							-- ���ȼ�������.
							-------------------------
							set @epicstem 		= dbo.fun_GetDealerStateValue( 2,  @tradestate, @epicstem )	-- �ڽ����� ��������(2)
							set @rewardepicstem	= @epicstem
							set @loop			= 0
							if( @mode_ = @MODE_BOXOPEN_CASH_TRIPLE )
								begin
									set @rewardepicstem = @rewardepicstem * 2
								end
							--select 'DEBUG ', @rewardepicstem rewardepicstem
							while(@loop < @rewardepicstem)
								begin
									set @rand 		= Convert(int, ceiling(RAND() * 1000))
									set @rand2 		= Convert(int, ceiling(RAND() * @randval)) + @randbase
									set @stemcellitemcode = dbo.fun_GetBoxStemCell( 2, @rand, @rand2 )

									exec spu_SetDirectItemNew @gameid, @stemcellitemcode, 1, 19, @rtn_ = @celllistidx OUTPUT
									--select 'DEBUG epic', @loop loop, @rand rand, @rand2 rand2, @stemcellitemcode stemcellitemcode, @celllistidx celllistidx

									insert into @tTempTable(listidx) values( @celllistidx )
									set @loop = @loop + 1
								end

							-------------------------
							-- �Ϲݼ�������.
							-------------------------
							set @generalstem 		= dbo.fun_GetDealerStateValue( 2,  @tradestate, @generalstem )	-- �ڽ����� ��������(2)
							--select 'DEBUG (��)', @rewardgamecost rewardgamecost, @epicstem epicstem, @generalstem generalstem
							set @rewardgeneralstem	= @generalstem
							set @loop				= 0
							if( @mode_ = @MODE_BOXOPEN_CASH_TRIPLE )
								begin
									set @rewardgeneralstem = @rewardgeneralstem + @rewardgeneralstem * 50 / 100
								end
							--select 'DEBUG ', @rewardgeneralstem rewardgeneralstem
							while(@loop < @rewardgeneralstem)
								begin
									set @rand 		= Convert(int, ceiling(RAND() * 1000))
									set @rand2 		= Convert(int, ceiling(RAND() * @randval)) + @randbase
									set @stemcellitemcode = dbo.fun_GetBoxStemCell( 1, @rand, @rand2 )

									exec spu_SetDirectItemNew @gameid, @stemcellitemcode, 1, 19, @rtn_ = @celllistidx OUTPUT
									--select 'DEBUG general', @loop loop, @rand rand, @rand2 rand2, @stemcellitemcode stemcellitemcode, @celllistidx celllistidx

									insert into @tTempTable(listidx) values( @celllistidx )
									set @loop = @loop + 1
								end


							------------------------------------------------
							-- ¥���������� �귿����.
							------------------------------------------------
							if( @salefresh >= @ZCP_APPEAR_LIMIT_FRESH and @zcpchance = @ZAYO_PIECE_CHANCE_NON and @zcpappearcnt <= @ZCP_APPEAR_CNT_DAY )
								begin
									set @zcprand  = Convert(int, ceiling(RAND() * 10000))
									set @zcpchance = dbo.fun_getZCPChance( 20,  @zcpplus, @zcprand )	-- �ڽ�(20).

									if( @zcpchance = @ZAYO_PIECE_CHANCE_ONE )
										begin
											set @zcpappearcnt = @zcpappearcnt + 1 -- 1ȸ����.

											exec spu_DayLogInfoStatic @market, 121, 1				-- �� �ڽ�   ¥���������� �귿����.
										end
								end

						END
				END
		END

	--------------------------------------------------
	----	3-3. �������
	--------------------------------------------------
	--select @nResult_ rtn, @comment comment,
	--	   @cashcost cashcost, @gamecost gamecost, @heart heart, @feed feed, @fpoint fpoint,
	--	   @goldticket goldticket, @battleticket battleticket,
	--	   @boxslotidx boxslotidx, @boxslottime boxslottime,
	--	   @boxslot1 boxslot1, @boxslot2 boxslot2, @boxslot3 boxslot3, @boxslot4 boxslot4,
	--	   @rewardgamecost rewardgamecost, @rewardcomposeticket rewardcomposeticket, @rewardpromoteticket rewardpromoteticket, @rewardgeneralstem rewardgeneralstem, @rewardepicstem rewardepicstem,
	--	   @zcpchance zcpchance

	if(@nResult_ = @RESULT_SUCCESS)
		BEGIN
			------------------------------------------------
			-- ��������
			------------------------------------------------
			update dbo.tUserMaster
				set
					cashcost		= @cashcost, 		gamecost	= @gamecost,
					zcpchance		= @zcpchance,		zcpappearcnt= @zcpappearcnt,
					feed			= @feed,			heart		= @heart,				fpoint		= @fpoint,
					goldticket		= @goldticket, 		goldticketmax 	= @goldticketmax, 	goldtickettime	= @goldtickettime,
					battleticket	= @battleticket, 	battleticketmax	= @battleticketmax, battletickettime= @battletickettime,
					boxslotidx		= @boxslotidx,		boxslottime		= @boxslottime,
					boxslot1		= @boxslot1,		boxslot2		= @boxslot2,		boxslot3		= @boxslot3,			boxslot4		= @boxslot4
			where gameid = @gameid_

			--------------------------------------------------------------
			-- ������ ����.
			--------------------------------------------------------------
			--select * from dbo.tUserItem
			--where gameid = @gameid_ and listidx in ( select listidx from @tTempTable )
		END

	------------------------------------------------
	-- �ٸ� ������ ����Ʈ ������ ����.
	------------------------------------------------
	set nocount off
End

