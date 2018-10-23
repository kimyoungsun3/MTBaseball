/*
exec spu_Login 'mtxxxx3', '049000s1i0n7t8445289', 100, '192.168.0.8', -1	-- 정상유저
exec spu_Login 'xxxx', '049000s1i0n7t8445288', 100, '192.168.0.8', -1		-- 비번틀림
exec spu_Login 'xxxx0','049000s1i0n7t8445289', 100, '192.168.0.8', -1		-- 없는유저
exec spu_Login 'xxxx', '049000s1i0n7t8445289',  99, '192.168.0.8', -1		-- 마켓버젼낮음
exec spu_Login 'xxxx3','049000s1i0n7t8445289', 100, '192.168.0.8', -1		-- 블럭유저
update dbo.tUserMaster set cashcopy = 3 where gameid = 'xxxx5'				-- 캐쉬카피 > 블럭처리
exec spu_Login 'xxxx5', '049000s1i0n7t8445289', 100, '192.168.0.8', -1
update dbo.tUserMaster set resultcopy = 100 where gameid = 'xxxx6'			-- 결과키피 > 블럭처리
exec spu_Login 'xxxx6', '049000s1i0n7t8445289', 100, '192.168.0.8', -1

exec spu_Login 'xxxx', '049000s1i0n7t8445289', 199, '192.168.0.8', -1		-- 정상유저
exec spu_Login 'xxxx2', '049000s1i0n7t8445289',119, '192.168.0.8', -1		-- 정상유저
exec spu_Login 'xxxx3', '049000s1i0n7t8445289',199, '192.168.0.8', -1		-- 정상유저
exec spu_Login 'xxxx6', '049000s1i0n7t8445289',199, '192.168.0.8', -1		-- 정상유저
*/
use GameMTBaseball
Go

