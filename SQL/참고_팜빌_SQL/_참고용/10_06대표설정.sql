/*
exec spu_FVAniRepReg 'xxxx0', '049000s1i0n7t8445289', 0, -1	-- 없음.
exec spu_FVAniRepReg 'xxxx', '049000s1i0n7t8445289', 8, -1	-- 소모템.
exec spu_FVAniRepReg 'xxxx', '049000s1i0n7t8445289', 1, -1	-- 필드동물.
exec spu_FVAniRepReg 'xxxx', '049000s1i0n7t8445289', 18, -1	 --없는 번호
exec spu_FVAniRepReg 'xxxx', '049000s1i0n7t8445289', 17, -1	-- 정상(병원).
exec spu_FVAniRepReg 'xxxx', '049000s1i0n7t8445289', 0, -1	-- 정상(창고).
exec spu_FVAniRepReg 'xxxx2', '049000s1i0n7t8445289', 3, -1	-- 정상(필드).
select * from dbo.tFVSchoolUser where gameid = 'xxxx2'
*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVAniRepReg', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVAniRepReg;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_FVAniRepReg
	@gameid_								varchar(60),
	@password_								varchar(20),
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
	declare @RESULT_ERROR_RESULT_COPY			int				set @RESULT_ERROR_RESULT_COPY			= -53			-- 결과카피시도.
	declare @RESULT_ERROR_GAMECOST_COPY			int				set @RESULT_ERROR_GAMECOST_COPY			= -54			-- 실버카피시도.
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- 지원하지않는모드.
	declare @RESULT_ERROR_HEART_FULL			int				set @RESULT_ERROR_HEART_FULL			= -71			-- 지원하지않는모드.
	declare @RESULT_ERROR_TUTORIAL_ALREADY		int				set @RESULT_ERROR_TUTORIAL_ALREADY		= -73			-- 투토리얼 이미 보상.
	declare @RESULT_ERROR_NOT_FOUND_OTHERID		int				set @RESULT_ERROR_NOT_FOUND_OTHERID		= -83
	declare @RESULT_ERROR_INVEN_FULL			int				set @RESULT_ERROR_INVEN_FULL			= -101			-- 인벤부족.
	declare @RESULT_ERROR_DAILY_REWARD_ALREADY	int				set @RESULT_ERROR_DAILY_REWARD_ALREADY	= -102			-- 일일보상 이미 보상.
	declare @RESULT_ERROR_NOT_FOUND_DOGAMIDX	int				set @RESULT_ERROR_NOT_FOUND_DOGAMIDX	= -103			-- 도감번호를 찾을수 없음.
	declare @RESULT_ERROR_DOGAM_ALREADY_REWARD	int				set @RESULT_ERROR_DOGAM_ALREADY_REWARD	= -104			-- 도감을 이미 지급했음.
	declare @RESULT_ERROR_DOGAM_LACK			int				set @RESULT_ERROR_DOGAM_LACK			= -105			-- 도감중에 동물번호가 부족함.
	declare @RESULT_ERROR_ANIMAL_NOT_FOUND		int				set @RESULT_ERROR_ANIMAL_NOT_FOUND		= -106			-- 대표동물 못찾음.
	declare @RESULT_ERROR_ANIMAL_NOT_INVEN		int				set @RESULT_ERROR_ANIMAL_NOT_INVEN		= -107			-- 인벤에 없음(창고).
	declare @RESULT_ERROR_ANIMAL_NOT_ALIVE		int				set @RESULT_ERROR_ANIMAL_NOT_ALIVE		= -108			-- 살아 있지 않음.
	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------
	-- 아이템별 인벤분류
	declare @USERITEM_INVENKIND_ANI				int 				set @USERITEM_INVENKIND_ANI					= 1
	declare @USERITEM_INVENKIND_CONSUME			int 				set @USERITEM_INVENKIND_CONSUME				= 3
	declare @USERITEM_INVENKIND_ACC				int 				set @USERITEM_INVENKIND_ACC					= 4
	declare @USERITEM_INVENKIND_DIRECT			int 				set @USERITEM_INVENKIND_DIRECT				= 40
	declare @USERITEM_INVENKIND_INFO			int 				set @USERITEM_INVENKIND_INFO				= 60
	declare @USERITEM_INVENKIND_PET				int 				set @USERITEM_INVENKIND_PET					= 1000

	-- 기타 상수값
	declare @ID_MAX								int					set	@ID_MAX									= 9999	-- 한폰당 생성할 수 있는 아이디개수.
	declare @USERMASTER_UPGRADE_STATE_NON		int					set @USERMASTER_UPGRADE_STATE_NON			= -1	--미진행, 완료중.(유저)
	declare @USERMASTER_UPGRADE_STATE_ING		int					set @USERMASTER_UPGRADE_STATE_ING			= 1		--다음단계진행중.
	declare @USERSEED_NEED_EMPTY				int					set @USERSEED_NEED_EMPTY					= -1	-- (경작지)
	declare @USERSEED_NEED_BUY					int					set @USERSEED_NEED_BUY						= -2

	-- 동물정보.
	-- 필드동물 0 ~ 8.
	declare @USERITEM_FIELDIDX_INVEN			int					set @USERITEM_FIELDIDX_INVEN					= -1	-- 창고.
	declare @USERITEM_FIELDIDX_HOSPITAL			int					set @USERITEM_FIELDIDX_HOSPITAL					= -2	-- 병원.

	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @comment			varchar(80)
	declare @gameid 			varchar(60),
			@anireplistidx		int,
			@anirepitemcode		int,
			@anirepacc1			int,
			@anirepacc2			int

	declare @invenkind			int				set	@invenkind	= -444
	declare @fieldidx			int				set @fieldidx	= -444

	set @anirepitemcode			=  1
	set @anirepacc1				= -1
	set @anirepacc2				= -1


Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG 입력값', @gameid_ gameid_, @password_ password_, @listidx_ listidx_

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	select
		@gameid 		= gameid,
		@anireplistidx 	= anireplistidx
	from dbo.tFVUserMaster
	where gameid = @gameid_
	--select 'DEBUG 유저정보', @gameid gameid, @anireplistidx anireplistidx

	select
		@invenkind 		= invenkind,
		@fieldidx 		= fieldidx,
		@anirepitemcode	= itemcode,
		@anirepacc1		= acc1,
		@anirepacc2		= acc2
	from dbo.tFVUserItem
	where gameid = @gameid_ and listidx = @listidx_
	--select 'DEBUG 대표동물정보', @gameid gameid, @invenkind invenkind, @fieldidx fieldidx

	if(isnull(@gameid, '') = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '아이디가 존재하지 않는다.'
		END
	else if(@invenkind != @USERITEM_INVENKIND_ANI)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_ANIMAL_NOT_FOUND
			set @comment 	= '해당 동물아니거나 없다.'
		END
	else if(@fieldidx = @USERITEM_FIELDIDX_HOSPITAL)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_ANIMAL_NOT_ALIVE
			set @comment 	= '해당 동물이 살아있지 않다.'
		END
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '등록했습니다..'

			----------------------------
			-- 대표가축 링크변경.
			----------------------------
			update dbo.tFVUserMaster
				set
					anireplistidx 	= @listidx_,
					anirepitemcode 	= @anirepitemcode,
					anirepacc1	 	= @anirepacc1,
					anirepacc2 		= @anirepacc2
			where gameid = @gameid_

			----------------------------
			-- 대표가축 > 학교개인 동물세팅도 변경.
			----------------------------
			update dbo.tFVSchoolUser
				set
					itemcode= @anirepitemcode,
					acc1	= @anirepacc1,
					acc2	= @anirepacc2
			where gameid = @gameid_
		END

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
	select @nResult_ rtn, @comment comment
End



