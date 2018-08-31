use Game4FarmVill4
Go
/*
update dbo.tFVUserMaster set randserial = -1, ownercashcost = 10000  where gameid = 'xxxx2'
exec spu_FVTSUgrade 'xxxx2', '049000s1i0n7t8445289', 1, 80010, 0, 1,    0, 100, 'savedata1', -1, 7776, -1			-- �Ϲݰ�ȭ(1)
exec spu_FVTSUgrade 'xxxx2', '049000s1i0n7t8445289', 2, 80010, 0, 1, 1000,   0, 'savedata2', -1, 7777, -1			-- ������ȭ(2)
exec spu_FVTSUgrade 'xxxx2', '049000s1i0n7t8445289', 2, 80010, 0, 1, 1000,   0, 'savedata2',  1, 7777, -1			-- ������ȭ(2)

select * from dbo.tFVUserUpgradeLog where gameid = 'xxxx2'
*/

IF OBJECT_ID ( 'dbo.spu_FVTSUgrade', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVTSUgrade;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_FVTSUgrade
	@gameid_								varchar(60),				-- ���Ӿ��̵�
	@password_								varchar(20),
	@mode_									int,
	@itemcode_								int,
	@step_									int,
	@results_								int,
	@cashcost_								int,
	@heart_									int,
	@savedata_								varchar(8000),
	@sid_									int,
	@randserial_							varchar(20),
	@nResult_								int					OUTPUT
	--WITH ENCRYPTION -- ���ν����� ��ȣȭ��.
as
	------------------------------------------------
	--	2-1. �ڵ尪�ڸ�
	------------------------------------------------
	-- �Ϲݰ�
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	--���� ����.
	declare @RESULT_ERROR_ID_DUPLICATE			int				set @RESULT_ERROR_ID_DUPLICATE			= -2

	-- ���̺� ����.
	--declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--������ > �˾�ó���� ��Ʈ�η� ��������.
	--declare @RESULT_ERROR_DELETED_USER 		int				set @RESULT_ERROR_DELETED_USER			= -12			--�������� > �˾�ó���� ��Ʈ�η� ��������.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--�ش������� ã�� ����
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- ���������ʴ¸��
	declare @RESULT_ERROR_SESSION_ID_EXPIRE		int				set @RESULT_ERROR_SESSION_ID_EXPIRE		= -150			-- ������ ����Ǿ����ϴ�.

	-- ��ȭ ���.
	declare @MODE_TSUPGRADE_NORMAL				int				set @MODE_TSUPGRADE_NORMAL				= 1		-- �Ϲݰ�ȭ(1).
	declare @MODE_TSUPGRADE_PREMIUM				int				set @MODE_TSUPGRADE_PREMIUM				= 2		-- ������ȭ(2).

	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @comment				varchar(512)			set @comment		= '���̺�'
	declare @comment2				varchar(512)			set @comment2		= ''
	declare @gameid 				varchar(60)				set @gameid			= ''
	declare @market					int						set @market			= 5
	declare @randserial				varchar(20)				set @randserial		= '-1'
	declare @ownercashcost			bigint					set @ownercashcost	= 0
	declare @ownercashcost2			bigint					set @ownercashcost2	= 0
	declare @idx2					int						set @idx2			= 1
	declare @strange				int						set @strange		= -1
	declare @curdate				datetime				set @curdate		= getdate()
	declare @sid					int						set @sid			= 0

	-- ������ȭ����.
	declare @tsupgradesaleflag		int						set @tsupgradesaleflag	= -1
	declare @tsupgradesalevalue		int						set @tsupgradesalevalue	=  0
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG �Է�����', @gameid_ gameid_, @password_ password_, @mode_ mode_, @itemcode_ itemcode_, @step_ step_, @results_ results_, @cashcost_ cashcost_, @heart_ heart_, @savedata_ savedata_, @randserial_ randserial_

	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	select
		@gameid 	= gameid,
		@market		= market,
		@ownercashcost= ownercashcost,
		@sid		= sid,
		@randserial	= randserial
	from dbo.tFVUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG ��������', @gameid gameid, @market market, @ownercashcost ownercashcost, @randserial randserial

	if(@gameid = '')
		BEGIN
			-- ���̵� ���������ʴ°�??
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '���̵� �������� �ʴ´�. > ���̵� Ȯ���ض�.'
			--select 'DEBUG ', @comment
		END
	else if(@sid_ != -1 and @sid_ != @sid)
		BEGIN
			-- ���� ID�� ���� ������ �ȵ�.
			set @nResult_ 	= @RESULT_ERROR_SESSION_ID_EXPIRE
			set @comment 	= '������ ����Ǿ� �ֽ��ϴ�. ��α����մϴ�.'
			--select 'DEBUG ', @comment
		END
	else if (@mode_ not in (@MODE_TSUPGRADE_NORMAL, @MODE_TSUPGRADE_PREMIUM))
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment = 'ERROR �������� �ʴ� ����Դϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if (@randserial_ = @randserial)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'SUCCESS ��ȭ�� ���� ����ó��(���Ͽ�û)'

			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '��ȭ�� ���� ����ó��'
			--select 'DEBUG ', @comment

			------------------------------------------------
			-- �̱� �̺�Ʈ ���� ��������.
			------------------------------------------------
			select
				top 1
				-- ������ȭ����
				@tsupgradesaleflag	= case when (@curdate > roulstart and @curdate <= roulend) then tsupgradesaleflag	else -1 end,
				@tsupgradesalevalue	= case when @tsupgradesaleflag = -1 then 0 else tsupgradesalevalue end
			from dbo.tFVSystemRouletteMan
			where roulmarket = @market
			order by idx desc
			--select 'DEBUG ', @tsupgradesaleflag tsupgradesaleflag, @tsupgradesalevalue tsupgradesalevalue

			----------------------------------------------
			-- �������.
			-- ���̺� ���� > �ݾ׻���.
			----------------------------------------------
			set @ownercashcost2 = dbo.fnu_GetFVSaveDataToCashcost(@savedata_)
			--select 'DEBUG', @ownercashcost2 ownercashcost2
			if(@mode_ = @MODE_TSUPGRADE_NORMAL)
				begin
					--select 'DEBUG �Ϲݰ�ȭ'
					exec spu_FVDayLogInfoStatic @market, 100, 1			-- �� �Ϲݰ�ȭ
				end
			else if(@mode_ = @MODE_TSUPGRADE_PREMIUM)
				begin
					--select 'DEBUG �����̾���ȭ', @ownercashcost ownercashcost, @ownercashcost2 ownercashcost2, @cashcost_ cashcost_
					exec spu_FVDayLogInfoStatic @market, 101, 1			-- �� �����̾���ȭ

					if(@ownercashcost2 > @ownercashcost - @cashcost_)
						begin
							set @strange = 1
							set @comment2 = '��ȭ�̻� ����(' + ltrim(rtrim(@ownercashcost)) + ') - ��ȭ���(' + ltrim(rtrim(@cashcost_)) + ') < ������(' + ltrim(rtrim(@ownercashcost2)) + ')'
							--select 'DEBUG **** �̻���', @comment2 comment2
							exec spu_FVSubUnusualRecord2  @gameid_, @comment2
						end
				end

			---------------------------------------------------
			-- ������ȭ �αױ��(200������ ����).
			---------------------------------------------------
			select @idx2 = isnull(idx2, 0) + 1 from dbo.tFVUserUpgradeLog where gameid = @gameid_
			--select 'DEBUG ���ΰ�ȭ �α� ���', @idx2 idx2, @strange strange

			insert into dbo.tFVUserUpgradeLog(gameid,    idx2,  mode,   itemcode,   step,   results,   ownercashcost,  ownercashcost2, cashcost,   heart,   strange)
			values(                           @gameid_, @idx2, @mode_, @itemcode_, @step_, @results_, @ownercashcost, @ownercashcost2, @cashcost_, @heart_, @strange)

			delete from dbo.tFVUserUpgradeLog where idx2 <= @idx2 - 500

			---------------------------------------------------
			-- ���� ���� ����
			---------------------------------------------------
			update dbo.tFVUserMaster
				set
					ownercashcost	= @ownercashcost2,
					randserial		= @randserial_
			where gameid = @gameid_

			----------------------------------------------
			-- ���̺� ���� ����.
			----------------------------------------------
			--select 'DEBUG update'
			update dbo.tFVUserData
				set
					savedate	= getdate(),
					savedata 	= @savedata_
			where gameid = @gameid_
		END


	-----------------------------------------------
	-- ����ڵ�ó��.
	-----------------------------------------------
	select @nResult_ rtn, @comment comment, @tsupgradesaleflag tsupgradesaleflag, @tsupgradesalevalue tsupgradesalevalue

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off
End



