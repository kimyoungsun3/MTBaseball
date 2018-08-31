-- SQL Server ������Ʈ(���� �����־���Ѵ�.)
--  > �۾�(���, ��ȹ, �ð�) 
-- �˻��ϱ� 
--   	select * from dbo.tGiftList order by giftdate desc
-- 		select * from dbo.tGiftList where giftid = '������(adminid)'
--------------------------------------------
-- Ȩ������_����Ÿ ���
-- tUserMasterBackupSchedule
-- ���� ������ 1���� ������ ����� �����Ѵ�.
---------------------------------------------
-- ���ֿ����� ���� 00�� 00�� 01�ʿ� ����
-- ���� ������ ó��
-- select * from tUserMasterSchedule
-- select top 5 * from tUserMaster order by idx desc
-- select top 5 * from tUserMaster where idx > 47699 order by idx asc
-- select top 5 * from tUserMaster order by idx asc
declare @idxStart	int,
		@idxEnd		int,
		@interval	int,
		@dateid		varchar(8)
declare @idxStart2	int
declare @gameid varchar(20)
declare @loop int					
declare @rank int
set @dateid	= Convert(varchar(8),Getdate(),112)

select @idxStart = isnull(idxStart, 0) from dbo.tUserMasterSchedule where dateid = @dateid
set @idxStart = isnull(@idxStart, -1)
select @idxEnd = max(idx) from dbo.tUserMaster
set @interval = 3000
--select 'DEBUG ', @dateid, @idxStart, @idxEnd, @interval

------------------------------------------------------
-- �ӽ�, �ӽ�, ��Ʋ > ��Ʋ�� ����
-- ��Ʋ�� �� 9�� ����
------------------------------------------------------

-- �ӽ�
declare curRankMachine Cursor for
select top 5 rank() over(order by machinepoint desc) as rank, gameid from dbo.tUserMaster where machinepoint > 0

open curRankMachine
Fetch next from curRankMachine into @rank, @gameid
while @@Fetch_status = 0
	begin
		set @loop = 0
		while(@loop < 3)
			begin
				exec spu_GiftSend @gameid, 6000, 'SangSang', -1, 0, 'adminid', 1
				exec spu_GiftSend @gameid, 6001, 'SangSang', -1, 0, 'adminid', 1
				exec spu_GiftSend @gameid, 6002, 'SangSang', -1, 0, 'adminid', 1
				exec spu_GiftSend @gameid, 6003, 'SangSang', -1, 0, 'adminid', 1
				exec spu_GiftSend @gameid, 6004, 'SangSang', -1, 0, 'adminid', 1		
				set @loop = @loop + 1
			end
		Fetch next from curRankMachine into @rank, @gameid
	end
close curRankMachine
Deallocate curRankMachine

-- �ϱ�
declare curRankMemo Cursor for				
select top 5 rank() over(order by memorialpoint desc) as rank, gameid from dbo.tUserMaster where memorialpoint > 0

open curRankMemo
Fetch next from curRankMemo into @rank, @gameid
while @@Fetch_status = 0
	begin
		set @loop = 0
		while(@loop < 3)
			begin
				exec spu_GiftSend @gameid, 6000, 'SangSang', -1, 0, 'adminid', 1
				exec spu_GiftSend @gameid, 6001, 'SangSang', -1, 0, 'adminid', 1
				exec spu_GiftSend @gameid, 6002, 'SangSang', -1, 0, 'adminid', 1
				exec spu_GiftSend @gameid, 6003, 'SangSang', -1, 0, 'adminid', 1
				exec spu_GiftSend @gameid, 6004, 'SangSang', -1, 0, 'adminid', 1		
				set @loop = @loop + 1
			end
		Fetch next from curRankMemo into @rank, @gameid
	end
close curRankMemo
Deallocate curRankMemo

-- ��Ʋ
declare curRankBattle Cursor for				
select top 5 rank() over(order by btwin desc, bttotal asc) as rank, gameid from dbo.tUserMaster where btwin > 0

open curRankBattle
Fetch next from curRankBattle into @rank, @gameid
while @@Fetch_status = 0
	begin
		set @loop = 0
		while(@loop < 3)
			begin
				exec spu_GiftSend @gameid, 6000, 'SangSang', -1, 0, 'adminid', 1
				exec spu_GiftSend @gameid, 6001, 'SangSang', -1, 0, 'adminid', 1
				exec spu_GiftSend @gameid, 6002, 'SangSang', -1, 0, 'adminid', 1
				exec spu_GiftSend @gameid, 6003, 'SangSang', -1, 0, 'adminid', 1
				exec spu_GiftSend @gameid, 6004, 'SangSang', -1, 0, 'adminid', 1		
				set @loop = @loop + 1
			end
		Fetch next from curRankBattle into @rank, @gameid
	end
