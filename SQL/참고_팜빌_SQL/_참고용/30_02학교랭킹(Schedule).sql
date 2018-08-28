--use Farm
--GO
--
--delete from dbo.tFVGiftList where giftdate > '2014-01-01' and gameid in ('xxxx12', 'xxxx13', 'xxxx14', 'xxxx15', 'xxxx16', 'xxxx17', 'xxxx18', 'xxxx19', 'xxxx2','xxxx3','xxxx4', 'xxxx5', 'xxxx6', 'xxxx7', 'xxxx8', 'xxxx9')
--delete from dbo.tFVSchoolBackMaster where dateid = '20140919'
--delete from dbo.tFVSchoolBackUser where dateid = '20140919'	-- ������.
--exec spu_FVSchoolScheduleRecord '20140919', 0
--------------------------------------------
-- ¥�� ���� �̾߱�
--  �ϱ��� ������ �����쿡 ��ϵȴ�.
--  1. 1���� ������ ����� �����Ѵ�. (���� �Ͽ��� 23�� 59�� 00�ʿ� ����)
--  2. �б� ��ŷ ���
--  3. �б���, ��ŷ�� ���.
---------------------------------------------
declare @step				int,
		@dateid				varchar(8),
		@gameid 			varchar(20),
		@loop 				int,
		@backschoolrank 	int,
		@schoolidx			int,
		@backcnt			int,
		@backtotalpoint		bigint,
		@backitemcode		int,
		@backacc1			int,
		@backacc2			int,
		@backuserrank		int,
		@curdate			datetime,
		@idx				int,
		@idx2				int,
		@cnt2				int,
		@totalpoint2		bigint,
		@comment			varchar(64)

set @dateid		= Convert(varchar(8),Getdate(),112)
set @curdate	= getdate()

declare @SCHOOL_STEP01_INIT_NON				int		set @SCHOOL_STEP01_INIT_NON				= 0
declare @SCHOOL_STEP02_INIT_END				int		set @SCHOOL_STEP02_INIT_END				= 1
declare @SCHOOL_STEP03_MASTERRANK_END		int		set @SCHOOL_STEP03_MASTERRANK_END		= 2
declare @SCHOOL_STEP04_USERRANK_END			int		set @SCHOOL_STEP04_USERRANK_END			= 3
declare @SCHOOL_STEP05_DUMP_END				int		set @SCHOOL_STEP05_DUMP_END				= 4

select @step = isnull(step, 0) from dbo.tFVSchoolSchedule where dateid = @dateid
set @step = isnull(@step, @SCHOOL_STEP01_INIT_NON)
--select 'DEBUG ', @dateid dateid, @step step, getdate() '�ð�', dbo.fnu_GetFVDatePart('ss', @curdate, getdate())

