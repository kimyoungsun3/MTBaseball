--use Farm
--GO
--
--delete from dbo.tFVGiftList where giftdate > '2014-01-01' and gameid in ('xxxx12', 'xxxx13', 'xxxx14', 'xxxx15', 'xxxx16', 'xxxx17', 'xxxx18', 'xxxx19', 'xxxx2','xxxx3','xxxx4', 'xxxx5', 'xxxx6', 'xxxx7', 'xxxx8', 'xxxx9')
--delete from dbo.tFVSchoolBackMaster where dateid = '20140919'
--delete from dbo.tFVSchoolBackUser where dateid = '20140919'	-- 사용안함.
--exec spu_FVSchoolScheduleRecord '20140919', 0
--------------------------------------------
-- 짜요 목장 이야기
--  하기의 내용은 스케쥴에 등록된다.
--  1. 1주일 단위로 백업을 진행한다. (매주 일요일 23시 59분 00초에 진행)
--  2. 학교 랭킹 백업
--  3. 학교별, 랭킹별 백업.
---------------------------------------------
declare @step				int,
		@dateid				varchar(8),
		@gameid 			varchar(20),
		@loop 				int,
		@backschoolrank 	int,
		@schoolidx			int,
		@backcnt			int,
		@backtotalpoint		bigint,
		@backitemcode		int,
		@backacc1			int,
		@backacc2			int,
		@backuserrank		int,
		@curdate			datetime,
		@idx				int,
		@idx2				int,
		@cnt2				int,
		@totalpoint2		bigint,
		@comment			varchar(64)

set @dateid		= Convert(varchar(8),Getdate(),112)
set @curdate	= getdate()

declare @SCHOOL_STEP01_INIT_NON				int		set @SCHOOL_STEP01_INIT_NON				= 0
declare @SCHOOL_STEP02_INIT_END				int		set @SCHOOL_STEP02_INIT_END				= 1
declare @SCHOOL_STEP03_MASTERRANK_END		int		set @SCHOOL_STEP03_MASTERRANK_END		= 2
declare @SCHOOL_STEP04_USERRANK_END			int		set @SCHOOL_STEP04_USERRANK_END			= 3
declare @SCHOOL_STEP05_DUMP_END				int		set @SCHOOL_STEP05_DUMP_END				= 4

select @step = isnull(step, 0) from dbo.tFVSchoolSchedule where dateid = @dateid
set @step = isnull(@step, @SCHOOL_STEP01_INIT_NON)
--select 'DEBUG ', @dateid dateid, @step step, getdate() '시간', dbo.fnu_GetFVDatePart('ss', @curdate, getdate())

