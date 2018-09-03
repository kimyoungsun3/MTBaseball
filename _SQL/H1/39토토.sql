/*

exec sup_TotoRegister 'supermanx', '7575970askeie1595312', 1, 1, 500, 12, 11, -1	-- x
exec sup_TotoRegister 'superman6', '7575970askeie1595312', 1, 3, 500, 12, 11, -1	-- x
exec sup_TotoRegister 'superman6', '7575970askeie1595312', 1, 1, -500, 12, 11, -1	-- x
exec sup_TotoRegister 'superman6', '7575970askeie1595312', 1, 1, 50000, 12, 11, -1	-- x
exec sup_TotoRegister 'superman6', '7575970askeie1595312', 1, 1, 500, 120, 11, -1	-- x

exec sup_TotoRegister 'superman7', '7575970askeie1595312', 1, 1, 500,  6, -1, -1
exec sup_TotoRegister 'superman7', '7575970askeie1595312', 2, 2, 500,  5, 11, -1
exec sup_TotoRegister 'superman7', '7575970askeie1595312', 3, 1, 500,  2, -1, -1
exec sup_TotoRegister 'superman7', '7575970askeie1595312', 4, 2, 500, 10, 12, -1

exec sup_TotoRegister 'superman6', '7575970askeie1595312', 1, 1, 500, 28, -1, -1
exec sup_TotoRegister 'superman6', '7575970askeie1595312', 2, 2, 500,  7, 11, -1
exec sup_TotoRegister 'superman6', '7575970askeie1595312', 3, 1, 500, 21, -1, -1
exec sup_TotoRegister 'superman6', '7575970askeie1595312', 4, 2, 500,  7, 12, -1


exec sup_TotoRegister 'supermmm12', '049000s1i0n7t8445289', 10, 1, 500,  4, -1, -1
exec sup_TotoRegister 'supermmm13', '049000s1i0n7t8445289', 10, 2, 500,  4, 12, -1
exec sup_TotoRegister 'supermmm14', '049000s1i0n7t8445289', 10, 1, 500,  4, -1, -1
exec sup_TotoRegister 'superman90', '7575970askeie1595312', 10, 1, 500,  7, 12, -1
exec sup_TotoRegister 'superman91', '7575970askeie1595312', 10, 2, 500,  7, 12, -1

exec sup_TotoRegister 'superman7', '7575970askeie1595312', 18, 1, 500,  7, -1, -1
exec sup_TotoRegister 'superman6', '7575970askeie1595312', 18, 2, 500,  7, 12, -1
exec sup_TotoRegister 'sususu',    '7575970askeie1595312', 29, 1, 500,  21, -1, -1
exec sup_TotoRegister 'sususu2',   '7575970askeie1595312', 29, 2, 500,  21, 12, -1


exec sup_TotoRegister 'guest74466', '3357091y7k5m7v257919', 16, 2, 1000,  2, 1, -1
exec sup_TotoRegister 'guest74465', '6802007e8t4h0p462444', 16, 2, 1000,  2, 2, -1
exec sup_TotoRegister 'guest74464', '8598023k6z3i4f689522', 16, 2, 1000,  2, 3, -1
exec sup_TotoRegister 'guest74463', '0056861i7j2a2r443821', 16, 2, 1000,  2, 4, -1

exec sup_TotoRegister 'superman3', '7575970askeie1595312', 18, 1, 500, 2, -1, -1
exec sup_TotoRegister 'superman5', '7575970askeie1595312', 18, 2, 500, 2, 12, -1
exec sup_TotoRegister 'superman6', '7575970askeie1595312', 18, 1, 500, 3, -1, -1
exec sup_TotoRegister 'superman7', '7575970askeie1595312', 18, 2, 500, 3, 12, -1
select * from dbo.tTotoUser where totoid = 18
select * from dbo.tTotoMaster where totoid = 18
delete from dbo.tTotoUser where totoid = 18
delete from dbo.tTotoMaster where totoid = 18
*/


IF OBJECT_ID ( 'dbo.sup_TotoRegister', 'P' ) IS NOT NULL 
    DROP PROCEDURE dbo.sup_TotoRegister;
GO

