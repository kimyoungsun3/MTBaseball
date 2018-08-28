/*
-- 1. �˻�.
exec spu_SchoolInfo 'xxxx2', '049000s1i0n7t8445289', 1, 1, '����', -1		-- �˻����(�ʵ��б�, ���)

-- 2-1. ���ʰ��� ����.
-- select gameid, password, schoolidx from dbo.tUserMaster where idx >= 1092 and idx <= 1092 + 20
-- delete from dbo.tSchoolUser where gameid = 'xxxx2'
-- update dbo.tUserMaster set schoolidx = -1, schoolresult = -1 where gameid = 'xxxx2'
exec spu_SchoolInfo 'xxxx2', '049000s1i0n7t8445289', 2, 10709, '', -1			-- ���Ը��

-- 2-2. ����ȹ��
select * from dbo.tSchoolMaster where schoolidx in (23, 24)
select * from dbo.tSchoolUser where schoolidx in (23, 24) order by schoolidx desc

-- 2-3. �ٸ�ģ�� ����
-- update dbo.tUserMaster set schoolidx = -1, schoolresult = -1 where gameid like 'xxxx%'
-- delete from dbo.tSchoolUser where gameid like 'xxxx%'
exec spu_SchoolInfo 'xxxx', '049000s1i0n7t8445289', 2, 23, '', -1			-- ���Ը��
exec spu_SchoolInfo 'xxxx2', '049000s1i0n7t8445289', 2, 23, '', -1			-- ���Ը��
exec spu_SchoolInfo 'xxxx3', '049000s1i0n7t8445289', 2, 23, '', -1			-- ���Ը��
exec spu_SchoolInfo 'xxxx4', '049000s1i0n7t8445289', 2, 23, '', -1			-- ���Ը��
exec spu_SchoolInfo 'xxxx5', '049000s1i0n7t8445289', 2, 23, '', -1			-- ���Ը��
exec spu_SchoolInfo 'xxxx6', '049000s1i0n7t8445289', 2, 23, '', -1			-- ���Ը��
exec spu_SchoolInfo 'xxxx7', '049000s1i0n7t8445289', 2, 23, '', -1			-- ���Ը��
exec spu_SchoolInfo 'xxxx8', '049000s1i0n7t8445289', 2, 23, '', -1			-- ���Ը��
exec spu_SchoolInfo 'xxxx9', '049000s1i0n7t8445289', 2, 23, '', -1			-- ���Ը��
exec spu_SchoolInfo 'xxxx10', '049000s1i0n7t8445289', 2, 23, '', -1			-- ���Ը��
exec spu_SchoolInfo 'xxxx11', '049000s1i0n7t8445289', 2, 23, '', -1			-- ���Ը��

-- 3. �б� Top 10�� + ������
exec spu_SchoolInfo 'xxxx2', '049000s1i0n7t8445289', 3, -1, '', -1

-- 4. �Ҽ� Top 30�� + ������
exec spu_SchoolInfo 'xxxx2', '049000s1i0n7t8445289', 4, -1, '', -1
exec spu_SchoolInfo 'xxxx2', '049000s1i0n7t8445289', 4,  1, '', -1

--  ���� �˾ƺ���.
declare @gameid varchar(20) set @gameid = 'xxxx2'
declare @schoolidx int		set @schoolidx = -1
declare @schoolresult int	set @schoolresult = -1
select @schoolidx = schoolidx, @schoolresult = schoolresult from dbo.tUserMaster where gameid = @gameid
select @schoolidx schoolidx, @schoolresult schoolresult
select * from dbo.tSchoolBank where schoolidx = @schoolidx
select * from dbo.tSchoolMaster where schoolidx = @schoolidx
select * from dbo.tSchoolUser where schoolidx = @schoolidx
*/
use Game4Farmvill5
GO

