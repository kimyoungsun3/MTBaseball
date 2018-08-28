/*
-- 2013.3 ~ 2013.10(7개월까지 무료부활)
-- 죽음세팅
exec spu_AniDie 'xxxx2', '049000s1i0n7t8445289', 1, 1, -1
exec spu_AniDie 'xxxx2', '049000s1i0n7t8445289', 2, 3, -1
exec spu_AniDie 'xxxx2', '049000s1i0n7t8445289', 3, 4, -1
exec spu_AniDie 'xxxx2', '049000s1i0n7t8445289', 4, 6, -1

-- 무료부활(2013).
exec spu_AniRevival 'xxxx2', '049000s1i0n7t8445289', 1, 1, 1, -1		-- 2013년 무료부활
exec spu_AniRevival 'xxxx2', '049000s1i0n7t8445289', 1, 2, 2, -1		-- 2013년 무료부활
exec spu_AniRevival 'xxxx2', '049000s1i0n7t8445289', 2, 3, 3, -1		-- 2013년 무료부활

-- 부활석x1 or 캐쉬+1
exec spu_AniRevival 'xxxx2', '049000s1i0n7t8445289', 1, 1, 1, -1		-- 필드부활 > 필드로 넣기.
exec spu_AniRevival 'xxxx2', '049000s1i0n7t8445289', 1, 3, 2, -1		--
exec spu_AniRevival 'xxxx2', '049000s1i0n7t8445289', 1, 4, 4, -1		-- (클라죽음 - 서버살음) 싱크 안맞음 > 클라기준으로 살려줌.
exec spu_AniRevival 'xxxx2', '049000s1i0n7t8445289', 1, 3, -1, -1		-- 필드부활 > 필드로 넣기.

-- 부활석x2 or (캐쉬+1)*2
exec spu_AniRevival 'xxxx2', '049000s1i0n7t8445289', 2, 19, -1, -1		-- 병원부활 > 인벤으로 넣기.
exec spu_AniRevival 'xxxx2', '049000s1i0n7t8445289', 2, 6, -1, -1		--

-- 삭제하기
exec spu_AniRevival 'xxxx', '049000s1i0n7t8445289', 3, 5, -1, -1		-- 병원부활 > 삭제하기.
*/
use Game4Farmvill5
GO

