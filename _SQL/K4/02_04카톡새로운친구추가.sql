/*
exec spu_FVKakaoFriendAdd 'xxxx2',  '049000s1i0n7t8445289', '0:kakaouseridxxxx;1:kakaouseridxxxx3;2:kakaouseridxxxx4;', -1
exec spu_FVKakaoFriendAdd 'farm475',  '5835637x1w8u9f873297', '0:88470968441492992;1:91188455545412240;2:88287440312089585;3:88258263875124913;4:91408079342706913;5:88103356826892544;6:88141973561720689;7:88072204762769425;8:88812599272546640;9:91226849457314705;', -1

*/
use Game4FarmVill4
GO

IF OBJECT_ID ( 'dbo.spu_FVKakaoFriendAdd', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVKakaoFriendAdd;
GO

create procedure dbo.spu_FVKakaoFriendAdd
	@gameid_				varchar(60),
	@password_				varchar(20),
	@kakaouseridlist_		varchar(8000),
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

	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @comment		varchar(128)
	declare @gameid			varchar(60)		set @gameid			= ''
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	set @comment = '�˼� ���� ������ �߻��߽��ϴ�.'
	--select 'DEBUG 1', @gameid_ gameid_, @password_ password_, @kakaouseridlist_ kakaouseridlist_

	------------------------------------------------
	--	3-2. ����ȹ��
	------------------------------------------------
	select
		@gameid = gameid
	from dbo.tFVUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 2', @gameid gameid

	------------------------------------------------
	--	3-3. ��������.
	------------------------------------------------
	if (@gameid = '')
		begin
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR ���̵� �������� �ʴ´�.'
			--select 'DEBUG 3' + @comment
		end
	else
		begin
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'ģ���� �߰��߽��ϴ�.'
			--select 'DEBUG 4', @comment

			if(LEN(@kakaouseridlist_) >= 3)
				begin
					-- DEBUG ģ���߰� ���� ���μ��� ȣ��	farm1503	0:88227566776204833;1:88248034712699921;2:88282071099937857;
					--select 'DEBUG ģ���߰� ���� ���μ��� ȣ��', @gameid_ gameid_, @kakaouseridlist_ kakaouseridlist_
					exec sup_FVsubAddKakaoFriend @gameid_, @kakaouseridlist_
				end
		end

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	select @nResult_ rtn, @comment comment
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			--------------------------------------------------------------
			-- ���� ģ������
			-- ī�� & ������� ��ó������.(������ ���ʵ����� ��ü)
			--------------------------------------------------------------
			--select 'DEBUG ���� ģ������ ���'
			exec spu_FVsubFriendRank @gameid_, 1
		end

	--���� ����� �����Ѵ�.
	set nocount off
End



