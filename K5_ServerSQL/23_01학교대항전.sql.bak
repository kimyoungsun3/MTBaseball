/*
-- 1. 검색.
exec spu_SchoolInfo 'xxxx2', '049000s1i0n7t8445289', 1, 1, '운현', -1		-- 검색모드(초등학교, 용봉)

-- 2-1. 최초가입 가입.
-- select gameid, password, schoolidx from dbo.tUserMaster where idx >= 1092 and idx <= 1092 + 20
-- delete from dbo.tSchoolUser where gameid = 'xxxx2'
-- update dbo.tUserMaster set schoolidx = -1, schoolresult = -1 where gameid = 'xxxx2'
exec spu_SchoolInfo 'xxxx2', '049000s1i0n7t8445289', 2, 10709, '', -1			-- 가입모드

-- 2-2. 점수획득
select * from dbo.tSchoolMaster where schoolidx in (23, 24)
select * from dbo.tSchoolUser where schoolidx in (23, 24) order by schoolidx desc

-- 2-3. 다른친구 가입
-- update dbo.tUserMaster set schoolidx = -1, schoolresult = -1 where gameid like 'xxxx%'
-- delete from dbo.tSchoolUser where gameid like 'xxxx%'
exec spu_SchoolInfo 'xxxx', '049000s1i0n7t8445289', 2, 23, '', -1			-- 가입모드
exec spu_SchoolInfo 'xxxx2', '049000s1i0n7t8445289', 2, 23, '', -1			-- 가입모드
exec spu_SchoolInfo 'xxxx3', '049000s1i0n7t8445289', 2, 23, '', -1			-- 가입모드
exec spu_SchoolInfo 'xxxx4', '049000s1i0n7t8445289', 2, 23, '', -1			-- 가입모드
exec spu_SchoolInfo 'xxxx5', '049000s1i0n7t8445289', 2, 23, '', -1			-- 가입모드
exec spu_SchoolInfo 'xxxx6', '049000s1i0n7t8445289', 2, 23, '', -1			-- 가입모드
exec spu_SchoolInfo 'xxxx7', '049000s1i0n7t8445289', 2, 23, '', -1			-- 가입모드
exec spu_SchoolInfo 'xxxx8', '049000s1i0n7t8445289', 2, 23, '', -1			-- 가입모드
exec spu_SchoolInfo 'xxxx9', '049000s1i0n7t8445289', 2, 23, '', -1			-- 가입모드
exec spu_SchoolInfo 'xxxx10', '049000s1i0n7t8445289', 2, 23, '', -1			-- 가입모드
exec spu_SchoolInfo 'xxxx11', '049000s1i0n7t8445289', 2, 23, '', -1			-- 가입모드

-- 3. 학교 Top 10위 + 내순위
exec spu_SchoolInfo 'xxxx2', '049000s1i0n7t8445289', 3, -1, '', -1

-- 4. 소속 Top 30위 + 내순위
exec spu_SchoolInfo 'xxxx2', '049000s1i0n7t8445289', 4, -1, '', -1
exec spu_SchoolInfo 'xxxx2', '049000s1i0n7t8445289', 4,  1, '', -1

--  정보 알아보기.
declare @gameid varchar(20) set @gameid = 'xxxx2'
declare @schoolidx int		set @schoolidx = -1
declare @schoolresult int	set @schoolresult = -1
select @schoolidx = schoolidx, @schoolresult = schoolresult from dbo.tUserMaster where gameid = @gameid
select @schoolidx schoolidx, @schoolresult schoolresult
select * from dbo.tSchoolBank where schoolidx = @schoolidx
select * from dbo.tSchoolMaster where schoolidx = @schoolidx
select * from dbo.tSchoolUser where schoolidx = @schoolidx
*/
use Game4Farmvill5
GO

