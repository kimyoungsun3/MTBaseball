/*
-- update dbo.tItemInfo set param8 = 90373 where category = 901 and itemcode = 90372
--paraminfo=param0:value0;param1:value1;
delete from dbo.tComReward where gameid = 'xxxx2'	delete from dbo.tGiftList where gameid = 'xxxx2'
update dbo.tUserMaster set comreward = 90100, gamecost = 0, cashcost = 0, feed = 0, heart = 0, fpoint = 0 where gameid = 'xxxx2'
update dbo.tUserMaster set bktwolfkillcnt = 1, bktsalecoin = 2, bkheart= 3, bkfeed = 4, bktsuccesscnt = 5, bktbestfresh = 6, bktbestbarrel = 7, bktbestcoin = 8, bkbarrel = 9, bkcrossnormal = 10, bkcrosspremium = 11 where gameid = 'xxxx2'
exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289',    -1, '0:0;1:1;', -1, -1	-- �ܼ��ʱ�ȭ.
exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289', 90100, '0:1;1:2;', -1, -1	-- ���� > �������� �ڵ�����.
exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289', 90101, '0:0;1:1;', -1, -1	-- ĳ��
exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289', 90102, '0:0;1:1;', -1, -1	-- ��Ʈ
exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289', 90103, '0:0;1:1;', -1, -1	-- ����
exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289', 90104, '0:0;1:1;', -1, -1	-- ��������Ʈ
exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289', 90105, '0:0;1:1;', -1, -1	-- �������ڵ�
exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289', 90106, '0:0;1:1;', -1, -1	--
exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289', 90107, '0:0;1:1;', -1, -1	--
exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289', 90108, '0:0;1:1;', -1, -1	--
exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289', 90109, '0:0;1:1;', -1, -1	--

exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289',    -1, '0:0;1:1;',  1, -1	-- �ܼ��ʱ�ȭ.
exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289', 90100, '0:1;1:2;',  1, -1	-- ���� > �������� �ڵ�����.
exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289', 90101, '0:0;1:1;',  1, -1	-- ĳ��
exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289', 90102, '0:0;1:1;',  1, -1	-- ��Ʈ
exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289', 90103, '0:0;1:1;',  1, -1	-- ����
exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289', 90104, '0:0;1:1;',  1, -1	-- ��������Ʈ
exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289', 90105, '0:0;1:1;',  1, -1	-- �������ڵ�
exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289', 90106, '0:0;1:1;',  1, -1	--
exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289', 90107, '0:0;1:1;',  1, -1	--
exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289', 90108, '0:0;1:1;',  1, -1	--
exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289', 90109, '0:0;1:1;',  1, -1	--


delete from dbo.tComReward where gameid = 'xxxx2'
delete from dbo.tGiftList where gameid = 'xxxx2'
update dbo.tUserMaster set comreward = 90378, gamecost = 0, cashcost = 0, feed = 0, heart = 0, fpoint = 0 where gameid = 'xxxx2'
update dbo.tUserMaster set bktwolfkillcnt = 1, bktsalecoin = 2, bkheart= 3, bkfeed = 4, bktsuccesscnt = 5, bktbestfresh = 6, bktbestbarrel = 7, bktbestcoin = 8, bkbarrel = 9, bkcrossnormal = 10, bkcrosspremium = 11 where gameid = 'xxxx2'
exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289', 90378, '0:0;1:1;', -1, -1	-- �����������(1) > �ְ�ż��� Ŭ����(15)	����
exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289', 90379, '0:0;1:1;', -1, -1	-- �ְ�ż���(15)  > �����Ǹűݾ�(11)

exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289', 90378, '0:0;1:1;',  1, -1	-- �����������(1) > �ְ�ż��� Ŭ����(15)	�н�
exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289', 90379, '0:0;1:1;',  1, -1	-- �ְ�ż���(15)  > �����Ǹűݾ�(11)


update dbo.tUserMaster set comreward = 90200, version = 109 where gameid = 'xxxx2' 	delete from dbo.tComReward where gameid = 'xxxx2'	delete from dbo.tGiftList where gameid = 'xxxx2'
update dbo.tUserMaster set comreward = 90200, version = 110 where gameid = 'xxxx2' 	delete from dbo.tComReward where gameid = 'xxxx2'	delete from dbo.tGiftList where gameid = 'xxxx2'
exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289', 90200, '0:0;1:1;', -1, -1	-- ��������

update dbo.tUserMaster set comreward = 90221 where gameid = 'xxxx2'
exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289', 90221, '0:0;1:1;', -1, -1

update dbo.tUserMaster set comreward = 90241 where gameid = 'xxxx2'
exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289', 90241, '0:0;1:1;', -1, -1

update dbo.tUserMaster set comreward = 90258 where gameid = 'xxxx2'
exec spu_ComReward 'xxxx2', '049000s1i0n7t8445289', 90258, '0:0;1:1;', -1, -1

*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_ComReward', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_ComReward;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_ComReward
	@gameid_								varchar(20),
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

	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--�ش������� ã�� ����
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- �������ڵ��ã��
	declare @RESULT_ERROR_TUTORIAL_ALREADY		int				set @RESULT_ERROR_TUTORIAL_ALREADY		= -73			-- ���丮�� �̹� ����.
	------------------------------------------------
	--	2-2. ���°�
	------------------------------------------------
	-- ������ �Һз�
	declare @ITEM_SUBCATEGORY_COMPETITION		int					set @ITEM_SUBCATEGORY_COMPETITION 			= 901 	--������(901)

	-- ���� ���ǰ�
	--declare @GIFTLIST_GIFT_KIND_MESSAGE		int					set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2

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

	declare @BKT_TSGRADE1_CNT 					int                 set @BKT_TSGRADE1_CNT 						= 23	--�ӽ��Ϲݺ����̱�(23).
	declare @BKT_TSGRADE2_CNT 					int                 set @BKT_TSGRADE2_CNT 						= 24	--�ӽ����������̱�(24).
	declare @BKT_TSUP_CNT 						int                 set @BKT_TSUP_CNT 							= 25	--�ӽú�����ȭȽ��(25).
	declare @BKT_BATTLE_CNT 					int                 set @BKT_BATTLE_CNT 						= 26	--�ӽù�Ʋ����Ƚ��(26).
	declare @BKT_ANI_UP_CNT						int                 set @BKT_ANI_UP_CNT 						= 27	--�ӽõ�����ȭ(27).
	declare @BKT_APART_ANI						int                 set @BKT_APART_ANI 							= 28	--�ӽõ�������(28).
	declare @BKT_APART_TS						int                 set @BKT_APART_TS 							= 29	--�ӽú�������(29).
	declare @BKT_COMPOSE_CNT					int                 set @BKT_COMPOSE_CNT						= 20	--�ӽõ����ռ�(20).

	-- bool
	declare @BOOL_TRUE							int					set @BOOL_TRUE								= 1
	declare @BOOL_FALSE							int					set @BOOL_FALSE								= 0

	declare @INIT_VALUE							int					set @INIT_VALUE								= -555
	declare @USER_LIST_MAX						int					set @USER_LIST_MAX 							= 50

	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @gameid 				varchar(20)			set @gameid			= ''
	declare @cashcost				int					set @cashcost			= 0
	declare @gamecost				int					set @gamecost			= 0
	declare @feed					int					set @feed				= 0
	declare @heart					int					set @heart				= 0
	declare @fpoint					int					set @fpoint				= 0
	declare @comreward				int					set @comreward			= -1
	declare @version				int					set @version			= -1

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

	declare @kind					int,
			@info					int,
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
	declare @idx2					int			set @idx2 			= 0
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
		@version 		= version,

		@gameyear 		= gameyear,
		@gamemonth 		= gamemonth,
		@famelv 		= famelv
	from dbo.tUserMaster
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
	from dbo.tItemInfo
	where itemcode = @comreward_ and subcategory = @ITEM_SUBCATEGORY_COMPETITION
	--select 'DEBUG ������ ������', @rewardkind rewardkind, @rewardvalue rewardvalue, @nextcomreward nextcomreward, @nextinitpart1 nextinitpart1, @nextinitpart2 nextinitpart2


	------------------------------------------------
	--	����üŷ
	------------------------------------------------
	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '���̵� �������� �ʴ´�.'
			--select 'DEBUG ', @comment
		END
	else if(@comreward_ != -1 and exists(select top 1 * from dbo.tComReward where gameid = @gameid_ and itemcode = @comreward_))
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
					-------------------------------------------------
					-- ������ ���Ƽ� �߻��� ����.
					-------------------------------------------------
					if( @version <= 109 )
						begin
							--select 'DEBUG ����Ʈ ����ä��(��)', @version version, @comreward_ comreward_, @rewardvalue rewardvalue
							if( @comreward_ = 90200 and @rewardvalue = 104 )
								begin
									set @rewardvalue = 105
									--select 'DEBUG ����Ʈ ����ä�� (��)', @version version, @comreward_ comreward_, @rewardvalue rewardvalue
								end
							else if( @comreward_ = 90241 and @rewardvalue = 205 )
								begin
									set @rewardvalue = 207
									--select 'DEBUG ����Ʈ ����ä�� (��)', @version version, @comreward_ comreward_, @rewardvalue rewardvalue
								end
							else if( @comreward_ = 90258 and @rewardvalue = 206 )
								begin
									set @rewardvalue = 211
									--select 'DEBUG ����Ʈ ����ä�� (��)', @version version, @comreward_ comreward_, @rewardvalue rewardvalue
								end
						end

					-------------------------------------------------
					-- ������ ����.
					-------------------------------------------------
					if(exists(select top 1 * from dbo.tItemInfo where itemcode = @rewardvalue))
						begin
							exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT, @rewardvalue, 0, 'SysCom', @gameid_, ''				-- Ư�������� ����
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
					select @idx2 = isnull(max(idx2), 1) from dbo.tComReward where gameid = @gameid_
					set @idx2 = @idx2 + 1

					insert into dbo.tComReward(gameid,   itemcode,           ispass,        gameyear,  gamemonth,  famelv,  idx2)
					values(                   @gameid_, @comreward_, isnull(@ispass_, -1), @gameyear, @gamemonth, @famelv, @idx2)

					delete dbo.tComReward where gameid = @gameid_ and idx2 < @idx2 - @USER_LIST_MAX
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
			update dbo.tUserMaster
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
					bkcrosspremium	= case when @BKT_CROSS_PREMIUM 	in (@part1, @part2) 	then 0 					else 	bkcrosspremium 	end,

					bktsgrade1cnt	= case when @BKT_TSGRADE1_CNT 	in (@part1, @part2) 	then 0 					else 	bktsgrade1cnt 	end,
					bktsgrade2cnt	= case when @BKT_TSGRADE2_CNT 	in (@part1, @part2) 	then 0 					else 	bktsgrade2cnt 	end,
					bktsupcnt		= case when @BKT_TSUP_CNT 		in (@part1, @part2) 	then 0 					else 	bktsupcnt 		end,
					bkbattlecnt		= case when @BKT_BATTLE_CNT 	in (@part1, @part2) 	then 0 					else 	bkbattlecnt 	end,
					bkaniupcnt		= case when @BKT_ANI_UP_CNT 	in (@part1, @part2) 	then 0 					else 	bkaniupcnt 		end,

					bkapartani		= case when @BKT_APART_ANI	 	in (@part1, @part2) 	then 0 					else 	bkapartani 		end,
					bkapartts		= case when @BKT_APART_TS	 	in (@part1, @part2) 	then 0 					else 	bkapartts 		end,
					bkcomposecnt	= case when @BKT_COMPOSE_CNT 	in (@part1, @part2) 	then 0 					else 	bkcomposecnt 	end


			where gameid = @gameid_


			--------------------------------------------------------------
			--	��������.
			--------------------------------------------------------------
			select @rewardkind rewardkind, @rewardvalue rewardvalue,  * from dbo.tUserMaster where gameid = @gameid_

			--------------------------------------------------------------
			--	������.
			--------------------------------------------------------------
			exec spu_GiftList @gameid_

		END

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off
End



