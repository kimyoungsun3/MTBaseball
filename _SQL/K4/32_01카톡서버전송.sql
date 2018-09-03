/*
-- select * from dbo.tFVCashLogKakaoSend				select kakaosend, cashcost, cash, market, kakaouserid, kakaouk, * from dbo.tFVCashLog order by idx asc
-- update dbo.tFVCashLogKakaoSend set checkidx = 0	update dbo.tFVCashLog set kakaosend = -1, kakaouserid = '88258263875124913' where gameid = 'xxxx2' and kakaosend = 1
-- update dbo.tFVCashLogKakaoSend set checkidx = 0	update dbo.tFVCashLog set kakaosend = -1 where gameid = 'guest180' and kakaosend = 1
exec spu_FVKakaoPayment 1, -1,  '', '', -1							-- �˻�
exec spu_FVKakaoPayment 2, 11, '10, 11', '10', -1		-- ���ۿϷ�
exec spu_FVKakaoPayment 2, 13, '12, 13', '', -1
exec spu_FVKakaoPayment 2,  -1, '', '', -1
*/
use Game4FarmVill4
GO

IF OBJECT_ID ( 'dbo.spu_FVKakaoPayment', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVKakaoPayment;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_FVKakaoPayment
	@mode_									int,
	@paramint_								int,
	@paramstr_								varchar(1024),
	@paramerr_								varchar(1024),
	@nResult_								int					OUTPUT
	--WITH ENCRYPTION -- ���ν����� ��ȣȭ��.
as
	------------------------------------------------
	--	2-1. �ڵ尪�ڸ�
	------------------------------------------------
	-- �Ϲݰ�
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	------------------------------------------------
	--	2-2. ���°�
	------------------------------------------------
	-- ģ���˻�, �߰�, ����
	declare @KAKAO_MODE_LIST					int					set	@KAKAO_MODE_LIST						= 1;
	declare @KAKAO_MODE_SENDED					int					set	@KAKAO_MODE_SENDED						= 2;

	------------------------------------------------
	--	2-3. ���λ�� ����
	------------------------------------------------
	declare @cnt			int						set @cnt 			= 0
	declare @senddate		datetime				set @senddate		= getdate()


Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on

	------------------------------------------------
	-- 3-3. �� ���Ǻ� �б�
	------------------------------------------------
	if (@mode_ not in (@KAKAO_MODE_LIST, @KAKAO_MODE_SENDED))
		BEGIN
			set @nResult_ 	= -1
			select @nResult_ rtn, 'ERROR �������� �ʴ� ����Դϴ�.'
		END
	else if (@mode_ = @KAKAO_MODE_LIST)
		BEGIN
			------------------------------------------
			-- �����˻�.
			------------------------------------------
			set @nResult_ = @RESULT_SUCCESS
			select @nResult_ rtn, 'SUCCESS �˻�����Ʈ'

			----------------------------------
			-- ����Ÿ �˻�.
			----------------------------------
			select top 50 * from dbo.tFVCashLog
			where idx > isnull((select top 1 checkidx from dbo.tFVCashLogKakaoSend order by checkidx desc), 0)
			and kakaosend = -1
			order by idx asc
		END
	else if (@mode_ = @KAKAO_MODE_SENDED)
		BEGIN
			------------------------------------------
			-- .
			------------------------------------------
			set @nResult_ = @RESULT_SUCCESS
			select @nResult_ rtn, 'SUCCESS �ݿ��Ϸ�.'

			------------------------------------------
			-- .
			------------------------------------------
			-- 2-1. ��ŷ�ϱ�.
			if(@paramint_ = -1 or LEN(@paramstr_) < 1)
				begin
					-- �н���.
					set @paramint_ = -1
				end
			else
				begin
					if(not exists(select top 1 * from dbo.tFVCashLogKakaoSend))
						begin
							insert into dbo.tFVCashLogKakaoSend(checkidx) values(@paramint_)
						end
					else
						begin
							update dbo.tFVCashLogKakaoSend set checkidx = @paramint_
						end

					-- 2-2. (���ڿ��� sql �۵��ϱ�.
					EXECUTE('update dbo.tFVCashLog set kakaosend = 1 where idx in (' + @paramstr_ + ')')
				end

			if(LEN(@paramerr_) >= 1)
				begin
					-- 2-2. (���ڿ��� sql �۵��ϱ�.
					EXECUTE('update dbo.tFVCashLog set kakaosend = -444 where idx in (' + @paramerr_ + ')')
				end

		END
	else
		begin
			set @nResult_ = @RESULT_ERROR
			select @nResult_ rtn, 'ERROR �˼����� ����(-1)'
		end



	------------------------------------------------
	--	4-2. ��������
	------------------------------------------------
	set nocount off
End

