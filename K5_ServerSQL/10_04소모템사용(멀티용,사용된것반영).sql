/*
-- 소모구매.
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289',  701, -1, -1, -1, 7773, -1	-- 총알
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289',  801, -1, -1, -1, 7777, -1	-- 백신
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289', 1001, -1, -1, -1, 7779, -1	-- 일꾼
exec spu_ItemBuy 'xxxx2', '049000s1i0n7t8445289', 1101, -1, -1,  1, 7781, -1	-- 촉진제


-- 소모템 사용정보.
exec spu_AniUseItem 'xxxx2', '049000s1i0n7t8445289', '', -1						-- 없음.
exec spu_AniUseItem 'xxxx2', '049000s1i0n7t8445289', '6:4', -1					-- 동물 > 패스.
exec spu_AniUseItem 'xxxx2', '049000s1i0n7t8445289', '12:1;13:1;14:1;15:1', -1	-- 소모템
*/
use Game4Farmvill5
GO

IF OBJECT_ID ( 'dbo.spu_AniUseItem', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_AniUseItem;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_AniUseItem
	@gameid_								varchar(20),
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

	-- 기타오류
	declare @RESULT_ERROR_NOT_MATCH				int				set @RESULT_ERROR_NOT_MATCH				= -110			-- 무엇인가 매치가 안되었다.
	declare @RESULT_ERROR_NOT_ENOUGH			int				set @RESULT_ERROR_NOT_ENOUGH			= -115			-- 무엇인가 충분하지 않음.
	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------
	-- 아이템별 인벤분류
	--declare @USERITEM_INVENKIND_ANI			int 				set @USERITEM_INVENKIND_ANI					= 1
	declare @USERITEM_INVENKIND_CONSUME			int 				set @USERITEM_INVENKIND_CONSUME				= 3
	--declare @USERITEM_INVENKIND_ACC			int 				set @USERITEM_INVENKIND_ACC					= 4
	--declare @USERITEM_INVENKIND_DIRECT		int 				set @USERITEM_INVENKIND_DIRECT				= 40
	--declare @USERITEM_INVENKIND_INFO			int 				set @USERITEM_INVENKIND_INFO				= 60
	--declare @USERITEM_INVENKIND_PET			int 				set @USERITEM_INVENKIND_PET					= 1000

	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @comment			varchar(80)

	declare @gameid 			varchar(20)

	declare @listidx			int
	declare @usecnt				int
	declare @updatecnt			int				set @updatecnt		= 0
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
		@gameid 		= gameid
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 유저정보', @gameid gameid


	if(isnull(@gameid, '') = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '아이디가 존재하지 않는다.'
		END
	else if(@listset_ = '' or LEN(@listset_) < 3 or CHARINDEX(':', @listset_) < 2)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_ENOUGH
			set @comment 	= '정보가 불충분합니다.'
		END
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '소모템 사용을 처리해준다.'

			----------------------------------------------
			-- 최소 한쌍이상일 경우만 작동되도록 한다.[1:2]
			-- 내부번호를 보고 보유정보 읽어오기.
			----------------------------------------------
			-- 1. 커서 생성
			declare curTemp Cursor for
			-- fieldidx	-> @listidx
			-- listidx	-> @usecnt
			select * FROM dbo.fnu_SplitTwo(';', ':', @listset_)

			-- 2. 커서오픈
			open curTemp

			-- 3. 커서 사용
			Fetch next from curTemp into @listidx, @usecnt
			while @@Fetch_status = 0
				Begin
					--select 'DEBUG ', @listidx listidx, @usecnt usecnt

					----------------------------------------------
					-- 음수대역은 양수로 바꾼다.(조작자방지)
					----------------------------------------------
					set @usecnt = case when @usecnt < 0 then (-@usecnt) else @usecnt end

					if(@usecnt > 0)
						begin
							----------------------------------------------
							-- 음수로 내려가는 것은 그대로 두자 (차후에 분석용으로 허용해둔다.)
							-- update >     find > @updatecnt	= @updatecnt + 1
							-- update > not find >
							-- 이방법을 응용한다.
							----------------------------------------------
							update dbo.tUserItem
								set
									cnt 		= case when ((cnt - @usecnt) < 0) then 0 else (cnt - @usecnt) end,
									@updatecnt	= @updatecnt + case when ((cnt - @usecnt) < 0) then 0 else 1 end			-- 업데이트 하면서 카운터한다. ㅋㅋㅋ.
							from dbo.tUserItem
							where gameid = @gameid_ and listidx = @listidx and invenkind = @USERITEM_INVENKIND_CONSUME
						end

					Fetch next from curTemp into @listidx, @usecnt
				end

			-- 4. 커서닫기
			close curTemp
			Deallocate curTemp

			----------------------------------------------
			-- 최소 한개라도 업데이트 되어야함.
			-- 그냥패스
			----------------------------------------------
			--select 'DEBUG ', @updatecnt updatecnt
			if(@updatecnt = 0)
				BEGIN
					set @nResult_ 	= @RESULT_ERROR_NOT_MATCH
					set @comment 	= '소모성 정보가 불일치 합니다.'
				END
		END


	select @nResult_ rtn, @comment comment
	if(@nResult_ = @RESULT_SUCCESS)
		BEGIN
			--------------------------------------------------------------
			-- 소모템 리스트 전체 갱신.
			--------------------------------------------------------------
			select * from dbo.tUserItem
			where gameid = @gameid_ and invenkind = @USERITEM_INVENKIND_CONSUME
			order by itemcode desc
		END


	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
End



