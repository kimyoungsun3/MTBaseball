/*
-- 1�� 1�δ� 5����Ʈ 450����Ʈ�� �ƽ��� ����
-- update dbo.tFVUserMaster set kakaomsgblocked = 1 where gameid = 'xxxx3'
-- update dbo.tFVUserMaster set kakaomsgblocked = 0 where gameid = 'xxxx3'
-- select * from dbo.tFVUserMaster where gameid in ( 'farm16225', 'farm51837')

update dbo.tFVUserMaster set heartget = 10, heartcnt = 20, heartdate = '20150202' where gameid = 'xxxx2'
update dbo.tFVUserMaster set heartget = 30, heartcnt = 400, heartdate = '20150201' where gameid = 'xxxx3'
update dbo.tFVUserFriend set senddate = getdate() - 1 where gameid in ('xxxx2', 'xxxx3')
exec spu_FVFriend 'xxxx2', '049000s1i0n7t8445289', 7, 'xxxx3', -1		-- ��Ʈ : ��Ʈ����, ����Ʈ����.
exec spu_FVFriend 'xxxx3', '049000s1i0n7t8445289', 7, 'xxxx2', -1		-- ��Ʈ : ��Ʈ����, ����Ʈ����.


select * from dbo.tFVUserMaster where gameid in ( 'farm16225', 'farm51837')
-- â�� : farm16225		3465659i5o0x9v476693
-- �ؽ� : farm51837		7758499v9a9u6d423517
update dbo.tFVUserFriend set senddate = getdate() - 1 where gameid = 'farm16225' and friendid = 'farm51837'
update dbo.tFVUserFriend set senddate = getdate() - 1 where gameid = 'farm51837' and friendid = 'farm16225'
exec spu_FVFriend 'farm16225', '3465659i5o0x9v476693', 7, 'farm51837', -1		-- ��Ʈ : ��Ʈ����, ����Ʈ����.

exec spu_FVFriend 'farm51837', '7758499v9a9u6d423517', 7, 'farm16225', -1		-- ��Ʈ : ��Ʈ����, ����Ʈ����.


-- ����(9)
*/
use Game4FarmVill3
GO