create procedure dbo.sup_TotoRegister
	@gameid_				varchar(20),
	@password_				varchar(20),
	@totoid_				int,
	@chalmode_				int,
	@chalsb_				int,
	@chalcountry_			int,
	@chalpoint_				int,
	@nResult_				int				OUTPUT
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
	declare @RESULT_ERROR_ITEM_NOSALE_KIND		int				set @RESULT_ERROR_ITEM_NOSALE_KIND		= -37			--판매하지 않는 아이템
	declare @RESULT_ERROR_ITEM_PERMANENT_ALREADY int			set @RESULT_ERROR_ITEM_PERMANENT_ALREADY = -38			-- 영구템을 이미 구해했습니다.
	declare @RESULT_ERROR_ITEM_NOCHANGE_KIND	int				set @RESULT_ERROR_ITEM_NOCHANGE_KIND	= -39			--자체변경불가템

	-- 기타오류
	declare @RESULT_ERROR_RESULT_COPY			int				set @RESULT_ERROR_RESULT_COPY			= -53			-- 결과카피시도
	declare @RESULT_ERROR_SILVER_COPY			int				set @RESULT_ERROR_SILVER_COPY			= -54			-- 실버카피시도
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- 지원하지않는모드
	declare @RESULT_ERROR_ACTION_FULL			int				set @RESULT_ERROR_ACTION_FULL			= -71			-- 지원하지않는모드
	declare @RESULT_ERROR_WIN_LACK				int				set @RESULT_ERROR_WIN_LACK				= -72			-- 스프린트 보상.
	declare @RESULT_ERROR_TUTORIAL_ALREADY		int				set @RESULT_ERROR_TUTORIAL_ALREADY		= -73			-- 투토리얼 이미 보상.
	declare @RESULT_ERROR_FRIEND_ADD_MYGAMEID	int				set @RESULT_ERROR_FRIEND_ADD_MYGAMEID	= -74	
	declare @RESULT_ERROR_NOT_FOUND_GIFTID		int				set @RESULT_ERROR_NOT_FOUND_GIFTID		= -75			-- 캐쉬 > 선물할 아이디를 못찾음
	
	declare @RESULT_ERROR_SMS_NOT_MATCH_PHONE	int				set @RESULT_ERROR_SMS_NOT_MATCH_PHONE	= -80			--문자추천. 
	declare @RESULT_ERROR_SMS_KEY_DUPLICATE		int				set @RESULT_ERROR_SMS_KEY_DUPLICATE		= -81
	declare @RESULT_ERROR_SMS_LACK				int				set @RESULT_ERROR_SMS_LACK				= -82
	
	declare @RESULT_ERROR_NOT_FOUND_OTHERID		int				set @RESULT_ERROR_NOT_FOUND_OTHERID		= -83
	
	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @gameid			varchar(20)
	declare @acountry		int
	declare @bcountry		int
	declare @silverball		int						set @silverball			= 0
	declare @goldball		int						set @goldball			= 0
	declare @chalbat		int						set @chalbat			= 2
	declare @comment		varchar(128)
	declare @totodate		varchar(16)				--set @totodate			= '2013-03-02 23:59'

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	--select 'DEBUG 1-0 ', @gameid_ gameid_, @totoid_ totoid_, @chalmode_ chalmode_, @chalsb_ chalsb_, @chalcountry_ chalcountry_, @chalpoint_ chalpoint_

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	-- 유저 정보 얻기
	select 
		@gameid			= gameid,
		@goldball		= goldball,
		@silverball		= silverball
	from dbo.tUserMaster where gameid = @gameid_ and password = @password_
	--select 'DEBUG 1-2 ', @gameid gameid, @goldball goldball, @silverball silverball
	
	-- 토토 마스터 정보 얻기
	select @acountry = acountry, @bcountry = bcountry, @totodate = totodate
	from dbo.tTotoMaster where totoid = @totoid_
	--select 'DEBUG 1-3 ', @acountry acountry, @bcountry bcountry
	
	
	------------------------------------------------
	--	3-2-3. 연산수행
	------------------------------------------------
	if(isnull(@gameid, '') = '')
		begin
			-- 아이디가 존재하지않는가??
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID	
			set @comment = 'ERROR 아이디를 찾지 못했습니다.'
			--select 'DEBUG 2-1 ', @comment
		end
	else if(@chalmode_ not in (1, 2))
		begin
			-------------------------------------
			-- 도전모드 1, 2
			-------------------------------------
			set @nResult_ = @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment = 'ERROR 지원하지 않는 모드입니다..(1)'
			--select 'DEBUG 3-1 ', @comment
		end
	else if(getdate() > @totodate)
		begin
			-------------------------------------
			-- 금액 500 ~ 30,000
			-------------------------------------
			set @nResult_ = @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment = 'ERROR 날짜가 넘어갔습니다.(1-2)'
			--select 'DEBUG 3-2 ', @comment
		end
	else if(@chalsb_ < 500 or @chalsb_ > 30000)
		begin
			-------------------------------------
			-- 금액 500 ~ 30,000
			-------------------------------------
			set @nResult_ = @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment = 'ERROR 허용된 금액이 아닙니다.(2)'
			--select 'DEBUG 4-1 ', @comment
		end
	else if(@chalcountry_ not in (@acountry, @bcountry))
		begin
			-------------------------------------
			-- 마스터에 없는 국가번호
			-------------------------------------
			set @nResult_ = @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment = 'ERROR 국가 번호가 존재안합니다.(3)'
			--select 'DEBUG 5-1 ', @comment
		end
	else if(@chalsb_ > @silverball)
		begin
			-------------------------------------
			-- 실버부족
			-------------------------------------
			set @nResult_ = @RESULT_ERROR_SILVERBALL_LACK
			set @comment = 'ERROR 실버가 부족합니다..'
			--select 'DEBUG 6-1 ', @comment
		end
	else if(exists(select top 1 * from dbo.tTotoUser where gameid = @gameid_ and totoid = @totoid_))
		begin
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 정상처리하다.(1있음)'
			--select 'DEBUG 7-1 ', @comment
		end
	else 
		begin
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 정상처리하다.(2입력)'
			--select 'DEBUG 8-1 ', @comment
			
			---------------------------------------------------
			-- tUserMaster 실버차감
			---------------------------------------------------
			set @silverball = @silverball - @chalsb_
			update dbo.tUserMaster  
				set
					silverball		= @silverball
			where gameid = @gameid_			
			
			---------------------------------------------------
			-- tTotoUser 로그기록(1, 2모드)
			---------------------------------------------------
			if(@chalmode_ = 1)
				begin
					select @chalbat = 2
				end
			else if(@chalmode_ = 2)
				begin
					select @chalbat = 4
				end
				
			insert into dbo.tTotoUser(gameid,   totoid,   chalmode,   chalbat,  chalsb,   chalcountry,   chalpoint,  chalstate) 
			values(                  @gameid_, @totoid_, @chalmode_, @chalbat, @chalsb_, @chalcountry_, @chalpoint_, 1)
			
			---------------------------------------------------
			-- tTotoMaster 참여카운터 +1
			---------------------------------------------------
			if(exists(select top 1 * from dbo.tTotoMaster where totoid = @totoid_))
				begin
					update dbo.tTotoMaster
						set
							chalmode1cnt 	= chalmode1cnt + (case when (@chalmode_ = 1) then 1 else 0 end),
							chalmode1sb 	= chalmode1sb  + (case when (@chalmode_ = 1) then @chalsb_ else 0 end),
							
							chalmode2cnt 	= chalmode2cnt + (case when (@chalmode_ = 2) then 1 else 0 end),
							chalmode2sb 	= chalmode2sb  + (case when (@chalmode_ = 2) then @chalsb_ else 0 end)
					where totoid = @totoid_
				end
		end



	------------------------------------------------
	--	4-2. 유저정보
	------------------------------------------------
	select @nResult_ rtn, @comment comment, @goldball goldball, @silverball silverball
	
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			--------------------------------------------------------------
			-- 로그인 > WBC토토정보
			--------------------------------------------------------------
			select 
				m.totoid, m.totodate, m.totoday, m.title, m.acountry, m.bcountry, apoint, bpoint, victcountry, victpoint, chalmode1give,
				isnull(chalstate, -1) chalstate, 
				isnull(u.chalmode, -1) chalmode, isnull(u.chalbat, -1) chalbat, 
				isnull(chalsb, -1) chalsb, isnull(chalcountry, -1) chalcountry, isnull(chalpoint, -1) chalpoint, 
				isnull(chalresult1, -1) chalresult1, isnull(chalresult2, -1) chalresult2
				--, u.*
					from 
						dbo.tTotoMaster m 
							LEFT OUTER JOIN 
						(select * from dbo.tTotoUser where gameid = @gameid_) u 
							on m.totoid = u.totoid 
								where active = 1
			order by chalmode1give asc, totodate asc
		end
	
	set nocount off
End

