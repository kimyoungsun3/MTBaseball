-- use Farm
-- GO
--
-- delete from dbo.tFVUserMasterSchedule where dateid = '20140530'
-- update dbo.tFVUserMasterSchedule set idxStart = 1 where dateid = '20140530'
-- select * from dbo.tFVUserMasterSchedule where dateid = '20140530'

--------------------------------------------
-- SQL Server ������Ʈ(���� �����־���Ѵ�.)
-- ���� ������ 1���� ������ ����� �����Ѵ�.
---------------------------------------------
-- ���ֿ����� ���� 00�� 00�� 01�ʿ� ����
-- ���� ������ ó��
declare @USERFRIEND_STATE_FRIEND	int			set	@USERFRIEND_STATE_FRIEND	= 2;		-- 2 : ��ȣģ��
declare @sysfriendid				varchar(20)	set @sysfriendid 				= 'farmgirl'
declare @binsert		int,
		@dateid			varchar(8),
		@loop			int,
		@idx			int,
		@gameid 		varchar(20),
		@ttsalecoin		int,
		@lmsalecoin		int,			@lmrank			int,	@lmcnt			int,
		@l1gameid		varchar(40),	@l1itemcode		int,	@l1acc1			int,	@l1acc2			int,	@l1salecoin		int,	@l1kakaonickname	varchar(40),	 @l1kakaoprofile varchar(512),
		@l2gameid		varchar(40),	@l2itemcode		int,	@l2acc1			int,	@l2acc2			int,	@l2salecoin		int,	@l2kakaonickname	varchar(40),	 @l2kakaoprofile varchar(512),
		@l3gameid		varchar(40),	@l3itemcode		int,	@l3acc1			int,	@l3acc2			int,	@l3salecoin		int,	@l3kakaonickname	varchar(40),	 @l3kakaoprofile varchar(512)

set @dateid		= Convert(varchar(8), Getdate(), 112)
set @loop 		= 3000
set @idx 		= -1
set @binsert	= -1
set @lmsalecoin = 0		set @lmrank 	= 1		set @lmcnt = 0
set @l1gameid 	= ''	set @l1itemcode = 1		set @l1acc1 = -1		set @l1acc2 = -1		set @l1salecoin = 0
set @l2gameid 	= ''	set @l2itemcode = 1		set @l2acc1 = -1		set @l2acc2 = -1		set @l2salecoin = 0
set @l3gameid 	= ''	set @l3itemcode = 1		set @l3acc1 = -1		set @l3acc2 = -1		set @l3salecoin = 0


DECLARE @tTempTableList TABLE(
	rank			int,
	gameid			varchar(20),
	itemcode		int,
	acc1			int,
	acc2			int,
	ttsalecoin		int,
	kakaonickname	varchar(40),
	kakaoprofile 	varchar(512)
);

select @idx = isnull(idxStart, 0) from dbo.tFVUserMasterSchedule where dateid = @dateid
--select 'DEBUG �о����', @dateid dateid, @idx idx
set @binsert = @idx

-- 1. ģ�� ��ŷ Ŀ���� �о����.
declare curUserMaster Cursor for
select idx, gameid, ttsalecoin from dbo.tFVUserMaster
where idx > @idx
order by idx asc

-- 2. Ŀ������
open curUserMaster

