use Game4FarmVill3
Go
/*
-- update dbo.tFVNotice set syscheck = 0
-- select rkteam, gameid, * from dbo.tFVUserMaster where gameid in ( 'xxxx2', 'farm81499', 'farm99545')
-- update dbo.tFVUserMaster set logindate = '20100101', attendcnt = 0 where gameid = 'xxxx2'
-- update dbo.tFVUserMaster set logindate = '20100101' where gameid = 'xxxx2'
-- update dbo.tFVUserMaster set cashcopy = 2 where gameid = 'xxxx2'
-- update dbo.tFVUserMaster set heartget = 0, heartcnt = 0, heartdate = '20010101' where gameid = 'xxxx2'
-- update dbo.tFVUserMaster set heartget = 10, heartcnt = 10, heartdate = '20010101' where gameid = 'xxxx2'
-- update dbo.tFVUserMaster set heartget = 10, heartcnt = 10, heartdate = '20150202' where gameid = 'xxxx2'
-- update dbo.tFVUserMaster set heartget = 10, heartcnt = 50, heartdate = '20150202' where gameid = 'xxxx2'
-- update dbo.tFVUserMaster set roulfreeheartdate = '20150517', roulfreeheartcnt = 3 where gameid = 'xxxx2'

exec spu_FVLogin 'xxxx2', '049000s1i0n7t8445289', 5, 199, 0, -1			-- ��������
exec spu_FVLogin 'xxxx3', '049000s1i0n7t8445289', 5, 199, 0, -1			-- ��������

exec spu_FVLogin 'farm60212', '5928457n0i5f0d464334', 5, 199, 0, -1
exec spu_FVLogin 'farm99545', '5825491m3y4n5n274413', 5, 199, 0, -1


-----------------------------------------------------------
-- 01087861226		farm75591		4029599r4x0h9s174282
-- 01076371226
exec spu_FVLogin 'farm75591', '4029599r4x0h9s174282', 5, 199, 0, -1
-- http://175.117.144.244:8886/Game4FarmVill3/zfvgoo/login.jsp?gameid=farm75591&password=4029599r4x0h9s174282&market=5&version=199&kakaoprofile=&kakaonickname=&kakaomsgblocked=

*/

