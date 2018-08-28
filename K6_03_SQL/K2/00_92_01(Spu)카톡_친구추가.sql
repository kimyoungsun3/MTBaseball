-----------------------------------------------------------------------
-- exec sup_FVsubAddKakaoFriend 'xxxx@gmail.com', '0:kakaouseridxxxx;1:kakaouseridxxxx3;'
-- exec sup_FVsubAddKakaoFriend 'xxxx@gmail.com', '0:x1;1:x2;'
-- SELECT * FROM dbo.fnu_SplitTwoStr(';', ':', '0:x1;1:x2;')
-- SELECT * FROM dbo.fnu_SplitTwoStr(';', ':', '0:kakaouseridxxxx;1:kakaouseridxxxx3;')
-- exec sup_FVsubAddKakaoFriend 'villxxxx', '0:88227566776204833;1:88248034712699921;2:88282071099937857;'
-----------------------------------------------------------------------
use Farm
GO

IF OBJECT_ID ( 'dbo.sup_FVsubAddKakaoFriend', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.sup_FVsubAddKakaoFriend;
GO

create procedure dbo.sup_FVsubAddKakaoFriend
	@gameid_				varchar(60),
	@kakaouseridlist_		varchar(8000)
	--WITH ENCRYPTION -- 프로시져를 암호화함.
as
	-- 친구상태값.
	declare @USERFRIEND_STATE_NON				int					set	@USERFRIEND_STATE_NON						=-2;		-- -2: 없음.
	declare @USERFRIEND_STATE_SEARCH			int					set	@USERFRIEND_STATE_SEARCH					=-1;		-- -1: 검색.
	declare @USERFRIEND_STATE_PROPOSE_WAIT		int					set	@USERFRIEND_STATE_PROPOSE_WAIT				= 0;		-- 0 : 친구신청대기
	declare @USERFRIEND_STATE_APPROVE_WAIT		int					set	@USERFRIEND_STATE_APPROVE_WAIT				= 1;		-- 1 : 친구수락대기
	declare @USERFRIEND_STATE_FRIEND			int					set	@USERFRIEND_STATE_FRIEND					= 2;		-- 2 : 상호친구

	declare @KAKAO_FRIEND_KIND_GAME				int					set @KAKAO_FRIEND_KIND_GAME						= 1 		-- 게임친구
	declare @KAKAO_FRIEND_KIND_KAKAO			int					set @KAKAO_FRIEND_KIND_KAKAO					= 2 		-- 카카오친구

	-- 진행중 or 새로하기.
	declare @KAKAO_STATUS_CURRENTING  			int				set @KAKAO_STATUS_CURRENTING			= 1				-- 현재게임 진행상태
	declare @KAKAO_STATUS_NEWSTART  			int				set @KAKAO_STATUS_NEWSTART				= -1			-- 새롭하기한상태


	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @dummy			int
	declare	@kakaouserid	varchar(40)		set @kakaouserid	= ''
	declare @friendid		varchar(60)		set @friendid		= ''
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on

	if(LEN(@kakaouseridlist_) >= 3)
		begin
			-- 1. 커서 생성
			declare curParamInfo Cursor for
			select listidx, data FROM dbo.fnu_SplitTwoStr(';', ':', @kakaouseridlist_)

			-- 2. 커서오픈
			open curParamInfo

			-- 3. 커서 사용
			Fetch next from curParamInfo into @dummy, @kakaouserid
			while @@Fetch_status = 0
				Begin
					set @friendid		= ''
					select @friendid = gameid from dbo.tFVKakaoMaster where kakaouserid = @kakaouserid
					--select 'DEBUG ', @friendid friendid
					if(@friendid != '')
						begin
							------------------------------------------
							-- 기존 쓰레기 데이타를 삭제한다.
							------------------------------------------
							-- 나 - 친구
							--select 'DEBUG 나 - 친구', @gameid_ gameid_, @kakaouserid kakaouserid
							--select 'DEBUG ', gameid from dbo.tFVUserMaster where kakaouserid = @kakaouserid and kakaostatus != @KAKAO_STATUS_NEWSTART
							--delete from dbo.tFVUserFriend
							--where gameid = @gameid_
							--	  and friendid in (select gameid from dbo.tFVUserMaster where kakaouserid = @kakaouserid and kakaostatus != @KAKAO_STATUS_NEWSTART)


							--select 'DEBUG 있음', @kakaouserid, @friendid
							-- 내 - 친구
							if(not exists(select top 1 * from dbo.tFVUserFriend where gameid = @gameid_ and friendid = @friendid))
								begin
									--select 'DEBUG 내 - 친구(입력)'
									insert into dbo.tFVUserFriend(gameid,   friendid,  state,					 kakaofriendkind,         helpdate,      senddate)
									values(                      @gameid_, @friendid, @USERFRIEND_STATE_FRIEND, @KAKAO_FRIEND_KIND_KAKAO, getdate() - 1, getdate() - 1)
								end
							else
								begin
									--select 'DEBUG 내 - 친구(갱신)'
									update dbo.tFVUserFriend
										set
											state 			= @USERFRIEND_STATE_FRIEND,
											kakaofriendkind = @KAKAO_FRIEND_KIND_KAKAO
									where gameid = @gameid_ and friendid = @friendid
								end

							-- 친구 - 내
							--select 'DEBUG 친구 - 내', @friendid friendid, @kakaouserid kakaouserid, @gameid_ gameid_
							--select 'DEBUG ', kakaouserid from dbo.tFVKakaoMaster where gameid = @gameid_
							--select 'DEBUG ', gameid from dbo.tFVUserMaster where kakaouserid in (select kakaouserid from dbo.tFVKakaoMaster where gameid = @gameid_) and kakaostatus != @KAKAO_STATUS_NEWSTART
							--delete from dbo.tFVUserFriend
							--where gameid = @friendid
							--	  and friendid in (select gameid from dbo.tFVUserMaster where kakaouserid in (select kakaouserid from dbo.tFVKakaoMaster where gameid = @gameid_) and kakaostatus != @KAKAO_STATUS_NEWSTART)

							if(not exists(select top 1 * from dbo.tFVUserFriend where gameid = @friendid and friendid = @gameid_))
								begin
									--select 'DEBUG 친구 - 내(입력)'
									insert into dbo.tFVUserFriend(gameid,  friendid, state,					   kakaofriendkind,         helpdate,      senddate)
									values(                    @friendid, @gameid_, @USERFRIEND_STATE_FRIEND, @KAKAO_FRIEND_KIND_KAKAO, getdate() - 1, getdate() - 1)
								end
							else
								begin
									--select 'DEBUG 친구 - 내(갱신)'
									update dbo.tFVUserFriend
										set
											state 			= @USERFRIEND_STATE_FRIEND,
											kakaofriendkind	= @KAKAO_FRIEND_KIND_KAKAO
									where gameid = @friendid and friendid = @gameid_
								end
						end
					--else
					--	begin
					--		--select 'DEBUG 없음', @kakaouserid, @friendid
					--	end
					Fetch next from curParamInfo into @dummy, @kakaouserid
				end

			-- 4. 커서닫기
			close curParamInfo
			Deallocate curParamInfo
		end

	------------------------------------------------
	--	4-1. 종류
	------------------------------------------------
	set nocount off
End


