/*
exec spu_AniDie 'xxxx2', '049000s1i0n7t8445289', 1, 18, -1		-- 눌러죽음.
exec spu_AniDie 'xxxx2', '049000s1i0n7t8445289', 2, 13, -1		-- 늑대에 죽음.

exec spu_AniDie 'xxxx2', '049000s1i0n7t8445289', 1, 1, -1		-- 눌러죽음.
exec spu_AniDie 'xxxx2', '049000s1i0n7t8445289', 2, 2, -1		-- 늑대에 죽음.

exec spu_AniDie 'xxxx2', '049000s1i0n7t8445289', 1, 18, -1		-- 눌러죽음.
exec spu_AniDie 'xxxx2', '049000s1i0n7t8445289', 1, 19, -1		-- 눌러죽음.
exec spu_AniDie 'xxxx2', '049000s1i0n7t8445289', 1, 20, -1		-- 눌러죽음.
exec spu_AniDie 'xxxx2', '049000s1i0n7t8445289', 1, 21, -1		-- 눌러죽음.
exec spu_AniDie 'xxxx2', '049000s1i0n7t8445289', 1, 22, -1		-- 눌러죽음.

*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_AniDie', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_AniDie;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_AniDie
	@gameid_								varchar(20),
	@password_								varchar(20),
	@mode_									int,
	@listidx_								int,
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

	-- 기타오류
	declare @RESULT_ERROR_RESULT_COPY			int				set @RESULT_ERROR_RESULT_COPY			= -53			-- 결과카피시도
	declare @RESULT_ERROR_GAMECOST_COPY			int				set @RESULT_ERROR_GAMECOST_COPY			= -54			-- 실버카피시도
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- 지원하지않는모드
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

	-- 기타 상수값
	declare @ID_MAX								int					set	@ID_MAX									= 9999	-- 한폰당 생성할 수 있는 아이디개수.
	declare @USERMASTER_UPGRADE_STATE_NON		int					set @USERMASTER_UPGRADE_STATE_NON			= -1	--미진행, 완료중.(유저)
	declare @USERMASTER_UPGRADE_STATE_ING		int					set @USERMASTER_UPGRADE_STATE_ING			= 1		--다음단계진행중.
	declare @USERSEED_NEED_EMPTY				int					set @USERSEED_NEED_EMPTY					= -1	-- (경작지)
	declare @USERSEED_NEED_BUY					int					set @USERSEED_NEED_BUY						= -2
	-- >= 0 이상이면 특정 식물이 심어져있음.
	declare @GAME_INVEN_HOSPITAL_BASE			int					set @GAME_INVEN_HOSPITAL_BASE				= 10+9 -- 동물병원(병원10 + 필드9).

	-- 동물정보.
	-- 필드동물 0 ~ 8.
	declare @USERITEM_FIELDIDX_INVEN			int					set @USERITEM_FIELDIDX_INVEN					= -1	-- 창고.
	declare @USERITEM_FIELDIDX_HOSPITAL			int					set @USERITEM_FIELDIDX_HOSPITAL					= -2	-- 병원.
	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @comment			varchar(80)
	declare @gameid 			varchar(20)		set @gameid			= ''
	declare @anireplistidx		int				set @anireplistidx	= -1

	declare @loop				int
	declare @fieldidx			int				set @fieldidx		= -444
	declare @listidx			int				set @listidx		= -1
	declare @itemcode			int				set @itemcode		= -1
	declare @needhelpcnt		int				set @needhelpcnt	= 99999
	declare @gameyear			int				set @gameyear		= 2013
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	set @comment = '모르는 오류(-1).'
	--select 'DEBUG 입력값', @gameid_ gameid_, @password_ password_, @mode_ mode_, @listidx_ listidx_

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	select
		@gameid 		= gameid,
		@gameyear		= gameyear,
		@anireplistidx 	= anireplistidx
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 유저정보', @gameid gameid

	select
		@fieldidx 	= fieldidx,
		@itemcode 	= itemcode
	from dbo.tUserItem
	where gameid = @gameid_ and listidx = @listidx_ and invenkind in (@USERITEM_INVENKIND_ANI)


	if( @gameid = '' )
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '아이디가 존재하지 않는다.'
		END
	else if(@mode_ not in (@USERITEM_MODE_DIE_PRESS, @USERITEM_MODE_DIE_EAT_WOLF, @USERITEM_MODE_DIE_EXPLOSE, @USERITEM_MODE_DIE_DISEASE))
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment 	= '지원하지 않는 모드입니다.'
		END
	else if(@fieldidx < @USERITEM_FIELDIDX_INVEN or @fieldidx >= 9)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment 	= '죽었다고 표시해준다.(기존 or 없거나 or 대표 or 인벤)'
		END
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '죽었다고 표시해준다.(신규)'

			-----------------------------------------
			-- 대표동물 죽으면 기본동물로 세팅
			-----------------------------------------
			if(@anireplistidx = @listidx_)
				begin
					update dbo.tUserMaster
						set
							anirepitemcode 	=  1,
							anirepacc1	 	= -1,
							anirepacc2 		= -1
					where gameid = @gameid_
				end

			-----------------------------------------
			-- 필요부활석.
			-----------------------------------------
			select
				@needhelpcnt = param13
			from dbo.tItemInfo
			where itemcode = @itemcode

			-----------------------------------------
			-- 죽기전에 정보백업
			-----------------------------------------
			if(@gameyear >= 2014)
				begin
					-- 보기용 로고만 기록한다. (이걸 가지고 복구하지는 않는다.)
					exec spu_AnimalLogBackup @gameid_, 1, @listidx_, @mode_, @needhelpcnt	-- 죽음로고.
				end

			-----------------------------------------
			-- 죽음표시.
			-----------------------------------------
			--select 'DEBUG 늑대, 터져 죽음 > 필드(병원:-2), 모드, 시간'
			update dbo.tUserItem
				set
					fieldidx 	= @USERITEM_FIELDIDX_HOSPITAL,
					diemode		= @mode_,
					diedate		= getdate(),
					needhelpcnt	= @needhelpcnt
			where gameid = @gameid_ and listidx = @listidx_ and invenkind in (@USERITEM_INVENKIND_ANI)

			-----------------------------------------
			-- (죽은 동물 > 10개 > 나중것 부터삭제)
			-----------------------------------------
			-- 1. 커서를 사용 정리.
			set @loop = 0

			declare curTemp Cursor for
			select listidx from dbo.tUserItem
			where gameid = @gameid_ and invenkind in (@USERITEM_INVENKIND_ANI) and fieldidx = @USERITEM_FIELDIDX_HOSPITAL
			order by diedate desc

			-- 2. 커서오픈
			open curTemp

			-- 3. 커서 사용
			Fetch next from curTemp into @listidx
			while @@Fetch_status = 0
				Begin
					--select 'DEBUG 병원수량 확인', @loop loop
					if(@loop >= @GAME_INVEN_HOSPITAL_BASE)
						begin
							--select 'DEBUG > 삭제', @loop loop, @listidx listidx
							exec spu_DeleteUserItemBackup 0, @gameid_, @listidx
						end

					set @loop = @loop + 1
					Fetch next from curTemp into @listidx
				end

			-- 4. 커서닫기
			close curTemp
			Deallocate curTemp
		END

	select @nResult_ rtn, @comment comment

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
End



