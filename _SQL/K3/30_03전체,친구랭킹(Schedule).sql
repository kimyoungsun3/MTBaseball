-- use Game4FarmVill3
-- GO
update dbo.tFVUserMaster set erbestdealer = 200, erstate = 2 where gameid = 'xxxx'
update dbo.tFVUserMaster set erbestdealer = 150, erstate = 2 where gameid = 'xxxx2'
update dbo.tFVUserMaster set erbestdealer = 100, erstate = 2 where gameid = 'xxxx3'
-- delete from dbo.tFVUserMasterSchedule where dateid = '20150707'
-- update dbo.tFVUserMasterSchedule set idxStart = 1 where dateid = '20150707'
-- select * from dbo.tFVUserMasterSchedule where dateid = '20150707'

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
		@erbestdealer		bigint,
		@lmerbestdealer	bigint,			@lmrank			int,	@lmcnt			int,
		@l1gameid		varchar(60),	@l1erbestdealer		bigint,
		@l2gameid		varchar(60),	@l2erbestdealer		bigint,
		@l3gameid		varchar(60),	@l3erbestdealer		bigint,
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
		insert into dbo.tFVUserRankSub(rank, dateid8, gameid, erbestdealer, nickname)
		select top 1000 rank() over(order by erbestdealer desc) as rank, @dateid, gameid, erbestdealer, nickname
		from dbo.tFVUserMaster where erstate = 2 and erbestdealer > 0

		-- 1. ��ŷ Ŀ���� �о����.
		declare curUserRanking Cursor for
		select top 1000 rank() over(order by erbestdealer desc) as rank, gameid from dbo.tFVUserMaster where erbestdealer > 0

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
	erbestdealer		bigint
);

select @idx = isnull(idxStart, 0) from dbo.tFVUserMasterSchedule where dateid = @dateid
--select 'DEBUG �о����', @dateid dateid, @idx idx
set @binsert = @idx

-- 1. ģ�� ��ŷ Ŀ���� �о����.
declare curUserMaster Cursor for
select idx, gameid, erbestdealer from dbo.tFVUserMaster
where idx > @idx
order by idx asc

-- 2. Ŀ������
open curUserMaster

-- 3. Ŀ�� ���
Fetch next from curUserMaster into @idx, @gameid, @erbestdealer
while @@Fetch_status = 0
	Begin
		--------------------------------------
		-- ģ�� ����Ʈ ���� �ӽ� ���̺� Ŭ����.
		--------------------------------------
		delete from @tTempTableList
		set @lmerbestdealer = 0	set @lmrank 	= 1		set @lmcnt = 0
		set @l1gameid 	= ''	set @l1erbestdealer = 0
		set @l2gameid 	= ''	set @l2erbestdealer = 0
		set @l3gameid 	= ''	set @l3erbestdealer = 0

		---------------------------------
		-- ģ�� ����Ʈ + �ڱ� �Է�.
		---------------------------------
		-- ģ����ŷ.
		insert into @tTempTableList(                   rank, gameid, erbestdealer)
		select rank() over(order by erbestdealer desc) as rank, gameid, erbestdealer from dbo.tFVUserMaster
		where gameid in (select friendid from dbo.tFVUserFriend where (gameid = @gameid and state = @USERFRIEND_STATE_FRIEND)
						union
						select @gameid)
			  and erbestdealer > 0
		--select 'DEBUG ', * from @tTempTableList

		-- �������� ��ŷ �����ϱ�.
		select @l1gameid = gameid, @l1erbestdealer = erbestdealer from @tTempTableList where rank = 1
		select @l2gameid = gameid, @l2erbestdealer = erbestdealer from @tTempTableList where rank = 2
		select @l3gameid = gameid, @l3erbestdealer = erbestdealer from @tTempTableList where rank = 3

		select @lmrank = rank, @lmerbestdealer = erbestdealer from @tTempTableList where gameid = @gameid
		select @lmcnt  = isnull(max(rank), 1) from @tTempTableList

		-------------------------------------
		-- 2. ���� �����ϱ�.
		-------------------------------------
		update dbo.tFVUserMaster
			set
				-- �ڽ��� ��ŷ.
				rankresult	= 1,
				lmerbestdealer = @lmerbestdealer, lmrank = @lmrank, 			lmcnt = @lmcnt,

				-- ģ�� 1, 2, 3�� ��ŷ.
				l1gameid = @l1gameid, 		l1erbestdealer = @l1erbestdealer,
				l2gameid = @l2gameid, 		l2erbestdealer = @l2erbestdealer,
				l3gameid = @l3gameid, 		l3erbestdealer = @l3erbestdealer,

				-- �ʱ�ȭ.
				erbestdealerbkup 	= erbestdealerbkup + @erbestdealer
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
		Fetch next from curUserMaster into @idx, @gameid, @erbestdealer
	end

--select 'DEBUG �Ϸ� > ��ŷ�ϱ�', @idx idx
update tFVUserMasterSchedule set idxStart = @idx where dateid = @dateid


----------------------------------------
--	���������� Ŭ�����ϱ�.
----------------------------------------
select @idx = max(idx) from dbo.tFVUserMaster
while(@idx > -1000)
	begin
		--select 'DEBUG ���� ���� Ŭ����', @idx idx
		update dbo.tFVUserMaster
			set
				erbestdealer = 0
		where idx >= @idx - 1000 and idx <= @idx
		set @idx =  @idx - 1000
	end

-- 4. Ŀ���ݱ�
close curUserMaster
Deallocate curUserMaster
