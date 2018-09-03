-- use Farm
-- GO
-- update dbo.tUserMaster set salemoney = 123456789000 where gameid = 'xxxx' update dbo.tUserMaster set salemoney = 123456789002 where gameid = 'xxxx@gmail.com' update dbo.tUserMaster set salemoney = 123456789003 where gameid = 'xxxx3'
-- delete from dbo.tFVUserMasterSchedule where dateid = '20150209'
-- update dbo.tFVUserMasterSchedule set idxStart = 1 where dateid = '20150209'
-- select * from dbo.tFVUserMasterSchedule where dateid = '20150209'

--------------------------------------------
-- SQL Server ������Ʈ(���� �����־���Ѵ�.)
-- ���� ������ 1���� ������ ����� �����Ѵ�.
---------------------------------------------
-- ���ֿ����� ���� 00�� 00�� 01�ʿ� ����
-- ���� ������ ó��
declare @USERFRIEND_STATE_FRIEND	int			set	@USERFRIEND_STATE_FRIEND	= 2;		-- 2 : ��ȣģ��
declare @binsert		int,
		@dateid			varchar(8),
		@loop			int,
		@idx			int,
		@gameid 		varchar(60),
		@salemoney		bigint,
		@lmsalemoney	bigint,			@lmrank			int,	@lmcnt			int,
		@l1gameid		varchar(60),	@l1bestani		int,	@l1salemoney		bigint,
		@l2gameid		varchar(60),	@l2bestani		int,	@l2salemoney		bigint,
		@l3gameid		varchar(60),	@l3bestani		int,	@l3salemoney		bigint,
		@rank			int,
		@sendid 		varchar(60)

set @dateid		= Convert(varchar(8), Getdate(), 112)
set @loop 		= 3000
set @idx 		= -1
set @binsert	= -1


--------------------------------------------------------
-- 1. ��ü��ŷ
--------------------------------------------------------
--select 'DEBUG ', @dateid dateid
-- 1. ��ŷ�� ���� �Ǿ��°�?
if(exists(select top 1 * from dbo.tFVUserRankMaster where dateid = @dateid))
	begin
		set @dateid = @dateid
		--select 'DEBUG ��ŷ ���� �̹���'
	end
else
	begin
		--select 'DEBUG ��ŷ ���� �ϱ�', @dateid dateid
		-- ��ŷ����Ÿ ���
		insert into dbo.tFVUserRankSub(rank, dateid8, gameid, salemoney, bestani, nickname)
		select top 1000 rank() over(order by salemoney desc) as rank, @dateid, gameid, salemoney, bestani, nickname from dbo.tUserMaster where salemoney > 0

		-- 1. ��ŷ Ŀ���� �о����.
		declare curUserRanking Cursor for
		select top 1000 rank() over(order by salemoney desc) as rank, gameid from dbo.tUserMaster where salemoney > 0

		-- 2. Ŀ������
		open curUserRanking

		-- 3. Ŀ�� ���
		Fetch next from curUserRanking into @rank, @gameid
		while @@Fetch_status = 0
			Begin


				----------------------------
				-- 	1 ~  10. 10,000 ����
				--	  ~  30.  5,000 ����
				--	  ~  50.  2,000 ����
				--	  ~ 100.    500 ����
				--	  ~1000.    200 ����
				----------------------------
				set @sendid = '��ŷ' + ltrim(rtrim(@rank))
				--select 'DEBUG ', @rank rank, @gameid gameid, @sendid sendid


				if(@rank >= 1 and @rank <= 10)
					begin
						exec spu_FVSubGiftSend 2, 3015,  10000, @sendid, @gameid, ''
					end
				else if(          @rank <= 30)
					begin
						exec spu_FVSubGiftSend 2, 3015,   5000, @sendid, @gameid, ''
					end
				else if(          @rank <= 50)
					begin
						exec spu_FVSubGiftSend 2, 3015,   2000, @sendid, @gameid, ''
					end
				else if(          @rank <= 100)
					begin
						exec spu_FVSubGiftSend 2, 3015,    500, @sendid, @gameid, ''
					end
				else if(          @rank <= 1000)
					begin
						exec spu_FVSubGiftSend 2, 3015,    200, @sendid, @gameid, ''
					end

				Fetch next from curUserRanking into @rank, @gameid
			end

		exec spu_FVUserRankScheduleRecord @dateid, 1

		-- 4. Ŀ���ݱ�
		close curUserRanking
		Deallocate curUserRanking
	end

--------------------------------------------------------
-- 2. ģ����ŷ
--------------------------------------------------------
DECLARE @tTempTableList TABLE(
	rank			int,
	gameid			varchar(60),
	bestani			int,
	salemoney		bigint
);

