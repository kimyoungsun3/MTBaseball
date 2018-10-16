/*
select * from dbo.tSingleGame			where gameid = 'mtxxxx3' order by curturntime desc
select * from dbo.tSingleGamelog		where gameid = 'mtxxxx3' order by curturntime desc
delete from dbo.tSingleGame           	where gameid = 'mtxxxx3'
delete from dbo.tSingleGameLog        	where gameid = 'mtxxxx3'
update dbo.tUserMaster set sid = 333 	where gameid = 'mtxxxx3'
-- 착용템 -> 경험치
-- 레벨  -> 수익변화

-- 싱글게임.
exec spu_SGReady 'mtxxxx3', '049000s1i0n7t8445289', 333, 1, -1, -1		-- 소모템없음
exec spu_SGReady 'mtxxxx3', '049000s1i0n7t8445289', 333, 1, 10, -1		-- 코치의 조언주문서
exec spu_SGReady 'mtxxxx3', '049000s1i0n7t8445289', 333, 1, 11, -1		-- 응원의 소리
exec spu_SGReady 'mtxxxx3', '049000s1i0n7t8445289', 333, 1, 12, -1		-- 감독의 조언 주문서

-- error
exec spu_SGReady 'mtxxxx3', '049000s1i0n7t8445289', 333,  1,  1, -1		-- 의상으로 주문 > error
exec spu_SGReady 'mtxxxx3', '049000s1i0n7t8445289', 3331, 1, -1, -1		-- 세션이 만기된경우.
--delete from dbo.tLottoInfo	where curturntime = (select top 1 curturntime from dbo.tLottoInfo order by curturntime desc)
exec spu_SGReady 'mtxxxx3', '049000s1i0n7t8445289', 333, 1, -1, -1		-- 계산중일때.
exec spu_SGReady 'mtxxxx3', '049000s1i0n7t8445289', 333,  1,  11, -1		-- 소모템 수량부족
*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_SGReady', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_SGReady;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_SGReady
	@gameid_								varchar(20),					-- 게임아이디
	@password_								varchar(20),
	@sid_									int,
	@gmode_									int,
	@listidx_								int,
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
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- 아이템코드못찾음
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- 지원하지않는모드
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

	-- MT 게임모드.
	declare @GAME_MODE_PRACTICE					int					set @GAME_MODE_PRACTICE						= 0
	declare @GAME_MODE_SINGLE					int					set @GAME_MODE_SINGLE						= 1
	declare @GAME_MODE_MULTI					int					set @GAME_MODE_MULTI						= 2


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
	declare @consumeitemcode		int 				set @consumeitemcode 	= -1
	declare @consumecnt				int					set @consumecnt			= 0

	declare @curdate				datetime			set @curdate			= getdate()
	declare @curturntime			int					set @curturntime		= -1
	declare @curturndate			datetime			set @curturndate		= getdate()

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG 3-1 입력정보', @gameid_ gameid_, @password_ password_, @sid_ sid_, @gmode_ gmode_, @listidx_ listidx_

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	select
		@gameid 		= gameid,	@blockstate		= blockstate,
		@cashcost		= cashcost,	@gamecost		= gamecost,
		@sid			= sid
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 3-2 유저정보', @gameid gameid, @sid sid, @cashcost cashcost, @gamecost gamecost

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
			--select 'DEBUG 3-4 보유템정보.', @consumeitemcode consumeitemcode, @consumecnt consumecnt
		end

	-- 회차 정보
	select top 1
		@curturntime = nextturntime,
		@curturndate = nextturndate
	from dbo.tLottoInfo order by curturntime desc
	--select 'DEBUG 3-4 보유템정보.', @curturntime curturntime, @curturndate curturndate, @curdate curdate

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
	else if( @gmode_ not in ( @GAME_MODE_PRACTICE, @GAME_MODE_SINGLE, @GAME_MODE_MULTI ) )
		BEGIN
			-- 전송한 파라미터검사?
			set @nResult_ 	= @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment 	= 'ERROR 지원하지 않는 모드입니다.'
			--select 'DEBUG ' + @comment
		END
	--else if(현재배팅 정보가 존재한다?)
	--	BEGIN
	--		set @nResult_ 	= @RESULT_ERROR_SESSION_ID_EXPIRE_LOGOUT
	--		set @comment 	= 'ERROR 세션이 만기 되었습니다.'
	--		--select 'DEBUG ' + @comment
	--	END
	else if(@curdate > @curturndate)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_CALCULATE_LOTTO_WAIT_LOBBY
			set @comment 	= 'ERROR 결과를 계산중이여서 (로비에서 대기해서 잠시후에 들어와주세요.)'
			--select 'DEBUG ' + @comment
		END
	else if(@listidx_ != -1 and @consumecnt <= 0)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_ITEM_LACK
			set @comment 	= 'ERROR 아이템이 부족합니다.'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 준비했습니다.'
			--select 'DEBUG ' + @comment

			------------------------------------------------
			-- 통계정보.
			------------------------------------------------
			--exec spu_DayLogInfoStatic 32, 1
		END


	--------------------------------------------------------------
	-- 결과전송.
	--------------------------------------------------------------
	select @nResult_ rtn, @comment comment, @curdate curdate, @curturntime curturntime, @curturndate curturndate, @cashcost cashcost, @gamecost gamecost



	------------------------------------------------
	--	4-2. 유저정보
	------------------------------------------------
	set nocount off
End