IF OBJECT_ID ( 'dbo.spu_Login', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_Login;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_Login
	@gameid_								varchar(20),					-- 게임아이디
	@password_								varchar(20),					-- 암호화해서저장, 유저패스워가 해킹당해도 안전
	@version_								int,							-- 클라버젼
	@connectip_								varchar(60),					-- 접속 IP
	@nResult_								int					OUTPUT
	WITH ENCRYPTION -- 프로시져를 암호화함.
as
	------------------------------------------------
	--	2-1. 코드값자리
	------------------------------------------------
	-- MT 일반값
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	-- MT 로그인 오류.
	declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--블럭유저 > 팝업처리후 인트로로 빼버린다.
	declare @RESULT_ERROR_DELETED_USER 			int				set @RESULT_ERROR_DELETED_USER			= -12			--삭제유저 > 팝업처리후 인트로로 빼버린다.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함
	declare @RESULT_ERROR_NOT_FOUND_PASSWORD	int				set @RESULT_ERROR_NOT_FOUND_PASSWORD	= -17
	declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--서버를 점검하고 있다.
	declare @RESULT_NEWVERION_CLIENT_DOWNLOAD 	int				set @RESULT_NEWVERION_CLIENT_DOWNLOAD	= -15			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 링크처리.
	declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 종료.
	declare @RESULT_ERROR_NOT_FOUND_PHONE 		int				set @RESULT_ERROR_NOT_FOUND_PHONE		= -76			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 종료.

	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------
	-- MT 블럭상태값.
	declare @BLOCK_STATE_NO						int					set	@BLOCK_STATE_NO							= 0	-- 블럭상태아님
	declare @BLOCK_STATE_YES					int					set	@BLOCK_STATE_YES						= 1	-- 블럭상태

	-- MT 시스템 체킹
	declare @SYSCHECK_NON						int					set @SYSCHECK_NON							= 0
	declare @SYSCHECK_YES						int					set @SYSCHECK_YES							= 1

	-- MT 아이템별 인벤분류
	declare @USERITEM_INVENKIND_WEAR			int 				set @USERITEM_INVENKIND_WEAR				= 1
	declare @USERITEM_INVENKIND_PIECE			int 				set @USERITEM_INVENKIND_PIECE				= 2
	declare @USERITEM_INVENKIND_CONSUME			int 				set @USERITEM_INVENKIND_CONSUME				= 3

	-- 배팅상태.
	declare @GAME_STATE_ING						int					set @GAME_STATE_ING							= -1	-- 게임진행중.
	declare @GAME_STATE_ROLLBACK				int					set @GAME_STATE_ROLLBACK					= -2	-- 롤백예정임.
	declare @GAME_STATE_ROLLBACK_CHECK			int					set @GAME_STATE_ROLLBACK_CHECK				= -3	-- 시스템점검예정.
	declare @GAME_STATE_SUCCESS					int					set @GAME_STATE_SUCCESS						= 0		-- 정상처리.
	declare @GAME_STATE_FAIL_LOGIN_MOLSU		int					set @GAME_STATE_FAIL_LOGIN_MOLSU			= 10	-- 재로그인으로 몰수.
	declare @GAME_STATE_FAIL_LOGIN_ROLLBACK		int					set @GAME_STATE_FAIL_LOGIN_ROLLBACK			= 11	-- 재로그인으로 롤백
	declare @GAME_STATE_FAIL_ADMIN_DEL			int					set @GAME_STATE_FAIL_ADMIN_DEL				= 12	-- 관리자가 삭제함.
	declare @GAME_STATE_FAIL_ADMIN_ROLLBACK		int					set @GAME_STATE_FAIL_ADMIN_ROLLBACK			= 13	-- 관리자가 롤백처리.
	declare @GAME_STATE_FAIL_CHECK_ROLLBACK		int					set @GAME_STATE_FAIL_CHECK_ROLLBACK			= 14	-- 시스템 롤백.
	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @comment				varchar(512)			set @comment		= '로그인'
	declare @gameid					varchar(20)				set @gameid			= ''
	declare @password				varchar(20)				set @password		= ''
	declare @blockstate				int
	declare @cashcopy				int
	declare @resultcopy				int
	declare @version				int						set @version		= 100

	declare @curversion				int						set @curversion		= -1
	declare @cursyscheck			int

	-- 일반변수값
	declare @logindate				varchar(8)				set @logindate		= '20100101'
	--declare @dateid10 			varchar(10) 			set @dateid10 		= Convert(varchar(8), Getdate(),112) + Convert(varchar(2), Getdate(), 108)
	declare @dateid8 				varchar(8) 				set @dateid8 		= Convert(varchar(8), Getdate(),112)
	declare @curdate				datetime				set @curdate		= getdate()
	declare @rand					int

	-- 싱글게임 몰수, 롤백처리.
	declare @idx					int						set @idx			= -1
	declare @gamestate				int						set @gamestate		= @GAME_STATE_ING
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG 입력정보', @gameid_ gameid_, @password_ password_, @version_ version_, @connectip_ connectip_

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	select
		@gameid 		= gameid,			@password		= password,
		@blockstate 	= blockstate,
		@cashcopy 		= cashcopy, 		@resultcopy 	= resultcopy,
		@logindate		= logindate
	from dbo.tUserMaster
	where gameid = @gameid_
	--select 'DEBUG 유저정보', @gameid gameid, @password password, @blockstate blockstate, @cashcopy cashcopy, @resultcopy resultcopy, @logindate logindate

	------------------------------------------------
	--	3-3. 공지사항 체크
	------------------------------------------------
	select top 1 @cursyscheck = syscheck, @curversion = version from dbo.tNotice
	order by idx desc
	--select 'DEBUG 공지사항', @cursyscheck cursyscheck, @curversion curversion

	if(@cursyscheck = @SYSCHECK_YES)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_SERVER_CHECKING
			set @comment 	= 'DEBUG 시스템 점검중입니다.'
			--select 'DEBUG ', @comment
		END
	else if(@gameid = '' or @password != @password_)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '아이디가 존재하지 않는다. > 아이디를 확인해라.'
			--select 'DEBUG ', @comment
		END
	else if(@version_ < @curversion)
		BEGIN
			-- 마켓별 버젼이 틀리다
			set @nResult_ 	= @RESULT_NEWVERION_CLIENT_DOWNLOAD
			set @comment 	= '마켓별 버젼이 틀리다. > 다시받아라.'
			--select 'DEBUG ', @comment
		END
	else if (@blockstate = @BLOCK_STATE_YES)
		BEGIN
			-- 블럭유저인가?
			set @nResult_ 	= @RESULT_ERROR_BLOCK_USER
			set @comment 	= '블럭처리된 아이디입니다.'
			--select 'DEBUG ', @comment
		END
	else if(@cashcopy >= 2)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_BLOCK_USER
			set @comment 	= '캐쉬결재카피를 '+ltrim(rtrim(str(@cashcopy)))+'회 이상했다. > 블럭처리하자!!'
			--select 'DEBUG ', @comment

			-- xx회 이상카피행동 > 블럭처리, 블럭로그기록
			update dbo.tUserMaster
				set
					blockstate = @BLOCK_STATE_YES,
					cashcopy = 0
			where gameid = @gameid_

			-- 아이템3회 카피에 대한 블럭처리
			insert into dbo.tUserBlockLog(gameid, comment)
			values(@gameid_, '(캐쉬결재)를  '+ltrim(rtrim(str(@cashcopy)))+'회 이상 카피를 해서 로그인시 시스템에서 블럭 처리했습니다.')
		END
	else if(@resultcopy >= 20)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_BLOCK_USER
			set @comment 	= '경기결과복제를 '+ltrim(rtrim(str(@resultcopy)))+'회이상 시도했다. > 블럭처리하자!!'
			--select 'DEBUG ', @comment

			--결과복제를 xx회 이상했다. > 블럭처리, 블럭로그기록
			update dbo.tUserMaster
				set
					blockstate = @BLOCK_STATE_YES,
					resultcopy = 0
			where gameid = @gameid_

			-- 아이템3회 카피에 대한 블럭처리
			insert into dbo.tUserBlockLog(gameid, comment)
			values(@gameid_, '경기결과복제를 '+ltrim(rtrim(str(@resultcopy)))+'회이상 시도해서 로그인시 시스템에서 블럭 처리했습니다.')
		END
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '로그인 정상처리'
			--select 'DEBUG ', @comment
		END


	-----------------------------------------------
	-- 결과코드처리.
	-----------------------------------------------
	select @nResult_ rtn, @comment comment

	if(@nResult_ = @RESULT_SUCCESS)
		BEGIN
			------------------------------------------------------------------
			-- 유저 > 로그인 카운터
			------------------------------------------------------------------
			if(@logindate != @dateid8)
				begin
					exec spu_DayLogInfoStatic 12, 1               -- 일 로그인(중복)
					exec spu_DayLogInfoStatic 14, 1               -- 일 로그인(유니크)
				end
			else
				begin
					exec spu_DayLogInfoStatic 12, 1               -- 일 로그인(중복)
				end
			set @logindate = @dateid8

			-----------------------------------------------
			-- * 로그인할때 소모템 없으면 정리제거한다.
			-----------------------------------------------
			delete from dbo.tUserItem where gameid = @gameid and invenkind = @USERITEM_INVENKIND_CONSUME and cnt <= 0


			-----------------------------------------------
			-- * 기존에 배팅검사
			--	-1 -> 재로그인으로몰수(10)
			--		  전부 환수 처리해버림…
			--	-2 -> 재로그인으로롤백(11)
			--		  전부(소모템, 조각) 롤백처리해서 돌려줌.
			-----------------------------------------------
			declare curSingleGame Cursor for
			select idx, gamestate from dbo.tSingleGame where gameid = @gameid_ order by idx asc

			Open curSingleGame
			Fetch next from curSingleGame into @idx, @gamestate
			while @@Fetch_status = 0
				Begin
					--select 'DEBUG 싱글처리', @idx idx, @gamestate gamestate
					if( @gamestate = @GAME_STATE_ING )
						begin
							--select 'DEBUG -1 > 몰수처리', @idx idx, @gamestate gamestate
							exec dbo.spu_BetRollBack @GAME_STATE_FAIL_LOGIN_MOLSU, @gameid_, @idx
						end
					else if( @gamestate = @GAME_STATE_ROLLBACK )
						begin
							--select 'DEBUG -2 > 롤백처리', @idx idx, @gamestate gamestate
							exec dbo.spu_BetRollBack @GAME_STATE_FAIL_LOGIN_ROLLBACK, @gameid_, @idx
						end
					else if( @gamestate = @GAME_STATE_ROLLBACK_CHECK )
						begin
							--select 'DEBUG -3 > 롤백처리', @idx idx, @gamestate gamestate
							exec dbo.spu_BetRollBack @GAME_STATE_FAIL_CHECK_ROLLBACK, @gameid_, @idx
						end


					Fetch next from curSingleGame into @idx, @gamestate
				end
			close curSingleGame
			Deallocate curSingleGame


			-----------------------------------------------
			-- * 연습모드는 전부 삭제함.
			-----------------------------------------------
			delete from dbo.tPracticeGame where gameid = @gameid_

			------------------------------------------------------------------
			-- 유저 정보를 업데이트하기
			------------------------------------------------------------------
			update dbo.tUserMaster
				set
					version			= @version_,
					connectip		= @connectip_,
					logindate		= @logindate,	-- 로그인날짜별.

					sid				= dbo.fnu_GetRandom( 100, 10000),

					condate			= getdate(),	-- 최종접속일
					concnt			= concnt + 1	-- 접속횟수 +1
			where gameid = @gameid_

			----------------------------------------------
			-- 유저 정보
			---------------------------------------------
			select
				*, @curdate curdate
			 from dbo.tUserMaster where gameid = @gameid_

			--------------------------------------------------------------
			-- 유저 보유템 전체 리스트
			-- 동물(동물병원[최근것], 인벤, 필드, 대표), 소비템, 악세사리
			--------------------------------------------------------------
			select * from dbo.tUserItem
			where gameid = @gameid_ and invenkind in (@USERITEM_INVENKIND_WEAR, @USERITEM_INVENKIND_PIECE, @USERITEM_INVENKIND_CONSUME )
			order by invenkind, itemcode

			--------------------------------------------------------------
			-- 유저 선물/쪽지(존재, 쪽지기능보유 통합)
			--------------------------------------------------------------
			exec spu_GiftList @gameid_

			------------------------------------------------------------------
			-- 공지사항
			------------------------------------------------------------------
			select top 1 * from dbo.tNotice order by idx desc

		END

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
End



