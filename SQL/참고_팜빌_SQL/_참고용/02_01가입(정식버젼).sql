/*
select top 10 * from dbo.tFVUserMaster order by idx desc
exec spu_FVUserCreate 'farm',   '1052234j7g4k0l225439', 5, 0, 1, 'ukukukuk', 120, '01026403070', '', 'COk87e086Qg', '91386767984635713', 'oCBksPCjIXxc1BMNzZhMAw==', '', -1, '', -1


-- �Ϲݰ���
--select * from dbo.tFVKakaoMaster where gameid like 'xxxx%'
exec spu_FVUserCreate 'xxxx',   '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 101, '01011112221', '', 'kakaotalkidxxxx', 'kakaouseridxxxx', '', '', -1, '', -1
exec spu_FVUserCreate 'xxxx2',  '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 101, '01011112222', '', 'kakaotalkidxxxx2', 'kakaouseridxxxx2', '', '', -1, '', -1
exec spu_FVUserCreate 'xxxx3',  '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 101, '01011112222', '', 'kakaotalkidxxxx3', 'kakaouseridxxxx3', '', '', -1, '', -1
exec spu_FVUserCreate 'xxxx4',  '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 101, '01011112222', '', 'kakaotalkidxxxx4', 'kakaouseridxxxx4', '', '', -1, '', -1
exec spu_FVUserCreate 'xxxx5',  '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 101, '01011112222', '', 'kakaotalkidxxxx5', 'kakaouseridxxxx5', '', '', -1, '', -1
exec spu_FVUserCreate 'xxxx6',  '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 101, '01011112222', '', 'kakaotalkidxxxx6', 'kakaouseridxxxx6', '', '', -1, '', -1
exec spu_FVUserCreate 'xxxx7',  '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 101, '01011112222', '', 'kakaotalkidxxxx7', 'kakaouseridxxxx7', '', '', -1, '', -1
exec spu_FVUserCreate 'xxxx8',  '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 101, '01011112222', '', 'kakaotalkidxxxx8', 'kakaouseridxxxx8', '', '', -1, '', -1
exec spu_FVUserCreate 'xxxx9',  '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 101, '01011112222', '', 'kakaotalkidxxxx9', 'kakaouseridxxxx9', '', '', -1, '', -1
exec spu_FVUserCreate 'xxxx10',  '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 103, '01011112210', '', 'kakaotalkidxxxx10', 'kakaouseridxxxx10', '', '', -1, '', -1
exec spu_FVUserCreate 'xxxx11',  '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 103, '01011112211', '', 'kakaotalkidxxxx11', 'kakaouseridxxxx11', '', '', -1, '', -1
exec spu_FVUserCreate 'superman',  '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 101, '01011112221', '', 'kakaotalkidsuperman', 'kakaouseridsuperman', '', '', -1, '', -1
exec spu_FVUserCreate 'superman2', '049000s1i0n7t8445289', 2, 0, 1, 'ukukukuk', 101, '01011112221', '', 'kakaotalkidsuperman2', 'kakaouseridsuperman2', '', '', -1, '', -1
exec spu_FVUserCreate 'superman3', '049000s1i0n7t8445289', 3, 0, 1, 'ukukukuk', 101, '01011112221', '', 'kakaotalkidsuperman3', 'kakaouseridsuperman3', '', '', -1, '', -1
exec spu_FVUserCreate 'superman5', '049000s1i0n7t8445289', 5, 0, 1, 'ukukukuk', 101, '01011112221', '', 'kakaotalkidsuperman5', 'kakaouseridsuperman4', '', '', -1, '', -1
exec spu_FVUserCreate 'supermani', '049000s1i0n7t8445289', 7, 0, 2, 'ukukukuk', 101, '01011112221', '089c5cfc3ff57d1aca53be9df1d8d47c02601fb2820caef4b5a0db92909f292c', 'kakaotalkidiphone', '', '', '', -1, '', -1			-- ������ ������ ���� ����
exec spu_FVUserCreate 'superman12',  '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 101, '01011112222', '', 'kakaotalkidsuperman12', 'kakaouseridsuperman12', '', '', -1, '', -1

-- ó��(����), �ι�°(����)
exec spu_FVUserCreate 'guest',  '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 101, '01011112222', '', 'kakaotalkidnnnn2', '', '', '', -1, '0:x1;1:x2;2:x3;', -1

-- select * from dbo.tFVUserPay where phone in (select phone from dbo.tFVUserMaster where gameid = '')
-- select * from dbo.tFVUserBlockLog where gameid = ''
-- select * from dbo.tFVUserMaster where gameid = ''
-- select * from dbo.tFVUserItem where gameid = ''
-- select * from dbo.tFVUserSeed where gameid = ''
-- select top 10 * from dbo.tFVKakaoMaster order by idx desc

-- guest���� (������ 5���� �Է��ϱ� )
declare @var 			int
declare @loop			int				set @loop	= 1
declare @gameid 		varchar(60)		set @gameid = 'farm'	-- guest, farm, iuest
declare @phone 			varchar(20)
select @var = max(idx) + 1 from dbo.tFVUserMaster
set @loop = @var + @loop
while @var < @loop
	begin
		set @phone			= '010' + ltrim(@var)
		exec dbo.spu_FVUserCreate
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
							@gameid, 					-- kakaonickname
							'',							-- kakaoprofile
							-1,							-- kakaomsgblocked
							'0:000000000031;1:000000000033;',-- kakaofriendlist(kakaouserid)
							-1
		set @var = @var + 1
	end
-- ���� ������ ������ �ִ��� �׽�Ʈ
-- farm(ī�忡�� ����) -> iuest(�Խ�Ʈ�� ����) -> iuest(����) -> farm(����)
-- select kakaouserid, count(*) from dbo.tFVKakaoMaster group by kakaouserid order by 2 desc
-- select * from dbo.tFVKakaoMaster where kakaouserid = '88258263875124913' order by idx desc
-- delete from dbo.tFVKakaoMaster where idx in (9)
*/
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVUserCreate', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVUserCreate;
GO