IF OBJECT_ID ( 'dbo.spu_SchoolInfo', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_SchoolInfo;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_SchoolInfo
	@gameid_								varchar(20),					-- 게임아이디
	@password_								varchar(20),
	@mode_									int,
	@paramint_								int,
	@paramstr_								varchar(256),
	@nResult_								int					OUTPUT
	--WITH ENCRYPTION -- 프로시져를 암호화함.
as
	------------------------------------------------
	--	2-1. 코드값자리
	------------------------------------------------
	-- 일반값
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	-- 로그인 오류.
	declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--블럭유저 > 팝업처리후 인트로로 빼버린다.
	declare @RESULT_ERROR_DELETED_USER 			int				set @RESULT_ERROR_DELETED_USER			= -12			--삭제유저 > 팝업처리후 인트로로 빼버린다.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함
	declare @RESULT_ERROR_NOT_FOUND_PASSWORD	int				set @RESULT_ERROR_NOT_FOUND_PASSWORD	= -17
	declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--서버를 점검하고 있다.
	declare @RESULT_NEWVERION_CLIENT_DOWNLOAD 	int				set @RESULT_NEWVERION_CLIENT_DOWNLOAD	= -15			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 링크처리.
	declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 종료.

	-- 기타오류
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- 지원하지않는모드
	declare @RESULT_ERROR_CANNT_CHANGEDAY_SCHOOL	int			set @RESULT_ERROR_CANNT_CHANGEDAY_SCHOOL= -127			-- 학교대항전을 변경못함.
	declare @RESULT_ERROR_CANNT_JOINDAY_SCHOOL	int				set @RESULT_ERROR_CANNT_JOINDAY_SCHOOL	= -128			-- 학교대항전을 가입불가.
	declare @RESULT_ERROR_CANNT_FIND_SCHOOL		int				set @RESULT_ERROR_CANNT_FIND_SCHOOL		= -129			-- 학교대항전을 학교를 찾을수 없음.
	declare @RESULT_ERROR_CANNT_JOINMAX_SCHOOL	int				set @RESULT_ERROR_CANNT_JOINMAX_SCHOOL	= -130			-- 학교대항전을 학교가 맥스입니다.

	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------
	-- 학교종류.
	--declare @SCHOOLKIND_ELEMENTARY_SCHOOL		int				set @SCHOOLKIND_ELEMENTARY_SCHOOL 		= 1		-- 초등.
	--declare @SCHOOLKIND_JUNIOR_SCHOOL			int				set @SCHOOLKIND_JUNIOR_SCHOOL 			= 2		-- 중등.
	--declare @SCHOOLKIND_HIGH_SCHOOL			int				set @SCHOOLKIND_HIGH_SCHOOL 			= 3		-- 고등.
	--declare @SCHOOLKIND_COLLEGE_SCHOOL		int				set @SCHOOLKIND_COLLEGE_SCHOOL 			= 4		-- 대학.

	-- 학교대항전 모드.
	declare @SCHOOLRANK_MODE_SCHOOLBANK_SEARCH	int				set @SCHOOLRANK_MODE_SCHOOLBANK_SEARCH	= 1
	declare @SCHOOLRANK_MODE_SCHOOLBANK_JOIN	int				set @SCHOOLRANK_MODE_SCHOOLBANK_JOIN	= 2
	declare @SCHOOLRANK_MODE_SCHOOLTOP			int				set @SCHOOLRANK_MODE_SCHOOLTOP			= 3
	declare @SCHOOLRANK_MODE_SCHOOLUSERLIST		int				set @SCHOOLRANK_MODE_SCHOOLUSERLIST		= 4

	-- 요일값.
	declare @WHAT_DAY_SUNDAY					int				set @WHAT_DAY_SUNDAY					= 1	-- 일(1)
	declare @WHAT_DAY_MONDAY					int				set @WHAT_DAY_MONDAY					= 2 -- 월(2)
	declare @WHAT_DAY_TUESDAY					int				set @WHAT_DAY_TUESDAY					= 3 -- 화(3)
	declare @WHAT_DAY_WEDNESDAY					int				set @WHAT_DAY_WEDNESDAY					= 4 -- 수(4)
	declare @WHAT_DAY_THURSDAY					int				set @WHAT_DAY_THURSDAY					= 5 -- 목(5)
	declare @WHAT_DAY_FRIDAY					int				set @WHAT_DAY_FRIDAY					= 6 -- 금(6)
	declare @WHAT_DAY_SATURDAY					int				set @WHAT_DAY_SATURDAY					= 7 -- 토(7)

	declare @SCHOOL_MAX							int				set @SCHOOL_MAX							= 300
	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @comment		varchar(128)
	declare @gameid			varchar(20)				set @gameid			= ''
	declare @schoolidxcur	int						set @schoolidxcur	= -1

	declare @dw				int						set @dw				= 2
	declare @cnt			int						set @cnt			= 0
	declare @cnt2			int						set @cnt2			= 0
	declare @schoolname		varchar(128)			set @schoolname		= @paramstr_
	declare @schoolkind		int						set @schoolkind		= @paramint_
	declare @schoolidxnew	int						set @schoolidxnew	= @paramint_
	declare @point			bigint					set @point			= 0

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG 입력정보', @gameid_ gameid_, @password_ password_, @mode_ mode_, @paramint_ paramint_, @paramstr_ paramstr_

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	select
		@gameid 		= gameid,
		@schoolidxcur	= schoolidx
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 유저정보', @gameid gameid, @schoolidxcur schoolidxcur

	------------------------------------------------
	-- 3-3. 각 조건별 분기
	------------------------------------------------
	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR 아이디가 존재하지 않는다.'
			--select 'DEBUG ' + @comment

			select @nResult_ rtn, @comment comment
		END
	else if (@mode_ not in (@SCHOOLRANK_MODE_SCHOOLBANK_SEARCH, @SCHOOLRANK_MODE_SCHOOLBANK_JOIN, @SCHOOLRANK_MODE_SCHOOLTOP, @SCHOOLRANK_MODE_SCHOOLUSERLIST))
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment 	= 'ERROR 지원하지 않는 모드입니다.'
			--select 'DEBUG ' + @comment

			select @nResult_ rtn, @comment comment
		END
	else if (@mode_ = @SCHOOLRANK_MODE_SCHOOLBANK_SEARCH)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'SUCCESS 검색모드.'
			--select 'DEBUG ' + @comment

			--------------------------------------------------------------
			-- 결과전송.
			--------------------------------------------------------------
			select @nResult_ rtn, @comment comment

			--------------------------------------------------------------
			-- 학교대항정보.
			--------------------------------------------------------------
			set @schoolname = '%' + @schoolname + '%'

			select top 10 * from dbo.tSchoolBank
			where schoolkind = @schoolkind and schoolname like @schoolname
		END
	else if (@mode_ = @SCHOOLRANK_MODE_SCHOOLTOP)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'SUCCESS 학교대항 10위 + 내순위.'
			--select 'DEBUG ' + @comment

			--------------------------------------------------------------
			-- 결과전송.
			--------------------------------------------------------------
			select @nResult_ rtn, @comment comment

			--------------------------------------------------------------
			-- 학교대항정보.
			-- 현재 학교순위       (           학교순위 + MY             )
			--------------------------------------------------------------
			exec spu_SchoolRank  4, -1, @gameid_
		END
	else if (@mode_ = @SCHOOLRANK_MODE_SCHOOLUSERLIST)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'SUCCESS 소속 Top 10위 + 내순위.'
			--select 'DEBUG ' + @comment

			--------------------------------------------------------------
			-- 결과전송.
			--------------------------------------------------------------
			select @nResult_ rtn, @comment comment

			--------------------------------------------------------------
			-- 학교대항정보.
			-- 현재 학교내 유저순위(유저이름 > 학교번호 > 학교인원들 순위 + MY)
			--------------------------------------------------------------
			if(@paramint_ != -1)
				begin
					exec spu_SchoolRank  7, @paramint_, ''
				end
			else
				begin
					exec spu_SchoolRank  5, -1, @gameid_
				end
		END
	else if (@mode_ = @SCHOOLRANK_MODE_SCHOOLBANK_JOIN)
		BEGIN

			set @dw = datepart(dw, getdate())	-- 일(1), 월(2)
			select @cnt  = cnt from dbo.tSchoolMaster where schoolidx = @schoolidxnew
			--select 'DEBUG 가입모드 선택되었습니다.', @schoolidxcur schoolidxcur, @schoolidxnew schoolidxnew, @cnt cnt, case when @dw = 1 then '일요일(가입불가)' when @dw = 2 then '월요일(가입,이동)' when @dw = 3 then '화요일(가입)' when @dw = 4 then '수요일(가입)' when @dw = 5 then '목요일(가입)' when @dw = 6 then '금요일(가입)' when @dw = 7 then '토요일(가입)' else 'xx요일' end

			if(@schoolidxcur != -1 and @dw != @WHAT_DAY_MONDAY)
				begin
					set @nResult_ 	= @RESULT_ERROR_CANNT_CHANGEDAY_SCHOOL
					set @comment 	= 'ERROR 가입한 유저는 월요일만 재가입됩니다.'
					--select 'DEBUG ' + @comment
				end
			else if(@dw = @WHAT_DAY_SUNDAY)
				begin
					set @nResult_ 	= @RESULT_ERROR_CANNT_JOINDAY_SCHOOL
					set @comment 	= 'ERROR 일요일에는 불가능합니다.'
					--select 'DEBUG ' + @comment
				end
			else if(@schoolidxnew = -1)
				begin
					set @nResult_ 	= @RESULT_ERROR_CANNT_FIND_SCHOOL
					set @comment 	= 'ERROR 찾을 수 없습니다.(schoolidxnew:-1)'
					--select 'DEBUG ' + @comment
				end
			else if(not exists(select top 1 * from dbo.tSchoolBank where schoolidx = @schoolidxnew))
				begin
					set @nResult_ 	= @RESULT_ERROR_CANNT_FIND_SCHOOL
					set @comment 	= 'ERROR 찾을 수 없습니다.(bank not found)'
					--select 'DEBUG ' + @comment
				end
			else if(@cnt >= @SCHOOL_MAX)
				begin
					set @nResult_ 	= @RESULT_ERROR_CANNT_JOINMAX_SCHOOL
					set @comment 	= 'SUCCESS 맥스 인원을 초과했습니다.'
					--select 'DEBUG ' + @comment
				end
			else if(@schoolidxcur = @schoolidxnew)
				begin
					set @nResult_ 	= @RESULT_SUCCESS
					set @comment 	= 'SUCCESS 새로 가입했습니다.(동일한곳 재가입)'
					--select 'DEBUG ' + @comment
				end
			else
				begin
					set @nResult_ 	= @RESULT_SUCCESS
					set @comment 	= 'SUCCESS 새로 가입했습니다.'
					select @point 	= point from dbo.tSchoolUser where gameid = @gameid_
					--select 'DEBUG ' + @comment, @schoolidxcur schoolidxcur, @schoolidxnew schoolidxnew, @point point

					---------------------------------------
					-- 1-1. 탈퇴처리 > 차감처리.
					---------------------------------------
					if(@schoolidxcur != -1)
						begin
							update dbo.tSchoolMaster
								set
									cnt 		= case when (cnt - 1) < 0 then 0 else (cnt - 1) end,
									totalpoint 	= totalpoint - @point
							where schoolidx = @schoolidxcur

							--select 'DEBUG 1-1. 기존가입 탈퇴 > 인력감소, 포인트감소', cnt, totalpoint from dbo.tSchoolMaster where schoolidx = @schoolidxcur
						end
					else
						begin
							set @point = @point
							--select 'DEBUG 1-1. 기존없음'
						end

					-----------------------
					-- 2-1. 마스터 가입
					-----------------------
					if(not exists(select top 1 * from dbo.tSchoolMaster where schoolidx = @schoolidxnew))
						begin
							-- 학교가 새롭게 들어오면 생성해준다.
							insert into tSchoolMaster(schoolidx,  cnt, totalpoint)
							values(                  @schoolidxnew, 1,     @point)
						end
					else
						begin
							update dbo.tSchoolMaster
								set
									cnt 		= cnt + 1,
									totalpoint 	= totalpoint + @point
							where schoolidx = @schoolidxnew
						end
					--select 'DEBUG 2-1. 마스터 인원추가', @schoolidxnew schoolidxnew, @gameid_ gameid_, @point point, cnt, totalpoint from dbo.tSchoolMaster where schoolidx = @schoolidxnew

					-----------------------
					-- 2-2. 유저 가입하기.
					-----------------------
					if(not exists(select top 1 * from dbo.tSchoolUser where gameid = @gameid_))
						begin
							--select 'DEBUG 3-1. 학교유저서브 insert'
							insert into dbo.tSchoolUser(schoolidx,     gameid,   point)
							values(                    @schoolidxnew, @gameid_,      0)
						end
					else
						begin
							--select 'DEBUG 3-2. 학교유저서브 update'
							update dbo.tSchoolUser
								set
									schoolidx 	= @schoolidxnew
							where gameid = @gameid_
						end

					----------------------------------
					-- 3-1. 유저 정보 갱신하기
					----------------------------------
					----select 'DEBUG 4-1. 유저마스터 (학교대항전 기입)', @gameid_ gameid_, @schoolidxnew schoolidxnew
					update dbo.tUserMaster
						set
							schoolidx = @schoolidxnew
					where gameid = @gameid_

					----------------------------------
					-- 학교대항전정보.
					----------------------------------
				end

			--------------------------------------------------------------
			-- 결과전송.
			--------------------------------------------------------------
			select @nResult_ rtn, @comment comment

			if( @nResult_ = @RESULT_SUCCESS)
				begin
					-- 학교이름.
					set @schoolname = ''
					select @schoolname = isnull(schoolname, '') from dbo.tSchoolBank where schoolidx = @schoolidxnew

					select @schoolname schoolname, @schoolidxnew schoolidx
				end
		END
	else
		begin
			set @nResult_ 	= @RESULT_ERROR
			set @comment 	= 'ERROR 알수없는 오류(-1)'

			select @nResult_ rtn, @comment comment
		end

	------------------------------------------------
	--	4-2. 유저정보
	------------------------------------------------
	set nocount off
End

