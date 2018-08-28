/*
exec spu_SchoolRank  1, -1, ''			-- ���� �б�����       (           �б�����                  )					--										50_01���˻�
exec spu_SchoolRank  4, -1, 'xxxx2'		-- ���� �б�����       (           �б����� + MY(������)     )					-- 13_02���Ӱŷ�	23_01�б�������
exec spu_SchoolRank  4, -1, 'guest90909'-- ���� �б�����       (           �б����� + MY(�̰�����)   )					-- 13_02���Ӱŷ�	23_01�б�������
exec spu_SchoolRank  6, -1, 'xxxx2'     -- ���� �б�����       (           �б����� + MY(����)		 )					-- 13_02���Ӱŷ�
exec spu_SchoolRank  2, 6607, ''		-- ���� �б��� ��������(           �б���ȣ > �б��ο��� ����) > Web���� ���	--										50_01���˻�
exec spu_SchoolRank  3, -1, 'xxxx2'		-- ���� �б��� ��������(�����̸� > �б���ȣ > �б��ο��� ����)					--										50_01���˻�
exec spu_SchoolRank  5, -1, 'xxxx2'		-- ���� �б��� ��������(�����̸� > �б���ȣ > �б��ο��� ���� + MY)				--					23_01�б�������
exec spu_SchoolRank  7, 6607, ''		-- ���� �б��� ��������(           �б���ȣ > �б��ο��� ����) > ���ӿ��� ���	-- 13_02���Ӱŷ�	23_01�б�������
exec spu_SchoolRank  7, -1, ''			-- ���� �б��� ��������(           �б���ȣ > �б��ο��� ����) > ����			-- 13_02���Ӱŷ�	23_01�б�������

exec spu_SchoolRank 11, -1, 'xxxx2'		-- ���� �б���ŷ(�б� + ���Ҽ�) > LOGIN											-- 04_01�α���
exec spu_SchoolRank 11, -1, 'xxxx2'	--																				-- 04_01�α���
-- select * from dbo.tEpiReward where gameid = 'guest198' order by idx asc
-- exec spu_Login 'guest198', '3023677g3i8n7l492451', 1, 101, '', '', -1, -1			-- ��������


exec spu_SchoolRank 20, -1, ''			-- ���� ��¥����Ʈ.																--										50_01���˻�
exec spu_SchoolRank 22, -1, '20140523'	-- ���� ������ ��¥ �б����� (20131227�� �б� ��ŷ)								--										50_01���˻�
exec spu_SchoolRank 23,  1, '20140523'	-- ���� ������ ��¥ �б����� > ���� ��ŷ										--										50_01���˻�
*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_SchoolRank', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_SchoolRank;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_SchoolRank
	@mode_									int,
	@paramint_								int,
	@paramstr_								varchar(256)
	--WITH ENCRYPTION -- ���ν����� ��ȣȭ��.
as
	------------------------------------------------
	--	2-2. ���°�
	------------------------------------------------
	-- �б������� ��ŷ���.
	declare @SCHOOLRANK_CURRENT_SCHOOLRANK		int				set @SCHOOLRANK_CURRENT_SCHOOLRANK		= 1			-- 										50_01���˻�
	declare @SCHOOLRANK_CURRENT_SCHOOLRANK_MY	int				set @SCHOOLRANK_CURRENT_SCHOOLRANK_MY	= 4			-- 13_02���Ӱŷ�	23_01�б�������
	declare @SCHOOLRANK_CURRENT_SCHOOLRANK_MY2	int				set @SCHOOLRANK_CURRENT_SCHOOLRANK_MY2	= 6			-- 13_02���Ӱŷ�
	declare @SCHOOLRANK_CURRENT_USERRANK		int				set @SCHOOLRANK_CURRENT_USERRANK		= 2			--										50_01���˻�
	declare @SCHOOLRANK_CURRENT_USERRANK_NAME	int				set @SCHOOLRANK_CURRENT_USERRANK_NAME	= 3			--										50_01���˻�
	declare @SCHOOLRANK_CURRENT_USERRANK_GAMEID	int				set @SCHOOLRANK_CURRENT_USERRANK_GAMEID	= 5			--					23_01�б�������
	declare @SCHOOLRANK_CURRENT_USERRANK_SCHOOLIDX	int			set @SCHOOLRANK_CURRENT_USERRANK_SCHOOLIDX	= 7		-- 13_02���Ӱŷ�	23_01�б�������

	declare @SCHOOLRANK_RECENTLY_SCHOOLRANK		int				set @SCHOOLRANK_RECENTLY_SCHOOLRANK		= 11		-- 04_01�α���

	declare @SCHOOLRANK_LASTWEEK_DATE			int				set @SCHOOLRANK_LASTWEEK_DATE			= 20		--										50_01���˻�
	declare @SCHOOLRANK_LASTWEEK_SCHOOLRANK		int				set @SCHOOLRANK_LASTWEEK_SCHOOLRANK		= 22		--										50_01���˻�
	declare @SCHOOLRANK_LASTWEEK_USERRANK		int				set @SCHOOLRANK_LASTWEEK_USERRANK		= 23		--										50_01���˻�


	------------------------------------------------
	--	2-3. ���λ�� ����
	------------------------------------------------
	declare @schoolname		varchar(128)
	declare @gameid			varchar(20)
	declare @dateid			varchar(40)
	declare @schoolidx		int						set @schoolidx		= -1
	declare @totalpoint		bigint					set @totalpoint		= 0
	declare @point			int						set @point			= 0
	declare @cnt			int						set @cnt			= -1
	declare @schoolrank		int						set @schoolrank		= -1
	declare @userrank		int						set @userrank		= -1
	declare @itemcode1		int						set @itemcode1		= -1
	declare @itemcode2		int						set @itemcode2		= -1
	declare @itemcode3		int						set @itemcode3		= -1


Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on

	if(@mode_ = @SCHOOLRANK_CURRENT_SCHOOLRANK)
		BEGIN
			-----------------------------------------
			-- ������ ������������ ���� ����
			--select 'DEBUG �ǽð� ��ü����'
			-----------------------------------------
			DECLARE @tTempTableCurrentMaster TABLE(
				schoolrank		int,
				schoolidx		int,
				cnt				int,
				totalpoint		bigint
			);

			-- ���� 10��
			insert into @tTempTableCurrentMaster
			select top 500 rank() over(order by totalpoint desc) schoolrank, schoolidx, cnt, totalpoint/100 from dbo.tSchoolMaster
			--where totalpoint > 0
			--order by totalpoint desc

			select * from
				@tTempTableCurrentMaster m
			JOIN
				(select * from dbo.tSchoolBank where schoolidx in (select schoolidx from @tTempTableCurrentMaster)) b
			ON
				m.schoolidx = b.schoolidx
			--order by schoolrank asc
		END
	else if(@mode_ = @SCHOOLRANK_CURRENT_SCHOOLRANK_MY)
		BEGIN

			-------------------------------
			-- �������� �о����.
			-------------------------------
			set @gameid		= @paramstr_
			set @totalpoint	= 0
			select @schoolidx = schoolidx, @cnt = cnt, @totalpoint = totalpoint from dbo.tSchoolMaster
			where schoolidx = (select schoolidx from dbo.tUserMaster where gameid = @gameid)

			-----------------------------------------
			--select 'DEBUG ����10 + �ڽŷ�ŷ', @gameid gameid, @schoolidx schoolidx, @cnt cnt, @totalpoint totalpoint
			-----------------------------------------
			DECLARE @tTempTableCurrentMasterMy TABLE(
				schoolrank		int,
				schoolidx		int,
				cnt				int,
				totalpoint		bigint
			);

			-- ����10 + �ڽŷ�ŷ.
			insert into @tTempTableCurrentMasterMy
			select top 10 rank() over(order by totalpoint desc) schoolrank,  schoolidx, cnt, totalpoint/100 from dbo.tSchoolMaster
			union
			select count(schoolidx) + 1 as schoolrank, @schoolidx schoolidx, @cnt cnt, @totalpoint/100 totalpoint from dbo.tSchoolMaster where totalpoint > @totalpoint

			select m.*, b.schoolname, schoolarea, schoolkind from
				@tTempTableCurrentMasterMy m
			JOIN
				(select * from dbo.tSchoolBank where schoolidx in (select schoolidx from @tTempTableCurrentMasterMy)) b
			ON
				m.schoolidx = b.schoolidx
			--order by schoolrank asc
		END
	else if(@mode_ = @SCHOOLRANK_CURRENT_SCHOOLRANK_MY2)
		BEGIN
			DECLARE @tTempTableCurrentMasterMy2 TABLE(
				schoolrank		int,
				schoolidx		int,
				cnt				int,
				totalpoint		bigint,
				schoolname		varchar(128),
				schoolarea		varchar(128),
				schoolkind		int
			);
			select * from @tTempTableCurrentMasterMy2
		END
	else if (@mode_ = @SCHOOLRANK_CURRENT_USERRANK)
		BEGIN
			---------------------------------------------
			-- ������ ������������ ���� ����
			--select 'DEBUG ���� ���� �׷��ο��� �ǽð� ����'
			---------------------------------------------
			set @schoolidx = @paramint_
			select @schoolname = schoolname from dbo.tSchoolBank where schoolidx = @schoolidx

			select top 500 rank() over(order by point desc) userrank, @schoolname schoolname, * from dbo.tSchoolUser
			where schoolidx = @schoolidx and schoolidx != -1
			order by point desc

		END
	else if (@mode_ = @SCHOOLRANK_CURRENT_USERRANK_NAME)
		BEGIN
			---------------------------------------------
			-- ������ ������������ ���� ����
			--select 'DEBUG ���� ���� �׷��ο��� �ǽð� ����'
			---------------------------------------------
			select @schoolidx = schoolidx from dbo.tUserMaster where gameid = @paramstr_
			select @schoolname = schoolname from dbo.tSchoolBank where schoolidx = @schoolidx

			select top 500 rank() over(order by point desc) userrank, @schoolname schoolname, * from dbo.tSchoolUser
			where schoolidx = @schoolidx and schoolidx != -1
			order by point desc

		END
	else if (@mode_ = @SCHOOLRANK_CURRENT_USERRANK_GAMEID)
		BEGIN
			set @gameid		= @paramstr_
			set @schoolidx	= -1
			set @schoolname	= ''
			set @cnt		= 1
			---------------------------------------------
			--select 'DEBUG �����̸� > �б���ȣ > �б��ο��� ����(�ǽð�) + MY'
			---------------------------------------------
			select @schoolidx = schoolidx from dbo.tUserMaster where gameid = @gameid
			select @schoolname = schoolname from dbo.tSchoolBank where schoolidx = @schoolidx
			select @point = point from dbo.tSchoolUser where gameid = @gameid and schoolidx = @schoolidx and schoolidx != -1
			select @cnt = cnt from dbo.tSchoolMaster where  schoolidx = @schoolidx

			---------------------------------------------
			-- ģ������.
			---------------------------------------------
			DECLARE @tTempUserRank TABLE(
				userrank		int,
				gameid			varchar(20),
				point			int,
				schoolname		varchar(128),
				schoolidx		int,
				cnt				int
			);

			-- ģ�� ������ ����.
			insert into @tTempUserRank
			select top 10 rank() over(order by point desc) userrank, gameid, point, @schoolname schoolname, schoolidx, @cnt cnt from dbo.tSchoolUser where schoolidx = @schoolidx and schoolidx != -1
			union
			select count(gameid) + 1 as userrank, @gameid gameid, @point point, @schoolname schoolname, @schoolidx schoolidx, @cnt cnt from dbo.tSchoolUser where schoolidx = @schoolidx and point > @point and schoolidx != -1
			--order by point desc

			select r.*, isnull(itemcode, 1) itemcode, isnull(acc1, -1) acc1, isnull(acc2, -1) acc2, kakaotalkid, kakaouserid, kakaonickname, kakaoprofile, kakaomsgblocked, 1 kakaofriendkind from
				(select gameid, anireplistidx, kakaotalkid, kakaouserid, kakaonickname, kakaoprofile, kakaomsgblocked from dbo.tUserMaster where gameid in (select gameid from @tTempUserRank)) as m
			LEFT JOIN
				(select gameid, listidx, itemcode, acc1, acc2 from dbo.tUserItem where gameid in (select gameid from @tTempUserRank)) as i
			ON
				m.gameid = i.gameid and m.anireplistidx = i.listidx
			JOIN
				(select * from @tTempUserRank) as r
			ON
				m.gameid = r.gameid
			order by point desc

		END
	else if (@mode_ = @SCHOOLRANK_CURRENT_USERRANK_SCHOOLIDX)
		BEGIN
			---------------------------------------------
			--select 'DEBUG ���� ���� �׷��ο��� �ǽð� ���� 10����'
			---------------------------------------------
			set @schoolidx 	= @paramint_
			set @cnt		= 1
			select @schoolname = schoolname from dbo.tSchoolBank where schoolidx = @schoolidx
			select @cnt = cnt from dbo.tSchoolMaster where  schoolidx = @schoolidx

			---------------------------------------------
			-- ģ������.
			-- ���� �ŷ���, �б� ������
			---------------------------------------------
			DECLARE @tTempUserRank2 TABLE(
				userrank		int,
				gameid			varchar(20),
				point			int,
				schoolname		varchar(128),
				schoolidx		int,
				cnt				int
			);

			-- ģ�� ������ ����.
			insert into @tTempUserRank2
			select top 10 rank() over(order by point desc) userrank, gameid, point, @schoolname schoolname, schoolidx, @cnt cnt from dbo.tSchoolUser
			where schoolidx = @schoolidx and schoolidx != -1
			--order by point desc

			select r.*, isnull(itemcode, 1) itemcode, isnull(acc1, -1) acc1, isnull(acc2, -1) acc2, kakaotalkid, kakaouserid, kakaonickname, kakaoprofile, kakaomsgblocked, 1 kakaofriendkind from
				(select gameid, anireplistidx, kakaotalkid, kakaouserid, kakaonickname, kakaoprofile, kakaomsgblocked from dbo.tUserMaster where gameid in (select gameid from @tTempUserRank2)) as m
			LEFT JOIN
				(select gameid, listidx, itemcode, acc1, acc2 from dbo.tUserItem where gameid in (select gameid from @tTempUserRank2)) as i
			ON
				m.gameid = i.gameid and m.anireplistidx = i.listidx
			JOIN
				(select * from @tTempUserRank2) as r
			ON
				m.gameid = r.gameid
			order by point desc

		END
	else if (@mode_ = @SCHOOLRANK_RECENTLY_SCHOOLRANK)
		BEGIN
			---------------------------------------------
			--select 'DEBUG ������ �б�����, �б��� �⿩��'
			---------------------------------------------
			DECLARE @tTempTableLastWeekMaster TABLE(
				dateid			varchar(8) default(getdate()),

				schoolrank		int,
				schoolidx		int,
				cnt				int,
				totalpoint		bigint
			);

			--------------------------------
			-- ������ �б�����
			--------------------------------
			set @gameid		= @paramstr_
			set @dateid		= Convert(varchar(8), Getdate(),112)
			select top 1 @dateid = dateid from dbo.tSchoolBackMaster order by dateid desc

			-- ������ �б���ŷ
			insert into @tTempTableLastWeekMaster
			select top 3 dateid, schoolrank, schoolidx, cnt, totalpoint/100
			from dbo.tSchoolBackMaster
			where dateid = @dateid
			order by schoolrank asc

			select l.*, b.schoolname from
				@tTempTableLastWeekMaster l
			JOIN
				(select schoolidx, schoolname from dbo.tSchoolBank where schoolidx in (select schoolidx from @tTempTableLastWeekMaster)) b
			ON
				l.schoolidx = b.schoolidx
			--order by schoolrank asc

			--------------------------------
			-- ���� �б��� �⿩��.
			--------------------------------
			set @schoolrank 	= -1
			set @userrank		= -1
			set @schoolidx		= -1
			set @point			= 0
			set @schoolname		= ''
			set @cnt			= 0
			set @itemcode1		= -1
			set @itemcode2		= -1
			set @itemcode3		= -1

			------------------------------------------
			-- tSchoolUser > ������ŷ����.
			------------------------------------------
			select
				@schoolrank 	= backschoolrank,
				@userrank 		= backuserrank,
				@schoolidx 		= backschoolidx,
				@point 			= backpoint,
				@itemcode1 		= backitemcode1,
				@itemcode2 		= backitemcode2,
				@itemcode3 		= backitemcode3
			from dbo.tSchoolUser
			where gameid = @gameid

			select @schoolname = schoolname from dbo.tSchoolBank where schoolidx = @schoolidx
			select @cnt = cnt from dbo.tSchoolBackMaster where dateid = @dateid and schoolidx = @schoolidx

			select @dateid dateid, @schoolrank schoolrank, @userrank userrank, @schoolidx schoolidx, @point point, @schoolname schoolname, @cnt cnt, @itemcode1 itemcode1, @itemcode2 itemcode2, @itemcode3 itemcode3
		END
	else if (@mode_ = @SCHOOLRANK_LASTWEEK_DATE)
		BEGIN
			---------------------------------------------------
			-- ������ ������������ ���� ����
			--select 'DEBUG ���� ���� ������ �׷��ο��� ����'
			---------------------------------------------
			select top 500 * from dbo.tSchoolSchedule
			order by dateid desc
		END
	else if (@mode_ = @SCHOOLRANK_LASTWEEK_SCHOOLRANK)
		BEGIN
			---------------------------------------------------
			-- ������ ������������ ���� ����
			---------------------------------------------

			set @dateid = @paramstr_
			DECLARE @tTempTableLastSchoolList TABLE(
				dateid			varchar(8),

				schoolrank		int,
				schoolidx		int,
				cnt				int,
				totalpoint		bigint
			);

			insert into @tTempTableLastSchoolList
			select top 500 dateid, schoolrank, schoolidx, cnt, totalpoint/100 from dbo.tSchoolBackMaster
			where dateid = @dateid
			order by schoolrank asc

			select l.*, b.schoolname from
				@tTempTableLastSchoolList l
			JOIN
				(select schoolidx, schoolname from dbo.tSchoolBank where schoolidx in (select schoolidx from @tTempTableLastSchoolList)) b
			ON
				l.schoolidx = b.schoolidx
			order by schoolrank asc
		END
	else if (@mode_ = @SCHOOLRANK_LASTWEEK_USERRANK)
		BEGIN
			---------------------------------------------------
			-- ������ ������������ ���� ����
			---------------------------------------------

			set @schoolidx = @paramint_
			set @dateid = @paramstr_
			DECLARE @tTempTableLastUserList TABLE(
				dateid			varchar(8),

				schoolrank		int,
				userrank		int,
				schoolidx		int,
				gameid			varchar(20),
				joindate		datetime,
				point			int,
				itemcode		int,
				acc1			int,
				acc2			int,
				itemcode1		int,
				itemcode2		int,
				itemcode3		int
			);

			insert into @tTempTableLastUserList
			select top 500 backdateid, backschoolrank, backuserrank, backschoolidx, gameid, joindate, backpoint, backitemcode, backacc1, backacc2, backitemcode1, backitemcode2, backitemcode3 from dbo.tSchoolUser
			where backdateid = @dateid and backschoolidx = @schoolidx
			order by backuserrank asc

			select l.*, b.schoolname from
				@tTempTableLastUserList l
			JOIN
				(select schoolidx, schoolname from dbo.tSchoolBank where schoolidx in (select schoolidx from @tTempTableLastUserList)) b
			ON
				l.schoolidx = b.schoolidx
			--order by schoolrank asc
		END
	else
		BEGIN
			set @mode_ = @mode_
		END

	------------------------------------------------
	set nocount off
End

