/*
gameid=xxx
mode=xxx
friendid=xxx

exec spu_Friend 'SangSang', '', 0, 'DD', -1			-- 지원하지 않는 모드

exec spu_Friend 'SangSang', '', 1, '', -1			-- 검색 : 랜덤검색
exec spu_Friend 'SangSang', '', 1, 'DD', -1			-- 검색 : 이웃 > 0초
exec spu_Friend 'SangSang', '', 1, 'SangSang', -1	-- 검색 : 떨어져있음 > 0초
exec spu_Friend 'SangSang', '', 1, 'AD', -1			-- 검색 : 없음 > 0초
exec spu_Friend 'SangSang', '', 1, 'superman', -1	-- 검색 : 정확한

exec spu_Friend 'SangSang', '7575970askeie1595312', 2, 'DD0', -1		-- 친구 추가(계속추가가능)
exec spu_Friend 'SangSang', '7575970askeie1595312', 2, 'DD', -1			-- 친구 없음
exec spu_Friend 'SangSang', '7575970askeie1595312', 2, 'SangSang', -1	-- 자기추가?
exec spu_Friend 'SangSang', '7575970askeie1595312', 2, 'DD0', -1		-- 패스워드틀림
select * from dbo.tUserMaster where gameid = 'Superman'
exec spu_Friend 'Superman', '7575970askeie1595312', 2, 'Superman', -1	-- 자기추가?

exec spu_Friend 'dd5', '7575970askeie1595312', 2, 'DD1', -1
exec spu_Friend 'dd5', '7575970askeie1595312', 2, 'DD2', -1
exec spu_Friend 'dd5', '7575970askeie1595312', 2, 'DD3', -1
exec spu_Friend 'dd5', '7575970askeie1595312', 2, 'DD4', -1
exec spu_Friend 'dd5', '7575970askeie1595312', 2, 'DD6', -1
exec spu_Friend 'dd5', '7575970askeie1595312', 3, 'DD1', -1
exec spu_Friend 'dd5', '7575970askeie1595312', 3, 'DD2', -1
exec spu_Friend 'dd5', '7575970askeie1595312', 3, 'DD3', -1
exec spu_Friend 'dd5', '7575970askeie1595312', 3, 'DD4', -1
exec spu_Friend 'dd5', '7575970askeie1595312', 3, 'DD6', -1

exec spu_Friend 'SangSang', 'a1s2d3f4', 3, 'DD0', -1		-- 친구 삭제
exec spu_Friend 'SangSang', 'a1s2d3f4', 3, 'DD', -1			-- 친구 없음
exec spu_Friend 'SangSang', '1111', 3, 'DD', -1				-- 패스워드틀림

exec spu_Friend 'SangSang', '', 4, 'SangSang', -1	-- 친구 My리스트

exec spu_Friend 'SangSang', '', 5, 'DD0', -1		-- 친구 방문(있음)
exec spu_Friend 'SangSang', '', 5, 'DD', -1			-- 친구 방문(없음)
*/

IF OBJECT_ID ( 'dbo.spu_Friend', 'P' ) IS NOT NULL 
    DROP PROCEDURE dbo.spu_Friend;
