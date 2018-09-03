/*
-- select * from dbo.tFVSysRecommendLog where gameid = 'xxxx@gmail.com'
-- select * from dbo.tFVGiftList where gameid = 'xxxx@gmail.com'
-- delete from dbo.tFVSysRecommendLog where gameid = 'xxxx@gmail.com'
-- delete from dbo.tFVGiftList where gameid = 'xxxx@gmail.com'

exec spu_FVGameReward 'xxxx@gmail.com',  '01022223331', 1, 7773, -1
exec spu_FVGameReward 'xxxx@gmail.com',  '01022223331', 2, 7774, -1
exec spu_FVGameReward 'xxxx@gmail.com',  '01022223331', 3, 7775, -1
*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVGameReward', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVGameReward;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_FVGameReward
	@gameid_								varchar(60),					-- ���Ӿ��̵�
	@phone_									varchar(20),					-- ��ȣȭ�ؼ�����, �����н����� ��ŷ���ص� ����
	@idx_									int,
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

	-- �α��� ����.
	--declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--������ > �˾�ó���� ��Ʈ�η� ��������.
	--declare @RESULT_ERROR_DELETED_USER 		int				set @RESULT_ERROR_DELETED_USER			= -12			--�������� > �˾�ó���� ��Ʈ�η� ��������.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--�ش������� ã�� ����

	-- ��Ÿ����
	declare @RESULT_ERROR_ALREADY_REWARD		int				set @RESULT_ERROR_ALREADY_REWARD		= -126			-- �����ΰ� �̹̺�������.

	------------------------------------------------
	--	2-2. ���ǰ�
	------------------------------------------------

	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @comment				varchar(80)
	declare @gameid 				varchar(60)			set @gameid 		= ''
	declare @market					int					set @market			= 5

	declare @randserial				varchar(20)			set @randserial		= ''
	declare @bgitemcode1			int					set @bgitemcode1	= -1
	declare @bgcnt1					int					set @bgcnt1			= 0

	declare @rewarditemcode			int					set @rewarditemcode	= -1
	declare @rewardcnt				int					set @rewardcnt		= 0

Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG �Է�����', @gameid_ gameid_, @password_ password_, @idx_ idx_, @randserial_ randserial_

	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	-- ���� ����Ÿ �о����
	select
		@gameid 		= gameid,		@market		= market,
		@randserial		= randserial,
		@bgitemcode1	= bgitemcode1,	@bgcnt1		= bgcnt1
	from dbo.tUserMaster where gameid = @gameid_ and phone = @phone_
	--select 'DEBUG ', @gameid gameid, @market market, @randserial randserial, @bgitemcode1 bgitemcode1, @bgcnt1 bgcnt1

	-- ��õ���� ��������.
	select
		@rewarditemcode		= rewarditemcode,
		@rewardcnt 			= rewardcnt
	from dbo.tFVSysRecommend2
	where idx = @idx_
	--select 'DEBUG ', @rewarditemcode rewarditemcode, @rewardcnt rewardcnt

	------------------------------------------------
	--	3-3. ����Ȳ���� �ڵ�� �з�
	------------------------------------------------
	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR ���̵� �������� �ʴ´�.'
			--select 'DEBUG ' + @comment
		END
	else if (@randserial_ = @randserial)
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'SUCCESS ��õ ������ �ޱ� �߽��ϴ�.(���Ͽ�û)'
			--select 'DEBUG ' + @comment
		END
	else if (exists(select top 1 * from dbo.tFVSysRecommendLog where gameid = @gameid_ and recommendidx = @idx_))
		BEGIN
			set @nResult_ = @RESULT_ERROR_ALREADY_REWARD
			set @comment = 'ERROR �̹� ������ �޾ҽ��ϴ�.'
			--select 'DEBUG ' + @comment
		END
	else if (@rewarditemcode = -1)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR ��õ���� �ڵ尡 �������� �ʽ��ϴ�.'
			--select 'DEBUG ' + @comment
		END
	ELSE
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS ��õ ������ �ޱ� �߽��ϴ�.'
			--select 'DEBUG ' + @comment

			--------------------------------------------------
			-- ������ ����
			-- �α� ���
			--------------------------------------------------
			exec spu_FVSubGiftSend 2, @rewarditemcode, @rewardcnt, 'SysRecom', @gameid_, ''

			insert into dbo.tFVSysRecommendLog(gameid,   recommendidx)
			values(                           @gameid_,         @idx_)

			update dbo.tUserMaster
				set
					randserial	= @randserial_,
					bgitemcode1	= @rewarditemcode,		bgcnt1	= @rewardcnt
			where gameid = @gameid_
		END

	-----------------------------------------------
	-- ����ڵ�ó��.
	-----------------------------------------------
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

