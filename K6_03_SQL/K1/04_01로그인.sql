use Farm
Go
/*
-- update dbo.tFVNotice set syscheck = 0
-- select * from dbo.tUserMaster where gameid = 'xxxx@gmail.com'
-- update dbo.tUserMaster set eventspot0x = 0 where gameid = 'xxxx@gmail.com'	 delete from dbo.tFVGiftList where gameid = 'xxxx@gmail.com'

exec spu_FVLogin 'xxxx@gmail.com',  '01022223331', 1, 199, 82, 0, 'pushid', -1			-- ��������
exec spu_FVLogin 'xxxx@gmail.com',  '01022223331', 5, 199, 82, 0, 'pushid', -1			-- ��������
exec spu_FVLogin 'xxxx2@gmail.com', '01022223332', 5, 100, 82, 0, 'pushid', -1			-- ���Ϲ�������
exec spu_FVLogin 'xxxx3@gmail.com', '01022223333', 5, 101, 82, 0, 'pushid', -1			-- ������
exec spu_FVLogin '',                '01022223336', 5, 101, 82, 0, 'pushid', -1			-- ����� ����

exec spu_FVLogin 'xxxx5@gmail.com', '01022223335', 5, 101, 82, 0, 'pushid', -1			-- ��������
exec spu_FVLogin 'xxxx6@gmail.com', '01022223336', 5, 101, 82, 0, 'pushid', -1			-- ��������
exec spu_FVLogin 'xxxx7@gmail.com', '01022223337', 5, 101, 82, 0, 'pushid', -1			-- ��������
exec spu_FVLogin 'xxxx8@gmail.com', '01022223338', 5, 101, 82, 0, 'pushid', -1			-- ��������
exec spu_FVLogin 'xxxx9@gmail.com', '01022223339', 5, 101, 82, 0, 'pushid', -1			-- ��������

delete from dbo.tUserMaster where gameid in ('', 'xxxx91@gmail.com', 'xxxx92@gmail.com', 'xxxx93@gmail.com', 'xxxx95@gmail.com', 'xxxx96@gmail.com', 'xxxx97@gmail.com')
delete from dbo.tFVGiftList where gameid in ('', 'xxxx91@gmail.com', 'xxxx92@gmail.com', 'xxxx93@gmail.com', 'xxxx95@gmail.com', 'xxxx96@gmail.com', 'xxxx97@gmail.com')
exec spu_FVLogin 'xxxx91@gmail.com', '01022223390', 1, 101, 82, 0, 'pushid', -1	-- SKT
exec spu_FVLogin 'xxxx92@gmail.com', '01022223390', 2, 101, 82, 0, 'pushid', -1	-- KT
exec spu_FVLogin 'xxxx93@gmail.com', '01022223390', 3, 101, 82, 0, 'pushid', -1	-- LGT Event
exec spu_FVLogin 'xxxx95@gmail.com', '01022223390', 5, 101, 82, 0, 'pushid', -1	-- Google
exec spu_FVLogin 'xxxx96@gmail.com', '01022223390', 6, 101, 82, 0, 'pushid', -1	-- NHN Event
exec spu_FVLogin 'xxxx97@gmail.com', '01022223390', 7, 101, 82, 0, 'pushid', -1	-- iPhone

-- delete from dbo.tUserMaster where gameid in ('xxxx70@gmail.com', 'xxxx72@gmail.com')
-- select * from dbo.tUserMaster where gameid in ('xxxx70@gmail.com', 'xxxx72@gmail.com')
exec spu_FVLogin 'xxxx70@gmail.com', '01022223371', 5, 199, 82, 0, 'pushid', -1	-- Google(����)
exec spu_FVLogin 'xxxx72@gmail.com', '01022223372', 5, 199, 82, 1, 'pushid', -1	-- Google(����)

exec spu_FVLogin 'xxxx81@gmail.com', '01022223381', 3, 199, 82, 0, 'pushid', -1	-- LGT Event
*/