IF OBJECT_ID ( 'dbo.spu_SchoolInfo', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_SchoolInfo;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_SchoolInfo
	@gameid_								varchar(20),					-- ���Ӿ��̵�
	@password_								varchar(20),
	@mode_									int,
	@paramint_								int,
	@paramstr_								varchar(256),
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
	declare @RESULT_ERROR_DELETED_USER 			int				set @RESULT_ERROR_DELETED_USER			= -12			--�������� > �˾�ó���� ��Ʈ�η� ��������.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--�ش������� ã�� ����
	declare @RESULT_ERROR_NOT_FOUND_PASSWORD	int				set @RESULT_ERROR_NOT_FOUND_PASSWORD	= -17
	declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--������ �����ϰ� �ִ�.
	declare @RESULT_NEWVERION_CLIENT_DOWNLOAD 	int				set @RESULT_NEWVERION_CLIENT_DOWNLOAD	= -15			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ��ũó��.
	declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ����.

	-- ��Ÿ����
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- ���������ʴ¸��
	declare @RESULT_ERROR_CANNT_CHANGEDAY_SCHOOL	int			set @RESULT_ERROR_CANNT_CHANGEDAY_SCHOOL= -127			-- �б��������� �������.
	declare @RESULT_ERROR_CANNT_JOINDAY_SCHOOL	int				set @RESULT_ERROR_CANNT_JOINDAY_SCHOOL	= -128			-- �б��������� ���ԺҰ�.
	declare @RESULT_ERROR_CANNT_FIND_SCHOOL		int				set @RESULT_ERROR_CANNT_FIND_SCHOOL		= -129			-- �б��������� �б��� ã���� ����.
	declare @RESULT_ERROR_CANNT_JOINMAX_SCHOOL	int				set @RESULT_ERROR_CANNT_JOINMAX_SCHOOL	= -130			-- �б��������� �б��� �ƽ��Դϴ�.

	------------------------------------------------
	--	2-2. ���°�
	------------------------------------------------
	-- �б�����.
	--declare @SCHOOLKIND_ELEMENTARY_SCHOOL		int				set @SCHOOLKIND_ELEMENTARY_SCHOOL 		= 1		-- �ʵ�.
	--declare @SCHOOLKIND_JUNIOR_SCHOOL			int				set @SCHOOLKIND_JUNIOR_SCHOOL 			= 2		-- �ߵ�.
	--declare @SCHOOLKIND_HIGH_SCHOOL			int				set @SCHOOLKIND_HIGH_SCHOOL 			= 3		-- ���.
	--declare @SCHOOLKIND_COLLEGE_SCHOOL		int				set @SCHOOLKIND_COLLEGE_SCHOOL 			= 4		-- ����.

	-- �б������� ���.
	declare @SCHOOLRANK_MODE_SCHOOLBANK_SEARCH	int				set @SCHOOLRANK_MODE_SCHOOLBANK_SEARCH	= 1
	declare @SCHOOLRANK_MODE_SCHOOLBANK_JOIN	int				set @SCHOOLRANK_MODE_SCHOOLBANK_JOIN	= 2
	declare @SCHOOLRANK_MODE_SCHOOLTOP			int				set @SCHOOLRANK_MODE_SCHOOLTOP			= 3
	declare @SCHOOLRANK_MODE_SCHOOLUSERLIST		int				set @SCHOOLRANK_MODE_SCHOOLUSERLIST		= 4

	-- ���ϰ�.
	declare @WHAT_DAY_SUNDAY					int				set @WHAT_DAY_SUNDAY					= 1	-- ��(1)
	declare @WHAT_DAY_MONDAY					int				set @WHAT_DAY_MONDAY					= 2 -- ��(2)
	declare @WHAT_DAY_TUESDAY					int				set @WHAT_DAY_TUESDAY					= 3 -- ȭ(3)
	declare @WHAT_DAY_WEDNESDAY					int				set @WHAT_DAY_WEDNESDAY					= 4 -- ��(4)
	declare @WHAT_DAY_THURSDAY					int				set @WHAT_DAY_THURSDAY					= 5 -- ��(5)
	declare @WHAT_DAY_FRIDAY					int				set @WHAT_DAY_FRIDAY					= 6 -- ��(6)
	declare @WHAT_DAY_SATURDAY					int				set @WHAT_DAY_SATURDAY					= 7 -- ��(7)

	declare @SCHOOL_MAX							int				set @SCHOOL_MAX							= 300
	------------------------------------------------
	--	2-3. ���λ�� ����
	------------------------------------------------
	declare @comment		varchar(128)
	declare @gameid			varchar(20)				set @gameid			= ''
	declare @schoolidxcur	int						set @schoolidxcur	= -1

	declare @dw				int						set @dw				= 2
	declare @cnt			int						set @cnt			= 0
	declare @cnt2			int						set @cnt2			= 0
	declare @schoolname		varchar(128)			set @schoolname		= @paramstr_
	declare @schoolkind		int						set @schoolkind		= @paramint_
	declare @schoolidxnew	int						set @schoolidxnew	= @paramint_
	declare @point			bigint					set @point			= 0

Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG �Է�����', @gameid_ gameid_, @password_ password_, @mode_ mode_, @paramint_ paramint_, @paramstr_ paramstr_

	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	select
		@gameid 		= gameid,
		@schoolidxcur	= schoolidx
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG ��������', @gameid gameid, @schoolidxcur schoolidxcur

	------------------------------------------------
	-- 3-3. �� ���Ǻ� �б�
	------------------------------------------------
	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR ���̵� �������� �ʴ´�.'
			--select 'DEBUG ' + @comment

			select @nResult_ rtn, @comment comment
		END
	else if (@mode_ not in (@SCHOOLRANK_MODE_SCHOOLBANK_SEARCH, @SCHOOLRANK_MODE_SCHOOLBANK_JOIN, @SCHOOLRANK_MODE_SCHOOLTOP, @SCHOOLRANK_MODE_SCHOOLUSERLIST))
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment 	= 'ERROR �������� �ʴ� ����Դϴ�.'
			--select 'DEBUG ' + @comment

			select @nResult_ rtn, @comment comment
		END
	else if (@mode_ = @SCHOOLRANK_MODE_SCHOOLBANK_SEARCH)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'SUCCESS �˻����.'
			--select 'DEBUG ' + @comment

			--------------------------------------------------------------
			-- �������.
			--------------------------------------------------------------
			select @nResult_ rtn, @comment comment

			--------------------------------------------------------------
			-- �б���������.
			--------------------------------------------------------------
			set @schoolname = '%' + @schoolname + '%'

			select top 10 * from dbo.tSchoolBank
			where schoolkind = @schoolkind and schoolname like @schoolname
		END
	else if (@mode_ = @SCHOOLRANK_MODE_SCHOOLTOP)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'SUCCESS �б����� 10�� + ������.'
			--select 'DEBUG ' + @comment

			--------------------------------------------------------------
			-- �������.
			--------------------------------------------------------------
			select @nResult_ rtn, @comment comment

			--------------------------------------------------------------
			-- �б���������.
			-- ���� �б�����       (           �б����� + MY             )
			--------------------------------------------------------------
			exec spu_SchoolRank  4, -1, @gameid_
		END
	else if (@mode_ = @SCHOOLRANK_MODE_SCHOOLUSERLIST)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'SUCCESS �Ҽ� Top 10�� + ������.'
			--select 'DEBUG ' + @comment

			--------------------------------------------------------------
			-- �������.
			--------------------------------------------------------------
			select @nResult_ rtn, @comment comment

			--------------------------------------------------------------
			-- �б���������.
			-- ���� �б��� ��������(�����̸� > �б���ȣ > �б��ο��� ���� + MY)
			--------------------------------------------------------------
			if(@paramint_ != -1)
				begin
					exec spu_SchoolRank  7, @paramint_, ''
				end
			else
				begin
					exec spu_SchoolRank  5, -1, @gameid_
				end
		END
	else if (@mode_ = @SCHOOLRANK_MODE_SCHOOLBANK_JOIN)
		BEGIN

			set @dw = datepart(dw, getdate())	-- ��(1), ��(2)
			select @cnt  = cnt from dbo.tSchoolMaster where schoolidx = @schoolidxnew
			--select 'DEBUG ���Ը�� ���õǾ����ϴ�.', @schoolidxcur schoolidxcur, @schoolidxnew schoolidxnew, @cnt cnt, case when @dw = 1 then '�Ͽ���(���ԺҰ�)' when @dw = 2 then '������(����,�̵�)' when @dw = 3 then 'ȭ����(����)' when @dw = 4 then '������(����)' when @dw = 5 then '�����(����)' when @dw = 6 then '�ݿ���(����)' when @dw = 7 then '�����(����)' else 'xx����' end

			if(@schoolidxcur != -1 and @dw != @WHAT_DAY_MONDAY)
				begin
					set @nResult_ 	= @RESULT_ERROR_CANNT_CHANGEDAY_SCHOOL
					set @comment 	= 'ERROR ������ ������ �����ϸ� �簡�Ե˴ϴ�.'
					--select 'DEBUG ' + @comment
				end
			else if(@dw = @WHAT_DAY_SUNDAY)
				begin
					set @nResult_ 	= @RESULT_ERROR_CANNT_JOINDAY_SCHOOL
					set @comment 	= 'ERROR �Ͽ��Ͽ��� �Ұ����մϴ�.'
					--select 'DEBUG ' + @comment
				end
			else if(@schoolidxnew = -1)
				begin
					set @nResult_ 	= @RESULT_ERROR_CANNT_FIND_SCHOOL
					set @comment 	= 'ERROR ã�� �� �����ϴ�.(schoolidxnew:-1)'
					--select 'DEBUG ' + @comment
				end
			else if(not exists(select top 1 * from dbo.tSchoolBank where schoolidx = @schoolidxnew))
				begin
					set @nResult_ 	= @RESULT_ERROR_CANNT_FIND_SCHOOL
					set @comment 	= 'ERROR ã�� �� �����ϴ�.(bank not found)'
					--select 'DEBUG ' + @comment
				end
			else if(@cnt >= @SCHOOL_MAX)
				begin
					set @nResult_ 	= @RESULT_ERROR_CANNT_JOINMAX_SCHOOL
					set @comment 	= 'SUCCESS �ƽ� �ο��� �ʰ��߽��ϴ�.'
					--select 'DEBUG ' + @comment
				end
			else if(@schoolidxcur = @schoolidxnew)
				begin
					set @nResult_ 	= @RESULT_SUCCESS
					set @comment 	= 'SUCCESS ���� �����߽��ϴ�.(�����Ѱ� �簡��)'
					--select 'DEBUG ' + @comment
				end
			else
				begin
					set @nResult_ 	= @RESULT_SUCCESS
					set @comment 	= 'SUCCESS ���� �����߽��ϴ�.'
					select @point 	= point from dbo.tSchoolUser where gameid = @gameid_
					--select 'DEBUG ' + @comment, @schoolidxcur schoolidxcur, @schoolidxnew schoolidxnew, @point point

					---------------------------------------
					-- 1-1. Ż��ó�� > ����ó��.
					---------------------------------------
					if(@schoolidxcur != -1)
						begin
							update dbo.tSchoolMaster
								set
									cnt 		= case when (cnt - 1) < 0 then 0 else (cnt - 1) end,
									totalpoint 	= totalpoint - @point
							where schoolidx = @schoolidxcur

							--select 'DEBUG 1-1. �������� Ż�� > �η°���, ����Ʈ����', cnt, totalpoint from dbo.tSchoolMaster where schoolidx = @schoolidxcur
						end
					else
						begin
							set @point = @point
							--select 'DEBUG 1-1. ��������'
						end

					-----------------------
					-- 2-1. ������ ����
					-----------------------
					if(not exists(select top 1 * from dbo.tSchoolMaster where schoolidx = @schoolidxnew))
						begin
							-- �б��� ���Ӱ� ������ �������ش�.
							insert into tSchoolMaster(schoolidx,  cnt, totalpoint)
							values(                  @schoolidxnew, 1,     @point)
						end
					else
						begin
							update dbo.tSchoolMaster
								set
									cnt 		= cnt + 1,
									totalpoint 	= totalpoint + @point
							where schoolidx = @schoolidxnew
						end
					--select 'DEBUG 2-1. ������ �ο��߰�', @schoolidxnew schoolidxnew, @gameid_ gameid_, @point point, cnt, totalpoint from dbo.tSchoolMaster where schoolidx = @schoolidxnew

					-----------------------
					-- 2-2. ���� �����ϱ�.
					-----------------------
					if(not exists(select top 1 * from dbo.tSchoolUser where gameid = @gameid_))
						begin
							--select 'DEBUG 3-1. �б��������� insert'
							insert into dbo.tSchoolUser(schoolidx,     gameid,   point)
							values(                    @schoolidxnew, @gameid_,      0)
						end
					else
						begin
							--select 'DEBUG 3-2. �б��������� update'
							update dbo.tSchoolUser
								set
									schoolidx 	= @schoolidxnew
							where gameid = @gameid_
						end

					----------------------------------
					-- 3-1. ���� ���� �����ϱ�
					----------------------------------
					----select 'DEBUG 4-1. ���������� (�б������� ����)', @gameid_ gameid_, @schoolidxnew schoolidxnew
					update dbo.tUserMaster
						set
							schoolidx = @schoolidxnew
					where gameid = @gameid_

					----------------------------------
					-- �б�����������.
					----------------------------------
				end

			--------------------------------------------------------------
			-- �������.
			--------------------------------------------------------------
			select @nResult_ rtn, @comment comment

			if( @nResult_ = @RESULT_SUCCESS)
				begin
					-- �б��̸�.
					set @schoolname = ''
					select @schoolname = isnull(schoolname, '') from dbo.tSchoolBank where schoolidx = @schoolidxnew

					select @schoolname schoolname, @schoolidxnew schoolidx
				end
		END
	else
		begin
			set @nResult_ 	= @RESULT_ERROR
			set @comment 	= 'ERROR �˼����� ����(-1)'

			select @nResult_ rtn, @comment comment
		end

	------------------------------------------------
	--	4-2. ��������
	------------------------------------------------
	set nocount off
End