-- 3. Ŀ�� ���
Fetch next from curUserMaster into @idx, @gameid, @ttsalecoin
while @@Fetch_status = 0
	Begin
		--------------------------------------
		-- ģ�� ����Ʈ ���� �ӽ� ���̺� Ŭ����.
		--------------------------------------
		delete from @tTempTableList

		---------------------------------
		-- ģ�� ����Ʈ + �ڱ� �Է�.
		---------------------------------
		-- ģ����ŷ.
		insert into @tTempTableList(                          rank, gameid,       itemcode,       acc1,       acc2, ttsalecoin, kakaonickname, kakaoprofile)
		select rank() over(order by ttsalecoin desc) as rank, gameid, anirepitemcode, anirepacc1, anirepacc2, ttsalecoin, kakaonickname, kakaoprofile from dbo.tFVUserMaster
		where gameid in (select friendid from dbo.tFVUserFriend where (gameid = @gameid and friendid != @sysfriendid and state = @USERFRIEND_STATE_FRIEND)
						union
						select @gameid)
			  and ttsalecoin > 0
		--select 'DEBUG ', * from @tTempTableList

		-- �������� ��ŷ �����ϱ�.
		set @l1kakaonickname 	= ''
		set @l1kakaoprofile 	= ''
		set @l2kakaonickname 	= ''
		set @l2kakaoprofile 	= ''
		set @l3kakaonickname 	= ''
		set @l3kakaoprofile 	= ''
		select @l1gameid = gameid, @l1itemcode = itemcode, @l1acc1 = acc1, @l1acc2 = acc2, @l1salecoin = ttsalecoin, @l1kakaonickname = kakaonickname, @l1kakaoprofile = kakaoprofile from @tTempTableList where rank = 1
		select @l2gameid = gameid, @l2itemcode = itemcode, @l2acc1 = acc1, @l2acc2 = acc2, @l2salecoin = ttsalecoin, @l2kakaonickname = kakaonickname, @l2kakaoprofile = kakaoprofile from @tTempTableList where rank = 2
		select @l3gameid = gameid, @l3itemcode = itemcode, @l3acc1 = acc1, @l3acc2 = acc2, @l3salecoin = ttsalecoin, @l3kakaonickname = kakaonickname, @l3kakaoprofile = kakaoprofile from @tTempTableList where rank = 3

		select @lmrank = rank, @lmsalecoin = ttsalecoin from @tTempTableList where gameid = @gameid
		select @lmcnt  = isnull(max(rank), 1) from @tTempTableList

		-------------------------------------
		-- 2. ���� �����ϱ�.
		-------------------------------------
		update dbo.tFVUserMaster
			set
				-- �ڽ��� ��ŷ.
				lmsalecoin = @lmsalecoin, 	lmrank = @lmrank, 			lmcnt = @lmcnt,

				-- ģ�� 1, 2, 3�� ��ŷ.

				l1gameid = @l1gameid, 		l1itemcode = @l1itemcode, 	l1acc1 = @l1acc1, 		l1acc2 = @l1acc2, 	l1salecoin = @l1salecoin, 	l1kakaonickname = @l1kakaonickname, l1kakaoprofile = @l1kakaoprofile,
				l2gameid = @l2gameid, 		l2itemcode = @l2itemcode, 	l2acc1 = @l2acc1, 		l2acc2 = @l2acc2, 	l2salecoin = @l2salecoin,	l2kakaonickname = @l2kakaonickname, l2kakaoprofile = @l2kakaoprofile,
				l3gameid = @l3gameid, 		l3itemcode = @l3itemcode, 	l3acc1 = @l3acc1, 		l3acc2 = @l3acc2, 	l3salecoin = @l3salecoin,	l3kakaonickname = @l3kakaonickname, l3kakaoprofile = @l3kakaoprofile,

				-- �ʱ�ȭ.
				ttsalecoinbkup 	= ttsalecoinbkup + @ttsalecoin
		where gameid = @gameid

		-------------------------------------
		-- 3. üũ����Ʈ �α�
		-------------------------------------
		if(@binsert = -1)
			begin
				--select 'DEBUG �ű� > ��ŷ�ϱ�', @idx idx
				insert into dbo.tFVUserMasterSchedule(dateid,  idxStart)
				values(                            @dateid, @idx)

				set @binsert = 1
			end
		else if(@idx % @loop = 0)
			begin
				--select 'DEBUG �߰� > ��ŷ�ϱ�', @idx idx
				update tUserMasterSchedule set idxStart = @idx where dateid = @dateid
			end
		Fetch next from curUserMaster into @idx, @gameid, @ttsalecoin
	end

--select 'DEBUG �Ϸ� > ��ŷ�ϱ�', @idx idx
update tUserMasterSchedule set idxStart = @idx where dateid = @dateid

----------------------------------------
--	���������� Ŭ�����ϱ�.
----------------------------------------
select @idx = max(idx) from dbo.tFVUserMaster
while(@idx > -1000)
	begin
		--select 'DEBUG ���� ���� Ŭ����', @idx idx
		update dbo.tFVUserMaster set ttsalecoin = 0 where idx >= @idx - 1000 and idx <= @idx
		set @idx =  @idx - 1000
	end


-- 4. Ŀ���ݱ�
close curUserMaster
Deallocate curUserMaster