close curRankBattle
Deallocate curRankBattle

------------------------------------------------------
-- ��ŷ ��� �� ���׹̳� ����
------------------------------------------------------
-- 0. ��ŷ ���
insert into dbo.tRankTotal(rank,  dateid, gamemode, gameid, machinepoint, memorialpoint, btwin, bttotal, btlose) 
select top 10 rank() over(order by machinepoint desc)       as rank, @dateid, 2,        gameid, machinepoint, memorialpoint, btwin, bttotal, bttotal - btwin from dbo.tUserMaster where machinepoint > 0

insert into dbo.tRankTotal(rank,  dateid, gamemode, gameid, machinepoint, memorialpoint, btwin, bttotal, btlose) 
select top 10 rank() over(order by memorialpoint desc)      as rank, @dateid, 3,        gameid, machinepoint, memorialpoint, btwin, bttotal, bttotal - btwin from dbo.tUserMaster where memorialpoint > 0

insert into dbo.tRankTotal(rank,  dateid, gamemode, gameid, machinepoint, memorialpoint, btwin, bttotal, btlose) 
select top 10 rank() over(order by btwin desc, bttotal asc) as rank, @dateid, 5,        gameid, machinepoint, memorialpoint, btwin, bttotal, bttotal - btwin from dbo.tUserMaster where btwin > 0

while @idxStart < @idxEnd
	begin
		-- select top 10 machinepoint, memorialpoint, btwin, bttotal, btlose from dbo.tUserMaster
		-- select 'DEBUG ', str(@idxStart) + ' ~ ' + str(@idxStart + @interval)
		set @idxStart2 = @idxStart + @interval
	
		-- 1. ����Ʈ �������
		update dbo.tUserMaster
			set
				trainpointbkup 		= trainpointbkup + trainpoint,
				machinepointbkup 	= machinepointbkup + machinepoint, 
				memorialpointbkup 	= memorialpointbkup + memorialpoint, 
				soulpointbkup 		= soulpointbkup + soulpoint,
				btwinbkup 			= btwinbkup + btwin, 
				bttotalbkup 		= bttotalbkup + bttotal, 
				btlosebkup			= btlosebkup + btlose
		where idx >= @idxStart and idx < @idxStart2

		-- 2. ����Ʈ Ŭ����, ���׹̳� �ƽ�ó��
		update dbo.tUserMaster
			set
				trainpoint 			= 0,
				machinepoint 		= 0, 
				memorialpoint 		= 0, 
				soulpoint 			= 0,
				btwin 				= 0, 
				bttotal 			= 0, 
				btlose 				= 0,				
				actionCount			= actionMax
		where idx >= @idxStart and idx < @idxStart2

		-- 3. üũ����Ʈ �α�
		--if(not exists(select dateid from dbo.tUserMasterSchedule where dateid = @dateid))
		if(@idxStart = -1)
			begin
				insert into dbo.tUserMasterSchedule(dateid, idxStart) values(@dateid, @idxStart2)
			end
		else
			begin
				update tUserMasterSchedule
			 	set
					idxStart = @idxStart2
				where dateid = @dateid
			end

		set @idxStart = @idxStart2
	end


