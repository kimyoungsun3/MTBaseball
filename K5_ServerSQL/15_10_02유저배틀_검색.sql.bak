/*
-- update dbo.tUserMaster set trophy = 600 where gameid = 'xxxx2'
-- delete from dbo.tUserBattleLog where gameid = 'xxxx2'
delete from dbo.tUserItem where gameid in ('xxxx2') and invenkind in (1)
insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 14, 9, 1, 0, -1, 1, 5)
insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 19, 1, 1, 0, -1, 1, 5) insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 20, 1, 1, 0, -1, 1, 5)
insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 21, 5, 1, 0, -1, 1, 5) insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 22, 5, 1, 0, -1, 1, 5) insert into dbo.tUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 23, 5, 1, 0, -1, 1, 5)

exec spu_UserBattleStart 'xxxx2', '049000s1i0n7t8445289', '0:14;', 				-1
exec spu_UserBattleStart 'xxxx2', '049000s1i0n7t8445289', '0:19;1:20;', 		-1
exec spu_UserBattleStart 'xxxx2', '049000s1i0n7t8445289', '0:21;1:22;2:23;', 	-1

select trophy, tier, * from dbo.tUserBattleBank where gameid = 'xxxx2' order by idx desc
select * from dbo.tUserBattleLog where gameid = 'xxxx2' order by idx desc

update dbo.tUserMaster set trophy = 0, boxrotidx = -4  where gameid = 'xxxx2'
exec spu_UserBattleStart 'xxxx2', '049000s1i0n7t8445289', '0:14;', 				-1
select * from dbo.tUserBattleSearchLog order by idx2 desc



exec spu_UserBattleStart 'xxxx2', '049000s1i0n7t8445289', '0:190;1:195;2:194;', 				-1
exec spu_UserBattleStart 'xxxx2', '049000s1i0n7t8445289', '', 				-1

*/
use Game4Farmvill5
GO

