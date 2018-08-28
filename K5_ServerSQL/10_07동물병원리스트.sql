/*
-- 죽음세팅
exec spu_AniDie 'xxxx2', '049000s1i0n7t8445289', 1, 0, -1
exec spu_AniDie 'xxxx2', '049000s1i0n7t8445289', 1, 1, -1
exec spu_AniDie 'xxxx2', '049000s1i0n7t8445289', 1, 2, -1
exec spu_AniDie 'xxxx2', '049000s1i0n7t8445289', 1, 3, -1
exec spu_AniDie 'xxxx2', '049000s1i0n7t8445289', 1,14, -1

-- 무료부활(2013).
exec spu_AniRevival 'xxxx2', '049000s1i0n7t8445289', 2, 0, -1, -1
exec spu_AniRevival 'xxxx2', '049000s1i0n7t8445289', 2, 1, -1, -1
exec spu_AniRevival 'xxxx2', '049000s1i0n7t8445289', 2, 2, -1, -1
exec spu_AniRevival 'xxxx2', '049000s1i0n7t8445289', 2, 3, -1, -1
exec spu_AniRevival 'xxxx2', '049000s1i0n7t8445289', 2,14, -1, -1

-- 도움요청
-- select * from dbo.tUserFriend where gameid = 'xxxx2'
-- select * from dbo.tKakaoHelpWait where gameid = 'xxxx2'
-- xxxx2 -> xxxx3, xxxx4 요청
-- exec spu_AniDie 'xxxx2', '049000s1i0n7t8445289', 1, 25, -1						-- 눌러죽음.
-- update dbo.tUserFriend set helpdate = getdate() - 10 where gameid in ('xxxx2', 'xxxx', 'xxxx3')
exec spu_KakaoFriendHelp 'xxxx2', '049000s1i0n7t8445289', 'xxxx',  0, -1
exec spu_KakaoFriendHelp 'xxxx2', '049000s1i0n7t8445289', 'xxxx3', 1, -1

-- 부활요청처리, 자신의 동물병원, 내집의 리스트(새로운것만 추가해주삼)
exec spu_AniHosList 'xxxx2', '049000s1i0n7t8445289', -1
exec spu_AniHosList 'xxxx', '049000s1i0n7t8445289', -1
exec spu_AniHosList 'xxxx3', '049000s1i0n7t8445289', -1

*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_AniHosList', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_AniHosList;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_AniHosList
	@gameid_								varchar(20),
	@password_								varchar(20),
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
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함
	declare @RESULT_ERROR_NOT_FOUND_PASSWORD	int				set @RESULT_ERROR_NOT_FOUND_PASSWORD	= -17
	declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--서버를 점검하고 있다.
	declare @RESULT_NEWVERION_CLIENT_DOWNLOAD 	int				set @RESULT_NEWVERION_CLIENT_DOWNLOAD	= -15			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 링크처리.
	declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--신버젼이 나왔다 > 새버젼을 받아라 메세지 처리후 종료.

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

	-- 기타 상수값
	declare @ID_MAX								int					set	@ID_MAX									= 9999	-- 한폰당 생성할 수 있는 아이디개수.
	declare @USERMASTER_UPGRADE_STATE_NON		int					set @USERMASTER_UPGRADE_STATE_NON			= -1	--미진행, 완료중.(유저)
	declare @USERMASTER_UPGRADE_STATE_ING		int					set @USERMASTER_UPGRADE_STATE_ING			= 1		--다음단계진행중.
	declare @USERSEED_NEED_EMPTY				int					set @USERSEED_NEED_EMPTY					= -1	-- (경작지)
	declare @USERSEED_NEED_BUY					int					set @USERSEED_NEED_BUY						= -2
	-- >= 0 이상이면 특정 식물이 심어져있음.

	-- 동물정보.
	-- 필드동물 0 ~ 8.
	declare @USERITEM_FIELDIDX_INVEN			int					set @USERITEM_FIELDIDX_INVEN					= -1	-- 창고.
	declare @USERITEM_FIELDIDX_HOSPITAL			int					set @USERITEM_FIELDIDX_HOSPITAL					= -2	-- 병원.
	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @comment				varchar(512)
	declare @gameid 				varchar(20)
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG 입력정보', @gameid_ gameid_, @password_ password_

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	select
		@gameid 		= gameid
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 유저정보', @gameid gameid

	if(isnull(@gameid, '') = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '아이디가 존재하지 않는다. > 아이디를 확인해라.'
			--select 'DEBUG ', @comment
		END
	else if(not exists(select top 1 * from dbo.tKakaoHelpWait where gameid = @gameid_))
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '정상처리(처리할것이 없음)'
		END
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '정상처리(처리해서 보냄)'
			--select 'DEBUG ', @comment

			------------------------------------------------------------------------
			-- 친구 도움 요청 처리하기(직접구현). > 리스트 출력때문에
			-----------------------------------------------------------------------
			exec sup_subKakaoHelpWait @gameid_
		END

	select @nResult_ rtn, @comment comment
	if(@nResult_ = @RESULT_SUCCESS)
		BEGIN
			--------------------------------------------------------------
			-- 유저 보유템 전체 리스트
			-- 동물(살아있는것, 동물병원)
			--------------------------------------------------------------
			select top 10 * from dbo.tUserItem
			where gameid = @gameid_ and invenkind = @USERITEM_INVENKIND_ANI and fieldidx = @USERITEM_FIELDIDX_HOSPITAL
			order by diedate asc

			--------------------------------------------------------------
			-- 내집에 살아 있는 동물들.
			--------------------------------------------------------------
			select * from dbo.tUserItem
			where gameid = @gameid_ and invenkind = @USERITEM_INVENKIND_ANI and fieldidx = @USERITEM_FIELDIDX_INVEN
		END

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
End