------------------------------------------------------
-- 1. tSchoolMaster, tSchoolUser ��ŷ �ʱ�ȭ
-- select dbo.fnu_GetFVDatePart('ss', getdate() - 1, getdate())
--
------------------------------------------------------
--select 'DEBUG ������', max(idx) cnt from dbo.tFVUserMaster			-- 938984
--select 'DEBUG �б���', max(idx) cnt from dbo.tFVSchoolMaster		-- 12225
--select 'DEBUG �б������л���', max(idx) cnt from dbo.tFVSchoolUser	-- 590446
--select 'DEBUG step1 tSchoolMaster, tSchoolUser  �̵�����', getdate() '�ð�', dbo.fnu_GetFVDatePart('ss', @curdate, getdate())
if(@step = @SCHOOL_STEP01_INIT_NON)
	begin
		set @step 	= @SCHOOL_STEP02_INIT_END

		-------------------------------------
		-- �б����� ������ ���ȭ(���� 0��) > �л�ó��.
		-------------------------------------
		select @idx2 = max(idx) from dbo.tFVSchoolMaster
		while(@idx2 > -1000)
			begin
				update dbo.tFVSchoolMaster
					set
						backcnt			= cnt,
						backtotalpoint	= totalpoint,
						backschoolrank	= -1
				where idx >= @idx2 - 1000 and idx < @idx2

				set @idx2 = @idx2 - 1000
			end

		--select 'DEBUG step1-1 > tSchoolMaster �̵�', getdate() '�ð�', dbo.fnu_GetFVDatePart('ss', @curdate, getdate())

		-------------------------------------------
		-- ���� ���� ������ ���ȭ(590,418��)
		-- ����Ÿ�� ������ > 4��
		-- ����Ÿ�� ������ > 20��
		-- select count(*) from dbo.tFVSchoolUser
		-- ��ǥ���� > itemcode, acc1, acc2 (��ǥ ���� �����Ҷ� �����)
		-------------------------------------------
		select @idx2 = max(idx) from dbo.tFVSchoolUser
		while(@idx2 > -1000)
			begin
				update dbo.tFVSchoolUser
					set
						backdateid		= @dateid,
						backschoolidx	= schoolidx,
						backschoolrank 	= -1,
						backuserrank	= -1,
						backpoint	 	= point,
						backitemcode	= itemcode,	-- ��ǥ���� ��ü�Ҷ� ����.
						backacc1		= acc1,
						backacc2		= acc2,
						backitemcode1	= -1,		-- �б����������� ��������
						backitemcode2	= -1,
						backitemcode3	= -1
				where idx >= @idx2 - 1000 and idx < @idx2
				set @idx2 = @idx2 - 1000
			end

		--select 'DEBUG step1-2 > tSchoolUser �̵�', getdate() '�ð�', dbo.fnu_GetFVDatePart('ss', @curdate, getdate())

		-------------------------------------
		-- �б�	> 1�ܰ迡�� Ŭ������.
		-------------------------------------
		update dbo.tFVSchoolMaster
			set
				totalpoint = 0
		--where totalpoint > 0
		--select 'DEBUG step1-3 > tSchoolMaster Ŭ����', getdate() '�ð�', dbo.fnu_GetFVDatePart('ss', @curdate, getdate())

		---------------------------------------------------------------------------
		-- ���� ���� ������ ���ȭ(590,418��)
		-- ���� > 1�ܰ迡�� Ŭ������.
		-- ����Ÿ�� ������ > 5��
		-- ����Ÿ�� ������ > 20 ~ 50��
		-- > schoolrank, point�� �ε����� �ɷ��־� ���������� �ε��� �۾�
		-- > ��Ȱ�ؼ� �۾��ϱ�.
		-- > --schoolrank = -1, ������(�̻��)
		-- select top 10 * from dbo.tFVSchoolUser
		---------------------------------------------------------------------------
		select @idx2 = max(idx) from dbo.tFVSchoolUser
		while(@idx2 > -1000)
			begin
				update dbo.tFVSchoolUser
					set
						point		= 0
				where idx >= @idx2 - 1000 and idx <= @idx2

				set @idx2 =  @idx2 - 1000
				--select 'DEBUG step1-4 > tSchoolUser Ŭ����****', getdate() '�ð�',  (@idx2 + 1000) idx, @idx2 idx, dbo.fnu_GetFVDatePart('ss', @curdate, getdate())
			end

		---------------------------------------
		-- �����б� �ٽú��� close�صα� > ����� �н�����.
		---------------------------------------

		-- ��ŷ�ϱ�
		exec spu_FVSchoolScheduleRecord @dateid, @step
		--select 'DEBUG step1-5 > �Ϸ�', getdate() '�ð�', dbo.fnu_GetFVDatePart('ss', @curdate, getdate())
	end
else
	begin
		--select 'DEBUG step1-1. tSchoolMaster, tSchoolUser ������۷� �̵��Ϸ�� > �н�', getdate() '�ð�', dbo.fnu_GetFVDatePart('ss', @curdate, getdate())
		set @step = @step
	end


