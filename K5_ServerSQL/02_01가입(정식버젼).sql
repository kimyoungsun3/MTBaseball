/*
-- �Ϲݰ���
--select * from dbo.tKakaoMaster where gameid like 'xxxx%'
exec spu_UserCreate 'xxxx',   '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 101, '01011112221', '',    'kakaotalkidxxxx',      'kakaouseridxxxx',      'kakaogameid01',   '', '', -1, '', -1
exec spu_UserCreate 'xxxx2',  '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 101, '01011112222', '',    'kakaotalkidxxxx2',     'kakaouseridxxxx2',     'kakaogameid02',   '', '', -1, '', -1
exec spu_UserCreate 'xxxx3',  '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 101, '01011112222', '',    'kakaotalkidxxxx3',     'kakaouseridxxxx3',     'kakaogameid03',   '', '', -1, '', -1
exec spu_UserCreate 'xxxx4',  '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 101, '01011112222', '',    'kakaotalkidxxxx4',     'kakaouseridxxxx4',     'kakaogameid04',   '', '', -1, '', -1
exec spu_UserCreate 'xxxx5',  '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 101, '01011112222', '',    'kakaotalkidxxxx5',     'kakaouseridxxxx5',     'kakaogameid05',   '', '', -1, '', -1
exec spu_UserCreate 'xxxx6',  '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 101, '01011112222', '',    'kakaotalkidxxxx6',     'kakaouseridxxxx6',     'kakaogameid06',   '', '', -1, '', -1
exec spu_UserCreate 'xxxx7',  '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 101, '01011112222', '',    'kakaotalkidxxxx7',     'kakaouseridxxxx7',     'kakaogameid07',   '', '', -1, '', -1
exec spu_UserCreate 'xxxx8',  '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 101, '01011112222', '',    'kakaotalkidxxxx8',     'kakaouseridxxxx8',     'kakaogameid08',   '', '', -1, '', -1
exec spu_UserCreate 'xxxx9',  '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 101, '01011112222', '',    'kakaotalkidxxxx9',     'kakaouseridxxxx9',     'kakaogameid09',   '', '', -1, '', -1
exec spu_UserCreate 'xxxx10',  '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 103, '01011112210', '',   'kakaotalkidxxxx10',    'kakaouseridxxxx10',    'kakaogameid10',   '', '', -1, '', -1
exec spu_UserCreate 'xxxx11',  '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 103, '01011112211', '',   'kakaotalkidxxxx11',    'kakaouseridxxxx11',    'kakaogameid11',   '', '', -1, '', -1

-- select * from dbo.tUserBlockLog where gameid = ''
-- select * from dbo.tUserMaster where gameid = ''
-- select * from dbo.tUserItem where gameid = ''
-- select * from dbo.tUserSeed where gameid = ''
-- select top 10 * from dbo.tKakaoMaster order by idx desc

-- guest���� (������ 5���� �Է��ϱ� )
declare @var 			int
declare @loop			int				set @loop	= 1
declare @gameid 		varchar(20)		set @gameid = 'farm'	-- guest, farm, iuest
declare @phone 			varchar(20)
select @var = max(idx) + 1 from dbo.tUserMaster
set @loop = @var + @loop
while @var < @loop
	begin
		set @phone			= '010' + ltrim(@var)
		exec dbo.spu_UserCreate
							@gameid,					-- gameid
							'049000s1i0n7t8445289',		-- password
							1,							-- market
							0,							-- buytype
							1,							-- platform
							'ukukukuk',					-- ukey
							101,						-- version
							@phone,						-- phone
							'',							-- pushid

							'',							-- kakaotalkid (������ ������ ��������)
							'',							-- kakaouserid (������ ������ ��������)
							'',							-- kakaogameid (������ ������ ��������)
							'', 						-- kakaonickname
							'',							-- kakaoprofile
							-1,							-- kakaomsgblocked
							'0:000000000031;1:000000000033;',-- kakaofriendlist(kakaouserid)
							-1
		set @var = @var + 1
	end
-- ���� ������ ������ �ִ��� �׽�Ʈ
-- farm(ī�忡�� ����) -> iuest(�Խ�Ʈ�� ����) -> iuest(����) -> farm(����)
-- select kakaouserid, count(*) from dbo.tKakaoMaster group by kakaouserid order by 2 desc
-- select * from dbo.tKakaoMaster where kakaouserid = '88258263875124913' order by idx desc
-- delete from dbo.tKakaoMaster where idx in (9)

*/
use Game4Farmvill5
GO