IF OBJECT_ID ( 'dbo.spu_FVFriend', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVFriend;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_FVFriend
	@gameid_								varchar(60),					-- ���Ӿ��̵�
	@password_								varchar(20),
	@mode_									int,
	@friendid_								varchar(60),
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
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--�ش������� ã�� ����

	-- ��Ÿ����
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- ���������ʴ¸��
	declare @RESULT_ERROR_NOT_FOUND_OTHERID		int				set @RESULT_ERROR_NOT_FOUND_OTHERID		= -83
	declare @RESULT_ERROR_TIME_REMAIN			int				set @RESULT_ERROR_TIME_REMAIN			= -123			-- ���� �ð��� ����.
	declare @RESULT_ERROR_KAKAO_MESSAGE_BLOCK	int				set @RESULT_ERROR_KAKAO_MESSAGE_BLOCK	= -149			-- �޼��� ���Űźλ����Դϴ�

	------------------------------------------------
	--	2-2. ���°�
	------------------------------------------------
	-- ģ����Ʈ����
	declare @USERFRIEND_MODE_HEARD				int					set	@USERFRIEND_MODE_HEARD						= 7;

	-- ģ�����°�.
	--declare @USERFRIEND_STATE_NON				int					set	@USERFRIEND_STATE_NON						=-2;		-- -2: ����.
	--declare @USERFRIEND_STATE_SEARCH			int					set	@USERFRIEND_STATE_SEARCH					=-1;		-- -1: �˻�.
	--declare @USERFRIEND_STATE_PROPOSE_WAIT	int					set	@USERFRIEND_STATE_PROPOSE_WAIT				= 0;		-- 0 : ģ����û���
	--declare @USERFRIEND_STATE_APPROVE_WAIT	int					set	@USERFRIEND_STATE_APPROVE_WAIT				= 1;		-- 1 : ģ���������
	declare @USERFRIEND_STATE_FRIEND			int					set	@USERFRIEND_STATE_FRIEND					= 2;		-- 2 : ��ȣģ��

	declare @KAKAO_FRIEND_KIND_GAME				int					set @KAKAO_FRIEND_KIND_GAME						= 1 		-- ����ģ��
	declare @KAKAO_FRIEND_KIND_KAKAO			int					set @KAKAO_FRIEND_KIND_KAKAO					= 2 		-- īī��ģ��

	declare @KAKAO_MESSAGE_ALLOW 				int					set @KAKAO_MESSAGE_ALLOW						= -1		-- īī�� �޼��� �߼۰���.
	declare @KAKAO_MESSAGE_BLOCK 				int					set @KAKAO_MESSAGE_BLOCK						=  1		-- īī�� �޼��� �Ұ���.

	------------------------------------------------
	--	2-3. ���λ�� ����
	------------------------------------------------
	declare @gameid			varchar(60)				set @gameid			= ''
	declare @market			int						set @market			= 0
	declare @friendid		varchar(60)				set @friendid		= ''
	declare @cnt			int						set @cnt 			= 0
	declare @senddate		datetime				set @senddate		= getdate()
	declare @senddate2		datetime				set @senddate2		= getdate() - 1
	declare @state			int

	-- ������ ��Ʈ
	declare @plusheart		int						set @plusheart		= 5
	declare @heartget2		int						set @heartget2		= 0
	declare @heartget		int						set @heartget		= 0
	declare @heartcnt		int						set @heartcnt		= 0
	declare @heartcntmax	int						set @heartcntmax	= 450
	declare @heartdate		varchar(8)				set @heartdate		= '20100101'

	-- ������ ��Ʈ
	declare @fheartget		int						set @fheartget		= 0
	declare @fheartcnt		int						set @fheartcnt		= 0
	declare @fheartcntmax	int						set @fheartcntmax	= 400
	declare @fheartdate		varchar(8)				set @fheartdate		= '20100101'
	declare @dateid8 		varchar(8) 				set @dateid8 		= Convert(varchar(8), Getdate(),112)
	declare @fkakaomsgblocked	int					set @fkakaomsgblocked = @KAKAO_MESSAGE_BLOCK

Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	--select 'DEBUG ', @gameid_ gameid_, @password_ password_, @mode_ mode_, @friendid_ friendid_

	------------------------------------------------
	-- 3-3. �� ���Ǻ� �б�
	------------------------------------------------
	if (@mode_ not in (@USERFRIEND_MODE_HEARD))
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_SUPPORT_MODE
			select @nResult_ rtn, 'ERROR �������� �ʴ� ����Դϴ�.'
		END
	else if (@mode_ = @USERFRIEND_MODE_HEARD)
		BEGIN
			-- ģ���� ����
			select
				@gameid 	= gameid,		@market 	= market,
				@heartget	= heartget, 	@heartcnt	= heartcnt,
				@heartcntmax= heartcntmax, 	@heartdate	= heartdate
			from dbo.tFVUserMaster
			where gameid = @gameid_ and password = @password_
			--select 'DEBUG ������(A)', @gameid gameid, @heartget heartget, @heartcnt heartcnt, @heartcntmax heartcntmax, @heartdate heartdate

			select
				@friendid 	= gameid,		@fkakaomsgblocked = kakaomsgblocked,
				@fheartget	= heartget, 	@fheartcnt	= heartcnt,
				@fheartcntmax= heartcntmax, @fheartdate	= heartdate
			from dbo.tFVUserMaster where gameid = @friendid_
			--select 'DEBUG �޴���(B)', @friendid friendid, @fheartget fheartget, @fheartcnt fheartcnt, @fheartcntmax fheartcntmax, @fheartdate fheartdate

			select
				@state 		= state,
				@senddate 	= senddate
			from dbo.tFVUserFriend where gameid = @gameid_ and friendid = @friendid_
			--select 'DEBUG ', @gameid gameid, @friendid friendid, @state state, @senddate senddate

			if(@gameid = '')
				begin
					set @nResult_ = @RESULT_ERROR_NOT_FOUND_GAMEID
					select @nResult_ rtn, 'ERROR ���̵� ã�� �� �����ϴ�.'
				end
			else if(@friendid = '' or @gameid_ = @friendid_)
				begin
					set @nResult_ = @RESULT_ERROR_NOT_FOUND_OTHERID
					select @nResult_ rtn, 'ERROR ģ���� ������ ã���� �����ϴ�.'
				end
			else if(@fkakaomsgblocked = @KAKAO_MESSAGE_BLOCK)
				begin
					set @nResult_ = @RESULT_ERROR_KAKAO_MESSAGE_BLOCK
					select @nResult_ rtn, 'ERROR �ش�ģ���� �޼��� ���Űźλ����Դϴ�.'
				end
			else if(@state != @USERFRIEND_STATE_FRIEND)
				begin
					set @nResult_ = @RESULT_ERROR_NOT_SUPPORT_MODE
					select @nResult_ rtn, 'ERROR ��ȣģ���� �ƴմϴ�.'
				end
			else if(@senddate > @senddate2)
				begin
					set @nResult_ = @RESULT_ERROR_TIME_REMAIN
					select @nResult_ rtn, 'ERROR ��Ʈ ���� �ð��� ���ҽ��ϴ�.'
				end
			else
				begin
					set @nResult_ = @RESULT_SUCCESS
					select @nResult_ rtn, 'SUCCESS ģ������ ��Ʈ �����ϱ�'

					-------------------------------------
					-- �� īī�� ��Ʈ(O)
					-------------------------------------
					exec spu_FVDayLogInfoStatic @market, 16, 1

					---------------------------------------------
					-- ������(A)
					-- ��Ʈ�������۷� �ʱ�ȭ
					---------------------------------------------
					if(@heartdate != @dateid8)
						begin
							--select 'DEBUG (������A)�Ϸ� ��¥�� �ٲ� �ʱ�ȭ'
							set @heartdate	= @dateid8
							set @heartcnt = 0
						end
					set @heartget2 = @heartget
					set @heartget = 0

					update dbo.tFVUserMaster
						set
							heartget		= @heartget,
							heartcnt		= @heartcnt,
							heartdate		= @heartdate
					where gameid = @gameid_
					--select 'DEBUG (������A) ��Ʈ', @heartget2 heartget2

					---------------------------------------------
					--             ������(B)
					--             ������Ʈ ����(���� ���۷��� �ʰ��� ������)
					---------------------------------------------
					if(@fheartcnt >= @fheartcntmax)
						begin
							--select 'DEBUG ������(B)�����ʰ��� �ʰ�(1:�̹��ʰ�)'
							set @plusheart 	= 0
						end
					else if(@fheartcnt + @plusheart >= @fheartcntmax)
						begin
							--select 'DEBUG ������(B)�����ʰ��� �ʰ�(2:�̹��� �ʰ�)'
							set @plusheart 	= @fheartcntmax - @fheartcnt
						end
					else
						begin
							--select 'DEBUG ������(B)��Ʈ����'
							set @plusheart 	= @plusheart
						end
					set @fheartget = @fheartget + @plusheart
					set @fheartcnt = @fheartcnt + @plusheart
					--select 'DEBUG ������(B)', @plusheart plusheart, @fheartget fheartget, @fheartcnt fheartcnt

					update dbo.tFVUserMaster
						set
							heartget = @fheartget,
							heartcnt = @fheartcnt
					where gameid = @friendid_

					---------------------------------------------
					--	��		> ����Ʈ���޳��ڰ���
					-- ��Ʈ ���� �ð� ���� (Ŭ�� 24�ð��� �������� ����)
					-- 1 : 24H = 0.25 : 6H
					-- t - 24 > (t2 - (1 - 0.25) - 24
					---------------------------------------------
					update dbo.tFVUserFriend
						set
							--senddate = (getdate() - (1 - 0.25))		-- 6�ð�
							senddate = getdate() 						-- 1��
					where gameid = @gameid_ and friendid = @friendid_

					---------------------------------------------
					--	��������.
					---------------------------------------------
					select @heartget2 heartget2 --, * from dbo.tFVUserMaster where gameid = @gameid_

					--------------------------------------------------------------
					-- ���� ģ������
					-- ī�� & ������� ��ó������.(������ ���ʵ����� ��ü)
					--------------------------------------------------------------
					exec spu_FVsubFriendRank @gameid_, 1

					--------------------------------------------------------------
					-- Ȧ¦ ��ŷ����
					--------------------------------------------------------------
					--exec spu_subFVRankDaJun @gameid_, 0, 0, 0, 0, 1, 0, 0

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

