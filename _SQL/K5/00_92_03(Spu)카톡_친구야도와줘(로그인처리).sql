-----------------------------------------------------------------------
-- select top 1 * from dbo.tKakaoHelpWait where gameid = 'xxxx'
-- delete from dbo.tGiftList where gameid in ('xxxx2', 'xxxx', 'xxxx3')
-- exec sup_subKakaoHelpWait 'xxxx'
-- exec sup_subKakaoHelpWait 'xxxx3'
-----------------------------------------------------------------------
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.sup_subKakaoHelpWait', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.sup_subKakaoHelpWait;
GO

create procedure dbo.sup_subKakaoHelpWait
	@gameid_				varchar(20)
	--WITH ENCRYPTION -- 프로시져를 암호화함.
as
	------------------------------------------------
	--	2-2. 정의된값
	------------------------------------------------
	-- 아이템별 인벤분류
	declare @USERITEM_INVENKIND_ANI				int 				set @USERITEM_INVENKIND_ANI					= 1

	-- 죽은 or 부활모드.
	declare @USERITEM_MODE_DIE_INIT				int					set @USERITEM_MODE_DIE_INIT					= -1-- 초기상태.

	-- 동물정보.
	declare @USERITEM_INIT_ANISTEP				int					set @USERITEM_INIT_ANISTEP						= 5		-- 단계.
	declare @USERITEM_INIT_MANGER				int					set @USERITEM_INIT_MANGER						= 25	-- 여물통.
	declare @USERITEM_INIT_DISEASESTATE			int					set @USERITEM_INIT_DISEASESTATE					= 0		-- 질병상태.

	-- 도와준 친구에 대한 보상
	declare @HEART_REWARD						int					set @HEART_REWARD								= 2012  -- 하트 10개.

	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @friendid			varchar(20)		set @friendid			= ''
	declare @kakaonickname		varchar(40)		set @kakaonickname		= ''
	declare @helpgameid			varchar(20)		set @helpgameid			= ''
	declare @helpcomment		varchar(256)
	declare @listidx			int				set @listidx			= -1
	declare @needhelpcnt		int 			set @needhelpcnt		= 99999
	declare @invenkind			int
	declare @loop 				int				set @loop 				= 0
	declare @itemcode			int				set @itemcode			= 1
	declare @ishelp				int				set @ishelp				= -1
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on

	--select 'DEBUG 1 요청 1일전것 삭제', @gameid_ gameid_
	delete from dbo.tKakaoHelpWait
	where gameid = @gameid_ and helpdate < getdate() - 1

	-- 닉네임을 얻어오기.
	select @kakaonickname = kakaonickname FROM dbo.tUserMaster where gameid = @gameid_

	-- 1. 커서 생성
	declare curKakaoHelpWait Cursor for
	select friendid, listidx FROM dbo.tKakaoHelpWait where gameid = @gameid_

	-- 2. 커서오픈
	open curKakaoHelpWait

	-- 3. 커서 사용
	Fetch next from curKakaoHelpWait into @friendid, @listidx
	while @@Fetch_status = 0
		Begin
			--select 'DEBUG 2-1 데이타 존재', @friendid friendid, @listidx listidx

			set @needhelpcnt = 99999
			select @needhelpcnt = needhelpcnt, @invenkind = invenkind, @itemcode = itemcode from dbo.tUserItem where gameid = @friendid and listidx = @listidx
			--select 'DEBUG 2-2', @needhelpcnt needhelpcnt, @invenkind invenkind

			if(@needhelpcnt <= 0 or @needhelpcnt = 99999 or @invenkind != @USERITEM_INVENKIND_ANI)
				begin
					--select 'DEBUG 2-3 데이타가 없다 ㅠㅠ 패스~~'
					set @needhelpcnt = 99999
				end
			else if(@needhelpcnt <= 1)
				begin
					--------------------------------------------
					--select 'DEBUG 2-4 부활, 쪽지 기록하기.'
					-- 동물 부활.
					--------------------------------------------
					update dbo.tUserItem
						set
							fieldidx 	= -1,
							anistep		= @USERITEM_INIT_ANISTEP,
							manger		= @USERITEM_INIT_MANGER,
							diseasestate= @USERITEM_INIT_DISEASESTATE,
							diemode		= @USERITEM_MODE_DIE_INIT,
							diedate		= null,
							needhelpcnt	= 0
					where gameid = @friendid and listidx = @listidx

					--------------------------------------------
					-- 살아나는 동물의 수량을 기록한다.
					--------------------------------------------
					update dbo.tUserMaster
						set
							kkhelpalivecnt = kkhelpalivecnt + 1
					where gameid = @friendid

					--------------------------------------------
					-- 쪽지 남기기
					--------------------------------------------
					set @helpgameid 	= '친구도움'
					--set @helpcomment 	= @kakaonickname + '님의 도움으로 가축이 부활했습니다! 부활한 가축을 인벤토리에서 확인하세요.'
					set @helpcomment 	= '친구의 도움으로 가축이 부활했습니다! 부활한 가축을 인벤토리에서 확인하세요.'
					Exec spu_SubGiftSendNew 1, -1, 0, @helpgameid, @friendid, @helpcomment


					------------------------------------------------
					---- 해당동물을 선물함으로 넣어주기.
					----  	1. 삭제해서 로그를 별도로 기록.
					----	2. 해당 동물을 선물함(친구부활)로 넣어준다.
					----	3. 악세사리를 넣어준다.
					------------------------------------------------
					--delete from dbo.tUserItem where gameid = @friendid and listidx = @listidx
                    --
					--set @helpgameid = '친구도움(' + @kakaonickname + ')'
					--Exec spu_SubGiftSendNew 2, @itemcode, 0, @helpgameid, @friendid, ''				-- 젖소

					-- 도와줄 친구가 있다.
					set @ishelp				= 1
				end
			else if(@needhelpcnt <= 10)
				begin
					--select 'DEBUG 2-5 부활 도움줌'
					update dbo.tUserItem
						set
							needhelpcnt = needhelpcnt - 1
					where gameid = @friendid and listidx = @listidx

					-- 도와줄 친구가 있다.
					set @ishelp				= 1
				end

			set @loop = @loop + 1
			Fetch next from curKakaoHelpWait into @friendid, @listidx
		end

	if(@loop >= 1)
		begin
			--select 'DEBUG 3 요청처리 일괄 삭제'
			delete from dbo.tKakaoHelpWait where gameid = @gameid_
		end

	if(@ishelp = 1)
		begin
			-- 도움을 준 친구에게 보상해주기.
			exec spu_SubGiftSendNew 2, @HEART_REWARD, 0, 'SysHelp2', @gameid_, ''
		end


	-- 4. 커서닫기
	close curKakaoHelpWait
	Deallocate curKakaoHelpWait

	------------------------------------------------
	--	4-1. 종류
	------------------------------------------------
	set nocount off
End