IF OBJECT_ID ( 'dbo.spu_FVLogin', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVLogin;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_FVLogin
	@gameid_								varchar(60),					-- ���Ӿ��̵�
	@password_								varchar(20),
	@market_								int,							-- (����ó�ڵ�)
	@version_								int,							-- Ŭ�����
	@kakaomsgblocked_						int,
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

	-- �α��� ����.
	declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--������ > �˾�ó���� ��Ʈ�η� ��������.
	declare @RESULT_ERROR_DELETED_USER 			int				set @RESULT_ERROR_DELETED_USER			= -12			--�������� > �˾�ó���� ��Ʈ�η� ��������.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--�ش������� ã�� ����
	--declare @RESULT_ERROR_NOT_FOUND_PASSWORD	int				set @RESULT_ERROR_NOT_FOUND_PASSWORD	= -17
	declare @RESULT_ERROR_SERVER_CHECKING		int				set @RESULT_ERROR_SERVER_CHECKING		= -14			--������ �����ϰ� �ִ�.
	declare @RESULT_NEWVERION_CLIENT_DOWNLOAD 	int				set @RESULT_NEWVERION_CLIENT_DOWNLOAD	= -15			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ��ũó��.
	--declare @RESULT_NEWVERION_FILE_DOWNLOAD 	int				set @RESULT_NEWVERION_FILE_DOWNLOAD		= -16			--�Ź����� ���Դ� > �������� �޾ƶ� �޼��� ó���� ����.

	------------------------------------------------
	--	2-2. ���°�
	------------------------------------------------
	-- ����ó�ڵ�
	declare @MARKET_SKT							int					set @MARKET_SKT						= 1
	declare @MARKET_KT							int					set @MARKET_KT						= 2
	declare @MARKET_LGT							int					set @MARKET_LGT						= 3
	declare @MARKET_GOOGLE						int					set @MARKET_GOOGLE					= 5
	declare @MARKET_NHN							int					set @MARKET_NHN						= 6
	declare @MARKET_IPHONE						int					set @MARKET_IPHONE					= 7

	-- �����°�.
	--declare @BLOCK_STATE_NO					int					set	@BLOCK_STATE_NO					= 0	-- �����¾ƴ�
	declare @BLOCK_STATE_YES					int					set	@BLOCK_STATE_YES				= 1	-- ������

	-- �ý��� üŷ
	--declare @SYSCHECK_NON						int					set @SYSCHECK_NON					= 0
	declare @SYSCHECK_YES						int					set @SYSCHECK_YES					= 1

	-- bool
	declare @BOOL_TRUE							int					set @BOOL_TRUE						= 1
	declare @BOOL_FALSE							int					set @BOOL_FALSE						= 0

	-- ���� ���ǰ�
	--declare @GIFTLIST_GIFT_KIND_MESSAGE		int					set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2
	--declare @GIFTLIST_GIFT_KIND_MESSAGE_DEL	int					set @GIFTLIST_GIFT_KIND_MESSAGE_DEL			= -1
	--declare @GIFTLIST_GIFT_KIND_GIFT_DEL		int					set @GIFTLIST_GIFT_KIND_GIFT_DEL			= -2
	--declare @GIFTLIST_GIFT_KIND_GIFT_GET		int					set @GIFTLIST_GIFT_KIND_GIFT_GET			= -3
	--declare @GIFTLIST_GIFT_KIND_GIFT_SELL		int					set @GIFTLIST_GIFT_KIND_GIFT_SELL			= -4
	--declare @GIFTLIST_GIFT_KIND_LIST			int					set @GIFTLIST_GIFT_KIND_LIST				= -5

	--�޼��� ���ſ���.
	declare @KAKAO_MESSAGE_BLOCKED_NON			int					set @KAKAO_MESSAGE_BLOCKED_NON					= 0
	declare @KAKAO_MESSAGE_ALLOW 				int					set @KAKAO_MESSAGE_ALLOW						= -1		-- īī�� �޼��� �߼۰���.
	declare @KAKAO_MESSAGE_BLOCK 				int					set @KAKAO_MESSAGE_BLOCK						=  1		-- īī�� �޼��� �Ұ���.

	-- īī���� ����.
	declare @KAKAO_MESSAGE_INVITE_ID			int					set @KAKAO_MESSAGE_INVITE_ID 				= 3143	--�ʴ��ϱ� A
	declare @KAKAO_MESSAGE_PROUD_ID				int					set @KAKAO_MESSAGE_PROUD_ID 				= 3142	--�ڶ��ϱ�A
	declare @KAKAO_MESSAGE_HEART_ID				int					set @KAKAO_MESSAGE_HEART_ID 				= 3141	--��Ʈ����C
	declare @KAKAO_MESSAGE_RETURN_ID			int					set @KAKAO_MESSAGE_RETURN_ID				= 3146	--�����̺�Ʈ

	-------------------------------------------------------------------
	-- Event1. ���� ���� �����ϴ� ������.
	-------------------------------------------------------------------
	declare @EVENT_STATE_NON					int					set @EVENT_STATE_NON				=-1
	declare @EVENT_STATE_YES					int					set @EVENT_STATE_YES				= 1

	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @comment				varchar(512)			set @comment		= ''
	declare @gameid 				varchar(60)				set @gameid			= ''
	declare @market					int						set @market			= @MARKET_GOOGLE
	declare @curdate				datetime				set @curdate		= getdate()
	declare @blockstate				int
	declare @kakaostatus			int						set @kakaostatus	= 1
	declare @cashcopy				int
	declare @ownercashcost			bigint					set @ownercashcost	= 0

	declare @curversion				int						set @curversion		= -1
	declare @cursyscheck			int
	declare @patchurl				varchar(512)
	declare @recurl					varchar(512)

	-- �ð�üŷ
	declare @dateid8 				varchar(8) 				set @dateid8 		= Convert(varchar(8), Getdate(),112)
	declare @logindate				varchar(8)				set @logindate		= '20100101'
	declare @attendnewday			int						set @attendnewday	= -1
	declare @attendcnt				int						set @attendcnt		= 0

	-- ��Ʈ����.
	declare @heartget2				int						set @heartget2		= 0
	declare @heartget				int						set @heartget		= 0
	declare @heartcnt				int						set @heartcnt		= 0
	--declare @heartcntmax			int						set @heartcntmax	= 400
	declare @heartdate				varchar(8)				set @heartdate		= '20100101'

	-- ��������
	declare @ntcomment				varchar(4096)			set @ntcomment	= ''

	-- Event1 > �α����ϸ� ��������~~~
	declare @eventidx				int				set @eventidx					= -1
	declare @eventitemcode			int				set @eventitemcode				= -1
	declare @eventcnt				int				set @eventcnt					= 0
	declare @eventsender 			varchar(60)		set @eventsender				= 'sangsang'
	declare @eventsender2 			varchar(60)		set @eventsender2				= ''

	-- ���̺굥��Ÿ.
	declare @savedata				varchar(4096)	set @savedata					= ''
	declare @strmarket				varchar(40)

	-- 1�� �ʴ� �ο� �ʱ�ȭ.
	declare @kakaomsginvitetodaycnt		int			set @kakaomsginvitetodaycnt		= 0
	declare @kakaomsginvitetodaydate	datetime	set @kakaomsginvitetodaydate	= getdate()

	-- �ڽ��� ��������.
	declare @kkhelpalivecnt			int				set @kkhelpalivecnt				= 0
	declare @tmpcnt					int
	declare @rankresult2			int				set @rankresult2				= 0

	-- ���� ó��.
	declare @rtnflag				int															-- ���纹�� �÷��� ����.
	declare @rtngameid				varchar(60)		set @rtngameid					= ''
	declare @rtndate				datetime		set @rtndate					= getdate() - 1
	declare @rtnstep				int				set @rtnstep					= 0			-- 1���� 1, 2���� 2....
	declare @rtnplaycnt				int				set @rtnplaycnt					= 0			-- �ŷ�Ƚ��.
	declare @rtnitemcode			int				set @rtnitemcode				= 5027		-- ����5.

	-- ��ŷ����.
	declare @schoolinitdate			varchar(19),
			@dw						int

	-- ��������.
	declare @roulcashcostgauage			int,			@roulcashcostfree			int

	-- ��������.
	declare @roulsaleflag			int				set @roulsaleflag		= -1
	declare @roulsalevalue			int				set @roulsalevalue		=  0

	-- ��������.
	declare @roulrewardflag			int				set @roulrewardflag		= -1

	-- ����Ȯ�����.
	declare @roultimeflag			int				set @roultimeflag		= -1
	declare @roultimetime1			int				set @roultimetime1		= -1
	declare @roultimetime2			int				set @roultimetime2		= -1
	declare @roultimetime3			int				set @roultimetime3		= -1
	declare @roultimetime4			int				set @roultimetime4		= -1

	-- ��������̱�.
	declare @roulgauageflag			int				set @roulgauageflag		= -1

	-- ������ȭ����.
	declare @tsupgradesaleflag		int				set @tsupgradesaleflag	= -1
	declare @tsupgradesalevalue		int				set @tsupgradesalevalue	=  0

	-- �귿(ȸ����)����̱�.
	declare @wheeldayfree			int				set @wheeldayfree		= -1		-- 1�� ����ȸ���� ������.
	declare @wheelgauageflag		int				set @wheelgauageflag	= -1		-- ĳ�� ȸ���� ������(10ȸ�ϸ� 1ȸ ���ᵹ����).

	-- �̱� 1�� ��������Ʈ�� 3ȸ �̱�.
	declare @roulfreeheartdate		varchar(8)		set @roulfreeheartdate		= '20100101'
	declare @roulfreeheartcnt		int				set @roulfreeheartcnt		= 0
	declare @curdate8				varchar(8)		set @curdate8				= '20000102'

	-- ĳ�������� 30�ϰ� ����.
	declare @cashdatestart		smalldatetime	set @cashdatestart	= '20000101'
	declare @cashdateend		smalldatetime	set @cashdateend	= '20000101'
	declare @cashdatecur		smalldatetime	set @cashdatecur	= '20000101'
	declare @curdate2			smalldatetime	set @curdate2		= Convert(varchar(8), Getdate(), 112)
	declare @cashreward			int				set @cashreward		= -1
	declare @cashcnt			int				set @cashcnt		= 0
	declare @cashsender			varchar(60)		set @cashsender		= ''
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG �Է�����', @gameid_ gameid_, @password_ password_, @market_ market_, @version_ version_, @kakaomsgblocked_ kakaomsgblocked_

	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	select
		@gameid 		= gameid,
		@attendcnt 		= attendcnt,
		@wheeldayfree	= wheeldayfree,
		@cashdatestart	= cashdatestart, 	@cashdateend = cashdateend,		@cashdatecur = cashdatecur,
		@roulfreeheartdate	= roulfreeheartdate,	@roulfreeheartcnt	= roulfreeheartcnt,
		@blockstate 	= blockstate,	@kakaostatus = kakaostatus,
		@cashcopy		= cashcopy,
		@logindate		= logindate,	@rankresult2= rankresult,
		@heartget		= heartget, 	@heartcnt	= heartcnt,		@heartdate	= heartdate,
		@kakaomsginvitetodaycnt 	= kakaomsginvitetodaycnt,
		@kakaomsginvitetodaydate	= kakaomsginvitetodaydate
	from dbo.tFVUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG ��������', @gameid gameid, @blockstate blockstate, @logindate logindate, @heartdate heartdate

	------------------------------------------------
	--	3-3. �������� üũ
	------------------------------------------------
	select top 1
		@cursyscheck 	= syscheck,
		@curversion 	= version,
		@patchurl		= patchurl,
		@recurl			= recurl,
		@ntcomment		= comment
	from dbo.tFVNotice
	where market = @market_
	order by idx desc
	--select 'DEBUG ��������', @cursyscheck cursyscheck, @curversion curversion, @patchurl patchurl, @recurl recurl

	if(@cursyscheck = @SYSCHECK_YES)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_SERVER_CHECKING
			set @comment 	= 'DEBUG �ý��� �������Դϴ�.'
			--select 'DEBUG ', @comment
		END
	else if(@gameid = '')
		BEGIN
			-- ���̵� ���������ʴ°�??
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '���̵� �������� �ʴ´�. > ���̵� Ȯ���ض�.'
			--select 'DEBUG ', @comment
		END
	else if(@version_ < @curversion)
		BEGIN
			-- ���Ϻ� ������ Ʋ����
			set @nResult_ 	= @RESULT_NEWVERION_CLIENT_DOWNLOAD
			set @comment 	= '���Ϻ� ������ Ʋ����. > �ٽù޾ƶ�.'
			--select 'DEBUG ', @comment
		END
	else if (@blockstate = @BLOCK_STATE_YES)
		BEGIN
			-- �������ΰ�?
			set @nResult_ 	= @RESULT_ERROR_BLOCK_USER
			set @comment 	= '��ó���� ���̵��Դϴ�.'
			--select 'DEBUG ', @comment
		END
	else if (@kakaostatus = -1)
		BEGIN
			-- ������ �����Դϴ�.
			set @nResult_ 	= @RESULT_ERROR_DELETED_USER
			set @comment 	= '���̵� �����Ǿ����ϴ�.'
			--select 'DEBUG ', @comment
		END
	else if(@cashcopy >= 2)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_BLOCK_USER
			set @comment 	= 'ĳ������ī�Ǹ� '+ltrim(rtrim(str(@cashcopy)))+'ȸ �̻��ߴ�. > ��ó������!!'
			--select 'DEBUG ', @comment

			-- xxȸ �̻�ī���ൿ > ��ó��, ���αױ��
			update dbo.tFVUserMaster
				set
					blockstate = @BLOCK_STATE_YES,
					cashcopy = 0
			where gameid = @gameid_

			-- ������3ȸ ī�ǿ� ���� ��ó��
			insert into dbo.tFVUserBlockLog(gameid, comment)
			values(@gameid_, '(ĳ������)��  '+ltrim(rtrim(str(@cashcopy)))+'ȸ �̻� ī�Ǹ� �ؼ� �α��ν� �ý��ۿ��� �� ó���߽��ϴ�.')
		END
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '�α��� ����ó��'
			--select 'DEBUG ', @comment
		END


	-----------------------------------------------
	-- ����ڵ�ó��.
	-----------------------------------------------
	select @nResult_ rtn, @comment comment, @patchurl patchurl, @recurl recurl, @curversion curversion, @curdate curdate, @ntcomment ntcomment

	if(@nResult_ = @RESULT_SUCCESS)
		BEGIN
			-------------------------------------------------------------------
			-- ���� ó�� �ϱ�.
			--if(condate >=30)
			--	���ͽ��� 1�ܰ�
			--	�����÷���ī���� Ŭ����
			--	if(��û��¥ 24�ð��̳�, ���̵�) ��û�� ����
			--else if(���ο and ���� >= 1step and ���� >= 5)
			--	���ͽ��� + 1
			--	�����÷���ī���� Ŭ����
			--	if(step > 10)
			--		step = -1
			-------------------------------------------------------------------
			--if(@rtnflag = @RETURN_FLAG_ON)
			--	begin
			--		--select 'DEBUG ����������(����ON).', @newday newday, @rtnstep rtnstep, @rtnplaycnt rtnplaycnt, @condate condate, @rtndate rtndate, (getdate() - 1) '1����', getdate() '����'
			--		if(@condate <= (getdate() - @RETURN_LIMIT_DAY))
			--			begin
			--				--select 'DEBUG > ���� > ��������.', @rtngameid rtngameid
			--				set @rtnstep	= 1
			--				set @rtnplaycnt	= 0
			--				if(@rtngameid != '' and @rtndate >= (getdate() - 1))
			--					begin
			--						--select 'DEBUG > ��뺸��.', @rtngameid rtngameid
			--						set @comment2 = @gameid_ + '�� ���� �������� �帳�ϴ�.'
			--						exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,   @rtnitemcode, '���ͺ���', @rtngameid, ''
			--						exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_MESSAGE, -1, '��������', @rtngameid, @comment2
			--					end
            --
			--				-------------------------------------
			--				-- ���� �ο���.
			--				-------------------------------------
			--				exec spu_FVDayLogInfoStatic @market_, 28, 1				-- �� ���ͼ�.
			--			end
			--		--else if(@newday >= 1 and @rtnstep >= 1 and @rtnplaycnt >= 5)	-- ������ and ������ and ��ǰ����
			--		else if(@newday >= 1 and @rtnstep >= 1)							-- ������ and ������
			--			begin
			--				--select 'DEBUG > ���� > ������.', @newday newday, @rtnstep rtnstep, @rtnplaycnt rtnplaycnt
			--				set @rtnstep	= @rtnstep + 1
			--				set @rtnplaycnt	= 0
			--				if(@rtnstep >= 15)
			--					begin
			--						--select 'DEBUG > ���� > �Ϸ�.', @newday newday, @rtnstep rtnstep, @rtnplaycnt rtnplaycnt
			--						set @rtnstep	= -1
			--					end
			--			end
			--	end

			----------------------------------------------
			-- EVENT > ĳ�������� 30�ϰ� ����.
			-- 3000�� ���� -> 1000������� ��
			----------------------------------------------
			if(@curdate2 >= @cashdatestart and @curdate2 < @cashdateend)
				begin
					--select 'DEBUG > ��ȿ�Ⱓ'
					if(@cashdatecur != @curdate2)
						begin
							set @cashsender 	= '�̺�Ʈ30('+ ltrim(rtrim(str(dbo.fnu_GetDatePart('dd', @cashdatestart, @curdate2) + 1))) +'��)'
							set @cashdatecur 	= @curdate2
							set @cashreward		= 3015
							set @cashcnt		= 100

							exec spu_FVCashCostDaily @gameid_, @cashsender, @cashreward, @cashcnt
							--select 'DEBUG > ����, ���', @cashsender cashsender
						end
				end


			------------------------------------------------------------------
			-- �̱� > ��Ʈ ī���� �ʱ�ȭ.
			------------------------------------------------------------------
			set	@curdate8	= Convert(varchar(8), Getdate(), 112)
			if(@roulfreeheartdate != @curdate8)
				begin
					set @roulfreeheartcnt 	= 0
					set @roulfreeheartdate	= @curdate8
					--select 'DEBUG ��Ʈ�̱� > ��ó��'
				end

			------------------------------------------------------------------
			-- ���� > �α��� ī����
			------------------------------------------------------------------
			if(@logindate != @dateid8)
				begin
					exec spu_FVDayLogInfoStatic @market_, 12, 1               -- �� �α���(�ߺ�)
					exec spu_FVDayLogInfoStatic @market_, 14, 1               -- �� �α���(����ũ)
					set @attendnewday 	= 1
					set @wheeldayfree	= 1
					set @attendcnt  	= CASE WHEN (@attendcnt + 1 > 28) then 1 else (@attendcnt + 1) end
					--select 'DEBUG �� �α���(����ũ)', @attendnewday attendnewday, @wheeldayfree wheeldayfree, @attendcnt attendcnt
				end
			else
				begin
					exec spu_FVDayLogInfoStatic @market_, 12, 1               -- �� �α���(�ߺ�)
					--select 'DEBUG �� �α���(�ߺ�)'
				end
			set @logindate = @dateid8

			------------------------------------------------------------------
			-- �������� > ������
			-- ���� ��������(�������� ���� ����2 > �α����� �����ϱ� ���� ��2�� ���)
			-- Event1 �α����ϸ� ��������~~~
			--		step3 : �ش� ���� ����, �������� ���(tEventUser)
			------------------------------------------------------------------
			--select 'DEBUG', @attendnewday attendnewday, @attendcnt attendcnt
			if(@attendnewday = 1)
				begin
					select top 1
						@eventidx 		= eventidx,
						@eventitemcode 	= eventitemcode,
						@eventcnt		= eventcnt,
						@eventsender 	= eventsender
					from dbo.tFVEventSub
					where eventday = @attendcnt
					--select 'DEBUG ', @eventidx eventidx, @eventitemcode eventitemcode, @eventcnt eventcnt, @eventsender eventsender

					if(@eventidx != -1 and @eventitemcode != -1)
						begin
							set @eventsender2 =  ltrim(rtrim(@attendcnt)) + '�Ϻ���'
							exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT, @eventitemcode, @eventcnt, @eventsender, @gameid_, @eventsender2

							--select 'DEBUG > ����', @eventitemcode eventitemcode, @eventcnt eventcnt, @eventsender eventsender, @gameid_ gameid_, @eventsender2 eventsender2
						end
				end


			---------------------------------------------
			-- ��Ʈ�������۷� �ʱ�ȭ
			---------------------------------------------
			if(@heartdate != @dateid8)
				begin
					--select 'DEBUG �Ϸ� ��¥�� �ٲ� �ʱ�ȭ'
					set @heartdate	= @dateid8
					set @heartcnt = 0
				end
			set @heartget2 = @heartget
			set @heartget = 0

			-------------------------------------------------
			---- ī�� �ʴ��ο� �ʱ�ȭ.
			-------------------------------------------------
			set @tmpcnt = datediff(d, @kakaomsginvitetodaydate, getdate())
			if(@tmpcnt >= 1)
				begin
					set @kakaomsginvitetodaycnt		= 0
					set @kakaomsginvitetodaydate 	= getdate()
				end

			--select 'DEBUG ', @kakaomsginvitetodaycnt kakaomsginvitetodaycnt, @kakaomsginvitetodaydate kakaomsginvitetodaydate

			-----------------------------------------------------------------
			-- ���̺� ����.
			-----------------------------------------------------------------
			select @savedata = savedata from dbo.tFVUserData where gameid = @gameid_
			set @ownercashcost = dbo.fnu_GetFVSaveDataToCashcost(@savedata)

			----------------------------------------------
			-- �б����� �ʱ�ȭ��¥(���� ����� ���� 11:59).
			---------------------------------------------
			select @dw = DATEPART(dw, @curdate)
			set @curdate = @curdate + (7 - @dw)
			set @schoolinitdate = CONVERT(char(10), @curdate, 25) + ' 23:59:00'


			------------------------------------------------
			-- �̱� �̺�Ʈ ���� ��������.
			------------------------------------------------
			select
				top 1
				-- ��������
				@roulsaleflag	= case when (@curdate > roulstart and @curdate <= roulend) then roulsaleflag	else -1 end,
				@roulsalevalue	= case when @roulsaleflag = -1 then 0 else roulsalevalue end,

				-- �������� 	> ������ ������ ��������
				@roulrewardflag = case when (@curdate > roulstart and @curdate <= roulend) then roulflag 		else -1 end,

				-- ����Ȯ����� > Ư�� �ð��� Ȯ�����.
				@roultimeflag	= case when (@curdate > roulstart and @curdate <= roulend) then roultimeflag 	else -1 end,
				@roultimetime1	= roultimetime1,	@roultimetime2	= roultimetime2,	@roultimetime3	= roultimetime3,	@roultimetime4	= roultimetime4,

				-- ��������̱�	> �̱� xȸ�Ŀ� 1ȸ ����.
				@roulgauageflag	= case when (@curdate > roulstart and @curdate <= roulend) then pmgauageflag 	else -1 end,

				-- ������ȭ����
				@tsupgradesaleflag	= case when (@curdate > roulstart and @curdate <= roulend) then tsupgradesaleflag	else -1 end,
				@tsupgradesalevalue	= case when @tsupgradesaleflag = -1 then 0 else tsupgradesalevalue end,

				-- �귿(ȸ����)����̱�.> xȸ�Ŀ� 1ȸ ����.
				@wheelgauageflag	= case when (@curdate > roulstart and @curdate <= roulend) then wheelgauageflag		else -1 end
			from dbo.tFVSystemRouletteMan
			where roulmarket = @market
			order by idx desc
			--select 'DEBUG ', @roulrewardflag roulrewardflag, @roultimeflag roultimeflag, @roulgauageflag roulgauageflag, @tsupgradesaleflag tsupgradesaleflag, @tsupgradesalevalue tsupgradesalevalue


			------------------------------------------------------------------
			-- ���� ������ ������Ʈ�ϱ�
			------------------------------------------------------------------
			--select 'DEBUG(��)', rkteam, * from dbo.tFVUserMaster where gameid = @gameid_

			update dbo.tFVUserMaster
				set
					market			= @market_,
					version			= @version_,
					rkteam			= (CASE WHEN ISNUMERIC(SUBSTRING(gameid, LEN(LTRIM(gameid)), LEN(LTRIM(gameid)))) = 1 THEN CAST(SUBSTRING(gameid, LEN(LTRIM(gameid)), LEN(LTRIM(gameid))) AS INT) ELSE 0 END)%2,
					ownercashcost	= @ownercashcost,

					kakaomsgblocked	= case
											when (@kakaomsgblocked_ = @KAKAO_MESSAGE_BLOCKED_NON) 	then kakaomsgblocked
											when (@kakaomsgblocked_ = @KAKAO_MESSAGE_BLOCK) 	then @KAKAO_MESSAGE_BLOCK
											else kakaomsgblocked
									end,
					logindate		= @logindate,		-- �α��γ�¥��.
					wheeldayfree	= @wheeldayfree,
					attendcnt		= @attendcnt,

					cashdatecur 	= @cashdatecur,

					heartget		= @heartget,
					heartcnt		= @heartcnt,
					heartdate		= @heartdate,
					roulfreeheartcnt= @roulfreeheartcnt,	-- �̱� ��Ʈ
					roulfreeheartdate= @roulfreeheartdate,

					-- ������������.
					--rtngameid		= @rtngameid,
					--rtndate		= @rtndate,
					rtnstep			= @rtnstep,
					rtnplaycnt		= @rtnplaycnt,

					kakaomsginvitetodaycnt 	= @kakaomsginvitetodaycnt,
					kakaomsginvitetodaydate = @kakaomsginvitetodaydate,

					rankresult		= 0,
					condate			= getdate(),		-- ����������
					concnt			= concnt + 1		-- ����Ƚ�� +1
			where gameid = @gameid_

			--select 'DEBUG(��)', rkteam, * from dbo.tFVUserMaster where gameid = @gameid_


			----------------------------------------------
			-- ���� ����
			---------------------------------------------
			select
				@schoolinitdate userrankinitdate,
				@attendnewday attendnewday, @eventitemcode eventitemcode, @eventcnt eventcnt,
				@savedata savedata,
				@KAKAO_MESSAGE_INVITE_ID kakaoinviteid,
				@KAKAO_MESSAGE_PROUD_ID kakaoproudid,
				@KAKAO_MESSAGE_HEART_ID kakaoheartid,
				@KAKAO_MESSAGE_RETURN_ID kakaoreturnid,
				@heartget2 heartget2,
				@rankresult2 rankresult2,
				@roulsaleflag roulsaleflag, @roulsalevalue roulsalevalue,
				@tsupgradesaleflag tsupgradesaleflag, @tsupgradesalevalue tsupgradesalevalue,
				@roulrewardflag roulrewardflag,
				@roultimeflag roultimeflag,
				@roultimetime1 roultimetime1, @roultimetime2 roultimetime2,	@roultimetime3 roultimetime3, @roultimetime4 roultimetime4,
				@roulgauageflag roulgauageflag,
				@cashreward cashreward, @cashcnt cashcnt,
				@wheelgauageflag wheelgauageflag,
				*
			from dbo.tFVUserMaster where gameid = @gameid_

			--------------------------------------------------------------
			-- ���� ģ������   &   �� ŷ
			--------------------------------------------------------------
			exec spu_FVsubFriendRank @gameid_, 1

			--------------------------------------------------------------
			-- ī�� �ʴ�ģ����
			--------------------------------------------------------------
			select * from dbo.tFVKakaoInvite where gameid = @gameid_ and senddate >= (getdate() - 30)

			----------------------------------------------
			-- ��������Ʈ
			---------------------------------------------
			exec spu_FVGiftList @gameid_

			------------------------------------------------
			--	3-2. ��õ����
			------------------------------------------------
			set @strmarket = '%' + ltrim(rtrim(str(@market_))) + '%'
			select m.*, isnull(s.rewarded, -1) rewarded from
			(select idx, comfile, comurl, compackname, rewarditemcode, rewardcnt from dbo.tFVSysRecommend2 where packmarket like @strmarket and syscheck = 1) m
				LEFT JOIN
			(select recommendidx, 1 rewarded from dbo.tFVSysRecommendLog where gameid = @gameid_) s
				ON m.idx = s.recommendidx

			--------------------------------------------------------------
			-- ���� ��ü��ŷ (3���� ������ ��ŷ�� ����)
			--------------------------------------------------------------
			exec spu_FVsubTotalRank @gameid_
		END

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off
End



