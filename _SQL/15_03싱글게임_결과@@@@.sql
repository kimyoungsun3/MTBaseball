/*
exec spu_SGResult 'mtxxxx3', '049000s1i0n7t8445289', 3331, 1,    -1, -1		-- 세션에러
exec spu_SGResult 'mtxxxx3', '049000s1i0n7t8445289', 333, 1,     -1, -1		-- 회차없음 ( 로또X, 배티X, 전로또X )
exec spu_SGResult 'mtxxxx3', '049000s1i0n7t8445289', 333, 1, 829532, -1		-- 회차없음 ( 그냥보는 사람 > 5+5분 안들어옴… > 로그아웃 )
exec spu_SGResult 'mtxxxx3', '049000s1i0n7t8445289', 333, 1, 829533, -1		-- 배팅중 > 5+5분 안들어옴> 내부취소마킹, 로그아웃 해주세요(나중에 로그인하면 자동 롤백됩니다.)
exec spu_SGResult 'mtxxxx3', '049000s1i0n7t8445289', 333, 1, 829753, -1		-- 로또정보가 안들어옴.(바로배팅한것 검사하는방식)
exec spu_SGResult 'mtxxxx3', '049000s1i0n7t8445289', 333, 1, 829750, -1		-- 관람하기 들어온것.

declare @curturntime int  select top 1 @curturntime = curturntime from dbo.tSingleGame where gameid = 'mtxxxx3' order by curturntime desc
exec spu_SGResult 'mtxxxx3', '049000s1i0n7t8445289', 333, 1, @curturntime, -1

-- 829534
-- 스트라이크(0) / 100 /	직구(0) / 100 /	좌(0) / 100 /	상(0) / 100 /
--         볼(1)	        변화(1)	        좌(0)	        상(0)
exec spu_SGResult 'mtxxxx3', '049000s1i0n7t8445289', 333, 1, 830092, -1	-- 1개배팅
exec spu_SGResult 'mtxxxx3', '049000s1i0n7t8445289', 333, 1, 830093, -1	-- 2개배팅
exec spu_SGResult 'mtxxxx3', '049000s1i0n7t8445289', 333, 1, 830094, -1	-- 3개배팅
exec spu_SGResult 'mtxxxx3', '049000s1i0n7t8445289', 333, 1, 828643, -1	-- 4개배팅
exec spu_SGResult 'mtxxxx3', '049000s1i0n7t8445289', 333, 1, 829540, -1
exec spu_SGResult 'mtxxxx3', '049000s1i0n7t8445289', 333, 1, 829538, -1
exec spu_SGResult 'mtxxxx3', '049000s1i0n7t8445289', 333, 1, 829537, -1
exec spu_SGResult 'mtxxxx3', '049000s1i0n7t8445289', 333, 1, 829534, -1
exec spu_SGResult 'mtxxxx3', '049000s1i0n7t8445289', 333, 1, 828644, -1

*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_SGResult', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_SGResult;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_SGResult
	@gameid_								varchar(20),					-- 게임아이디
	@password_								varchar(20),
	@sid_									int,
	@gmode_									int,
	@curturntime_							int,
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
	declare @ITEM_MAINCATEGORY_COMSUME			int					set @ITEM_MAINCATEGORY_COMSUME				= 40 	-- 소모품(40)
	declare @ITEM_MAINCATEGORY_CASHCOST			int					set @ITEM_MAINCATEGORY_CASHCOST 			= 50 	-- 캐쉬선물(50)
	declare @ITEM_MAINCATEGORY_STATICINFO		int					set @ITEM_MAINCATEGORY_STATICINFO 			= 500 	-- 정보수집(500)
	declare @ITEM_MAINCATEGORY_LEVELUPREWARD	int					set @ITEM_MAINCATEGORY_LEVELUPREWARD		= 510 	-- 레벨업 보상(510)

	-- 선물하기.
	declare @GIFTLIST_GIFT_KIND_MESSAGE			int					set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2

	-- MT 게임모드.
	declare @GAME_MODE_PRACTICE					int					set @GAME_MODE_PRACTICE						= 0
	declare @GAME_MODE_SINGLE					int					set @GAME_MODE_SINGLE						= 1
	declare @GAME_MODE_MULTI					int					set @GAME_MODE_MULTI						= 2

	-- MT 플래그
	declare @SINGLE_FLAG_PLAY					int					set @SINGLE_FLAG_PLAY						= 1
	declare @SINGLE_FLAG_END					int					set @SINGLE_FLAG_END						= 0

	-- 기타정보.
	declare @BET_TIME_START						int					set @BET_TIME_START					= -5 * 60 + 10
	declare @BET_TIME_END						int					set @BET_TIME_END					=         - 30
	declare @SAFE_TIME_START					int					set @SAFE_TIME_START				= @BET_TIME_END
	declare @SAFE_TIME_END						int					set @SAFE_TIME_END					=         + 10
	declare @OVER_TIME_START					int					set @OVER_TIME_START				= @SAFE_TIME_END
	declare @OVER_TIME_END						int					set @OVER_TIME_END					= +5 * 60

	-- 배팅상태.
	declare @GAME_STATE_ING						int					set @GAME_STATE_ING					= -1	-- 게임진행중.
	declare @GAME_STATE_ROLLBACK				int					set @GAME_STATE_ROLLBACK			= -2	-- 롤백예정임.
	declare @GAME_STATE_SUCCESS					int					set @GAME_STATE_SUCCESS				= 0		-- 정상처리.
	--declare @GAME_STATE_FAIL_LOGIN_MOLSU		int					set @GAME_STATE_FAIL_LOGIN_MOLSU	= 10	-- 재로그인으로 몰수.
	--declare @GAME_STATE_FAIL_LOGIN_ROLLBACK	int					set @GAME_STATE_FAIL_LOGIN_ROLLBACK	= 11	-- 재로그인으로 롤백
	--declare @GAME_STATE_FAIL_ADMIN_DEL		int					set @GAME_STATE_FAIL_ADMIN_DEL		= 12	-- 관리자가 삭제함.
	--declare @GAME_STATE_FAIL_ADMIN_ROLLBACK	int					set @GAME_STATE_FAIL_ADMIN_ROLLBACK	= 13	-- 관리자가 롤백처리.

	-- 배팅결과.
	declare @GAME_RESULT_ING					int					set @GAME_RESULT_ING				= -1
	declare @GAME_RESULT_OUT					int					set @GAME_RESULT_OUT				= 0
	declare @GAME_RESULT_ONEHIT					int					set @GAME_RESULT_ONEHIT				= 1
	declare @GAME_RESULT_TWOHIT					int					set @GAME_RESULT_TWOHIT				= 2
	declare @GAME_RESULT_THREEHIT				int					set @GAME_RESULT_THREEHIT			= 3
	declare @GAME_RESULT_HOMERUN				int					set @GAME_RESULT_HOMERUN			= 4

	-- 유저가 선택한 정보.
	declare @SELECT_1_STRIKE					int					set @SELECT_1_STRIKE				=  0
	declare @SELECT_1_BALL						int					set @SELECT_1_BALL					=  1
	declare @SELECT_2_FAST						int					set @SELECT_2_FAST					=  0
	declare @SELECT_2_CURVE						int					set @SELECT_2_CURVE					=  1
	declare @SELECT_3_LEFT						int					set @SELECT_3_LEFT					=  0
	declare @SELECT_3_RIGHT						int					set @SELECT_3_RIGHT					=  1
	declare @SELECT_4_UP						int					set @SELECT_4_UP					=  0
	declare @SELECT_4_DOWN						int					set @SELECT_4_DOWN					=  1

	-- 플레그정보.
	declare @RESULT_SELECT_NON					int					set @RESULT_SELECT_NON				= -1
	declare @RESULT_SELECT_LOSE					int					set @RESULT_SELECT_LOSE				=  0
	declare @RESULT_SELECT_WIN					int					set @RESULT_SELECT_WIN				=  1

	-- 기타상수.
	declare @COMMISSION_BASE					int					set @COMMISSION_BASE				= 700

	-- 결과에 따른 경험치
	declare @EXP_OUT							int					set @EXP_OUT						= 5
	declare @EXP_ONE_HIT						int					set @EXP_ONE_HIT					= 20
	declare @EXP_TWO_HIT						int					set @EXP_TWO_HIT					= 40
	declare @EXP_THREE_HIT						int					set @EXP_THREE_HIT					= 80
	declare @EXP_HOMERUN						int					set @EXP_HOMERUN					= 160

	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @comment				varchar(512)		set @comment			= ''
	declare @gameid					varchar(20)			set @gameid				= ''
	declare @cashcost				int					set @cashcost			= 0
	declare @gamecost				int					set @gamecost			= 0
	declare @sid					int					set @sid				= -1
	declare @exp					int					set @exp				= 0
	declare @level					int					set @level				= 1
	declare @level2					int					set @level2				= 1
	declare @wearplusexp			int					set @wearplusexp		= 0
	declare @commission				int					set @commission			= @COMMISSION_BASE
	declare @cursyscheck			int					set @cursyscheck		= @SYSCHECK_YES
	declare @blockstate				int					set @blockstate			= @BLOCK_STATE_YES

	-- 배팅정보.
	declare @curdate				datetime			set @curdate			= getdate()
	declare @curturntime			int					set @curturntime		= -1
	declare @curturndate			datetime			set @curturndate		= getdate() - 1
	declare @nextturntime			int					set @nextturntime		= -1
	declare @nextturndate			datetime			set @nextturndate		= getdate() - 1
	declare @select1				int					set @select1			= @RESULT_SELECT_NON
	declare @select2				int					set @select2			= @RESULT_SELECT_NON
	declare @select3				int					set @select3			= @RESULT_SELECT_NON
	declare @select4				int					set @select4			= @RESULT_SELECT_NON
	declare @cnt1					int					set @cnt1				= 0
	declare @cnt2					int					set @cnt2				= 0
	declare @cnt3					int					set @cnt3				= 0
	declare @cnt4					int					set @cnt4				= 0
	declare @connectip				varchar(20)			set @connectip			= ''
	declare @commissionbet			int					set @commissionbet		= @COMMISSION_BASE
	declare @gamestate				int					set @gamestate			= @GAME_STATE_ING
	declare @idx2					int					set @idx2				= 0
	declare @gameresult				int					set @gameresult			= @GAME_RESULT_ING
	declare @gainexp				int					set @gainexp			= 0
	declare @gaingamecost			int					set @gaingamecost		= 0
	declare @gaingamecostbet		int					set @gaingamecostbet	= 0
	declare @pcgameid				varchar(20)			set @pcgameid			= ''

	-- 배팅계산.
	declare @rselect1				int					set @rselect1			= @RESULT_SELECT_NON
	declare @rselect2				int					set @rselect2			= @RESULT_SELECT_NON
	declare @rselect3				int					set @rselect3			= @RESULT_SELECT_NON
	declare @rselect4				int					set @rselect4			= @RESULT_SELECT_NON
	declare @rcnt1					int					set @rcnt1				= 0
	declare @rcnt2					int					set @rcnt2				= 0
	declare @rcnt3					int					set @rcnt3				= 0
	declare @rcnt4					int					set @rcnt4				= 0
	declare @betgamecosttotal		int					set @betgamecosttotal	= 0		-- 원본에 대한 볼.
	declare @betgamecostwin			int					set @betgamecostwin		= 0		-- 원본에 대한 결과.
	declare @betgamecostlose		int					set @betgamecostlose	= 0
	declare @rgamecostwin			int					set @rgamecostwin		= 0		-- 결과에 대한 결과.
	declare @rgamecostlose			int					set @rgamecostlose		= 0
	declare @rpcgamecost			int					set @rpcgamecost		= 0		-- pc방에 주는것.
	declare @betgamecostorg			int					set @betgamecostorg		= 0		-- 단순하게 배팅금액, 획득금액
	declare @betgamecostearn		int					set @betgamecostearn	= 0

	--로또회차정보.
	declare @ltcurturntime			int					set @ltcurturntime		= -1
	declare @ltcurturntime2			int					set @ltcurturntime2		= -1
	declare @ltcurturndate			datetime			set @ltcurturndate		= getdate() - 1
	declare @ltcurturndate2			datetime			set @ltcurturndate2		= getdate() - 1
	declare @ltselect1				int					set @ltselect1			= -1
	declare @ltselect2				int					set @ltselect2			= -1
	declare @ltselect3				int					set @ltselect3			= -1
	declare @ltselect4				int					set @ltselect4			= -1

	-- 기타정보.
	declare @levelupitemcode		int					set @levelupitemcode	= -1
	declare @giftsendexists			int					set @giftsendexists		= -1

	--DECLARE @tTempTable TABLE(
	--	listidx		int
	--);
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG 1 입력정보', @gameid_ gameid_, @password_ password_, @sid_ sid_, @gmode_ gmode_, @curturntime_ curturntime_

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	select
		@gameid 	= gameid,		@blockstate		= blockstate,
		@cashcost	= cashcost,		@gamecost		= gamecost,			@gaingamecost 	= gaingamecost,
		@exp		= exp,			@level			= level,			@wearplusexp	= wearplusexp,
		@sid		= sid
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 3-2 유저정보', @gameid gameid, @blockstate blockstate, @sid sid, @cashcost cashcost, @gamecost gamecost

	if(@gameid != '')
		begin
			--	3-3. 공지사항 체크
			select top 1 @cursyscheck = syscheck from dbo.tNotice order by idx desc
			--select 'DEBUG 3-3 공지사항', @cursyscheck cursyscheck

			-- 배팅정보.
			select
				@curturntime= curturntime,	@curturndate 	= curturndate,
				@select1	= select1, 		@cnt1 = cnt1,
				@select2	= select2, 		@cnt2 = cnt2,
				@select3	= select3, 		@cnt3 = cnt3,
				@select4	= select4, 		@cnt4 = cnt4,
				@connectip	= connectip, 	@commissionbet = commissionbet
			from dbo.tSingleGame
			where gameid = @gameid and curturntime = @curturntime_ and gamemode = @gmode_
			--select 'DEBUG 3-5 내가배팅한 회차정보.', @curdate curdate, @curturntime curturntime, @curturndate curturndate, @select1 select1, @cnt1 cnt1, @select2 select2, @cnt2 cnt2, @select3 select3, @cnt3 cnt3, @select4 select4, @cnt4 cnt4, @connectip connectip, @commissionbet commissionbet

			-- 진행중인 회차 정보
			select
				@ltcurturntime 	= curturntime,	@ltcurturndate = curturndate,
				@ltselect1		= select1,
				@ltselect2		= select2,
				@ltselect3		= select3,
				@ltselect4		= select4
			from dbo.tLottoInfo
			where curturntime = @curturntime_
			--select 'DEBUG 3-7 로토회차정보.', @ltcurturntime ltcurturntime, @ltcurturndate ltcurturndate, @ltselect1 ltselect1, @ltselect2 ltselect2, @ltselect3 ltselect3, @ltselect4 ltselect4

			-- 전회차에서 현재시간을 가져오기위해서.
			if( @curturntime = -1)
				begin
					select
						@ltcurturntime2 	= nextturntime,	@ltcurturndate2 = nextturndate
					from dbo.tLottoInfo
					where nextturntime = @curturntime_
					--select 'DEBUG 3-8 로토회차정보(로또가안들어와서 전것).', @ltcurturntime2 ltcurturntime2, @ltcurturndate2 ltcurturndate2
				end

			------------------------------------------------
			-- 다음회차 정보
			------------------------------------------------
			select top 1
				@nextturntime = nextturntime,
				@nextturndate = nextturndate
			from dbo.tLottoInfo order by curturntime desc
			--select 'DEBUG 3-5 회차정보.', @curdate curdate, @nextturntime nextturntime, @nextturndate nextturndate

		end

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
	else if( @ltcurturntime = -1 and @curturntime = -1 and @ltcurturntime2 = -1 )
		BEGIN
			-- 로또X, 배티X, 전로또X
			set @nResult_ 	= @RESULT_ERROR_PARAMETER
			set @comment 	= 'ERROR 파라미터오류 (로또, 배팅, 전로또 정보가 없음)'
			--select 'DEBUG ' + @comment
		END
	else if( @ltcurturntime = -1 and @curturntime  = -1 and @curdate > DATEADD(ss, @OVER_TIME_END, @ltcurturndate2) )
		BEGIN
			-- 로또X, 배티X, 전로또O
			set @nResult_ = @RESULT_ERROR_NOT_CALCULATE_LOTTO_LOGOUT
			set @comment = 'ERROR 그냥보는 사람 > 5+5분 안들어옴… > 로그아웃 해주세요.'
			--select 'DEBUG ' + @comment
		END
	else if( @ltcurturntime = -1 and @curturntime != -1 and @curdate > DATEADD(ss, @OVER_TIME_END, @curturndate) )
		BEGIN
			-- 로또X, 배티O, 전로또O
			set @nResult_ = @RESULT_ERROR_NOT_CALCULATE_LOTTO_LOGOUT
			set @comment = 'ERROR 배팅중 > 5+5분 안들어옴> 내부취소마킹, 로그아웃 해주세요(나중에 로그인하면 자동 롤백됩니다.)'

			-- 있을때만 -> 자동 취소마킹해두기(-2)재로그인하면 자동으로 처리됨)
			update dbo.tSingleGame
				set
					gamestate = @GAME_STATE_ROLLBACK
			where gameid = @gameid and curturntime = @curturntime_ and gamemode = @gmode_

			--select 'DEBUG ' + @comment
		END
	else if(    ( @ltcurturntime = -1 and @curturntime  = -1 and @curdate > @ltcurturndate2 )
			 or ( @ltcurturntime = -1 and @curturntime != -1 and @curdate > @curturndate ) )
		BEGIN
			-- 현재시간 > 다음예정완료예정시간 + 10초후 오버타임 이상 동안 회차가 안들어왔는가?
			set @nResult_ 	= @RESULT_ERROR_NOT_INPUT_SUPERBALL_5TRY
			set @comment 	= 'ERROR 슈퍼볼 데이터가 아직 안들어옴… > 5초후에 다시 요청(1)'
			--select 'DEBUG ' + @comment
		END
	else if( @ltcurturntime = -1 )
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_INPUT_SUPERBALL_5TRY
			set @comment 	= 'ERROR 슈퍼볼 데이터가 아직 안들어옴… > 5초후에 다시 요청(2)'
			--select 'DEBUG ' + @comment
		END
	else if ( exists( select top 1 * from dbo.tSingleGameLog where gameid = @gameid_ and curturntime = @curturntime_ ) )
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 배팅산출했다.(중복)'
			--select 'DEBUG ' + @comment
		END
	-- 이하부터는 로또정보가 들어와 있음...(위에서 필터해줌)
	else if( @ltcurturntime != -1 and @curturntime  = -1 )
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'SUCCESS 그냥 관람하기 위해서 들어온것'
			--select 'DEBUG ' + @comment
		END
	else if ( @ltcurturntime != -1 and @curturntime = @ltcurturntime )
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 배팅산출했습니다.'
			--select 'DEBUG ' + @comment

			------------------------------------------------
			-- 700(7%) - 소모템(2~3%) - 레벨(0~6.5%) => 0% 이하로는 안내려감
			-- 결과비교하기 1, 2, 3, 4
			--	if(결과 : 미배팅)		> 패스
			--	else if(결과 > 성공 )  > 오른쪽 참고(다이아바로Plus)
			--	else 결과 > 실패      	> 오른쪽 참고
			------------------------------------------------
			select @rselect1 = rselect, @rcnt1 = rcnt from dbo.fnu_GetSingleGameResult( @ltselect1, @select1, @cnt1)
			--select 'DEBUG 결과비교1', @select1 select1, @ltselect1 ltselect1, @cnt1 cnt1, @rselect1 rselect1, @rcnt1 rcnt1

			select @rselect2 = rselect, @rcnt2 = rcnt from dbo.fnu_GetSingleGameResult( @ltselect2, @select2, @cnt2)
			--select 'DEBUG 결과비교2', @select2 select2, @ltselect2 ltselect2, @cnt2 cnt2, @rselect2 rselect2, @rcnt2 rcnt2

			select @rselect3 = rselect, @rcnt3 = rcnt from dbo.fnu_GetSingleGameResult( @ltselect3, @select3, @cnt3)
			--select 'DEBUG 결과비교3', @select3 select3, @ltselect3 ltselect3, @cnt3 cnt3, @rselect3 rselect3, @rcnt3 rcnt3

			select @rselect4 = rselect, @rcnt4 = rcnt from dbo.fnu_GetSingleGameResult( @ltselect4, @select4, @cnt4)
			--select 'DEBUG 결과비교4', @select4 select4, @ltselect4 ltselect4, @cnt4 cnt4, @rselect4 rselect4, @rcnt4 rcnt4

			--결과에 따른 합, 수수료계산,
			set @betgamecosttotal 	= @cnt1  + @cnt2  + @cnt3  + @cnt4
			set @betgamecostwin		= @rcnt1 + @rcnt2 + @rcnt3 + @rcnt4
			set @betgamecostlose	= @betgamecosttotal - @betgamecostwin
			set @rgamecostwin 		= @betgamecostwin
			set @rgamecostlose		= @betgamecostlose
			--select 'DEBUG 배팅정보.', @betgamecosttotal betgamecosttotal, @cnt1 cnt1, @cnt2 cnt2, @cnt3 cnt3, @cnt4 cnt4
			--select 'DEBUG 배팅정보.', @betgamecostwin betgamecostwin, @betgamecostlose betgamecostlose, @rcnt1 rcnt1, @rcnt2 rcnt2, @rcnt3 rcnt3, @rcnt4 rcnt4
			--select 'DEBUG 배팅정보.', @rgamecostwin rgamecostwin, @rgamecostlose rgamecostlose

			set @rpcgamecost	 	=                 @betgamecosttotal * @commissionbet / 10000
			set @rgamecostwin		= @rgamecostwin  - @rgamecostwin    * @commissionbet / 10000
			set @rgamecostlose		= @rgamecostlose - @rgamecostlose   * @commissionbet / 10000
			--set @betgamecostwin	= betgamecostwin
			--select 'DEBUG 배팅정보.', @betgamecosttotal betgamecosttotal, @commissionbet commissionbet, @rpcgamecost rpcgamecost, @betgamecostwin betgamecostwin, @rgamecostwin rgamecostwin, @rgamecostlose rgamecostlose

			-- 배팅하고 나온 결과값.(투자비용 -> 결과비용(결과에대한 수수료제외하고))
			set @betgamecostorg		= @betgamecosttotal
			set @betgamecostearn	= @betgamecostwin + @rgamecostwin

			-- 유저수입, PC방, 회사수입정하기.
			set @gaingamecostbet= (@betgamecostwin + @rgamecostwin) - @betgamecosttotal
			set @gaingamecost	= @gaingamecost + @gaingamecostbet
			set @gamecost 		= @gamecost + ( @betgamecostwin + @rgamecostwin )
			--select 'DEBUG 배팅정보.', @gaingamecost gaingamecost

			-- 게임결과.
			set @gameresult =
				  case when @rselect1 = @RESULT_SELECT_WIN then 1 else 0 end
				+ case when @rselect2 = @RESULT_SELECT_WIN then 1 else 0 end
				+ case when @rselect3 = @RESULT_SELECT_WIN then 1 else 0 end
				+ case when @rselect4 = @RESULT_SELECT_WIN then 1 else 0 end
			--select 'DEBUG 게임결과 ', @gameresult gameresult, @rselect1 rselect1, @rselect2 rselect2, @rselect3 rselect3, @rselect4 rselect4

			------------------------------------------------
			--경험치, 레벨 <- 착용아이템에 따른 경험치 +plus (아이템테이블), 플래그(0)
			------------------------------------------------
			set @gainexp = case
								when @gameresult <= 0 then @EXP_OUT
								when @gameresult <= 1 then @EXP_ONE_HIT
								when @gameresult <= 2 then @EXP_TWO_HIT
								when @gameresult <= 3 then @EXP_THREE_HIT
								else 					   @EXP_HOMERUN
							end
			--select 'DEBUG 게임결과 -> 경험치(착용템적용전) ', @gameresult gameresult, @gainexp gainexp, @wearplusexp wearplusexp
			set @gainexp = @gainexp + @gainexp * @wearplusexp / 10000
			--select 'DEBUG 게임결과 -> 경험치(착용템적용후) ', @gameresult gameresult, @gainexp gainexp, @wearplusexp wearplusexp

			set @exp 			= @exp + @gainexp
			set @level2			= dbo.fnu_GetLevel( @exp )
			set @commission 	= @COMMISSION_BASE - dbo.fnu_GetTax100FromLevel( @level2 )
			set @commission = CASE
									WHEN @commission < 0 THEN 	0
									ELSE						@commission
							  END
			--select 'DEBUG 게임결과 -> 경험치 ', @gainexp gainexp, @exp exp, @level level, @level2 level2, @commission commission

			--select 'DEBUG 레벨업에 따른 아이템 지급?', @level level, @level2 level2
			--set @level = 9
			--set @level2 = 10
			if( @level != @level2 )
				begin
					--select 'DEBUG 레벨업 변경되어서 아이템 지급건이 있는가?'
					select @levelupitemcode = param2
					from dbo.tItemInfo
					where category = @ITEM_MAINCATEGORY_LEVELUPREWARD and param1 = @level2

					if( @levelupitemcode != -1 )
						begin
							--select 'DEBUG 레벨업 검사 > 아이템 지급', @levelupitemcode levelupitemcode
							exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT,  @levelupitemcode,  1, 'SysLevelup', @gameid_, ''

							-- 반영정보에 전달하기.
							set @giftsendexists = 1
						end
				end

			------------------------------------------------
			-- PC방 업주에게 볼넣어주기.
			-- 개인, 회사, PC방 수익부분 여기서 고려해볼만한다. 아직은 미구현됨
			------------------------------------------------
			select @pcgameid = gameid from dbo.tPCRoomIP where connectip = @connectip
			--select 'DEBUG PC업주검색', @pcgameid pcgameid, @connectip connectip

			if( @pcgameid != '' )
				begin
					--select 'DEBUG PC업주넣어주기', @rpcgamecost rpcgamecost, gamecost, gaingamecostpc from dbo.tUserMaster where gameid = @pcgameid
					-- pc 정보 업데이트.
					update dbo.tPCRoomIP
						set
							cnt 			= cnt + 1,
							gaingamecost 	= gaingamecost + @rpcgamecost
					 where connectip = @connectip

					 --select 'DEBUG 일별통계 > PC방매출..(일, 월).', @pcgameid pcgameid, @rpcgamecost rpcgamecost
					 exec dbo.spu_SinglePCRoomLog @pcgameid, @connectip, 0, @rpcgamecost

					 -- PC방 업주에게 전달해주기.
					 update dbo.tUserMaster
					 	set
					 		gamecost 		= gamecost       + @rpcgamecost,
					 		gaingamecostpc 	= gaingamecostpc + @rpcgamecost
					 where gameid = @pcgameid
				end

			------------------------------------------------
			-- 배팅로고 기록하기.
			------------------------------------------------
			--select 'DEBUG ', @select1 select1, @select2 select2, @select3 select3, @select4 select4, @rselect1 rselect1, @rselect2 rselect2, @rselect3 rselect3, @rselect4 rselect4, @betgamecostorg betgamecostorg, @betgamecostearn betgamecostearn
			exec dbo.spu_SingleGameEarnLog @select1, @select2, @select3, @select4, @rselect1, @rselect2, @rselect3, @rselect4, @betgamecostorg, @betgamecostearn

			------------------------------------------------
			-- 배팅테이블 -> 배팅로고로 이동, 기타정보 입력
			------------------------------------------------
			select @idx2 = ( ISNULL( MAX( idx2 ), 0) + 1) from dbo.tSingleGameLog where gameid = @gameid_
			insert into dbo.tSingleGameLog
			(
						idx2,
						gameid, curturntime, curturndate, gamemode, consumeitemcode,
						select1, cnt1, select2, cnt2, select3, cnt3, select4, cnt4,
						selectdata, writedate, connectip, level, exp, commissionbet, gamestate,
						gameresult,
						gainexp,
						gaingamecost,
						rselect1, rselect2, rselect3, rselect4,
						ltselect1, ltselect2, ltselect3, ltselect4,
						betgamecostorg, betgamecostearn,
						pcgameid, pcgamecost, resultdate
			)
			select 		@idx2,
						gameid, curturntime, curturndate, gamemode, consumeitemcode,
						select1, cnt1, select2, cnt2, select3, cnt3, select4, cnt4,
						selectdata, writedate, connectip, level, exp, commissionbet, @GAME_STATE_SUCCESS,
						@gameresult,
						@gainexp,
						@gaingamecostbet,
						@rselect1, @rselect2, @rselect3, @rselect4,
						@ltselect1, @ltselect2, @ltselect3, @ltselect4,
						@betgamecostorg, @betgamecostearn,
						@pcgameid, @rpcgamecost, getdate()
			from dbo.tSingleGame
			where gameid = @gameid_ and curturntime = @curturntime


			------------------------------------------------
			-- 삭제하기.
			------------------------------------------------
			--select 'DEBUG 2-3 배팅정보삭제', * from dbo.tSingleGame where gameid = @gameid_ and curturntime = @curturntime
			delete from dbo.tSingleGame where gameid = @gameid_ and curturntime = @curturntime

			------------------------------------------------
			-- 유저정보
			------------------------------------------------
			update dbo.tUserMaster
				set
					singleflag	= @SINGLE_FLAG_END,
					cashcost	= @cashcost, 			gamecost 	= @gamecost,	gaingamecost = @gaingamecost,
					exp			= @exp, 				level 		= @level2,
					commission	= @commission
			where gameid = @gameid_
		END


	--------------------------------------------------------------
	-- 결과전송.
	--------------------------------------------------------------
	select @nResult_ rtn, @comment comment,
	@curdate curdate, @curturntime curturntime, @curturndate curturndate,
	@nextturntime nextturntime, @nextturndate nextturndate,
	@cashcost cashcost, @gamecost gamecost,
	@ltselect1 ltselect1, @ltselect2 ltselect2, @ltselect3 ltselect3, @ltselect4 ltselect4,
	@rselect1 rselect1, @rselect2 rselect2, @rselect3 rselect3, @rselect4 rselect4,
	@rcnt1 rcnt1, @rcnt2 rcnt2, @rcnt3 rcnt3, @rcnt4 rcnt4,
	@gameresult gameresult


	if(@nResult_ = @RESULT_SUCCESS)
		BEGIN
			--------------------------------------------------------------
			-- 유저 보유 아이템 정보
			--------------------------------------------------------------

			if( @giftsendexists != -1 )
				begin
					exec spu_GiftList @gameid_
				end
		END

	------------------------------------------------
	--	4-2. 유저정보
	------------------------------------------------
	set nocount off
End

