/*
select * from dbo.tFVUserMaster where kakaouserid != ''
select * from dbo.tFVKakaoMaster where gameid = 'guest115966'
exec spu_FVUserCreate 'farm',  '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 101, '01011112222', '', 'kakaotalkidnnnn2', '', -1, '0:kakaouseridxxxx;1:kakaouseridxxxx3;', -1


exec spu_FVNewStart 'farm58417',  '049000s1i0n7t8445289', 'farmAE0BC0B7BFEF48F', -1
*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVNewStart', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVNewStart;
GO

create procedure dbo.spu_FVNewStart
	@gameid_				varchar(60),						-- ���Ӿ��̵�
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
	--declare @KAKAO_STATUS_CURRENTING  		int				set @KAKAO_STATUS_CURRENTING			= 1				-- ������� �������
	declare @KAKAO_STATUS_NEWSTART  			int				set @KAKAO_STATUS_NEWSTART				= -1			-- �����ϱ��ѻ���

	-- �������°�.
	--declare @DELETE_STATE_NO					int				set	@DELETE_STATE_NO				= 0	-- �������¾ƴ�
	declare @DELETE_STATE_YES					int				set	@DELETE_STATE_YES				= 1	-- ��������

	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @comment		varchar(128)
	declare	@kakaouserid	varchar(60)		set @kakaouserid	= ''
	declare @gameid			varchar(60)		set @gameid			= ''
	declare @gameid2		varchar(60)		set @gameid2		= ''

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
		@gameid2 		= gameid,
		@kakaouserid	= kakaouserid
	from dbo.tFVUserMaster
	where gameid = @gameid_ and phone = @phone_
	--select 'DEBUG tFVUserMaster > ', @kakaouserid kakaouserid, @gameid2 gameid2

	select
		@gameid = gameid
	from dbo.tFVKakaoMaster
	where kakaouserid = @kakaouserid
	--select 'DEBUG tFVKakaoMaster > ', @gameid gameid

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
			update dbo.tFVKakaoMaster
				set
					gameid 	= '',
					cnt 	= cnt + 1
					--, deldate	= getdate() --���Դ��ð� ����
			where kakaouserid = @kakaouserid_
			--select 'DEBUG > ī�帶���� Ŭ����'
			-----------------------------------
			-- ģ���� ������ ��ȣ���� �������ֱ�.
			-----------------------------------
			exec sup_FVsubDelFriend @gameid_

			-----------------------------------
			-- ���� �����Ϳ� �����ϱ⸦ �ߴٰ� ǥ���ϱ�.
			-----------------------------------
			update dbo.tFVUserMaster
				set
					kakaostatus = @KAKAO_STATUS_NEWSTART,
					deletestate = @DELETE_STATE_YES,
					salemoney	= 0
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



