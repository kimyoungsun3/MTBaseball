use Farm
GO
/*
update dbo.tFVUserMaster set kakaomsginvitecnt = 4, kakaomsginvitetodaycnt = 0, kakaomsginvitetodaydate = kakaomsginvitetodaydate - 1 	where gameid = 'xxxx@gmail.com'
update dbo.tFVUserMaster set kakaomsginvitecnt = 9, kakaomsginvitetodaycnt = 0, kakaomsginvitetodaydate = kakaomsginvitetodaydate - 1 	where gameid = 'xxxx@gmail.com'
update dbo.tFVUserMaster set kakaomsginvitecnt = 19, kakaomsginvitetodaycnt = 0, kakaomsginvitetodaydate = kakaomsginvitetodaydate - 1 	where gameid = 'xxxx@gmail.com'
update dbo.tFVUserMaster set kakaomsginvitecnt = 39, kakaomsginvitetodaycnt = 0, kakaomsginvitetodaydate = kakaomsginvitetodaydate - 1 	where gameid = 'xxxx@gmail.com'
update dbo.tFVUserMaster set kakaomsginvitecnt = 69, kakaomsginvitetodaycnt = 0, kakaomsginvitetodaydate = kakaomsginvitetodaydate - 1 	where gameid = 'xxxx@gmail.com'
update dbo.tFVUserMaster set kakaomsginvitecnt = 99, kakaomsginvitetodaycnt = 0, kakaomsginvitetodaydate = kakaomsginvitetodaydate - 1 	where gameid = 'xxxx@gmail.com'
update dbo.tFVUserMaster set kakaomsginvitetodaydate = kakaomsginvitetodaydate - 1 	where gameid = 'xxxx@gmail.com'
update dbo.tFVKakaoInvite set senddate = senddate - 31 where gameid = 'xxxx@gmail.com'
-- delete from dbo.tFVKakaoInvite where gameid = 'xxxx@gmail.com'
-- delete from dbo.tFVGiftList where gameid = 'xxxx@gmail.com'
exec spu_FVKakaoFriendInvite 'xxxx@gmail.com',  '01022223331', 'facebookxxxx', -1
exec spu_FVKakaoFriendInvite 'xxxx@gmail.com',  '01022223331', 'facebookxxxx3', -
exec spu_FVKakaoFriendInvite 'xxxx@gmail.com',  '01022223331', 'facebookxxxx4', -1
exec spu_FVKakaoFriendInvite 'xxxx@gmail.com',  '01022223331', 'facebookxxxx5', -1
exec spu_FVKakaoFriendInvite 'xxxx@gmail.com',  '01022223331', 'facebookxxxx6', -1
exec spu_FVKakaoFriendInvite 'xxxx@gmail.com',  '01022223331', 'facebookxxxx7', -1
exec spu_FVKakaoFriendInvite 'xxxx@gmail.com',  '01022223331', 'facebookxxxx8', -1

*/