IF OBJECT_ID ( 'dbo.spu_UserBattleStart', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_UserBattleStart;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_UserBattleStart
	@gameid_								varchar(20),					-- 게임아이디
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
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함
	declare @RESULT_ERROR_LISTIDX_NOT_FOUND		int				set @RESULT_ERROR_LISTIDX_NOT_FOUND		= -114			-- 리스트 번호를 못찾음.

	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------
	-- 아이템별 인벤분류
	declare @USERITEM_INVENKIND_STEMCELL		int 				set @USERITEM_INVENKIND_STEMCELL			= 1040


	-- 플레그정보.
	--declare @BATTLE_END						int					set @BATTLE_END						= 0
	declare @BATTLE_READY						int					set @BATTLE_READY					= 1

	declare @DEFINE_TIME_BASE					int					set @DEFINE_TIME_BASE				= 8000 -- 8초
	declare @USER_LOG_MAX						int					set @USER_LOG_MAX 					= 20	-- 테스트용.
	declare @USER_BANK_MAX						int					set @USER_BANK_MAX 					= 5		-- 테스트용.
	declare @USER_SEARCH_LOOPMAX				int					set @USER_SEARCH_LOOPMAX			= 3	-- 동일한 친구 다시만니기 회전률

	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @comment				varchar(512)		set @comment			= ''
	declare @gameid					varchar(20)			set @gameid				= ''
	declare @market					int					set @market				= 1
	declare @trophy					int					set @trophy				= 0
	declare @tier					int					set @tier				= 1
	declare @boxrotidx 				int					set @boxrotidx			= -4
	declare @userbattleidx2			int					set @userbattleidx2		= 0
	declare @userbattleanilistidx1	int					set @userbattleanilistidx1= -1
	declare @userbattleanilistidx2	int					set @userbattleanilistidx2= -1
	declare @userbattleanilistidx3	int					set @userbattleanilistidx3= -1
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
	declare @def					int					set @def				=  0
	declare @hp						int					set @hp					=  0
	declare @time					int					set @time				=  0
	declare @attstem100				int					set @attstem100			=  0
	declare @defstem100				int					set @defstem100			=  0
	declare @hpstem100				int					set @hpstem100			=  0
	declare @timestem100			int					set @timestem100		=  0

	declare @anidesc1				varchar(120)		set @anidesc1			= '없음'
	declare @anidesc2				varchar(120)		set @anidesc2			= '없음'
	declare @anidesc3				varchar(120)		set @anidesc3			= '없음'

	-- 보물.
	declare @tslistidx1				int					set @tslistidx1			= -1
	declare @tslistidx2				int					set @tslistidx2			= -1
	declare @tslistidx3				int					set @tslistidx3			= -1
	declare @tslistidx4				int					set @tslistidx4			= -1
	declare @tslistidx5				int					set @tslistidx5			= -1

	declare @tsitemcode				int					set @tsitemcode			=  -1
	declare @tsitemname				varchar(40)			set @tsitemname			= ''
	declare @tsupgrade				int					set @tsupgrade			=  0
	declare @tsvalue				int					set @tsvalue			=  0

	declare @ts1					varchar(40)			set @ts1				=  '미장착'
	declare @ts2					varchar(40)			set @ts2				=  '미장착'
	declare @ts3					varchar(40)			set @ts3				=  '미장착'
	declare @ts4					varchar(40)			set @ts4				=  '미장착'
	declare @ts5					varchar(40)			set @ts5				=  '미장착'

	-- 유저배틀 로고수집용.
	declare @category				int					set @category			= -1
	declare @idx2					int					set @idx2				= 0
	declare @kakaonickname			varchar(40)			set @kakaonickname		= ''

	declare @category1				int					set @category1			= -1
	declare @aniitemcode1			int					set @aniitemcode1		= -1
	declare @upcnt1					int					set @upcnt1				= 0
	declare @attstem1				int					set @attstem1			= 0
	declare @defstem1				int					set @defstem1			= 0
	declare @hpstem1				int					set @hpstem1			= 0
	declare @timestem1				int					set @timestem1			= 0

	declare @category2				int					set @category2			= -1
	declare @aniitemcode2			int					set @aniitemcode2		= -1
	declare @upcnt2					int					set @upcnt2				= 0
	declare @attstem2				int					set @attstem2			= 0
	declare @defstem2				int					set @defstem2			= 0
	declare @hpstem2				int                 set @hpstem2			= 0
	declare @timestem2				int				    set @timestem2			= 0

	declare @category3				int					set @category3			= -1
	declare @aniitemcode3			int					set @aniitemcode3		= -1
	declare @upcnt3					int					set @upcnt3				= 0
	declare @attstem3				int					set @attstem3			= 0
	declare @defstem3				int					set @defstem3			= 0
	declare @hpstem3				int					set @hpstem3			= 0
	declare @timestem3				int					set @timestem3			= 0

	declare @treasure1				int					set @treasure1			= -1
	declare @treasure2				int				    set @treasure2			= -1
	declare @treasure3				int				    set @treasure3			= -1
	declare @treasure4				int					set @treasure4			= -1
	declare @treasure5				int				    set @treasure5			= -1
	declare @treasureupgrade1		int				    set @treasureupgrade1	= 0
	declare @treasureupgrade2		int					set @treasureupgrade2	= 0
	declare @treasureupgrade3		int				    set @treasureupgrade3	= 0
	declare @treasureupgrade4		int				    set @treasureupgrade4	= 0
	declare @treasureupgrade5		int					set @treasureupgrade5	= 0

	-- 검색유저.
	declare @otheridx				int					set @otheridx			= -1
	declare @othergameid			varchar(20)			set @othergameid		= ''
	declare @othernickname			varchar(40)			set @othernickname		= ''
	declare @othertrophy			int					set @othertrophy		= 0
	declare @othertier				int					set @othertier			= 1
	declare @otherinterval			int					set @otherinterval		= 10
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG 입력정보', @gameid_ gameid_, @password_ password_, @listset_ listset_

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	select
		@kakaonickname	= kakaonickname,
		@gameid 		= gameid,			@market			= market,
		@trophy			= trophy,			@tier			= tier,				@boxrotidx	= boxrotidx,
		@tslistidx1 	= tslistidx1,		@tslistidx2 = tslistidx2,			@tslistidx3 = tslistidx3,			@tslistidx4 = tslistidx4,		@tslistidx5 = tslistidx5
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 유저정보', @gameid gameid


	------------------------------------------------
	-- 3-3. 각 조건별 분기
	------------------------------------------------
	if( @gameid = '' )
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR 아이디가 존재하지 않는다.'
			--select 'DEBUG ' + @comment
		END
	else if ( @listset_ = '' or LEN(@listset_) < 4 )
		BEGIN
			set @nResult_ = @RESULT_ERROR_LISTIDX_NOT_FOUND
			set @comment = 'ERROR 해당 리스트를 찾을수 없습니다.(2)'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 준비했습니다.'
			--select 'DEBUG ' + @comment

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
					set @category		= -1
					set @upcnt			= 0
					set @upstep			= 0
					set @aniitemcode 	= -1
					set @aniitemname	= ''
					set @grade			= 0
					set @attstem100		= 0
					set @defstem100		= 0
					set @hpstem100		= 0
					set @timestem100	= 0

					select
						@category		= category,
						@upcnt			= upcnt,
						@upstep			= upstep,
						@aniitemcode 	= itemcode,
						@aniitemname	= itemname2,
						@grade			= grade,
						@attstem100		= attstem100,
						@defstem100 	= defstem100,
						@hpstem100 		= hpstem100,
						@timestem100 	= timestem100,
						@att			= attbase	+ attconst * upcnt / upstep  + attstem100 / 100,
						@time			= timebase	+ timeconst * upcnt / upstep  + timestem100 / 100,
						@def			= defbase	+ defconst * upcnt / upstep  + defstem100 / 100,
						@hp				= hpbase	+ hpconst * upcnt / upstep  + hpstem100 / 100
					from
					( select category, itemcode itemcode2, itemname itemname2, grade, param20 fresconst, param21 attbase, param22 attconst, param23 timebase, param24 timeconst, param25 defbase, param26 defconst, param27 hpbase, param28 hpconst, param29 upstep
					from dbo.tItemInfo
					where itemcode = ( select itemcode from dbo.tUserItem where gameid = @gameid_ and listidx = @info ) ) a
					JOIN
					(select itemcode, upcnt, attstem100, timestem100, defstem100, hpstem100 from dbo.tUserItem where gameid = @gameid_ and listidx = @info) b
					ON a.itemcode2 = b.itemcode

					--select 'DEBUG 시간값', @loop loop, @aniitemcode aniitemcode, @upcnt upcnt, @att att,  @time time,  @def def,  @hp hp
					set @time = @DEFINE_TIME_BASE / (100 + @time/3) * 100
					--select 'DEBUG 시간', @loop loop, @aniitemcode aniitemcode, @grade grade, @upcnt upcnt, @att att,  @time time,  @def def,  @hp hp

					---------------------------------
					-- 동물세팅.
					---------------------------------
					if(@aniitemcode != -1)
						begin
							if(@loop = 1)
								begin
									set @userbattleanilistidx1	= @info
									set @anidesc1		= @aniitemname+ '(' + ltrim(str(@aniitemcode)) + ')'
															+ ' 등급(' + ltrim(str(@grade)) + ')'
															+ ' ' + case when @upstep != 0 then (ltrim(str(@upcnt/@upstep + 1)) + 'lv' ) else '' end
															+ ' ' + (ltrim(str(@upcnt)) + '강')
															+ ' att:' + ltrim(str(@att))
															+ ' def:' + ltrim(str(@def))
															+ ' hp:' + ltrim(str(@hp))
															+ ' time:' + ltrim(str(@time))

									set @category1		= @category
									set @aniitemcode1	= @aniitemcode
									set @upcnt1			= @upcnt
									set @attstem1 		= @attstem100
									set @defstem1		= @defstem100
									set @hpstem1		= @hpstem100
									set @timestem1		= @timestem100
								end
							else if(@loop = 2)
								begin
									set @userbattleanilistidx2	= @info
									set @anidesc2		= @aniitemname+ '(' + ltrim(str(@aniitemcode)) + ')'
															+ ' 등급(' + ltrim(str(@grade)) + ')'
															+ ' ' + case when @upstep != 0 then (ltrim(str(@upcnt/@upstep + 1)) + 'lv' ) else '' end
															+ ' ' + (ltrim(str(@upcnt)) + '강')
															+ ' att:' + ltrim(str(@att))
															+ ' def:' + ltrim(str(@def))
															+ ' hp:' + ltrim(str(@hp))
															+ ' time:' + ltrim(str(@time))

									set @category2		= @category
									set @aniitemcode2	= @aniitemcode
									set @upcnt2			= @upcnt
									set @attstem2 		= @attstem100
									set @defstem2		= @defstem100
									set @hpstem2		= @hpstem100
									set @timestem2		= @timestem100
								end
							else if(@loop = 3)
								begin
									set @userbattleanilistidx3	= @info
									set @anidesc3		= @aniitemname+ '(' + ltrim(str(@aniitemcode)) + ')'
															+ ' 등급(' + ltrim(str(@grade)) + ')'
															+ ' ' + case when @upstep != 0 then (ltrim(str(@upcnt/@upstep + 1)) + 'lv' ) else '' end
															+ ' ' + (ltrim(str(@upcnt)) + '강')
															+ ' att:' + ltrim(str(@att))
															+ ' def:' + ltrim(str(@def))
															+ ' hp:' + ltrim(str(@hp))
															+ ' time:' + ltrim(str(@time))

									set @category3		= @category
									set @aniitemcode3	= @aniitemcode
									set @upcnt3			= @upcnt
									set @attstem3 		= @attstem100
									set @defstem3		= @defstem100
									set @hpstem3		= @hpstem100
									set @timestem3		= @timestem100
								end
						end


					set @loop = @loop + 1
					Fetch next from curUpgradeInfo into @kind, @info
				end
			-- 4. 커서닫기
			close curUpgradeInfo
			Deallocate curUpgradeInfo
			--select 'DEBUG ', @userbattleanilistidx1 userbattleanilistidx1, @userbattleanilistidx2 userbattleanilistidx2, @userbattleanilistidx3 userbattleanilistidx3

			---------------------------------------------
			-- 보물능력치계산.
			-- 내보물 로고용~~~
			---------------------------------------------
			if( @tslistidx1 != -1 )
				begin
					select
						@tsitemcode		= itemcode,
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

					set @treasure1 			= @tsitemcode
					set @treasureupgrade1	= @tsupgrade
				end

			if( @tslistidx2 != -1 )
				begin
					select
						@tsitemcode		= itemcode,
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

					set @treasure2 			= @tsitemcode
					set @treasureupgrade2	= @tsupgrade
				end

			if( @tslistidx3 != -1 )
				begin
					select
						@tsitemcode		= itemcode,
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

					set @treasure3 			= @tsitemcode
					set @treasureupgrade3	= @tsupgrade
				end

			if( @tslistidx4 != -1 )
				begin
					select
						@tsitemcode		= itemcode,
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

					set @treasure4 			= @tsitemcode
					set @treasureupgrade4	= @tsupgrade
				end

			if( @tslistidx5 != -1 )
				begin
					select
						@tsitemcode		= itemcode,
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

					set @treasure5 			= @tsitemcode
					set @treasureupgrade5	= @tsupgrade
				end



			---------------------------------------------
			-- 기록마킹
			---------------------------------------------
			update dbo.tUserMaster
				set
					userbattleanilistidx1	= @userbattleanilistidx1,
					userbattleanilistidx2	= @userbattleanilistidx2,
					userbattleanilistidx3	= @userbattleanilistidx3,
					userbattleflag			= @BATTLE_READY
			where gameid = @gameid_

			--------------------------------------------------------------
			-- 상대 유저 보유 아이템 정보
			-- > 새로 획득한 것만 전송(기존것 하고 같이 보내면 클라것의 데이터를 덮씌워서 문제됨)
			-- 자신이 검색한 유저 로고는 패스한다.
			--------------------------------------------------------------
			set @otherinterval = 2
			while( @otheridx = -1 )
				begin
					select top 1
						@otheridx		= idx,
						@othergameid 	= gameid,	@othernickname 	= kakaonickname,
						@othertrophy 	= trophy,	@othertier 		= tier
					from dbo.tUserBattleBank
					where gameid != @gameid_
						  and gameid not in ( select othergameid from dbo.tUserBattleSearchLog where gameid = @gameid )
						  and ( trophy >= @trophy - @otherinterval )
						  and ( trophy <= @trophy + @otherinterval )
						  order by newid()
					--select 'DEBUG', @otherinterval otherinterval, @otheridx otheridx, @othergameid othergameid, @othernickname othernickname, @othertrophy othertrophy, @othertier othertier

					if( @otheridx != -1)
						begin
							break;
						end
					else
						begin
							set @otherinterval = @otherinterval + 10
						end
				end

			---------------------------------------------
			-- 로고 데이타 기록 (유지)
			-- 검색한 유저 다시 만날때는 몇번의 회전후에 본다.
			---------------------------------------------
			set @idx2 	= 1
			select @idx2 = isnull( max( idx2 ), 0 ) + 1 from dbo.tUserBattleSearchLog where gameid = @gameid_
			insert into dbo.tUserBattleSearchLog(idx2,  gameid,  othergameid)
			values(								@idx2, @gameid, @othergameid)
			-- 일정수량 이상은 삭제.
			if(@idx2 - @USER_SEARCH_LOOPMAX > 0)
				begin
					delete from dbo.tUserBattleSearchLog where gameid = @gameid_ and idx2 < @idx2 - @USER_BANK_MAX
				end


			---------------------------------------------
			-- 유저배틀 기록마킹
			---------------------------------------------
			set @userbattleidx2 = 1
			select @userbattleidx2 = isnull( max( idx2 ), 0 ) + 1 from dbo.tUserBattleLog where gameid = @gameid_
			--select 'DEBUG ', @userbattleidx2 userbattleidx2
			insert into dbo.tUserBattleLog(gameid,     idx2,	trophy, 	tier,
											anidesc1,  anidesc2,  anidesc3,
											ts1name,  ts2name,   ts3name,   ts4name,  ts5name,
											othergameid, othernickname, othertrophy, othertier, otheridx
											)
			values(					  		@gameid_,   @userbattleidx2,	@trophy, 	@tier,
											@anidesc1,  @anidesc2, @anidesc3,
											@ts1, @ts2, @ts3, @ts4, @ts5,
											@othergameid, @othernickname, @othertrophy, @othertier, @otheridx
											)

			-- 일정수량 이상은 삭제.
			if(@userbattleidx2 - @USER_LOG_MAX > 0)
				begin
					delete from dbo.tUserBattleLog where gameid = @gameid_ and idx2 < @userbattleidx2 - @USER_LOG_MAX
				end

			---------------------------------------------
			-- 유저배틀 로고용.
			---------------------------------------------
			--select 'DEBUG 유저배틀 데이타기록', @category1 category1, @category2 category2, @category3 category3
			if( @category1 in (1, -1) and @category2 in (1, -1) and @category3 in (1, -1) )
				begin
					--select 'DEBUG > 기록'
					---------------------------------------------------
					-- 1단계	: 동물, grade -> trophy그룹설정.
					--			  @trophy	= trophy,
					-- 2단계 	: tier당 100개정도 로고를 작성해둔다.
					--
					---------------------------------------------------
					set @idx2 	= 1
					select @idx2 = isnull( max( idx2 ), 0 ) + 1 from dbo.tUserBattleBank where gameid = @gameid_ and trophy = @trophy

					insert into dbo.tUserBattleBank(idx2, gameid, kakaonickname, trophy, tier,
													aniitemcode1, upcnt1, attstem1, defstem1, hpstem1, timestem1,
													aniitemcode2, upcnt2, attstem2, defstem2, hpstem2, timestem2,
													aniitemcode3, upcnt3, attstem3, defstem3, hpstem3, timestem3,
													treasure1, treasure2, treasure3, treasure4, treasure5,
													treasureupgrade1, treasureupgrade2, treasureupgrade3, treasureupgrade4, treasureupgrade5)
					values(							@idx2, @gameid, @kakaonickname, @trophy, @tier,
													@aniitemcode1, @upcnt1, @attstem1, @defstem1, @hpstem1, @timestem1,
													@aniitemcode2, @upcnt2, @attstem2, @defstem2, @hpstem2, @timestem2,
													@aniitemcode3, @upcnt3, @attstem3, @defstem3, @hpstem3, @timestem3,
													@treasure1, @treasure2, @treasure3, @treasure4, @treasure5,
													@treasureupgrade1, @treasureupgrade2, @treasureupgrade3, @treasureupgrade4, @treasureupgrade5)

					-- 일정수량 이상은 삭제.
					if(@idx2 - @USER_BANK_MAX > 0)
						begin
							delete from dbo.tUserBattleBank where gameid = @gameid_ and trophy = @trophy and idx2 < @idx2 - @USER_BANK_MAX
						end
				end

			------------------------------------------------
			-- 통계정보.
			------------------------------------------------
			exec spu_DayLogInfoStatic @market, 34, 1				-- 일 유저배틀수.
		END


	--------------------------------------------------------------
	-- 결과전송.
	--------------------------------------------------------------
	select @nResult_ rtn, @comment comment, @userbattleidx2 userbattleidx2
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			--------------------------------------------------------------
			-- 유저 보유 아이템 정보 > 새로 획득한 것만 전송(기존것 하고 같이 보내면 클라것의 데이터를 덮씌워서 문제됨)
			--------------------------------------------------------------
			if( @boxrotidx < 0 )
				begin
					if( @boxrotidx <= -4 )
						begin
							set @aniitemcode1 = 1 set @aniitemcode2 = 1	set @aniitemcode3 = 1
						end
					else if( @boxrotidx <= -3 )
						begin
							set @aniitemcode1 = 2 set @aniitemcode2 = 1	set @aniitemcode3 = 1
						end
					else if( @boxrotidx <= -2 )
						begin
							set @aniitemcode1 = 2 set @aniitemcode2 = 2	set @aniitemcode3 = 2
						end
					else
						begin
							set @aniitemcode1 = 3 set @aniitemcode2 = 1	set @aniitemcode3 = 1
						end

					select '짜요 가이드 배틀' kakaonickname, 0 trophy, 1 tier,
							@aniitemcode1 aniitemcode1, 0 upcnt1, 0 attstem1, 0 defstem1, 0 hpstem1, 0 timestem1,
							@aniitemcode2 aniitemcode2, 0 upcnt2, 0 attstem2, 0 defstem2, 0 hpstem2, 0 timestem2,
							@aniitemcode3 aniitemcode3, 0 upcnt3, 0 attstem3, 0 defstem3, 0 hpstem3, 0 timestem3,
							120011 treasure1, 0 treasureupgrade1,
							120021 treasure2, 0 treasureupgrade2,
							120031 treasure3, 0 treasureupgrade3,
							-1 treasure4, 0 treasureupgrade4,
							-1 treasure5, 0 treasureupgrade5

				end
			else
				begin
					select top 1 * from dbo.tUserBattleBank where idx = @otheridx
				end
		end

	------------------------------------------------
	--	4-2. 유저정보
	------------------------------------------------
	set nocount off
End

