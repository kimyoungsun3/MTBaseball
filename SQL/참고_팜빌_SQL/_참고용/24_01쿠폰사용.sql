/*
-- select top 20 * from dbo.tFVEventCertNo
-- delete from dbo.tFVGiftList where gameid = 'xxxx2'
exec spu_FVCheckCertNo 'xxxx2', '049000s1i0n7t8445289', 'D832ACF8DC56480F', -1	-- ���̵� �������

--delete from dbo.tFVGiftList where gameid in ('farm83837225', 'xxxx2')
--update dbo.tFVUserMaster set eventspot06 = 0 where gameid in ('farm83837225', 'xxxx2')
exec spu_FVCheckCertNo 'xxxx2', '049000s1i0n7t8445289', 'LSYOARPUSSDGG796', -1	-- ���� �̺�Ʈ.
exec spu_FVCheckCertNo 'xxxx2', '049000s1i0n7t8445289', 'lsYoarpussdgg796', -1	-- ���� �̺�Ʈ.
exec spu_FVCheckCertNo 'xxxx2', '049000s1i0n7t8445289', 'Lsyoarpussdgg796', -1	-- ���� �̺�Ʈ.
exec spu_FVCheckCertNo 'xxxx2',        '049000s1i0n7t8445289', 'LSYOARPUSSDGG796', -1	-- ���� �̺�Ʈx.
exec spu_FVCheckCertNo 'farm83837225', '9164161y5c1d8y944779', 'lsyoarpussdgg796', -1	-- ���� �̺�Ʈ.

exec spu_FVCheckCertNo 'xxxx2', '049000s1i0n7t8445289', 'A1D7EF80D0B44F64', -1	-- ���� �̺�Ʈ.
exec spu_FVCheckCertNo 'xxxx2', '049000s1i0n7t8445289', '7B92619E3AEB468D', -1
exec spu_FVCheckCertNo 'xxxx2', '049000s1i0n7t8445289', '3758F8A00A8E4D2D', -1
*/
use Farm
GO


