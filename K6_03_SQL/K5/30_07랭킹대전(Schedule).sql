-- use Game4GameMTBaseballVill5
-- GO

-- K5_û�鷩ŷ

--------------------------------------------
-- [����(���������ϱ�)] / 00�ÿ� ����
-- ���� ���� 00�� 00�� 01�ʿ� ����
-- if(������¥ > �����޻���)
-- 1. �̱��� ���������� ����� ���� ���� ��������
-- 	> �̱��� �ο��� �� ������ �������� ���� �翬��
-- 		> �̱�͸� ���� & ������ 0��ó��
-- 	> �翬��Ȱ����� ��ŷ ����
-- 	> ����� �������� ������������ (Ȧ¦0313_1 ~ Ȧ¦0313_101)
-- 2. �������� ����� > Ŭ����
-- 3. ������¥�� ������ ����ó���� ��ȯ
---------------------------------------------
declare @RANK_REWARD_ING	int 	set @RANK_REWARD_ING	= 0
declare @RANK_REWARD_END	int 	set @RANK_REWARD_END	= 1
declare @rkreward			int,
		@rkwinteam			int,
		@rkteam1			int,
		@rkteam0			int,
		@rkdateid8			varchar(8),
		@rkdateid4			varchar(4),
		@loop				int,
		@idx				int,
		@rank				int,
		@gameid 			varchar(60),
		@sendid 			varchar(60),
		@title				varchar(10)

set @rkreward	= @RANK_REWARD_END
set @rkdateid8	= Convert(varchar(8), Getdate() - 1, 112)
set @rkdateid4	= SUBSTRING(@rkdateid8, 5, 8)
set @loop 		= 1000
set @idx 		= -1

--------------------------------------------------------
-- 1. ���� ������ ��������
--------------------------------------------------------
	select
		@rkreward 	= rkreward,		@rkteam1 	= rkteam1,		@rkteam0 	= rkteam0
	from dbo.tRankDaJun where rkdateid8 = @rkdateid8
	--select 'DEBUG ', @rkdateid4 rkdateid4, @rkdateid8 rkdateid8, * from dbo.tRankDaJun where rkdateid8 = @rkdateid8

	if(@rkreward = @RANK_REWARD_END)
		begin
			--select 'DEBUG ���޿Ϸ� > ������ ����.'
			return
		end

--------------------------------------------------------
-- 2. �̱��� ���� > �����
-- �Ǹż���			80,000		1 		80,000
-- ����跲			   600 		135 	81,000
-- ��Ʋ ����Ʈ		    70 		1000 	70,000
-- ����,��������Ʈ	    60 		1400 	84,000
-- ģ������Ʈ		 1,510 		50 		75,500
-- �귿����Ʈ		   101 		600		60,600
-- ��������Ʈ		    36 		50 		 1,800
-- 3. �������� ����� > Ŭ����
--------------------------------------------------------
	select @idx = max(idx) from dbo.tUserMaster
	while(@idx > -1000)
		begin
			--select 'DEBUG ���� ��ŷ���� ���', @idx idx
			update dbo.tUserMaster
				set
					-- 1�� ��� ����Ÿ�� ����Ѵ�.
					rktotalbk 		= rktotal,
					rksalemoneybk	= rksalemoney,
					rksalebarrelbk	= rksalebarrel,
					rkbattlecntbk	= rkbattlecnt,
					rkbogicntbk		= rkbogicnt,
					rkfriendpointbk	= rkfriendpoint,
					rkroulettecntbk	= rkroulettecnt,
					rkwolfcntbk		= rkwolfcnt,

					-- 2�� �����ϱ�.
					rktotal  = FLOOR(case when ((@rkteam1 > @rkteam0 and rkteam = 1) or (@rkteam1 < @rkteam0 and rkteam = 0)) then (rksalemoney * 1 + rksalebarrel * 135 + rkbattlecnt*1000 + rkbogicnt*1400 + rkfriendpoint*50 + rkroulettecnt*600 + rkwolfcnt*50) else 0 end),

					-- 3�� ������ ����Ÿ�� Ŭ�����ϱ�.
					rksalemoney 	= 0,
					rksalebarrel	= 0,
					rkbattlecnt		= 0,
					rkbogicnt		= 0,
					rkfriendpoint	= 0,
					rkroulettecnt	= 0,
					rkwolfcnt		= 0
			where idx >= @idx - 1000 and idx <= @idx
			set @idx =  @idx - 1000
		end
	--select 'DEBUG ', gameid, rkteam, rktotal, rktotal2 from dbo.tUserMaster where rktotal > 0 order by rktotal desc


--------------------------------------------------------
-- 3. ����� ���� ���� ��������
--------------------------------------------------------
	set @title = case when (@rkteam1 > @rkteam0) then 'û����' else '������' end

	-- 1. ��ŷ Ŀ���� �о����.
	declare curUserRanking Cursor for
	select rank() over(order by rktotal desc) as rank, gameid from dbo.tUserMaster where rktotal > 0

	-- 2. Ŀ������
	open curUserRanking

	-- 3. Ŀ�� ���
	Fetch next from curUserRanking into @rank, @gameid
	while @@Fetch_status = 0
		Begin
			----------------------------
			--	< Ȧ¦��ŷ >
			-- 	 ~    1. 100
			-- 	 ~    5.  70
			--	  ~  10.  40
			--	  ~ 100.  20
			--	 ������.   5
			----------------------------
			set @sendid = @title + @rkdateid4 + '_' + ltrim(rtrim(@rank))
			--select 'DEBUG ', @rank rank, @gameid gameid, @sendid sendid

			if(@rank >= 1 and @rank <= 1)
				begin
					exec spu_SubGiftSendNew 2, 3600, 150, @sendid, @gameid, ''
					exec spu_SubGiftSendNew 2, 3500, 150, @sendid, @gameid, ''
				end
			else if(          @rank <= 5)
				begin
					exec spu_SubGiftSendNew 2, 3600, 130, @sendid, @gameid, ''
					exec spu_SubGiftSendNew 2, 3500, 130, @sendid, @gameid, ''
				end
			else if(          @rank <= 10)
				begin
					exec spu_SubGiftSendNew 2, 3600, 100, @sendid, @gameid, ''
					exec spu_SubGiftSendNew 2, 3500, 100, @sendid, @gameid, ''
				end
			else if(          @rank <= 100)
				begin
					exec spu_SubGiftSendNew 2, 3600, 50, @sendid, @gameid, ''
					exec spu_SubGiftSendNew 2, 3500, 50, @sendid, @gameid, ''
				end
			else
				begin
					exec spu_SubGiftSendNew 2, 3600, 30, @sendid, @gameid, ''
					exec spu_SubGiftSendNew 2, 3500, 30, @sendid, @gameid, ''
				end

			Fetch next from curUserRanking into @rank, @gameid
		end

	-- 4. Ŀ���ݱ�
	close curUserRanking
	Deallocate curUserRanking

--------------------------------------------------------
-- 4. ������¥�� ������ ����ó���� ��ȯ
--------------------------------------------------------
--select 'DEBUG ������¥�� ������ ����ó���� ��ȯ'
update dbo.tRankDaJun
	set
		rkreward = @RANK_REWARD_END
where rkdateid8 = @rkdateid8