IF OBJECT_ID ( 'dbo.spu_FVKakaoFriendInvite', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVKakaoFriendInvite;
GO

create procedure dbo.spu_FVKakaoFriendInvite
	@gameid_				varchar(60),
	@phone_					varchar(20),
	@kakaouserid_			varchar(60),
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
	declare @RESULT_ERROR_TIME_REMAIN			int				set @RESULT_ERROR_TIME_REMAIN			= -123			-- ���� �ð��� ����.

	-- �ʴ뿡 ���� ���.
	declare @SENDEDDAY_INIT						int				set @SENDEDDAY_INIT						= 99999
	declare @SENDEDDAY_LIMIT					int				set @SENDEDDAY_LIMIT					= 7

	declare @KAKAO_MSG_INVITE_STEP1				int				set @KAKAO_MSG_INVITE_STEP1				= 5
	declare @KAKAO_MSG_INVITE_STEP2				int				set @KAKAO_MSG_INVITE_STEP2				= 10
	declare @KAKAO_MSG_INVITE_STEP3				int				set @KAKAO_MSG_INVITE_STEP3				= 20
	declare @KAKAO_MSG_INVITE_STEP4				int				set @KAKAO_MSG_INVITE_STEP4				= 40
	declare @KAKAO_MSG_INVITE_STEP5				int				set @KAKAO_MSG_INVITE_STEP5				= 70
	declare @KAKAO_MSG_INVITE_STEP6				int				set @KAKAO_MSG_INVITE_STEP6				= 100
	declare @KAKAO_MSG_INVITE_STEP7				int				set @KAKAO_MSG_INVITE_STEP7				= 200
	declare @KAKAO_MSG_INVITE_STEP8				int				set @KAKAO_MSG_INVITE_STEP8				= 400
	declare @KAKAO_MSG_INVITE_STEP9				int				set @KAKAO_MSG_INVITE_STEP9				= 700
	declare @KAKAO_MSG_INVITE_STEP10			int				set @KAKAO_MSG_INVITE_STEP10			= 1000



	-- ī�� ģ���ʴ� ����.
	declare @KAKAO_MSG_INVITE_STEP0_NON			int				set @KAKAO_MSG_INVITE_STEP0_NON			= -1
	--declare @KAKAO_MSG_INVITE_STEP1_ITEMCODE	int				set @KAKAO_MSG_INVITE_STEP1_ITEMCODE	= 3100
	--declare @KAKAO_MSG_INVITE_STEP2_ITEMCODE	int				set @KAKAO_MSG_INVITE_STEP2_ITEMCODE	= 3015
	--declare @KAKAO_MSG_INVITE_STEP3_ITEMCODE	int				set @KAKAO_MSG_INVITE_STEP3_ITEMCODE	= 3015
	--declare @KAKAO_MSG_INVITE_STEP4_ITEMCODE	int				set @KAKAO_MSG_INVITE_STEP4_ITEMCODE	= 3015
	--declare @KAKAO_MSG_INVITE_STEP5_ITEMCODE	int				set @KAKAO_MSG_INVITE_STEP5_ITEMCODE	= 3015
	--declare @KAKAO_MSG_INVITE_STEP6_ITEMCODE	int				set @KAKAO_MSG_INVITE_STEP6_ITEMCODE	= 3015

	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @comment			varchar(128)
	declare @gameid				varchar(60)		set @gameid				= ''
	declare @market				int				set @market				= 0
	declare @kakaomsginvitecnt	int				set @kakaomsginvitecnt	= 0
	declare @giftcode			int				set @giftcode			= @KAKAO_MSG_INVITE_STEP0_NON
	declare @cnt				int				set @cnt				= 0
	declare @sendedday			int				set @sendedday			= @SENDEDDAY_INIT
	declare @kakaomsginvitetodaycnt		int			set @kakaomsginvitetodaycnt		= 0
	declare @kakaomsginvitetodaydate	datetime	set @kakaomsginvitetodaydate	= getdate()

	declare @tmpcnt				int

	declare @kakaoinvite01		int				set @kakaoinvite01 		= 3100	--5�� ����	3100	20000
	declare @kakaoinvite02		int				set @kakaoinvite02 		= 3015	--10�� ����	3015	500
	declare @kakaoinvite03		int				set @kakaoinvite03 		= 3015	--20�� ����	3015	600
	declare @kakaoinvite04		int				set @kakaoinvite04		= 3015	--40�� ����	3015	700
	declare @kakaoinvite05		int				set @kakaoinvite05 		= 3015	--70�� ����	3015	800
	declare @kakaoinvite06		int				set @kakaoinvite06		= 3015	--100�����	3015	900
	declare @kakaoinvite07		int				set @kakaoinvite07		= 3015	--200�����	3015	1000
	declare @kakaoinvite08		int				set @kakaoinvite08		= 3015	--400�����	3015	1100
	declare @kakaoinvite09		int				set @kakaoinvite09		= 3015	--700�����	3015	1200
	declare @kakaoinvite10		int				set @kakaoinvite10		= 3015	--1000�����3015	1500
	declare @kakaoinvitecnt01	int				set @kakaoinvitecnt01 	= 20000
	declare @kakaoinvitecnt02	int				set @kakaoinvitecnt02 	= 500
	declare @kakaoinvitecnt03	int				set @kakaoinvitecnt03 	= 600
	declare @kakaoinvitecnt04	int				set @kakaoinvitecnt04	= 700
	declare @kakaoinvitecnt05	int				set @kakaoinvitecnt05 	= 800
	declare @kakaoinvitecnt06	int				set @kakaoinvitecnt06	= 900
	declare @kakaoinvitecnt07	int				set @kakaoinvitecnt07	= 1000
	declare @kakaoinvitecnt08	int				set @kakaoinvitecnt08	= 1100
	declare @kakaoinvitecnt09	int				set @kakaoinvitecnt09	= 1200
	declare @kakaoinvitecnt10	int				set @kakaoinvitecnt10	= 1500
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	set @comment = '�˼� ���� ������ �߻��߽��ϴ�.'
	--select 'DEBUG 1', @gameid_ gameid_, @phone_ phone_, @kakaouserid_ kakaouserid_

	------------------------------------------------
	--	3-2. ����ȹ��
	------------------------------------------------
	select
		@gameid 					= gameid,
		@market						= market,
		@kakaomsginvitecnt 			= kakaomsginvitecnt,
		@kakaomsginvitetodaycnt 	= kakaomsginvitetodaycnt,
		@kakaomsginvitetodaydate	= kakaomsginvitetodaydate
	from dbo.tFVUserMaster
	where gameid = @gameid_ and phone = @phone_
	--select 'DEBUG 2', @gameid gameid, @kakaomsginvitecnt kakaomsginvitecnt, @kakaomsginvitetodaycnt kakaomsginvitetodaycnt, @kakaomsginvitetodaydate kakaomsginvitetodaydate

	select top 1
		@sendedday = datediff(d, senddate, getdate())
	from dbo.tFVKakaoInvite
	where gameid = @gameid_ and receuserid = @kakaouserid_
	--select 'DEBUG 3', @sendedday sendedday

	------------------------------------------------
	--	3-3. ��������.
	------------------------------------------------
	if (@gameid = '')
		begin
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR ���̵� �������� �ʴ´�.'
			--select 'DEBUG 3' + @comment
		end
	else if (@sendedday < @SENDEDDAY_LIMIT)
		begin
			set @nResult_ 	= @RESULT_ERROR_TIME_REMAIN
			set @comment 	= 'ERROR �ð��� �����ֽ��ϴ�.'
			--select 'DEBUG 3' + @comment
		end
	else
		begin
			set @nResult_ = @RESULT_SUCCESS
			set @comment = '�ʴ븦 �����߽��ϴ�.'
			--select 'DEBUG 4', @comment

			-------------------------------------
			-- �� �ʴ�(O)
			-------------------------------------
			exec spu_FVDayLogInfoStatic 5, 17, 1               -- �� �ʴ�

			--30�� �̻��̸� ������ �ִ�.
			if(@sendedday = @SENDEDDAY_INIT)
				begin
					--select 'DEBUG 4-3 �����Է�'
					insert into dbo.tFVKakaoInvite(gameid,   receuserid)
					values(                     @gameid_, @kakaouserid_)
				end
			else --if(@sendedday >= @SENDEDDAY_LIMIT)
				begin
					--select 'DEBUG 4-2 30�� ����ؼ� ����'
					update dbo.tFVKakaoInvite
						set
							cnt 		= cnt + 1,
							senddate 	= getdate()
					where gameid = @gameid_ and receuserid = @kakaouserid_
				end
			-------------------------------------------------
			-- 1 �� �ʴ��ѵ�
			-------------------------------------------------
			set @tmpcnt = datediff(d, @kakaomsginvitetodaydate, getdate())
			if(@tmpcnt >= 1)
				begin
					set @kakaomsginvitetodaycnt		= 0
					set @kakaomsginvitetodaydate 	= getdate()
				end
			set @kakaomsginvitetodaycnt	= @kakaomsginvitetodaycnt + 1

			-------------------------------------------------
			-- ���� �Ը���Ʈ ����.
			-------------------------------------------------
			set @kakaomsginvitecnt 	= @kakaomsginvitecnt + 1
			set @giftcode 			= @KAKAO_MSG_INVITE_STEP0_NON
			if(@kakaomsginvitecnt = @KAKAO_MSG_INVITE_STEP1)
				begin
					set @giftcode 	= @kakaoinvite01
					set @cnt		= @kakaoinvitecnt01
					--select 'DEBUG > 1�ܰ�'
				end
			else if(@kakaomsginvitecnt = @KAKAO_MSG_INVITE_STEP2)
				begin
					set @giftcode 	= @kakaoinvite02
					set @cnt		= @kakaoinvitecnt02
					--select 'DEBUG > 2�ܰ�'
				end
			else if(@kakaomsginvitecnt = @KAKAO_MSG_INVITE_STEP3)
				begin
					set @giftcode 	= @kakaoinvite03
					set @cnt		= @kakaoinvitecnt03
					--select 'DEBUG > 3�ܰ�'
				end
			else if(@kakaomsginvitecnt = @KAKAO_MSG_INVITE_STEP4)
				begin
					set @giftcode 	= @kakaoinvite04
					set @cnt		= @kakaoinvitecnt04
					--select 'DEBUG > 4�ܰ�'
				end
			else if(@kakaomsginvitecnt = @KAKAO_MSG_INVITE_STEP5)
				begin
					set @giftcode 	= @kakaoinvite05
					set @cnt		= @kakaoinvitecnt05
					--select 'DEBUG > 5�ܰ�'
				end
			else if(@kakaomsginvitecnt = @KAKAO_MSG_INVITE_STEP6)
				begin
					set @giftcode 	= @kakaoinvite06
					set @cnt		= @kakaoinvitecnt06
					--select 'DEBUG > 6�ܰ�'
				end
			else if(@kakaomsginvitecnt = @KAKAO_MSG_INVITE_STEP7)
				begin
					set @giftcode 	= @kakaoinvite07
					set @cnt		= @kakaoinvitecnt07
					--select 'DEBUG > 6�ܰ�'
				end
			else if(@kakaomsginvitecnt = @KAKAO_MSG_INVITE_STEP8)
				begin
					set @giftcode 	= @kakaoinvite08
					set @cnt		= @kakaoinvitecnt08
					--select 'DEBUG > 6�ܰ�'
				end
			else if(@kakaomsginvitecnt = @KAKAO_MSG_INVITE_STEP9)
				begin
					set @giftcode 	= @kakaoinvite09
					set @cnt		= @kakaoinvitecnt09
					--select 'DEBUG > 6�ܰ�'
				end
			else if(@kakaomsginvitecnt = @KAKAO_MSG_INVITE_STEP10)
				begin
					set @giftcode 	= @kakaoinvite10
					set @cnt		= @kakaoinvitecnt10
					--select 'DEBUG > 6�ܰ�'
				end

			--select 'DEBUG 4-4', @kakaomsginvitecnt kakaomsginvitecnt, @giftcode giftcode, @cnt cnt
			if(@giftcode != @KAKAO_MSG_INVITE_STEP0_NON)
				begin
					--select 'DEBUG 4-5 > ������ ����'
					exec spu_FVSubGiftSend 2, @giftcode, @cnt, 'FacebookInv', @gameid_, ''
				end

		end

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	select @nResult_ rtn, @comment comment, @kakaomsginvitecnt kakaomsginvitecnt, @kakaomsginvitetodaycnt kakaomsginvitetodaycnt, @kakaomsginvitetodaydate kakaomsginvitetodaydate
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			------------------------------------------------
			-- ��������
			------------------------------------------------
			update dbo.tFVUserMaster
				set
					kakaomsginvitecnt 		= @kakaomsginvitecnt,
					kakaomsginvitetodaycnt 	= @kakaomsginvitetodaycnt,
					kakaomsginvitetodaydate = @kakaomsginvitetodaydate
			where gameid = @gameid_

			--------------------------------------------------------------
			-- ī�� �ʴ�ģ����
			--------------------------------------------------------------
			select * from dbo.tFVKakaoInvite where gameid = @gameid_ and senddate >= (getdate() - 30)

			--------------------------------------------------------------
			-- ����������.
			-- ������ > �󸮽�Ʈ�� �������ֱ�
			--------------------------------------------------------------
			if(@giftcode != @KAKAO_MSG_INVITE_STEP0_NON)
				begin
					exec spu_FVGiftList @gameid_
				end
			else
				begin
					exec spu_FVGiftList ''
				end

		end

	--���� ����� �����Ѵ�.
	set nocount off
End



