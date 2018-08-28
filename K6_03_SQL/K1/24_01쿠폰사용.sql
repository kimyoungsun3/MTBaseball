/*
-- select * from dbo.tFVUserMaster where gameid = 'xxxx@gmail.com'
-- select * from dbo.tFVEventCertNoBack where gameid = 'xxxx@gmail.com'
-- update dbo.tFVUserMaster set market = 5 where gameid = 'xxxx@gmail.com'
-- update dbo.tFVUserMaster set randserial = -1, itemcode1 = -1, cnt1 = 0, itemcode2 = -1, cnt2 = 0, itemcode3 = -1, cnt3 = 0 where gameid = 'xxxx@gmail.com'
-- select * from dbo.tFVEventCertNo where kind = 2
-- delete from dbo.tFVGiftList where gameid in ('xxxx@gmail.com', 'editor1234567890')
-- delete from dbo.tFVEventCertNoBack where gameid in ('xxxx@gmail.com', 'editor1234567890')

exec spu_FVCheckCertNo 'xxxx@gmail.com', '01022223331', 'E344259F1D0B4FE7', '7771', -1
exec spu_FVCheckCertNo 'xxxx@gmail.com', '01022223331', '168B6A75D3804F47', '7772', -1
exec spu_FVCheckCertNo 'xxxx@gmail.com', '01022223331', 'E2731C6EA8B24DF4', '7773', -1
exec spu_FVCheckCertNo 'xxxx@gmail.com', '01022223331', 'CB459BDD12EA4B71', '7774', -1
exec spu_FVCheckCertNo 'xxxx@gmail.com', '01022223331', '1F087E6589454902', '7775', -1

exec spu_FVCheckCertNo 'xxxx@gmail.com', '01022223331', 'JAYOJAYOFARMVILL', '7777', -1

exec spu_FVCheckCertNo 'xxxx@gmail.com', '01022223331', 'JAYOFARMVILLFREE', '7780', -1
exec spu_FVCheckCertNo 'xxxx@gmail.com', '01022223331', 'JAYOFARMVILLFUN2', '7782', -1
exec spu_FVCheckCertNo 'xxxx@gmail.com', '01022223331', 'JAYOFARMVILLJAM2', '7783', -1
exec spu_FVCheckCertNo 'xxxx@gmail.com', '01022223331', 'JAYOFARMVILLSTRY', '7784', -1

exec spu_FVCheckCertNo 'xxxx@gmail.com', '01022223331', 'FARMVILLAGESTORY', '7785', -1
*/
use Farm
GO