/*
-- SQL Server ������Ʈ(���� �����־���Ѵ�.)
--  > �۾�(���, ��ȹ, �ð�) 
--------------------------------------------
-- Ȩ������_����Ÿ ���
-- tUserMasterBackupSchedule
-- ���� ������ 1���� ������ ����� �����Ѵ�.
---------------------------------------------
-- ���ֿ����� ���� 00�� 00�� 01�ʿ� ����
-- ���� ������ ó��
-- select * from tUserMasterSchedule
-- select top 5 * from tUserMaster order by idx desc
-- select top 5 * from tUserMaster where idx > 47699 order by idx asc
-- select top 5 * from tUserMaster order by idx asc
declare @idxStart	int,
		@idxEnd		int,
		@interval	int,
		@dateid		varchar(8)
declare @idxStart2	int
set @dateid	= Convert(varchar(8),Getdate(),112)

select @idxStart = isnull(idxStart, 0) from dbo.tUserMasterSchedule where dateid = @dateid
set @idxStart = isnull(@idxStart, -1)
select @idxEnd = max(idx) from dbo.tUserMaster
set @interval = 3000
--select 'DEBUG ', @dateid, @idxStart, @idxEnd, @interval

while @idxStart < @idxEnd
	begin
		-- select top 10 machinepoint, memorialpoint, btwin, bttotal, btlose from dbo.tUserMaster
		-- select 'DEBUG ', str(@idxStart) + ' ~ ' + str(@idxStart + @interval)
		set @idxStart2 = @idxStart + @interval
	
		-- 1. ����Ʈ �������
		update dbo.tUserMaster
			set
				trainpointbkup 		= trainpointbkup + trainpoint,
				machinepointbkup 	= machinepointbkup + machinepoint, 
				memorialpointbkup 	= memorialpointbkup + memorialpoint, 
				soulpointbkup 		= soulpointbkup + soulpoint,
				btwinbkup 			= btwinbkup + btwin, 
				bttotalbkup 		= bttotalbkup + bttotal, 
				btlosebkup			= btlosebkup + btlose
		where idx >= @idxStart and idx < @idxStart2

		-- 2. ����Ʈ Ŭ����
		update dbo.tUserMaster
			set
				trainpoint 			= 0,
				machinepoint 		= 0, 
				memorialpoint 		= 0, 
				soulpoint 			= 0,
				btwin 				= 0, 
				bttotal 			= 0, 
				btlose 				= 0
		where idx >= @idxStart and idx < @idxStart2

		-- 3. üũ����Ʈ �α�
		--if(not exists(select dateid from dbo.tUserMasterSchedule where dateid = @dateid))
		if(@idxStart = -1)
			begin
				insert into dbo.tUserMasterSchedule(dateid, idxStart) values(@dateid, @idxStart2)
			end
		else
			begin
				update tUserMasterSchedule
			 	set
					idxStart = @idxStart2
				where dateid = @dateid
			end

		set @idxStart = @idxStart2
	end
*/

