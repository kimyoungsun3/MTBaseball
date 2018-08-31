/*
exec spu_DoubleMode 'SangSangx', '7575970askeie1595312', -1
exec spu_DoubleMode 'SangSang', '7575970askeie1595312', -1
exec spu_DoubleMode 'guest134', '3495365l5q8c1u355253', -1

*/

IF OBJECT_ID ( 'dbo.spu_DoubleMode', 'P' ) IS NOT NULL 
    DROP PROCEDURE dbo.spu_DoubleMode;
GO 

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_DoubleMode
	@gameid_								varchar(20),					-- 게임아이디
	@password_								varchar(20),
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
	
	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------	
	-- DoublePowerMode(로그인, 더블모드)
	declare @doubleitemcode					int
	declare @doublepriceinfo				int
	declare @doubleperiodinfo				int
	declare @doublepowerinfo				int
	declare @doubledegreeinfo				int
	
	declare @comment			varchar(512)		
	declare @gameid				varchar(20)
	declare @goldball			int
	declare	@doubledate			datetime
	declare @goldballPrice		int					set @goldballPrice 			= 100
	declare @silverballPrice 	int					set @silverballPrice		= 0
	declare @itemcode			int
	
	
	
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
		@goldball	= goldball,
		@doubledate = doubledate
	from dbo.tUserMaster where gameid = @gameid_ and password = @password_
	
	------------------------------------------------
	--	3-3-3. 더블모드가격
	------------------------------------------------
	select top 1  
		@doubleitemcode		= doubleitemcode,
		@doublepriceinfo	= doublepriceinfo,	
		@doubleperiodinfo	= doubleperiodinfo,
		
		@doublepowerinfo 	= doublepowerinfo,
		@doubledegreeinfo 	= doubledegreeinfo
	from dbo.tDoubleModeInfo 
	order by idx desc
	
	set @itemcode 		= @doubleitemcode
	set @goldballPrice 	= @doublepriceinfo 
	
	
	------------------------------------------------
	-- 3-3. 각 조건별 분기
	------------------------------------------------
	if(isnull(@gameid, '') = '')
		begin
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment = 'ERROR 아이디를 찾지 못했습니다.'
			--select 'DEBUG ' + @comment
		END
	else if (@goldball < @goldballPrice)
		BEGIN
			set @nResult_ = @RESULT_ERROR_GOLDBALL_LACK
			set @comment = 'ERROR 골든볼가 부족'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 더블모드 시간연장'
			
			
			--select 'DEBUG (전) > ', @doubledate doubledate, @goldball goldball			
			-- 날짜 갱신
			if(@doubledate < getdate())
				begin
					--select 'DEBUG 날자가 오늘 날자 이전'
					set @doubledate = getdate()
				end
			else
				begin
					--select 'DEBUG 날짜가 남은 것이 있다.'
					set @doubledate = @doubledate
				end
				
			set @doubledate = DATEADD(dd, @doubleperiodinfo, @doubledate)			
			set @goldball = @goldball - @goldballPrice
			

			--select 'DEBUG (후) > ', @doubledate doubledate, @goldball goldball
			
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
				doubledate 		= @doubledate,
				doublepower		= @doublepowerinfo,
				doubledegree	= @doubledegreeinfo,
				goldball		= @goldball
			where gameid = @gameid
			
			---------------------------------------------------------
			-- 구매로그 기록
			---------------------------------------------------------
			--select 'DEBUG 구매로그 기록'
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
				
			
			---------------------------------------------------------
			-- 더블실버, 부스터모드 로그기록
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