IF OBJECT_ID ( 'dbo.spu_AniRevival', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_AniRevival;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_AniRevival
	@gameid_								varchar(20),
	@password_								varchar(20),
	@mode_									int,
	@listidx_								int,
	@fieldidx_								int,
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
	declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--블럭유저 > 팝업처리후 인트로로 빼버린다.
	declare @RESULT_ERROR_DELETED_USER 			int				set @RESULT_ERROR_DELETED_USER			= -12			--삭제유저 > 팝업처리후 인트로로 빼버린다.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함.
	declare @RESULT_ERROR_NOT_FOUND_PASSWORD	int				set @RESULT_ERROR_NOT_FOUND_PASSWORD	= -17
	declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--서버를 점검하고 있다.
	declare @RESULT_NEWVERION_CLIENT_DOWNLOAD 	int				set @RESULT_NEWVERION_CLIENT_DOWNLOAD	= -15			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 링크처리.
	declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 종료.

	-- 게임중에 부족.
	declare @RESULT_ERROR_HEART_LACK			int				set @RESULT_ERROR_HEART_LACK			= -20			--하트이 부족하다.
	declare @RESULT_ERROR_GAMECOST_LACK			int				set @RESULT_ERROR_GAMECOST_LACK			= -21			--실버가 부족하다.
	declare @RESULT_ERROR_CASHCOST_LACK			int				set @RESULT_ERROR_CASHCOST_LACK			= -22			--골드가 부족하다.
	declare @RESULT_ERROR_ITEM_LACK				int				set @RESULT_ERROR_ITEM_LACK				= -23			--아이템이부족하다.

	-- 기타오류
	declare @RESULT_ERROR_RESULT_COPY			int				set @RESULT_ERROR_RESULT_COPY			= -53			-- 결과카피시도
	declare @RESULT_ERROR_GAMECOST_COPY			int				set @RESULT_ERROR_GAMECOST_COPY			= -54			-- 실버카피시도
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- 지원하지않는모드
	declare @RESULT_ERROR_HEART_FULL			int				set @RESULT_ERROR_HEART_FULL			= -71			-- 지원하지않는모드
	declare @RESULT_ERROR_TUTORIAL_ALREADY		int				set @RESULT_ERROR_TUTORIAL_ALREADY		= -73			-- 투토리얼 이미 보상.
	declare @RESULT_ERROR_NOT_FOUND_OTHERID		int				set @RESULT_ERROR_NOT_FOUND_OTHERID		= -83
	declare @RESULT_ERROR_INVEN_FULL			int				set @RESULT_ERROR_INVEN_FULL			= -101			-- 인벤부족
	declare @RESULT_ERROR_DAILY_REWARD_ALREADY	int				set @RESULT_ERROR_DAILY_REWARD_ALREADY	= -102			-- 일일보상 이미 보상.
	declare @RESULT_ERROR_NOT_FOUND_DOGAMIDX	int				set @RESULT_ERROR_NOT_FOUND_DOGAMIDX	= -103			-- 도감번호를 찾을수 없음.
	declare @RESULT_ERROR_DOGAM_ALREADY_REWARD	int				set @RESULT_ERROR_DOGAM_ALREADY_REWARD	= -104			-- 도감을 이미 지급했음.
	declare @RESULT_ERROR_DOGAM_LACK			int				set @RESULT_ERROR_DOGAM_LACK			= -105			-- 도감중에 동물번호가 부족함.
	declare @RESULT_ERROR_ANIMAL_NOT_FOUND		int				set @RESULT_ERROR_ANIMAL_NOT_FOUND		= -106			-- 대표동물 못찾음
	declare @RESULT_ERROR_ANIMAL_NOT_INVEN		int				set @RESULT_ERROR_ANIMAL_NOT_INVEN		= -107			-- 인벤에 없음(창고)
	declare @RESULT_ERROR_ANIMAL_NOT_ALIVE		int				set @RESULT_ERROR_ANIMAL_NOT_ALIVE		= -108			-- 살아 있지 않음
	declare @RESULT_ERROR_ANIMAL_IS_ALIVE		int				set @RESULT_ERROR_ANIMAL_IS_ALIVE		= -116			-- 동물이 살아있다.
	declare @RESULT_ERROR_ANIMAL_FIELDIDX		int				set @RESULT_ERROR_ANIMAL_FIELDIDX		= -117			-- 필드인덱스오류.
	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------
	-- 아이템별 인벤분류
	declare @USERITEM_INVENKIND_ANI				int 				set @USERITEM_INVENKIND_ANI					= 1
	--declare @USERITEM_INVENKIND_CONSUME		int 				set @USERITEM_INVENKIND_CONSUME				= 3
	--declare @USERITEM_INVENKIND_ACC			int 				set @USERITEM_INVENKIND_ACC					= 4
	--declare @USERITEM_INVENKIND_DIRECT		int 				set @USERITEM_INVENKIND_DIRECT				= 40
	--declare @USERITEM_INVENKIND_INFO			int 				set @USERITEM_INVENKIND_INFO				= 60
	--declare @USERITEM_INVENKIND_PET			int 				set @USERITEM_INVENKIND_PET					= 1000

	-- 죽은 or 부활모드.
	declare @USERITEM_MODE_DIE_INIT				int					set @USERITEM_MODE_DIE_INIT					= -1-- 초기상태.
	declare @USERITEM_MODE_DIE_PRESS			int					set @USERITEM_MODE_DIE_PRESS				= 1	-- 눌러 죽음.
	declare @USERITEM_MODE_DIE_EAT_WOLF			int					set @USERITEM_MODE_DIE_EAT_WOLF				= 2	-- 늑대 죽음.
	declare @USERITEM_MODE_DIE_EXPLOSE			int					set @USERITEM_MODE_DIE_EXPLOSE				= 3	-- 터져 죽음.
	declare @USERITEM_MODE_DIE_DISEASE			int					set @USERITEM_MODE_DIE_DISEASE				= 4	-- 질병 죽음.

	declare @USERITEM_MODE_REVIVAL_FIELD		int					set @USERITEM_MODE_REVIVAL_FIELD			= 1	-- 필드부활.
	declare @USERITEM_MODE_REVIVAL_HOSPITAL		int					set @USERITEM_MODE_REVIVAL_HOSPITAL			= 2	-- 병원부활.
	declare @USERITEM_MODE_REVIVAL_DELETE		int					set @USERITEM_MODE_REVIVAL_DELETE			= 3	-- 병원삭제.

	-- 동물정보.
	declare @USERITEM_FIELDIDX_INVEN			int					set @USERITEM_FIELDIDX_INVEN					= -1	-- 창고.
	declare @USERITEM_FIELDIDX_HOSPITAL			int					set @USERITEM_FIELDIDX_HOSPITAL					= -2	-- 병원.
	declare @USERITEM_INIT_ANISTEP				int					set @USERITEM_INIT_ANISTEP						= 5		-- 단계.
	declare @USERITEM_INIT_MANGER				int					set @USERITEM_INIT_MANGER						= 25	-- 여물통.
	declare @USERITEM_INIT_DISEASESTATE			int					set @USERITEM_INIT_DISEASESTATE					= 0		-- 질병상태.

	-- 부활템 코드번호.
	declare @REVIVAL_ITEMCODE					int					set @REVIVAL_ITEMCODE							= 1200

	-- >= 0 이상이면 특정 식물이 심어져있음.
	declare @GAME_START_YEAR					int					set @GAME_START_YEAR						= 2013	-- 게임 기본정보.

	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @comment			varchar(80)

	declare @gameid 			varchar(20)		set @gameid 		= ''
	declare @market				int
	declare @cashcost			int				set @cashcost		= 0
	declare @gamecost			int				set @gamecost		= 0

	declare @aniinvenkind		int				set	@aniinvenkind	= -444
	declare @anifieldidx		int				set @anifieldidx	= -444
	declare @anilistidx2		int				set @anilistidx2	= -444

	declare @revlistidx			int				set @revlistidx		= -444
	declare @revcnt				int				set @revcnt			= 0
	declare @revcntneed			int				set @revcntneed		= 99

	declare @revcashcost		int				set @revcashcost	= 6
	declare @revcashcostneed	int				set @revcashcostneed= 99

	declare @gameyear			int				set @gameyear		= 9999
	declare @gamemonth			int				set @gamemonth		= 12

	declare @anireplistidx		int				set @anireplistidx	= 1
	declare @anirepitemcode		int				set @anirepitemcode	= 1
	declare @anirepacc1			int				set @anirepacc1		= -1
	declare @anirepacc2			int				set @anirepacc2		= -1

	declare @aniitemcode		int				set @aniitemcode	= 1
	declare @anineedrevcnt		int				set @anineedrevcnt	= 99

	-- 살리는 정보 백어.
	declare @alivecheck			int				set @alivecheck		= 0
	declare @alivecash			int				set @alivecash		= 0
	declare @alivedoll			int				set @alivedoll		= 0
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG 입력값', @gameid_ gameid_, @password_ password_, @mode_ mode_, @listidx_ listidx_, @fieldidx_ fieldidx_

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	-- 유저 보유캐쉬
	select
		@gameid 		= gameid,			@market			= market,
		@cashcost		= cashcost,			@gamecost		= gamecost,
		@gameyear		= gameyear,			@gamemonth		= gamemonth,
		@anireplistidx	= anireplistidx,
		@anirepitemcode	= anirepitemcode,	@anirepacc1	= anirepacc1,	@anirepacc2		= anirepacc2
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 유저정보', @gameid gameid, @cashcost cashcost, @gamecost gamecost

	-- 유저 가축정보.
	select
		@aniitemcode	= itemcode,
		@aniinvenkind	= invenkind,
		@anifieldidx	= fieldidx,
		@anirepitemcode	= case when (@anireplistidx = @listidx_) 	then itemcode 	else @anirepitemcode end,
		@anirepacc1		= case when (@anireplistidx = @listidx_) 	then acc1 		else @anirepacc1 end,
		@anirepacc2		= case when (@anireplistidx = @listidx_) 	then acc2 		else @anirepacc2 end
	from dbo.tUserItem
	where gameid = @gameid_ and listidx = @listidx_
	--select 'DEBUG 유저 가축정보', @aniinvenkind aniinvenkind, @anifieldidx anifieldidx


	if(@fieldidx_ != -1)
		begin
			-- 유저 가축정보2.
			select
				@anilistidx2	= listidx
			from dbo.tUserItem
			where gameid = @gameid_ and fieldidx = @fieldidx_
			--select 'DEBUG 유저 가축정보2', @fieldidx_ fieldidx_, @anilistidx2 anilistidx2
		end

	-- 유저 보유 부활템.
	select
		@revlistidx		= listidx,
		@revcnt 		= cnt
	from dbo.tUserItem
	where gameid = @gameid_ and itemcode = @REVIVAL_ITEMCODE
	--select 'DEBUG 유저 보유 부활템', @revlistidx revlistidx, @revcnt revcnt

	select
		@revcashcost = cashcost
	from dbo.tItemInfo
	where itemcode = @REVIVAL_ITEMCODE
	--select 'DEBUG 부활템 캐쉬가격(원가)', @revcashcost revcashcost

	-- 동물 아이템 테이블 > 필요부활석
	select
		@anineedrevcnt = param13
	from dbo.tItemInfo
	where itemcode = @aniitemcode

	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '아이디가 존재하지 않는다.'
			--select 'DEBUG ' + @comment
		END
	else if (@mode_ not in (@USERITEM_MODE_REVIVAL_FIELD, @USERITEM_MODE_REVIVAL_HOSPITAL, @USERITEM_MODE_REVIVAL_DELETE))
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment 	= 'ERROR 지원하지 않는 모드입니다.'
			--select 'DEBUG ' + @comment
		END
	else if(@aniinvenkind != @USERITEM_INVENKIND_ANI)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_ANIMAL_NOT_FOUND
			set @comment 	= '동물이 존재하지 않는다.'
			--select 'DEBUG ' + @comment
		END
	-- 동물 -> 죽음(전송) -> 싱크맞음
	-- 동물 -> 죽음(네단) -> 싱크틀림 -> 클라기준으로 살려줌.
	--else if(@anifieldidx != @USERITEM_FIELDIDX_HOSPITAL)
	--	BEGIN
	--		set @nResult_ 	= @RESULT_ERROR_ANIMAL_IS_ALIVE
	--		set @comment 	= '동물이 살아있다.'
	--	END
	else if(@fieldidx_ < @USERITEM_FIELDIDX_INVEN  or @fieldidx_ >= 9)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_ANIMAL_FIELDIDX
			set @comment 	= '입력된 필드 인덱스 오류(-1, 0 ~ 8).'
			--select 'DEBUG ' + @comment
		END
	else if(@anilistidx2 != @listidx_ and @fieldidx_ != @USERITEM_FIELDIDX_INVEN and exists(select top 1 * from dbo.tUserItem where gameid = @gameid_ and fieldidx = @fieldidx_))
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_ANIMAL_IS_ALIVE
			set @comment 	= '해당 필드에 다른 동물이 있다.'
			--select 'DEBUG ' + @comment
		END

	else if(@mode_ = @USERITEM_MODE_REVIVAL_DELETE)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '해당 동물을 삭제했습니다.'
			--select 'DEBUG ' + @comment
			if(exists(select top 1 * from dbo.tUserItem where gameid = @gameid_ and listidx = @listidx_))
				begin
					exec spu_DeleteUserItemBackup 0, @gameid_, @listidx_
				end
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 정상 부활 합니다.'
			--select 'DEBUG ' + @comment

			if(@gameyear = @GAME_START_YEAR)
				begin
					--select 'DEBUG 무료 부활 > 배'
					set @revcntneed 		= 0
				end
			else if(@mode_ = @USERITEM_MODE_REVIVAL_FIELD)
				begin
					--select 'DEBUG 필드 부활 > 1배'
					set @revcntneed 		= 1
				end
			else if(@mode_ = @USERITEM_MODE_REVIVAL_HOSPITAL)
				begin
					--select 'DEBUG 병원부활 > n개필요'
					set @revcntneed 		= @anineedrevcnt
				end
			else
				begin
					--select 'DEBUG 모르는 부활 > 99배'
					set @revcntneed 		= 99
				end
			set @revcashcostneed	= @revcashcost * @revcntneed
			set @alivecheck 	= 0

			-------------------------------------------------------------------------------
			if(@revcntneed = 0)
				begin
					----------------------------------
					--	무료부활.
					----------------------------------

					-----------------------------------
					-- 유저 정보 수집.
					-----------------------------------
					exec spu_DayLogInfoStatic @market, 25, @revcntneed				-- 무료부활.

					-----------------------------------
					-- > 유저, 가축부활 하단에서 세팅
					-----------------------------------
				end
			else if(@revcnt >= @revcntneed)
				begin
					----------------------------------
					--	부활템 부활.
					----------------------------------
					set @alivecheck 	= 1
					set @alivecash 		= 0
					set @alivedoll 		= @revcntneed
					set @revcnt 		= @revcnt - @revcntneed
					--select 'DEBUG > 부활석(0), 캐쉬(x) > 부활(0)', @revcnt revcnt

					update dbo.tUserItem
						set
							cnt = @revcnt
					where gameid = @gameid_ and itemcode = @REVIVAL_ITEMCODE

					-----------------------------------
					-- 유저 정보 수집.
					-----------------------------------
					exec spu_DayLogInfoStatic @market, 23, @revcntneed				-- 일 부활수(템)

					-----------------------------------
					-- > 유저, 가축부활 하단에서 세팅
					-----------------------------------
				end
			else if(@revcnt > 0 and @revcnt < @revcntneed and @cashcost >= (@revcntneed - @revcnt) * @revcashcost)
				begin
					----------------------------------
					--	부활템 부활 & 캐쉬
					----------------------------------
					set @alivecheck 	= 1
					set @alivecash 		= (@revcntneed - @revcnt) * @revcashcost
					set @alivedoll 		= @revcnt
					--select 'DEBUG 부활(전)> 부활석(0), 캐쉬(0) > 부활(0)', @revcnt revcnt, @revcntneed revcntneed, @cashcost cashcost, @revcashcost revcashcost, @cashcost cashcost
					set @cashcost 	= @cashcost - (@revcntneed - @revcnt) * @revcashcost
					set @revcnt 	= 0
					--select 'DEBUG 부활(후)> 부활석(0), 캐쉬(0) > 부활(0)', @revcnt revcnt, @revcntneed revcntneed, @cashcost cashcost, @revcashcost revcashcost, @cashcost cashcost

					update dbo.tUserItem
						set
							cnt = @revcnt
					where gameid = @gameid_ and itemcode = @REVIVAL_ITEMCODE

					-----------------------------------
					-- 유저 정보 수집.
					-----------------------------------
					exec spu_DayLogInfoStatic @market, 23, @revcntneed				-- 일 부활수(템)

					-----------------------------------
					-- > 유저, 가축부활 하단에서 세팅
					-----------------------------------
				end
			else if(@cashcost >= @revcashcostneed)
				begin
					----------------------------------
					--	캐쉬 부활.
					----------------------------------
					set @alivecheck 	= 1
					set @alivecash 		= @revcashcostneed
					set @alivedoll 		= 0
					set @cashcost = @cashcost - @revcashcostneed
					--select 'DEBUG > 부활석(x), 캐쉬(0) > 부활(0)', @cashcost cashcost

					-----------------------------------
					-- 유저 정보 수집.
					-----------------------------------
					exec spu_DayLogInfoStatic @market, 24, @revcashcostneed			-- 일 부활수(캐쉬)

					-----------------------------------
					-- > 유저, 가축부활 하단에서 세팅
					-----------------------------------

					-----------------------------------
					-- 구매기록마킹
					-----------------------------------
					exec spu_UserItemBuyLogNew @gameid_, @REVIVAL_ITEMCODE, 0, @revcashcostneed, 0
				end
			else
				begin
					set @nResult_ = @RESULT_ERROR_CASHCOST_LACK
					set @comment = 'ERROR 부활석 or 캐쉬가 부족합니다.'
					--select 'DEBUG > 부활석(x), 캐쉬(x) > 부활못함(x)'
				end


			-----------------------------------------
			-- 살리기전에 정보백업
			-----------------------------------------
			if(@nResult_ = @RESULT_SUCCESS and @alivecheck = 1)
				begin
					-- 복구했다는 로고만 기록한다.
					exec spu_AnimalLogBackup @gameid_, 2, @listidx_, @alivecash, @alivedoll	-- 부활로고.
				end

		END



	--------------------------------------------------------------
	-- 코드(캐쉬, 코인, 하트, 건초)
	--------------------------------------------------------------
	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost

	if(@nResult_ = @RESULT_SUCCESS)
		begin
			-----------------------------------
			-- 유저 정보 반영.
			-----------------------------------
			update dbo.tUserMaster
			set
				cashcost		= @cashcost,		gamecost		= @gamecost,
				anirepitemcode	= @anirepitemcode,	anirepacc1		= @anirepacc1,	anirepacc2		= @anirepacc2
			where gameid = @gameid_

			-----------------------------------
			-- 가축 정보 반영.
			-----------------------------------
			update dbo.tUserItem
				set
					fieldidx 	= @fieldidx_,
					anistep		= @USERITEM_INIT_ANISTEP,
					manger		= @USERITEM_INIT_MANGER,
					diseasestate= @USERITEM_INIT_DISEASESTATE,
					diemode		= @USERITEM_MODE_DIE_INIT,
					diedate		= null,
					needhelpcnt	= 0
			where gameid = @gameid_ and listidx = @listidx_

			--------------------------------------------------------------
			-- 유저 보유 아이템 정보(동물)
			--------------------------------------------------------------
			select * from dbo.tUserItem
			where gameid = @gameid_ and listidx = @listidx_

			--------------------------------------------------------------
			-- 유저 보유 아이템 정보(부활템)
			--------------------------------------------------------------
			select * from dbo.tUserItem
			where gameid = @gameid_ and listidx = @revlistidx
		end

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
End



