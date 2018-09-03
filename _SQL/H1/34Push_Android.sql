/*
	 	
exec spu_UserPushMsgAndroid 'guest73799', '5108471s3a9v0v424371', 'guest73799', 1, '단순제목', '단순내용', -1, -1

exec spu_UserPushMsgAndroid 'guest73801', '7845557f9w2v5m112499', 'guest73801', 1, '단순제목', '단순내용', -1, -1
exec spu_UserPushMsgAndroid 'guest73801', '7845557f9w2v5m112499', 'guest73801', 2, '자랑제목', '자랑내용', 5, -1
exec spu_UserPushMsgAndroid 'guest73801', '7845557f9w2v5m112499', 'guest73801', 3, 'URL제목', 'http://m.naver.com', -1, -1

exec spu_UserPushMsgAndroid 'superman6', '7575970askeie1595312', 'superman6', 2, '자랑제목', '자랑내용', -1, -1

exec spu_UserPushMsgAndroid 'supermani', '049000s1i0n7t8445289', 'supermani', 1, '단순제목', '단순내용', -1, -1
exec spu_UserPushMsgAndroid 'supermani', '049000s1i0n7t8445289', 'supermani', 2, '자랑제목', '자랑내용', 5, -1
exec spu_UserPushMsgAndroid 'supermani', '049000s1i0n7t8445289', 'supermani', 3, 'URL제목', 'http://m.naver.com', -1, -1

---------------------------------
-- 복수전 : superman7 -> superman
update dbo.tUserMaster set resultwinpush = 1 where gameid in ('sususu', 'sususu2')
exec spu_UserPushMsgAndroid 'sususu', '7575970askeie1595312', 'sususu2', 2, '자랑제목', '자랑내용', 5, -1
exec spu_BattleSearch 'sususu', 'sususu2', 5, 1, -1

-- 복수전 : superman <- superman7
update dbo.tUserMaster set resultwinpush = 1 where gameid in ('sususu2', 'sususu')
exec spu_UserPushMsgAndroid 'sususu', '7575970askeie1595312', 'sususu2', 2, '자랑제목', '자랑내용', 5, -1
exec spu_BattleSearch 'sususu2', 'sususu', 5, 1, -1

*/


IF OBJECT_ID ( 'dbo.spu_UserPushMsgAndroid', 'P' ) IS NOT NULL 
    DROP PROCEDURE dbo.spu_UserPushMsgAndroid;
GO

