/*
exec dbo.spu_BetRollBack 10, 'mtxxxx3', 51	-- -1 -> 10 재로그인으로 몰수처리
exec dbo.spu_BetRollBack 11, 'mtxxxx3', 52	-- -2 -> 11 재로그인으로 몰수처리
exec dbo.spu_BetRollBack 12, 'mtxxxx3', 53	-- -1 -> 12 관리자 강제삭제
exec dbo.spu_BetRollBack 13, 'mtxxxx3', 54	-- -1 -> 13 관리자 강제롤백
*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_BetRollBack', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_BetRollBack;
GO

create procedure dbo.spu_BetRollBack
	@state_									int,
	@gameid_								varchar(20),		-- 게임아이디
	@idx_									int
	WITH ENCRYPTION -- 프로시져를 암호화함.
as
	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @GIFTLIST_GIFT_KIND_MESSAGE			int					set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2

	-- MT 플래그
	declare @SINGLE_FLAG_PLAY					int					set @SINGLE_FLAG_PLAY						= 1
	declare @SINGLE_FLAG_END					int					set @SINGLE_FLAG_END						= 0

	-- 배팅상태.
	declare @GAME_STATE_ING						int					set @GAME_STATE_ING							= -1	-- 게임진행중.
	declare @GAME_STATE_ROLLBACK				int					set @GAME_STATE_ROLLBACK					= -2	-- 롤백예정임.
	declare @GAME_STATE_SUCCESS					int					set @GAME_STATE_SUCCESS						= 0		-- 정상처리.
	declare @GAME_STATE_FAIL_LOGIN_MOLSU		int					set @GAME_STATE_FAIL_LOGIN_MOLSU			= 10	-- 재로그인으로 몰수.
	declare @GAME_STATE_FAIL_LOGIN_ROLLBACK		int					set @GAME_STATE_FAIL_LOGIN_ROLLBACK			= 11	-- 재로그인으로 롤백
	declare @GAME_STATE_FAIL_ADMIN_DEL			int					set @GAME_STATE_FAIL_ADMIN_DEL				= 12	-- 관리자가 삭제함.
	declare @GAME_STATE_FAIL_ADMIN_ROLLBACK		int					set @GAME_STATE_FAIL_ADMIN_ROLLBACK			= 13	-- 관리자가 롤백처리.

	declare @SINGLE_GAME_LOG_MAX				int					set @SINGLE_GAME_LOG_MAX 					= 200
	declare @ITEM_GAMECOST_MOTHER				int 				set @ITEM_GAMECOST_MOTHER					= 6000

	------------------------------------------------
	-- 배팅정보.
	declare @selectdata				varchar(100)		set @selectdata			= ''
	declare @consumeitemcode		int 				set @consumeitemcode	= -1
	declare @consumecnt				int					set @consumecnt			= 0
	declare @select1				int					set @select1			= -1
	declare @select2				int					set @select2			= -1
	declare @select3				int					set @select3			= -1
	declare @select4				int					set @select4			= -1
	declare @cnt1					int					set @cnt1				= 0
	declare @cnt2					int					set @cnt2				= 0
	declare @cnt3					int					set @cnt3				= 0
	declare @cnt4					int					set @cnt4				= 0

	declare @idx2					int					set @idx2 				= 1
	declare @idx2del				int					set @idx2del			= -1

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	--select 'DEBUG 1-1 삭제, 복구', @state_ state_, @gameid_ gameid_, @idx_ idx_

	if(@state_ in ( @GAME_STATE_FAIL_ADMIN_DEL, @GAME_STATE_FAIL_LOGIN_MOLSU ) )
		begin
			------------------------------------------------
			-- 유저 정보세팅
			------------------------------------------------
			update dbo.tUserMaster set singleflag = @SINGLE_FLAG_END where gameid = @gameid_
			--select 'DEBUG 2-1 삭제, 몰수', singleflag from dbo.tUserMaster where gameid = @gameid_

			------------------------------------------------
			-- 이동
			------------------------------------------------
			--select 'DEBUG 2-2 삭제, 몰수', ( ISNULL( MAX( idx2 ), 0) + 1) from dbo.tSingleGameLog where gameid = @gameid_
			select @idx2 = ( ISNULL( MAX( idx2 ), 0) + 1) from dbo.tSingleGameLog where gameid = @gameid_


			insert into dbo.tSingleGameLog
			(
						idx2,
						gameid, curturntime, curturndate, gamemode, consumeitemcode,
						select1, cnt1, select2, cnt2, select3, cnt3, select4, cnt4,
						selectdata, writedate, connectip, level, exp, commission, gamestate
			)
			select 		@idx2,
						gameid, curturntime, curturndate, gamemode, consumeitemcode,
						select1, cnt1, select2, cnt2, select3, cnt3, select4, cnt4,
						selectdata, writedate, connectip, level, exp, commission, @state_
			from dbo.tSingleGame
			where gameid = @gameid_ and idx = @idx_

			------------------------------------------------
			-- 삭제하기.
			------------------------------------------------
			--select 'DEBUG 2-3 배팅정보삭제', * from dbo.tSingleGame where gameid = @gameid_ and idx = @idx_
			delete from dbo.tSingleGame where gameid = @gameid_ and idx = @idx_


			------------------------------------------------
			-- 로고삭제.
			------------------------------------------------
			set @idx2del = @idx2 - @SINGLE_GAME_LOG_MAX
			if( @idx2del > 0 )
				begin
					--select 'DEBUG 2-4 배팅로고삭제', @idx2del idx2del, @idx2 idx2, * from dbo.tSingleGameLog where gameid = @gameid_ and idx2 < @idx2del
					delete from dbo.tSingleGameLog where gameid = @gameid_ and idx2 < @idx2del
				end


		end
	else if(@state_ in ( @GAME_STATE_FAIL_ADMIN_ROLLBACK, @GAME_STATE_FAIL_LOGIN_ROLLBACK ) )
		begin

			------------------------------------------------
			-- 유저 정보세팅
			------------------------------------------------
			update dbo.tUserMaster set singleflag = @SINGLE_FLAG_END where gameid = @gameid_

			--select 'DEBUG 2-1 롤백', singleflag from dbo.tUserMaster where gameid = @gameid_

			------------------------------------------------
			-- 유저 정보배팅 정보 읽기.
			------------------------------------------------
			select
				@selectdata			= selectdata,
				@consumeitemcode	= consumeitemcode,
				@select1 	= select1, 	@cnt1 	= cnt1,
				@select2 	= select2, 	@cnt2 	= cnt2,
				@select3 	= select3, 	@cnt3 	= cnt3,
				@select4 	= select4, 	@cnt4 	= cnt4
			from dbo.tSingleGame
			where gameid = @gameid_ and idx = @idx_

			--select 'DEBUG 2-2 롤백', * from dbo.tSingleGame where gameid = @gameid_ and idx = @idx_

			------------------------------------------------
			-- 소모템 복구하기.
			------------------------------------------------
			if( @consumeitemcode != -1)
				begin
					exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT,  @consumeitemcode,  1, 'SysBetRoll', @gameid_, ''

					--select 'DEBUG 2-3 롤백 소모템복구(수량1개)', @consumeitemcode consumeitemcode
				end

			------------------------------------------------
			-- 조각템 모두 감소해두기
			------------------------------------------------
			if(@select1 != -1)
				begin
					exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT,  @ITEM_GAMECOST_MOTHER,  @cnt1, 'SysBetRoll', @gameid_, ''
					--select 'DEBUG 2-4-1 롤백 조각템복구', @cnt1 cnt1
				end

			if(@select2 != -1)
				begin
					exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT,  @ITEM_GAMECOST_MOTHER,  @cnt2, 'SysBetRoll', @gameid_, ''
					--select 'DEBUG 2-4-2 롤백 조각템복구', @cnt2 cnt2
				end

			if(@select3 != -1)
				begin
					exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT,  @ITEM_GAMECOST_MOTHER,  @cnt3, 'SysBetRoll', @gameid_, ''
					--select 'DEBUG 2-4-2 롤백 조각템복구', @cnt3 cnt3
				end

			if(@select4 != -1)
				begin
					exec spu_SubGiftSendNew @GIFTLIST_GIFT_KIND_GIFT,  @ITEM_GAMECOST_MOTHER,  @cnt4, 'SysBetRoll', @gameid_, ''
					--select 'DEBUG 2-4-2 롤백 조각템복구', @cnt4 cnt4
				end

			------------------------------------------------
			-- 이동
			------------------------------------------------
			----select 'DEBUG 2-5 롤백', ( ISNULL( MAX( idx2 ), 0) + 1) from dbo.tSingleGameLog where gameid = @gameid_
			select @idx2 = ( ISNULL( MAX( idx2 ), 0) + 1) from dbo.tSingleGameLog where gameid = @gameid_


			insert into dbo.tSingleGameLog
			(
						idx2,
						gameid, curturntime, curturndate, gamemode, consumeitemcode,
						select1, cnt1, select2, cnt2, select3, cnt3, select4, cnt4,
						selectdata, writedate, connectip, level, exp, commission, gamestate
			)
			select 		@idx2,
						gameid, curturntime, curturndate, gamemode, consumeitemcode,
						select1, cnt1, select2, cnt2, select3, cnt3, select4, cnt4,
						selectdata, writedate, connectip, level, exp, commission, @state_
			from dbo.tSingleGame
			where gameid = @gameid_ and idx = @idx_


			------------------------------------------------
			-- 삭제하기.
			------------------------------------------------
			--select 'DEBUG 2-6 배팅정보삭제', * from dbo.tSingleGame where gameid = @gameid_ and idx = @idx_
			delete from dbo.tSingleGame where gameid = @gameid_ and idx = @idx_

			------------------------------------------------
			-- 로고삭제.
			------------------------------------------------
			set @idx2del = @idx2 - @SINGLE_GAME_LOG_MAX
			if( @idx2del > 0 )
				begin
					--select 'DEBUG 2-7 배팅로고정보삭제', @idx2del idx2del, @idx2 idx2, * from dbo.tSingleGameLog where gameid = @gameid_ and idx2 < @idx2del
					delete from dbo.tSingleGameLog where gameid = @gameid_ and idx2 < @idx2del
				end
		end

	set nocount off
End