------------------------------------------------------
-- 1. tSchoolMaster, tSchoolUser 랭킹 초기화
-- select dbo.fnu_GetFVDatePart('ss', getdate() - 1, getdate())
--
------------------------------------------------------
--select 'DEBUG 유저수', max(idx) cnt from dbo.tFVUserMaster			-- 938984
--select 'DEBUG 학교수', max(idx) cnt from dbo.tFVSchoolMaster		-- 12225
--select 'DEBUG 학교가입학생수', max(idx) cnt from dbo.tFVSchoolUser	-- 590446
--select 'DEBUG step1 tSchoolMaster, tSchoolUser  이동시작', getdate() '시간', dbo.fnu_GetFVDatePart('ss', @curdate, getdate())
if(@step = @SCHOOL_STEP01_INIT_NON)
	begin
		set @step 	= @SCHOOL_STEP02_INIT_END

		-------------------------------------
		-- 학교정보 마스터 백업화(만건 0초) > 분산처리.
		-------------------------------------
		select @idx2 = max(idx) from dbo.tFVSchoolMaster
		while(@idx2 > -1000)
			begin
				update dbo.tFVSchoolMaster
					set
						backcnt			= cnt,
						backtotalpoint	= totalpoint,
						backschoolrank	= -1
				where idx >= @idx2 - 1000 and idx < @idx2

				set @idx2 = @idx2 - 1000
			end

		--select 'DEBUG step1-1 > tSchoolMaster 이동', getdate() '시간', dbo.fnu_GetFVDatePart('ss', @curdate, getdate())

		-------------------------------------------
		-- 유저 정보 마스터 백업화(590,418건)
		-- 데이타가 없으면 > 4초
		-- 데이타가 있으면 > 20초
		-- select count(*) from dbo.tFVSchoolUser
		-- 대표동물 > itemcode, acc1, acc2 (대표 동물 변경할때 적용됨)
		-------------------------------------------
		select @idx2 = max(idx) from dbo.tFVSchoolUser
		while(@idx2 > -1000)
			begin
				update dbo.tFVSchoolUser
					set
						backdateid		= @dateid,
						backschoolidx	= schoolidx,
						backschoolrank 	= -1,
						backuserrank	= -1,
						backpoint	 	= point,
						backitemcode	= itemcode,	-- 대표동물 교체할때 들어옴.
						backacc1		= acc1,
						backacc2		= acc2,
						backitemcode1	= -1,		-- 학교대항전으로 받은선물
						backitemcode2	= -1,
						backitemcode3	= -1
				where idx >= @idx2 - 1000 and idx < @idx2
				set @idx2 = @idx2 - 1000
			end

		--select 'DEBUG step1-2 > tSchoolUser 이동', getdate() '시간', dbo.fnu_GetFVDatePart('ss', @curdate, getdate())

		-------------------------------------
		-- 학교	> 1단계에서 클리어함.
		-------------------------------------
		update dbo.tFVSchoolMaster
			set
				totalpoint = 0
		--where totalpoint > 0
		--select 'DEBUG step1-3 > tSchoolMaster 클리어', getdate() '시간', dbo.fnu_GetFVDatePart('ss', @curdate, getdate())

		---------------------------------------------------------------------------
		-- 유저 정보 마스터 백업화(590,418건)
		-- 유저 > 1단계에서 클리어함.
		-- 데이타가 없으면 > 5초
		-- 데이타가 있으면 > 20 ~ 50초
		-- > schoolrank, point에 인덱싱이 걸려있어 내부적으로 인덱싱 작업
		-- > 분활해서 작업하기.
		-- > --schoolrank = -1, 삭제함(미사용)
		-- select top 10 * from dbo.tFVSchoolUser
		---------------------------------------------------------------------------
		select @idx2 = max(idx) from dbo.tFVSchoolUser
		while(@idx2 > -1000)
			begin
				update dbo.tFVSchoolUser
					set
						point		= 0
				where idx >= @idx2 - 1000 and idx <= @idx2

				set @idx2 =  @idx2 - 1000
				--select 'DEBUG step1-4 > tSchoolUser 클리어****', getdate() '시간',  (@idx2 + 1000) idx, @idx2 idx, dbo.fnu_GetFVDatePart('ss', @curdate, getdate())
			end

		---------------------------------------
		-- 지난학교 다시보기 close해두기 > 현재는 패스하자.
		---------------------------------------

		-- 마킹하기
		exec spu_FVSchoolScheduleRecord @dateid, @step
		--select 'DEBUG step1-5 > 완료', getdate() '시간', dbo.fnu_GetFVDatePart('ss', @curdate, getdate())
	end
else
	begin
		--select 'DEBUG step1-1. tSchoolMaster, tSchoolUser 연산버퍼로 이동완료됨 > 패스', getdate() '시간', dbo.fnu_GetFVDatePart('ss', @curdate, getdate())
		set @step = @step
	end


