/* 
[웹/선물하기]
gameid=xxx
itemcode=xxx

exec spu_GiftSend 'SangSang', 101, 'SangSang', -1, 0, 'adminid', 1		-- 기간템 선물
exec spu_GiftSend 'SangSang', 6000, 'SangSang', 7, 0, 'adminid', 1		-- 소모템 선물
exec spu_GiftSend 'SangSangxx', 6000, 'SangSang', 7, 0, 'adminid', 1	-- 아이디없음
exec spu_GiftSend 'SangSang', 8000, 'SangSang', 7, 0, 'adminid', 1		-- 번호없음


exec spu_GiftSend 'superman', 6004, 'SangSang', -1, 0, 'adminid', 1		-- 축하금(500실버)
exec spu_GiftSend 'superman', 9200, 'SangSang', -1, 0, 'adminid', 1		-- 축하금(50실버)
exec spu_GiftSend 'superman', 9225, 'SangSang', -1, 0, 'adminid', 1		-- 축하금(30000실버)
exec spu_GiftSend 'superman', 9300, 'SangSang', -1, 0, 'adminid', 1		-- 축하금(5골드)
exec spu_GiftSend 'superman', 9322, 'SangSang', -1, 0, 'adminid', 1		-- 축하금(500골드)
exec spu_GiftSend 'superman', 101, 'SangSang', -1, 0, 'adminid', 1
exec spu_GiftSend 'superman', 201, 'SangSang', -1, 0, 'adminid', 1
exec spu_GiftSend 'superman', 301, 'SangSang', -1, 0, 'adminid', 1
exec spu_GiftSend 'superman', 413, 'SangSang', -1, 0, 'adminid', 1
exec spu_GiftSend 'superman', 430, 'SangSang', -1, 0, 'adminid', 1
exec spu_GiftSend 'superman', 501, 'SangSang', -1, 0, 'adminid', 1
exec spu_GiftSend 'superman', 601, 'SangSang', -1, 0, 'adminid', 1
exec spu_GiftSend 'superman', 701, 'SangSang', -1, 0, 'adminid', 1
exec spu_GiftSend 'superman', 5000, 'SangSang', -1, 0, 'adminid', 1
exec spu_GiftSend 'superman', 6000, 'SangSang', -1, 0, 'adminid', 1

*/

IF OBJECT_ID ( 'dbo.spu_GiftSend', 'P' ) IS NOT NULL 
    DROP PROCEDURE dbo.spu_GiftSend;
GO 

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_GiftSend
	@gameid_								varchar(20),																-- 게임아이디
	@itemcode_								int,																		-- 선물할 아이템 코드
	@sendid_								varchar(20),
	@period2_								int,
	@upgradestate2_							int,
	@adminid_								varchar(20),
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
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50	-- 아이템코드못찾음

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

	
    
	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @itemname		varchar(80)
	declare @itemperiod		int
	
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR	
	
	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	BEGIN
		if not exists(select * from dbo.tUserMaster where gameid = @gameid_)
			BEGIN
				set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
				select @nResult_ rtn, 'ERROR 유저가 없어서 선물을 못합니다.'
			END
		else if not exists(select * from dbo.[tItemInfo] where itemcode = @itemcode_)
			BEGIN
				set @nResult_ = @RESULT_ERROR_NOT_FOUND_ITEMCODE
				select @nResult_ rtn, 'ERROR 아이템 코드('+ltrim(str(@itemcode_))+')가 존재하지 않습니다.' 
			END
		else 	
			BEGIN
				set @nResult_ = @RESULT_SUCCESS	
				select @nResult_ rtn, 'SUCCESS 선물처리되었습니다.'
				
				-- declare @itemcode_ int		set @itemcode_ = 101
				select @itemname = itemname, @itemperiod = period from dbo.tItemInfo where itemcode = @itemcode_
				
				------------------------
				-- -2일이면 오리지날
				-- 기타 양수이면 지정된 날짜
				if(@period2_ > 0)
					begin
						set @itemperiod = @period2_
					end
				else
					begin
						set @itemperiod = @itemperiod
					end
				
				
				insert into dbo.tGiftList(gameid, itemcode, giftid, period2, upgradestate2) 
				values(@gameid_ , @itemcode_, '관리자('+@adminid_+')', @itemperiod, @upgradestate2_);

				insert into tMessage(gameid, comment) 
				values(@gameid_, @itemname + '를 선물 받았습니다.')

			end
	END

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
	--select @nResult_ rtn
End