IF OBJECT_ID ( 'dbo.spu_FVCheckCertNo', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVCheckCertNo;
GO

create procedure dbo.spu_FVCheckCertNo
	@gameid_							varchar(60),					-- ���Ӿ��̵�
	@phone_								varchar(20),
	@certno_							varchar(16),
	@randserial_						varchar(20),					--
	@nResult_							int					OUTPUT
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
	declare @RESULT_ERROR_ONE_PERSON_ONE_COUPON	int				set @RESULT_ERROR_ONE_PERSON_ONE_COUPON	= -243			-- ������ 1�� 1��.

	-- �̺�Ʈ
	declare @EVENT_STATE_NON					int					set @EVENT_STATE_NON			= 0
	declare @EVENT_STATE_YES					int					set @EVENT_STATE_YES			= 1
	declare @EVENT06_CHECK_ITEM					varchar(16)			set @EVENT06_CHECK_ITEM			= 'JAYOFARMVILLFREE'
	declare @EVENT07_CHECK_ITEM					varchar(16)			set @EVENT07_CHECK_ITEM			= 'JAYOFARMVILLFUN2'
	declare @EVENT08_CHECK_ITEM					varchar(16)			set @EVENT08_CHECK_ITEM			= 'JAYOFARMVILLJAM2'
	declare @EVENT09_CHECK_ITEM					varchar(16)			set @EVENT09_CHECK_ITEM			= 'JAYOFARMVILLSTRY'
	declare @EVENT10_CHECK_ITEM					varchar(16)			set @EVENT10_CHECK_ITEM			= 'FARMVILLAGESTORY'

	------------------------------------------------
	--	2-3. ���λ�� ����
	------------------------------------------------
	declare @gameid			varchar(60)				set @gameid			= ''
	declare @market			int						set @market			= 1
	declare @itemcode1		int						set @itemcode1		= -1
	declare @itemcode2		int						set @itemcode2		= -1
	declare @itemcode3		int						set @itemcode3		= -1
	declare @cnt1			int						set @cnt1			= 0
	declare @cnt2			int						set @cnt2			= 0
	declare @cnt3			int						set @cnt3			= 0
	declare @kind			int						set @kind			= 0
	declare @comment		varchar(128)			set @comment		= ''
	declare @certno			varchar(16)				set @certno			= ''

	declare @randserial		varchar(20)				set @randserial		= ''
	declare @bgitemcode1	int						set @bgitemcode1	= -1
	declare @bgitemcode2	int						set @bgitemcode2	= -1
	declare @bgitemcode3	int						set @bgitemcode3	= -1
	declare @bgcnt1			int						set @bgcnt1			= 0
	declare @bgcnt2			int						set @bgcnt2			= 0
	declare @bgcnt3			int						set @bgcnt3			= 0

	declare @eventspot06	int						set @eventspot06 	= @EVENT_STATE_NON
	declare @eventspot07	int						set @eventspot07 	= @EVENT_STATE_NON
	declare @eventspot08	int						set @eventspot08 	= @EVENT_STATE_NON
	declare @eventspot09	int						set @eventspot09 	= @EVENT_STATE_NON
	declare @eventspot10	int						set @eventspot10 	= @EVENT_STATE_NON
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	--select 'DEBUG ', @gameid_ gameid_, @phone_ phone_, @certno_ certno_, @randserial_ randserial_

	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	-- ���� ���� ���
	select
		@gameid			= gameid,
		@market			= market,
		@eventspot06	= eventspot06,	@eventspot07= eventspot07,	@eventspot08= eventspot08,	@eventspot09= eventspot09, @eventspot10= eventspot10,

		@randserial		= randserial,
		@bgitemcode1	= bgitemcode1,	@bgcnt1		= bgcnt1,
		@bgitemcode2	= bgitemcode2,	@bgcnt2		= bgcnt2,
		@bgitemcode3	= bgitemcode3,	@bgcnt3		= bgcnt3
	from dbo.tFVUserMaster where gameid = @gameid_ and phone = @phone_
	--select 'DEBUG ', @gameid gameid, @market market, @randserial randserial, @bgitemcode1 bgitemcode1, @bgcnt1 bgcnt1, @bgitemcode2 bgitemcode2, @bgcnt2 bgcnt2, @bgitemcode3 bgitemcode3, @bgcnt3 bgcnt3

	------------------------------------------------
	--	3-2-3. �������
	------------------------------------------------
	select
		@itemcode1	= itemcode1,	@cnt1		= cnt1,
		@itemcode2	= itemcode2,	@cnt2		= cnt2,
		@itemcode3	= itemcode3,	@cnt3		= cnt3,
		@certno		= certno,
		@kind		= kind
	from dbo.tFVEventCertNo where certno = @certno_
	--select 'DEBUG ', @certno_ certno_, @kind kind, @itemcode1 itemcode1, @cnt1 cnt1, @itemcode2 itemcode2, @cnt2 cnt2, @itemcode3 itemcode3, @cnt3 cnt3

	if(@gameid = '')
		begin
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR ���̵� �������� �ʴ´�.'
			--select 'DEBUG 2-1 ', @comment
		end
	else if (@randserial_ = @randserial)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '���������� ����'
			--select 'DEBUG ' + @comment

			set @itemcode1	= @bgitemcode1		set @cnt1		= @bgcnt1
			set @itemcode2	= @bgitemcode2		set @cnt2		= @bgcnt2
			set @itemcode3	= @bgitemcode3		set @cnt3		= @bgcnt3
		END
	else if(@certno_ in (@EVENT06_CHECK_ITEM, @EVENT07_CHECK_ITEM, @EVENT08_CHECK_ITEM, @EVENT09_CHECK_ITEM, @EVENT10_CHECK_ITEM))
		begin
			-- �������� �̺�Ʈ.
			if(    (@eventspot06 = @EVENT_STATE_YES and @certno_ = @EVENT06_CHECK_ITEM)
				or (@eventspot07 = @EVENT_STATE_YES and @certno_ = @EVENT07_CHECK_ITEM)
				or (@eventspot08 = @EVENT_STATE_YES and @certno_ = @EVENT08_CHECK_ITEM)
				or (@eventspot09 = @EVENT_STATE_YES and @certno_ = @EVENT09_CHECK_ITEM)
				or (@eventspot10 = @EVENT_STATE_YES and @certno_ = @EVENT10_CHECK_ITEM))
				begin
					set @nResult_ 	= @RESULT_ERROR_ONE_PERSON_ONE_COUPON
					set @comment 	= 'SUCCESS �������� ����ó���ϴ�(�̹�����).'
				end
			else
				begin
					set @nResult_ 	= @RESULT_SUCCESS
					set @comment 	= 'SUCCESS �������� ����ó���ϴ�(��������2).'

					---------------------------------------------------
					-- ���� > ��������(������ �ڵ� �н���)
					---------------------------------------------------
					if(@certno_ = @EVENT06_CHECK_ITEM)
						begin
							-- 1�� ����(3015) 500��, ����(3100) 50��, ������(3003)	777   		JAYOFARMVILLFREE
							set @itemcode1	= 3015
							set @cnt1		=  500
							exec spu_FVSubGiftSend 2, @itemcode1, @cnt1, 'JAYO6', @gameid, ''

							set @itemcode2	= 3100
							set @cnt2		= 500000
							exec spu_FVSubGiftSend 2, @itemcode2, @cnt2, 'JAYO6', @gameid, ''

							set @itemcode3	= 3003
							set @cnt3		=  777
							exec spu_FVSubGiftSend 2, @itemcode3, @cnt3, 'JAYO6', @gameid, ''

							--------------------------------------
							-- ������ȣ > �����·� ����
							--------------------------------------
							update dbo.tFVUserMaster set eventspot06 = @EVENT_STATE_YES where gameid = @gameid_
						end
					else if(@certno_ = @EVENT07_CHECK_ITEM)
						begin
							-- 2�� ����(3015) 500��, ����(3100) 100��, �ٳ�������(3004) 777	JAYOFARMVILLFUN2
							set @itemcode1	= 3015
							set @cnt1		=  500
							exec spu_FVSubGiftSend 2, @itemcode1, @cnt1, 'JAYO7', @gameid, ''

							set @itemcode2	= 3100
							set @cnt2		= 1000000
							exec spu_FVSubGiftSend 2, @itemcode2, @cnt2, 'JAYO7', @gameid, ''

							set @itemcode3	= 3004
							set @cnt3		=  777
							exec spu_FVSubGiftSend 2, @itemcode3, @cnt3, 'JAYO7', @gameid, ''

							--------------------------------------
							-- ������ȣ > �����·� ����
							--------------------------------------
							update dbo.tFVUserMaster set eventspot07 = @EVENT_STATE_YES where gameid = @gameid_
						end
					else if(@certno_ = @EVENT08_CHECK_ITEM)
						begin
							-- 3�� ����(3015) 500��, ����(3100) 200��, ũ��ġ��(3007) 777		JAYOFARMVILLJAM2
							set @itemcode1	= 3015
							set @cnt1		=  500
							exec spu_FVSubGiftSend 2, @itemcode1, @cnt1, 'JAYO8', @gameid, ''

							set @itemcode2	= 3100
							set @cnt2		= 2000000
							exec spu_FVSubGiftSend 2, @itemcode2, @cnt2, 'JAYO8', @gameid, ''

							set @itemcode3	= 3007
							set @cnt3		=  777
							exec spu_FVSubGiftSend 2, @itemcode3, @cnt3, 'JAYO8', @gameid, ''

							--------------------------------------
							-- ������ȣ > �����·� ����
							--------------------------------------
							update dbo.tFVUserMaster set eventspot08 = @EVENT_STATE_YES where gameid = @gameid_
						end
					else if(@certno_ = @EVENT09_CHECK_ITEM)
						begin
							-- 4�� ����(3015) 500��, ����(3100) 400��, ī���(3008) 777		JAYOFARMVILLSTRY
							set @itemcode1	= 3015
							set @cnt1		=  500
							exec spu_FVSubGiftSend 2, @itemcode1, @cnt1, 'JAYO9', @gameid, ''

							set @itemcode2	= 3100
							set @cnt2		= 4000000
							exec spu_FVSubGiftSend 2, @itemcode2, @cnt2, 'JAYO9', @gameid, ''

							set @itemcode3	= 3008
							set @cnt3		=  777
							exec spu_FVSubGiftSend 2, @itemcode3, @cnt3, 'JAYO9', @gameid, ''

							--------------------------------------
							-- ������ȣ > �����·� ����
							--------------------------------------
							update dbo.tFVUserMaster set eventspot09 = @EVENT_STATE_YES where gameid = @gameid_
						end
					else if(@certno_ = @EVENT10_CHECK_ITEM)
						begin
							-- 4�� ����(3000) 1000��, ����(3100) 3��, �䱸��Ʈ(3001) 1000		FARMVILLAGESTORY
							set @itemcode1	= 3000
							set @cnt1		= 1000
							exec spu_FVSubGiftSend 2, @itemcode1, @cnt1, 'LGEvent', @gameid, ''

							set @itemcode2	= 3100
							set @cnt2		= 30000
							exec spu_FVSubGiftSend 2, @itemcode2, @cnt2, 'LGEvent', @gameid, ''

							set @itemcode3	= 3001
							set @cnt3		= 1000
							exec spu_FVSubGiftSend 2, @itemcode3, @cnt3, 'LGEvent', @gameid, ''

							--------------------------------------
							-- ������ȣ > �����·� ����
							--------------------------------------
							update dbo.tFVUserMaster set eventspot10 = @EVENT_STATE_YES where gameid = @gameid_
						end


					---------------------------------------------------
					-- ��Ż ����ϱ�
					---------------------------------------------------
					exec spu_FVDayLogInfoStatic @market, 41, 1				-- �� ������ϼ�
				end
		end
	else if(@certno = '')
		begin
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_CERTNO
			set @comment 	= 'ERROR ������ȣ�� ������մϴ�.(1)'
			--select 'DEBUG 3-1 ', @comment
		end
	else if(exists(select top 1 * from dbo.tFVEventCertNoBack where gameid = @gameid and kind = @kind))
		begin
			set @nResult_ 	= @RESULT_ERROR_ONE_PERSON_ONE_COUPON
			set @comment 	= 'SUCCESS 1�� 1�Ÿ� ���޵˴ϴ�.(�̹�����).'
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
					exec spu_FVSubGiftSend 2, @itemcode1, @cnt1, 'SysCoup', @gameid, ''
				end

			if(@itemcode2 != -1)
				begin
					exec spu_FVSubGiftSend 2, @itemcode2, @cnt2, 'SysCoup', @gameid, ''
				end

			if(@itemcode3 != -1)
				begin
					exec spu_FVSubGiftSend 2, @itemcode3, @cnt3, 'SysCoup', @gameid, ''
				end

			--------------------------------------
			-- ������ȣ > �����·� ����(��뿩��, ���̵�, ��볯¥)
			--------------------------------------
			delete from dbo.tFVEventCertNo where certno = @certno_

			insert into dbo.tFVEventCertNoBack(certno,   gameid,   itemcode1,  cnt1,  itemcode2,  cnt2,  itemcode3,  cnt3,  kind,  market)
			values(                           @certno_, @gameid_, @itemcode1, @cnt1, @itemcode2, @cnt2, @itemcode3, @cnt3, @kind, @market)

			---------------------------------------------------
			-- ��Ż ����ϱ�
			---------------------------------------------------
			exec spu_FVDayLogInfoStatic @market, 41, 1				-- �� ������ϼ�
		end

	------------------------------------------------
	-- ����� ����
	------------------------------------------------
	if(@nResult_ != @RESULT_SUCCESS)
		begin
			set @itemcode1		= -1 		set @cnt1			= 0
			set @itemcode2		= -1		set @cnt2			= 0
			set @itemcode3		= -1		set @cnt3			= 0
		end

	------------------------------------------------
	--	4-2. ��������
	------------------------------------------------
	select @nResult_ rtn, @comment comment, @itemcode1 itemcode1, @cnt1 cnt1, @itemcode2 itemcode2, @cnt2 cnt2, @itemcode3 itemcode3, @cnt3 cnt3
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			-- �������� ���� �־���
			update dbo.tFVUserMaster
				set
					randserial	= @randserial_,
					bgitemcode1	= @itemcode1,		bgcnt1	= @cnt1,
					bgitemcode2	= @itemcode2,		bgcnt2	= @cnt2,
					bgitemcode3	= @itemcode3,		bgcnt3	= @cnt3
			where gameid = @gameid_

			--------------------------------------------------------------
			-- ����/���� ����Ʈ ����
			--------------------------------------------------------------
			exec spu_FVGiftList @gameid_
		end


	set nocount off
End

