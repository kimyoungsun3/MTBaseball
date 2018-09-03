use Game4FarmVill4
Go
/*
-- update dbo.tFVNotice set syscheck = 0
-- update dbo.tFVUserData set savedate = '2001-01-01' where gameid = 'xxxx2'
-- select rkteam, gameid, * from dbo.tFVUserMaster where gameid in ( 'xxxx2', 'farm81499', 'farm99545')
-- update dbo.tFVUserMaster set cashcopy = 2 where gameid = 'xxxx2'
-- update dbo.tFVUserMaster set heartget = 0, heartcnt = 0, heartdate = '20010101' where gameid = 'xxxx2'
-- update dbo.tFVUserMaster set heartget = 10, heartcnt = 10, heartdate = '20010101' where gameid = 'xxxx2'
-- update dbo.tFVUserMaster set heartget = 10, heartcnt = 10, heartdate = '20150202' where gameid = 'xxxx2'
-- update dbo.tFVUserMaster set heartget = 10, heartcnt = 50, heartdate = '20150202' where gameid = 'xxxx2'

update dbo.tFVUserData set savedate = '2001-01-01' where gameid = 'xxxx2'
exec spu_FVLogin 'xxxx2', '049000s1i0n7t8445289', 5, 199, 0, -1			-- ��������
exec spu_FVLogin 'xxxx3', '049000s1i0n7t8445289', 5, 199, 0, -1			-- ��������

-----------------------------------------------------------
update dbo.tFVUserData set savedate = getdate() - 1 where gameid = 'farm69572'
exec spu_FVLogin 'xxxx2', '049000s1i0n7t8445289', 5, 199, 0, -1			-- ��������


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
	declare @RESULT_ERROR_NOT_FOUND_PASSWORD	int				set @RESULT_ERROR_NOT_FOUND_PASSWORD	= -17
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
	declare @GIFTLIST_GIFT_KIND_MESSAGE			int					set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
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
	declare @KAKAO_MESSAGE_INVITE_ID			int					set @KAKAO_MESSAGE_INVITE_ID 				= 3210	--�ʴ��ϱ� A
	declare @KAKAO_MESSAGE_PROUD_ID				int					set @KAKAO_MESSAGE_PROUD_ID 				= 3207	--�ڶ��ϱ�A
	declare @KAKAO_MESSAGE_HEART_ID				int					set @KAKAO_MESSAGE_HEART_ID 				= 3208	--��Ʈ����C
	declare @KAKAO_MESSAGE_RETURN_ID			int					set @KAKAO_MESSAGE_RETURN_ID				= 3209	--�����̺�Ʈ

	-- ��⺹�ͱ���.
	declare @RETURN_LIMIT_DAY					int					set @RETURN_LIMIT_DAY				= 30 	-- ���ϰ� �����ΰ�?.
	declare @RETURN_FLAG_OFF					int					set @RETURN_FLAG_OFF				= -1 	-- On(1), Off(-1)
	declare @RETURN_FLAG_ON						int					set @RETURN_FLAG_ON					= 1 	--
	-------------------------------------------------------------------
	-- Event1. ���� ���� �����ϴ� ������.
	-------------------------------------------------------------------
	declare @EVENT_STATE_NON					int					set @EVENT_STATE_NON				=-1
	declare @EVENT_STATE_YES					int					set @EVENT_STATE_YES				= 1

	------------------------------------------------
	--	NHN, LGT ���� �̺�Ʈ
	-- ~ 2015.01.31
	-- 1. ��õ�� ��÷�� ���ؼ� ����
	-- 2. ���� ù���� ����
	-- 3. �������� ���
	--	> ��������		: 500	3015
	--	> �ٳ��� ���� 	: 200	3004
	--	> ��ũ��		: 200	3005
	--	> ������ 		: 500	3003
	------------------------------------------------
	declare @EVENT02_END_DAY					datetime			set @EVENT02_END_DAY			= '2015-01-31 23:59'

	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @comment				varchar(512)			set @comment		= ''
	declare @comment2				varchar(128)			set @comment2		= ''
	declare @gameid 				varchar(60)				set @gameid			= ''
	declare @nickname 				varchar(20)				set @nickname		= ''
	declare @market					int						set @market			= @MARKET_GOOGLE
	declare @curdate				datetime				set @curdate		= getdate()
	declare @blockstate				int
	declare @kakaostatus			int						set @kakaostatus	= 1
	declare @cashcopy				int
	declare @ownercashcost			bigint					set @ownercashcost	= 0
	declare @bestani				int						set @bestani		= 500
	declare @rebirthdate			datetime				set @rebirthdate 	= getdate()		-- ȯ����.
	declare @sameweek				int						set @sameweek		= 0
	declare @eventspot12			int						set @eventspot12	= 0
	declare @eventspot13			int						set @eventspot13	= 0

	declare @curversion				int						set @curversion		= -1
	declare @cursyscheck			int
	declare @patchurl				varchar(512)
	declare @recurl					varchar(512)

	-- �ð�üŷ
	declare @dateid8 				varchar(8) 				set @dateid8 		= Convert(varchar(8), Getdate(),112)
	declare @logindate				varchar(8)				set @logindate		= '20100101'
	declare @attendnewday			int						set @attendnewday	= -1
	declare @roulette				int						set @roulette		= -1

	-- ��Ʈ����.
	declare @heartget2		int						set @heartget2		= 0
	declare @heartget		int						set @heartget		= 0
	declare @heartcnt		int						set @heartcnt		= 0
	--declare @heartcntmax	int						set @heartcntmax	= 400
	declare @heartdate		varchar(8)				set @heartdate		= '20100101'

	-- ��������
	declare @ntcomment				varchar(8000)			set @ntcomment	= ''

	-- Event1 > ������ �ð��� �α����ϸ� ��������~~~
	declare @eventstatemaster		int				set @eventstatemaster			= @EVENT_STATE_NON
	declare @eventidx				int				set @eventidx					= -1
	declare @eventidx2				int
	declare @eventitemcode			int				set @eventitemcode				= -1
	declare @eventcnt				int				set @eventcnt					= 0
	declare @eventsender 			varchar(20)		set @eventsender				= 'sangsang'
	declare @curyear				int				set @curyear					= DATEPART("yy", @curdate)
	declare @curmonth				int				set @curmonth					= DATEPART("mm", @curdate)
	declare @curday					int				set @curday						= DATEPART(dd, @curdate)
	declare @curhour				int				set @curhour					= DATEPART(hour, @curdate)
	declare @idx2					int				set @idx2 						= 0

	-- ���̺굥��Ÿ.
	declare @savedata				varchar(8000)	set @savedata					= ''
	declare @strmarket				varchar(40)
	declare @savedate				datetime		set @savedate		= getdate()
	declare @pausetick				int				set @pausetick		= 0

	-- 1�� �ʴ� �ο� �ʱ�ȭ.
	declare @kakaomsginvitetodaycnt		int			set @kakaomsginvitetodaycnt		= 0
	declare @kakaomsginvitetodaydate	datetime	set @kakaomsginvitetodaydate	= getdate()


	-- �ڽ��� ��������.
	declare @kkhelpalivecnt			int				set @kkhelpalivecnt				= 0
	declare @tmpcnt					int
	declare @rankresult2			int				set @rankresult2				= 0

	-- ��ŷ����.
	declare @schoolinitdate			varchar(19),
			@dw						int

	-- ��������.
	declare @tsgrade2gauage			int,			@tsgrade2free			int,
			@tsgrade3gauage			int,			@tsgrade3free			int,
			@tsgrade4gauage			int,			@tsgrade4free			int

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
	declare @tsgauageflag			int				set @tsgauageflag		= -1

	-- ������ȭ����.
	declare @tsupgradesaleflag		int				set @tsupgradesaleflag	= -1
	declare @tsupgradesalevalue		int				set @tsupgradesalevalue	=  0

	-- �귿(ȸ����)����̱�.
	declare @wheelgauageflag		int				set @wheelgauageflag	= -1

	-- ���� ó��.
	declare @rtnflag				int				set @rtnflag					= @RETURN_FLAG_OFF	-- ���纹�� �÷��� ����.
	declare @rtngameid				varchar(60)		set @rtngameid					= ''
	declare @rtndate				datetime		set @rtndate					= getdate() 		-- 1
	declare @rtnstep				int				set @rtnstep					= 0					-- 1���� 1, 2���� 2....
	declare @rtnplaycnt				int				set @rtnplaycnt					= 0					-- �ŷ�Ƚ��.
	declare @rtnitemcode			int				set @rtnitemcode				= 3015				-- ��û�� : 500����, ���� : 1�� 300����.
	declare @newday					int				set @newday						= 0
	declare @condate				datetime		set @condate					= getdate()

	declare @pos					int				set @pos 						= 0
	declare @pos2					int				set @pos						= 0
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
		@gameid 	= gameid,		@nickname	= nickname,
		@eventspot12= eventspot12,	@eventspot13= eventspot13,
		@bestani	= bestani,
		@roulette	= roulette,
		@blockstate = blockstate,	@kakaostatus = kakaostatus,
		@rebirthdate= rebirthdate,
		@cashcopy	= cashcopy,
		@logindate	= logindate,	@rankresult2= rankresult,
		@rtngameid	= rtngameid, 	@rtndate	= rtndate,
		@rtnstep	= rtnstep, 		@rtnplaycnt	= rtnplaycnt,
		@condate	= condate,
		@heartget	= heartget, 	@heartcnt	= heartcnt,		@heartdate	= heartdate,
		@kakaomsginvitetodaycnt 	= kakaomsginvitetodaycnt,
		@kakaomsginvitetodaydate	= kakaomsginvitetodaydate
	from dbo.tFVUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG ��������', @gameid gameid, @blockstate blockstate, @logindate logindate, @heartdate heartdate, @condate condate

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
			-- ���� ��������(�������� ���� ����2 > �α����� �����ϱ� ���� ��2�� ���)
			-- Event1 ������ �ð��� �α����ϸ� ��������~~~
			-- 		step1 : �����Ͱ� ������
			--		step2 : ���� <= ���� < �� (������)
			--				=> �̺�Ʈ�ڵ�, �������ڵ�, ������
			--		step3 : �ش� ���� ����, �������� ���(tEventUser)
			-------------------------------------------------------------------
			select @eventstatemaster = eventstatemaster from dbo.tFVEventMaster where idx = 1
			--select 'DEBUG �����̺�Ʈ1-1', @eventstatemaster eventstatemaster
			if(@eventstatemaster = @EVENT_STATE_YES)
				begin
					select top 1
						@eventidx 		= eventidx,
						@eventitemcode 	= eventitemcode,
						@eventcnt		= eventcnt,
						@eventsender 	= eventsender
					from dbo.tFVEventSub
					where @curday = eventday and eventstarthour <= @curhour and @curhour <= eventendhour and eventstatedaily = @EVENT_STATE_YES
					order by eventidx desc

					set @eventidx2 = (@curyear - 2015)*1000000 + @curmonth*10000 + @curday*100 + @eventidx
					--select 'DEBUG �����̺�Ʈ1-2', @eventidx eventidx, @eventitemcode eventitemcode, @eventsender eventsender, @eventidx2 eventidx2

					if(@eventidx != -1 and @eventitemcode != -1)
						begin
							--select 'DEBUG �����̺�Ʈ1-3'
							if(not exists(select top 1 * from dbo.tFVEvnetUserGetLog where gameid = @gameid_ and eventidx = @eventidx2))
								begin
									--select 'DEBUG �����̺�Ʈ1-4 ����, �αױ��', @eventitemcode eventitemcode, @eventcnt eventcnt, @eventsender eventsender, @gameid_ gameid_
									exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @eventitemcode, @eventcnt, @eventsender, @gameid_, 'login'

									insert into dbo.tFVEvnetUserGetLog(gameid,   eventidx,   eventitemcode)
									values(                           @gameid_, @eventidx2, @eventitemcode)

									-- �ڼ��� �ΰ�� �����Կ� �־ �����ص� �ȴ�.
									select @idx2 = max(idx) from dbo.tFVEvnetUserGetLog
									delete from tFVEvnetUserGetLog where idx <= @idx2 - 8800
								end
						end
				end

			------------------------------------------------------------------
			-- ���� > �α��� ī����
			------------------------------------------------------------------
			if(@logindate != @dateid8)
				begin
					exec spu_FVDayLogInfoStatic @market_, 12, 1               -- �� �α���(�ߺ�)
					exec spu_FVDayLogInfoStatic @market_, 14, 1               -- �� �α���(����ũ)
					set @attendnewday 	= 1
					set @roulette		= 1
					--select 'DEBUG �� �α���(����ũ)'
				end
			else
				begin
					exec spu_FVDayLogInfoStatic @market_, 12, 1               -- �� �α���(�ߺ�)
					--select 'DEBUG �� �α���(�ߺ�)'
				end
			set @logindate = @dateid8

			-------------------------------------------------------------------
			-- ���� ó�� �ϱ�.
			--if(@condate >=30)
			--	���ͽ��� 1�ܰ�
			--	�����÷���ī���� Ŭ����
			--	if(��û��¥ 24�ð��̳�, ���̵�) ��û�� ����
			--else if(���ο and ���� >= 1step and ���� >= 5)
			--	���ͽ��� + 1
			--	�����÷���ī���� Ŭ����
			--	if(step > 10)
			--		step = -1
			-------------------------------------------------------------------
			set @newday = datediff(d, @condate, getdate())

			select top 1 @rtnflag = rtnflag from dbo.tFVSystemRouletteMan where roulmarket = @market_ order by idx desc
			--select 'DEBUG ����ó��', @rtnflag rtnflag, @newday newday, @rtnstep rtnstep
			if(@rtnflag = @RETURN_FLAG_ON)
				begin
					--select 'DEBUG ����������(����ON).', @newday newday, @rtnstep rtnstep, @rtnplaycnt rtnplaycnt, @condate condate, @rtndate rtndate, (getdate() - 1) '1����', getdate() '����'
					if(@condate <= (getdate() - @RETURN_LIMIT_DAY))
						begin
							--select 'DEBUG > ���� > ��������.', @rtngameid rtngameid
							set @rtnstep	= 1
							set @rtnplaycnt	= 0

							-- ������ ����.
							exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,    @rtnitemcode, 300, '���ͺ���(1��)', @gameid_, ''

							-- ���� ��û�� ����.
							if(@rtngameid != '' and @rtndate >= (getdate() - 1))
								begin
									--select 'DEBUG > ��뺸��.', @rtngameid rtngameid
									set @comment2 = @nickname + '�� ���� �������� �帳�ϴ�.'
									exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,    @rtnitemcode, 500, '���ͺ���', @rtngameid, ''
									exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_MESSAGE, -1,             0, '��������', @rtngameid, @comment2
								end

							-------------------------------------
							-- ���� �ο���.
							-------------------------------------
							exec spu_FVDayLogInfoStatic @market_, 28, 1				-- �� ���ͼ�.
						end
					else if(@newday >= 1 and @rtnstep >= 1)							-- ������ and ������
						begin
							--select 'DEBUG > ���� > ������.', @newday newday, @rtnstep rtnstep, @rtnplaycnt rtnplaycnt
							set @rtnstep	= @rtnstep + 1
							set @rtnplaycnt	= 0
							set @comment2 = '���ͺ���(' + ltrim(rtrim(str(@rtnstep))) + '��)'

							-- ������ ����.
							if(@rtnstep in (2, 3, 4, 5, 6, 8, 9, 10, 11, 12, 13))
								begin
									exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,    @rtnitemcode, 300, @comment2, @gameid_, ''
								end
							else if(@rtnstep in (7, 14))
								begin
									exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,    3500,           1, @comment2, @gameid_, ''
								end

							if(@rtnstep >= 15)
								begin
									--select 'DEBUG > ���� > �Ϸ�.', @newday newday, @rtnstep rtnstep, @rtnplaycnt rtnplaycnt
									set @rtnstep	= -1
								end
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
			select
				@savedate	= savedate,
				@savedata 	= savedata
			from dbo.tFVUserData where gameid = @gameid_
			set @ownercashcost = dbo.fnu_GetFVSaveDataToCashcost(@savedata)


			---------------------------------------------------
			-- ȯ�������� ��.
			-- �� �� ȭ �� �� �� ��
			--                		> �̹��ֿ� ȯ���� ���.
			---------------------------------------------------
			set @sameweek = dbo.fnu_GetSameWeek( @rebirthdate, GETDATE() )


			-------------------------------------------------------------------
			---- �ڡڡ� ���̺� ���� > ���ְ��� Ŭ�������ֱ�.�ڡڡ�
			-------------------------------------------------------------------
			set @pos = charindex('%30:', @savedata)
			set @pos2 = charindex('%', @savedata, @pos + 4)
			if(@pos + 4 < @pos2)
				begin
					set @savedata = substring(@savedata, 1, @pos + 3)  + substring(@savedata, @pos2, len(@savedata))
					--select 'DEBUG', @savedata savedata
				end

			------------------------------------------------------------------ 
			-- �ڡڡ�3�� ������ ����ڡڡ�
			-- �����е��� ������ ���Ծ� ������ 3������ ������ �����߽��ϴ�. 
			-- �̿� ���׸��� ������ ���� �����е鿡�Դ� 1,000 ���� �ű� �����е鿡�Դ� 3,000��� �׸��� �� �����е鿡�Դ� �����ְ��Ƽ�� 1���� 100���� �帳�ϴ�. 
			-- ������ 8�� 31�ϱ����̸� �α����Ͻø� ���������� ���޵˴ϴ�.
			------------------------------------------------------------------ 
			if(@eventspot12 = 0 and @curdate < '2015-08-31 23:59')
				begin
					exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT, 3015, 2000, '������ ����', @gameid_, ''
					set @eventspot12 = @eventspot12 + 1
				end
				
			if(@eventspot13 = 0 and @curdate < '2015-08-31 23:59')
				begin
					exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT, 3015, 1000, '3�� ��������', @gameid_, ''
					exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT, 3601,    1, '3�� ��������', @gameid_, ''
					set @eventspot13 = @eventspot13 + 1
				end
				

			-------------------------------------------------------------------
			-- ���̺� �ð��� �̿��ؼ� ƽ����ϱ�.
			-- ���̺� - ����ð� > ��(1��ƽ) / 15 > 15��ƽ > 40ƽ���� �̿�
			-------------------------------------------------------------------
			set @pausetick = dbo.fnu_GetDatePart('mi', @savedate, @curdate) / 15
			set @pausetick = case
								when (@pausetick >= 40) then 40
								when (@pausetick <   0) then  0
								else 						 @pausetick
							end
			--select 'DEBUG ', @pausetick pausetick, @savedate savedate, @curdate curdate


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
				@tsgauageflag	= case when (@curdate > roulstart and @curdate <= roulend) then pmgauageflag 	else -1 end,

				-- ������ȭ����
				@tsupgradesaleflag	= case when (@curdate > roulstart and @curdate <= roulend) then tsupgradesaleflag	else -1 end,
				@tsupgradesalevalue	= case when @tsupgradesaleflag = -1 then 0 else tsupgradesalevalue end,

				-- �귿(ȸ����)����̱�.> xȸ�Ŀ� 1ȸ ����.
				@wheelgauageflag	= case when (@curdate > roulstart and @curdate <= roulend) then wheelgauageflag		else -1 end
			from dbo.tFVSystemRouletteMan
			where roulmarket = @market
			order by idx desc
			--select 'DEBUG ', @roulrewardflag roulrewardflag, @roultimeflag roultimeflag, @tsgauageflag tsgauageflag, @tsupgradesaleflag tsupgradesaleflag, @tsupgradesalevalue tsupgradesalevalue


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
					eventspot12		= @eventspot12,
					eventspot13		= @eventspot13,

					kakaomsgblocked	= case
											when (@kakaomsgblocked_ = @KAKAO_MESSAGE_BLOCKED_NON) 	then kakaomsgblocked
											when (@kakaomsgblocked_ = @KAKAO_MESSAGE_BLOCK) 	then @KAKAO_MESSAGE_BLOCK
											else kakaomsgblocked
									end,
					logindate		= @logindate,		-- �α��γ�¥��.
					roulette		= @roulette,


					heartget		= @heartget,
					heartcnt		= @heartcnt,
					heartdate		= @heartdate,

					-- ������������.
					--rtngameid		= @rtngameid,
					--rtndate		= @rtndate,
					rtnstep			= @rtnstep,
					rtnplaycnt		= @rtnplaycnt,

					kakaomsginvitetodaycnt 	= @kakaomsginvitetodaycnt,
					kakaomsginvitetodaydate = @kakaomsginvitetodaydate,
					sid				= sid + 1,

					rankresult		= 0,
					condate			= getdate(),		-- ����������
					concnt			= concnt + 1		-- ����Ƚ�� +1
			where gameid = @gameid_

			--select 'DEBUG(��)', rkteam, * from dbo.tFVUserMaster where gameid = @gameid_


			----------------------------------------------
			-- ���� ����
			---------------------------------------------
			select
				@sameweek sameweek,
				@pausetick pausetick,
				@rtnstep rtnstep,
				@schoolinitdate userrankinitdate,
				@attendnewday attendnewday, @savedata savedata,
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
				@tsgauageflag tsgauageflag,
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

			---------------------------------------------
			-- ��Ű����ǰ.
			---------------------------------------------
			select top 1 * from dbo.tFVSystemPack
			where famelvmin <= @bestani
				and @bestani <= famelvmax
				and packstate = 1
				and packmarket like @strmarket
				order by newid()
		END

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off
End



