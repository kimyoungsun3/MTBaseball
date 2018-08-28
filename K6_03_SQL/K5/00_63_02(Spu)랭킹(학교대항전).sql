/*
exec spu_SchoolRank  1, -1, ''			-- 현재 학교순위       (           학교순위                  )					--										50_01웹검색
exec spu_SchoolRank  4, -1, 'xxxx2'		-- 현재 학교순위       (           학교순위 + MY(가입자)     )					-- 13_02게임거래	23_01학교대항전
exec spu_SchoolRank  4, -1, 'guest90909'-- 현재 학교순위       (           학교순위 + MY(미가입자)   )					-- 13_02게임거래	23_01학교대항전
exec spu_SchoolRank  6, -1, 'xxxx2'     -- 현재 학교순위       (           학교순위 + MY(깡통)		 )					-- 13_02게임거래
exec spu_SchoolRank  2, 6607, ''		-- 현재 학교내 유저순위(           학교번호 > 학교인원들 순위) > Web에서 사용	--										50_01웹검색
exec spu_SchoolRank  3, -1, 'xxxx2'		-- 현재 학교내 유저순위(유저이름 > 학교번호 > 학교인원들 순위)					--										50_01웹검색
exec spu_SchoolRank  5, -1, 'xxxx2'		-- 현재 학교내 유저순위(유저이름 > 학교번호 > 학교인원들 순위 + MY)				--					23_01학교대항전
exec spu_SchoolRank  7, 6607, ''		-- 현재 학교내 유저순위(           학교번호 > 학교인원들 순위) > 게임에서 사용	-- 13_02게임거래	23_01학교대항전
exec spu_SchoolRank  7, -1, ''			-- 현재 학교내 유저순위(           학교번호 > 학교인원들 순위) > 더미			-- 13_02게임거래	23_01학교대항전

exec spu_SchoolRank 11, -1, 'xxxx2'		-- 지난 학교랭킹(학교 + 내소속) > LOGIN											-- 04_01로그인
exec spu_SchoolRank 11, -1, 'xxxx2'	--																				-- 04_01로그인
-- select * from dbo.tEpiReward where gameid = 'guest198' order by idx asc
-- exec spu_Login 'guest198', '3023677g3i8n7l492451', 1, 101, '', '', -1, -1			-- 정상유저


exec spu_SchoolRank 20, -1, ''			-- 지난 날짜리스트.																--										50_01웹검색
exec spu_SchoolRank 22, -1, '20140523'	-- 지난 지정된 날짜 학교순위 (20131227일 학교 랭킹)								--										50_01웹검색
exec spu_SchoolRank 23,  1, '20140523'	-- 지난 지정된 날짜 학교내의 > 유저 랭킹										--										50_01웹검색
*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_SchoolRank', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_SchoolRank;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_SchoolRank
	@mode_									int,
	@paramint_								int,
	@paramstr_								varchar(256)
	--WITH ENCRYPTION -- 프로시져를 암호화함.
as
	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------
	-- 학교대항전 랭킹모드.
	declare @SCHOOLRANK_CURRENT_SCHOOLRANK		int				set @SCHOOLRANK_CURRENT_SCHOOLRANK		= 1			-- 										50_01웹검색
	declare @SCHOOLRANK_CURRENT_SCHOOLRANK_MY	int				set @SCHOOLRANK_CURRENT_SCHOOLRANK_MY	= 4			-- 13_02게임거래	23_01학교대항전
	declare @SCHOOLRANK_CURRENT_SCHOOLRANK_MY2	int				set @SCHOOLRANK_CURRENT_SCHOOLRANK_MY2	= 6			-- 13_02게임거래
	declare @SCHOOLRANK_CURRENT_USERRANK		int				set @SCHOOLRANK_CURRENT_USERRANK		= 2			--										50_01웹검색
	declare @SCHOOLRANK_CURRENT_USERRANK_NAME	int				set @SCHOOLRANK_CURRENT_USERRANK_NAME	= 3			--										50_01웹검색
	declare @SCHOOLRANK_CURRENT_USERRANK_GAMEID	int				set @SCHOOLRANK_CURRENT_USERRANK_GAMEID	= 5			--					23_01학교대항전
	declare @SCHOOLRANK_CURRENT_USERRANK_SCHOOLIDX	int			set @SCHOOLRANK_CURRENT_USERRANK_SCHOOLIDX	= 7		-- 13_02게임거래	23_01학교대항전

	declare @SCHOOLRANK_RECENTLY_SCHOOLRANK		int				set @SCHOOLRANK_RECENTLY_SCHOOLRANK		= 11		-- 04_01로그인

	declare @SCHOOLRANK_LASTWEEK_DATE			int				set @SCHOOLRANK_LASTWEEK_DATE			= 20		--										50_01웹검색
	declare @SCHOOLRANK_LASTWEEK_SCHOOLRANK		int				set @SCHOOLRANK_LASTWEEK_SCHOOLRANK		= 22		--										50_01웹검색
	declare @SCHOOLRANK_LASTWEEK_USERRANK		int				set @SCHOOLRANK_LASTWEEK_USERRANK		= 23		--										50_01웹검색


	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @schoolname		varchar(128)
	declare @gameid			varchar(20)
	declare @dateid			varchar(40)
	declare @schoolidx		int						set @schoolidx		= -1
	declare @totalpoint		bigint					set @totalpoint		= 0
	declare @point			int						set @point			= 0
	declare @cnt			int						set @cnt			= -1
	declare @schoolrank		int						set @schoolrank		= -1
	declare @userrank		int						set @userrank		= -1
	declare @itemcode1		int						set @itemcode1		= -1
	declare @itemcode2		int						set @itemcode2		= -1
	declare @itemcode3		int						set @itemcode3		= -1


Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on

	if(@mode_ = @SCHOOLRANK_CURRENT_SCHOOLRANK)
		BEGIN
			-----------------------------------------
			-- 관리자 페이지에서만 보는 정보
			--select 'DEBUG 실시간 전체순위'
			-----------------------------------------
			DECLARE @tTempTableCurrentMaster TABLE(
				schoolrank		int,
				schoolidx		int,
				cnt				int,
				totalpoint		bigint
			);

			-- 상위 10위
			insert into @tTempTableCurrentMaster
			select top 500 rank() over(order by totalpoint desc) schoolrank, schoolidx, cnt, totalpoint/100 from dbo.tSchoolMaster
			--where totalpoint > 0
			--order by totalpoint desc

			select * from
				@tTempTableCurrentMaster m
			JOIN
				(select * from dbo.tSchoolBank where schoolidx in (select schoolidx from @tTempTableCurrentMaster)) b
			ON
				m.schoolidx = b.schoolidx
			--order by schoolrank asc
		END
	else if(@mode_ = @SCHOOLRANK_CURRENT_SCHOOLRANK_MY)
		BEGIN

			-------------------------------
			-- 개인정보 읽어오기.
			-------------------------------
			set @gameid		= @paramstr_
			set @totalpoint	= 0
			select @schoolidx = schoolidx, @cnt = cnt, @totalpoint = totalpoint from dbo.tSchoolMaster
			where schoolidx = (select schoolidx from dbo.tUserMaster where gameid = @gameid)

			-----------------------------------------
			--select 'DEBUG 상위10 + 자신랭킹', @gameid gameid, @schoolidx schoolidx, @cnt cnt, @totalpoint totalpoint
			-----------------------------------------
			DECLARE @tTempTableCurrentMasterMy TABLE(
				schoolrank		int,
				schoolidx		int,
				cnt				int,
				totalpoint		bigint
			);

			-- 상위10 + 자신랭킹.
			insert into @tTempTableCurrentMasterMy
			select top 10 rank() over(order by totalpoint desc) schoolrank,  schoolidx, cnt, totalpoint/100 from dbo.tSchoolMaster
			union
			select count(schoolidx) + 1 as schoolrank, @schoolidx schoolidx, @cnt cnt, @totalpoint/100 totalpoint from dbo.tSchoolMaster where totalpoint > @totalpoint

			select m.*, b.schoolname, schoolarea, schoolkind from
				@tTempTableCurrentMasterMy m
			JOIN
				(select * from dbo.tSchoolBank where schoolidx in (select schoolidx from @tTempTableCurrentMasterMy)) b
			ON
				m.schoolidx = b.schoolidx
			--order by schoolrank asc
		END
	else if(@mode_ = @SCHOOLRANK_CURRENT_SCHOOLRANK_MY2)
		BEGIN
			DECLARE @tTempTableCurrentMasterMy2 TABLE(
				schoolrank		int,
				schoolidx		int,
				cnt				int,
				totalpoint		bigint,
				schoolname		varchar(128),
				schoolarea		varchar(128),
				schoolkind		int
			);
			select * from @tTempTableCurrentMasterMy2
		END
	else if (@mode_ = @SCHOOLRANK_CURRENT_USERRANK)
		BEGIN
			---------------------------------------------
			-- 관리자 페이지에서만 보는 정보
			--select 'DEBUG 내가 속한 그룹인원들 실시간 순위'
			---------------------------------------------
			set @schoolidx = @paramint_
			select @schoolname = schoolname from dbo.tSchoolBank where schoolidx = @schoolidx

			select top 500 rank() over(order by point desc) userrank, @schoolname schoolname, * from dbo.tSchoolUser
			where schoolidx = @schoolidx and schoolidx != -1
			order by point desc

		END
	else if (@mode_ = @SCHOOLRANK_CURRENT_USERRANK_NAME)
		BEGIN
			---------------------------------------------
			-- 관리자 페이지에서만 보는 정보
			--select 'DEBUG 내가 속한 그룹인원들 실시간 순위'
			---------------------------------------------
			select @schoolidx = schoolidx from dbo.tUserMaster where gameid = @paramstr_
			select @schoolname = schoolname from dbo.tSchoolBank where schoolidx = @schoolidx

			select top 500 rank() over(order by point desc) userrank, @schoolname schoolname, * from dbo.tSchoolUser
			where schoolidx = @schoolidx and schoolidx != -1
			order by point desc

		END
	else if (@mode_ = @SCHOOLRANK_CURRENT_USERRANK_GAMEID)
		BEGIN
			set @gameid		= @paramstr_
			set @schoolidx	= -1
			set @schoolname	= ''
			set @cnt		= 1
			---------------------------------------------
			--select 'DEBUG 유저이름 > 학교번호 > 학교인원들 순위(실시간) + MY'
			---------------------------------------------
			select @schoolidx = schoolidx from dbo.tUserMaster where gameid = @gameid
			select @schoolname = schoolname from dbo.tSchoolBank where schoolidx = @schoolidx
			select @point = point from dbo.tSchoolUser where gameid = @gameid and schoolidx = @schoolidx and schoolidx != -1
			select @cnt = cnt from dbo.tSchoolMaster where  schoolidx = @schoolidx

			---------------------------------------------
			-- 친구정보.
			---------------------------------------------
			DECLARE @tTempUserRank TABLE(
				userrank		int,
				gameid			varchar(20),
				point			int,
				schoolname		varchar(128),
				schoolidx		int,
				cnt				int
			);

			-- 친구 정보를 저장.
			insert into @tTempUserRank
			select top 10 rank() over(order by point desc) userrank, gameid, point, @schoolname schoolname, schoolidx, @cnt cnt from dbo.tSchoolUser where schoolidx = @schoolidx and schoolidx != -1
			union
			select count(gameid) + 1 as userrank, @gameid gameid, @point point, @schoolname schoolname, @schoolidx schoolidx, @cnt cnt from dbo.tSchoolUser where schoolidx = @schoolidx and point > @point and schoolidx != -1
			--order by point desc

			select r.*, isnull(itemcode, 1) itemcode, isnull(acc1, -1) acc1, isnull(acc2, -1) acc2, kakaotalkid, kakaouserid, kakaonickname, kakaoprofile, kakaomsgblocked, 1 kakaofriendkind from
				(select gameid, anireplistidx, kakaotalkid, kakaouserid, kakaonickname, kakaoprofile, kakaomsgblocked from dbo.tUserMaster where gameid in (select gameid from @tTempUserRank)) as m
			LEFT JOIN
				(select gameid, listidx, itemcode, acc1, acc2 from dbo.tUserItem where gameid in (select gameid from @tTempUserRank)) as i
			ON
				m.gameid = i.gameid and m.anireplistidx = i.listidx
			JOIN
				(select * from @tTempUserRank) as r
			ON
				m.gameid = r.gameid
			order by point desc

		END
	else if (@mode_ = @SCHOOLRANK_CURRENT_USERRANK_SCHOOLIDX)
		BEGIN
			---------------------------------------------
			--select 'DEBUG 내가 속한 그룹인원들 실시간 상위 10위만'
			---------------------------------------------
			set @schoolidx 	= @paramint_
			set @cnt		= 1
			select @schoolname = schoolname from dbo.tSchoolBank where schoolidx = @schoolidx
			select @cnt = cnt from dbo.tSchoolMaster where  schoolidx = @schoolidx

			---------------------------------------------
			-- 친구정보.
			-- 게임 거래중, 학교 대항전
			---------------------------------------------
			DECLARE @tTempUserRank2 TABLE(
				userrank		int,
				gameid			varchar(20),
				point			int,
				schoolname		varchar(128),
				schoolidx		int,
				cnt				int
			);

			-- 친구 정보를 저장.
			insert into @tTempUserRank2
			select top 10 rank() over(order by point desc) userrank, gameid, point, @schoolname schoolname, schoolidx, @cnt cnt from dbo.tSchoolUser
			where schoolidx = @schoolidx and schoolidx != -1
			--order by point desc

			select r.*, isnull(itemcode, 1) itemcode, isnull(acc1, -1) acc1, isnull(acc2, -1) acc2, kakaotalkid, kakaouserid, kakaonickname, kakaoprofile, kakaomsgblocked, 1 kakaofriendkind from
				(select gameid, anireplistidx, kakaotalkid, kakaouserid, kakaonickname, kakaoprofile, kakaomsgblocked from dbo.tUserMaster where gameid in (select gameid from @tTempUserRank2)) as m
			LEFT JOIN
				(select gameid, listidx, itemcode, acc1, acc2 from dbo.tUserItem where gameid in (select gameid from @tTempUserRank2)) as i
			ON
				m.gameid = i.gameid and m.anireplistidx = i.listidx
			JOIN
				(select * from @tTempUserRank2) as r
			ON
				m.gameid = r.gameid
			order by point desc

		END
	else if (@mode_ = @SCHOOLRANK_RECENTLY_SCHOOLRANK)
		BEGIN
			---------------------------------------------
			--select 'DEBUG 지난주 학교순위, 학교내 기여도'
			---------------------------------------------
			DECLARE @tTempTableLastWeekMaster TABLE(
				dateid			varchar(8) default(getdate()),

				schoolrank		int,
				schoolidx		int,
				cnt				int,
				totalpoint		bigint
			);

			--------------------------------
			-- 지난주 학교순위
			--------------------------------
			set @gameid		= @paramstr_
			set @dateid		= Convert(varchar(8), Getdate(),112)
			select top 1 @dateid = dateid from dbo.tSchoolBackMaster order by dateid desc

			-- 지난주 학교랭킹
			insert into @tTempTableLastWeekMaster
			select top 3 dateid, schoolrank, schoolidx, cnt, totalpoint/100
			from dbo.tSchoolBackMaster
			where dateid = @dateid
			order by schoolrank asc

			select l.*, b.schoolname from
				@tTempTableLastWeekMaster l
			JOIN
				(select schoolidx, schoolname from dbo.tSchoolBank where schoolidx in (select schoolidx from @tTempTableLastWeekMaster)) b
			ON
				l.schoolidx = b.schoolidx
			--order by schoolrank asc

			--------------------------------
			-- 지난 학교내 기여도.
			--------------------------------
			set @schoolrank 	= -1
			set @userrank		= -1
			set @schoolidx		= -1
			set @point			= 0
			set @schoolname		= ''
			set @cnt			= 0
			set @itemcode1		= -1
			set @itemcode2		= -1
			set @itemcode3		= -1

			------------------------------------------
			-- tSchoolUser > 지난랭킹보기.
			------------------------------------------
			select
				@schoolrank 	= backschoolrank,
				@userrank 		= backuserrank,
				@schoolidx 		= backschoolidx,
				@point 			= backpoint,
				@itemcode1 		= backitemcode1,
				@itemcode2 		= backitemcode2,
				@itemcode3 		= backitemcode3
			from dbo.tSchoolUser
			where gameid = @gameid

			select @schoolname = schoolname from dbo.tSchoolBank where schoolidx = @schoolidx
			select @cnt = cnt from dbo.tSchoolBackMaster where dateid = @dateid and schoolidx = @schoolidx

			select @dateid dateid, @schoolrank schoolrank, @userrank userrank, @schoolidx schoolidx, @point point, @schoolname schoolname, @cnt cnt, @itemcode1 itemcode1, @itemcode2 itemcode2, @itemcode3 itemcode3
		END
	else if (@mode_ = @SCHOOLRANK_LASTWEEK_DATE)
		BEGIN
			---------------------------------------------------
			-- 관리자 페이지에서만 보는 정보
			--select 'DEBUG 내가 속한 지난주 그룹인원들 순위'
			---------------------------------------------
			select top 500 * from dbo.tSchoolSchedule
			order by dateid desc
		END
	else if (@mode_ = @SCHOOLRANK_LASTWEEK_SCHOOLRANK)
		BEGIN
			---------------------------------------------------
			-- 관리자 페이지에서만 보는 정보
			---------------------------------------------

			set @dateid = @paramstr_
			DECLARE @tTempTableLastSchoolList TABLE(
				dateid			varchar(8),

				schoolrank		int,
				schoolidx		int,
				cnt				int,
				totalpoint		bigint
			);

			insert into @tTempTableLastSchoolList
			select top 500 dateid, schoolrank, schoolidx, cnt, totalpoint/100 from dbo.tSchoolBackMaster
			where dateid = @dateid
			order by schoolrank asc

			select l.*, b.schoolname from
				@tTempTableLastSchoolList l
			JOIN
				(select schoolidx, schoolname from dbo.tSchoolBank where schoolidx in (select schoolidx from @tTempTableLastSchoolList)) b
			ON
				l.schoolidx = b.schoolidx
			order by schoolrank asc
		END
	else if (@mode_ = @SCHOOLRANK_LASTWEEK_USERRANK)
		BEGIN
			---------------------------------------------------
			-- 관리자 페이지에서만 보는 정보
			---------------------------------------------

			set @schoolidx = @paramint_
			set @dateid = @paramstr_
			DECLARE @tTempTableLastUserList TABLE(
				dateid			varchar(8),

				schoolrank		int,
				userrank		int,
				schoolidx		int,
				gameid			varchar(20),
				joindate		datetime,
				point			int,
				itemcode		int,
				acc1			int,
				acc2			int,
				itemcode1		int,
				itemcode2		int,
				itemcode3		int
			);

			insert into @tTempTableLastUserList
			select top 500 backdateid, backschoolrank, backuserrank, backschoolidx, gameid, joindate, backpoint, backitemcode, backacc1, backacc2, backitemcode1, backitemcode2, backitemcode3 from dbo.tSchoolUser
			where backdateid = @dateid and backschoolidx = @schoolidx
			order by backuserrank asc

			select l.*, b.schoolname from
				@tTempTableLastUserList l
			JOIN
				(select schoolidx, schoolname from dbo.tSchoolBank where schoolidx in (select schoolidx from @tTempTableLastUserList)) b
			ON
				l.schoolidx = b.schoolidx
			--order by schoolrank asc
		END
	else
		BEGIN
			set @mode_ = @mode_
		END

	------------------------------------------------
	set nocount off
End

