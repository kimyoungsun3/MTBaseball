/*
--select * from dbo.tUserMaster where schoolidx != -1 and kakaouserid != ''
--select * from dbo.tKakaoMaster where gameid = 'guest115966'
--exec spu_SchoolInfo 'guest115966', '049000s1i0n7t8445289', 2, 1, '', -1			-- ���Ը��
exec spu_NewStart 'xxxx11',  '049000s1i0n7t8445289', 'farmFB7940F66C204CD', -1
*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_NewStart', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_NewStart;
GO

create procedure dbo.spu_NewStart
	@gameid_				varchar(20),						-- ���Ӿ��̵�
	@password_				varchar(20),						-- ��ȣȭ�ؼ�����, �����н����� ��ŷ���ص� ����
	@kakaouserid_			varchar(60),						-- ī������.
	@nResult_				int				OUTPUT
	--WITH ENCRYPTION -- ���ν����� ��ȣȭ��.
as
	------------------------------------------------
	--	2-1. �����ڵ尪
	------------------------------------------------
	-- �Ϲݰ�
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	-- �α��� ����.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--�ش������� ã�� ����

	-- ������ or �����ϱ�.
	declare @KAKAO_STATUS_CURRENTING  			int				set @KAKAO_STATUS_CURRENTING			= 1				-- ������� �������
	declare @KAKAO_STATUS_NEWSTART  			int				set @KAKAO_STATUS_NEWSTART				= -1			-- �����ϱ��ѻ���

	-- �������°�.
	declare @DELETE_STATE_NO					int					set	@DELETE_STATE_NO				= 0	-- �������¾ƴ�
	declare @DELETE_STATE_YES					int					set	@DELETE_STATE_YES				= 1	-- ��������

	declare @NEW_START_INIT_LV					int					set @NEW_START_INIT_LV				= 15		-- ���ν����ϱ� �ð��ʱ�ȭ��.
	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @comment		varchar(128)
	declare	@kakaouserid	varchar(60)		set @kakaouserid	= ''
	declare @gameid			varchar(20)		set @gameid			= ''
	declare @famelv 		int				set @famelv			= 1
	declare @gameid2		varchar(20)		set @gameid2		= ''
	declare @schoolidx		int,
			@point			int

Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	set @comment = '�˼� ���� ������ �߻��߽��ϴ�.'
	--select 'DEBUG 1', @gameid_ gameid_, @password_ password_, @kakaouserid_ kakaouserid_

	------------------------------------------------
	--	3-2. ����ȹ��
	------------------------------------------------
	select
		@gameid = gameid
	from dbo.tKakaoMaster
	where kakaouserid = @kakaouserid_

	select
		@gameid2 	= gameid,	@famelv	= famelv,
		@schoolidx 	= schoolidx
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 2', @gameid gameid, @gameid2 gameid2

	------------------------------------------------
	--	3-3. ��������.
	------------------------------------------------
	if (@gameid = '' and @gameid != @gameid2)
		begin
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '�����ϱ⸦ �Ͽ����ϴ�.(����������)'
			--select 'DEBUG 3' + @comment
		end
	else if (@gameid = '' or @gameid2 = '' or @gameid != @gameid2)
		begin
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR ���̵� �������� �ʴ´�.'
			--select 'DEBUG 3' + @comment
		end
	else if(@gameid = @gameid2)
		begin
			set @nResult_ = @RESULT_SUCCESS
			set @comment = '�����ϱ⸦ �Ͽ����ϴ�.'
			--select 'DEBUG 4', @comment

			-----------------------------------
			-- ī�� �����Ϳ� Ŭ�����صα�.
			-----------------------------------
			update dbo.tKakaoMaster
				set
					gameid 	= '',
					cnt 	= cnt + 1,
					deldate	= case
									when @famelv >= @NEW_START_INIT_LV then ( getdate() - 0.958 )
									else					                ( getdate()         )
							  end
			where kakaouserid = @kakaouserid_
			--select 'DEBUG > ī�帶���� Ŭ����'
			-----------------------------------
			-- ģ���� ������ ��ȣ���� �������ֱ�.
			-----------------------------------
			exec sup_subDelFriend @gameid_


			-----------------------------------
			-- �б� Ż���ϱ�
			-- 1-1. �������� ���� Ȯ�� > ����ó��.
			---------------------------------------
			if(@schoolidx != -1)
				begin
					---------------------------------
					-- �б� ���������� ����.
					-- ������ (100) 					=>  100
					-- 					������ (100) 	=>  200
					-- Ż���							=> -200
					---------------------------------
					select @point = point from dbo.tSchoolUser where gameid = @gameid_

					-- ���������ʱ�ȭ.
					update dbo.tSchoolUser
						set
							schoolidx	= -1,
							point 		= 0
					where gameid = @gameid_

					-- ������ ���� �ʱ�ȭ.
					update dbo.tSchoolMaster
						set
							cnt 		= case when (cnt - 1) <= 0 then 0 else (cnt - 1) end,
							totalpoint 	= totalpoint - @point
					where schoolidx = @schoolidx
				end

			-----------------------------------
			-- ���� �����Ϳ� �����ϱ⸦ �ߴٰ� ǥ���ϱ�.
			-----------------------------------
			update dbo.tUserMaster
				set
					kakaostatus = @KAKAO_STATUS_NEWSTART,
					deletestate = @DELETE_STATE_YES,
					schoolidx 	= -1
			where gameid = @gameid_
			--select 'DEBUG > ���������� Ŭ����'
		end

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	select @nResult_ rtn, @comment comment

	--���� ����� �����Ѵ�.
	set nocount off
End