------------------------------------------------------
-- 2. tSchoolMaster 학교랭킹 산출
-- 전체 	> 60초 걸림.
-- 100개 	> 1초
-- select top 10 * from dbo.tFVSchoolMaster order by backtotalpoint desc
-- select top 10 * from dbo.tFVSchoolMaster order by backschoolrank asc
-- select top 10 * from dbo.tFVSchoolUser order by backschoolrank asc
------------------------------------------------------
--select 'DEBUG step2 학교랭킹 산출', getdate() '시간', dbo.fnu_GetFVDatePart('ss', @curdate, getdate())
if(@step = @SCHOOL_STEP02_INIT_END)
	begin
		set @step 	= @SCHOOL_STEP03_MASTERRANK_END

		---------------------------------------------------------------------------
		-- 1안 : 100개의 학교 > 0초
		-- 2안 : 전체학교
		--		 학교 랭킹 마스터 정보 입력 (3:35, 60초)
		--		 학교 마스터 : 5959개
		--		 학교 유저   : 60만개
		--		 다른 작업이 진행된다.
		---------------------------------------------------------------------------
		declare curSchoolMasterRank Cursor for
		select rank() over(order by backtotalpoint desc) backschoolrank, schoolidx
		from dbo.tFVSchoolMaster
		where backcnt > 0 and backtotalpoint > 0

		open curSchoolMasterRank
		Fetch next from curSchoolMasterRank into @backschoolrank, @schoolidx
		while @@Fetch_status = 0
			begin
				-- 마스터, 유저에 학교 랭킹 등록.
				update dbo.tFVSchoolMaster set backschoolrank = @backschoolrank where schoolidx = @schoolidx
				update dbo.tFVSchoolUser   set backschoolrank = @backschoolrank where schoolidx = @schoolidx

				Fetch next from curSchoolMasterRank into @backschoolrank, @schoolidx
			end
		close curSchoolMasterRank
		Deallocate curSchoolMasterRank
		--select 'DEBUG step2-1 > tSchoolMaster 랭킹산출', getdate() '시간', dbo.fnu_GetFVDatePart('ss', @curdate, getdate())

		-- 마킹하기
		exec spu_FVSchoolScheduleRecord @dateid, @step
	end
else
	begin
		--select 'DEBUG 2. tSchoolMaster 랭킹 산출 > 패스'
		set @step = @step
	end

