/*
-- use Game4FarmVill4
-- GO

-- exec spu_subFVRankDaJunTest 'xxxx2', '20150312', 99999999999999, 2000000000000, 3000000, 1267977400, 500000, 6000000, 70000000
-- exec spu_subFVRankDaJunTest 'xxxx3', '20150312', 1, 20000000000, 3, 12679774, 5, 60000, 7
-- update dbo.tFVRankDaJun set rkreward = 0 where rkdateid8 = '20150312'


--------------------------------------------
-- [데몬(보상지급하기)] / 00시에 시작
-- 매일 시작 00시 00분 01초에 시작
-- if(어제날짜 > 미지급상태)
-- 1. 이긴팀 점수산정후 등수에 따른 차등 선물지급
-- 	> 이긴팀 인원들 각 점수를 가산점에 따른 재연산
-- 		> 이긴것만 적용 & 진것은 0점처리
-- 	> 재연산된것으로 랭킹 산출
-- 	> 산출된 기준으로 선물차등지급 (홀짝0313_1 ~ 홀짝0313_101)
-- 2. 개인점수 백업후 > 클리어
-- 3. 어제날짜의 보상을 지급처리로 변환
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
-- 1. 어제 미지급 상태점검
--------------------------------------------------------
	select
		@rkreward 		= rkreward,			@rkteam1 		= rkteam1,			@rkteam0 		= rkteam0
	from dbo.tFVRankDaJun where rkdateid8 = @rkdateid8
	--select 'DEBUG ', @rkdateid4 rkdateid4, @rkdateid8 rkdateid8, * from dbo.tFVRankDaJun where rkdateid8 = @rkdateid8

	if(@rkreward = @RANK_REWARD_END)
		begin
			--select 'DEBUG 지급완료 > 스케쥴 종료.'
			return
		end

--------------------------------------------------------
-- 2. 이긴팀 점수 > 재산정
-- 판매수익(0)	200,000,000 	0.000100 	20,000
-- 생산수량(30)	2,000,000 		0.010000 	20,000
-- 목장수익(31)	2,000,000 		0.010000 	20,000
-- 늑대사냥(32)	500 			40.000000 	20,000
-- 친구포인트	200 			50.000000 	10,000
-- 룰렛횟수	2 	900.000000 		1,			800
-- 플레이타임	86,400 			0.100000 	8,640
-- 3. 개인점수 백업후 > 클리어
--------------------------------------------------------
	select @idx = max(idx) from dbo.tFVUserMaster
	while(@idx > -1000)
		begin
			-- --select 'DEBUG 유저 랭킹정보 계산', @idx idx
			update dbo.tFVUserMaster
				set
					-- 1차 백업 데이타를 백업한다.
					rktotal2 		= rktotal,
					rksalemoneybk	= rksalemoney,
					rkproductcntbk	= rkproductcnt,
					rkfarmearnbk	= rkfarmearn,
					rkwolfcntbk		= rkwolfcnt,
					rkfriendpointbk	= rkfriendpoint,
					rkroulettecntbk	= rkroulettecnt,
					rkplaycntbk		= rkplaycnt,

					-- 2차 연산하기.
					rktotal  = FLOOR(case when ((@rkteam1 > @rkteam0 and rkteam = 1) or (@rkteam1 < @rkteam0 and rkteam = 0)) then (rksalemoney*0.0001 + rkproductcnt*0.01 + rkfarmearn*0.01 + rkwolfcnt*40 + rkfriendpoint*50 + rkroulettecnt*900 + rkplaycnt*0.1) else 0 end),

					-- 3차 연산한 데이타를 클리어하기.
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
-- 3. 등수에 따른 차등 선물지급
--------------------------------------------------------
	set @title = case when (@rkteam1 > @rkteam0) then '홀승' else '짝승' end

	-- 1. 랭킹 커서로 읽어오기.
	declare curUserRanking Cursor for
	select rank() over(order by rktotal desc) as rank, gameid from dbo.tFVUserMaster where rktotal > 0

	-- 2. 커서오픈
	open curUserRanking

	-- 3. 커서 사용
	Fetch next from curUserRanking into @rank, @gameid
	while @@Fetch_status = 0
		Begin
			----------------------------
			--	< 홀짝랭킹 >
			-- 	 ~    1. 10,000 결정	별 50
			-- 	 ~    5.  5,000 결정	별 30
			--	  ~  10.  2,000 결정	별 20
			--	  ~ 100.    500 결정	별 5
			--	 나머지.     30 결정	별 0
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

	-- 4. 커서닫기
	close curUserRanking
	Deallocate curUserRanking

--------------------------------------------------------
-- 4. 어제날짜의 보상을 지급처리로 변환
--------------------------------------------------------
--select 'DEBUG 어제날짜의 보상을 지급처리로 변환'
update dbo.tFVRankDaJun
	set
		rkreward = @RANK_REWARD_END
where rkdateid8 = @rkdateid8
*/
