use Game4FarmVill4
Go
/*
update dbo.tFVUserMaster set randserial = -1, roulette = 1, ownercashcost = 10000, wheelgauage = 0, wheelfree = 1 where gameid = 'xxxx2'
exec spu_FVWheel 'xxxx2', '049000s1i0n7t8445289', 20,    0, 'savedata1', -1, 7776, -1			-- ����ȸ����(20)    MODE_WHEEL_NORMAL
exec spu_FVWheel 'xxxx2', '049000s1i0n7t8445289', 21, 1000, 'savedata2', -1, 7777, -1			-- ����ȸ����(21)    MODE_WHEEL_PREMINUM
exec spu_FVWheel 'xxxx2', '049000s1i0n7t8445289', 22,    0, 'savedata3', -1, 7778, -1			-- Ȳ�ݹ���(22)  	 MODE_WHEEL_PREMINUMFREE

select * from dbo.tFVUserWheelLog where gameid = 'xxxx2'
*/

IF OBJECT_ID ( 'dbo.spu_FVWheel', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVWheel;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_FVWheel
	@gameid_								varchar(60),				-- ���Ӿ��̵�
	@password_								varchar(20),
	@mode_									int,
	@cashcost_								int,
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
	declare @RESULT_ERROR_DAILY_REWARD_ALREADY	int				set @RESULT_ERROR_DAILY_REWARD_ALREADY	= -102			-- ���Ϻ��� �̹� ����.
	declare @RESULT_ERROR_SESSION_ID_EXPIRE		int				set @RESULT_ERROR_SESSION_ID_EXPIRE		= -150			-- ������ ����Ǿ����ϴ�.


	-- ȸ���� ���.
	declare @MODE_WHEEL_NORMAL					int				set @MODE_WHEEL_NORMAL					= 20			-- ����ȸ����(20)
	declare @MODE_WHEEL_PREMINUM				int				set @MODE_WHEEL_PREMINUM				= 21			-- Ȳ��ȸ����(21)
	declare @MODE_WHEEL_PREMINUMFREE			int				set @MODE_WHEEL_PREMINUMFREE			= 22			-- Ȳ�ݹ���(22)

	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @comment				varchar(512)			set @comment		= '���̺�'
	declare @comment2				varchar(512)			set @comment2		= ''
	declare @gameid 				varchar(60)				set @gameid			= ''
	declare @market					int						set @market			= 5
	declare @roulette				int						set @roulette		= -1
	declare @randserial				varchar(20)				set @randserial		= '-1'
	declare @ownercashcost			bigint					set @ownercashcost	= 0
	declare @ownercashcost2			bigint					set @ownercashcost2	= 0
	declare @idx2					int						set @idx2			= 1
	declare @strange				int						set @strange		= -1
	declare @curdate				datetime				set @curdate		= getdate()
	declare @sid					int						set @sid			= 0

	-- ȸ����(ȸ����)����̱�.
	declare @wheelgauageflag		int						set @wheelgauageflag	= -1
	declare @wheelgauagepoint		int						set @wheelgauagepoint	= 10
	declare @wheelgauagemax			int						set @wheelgauagemax		= 100

	-- ȸ���� ��������.
	declare @wheelgauage			int						set @wheelgauage	= -1
	declare @wheelfree				int						set @wheelfree		= -1
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG �Է�����', @gameid_ gameid_, @password_ password_, @mode_ mode_, @cashcost_ cashcost_, @savedata_ savedata_, @randserial_ randserial_

	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	select
		@gameid 		= gameid, 			@market			= market,
		@ownercashcost	= ownercashcost,	@roulette		= roulette,
		@wheelgauage	= wheelgauage,		@wheelfree		= wheelfree,
		@sid			= sid,
		@randserial		= randserial
	from dbo.tFVUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG ��������', @gameid gameid, @market market, @ownercashcost ownercashcost, @wheelgauage wheelgauage, @wheelfree wheelfree, @randserial randserial

	----------------------------------------
	-- �߸��� ������ ���޵Ȱ� ȸ��
	----------------------------------------
	if(exists(select top 1 * from dbo.tFVGiftList where gameid = @gameid_ and itemcode = 3500 and cnt = 2000 and giftkind = -3))
		begin
			--select 'DEBUG Ƽ�� +2000 ����' 
			if(not exists(select top 1 * from dbo.tFVGiftList where gameid = @gameid_ and itemcode = 3500 and cnt = -2000 and giftkind = -3))
				begin
					--select 'DEBUG Ƽ�� -2000 �̼���' 				
					set @sid_ = 444
				end
		end
	
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
	else if (@mode_ not in (@MODE_WHEEL_NORMAL, @MODE_WHEEL_PREMINUM, @MODE_WHEEL_PREMINUMFREE))
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment = 'ERROR �������� �ʴ� ����Դϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if (@mode_ = @MODE_WHEEL_NORMAL and @roulette = -1)
		BEGIN
			set @nResult_ = @RESULT_ERROR_DAILY_REWARD_ALREADY
			set @comment = 'ERROR �̹� ������ �޾ư�(1). 1��1ȸ ����ȸ������ 2���̻� ����'
			--select 'DEBUG ' + @comment

			exec spu_FVSubUnusualRecord2  @gameid_, '1��1ȸ ����ȸ������ 2���̻� ����'
		END
	else if (@mode_ = @MODE_WHEEL_PREMINUMFREE and @wheelfree < 1)
		BEGIN
			set @nResult_ = @RESULT_ERROR_DAILY_REWARD_ALREADY
			set @comment = 'ERROR �̹� ������ �޾ư�(2). Ȳ�ݹ��ᰡ ���� �ǵ���'
			--select 'DEBUG ' + @comment
			exec spu_FVSubUnusualRecord2  @gameid_, 'Ȳ�ݹ��ᰡ ���� �ǵ���'
		END
	else if (@randserial_ = @randserial)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'SUCCESS ȸ���� ���� (���Ͽ�û)'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'ȸ���� ���� '
			--select 'DEBUG ', @comment

			------------------------------------------------
			-- �̱� �̺�Ʈ ���� ��������.
			------------------------------------------------
			select
				top 1
				-- ȸ����(ȸ����)����̱�.> xȸ�Ŀ� 1ȸ ����.
				@wheelgauageflag	= case when (@curdate > roulstart and @curdate <= roulend) then wheelgauageflag		else -1 end,
				@wheelgauagepoint	= wheelgauagepoint,
				@wheelgauagemax		= wheelgauagemax
			from dbo.tFVSystemRouletteMan
			where roulmarket = @market
			order by idx desc
			--select 'DEBUG ', @wheelgauageflag wheelgauageflag, @wheelgauagepoint wheelgauagepoint, @wheelgauagemax wheelgauagemax

			------------------------------------------------
			-- �̱� �̺�Ʈ ����ȸ���� > Ȳ�ݹ���.
			------------------------------------------------
			if(@wheelgauageflag = 1 and @mode_ in (@MODE_WHEEL_PREMINUM))
				begin
					--select 'DEBUG ����ȸ���� ���� �̺�Ʈ��', @wheelgauage wheelgauage
					if(@wheelgauage < @wheelgauagemax)
						begin
							--select 'DEBUG ����ȸ���� ������ ����'
							set @wheelgauage = @wheelgauage + @wheelgauagepoint
						end

					if(@wheelgauage >= @wheelgauagemax)
						begin
							--select 'DEBUG ����ȸ���� > Ȳ�ݹ������'
							set @wheelgauage = 0
							set @wheelfree	= 1
						end
				end

			----------------------------------------------
			-- �������.
			-- ���̺� ���� > �ݾ׻���.
			----------------------------------------------
			set @ownercashcost2 = dbo.fnu_GetFVSaveDataToCashcost(@savedata_)
			--select 'DEBUG', @ownercashcost2 ownercashcost2
			if(@mode_ = @MODE_WHEEL_NORMAL)
				begin
					--select 'DEBUG ����ȸ����'
					exec spu_FVDayLogInfoStatic @market, 63, 1			-- �� ����ȸ����
					set @roulette = -1
				end
			else if(@mode_ = @MODE_WHEEL_PREMINUM)
				begin
					--select 'DEBUG ����ȸ����', @ownercashcost ownercashcost, @ownercashcost2 ownercashcost2, @cashcost_ cashcost_
					exec spu_FVDayLogInfoStatic @market, 61, 1			-- �� ����ȸ����

					if(@ownercashcost2 > @ownercashcost - @cashcost_)
						begin
							set @strange = 1
							set @comment2 = '����ȸ���� ����(' + ltrim(rtrim(@ownercashcost)) + ') - ���(' + ltrim(rtrim(@cashcost_)) + ') < ������(' + ltrim(rtrim(@ownercashcost2)) + ')'
							--select 'DEBUG **** �̻���', @comment2 comment2
							exec spu_FVSubUnusualRecord2  @gameid_, @comment2
						end
						
				end
			else if(@mode_ = @MODE_WHEEL_PREMINUMFREE)
				begin
					--select 'DEBUG Ȳ�ݹ���'
					exec spu_FVDayLogInfoStatic @market, 62, 1			-- �� Ȳ�ݹ���

					if(@wheelfree < 1)
						begin
							set @strange = 1
							set @comment2 = 'Ȳ�ݹ��� ����(' + ltrim(rtrim(@wheelfree)) + ') ���ȴ�.'
							--select 'DEBUG **** �̻���', @comment2 comment2
							exec spu_FVSubUnusualRecord2  @gameid_, @comment2
						end
					set @wheelfree	= 0					
				end

			---------------------------------------------------
			-- ����ȸ���� �αױ��(200������ ����).
			---------------------------------------------------
			select @idx2 = isnull(idx2, 0) + 1 from dbo.tFVUserWheelLog where gameid = @gameid_
			--select 'DEBUG ȸ���� �α� ���', @idx2 idx2, @strange strange

			insert into dbo.tFVUserWheelLog(gameid,   idx2,  mode,   cashcost,   ownercashcost,  ownercashcost2,  strange)
			values(                        @gameid_, @idx2, @mode_, @cashcost_, @ownercashcost, @ownercashcost2, @strange)

			delete from dbo.tFVUserWheelLog where idx2 <= @idx2 - 500


			---------------------------------------------------
			-- ���� ���� ����
			----�α���
			--	�����ȵɸ�  	: <roulette>1</roulette>
			--	����			: <roulette>-1</roulette>
			--
			----�Ϲ� ȸ���� ����.
			--	�Ϲ� : userinfo 	20:-1;21:0;22:0;
			--	���� : userinfo		20:-1;21:1;22:0;
			--	Ȳ�� : userinfo		20:-1;21:0;22:1;
			---------------------------------------------------
			--select 'DEBUG ���� ���� ����'
			update dbo.tFVUserMaster
				set
					roulette 		= @roulette,
					ownercashcost	= @ownercashcost2,
					wheelgauage		= @wheelgauage,
					wheelfree		= @wheelfree,
					randserial		= @randserial_
			where gameid = @gameid_

			----------------------------------------------
			-- ���̺� ���� ����.
			----------------------------------------------
			--select 'DEBUG ���̺� ���� ����'
			update dbo.tFVUserData
				set
					savedate	= getdate(),
					savedata 	= @savedata_
			where gameid = @gameid_


			----------------------------------------------
			-- Ȧ¦ ��ŷ����
			----------------------------------------------
			--select 'DEBUG Ȧ¦ ��ŷ����',
			exec spu_subFVRankDaJun @gameid_, 0, 0, 0, 0, 0, 1, 0
		END


	-----------------------------------------------
	-- ����ڵ�ó��.
	-----------------------------------------------
	select @nResult_ rtn, @comment comment, @roulette roulette, @wheelgauageflag wheelgauageflag, @wheelgauage wheelgauage, @wheelfree wheelfree



	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off
End



