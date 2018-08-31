-- ��Ż� ���а�
declare @IPHONE					int					
set @IPHONE						= 7

-- 1-1. ���� ����
declare @gameid 				varchar(20)
declare @actiontime				datetime
declare @actioncount			int
declare	@actionmax				int
declare @pushid					varchar(256)
declare @condate				datetime
declare @market					int

declare @nActPerMin				bigint
declare @nActCount				int
declare @dActTime				datetime
declare @LOOP_TIME_ACTION		int 			set @LOOP_TIME_ACTION 				= 3*60			-- �ൿ�� 3�п� �Ѱ��� ä����
declare @dateid10				varchar(10)
declare @cnt 					int
declare @cnt2 					int
declare @loop					int				

-- 1-2. ���� �ʱ�ȭ
set @nActPerMin 		= @LOOP_TIME_ACTION
set @cnt 				= 0
set @cnt2 				= 0
set @loop				= 0


-- 2-1. Ŀ�� ����(�α����ؼ� ��ϵȰ�)
declare curActionCheck Cursor for
select gameid, actiontime, actioncount, actionmax, pushid, condate, market from dbo.tUserMaster 
where gameid in (select gameid from dbo.tActionScheduleData)


-- 2-2. Ŀ������
open curActionCheck

-- 2-3. Ŀ�� ���
Fetch next from curActionCheck into @gameid, @actiontime, @actioncount, @actionmax, @pushid, @condate, @market
while @@Fetch_status = 0
	Begin
			--select 'DEBUG > ', @gameid
			--------------------------------------------
			--	1�ܰ� �ൿġ�� �Ҹ�Ȼ��� and 1�� ��
			--------------------------------------------
			if(@actioncount < @actionmax)
				begin
					---------------------------------------
					-- 2�ܰ� �ൿġ�� �����ΰ�?
					---------------------------------------
					set @nActCount = datediff(s, @actiontime, getdate())/@nActPerMin
					set @dActTime = DATEADD(s, @nActCount*@nActPerMin, @actiontime)
					set @actioncount = @actioncount + @nActCount
					if(@actioncount >= @actionmax)
						begin
							---------------------------------------
							-- 3�ܰ� Push�߼�, ����Ÿ ����
							---------------------------------------
							--select 'DEBUG 1���� > Push, �α׻���, cnt+1', @gameid, @actiontime, @actioncount, @actionmax, @pushid, @condate
							
							-- Push�� �Է��ϱ�
							if(@market = @IPHONE)
								begin
									insert into dbo.tUserPushiPhone(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) 
									values('SangSang', @gameid, @pushid, 1, 99, '[Ȩ������(' + @gameid + ')]', '���׹̳� ��� ���� �Ǿ����ϴ�', '')
								end
							else
								begin							
									insert into dbo.tUserPushAndroid(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) 
									values('SangSang', @gameid, @pushid, 1, 99, '[Ȩ������(' + @gameid + ')]', '���׹̳� ��� ���� �Ǿ����ϴ�', '')
								end
							
							-- �α� ���� > �ؿ��� �ϰ� ó��
							delete from dbo.tActionScheduleData where gameid = @gameid
							
							-- ī���� ����
							set @cnt = @cnt + 1
						end
					else
						begin
							--select 'DEBUG 2���� > 2�ð� �Ŀ� �ٽ� ����!!!', @gameid, @actiontime, @actioncount, @actionmax, @pushid, @condate
							
							set @cnt2 = @cnt2
						end
				end
			else
				begin
					--select 'DEBUG 3 ���� �����̳�(�˾Ƽ���´�) > ����, FullȮ�� > No Push', @gameid, @actiontime, @actioncount, @actionmax, @pushid, @condate
					
					-- �α� ����
					delete from dbo.tActionScheduleData where gameid = @gameid
					
					-- ī���� ����
					set @cnt2 = @cnt2 + 1
				end
			
		set @loop = @loop + 1
		Fetch next from curActionCheck into @gameid, @actiontime, @actioncount, @actionmax, @pushid, @condate, @market
	end

-- ���׹̳� ��� �ڷḦ �Է��Ѵ�.
set @dateid10 = Convert(varchar(8), getdate(),112) + Convert(varchar(2), getdate(), 108)
if(not exists(select * from dbo.tActionScheduleStatic where dateid10 = @dateid10))
	begin
		insert into dbo.tActionScheduleStatic(dateid10, cnt, cnt2)
		values(@dateid10, @cnt, @cnt2)
	end
else
	begin
		update dbo.tActionScheduleStatic
			set
				cnt		= cnt + @cnt, 
				cnt2	= cnt2 + @cnt2
		where dateid10 = @dateid10
	end

-- 2-4. Ŀ���ݱ�
close curActionCheck
Deallocate curActionCheck