------------------------------------------------------
-- 2. tSchoolMaster �б���ŷ ����
-- ��ü 	> 60�� �ɸ�.
-- 100�� 	> 1��
-- select top 10 * from dbo.tFVSchoolMaster order by backtotalpoint desc
-- select top 10 * from dbo.tFVSchoolMaster order by backschoolrank asc
-- select top 10 * from dbo.tFVSchoolUser order by backschoolrank asc
------------------------------------------------------
--select 'DEBUG step2 �б���ŷ ����', getdate() '�ð�', dbo.fnu_GetFVDatePart('ss', @curdate, getdate())
if(@step = @SCHOOL_STEP02_INIT_END)
	begin
		set @step 	= @SCHOOL_STEP03_MASTERRANK_END

		---------------------------------------------------------------------------
		-- 1�� : 100���� �б� > 0��
		-- 2�� : ��ü�б�
		--		 �б� ��ŷ ������ ���� �Է� (3:35, 60��)
		--		 �б� ������ : 5959��
		--		 �б� ����   : 60����
		--		 �ٸ� �۾��� ����ȴ�.
		---------------------------------------------------------------------------
		declare curSchoolMasterRank Cursor for
		select rank() over(order by backtotalpoint desc) backschoolrank, schoolidx
		from dbo.tFVSchoolMaster
		where backcnt > 0 and backtotalpoint > 0

		open curSchoolMasterRank
		Fetch next from curSchoolMasterRank into @backschoolrank, @schoolidx
		while @@Fetch_status = 0
			begin
				-- ������, ������ �б� ��ŷ ���.
				update dbo.tFVSchoolMaster set backschoolrank = @backschoolrank where schoolidx = @schoolidx
				update dbo.tFVSchoolUser   set backschoolrank = @backschoolrank where schoolidx = @schoolidx

				Fetch next from curSchoolMasterRank into @backschoolrank, @schoolidx
			end
		close curSchoolMasterRank
		Deallocate curSchoolMasterRank
		--select 'DEBUG step2-1 > tSchoolMaster ��ŷ����', getdate() '�ð�', dbo.fnu_GetFVDatePart('ss', @curdate, getdate())

		-- ��ŷ�ϱ�
		exec spu_FVSchoolScheduleRecord @dateid, @step
	end
else
	begin
		--select 'DEBUG 2. tSchoolMaster ��ŷ ���� > �н�'
		set @step = @step
	end