IF OBJECT_ID ( 'dbo.spu_UserCreate', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_UserCreate;
GO

create procedure dbo.spu_UserCreate
	@gameid_				varchar(20),						-- ���Ӿ��̵�
	@password_				varchar(20),						-- ��ȣȭ�ؼ�����, �����н����� ��ŷ���ص� ����
	@market_				int,								-- (����ó�ڵ�) MARKET_SKT
																--		MARKET_SKT		= 1
																--		MARKET_GOOGLE	= 5
																--		MARKET_NHN		= 6
																--		MARKET_IPHONE	= 7
	@buytype_				int,								-- (����/�����ڵ�)
																--		���ᰡ�� : ������ �ּ� BUYTYPE_FREE		= 0
	@platform_				int,								-- (�÷���)
																--		PLATFORM_ANDROID	= 1
																--		PLATFORM_IPHONE		= 2
	@ukey_					varchar(256),						-- UKey
	@version_				int,								-- Ŭ�����
	@phone_					varchar(20),
	@pushid_				varchar(256),
	@kakaotalkid_			varchar(60),						-- ī������(�簡�Խ� �����).
	@kakaouserid_			varchar(60),						--          �簡�Խ� �̺���
	@kakaogameid_			varchar(60),						--          �簡�Խ� �̺���
	@kakaonickname_			varchar(40),
	@kakaoprofile_			varchar(512),
	@kakaomsgblocked_		int,
	@kakaofriendlist_		varchar(2048),
	@nResult_				int				OUTPUT
	--WITH ENCRYPTION -- ���ν����� ��ȣȭ��.
as
	------------------------------------------------
	--	2-1. �����ڵ尪
	------------------------------------------------
	-- �Ϲݰ�
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	declare @RESULT_ERROR_ID_DUPLICATE			int				set @RESULT_ERROR_ID_DUPLICATE			= -2
	declare @RESULT_ERROR_ID_CREATE_MAX 		int				set @RESULT_ERROR_ID_CREATE_MAX			= -3	-- ��������.
	declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--������ > �˾�ó���� ��Ʈ�η� ��������.

	declare @RESULT_ERROR_JOIN_WAIT				int				set @RESULT_ERROR_JOIN_WAIT				= -142			-- ���Խð����.

	------------------------------------------------
	--	2-1. ���ǵȰ�
	------------------------------------------------
	-- ���°�.
	declare @BLOCK_STATE_NO						int					set	@BLOCK_STATE_NO					= 0	-- �����¾ƴ�
	declare @BLOCK_STATE_YES					int					set	@BLOCK_STATE_YES				= 1	-- ������

	declare @DELETE_STATE_NO					int					set	@DELETE_STATE_NO				= 0	-- �������¾ƴ�
	declare @DELETE_STATE_YES					int					set	@DELETE_STATE_YES				= 1	-- ��������

	declare @ID_MAX								int					set	@ID_MAX							= 99999 -- ������ ������ �� �ִ� ���̵𰳼�

	-- �Ϲݰ���, �Խ�Ʈ ����
	declare @JOIN_MODE_GUEST					int					set @JOIN_MODE_GUEST				= 1
	declare @JOIN_MODE_PLAYER					int					set @JOIN_MODE_PLAYER				= 2

	-- �����ۺ� �κ��з�
	declare @USERITEM_INVENKIND_ANI				int 				set @USERITEM_INVENKIND_ANI					= 1
	declare @USERITEM_INVENKIND_CONSUME			int 				set @USERITEM_INVENKIND_CONSUME				= 3
	declare @USERITEM_INVENKIND_PET				int 				set @USERITEM_INVENKIND_PET					= 1000

	-- ������ ���
	declare @USERSEED_NEED_BUY					int					set @USERSEED_NEED_BUY						= -2
	declare @USERSEED_NEED_EMPTY				int					set @USERSEED_NEED_EMPTY					= -1
	-- >= 0 �̻��̸� Ư�� �Ĺ��� �ɾ�������.
	declare @GAME_INVEN_HOSPITAL_BASE			int					set @GAME_INVEN_HOSPITAL_BASE				= 10+9 	-- ��������(����10 + �ʵ�9).
	declare @GAME_COMPETITION_BASE				int					set @GAME_COMPETITION_BASE					= 90106	-- �����ȣ, -1�� ����.
	declare @GAME_FEED_BASE						int					set @GAME_FEED_BASE							= 15	-- ���� ���ʰ�.
	declare @GAME_PET_BASE_ITEMCODE				int					set @GAME_PET_BASE_ITEMCODE					= 100000-- ������.

	-- ������ �Һз�
	declare @ITEM_SUBCATEGORY_USERFARM			int					set @ITEM_SUBCATEGORY_USERFARM	 			= 69	-- ��������

	-- ��������.
	-- �ʵ嵿�� 0 ~ 8.
	declare @USERITEM_FIELDIDX_INVEN			int					set @USERITEM_FIELDIDX_INVEN				= -1	-- â��.
	declare @USERITEM_FIELDIDX_HOSPITAL			int					set @USERITEM_FIELDIDX_HOSPITAL				= -2	-- ����.

	-- ģ�����°�.
	declare @USERFRIEND_STATE_SEARCH			int					set	@USERFRIEND_STATE_SEARCH				=-1;		-- -1: �˻�.
	declare @USERFRIEND_STATE_PROPOSE_WAIT		int					set	@USERFRIEND_STATE_PROPOSE_WAIT			= 0;		-- 0 : ģ����û���
	declare @USERFRIEND_STATE_APPROVE_WAIT		int					set	@USERFRIEND_STATE_APPROVE_WAIT			= 1;		-- 1 : ģ���������
	declare @USERFRIEND_STATE_FRIEND			int					set	@USERFRIEND_STATE_FRIEND				= 2;		-- 2 : ��ȣģ��

	-- ����(����).
	declare @USERFARM_BUYSTATE_NOBUY			int					set @USERFARM_BUYSTATE_NOBUY				= -1	-- (����)
	declare @USERFARM_BUYSTATE_BUY				int					set @USERFARM_BUYSTATE_BUY					=  1
	declare @USERFARM_INIT_ITEMCODE				int					set @USERFARM_INIT_ITEMCODE					= 6900

	declare @KAKAO_DATA_YES						int					set @KAKAO_DATA_YES = 1
	declare @KAKAO_DATA_NO						int					set @KAKAO_DATA_NO = -1

	-- ���� ���ǰ�
	declare @GIFTLIST_GIFT_KIND_MESSAGE			int					set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2

	----------------------------------------------
	-- EVENT
	-- kakao ���� �̺�Ʈ ~ 2014-06-19 23:59
	-- 10���(5009)�� ������ �����Ѵ�.
	----------------------------------------------
	--declare @EVENT01_START_DAY				datetime			set @EVENT01_START_DAY			= '2014-06-19 23:59'
	--declare @EVENT01_END_DAY					datetime			set @EVENT01_END_DAY			= '2014-06-19 23:59'
	--declare @EVENT01_REWARD_ITEM				int					set @EVENT01_REWARD_ITEM		= 5009		-- 10���
	--declare @EVENT01_REWARD_NAME				varchar(20)			set @EVENT01_REWARD_NAME		= 'ī�尡�Ա��'

	----------------------------------------------
	-- Naver �̺�Ʈ ó��
	--	�Ⱓ : 7.24 ~ 8.6
	--	��ǥ : 8.11
	--	1. ���Խ� ...		=> ��ũ�� ��1����, ��� 60��
	--						   02_01����(���Ĺ���).sql
	--	2. ���� 2��			=> �����ϸ� 2�� �̺�Ʈ
	--						   21_01ĳ��(������).sql
	--						   21_02ĳ��(����������).sql
	--	3. Naverĳ��		=> ���̹� ĳ��
	--	4. ������÷			=> ��÷�� ��ǥ �� 1���� �̳� ������ �Ϸ��ϸ� �˴ϴ�.
	--						  �����̾�Ƽ��(20��), ���20��
	--	5. �ʴ���÷			=> ��÷�� ��ǥ �� 1���� �̳� ������ �Ϸ��ϸ� �˴ϴ�.
	--						  �˹��� ������Ű��(20��), ��Ȱ�� 10��(����)
	------------------------------------------------
	--declare @EVENT07_START_DAY				datetime			set @EVENT07_START_DAY			= '2014-06-13 20:00'
	--declare @EVENT07_REWARD_ITEM01			int					set @EVENT07_REWARD_ITEM01		= 205			-- ��ũ�� ���� ��
	--declare @EVENT07_REWARD_ITEM02			int					set @EVENT07_REWARD_ITEM02		= 5000			--���60
	--declare @EVENT07_REWARD_NAME				varchar(20)			set @EVENT07_REWARD_NAME		= '���±��'

	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @sysfriendid	varchar(20)		set @sysfriendid 	= 'farmgirl'
	declare @joincnt		int				set @joincnt		= 0
	declare @joinmode		int				set @joinmode 		= @JOIN_MODE_PLAYER

	declare @cashcost 		int
	declare @gamecost 		int
	declare @loop 			int

	declare	@regmsg			varchar(200)	set @regmsg = '������ �������� ���� �մϴ�.'
	declare @comment		varchar(80)
	declare @dateid8 		varchar(8)		set @dateid8 = Convert(varchar(8),Getdate(),112)
	declare @blockstate		int
	declare @listidx		int
	declare @itemcode		int
	declare @upstepmax		int				set @upstepmax		= 16
	declare @upstepmax2		int				set @upstepmax2		= 16

	-- ��õ�� ������ ���� ����
	declare @smsgameid		varchar(20)
	declare @smsplusgbrec	int				set @smsplusgbrec	= 0
	declare @smsplusgbmy	int				set @smsplusgbmy	= 0
	declare @commentrec		varchar(128)
	declare @commentmy		varchar(128)

	-- �Һ������
	declare @bulletlistidx		int,
			@vaccinelistidx		int,
			@albalistidx		int,
			@boosterlistidx		int,
			@petlistidx			int,
			@cnt				int

	-- Kakao
	declare	@kakaotalkid	varchar(60)		set @kakaotalkid	= ''
	declare	@kakaouserid	varchar(60)		set @kakaouserid	= ''
	declare	@kakaouserid2	varchar(60)		set @kakaouserid2	= ''
	declare @gameid			varchar(20)		set @gameid			= ''
	declare @strkind		varchar(20)		set @strkind 		= @gameid_
	declare @kakaodata		int				set @kakaodata 		= @KAKAO_DATA_YES
	declare @idx			int				set @idx			= -1

	declare @deldate		datetime		set @deldate		= getdate() - 1
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	if(exists(select top 1 * from dbo.tUserBlockPhone where phone = @phone_))
		begin
			-- �������ΰ�?
			set @nResult_ 	= @RESULT_ERROR_BLOCK_USER
			set @comment 	= '��ó���� ���̵��Դϴ�.'
			--select 'DEBUG ', @comment
			select @nResult_ rtn, @comment comment, @gameid_ gameid, @password_ password, @deldate waittime
			return
		end



	------------------------------------------------
	--	3-2. �Խ�ƮID����
	------------------------------------------------
	--select 'DEBUG ', @gameid_ gameid_, @kakaouserid_ kakaouserid_
	if(@gameid_ in ('farm', 'guest', 'iuest'))
		begin
			--select 'DEBUG ��������(1)'
			if(@kakaouserid_ = '')
				begin
					--select 'DEBUG kakaotalkid create'
					SET @kakaouserid_ = @gameid_ + cast(replace(NEWID(), '-', '') as varchar(15))
					SET @kakaotalkid_ = @kakaouserid_
				end

			set @joinmode = @JOIN_MODE_GUEST

			-- 1. guest ���̵����
			declare @maxIdx int
			declare @rand int
			select @maxIdx = max(idx)+1 from dbo.tUserMaster
			set @rand 	= 100 + Convert(int, ceiling(RAND() * 899))	-- 100 ~ 999
			set @gameid_ = @gameid_ + rtrim(ltrim(str(@maxIdx))) + rtrim(ltrim(str(@rand)))
			--select 'DEBUG 3-2-1 guest���Ը��', @gameid_

			if exists (select * from tUserMaster where gameid = @gameid_)
				begin
					declare @tmp varchar(10)
					set @tmp = replace(newid(), '-', '')
					set @gameid_ = @gameid_ + @tmp
					--select 'DEBUG 3-2-2 guest�ߺ��Ǿ �׳ɻ���', @gameid_
				end
		end
	--else if(PATINDEX('%iuest%', @gameid_) = 1 and @kakaouserid_ != '')
	--	begin
	--		-- ī�� ������ ������ �����Ǿ���Ѵ�.
	--		--select 'DEBUG ī�� ������ ��������', @kakaouserid_ kakaouserid_
	--		delete from dbo.tKakaoMaster where kakaouserid = @kakaouserid_
    --
	--		-- 88452235362617025 > iuest583397699, farm161006288
	--		-- insert into dbo.tKakaoMaster(kakaotalkid,   kakaouserid,                 gameid,   kakaodata, writedate)
	--		-- values(						'A1QZxsYZVAM', '88452235362617025', 'farm161006288', 1, '2014-05-12 12:14')
	--		-- ī�� ������ ���� �Է�
	--		if(exists(select top 1 * from dbo.tKakaoMaster where gameid = @gameid_))
	--			begin
	--				--select 'DEBUG ���', @gameid_ gameid_, @kakaotalkid_ kakaotalkid_, @kakaouserid_ kakaouserid_, @kakaodata kakaodata
	--				update dbo.tKakaoMaster
	--					set
	--						kakaotalkid	= @kakaotalkid_,
	--						kakaouserid = @kakaouserid_,
	--						kakaodata	= @kakaodata
	--				where gameid = @gameid_
	--			end
	--		else
	--			begin
	--				--select 'DEBUG �Է�', @gameid_ gameid_, @kakaotalkid_ kakaotalkid_, @kakaouserid_ kakaouserid_, @kakaodata kakaodata
	--				insert into dbo.tKakaoMaster(kakaotalkid,   kakaouserid,   gameid,   kakaodata)
	--				values(						@kakaotalkid_, @kakaouserid_, @gameid_, @kakaodata)
	--			end
    --
	--		-- ���� ���� ����.
	--		update dbo.tUserMaster
	--			set
	--				kakaotalkid		= @kakaotalkid_,
	--				kakaouserid		= @kakaouserid_,
	--				kakaonickname	= @kakaonickname_,
	--				kakaoprofile	= @kakaoprofile_,
	--				kakaomsgblocked	= @kakaomsgblocked_
	--		where gameid = @gameid_
	--	end
	else if(@kakaouserid_ != '' and @gameid_ != '')
		begin
			 select @kakaouserid2 = kakaouserid from dbo.tKakaoMaster where gameid = @gameid_
			 --select 'DEBUG ��������(2)', @gameid_ gameid_, @kakaouserid2 kakaouserid2, @kakaouserid_ kakaouserid_

			 if(@kakaouserid_ != @kakaouserid2)
			 	begin
			 		--select 'DEBUG kakaouserid�� �ٸ� > �űԻ����� ���� ����', @kakaouserid2 kakaouserid2
			 		-- ������ ������ ī����̵�� ����.
			 		delete from dbo.tKakaoMaster where kakaouserid = @kakaouserid2

					-- ī�� ������ ���� �Է�
					if(exists(select top 1 * from dbo.tKakaoMaster where kakaouserid = @kakaouserid_))
						begin
							--select 'DEBUG kakaouserid > update'
							update dbo.tKakaoMaster
								set
									kakaotalkid		= @kakaotalkid_,
									kakaodata		= @kakaodata,
									gameid 			= @gameid_
							where kakaouserid = @kakaouserid_
						end
					else
						begin
							--select 'DEBUG kakaouserid > insert', @gameid_ gameid_, @kakaotalkid_ kakaotalkid_, @kakaouserid_ kakaouserid_, @kakaodata kakaodata
							insert into dbo.tKakaoMaster(kakaotalkid,   kakaouserid,   gameid,   kakaodata)
							values(						@kakaotalkid_, @kakaouserid_, @gameid_, @kakaodata)
						end

					-- ���� ���� ����.
					update dbo.tUserMaster
						set
							kakaotalkid		= @kakaotalkid_,
							kakaouserid		= @kakaouserid_,
							kakaogameid		= @kakaogameid_,
							kakaonickname	= @kakaonickname_,
							kakaoprofile	= @kakaoprofile_,
							kakaomsgblocked	= @kakaomsgblocked_
					where gameid = @gameid_
				end
		end

	--select 'DEBUG 3-2-3', @gameid_ gameid_, @password_ password_, @market_ market_, @buytype_ buytype_, @platform_ platform_, @ukey_ ukey_, @version_ version_, @phone_ phone_, @pushid_ pushid_
	if(@strkind in ('iuest'))
		begin
			set @kakaonickname_ 	= @gameid_
			set @kakaodata			= @KAKAO_DATA_NO
		end

	------------------------------------------------
	-- �ڵ������� ������ ���̵�� ���� �ľ�
	--select
	--	@joincnt = isnull(count(*), 0)
	--from tUserMaster where phone = @phone_ and deletestate = @DELETE_STATE_NO
	------------------------------------------------
	select
		@joincnt = joincnt
	from tUserPhone where phone = @phone_
	--select 'DEBUG 3-2-4  �ڵ����� ������:', @phone_ phone_, @joincnt joincnt

	------------------------------------------------
	-- īī�� ������ ã��
	-- ó������	: '' > ''					      -> 88258263875124913 > guestxxxx
	-- �����ϱ�	: 88258263875124913 > guestxxxx   -> 88258263875124913 > ''
	-- �簡��	: 88258263875124913 > ''		  -> 88258263875124913 > guestxxxx
	------------------------------------------------
	select top 1
		@idx			= idx,
		@kakaotalkid	= kakaotalkid,
		@kakaouserid 	= kakaouserid,
		@gameid 		= gameid,
		@deldate		= deldate
	from dbo.tKakaoMaster
	where kakaouserid = @kakaouserid_
	order by idx desc
	--select 'DEBUG 3-2-5', @kakaouserid_ kakaouserid_, @kakaotalkid kakaotalkid, @kakaouserid kakaouserid, @gameid gameid, @deldate deldate

	------------------------------------------------
	--	3-3. ��������.
	------------------------------------------------
	if (@gameid != '' and exists(select top 1 * from dbo.tUserMaster where gameid = @gameid))
		begin
			set @nResult_ = @RESULT_SUCCESS
			set @comment = '(�翬��)������ �����մϴ�.'
			--select 'DEBUG 3', @comment
			if(@kakaotalkid != @kakaotalkid_)
				begin
					--select 'DEBUG 3 kakaotalkid �Է�, ���尪�� Ʋ���� ����', @kakaotalkid kakaotalkid, @kakaotalkid_ kakaotalkid_
					-- �簻�ŵɶ��� �ִ�.
					update dbo.tKakaoMaster
						set
							kakaotalkid 	= @kakaotalkid_,
							cnt2			= cnt2 + 1
					where idx = @idx
				end

			-- �г��Ӱ� ���������� �����ϴ�.
			update dbo.tUserMaster
				set
					kakaoprofile	= @kakaoprofile_,
					--kakaonickname = @kakaonickname_,
					--market		= @market_,				-- �α����Ҷ� �����Ѵ�.
					pushid			= @pushid_
			where gameid = @gameid

			select @nResult_ rtn, @comment comment, gameid, password, @deldate waittime
			from dbo.tUserMaster
			where gameid = @gameid
			return
		end
	else if exists (select * from tUserMaster where gameid = @gameid_)
		begin
			set @nResult_ = @RESULT_ERROR_ID_DUPLICATE
			set @comment = '(����)���̵� �ߺ��Ǿ����ϴ�.'
			--select 'DEBUG 4', @comment
		end
	else if(@joincnt >= @ID_MAX)
		begin
			set @nResult_ = @RESULT_ERROR_ID_CREATE_MAX
			set @comment = '�������� ' + ltrim(str(@ID_MAX)) + '��������(����������)'
			--select 'DEBUG 5', @comment
		end
	else if(@idx != -1 and @deldate > (getdate() - 1))
		begin
			set @nResult_ = @RESULT_ERROR_JOIN_WAIT
			set @comment = '���� �ð����� �簡���� �Ұ��մϴ�.'

			set @deldate = @deldate + 1
			--select 'DEBUG 5', @comment
		end
	else
		begin
			set @nResult_ = @RESULT_SUCCESS
			set @comment = '(����)������ �����մϴ�.'
			--select 'DEBUG 6', @comment

			-------------------------------------------
			-- 1. �ʱ� ����
			-- ���� : ĳ��(10),  ���ӸӴ�(400), ����(5)
			-- Ʃ�� : 4��� + 150���� + 2 ĳ�� �ϲ� + 2ĳ�� ���
			-------------------------------------------
			set @cashcost		= 60
			set @gamecost		= 400

			--select 'DEBUG 6-1. �ʱ� ����', @buytype_ buytype_, @cashcost cashcost, @gamecost gamecost

			-------------------------------------------
			-- 2. ���� > ���Ժ�ó��
			-------------------------------------------
			--select 'DEBUG 6-2. �������� �˻�'
			if(exists(select top 1 * from dbo.tUserBlockPhone where phone = @phone_))
				begin
					--select 'DEBUG > 6-2-2 @@@@�� �ڵ���@@@@'
					--�������� ī��ó��.
					set @blockstate = @BLOCK_STATE_YES

					-- �������� ���Ժ��� ������ ó���Ѵ�.
					insert into dbo.tUserBlockLog(gameid, comment)
					values(@gameid_, '�� ������ �����ҷ��� �ؼ� ���Ժ��� ��ó����.')
				end
			else
				begin
					--select 'DEBUG > 6-2-3 NON��'
					set @blockstate = @BLOCK_STATE_NO
				end

			------------------------------------------------
			-- �� 7���� : (��ǥ�� 1 + �Ϲݼ�6)
			------------------------------------------------
			--select 'DEBUG 6-4 ���������� > �����Է�'
			set @listidx		= 0
			set @itemcode		= 1
			select @upstepmax  = param30 from dbo.tItemInfo where itemcode = 1
			select @upstepmax2 = param30 from dbo.tItemInfo where itemcode = 2

			insert into dbo.tUserItem(gameid,   listidx,      itemcode, cnt, farmnum, fieldidx,  upstepmax, invenkind)					-- ��ǥ����.
			values(					 @gameid_, @listidx + 0, 		 1,   1,       0,        0, @upstepmax, @USERITEM_INVENKIND_ANI)	--	E��� ��

			insert into dbo.tUserItem(gameid,   listidx,      itemcode, cnt, farmnum, fieldidx,  upstepmax, invenkind)
			values(					 @gameid_, @listidx + 1, 		 1,   1,       0,        1, @upstepmax, @USERITEM_INVENKIND_ANI)

			insert into dbo.tUserItem(gameid,   listidx,      itemcode, cnt, farmnum, fieldidx,  upstepmax, invenkind)
			values(					 @gameid_, @listidx + 2, 		 1,   1,       0,        2, @upstepmax, @USERITEM_INVENKIND_ANI)

			insert into dbo.tUserItem(gameid,   listidx,      itemcode, cnt, farmnum, fieldidx,  upstepmax,  invenkind)
			values(					 @gameid_, @listidx + 3, 		 2,   1,       0,        3, @upstepmax2, @USERITEM_INVENKIND_ANI)

			--insert into dbo.tUserItem(gameid,   listidx,      itemcode, cnt, farmnum, fieldidx, invenkind)
			--values(				 @gameid_, @listidx + 4, 		 2,   1,       0,        4, @USERITEM_INVENKIND_ANI)

			--insert into dbo.tUserItem(gameid,   listidx,      itemcode, cnt, farmnum, fieldidx, invenkind)
			--values(				 @gameid_, @listidx + 5, 		 2,   1,       0,        5, @USERITEM_INVENKIND_ANI)

			------------------------------------------------
			-- �������� ȹ��ǥ��.(���� �Է��ҷ��� ���� ���ν��� ������)
			-- exec spu_DogamListLog @gameid_, 1
			------------------------------------------------
			insert into dbo.tDogamList(gameid, itemcode) values(@gameid_, 1)
			insert into dbo.tDogamList(gameid, itemcode) values(@gameid_, 2)

			------------------------------------------------
			-- ������ �� �������
			------------------------------------------------
			set @petlistidx	= @listidx + 6
			insert into dbo.tUserItem(gameid,   listidx,            itemcode, cnt, invenkind)
			values(					 @gameid_, @petlistidx,   @GAME_PET_BASE_ITEMCODE,    1, @USERITEM_INVENKIND_PET)

			insert into dbo.tDogamListPet(gameid, itemcode) values(@gameid_, @GAME_PET_BASE_ITEMCODE)

			------------------------------------------------
			-- ���	: x3
			-- �˹�		: x3
			-- ��Ȱ��	: x3
			------------------------------------------------
			--select 'DEBUG 6-5 ���������� > �Ҹ���(�Ѿ�x5, ġ����x5, �˹�x2, ������x2, ��Ȱ��x3)'
			set @bulletlistidx 	= @listidx + 7
			set @cnt			= 5
			insert into dbo.tUserItem(gameid,         listidx, itemcode, cnt, invenkind)							-- �Ѿ�x5
			values(					@gameid_, @bulletlistidx,      700, @cnt, @USERITEM_INVENKIND_CONSUME)

			set @vaccinelistidx 	= @listidx + 8
			set @cnt				= 5
			insert into dbo.tUserItem(gameid,          listidx, itemcode, cnt, invenkind)							-- ġ����x5
			values(					@gameid_, @vaccinelistidx,      800, @cnt, @USERITEM_INVENKIND_CONSUME)

			set @albalistidx 		= @listidx + 9
			set @cnt				= 5
			insert into dbo.tUserItem(gameid,       listidx, itemcode, cnt, invenkind)								-- �˹�x2
			values(					@gameid_, @albalistidx,     1002, @cnt, @USERITEM_INVENKIND_CONSUME)

			set @boosterlistidx 	= @listidx + 10
			set @cnt				= 5
			insert into dbo.tUserItem(gameid,          listidx, itemcode, cnt, invenkind)							-- ������x2
			values(					@gameid_, @boosterlistidx,     1100, @cnt, @USERITEM_INVENKIND_CONSUME)

			insert into dbo.tUserItem(gameid,      listidx, itemcode, cnt, invenkind)								-- ��Ȱ��x3
			values(					@gameid_, @listidx +11,     1200,   3, @USERITEM_INVENKIND_CONSUME)

			insert into dbo.tUserItem(gameid,      listidx, itemcode, cnt, invenkind)								-- �������x3
			values(					@gameid_, @listidx +14,     2100,   3, @USERITEM_INVENKIND_CONSUME)

			--insert into dbo.tUserItem(gameid,      listidx, itemcode, cnt, invenkind)								-- �����̾�����x1
			--values(					@gameid_, @listidx +15,     2300,   1, @USERITEM_INVENKIND_CONSUME)


			---------------------------------------------
			-- kakao �Է��ϱ�
			---------------------------------------------
			if(@kakaouserid = '')
				begin
					insert into dbo.tKakaoMaster(kakaotalkid,   kakaouserid,   gameid,   kakaodata)
					values(						@kakaotalkid_, @kakaouserid_, @gameid_, @kakaodata)
				end
			else
				begin
					update dbo.tKakaoMaster
						set
							gameid 	= @gameid_,
							cnt 	= cnt + 1
					where kakaouserid = @kakaouserid_
				end

			---------------------------------------------
			-- kakao �г����� ����̸� ���Ӿ��̵� �Է����ش�.
			---------------------------------------------
			--select 'DEBUG ', @kakaonickname_ kakaonickname_, @gameid_ gameid_
			if( @kakaonickname_ = '' )
				begin
					set @kakaonickname_ = @gameid_
				end

			---------------------------------------------
			-- ���� ���� �Է��ϱ�,
			-- ��ǥ����(0)
			-- ��Ʈ�ƽ� : 10
			---------------------------------------------
			--select 'DEBUG 6-3 ���� ���� �Է�'
			insert into dbo.tUserMaster(gameid, password, market, buytype, platform, ukey, version, phone, pushid,
										gamecost, cashcost, feed,
										petlistidx, petitemcode,
										blockstate,
										l1gameid,
										bulletlistidx, vaccinelistidx, boosterlistidx, albalistidx,
										anireplistidx,
										kakaotalkid,   kakaouserid,  kakaogameid, kakaonickname,   kakaoprofile,   kakaomsgblocked
										)
			values(@gameid_, @password_, @market_, @buytype_, @platform_, @ukey_, @version_, @phone_, @pushid_,
										@gamecost, @cashcost + @smsplusgbmy, @GAME_FEED_BASE,

										@petlistidx, @GAME_PET_BASE_ITEMCODE,
										@blockstate,
										@gameid_,
										@bulletlistidx, @vaccinelistidx, @boosterlistidx, @albalistidx,
										0,
										@kakaotalkid_, @kakaouserid_, @kakaogameid_, @kakaonickname_, @kakaoprofile_, @kakaomsgblocked_
										)

			------------------------------------------------
			-- ������1	: �վ��ֱ�.
			------------------------------------------------
			--select 'DEBUG 6-6 ���������� > ������(0:����, 11:�̱���)'
			insert into dbo.tUserSeed(gameid, seedidx, itemcode) values(@gameid_, 0, @USERSEED_NEED_EMPTY)
			set @loop = 1
			while(@loop < 12)
				begin
					insert into dbo.tUserSeed(gameid, seedidx, itemcode) values(@gameid_, @loop, @USERSEED_NEED_BUY)
					set @loop = @loop + 1
				end

			------------------------------------------------
			-- ����ģ���߱�(��ȣ �������·� ���۵ȴ�.)
			------------------------------------------------
			insert into dbo.tUserFriend(gameid,      friendid, state)
			values(                    @gameid_, @sysfriendid, @USERFRIEND_STATE_FRIEND)

			------------------------------------
			-- ���� ��踦 �ۼ��Ѵ�.(�Ϲ�, �Խ�Ʈ)
			------------------------------------
			--select 'DEBUG > 6-7 ���� ��踦 �ۼ��Ѵ�.'
			if(@joinmode = @JOIN_MODE_PLAYER)
				begin
					--select 'DEBUG > 6-7-2 ���̵��Է¹�� ����'
					exec spu_DayLogInfoStatic @market_, 10, 1
				end
			else
				begin
					--select 'DEBUG > 6-7-2 �Խ�Ʈ ����'
					exec spu_DayLogInfoStatic @market_, 13, 1
				end

			----------------------------------------------
			---- �ڵ����� ���� ī����
			----------------------------------------------
			if(@joincnt = 0)
				begin
					--select 'DEBUG > 6-8 �ڵ����� ���� ī����'
					exec spu_DayLogInfoStatic @market_, 11, 1

					insert into dbo.tUserPhone(phone, market, joincnt) values(@phone_, @market_, 1)

					----------------------------
					------ �̺�Ʈ
					----------------------------
					--exec spu_SubgiftsendNew @GIFTLIST_GIFT_KIND_GIFT, @EVENT07_REWARD_ITEM01, 1,  @EVENT07_REWARD_NAME, @gameid_, ''
					--exec spu_SubgiftsendNew @GIFTLIST_GIFT_KIND_GIFT, @EVENT07_REWARD_ITEM02, 100, @EVENT07_REWARD_NAME, @gameid_, ''
				end
			else
				begin
					update dbo.tUserPhone
						set
							joincnt = joincnt + 1
					where phone = @phone_
				end

			------------------------------------------------
			-- ���帮��Ʈ �߰�.
			-- ù���� ���޾��� > ������ ���� ������ �ȵ���.
			------------------------------------------------
			insert into dbo.tUserFarm(farmidx, gameid, itemcode)
			select rank() over(order by itemcode asc) as farmidx, @gameid_, itemcode from dbo.tItemInfo
			where subcategory = @ITEM_SUBCATEGORY_USERFARM order by itemcode asc

			----------------------------------------------
			-- kakao ģ�� ���� �˻��ؼ� �Է��ϱ�.
			----------------------------------------------
			exec sup_subAddKakaoFriend @gameid_, @kakaofriendlist_

		end

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	select @nResult_ rtn, @comment comment, @gameid_ gameid, @password_ password, @deldate waittime
	--, CONVERT(CHAR(19), @deldate, 20) deldate > ������ �޴� ������ ��� ������ ����. �Ф�

	--���� ����� �����Ѵ�.
	set nocount off
End