create procedure dbo.spu_UserPushMsgAndroid
	@gameid_				varchar(20),
	@password_				varchar(20),
	@receid_				varchar(20),
	@kind_					int,
	@msgtitle_				varchar(512),
	@msgmsg_				varchar(512),
	@gmode_					int,						--현재의 게임모드.
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

	-- 캐쉬구매.
	declare @RESULT_ERROR_CASH_COPY				int				set @RESULT_ERROR_CASH_COPY				= -40			
	declare @RESULT_ERROR_CASH_OVER				int				set @RESULT_ERROR_CASH_OVER				= -41			
	declare @RESULT_ERROR_MONTH_OVER			int				set @RESULT_ERROR_MONTH_OVER			= -42			--한달동안 구매한도를 검사

	-- 아이템선물
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- 아이템코드못찾음
	declare @RESULT_ERROR_GIFTITEM_NOT_FOUND	int				set @RESULT_ERROR_GIFTITEM_NOT_FOUND	= -51			-- 선물아이템을 못찾음
	declare @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	int				set @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	= -52			-- 선물을 이미 가져감
	
	-- 게임시작
	declare @GAME_MODE_LOGERROR					int				set @GAME_MODE_LOGERROR					= -1
	declare @GAME_MODE_SBCHEAT					int				set @GAME_MODE_SBCHEAT					= -2
	declare @GAME_MODE_TRAINING					int				set @GAME_MODE_TRAINING					= 1
	declare @GAME_MODE_MACHINE					int				set @GAME_MODE_MACHINE					= 2
	declare @GAME_MODE_MEMORISE					int				set @GAME_MODE_MEMORISE					= 3
	declare @GAME_MODE_SOUL						int				set @GAME_MODE_SOUL						= 4
	declare @GAME_MODE_BATTLE					int				set @GAME_MODE_BATTLE					= 5
	declare @GAME_MODE_SPRINT					int				set @GAME_MODE_SPRINT					= 6
	
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
	
	-- 상수값들. (99)
	declare @PUSH_MODE_MSG						int				set @PUSH_MODE_MSG						= 1
	declare @PUSH_MODE_PEACOCK					int				set @PUSH_MODE_PEACOCK					= 2
	declare @PUSH_MODE_URL						int				set @PUSH_MODE_URL						= 3	
	declare @PUSH_MODE_GROUP					int				set @PUSH_MODE_GROUP					= 99	-- 단체발송용	
	
	-- 자랑하기를 통해서 보상받기.
	declare @PEACOCK_REWARD_SB_FRIEND			int				set @PEACOCK_REWARD_SB_FRIEND			= 60
	declare @PEACOCK_REWARD_SB_ALL				int				set @PEACOCK_REWARD_SB_ALL				= 30
	declare @RESULT_WIN_PUSH_PUSHED				int 			set	@RESULT_WIN_PUSH_PUSHED				= 0
	declare @RESULT_WIN_PUSH_WIN				int 			set	@RESULT_WIN_PUSH_WIN				= 1
	
	-- 통신사 구분값
	declare @SKT 							int					set @SKT						= 1
	declare @KT 							int					set @KT							= 2
	declare @LGT 							int					set @LGT						= 3
	declare @FACKBOOK 						int					set @FACKBOOK					= 4
	declare @GOOGLE 						int					set @GOOGLE						= 5
	declare @NHN							int					set @NHN						= 6
	declare @IPHONE							int					set @IPHONE						= 7
	declare @NHNWEB							int					set @NHNWEB						= 8
	declare @SKT2 							int					set @SKT2						= 11
	declare @KT2 							int					set @KT2						= 12
	declare @LGT2 							int					set @LGT2						= 13
	declare @GOOGLE2 						int					set @GOOGLE2					= 15
	declare @XXXXXXXXXXXXXXXXXXX			int					set @XXXXXXXXXXXXXXXXXXX		= 99
	
	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @gameid			varchar(20)
	declare @receid			varchar(20)
	declare @recepushid		varchar(256)
	declare @comment		varchar(512)
	declare @dateid 		varchar(8)				set @dateid 			= Convert(varchar(8),Getdate(),112)		-- 20120819
	declare @grade			int
	declare @recegrade		int
	
	declare @resultwinpush	int						set @resultwinpush 		= @RESULT_WIN_PUSH_PUSHED	
	declare @silverball		int						set @silverball			= 0
	declare @goldball		int						set @goldball			= 0
	
	declare @recemarket		int						set @recemarket			= @SKT

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	select 
		@gameid			= gameid,
		@grade			= grade,
		@silverball		= silverball,
		@goldball		= goldball,
		@resultwinpush 	= resultwinpush
	from dbo.tUserMaster where gameid = @gameid_ and password = @password_
	
	select 
		@receid		= gameid,
		@recegrade	= grade,
		@recemarket	= market,
		@recepushid	= pushid
	from dbo.tUserMaster where gameid = @receid_
				
	------------------------------------------------
	--	3-2-3. 연산수행
	------------------------------------------------
	if(isnull(@gameid, '') = '')
		begin
			-- 아이디가 존재하지않는가??
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID	
			set @comment = 'ERROR 아이디를 찾지 못했습니다.'
		end
	else if(isnull(@receid, '') = '')
		begin
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_OTHERID
			set @comment = 'ERROR 상대가 존재하지 않습니다.'
		end
	else if(@kind_ not in (@PUSH_MODE_MSG, @PUSH_MODE_PEACOCK, @PUSH_MODE_URL))
		begin
			set @nResult_ = @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment = 'ERROR 지원하지 않는 모드입니다..'
		end
	else 
		begin
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS Push 정상처리하다.'
			
			---------------------------------------------------
			-- 전송 기록하기
			---------------------------------------------------
			declare @msgtitle		varchar(512)
			declare @msgmsg			varchar(512)
			declare @msgaction		varchar(512)
			
			if(@kind_ = @PUSH_MODE_MSG)
				begin
					set @msgtitle	= @msgtitle_
					set @msgmsg		= @msgmsg_
					set @msgaction	= 'LAUNCH'
				end
			else if(@kind_ = @PUSH_MODE_PEACOCK)
				begin
					-- 핸드폰에서 자랑하기로 들어온 경우.
					set @msgtitle	= '[홈런리그]'
					--set @msgmsg		= @gameid + '님이 대전에서 승리하였습니다.'
					--(친구)님이 (유저)님과 대전하여 승리했습니다! 지금 바로 접속해서 (친구)님과 대전하세요!
					--set @msgmsg		= @gameid + '님이 대전하여 승리했습니다! 지금 바로 접속해서 ' + @gameid + '님과 대전하세요!'
					set @msgmsg		= '[' + @gameid + '님과의 대전에서 패배! 대전기록에서 복수상대를 찾으세요!'
					set @msgaction	= 'LAUNCH'

					-- 자랑하기를 통해서 전송된 경우에는 추가 실버가 지급됩니다.
					if(@resultwinpush = @RESULT_WIN_PUSH_WIN)
						begin
							---------------------------------------------------
							--	자기 >자랑하기 정상전송
							---------------------------------------------------
							if(exists(select * from dbo.tUserFriend where gameid = @gameid_ and friendid = @receid_))
								begin
									set @silverball = @silverball + @PEACOCK_REWARD_SB_FRIEND
								end
							else
								begin
									set @silverball = @silverball + @PEACOCK_REWARD_SB_ALL
								end
							
							
							update dbo.tUserMaster  
								set
									resultwinpush 	= @RESULT_WIN_PUSH_PUSHED,
									silverball		= @silverball
							where gameid = @gameid_
							
							
							---------------------------------------------------
							--	상대방 > 승리자의 아이디를 기록
							---------------------------------------------------
							--select 'DEBUG 1-1', @gmode_ gmode_, @gameid_ gameid_, @grade grade, @receid_ receid_, @recegrade recegrade
							if(@gmode_ in (@GAME_MODE_BATTLE, @GAME_MODE_SPRINT) and @grade > @recegrade - 10)
								begin
									--select 'DEBUG 1-2 > 복수전 기록'
									insert into dbo.tUserRevenge(btpgameid, btpgrade, btpgmode, gameid) 
									values(@gameid_, @grade, @gmode_, @receid_)
								end
							
							
						end
					else
						begin
							---------------------------------------------------
							--	카피플래그 기록, 로그 기록
							---------------------------------------------------
							update dbo.tUserMaster 
								set 
									resultcopy 		= resultcopy + 1
							where gameid = @gameid_
										
							insert into dbo.tUserUnusualLog(gameid, comment) 
							values(@gameid_, '자랑하기를 이용해서 캐쉬 카피를 시도할려고 했다.')
						end
				end
			else if(@kind_ = @PUSH_MODE_URL)
				begin
					set @msgtitle	= '[홈런리그]'
					set @msgmsg		= '짜릿한 한판승부~~~'
					set @msgaction	= @msgmsg_
				end
			
			if(@recemarket = @IPHONE)
				begin
					insert into dbo.tUserPushiPhone(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) 
					values(@gameid, @receid, @recepushid, @kind_, 99, @msgtitle, @msgmsg, @msgaction)
				end
			else
				begin
					insert into dbo.tUserPushAndroid(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) 
					values(@gameid, @receid, @recepushid, @kind_, 99, @msgtitle, @msgmsg, @msgaction)
				end

			---------------------------------------------------
			-- 토탈 기록하기
			---------------------------------------------------
			if(exists(select top 1 * from dbo.tUserPushAndroidTotal where dateid = @dateid))
				begin
					update dbo.tUserPushAndroidTotal 
						set
							cnt = cnt + 1
					where dateid = @dateid
				end
			else
				begin
					insert into dbo.tUserPushAndroidTotal(dateid, cnt) 
					values(@dateid, 1)
				end

		end



	------------------------------------------------
	--	4-2. 유저정보
	------------------------------------------------
	select @nResult_ rtn, @comment comment, @goldball goldball, @silverball silverball
	
	set nocount off
End

