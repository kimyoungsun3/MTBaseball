
/*				

exec spu_QuestReward 'guest73317', '8259288t0f2g7j817448', 100, -1	
delete from dbo.tGiftList where gameid ='guest73317'

exec spu_QuestReward 'superman3', '7575970askeie1595312', 100, -1	
delete from dbo.tGiftList where gameid ='superman3'
*/

IF OBJECT_ID ( 'dbo.spu_QuestReward', 'P' ) IS NOT NULL 
    DROP PROCEDURE dbo.spu_QuestReward;
GO 

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_QuestReward
	@gameid_								varchar(20),					-- 게임아이디
	@password_								varchar(20),
	@questcode_								int,
	@nResult_								int				OUTPUT
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
	declare @RESULT_ERROR_WIN_LACK				int				set @RESULT_ERROR_WIN_LACK				= -72			-- 스프린트 보상.
	declare @RESULT_ERROR_TUTORIAL_ALREADY		int				set @RESULT_ERROR_TUTORIAL_ALREADY		= -73			-- 투토리얼 이미 보상.
	declare @RESULT_ERROR_FRIEND_ADD_MYGAMEID	int				set @RESULT_ERROR_FRIEND_ADD_MYGAMEID	= -74			-- 자신의 아이디를 추가.
	
	-- 퀘스트 도달미션
	declare @QUEST_MISSION_ITEM_PERIOD			int 			set @QUEST_MISSION_ITEM_PERIOD			= 4
	declare @QUEST_MISSION_SENDER				varchar(20)		set @QUEST_MISSION_SENDER				= 'QuestMsg'
	
	-- 퀘스트 오류.
	declare @RESULT_ERROR_QUEST_CODE_NOT_FOUND	int				set @RESULT_ERROR_QUEST_CODE_NOT_FOUND	= -100			-- 퀘스트 코드를 찾을수 없다.
	declare @RESULT_ERROR_QUEST_ALREADY_REWARD	int				set @RESULT_ERROR_QUEST_ALREADY_REWARD	= -101			-- 퀘스트 이미 보상했다.
	declare @RESULT_ERROR_QUEST_NOT_ING			int				set @RESULT_ERROR_QUEST_NOT_ING			= -102			-- 퀘스트 진행중이 아니다.
	declare @RESULT_ERROR_QUEST_NOT_COMPLETED	int				set @RESULT_ERROR_QUEST_NOT_COMPLETED	= -103			-- 퀘스트 못만족하다.

	-- 퀘스트 
	declare @QUEST_KIND_UPGRADE				int 			set @QUEST_KIND_UPGRADE 			= 100	-- 강화
	declare @QUEST_KIND_MATING				int 			set @QUEST_KIND_MATING				= 200	-- 교배
	declare @QUEST_KIND_MACHINE				int 			set @QUEST_KIND_MACHINE				= 300	-- 머신
	declare @QUEST_KIND_MEMORIAL			int 			set @QUEST_KIND_MEMORIAL			= 400	-- 암기
	declare @QUEST_KIND_FRIEND				int 			set @QUEST_KIND_FRIEND				= 500	-- 친구
	declare @QUEST_KIND_POLL				int 			set @QUEST_KIND_POLL				= 600	-- 폴대
	declare @QUEST_KIND_BOARD				int 			set @QUEST_KIND_BOARD				= 700	-- 보드
	declare @QUEST_KIND_CEIL				int 			set @QUEST_KIND_CEIL				= 800	-- 천장
	declare @QUEST_KIND_BATTLE				int 			set @QUEST_KIND_BATTLE				= 900	-- 배틀
	declare @QUEST_KIND_SPRINT				int 			set @QUEST_KIND_SPRINT				= 1000	-- 스프
	
	declare @QUEST_SUBKIND_POINT_ACCRUE		int 			set @QUEST_SUBKIND_POINT_ACCRUE 	= 1		-- 누적
	declare @QUEST_SUBKIND_POINT_BEST		int 			set @QUEST_SUBKIND_POINT_BEST 		= 2		-- 최고
	declare @QUEST_SUBKIND_FRIEND_ADD		int 			set @QUEST_SUBKIND_FRIEND_ADD 		= 3		-- 추가
	declare @QUEST_SUBKIND_FRIEND_VISIT		int 			set @QUEST_SUBKIND_FRIEND_VISIT 	= 4		-- 방문
	declare @QUEST_SUBKIND_HR_CNT			int 			set @QUEST_SUBKIND_HR_CNT 			= 5		-- 홈런누적
	declare @QUEST_SUBKIND_HR_COMBO			int 			set @QUEST_SUBKIND_HR_COMBO 		= 6		-- 홈런콤보
	declare @QUEST_SUBKIND_WIN_CNT			int 			set @QUEST_SUBKIND_WIN_CNT 			= 7		-- 승누적
	declare @QUEST_SUBKIND_WIN_STREAK		int 			set @QUEST_SUBKIND_WIN_STREAK 		= 8		-- 승연승
	declare @QUEST_SUBKIND_CNT				int 			set @QUEST_SUBKIND_CNT 				= 9		-- 플레이

	declare @QUEST_INIT_NOT					int 			set @QUEST_INIT_NOT 				= 0
	declare @QUEST_INIT_FIRST				int 			set @QUEST_INIT_FIRST 				= 1
		
	declare @QUEST_CLEAR_NON				int 			set @QUEST_CLEAR_NON 				= 0
	declare @QUEST_CLEAR_START				int 			set @QUEST_CLEAR_START 				= 1
	declare @QUEST_CLEAR_REWARD				int 			set @QUEST_CLEAR_REWARD				= 2
	
	declare @QUEST_STATE_USER_END			int 			set @QUEST_STATE_USER_END 			= 0
	declare @QUEST_STATE_USER_WAIT			int 			set @QUEST_STATE_USER_WAIT 			= 1
	declare @QUEST_STATE_USER_ING			int 			set @QUEST_STATE_USER_ING 			= 2
	
	-- 퀘스트 일반정의문
	declare @QUEST_MODE_CLEAR				int 			set @QUEST_MODE_CLEAR 				= 1
	declare @QUEST_MODE_CHECK				int 			set @QUEST_MODE_CHECK 				= 2
	
	declare @QUEST_NOT_COMPLETE				int 			set @QUEST_NOT_COMPLETE 			= -1
	declare @QUEST_COMPLETED				int 			set @QUEST_COMPLETED 				= 1

	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @comment		varchar(80)
	
	declare @gameid			varchar(20)
	declare @password		varchar(20)
	declare @silverball		int,
			@lv				int
	
	declare @questcode		int,
			@queststate		int,	
			
			@questnext		int,
			@questkind		int,	
			@questsubkind	int,	
			@questvalue		int,
			@rewardsb		int,
			@rewarditem		int,
			
			@questtimenext	int,
			@questclearnext	int
			
	declare @questcomplete	int				set @questcomplete		= @QUEST_NOT_COMPLETE	
	
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR	
	set @comment = 'ERROR 존재하지 않는 아이디 입니다.'
	
	
	------------------------------------------------
	--	3-2. 유저 정보검색
	------------------------------------------------
	select 
		@gameid = gameid, 		@password = password,	
		@silverball = silverball,
		@lv = lv
	from dbo.tUserMaster where gameid = @gameid_
	
	------------------------------------------------
	--	3-3. 유저가 유효한지 검사.
	------------------------------------------------
	if isnull(@gameid, '') = ''
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment = 'ERROR 존재하지 않는 아이디 입니다.'
			--select 'DEBUG ' + @comment
		END
	else if(isnull(@password, '') = '' or @password != @password_)
		BEGIN
			-- 아이디 & 패스워드 존재하지않는가??
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_PASSWORD
			set @comment = 'DEBUG 패스워드 틀렸다. > 패스워드 확인해라'
			--select 'DEBUG ' + @comment
		END
	else
		begin
			-------------------------------------------------------
			-- 유저아이디, 퀘스트 코드 -> 유저퀘스트 진행상태
			-- 퀘스트 코드 -> 퀘스트정보 
			-- 퀘정보(info), 퀘정보(user) > 퀘스트정보읽기
			-------------------------------------------------------
			--select 'DEBUG 퀘정보(info), 퀘정보(user) > 퀘스트정보읽기'
			select 
				@questcode = u.questcode, 	@queststate = queststate, 
				@questnext = questnext,		@questkind = questkind,		@questsubkind = questsubkind,	@questvalue = questvalue, 	
				@rewardsb = rewardsb,		@rewarditem = rewarditem
			from 
				(select * from dbo.tQuestUser where gameid = @gameid_ and questcode = @questcode_) u 
					join
				(select * from dbo.tQuestInfo where questcode = @questcode_) i
					on u.questcode = i.questcode
			
			-- 퀘번호가 존재안함?
			if isnull(@questcode, -1) = -1
				BEGIN
					set @nResult_ = @RESULT_ERROR_QUEST_CODE_NOT_FOUND
					set @comment = 'ERROR 퀘번호가 정상적이지 않습니다.'
					--select 'DEBUG ' + @comment
				END
			else if(@queststate = @QUEST_STATE_USER_END)					
				BEGIN
					set @nResult_ = @RESULT_ERROR_QUEST_ALREADY_REWARD
					set @comment = 'ERROR 이미 정상 지급 했습니다.'
					--select 'DEBUG ' + @comment
				END
			else if(@queststate = @QUEST_STATE_USER_WAIT)					
				BEGIN
					set @nResult_ = @RESULT_ERROR_QUEST_NOT_ING
					set @comment = 'ERROR 진행중인 퀘가 아닙니다.'
					--select 'DEBUG ' + @comment
				END
			else if(@queststate = @QUEST_STATE_USER_ING)					
				BEGIN
					-------------------------------------------------
					-- 퀘스트가 완료 할 수 있어 보상할 수 있는가?
					-- spu_QuestCheck > 퀘검사 > 상태체크
					-------------------------------------------------
					declare @rtn 		int		
					set @rtn 			= @QUEST_NOT_COMPLETE
					exec spu_QuestCheck @QUEST_MODE_CHECK, @gameid_, @questkind, @questsubkind, @questvalue, @rtn OUTPUT
					--select 'DEBUG spu_QuestCheck > 퀘검사 > 상태체크'
					
					-------------------------------------------------
					-- 완료할수 있는가?
					if(@rtn = @QUEST_NOT_COMPLETE)
						begin		
							set @nResult_ = @RESULT_ERROR_QUEST_NOT_COMPLETED
							set @comment = 'ERROR 퀘스트 조건이 만족하지 못했습니다.'	
							--select 'DEBUG ' + @comment 
						end
					else	
						begin
							-------------------------------------------------
							set @nResult_ = @RESULT_SUCCESS
							set @comment = 'SUCCESS 퀘스트 완료했습니다.'
							select @questtimenext = isnull(questtime, -100), @questclearnext = isnull(questclear, @QUEST_CLEAR_NON) 
							from dbo.tQuestInfo 
							where questcode = @questnext
							
							-------------------------------------------------
							--select 'DEBUG 유저 실버볼 or 선물'
							set @silverball = @silverball + @rewardsb
							if(@rewarditem != -1)
								begin
									--select 'DEBUG 아이템 선물로 지급'
									insert into dbo.tGiftList(gameid, itemcode, giftid, period2) 
									values(@gameid_ , @rewarditem, @QUEST_MISSION_SENDER, @QUEST_MISSION_ITEM_PERIOD);
								end
								
							-------------------------------------------------
							--select 'DEBUG 현재퀘 완료로 변경(user)'
							update dbo.tQuestUser
								set 
									queststate = @QUEST_STATE_USER_END,
									questend = getdate()
							where gameid = @gameid_ and questcode = @questcode_
										
							-------------------------------------------------
							--select 'DEBUG 다음퀘가 즉시 클리어?'
							if(@questclearnext = @QUEST_CLEAR_REWARD)
								begin 
									--select 'DEBUG > (다음퀘)spu > 즉시 클리어 > 유저데이타중 퀘스트 데이터 클리어'
									exec spu_QuestCheck @QUEST_MODE_CLEAR, @gameid_, @questkind, @questsubkind, -1, -1
								end
								
							-------------------------------------------------
							--select 'DEBUG 다음퀘가 있는가?'
							if(@questtimenext != -100)
								begin
									--select 'DEBUG > (다음퀘)설정하기 다음퀘번호:' + ltrim(rtrim(str(@questnext))) + ' 시간:' + ltrim(rtrim(str(@questtimenext)))
									
									if exists (select * from dbo.tQuestUser where gameid = @gameid_ and questcode = @questnext)
										begin
											--select 'DEBUG 다음퀘 존재 > Update 대기중, 진행일 + 시간'
											update dbo.tQuestUser 
												set 
													queststate = @QUEST_STATE_USER_WAIT,
													queststart = DATEADD(hh, @questtimenext, getdate())
											where gameid = @gameid_ and questcode = @questnext
										end
									else	
										begin	
											--select 'DEBUG 다음퀘 없음 > insert 대기중, 진행일 + 시간'
											insert into dbo.tQuestUser(gameid, questcode, queststate, queststart) 
											values(@gameid_, @questnext, @QUEST_STATE_USER_WAIT, DATEADD(hh, @questtimenext, getdate()))
										end
								end
								
							-------------------------------------------------
							--select 'DEBUG 퀘상태값 재정의하기'
							update dbo.tQuestUser 
								set 
									queststate = @QUEST_STATE_USER_ING
							where gameid = @gameid_ 
								and queststate = @QUEST_STATE_USER_WAIT 
								and getdate() >= queststart
						end	
				end	
		end
	

	------------------------------------------------
	--	3-5. 유저 데이타 정리하기
	--       각 조건별 분기 > 결과출력
	------------------------------------------------
	if(@nResult_ in (@RESULT_SUCCESS, @RESULT_ERROR_QUEST_ALREADY_REWARD))
		begin
			-- 메시지 출력	
			select @nResult_ rtn, @comment
		
			-- 유저정보 갱신, 유저정보 퀘데이타	(위에서 처리함)
			update dbo.tUserMaster
				set
					silverball = @silverball
			where gameid = @gameid_
			
			-- 유저 퀘데이타 정보
			select * from dbo.tUserMaster where gameid = @gameid_
						
			--> 진행중 리스트 만들기
			select * from dbo.tQuestInfo 
			where questcode in (
				select questcode from dbo.tQuestUser 
				where gameid = @gameid_ and queststate = @QUEST_STATE_USER_ING and @lv >= questlv
			)
			order by questorder
			
			-- 선물 리스트 정보
			select top 50 idx, itemcode, convert(varchar(16), giftdate, 20) as giftdate, giftid, period2, upgradestate2
			from dbo.tGiftList 
			where gameid = @gameid_ and gainstate = 0 
			order by idx desc
		end
	else
		begin
			select @nResult_ rtn, @comment
		end
	
	set nocount off
End

