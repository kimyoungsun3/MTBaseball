---------------------------------------------------------------
/* 
[선물받기]
idx=1
--선물리스트
select a.idx idx2, gameid, gainstate, gaindate, giftid, giftdate, a.period2, b.* from 
	(select top 20 * from dbo.tGiftList order by giftdate desc) a  
	INNER JOIN 
	dbo.tItemInfo b 
	ON a.itemcode = b.itemcode 


update dbo.tGiftList set gainstate = 0 where idx in(16, 17, 18, 19, 20, 21)
exec spu_GiftGain 16, 1		-- 기간템(7일)
exec spu_GiftGain 16, 1		-- 이미 지급한것
exec spu_GiftGain 1000, 1	-- 존재하지 않는것
exec spu_GiftGain 17, 1		-- 기간템(7일)+a
exec spu_GiftGain 18, 1		-- 기간템(영구)
exec spu_GiftGain 19, 1		-- 기간템(영구)
exec spu_GiftGain 20, 1		-- 소모템(배틀)
exec spu_GiftGain 21, 1		-- 소모템(배틀)

exec spu_GiftGain 3917, 1	

select gameid, goldball, silverball from dbo.tUserMaster where gameid = 'superman'
exec spu_GiftGain 43139, 1	-- 축하금(5골드)(9300)
exec spu_GiftGain 43138, 1	-- 축하금(500실버)(9200)
exec spu_GiftGain 43142, 1	-- 자동타격 3(6004)
*/

IF OBJECT_ID ( 'dbo.spu_GiftGain', 'P' ) IS NOT NULL 
    DROP PROCEDURE dbo.spu_GiftGain;