/*
---------------------------------------------
--		1. �������� ���̺�
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserTTT', N'U') IS NOT NULL
	DROP TABLE dbo.tUserTTT;
GO

create table dbo.tUserTTT(
	--(����)
	idx			int 					IDENTITY(1, 1),
	gameid		varchar(20),
	
	--�����
	trainpoint		int					default(0),
	machinepoint	int					default(0), 
	memorialpoint	int					default(0), 
	soulpoint		int					default(0),
	bttotal			int					default(0), 
	btwin			int					default(0), 
	btlose			int					default(0), 

	-- ����忡 ���� ���
	trainpointbkup		int				default(0),
	machinepointbkup	int				default(0),			
	memorialpointbkup	int				default(0),					
	soulpointbkup		int				default(0),			
	bttotalbkup			int				default(0),						
	btwinbkup			int				default(0),						
	btlosebkup			int				default(0),			

	-- Constraint
	CONSTRAINT pk_tUserTTT_gameid	PRIMARY KEY(gameid)	
)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tUserTTT_idx')
   DROP INDEX tUserTTT.idx_tUserTTT_idx
GO
CREATE INDEX idx_tUserTTT_idx ON tUserTTT (idx)
GO

-- ���
-- update dbo.tUserTTT set trainpointbkup = trainpointbkup + trainpoint where idx > start and idx <= end
-- Ŭ����
-- update dbo.tUserTTT set trainpoint = 0 where idx > start and idx <= end


---------------------------------------------
--	��������췯 ����Ʈ
--	(���� ������ �Ұ��)
---------------------------------------------
IF OBJECT_ID (N'dbo.tUserTTTSchedule', N'U') IS NOT NULL
	DROP TABLE dbo.tUserTTTSchedule;
GO

create table dbo.tUserTTTSchedule(
	--(����)
	idx				int					identity(1, 1),
	dateid			varchar(8),										-- 20121118
	idxStart		int					default(0),
	writedate		datetime			default(getdate()), 		-- �ۼ���

	-- Constraint
	CONSTRAINT pk_tUserTTTSchedule_dateid	PRIMARY KEY(dateid)	
)
GO

-- if(not exist(select dateid from dbo.tUserTTTSchedule where dateid = '20121118'))
-- insert into dbo.tUserTTTSchedule(dateid, idxEnd) values('20121118', 1000)
-- update tUserTTTSchedule
-- 	set
--		idxStart = idx
-- where dateid = '20121118'
-- select * from dbo.tUserTTTSchedule

---------------------------------------------
--		3. �������� ���̺� ����Ÿ �ֱ�
---------------------------------------------
-- ������ ��ŷ ����Ÿ �Է�
declare @gameid				varchar(20),
		@machinepoint 		int,
		@memorialpoint 		int,
		@bttotal 			int,
		@btwin 				int
declare @idxStart 			int,
		@idxEnd 			int
select @idxStart = isnull(max(idx), 0) from dbo.tUserTTT
--set @idxStart = 1
set @idxEnd = @idxStart + 10000--0--0
select ltrim(rtrim(@idxStart)) + ' ~ ' + ltrim(rtrim(@idxEnd))

while @idxStart < @idxEnd
	begin
		set @gameid 			= 'SangSang' + ltrim(rtrim(@idxStart))
		set @machinepoint 		= Convert(int, ceiling(RAND() * 30000)) 
		set @memorialpoint 		= Convert(int, ceiling(RAND() * 30000)) 
		set @bttotal = Convert(int, ceiling(RAND() * 30000)) 
		set @btwin = Convert(int, ceiling(RAND() * @bttotal)) 

		if(not exists(select * from dbo.tUserTTT where gameid = @gameid))
			begin
				insert into dbo.tUserTTT(gameid, machinepoint, memorialpoint, bttotal, btwin, btlose)
				values(@gameid, @machinepoint, @memorialpoint, @bttotal, @btwin, @bttotal - @btwin)
			end
		else
			begin
				update dbo.tUserTTT
				set
					machinepoint = machinepoint + @machinepoint,
					memorialpoint = memorialpoint + @memorialpoint, 
					bttotal = bttotal + @bttotal, 
					btwin = btwin + @btwin, 
					btlose = btlose + (@bttotal - @btwin)
				where gameid = @gameid
			end
		
		set @idxStart = @idxStart + 1
	end

--------------------------------------------
-- ��ŷ�ʱ�ȭ
-- tUserTTTBackupSchedule
-- ���� ������ 1���� ������ ����� �����Ѵ�.
---------------------------------------------
-- ���ֿ����� ���� 00�� 00�� 01�ʿ� ����
-- ���� ������ ó��
-- select * from tUserTTTSchedule
-- select top 5 * from tUserTTT order by idx desc
-- select top 5 * from tUserTTT where idx > 47699 order by idx asc
-- select top 5 * from tUserTTT order by idx asc
declare @idxStart	int,
		@idxEnd		int,
		@interval	int,
		@dateid		varchar(8)
declare @idxStart2	int
set @dateid	= Convert(varchar(8),Getdate(),112)

select @idxStart = isnull(idxStart, 0) from dbo.tUserTTTSchedule where dateid = @dateid
set @idxStart = isnull(@idxStart, -1)
select @idxEnd = max(idx) from dbo.tUserTTT
set @interval = 3000
--select 'DEBUG ', @dateid, @idxStart, @idxEnd, @interval

while @idxStart < @idxEnd
	begin
		-- select top 10 machinepoint, memorialpoint, btwin, bttotal, btlose from dbo.tUserTTT
		-- select 'DEBUG ', str(@idxStart) + ' ~ ' + str(@idxStart + @interval)
		set @idxStart2 = @idxStart + @interval
	
		-- 1. ����Ʈ �������
		update dbo.tUserTTT
			set
				trainpointbkup 		= trainpointbkup + trainpoint,
				machinepointbkup 	= machinepointbkup + machinepoint, 
				memorialpointbkup 	= memorialpointbkup + memorialpoint, 
				soulpointbkup 		= soulpointbkup + soulpoint,
				btwinbkup 			= btwinbkup + btwin, 
				bttotalbkup 		= bttotalbkup + bttotal, 
				btlosebkup			= btlosebkup + btlose
		where idx >= @idxStart and idx < @idxStart2

		-- 2. ����Ʈ Ŭ����
		update dbo.tUserTTT
			set
				trainpoint 			= 0,
				machinepoint 		= 0, 
				memorialpoint 		= 0, 
				soulpoint 			= 0,
				btwin 				= 0, 
				bttotal 			= 0, 
				btlose 				= 0
		where idx >= @idxStart and idx < @idxStart2

		-- 3. üũ����Ʈ �α�
		--if(not exists(select dateid from dbo.tUserTTTSchedule where dateid = @dateid))
		if(@idxStart = -1)
			begin
				insert into dbo.tUserTTTSchedule(dateid, idxStart) values(@dateid, @idxStart2)
			end
		else
			begin
				update tUserTTTSchedule
			 	set
					idxStart = @idxStart2
				where dateid = @dateid
			end

		set @idxStart = @idxStart2
	end

*/