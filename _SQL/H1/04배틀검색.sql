---------------------------------------------------------------
/*
--select * from dbo.tUserMaster where gameid = 'DD1'
--select * from tBattleLogSearch where gameid = 'SangSang1'
--select isnull(max(btidx), 1) from tBattleLogSearch where gameid = 'SangSang1' and grade = 1
--select isnull(max(btidx), 1) from tBattleLogSearch where gameid = 'SangSang1' and grade = 9
--select isnull(max(btidx), 1) from tBattleLogSearch where gameid = 'SangSang1' and grade = 20

--declare @idx bigint set @idx = 70075
--select top 1 * from dbo.tBattleLog where gameid != 'SangSang' and idx > @idx
--select top 1 * from dbo.tBattleLog where gameid != 'SangSang' and (grade between 1 and 6) and idx > @idx
--select top 1 * from dbo.tBattleLog where gameid != 'SangSang' and idx > @idx and (grade between 1 and 6)
--select top 1 * from dbo.tBattleLog where gameid != 'SangSang' and (grade >= 1 and grade <= 6) and idx > @idx
--select top 1 * from dbo.tBattleLog where gameid != 'SangSang' and idx > @idx and (grade >= 1 and grade <= 6)


[배틀검색]
gameid=xxx
btgameid=xxx

-- 강제로 검색하기
-- delete tBattleLogSearchJump where gameid = 'SangSang'
-- delete tBattleLogSearch where gameid = 'SangSang'
select count(*) from tBattleLogSearch
select count(*) from tBattleLogSearch where gameid = 'SangSang'
select count(*) from tBattleLog
select top 10 * from tBattleLog

select * from dbo.tBattleLogSearchJump where gameid = 'parkd'  order by idx desc
select * from dbo.tBattleLogSearch where gameid = 'parkd'  order by idx desc
select * from dbo.tBattleLog where gameid = 'parkd'  order by idx desc
select * from dbo.tUserMaster where gameid = 'parkd'



declare @var int
set @var = 1
while @var < 500
	begin
		exec spu_BattleSearch 'SangSang', '', 5, -1
		set @var = @var + 1
	end

update dbo.tUserMaster set grade = 1  where gameid = 'SangSang'
exec spu_BattleSearch 'SangSang', '', 5, -1			--처음검색
exec spu_BattleSearch 'SangSang', 'SangSang5', 5, -1	--연속검색
exec spu_BattleSearch 'SangSang', 'DD', 5, -1			--연속검색 > 유저존재안함 > 신규로인식
exec spu_BattleSearch 'SangSang', 'DD6', 5, -1			--연속검색 > 유저존재, 로그존재안함 > 신규로 인식

update dbo.tUserMaster set grade = 10  where gameid = 'park'
exec spu_BattleSearch 'parkd', '', 5, -1			--처음검색
exec spu_BattleSearch 'parkd', 'leaguefaz', 5, -1	--연속검색

update dbo.tUserMaster set grade = 20  where gameid = 'SangSang'
exec spu_BattleSearch 'SangSang', '', 5, -1		--처음검색
exec spu_BattleSearch 'SangSang', 'SangSang7', 5,  -1	--연속검색

update dbo.tUserMaster set grade = 30  where gameid = 'SangSang'
exec spu_BattleSearch 'SangSang', '', 5, -1			--처음검색
exec spu_BattleSearch 'SangSang', 'SangSang20', 5, -1	--연속검색

update dbo.tUserMaster set grade = 40  where gameid = 'SangSang'
exec spu_BattleSearch 'SangSang', '', 5, -1			--처음검색
exec spu_BattleSearch 'SangSang', 'SangSang19', 5, -1	--연속검색

update dbo.tUserMaster set grade = 50, lv = 45 where gameid = 'SangSang'
exec spu_BattleSearch 'SangSang', '', 5, -1			--처음검색
exec spu_BattleSearch 'SangSang', 'SangSang44', 5, -1	--연속검색

update dbo.tUserMaster set grade = 50, lv = 50  where gameid = 'SangSang'
exec spu_BattleSearch 'SangSang', '', 5, -1			--처음검색
exec spu_BattleSearch 'SangSang', 'SangSang12', 5, -1	--연속검색


exec spu_BattleSearch 'AAA', '', 5, -1
exec spu_BattleSearch 'superman', '', 5, -1			--처음검색
exec spu_BattleSearch 'superman', 'personaways404', 5, -1		--연속검색
exec spu_BattleSearch 'superman', '', 6, -1			--처음검색
exec spu_BattleSearch 'superman', 'DD1', 6, -1		--연속검색

-- 'mogly'
declare @loop int set @loop = 1
while @loop < 10
	begin
		--exec spu_BattleSearch 'superman7', '', 5, 0, -1			--연속검색 없으면 > 다른것으로 변경
		--exec spu_BattleSearch 'superman7', '', 5, 1, -1			--연속검색 없으면 > 처음부터
		--exec spu_BattleSearch 'superman7', 'superman', 5, 0, -1	--연속검색 없으면 다른것으로 변경		-- 검색 > 없으면 다른유저검색(짤라먹은 것이 있어 확장함)
		--exec spu_BattleSearch 'superman7', 'superman', 5, 1, -1	--연속검색 없으면 > 처음부터			-- 검색 > 없으면 처음부터(짤라먹은 것이 있어 확장함)

		--exec spu_BattleSearch 'superman7', 'mogly', 5, 0, -1		-- 정상처리
		exec spu_BattleSearch 'superman7', 'mogly', 5, 1, -1
		set @loop = @loop + 1
	end

exec spu_BattleSearch 'superman', 'mogly', 5, 1, -1
http://14.63.218.20:8989/Game4/hlskt/btsearch.jsp?gameid=superman&btgameid=mogly&gmode=5&tmode=1
*/

