/*
exec spu_FVFriend 'xxxx', '049000s1i0n7t8445289',  0, 'DD', 	 -1		-- 지원하지 않는 모드

exec spu_FVFriend 'xxxx', '049000s1i0n7t8445289',  1, '', 	 -1		-- 검색 : 랜덤검색
exec spu_FVFriend 'xxxx', '049000s1i0n7t8445289',  1, 'gu', 	 -1		-- 검색 : 이웃 > 0초
exec spu_FVFriend 'xxxx', '049000s1i0n7t8445289',  1, 'AD', 	 -1		-- 검색 : 없음 > 0초
exec spu_FVFriend 'xxxx', '049000s1i0n7t8445289',  1, 'xxxx2', -1		-- 검색 : 이웃 > 0초
exec spu_FVFriend 'xxxx', '049000s1i0n7t8445289',  1, 'xxxx3', -1		-- 검색 : 이웃 > 0초
exec spu_FVFriend 'xxxx', '049000s1i0n7t8445289',  1, 'xxxx4', -1		-- 검색 : 이웃 > 0초
exec spu_FVFriend 'xxxx2','049000s1i0n7t8445289',  1, 'xxxx3', -1		-- 검색 : 이웃 > 0초

exec spu_FVFriend 'xxx0', '049000s1i0n7t8445289',  2, 'DD', 	 -1		-- 신청 : 내가 없음
exec spu_FVFriend 'xxxx', '049000s1i0n7t8445289',  2, 'DD',	 -1		-- 신청 : 친구 없음
exec spu_FVFriend 'xxxx2', '049000s1i0n7t8445289' ,2, 'xxxx2', -1		-- 신청 : 친구 = 나
exec spu_FVFriend 'xxxx', '049000s1i0n7t8445289',  2, '', 	 -1		-- 신청 : 친구 공백
exec spu_FVFriend 'xxxx2','049000s1i0n7t8445289',  2, 'xxxx3', -1		-- 신청 : 친구 추가(계속추가가능)

exec spu_FVFriend 'xxxx0', '049000s1i0n7t8445289', 3, 'xxxx',  -1		-- 삭제 : 친구 삭제, 없음
exec spu_FVFriend 'xxxx2', '049000s1i0n7t8445289', 3, 'xxxx2', -1		-- 삭제 : 나를 삭제 안됨.
exec spu_FVFriend 'xxxx2', '049000s1i0n7t8445289', 3, 'xxxx3', -1		-- 삭제 : OK(친구수락대기 삭제됨)
exec spu_FVFriend 'xxxx2', '049000s1i0n7t8445289', 3, 'xxxx3', -1		-- 삭제 : OK(상호친구     삭제됨)

exec spu_FVFriend 'xxxx2', '049000s1i0n7t8445289', 6, 'xxxx3', -1		-- 수락 : 신청자가 수락요청(못함)
exec spu_FVFriend 'xxxx3', '049000s1i0n7t8445289', 6, 'xxxx2', -1		-- 수락 : OK

exec spu_FVFriend 'xxxx2', '049000s1i0n7t8445289', 4, '', -1			-- 리스트 : 친구 리스트(상호친구)

update dbo.tFVUserMaster set market = 5, version = 115  where gameid = 'xxxx2'
exec spu_FVFriend 'xxxx2', '049000s1i0n7t8445289', 5, 'xxxx3', -1				-- 방문 : 친구방문.
exec spu_FVFriend 'xxxx2', '049000s1i0n7t8445289', 5, 'farm939103838', -1		-- 방문 : 친구방문.

update dbo.tFVUserFriend set senddate = getdate() - 1 where gameid = 'xxxx2' and friendid = 'xxxx3'
exec spu_FVFriend 'xxxx2', '049000s1i0n7t8445289', 7, 'xxxx3', -1		-- 하트 : 하트선물, 포인트누적.

exec spu_FVFriend 'xxxx2', '049000s1i0n7t8445289', 8, 'xxxx', -1		-- 친구 빌려쓰기

-- update dbo.tFVUserMaster set condate = getdate() - 31, rtndate = getdate() - 1 where gameid = 'xxxx3'
-- update dbo.tFVUserMaster set condate = getdate() - 31, rtndate = getdate() - 1  where gameid = 'xxxx4'
exec spu_FVFriend 'xxxx2', '049000s1i0n7t8445289', 9, 'xxxx3', -1		-- 친구 복귀요청.(활동)
exec spu_FVFriend 'xxxx2', '049000s1i0n7t8445289', 9, 'xxxx4', -1		-- 친구 복귀요청.(처음, 이미)
*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVFriend', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVFriend;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_FVFriend
	@gameid_								varchar(60),					-- 게임아이디
	@password_								varchar(20),
	@mode_									int,
	@friendid_								varchar(20),
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
	--declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--블럭유저 > 팝업처리후 인트로로 빼버린다.
	--declare @RESULT_ERROR_DELETED_USER 		int				set @RESULT_ERROR_DELETED_USER			= -12			--삭제유저 > 팝업처리후 인트로로 빼버린다.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함
	--declare @RESULT_ERROR_NOT_FOUND_PASSWORD	int				set @RESULT_ERROR_NOT_FOUND_PASSWORD	= -17
	--declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--서버를 점검하고 있다.
	--declare @RESULT_NEWVERION_CLIENT_DOWNLOAD int				set @RESULT_NEWVERION_CLIENT_DOWNLOAD	= -15			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 링크처리.
	--declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 종료.

	-- 기타오류
	--declare @RESULT_ERROR_RESULT_COPY			int				set @RESULT_ERROR_RESULT_COPY			= -53			-- 결과카피시도
	--declare @RESULT_ERROR_GAMECOST_COPY		int				set @RESULT_ERROR_GAMECOST_COPY			= -54			-- 실버카피시도
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- 지원하지않는모드
	--declare @RESULT_ERROR_HEART_FULL			int				set @RESULT_ERROR_HEART_FULL			= -71			-- 지원하지않는모드
	--declare @RESULT_ERROR_TUTORIAL_ALREADY	int				set @RESULT_ERROR_TUTORIAL_ALREADY		= -73			-- 투토리얼 이미 보상.
	declare @RESULT_ERROR_NOT_FOUND_OTHERID		int				set @RESULT_ERROR_NOT_FOUND_OTHERID		= -83
	--declare @RESULT_ERROR_INVEN_FULL			int				set @RESULT_ERROR_INVEN_FULL			= -101			-- 인벤부족
	--declare @RESULT_ERROR_DAILY_REWARD_ALREADY	int				set @RESULT_ERROR_DAILY_REWARD_ALREADY	= -102			-- 일일보상 이미 보상.
	--declare @RESULT_ERROR_NOT_FOUND_DOGAMIDX	int				set @RESULT_ERROR_NOT_FOUND_DOGAMIDX	= -103			-- 도감번호를 찾을수 없음.
	--declare @RESULT_ERROR_DOGAM_ALREADY_REWARD	int				set @RESULT_ERROR_DOGAM_ALREADY_REWARD	= -104			-- 도감을 이미 지급했음.
	--declare @RESULT_ERROR_DOGAM_LACK			int				set @RESULT_ERROR_DOGAM_LACK			= -105			-- 도감중에 동물번호가 부족함.
	--declare @RESULT_ERROR_MAXCOUNT			int				set @RESULT_ERROR_MAXCOUNT				= -112			-- 맥스카운터.
	declare @RESULT_ERROR_TIME_REMAIN			int				set @RESULT_ERROR_TIME_REMAIN			= -123			-- 아직 시간이 남음.
	declare @RESULT_ERROR_FRIEND_WAIT_MAX		int				set @RESULT_ERROR_FRIEND_WAIT_MAX		= -131			-- 친구 대기 맥스(더이상 친구 신청을 할 수 없습니다.)
	declare @RESULT_ERROR_FRIEND_AGREE_MAX		int				set @RESULT_ERROR_FRIEND_AGREE_MAX		= -132			-- 친구 맥스(더 이상 친구를 맺을 수 없습니다.)
	declare @RESULT_ERROR_ALIVE_USER			int				set @RESULT_ERROR_ALIVE_USER			= -147			-- 현재 활동하는 유저입니다.
	declare @RESULT_ERROR_WAIT_RETURN			int				set @RESULT_ERROR_WAIT_RETURN			= -148			-- 요청 대기중입니다.

	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------
	-- 구매처코드
	declare @MARKET_SKT							int					set @MARKET_SKT						= 1
	--declare @MARKET_KT						int					set @MARKET_KT						= 2
	--declare @MARKET_LGT						int					set @MARKET_LGT						= 3
	declare @MARKET_GOOGLE						int					set @MARKET_GOOGLE					= 5
	declare @MARKET_NHN							int					set @MARKET_NHN						= 6
	declare @MARKET_IPHONE						int					set @MARKET_IPHONE					= 7

	-- 아이템별 인벤분류
	declare @USERITEM_INVENKIND_ANI				int 				set @USERITEM_INVENKIND_ANI					= 1
	--declare @USERITEM_INVENKIND_CONSUME		int 				set @USERITEM_INVENKIND_CONSUME				= 3
	--declare @USERITEM_INVENKIND_ACC			int 				set @USERITEM_INVENKIND_ACC					= 4
	--declare @USERITEM_INVENKIND_DIRECT		int 				set @USERITEM_INVENKIND_DIRECT				= 40
	--declare @USERITEM_INVENKIND_INFO			int 				set @USERITEM_INVENKIND_INFO				= 60
	--declare @USERITEM_INVENKIND_PET			int 				set @USERITEM_INVENKIND_PET					= 1000

	-- 아이템 소분류
	declare @ITEM_SUBCATEGORY_COW				int					set @ITEM_SUBCATEGORY_COW 					= 1  -- 소		(판매[O], 선물[O])
	declare @ITEM_SUBCATEGORY_GOAT				int					set @ITEM_SUBCATEGORY_GOAT 					= 2  -- 양		(판매[O], 선물[O])
	declare @ITEM_SUBCATEGORY_SHEEP				int					set @ITEM_SUBCATEGORY_SHEEP 				= 3  -- 산양	(판매[O], 선물[O])

	-- 친구검색, 추가, 삭제
	declare @USERFRIEND_MODE_SEARCH				int					set	@USERFRIEND_MODE_SEARCH						= 1;
	declare @USERFRIEND_MODE_ADD				int					set	@USERFRIEND_MODE_ADD						= 2;
	declare @USERFRIEND_MODE_DELETE				int					set	@USERFRIEND_MODE_DELETE						= 3;
	declare @USERFRIEND_MODE_MYLIST				int					set	@USERFRIEND_MODE_MYLIST						= 4;
	declare @USERFRIEND_MODE_VISIT				int					set	@USERFRIEND_MODE_VISIT						= 5;
	declare @USERFRIEND_MODE_APPROVE			int					set	@USERFRIEND_MODE_APPROVE					= 6;
	declare @USERFRIEND_MODE_HEARD				int					set	@USERFRIEND_MODE_HEARD						= 7;
	declare @USERFRIEND_MODE_FRIEND_RENT		int					set	@USERFRIEND_MODE_FRIEND_RENT				= 8;
	declare @USERFRIEND_MODE_RETURN_FRIEND		int					set	@USERFRIEND_MODE_RETURN_FRIEND				= 9;

	-- 장기복귀기한.
	declare @RETURN_LIMIT_DAY					int					set @RETURN_LIMIT_DAY							= 30 	-- 몇일간 기한인가?.
	--declare @RETURN_FLAG_OFF					int					set @RETURN_FLAG_OFF							= 0 	-- On(1), Off(0)
	--declare @RETURN_FLAG_ON					int					set @RETURN_FLAG_ON								= 1 	-- On(1), Off(0)

	-- 친구상태값.
	declare @USERFRIEND_STATE_NON				int					set	@USERFRIEND_STATE_NON						=-2;		-- -2: 없음.
	declare @USERFRIEND_STATE_SEARCH			int					set	@USERFRIEND_STATE_SEARCH					=-1;		-- -1: 검색.
	declare @USERFRIEND_STATE_PROPOSE_WAIT		int					set	@USERFRIEND_STATE_PROPOSE_WAIT				= 0;		-- 0 : 친구신청대기
	declare @USERFRIEND_STATE_APPROVE_WAIT		int					set	@USERFRIEND_STATE_APPROVE_WAIT				= 1;		-- 1 : 친구수락대기
	declare @USERFRIEND_STATE_FRIEND			int					set	@USERFRIEND_STATE_FRIEND					= 2;		-- 2 : 상호친구

	declare @USERFRIEND_WAIT_MAX				int					set	@USERFRIEND_WAIT_MAX						= 100;		-- 유저친구허용인원
	declare @USERFRIEND_AGREE_MAX				int					set	@USERFRIEND_AGREE_MAX						= 100;		-- 대기친구.

	declare @KAKAO_FRIEND_KIND_GAME				int					set @KAKAO_FRIEND_KIND_GAME						= 1 		-- 게임친구
	declare @KAKAO_FRIEND_KIND_KAKAO			int					set @KAKAO_FRIEND_KIND_KAKAO					= 2 		-- 카카오친구

	-- 진행중 or 새로하기.
	declare @KAKAO_STATUS_CURRENTING  			int				set @KAKAO_STATUS_CURRENTING			= 1				-- 현재게임 진행상태
	declare @KAKAO_STATUS_NEWSTART  			int				set @KAKAO_STATUS_NEWSTART				= -1			-- 새롭하기한상태
	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @gameid			varchar(60)				set @gameid			= ''
	declare @market			int						set @market			= 0
	declare @version		int						set @version		= 101
	declare @downgrade 		int
	declare @friendid		varchar(60)				set @friendid		= ''
	declare @cnt			int						set @cnt 			= 0
	declare @cnt2			int						set @cnt2 			= 0
	declare @senddate		datetime				set @senddate		= getdate()
	declare @senddate2		datetime				set @senddate2		= getdate() - 1
	declare @rentdate		datetime				set @rentdate		= getdate()
	declare @rentdate2		datetime				set @rentdate2		= getdate() - 1
	declare @subcategory	int
	declare @plusheart		int
	declare @plusfpoint		int
	declare @state			int
	declare @findstate1		int
	declare @findstate2		int

	declare @condate		datetime				set @condate		= getdate()
	declare @rtndate		datetime				set @rtndate		= getdate()

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on

	------------------------------------------------
	-- 3-3. 각 조건별 분기
	------------------------------------------------
	if (@mode_ not in (@USERFRIEND_MODE_MYLIST, @USERFRIEND_MODE_SEARCH, @USERFRIEND_MODE_ADD, @USERFRIEND_MODE_APPROVE, @USERFRIEND_MODE_DELETE, @USERFRIEND_MODE_VISIT, @USERFRIEND_MODE_HEARD, @USERFRIEND_MODE_FRIEND_RENT, @USERFRIEND_MODE_RETURN_FRIEND))
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_SUPPORT_MODE
			select @nResult_ rtn, 'ERROR 지원하지 않는 모드입니다.'
		END
	else if (@mode_ = @USERFRIEND_MODE_SEARCH)
		BEGIN
			------------------------------------------
			-- 유저검색.
			------------------------------------------
			set @nResult_ = @RESULT_SUCCESS
			select @nResult_ rtn, 'SUCCESS 유저검색리스트'

			DECLARE @tTempTable TABLE(
				gameid 			varchar(20),
				anireplistidx	int,
				famelv			int,

				kakaotalkid		varchar(20),
				kakaouserid		varchar(20),
				kakaonickname	varchar(40),
				kakaoprofile	varchar(512),
				kakaomsgblocked	int,
				kakaofriendkind	int,
				helpdate		datetime
			);

			----------------------------------
			-- 랜덤검색, 와일드 검색.
			----------------------------------
			if(isnull(@friendid_, '') = '')
				begin
					-- 1. 빠름
					-- 임시 테이블에 넣어서 > 친구 리스트 생성.
					select @cnt = max(idx) from dbo.tFVUserMaster

					insert into @tTempTable
					select gameid, anireplistidx, famelv, kakaotalkid, kakaouserid, kakaonickname, kakaoprofile, kakaomsgblocked, @KAKAO_FRIEND_KIND_GAME, getdate() from dbo.tFVUserMaster
					where gameid != @gameid_
						and idx in (Convert(int, ceiling(RAND() * @cnt - 0)),
									Convert(int, ceiling(RAND() * @cnt - 1)),
									Convert(int, ceiling(RAND() * @cnt - 2)),
									Convert(int, ceiling(RAND() * @cnt - 3)),
									Convert(int, ceiling(RAND() * @cnt - 4)),
									Convert(int, ceiling(RAND() * @cnt - 5)),
									Convert(int, ceiling(RAND() * @cnt - 6)),
									Convert(int, ceiling(RAND() * @cnt - 7)),
									Convert(int, ceiling(RAND() * @cnt - 8)),
									Convert(int, ceiling(RAND() * @cnt - 9)),
									Convert(int, ceiling(RAND() * @cnt - 10)),
									Convert(int, ceiling(RAND() * @cnt - 11)),
									Convert(int, ceiling(RAND() * @cnt - 12)),
									Convert(int, ceiling(RAND() * @cnt - 13)),
									Convert(int, ceiling(RAND() * @cnt - 14)),
									Convert(int, ceiling(RAND() * @cnt - 15)),
									Convert(int, ceiling(RAND() * @cnt - 16)),
									Convert(int, ceiling(RAND() * @cnt - 17)),
									Convert(int, ceiling(RAND() * @cnt - 18)),
									Convert(int, ceiling(RAND() * @cnt - 19)),
									Convert(int, ceiling(RAND() * @cnt - 20)))
						and gameid not in (select friendid from dbo.tFVUserFriend where gameid = @gameid_)
						and kakaostatus = @KAKAO_STATUS_CURRENTING		-- 현재 게임이 진행중인상태.

				end
			-- 직접검색에 문제가 있음
			-- mogly > mogly가 존재하면 mogly만 나옴, 난 mogly, mogly2를 검색하기를 원함.
			--else if(exists(select top 1 * from dbo.tFVUserMaster where gameid != @gameid_ and gameid = @friendid_))
			--	begin
			--		select top 1 * from dbo.tFVUserMaster where gameid = @friendid_
			--	end
			else
				begin
					-- 2. 뒤 '%' 빠름
					set @friendid_ = @friendid_ + '%'

					insert into @tTempTable
					select top 10 gameid, anireplistidx, famelv, kakaotalkid, kakaouserid, kakaonickname, kakaoprofile, kakaomsgblocked, @KAKAO_FRIEND_KIND_GAME, getdate() from dbo.tFVUserMaster
					where gameid != @gameid_ and gameid like @friendid_
				end


			----------------------------------
			-- 친구 정보에서 동물정보 링크 확인.
			----------------------------------
			select m.gameid friendid, isnull(itemcode, 1) itemcode, isnull(acc1, -1) acc1, isnull(acc2, -1) acc2, '-1' state, '2010-01-01' senddate, famelv, kakaotalkid, kakaouserid, kakaonickname, kakaoprofile, kakaomsgblocked, kakaofriendkind, helpdate from
				@tTempTable as m
			left join
				(select gameid, listidx, itemcode, acc1, acc2 from dbo.tFVUserItem   where gameid in (select gameid from @tTempTable)) as i
			on
				m.gameid = i.gameid and m.anireplistidx = i.listidx
			order by state desc, itemcode desc
		END
	else if (@mode_ = @USERFRIEND_MODE_ADD)
		BEGIN
			------------------------------------------
			-- 친구추가.
			------------------------------------------
			select @gameid 		= gameid from dbo.tFVUserMaster where gameid = @gameid_ and password = @password_
			select @friendid 	= gameid from dbo.tFVUserMaster where gameid = @friendid_
			select @cnt  = isnull(count(*), 0) from dbo.tFVUserFriend where gameid = @gameid_ and state in (@USERFRIEND_STATE_PROPOSE_WAIT, @USERFRIEND_STATE_APPROVE_WAIT)
			select @cnt2 = isnull(count(*), 0) from dbo.tFVUserFriend where gameid = @gameid_ and state in (@USERFRIEND_STATE_FRIEND)
			--select 'DEBUG ', @gameid gameid, @friendid friendid, @cnt cnt, @cnt2 cnt2

			if(@gameid = '')
				begin
					set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
					select @nResult_ rtn, 'ERROR 아이디를 찾을 수 없습니다.'
				end
			else if(@friendid = '' or @gameid_ = @friendid_)
				begin
					set @nResult_ = @RESULT_ERROR_NOT_FOUND_OTHERID
					select @nResult_ rtn, 'ERROR 친구 아이디를 찾을 수 없습니다.'
				end
			else if(@cnt > @USERFRIEND_WAIT_MAX)
				begin
					set @nResult_ = @RESULT_ERROR_FRIEND_WAIT_MAX
					select @nResult_ rtn, 'ERROR 더이상 친구 신청을 할 수 없습니다(2).'
				end
			else if(@cnt2 > @USERFRIEND_AGREE_MAX)
				begin
					set @nResult_ = @RESULT_ERROR_FRIEND_AGREE_MAX
					select @nResult_ rtn, 'ERROR 더 이상 친구를 맺을 수 없습니다(3).'
				end
			else
				begin
					set @nResult_ 	= @RESULT_SUCCESS
					select @nResult_ rtn, 'SUCCESS 유저친구추가'

					------------------------------------------
					-- (신청자) > 친구신청대기...
					------------------------------------------
					set @findstate1 = @USERFRIEND_STATE_NON
					select top 1 @findstate1 = state from dbo.tFVUserFriend where gameid = @gameid_ and friendid = @friendid_

					if(@findstate1 = @USERFRIEND_STATE_NON)
						begin
							--친구추가
							insert into dbo.tFVUserFriend(gameid,   friendid,   state)
							values(                    @gameid_, @friendid_, @USERFRIEND_STATE_PROPOSE_WAIT)
						end
					else if(@findstate1 = @USERFRIEND_STATE_APPROVE_WAIT)
						begin
							--친구추가
							update dbo.tFVUserFriend
								set
									state = @USERFRIEND_STATE_FRIEND
							where gameid = @gameid_ and friendid = @friendid_
						end

					------------------------------------------
					-- (상대방)	> @친구수락대기...
					------------------------------------------
					set @findstate2 = @USERFRIEND_STATE_NON
					select top 1 @findstate2 = state from dbo.tFVUserFriend where gameid = @friendid_ and friendid = @gameid_

					if(@findstate2 = @USERFRIEND_STATE_NON)
						begin
							insert into dbo.tFVUserFriend(  gameid,   friendid,  state)
							values(                    @friendid_, @gameid_,  @USERFRIEND_STATE_APPROVE_WAIT)
						end
					else if(@findstate2 = @USERFRIEND_STATE_PROPOSE_WAIT)
						begin
							--친구추가
							update dbo.tFVUserFriend
								set
									state = @USERFRIEND_STATE_FRIEND
							where gameid = @friendid_ and friendid = @gameid_
						end

					--------------------------------------------------------------
					-- 유저 친구정보
					-- 카피 & 사라지면 대처동물로.(없으면 기초동물로 교체)
					--------------------------------------------------------------
					exec spu_FVsubFriendList @gameid_

				end
		END
	else if (@mode_ = @USERFRIEND_MODE_DELETE)
		BEGIN
			select @gameid 		= gameid from dbo.tFVUserMaster where gameid = @gameid_ and password = @password_

			if(@gameid = '' or @gameid_ = @friendid_)
				begin
					set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
					select @nResult_ rtn, 'ERROR 아이디를 찾을 수 없습니다.'
				end
			else
				begin
					set @nResult_ = @RESULT_SUCCESS
					select @nResult_ rtn, 'SUCCESS 삭제 친구리스트 삭제' + @friendid_

					------------------------------------------
					-- 친구삭제
					------------------------------------------
					delete from dbo.tFVUserFriend where gameid = @gameid_   and friendid = @friendid_
					delete from dbo.tFVUserFriend where gameid = @friendid_ and friendid = @gameid_

					--------------------------------------------------------------
					-- 유저 친구정보
					-- 카피 & 사라지면 대처동물로.(없으면 기초동물로 교체)
					--------------------------------------------------------------
					exec spu_FVsubFriendList @gameid_
				end
		END
	else if (@mode_ = @USERFRIEND_MODE_APPROVE)
		BEGIN
			select @gameid 		= gameid from dbo.tFVUserMaster where gameid = @gameid_ and password = @password_
			select @state = state        from dbo.tFVUserFriend where gameid = @gameid_ and friendid = @friendid_

			if(@gameid = '' or @gameid_ = @friendid_)
				begin
					set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
					select @nResult_ rtn, 'ERROR 아이디를 찾을 수 없습니다.'
				end
			else if(@state not in (@USERFRIEND_STATE_APPROVE_WAIT, @USERFRIEND_STATE_FRIEND))
				begin
					set @nResult_ = @RESULT_ERROR_NOT_SUPPORT_MODE
					select @nResult_ rtn, 'ERROR 신청 받은 사람만이 승인 처리 할 수 있습니다.'
				end
			else
				begin
					set @nResult_ = @RESULT_SUCCESS
					select @nResult_ rtn, 'SUCCESS 친구 수락처리' + @friendid_

					------------------------------------------
					-- 친구승인
					------------------------------------------
					update dbo.tFVUserFriend set state = @USERFRIEND_STATE_FRIEND, senddate = getdate() where gameid = @gameid_   and friendid = @friendid_
					update dbo.tFVUserFriend set state = @USERFRIEND_STATE_FRIEND, senddate = getdate() where gameid = @friendid_ and friendid = @gameid_

					--------------------------------------------------------------
					-- 유저 친구정보
					-- 카피 & 사라지면 대처동물로.(없으면 기초동물로 교체)
					--------------------------------------------------------------
					exec spu_FVsubFriendList @gameid_
				end
		END
	else if (@mode_ = @USERFRIEND_MODE_MYLIST)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			select @nResult_ rtn, 'SUCCESS 유저친구리스트'

			--------------------------------------------------------------
			-- 유저 친구정보
			-- 카피 & 사라지면 대처동물로.(없으면 기초동물로 교체)
			--------------------------------------------------------------
			exec spu_FVsubFriendList @gameid_
		END
	else if (@mode_ = @USERFRIEND_MODE_VISIT)
		BEGIN
			-- 친구의 정보
			select @gameid 		= gameid, @market = market, @version = version from dbo.tFVUserMaster where gameid = @gameid_ and password = @password_
			select @friendid 	= gameid from dbo.tFVUserMaster where gameid = @friendid_

			if(@gameid = '')
				begin
					set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
					select @nResult_ rtn, 'ERROR 아이디를 찾을 수 없습니다.'
				end
			else if(@friendid = '' or @gameid_ = @friendid_)
				begin
					set @nResult_ = @RESULT_ERROR_NOT_FOUND_OTHERID
					select @nResult_ rtn, 'ERROR 친구의 정보를 찾을수 없습니다.'
				end
			else
				begin
					set @nResult_ = @RESULT_SUCCESS
					select @nResult_ rtn, 'SUCCESS 친구의 정보'

					---------------------------------------------
					-- 내친구의친밀도 올리기
					---------------------------------------------
					update dbo.tFVUserFriend
						set
						familiar = familiar + 1
					where gameid = @gameid_ and friendid = @friendid_

					---------------------------------------------
					-- 친구정보(업글정보만).
					-- 버젼이 낮은 것에대한 필터적용 > 현상태로 그대로 둔다
					-- (테스트 서버는 버젼이 맞추기가 힘들어서)
					---------------------------------------------
					set @downgrade = 0
					if(    (@market = @MARKET_SKT    and @version <= 113)
						or (@market = @MARKET_GOOGLE and @version <= 119)
						or (@market = @MARKET_NHN    and @version <= 107)
						or (@market = @MARKET_IPHONE and @version <= 116))
							begin
								set @downgrade = 1
							end

					-- > 버젼이 낮으면 최초의 렙으로 나온다.
					select
						*,
						case when (@downgrade = 1 and housestep    >= 7)  then 7  else housestep 	end housestep2,
						case when (@downgrade = 1 and tankstep     >= 23) then 23 else tankstep 	end tankstep2,
						case when (@downgrade = 1 and bottlestep   >= 23) then 23 else bottlestep 	end bottlestep2,
						case when (@downgrade = 1 and pumpstep     >= 23) then 23 else pumpstep 	end pumpstep2,
						case when (@downgrade = 1 and transferstep >= 23) then 23 else transferstep end transferstep2,
						case when (@downgrade = 1 and purestep     >= 23) then 23 else purestep 	end purestep2,
						case when (@downgrade = 1 and freshcoolstep>= 23) then 23 else freshcoolstep end freshcoolstep2
					from dbo.tFVUserMaster where gameid = @friendid_

					---------------------------------------------
					-- 친구동물정보.
					---------------------------------------------
					select * from dbo.tFVUserItem
					where gameid = @friendid_ and invenkind = @USERITEM_INVENKIND_ANI and (fieldidx >= 0 and fieldidx < 9)

					---------------------------------------------
					-- 친구경작지정보.
					---------------------------------------------
					select * from dbo.tFVUserSeed
					where gameid = @friendid_
					order by seedidx asc

				end
		END
	else if (@mode_ = @USERFRIEND_MODE_HEARD)
		BEGIN
			-- 친구의 정보
			select @gameid 		= gameid, @market = market from dbo.tFVUserMaster where gameid = @gameid_ and password = @password_
			select @friendid 	= gameid from dbo.tFVUserMaster where gameid = @friendid_
			select @state 		= state,
				   @senddate 	= senddate from dbo.tFVUserFriend where gameid = @gameid_ and friendid = @friendid_
			--select 'DEBUG ', @gameid gameid, @friendid friendid, @state state, @senddate senddate

			if(@gameid = '')
				begin
					set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
					select @nResult_ rtn, 'ERROR 아이디를 찾을 수 없습니다.'
				end
			else if(@friendid = '' or @gameid_ = @friendid_)
				begin
					set @nResult_ = @RESULT_ERROR_NOT_FOUND_OTHERID
					select @nResult_ rtn, 'ERROR 친구의 정보를 찾을수 없습니다.'
				end
			else if(@state != @USERFRIEND_STATE_FRIEND)
				begin
					set @nResult_ = @RESULT_ERROR_NOT_SUPPORT_MODE
					select @nResult_ rtn, 'ERROR 상호친구가 아닙니다.'
				end
			else if(@senddate > @senddate2)
				begin
					set @nResult_ = @RESULT_ERROR_TIME_REMAIN
					select @nResult_ rtn, 'ERROR 하트 선물 시간이 남았습니다.'
				end
			else
				begin
					set @nResult_ = @RESULT_SUCCESS
					select @nResult_ rtn, 'SUCCESS 친구에게 하트 선물하기'

					-------------------------------------
					-- 일 카카오 하트(O)
					-------------------------------------
					exec spu_FVDayLogInfoStatic @market, 16, 1

					---------------------------------------------
					-- 친구동물 정보 알아오기.
					---------------------------------------------
					set 	@subcategory	= @ITEM_SUBCATEGORY_COW
					select 	@subcategory 	= subcategory from dbo.tFVItemInfo
					where itemcode = (select top 1 itemcode from dbo.tFVUserItem
									  where gameid = @friendid_ and invenkind = @USERITEM_INVENKIND_ANI
											  and listidx = (select top 1 anireplistidx from dbo.tFVUserMaster where gameid = @friendid_))

					---------------------------------------------
					-- 친구동물 	> 친구	 	> 하트전송(3,4,6)
					-- 친구동물 	> 나 		> 우정포인트(3,4,6)
					-- 변경		 	> 나 		> 우정포인트(2,3,3)
					---------------------------------------------
					set @plusheart = case
										when @subcategory = @ITEM_SUBCATEGORY_SHEEP then 5
										when @subcategory = @ITEM_SUBCATEGORY_GOAT	then 4
										else 											 3
									end
					set @plusfpoint = @plusheart


					update dbo.tFVUserMaster
						set
							heart = case
										when (heart 			) > heartmax then heart
										when (heart + @plusheart) > heartmax then heartmax
										else (heart + @plusheart)
									end,
							heartget = heartget + case
														when (heart 			) > heartmax then 0
														when (heart + @plusheart) > heartmax then (heartmax - heart)
														else                                      @plusheart
													end
					where gameid = @friendid_

					update dbo.tFVUserMaster
						set
							fpoint =  case
										when (fpoint 		 	  ) > fpointmax then fpoint
										when (fpoint + @plusfpoint) > fpointmax then fpointmax
										else (fpoint + @plusfpoint)
									end
					where gameid = @gameid_


					---------------------------------------------
					--	나		> 포인트지급날자갱신
					-- 하트 지급 시간 단축 (클라 24시간을 기준으로 세팅)
					-- 1 : 24H = 0.25 : 6H
					-- t - 24 > (t2 - (1 - 0.25) - 24
					---------------------------------------------
					update dbo.tFVUserFriend
						set
							senddate = (getdate() - (1 - 0.25))
					where gameid = @gameid_ and friendid = @friendid_


					---------------------------------------------
					--	유저정보.
					---------------------------------------------
					select * from dbo.tFVUserMaster where gameid = @gameid_


					--------------------------------------------------------------
					-- 유저 친구정보
					-- 카피 & 사라지면 대처동물로.(없으면 기초동물로 교체)
					--------------------------------------------------------------
					exec spu_FVsubFriendList @gameid_
				end
		END
	else if (@mode_ = @USERFRIEND_MODE_FRIEND_RENT)
		BEGIN
			-- 친구의 정보
			select @gameid 		= gameid from dbo.tFVUserMaster where gameid = @gameid_ and password = @password_
			select @friendid 	= gameid from dbo.tFVUserMaster where gameid = @friendid_
			select @state 		= state,
				   @rentdate 	= rentdate from dbo.tFVUserFriend where gameid = @gameid_ and friendid = @friendid_
			--select 'DEBUG ', @gameid gameid, @friendid friendid, @state state, @senddate senddate

			if(@gameid = '')
				begin
					set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
					select @nResult_ rtn, 'ERROR 아이디를 찾을 수 없습니다.'
				end
			else if(@friendid = '' or @gameid_ = @friendid_)
				begin
					set @nResult_ = @RESULT_ERROR_NOT_FOUND_OTHERID
					select @nResult_ rtn, 'ERROR 친구의 정보를 찾을수 없습니다.'
				end
			else if(@state != @USERFRIEND_STATE_FRIEND)
				begin
					set @nResult_ = @RESULT_ERROR_NOT_SUPPORT_MODE
					select @nResult_ rtn, 'ERROR 상호친구가 아닙니다.'
				end
			else if(@rentdate > @rentdate2)
				begin
					set @nResult_ = @RESULT_ERROR_TIME_REMAIN
					select @nResult_ rtn, 'ERROR 동물빌리기 남았습니다.'
				end
			else
				begin
					set @nResult_ = @RESULT_SUCCESS
					select @nResult_ rtn, 'SUCCESS 친구에게 동물빌리기'

					---------------------------------------------
					-- 친구에게 동물빌리기
					---------------------------------------------
					update dbo.tFVUserFriend
						set
							rentdate = getdate()
					where gameid = @gameid_ and friendid = @friendid_

					---------------------------------------------
					--	유저정보.
					---------------------------------------------
					select * from dbo.tFVUserMaster where gameid = @gameid_

					--------------------------------------------------------------
					-- 유저 친구정보
					-- 카피 & 사라지면 대처동물로.(없으면 기초동물로 교체)
					--------------------------------------------------------------
					exec spu_FVsubFriendList @gameid_
				end
		END
	else if (@mode_ = @USERFRIEND_MODE_RETURN_FRIEND)
		BEGIN
			-- 친구의 정보
			select @gameid 		= gameid, @market = market from dbo.tFVUserMaster where gameid = @gameid_ and password = @password_
			select @friendid 	= gameid, @condate = condate, @rtndate = rtndate from dbo.tFVUserMaster where gameid = @friendid_
			select @state 		= state from dbo.tFVUserFriend where gameid = @gameid_ and friendid = @friendid_
			--select 'DEBUG 복귀', @gameid gameid, @friendid friendid, @state state

			if(@gameid = '')
				begin
					set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
					select @nResult_ rtn, 'ERROR 아이디를 찾을 수 없습니다.'
				end
			else if(@friendid = '' or @gameid_ = @friendid_)
				begin
					set @nResult_ = @RESULT_ERROR_NOT_FOUND_OTHERID
					select @nResult_ rtn, 'ERROR 친구의 정보를 찾을수 없습니다.'
				end
			else if(@state != @USERFRIEND_STATE_FRIEND)
				begin
					set @nResult_ = @RESULT_ERROR_NOT_SUPPORT_MODE
					select @nResult_ rtn, 'ERROR 상호친구가 아닙니다.'
				end
			else if(@condate > (getdate() - @RETURN_LIMIT_DAY))
				begin
					set @nResult_ = @RESULT_ERROR_ALIVE_USER
					select @nResult_ rtn, 'ERROR 현재 활동하는 유저입니다.'
				end
			else if(@rtndate >= (getdate() - 1))
				begin
					set @nResult_ = @RESULT_ERROR_WAIT_RETURN
					select @nResult_ rtn, 'ERROR 요청 대기중입니다.'
				end
			else
				begin
					set @nResult_ = @RESULT_SUCCESS
					select @nResult_ rtn, 'SUCCESS 친구에게 복귀 요청하기'

					-------------------------------------
					-- 복귀 요청수.
					-------------------------------------
					exec spu_FVDayLogInfoStatic @market, 27, 1

					-------------------------------------
					-- 복귀유저 > 요청친구과 날자 갱신
					-------------------------------------
					update dbo.tFVUserMaster
						set
							rtngameid 	= @gameid_,
							rtndate 	= getdate()
					where gameid = @friendid_

					set @plusfpoint = 1
					update dbo.tFVUserMaster
						set
							fpoint =  case
										when (fpoint 		 	  ) > fpointmax then fpoint
										when (fpoint + @plusfpoint) > fpointmax then fpointmax
										else (fpoint + @plusfpoint)
									end
					where gameid = @gameid_

					---------------------------------------------
					--	유저정보.
					---------------------------------------------
					select * from dbo.tFVUserMaster where gameid = @gameid_

					--------------------------------------------------------------
					-- 유저 친구정보
					-- 카피 & 사라지면 대처동물로.(없으면 기초동물로 교체)
					--------------------------------------------------------------
					exec spu_FVsubFriendList @gameid_
				end
		END
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

