/*
-- use Game4FarmVill4
-- GO

-- exec spu_subFVRankDaJunTest 'xxxx2', '20150312', 99999999999999, 2000000000000, 3000000, 1267977400, 500000, 6000000, 70000000
-- exec spu_subFVRankDaJunTest 'xxxx3', '20150312', 1, 20000000000, 3, 12679774, 5, 60000, 7
-- update dbo.tFVRankDaJun set rkreward = 0 where rkdateid8 = '20150312'


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
set @loop 		= 3000
set @idx 		= -1

--------------------------------------------------------
-- 1. ���� ������ ��������
--------------------------------------------------------
	select
		@rkreward 		= rkreward,			@rkteam1 		= rkteam1,			@rkteam0 		= rkteam0
	from dbo.tFVRankDaJun where rkdateid8 = @rkdateid8
	--select 'DEBUG ', @rkdateid4 rkdateid4, @rkdateid8 rkdateid8, * from dbo.tFVRankDaJun where rkdateid8 = @rkdateid8

	if(@rkreward = @RANK_REWARD_END)
		begin
			--select 'DEBUG ���޿Ϸ� > ������ ����.'
			return
		end

--------------------------------------------------------
-- 2. �̱��� ���� > �����
-- �Ǹż���(0)	200,000,000 	0.000100 	20,000
-- �������(30)	2,000,000 		0.010000 	20,000
-- �������(31)	2,000,000 		0.010000 	20,000
-- ������(32)	500 			40.000000 	20,000
-- ģ������Ʈ	200 			50.000000 	10,000
-- �귿Ƚ��	2 	900.000000 		1,			800
-- �÷���Ÿ��	86,400 			0.100000 	8,640
-- 3. �������� ����� > Ŭ����
--------------------------------------------------------
	select @idx = max(idx) from dbo.tFVUserMaster
	while(@idx > -1000)
		begin
			-- --select 'DEBUG ���� ��ŷ���� ���', @idx idx
			update dbo.tFVUserMaster
				set
					-- 1�� ��� ����Ÿ�� ����Ѵ�.
					rktotal2 		= rktotal,
					rksalemoneybk	= rksalemoney,
					rkproductcntbk	= rkproductcnt,
					rkfarmearnbk	= rkfarmearn,
					rkwolfcntbk		= rkwolfcnt,
					rkfriendpointbk	= rkfriendpoint,
					rkroulettecntbk	= rkroulettecnt,
					rkplaycntbk		= rkplaycnt,

					-- 2�� �����ϱ�.
					rktotal  = FLOOR(case when ((@rkteam1 > @rkteam0 and rkteam = 1) or (@rkteam1 < @rkteam0 and rkteam = 0)) then (rksalemoney*0.0001 + rkproductcnt*0.01 + rkfarmearn*0.01 + rkwolfcnt*40 + rkfriendpoint*50 + rkroulettecnt*900 + rkplaycnt*0.1) else 0 end),

					-- 3�� ������ ����Ÿ�� Ŭ�����ϱ�.
					rksalemoney 	= 0,
					rkproductcnt	= 0,
					rkfarmearn		= 0,
					rkwolfcnt		= 0,
					rkfriendpoint	= 0,
					rkroulettecnt	= 0,
					rkplaycnt		= 0
			where idx >= @idx - 1000 and idx <= @idx
			set @idx =  @idx - 1000
		end
	--select 'DEBUG ', gameid, rkteam, rktotal, rktotal2 from dbo.tFVUserMaster where rktotal > 0 order by rktotal desc


--------------------------------------------------------
-- 3. ����� ���� ���� ��������
--------------------------------------------------------
	set @title = case when (@rkteam1 > @rkteam0) then 'Ȧ��' else '¦��' end

	-- 1. ��ŷ Ŀ���� �о����.
	declare curUserRanking Cursor for
	select rank() over(order by rktotal desc) as rank, gameid from dbo.tFVUserMaster where rktotal > 0

	-- 2. Ŀ������
	open curUserRanking

	-- 3. Ŀ�� ���
	Fetch next from curUserRanking into @rank, @gameid
	while @@Fetch_status = 0
		Begin
			----------------------------
			--	< Ȧ¦��ŷ >
			-- 	 ~    1. 10,000 ����	�� 50
			-- 	 ~    5.  5,000 ����	�� 30
			--	  ~  10.  2,000 ����	�� 20
			--	  ~ 100.    500 ����	�� 5
			--	 ������.     30 ����	�� 0
			----------------------------
			set @sendid = @title + @rkdateid4 + '_' + ltrim(rtrim(@rank))
			--select 'DEBUG ', @rank rank, @gameid gameid, @sendid sendid

			if(@rank >= 1 and @rank <= 1)
				begin
					exec spu_FVSubGiftSend 2, 3015,  10000, @sendid, @gameid, ''
					exec spu_FVSubGiftSend 2, 3700,     50, @sendid, @gameid, ''
				end
			else if(          @rank <= 5)
				begin
					exec spu_FVSubGiftSend 2, 3015,   2000, @sendid, @gameid, ''
					exec spu_FVSubGiftSend 2, 3700,     30, @sendid, @gameid, ''
				end
			else if(          @rank <= 10)
				begin
					exec spu_FVSubGiftSend 2, 3015,   2000, @sendid, @gameid, ''
					exec spu_FVSubGiftSend 2, 3700,     20, @sendid, @gameid, ''
				end
			else if(          @rank <= 100)
				begin
					exec spu_FVSubGiftSend 2, 3015,    500, @sendid, @gameid, ''
					exec spu_FVSubGiftSend 2, 3700,      5, @sendid, @gameid, ''
				end
			else
				begin
					exec spu_FVSubGiftSend 2, 3015,     60, @sendid, @gameid, ''
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
update dbo.tFVRankDaJun
	set
		rkreward = @RANK_REWARD_END
where rkdateid8 = @rkdateid8
*/
