/*
update dbo.tFVUserMaster set kakaomsginvitecnt = 9, kakaomsginvitetodaycnt = 0, kakaomsginvitetodaydate = kakaomsginvitetodaydate - 1 	where gameid = 'xxxx2'
update dbo.tFVUserMaster set kakaomsginvitetodaydate = kakaomsginvitetodaydate - 1 	where gameid = 'xxxx2'
update dbo.tFVKakaoInvite set senddate = senddate - 31 where gameid = 'xxxx2'
-- delete from dbo.tFVKakaoInvite where gameid = 'xxxx2'
-- delete from dbo.tFVGiftList where gameid = 'xxxx2'
exec spu_FVKakaoFriendInvite 'xxxx2',  '049000s1i0n7t8445289', 'kakaouseridxxxx', -1
exec spu_FVKakaoFriendInvite 'xxxx2',  '049000s1i0n7t8445289', 'kakaouseridxxxx3', -1

*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVKakaoFriendInvite', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVKakaoFriendInvite;
GO

create procedure dbo.spu_FVKakaoFriendInvite
	@gameid_				varchar(60),
	@password_				varchar(20),
	@kakaouserid_			varchar(20),
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

	-- ���� ���ǰ�
	declare @GIFTLIST_GIFT_KIND_MESSAGE			int				set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int				set @GIFTLIST_GIFT_KIND_GIFT				= 2
	--declare @GIFTLIST_GIFT_KIND_MESSAGE_DEL	int				set @GIFTLIST_GIFT_KIND_MESSAGE_DEL			= -1
	--declare @GIFTLIST_GIFT_KIND_GIFT_DEL		int				set @GIFTLIST_GIFT_KIND_GIFT_DEL			= -2
	--declare @GIFTLIST_GIFT_KIND_GIFT_GET		int				set @GIFTLIST_GIFT_KIND_GIFT_GET			= -3
	--declare @GIFTLIST_GIFT_KIND_GIFT_SELL		int				set @GIFTLIST_GIFT_KIND_GIFT_SELL			= -4

	-- ������ �Һз�
	declare @ITEM_SUBCATEGORY_PET				int					set @ITEM_SUBCATEGORY_PET					= 1000 	--��(1000)

	-- �ʴ뿡 ���� ���.
	declare @SENDEDDAY_INIT						int				set @SENDEDDAY_INIT						= 99999
	declare @SENDEDDAY_LIMIT					int				set @SENDEDDAY_LIMIT					= 30

	declare @KAKAO_MSG_INVITE_STEP1				int				set @KAKAO_MSG_INVITE_STEP1				= 10
	declare @KAKAO_MSG_INVITE_STEP2				int				set @KAKAO_MSG_INVITE_STEP2				= 20
	declare @KAKAO_MSG_INVITE_STEP3				int				set @KAKAO_MSG_INVITE_STEP3				= 30
	declare @KAKAO_MSG_INVITE_STEP4				int				set @KAKAO_MSG_INVITE_STEP4				= 40

	-- ī�� ģ���ʴ� ����.
	declare @KAKAO_MSG_INVITE_STEP0_NON			int				set @KAKAO_MSG_INVITE_STEP0_NON			= -1
	--declare @KAKAO_MSG_INVITE_STEP1_ITEMCODE	int				set @KAKAO_MSG_INVITE_STEP1_ITEMCODE	= 2000
	--declare @KAKAO_MSG_INVITE_STEP2_ITEMCODE	int				set @KAKAO_MSG_INVITE_STEP2_ITEMCODE	= 1005
	--declare @KAKAO_MSG_INVITE_STEP3_ITEMCODE	int				set @KAKAO_MSG_INVITE_STEP3_ITEMCODE	= 6
	--declare @KAKAO_MSG_INVITE_STEP4_ITEMCODE	int				set @KAKAO_MSG_INVITE_STEP4_ITEMCODE	= 100003

	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @comment			varchar(128)
	declare @gameid				varchar(60)		set @gameid				= ''
	declare @market				int				set @market				= 0
	declare @kakaomsginvitecnt	int				set @kakaomsginvitecnt	= 0
	declare @giftcode			int				set @giftcode			= @KAKAO_MSG_INVITE_STEP0_NON
	declare @sendedday			int				set @sendedday			= @SENDEDDAY_INIT
	declare @kakaomsginvitetodaycnt		int			set @kakaomsginvitetodaycnt		= 0
	declare @kakaomsginvitetodaydate	datetime	set @kakaomsginvitetodaydate	= getdate()

	declare @cashcost			int				set @cashcost		= 0
	declare @gamecost			int				set @gamecost		= 0
	declare @heart				int				set @heart			= 0
	declare @feed				int				set @feed			= 0
	declare @fpoint				int				set @fpoint			= 0
	declare @tmpcnt				int

	declare @subcategory	int					set @subcategory 		= -1
	declare @kakaoinvite01	int					set @kakaoinvite01 		= 2000
	declare @kakaoinvite02	int					set @kakaoinvite02 		= 1005
	declare @kakaoinvite03	int					set @kakaoinvite03 		= 6
	declare @kakaoinvite04	int					set @kakaoinvite04		= 100003
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
		@gameid 			= gameid,
		@market				= market,
		@cashcost			= cashcost,
		@gamecost			= gamecost,
		@heart				= heart,
		@feed				= feed,
		@fpoint 			= fpoint,
		@kakaomsginvitecnt 			= kakaomsginvitecnt,
		@kakaomsginvitetodaycnt 	= kakaomsginvitetodaycnt,
		@kakaomsginvitetodaydate	= kakaomsginvitetodaydate
	from dbo.tFVUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 2', @gameid gameid, @kakaomsginvitecnt kakaomsginvitecnt, @kakaomsginvitetodaycnt kakaomsginvitetodaycnt, @kakaomsginvitetodaydate kakaomsginvitetodaydate

	select top 1
		@sendedday = datediff(d, senddate, getdate())
	from dbo.tFVKakaoInvite
	where gameid = @gameid_ and recetalkid = @kakaouserid_
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
			-- �� īī���ʴ�(O)
			-------------------------------------
			exec spu_FVDayLogInfoStatic @market, 15, 1

			--30�� �̻��̸� ������ �ִ�.
			if(@sendedday = @SENDEDDAY_INIT)
				begin
					--select 'DEBUG 4-3 �����Է�'
					insert into dbo.tFVKakaoInvite(gameid,   recetalkid)
					values(                     @gameid_, @kakaouserid_)
				end
			else --if(@sendedday >= @SENDEDDAY_LIMIT)
				begin
					--select 'DEBUG 4-2 30�� ����ؼ� ����'
					update dbo.tFVKakaoInvite
						set
							cnt 		= cnt + 1,
							senddate 	= getdate()
					where gameid = @gameid_ and recetalkid = @kakaouserid_
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
			-- �ý��ۿ��� �ʴ� �����о����.
			-------------------------------------------------
			select top 1
				@kakaoinvite01 = kakaoinvite01,
				@kakaoinvite02 = kakaoinvite02,
				@kakaoinvite03 = kakaoinvite03,
				@kakaoinvite04 = kakaoinvite04
			from dbo.tFVSystemInfo
			order by idx desc

			-------------------------------------------------
			-- 10	2000		��Ʈ100��
			-- 20	1005		�˹��� ����12��
			-- 30	6			������������� 1����x2
			-- 40	100003		�絿�� ũ�� ������
			-- ���� �Ը���Ʈ ����.
			-------------------------------------------------
			set @kakaomsginvitecnt 		= @kakaomsginvitecnt + 1
			set @giftcode = case
								when (@kakaomsginvitecnt = @KAKAO_MSG_INVITE_STEP1) then @kakaoinvite01
								when (@kakaomsginvitecnt = @KAKAO_MSG_INVITE_STEP2) then @kakaoinvite02
								when (@kakaomsginvitecnt = @KAKAO_MSG_INVITE_STEP3) then @kakaoinvite03
								when (@kakaomsginvitecnt = @KAKAO_MSG_INVITE_STEP4) then @kakaoinvite04
								else													 @KAKAO_MSG_INVITE_STEP0_NON
							end

			--select 'DEBUG 4-4', @kakaomsginvitecnt kakaomsginvitecnt, @giftcode giftcode
			if(@giftcode != @KAKAO_MSG_INVITE_STEP0_NON)
				begin
					--select 'DEBUG 4-5 > ������ ����'
					exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT, @giftcode, 'KakaoInv', @gameid_, ''				-- Ư�������� ����

					select @subcategory = subcategory from dbo.tFVItemInfo where itemcode = @giftcode

					if(@subcategory = @ITEM_SUBCATEGORY_PET)
						begin
							Exec Spu_Subgiftsend @GIFTLIST_GIFT_KIND_MESSAGE, -1, 'KakaoInv', @gameid_, '���� ������ ������ [�꺯��]���� Ȯ�� �մϴ�.'
						end
				end
			set @heart = @heart + 20
		end

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost, @heart heart, @feed feed, @fpoint fpoint, @kakaomsginvitecnt kakaomsginvitecnt, @kakaomsginvitetodaycnt kakaomsginvitetodaycnt, @kakaomsginvitetodaydate kakaomsginvitetodaydate
	if(@nResult_ = @RESULT_SUCCESS)
		begin
			------------------------------------------------
			-- ��������
			------------------------------------------------
			update dbo.tFVUserMaster
				set
					heart 					= @heart,
					kakaomsginvitecnt 		= @kakaomsginvitecnt,
					kakaomsginvitetodaycnt 	= @kakaomsginvitetodaycnt,
					kakaomsginvitetodaydate = @kakaomsginvitetodaydate
			where gameid = @gameid_

			--------------------------------------------------------------
			-- ī�� �ʴ�ģ����
			--------------------------------------------------------------
			select * from dbo.tFVKakaoInvite where gameid = @gameid_

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