------------------------------------------------------
-- 3. tSchoolUser �׷쳻�� ��ŷ ����
------------------------------------------------------
--select 'DEBUG step3 tSchoolUser �б��� �� ���� ��ŷ ����', getdate() '�ð�', dbo.fnu_GetFVDatePart('ss', @curdate, getdate())
if(@step = @SCHOOL_STEP03_MASTERRANK_END)
	begin
		--select 'DEBUG step3-1. tSchoolUser > ����', getdate() '�ð�', dbo.fnu_GetFVDatePart('ss', @curdate, getdate())
		set @step 	= @SCHOOL_STEP04_USERRANK_END

		declare curSchoolUserRank Cursor for
		select u.backschoolrank, rank() over (partition by u.backschoolrank order by u.backpoint desc) as userrank2, gameid, m.backcnt, m.backtotalpoint
		from dbo.tFVSchoolUser u
			 JOIN
			 dbo.tFVSchoolMaster m
			 ON u.schoolidx = m.schoolidx
		where u.backschoolrank > 0 and u.backpoint > 0 order by u.backschoolrank asc
		--select 'DEBUG step3-2. tSchoolUser > Ŀ�� ����', getdate() '�ð�', dbo.fnu_GetFVDatePart('ss', @curdate, getdate())

		open curSchoolUserRank
		Fetch next from curSchoolUserRank into @backschoolrank, @backuserrank, @gameid, @cnt2 , @totalpoint2
		while @@Fetch_status = 0
			begin
				-----------------------------------------------
				-- �� ���� ��޿� ���� ��������
				-- 1���б� 	1��		212, 1003, 1207
				-- 			2��		112, 1003, 1206
				-- 			3��		 14, 1003, 1205
				-- 			��Ÿ  	 -1, 1004,   -1
				-- 2���б� 	1��		210, 1003, 1206
				-- 			2��		111, 1003, 1205
				-- 			3��		 13, 1003, 1204
				-- 			��Ÿ	 -1,  902,   -1
				-- 3���б� 	1��		209, 1003, 1205
				-- 			2��		110, 1003, 1204
				-- 			3��		 12, 1003, 1203
				-- 			��Ÿ	 -1,  901,   -1
				-- 4���̻�           -1,   -1,   -1
				-----------------------------------------------
				if(@backschoolrank = 1)
					begin
						--select 'DEBUG 1�� �б�'
						if(@backuserrank = 1)
							begin
								exec spu_FVSchoolScheduleGiftSendNew @gameid, @backuserrank, 212, 1003, 1207
							end
						else if(@backuserrank = 2)
							begin
								exec spu_FVSchoolScheduleGiftSendNew @gameid, @backuserrank, 112, 1003, 1206
							end
						else if(@backuserrank = 3)
							begin
								exec spu_FVSchoolScheduleGiftSendNew @gameid, @backuserrank,  14, 1003, 1205
							end
						else
							begin
								exec spu_FVSchoolScheduleGiftSendNew @gameid, @backuserrank, -1, 1004, -1
							end
					end
				else if(@backschoolrank = 2)
					begin
						--select 'DEBUG 2�� �б�'
						if(@backuserrank = 1)
							begin
								exec spu_FVSchoolScheduleGiftSendNew @gameid, @backuserrank,  210, 1003, 1206
							end
						else if(@backuserrank = 2)
							begin
								exec spu_FVSchoolScheduleGiftSendNew @gameid, @backuserrank,  111, 1003, 1205
							end
						else if(@backuserrank = 3)
							begin
								exec spu_FVSchoolScheduleGiftSendNew @gameid, @backuserrank,  13, 1003, 1204
							end
						else
							begin
								exec spu_FVSchoolScheduleGiftSendNew @gameid, @backuserrank, -1, 902, -1
							end
					end
				else if(@backschoolrank = 3)
					begin
						--select 'DEBUG 3�� �б�'
						if(@backuserrank = 1)
							begin
								exec spu_FVSchoolScheduleGiftSendNew @gameid, @backuserrank,  209, 1003, 1205
							end
						else if(@backuserrank = 2)
							begin
								exec spu_FVSchoolScheduleGiftSendNew @gameid, @backuserrank,  110, 1003, 1204
							end
						else if(@backuserrank = 3)
							begin
								exec spu_FVSchoolScheduleGiftSendNew @gameid, @backuserrank,  12, 1003, 1203
							end
						else
							begin
								exec spu_FVSchoolScheduleGiftSendNew @gameid, @backuserrank, -1, 901, -1
							end
					end
				else
					begin
						-----------------------------------------------
						-- 4�� �̻��� �б��� ����� �ְ� ������ ����.
						-- > ���⼭ �� ���� �ɸ���. �Ф�
						--exec spu_FVSchoolScheduleGiftSendNew @gameid, @backuserrank, -1, -1, -1
						-----------------------------------------------
						--select 'DEBUG 4�� �̻��б�', @gameid gameid, @backuserrank backuserrank, @cnt2 cnt2, @totalpoint2 totalpoint2
						update dbo.tFVSchoolUser set backuserrank = @backuserrank where gameid = @gameid


						-------------------------------------------------
						---- ���� ���� �б��� 1���� �Ǿ� ����~
						---- �Ⱓ: 09/15(��) ~ 09/28(��)
						---- 4~300�� �б� ���� 1,2,3�� ���Դ� ������ 5,4,3��
						---- 20�� �̻�, 5���� �̻�
						---- 5025	����3
						---- 5026	����4
						---- 5027	����5
						-------------------------------------------------
						--if(@cnt2 >= 20 and @totalpoint2 >= 50000)
						--	begin
						--		if(@backuserrank = 1)
						--			begin
						--				--select 'DEBUG 4�̻��б�(1)', @cnt2 cnt2, @totalpoint2 totalpoint2
						--				set @comment = '�б� ' + ltrim(str(@backschoolrank)) + '�� 1��'
						--				exec spu_FVSchoolScheduleGiftSendNew2 @gameid, @backuserrank,  -1, 5027, -1, @comment
						--			end
						--		else if(@backuserrank = 2)
						--			begin
						--				--select 'DEBUG 4�̻��б�(2)', @cnt2 cnt2, @totalpoint2 totalpoint2
						--				set @comment = '�б� ' + ltrim(str(@backschoolrank)) + '�� 2��'
						--				exec spu_FVSchoolScheduleGiftSendNew2 @gameid, @backuserrank,  -1, 5026, -1, @comment
						--			end
						--		else if(@backuserrank = 3)
						--			begin
						--				--select 'DEBUG 4�̻��б�(3)', @cnt2 cnt2, @totalpoint2 totalpoint2
						--				set @comment = '�б� ' + ltrim(str(@backschoolrank)) + '�� 3��'
						--				exec spu_FVSchoolScheduleGiftSendNew2 @gameid, @backuserrank,  -1, 5025, -1, @comment
						--			end
						--	end

					end

				Fetch next from curSchoolUserRank into @backschoolrank, @backuserrank, @gameid, @cnt2 , @totalpoint2
			end
		close curSchoolUserRank
		Deallocate curSchoolUserRank

		---------------------------------------
		-- 60���� �ϴµ� > 47��
		---------------------------------------
		--select 'DEBUG step3-3. tSchoolUser > ��üó��', getdate() '�ð�', dbo.fnu_GetFVDatePart('ss', @curdate, getdate())

		-- ��ŷ�ϱ�
		exec spu_FVSchoolScheduleRecord @dateid, @step
	end