IF OBJECT_ID ( 'dbo.spu_FVLogin', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVLogin;
GO

------------------------------------------------
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_FVLogin
	@gameid_								varchar(60),					-- ���Ӿ��̵�
	@phone_									varchar(20),
	@market_								int,							-- (����ó�ڵ�)
	@version_								int,							-- Ŭ�����
	@concode_								int,
	@buytype_								int,							-- (����/�����ڵ�)
																			--		���ᰡ�� : ������ �ּ� BUYTYPE_FREE		= 0
																			--		���ᰡ�� : ������ ���� BUYTYPE_PAY		= 1
	@pushid_								varchar(256),
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

	-- (����/�����ڵ�)
	declare @BUYTYPE_FREE						int					set @BUYTYPE_FREE 					= 0	-- ���ᰡ�� : ������ �ּ�
	declare @BUYTYPE_PAY						int					set @BUYTYPE_PAY 					= 1	-- ���ᰡ�� : ������ ����
	declare @BUYTYPE_PAY2						int					set @BUYTYPE_PAY2 					= 2	-- ���ᰡ��(�簡��)

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

	-------------------------------------------------------------------
	-- Event1. ���� ���� �����ϴ� ������.
	-------------------------------------------------------------------
	declare @EVENT_STATE_NON					int					set @EVENT_STATE_NON				=-1
	declare @EVENT_STATE_YES					int					set @EVENT_STATE_YES				= 1

	------------------------------------------------
	-- ~ 2015.03.27
	-- 2. ���� ù���� ����
	-- 3. �������� ���
	--	> ����    		: 200	3000
	--	> �䱸��Ʈ		: 200	3001
	--	> ������ ����	: 100	3002
	--	> �ٳ��� ���� 	: 100	3004
	--	> ��ũ��		: 100	3005
	--	> ���� 			: 20000	3100
	------------------------------------------------
	declare @EVENT02_END_DAY					datetime			set @EVENT02_END_DAY			= '2015-03-31 23:59'
	declare @EVENT0X_END_DAY					datetime			set @EVENT0X_END_DAY			= '2015-03-07 05:00'

	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @comment				varchar(512)			set @comment		= '�α���'
	declare @gameid 				varchar(60)				set @gameid			= ''
	declare @phone 					varchar(20)
	declare @market					int						set @market			= @MARKET_GOOGLE
	declare @curdate				datetime				set @curdate		= getdate()
	declare @blockstate				int						set @blockstate		= 0
	declare @ownercashcost			bigint					set @ownercashcost	= 0
	declare @cashcopy				int						set @cashcopy		= 0

	declare @curversion				int						set @curversion		= -1
	declare @cursyscheck			int

	-- �ð�üŷ
	declare @dateid8 				varchar(8) 				set @dateid8 		= Convert(varchar(8), Getdate(),112)
	declare @logindate				varchar(8)				set @logindate		= '20100101'
	declare @attendnewday			int						set @attendnewday	= -1
	declare @roulette				int						set @roulette		= -1

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
	declare @idx					int				set @idx 						= 0
	declare @idx2					int				set @idx2 						= 0

	-- ���̺굥��Ÿ.
	declare @savedata				varchar(4096)	set @savedata					= ''
	declare @strmarket				varchar(40)

	-- ��Ÿ����.
	declare @eventspot0x			int				set @eventspot0x 				= 1

	-- ��ŷ�ʱ�ȭ �ð�ǥ��.
	declare @schoolinitdate			varchar(19),
			@dw						int
	declare @userrankview			int				set @userrankview				= -1 -- �Ⱥ���(-1), ����(1)


	-- ��������(X).
	declare @roulsaleflag			int				set @roulsaleflag		= -1
	declare @roulsalevalue			int				set @roulsalevalue		=  0

	-- ��������(X).
	declare @roulrewardflag			int				set @roulrewardflag		= -1

	-- ����Ȯ�����(X).
	declare @roultimeflag			int				set @roultimeflag		= -1
	declare @roultimetime1			int				set @roultimetime1		= -1
	declare @roultimetime2			int				set @roultimetime2		= -1
	declare @roultimetime3			int				set @roultimetime3		= -1
	declare @roultimetime4			int				set @roultimetime4		= -1

	-- ��������̱�(X).
	declare @tsgauageflag			int				set @tsgauageflag		= -1

	-- ������ȭ����(X).
	declare @tsupgradesaleflag		int				set @tsupgradesaleflag	= -1
	declare @tsupgradesalevalue		int				set @tsupgradesalevalue	=  0

	-- �귿(ȸ����)����̱�.
	declare @wheelgauageflag		int				set @wheelgauageflag	= -1
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG �Է�����', @gameid_ gameid_, @phone_ phone_, @market_ market_, @version_ version_, @concode_ concode_, @pushid_ pushid_

	------------------------------------------------
	--	3-2. �������
	------------------------------------------------
	select
		@gameid 		= gameid,
		@roulette		= roulette,
		@logindate		= logindate,
		@blockstate		= blockstate,
		@cashcopy		= cashcopy,
		@eventspot0x	= eventspot0x
	from dbo.tUserMaster
	where gameid = @gameid_
	--select 'DEBUG ��������', @gameid gameid

	------------------------------------------------
	--	3-3. �������� üũ
	------------------------------------------------
	select
		top 1
		@cursyscheck 	= syscheck,
		@curversion 	= version,
		@idx 			= idx
	from dbo.tFVNotice
	where market = @market_
	order by idx desc
	--select 'DEBUG ��������', @cursyscheck cursyscheck, @curversion curversion

	if(@cursyscheck = @SYSCHECK_YES)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_SERVER_CHECKING
			set @comment 	= 'DEBUG �ý��� �������Դϴ�.'
			--select 'DEBUG ', @comment
		END
	else if(@gameid_ = '')
		BEGIN
			-- ���̵� ���������ʴ°�??
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '���̵� �������� �ʴ´�. > ���̵� Ȯ���ض�.'
			--select 'DEBUG ', @comment
		END
	else if(@blockstate = 1)
		BEGIN
			-- ���̵� ���������ʴ°�??
			set @nResult_ 	= @RESULT_ERROR_BLOCK_USER
			set @comment 	= '������ �� �Ǿ����ϴ�.'
			--select 'DEBUG ', @comment
		END
	else if(@version_ < @curversion)
		BEGIN
			-- ���Ϻ� ������ Ʋ����
			set @nResult_ 	= @RESULT_NEWVERION_CLIENT_DOWNLOAD
			set @comment 	= '���Ϻ� ������ Ʋ����. > �ٽù޾ƶ�.'
			--select 'DEBUG ', @comment
		END
	else if (exists(select top 1 * from dbo.tFVUserBlockPhone where phone = @phone_))
		BEGIN
			-- �������ΰ�?
			set @nResult_ 	= @RESULT_ERROR_BLOCK_USER
			set @comment 	= '��ó���� ���̵��Դϴ�.'
			--select 'DEBUG ', @comment
		END
	else if(@cashcopy >= 2)
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_BLOCK_USER
			set @comment 	= 'ĳ������ī�Ǹ� '+ltrim(rtrim(str(@cashcopy)))+'ȸ �̻��ߴ�. > ��ó������!!'
			--select 'DEBUG ', @comment

			-- xxȸ �̻�ī���ൿ > ��ó��, ���αױ��
			update dbo.tUserMaster
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
	select @nResult_ rtn, @comment comment, @curdate curdate, comment ntcomment, version curversion, * from dbo.tFVNotice where idx = @idx

	if(@nResult_ = @RESULT_SUCCESS)
		BEGIN
			if(@gameid = '')
				begin
					--select 'DEBUG �ű԰���'
					---------------------------------------------
					-- ����, ����ũ ����.
					---------------------------------------------
					insert into dbo.tUserMaster(gameid,   phone,   market,   version,   concode,   pushid,   buytype)
					values(                      @gameid_, @phone_, @market_, @version_, @concode_, @pushid_, @buytype_)

					---------------------------------------------
					-- ����, ���� ���� �����ؼ� ����.
					---------------------------------------------
					if(@buytype_ = @BUYTYPE_PAY)
						begin
							--select 'DEBUG �ű԰���(����)'
							------------------------------
							-- ���� ���� > �������.
							--	> ���� �����ڴ� ĳ���� ���������� ����.
							------------------------------
							exec spu_FVDayLogInfoStatic @market_, 15, 1               -- �� ����ũ ����(����)

							--if(@market_ = @MARKET_GOOGLE)
							--	begin
							--		exec spu_FVSubGiftSend 2, 3015, 5000, 'sangsang', @gameid_, ''
							--	end
						end
					else
						begin
							--select 'DEBUG �ű԰���(����)'
							------------------------------
							-- ���� ���� > �������.
							------------------------------
							exec spu_FVDayLogInfoStatic @market_, 11, 1               -- �� ����ũ ����(����)

						end

					---------------------------------------------
					--	Event
					-----------------------------------------------
					--select 'DEBUG ', @market_ market_, @curdate curdate, @gameid_ gameid_
					if(@curdate < @EVENT02_END_DAY)
						begin
							exec spu_FVSubGiftSend 2, 3000,  200, 'NewStart', @gameid_, ''
							exec spu_FVSubGiftSend 2, 3001,  200, 'NewStart', @gameid_, ''
							exec spu_FVSubGiftSend 2, 3002,  100, 'NewStart', @gameid_, ''
							exec spu_FVSubGiftSend 2, 3004,  100, 'NewStart', @gameid_, ''
							exec spu_FVSubGiftSend 2, 3005,  100, 'NewStart', @gameid_, ''
							exec spu_FVSubGiftSend 2, 3100,20000, 'NewStart', @gameid_, ''
						end
				end

			-------------------------------------------------------------------
			-- ��ġ����
			-------------------------------------------------------------------
			if(@market_ = @MARKET_GOOGLE and @eventspot0x = 0 and @curdate < @EVENT0X_END_DAY)
				begin
					exec spu_FVSubGiftSend 2, 3015,   3000, '��ġ����', @gameid_, ''
					exec spu_FVSubGiftSend 2, 3100,5000000, '��ġ����', @gameid_, ''
					set @eventspot0x = 1
				end


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

					set @eventidx2 = (@curyear - 2013)*1000000 + @curmonth*10000 + @curday*100 + @eventidx
					--select 'DEBUG �����̺�Ʈ1-2', @eventidx eventidx, @eventitemcode eventitemcode, @eventsender eventsender, @eventidx2 eventidx2

					if(@eventidx != -1 and @eventitemcode != -1)
						begin
							--select 'DEBUG �����̺�Ʈ1-3'
							if(not exists(select top 1 * from dbo.tFVEvnetUserGetLog where gameid = @gameid_ and eventidx = @eventidx2))
								begin
									--select 'DEBUG �����̺�Ʈ1-4 ����, �αױ��'
									exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @eventitemcode, @eventcnt, @eventsender, @gameid_, 'login'

									insert into dbo.tFVEvnetUserGetLog(gameid,   eventidx,  eventitemcode)
									values(                         @gameid_, @eventidx2, @eventitemcode)

									-- �ڼ��� �ΰ�� �����Կ� �־ �����ص� �ȴ�.
									select @idx2 = max(idx) from dbo.tFVEvnetUserGetLog
									delete from tFVEvnetUserGetLog where idx <= @idx2 - 800
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
				end
			else
				begin
					exec spu_FVDayLogInfoStatic @market_, 12, 1               -- �� �α���(�ߺ�)
				end
			set @logindate = @dateid8

			-----------------------------------------------------------------
			-- ���̺� ����.
			-----------------------------------------------------------------
			select @savedata = savedata from dbo.tFVUserData where gameid = @gameid_ and market = @market_
			set @ownercashcost = dbo.fnu_GetFVSaveDataToCashcost(@savedata)

			----------------------------------------------
			-- �б����� �ʱ�ȭ��¥(���� ����� ���� 11:00).
			---------------------------------------------
			select @dw = DATEPART(dw, @curdate)
			set @curdate = @curdate + (7 - @dw)
			set @schoolinitdate = CONVERT(char(10), @curdate, 25) + ' 23:00:00'

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
				@roultimetime1	= roultimetime1,	@roultimetime2	= roultimetime2,	@roultimetime3	= roultimetime3, @roultimetime4	= roultimetime4,

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


			----------------------------------------------
			-- ��ŷ����?
			---------------------------------------------
			select @userrankview = userrankview from dbo.tFVUserRankView where idx = 1

			------------------------------------------------------------------
			-- ���� ������ ������Ʈ�ϱ�
			------------------------------------------------------------------
			--select * from dbo.tUserMaster where gameid = @gameid_

			update dbo.tUserMaster
				set
					market			= @market_,
					version			= @version_,
					concode			= @concode_,
					ownercashcost	= @ownercashcost,
					pushid			= @pushid_,
					phone			= @phone_,
					eventspot0x		= @eventspot0x,
					logindate		= @logindate,		-- �α��γ�¥��.
					roulette		= @roulette,
					condate			= getdate(),		-- ����������
					concnt			= concnt + 1		-- ����Ƚ�� +1
			where gameid = @gameid_

			----------------------------------------------
			-- ���� ����
			---------------------------------------------
			select
				concnt,
				@attendnewday attendnewday,
				@savedata savedata,
				@userrankview userrankview,
				@schoolinitdate userrankinitdate,

				@roulsaleflag roulsaleflag, @roulsalevalue roulsalevalue,
				@tsupgradesaleflag tsupgradesaleflag, @tsupgradesalevalue tsupgradesalevalue,
				@roulrewardflag roulrewardflag,
				@roultimeflag roultimeflag,
				@roultimetime1 roultimetime1, @roultimetime2 roultimetime2,	@roultimetime3 roultimetime3, @roultimetime4 roultimetime4,
				@tsgauageflag tsgauageflag,
				@wheelgauageflag wheelgauageflag, wheelgauage, wheelfree,
				tsgrade1cnt, tsgrade2cnt, tsgrade3cnt, tsgrade4cnt,
						     tsgrade2gauage, tsgrade3gauage, tsgrade4gauage,
						     tsgrade2free, tsgrade3free, tsgrade4free,
						     adidx,
				kakaomsginvitecnt, kakaomsginvitetodaycnt, kakaomsginvitetodaydate,
				roulette, nickname, nickcnt
			from dbo.tUserMaster where gameid = @gameid_

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
			-- ī�� �ʴ�ģ����
			--------------------------------------------------------------
			select * from dbo.tFVKakaoInvite where gameid = @gameid_ and senddate >= (getdate() - 7)

			--------------------------------------------------------------
			-- ���� ��ü��ŷ
			--------------------------------------------------------------
			if(@userrankview = 1)
				begin
					exec spu_FVsubTotalRank @gameid_
				end
		END

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	set nocount off
End



