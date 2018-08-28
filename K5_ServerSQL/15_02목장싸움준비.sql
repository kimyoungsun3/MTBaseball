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
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_AniBattleStart
	@gameid_								varchar(20),					-- ���Ӿ��̵�
	@password_								varchar(20),
	@farmidx_								int,
	@listset_								varchar(256),
	@nResult_								int					OUTPUT
	--WITH ENCRYPTION -- ���ν����� ��ȣȭ��.
as
	------------------------------------------------
	--	2-1. �ڵ尪�ڸ�
	------------------------------------------------
	-- �Ϲݰ�
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	-- �α��� ����.
	declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--������ > �˾�ó���� ��Ʈ�η� ��������.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--�ش������� ã�� ����

	-- ��Ÿ����
	declare @RESULT_ERROR_INVEN_FULL			int				set @RESULT_ERROR_INVEN_FULL			= -101			-- �κ�����
	declare @RESULT_ERROR_LISTIDX_NOT_FOUND		int				set @RESULT_ERROR_LISTIDX_NOT_FOUND		= -114			-- ����Ʈ ��ȣ�� ��ã��.
	declare @RESULT_ERROR_NOT_FOUND_USERFARM	int				set @RESULT_ERROR_NOT_FOUND_USERFARM	= -125			-- ���帮��Ʈ�� �̱���.
	declare @RESULT_ERROR_NOT_CLEAR_BEFORE_FARM	int				set @RESULT_ERROR_NOT_CLEAR_BEFORE_FARM	= -149			-- ���嵵���Ұ�.
	declare @RESULT_ERROR_TICKET_LACK			int				set @RESULT_ERROR_TICKET_LACK			= -150			-- Ƽ�ϼ�������.
	declare @RESULT_ERROR_PLAY_COUNT_ZERO		int				set @RESULT_ERROR_PLAY_COUNT_ZERO		= -151			-- �÷��� Ƚ���� �����ϴ�.
	------------------------------------------------
	--	2-2. ���°�
	------------------------------------------------
	-- �����ۺ� �κ��з�
	declare @USERITEM_INVENKIND_STEMCELL		int 				set @USERITEM_INVENKIND_STEMCELL			= 1040

	-- ����(����).
	declare @USERFARM_BUYSTATE_NOBUY			int					set @USERFARM_BUYSTATE_NOBUY				= -1	-- (����)
	declare @USERFARM_BUYSTATE_BUY				int					set @USERFARM_BUYSTATE_BUY					=  1

	-- �������.
	declare @BATTLE_RESULT_WIN					int					set @BATTLE_RESULT_WIN				=  1	-- (����)
	declare @BATTLE_RESULT_LOSE					int					set @BATTLE_RESULT_LOSE				= -1
	declare @BATTLE_RESULT_DRAW					int					set @BATTLE_RESULT_DRAW				=  0

	-- �÷�������.
	declare @BATTLE_END							int					set @BATTLE_END						= 0
	declare @BATTLE_READY						int					set @BATTLE_READY					= 1

	declare @DEFINE_TIME_BASE					int					set @DEFINE_TIME_BASE				= 8000 -- 8��
	--declare @USER_LOG_MAX						int					set @USER_LOG_MAX 					= 50	-- 12���� * 40��.
	declare @USER_LOG_MAX						int					set @USER_LOG_MAX 					= 50	-- �׽�Ʈ��.

	------------------------------------------------
	--	2-3. ���λ�� ����
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

	-- ����.
	declare @aniitemcode			int					set @aniitemcode		= -1
	declare @aniitemname			varchar(40)			set @aniitemname		= ''
	declare @grade					int					set @grade				=  0
	declare @upcnt					int					set @upcnt				=  0
	declare @upstep					int					set @upstep				=  0
	declare @att					int					set @att				=  0
	declare @time					int					set @time				=  0
	declare @def					int					set @def				=  0
	declare @hp						int					set @hp					=  0

	declare @anidesc1				varchar(120)		set @anidesc1			= '����'
	declare @anidesc2				varchar(120)		set @anidesc2			= '����'
	declare @anidesc3				varchar(120)		set @anidesc3			= '����'

	-- ����.
	declare @tslistidx1				int					set @tslistidx1			= -1
	declare @tslistidx2				int					set @tslistidx2			= -1
	declare @tslistidx3				int					set @tslistidx3			= -1
	declare @tslistidx4				int					set @tslistidx4			= -1
	declare @tslistidx5				int					set @tslistidx5			= -1

	declare @tsitemname				varchar(40)			set @tsitemname			= ''
	declare @tsupgrade				int					set @tsupgrade			=  0
	declare @tsvalue				int					set @tsvalue			=  0

	declare @ts1					varchar(40)			set @ts1				=  '������'
	declare @ts2					varchar(40)			set @ts2				=  '������'
	declare @ts3					varchar(40)			set @ts3				=  '������'
	declare @ts4					varchar(40)			set @ts4				=  '������'
	declare @ts5					varchar(40)			set @ts5				=  '������'

	-- ������.
	declare @enemydesc				varchar(120)		set @enemydesc			=  ''
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG �Է�����', @gameid_ gameid_, @password_ password_, @farmidx_ farmidx_, @listset_ listset_

	------------------------------------------------
	--	3-2. �������
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
	--select 'DEBUG ��������', @gameid gameid, @battlefarmidx battlefarmidx, @goldticket goldticket, @battleticket battleticket

	select
		@buystate		= buystate,		@playcnt		= playcnt
	from dbo.tUserFarm
	where gameid = @gameid_ and itemcode = @farmidx_
	--select 'DEBUG ���� ��������', @farmidx_ farmidx_, @buystate buystate, @playcnt playcnt

	select
		@needticket	= param14,

		@enemyani	= param16,
		@enemylv	= param17,
		@enemycnt	= param18,
		@stagecnt	= param19,
		@enemyboss	= param20
	from dbo.tItemInfo
	where itemcode = @farmidx_
	--select 'DEBUG �ʿ��������.', @farmidx_ farmidx_, @needticket needticket

	if(@gameid != '')
		begin
			------------------------------------------------
			-- Ƽ�� ���� ����.
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
			-- �ٱ⼼���� ����.
			------------------------------------------------
			select @cnt = count(*) from dbo.tUserItem
			where gameid = @gameid_ and invenkind = @USERITEM_INVENKIND_STEMCELL

		end

	------------------------------------------------
	-- 3-3. �� ���Ǻ� �б�
	------------------------------------------------
	if( @gameid = '' )
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR ���̵� �������� �ʴ´�.'
			--select 'DEBUG ' + @comment
		END
	else if(@buystate != @USERFARM_BUYSTATE_BUY)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_USERFARM
			set @comment 	= 'ERROR ������ �����ϰ� ���� �ʴ�.'
			--select 'DEBUG ' + @comment
		END
	else if ( @farmidx_ > @battlefarmidx + 1 )
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_CLEAR_BEFORE_FARM
			set @comment 	= 'ERROR �������� Ŭ�����ϼ���.'
			--select 'DEBUG ' + @comment
		END
	else if(@needticket > @battleticket)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_TICKET_LACK
			set @comment 	= 'ERROR Ƽ�ϼ����� �����մϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if(@playcnt <= 0)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_PLAY_COUNT_ZERO
			set @comment 	= 'ERROR ���� �÷��� Ƚ���� �����ϴ�..'
			--select 'DEBUG ' + @comment
		END
	else if(@cnt >= @invenstemcellmax)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_INVEN_FULL
			set @comment 	= 'ERROR ���� �κ��� Ǯ�Դϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if ( @listset_ = '' or LEN(@listset_) < 4 )
		BEGIN
			set @nResult_ = @RESULT_ERROR_LISTIDX_NOT_FOUND
			set @comment = 'ERROR �ش� ����Ʈ�� ã���� �����ϴ�.(1)'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS �غ��߽��ϴ�.'
			----select 'DEBUG ' + @comment

			set @loop	= 1
			------------------------------------------------------------------
			-- ��������.
			-- ������ �ΰ��~~~
			------------------------------------------------------------------
			-- 1. Ŀ�� ����
			declare curUpgradeInfo Cursor for
			select * FROM dbo.fnu_SplitTwo(';', ':', @listset_)

			-- 2. Ŀ������
			open curUpgradeInfo

			-- 3. Ŀ�� ���
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

					--select 'DEBUG �ð���', @loop loop, @aniitemcode aniitemcode, @upcnt upcnt, @att att,  @time time,  @def def,  @hp hp
					set @time = @DEFINE_TIME_BASE / (100 + @time/3) * 100
					--select 'DEBUG �ð�', @loop loop, @aniitemcode aniitemcode, @aniitemname aniitemname, @grade grade, @upcnt upcnt, @att att,  @time time,  @def def,  @hp hp


					if(@aniitemcode != -1)
						begin
							if(@loop = 1)
								begin
									set @battleanilistidx1	= @info
									set @anidesc1		= @aniitemname+ '(' + ltrim(str(@aniitemcode)) + ')'
															+ ' ���(' + ltrim(str(@grade)) + ')'
															+ ' ' + case when @upstep != 0 then (ltrim(str(@upcnt/@upstep + 1)) + 'lv' ) else '' end
															+ ' ' + (ltrim(str(@upcnt)) + '��')
															+ ' att:' + ltrim(str(@att))
															+ ' def:' + ltrim(str(@def))
															+ ' hp:' + ltrim(str(@hp))
															+ ' time:' + ltrim(str(@time))
								end
							else if(@loop = 2)
								begin
									set @battleanilistidx2	= @info
									set @anidesc2		= @aniitemname+ '(' + ltrim(str(@aniitemcode)) + ')'
															+ ' ���(' + ltrim(str(@grade)) + ')'
															+ ' ' + case when @upstep != 0 then (ltrim(str(@upcnt/@upstep + 1)) + 'lv' ) else '' end
															+ ' ' + (ltrim(str(@upcnt)) + '��')
															+ ' att:' + ltrim(str(@att))
															+ ' def:' + ltrim(str(@def))
															+ ' hp:' + ltrim(str(@hp))
															+ ' time:' + ltrim(str(@time))
								end
							else if(@loop = 3)
								begin
									set @battleanilistidx3	= @info
									set @anidesc3		= @aniitemname+ '(' + ltrim(str(@aniitemcode)) + ')'
															+ ' ���(' + ltrim(str(@grade)) + ')'
															+ ' ' + case when @upstep != 0 then (ltrim(str(@upcnt/@upstep + 1)) + 'lv' ) else '' end
															+ ' ' + (ltrim(str(@upcnt)) + '��')
															+ ' att:' + ltrim(str(@att))
															+ ' def:' + ltrim(str(@def))
															+ ' hp:' + ltrim(str(@hp))
															+ ' time:' + ltrim(str(@time))
								end
						end


					set @loop = @loop + 1
					Fetch next from curUpgradeInfo into @kind, @info
				end
			-- 4. Ŀ���ݱ�
			close curUpgradeInfo
			Deallocate curUpgradeInfo
			--select 'DEBUG ', @battleanilistidx1 battleanilistidx1, @battleanilistidx2 battleanilistidx2, @battleanilistidx3 battleanilistidx3

			---------------------------------------------
			-- �����ɷ�ġ���.
			-- ������ �ΰ��~~~
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

					set @ts1 = @tsitemname + ' ' + ltrim(str(@tsupgrade)) + '�� ' + ltrim(str(@tsvalue))
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

					set @ts2 = @tsitemname + ' ' + ltrim(str(@tsupgrade)) + '�� ' + ltrim(str(@tsvalue))
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

					set @ts3 = @tsitemname + ' ' + ltrim(str(@tsupgrade)) + '�� ' + ltrim(str(@tsvalue))
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

					set @ts4 = @tsitemname + ' ' + ltrim(str(@tsupgrade)) + '�� ' + ltrim(str(@tsvalue))
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

					set @ts5 = @tsitemname + ' ' + ltrim(str(@tsupgrade)) + '�� ' + ltrim(str(@tsvalue))
				end

			---------------------------------------------
			-- ���ɷ�ġ���.
			---------------------------------------------
			set @enemydesc =
							' ����:'
							+ case
									when @enemyani = 4 then '��'
									when @enemyani = 2 then '��'
									when @enemyani = 1 then '���'
									when @enemyani = 6 then '��/��'
									when @enemyani = 5 then '��/���'
									when @enemyani = 3 then '��/���'
									when @enemyani = 7 then '��/��/���'
									else					 '��'
							  end
							+ ' ����:' 	+  ltrim(str(@enemylv))
							+ ' att:' 	+ ltrim(str(13 * @enemylv + 10))
							+ ' time:' 	+ ltrim(str(11000 / (100  + @enemylv*4) * 100))
							+ ' DEF:' 	+ ltrim(str(50 + (@enemylv - 2)* 10))
							+ ' HP:' 	+ ltrim(str(100 + (@enemylv - 2)* 12))
							+ ' ����:' + ltrim(str(@enemycnt)) + '/' + ltrim(str(@stagecnt))
							+ ' BOSS:'
								+ case
										when @enemyboss = 0 then '����(0)'
										when @enemyboss = 1 then '����Att(1)'
										when @enemyboss = 2 then '����Def(2)'
										when @enemyboss = 3 then '����HP(3)'
										when @enemyboss = 4 then '����Turn(4)'
										when @enemyboss = 11 then '����AD(11)'
										when @enemyboss = 12 then '����ah(12)'
										when @enemyboss = 13 then '����at(13)'
										when @enemyboss = 14 then '����dh(14)'
										when @enemyboss = 15 then '����dt(15)'
										when @enemyboss = 16 then '����ht(16)'
										when @enemyboss = 21 then '����adh(21)'
										when @enemyboss = 22 then '����adt(22)'
										when @enemyboss = 23 then '����aht(23)'
										when @enemyboss = 24 then '����dht(24)'
										when @enemyboss = 31 then '����adht(31)'
										else					 '��'
								  end

			---------------------------------------------
			-- ��ƲƼ�� ��뷮 ����.
			---------------------------------------------
			set @battleticket = @battleticket - @needticket

			---------------------------------------------
			-- ��ϸ�ŷ
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
			-- ��ƲȽ������.
			---------------------------------------------
			--update dbo.tUserFarm
			--	set
			--		playcnt = playcnt - 1
			--where gameid = @gameid_ and itemcode = @farmidx_


			---------------------------------------------
			-- ��ϸ�ŷ
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

			-- �������� �̻��� ����.
			if(@battleidx2 - @USER_LOG_MAX > 0)
				begin
					delete from dbo.tBattleLog where gameid = @gameid_ and idx2 < @battleidx2 - @USER_LOG_MAX
				end

			------------------------------------------------
			-- �������.
			------------------------------------------------
			exec spu_DayLogInfoStatic @market, 32, 1			-- �� ��Ʋ��.
		END


	--------------------------------------------------------------
	-- �������.
	--------------------------------------------------------------
	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost, @heart heart, @feed feed, @fpoint fpoint, @goldticket goldticket, @battleticket battleticket, @goldtickettime goldtickettime, @battletickettime battletickettime, @battleidx2 battleidx2, @goldticketmax goldticketmax, @battleticketmax battleticketmax,
		   @enemylv enemylv, @enemycnt enemycnt, @stagecnt stagecnt, @enemyani enemyani, @enemyboss enemyboss



	------------------------------------------------
	--	4-2. ��������
	------------------------------------------------
	set nocount off
End

