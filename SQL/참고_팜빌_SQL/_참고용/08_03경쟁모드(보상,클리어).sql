/*
-- update dbo.tFVItemInfo set param8 = 90373 where category = 901 and itemcode = 90372
--paraminfo=param0:value0;param1:value1;
delete from dbo.tFVComReward where gameid = 'xxxx2'
delete from dbo.tFVGiftList where gameid = 'xxxx2'
update dbo.tFVUserMaster set comreward = 90100, gamecost = 0, cashcost = 0, feed = 0, heart = 0, fpoint = 0 where gameid = 'xxxx2'
update dbo.tFVUserMaster set bktwolfkillcnt = 1, bktsalecoin = 2, bkheart= 3, bkfeed = 4, bktsuccesscnt = 5, bktbestfresh = 6, bktbestbarrel = 7, bktbestcoin = 8, bkbarrel = 9, bkcrossnormal = 10, bkcrosspremium = 11 where gameid = 'xxxx2'
exec spu_FVComReward 'xxxx2', '049000s1i0n7t8445289',    -1, '0:0;1:1;', -1, -1	-- �ܼ��ʱ�ȭ.
exec spu_FVComReward 'xxxx2', '049000s1i0n7t8445289', 90100, '0:1;1:2;', -1, -1	-- ���� > �������� �ڵ�����.
exec spu_FVComReward 'xxxx2', '049000s1i0n7t8445289', 90101, '0:0;1:1;', -1, -1	-- ĳ��
exec spu_FVComReward 'xxxx2', '049000s1i0n7t8445289', 90102, '0:0;1:1;', -1, -1	-- ��Ʈ
exec spu_FVComReward 'xxxx2', '049000s1i0n7t8445289', 90103, '0:0;1:1;', -1, -1	-- ����
exec spu_FVComReward 'xxxx2', '049000s1i0n7t8445289', 90104, '0:0;1:1;', -1, -1	-- ��������Ʈ
exec spu_FVComReward 'xxxx2', '049000s1i0n7t8445289', 90105, '0:0;1:1;', -1, -1	-- �������ڵ�
exec spu_FVComReward 'xxxx2', '049000s1i0n7t8445289', 90106, '0:0;1:1;', -1, -1	--
exec spu_FVComReward 'xxxx2', '049000s1i0n7t8445289', 90107, '0:0;1:1;', -1, -1	--
exec spu_FVComReward 'xxxx2', '049000s1i0n7t8445289', 90108, '0:0;1:1;', -1, -1	--
exec spu_FVComReward 'xxxx2', '049000s1i0n7t8445289', 90109, '0:0;1:1;', -1, -1	--

exec spu_FVComReward 'xxxx2', '049000s1i0n7t8445289',    -1, '0:0;1:1;',  1, -1	-- �ܼ��ʱ�ȭ.
exec spu_FVComReward 'xxxx2', '049000s1i0n7t8445289', 90100, '0:1;1:2;',  1, -1	-- ���� > �������� �ڵ�����.
exec spu_FVComReward 'xxxx2', '049000s1i0n7t8445289', 90101, '0:0;1:1;',  1, -1	-- ĳ��
exec spu_FVComReward 'xxxx2', '049000s1i0n7t8445289', 90102, '0:0;1:1;',  1, -1	-- ��Ʈ
exec spu_FVComReward 'xxxx2', '049000s1i0n7t8445289', 90103, '0:0;1:1;',  1, -1	-- ����
exec spu_FVComReward 'xxxx2', '049000s1i0n7t8445289', 90104, '0:0;1:1;',  1, -1	-- ��������Ʈ
exec spu_FVComReward 'xxxx2', '049000s1i0n7t8445289', 90105, '0:0;1:1;',  1, -1	-- �������ڵ�
exec spu_FVComReward 'xxxx2', '049000s1i0n7t8445289', 90106, '0:0;1:1;',  1, -1	--
exec spu_FVComReward 'xxxx2', '049000s1i0n7t8445289', 90107, '0:0;1:1;',  1, -1	--
exec spu_FVComReward 'xxxx2', '049000s1i0n7t8445289', 90108, '0:0;1:1;',  1, -1	--
exec spu_FVComReward 'xxxx2', '049000s1i0n7t8445289', 90109, '0:0;1:1;',  1, -1	--


delete from dbo.tFVComReward where gameid = 'xxxx2'
delete from dbo.tFVGiftList where gameid = 'xxxx2'
update dbo.tFVUserMaster set comreward = 90378, gamecost = 0, cashcost = 0, feed = 0, heart = 0, fpoint = 0 where gameid = 'xxxx2'
update dbo.tFVUserMaster set bktwolfkillcnt = 1, bktsalecoin = 2, bkheart= 3, bkfeed = 4, bktsuccesscnt = 5, bktbestfresh = 6, bktbestbarrel = 7, bktbestcoin = 8, bkbarrel = 9, bkcrossnormal = 10, bkcrosspremium = 11 where gameid = 'xxxx2'
exec spu_FVComReward 'xxxx2', '049000s1i0n7t8445289', 90378, '0:0;1:1;', -1, -1	-- �����������(1) > �ְ�ż��� Ŭ����(15)	����
exec spu_FVComReward 'xxxx2', '049000s1i0n7t8445289', 90379, '0:0;1:1;', -1, -1	-- �ְ�ż���(15)  > �����Ǹűݾ�(11)

exec spu_FVComReward 'xxxx2', '049000s1i0n7t8445289', 90378, '0:0;1:1;',  1, -1	-- �����������(1) > �ְ�ż��� Ŭ����(15)	�н�
exec spu_FVComReward 'xxxx2', '049000s1i0n7t8445289', 90379, '0:0;1:1;',  1, -1	-- �ְ�ż���(15)  > �����Ǹűݾ�(11)
*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVComReward', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVComReward;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_FVComReward
	@gameid_								varchar(60),
	@password_								varchar(20),
	@comreward_								int,
	@paraminfo_								varchar(1024),
	@ispass_								int,
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
	--declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--������ > �˾�ó���� ��Ʈ�η� ��������.
	--declare @RESULT_ERROR_DELETED_USER 		int				set @RESULT_ERROR_DELETED_USER			= -12			--�������� > �˾�ó���� ��Ʈ�η� ��������.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--�ش������� ã�� ����
	--declare @RESULT_ERROR_NOT_FOUND_PASSWORD	int				set @RESULT_ERROR_NOT_FOUND_PASSWORD	= -17
	--declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--������ �����ϰ� �ִ�.
	--declare @RESULT_NEWVERION_CLIENT_DOWNLOAD int				set @RESULT_NEWVERION_CLIENT_DOWNLOAD	= -15			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ��ũó��.
	--declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ����.

	-- ���� �ڵ尪
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- �������ڵ��ã��
	--declare @RESULT_ERROR_GIFTITEM_NOT_FOUND	int				set @RESULT_ERROR_GIFTITEM_NOT_FOUND	= -51			-- ������������ ��ã��
	--declare @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	int			set @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	= -52			-- ������ �̹� ������
	--declare @RESULT_ERROR_NOT_FOUND_GIFTID	int				set @RESULT_ERROR_NOT_FOUND_GIFTID		= -75			-- ĳ�� > ������ ���̵� ��ã��

	-- ��Ÿ����
	--declare @RESULT_ERROR_RESULT_COPY			int				set @RESULT_ERROR_RESULT_COPY			= -53			-- ���ī�ǽõ�
	--declare @RESULT_ERROR_GAMECOST_COPY		int				set @RESULT_ERROR_GAMECOST_COPY			= -54			-- �ǹ�ī�ǽõ�
	--declare @RESULT_ERROR_NOT_SUPPORT_MODE	int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- ���������ʴ¸��
	--declare @RESULT_ERROR_HEART_FULL			int				set @RESULT_ERROR_HEART_FULL			= -71			-- ���������ʴ¸��
	declare @RESULT_ERROR_TUTORIAL_ALREADY		int				set @RESULT_ERROR_TUTORIAL_ALREADY		= -73			-- ���丮�� �̹� ����.
	--declare @RESULT_ERROR_NOT_FOUND_OTHERID	int				set @RESULT_ERROR_NOT_FOUND_OTHERID		= -83
	--declare @RESULT_ERROR_INVEN_FULL			int				set @RESULT_ERROR_INVEN_FULL			= -101			-- �κ�����
	--declare @RESULT_ERROR_DAILY_REWARD_ALREADY	int			set @RESULT_ERROR_DAILY_REWARD_ALREADY	= -102			-- ���Ϻ��� �̹� ����.
	--declare @RESULT_ERROR_NOT_FOUND_DOGAMIDX	int				set @RESULT_ERROR_NOT_FOUND_DOGAMIDX	= -103			-- ������ȣ�� ã���� ����.
	--declare @RESULT_ERROR_DOGAM_ALREADY_REWARD	int			set @RESULT_ERROR_DOGAM_ALREADY_REWARD	= -104			-- ������ �̹� ��������.
	--declare @RESULT_ERROR_DOGAM_LACK			int				set @RESULT_ERROR_DOGAM_LACK			= -105			-- �����߿� ������ȣ�� ������.
	------------------------------------------------
	--	2-2. ���°�
	------------------------------------------------
	-- ����ó�ڵ�
	--declare @MARKET_SKT						int					set @MARKET_SKT						= 1
	--declare @MARKET_KT						int					set @MARKET_KT						= 2
	--declare @MARKET_LGT						int					set @MARKET_LGT						= 3
	--declare @MARKET_GOOGLE					int					set @MARKET_GOOGLE					= 5
	--declare @MARKET_NHN						int					set @MARKET_NHN						= 6
	declare @MARKET_IPHONE						int					set @MARKET_IPHONE					= 7

	-- ������ �Һз�
	declare @ITEM_SUBCATEGORY_COMPETITION		int					set @ITEM_SUBCATEGORY_COMPETITION 			= 901 	--������(901)

	-- ���� ���ǰ�
	--declare @GIFTLIST_GIFT_KIND_MESSAGE		int					set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2
	--declare @GIFTLIST_GIFT_KIND_MESSAGE_DEL	int					set @GIFTLIST_GIFT_KIND_MESSAGE_DEL			= -1
	--declare @GIFTLIST_GIFT_KIND_GIFT_DEL		int					set @GIFTLIST_GIFT_KIND_GIFT_DEL			= -2
	--declare @GIFTLIST_GIFT_KIND_GIFT_GET		int					set @GIFTLIST_GIFT_KIND_GIFT_GET			= -3
	--declare @GIFTLIST_GIFT_KIND_GIFT_SELL		int					set @GIFTLIST_GIFT_KIND_GIFT_SELL			= -4

	-- ������ ���ǰ�.
	declare @BKT_WOLF_KILL_CNT					int					set @BKT_WOLF_KILL_CNT						= 1		-- ������������(1)
	declare @BKT_SALE_COIN						int                 set @BKT_SALE_COIN							= 11	-- �����Ǹűݾ�(11)
	declare @BKT_HEART 							int                 set @BKT_HEART 								= 12	-- ������Ʈȹ��(12)
	declare @BKT_FEED 							int                 set @BKT_FEED 								= 13	-- ��������ȹ��(13)
	declare @BKT_SUCCESS_CNT 					int                 set @BKT_SUCCESS_CNT 						= 14	-- �ְ�ŷ�����Ƚ��(14)
	declare @BKT_BEST_FRESH 					int                 set @BKT_BEST_FRESH 						= 15	-- �ְ�ż���(15)
	declare @BKT_BEST_BARREL 					int                 set @BKT_BEST_BARREL 						= 16	-- �ְ�跲(16)
	declare @BKT_BEST 							int                 set @BKT_BEST 								= 17	-- �ְ��Ǹűݾ�(17)
	declare @BKT_BARREL							int                 set @BKT_BARREL								= 18	-- �����跲(18)
	declare @BKT_CROSS_NORMAL 					int                 set @BKT_CROSS_NORMAL 						= 21	-- �����Ϲݱ���(21)
	declare @BKT_CROSS_PREMIUM 					int                 set @BKT_CROSS_PREMIUM 						= 22	-- ���������̾�����(22)

	-- bool
	declare @BOOL_TRUE							int					set @BOOL_TRUE								= 1
	declare @BOOL_FALSE							int					set @BOOL_FALSE								= 0

	declare @INIT_VALUE							int					set @INIT_VALUE								= -555
	declare @USER_LIST_MAX						int					set @USER_LIST_MAX 							= 50

	-- ��������Ʈ
	declare @COMREWARD_CHECK_POINT				int					set @COMREWARD_CHECK_POINT					= 90372
	declare @COMREWARD_NEW_NEXT					int					set @COMREWARD_NEW_NEXT						= 90373
	declare @COMREWARD_OLD_NEXT					int					set @COMREWARD_OLD_NEXT	 					= 90152
	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @gameid 				varchar(60)			set @gameid			= ''
	declare @cashcost				int					set @cashcost			= 0
	declare @gamecost				int					set @gamecost			= 0
	declare @feed					int					set @feed				= 0
	declare @heart					int					set @heart				= 0
	declare @fpoint					int					set @fpoint				= 0
	declare @comreward				int					set @comreward			= -1
	declare @market					int					set @market				= @MARKET_IPHONE

	declare @gameyear				int					set @gameyear			= -1
	declare @gamemonth				int					set @gamemonth			= -1
	declare @famelv					int					set @famelv				= -1

	declare @rewardkind				int					set @rewardkind 		= -1
	declare @rewardvalue			int					set @rewardvalue		= 0
	declare @brewardwrite			int					set @brewardwrite		= @BOOL_TRUE

	declare @nextcomreward			int					set @nextcomreward		= -1
	declare @nextinitpart1			int					set @nextinitpart1		= 0
	declare @nextinitpart2			int					set @nextinitpart2		= 0
	declare @brecord				int					set @brecord			= -1
	declare @part1					int					set @part1				= -1
	declare @part2					int					set @part2				= -1

	declare @kind				int,
			@info				int,
											@param20			int,
											@param21			int,
											@param22			int,
											@param23			int,
											@param24			int,
											@param25			int,
											@param26			int,
											@param27			int,
											@param28			int,
											@param29			int
	declare @comment				varchar(512)
	declare @idx2				int			set @idx2 			= 0
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG �Է�����', @gameid_ gameid_, @password_ password_, @comreward_ comreward_

	------------------------------------------------
	--	3-2. �������(��������)
	------------------------------------------------
	select
		@gameid 		= gameid,
		@cashcost		= cashcost,
		@gamecost		= gamecost,
		@heart			= heart,
		@feed			= feed,
		@fpoint			= fpoint,
		@comreward		= comreward,
		@market			= market,

		@gameyear 		= gameyear,
		@gamemonth 		= gamemonth,
		@famelv 		= famelv
	from dbo.tFVUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG ��������', @gameid gameid, @cashcost cashcost, @gamecost gamecost, @heart heart, @feed feed, @fpoint fpoint, @comreward comreward, @gameyear gameyear, @gamemonth gamemonth, @famelv famelv

	------------------------------------------------
	--	3-2. ȹ�渮��Ʈ�� ���� ������ ��ġ�����ľ�.
	-- 		 > �����ۿ� ���翩�� �ľ��ϱ�.
	------------------------------------------------
	select
		@rewardkind 	= param1,
		@rewardvalue 	= param2,
		@nextcomreward	= param8,
		@nextinitpart1	= param9,
		@nextinitpart2	= param10
	from dbo.tFVItemInfo
	where itemcode = @comreward_ and subcategory = @ITEM_SUBCATEGORY_COMPETITION
	--select 'DEBUG ������ ������', @rewardkind rewardkind, @rewardvalue rewardvalue, @nextcomreward nextcomreward, @nextinitpart1 nextinitpart1, @nextinitpart2 nextinitpart2

	------------------------------------------
	-- @@@@ ���ͱ���
	-- iphone�� ����Ʈ ������ ������.
	------------------------------------------
	if(@market in (@MARKET_IPHONE) and @comreward_ = @COMREWARD_CHECK_POINT and @nextcomreward = @COMREWARD_NEW_NEXT)
		begin
			set @nextcomreward = @COMREWARD_OLD_NEXT
		end

	------------------------------------------------
	--	����üŷ
	------------------------------------------------
	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '���̵� �������� �ʴ´�.'
			--select 'DEBUG ', @comment
		END
	else if(@comreward_ != -1 and exists(select top 1 * from dbo.tFVComReward where gameid = @gameid_ and itemcode = @comreward_))
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_TUTORIAL_ALREADY
			set @comment 	= 'DEBUG �̹� �����ߴ�.'
			--select 'DEBUG ', @comment
		END
	else if(@comreward_ != -1 and (@rewardkind = -1 or @comreward != @comreward_))
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_ITEMCODE
			set @comment 	= '������ ��ȣ�� ������Ѵ�.'
			--select 'DEBUG ', @comment
		END
	else if(@ispass_ = 1)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'DEBUG ������ �н��մϴ�.'
			--select 'DEBUG ', @comment

			if(@comreward_ = -1)
				begin
					set @brewardwrite 	= @BOOL_FALSE
				end
			else
				begin
					set @brewardwrite 	= @BOOL_TRUE
				end
			set @brecord		= 1
		END
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'DEBUG ���������մϴ�.'
			--select 'DEBUG ', @comment

			--����(0)
			--ĳ��(1)
			--��Ʈ(2)
			--����(3)
			--��������Ʈ(4)
			--�������ڵ�(5)
			if(@comreward_ = -1)
				begin
					set @brewardwrite = @BOOL_FALSE
					--select 'DEBUG �ܼ��ʱ�ȭ����', @rewardvalue
				end
			else if(@rewardkind = 0)
				begin
					set @gamecost = @gamecost + @rewardvalue
					--select 'DEBUG ��������', @rewardvalue
				end
			else if(@rewardkind = 1)
				begin
					set @cashcost = @cashcost + @rewardvalue
					--select 'DEBUG ĳ������', @rewardvalue
				end
			else if(@rewardkind = 2)
				begin
					set @heart = @heart + @rewardvalue
					--select 'DEBUG ��Ʈ����', @rewardvalue
				end
			else if(@rewardkind = 3)
				begin
					set @feed = @feed + @rewardvalue
					--select 'DEBUG ��������', @rewardvalue
				end
			else if(@rewardkind = 4)
				begin
					set @fpoint = @fpoint + @rewardvalue
					--select 'DEBUG ��������Ʈ', @rewardvalue
				end
			else if(@rewardkind = 5)
				begin
					if(exists(select top 1 * from dbo.tFVItemInfo where itemcode = @rewardvalue))
						begin
							exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT, @rewardvalue, 'SysCom', @gameid_, ''				-- Ư�������� ����
						end
					--select 'DEBUG �������ڵ�', @rewardvalue
				end

			set @brecord	= 1
		END

	if(@nResult_ = @RESULT_SUCCESS and @brecord	= 1)
		BEGIN
			--------------------------------------------------------------
			--	���� ���(������ �˻���)
			--------------------------------------------------------------
			if(@brewardwrite = @BOOL_TRUE)
				begin
					select @idx2 = isnull(max(idx2), 1) from dbo.tFVComReward where gameid = @gameid_
					set @idx2 = @idx2 + 1

					insert into dbo.tFVComReward(gameid,   itemcode,           ispass,        gameyear,  gamemonth,  famelv,  idx2)
					values(                   @gameid_, @comreward_, isnull(@ispass_, -1), @gameyear, @gamemonth, @famelv, @idx2)

					delete dbo.tFVComReward where gameid = @gameid_ and idx2 < @idx2 - @USER_LIST_MAX
				end

			--------------------------------------------------------------
			--	������, ��������Ÿ �ʱ�ȭ
			--------------------------------------------------------------
			set @comreward		= case
										when @comreward_ != -1		then 	@nextcomreward
										else 								@comreward
								  end
			set @part1			= @nextinitpart1
			set @part2			= @nextinitpart2
			--select 'DEBUG ', @comreward comreward, @part1 part1, @part2 part2

			----------------------------------------------
			-- �Է�����3-2.(param) >
			-- paraminfo=param0;param1;param2;param3;...
			--       0:0;   1:0;   2:0;   3:0;
			----------------------------------------------
			set @param20 		= @INIT_VALUE
			set @param21 		= @INIT_VALUE
			set @param22 		= @INIT_VALUE
			set @param23 		= @INIT_VALUE
			set @param24 		= @INIT_VALUE
			set @param25 		= @INIT_VALUE
			set @param26 		= @INIT_VALUE
			set @param27 		= @INIT_VALUE
			set @param28 		= @INIT_VALUE
			set @param29 		= @INIT_VALUE

			if(LEN(@paraminfo_) >= 3)
				begin
					-- 1. Ŀ�� ����
					declare curParamInfo Cursor for
					select fieldidx, listidx FROM dbo.fnu_SplitTwo(';', ':', @paraminfo_)

					-- 2. Ŀ������
					open curParamInfo

					-- 3. Ŀ�� ���
					Fetch next from curParamInfo into @kind, @info
					while @@Fetch_status = 0
						Begin
							if(@kind = 0)
								begin
									set @param20 		= @info
								end
							else if(@kind = 1)
								begin
									set @param21 		= @info
								end
							else if(@kind = 2)
								begin
									set @param22 		= @info
								end
							else if(@kind = 3)
								begin
									set @param23 		= @info
								end
							else if(@kind = 4)
								begin
									set @param24 		= @info
								end
							else if(@kind = 5)
								begin
									set @param25 		= @info
								end
							else if(@kind = 6)
								begin
									set @param26 		= @info
								end
							else if(@kind = 7)
								begin
									set @param27 		= @info
								end
							else if(@kind = 8)
								begin
									set @param28 		= @info
								end
							else if(@kind = 9)
								begin
									set @param29 		= @info
								end
							Fetch next from curParamInfo into @kind, @info
						end
					-- 4. Ŀ���ݱ�
					close curParamInfo
					Deallocate curParamInfo
					--select 'DEBUG �Է�����(useinfo)', @param20 param20, @param21 param21, @param22 param22, @param23 param23, @param24 param24, @param25 param25, @param26 param26, @param27 param27, @param28 param28, @param29 param29
				end
		END




	select @nResult_ rtn, @comment comment
	if(@nResult_ = @RESULT_SUCCESS)
		BEGIN
			--------------------------------------------------------------
			--	�������
			--------------------------------------------------------------
			update dbo.tFVUserMaster
				set
					cashcost		= @cashcost,
					gamecost		= @gamecost,
					heart			= @heart,
					feed			= @feed,
					fpoint			= @fpoint,
					comreward		= @comreward,

					-- �Ķ����
					param0			= case when (@param20 != @INIT_VALUE) 			then @param20		else param0			end,
					param1			= case when (@param21 != @INIT_VALUE) 			then @param21		else param1			end,
					param2			= case when (@param22 != @INIT_VALUE) 			then @param22		else param2			end,
					param3			= case when (@param23 != @INIT_VALUE) 			then @param23		else param3			end,
					param4			= case when (@param24 != @INIT_VALUE) 			then @param24		else param4			end,
					param5			= case when (@param25 != @INIT_VALUE) 			then @param25		else param5			end,
					param6			= case when (@param26 != @INIT_VALUE) 			then @param26		else param6			end,
					param7			= case when (@param27 != @INIT_VALUE) 			then @param27		else param7			end,
					param8			= case when (@param28 != @INIT_VALUE) 			then @param28		else param8			end,
					param9			= case when (@param29 != @INIT_VALUE) 			then @param29		else param9			end,

					bktwolfkillcnt	= case when @BKT_WOLF_KILL_CNT 	in (@part1, @part2) 	then 0 					else 	bktwolfkillcnt 	end,
					bktsalecoin		= case when @BKT_SALE_COIN 		in (@part1, @part2) 	then 0 					else 	bktsalecoin	 	end,
					bkheart			= case when @BKT_HEART 			in (@part1, @part2) 	then 0 					else 	bkheart 		end,
					bkfeed			= case when @BKT_FEED 			in (@part1, @part2) 	then 0 					else 	bkfeed 			end,
					bktsuccesscnt	= case when @BKT_SUCCESS_CNT 	in (@part1, @part2) 	then 0 					else 	bktsuccesscnt 	end,
					bktbestfresh	= case when @BKT_BEST_FRESH 	in (@part1, @part2) 	then 0 					else 	bktbestfresh 	end,
					bktbestbarrel	= case when @BKT_BEST_BARREL 	in (@part1, @part2) 	then 0 					else 	bktbestbarrel 	end,
					bktbestcoin		= case when @BKT_BEST 			in (@part1, @part2) 	then 0 					else 	bktbestcoin 	end,
					bkbarrel		= case when @BKT_BARREL 		in (@part1, @part2) 	then 0 					else 	bkbarrel 		end,
					bkcrossnormal	= case when @BKT_CROSS_NORMAL 	in (@part1, @part2) 	then 0 					else 	bkcrossnormal 	end,
					bkcrosspremium	= case when @BKT_CROSS_PREMIUM 	in (@part1, @part2) 	then 0 					else 	bkcrosspremium 	end
			where gameid = @gameid_


			--------------------------------------------------------------
			--	��������.
			--------------------------------------------------------------
			select @rewardkind rewardkind, @rewardvalue rewardvalue,  * from dbo.tFVUserMaster where gameid = @gameid_

			--------------------------------------------------------------
			--	������.
			--------------------------------------------------------------
			exec spu_FVGiftList @gameid_

		END

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off
End



