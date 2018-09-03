-- use Farm
-- GO
-- delete from dbo.tFVUserRankMaster where dateid in ('20150413')
-- update dbo.tUserMaster set salemoney2 = 123456789000 where gameid = 'xxxx@gmail.com' update dbo.tUserMaster set salemoney2 = 123456789002 where gameid = 'xxxx2@gmail.com' update dbo.tUserMaster set salemoney2 = 123456789003 where gameid = 'xxxx3@gmail.com'
-- select * from dbo.tFVUserRankMaster
-- select * from dbo.tFVUserRankSub
-- select * from dbo.tUserMaster where gameid in ('xxxx@gmail.com', 'xxxx3@gmail.com')
-- update dbo.tUserMaster set salemoney2 = 10 where gameid in ('xxxx@gmail.com', 'xxxx3@gmail.com')
-- select top 1000 rank() over(order by salemoney2 desc) as rank, gameid, salemoney2, bestani, nickname from dbo.tUserMaster where salemoney2 > 0

--------------------------------------------
-- SQL Server ������Ʈ(���� �����־���Ѵ�.)
-- ���� ������ 1���� ������ ����� �����Ѵ�.
---------------------------------------------
-- ��������� ���� 23�� 00�� 00�ʿ� ����
-- ���� ������ ó��
declare @USERFRIEND_STATE_FRIEND	int			set	@USERFRIEND_STATE_FRIEND	= 2;		-- 2 : ��ȣģ��
declare @dateid			varchar(8),
		@idx			int,
		@gameid 		varchar(60),
		@salemoney2		bigint,
		@rank			int,
		@sendid 		varchar(60)

set @dateid		= Convert(varchar(8), Getdate(), 112)
set @idx 		= -1


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
		select top 1000 rank() over(order by salemoney2 desc) as rank, @dateid, gameid, salemoney2, bestani, nickname from dbo.tUserMaster where salemoney2 > 0

		-- 1. ��ŷ Ŀ���� �о����.
		declare curUserRanking Cursor for
		select top 1000 rank() over(order by salemoney2 desc) as rank, gameid from dbo.tUserMaster where salemoney2 > 0

		-- 2. Ŀ������
		open curUserRanking

		-- 3. Ŀ�� ���
		Fetch next from curUserRanking into @rank, @gameid
		while @@Fetch_status = 0
			Begin


				----------------------------
				-- 	1 ~  10. 5,000 ����
				--	   ~  30. 2,500 ����
				--	   ~  50. 1,000 ����
				--	   ~ 100.    250 ����
				----------------------------
				set @sendid = '��ŷ' + ltrim(rtrim(@rank))
				--select 'DEBUG ', @rank rank, @gameid gameid, @sendid sendid


				if(@rank >= 1 and @rank <= 10)
					begin
						exec spu_FVSubGiftSend 2, 3015,  5000, @sendid, @gameid, ''
					end
				else if(          @rank <= 30)
					begin
						exec spu_FVSubGiftSend 2, 3015,   2500, @sendid, @gameid, ''
					end
				else if(          @rank <= 50)
					begin
						exec spu_FVSubGiftSend 2, 3015,   1000, @sendid, @gameid, ''
					end
				else if(          @rank <= 100)
					begin
						exec spu_FVSubGiftSend 2, 3015,    250, @sendid, @gameid, ''
					end

				Fetch next from curUserRanking into @rank, @gameid
			end

		exec spu_FVUserRankScheduleRecord @dateid, 1

		-- 4. Ŀ���ݱ�
		close curUserRanking
		Deallocate curUserRanking
	end


----------------------------------------
--	���������� Ŭ�����ϱ�.
----------------------------------------
select @idx = max(idx) from dbo.tUserMaster
while(@idx > -1000)
	begin
		--select 'DEBUG ���� ���� Ŭ����', @idx idx
		update dbo.tUserMaster
			set
				salemoney2 = 0
		where idx >= @idx - 1000 and idx <= @idx
		set @idx =  @idx - 1000
	end

