/*
-- �Ϲݰ���
select * from dbo.tFVKakaoMaster where gameid like 'xxxx%'
select * from dbo.tUserMaster where kakaouserid like 'kakaouserid%'
exec spu_FVUserCreate 'xxxx',   '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 101, '01011112221', '', 'kakaotalkidxxxx', 'kakaouseridxxxx', -1, '', -1
exec spu_FVUserCreate 'xxxx@gmail.com',  '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 101, '01011112222', '', 'kakaotalkidxxxx2', 'kakaouseridxxxx2', -1, '', -1
exec spu_FVUserCreate 'xxxx3',  '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 101, '01011112222', '', 'kakaotalkidxxxx3', 'kakaouseridxxxx3', -1, '', -1
exec spu_FVUserCreate 'xxxx4',  '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 101, '01011112222', '', 'kakaotalkidxxxx4', 'kakaouseridxxxx4', -1, '', -1
exec spu_FVUserCreate 'xxxx5',  '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 101, '01011112222', '', 'kakaotalkidxxxx5', 'kakaouseridxxxx5', -1, '', -1
exec spu_FVUserCreate 'xxxx6',  '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 101, '01011112222', '', 'kakaotalkidxxxx6', 'kakaouseridxxxx6', -1, '', -1
exec spu_FVUserCreate 'xxxx7',  '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 101, '01011112222', '', 'kakaotalkidxxxx7', 'kakaouseridxxxx7', -1, '', -1
exec spu_FVUserCreate 'xxxx8',  '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 101, '01011112222', '', 'kakaotalkidxxxx8', 'kakaouseridxxxx8', -1, '', -1
exec spu_FVUserCreate 'xxxx9',  '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 101, '01011112222', '', 'kakaotalkidxxxx9', 'kakaouseridxxxx9', -1, '', -1

-- ó��(����), �ι�°(����)
exec spu_FVUserCreate 'farm',  '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 101, '01011112222', '', 'kakaotalkidnnnn2', '', -1, '0:x1;1:x2;2:x3;', -1

-- select * from dbo.tUserMaster where gameid = ''
-- select top 10 * from dbo.tFVKakaoMaster order by idx desc

-- guest���� (������ 5���� �Է��ϱ� )
declare @var 			int
declare @loop			int				set @loop	= 1
declare @gameid 		varchar(20)		set @gameid = 'farm'	-- farm, iuest
declare @phone 			varchar(20)
select @var = max(idx) + 1 from dbo.tUserMaster
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
	@market_				int,
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
	@kakaotalkid_			varchar(60),						-- ī������(�簡�Խ� �����).
	@kakaouserid_			varchar(60),						--          �簡�Խ� �̺���
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
	--declare @MARKET_NHN						int				set @MARKET_NHN							= 6
	--declare @MARKET_IPHONE					int				set @MARKET_IPHONE						= 7

	declare @ID_MAX								int				set	@ID_MAX								= 99999 -- ������ ������ �� �ִ� ���̵𰳼�

	-- �Ϲݰ���, �Խ�Ʈ ����
	declare @JOIN_MODE_GUEST					int				set @JOIN_MODE_GUEST				= 1
	declare @JOIN_MODE_PLAYER					int				set @JOIN_MODE_PLAYER				= 2

	declare @KAKAO_DATA_YES						int				set @KAKAO_DATA_YES = 1
	declare @KAKAO_DATA_NO						int				set @KAKAO_DATA_NO = -1

	-- ���� ���ǰ�
	--declare @GIFTLIST_GIFT_KIND_MESSAGE		int				set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int				set @GIFTLIST_GIFT_KIND_GIFT				= 2

	------------------------------------------------
	--	2-1. ���λ�� ����
	------------------------------------------------
	declare @comment		varchar(80)
	declare @joincnt		int				set @joincnt		= 0
	declare @joinmode		int				set @joinmode 		= @JOIN_MODE_PLAYER

	-- Kakao
	declare	@kakaotalkid	varchar(60)		set @kakaotalkid	= ''
	declare	@kakaouserid	varchar(60)		set @kakaouserid	= ''
	declare	@kakaouserid2	varchar(60)		set @kakaouserid2	= ''
	declare @gameid			varchar(60)		set @gameid			= ''
	declare @strkind		varchar(60)		set @strkind 		= @gameid_
	declare @kakaodata		int				set @kakaodata 		= @KAKAO_DATA_YES
	declare @idx			int				set @idx			= -1

	declare @deldate		datetime		set @deldate		= getdate() - 1
Begin
	------------------------------------------------
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG ', @gameid_ gameid_, @password_ password_, @market_ market_, @buytype_ buytype_, @platform_ platform_, @ukey_ ukey_, @version_ version_, @phone_ phone_, @pushid_ pushid_, @kakaotalkid_ kakaotalkid_, @kakaouserid_ kakaouserid_, @kakaomsgblocked_ kakaomsgblocked_, @kakaofriendlist_ kakaofriendlist_

	if(exists(select top 1 * from dbo.tFVUserBlockPhone where phone = @phone_))
		begin
			-- �������ΰ�?
			set @nResult_ 	= @RESULT_ERROR_BLOCK_USER
			set @comment 	= '��ó���� ���̵��Դϴ�.'
			select @nResult_ rtn, @comment comment, @gameid_ gameid, @password_ password
			return
		end



	------------------------------------------------
	--	3-2. �Խ�ƮID����
	------------------------------------------------
	if(@gameid_ in ('farm', 'iuest'))
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
	--		update dbo.tUserMaster
	--			set
	--				kakaotalkid		= @kakaotalkid_,
	--				kakaouserid		= @kakaouserid_,
	--				kakaomsgblocked	= @kakaomsgblocked_
	--		where gameid = @gameid_
	--	end
	else if(@kakaouserid_ != '' and @gameid_ != '')
		begin
			select @kakaouserid2 = kakaouserid from dbo.tFVKakaoMaster where gameid = @gameid_
			--select 'DEBUG ��������', @kakaouserid_ kakaouserid_, @gameid_ gameid_, @kakaouserid2 kakaouserid2
			if(@kakaouserid_ != @kakaouserid2)
			 	begin
			 		-- ������ ������ ī����̵�� ����.
			 		delete from dbo.tFVKakaoMaster where kakaouserid = @kakaouserid2
			 		--select 'DEBUG kakao master �����ϰ� �����'

					-- ī�� ������ ���� �Է�
					if(exists(select top 1 * from dbo.tFVKakaoMaster where kakaouserid = @kakaouserid_))
						begin
							--select 'DEBUG update(tFVKakaoMaster)', @gameid_ gameid_, @kakaotalkid_ kakaotalkid_, @kakaouserid_ kakaouserid_, @kakaodata kakaodata
							update dbo.tFVKakaoMaster
								set
									kakaotalkid		= @kakaotalkid_,
									kakaodata		= @kakaodata,
									gameid 			= @gameid_
							where kakaouserid = @kakaouserid_
						end
					else
						begin
							--select 'DEBUG insert(tFVKakaoMaster)', @gameid_ gameid_, @kakaotalkid_ kakaotalkid_, @kakaouserid_ kakaouserid_, @kakaodata kakaodata
							insert into dbo.tFVKakaoMaster(kakaotalkid,   kakaouserid,   gameid,   kakaodata)
							values(						  @kakaotalkid_, @kakaouserid_, @gameid_, @kakaodata)
						end

					-- ���� ���� ����.
					update dbo.tUserMaster
						set
							kakaotalkid		= @kakaotalkid_,
							kakaouserid		= @kakaouserid_,
							kakaomsgblocked	= @kakaomsgblocked_
					where gameid = @gameid_
				end
		end

	--select 'DEBUG 3-2-3', @gameid_ gameid_, @password_ password_, @market_ market_, @buytype_ buytype_, @platform_ platform_, @ukey_ ukey_, @version_ version_, @phone_ phone_, @pushid_ pushid_
	if(@strkind in ('iuest'))
		begin
			set @kakaodata			= @KAKAO_DATA_NO
		end

	------------------------------------------------
	-- �ڵ������� ������ ���̵�� ���� �ľ�
	------------------------------------------------
	select
		@joincnt = joincnt
	from tFVUserPhone where phone = @phone_
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
	if (@gameid != '' and exists(select top 1 * from dbo.tUserMaster where gameid = @gameid))
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
			update dbo.tUserMaster
				set
					--market		= @market_,				-- �α����Ҷ� �����Ѵ�.
					pushid			= @pushid_
			where gameid = @gameid

			select @nResult_ rtn, @comment comment, gameid, password
			from dbo.tUserMaster
			where gameid = @gameid

			return
		end
	--else if exists (select * from tUserMaster where gameid = @gameid_)
	--	begin
	--		set @nResult_ = @RESULT_ERROR_ID_DUPLICATE
	--		set @comment = '(����)���̵� �ߺ��Ǿ����ϴ�.'
	--		--select 'DEBUG 4', @comment
	--	end
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

			---------------------------------------------
			-- kakao �Է��ϱ�
			---------------------------------------------
			if(@kakaouserid = '')
				begin
					insert into dbo.tFVKakaoMaster(kakaotalkid,   kakaouserid,   gameid,   kakaodata)
					values(					 	  @kakaotalkid_, @kakaouserid_, @gameid_, @kakaodata)
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
			insert into dbo.tUserMaster(gameid,  password,   market,   buytype,   platform,   ukey,   version,   phone,   pushid,
										 kakaotalkid,   kakaouserid,   kakaomsgblocked,   nickname
										)
			values(                     @gameid_, @password_, @market_, @buytype_, @platform_, @ukey_, @version_, @phone_, @pushid_,
										@kakaotalkid_, @kakaouserid_, @kakaomsgblocked_, @gameid_
										)

			---------------------------------------------
			-- ���Լ���.
			-- ��Ʈ(3300) 	50
			-- ������(3003)	200
			-- �ٳ���(3004)	200
			-- ����(3400)	250
			---------------------------------------------
			exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT, 3300, 50, '�ű԰���', @gameid_, ''
			exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT, 3003, 100, '�ű԰���', @gameid_, ''
			exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT, 3004, 100, '�ű԰���', @gameid_, ''
			exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT, 3400, 150, '�ű԰���', @gameid_, ''


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

					insert into dbo.tFVUserPhone(phone,   market)
					values(                     @phone_, @market_)
				end
			else
				begin
					update dbo.tFVUserPhone
						set
							joincnt = joincnt + 1
					where phone = @phone_
				end

			----------------------------------------------
			-- kakao ģ�� ���� �˻��ؼ� �Է��ϱ�.
			----------------------------------------------
			exec sup_FVsubAddKakaoFriend @gameid_, @kakaofriendlist_

		end

	------------------------------------------------
	--	3-3. �������
	------------------------------------------------
	select @nResult_ rtn, @comment comment, @gameid_ gameid, @password_ password
	--, CONVERT(CHAR(19), @deldate, 20) deldate > ������ �޴� ������ ��� ������ ����. �Ф�

	--���� ����� �����Ѵ�.
	set nocount off
End



