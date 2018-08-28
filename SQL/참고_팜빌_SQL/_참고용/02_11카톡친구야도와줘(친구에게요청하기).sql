/*
-- select * from dbo.tFVUserFriend where gameid = 'xxxx2'
-- select * from dbo.tFVKakaoHelpWait where gameid = 'xxxx2'
-- xxxx2 -> xxxx3, xxxx4 요청
-- exec spu_FVGiftGain 'xxxx2', '049000s1i0n7t8445289', -3, 3429809, -1, -1, -1, -1	-- 소선물받기.
-- exec spu_FVAniDie 'xxxx2', '049000s1i0n7t8445289', 1, 1, -1						-- 눌러죽음.
-- update dbo.tFVUserFriend set helpdate = getdate() - 10 where gameid in ('xxxx2', 'xxxx', 'xxxx3')
exec spu_FVKakaoFriendHelp 'xxxx2', '049000s1i0n7t8445289', 'xxxx',  0, -1
exec spu_FVKakaoFriendHelp 'xxxx2', '049000s1i0n7t8445289', 'xxxx3', 1, -1

exec spu_FVKakaoFriendHelp 'xxxx2', '049000s1i0n7t8445289', 'xxxx',  19, -1
exec spu_FVKakaoFriendHelp 'xxxx2', '049000s1i0n7t8445289', 'xxxx3', 19, -1

exec spu_FVKakaoFriendHelp 'xxxx', '049000s1i0n7t8445289', 'xxxx2',  18, -1
exec spu_FVKakaoFriendHelp 'xxxx4', '049000s1i0n7t8445289', 'xxxx2', 18, -1
*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVKakaoFriendHelp', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVKakaoFriendHelp;
GO

create procedure dbo.spu_FVKakaoFriendHelp
	@gameid_				varchar(60),
	@password_				varchar(20),
	@friendid_				varchar(20),
	@listidx_				int,
	@nResult_				int				OUTPUT
	--WITH ENCRYPTION -- 프로시져를 암호화함.
as
	------------------------------------------------
	--	2-1. 에러코드값
	------------------------------------------------
	-- 일반값
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	-- 로그인 오류.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함
	declare @RESULT_ERROR_TIME_REMAIN			int				set @RESULT_ERROR_TIME_REMAIN			= -123			-- 아직 시간이 남음.

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

	-- 동물정보.
	-- 필드동물 0 ~ 8.
	declare @USERITEM_FIELDIDX_INVEN			int					set @USERITEM_FIELDIDX_INVEN					= -1	-- 창고.
	declare @USERITEM_FIELDIDX_HOSPITAL			int					set @USERITEM_FIELDIDX_HOSPITAL					= -2	-- 병원.

	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @comment			varchar(128)
	declare @gameid				varchar(60)		set @gameid				= ''
	declare @market				int				set @market				= 0
	declare @friendid			varchar(60)		set @friendid			= ''
	declare @listidx			int				set @listidx			= -1
	declare @helpdaycnt			int				set @helpdaycnt			= 99999
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	set @comment = '알수 없는 오류가 발생했습니다.'
	--select 'DEBUG 1', @gameid_ gameid_, @password_ password_, @friendid_ friendid_, @listidx_ listidx_

	------------------------------------------------
	--	3-2. 정보획득
	------------------------------------------------
	select
		@gameid 			= gameid,
		@market				= market
	from dbo.tFVUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 1-1 내정보', @gameid gameid

	select
		@friendid 			= gameid
	from dbo.tFVUserMaster
	where gameid = @friendid_
	--select 'DEBUG 1-2 친구정보', @friendid friendid

	select
		@helpdaycnt = datediff(d, helpdate, getdate())
	from dbo.tFVUserFriend
	where gameid = @gameid_ and friendid = @friendid_
	--select 'DEBUG 1-3 친구요청일', @helpdaycnt helpdaycnt

	------------------------------------------------
	--	3-3. 유저생성.
	------------------------------------------------
	if (@gameid = '' or @friendid = '' or @gameid = @friendid or @helpdaycnt = 99999)
		begin
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR 아이디가 존재하지 않는다.'
			--select 'DEBUG 2' + @comment
		end
	else if (@helpdaycnt < 1)
		begin
			set @nResult_ 	= @RESULT_ERROR_TIME_REMAIN
			set @comment 	= 'ERROR 시간이 남아있습니다.'
			--select 'DEBUG 3' + @comment
		end
	else
		begin
			set @nResult_ = @RESULT_SUCCESS
			set @comment = '친구에게 도와줘를 요청했습니다.'
			--select 'DEBUG 4-1', @comment
			-------------------------------------
			-- 일 카카오 도와줘친구야(O)
			-------------------------------------
			exec spu_FVDayLogInfoStatic @market, 17, 1

			--------------------------------------------
			-- [요청] 마킹하기.
			--------------------------------------------
			--select 'DEBUG 4-2 [요청]갱신'
			update dbo.tFVUserFriend
				set
					helpdate = getdate()
			where gameid = @gameid_ and friendid = @friendid_

			--------------------------------------------
			-- [기록] 마킹하기.
			--------------------------------------------
			if(not exists(select top 1 * from dbo.tFVKakaoHelpWait where gameid = @friendid_ and friendid = @gameid_ and listidx = @listidx_))
				begin
					--select 'DEBUG 4-3-1 [기록]기록'
					insert into dbo.tFVKakaoHelpWait(gameid,     friendid,   listidx)
					values(                    	  @friendid_, @gameid_,   @listidx_)
				end
			else
				begin
					--select 'DEBUG 4-3-1 [기록]갱신'
					update dbo.tFVKakaoHelpWait
						set
							helpdate = getdate()
					where gameid = @friendid_ and friendid = @gameid_ and listidx = @listidx_
				end
		end

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	select @nResult_ rtn, @comment comment


	if(@nResult_ = @RESULT_SUCCESS)
		begin
			--------------------------------------------------------------
			-- 유저 친구정보
			--------------------------------------------------------------
			exec spu_FVsubFriendList @gameid_
		end


	--최종 결과를 리턴한다.
	set nocount off
End