IF OBJECT_ID ( 'dbo.spu_FVCheckCertNo', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVCheckCertNo;
GO

create procedure dbo.spu_FVCheckCertNo
	@gameid_								varchar(60),					-- ���Ӿ��̵�
	@password_								varchar(20),
	@certno_								varchar(16),
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

	declare @RESULT_ERROR_ALREADY_REWARD		int				set @RESULT_ERROR_ALREADY_REWARD		= -126			-- �����ΰ� �̹̺�������.
	declare @RESULT_ERROR_NOT_FOUND_CERTNO		int				set @RESULT_ERROR_NOT_FOUND_CERTNO		= -133			-- ���� ��ȣ�� ����.
	declare @RESULT_ERROR_ALREADY_REWARD_COUPON	int				set @RESULT_ERROR_ALREADY_REWARD_COUPON	= -143			-- ������ 1�� 1��.

	--declare @MARKET_SKT						int					set @MARKET_SKT						= 1
	--declare @MARKET_KT						int					set @MARKET_KT						= 2
	--declare @MARKET_LGT						int					set @MARKET_LGT						= 3
	--declare @MARKET_GOOGLE					int					set @MARKET_GOOGLE					= 5
	--declare @MARKET_NHN						int					set @MARKET_NHN						= 6
	--declare @MARKET_IPHONE					int					set @MARKET_IPHONE					= 7

	-------------------------------------------------------------------
	-- [¥�� �����̾߱� ��������]
	-- �Ⱓ			: 2014-05-23 00:01 ~ 2014-05-31 23:59
	-- �̺�Ʈ ���� 	: ��������(1ȸ�� ������)
	-- ������ȣ		: LSYOARPUSSDGG796
	--                lsyoarpussdgg796
	--                Lsyoarpussdgg796
	-- ������ 		: ��Ȱ�� 10�� (1205)
	-------------------------------------------------------------------
	declare @EVENT_STATE_NON					int					set @EVENT_STATE_NON			= 0
	declare @EVENT_STATE_YES					int					set @EVENT_STATE_YES			= 1
	declare @EVENT06_START_DAY					datetime			set @EVENT06_START_DAY			= '2014-05-23 00:01'
	declare @EVENT06_END_DAY					datetime			set @EVENT06_END_DAY			= '2014-05-31 23:59'
	declare @EVENT06_CHECK_ITEM					varchar(16)			set @EVENT06_CHECK_ITEM			= 'LSYOARPUSSDGG796'
	declare @EVENT06_REWARD_ITEM				int					set @EVENT06_REWARD_ITEM		= 1205
	declare @EVENT06_REWARD_NAME				varchar(20)			set @EVENT06_REWARD_NAME		= '��������'

	declare @EVENT07_KIND_KUPANG				int					set @EVENT07_KIND_KUPANG		= 7		-- ���ο� ������ 5����.

	------------------------------------------------
	--	2-3. ���λ�� ����
	------------------------------------------------
	declare @gameid			varchar(60)				set @gameid			= ''
	declare @market			int						set @market			= 1
	declare @itemcode1		int						set @itemcode1		= -1
	declare @itemcode2		int						set @itemcode2		= -1
	declare @itemcode3		int						set @itemcode3		= -1
	declare @kind			int						set @kind			= 0
	declare @comment		varchar(128)			set @comment		= ''
	declare @certno			varchar(16)				set @certno			= ''

	declare @eventspot06	int						set @eventspot06 	= @EVENT_STATE_NON
	declare @curdate		datetime				set @curdate		= getdate()
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	--select 'DEBUG ', @gameid_ gameid_, @password_ password_, @certno_ certno_

	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	-- ���� ���� ���
	select
		@gameid			= gameid,
		@market			= market,
		@eventspot06	= eventspot06
	from dbo.tFVUserMaster where gameid = @gameid_ and password = @password_
	--select 'DEBUG ', @gameid gameid, @market market, @eventspot06 eventspot06

	------------------------------------------------
	--	3-2-3. �������
	------------------------------------------------
	select
		@itemcode1	= itemcode1,
		@itemcode2	= itemcode2,
		@itemcode3	= itemcode3,
		@certno		= certno,
		@kind		= kind
	from dbo.tFVEventCertNo where certno = @certno_
	--select 'DEBUG ', @certno_ certno_, @kind kind

	if(@gameid = '')
		begin
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR ���̵� �������� �ʴ´�.'
			--select 'DEBUG 2-1 ', @comment
		end
	else if(@certno_ = @EVENT06_CHECK_ITEM)
		begin
			-- �������� �̺�Ʈ.
			if(@eventspot06 = @EVENT_STATE_YES)
				begin
					set @nResult_ 	= @RESULT_ERROR_ALREADY_REWARD
					set @comment 	= 'SUCCESS �������� ����ó���ϴ�(�̹�����).'
				end
			else
				begin
					set @nResult_ 	= @RESULT_SUCCESS
					set @comment 	= 'SUCCESS �������� ����ó���ϴ�(��������2).'

					---------------------------------------------------
					-- ���� > ��������(������ �ڵ� �н���)
					---------------------------------------------------
					exec spu_FVSubGiftSend 2, @EVENT06_REWARD_ITEM, @EVENT06_REWARD_COUNT, @EVENT06_REWARD_NAME, @gameid, ''


					--------------------------------------
					-- ������ȣ > �����·� ����
					--------------------------------------
					update dbo.tFVUserMaster
						set
							eventspot06	= @EVENT_STATE_YES
					where gameid = @gameid_

					---------------------------------------------------
					-- ��Ż ����ϱ�
					---------------------------------------------------
					exec spu_FVDayLogInfoStatic @market, 41, 1				-- �� ������ϼ�
				end
		end
	else if(@kind >= @EVENT07_KIND_KUPANG and exists(select top 1 * from dbo.tFVEventCertNoBack where gameid = @gameid and kind = @kind))
		begin
			set @nResult_ 	= @RESULT_ERROR_ALREADY_REWARD_COUPON
			set @comment 	= 'SUCCESS 1�� 1�Ÿ� ���޵˴ϴ�.(�̹�����).'
			--select 'DEBUG 3-1 ', @comment
		end
	else if(@certno = '')
		begin
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_CERTNO
			set @comment 	= 'ERROR ������ȣ�� ������մϴ�.(1)'
			--select 'DEBUG 3-1 ', @comment
		end
	else
		begin
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'SUCCESS ����ó���ϴ�(��������1).'
			--select 'DEBUG 5-1 ', @comment

			--------------------------------------
			-- ���� > ��������(������ �ڵ� �н���)
			--------------------------------------
			if(@itemcode1 != -1)
				begin
					exec spu_FVSubGiftSend 2, @itemcode1, 'SysCert', @gameid, ''
				end

			if(@itemcode2 != -1)
				begin
					exec spu_FVSubGiftSend 2, @itemcode2, 'SysCert', @gameid, ''
				end

			if(@itemcode3 != -1)
				begin
					exec spu_FVSubGiftSend 2, @itemcode3, 'SysCert', @gameid, ''
				end

			--------------------------------------
			-- ������ȣ > �����·� ����(��뿩��, ���̵�, ��볯¥)
			--------------------------------------
			delete from dbo.tFVEventCertNo where certno = @certno_

			insert into dbo.tFVEventCertNoBack(certno,   gameid,   itemcode1,  itemcode2,  itemcode3,  kind)
			values(                         @certno_, @gameid_, @itemcode1, @itemcode2, @itemcode3, @kind)


			---------------------------------------------------
			-- ��Ż ����ϱ�
			---------------------------------------------------
			exec spu_FVDayLogInfoStatic @market, 41, 1				-- �� ������ϼ�
		end

	------------------------------------------------
	--	4-2. ��������
	------------------------------------------------
	select @nResult_ rtn, @comment comment
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			--------------------------------------------------------------
			-- ����/���� ����Ʈ ����
			--------------------------------------------------------------
			exec spu_FVGiftList @gameid_
		end

	set nocount off
End