GO 

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_GiftGain
	@idx_									int,							-- 선물인덱스
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
	declare @ITEM_KIND_PETREWARD				int 			set @ITEM_KIND_PETREWARD				= 98
	declare @ITEM_KIND_GIFTGOLDBALL				int 			set @ITEM_KIND_GIFTGOLDBALL				= 101
	declare @ITEM_KIND_CONGRATULATE_BALL		int 			set @ITEM_KIND_CONGRATULATE_BALL		= 102

	--아이템만기
	declare @ITEM_EXPIRE_STATE_NO				int 			set @ITEM_EXPIRE_STATE_NO				= 0			
	declare @ITEM_EXPIRE_STATE_YES				int				set @ITEM_EXPIRE_STATE_YES				= 1
	--declare @DAY_PLUS_TIME						bigint			set @DAY_PLUS_TIME 						= 24*60*60

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
	

	-- 기타 정의값
	declare @ITEM_PERMANENT_START_DAY			datetime		set @ITEM_PERMANENT_START_DAY			= '2012-01-01'	--- 영구템시작
	declare @ITEM_PERMANENT_ADD_YEAR			int				set @ITEM_PERMANENT_ADD_YEAR			= 50			--- 영구템기간
	declare @ITEM_PERIOD_PERMANENT				int 			set @ITEM_PERIOD_PERMANENT				= -1			-- 테이블에 -1이라 기록됨
	
    
	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------

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
		-- declare @idx_ int set @idx_ = 1
		declare @comment		varchar(80)
		declare @plussb 		int 		set @plussb = 0
		declare @plusgb 		int 		set @plusgb = 0
		declare @silverball		int
		declare @goldball		int
		declare @gameid			varchar(20),
				@itemcode		int,
				@gainstate		int,
				@period2		int,
				@upgradestate2	int
		declare @nparam1		int			set @nparam1	= 0
		declare @nparam2		int			set @nparam2	= 0
		
		-- 아이템 지급
		select @gameid = gameid, @itemcode = itemcode , @gainstate = gainstate, @period2 = period2, @upgradestate2 = upgradestate2 from dbo.tGiftList where idx = @idx_
		
		-- 유저 정보 읽어오기
		select 
			@silverball = silverball,
			@goldball = goldball
		from dbo.tUserMaster where gameid = @gameid
		

		if isnull(@itemcode, -1) = -1
			BEGIN
				set @nResult_ = @RESULT_ERROR_GIFTITEM_NOT_FOUND
				set @comment = 'ERROR 선물아이템 존재자체를 안함'
			END
		else if @gainstate = @GAINSTATE_YES
			BEGIN
				set @nResult_ = @RESULT_ERROR_GIFTITEM_ALREADY_GAIN
				set @comment = 'ERROR 아이템을 이미 지급했습니다.' 
			END
		else 	
			BEGIN
				set @nResult_ = @RESULT_SUCCESS	
				set @comment = 'SUCCESS 정상 지급 처리합니다.'

				-- 아이템이 소모성인가?
				-- select * from dbo.tUserItem where gameid = 'SangSang' order by idx desc
				-- 6000 ~ 6004(소모성)
				-- 201(착용:7:기존), 5000(늑대팻:-1:기존)
				-- declare @itemcode int	set @itemcode = 201	declare @gameid varchar(20)		set @gameid='SangSang'
				declare @itemkind	int
				declare @itemcount	int		
				declare @itemperiod int
				declare @itemupgrade int
				declare @itemcount1	int		set @itemcount1 = 0
				declare @itemcount2	int		set @itemcount2 = 0
				declare @itemcount3	int		set @itemcount3 = 0
				declare @itemcount4	int		set @itemcount4 = 0
				declare @itemcount5	int		set @itemcount5 = 0

				---------------------------------------------
				-- 선물에 기간이 들어가게 변경됨.
				---------------------------------------------
				--select @itemkind = kind, @itemcount = param1, @itemperiod = period from dbo.tItemInfo where itemcode = @itemcode
				select 
					@itemkind = kind, 
					@itemcount = param1
				from dbo.tItemInfo where itemcode = @itemcode				
				
				set @itemperiod = @period2
				set @itemupgrade = @upgradestate2
				
				
				if(@itemkind not in(@ITEM_KIND_BATTLEITEM, @ITEM_KIND_SYSTEMETC, @ITEM_KIND_PETREWARD, @ITEM_KIND_GIFTGOLDBALL, @ITEM_KIND_CONGRATULATE_BALL))
					begin
						-- 유저아이템 테이블에 아이템 존재유무 파악
						--select 'DEBUG 착용'
						if not exists(select * from dbo.tUserItem where gameid = @gameid and itemcode = @itemcode)
							begin
								------------------------------------------------------
								-- 20강 이상이면 영구템으로 바뀐다.
								------------------------------------------------------
								if(@itemupgrade >= 20)
									begin
										set @itemperiod = @ITEM_PERIOD_PERMANENT
									end
							
								------------------------------------------------------
								--select ' > DEBUG 신규입력'
								if(@itemperiod != @ITEM_PERIOD_PERMANENT)
									begin
										--select '  > DEBUG 신규기간(dd):' + str(@itemperiod)
										insert into dbo.tUserItem(gameid, itemcode, expiredate, upgradestate)
										values(@gameid, @itemcode, DATEADD(dd, @itemperiod, getdate()), @itemupgrade)
									end
								else
									begin
										--select '  > DEBUG 신규영구(yy):' + str(@itemperiod)
										insert into dbo.tUserItem(gameid, itemcode, expiredate, upgradestate)
										values(@gameid, @itemcode, DATEADD(yy, @ITEM_PERMANENT_ADD_YEAR, @ITEM_PERMANENT_START_DAY), @itemupgrade)
									end
							end
						else
							begin
								--select ' > DEBUG 템존재 > 날짜업그레이드'
								--select ' DEBUG 전', * from dbo.tUserItem where gameid = @gameid and itemcode = @itemcode
								if(@itemperiod != @ITEM_PERIOD_PERMANENT)
									begin
										--select '  > DEBUG 템존재 > 날짜업기간(dd):' + str(@itemperiod)
										update dbo.tUserItem
											set
										expirestate = 0,
										expiredate = case 
														when @itemupgrade >= 20 		then DATEADD(yy, @ITEM_PERMANENT_ADD_YEAR, @ITEM_PERMANENT_START_DAY)
														when getdate() > expiredate 	then DATEADD(dd, @itemperiod, getdate())
														else DATEADD(dd, @itemperiod, expiredate)
													end,
										upgradestate = case
														when @itemupgrade > upgradestate then @itemupgrade
														else upgradestate
													end
										where gameid = @gameid and itemcode = @itemcode										
									end
								--else
								--	begin
								--		--select '  > DEBUG 템존재 > 날짜업기간(yy):' + str(@itemperiod) + ' > 의미없어 패스'
								--		-- 의미가 없어서 패스
								--	end
								--select ' DEBUG 후', * from dbo.tUserItem where gameid = @gameid and itemcode = @itemcode
							end	
					end
				else if(@itemkind = @ITEM_KIND_PETREWARD)
					begin
						set @plussb = isnull(@itemcount, 0)
						
						if(@plussb < 0)
							begin 
								set @plussb = 20
							end
						else if(@plussb > 80)
							begin 
								set @plussb = 80
							end
						
						set @silverball = @silverball + @plussb
							
						update dbo.tUserMaster
						set
							silverball = @silverball 
						where gameid = @gameid
					end
				else if(@itemkind = @ITEM_KIND_GIFTGOLDBALL)
					begin
						set @plusgb = isnull(@itemcount, 0)
						
						if(@plusgb < 0)
							begin 
								set @plusgb = 20
							end
						else if(@plusgb > 1320)
							begin 
								set @plusgb = 1320
							end
						set @goldball = @goldball + @plusgb
							
						update dbo.tUserMaster
						set
							goldball = @goldball
						where gameid = @gameid
					end
				else if(@itemkind = @ITEM_KIND_CONGRATULATE_BALL)
					begin
						------------------------------------
						-- 축하금(실버)
						-- 데이타가 문자형이라서 정수형으로 변환하는 부분만 필요해서 여기서 받는다.
						------------------------------------
						select 
							@nparam1 = param1, 	
							@nparam2 = param2
						from dbo.tItemInfo where itemcode = @itemcode
						
						------------------------------------
						-- 축하금(실버)
						------------------------------------
						set @plussb = isnull(@nparam1, 0)						
						if(@plussb < 0)
							begin 
								set @plussb = 0
							end
						else if(@plussb > 30000)
							begin 
								set @plussb = 30000
							end
						set @silverball = @silverball + @plussb
							
						------------------------------------
						-- 축하금(골드)
						------------------------------------
						set @plusgb = isnull(@nparam2, 0)
						if(@plusgb < 0)
							begin 
								set @plusgb = 0
							end
						else if(@plusgb > 500)
							begin 
								set @plusgb = 500
							end
						set @goldball = @goldball + @plusgb
							
						update dbo.tUserMaster
						set
							silverball = @silverball,
							goldball = @goldball
						where gameid = @gameid
					end
				else
					begin
						-- declare @itemcode int set @itemcode = 6000
						if(@itemcode = 6000)
							begin
								set @itemcount1 = @itemcount
							end
						else if(@itemcode = 6001)
							begin
								set @itemcount2 = @itemcount
							end
						else if(@itemcode = 6002)
							begin
								set @itemcount3 = @itemcount
							end
						else if(@itemcode = 6003)
							begin
								set @itemcount4 = @itemcount
							end
						else if(@itemcode = 6004)
							begin
								set @itemcount5 = @itemcount
							end
			
						--select 'DEBUG 배틀 소모성', @itemcount1, @itemcount2, @itemcount3, @itemcount4, @itemcount5

						update dbo.tUserMaster
						set
							bttem1cnt = bttem1cnt + @itemcount1,
							bttem2cnt = bttem2cnt + @itemcount2,
							bttem3cnt = bttem3cnt + @itemcount3,
							bttem4cnt = bttem4cnt + @itemcount4,
							bttem5cnt = bttem5cnt + @itemcount5
						where gameid = @gameid
						--select 'DEBUG 배틀 소모성', bttem1cnt, bttem2cnt, bttem3cnt, bttem4cnt, bttem5cnt from dbo.tUserMaster where gameid = @gameid
					end

				-- 아이템 가져간 상태로 돌려둔다.
				update dbo.tGiftList 
				set 
					gainstate = @GAINSTATE_YES,
					gaindate = getdate()
				where idx = @idx_
			END
	END

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
	
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			select @nResult_ rtn, @comment comment, * from dbo.tUserMaster where gameid = @gameid
		end
	else
		begin
			select @nResult_ rtn, @comment comment, @silverball silverball, @goldball goldball, 0 bttem1cnt, 0 bttem2cnt, 0 bttem3cnt, 0 bttem4cnt, 0 bttem5cnt
		end
	
	
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			-- 유저 보유 아이템 정보	
			-- declare @gameid_ varchar(20) set @gameid_ = 'SangSang'
			--select itemcode, convert(varchar(19), expiredate, 20) as expiredate, datediff(mi, getdate(), expiredate) as remaintime, upgradestate
			select itemcode, expiredate, datediff(mi, getdate(), expiredate) as remaintime, upgradestate
			from dbo.tUserItem where gameid = @gameid and expirestate = @ITEM_EXPIRE_STATE_NO
		
			-- 유저 강화된 미보유 아이템(강화표시에 사용하기 위해서)
			-- declare @gameid_ varchar(20) set @gameid_ = 'SangSang'
			select itemcode, upgradestate from dbo.tUserItem where gameid = @gameid and expirestate = @ITEM_EXPIRE_STATE_YES and upgradestate > 0
			
			
			-- 선물 리스트 정보
			-- declare @gameid_ varchar(20) set @gameid_ = 'SangSang'
			select top 50 idx, itemcode, convert(varchar(16), giftdate, 20) as giftdate, giftid, period2, upgradestate2
			from dbo.tGiftList 
			where gameid = @gameid and gainstate = @GAINSTATE_NON 
			order by idx desc
		
		end
End