else
	begin
		--select 'DEBUG step3. tSchoolUser �׷쳻�� ��ŷ ���� > �н�'
		set @step = @step
	end

------------------------------------------------------
-- 4. �����ϱ��� Ŭ����. tSchoolMaster, tSchoolUser -> tSchoolBackMaster, tSchoolBackUser(�н�)
------------------------------------------------------
--select 'DEBUG step4 > tSchoolBackMaster ���', getdate() '�ð�', dbo.fnu_GetFVDatePart('ss', @curdate, getdate())
if(@step = @SCHOOL_STEP04_USERRANK_END)
	begin
		--select 'DEBUG 4-1. �����ϱ�. tSchoolMaster, tSchoolUser -> tSchoolBackMaster, tSchoolBackUser'
		set @step 	= @SCHOOL_STEP05_DUMP_END

		-----------------------------------------------------
		-- �б���ŷ 100�������� > ���
		-----------------------------------------------------
		insert into dbo.tFVSchoolBackMaster(dateid, schoolidx,     cnt,     totalpoint,     schoolrank)
		select                           @dateid, schoolidx, backcnt, backtotalpoint, backschoolrank
		from dbo.tFVSchoolMaster where backschoolrank >= 1 and backschoolrank <= 10
		order by backschoolrank asc
		--select 'DEBUG step4-2 > tSchoolMaster ����', getdate() '�ð�', dbo.fnu_GetFVDatePart('ss', @curdate, getdate())


		-----------------------------------------------------
		-- �б��� �л�������. > �ο�����ŭ�̶� �����Ѵ�.
		-----------------------------------------------------
		insert into dbo.tFVSchoolBackUser(dateid,     schoolidx, gameid,     point, joindate,     schoolrank,     userrank,     itemcode,     acc1,     acc2,     itemcode1,     itemcode2,     itemcode3)
		select                         @dateid, backschoolidx, gameid, backpoint, joindate, backschoolrank, backuserrank, backitemcode, backacc1, backacc2, backitemcode1, backitemcode2, backitemcode3
		from dbo.tFVSchoolUser where backschoolrank >= 1 and backschoolrank <= 10
		order by backschoolrank asc, backuserrank asc
		--select 'DEBUG step4-3 > tSchoolBackUser ����', getdate() '�ð�', dbo.fnu_GetFVDatePart('ss', @curdate, getdate())

		-----------------------------------------
		-- ��ü ���� �ɷ��� ����ϸ� �ȵɵ���. �Ф�
		-- 938,939	> (1�� 37, 53��)
		--  1: �о��   > �����ֻ�.
		-- -1: �о	> ���� �Ⱥ����൵��.
		-- �α��ο� ���� �ɸ� �Ф� > ������. �Ф�
		-----------------------------------------
		--select @idx = max(idx) from dbo.tFVUserMaster
		--while(@idx > 0)
		--	begin
		--		update dbo.tFVUserMaster
		--			set
		--				schoolresult	= 1
		--		where idx >= @idx - 5000 and idx <= @idx and schoolresult	= -1
        --
		--		set @idx =  @idx - 5000
		--		--select 'DEBUG step4-4 > tUserMaster �÷������ֱ�', getdate() '�ð�',  (@idx + 10000) idx, @idx idx, dbo.fnu_GetFVDatePart('ss', @curdate, getdate())
		--	end
		--
		-----------------------------------------
		-- ��ó���  ��ŷ�ϴ� ���� ���
		-----------------------------------------
		insert into dbo.tFVSchoolResult(schoolresult)
		select top 1 (isnull(schoolresult, 0) + 1) from dbo.tFVSchoolResult order by schoolresult desc


		-- ��ŷ�ϱ�
		exec spu_FVSchoolScheduleRecord @dateid, @step
	end
else
	begin
		--select 'DEBUG 4. �����ϱ�. tSchoolMaster, tSchoolUser -> tSchoolBackMaster, tSchoolBackUser(�н�) > �н�'
		set @step = @step
	end