GO 

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_Friend
	@gameid_								varchar(20),					-- 게임아이디
	@password_								varchar(20),
	@mode_									int,
	@friendid_								varchar(20),
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
	declare @RESULT_ERROR_WIN_LACK				int				set @RESULT_ERROR_WIN_LACK				= -72			-- 스프린트 보상.
	declare @RESULT_ERROR_TUTORIAL_ALREADY		int				set @RESULT_ERROR_TUTORIAL_ALREADY		= -73			-- 투토리얼 이미 보상.
	declare @RESULT_ERROR_FRIEND_ADD_MYGAMEID	int				set @RESULT_ERROR_FRIEND_ADD_MYGAMEID	= -74			-- 자신의 아이디를 추가.
	
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
	
	-- 친구추가에 따른 라커룸 정의값
	declare @FRIEND_LSINIT						int				set @FRIEND_LSINIT						= 5
	declare @FRIEND_LSMAX						int				set @FRIEND_LSMAX						= 20
	
	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @gameid			varchar(20)
	declare @password		varchar(20)
	declare @comment		varchar(80)
	declare @cnt			int
	declare @friendLSMax	int
	declare @friendLSMaxO	int
	

	-- 퀘스트용 데이타.
	declare @friendaddcnt			int,
			@friendvisitcnt			int	

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on

	------------------------------------------------
	-- 3-3. 각 조건별 분기
	------------------------------------------------
	if (@mode_ not in (@FRIEND_MODE_SEARCH, @FRIEND_MODE_ADD, @FRIEND_MODE_DELETE, @FRIEND_MODE_MYLIST, @FRIEND_MODE_VISIT))
		BEGIN
			set @nResult_ = @RESULT_ERROR
			select @nResult_ rtn, 'ERROR 지원하지 않는 모드입니다.'
		END
	else if (@mode_ = @FRIEND_MODE_SEARCH)
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			select @nResult_ rtn, 'SUCCESS 유저검색리스트'
			
			--1. 앞에 '%' 너무늦음			
			--set @friendid_ = '%' + @friendid_ + '%'
			--select top 10 * from dbo.tUserMaster where gameid like @friendid_ and gameid != @gameid_		
			--select top 10 * from dbo.tUserMaster where gameid = @friendid_ and gameid != @gameid_		

			if(isnull(@friendid_, '') = '')
				begin
					select top 10 * from dbo.tUserMaster where gameid != @gameid_	
					order by newid()
				end
			-- 직접검색에 문제가 있음 
			-- mogly > mogly가 존재하면 mogly만 나옴, 난 mogly, mogly2를 검색하기를 원함.
			--else if(exists(select top 1 * from dbo.tUserMaster where gameid != @gameid_ and gameid = @friendid_))
			--	begin
			--		select top 1 * from dbo.tUserMaster where gameid = @friendid_
			--	end
			else
				begin
					-- 2. 뒤 '%' 빠름
					set @friendid_ = @friendid_ + '%'
					select top 10 * from dbo.tUserMaster where gameid != @gameid_ and gameid like @friendid_ 	
				end
			
		END
	else if (@mode_ = @FRIEND_MODE_ADD)
		BEGIN
			select 
				@password = password, @friendLSMaxO = friendLSMax,
				@friendaddcnt = friendaddcnt
			from dbo.tUserMaster where gameid = @gameid_		
			
			select @cnt = count(*)  from dbo.tUserMaster where gameid in (@gameid_, @friendid_)
			
			if(isnull(@password, '') != '' and @password != @password_)
				begin
					set @nResult_ = @RESULT_ERROR_NOT_FOUND_PASSWORD
					select @nResult_ rtn, 'ERROR 패스워드가 틀립니다.'
				end
			else if(isnull(@gameid_, '') != '' and @gameid_ = @friendid_)
				begin
					set @nResult_ = @RESULT_ERROR_FRIEND_ADD_MYGAMEID
					select @nResult_ rtn, 'ERROR 자신의 아이디를 추가 할 수 없습니다.'
				end
			else if(@cnt = 2)
				begin
					------------------------------------------
					-- 친구추가
					------------------------------------------
					if(exists(select * from dbo.tUserFriend where gameid = @gameid_ and friendid = @friendid_))
						begin
							-- 친구가 있다.
							set @nResult_ = @RESULT_SUCCESS
							select @nResult_ rtn, 'SUCCESS 유저친구추가(이미추가)'
						end
					else
						begin
							--친구추가
							set @nResult_ = @RESULT_SUCCESS
							select @nResult_ rtn, 'SUCCESS 유저친구추가'
							
							insert into dbo.tUserFriend(gameid, friendid) values(@gameid_, @friendid_)
						end
					
					------------------------------------------
					-- 친구추가나 삭제에 따른 라커룸 수량변경
					-- 오리지날과 수량이 변할때 유저테이블 반영
					------------------------------------------
					select @friendLSMax = count(*) from dbo.tUserFriend where gameid = @gameid_
					set @friendaddcnt = @friendLSMax 
					set @friendLSMax = @FRIEND_LSINIT + @friendLSMax / 2
					if(@friendLSMax > @FRIEND_LSMAX)
						begin
							set @friendLSMax = @FRIEND_LSMAX
						end
					--if(@friendLSMaxO != @friendLSMax)
					--	begin
					--		update dbo.tUserMaster
					--			set
					--				friendLSMax = @friendLSMax
					--		where gameid = @gameid_	
					--	end
					update dbo.tUserMaster
						set
							friendLSMax = @friendLSMax,
							friendaddcnt = @friendaddcnt
					where gameid = @gameid_	
					
					
					------------------------------------------
					-- 친구 리스트 전송
					------------------------------------------
					select f.gameid, u.avatar, u.picture, u.ccode, u.grade, u.lv, u.btwin, u.bttotal, f.friendid, f.writedate, f.familiar 
					from dbo.tUserMaster u join dbo.tUserFriend f on u.gameid = f.friendid
					where f.gameid = @gameid_ order by familiar desc
					
					
				end
			else
				begin
					set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
					select @nResult_ rtn, 'ERROR 유저가 없습니다.'
				end

		END
	else if (@mode_ = @FRIEND_MODE_DELETE)
		BEGIN
			select 
				@password = password, @friendLSMaxO = friendLSMax,
				@friendaddcnt = friendaddcnt
			from dbo.tUserMaster where gameid = @gameid_	
			
			if(isnull(@password, '') != '' and @password != @password_)
				begin
					set @nResult_ = @RESULT_ERROR_NOT_FOUND_PASSWORD
					select @nResult_ rtn, 'ERROR 패스워드가 틀립니다.'
				end
			else if EXISTS(select * from dbo.tUserFriend where gameid = @gameid_ and friendid = @friendid_)
				begin
					set @nResult_ = @RESULT_SUCCESS
					select @nResult_ rtn, 'SUCCESS 삭제 친구리스트 삭제' + @friendid_
					
					------------------------------------------
					-- 친구삭제
					------------------------------------------
					delete from dbo.tUserFriend where gameid = @gameid_ and friendid = @friendid_
					
					
					------------------------------------------
					-- 친구추가나 삭제에 따른 라커룸 수량변경
					-- 오리지날과 수량이 변할때 유저테이블 반영
					------------------------------------------
					select @friendLSMax = count(*) from dbo.tUserFriend where gameid = @gameid_
					set @friendaddcnt = @friendLSMax 
					set @friendLSMax = @FRIEND_LSINIT + @friendLSMax / 2
					if(@friendLSMax > @FRIEND_LSMAX)
						begin
							set @friendLSMax = @FRIEND_LSMAX
						end
					--if(@friendLSMaxO != @friendLSMax)
					--	begin
					--		update dbo.tUserMaster
					--			set
					--				friendLSMax = @friendLSMax,
					--				friendLSCount = case 
					--									when friendLSCount > @friendLSMax then @friendLSMax
					--									else friendLSCount
					--								end
					--		where gameid = @gameid_	
					--	end
					update dbo.tUserMaster
						set
							friendLSMax = @friendLSMax,
							friendLSCount = case 
												when friendLSCount > @friendLSMax then @friendLSMax
												else friendLSCount
											end,
							friendaddcnt = @friendaddcnt
					where gameid = @gameid_	
			
					
					
					------------------------------------------
					-- 친구 리스트 전송
					------------------------------------------
					select f.gameid, u.avatar, u.picture, u.ccode, u.grade, u.lv, u.btwin, u.bttotal, f.friendid, f.writedate, f.familiar 
					from dbo.tUserMaster u join dbo.tUserFriend f on u.gameid = f.friendid
					where f.gameid = @gameid_ order by familiar desc
				end
			else
				begin
					set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
					select @nResult_ rtn, 'ERROR 삭제 친구리스트가 없습니다.'
				end
		END
	else if (@mode_ = @FRIEND_MODE_MYLIST)
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			select @nResult_ rtn, 'SUCCESS 유저친구리스트'
			
			select f.gameid, u.avatar, u.picture, u.ccode, u.grade, u.lv, u.btwin, u.bttotal, f.friendid, f.writedate, f.familiar 
			--select u.lv, u.grade, f.gameid, f.friendid, f.writedate, f.familiar 
			from dbo.tUserMaster u join dbo.tUserFriend f on u.gameid = f.friendid
			where f.gameid = @gameid_ order by familiar desc
		END
	else if (@mode_ = @FRIEND_MODE_VISIT)
		BEGIN
			-- 친구의 정보
			declare @cap 			int,	@cap2		int,
					@cupper			int,	@cupper2	int,
					@cunder			int,	@cunder2	int,
					@bat			int,	@bat2		int,
					@pet			int,	@pet2		int,
					@itemcode		int,	@upgradestate int
			select 
				@cap = cap, @cunder = cunder, @cupper = cupper, @bat = bat, @pet = pet
			from dbo.tUserMaster where gameid = @friendid_

			
			if(isnull(@cap, -1) != -1)
				begin
					set @nResult_ = @RESULT_SUCCESS
					select @nResult_ rtn, 'SUCCESS 친구의 정보'
					
					-- 내친구의친밀도 올리기
					-- 내것에서 친구를 방문 > gameid and friendid
					-- 친구에서 친구를 방문 >            friendid
					if(isnull(@gameid_, '') != '')
						begin
							update dbo.tUserFriend
								set
								familiar = familiar + 1
							where gameid = @gameid_ and friendid = @friendid_
						end
					
					-- 유저정보
					-- 1. 커서선언
					declare curUserItem Cursor for
					select itemcode, upgradestate from dbo.tUserItem where gameid = @friendid_ and itemcode in (@cap, @cupper, @cunder, @bat, @pet)
		
					-- 2. 커서오픈
					open curUserItem
		
					-- 3. 커서 사용
					Fetch next from curUserItem into @itemcode, @upgradestate
					while @@Fetch_status = 0
						Begin	
							if(@itemcode = @cap)
								set @cap2 = @upgradestate
							else if(@itemcode = @cupper)
								set @cupper2 = @upgradestate
							else if(@itemcode = @cunder)
								set @cunder2 = @upgradestate
							else if(@itemcode = @bat)
								set @bat2 = @upgradestate
							else if(@itemcode = @pet)
								set @pet2 = @upgradestate
							Fetch next from curUserItem into @itemcode, @upgradestate
						end
		
					-- 4. 커서닫기
					close curUserItem
					Deallocate curUserItem		
					select @cap2 capupgrade, @cunder2 cunderupgrade, @cupper2 cupperupgrade, @bat2 batupgrade, isnull(@pet2, 0) petupgrade, * from dbo.tUserMaster where gameid = @friendid_ 
					
				
					-- 친구의 친구들
					--select * from dbo.tUserFriend where gameid = @friendid_ order by familiar desc
					select f.gameid, u.avatar, u.picture, u.ccode, u.grade, u.lv, u.btwin, u.bttotal, f.friendid, f.writedate, f.familiar 
					from dbo.tUserMaster u join dbo.tUserFriend f on u.gameid = f.friendid
					where f.gameid = @friendid_ order by familiar desc
					
					
					-- 친구 방문 카운터 증가하기
					update dbo.tUserMaster
						set 
							friendvisitcnt = friendvisitcnt + 1
					where gameid = @gameid_					
				end
			else
				begin
					set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
					select @nResult_ rtn, 'ERROR 친구의 정보를 찾을수 없습니다.'
				end
		END
	else 
		begin
			set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
			select @nResult_ rtn, 'ERROR 알수없는 오류(-1)'
		end



	------------------------------------------------
	--	4-2. 유저정보
	------------------------------------------------		
	set nocount off
End

