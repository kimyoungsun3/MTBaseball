/*
update dbo.tUserMaster set boardwrite = getdate() - 0.01 where gameid = 'xxxx2'
exec spu_UserBoard 'xxxx2', '049000s1i0n7t8445289', 1, 1, -1, '친추게시판광고', -1		-- 게시판글쓰기.
exec spu_UserBoard 'xxxx2', '049000s1i0n7t8445289', 1, 2, -1, '일반게시판광고', -1		-- < 사용안함.
exec spu_UserBoard 'xxxx2', '049000s1i0n7t8445289', 1, 3, -1, '대항게시판광고', -1

-- delete from dbo.tUserBoard where kind = 3 and idx2 > 10
-- select top 10 * from dbo.tUserBoard where kind = 1 order by idx2 desc
exec spu_UserBoard 'xxxx2', '049000s1i0n7t8445289', 2, 1, 1, '', -1					-- 친추.
exec spu_UserBoard 'xxxx2', '049000s1i0n7t8445289', 2, 2, 1, '', -1					-- 일반.
exec spu_UserBoard 'xxxx2', '049000s1i0n7t8445289', 2, 3, 1, '', -1					-- 대항.

--글읽기 테스트.
exec spu_UserBoard 'xxxx2', '049000s1i0n7t8445289', 2,  1, 0, '', -1					-- 친추.
exec spu_UserBoard 'xxxx2', '049000s1i0n7t8445289', 2,  1, 1, '', -1					-- 친추.
exec spu_UserBoard 'xxxx2', '049000s1i0n7t8445289', 2,  1, 2, '', -1					-- 친추.
exec spu_UserBoard 'xxxx2', '049000s1i0n7t8445289', 2,  1, 7456, '', -1					-- 친추.
exec spu_UserBoard 'xxxx2', '049000s1i0n7t8445289', 2,  1, 7457, '', -1					-- 친추.
exec spu_UserBoard 'xxxx2', '049000s1i0n7t8445289', 2,  1, 7458, '', -1					-- 친추.
*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_UserBoard', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_UserBoard;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_UserBoard
	@gameid_								varchar(20),					-- 게임아이디
	@password_								varchar(20),
	@mode_									int,
	@kind_									int,
	@page_									int,
	@message_								varchar(256),
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

	-- 기타오류
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- 지원하지않는모드
	declare @RESULT_ERROR_TIME_REMAIN			int				set @RESULT_ERROR_TIME_REMAIN			= -123			-- 아직 시간이 남음.
	declare @RESULT_ERROR_NOT_FOUND_USERFARM	int				set @RESULT_ERROR_NOT_FOUND_USERFARM	= -125			-- 목장리스트가 미구매.
	declare @RESULT_ERROR_ALREADY_REWARD		int				set @RESULT_ERROR_ALREADY_REWARD		= -126			-- 무엇인가 이미보상했음.

	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------
	-- 게시판 모드.
	declare @USERBOARD_MODE_WRITE				int				set @USERBOARD_MODE_WRITE				= 1		-- 글쓰기
	declare @USERBOARD_MODE_READ				int				set @USERBOARD_MODE_READ				= 2		-- 읽기

	-- 게시판 종류.
	declare @USERBOARD_KIND_NORMAL				int				set @USERBOARD_KIND_NORMAL				= 1		-- 친추게시판(1)
	declare @USERBOARD_KIND_FRIEND				int				set @USERBOARD_KIND_FRIEND				= 2 	-- 일반게시판(2)
	declare @USERBOARD_KIND_GROUP				int				set @USERBOARD_KIND_GROUP				= 3		-- 대항게시판(3)

	-- 게시판 라인수
	declare @PAGE_LINE							int				set @PAGE_LINE							= 10

	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @comment		varchar(128)
	declare @gameid			varchar(20)				set @gameid			= ''
	declare @idx2			int						set @idx2			= 1
	declare @pagemax		int						set @pagemax		= 1
	declare @page			int						set @page			= 1
	declare @schoolidx		int						set @schoolidx		= -1
	declare @gapminute		int						set @gapminute		= 0
	declare @boardwrite		datetime				set @boardwrite		= getdate()

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG 입력정보', @gameid_ gameid_, @password_ password_, @mode_ mode_, @kind_ kind_, @page_ page_, @message_ message_

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	select
		@gameid 		= gameid,
		@schoolidx		= schoolidx,
		@boardwrite		= boardwrite
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 유저정보', @gameid gameid

	set @gapminute 		= dbo.fnu_GetDatePart('mi', @boardwrite, getdate())
	--select 'DEBUG 유저정보', @gapminute gapminute, @boardwrite boardwrite, getdate() '현재시간'

	------------------------------------------------
	-- 3-3. 각 조건별 분기
	------------------------------------------------
	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR 아이디가 존재하지 않는다.'
			--select 'DEBUG ' + @comment
		END
	else if (@mode_ not in (@USERBOARD_MODE_WRITE, @USERBOARD_MODE_READ) or @kind_ not in (@USERBOARD_KIND_NORMAL, @USERBOARD_KIND_FRIEND, @USERBOARD_KIND_GROUP))
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment 	= 'ERROR 지원하지 않는 모드입니다.'
			--select 'DEBUG ' + @comment
		END
	else if (@mode_ in (@USERBOARD_MODE_WRITE) and @gapminute <= 2)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_TIME_REMAIN
			set @comment 	= 'ERROR 아직 시간이 남았습니다.'
			--select 'DEBUG ' + @comment
		END
	else if (@mode_ = @USERBOARD_MODE_WRITE)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'SUCCESS 글쓰기 성공.'
			--select 'DEBUG ' + @comment

			---------------------------------------
			-- 인덱스 번호를 읽어서 > 입력.
			---------------------------------------
			-- 현카테고리의 맥스번호
			select @idx2 = (isnull(max(idx2), 0) + 1)
			from dbo.tUserBoard where kind = @kind_

			-- 입력
			insert into dbo.tUserBoard( kind,   idx2,  gameid,   message,   schoolidx)
			values(                    @kind_, @idx2, @gameid_, @message_, @schoolidx)

			--select 'DEBUG WRITE', @idx2 idx2

			-- select 'DEBUG 게시판 글쓴 시간을 기록해둔다.'
			update dbo.tUserMaster
				set
					boardwrite	= getdate()
			where gameid = @gameid_
		END
	else if (@mode_ = @USERBOARD_MODE_READ)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'SUCCESS 글읽기 성공.'
			----select 'DEBUG ' + @comment

			---------------------------------------
			-- 인덱스 번호를 읽어서 > 입력.
			---------------------------------------
			-- 현카테고리의 맥스번호
			select @idx2 = (isnull(max(idx2), 1))
			from dbo.tUserBoard where kind = @kind_

			--select 'DEBUG READ', @idx2 idx2
		END
	else
		begin
			set @nResult_ 	= @RESULT_ERROR
			set @comment 	= 'ERROR 알수없는 오류(-1)'
		end


	--------------------------------------------------------------
	-- 결과전송.
	--------------------------------------------------------------
	select @nResult_ rtn, @comment comment
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			-- 페이지 맥스
			set @pagemax	= @idx2 / @PAGE_LINE
			set @pagemax 	= @pagemax + case when (@idx2 % @PAGE_LINE != 0) then 1 else 0 end
			set @page		= case
								when (@page_ <= 0)			then 1
								when (@page_ >  @pagemax)	then @pagemax
								else @page_
							end
			set @idx2		= @idx2 - (@page - 1) * @PAGE_LINE
			--select 'DEBUG ', @idx2 idx2

			--------------------------------------------------------------
			-- 게시판 정보.
			--------------------------------------------------------------
			DECLARE @tTempTableList TABLE(
				pagemax			int,
				page			int,

				idx				int,
				idx2			int,
				kind			int,
				gameid			varchar(20),
				message			varchar(256),
				writedate		datetime,
				schoolidx		int
			);

			if(@mode_ = @USERBOARD_MODE_WRITE)
				begin
					insert into @tTempTableList
					select top 10 @pagemax pagemax, @page page, idx, idx2, kind, gameid, message, writedate, schoolidx from dbo.tUserBoard
					where kind = @kind_ order by idx desc, idx2 desc
				end
			else
				begin
					insert into @tTempTableList
					select top 10 @pagemax pagemax, @page page, idx, idx2, kind, gameid, message, writedate, schoolidx from dbo.tUserBoard
					where idx2 <= @idx2 and kind = @kind_ order by idx desc, idx2 desc
				end


			-------------------------------------------------------------
			-- 게시판에 동물 링크 걸기.
			-------------------------------------------------------------
			--select b.*, isnull(i.itemcode, 1) itemcode, isnull(acc1, -1) acc1, isnull(acc2, -1) acc2 from
			--	(select gameid, anireplistidx from dbo.tUserMaster where gameid in (select gameid from @tTempTableList)) as m
			--LEFT JOIN
			--	(select gameid, listidx, itemcode, acc1, acc2 from dbo.tUserItem where gameid in (select gameid from @tTempTableList)) as i
			--ON
			--	m.gameid = i.gameid and m.anireplistidx = i.listidx
			--JOIN
			--	@tTempTableList b
			--ON
			--	m.gameid = b.gameid

			select b.*, isnull(m.itemcode, 1) itemcode, isnull(acc1, -1) acc1, isnull(acc2, -1) acc2, kakaoprofile, kakaonickname from
				(select gameid, anirepitemcode itemcode, anirepacc1 acc1, anirepacc2 acc2, kakaoprofile, kakaonickname from dbo.tUserMaster where gameid in (select gameid from @tTempTableList)) as m
			JOIN
				@tTempTableList b
			ON
				m.gameid = b.gameid
			order by idx desc




		end

	------------------------------------------------
	--	4-2. 유저정보
	------------------------------------------------
	set nocount off
End

