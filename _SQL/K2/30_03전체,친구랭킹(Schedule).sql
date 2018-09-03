-- use Farm
-- GO
-- update dbo.tUserMaster set salemoney = 123456789000 where gameid = 'xxxx' update dbo.tUserMaster set salemoney = 123456789002 where gameid = 'xxxx@gmail.com' update dbo.tUserMaster set salemoney = 123456789003 where gameid = 'xxxx3'
-- delete from dbo.tFVUserMasterSchedule where dateid = '20150209'
-- update dbo.tFVUserMasterSchedule set idxStart = 1 where dateid = '20150209'
-- select * from dbo.tFVUserMasterSchedule where dateid = '20150209'

--------------------------------------------
-- SQL Server 에이전트(먼저 켜져있어야한다.)
-- 유저 정보를 1주일 단위로 백업을 진행한다.
---------------------------------------------
-- 매주월요일 시작 00시 00분 01초에 시작
-- 묶음 단위로 처리
declare @USERFRIEND_STATE_FRIEND	int			set	@USERFRIEND_STATE_FRIEND	= 2;		-- 2 : 상호친구
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
-- 1. 전체랭킹
--------------------------------------------------------
--select 'DEBUG ', @dateid dateid
-- 1. 랭킹이 산출 되었는가?
if(exists(select top 1 * from dbo.tFVUserRankMaster where dateid = @dateid))
	begin
		set @dateid = @dateid
		--select 'DEBUG 랭킹 산출 이미함'
	end
else
	begin
		--select 'DEBUG 랭킹 산출 하기', @dateid dateid
		-- 랭킹데이타 백업
		insert into dbo.tFVUserRankSub(rank, dateid8, gameid, salemoney, bestani, nickname)
		select top 1000 rank() over(order by salemoney desc) as rank, @dateid, gameid, salemoney, bestani, nickname from dbo.tUserMaster where salemoney > 0

		-- 1. 랭킹 커서로 읽어오기.
		declare curUserRanking Cursor for
		select top 1000 rank() over(order by salemoney desc) as rank, gameid from dbo.tUserMaster where salemoney > 0

		-- 2. 커서오픈
		open curUserRanking

		-- 3. 커서 사용
		Fetch next from curUserRanking into @rank, @gameid
		while @@Fetch_status = 0
			Begin


				----------------------------
				-- 	1 ~  10. 10,000 결정
				--	  ~  30.  5,000 결정
				--	  ~  50.  2,000 결정
				--	  ~ 100.    500 결정
				--	  ~1000.    200 결정
				----------------------------
				set @sendid = '랭킹' + ltrim(rtrim(@rank))
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

		-- 4. 커서닫기
		close curUserRanking
		Deallocate curUserRanking
	end

--------------------------------------------------------
-- 2. 친구랭킹
--------------------------------------------------------
DECLARE @tTempTableList TABLE(
	rank			int,
	gameid			varchar(60),
	bestani			int,
	salemoney		bigint
);

select @idx = isnull(idxStart, 0) from dbo.tFVUserMasterSchedule where dateid = @dateid
--select 'DEBUG 읽어오기', @dateid dateid, @idx idx
set @binsert = @idx

-- 1. 친구 랭킹 커서로 읽어오기.
declare curUserMaster Cursor for
select idx, gameid, salemoney from dbo.tUserMaster
where idx > @idx
order by idx asc

-- 2. 커서오픈
open curUserMaster

-- 3. 커서 사용
Fetch next from curUserMaster into @idx, @gameid, @salemoney
while @@Fetch_status = 0
	Begin
		--------------------------------------
		-- 친구 리스트 담을 임시 테이블 클리어.
		--------------------------------------
		delete from @tTempTableList
		set @lmsalemoney = 0	set @lmrank 	= 1		set @lmcnt = 0
		set @l1gameid 	= ''	set @l1bestani = -1		set @l1salemoney = 0
		set @l2gameid 	= ''	set @l2bestani = -1		set @l2salemoney = 0
		set @l3gameid 	= ''	set @l3bestani = -1		set @l3salemoney = 0

		---------------------------------
		-- 친구 리스트 + 자기 입력.
		---------------------------------
		-- 친구랭킹.
		insert into @tTempTableList(                   rank, gameid, bestani, salemoney)
		select rank() over(order by salemoney desc) as rank, gameid, bestani, salemoney from dbo.tUserMaster
		where gameid in (select friendid from dbo.tFVUserFriend where (gameid = @gameid and state = @USERFRIEND_STATE_FRIEND)
						union
						select @gameid)
			  and salemoney > 0
		--select 'DEBUG ', * from @tTempTableList

		-- 순위별로 랭킹 세팅하기.
		select @l1gameid = gameid, @l1bestani = bestani, @l1salemoney = salemoney from @tTempTableList where rank = 1
		select @l2gameid = gameid, @l2bestani = bestani, @l2salemoney = salemoney from @tTempTableList where rank = 2
		select @l3gameid = gameid, @l3bestani = bestani, @l3salemoney = salemoney from @tTempTableList where rank = 3

		select @lmrank = rank, @lmsalemoney = salemoney from @tTempTableList where gameid = @gameid
		select @lmcnt  = isnull(max(rank), 1) from @tTempTableList

		-------------------------------------
		-- 2. 값을 세팅하기.
		-------------------------------------
		update dbo.tUserMaster
			set
				-- 자신의 랭킹.
				rankresult	= 1,
				lmsalemoney = @lmsalemoney, lmrank = @lmrank, 			lmcnt = @lmcnt,

				-- 친구 1, 2, 3위 랭킹.
				l1gameid = @l1gameid, 		l1bestani = @l1bestani, 	l1salemoney = @l1salemoney,
				l2gameid = @l2gameid, 		l2bestani = @l2bestani, 	l2salemoney = @l2salemoney,
				l3gameid = @l3gameid, 		l3bestani = @l3bestani, 	l3salemoney = @l3salemoney,

				-- 초기화.
				salemoneybkup 	= salemoneybkup + @salemoney
		where gameid = @gameid

		-------------------------------------
		-- 3. 체크포인트 두기
		-------------------------------------
		if(@binsert = -1)
			begin
				--select 'DEBUG 신규 > 마킹하기', @idx idx
				insert into dbo.tFVUserMasterSchedule(dateid,  idxStart)
				values(                              @dateid, @idx)

				set @binsert = 1
			end
		else if(@idx % @loop = 0)
			begin
				--select 'DEBUG 중간 > 마킹하기', @idx idx
				update tFVUserMasterSchedule set idxStart = @idx where dateid = @dateid
			end
		Fetch next from curUserMaster into @idx, @gameid, @salemoney
	end

--select 'DEBUG 완료 > 마킹하기', @idx idx
update tFVUserMasterSchedule set idxStart = @idx where dateid = @dateid


----------------------------------------
--	유저마스터 클리어하기.
----------------------------------------
select @idx = max(idx) from dbo.tUserMaster
while(@idx > -1000)
	begin
		--select 'DEBUG 유저 정보 클리어', @idx idx
		update dbo.tUserMaster
			set
				salemoney = 0
		where idx >= @idx - 1000 and idx <= @idx
		set @idx =  @idx - 1000
	end

-- 4. 커서닫기
close curUserMaster
Deallocate curUserMaster
