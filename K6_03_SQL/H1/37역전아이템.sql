/*

exec spu_RevMode 'guest74211', '5913172g3s1g3g173731', -1, -1		-- 비지원
exec spu_RevMode 'guest74211', '5913172g3s1g3g173731', 7020, -1		-- 배틀
exec spu_RevMode 'guest74211', '5913172g3s1g3g173731', 7021, -1		-- 미션
exec spu_RevMode 'guest74211', '5913172g3s1g3g173731', 7022, -1
exec spu_RevMode 'guest74211', '5913172g3s1g3g173731', 7023, -1
exec spu_RevMode 'guest74211', '5913172g3s1g3g173731', 7024, -1

*/

IF OBJECT_ID ( 'dbo.spu_RevMode', 'P' ) IS NOT NULL 
    DROP PROCEDURE dbo.spu_RevMode;
GO 

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_RevMode
	@gameid_								varchar(20),					-- 게임아이디
	@password_								varchar(20),
	@revitemcode_							int,
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
	
	-- 기타오류
	declare @RESULT_ERROR_RESULT_COPY			int				set @RESULT_ERROR_RESULT_COPY			= -53			-- 결과카피시도
	declare @RESULT_ERROR_SILVER_COPY			int				set @RESULT_ERROR_SILVER_COPY			= -54			-- 실버카피시도
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- 지원하지않는모드
	declare @RESULT_ERROR_ACTION_FULL			int				set @RESULT_ERROR_ACTION_FULL			= -71			-- 지원하지않는모드
	declare @RESULT_ERROR_WIN_LACK				int				set @RESULT_ERROR_WIN_LACK				= -72			-- 스프린트 보상.
	declare @RESULT_ERROR_TUTORIAL_ALREADY		int				set @RESULT_ERROR_TUTORIAL_ALREADY		= -73			-- 투토리얼 이미 보상.
	declare @RESULT_ERROR_FRIEND_ADD_MYGAMEID	int				set @RESULT_ERROR_FRIEND_ADD_MYGAMEID	= -74			-- 자신의 아이디를 추가.
	
	declare @BATTLE_REV_ITEM_CODE				int				set @BATTLE_REV_ITEM_CODE		= 7020
	declare @MISSION_REV_ITEM_CODE4				int				set @MISSION_REV_ITEM_CODE4		= 7021
	declare @MISSION_REV_ITEM_CODE7				int				set @MISSION_REV_ITEM_CODE7		= 7022
	declare @MISSION_REV_ITEM_CODE8				int				set @MISSION_REV_ITEM_CODE8		= 7023
	declare @MISSION_REV_ITEM_CODE9				int				set @MISSION_REV_ITEM_CODE9		= 7024
	
	
	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------	
	declare @comment			varchar(512)
	declare @gameid				varchar(20)
	declare @goldball			int
	declare @goldballPrice		int					set @goldballPrice 			= 100
	declare @silverballPrice 	int					set @silverballPrice		= 0
	declare @itemcode			int					
	
	declare @btrevitemcode		int					set @btrevitemcode 			= @BATTLE_REV_ITEM_CODE
	declare @btrevprice			int					set @btrevprice 			= 5
	declare @msrevitemcode4		int					set @msrevitemcode4 		= @MISSION_REV_ITEM_CODE4
	declare @msrevprice4		int					set @msrevprice4 			= 5
	declare @msrevitemcode7		int					set @msrevitemcode7 		= @MISSION_REV_ITEM_CODE7
	declare @msrevprice7		int					set @msrevprice7 			= 7
	declare @msrevitemcode8		int					set @msrevitemcode8 		= @MISSION_REV_ITEM_CODE8
	declare @msrevprice8		int					set @msrevprice8 			= 20
	declare @msrevitemcode9		int					set @msrevitemcode9 		= @MISSION_REV_ITEM_CODE9
	declare @msrevprice9		int					set @msrevprice9 			= 50
	
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR	
	set @comment = 'ERROR 알수없는 오류(-1)'

	
	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	--유저 정보를 읽어오기
	select 
		@gameid		= gameid,
		@goldball	= goldball
	from dbo.tUserMaster where gameid = @gameid_ and password = @password_
	--select 'DEBUG 1-1', @gameid gameid, @goldball '보유골드', @revitemcode_ revitemcode_
	
	------------------------------------------------
	--	3-3-3. 역전모드가격
	-- 각 종류별로 구분한다.
	------------------------------------------------
	select top 1  
		@btrevitemcode		= btrevitemcode, 	
		@btrevprice			= btrevprice, 		
		@msrevitemcode4		= msrevitemcode4, 	
		@msrevprice4		= msrevprice4, 		
		@msrevitemcode7		= msrevitemcode7, 	
		@msrevprice7		= msrevprice7, 		
		@msrevitemcode8		= msrevitemcode8, 	
		@msrevprice8		= msrevprice8, 		
		@msrevitemcode9		= msrevitemcode9, 	
		@msrevprice9		= msrevprice9
	from dbo.tRevModeInfo 
	order by idx desc
	--select 'DEBUG 2-1', @btrevitemcode btrevitemcode, @btrevprice btrevprice, @msrevitemcode4 msrevitemcode4, @msrevprice4 msrevprice4, @msrevitemcode7 msrevitemcode7, @msrevprice7 msrevprice7, @msrevitemcode8 msrevitemcode8, @msrevprice8 msrevprice8, @msrevitemcode9 msrevitemcode9, @msrevprice9 msrevprice9

	
	set @itemcode 		= @revitemcode_
	if(@itemcode = @btrevitemcode)
		begin
			set @goldballPrice 	= @btrevprice
			--select 'DEBUG 2-2-1 배틀역전', @itemcode itemcode, @goldballPrice goldballPrice
		end
	else if(@itemcode = @msrevitemcode4)
		begin
			set @goldballPrice 	= @msrevprice4 
			--select 'DEBUG 2-2-2 4미션역전', @itemcode itemcode, @goldballPrice goldballPrice
		end
	else if(@itemcode = @msrevitemcode7)
		begin
			set @goldballPrice 	= @msrevprice7 
			--select 'DEBUG 2-2-3 7미션역전', @itemcode itemcode, @goldballPrice goldballPrice
		end
	else if(@itemcode = @msrevitemcode8)
		begin
			set @goldballPrice 	= @msrevprice8 
			--select 'DEBUG 2-2-4 8미션역전', @itemcode itemcode, @goldballPrice goldballPrice
		end
	else if(@itemcode = @msrevitemcode9)
		begin
			set @goldballPrice 	= @msrevprice9 
			--select 'DEBUG 2-2-5 9미션역전', @itemcode itemcode, @goldballPrice goldballPrice
		end
	else 
		begin
			set @goldballPrice 	= 100 
			--select 'DEBUG 2-2-6 @@@@역전', @itemcode itemcode, @goldballPrice goldballPrice
		end
	
	
	------------------------------------------------
	-- 3-3. 각 조건별 분기
	------------------------------------------------
	if(isnull(@gameid, '') = '')
		begin
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment = 'ERROR 아이디를 찾지 못했습니다.'
			--select 'DEBUG 3' + @comment
		END
	else if (@itemcode not in (@BATTLE_REV_ITEM_CODE, @MISSION_REV_ITEM_CODE4, @MISSION_REV_ITEM_CODE7, @MISSION_REV_ITEM_CODE8, @MISSION_REV_ITEM_CODE9))
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment = 'ERROR 지원하지 않는 모드입니다.'
			--select 'DEBUG 4-0' + @comment
		END
	else if (@goldballPrice <= 0)
		BEGIN
			set @nResult_ = @RESULT_ERROR_GOLDBALL_LACK
			set @comment = 'ERROR 유효하지 않는 가격'
			--select 'DEBUG 4-1' + @comment
		END
	else if (@goldball < @goldballPrice or @goldball <= 0)
		BEGIN
			set @nResult_ = @RESULT_ERROR_GOLDBALL_LACK
			set @comment = 'ERROR 골든볼이 부족'
			--select 'DEBUG 4-2' + @comment
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 역전아이템 구매적용'
			
			--select 'DEBUG 5-1 골드충분(전) > ', @goldball '보유골드', @goldballPrice goldballPrice			
			set @goldball = @goldball - @goldballPrice
			--select 'DEBUG 5-2(후) > ', @goldball '보유골드', @goldballPrice goldballPrice			
		end
		

	---------------------------------------------------------
	-- 코드출력
	---------------------------------------------------------
	select @nResult_ rtn, @comment comment

	------------------------------------------------
	-- 4-1. 각 조건별 분기 > 결과출력
	------------------------------------------------
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			---------------------------------------------------------
			-- 유저 정보갱신
			---------------------------------------------------------
			update dbo.tUserMaster
			set
				goldball		= @goldball
			where gameid = @gameid
			
			---------------------------------------------------------
			-- 구매로그 기록
			---------------------------------------------------------
			--select 'DEBUG 6 역전아이템 구매로그 기록', goldball '보유골드', @goldballPrice '판매가' from dbo.tUserMaster where gameid = @gameid_
			insert into dbo.tItemBuyLog(gameid, itemcode, goldball, silverball) 
			values(@gameid, @itemcode, @goldballPrice, 0) 
			
			---------------------------------------------------
			-- 토탈로그 기록하기
			---------------------------------------------------
			declare @dateid varchar(8)
			set @dateid = Convert(varchar(8),Getdate(),112)		-- 20120819
			if(exists(select top 1 * from dbo.tItemBuyLogTotalSub where dateid = @dateid and itemcode = @itemcode))
				begin
					update dbo.tItemBuyLogTotalSub 
						set 
							goldball = goldball + @goldballPrice, 
							silverball = silverball + @silverballPrice, 
							cnt = cnt + 1
					where dateid = @dateid and itemcode = @itemcode
				end
			else
				begin
					insert into dbo.tItemBuyLogTotalSub(dateid, itemcode, goldball, silverball, cnt)
					values(@dateid, @itemcode, @goldballPrice, @silverballPrice, 1)
				end
				
				
			---------------------------------------------------
			-- 토탈로그 기록하기2 Master
			---------------------------------------------------
			if(exists(select top 1 * from dbo.tItemBuyLogTotalMaster where dateid = @dateid))
				begin
					update dbo.tItemBuyLogTotalMaster 
						set 
							goldball 	= goldball + @goldballPrice, 
							silverball 	= silverball + @silverballPrice, 
							cnt 		= cnt + 1
					where dateid = @dateid
				end
			else
				begin
					insert into dbo.tItemBuyLogTotalMaster(dateid, goldball, silverball, cnt)
					values(@dateid, @goldballPrice, @silverballPrice, 1)
				end
			
			---------------------------------------------------------
			-- 역전실버, 부스터모드 로그기록
			---------------------------------------------------------
			if(exists(select top 1 * from dbo.tItemBuyPromotionTotal where dateid = @dateid and itemcode = @itemcode))
				begin
					update dbo.tItemBuyPromotionTotal 
						set 
							goldball = goldball + @goldballPrice,
							cnt = cnt + 1
					where dateid = @dateid and itemcode = @itemcode
				end
			else
				begin
					insert into dbo.tItemBuyPromotionTotal(dateid, itemcode, goldball, cnt)
					values(@dateid, @itemcode, @goldballPrice, 1)
				end
			
			
		end

	------------------------------------------------
	--	4-2. 유저정보
	------------------------------------------------
	select * from dbo.tUserMaster where gameid = @gameid
	
	set nocount off
End

