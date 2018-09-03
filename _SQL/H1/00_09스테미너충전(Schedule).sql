-- 통신사 구분값
declare @IPHONE					int					
set @IPHONE						= 7

-- 1-1. 변수 선언
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
declare @LOOP_TIME_ACTION		int 			set @LOOP_TIME_ACTION 				= 3*60			-- 행동력 3분에 한개씩 채워줌
declare @dateid10				varchar(10)
declare @cnt 					int
declare @cnt2 					int
declare @loop					int				

-- 1-2. 변수 초기화
set @nActPerMin 		= @LOOP_TIME_ACTION
set @cnt 				= 0
set @cnt2 				= 0
set @loop				= 0


-- 2-1. 커서 설정(로그인해서 기록된것)
declare curActionCheck Cursor for
select gameid, actiontime, actioncount, actionmax, pushid, condate, market from dbo.tUserMaster 
where gameid in (select gameid from dbo.tActionScheduleData)


-- 2-2. 커서오픈
open curActionCheck

-- 2-3. 커서 사용
Fetch next from curActionCheck into @gameid, @actiontime, @actioncount, @actionmax, @pushid, @condate, @market
while @@Fetch_status = 0
	Begin
			--select 'DEBUG > ', @gameid
			--------------------------------------------
			--	1단계 행동치가 소모된상태 and 1일 전
			--------------------------------------------
			if(@actioncount < @actionmax)
				begin
					---------------------------------------
					-- 2단계 행동치가 만땅인가?
					---------------------------------------
					set @nActCount = datediff(s, @actiontime, getdate())/@nActPerMin
					set @dActTime = DATEADD(s, @nActCount*@nActPerMin, @actiontime)
					set @actioncount = @actioncount + @nActCount
					if(@actioncount >= @actionmax)
						begin
							---------------------------------------
							-- 3단계 Push발송, 데이타 삭제
							---------------------------------------
							--select 'DEBUG 1만땅 > Push, 로그삭제, cnt+1', @gameid, @actiontime, @actioncount, @actionmax, @pushid, @condate
							
							-- Push에 입력하기
							if(@market = @IPHONE)
								begin
									insert into dbo.tUserPushiPhone(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) 
									values('SangSang', @gameid, @pushid, 1, 99, '[홈런리그(' + @gameid + ')]', '스테미너 모두 충전 되었습니다', '')
								end
							else
								begin							
									insert into dbo.tUserPushAndroid(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) 
									values('SangSang', @gameid, @pushid, 1, 99, '[홈런리그(' + @gameid + ')]', '스테미너 모두 충전 되었습니다', '')
								end
							
							-- 로그 삭제 > 밑에서 일괄 처리
							delete from dbo.tActionScheduleData where gameid = @gameid
							
							-- 카운터 증가
							set @cnt = @cnt + 1
						end
					else
						begin
							--select 'DEBUG 2부족 > 2시간 후에 다시 보자!!!', @gameid, @actiontime, @actioncount, @actionmax, @pushid, @condate
							
							set @cnt2 = @cnt2
						end
				end
			else
				begin
					--select 'DEBUG 3 원래 만땅이네(알아서들온다) > 무한, Full확인 > No Push', @gameid, @actiontime, @actioncount, @actionmax, @pushid, @condate
					
					-- 로그 삭제
					delete from dbo.tActionScheduleData where gameid = @gameid
					
					-- 카운터 증가
					set @cnt2 = @cnt2 + 1
				end
			
		set @loop = @loop + 1
		Fetch next from curActionCheck into @gameid, @actiontime, @actioncount, @actionmax, @pushid, @condate, @market
	end

-- 스테미너 통계 자료를 입력한다.
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

-- 2-4. 커서닫기
close curActionCheck
Deallocate curActionCheck