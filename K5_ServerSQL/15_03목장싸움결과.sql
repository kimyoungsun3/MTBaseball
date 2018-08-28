/*
--delete from dbo.tBattleLog where gameid = 'xxxx2'
select * from dbo.tBattleLog where gameid = 'xxxx2' order by idx desc

update dbo.tUserMaster set battleflag = 1 where gameid = 'xxxx2'
exec spu_AniBattleResult 'xxxx2', '049000s1i0n7t8445289', 17,  1, 90, 3, -1

update dbo.tUserMaster set battleflag = 1 where gameid = 'xxxx2'
exec spu_AniBattleResult 'xxxx2', '049000s1i0n7t8445289', 17, -1, 90, 0, -1

update dbo.tUserMaster set battleflag = 1 where gameid = 'xxxx2'
exec spu_AniBattleResult 'xxxx2', '049000s1i0n7t8445289', 62,  1, 90, 2, -1

update dbo.tUserMaster set battleflag = 1 where gameid = 'xxxx2'
exec spu_AniBattleResult 'xxxx2', '049000s1i0n7t8445289', 61,  1, 90, 1, -1

update dbo.tUserMaster set battleflag = 1 where gameid = 'xxxx2'
exec spu_AniBattleResult 'xxxx2', '049000s1i0n7t8445289', 65,  1, 90, 3, -1
*/
use Game4Farmvill5
GO

