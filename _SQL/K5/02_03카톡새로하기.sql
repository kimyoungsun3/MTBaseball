/*
--select * from dbo.tUserMaster where schoolidx != -1 and kakaouserid != ''
--select * from dbo.tKakaoMaster where gameid = 'guest115966'
--exec spu_SchoolInfo 'guest115966', '049000s1i0n7t8445289', 2, 1, '', -1			-- 가입모드
exec spu_NewStart 'xxxx11',  '049000s1i0n7t8445289', 'farmFB7940F66C204CD', -1
*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_NewStart', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_NewStart;
GO

create procedure dbo.spu_NewStart
	@gameid_				varchar(20),						-- 게임아이디
	@password_				varchar(20),						-- 암호화해서저장, 유저패스워가 해킹당해도 안전
	@kakaouserid_			varchar(60),						-- 카톡정보.
	@nResult_				int				OUTPUT
	--WITH ENCRYPTION -- 프로시져를 암호화함.
as
	------------------------------------------------
	--	2-1. 에러코드값
	------------------------------------------------
	-- 일반값
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	-- 로그인 오류.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함

	-- 진행중 or 새로하기.
	declare @KAKAO_STATUS_CURRENTING  			int				set @KAKAO_STATUS_CURRENTING			= 1				-- 현재게임 진행상태
	declare @KAKAO_STATUS_NEWSTART  			int				set @KAKAO_STATUS_NEWSTART				= -1			-- 새롭하기한상태

	-- 삭제상태값.
	declare @DELETE_STATE_NO					int					set	@DELETE_STATE_NO				= 0	-- 삭제상태아님
	declare @DELETE_STATE_YES					int					set	@DELETE_STATE_YES				= 1	-- 삭제상태

	declare @NEW_START_INIT_LV					int					set @NEW_START_INIT_LV				= 15		-- 새로시작하기 시간초기화모델.
	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @comment		varchar(128)
	declare	@kakaouserid	varchar(60)		set @kakaouserid	= ''
	declare @gameid			varchar(20)		set @gameid			= ''
	declare @famelv 		int				set @famelv			= 1
	declare @gameid2		varchar(20)		set @gameid2		= ''
	declare @schoolidx		int,
			@point			int

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	set @comment = '알수 없는 오류가 발생했습니다.'
	--select 'DEBUG 1', @gameid_ gameid_, @password_ password_, @kakaouserid_ kakaouserid_

	------------------------------------------------
	--	3-2. 정보획득
	------------------------------------------------
	select
		@gameid = gameid
	from dbo.tKakaoMaster
	where kakaouserid = @kakaouserid_

	select
		@gameid2 	= gameid,	@famelv	= famelv,
		@schoolidx 	= schoolidx
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 2', @gameid gameid, @gameid2 gameid2

	------------------------------------------------
	--	3-3. 유저생성.
	------------------------------------------------
	if (@gameid = '' and @gameid != @gameid2)
		begin
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '새로하기를 하였습니다.(기존삭제됨)'
			--select 'DEBUG 3' + @comment
		end
	else if (@gameid = '' or @gameid2 = '' or @gameid != @gameid2)
		begin
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR 아이디가 존재하지 않는다.'
			--select 'DEBUG 3' + @comment
		end
	else if(@gameid = @gameid2)
		begin
			set @nResult_ = @RESULT_SUCCESS
			set @comment = '새로하기를 하였습니다.'
			--select 'DEBUG 4', @comment

			-----------------------------------
			-- 카톡 마스터에 클리어해두기.
			-----------------------------------
			update dbo.tKakaoMaster
				set
					gameid 	= '',
					cnt 	= cnt + 1,
					deldate	= case
									when @famelv >= @NEW_START_INIT_LV then ( getdate() - 0.958 )
									else					                ( getdate()         )
							  end
			where kakaouserid = @kakaouserid_
			--select 'DEBUG > 카톡마스터 클리어'
			-----------------------------------
			-- 친구들 정보를 상호관에 정리해주기.
			-----------------------------------
			exec sup_subDelFriend @gameid_


			-----------------------------------
			-- 학교 탈퇴하기
			-- 1-1. 기존가입 여부 확인 > 차감처리.
			---------------------------------------
			if(@schoolidx != -1)
				begin
					---------------------------------
					-- 학교 개인점수를 차감.
					-- 가입전 (100) 					=>  100
					-- 					가입후 (100) 	=>  200
					-- 탈퇴시							=> -200
					---------------------------------
					select @point = point from dbo.tSchoolUser where gameid = @gameid_

					-- 개인정보초기화.
					update dbo.tSchoolUser
						set
							schoolidx	= -1,
							point 		= 0
					where gameid = @gameid_

					-- 마스터 정보 초기화.
					update dbo.tSchoolMaster
						set
							cnt 		= case when (cnt - 1) <= 0 then 0 else (cnt - 1) end,
							totalpoint 	= totalpoint - @point
					where schoolidx = @schoolidx
				end

			-----------------------------------
			-- 유저 마스터에 새로하기를 했다고 표시하기.
			-----------------------------------
			update dbo.tUserMaster
				set
					kakaostatus = @KAKAO_STATUS_NEWSTART,
					deletestate = @DELETE_STATE_YES,
					schoolidx 	= -1
			where gameid = @gameid_
			--select 'DEBUG > 유저마스터 클리어'
		end

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	select @nResult_ rtn, @comment comment

	--최종 결과를 리턴한다.
	set nocount off
End



