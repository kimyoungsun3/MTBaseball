/*
-- 농장에 배치된 동물들만 나오도록 한다.
exec spu_FVAniSet 'xxxx', '049000s1i0n7t8445289', '', -1											-- 필드없음.
exec spu_FVAniSet 'xxxx', '049000s1i0n7t8445289', '3:4', -1										-- 필드1마리.
exec spu_FVAniSet 'xxxx', '049000s1i0n7t8445289', '0:1;1:3', -1
exec spu_FVAniSet 'xxxx', '049000s1i0n7t8445289', '0:1;2:3;3:17', -1
exec spu_FVAniSet 'xxxx', '049000s1i0n7t8445289', '0:1;1:3;2:17;3:16;4:8', -1
exec spu_FVAniSet 'xxxx', '049000s1i0n7t8445289', '0:1;1:2;2:3;3:4;4:5;5:6;6:12;7:13;8:14', -1	-- 필드9마리.
*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVAniSet', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVAniSet;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_FVAniSet
	@gameid_								varchar(60),
	@password_								varchar(20),
	@listset_								varchar(256),
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
	-- >= 0 이상이면 특정 식물이 심어져있음.

	-- 동물정보.
	-- 필드동물 0 ~ 8.
	declare @USERITEM_FIELDIDX_INVEN			int					set @USERITEM_FIELDIDX_INVEN					= -1	-- 창고.
	declare @USERITEM_FIELDIDX_HOSPITAL			int					set @USERITEM_FIELDIDX_HOSPITAL					= -2	-- 병원.
	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @comment			varchar(80)
	declare @gameid 			varchar(60)
	declare @fieldidx			int,
			@fieldidxold		int
	declare @listidx			int

	-- 필드오픈.
	declare @field0				int			set @field0			= -1
	declare @field1				int			set @field1			= -1
	declare @field2				int			set @field2			= -1
	declare @field3				int			set @field3			= -1
	declare @field4				int			set @field4			= -1
	declare @field5				int			set @field5			= -1
	declare @field6				int			set @field6			= -1
	declare @field7				int			set @field7			= -1
	declare @field8				int			set @field8			= -1
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG 입력값', @gameid_ gameid_, @password_ password_, @listset_ listset_

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	select
		@gameid 		= gameid,

		@field0			= field0,			@field1			= field1,			@field2			= field2,
		@field3			= field3,			@field4			= field4,			@field5			= field5,
		@field6			= field6,			@field7			= field7,			@field8			= field8
	from dbo.tFVUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 유저정보', @gameid gameid


	if(isnull(@gameid, '') = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '아이디가 존재하지 않는다.'
		END
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '동물들 재배치했습니다.'

			----------------------------------------------
			-- 동물들 필드번호 전부 초기화 (-1)
			----------------------------------------------
			update dbo.tFVUserItem
				set
					fieldidx = @USERITEM_FIELDIDX_INVEN
			from dbo.tFVUserItem
			where gameid = @gameid_ and (fieldidx >= 0 and fieldidx < 9)

			-- 최소 한쌍이상일 경우만 작동되도록 한다.[1:2]
			if(LEN(@listset_) >= 3)
				begin
				----------------------------------------------
				-- 내부번호를 보고 필드번호세팅
				----------------------------------------------
				-- 1. 커서 생성
				declare curTemp Cursor for
				select fieldidx, listidx FROM dbo.fnu_SplitTwo(';', ':', @listset_)

				-- 2. 커서오픈
				open curTemp

				-- 3. 커서 사용
				Fetch next from curTemp into @fieldidx, @listidx
				while @@Fetch_status = 0
					Begin
						--select 'DEBUG ', @fieldidx fieldidx, @listidx listidx

						-- 동물만	 	> ...
						-- 대표동물 	> 패스
						-- 죽었다		> 패스
						set @fieldidxold = -444
						select
							@fieldidxold = fieldidx
						from dbo.tFVUserItem
						where gameid = @gameid_ and listidx = @listidx and invenkind = @USERITEM_INVENKIND_ANI
						if(@fieldidxold = -1)
							begin
								-- 필드가 허용하는 범위인가?
								set @fieldidx = dbo.fun_getFVUserItemFieldCheck(@fieldidx,
																			  @field0, @field1, @field2,
																			  @field3, @field4, @field5,
																			  @field6, @field7, @field8)

								--select 'DEBUG 동물 위치변경'
								update dbo.tFVUserItem
									set
										fieldidx = @fieldidx
								from dbo.tFVUserItem
								where gameid = @gameid_ and listidx = @listidx
							end

						Fetch next from curTemp into @fieldidx, @listidx
					end

				-- 4. 커서닫기
				close curTemp
				Deallocate curTemp
			end
		END


	select @nResult_ rtn, @comment comment
	if(@nResult_ = @RESULT_SUCCESS)
		BEGIN
			--------------------------------------------------------------
			-- 동물 리스트만 보내줌.
			--------------------------------------------------------------
			select fieldidx, listidx from dbo.tFVUserItem
			where gameid = @gameid_ and invenkind in (@USERITEM_INVENKIND_ANI) and fieldidx >= 0 and fieldidx <= 9
			order by fieldidx asc
		END


	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
End



