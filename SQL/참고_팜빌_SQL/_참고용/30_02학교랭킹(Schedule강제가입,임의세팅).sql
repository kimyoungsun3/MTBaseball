use Farm
GO
--------------------------------------------
-- 1. 유저 10만 입력
-- select max(idx) from dbo.tFVUserMaster
--------------------------------------------
/*
-- select max(idx) from dbo.tFVUserMaster
declare @var 			int
declare @loop			int				set @loop	= 100000
declare @gameid 		varchar(60)		set @gameid = 'farm'	-- guest, farm, iuest
declare @phone 			varchar(20)
select @var = max(idx) + 1 from dbo.tFVUserMaster
set @loop = @var + @loop
while @var < @loop
	begin
		set @phone			= '010' + ltrim(@var)
		exec dbo.spu_FVUserCreateTest
							@gameid,					-- gameid
							'049000s1i0n7t8445289',		-- password
							1,							-- market
							0,							-- buytype
							1,							-- platform
							'ukukukuk',					-- ukey
							101,						-- version
							@phone,						-- phone
							'',							-- pushid
							'',							-- kakaotalkid (없으면 임으로 생성해줌)
							'',							-- kakaouserid (없으면 임으로 생성해줌)
							@gameid, 					-- kakaonickname
							'',							-- kakaoprofile
							-1,							-- kakaomsgblocked
							'',-- kakaofriendlist(kakaouserid)
							-1
		set @var = @var + 1
	end
*/


---------------------------------------------
-- 2. 학교 정보 강제로 가입시키기 (max 12,222)
---------------------------------------------
/*
-- select count(*) from dbo.tFVUserMaster where schoolidx != -1			-- 오래 걸리는 작업이니까 조심하세요.
-- select schoolidx, count(*) from dbo.tFVUserMaster group by schoolidx	-- 오래 걸리는 작업이니까 조심하세요.
-- select count(*) from dbo.tFVSchoolUser where schoolidx != -1			-- 빠른 검색.
-- select schoolidx, count(*) from dbo.tFVSchoolUser where schoolidx != -1 group by schoolidx
-- select count(*) from dbo.tFVSchoolBank		-- 12,222
-- select count(*) from dbo.tFVSchoolMaster	-- 12,222
declare @schoolidx		int,
		@gameid			varchar(20),
		@password		varchar(20),
		@loop 			int,
		@idx			int

declare curSchoolJoin Cursor for
select idx, gameid, password from dbo.tFVUserMaster where schoolidx = -1
set @loop 		= 0
select @schoolidx = schoolidx from dbo.tFVSchoolMaster where cnt < 30 order by newid()

-- 2. 커서오픈
open curSchoolJoin

-- 3. 커서 사용
Fetch next from curSchoolJoin into @idx, @gameid, @password
while @@Fetch_status = 0
	Begin
		-- select @idx idx, @loop loop, @gameid gameid, @password password, @schoolidx schoolidx
		if(@loop > 1000)break;

		if(@loop % 30 = 0)
			begin
				select @schoolidx = schoolidx from dbo.tFVSchoolMaster where cnt < 30 order by newid()
			end
		exec spu_FVSchoolInfo @gameid, @password, 2, @schoolidx, '', -1			-- 가입모드

		set @loop = @loop + 1
		Fetch next from curSchoolJoin into @idx, @gameid, @password
	end

-- 4. 커서닫기
close curSchoolJoin
Deallocate curSchoolJoin
*/

--------------------------------------------
-- 3. 개인, 친구랭킹, 학교 점수 랜덤입력.
-- 60만 : 11:09, 10:23, 19:16
-- 90만 :
--------------------------------------------
-- update dbo.tFVUserMaster set ttsalecoin = 10 update dbo.tFVSchoolUser set point = 20 update dbo.tFVSchoolMaster set totalpoint	= 30
-- select top 10 * from dbo.tFVSchoolUser where schoolidx != -1
-- select top 10 * from dbo.tFVSchoolMaster where cnt >= 10
-- select top 1000 * from dbo.tFVGiftList  where idx > 302771673 order by idx desc
/*
declare @ttsalecoin		int,
		@schoolidx		int,
		@gameid			varchar(20),
		@servername		varchar(40)
SELECT @servername = @@SERVERNAME
if(@servername = 'WIN-J35FAHA60GQ')
	begin
		select 'DEBUG 1. 개인 정보 랜덤입력 > 실서버 리턴.'
		return
	end
else
	begin
		select 'DEBUG 1. 개인 정보 랜덤입력 > 테스트서버.'
	end

declare curUserMaster Cursor for
select gameid, schoolidx from dbo.tFVUserMaster
where gameid in (select gameid from dbo.tFVSchoolUser where schoolidx != -1)

-- 2. 커서오픈
open curUserMaster

-- 3. 커서 사용
Fetch next from curUserMaster into @gameid, @schoolidx
while @@Fetch_status = 0
	Begin
		set @ttsalecoin = Convert(int, ceiling(RAND() * 2000000))
		update dbo.tFVUserMaster		set ttsalecoin	= @ttsalecoin				where gameid = @gameid
		update dbo.tFVSchoolUser		set point		= @ttsalecoin				where gameid = @gameid
		if(@schoolidx != -1)
			begin
				update dbo.tFVSchoolMaster	set totalpoint	= totalpoint + @ttsalecoin	where schoolidx = @schoolidx
			end

		Fetch next from curUserMaster into @gameid, @schoolidx
	end
	-- 4. 커서닫기
close curUserMaster
Deallocate curUserMaster
select 'DEBUG 2. 개인 정보 랜덤입력 > 완료.'
*/
