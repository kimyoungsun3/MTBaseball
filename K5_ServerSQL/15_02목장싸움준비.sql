/*
--delete from dbo.tBattleLog where gameid = 'xxxx2'
select * from dbo.tBattleLog where gameid = 'xxxx2'

exec spu_AniBattleStart 'xxxx2', '049000s1i0n7t8445289', 6900, '0:19;1:20;2:21;', -1
exec spu_AniBattleStart 'xxxx2', '049000s1i0n7t8445289', 6901, '0:2;1:39;1:38;', -1
exec spu_AniBattleStart 'xxxx2', '049000s1i0n7t8445289', 6902, '0:2;1:39;1:38;', -1

exec spu_AniBattleStart 'farm308281', '0522672n2f3p6t462944', 6900, '0:67;1:84;2:69;', -1
exec spu_AniBattleStart 'xxxx2', '049000s1i0n7t8445289', 6900, '', -1
*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_AniBattleStart', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_AniBattleStart;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_AniBattleStart
	@gameid_								varchar(20),					-- 게임아이디
	@password_								varchar(20),
	@farmidx_								int,
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
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함

	-- 기타오류
	declare @RESULT_ERROR_INVEN_FULL			int				set @RESULT_ERROR_INVEN_FULL			= -101			-- 인벤부족
	declare @RESULT_ERROR_LISTIDX_NOT_FOUND		int				set @RESULT_ERROR_LISTIDX_NOT_FOUND		= -114			-- 리스트 번호를 못찾음.
	declare @RESULT_ERROR_NOT_FOUND_USERFARM	int				set @RESULT_ERROR_NOT_FOUND_USERFARM	= -125			-- 목장리스트가 미구매.
	declare @RESULT_ERROR_NOT_CLEAR_BEFORE_FARM	int				set @RESULT_ERROR_NOT_CLEAR_BEFORE_FARM	= -149			-- 목장도전불가.
	declare @RESULT_ERROR_TICKET_LACK			int				set @RESULT_ERROR_TICKET_LACK			= -150			-- 티켓수량부족.
	declare @RESULT_ERROR_PLAY_COUNT_ZERO		int				set @RESULT_ERROR_PLAY_COUNT_ZERO		= -151			-- 플레이 횟수가 없습니다.
	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------
	-- 아이템별 인벤분류
	declare @USERITEM_INVENKIND_STEMCELL		int 				set @USERITEM_INVENKIND_STEMCELL			= 1040

	-- 농장(정보).
	declare @USERFARM_BUYSTATE_NOBUY			int					set @USERFARM_BUYSTATE_NOBUY				= -1	-- (농장)
	declare @USERFARM_BUYSTATE_BUY				int					set @USERFARM_BUYSTATE_BUY					=  1

	-- 결과정보.
	declare @BATTLE_RESULT_WIN					int					set @BATTLE_RESULT_WIN				=  1	-- (농장)
	declare @BATTLE_RESULT_LOSE					int					set @BATTLE_RESULT_LOSE				= -1
	declare @BATTLE_RESULT_DRAW					int					set @BATTLE_RESULT_DRAW				=  0

	-- 플레그정보.
	declare @BATTLE_END							int					set @BATTLE_END						= 0
	declare @BATTLE_READY						int					set @BATTLE_READY					= 1

	declare @DEFINE_TIME_BASE					int					set @DEFINE_TIME_BASE				= 8000 -- 8초
	--declare @USER_LOG_MAX						int					set @USER_LOG_MAX 					= 50	-- 12개월 * 40년.
	declare @USER_LOG_MAX						int					set @USER_LOG_MAX 					= 50	-- 테스트용.

	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @comment				varchar(512)		set @comment			= ''
	declare @gameid					varchar(20)			set @gameid				= ''
	declare @market					int					set @market				= 1
	declare @cashcost				int					set @cashcost 			= 0
	declare @gamecost				int					set @gamecost 			= 0
	declare @heart					int					set @heart 				= 0
	declare @feed					int					set @feed 				= 0
	declare @fpoint					int					set @fpoint				= 0
	declare @goldticket				int					set @goldticket			= 0
	declare @goldticketmax			int					set @goldticketmax		= 0
	declare @goldtickettime			datetime			set @goldtickettime		= getdate()
	declare @battleticket			int					set @battleticket		= 0
	declare @battleticketmax		int					set @battleticketmax	= 0
	declare @battletickettime		datetime			set @battletickettime	= getdate()
	declare @battlefarmidx			int					set @battlefarmidx		= 6900
	declare @battleanilistidx1		int					set @battleanilistidx1	= -1
	declare @battleanilistidx2		int					set @battleanilistidx2	= -1
	declare @battleanilistidx3		int					set @battleanilistidx3	= -1
	declare @buystate				int					set @buystate			= @USERFARM_BUYSTATE_NOBUY
	declare @invenstemcellmax		int					set @invenstemcellmax	= 50
	declare @cnt					int					set @cnt				= 0
	declare @playcnt				int					set @playcnt			= 0


	declare @battleidx2				int					set @battleidx2			= 0
	declare @needticket				int					set @needticket			= 4
	declare @enemylv				int					set @enemylv			= 99
	declare @enemycnt				int					set @enemycnt			= 7
	declare @stagecnt				int					set @stagecnt			= 6
	declare @enemyboss				int					set @enemyboss			= 0
	declare @enemyani				int					set @enemyani			= 7
	declare @kind					int
	declare @info					int
	declare @loop					int

	-- 동물.
	declare @aniitemcode			int					set @aniitemcode		= -1
	declare @aniitemname			varchar(40)			set @aniitemname		= ''
	declare @grade					int					set @grade				=  0
	declare @upcnt					int					set @upcnt				=  0
	declare @upstep					int					set @upstep				=  0
	declare @att					int					set @att				=  0
	declare @time					int					set @time				=  0
	declare @def					int					set @def				=  0
	declare @hp						int					set @hp					=  0

	declare @anidesc1				varchar(120)		set @anidesc1			= '없음'
	declare @anidesc2				varchar(120)		set @anidesc2			= '없음'
	declare @anidesc3				varchar(120)		set @anidesc3			= '없음'

	-- 보물.
	declare @tslistidx1				int					set @tslistidx1			= -1
	declare @tslistidx2				int					set @tslistidx2			= -1
	declare @tslistidx3				int					set @tslistidx3			= -1
	declare @tslistidx4				int					set @tslistidx4			= -1
	declare @tslistidx5				int					set @tslistidx5			= -1

	declare @tsitemname				varchar(40)			set @tsitemname			= ''
	declare @tsupgrade				int					set @tsupgrade			=  0
	declare @tsvalue				int					set @tsvalue			=  0

	declare @ts1					varchar(40)			set @ts1				=  '미장착'
	declare @ts2					varchar(40)			set @ts2				=  '미장착'
	declare @ts3					varchar(40)			set @ts3				=  '미장착'
	declare @ts4					varchar(40)			set @ts4				=  '미장착'
	declare @ts5					varchar(40)			set @ts5				=  '미장착'

	-- 적동물.
	declare @enemydesc				varchar(120)		set @enemydesc			=  ''
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG 입력정보', @gameid_ gameid_, @password_ password_, @farmidx_ farmidx_, @listset_ listset_

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	select
		@gameid 		= gameid,			@market			= market,
		@cashcost		= cashcost,			@gamecost		= gamecost,			@heart				= heart,			@feed			= feed,				@fpoint			= fpoint,
		@invenstemcellmax= invenstemcellmax,
		@battlefarmidx	= battlefarmidx,
		@tslistidx1 	= tslistidx1,		@tslistidx2 = tslistidx2,			@tslistidx3 = tslistidx3,			@tslistidx4 = tslistidx4,		@tslistidx5 = tslistidx5,
		@goldticket		= goldticket, 		@goldticketmax 	= goldticketmax, 	@goldtickettime		= goldtickettime,
		@battleticket	= battleticket, 	@battleticketmax= battleticketmax, 	@battletickettime	= battletickettime
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 유저정보', @gameid gameid, @battlefarmidx battlefarmidx, @goldticket goldticket, @battleticket battleticket

	select
		@buystate		= buystate,		@playcnt		= playcnt
	from dbo.tUserFarm
	where gameid = @gameid_ and itemcode = @farmidx_
	--select 'DEBUG 농장 보유정보', @farmidx_ farmidx_, @buystate buystate, @playcnt playcnt

	select
		@needticket	= param14,

		@enemyani	= param16,
		@enemylv	= param17,
		@enemycnt	= param18,
		@stagecnt	= param19,
		@enemyboss	= param20
	from dbo.tItemInfo
	where itemcode = @farmidx_
	--select 'DEBUG 필요수량정보.', @farmidx_ farmidx_, @needticket needticket

	if(@gameid != '')
		begin
			------------------------------------------------
			-- 티켓 수량 정리.
			------------------------------------------------
			select
				@goldtickettime = rtndate,
				@goldticket		= rtncount
			from dbo.fnu_GetActionTime(@goldtickettime, getdate(), @goldticket, @goldticketmax)
			--select 'DEBUG ', @goldtickettime goldtickettime, @goldticket goldticket, @goldticketmax goldticketmax

			select
				@battletickettime 	= rtndate,
				@battleticket		= rtncount
			from dbo.fnu_GetActionTime(@battletickettime, getdate(), @battleticket, @battleticketmax)
			--select 'DEBUG ', @battletickettime battletickettime, @battleticket battleticket, @battleticketmax battleticketmax

			------------------------------------------------
			-- 줄기세포의 수량.
			------------------------------------------------
			select @cnt = count(*) from dbo.tUserItem
			where gameid = @gameid_ and invenkind = @USERITEM_INVENKIND_STEMCELL

		end

	------------------------------------------------
	-- 3-3. 각 조건별 분기
	------------------------------------------------
	if( @gameid = '' )
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR 아이디가 존재하지 않는다.'
			--select 'DEBUG ' + @comment
		END
	else if(@buystate != @USERFARM_BUYSTATE_BUY)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_USERFARM
			set @comment 	= 'ERROR 농장을 소유하고 있지 않다.'
			--select 'DEBUG ' + @comment
		END
	else if ( @farmidx_ > @battlefarmidx + 1 )
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_CLEAR_BEFORE_FARM
			set @comment 	= 'ERROR 전목장을 클리어하세요.'
			--select 'DEBUG ' + @comment
		END
	else if(@needticket > @battleticket)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_TICKET_LACK
			set @comment 	= 'ERROR 티켓수량이 부족합니다.'
			--select 'DEBUG ' + @comment
		END
	else if(@playcnt <= 0)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_PLAY_COUNT_ZERO
			set @comment 	= 'ERROR 현재 플레이 횟수가 없습니다..'
			--select 'DEBUG ' + @comment
		END
	else if(@cnt >= @invenstemcellmax)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_INVEN_FULL
			set @comment 	= 'ERROR 동물 인벤이 풀입니다.'
			--select 'DEBUG ' + @comment
		END
	else if ( @listset_ = '' or LEN(@listset_) < 4 )
		BEGIN
			set @nResult_ = @RESULT_ERROR_LISTIDX_NOT_FOUND
			set @comment = 'ERROR 해당 리스트를 찾을수 없습니다.(1)'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 준비했습니다.'
			----select 'DEBUG ' + @comment

			set @loop	= 1
			------------------------------------------------------------------
			-- 정보보기.
			-- 내동물 로고용~~~
			------------------------------------------------------------------
			-- 1. 커서 생성
			declare curUpgradeInfo Cursor for
			select * FROM dbo.fnu_SplitTwo(';', ':', @listset_)

			-- 2. 커서오픈
			open curUpgradeInfo

			-- 3. 커서 사용
			Fetch next from curUpgradeInfo into @kind, @info
			while @@Fetch_status = 0
				Begin
					set @upcnt			= 0
					set @upstep			= 0
					set @aniitemcode 	= -1
					set @aniitemname	= ''
					set @grade			= 0
					set @att			= 0
					set @time			= 0
					set @def			= 0
					set @hp				= 0

					select
						@upcnt			= upcnt,
						@upstep			= upstep,
						@aniitemcode 	= itemcode,
						@aniitemname	= itemname2,
						@grade			= grade,
						@att			= attbase	+ attconst * upcnt / upstep  + attstem100 / 100,
						@time			= timebase	+ timeconst * upcnt / upstep  + timestem100 / 100,
						@def			= defbase	+ defconst * upcnt / upstep  + defstem100 / 100,
						@hp				= hpbase	+ hpconst * upcnt / upstep  + hpstem100 / 100
					from
					( select itemcode itemcode2, itemname itemname2, grade, param20 fresconst, param21 attbase, param22 attconst, param23 timebase, param24 timeconst, param25 defbase, param26 defconst, param27 hpbase, param28 hpconst, param29 upstep
					from dbo.tItemInfo
					where itemcode = ( select itemcode from dbo.tUserItem where gameid = @gameid_ and listidx = @info ) ) a
					JOIN
					(select itemcode, upcnt, attstem100, timestem100, defstem100, hpstem100 from dbo.tUserItem where gameid = @gameid_ and listidx = @info) b
					ON a.itemcode2 = b.itemcode

					--select 'DEBUG 시간값', @loop loop, @aniitemcode aniitemcode, @upcnt upcnt, @att att,  @time time,  @def def,  @hp hp
					set @time = @DEFINE_TIME_BASE / (100 + @time/3) * 100
					--select 'DEBUG 시간', @loop loop, @aniitemcode aniitemcode, @aniitemname aniitemname, @grade grade, @upcnt upcnt, @att att,  @time time,  @def def,  @hp hp


					if(@aniitemcode != -1)
						begin
							if(@loop = 1)
								begin
									set @battleanilistidx1	= @info
									set @anidesc1		= @aniitemname+ '(' + ltrim(str(@aniitemcode)) + ')'
															+ ' 등급(' + ltrim(str(@grade)) + ')'
															+ ' ' + case when @upstep != 0 then (ltrim(str(@upcnt/@upstep + 1)) + 'lv' ) else '' end
															+ ' ' + (ltrim(str(@upcnt)) + '강')
															+ ' att:' + ltrim(str(@att))
															+ ' def:' + ltrim(str(@def))
															+ ' hp:' + ltrim(str(@hp))
															+ ' time:' + ltrim(str(@time))
								end
							else if(@loop = 2)
								begin
									set @battleanilistidx2	= @info
									set @anidesc2		= @aniitemname+ '(' + ltrim(str(@aniitemcode)) + ')'
															+ ' 등급(' + ltrim(str(@grade)) + ')'
															+ ' ' + case when @upstep != 0 then (ltrim(str(@upcnt/@upstep + 1)) + 'lv' ) else '' end
															+ ' ' + (ltrim(str(@upcnt)) + '강')
															+ ' att:' + ltrim(str(@att))
															+ ' def:' + ltrim(str(@def))
															+ ' hp:' + ltrim(str(@hp))
															+ ' time:' + ltrim(str(@time))
								end
							else if(@loop = 3)
								begin
									set @battleanilistidx3	= @info
									set @anidesc3		= @aniitemname+ '(' + ltrim(str(@aniitemcode)) + ')'
															+ ' 등급(' + ltrim(str(@grade)) + ')'
															+ ' ' + case when @upstep != 0 then (ltrim(str(@upcnt/@upstep + 1)) + 'lv' ) else '' end
															+ ' ' + (ltrim(str(@upcnt)) + '강')
															+ ' att:' + ltrim(str(@att))
															+ ' def:' + ltrim(str(@def))
															+ ' hp:' + ltrim(str(@hp))
															+ ' time:' + ltrim(str(@time))
								end
						end


					set @loop = @loop + 1
					Fetch next from curUpgradeInfo into @kind, @info
				end
			-- 4. 커서닫기
			close curUpgradeInfo
			Deallocate curUpgradeInfo
			--select 'DEBUG ', @battleanilistidx1 battleanilistidx1, @battleanilistidx2 battleanilistidx2, @battleanilistidx3 battleanilistidx3

			---------------------------------------------
			-- 보물능력치계산.
			-- 내보물 로고용~~~
			---------------------------------------------
			if( @tslistidx1 != -1 )
				begin
					select
						@tsitemname		= itemname2,
						@tsupgrade		= treasureupgrade,
						@tsvalue		= base_value + treasureupgrade * upgrade_value
					from
					( select itemcode itemcode2, itemname itemname2, param2 base_value, param3 upgrade_value
					from dbo.tItemInfo
					where itemcode = ( select itemcode from dbo.tUserItem where gameid = @gameid_ and listidx = @tslistidx1 ) ) a
					JOIN
					(select itemcode, treasureupgrade from dbo.tUserItem where gameid = @gameid_ and listidx = @tslistidx1) b
					ON a.itemcode2 = b.itemcode

					set @ts1 = @tsitemname + ' ' + ltrim(str(@tsupgrade)) + '강 ' + ltrim(str(@tsvalue))
				end

			if( @tslistidx2 != -1 )
				begin
					select
						@tsitemname		= itemname2,
						@tsupgrade		= treasureupgrade,
						@tsvalue		= base_value + treasureupgrade * upgrade_value
					from
					( select itemcode itemcode2, itemname itemname2, param2 base_value, param3 upgrade_value
					from dbo.tItemInfo
					where itemcode = ( select itemcode from dbo.tUserItem where gameid = @gameid_ and listidx = @tslistidx2 ) ) a
					JOIN
					(select itemcode, treasureupgrade from dbo.tUserItem where gameid = @gameid_ and listidx = @tslistidx2) b
					ON a.itemcode2 = b.itemcode

					set @ts2 = @tsitemname + ' ' + ltrim(str(@tsupgrade)) + '강 ' + ltrim(str(@tsvalue))
				end

			if( @tslistidx3 != -1 )
				begin
					select
						@tsitemname		= itemname2,
						@tsupgrade		= treasureupgrade,
						@tsvalue		= base_value + treasureupgrade * upgrade_value
					from
					( select itemcode itemcode2, itemname itemname2, param2 base_value, param3 upgrade_value
					from dbo.tItemInfo
					where itemcode = ( select itemcode from dbo.tUserItem where gameid = @gameid_ and listidx = @tslistidx3 ) ) a
					JOIN
					(select itemcode, treasureupgrade from dbo.tUserItem where gameid = @gameid_ and listidx = @tslistidx3) b
					ON a.itemcode2 = b.itemcode

					set @ts3 = @tsitemname + ' ' + ltrim(str(@tsupgrade)) + '강 ' + ltrim(str(@tsvalue))
				end

			if( @tslistidx4 != -1 )
				begin
					select
						@tsitemname		= itemname2,
						@tsupgrade		= treasureupgrade,
						@tsvalue		= base_value + treasureupgrade * upgrade_value
					from
					( select itemcode itemcode2, itemname itemname2, param2 base_value, param3 upgrade_value
					from dbo.tItemInfo
					where itemcode = ( select itemcode from dbo.tUserItem where gameid = @gameid_ and listidx = @tslistidx4 ) ) a
					JOIN
					(select itemcode, treasureupgrade from dbo.tUserItem where gameid = @gameid_ and listidx = @tslistidx4) b
					ON a.itemcode2 = b.itemcode

					set @ts4 = @tsitemname + ' ' + ltrim(str(@tsupgrade)) + '강 ' + ltrim(str(@tsvalue))
				end

			if( @tslistidx5 != -1 )
				begin
					select
						@tsitemname		= itemname2,
						@tsupgrade		= treasureupgrade,
						@tsvalue		= base_value + treasureupgrade * upgrade_value
					from
					( select itemcode itemcode2, itemname itemname2, param2 base_value, param3 upgrade_value
					from dbo.tItemInfo
					where itemcode = ( select itemcode from dbo.tUserItem where gameid = @gameid_ and listidx = @tslistidx5 ) ) a
					JOIN
					(select itemcode, treasureupgrade from dbo.tUserItem where gameid = @gameid_ and listidx = @tslistidx5) b
					ON a.itemcode2 = b.itemcode

					set @ts5 = @tsitemname + ' ' + ltrim(str(@tsupgrade)) + '강 ' + ltrim(str(@tsvalue))
				end

			---------------------------------------------
			-- 적능력치계산.
			---------------------------------------------
			set @enemydesc =
							' 등장:'
							+ case
									when @enemyani = 4 then '소'
									when @enemyani = 2 then '양'
									when @enemyani = 1 then '산양'
									when @enemyani = 6 then '소/양'
									when @enemyani = 5 then '소/산양'
									when @enemyani = 3 then '양/산양'
									when @enemyani = 7 then '소/양/산양'
									else					 '모름'
							  end
							+ ' 레벨:' 	+  ltrim(str(@enemylv))
							+ ' att:' 	+ ltrim(str(13 * @enemylv + 10))
							+ ' time:' 	+ ltrim(str(11000 / (100  + @enemylv*4) * 100))
							+ ' DEF:' 	+ ltrim(str(50 + (@enemylv - 2)* 10))
							+ ' HP:' 	+ ltrim(str(100 + (@enemylv - 2)* 12))
							+ ' 등장:' + ltrim(str(@enemycnt)) + '/' + ltrim(str(@stagecnt))
							+ ' BOSS:'
								+ case
										when @enemyboss = 0 then '없음(0)'
										when @enemyboss = 1 then '보스Att(1)'
										when @enemyboss = 2 then '보스Def(2)'
										when @enemyboss = 3 then '보스HP(3)'
										when @enemyboss = 4 then '보스Turn(4)'
										when @enemyboss = 11 then '보스AD(11)'
										when @enemyboss = 12 then '보스ah(12)'
										when @enemyboss = 13 then '보스at(13)'
										when @enemyboss = 14 then '보스dh(14)'
										when @enemyboss = 15 then '보스dt(15)'
										when @enemyboss = 16 then '보스ht(16)'
										when @enemyboss = 21 then '보스adh(21)'
										when @enemyboss = 22 then '보스adt(22)'
										when @enemyboss = 23 then '보스aht(23)'
										when @enemyboss = 24 then '보스dht(24)'
										when @enemyboss = 31 then '보스adht(31)'
										else					 '모름'
								  end

			---------------------------------------------
			-- 배틀티켓 사용량 차감.
			---------------------------------------------
			set @battleticket = @battleticket - @needticket

			---------------------------------------------
			-- 기록마킹
			---------------------------------------------
			update dbo.tUserMaster
				set
					goldticket		= @goldticket,
					goldtickettime	= @goldtickettime,
					battleticket	= @battleticket,
					battletickettime= @battletickettime,
					battlefarmidx	= case when ( @farmidx_ > battlefarmidx ) then @farmidx_ else battlefarmidx end,
					battleanilistidx1= @battleanilistidx1, battleanilistidx2= @battleanilistidx2, battleanilistidx3= @battleanilistidx3,
					battleflag		= @BATTLE_READY
			where gameid = @gameid_

			---------------------------------------------
			-- 배틀횟수차감.
			---------------------------------------------
			--update dbo.tUserFarm
			--	set
			--		playcnt = playcnt - 1
			--where gameid = @gameid_ and itemcode = @farmidx_


			---------------------------------------------
			-- 기록마킹
			---------------------------------------------
			set @battleidx2 = 1
			select @battleidx2 = isnull( max( idx2 ), 0 ) + 1 from dbo.tBattleLog where gameid = @gameid_
			--select 'DEBUG ', @battleidx2 battleidx2, @farmidx_ farmidx_
			insert into dbo.tBattleLog(gameid,        idx2,  farmidx,
												anidesc1,  anidesc2,  anidesc3,
												ts1name,  ts2name,   ts3name,   ts4name,  ts5name,
												enemydesc
												)
			values(					  @gameid_,@battleidx2, @farmidx_,
												@anidesc1,  @anidesc2, @anidesc3,
												@ts1, @ts2, @ts3, @ts4, @ts5,
												@enemydesc
												)

			-- 일정수량 이상은 삭제.
			if(@battleidx2 - @USER_LOG_MAX > 0)
				begin
					delete from dbo.tBattleLog where gameid = @gameid_ and idx2 < @battleidx2 - @USER_LOG_MAX
				end

			------------------------------------------------
			-- 통계정보.
			------------------------------------------------
			exec spu_DayLogInfoStatic @market, 32, 1			-- 일 배틀수.
		END


	--------------------------------------------------------------
	-- 결과전송.
	--------------------------------------------------------------
	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost, @heart heart, @feed feed, @fpoint fpoint, @goldticket goldticket, @battleticket battleticket, @goldtickettime goldtickettime, @battletickettime battletickettime, @battleidx2 battleidx2, @goldticketmax goldticketmax, @battleticketmax battleticketmax,
		   @enemylv enemylv, @enemycnt enemycnt, @stagecnt stagecnt, @enemyani enemyani, @enemyboss enemyboss



	------------------------------------------------
	--	4-2. 유저정보
	------------------------------------------------
	set nocount off
End

