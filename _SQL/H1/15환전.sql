/*
gameid=xxx
password=xxx
goldball=xxx


exec spu_CashChange 'NotFound', 'a1s2d3f4', 20, -1		-- 아이디 오류
exec spu_CashChange 'SangSang', 'passerror', 20, -1		-- 패스워드 오류
-- update  dbo.tUserMaster set goldball = 0 where gameid = 'SangSang'
-- update  dbo.tUserMaster set goldball = 1000 where gameid = 'SangSang'
exec spu_CashChange 'SangSang', '7575970askeie1595312', 20, -1		-- 정상환전
exec spu_CashChange 'SangSang', '7575970askeie1595312', 50, -1
exec spu_CashChange 'SangSang', '7575970askeie1595312', 100, -1
exec spu_CashChange 'SangSang', '7575970askeie1595312', 300, -1
exec spu_CashChange 'SangSang', '7575970askeie1595312', 500, -1
*/

IF OBJECT_ID ( 'dbo.spu_CashChange', 'P' ) IS NOT NULL 
    DROP PROCEDURE dbo.spu_CashChange;
GO 

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_CashChange
	@gameid_								varchar(20),					-- 게임아이디
	@password_								varchar(20),
	@goldballChange_						int,
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
	declare @RESULT_ERROR_ITEM_NOSALE_KIND		int				set @RESULT_ERROR_ITEM_NOSALE_KIND		= -37			--판매하지 않는 아이템
	declare @RESULT_ERROR_ITEM_PERMANENT_ALREADY int			set @RESULT_ERROR_ITEM_PERMANENT_ALREADY = -38			-- 영구템을 이미 구해했습니다.
	declare @RESULT_ERROR_ITEM_NOCHANGE_KIND	int				set @RESULT_ERROR_ITEM_NOCHANGE_KIND	= -39			--자체변경불가템

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
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- 지원하지않는모드
	declare @RESULT_ERROR_ACTION_FULL			int				set @RESULT_ERROR_ACTION_FULL			= -71			-- 지원하지않는모드
	
	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------	
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
	
	-- 아이템파트이름
	declare @ITEM_KIND_CHARACTER				int 			set @ITEM_KIND_CHARACTER				= 0
	declare @ITEM_KIND_FACE						int 			set @ITEM_KIND_FACE						= 1			-- 판매템아님
	declare @ITEM_KIND_CAP						int 			set @ITEM_KIND_CAP						= 2
	declare @ITEM_KIND_UPPER					int 			set @ITEM_KIND_UPPER					= 4
	declare @ITEM_KIND_UNDER					int 			set @ITEM_KIND_UNDER					= 5
	declare @ITEM_KIND_BAT						int 			set @ITEM_KIND_BAT						= 6
	declare @ITEM_KIND_GLASSES					int 			set @ITEM_KIND_GLASSES					= 7
	declare @ITEM_KIND_WING						int 			set @ITEM_KIND_WING						= 8
	declare @ITEM_KIND_TAIL						int 			set @ITEM_KIND_TAIL						= 9
	declare @ITEM_KIND_STADIUM					int 			set @ITEM_KIND_STADIUM					= 100
	declare @ITEM_KIND_CUSTOMIZE				int 			set @ITEM_KIND_CUSTOMIZE					= 22		-- 판매방식이 다름
	declare @ITEM_KIND_PET						int 			set @ITEM_KIND_PET						= 80
	declare @ITEM_KIND_BATTLEITEM				int 			set @ITEM_KIND_BATTLEITEM				= 90
	declare @ITEM_KIND_SYSTEMETC				int 			set @ITEM_KIND_SYSTEMETC				= 99
	
	-- 기타 정의값
	declare @ITEM_PERMANENT_START_DAY			datetime		set @ITEM_PERMANENT_START_DAY			= '2012-01-01'	-- 영구템시작
	declare @ITEM_PERMANENT_ADD_YEAR			int				set @ITEM_PERMANENT_ADD_YEAR			= 50			-- 영구템기간
	declare @ITEM_PERIOD_PERMANENT				int 			set @ITEM_PERIOD_PERMANENT				= -1			-- 테이블에 -1이라 기록됨

	--아이템만기
	declare @ITEM_EXPIRE_STATE_NO				int 			set @ITEM_EXPIRE_STATE_NO				= 0			
	declare @ITEM_EXPIRE_STATE_YES				int				set @ITEM_EXPIRE_STATE_YES				= 1

	-- 코인으로 무엇인가 얻을 경우.
	declare @COIN_RESULT_SILVER_ITEM			int				set @COIN_RESULT_SILVER_ITEM 			= 1;
	declare @COIN_RESULT_PERIOD_ITEM			int				set	@COIN_RESULT_PERIOD_ITEM			= 2;
	declare @COIN_RESULT_BATTLE_ITEM1			int				set	@COIN_RESULT_BATTLE_ITEM1			= 3;
	declare @COIN_RESULT_BATTLE_ITEM2			int				set	@COIN_RESULT_BATTLE_ITEM2			= 4;
	declare @COIN_RESULT_BATTLE_ITEM3			int				set	@COIN_RESULT_BATTLE_ITEM3			= 5;
	declare @COIN_RESULT_BATTLE_ITEM4			int				set	@COIN_RESULT_BATTLE_ITEM4			= 6;
	declare @COIN_RESULT_BATTLE_ITEM5			int				set	@COIN_RESULT_BATTLE_ITEM5			= 7;
	
	-- 액션충전
	declare @MODE_ACTION_RECHARGE_FULL			int				set	@MODE_ACTION_RECHARGE_FULL			= 1;
	declare @MODE_ACTION_RECHARGE_HALF			int				set	@MODE_ACTION_RECHARGE_HALF			= 2;
	declare @ITEMCODE_ACTION_RECHARGE_FULL		int				set	@ITEMCODE_ACTION_RECHARGE_FULL		= 7000;
	declare @ITEMCODE_ACTION_RECHARGE_HALF		int				set	@ITEMCODE_ACTION_RECHARGE_HALF		= 7001;
	
	-- 친구검색, 추가, 삭제
	declare @FRIEND_MODE_SEARCH					int				set	@FRIEND_MODE_SEARCH					= 1;
	declare @FRIEND_MODE_ADD					int				set	@FRIEND_MODE_ADD					= 2;
	declare @FRIEND_MODE_DELETE					int				set	@FRIEND_MODE_DELETE					= 3;
	declare @FRIEND_MODE_MYLIST					int				set	@FRIEND_MODE_MYLIST					= 4;
	declare @FRIEND_MODE_VISIT					int				set	@FRIEND_MODE_VISIT					= 5;
	
	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @gameid			varchar(20)
	declare @password		varchar(20)
	declare @goldball		int
	declare @silverball		int
	declare @silverball2	int
	declare @plussilverball	int					set @plussilverball	= 0

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	select 	@gameid = gameid, @password = password, @goldball = goldball, @silverball = silverball
	from dbo.tUserMaster where gameid = @gameid_
	
	if(isnull(@gameid, '') = '')
		begin
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
			select @nResult_ rtn, 'ERROR 아이디를 찾지 못했습니다.'
		end
	else if(@password != @password_)
		begin
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_PASSWORD
			select @nResult_ rtn, 'ERROR 패스워드가 일치하지 않습니다.'
		end
	else if(@goldballChange_ < 20)
		begin
			set @nResult_ = @RESULT_ERROR_GOLDBALL_LACK
			select @nResult_ rtn, 'ERROR 골든볼이 부족합니다.'

			-- 환전이상행동을 해서 > 블럭처리, 블럭로그기록
			update dbo.tUserMaster 
				set 
					blockstate = @BLOCK_STATE_YES,
					cashcopy = 0
			where gameid = @gameid_

			-- 아이템3회 카피에 대한 블럭처리
			insert into dbo.tUserBlockLog(gameid, comment)
			values(@gameid_, '캐쉬환전에서 카피를 해서 시스템에서 블럭 처리했습니다. 골드:' + ltrim(rtrim(str(@goldballChange_))) )	

		end
	else if(@goldball < @goldballChange_)
		begin
			set @nResult_ = @RESULT_ERROR_GOLDBALL_LACK
			select @nResult_ rtn, 'ERROR 골든볼이 부족합니다.'
		end
	else if(@gameid = @gameid_ and @password = @password_ and @goldball >= @goldballChange_)
		begin
			-------------------------
			-- 환전금액 계산
			-------------------------
			declare @plus decimal(10, 1)
			set @plus = 0
			if(@goldballChange_ <= 20)
				begin
					set @plus = 0.1
				end
			else if(@goldballChange_ <= 50)
				begin
					set @plus = 0.2
				end
			else if(@goldballChange_ <= 100)
				begin
					set @plus = 0.3
				end
			else if(@goldballChange_ <= 300)
				begin
					set @plus = 0.4
				end
			else if(@goldballChange_ < 500)
				begin
					set @plus = 0.5
				end
			else 
				begin
					set @plus = 1.0
				end
				
			-------------------------------------------------
			--	실버환전 계산
			-------------------------------------------------
			set @silverball2 = (@goldballChange_ * 200) + (@goldballChange_ * 200) * @plus
				
			-------------------------------------------------
			-- 추가 실버세팅되어 있다면
			-------------------------------------------------
			select top 1 @plussilverball = plussilverball 
			from dbo.tActionInfo where flag = 1 
			order by idx desc
			if(@plussilverball > 0 and @plussilverball <= 100)
				begin
					set @silverball2 = @silverball2 + (@silverball2 * @plussilverball / 100)
				end
			
			-------------------------------------------------
			--	환전골드 차감
			--	추가 실버 최종Plus
			-------------------------------------------------
			set @goldball =  @goldball - @goldballChange_
			set @silverball =  @silverball + @silverball2

			-------------------------
			-- 출력하기
			-------------------------
			set @nResult_ = @RESULT_SUCCESS
			select @nResult_ rtn, 'SUCCESS 환전했습니다.' + ltrim(str(@silverball2))

			
			-- 유저 정보를 갱신한다.
			update dbo.tUserMaster
				set
					goldball = @goldball,
					silverball = @silverball
			where gameid = @gameid_
			
			---------------------------------------------
			-- 환전한 기록
			---------------------------------------------
			insert into dbo.tCashChangeLog(gameid, goldball, silverball) 
			values(@gameid_, @goldballChange_, @silverball2)
			
			-- 토탈로그 기록하기
			declare @dateid varchar(8)
			set @dateid = Convert(varchar(8),Getdate(),112)		-- 20120819
			if(exists(select top 1 * from dbo.tCashChangeLogTotal where dateid = @dateid))
				begin
					update dbo.tCashChangeLogTotal 
						set 
							goldball = goldball + @goldballChange_, 
							silverball = silverball + @silverball2, 
							changecnt = changecnt + 1
					where dateid = @dateid
				end
			else
				begin
					insert into dbo.tCashChangeLogTotal(dateid, goldball, silverball, changecnt)
					values(@dateid, @goldballChange_, @silverball2, 1)
				end

			
			--유저 정보 전송
			select * from dbo.tUserMaster where gameid = @gameid_
			
		end
	else 
		begin
			set @nResult_ = @RESULT_ERROR
			select @nResult_ rtn, 'ERROR 알수없는 오류(-1)'
		end



	------------------------------------------------
	--	4-2. 유저정보
	------------------------------------------------		
	set nocount off
End

