/*
-- listidx:11 -> 응원의 소리(4600)
-- 싱글게임 배팅 > 1번만선택, 스트라이트(0) x 1개
--                 2 ~ 4번 미선택
-- select=번호:select:cnt;
--        [1번자리] : STRIKE( 0 ) : 수량(1) )
-- update dbo.tLottoInfo set nextturndate = DATEADD(ss, 0+5*60, getdate() ) where idx = ( select top 1 idx from dbo.tLottoInfo order by curturntime desc)
declare @curturntime int  		select top 1 @curturntime = nextturntime from tLottoInfo order by curturntime desc
--declare @select varchar(100)	set @select = '1:-1:0; 2:-1:0; 3:-1:0; 4:-1:0;'	-- 0개 배팅
--declare @select varchar(100)	set @select = '1:0:100;2:-1:0; 3:-1:0; 4:-1:0;'	-- 1개 배팅
declare @select varchar(100)	set @select = '1:0:100;2:0:100;3:0:100;4:0:100;'	-- 4개 배팅

--delete from dbo.tSingleGame      	where gameid = 'mtxxxx3' and curturntime = (select top 1 nextturntime from tLottoInfo order by curturntime desc)
--delete from dbo.tSingleGameLog   	where gameid = 'mtxxxx3' and curturntime = (select top 1 nextturntime from tLottoInfo order by curturntime desc)
exec spu_SGBet 'mtxxxx3', '049000s1i0n7t8445289', 333, 1, 11, @curturntime, @select, -1

-- select * from dbo.tSingleGame		where gameid = 'mtxxxx3' order by curturntime desc
-- delete from dbo.tSingleGame      	where gameid = 'mtxxxx3' and curturntime = (select top 1 nextturntime from tLottoInfo order by curturntime desc)
-- select top 1 nextturntime from tLottoInfo order by curturntime desc


-- 싱글게임 배팅 : 돌 상의 조각 A(1600) x 1	-> 배팅불가
--        [1번자리] : STRIKE( 0 ) : 수량(1) )
declare @curturntime int  		select top 1 @curturntime = nextturntime from tLottoInfo order by curturntime desc
declare @select varchar(100)	set @select = '1:0:1;2:-1:0;3:-1:0;4:-1:0;'
exec spu_SGBet 'mtxxxx3', '049000s1i0n7t8445289', 333, 1, 11, @curturntime, @select, -1

-- 관람만 할경우... > 던지면 안된다.
declare @curturntime int  		select top 1 @curturntime = nextturntime from tLottoInfo order by curturntime desc
declare @select varchar(100)	set @select = ''	-- 아무것도 없음.
exec spu_SGBet 'mtxxxx3', '049000s1i0n7t8445289', 333, 1, 11, @curturntime, @select, -1


-- 강제로 데이타를 백업하고 롤돌린경우.
--update dbo.tSingleGame set gamestate = -2 where gameid = 'mtxxxx3' and idx = 56
delete from dbo.tSingleGame where gameid = 'mtxxxx3' and curturntime in ( 828644, 828643, 828645 )
delete from dbo.tSingleGameLog where gameid = 'mtxxxx3' and  curturntime in ( 828644, 828643, 828645 )
insert into tSingleGame (
							gameid,
							curturntime, curturndate, gamemode, consumeitemcode, select1, cnt1,
							select2, cnt2,
							select3, cnt3,
							select4, cnt4,
							selectdata, writedate, connectip, level, exp, commission, gamestate
						)
select
							'mtxxxx3',
							curturntime, curturndate, gamemode, consumeitemcode, select1, cnt1,
							select2, cnt2,
							select3, cnt3,
							select4, cnt4,
							selectdata, writedate, connectip, level, exp, commission, gamestate
from dbo.tSingleGame where gameid = 'mtxxxx2'
*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_SGBet', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_SGBet;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_SGBet
	@gameid_								varchar(20),					-- 게임아이디
	@password_								varchar(20),
	@sid_									int,
	@gmode_									int,
	@listidx_								int,
	@curturntime_							int,
	@select_								varchar(100),
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
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함
	declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--서버를 점검하고 있다.

	-- 기타오류
	declare @RESULT_ERROR_ITEM_LACK				int				set @RESULT_ERROR_ITEM_LACK				= -23			--아이템이부족하다.
	declare @RESULT_ERROR_GAMECOST_LACK			int				set @RESULT_ERROR_GAMECOST_LACK			= -24			--
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- 아이템코드못찾음
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- 지원하지않는모드
	declare @RESULT_ERROR_PARAMETER				int				set @RESULT_ERROR_PARAMETER				= -122			-- 파라미터오류.
	declare @RESULT_ERROR_SESSION_ID_EXPIRE_LOGOUT	int			set @RESULT_ERROR_SESSION_ID_EXPIRE_LOGOUT	= -151		-- 세션이 만료되었습니다.
	declare @RESULT_ERROR_DOUBLE_IP				int				set @RESULT_ERROR_DOUBLE_IP				= -201			-- IP중복...
	declare @RESULT_ERROR_TURNTIME_WRONG		int				set @RESULT_ERROR_TURNTIME_WRONG		= -203			-- 회차정보가 잘못되었다
	declare @RESULT_ERROR_NOT_BET_ITEMLACK		int				set @RESULT_ERROR_NOT_BET_ITEMLACK		= -204			-- 아이템을 배팅하지 않고 배팅할려고하였습니다.
	declare @RESULT_ERROR_NOT_BET_SAFETIME		int				set @RESULT_ERROR_NOT_BET_SAFETIME		= -205			-- 30초 ~ 결과 ~ 10초 이시간에는 배팅금지
	declare @RESULT_ERROR_NOT_BET_OVERTIME		int				set @RESULT_ERROR_NOT_BET_OVERTIME		= -211			-- 오버타임이상에서는 배팅불가
	declare @RESULT_ERROR_NOT_INPUT_SUPERBALL_5TRY	int			set @RESULT_ERROR_NOT_INPUT_SUPERBALL_5TRY	= -207		-- 슈퍼볼 데이터가 아직 안들어옴… > 5초후에 다시 요청
	declare @RESULT_ERROR_NOT_ING_TURNTIME			int			set @RESULT_ERROR_NOT_ING_TURNTIME		= -	208			-- 잘못된 턴 타임입니다.
	declare @RESULT_ERROR_NOT_CALCULATE_LOTTO_WAIT_LOBBY	int	set @RESULT_ERROR_NOT_CALCULATE_LOTTO_WAIT_LOBBY= -209	-- 로또에서 회차 정보가 5분이 되어도 안옴… > 로비에서 대기해주세요.
	declare @RESULT_ERROR_NOT_CALCULATE_LOTTO_LOGOUT	int		set @RESULT_ERROR_NOT_CALCULATE_LOTTO_LOGOUT= -210		-- 로또에서 회차 정보가 오버타임지나도(5+5분) 안들어옴… > 내부취소마킹, 로그아웃, 점검중…
	declare @RESULT_ERROR_ITEMCODE_GRADE_CHECK	int				set @RESULT_ERROR_ITEMCODE_GRADE_CHECK		= -212		-- 아이템 등급이 잘못되었습니다.
	declare @RESULT_ERROR_MINUMUN_LACK			int				set @RESULT_ERROR_MINUMUN_LACK				= -213		-- 최소수량보다 부족.

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

	-- MT 아이템 대분류
	declare @ITEM_MAINCATEGORY_WEARPART			int					set @ITEM_MAINCATEGORY_WEARPART 			= 1 	-- 장착템(1)
	declare @ITEM_MAINCATEGORY_PIECEPART		int					set @ITEM_MAINCATEGORY_PIECEPART			= 15 	-- 조각템(15)

	-- MT 게임모드.
	declare @GAME_MODE_PRACTICE					int					set @GAME_MODE_PRACTICE						= 0
	declare @GAME_MODE_SINGLE					int					set @GAME_MODE_SINGLE						= 1
	declare @GAME_MODE_MULTI					int					set @GAME_MODE_MULTI						= 2

	-- MT 플래그
	declare @SINGLE_FLAG_PLAY					int					set @SINGLE_FLAG_PLAY						= 1
	declare @SINGLE_FLAG_END					int					set @SINGLE_FLAG_END						= 0

	-- 플레그정보.
	declare @SELECT_1							int					set @SELECT_1						= 1		-- 스트라이크, 볼.
	declare @SELECT_2							int					set @SELECT_2						= 2		-- 직구, 변화구.
	declare @SELECT_3							int					set @SELECT_3						= 3		-- 좌, 우.
	declare @SELECT_4							int					set @SELECT_4						= 4		-- 상, 하.
	declare @BATTLE_END							int					set @BATTLE_END						= 0
	declare @SELECT_1_NON						int					set @SELECT_1_NON					= -1
	declare @SELECT_1_STRIKE					int					set @SELECT_1_STRIKE				= 0
	declare @SELECT_1_BALL						int					set @SELECT_1_BALL					= 1
	declare @SELECT_2_NON						int					set @SELECT_2_NON					= -1
	declare @SELECT_2_FAST						int					set @SELECT_2_FAST					= 0
	declare @SELECT_2_CURVE						int					set @SELECT_2_CURVE					= 1
	declare @SELECT_3_NON						int					set @SELECT_3_NON					= -1
	declare @SELECT_3_LEFT						int					set @SELECT_3_LEFT					= 0
	declare @SELECT_3_RIGHT						int					set @SELECT_3_RIGHT					= 1
	declare @SELECT_4_NON						int					set @SELECT_4_NON					= -1
	declare @SELECT_4_UP						int					set @SELECT_4_UP					= 0
	declare @SELECT_4_DOWN						int					set @SELECT_4_DOWN					= 1

	-- 기타정보.
	declare @BET_TIME_START						int					set @BET_TIME_START					= -5 * 60 + 10
	declare @BET_TIME_END						int					set @BET_TIME_END					=         - 30
	declare @SAFE_TIME_START					int					set @SAFE_TIME_START				= @BET_TIME_END
	declare @SAFE_TIME_END						int					set @SAFE_TIME_END					=         + 10
	declare @OVER_TIME_START					int					set @OVER_TIME_START				= @SAFE_TIME_END
	declare @OVER_TIME_END						int					set @OVER_TIME_END					= +5 * 60

	declare @GAMECOST_MINIMUM_CNT				int					set @GAMECOST_MINIMUM_CNT			= 100	--최소배팅카운터.
	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @comment				varchar(512)		set @comment			= ''
	declare @gameid					varchar(20)			set @gameid				= ''
	declare @cashcost				int					set @cashcost			= 0
	declare @gamecost				int					set @gamecost			= 0
	declare @sid					int					set @sid				= -1
	declare @cursyscheck			int					set @cursyscheck		= @SYSCHECK_YES
	declare @blockstate				int					set @blockstate			= @BLOCK_STATE_YES
	declare @consumeitemcode		int 				set @consumeitemcode	= -1
	declare @consumecnt				int					set @consumecnt			= 0
	declare @connectip				varchar(20)			set @connectip			= ''
	declare @level					int					set @level				= 1
	declare @exp					int					set @exp				= 0
	declare @commission				int					set @commission			= 700

	declare @curdate				datetime			set @curdate			= getdate()
	declare @curturntime			int					set @curturntime		= -1
	declare @curturndate			datetime			set @curturndate		= getdate() - 1

	-- 배팅정보.
	declare @totalcnt				int					set @totalcnt			= 0
	declare @select1				int					set @select1			= -1
	declare @select2				int					set @select2			= -1
	declare @select3				int					set @select3			= -1
	declare @select4				int					set @select4			= -1
	declare @cnt1					int					set @cnt1				= 0
	declare @cnt2					int					set @cnt2				= 0
	declare @cnt3					int					set @cnt3				= 0
	declare @cnt4					int					set @cnt4				= 0

	DECLARE @tTempTable TABLE(
		listidx		int
	);
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG 입력정보', @gameid_ gameid_, @password_ password_, @sid_ sid_, @gmode_ gmode_, @listidx_ listidx_, @curturntime_ curturntime_, @select_ select_

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	select
		@gameid 	= gameid,		@blockstate		= blockstate,
		@cashcost	= cashcost,		@gamecost		= gamecost,
		@connectip	= connectip, 	@exp			= exp,			@level	= level, @commission 	= commission,
		@sid		= sid
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 3-2 유저정보', @gameid gameid, @sid sid, @blockstate blockstate, @connectip connectip, @exp exp, @cashcost cashcost, @gamecost gamecost

	--	3-3. 공지사항 체크
	select top 1 @cursyscheck = syscheck from dbo.tNotice order by idx desc
	--select 'DEBUG 3-3 공지사항', @cursyscheck cursyscheck

	-- 소모템보유템정보.
	if( @listidx_ != -1)
		begin
			select
				@consumeitemcode 	= itemcode,
				@consumecnt			= cnt
			from dbo.tUserItem
			where gameid = @gameid_ and listidx = @listidx_ and invenkind = @USERITEM_INVENKIND_CONSUME
			--select 'DEBUG 3-4 소모템 보유현황.', @consumeitemcode consumeitemcode, @consumecnt consumecnt
		end

	-- 진행중인 회차 정보
	select top 1
		@curturntime = nextturntime,
		@curturndate = nextturndate
	from dbo.tLottoInfo order by curturntime desc
	--select 'DEBUG 3-5 회차정보.', @curdate curdate, @curturntime curturntime, @curturndate curturndate, @curdate curdate
	--select 'DEBUG 3-5 시간이동.', @BET_TIME_START BET_TIME_START, @BET_TIME_END BET_TIME_END, @SAFE_TIME_START SAFE_TIME_START, @SAFE_TIME_END SAFE_TIME_END, @OVER_TIME_START OVER_TIME_START, @OVER_TIME_END OVER_TIME_END
	--select 'DEBUG 3-5 시간이동.', @curdate curdate, @curturndate curturndate, DATEADD(ss, @OVER_TIME_START, @curturndate) p1, DATEADD(ss, @SAFE_TIME_START, @curturndate) p2, DATEADD(ss, @BET_TIME_START, @curturndate) p3

	if( @curturntime_ = -1 )
		begin
			set @curturntime_ = @curturntime
			--select 'DEBUG 3-5 배팅타임이 없어서 최근것을 그대로 보상.', @curturntime_ curturntime_
		end

	---------------------------------------------------------
	-- 아이템 정보 검색.
	---------------------------------------------------------
	if( LEN( @select_ ) > 8)
		begin
			SELECT @select1 = param2, @cnt1 = param3  FROM dbo.fnu_SplitThree(';', ':', @select_) where param1 = 1
			SELECT @select2 = param2, @cnt2 = param3  FROM dbo.fnu_SplitThree(';', ':', @select_) where param1 = 2
			SELECT @select3 = param2, @cnt3 = param3  FROM dbo.fnu_SplitThree(';', ':', @select_) where param1 = 3
			SELECT @select4 = param2, @cnt4 = param3  FROM dbo.fnu_SplitThree(';', ':', @select_) where param1 = 4
		end
	--select 'DEBUG 3-7 배팅 템정보.', @select1 select1, @cnt1 cnt1, @select2 select2, @cnt2 cnt2, @select3 select3, @cnt3 cnt3, @select4 select4, @cnt4 cnt4

	-- 볼 보유수량..
	set @totalcnt = @cnt1 + @cnt2 + @cnt3 + @cnt4

	------------------------------------------------
	-- 3-3. 각 조건별 분기
	------------------------------------------------
	if(@cursyscheck = @SYSCHECK_YES)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_SERVER_CHECKING
			set @comment 	= 'DEBUG 시스템 점검중입니다.'
			--select 'DEBUG ', @comment
		END
	else if( @gameid = '' )
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR 아이디가 존재하지 않는다.'
			--select 'DEBUG ' + @comment
		END
	else if (@blockstate = @BLOCK_STATE_YES)
		BEGIN
			-- 블럭유저인가?
			set @nResult_ 	= @RESULT_ERROR_BLOCK_USER
			set @comment 	= '블럭처리된 아이디입니다.'
			--select 'DEBUG ', @comment
		END
	else if(@sid_ != @sid)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_SESSION_ID_EXPIRE_LOGOUT
			set @comment 	= 'ERROR 세션이 만기 되었습니다. (로그아웃 시켜주세요.)'
			--select 'DEBUG ' + @comment
		END
	else if(@curturntime_ != @curturntime)
		BEGIN
			-- (배팅회차정보 != 최고회차의 다음예정회차)
			set @nResult_ 	= @RESULT_ERROR_TURNTIME_WRONG
			set @comment 	= 'ERROR 회차정보가 잘못되었다.'
			--select 'DEBUG ' + @comment
		END
	else if(@curdate > DATEADD(ss, @OVER_TIME_START, @curturndate))
		BEGIN
			-- 현재시간 > 다음예정완료예정시간 + 10초후 오버타임 이상 동안 회차가 안들어왔는가?
			set @nResult_ 	= @RESULT_ERROR_NOT_BET_OVERTIME
			set @comment 	= 'ERROR 오버타임이상에서는 배팅불가'
			--select 'DEBUG ' + @comment
		END
	else if(@curdate > DATEADD(ss, @SAFE_TIME_START, @curturndate))
		BEGIN
			-- 현재시간 > 다음예정완료예정시간 - 30초전 ~ +10초전 세이프 타임인가?
			set @nResult_ 	= @RESULT_ERROR_NOT_BET_SAFETIME
			set @comment 	= 'ERROR 세이프타임에서는 배팅불가'
			--select 'DEBUG ' + @comment
		END
	else if(@curdate < DATEADD(ss, @BET_TIME_START, @curturndate))
		BEGIN
			-- 현재시간 > 다음예정완료예정시간(bettime)이내가 아닌가?
			set @nResult_ 	= @RESULT_ERROR_NOT_BET_SAFETIME
			set @comment 	= 'ERROR 배팅 불가 타임입니다.'
			--select 'DEBUG ' + @comment
		END
	else if( @gmode_ not in ( @GAME_MODE_PRACTICE, @GAME_MODE_SINGLE, @GAME_MODE_MULTI ) )
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment 	= 'ERROR 지원하지 않는 모드입니다.'
			--select 'DEBUG ' + @comment
		END
	else if( LEN( @select_ ) = 0 )
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 배팅했습니다.(관람용 기록없음)'
			--select 'DEBUG ' + @comment
		END
	else if(   ( LEN( @select_ ) < 6 )
			or ( @select1 = -1 and @select2 = -1 and @select3 = -1 and @select4 = -1 )
			or ( @cnt1    < 0     or  @cnt2 < 0      or @cnt3 < 0      or @cnt4 < 0 )
			)
		BEGIN
			-- 전송한 파라미터검사?
			set @nResult_ 	= @RESULT_ERROR_PARAMETER
			set @comment 	= 'ERROR 파라미터가 잘못되었습니다.'
			--select 'DEBUG ' + @comment
		END
	else if(
			   ( @select1 != -1 and @cnt1 < @GAMECOST_MINIMUM_CNT )
			or ( @select2 != -1 and @cnt2 < @GAMECOST_MINIMUM_CNT )
			or ( @select3 != -1 and @cnt3 < @GAMECOST_MINIMUM_CNT )
			or ( @select4 != -1 and @cnt4 < @GAMECOST_MINIMUM_CNT )
			)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_MINUMUN_LACK
			set @comment 	= 'ERROR 최소수량보다 작습니다.(100)'
			--select 'DEBUG ' + @comment
		END
	else if( @totalcnt > @gamecost )
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_GAMECOST_LACK
			set @comment 	= 'ERROR 아이템이 부족합니다.(볼부족)'
			--select 'DEBUG ' + @comment
		END
	else if( @consumeitemcode != -1 and @consumecnt <= 0 )
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_ITEM_LACK
			set @comment 	= 'ERROR 아이템이 부족합니다.(소모템)'
			--select 'DEBUG ' + @comment
		END
	else if ( exists( select top 1 * from dbo.tSingleGame where gameid = @gameid_ and curturntime = @curturntime_ ) )
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 배팅했습니다.(중복)'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 배팅했습니다.'
			--select 'DEBUG ' + @comment

			set @level 		= dbo.fnu_GetLevel( @exp )
			set @commission = dbo.fnu_GetTax100FromLevel( @level )
			--select 'DEBUG ', @exp exp, @level level, @commission commission

			------------------------------------------------
			-- 배팅 테이블에 gameid에 따른 배팅기록, 다음예정완료시간기록.
			------------------------------------------------
			insert into dbo.tSingleGame(
						gameid, connectip, exp, level, commission,
						curturntime, curturndate,
						gamemode,
						consumeitemcode,
						selectdata,
						select1, cnt1,
						select2, cnt2,
						select3, cnt3,
						select4, cnt4
			)
			values (
						@gameid, @connectip, @exp, @level, @commission,
						@curturntime, @curturndate,
						@gmode_,
						@consumeitemcode,
						@select_,
						@select1, @cnt1,
						@select2, @cnt2,
						@select3, @cnt3,
						@select4, @cnt4
			)

			------------------------------------------------
			-- 소모템 감소해두기
			------------------------------------------------
			if( @listidx_ != -1)
				begin
					update dbo.tUserItem
						set
							cnt = cnt - 1
					where gameid = @gameid_ and listidx = @listidx_ and invenkind = @USERITEM_INVENKIND_CONSUME

					-- 반영정보에 전달하기.
					insert into @tTempTable( listidx ) values( @listidx_ )
				end

			------------------------------------------------
			-- 배팅한것 감소하기.
			------------------------------------------------
			set @gamecost = @gamecost - @totalcnt

			------------------------------------------------
			-- 유저정보
			------------------------------------------------
			update dbo.tUserMaster
				set
					singleflag	= @SINGLE_FLAG_PLAY,
					gamecost 	= @gamecost,
					level 		= @level,
					commission 	= @commission
			where gameid = @gameid_

		END


	--------------------------------------------------------------
	-- 결과전송.
	--------------------------------------------------------------
	select @nResult_ rtn, @comment comment, @curdate curdate, @curturntime curturntime, @curturndate curturndate, @cashcost cashcost, @gamecost gamecost

	if(@nResult_ = @RESULT_SUCCESS)
		BEGIN
			--------------------------------------------------------------
			-- 유저 보유 아이템 정보
			--------------------------------------------------------------
			select * from dbo.tUserItem
			where gameid = @gameid_ and listidx in ( select listidx from @tTempTable )
		END

	------------------------------------------------
	--	4-2. 유저정보
	------------------------------------------------
	set nocount off
End