IF OBJECT_ID ( 'dbo.spu_AniBattleResult', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_AniBattleResult;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_AniBattleResult
	@gameid_								varchar(20),					-- ���Ӿ��̵�
	@password_								varchar(20),
	@battleidx2_							int,
	@result_								int,
	@playtime_								int,
	@star_									int,
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
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--�ش������� ã�� ����
	declare @RESULT_ERROR_TICKET_LACK			int				set @RESULT_ERROR_TICKET_LACK			= -150			-- Ƽ�ϼ�������.

	------------------------------------------------
	--	2-2. ���°�
	------------------------------------------------
	-- ������ �Һз�.
	declare @ITEM_SUBCATEGORY_STEMCELL			int					set @ITEM_SUBCATEGORY_STEMCELL				= 1040	-- �ٱ⼼��.

	-- ��������.
	--declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2

	-- �������.
	declare @BATTLE_RESULT_WIN					int					set @BATTLE_RESULT_WIN				=  1	-- (����)
	--declare @BATTLE_RESULT_LOSE				int					set @BATTLE_RESULT_LOSE				= -1
	--declare @BATTLE_RESULT_DRAW				int					set @BATTLE_RESULT_DRAW				=  0

	-- �÷�������.
	declare @BATTLE_END							int					set @BATTLE_END						= 0
	declare @BATTLE_READY						int					set @BATTLE_READY					= 1

	--declare @DEFINE_TIME_BASE					int					set @DEFINE_TIME_BASE				= 8000 -- 8��
	--declare @USER_LOG_MAX						int					set @USER_LOG_MAX 					= 50	-- 12���� * 40��.
	declare @GOLDTICKET_ITEMCODE				int					set @GOLDTICKET_ITEMCODE			= 3000

	-- ������ݻ���.
	declare @TRADE_STATE_OPEN					int					set @TRADE_STATE_OPEN						= 1	 	-- ���ο���(1)
	declare @TRADE_STATE_CLOSE					int					set @TRADE_STATE_CLOSE						= -1	-- �������(-1)

	------------------------------------------------
	--	2-3. ���λ�� ����
	------------------------------------------------
	declare @comment				varchar(512)		set @comment			= ''
	declare @gameid					varchar(20)			set @gameid				= ''
	declare @cashcost				int					set @cashcost 			= 0
	declare @gamecost				int					set @gamecost 			= 0
	declare @heart					int					set @heart 				= 0
	declare @feed					int					set @feed 				= 0
	declare @fpoint					int					set @fpoint				= 0
	declare @goldticket				int					set @goldticket			= 0
	declare @goldticketmax			int					set @goldticketmax		= 0
	declare @goldtickettime			datetime			set @goldtickettime		= getdate()
	declare @battleticket			int					set @battleticket		= 0
	declare @battleticketmax		int					set @battleticketmax	= 0
	declare @battletickettime		datetime			set @battletickettime	= getdate()
	declare @battleflag				int					set @battleflag			= @BATTLE_END
	declare @farmidx				int					set @farmidx			= 6900
	declare @star					int					set @star				=  0
	declare @needticket				int					set @needticket			= 4
	declare @tradestate				int					set @tradestate			= @TRADE_STATE_CLOSE

	declare @result					int					set @result				= -444
	declare @reward1				int					set @reward1			= -1
	declare @reward2				int					set @reward2			= -1
	declare @reward3				int					set @reward3			= -1
	declare @reward4				int					set @reward4			= -1
	declare @rewardgoldticket		int					set @rewardgoldticket	= -1
	declare @rewardgamecost			int					set @rewardgamecost		=  0

	declare @rd1					int					set @rd1				= -1
	declare @rd2					int					set @rd2				= -1
	declare @rd3					int					set @rd3				= -1
	declare @rd4					int					set @rd4				= -1
	declare @rdgoldticket			int					set @rdgoldticket		=  0
	declare @rdgamecost				int					set @rdgamecost			=  0

	declare @sendid					varchar(60)			set @sendid				= 'SysBattle'
	declare @rand					int,
			@cnt					int

	declare @listidx1				int					set @listidx1			= -1
	declare @listidx2				int					set @listidx2			= -1
	declare @listidx3				int					set @listidx3			= -1
	declare @listidx4				int					set @listidx4			= -1

Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG �Է�����', @gameid_ gameid_, @password_ password_, @battleidx2_ battleidx2_, @result_ result_, @playtime_ playtime_

	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	select
		@gameid 		= gameid,
		@cashcost		= cashcost,			@gamecost		= gamecost,			@heart				= heart,			@feed			= feed,				@fpoint			= fpoint,
		@star			= star,
		@tradestate		= tradestate,
		@battleflag		= battleflag,
		@goldticket		= goldticket, 		@goldticketmax 	= goldticketmax, 	@goldtickettime		= goldtickettime,
		@battleticket	= battleticket, 	@battleticketmax= battleticketmax, 	@battletickettime	= battletickettime
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG ��������', @gameid gameid

	select
		@result			= result,	@farmidx		= farmidx
	from dbo.tBattleLog
	where gameid = @gameid_ and idx2 = @battleidx2_
	--select 'DEBUG ��Ʋ����', @battleidx2_ battleidx2_, @result result, @farmidx farmidx

	select
		@needticket		= param14,
		@rd1 			= param23, @rd2 		= param24, @rd3 	= param25, @rd4 	= param26,
		@rdgoldticket 	= param27, @rdgamecost 	= param28
	from dbo.tItemInfo
	where itemcode = @farmidx
	--select 'DEBUG �ʿ��������.', @farmidx farmidx, @rd1 rd1, @rd2 rd2, @rd3 rd3, @rd4 rd4, @rdgoldticket rdgoldticket, @rdgamecost rdgamecost

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
		end

	------------------------------------------------
	-- 3-3. �� ���Ǻ� �б�
	------------------------------------------------
	if( @gameid = '' )
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR ���̵� �������� �ʴ´�.'
			--select 'DEBUG ' + @comment
		END
	--else if(@needticket > @battleticket)
	--	BEGIN
	--		set @nResult_ 	= @RESULT_ERROR_TICKET_LACK
	--		set @comment 	= 'ERROR Ƽ�ϼ����� �����մϴ�.'
	--		--select 'DEBUG ' + @comment
	--	END
	else if(@battleflag != @BATTLE_READY)
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS �Ϸ��߽��ϴ�.(�������� �Ϸ� �н���)'
			--select 'DEBUG ' + @comment
		END
	else if(@result = -444)
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS �Ϸ��߽��ϴ�.(�ΰ� ��� �Ϸ� �н���)'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS �Ϸ��߽��ϴ�.'
			--select 'DEBUG ' + @comment


			if( @result_ = @BATTLE_RESULT_WIN )
				begin
					-- �ٱ⼼��1 ~ 4.
					set @rand  	= Convert(int, ceiling(RAND() * 100))
					set @reward1= dbo.fnu_GetRandomStemTwo(@ITEM_SUBCATEGORY_STEMCELL, @rand, 90, @rd1, @rd1 - 10)

					set @rand  	= Convert(int, ceiling(RAND() * 100))
					set @reward2= dbo.fnu_GetRandomStemTwo(@ITEM_SUBCATEGORY_STEMCELL, @rand, 90, @rd2, @rd2 - 10)

					set @rand  	= Convert(int, ceiling(RAND() * 100))
					set @reward3= dbo.fnu_GetRandomStemTwo(@ITEM_SUBCATEGORY_STEMCELL, @rand, 90, @rd3, @rd3 - 10)

					set @rand  	= Convert(int, ceiling(RAND() * 100))
					set @reward4= dbo.fnu_GetRandomStemTwo(@ITEM_SUBCATEGORY_STEMCELL, @rand, 95, @rd4, @rd4 - 10)
					--select 'DEBUG (��)', @reward1 reward1, @reward2 reward2, @reward3 reward3, @reward4 reward4

					set @rand  	= Convert(int, ceiling(RAND() * 10000))
					--select 'DEBUG0 (��)', @tradestate tradestate, @rand rand
					set @rand = dbo.fun_GetDealerStateValue( 12,  @tradestate, @rand ) -- �����Ʋ ��������(12)
					--select 'DEBUG0 (��)', @tradestate tradestate, @rand rand
					--select 'DEBUG ', @rand rand
					if( @rand > 9300 )
						begin
							set @cnt 		= 4
							set @reward1 	= @reward1
							set @reward2 	= @reward2
							set @reward3 	= @reward3
							set @reward4 	= @reward4
						end
					else if( @rand > 8300 )
						begin
							set @cnt 		= 3
							set @reward1 	= @reward1
							set @reward2 	= @reward2
							set @reward3 	= @reward3
							set @reward4 	= -1
						end
					else if( @rand > 3000 )
						begin
							set @cnt 		= 2
							set @reward1 	= @reward1
							set @reward2 	= @reward2
							set @reward3 	= -1
							set @reward4 	= -1
						end
					else
						begin
							set @cnt 		= 1
							set @reward1 	= @reward1
							set @reward2 	= -1
							set @reward3 	= -1
							set @reward4 	= -1
						end
					--select 'DEBUG (��)', @reward1 reward1, @reward2 reward2, @reward3 reward3, @reward4 reward4

					-- Ȳ��Ƽ��.
					set @rand  	= Convert(int, ceiling(RAND() * 10000))
					if( @rdgoldticket = 1 and @cnt <= 2 and @goldticket < @goldticketmax and @rand > 7000)
						begin
							set @rewardgoldticket = @GOLDTICKET_ITEMCODE
						end
					--select 'DEBUG ', @rewardgoldticket rewardgoldticket

					-- ����.
					set @rewardgamecost = @rdgamecost + @rdgamecost * (10 + Convert(int, ceiling(RAND() * 20))) / 100
					--select 'DEBUG0 (��)', @tradestate tradestate, @rdgamecost rdgamecost, @rewardgamecost rewardgamecost
					set @rewardgamecost = dbo.fun_GetDealerStateValue( 11,  @tradestate, @rewardgamecost ) -- �����Ʋ ����(11)
					--select 'DEBUG0 (��)', @tradestate tradestate, @rdgamecost rdgamecost, @rewardgamecost rewardgamecost

					--------------------------------------------------
					---- �ش��� -> ����
					--------------------------------------------------
					--exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT,  @reward1, 1, @sendid, @gameid_, ''
					--exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT,  @reward2, 1, @sendid, @gameid_, ''
					--exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT,  @reward3, 1, @sendid, @gameid_, ''
					--exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT,  @reward4, 1, @sendid, @gameid_, ''
					------------------------------------------------
					-- �ش��� -> ����
					------------------------------------------------
					exec spu_SetDirectItem @gameid_, @reward1, 1, @nResult_ = @listidx1 OUTPUT
					exec spu_SetDirectItem @gameid_, @reward2, 1, @nResult_ = @listidx2 OUTPUT
					exec spu_SetDirectItem @gameid_, @reward3, 1, @nResult_ = @listidx3 OUTPUT
					exec spu_SetDirectItem @gameid_, @reward4, 1, @nResult_ = @listidx4 OUTPUT
					if( @rewardgoldticket = @GOLDTICKET_ITEMCODE )
						begin
							set @goldticket = @goldticket + 1
						end
					set @gamecost = @gamecost + @rewardgamecost


					------------------------------------------------
					-- ��Ÿó�����ֱ�.
					------------------------------------------------
					update dbo.tUserFarm
						set
							playcnt = playcnt - 1,
							@star 	= @star + case when ( @star_ > star ) then @star_ - star else    0 end,
							star 	=         case when ( @star_ > star ) then @star_        else star end
					where gameid = @gameid_ and itemcode = @farmidx
					--select 'DEBUG ���彺Ÿ', @farmidx farmidx, @star_ star_, @star star

					---------------------------------------------
					-- ��ƲƼ�� ��뷮 ����.
					---------------------------------------------
					--set @battleticket = @battleticket - @needticket

					------------------------------------------------
					-- ��ŷ���� ��������.
					------------------------------------------------
					exec spu_subRankDaJun @gameid_, 0, 0, 1, 0, 0, 0, 0		-- ��Ʋ ����Ʈ
				end
			--else
			--	begin
			--		-- ���г� ����� ����
			--		--set @rewardgamecost = 0
			--	end

			----------------------------------
			-- ������������.
			----------------------------------

			update dbo.tUserMaster
				set
					star			= @star,
					bkbattlecnt		= bkbattlecnt + case when ( @result_ = @BATTLE_RESULT_WIN ) then 1 else 0 end,
					bgbattlecnt	= bgbattlecnt + case when ( @result_ = @BATTLE_RESULT_WIN ) then 1 else 0 end,
					goldticket		= @goldticket,
					goldtickettime	= @goldtickettime,
					battleticket	= @battleticket,
					battletickettime= @battletickettime,
					battleflag		= @BATTLE_END,
					gamecost		= @gamecost
			where gameid = @gameid_

			----------------------------------
			-- �ΰ� ��������
			----------------------------------
			update dbo.tBattleLog
				set
					result 		= @result_,		playtime	= @playtime_,
					reward1		= @reward1,		reward2		= @reward2,		reward3		= @reward3,
					reward4		= @reward4,		reward5		= @rewardgoldticket,
					rewardgamecost = @rewardgamecost,
					star		= @star_
			where gameid = @gameid_ and idx2 = @battleidx2_


		END


	------------------------------------------------
	--	4-2. ��������
	------------------------------------------------
	set nocount off

	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost, @heart heart, @feed feed, @fpoint fpoint, @goldticket goldticket, @battleticket battleticket, @goldtickettime goldtickettime, @battletickettime battletickettime, @goldticketmax goldticketmax, @battleticketmax battleticketmax, @reward1 reward1, @reward2 reward2, @reward3 reward3, @reward4 reward4, @rewardgoldticket rewardgoldticket, @rewardgamecost rewardgamecost, @star star
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			--------------------------------------------------------------
			-- ���� ���� ������ ���� > ���� ȹ���� �͸� ����(������ �ϰ� ���� ������ Ŭ����� �����͸� �������� ������)
			--------------------------------------------------------------
			select * from dbo.tUserItem
			where gameid = @gameid_ and listidx in (@listidx1, @listidx2, @listidx3, @listidx4)

			--------------------------------------------------------------
			-- ����/���� ����Ʈ ����
			--------------------------------------------------------------
			--exec spu_GiftList @gameid_
		end
End