create procedure dbo.spu_FVUserCreate
	@gameid_				varchar(60),						-- ���Ӿ��̵�
	@password_				varchar(20),						-- ��ȣȭ�ؼ�����, �����н����� ��ŷ���ص� ����
	@market_				int,								-- (����ó�ڵ�) MARKET_SKT
																--		MARKET_SKT		= 1
																--		MARKET_KT		= 2
																--		MARKET_LGT		= 3
																--		MARKET_GOOGLE	= 5
																--		MARKET_NHN		= 6
																--		MARKET_IPHONE	= 7
	@buytype_				int,								-- (����/�����ڵ�)
																--		���ᰡ�� : ������ �ּ� BUYTYPE_FREE		= 0
																--		���ᰡ�� : ������ ���� BUYTYPE_PAY		= 1
	@platform_				int,								-- (�÷���)
																--		PLATFORM_ANDROID	= 1
																--		PLATFORM_IPHONE		= 2
	@ukey_					varchar(256),						-- UKey
	@version_				int,								-- Ŭ�����
	@phone_					varchar(20),
	@pushid_				varchar(256),
	@kakaotalkid_			varchar(20),						-- ī������(�簡�Խ� �����).
	@kakaouserid_			varchar(20),						--          �簡�Խ� �̺���
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
	-- ����ó�ڵ�
	--declare @MARKET_SKT						int				set @MARKET_SKT							= 1
	--declare @MARKET_KT						int				set @MARKET_KT							= 2
	--declare @MARKET_LGT						int				set @MARKET_LGT							= 3
	--declare @MARKET_GOOGLE					int				set @MARKET_GOOGLE						= 5
	declare @MARKET_NHN							int				set @MARKET_NHN							= 6
	--declare @MARKET_IPHONE					int				set @MARKET_IPHONE						= 7

	-- (����/�����ڵ�)
	declare @BUYTYPE_FREE						int					set @BUYTYPE_FREE 					= 0	-- ���ᰡ�� : ������ �ּ�
	declare @BUYTYPE_PAY						int					set @BUYTYPE_PAY 					= 1	-- ���ᰡ�� : ������ ����
	declare @BUYTYPE_PAY2						int					set @BUYTYPE_PAY2 					= 2	-- ���ᰡ��(�簡��)

	-- (�÷���)
	--declare @PLATFORM_ANDROID 				int					set @PLATFORM_ANDROID				= 1
	--declare @PLATFORM_IPHONE 					int					set @PLATFORM_IPHONE				= 2

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
	declare @USERITEM_INVENKIND_ACC				int 				set @USERITEM_INVENKIND_ACC					= 4
	declare @USERITEM_INVENKIND_DIRECT			int 				set @USERITEM_INVENKIND_DIRECT				= 40
	declare @USERITEM_INVENKIND_INFO			int 				set @USERITEM_INVENKIND_INFO				= 60
	declare @USERITEM_INVENKIND_PET				int 				set @USERITEM_INVENKIND_PET					= 1000

	-- ������ ���
	declare @USERSEED_NEED_BUY					int					set @USERSEED_NEED_BUY						= -2
	declare @USERSEED_NEED_EMPTY				int					set @USERSEED_NEED_EMPTY					= -1
	-- >= 0 �̻��̸� Ư�� �Ĺ��� �ɾ�������.
	declare @GAME_START_YEAR					int					set @GAME_START_YEAR						= 2013
	declare @GAME_START_MONTH					int					set @GAME_START_MONTH						= 3
	declare @GAME_INVEN_ANIMAL_BASE				int					set @GAME_INVEN_ANIMAL_BASE					= 10	-- ��ǥ1 + ����9
	declare @GAME_INVEN_CUSTOME_BASE			int					set @GAME_INVEN_CUSTOME_BASE				= 8
	declare @GAME_INVEN_ACC_BASE				int					set @GAME_INVEN_ACC_BASE					= 6
	declare @GAME_INVEN_HOSPITAL_BASE			int					set @GAME_INVEN_HOSPITAL_BASE				= 10+9 	-- ��������(����10 + �ʵ�9).
	declare @GAME_COMPETITION_BASE				int					set @GAME_COMPETITION_BASE					= 90106	-- �����ȣ, -1�� ����.
	declare @GAME_FEED_BASE						int					set @GAME_FEED_BASE							= 15	-- ���� ���ʰ�.
	declare @GAME_PET_BASE_ITEMCODE				int					set @GAME_PET_BASE_ITEMCODE					= 100000-- ������.

	-- ������ �Һз�
	declare @ITEM_SUBCATEGORY_USERFARM			int					set @ITEM_SUBCATEGORY_USERFARM	 			= 69	-- ��������

	-- ��������.
	-- �ʵ嵿�� 0 ~ 8.
	declare @USERITEM_FIELDIDX_INVEN			int					set @USERITEM_FIELDIDX_INVEN					= -1	-- â��.
	declare @USERITEM_FIELDIDX_HOSPITAL			int					set @USERITEM_FIELDIDX_HOSPITAL					= -2	-- ����.

	-- ģ�����°�.
	declare @USERFRIEND_STATE_SEARCH			int					set	@USERFRIEND_STATE_SEARCH					=-1;		-- -1: �˻�.
	declare @USERFRIEND_STATE_PROPOSE_WAIT		int					set	@USERFRIEND_STATE_PROPOSE_WAIT				= 0;		-- 0 : ģ����û���
	declare @USERFRIEND_STATE_APPROVE_WAIT		int					set	@USERFRIEND_STATE_APPROVE_WAIT				= 1;		-- 1 : ģ���������
	declare @USERFRIEND_STATE_FRIEND			int					set	@USERFRIEND_STATE_FRIEND					= 2;		-- 2 : ��ȣģ��

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
	-- 10����(5009)�� ������ �����Ѵ�.
	----------------------------------------------
	--declare @EVENT01_START_DAY				datetime			set @EVENT01_START_DAY			= '2014-06-19 23:59'
	--declare @EVENT01_END_DAY					datetime			set @EVENT01_END_DAY			= '2014-06-19 23:59'
	--declare @EVENT01_REWARD_ITEM				int					set @EVENT01_REWARD_ITEM		= 5009		-- 10����
	--declare @EVENT01_REWARD_NAME				varchar(20)			set @EVENT01_REWARD_NAME		= 'ī�尡�Ա��'

	----------------------------------------------
	-- Naver �̺�Ʈ ó��
	--	�Ⱓ : 7.24 ~ 8.6
	--	��ǥ : 8.11
	--	1. ���Խ� ...		=> ��ũ�� ��1����, ���� 60��
	--						   02_01����(���Ĺ���).sql
	--	2. ���� 2��			=> �����ϸ� 2�� �̺�Ʈ
	--						   21_01ĳ��(������).sql
	--						   21_02ĳ��(����������).sql
	--	3. Naverĳ��		=> ���̹� ĳ��
	--	4. ������÷			=> ��÷�� ��ǥ �� 1���� �̳� ������ �Ϸ��ϸ� �˴ϴ�.
	--						  �����̾�Ƽ��(20��), ����20��
	--	5. �ʴ���÷			=> ��÷�� ��ǥ �� 1���� �̳� ������ �Ϸ��ϸ� �˴ϴ�.
	--						  �˹��� ������Ű��(20��), ��Ȱ�� 10��(����)
	------------------------------------------------
	--declare @EVENT07NHN_START_DAY				datetime			set @EVENT07NHN_START_DAY			= '2014-06-13 20:00'
	declare @EVENT07NHN_END_DAY					datetime			set @EVENT07NHN_END_DAY				= '2014-08-06 23:59'
	declare @EVENT07NHN_REWARD_ITEM01			int					set @EVENT07NHN_REWARD_ITEM01		= 111			-- ��ũ�� ���� ��
	declare @EVENT07NHN_REWARD_ITEM02			int					set @EVENT07NHN_REWARD_ITEM02		= 5014			--����60
	declare @EVENT07NHN_REWARD_NAME				varchar(20)			set @EVENT07NHN_REWARD_NAME			= '���̹�����'

	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @sysfriendid	varchar(60)		set @sysfriendid 	= 'farmgirl'
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
	declare	@kakaotalkid	varchar(20)		set @kakaotalkid	= ''
	declare	@kakaouserid	varchar(20)		set @kakaouserid	= ''
	declare	@kakaouserid2	varchar(20)		set @kakaouserid2	= ''
	declare @gameid			varchar(60)		set @gameid			= ''
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
	if(exists(select top 1 * from dbo.tFVUserBlockPhone where phone = @phone_))
		begin
			-- �������ΰ�?
			set @nResult_ 	= @RESULT_ERROR_BLOCK_USER
			set @comment 	= '��ó���� ���̵��Դϴ�.'
			--select 'DEBUG ', @comment
			select @nResult_ rtn, @comment comment, @gameid_ gameid, @password_ password
			return
		end



	------------------------------------------------
	--	3-2. �Խ�ƮID����
	------------------------------------------------
	if(@gameid_ in ('farm', 'guest', 'iuest'))
		begin
			--select 'DEBUG guest create'
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
			select @maxIdx = max(idx)+1 from dbo.tFVUserMaster
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
	--		delete from dbo.tFVKakaoMaster where kakaouserid = @kakaouserid_
    --
	--		-- 88452235362617025 > iuest583397699, farm161006288
	--		-- insert into dbo.tFVKakaoMaster(kakaotalkid,   kakaouserid,                 gameid,   kakaodata, writedate)
	--		-- values(						'A1QZxsYZVAM', '88452235362617025', 'farm161006288', 1, '2014-05-12 12:14')
	--		-- ī�� ������ ���� �Է�
	--		if(exists(select top 1 * from dbo.tFVKakaoMaster where gameid = @gameid_))
	--			begin
	--				--select 'DEBUG ����', @gameid_ gameid_, @kakaotalkid_ kakaotalkid_, @kakaouserid_ kakaouserid_, @kakaodata kakaodata
	--				update dbo.tFVKakaoMaster
	--					set
	--						kakaotalkid	= @kakaotalkid_,
	--						kakaouserid = @kakaouserid_,
	--						kakaodata	= @kakaodata
	--				where gameid = @gameid_
	--			end
	--		else
	--			begin
	--				--select 'DEBUG �Է�', @gameid_ gameid_, @kakaotalkid_ kakaotalkid_, @kakaouserid_ kakaouserid_, @kakaodata kakaodata
	--				insert into dbo.tFVKakaoMaster(kakaotalkid,   kakaouserid,   gameid,   kakaodata)
	--				values(						@kakaotalkid_, @kakaouserid_, @gameid_, @kakaodata)
	--			end
    --
	--		-- ���� ���� ����.
	--		update dbo.tFVUserMaster
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
			 select @kakaouserid2 = kakaouserid from dbo.tFVKakaoMaster where gameid = @gameid_
			 if(@kakaouserid_ != @kakaouserid2)
			 	begin
			 		-- ������ ������ ī����̵�� ����.
			 		delete from dbo.tFVKakaoMaster where kakaouserid = @kakaouserid2

					-- ī�� ������ ���� �Է�
					if(exists(select top 1 * from dbo.tFVKakaoMaster where kakaouserid = @kakaouserid_))
						begin
							update dbo.tFVKakaoMaster
								set
									kakaotalkid		= @kakaotalkid_,
									kakaodata		= @kakaodata,
									gameid 			= @gameid_
							where kakaouserid = @kakaouserid_
						end
					else
						begin
							--select 'DEBUG �Է�', @gameid_ gameid_, @kakaotalkid_ kakaotalkid_, @kakaouserid_ kakaouserid_, @kakaodata kakaodata
							insert into dbo.tFVKakaoMaster(kakaotalkid,   kakaouserid,   gameid,   kakaodata)
							values(						@kakaotalkid_, @kakaouserid_, @gameid_, @kakaodata)
						end

					-- ���� ���� ����.
					update dbo.tFVUserMaster
						set
							kakaotalkid		= @kakaotalkid_,
							kakaouserid		= @kakaouserid_,
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
	from dbo.tFVKakaoMaster
	where kakaouserid = @kakaouserid_
	order by idx desc
	--select 'DEBUG 3-2-5', @kakaouserid_ kakaouserid_, @kakaotalkid kakaotalkid, @kakaouserid kakaouserid, @gameid gameid

	------------------------------------------------
	--	3-3. ��������.
	------------------------------------------------
	if (@gameid != '' and exists(select top 1 * from dbo.tFVUserMaster where gameid = @gameid))
		begin
			set @nResult_ = @RESULT_SUCCESS
			set @comment = '(�翬��)������ �����մϴ�.'
			--select 'DEBUG 3', @comment
			if(@kakaotalkid != @kakaotalkid_)
				begin
					--select 'DEBUG 3 kakaotalkid �Է�, ���尪�� Ʋ���� ����', @kakaotalkid kakaotalkid, @kakaotalkid_ kakaotalkid_
					-- �簻�ŵɶ��� �ִ�.
					update dbo.tFVKakaoMaster
						set
							kakaotalkid 	= @kakaotalkid_,
							cnt2			= cnt2 + 1
					where idx = @idx
				end

			-- �г��Ӱ� ���������� �����ϴ�.
			update dbo.tFVUserMaster
				set
					kakaoprofile	= @kakaoprofile_,
					kakaonickname 	= @kakaonickname_,
					--market		= @market_,				-- �α����Ҷ� �����Ѵ�.
					pushid			= @pushid_
			where gameid = @gameid

			select @nResult_ rtn, @comment comment, gameid, password
			from dbo.tFVUserMaster
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
			-- ���� : ĳ��(6),  ���ӸӴ�(400), ����(5)
			-- ���� : ĳ��(60), ���ӸӴ�(100), ����(5)
			-- Ʃ�� : 4���� + 150���� + 2 ĳ�� �ϲ� + 2ĳ�� ġ����
			-------------------------------------------
			set @cashcost		= 6
			set @gamecost		= 100 + 300

			if(@buytype_ = @BUYTYPE_PAY)
				begin
					if(not exists(select top 1 * from dbo.tFVUserPay where phone = @phone_ and market = @market_))
						begin
							-- ���� > �ѹ��� ���޾���(�α� ���)
							set @cashcost		= 60
							set @gamecost		= 100

							insert into dbo.tFVUserPay(phone, market) values(@phone_, @market_)
						end
					else
						begin
							------------------------------------
							-- ���� > �ι����޽� ����� ����
							------------------------------------
							set @buytype_ = @BUYTYPE_PAY2
						end
				end
			--select 'DEBUG 6-1. �ʱ� ����', @buytype_ buytype_, @cashcost cashcost, @gamecost gamecost

			-------------------------------------------
			-- 2. ���� > ���Ժ�ó��
			-------------------------------------------
			--select 'DEBUG 6-2. �������� �˻�'
			if(exists(select top 1 * from dbo.tFVUserBlockPhone where phone = @phone_))
				begin
					--select 'DEBUG > 6-2-2 @@@@�� �ڵ���@@@@'
					--�������� ī��ó��.
					set @blockstate = @BLOCK_STATE_YES

					-- �������� ���Ժ��� ������ ó���Ѵ�.
					insert into dbo.tFVUserBlockLog(gameid, comment)
					values(@gameid_, '�� ������ �����ҷ��� �ؼ� ���Ժ��� ��ó����.')
				end
			else
				begin
					--select 'DEBUG > 6-2-3 NON��'
					set @blockstate = @BLOCK_STATE_NO
				end

			-----------------------------------------------
			----	3. ��õ���� �����ϱ�(��õ��, ������)
			-----------------------------------------------
			-- --select 'DEBUG 3. ��õ���� �����ϱ�(��õ��, ������)', '������:' + ltrim(@phone_)
			--select top 1 @smsgameid = gameid from dbo.tFVUserSMSLog
			--where recphone = @phone_
			--order by idx asc
            --
			-- --select 'DEBUG ��õ��', @smsgameid
			--if(isnull(@smsgameid, '') != '')
			--	begin
			--		--select 'DEBUG 1�ܰ� ��õSMS�α׿� ������'
			--		if(not exists(select top 1 * from dbo.tFVUserSMSReward where recphone = @phone_))
			--			begin
			--				-- select 'DEBUG 2�ܰ� ����SMS�α׿� ������� > Reward�����ϱ�'
			--				---------------------------------------------
			--				--		��õ�� :  ĳ��(5)
			--				---------------------------------------------
			--				set @smsplusgbrec	= 5
			--				set @commentrec		= ltrim(rtrim(@phone_)) + '�� ��õ�� �����ؼ� �������� 5ĳ��(500��)'
            --
			--				----------------------------------------------
			--				-- 1-2-1. ��õ�� �����ϱ�
			--				----------------------------------------------
			--				-- select 'DEBUG > SMS > ��õ�� �����ϱ�'
			--				update dbo.tFVUserMaster
			--					set
			--						cashcost	= cashcost 		+ @smsplusgbrec,
			--						smsjoincnt	= smsjoincnt 	+ 1
			--				where gameid = @smsgameid
            --
			--				exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT, -1, 'SysLogin', @smsgameid, @commentrec
			--				---------------------------------------------
			--				--	1-2-2. ������ �����ϱ�(X)
			--				---------------------------------------------
            --
			--				---------------------------------------------
			--				--	1-3. ����ϱ�
			--				---------------------------------------------
			--				-- select 'DEBUG > SMS > ������ ����ϱ�'
			--				insert into dbo.tFVUserSMSReward(recphone, gameid)
			--				values(@phone_, @smsgameid)
            --
			--				---------------------------------------------------
			--				-- ��Ż ����ϱ�
			--				---------------------------------------------------
			--				-- select 'DEBUG > SMSJOIN > ������ν������'
			--				exec spu_FVDayLogInfoStatic @market_, 2, 1
			--			end
			--	end
			--select 'DEBUG > SMS > ��õ', @smsgameid from dbo.tFVUserMaster where gameid = @smsgameid

			------------------------------------------------
			-- �� 7���� : (��ǥ�� 1 + �Ϲݼ�6)
			------------------------------------------------
			--select 'DEBUG 6-4 ���������� > �����Է�'
			set @listidx		= 0
			set @itemcode		= 1

			insert into dbo.tFVUserItem(gameid,   listidx,      itemcode, cnt, farmnum, fieldidx, invenkind)					-- ��ǥ����.
			values(					 @gameid_, @listidx + 0, 		 1,   1,       0,        0, @USERITEM_INVENKIND_ANI)	--	E��� ��

			insert into dbo.tFVUserItem(gameid,   listidx,      itemcode, cnt, farmnum, fieldidx, invenkind)
			values(					 @gameid_, @listidx + 1, 		 1,   1,       0,        1, @USERITEM_INVENKIND_ANI)

			insert into dbo.tFVUserItem(gameid,   listidx,      itemcode, cnt, farmnum, fieldidx, invenkind)
			values(					 @gameid_, @listidx + 2, 		 1,   1,       0,        2, @USERITEM_INVENKIND_ANI)

			insert into dbo.tFVUserItem(gameid,   listidx,      itemcode, cnt, farmnum, fieldidx, invenkind)
			values(					 @gameid_, @listidx + 3, 		 2,   1,       0,        3, @USERITEM_INVENKIND_ANI)

			--insert into dbo.tFVUserItem(gameid,   listidx,      itemcode, cnt, farmnum, fieldidx, invenkind)
			--values(					 @gameid_, @listidx + 4, 		 2,   1,       0,        4, @USERITEM_INVENKIND_ANI)

			--insert into dbo.tFVUserItem(gameid,   listidx,      itemcode, cnt, farmnum, fieldidx, invenkind)
			--values(					 @gameid_, @listidx + 5, 		 2,   1,       0,        5, @USERITEM_INVENKIND_ANI)

			------------------------------------------------
			-- �������� ȹ��ǥ��.(���� �Է��ҷ��� ���� ���ν��� ������)
			-- exec spu_FVDogamListLog @gameid_, 1
			------------------------------------------------
			insert into dbo.tFVDogamList(gameid, itemcode) values(@gameid_, 1)
			insert into dbo.tFVDogamList(gameid, itemcode) values(@gameid_, 2)
			--insert into dbo.tFVDogamList(gameid, itemcode) values(@gameid_, 3) --���޾���.


			------------------------------------------------
			-- ������ �� �������
			------------------------------------------------
			set @petlistidx	= @listidx + 6
			insert into dbo.tFVUserItem(gameid,   listidx,            itemcode, cnt, invenkind)
			values(					 @gameid_, @petlistidx,   @GAME_PET_BASE_ITEMCODE,    1, @USERITEM_INVENKIND_PET)

			insert into dbo.tFVDogamListPet(gameid, itemcode) values(@gameid_, @GAME_PET_BASE_ITEMCODE)

			------------------------------------------------
			-- ġ����	: x3
			-- �˹�		: x3
			-- ��Ȱ��	: x3
			------------------------------------------------
			--select 'DEBUG 6-5 ���������� > �Ҹ���(�Ѿ�x5, ġ����x5, �˹�x2, ������x2, ��Ȱ��x3)'
			set @bulletlistidx 	= @listidx + 7
			set @cnt			= 5
			insert into dbo.tFVUserItem(gameid,         listidx, itemcode, cnt, invenkind)							-- �Ѿ�x5
			values(					@gameid_, @bulletlistidx,      700, @cnt, @USERITEM_INVENKIND_CONSUME)

			set @vaccinelistidx 	= @listidx + 8
			set @cnt				= 5
			insert into dbo.tFVUserItem(gameid,          listidx, itemcode, cnt, invenkind)							-- ġ����x5
			values(					@gameid_, @vaccinelistidx,      800, @cnt, @USERITEM_INVENKIND_CONSUME)

			set @albalistidx 		= @listidx + 9
			set @cnt				= 5
			insert into dbo.tFVUserItem(gameid,       listidx, itemcode, cnt, invenkind)								-- �˹�x2
			values(					@gameid_, @albalistidx,     1002, @cnt, @USERITEM_INVENKIND_CONSUME)

			set @boosterlistidx 	= @listidx + 10
			set @cnt				= 5
			insert into dbo.tFVUserItem(gameid,          listidx, itemcode, cnt, invenkind)							-- ������x2
			values(					@gameid_, @boosterlistidx,     1100, @cnt, @USERITEM_INVENKIND_CONSUME)

			insert into dbo.tFVUserItem(gameid,      listidx, itemcode, cnt, invenkind)								-- ��Ȱ��x3
			values(					@gameid_, @listidx +11,     1200,   3, @USERITEM_INVENKIND_CONSUME)

			insert into dbo.tFVUserItem(gameid,      listidx, itemcode, cnt, invenkind)								-- (�Ǽ�)���Ƹ�����.
			values(					@gameid_, @listidx +12,     1400,   1, @USERITEM_INVENKIND_ACC)

			insert into dbo.tFVUserItem(gameid,      listidx, itemcode, cnt, invenkind)								-- (�Ǽ�)��������
			values(					@gameid_, @listidx +13,     1404,   1, @USERITEM_INVENKIND_ACC)

			insert into dbo.tFVUserItem(gameid,      listidx, itemcode, cnt, invenkind)								-- �������x3
			values(					@gameid_, @listidx +14,     2100,   3, @USERITEM_INVENKIND_CONSUME)

			--insert into dbo.tFVUserItem(gameid,      listidx, itemcode, cnt, invenkind)								-- �����̾�����x1
			--values(					@gameid_, @listidx +15,     2300,   1, @USERITEM_INVENKIND_CONSUME)


			---------------------------------------------
			-- kakao �Է��ϱ�
			---------------------------------------------
			if(@kakaouserid = '')
				begin
					insert into dbo.tFVKakaoMaster(kakaotalkid,   kakaouserid,   gameid,   kakaodata)
					values(						@kakaotalkid_, @kakaouserid_, @gameid_, @kakaodata)
				end
			else
				begin
					update dbo.tFVKakaoMaster
						set
							gameid 	= @gameid_,
							cnt 	= cnt + 1
					where kakaouserid = @kakaouserid_
				end

			---------------------------------------------
			-- ���� ���� �Է��ϱ�,
			-- ��ǥ����(0)
			-- ��Ʈ�ƽ� : 10
			---------------------------------------------
			--select 'DEBUG 6-3 ���� ���� �Է�'
			insert into dbo.tFVUserMaster(gameid, password, market, buytype, platform, ukey, version, phone, pushid,
										gamecost, cashcost, feed,
										gameyear, gamemonth,
										petlistidx, petitemcode,
										invenanimalmax, invencustommax, invenaccmax,
										blockstate,
										l1gameid,
										bulletlistidx, vaccinelistidx, boosterlistidx, albalistidx,
										anireplistidx,
										kakaotalkid,   kakaouserid,   kakaonickname,   kakaoprofile,   kakaomsgblocked
										)
			values(@gameid_, @password_, @market_, @buytype_, @platform_, @ukey_, @version_, @phone_, @pushid_,
										@gamecost, @cashcost + @smsplusgbmy, @GAME_FEED_BASE,
										@GAME_START_YEAR, @GAME_START_MONTH,

										@petlistidx, @GAME_PET_BASE_ITEMCODE,
										@GAME_INVEN_ANIMAL_BASE, @GAME_INVEN_CUSTOME_BASE, @GAME_INVEN_ACC_BASE,
										@blockstate,
										@gameid_,
										@bulletlistidx, @vaccinelistidx, @boosterlistidx, @albalistidx,
										0,
										@kakaotalkid_, @kakaouserid_, @kakaonickname_, @kakaoprofile_, @kakaomsgblocked_
										)

			------------------------------------------------
			-- ������1	: �վ��ֱ�.
			------------------------------------------------
			--select 'DEBUG 6-6 ���������� > ������(0:����, 11:�̱���)'
			insert into dbo.tFVUserSeed(gameid, seedidx, itemcode) values(@gameid_, 0, @USERSEED_NEED_EMPTY)
			set @loop = 1
			while(@loop < 12)
				begin
					insert into dbo.tFVUserSeed(gameid, seedidx, itemcode) values(@gameid_, @loop, @USERSEED_NEED_BUY)
					set @loop = @loop + 1
				end

			------------------------------------------------
			-- ����ģ���߱�(��ȣ �������·� ���۵ȴ�.)
			------------------------------------------------
			insert into dbo.tFVUserFriend(gameid,      friendid, state)
			values(                    @gameid_, @sysfriendid, @USERFRIEND_STATE_FRIEND)

			------------------------------------
			-- ���� ��踦 �ۼ��Ѵ�.(�Ϲ�, �Խ�Ʈ)
			------------------------------------
			--select 'DEBUG > 6-7 ���� ��踦 �ۼ��Ѵ�.'
			if(@joinmode = @JOIN_MODE_PLAYER)
				begin
					--select 'DEBUG > 6-7-2 ���̵��Է¹�� ����'
					exec spu_FVDayLogInfoStatic @market_, 10, 1
				end
			else
				begin
					--select 'DEBUG > 6-7-2 �Խ�Ʈ ����'
					exec spu_FVDayLogInfoStatic @market_, 13, 1
				end

			----------------------------------------------
			---- �ڵ����� ���� ī����
			----------------------------------------------
			if(@joincnt = 0)
				begin
					--select 'DEBUG > 6-8 �ڵ����� ���� ī����'
					exec spu_FVDayLogInfoStatic @market_, 11, 1

					insert into dbo.tFVUserPhone(phone, market, joincnt) values(@phone_, @market_, 1)

					--------------------------
					---- �̺�Ʈ
					--------------------------
					if(@market_ = @MARKET_NHN and getdate() < @EVENT07NHN_END_DAY)
						begin
							exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT, @EVENT07NHN_REWARD_ITEM01, @EVENT07NHN_REWARD_NAME, @gameid_, ''
							exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT, @EVENT07NHN_REWARD_ITEM02, @EVENT07NHN_REWARD_NAME, @gameid_, ''
						end
				end
			else
				begin
					update dbo.tFVUserPhone
						set
							joincnt = joincnt + 1
					where phone = @phone_
				end

			------------------------------------------------
			-- ���帮��Ʈ �߰�.
			-- ù��° ������ ������.
			------------------------------------------------
			insert into dbo.tFVUserFarm(farmidx, gameid, itemcode)
			select rank() over(order by itemcode asc) as farmidx, @gameid_, itemcode from dbo.tFVItemInfo
			where subcategory = @ITEM_SUBCATEGORY_USERFARM order by itemcode asc

			-- ù���� ���޾���.
			--update dbo.tFVUserFarm
			--	set
			--		buystate	= @USERFARM_BUYSTATE_BUY,
			--		buydate		= getdate(),
			--		incomedate	= getdate()
			--where gameid = @gameid_ and itemcode = @USERFARM_INIT_ITEMCODE

			----------------------------------------------
			-- kakao ģ�� ���� �˻��ؼ� �Է��ϱ�.
			----------------------------------------------
			exec spu_FVsubAddKakaoFriend @gameid_, @kakaofriendlist_

		end

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	select @nResult_ rtn, @comment comment, @gameid_ gameid, @password_ password
	--, CONVERT(CHAR(19), @deldate, 20) deldate > ������ �޴� ������ ��� ������ ����. �Ф�

	--���� ����� �����Ѵ�.
	set nocount off
End