------------------------------------------------------
-- 3. tSchoolUser 그룹내의 랭킹 산출
------------------------------------------------------
--select 'DEBUG step3 tSchoolUser 학교내 각 유저 랭킹 산출', getdate() '시간', dbo.fnu_GetFVDatePart('ss', @curdate, getdate())
if(@step = @SCHOOL_STEP03_MASTERRANK_END)
	begin
		--select 'DEBUG step3-1. tSchoolUser > 시작', getdate() '시간', dbo.fnu_GetFVDatePart('ss', @curdate, getdate())
		set @step 	= @SCHOOL_STEP04_USERRANK_END

		declare curSchoolUserRank Cursor for
		select u.backschoolrank, rank() over (partition by u.backschoolrank order by u.backpoint desc) as userrank2, gameid, m.backcnt, m.backtotalpoint
		from dbo.tFVSchoolUser u
			 JOIN
			 dbo.tFVSchoolMaster m
			 ON u.schoolidx = m.schoolidx
		where u.backschoolrank > 0 and u.backpoint > 0 order by u.backschoolrank asc
		--select 'DEBUG step3-2. tSchoolUser > 커서 생성', getdate() '시간', dbo.fnu_GetFVDatePart('ss', @curdate, getdate())

		open curSchoolUserRank
		Fetch next from curSchoolUserRank into @backschoolrank, @backuserrank, @gameid, @cnt2 , @totalpoint2
		while @@Fetch_status = 0
			begin
				-----------------------------------------------
				-- 각 유저 등급에 따른 선물지급
				-- 1등학교 	1위		212, 1003, 1207
				-- 			2위		112, 1003, 1206
				-- 			3위		 14, 1003, 1205
				-- 			기타  	 -1, 1004,   -1
				-- 2등학교 	1위		210, 1003, 1206
				-- 			2위		111, 1003, 1205
				-- 			3위		 13, 1003, 1204
				-- 			기타	 -1,  902,   -1
				-- 3등학교 	1위		209, 1003, 1205
				-- 			2위		110, 1003, 1204
				-- 			3위		 12, 1003, 1203
				-- 			기타	 -1,  901,   -1
				-- 4등이상           -1,   -1,   -1
				-----------------------------------------------
				if(@backschoolrank = 1)
					begin
						--select 'DEBUG 1등 학교'
						if(@backuserrank = 1)
							begin
								exec spu_FVSchoolScheduleGiftSendNew @gameid, @backuserrank, 212, 1003, 1207
							end
						else if(@backuserrank = 2)
							begin
								exec spu_FVSchoolScheduleGiftSendNew @gameid, @backuserrank, 112, 1003, 1206
							end
						else if(@backuserrank = 3)
							begin
								exec spu_FVSchoolScheduleGiftSendNew @gameid, @backuserrank,  14, 1003, 1205
							end
						else
							begin
								exec spu_FVSchoolScheduleGiftSendNew @gameid, @backuserrank, -1, 1004, -1
							end
					end
				else if(@backschoolrank = 2)
					begin
						--select 'DEBUG 2등 학교'
						if(@backuserrank = 1)
							begin
								exec spu_FVSchoolScheduleGiftSendNew @gameid, @backuserrank,  210, 1003, 1206
							end
						else if(@backuserrank = 2)
							begin
								exec spu_FVSchoolScheduleGiftSendNew @gameid, @backuserrank,  111, 1003, 1205
							end
						else if(@backuserrank = 3)
							begin
								exec spu_FVSchoolScheduleGiftSendNew @gameid, @backuserrank,  13, 1003, 1204
							end
						else
							begin
								exec spu_FVSchoolScheduleGiftSendNew @gameid, @backuserrank, -1, 902, -1
							end
					end
				else if(@backschoolrank = 3)
					begin
						--select 'DEBUG 3등 학교'
						if(@backuserrank = 1)
							begin
								exec spu_FVSchoolScheduleGiftSendNew @gameid, @backuserrank,  209, 1003, 1205
							end
						else if(@backuserrank = 2)
							begin
								exec spu_FVSchoolScheduleGiftSendNew @gameid, @backuserrank,  110, 1003, 1204
							end
						else if(@backuserrank = 3)
							begin
								exec spu_FVSchoolScheduleGiftSendNew @gameid, @backuserrank,  12, 1003, 1203
							end
						else
							begin
								exec spu_FVSchoolScheduleGiftSendNew @gameid, @backuserrank, -1, 901, -1
							end
					end
				else
					begin
						-----------------------------------------------
						-- 4등 이상의 학교는 등수만 있고 선물은 없다.
						-- > 여기서 젤 많이 걸린다. ㅠㅠ
						--exec spu_FVSchoolScheduleGiftSendNew @gameid, @backuserrank, -1, -1, -1
						-----------------------------------------------
						--select 'DEBUG 4등 이상학교', @gameid gameid, @backuserrank backuserrank, @cnt2 cnt2, @totalpoint2 totalpoint2
						update dbo.tFVSchoolUser set backuserrank = @backuserrank where gameid = @gameid


						-------------------------------------------------
						---- 내가 속한 학교에 1등이 되어 보자~
						---- 기간: 09/15(월) ~ 09/28(일)
						---- 4~300위 학교 내에 1,2,3등 에게는 보석이 5,4,3개
						---- 20명 이상, 5만점 이상
						---- 5025	수정3
						---- 5026	수정4
						---- 5027	수정5
						-------------------------------------------------
						--if(@cnt2 >= 20 and @totalpoint2 >= 50000)
						--	begin
						--		if(@backuserrank = 1)
						--			begin
						--				--select 'DEBUG 4이상학교(1)', @cnt2 cnt2, @totalpoint2 totalpoint2
						--				set @comment = '학교 ' + ltrim(str(@backschoolrank)) + '등 1위'
						--				exec spu_FVSchoolScheduleGiftSendNew2 @gameid, @backuserrank,  -1, 5027, -1, @comment
						--			end
						--		else if(@backuserrank = 2)
						--			begin
						--				--select 'DEBUG 4이상학교(2)', @cnt2 cnt2, @totalpoint2 totalpoint2
						--				set @comment = '학교 ' + ltrim(str(@backschoolrank)) + '등 2위'
						--				exec spu_FVSchoolScheduleGiftSendNew2 @gameid, @backuserrank,  -1, 5026, -1, @comment
						--			end
						--		else if(@backuserrank = 3)
						--			begin
						--				--select 'DEBUG 4이상학교(3)', @cnt2 cnt2, @totalpoint2 totalpoint2
						--				set @comment = '학교 ' + ltrim(str(@backschoolrank)) + '등 3위'
						--				exec spu_FVSchoolScheduleGiftSendNew2 @gameid, @backuserrank,  -1, 5025, -1, @comment
						--			end
						--	end

					end

				Fetch next from curSchoolUserRank into @backschoolrank, @backuserrank, @gameid, @cnt2 , @totalpoint2
			end
		close curSchoolUserRank
		Deallocate curSchoolUserRank

		---------------------------------------
		-- 60만개 하는데 > 47초
		---------------------------------------
		--select 'DEBUG step3-3. tSchoolUser > 전체처리', getdate() '시간', dbo.fnu_GetFVDatePart('ss', @curdate, getdate())

		-- 마킹하기
		exec spu_FVSchoolScheduleRecord @dateid, @step
	end