IF OBJECT_ID ( 'dbo.spu_BattleSearch', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_BattleSearch;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_BattleSearch
	@gameid_								varchar(20),		-- 게임아이디
	@btgameid_								varchar(20),
	@gmode_									int,
	@tmode_									int,
	@nResult_								int					OUTPUT
	WITH ENCRYPTION -- 프로시져를 암호화함.

as
	------------------------------------------------
	--	2-1. 코드값자리
	------------------------------------------------
	-- 일반값
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	--가입 오류.
	declare @RESULT_ERROR_ID_DUPLICATE			int				set @RESULT_ERROR_ID_DUPLICATE			= -2
	declare @RESULT_ERROR_EMAIL_DUPLICATE		int				set @RESULT_ERROR_EMAIL_DUPLICATE		= -3

	-- 로그인 오류.
	declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--블럭유저 > 팝업처리후 인트로로 빼버린다.
	declare @RESULT_ERROR_DELETED_USER 			int				set @RESULT_ERROR_DELETED_USER			= -12			--삭제유저 > 팝업처리후 인트로로 빼버린다.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함
	declare @RESULT_ERROR_NOT_FOUND_PASSWORD	int				set @RESULT_ERROR_NOT_FOUND_PASSWORD	= -17
	declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--서버를 점검하고 있다.
	declare @RESULT_NEWVERION_CLIENT_DOWNLOAD 	int				set @RESULT_NEWVERION_CLIENT_DOWNLOAD	= -15			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 링크처리.
	declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 종료.

	-- 게임중에 부족.
	declare @RESULT_ERROR_ACTION_LACK			int				set @RESULT_ERROR_ACTION_LACK			= -20			--행동력이 부족하다.
	declare @RESULT_ERROR_SILVERBALL_LACK		int				set @RESULT_ERROR_SILVERBALL_LACK		= -21			--실버가 부족하다.
	declare @RESULT_ERROR_GOLDBALL_LACK			int				set @RESULT_ERROR_GOLDBALL_LACK			= -22			--골드가 부족하다.
	declare @RESULT_ERROR_ITEM_LACK				int				set @RESULT_ERROR_ITEM_LACK				= -23			--아이템이부족하다.
	declare @RESULT_ERROR_COIN_LACK				int				set @RESULT_ERROR_COIN_LACK				= -24			--코인잉 부족하다.

	-- 아이템 구매, 변경.
	declare @RESULT_ERROR_BUY_ALREADY			int				set @RESULT_ERROR_BUY_ALREADY			= -31			--이미 구매했습니다.
	declare @RESULT_ERROR_NOT_HAVE				int				set @RESULT_ERROR_NOT_HAVE				= -32			--보유하지 않고 있다.
	declare @RESULT_ERROR_UPGRADE_CANNT			int				set @RESULT_ERROR_UPGRADE_CANNT			= -33			--업그레이드를 할수 없다.
	declare @RESULT_ERROR_UPGRADE_FAIL			int				set @RESULT_ERROR_UPGRADE_FAIL			= -34			--업그레이드 실패.
	declare @RESULT_ERROR_UPGRADE_FULL			int				set @RESULT_ERROR_UPGRADE_FULL			= -35			--업그레이드가 풀로되었다.
	declare @RESULT_ERROR_ITEM_EXPIRE			int				set @RESULT_ERROR_ITEM_EXPIRE			= -36			--아이템이 만기 되었다.

	-- 캐쉬구매.
	declare @RESULT_ERROR_CASH_COPY				int				set @RESULT_ERROR_CASH_COPY				= -40
	declare @RESULT_ERROR_CASH_OVER				int				set @RESULT_ERROR_CASH_OVER				= -41
	declare @RESULT_ERROR_MONTH_OVER			int				set @RESULT_ERROR_MONTH_OVER			= -42			--한달동안 구매한도를 검사

	-- 아이템선물
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- 아이템코드못찾음
	declare @RESULT_ERROR_GIFTITEM_NOT_FOUND	int				set @RESULT_ERROR_GIFTITEM_NOT_FOUND	= -51			-- 선물아이템을 못찾음
	declare @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	int				set @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	= -52			-- 선물을 이미 가져감

	-- 기타오류
	declare @RESULT_ERROR_RESULT_COPY			int				set @RESULT_ERROR_RESULT_COPY			= -53			-- 결과카피시도
	declare @RESULT_ERROR_SILVER_COPY			int				set @RESULT_ERROR_SILVER_COPY			= -54			-- 실버카피시도


	-- 상태값.
	declare @BLOCK_STATE_NO						int				set	@BLOCK_STATE_NO						= 0				-- 블럭상태아님
	declare @BLOCK_STATE_YES					int				set	@BLOCK_STATE_YES					= 1				-- 블럭상태
	declare @DELETE_STATE_NO					int				set	@DELETE_STATE_NO					= 0				-- 삭제상태아님
	declare @DELETE_STATE_YES					int				set	@DELETE_STATE_YES					= 1				-- 삭제상태

	-- 구매처코드
	declare @MARKET_SKT							int				set @MARKET_SKT							= 1
	declare @MARKET_KT							int				set @MARKET_KT							= 2
	declare @MARKET_LGT							int				set @MARKET_LGT							= 3
	declare @MARKET_FACEBOOK					int				set @MARKET_FACEBOOK					= 4
	declare @MARKET_GOOGLE						int				set @MARKET_GOOGLE						= 5

	-- 시스템 체킹
	declare @SYSCHECK_NON						int				set @SYSCHECK_NON						= 0
	declare @SYSCHECK_YES						int				set @SYSCHECK_YES						= 1

	-- 선물가져가기
	declare @GAINSTATE_NON						int				set @GAINSTATE_NON						= 0
	declare @GAINSTATE_YES						int				set @GAINSTATE_YES						= 1

	-- 게임시작
	declare @GAME_MODE_TRAINING					int				set @GAME_MODE_TRAINING					= 1
	declare @GAME_MODE_MACHINE					int				set @GAME_MODE_MACHINE					= 2
	declare @GAME_MODE_MEMORISE					int				set @GAME_MODE_MEMORISE					= 3
	declare @GAME_MODE_SOUL						int				set @GAME_MODE_SOUL						= 4
	declare @GAME_MODE_BATTLE					int				set @GAME_MODE_BATTLE					= 5
	declare @GAME_MODE_SPRINT					int				set @GAME_MODE_SPRINT					= 6

	declare @TARGET_MODE_NO						int				set @TARGET_MODE_NO						= 0
	declare @TARGET_MODE_YES					int				set @TARGET_MODE_YES					= 1

	-- 모드별 행동력 소모량
	declare @GAME_MODE_SINGLE_ACTION			int				set @GAME_MODE_SINGLE_ACTION					= 3
	declare @GAME_MODE_BATTLE_ACTION			int				set @GAME_MODE_BATTLE_ACTION					= 5

	-- 게임플레이 상태정보
	declare @GAME_STATE_END						int				set @GAME_STATE_END						= 0
	declare @GAME_STATE_PLAYING					int				set @GAME_STATE_PLAYING					= 1

	-- 게임중에 획득하는 레벨경험치, 등급경험치, 획득실버
	declare @GAME_SINGLE_LVEXP					int				set @GAME_SINGLE_LVEXP					= 3
	declare @GAME_BATTLE_LVEXP					int				set @GAME_BATTLE_LVEXP					= 5
	--
	declare @GAME_BATTLE_GRADEEXP				int				set @GAME_BATTLE_GRADEEXP				= 3
	declare @GAME_SINGLE_SILVERBALL_MAX			int				set @GAME_SINGLE_SILVERBALL_MAX			= 10
	declare @GAME_BATTLE_SILVERBALL_MAX			int				set @GAME_BATTLE_SILVERBALL_MAX			= 20

	declare @FLAG_CHANGE_NO						int 			set @FLAG_CHANGE_NO						= 0
	declare @FLAG_CHANGE_YES					int 			set @FLAG_CHANGE_YES					= 1

	declare @MAX_GRADE							int				set @MAX_GRADE							= 100
	declare @MAX_LV								int				set @MAX_LV								= 100
	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @gameid			varchar(20)
	declare @winstreak		int				set @winstreak 	= 0
	declare @winstreak2		int				set @winstreak2 = 0
	declare @grademax		int
	declare @grade			int				set @grade 		= 1
	declare @lv				int
	declare @btflag			int
	declare @btflag2		int
	declare @flagchange		int				set @flagchange = @FLAG_CHANGE_NO

	declare @grademin2		int
	declare @grademax2		int
	declare @grademax3		int

	declare @btgameid		varchar(20)
	declare @btgrade		int
	declare @btidx			bigint
	declare @btidx2			bigint
	declare @btIdxTotalMax 	bigint

	declare @searchidx		bigint

	declare @kind			int				set @kind = 1
	declare @comment		varchar(80)
	declare @actioncount	int				set @actioncount = 0
	declare	@actionmax		int				set @actionmax = 0
	declare	@doubledate		datetime		set @doubledate = GETDATE()

	declare @blockstate		int


Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	-- 검색을 할려는 유저
	select
		@gameid 		= gameid, 		@grademax = grademax,
		@blockstate		= blockstate,
		@winstreak		= winstreak,
		@winstreak2		= winstreak2,
		@btflag			= btflag,
		@btflag2		= btflag2,
		@grade 			= grade,  		@lv = lv,
		@doubledate		= doubledate,
		@actioncount 	= actioncount, 	@actionmax = actionmax
	from dbo.tUserMaster where gameid = @gameid_
	--select 'DEBUG1 ', @gameid gameid, @grade grade, @grademax grademax, @winstreak winstreak, @winstreak2 winstreak2


	-- 상대 유저 존재하는가?
	if(isnull(@btgameid_, '') != '')
		begin
			declare @e1 int
			set @e1 = -1
			--select 'DEBUG1_2 상대유저 존재:' + @btgameid_ + ' 배틀로그 > 유무확인해볼까?'
			if(exists(select top 1 * from dbo.tUserMaster where gameid = @btgameid_))
				begin
					--select 'DEBUG1_3 상대로그 존재?'
					if(exists(select top 1 * from dbo.tBattleLog where gameid = @btgameid_))
						begin
							--select 'DEBUG1_4 상대유저, 로그도 한개 이상존재'
							set @e1 = 1
						end
				end

			if(@e1 != 1)
				begin
					--select 'DEBUG1_5 상대유저나 로그가 존재안함 > 상대 널처리'
					set @btgameid_ = null
				end
		end

	------------------------------------------------
	--	배틀/스프린트 진행중 -> 연승 초기화
	------------------------------------------------
	if(isnull(@gameid, '') != '')
		begin
			if(@gmode_ = @GAME_MODE_BATTLE and @btflag = @GAME_STATE_PLAYING)
				begin
					--select 'DEBUG2_1 배틀모드 > 진행중 > 클리어'
					set @winstreak 	= 0
					set @btflag 	= @GAME_STATE_END
					set @flagchange = @FLAG_CHANGE_YES
				end
			 else if(@gmode_ = @GAME_MODE_SPRINT and @btflag2 = @GAME_STATE_PLAYING)
				begin
					--select 'DEBUG2_2 스프린트모드 > 진행중 > 클리어'
					set @winstreak2 = 0
					set @btflag2 	= @GAME_STATE_END
					set @flagchange = @FLAG_CHANGE_YES
				end
		end

	------------------------------------------------
	--	grade 범위 결정1
	------------------------------------------------
	--if(@grademax > 0)
	--	begin
	--		set @grademax3 = @grademax
	--	end
	--else
	--	begin
	--		set @grademax3 = @grademax * (-1)
	--	end
	--set @grademin2 = @grade - (3 + @grademax3)
	--set @grademax2 = @grade + (3 + @grademax3)
	--
	--if(@grademin2 < 1 )
	--	begin
	--		set @grademin2 = 1
	--	end
	--if(@grademax2 > 50 )
	--	begin
	--		set @grademax2 = 50
	--	end
	--
	--if(@grademin2 > @grademax2)
	--	begin
	--		set @grademin2 = @grade - 3
	--		set @grademax2 = @grade + 3
	--	end
	--
	--if(@grade >= 50 and @lv >= 50)
	--	begin
	--		set @grademin2 = 50
	--		set @grademax2 = 50
	--	end
	--select 'DEBUG3 ', @grademin2 grademin2, @grademax2 grademax2

	------------------------------------------------
	--	grade 범위 결정2
	------------------------------------------------
	if(@gmode_ = @GAME_MODE_BATTLE)
		begin
			--select 'DEBUG4_1 배틀모드'
			--set @grademin2 = @grade + @winstreak - 3
			--set @grademax2 = @grade + @winstreak + 3

			set @grademin2 = @grade + @winstreak - 10
			set @grademax2 = @grade + @winstreak + 3
		end
	else
		begin
			--select 'DEBUG4_2 스프린트모드'
			-- 어려움
			--set @grademin2 = @grade + @winstreak2 * 1 - 5
			--set @grademax2 = @grade + @winstreak2 * 3

			-- 처음은 쉽고 나중은 어렵게 > 어렵다.
			--set @grademin2 = @winstreak2 * @winstreak2 * 0.617 + @grade / 3
			--set @grademax2 = @winstreak2 * @winstreak2 * 0.617 + @grade / 3

			-- 업에따른 균등하게
			--set @grademin2 = @winstreak2 * @winstreak2 * 0.5 + @grade * 0.6
			--set @grademax2 = @winstreak2 * @winstreak2 * 0.5 + @grade * 0.6

			-- 위에것에 1/2
			set @grademin2 = @winstreak2 * @winstreak2 * 0.2 + @grade * 0.6
			set @grademax2 = @winstreak2 * @winstreak2 * 0.2 + @grade * 0.8
		end
	--select 'DEBUG4_3 ', @grademin2 grademin2, @grademax2 grademax2


	if(@grademin2 < 1 )
		begin
			set @grademin2 = 1
			--select 'DEBUG4_5 ' + str(@grademin2)
		end
	if(@grademax2 > @MAX_GRADE )
		begin
			set @grademax2 = @MAX_GRADE
			--select 'DEBUG4_6 ' + str(@grademax2)
		end
	else if(@grademax2 < 2)
		begin
			set @grademax2 = 2
		end

	if(@grademin2 > @grademax2)
		begin
			set @grademin2 = @grade - 3
			set @grademax2 = @grade + 3
			--select 'DEBUG4_7 ' + str(@grademin2) + ' ~ ' + str(@grademax2)
		end

	if(@grade >= @MAX_GRADE and @lv >= @MAX_LV)
		begin
			set @grademin2 = @MAX_GRADE
			set @grademax2 = @MAX_GRADE
			--select 'DEBUG4_8 ' + str(@grademin2) + ' ~ ' + str(@grademax2)
		end
	--select 'DEBUG4_9 ', @grademin2 grademin2, @grademax2 grademax2

	------------------------------------------------
	--	메모리변수
	------------------------------------------------
	declare @tBattleLog table(
		idxOrder	bigint,
		idx			bigint,
		gameid		varchar(20),
		grade		int,
		gradestar	int,
		lv			int,

		btidx		bigint,
		btgameid	varchar(20),
		btlog		varchar(1024),
		btitem		varchar(16),
		btiteminfo2	varchar(128),			--사용안함
		bttotal2	int,
		btwin2		int,
		btresult	int,
		bthit		int,
		writedate	datetime,

		bttotalpower int,
		bttotalcount int,
		btavg		int
	)

	--현재 검색의 1번 검색
	if(isnull(@gameid, '') != '')
		begin
			--------------------------------------------------------------
			-- 점프아이디 관리 > gameid존재, btgameid없음 > 신규유저
			--------------------------------------------------------------
			if(isnull(@btgameid_, '') = '')
				begin
					--select 'DEBUG5_1 상대아이디가 없음.', @btgameid_ btgameid_
					select @searchidx = searchidx from dbo.tBattleLogSearchJump where gameid = @gameid_ and grade = @grade
					--------------------------------------
					-- 점프아이디 있으면 삭제
					--------------------------------------
					if(isnull(@searchidx, -1) != -1)
						begin
							--------------------------------------------------------------
							--select 'DEBUG5_2 점프아이디가 존재하면 삭제하자!!!' + str(@searchidx)
							delete from dbo.tBattleLogSearchJump
							where gameid = @gameid_ and grade = @grade

							delete from dbo.tBattleLogSearch
							where  gameid = @gameid_ and grade = @grade and btidx >= @searchidx

							----------------------------------------
							set @kind = 2
						end
				end
			else
				begin
					--select 'DEBUG5_3 상대아이디, 로그, 범위 있는가?.', @btgameid_ btgameid_
					if(not exists(select top 1 * from tBattleLog where gameid = @btgameid_ and (grade between @grademin2 and @grademax2)))
						begin
							-- 상대아이디 	-> 존재
							-- 상대로그   	-> 존재
							-- 상대로그범위 -> 없음	> 전범위로 확장
							-- 중간에 로그를 잘라먹기해서 삭제되는 경우가 있는듯 하다.
							--select 'DEBUG5_5 상대로그범위 -> 없음	> 전범위로 확장', @btgameid_ btgameid_, @grademin2 grademin2, @grademax2 grademax2
							set @grademin2 = 1
							set @grademax2 = @MAX_GRADE
						end
				end



			-------------------------------------------------------------
			-- 검색되는 데이타는 큐의 포인트 값이 나오는 개념이다.
			-------------------------------------------------------------
			select @btidx2 = btidx from tBattleLogSearch where gameid = @gameid_ and grade = @grade
			if(isnull(max(@btidx2), -1) = -1)
				begin
					--select 'DEBUG5_10 존재[X]'
					set @btidx2 = 1
				end
			else
				begin
					--select 'DEBUG5_11 존재[O]' + str(@btidx2)
					select @btIdxTotalMax = max(idx) from dbo.tBattleLog
					if(@btidx2 >= @btIdxTotalMax)
						begin
							--select 'DEBUG5_12 @@@@ 검색위치 재갱신'
							set @btidx2 = 1
						end
				end
		end


	------------------------------------------------
	--	유저존재유무
	------------------------------------------------
	-- 계정이 없거나 블럭유저는 검색을 못함
	if ((isnull(@gameid, '') = '') or (@blockstate = @BLOCK_STATE_YES))
		begin
			set @nResult_ = @RESULT_ERROR
			set @comment = 'ERROR 유저가 미존재 or 블럭유저.'
			--select 'DEBUG7 유저 없음'
		end
	else if(isnull(@btgameid_, '') = '')
		begin
			set @nResult_ = @RESULT_SUCCESS
			if(@gmode_ = @GAME_MODE_BATTLE)
				begin
					set @comment = 'SUCCESS 유저가 신규배틀로그검색'
					--select 'DEBUG8_1 유저가 신규배틀로그검색'
				end
			else
				begin
					set @comment = 'SUCCESS 유저가 신규스프린트로그검색'
					--select 'DEBUG8_2 유저가 신규스프린트로그검색'
				end

			--select 'DEBUG8_3 유저가 신규', @btidx2 btidx2, @gameid_ gameid_, @grademin2 grademin2, @grademax2 grademax2
			--------------------------------------
			--검색관리 > 로그 검색 > 임시테이블에 넣기(한개만)
			--------------------------------------
			insert @tBattleLog
			select top 1 idxOrder, idx, gameid, grade, gradestar, lv, btidx, btgameid, btlog, btitem, btiteminfo, bttotal, btwin, btresult, bthit, writedate, bttotalpower, bttotalcount, btavg
			from dbo.tBattleLog
			where idx > @btidx2
			and gameid != @gameid_
			and (grade between @grademin2 and @grademax2)
			order by newid()
			--데이타가 많으면 삭제하자.

			--select 'DEBUG8_4 유저가 신규', * from @tBattleLog
			set @kind = 2

		end
	else
		begin
			set @nResult_ = @RESULT_SUCCESS
			if(@gmode_ = @GAME_MODE_BATTLE)
				begin
					set @comment = 'SUCCESS 유저가 연속배틀로그검색' + @btgameid_
					--select 'DEBUG9_1 유저가 연속배틀로그검색', @btgameid_ btgameid_
				end
			else
				begin
					set @comment = 'SUCCESS 유저가 연속스프린트로그검색' + @btgameid_
					--select 'DEBUG9_2 유저가 연속스프린트로그검색', @btgameid_ btgameid_
				end

			--select 'DEBUG9_3 유저가 연속', @btidx2 btidx2, @gameid_ gameid_, @grademin2 grademin2, @grademax2 grademax2, @btgameid_ btgameid_
			--------------------------------------
			--검색관리 > 로그 검색 > 임시테이블에 넣기
			--------------------------------------
			insert @tBattleLog
			select top 1 idxOrder, idx, gameid, grade, gradestar, lv, btidx, btgameid, btlog, btitem, btiteminfo, bttotal, btwin, btresult, bthit, writedate, bttotalpower, bttotalcount, btavg
			from dbo.tBattleLog
			where gameid != @gameid_ and gameid = @btgameid_
			and (grade between @grademin2 and @grademax2)
			and idx > @btidx2
			order by newid()

			--select 'DEBUG9_4 유저가 연속', * from @tBattleLog
			set @kind = 3
		end

	-- 정보를 전송
	select @nResult_ rtn, @comment, @winstreak winstreak, @winstreak2 winstreak2, @actioncount actioncount, @actionmax actionmax, @doubledate doubledate, @grade grade


	------------------------------------------------
	--	결과정리하기
	------------------------------------------------
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			-- 검색이 안뜨면 범위를 확대해서 재검색
			if(not exists(select top 1 * from @tBattleLog))
				begin
					--select 'DEBUG10_1 검색데이타없어 재검색'
					-------------------------------------------------
					-- 한바퀴를 돌았서 더이상 없으므로
					-- 처음부터 돌기 위해서는
					-- 로그를 삭제한다.
					-------------------------------------------------
					delete from dbo.tBattleLogSearch
					where gameid = @gameid_ and grade = @grade

					-------------------------------------------------
					-- 처음부터 검색을 시도한다.
					-------------------------------------------------
					set @btidx2 = 1

					-----------------------------------------
					-- 검색범위를 확대해서
					-----------------------------------------
					set @grademin2 = @grade - 10
					set @grademax2 = @grade + 5
					if(@grademin2 < 1)
						begin
							set @grademin2 = 1
						end
					if(@grademax2 > @MAX_GRADE)
						begin
							set @grademax2 = @MAX_GRADE
						end

					-----------------------------------------
					-- top 1 배틀로그 where 내아이디제외 and grade A ~ B
					-----------------------------------------
					if(@tmode_ = @TARGET_MODE_NO)
						begin
							--select 'DEBUG10_2 검색데이타없어 재검색 > 노타게팅'

							insert @tBattleLog
							select top 1 idxOrder, idx, gameid, grade, gradestar, lv, btidx, btgameid, btlog, btitem, btiteminfo, bttotal, btwin, btresult, bthit, writedate, bttotalpower, bttotalcount, btavg
							from dbo.tBattleLog
							where idx > @btidx2
							and gameid != @gameid_
							and (grade between @grademin2 and @grademax2)
							order by newid()
							--데이타가 많으면 삭제하자.
						end
					else
						begin
							--select 'DEBUG10_3 검색데이타없어 재검색 > 타게팅'

							insert @tBattleLog
							select top 1 idxOrder, idx, gameid, grade, gradestar, lv, btidx, btgameid, btlog, btitem, btiteminfo, bttotal, btwin, btresult, bthit, writedate, bttotalpower, bttotalcount, btavg
							from dbo.tBattleLog
							where gameid != @gameid_ and gameid = @btgameid_
							and (grade between @grademin2 and @grademax2)
						end
				end

			----------------------------------------------
			-- 아무리 검색해도 안나오는 경우
			----------------------------------------------
			if(not exists(select top 1 * from @tBattleLog))
				begin
					insert @tBattleLog
					select top 1 idxOrder, idx, gameid, grade, gradestar, lv, btidx, btgameid, btlog, btitem, btiteminfo, bttotal, btwin, btresult, bthit, writedate, bttotalpower, bttotalcount, btavg
					from dbo.tBattleLog
					where gameid != @gameid_
					order by newid()
				end

			-----------------------------------------------
			-- 중간에 진행중에 나간 유저의 정보를 갱신하기
			-----------------------------------------------
			--select 'DEBUG11_1 중간에 진행중에 나간 유저의 정보를 갱신 있는가?'
			if(@flagchange = @FLAG_CHANGE_YES)
				begin
					--select 'DEBUG11_2 > 있어 갱신'
					update dbo.tUserMaster
						set
							winstreak		= @winstreak,
							winstreak2		= @winstreak2,
							btflag			= @btflag,
							btflag2			= @btflag2
					from dbo.tUserMaster where gameid = @gameid
				end

			-----------------------------------------------
			-- M 검색로그기록
			--select 'DEBUG11_3 M 검색로그기록'
			select @btgameid = gameid, @btgrade = grade, @btidx = idx from @tBattleLog

			--select 'DEBUG11_4 배틀로그 검색기록'
			insert into dbo.tBattleLogSearch(gameid, grade, btgameid, btgrade, btidx)
			values(@gameid, @grade, @btgameid, @btgrade, @btidx)


			-- 배틀정보전송, 임시테이블 자동소멸
			--select 'DEBUG11_5 배틀정보전송, 임시테이블 자동소멸'
			if(@grade > 50)
				begin
					select b.*,
						isnull(u.avatar, 1) avatar,
						isnull(u.picture, '-1') picture,
						isnull(u.ccode, 1) ccode,
						u.bttotal bttotal,
						u.btwin btwin,

						-------------------------------------
						-- 유저가 플레이한 로그것
						-------------------------------------
						b.btiteminfo2 btiteminfo
					from @tBattleLog as b
						left join (select * from dbo.tUserMaster where gameid = @btgameid) as u
						on b.gameid = u.gameid
					--select * from @tBattleLog
					--select * from dbo.tUserMaster where gameid = @btgameid
				end
			else
				begin
					select b.*,
						isnull(u.avatar, 1) avatar,
						isnull(u.picture, '-1') picture,
						isnull(u.ccode, 1) ccode,
						u.bttotal bttotal,
						u.btwin btwin,

						---------------------------------------
						-- 현재것을 세팅
						---------------------------------------
						ltrim(rtrim(str(isnull(ccharacter, 0)))) + ',' +
						ltrim(rtrim(str(isnull(face, 50)))) + ',' +
						ltrim(rtrim(str(isnull(cap, 100)))) + ',' +
						ltrim(rtrim(str(isnull(cupper, 200)))) + ',' +
						ltrim(rtrim(str(isnull(cunder, 300)))) + ',' +
						ltrim(rtrim(str(isnull(bat, 400)))) + ',' +
						ltrim(rtrim(str(isnull(pet, -1)))) + ',' +
						ltrim(rtrim(str(isnull(glasses, -1)))) + ',' +
						ltrim(rtrim(str(isnull(wing, -1)))) + ',' +
						ltrim(rtrim(str(isnull(tail, -1)))) + ',' +
						isnull(customize, '1') btiteminfo

						-------------------------------------
						-- 유저가 플레이한 로그것
						-------------------------------------
						-- b.btiteminfo2 btiteminfo
					from @tBattleLog as b
						left join (select * from dbo.tUserMaster where gameid = @btgameid) as u
						on b.gameid = u.gameid
					--select * from @tBattleLog
					--select * from dbo.tUserMaster where gameid = @btgameid
				end


			if(@kind = 3)
				begin
					--------------------------------------
					-- 점프아이디 기록하기
					--------------------------------------
					--select 'DEBUG12_0 점프아이디 기록하기'
					select @searchidx = searchidx from dbo.tBattleLogSearchJump where gameid = @gameid_ and grade = @grade
					if( isnull(@searchidx, -1) = -1)
						begin
							--select 'DEBUG12_1 점프아이디를 기록하자!!!' + str(@grade)

							insert into dbo.tBattleLogSearchJump(gameid, grade, searchidx)
							values(@gameid_, @grade, @btidx)
						end
					else
						begin
							--select 'DEBUG12_2 점프아이디가 기록되어 있다.' + str(@grade)
							set @grade = @grade
						end
				end

		end

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
End

