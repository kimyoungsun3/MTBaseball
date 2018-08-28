use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVRoulBuyTest', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVRoulBuyTest;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_FVRoulBuyTest
	@gameid_								varchar(60),
	@phone_									varchar(20),
	@mode_									int,
	@savedata_								varchar(4096),
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
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--�ش������� ã�� ����
	declare @RESULT_ERROR_ITEM_LACK				int				set @RESULT_ERROR_ITEM_LACK				= -23			--�������̺����ϴ�.
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- �������ڵ��ã��
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- ���������ʴ¸��
	------------------------------------------------
	--	2-2. ���°�
	------------------------------------------------

	-- ���� ���ǰ�
	--declare @GIFTLIST_GIFT_KIND_MESSAGE		int					set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2
	--declare @GIFTLIST_GIFT_KIND_MESSAGE_DEL	int					set @GIFTLIST_GIFT_KIND_MESSAGE_DEL			= -1
	--declare @GIFTLIST_GIFT_KIND_GIFT_DEL		int					set @GIFTLIST_GIFT_KIND_GIFT_DEL			= -2
	--declare @GIFTLIST_GIFT_KIND_GIFT_GET		int					set @GIFTLIST_GIFT_KIND_GIFT_GET			= -3
	--declare @GIFTLIST_GIFT_KIND_GIFT_SELL		int					set @GIFTLIST_GIFT_KIND_GIFT_SELL			= -4

	-- �̱� ���.
	declare @MODE_ROULETTE_GRADE1				int					set @MODE_ROULETTE_GRADE1					= 1		-- �Ϲݻ̱�.
	declare @MODE_ROULETTE_GRADE2				int					set @MODE_ROULETTE_GRADE2					= 2		-- �����̱�.
	declare @MODE_ROULETTE_GRADE3				int					set @MODE_ROULETTE_GRADE3					= 3		--
	declare @MODE_ROULETTE_GRADE4				int					set @MODE_ROULETTE_GRADE4					= 4	   	--
	declare @MODE_ROULETTE_GRADE2_FREE			int					set @MODE_ROULETTE_GRADE2_FREE				= 12	-- �����̱�(����).
	declare @MODE_ROULETTE_GRADE3_FREE			int					set @MODE_ROULETTE_GRADE3_FREE				= 13	--
	declare @MODE_ROULETTE_GRADE4_FREE			int					set @MODE_ROULETTE_GRADE4_FREE				= 14	--

	declare @ITEM_ROULETTE_NOR_MOTHER			int					set @ITEM_ROULETTE_NOR_MOTHER				= 2200	-- �Ϲݻ̱�.
	declare @ITEM_ROULETTE_PRE_MOTHER			int					set @ITEM_ROULETTE_PRE_MOTHER				= 2300	-- �����̾��̱�.

	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @comment				varchar(512)
	declare @comment2				varchar(512)	set @comment2			= ''
	declare @gameid					varchar(60)		set @gameid				= ''
	declare @sendid					varchar(60)		set @sendid				= ''
	declare @ownercashcost			bigint			set @ownercashcost		= 0
	declare @ownercashcost2			bigint			set @ownercashcost2		= 0
	declare @strange				int				set @strange			= -1
	declare @nickname				varchar(40)		set @nickname			= ''
	declare @market					int				set @market				= 1
	declare @randserial				varchar(20)		set @randserial			= ''
	declare @bestani				int
	declare @needcashcost			int				set @needcashcost		= 0
	declare @needgamecost			int				set @needgamecost		= 0
	declare @needheart				int				set @needheart			= 0

	declare @itemcode				int				set @itemcode			= -1
	declare @pack1					int				set @pack1				= -1
	declare @pack2					int				set @pack2				= -1
	declare @pack3					int				set @pack3				= -1
	declare @pack4					int				set @pack4				= -1
	declare @pack5					int				set @pack5				= -1
	declare @pack6					int				set @pack6				= -1
	declare @pack7					int				set @pack7				= -1
	declare @pack8					int				set @pack8				= -1
	declare @pack9					int				set @pack9				= -1
	declare @pack10					int				set @pack10				= -1
	declare @pack11					int				set @pack11				= -1
	declare @pack12					int				set @pack12				= -1
	declare @pack13					int				set @pack13				= -1
	declare @pack14					int				set @pack14				= -1
	declare @pack15					int				set @pack15				= -1
	declare @pack16					int				set @pack16				= -1
	declare @pack17					int				set @pack17				= -1
	declare @pack18					int				set @pack18				= -1
	declare @pack19					int				set @pack19				= -1
	declare @pack20					int				set @pack20				= -1
	declare @pack21					int				set @pack21				= -1
	declare @pack22					int				set @pack22				= -1
	declare @pack23					int				set @pack23				= -1
	declare @pack24					int				set @pack24				= -1
	declare @pack25					int				set @pack25				= -1
	declare @pack26					int				set @pack26				= -1
	declare @pack27					int				set @pack27				= -1
	declare @pack28					int				set @pack28				= -1
	declare @pack29					int				set @pack29				= -1
	declare @pack30					int				set @pack30				= -1
	declare @pack31					int				set @pack31				= -1
	declare @pack32					int				set @pack32				= -1
	declare @pack33					int				set @pack33				= -1
	declare @pack34					int				set @pack34				= -1
	declare @pack35					int				set @pack35				= -1
	declare @pack36					int				set @pack36				= -1
	declare @pack37					int				set @pack37				= -1
	declare @pack38					int				set @pack38				= -1
	declare @pack39					int				set @pack39				= -1
	declare @pack40					int				set @pack40				= -1
	declare @pack41					int				set @pack41				= -1
	declare @pack42					int				set @pack42				= -1
	declare @pack43					int				set @pack43				= -1
	declare @pack44					int				set @pack44				= -1
	declare @pack45					int				set @pack45				= -1
	declare @pack46					int				set @pack46				= -1
	declare @pack47					int				set @pack47				= -1
	declare @pack48					int				set @pack48				= -1
	declare @pack49					int				set @pack49				= -1
	declare @pack50					int				set @pack50				= -1

	declare @roul1					int				set @roul1				= -1
	declare @roul2					int				set @roul2				= -1
	declare @roul3					int				set @roul3				= -1
	declare @roul4					int				set @roul4				= -1
	declare @roul5					int				set @roul5				= -1

	declare @group1			int,	@group2				int,	@group3			int,	@group4		int,	@group5		int,
			@rand			int,	@rand2				int,
			@tsgrade1cnt	int,
			@tsgrade2cnt	int,	@tsgrade2gauage		int,	@tsgrade2free	int,
			@tsgrade3cnt	int,	@tsgrade3gauage		int,	@tsgrade3free	int,
			@tsgrade4cnt	int,	@tsgrade4gauage		int,	@tsgrade4free	int,
			@cnt			int

	declare @curdate				datetime		set @curdate		= getdate()
	declare @curhour				int				set @curhour			= -1

	-- ��������.
	declare @roulsaleflag			int				set @roulsaleflag		= -1
	declare @roulsalevalue			int				set @roulsalevalue		=  0

	-- ��������(������).
	declare @checktreasure			int				set @checktreasure		= -1
	declare @checkreward			int				set @checkreward		= -1
	declare @checkrewardcnt			int				set @checkrewardcnt		= -1

	-- ��������.
	declare @roulrewardflag			int				set @roulrewardflag		= -1
	declare @roulani1				int				set @roulani1			= -1
	declare @roulani2				int				set @roulani2			= -1
	declare @roulani3				int				set @roulani3			= -1
	declare @roulreward1			int				set @roulreward1		= -1
	declare @roulreward2			int				set @roulreward2		= -1
	declare @roulreward3			int				set @roulreward3		= -1
	declare @roulrewardcnt1			int				set @roulrewardcnt1		=  0
	declare @roulrewardcnt2			int				set @roulrewardcnt2		=  0
	declare @roulrewardcnt3			int				set @roulrewardcnt3		=  0
	declare @roulname1				varchar(20)		set @roulname1			= ''
	declare @roulname2				varchar(20)		set @roulname2			= ''
	declare @roulname3				varchar(20)		set @roulname3			= ''

	-- ����Ȯ�����.
	declare @roultimeflag			int				set @roultimeflag		= -1
	declare @roultimetime1			int				set @roultimetime1		= -1
	declare @roultimetime2			int				set @roultimetime2		= -1
	declare @roultimetime3			int				set @roultimetime3		= -1

	-- ��������̱�.
	declare @tsgauageflag			int				set @tsgauageflag			= -1
	declare @PMGAUAGEPOINT			int				set @PMGAUAGEPOINT			= 10
	declare @PMGAUAGEMAX			int				set @PMGAUAGEMAX			= 100
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG �Է�����', @gameid_ gameid_, @password_ password_, @mode_ mode_, @randserial_ randserial_

	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	select
		@gameid 		= gameid,		@nickname 		= nickname,		@market			= market,		@bestani		= bestani,
		@ownercashcost	= ownercashcost,
		@roul1			= bgroul1,		@roul2			= bgroul2,		@roul3			= bgroul3, 		@roul4			= bgroul4,		@roul5			= bgroul5,
		@tsgrade1cnt	= tsgrade1cnt,	@tsgrade2cnt	= tsgrade2cnt,	@tsgrade3cnt	= tsgrade3cnt,	@tsgrade4cnt	= tsgrade4cnt,
										@tsgrade2gauage	= tsgrade2gauage,@tsgrade3gauage= tsgrade3gauage,@tsgrade4gauage= tsgrade4gauage,
										@tsgrade2free	= tsgrade2free,	@tsgrade3free	= tsgrade3free,	@tsgrade4free	= tsgrade4free,
		@randserial		= randserial
	from dbo.tFVUserMaster
	where gameid = @gameid_ and phone = @phone_
	--select 'DEBUG ��������', @gameid gameid, @nickname nickname, @market market, @bestani bestani, @randserial randserial, @roul1 roul1, @roul2 roul2, @roul3 roul3, @roul4 roul4, @roul5 roul5, @tsgrade1cnt tsgrade1cnt, @tsgrade2cnt tsgrade2cnt, @tsgrade3cnt tsgrade3cnt, @tsgrade4cnt tsgrade4cnt, @tsgrade2gauage	tsgrade2gauage, @tsgrade3gauage tsgrade3gauage, @tsgrade4gauage tsgrade4gauage, @tsgrade2free tsgrade2free,	@tsgrade3free tsgrade3free,	@tsgrade4free tsgrade4free

	------------------------------------------------
	-- �̱� �̺�Ʈ ���� ��������.
	------------------------------------------------
	select
		top 1
		-- ��������
		@roulsaleflag	= case when (@curdate > roulstart and @curdate <= roulend) then roulsaleflag	else -1 end,
		@roulsalevalue	= case when @roulsaleflag = -1 then 0 else roulsalevalue end,

		-- �������� 	> ������ ������ ��������
		@roulrewardflag = case when (@curdate > roulstart and @curdate <= roulend) then roulflag 		else -1 end,
		@roulani1		= roulani1,			@roulani2		= roulani2,			@roulani3		= roulani3,
		@roulreward1	= roulreward1,		@roulreward2	= roulreward2,		@roulreward3	= roulreward3,
		@roulrewardcnt1	= roulrewardcnt1,	@roulrewardcnt2	= roulrewardcnt2,	@roulrewardcnt3	= roulrewardcnt3,
		@roulname1		= roulname1,		@roulname2		= roulname2,		@roulname3		= roulname3,

		-- ����Ȯ����� > Ư�� �ð��� Ȯ�����.
		@roultimeflag	= case when (@curdate > roulstart and @curdate <= roulend) then roultimeflag 	else -1 end,
		@roultimetime1	= roultimetime1,	@roultimetime2	= roultimetime2,	@roultimetime3	= roultimetime3,

		-- ��������̱�	> �̱� xȸ�Ŀ� 1ȸ ����.
		@tsgauageflag	= case when (@curdate > roulstart and @curdate <= roulend) then pmgauageflag 	else -1 end,
		@PMGAUAGEPOINT	= pmgauagepoint,
		@PMGAUAGEMAX	= pmgauagemax
	from dbo.tFVSystemRouletteMan
	where roulmarket = @market
	order by idx desc
	--select 'DEBUG ', @roulrewardflag roulrewardflag, @roultimeflag roultimeflag, @tsgauageflag tsgauageflag

	----------------------------------------
	-- �̱�����.
	----------------------------------------
	select
		top 1
		@itemcode = itemcode,
		@pack1 = pack1,		@pack2 = pack2,		@pack3 = pack3, 	@pack4 = pack4,		@pack5 = pack5,
		@pack6 = pack6,		@pack7= pack7,		@pack8 = pack8, 	@pack9 = pack9,		@pack10 = pack10,

		@pack11 = pack11,	@pack12 = pack12,	@pack13 = pack13, 	@pack14 = pack14,	@pack15 = pack15,
		@pack16 = pack16,	@pack17= pack17,	@pack18 = pack18, 	@pack19 = pack19,	@pack20 = pack20,

		@pack21 = pack21,	@pack22 = pack22,	@pack23 = pack23, 	@pack24 = pack24,	@pack25 = pack25,
		@pack26 = pack26,	@pack27= pack27,	@pack28 = pack28, 	@pack29 = pack29,	@pack30 = pack30,

		@pack31 = pack31,	@pack32 = pack32,	@pack33 = pack33, 	@pack34 = pack34,	@pack35 = pack35,
		@pack36 = pack36,	@pack37= pack37,	@pack38 = pack38, 	@pack39 = pack39,	@pack40 = pack40,

		@pack41 = pack41,	@pack42= pack42,	@pack43 = pack43, 	@pack44 = pack44,	@pack45 = pack45,
		@pack46 = pack46,	@pack47= pack47,	@pack48 = pack48, 	@pack49 = pack49,	@pack50 = pack50
	from dbo.tFVSystemRoulette
	where famelvmin <= @bestani
		  and @bestani <= famelvmax
		  and packstate = 1
		  order by newid()
	--select 'DEBUG �̱�����', @itemcode itemcode, @pack1 pack1, @pack2 pack2, @pack3 pack3, @pack4 pack4, @pack5 pack5, @pack6 pack6, @pack7 pack7, @pack8 pack8, @pack9 pack9, @pack10 pack10, @pack11 pack11, @pack12 pack12, @pack13 pack13, @pack14 pack14, @pack15 pack15, @pack16 pack16, @pack17 pack17, @pack18 pack18, @pack19 pack19, @pack20 pack20, @pack21 pack21, @pack22 pack22, @pack23 pack23, @pack24 pack24, @pack25 pack25, @pack26 pack26, @pack27 pack27, @pack28 pack28, @pack29 pack29, @pack30 pack30, @pack31 pack31, @pack32 pack32, @pack33 pack33, @pack34 pack34, @pack35 pack35, @pack36 pack36, @pack37 pack37, @pack38 pack38, @pack39 pack39, @pack40 pack40, @pack41 pack41, @pack42 pack42, @pack43 pack43, @pack44 pack44, @pack45 pack45, @pack46 pack46, @pack47 pack47, @pack48 pack48, @pack49 pack49, @pack50 pack50

	------------------------------------------------
	--	3-3. ����Ȳ���� �ڵ�� �з�
	------------------------------------------------
	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR ���̵� �������� �ʴ´�.'
			--select 'DEBUG ' + @comment
		END
	else if (@itemcode = -1)
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_ITEMCODE
			set @comment = 'ERROR �ڵ带 ã���� �����ϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if (@mode_ not in (@MODE_ROULETTE_GRADE1, @MODE_ROULETTE_GRADE2, @MODE_ROULETTE_GRADE3, @MODE_ROULETTE_GRADE4, @MODE_ROULETTE_GRADE2_FREE , @MODE_ROULETTE_GRADE3_FREE, @MODE_ROULETTE_GRADE4_FREE))
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment = 'ERROR �������� �ʴ� ����Դϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if ((@mode_ = @MODE_ROULETTE_GRADE2_FREE and @tsgrade2free <= 0)
		 or  (@mode_ = @MODE_ROULETTE_GRADE3_FREE and @tsgrade3free <= 0)
		 or  (@mode_ = @MODE_ROULETTE_GRADE4_FREE and @tsgrade4free <= 0))
		BEGIN
			set @nResult_ = @RESULT_ERROR_ITEM_LACK
			set @comment = 'ERROR �������� �����ϴ�.'
			--select 'DEBUG ' + @comment

			if(@mode_ = @MODE_ROULETTE_GRADE2_FREE)
				begin
					set @comment2 = '�����̾�2 ������ ��������(' + ltrim(rtrim(@tsgrade2free)) + ')'
					--select 'DEBUG **** �̻���', @comment2 comment2
					exec spu_FVSubUnusualRecord2  @gameid_, @comment2
				end
			else if(@mode_ = @MODE_ROULETTE_GRADE3_FREE)
				begin
					set @comment2 = '�����̾�3 ������ ��������(' + ltrim(rtrim(@tsgrade3free)) + ')'
					--select 'DEBUG **** �̻���', @comment2 comment2
					exec spu_FVSubUnusualRecord2  @gameid_, @comment2
				end
			else if(@mode_ = @MODE_ROULETTE_GRADE4_FREE)
				begin
					set @comment2 = '�����̾�4 ������ ��������(' + ltrim(rtrim(@tsgrade4free)) + ')'
					--select 'DEBUG **** �̻���', @comment2 comment2
					exec spu_FVSubUnusualRecord2  @gameid_, @comment2
				end
		END
	else if (@randserial_ = @randserial)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '�̱� �����ϱ�(2)'

			set @ownercashcost2	= @ownercashcost
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '�̱� �����ϱ�(1)'
			--select 'DEBUG ', @comment

			-----------------------------------------------------------------
			-- ���̺� ���� > �ݾ׻���.
			-----------------------------------------------------------------
			set @ownercashcost2 = dbo.fnu_GetFVSaveDataToCashcost(@savedata_)

			------------------------------------------------
			-- ���� ���� �Ϲ�, �����̾� > �����̺�Ʈ.
			------------------------------------------------
			if(@tsgauageflag = 1 and @mode_ in (@MODE_ROULETTE_GRADE2, @MODE_ROULETTE_GRADE3, @MODE_ROULETTE_GRADE4))
				begin
					--select 'DEBUG �����̾� ���� �̺�Ʈ��', @mode_ mode_
					if(@mode_ = @MODE_ROULETTE_GRADE2)
						begin
							if(@tsgrade2gauage < @PMGAUAGEMAX)
								begin
									--select 'DEBUG �����̾�2 ����'
									set @tsgrade2gauage = @tsgrade2gauage + @PMGAUAGEPOINT
								end


							if(@tsgrade2gauage >= @PMGAUAGEMAX)
								begin
									--select 'DEBUG �����̾�2 �������'
									set @tsgrade2gauage = 0
									set @tsgrade2free	= 1
								end
						end
					else if(@mode_ = @MODE_ROULETTE_GRADE3)
						begin
							if(@tsgrade3gauage < @PMGAUAGEMAX)
								begin
									--select 'DEBUG �����̾�3 ����'
									set @tsgrade3gauage = @tsgrade3gauage + @PMGAUAGEPOINT
								end

							if(@tsgrade3gauage >= @PMGAUAGEMAX)
								begin
									--select 'DEBUG �����̾�3 �������'
									set @tsgrade3gauage = 0										-- �Ѳ����� ���������.
									set @tsgrade3free	= 1
								end
						end
					else if(@mode_ = @MODE_ROULETTE_GRADE4)
						begin
							if(@tsgrade4gauage < @PMGAUAGEMAX)
								begin
									--select 'DEBUG �����̾�4 ����'
									set @tsgrade4gauage = @tsgrade4gauage + @PMGAUAGEPOINT
								end

							if(@tsgrade4gauage >= @PMGAUAGEMAX)
								begin
									--select 'DEBUG �����̾�4 �������'
									set @tsgrade4gauage = 0										-- �Ѳ����� ���������.
									set @tsgrade4free	= 1
								end
						end
				end
			else if(@mode_ = @MODE_ROULETTE_GRADE2_FREE)
				begin
					--select 'DEBUG �����̾�2 ������'
					set @tsgrade2free	= 0
				end
			else if(@mode_ = @MODE_ROULETTE_GRADE3_FREE)
				begin
					--select 'DEBUG �����̾�3 ������'
					set @tsgrade3free	= 0
				end
			else if(@mode_ = @MODE_ROULETTE_GRADE4_FREE)
				begin
					--select 'DEBUG �����̾�4 ������'
					set @tsgrade4free	= 0
				end

			-----------------------------------
			-- �ð��� ������.
			-- ��µǴ� ��������.
			-----------------------------------
			set @curhour 	= DATEPART(Hour, getdate())
			set @cnt		= 1
			--select 'DEBUG ', @curhour curhour, @cnt cnt

			--------------------------------
			-- �����ϱ�.
			--------------------------------
			if(@mode_ in (@MODE_ROULETTE_GRADE1))
				begin
					set @group1 	= 9800
					set @group2		=  200
					set @group3		=    0
					set @group4		=    0
					set @group5		=    0
					set @sendid		= 'SysRoul1'
					set @needcashcost	= 0
					set @needgamecost	= 0
					set @needheart		= 100

					--select 'DEBUG �Ϲݻ̱� ����', @group1 group1, @group2 group2, @group3 group3, @group4 group4, @group5 group5, @cnt cnt, @needcashcost needcashcost, @needgamecost needgamecost, @needheart needheart

					-- �ð����� > ����.

					--------------------------------
					-- ���� ��������.
					--------------------------------
					exec spu_FVDayLogInfoStatic @market, 81, 1				-- �� �̱��Ϲ�.
				end
			else if(@mode_ in (@MODE_ROULETTE_GRADE2, @MODE_ROULETTE_GRADE2_FREE))
				begin
					set @group1 	=    0
					set @group2		= 9800
					set @group3		=  200
					set @group4		=    0
					set @group5		=    0
					set @sendid		= 'SysRoul2'
					set @needcashcost	= case when @mode_ = @MODE_ROULETTE_GRADE2 then 2000 else 0 end
					set @needgamecost	= 0
					set @needheart		= 0
					--select 'DEBUG �����̾�2 ', @group1 group1, @group2 group2, @group3 group3, @group4 group4, @group5 group5, @cnt cnt, @needcashcost needcashcost, @needgamecost needgamecost, @needheart needheart

					-- �ð�����.
					if(@curhour in (@roultimetime1, @roultimetime2, @roultimetime3))
						begin
							--select 'DEBUG > ����ð���'
							set @group2		= @group2 - 250
							set @group3		= @group3 + 200
							set @group4		= @group4 +  50
							--select 'DEBUG �̱�Ȯ�� ���', @roultimetime1 roultimetime1, @roultimetime2 roultimetime2, @roultimetime3 roultimetime3
						end

					--------------------------------
					-- ���� ��������.
					--------------------------------
					if(@mode_ = @MODE_ROULETTE_GRADE4)
						begin
							exec spu_FVDayLogInfoStatic @market, 82, 1				-- �� �����̾�2
						end
					else
						begin
							exec spu_FVDayLogInfoStatic @market, 92, 1				-- �� �����̾�2 ����
						end
				end
			else if(@mode_ in (@MODE_ROULETTE_GRADE3, @MODE_ROULETTE_GRADE3_FREE))
				begin
					set @group1 	=    0
					set @group2		=    0
					set @group3		= 9750
					set @group4		=  200
					set @group5		=   50
					set @sendid		= 'SysRoul3'
					set @needcashcost	= case when @mode_ = @MODE_ROULETTE_GRADE3 then 4000 else 0 end
					set @needgamecost	= 0
					set @needheart		= 0
					--select 'DEBUG �����̾�3 ', @group1 group1, @group2 group2, @group3 group3, @group4 group4, @group5 group5, @cnt cnt, @needcashcost needcashcost, @needgamecost needgamecost, @needheart needheart

					-- �ð�����.
					if(@curhour in (@roultimetime1, @roultimetime2, @roultimetime3))
						begin
							--select 'DEBUG > ����ð���'
							set @group3		= @group3 - 250
							set @group4		= @group4 + 200
							set @group5		= @group5 +  50
							--select 'DEBUG �̱�Ȯ�� ���', @roultimetime1 roultimetime1, @roultimetime2 roultimetime2, @roultimetime3 roultimetime3
						end

					--------------------------------
					-- ���� ��������.
					--------------------------------
					if(@mode_ = @MODE_ROULETTE_GRADE4)
						begin
							exec spu_FVDayLogInfoStatic @market, 83, 1				-- �� �����̾�3
						end
					else
						begin
							exec spu_FVDayLogInfoStatic @market, 93, 1				-- �� �����̾�3 ����
						end

				end
			else if(@mode_ in (@MODE_ROULETTE_GRADE4, @MODE_ROULETTE_GRADE4_FREE))
				begin
					set @group1 	=    0
					set @group2		=    0
					set @group3		= 7400
					set @group4		= 2400
					set @group5		=  200
					set @cnt		= 3 + 1
					set @sendid		= 'SysRoul4'
					set @needcashcost	= case when @mode_ = @MODE_ROULETTE_GRADE4 then 12000 else 0 end
					set @needgamecost	= 0
					set @needheart		= 0
					--select 'DEBUG �����̾�4 ', @group1 group1, @group2 group2, @group3 group3, @group4 group4, @group5 group5, @cnt cnt, @needcashcost needcashcost, @needgamecost needgamecost, @needheart needheart

					-- �ð�����.
					if(@curhour in (@roultimetime1, @roultimetime2, @roultimetime3))
						begin
							--select 'DEBUG > ����ð���'
							set @group3		= @group3 - 400
							set @group4		= @group4 + 200
							set @group5		= @group5 + 200
							--select 'DEBUG �̱�Ȯ�� ���', @roultimetime1 roultimetime1, @roultimetime2 roultimetime2, @roultimetime3 roultimetime3
						end

					--------------------------------
					-- ���� ��������.
					--------------------------------
					if(@mode_ = @MODE_ROULETTE_GRADE4)
						begin
							exec spu_FVDayLogInfoStatic @market, 84, 1				-- �� �����̾�4
						end
					else
						begin
							exec spu_FVDayLogInfoStatic @market, 94, 1				-- �� �����̾�4 ����
						end
				end
			--select 'DEBUG ', @group1 group1, @group2 group2, @group3 group3, @group4 group4, @group5 group5

			--------------------------
			---- ���Ź�ȣ.
			----exec spu_FVUserItemBuyLog @gameid_, @ownercashcost2, @itemcode, @needcashcost, @needgamecost, @needheart	-- D, C�̱� X (1)
			----exec spu_FVUserItemBuyLog @gameid_, @ownercashcost2, @itemcode, @needcashcost, @needgamecost, @needheart	-- B, A�̱� X (1)
			----exec spu_FVUserItemBuyLog @gameid_, @ownercashcost2, @itemcode, @needcashcost, @needgamecost, @needheart	-- A, S�̱� X (1)
			----exec spu_FVUserItemBuyLog @gameid_, @ownercashcost2, @itemcode, @needcashcost, @needgamecost, @needheart	-- A, S�̱� X (3 + 1)
			--------------------------
			----select 'DEBUG(��)', @needcashcost needcashcost, @needgamecost needgamecost, @needheart needheart
			--if(@roulsaleflag = 1 and @roulsalevalue > 0 and @roulsalevalue <= 100)
			--	begin
			--		set @needcashcost 	= @needcashcost - @needcashcost * @roulsalevalue / 100
			--		set @needgamecost 	= @needgamecost - @needgamecost * @roulsalevalue / 100
			--		set @needheart 		= @needheart - @needheart * @roulsalevalue / 100
			--	end
			----select 'DEBUG(��)', @needcashcost needcashcost, @needgamecost needgamecost, @needheart needheart
			--exec spu_FVUserItemBuyLog @gameid_, @ownercashcost2, @itemcode, @needcashcost, @needgamecost, @needheart


			------------------------------------
			-- ������ ���� �Ѱ��� ����
			------------------------------------
			set @rand 		= Convert(int, ceiling(RAND() * 10000))
			set @rand2		= Convert(int, ceiling(RAND() *    10))
			set @roul1 		= dbo.fnu_FVGetCrossRandom(@rand, @rand2, 	@group1, @group2, @group3, @group4, @group5,    @pack1,  @pack2,  @pack3,  @pack4,  @pack5,  @pack6,  @pack7,  @pack8,  @pack9, @pack10,
																														@pack11, @pack12, @pack13, @pack14, @pack15, @pack16, @pack17, @pack18, @pack19, @pack20,
																														@pack21, @pack22, @pack23, @pack24, @pack25, @pack26, @pack27, @pack28, @pack29, @pack30,
																														@pack31, @pack32, @pack33, @pack34, @pack35, @pack36, @pack37, @pack38, @pack39, @pack40,
																														@pack41, @pack42, @pack43, @pack44, @pack45, @pack46, @pack47, @pack48, @pack49, @pack50)

			set @rand 		= Convert(int, ceiling(RAND() * 10000))
			set @rand2		= Convert(int, ceiling(RAND() *    10))
			set @roul2 		= dbo.fnu_FVGetCrossRandom(@rand, @rand2, 	@group1, @group2, @group3, @group4, @group5,    @pack1,  @pack2,  @pack3,  @pack4,  @pack5,  @pack6,  @pack7,  @pack8,  @pack9, @pack10,
																														@pack11, @pack12, @pack13, @pack14, @pack15, @pack16, @pack17, @pack18, @pack19, @pack20,
																														@pack21, @pack22, @pack23, @pack24, @pack25, @pack26, @pack27, @pack28, @pack29, @pack30,
																														@pack31, @pack32, @pack33, @pack34, @pack35, @pack36, @pack37, @pack38, @pack39, @pack40,
																														@pack41, @pack42, @pack43, @pack44, @pack45, @pack46, @pack47, @pack48, @pack49, @pack50)


			set @rand 		= Convert(int, ceiling(RAND() * 10000))
			set @rand2		= Convert(int, ceiling(RAND() *    10))
			set @roul3 		= dbo.fnu_FVGetCrossRandom(@rand, @rand2, 	@group1, @group2, @group3, @group4, @group5,    @pack1,  @pack2,  @pack3,  @pack4,  @pack5,  @pack6,  @pack7,  @pack8,  @pack9, @pack10,
																														@pack11, @pack12, @pack13, @pack14, @pack15, @pack16, @pack17, @pack18, @pack19, @pack20,
																														@pack21, @pack22, @pack23, @pack24, @pack25, @pack26, @pack27, @pack28, @pack29, @pack30,
																														@pack31, @pack32, @pack33, @pack34, @pack35, @pack36, @pack37, @pack38, @pack39, @pack40,
																														@pack41, @pack42, @pack43, @pack44, @pack45, @pack46, @pack47, @pack48, @pack49, @pack50)


			set @rand 		= Convert(int, ceiling(RAND() * 10000))
			set @rand2		= Convert(int, ceiling(RAND() *    105))
			set @roul4 		= dbo.fnu_FVGetCrossRandom(@rand, @rand2, 	@group1, @group2, @group3, @group4, @group5,    @pack1,  @pack2,  @pack3,  @pack4,  @pack5,  @pack6,  @pack7,  @pack8,  @pack9, @pack10,
																														@pack11, @pack12, @pack13, @pack14, @pack15, @pack16, @pack17, @pack18, @pack19, @pack20,
																														@pack21, @pack22, @pack23, @pack24, @pack25, @pack26, @pack27, @pack28, @pack29, @pack30,
																														@pack31, @pack32, @pack33, @pack34, @pack35, @pack36, @pack37, @pack38, @pack39, @pack40,
																														@pack41, @pack42, @pack43, @pack44, @pack45, @pack46, @pack47, @pack48, @pack49, @pack50)


			set @rand 		= Convert(int, ceiling(RAND() * 10000))
			set @rand2		= Convert(int, ceiling(RAND() *    10))
			set @roul5 		= dbo.fnu_FVGetCrossRandom(@rand, @rand2, 	@group1, @group2, @group3, @group4, @group5,    @pack1,  @pack2,  @pack3,  @pack4,  @pack5,  @pack6,  @pack7,  @pack8,  @pack9, @pack10,
																														@pack11, @pack12, @pack13, @pack14, @pack15, @pack16, @pack17, @pack18, @pack19, @pack20,
																														@pack21, @pack22, @pack23, @pack24, @pack25, @pack26, @pack27, @pack28, @pack29, @pack30,
																														@pack31, @pack32, @pack33, @pack34, @pack35, @pack36, @pack37, @pack38, @pack39, @pack40,
																														@pack41, @pack42, @pack43, @pack44, @pack45, @pack46, @pack47, @pack48, @pack49, @pack50)


			--select 'DEBUG �̱�(����1��)', @roul1 roul1, @roul2 roul2, @roul3 roul3, @roul4 roul4, @roul5 roul5, @tsgrade1cnt tsgrade1cnt, @tsgrade2cnt tsgrade2cnt, @tsgrade3cnt tsgrade3cnt, @tsgrade4cnt tsgrade4cnt
			----------------------------------
			-- ���� ���� �ϱ�.
			----------------------------------
			if(@cnt = 1)
				begin
					--set @roul1 		= -1
					set @roul2 			= -1
					set @roul3 			= -1
					set @roul4 			= -1
					set @roul5 			= -1
				end
			else if(@cnt = 2)
				begin
					--set @roul1 		= -1
					--set @roul2 		= -1
					set @roul3 			= -1
					set @roul4 			= -1
					set @roul5 			= -1
				end
			else if(@cnt = 3)
				begin
					--set @roul1 		= -1
					--set @roul2 		= -1
					--set @roul3 		= -1
					set @roul4 			= -1
					set @roul5 			= -1
				end
			else if(@cnt = 4)
				begin
					--set @roul1 		= -1
					--set @roul2 		= -1
					--set @roul3 		= -1
					--set @roul4 		= -1
					set @roul5 			= -1
				end
			--select 'DEBUG �̱�(����2��)', @roul1 roul1, @roul2 roul2, @roul3 roul3, @roul4 roul4, @roul5 roul5, @tsgrade1cnt tsgrade1cnt, @tsgrade2cnt tsgrade2cnt, @tsgrade3cnt tsgrade3cnt, @tsgrade4cnt tsgrade4cnt


			--------------------------------------------
			-- 1, 5��°���� ������ �������� �Ѵ�.
			-- 80010, 80020, 80030, 80040, 80050, 80060, 80070, 80080, 80090, 80010, 80110, 80120
			-- 80011, 80021, 80031, 80041, 80051, 80061, 80071, 80081, 80091, 80011, 80111, 80121
			-- 80012, 80022, 80032, 80042, 80052, 80062, 80072, 80082, 80092, 80102, 80112, 80122
			-- 80013, 80023, 80033, 80043, 80053, 80063, 80073, 80083, 80093, 80103, 80113, 80123
			-- 80014, 80024, 80034, 80044, 80054, 80064, 80074, 80084, 80094, 80104, 80114, 80124
			--------------------------------------------
			if(@mode_ = @MODE_ROULETTE_GRADE1 and @tsgrade1cnt in (0, 5, 20, 50, 100))
				begin
					--select 'DEBUG ����1'
					set @rand 	= Convert(int, ceiling(RAND() * 100))
					set @rand2 	= Convert(int, ceiling(RAND() * 100))
					if(@rand2 < 80)
						begin
							set @roul1	= dbo.fnu_FVGetCrossRandom2(@rand, 	80070, 80070, 80070, 80070, 80090, 80090, 80090, 80090, 80110, 80110, 80110, 80110)
						end
					else
						begin
							set @roul1	= dbo.fnu_FVGetCrossRandom2(@rand, 	80070, 80080, 80090, 80110, 80120, 80070, 80080, 80090, 80110, 80120, 80110, 80120)
						end
				end
			if(@mode_ = @MODE_ROULETTE_GRADE2 and @tsgrade2cnt in (0, 5, 20, 50, 100))
				begin
					--select 'DEBUG ����2'
					set @rand 	= Convert(int, ceiling(RAND() * 100))
					set @rand2 	= Convert(int, ceiling(RAND() * 100))
					if(@rand2 < 25)
						begin
							set @roul1	= dbo.fnu_FVGetCrossRandom2(@rand, 	80011, 80021, 80031, 80041, 80051, 80061, 80071, 80081, 80091, 80111, 80121, 80121)
						end
					else if(@rand2 < 50)
						begin
							set @roul1	= dbo.fnu_FVGetCrossRandom2(@rand, 	80202, 80207, 80212, 80217, 80222, 80227, 80232, 80237, 80242, 80247, 80252, 80257)
						end
					else if(@rand2 < 75)
						begin
							set @roul1	= dbo.fnu_FVGetCrossRandom2(@rand, 	80262, 80267, 80272, 80277, 80282, 80287, 80292, 80297, 80302, 80307, 80312, 80257)
						end
					else
						begin
							set @roul1	= dbo.fnu_FVGetCrossRandom2(@rand, 	80012, 80022, 80032, 80042, 80052, 80062, 80072, 80082, 80092, 80102, 80112, 80122)
						end
				end
			else if(@mode_ = @MODE_ROULETTE_GRADE3 and @tsgrade3cnt in (0, 5, 20, 50, 100))
				begin
					--select 'DEBUG ����3'
					set @rand 	= Convert(int, ceiling(RAND() * 100))
					set @rand2 	= Convert(int, ceiling(RAND() * 100))
					if(@rand2 < 25)
						begin
							set @roul1	= dbo.fnu_FVGetCrossRandom2(@rand, 	80012, 80022, 80032, 80042, 80052, 80062, 80072, 80082, 80092, 80112, 80122, 80122)
						end
					else if(@rand2 < 50)
						begin
							set @roul1	= dbo.fnu_FVGetCrossRandom2(@rand, 	80203, 80208, 80213, 80218, 80223, 80228, 80233, 80238, 80243, 80248, 80253, 80258)
						end
					else if(@rand2 < 75)
						begin
							set @roul1	= dbo.fnu_FVGetCrossRandom2(@rand, 	80263, 80268, 80273, 80278, 80283, 80288, 80293, 80298, 80303, 80308, 80313, 80258)
						end
					else
						begin
							set @roul1	= dbo.fnu_FVGetCrossRandom2(@rand, 	80013, 80023, 80033, 80043, 80053, 80063, 80073, 80083, 80093, 80103, 80113, 80123)
						end
				end
			else if(@mode_ = @MODE_ROULETTE_GRADE4 and @tsgrade4cnt in (0, 5, 20, 50, 100))
				begin
					--select 'DEBUG ����4'
					set @rand 	= Convert(int, ceiling(RAND() * 100))
					set @rand2 	= Convert(int, ceiling(RAND() * 100))
					if(@rand2 < 25)
						begin
							set @roul1	= dbo.fnu_FVGetCrossRandom2(@rand, 	80013, 80023, 80033, 80043, 80053, 80063, 80073, 80083, 80093, 80113, 80123, 80123)
						end
					else if(@rand2 < 50)
						begin
							set @roul1	= dbo.fnu_FVGetCrossRandom2(@rand, 	80204, 80209, 80214, 80219, 80224, 80229, 80234, 80239, 80244, 80249, 80254, 80259)
						end
					else if(@rand2 < 75)
						begin
							set @roul1	= dbo.fnu_FVGetCrossRandom2(@rand, 	80264, 80269, 80274, 80279, 80284, 80289, 80294, 80299, 80304, 80309, 80314, 80204)
						end
					else
						begin
							set @roul1	= dbo.fnu_FVGetCrossRandom2(@rand, 	80014, 80024, 80034, 80044, 80054, 80064, 80074, 80084, 80094, 80104, 80114, 80124)
						end
				end
			--select 'DEBUG �̱�(1������)', @roul1 roul1, @roul2 roul2, @roul3 roul3, @roul4 roul4, @roul5 roul5

			--------------------------------------------------------------------
			---- �̱⸦ �����Կ� �־��ֱ�.
			--------------------------------------------------------------------
			----select 'DEBUG �̱� ��������(������ �ڵ����� �н���)', @roul1 roul1, @roul2 roul2, @roul3 roul3, @roul4 roul4, @roul5 roul5
			--exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @roul5, 0, @sendid, @gameid_, ''
			--exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @roul4, 0, @sendid, @gameid_, ''
			--exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @roul3, 0, @sendid, @gameid_, ''
			--exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @roul2, 0, @sendid, @gameid_, ''
			--exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @roul1, 0, @sendid, @gameid_, ''


			--------------------------------------------------------------------
			---- �̺�Ʈ ��¥ > Ư�� > ��������1
			--------------------------------------------------------------------
			--if(@roulrewardflag = 1)
			--	begin
			--		--select 'DEBUG > �̺�Ʈ �Ⱓ��'
			--		if(@roulani1 != -1 and @roulani1 in (@roul1, @roul2, @roul3, @roul4, @roul5))
			--			begin
			--				--select 'DEBUG > 	-> Ư�� ����1'
			--				exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @roulreward1, @roulrewardcnt1, @roulname1, @gameid_, ''
			--				set @checktreasure 	= @roulani1
			--				set @checkreward 	= @roulreward1
			--			end
			--		else if(@roulani2 != -1 and @roulani2 in (@roul1, @roul2, @roul3, @roul4, @roul5))
			--			begin
			--				--select 'DEBUG >  	-> Ư�� ����2'
			--				exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @roulreward2, @roulrewardcnt2, @roulname2, @gameid_, ''
			--				set @checktreasure 	= @roulani2
			--				set @checkreward 	= @roulreward2
			--			end
			--		else if(@roulani3 != -1 and @roulani3 in (@roul1, @roul2, @roul3, @roul4, @roul5))
			--			begin
			--				--select 'DEBUG > 	-> Ư�� ����3'
			--				exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @roulreward3, @roulrewardcnt3, @roulname3, @gameid_, ''
			--				set @checktreasure 	= @roulani3
			--				set @checkreward 	= @roulreward3
			--			end
			--	end

			--------------------------------------------------------------------
			-- �̱� �����ϱ�.
			--------------------------------------------------------------------
			--exec spu_FVRoulAdLog @gameid_, @nickname, @mode_, @roul1, @roul2, @roul3, @roul4, @roul5

			--------------------------------------------------------------------
			---- ��������ϱ�.
			--------------------------------------------------------------------
			--if(@roul1 != -1)
			--	begin
			--		exec spu_FVDogamListLog @gameid_, @roul1
			--	end
			--if(@roul2 != -1)
			--	begin
			--		exec spu_FVDogamListLog @gameid_, @roul2
			--	end
			--if(@roul3 != -1)
			--	begin
			--		exec spu_FVDogamListLog @gameid_, @roul3
			--	end
			--if(@roul4 != -1)
			--	begin
			--		exec spu_FVDogamListLog @gameid_, @roul4
			--	end
			--if(@roul5 != -1)
			--	begin
			--		exec spu_FVDogamListLog @gameid_, @roul5
			--	end

			--------------------------------
			-- �̱� �α� ���.
			--exec spu_FVUserItemRoulLogTest 'xxxx2',  1, 500, 80010,     0, 0, 400, 80010, -1, -1, -1, -1, -1, 10, 10
			--exec spu_FVUserItemRoulLogTest 'xxxx2',  2, 500, 80010,  2000, 0,   0, 80010, -1, -1, -1, -1, -1, 10, 10
			--exec spu_FVUserItemRoulLogTest 'xxxx2',  3, 500, 80010,  4000, 0,   0, 80010, -1, -1, -1, -1, -1, 10, 10
			--exec spu_FVUserItemRoulLogTest 'xxxx2',  4, 500, 80010, 12000, 0,   0, 80010, -1, -1, -1, -1, -1, 10, 10
			--
			--exec spu_FVUserItemRoulLogTest 'xxxx2', 12, 500, 80010,     0, 0,   0, 80010, -1, -1, -1, -1, -1, ,10, 10
			--exec spu_FVUserItemRoulLogTest 'xxxx2', 13, 500, 80010,     0, 0,   0, 80010, -1, -1, -1, -1, -1, ,10, 10
			--exec spu_FVUserItemRoulLogTest 'xxxx2', 14, 500, 80010,     0, 0,   0, 80010, -1, -1, -1, -1, -1, ,10, 10
			--------------------------------
			--if(@ownercashcost2 > @ownercashcost - @needcashcost)
			--	begin
			--		set @strange = 1
			--		set @comment2 = '�����̱� ����(' + ltrim(rtrim(@ownercashcost)) + ') - ���(' + ltrim(rtrim(@needcashcost)) + ') < ������(' + ltrim(rtrim(@ownercashcost2)) + ')'
			--		--select 'DEBUG **** �̻���', @comment2 comment2
			--		exec spu_FVSubUnusualRecord2  @gameid_, @comment2
			--	end
			exec spu_FVUserItemRoulLogTest @gameid_, @mode_, @bestani, @itemcode, @needcashcost, @needgamecost, @needheart, @roul1, @roul2, @roul3, @roul4, @roul5, @strange, @ownercashcost, @ownercashcost2

			------------------------------------------------
			---- ���̺� ���� ����.
			------------------------------------------------
			----select 'DEBUG update'
			--update dbo.tFVUserData
			--	set
			--		savedata = @savedata_
			--where gameid = @gameid_
		END

	--------------------------------------------------
	----	3-3. �������
	--------------------------------------------------
	--select @nResult_ rtn, @comment comment,
	--	   @roul1 roul1, @roul2 roul2, @roul3 roul3, @roul4 roul4, @roul5 roul5,
	--	   @roulsaleflag roulsaleflag, 	@roulsalevalue roulsalevalue,
	--	   @roulrewardflag roulrewardflag,	@checktreasure checktreasure, 	@checkreward checkreward,
	--	   @roultimeflag roultimeflag, 		@roultimetime1 roultimetime1,	@roultimetime2 roultimetime2, @roultimetime3 roultimetime3,
	--	   @tsgauageflag tsgauageflag,
	--	   @tsgrade2gauage tsgrade2gauage, 	@tsgrade3gauage tsgrade3gauage, @tsgrade4gauage tsgrade4gauage,
	--	   @tsgrade2free tsgrade2free, 		@tsgrade3free tsgrade3free, 	@tsgrade4free tsgrade4free

	if(@nResult_ = @RESULT_SUCCESS)
		begin
			-- �������� ���� �־���
			update dbo.tFVUserMaster
				set
					randserial		= @randserial_,
					ownercashcost	= @ownercashcost2,

					bgroul1			= @roul1,		bgroul2			= @roul2,			bgroul3			= @roul3,			bgroul4			= @roul4,			bgroul5		= @roul5,
					tsgrade1cnt		= tsgrade1cnt + case when (@mode_ in (@MODE_ROULETTE_GRADE1)                            ) then 1 else 0 end,
					tsgrade2cnt		= tsgrade2cnt + case when (@mode_ in (@MODE_ROULETTE_GRADE2, @MODE_ROULETTE_GRADE2_FREE)) then 1 else 0 end,
					tsgrade3cnt		= tsgrade3cnt + case when (@mode_ in (@MODE_ROULETTE_GRADE3, @MODE_ROULETTE_GRADE3_FREE)) then 1 else 0 end,
					tsgrade4cnt		= tsgrade4cnt + case when (@mode_ in (@MODE_ROULETTE_GRADE4, @MODE_ROULETTE_GRADE4_FREE)) then 1 else 0 end,
					tsgrade2gauage 	= @tsgrade2gauage,	tsgrade3gauage 	= @tsgrade3gauage,	tsgrade4gauage 	= @tsgrade4gauage,
					tsgrade2free	= @tsgrade2free,	tsgrade3free	= @tsgrade3free,	tsgrade4free	= @tsgrade4free
			where gameid = @gameid_

			--------------------------------------------------------------
			-- ����/���� ����Ʈ ����
			--------------------------------------------------------------
			--exec spu_FVGiftList @gameid_
		end
	set nocount off
End