else
	begin
		--select 'DEBUG step3. tSchoolUser 그룹내의 랭킹 산출 > 패스'
		set @step = @step
	end

------------------------------------------------------
-- 4. 덤프하기후 클리어. tSchoolMaster, tSchoolUser -> tSchoolBackMaster, tSchoolBackUser(패스)
------------------------------------------------------
--select 'DEBUG step4 > tSchoolBackMaster 백업', getdate() '시간', dbo.fnu_GetFVDatePart('ss', @curdate, getdate())
if(@step = @SCHOOL_STEP04_USERRANK_END)
	begin
		--select 'DEBUG 4-1. 덤프하기. tSchoolMaster, tSchoolUser -> tSchoolBackMaster, tSchoolBackUser'
		set @step 	= @SCHOOL_STEP05_DUMP_END

		-----------------------------------------------------
		-- 학교랭킹 100위까지만 > 백업
		-----------------------------------------------------
		insert into dbo.tFVSchoolBackMaster(dateid, schoolidx,     cnt,     totalpoint,     schoolrank)
		select                           @dateid, schoolidx, backcnt, backtotalpoint, backschoolrank
		from dbo.tFVSchoolMaster where backschoolrank >= 1 and backschoolrank <= 10
		order by backschoolrank asc
		--select 'DEBUG step4-2 > tSchoolMaster 덤프', getdate() '시간', dbo.fnu_GetFVDatePart('ss', @curdate, getdate())


		-----------------------------------------------------
		-- 학교내 학생들정보. > 인원수만큼이라서 제거한다.
		-----------------------------------------------------
		insert into dbo.tFVSchoolBackUser(dateid,     schoolidx, gameid,     point, joindate,     schoolrank,     userrank,     itemcode,     acc1,     acc2,     itemcode1,     itemcode2,     itemcode3)
		select                         @dateid, backschoolidx, gameid, backpoint, joindate, backschoolrank, backuserrank, backitemcode, backacc1, backacc2, backitemcode1, backitemcode2, backitemcode3
		from dbo.tFVSchoolUser where backschoolrank >= 1 and backschoolrank <= 10
		order by backschoolrank asc, backuserrank asc
		--select 'DEBUG step4-3 > tSchoolBackUser 덤프', getdate() '시간', dbo.fnu_GetFVDatePart('ss', @curdate, getdate())

		-----------------------------------------
		-- 전체 락이 걸려서 사용하면 안될듯함. ㅠㅠ
		-- 938,939	> (1분 37, 53초)
		--  1: 읽어라   > 보여주삼.
		-- -1: 읽어감	> 이젠 안보여줘도됨.
		-- 로그인에 락이 걸림 ㅠㅠ > 사용안함. ㅠㅠ
		-----------------------------------------
		--select @idx = max(idx) from dbo.tFVUserMaster
		--while(@idx > 0)
		--	begin
		--		update dbo.tFVUserMaster
		--			set
		--				schoolresult	= 1
		--		where idx >= @idx - 5000 and idx <= @idx and schoolresult	= -1
        --
		--		set @idx =  @idx - 5000
		--		--select 'DEBUG step4-4 > tUserMaster 플래그켜주기', getdate() '시간',  (@idx + 10000) idx, @idx idx, dbo.fnu_GetFVDatePart('ss', @curdate, getdate())
		--	end
		--
		-----------------------------------------
		-- 대처방법  마킹하는 듯한 방법
		-----------------------------------------
		insert into dbo.tFVSchoolResult(schoolresult)
		select top 1 (isnull(schoolresult, 0) + 1) from dbo.tFVSchoolResult order by schoolresult desc


		-- 마킹하기
		exec spu_FVSchoolScheduleRecord @dateid, @step
	end
else
	begin
		--select 'DEBUG 4. 덤프하기. tSchoolMaster, tSchoolUser -> tSchoolBackMaster, tSchoolBackUser(패스) > 패스'
		set @step = @step
	end