select @idx = isnull(idxStart, 0) from dbo.tFVUserMasterSchedule where dateid = @dateid
--select 'DEBUG �о����', @dateid dateid, @idx idx
set @binsert = @idx

-- 1. ģ�� ��ŷ Ŀ���� �о����.
declare curUserMaster Cursor for
select idx, gameid, salemoney from dbo.tUserMaster
where idx > @idx
order by idx asc

-- 2. Ŀ������
open curUserMaster

-- 3. Ŀ�� ���
Fetch next from curUserMaster into @idx, @gameid, @salemoney
while @@Fetch_status = 0
	Begin
		--------------------------------------
		-- ģ�� ����Ʈ ���� �ӽ� ���̺� Ŭ����.
		--------------------------------------
		delete from @tTempTableList
		set @lmsalemoney = 0	set @lmrank 	= 1		set @lmcnt = 0
		set @l1gameid 	= ''	set @l1bestani = -1		set @l1salemoney = 0
		set @l2gameid 	= ''	set @l2bestani = -1		set @l2salemoney = 0
		set @l3gameid 	= ''	set @l3bestani = -1		set @l3salemoney = 0

		---------------------------------
		-- ģ�� ����Ʈ + �ڱ� �Է�.
		---------------------------------
		-- ģ����ŷ.
		insert into @tTempTableList(                   rank, gameid, bestani, salemoney)
		select rank() over(order by salemoney desc) as rank, gameid, bestani, salemoney from dbo.tUserMaster
		where gameid in (select friendid from dbo.tFVUserFriend where (gameid = @gameid and state = @USERFRIEND_STATE_FRIEND)
						union
						select @gameid)
			  and salemoney > 0
		--select 'DEBUG ', * from @tTempTableList

		-- �������� ��ŷ �����ϱ�.
		select @l1gameid = gameid, @l1bestani = bestani, @l1salemoney = salemoney from @tTempTableList where rank = 1
		select @l2gameid = gameid, @l2bestani = bestani, @l2salemoney = salemoney from @tTempTableList where rank = 2
		select @l3gameid = gameid, @l3bestani = bestani, @l3salemoney = salemoney from @tTempTableList where rank = 3

		select @lmrank = rank, @lmsalemoney = salemoney from @tTempTableList where gameid = @gameid
		select @lmcnt  = isnull(max(rank), 1) from @tTempTableList

		-------------------------------------
		-- 2. ���� �����ϱ�.
		-------------------------------------
		update dbo.tUserMaster
			set
				-- �ڽ��� ��ŷ.
				rankresult	= 1,
				lmsalemoney = @lmsalemoney, lmrank = @lmrank, 			lmcnt = @lmcnt,

				-- ģ�� 1, 2, 3�� ��ŷ.
				l1gameid = @l1gameid, 		l1bestani = @l1bestani, 	l1salemoney = @l1salemoney,
				l2gameid = @l2gameid, 		l2bestani = @l2bestani, 	l2salemoney = @l2salemoney,
				l3gameid = @l3gameid, 		l3bestani = @l3bestani, 	l3salemoney = @l3salemoney,

				-- �ʱ�ȭ.
				salemoneybkup 	= salemoneybkup + @salemoney
		where gameid = @gameid

		-------------------------------------
		-- 3. üũ����Ʈ �α�
		-------------------------------------
		if(@binsert = -1)
			begin
				--select 'DEBUG �ű� > ��ŷ�ϱ�', @idx idx
				insert into dbo.tFVUserMasterSchedule(dateid,  idxStart)
				values(                              @dateid, @idx)

				set @binsert = 1
			end
		else if(@idx % @loop = 0)
			begin
				--select 'DEBUG �߰� > ��ŷ�ϱ�', @idx idx
				update tFVUserMasterSchedule set idxStart = @idx where dateid = @dateid
			end
		Fetch next from curUserMaster into @idx, @gameid, @salemoney
	end

--select 'DEBUG �Ϸ� > ��ŷ�ϱ�', @idx idx
update tFVUserMasterSchedule set idxStart = @idx where dateid = @dateid


----------------------------------------
--	���������� Ŭ�����ϱ�.
----------------------------------------
select @idx = max(idx) from dbo.tUserMaster
while(@idx > -1000)
	begin
		--select 'DEBUG ���� ���� Ŭ����', @idx idx
		update dbo.tUserMaster
			set
				salemoney = 0
		where idx >= @idx - 1000 and idx <= @idx
		set @idx =  @idx - 1000
	end

-- 4. Ŀ���ݱ�
close curUserMaster
Deallocate curUserMaster
